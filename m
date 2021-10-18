Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ACEC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC12610A2
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BC12610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203E46EAB2;
	Mon, 18 Oct 2021 23:49:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CE96EAB0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 23:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW7zKTfzb1AUaq+Cv+TCsBG2rRVydsiKNROW/t5j+jIutcwQ/VKIHAU1mAOttg6iHsBMTomHmLBDrKWpDOKNO5nF0MUNCvvGCvVrAKlZAwaYXCt4B/sFWj0syWkstR2wrCa3p9ZJHHQ89/90vJXjSJIZIsQqcBvrfva+PFbUJSAjrsS7Vs9JVQSvxKbhkTGpD4OThv/jMOWgtDCgWu3w+I/aLPtIWWaeUp2e+8RMvYp0dAd/F6Hr+v+Q8QZlNy/oRWTS3qkojkTH5QTV5Wwvod97VouLl+0Er7FHMrv0a/FqvMS8DALeiacgPabpInYskTiFk5YnlYdaVjbVeIVWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTFDAVAjTB8atwA/xW/3EjoNX4QGuLEpB+SsjIzZnN4=;
 b=brfb7H+iUGtY2f0oRQqgueI7uBNPxJj+SUu5X6ZDnM1rPRMeWWcY0pyElqJ1nBSqeYV16ugsmLZSRw2CYGIVk6cYN3gLd/7VeG996jSI1fOgGAL9x2vfDi+wy1ZEkZGv91L5O+y04JJkWuoZHm45XpA4hHN9tqRVXMs6EzOzoCnh0gJYrsUOX3FodffGMuQ6/H9hVVQ2HouyHCy0bzyBZY+FFu+KE+BwOw0OLVquKsA+SR8b1FGBSy+JEOQwccdCftkYJqVPBgYuGpvXT3LG2KVrOJfsl1YDnJnI+IAaZmRUuzJb7HfLYFFevfHDnEeuh8/mm/KMpWzIIo6j/+ppRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTFDAVAjTB8atwA/xW/3EjoNX4QGuLEpB+SsjIzZnN4=;
 b=tq8czOCZfto7kHG/SEk/KZk00YnJAK/M6Nwaj4koPWaGDd2H9mvBM3IlNSTQaPZ2H1Gsl2qe/8bSnHMMvH12YX3hKbgr90eoEun4pBkZzhjTCWfbqRDRk0OxhoUzNQxPbSFirqBZOa1xplnnwZSX28ibzZF53Yo4H+3/nRS4/Gk=
Received: from MWHPR2001CA0015.namprd20.prod.outlook.com
 (2603:10b6:301:15::25) by BN8PR12MB3377.namprd12.prod.outlook.com
 (2603:10b6:408:46::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 23:49:34 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::5a) by MWHPR2001CA0015.outlook.office365.com
 (2603:10b6:301:15::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 23:49:34 +0000
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
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 23:49:33 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 18:49:29 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>
Subject: [PATCH 5/5] dpm/amd/pm: Navi10: Remove 0 MHz as a current clock
 frequency (v3)
Date: Mon, 18 Oct 2021 19:49:13 -0400
Message-ID: <20211018234913.42349-6-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e6f7e64-6dde-4a52-0bca-08d99291ef9c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3377:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3377CDC246E0111D9CE0030399BC9@BN8PR12MB3377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxtztXZ7R/pvgXVap1P/jzy6q2xkKb8CuJ/7Wn4bDCmsRAXmFwGUvRhOuDEaTNAxyY6VJr40gkahS0Btu3QlAGTVyr3QKXnSAikzXP1602QOQk6mKe/zwmaZsXRJkVZFLyY+Slb6nA2tlEbucpJK64XJGITKgh2yUfEbhknYmyoHtLAH52d+eadkYfTqrcFB5zvhaPQfpQluiPs5x6pM1VUMawrnJbjE5eud0vTxF0fX9nKlw1i2E8Tc9F6m7nKxMRqFWkhtp8/05osaRXsnVRuIMVJxjeIkpMJR0wVHU0oL/aPXmI30vYB1XYvN8xV6wuHOCcMCa/a56mHlc1gjo8DLhwSP4L6BxljkGAgKgIT+5bFITBnrfqjuYTBgX9IjRiX7Oec3kw7cAygQhoQvBvAKimGxBbl01p23w++c1Cm17izx1S3RgQer9IPp0tHrGNgx9jy6ngE7scyJKZs1kfKH26WiK5wnXZ0c660dsZ4UV6PSmMJzPVOI7RwMC69PIwG4v7hSEkbeIjg1+l1LAnPX2G+8uvzOnyyOrXtK3X8VjAEFLh73cBb/uMa5p0HZWZpLGPfKhixyNvf2GTpBEIne/kVPIVN4Fqj6IRZbqBeWkkvJu1VqTPCf7yf5jmZgpfV0mJsMa/RAIudDIzbDaZzBGK3VJkus1pM8CKbchiiXVy1f8ZFRz+PZ2yyKzVHwo3iiJd9o6HRRpIxWKVyvdSn9MjIlAn6sG072rkCl484=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(7696005)(36756003)(47076005)(26005)(5660300002)(8676002)(83380400001)(2616005)(86362001)(6666004)(36860700001)(4326008)(356005)(336012)(6916009)(82310400003)(2906002)(426003)(508600001)(1076003)(54906003)(70206006)(16526019)(70586007)(316002)(186003)(44832011)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 23:49:33.5441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6f7e64-6dde-4a52-0bca-08d99291ef9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3377
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

