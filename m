Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D5BCD98DE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 21:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41EB110E722;
	Mon, 15 Jun 2026 21:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EJDOeF5Y";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8ADC10E6CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 21:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoSNKQ1D4YXKphz67lZPKfGOkRAQvVO/1q4HbB5eKCGF1Ek3RbP3rHTnXYDWH1qmAaQcvprGemwF+bhj+QZ+4LP6r9y0NB69WZHSlzDl0CmOrtKbgGGjmUCiWRD23q2rwoaGS6KcihuN3UEHOmV4znPzez6zItgYOrgvr3P3S9UA9aON4aftXcBn6hi4qn5p4jEp5oiNyOS/Q9mtPb7DCGoJyf52z8qUOuy0rzGmvcCYn8bEF0YQVu7rFfLpXrsrAzmNKeekpJvAH0iALiaDRWd/f30/+1QPMMUJWTcMZJubQXEtz+mrd2nbJkGFSGhmZv2JjDeUzxr6fdFuOwGzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCI8vI/LfTxrdbe2zc3LJrDspNKM0otaz9NzA6dzxEg=;
 b=VC7ewmXDcPAbZOWFr8GTBH5CVV+1ZFiEnEcNjbhzx8W+cFax0eE+YPUsvhjjyv/zKucDKU2er37F9oPiVhDmGReF8Tht2XtNTdOKoItO+zMVLSUNj2VX/uVF0k7Tn8qXP8MDdzl7O6Z7FJFlFHe3jbUOHNVxnBMx6qRCe48sMNUG+K0zjzR0CJb2yFxlCRgqNb1PCTrJx8l/k/Zv7Ioei+ren1DpZAILVzg78aqWX7/+bJ7zNZmUR94dPAFTDjl8AXPSMKDo3MdIgiX2/MeA59WsbwbpGcnPvuWTws/zjQY9p8wVUx1t+pH2s5fekzMacPNK23pa454gWNiR1wQFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCI8vI/LfTxrdbe2zc3LJrDspNKM0otaz9NzA6dzxEg=;
 b=EJDOeF5YE4Pljwj7og83RlmZgTUVEUeL1sPj6Osjg9BoVKadh9+g5uU0WLtpgCNOaXuGlMfdRqx08f/mTKMefkb7dNBwFFCXAohi9dN/VSF2edaHxuIekIDxlF4wYeo13bteNOBXPlHb3XMUoekO5ZqcGZEZnxmXHVfCqzaqnEE=
Received: from SJ0PR03CA0094.namprd03.prod.outlook.com (2603:10b6:a03:333::9)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 21:17:10 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::76) by SJ0PR03CA0094.outlook.office365.com
 (2603:10b6:a03:333::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 21:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 21:17:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:17:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 16:17:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kent.Russell@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu/jpeg5.0.1: add support for disabling kernel
 queues
Date: Mon, 15 Jun 2026 17:16:48 -0400
Message-ID: <20260615211654.676386-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615211654.676386-1-alexander.deucher@amd.com>
References: <20260615211654.676386-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d65293-8484-400a-f790-08decb237649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 80+pgePyhvNbY2/ndKiGHC+lR7tC9gYrLCiSXbKKeFWzCXiXlKIQloE71JK5UG8NZMe/HSrg2gu012gtU22QHhapnBkCVQRs4FZptj+Thv4CuGjNd/HhEGI2vXqMroQPkDsqK+ugwKlCM253zvXX0tFgRA6YoU7kRtIiyr/TfyFosorMiepslc+iJKFcSqGMY7zwIR0TocgDzppyuHc+vthbCDKWBsYwLaa61oZJH+po5pMWmGyv4CEHdW7TGDlRVjW9tQvjfq0CorkuCpHHUEAUK6qwGuHn9an0TsCNiZlz3u27FlFE/pXkoY7gTjT8DRBnyMbBtxX98KdKiupHCJ31ij2nfS0EUA/R8CZLJ1TmRou8j00vY5wqFsO5PnqFaN3SJ0ymuL9Vl778/SNif1PS3sM3oazkJBV5SmFGLP9r7rLsw9Hb4eDnZFzeZWCdr3bTX5EmLKT0QlcrpLPLrivGkDiQob2fF5FrI+NxAtkRTmHTGxPkkmqX37S4AInksYgKACwEN6e07kwTfS4SEWk+FTXpDQf5nGQWaU7KSqd3o+z7IzqWTvor9xDkyZHSU03NHFbaCFVr+bt/QsPBuJuROCjruBB61tGJRTVqcFl5WWSl87ClXdWXOKKI50xil1CjwyyEAnLfDuHwZ8CM1FQWHOzkiSQRyFY7hC8NonIBbjokTEvXEFL83zpKByXkwK5H35mRG8MBmzkRXjKS9GKStNjB+5TyBS+csZis7Zg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WY/Gm61IOwkNP28oPVYcLiFe0RGUP8HwI3YsU8fnUM2+vKoWXkdSKMRNk9sGd4+KQdgCR/+pgWhkrFfmzMiDeeZsNiSn5ZRScVmcVoBIMuCTyLduQuDhEQg+2sc0WVzwywZel0M0cmAqiSOXKk74KCbmAob8qH5kFxpHPYjZJO4KOXpy5mEs0P57uZTwoPelp5OUjOA1t/5XUtUKLGNsTAfe9J4Qbem2fmBOKpqZD18PQcuVlPdnymZqQWyFpxMDEOpe0+PS7UnqMzvHNGpLixgLL4zV3yc/O5zhx1Lxq1zemSrWCxlnn7129v8tCKCcYSAl7IZGGFGQFjTtCbpDN1j8WEg4xAp5SpCXTj9+ye8bZkKmdSkDAnoKw472gjPmxTPTt5yJUZW+27xiVvu2E/nkd3QqVJTbQn1JE6h5Ed0N+wX9VgBD2GMM3kKPHxh4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 21:17:10.0166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d65293-8484-400a-f790-08decb237649
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435
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

Allow the user to disable kernel queues.  This can be used
to free up vmid resources if kernel queues are not needed.

Set amdgpu.user_queue=2 to disable kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 250316704dfac..e023ae958459b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -118,6 +118,19 @@ static int jpeg_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 	if (!adev->jpeg.num_jpeg_inst || adev->jpeg.num_jpeg_inst > AMDGPU_MAX_JPEG_INSTANCES)
 		return -ENOENT;
 
+	switch (amdgpu_user_queue) {
+	case -1:
+	case 0:
+	default:
+		adev->jpeg.disable_kq = false;
+		adev->jpeg.disable_uq = true;
+		break;
+	case 2:
+		adev->jpeg.disable_kq = true;
+		adev->jpeg.disable_uq = true;
+		break;
+	}
+
 	adev->jpeg.num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS;
 	jpeg_v5_0_1_set_dec_ring_funcs(adev);
 	jpeg_v5_0_1_set_irq_funcs(adev);
@@ -172,6 +185,10 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 			ring->use_doorbell = true;
+			if (adev->jpeg.disable_kq) {
+				ring->no_scheduler = true;
+				ring->no_user_submission = true;
+			}
 			ring->vm_hub = AMDGPU_MMHUB0(adev->jpeg.inst[i].aid_id);
 			if (!amdgpu_sriov_vf(adev)) {
 				ring->doorbell_index =
-- 
2.54.0

