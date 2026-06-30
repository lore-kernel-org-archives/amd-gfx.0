Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2789CC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 04:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B065810E16B;
	Tue, 30 Jun 2026 04:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Yj8n3CY";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB5610E16B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 04:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoAD+wDQah7G4WgRvlglO0m+E1vHmmmh08ZdYEZ5wvHeFHFKERipVxL2hlEfMsW2B+l9GX4wcOs4gmw35MoX0DvBJ42LyhYKHsDsmTO6Yf/4FatKXRjiQdrHRNbI7RiZa1dB8TQILwPubF1T2cAoB72xZWVsRzpWks7XytLYhunOI+tLVHLdWjTBGJwJ/pxSJuEON6J8H4aJsLl7UgkVjqZBuQAQQnfrmWhl6oE4NIFJLDMJgAZeI3WVQzCcGdJ+qGHWEIXADpvdA6WIOeRy1k6WeNXw9ViZ3O36XDUU1v/8VtY1UoiJzIG1xUc/rREM2nmGLcJnzZnzDRiPNBTAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlqeAr7C1nFm7HF8XtEj8ttmV63txZ1WFVCBGVDp824=;
 b=TY5N3/Fz7lvp74PEX5IsVfqUeu5Wf3+NCTtPoBwsY/n6ilUN7YzHVES4Mx7VE4kLkh+Z4iHVKQqdtJQqj63MAuXlw6RCSrbPKzSJWfRCY3eLBw23lchLBkVDEyafk81Bli5beZHsIBBbH8ossBF8cP+DmeMHxw6Ztj6WXA3actEqfT0N+wECP5CVc1hEWZu1x1j/7QDRhdeTAJh0ouMOzGyXH9tS34aaeVdaV/oB86iYCIg3/pe/5RqIFKNt3WV4BIjom71uUAvNiae+iuQE1Wu7FPz8y3iAghPrdkDzgVv0v7l5uaID/R7YsXzWWfL5XoixGoqiiK8H6dbAcjxkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlqeAr7C1nFm7HF8XtEj8ttmV63txZ1WFVCBGVDp824=;
 b=0Yj8n3CY1h+bsiLaLuf7kW2uckS8f/7kWUrLkhiEDYmZMVjFuABVx1zOv08dZEd/G/cGNzpDhlJzfRaQicHZNNptdjoEs2e2OZisJTcQufV/PS8UwmCDaH8ipQBkFf811DX8oTzZuF0f02jjV1gUFe2EkQkfzfjMZa8TMcMlQDQ=
Received: from CH0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:610:e6::14)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 04:37:26 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::6) by CH0PR03CA0279.outlook.office365.com
 (2603:10b6:610:e6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 04:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:37:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:37:25 -0500
Received: from granthali.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 21:37:22 -0700
From: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>
To: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <Pratik.Vishwakarma@amd.com>,
 <Suresh.Guttula@amd.com>
CC: <Kanala.RamalingeswaraReddy@amd.com>, Granthali Vinodkumar Dhandar
 <granthali.vinodkumardhandar@amd.com>
Subject: [PATCH v2 3/5] drm/amdgpu: add support for PSP version 15.0.9
Date: Tue, 30 Jun 2026 10:06:53 +0530
Message-ID: <20260630043655.1284069-3-Granthali.VinodkumarDhandar@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
References: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 918dc88c-46c8-4f55-0ddb-08ded661490f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yFO7khzDPAkmJBtlTT0dj4ddFN2h4Sk/zLXLwYxlsHio+uJgTTnLpB/Y0f9Kh3z/DWlzH2OXT7hj83bZYXtjMA+CiQk0G5xDAc6/R+Rt6Xq65zvpt83pV8bIaLgMZYs5kueBpaV22sDBDpO1UH9n5BmUP6Mx0B2Adgvj1JvRdpOKoABfn6M6Cd1bpcmqMJq+2sjJU0SKjIBrPgBWsN4J86kauC/4InCNTE/i7F6NRG7qKZS0A0xOKtkGeijbGBgyhyZX1RKYQK3f44U4htpMFvzACSFQIaOSREolZ4mfQ63KFYA3gyxsCZbAk2h1DIjjrUve80YGdpi+nZOQXRe9XUfSFrTrrl8tTghrRBsplnEksQkWG1gKXHA67fECUCsCjBmv8P3loAEAD61NTOtWHJ4Wtg1ktFqfvNl794rQK81+G6vFqh1tAfrULAmBqXeZUPGhn0vrWTBo3VwDUtbN5eqx4rAUEKswDuPOxkM6QXvButSPDBQfI8QQIJFX6RD7AG+y4w4c/2f5pIgPKoVMIr82EGoNpNx716bCaO5dk04s0z8C8g9VuPo3nyGccfi5zhrWY+If/8qkplVJzO5MOsHh0HRqHqx70LD2r5EHJWGUVVB1OrOKDDrQOm0aoDkYwmiqFFRnZeOkhn3z32RBFL6tldz1YWcnCK4QUnpRbPdAM3p9HElmbGujx4NDl9QBWuAJWr38o8YeCGC5oM2a+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8b7LUk7avEHprSdeOKG/G1myHNApbxRtpjC8oeYoBQHdXpDVvmrSehaBhgRVs92Kf6iQe16sNcwHCXZL8RrJCNkAXXsMIRgp9enr3vmJ8PZ+t33wUeftzRisHQVaK37y0k5dVtBqm7iK1k9geEdo73J+hyciZm0nNHh4JvsQvBWTVgMQ1kSq7rX7o3stwHyo8G0iF33JRP+Wfus6tj8IuZAj36ZIkJPubCMdOvvrLi+oWai/WtwnjM2r4iBWacvCFdGdw27u6GktxZZQCr4+LwisZcItULwqNLA4EjAf9zEaaIJ/ILA0V8rpf2Eg088GP62RaozFxsMGhSH/sHzPjwiBbW8BRdiitm9wZs2/jLaXvbkI95qqIap+4DcCR7EyumRjN7vQDys9+nM2MSvU72AQ5LAVvfmPjJvoGUQxGXnuE0Md3ETG1kBTV/IE3nSY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:37:25.8534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 918dc88c-46c8-4f55-0ddb-08ded661490f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

From: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>

Initialize PSP Version 15_0_9

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d345bea4f390..16606155a92e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2521,6 +2521,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &psp_v14_0_ip_block);
 		break;
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 9):
 		amdgpu_device_ip_block_add(adev, &psp_v15_0_ip_block);
 		break;
 	case IP_VERSION(15, 0, 8):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4b91a22701dc..a36cbfc1f6f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -275,6 +275,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		psp->boot_time_tmr = false;
 		break;
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 9):
 		psp_v15_0_0_set_psp_funcs(psp);
 		psp->boot_time_tmr = false;
 		break;
@@ -3475,7 +3476,9 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
 			     IP_VERSION(15, 0, 0) ||
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
-			     IP_VERSION(15, 0, 8)) &&
+			     IP_VERSION(15, 0, 8) ||
+		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
+			     IP_VERSION(15, 0, 9)) &&
 		    (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3))
-- 
2.43.0

