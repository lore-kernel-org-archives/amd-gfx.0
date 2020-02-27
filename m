Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7887C4BA3B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 02:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBBF924672
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 02:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNNi7KQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBF924672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47DE06E40A;
	Thu, 27 Feb 2020 02:57:30 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 640DB6E40A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 02:57:29 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id v2so1407203wrp.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 18:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dA8LDuwXiIu8IO3i+H5+BS+i3pRMsUTvlG0F8yYilPk=;
 b=GNNi7KQJxNF8fr3Mog46V1h8oMPvdBwbR6cSasBSibOVhkTmiFRpGG8bDch7HtoiCd
 JhtoWqj1+N7W8D3jNGcrdqLGF97d7FYqGAqRclUg851vnJJASnJFVIcqKUJRGKuwMbgp
 vqRBFVAIF9P5ryPDshQe6SII9YZZuuwu7nRzF8WGFwQS3T8e7ZvpH0ESMktHKIibbx2L
 j2COmxTx91ipS7H49Aw4HyciOQqbVT2F61A7xCpW6S7Vv3Z2HyhnX9kgzfdHmQOHCKhT
 A3uaUAfG0zIfvNvb4eYlkONiq0/lVpwv6u1e5RtQMu/KLGf/okB+wGc/vJFKMwQWP0cC
 XS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dA8LDuwXiIu8IO3i+H5+BS+i3pRMsUTvlG0F8yYilPk=;
 b=KHZ94GoY3aABY0RBd9kvySFlNvTsGe8OjlypRTjIYoTL03IMCZ972QGLmoTI9HKpcS
 j0lRrQ3Ebjk9EfXW2h5LY+DtnQ63+oQZbmZgToRbPVENfzXLoReJvpmjd/pJqegSCD4x
 hAuMcWp5Qgn9+RV5AsvIUGcgkRd0AaUj+ANQvCafTrKquFfHv4qMjV2UKyiUJz7hXGCf
 SwMx2gA0b5f0HaeWrUgmL7gC2jYQNnqW7YB+8DrWv/C0Vwia3CVB48Gihok8Wa2fhAPM
 8KfwvQjNlnK+aTKMG66qIXWX+m6DtUP45fTd2tuXdZv7NFyl3Ghpr7cs6FR5fYwWKEZ7
 H8Sw==
X-Gm-Message-State: APjAAAUfazmJRcKzcLPOwocT6NpzDQjc3x2uWXnOwdZUr8XDAa7TlaoW
 xIANHiLMiPYtpwDwalLRvANYO3+x30mRzsCiSTk=
X-Google-Smtp-Source: APXvYqyW7jN0AaSOT49QN+3Ist/+0j9cBRQxWBlcK4YDSbcGxaDElGdIyhV4Vk17FVlfruvffHXVWQx1A6at67CS/KU=
X-Received: by 2002:adf:8b59:: with SMTP id v25mr2004996wra.419.1582772247847; 
 Wed, 26 Feb 2020 18:57:27 -0800 (PST)
MIME-Version: 1.0
References: <1582768095-7917-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1582768095-7917-1-git-send-email-Emily.Deng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Feb 2020 21:57:16 -0500
Message-ID: <CADnq5_MgFEaeqFB1h-8yj4TM=2U7bFv8oa7AW23pm7aOQjC=ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/sriov: Use kiq to copy the gpu clock
To: Emily Deng <Emily.Deng@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 26, 2020 at 8:48 PM Emily Deng <Emily.Deng@amd.com> wrote:
>
> For vega10 sriov, the register is blocked, use
> copy data command to fix the issue.
>
> v2: Rename amdgpu_kiq_read_clock to gfx_v9_0_kiq_read_clock.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 68 +++++++++++++++++++++++++++++------
>  1 file changed, 58 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index edd5501..5f7336a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3978,6 +3978,63 @@ static int gfx_v9_0_soft_reset(void *handle)
>         return 0;
>  }
>
> +static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
> +{
> +       signed long r, cnt = 0;
> +       unsigned long flags;
> +       uint32_t seq;
> +       struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> +       struct amdgpu_ring *ring = &kiq->ring;
> +
> +       BUG_ON(!ring->funcs->emit_rreg);
> +
> +       spin_lock_irqsave(&kiq->ring_lock, flags);
> +       amdgpu_ring_alloc(ring, 32);
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
> +       amdgpu_ring_write(ring, 9 |     /* src: register*/
> +                               (5 << 8) |      /* dst: memory */
> +                               (1 << 16) |     /* count sel */
> +                               (1 << 20));     /* write confirm */
> +       amdgpu_ring_write(ring, 0);
> +       amdgpu_ring_write(ring, 0);
> +       amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> +                               kiq->reg_val_offs * 4));
> +       amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> +                               kiq->reg_val_offs * 4));
> +       amdgpu_fence_emit_polling(ring, &seq);
> +       amdgpu_ring_commit(ring);
> +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +       r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +
> +       /* don't wait anymore for gpu reset case because this way may
> +        * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
> +        * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
> +        * never return if we keep waiting in virt_kiq_rreg, which cause
> +        * gpu_recover() hang there.
> +        *
> +        * also don't wait anymore for IRQ context
> +        * */
> +       if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
> +               goto failed_kiq_read;
> +
> +       might_sleep();
> +       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> +               msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> +               r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +       }
> +
> +       if (cnt > MAX_KIQ_REG_TRY)
> +               goto failed_kiq_read;
> +
> +       return (uint64_t)adev->wb.wb[kiq->reg_val_offs] |
> +               (uint64_t)adev->wb.wb[kiq->reg_val_offs + 1 ] << 32ULL;
> +
> +failed_kiq_read:
> +       pr_err("failed to read gpu clock\n");
> +       return ~0;
> +}
> +
>  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>  {
>         uint64_t clock;
> @@ -3985,16 +4042,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>         amdgpu_gfx_off_ctrl(adev, false);
>         mutex_lock(&adev->gfx.gpu_clock_mutex);
>         if (adev->asic_type == CHIP_VEGA10 && amdgpu_sriov_runtime(adev)) {
> -               uint32_t tmp, lsb, msb, i = 0;
> -               do {
> -                       if (i != 0)
> -                               udelay(1);
> -                       tmp = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);
> -                       lsb = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_LSB);
> -                       msb = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);
> -                       i++;
> -               } while (unlikely(tmp != msb) && (i < adev->usec_timeout));
> -               clock = (uint64_t)lsb | ((uint64_t)msb << 32ULL);
> +               clock = gfx_v9_0_kiq_read_clock(adev);
>         } else {
>                 WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
>                 clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
