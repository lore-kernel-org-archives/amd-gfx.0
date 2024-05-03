Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB17EC25B4F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 09:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E952110E551;
	Fri,  3 May 2024 09:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="m5g0O6fJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 427DF10E644
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F5Jjsf6L5e6gu/GOqTMxP/sUj7SINu6NJHzC6p2eyqE=; b=m5g0O6fJ7Q4HmaWcfK/0uZaSaS
 MPWMVVAB2xz1BSJ4NQ1Bw4p0trXfof3Orv7Xk50bW494l+PCg8fmGCDann0EPdoIrnoanuD+jycpx
 fBoxM+ucR++wZN6KdJc0K/VNErU8Ze0yUykq7KD8sHCcOZTOn1QpRhMmSSyVVScvhlv3cdL0DPS6k
 rMTl2zLrxLZ590zMG7IG7zDksg43N+nyxKSwpMfiCwvwRtu+knw0MDARiNCvm56gaNfTbhYW/BqR2
 lc5q1Zb6MxeQzvy23kfcHsXqVGvodlIWok0Aaf6Cv+UrjvrYyZwms5KG01jP5Mmg6v1bavjJ420ug
 qo2ffgUw==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s2p0U-0003eS-VC; Fri, 03 May 2024 11:15:07 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Describe all object placements in debugfs
Date: Fri,  3 May 2024 10:15:00 +0100
Message-ID: <20240503091500.7768-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503091500.7768-1-tursulin@igalia.com>
References: <20240503091500.7768-1-tursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Accurately show all placements when describing objects in debugfs, instead
of bunching them up under the 'CPU' placement.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4f9073dd19eb..fa5227a4aac2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1612,6 +1612,21 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 		case TTM_PL_TT:
 			placement = "GTT";
 			break;
+		case AMDGPU_PL_GDS:
+			placement = "GDS";
+			break;
+		case AMDGPU_PL_GWS:
+			placement = "GWS";
+			break;
+		case AMDGPU_PL_OA:
+			placement = "OA";
+			break;
+		case AMDGPU_PL_PREEMPT:
+			placement = "PREEMPTIBLE";
+			break;
+		case AMDGPU_PL_DOORBELL:
+			placement = "DOORBELL";
+			break;
 		case TTM_PL_SYSTEM:
 		default:
 			placement = "CPU";
-- 
2.44.0

