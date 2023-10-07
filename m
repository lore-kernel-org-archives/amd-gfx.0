Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76745E95A62
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Oct 2023 08:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2BEB10E061;
	Sat,  7 Oct 2023 08:54:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B21610E061
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Oct 2023 08:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORq1Dv4DqxFby90e4+FrWMhzb086/LbYeKTajEB83Cy/jn7C+19XyVg+XKv8Yx2SUCjAckLEk3M/EcCflA+06+aquY0NKzVYds3L1OZMb+c0v8IdBFETjRBwAF15c3S1/v7CU3gIUI8EJO2CFIqUxN1YPZJ4TNL13hk71o7yKxFDAFT8GT1Y0cH3GoNL0a7Ccx39ny0v70UZvgYFPB78MX6ObCxhsC+It2cgBzrzXTpwTk1u/Q51v1ydK00cAPbJM8LyW9cKR5ePGh9Znc2oIP4u+dKJn0mY9j24YKQbV2CBKV+4iIej5neemJpXe5m4FLrIAqFllZUK5NHJdoHUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x617KIhZpuSdpwq5q0+K3PvAqB4OwrPKDXUYBP1pc98=;
 b=TIQIH3ld9Stm/kbeb4W6XW3prIiBLW88hKiPYqSbblw5/PxHAOnl6MPTKvPf3ic7OM7JEqNG4jV/2x98YdOeXtu7YPwsosJpNxjVC1Dy/2XePyUOxRiQGF2j5aPNEDIqbgUFXvkRuEPJpMON4AaYdWrW3Va69322rhtWw3fUZdiXtSU6zueFMwJlLEhE+z6mvVOwuLpaw2Pqw7dH+fQJhPJBtnO6eNQTtob2hX0evl9v+5Dvv+YuM0bgX1sZE7LLssH94oYshSdmjq3QBI2rCAssd/o2nIi1vIGPa4Lzug2CvH0apKzPdprD9zlrd+qIC+HEMh2xMRnIHmPHy5L3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x617KIhZpuSdpwq5q0+K3PvAqB4OwrPKDXUYBP1pc98=;
 b=FVcA9s8Hb/ygir9Fc6ko5vUJTATs/iTdR6dE+yhDmoPQ4xSCt6UIOtxc/TgCXMb9RfMbJB0404WV7O137C3Zy+yvjHhhpJ4qaffcUqAh5ntAvbYzJgQapgsiQ9AQqWZPdxOaIyb92VNlyOq4tDQSEWj4CrNEo4O8J2z1ZJEWX0k=
Received: from DM6PR02CA0112.namprd02.prod.outlook.com (2603:10b6:5:1b4::14)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 08:54:20 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::4e) by DM6PR02CA0112.outlook.office365.com
 (2603:10b6:5:1b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.31 via Frontend
 Transport; Sat, 7 Oct 2023 08:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Sat, 7 Oct 2023 08:54:20 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 7 Oct
 2023 03:54:18 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
Date: Sat, 7 Oct 2023 16:54:01 +0800
Message-ID: <20231007085402.67350-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231007085402.67350-1-Lang.Yu@amd.com>
References: <20231007085402.67350-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 1763fe17-f46c-4482-3ffc-08dbc712fedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: za2Ta18mJIqSMi65NO88RQOuhBwwZ5U+S5qqTGOlXzLLydcmcYQN0OfCCwp0gtv3WZ2DWaFQ5l1Gwc9Zcpt04FuheWkSp/Sk2gWa/mOh6pgjqfZlqlI2z+b89hVcRieAeCDflYN6aY7SbDtrdwODXZKFfULjrs30+Mly1Ye4NABaw7EmXTo4dy6bySzM7XzaWngYLWKSLUaflfaRUOCunCgtTbD4itKug9ikvdVi+QCXoGeXqGBkN7slV/pTkaaGh1TBl1KvzkPOeHbEUlv83v9tunN7QnwtalIi7v9KB8gVLDmtONKXE56NULXxVb4r5xftcizyILPdC0Njn3q4UG8GoPMa+TIOOhGNxr1ay0stAuicwR815aj4eWcd2ecXUXzrlWiOZ22w2kU24u60MHTKLiAI3IoF7aHwCifFub2JU+5NMAePsD0KfgfXMRJzpd2xKuK+ixRQ/OQBJzhpz8WPvjegBtPRYdKDB7wbT2tF5C8Vi5pSFYPOLLEQf3gl5Pi2k7PdvsIQcjgRG7wn5oiabiMtCjAAiBLGI00Vdx+4MNYFBrkxbNV311I3Q0P/FtZB6wLLlGoCLnWxwWwaUdbNB6EwZNYvS4Btts4HiO37krjg2lcgXv1tIJSi9ZaSir/I5l2f7LtDPTBBEpt0fg7F/lvUkzn7xvH9E6WAwa4sfzCN+Xc0Gl66zBl7wTCHYjvRtTuK4Snwn5l8vZLTVJItZtsXbdjqGZwpkOOz3P11lWPKrspPDzeXg2GirA47oM/P8LZ78SzTvGRxkOvwQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(1076003)(2616005)(336012)(426003)(26005)(16526019)(47076005)(36860700001)(70206006)(70586007)(54906003)(316002)(6916009)(8936002)(8676002)(4326008)(5660300002)(41300700001)(7696005)(6666004)(2906002)(82740400003)(478600001)(36756003)(356005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 08:54:20.1461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1763fe17-f46c-4482-3ffc-08dbc712fedc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN 4.0.5 uses DLDO.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index a60178156c77..7e79954c833b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -34,6 +34,16 @@
 #include "umsch_mm_4_0_api_def.h"
 #include "umsch_mm_v4_0.h"
 
+#define regUVD_IPX_DLDO_CONFIG                             0x0064
+#define regUVD_IPX_DLDO_CONFIG_BASE_IDX                    1
+#define regUVD_IPX_DLDO_STATUS                             0x0065
+#define regUVD_IPX_DLDO_STATUS_BASE_IDX                    1
+
+#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT        0x00000002
+#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG_MASK          0x0000000cUL
+#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT        0x00000001
+#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK          0x00000002UL
+
 static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
 {
 	struct amdgpu_device *adev = umsch->ring.adev;
@@ -50,6 +60,14 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
 
 	umsch->cmd_buf_curr_ptr = umsch->cmd_buf_ptr;
 
+	if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(4, 0, 5)) {
+		WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
+			1 << UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
+		SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
+			0 << UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
+			UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
+	}
+
 	data = RREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL);
 	data = REG_SET_FIELD(data, UMSCH_MES_RESET_CTRL, MES_CORE_SOFT_RESET, 0);
 	WREG32_SOC15_UMSCH(regUMSCH_MES_RESET_CTRL, data);
@@ -229,6 +247,14 @@ static int umsch_mm_v4_0_ring_stop(struct amdgpu_umsch_mm *umsch)
 	data = REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 0);
 	WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);
 
+	if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(4, 0, 5)) {
+		WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
+			2 << UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
+		SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
+			1 << UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
+			UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

