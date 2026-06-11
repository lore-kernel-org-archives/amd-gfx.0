Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A55CD98D1
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 07:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFBEA10ED28;
	Thu, 11 Jun 2026 07:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iBYu7cki";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC9510ED26
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 07:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odsVshHS+1J+UAww69Y++XPrHz7Nfb3UGl6O/yP3XdaqaTXEj8ma7Vv/O63f6jTuM6uLx1Jf4pzmFXs4O9RoJxrQz++HGxxy1kE7iyxjyPPVd3mr2/KoQOK4FBt8XqnySbX15/t2zrEDXVW4Rw1owun0HDJI+mzDO8QnGgc00/IGlbBYknGlJoWLmfY4qx6i92h9K0bugDHlrUy/UchSU3zVbIyECrCWKBsb+7Fu5yi+e/01/NZJ0A/dsIgVLrkNnagOi4WMTe/sMEo5rBsvcP9CxuKY+2zqujblVQH6I7sMiudFYF92gFoIQ5PLb/YnHtsUeNux1YRZBITC0hEGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCHTPmkxU9doroRvnQemzAEp7jNTl8KCCXEux3w8eww=;
 b=GddYGeG+8viAgVTKxycRplpr0ayr7pt/0agidg0XFFFi9Kp34juFWzDo+YB7dw6HqwMh7v7F0cQHB7VzmJusCxhmlmTjEDlHH8kswJHSVjVXz2srxeUHB/0gr9EF6jI1yyQMjmLGIb3skBd3lRwz+eXGsCC/zjZuuWwWp2ErAuMiTpNOWyEHjT/pF/ExGbzD++skBU+roFmaezQJICe7JPFHE7X4iFsCee+Bql8MKPElbf74ihXXXDF6tQrkeQDZ25dDHMqQ/vPdjIJdITyFG0xNzSHey4bMaF/RbKqZpgfIz1MmlOoSctyHwEEIl2vSwiuP09B19zHZBJ+sjQ/cbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCHTPmkxU9doroRvnQemzAEp7jNTl8KCCXEux3w8eww=;
 b=iBYu7ckiTdX34qD3WkJzk5HECrCXgKzvdBLNRvcj9joZd8NyjqEnzrpFqUQ3I1XtyqTBp9NA2V5qB1SrtA+x3ETKz5OFvWDZbwdvw9L3YvzD5YzultCyYkePpMtYjE4Cjz1onz40oorT59ZpRcRXBHXh3raNiWYpbNW01k1czkg=
Received: from DS7PR06CA0034.namprd06.prod.outlook.com (2603:10b6:8:54::18) by
 SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.11; Thu, 11 Jun 2026 07:27:10 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::10) by DS7PR06CA0034.outlook.office365.com
 (2603:10b6:8:54::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 07:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 07:27:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 11 Jun 2026 02:27:08 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v11 2/5] drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
Date: Thu, 11 Jun 2026 12:56:41 +0530
Message-ID: <20260611072644.2856170-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611072644.2856170-1-srinivasan.shanmugam@amd.com>
References: <20260611072644.2856170-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8a377b-56f6-4d03-d6cc-08dec78ad982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wWDk5QkTPGe6h+AL1JMbEbtqBHrEHWwOGvspCNbTkfekfMUy0gr2ZYkadlYm5ZwOwOCgGVY5MC33LdepKPwETRHpIOut2VruKL87+1xDmM/Ta8+1D4lfCehO+HCn4FqW4SCp6lmFKjUCxty2oRC1CFoc2AWW0xuRT1e30yOW+shh3p6usdxp8HcnXd57OT0KpsG8Ft82ag6MnkNd41D9sPTCHjfot8hFdHDgJ7pUJHoaxbe9qVWX6P2cmNGxkPxtJJXFuE9b3/bSL5W0QwgFKlbLWaAK/SBtl7hdAzTk2FnaAirRPEMxNm9kl9uUG7VaZaACv2YOOVaTzEjzsiLO85yEUnZ7LVFlXUDyf+AdcgGTfMR94IqUl/2JsEVcmNBPpNFdyk71ZwaaEMc3NImNDaUSb9pyvT5nrIUCYMaz4FxFp195nuc76920ja7Aob6DVJiVE2sHiQiEoz5JWfD7pxYIrAC87VJKBL6cY18KV1IwOVkTmzEfZxKj+3rvLKdX37ui6kI8C0JDRttLYVPadYjHEePeOqnvoocClc6MAPc5EJpA7l7MnicNHnlzTp4S7JjYvgeSSCRN7Q49Kw6uFL0fsOEqE+1zCiLNTSkJ+BAixkk0BBOmpJUoHmTiBufQwr3XxD4fmuHp7qhPThHaHugp8la0iZI6lfXO7fYEfWPC/v7CiHssTPW68L4HKsBxo3V/yPr4CVMUBhl83FKbjUgursuz50xlpDNAc4YjTMA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XhYVdruqsCr7ZNmny4jsmsqnydO2Qne0cmMgvqAWzHL0YfryvWIyRrVHioxdUa24rhfT/+4YavVsGsJPN5P+TZqdTbAfEr/fNs2or4H93NFCB1KQ4Ji9pl1bC/mUqiN9tLQ0HClRctOH+QvC6X9YWMJFJ7X7s4pG8Ag1BEHkuSqBCIX92aV0WBTwV+KqnGUl5ZRPda0iJglK/LPj8NkE9LVF/bBEn1+nSs/S1omgLsZmyh+F3lBr3mrUC4Z/5rsST1yaA8ZXw8e1k3j5xiWdfJpm8R88kYelgtP4srHiZK0ZhZAdPE6BzQvlOLwKQ5kRQO4CMAzfc0pfjWDlWbuEvVSx1IIZv/KJZPi9UGYq4y8cO8uwhUZ6T53REyYZShYN/mpqX4OpjyD1Cu3AWKoJvxtv3cfjg/sgUipZUvWBDnSCfN5hF5OJwmEmjXOnMwVl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:27:10.1097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8a377b-56f6-4d03-d6cc-08dec78ad982
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

