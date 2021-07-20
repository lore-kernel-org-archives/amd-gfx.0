Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B549C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 03:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218026113B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 03:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218026113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDEF689CAA;
	Tue, 20 Jul 2021 03:34:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B09389CAA
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 03:33:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3mlJX+5dyzXTec0R8AcWyD6lFsGNuvUDpgg1GXbSgAwFYHc+ZYLmYftlMze5UsHAhVJw8rPI4r9ivRkzEzzJ2sdvSd2FjlBHsVOLqttOxXsklGIATkOq3joXrhx7lndHU89xDqIJaNaCUV+o5u3WV68oRLPQ7Swj2jKhdtvpCQuscw12oYVk311DVi41pOEgSwF2nnz5Ut8cni5olb+8BFCS+MHnpKpXNZBE/6EeeqJWFJHLYslaJj1aUGTNo7cw6qmpAQlO/wxpjIb98BHPVDcMpJ1p3dLYoigJ9DoxT+IR1to3SllUxZHbhNff7n9/8GHUsnYqoZdmKWwuspwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoR5GANOnIExxerq/E+Sz8e/xbiIFLV2/HYITA/9bWI=;
 b=UbP8UN1UAOsiCqZ+me5WDqea616+oUai1GPlziR+WNkRktsJWAmaOu+7krDMr16BvSKHfUbA0+yPNy1kPppg7VoBa/yQuBzNYH4Rl73KtYzKUGXuJOH9G+D6uKpNZXqBxWgprV82NZHC9R80LMu+qoWG+B7SbBkWNgLVeoHjqbvyS7IripRm7A1c8chbbjJzDG5D3bzr3YFHlkZPoLB+NpDJxJZjpPT14E1JPDrDcXjIZJER4e19OyP/w9tFJfnXSJCYBDQ0vOYed7lM27Awn+GwvjhHnUoofPy222WtbxyofIs7NNsxEKPWtA6ew5CI1f9UkjUaxUAbI4TkRZyQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoR5GANOnIExxerq/E+Sz8e/xbiIFLV2/HYITA/9bWI=;
 b=iRmNvCkOIiND+Z3hal3RTau5XANEfib/ewpeCQrAXkLJZAeBHrpozClVDIZj/eMm/wSVE42fdske00kECvNtJewsEBNkiailAMP+O2eC5kIJbwhRUCkFnzo9mkWLThZYwoHP9Savv3Kj+AUFxneURx7IWVlX4/iKkfJdE3eV/t4=
Received: from DM5PR19CA0052.namprd19.prod.outlook.com (2603:10b6:3:116::14)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Tue, 20 Jul
 2021 03:33:57 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::72) by DM5PR19CA0052.outlook.office365.com
 (2603:10b6:3:116::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 03:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 03:33:56 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 22:33:52 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Fix ASSR regression on embedded panels
Date: Tue, 20 Jul 2021 11:33:17 +0800
Message-ID: <20210720033317.686726-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210720033317.686726-1-stylon.wang@amd.com>
References: <20210720033317.686726-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 126c84c7-65be-4efa-e2fe-08d94b2f34a5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40164B709F331E4999E39041FFE29@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSSGpbrhdyeSdsNS33apSCO0EdmJGrQptyB96Wx4eJxt4u1w/u7tNXUmPPVpXhqJnfxq/hdNeamrvXSjKt1E5E/xUdIRON9XEk/vbvLjkuySbYlBNesc8w4MGDOWfVF5o8SDuU9dijK7s79R0rnk+yn5tqy1BaPD2/mAIfmUQe/JoaSXgQKgLuIoz4wm0ODKUvl3vDiFLDd50zUegSLLraZnhqGnIFuxFRNdzyfr3x4PICklnnqJGwmlMWRvFyTJn4MQ0o7Zz5S77Dyy98teyMSeL+GnUT64PdO0i75JHIZUvI1n2FSHK8654C3xGHJwy9JwR/rHNzFcBnqdbR+rYKlnisX46992E0dV4/cIUp2FFp2ODVO1IKgPx/jPkzUvYg1Si8/gpdTrwpUGcRDJ5mqQ/Bq8V/OD09qIzahp9VFq2sY+IDJOwBi+Vi1CiARaqtYqFH9wMMExNPIcCgie0CWk1RZk+M02aLHPFN0oce2krZd/In7V2UsCIy1gl01UsKX6IwHTUyhxrNV9X0NSuRxF6n+JSOqlCFc2b3NLNXmokwEXTR6T48Irn7asmU+CIRnHFZbfCZiF+ECIaxOLOqFyQrOs2+Kfbs1CPs7SDgCm7ts4mIr4W94e73G6r1sTkKB2LX/TQqwrvJZG1T9Ngpd5cACS6A48GipEsgNwn4GsDJUxSQ2ESSVp6TIG21R+e/tw3nK9xZL1ZMj8PuHEggp8uvyF/OdBgdosTQjByuE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(44832011)(82310400003)(36756003)(2616005)(316002)(8676002)(70206006)(54906003)(47076005)(336012)(8936002)(1076003)(86362001)(6916009)(6666004)(70586007)(426003)(82740400003)(478600001)(5660300002)(83380400001)(81166007)(7696005)(4326008)(16526019)(356005)(186003)(26005)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 03:33:56.7269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 126c84c7-65be-4efa-e2fe-08d94b2f34a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Regression found in some embedded panels traces back to the earliest
upstreamed ASSR patch. The changed code flow are causing problems
with some panels.

[How]
- Change ASSR enabling code while preserving original code flow
  as much as possible
- Simplify the code on guarding with internal display flag

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cc62124b0b82..f56e061d35bc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1811,8 +1811,7 @@ bool perform_link_training_with_retries(
 					 */
 					panel_mode = DP_PANEL_MODE_DEFAULT;
 				}
-			} else
-				panel_mode = DP_PANEL_MODE_DEFAULT;
+			}
 		}
 #endif
 
@@ -4643,7 +4642,10 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
 		}
 	}
 
-	if (link->dpcd_caps.panel_mode_edp) {
+	if (link->dpcd_caps.panel_mode_edp &&
+		(link->connector_signal == SIGNAL_TYPE_EDP ||
+		 (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
+		  link->is_internal_display))) {
 		return DP_PANEL_MODE_EDP;
 	}
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
