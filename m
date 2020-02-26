Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E53C4BA13
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 16:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B6B2084E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 16:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHPX6AKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B6B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0996E042;
	Wed, 26 Feb 2020 16:18:20 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2331A6E042
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 16:18:20 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id m16so3754821wrx.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 08:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Zj4LgVYjL4ijH3cecF5AebAOtgf95es4CcD8/Z/N6tk=;
 b=SHPX6AKViUKgWCuAhyF/+NWzRR84pYTyxBQHZ6XVEu440w3g1AodhC56wk96GUAmBP
 V+rd+IfJZWE/0I7V85nNjngEQhb3Zesjx2QK7XpcpJ/+9pSG0RPBNz2BkGCVkNuFiHYI
 OLnBX4YkO10oAnswyLeFa9ivT4aLVoTNozm9ZD/ydnx1cu7Lt05RmbF9RWx2ZQn8bUCu
 kjitfds5iSDt94/NiKMxENYgOJRgT6Piz0bj4rKVTLd10iCinXhxpzdUcksXdRzGO7b8
 T3roIsMrOSi5zKBUI8RKnTpCaB8MRBf3iro7zNAf6D0OWczhlp55ZdeFeX+EcTbCArkz
 R5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Zj4LgVYjL4ijH3cecF5AebAOtgf95es4CcD8/Z/N6tk=;
 b=AvU7BIOpPBn4+V0/4FfSJHpKGzhp+g19i2yjBZOJEBvIyJoyX0hRchJ9fWGG7GecJv
 k7Q5/+YABZ1yTFds7G0RcDi2BqX91ooZQ1xPRGUr4BtVYn+BNBOPwJhgEpTgL/X7ArZF
 ok9V7E6XjZUjpAp5LV0CrDJuVVC0DQ88gf0rA7D/b6vO5W3801ILEENolKX3t/w3IWkE
 M22ZmvVdOMaixww06FHYU330lb8b0ZN4wnwQOw0Y0jeiHTEtXNDtTh5qcsFX+Xg5P6t4
 /CX1Dv6h9Czf+LXBGTWW4JZ6jTXJp5E/vQXsfcMhxHwVGjMUPg6YKOgiOmzZwvaqoK5K
 INsg==
X-Gm-Message-State: APjAAAXLA0TRJWQzsCeM5j9KscVkbWqYZwQNFFXDksBl7gwRv7v3woGa
 AuHDIT1eUvdNVIvrk++LwA8Vbbrd
X-Google-Smtp-Source: APXvYqygT1nC11y9pLGZb2t7ANlQUTJXtw0nqf06amkUOUAHaGUhsyac4j8H70B9ugDLPQgoFgfv6w==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr6175892wrp.17.1582733898516;
 Wed, 26 Feb 2020 08:18:18 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 25sm3617797wmi.32.2020.02.26.08.18.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Feb 2020 08:18:17 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu/sriov: Use kiq to copy the gpu clock
To: Alex Deucher <alexdeucher@gmail.com>, Emily Deng <Emily.Deng@amd.com>
References: <1582691649-4876-1-git-send-email-Emily.Deng@amd.com>
 <CADnq5_NEnQoDRQzyk4v9Nie+qUJo3q5eZUGoC1j+CoY+SG25hg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <799e1e1f-bfaf-7b96-d569-88aac46a077f@gmail.com>
Date: Wed, 26 Feb 2020 17:18:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_NEnQoDRQzyk4v9Nie+qUJo3q5eZUGoC1j+CoY+SG25hg@mail.gmail.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.02.20 um 15:29 schrieb Alex Deucher:
> On Tue, Feb 25, 2020 at 11:34 PM Emily Deng <Emily.Deng@amd.com> wrote:
>> For vega10 sriov, the register is blocked, use
>> copy data command to fix the issue.
>>
>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 68 +++++++++++++++++++++++++++++------
>>   1 file changed, 58 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 1c7a16b..71df0d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -3963,6 +3963,63 @@ static int gfx_v9_0_soft_reset(void *handle)
>>          return 0;
>>   }
>>
>> +static uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev)
> Please name this function gfx_v9_0_kiq_read_clock for consistency.

Alternatively it might also be a good idea to move this in amdgpu_kiq.c.

But depends on you what you think makes more sense.

Regards,
Christian.

>
>
>> +{
>> +       signed long r, cnt = 0;
>> +       unsigned long flags;
>> +       uint32_t seq;
>> +       struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>> +       struct amdgpu_ring *ring = &kiq->ring;
>> +
>> +       BUG_ON(!ring->funcs->emit_rreg);
>> +
>> +       spin_lock_irqsave(&kiq->ring_lock, flags);
>> +       amdgpu_ring_alloc(ring, 32);
>> +       amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>> +       amdgpu_ring_write(ring, 9 |     /* src: register*/
> Is src 9 the counter?
>
> Assuming that is correct, with the naming fixed:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
>> +                               (5 << 8) |      /* dst: memory */
>> +                               (1 << 16) |     /* count sel */
>> +                               (1 << 20));     /* write confirm */
>> +       amdgpu_ring_write(ring, 0);
>> +       amdgpu_ring_write(ring, 0);
>> +       amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
>> +                               kiq->reg_val_offs * 4));
>> +       amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
>> +                               kiq->reg_val_offs * 4));
>> +       amdgpu_fence_emit_polling(ring, &seq);
>> +       amdgpu_ring_commit(ring);
>> +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
>> +
>> +       r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>> +
>> +       /* don't wait anymore for gpu reset case because this way may
>> +        * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
>> +        * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
>> +        * never return if we keep waiting in virt_kiq_rreg, which cause
>> +        * gpu_recover() hang there.
>> +        *
>> +        * also don't wait anymore for IRQ context
>> +        * */
>> +       if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
>> +               goto failed_kiq_read;
>> +
>> +       might_sleep();
>> +       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
>> +               msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
>> +               r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>> +       }
>> +
>> +       if (cnt > MAX_KIQ_REG_TRY)
>> +               goto failed_kiq_read;
>> +
>> +       return (uint64_t)adev->wb.wb[kiq->reg_val_offs] |
>> +               (uint64_t)adev->wb.wb[kiq->reg_val_offs + 1 ] << 32ULL;
>> +
>> +failed_kiq_read:
>> +       pr_err("failed to read gpu clock\n");
>> +       return ~0;
>> +}
>> +
>>   static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>>   {
>>          uint64_t clock;
>> @@ -3970,16 +4027,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>>          amdgpu_gfx_off_ctrl(adev, false);
>>          mutex_lock(&adev->gfx.gpu_clock_mutex);
>>          if (adev->asic_type == CHIP_VEGA10 && amdgpu_sriov_runtime(adev)) {
>> -               uint32_t tmp, lsb, msb, i = 0;
>> -               do {
>> -                       if (i != 0)
>> -                               udelay(1);
>> -                       tmp = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);
>> -                       lsb = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_LSB);
>> -                       msb = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);
>> -                       i++;
>> -               } while (unlikely(tmp != msb) && (i < adev->usec_timeout));
>> -               clock = (uint64_t)lsb | ((uint64_t)msb << 32ULL);
>> +               clock = amdgpu_kiq_read_clock(adev);
>>          } else {
>>                  WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
>>                  clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
