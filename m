Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D4EC05027
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Feb 2023 16:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9423A10E1E4;
	Thu,  2 Feb 2023 16:26:58 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Thu, 02 Feb 2023 16:26:56 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2C010E1E4
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Feb 2023 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1675355215; bh=dKsVqu8/jP8GKg7WdcezF+X776+Ykduyoa0mwmZDguE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=GhHsqZHp5tzZ2XaqHOX3VSbUm6+9VY7oQRdyygA6YeIgk8qoJZo001vbi57DVPxeT
 e79GtX3gPFHByrvXwUIXr71qQmtCW/rgHhNdz4+ntizXcwzkwPXX2ElPt/AnE0udyI
 mAFtf7TLLskD4fsuWspcXL5acjdnyrNhbmyhT5PQqGV7OlHsOs+z4d3Oi6n977AFrn
 26oF0jyvFCo+ayuR7Oe6Iwc8sqAAkI+Eq+xCaiojcicbd+IFMRpwTS6JBGRJnGP8oY
 F4TibfG+NKjEIaX4Et9AMbkjX2ufjNsIconc2CA76NiJr+iIQUTF4jTNs9DdFlaPFn
 U5LdPaXbXiS3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.119.13]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My36T-1oQJkX3v4R-00zTtP; Thu, 02
 Feb 2023 17:21:51 +0100
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use the TGID for trace_amdgpu_vm_update_ptes
Date: Thu,  2 Feb 2023 17:21:03 +0100
Message-Id: <20230202162103.5811-1-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:krPgoiCu+/zEsea1XZN6X28O1In8HkzPXbCblxJkSP5qQpcIk88
 9lW8iNRAt5la5PTYru8ClMbGPhb/bUtw7eH8M7mno8cfCldo3xO6rfwulpH1CHOjDOhrqKD
 JHxmRGpwRRzkg3Mi5A2m4tZztW5Ortijm86ZU2mmkwW3GLF0/bGXb1J3OXXa4ZHjYHz+J3G
 SmWbV+pqgvksHsnzjuqIA==
UI-OutboundReport: notjunk:1;M01:P0:OxQVGJJ5WTE=;iwJLmILcK5xQLq2J7a8UbLbG4vO
 t0vVDgEGnBI3u7FqQMTz/mi/VwJto6yd2GDKNHhUVnvnpQzS33SeUQZQcuH0iKBMCW2PkzPVD
 VwQzu0wyO7BxzTAe0WsRtHE0ImCvDRbdyWEqEi44Tu9wHis228AFqpm9tmIr8PwJdWHfOZV9w
 NF3IuakDbbBhZUKubhg0ctosJZGZy7S++i38Wwrr5ca1imbKSy0PLIQkMTjxDZ32a8CEcllro
 47NVtmNYuuO+pVOzPAs2jHXRhDDsOuF/kLeoBuy0e9RrVVAOi5cviQaBVOMTeyDTRBFowhBFp
 I5+eSNIhDFyQs6Wri7isCMzCjKO6/6NMa/6eT1bKRliGgHHVvBBoYVHCJsI39wasxDiy+2b1H
 6Uscae56jYdAJWfAco16ziX+N3MJKzILWkDJ1TUhsKWnUGycriqJavvp1uON/40JcgNec4fda
 FpRCkkguSqtwJkwO8fodHnIvr9iv/EEU8lW8gO3Zf8a6o9eqs59w3DD6ibFGhdSFVxaQj2Y5z
 apgUhfBv3kW2jL/cg3fqndIYsHv8AH3hJKflMiqPGTHE5jygjmdnPRdmGGISfTU55ixyRFqAL
 f2Nk1erldPkXrAqdSHQqK/udfoKRRaZJzOYwouSLxi9yrxGF9p+k+YUhs8uYyQVOwobMeId/y
 BOsP9bpFyCveIfjNRszW0b0vSwP4EwJ/8/ufx7kyQbusV+8kUPCJRyLOOzR2/kkdjV7BO1NBR
 2LU8lykvL3zxCdrBU1h2b1klxfdx/N50OhpWjMuearTTXUQ+WrezDuiA46ypfHIU3WaFDoKmj
 +MFP40tJ70p39sq27vpdecqa70k6w1li8RKNQz4IqmdF29glinqhliARlYepEMS5a01B70IEe
 upS23VMvWdccP+62ns6MjW3rcHlLfzksA62/k05nnkJxmqaugGoCT+ucdOiHw8r4ZjtVgAxSr
 AIiqFUVCV1AxhcZvFzZsNm6TyZI=
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
Cc: Friedrich Vock <friedrich.vock@gmx.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The pid field corresponds to the result of gettid() in userspace.
However, userspace cannot reliably attribute PTE events to processes
with just the thread id. This patch allows userspace to easily
attribute PTE update events to specific processes by comparing this
field with the result of getpid().

For attributing events to specific threads, the thread id is also
contained in the common fields of each trace event.

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm_pt.c
index b5f3bba851db..01e42bdd8e4e 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -974,7 +974,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_para=
ms *params,
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    min(nptes, 32u), dst, incr,
 						    upd_flags,
-						    vm->task_info.pid,
+						    vm->task_info.tgid,
 						    vm->immediate.fence_context);
 			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 						   cursor.level, pe_start, dst,
=2D-
2.39.1

