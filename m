Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F72C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 16:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7811A10F409;
	Mon, 29 Apr 2024 16:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="np7o8eN3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8698710F486
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 16:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aNlsnhlFFohelWOOrwuCgUIQCdBYw5G4xgDGBYQuLQk=; b=np7o8eN3F35mcYfXe53+DVaNys
 zzvXGxLG7TN6qq15BaWY//0IJr9m/dhHNl1qGtsD2JYA7yo/v8RDpnVsZwd1hUosWDaDitTDH9Puq
 X1798D3eby9jxIo84Mkt9JgDYygJ46eBrtSbkoJ8G70QH+qlcup11F7QcfHxnE6sCJoMIexG+n+LN
 tgCSor4MT5h5o2fx619y8MeS6bz7YWxv+kTn5NS/WlevvKiFJiKy/x3n6PdM1W8VV8VzFJHomLEKH
 QE+JnqkRDxq7nw/Az6bf6jxH9yb/yYD1DI+71AXQ5Smzzn6AJLJuVuUYe7ESTAdqhjIjsRnbFv2D5
 iS9LdoDw==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s1U9n-001Nw8-Uv; Mon, 29 Apr 2024 18:47:11 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Describe preemptible objects in debugfs
Date: Mon, 29 Apr 2024 17:47:07 +0100
Message-ID: <20240429164707.49196-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429164707.49196-1-tursulin@igalia.com>
References: <20240429164707.49196-1-tursulin@igalia.com>
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

Instead of mixing them together with regular system memory objects mark
them explicitly as 'PREEMPTIBLE'.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
---
No idea on the name to use.. :)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index eb5bd6962560..be6c2f5b9fcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1599,6 +1599,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 		case TTM_PL_TT:
 			placement = "GTT";
 			break;
+		case AMDGPU_PL_PREEMPT:
+			placement = "PREEMPTIBLE";
+			break;
 		case TTM_PL_SYSTEM:
 		default:
 			placement = "CPU";
-- 
2.44.0

