Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F12C4BA10
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 14:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D8D2467B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 14:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZhAT4H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D8D2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9C76E2BE;
	Wed, 26 Feb 2020 14:30:02 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E21716E2BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 14:30:00 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id p18so3262082wre.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 06:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BS+4+KWPRWYL3BYTVDgjO+hTwl98mowUBFjXfepShfw=;
 b=vZhAT4H6jfhigWd788KtL1iQZOqiVZHSdZ5IWrh0vO4qq2Azzfox5J6pi010/KBgfg
 y94Wie1zgx37jQY1JYwR4FUb+1BcKxMphcYg0bSCl4dqvy0D5jodzKMAyBpOxUuA0Bho
 LZ8r1PyQkwES4U14DFvbOjSb3cpxa0kXRB06mpquIhW/mr+jaq0hUqrJImorlmplt0eu
 tKaMEcOzVSI7TWHvzDeTr/Q96NqurNuFty0OQGxXyV2MXVxf6yUZkN8bJYQG7fJlm3SR
 eb7cs3ZJ/kRLCibrKDweCHmZqY8jiJlY2sO00cT7KUDqYFdkIgftoh6pzXFdVtuItbh6
 5Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BS+4+KWPRWYL3BYTVDgjO+hTwl98mowUBFjXfepShfw=;
 b=rQlRJglfFSHUs3wrxZNga/kaF0l6hYpAfP5WOB6qYB4idnlzKRbB8+S0HBgKdRpLn+
 HT3VebVOtYoiSlTHBKY+CHicNrsvfK8Gz4aew2Bgc199PbA5HiajVBo7NbfF5G/4sFo7
 KXJMckwKH+tVrBan2B51BUZwzzJIByTX+k5juZyEES6rF7P9vqZ4pPXPT0edaoWsD/fM
 +htgULeXCnzWGJ4A36VwYj+KpnQsQbHt4/pyaOCexPeJWw59nllcnMqEt0VltJKTpcZL
 tNvYujwEGL077lmt/odLhcWP712bNbMpbd96WUNr3UZKiySD7HJakNQ2CwOBNRcD04Ex
 JMRg==
X-Gm-Message-State: APjAAAXeIoUN/bhZNZUMt6A2MDj13WhxEDoCIgSd6RdKXjiPauwM2WiC
 j9aS7WhD5TgSTrW/dWvpGAU0o5pPE+jZ2dkDM6kLqQ==
X-Google-Smtp-Source: APXvYqwBk/KChNRx3T8ToT3wecGoD576zlEAv+VwQ8UuDgl13ZNC99UPCPj0SaFnH+7kd2g+tASMZXEAFhxEdkv2eN8=
X-Received: by 2002:a5d:55ca:: with SMTP id i10mr5781785wrw.111.1582727399542; 
 Wed, 26 Feb 2020 06:29:59 -0800 (PST)
MIME-Version: 1.0
References: <1582691649-4876-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1582691649-4876-1-git-send-email-Emily.Deng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Feb 2020 09:29:48 -0500
Message-ID: <CADnq5_NEnQoDRQzyk4v9Nie+qUJo3q5eZUGoC1j+CoY+SG25hg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sriov: Use kiq to copy the gpu clock
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

On Tue, Feb 25, 2020 at 11:34 PM Emily Deng <Emily.Deng@amd.com> wrote:
>
> For vega10 sriov, the register is blocked, use
> copy data command to fix the issue.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 68 +++++++++++++++++++++++++++++------
>  1 file changed, 58 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1c7a16b..71df0d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3963,6 +3963,63 @@ static int gfx_v9_0_soft_reset(void *handle)
>         return 0;
>  }
>
> +static uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev)

Please name this function gfx_v9_0_kiq_read_clock for consistency.


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

Is src 9 the counter?

Assuming that is correct, with the naming fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

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
> @@ -3970,16 +4027,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
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
> +               clock = amdgpu_kiq_read_clock(adev);
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
