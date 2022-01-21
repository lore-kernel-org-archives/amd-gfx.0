Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06039C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 20:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06AA10E2E4;
	Fri, 21 Jan 2022 20:22:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE3310E2E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 20:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFdRY/bNhmvTa3RnPKGv4sBzLQ0vafjnrOabZT1i0SrGQACYixV4ljYUBIiuBREj07tA6jmeOZNnigvAFax0Xq227z7wSJxpcIkcejpyZcN0cEcYnvWyD/OG4oTR+fs+Bn6brbMMim7EEb9yY42vtzEbRs4Z9y9ssGYrB38yThssjcBNbswitY3LKRdukNfu/eogxqEOvr0H4OWEk5P+8V2f/UoNSJQpMxxCRgvwcIHExBpRpPu08g4UIqKvIPy1y78ctZ5Myd9rZEE0RTXZvWaqyru/098ndSsMiq47eJGpbwmu1mO2eav/8fcdvVgYjNmrT+c4rxjlOaDwuec84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/rrVeGvPVhDndHYic0O2VkZnICicI2NvPvHq3xOC0o=;
 b=gBXR/LMsmG0oxps1Ym8Sn6M/9y0nur0Hudrp6O7Bh4sul2TZzzEDMLAR2qz+734BF/af+8uwYr0SAobNi02jWIWj1gTewx0KskSIfMXtxRLsRYwNsowJQe9MBh69wIJ9eNY6HxIccbNgibS3XTkKn6Ncg815yOy2vxxVP5SZaTmNIKOpkOmkhCcUYzDAw2hA1h/hI2vfbJRVvaBXpLG7MlCo8b2wPEZHtI5pQ2EOYnuzlyI7o0HPKCD5028UF11zJN6AOQicXOwzn4UvYYHfGtV1Iru0yBFBMmdkrkmbVQLZpS6FHaA2yWgLG05CVRCzoJQt/BZpBPDC7Aqj6v96wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/rrVeGvPVhDndHYic0O2VkZnICicI2NvPvHq3xOC0o=;
 b=Q2Xa+Nna7LcQEViV4wa98j709wXJ24N7lvzJFshSLCkpl6fOolzymNDmjB6l0kJKCWdrG1liYvylDL5pHelA5ghh0RdoT/fzc7B47RqLqykUIEAQMNyWzYLjbsEPCmuRCpDw8eOSNyzkNeL+TixO1PB/b26tiWDq93zedzF4Haw=
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 20:21:58 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::54) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Fri, 21 Jan 2022 20:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 20:21:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 14:21:57 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/pm/smu7: drop message about VI performance levels
Date: Fri, 21 Jan 2022 15:21:36 -0500
Message-ID: <20220121202136.5541-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a09701a-072b-4cb0-1901-08d9dd1bacc9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4228:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4228FE2740DFEC8189293BEDF75B9@BY5PR12MB4228.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIB8gauN9oYxvT+l/nSumdIPp20kKXAxlWUj3JljDeqMH1q9pJtQ0W5ZFe0i5ST9oPTqPaChtnqE03yYE3vvu/P/C9vrKujFiJCXJFGzKpWWjHiPLT/n+S12EURRjz0Hm03tLKTzNCN0Lanh+RPoVH+H+XBCzzt/op9+LdFJa+y2+Ib0JSWepr6nsaT767o6iXJXy8VkuqbZ1bDAENI7hcPrnKd/aSDKf1Ub0ICt5fmAeGRN1s8J+z+Wyga6RRfYwv9+z8OoP7KGHBo9XT+mjjpIgfM6rjkfrXmMyIfe1yRPXIJHbyzP0VS9QeLjg56UR3FAP1sorOxjuworR+8ap92aRHh+grMq3JttMBQzfiP4ZFBKz+6FxaO1y7QJPXxpTDNsL53SkvxAWnDilalUwMZr8f7CZS6+PwEfPttB/+G3+LMj2yhSFHb9ENP3bwdsqFOkY+fobHk+A8F8gE3uvKamF3+gajEQwYSlwMjQu1r7PpnopewqgPZNs8AOoPZTXfvOU29w+JnCvI4x2g+7Y13OGxejTq2Mqw6uMuO52hHb8m5/bVm5LnMf8t8AwgS6T+W+cG6gkCAlj5iQP14DqFChIzTjT8doegsZXNE3Ut1+nuIt81xrBuwrlmx1gVgYp+0brKZKE86MfGOLIyMZ2rA3xKj5RgWPX6d5au3+JHf3lwfnnYV06bG3IbmRRpvkqCslQYxXHPp12LWdmQU+JrVGQn8E+JzMp9ls6karWfMG3cFtcgAjvx7GiYH93coYlPZiMJP3lur3tSZJimVu18Jvjr8KEQYaZKgILUxwpvU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(426003)(6916009)(966005)(8676002)(1076003)(6666004)(4326008)(316002)(36756003)(356005)(508600001)(82310400004)(47076005)(336012)(5660300002)(70586007)(36860700001)(70206006)(86362001)(40460700001)(83380400001)(2616005)(2906002)(8936002)(81166007)(15650500001)(26005)(186003)(16526019)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:21:58.1882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a09701a-072b-4cb0-1901-08d9dd1bacc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Earlier chips only had two performance levels, but newer
ones potentially had more.  The message is harmless.  Drop the
message to avoid spamming the log.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1874
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index cd99db0dc2be..a1e11037831a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3295,10 +3295,6 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 			request_ps->classification.ui_label);
 	data->mclk_ignore_signal = false;
 
-	PP_ASSERT_WITH_CODE(smu7_ps->performance_level_count == 2,
-				 "VI should always have 2 performance levels",
-				);
-
 	max_limits = adev->pm.ac_power ?
 			&(hwmgr->dyn_state.max_clock_voltage_on_ac) :
 			&(hwmgr->dyn_state.max_clock_voltage_on_dc);
-- 
2.34.1

