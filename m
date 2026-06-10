Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB6ACD98C6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 06:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82C510E712;
	Wed, 10 Jun 2026 06:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LV4Z5QLa";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013030.outbound.protection.outlook.com
 [40.107.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC0510E712
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 06:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oN1TnOhWpDFfSs8Y8p2g8xKfvDYN2QuZyyaPO50wpJiLl3iP8ql77Z4RQpugJu+/bdAFC+PjLG+kjlAxS8mQYj6+xKXr9/xT9nAeTC7PwVGsc68DzQKXO+FS0aPq1TSz3QioDsVBDvUWeE4NLy8fnkGROcm+xE9zX2ti6AxUtGCTbqAg6moQOAHKhvOI9j0AxzNhr67SSZFyLL1/BlCI6DlbKdRt++gbIscSzg5T202loO6RlFIN4IYh53hMnVQFA6dZyElY4TVoF+Oseiyu93wjrQzwiPUxGmKDQpQQ7mQjf9xmSZ5DbhsqvM+cCcV7FFd9deBeQAKkPo8sAR+nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCHTPmkxU9doroRvnQemzAEp7jNTl8KCCXEux3w8eww=;
 b=e9b7H24wPy+jMBgCh5lV5tnEnxRyx8Ce4yNCLjVElQlJLsp0PH69QHAcJPQCbtbYWLi/zKNk9pq6t5mzOb5Csm7rGwpZ9Jgv6MV2LXVIra7TX/v94J9+ofkVaTfhNpcFaysF1ztluZztklL1w50Dp270YmE78FOY6bxVSQZQd8BvAxuUY/pn33MWmK+PB+vJU/yqWOesT5c+ezkiXi8qHDGg7wWCXbZtnGQo/1cSa4yl7fOLv0h/qgN3TaOy4Cf9Q282XGtXfqaT3jnkpHjz3enMj08xOkk2w9KDGRH09vDbVxqyOj1vfFWUyc3kwC47Jc0jCQdbbT5LLxC1KNe0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCHTPmkxU9doroRvnQemzAEp7jNTl8KCCXEux3w8eww=;
 b=LV4Z5QLaoOJ0ezBTfXNkl1qKydkzjxefXQtqta+Fz4RsEM8HIgAV33pCVpZHtKZfHssg7kzfczNwojBr2Bm8/yhhf8ENWngc+e2MxRpQi6VVIDw+xi5/j1YXCdFUIuTiqVqXMh8zg3guv4/CQ22+iC/WHp5Wb3Ey7UNvUyRfS/w=
Received: from IA1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::14)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 06:04:34 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:461:cafe::6) by IA1P220CA0008.outlook.office365.com
 (2603:10b6:208:461::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 06:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:04:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 10 Jun 2026 01:04:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 2/9] drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
Date: Wed, 10 Jun 2026 11:33:55 +0530
Message-ID: <20260610060402.2769642-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
References: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa00416-def3-4839-8747-08dec6b6250d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Qp1YS7s2Xi9UITpjozaKgz5D+AXZNsvLwTSyz2BtImIG40PpKNm4JtoYvGISn86DOkKPncTES7ptjqZoMRHwPZLiAozCzDbi3ejmjkEJudec4dnSjc6RGnJVPX0vyIO+vYLxM0hA2bIScJlbG5SWB4c7wXbD/fHKSlANP53qVSWmmLuBZepNBoy7a4zEhzK1Jw2d/mgrCGtVRYZjvT1JbbwcEnjUWGMsIYRxaKCYZJ0+AICJik+PDuIrIajfY9VOye3qiA4O7n7vUv/GerUIo8wyRAg7WSzCMOUrrcfqsPAuOG27vIk/uagaaU8kx2Bcbkilhc6OVG7csla8NmXZrvP0sm3g1ji56unK0xdAsTUBkDPM5qeSRxiMcnN/8n623clLFIjk4o9SAdr5TWCPiIdGgwZJ6wb+MI02v2CrsWE0mCyK/t4jPgy6rj3+XeNnkrE/dfLf5Fz4zn9BFWUl4KtAHA9H3XmyiPJ/GPLWhSArXvGYw9ajbpkTeH4pEPVhk9NHPVt3NLEcfTCegWLm8lDERRJx9LYPDksy+dfYVfnJRbQkWsiL6ll3n1y/6iBBixdjytrGmAHXqqeMQaqMTNEr1Qu9+q01DeLlR2+bKrdlpmE8N81NPQraUxloVJD39hVZ2McD8wW4l64Xcn/mw2CMJUuqLi3yNuFaHcwicN5nbvyLvWI+5isRunAyKWINpx4UQJfwQXeDVwghwglcL2up9/9HbNYnU2vfNzQC/vI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u7y2W+op7tTlaMVVw3ZDXkYuWXYYYfXUTsmYrKE7+1m887RdNKBkoAkJ06SgTbAhWkMcJMOn5m+r2zMJI6RYvz/r2F156/hXGyo07U0ZixCvnWf91k97HRLF0gV1CJGBo5OQnrxAIVdapcd5DbZA9+lqXXs+3KtAD09UlyRNNVSy874oigAHx32beK1EfWPEjKtuTlRZBzEx0s1tuyvXfysUiNL/9edOfYBJjacT9Ob1jiqZoEZATEyycKvh5CWQeRWX7+VW6XmmsstKtqpoqsWRIa33ElVJ3ADeblM16u5CKqltGvrm8v+wf6kTnfGHG4l1spdesDQgrDTzI5zDYYDo/kW3bsEM0yyL4jlWtlw3Ht2ZfvXukAA/8JqRUTYf5Ux+uh4n+/0mpNzHviVN7bDxhHDNYF1FzwrawV8jb5ZpKSLICKRz8URHxmTBU9LP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:04:34.0829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa00416-def3-4839-8747-08dec6b6250d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d7bfa59424a..a75c68195df9 100644
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
@@ -455,6 +456,8 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+
+	struct amdgpu_eventfd_mgr	eventfd_mgr;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 24526e92f9b8..f5719500527f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1460,6 +1460,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
+	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
@@ -1556,6 +1558,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	/* Drop all subscriptions before fpriv goes away. */
+	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
+
 	pm_runtime_get_sync(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
-- 
2.34.1

