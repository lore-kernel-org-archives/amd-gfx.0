Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD9E1073C93
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 12:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043A910E63F;
	Wed,  8 Apr 2026 12:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GNj1+967";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F22B10E63F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 12:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNVr15fmahkbyimzmgoCnSHd9aMRkmBOWmqyz/8l5ilW04d5fXGvpxknMJOGNQ270oBVDw/CdT3EfEDvgKZPrUMKpfvgXYsGcH0zUEIaefvg2lbmEF8I6uU+C57N6qvNcwdmqO1BLAyYQRo5nsl16TcykNR7IzdcbxbEZWGnRmChYkOTM9SYPCW2oihX1+ffuaDA/S6avWE4Ym/m771irs+fJg5VYnFm/ZS2x0v7RF2zE9/CMz7zsUx9U+WIWtLS67dqCqd+XYpyFuv5e2xQr6t3HZFKsKatFN0pTIfFwgcOXxdjmyx7ywOkRib3xk3b2AXr+a+8eXsF53CSERdxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si0yQQZqfDSIze6IemEc9NniJ0ire0qt1RwkFhJ1lEo=;
 b=OhM10l3HfDFyoc3GOEXk/BEjivLMsuNmGnaEmm3lt6t7wjMfHmlaSfIfLSLlR8SgBQF6s3LhDNL/urejPUV13CELla5v/vFm7b81mYTdc8E+AvGCNVNQZYdX7o0svjWGwC6cxl94OqjKMubcOWwjEmfgJuCePVUMhHAieT4XH9qfo04X3ft7fJXzeOHdzChkCqxhRklLdvMoMUq9LdPMAB4Bkw1wimj2+FJ02u8G23OyhBgw+3TjJ9McP/NVZqMiVU1oZpAdTVC62lYuaucr31ZfRRXK5AcD3cEyGJLmeFPsjZ4tw80SGRehdTRspS+Yu8rsNmPewQwrIM5J1Fv0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si0yQQZqfDSIze6IemEc9NniJ0ire0qt1RwkFhJ1lEo=;
 b=GNj1+967XM9TuAok36pJp92+FOGbKoCKuutDFud7BMAUOH7WeG4haIroV5B8J7DAxybHv5ZX1oyxdkori0RyY6ZkflF2Xt5Kcb5BbhgKR2TgSXDJAdfKM6Rj2qWaBTdY9OQoQQR1h4aQM3GqdOrimjQkuD6rbh+OrcAXSIz6aZQ=
Received: from BN9PR03CA0128.namprd03.prod.outlook.com (2603:10b6:408:fe::13)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 12:54:39 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::30) by BN9PR03CA0128.outlook.office365.com
 (2603:10b6:408:fe::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Wed,
 8 Apr 2026 12:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 12:54:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Apr
 2026 07:54:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Apr
 2026 07:54:39 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 07:54:38 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu/vcn: Move RDECODE_* to amdgpu_vcn.h
Date: Wed, 8 Apr 2026 08:54:24 -0400
Message-ID: <20260408125426.2118644-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: benjamin.cheng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b48781b-385d-4745-afeb-08de956dff19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: K7NN3ATeZ13NH9odYmLe9Sl6LAgc1Zfp3C1CYzJr1xvBHegt1J/aqm5xtHwPjrj5xa5xGWiHbFvMSFEOyqiscDcCKMddKFC6nf7yBUmJasgrwhG6d1Z5T6x4/yTh/75RjUK/SkTpi7D313MrtZHMzvVovmKiYd7I6h85DJydf7dy7L9rNFd4+smbL3yzN5S+o8H45Bfb4I10kXSsXoYA/izGbHhvwmtnHdV6irZWm+f70zVvWWq9XlOLagdfZug4RZ4JSQPQ3LcXusHYfgtAn+YfG7i4sio8VLN9BDUKUNj0o8uOuuDDrYVnGad3uOpEVRdcKyiB9zZJDyPZJ2QMbqblldiNudJe6cDSC307x3J+HpaIGCuVSC2a37P1QLJ4xiEMnqRb4Q9tlx4SLs4dIxRTzOgcsNLWCSXhJn7VVx/Ink97CY/1mu860ykSe5RVyHyxBQVxGSZWLWWXmo//997IP6Zu7QeO5MyF3/y4Lg4YK/xaTH5+qqZaJX3R4aD/j8NmDmsknCaudURfO6EUnULrJppF4C2IpBIRbd39xtUqFRJGdthv8nemGVwCxikfD9/miyiYyOhNRjLA+Bi9sSYC5BgUaaYFeEyj0TynoNljHS8Em76ePzd5IcRvBwIYO0NFNieIExYLrD1pOAzUWmS0unrRIo9C4dVR+b+TUnvwar3FGCrX1h+WyJZcq307Qt1Oow/REUb5iB+VWdjiyaFxBnlg/oMZdOJPf11OJeDCoAluNNWQEkbPjRQ5qKGjvfAwCvTL8rK1Dwe/4pIuCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b2GWBxZC9U7T3TR8w6SYpi/cQbsGMtZxHyJRdE7yo8qbntpU1nG7QPss0DQFKjIxNhFMbOpTXEL7ssl9pD9/Zl22AoDrLPmtWvT/UScDOvrQQYWSVfop77dbq7NCVQgYAh0biOx73UzF0g692BNBtgG8ymoRTFCdqa1RQ67ibLXeXPJ4XoEoAv2NApcOViB+l2ABMjRwUlZc006QjzJ2JHr/PJQLMjRGXwslKZVaLIDupngjbdsuFFHqSkQ25tBJCjrP+oIx3EiTzWwb/RU/jjycyG17+e+pPp1aiQ+mp5EvKvFkV1hPOrmdvfaHGv4ywjAan35V46OjYkCG3zg+son9VHP1UVjhO/Ini7Ex5ZmgSyz+1S0XvQFLhrOAyUmv4C+rxdccSgEUecrX8IvYEXOz94D3wCgXt8P0HDf7xLAruTEGx+a9xEI+UrBfnA+m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:54:39.6614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b48781b-385d-4745-afeb-08de956dff19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
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

These defines can be shared. Move them and prefix with VCN_DEC_ instead.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v3: Renamed to VCN_DEC_

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 ---
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 82624b44e661..e72687246235 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -57,6 +57,9 @@
 #define VCN_DEC_SW_CMD_REG_WRITE	0x0000000b
 #define VCN_DEC_SW_CMD_REG_WAIT		0x0000000c
 
+#define VCN_DEC_MSG_CREATE		0x00000000
+#define VCN_DEC_MESSAGE_CREATE		0x00000001
+
 #define VCN_ENC_CMD_NO_OP		0x00000000
 #define VCN_ENC_CMD_END 		0x00000001
 #define VCN_ENC_CMD_IB			0x00000002
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6fb4fcdbba4f..64531ad56c48 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -58,9 +58,6 @@
 #define VCN_INSTANCES_SIENNA_CICHLID				2
 #define DEC_SW_RING_ENABLED					FALSE
 
-#define RDECODE_MSG_CREATE					0x00000000
-#define RDECODE_MESSAGE_CREATE					0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_3_0[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_STATUS),
@@ -1957,7 +1954,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		goto out;
 	}
 
-	if (msg[3] != RDECODE_MSG_CREATE)
+	if (msg[3] != VCN_DEC_MSG_CREATE)
 		goto out;
 
 	len_dw = msg[1] / 4;
@@ -1973,7 +1970,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
 
-		if (msg[0] != RDECODE_MESSAGE_CREATE)
+		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
 			continue;
 
 		offset = msg[1];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5dec92691f73..a89e316a4add 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -50,9 +50,6 @@
 
 #define VCN_HARVEST_MMSCH								0
 
-#define RDECODE_MSG_CREATE							0x00000000
-#define RDECODE_MESSAGE_CREATE							0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
@@ -1874,7 +1871,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		goto out;
 	}
 
-	if (msg[3] != RDECODE_MSG_CREATE)
+	if (msg[3] != VCN_DEC_MSG_CREATE)
 		goto out;
 
 	len_dw = msg[1] / 4;
@@ -1890,7 +1887,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
 
-		if (msg[0] != RDECODE_MESSAGE_CREATE)
+		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
 			continue;
 
 		offset = msg[1];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 1f6a22983c0d..cbbc02d68695 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -50,9 +50,6 @@
 
 #define VCN_HARVEST_MMSCH							0
 
-#define RDECODE_MSG_CREATE							0x00000000
-#define RDECODE_MESSAGE_CREATE						0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_5[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
-- 
2.53.0

