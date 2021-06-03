Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D9C47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE84561208
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE84561208
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577926F49F;
	Thu,  3 Jun 2021 15:17:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B616F49F
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBkSfs6OuJNj3sQes4iNXpviCMn4zqzfhs6ziulhIRYrW5geNH2WBCviUxlbYmDiT2Qm6w9zpvl9Uu2Sba80FSDYegV4LmlnPyjM8z/9GqEK4IJRABhDsiRiWWDB7Ue+3WeK1B92yDhXgEWKyRzg7ggHSTjO4vHqKqqPiWqdSspZZFaG5Uu5nWL2g8f8kRNeQuHM+36EcOpgvWk+dLjUWeLzHeEFwKl+neJlZz7eXy8QUqK5eY0hEsAPy+DHeU35UVNZPGQWLv5OeKRRlCygF89Xds4sWi6hLf9Xv52d9mU1yoE7j8demeaD3th0BfBIw1zm6+skaae9d/r2S1FY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNtl3qBNrG8lS4uFRuwvw/aD1ylrebuZXqrRzHqI28g=;
 b=M8Jpia9nKeqoqVpgWdbGxUutFFuyDXGGlY6P9degGH8Q+5YSQIThA2XPv/Ykadh9w5yvVIuMH332SAl3bQspoledn63qG05dKffNcpzGALk+rjz1+jkUzEn4Gr7f9FrZlJE3y68iEjI6+/+Iz+AIbJM9FQp1WQLQgC3vq5kgCmQyc7pQlk3moh3oWNZF+9INDkXjzQUFJtgYi/IoVwm3vzF1wOTh3abDNcNlHkkzrxsMsRyh1K0aLxY1NjupkK9gzRtRm0Dco9YHT1ZvSMAT3819EP9hfopi9X1WorLI1BYrTLY5zyIrSSfVGnXcd0sbEut/UtGS/dl4GAmwFLa/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNtl3qBNrG8lS4uFRuwvw/aD1ylrebuZXqrRzHqI28g=;
 b=cQ/+ltHk/RgO35o1p2VsGt14rPFPXoQxDhMVT2t/d3r1VMtwZPkeun5U2tkeXjWtYMHEw7uc6evz3XQZvAYtoWxxP0Bc9hPa7yxfmgMG6wMIyOh+7SThXWuWvnDkelrqkFKZdgw0BPgwqlVilgbVxYiqr35POIP/YAKfffiTzX0=
Received: from DM5PR2201CA0009.namprd22.prod.outlook.com (2603:10b6:4:14::19)
 by BY5PR12MB5511.namprd12.prod.outlook.com (2603:10b6:a03:1d8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Thu, 3 Jun
 2021 15:17:36 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::98) by DM5PR2201CA0009.outlook.office365.com
 (2603:10b6:4:14::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Thu, 3 Jun 2021 15:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 15:17:35 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 10:17:31 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/9] drm/amd/pm: Add u64 throttler status field to
 gpu_metrics
Date: Thu, 3 Jun 2021 11:16:34 -0400
Message-ID: <20210603151642.14014-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8e2307a-9d3f-4714-f84b-08d926a2b7b9
X-MS-TrafficTypeDiagnostic: BY5PR12MB5511:
X-Microsoft-Antispam-PRVS: <BY5PR12MB551139706382C120B4F14A838A3C9@BY5PR12MB5511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKHJZBOXxgroMCGUaAR6J7RoWAaXfwnzbLH5QjIcRYoJqDNU0P1CqKdL1aTx7LSiSXc2sHKFJjnooaKXbdEKUpuozODlElTkVHsxHMtpn0cPs8gKYlSLClmg+RYVQ+oFv6xRy0cM9qNwwN30H3TnyiSpiV2pqunZTHhGGHyFdC90AEWtn5ue+CIcBK0HUorqEfD++WMPeXAjLIk9AFTFci3UEFs6kHrlcERdWpfL5BTdw0uBVOlCvrOpSPIO1EXQRPJKSSNa/sFLtFLMZqjMxXKDbl8nmlJmzM/1wVtXP6FKZyIi5uUWKvOx1iyF5n2zLGwJNSy6QWJpyUOYds+VZdBiDbbNzVqc6RitjY5gwZ1P7+L8co48i9AKydJorEjqbner3tm5u2pMB32i4LnOiDrr33cdJLxEzKymM16BWfv8WsczD5B68n4zHhW1VfdaPPEGmBqpRY/Fo7JO1/sVlFSLCry2Ple1WG+VKH0Qmk1OyqPSH9AZkp11fjCUgRGts2SLt4uXLwJhkjgFDyqIVb0x3YGF+BKwZ9IL8bLwc21YVRGQAWNBSbf32/ykpX2NnMnHkE5QfuBLdxLGGUGzgLCo7SsQ1H9fnhtpDkJ3SkRUwO+85Ny1cs0kn+6XvDTNUOWImqS8PB3CFfeyOwmLGN1zhJOu01Rq+Ph99NP73HwCX3JA4yrXKfkSNsCs0ErE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39840400004)(136003)(396003)(346002)(46966006)(36840700001)(186003)(6916009)(16526019)(7696005)(336012)(26005)(356005)(81166007)(4326008)(426003)(86362001)(316002)(47076005)(8676002)(36756003)(8936002)(54906003)(83380400001)(478600001)(36860700001)(82310400003)(5660300002)(70206006)(70586007)(2906002)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 15:17:35.7572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e2307a-9d3f-4714-f84b-08d926a2b7b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5511
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
