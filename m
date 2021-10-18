Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9A2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 22:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD17C60FC3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 22:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD17C60FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7031C6EA7B;
	Mon, 18 Oct 2021 22:57:23 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C644D6EA7B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 22:57:21 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae8cf.dynamic.kabel-deutschland.de
 [95.90.232.207])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2965361E5FE33;
 Tue, 19 Oct 2021 00:57:20 +0200 (CEST)
Subject: Re: [PATCH 16/27] drm/amd/display: increase Z9 latency to workaround
 underflow in Z9
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Mike Lothian <mike@fireburn.co.uk>,
 Agustin Gutierrez <agustin.gutierrez@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <Harry.Wentland@amd.com>,
 Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, qingqing.zhuo@amd.com,
 "Lipski, Mikita" <mikita.lipski@amd.com>, Roman Li <roman.li@amd.com>,
 Anson.Jacob@amd.com, Wayne Lin <wayne.lin@amd.com>, stylon.wang@amd.com,
 solomon.chiu@amd.com, pavle.kotarac@amd.com, Eric Yang <Eric.Yang2@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
 <20211015184332.221091-17-agustin.gutierrez@amd.com>
 <CAHbf0-HyA2EPHq74e_oq_X1bbSd9-uNwuX6aWYjf7Hz3UYTx3Q@mail.gmail.com>
 <3f1dee31-dfb0-3fb2-d647-9b6bf344a7e9@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <111325f7-3c66-3d0c-64b4-be092c65f074@molgen.mpg.de>
Date: Tue, 19 Oct 2021 00:57:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3f1dee31-dfb0-3fb2-d647-9b6bf344a7e9@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

Dear Nicholas, dear Eric, dear Augustin,


Am 18.10.21 um 19:14 schrieb Kazlauskas, Nicholas:
> On 2021-10-15 7:53 p.m., Mike Lothian wrote:
>> This patch seems to change z8 - not that I know what z8 or z9 are
> 
> It's a little misleading but the patch and terminology is correct.
> 
> Z9 is the usecase for these watermarks even if the calculation is shared 
> with Z8/Z9.

It’d be great to have that in the commit message.


Kind regards,

Paul

>> On Fri, 15 Oct 2021 at 19:44, Agustin Gutierrez wrote:
>>>
>>> From: Eric Yang <Eric.Yang2@amd.com>
>>>
>>> [Why]
>>> Z9 latency is higher than when we originally tuned the watermark
>>> parameters, causing underflow. Increasing the value until the latency
>>> issues is resolved.
>>>
>>> Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
>>> Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
>>> Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c 
>>> b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
>>> index c9d3d691f4c6..12ebd9f8912f 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
>>> @@ -222,8 +222,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_1_soc = {
>>>          .num_states = 5,
>>>          .sr_exit_time_us = 9.0,
>>>          .sr_enter_plus_exit_time_us = 11.0,
>>> -       .sr_exit_z8_time_us = 402.0,
>>> -       .sr_enter_plus_exit_z8_time_us = 520.0,
>>> +       .sr_exit_z8_time_us = 442.0,
>>> +       .sr_enter_plus_exit_z8_time_us = 560.0,
>>>          .writeback_latency_us = 12.0,
>>>          .dram_channel_width_bytes = 4,
>>>          .round_trip_ping_latency_dcfclk_cycles = 106,
>>> -- 
>>> 2.25.1
>>>
> 
