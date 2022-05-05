Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA6DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D2D10E263;
	Thu,  5 May 2022 20:08:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC48C10E263
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBrsWhW6wCZtS2QPx0bcmP404icbICGjPsih4dyD8oUAlPiMjd5lPB5QupVC37bDZhjHi1m5UtbITZDPAvglIKIxaTEhQ/xYseTcuHdtkMqDiRcXEbNJj4L8QPknkiuZbIJn6adlvuKJPE4TJrv36fxj76FzRiyVVeDPifSYSUD+mo+R6TylBZdaiV9Oj+4HDEH2Xi5ASbg1P1SYczmQgEJd2jOUG37XuosVzguj1ge8zYbcJ3vCHkW/jy1ThA/DlfCVxMD13bj86pzIFwuHhoNRay4aUM29BSudBl00rh4xNwfQIZuzzDk0yJshBtPWyG5s5wPEjJWqO+kb6ZZeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5auTafM+thFzinFMw5cneJsjfG5xMsjRjjpmDBtFc5M=;
 b=BdfnH1nlOlRprxRiOe1YSVApv0sggim1EcDHnQ5yA4KggQDxdM3pcrC+7izMZZqRh7vLOe14BLLT8HQA2xzsqVC5C9hFoZJf15alrU5Y/DxfdsBSJ7+4Cn8l4km3fiHFp4Nvx44vemopiPWaO2v0YbL0H8N8OTbxkkT2x2KRgOuqVrGGpy0/xleyQ+CQ8QpmHJDQgD7pApJ9pJ41Ow5jX/AJeNtGHU9fAuczTwnEjUWdw/ZzW8RA4E0sFtdlAsS/nlxqF62aUqYl5KcelNvll66QEsot2jIUNVbPMiWQvWyQixTQ21MvoRwuUSxW2LmJ9BlKf0RMwLmEEU3mG0iqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5auTafM+thFzinFMw5cneJsjfG5xMsjRjjpmDBtFc5M=;
 b=00T50k7s/WCTU9Udn3/1BxHTzQlVpr79UuoUbdKnr62aeap0QrYK8f2Gj8w9xKFp1122am6daighZZ9ytZrclBDDeg8hb0ztoho4oKb9zY0AsTckAa+wprwhv/za2OunvU1osxQExwBj1Ew3xOEG9+1Q7SI78SG0FjSsaCx8I/s=
Received: from DM6PR06CA0064.namprd06.prod.outlook.com (2603:10b6:5:54::41) by
 DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 5 May 2022 20:08:34 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::33) by DM6PR06CA0064.outlook.office365.com
 (2603:10b6:5:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Thu, 5 May 2022 20:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the check for current link status
Date: Thu, 5 May 2022 16:07:40 -0400
Message-ID: <20220505200750.1293725-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200750.1293725-1-alexander.deucher@amd.com>
References: <20220505200750.1293725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b67c3b-0fed-4448-98aa-08da2ed308e2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3770:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3770B5F7BAB5FBF247FD6055F7C29@DM6PR12MB3770.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqkQ577X8X+TGsWu+D3egtsBL4NYQtIa/sOqzV82uIGrBuuhiRwQ1uwMp7gcX4VJaCdLFhwM+I8uoRtZHS/jgZF4DqW9IGOMlvv2soU5z+WuFcdSCeqV1ZD3O+uA5kiRQhRSmiJz1JVNSz0n7cZ/+hSZGy/ppBsSstih6RsIJRoLQN18YXvaEMiIkvC7aIEAhDaFrK423/bvgIH+uihchkon5KrmBt7dxnt4R8WHKwD4UuTtx9JZNQYf60YbD5b+gw74Sy9dSDjEtqJUvUOFX0zwmWCPOvKoeXL5a8TRX8rF2vUa+/Hw3Pk+4CY04ZFitSrRcuJet6F9+uO83l4eFn+eZQyU4wmZhb5KGKGj7e2AygGX3iYPlwS/p8wwz8kGByWp2q5A1oisOYT+AJkmzCFAexsn8ewDAizz6+ToEvTz3eJzUCUPye6WPMY7cWojWb/F1LFk8uF6ueE1AHiIRPGpMFqVCtpYLonQUj8RMLxKretooc4laHYiBMy86AkQOzRbL1fjattsNUqt+0WxKMgHuV2qo3QGHLsxFAb+dlyO7BZFiDL1umg5KudB8jQyw+1vWYxh21fgukqYvDdHQjrqKpwaJqrdPGe4MuISlZAllhMb3zpWy0rEFZHBRDkvJu4/rTnnq6eMUyokHIc3LFBK9EjFwyCPG1yFDqhVuGvFKC+MnHNDKbnwo7IoWdaPkTfeoFu03T24eXM3adq+6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(36860700001)(86362001)(40460700003)(7696005)(82310400005)(81166007)(70586007)(6666004)(8676002)(70206006)(2906002)(4326008)(508600001)(5660300002)(8936002)(6916009)(54906003)(47076005)(426003)(336012)(83380400001)(26005)(16526019)(186003)(1076003)(36756003)(316002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:34.7297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b67c3b-0fed-4448-98aa-08da2ed308e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

The output from metrics table for current link status changed.
We need to update our driver accordingly.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e3d3cf4d5c54..3fd0ab90b566 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -886,6 +886,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_13_0_pcie_table *pcie_table;
+	const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
 	uint32_t gen_speed, lane_width;
 	int i, curr_freq, size = 0;
 	int ret = 0;
@@ -999,8 +1000,8 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 					(pcie_table->pcie_lane[i] == 5) ? "x12" :
 					(pcie_table->pcie_lane[i] == 6) ? "x16" : "",
 					pcie_table->clk_freq[i],
-					(gen_speed == pcie_table->pcie_gen[i]) &&
-					(lane_width == pcie_table->pcie_lane[i]) ?
+					((gen_speed - 1) == pcie_table->pcie_gen[i]) &&
+					(lane_width == link_width[pcie_table->pcie_lane[i]]) ?
 					"*" : "");
 		break;
 
-- 
2.35.1

