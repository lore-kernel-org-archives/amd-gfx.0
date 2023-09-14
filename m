Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43324EE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC04710E4E5;
	Thu, 14 Sep 2023 02:02:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E7A10E4E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNgP9O9k+XacH7eKgsdrFj70Eub0ylCXvGmU0B3fb5lbmq7XTp0Fct6GVYgOg8Mf5WPUHDvZ1usAZYJIjJ4/+HtLw7cVBxQJhU+V5vfQifJQdSBHpLkgIbRu3E2mVHJ7E0fnzRlKPwUFWohLnpHydbJaS9/UMxxVyoljAKuFqDi8KmK/D1capX+vxWrWUG0GWiUXtu221cKcgvqE15P7cWJqpfsmzzwShn3ZB47vhrYNB2BCOu8jrNbDu/bTUCEvSOqnZCBROCi3AQ1VgRc7iX/3cgMtqYia0ENMjMjvvTgowywi4oImLGQzYHpe40OVzxDr6YfwdF0erS/aNxKgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEA5XV1LY2bPufno+eq0Iw6nbV5sBsgLyng/TS0qtkE=;
 b=dNBAXuy4tt4ckemsXkU0CMDPnVJBHtgmE3XtV8g3hghkGDQ0VKESYbJ+1GPDeTYTahkydwePNoRvQ2vwPcrgXRTWV5S6pgf6iV5w+MZPakilQASMw1tsRsxxlHQYPaCV70fcyGr3b4twOE8bwDW/HzxElfThT3LsjEz5197e7JNM1nhA8ThwArpQoqtsfWMpv+CRHUZr00PKPIH7zXPL5UZVNysiVZxtldeLnuRSOTnYE8/mSw5GI30UfcrxnwbwvDTj14jJih3Xu9mLsQ0LC3hgJTj9JavTLCYik9mGq2HvkXp4RZOB/Os232wulhejxR8Weq5uq7caBS1k/07foQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEA5XV1LY2bPufno+eq0Iw6nbV5sBsgLyng/TS0qtkE=;
 b=FOwEJWQMhwawltzA9rXL70en5s4f1myobTaG214O0KAJYPyRHqyWQ16BB1mORNmi1+9xDiiZvevEKEuAR3AePiSAziPCVtih7tJVPNlKS5ulQk0uDju4V+NtrHwLPvlbKc72hoK5IMfp9w18gCFuXr6XAdg7wFyQbj4ZV+FGWB4=
Received: from SA0PR11CA0072.namprd11.prod.outlook.com (2603:10b6:806:d2::17)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 02:02:17 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::b) by SA0PR11CA0072.outlook.office365.com
 (2603:10b6:806:d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 02:02:17 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:02:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/28] drm/amd/display: Enable DCN low mem power by default
Date: Wed, 13 Sep 2023 20:00:19 -0600
Message-ID: <20230914020021.2890026-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH0PR12MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0bc79f-70e7-4d3d-dd92-08dbb4c69fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYE71W0XaKYLwNchEP+aCENwoxRjxSQCmnAuiXsGnxc3IWSDyvqBuO37EaryD1pTUSpIPbZhcP8hbLz5p/Ulqz+ExE9Pyxp5cvIXI6j0dVAvtgESfzNqBgsU31NTDQrD2odN9vOBzIMkvA0tl308Id6zKH55NffLHroUKX8wt9gCDZJAOjCwa2MIBCZa1gRYoLGIhQp8rXJihKJzmpPuGmnwf0AZLyeJJ8y6YbnsLeWMRDeEkQYM6QSfmoEwVDa3+dD/Z4sB6V6Cq27iASKWCM7AFwACSbFPOh12/3i3rUYCoJoUD+0sFeuG9NXK7aP505n2O5DIo6BAKRiWeTHIsU0cL+IcCiC9TEqEfHHmFQRU57yQL24bxM1ZBeYe30a5iH41L8aJV6agAt3wyj/lEUvHZYg4LHbMwwwLg7vJvedCD0Xl3bI5oN9FBWNs5ANxomve5OxYPLLTPTTf5JymcJJXv2iuextXzSVdT/R1EWUwG1o22GH13UzcgjgPffFl/jeGmp5UghmlJAMhrzgXZCsEH/GBxq0e9yjt5LBnWtbh35aLrOcUYyOhtR7jYwobMgcOBj/I/+6Q/sz5dolRIHSCzgvUFnBpa9yb/xsgvJ1BPjL8Dk5LLew4H5I6Js5Ylq6I3q0ISyKr5mBr7M//BM4m6tGVUqKzxibTTR6tWGA0WCRCuHoqjDyjcB/jSFqJVs8y0uWOg5GCBUyTSHSS0tdmEVn79X032E1XrmL3NEDdc1w0jGGSKbD/v+gqj0Jyd0D/eJOeVyzt/30kCUWMcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(6666004)(81166007)(86362001)(36756003)(2906002)(356005)(82740400003)(36860700001)(40480700001)(426003)(4326008)(2616005)(336012)(478600001)(1076003)(26005)(83380400001)(8676002)(16526019)(40460700003)(8936002)(5660300002)(47076005)(70586007)(316002)(41300700001)(54906003)(70206006)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:02:17.7862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0bc79f-70e7-4d3d-dd92-08dbb4c69fac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

Enable DCN low mem power by default.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 4a0bca134581..961af9e7d5c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -749,7 +749,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.dmcub_emulation = false,
 	.disable_boot_optimizations = false,
 	.disable_unbounded_requesting = false,
-	.disable_mem_low_power = true,
+	.disable_mem_low_power = false,
 	.enable_hpo_pg_support = false,
 	//must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions
 	.enable_double_buffered_dsc_pg_support = false,
-- 
2.40.1

