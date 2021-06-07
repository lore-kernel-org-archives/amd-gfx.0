Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EB9C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D9B61153
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D9B61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D196E8CA;
	Mon,  7 Jun 2021 13:45:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D14B6E8CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 13:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQHJ6ctat2hFVZRUxgITaFml0MQEnK4s4nLbrD/zPZmo4SEg4JuvEzNUXNvt2GaZ/gfQp1BZRFzCEsT4NXGdtMxHx6MmLx2CQYxjw4DQ4Sj+hnXVLfzzEeznPI25eTtMcJ8haNR1IJ/NOtRrj4dN6ZcMnb9GH8vxq2/+v7doPYctWlEJH5lx53TFQom9wx0e2s09+HFg3Y+KCAtZ+fcwDhCIqkKypkNP27RuBCg0zEcMU8Zzz6r3qtpjegd5iA7ZAJMKYYq4spouTDQzn18MyQ3BJLmNWnMXfelmgAxY780age84eYzhxnTJ3bbvhJB/hsiohm+7VWJoaf6wBoSXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNtl3qBNrG8lS4uFRuwvw/aD1ylrebuZXqrRzHqI28g=;
 b=CRcCWRpYFNEgRjKsfiDwwSvWX483FvS0sSWNhr8SAb18zvLfj2oajfsTYNme1Gy+JCbSa9eGnuq4VdqS854SHNJHQTpXTuDiKRYz7tu8znhCdcrUmwnA7Ml+anxozPL/mkkaphBkeV+L+LQTJ2Iu5ykk7QWSyXDc1SxzgDoIVn7wjmmx8KyAArh6XZGiXN4iYK03igZTB3Y9TY8u6akvtvum2kaSiL8CT5H2NAd9wFlHSjPy907ccaqwQXLCTEdItIZ+/qFhNbntF5VG1o+uH26wHagnTgQtu+iL9m/QEj6O3TQIfNQ2T2T7gWS4Kjz+Vo1lGgF4qmaJoyeQqIs7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNtl3qBNrG8lS4uFRuwvw/aD1ylrebuZXqrRzHqI28g=;
 b=lvTaZ371ADd/72H14yXcC6cvFDpRHxDMh+rBn1yyuyyJa3vOJOMbieW2RbOlC+a9VXa95UNzWNuOmUJ45OhbASpjyPeMbYfByIUn1YELtLC5z4TDJdWHrzWeFCo6Tu+/RVB9T4wcSY1caz/+oZ3l8Db/X/g7ZBKd+Wfgme8f9M8=
Received: from BN6PR18CA0021.namprd18.prod.outlook.com (2603:10b6:404:121::31)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Mon, 7 Jun
 2021 13:45:14 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::9a) by BN6PR18CA0021.outlook.office365.com
 (2603:10b6:404:121::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Mon, 7 Jun 2021 13:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 13:45:13 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 08:45:13 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 1/9] drm/amd/pm: Add u64 throttler status field to
 gpu_metrics
Date: Mon, 7 Jun 2021 09:44:31 -0400
Message-ID: <20210607134439.28542-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37a9cc62-f006-4b48-ca65-08d929ba7a2b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53685382A7506A81F030A4AD8A389@BN9PR12MB5368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9A0LUggQNQaRWquxQHa/XB5+Hc4pONRo399zTbFU23PMYgxAs75kWOKr3Oa+Hy8oov/oZLtFrruLOCHwUgfN9NxUXHeKs0HPPOwyg9ha61dX8yNQdb8uId8fwjcYIeH4l4lF2bV8WlawaCq51gPT9uz2TWOR3PcybVctIz7rJUp+RkIngu96BnEn+dm0p2rjBLcTHdubuifkox/AwVf/SrbLgdxVh/2eJzzVgPvbRaYg6z8HxsWwDrWpUrlVUAfcHc5T/1UOXy6L+KMSFDJ8wJMrqTuQfamkeU4AWPDlkI3fzwB//01gIkJfZfjEPVmMDxKeRTmCzJmopICEG/cN9ehLRrjyeHEJc154jG/QW9e/54d/SRiY/Gy9ZIQ2azBk58ApJdr6XrwFj6PtqFahZo3VxJloml8rEytxSNjAdpGFvTeI0AyaD80eAeWanq0hlo2TO+C2vsw3gyjWvaZUoYFDEYoDvcToLWLZasBvJvIfxN18sQit3XIuNekfqtDp/a4aIP5w72jXrb5OtddmH+YXQ/SvF684Ly0wg4hDU2Dy7lzUy6fzdgxQ8rUedrOURysslFh7GUvadLJ+DWTmFOux+jwVCqnAxXswKOMzyR0jC5a4I4RJ+bu3BmmVSOEVOL/S9i128lhc7DWydYokZn2FblAVvC6eFjgXoW9iA4GlumI5nS7pFqpswEw4HCP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(81166007)(7696005)(8676002)(82310400003)(83380400001)(1076003)(70206006)(2906002)(8936002)(356005)(70586007)(426003)(26005)(5660300002)(336012)(2616005)(36756003)(498600001)(47076005)(86362001)(36860700001)(4326008)(186003)(54906003)(16526019)(6916009)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 13:45:13.9542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a9cc62-f006-4b48-ca65-08d929ba7a2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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
Cc: Harish.Kasiviswanathan@amd.com, Graham
 Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set adds support for a new ASIC independant u64 throttler
status field (indep_throttle_status). Piggybacks off the
gpu_metrics_v1_3 bump and similarly bumps  gpu_metrics_v2 version (to
v2_2) to add field.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 58 ++++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 7bc7492f37b9..271018ce739b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -579,7 +579,7 @@ struct gpu_metrics_v1_3 {
 	uint16_t			current_vclk1;
 	uint16_t			current_dclk1;
 
-	/* Throttle status */
+	/* Throttle status (ASIC dependent) */
 	uint32_t			throttle_status;
 
 	/* Fans */
@@ -605,6 +605,9 @@ struct gpu_metrics_v1_3 {
 	uint16_t			voltage_mem;
 
 	uint16_t			padding1;
+
+	/* Throttle status (ASIC independent) */
+	uint64_t			indep_throttle_status;
 };
 
 /*
@@ -711,4 +714,57 @@ struct gpu_metrics_v2_1 {
 	uint16_t			padding[3];
 };
 
+struct gpu_metrics_v2_2 {
+	struct metrics_table_header	common_header;
+
+	/* Temperature */
+	uint16_t			temperature_gfx; // gfx temperature on APUs
+	uint16_t			temperature_soc; // soc temperature on APUs
+	uint16_t			temperature_core[8]; // CPU core temperature on APUs
+	uint16_t			temperature_l3[2];
+
+	/* Utilization */
+	uint16_t			average_gfx_activity;
+	uint16_t			average_mm_activity; // UVD or VCN
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
+
+	/* Power/Energy */
+	uint16_t			average_socket_power; // dGPU + APU power on A + A platform
+	uint16_t			average_cpu_power;
+	uint16_t			average_soc_power;
+	uint16_t			average_gfx_power;
+	uint16_t			average_core_power[8]; // CPU core power on APUs
+
+	/* Average clocks */
+	uint16_t			average_gfxclk_frequency;
+	uint16_t			average_socclk_frequency;
+	uint16_t			average_uclk_frequency;
+	uint16_t			average_fclk_frequency;
+	uint16_t			average_vclk_frequency;
+	uint16_t			average_dclk_frequency;
+
+	/* Current clocks */
+	uint16_t			current_gfxclk;
+	uint16_t			current_socclk;
+	uint16_t			current_uclk;
+	uint16_t			current_fclk;
+	uint16_t			current_vclk;
+	uint16_t			current_dclk;
+	uint16_t			current_coreclk[8]; // CPU core clocks
+	uint16_t			current_l3clk[2];
+
+	/* Throttle status (ASIC dependent) */
+	uint32_t			throttle_status;
+
+	/* Fans */
+	uint16_t			fan_pwm;
+
+	uint16_t			padding[3];
+
+	/* Throttle status (ASIC independent) */
+	uint64_t			indep_throttle_status;
+};
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 0ceb7329838c..01645537d9ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -773,6 +773,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(2, 1):
 		structure_size = sizeof(struct gpu_metrics_v2_1);
 		break;
+	case METRICS_VERSION(2, 2):
+		structure_size = sizeof(struct gpu_metrics_v2_2);
+		break;
 	default:
 		return;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
