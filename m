Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A56C636D3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 17:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF3E510E9B9;
	Mon,  6 Feb 2023 17:05:31 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8219610E9DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 17:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIuEt/oFqBINW10TGgwEmGgSbAifvWl4e2S4ZepMfr/T7WjONHrEytahUKqBsP7aJQAH+xTCfZPKeKgCSZwp22POdxYEttx3I+Bn0RZ0O7C5mV94vP3apZSFwIhzVMgxSrWmyM/QV+EfagOG0/OH4QvehzLl5QtG0YHpvhNGg7GKnk/f7D7fa5CYyLFtX+ENgXcFz5LOaO3XKlDC15xBqiSe0ELJRZ9IkrJc4XvgesE/Mh21twLeWhko/tbdpHFRcJisi8qI2oqfKqz17LVR47QtuUyYkVS2ph7wDDPxY+kMYq4+CfZyxrCFL3wSBpvs3eWdjgqbw+mnrVXQ9qCmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWlpAq9L3Z4OQ2DLpiLDp/cQNeySpsTv1sOWCXN41aE=;
 b=mlzzmHk+w1hp/vOsh0SlLnaArE93F8boC5yHZnjKQk5+xPpUEBK9Fb+G8HeF2nTflv7aKGcX12AuV/IQ+kAkmE7P+DsjCltI4AKHM39xihsSvyhGN2zZal/2SLB7ZsYzQagnOmicAtuEeEAhkJFZRv2/kIqiExbY9Aj2lh/JMmkrQqYhpxhtJNmmB+ANiWPm5v/WOlx8eBounbSsXTJvf87OtjuKaKgH7QWPX+jqwS6s3OCAlSXv5VGTJsPiadbw4KWMSQ1CooD4ddBuw3Z1uQ+zR4urf9Dpokb5V/K8v2kwrLiPgbO2xqUH0CtZpjrBkO6/sN1FzMObUtjHpvDBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWlpAq9L3Z4OQ2DLpiLDp/cQNeySpsTv1sOWCXN41aE=;
 b=V/kAkD/vJ9N8RhaDliXoSSAeiexqYG6pliu9dMKHLRWD2iG3CCQBHMcT3Z2Hh6b8ge2+ZveVv1XiAegXAz/8gD267u6Rfx5d4z/KcMGdADjmQGwXLSwu5kyklfKUNK/joLLEpViNKfSnVsmJjpdVeKEeclF2NtlLwttmzz3vi5w=
Received: from BN0PR04CA0181.namprd04.prod.outlook.com (2603:10b6:408:e9::6)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 17:05:27 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::87) by BN0PR04CA0181.outlook.office365.com
 (2603:10b6:408:e9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Mon, 6 Feb 2023 17:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.34 via Frontend Transport; Mon, 6 Feb 2023 17:05:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 11:05:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm/smu7: move variables to where they are used
Date: Mon, 6 Feb 2023 12:05:02 -0500
Message-ID: <20230206170502.105165-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 5905491e-fad6-4bae-22fb-08db08645826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vw50ZtMxXO0qAJKJEu31zLBgOE1jO1UEv9nBKo/Dr098ml5jR3gSQYTTeFb4NO0yShIn3nBVsineYqwMY8daucgnAhSVxjaaZmsD7xVPtHscgQqX+ELBC9m8ZYXgWHlPiLN+L5c3CJy7bLKotQjVtskO21Wjm64DpREZI1GOHz2lCNOCfOkuZFY+ZC4ZV15+hQYoN/t3U2HwmPYAAbJkjVsh/OSb4sgQerWW5QmgTcbpoRwfsa3f1MNDx5LtmnJhZcyK7hFGB3CoiSIKcIcSnm7iY+5/VRemh4B7Z8TkCbNRn0SRnucLVrgnF9dU9ox4APdT2/B13085JFW5dQuIfJqi/MVhXYEKECaCT3V3geItqcIbayPJ8N+n6mIRZ4BVhQX8TYcflFVGBOiGsUry2QYETJzwH5W3YeyXvm9C1DA/TheZ5kLv6+Mre9iQqX9fK702KxjP2wRinM4NrFOv4lsXd7hq13VHFecF6Z2P9JJJCTjysJs2HYW6mdT6zXz6NRbZKsXfljI6DwLktvZynmnw7LiCC+SOcBG12HgI00GoY6q6oxEMVM1ivoAlkJvSQn+7Wgi67E2dkKMBEN6Gn8VNCGbdKwbAp151RKAAX9nnU80ue+i6S/uWoxEojW7OVsP2Q9HaaxOKE3np2iv5CjSCy4ys/vMYMMSWrAIrA0RXXJVPYqDlnN1rQIZR7cA5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(36756003)(54906003)(478600001)(966005)(7696005)(316002)(2906002)(82740400003)(86362001)(40480700001)(356005)(81166007)(82310400005)(336012)(47076005)(426003)(2616005)(70586007)(6666004)(6916009)(83380400001)(70206006)(8676002)(4326008)(8936002)(41300700001)(5660300002)(26005)(16526019)(186003)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:05:27.1390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5905491e-fad6-4bae-22fb-08db08645826
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move variable declarations to where they are used.  Fixes
a segfault on smu7 V0 structures where some tables don't
exist.

Cc: Evan Quan <evan.quan@amd.com>
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2388
Fixes: 711d3c39503b ("drm/amd/pm: fulfill powerplay peak profiling mode shader/memory clock settings")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 89fc32318d80..e10cc5e7928e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1504,12 +1504,6 @@ static void smu7_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	struct smu7_dpm_table *golden_dpm_table = &data->golden_dpm_table;
-	struct phm_clock_voltage_dependency_table *vddc_dependency_on_sclk =
-			hwmgr->dyn_state.vddc_dependency_on_sclk;
-	struct phm_ppt_v1_information *table_info =
-			(struct phm_ppt_v1_information *)(hwmgr->pptable);
-	struct phm_ppt_v1_clock_voltage_dependency_table *vdd_dep_on_sclk =
-			table_info->vdd_dep_on_sclk;
 	int32_t tmp_sclk, count, percentage;
 
 	if (golden_dpm_table->mclk_table.count == 1) {
@@ -1524,6 +1518,9 @@ static void smu7_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
 	tmp_sclk = hwmgr->pstate_mclk * percentage / 100;
 
 	if (hwmgr->pp_table_version == PP_TABLE_V0) {
+		struct phm_clock_voltage_dependency_table *vddc_dependency_on_sclk =
+			hwmgr->dyn_state.vddc_dependency_on_sclk;
+
 		for (count = vddc_dependency_on_sclk->count - 1; count >= 0; count--) {
 			if (tmp_sclk >= vddc_dependency_on_sclk->entries[count].clk) {
 				hwmgr->pstate_sclk = vddc_dependency_on_sclk->entries[count].clk;
@@ -1536,6 +1533,11 @@ static void smu7_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
 		hwmgr->pstate_sclk_peak =
 			vddc_dependency_on_sclk->entries[vddc_dependency_on_sclk->count - 1].clk;
 	} else if (hwmgr->pp_table_version == PP_TABLE_V1) {
+		struct phm_ppt_v1_information *table_info =
+			(struct phm_ppt_v1_information *)(hwmgr->pptable);
+		struct phm_ppt_v1_clock_voltage_dependency_table *vdd_dep_on_sclk =
+			table_info->vdd_dep_on_sclk;
+
 		for (count = vdd_dep_on_sclk->count - 1; count >= 0; count--) {
 			if (tmp_sclk >= vdd_dep_on_sclk->entries[count].clk) {
 				hwmgr->pstate_sclk = vdd_dep_on_sclk->entries[count].clk;
-- 
2.39.1

