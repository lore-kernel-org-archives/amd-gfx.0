Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F336DC4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FC310E87E;
	Sun, 23 Jan 2022 18:21:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D77B10E466
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNURpXynRQJPqRlBnMMl/LLYXjes3U1xTH6veYn+UIfRvlfmG7g8bcWkxT2ARAB+VfEGpK2oq9UA3NKG15U52iGAqN6vrZ6Q0QL7CWH4cSpUTShtxomDhBXQm5ro5RNPH8TUnn5H69csL5+TBlxPJhro9/fwxfg25YplXwRFVqr3IXTAxkcPLXGfWYz5zOX1o9TwvLf+mQpBdfrUB73S+GQx1veIQ7MgvoZybN3CHpg/jAaD6dOwdSWTS6pcKNUOpFlBFO/7XNwQQWu9F/AR4M26ABAw2J8xzdo5LRyyTurKJCstj4wqj6rXkTPzgSxYm5fCe9WiitavYy/AAwqbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vULEntM9fqVlr4r0Q8aby95FAMCwyr9LtremRcJjQVw=;
 b=oIWX6/IXbvAvdrO2UkeGjkSZP7NVj4UgWiuAdL3eyh8bLMApBCA8NtepZrsgJHm58GyCJtYXkjvMWErXZVE070iihPbfyUa8CAaOJgdQZixBwbPhKSCGFtl6xmieZU6/K1LY84Z/RnVogHReqIfhbGpWWZazKtQEgIZSH0xhd5ewQ4RLEMvO4xWigmJSu9EmknWR+FkqQSA/HoQZ8DdhqIbV2MmyqnXVP4LvrXAonPUuCnjYgM1Plm1SoPNjyixXbPPhbD+QDV94rEtSHLlEfoHX5Bj6dlv0W7St1uAPirkoUQ5o6kg02WESprY8BobzI2oFGaA3H0VExInFZILbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vULEntM9fqVlr4r0Q8aby95FAMCwyr9LtremRcJjQVw=;
 b=ets9aXSrzfaFg9/WWF6FN1WDq5ifDlfBU8YYeVzPAFFIvNGZs85rhu65CX25LJZEL1EcoInn+77xKtuYvErrpCeDnKKPGRpGuXIwNeFSt/PBDutQ1mOQPqtjgQqUY0v5tesONfiI+cySd100eKayOiRJ7qrOSuakJnB7EmLO+Jo=
Received: from BN9PR03CA0990.namprd03.prod.outlook.com (2603:10b6:408:109::35)
 by BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Sun, 23 Jan
 2022 18:21:12 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::35) by BN9PR03CA0990.outlook.office365.com
 (2603:10b6:408:109::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:12 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:07 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/24] drm/amd/display: remove PHY repeater count check for
 LTTPR mode
Date: Sun, 23 Jan 2022 13:20:11 -0500
Message-ID: <20220123182021.4154032-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f79eae76-db0f-4170-feab-08d9de9d22f2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1283:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB12832763F8E242232086C6D3985D9@BN6PR12MB1283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZDCM2pixQIbooNTombzBL8fYCwoNL2hMk6XkilzWSCUOqziEMF0aNH2dBKrqn3Ay08cSkA9mcRmprGNBI0zaBp6PYGhhJMTCA2b1plpnKcPM63UTtEmIsOpqNDbKIp9mloH7kWimXpG+tKwJvLuE/F8Q5WhMQld5EEjRbF/k2QaLaSubbWQs0vXMCJ2qrEZRZ3sMnwNhkdzxdjSOjdp53WmdvL7QB0aGN9V7yTYU3gP8GD3f0VZEojUvs0b2/RbT3cHmysqLCM2+uNPL5Ye4YicVa89PK1Wv3TH11AmWKGSU5kCGQWdShhJLCgTbBzpdo2vFYFX5ucE9smUPiCe+wnrcIPkGxuwNtxqbyW8ljtcwKrOADPE+wuoyxPkGCL8pOEE/PTVVnTa46pEugPljpJcc2C+oLpUSesw/EqYFo5r5v/VH0kQ6cSNseup2vu8noqD0o8tP6Q4Y2q30Hm1MNdqh24toFzjt+Xy2saWYJyUZEMON9ATTL1MpwWqSESHfUnOzBVl+d/IxvJf/lAAJCNLYxhoRxYeLZIDgF5y6uLTugWco6/hfDEolxN5Ptecop2QiReEK/1juAxRIsFyp5klh2ReSgc7j0gycKEU9AY3MK2fTAmTeFt0bueuDi6cP518Uye4+fW/ivzui1cf6ag32XvxQhJoBBvjBkSs0pKSU+ZBaZYb/R9ix5Qmft4cbLBnKWTis4C9B3RQ4UEWoyjDF2NVUhTAtxLkANhv/L0l+aZWfTTco/FNhLRj66bS9HdIr+ylg6xj2C21ydpsmrHeih1GCSds0QCLjVDRaqg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(356005)(26005)(16526019)(186003)(4326008)(40460700003)(6666004)(70206006)(86362001)(2906002)(83380400001)(8936002)(8676002)(82310400004)(36756003)(81166007)(508600001)(36860700001)(6916009)(336012)(54906003)(2616005)(47076005)(426003)(70586007)(1076003)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:12.6749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79eae76-db0f-4170-feab-08d9de9d22f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1283
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Sung Joon Kim <sungkim@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Due to bad hardware, the PHY repeater count in LTTPR cap is read as 0xFF
in some monitors while the LTTPR is actually present.

[how]
Remove PHY repeater counter check when configuring LTTPR mode.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 0033d2a0cfe5..f7ddba9cc63a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5069,9 +5069,8 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
 		/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
-		is_lttpr_present = (dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) != 0 &&
+		is_lttpr_present = (link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 				link->dpcd_caps.lttpr_caps.phy_repeater_cnt < 0xff &&
-				link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
 				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
 		if (is_lttpr_present) {
-- 
2.25.1

