Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378BF109E540
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8772810E24A;
	Thu, 26 Mar 2026 03:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YKjPvAAZ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421BE10E24A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjjWG55xNShyozofdsDbs5s/umGNvva7AyGZWpiiuSAQ5Lk7AwjFd3tgQFufkvT8VfY5dZrcTVdRAPpFhHZddF1IUHXP9KMUmhK+0JFQeGVDYxyHDHstWD9Up5++41yq3/P0JWyTmIB3DiNaP1G79M95oB7r3V5gd6LlyGAARC7Ar29TaZTbntiCM8Ugqn+O1kQYzvZPPAzf6YUtY6rrdVtNZHVMbBlTZGq4qZum3bM0A5ZUdTp3adUw787ZXFhbuo/LFzHLwPTcTH40ByzV/uG1vK1RtlYf71Z9LBw4rF38GzGdFxT1J1CyEbb0eOpZCzt27WJZmonuvYESMgLE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heAnPdIGqP74/YPaD4n5DnF1/lAvTxISLoHxPIs1R60=;
 b=wuCESR8DSlJ1jcFtTGUGWHhoSr5wP8gWlFyCOy7fznWTcF6TJC43IUoLJMwCOefYPEWZup2XB7Z1FFkamlJL5rsP0ZbBdJRaDLVFGEll1f1ua9SFeMvI34ml/LNnTa2eRfS9xaRddEoZTXQYwuMLJvW68DVIsDwpZkuTBpGrcT61K3syyus92fJA9vWFhes5fPMsGUDCH1i9mHPPdXriFFvqRkPawrPuKbkF6naYqYEZv0lkbAqHTTy4ifgYHwZ8xPHXDSepIDBzhpbwpFiLvCx0ETwkhyVsQ8sUn/++nccU18NtRzsnZ44jT5egArREwfsnOug/lYeKXgZyp5aiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heAnPdIGqP74/YPaD4n5DnF1/lAvTxISLoHxPIs1R60=;
 b=YKjPvAAZm8Qn6EBFY0YkfDCeQzq8dJUYdr5T5g1x/rFnpS1UnC8VNUEHKfad7y2ifIPqKNrICQ2KelT5s3LVA2y88TDDvVPxV9kBP2EwppTdAYdMAz6aBo+uzOoOGjiyPDhhXuBaUTldR3v7AbYxw75/xyEovxM12NzbmhI+1ds=
Received: from BL1PR13CA0172.namprd13.prod.outlook.com (2603:10b6:208:2bd::27)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 03:00:30 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::7e) by BL1PR13CA0172.outlook.office365.com
 (2603:10b6:208:2bd::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 03:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:00:29 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:00:25 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 01/30] drm/amd/display: Remove check for DC_DMCUB_ENABLE on
 DCN42
Date: Thu, 26 Mar 2026 10:56:52 +0800
Message-ID: <20260326030153.406612-2-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c98a559-2fb9-4f05-aa9f-08de8ae3d6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: pZmXxJ9/0xnaN67ZtLshEyxQqpJsynLf44FP0/ClN8L5su76V8adVC0rWDF7ySSe4QeVPbBNqet7s7FtUNEyDYqiR65ivyRZrvut77NpNNA3rmCV49hm+x3HlVKNqj4BSzB31A05SBf1KmK2eMmwGV2teqGhsWuZROjWJxlf56mLh7bRcKWwLyXZpeoWoxsH1QwObKSey6ypioGOqIzbmG0gxza/B3/p4lo7t2qQZ8lmqMHyi0Iu5ZJ887X+kJo1AJjjWH0CNxADQa+piS8y6vYq6njF8+F3DSf+DyX+XQJHU42zbO07UAKJV9r3ZAGwbWkJm4XM+E+aJazc3eAlL9hKo4KR4EKCFIF2s/QpHsYONRr0zWN2YAgCgQMD8UbqNnnqimC4mLuWqk3musHkSkS69vnScWCApkPjJ6yxbtbTNqBT/F4xqZj9ltK/ACCt+LqmJOIsWCFADt885U/eLEjVaYkV6nvkgDx6uproow2NH+F8CV4R68nK1U4QIlBJNJGhZLzqmRgSY9+JNs0y4mnEBHWgVxDNMxoJjtFk1jnHGmkvEl/QyUMFwt/ql2ZIGRuQwndsDHN/cYIcT9q/TapFgSYAcGMdoJmx/Lmmfl82ZlnAen7unyxr/oM7kCo1RCleIIkDcgDOdUApWPD8pxvHHc560DQeTsa8RmMRmv2hzx5diBz9TfwtZ1LEp49J5sIFlIjRiaK+pUiMgCjlG5nEUmFuQz89cdEK16ZhiYNsXdty4ynMLB3stTL5umbtttqD5OhbIg/nEKUXe+m0Zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ax84Vn8uxirJzw7bh55iRJI2yn+f/m/TUqlUOWlbtTE9qJYnuKx3q1H4zXteHl3WmwQSdHSIhx2fWtgFCv3zSSoCgnpB8mtj/pyf6nB9oQ/YGSklLJxpdwSfVo598jhxZE75A1bq43yWU72nImtTN2V48UI+0/4KMCQBsxl7KHqpATshmjBZ+eHH0mSS+s6MbSf0OoiOUdBKJL2TPak4gXmorXby+5FOjOGAOmbhMHKeS95lJRqPKGnPYEmIdirHp7hhAvbfmlvZOA3tAEPGngRa7NQeBKPKm8UOVlWag8SjFX6qje1URymrv9lhytEOOi3uURle3CoeUoB8YUVuTPpBku+tfn9Z/I4t+jkBo2P2UANTllToJsYoOOJXP/OBOwt/3hKj1NpigiloglywnCrZUgB1lhul94lEv42MIvcVXf7fDImzUcMGZzsyAoU1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:00:29.7128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c98a559-2fb9-4f05-aa9f-08de8ae3d6b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
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

From: Gabe Teeger <gabe.teeger@amd.com>

[why]
DCN without DMCUB is not a supported configuration on DCN42.

[how]
Remove the DC_DMCUB_ENABLE fuse register check and remove the
corresponding entries in the DCN42 DMUB register list.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |   8 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.h | 136 +++++++++++++++++-
 2 files changed, 137 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
index 7833a4fb7fbf..f687359b7d83 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
@@ -321,11 +321,9 @@ void dmub_dcn42_set_outbox1_rptr(struct dmub_srv *dmub, uint32_t rptr_offset)
 
 bool dmub_dcn42_is_supported(struct dmub_srv *dmub)
 {
-	uint32_t supported = 0;
-
-	REG_GET(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE, &supported);
-
-	return supported;
+	// DCN without DMUB is not a supported configuration; safe to assume that it is always
+	// present.
+	return true;
 }
 
 union dmub_fw_boot_options dmub_dcn42_get_fw_boot_option(struct dmub_srv *dmub)
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
index a49d88ab0455..c53f7691d1a8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
@@ -34,7 +34,101 @@ struct dmub_srv;
 /* DCN42 register definitions. */
 
 #define DMUB_DCN42_REGS() \
-	DMUB_DCN35_REGS() \
+	DMUB_SR(DMCUB_CNTL) \
+	DMUB_SR(DMCUB_CNTL2) \
+	DMUB_SR(DMCUB_SEC_CNTL) \
+	DMUB_SR(DMCUB_INBOX0_SIZE) \
+	DMUB_SR(DMCUB_INBOX0_RPTR) \
+	DMUB_SR(DMCUB_INBOX0_WPTR) \
+	DMUB_SR(DMCUB_INBOX1_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_INBOX1_SIZE) \
+	DMUB_SR(DMCUB_INBOX1_RPTR) \
+	DMUB_SR(DMCUB_INBOX1_WPTR) \
+	DMUB_SR(DMCUB_OUTBOX0_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_OUTBOX0_SIZE) \
+	DMUB_SR(DMCUB_OUTBOX0_RPTR) \
+	DMUB_SR(DMCUB_OUTBOX0_WPTR) \
+	DMUB_SR(DMCUB_OUTBOX1_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_OUTBOX1_SIZE) \
+	DMUB_SR(DMCUB_OUTBOX1_RPTR) \
+	DMUB_SR(DMCUB_OUTBOX1_WPTR) \
+	DMUB_SR(DMCUB_REGION3_CW0_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW1_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW2_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW3_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW4_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW5_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW6_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW7_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW0_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW1_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW2_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW3_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW4_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW5_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW6_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW7_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW0_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW1_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW2_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW3_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW4_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW5_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW6_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW7_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW0_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW1_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW2_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW3_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW4_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW5_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW6_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW7_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION4_OFFSET) \
+	DMUB_SR(DMCUB_REGION4_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION4_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION5_OFFSET) \
+	DMUB_SR(DMCUB_REGION5_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION5_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION6_OFFSET) \
+	DMUB_SR(DMCUB_REGION6_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION6_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_SCRATCH0) \
+	DMUB_SR(DMCUB_SCRATCH1) \
+	DMUB_SR(DMCUB_SCRATCH2) \
+	DMUB_SR(DMCUB_SCRATCH3) \
+	DMUB_SR(DMCUB_SCRATCH4) \
+	DMUB_SR(DMCUB_SCRATCH5) \
+	DMUB_SR(DMCUB_SCRATCH6) \
+	DMUB_SR(DMCUB_SCRATCH7) \
+	DMUB_SR(DMCUB_SCRATCH8) \
+	DMUB_SR(DMCUB_SCRATCH9) \
+	DMUB_SR(DMCUB_SCRATCH10) \
+	DMUB_SR(DMCUB_SCRATCH11) \
+	DMUB_SR(DMCUB_SCRATCH12) \
+	DMUB_SR(DMCUB_SCRATCH13) \
+	DMUB_SR(DMCUB_SCRATCH14) \
+	DMUB_SR(DMCUB_SCRATCH15) \
+	DMUB_SR(DMCUB_SCRATCH16) \
+	DMUB_SR(DMCUB_SCRATCH17) \
+	DMUB_SR(DMCUB_SCRATCH18) \
+	DMUB_SR(DMCUB_SCRATCH19) \
+	DMUB_SR(DMCUB_SCRATCH20) \
+	DMUB_SR(DMCUB_SCRATCH21) \
+	DMUB_SR(DMCUB_GPINT_DATAIN0) \
+	DMUB_SR(DMCUB_GPINT_DATAIN1) \
+	DMUB_SR(DMCUB_GPINT_DATAOUT) \
+	DMUB_SR(MMHUBBUB_SOFT_RESET) \
+	DMUB_SR(DCN_VM_FB_LOCATION_BASE) \
+	DMUB_SR(DCN_VM_FB_OFFSET) \
+	DMUB_SR(DMCUB_TIMER_CURRENT) \
+	DMUB_SR(DMCUB_INST_FETCH_FAULT_ADDR) \
+	DMUB_SR(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR) \
+	DMUB_SR(DMCUB_DATA_WRITE_FAULT_ADDR) \
+	DMUB_SR(DMCUB_REGION3_TMR_AXI_SPACE) \
+	DMUB_SR(DMCUB_INTERRUPT_ENABLE) \
+	DMUB_SR(DMCUB_INTERRUPT_ACK) \
+	DMUB_SR(DMU_CLK_CNTL) \
 	DMUB_SR(DMCUB_INTERRUPT_STATUS) \
 	DMUB_SR(DMCUB_REG_INBOX0_RDY) \
 	DMUB_SR(DMCUB_REG_INBOX0_MSG0) \
@@ -59,7 +153,45 @@ struct dmub_srv;
 	DMUB_SR(HOST_INTERRUPT_CSR)
 
 #define DMUB_DCN42_FIELDS() \
-	DMUB_DCN35_FIELDS() \
+	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_TRACEPORT_EN) \
+	DMUB_SF(DMCUB_CNTL2, DMCUB_SOFT_RESET) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_MEM_UNIT_ID) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS) \
+	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_ENABLE) \
+	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_ENABLE) \
+	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_ENABLE) \
+	DMUB_SF(DMCUB_REGION6_TOP_ADDRESS, DMCUB_REGION6_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION6_TOP_ADDRESS, DMCUB_REGION6_ENABLE) \
+	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
+	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
+	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET) \
+	DMUB_SF(DMCUB_INBOX0_WPTR, DMCUB_INBOX0_WPTR) \
+	DMUB_SF(DMCUB_REGION3_TMR_AXI_SPACE, DMCUB_REGION3_TMR_AXI_SPACE) \
+	DMUB_SF(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN) \
+	DMUB_SF(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS) \
+	DMUB_SF(DMU_CLK_CNTL, LONO_DISPCLK_GATE_DISABLE) \
+	DMUB_SF(DMU_CLK_CNTL, LONO_SOCCLK_GATE_DISABLE) \
+	DMUB_SF(DMU_CLK_CNTL, LONO_DMCUBCLK_GATE_DISABLE) \
 	DMUB_SF(DMCUB_INTERRUPT_STATUS, DMCUB_REG_OUTBOX0_RSP_INT_STAT) \
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_ACK) \
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_STAT) \
-- 
2.43.0

