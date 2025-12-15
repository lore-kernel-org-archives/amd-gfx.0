Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7877CD59D99
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 01:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC97610E028;
	Mon, 15 Dec 2025 01:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YzMKYA5I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3518510E057
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 09F21442D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BA4C4CEFB;
 Mon, 15 Dec 2025 01:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765761153;
 bh=Lw/gUZF0bA8kHOkUtbMyHskcVdjdGhOgRz6h4nGm8I4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YzMKYA5ISEq7TrfVj/TpgdhKGRZWMjZ7reB4DFjhyDh8GJU9SEXXi+XlHPJVqAMr2
 GJGJaftg3n4r+PlTmnGjDoZDVv9hJIOOBGg4WCL16BSl5hJOy2OiQclVTDqOcYiVz7
 oVLIMiYlVRxbaK+M6uB9JZoiA6Z3p/H6Jd6taLaYmOzS38+f385i5DlU5MyzSSSBPp
 IocHXDo1GU3khhqQxVzmsdr63ZMDr5KW1AgZejTXN9jQZIAt4nYPYDCJVKbjP6RUIw
 Ma+yCbq4xb/QOUVy34SFN18ySZ9hWySKw/bqf8AHmNInkxJyoTQsWaEvfkMREycWEE
 2+suBOPnzg1xw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 2/9] drm/amdkfd: Correct the topology message for APUs
Date: Sun, 14 Dec 2025 19:12:20 -0600
Message-ID: <20251215011227.161597-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215011227.161597-1-superm1@kernel.org>
References: <20251215011227.161597-1-superm1@kernel.org>
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

At bootup on a Strix machine the following message comes up:
```
amdgpu: Topology: Add dGPU node [0x150e:0x1002]
```

This is an APU though. Clarify the messaging by only offer a
"CPU node" or "GPU node" message. Also set the message as
VID:DID instead which is how other messages work.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a0990dd2378c1..2b8455d23ed19 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -931,17 +931,12 @@ static void kfd_debug_print_topology(void)
 	dev = list_last_entry(&topology_device_list,
 			struct kfd_topology_device, list);
 	if (dev) {
-		if (dev->node_props.cpu_cores_count &&
-				dev->node_props.simd_count) {
-			pr_info("Topology: Add APU node [0x%0x:0x%0x]\n",
-				dev->node_props.device_id,
-				dev->node_props.vendor_id);
-		} else if (dev->node_props.cpu_cores_count)
+		if (dev->node_props.cpu_cores_count)
 			pr_info("Topology: Add CPU node\n");
-		else if (dev->node_props.simd_count)
-			pr_info("Topology: Add dGPU node [0x%0x:0x%0x]\n",
-				dev->node_props.device_id,
-				dev->node_props.vendor_id);
+		else
+			pr_info("Topology: Add GPU node [0x%0x:0x%0x]\n",
+				dev->node_props.vendor_id,
+				dev->node_props.device_id);
 	}
 	up_read(&topology_lock);
 }
-- 
2.43.0

