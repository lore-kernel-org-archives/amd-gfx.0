Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90180C83F22
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 21:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E88710E102;
	Wed, 16 Jul 2025 21:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SI9KeLrC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4495210E102
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 21:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KKOHBRLGGsJFvdXUNlFAIMyOra3x11IC9gCpDov9YGQ=; b=SI9KeLrCMyKAkAn0ttdsRneNAH
 6B9Hl/LNWGwwCevN1lm134VymVa7y+jeLsux3m7AsAZONr1OOUWjuBlNO8bXx0pVzqnf40vJi/COr
 u8ptWQ+Mza6G4hLaJPrlklu3emiPaEx8HrjxSMBzhesSn29ysW0izAKxclmYh9q1RKtpdKEmpbYmN
 x6jAnlppQzDUsr/v4aP598HUe39vJpewnieM8qgJ/f8crKlXNB9vqCvmPn249ku76LXFiWaYwhm9V
 PCkpb0notNfDhcN/9k9dIlOBhRPUM/zCudylJjyRIbpZOHGZOy4PzO/P4ngvIr41F+f7gzaOao+P7
 LP1QHtzw==;
Received: from [189.6.13.79] (helo=[192.168.0.55])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1ucA33-00HVAY-8A; Wed, 16 Jul 2025 23:52:21 +0200
Message-ID: <6ab48e71-15e4-4268-a3bd-84d993382e3a@igalia.com>
Date: Wed, 16 Jul 2025 18:52:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] drm/amd/display: limit clear_update_flags to dcn32
 and above
From: Melissa Wen <mwen@igalia.com>
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
 <c4579093-02d8-430c-bb3a-c550a84b7abe@igalia.com>
Content-Language: en-US
In-Reply-To: <c4579093-02d8-430c-bb3a-c550a84b7abe@igalia.com>
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



On 14/07/2025 19:43, Melissa Wen wrote:
>
>
> On 11/07/2025 16:50, Mario Limonciello wrote:
>> On 7/10/2025 4:25 PM, IVAN.LIPSKI@amd.com wrote:
>>> From: Charlene Liu <Charlene.Liu@amd.com>
>>>
>>> [why]
>>> dc has some code out of sync:
>>> dc_commit_updates_for_stream handles v1/v2/v3,
>>> but dc_update_planes_and_stream makes v1 asic to use v2.
>>>
>>> as a reression fix: limit clear_update_flags to dcn32 or newer asic.
>>
>> regression
>>
>>> need to follow up that v1 asic using v2 issue.
>>>
>>> Reviewed-by: Syed Hassan <syed.hassan@amd.com>
>>> Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
>>> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
>>
>> There is a public issue on this regression, we should add the 
>> following tags so it closes and backports to fix it.
>>
>> Cc: stable@vger.kernel.org
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4129
>> Fixes: 7671f62c10f2 ("drm/amd/display: Clear update flags after 
>> update has been applied")
>
> Just found this patch, and I suspect it causes a regression on 
> steamdeck (DCN 3.01), since in the past calling clear_update_flags 
> fixed glitches related to minimal transition. Except if there are 
> changes on other parts of the minimal transition machinery that avoid 
> the problem for some reasons.
>
> Did you guys validate this patch in the scenario described in 
> https://gitlab.freedesktop.org/drm/amd/-/issues/3441#note_2508309 + 
> https://gitlab.freedesktop.org/drm/amd/-/issues/3441#note_2510928 ?
> If not, I'll do tomorrow.

Hi,

I tested current `amd-staging-drm-next` that includes this patch on 
SteamDeck/SteamOS and I see those glitches reported in [1] back.
For better context, on SteamDeck/SteamOS we use many plane color 
capabilities (so it sets multiple update flags) and the glitches appear 
when transitioning between 1-2 active overlay planes.

I think we should revert this patch. Another option is to include DCN 
3.01 to the list of users of clear_update_flags().

Best Regards,

Melissa

[1] https://gitlab.freedesktop.org/drm/amd/-/issues/3441

>
> Melissa
>
>>
>> Thanks!
>>
>>> ---
>>>   drivers/gpu/drm/amd/display/dc/core/dc.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c 
>>> b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> index f37ed24b2430..cee45fe7cec9 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> @@ -5443,8 +5443,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
>>>       else
>>>           ret = update_planes_and_stream_v2(dc, srf_updates,
>>>               surface_count, stream, stream_update);
>>> -
>>> -    if (ret)
>>> +    if (ret && dc->ctx->dce_version >= DCN_VERSION_3_2)
>>>           clear_update_flags(srf_updates, surface_count, stream);
>>>         return ret;
>>> @@ -5475,7 +5474,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
>>>           ret = update_planes_and_stream_v1(dc, srf_updates, 
>>> surface_count, stream,
>>>                   stream_update, state);
>>>   -    if (ret)
>>> +    if (ret && dc->ctx->dce_version >= DCN_VERSION_3_2)
>>>           clear_update_flags(srf_updates, surface_count, stream);
>>>   }
>>
>

