Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31658C9830E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5643910F14A;
	Wed, 23 Sep 2026 19:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o1P0G53H";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012036.outbound.protection.outlook.com
 [40.107.200.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F3410F12B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hibRFNsteeHDcQKo6AUVHppuJgb9Kv+f/sl1STH0gyDSQ/tGf7yrH/4CaLWKCO6rtpQY53ou+/tm3N3lTsQoFp8u6o7tS+BukeTaIepYnnSFjG2tewEq+EX5D3EO9UbQANG1/kFOLnzq1guCW0/h7jalngqZUVPDhdFinOAcZd7C0i8iSIhGA4j02aGiVZIPQGHZvLjqxHBTUWeC1k9eM/okS4uDryR8QfXmAS4LPj2oihQzr12Hx1n0Kcej7ZnUcbLBHSjmn5JmZC16GeId8rqVkPugxg9z/D2b46jL93RejItDvXqd2+EAqNCcbvdcfbBmBcsX2XTzdjuJLzDwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwG+ZFuAjT3eVpL5CPx3xtWdbYo+a+7E0se344BGoac=;
 b=HzsAk1DDzNEfFJ2Bw203tivv0mhxaa+zM0KCUfJ9WQ/RR+OmMRYbWc9aDe1rt+RVJ2ngHDqPo2e1w0n3hLmoC/GZQDWpUTY1yw8T7wnxO1JMB2pEK4IZptVmIz8AczzHlqSr/qePsp8u9HPBZp9XKUpgUqR7eNqArP5oWjlOMvuo0BVV3qakJ5BVjyu1uMFthdiOMf0x7Yrhypv+9lS4KMEgzeG5s5LCKFNJSZvd/Dj751hcFO/9SWH5fgod5tSeKB70urWfPHaNmVxIxPDjuVQu7Ps0R5PVg7PrOxb/5JQoFYRCVXqFQaW6AZ0P6BwnMKi0+2goHrWzLkedBuA2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwG+ZFuAjT3eVpL5CPx3xtWdbYo+a+7E0se344BGoac=;
 b=o1P0G53HNvZNMi9JXWy35k1MbLgaY/L9AQ5aX5W5dk5leQF+v3zN5TAzvrbIMoe2yP5jRvergqYurftFD/QvgWzH4Me1OpT67ud3GwIWQjEQWw34XaCmpvk8FaFaf/689naT5yAJzzpMTXBqKZBSBe6izGWJ02GZB6SYhEEWWq4=
Received: from SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::21)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:34:23 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::76) by SA9P223CA0016.outlook.office365.com
 (2603:10b6:806:26::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 19:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:34:23 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:34:20 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v3 03/10] drm/amdgpu: rework runtime pm management for cs
Date: Wed, 23 Sep 2026 15:33:39 -0400
Message-ID: <20260923193346.2292597-4-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193346.2292597-1-shahyan.soltani@amd.com>
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 67018edd-d641-4829-d5a1-08df19a9ac06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oow2MvTqSX+MRmhJ3lGW+HJVeMzHJaKsA1ViAQ8u6tjB2JMw1mMUt2nsZ3kysZy7Urfq6mEro+XNGHEtGOO1Ra1nl2oWSFahuW5w3uhQ5kgXowYqe+bvNAJaApQl8s2hlw7MuFH73O7d3qbBUVDxfSplPSEugKKoaD+hmfzqfEEZASet6m9eMkau2vlVTA8oF2zuHD+pLBYthJ0VaKt38q8QoaSv7T915Sb2avJydvW5xFBzyop7wGNY0ZRgCtH1ht1cJxlMo+4FAQy9JDWTIiQxfzo5HNGGI16R0sz7ZOoDlOmTtY/azmK9kfwgFSqPyEBz5twP29lXzA+7QokA2IZVkNx/Ogz0N1nx6oJ5KLD2JC6jkmDxcJ9s5xTDTI0SX1B4e8qOwGjo8Yud+R8V4113QR4pmu0f1kpilKs/PgL1R3uJ4cLKQrhU+/3w/bX9x3pi2pM1jYVFWyVoh3npNRmQsUyS0p31wFjJaQTqNgvcnGrabrhdluxSu09jmq7CRQG8aiSKKYABjPU+pWS3uOKmpMFJMOOn431d1z43w01Vm9FTsVCdAbUNerOk8Fob5vUIPJMfxhgZdMhxmaMzQjU7fbGF4BoM84q0Gu2NBqNVP2XDA4/aV+6onT+jfJ3IayXKWIzwlGWRL3bdjqVG1dFJaY3/Ijp3E7Y4YaCH6lBo2yv8oBCAJy+vO++DTwOktADV5Ps7d/wOQYWnr14xbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ahc4d+AwHEzxU18sHfn0mOL4Ljn+WWntbEBHYn1g97NFCh6wbSBWMn+ilLPwnZlKd95jiIy4AuLARivQj8xFDrxXHiKgghgLrtzynwwEQugi00+ddWqSx6xgaQhJx6hkiBeAHL7xGHRK3LLoQcnFk8zebZuEK+stU6jJkke9pXi/xrhmYriVu9opJpB45JMSYzH+eJ57L8SYOa1Xyo/1EhpzYqDUbM670gX9zx1PIRXH6SbfFFMF+R0itzHGcU0/X49zxvCWe0G2sxfV0VpFuYbSV94xnlsynG+67USgTactNfhbBr+Cb9mNHWavc+sBeMaU/j+fG/Pgcg7khauh1z51CqvlkmbQk9y8edSztf/VHVtYm5utJwWDr8VWUphenA7Lqlu597P7PtBrN5RSCv53CXd2MbWj4lH4Tzet5viOvMGgNt/zYaXFxupMVx6x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:34:23.5538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67018edd-d641-4829-d5a1-08df19a9ac06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Submitting a cs ioctl will now wake up the GPU. The guard will
automatically drop the rpm ref when the cs ioctl goes out of scope.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Co-developed-by: Shahyan Soltani <shahyan.soltani@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 87ccef153073..e2a715c04208 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/sync_file.h>
 #include <linux/dma-buf.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_syncobj.h>
@@ -1445,6 +1446,12 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	if (!adev->accel_working)
 		return -EBUSY;
 
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
+
+	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
+	if (r)
+		return r;
+
 	r = amdgpu_cs_parser_init(&parser, adev, filp, data);
 	if (r) {
 		drm_err_ratelimited(dev, "Failed to initialize parser %d!\n", r);
-- 
2.55.0

