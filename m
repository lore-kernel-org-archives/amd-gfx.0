Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD245C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6082E10E6F3;
	Wed, 13 Dec 2023 06:14:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1820110E6F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtT962GfsT/m9dmQ8Ic9QbzQuxnEFomx5WS3o9nfqID+PZriZe2zv0lim+9SsD9whmDTzUOPmSGApoZccfyviua5KUPee0PaYXVkwso54yhhFmxvdfoOIDU39KLaZ6T6P1+k2XDLV2RFQz8NuOMrlbKuaR0Xv7k+9vUio4jNo/Ls6Ts5vlBQmKHuWnOri6hbEFADXZ8oAi2jSOeRd8Zs0zG9F2r/efS/l6VwqQakS5RxdFODea/rm1I61ShA6ZU7dDvjVOIgkOCavFSUqypupAYacmzIGZfvX8DadWt4r/1USNjnoJxNB4tY8EiWmXl0FIYeEY6DQ03P4NwvR4jPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wME9Yb77jUbJAsGnvinTVGU15iqUk9M5m5Q2vKBJ+78=;
 b=obDgNkZqBMIvSiWl1mxRncVAJ2CqCaMXHJDHs9MYuT52PGCyaKgbSWZ0+b6Mo+lN98HKO51Cs2R513wC+8cRh8joPVRhk2nqugNnm66Ku6EncgknrMYEKVjv1pjAy/qdYnR3J4z3lmh0SBWje8cAE4DFEHOaV3uqaySI9I0FJ0RTlTJgjRNE/MWi9I7QUW1KlPYz/36mCviMEURU04G2gPfNxXhaBHxQb391g/upyXlCvEmpcv15/EiomPpJIUF7BCj4CWjSF9sREfEviTV7enk1OcmaOn/rL3E3aqogAG+B/+1hEVyNoNYQZ2HaYgsyvB25urr6vs6qVAbAbXBKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wME9Yb77jUbJAsGnvinTVGU15iqUk9M5m5Q2vKBJ+78=;
 b=HWkVuEELRoyyowy/yCuOL9FTpeStNg1JKycbcZC3lHVlJk0leg9UaWs3HAWDcerxP2qW6AyA//zgoWvXrY7jCkpAYrY8vQaG6jiH8kJ2XEaTf+mLNzRcKt9eecM/H5eSgg/1yEHc7CLbvwUXuGkpJv0zd2sXJzWcM6z+ciHepN0=
Received: from MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Wed, 13 Dec 2023 06:13:59 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::40) by MW2PR16CA0009.outlook.office365.com
 (2603:10b6:907::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Wed, 13 Dec 2023 06:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.7 via Frontend Transport; Wed, 13 Dec 2023 06:13:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:58 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:13:53 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/25] drm/amd/display: Set test_pattern_changed update flag
 on pipe enable
Date: Wed, 13 Dec 2023 14:12:13 +0800
Message-ID: <20231213061227.1750663-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM6PR12MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: e18be1b2-2840-4c71-52ba-08dbfba2b21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZD2bUmY7SsTuu65SuuEe2USN+GS361AvDAbBt7cjCyiczmFRfJ8xlX0uPlg/+aLqDJ45UHUDDXPjpJxeq7ytDlcxDBAlVAwm4orrS1Q0HeIY+DmHxdq0wLotfWIk4EJDg5oeWmWObZb/1O21R8JdbjelzEwoVrrFI7f1bkk8qGRUcbIMRmI5rRnSEQUOCPdCREyFpNHQCxeuSxng3WMqe4PaPUU28hhqbf9OvKKaLdfxEnlwV31B5yMUrOLdILr0j+rzmdIQUQIJ4iA2b0E1zrGhIfJHlsVzEE2moPyPzl9sC8HKvExJok2fJxJwaA9766q9qRLKSvi/EzpwfY9Qv7iCClQqqAP+bU0BJ/gD4A3FjImyaQ2D7SyxKFWBEyPJmtLbTKLNzfW9bctNsZZT8ONit5C1+4wfpcS6LNLoJgAHeHiQxsLOyw4+keHDmiu8n2EgtElB1po8BblwJhgfPxjFpwCftsmmVR7fLKeqdDswXBa8842IRT3u4No1m2zJKsmSm5+IT7jIdVDf2r9WdsYUAvUf77USE/C2PxKG6ZVINAoTn8a3QBZIWGRJuWsNxLePLA0uGocUTM4f8PWcxnZRdLBh85ABVi4vms/EOk+CQ7+hNK8KKzPl1AvQNghi6+T19BCe+l8UCIeGvaZkrHCB1Zt196kXPQXUCjXPcFnbsh/EqIJnkLPa/W2/hIJO5j+U4MG3Kn8myP6d1E4is12pMGDK3WCYKxCIC6jR00pmtPqf/ZrOGJurvfq7lbbRi9MtY+WTcBNLYZ3qHYIqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(70586007)(70206006)(6916009)(54906003)(82740400003)(81166007)(356005)(36756003)(86362001)(36860700001)(47076005)(83380400001)(426003)(336012)(2616005)(1076003)(7696005)(15650500001)(2906002)(6666004)(316002)(26005)(478600001)(4326008)(5660300002)(8936002)(8676002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:13:59.2878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18be1b2-2840-4c71-52ba-08dbfba2b21d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
In certain cases, ODM pipe split can occur while stream already has test
pattern enabled. The new pipe used in the ODM combine config must be
configured to output the test pattern in this case.

[How]
If the stream is configured to output test pattern, then set the
test_pattern_changed update flag for the new pipe when it gets enabled.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 5bb5e2960276..2c8eff815ec1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1400,6 +1400,10 @@ static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx
 		new_pipe->update_flags.bits.scaler = 1;
 		new_pipe->update_flags.bits.viewport = 1;
 		new_pipe->update_flags.bits.det_size = 1;
+		if (new_pipe->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE &&
+				new_pipe->stream_res.test_pattern_params.width != 0 &&
+				new_pipe->stream_res.test_pattern_params.height != 0)
+			new_pipe->update_flags.bits.test_pattern_changed = 1;
 		if (!new_pipe->top_pipe && !new_pipe->prev_odm_pipe) {
 			new_pipe->update_flags.bits.odm = 1;
 			new_pipe->update_flags.bits.global_sync = 1;
-- 
2.37.3

