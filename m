Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059C9C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 17:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67222112D6C;
	Tue, 30 Apr 2024 17:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GtuV53aT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E16112D66
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 17:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VNCVoxQIA5jo8px2LDXOR63J7jMf6MMpDTMoZfjjy/Q=; b=GtuV53aTu3TIEBEN7N1lBjpBEg
 csHwk5dmTjo9yCR6j4WZ+URB5ss/k+/IPPoxqTUhMOE3qAkBJlW48insncpn4tjgjmXpAhQx0LPnC
 Ks7swCHcO4RYMqp8WQlXMtIB8srhsh1DnwkRuk8+bQsOghvrVr3Kz0Z3P1xUN09OX7uxxrlA+UggD
 Zj71MBGRTV3t85Tm7vYMI6Luikj3pVXV/pXG8GrwCyrG2Tb+lm7nd/ME7cPs9NO/Qg5GjfINVcAzo
 DviB2fJan6Osp8LD03W17JF0eHhms32WYoSczNDh47bOnFHk/eVDctLLL+mjO9QcONEEJ14Y/EVyJ
 j8VhqxBA==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s1rGk-001sRa-Sj; Tue, 30 Apr 2024 19:27:54 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 3/5] drm/amdgpu: Skip not present rings in amdgpu_ctx_mgr_usage
Date: Tue, 30 Apr 2024 18:27:46 +0100
Message-ID: <20240430172748.61576-4-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430172748.61576-1-tursulin@igalia.com>
References: <20240430172748.61576-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Avoids a tiny bit of arithmetic and more importantly walking those empty
arrays up to amdgpu_sched_jobs slots and amdgpu_ctx_num_entities, both
which are pointless if there are no rings of the respective type.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 5cb33ac99f70..b409395f6e0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -979,6 +979,9 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
 
 	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
 		for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
+			if (!mgr->adev->num_ip_rings[hw_ip])
+				continue;
+
 			for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
 				struct amdgpu_ctx_entity *centity;
 				ktime_t spend;
-- 
2.44.0

