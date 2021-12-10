Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BA2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD3410E5A0;
	Fri, 10 Dec 2021 23:33:24 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459CB10E58E;
 Fri, 10 Dec 2021 23:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639178652; x=1670714652;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8QsQEKSxoLGHydWZTS5T8WXMzBP5ZWfGvu6Ze1y391U=;
 b=Ey4W1cFPxfTiPAPSO1axv1Wr/VRxcjsdvzADEfY1UdD4i5Ohpn1DWI/P
 3FASgLeStwZlVVMl1rYRxziwL6VjlT7lfbkwJmGO1Z1WVtrfMN3QN0NF4
 lCukREHp13kGK56v82pLpsm+Hsal+OViuAxJ6fB/miF1YyUyBLLCyZpCN
 jyymw4nsTc8OhPaYJ6Zk30Sla7oYFB4ARHuhQzesw2h1pvBpXkiDh0tT1
 G+nC6uNsAKWHohRzUWemDmIIrkMMulOCzy8cKU4ZQnINq5UtoRCUaj2RQ
 EH6qJ7ZD/ZtFTNtVTewapKbCFDuKlmq+op8WIocsxaVmbRJDnx6sgKb0W w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="237212382"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; d="scan'208";a="237212382"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 15:24:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; d="scan'208";a="463861476"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 15:24:11 -0800
From: ira.weiny@intel.com
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Subject: [PATCH 6/7] drm/amdgpu: Ensure kunmap is called on error
Date: Fri, 10 Dec 2021 15:24:03 -0800
Message-Id: <20211210232404.4098157-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211210232404.4098157-1-ira.weiny@intel.com>
References: <20211210232404.4098157-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Dec 2021 23:33:23 +0000
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
Cc: linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Ira Weiny <ira.weiny@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ira Weiny <ira.weiny@intel.com>

The default case leaves the buffer object mapped in error.

Add amdgpu_bo_kunmap() to that case to ensure the mapping is cleaned up.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
NOTE: It seems like this function could use a fair bit of refactoring
but this is the easiest way to fix the actual bug.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 6f8de11a17f1..b3ffd0f6b35f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -889,6 +889,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 		return 0;
 
 	default:
+		amdgpu_bo_kunmap(bo);
 		DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
 	}
 
-- 
2.31.1

