Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B2DC54791
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Mar 2024 05:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD8711204C;
	Sun, 10 Mar 2024 05:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="dig9gT64";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1578D11204C
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Mar 2024 05:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1710049289; x=1710654089; i=friedrich.vock@gmx.de;
 bh=X9LBql3Qe+ESf+/kwJmfU5sBw5HwDa67V3gic7/cvpI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=dig9gT64I0o/ZN42BpiMMCKuL2TJwKX5zOCzPVuMl4DpmSKdQUWHENeKmLCDPsfl
 y0N2sTtdLhd0tFWGCMPf3TepoZJ3eZpn6flPs5Lp4NRoQFFfz8g4ciPfF+eIfX4vq
 cMwnN9Fo4SeAR534Khv3e5JUPaKHA4w7fIXR5f4X04eFq9LuVTtEgJLjjZNmJ+MEr
 RL6P9YEhH5UG8i6EWt+ghxTANVqAd4hrK9quAeAboRltfo1MINO1lCF6WgtF99Uhd
 tXTPh+YmH7AggDT9JAqSjdV2eWAjVN3UHEWdEmUqshXgBQUiEdI9wq0rP367t1x9W
 IZ6rFtZSm4lITkNroA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.118.97]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDIu-1r1MoD206y-00i8Oi; Sun, 10
 Mar 2024 06:41:29 +0100
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Reset IH OVERFLOW_EN bit for IH 7.0
Date: Sun, 10 Mar 2024 06:40:40 +0100
Message-ID: <20240310054040.978056-1-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T5GXu7WE7NOl79w3UwONHdDjGc0Up3QjiWof61v4vNWybjVCQna
 TKzLI5v1R//bZX7FV0dCZ9JNr4Oocg/r9fuejL93JVhQPCV/ZO/nh6yfcY7WRj9rTqdxIJv
 +WEmuzMRD3/9zt+B8RgH6ORlGA5kqzs9b+8rC3teLUHb0WXlWDRBxXf2kgbE+kpCUVMMGYf
 0OT4FAxmxzNvtngTEs4bQ==
UI-OutboundReport: notjunk:1;M01:P0:Nf8iyvJiU/g=;tTnzJ9lnRH3EO3hOS14BF7Mzw9F
 nOgmoZV96FmwlWT2AyQjSj8x/JRl1I13nzob1oryx4h+BFtiZ/9ZE+W5xFK2w34Li8ClUbEwy
 EC181SWQP3itkvYwWgaueeOBzZQgZVzodeQB0kI2DZytNxMEuQkimBojM/3O2jUCVy1WiioAZ
 u42HXD1fkPp07v6uSBrrNiJRrxe3KXDCTQuLUYKIuQG3cU401BC2YujIR+l8oNmMpY5gxLP4R
 n/TVkyOplSdG96DtA5SurwlghrApYwSVtFHmVfcA+mA3x0TvdNHRhdHUZqQmbkuWTRKMt49Fc
 bxsjktL4jwppjDQ/D5/j7QmAmByfFCjFBB9y5nTkTmpBCCIYjMaG4UBBkdlg6zyKloKlSf7OP
 BJre1MdLJGNc7a+127HTrS8hL/JI7DwGlrMdwEXTPSUOZzeDMDJpYZhxPY2VAUuu6MYh/TyjE
 HJO8w3nIIdE80QSU89hc2uoCkjsho+pbfgJE453nM9IBnu14vBxZRLnEg1r5TXU5efPewC7Wm
 TCbVf/mKGteWgR7HGLdt7ic7qs7Lh5IhleeY4yVK+XKSLjGyCY6aIN/fprOfPBaHu6EALUBRh
 Lb+wY6spMbE7tSO/t4/WnRCvQYdf7R8ZUXDjihhRcZGi0h8JIiWpXLTJRMXqzvKnv8fKaK1Ua
 FlBfC61NK5bJeTSmNcGnKyPhWCTIYkpWEEOd8oLkmurUOKpkSv1ThZHUCtqBecPnE1Ls+M0Gz
 wZUShxLpNF+BFWD9DmaupUEq2fjeDRkAsFgl0xoqeFTFkqQ76uwizADpW8voXCkfG2qVG5xZA
 JB2UECmmGwMRuQlWiMAvEaDW0CBEWqRcVrOSKmhqnLWRE=
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

IH 7.0 support landed shortly after the original patch for resetting the
bit on all other generations, but without that patch applied.

Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/ih_v7_0.c
index 16fe428c0722d..7aed96fa10a9d 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -418,6 +418,12 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device *ade=
v,
 	tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
 out:
 	return (wptr & ih->ptr_mask);
 }
=2D-
2.44.0

