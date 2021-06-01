Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81921C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3354D613D2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3354D613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD146EA95;
	Tue,  1 Jun 2021 18:14:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66ABC6E0F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 18:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9yK9lugfV+xdbKQC22cF/KCi5xlidu3Ae8f4yu3I4ReIT99xU3OJDxsBFpUvzZwxANO70wPgutKJXMmOXWT9y1vXONj8QeFEKpYOct5TCROFDDo1NaGXia8BW8Pk80eI3JGo9FIME+dwseyOKFcfeKv0SKAVmIESCUSBkqLC7zZdxableQIqSYNiCOivelRbq7LE4GB3Wr3c2X561rv3u/M2cSF7MYiyxEPANInFNxDM2TGWbojpSeHH5HXyyY0fjrwJJV47CmXlTqeLMkcUzrwx/fqrD1NKDCgT/5nmhqAer4bol+16dLbWCLMrrtuLVzI6OxDBHBUR6YU01MisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2voXrGbyIS79LHCEtAEgvIIWffXLg6y1Mh5+swtq+k=;
 b=OxaG5Quc7pwXUIFckScYzSGUDxxe7TdXNEE/LKwY5ufc7aUC8mgobvSSlinqJs7uK2sxZ908inb7shffWvrS8kPElQtxdpsN3nAkoTZ3FjL1yLsWR7A2llvhhmK1YP9TwmmhDqY1pcT0QULY78ZTiCjvb4KKsi279HBou4ZL3zCB8BywaxSpE9/3zR4uLlXFVEK/5j4iva0DDNIO9u194ocwnzhjU5kDMZKYJlBiE0YutuU+TROid6gXjbwgcRnUHD2OV+3nVkXdtjrMMkcpcMlQ1kGUa0BOh/dfjcltes2PC81N5NrwnVBIJxvp0K1bmLbap/tqoWXZ9BGHkY63Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2voXrGbyIS79LHCEtAEgvIIWffXLg6y1Mh5+swtq+k=;
 b=MmVWoEnMGqmn+sHYmELWPs2WEKHQC2IbwSpcO2s+eku7rmXi5CDwxP+5dJhQtW8NPM2mXemsGAXXlhtIDVByW34OI8Xlj64ZVNmV3KOfEyM6Jp6ugXsRrVNwHUv8Lxbyaxlic3mxc/60jfIrYFCmsThNLhAWFie9ukT2thtxgJI=
Received: from DM5PR22CA0021.namprd22.prod.outlook.com (2603:10b6:3:101::31)
 by CY4PR12MB1606.namprd12.prod.outlook.com (2603:10b6:910:10::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 18:13:56 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::5e) by DM5PR22CA0021.outlook.office365.com
 (2603:10b6:3:101::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 18:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 18:13:55 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 13:13:53 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/8] drm/amd/pm: Add u64 throttler status field to
 gpu_metrics
Date: Tue, 1 Jun 2021 14:12:24 -0400
Message-ID: <20210601181231.24773-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28720773-048d-484c-8f31-08d92529052b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1606:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1606EF32B737C3361CAF16D78A3E9@CY4PR12MB1606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeV7pKwB6+DityvDRpWhMCrQOBJSAExSx2Uhl5VetC6py33ylori0NKHUxIIKNzzgiC8Dzn6pEtbGqNf4QFZFueW5far3kMY3BqhmkbgZkzMivQj6+V2yAEgxbVE7mYvO/Mna0N6UTPZxyTyAGTtGORSsl4kJ+H39RTM8VUZLy/H7iDxCeL/wmDpPlZh/pgscd3+o9rVg2HtG0Qt9sZ6dC5+0yXXQSSIID0e8QVazagKod0o7JqrdHbKuvqKwLvOVI1mFCtGjMnB5OiMXCmITj7gDXXUu9BBg7bOwXuxw1Xr8tCH151FBlo68dSPhaf75ACczv3fLQ8LHLGst6vCpLEWKSSxsX2QiNdahFind3+YWKR0pwHsbKKieOBQXdI+ez17hRLFCHU9vwZuV4K0igUheL9d66iomz0fpy/LEg7iapVWqubCwl2uDHbtANags1oJdl8ltqYfqiO9tw2+qZ/abKIm5AdoeT141Juy+Rs65ub9knkJRCk89dJNX9lYqipNZqfqCesxRqGK5zp6hV+vkYtMqUQq6I1CMTMJLLRD1JABa3bTKUO6+4rkZUlSSH8gzCgqSyRZ7Z4ilGY8ZaAnwH+M4oKUBuzH6ADPssMc6qbFeOJDq5qsDH407pYAlxpn1yGQstN6FybkyKAEGN3tgEt2vVxCLJZKd9reaPoZvgdxCqVVOr97/uc3H4ag
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(478600001)(8936002)(70206006)(336012)(5660300002)(8676002)(186003)(426003)(36756003)(1076003)(36860700001)(47076005)(2906002)(70586007)(16526019)(86362001)(82310400003)(2616005)(82740400003)(6916009)(6666004)(316002)(54906003)(356005)(26005)(4326008)(83380400001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 18:13:55.7934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28720773-048d-484c-8f31-08d92529052b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1606
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
Cc: Lijo.Lazar@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set adds support for a new ASIC independent u64 throttler
status field (indep_throttle_status). Piggybacks off the
gpu_metrics_v1_3 bump and similarly bumps gpu_metrics_v2 version (to
v2_2) to add field.  Adding this new field allows us to allocate 16
bits to each type of throttler information for more leeway in adding
additional throttler bits in the future.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 58 ++++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index b1cd52a9d684..a6436c331f46 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -577,7 +577,7 @@ struct gpu_metrics_v1_3 {
 	uint16_t			current_vclk1;
 	uint16_t			current_dclk1;
 
-	/* Throttle status */
+	/* Throttle status (ASIC dependent) */
 	uint32_t			throttle_status;
 
 	/* Fans */
@@ -603,6 +603,9 @@ struct gpu_metrics_v1_3 {
 	uint16_t			voltage_mem;
 
 	uint16_t			padding1;
+
+	/* Throttle status (ASIC independent) */
+	uint64_t			indep_throttle_status;
 };
 
 /*
@@ -709,4 +712,57 @@ struct gpu_metrics_v2_1 {
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
