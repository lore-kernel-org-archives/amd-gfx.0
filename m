Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BA6C5B552
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jun 2025 19:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 896A210E151;
	Tue, 10 Jun 2025 19:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="IqJk/SqM";
	dkim-atps=neutral
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAB410E151
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jun 2025 19:12:49 +0000 (UTC)
Received: from over.fork.zz (unknown [82.65.94.41])
 (Authenticated sender: patrick9876@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id D8FFE78035E;
 Tue, 10 Jun 2025 21:12:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1749582764;
 bh=C+o1vlwFlP0hESaP8Wpb91s4oN5FOtBtx9KxIXzolyU=;
 h=From:To:Cc:Subject:Date:From;
 b=IqJk/SqMAoQSmblg3crP039cE+CKi4hqe7iVl6d2fudnFGrLnsl3lFMQui30g9dmg
 p3GvbHdpoSojY16/BPUVvEiLtHe8W1MPfnOViRZK7Xcxzyt7EFPvih3XbTYwKDuDzA
 8nRIWWb41NlI8X+eIrNbiY5ytDKIv/kPFxDGTXSMYfLy+QrqZugUIc0IGk83TXztrs
 BiknUksW5NzZ3kulwINWUi88DNuub19D4RcULYYf//5mghGJSWrhtQRrr2fkAW7Htx
 wqToALS9sWN8MKlhghIIg7oxbYNwQWa+o+F6CskEO/Xq9S30p5cB4uxsqpslICA9nI
 86WvIlQq1omSg==
From: Patrick Lerda <patrick9876@free.fr>
To: amd-gfx@lists.freedesktop.org
Cc: Patrick Lerda <patrick9876@free.fr>
Subject: [PATCH 1/2] drm/radeon/evergreen_cs: implement cond_exec and
 cond_write
Date: Tue, 10 Jun 2025 21:12:22 +0200
Message-ID: <20250610191232.15597-1-patrick9876@free.fr>
X-Mailer: git-send-email 2.49.0
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

This change implements the support of PACKET3_COND_EXEC and
PACKET3_COND_WRITE which are required to implement
ARB_indirect_parameters. ARB_indirect_parameters is
part of OpenGL 4.6.

Link: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/34726
Signed-off-by: Patrick Lerda <patrick9876@free.fr>
---
 drivers/gpu/drm/radeon/evergreen_cs.c | 96 ++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index a46613283393..7d00096fc915 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -2661,6 +2661,95 @@ static int evergreen_packet3_check(struct radeon_cs_parser *p,
 		}
 		break;
 	}
+	case PACKET3_COND_EXEC:
+	{
+		u64 offset;
+
+		if (pkt->count != 2) {
+			DRM_ERROR("bad COND_EXEC (invalid count)\n");
+			return -EINVAL;
+		}
+		r = radeon_cs_packet_next_reloc(p, &reloc, 0);
+		if (r) {
+			DRM_ERROR("bad COND_EXEC (missing reloc)\n");
+			return -EINVAL;
+		}
+		offset = radeon_get_ib_value(p, idx + 0);
+		offset += ((u64)(radeon_get_ib_value(p, idx + 1) & 0xff)) << 32UL;
+		if (offset & 0x7) {
+			DRM_ERROR("bad COND_EXEC (address not qwords aligned)\n");
+			return -EINVAL;
+		}
+		if ((offset + 8) > radeon_bo_size(reloc->robj)) {
+			DRM_ERROR("bad COND_EXEC bo too small: 0x%llx, 0x%lx\n",
+				  offset + 8, radeon_bo_size(reloc->robj));
+			return -EINVAL;
+		}
+		offset += reloc->gpu_offset;
+		ib[idx + 0] = offset;
+		ib[idx + 1] = upper_32_bits(offset) & 0xff;
+		break;
+	}
+	case PACKET3_COND_WRITE:
+		if (pkt->count != 7) {
+			DRM_ERROR("bad COND_WRITE (invalid count)\n");
+			return -EINVAL;
+		}
+		if (idx_value & 0x10) {
+			u64 offset;
+			/* POLL is memory. */
+			r = radeon_cs_packet_next_reloc(p, &reloc, 0);
+			if (r) {
+				DRM_ERROR("bad COND_WRITE (missing src reloc)\n");
+				return -EINVAL;
+			}
+			offset = radeon_get_ib_value(p, idx + 1);
+			offset += ((u64)(radeon_get_ib_value(p, idx + 2) & 0xff)) << 32;
+			if ((offset + 8) > radeon_bo_size(reloc->robj)) {
+				DRM_ERROR("bad COND_WRITE src bo too small: 0x%llx, 0x%lx\n",
+					  offset + 8, radeon_bo_size(reloc->robj));
+				return -EINVAL;
+			}
+			offset += reloc->gpu_offset;
+			ib[idx + 1] = offset;
+			ib[idx + 2] = upper_32_bits(offset) & 0xff;
+		} else {
+			/* POLL is a reg. */
+			reg = radeon_get_ib_value(p, idx + 1) << 2;
+			if (!evergreen_is_safe_reg(p, reg)) {
+				dev_warn(p->dev, "forbidden register 0x%08x at %d\n",
+					 reg, idx + 1);
+				return -EINVAL;
+			}
+		}
+		if (idx_value & 0x100) {
+			u64 offset;
+			/* WRITE is memory. */
+			r = radeon_cs_packet_next_reloc(p, &reloc, 0);
+			if (r) {
+				DRM_ERROR("bad COND_WRITE (missing dst reloc)\n");
+				return -EINVAL;
+			}
+			offset = radeon_get_ib_value(p, idx + 5);
+			offset += ((u64)(radeon_get_ib_value(p, idx + 6) & 0xff)) << 32;
+			if ((offset + 8) > radeon_bo_size(reloc->robj)) {
+				DRM_ERROR("bad COND_WRITE dst bo too small: 0x%llx, 0x%lx\n",
+					  offset + 8, radeon_bo_size(reloc->robj));
+				return -EINVAL;
+			}
+			offset += reloc->gpu_offset;
+			ib[idx + 5] = offset;
+			ib[idx + 6] = upper_32_bits(offset) & 0xff;
+		} else {
+			/* WRITE is a reg. */
+			reg = radeon_get_ib_value(p, idx + 5) << 2;
+			if (!evergreen_is_safe_reg(p, reg)) {
+				dev_warn(p->dev, "forbidden register 0x%08x at %d\n",
+					 reg, idx + 5);
+				return -EINVAL;
+			}
+		}
+		break;
 	case PACKET3_NOP:
 		break;
 	default:
@@ -3406,7 +3495,12 @@ static int evergreen_vm_packet3_check(struct radeon_device *rdev,
 	case CAYMAN_PACKET3_DEALLOC_STATE:
 		break;
 	case PACKET3_COND_WRITE:
-		if (idx_value & 0x100) {
+		if (!(idx_value & 0x10)) {
+			reg = ib[idx + 1] * 4;
+			if (!evergreen_vm_reg_valid(reg))
+				return -EINVAL;
+		}
+		if (!(idx_value & 0x100)) {
 			reg = ib[idx + 5] * 4;
 			if (!evergreen_vm_reg_valid(reg))
 				return -EINVAL;
-- 
2.49.0

