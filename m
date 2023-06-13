Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAADEB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 14:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A06610E262;
	Tue, 13 Jun 2023 14:15:39 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C068A10E25F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 14:15:37 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b203360d93so69012641fa.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686665735; x=1689257735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WHg8L0Hyz9xdtGh6cxATS2uKQ7IBf8dp4zVvm39d12M=;
 b=lnvXn9iv2YnYgT/f6UrtEFrdlI/DGBNmRYUxFBXkORjO7hwFRtsurMk/ND0EB8ELKW
 d43Q72g7RTtTtqqzjOxQahQxLSri5xygvGYit7BRXJFwulUq0n8I3tI5vmWk0woIPL/Y
 wxYdt36PSHJPoZLedzDultvYH0tzowRYswnaXdbX63NKJs6rFS+VKfJdsKQrD0oWhZ9w
 WRnd2ob4/y7BIfi2lBrsdDlRl+g9fSybg4R9gUFZrRZW10LspYGivOc/1M2czAV543Nl
 8IDVqEhLrZ8ZeNSY42oUvNnKEutkonNoFiDCDmcv7W4P4bFRrX7Roy7d++XEqKbnh+kL
 shVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686665735; x=1689257735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WHg8L0Hyz9xdtGh6cxATS2uKQ7IBf8dp4zVvm39d12M=;
 b=Rdn47JCw46QTTsSihfsqyNbrnuL9dqA9fqOV1K7sjtMu4U+KAFU2w2lyx9rBDcE0rL
 IyskFWh87yWXe+8rk45fGo1bLzL/3Ie5+iy+ZBEju/HG+ADLgb1Hu4Grtzpbxw5aedsJ
 YDWymU3WR6c2rXehWCZNpcPNzvN5xsLTgGBK6lW2j0r3TQ8MttJTUw6vepFvfKPJ3+uK
 BQsemDj0FC0TOiHcMX+GNQmj5aBECeoR8nT8A8a2V3OQ7wV+5q+keYwVSuwesQqy0Ozu
 c0uJ5tZBNhZ/uxa0qjiGiBt8vcuUCztnHHLo4kefjaZxeteCbuul/vlRbCcUkY7PDIl2
 9NgA==
X-Gm-Message-State: AC+VfDzx5BRzgtQ6mX62gnlDbNb0Jyskz0qYvvXhksXJI+PZA0EE2hA/
 JxrckXpgaW2O+MpW25mWZ6E=
X-Google-Smtp-Source: ACHHUZ7iD5USce7oHFU+g88b5CPc5pBubY2BmwEwWcSo0tlPK5xX0GsDpYxdenjPpbaTDlaQ33CzqA==
X-Received: by 2002:a2e:9ad0:0:b0:2b2:1373:2377 with SMTP id
 p16-20020a2e9ad0000000b002b213732377mr4490541ljj.35.1686665735172; 
 Tue, 13 Jun 2023 07:15:35 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15d2:d500:ce87:656b:f6b5:7e12?
 ([2a00:e180:15d2:d500:ce87:656b:f6b5:7e12])
 by smtp.gmail.com with ESMTPSA id
 be14-20020a0564021a2e00b005187902d25bsm846858edb.62.2023.06.13.07.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 07:15:33 -0700 (PDT)
Message-ID: <d0d04b7e-02ff-c058-0a8d-a8591dcda2d1@gmail.com>
Date: Tue, 13 Jun 2023 16:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu/sdma4: set align mask to 255
Content-Language: en-US
To: "Liu, Aaron" <Aaron.Liu@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230607163136.958994-1-alexander.deucher@amd.com>
 <CADnq5_P6e7kYFYaZ9S8yRGhyWrLbUqBEPtGjTPHJ5a1DVWsepQ@mail.gmail.com>
 <BL1PR12MB5237E77210FC7DBA7466EB5CF055A@BL1PR12MB5237.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <BL1PR12MB5237E77210FC7DBA7466EB5CF055A@BL1PR12MB5237.namprd12.prod.outlook.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

Am 13.06.23 um 03:14 schrieb Liu, Aaron:
> [AMD Official Use Only - General]
>
> Reviewed-by: Aaron Liu <aaron.liu@amd.com>
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
>> Deucher
>> Sent: Tuesday, June 13, 2023 5:48 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu/sdma4: set align mask to 255
>>
>> ping?
>>
>> On Wed, Jun 7, 2023 at 12:31 PM Alex Deucher <alexander.deucher@amd.com>
>> wrote:
>>> The wptr needs to be incremented at at least 64 dword intervals, use
>>> 256 to align with windows.  This should fix potential hangs with
>>> unaligned updates.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> index 1f83eebfc8a7..cd37f45e01a1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> @@ -2312,7 +2312,7 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
>>>
>>>   static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
>>>          .type = AMDGPU_RING_TYPE_SDMA,
>>> -       .align_mask = 0xf,
>>> +       .align_mask = 0xff,
>>>          .nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>>>          .support_64bit_ptrs = true,
>>>          .secure_submission_supported = true, @@ -2344,7 +2344,7 @@
>>> static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
>>>
>>>   static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
>>>          .type = AMDGPU_RING_TYPE_SDMA,
>>> -       .align_mask = 0xf,
>>> +       .align_mask = 0xff,
>>>          .nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>>>          .support_64bit_ptrs = true,
>>>          .secure_submission_supported = true, diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index 8eebf9c2bbcd..05bb0691ee0e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -1823,7 +1823,7 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs =
>>> {
>>>
>>>   static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>>>          .type = AMDGPU_RING_TYPE_SDMA,
>>> -       .align_mask = 0xf,
>>> +       .align_mask = 0xff,
>>>          .nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>>>          .support_64bit_ptrs = true,
>>>          .get_rptr = sdma_v4_4_2_ring_get_rptr, @@ -1854,7 +1854,7 @@
>>> static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>>>
>>>   static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>>>          .type = AMDGPU_RING_TYPE_SDMA,
>>> -       .align_mask = 0xf,
>>> +       .align_mask = 0xff,
>>>          .nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>>>          .support_64bit_ptrs = true,
>>>          .get_rptr = sdma_v4_4_2_ring_get_rptr,
>>> --
>>> 2.40.1
>>>

