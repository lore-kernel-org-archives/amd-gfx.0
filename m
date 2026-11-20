Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD5606A325
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C6Rq3qql
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE7610E17C;
	Fri, 20 Nov 2026 05:30:25 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF0210E17C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 05:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OumoIF2DPgvUdvzTP/24MJ/xhFqHUTwVs247nSYiHDwc48s+jx9YoYHbOLObbU590HZXU0a4+w/FmZU9eMR+AcSGf2Qc+oN4rnCyDgQ9szD8ZLGd+QTgdJPoFg0+DlI7uxumdCv92D5wjPrpig7hrdO57uzhQjFu9Fx2W0OZnB/1Hg/uZZi9Qmr6hQD42ZpHPqk1/1egPQiyfbYAbvJlHemQ0558u2AmMAVQYeq5JdCnFk9ceaYil8rd3StIDilYCZs4EuY0IANDOQIJ+mZkeCdwWjbRoiakOgCZnP+X8Feij9+0rmuXHQU0qUtaUG1OPls4nxdFSLb58TjgxrRBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvdTsI/79rf4SWxSUGbJXTOaDdQyZDYhFZdyVJ3xdbI=;
 b=critayvEDxrlRMC2khBsrLnzkWyAf1H1thZTFiZ36vFsTI+VU/kQ6J3AI+t/P6bD27qHV0/oJKTw2/0A3Nno6p1Y6TPeQH5ygUXzYxVRarkYc3wv42cUvm6BYCt+r76Ah1cIUUQ9NMNfR3kwNMDFz6oi+FFMsz5kTsrs5hGUGqVeS6dUHG08CoaaR2L4k5j5PqhqdPO302qJPRVIZyix/jVJVsXgShU1Wsl8zx94hK0lzZTpZZlSUcoOCixcKPBL+ivqlBPqklynBPXBHQBqIuMP0LIhIdZviFVo6ggq6v/Uhg6taG6gMP80QCcw7/ahu/pw4uQICqw3ehSTft7v5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvdTsI/79rf4SWxSUGbJXTOaDdQyZDYhFZdyVJ3xdbI=;
 b=C6Rq3qqlSJJac7HN45Kn0fzzDd6wptDHK+mOgPWCnYvIZXPohrKrH3GquodDGih1iuTj2e2g8YJ9BhpZ4on2J3qwTQyrvp/I/IvkAozu59yuCba6OFhJS5xdpaOrRsx7JPxxmZJyjU38jajoi8FgSgvfYs0+8MK/pJ+0c6Flprg=
Received: from PH7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::16)
 by IA4PR12MB929686.namprd12.prod.outlook.com (2603:10b6:207:110::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 05:30:15 +0000
Received: from PH1PEPF00062F25.namprd02.prod.outlook.com
 (2603:10b6:510:33a:cafe::19) by PH7P222CA0014.outlook.office365.com
 (2603:10b6:510:33a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Fri,
 20 Nov 2026 05:30:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH1PEPF00062F25.mail.protection.outlook.com (10.167.243.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 05:30:15 +0000
Received: from vpe-at2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 23:30:12 -0600
From: Caden Chien <chih-wei.chien@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Frank.Min@amd.com>, <Tong.Liu01@amd.com>, <Solomon.Chiu@amd.com>, "Caden
 Chien" <chih-wei.chien@amd.com>
Subject: [PATCH] drm/amdgpu/vpe: align with reg read permission
Date: Fri, 20 Nov 2026 13:29:32 +0800
Message-ID: <20261120052932.24761-1-chih-wei.chien@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F25:EE_|IA4PR12MB929686:EE_
X-MS-Office365-Filtering-Correlation-Id: c14c479e-500b-4667-d0e0-08df46c75b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|11063799006|261009223027099003|261021121427099003|261102123227099003|56012099006|261022075727099003|261021123027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: xMSDGJvEhpIFA+e1A0i+J10OYsk9P1mzH12HLBny/toHIiUNg8O9WesbwpI88nGOvIOV/0paDbuKAiI9cG0Gd2/NWm90mbgwbupi0GzUhuPa/suvKrduBKIPIuk6skTUTvgOYRrFV2sxOmRPoJZuiP9uDuiWcj4z3LD6a/FUEItZLfDvNg17vhBghLMMpUBbeAQxTdN9l6VTu4mX6xwO5WX6KbFPDtCQpeb8qd+jhw7oF/yPEZxocX/tgE2o4a7aF1Vf146U0VOqxhtXvsREdT4oGw+kopD88zpDk8GJnLRymuS++cgy58ZvT5x5BtW7v+A7+2hukqRyAIn+jjjT8RVyBzslDNFg7wy85wlNKl0oVf/PqNNCVCiWhk7aBYt34Mlj4w8w95nPpidKuO1z5ht8LBxDJ6EdrTqNi3bS6WuTDOQiAW6uVWNj4mbw8fQoJUnVTeUb7JQXZsyGhxoSolD4vmidK5qrnYNQo5IJxytTJsGnYgGSElYADVXSofhjt91ZXfFMXXdB4plUkp+v93Pt846OmLuSjXkCGqQX2u1eKWQv9mXBrTiVxOF9C45kyOsEEeyYMBup3h9mePEqC4s5MZnjUrMWykoKrGQQlCgFHPdpdF165yWDrX94cP6L1cbtlvou+9+XNeo3okb3oKrC7BwjD+1AFsrYrNSqdvlNalwwJ03mnHclQKzLYcSZgc/O/BnGiFbLl2AOzlzkbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(11063799006)(261009223027099003)(261021121427099003)(261102123227099003)(56012099006)(261022075727099003)(261021123027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: do/n/nlgiapYl3w6M293uxf9Qbf3kaFzPWyuNJNce+ceGPl6wA9/hVfPYR9noPTWoLC/tnYye66ZskgmLs0jgg3z4WsKrhkMYvlu6ck1epSBeMc2eXGcVzkBasAPtc8QP4QB4VKmiSwwBGveBemBvgjhWu5lPKQCVpE1W3kNHjVjGrJw+EtQNPpvvDoT4rHdYgPturJ4N/8M0lpqeSPOfnSDQd9Ikn90qMwfmEo4aMXhZ4bOMV66DqSPelgDN0+K12ut5HMHj46MnCV25I/zEr5Q1j7aihyK/ZoaxmzIxEqPFxwQzILcG65EM+yocC1rc4qdPHS6IQwBQK2+DmoRHhON8No9o9chfI2s5a7UORrRDdB07e3hR5ntRc3il3SNLOw/vWJ4Nca+bfdAenrMZLMbirHOmmgZSQ1UsgpdHgco7uE8D0n9c9gG37TnHgJu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 05:30:15.1459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14c479e-500b-4667-d0e0-08df46c75b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F25.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB929686
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As register VPEC_F32_CNTL could be unreadable, we hardcode the default
value instead of reading it.

Signed-off-by: Caden Chien <chih-wei.chien@amd.com>

---
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
index c92c5fc59aeb..dd5efc121e4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
@@ -34,6 +34,7 @@ MODULE_FIRMWARE("amdgpu/vpe_2_0_0.bin");
 MODULE_FIRMWARE("amdgpu/vpe_2_2_0.bin");
 
 #define VPE_THREAD1_UCODE_OFFSET	0x8000
+#define regVPEC_F32_CNTL_DEFAULT	0x08084001
 
 static uint32_t vpe_v2_0_get_reg_offset(struct amdgpu_vpe *vpe, uint32_t inst, uint32_t offset)
 {
@@ -80,7 +81,7 @@ static int vpe_v2_0_load_microcode(struct amdgpu_vpe *vpe)
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 
 		f32_offset = vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL);
-		f32_cntl = RREG32(f32_offset);
+		f32_cntl = regVPEC_F32_CNTL_DEFAULT;
 		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT, 0);
 		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_RESET, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
index 9077ae138d2a..ca3b27e76251 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
@@ -34,6 +34,7 @@ MODULE_FIRMWARE("amdgpu/vpe_3_0_0.bin");
 MODULE_FIRMWARE("amdgpu/vpe_3_0_1.bin");
 
 #define VPE_THREAD1_UCODE_OFFSET	0x8000
+#define regVPEC_F32_CNTL_DEFAULT	0x08084001
 
 static uint32_t vpe_v3_0_get_reg_offset(struct amdgpu_vpe *vpe, uint32_t inst, uint32_t offset)
 {
@@ -80,7 +81,7 @@ static int vpe_v3_0_load_microcode(struct amdgpu_vpe *vpe)
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 
 		f32_offset = vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL);
-		f32_cntl = RREG32(f32_offset);
+		f32_cntl = regVPEC_F32_CNTL_DEFAULT;
 		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT, 0);
 		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_RESET, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
index 45876883bbf3..c758f7385fac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -61,6 +61,8 @@ MODULE_FIRMWARE("amdgpu/vpe_6_1_3.bin");
 #define regVPEC_PUB_DUMMY2_6_1_1                                                0x004c
 #define regVPEC_PUB_DUMMY2_6_1_1_BASE_IDX                                       0
 
+#define regVPEC_F32_CNTL_DEFAULT                                                0x08084001
+
 static uint32_t vpe_v6_1_get_reg_offset(struct amdgpu_vpe *vpe, uint32_t inst, uint32_t offset)
 {
 	uint32_t base;
@@ -159,7 +161,7 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
 		uint32_t f32_offset, f32_cntl;
 
 		f32_offset = vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL);
-		f32_cntl = RREG32(f32_offset);
+		f32_cntl = regVPEC_F32_CNTL_DEFAULT;
 		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT, 0);
 		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_RESET, 0);
 
-- 
2.56.0

