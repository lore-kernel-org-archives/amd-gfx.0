Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B971C77B73
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 10:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA6410E29B;
	Mon, 22 May 2023 10:10:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829F210E29B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 10:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+9Eby3EQpEw0TlKVcZh/XRUGT9PL9H51Y2jww7aa36uZZgkwRisOh+PTRDGeuQX8S/j9nvKQ436xlIcrueAx6E3E4jlSIUPa+EQA8wWh0Qrv07EUVjTTsMbfL42G+dNIS9QLcFTk4cx5FP8QdJpQCdkw/I2bUGEBy4Y0gW8VZZFKHuoE/LvGz+A7fgguKDJoqi68W5tlEMRLQ/Vm9AJka0pFU2HA+SrqDgzIDLDTVPmN4jUNcpxWFVeZzqGkZwU5HEdcxS+LOSjqHxcwIMB78UxgskYscranBlAfXUzLB2woxNZetQcHpyQYTHfCAjEQK1N28RFV86GWb1YJ1cBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD46MR9e52B8hHO/fdAWp/HUfOoJ1bIjE5Ac/DcEvNc=;
 b=baWqO/p2xD572NnNubzx5Jp3K1Kal+6rpH8+BSQglHuamAaBqpgFhobpNGia1J2H3hZPrFahlMYcGdPVCVtNDs1oobSNWaJCTLofADP7sNVGIyjMYHiUmNEGIvJrAZrULlqa8yPvD4WS2gy8eSFVQ5kVi5r3dv4CvrnfEmYa06cHe3g/UegyZ9rKRNdm0cjikC+PfYaw7KkxoMrogXXrerTgZyak9c+0BUQgTmSOtcpkO0fr3JDuALUUlV1Z8DqW5zSGGcYgenTrx2KbzCermjTIM/GqeOFWl0E3LgWWWmcdrbB7llTT0Q5iMcEaXCIRGsmxXSMJONo7VYZJCoEMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD46MR9e52B8hHO/fdAWp/HUfOoJ1bIjE5Ac/DcEvNc=;
 b=CvWHPoTBk/yHNE6EKFg8R9JB0pZu1JpRl9SPpXRJjUl4fVbe0+bMnOC7x/MxcYGP2xCL8yCXNsRlcNwWmhd1kWC/464mKdQxyvZMs1A6IoLG1Yr+FPn9RQpav3GFyFdtz+7+XEALz3lLbsqDoUIbHifFPYb0rAAYN0fPW/LZHpI=
Received: from DS7PR03CA0251.namprd03.prod.outlook.com (2603:10b6:5:3b3::16)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 10:10:19 +0000
Received: from DS1PEPF0000E640.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::32) by DS7PR03CA0251.outlook.office365.com
 (2603:10b6:5:3b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 10:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E640.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Mon, 22 May 2023 10:10:19 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 05:10:17 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] amd/pm/swsmu: reverse mclk and fclk clocks levels for
 vangogh
Date: Mon, 22 May 2023 18:08:32 +0800
Message-ID: <20230522100832.1968912-4-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522100832.1968912-1-Tim.Huang@amd.com>
References: <20230522100832.1968912-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E640:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: d1980411-22d2-4d88-b106-08db5aacbf40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7q3Qzo9AfS9uksBtHv4wxFnIJ6twxY1Pabf7bJJ66Q35x/udZIignOTz18D/GdQx92g+rtcJ3iDU73wgeE+pjZ2Ub/2DAWgI1OH6AFhqXz1EREy+dFxSDV8SSG6S2q9m4uRJmg+gk0H2RvYtuDwpN8St8soKbpD2FF203YfVeSfALcp1rAsCGhvo0XA48QlbSb+FdC3/DEztj4M2UR29zkWpy77FWXHSR7zWI4r/GuEzGtFo1/tYmZfNwHiTiiWXFn6FWqSBi1rtm1RJ4fpjWg544+YbNfZwIhwUY1soLm2N+1S0zXx/8nLYUp/tj66H+8FPJkvdAidjAHRTAaIHRCoLRYq8EYzIUnk95V+Fzl63S0nS3kqi1/qyxm3dnzLATGgPBF/2bNDqqTdFQ7+zn7tPQe54Q2v1+nP+DZGJDf2voHtaRLyfi83GuAK+zNaw3nVlm8ZQm19yO/w1a1EdKRvChmkh0MUqw38BbKQ9UF2pia4D0rit0vcn19bhJlQiAudMEDvLh36sR6I/Dc16fVn8RoQI4LHGTsmwLEe+TX/oSbMeM/TqUpq8nEq5hedRQTlAA7r9TI8XCnftrA2o56HEIPcaiubhqGfJEwVaRKROSZV/wy44Wim9FnCLnjoNnn+RpFrNMg4m3keKlS/qbbXQOaYeMI4aehcOne0YMQfjy0fHwn7XoGJYQChrye9B4vCssO6jAJX5qARjWgRdfCBW5fQj2n55pk6/VzzAZnvDSgIiTW79+N42EANG0cvI2Uww/RRWiFed6R26vdcmsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(8676002)(8936002)(5660300002)(36860700001)(82310400005)(47076005)(83380400001)(16526019)(186003)(26005)(1076003)(86362001)(2616005)(81166007)(356005)(82740400003)(426003)(336012)(40460700003)(41300700001)(6666004)(7696005)(40480700001)(70206006)(70586007)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 10:10:19.1838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1980411-22d2-4d88-b106-08db5aacbf40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch reverses the DPM clocks levels output of pp_dpm_mclk
and pp_dpm_fclk.

On dGPUs and older APUs we expose the levels from lowest clocks
to highest clocks. But for some APUs, the clocks levels that from
the DFPstateTable are given the reversed orders by PMFW. Like the
memory DPM clocks that are exposed by pp_dpm_mclk.

It's not intuitive that they are reversed on these APUs. All tools
and software that talks to the driver then has to know different ways
to interpret the data depending on the asic.

So we need to reverse them to expose the clocks levels from the
driver consistently.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 7433dcaa16e0..067b4e0b026c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -582,7 +582,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_legacy_t metrics;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
 
@@ -656,7 +656,8 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_FCLK:
 		for (i = 0; i < count; i++) {
-			ret = vangogh_get_dpm_clk_limited(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = vangogh_get_dpm_clk_limited(smu, clk_type, idx, &value);
 			if (ret)
 				return ret;
 			if (!value)
@@ -683,7 +684,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
 	uint32_t min, max;
@@ -765,7 +766,8 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_FCLK:
 		for (i = 0; i < count; i++) {
-			ret = vangogh_get_dpm_clk_limited(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = vangogh_get_dpm_clk_limited(smu, clk_type, idx, &value);
 			if (ret)
 				return ret;
 			if (!value)
-- 
2.34.1

