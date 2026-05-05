Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF54CD13DA
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 07:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A2F10E9A6;
	Tue,  5 May 2026 07:27:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="bW5pl293";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C8F10E9A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 07:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1777966044; bh=aPM8FIPX/Ek4afWE0qf7JWcZcG9Rbm8ImXvi7Vn3GMk=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=bW5pl293qkbTo2qmqA/N/9PuE1gimRfYvrSfjzMogpn+g+t+ZV8IH0Pc5nxu15q8h
 cExK5SASx8azAm6q4czc2LsT3sThcYR5E7yhlKgxs0B4kn9dOasQoURdMwYfInS5u/
 G1XrIJvvPqOfhlmzqefbbPdv4hQITM1e7xpP7slGM1M7V17rK3sBPfR/Faajub1C3+
 C877ClbjzDlvHi4ZBguH83ZCs/aZkO+LStXh2PI44wvOTxL6RdcF6fYaYQ42e2t4NA
 pVvryeCRIrar/9DcAiQDEc9uXHEllSE8eoIdJvfTaTi9vhhSvcHduDtoj3cQfVwUOe
 cWQzWOIG6tU1A==
Message-ID: <e4f72783-6086-4e7e-9de6-273ffbe743e7@m1k.cloud>
Date: Tue, 5 May 2026 09:27:22 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, siqueira@igalia.com,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Shengyu Qu <wiagn233@outlook.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
 <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
 <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
 <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
 <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
 <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
 <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
 <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
 <fe88c29c-3fc3-48b5-b6a2-ee4c210e7a83@m1k.cloud>
 <e415c38b-4102-40e4-a195-0256caf34802@m1k.cloud>
 <9c37520f-ad9a-4fac-bd21-e92f2107ca36@amd.com>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <9c37520f-ad9a-4fac-bd21-e92f2107ca36@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/4/26 20:48, Leo Li wrote:
> 
> Hi Michel, Shengyu,
> 
> I sent out a potential fix here: https://lore.kernel.org/amd-gfx/20260504183649.165131-1-sunpeng.li@amd.com/T/#u
> If you get a chance, can you give it a spin and let me know the results(*)? The issue remains elusive on my end.
> 
> (*) Of course, make sure the Restore 5s vbl offdelay change is not applied, and that no other debug patch/kernel cmdline are applied.
> 
> Thanks,
> Leo
> 

Hi Leo,
building it right now, will let you know how it goes.

Michele
