Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18902C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 602CA10EAFE;
	Fri, 14 Jan 2022 01:38:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A12710EAFE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUk5UwMKGPZHmto0IQtPMK2GEFHunoyI1WrmhKo3XOOZBK1cnxI7ZebetTP4VuKO28WXnZDtSTZoHUVLpr0WdJgiqXVLZjNN4TLLYm+yl4jBF80uZwGYcVgKi+XKQTwJXcbkTRryWC2FQ/MjKkEClrCrQO3DBGjb3k5yqSqgEVoVV+MO+a4xaxPR8TXxr33mYo80nRe6etBBZo9C4uGTJVdTw+SKYTtj6fOX2zPpXKUme1kHqbK0PMenZ/DrVHJUGujMoh8EmYxq8Dc2PM5rZgeBiWY350mfwEhw3uBRE/nd8qZXCa9SB2U8gaAzsOhssNnWY6reC0V1TbmtBxLxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boMHZAA3yD6yb1JPRvakRSrCj0geA3z2vI+iApeIZSM=;
 b=aXq2ggTnAiEko5ukPIgHgJ3vZmUUC83id4vlS+KfZ+agl9ByhlITNh74/UM9IlaEM+cP8I0HB4cRkNPNjdpI3jlYyn59e3ZVjdOz4X5zsybaZAx/ztffhddbrRwfLATQ6E/eauhCgr3aABuWBrnznDX8jhQ4kJJ902eullm64HEFL6rWVVVByYD/XNHgU4PKfjsZVYiNTEgO7BNcDWTPziGiou9nkoIISW2jcluFYQFVcUOpM5RjvEMNWAy1Q5LC5yQL/0brSOnyV3DxpvfyeA2aiXk+eUO5Y0JXs339hDBgvLbUlsO+UJivusrBe6tT08nBXrI+p1ogMhQqgdx7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boMHZAA3yD6yb1JPRvakRSrCj0geA3z2vI+iApeIZSM=;
 b=eOMvQUQ6R8Fi9/3rVMaMsMyjtTngUQ4gFBcq6WzWq4vXILcRrFjhwk5BZpAA9AF2lDDAzKgCjvRYmvp31W/Gnf7dYumlgD4E3TxoqsTAT6GQ2NiDI9Om5ejnwfTi/65K8wJ3TCZ72Y2J7+jngignCDf+np6BfBascTI/0GKCZ5I=
Received: from BN9PR03CA0549.namprd03.prod.outlook.com (2603:10b6:408:138::14)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 01:38:00 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::c8) by BN9PR03CA0549.outlook.office365.com
 (2603:10b6:408:138::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Fri, 14 Jan 2022 01:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:38:00 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:59 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 17:37:59 -0800
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:37:54 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amd/display: Fix black screen issue on memory clock
 switch en
Date: Fri, 14 Jan 2022 09:36:53 +0800
Message-ID: <20220114013657.3119627-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbd05607-7043-4aab-f633-08d9d6fe7fb2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4465:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB44654A2314341BE8FE54515DFC549@DM6PR12MB4465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6foPdT/uSLEL76uEy+psNoENSB1RRheA1rF/g0MKKENY1MCq7WUbddOioRpuACUrHEa3T61hP5xSX4orHgbWS9odfmJo3FBWBMCjXhNqf4c7XgNiVRX3oclPaJz8pENoTPslVIG9SavNwsjYjUtKkJY2vXSE/fpNhQD9zoB5I7wfg8b7nA4Qu6U6Ltv0K2ELDH9SaHTvbqbs2zXnAAZ3x116s4p+CljJwxXQbxJN46onncL0scPG18VFr2z5Wr3ZYOOzwtNmRPWxN29tRfAUdDVWMOLTyvFFt3+AwAOxRe7VG8oPXXmv95D+DHOfPWa1nReJvDV9csxWX0P+vA0F/YqqHEy1kQBZalb6zVzIk2VD213ASPfSlQxJ1DVH+/cANtPZMsyouvy8Ye7SqXwydVTW3bJrFFoRmEM1coJUQ4yF0PfBaNQxgN+J2/D6sfeCmsZDGu/62oEz7Z+cXOZwI7sgclGLP7E94db5A/ezdWFoxizBhJj4ITM5SdONyfTaI5L3tZDRLIXU2Dt6HfIvKpzt51fxpuTZA0lo2zD3oIlF1ylS/5H7zG9WZ9X16O1tbG5gSmAufQky8v3Qgr+SoGud7NNxCcgd2FWKiHuYJmAjuBqlqHkmRimOhm93weNfRUK9TZUUrut/NCgiToIMWnWoK+VbHiFkO+JHSAm8f9s/rPD3EPIgZ31zXlgeENKkel6v8eucNrAFtF581dStJUHXWoya68uls3eoJWjWKGvVWcxUa+q5zzIQn9MQmU1qXvoahex5XVS348BTvGNAmVQcao3GJnYHE17oODNUOGk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(1076003)(8936002)(70206006)(356005)(4326008)(83380400001)(316002)(7696005)(47076005)(70586007)(336012)(426003)(86362001)(36860700001)(508600001)(6916009)(26005)(40460700001)(81166007)(82310400004)(2906002)(54906003)(186003)(5660300002)(2616005)(36756003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:38:00.1326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd05607-7043-4aab-f633-08d9d6fe7fb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Felipe Clark <felclark@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Felipe Clark <feclark@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Felipe Clark <felclark@amd.com>

[WHY]
With some monitors when multi plane overlay is enabled the memory
clock switching mechanism has to change and, due to an error in the
initialization sequence, it may cause a black screen.

[HOW]
Change the firmware assisted memory clock switch initialization and
tear-down sequence utilizing the prepare_bandwidth and
optimize_bandwidth contexts.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Felipe Clark <feclark@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c  | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index ed0a0e5fd805..dec8604a0612 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -355,6 +355,11 @@ void dcn30_prepare_bandwidth(struct dc *dc,
  	dcn20_prepare_bandwidth(dc, context);
 }
 
+void dcn30_optimize_bandwidth(struct dc *dc, struct dc_state *context)
+{
+	dcn20_optimize_bandwidth(dc, context);
+}
+
 void dcn30_disable_writeback(
 		struct dc *dc,
 		unsigned int dwb_pipe_inst)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index 73e7b690e82c..357ee14711ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -50,6 +50,9 @@ void dcn30_disable_writeback(
 void dcn30_prepare_bandwidth(struct dc *dc,
  	struct dc_state *context);
 
+void dcn30_optimize_bandwidth(struct dc *dc,
+	struct dc_state *context);
+
 bool dcn30_mmhubbub_warmup(
 	struct dc *dc,
 	unsigned int num_dwb,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index bb347319de83..73a416cba563 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -60,7 +60,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
-	.optimize_bandwidth = dcn20_optimize_bandwidth,
+	.optimize_bandwidth = dcn30_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-- 
2.25.1

