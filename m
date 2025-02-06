Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C137C02199
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 13:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E54E10E826;
	Thu,  6 Feb 2025 13:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BFnmT4N2";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5970E10E826
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kN60zpDpOWK0tP1ga9GllN1Ug7MJ2yRo3Dt9jUtbDOsiYBiH+pdSIhK5IUrzJlgcbf2gdOB7VCkPSgKLhPv+0LtYwni/VNG+fB6bQ+2hW04+2JTGd51hqBMYvbzXpNFn1X2tn20YWqVfQRPf6ijbQV/2LNC/ZoMt3nD/+kf5K5hKcplTKCm9QBPy99798EjKRayIuhZxaEkB1pUjFEbNrxT5MigzhlKQKjJlNF54U9TcKD/1p6Zm8xGKvM+F9w576H6yWjilf06SYRsnrXW47nZ6hxnjCQ814iuHdhrh31SqEvFEH7kU3wLYS3iaHob93nkzzov4ZojxNv6rcuuqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtpuXSrWuYbJ01CZIYJvFmbw/aXXayME+BHqtCQDz2E=;
 b=lkhKLciSpNHv0nA4LzBf2bH5T1WO6yoiRsT1jEdy3rXgae4hQAPV4OZKSYzsyU/XNnxBazWarKMwUwkkEgaGmEGTg1B76yeMtUNoXRqYTcizz8n0fGlGJIYTkGKpLN9bB1H58Um2jPZTVWZdIoLcyp6XKBteAWJc8KNCSd7kxNb8pDe2cyQVlxN1sPf3w+77FhEomAoeOHe4pMk4VwJ/fOJKunZbfyNCEhXkFj/Dk4etBIyhN6y1sw4QGLY0VoS+GiQbBm+h211v/wHWXzrALEg2TFeM+eJJniDUUNUeFWnLwYC1vmKlgRZZ9GkaNL6ALnC9ii5PJaI1Zq6ex8extA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtpuXSrWuYbJ01CZIYJvFmbw/aXXayME+BHqtCQDz2E=;
 b=BFnmT4N2QtflvqIxy74YESPmQofNDn9fZvB1fn8t0a57ZbRSEeXTbi+6iYDBkCtBW+Hwb9YWN6s6M2X3tRj3JsvLKzhxcDVXS8A9oq1vdwP0km3BqfISQFLReCK/X6Ne2zCaWdfaNVUXM5DXZWEPDGtw8a64F/03JKzlPRhZPTI=
Received: from BY5PR16CA0001.namprd16.prod.outlook.com (2603:10b6:a03:1a0::14)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Thu, 6 Feb
 2025 13:13:20 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::de) by BY5PR16CA0001.outlook.office365.com
 (2603:10b6:a03:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 6 Feb 2025 13:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 13:13:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 07:13:17 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: <Hawking.Zhang@amd.com>, <Jonathan.Kim@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Date: Thu, 6 Feb 2025 18:42:57 +0530
Message-ID: <20250206131258.1970391-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206131258.1970391-1-lijo.lazar@amd.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: b219f076-6277-4789-5336-08dd46b006e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q6hFh5rze+WI22EWo7tOKpGfpCOL5Hfl8rw4cJPbGdUrEY7upxRtcSkOHZNv?=
 =?us-ascii?Q?I7vq4ndmkEWOmHNBFOrvOhqbgRWvBfmEMjooIBQ45bhAJ7FfnV43MQiiTvjt?=
 =?us-ascii?Q?HJmP6M0O7/kUxtkGrW3MtM1pHOEptkdpMoVaILDuLRhkIkWCBXepHZ82eaC3?=
 =?us-ascii?Q?MIXV1pZqW6ODnkLAzap0Mro5DxxpuW6ov20aF+oaDNmNvsM1tRamOXRn8FE0?=
 =?us-ascii?Q?6tmRXdK45KbkXqD1KtVxdwovLKkMVwTHflOZAiym+WTGX/At7acD2fkYUALN?=
 =?us-ascii?Q?c+8666ZTHi7gSs90WHhGI3sxj2VW0iGUJTACzrLsukLIfYEABIYJLJIuRuSx?=
 =?us-ascii?Q?Ce+c6omwJnRCVRF79/kOHLOIjHDwU5LHdbq8ESlCd6dFjv6yzt9roNKBWMmI?=
 =?us-ascii?Q?RfyMsb2R4Yny3vDDDghvioEXbr5aXAmNj+sumLZeBbMCy4KAOimY7NgC5w43?=
 =?us-ascii?Q?BYHKTJZxwLRSgDRSw9NdRFrnnuSr/0h6CJl/YC5vx37qr1z/8nFzlqx5QsZG?=
 =?us-ascii?Q?SA7x1Wo4eRoSSqxMxHfclsA1koZqUyU8HSjiwdIm1XgN4FNcnsYOmx2Rf+rC?=
 =?us-ascii?Q?dnrjTYPNO6ionBDN7OwtqQLlpDHdfGu8lWHODVDDBQ9o6Am29nLx/hnNd03g?=
 =?us-ascii?Q?urj2yoiIu9UlfSX9s+rqIEAWdyGLxJ49/OYmcoUHSnRJsqX9Cg5P3NlQtRT8?=
 =?us-ascii?Q?StwaxG2YPCyhnTcOjBCEGdBtyPOxjcFKl31GwN8sKSFWrfZDVT+th1/YnIu8?=
 =?us-ascii?Q?yiqJoNhnK4Bhl6BSCihhvLqeLTEljnf2kgklnZaVQfRUfx5Tq19Bbvuoruor?=
 =?us-ascii?Q?96dIM/LDc5gN4aay68RI5e2hxZW2qhY5FA8KFxgWILtY/RGcATHdlTaArWoC?=
 =?us-ascii?Q?uSuw5SMD4jb9IqRiZMb2A8P0dXWey27fiOMyg2OTmV0WFllSUqtQ6ylA2PX2?=
 =?us-ascii?Q?srs92BqmoIkbA8iwil1XDdxvLllOULSwwxO7Iti+F8Ibo7rfh9y+XflpJPbo?=
 =?us-ascii?Q?5rPR6a81BhD3VXYfQJb/qA2rsdSdkflQ0djZ1j67C0fxhnnT03YMRI6HUYTD?=
 =?us-ascii?Q?/uymunD0kpt3niKfhNSXAluUUk2706WzOHUf3i6dCKJXgnWRyhkQ7KXckOX9?=
 =?us-ascii?Q?OasdBpD7nh1UdhVIejoXa2vSMdEqIca1U6vZ+LHZfE4kmF0aRSJI+77FFSe1?=
 =?us-ascii?Q?Htynvw2p5iLDBBvdj7T2wSWWiqdGM3ic3cqtNBCc1fzvtQtrjDbSjywUze17?=
 =?us-ascii?Q?Lnw12e/QHjYIqO2JV/+hHUvC8U5iy31/pmb/rLIk9sRBpgV39cyVICFqHGL3?=
 =?us-ascii?Q?kk/4mvglgWtJIjSDT7Hqz+7Srd2E2PI/fsPLDvH0Cb19wllGd6GJRZVwOIKt?=
 =?us-ascii?Q?J+RLdlJnN04x5QrGDnNExVaa1/+v5UHaFg95/I391AUYavEdoikrsQf7tZRR?=
 =?us-ascii?Q?fTaJMKQPYVtJjW/I88W4v4Md4pcIWZnhOUCb26QN6647AuSTXyzXF6eIc4Wk?=
 =?us-ascii?Q?u2BM/AOMul1/jHM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:13:19.9058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b219f076-6277-4789-5336-08dd46b006e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
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

Initialize xgmi related static information during discovery.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index eca431e52038..d4eade2bd4d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2502,6 +2502,19 @@ static int amdgpu_discovery_set_isp_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void amdgpu_discovery_set_xgmi_info(struct amdgpu_device *adev)
+{
+	if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
+		adev->gmc.xgmi.supported = true;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
+		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
+
+	if (amdgpu_ip_version(adev, XGMI_HWIP, 0))
+		amdgpu_xgmi_init_info(adev);
+}
+
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -2769,12 +2782,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
-		adev->gmc.xgmi.supported = true;
-
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
-		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
+	amdgpu_discovery_set_xgmi_info(adev);
 
 	/* set NBIO version */
 	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
-- 
2.25.1

