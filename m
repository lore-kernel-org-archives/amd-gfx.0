Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6DDC001DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 08:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1083510E16D;
	Fri, 21 Jul 2023 08:17:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A05310E16D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 08:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfjXo4Z31//L55QcfXHlEatO2PL9+mk7SfCF+qD8mPLrh4JGjQJFtNNbjbvtZIKIXpcUPlNbV4tjqM6NTPU75C59kbelntD/k+dGlcqrdNUwPGBsb0eGO7T385oLgnzNF02mVraS9RyW4KQvqUn2hD9q0wL/exYQy+EbqHDLoOpIwKapqmRpf3UEIE/lCP5fyU9YKl+NX8WCa7qPLMq3/J55pRRxjvWTV3CbXMLWfJgrWuEQale2MrK1mB/KBR/j21UID7h+hpz2BNlplSceqCkVdVI+ASqPgHvmUU7nT/oPZxw1qUDF1RQ2olYauijjvYEQ/csdRaIaVpcXQHik6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFIBE42Hye7XZzaZMuCwZdK/fXL5legfhj+bGJISlTc=;
 b=JIwkc1vEbHo8CCRRrDpqnRUMDlijR+Y+RpH1T0FryIEbF+EnnmOITsnJSQXrIzBCeKgvdasQDWc+mHXYinDEMEKtvYSTc0ZQzcjovqtFmLN8apfB17b7LofcCQTnqGAHtvJ30K+ChjQNIp0aHdMxbIkbm3PSwFNYiRJE+CyS4tC0BDcbmkdAUY6K4XXQJl4M/nvXmutxyud6FRbkgPniaOF1VjzzU1H3Yyj3YT59GLDiw0tPVPg+j1FVTT7DN7B/aKZmmJ2Zz0C9MQ9eGIMb1c+kd6WSDiME3msGYhiSqS+Hf5/qwwSWCCAC8yDaX9Inj1ke/mXOXMWBebN0BoIKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFIBE42Hye7XZzaZMuCwZdK/fXL5legfhj+bGJISlTc=;
 b=OPvOzvNi+pCSXMFKpIV5VTogKqvTzQ4exZD7Z55uBqcnz8jBSU7NHzYTM5/nHkmcp9LJZ6chb54e5t+dRWcjYdYlKNRhJyVyASm539iQf/kLYKkM+j87OtYxBavRbCJlIKj+NWyx0dV98683u1FCHb1/x90AHRUj3G0bIR1DbY8=
Received: from BN9PR03CA0792.namprd03.prod.outlook.com (2603:10b6:408:13f::17)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 08:17:01 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::ad) by BN9PR03CA0792.outlook.office365.com
 (2603:10b6:408:13f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 08:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 08:17:01 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 21 Jul
 2023 03:16:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix do not add new typedefs in
 amdgpu_fw_attestation.c
Date: Fri, 21 Jul 2023 13:46:23 +0530
Message-ID: <20230721081623.1291213-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|CH0PR12MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bf90f7-916d-4a42-c0e8-08db89c2dc40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGu/Yk+WXt4tu8B5RZdF3G7zOGOvNuyYha9+HnZyZ0rnNVTuvmMSb1OkjDJhEZ02mzbvohqTM4hpNqC7tA86rzDLdL6SKqZbqQUmPsZeCq393hpeLSUKkT2OpcwYjQBVAwkZYThtrU4nIFNWgcO/D7zXf9voLtjoW8R72Bfd0pf3BM2zj8MP6tgf0IIe92RxlRftKLEvrCabP7KNMsP/i/U67g7e7/ePMOLX0MLH42GwxD+5kyjI3ZmJt6bc7or5zlSWXUl/dorCJG+RmqZbTShLE3Y7TNCqKKKVdIAGf9eH44wmBWaEOkOTRHfdHqmEG5ybwgkJJygwh7nfgHnUieHx7QtAOge6GkTPSnytDpaZMbyA7EO9qaVnsA5fw+/quCYO/RZOGw6O49XpYuOXenxLvO8nZI05dB/+9fZufcuv4MUwXKQ8jwtZ5oiKl8fNA/yjObXGIX0EUgoGQgUFdU9CLqdiMY3uouslPOXI0dVOMd58EkL56DzhogobVAD9rU56jYS0rcGlvo8QblxkLq2wJY7stT53t6WQnvsPTO6G1LCxuOSQjE73+RRWVJbiyZqTVjrZS5aMjfEdTsM1BY95OlzGZxzrgzUNxd9y8cFIFtc5+rxhzSVvIf2AgYTRNPE9/4NpGqCguaKRMOo+DIdRyOuW44qjmJl+/YqiIwllxuJaOz+G50SKzFof4mVYnHITxeCaXuR+gUa0/K1HjE2Ccmv/5IL2qFq3z5z8+HDai5yceMatImHl68y6wx2p6hwIjoFvZfFDfAfeRUPX+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(16526019)(1076003)(336012)(186003)(26005)(478600001)(110136005)(316002)(6636002)(4326008)(40480700001)(70206006)(70586007)(8936002)(8676002)(44832011)(5660300002)(54906003)(7696005)(6666004)(2616005)(356005)(47076005)(426003)(66574015)(83380400001)(40460700003)(36860700001)(2906002)(81166007)(82740400003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 08:17:01.4480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bf90f7-916d-4a42-c0e8-08db89c2dc40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following to align to coding style:

WARNING: do not add new typedefs
+typedef struct FW_ATT_DB_HEADER

WARNING: do not add new typedefs
+typedef struct FW_ATT_RECORD

WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using octal permissions '0400'.
+                           S_IRUSR,

ERROR: "(foo*)" should be "(foo *)"
WARNING: please, no space before tabs

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_fw_attestation.c    | 38 +++++++++----------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
index 2ca3c329de6d..2d4b67175b55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
@@ -32,17 +32,15 @@
 #include "soc15_common.h"
 
 #define FW_ATTESTATION_DB_COOKIE        0x143b6a37
-#define FW_ATTESTATION_RECORD_VALID  	1
+#define FW_ATTESTATION_RECORD_VALID	1
 #define FW_ATTESTATION_MAX_SIZE		4096
 
-typedef struct FW_ATT_DB_HEADER
-{
+struct FW_ATT_DB_HEADER {
 	uint32_t AttDbVersion;           /* version of the fwar feature */
 	uint32_t AttDbCookie;            /* cookie as an extra check for corrupt data */
-} FW_ATT_DB_HEADER;
+};
 
-typedef struct FW_ATT_RECORD
-{
+struct FW_ATT_RECORD {
 	uint16_t AttFwIdV1;              /* Legacy FW Type field */
 	uint16_t AttFwIdV2;              /* V2 FW ID field */
 	uint32_t AttFWVersion;           /* FW Version */
@@ -50,7 +48,7 @@ typedef struct FW_ATT_RECORD
 	uint8_t  AttSource;              /* FW source indicator */
 	uint8_t  RecordValid;            /* Indicates whether the record is a valid entry */
 	uint32_t AttFwTaId;              /* Ta ID (only in TA Attestation Table) */
-} FW_ATT_RECORD;
+};
 
 static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
 						  char __user *buf,
@@ -60,15 +58,15 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	uint64_t records_addr = 0;
 	uint64_t vram_pos = 0;
-	FW_ATT_DB_HEADER fw_att_hdr = {0};
-	FW_ATT_RECORD fw_att_record = {0};
+	struct FW_ATT_DB_HEADER fw_att_hdr = {0};
+	struct FW_ATT_RECORD fw_att_record = {0};
 
-	if (size < sizeof(FW_ATT_RECORD)) {
+	if (size < sizeof(struct FW_ATT_RECORD)) {
 		DRM_WARN("FW attestation input buffer not enough memory");
 		return -EINVAL;
 	}
 
-	if ((*pos + sizeof(FW_ATT_DB_HEADER)) >= FW_ATTESTATION_MAX_SIZE) {
+	if ((*pos + sizeof(struct FW_ATT_DB_HEADER)) >= FW_ATTESTATION_MAX_SIZE) {
 		DRM_WARN("FW attestation out of bounds");
 		return 0;
 	}
@@ -83,8 +81,8 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
 	if (*pos == 0) {
 		amdgpu_device_vram_access(adev,
 					  vram_pos,
-					  (uint32_t*)&fw_att_hdr,
-					  sizeof(FW_ATT_DB_HEADER),
+					  (uint32_t *)&fw_att_hdr,
+					  sizeof(struct FW_ATT_DB_HEADER),
 					  false);
 
 		if (fw_att_hdr.AttDbCookie != FW_ATTESTATION_DB_COOKIE) {
@@ -96,20 +94,20 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
 	}
 
 	amdgpu_device_vram_access(adev,
-				  vram_pos + sizeof(FW_ATT_DB_HEADER) + *pos,
-				  (uint32_t*)&fw_att_record,
-				  sizeof(FW_ATT_RECORD),
+				  vram_pos + sizeof(struct FW_ATT_DB_HEADER) + *pos,
+				  (uint32_t *)&fw_att_record,
+				  sizeof(struct FW_ATT_RECORD),
 				  false);
 
 	if (fw_att_record.RecordValid != FW_ATTESTATION_RECORD_VALID)
 		return 0;
 
-	if (copy_to_user(buf, (void*)&fw_att_record, sizeof(FW_ATT_RECORD)))
+	if (copy_to_user(buf, (void *)&fw_att_record, sizeof(struct FW_ATT_RECORD)))
 		return -EINVAL;
 
-	*pos += sizeof(FW_ATT_RECORD);
+	*pos += sizeof(struct FW_ATT_RECORD);
 
-	return sizeof(FW_ATT_RECORD);
+	return sizeof(struct FW_ATT_RECORD);
 }
 
 static const struct file_operations amdgpu_fw_attestation_debugfs_ops = {
@@ -136,7 +134,7 @@ void amdgpu_fw_attestation_debugfs_init(struct amdgpu_device *adev)
 		return;
 
 	debugfs_create_file("amdgpu_fw_attestation",
-			    S_IRUSR,
+			    0400,
 			    adev_to_drm(adev)->primary->debugfs_root,
 			    adev,
 			    &amdgpu_fw_attestation_debugfs_ops);
-- 
2.25.1

