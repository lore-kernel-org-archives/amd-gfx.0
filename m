Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C776103E166
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 11:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB24710E77F;
	Wed, 18 Mar 2026 11:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="j3PD3SYL";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 267DF10E77F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1773833811; bh=g9jhrJur0KQWKJh4gmdbWiFip9E0QP146aLQ+dEBj2g=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=j3PD3SYLs28cAAxcsI39yO10fIuPcjppRrsCRPxLWVeQVu1NjSjPquR2rMzj4jVJ8
 3nJxbi/xvGKxey56sWfj+sABoLWAskMMJdn1zwkFmkvfl76hkiV/lCy9bP1E8EiUVs
 QyRduhzjLLX+IRyAdTBECrh9rKpMbKpaRgMyqQLFWnleoaxnGYs2CazJmARR6O9tTs
 7OFmj00QE1EMKyV89VzxpQi5H74dJh1e/L6waudrkaHVfjwz2CvHe2ckqXmCC/4dth
 j0AuKEKUQYwnbLL475jP3DbDuJQR85fP7CFkOVtqV3W2onHHynArQsimY+GjivZVoK
 4iUTAVJs+5xwA==
Message-ID: <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
Date: Wed, 18 Mar 2026 12:36:51 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, siqueira@igalia.com,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Shengyu Qu <wiagn233@outlook.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
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
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
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

On 3/16/26 19:48, Leo Li wrote:
>>
>> Thanks for the dumps, looks like interrupts were disabled, which is surprising
>> given drm_vblank_disable_and_save() was not called. OTG0 seems to be active as
>> the FRAME_COUNT is incrementing.
>>
>> Does force-enabling the VSTARTUP interrupt on OTG0 revive the hanging display
>> once the timeout happens?
> 
> Actually, if you manage to catch it and send the below umr command *before* the 10s
> timeout expires, that'd be even more telling.
> - Leo
> 
>>
>> sudo umr --instance 1 -wb '*.dcn410.regOTG0_OTG_GLOBAL_SYNC_STATUS.VSTARTUP_INT_EN' 1
>>
>> - Leo
> 

Ok i managed to do exactly that, before the timeout sent your umr 
command, frozen display did not recover (recovered only after 
unplugging/replugging the DP cable as always)

UMR output before/after force enable
https://pastebin.com/hhapxBev

