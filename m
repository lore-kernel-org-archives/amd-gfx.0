Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B2BCA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 09:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B2610FDE5;
	Fri,  9 Oct 2026 09:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DKfQ/6wY";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3509B10FDE5
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 09:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGrODc7jSZhYNUZ4aOVfqeLjjYrI8ua4U4S/DX1GViH6Z+NndAdqFJKJ48k12Est2d4mtd+Tn6YINkHp+baKpOrdj6izcyys7nYtJcxJQQ9nOlIXYnESVGrr3GYgp9g4SxGNWSkUx7RadqzffcXKOFaDh1zkkePbJkmdmJnVdo2H5nWwBvvzZ46hYSt/BIkg/4Xjbq7If7uBd9YsF+VMsemxb1/ESDQxNwK6T0R8x2xuUW6NiQvfNeG03/UhCswDBAK57Tl6X6tOpvF6w3jKNZTtCE/FXhRwfttoULAllyTOQDkA6eQuiPv8naSfnFAnwK3g6F8Zm0LmpHanYeaEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGdZ3dAIGiyI0tWLixd7hTpMnhYT3ANqdL7Z+5h4DU0=;
 b=kunb0tDPMFHwDmVy1OWuv+uYqbFJTG3tJZLnZl/o91J83skaEWzvLIaE3epbLSM2R3TQ0wGRCrbhTtM7i72LB8avS9KUQwwz2X8xs6VsrVJ/4A7ja7G2mNfAcsUXWx7WDmZYRGJckxYoNHx69v/kKdUKbzABjKPncToLQr/h8ptnA9m0HZ29qADkLSLrEsNASUPfjs/ZKP+eUyBbgBt9fsd+UFIKqJHJSKl6OKzwG5NSWzK4j6PtxsPnH1k9hJjwZ+jfUoH3DIRmJyDvz4ZkrO+BWS82wubmdQbSsgNhpK3yrIiVS0dJPf+w7EsvqxwXinSSRY29jAxs4wyKZOYXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGdZ3dAIGiyI0tWLixd7hTpMnhYT3ANqdL7Z+5h4DU0=;
 b=DKfQ/6wYNNgNZTroM6iIJu22dt+LBlNvq+TvdOpaCH/ieAGH+ZqKF2DBjvywBidMTAI/DjMU0Q+YRWPB5JZ9C8pbqDCDk+/mKV/LBCoA+Qy9v/v/oD3Vu6XDfyuIa1SUGQRB2VjundgwoDXCiHtCxJjGMslNmdKcWCoQoCjbOyY=
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Fri, 9 Oct
 2026 09:08:44 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::9a) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 09:08:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 09:08:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 04:08:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 04:08:27 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 04:08:25 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: don't drop the runtime PM reference twice in
 amdgpu_gpr
Date: Fri, 9 Oct 2026 17:07:39 +0800
Message-ID: <20261009090822.4095122-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261009090822.4095122-1-Jesse.Zhang@amd.com>
References: <20261009090822.4095122-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 34522cc8-c79b-42b1-899b-08df25e4eae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sWbAr4VQinw8UWETVnuuk+QAK1aoCv2GQPNV/2iEhnZFnXpR9SaKRyKm7H7nFlBQYsoBzCkFkm0iPrUKO2rY6aWeTH5IOf47BrcrdcMhMF5FV6ycDC4EgFm21hOmeiMRsxQH7tK7JJWM2tXx5wqCBkNfegPiaVToN5TumyA/9JPVqbEWqEJFnb7WwMqVZGgNwMTENpHAa7Vv3+Y4CI6ZMFOuvwswBKD+TDCrxB2RcIz7E8vu70oVxHBFz8/sERyjKIxM1E6tg5goivBNhKrq3Mz1iHIIxdD25fR/3l2o0K86kHx2kej71DJyiWwhzR4YA8FTgXWxV2NSITPwMkCge5ywrb3gDZpR7N1PPojDd7qoza7z6P6XbhNjV9uqczGIrCXDawqYR3hiR0KKnYknbCvjOS5bSo8qhdMS4292/uNlsPN0o9h0da7EL3tU5wMOMBfySw1xUvQc5nJ7fHmMwsr+xwq4i6dDkT6qk5QVPBVe/Q1RDoqSlGkJ6Ap3ALd2ViGIO9pf0P3Jzcvc64zkIXyo9rpHbZhwqqyDt54z0T4pwPXtkwM3SNS/SqcgSL/Jysm4Sps65nWjv7x0T1TklYth7UPbhD6NykgbFy6gntLm0IBq2mo5FuRIbpPUTMx8kA0KVZLVV82DXA9LOTwzjwQqYc9H2ZlzQmZpIYxUtOJ/ilRtWwB4/VOX0k4DAVGsTyHDbnzfQ4ZA0zrmmnP94A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +ybDJeZOtx8U+657HcLisshGOuDYt9PrgpZCNDKubHy2EuWKpbqVEBxPCUqpZLStkzD9Fuy4BJitbAUR8xPXnyW1ZIF+R7uBbe3gvJQ2UYKPwYCsmikVYm/neaKSjo7TdgLX5ap45Lp9OkVNFm0VYKSkrF/tMLzauhKX2ZR8fRtbTWaPGqWGOJYxd/i18icg4oPChXXjYYy/O4RCP7yiENNZNIZYyghYi0Eb5Wnk7Ep46aJ59vu0DABUDEAc12HKjG/tvkeZ9sQENU+OXPC07rcMRz3x158UWaDY1GTIG5bTrRgx7/9sQf1j//bBOJscWqYLZnYw0Aib2gv0647CFJSWOQdQLB3Fvaw9hplBn0XNxA9FRiTqoXPibaE9cDN7BLz6Yfbat/y9/5IVrgNlCvgK7I3OJarmuVQKk5pVX611rbqY8DDQZ8wy6O6FRgKu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:08:43.3135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34522cc8-c79b-42b1-899b-08df25e4eae5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
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

amdgpu_debugfs_gpr_read() drops its runtime PM reference right after
reading the wave registers. When copying them to userspace fails, it
jumps to the err label, which drops the reference a second time. A read
into a bad buffer on Navi31 either steals a reference somebody else
holds (power/runtime_usage goes from 1 to 0) or underflows the count:

  amdgpu 0000:03:00.0: Runtime PM usage count underflow!

The registers are already in the kernel buffer at that point, so finish
the hardware access first and copy the buffer with a single
copy_to_user() instead of the put_user() loop with its own error path.

Fixes: 9eee152aab56 ("drm/amdgpu/debugfs: fix ref count leak when pm_runtime_get_sync fails")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 35cbd358c28c..3dc95d9accf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1267,7 +1267,6 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 {
 	struct amdgpu_device *adev = f->f_inode->i_private;
 	int r;
-	ssize_t result = 0;
 	uint32_t offset, se, sh, cu, wave, simd, thread, bank, *data;
 
 	if (size > 4096 || size & 3 || *pos & 3)
@@ -1311,25 +1310,11 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_virt_disable_access_debugfs(adev);
 
-	while (size) {
-		uint32_t value;
-
-		value = data[result >> 2];
-		r = put_user(value, (uint32_t *)buf);
-		if (r) {
-			amdgpu_virt_disable_access_debugfs(adev);
-			goto err;
-		}
-
-		result += 4;
-		buf += 4;
-		size -= 4;
-	}
-
+	r = copy_to_user(buf, data, size) ? -EFAULT : size;
 	kfree(data);
-	amdgpu_virt_disable_access_debugfs(adev);
-	return result;
+	return r;
 
 err:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.50.1

