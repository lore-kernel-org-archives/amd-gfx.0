Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5879C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7641311242D;
	Fri,  3 Jun 2022 20:12:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D466611242D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQy3z9mrSOKyfXVvCs6PNaMTderqe8x4OEJo3C9azKB5yEvamN4Wr7gtqz9mxIMv922xXG0XlCyaDmHFOrqlQ5X2qtkA+mihTa8qoqZ9N3KHG+CQWUhmxSuP9RJV89ynYOOUuh1zgNUsKN71E+hGI0Ibn1SyNjJHIBKgB9kGDZtt+hMGzHboLfFR1SE0dzbuXCU4HaroGH7m2kTO750AVNbHLkw5rN1e3ez9ixwOywyqCb5q17Rzqb46872glzsD1t/sOHtZh8xlfJKPK0BaCEE2Qgj7i8wW7DcsOU6f6RWrk+fk+N8gPovsGu0e0W58Ycz3ZuXDuLKfiqYBun+CXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/HOq9tHznyLzMBpkKXmdrG6XV8RyzyQ8HPYO+B+Dfc=;
 b=QUl0kcbG++ooDNsIsNYzQaxzCEOfnzpTPOqGpBB+J+WLG0tZoGJa0TmsRLc1C9ABPcV5UrN4NYTSXtnaJMrLWFBOgFcS9j2QV5es4HE3Z2V3VTUqzTsbIbuXHBrELWQFXSkqHJBfmMfliXmytECzY/BYoLaXcAD/6TlQuO6+l+QUebOoNXcDrh2UnTKBnCiYQjXchqfF7uAY/G6stlKcskM8enQgILiUXkkMYw/YPxbRSdFbf6FgKath9w+gW/CHWLsopBCX2xQ7h4cCr6Luty7PRM4K/3ryGesionnP28+3OwTpFoCqsGyI595ZGtH/ROctzgjDZkVxTeCpTUjdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/HOq9tHznyLzMBpkKXmdrG6XV8RyzyQ8HPYO+B+Dfc=;
 b=icPbh7XLBxv+gyfw0eutWmoGRaAOBxakjnykFvhtuUB+OCKtBYtIFSrDsRt1r1imZyjoeUtkMz8Fwru1CbI6qNjHwzrCU6pGfgn4PI2BOnehQ6UfL8Kl/B/WB/+ylrN3Ir2jO1YShz89EAmVpEYJ7tgANPWkxOKlZhDcgFaZRHA=
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 BL0PR12MB4993.namprd12.prod.outlook.com (2603:10b6:208:17e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Fri, 3 Jun 2022 20:12:48 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::88) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:47 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:46 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: Extend soc BB capabilitiy
Date: Fri, 3 Jun 2022 16:11:45 -0400
Message-ID: <20220603201147.121817-15-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a9fd48a-e720-45c7-8616-08da459d6db0
X-MS-TrafficTypeDiagnostic: BL0PR12MB4993:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB49931E5CA0FE8C12E1F0E969F4A19@BL0PR12MB4993.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33AdjfDBQuLY5xPYYHLUQfi00uv9kUYvjf2STDimJMqxUC1k+uYTTcVoI25E8dY3IfzjrC99CQp5Wa4v66/l0wzFdMk2WgheaWEZTFM4wdbKeNrCsx2zpNrcZnFWUWApq3nUuYdswK8/UazNirMPCZpV98FWFGTTwAdnw9ISX4FOzzrOST9mTe41f44BKlrITMDYmEW4PH8yW5HFFcx4eWI4eZWkiGN3RH2CBhN5Tc/CPByHunFMWGpEJoXR+cvZ1UX3DJwy1IWzkVT+o7ndItCM7tPXMjTcWf3hq2ntiRopnFGRBT5md65pNS/mGV3FXyI3u0cO8E31FzzSgDizgBbC7lw/aCReQeOoSaeTnVhCBHliV3inH+dtft8xbU3S+kCBtcw8LDAj/QD0I+Q/Cgckcg+hWs7M5VHRpGJSXlKSQfy8ONNR6PRt9FxITwSuEhno7iaja8SkzLGx/6rUMU8RAdUh29dX6v1giLV5FNdouAGVdKLt/X6xzj27R5Ivxx4rObvrbQbHs5HRLGmtwmgPcKGKVX2dGcX6pAuAUnj7hJwFHeNpxhCA7ekdfwzA0iU1oCw0udbLb1xZSm9yDcyb2mrUhLCDPVFHi3KK3Y2ClijczkCDEYV9yEahUAG3wZYtZ/BNtzqdvotDKxuHWcUhUHAhriCfYK2IotWkPmr+zP4jMnbiFGxLCYrzuuC8xrIk2XnRBYJHMf3coCDjCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(1076003)(4326008)(36860700001)(86362001)(2906002)(356005)(2616005)(6916009)(316002)(8676002)(36756003)(70586007)(70206006)(54906003)(426003)(82310400005)(508600001)(44832011)(47076005)(16526019)(336012)(81166007)(40460700003)(83380400001)(26005)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:47.7876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9fd48a-e720-45c7-8616-08da459d6db0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4993
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
 Alvin Lee <Alvin.Lee2@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lei, Jun" <Jun.Lei@amd.com>

[why]
Some parts are consuming dangerously close to maximum number of states
supported when updating the BB (i.e. 8).

[how]
Change maximum stages from 9 to 20.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Jun Lei <jun.lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h              | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dc_features.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index df03fef1fff7..fc0da169346c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -726,6 +726,7 @@ struct dc_debug_options {
 	bool disable_dtb_ref_clk_switch;
 	uint8_t psr_power_use_phy_fsm;
 	enum dml_hostvm_override_opts dml_hostvm_override;
+	bool use_legacy_soc_bb_mechanism;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
index 2a1983324629..74e86732e301 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
@@ -29,7 +29,7 @@
 #define DC__PRESENT 1
 #define DC__PRESENT__1 1
 #define DC__NUM_DPP 4
-#define DC__VOLTAGE_STATES 9
+#define DC__VOLTAGE_STATES 20
 #define DC__NUM_DPP__4 1
 #define DC__NUM_DPP__0_PRESENT 1
 #define DC__NUM_DPP__1_PRESENT 1
-- 
2.36.1

