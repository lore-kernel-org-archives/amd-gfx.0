Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D015CC43458
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 15:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4680C10E4B7;
	Sun, 12 Jul 2026 15:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nlIyWkA6";
	dkim-atps=neutral
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAAD510F836
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 10:52:38 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-9696319e14dso300413241.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 03:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783680757; cv=none;
 d=google.com; s=arc-20260327;
 b=rMUFMTg3QdUNDSJ6u5rQ5ES297ucCLet7mq6JEy8k9ck/bo1ITaXaHpparKmN3Mi/1
 Ua5iOwaEk7L9LRn8nq442j2lQW7kryToGh9u78jCbafYTwUV7dnaWylrkzCH9iwnmpql
 2Ti+k0XZKXcWT3J92XnqkKv8aB323rWMtQ1dHYnu+1WeYBFWVAVM24/i/dIc+NO0XtKi
 2R2abYGXH8AAcPsRFV5/U/2qFMZRBKC6xvxSZmDtrOVHGg1axdlN+bWpusSPXqn4DtGm
 E5ueLE6LgdUb2x7YFYk/nAn7mtfducEr7bxpSEYJG6PUNOh2N8Uy2W6+yfdOyJHtdI19
 sHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=tE2af13ZjzzmnvVf9fs+rE4jiyGOe38dSKqZUzwPabM=;
 fh=mDrdPA2Hexg874CBaf5Dazd4zumHfFQNv1ry5xjZ00o=;
 b=YQQopz3SiLaF7VzVeyjCuYui1T5HTYldxXOp7zIJ1N8cvfqGFpTNRMdnmaXxyesyvA
 QhOheFrI0pG/lbUmCfxKZZOY3EHFDcAiaQZ7jSwQ0vFHbB1CayT5npWsawZ+5Hvb5BdC
 4Uj+Oj+jKsJLAvZYzaZ2MrL0S2EPEefZC0mVYhEVUwiHiRGsMrolMd6Iz2tMWHyqWsYw
 SKhQHXavZumDNncRBJH7LOYfHQhARAbFDvhjgZ0nznDx7WsfYJkusIW0bkY5ZnSb8wl4
 bkOtqbRcXLYGodecnEO3SWMyuDmWqBd26P/Tlpk9w8jxWHLtRZba2rIXi2q7n34EbJDh
 wKYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783680757; x=1784285557; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tE2af13ZjzzmnvVf9fs+rE4jiyGOe38dSKqZUzwPabM=;
 b=nlIyWkA6Aq4/V0CiWstBCk/dNWOwWOuwhG0MkN1qfQf3jnkL222sSkcEVP+nAUJP7o
 xnxVXp4mmTZbI1NqoL9ovCyqyNXEiNB8ghS0xpL5jsQhzexRThwdYd73Qh7dBL7AGUbn
 ftem6jkiT9QgU59qqvFPvzj2I3tUpzMTmt3aftqWFaMs3KiaaIfi6LFPZIAFezoCqNWr
 qtHj21NuMpNRxxVukP0bHjBeJo1lH8A+gcTF09ljIiZz78VJws9n3ZAtoMmJ4RKMBidX
 1ngzYINtIBG2QJ506DTJveREyylSm4UUUc2LvZD7W9r2ZY+cwgI/S5edsS+vhlNYBN0z
 Id1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783680757; x=1784285557;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tE2af13ZjzzmnvVf9fs+rE4jiyGOe38dSKqZUzwPabM=;
 b=oHuIcVXpk3JXmTvu8DGpm6kNRA3F4brVDCgUu2Q6om0y2n3ojIibNElyjUl6ay4/iX
 UuamCibzcYB9jbfUbnGDAytJ3/gAS/hEykM5YB2MAGYzXDv+iXiQl1hdw1i8jC6b+jIM
 H0Ie05DKKoAULRe3wnx7isyDu8DeQ8l5rEXrCMfMgIkCZBwpBhjNjyluxWqp6mtJwiZL
 OT21ajbnQ0stkeq1dvD2J3JM/cIAbyKT84f8lRmik1eUElHWwcpEXmxdhCIHwSWwo3rJ
 8nJepnLMmWkQ+0svliW+xKjcllKZ3lbzjUqYY91PvJWzcT7dfy5Sc9EFpKDQazbMffvO
 D7xw==
X-Gm-Message-State: AOJu0YwZ+EXRkmQNo49iCYFJR8Jz7YA7dwmERLqYG72GjOOTvoIv3ziF
 DLf6UQEhySB2QBd0meiK6q+N2n1nFgpozIvO8/TgdIq9y7LnGpSIG+FrevnDXzOGbsEUXDbzZ3N
 ys7PDZ3goHFePDBKahCtH2qmkJ4s+NGFojTkR3V7Lsw==
X-Gm-Gg: AfdE7cnsdEet3B9+P/6RNQPmMs/x40Y4fBenMDj83fNTVhiN8XAy3poNrmvPHuaCZ0X
 qCZDndXoyUo2o+VXNnYS8n/4xMdx8BPaeFQwuCUv/k/NBke8iYnYYvF2BmhySBzVSeod+guR8pD
 NFs7qGduLLmVpGwL5Dor2dCqZN+F+Nw/0LxZDCQNjkf3HD3OM8aXnxZExmMNw8CGOaf8Vz/FqFI
 ljAlFk1zPxNuIFmgxDWLJ9/GMzUk/Mf8xu2XMd9qnEiyTrIAxzv/TZEOMjjzbmDCpcIARwDXQ==
X-Received: by 2002:a05:6102:598c:b0:744:a17f:7ba2 with SMTP id
 ada2fe7eead31-744e03134f3mr6196938137.16.1783680757324; Fri, 10 Jul 2026
 03:52:37 -0700 (PDT)
MIME-Version: 1.0
From: Andriy Korud <a.korud@gmail.com>
Date: Fri, 10 Jul 2026 12:52:26 +0200
X-Gm-Features: AUfX_mwv-W63-i1yM_kVKRADc5pL3y_XCJPzArDNGAtBVvnwYfFmilX7njJhzjg
Message-ID: <CAOidqQDq6khYfEjSz8=FHNBnR_nd17WYZDn7OdWOPG4BgPtTwQ@mail.gmail.com>
Subject: [PATCH drm-amd] drm/amd/display: dce100: skip non-DP stream encoders
 for DP MST
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mario.limonciello@amd.com, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 12 Jul 2026 15:22:44 +0000
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

From d37cbde6a3b3e57a5dc794514e77fc66e7fa8943 Mon Sep 17 00:00:00 2001
From: Andriy Korud <a.korud@gmail.com>
Date: Fri, 10 Jul 2026 12:36:59 +0200
Subject: [PATCH drm-amd] drm/amd/display: dce100: skip non-DP stream encoders
for DP MST

On DCE8-class ASICs (e.g. Bonaire), the resource pool contains digital
DIG stream encoders plus one analog DAC encoder. When assigning a stream
encoder for a second DisplayPort MST stream, if the preferred digital
encoder is already acquired, dce100_find_first_free_match_stream_enc_for_link()
falls back to the first free pool entry. That entry may be the analog
encoder, whose funcs table lacks DP hooks such as dp_set_stream_attribute.
The subsequent atomic commit then dereferences NULL function pointers in
link_set_dpms_on() and crashes.

Skip encoders without dp_set_stream_attribute when the stream uses a DP
signal (including MST). Use dc_is_dp_signal(stream->signal) for the MST
fallback path instead of checking only the link connector signal.

Tested on:
- GPU: AMD Radeon R7 260X (Bonaire / DCE8)
- Board: Supermicro C9X299-PG300
- Setup: DP MST daisy chain, hotplug second monitor or have it connected on boot
- Kernel: 7.1.3 (issue observed since 6.19)
- Result: kernel oops without patch; dual monitors stable with patch

Signed-off-by: Andriy Korud <a.korud@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5162
---
.../drm/amd/display/dc/resource/dce100/dce100_resource.c | 9 ++++++++-
1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index b92d4f378d60..beaf2e654672 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -29,6 +29,7 @@
#include "stream_encoder.h"

#include "resource.h"
+#include "signal_types.h"
#include "clk_mgr.h"
#include "include/irq_service_interface.h"
#include "dio/virtual/virtual_stream_encoder.h"
@@ -992,6 +993,12 @@ struct stream_encoder
*dce100_find_first_free_match_stream_enc_for_link(
       for (i = 0; i < pool->stream_enc_count; i++) {
               if (!res_ctx->is_stream_enc_acquired[i] &&
                               pool->stream_enc[i]) {
+                       /* DP/MST needs a digital encoder; skip
analog/no-DP encoders */
+                       if (dc_is_dp_signal(stream->signal) &&
+                           (!pool->stream_enc[i]->funcs ||
+
!pool->stream_enc[i]->funcs->dp_set_stream_attribute))
+                               continue;
+
                       /* Store first available for MST second display
                        * in daisy chain use case
                        */
@@ -1014,7 +1021,7 @@ struct stream_encoder
*dce100_find_first_free_match_stream_enc_for_link(
        * required for non DP connectors.
        */

-       if (j >= 0 && link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT)
+       if (j >= 0 && dc_is_dp_signal(stream->signal))
               return pool->stream_enc[j];

       return NULL;
--
2.55.0
