Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A9DFA1FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5F010EAA0;
	Wed, 22 Apr 2026 21:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UlU+ohRl";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A08D10EA8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAF9+hfmjcDTfwo9/7bknn+UDDoXs3tfYJEqsYaEUNzMN9KmR0cDAljW2+CkF4e8MWARateK5PM/xAWJ0FLiYAEDPslBoFCwwBg/HSKnKd4s+yniDJIUUmq2X/pHf4AqzU3YTFvardOWeGTnjz0huwQLkDtmgdA0Cvk/pl70qBz4yYVBNezxNPKWTQgqAagnoUMbJvbLkhCsnpEV6xnZkj2CinxRgUKNWQrfNRAWICn3c4cZbb/qUgOS3cR+YEvaJ5BdocOn3nYR9PYYbyJQIB4DoStalBL4/DroxICHnGgC4RkX695GrSyRCaxYl23U4BLojkPytInuiTvhOHuvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st/UcWjwFzZ4PtCfGdnGswY36Yhcib+oiosfE0gI9Ss=;
 b=dmVgsLQtVysA5FXTLRBUy4GSv24QLuNHKm3VnUIiJ+PodxEtv1OVnD2UcG18z2ZVbIpkPSzIIE/MrdhcxIVJPkCiv5Jac9LMFl8sUd/loh7zdfE8o89RU2W76QAwsjebGHL516ElyrANvNCFuICr0aJpOVeUiqjpGN8hzPxlXVdCPvg+elVCVI+hWskHX+g1k7QWdSqK7m4Yj6rLaGWZoKWblk51bEzMN9/+tBzOUba1Cdz+inDdynzG7+4rk6RDSXQypGnKv/LkujXOVIyrJ5pbnozUWZAvLHOQo1Ss3Usr1zKLYEtmfuhN2owFfgR6Vt93OwAz3imdXFxgu6pjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st/UcWjwFzZ4PtCfGdnGswY36Yhcib+oiosfE0gI9Ss=;
 b=UlU+ohRl45lbIxpDpFUpTsYkntm0eORVndk95v/qh/RsIYQeLfE2Wn4SB/t+lWU4uDOIh+lOQm7S9mpNXxbs71XfnPr70dji5KNmCrNY2Gg5YJijLgDEygsucgd1IMKUaBE2Xfpmru5pN26kq+lSSMqule9wutkSf08dfb6U8kY=
Received: from BN9PR03CA0227.namprd03.prod.outlook.com (2603:10b6:408:f8::22)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 21:51:03 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::5a) by BN9PR03CA0227.outlook.office365.com
 (2603:10b6:408:f8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 21:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 21:51:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:51:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:51:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 16:51:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Switch to gfx_v12_1_get_xccs_per_xcp
Date: Wed, 22 Apr 2026 17:50:35 -0400
Message-ID: <20260422215035.2242622-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422215035.2242622-1-alexander.deucher@amd.com>
References: <20260422215035.2242622-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bdd05d-b643-4dae-7699-08dea0b93ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +vhlKqtIovpT4xvgDuXxxkvILR1Fv5iCTFuB1wL29x/OA4fb/LLk4qWqpF1YIBrWbRI2uBtEvZTDARIsQ960zcXV3mNnpAHk3l9IzDtHto9/bw0Jdhl4xym2+Ue7oG5lpPF8isF1Dukc0Kb4e1vTrcVwfrKEzQUMI1KnFz8VSs3EjUP/MGAeSsGPfdQJ3JzKOo4ZPcY7B3vh4HGevSB21vdUD7kk44h8Oc9yaStrLDtwOjljz/CZTB9Tp+khgoky8zuj6MBOiTTTO9sYnSZ2d0UsSY9JY3ukg6lcok0W4pT8KfHhc+a7AEfb1XlF6Z6jYIAH68TkDFsKmcMrg+zMn8DefjyhLec17F7rD1/iUJazA7LEB77leir0gp+hA8nhfM45TyARc3Y0F21zI/DSO9Fnad/im0l5JTpjqNKc4behY+5o0w6VyG+MbM7b6o5cLYQtpdwNaf1KEJNF0bLOVWDBPcLB6nNncJO9ARSvN7ZPaDIkbTkOFsEVkhS+u8OSCc0Uj+CmDv0BT0HW4u55mEuzr7u458qYY00982gpDmLy/5SC//HFRDuVSbKHLHFSHUhbE7j2ASpSKpOv+RNYUG8tv4WtJ7/pG3PNiVSMPET577yH6aSJNGenNsRrY/QJJecpXdAQG9q5Jqt2kxoLf3dkAcYn5TJjqp0UHU7GPt+bZQ6d2KRtTZi6oZ+RDtgqNwrqSbyYjuDTqxj6eNp8bHKJcoaA4cqYuAWCv25Lq12/8jmiRSytVRgVHArOCNdIvUA9Np8tDcZtQFQnqKrlbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5V88PC6jqZ47Fwzz5u50R2O6MDDCa14XAXcxvJ8DCycEPW/4eiZGG9eqn4rLIV5u/UKXW3D6osZNVUAheEbqiLuLspBuCqEtbgSyYmisKkCVr2nuxS3Se/5Nl2hZ5+O01f7F1F4SWXytdhu5346bIODRM8ZkTV0XbTUh2pGj+BgjI85cqXbHGNerKgJVDG3PlYjCCqFSQ1zg17LhYjnxlYgqg3mwGygB1WNpUCHwu6m9ZlnlIpb/or+AoSQuNmE7vDFpj34GL0NvjvCspkC77CfYaNFipGFYsb4n0ijJj9PFUNEJNw0MOiABGAl/UTeqeFauy+c9vmpg2cdPXTlMTb8hDqk/coGzxBop2HLqJn2woz4AYjlL7zKp0x7StbZRXA/B8smGrKwXjlV+BEV221XwRgGbrUMV5ZoxxSrgdqO9p/u2XOOzSVAbIsBvgRQ9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:51:03.5795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bdd05d-b643-4dae-7699-08dea0b93ffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Use gfx v12_1 callback to query the numbers of xccs
per xcp

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 6872ce3f3ebbe..5412a528f78be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -718,10 +718,19 @@ static void gfx_v12_1_select_me_pipe_q(struct amdgpu_device *adev,
 	soc_v1_0_grbm_select(adev, me, pipe, q, vm, GET_INST(GC, xcc_id));
 }
 
+#define regGFX_IMU_PARTITION_SWITCH		0x5f8c
+#define regGFX_IMU_PARTITION_SWITCH_BASE_IDX	1
+#define GFX_IMU_PARTITION_SWITCH__TOTAL_XCCS_IN_XCP__SHIFT	0x2
+#define GFX_IMU_PARTITION_SWITCH__TOTAL_XCCS_IN_XCP_MASK		0x0000003CL
+
 static int gfx_v12_1_get_xccs_per_xcp(struct amdgpu_device *adev)
 {
-	/* Fill this in when the interface is ready */
-	return 1;
+	u32 reg_data;
+
+	/* the register data is expected to be the same on all instances */
+	reg_data = RREG32_SOC15(GC, GET_INST(GC, 0), regGFX_IMU_PARTITION_SWITCH);
+
+	return REG_GET_FIELD(reg_data, GFX_IMU_PARTITION_SWITCH, TOTAL_XCCS_IN_XCP);
 }
 
 static int gfx_v12_1_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
-- 
2.53.0

