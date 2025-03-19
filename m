Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E118C35FFF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 19:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC49A10E318;
	Wed, 19 Mar 2025 19:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5DMWvOLa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7905610E1CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 19:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZ1Fmifx7TCbqiLf4MvG6UmtEmAs2YSHM9TeVU+BjBlL0opapvlJ0g177nAPRto53+f6kQ1vjdCqoBGETOCk4jhgo3iL1ThHfiQgz9FCCUsdUwr8yzsuYNqo0uCf8KLxpOvYyUturBBy0vDWgLYS2npG3unZXqwD7QVlQWePnniOYmYawcsINRcC35gCSVgumM24AM2A+/4XD8g6FKXw2INYvpKJelSQWY21Qjwy76ltKwRLTCWXMaCVy2gJEjXb1erQU3qmjuwKGNCy5oo+9FDlNwLRvDliGR3GatVuIJucJs/ZI+2R7QxAFG2UO5PTUO0s0L7A8NynVs/BTTO/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW69JL94q0WpBRaK+fn6OFDseKBM4V2xX0R/x2K2I/U=;
 b=F5brBPCSE5ndnIfP6/PEM2dDuDhhDkfp/xkF9zCFU2FC6i4iktcno92whkED0W7fIzx25ZdMf0zKtFNFv4z7QqODsQ9rLOueb+oQpzO9ZA/MFcQJpAxglsxte+I3leZWnU86/HSZwbKyeNUI9SReWybDJJJgrjCHa+zynuTvz/ICVljIBLsPrSy3b0B6gC+4HSBew+dEY1Ds9JcelGEDFKrquxk8SQFI/rYf3Suo0wRsT9W5tmUC5A1RynNYFssLoP5BTMsiXT2mmydb1e6KHXttOIP6fkR8e0YIeE3tXLhd348+Ng2k7KnUxYYWYOVD1zbYPvVism6MTCgO7WzDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW69JL94q0WpBRaK+fn6OFDseKBM4V2xX0R/x2K2I/U=;
 b=5DMWvOLaJUF9f5sKppaUY/C32ZlPUrHQWbUcOtCDJQzSb0Wmyz20lDnf+12ZUwCyCuS0RTdspjFlnswKoKh/XjcY3vvEPj2SuTEQtVFLMsck89gyFW2Lss+I5l8SzIxvDbz4UWiZWhoUR/S952fEu67QgyaAsUbbp6StgeKhBOo=
Received: from BL1PR13CA0365.namprd13.prod.outlook.com (2603:10b6:208:2c0::10)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:09:06 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::c7) by BL1PR13CA0365.outlook.office365.com
 (2603:10b6:208:2c0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 19:09:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:09:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/mes: clean up SDMA HQD loop
Date: Wed, 19 Mar 2025 15:08:50 -0400
Message-ID: <20250319190850.3899718-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319190850.3899718-1-alexander.deucher@amd.com>
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 89283ca0-9f97-4060-3e21-08dd6719856f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ajsFo3ojA4t0Hy/oQXoR2SeRvB180ijC6QiXRwziWfDPuGrbqpo4n2r9Za9B?=
 =?us-ascii?Q?NRvdCvrQm28mWi10K8i9DgixK9E6Zr0AwCevGW5mRt1G2r+h0HLpVmGoXzkf?=
 =?us-ascii?Q?SMfghQU+U60jzTvzHZuFK7QPJZynuZ4vIMpCJwJYl2WmKCo38PMxBcp1A+Q2?=
 =?us-ascii?Q?W/1jdl46sVFjSIU5aJsyMLKHmzrflp0PNL9BMiNyJJqCqHVDUxahUauQcqhi?=
 =?us-ascii?Q?WrpccRtBdW/n1UDgkDRz+wzGjYQI1B8NiDUfiyz1Z8iV6pek78XK3ZkzUax+?=
 =?us-ascii?Q?R8exOBE8jO4Rn6yXQgiRl62xClGh4SmiC5NLUaWpzurEoIeTWPJMg6xSPyC8?=
 =?us-ascii?Q?H7ZvZRxnupW6wVNtrLR0SBbjl53bJ9QxOR2oGaMDMbGwmXpuZ520zq4LHuCy?=
 =?us-ascii?Q?BTNgV9U/Q0D6ZnqdpEUjSFEz+wK2fg1dGtE7KtrJBWX9F5llWPkWbm6TqdFO?=
 =?us-ascii?Q?oC68N15W2kYfuc5xItzDWAmIHOdm0h4hiALJPG88gsz4yqUtL/nyUsqp1nBI?=
 =?us-ascii?Q?v8bxwGkkdRMnTJpYZibgR5pKB5yUqUCk+6DIPShx+nEPQ7D9EL/ugfZu3sua?=
 =?us-ascii?Q?d7lBapZo8moB1Oc8JnzlCN1ZXZxh+MjzRQW5hvn1aIWlXaUDkMWwBhADZMOw?=
 =?us-ascii?Q?Nx/QR8HbO4gZs5dvXfBd1qWbfXUwonqBVMPtJr0t3RFmQBLNU0v0ZFcNesKY?=
 =?us-ascii?Q?BMPem2drZoXvkz4VIXZ918zDy0YCFzLube8Xhih41LgOo3NCFqSkrLpsOw2s?=
 =?us-ascii?Q?JcCcVubhCv+qaD3R9EtTnoqoLqCkBdoTFVlHu8MWEYNjzLJUzglP3bboD0NT?=
 =?us-ascii?Q?wffobSyBBMrwxAY3M6otfTzeDaxOX//Ai9hlCH24PzEH85gGNo5BjiyiWxrO?=
 =?us-ascii?Q?JlWgQ3Rch/mQ1fjqx58gdnO/7nFNtarLsZKg41AnbtNlbeeqyJNupoEH8cRD?=
 =?us-ascii?Q?Z0ygBqYI5WN3bKLGe8ahm+vveEBoEX3sqHjBVTK5yvJXLMnNJi9PRY2t+suB?=
 =?us-ascii?Q?Zmvyhw0o3uNnuwlBsCITeLUFyeCifulEoIHt3qfyh8eFvtWLX1MLZk9dGdDa?=
 =?us-ascii?Q?aNMoRcWHlwXlg1tVysp7CrC+QsFAkvloBEaIgEX8JcnnNVZhISUBIyDCNRdX?=
 =?us-ascii?Q?TXBdjz8FpaHR+4Nx6HDCwilqgTDVVMRmeo4iNeDsrSzL9Wi75yKVnwNwr4Zy?=
 =?us-ascii?Q?9smrjoVro3+bX1+UW2qCAakPvbDuh/le/O5qimK/NixrK++UwQf5xQGYg2Wq?=
 =?us-ascii?Q?kxAkm3OpRuuuXQylCWYLW5F/Hur43/v0hNmXkpI8hfdYSLFRs8fl55bHI+l8?=
 =?us-ascii?Q?vjZbo7bhLqt0v/6/Uj/iGC1twUkHxIqhr378J/idTYo32pa1GRWh2+uv4SAN?=
 =?us-ascii?Q?aOn0+XLkFDt+VVqfSW7rwnbPZz2dt5uJdFDOzZ4wvSFKa/4RQL6L+DUhmcTi?=
 =?us-ascii?Q?SAbILmPM1cQkL4WKppTprUxifeNjE2b6Uvc5A6s+aQpMd7G2Rj7gsbk69rkd?=
 =?us-ascii?Q?SdgDSUTAcA/LEe4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:09:06.6513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89283ca0-9f97-4060-3e21-08dd6719856f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213
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

Follow the same logic as the other IP types.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index fddec5d1f2444..016af4e9c35fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -136,11 +136,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-		/* zero sdma_hqd_mask for non-existent engine */
-		if (adev->sdma.num_instances == 1)
-			adev->mes.sdma_hqd_mask[i] = i ? 0 : 0xfc;
-		else
-			adev->mes.sdma_hqd_mask[i] = 0xfc;
+		if (i >= adev->sdma.num_instances)
+			break;
+		adev->mes.sdma_hqd_mask[i] = 0xfc;
 	}
 
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
-- 
2.48.1

