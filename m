Return-Path: <SRS0=AYlF=LA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7FDC4743F
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E2F61420
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E2F61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C0B36E51C;
	Sun,  6 Jun 2021 05:00:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3726E51C
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jun 2021 05:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBwO+LfRdtK7fsw+vPcyje5wx/Uue8uW+09VheHuaUi2eAJu+/IDVGsi3chHfiBgObxlyd/nFnd/pat1fKpxPuevwpmTz8kbRjp10bN3o//P5iVkJAnw7hnUDLjiy9rJb6IOvSwYpfPgPt4w68OcGp1qAsZdPfC7Ixh8KZ8m1rKzhCvwvJlyjUv+H0u2BRWj2ZXwzGdI/VsJJKFMcq5NpgIgUkJK28whRiXPr/zHNWAOibZIuIn/xFEP4gaVFHfbHrwExGkos4rEc9tvHui8BhH86dQ54tv4hsVxaUEVg6bpiPw7EjOyvFuHJQ65E3dkm/w3yzWidVwWmmnnqdLcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysKZdgG5+UR7jPsjqML3N3tugQShlpeUGGEHAMTGuMM=;
 b=itSjnp5VtrxTC8MNZGF7dJ6BNcVgbZ4cV2ojYcnldLmcbvyAgdJuQsCqWxhl4wTeqbQ887xdjj9qTC5Dqu35/3ZLV50yIppzU0AT7bXthAeFq02KJG1AIenFKmws0I8ueyg5MJ9t8n+TplN7gLOnnf++0LQhOv8K4yLLuntlzHC811V1SoG6vnBMypTqFSSB969Wv5krZwS56wbIpnyK3eVizCzp7WxeD/A+8NlvoTGz0U/+DKPSVXtdyMCo4FyMVYBkIjEaItSGfXWol0TKRXneKwzV6APUiu+EULcNulAB3HZqy8CvXuy8HNh9vz2SIKnprrL26Qcn9K3K2QdHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysKZdgG5+UR7jPsjqML3N3tugQShlpeUGGEHAMTGuMM=;
 b=aDUx6udeeM+zGH76WQQIhu3TX8aycWIwEEMIP0wEnWut2Jo/A7kOOkCLqG11kTCxWCrMQTYW1+vEOGOTnqOKIcA3FeofwdefgqgqUPe7/ysC3UGntI9rJlqfTnrvGyurcbS9CvcXT3tOPoMEBYhgkreiOLn0GTGUaATOJPAs4yI=
Received: from CO2PR04CA0117.namprd04.prod.outlook.com (2603:10b6:104:7::19)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Sun, 6 Jun
 2021 05:00:47 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::2f) by CO2PR04CA0117.outlook.office365.com
 (2603:10b6:104:7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Sun, 6 Jun 2021 05:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 05:00:46 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 6 Jun 2021 00:00:43 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] amdgpu/pm: handle return value for get_power_limit
Date: Sun, 6 Jun 2021 01:00:22 -0400
Message-ID: <20210606050023.4124-6-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606050023.4124-1-darren.powell@amd.com>
References: <20210606050023.4124-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c2cd74f-707d-4a97-15f4-08d928a80bf3
X-MS-TrafficTypeDiagnostic: PH0PR12MB5419:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5419C365366834BCB8FACD44F0399@PH0PR12MB5419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cju58eyPFWd7YC3aNSxbcIz9dxfrtxMVvaQYxQbd4MuiA2HTLDVDivVElF89aauFnoijdkjgWeugHc0MCOqZ54802+Mg+WixBrVT1RvRvKpb9o0qheEY51JaMtswLywCMtqX+4fbAHuoly5fAEZHfMOChpNDKpcrP8cPbroOZ52yNszZAF2xKFT0yXXgEWoiwHTcy0GtAFHufulhsMqSTQiDwt47WsYIqtPmWn6UyxJpbX5Vkd5Pf3jjMix7n4PduU4kkIOSeQQTfPODLvEQ2VTe5fnWjoQANlOzkjwDbabcwPL+/u5lPTky9INEETrvjXN3lnilr0C6ql8pmFPZm9KG71EKccmvcOqfSrB5wLDuEIHCGxMikuUv/9yXvsttfk0BwgO/wQ/WQqkrTVBsTJHHNCEfLuPONyXRNiGJ8GLtL+4Wm3tC+2MUpgmUX6tSBZR262dymvC0c4yAEjKWehDtP2qqHLL1OPV1/zz2ccp2IcWYXUBw9iNUhrMr9zJWNgQtqRS1zMOpJbdObhsPyDSuVvT3J6ANg2d0dU71KBuZbBCb9oYYmeOiPwA+I3tnvRAtMteEzAOygQJ3x8/M+TabixwQ0iPpMsHemHkhMq3djIiQ9NFu0grnAd6+UXUFaUgXsoXcxe9AovOFNbM18H3mDDdMTlpgKY5DzQUgkvdcrMRNIk5ScJ6JgkKY8kvu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(8676002)(82310400003)(8936002)(1076003)(426003)(6916009)(7696005)(44832011)(70206006)(26005)(316002)(81166007)(2616005)(336012)(4326008)(47076005)(186003)(36860700001)(2906002)(82740400003)(478600001)(356005)(16526019)(83380400001)(36756003)(6666004)(70586007)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:00:46.8163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2cd74f-707d-4a97-15f4-08d928a80bf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 39 ++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0a788cb38ee2..b2335a1d3f98 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2924,13 +2924,16 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		return r;
 	}
 
-	if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
-					  pp_limit_level, power_type);
+	if (pp_funcs && pp_funcs->get_power_limit)
+		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					      pp_limit_level, power_type);
+	else
+		r = -ENODATA;
+
+	if (!r)
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else {
+	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
-	}
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -2961,13 +2964,16 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		return r;
 	}
 
-	if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
-					  pp_limit_level, power_type);
+	if (pp_funcs && pp_funcs->get_power_limit)
+		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					      pp_limit_level, power_type);
+	else
+		r = -ENODATA;
+
+	if (!r)
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else {
+	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
-	}
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -2998,13 +3004,16 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 		return r;
 	}
 
-	if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
-					  pp_limit_level, power_type);
+	if (pp_funcs && pp_funcs->get_power_limit)
+		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					      pp_limit_level, power_type);
+	else
+		r = -ENODATA;
+
+	if (!r)
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else {
+	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
-	}
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
