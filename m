Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56178D1950F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE78C10E480;
	Mon, 26 Jan 2026 20:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OFdFXjWx";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013045.outbound.protection.outlook.com
 [40.93.196.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5BC10E47D
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/gH6m3MS5a/okvTDC9cYYb23Aq+6yPnOUeq5AZr2J17dj6yGWz6WFG+EzjCNOl8r0fxFTWFxSMEcaebTGBrzBtFk8BRYzs0vf6cHP2Kdv/bX0tbBpOZ7WPsPC5S2j/QZTecaUISwB4STDhC/4Z/S22Bd5nW/vYJDbGpiEUZUQt+X/d2zv8fHoiBEqqk2PuL4k2VeGccn8fgg6adyYU9N+5s5q+upPQOpmZC2JvogdNZmeH2KL9pF1HeXQI8CoLk+rCeEWQwMDTLRCbQoMyLrtgvklwciWq92Eooxt/uAA4mxwihID+Mrr5uOfdbBF81ge0FgAOWgoszORn+YoV1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9HEWqaZ4w1tbBL7JphNebx8oseRyhMDx/IyL3p+xDo=;
 b=lvZwZIHAb1a1+O/jxAgtr+ftI6Y8s8Ee7L4x5X1Cs3rjC0oCFanGa8siSyY4ZZZBuKjg1P2AsffVAshMpThKafo3rO52YdA7Dd2L6Qoo4JRwnJ89TcTxZjqc/59CxJ/6AJ4zMj/V7MTInnQvlKnlJvTPmoYgeK3hgA0W0IK+z55pmFtl/F7MaSOn0v12k/FhobnBL/eDK2tzje7r7Lk7nXuiS0cO7RAkAECsM529oYfS79dZROV7BdUh2bZnw5OQQ2fyUdln7pwWQ5ShwXaqEL2dmlI8hM/6v36rgDRvLyLVgOAznrf2gfm2GkuT5LslkWKzC0AgZAt6l4bWJLUmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9HEWqaZ4w1tbBL7JphNebx8oseRyhMDx/IyL3p+xDo=;
 b=OFdFXjWxTD25b5qmKs5r0B23X37wvEDg7MUWf3IHaOZ9EHOkEMOUZqhkSTue4ts18JOX20oa5wvdmr4LJaRbDp1Vp5Pr/IcHlcfp+QrfR3UjPierKRQdSDjtrgDI3bFdpv108P6wfnyJsPF0+DR5kGEkK2gt/3uxpEiHvKd2rfI=
Received: from SJ0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:33a::11)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 20:08:09 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5d) by SJ0PR03CA0006.outlook.office365.com
 (2603:10b6:a03:33a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 20:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:08:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 14:08:01 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:08:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 10/12] drm/amdgpu/gfx12.1: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:45 -0500
Message-ID: <20260126200747.13527-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: df88e730-88bf-4b29-b634-08de5d16a019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YQ73p9KnXwLNxgn2r4Z3PEhxYc4re5SI/lu8Cgaw5eZOjNbUSpB3dRlpvtP7?=
 =?us-ascii?Q?4lexYgnNBnx0W0rb1KT9Ez5tx1Psx1QpxNeXWlgoosKRI4WwMFg7wmN1Himn?=
 =?us-ascii?Q?n6Hc3dlE7fpmHq8W0md5pvA7DA1mJ8vuZ0KObRfgkDUjlxfVPi9lFt+P7vsc?=
 =?us-ascii?Q?8fXL8bT1LNB9CPrFtN3f++9dBqOFYpbvoucjLJIlzJmzhxGtVox1ndHr+7Dw?=
 =?us-ascii?Q?ujgKFeWGi7XCw762UsQLtSoso7svchGorbbEyblNE43JvBQu/yS2k88ionXu?=
 =?us-ascii?Q?GO64PDWCyAhdiBdMajn7UXZ6HatxjxsX7YTFBKhouHsu8UEYKSrCxqEks/hY?=
 =?us-ascii?Q?dkT/9KnHpGicxF9JCk9CA2+NsNNxzTIIfV2ylRwJy7O31WshZA3gWUwGAXIp?=
 =?us-ascii?Q?sIdLMEQxpRIdDpMcxVPGD+6J0qPefAj8nyeayG/9o3kjfx9fXwc2NYcQTtkO?=
 =?us-ascii?Q?OQNpXD7c79oxZ0yOCAg6caM/AzMug3zIOfEbVkQffuQ/po6+b7uTy3BF1fvI?=
 =?us-ascii?Q?oTUZT7MwRIRuAGahKak5xlf6p9QFqqGCyyIBgVRGt2D9WvfygQOMh+cZSwBV?=
 =?us-ascii?Q?5nIyyv/EQM31NJfsNU8WYXKkyQeiVf2MCSDLd9c38WSLkcimqJw6ESp8HG6l?=
 =?us-ascii?Q?Fno7y/AgeDEmzCZb6w1njqqBx+FQaQwWNm3erSeDhddLp5onbpGQQKbJ67g0?=
 =?us-ascii?Q?x9XQ9TIWd7VcbZqx17KPqQeewfcKDJ5dIOAA3+69PLgROIM0sLYtggJrR3PH?=
 =?us-ascii?Q?moWBY50NpOoeRU0bw2HUT0pqp91BDX2CCKr8VdgpC3U3x29vugciSrW/4paR?=
 =?us-ascii?Q?EmFoDj01Y++KrJ1yY+cNgecv1J4z0MG7Fxwvh+g4YRMSmoUUfBUvY/5YZ/K5?=
 =?us-ascii?Q?HaIVZroO8HLQjgtXV8K9LB4kfG1uBmbEH5hDwjSGN7bXPBYQ3e9/EO4IjXhW?=
 =?us-ascii?Q?znIHesQ2B6X9XPyPbUEPeoGhHRNGKZsss7+dc+dTnXeFNOHebcP+xcUP+Xrt?=
 =?us-ascii?Q?HnYaKZI9WsNJ/Kz7+3cjscPiQvr9X1cvBItGOGzr80A1m8ndApIp8tr8ce5f?=
 =?us-ascii?Q?ZJQ1yFTVoE14mDYhdPrHMF0xT8kscAfVS113t6Vfl4gYULGMK5g7gGff6B0V?=
 =?us-ascii?Q?kthGIt+nXSXx2YJU+W0w7toFC5rBFofAxBCZ2N42VwVoZetZg/ppcYFvw0Cf?=
 =?us-ascii?Q?i8SpZPLejhHXENt++FRgv8JowN3pvhs0TexsJhjvM2792+1QDxgbN1FKO5hh?=
 =?us-ascii?Q?4k8jRF8QxF7vlx9oIws+9AUARujnZ91SMY4KBHEMLojbFWVqRncavFq21PEw?=
 =?us-ascii?Q?2vLuoDPqvO4JzcrcmFfZtdR2Le/CrjjzfVaAbGlgNHL4U7pKL2OthHrj/muw?=
 =?us-ascii?Q?pVrhWk607N1TIvGRTeSrKvv2wfMOSuVSe6uQcgS73Bii4Y19XYhgFoQ3n4az?=
 =?us-ascii?Q?Kr1H+Eojnf7I/UgC8ycGiT5OfjvbcNHESnoHBCSYPqQOt4PWOwJDIX/RXOLu?=
 =?us-ascii?Q?t9zNxlP9I/QczcQJHP3T/gf/uKaIzuISCLZBoHQpcunXyav1GiaGCjioh19Z?=
 =?us-ascii?Q?h4SNyDulL4Nt5JMELskOBF+hBXxgM60iYwh/EBKT5CO5foc4XcDlzR/ljd1B?=
 =?us-ascii?Q?RSFYWV9pEl6+aCoinL8cA4JRHoBqdZdKrLtyjlaoiRBeN4JwoZFsNP9NxxmL?=
 =?us-ascii?Q?+WMrTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:08:08.9077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df88e730-88bf-4b29-b634-08de5d16a019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 2519bdf4d109e..8116625c92d92 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3575,6 +3575,7 @@ static int gfx_v12_1_set_eop_interrupt_state(struct amdgpu_device *adev,
 {
 	int i, num_xcc;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		switch (type) {
@@ -3598,6 +3599,7 @@ static int gfx_v12_1_set_eop_interrupt_state(struct amdgpu_device *adev,
 			break;
 		}
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
@@ -3668,6 +3670,7 @@ static int gfx_v12_1_set_priv_reg_fault_state(struct amdgpu_device *adev,
 {
 	int i, num_xcc;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
@@ -3680,6 +3683,7 @@ static int gfx_v12_1_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
@@ -3691,6 +3695,7 @@ static int gfx_v12_1_set_priv_inst_fault_state(struct amdgpu_device *adev,
 {
 	int i, num_xcc;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
@@ -3703,6 +3708,7 @@ static int gfx_v12_1_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
-- 
2.52.0

