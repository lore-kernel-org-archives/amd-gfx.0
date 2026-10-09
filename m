Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52753CA601E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 18:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D513610EABD;
	Fri,  9 Oct 2026 18:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s0jvDUhE";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE58110EABD
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 18:21:49 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-3535dd9a601so125960eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Oct 2026 11:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791570109; cv=none;
 d=google.com; s=arc-20260327;
 b=JqejpbHS05BXqoeEj/iNzBxBSyTocK+PkCjdd97Ro4NlEJyf5E+b1rEyMVrFcdOQB4
 WyW6EIRUMfwqLoDSngUTY4NyFMqALX9nh1qSU0nEBLRttP0veWKD9zg5D/UpuSad5IGG
 QdyS5fHAa4kX9jfRGE1eCylaeRu621jpQlwvurZwTqVasv5t5eSnKtUFvMzX7yW2lOmm
 C+TRCOJ5mcaqwizFy+vHkPzSq6Tpi8g7Q/fog6Zwp1K2veK/axE2n9tx0WZ7eT0twoZj
 g3yN4Yv8NHxKhXppS2e/RJCIfEvj403eEQDMRh+nLBpZDJSyssqMU5B2BDuJF4BVZcQV
 ST7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eQ9xGw9wAaeWGo0bjgTxJj3esAPvmL1Nsy57zRu7FsA=;
 fh=xy4xGHb8XHMFOeNqi/GntN0gh6U/VQCuneYv0kKlJ14=;
 b=aF6whnFjPPWzzhP1eisFzWCwmK4ML/aPVe4L/lzkNv2Nr5z4lDniYWIFetYNCiRkZL
 HQzGu0uDYuCTqCbs7eRyxLiJ/jyoHdOQkan5rVA4yiT3IG1VmVZRYuEMTehur4qCfreF
 Mi5Wcb2o528+xus9cAHr2qgmk7VZwUu6ZNb5EQUDrT6tU+x0/wPy2SQQHP/QfmB2eLXU
 122Gyz0ezAHTkLbkaE4sG/eZVFuLRfcme4kcYETv6QoKzwl7QiNKNTFSc2VvDaWfWkaW
 EzUVOn9mLU9QRSxALHzmfWm4jvn2lsANuESwhxooPVQ/AwnbtnxW5g5juw5LfHe/r8ZN
 0jug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791570109; x=1792174909; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eQ9xGw9wAaeWGo0bjgTxJj3esAPvmL1Nsy57zRu7FsA=;
 b=s0jvDUhEa6uLP2We0xBbKabkAkffTeZtGX0QMHbhCvWiZZU0V1giRIJ5odZA0BO9pr
 kFFMrV2wuKyPqFzHGFRt1Od7jko8HDZ0r5KGmHK0TebcB9yEfYOCoDd9EQcwug6oqOcV
 8jPy6RKvEinv4ceTiTKXoB6nXkpDS0QCWwulRjsxtjlTOPL6w2QIcbU+Hq90BjyhD8RA
 9SoFKcTC0r+oHFfsKnK5kUCBWGS1oYwp3sj9GRgAO2QSXM8RKvb+sToYSEvS2ZbdcasS
 Tbow8I29Xbeuc20VTISd/c6zI0Q+jZ9tFFKKvMu6s9c+v2hNsf3MnDS9ZT1MLy7maOO9
 APPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791570109; x=1792174909;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eQ9xGw9wAaeWGo0bjgTxJj3esAPvmL1Nsy57zRu7FsA=;
 b=Z6P5KO9N3ug8uyLC/I1x/1ZBwEPIJi+BuOHLsVncTDISmgkHvjGOUsITHT21hoX3Ct
 f7B/s0HhvAaMU8N9beF9gFyHfbSL8Ejomf/e28zceGEa1VYSRiIrg/h0HTSXVBOb7+HG
 vtbXGXGMYBf5TiYUo5+ySIGCibNieltqaJ+/undujNIBxy5i3akEu4fIQXcS6kXs5FoQ
 WpClkZToBuPv/GZqxUIY7FJuBwBOSpe93yMpZM0PohBHJDwkxsewWLLGKf/vduAKBzrn
 Z/nTkiUPcs5eG/azYl4Q6FzJey/A3Q4xaGL1HEJgzgGRVY92zUCXRpzydlpiIFslfj0j
 p5TQ==
X-Gm-Message-State: AFuF++lr9UzheSLYCwuvAIh4X1fZE2TnVyg/0aF1BqYHlgdR4vi3zeBk
 Q8KlGIfCMSvPgHO0rX6KbqsgcyRi+v7rBXi64JYhdaP7hicuTc4oZe+1a7rlGeT1ayGTo/uxY+G
 KqPv3DOIxNzo3QLp2XJyG/i7M4bAeusk=
X-Gm-Gg: AYBFou3Uo1McOSCZbCbl0TbiCr2fzhgO87ca6C1OEvUFcH/kZDZFCSPDtk8Q7OhRtax
 sHZzmKNSPQworJBVIWdJH7F+BS/s9XqKcubXlJTYlKMUdZHr5vxPYsDYwYfNVNBz4eEYZWvYbYo
 JBpsZFeFtZtcedsyatS0U5zShG6mpF1dVmmxVQlzJ6WmGiI9xWaiGDvAscdQBZexvjPXleaMsU4
 g78P78VQLBPaIzusfkmaQAnnisHL21aEsRtk+jkDKTVp6mwAX8v6yz1WLhmN5SaJzoZnR6yY3YM
 dj1LC7m+gXRiQHqvShAgzxwC1mylL+JnmTKYGv7x9vYL5Ag8YGV1LXA8vtzM1pebcPF+mRvE7WH
 5x2OPhsSQYGTWsIieCf+KtcA3IC34qgqk6O178PveMuw7fQMUW6/P
X-Received: by 2002:a05:701b:4510:20b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-16b4f520f3amr3815962c88.0.1791570108761; Fri, 09 Oct 2026
 11:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261009153122.532708-1-tom.stdenis@amd.com>
In-Reply-To: <20261009153122.532708-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Oct 2026 14:21:37 -0400
X-Gm-Features: AclHuK_vttosWYCiVO8i9fhxfVzCjhYW5r47DVwrj0bOuJT70VNxIgYNliISI94
Message-ID: <CADnq5_NJkiUjLrHBD+iG81_HgrEobomAOMsP+GyYrC_+YoNMvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add missing GC 11.0.0 registers
To: Tom St Denis <tom.stdenis@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Oct 9, 2026 at 12:26=E2=80=AFPM Tom St Denis <tom.stdenis@amd.com> =
wrote:
>
> This adds the regCP_ME1_INT_STAT_DEBUG and regCP_ME2_INT_STAT_DEBUG regis=
ters that
> were missing from the GC 11.0.0 headers but found in GC 11.0.3
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../include/asic_reg/gc/gc_11_0_0_offset.h    |  4 ++
>  .../include/asic_reg/gc/gc_11_0_0_sh_mask.h   | 54 +++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h b=
/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
> index a3bcdf632066..3dddaec23bcf 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
> @@ -4261,6 +4261,10 @@
>  #define regCP_ME2_PIPE2_INT_STATUS_BASE_IDX                             =
                                0
>  #define regCP_ME2_PIPE3_INT_STATUS                                      =
                                0x1e34
>  #define regCP_ME2_PIPE3_INT_STATUS_BASE_IDX                             =
                                0
> +#define regCP_ME1_INT_STAT_DEBUG                                        =
                                0x1e35
> +#define regCP_ME1_INT_STAT_DEBUG_BASE_IDX                               =
                                0
> +#define regCP_ME2_INT_STAT_DEBUG                                        =
                                0x1e36
> +#define regCP_ME2_INT_STAT_DEBUG_BASE_IDX                               =
                                0
>  #define regCP_GFX_QUEUE_INDEX                                           =
                                0x1e37
>  #define regCP_GFX_QUEUE_INDEX_BASE_IDX                                  =
                                0
>  #define regCC_GC_EDC_CONFIG                                             =
                                0x1e38
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h =
b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h
> index 3088a4a13cb5..1b64f157467d 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h
> @@ -16187,6 +16187,60 @@
>  #define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK               =
                                      0x00800000L
>  #define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT             =
                                      0x17
>  #define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK               =
                                      0x00800000L
> +//CP_ME1_INT_STAT_DEBUG
> +#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT     =
                                      0xc
> +#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT      =
                                      0xd
> +#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT         =
                                      0xe
> +#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT          =
                                      0xf
> +#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                  =
                                      0x10
> +#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT     =
                                      0x11
> +#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT             =
                                      0x17
> +#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT         =
                                      0x18
> +#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT           =
                                      0x1a
> +#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT   =
                                      0x1b
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT             =
                                      0x1d
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT             =
                                      0x1e
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT             =
                                      0x1f
> +#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK       =
                                      0x00001000L
> +#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK        =
                                      0x00002000L
> +#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK           =
                                      0x00004000L
> +#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK            =
                                      0x00008000L
> +#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                    =
                                      0x00010000L
> +#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK       =
                                      0x00020000L
> +#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK               =
                                      0x00800000L
> +#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK           =
                                      0x01000000L
> +#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK             =
                                      0x04000000L
> +#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK     =
                                      0x08000000L
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK               =
                                      0x20000000L
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK               =
                                      0x40000000L
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK               =
                                      0x80000000L
> +//CP_ME2_INT_STAT_DEBUG
> +#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT     =
                                      0xc
> +#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT      =
                                      0xd
> +#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT         =
                                      0xe
> +#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT          =
                                      0xf
> +#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                  =
                                      0x10
> +#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT     =
                                      0x11
> +#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT             =
                                      0x17
> +#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT         =
                                      0x18
> +#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT           =
                                      0x1a
> +#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT   =
                                      0x1b
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT             =
                                      0x1d
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT             =
                                      0x1e
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT             =
                                      0x1f
> +#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK       =
                                      0x00001000L
> +#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK        =
                                      0x00002000L
> +#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK           =
                                      0x00004000L
> +#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK            =
                                      0x00008000L
> +#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                    =
                                      0x00010000L
> +#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK       =
                                      0x00020000L
> +#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK               =
                                      0x00800000L
> +#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK           =
                                      0x01000000L
> +#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK             =
                                      0x04000000L
> +#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK     =
                                      0x08000000L
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK               =
                                      0x20000000L
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK               =
                                      0x40000000L
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK               =
                                      0x80000000L
>  //CP_GFX_QUEUE_INDEX
>  #define CP_GFX_QUEUE_INDEX__QUEUE_ACCESS__SHIFT                         =
                                      0x0
>  #define CP_GFX_QUEUE_INDEX__PIPE_ID__SHIFT                              =
                                      0x4
> --
> 2.53.0
>
