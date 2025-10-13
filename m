Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF88CCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 16:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C8310E49B;
	Mon, 13 Oct 2025 16:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fIRBLCeT";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8730C10E49B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 16:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yE0i+ZVi+tMmMqk3VBdj2rTba8eeWUeBGT9wHm2nmvMpfXAA/pA1LruOXqxczeWOaJsZdN/iC3SpKK+g2FRr428/QzrlwYgNMCVnL6yll5+e1+5a1R9spYmX7oH+4smE/vIR0j8AQZDMuFy65moKO1JtEreld+H7NH3PnXH6FErz5xJo1Dm5TcASnQeEHlZXMcy90mrFqXe8wkvBJ4gdAKX+gzweON8KYn5Ccd83hUjlLznNXrpGgHrOsvkHcEwMAvSDFlnaECtaHIK0TPOe2/vYeaHl0zlzuLWd93z67snf5ATokUzYpka2M3xsXx1Thl4pkadyBVCuBE0dFYQGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+x/BLW0PbQ+Ciy/cpWYvIl2ZuJX4Bappeh8wqGO+As=;
 b=XtR0aLsS3xxvOzhDEmHtB4xMktFFjiQKzFe9ZIocO2KAh9LD/KhAHJjDXLdZ367z8mMyvF14l6+nLy/74b8alw8HtVZG8IArFrjJGZidLLVAHESW9xPTEIb5VaX+S1Zqy4lC7FX83t767GNm+vuqLs7KoJXywfnglC2ULXxLZWptTYhoVYFCoFtcKld4OZwrP0QFtRzZisV7CqNd00uJbwRKqQjN5PpHakCHOROSq23AiXZf0R+8kbOqSBoOy3FaghKxj9F8w8Nj0cvxOMx86lN4A9TQqmCr7yjjmst+YrrApZs9cuRnFDrIA21JSRQY5+qG7iFzh1peZebB/jZMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+x/BLW0PbQ+Ciy/cpWYvIl2ZuJX4Bappeh8wqGO+As=;
 b=fIRBLCeTNC5EZnNOUaKwOIfI2BvPOGqb36vc5zudvuOste+xYqZ5f58mZC/PWOpSG5cDUetiaa9qydYAtiOAyiYMbBZKEH0eO7lSyRLfZUtQE8B760v+dOFISaoM5PBudr+mMAgIIc1KCThGzxnSvbfYdYbxnixAfv0yyDMngEI=
Received: from CYXPR03CA0029.namprd03.prod.outlook.com (2603:10b6:930:d2::13)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 16:14:16 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::8a) by CYXPR03CA0029.outlook.office365.com
 (2603:10b6:930:d2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 16:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 16:14:16 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 09:14:09 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for sdma
Date: Mon, 13 Oct 2025 12:13:51 -0400
Message-ID: <20251013161352.1628044-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013161352.1628044-1-alexander.deucher@amd.com>
References: <20251013161352.1628044-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 8484c5a1-b48e-4f03-ab1d-08de0a738ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lUhoAJKfCOVbMGhgE4yFxKP5/dTm9njYG0ZWF3Go47WWZAnwsgnwQQ9ORK4G?=
 =?us-ascii?Q?xkubbVpgYIwtK4suqMdj7izxCqHYTcaeroZ0j8rhJaGpOJ/1vlqfHJMNtKTc?=
 =?us-ascii?Q?w9h3Pdjr5IaQphyES+pyg+riNNufedtT5R1BeMHNZvUjbL+Xh6uP+Pp2HAhE?=
 =?us-ascii?Q?GD8koD2YjjUCzmdOsMpzWMvbhYIofHZaVfCjL8CH8rbtnMETfizcnpXp7hFx?=
 =?us-ascii?Q?Y8GUKpCcLvG8AHw1GgGOQSy2xR8xKXgeXvvsX1y7Ru6Fmvkp+7d8w+pm7auJ?=
 =?us-ascii?Q?Sy8F8+/UvJ5AwfTw+0XMxvVkESXYBqAM4tMSE7fA7pszEP7bNnLo0dPNep4Y?=
 =?us-ascii?Q?GPMjmoBZcSWbFNRUon8pPEdUgk86TYFDdlrpXCe4cKYPdBk4dtWSZdV2CxCv?=
 =?us-ascii?Q?vF0FasTCRYuzJuYNZy2+7dFLY5lqAoirFZ/a8jiHZtwdUmWQT/EP20ZiIlWf?=
 =?us-ascii?Q?On9upyG1cASAnunrMIvpRSa16cxFeXXSuA89zXvV4VieWbfSDroFsyYmggLI?=
 =?us-ascii?Q?8sCuLeL0IzaIOnQ07WFiCgcjqxU/CYW6NIYqGcs3Ney/2xjfVl1uu0wIwkOV?=
 =?us-ascii?Q?W4GpxEPPPzqFVVUdDx+cSzIuxXQ0gGYG5KblJutzpfvRhZzBAUB7gHy/PJon?=
 =?us-ascii?Q?91BsggGOgWZzFvdlaEBEtrjOlcSugVGT0zz30Din1m0DIWC4xdVS941Cmg7x?=
 =?us-ascii?Q?PlcC1wwGbGB3smqerXnEwwSykoRBd/lT3lbLPaYs6ZxWmMmASD9+LNvgKESL?=
 =?us-ascii?Q?54SdMYoPIYw8DHdwioDU6gX01ymQHhigcl1IKdEotyqoF1kP5CLokoL+CCX2?=
 =?us-ascii?Q?Xr7xU+LA4pjUAqN+frTwkVS+kR6/UJgmxD+OM+BQH2FYySucGnrMZ/vca2Pe?=
 =?us-ascii?Q?xKjx38FBACKE66ZB7ztg0P62z3vtmx5J51qjsjd2qXvVsKZt2QItEdhr79e6?=
 =?us-ascii?Q?CcLs4d10sN2MEySrK6DCrA2ogduIaYq/tKMOemciayx6LbS4JgTFR12qpw9c?=
 =?us-ascii?Q?bnMOQNxaZjL98E3oabXv6ml3i2Xu3Kgnc0PoAT5eLUy7lPkQiJ7Jl74+N60P?=
 =?us-ascii?Q?qeaQXnR7KmJ++ZyyrhZTrYFyf4q6O17R7XPIuQVKVKOmNzXde0bOkqVC0SSL?=
 =?us-ascii?Q?GEXZm/2YDoM3FxldcHqFweAibPMPdGHUZ8zgGFxCht7OB69BKyBAsUTTJYML?=
 =?us-ascii?Q?xKJuK8WIrrL6rI95j745428IoesWO4QvNuREfSjA1PrA/PgJ69Mvd1heHonn?=
 =?us-ascii?Q?7xijCVSI5dTc8Olvezpqe3UZITGL8ywt0Lubhj8fslWE7ea593XwtIwo9P29?=
 =?us-ascii?Q?Jwposzqj8GnkFeMrMDzBkCtf19RU7OC5FP9pxtisbOXwKfDKf68hfOl4Es4r?=
 =?us-ascii?Q?El7AiBq/EcJ/79DXZsmLTede/lDgcYfT4GYRmfBcVp+FlSyZ4u04wQiM3KTw?=
 =?us-ascii?Q?j5AQ3dtco4WFar7BsDQhBd4t5oOiiQWi9D81vtV0Qvs3tFDATHaqHg1+tbqq?=
 =?us-ascii?Q?SgMMTZTCcA1aaLnJAkLUy5djgt7Ur6O22NblBo7JbLAr7X1qMkavouWBA8gI?=
 =?us-ascii?Q?MxGohf+2k3VS2DSupk4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:14:16.4898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8484c5a1-b48e-4f03-ab1d-08de0a738ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
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

Add a query for sdma queues.  Userspace can use this to
query the size of the CSA buffers for sdma user queues.

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 26 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8a90b7ba59e6b..8ea8cbde4d1cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -409,6 +409,24 @@ static int amdgpu_userq_metadata_info_compute(struct amdgpu_device *adev,
 	return ret;
 }
 
+static int amdgpu_userq_metadata_info_sdma(struct amdgpu_device *adev,
+					   struct drm_amdgpu_info *info,
+					   struct drm_amdgpu_info_uq_metadata_sdma *meta)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (adev->sdma.get_csa_info) {
+		struct amdgpu_sdma_csa_info csa = {};
+
+		adev->sdma.get_csa_info(adev, &csa);
+		meta->csa_size = csa.size;
+		meta->csa_alignment = csa.alignment;
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			     struct drm_amdgpu_info *info,
 			     struct drm_amdgpu_info_hw_ip *result)
@@ -1386,6 +1404,14 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (ret)
 				return ret;
 
+			ret = copy_to_user(out, &meta_info,
+						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
+			return 0;
+		case AMDGPU_HW_IP_DMA:
+			ret = amdgpu_userq_metadata_info_sdma(adev, info, &meta_info.sdma);
+			if (ret)
+				return ret;
+
 			ret = copy_to_user(out, &meta_info,
 						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
 			return 0;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0840853fa447d..e61b9eb380bf5 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1636,10 +1636,18 @@ struct drm_amdgpu_info_uq_metadata_compute {
 	__u32 eop_alignment;
 };
 
+struct drm_amdgpu_info_uq_metadata_sdma {
+	/* context save area size for sdma6 */
+	__u32 csa_size;
+	/* context save area base virtual alignment for sdma6 */
+	__u32 csa_alignment;
+};
+
 struct drm_amdgpu_info_uq_metadata {
 	union {
 		struct drm_amdgpu_info_uq_metadata_gfx gfx;
 		struct drm_amdgpu_info_uq_metadata_compute compute;
+		struct drm_amdgpu_info_uq_metadata_sdma sdma;
 	};
 };
 
-- 
2.51.0

