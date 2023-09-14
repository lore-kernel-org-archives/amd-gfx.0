Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD4CEE0203
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DABC910E21A;
	Thu, 14 Sep 2023 02:01:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88A010E219
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxjhNEnYmuloYc7lvjExXClR+3UqhVWn0K4CNqekqhJtTpIiek3H2CUwt0h8y7Ex9/0tQ67+WlutnU/brNFEIe/e260uiUjhZBLOk+5zGrQd8uc9Co9JbFARaG1qLGnNAQXGPa6+9hPxsBNCdGqadeFqmlvfQqk7w7HR9tXQNe9UtoAR6Zug3OsMn/UE5mWVk/tgNdLUowfc7c4k8mKaIVW2cykotEQCSWFdgXDt+ReaMFesfEFRcve71EmNjc3uyjFovo8B+H31Il5MYwlTmj7tm0aPBIBU+HAPCLS7DEOunXqnDwZiV5my0v656dhhC5WsUpaVc1BSdyh1pzvIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+ySXnaBD9uga0TTat+OZFk5EdmAMI7knWAZ5EHVAgE=;
 b=WnSSfiwPWhVBKSGDvCYc2k/KfhBK+RRPsRgEcjRbkHiua1vcb7zTqBFR8mRzqiWBwneJcH6CCuFoS9CBG/BmOVSWRXn+33aXENGXW4iR9C9EgvgdGBeRf37Z/FKtkCYqgLSmMDpoiFmenTUgV8nyqOy7pr0XEXEZjiEehfNnFs4ebVyBmNVP0KmroPotd9NKq+Rsp07cY5Rq7mfbvHWAmX7kOWal/5RGJXhKtlSjgri3YDoRLhrFc2TI/uwOX0bw73R41JvZg9Ywcpt1VPy/96nTS5+4vJrGzOGWrIkcdFxPF6Djh2xFi7jRqyPvbE1WgBndb1fWWN/SzF0WFdsnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+ySXnaBD9uga0TTat+OZFk5EdmAMI7knWAZ5EHVAgE=;
 b=EBg/6h2q0Fy6k3Eon29rNb1rYvZu6HPVhNSj9x7DzgPtiEj4F1km2oRT0iDW1H2nwKPdRKvqoPHynRXbUqnhjTDjXoGsKcWbJ7kBcqAYQoPciyuo/oqu8Th953yaJTzuibnlmNbqSpZnvI9ClkL8k6vtG6iLSlJJNV0KeutqY84=
Received: from BY5PR17CA0009.namprd17.prod.outlook.com (2603:10b6:a03:1b8::22)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 02:01:31 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::b4) by BY5PR17CA0009.outlook.office365.com
 (2603:10b6:a03:1b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:30 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:28 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/28] drm/amd/display: Enable DCLK_DS from driver by default
Date: Wed, 13 Sep 2023 20:00:00 -0600
Message-ID: <20230914020021.2890026-8-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 60dc1c18-d816-4c28-51dd-08dbb4c6838f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rl+Fq5j0CmIJCMH2mOyaCmOcupsN9KsrNQTBnTpvHZg15rToWSag1ID2ZJquCMu29Zev7MUmibfrh133qVCfje0ZDxE6gBPAHMnjOymeeMlU5iAnCBTpY1bnBxY/SekAW4osqRTZwXZuoMb/Ad8maDE56vUwy8EsKeOGYDuz7Ry+lG6TpT0tTRfoVkCBVnzZEA+SFp5YluWgO9j2JicUlGF640ih+jYQ7yOBmaNl7XbnytJlKtqVEZJclEUwHAu9doQO7KALmhV5kjlrhT/kkh94q0rACrG0DLuHTTPdHaVZDW3wGWWKAvvDTeBzsjT+sJhHCs6uVcpblgg0DG/yLX6NxTeuX9gp0QGwQTsbAfRKoXlmsbIhdV0lIfI9ZDp7K1cDgxnAP9bhrtEDOiteLQeMlOA7B1VqK8avayxs7SEVzsp34oyyfJeN/Z5SmvJR2MBdNjN9QMlXxI1FklbYr04PEqoiRDteByA15ScktexbS1rnM1DAJva0qda/t8R8JE0GK7y9L/w34/04n8T/HW4Vsix7gMzsXas2z1N/4H5oIpTnyVSqL86wPSd7LkhJO3fmLbB6dWYliDK8/IfGPKsl76qUdsqCEuoirIy0I09yA9mNu7hGe20DLVgFN1IRWoFEmBgZAh4sksXJ/feaU9BbinYmzTHbgykwvq2OStXmwsTUtILHd+abYiXpaQ9mLtII6ALU22YS5LFJ/GQGcJ00j9YV4OuUa7XcJES7d+s8iQdeKSdzqpi442bpwB2tBi8Yc7b6BT3bxpFFo4SE3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(8936002)(70206006)(70586007)(8676002)(5660300002)(4744005)(6916009)(316002)(41300700001)(54906003)(2906002)(478600001)(6666004)(1076003)(16526019)(2616005)(26005)(4326008)(336012)(426003)(47076005)(36860700001)(83380400001)(81166007)(356005)(82740400003)(40460700003)(40480700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:30.6164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dc1c18-d816-4c28-51dd-08dbb4c6838f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[Why]
pmfw ungate this feature, this can be enabled now

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index 8d870880ec15..9bd1e86901ec 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -230,9 +230,6 @@ int dcn35_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, int re
 {
 	int actual_min_ds_dcfclk_mhz = -1;
 
-	if (!clk_mgr->base.ctx->dc->debug.pstate_enabled)
-		return -1;
-
 	if (!clk_mgr->smu_present)
 		return requested_min_ds_dcfclk_khz;
 
-- 
2.40.1

