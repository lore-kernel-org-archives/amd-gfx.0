Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBBFC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Nov 2022 08:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E335D10E248;
	Tue, 29 Nov 2022 08:55:29 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B390410E248
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Nov 2022 08:55:27 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id n21so32030642ejb.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Nov 2022 00:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uvXYQIUjlpODv2ASDgCCHhGurCSk0rWLiF7tIMDKiSQ=;
 b=ZCrRoUf96bXE+e1flhHdjOmDaWE7eIIT4me2XSrHtXbU6qEpoULtOqXJPpHK20ja9c
 uNdNXj0YwPig7BRUtozEewQ4xkBqHqC7p12w7ahd6Mv/O9uH1fDe/CzU29DvoxF2/Yl3
 QJdPkumi1emCqxlsrCS0SzZ4aOe5VSXeM5g+n+9edLkA2tfxZJKtulq5jFan4JwiXXzw
 //qayJdhcg5zJO/HFk/hhc3IDODoBeec+hbqNWbtQ6E8blZoeGqSusOFdxcsegjEHzRW
 KV3/B/gLHP3p3xITvcYc/sma4JSiJmBhx5Ev12sHa1ti4cOBhDMa4TPerop/k+ghHSRg
 hEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uvXYQIUjlpODv2ASDgCCHhGurCSk0rWLiF7tIMDKiSQ=;
 b=VrUaNA1xiDMIXlBlfV+z4wH2K10VIG2YL2sPqj9f/uRUqxsuuwqgjPFoffIduixmGt
 VffSlgfc/DVI2Ak5GNwUR+SN42NZYiQmWxMoVnVmoQUbs4/vOEJM8I1nDTetdwDEIXav
 2+8Vi5XsvNl7+TgYEWG6zWAAAH2X4SQJQZA0zaD0HenWiBfFPWxlmEf5iV5Kq77Ks+Kl
 jHIc8c2QegWFWaFW6V1qe/wbT1wXwc6RQZp4nPvr4Lo4UW1cnGAjoLSDV9FoN2LP7EF3
 3A5xbA3Ygh2fnhcs1SE49CNdJUJ7+MzHVO6MbxF5Jzs28aXg38v8+xkkBRNfHZVMtF+f
 ONCA==
X-Gm-Message-State: ANoB5pmJinHPYtf3x9bOaWHkO4tUGrHvwt8JXFW/IWCGhXNhMELKS4B6
 nuJc7yadivTfv6z+V8izMh+a2iEstnM=
X-Google-Smtp-Source: AA0mqf6sKD4XHaBnVDr6epTz5G++32nU4Q5ty4VJfYD9qAFOaT+Q1IBnz2pZr5F/dgOTh8kDHMTghw==
X-Received: by 2002:a17:907:16a5:b0:7be:42dc:4cfc with SMTP id
 hc37-20020a17090716a500b007be42dc4cfcmr11929959ejc.128.1669712126147; 
 Tue, 29 Nov 2022 00:55:26 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:95af:cbdd:b71c:d5f5?
 ([2a02:908:1256:79a0:95af:cbdd:b71c:d5f5])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a1709066dc900b007ba46867e6asm5996889ejt.16.2022.11.29.00.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Nov 2022 00:55:25 -0800 (PST)
Message-ID: <a67622d3-b640-16fb-ec42-b68eceeaa146@gmail.com>
Date: Tue, 29 Nov 2022 09:55:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBOZXcgbWV0aG9k?=
 =?UTF-8?Q?_to_check_block_continuous?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221127053926.119084-1-xinhui.pan@amd.com>
 <1908a95c-82ff-f68d-9463-a5d92db43191@gmail.com>
 <DM4PR12MB516512AD1912AE858D85784087129@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM4PR12MB516512AD1912AE858D85784087129@DM4PR12MB5165.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Xinhui,

Am 29.11.22 um 03:11 schrieb Pan, Xinhui:
> [AMD Official Use Only - General]
>
> What I am thinking is that
> Hi Chris,
>
> For continuous memory allocation, of course the blocks are in ascending order.
>
> For non-continuous memory allocation, the allocated memory might be continuous while the blocks are not in ascending order.
>
> Anyway, could we just re-sort these blocks in ascending order if memory is indeed continuous?

Well that the blocks are in continuous order by coincident is just 
extremely unlikely.

So this doesn't make much sense.

Regards,
Christian.

>
> thanks
> xinhui
>
> ________________________________________
> 发件人: Christian König <ckoenig.leichtzumerken@gmail.com>
> 发送时间: 2022年11月29日 1:11
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander
> 主题: Re: [PATCH] drm/amdgpu: New method to check block continuous
>
> Am 27.11.22 um 06:39 schrieb xinhui pan:
>> Blocks are not guarnteed to be in ascending order.
> Well certainly a NAK. Blocks are required to be in ascending order to be
> contiguous.
>
> Regards,
> Christian.
>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 21 ++++++++------------
>>    1 file changed, 8 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 27159f1d112e..17175d284869 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -59,22 +59,17 @@ amdgpu_vram_mgr_first_block(struct list_head *list)
>>    static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
>>    {
>>        struct drm_buddy_block *block;
>> -     u64 start, size;
>> +     u64 start = LONG_MAX, end = 0, size = 0;
>>
>> -     block = amdgpu_vram_mgr_first_block(head);
>> -     if (!block)
>> -             return false;
>> +     list_for_each_entry(block, head, link) {
>> +             u64 bstart = amdgpu_vram_mgr_block_start(block);
>> +             u64 bsize = amdgpu_vram_mgr_block_size(block);
>>
>> -     while (head != block->link.next) {
>> -             start = amdgpu_vram_mgr_block_start(block);
>> -             size = amdgpu_vram_mgr_block_size(block);
>> -
>> -             block = list_entry(block->link.next, struct drm_buddy_block, link);
>> -             if (start + size != amdgpu_vram_mgr_block_start(block))
>> -                     return false;
>> +             start = min(bstart, start);
>> +             end = max(bstart + bsize, end);
>> +             size += bsize;
>>        }
>> -
>> -     return true;
>> +     return end == start + size;
>>    }
>>
>>

