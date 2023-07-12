Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945B0EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04EE510E5B9;
	Wed, 12 Jul 2023 17:14:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9906210E5B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VN6FY/V8oezNBarNPoGRZZrhyb1Vo/TL7hzgtVqJ8QgRHasGQBSb4UPOjvN1ghltC99FUaDkJCUV8LRuJYyDcTRuaGHha9b6ew0nE1m1Q8RNfH6k2NFFI3+naZYcsP7bD6QuxUIM19/ruKEEsT0Kfq0NaFSPaGuubVW92XhCjvsp1CeXtWjaMmbfmswQ1pfraRm9aLvXPvAYSA2Ph0jUfC89o+EDaCdjgSZShWu7SAGcXTZxgs2foUhnKCAXlyfnlQHg8GyU1fryPGxZRWPvDqM+sfw7OWZLE+Zpyv4WP9O2TQZx/DK4YqRhdIHcKvS2HdiZs05AGkL2z8AG4B+Neg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOvb37CsRM4+Hs/ez3uo1vQuXBY+9eP/1W8+zsmdkGQ=;
 b=etMUKYzBrF7chQ1gcJjDR66gr0WFvphNDnw2V1S1Vza6zw6Mg7cGIiGcBzJnU4byOf8b+ePLFWOblaYuJ5dd1I2RzHFHFTWBJrPcnw/1aVBjAHi6+1ONWG3t8zJ1nbtyb141asAKd51QHOAcw1nnh/187NwHmCooVObmmxEruBRi6rMy1FBzgTjTTIsy3ViKPKnvmA0oW3mk5myMotTpF96oVDTW9gT/OBB0Csx9H2Yb+ch7ex4mODTxAyl4R7OaZRRgk3jDGBFtwxTEVZMcnvIsXdyyOYYLA8i0Hv0b+rQ6xrMv2flgxlNvmVwup1pTQzn5g+4lZiaK7eMrBaYjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOvb37CsRM4+Hs/ez3uo1vQuXBY+9eP/1W8+zsmdkGQ=;
 b=OhZQPB/CHA/rAXxsysxprdfl1oh78xoosS114Bfo/tFq0sPshzX4HXCXBanOcmt5PF6/9KqrgQC906+YCOrorCGo+yDsrTW+9aXZ1xs9X/jhkV0YJJgeWDT7rgdpQpMlRs6s1h1Qq3i5CpVD3caimjEAt4YxyFK9SejL/9ZEegM=
Received: from BN8PR04CA0033.namprd04.prod.outlook.com (2603:10b6:408:70::46)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:14:35 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::65) by BN8PR04CA0033.outlook.office365.com
 (2603:10b6:408:70::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:35 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 12 Jul
 2023 10:14:34 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:30 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/33] drm/amd/display: Reenable all root clock gating options
Date: Thu, 13 Jul 2023 01:11:33 +0800
Message-ID: <20230712171137.3398344-30-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: ea790af2-8e9b-4052-a0ad-08db82fb774d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGVyijm1bY+dniwsqWZ/cdb1dLiVJMmer8R1gGcis7hymBbfEF+koooWBkU5k3Z5cKbmeCiki43br6Tb61gCes/Yvw8NPBHV+yAq/g8liLfL8Y43OiQyyofXwOvGB+DgU2h9JJ9b4CKXLuMjeUZLCg5D6HaKfnONAHOG+7Xj/4JgHkD0IpuVq4Eptm3iEF+U34g06Ij9stewdBioc51Xbxoj9RG68I2xbpFybmAJOg1S4WOQC03msld6HPTKey1kRWlIv/VFV92bLF9n0SRX3EuaU5NbfgYkv/RT+1vkJrFIWLBu/B+BDZ+pJ7Dz1TNmtn3KNK3K8Uwx24aEXYLHLpAWGsmOFO+r7Jz1Y6UWhH+TMtGsqoFy5XNvgLYc/VO/nI03Ih5bn/Mm0BZztC1O/b42WEsPeHowOtdEx/oWO9gGGLH+tFyOppeIsq7KATUGEhG6wd7WNSKhwQyLd+cm/TPwXAfJbaBYUYglsKlUoTIoA5pArCP6nM6bAdw5y2MngqfqG5/WEY43QalaDSN4R+qcIeEHhWY+Fz9ssWC4hsKHDap8NTf/MF2AChYUbpMqXqUaCtedaXsb0wtwI05LYgO6RkQZw3aQpJZKd5Unu4bbVt+oJYNsC1dlGZgFRuu3NtFAHV0POrn6CpqJXeajY77dDpA+qYt5IJ6CVw+TbzIq5dNpeEY65cOHU/H0QucFhMOZK7KMnb6WGGEIOZrMda78GrmlQzzMSwbSmaMuBsYd2EUp07C7yEP9esjwBIaFrQ6NxS4cud3GMMbzJjYPEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(316002)(41300700001)(8936002)(8676002)(478600001)(54906003)(7696005)(70586007)(6916009)(70206006)(4326008)(36860700001)(83380400001)(1076003)(426003)(336012)(47076005)(82740400003)(356005)(81166007)(82310400005)(86362001)(40480700001)(36756003)(40460700003)(26005)(5660300002)(2616005)(2906002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:35.2566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea790af2-8e9b-4052-a0ad-08db82fb774d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alan Liu <haoping.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why & How]
Re-enable all RCO options now that all known issues with
RCO have been addressed

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../amd/display/dc/dcn314/dcn314_resource.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 6a9024aa3285..9b8e0f6f32b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -908,15 +908,15 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.root_clock_optimization = {
 			.bits = {
 					.dpp = true,
-					.dsc = false,
-					.hdmistream = false,
-					.hdmichar = false,
-					.dpstream = false,
-					.symclk32_se = false,
-					.symclk32_le = false,
-					.symclk_fe = false,
-					.physymclk = false,
-					.dpiasymclk = false,
+					.dsc = true,
+					.hdmistream = true,
+					.hdmichar = true,
+					.dpstream = true,
+					.symclk32_se = true,
+					.symclk32_le = true,
+					.symclk_fe = true,
+					.physymclk = true,
+					.dpiasymclk = true,
 			}
 	},
 
-- 
2.34.1

