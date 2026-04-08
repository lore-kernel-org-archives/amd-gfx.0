Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3031073CA5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 12:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6B110E427;
	Wed,  8 Apr 2026 12:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fNjkO39m";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B84910E427
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 12:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgfTrf2DHDlPWaZmHJBpU+SSypQFunaHGEwfYIn0lmZ5Y++pIg2QpcdSTndTeu0kU+T1pXb8gBhUcp5ZOJqIZR0NS5HKEVNY25C1QhIHdfnECp9JL3TUtxS8zqoDYsYoy8GhU23b/u3mnjvKU19BgkV4JxEmzIYITkjJJXvGuQ8NiiY9mtV9I8K3WA08sLF7GOKDfDD9xJkFUuOSv+QFcSoJrmGpFTkHvipAtub1MfZYeU5A7p4gkN8SicZ+qI3X6OO1t6ZU5K6oaWSFyXwRAkceebT+9Q/wLreHrTEGdeyjdUIKNZ1MQtk6LnR5nKp/MZMDPiE0K42ObjGuZIdPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV28/7p5KU+sOEH3cMvJ0VR56AVEhNfjeedInQeluBg=;
 b=eKjbFkRM9QQ6dN7Gu1Mgr/mF3EBJ8wabDA5yWuV5RqSuD4ln/L4X0mj00i+9W+gJxocYuGIBQ9SxuSQpw1BpdwXr8TJDn6NiXo4iRZhpZwTP+HkTENsIQGo0i+fpAe80HFx8+7dz9UspCFG9JtLnSSc3G4tOIRhizM9tmfiNH4B0cSpfqBIzgyI/DOw9T2sJhdphbUABtV9A0QEHgT6PkHls1+ZCvvAGCQ9uRNf38rwfySB2K4vUGkerTd/ScL1sUvEVcpwsVxxwacQMvKxTvvG1N/PruxoaOAlwT8aRRnsJEUezvz2PqmHr9OUcYqtNiHOug1duC4Sg0NVVc/yNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV28/7p5KU+sOEH3cMvJ0VR56AVEhNfjeedInQeluBg=;
 b=fNjkO39m9FUXijS2csumuUxgn0knG+RLq5mtTWrD6gey7HGxK7ivBn6hvbZwaJQmr85m5Q5eLbioQFd/SvJxSaf2opo8lhuiqEsYl8TXPDRd6EFzr3jSbmKhLnNC6L4mrFxmbCebvH4p4rGwanX/xsQxA0q5hGjAiLEL/IVoHM4=
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 12:25:12 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::92) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 12:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 12:25:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 07:25:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 05:25:12 -0700
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 07:25:11 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu/vcn: Move RDECODE_* to amdgpu_vcn.h
Date: Wed, 8 Apr 2026 08:24:54 -0400
Message-ID: <20260408122456.1787039-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ac9bda-bba1-4533-019d-08de9569e1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: dzuYzouAA2sTlIzWwK8cezuuZ6Q6cuffpEDPg3bcDwVawvFObNOUpSFmtjjSIoKMAW+FMOeIsa0OMRypRJW8gqU9dGGlGA91OsoWXChsuYVAMgDfCoGN+Qkctqjclu7bfDcQ6NI9aEemAU7gqSVwZtJtbYqy8hd8aaN7RL6IkYVxz4dD/SZA0piE9e7Gv44Q8LR2SeXTjL+5M6jWqNbmOqziaub/4IhQA9NhesgYC9nDlEzeCkktjtgUbeupir6OaDjtF8U+/2eyC09/yO3Db4GBdZlaoo+eoWkG+46tDW9VJGUdEIefZURLZqFarviucaA+4XC+edI2ddb/8qqajq2AwiC9YfyVl1TuNMGrhnbbjwtV5cwCdnNYHd8Fxkvhoa5B/PhIfzz0qLpkKbV/X7dYFsYsZTWEUghUOU3Hm6IhbO6eADQAuBREhwh3/dTK33+wuDf4T0z4wgCVCv1iHEeeFTIv+OHyzVPRtET7My1amnLBpzqVNDF0yewXdQEdhlfsSg/dYGxvca3svvRAJwA1xBxAp6cYwI7mayLIrmjIJJmcdd2Bs/gwI8qhhYika/sihDO1ITZelVG17MRxYYDT2SMha14Xnpjq30Fld1DwuwGyZEgnNUiOF84hyg3VyLBw3DJt8qxJLzxislKd1N4CmIIJu5f+7u5ySR57mjo1sAbTA0PdHi2G5pISMKyVfBBXFOBB3G9FySCW/huRDL6rEjIr/lRU7Su2N1txCKqQOX0Ki0nWCdeMituza91o39fk9qwD5MdE6ecTY0i5RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F2lOKrBCbskuXDp05bg45YjIHKn6eKVPr1NwfQ8gmrqThvX4WkVhIREP1mHGzc/yhdFfgbJ2KvJemnfww0E/v6kyCoRcz6qhdkHKRiwUOzJol6TEk2jKbtc4Dr/+c302qJ6L6cuYleAfJWMwdI+Jn2tmSOab0//VfXaFSNv6cCxazWl6YRgGV1AKhzFKXMc+274LiENj6Ke5UyobjnIW6x3QHdZBn6Ifvg/ZprTuJ100R/4BK7ZkeDChkPFohShYb7wueQfTIsTL25SCpogZl81FHGCa2YTFi0um72ukGgaCqq2zljAIz0immEtnuXgJuTdA0K/3uPMm/hcKc1lOelgT2bUXs/Bu3BOiNswzKuyaHscq5lNUl9b+IIoDuIslrGuyjRqS69tVrMFy4DhDjlm9SDMiJaPekesK/PvJ/sae2aBV62jseXtBQ+gs4kgR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:25:12.6638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ac9bda-bba1-4533-019d-08de9569e1e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
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

These defines can be shared.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 3 ---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 3 ---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 ---
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 82624b44e661..fd9657ae6c37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -57,6 +57,9 @@
 #define VCN_DEC_SW_CMD_REG_WRITE	0x0000000b
 #define VCN_DEC_SW_CMD_REG_WAIT		0x0000000c
 
+#define RDECODE_MSG_CREATE		0x00000000
+#define RDECODE_MESSAGE_CREATE		0x00000001
+
 #define VCN_ENC_CMD_NO_OP		0x00000000
 #define VCN_ENC_CMD_END 		0x00000001
 #define VCN_ENC_CMD_IB			0x00000002
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6fb4fcdbba4f..0e8eb4f671c0 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5dec92691f73..00abac9c7fd7 100644
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

