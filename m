Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82436C10F1E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 03:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2766D10E229;
	Fri,  9 Dec 2022 03:49:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C7CE10E03C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 03:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IucejLeNBArsKFo9mhxeaEDCuV0J7WpjpzpD8MLCFcw/Sk9jJ3jKg8Ow27WEB++zIsP9RPTgKvPreWa0eDTWZ5s3YRkXbX10IIuKcp9xYg2/tpK2FwL4IAV9DM3yqOyMMOoI121GnK+MBcg+0gWOFeOgOtnrq7ecD0oy/3mk9oY3uYIbrVb1UczIFPbO+rYtQ2JQnD0sZVqgTg0n/3IShDpfO51XXgq2pKWBvJx1raO26NmlI5fa1SCdqfz2KuJbwdjS99Ir7BgghomrL8bzG4jlGz7a8w8YabmncNAd8nS/jZ06Q9a0BqBUyVTMv7Y0Tnat4S9xtvDWg3ECgatkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FpDhIx2vDl+sw9lHuu3uLiZEZiAPHsrE3G3++O/GtA=;
 b=ko1h9TItL0p8TNcze8ZPsRZmCmU6DLz9BHttmDwaNUiZfzd2xuKdhitQDT0ZTXQzzCXvT1KDragF39ty5GlLHtNycUqaL7mMNS+PpnT/mV530cgJ8sb2oBpWKPRroxSUiHmRDLuQdahV58k6veeLJB3/tLIYvmd6VM6MSoawm/YKjtDdEDF49y0FhGAIq2O4OdAfMpBZMLeYdYVPIqUJxi6lBk5hCd/HEm/C6MnwZTeDNJjbJVjjd3zIUigHS0jszgUMFXmKa8E8xCXphFT/4ezzPmWOTbdpjM5MWT2v48Xm5fosNAxeNN+W33t/qgfQpA+dZF+UkwC2DoM0EHvqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FpDhIx2vDl+sw9lHuu3uLiZEZiAPHsrE3G3++O/GtA=;
 b=kYpNa2KoWA7OvnL210V/UG5c3oqNMx4yFtnenU9WNzvZ3X8l5FLxsn2RRNUjPFOKlS5FTpql8Xt8pQfHKGt/DNXpmoz8WW0noSetQbKFhz11X1PiJ8YJcVryv9JNEVFoHV061bWcrBltzUUwdYf9hvB/YG0/3YVLDItIHdVZbRI=
Received: from BN8PR16CA0011.namprd16.prod.outlook.com (2603:10b6:408:4c::24)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 03:49:13 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::65) by BN8PR16CA0011.outlook.office365.com
 (2603:10b6:408:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 9 Dec 2022 03:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 03:49:12 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 21:49:10 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10] drm/amd/pm: update SMU13.0.0 reported maximum shader
 clock
Date: Fri, 9 Dec 2022 11:48:13 +0800
Message-ID: <20221209034813.2373727-10-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209034813.2373727-1-evan.quan@amd.com>
References: <20221209034813.2373727-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d129c41-c823-47ee-e507-08dad99855ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGNtH00cMmPGHXiEcbWTlpcQhrPkpcs33v+L5JD+PeAyTR1jQw2oc2XuN+In6gti69oe4clmduCzmmDcvXdFGM2AymarbrEbnBenGzCUB64230wmAbKbi8auaU3RxnDVxR1cU67awJ1VVpUzuCWLH55n4MDoQNrtcIJ773ysOo6fyugRUjPuuUl03w8gLHjeLXGHLUpkQr0KUe+UdYkR9JOcewJGrZ0ocNm5+tHR/bTLij5G6oSCol1hvKf1ZbzG3z1KPGPNvUfWEuHgnberSO1I+NkHNRZr8NueONzma6mT7gZj5TvY4puoaIkO28Tbctzal/3Krz01w66vkkfHIYW9OYArB6FRIK1Ic2PizanqxRjPUBMd6yEk/UjMUoXnJxIfH9Kz86j5hKaY/QG+IYo8WjHISgXsrG/Svska0gRQdTPRpvG1qFPA3ryTBBtsAFxJ8GfsXOeJDJj+4pWlFn25BX9A7zK1htaZ+NVtvNDe9YGCqL/jgbAa0K+BwjvVSpyzGQFQjHR5/LREthQdntDp1o9ITJj5r9AgG94CvF60e3hOtkosVHezBc7qVOdDgy1uU4lypnQTDu/1ElajTRyXF+RLJhSIUiiGZ87LD/bh7QuTz2YyoLyQbPGKvVxUTV3Evhm367mTPUl5a6C1JxLpWbG1QinSJJHjTx4cLsZ+oTluNwGaUtb35Ew7He4lp5p2Tn5zV29agEMvPlgBzwuInETeKv1ZKKFnxJLSzq8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(316002)(82740400003)(40460700003)(82310400005)(6916009)(36756003)(2616005)(36860700001)(40480700001)(478600001)(1076003)(83380400001)(54906003)(81166007)(44832011)(86362001)(26005)(356005)(8936002)(7696005)(4326008)(5660300002)(8676002)(41300700001)(15650500001)(336012)(70206006)(2906002)(426003)(186003)(70586007)(16526019)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:49:12.6655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d129c41-c823-47ee-e507-08dad99855ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the reported maximum shader clock to the value which can
be guarded to be achieved on all cards. This is to align with
Window setting.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I83da5ec931664af36ee6db3cb13ef655db54220e
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 70 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 4adbab62e9dd..5a0593d336be 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -541,6 +541,23 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 						     dpm_table);
 		if (ret)
 			return ret;
+
+		/*
+		 * Update the reported maximum shader clock to the value
+		 * which can be guarded to be achieved on all cards. This
+		 * is aligned with Window setting. And considering that value
+		 * might be not the peak frequency the card can achieve, it
+		 * is normal some real-time clock frequency can overtake this
+		 * labelled maximum clock frequency(for example in pp_dpm_sclk
+		 * sysfs output).
+		 */
+		if (skutable->DriverReportedClocks.GameClockAc &&
+		    (dpm_table->dpm_levels[dpm_table->count - 1].value >
+		    skutable->DriverReportedClocks.GameClockAc)) {
+			dpm_table->dpm_levels[dpm_table->count - 1].value =
+				skutable->DriverReportedClocks.GameClockAc;
+			dpm_table->max = skutable->DriverReportedClocks.GameClockAc;
+		}
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
@@ -803,6 +820,57 @@ static int smu_v13_0_0_get_smu_metrics_data(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
+					     enum smu_clk_type clk_type,
+					     uint32_t *min,
+					     uint32_t *max)
+{
+	struct smu_13_0_dpm_context *dpm_context =
+		smu->smu_dpm.dpm_context;
+	struct smu_13_0_dpm_table *dpm_table;
+
+	switch (clk_type) {
+	case SMU_MCLK:
+	case SMU_UCLK:
+		/* uclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.uclk_table;
+		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		/* gfxclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.gfx_table;
+		break;
+	case SMU_SOCCLK:
+		/* socclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.soc_table;
+		break;
+	case SMU_FCLK:
+		/* fclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.fclk_table;
+		break;
+	case SMU_VCLK:
+	case SMU_VCLK1:
+		/* vclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.vclk_table;
+		break;
+	case SMU_DCLK:
+	case SMU_DCLK1:
+		/* dclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.dclk_table;
+		break;
+	default:
+		dev_err(smu->adev->dev, "Unsupported clock type!\n");
+		return -EINVAL;
+	}
+
+	if (min)
+		*min = dpm_table->min;
+	if (max)
+		*max = dpm_table->max;
+
+	return 0;
+}
+
 static int smu_v13_0_0_read_sensor(struct smu_context *smu,
 				   enum amd_pp_sensors sensor,
 				   void *data,
@@ -1908,7 +1976,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.dpm_set_vcn_enable = smu_v13_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v13_0_set_jpeg_enable,
-	.get_dpm_ultimate_freq = smu_v13_0_get_dpm_ultimate_freq,
+	.get_dpm_ultimate_freq = smu_v13_0_0_get_dpm_ultimate_freq,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.read_sensor = smu_v13_0_0_read_sensor,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
-- 
2.34.1

