Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91572CA5FA0
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Sep 2026 13:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B7310E5DF;
	Sun, 27 Sep 2026 13:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="erX0SCbx";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 078B110E166
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Sep 2026 17:16:32 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so9678705e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Sep 2026 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790442990; x=1791047790; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q2t4bvCUDvNXEUFZCKABDmLjetOn2pq0VIPxJ8jyYis=;
 b=erX0SCbxsrtD/2Y7diqT3d8jG44Doh7kGV/OG7e3YjQ4terEln3cFwO0slgbgk1hCc
 yB4E6daKuHTByiSyxpvHfHhzgPUBPTgciPRW4IXupe527xIPYxWqvA0RZIZF+3BfUUuX
 7uir4raCxQzfu4D7IJF0mHQxek/eJ401xH0xdiX+B5ilx9HHrMcNYfz1hk8Byo7P/L1c
 02qsDYjA32BLCseTFXfFmQzJ3zaU1HTV+NqL078ZP5lbqWBdQ+ajdGnBbegToPJBtAdh
 9f2NFssGl43211MOBUcZkcIHSdUTVQZgNBv+Mwpi3fm9Y4ZclxeGZQ7EWGfbLBzAWadG
 L0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790442990; x=1791047790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q2t4bvCUDvNXEUFZCKABDmLjetOn2pq0VIPxJ8jyYis=;
 b=0wRSD1ylpPLLYTgHkGuGvoErphyurGs2PEMMLwH0yN4bEXFW0mH5vzPhXaN6T1IP9u
 /qYITz1esf7E7BzFd5xkqX3LLS404nYPSXjKa3HBBj7LKgZ/VjdpDMzmCChl3TVyQ2oD
 cQobnJq3R96PIseVVmXpNzczBVsJ03QU6JhM34hg0eGuR+k4rcwzN1Q/0FywNcdGEwDw
 T6OwmZDHQaR+Bgf88n4IFMORCDMmUdv0/SMC8EzG7lYMmYFYShZ6aHYSatC3aDN/3foS
 LNVSwKJpbopyRbpBv9Cr5vCk8jMtNEi8fRNWvSPtee3Rc+ur2Qo3Q1PlAqkfPSq6LgQA
 Ci2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcpk0Wfn7FpGzod3KqPF3/dG8/Wy08tZvHY2qbJu0oNBRgCK6XRGYxt7Xop5Kxv90fa4tmOCqN@lists.freedesktop.org
X-Gm-Message-State: AFuF++nfh/JGLflOAFY/6lgVdjPXT7iIITSQFxYPxHCM048TpT8WmkiM
 kIiuELeKH2I43KSohfp6TzBWKLYJoUjmk/ImbGyTdZcKASoVjwuiL5tS
X-Gm-Gg: AYBFou0vHffxQD0lMxJrCxGmezpKv5NsTCXu/DsyqRgb1IIWh5IYvYC0uG7T+IoFUVa
 PeujdHMjRF8K4lucvCPGdxnIzF4OAVCOAuHK9/uX0bL06amNjsGLnqLBFciZUlMFCRRYls19rWx
 Opf+LEVvOHofhASMjjepyCEcgE89G43sBR33eeAm2xY+YfdqyzJ2NzXfZqyB20qtCShu8N4IFNX
 X4+YxYbkF+zRsyawqy9yxfJ1rK/mzeGy8hwZjb1PZ+18yOo5gRRkDpF8rWEEqKBBo1r1CZw031d
 zkf/VbwsdyQzAs44lSgyMRQyM+j3YUkxFJaVno5D38yk0BxJzOK9QiuXmF69iet8FopNaOlU0o2
 Nnc0hY2gZvEcWMP8MvKbguGjo5KX/CK5Bp/Sf0O+MvA+2Ol7qoNHI/N3GERt88GzDDj7VoWqnPe
 lYs4tXSh70RMSJ++3d4nfFTUjxSNMOm2nV+pPBSzXO1S/y84Dzxyn1NXgG4/MVMGlSGOs6r6drD
 vLdQxcZ13blOwlUMuNcyGfM9zJGn6QMV+E5uxrynJOJynwekDVaAgqWW3o=
X-Received: by 2002:a05:600c:4e49:b0:49d:29ab:540b with SMTP id
 5b1f17b1804b1-49fe66cec31mr154272065e9.15.1790442990051; 
 Sat, 26 Sep 2026 10:16:30 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff141948dsm57753635e9.1.2026.09.26.10.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 10:16:29 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Carlier <devnexen@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix NPA-REVOKE racing an in-flight UALink import
Date: Sat, 26 Sep 2026 18:16:00 +0100
Message-ID: <20260926171625.288519-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:26:05 +0000
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

The exporter records an importer when it answers NPA-REQ, so it can send
NPA-REVOKE as soon as the BO is freed, before the importer has finished
building the dma-buf for that handle. The revoke handler assumes a fully
imported node: it dereferences imp_xa_node->dmabuf, which is still NULL
until the import completes, and drops the xarray reference the importing
thread still relies on. The importer then links the node and marks it
READY regardless, so the node can be freed while still on the per-remote
list.

When the revoke hits a node that is still NOT_READY or PENDING, only
mark it for teardown and send NPA-RELEASE, as nothing has been handed to
user-space yet. The importer checks for teardown under the xarray lock
before linking the node and marking it READY, and unwinds otherwise.

Fixes: 7cc82cd90d35 ("drm/amdgpu: Implement mechanism to revoke exported memory")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Found by code analysis; not tested on hardware (needs two UALink-connected
accelerators in a vPod). Compile-tested with W=1. Applies on next-20260925
and does not overlap with Mukul's "UALink fixes" v2 series.
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 30 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8411ea17172f..90d2a525ff5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3265,6 +3265,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
 {
 	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
 	struct amdgpu_bo *bo;
+	u32 node_state;
 	int r = 0;
 
 	/* Remove the entry from the Xarray. */
@@ -3288,7 +3289,19 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
 		return;
 	}
 
+	node_state = READ_ONCE(imp_xa_node->node_state);
 	WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
+
+	/* The import is still in flight: the dmabuf may not exist yet and
+	 * nothing has been handed to user-space. Leave the node to the
+	 * importing thread, which sees the teardown state and unwinds.
+	 */
+	if (node_state == AMDGPU_UALINK_NODE_NOT_READY ||
+	    node_state == AMDGPU_UALINK_NODE_PENDING) {
+		xa_unlock(&adev->ualink.imp_xa);
+		goto send_release;
+	}
+
 	list_del_init(&imp_xa_node->list);
 	xa_unlock(&adev->ualink.imp_xa);
 
@@ -3299,6 +3312,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
 	/* Drop the refcount for the node */
 	amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
 
+send_release:
 	r = amdgpu_ualink_send_npa_release_msg(adev, remote_acc_id, handle);
 	if (r)
 		dev_err(adev->dev,
@@ -3760,9 +3774,20 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
 		return r;
 	}
 
-	/* Add this node to the imported handles list for the remote GPU */
+	/* Add this node to the imported handles list for the remote GPU,
+	 * unless the exporter revoked the handle while the import was in
+	 * flight. The dmabuf is released with the last node reference.
+	 */
 	xa_lock(&adev->ualink.imp_xa);
+	if (READ_ONCE(imp_xa_node->node_state) == AMDGPU_UALINK_NODE_TEARDOWN) {
+		xa_unlock(&adev->ualink.imp_xa);
+		dev_warn(adev->dev,
+			 "IMPORT: handle:%llx:%llx revoked during import\n",
+			 handle.handle_hi, handle.handle_lo);
+		return -EINVAL;
+	}
 	list_add(&imp_xa_node->list, &adev->ualink.imp_handles_list[remote_acc_id]);
+	WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_READY);
 	xa_unlock(&adev->ualink.imp_xa);
 
 	return 0;
@@ -3938,9 +3963,6 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 					"IMPORT: XA import failed for handle:%llx:%llx\n",
 					handle.handle_hi, handle.handle_lo);
 			goto cleanup;
-		} else {
-			WRITE_ONCE(imp_xa_node->node_state,
-				   AMDGPU_UALINK_NODE_READY);
 		}
 	}
 
-- 
2.55.0

