Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA9AC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63EAB610A2
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63EAB610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947B86EAB5;
	Mon, 18 Oct 2021 23:49:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D361B6EAB5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 23:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkzZ6e7N1ahBjCDrAksUlPXUe74Ddod8bQYDs7mUTPBBDu1jS9wq2YWw/77L51UKFOTjJx1gU0ciSSoSk2G7SiFoSBf4g4ru454bGFtZu1IrFoV3lU16y1yT+4NJa1fmEwmXoNHID5pLctnSawUWG12ka7nFzN3ZG/d7kzWA+JJehtGc76bNyqKj0w7j45JnAAirlirEB4si8FXK92y+qNfesg6UM4DKR3R+YqoT/YOFDPSqzMkRyhfLN7flDTqv95q+kHq9cFojztG+JD2JvA2mqxJTHT32tKTIQQyao4LQHv+2rNDb5z6tEWraG5xfTvyQ3+dj92UUYClVXPV9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b3pVjcNy278O64Hkedl0GRLT3wWf9iX9PJporhw7yE=;
 b=I8KzNIXo0Ox9973g7ju2Sdud5Gk7XNEYHhSMcxG/LS7GzeShLEYq1uu1nK2k0mbanAdubEFxvj/E5fONkdAyWBvObfogizv9HkS05siacFNBjk4rbsPNl2rISNqoycujseXFzc7iHI9Q8ycoJyV9fZF+ey5KuZ68ZJmFyr8tN/lE0XR5+EfV99NJf3LjgY2vLrUfTXNIno4W4yTFhEbhgbXJq48vF9Sn6KW274Zd6QP47ltjILGS7S4bq3WCiyAgh9b2EM+EG817AVk1XaJBYJ9lkT1989cmfHbbsRHHMAkPPEsMQjBVMxhhLq7gIXzKPECddx1i7Fd4vj7qlabddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b3pVjcNy278O64Hkedl0GRLT3wWf9iX9PJporhw7yE=;
 b=GTSh8vd1XCLyMz8mUaEKGQ0Ub1FZXyHHa0WwvzG9yQcLJSLmxk1K/y/paumpd4aufA9met6Mp9G5/Y4ieo54jg7Iuk2VbysDlVowNGWYrrllaLu+iQPzWI42vGy5xr1y79ZLsw1cdq9hgOZ5cE25jfA/oiUbbxmoMe0kKYJyQA0=
Received: from MWHPR2001CA0015.namprd20.prod.outlook.com
 (2603:10b6:301:15::25) by BN6PR12MB1300.namprd12.prod.outlook.com
 (2603:10b6:404:1a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 23:49:31 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::5a) by MWHPR2001CA0015.outlook.office365.com
 (2603:10b6:301:15::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 23:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 23:49:30 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 18:49:27 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 2/5] drm/amd/pm: Rename cur_value to curr_value
Date: Mon, 18 Oct 2021 19:49:10 -0400
Message-ID: <20211018234913.42349-3-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: dbb5f5a2-0d31-468b-0aec-08d99291ee03
X-MS-TrafficTypeDiagnostic: BN6PR12MB1300:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1300D872E37AE63A861B88A599BC9@BN6PR12MB1300.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9W+/uXwoAMbpk24fzP+1CtWaztbWNVGpTYv8FwOzVQsl7XzcssKa7y6oq+D/u8DD5P5RlvikKttAbacbfySqZ/ia1MUYBVPm0+bUiU212qRU1xZ714nHRg3TNBdlLpQtHcb2bGEsKwXJK8B0Ona7EpFHJY+rxQQOGIhGgv1n5KvG+sw1onRql4n6R8CIrxaXEEYppoMZw8enbK9hGdQaz+kfyDlw+3SKz8g5J+AsBCUlkZQdEyjgp9QMNcbKMv8c5LkqH8g1kkEfoNrDhefXGePXvbSPjox/F7xW4vuGQUfx+KoW8qL3I3w734nTnVwsean6YrqA2cy4T0NfX3b5ooUDtiu8fVa/KFUO8SAaT5p5YMFvHuByIlCoKU+03gq252Ou9ZDrur+rEnnoiCAqD/+u6YzXrQIoxqQerk4INh2BTggyKzdhaGzyqf1uHQ/thzFr8umNFZHOZWjvPSwnugZjETb6g26ir/LeBRjgihg0YkfYN7+EeIvE70DxQBz2aieygUPSj0uqSXUGf2sa3mt1qcu+l0bmXDWlt7O8u1NvBxkJF2E4eiZaagkH+qD7i/krl9aCWMfyb03CCSvAC7rw8CKPv1Kb7Wxbf5+usX2FSAFXYAM+KI7SQP/y6xbefMUWTrizC9nrJ4DHZMJl6x6s6B63P8E9+wKWgFwVAGI50afoxlkcxwA2IqZnS28tgYuWQ9mx6L1R9pwN3/RWhE2NhxfFDrM+uQjKnBPehc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(81166007)(4326008)(356005)(336012)(8936002)(26005)(36860700001)(2616005)(83380400001)(70206006)(426003)(508600001)(1076003)(6916009)(70586007)(2906002)(54906003)(16526019)(47076005)(86362001)(8676002)(36756003)(44832011)(5660300002)(7696005)(316002)(82310400003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 23:49:30.7687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb5f5a2-0d31-468b-0aec-08d99291ee03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1300
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

Rename "cur_value", which stands for "cursor
value" to "curr_value", which stands for "current
value".

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 12 ++++++------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 15 ++++++++-------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 0fe9790f67f5af..f810549df493d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1267,7 +1267,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 {
 	uint16_t *curve_settings;
 	int i, size = 0, ret = 0;
-	uint32_t cur_value = 0, value = 0, count = 0;
+	uint32_t curr_value = 0, value = 0, count = 0;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -1292,7 +1292,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	case SMU_VCLK:
 	case SMU_DCLK:
 	case SMU_DCEFCLK:
-		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
+		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &curr_value);
 		if (ret)
 			return size;
 
@@ -1307,7 +1307,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 					return size;
 
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-						cur_value == value ? "*" : "");
+						curr_value == value ? "*" : "");
 			}
 		} else {
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
@@ -1317,9 +1317,9 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			if (ret)
 				return size;
 
-			freq_values[1] = cur_value;
-			mark_index = cur_value == freq_values[0] ? 0 :
-				     cur_value == freq_values[2] ? 2 : 1;
+			freq_values[1] = curr_value;
+			mark_index = curr_value == freq_values[0] ? 0 :
+				     curr_value == freq_values[2] ? 2 : 1;
 			if (mark_index != 1)
 				freq_values[1] = (freq_values[0] + freq_values[2]) / 2;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3f5721baa5ff50..3ebded3a99b5f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1052,7 +1052,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
 	int i, size = 0, ret = 0;
-	uint32_t cur_value = 0, value = 0, count = 0;
+	uint32_t curr_value = 0, value = 0, count = 0;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
@@ -1073,10 +1073,11 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	case SMU_DCLK:
 	case SMU_DCLK1:
 	case SMU_DCEFCLK:
-		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
+		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, clk_type, &curr_value);
 		if (ret)
 			goto print_clk_out;
 
+
 		/* no need to disable gfxoff when retrieving the current gfxclk */
 		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
 			amdgpu_gfx_off_ctrl(adev, false);
@@ -1092,7 +1093,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 					goto print_clk_out;
 
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-						cur_value == value ? "*" : "");
+						curr_value == value ? "*" : "");
 			}
 		} else {
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
@@ -1102,9 +1103,9 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 			if (ret)
 				goto print_clk_out;
 
-			freq_values[1] = cur_value;
-			mark_index = cur_value == freq_values[0] ? 0 :
-				     cur_value == freq_values[2] ? 2 : 1;
+			freq_values[1] = curr_value;
+			mark_index = curr_value == freq_values[0] ? 0 :
+				     curr_value == freq_values[2] ? 2 : 1;
 
 			count = 3;
 			if (mark_index != 1) {
@@ -1114,7 +1115,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 
 			for (i = 0; i < count; i++) {
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_values[i],
-						cur_value  == freq_values[i] ? "*" : "");
+						curr_value  == freq_values[i] ? "*" : "");
 			}
 
 		}
-- 
2.33.1.558.g2bd2f258f4

