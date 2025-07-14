Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EF2C83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 22:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFAA210E0E5;
	Mon, 14 Jul 2025 22:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bgg4b5Nq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4487010E0E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 22:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=caASy5LYPQas10diWUsUqPMQeeqwBWWgQk7C/cqOw2A=; b=bgg4b5NqWmUZNGgt4Uft7+5RDW
 fXk3ACHhb1UFqV9/hEAxnj3AL9dd32VEBlGrt5Au1cdb+ImP9/s4NpwkMUJ/CTa5c3r2Wy4Ke0GVF
 woznrH0j+uooODSLmgEILfNVlskhs8EBo67IpNm39ESFMZBuMz5/h9mik7gKv4xCYrBLkbnurAAdW
 EcJkWxiejd4u6wSliKz/H8wOLTx+ndH/hwonPX4EAYdRp0oSgj8QnNdrEiiJS4XYMAor6eQz2+FqK
 al0SqyQ147H83KCsTgP6w9QrtQUb1DwgMvldJ5eVvJphWn+zPzkarBxJftjNSvVHPlBcvhpY/pKNH
 bRwxXfMA==;
Received: from [189.6.13.79] (helo=[192.168.0.55])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1ubRtA-00GbTi-5a; Tue, 15 Jul 2025 00:43:12 +0200
Message-ID: <c4579093-02d8-430c-bb3a-c550a84b7abe@igalia.com>
Date: Mon, 14 Jul 2025 19:43:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] drm/amd/display: limit clear_update_flags to dcn32
 and above
To: Mario Limonciello <mario.limonciello@amd.com>, IVAN.LIPSKI@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>,
 Charlene Liu <Charlene.Liu@amd.com>, Syed Hassan <syed.hassan@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
 <20250710212941.630259-7-IVAN.LIPSKI@amd.com>
 <9e7df914-a9a4-4496-8d2f-a562cdfaa9e9@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <9e7df914-a9a4-4496-8d2f-a562cdfaa9e9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 11/07/2025 16:50, Mario Limonciello wrote:
> On 7/10/2025 4:25 PM, IVAN.LIPSKI@amd.com wrote:
>> From: Charlene Liu <Charlene.Liu@amd.com>
>>
>> [why]
>> dc has some code out of sync:
>> dc_commit_updates_for_stream handles v1/v2/v3,
>> but dc_update_planes_and_stream makes v1 asic to use v2.
>>
>> as a reression fix: limit clear_update_flags to dcn32 or newer asic.
>
> regression
>
>> need to follow up that v1 asic using v2 issue.
>>
>> Reviewed-by: Syed Hassan <syed.hassan@amd.com>
>> Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
>> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
>
> There is a public issue on this regression, we should add the 
> following tags so it closes and backports to fix it.
>
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4129
> Fixes: 7671f62c10f2 ("drm/amd/display: Clear update flags after update 
> has been applied")

Just found this patch, and I suspect it causes a regression on steamdeck 
(DCN 3.01), since in the past calling clear_update_flags fixed glitches 
related to minimal transition. Except if there are changes on other 
parts of the minimal transition machinery that avoid the problem for 
some reasons.

Did you guys validate this patch in the scenario described in 
https://gitlab.freedesktop.org/drm/amd/-/issues/3441#note_2508309 + 
https://gitlab.freedesktop.org/drm/amd/-/issues/3441#note_2510928 ?
If not, I'll do tomorrow.

Melissa

>
> Thanks!
>
>> ---
>>   drivers/gpu/drm/amd/display/dc/core/dc.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c 
>> b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index f37ed24b2430..cee45fe7cec9 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -5443,8 +5443,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
>>       else
>>           ret = update_planes_and_stream_v2(dc, srf_updates,
>>               surface_count, stream, stream_update);
>> -
>> -    if (ret)
>> +    if (ret && dc->ctx->dce_version >= DCN_VERSION_3_2)
>>           clear_update_flags(srf_updates, surface_count, stream);
>>         return ret;
>> @@ -5475,7 +5474,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
>>           ret = update_planes_and_stream_v1(dc, srf_updates, 
>> surface_count, stream,
>>                   stream_update, state);
>>   -    if (ret)
>> +    if (ret && dc->ctx->dce_version >= DCN_VERSION_3_2)
>>           clear_update_flags(srf_updates, surface_count, stream);
>>   }
>

