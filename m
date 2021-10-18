Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B79C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A73D610A2
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A73D610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445EB6EAB1;
	Mon, 18 Oct 2021 23:49:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4EAB6EAB0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 23:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY5sPxKWodn/de+KNeE1T8b8UpJbcRkVKx6s9dsNVrdgk9budgOXyeCJJAVt75+4yZQ1Pto05LArC6NGbNJ3sAL8tTKLFNxrpqcX9opS8ov0jQYsA15Ev1TwnTGIohw8fIXsOCr5OwNffh7iOYfClsBeeVZbuw39vVfCzGzMYGiOr1DnTX1rHu9EBLiaaKePIMATPvAVYj1WR9eeoKF1tQOw36H7Iu4M9XAUeabYKzl4dWhRJ7TmMGcePv2ERFsxl05H85FUaWJyJ2IhRSUWpNHsTFqOtLp8mvJwz7nk1qLCU7Zlwx7qlZly2ga+EZcpNaQFDSQKoghCdK49vC8qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhJQROL3Qh39740LP0jhp/IcCjyyCr2EXtlGzgMAw00=;
 b=Y29gRJLhwQK8m/c+fQ4DADjSMBH2xRQ+s63f0HW0wQLE1MaWLajjMLj64hDCpb12tPpHRunFPemF7WU1/3dAfQoK5FfVnEkeyQur/K6vxuV8lH93rDdeRsOHUP3sylCQluCpi8oplWbPNnSuGqrW5gBjzeGo/mQHMUyCmUOcwXSJ51fSbYU3tWnxcGOljccqb6r+LsxaFKW/KdmLqdkq+rTAqbCImvJhBgTs0XxbPezVFHH5MuvBjTJUtU0DE5NXczfw14O2ezNKUqjZGmtVdGHXnrSbJtGIXjM7SJhaTFRNDRg2BMcNGVfb1pEDIZEoc2iMPvv0ycqlRvPl9upHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhJQROL3Qh39740LP0jhp/IcCjyyCr2EXtlGzgMAw00=;
 b=Y5d+IW7Ijwd3NVnMhhncKWl9YQx0OUw6yedTAeXdF22Hsx/YY4U5IFf4y4fxi1GKt3+6sDasp2eOFEiZ2LZ66aKPHaWO1g2SZ6GmJ+AcHK0gmVP2gAFfWdp3NtpekYFOgAO0IzST2VMuvgTuYTxYYxpEh5G2tbe4WD0v+6NvCyo=
Received: from MWHPR2001CA0005.namprd20.prod.outlook.com
 (2603:10b6:301:15::15) by CY4PR1201MB0261.namprd12.prod.outlook.com
 (2603:10b6:910:1c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 23:49:33 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::14) by MWHPR2001CA0005.outlook.office365.com
 (2603:10b6:301:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 23:49:33 +0000
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
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 23:49:32 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 18:49:28 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>
Subject: [PATCH 4/5] dpm/amd/pm: Sienna: Remove 0 MHz as a current clock
 frequency (v3)
Date: Mon, 18 Oct 2021 19:49:12 -0400
Message-ID: <20211018234913.42349-5-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41def9d2-0d13-449a-b447-08d99291eef1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0261:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0261E2CA069E33513A5D382199BC9@CY4PR1201MB0261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/cr2dPjjIAOubbtOMd3xQ+xTD/faiuDckntPX7y4Lt3L1XGAEvTWcxO/fslx4OQTu8on0JJeEbi6jYiybGNxUuIYcMaHtP4F1Svnn0dVqUx9XYUXawjmqVIvoih98XoEi0S5Mxr8ABckxZO+zPLGS+ROt0l45IKWSvpKY6ar/etCXSetIFA9aryWKb8g8XOG1vmhv0yx9nH0Dg734tOQa0K1UtsE6wLfzgBZuzAYVTIZN7VXTd+EhfK6Fjpskjxct6cjHFchCeGJCVFkRdmY6M9Q8XJroo0j55gdiy5lYZziuy0pNHpCWNbzzfpwibPQbLoHRH+/0q2iWEXKlgUNCswNvu6E4DDvhRenm+hQkiMggGI4+LOgCRo4N8085d3ui6QvYGTlNDP5LLtFMLg88utIyke4e2IKcBvFf6KtMO9KJtMf8zi5cMXpMSQMGhTqmMOHU+/OLwxzCUp7QM4FE7fptd9efwoeIc79o/010VmU7LylGV16rE24/u43wK8tNjAiHINxMLTj1jmksyUY0ZmSzPKIxvLKTeeqafASzYqoPNSBzToLDbt5vtyQJUAX+0Yu/Tzzpbm2Kb5Zrs64aGMEUILDVgejdVRZUPJNDwRw1lKGybrV0kKUWM3Vl+hrTPoQQJdNydwZBsJQJfzb739iMfWLeNW+XWxe6CPCjJIhYuSlyW//WA6NVLmeomoLJ4wiBSS1yaOKpd5t5Hro3T2IgaQ6HNDrDGURSUrxk8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(16526019)(70206006)(2616005)(426003)(44832011)(83380400001)(86362001)(508600001)(26005)(82310400003)(36860700001)(7696005)(47076005)(336012)(81166007)(186003)(6666004)(5660300002)(4326008)(356005)(8676002)(8936002)(36756003)(2906002)(1076003)(6916009)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 23:49:32.3098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41def9d2-0d13-449a-b447-08d99291eef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0261
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
v3: Start the subject title with a verb. (PaulM)

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
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

