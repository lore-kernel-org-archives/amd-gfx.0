Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEA2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 06:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D8B10FC3F;
	Tue, 12 Apr 2022 06:20:25 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C8210FC3F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 06:20:24 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef95.dynamic.kabel-deutschland.de
 [95.90.239.149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id E41E961EA1929;
 Tue, 12 Apr 2022 08:20:22 +0200 (CEST)
Message-ID: <e187b36c-2761-321b-4aae-ba2f78143b2c@molgen.mpg.de>
Date: Tue, 12 Apr 2022 08:20:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 04/13] drm/amd/display: FEC check in timing validation
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Alexander Deucher <Alexander.Deucher@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
 <20220318214800.3565679-5-alex.hung@amd.com>
 <85d909aa-3d02-fc43-47a4-2c321ad15dec@molgen.mpg.de>
In-Reply-To: <85d909aa-3d02-fc43-47a4-2c321ad15dec@molgen.mpg.de>
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Alex Hung <alex.hung@amd.com>,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 Chiawen Huang <chiawen.huang@amd.com>, Sunpeng.Li@amd.com,
 Aurabindo.Pillai@amd.com, agustin.gutierrez@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex,


Am 19.03.22 um 08:43 schrieb Paul Menzel:
> Dear Alex, dear Chiawen,
> 
> 
> Thank you for your patch.
> 
> Am 18.03.22 um 22:47 schrieb Alex Hung:
>> From: Chiawen Huang <chiawen.huang@amd.com>
>>
>> [Why]
>> disable/enable leads fec mismatch between hw/sw fec state.
> 
> 1.  Disable/enable of what?
> 2.  How can this be reproduced?
> 3.  s/fec/FEC/
> 
>> [How]
>> check fec status to fastboot on/off.
> 
> What do you mean by “to fastboot on/off”?
> 
>> Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
>> Acked-by: Alex Hung <alex.hung@amd.com>
>> Signed-off-by: Chiawen Huang <chiawen.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c 
>> b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index f6e19efea756..75f9c97bebb0 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -1496,6 +1496,10 @@ bool dc_validate_boot_timing(const struct dc *dc,
>>       if (!link->link_enc->funcs->is_dig_enabled(link->link_enc))
>>           return false;
>> +    /* Check for FEC status*/
> 
> Missing space before `*/`.
> 
>> +    if (link->link_enc->funcs->fec_is_active(link->link_enc))
>> +        return false;
>> +
>>       enc_inst = link->link_enc->funcs->get_dig_frontend(link->link_enc);
>>       if (enc_inst == ENGINE_ID_UNKNOWN)

I just saw, that this patch was committed on March 25th, 2022 (commit 
7d56a154e22f) with my comments ignored. Could you please explain why?


Kind regards,

Paul
