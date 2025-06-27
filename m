Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90717C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26FC010EA1F;
	Fri, 27 Jun 2025 14:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BWV8Gqth";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FD210EA38
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I83cjhrg6aULjiPD6FfQeBrxHDywNfkcSN9alkMeGPvAQuaavDzTIuIPXld6P/5BjnOm0Up0C0f12hTdnKJCbcZHSwbbuXbJmVwdeLR7ZmzzYMCxbBxNEc9yICKivoG/3QEXBkfe8stFRgd2lfCl3RuPn/01LzFgUSo2ouwZ+Tp+gBAKRkTrTzR9IpAsBx07fRciMpKbwdPSigF/aFQukMU4rhuavptq4TBKGXmHzL28bsbr9zPzxVqGDAjgn6UCqU3qW2pt/CNEaexmIwPo+9XT6FXK8kBhZDvtpVSyE6sDSjLIbbmsvsuLLjLyC/nNErW6Mb73RlD3gPMq2mRqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h/XU3HExw7RkJdhRMtMK6fDM/akSZr+Cai6gxYrPHU=;
 b=xxp0UM2EtUuPlWLprod56MEKkb0XEHmOPTc7wPOinngc5tq8bDgy9NiwOVrhJiZkvR3blHaUvYlzH37YEYAPW/7dMzv9KIp/ZEgGw8eL9rjKEORARU9ttEzmsOyB4i8Y2ti02fhQgJHw+JG+fDCPQ0aZC34B7FY3QHX+HX6iJ7Tk6lukhBmrVrMAIu0h8l8q18Kj3YGwJCumzNcl8xxe4BFXyUHdZ4BAW9jrCTBZzp+H3mGqjU7KxTeuGxWk0lorerPWVQra/4Taevrhyaq7pcY2LQpJlcrE0sSteue8H9NCSwYb7wnzT2LDyxcsgNQIKQYGMpvxYOgdcJzWK5nZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h/XU3HExw7RkJdhRMtMK6fDM/akSZr+Cai6gxYrPHU=;
 b=BWV8GqthecawcLLp1qM9CYHf2APTvA2W4sL4/G34nP2hC80LW3GxlTvsyOkAosd8k5zm6IS6QS3ltCT2F87cReju2BDfVZ8TEqzOOzJeBW49BAc6HeRW9fCH8fh1VZE/Adtrfgxm/MJJZsVn0LDeDH1ua95sTcHIuGaTEzhkOIc=
Received: from BY5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:1d0::28)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Fri, 27 Jun
 2025 14:34:10 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::9d) by BY5PR04CA0018.outlook.office365.com
 (2603:10b6:a03:1d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 14:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 14:34:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 09:34:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: don't enable SMU on cyan skillfish
Date: Fri, 27 Jun 2025 10:33:42 -0400
Message-ID: <20250627143342.23856-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627143342.23856-1-alexander.deucher@amd.com>
References: <20250627143342.23856-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: a578fda1-dcf3-4e58-a591-08ddb587adfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q7xFHBkm6BIKZkLDA0MedrFP1O1IjoR7nKg7fVfizyjLU7QGFfS6v2iX+/bP?=
 =?us-ascii?Q?UL2B+MPdbSLY2EsMm01czwK58y5kZgKK5KLUHUfgjGm20AtY1lo7S/QGfZPq?=
 =?us-ascii?Q?Zxe3KcMcJ1JNqP7Rb6RHx2dGy68LcqjQKkwx5sXa9HkfWkw1BN5hEL2YNgUK?=
 =?us-ascii?Q?XMk+89ahMAUr814y4NldjocXiL8cNmNW+/FAe2by1NtKG6Q2UrF89Jiz3qrO?=
 =?us-ascii?Q?Tf/xIXxS8s2Ct/0ouzf+mfNFB+yQCFdmvnpT3v44xLWyCCG2ySpTap1k0uGw?=
 =?us-ascii?Q?AMWgcxnPcfyXzaId//wvqcS9p4uKxrWf6rUcf5F68ntshtrZlz6ueeELPtvU?=
 =?us-ascii?Q?JID6Gd2HQdjJJzWKnyMqLrtcSAB8g2hJXFwuEOZr1qDqDRNht0h5ay9EFB2n?=
 =?us-ascii?Q?64/vNj0b1u2wCkXkGLwEtLDXOm0Lf1kjpqsK93P4U8DM+/wjYl9TX5i0GFhR?=
 =?us-ascii?Q?zE08Wb3xXGUEeaj3sYQ82RfdkuqvWaeCJXi1eZ7R1eA1Upn+ohY4wPO8+7L0?=
 =?us-ascii?Q?AXHnp9GGThBqwRkSMR097QFOFktzkob8bfbCKCErs2nwhj1rYZUIHQMldT9F?=
 =?us-ascii?Q?VyRvbcz6KXhfzcVumSeurC1wTfO0s7rY2chvcCiOv5lnZCsG1g4ag2nsz+aq?=
 =?us-ascii?Q?+C48TrTduvuxsUMWweOoVWY3QX/juDrmSxmlBS4gFlDlHInyvMar4tKJzq81?=
 =?us-ascii?Q?OOC16QmZHSGq7LKRTvmOjSen+Rh0cPGnz4pmT4a3ZbwQEL+qIqt/syM2E5oN?=
 =?us-ascii?Q?oZF63EWsbQ/mZ+RIxVgo5UmbDMXmKzRbi5G2fDSlduZFEw5u04g89RbJev6T?=
 =?us-ascii?Q?tImoHRJzv1Idpsm6EJlFJOxSROjYfJCumks2O6BHdtsl0JGuOv+GkK4QxtsC?=
 =?us-ascii?Q?Atnlq0WU/vKM3ZNqfcFIpqr1r/dmQeIcTWBcCJfsqAaFiT/RAN3jYTykU2Va?=
 =?us-ascii?Q?Ak75Q0xPNYT1/Nf3VD59bGKDIMbdfClx8kdAA9dRutJZN1t9lG91g1ZKyV5I?=
 =?us-ascii?Q?qf/EM3tGDBIb6yVOk1DwDpgfR0SOqhpgdOkYVpuXFAIV0GTOwp2xUsS29LHZ?=
 =?us-ascii?Q?Ejyw3aeRA7qRsNFAt1OTbaGgOGOUZ+bhGKr6iThneXk5+gnPohcTrwrUiu86?=
 =?us-ascii?Q?OY/vFQYUCdT8lrk/1dI9RzJnx9zRrO0La8epX/5PK2phBVAnBZpvEy2Ene85?=
 =?us-ascii?Q?xZbd/jz+l6q/0Rq+0JajohyLlGLOazA6kvbfu0mNbGd9auCTb17TtiEN1kV7?=
 =?us-ascii?Q?4K+CHbtFHLwsRJGvDJ0uf63V48XxCCy93xidMNz05WGPj5IlRraoRiDxmFqx?=
 =?us-ascii?Q?E1sofdAka0FLvU9B/DRnVw2kHZsOJuXBbf1MD1MMsKUXeZOnzXs/GKARX5l5?=
 =?us-ascii?Q?Q8IpnYdiPTlGae1Ruy6O/a0JzGLeZSXKNJ8cmoXOQUUYiwIAly2NWOghCcg9?=
 =?us-ascii?Q?x2YeA4mKV56pi2sf2q/VAB2yf7lhjBKaxTGkG4cXCJmyH/5H31pxaJWNrAe1?=
 =?us-ascii?Q?R5T+CNpDKXpu4fPooaYw2jy+1uSLWGFYsGN2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:34:09.9473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a578fda1-dcf3-4e58-a591-08ddb587adfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
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

Cyan skillfish uses different SMU firmware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ae89dc9687435..55b8349a6953c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2124,7 +2124,6 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 5):
 	case IP_VERSION(11, 0, 9):
 	case IP_VERSION(11, 0, 7):
-	case IP_VERSION(11, 0, 8):
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
@@ -2132,6 +2131,10 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 2):
 		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		break;
+	case IP_VERSION(11, 0, 8):
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
+			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+		break;
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
 		amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
-- 
2.50.0

