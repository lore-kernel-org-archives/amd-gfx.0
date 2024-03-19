Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C07C54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 03:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D4510E4D5;
	Tue, 19 Mar 2024 03:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rVsrcT7K";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C3D10E4D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 03:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0EcYw35Cw768DHQGbSE50BceLM/o5QJ++csn7Td58yFvIiwzNqeN8slOHYIqphSKrnCDRjs3U6cmeJTfMYuJ94EGNpRL5aBn/mbP2buwlX5NOJ7wxwXq8uL6mBBV+YA12ruCZh6oAbTllpdqGBY7ehW4NpaU5Qa8bxb+4l2bN7d5ZlHdodnQWh5D6QG00BngIDOu3zLLMvXJmbrflm1a5gw2eXh5xlwcj/6QiLRR40piwayzM25HEh8aZK2xslWfK8uoREwUcGns1MifeA7aYTReMPkfjw7wipMTM+5/e0aKBUWoI38uSfKOH6Ft9J/h7Cv9QM0dYxVkf8om+WSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l+3bviOWPXKm5BqaGWgBfocv6NTazvszVRqkC79YHA=;
 b=VJFKPp//NEQtwksPxf1HgbMduq7OEJ1LB6YGc65HAjYOjKZXTrN76f+mWEEMo5tKvlEFFKSx49V3CsHgNU7GqIRwIGwQ2L9lt8PNH+j1wM325tyWNqXogHCVwstDj5IuIm/8TwEhjl/NDshKOz0E1F/+RTWgiWg25ACdLUZ3fxel3R6OGoCBPKxjlGviPnsQnkzUjcRmsry5yCbIQeDjR40qCAcllAMtSCUSynzWLaTQDbYI5mD4X7I0cB0YP0TWqcSrprHvJlLsN/Y1W4ZtmeJjVqANym7A+Xclu+LtOBD5W3ub4MRHBxXwyhXBgQD7hYtLeETN6+g9cpNcVZL6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l+3bviOWPXKm5BqaGWgBfocv6NTazvszVRqkC79YHA=;
 b=rVsrcT7KullVJMn1EEhcQaZjWjS8116mjQ07hi17fg5o15k5FDg1+LYbfy0+y6Kvu8zGoXXv9BcSn7RVAs9IRdQz8aC+QlIRVj6/w3HoRot9MzjU+OnqtpHveQowJmbPrcWqP3vqKTfTaKBpyprUE1Vs3tDNhUO0sQ6FydGVTuM=
Received: from CH0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:76::21)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 03:25:52 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::39) by CH0PR04CA0016.outlook.office365.com
 (2603:10b6:610:76::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 03:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 03:25:51 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 22:25:50 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Update setting EEPROM table version
Date: Tue, 19 Mar 2024 11:25:37 +0800
Message-ID: <20240319032537.652617-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 83568737-6c47-4e5d-41fa-08dc47c4477f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOpIv4BXwaA9CdZkDCCaiZdyIPk6tonD2jR2Fr8wl3OBieNAiZiDZfZBhHMtkSyeoFwqN4V/E1z6im+JokmcA42WJrct9tUeq2Gy+7GOEmClnkakT4GJ6rRBi6gW8kGaM5gLvVG0v9olGSwJ4llVgF3AyCmoEY/Fx6PLchnuo8lmh8K4GJ9N0MhAbn7VPCCxkUtWkNZGUNO4KVB1KeXQfoxQ6W+isFhPlVo8kZyOdq/pRR4Z9uvqoo9gXMVv2D52+qIwEy6N0vY2FxiLtmw8kBe91a2ZD2La6n5nq+jgSufIt62A+9QIdr35GMqmPAsJQ9mWi16Jjwla6bWyOWRSS7etSq3xRKedNS8vDfL/w5BWV9E2LR9NNLiA1jjGV+SO+PFZVOSHmRiJ3LatoJcvVE1GoStoJNtXdgit9lUXxC2+3ktGqxphBPQ1SBpMv90DU/ktNk+petpyM2THgj3RvbAsGecSHElWx27Me8lwW7APKgSEMAxMWRnlEpyUg1GM17NA6wwhl6j8wSPZXBUnbFydKwPdgFD9nFpgLcLSIXuQLtncdSY6dzANXstOnIfoi+Cr8klAGP5MIYqHWEJFuG8e0Rjy0WPSH8OQtBLUfkOx82ZFFccLgGHCbi/gI7x11SiZX2ZE8AXamHsZpBhc7mJ5r/KEA29XvBqhTXUukWBz0QbJRwcQthKFzZSFOX8OWEYSeAzfg46VjL+gUT4aR7/wOvcGFZCqSJcDqs/bgii4CrGvJyc3L0M+UF/bkrNN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 03:25:51.7358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83568737-6c47-4e5d-41fa-08dc47c4477f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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

Use helper function instead of umc callback to set
EEPROM table version.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 22 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  2 --
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c        |  6 -----
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index b12808c0c331f2..06a62a8a992e9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -404,6 +404,22 @@ static int amdgpu_ras_eeprom_correct_header_tag(
 	return res;
 }
 
+static void amdgpu_ras_set_eeprom_table_version(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
+
+	switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
+	case IP_VERSION(8, 10, 0):
+	case IP_VERSION(12, 0, 0):
+		hdr->version = RAS_TABLE_VER_V2_1;
+		return;
+	default:
+		hdr->version = RAS_TABLE_VER_V1;
+		return;
+	}
+}
+
 /**
  * amdgpu_ras_eeprom_reset_table -- Reset the RAS EEPROM table
  * @control: pointer to control structure
@@ -423,11 +439,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	mutex_lock(&control->ras_tbl_mutex);
 
 	hdr->header = RAS_TABLE_HDR_VAL;
-	if (adev->umc.ras &&
-	    adev->umc.ras->set_eeprom_table_version)
-		adev->umc.ras->set_eeprom_table_version(hdr);
-	else
-		hdr->version = RAS_TABLE_VER_V1;
+	amdgpu_ras_set_eeprom_table_version(control);
 
 	if (hdr->version == RAS_TABLE_VER_V2_1) {
 		hdr->first_rec_offset = RAS_RECORD_START_V2_1;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 26d2ae498daf22..5954e839d5808d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -66,8 +66,6 @@ struct amdgpu_umc_ras {
 					void *ras_error_status);
 	bool (*check_ecc_err_status)(struct amdgpu_device *adev,
 			enum amdgpu_mca_error_type type, void *ras_error_status);
-	/* support different eeprom table version for different asic */
-	void (*set_eeprom_table_version)(struct amdgpu_ras_eeprom_table_header *hdr);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index c4c77257710c97..a32f87992f2058 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -442,11 +442,6 @@ static void umc_v8_10_ecc_info_query_ras_error_address(struct amdgpu_device *ade
 		umc_v8_10_ecc_info_query_error_address, ras_error_status);
 }
 
-static void umc_v8_10_set_eeprom_table_version(struct amdgpu_ras_eeprom_table_header *hdr)
-{
-	hdr->version = RAS_TABLE_VER_V2_1;
-}
-
 const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops = {
 	.query_ras_error_count = umc_v8_10_query_ras_error_count,
 	.query_ras_error_address = umc_v8_10_query_ras_error_address,
@@ -460,5 +455,4 @@ struct amdgpu_umc_ras umc_v8_10_ras = {
 	.query_ras_poison_mode = umc_v8_10_query_ras_poison_mode,
 	.ecc_info_query_ras_error_count = umc_v8_10_ecc_info_query_ras_error_count,
 	.ecc_info_query_ras_error_address = umc_v8_10_ecc_info_query_ras_error_address,
-	.set_eeprom_table_version = umc_v8_10_set_eeprom_table_version,
 };
-- 
2.25.1

