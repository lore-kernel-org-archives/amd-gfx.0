Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044A6C55180
	for <amd-gfx@archiver.kernel.org>; Sun,  2 Aug 2026 14:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5477D10E41D;
	Sun,  2 Aug 2026 14:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qpka5rku";
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA86A10E41D
 for <amd-gfx@lists.freedesktop.org>; Sun,  2 Aug 2026 14:35:34 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-44856d185bcso2999429fac.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 02 Aug 2026 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785681334; x=1786286134; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OBwqQBQZ7gr9qfD8QTCGZXfSKgrXALeSbfMpkftaqF8=;
 b=Qpka5rkuFtAQhU5rRnZbc7kg7mspeG5kvtGRw9pKkY4d70eDZZjS859qwqxjFcTBbB
 MEakdWPXulndLW7ylxBjGSAawEihG1jNCHrFD7kiCiQfzMAYxCNgkLD6LGs4gBohIUME
 6S0qNUJwDy1vY9LW99257H6JFO0W7F2TcWE1Qt56ZR4VVBBsTwPv8vd4tYu1rQSPbCqt
 Li9wW+pvjgd0B+KQuYLFUHkXTCr35pJXShfNyfeqmQ24glPPzZSi3z6ZYt5h87I0Aa7y
 bsc8ha0YVyytwRFE5hLy4Rua0XVi9v45LVpP6Rn15J00ZYk4iwvT/hqtdY+4g6grv9/4
 cNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785681334; x=1786286134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OBwqQBQZ7gr9qfD8QTCGZXfSKgrXALeSbfMpkftaqF8=;
 b=X38ji0bEKPddzGGSCSVWYn8ZiJ3Qp9U/UCEotzUwcUVjVPY5XPRYNWbSuE8DaY3d1B
 nAryLIhqhruvqXmYzttlFvDKEd6ckTmrQ4mVUbIGSZ5O7UbHmWXvbFOKGrRj9OngGryw
 JbYpKQiDNwVM6avHxijUFIdg0jRCPMOidDbr2QhoTfW7ReNMmYyL3yplCGKAUekAkb/t
 lJQ/AM0tHUn2pnNGHzMDrDAqfhuyhkVliCfhm24cR8/RU3PKR5haXb4hmvwhyprG6AC0
 NBU08/rFAi/sp0b1S/Dt31LOLxnbsSV/COtWlleTcMp48haKMYKGF8BP2rCEli35j5oM
 XH6g==
X-Gm-Message-State: AOJu0YwrG6kgO6abHW9BnMYvtU1iKsYvRAQno3ZtECfL1Rfoq+/X3mzW
 GcNMEzepucHRLqORitPXwljj9PPrujMzKzpH2oU47KiT0J0zqnyWPoNUqcLVqmQYWpc=
X-Gm-Gg: AR+sD11ip9X3ErR4sG9vm1uBK5m2o5UmOQZZc3RHHKdOgPQCkzZo0FTJ7qoWsgQiSis
 hdO98Nk3avT+rc9uOJdDKR2qMluz2SavqHcjw8vqxqcHs64yjNQ2B5VRzh5x5/Ncwm20+qtAKS5
 p8UqncWL1GrCa84KJMvnlfY3kkgFPe1BD3lP7oBcmj2oz3HKqH//kxqkPdu/wqr6IcxMhr8CHTX
 88eJUficx32nVb3r2p1qtXDpS+iHm8x86gAF0JAqFLYifkW/3U/DmmgHTbCOBJfSS+ekvvnsW6S
 GOGUaftfNMZaVHUy2WMB+GitjcikDnL0HXVeYY65eWMxPK73jyxViZV4JNM2pU3kkOOBzNxLZxT
 u/diRkLb1PQQ3LjwgiM1vbd5u2i4sL8nRKNoSngcL2Y6M1oYLbpCPFsVXzNOIG52z5TNw07+HFS
 RSs2TFyKrfsMWwnEqH6atwtLybkZXYhbFyNGdhWCQ4+NJ4nWqac+ULM/uMirNOnparAYMiFPTV8
 C3JvWfSREh82xQCkBDkawvfP/qn+HTM28LlR8q+TJYb
X-Received: by 2002:a05:6808:14c1:b0:4a3:58a6:8a57 with SMTP id
 5614622812f47-4af5e3a5f51mr11753697b6e.20.1785681330605; 
 Sun, 02 Aug 2026 07:35:30 -0700 (PDT)
Received: from natebox2.jabitha.com (46-110-104-162.wmnscoaa.metronetinc.net.
 [46.110.104.162]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58e9551dsm4778877b6e.11.2026.08.02.07.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 07:35:30 -0700 (PDT)
From: Nathan Lucas <nlucasgit@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, joshua@froggi.es, mwen@igalia.com,
 leorize+oss@disroot.org, alex.hung@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/amd/display: fix BT.2020 YCbCr output CSC matrices
Date: Sun,  2 Aug 2026 08:35:22 -0600
Message-ID: <cover.1785616749.git.nlucasgit@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch series fixes COLOR_SPACE_YCBCR2020_TYPE in dc_hw_sequencer.c
which is used for COLOR_SPACE_2020_YCBCR_LIMITED output but does not have
correct luma and chroma scaling for that output range, and fixes its
copies in dce_transform.c and dce110_opp_csc_v.c.

It looks like this matrix was originally added in commit 40df2f809e8f
("drm/amd/display: color space ycbcr709 support") as a raw BT.2020-NCL RGB
to YCbCr conversion matrix that had not yet been prepared for unsigned
limited or full-range quantization.  Commit 973a9c810c78
("drm/amd/display: Fix COLOR_SPACE_YCBCR2020_TYPE matrix") applied offsets
for unsigned limited-range quantization but did not fix the luma and chroma
scales which are still full range.  Because of this, output on a calibrated
display is too bright with incorrect color, although it still looks roughly
correct at low luminance in my testing.

Later, in commit 51e6668ab4ba
("drm/amd/display: add missing CSC entries for BT.2020 for DCE IPs"), the
incorrect COLOR_SPACE_YCBCR2020_TYPE matrix coefficients were duplicated to
DCE COLOR_SPACE_2020_YCBCR_LIMITED and COLOR_SPACE_2020_YCBCR_FULL, so
those matrices are also currently incorrect.

The first patch adds separate matrices for full and limited-range.  The
derivation is in the commit message.  The second patch replaces the copied
matrix coefficients in dce_transform.c and dce110_opp_csc_v.c with the new
ones.

For testing I have only been able to check the limited-range DCN path on a
9070 XT with a patched kernel.  amdgpu_dm_get_output_color_space does not
currently have a path to select COLOR_SPACE_2020_YCBCR_FULL although the
enum value exists.  Also, I cannot test the DCE paths as I do not have the
hardware to do so.

I ran into this issue measuring PQ test patterns through mpv with the
following command line:

mpv \
  --no-config \
  --vo=gpu-next \
  --gpu-context=displayvk \
  --gpu-api=vulkan \
  --vulkan-display-plane=3 \
  --vulkan-display-mode=22 \
  --target-trc=pq \
  --target-prim=bt.2020 \
  --target-colorspace-hint-mode=source \
  --target-colorspace-hint=yes \
  --tone-mapping=clip \
  --hdr-compute-peak=no \
  [pattern file]

Free test patterns:
https://diversifiedvideosolutions.com/hdr-10.html

Below is a table of values I measured on a Samsung S95H (US model) with a
Calibrite Display Pro HL meter.

Three sets of meter readings below:
Unpatched - Unpatched Fedora 44 kernel 7.1.4-200.fc44.x86_64
Patched   - The patches in these e-mails applied to Fedora 44 kernel
            7.1.4-200.fc44.x86_64
NVS/Kodi  - NVIDIA Shield Pro with Kodi

 5% HDR10/PQ
 Test Pattern        Meter Readings (nits)
==============   ==============================
PQ%       Nits   Unpatched   Patched   NVS/Kodi
15        1.01        1.63      1.01     1.02
25        5.24        9.68      5.46     5.12
35       18.78       40        20.5     21.2
45       56.55      128        62.0     62.1
55      148.03      369       155      155
65      384.71     1106       403      401
75      973.13     2681*     1030     1025

* This is at the peak capability for this TV.

PQ brightness overtracks a bit in Patched and NVS/Kodi, but that is likely
due to the TV's default calibration or my meter since the readings are so
similar.  Unpatched stands out as being way too bright.

Nathan Lucas (2):
  drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix
  drm/amd/display: fix BT.2020 YCbCr output CSC matrices for DCE

 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 31 ++++++++++++-------
 .../drm/amd/display/dc/dce/dce_transform.c    |  7 +++--
 .../amd/display/dc/dce110/dce110_opp_csc_v.c  |  7 +++--
 3 files changed, 28 insertions(+), 17 deletions(-)

-- 
2.55.0

