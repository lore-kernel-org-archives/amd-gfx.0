Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D191C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 13:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D9B2070B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 13:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmDoItV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D9B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D982189F1B;
	Mon, 20 Apr 2020 13:22:59 +0000 (UTC)
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F91D8926B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 07:37:57 +0000 (UTC)
Received: by mail-oo1-xc42.google.com with SMTP id p67so1907284ooa.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 00:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=zV0fj4CHiGqaNzAhP+BP2DJkbxhpeENVdLsHYfTZfzo=;
 b=nmDoItV2GSg3f5X/gytT1nsexZeJaHueTiIC+nuZtDeB6zAatBQflsexz5qD0xC8yV
 TuqdDrMsnoNzLgNaU1frNwlIsHgKPdFudTaPDuChNTWffJRHQ6Trwpr/hI5RulEK9EBm
 TtjhGMUboDk3muQywZk7Nd4FGMzO/b6egS95+yTR5mL4fpzlsEEyhMUzHr9iptL8Eh8s
 ZXkm3yPTdIJxftUuAZ7QtaKloc8Qzn5FPdyT4ptU2vKxMATETJ4zz691htMp0b8zV0vS
 +AAiQNCuAqM+hvKvKGEWeNzfkMzKIsV3YB4FyYV02B91AL2AxQf2wr2vPvhPVfRFfV8g
 csPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=zV0fj4CHiGqaNzAhP+BP2DJkbxhpeENVdLsHYfTZfzo=;
 b=C05Rn5VSCdV9Uvbm1v0pXkP/6afVJShYkueeQDgbObnCml4qOup2eTV7m8uW2DnOE2
 FxnFTvgGLuTbiIEqNXFTn2xc4V0qKrIybwOIVXEUCTr/bcXN8fBfaAv+0u67F2csJU/X
 tikyIcmWT4DLFwm0DbNfYclTZlurBzyvD3OJDJVOer7tcsX7M6YrkuGSBrtgi3uy/0Dl
 OY8Y6l43g0lwo4PR0qrJTv7jELAql+Zdbdp4ZTstMik65y9H9kEOH8jwfpro0jElXcja
 uMVyTuFYaG80GMaoQguNOqqHg3c3WmsX8w/01EjiXjO45a8jTC18Abr1eBRnWGPRyyxF
 rsMA==
X-Gm-Message-State: AGi0Pubf1h302rYxTAYfPQ+sjDJryhM3VT9qpRgq3mFQgeAEgcm4XMSO
 DG3Vyy2KG6ktY+f9l9SdpI53hxlVoFdDI+u8UXU=
X-Google-Smtp-Source: APiQypI3lmoPirYReNStm72/GvRFYkXaNLSzQw/RbNM+euVtvLaL1pXOmPUHQp350o5deFp8c09NMmsMmgXES22Rxs4=
X-Received: by 2002:a4a:e7d3:: with SMTP id y19mr11868828oov.88.1587368276861; 
 Mon, 20 Apr 2020 00:37:56 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5Lq/5LiA?= <teroincn@gmail.com>
Date: Mon, 20 Apr 2020 15:37:46 +0800
Message-ID: <CANTwqXCMA+UBi15oTcB53RQSqKZ0N39STDiwAoX7Lpg8AEo-Wg@mail.gmail.com>
Subject: drivers: gpu: drm: is it a memleak in function
 radeon_user_framebuffer_create
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com
X-Mailman-Approved-At: Mon, 20 Apr 2020 13:22:56 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, all:
    When reviewing function radeon_user_framebuffer_create,  what if
obj->import_attach is not NULL, it return directly without release obj
reference holded in function drm_gem_object_lookup.
it is a memleak of obj.
static struct drm_framebuffer *
radeon_user_framebuffer_create(struct drm_device *dev,
       struct drm_file *file_priv,
       const struct drm_mode_fb_cmd2 *mode_cmd)
    {
        struct drm_gem_object *obj;
        struct drm_framebuffer *fb;
        int ret;

        obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
        if (obj ==  NULL) {
            dev_err(&dev->pdev->dev, "No GEM object associated to
handle 0x%08X, "
                          "can't create framebuffer\n", mode_cmd->handles[0]);
        return ERR_PTR(-ENOENT);
        }

        /* Handle is imported dma-buf, so cannot be migrated to VRAM
for scanout */
        if (obj->import_attach) {
            DRM_DEBUG_KMS("Cannot create framebuffer from imported dma_buf\n");
            return ERR_PTR(-EINVAL);
        }

        fb = kzalloc(sizeof(*fb), GFP_KERNEL);
        if (fb == NULL) {
            drm_gem_object_put_unlocked(obj);
            return ERR_PTR(-ENOMEM);
        }

    ......

    }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
