Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE49FC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 15:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5922810E84F;
	Thu,  9 Mar 2023 15:27:12 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F13110E84F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 15:27:10 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-176b90e14a9so2639055fac.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Mar 2023 07:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678375630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6BP+1p+JOenSFFSXbrvtM/aIg2OHgCn81pLoq0fRfng=;
 b=DV2Yz2CdtZF4liboNViTAx4YSTqPCDDGWDlGtrhYc8UTI5W6Lx28rOk6Idxv89D9fP
 8CVn4YJsdj4pQtJ8RWlyF7d91QuTlhEqs0SqJ5UUwJRj73J7Kay74xMoPbHOSxpuETWx
 GqDBCX/EA6YgX5fnZ8EOp68sH4taM+l47/jDYII40ykPX3G41EKK5y2/pZ1/LE02bEGg
 FkEzPhErN4F5RPuNWK39oyWg0BhFWLv+B2g0NV4Ej7rez4ToaX/z5khDhravPNcLnYxT
 HxeHqdduL3boJ+9OM7sTdySXo7qVGTyq6grd2sgvZCe+ZZk1C70F4PfI9zdnw3hxTENF
 wqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678375630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6BP+1p+JOenSFFSXbrvtM/aIg2OHgCn81pLoq0fRfng=;
 b=dle/HqYSD5tStng2lk5wNJUnfXt9uTBYuYyB3LflVeWWOpibt+BBLQw2NUyoqA04zn
 049n3ETP0almoXh7L2blalrWb051qq4Wj0HZ5k9Ba+Fgqj7WhHgBcSPKvKwFVKPlniH3
 FsobmQQhsBhh7NUwKau9pQEuSExy0kEvu5XzXHSTsV7cdVzZglNhAfw1FCF7GTWcf+qp
 9sEhMwDmVvIwxacg5SNgtGooKHaRccVUN/4o7QsRFDl8X0G6BvIMwdhnBwLYgrOIYLBW
 0lJklhVXHjhcALxbcCXTj2X8jcqTokcFbK6URoYDgfs4A64rq/Q72VBa1GP+uW1u2WKA
 pDbg==
X-Gm-Message-State: AO0yUKXzvsP/SkUvYFprWMmawffsg+xCvrfQZIinY8qhjV0G+/Pzcxe7
 9+MZJEB0P+gCwfsk5LNnIrNcm9OLHUN1VoDr+N0D+3OV
X-Google-Smtp-Source: AK7set8Oq/jvG5sCMxE+EsWGC4SUcAWMhRUe7SiotTcNhtOVVOBaBQcOQeScqOafhbMgwWM90Hxei0xgwbP0fMjY5L0=
X-Received: by 2002:a05:6870:5a91:b0:16e:93b3:207c with SMTP id
 dt17-20020a0568705a9100b0016e93b3207cmr7562134oab.3.1678375629761; Thu, 09
 Mar 2023 07:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20230309152413.1185095-1-tom.stdenis@amd.com>
In-Reply-To: <20230309152413.1185095-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Mar 2023 10:26:57 -0500
Message-ID: <CADnq5_Oe_GgNS=9gc7YbYgYDtFi6OrPFrhCL_LSOMj4TCFrzug@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add missing INT_STAT_DEBUG registers to
 GC 10.1 and 10.3 headers
To: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 9, 2023 at 10:24 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Checked against database, copied from GC 9.4.2 header.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../include/asic_reg/gc/gc_10_1_0_offset.h    |  4 ++
>  .../include/asic_reg/gc/gc_10_1_0_sh_mask.h   | 54 +++++++++++++++++++
>  .../include/asic_reg/gc/gc_10_3_0_offset.h    |  4 ++
>  .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   | 54 +++++++++++++++++++
>  4 files changed, 116 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> index 18d34bbceebe..79c41004c0b6 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> @@ -4868,6 +4868,10 @@
>  #define mmCP_ME2_PIPE2_INT_STATUS_BASE_IDX                                                             0
>  #define mmCP_ME2_PIPE3_INT_STATUS                                                                      0x1e34
>  #define mmCP_ME2_PIPE3_INT_STATUS_BASE_IDX                                                             0
> +#define mmCP_ME1_INT_STAT_DEBUG                                                                        0x1e35
> +#define mmCP_ME1_INT_STAT_DEBUG_BASE_IDX                                                               0
> +#define mmCP_ME2_INT_STAT_DEBUG                                                                        0x1e36
> +#define mmCP_ME2_INT_STAT_DEBUG_BASE_IDX                                                               0
>  #define mmCP_GFX_QUEUE_INDEX                                                                           0x1e37
>  #define mmCP_GFX_QUEUE_INDEX_BASE_IDX                                                                  0
>  #define mmCC_GC_EDC_CONFIG                                                                             0x1e38
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> index 4127896ffcdf..52043e143067 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> @@ -18680,6 +18680,60 @@
>  //CC_GC_EDC_CONFIG
>  #define CC_GC_EDC_CONFIG__DIS_EDC__SHIFT                                                                      0x1
>  #define CC_GC_EDC_CONFIG__DIS_EDC_MASK                                                                        0x00000002L
> +//CP_ME1_INT_STAT_DEBUG
> +#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT                                           0xc
> +#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT                                            0xd
> +#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT                                               0xe
> +#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT                                                0xf
> +#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                                                        0x10
> +#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT                                           0x11
> +#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT                                                   0x17
> +#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT                                               0x18
> +#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT                                                 0x1a
> +#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT                                         0x1b
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT                                                   0x1d
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT                                                   0x1e
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT                                                   0x1f
> +#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK                                             0x00001000L
> +#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK                                              0x00002000L
> +#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK                                                 0x00004000L
> +#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK                                                  0x00008000L
> +#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                                                          0x00010000L
> +#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK                                             0x00020000L
> +#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
> +#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK                                                 0x01000000L
> +#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK                                                   0x04000000L
> +#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK                                           0x08000000L
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK                                                     0x20000000L
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK                                                     0x40000000L
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK                                                     0x80000000L
> +//CP_ME2_INT_STAT_DEBUG
> +#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT                                           0xc
> +#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT                                            0xd
> +#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT                                               0xe
> +#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT                                                0xf
> +#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                                                        0x10
> +#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT                                           0x11
> +#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT                                                   0x17
> +#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT                                               0x18
> +#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT                                                 0x1a
> +#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT                                         0x1b
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT                                                   0x1d
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT                                                   0x1e
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT                                                   0x1f
> +#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK                                             0x00001000L
> +#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK                                              0x00002000L
> +#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK                                                 0x00004000L
> +#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK                                                  0x00008000L
> +#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                                                          0x00010000L
> +#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK                                             0x00020000L
> +#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
> +#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK                                                 0x01000000L
> +#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK                                                   0x04000000L
> +#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK                                           0x08000000L
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK                                                     0x20000000L
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK                                                     0x40000000L
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK                                                     0x80000000L
>  //CP_ME1_PIPE_PRIORITY_CNTS
>  #define CP_ME1_PIPE_PRIORITY_CNTS__PRIORITY1_CNT__SHIFT                                                       0x0
>  #define CP_ME1_PIPE_PRIORITY_CNTS__PRIORITY2A_CNT__SHIFT                                                      0x8
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> index 3973110f149c..a734abaa91a5 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> @@ -4531,6 +4531,10 @@
>  #define mmCP_GFX_QUEUE_INDEX_BASE_IDX                                                                  0
>  #define mmCC_GC_EDC_CONFIG                                                                             0x1e38
>  #define mmCC_GC_EDC_CONFIG_BASE_IDX                                                                    0
> +#define mmCP_ME1_INT_STAT_DEBUG                                                                        0x1e35
> +#define mmCP_ME1_INT_STAT_DEBUG_BASE_IDX                                                               0
> +#define mmCP_ME2_INT_STAT_DEBUG                                                                        0x1e36
> +#define mmCP_ME2_INT_STAT_DEBUG_BASE_IDX                                                               0
>  #define mmCP_ME1_PIPE_PRIORITY_CNTS                                                                    0x1e39
>  #define mmCP_ME1_PIPE_PRIORITY_CNTS_BASE_IDX                                                           0
>  #define mmCP_ME1_PIPE0_PRIORITY                                                                        0x1e3a
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> index d4e8ff22ecb8..d7a17bae2584 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> @@ -17028,6 +17028,60 @@
>  //CC_GC_EDC_CONFIG
>  #define CC_GC_EDC_CONFIG__DIS_EDC__SHIFT                                                                      0x1
>  #define CC_GC_EDC_CONFIG__DIS_EDC_MASK                                                                        0x00000002L
> +//CP_ME1_INT_STAT_DEBUG
> +#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT                                           0xc
> +#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT                                            0xd
> +#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT                                               0xe
> +#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT                                                0xf
> +#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                                                        0x10
> +#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT                                           0x11
> +#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT                                                   0x17
> +#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT                                               0x18
> +#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT                                                 0x1a
> +#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT                                         0x1b
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT                                                   0x1d
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT                                                   0x1e
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT                                                   0x1f
> +#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK                                             0x00001000L
> +#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK                                              0x00002000L
> +#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK                                                 0x00004000L
> +#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK                                                  0x00008000L
> +#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                                                          0x00010000L
> +#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK                                             0x00020000L
> +#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
> +#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK                                                 0x01000000L
> +#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK                                                   0x04000000L
> +#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK                                           0x08000000L
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK                                                     0x20000000L
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK                                                     0x40000000L
> +#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK                                                     0x80000000L
> +//CP_ME2_INT_STAT_DEBUG
> +#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT                                           0xc
> +#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT                                            0xd
> +#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT                                               0xe
> +#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT                                                0xf
> +#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                                                        0x10
> +#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT                                           0x11
> +#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT                                                   0x17
> +#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT                                               0x18
> +#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT                                                 0x1a
> +#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT                                         0x1b
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT                                                   0x1d
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT                                                   0x1e
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT                                                   0x1f
> +#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK                                             0x00001000L
> +#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK                                              0x00002000L
> +#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK                                                 0x00004000L
> +#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK                                                  0x00008000L
> +#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                                                          0x00010000L
> +#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK                                             0x00020000L
> +#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
> +#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK                                                 0x01000000L
> +#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK                                                   0x04000000L
> +#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK                                           0x08000000L
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK                                                     0x20000000L
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK                                                     0x40000000L
> +#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK                                                     0x80000000L
>  //CP_ME1_PIPE_PRIORITY_CNTS
>  #define CP_ME1_PIPE_PRIORITY_CNTS__PRIORITY1_CNT__SHIFT                                                       0x0
>  #define CP_ME1_PIPE_PRIORITY_CNTS__PRIORITY2A_CNT__SHIFT                                                      0x8
> --
> 2.37.2
>
