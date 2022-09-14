Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA738C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B7110E801;
	Wed, 14 Sep 2022 03:50:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E193410E800
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi6c48qkwPnMQIbxQ/JNbBV8AnQUfX5wNVAv2BBnAG/BcZm1hDT3IWj9T3TqjiQjzVT5a9orvm+UcfDgSC9HXnJLTmDil4wznY8UNYB+2+ngUaTyet2ge4jayZH+aPphzvsEuprMuy6S2gRMsdUB9RpnNkxWkFvJxVUmaFF8kG7XXXWqGOPmNtHCO496JYe9I5IehG2C5bGHKwcm7zGhsWvFkPb9u2Z4uH9X+28leo4cGkajVhs/6/rTTDAAmo6TeU7uqmEQv13/qoNNK/K3Ovu9jTfNeTz3DeMTPAMTwl7/AtW6NGCB6jN3OSJDxp/E6mlFcN80cItdZE4jz7PfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxI/JHXzr5GZadyNViiN58V6lSDcbbOZdCxsdmfwu74=;
 b=dVIksycgp1ZDfymSsAiwDoen9waicm3rgQkVKaz38xcYOIbdNOBEA+/ldZ0SA1wLq5kpKOK4vof7z6w7VpnfYVW8dSvxEZtFxib/eT9kVTl9oTR2Q/ffJ0LGj7H/6WRXgu3DVX80jRaLS7p3Qw9GuAhHq13j96+dbEsiRb4mSedpMXZJY9BcdKmzFwETwKa40LzrvLZFuofxQeB8DqO3z3QwXUHH/87EICKEwesALjxjxd2gleLJdyCb8AIckIVOIBpNIcivqUPZLiFjfDPzst4Ut5kjURpaTjGWDP8HeIfAyg73lIXL5WoZtIpgAE4GS2hdm699v9BGSQTXv2O0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxI/JHXzr5GZadyNViiN58V6lSDcbbOZdCxsdmfwu74=;
 b=xgtfy1d/ZmAbRLqI/FsvdJoVVUs5N92XKTD0uo2SzHeRHqXJkepf3XLGByWB+Wpq/oEpJDzhaWVE2VR/NfrxkV+GBvxAPVgTyw4ho31IHjHV6CA6TjQsqKPXd+W2IXN1mTAeR/cVC/NGoL9gJKmRhWQe4UWSS5U4/9HmQ8jwNho=
Received: from BN9PR03CA0287.namprd03.prod.outlook.com (2603:10b6:408:f5::22)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:50:04 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::f3) by BN9PR03CA0287.outlook.office365.com
 (2603:10b6:408:f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:50:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:50:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:49:44 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:49:40 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 09/47] drm/amd/display: Assume an LTTPR is always present
 on fixed_vs links
Date: Wed, 14 Sep 2022 11:47:30 +0800
Message-ID: <20220914034808.1093521-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: b4be2c5d-e8fc-48ad-ee28-08da96043570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2sHMyGUK4M2IycBdqfKZd/pK9R7Mu4iHLjQC6+X0X/20IMw0n9lm/PZsV2BzKzhwBGwpLDWr8pWvGJWhcNFIUTynkeS2Bu55kwwtqHd9TWPOHRkOl8N+6Mnv663zxSdQaerPEM9QQlhItQ1Z0SYEKmwIlpa5gcd9uVWrNXUyW3v4HZgtt2lwCLz/L/YpG4v8qzhsfqhn4kWK5koS57ZdY7pwowP7YxSPkRvm+a+BKBrzfbYCg/upO/8s5ecHz/o5akGtHCg5e6/CUZg6slLi+7m75U/64ZhpNPX+pQtPPAkddA4azdX95+jR4eoc+YrCY0oXnM1HcXQ0ecytQ9+fJYlgu5UijV+7mOQbs7Sq35A1HUFCh8RRzUOMNUApSrBOSLKdCJs0+617yLG2+wfLemgCZXzekXxpcz714zWpJ7ARhNH7rBF3XiNyJStVJYMFh/kC4k7AX9df08f0btFbZhrChZRZa3/bM2lmZAndIM7oSsSHF24Qvig57br9RgzA8Tfxc8UeSXzke0REf/fuUK4m96HMx/eUQA4noTaHCnDCHX0phicjgzVZ//Mmq802P/Q6CCkxtzvhkl741eqpvHTCUKNZtDX7bScZVi6IVHQwbMGhj/xyH7HLBFhc8xOghiEXY60FB7jPq+B3QXsLusDdmCOHOgYSSpsbgFhg8nyoXeoTi9TvK45z1tY3tdq+B3wg77BtgIG/Ov2KDv0zC+DGouUN11iNAjqnKE92PjvIIPBp75pXnSDWjHRFEalmKTahQih2izG+6SuIZ7aMdc6VI1LxUFERM+gR7XUZpg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(70586007)(6666004)(8936002)(86362001)(41300700001)(40480700001)(7696005)(4326008)(8676002)(336012)(36756003)(70206006)(2616005)(186003)(1076003)(83380400001)(47076005)(426003)(40460700003)(81166007)(26005)(36860700001)(356005)(2906002)(82310400005)(478600001)(316002)(82740400003)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:50:04.6350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4be2c5d-e8fc-48ad-ee28-08da96043570
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

