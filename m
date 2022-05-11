Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EBBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 05:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A675A10E796;
	Wed, 11 May 2022 05:44:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71AB810E796
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 05:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByZR++bFS1tLMgMmQ+vGMzbvW8IOLjMOO+GHj0+l1IIAxf3P+Ptl/F8or6voNZWJB75rKRWisL+EBYSZqHn0sfx1qGC3yf6aJESYx43/+YyjBPIr/xgJHiTapablRefuHl+zxnGGTLqfTBo5jsSWHO9aen8qvhdBaUSvz5AqGfJmWbJZGeQA+Rh2Ia/nO911iKkCrbKBd/EgJSadc5d/yA4qq1x6EAeYRcKAjnwhlpskBiEkLgQln1KuZf/VfJwMWWMQYB0nI1VW27b9wQGdoGEZxb4094AJpeWgrE/lYPDFtlGV9Y0q0MAOzqirDWl0SIFbKKnE4wg1gRMiqQ6L3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2t7GXDyZpPMW7WcmMV5/NlLtu3fWT4VewYF6XNCBPk=;
 b=P3pV2iAzk16O/Y/M0t+N9WhndNfcAP6kHXgOp7WzYH62jUFLU/2dh+d8ZK/Hd1FPlbneDaTnrGu/+PwZFB7w8Mi+l7N+CXQh5FpRc/UfX5hAftb8r5GIB43ukxG9MZ9aTP2B4AlEFR39JKvpjx3o97Z9/vs05a3fNyimG0LVbVth4nU6M2NwqYEYcVuzsQmGhUR7CGOj0qt9YmmB6tnvMoi6yGparZqmSqDo4MpL6dh6TS6/zCAnZ4AI/eX72cyaan0S3eFSoE0QdFvL4CXGwF7fxv0T0QUqbcpTwdPW/iS17DzArv5rtb6Adu+ZDDJm9fl2DuwmVudV//9cpuWCrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2t7GXDyZpPMW7WcmMV5/NlLtu3fWT4VewYF6XNCBPk=;
 b=qOMxRlFQ/AKWP9KgMpyo+qD4NZNmtgNUxs8aJDk1acZF+v87XA7b3X3m2HyqGFG/fFrlqwne7eegWNZS1TKfKOo5LA+E8t363lRJ+sQ5kPX/9y7vU5hDtr4oPROR1duOJtybrrd42Z4XB499K5mykw6C5BzzCTPdPXXzX4F6iNM=
Received: from BN1PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:e0::20)
 by BY5PR12MB4833.namprd12.prod.outlook.com (2603:10b6:a03:1f6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 05:44:33 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::60) by BN1PR10CA0015.outlook.office365.com
 (2603:10b6:408:e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 05:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 05:44:32 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 00:44:31 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] amdgpu/pm: Fix incorrect variable for size of clocks
 array
Date: Wed, 11 May 2022 01:44:16 -0400
Message-ID: <20220511054417.25819-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700f5635-96a7-4fad-aafc-08da3311530c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4833:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB48331D57F3272A02E628AA49F0C89@BY5PR12MB4833.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQlpI3zy1XBHyKxl82mO/TbA9uTkmaiBLCS74/IiXo9TFMwfGhcyIybwbGiEVH0KhVQnJVk7nX50ADWsOcBefB5B318AlO5VhSEt6S9mSXde2KG/Pek9AoAO95ewRsXB05CQnBTRJvkjNzsoE+UACjs0vO8n7QdxvoWQDdcNSBYeKLZdkqNau+YiYWEqhtPe56npJmAJtuvGEtbVdrvMgf+iK9LUitTSocwHmth6LzpfTVmlpYdo2306WRvWQNgoHTvaaaSLJ6cURpmt4zMMlxG9FWQHav0MoAsKGyrcGcJpiAJh1PFmQGU6VfFz8pZohrxjLMbkWtTWfJSwHZ+VnSQ0T25arSSJ5meN3HOkz0jHOIWelXPvmYVYrEQUZUoYraHtvAACOK7pkp4PxJGRb8EA6BtJfdiQT5aYXFwu3M5YGGPxi4+U/1f0sbkTFlTP2FeUzSbqaKkY6J+gjcoFiUTy0L7dfvewCaho9uMfDolsuOB0BElNAAItG2STypKDuYozxFIRIv52ooJigRfchKAk28HSAwvMO4CC8PVL2gyTUU3UyY8uO5cEcO328vM7xsi2nnrKnsKFaWdRWe4r/hAbOtbJO21n14/xHJl2czqVsYu0SQTzp5DLbk/LSay9SvXaWx6RKZtB5hfZp9o0mHvTKFFkc8k18BLUXPzg9S3A4NLsytqYjku3EIkVHBOPw2kvF231SXhN4YgZ1cB+pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(40460700003)(36860700001)(26005)(82310400005)(54906003)(316002)(8676002)(6916009)(4326008)(1076003)(16526019)(336012)(47076005)(186003)(426003)(70206006)(36756003)(70586007)(6666004)(8936002)(2906002)(86362001)(7696005)(81166007)(356005)(83380400001)(5660300002)(44832011)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 05:44:32.6521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700f5635-96a7-4fad-aafc-08da3311530c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4833
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
Cc: kevin1.wang@amd.com, lijo.lazar@amd.com, Le.Ma@amd.com,
 Darren Powell <darren.powell@amd.com>, evan.quan@amd.com, kenneth.feng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 [v2]
No Changes, added RB
 [v1]
Size of pp_clock_levels_with_latency is PP_MAX_CLOCK_LEVELS, not MAX_NUM_CLOCKS.
Both are currently defined as 16, modifying in case one value is modified in future
Changed code in both arcturus and aldabaran.

Also removed unneeded var count, and used min_t function

Signed-off-by: Darren Powell <darren.powell@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 9 +++++----
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 201563072189..bdd1e1a35a12 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -573,12 +573,13 @@ static int arcturus_get_clk_table(struct smu_context *smu,
 			struct pp_clock_levels_with_latency *clocks,
 			struct smu_11_0_dpm_table *dpm_table)
 {
-	int i, count;
+	uint32_t i;
 
-	count = (dpm_table->count > MAX_NUM_CLOCKS) ? MAX_NUM_CLOCKS : dpm_table->count;
-	clocks->num_levels = count;
+	clocks->num_levels = min_t(uint32_t,
+				   dpm_table->count,
+				   (uint32_t)PP_MAX_CLOCK_LEVELS);
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < clocks->num_levels; i++) {
 		clocks->data[i].clocks_in_khz =
 			dpm_table->dpm_levels[i].value * 1000;
 		clocks->data[i].latency_in_us = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 38af648cb857..6a4fca47ae53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -549,12 +549,13 @@ static int aldebaran_get_clk_table(struct smu_context *smu,
 				   struct pp_clock_levels_with_latency *clocks,
 				   struct smu_13_0_dpm_table *dpm_table)
 {
-	int i, count;
+	uint32_t i;
 
-	count = (dpm_table->count > MAX_NUM_CLOCKS) ? MAX_NUM_CLOCKS : dpm_table->count;
-	clocks->num_levels = count;
+	clocks->num_levels = min_t(uint32_t,
+				   dpm_table->count,
+				   (uint32_t)PP_MAX_CLOCK_LEVELS);
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < clocks->num_levels; i++) {
 		clocks->data[i].clocks_in_khz =
 			dpm_table->dpm_levels[i].value * 1000;
 		clocks->data[i].latency_in_us = 0;

base-commit: 8bb14fbec5ae45c31cbefe217db2418cc683612f
-- 
2.35.1

