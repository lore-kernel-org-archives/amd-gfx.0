Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52E7C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31786128D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31786128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8376EC08;
	Tue,  8 Jun 2021 15:08:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E466EC04
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 15:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjabFyYRV7JP407URDo242EFcHGklhcSwN5iX77JA1+oV2V1mkewroFJ7SZ2aRdzvk6nD/4+zovzDe2+8lFDusgfGYfr4Ta3L+ZZ+yzENnfMCzSGMAVvD1MXRHdqpMY1XlRhqb/kImT/Xtr0Kpz7++Wx+Zl2aahSY+rx7qP03v51Q8DttcU6rfxbBDeN+E0n9lftNbyz2Cu9v4hXpf2J+jpB3SxcxdUa2dEirIOUDdYrQZVbKGGpPDPkh0Dc3/B5egUjB7dAhSnVRSabJl/SpZUjuYshcllRpZxdy8mkvxmaZtNNt4J7ptiH5bAVQnwVurEXbrFHAgARHdKeaWYocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNtl3qBNrG8lS4uFRuwvw/aD1ylrebuZXqrRzHqI28g=;
 b=fhCv4NWl8+q/k0WnnJO9906b/i7NOo+N8JcSbyC9tapGBvQyrPpsjb8kSb87pcNPgWj3QAm+l0lAoUAmEv79jQdOileW5hn1R88wme30TnyXoRm1Ff0uIt48fdCna/cDrygei1Mp7AKRO1d82yMpydpgT79Cp+QuZzCdq1Zdr3lFctIKMkfQEggCX1a/5FdVK9z0r49tYTj/2lpKnFTsENo0vVQ1mZ6iokmeTK/VhD8qI/IU90lrMNDw8y5L85BRVwjf+LSg+Z1s/f+QTZr66j96P4c57cZm16dnbr6HeGKVCdUyNT9laZAoUZABn5ckiPyT8tchRnZcrNRFkMIVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNtl3qBNrG8lS4uFRuwvw/aD1ylrebuZXqrRzHqI28g=;
 b=xIT2D2dd9xYgNTAhiGyQO628VR4mExqp9BD7uajpcv7nChKxZKQef9Fu/ugGjZoYFrYtPObrnPeb/FjkrfwA2Qm6mi2Xts48eBSfFzNtquRDVVroycuwEgO41sInNuyOtnc9Sn3P66Ua7U2pOWBBGqiuuym0hAWC7fPMw86E8L8=
Received: from DM6PR03CA0084.namprd03.prod.outlook.com (2603:10b6:5:333::17)
 by BYAPR12MB2949.namprd12.prod.outlook.com (2603:10b6:a03:12f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 15:08:25 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::6d) by DM6PR03CA0084.outlook.office365.com
 (2603:10b6:5:333::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 15:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 15:08:24 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 8 Jun 2021
 10:08:23 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 1/9] drm/amd/pm: Add u64 throttler status field to
 gpu_metrics
Date: Tue, 8 Jun 2021 11:08:02 -0400
Message-ID: <20210608150810.9679-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8787e61a-6ab5-4e18-32f2-08d92a8f4362
X-MS-TrafficTypeDiagnostic: BYAPR12MB2949:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29497FB36CB328FAF5F2E9B38A379@BYAPR12MB2949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5agmjZH25AUiXXN7WVNDP4QkVdWchn9txm1IC/e2Y9Bh18R54qKfyq7Lx28jbVYTrnbfEV69xoGlW9B6sTV7rIqjVNYxREz403PgdAwBzfR6Eb4fdvTvvwsQtmPo77+7hK+91BKPivn7O92eZuETg6LFo8mJQasLlbwA2rqK97iJFtTQrLArQgP6Qfp1Rbs7oVD/CPWLxi/WC3ngMYMlUH7ONInEHkF/K88yrDtbl4qmkCRhvfhC0Gl/DxlNrIopqopZJ0aaK0EFKC9WpGeE02fw1RHyt6pwv5VqiNzAfxY3yf7vibPax7ljuKnTyyaHLwbKPmBCqt6mX2Ys3ioLyM3rL9vy2wpj1sW1XOjjT6PtrZ5Ii9nDhL41eVYdzHoY9yuQJm1VDE7j9T8sDZ2gb/YL6q5q9eaXt9v/SyLT0borgEjV3zEUe9BuQXVil+hIazMf5o21lACsOxfFfYCXEpXClvmYTvrmsskqEcL1Q20zF+oEUc0h6nxeKN3xJpPXRSkRfMQXn5XZKdJCoI4QBu7Th7Yc0tyvG4qxwkfg1YuxLyA85fI+gdFizwRS9pJ/XIcCxCyzo38NjnXo+L0RCAMLJSRg2LhRRpfzDjwUGiehwGGpJBAKvL2LkOVTn3quWEUhSXPLkP4WqKUFvPc6WYvcr8MLMVrAnWo7jAmQ1upiu7NUf9PLauGnORF9wisA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(36840700001)(46966006)(5660300002)(70206006)(2906002)(36860700001)(7696005)(70586007)(1076003)(8936002)(82740400003)(36756003)(8676002)(16526019)(54906003)(186003)(6916009)(47076005)(82310400003)(426003)(81166007)(6666004)(356005)(86362001)(316002)(478600001)(336012)(26005)(4326008)(83380400001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:08:24.7485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8787e61a-6ab5-4e18-32f2-08d92a8f4362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2949
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
gpu_metrics_v1_3 bump and similarly bumps gpu_metrics_v2 version (to
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
