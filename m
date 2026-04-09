Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7A0EA3C48
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 10:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9BC10E788;
	Thu,  9 Apr 2026 10:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B+iehYBE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66DD110E788
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 10:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6NnbcT7qOOkF4CjCws+ueLX0jQn4akzfehmzM93QCC88T0YZFbatO8cfcCYRzx//gaxHb+FqxDUilro/0iFHbIcc7IKY92mmsGkUn5PbzQD0VHlFjv77EJuAzBYzbZVBnidkrqnninmc1asRZBLBVCDddTTSFMcBnGBvfDJMbCEWg54aFJLeF9wVjJg7MiA3756Mn1iyDIvxGmblFVDiUH3fMOrYA/dsaPMavbq7BlpAP1d59dEcRFHtp9qEqZBua5JFT20/8QjLZ11ysoozldzU2wJW1ofaX1wDcq5rdSkHtw5w5zw16ebQb2wZvdgsu3i9gEU9naYwohz92/bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/rW907JCl7izBTsZOoI3TMeBMz0IoLCsJowEPjZ/AY=;
 b=JEMNgEChh5DRtXhVC5Fq3zQQxTfeEO9scchON9pVBnV4Ie/1OZujJqmzZsA+DVks92bc7dV7Y34wE7ZZxefM0g05623HXBlh5dFKaLqLuzZejKy2kkY7z0SYTha8pJm/ywLX33APXB/TewhSlysWmi0J8nNcm9JHTslR64Ir0oCfLwUPYvetD/qN6yEfeW1AHY6JJRON1x4TjJaKGfhCftICGy0rVbOHDoeE0enC1mzA35w5nvbfaKY4qx1cBh1Jnn0azZaB09VVcTc3Bftk7yVLgNCtyb+YFnMk1K1APRHppO22XFVRkwqDzV5L0Jxap4QvulsQsB15cfo0gh1yTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/rW907JCl7izBTsZOoI3TMeBMz0IoLCsJowEPjZ/AY=;
 b=B+iehYBE2mAc5GmkkCHtzpuPp49x/fvrwO4lxVj2nMowLAS9ZrgbAQ7g0/hqNVchofR9jSqmUespPZMYOimYD7LuFwGv2/5F+njHlMYHADgn3hxr9QX6qKDpfEaanBnuQDByH+IVvjfjZfg4vaMSovnNfcwPSh8+NH+La2jswxQ=
Received: from BY3PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:39a::33)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 10:41:24 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::fd) by BY3PR03CA0028.outlook.office365.com
 (2603:10b6:a03:39a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 10:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 10:41:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 05:41:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 2/7] drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
Date: Thu, 9 Apr 2026 16:10:52 +0530
Message-ID: <20260409104057.2284155-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409104057.2284155-1-srinivasan.shanmugam@amd.com>
References: <20260409104057.2284155-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb33722-3643-44ba-d12f-08de96248b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kUdrahA2iz9SBa7EN3qnITOuDBlDXI4atmM3Kbca48Kwavka98IxYxA+Rcgti/ohtgjRUNwXj84FNQq9UYD/82RErpOcAA05wckmrSzjRO4eCtXhVlzStyxWdEhvVLzgjwjsYOpUFbUMFchoOenHGoQAWkp1OSDsptzH7wZjJREJFjytbwTEovKrbmQvJUr5fLoS2TBynwqGPanJvprr6QcJDq9ReCe1Tpi5z9MhCNFwgEZ0+Mj8ZQmT4/bfjrEQYkx+r7rvOvz3oCYQ20WprK1rMmQhnrR5j8igv3eLs2FhbEmKwdoaONsOEQtvObU5/BuSYS3XTcYsqP+C94frorNoS3L715WxdwKZpEqvh3cQPsvegHgs3hKtOPzlaNW4rMXMp50PqoWrcYKgH3ycQiY1Uv7q/l8mCm7RzBkodLMF7S2diTGW67gKQihZCuUapXCAOWklcUMgowOC2AlnvTUlhX/aduq1Rb1BlVpZ0FHj5T/PKQC7QAXtu6QupjJxoeONTXKFUSWvFzAG02Omh60clREIqLOVFkSY1MWIs+MDwCY70RVGs2Gm/2WQiZ0UWaXOpARGfZPKAitiinEF+AXjAzcq2g889AnTJGdC4dRBvJtdNi0uJJrAjjz2TD1SsrwN6iiif6Yuk1m4n6PRfzCmlfOzcJyAI1HRIMPulPFHTJ7KW4cbi1+cdJ4b1rxe9jOVc9XpeJpH/fY5XzUsk/r9z2U8saPF4vCqDgr7fd6yb2+MrfS5YVKJwyaPBlQ2o6b7KvrtSA5Qb2GXLtb5+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xp7ZQVDNGrT/XuOfs5mefPWWIrqjbu9a/xZmb4NlrO92WLTS2rq6BgJi42+/ipJI1KEdZNNrD/xdiBUghiuUyRHltAUoXSDf9IxxwJ/Q4cUg4RL1YHUWA8xU22dqxOSQRDAJlEy/taUnu/fLpDSOPhrBOAWTAGpp7j6bhPy+rN0iLSTrmhi7aMR1fcHwvM0R0ImnGV2OWJ/jGleH2cLxTEBdX+jfQPAzl9E9JAl+pVowyzP1kZkw5Tl48/NIj9YLRlmDSxWVm1xHSgsMGLY3n1IYNK0s5TcxnHR2UPeCP6Go8NK5MSqdT6YMBH0YIeV3cPfxsZF28cyNhk/3UA7NFoqT9+Pszb9k2VcPZZ6BP0BQdsLG1cdanyra/zuN+JtaNKJ4tr5Ea4cFM9ANYSJI7GXFpmql/xTairBYAjWvq4rhVDXT9Wb5uDs9gpnPezOC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:41:23.1767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb33722-3643-44ba-d12f-08de96248b4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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

Tie the eventfd manager lifetime strictly to the drm_file (amdgpu_fpriv)
by embedding the manager instead of storing a pointer.

This removes the need for reference counting and avoids destroying the
manager from IRQ context

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8bc591deb546..9001ac4eeeb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -104,6 +104,7 @@
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
 #include "amdgpu_aca.h"
+#include "amdgpu_eventfd.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_cper.h"
 #include "amdgpu_xcp.h"
@@ -454,6 +455,8 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+
+	struct amdgpu_eventfd_mgr	eventfd_mgr;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d88e4994c8c1..7df0e7fb2864 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1469,6 +1469,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
+	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
@@ -1565,6 +1567,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	/* Drop all subscriptions before fpriv goes away. */
+	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
+
 	pm_runtime_get_sync(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
-- 
2.34.1

