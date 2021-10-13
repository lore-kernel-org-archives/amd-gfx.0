Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2BBC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3915610C9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3915610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E626EA81;
	Wed, 13 Oct 2021 16:12:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA2A6EA76
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 16:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5WfmhgUJmIXxXQT+yvWWiwmXHH8JnFHa984g3kCixJt5lMLug5c5naFCylBbxbHGhaF8m6p7whuU3U/Auc7IRyJp05J0+P2GFuq23dvIfKXtTOOYXhzr6EGYbooCbDt++D2LUiNUDyA2EGLH2bAgqi2aBlr9q4hOc6EuobK/J1GJr0IdEBfYo2b1radMYe9g5z1vz2dAs/kITWPW5HTs60fduhgVHJZeWsrbOSv+Iel9Xps6kespLh1deCZWL4+MeGVnzgjeOrvuCkm19FFkviK/8GUguOrD9E3hcxmpITjw1IYa3VUC1d1D4B3ZPF6AKcYG3LsBkpuEGVMqTWazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj/nDzAmhwz0ETvefxT1gxl/2IrpJYvTVTMNA6pn54k=;
 b=W/PnLTsO33yHq6ZXO6OW7e3dXb9d4FvAV7aDGp0pAqaBHepHHv0Lzjj6FWvbe+qkSGpxvE7eSOxLmQGC31+eBAex+ykmkZE0eywqan6p3v+SZsKA1JFQC4YMReP7BWKjpGEwWgejM6I3WYKQOh7C2/9j8PtnapSuG//iuDeIzjKNqTMcjkD+50F/WX4nvAibx76A01fC3Mr0DEnuOtZIOgGXaLWMvREIFrBxWNaiETwcof20anTTKbmY0HnyCQfm9yeMpCgtPNpZqAK68JcAgotVOkWJw3DisOwVZTu+6gQF4TEKhEiCg+zQz3yJSOWx8D1xJoYRKqa4VkCfQft0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj/nDzAmhwz0ETvefxT1gxl/2IrpJYvTVTMNA6pn54k=;
 b=sZ7mV2d7bigKd1EhYPxTELAqwaVKdE4FKtxS5jGpC4g9+SbpgNh6RC0/BRA5FrTypIzdvz5aeM1WoAHln8nmQrP+KMRWDThoVaIf3SVsIAh8yy0GQqQbElMlYCMgowdhkU6YQw5KcILyO4fAxyWcVXE1QQXeyDV8jUoKikXa63A=
Received: from MWHPR19CA0063.namprd19.prod.outlook.com (2603:10b6:300:94::25)
 by MN2PR12MB3517.namprd12.prod.outlook.com (2603:10b6:208:ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 16:12:17 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::ba) by MWHPR19CA0063.outlook.office365.com
 (2603:10b6:300:94::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 16:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 16:12:16 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 11:12:13 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 4/5] dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
Date: Wed, 13 Oct 2021 12:11:59 -0400
Message-ID: <20211013161200.9052-5-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211013161200.9052-1-luben.tuikov@amd.com>
References: <20211013161200.9052-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfc55e03-d1aa-47ac-e85a-08d98e6439d5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3517:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3517EF17F00168AAD6B52F5C99B79@MN2PR12MB3517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2gV48RLkKFsiersXGPN14GNb7zX92vY+pB4LJEfTzP9su0DFDbG0XZRgpERB5AI8YZubgB3ppZr/QWc+XhwOp3CwqCPfaiK4Op0A+f4Vijk2WTKD3x4chE0yW9pQ7X1BLIH5eObuaTqM8FZP63gad0gyZHFwIHGVYU7RgriGSG9b5gYyWEMJsz3SLnype3OKLL6lcRXH5/JHJqDooVfGGpmUL8q+snXjU2Q3kcRWl4Xsl92G0TMnC2/wmKOWD/LTOKZPLxQI7DNR5Zln54CcESGuiWhYa8ovVEmB4PTtbit6XvQM75+H1+91FkM8NYvYbhjpZwMW0p0Ra4dxw8kpw5fWiGaun18zDskskUGPVejR/lyYaaCKzC+0JyvthY+xftfAGC3VD3aApI6OflVbYlEKFc5ZZHCySCPOYTou9lirlC2K27dDVn+Cg7TuNL9C7Tpu//gJxX6J8Mz6QlQxqU9WTjF7aKRdnG+nImuydlBIjSAfpBPxmTYJP2KAd6XHuRrCc/uYlqJ/sroYOv/d5sF3cFMNTV862K9Pk1Tzq4K+Dh3FqionbGh7VzMDaI9EtSSYOFIlvMpP5ktfHSrZ/4ekhdMKbGwM8L9dd4523A8zH9DGZNQ/7Gr34h15s9a9dfryLFvmMD3Pe+yJVUB+wQJuu7DUZ+6Pa7MMItvtGzD7BKVCMQS7yhYP7RLAMUwreaHXBLeT1Far44apPKOwg0humjzRzly/ChY5p9pKR8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(36860700001)(356005)(186003)(36756003)(8676002)(336012)(16526019)(508600001)(1076003)(47076005)(81166007)(426003)(44832011)(54906003)(2906002)(86362001)(82310400003)(26005)(8936002)(4326008)(7696005)(70206006)(316002)(70586007)(83380400001)(2616005)(5660300002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 16:12:16.6220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc55e03-d1aa-47ac-e85a-08d98e6439d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3517
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
current clock value is 0, then report as the
current clock the minimum operating one, which is
non-zero.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 57 +++++++++++++------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f630d5e928ccfe..00be2b851baf93 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1054,10 +1054,10 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	int i, size = 0, ret = 0;
 	uint32_t curr_value = 0, value = 0, count = 0;
 	uint32_t freq_value[3] = {0, 0, 0};
-	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
 	uint32_t min_value, max_value;
 	uint32_t smu_version;
+	bool     fine_grained;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
@@ -1077,6 +1077,22 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
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
+		 * current clock value is 0, then report as the
+		 * current clock the minimum operating one, which is
+		 * non-zero.
+		 */
+		if (curr_value == 0)
+			curr_value = freq_value[0];
 
 		/* no need to disable gfxoff when retrieving the current gfxclk */
 		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
@@ -1086,38 +1102,43 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
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
+			freq_value[1] = curr_value;
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

