Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D11D69113
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 14:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 858A210ECA7;
	Thu, 28 Nov 2024 14:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ZP+pqQl";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 303B810ECA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 14:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMjX+468mmZvn5rsFuF7GhjMjzXWPDsS5NpUERwatgvdl6cs3MzkZgG7yElJn8MKsyZHHF4SHtEq6qM4aQb8RAcJiueTls8VZvDi+FBaBJxoxFvO2gv1Bn/KnhATarOrf5T0+XdQOhHVcrahZnrfDZ0Mjc2MzY2e4qkgdExdnE8hxKS7xYd+77PkZVMCaOHdPXC9mH30PMnKfgR5TIFOmUIf5BjimwUqby0j+R0nzkAqdxHEPtRnejBlJmNbJMj8IzpUklk77OF9w43NPHkgsUpNM05KVqsIyVlqwZXtlBUCdR0rvw7eqdvVcL+iQmrgglj/cn8vv0mq5eZmLkUZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wauOmxQqFcHu/e5xSNdqW2Wivf8fUxcB3iONi92eLAg=;
 b=LKcw1hGUFwmzVluenvOg7bQsa3Gq6IKLwSZzFnl2wUdWl/r6r7lnLbbbuNHvchppspIKHDnNgvMSPNb5EcHbx5vFwzaNrSRfuMtOb5Buz2NfjjjEcR970XHWY6hcxLQC+iBbhS8gKZuAqa/0YHzs7WRmL3w9y7KBR5IpjcOWlQuNuJPgVy1LTHgOQ1e05jfL+19BNelztZL9sikokVnCxCEjfO8q9TNWX5B23wokB3Utg8NhlFwAGq9j8vlIwnGd4/AGkYvLXDs6s+8dG1V7AiwMBGQsgajtDEAXGkMEKZA/tOhYMilZiMea+/SO8np2iQI2Kvo6XtmV7PFYHPk1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wauOmxQqFcHu/e5xSNdqW2Wivf8fUxcB3iONi92eLAg=;
 b=4ZP+pqQllS2tFUKNLNlb6ROtRWGjJpo4uzRM4i5K1HbYq6kR0IXBHlQxCiQ1LMGtMJmiYTZDbjhcD+V0+rgK3K6513ygqn/y1/yfid7fAoJ2nXKJHr4aRDj50Do19mqUDsps2uRlp+ggOyWDm8iChMXjj7rB52MnphsXxXL97EU=
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 28 Nov
 2024 14:30:22 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::c9) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Thu,
 28 Nov 2024 14:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.0 via Frontend Transport; Thu, 28 Nov 2024 14:30:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:19 -0600
Received: from jzuo-linux.phub.net.cable.rogers.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Nov 2024 08:30:18 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>
Subject: [PATCH 4/9] drm/amd/display: Don't allow IPS2 in D0 for RCG Dynamic
Date: Thu, 28 Nov 2024 09:26:26 -0500
Message-ID: <20241128142958.28370-5-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128142958.28370-1-Jerry.Zuo@amd.com>
References: <20241128142958.28370-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc2d8b0-e33b-4e6d-a784-08dd0fb93091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DR4wv/QDzgsX2VZJI9hVNx0SoOzzM7yKZAfZ5Gqpz8nU+VJogVEgXLKSWjfL?=
 =?us-ascii?Q?aW7dj/9j5GbJgodeKTfKaNhiC/9Hta3lFtr5LFJ7pNaRfnGFV5GZvEs2BWzC?=
 =?us-ascii?Q?uhMMzFBXyeUSVsl9ZdEkE/4ANZzgQ+RxBL2TMVk593MJ3dz7IG6oQK8bJGjk?=
 =?us-ascii?Q?INWOht+g6JFNHHv5UBfDtx7pxHGVbTE6VpGHTZgbiQrjGMC/wSt58G7WEZ//?=
 =?us-ascii?Q?zltojv13vpRnO0g8zUv8simrTmviVehSOCTqvgZNxwUcJ6PsDh73VakzZpTt?=
 =?us-ascii?Q?VMDOgsWz6V8DXWqm2Nna9qMvWAuQfk5Avv+VtJubHTbzNHJcdjfzL78axuiE?=
 =?us-ascii?Q?2ojzNvbvmUfaGuGt2/lkiFmvAm98p1iTPJTgNJv+m2NScM63qeqm2a+f156O?=
 =?us-ascii?Q?e1oz86wxh5TWM45gFV8K0ownnGjtIqKGP1EfKCEGkIg1Va38V34BbgIC5bqm?=
 =?us-ascii?Q?36f3qrghHzd24mIeM8rS0V8w9FpHiE59bnU5MdKCmBDEs2yxKeEK4k15UfvU?=
 =?us-ascii?Q?zHD4LX43JMYdlq6nLkm3Rjp7t8cQWuDawrmPS7uEgaAgXZqPkTQMU/flx3KT?=
 =?us-ascii?Q?kw2Ne+MkbZVMFaQJF7LCH7WMcSKqUDFYJEVEldD8BjnrFlXWaem4UskINCp4?=
 =?us-ascii?Q?NKsoTVrTpj0W1M2kV6xqxq3d/oStw3Fy+LGAkEFUcnFgCq+AZlK47J44VDAP?=
 =?us-ascii?Q?+/Nr2qWrVDtyeG1K40XIs67HFhU/AwsAv9LTpQqU6xdN5gdUAu1HRLrWoWBe?=
 =?us-ascii?Q?k9WNSXmFvpnXmc+KGqzdnTtCmpp6GOe3tInzzEIu+cuoepJm4C8nhfnH/3q3?=
 =?us-ascii?Q?+JHyHxAWwW9G3CwahB5Jz37a+PYoyUeGcGPukCacscDKcdynu+ZQXPF1/i61?=
 =?us-ascii?Q?mFic8R1IqTak9vDH+MvJyaX9uU0kk/T5cmXDKCO66MHotBR2+XubNmv2KnRp?=
 =?us-ascii?Q?7ZtS0fcS7i654lQl6281C8EIVV65DDbVAsb73Z/yfXaa9xLM3DMth1nCCohY?=
 =?us-ascii?Q?a5J4OB8WqwO5Qct/yTcCTo9fHyBzuz+s/WKNlf3V+9MrjcV992ML9DX4O7L3?=
 =?us-ascii?Q?bFEhbOM/LXjnaht2Wg/l9UkbEAoT8sNye17GjMyj1xD+HoD4NtsJ+6OVfeLw?=
 =?us-ascii?Q?MQT4NqD9BdA9zAuOBUipihanoULSTJWPLXRzKZLJOlNPJtY28/qJZJ1cwePd?=
 =?us-ascii?Q?1TCJV/cu60dh1YP/AwNwjUhKctVuKbu9fkfy23LNWcPml2bZRL0gHVkyrmTw?=
 =?us-ascii?Q?5hNxoUUJTtW3ATgT3h4EH6oHwqvC4x/ge33dzZ6p7yHcFB771B+KZSIAM582?=
 =?us-ascii?Q?wgJayy57KLUm0Gq9TanMLhJgGYKzzzRRAK62VWOERS2uxn57FY8bHRs1wkDY?=
 =?us-ascii?Q?NFCKoMC+1lEHGljBbPjLbis57FXXq1PzYkAl6Q5TZw/Bv5NzB3NJL331gyrt?=
 =?us-ascii?Q?rIfzIx5Ie2qVDJ5AgpFnUxjzPlQWNcQa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:30:21.2978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc2d8b0-e33b-4e6d-a784-08dd0fb93091
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The existing changes to the DPMS off flag should help reduce
accidental entry, but this change further restricts the entry condition.

[How]
Record last power state as sent to DMUB.
Don't send IPS2 allow if it's D0.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 775c58637f46..2c3672c41163 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1313,7 +1313,8 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 			new_signals.bits.allow_ips2 = 1;
 		} else if (dc->config.disable_ips == DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF) {
 			/* TODO: Move this logic out to hwseq */
-			if (count_active_streams(dc) == 0) {
+			if (dc_dmub_srv->last_power_state == DC_ACPI_CM_POWER_STATE_D3 &&
+			    count_active_streams(dc) == 0) {
 				/* IPS2 - Display off */
 				new_signals.bits.allow_pg = 1;
 				new_signals.bits.allow_ips1 = 1;
@@ -1517,6 +1518,8 @@ void dc_dmub_srv_notify_fw_dc_power_state(struct dc_dmub_srv *dc_dmub_srv,
 	}
 
 	dc_wake_and_execute_dmub_cmd(dc_dmub_srv->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	dc_dmub_srv->last_power_state = power_state;
 }
 
 bool dc_dmub_srv_should_detect(struct dc_dmub_srv *dc_dmub_srv)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 10b48198b7a6..4763e652c9c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -56,6 +56,7 @@ struct dc_dmub_srv {
 	union dmub_shared_state_ips_driver_signals driver_signals;
 	bool idle_allowed;
 	bool needs_idle_wake;
+	enum dc_acpi_cm_power_state last_power_state;
 };
 
 void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
-- 
2.43.0

