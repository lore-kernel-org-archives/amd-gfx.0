Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81921C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A6F10ECA3;
	Tue, 11 Aug 2026 15:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qbzR/gO3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9320B10ECA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7gdjo9puEzUNI5AW/nxviAMnMQnM580KMrlsElC8lItjhAsYPr2pWf4sFeDWLERXb2dRLH9PVIzUC6HrshEj47Tn9Kpnqruxa7LBur2a7WUO2ZgfhDphSqAeDXH0UKVdLBRzPCCZZolGMgmm/rQeZn1pi9kP81aLin4Rb6KkFwx7bqykymCmyVTj7mR/FGRGtxjgGsxwGdXLBl//wXoN6DwRaM4JlNq1rZrPcUZx7Aurs/XT1LTRnTBQEk5BWOyu4l/1Lsq5V7IB+MxHaPtTfDxWwv3husxDIb5sawxxTGdMGbJWAMK8K/K3UR+IXjKuEoYK0Mkkh0Afk00GZ4mSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgjYb3kPvuPYvpjSmN4RS41lKIo4D9HupWym9OfLCJI=;
 b=Yv8SuJ4oeNh7ySQmiMmcjuA3F9NgfPePFG+UzVIVuvtV4KSSU+NYAffLxUpYLihkWBmv+XPXaVNKCjFs9Kd1N6VX3hyWIDp99rmbW9cFRTjUu9DmUyOJ+JeLxsiFqXbINbT7znv/PKlihgT0ToRtk73jLPSB6cAg5C8j+GMMjg/9TdnIGEpfcXBxQG7NckXdMHijIrnV6Uzdc1PtmHAeV/6pja8sg7YN1UVjuMz5JuE10MIIEEBn4s2s9YKPTn7c0te9iM1qupkl1f98tdW5SNBNlfzVEEEEdGV7D+Qux3L0S4227YoC/yW8wEu3TYYXaui8SnEeOfRyAtKhdbyRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgjYb3kPvuPYvpjSmN4RS41lKIo4D9HupWym9OfLCJI=;
 b=qbzR/gO3sW883huDKqC/5rLhKzdjP892BrcTuVBhR+uX0XQKVTwfjEiVeP2/IIX8qnXDUBaNqgzFjaLgmi2Z+/0hebwrxiBPTTC4hgu9uNZ2eQo/uh09YVNVdnyzAug7NkAmG5xl7y9MrVx8OGTgH8DEc5X5ahUlz5qfHohb5/o=
Received: from BN9PR03CA0565.namprd03.prod.outlook.com (2603:10b6:408:138::30)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:50:20 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::79) by BN9PR03CA0565.outlook.office365.com
 (2603:10b6:408:138::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 15:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:50:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:50:17 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:50:09 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 14/24] drm/amd/display: Make Struct In DCN42 SOC BB Header
 Static
Date: Tue, 11 Aug 2026 05:28:48 +0800
Message-ID: <20260810213010.1703162-15-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: aae89086-480f-497e-4a36-08def7c03fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VoJrImfMPQ6TxTSmK2b1LB4jTL/d/XYS8svkvz7DkiFs75a/YN2LAUNj7f6EfhrEcZk/RTo7Tk09UbRwAzYx7QQ7ibFp358FyD8LtkhCkWYhx8uQKjFrI1uw4ZqnC9+rs9Y3p5sJJdlyORly/pAas4eso/v6kY9gHt1f0zR3qvBlzJbtCGjyA6HxHA8U6bYtkIBzycHO3Lf34b7fjgENHbH/BML2PkjHxKAvo7u+kZcWSYGzd7KNEghrBZaETwoJ4g2GQsijYk/VrTA7shUd779B7Ey3qYPmeeOQpbTodcmb3l1TVAc2bsQYYfijhB0R+QCwEeKmNU3BgpRuuJKu+IPsj3p9QleFTjoeHH8753Iz637Ml68cC56YcOoI1iiw1Xi+9y3PWLT59EmuK8Sr14szdzBLdcKRud0QEGAZmEDpJt9HReJCd6CX6zmHqPUK/bfgwUhUA7eDhdp/mB+lJ/RdbXEGuy4YZMllgpWmfJr8OH3i+dT6oZHveIatE0DrbB22NwEQv99ymIh7Zlh8CLNzuufmf+ffXz6I02o4Nh4/9VU4hEBzzvIKkuT6dSFCuil87IicdRqN+myrBqg/ekgRbcLrAQEi/O4BTQ8ssELPM0YlHcFWX74XCge17c2KEcPWAFA7FbF/suYoCSqWTzpKWC5tYprsc5HBwqHLUfgM4ExMMk5O2I1gI0r4siApkT+NazAWJusJIAPUJ47KLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WeTdGTzsb2DBBnxW7Vu/W5i1CNERaCwaUiWY7jgAIII+FATRY6ZQ/rFJr0dM3yI0bZU/OIfl9LUY+5IBlp6ujIyPo4BvGwAp0uv383YGL1b2Lb0gnxLXvK5zt0wuMKAAth2RzalDqxGN2u4ajWntmJRrT4DxeizZsKg0rL9or6L/Et+qpa5aBMZ3aJi+LdvABEct+Lwo+twVTA3sTe9wiauO93yy8suCiKSUqWkPv8gIjcUKvFZjs9YiFpfvQJdCwZD/6UfoH7DeZ9/pZlBXt3k+1tr4be87SJWbPSzm4cqxAvv51LY7Grtpk9SHaE4DRGdnhvHO/R8EySaIr0E3FqNE7hQAl9lUdb9U+ApJJ6Cnv4LKJysCPKedZNnyQNBvYBZnZWveZoXP2v1LZsULoV/oOOSvVX0e13m6dzlODk5OH0Ry9vM380iCobSDylID
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:50:20.7153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aae89086-480f-497e-4a36-08def7c03fb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Make dcn42_ddr5_power_management_parameters struct static to avoid
having multiple declarations of the structure

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
index 51cae3efe310..b21beebc52bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
@@ -219,7 +219,7 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 };
 
 /* DCN42 params for DDR5 */
-struct dml2_soc_power_management_parameters dcn42_ddr5_power_management_parameters = {
+static struct dml2_soc_power_management_parameters dcn42_ddr5_power_management_parameters = {
 	.dram_clk_change_blackout_us = 36,
 	.fclk_change_blackout_us = 0,
 	.g7_ppt_blackout_us = 0,
-- 
2.43.0

