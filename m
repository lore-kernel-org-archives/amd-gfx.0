Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A738C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7596108B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F7596108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9396ECB6;
	Fri, 15 Oct 2021 00:51:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8FFF6ECB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 00:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agU4uldyd/tQv1c+GQ4cvNNRsck7RReys7Z290zSH3JDf08yMYcUa4KKHyMhFUwshkLfPQNgdQ6jY8D6l4NInMILsGk0kiyTMPFWOf4dtd76ynNzbLM9tJumAii7y4tAz53P36AWyfH6gkfpdkUdoqSchb8HeZ64udN4vXyNMemgYk48kWxTn0NbvhI6WPDTNBOL3l15Y33lTbR3D1LXPjsQCAif0NSKBC0vejg7liG9JvKHqtu+W3CXoyG5r7RSUOlZpLOqoscn4DSPgxkAWdzLgVNrdTWSasVWebIe4dg/xjMMPXLdJpvQoAt0/gICVzGNALVWCqmPHgUejBOROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuI5kIQ6HkhBZJKZzWLOAau7WmIn29D2HZNua4L5t54=;
 b=C4CTSumm+KNa2Bw0TPjeInbbHnQoZ4QUCAPTmcUPtXe5MOiQxU4tGF2G3C5q5F/CctyV8zST+6JsQWjb+ftOZg3OMGdq/yJKyW0KcLNDKXT2PuLiDuDtGzjbIRi1Yq5SodAP9/E2GE+oLwICffWrc8DEsFEq8AuZdqiCbEUHMP/ykeWImia2n/WbpKsBk0LgxnXzysWBRZKVi8UU3TZ+9szYCLm/R2SburXBLa7wjslGlnmUDqZ/VQD6w2PJaZBNjt+EETXxjd6fFBN+Q/u9qpoMZnKtRVsr8TxexNOA20QfYu2tSI3CkuwZpLmDOCkZDAETzDccw9wGkkagA6RQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuI5kIQ6HkhBZJKZzWLOAau7WmIn29D2HZNua4L5t54=;
 b=GdJWfaB7IO6d98EEahgapwz2MeAbGyc59+LPDKVM7NjYmPK5aldjYyiiFvLRMk5p75NMEhEVsuTLG1LRR1V9o6tMLlPciiQRezmcADvnM+wzlTE0dPCyBuujeZclESEP1wg0Tpwi9XJvLfJVc4OBkfwKBbM1PUM6D8IKfG8QcBE=
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 15 Oct
 2021 00:51:12 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::c4) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 00:51:11 +0000
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
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 00:51:11 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 19:51:06 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [PATCH 4/5] dpm/amd/pm: Sienna: 0 MHz is not a current clock
 frequency (v2)
Date: Thu, 14 Oct 2021 20:50:45 -0400
Message-ID: <20211015005046.43486-5-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ad3fabd1-3612-4b70-96d4-08d98f75e1f8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4357:
X-Microsoft-Antispam-PRVS: <MN2PR12MB435726B32D6306A0589C7D2499B99@MN2PR12MB4357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ojbj1GTqianq6/jbwEWms4SEB2KtiAlmMuvQF9kDTJVs3JIXEn7hC/M+KkzNDvkoAgeMwOWNVVivGR12OznX8IUpMD44SiygCoTzaTRrYBmVxhwbv/GWJYWG0empyvp0xXHVaOPwbtfPQRYlwayHRzLauDLQ+0oiYJvifPmb+PUVyDODbrpTPscNIrZ2eoNS6v0touGIFZyPfNoRE3BfTYbwKcOX51Hg6eucxs496jVf/gEVmo0miuvmKTweM8PJsPdslQi50KkEBPxZrm9zRFg3g9R7AQAdEY89QVUR/QPnZkn3y0JAoCQYVi9Qxk/DQqkW4bGRk8/u0Ox0zPijzs/nVK6D211/Iv+vgCjgglsEBB3ZLx2gpIKVNsSlQwwZonZyUTZpanH2AEexz1ZuP1NKkhT9+t12B9/ZenzQTu5oYbFajoz7I5hmuIe86QkVEFRZgQ3mSiDAz1ZvrKyeWhymrGVZz8RJiBsvJNv/+UcZnX+xQHD4tarxLs9SkIsVmzhCEhELX5XPDYOTqCUYZKj97X1wb8N4rHKk/0u8qubK3xJgLnkcM9TNzrNU9BzU2dNN07KLZKXdMaC7roa4LXJDBapU35EU5/7hNMJcoqqYQVsPzfIQPYCy9tRwxT0XdP00Ikn+NMxWECkyGJtVicFtoRcLHTYvxwO76MkIz4pluNBjXYpVAx2UqkcFYVEiJwt6klnsSmBcrA7dHIIhHTRCrg3GBZCGYruhZ1nDXHU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(44832011)(1076003)(336012)(6666004)(54906003)(8936002)(186003)(36756003)(26005)(508600001)(4326008)(83380400001)(426003)(356005)(7696005)(70206006)(2906002)(16526019)(86362001)(6916009)(36860700001)(82310400003)(316002)(81166007)(8676002)(47076005)(2616005)(5660300002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 00:51:11.2038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3fabd1-3612-4b70-96d4-08d98f75e1f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 60 ++++++++++++-------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f630d5e928ccfe..6fe792be77dbbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1040,7 +1040,8 @@ static void sienna_cichlid_get_od_setting_range(struct smu_11_0_7_overdrive_tabl
 }
 
 static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
-			enum smu_clk_type clk_type, char *buf)
+					   enum smu_clk_type clk_type,
+					   char *buf)
 {
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -1052,12 +1053,12 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
 	int i, size = 0, ret = 0;
-	uint32_t curr_value = 0, value = 0, count = 0;
+	uint32_t curr_value, value, count;
 	uint32_t freq_value[3] = {0, 0, 0};
-	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
 	uint32_t min_value, max_value;
 	uint32_t smu_version;
+	bool     fine_grained;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
@@ -1077,6 +1078,20 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto print_clk_out;
 
+		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0,
+						      &freq_value[0]);
+		if (ret)
+			goto print_clk_out;
+
+		/* A current value of a clock frequency of 0, means
+		 * that the IP block is in some kind of low power
+		 * state. Ignore it and don't report it here. Here we
+		 * only report the possible operating (non-zero)
+		 * frequencies of the block requested. So, if the
+		 * current clock value is 0, then we don't report a
+		 * "current" value from the DPM states, i.e. we don't
+		 * add an asterisk.
+		 */
 
 		/* no need to disable gfxoff when retrieving the current gfxclk */
 		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
@@ -1086,38 +1101,43 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto print_clk_out;
 
-		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
-			for (i = 0; i < count; i++) {
+		fine_grained = sienna_cichlid_supports_fine_grained_dpm(smu, clk_type);
+		if (!fine_grained) {
+			/* We already got the 0-th index--print it
+			 * here and continue thereafter.
+			 */
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", 0, freq_value[0],
+					      curr_value == freq_value[0] ? "*" : "");
+			for (i = 1; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
 					goto print_clk_out;
-
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 						curr_value == value ? "*" : "");
 			}
 		} else {
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_value[0]);
-			if (ret)
-				goto print_clk_out;
+			freq_value[1] = curr_value ?: freq_value[0];
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_value[2]);
 			if (ret)
 				goto print_clk_out;
 
-			freq_value[1] = curr_value;
-			mark_index = curr_value == freq_value[0] ? 0 :
-				     curr_value == freq_value[2] ? 2 : 1;
-
-			count = 3;
-			if (mark_index != 1) {
+			if (freq_value[1] == freq_value[0]) {
+				i = 1;
+				count = 3;
+			} else if (freq_value[1] == freq_value[2]) {
+				i = 0;
 				count = 2;
-				freq_value[1] = freq_value[2];
+			} else {
+				i = 0;
+				count = 3;
 			}
 
-			for (i = 0; i < count; i++) {
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_value[i],
-						curr_value  == freq_value[i] ? "*" : "");
+			for ( ; i < count; i++) {
+				size += sysfs_emit_at(buf, size,
+						      "%d: %uMhz %s\n",
+						      i, freq_value[i],
+						      curr_value == freq_value[i] ? "*" : "");
 			}
-
 		}
 		break;
 	case SMU_PCIE:
-- 
2.33.1.558.g2bd2f258f4

