Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD4ACD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 07:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823F110E039;
	Fri,  8 May 2026 07:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="B1GN6IFS";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B81910E039
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 07:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1778225866; bh=9Ctq2kuewybLJNFAfczCjB9enP/mw2D4p0PvffiFKOk=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=B1GN6IFSyfXS2fqtIoOyRO7IvQS47eye7VL9BKmmnB/nTDUuIPdksK5RwDS/S4im1
 u49gPiPyj7BI7GaJaZehSsfWC3MxwXA9XZCG2RBYGuk4Fgq1GlzeTWvyY/8lTFCt6V
 OEiXqQZwmyiKwqQoHJcl9XJuU5rGejwRqoSJmw7p4mUBlF3VZ7MYQthI1RjM6LuTZs
 PLtBw/yo+08P1zPUAAvrF9BnXAtcTQFhSAVFMnaus5U8PexISVv65zn7rO61UHCjvG
 h0zBPRXs6zAT/ozeDfH6cohj8RqqC002Vce8Jh47YAzxu96r7zo6vXqxRb9yMLmaEk
 GzDs9EH/2MmCA==
Message-ID: <efa5a347-b4ef-4081-966f-ffbd61cbfc12@m1k.cloud>
Date: Fri, 8 May 2026 09:37:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, siqueira@igalia.com,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Shengyu Qu <wiagn233@outlook.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
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
 <e4f72783-6086-4e7e-9de6-273ffbe743e7@m1k.cloud>
 <184d937f-31dc-4d38-890d-e7d93d0efd60@amd.com>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <184d937f-31dc-4d38-890d-e7d93d0efd60@amd.com>
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

On 5/7/26 22:19, Leo Li wrote:
> 
> In the event that you do hit the timeout again, would you give this branch a spin?
> https://gitlab.freedesktop.org/leoli/linux-asdn/-/commits/lileo/flip_done_timeout
> 
> It contains this patch, plus some additional debug dumps on timeouts/dmub hangs.
> In the event you hit the timeout with this branch, please post the full dmesg.
> 
> Thanks,
> Leo
> 

ok will do.

fwiw, running v7.0.3 + your vline2 patch alone (no 5s offdelay
restore on top) since building it and no flip-done
timeouts so far, but from past experience it's too early to call.

Michele
