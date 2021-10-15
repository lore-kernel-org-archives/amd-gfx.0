Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245F5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1704610D1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1704610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 768E16ECB9;
	Fri, 15 Oct 2021 00:51:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159BB6ECB9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 00:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgizwf7TyXabz4os2jatJ+tQepyt+qOkQ/GvbjQ5A2Wl8HAu1di0XsBgk+8wCvnqIcOXQ1CBRl4wdAcTo76i4VpidaoH9vFXowqQgj/kVljrx/PTSHDO/6h9LKDgN+QElUqow+loJZ0UrXR9XJV5bTWQomJMJBC1NiUrxP+3qf3WfBbK04Bibo4uVp4Y2Pwr03HmzFGx+dsKWxzNI24JgQFuYrqmE7V8hcadEbwyKVEJoKXR0puV+4X1yNFYQvU6JrKsf9GFVO2If2EqpgvsBTM09knIEoeCtg59P9H1uIysLCYTxP6jsYhxI4YAXQ/lR3kIuVOlpzlhi8bxKRI3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOtNterp08Mo7HNRtmm08FFa3Q7IffSUewwTm4kGpuI=;
 b=jGwg7KhtYEap7ORK2ixsgRVqdCuTI3sjM7VsQoYuim27r6G1zfY4YgtVM5p03YZPAP0sawAFr+PSLxOGZboz0hAQRi8Sb976jTwIwqJ03h5PMKdz5/PklC5xXga/tFxpRiI1ynWihD0IDtGyh+l/tiMxwZ+Nk6y5B6tmwkiP3tUK1uE/2Xu0AXFSAv+lTxGl3FnUx56txc5hHyNuTfKIsuQbiA/ljRiAXlm4OtyjAinORxMC0jmZQaZ+nQiH4+hgjIc27gmT7B/5waz0JRV354E3a4NwlWs7tz8Ot5yBc+qwyfiP33k4X8SxZA9Ikk4/GFglAuz6p2M/IjEEU7w74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOtNterp08Mo7HNRtmm08FFa3Q7IffSUewwTm4kGpuI=;
 b=GDFxW5O0KrMTyo8foSBTUdvmEp0XKQOLk+rEDwiXtYs3cMtxUw4sqo8U4iOtO75xH/sggm1deJxN92UTfHDNGv5pwCPQYlvstgOduahYJT55+D0c8S/b12xCl3stXIVVYenJLLshRMtWIrgFPhlqYVBzldePkgeWqnqb4IgwBIo=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by BY5PR12MB3651.namprd12.prod.outlook.com (2603:10b6:a03:1a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Fri, 15 Oct
 2021 00:51:13 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::a7) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 00:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 00:51:12 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 19:51:06 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [PATCH 5/5] dpm/amd/pm: Navi10: 0 MHz is not a current clock
 frequency (v2)
Date: Thu, 14 Oct 2021 20:50:46 -0400
Message-ID: <20211015005046.43486-6-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211015005046.43486-1-luben.tuikov@amd.com>
References: <20211015005046.43486-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7424c88-4acc-4c20-9a68-08d98f75e2b6
X-MS-TrafficTypeDiagnostic: BY5PR12MB3651:
X-Microsoft-Antispam-PRVS: <BY5PR12MB36514C810293EE3E8ED247D499B99@BY5PR12MB3651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCbs88vfUdiRZvBiEf1/4Nr4j+jQR/QE3TzP7OuODBSs0O7Ee4pBIAXNyFyvmGB7+H5CmY0hCKhaAZBYoH6BciOXaqeiGxpQ2PAQF0QZSYwvsCPsGhDhVJoQEtBom4d21MUQ3Ccik/hm1GEbGMPo49JOrt8r/t46h+iD75ZsdcVL/0mS/gXU5b5I2c1QwDIADrTqgsqo5PTnxrn5KDL42DDFoAXdYAqRp7jbVqkiPK/mcwqZUU7GTx4gMpouiKNfWgVtAKk6k113LlW7oMgXpn3a7nm2J1NQuj5Tqn+I3aZPj6atf/IUvdD59W7XdRMdr8nfXtnpBSrlA/ZDJkdDQG4hCyuZ0SZ67LMMRL9TpaJSzjPNntudZU1W+vWQXw6OOx0qtttCLVL9sfjaJsKtdujae+zyG+HYST35qGWQhc88zOIaXy6yY8DnzejApZDeHjg/eXrJU3Cu85ssEnv7YsSMbVDS0CNz5iDW4J9VVafmllv/5BbM8tAwqUq/5x51yCPv8E1RVcfYyKC3qVsMOknY9StAP7/Na8Wm5uux5UcUIlNJiIxSWwMmCxpuZi47bjd2kRDiEi3KMzcR5yn6kLnKWFxaI6mF+gphnxYxCQ63AyICwRokjsXtYUjZ/zlFvNAObp3/gJYOEzyCP6rShhslq3U4CZlHKyOxGA154TbRlx0xlHIq3rEm0cDaLm4gCBjfd8dozlSjRhSUyxTWoONX1qn2LStblxYg1UiQG1I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(2616005)(54906003)(6666004)(81166007)(7696005)(508600001)(70206006)(316002)(336012)(8676002)(4326008)(86362001)(6916009)(82310400003)(8936002)(36756003)(47076005)(83380400001)(356005)(44832011)(16526019)(186003)(426003)(2906002)(36860700001)(5660300002)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 00:51:12.4291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7424c88-4acc-4c20-9a68-08d98f75e2b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3651
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

A current value of a clock frequency of 0, means
that the IP block is in some kind of low power
state. Ignore it and don't report it here. Here we
only report the possible operating (non-zero)
frequencies of the block requested. So, if the
current clock value is 0, then print the DPM
frequencies, but don't report a current value.

v2: Don't report the minimum one as the current
one when reported one is 0, i.e. don't add an
asterisk (Lijo). LT: It is conceivable that this
may confuse user-mode tools if they scan and look
for a current one, i.e. look for an asterisk, but
they'll have to adapt and use other methods for
finding power states of the chip--we can't report
0 as current.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 44 ++++++++++++-------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 646e9bbf8af42a..2af6fd336352aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1267,9 +1267,8 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 {
 	uint16_t *curve_settings;
 	int i, size = 0, ret = 0;
-	uint32_t curr_value = 0, value = 0, count = 0;
+	uint32_t curr_value, value, count;
 	uint32_t freq_value[3] = {0, 0, 0};
-	uint32_t mark_index = 0;
 	struct smu_table_context *table_context = &smu->smu_table;
 	uint32_t gen_speed, lane_width;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
@@ -1279,6 +1278,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		(OverDriveTable_t *)table_context->overdrive_table;
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	uint32_t min_value, max_value;
+	bool fine_grained;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
@@ -1296,12 +1296,20 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
+		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0,
+						      &freq_value[0]);
+		if (ret)
+			return size;
+
 		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
 			return size;
 
-		if (!navi10_supports_fine_grained_dpm(smu, clk_type)) {
-			for (i = 0; i < count; i++) {
+		fine_grained = navi10_supports_fine_grained_dpm(smu, clk_type);
+		if (!fine_grained) {
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", 0, freq_value[0],
+					      curr_value == freq_value[0] ? "*" : "");
+			for (i = 1; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
 					return size;
@@ -1310,24 +1318,28 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 						curr_value == value ? "*" : "");
 			}
 		} else {
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_value[0]);
-			if (ret)
-				return size;
+			freq_value[1] = curr_value ?: freq_value[0];
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_value[2]);
 			if (ret)
 				return size;
 
-			freq_value[1] = curr_value;
-			mark_index = curr_value == freq_value[0] ? 0 :
-				     curr_value == freq_value[2] ? 2 : 1;
-			if (mark_index != 1)
-				freq_value[1] = (freq_value[0] + freq_value[2]) / 2;
-
-			for (i = 0; i < 3; i++) {
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_value[i],
-						i == mark_index ? "*" : "");
+			if (freq_value[1] == freq_value[0]) {
+				i = 1;
+				count = 3;
+			} else if (freq_value[1] == freq_value[2]) {
+				i = 0;
+				count = 2;
+			} else {
+				i = 0;
+				count = 3;
 			}
 
+			for ( ; i < count; i++) {
+				size += sysfs_emit_at(buf, size,
+						      "%d: %uMhz %s\n",
+						      i, freq_value[i],
+						      curr_value == freq_value[i] ? "*" : "");
+			}
 		}
 		break;
 	case SMU_PCIE:
-- 
2.33.1.558.g2bd2f258f4

