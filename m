Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EE3C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 08:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02BF10E1F4;
	Mon, 19 Aug 2024 08:37:14 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FE010E1F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 08:37:13 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3719f0758c6so1325941f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 01:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724056632; x=1724661432;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9z4cJb57ERdxIp0nnr+QMLIxjF6HyXCZLy7jtgzf/k=;
 b=KrVK3u+pbQprkxWIJNT7JHY/rnJPYVXC5ie+vVgcdlGavdM9zRgHm0oEvDOflSTO1m
 z+kBCnqmqXoh742eoXdwHQcYsG91trg2YswkXjnkfoMxtlb+2x80UJiNz+nfbnyujrvp
 /1DOsi/UgKGbgpjKSXgtr33WCmUW7lZEvQc0gY/f8/JNXy7C3NJqkTn7Sm43WbF7P54P
 aaUElHwl/b+ZnFrnLppKcrec/W7D89CsvBFJiIsU6B/Xq30AxlVvujJtd6vDePPFe5UE
 7f0El4Fd3Y66fG/J/Gv0cR+v2Zb0tMFntgUhwvMVNfIPVLYligCqsskmTmDYjdTaZX2w
 919g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9GQ1T2E+6/DFJqxHHgJQ/Zuv1hcMpC52QCMrnB/Pod152+lUvjZrYeWPA9vDixtUFx7e/KxJHKQw2JDtjDUOgU0/uLfGK+v7iUIIJOQ==
X-Gm-Message-State: AOJu0YzMXIT0w0alb1721yEg1CnACCmiKyQshHjFoTgk6g3N7ofqUC2o
 OtgP2US1c5JOJaq7e9wuP9qd/q6k447KW9VJKw7VOf8wLZRlPQSunW2rXFeV
X-Google-Smtp-Source: AGHT+IHcDy9ChYpK86QP9TV2695/PIHQnj6Za+NcnkS8Y8KYqu8Zk/Q6fLai/NYDJ48mxH0HuE8xWQ==
X-Received: by 2002:a5d:4a47:0:b0:371:8682:467e with SMTP id
 ffacd0b85a97d-371a746c205mr3900230f8f.46.1724056631663; 
 Mon, 19 Aug 2024 01:37:11 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898aa229sm9878453f8f.88.2024.08.19.01.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 01:37:11 -0700 (PDT)
Message-ID: <360cabdc-3ba7-47a0-8e4f-f0ed8cea54bc@kernel.org>
Date: Mon, 19 Aug 2024 10:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
To: "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
 <20240815224525.3077505-13-Roman.Li@amd.com>
 <CY8PR12MB81935FA7A89D077A2D0DADB489812@CY8PR12MB8193.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CY8PR12MB81935FA7A89D077A2D0DADB489812@CY8PR12MB8193.namprd12.prod.outlook.com>
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

On 16. 08. 24, 21:30, Li, Roman wrote:
> [Public]
> 
> Wiil update commit message as:
> 
> -------------
> drm/amd/display: Fix MST DSC lightup
> 
> [Why]
> Secondary monitor does not come up due to MST DSC bw calculation regression.

This patch is only related to this. It does not fix that issue on its 
own at all.

> [How]
> Fix bug in try_disable_dsc()

This update is worse than the original, IMO.

Could you write saner commit logs in the whole amdgpu overall?

If you insist on those [why] and [how] parts, something like:
"""
[Why]
The linked commit below misreverted one hunk in try_disable_dsc().

[How]
Fix that by using proper (original) 'max_kbps' instead of bogus 
'stream_kbps'.
""

> Fixes: 4b6564cb120c ("drm/amd/display: Fix MST BW calculation Regression")
> 
> Cc: mario.limonciello@amd.com
> Cc: alexander.deucher@amd.com
> Cc: stable@vger.kernel.org
> Reported-by: jirislaby@kernel.org

Care to fix up your machinery so that listed people are really CCed? I 
received a copy of neither the original (4b6564cb120c), nor this one.

Nor any mentions in the linked #3495 at all.

I would have told you that 4b6564cb120c is bogus. Immediately when it 
hit me as it differs from our (SUSE) in-tree revert in exactly this 
hunk. If I have known about this in the first place...

And you would have received a Tested-by if it had worked.

Given all the above, amdgpu workflow appears to be very ill. Please fix it.

> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3495
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1228093
> Reviewed-by: Roman Li <roman.li@amd.com>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Roman Li <roman.li@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> 
> 
>> -----Original Message-----
>> From: Roman.Li@amd.com <Roman.Li@amd.com>
>> Sent: Thursday, August 15, 2024 6:45 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
>> <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>;
>> Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman
>> <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Gutierrez,
>> Agustin <Agustin.Gutierrez@amd.com>; Chung, ChiaHsuan (Tom)
>> <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>;
>> Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Zuo, Jerry
>> <Jerry.Zuo@amd.com>
>> Subject: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
>>
>> From: Fangzhi Zuo <Jerry.Zuo@amd.com>
>>
>> A typo is fixed for "drm/amd/display: Fix MST BW calculation Regression"
>>
>> Fixes: 4b6564cb120c ("drm/amd/display: Fix MST BW calculation
>> Regression")
>>
>> Reviewed-by: Roman Li <roman.li@amd.com>
>> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
>> Signed-off-by: Roman Li <roman.li@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git
>> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>> index 958fad0d5307..5e08ca700c3f 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>> @@ -1066,7 +1066,7 @@ static int try_disable_dsc(struct drm_atomic_state
>> *state,
>>                        vars[next_index].dsc_enabled = false;
>>                        vars[next_index].bpp_x16 = 0;
>>                } else {
>> -                     vars[next_index].pbn =
>> kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps,
>> fec_overhead_multiplier_x1000);
>> +                     vars[next_index].pbn =
>> kbps_to_peak_pbn(params[next_index].bw_range.max_kbps,
>> fec_overhead_multiplier_x1000);
>>                        ret = drm_dp_atomic_find_time_slots(state,
>>
>> params[next_index].port->mgr,
>>
>> params[next_index].port,


thanks,
-- 
js
suse labs

