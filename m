Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E0FECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B8C710E7E6;
	Wed, 14 Sep 2022 03:27:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E0A10E7E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrkNHC8EyGm76ir7WN2Y5Sc5DeuI67xO37e9Ao7vCCLy06g6RB1XKpep+J3sNRt/9vvAwiUxvwzgy5OY1BHDwnITnVjpip5KiPaum4TjTdtEs7KesCR7FZ2pg8P8VmtprkG+xWFRKtOYczBUP4PoWkAUM0ilF61icpONAaPEOzkHxZaMK43l6mDy2HdCbLNIiBR2F0vtlpKzX482T1KlPt6ZMc8E2WGcT2Y3WnJxcCdjT0O9eSYJCErccD66LPMvFjKVk0Vi4KT4TrWsFVChUjS40SHegEkRG2pJ/4lLtDwT0Arp/TETssSF2GxtpiIUMpBWb++QrqiN05MmzRzc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxI/JHXzr5GZadyNViiN58V6lSDcbbOZdCxsdmfwu74=;
 b=ZB3PdRq+c29trgpy8E3yUgkjD2BS39FfoAt7jbiBUubE0x1SRUl1pKY4qeJDaM5ZYrr3yoRTqRGLE4TthaOdU7oKiwAlZBB7eGnXffJlXVOywuSvrWHgqj1ZPqIfnBcpSUzpofnZcDmYA4sToW6P4QeSALIh3mIqgp6Ad5qW+/jPercOMhYKO5Dok7f34l8o4fCXABWkM4/UzhLUqySQ7yneJE3MBy/dMu8HY3KoFORRBlNj1JS6raozQkb1kIyu89m7773X6Sv6nSEKUWRFthEXGZ+K065ixqHdecDpi75XU6fRS+Ni5mrhNwB4osIPFZLuwKSx7PRQ3UP2sM0c0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxI/JHXzr5GZadyNViiN58V6lSDcbbOZdCxsdmfwu74=;
 b=Q70ORZZ/TV/glX1kZvZZez9p6PJimkr9n0nDsTKVg+yq3ORg2olotKaYIT7uy/XOCgNN7SgqoVjPneqBMefJp29f1cuInXtKIip1Vf8wa3U6W9lhWdA9QJ2Cr0sOMq42WhE9auCRll231Ka63ke4PThlVZ4cgCrLlzmISkbnCwU=
Received: from DS7P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::9) by
 BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 03:27:20 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::e8) by DS7P222CA0023.outlook.office365.com
 (2603:10b6:8:2e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:27:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:27:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:27:19 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:27:14 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/47] drm/amd/display: Assume an LTTPR is always present on
 fixed_vs links
Date: Wed, 14 Sep 2022 11:24:03 +0800
Message-ID: <20220914032441.1075031-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|BL1PR12MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4389dc-617e-4e7b-fdfb-08da96010812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEizVNmmrt5DyfoIbYkrw73SrhjKMas6m65hwvFpBBReGlfOLdAqRb26mUceTzTTlOH3+jEIuRsad9hTvQaPcOTq4ITKLc+HKt/fpB+Ea8pojl/zMY4AaJfnXMRaBeuG/xl2ZpG9nfwC8up0tkWJxRxzvzHr5iG5Crt4Lxo4vzfTy3kqoYZXuUN6EEAPFotlDXI2PyhhmkaLjF+dcrjSneUC2pCEdKsbCj3nNQeUWEkCbpl8kb/vpdzm/o1Dl0eYOcC+MOlRLf1pSEzxZbGRpbj0oMuYlW73AOK/wFWm8a7fKh2/Jz/kepZEpTLmIHmsHYz+gR/49JNSoTqhxrUXC7T5Y3xARl2mNHeftM52DXTadybd4CJ/VKvsVTWJzEIrTKAk0/+CoFH3tB26BPXdD5F4S097TKHxk0nx6P2/wBdO+47kY+D4OmBrgIwe7XhL7T4SajxUGg1e96nH0lJBU3+KVEgkvQsB2fl0+Nj8eu+15WuRioIln8/9EjX4i8JpjJ+lNaQg7CMPdpVQc8vijuazZkxT/v3OVsFucNbtjhkWnuozVguBLKvtPCkPsS1iXtmWUQRUOdG62pgv6+71m8zxU7dP8Ag19bRn8f9NMSXQ9cyqxzIlZJRlOUw7TdxF+W3FlbdwbAO5JbSVlQrO306i72K6qJqTpm4omO4SNOTQlT48utU2Ap+oQ6G9ahmsB+dLYiNehlWlDqBeSz4gEPAIEnNBxveX+IkuMDoRlEkA1qDfwG4cRSsekr03i1GRKEWZlZpbfBqz4GqPmi0zREmUSM/DfyqpPWxZvYdX5mc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(6916009)(316002)(82310400005)(54906003)(41300700001)(70586007)(2616005)(7696005)(336012)(36756003)(40480700001)(4326008)(40460700003)(478600001)(186003)(2906002)(6666004)(70206006)(8936002)(426003)(356005)(5660300002)(86362001)(82740400003)(1076003)(47076005)(26005)(8676002)(81166007)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:27:20.0005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4389dc-617e-4e7b-fdfb-08da96010812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
LTTPRs can in very rare instsances fail to increment DPCD LTTPR count.
This results in aux-i LTTPR requests to be sent to the wrong DPCD
address, which causes link training failure.

[HOW]
Override internal repeater count if fixed_vs flag is set for a given link

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 11e13c45a338..40bdf9708d76 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5133,6 +5133,14 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 				lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
 								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
+		/* If this chip cap is set, at least one retimer must exist in the chain
+		 * Override count to 1 if we receive a known bad count (0 or an invalid value) */
+		if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN &&
+				(dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == 0)) {
+			ASSERT(0);
+			link->dpcd_caps.lttpr_caps.phy_repeater_cnt = 0x80;
+		}
+
 		/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
 		is_lttpr_present = (link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
-- 
2.37.3

