Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40552C05027
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 03:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A6310E03E;
	Mon, 20 Feb 2023 03:17:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4120710E03E
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 03:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qx1xutWzeE+VP52vjWlBWTd4MRdF6DVHOyZ8fWoxNjmB9A3hUDiOr+7t+Ab8wm+P9dfyBiGIkPPUzbgcKnDtDFr6LaVvf0Pi2LZrRdCC40VUePmwIPom8Z3oXaEXn5KOtFV1NWtbY62s5wjf1HYdLCjH78Mk2zhu/WiBsNyB2VV1EIiFExfotcMSmsIXUW+ajP8+DWSGZb2Ba15DqTh2fTxa0MS56ubW1h93PSIzVwa4vdi9HCYfDEpaCmD8u7V/I3meRzOEq0gOf1j8F+/SKhQptxnPK2XI3scbLBCoxeMQauYgKj0qPnwAAmKFeGk2oYF41OLMY4ooCP6kIznDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57CjCCi6B4u0Cb9EInfqLDoULPnTs1BV6/zUa5wBNso=;
 b=ErE4sgty13M+NQIZp9GUibHdkAYefjMWTesLGjxMf71DUWvuDkxONAfPDEir9i+OVReiFwE5z9v2h2U7hpFEZWUtxBfIZccKlMIQUithc3q8jWyvzxNiblyuxcDZiHg3x56WhhUGkqbgcN8ShZzDlknk8+12z4JJwt6cGzkZFVz7Y1zqD3cF/l3/gyN2+gFKyDCn/ASeDKCkJHmtY2cjkdYgOOyQxnr/l75mwveu/JuLFFyUfZdDgJ/WSIgrfrfJaEMFmlL+CuD7P4VhSCY4U16N17DhjEbFruSGaixIDyO4PoibPMhbjlnJZXb0rU3Q1ibY/L+YIo+6x+35YYhsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57CjCCi6B4u0Cb9EInfqLDoULPnTs1BV6/zUa5wBNso=;
 b=mmXL7aTyZqDVU0n4yUcjJ76OcIDUxS7Mh33Fy/8BfutOjI1BV5w/LDTOJvY7kxmiXsNYjd0uN025DPYj0kjqIlLsuyxRWOzbkWe2E5yAe41nOGU821dLgrWo7Maq2rnNdSGh1dKCATR/2kdkq4F4PhNm+QyQ0KIjpEjY73YRTok=
Received: from MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::12)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 03:17:29 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::91) by MW4P223CA0007.outlook.office365.com
 (2603:10b6:303:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 03:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.19 via Frontend Transport; Mon, 20 Feb 2023 03:17:29 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 19 Feb
 2023 21:17:26 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <candice.li@amd.com>,
 <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add umc retire unit element
Date: Mon, 20 Feb 2023 11:17:16 +0800
Message-ID: <20230220031717.18738-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: ff47c98a-1657-433e-38f2-08db12f0ffb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTFlLmRScSx+SIpKqw6/YyRi96FnCj3Dd0yjs5kxPB8Sbtxwf9PzG+5xmkNmpKyEcron8mmTKYE89aA0OT9ER+AIkhU9NLtY0ZX/kTYZ+OVkjbhEvah1FslVJ73j/foHl2j0JzAm8MbbFXuCAXvKIC6JwRmU1liZUlpT/gI69dRSUEM2s5FGYTtE/3E5N0p8COxeg6Oan8oTj0nbtTOD13AexBWFGKPikBDJZ+exCaHjESPn8jHNCHgjlRGSGduK4Ox1yOF7ve3AXXURnQk08Jgwju1XVcQo8U2RbFM+x0qEUfkXJbEKnIIXZa/S8erJznIbjShaMIcmyuZi134dhzokzREgvbKxW4Ar4bSmflqxU1UAmA03lOzburMm+Fl2zKQEdAlVumNcWhkcoKBJsa52p8xhodu5oguQ/JODHWpxb/hQ08VBV+xxXaV2Nu5a9koYv+rQ1PnWOfs5aejeiM8iWnZjMreYUCAOUoWDe/3a7nP9gzw3YYYBB2pQPFWXhKxPtGjPFbieuUSYwQqh2TYFWZdbWJ6Sjlz+eDtLD7EHvVl6H1X6q891+JCK2TVYaS340oQgD1GbCFi9Mcww5P1qqF8F/F+ONFXnox+1+4kQrajX5Gw0NFIgLCFvLeSjw7rzGOjymfjn5x6CN8cB6mxftXIMTSWRSFwBuJgTFpr4IS4wQ4dHjXy/BVnuRQjRI79X6kDC0SyN/fXfi+p34RiQ39zlAHeheCYRgr5IGBY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(82740400003)(36860700001)(8936002)(110136005)(2906002)(5660300002)(81166007)(356005)(426003)(47076005)(40480700001)(86362001)(82310400005)(2616005)(478600001)(336012)(1076003)(7696005)(6666004)(4326008)(70586007)(70206006)(8676002)(16526019)(41300700001)(6636002)(186003)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 03:17:29.2659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff47c98a-1657-433e-38f2-08db12f0ffb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It records how many bad pages are retired in one uncorrectable error.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 3 +++
 4 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index a6951160f13a..f2bf979af588 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -74,6 +74,8 @@ struct amdgpu_umc {
 
 	/* UMC regiser per channel offset */
 	uint32_t channel_offs;
+	/* how many pages are retired in one UE */
+	uint32_t retire_unit;
 	/* channel index table of interleaved memory */
 	const uint32_t *channel_idx_tbl;
 	struct ras_common_if *ras_if;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index fe2c15f598b8..c59c2332d191 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -696,6 +696,7 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_inst_num = UMC_V8_7_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V8_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V8_7_PER_CHANNEL_OFFSET_SIENNA;
+		adev->umc.retire_unit = 1;
 		adev->umc.channel_idx_tbl = &umc_v8_7_channel_idx_tbl[0][0];
 		adev->umc.ras = &umc_v8_7_ras;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 0a31a341aa43..85e0afc3d4f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -570,6 +570,7 @@ static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.node_inst_num = adev->gmc.num_umc;
 		adev->umc.max_ras_err_cnt_per_query = UMC_V8_10_TOTAL_CHANNEL_NUM(adev);
 		adev->umc.channel_offs = UMC_V8_10_PER_CHANNEL_OFFSET;
+		adev->umc.retire_unit = UMC_V8_10_NA_COL_2BITS_POWER_OF_2_NUM;
 		if (adev->umc.node_inst_num == 4)
 			adev->umc.channel_idx_tbl = &umc_v8_10_channel_idx_tbl_ext0[0][0][0];
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d65c6cea3445..b06170c00dfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1288,6 +1288,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_inst_num = UMC_V6_1_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V6_1_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_1_PER_CHANNEL_OFFSET_VG20;
+		adev->umc.retire_unit = 1;
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
 		adev->umc.ras = &umc_v6_1_ras;
 		break;
@@ -1296,6 +1297,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_inst_num = UMC_V6_1_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V6_1_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_1_PER_CHANNEL_OFFSET_ARCT;
+		adev->umc.retire_unit = 1;
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
 		adev->umc.ras = &umc_v6_1_ras;
 		break;
@@ -1305,6 +1307,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_inst_num = UMC_V6_7_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V6_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_7_PER_CHANNEL_OFFSET;
+		adev->umc.retire_unit = (UMC_V6_7_NA_MAP_PA_NUM * 2);
 		if (!adev->gmc.xgmi.connected_to_cpu)
 			adev->umc.ras = &umc_v6_7_ras;
 		if (1 & adev->smuio.funcs->get_die_id(adev))
-- 
2.35.1

