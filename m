Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E500C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DF0610A2
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45DF0610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6856EAAE;
	Mon, 18 Oct 2021 23:49:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2936EAAE
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 23:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdvIyEQHSy3pfVo6yfKTE6a4imsUSmjZRE0ORT3iTIIlam+8zZn4PxlKuUVftM28sANRBkiOI+OIpzvlu8eIv5ulhBt1gWy/INs8mXvPKBBM768LUVATJlnTnZToUo6YrO+fMPr8WPHg3gxR+Fd0AdUEReo0wChJq2jGXziYqmI26Qw5NkeqxM8mkjYOs1J65kIqv0taXEF9AYyVvY2kPULDoIzjvhUaGwalY7ijRsfj0VUllETqPstey5myIS0d2lZkU8bd6L3mvYrKumwR6+1UGnZ9WCHAD60w/uWZfu0f2pZS0UN7U9Ao9wTxIYcAZ4KQZhDzhmXbElRI3bOXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8LyCHXCBMZ1xUUsMo3tMcPrNr56lmLqWXzTytCttHM=;
 b=mzLYq3dyviwaRlfFiS/o9YUMzOkAv9Ow+xM/QXgrANtaFoaUA8N5Qotsl3qwEKydH6cmXnpVyDGmKWrZfN3Fli1tQgg2XBiHSTO7Kwm2Q/E8P8OwooSdbCc/FMNOOemshktlofqhpSgtAH0loC9O43caJ/ahiXVrdVMovnRpMdiiGe+j507Bx6a1NfHtrJFIZwoRGmID8My2Y8b8SxWrYp13vmsCI5qfoT0O+/biSC4TRuXy/3rulbdT8lqGMPC77+QhQhYr1vfB6p5id1g3NLZGo+kTefvr0yMPju+SPHsCZb3FLpM6RDU9Zy6D36q+jy7oVx1CQqQ/X8CIYbZiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8LyCHXCBMZ1xUUsMo3tMcPrNr56lmLqWXzTytCttHM=;
 b=s2+SYG6htD8Ac+GaSQgPcQle5gYem1cFggwQ5zHmIqXPXR3NldWUfN03vi8145a0F8615xZtkD7/+D+fjO6HQA50DTz5grsgxAitNpupQHsvZKbVrR7Nl8JPvYhcR9XKek/GONBHPvczEegPRHZgNYA/8d7OjZgQW6eKuzk2CWs=
Received: from MW4PR04CA0342.namprd04.prod.outlook.com (2603:10b6:303:8a::17)
 by DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 23:49:30 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::55) by MW4PR04CA0342.outlook.office365.com
 (2603:10b6:303:8a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Mon, 18 Oct 2021 23:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 23:49:30 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 18:49:27 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 1/5] drm/amd/pm: Rename a couple of functions (v3)
Date: Mon, 18 Oct 2021 19:49:09 -0400
Message-ID: <20211018234913.42349-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211018234913.42349-1-luben.tuikov@amd.com>
References: <20211018234913.42349-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b123309e-9028-4030-9190-08d99291edc7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2746:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27462D00182EC2A79039E0D699BC9@DM6PR12MB2746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OygUuB4bua20CL8eHV3o5uUzbHIa2m+ABjJor4ylEzNfgZej4zoEo/3ueXXAF31KBnzq6zy5DouUTdtc9d8g8nyCdzRxouafHvxf6lyVhtix5sfmhcCNl4s23I9mGYGvbX7HozRqcY3NiJOK7kcLGzaqkCF4QhO41myjTM7+qgwXeMOgkfE9KMOk2jdHX8oRV98LTtPR6v8SDrW+y2MTZKe+IoOvq79zDHGi6y5qYj9mJxwLJ3eLfR2ks9VSjpsGPHDnsaiRf0GTIPEYnQPhFSWhpktfHK1MGc20B8j319EDE/BQNF0YaZ8sWnET/E6MCQVyvHBRvgo5WZ2nmK4QDTzFBfKs8GOYQ0RNfqQ0mW03GPXww6xEBNH8oNjIQEJIyke7nmAKGrtEbvI9VjD8ghoKRJoI2VMRrCQmeOVXYQJL6MS21nuL69fBrktXJQcQUUt1gvkloankTh/a2w1c9hZRHi+LoQqvU9cU2zBlAFe6fZuvhjs907owAv30JF/VGEVxuWrh4+6raa6Yt8X0jhRndUyvtrwMYZHvgguTb9ZxvKKD/jWebrUunmvbzDpm/S+9vsw+efHa7mcS/QyZvSqPcYJL2FD4hVEo0caw6BbemF93PmxqWyvFRc1qaCAnoUNY677xiJOJospe4OVOMeZ7blXCXdjUzjDeVrda+i++Dnn9hO+b/5eaSacC9RWCB23QM2EDNgCmZSFP4f1fhl2v6Trgadh1UBSWNVeWWRw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(2906002)(36860700001)(26005)(336012)(81166007)(47076005)(8676002)(356005)(36756003)(6666004)(186003)(16526019)(2616005)(83380400001)(6916009)(54906003)(44832011)(70586007)(8936002)(316002)(82310400003)(5660300002)(70206006)(508600001)(4326008)(86362001)(7696005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 23:49:30.3584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b123309e-9028-4030-9190-08d99291edc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2746
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

Rename
sienna_cichlid_is_support_fine_grained_dpm() to
sienna_cichlid_supports_fine_grained_dpm().

Rename
navi10_is_support_fine_grained_dpm() to
navi10_supports_fine_grained_dpm().

v2: Fix function name in commit message to reflect
the change being done: add a missing 's'.
v3: Start the subject with a verb. (Suggested by
Paul M.)

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 71161f6b78fea9..0fe9790f67f5af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1231,7 +1231,8 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 					   value);
 }
 
-static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static bool navi10_supports_fine_grained_dpm(struct smu_context *smu,
+					     enum smu_clk_type clk_type)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	DpmDescriptor_t *dpm_desc = NULL;
@@ -1299,7 +1300,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
-		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (!navi10_supports_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1465,7 +1466,7 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (navi10_supports_fine_grained_dpm(smu, clk_type)) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 15e66e1912de33..3f5721baa5ff50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1006,7 +1006,8 @@ static int sienna_cichlid_get_current_clk_freq_by_table(struct smu_context *smu,
 
 }
 
-static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static bool sienna_cichlid_supports_fine_grained_dpm(struct smu_context *smu,
+						     enum smu_clk_type clk_type)
 {
 	DpmDescriptor_t *dpm_desc = NULL;
 	DpmDescriptor_t *table_member;
@@ -1084,7 +1085,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto print_clk_out;
 
-		if (!sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1235,7 +1236,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
-- 
2.33.1.558.g2bd2f258f4

