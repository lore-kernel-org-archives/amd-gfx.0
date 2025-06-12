Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFE9C71136
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 15:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9E710E41F;
	Thu, 12 Jun 2025 15:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xOtqui7l";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71FA910E897
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 15:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaFzBAlKois/wKDI2wVXyo60C+oMuInTSEyUB0yehNkkIFlvDlD2fJafkI9rUjjlmfvuBIQJb4ItWbd9Emh4SZFvk9YnWd/OwwRpyok1g/98P/R/uTcBzv7qLDJwhAHioYAn8WddVby/CZeboWwmyLTxcOPLy3dDucSXWnoAJwJFFPbGpIK4lff/uLBq48QTJp1gBkcGxTZ2VsUF8n++iY/bMo7dfqbb+X2ThZISyk9ZKKygVTlm5RynrGqw5IjqYQtZ7T02/tGDrgDcZDtVj3CGWRvOgJ1geolREw3d5mn3fEh9z6A9EqHSOvJr9rYJBNLIOZDnZsn2XUgkn0sevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCbrVJVaUXi3usTaacERtz9gWalFjaY0wL2aZs6fIvQ=;
 b=KW0sCRIgwYah7AQVhFcujX8A+rT/H8b4T22sfbhKWqOYEaX6xFrHWjeCVRR9g8cBSARBi++/rLUghBQId0siZvrYbyQWAljAXE189nH5kam7r8xLpRFvPDUNk3b2CTDpAN/u9urI08Qkzg439qE5u4TVIyOEJfrYMgI6sTfgDGdBmC1taql0K1FK51yeqPLnB7fhKv0L5CXVBg37VENkJ3t+q38hkkv8z+nshtdpLKh0Dv8OCeYY+fTulUeduTpk6XV1R5AVBtJ/fK1lmz3Ba8ZhI6Fbku/RGqHJ3xrmFM9nuP92vuzjN4Uj0E+DcmH0HDUxNcR4lmBf8VhPYdKwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCbrVJVaUXi3usTaacERtz9gWalFjaY0wL2aZs6fIvQ=;
 b=xOtqui7lrpgfkv94i2KMGlxBBrNIfkC8kLybz6WFaxpXlqRNhd3xDJo6EOxmiqjJEKFOyYOjBpJ9IF9f/xcJ9zqgnqMpGdZr4tJUU9e8TKTfNx5yfQWQdhUwMZZUgoqHsT7plC9U4kELoDAfGUhYqZiRsiN7MA+h5wdyRkfXd7s=
Received: from BN9PR03CA0629.namprd03.prod.outlook.com (2603:10b6:408:106::34)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 15:16:19 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:106:cafe::e7) by BN9PR03CA0629.outlook.office365.com
 (2603:10b6:408:106::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 15:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.0 via Frontend Transport; Thu, 12 Jun 2025 15:16:17 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 10:16:16 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>
Subject: [PATCH] drm/amdgpu: VCN v5_0_1 to prevent FW checking RB during DPG
 pause
Date: Thu, 12 Jun 2025 11:16:00 -0400
Message-ID: <20250612151600.966838-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e06a42-199f-4f67-5827-08dda9c4147c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NeRKnCHiqUQzb+iJcsFr8oVJmynv+Hrfd1QlaxzKaniekBnCobHuH04GjrNF?=
 =?us-ascii?Q?fcBlnRoLZS7pclIupfcp7xcOfOu7mU+ZZ2Oi/RMSVOB+fXvY17Q5e+k4c2zo?=
 =?us-ascii?Q?A5Z4u7OYn5J5kfWN6aq57H4gz7QaQr4PDcCP3gMawVn30iM3zfj/aHWqZk1b?=
 =?us-ascii?Q?Aw+hh7GJsVlJpCLzyzkYUN3h0MEYaGhaJDWpBC/ZqmVrlM8dRt9Ljs+nY5Lq?=
 =?us-ascii?Q?aBXId+OhsYY+VZUbjtoFJfkjztD3kMGQ/VRKDMsYs7IWVNQREtDsA4GTIMOl?=
 =?us-ascii?Q?c1nRqDjbP+2j0xYhT7v/t5Vj8EE/Vg/kyft6OzfYXzsiNEGDzWx63qegZt9H?=
 =?us-ascii?Q?OolSn7uN+RXFZXz6jTSLvvXYaPw/es3We8ShprV9LjgMF9BVFQuq2IbF9XKi?=
 =?us-ascii?Q?LhLUTHiQHvoEK5dnrecX5bOYjKl2FUaUSEQ05y6p2DiioJwGmFF3FBvE2grk?=
 =?us-ascii?Q?nDr/Z/qiFyjOJY4ajEwwctCnGNTAbqhp2SXoJtiNHxfVlxIJkxfQqXgxw+5g?=
 =?us-ascii?Q?RZUk5Vi4H6okweYxDWIv6pmc1w5P2O8298GZ5Jn1UnFNEhuDSMBDf/3e2rbK?=
 =?us-ascii?Q?38jOkvhmvvjEpkQPLy6BfXpRs1F1JO3ugRg35ACtRkoJtgeo8KhI/QDgd14W?=
 =?us-ascii?Q?P8kJcEa1vLyqJUmlIIRVKcTFNofg/LRMNnh4L5h4ZtcWn4ttq/T864VglbXa?=
 =?us-ascii?Q?u2Mu5xXI2g2/DUVWDKJ2/Uz47dvvubU+TQ8tiI2+DOtUYYBhG0eaSHUDIl0Q?=
 =?us-ascii?Q?5RHym3Q8WQ77ISHQJHCVMyxcZR7Yqf49SCAK0Z73IvrjmG8vEGk4ikrBK+Me?=
 =?us-ascii?Q?Y6igDr772uoR/4i4ml5KwnJWJoZp64kK1pCQUWvZB135ZfnTRrmgmTodhoZA?=
 =?us-ascii?Q?VTqnJZeC12vWDjq1yrHbyTKKqHRvQIpvM5Q7y1hM3BzPQwY6RmgsgfmYN6Wa?=
 =?us-ascii?Q?mKvZtDUPYr2AELKaQHF7ry3RFk3Za73crP7XwHVt/mmjuBPgdIzPF87wB+yA?=
 =?us-ascii?Q?DvUc/K5eWPAeZWtex69iQMEMWA10mPoAav5mK0Lu4XHGzBr6zizWA+yu8++n?=
 =?us-ascii?Q?vt17aeTgDbVJwn1Pwt4rhpstg8GoS3rlgta4G4QU8AZEqxZkCuGC4x2nJDGg?=
 =?us-ascii?Q?voxNuccrgvtyLrTmMTZoNnaLB3yMej8cZkSXfp0ujdHxe4m4ICTO/XB44cMN?=
 =?us-ascii?Q?/oZ8wEMiP/8YwnAcnu2JyO++YZKLXEqt+C348Mdcub3CjF3WuwzuEeXv0a+H?=
 =?us-ascii?Q?x7OoxL/yChL9Evd9+qQsIr9o7sj6b8NPq/in50M/NMrPRILEVMXHCOdrwKKm?=
 =?us-ascii?Q?aU2i3Q7puH98h1TEqaV4gNB0rRlg5+JicmDLxXq6jykriaUVfEhFhbUHXiyL?=
 =?us-ascii?Q?Y6Es2HbxYPufFI0yGKC8EPEholulxirTy134QoQzbqJL1BYAgkH7VeWHtRT0?=
 =?us-ascii?Q?XQlMV4tSTEl8le2jiUhDkaExICu/cYcNBiyWsWWK5ZGw9meFKGPQAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:16:17.8396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e06a42-199f-4f67-5827-08dda9c4147c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
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

This is a WA for unknown WPTR touched during DPG pause

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 338cf43c45fe..cdefd7fcb0da 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -669,6 +669,9 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	if (indirect)
 		amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
 
+	/* resetting ring, fw should not check RB ring */
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+
 	/* Pause dpg */
 	vcn_v5_0_1_pause_dpg_mode(vinst, &state);
 
@@ -681,7 +684,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
 	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
 	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
-	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+
 	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
 	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
 
@@ -692,6 +695,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
 	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
 	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	/* resetting done, fw can check RB ring */
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
 	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
-- 
2.49.0

