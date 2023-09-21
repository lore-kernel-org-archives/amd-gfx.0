Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD23CD4959
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 05:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC82210E06B;
	Thu, 21 Sep 2023 05:55:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC9110E0BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 05:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks/VeNz+povE8cRridAA4GVeRVlDkXJ67suS461YmsyqWBVGqUHC78RHNSa9RvUpgcsMvx0fE2g9WKLSCrmNt/9szgJBRFS3UTv+FhlaPUF8X9i1rcq8Zc7rdHAeZbikWliq5bTJ1ZtnT6ur76igphStVIIoei/8Mpeazx0lTB0zv5ZEk92Xkxlub46RipX1i4wxwcOswYhulerHcTPblp6hhcJvJeaxM3GxNHUim/aGJMJn2FEFdhloZLaUe6BvzSpRcqt+1fLC0XWE7j9VsDeuT8SlzLr90y/REoYi7z06Q3FY+FkV7HFovvQMhn3GSPyxLu7ew6DCYIIa7iJBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G/73rgKHMBmjOU2MBLjhbdWgsJ59O8nrTazL1wJQ6g=;
 b=GnV7TCRK3CgBc4Ub6wcluFK0DkaWpEYZ4ViG5P24bwOZrouDv8PTxXnzVltkURzkw30CmlSUyviDAQzhaJARNO5Y+Y+NUuci9q7DZn2JEe6ZjcPm3bnhgEanbSL2PJ+x/9uQ4HLCv86VGNGzW6FGYKc01FxsgVdkPHVhK3iusI3TTNIs0eq885JvhiSG+5GKF012WrT4lBB1Df3FShQWzFhFXNRyslLSpZVyQ++844aUC3IzRq1ZbuNxQmneoCQiIxoA+2IdgJ//bUCO82a7iT97cOjJqvIVgr6A7YPupMY6Vf+j7gLbYLtk/TxxgUxxKJfFVdtv0OJA3xg25SI4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G/73rgKHMBmjOU2MBLjhbdWgsJ59O8nrTazL1wJQ6g=;
 b=s4OspRuGSlq4xtlrafDnee4unfqzlMKrZvaeelrBl/OaSyG0EHj5QbKO6nsGEV77KE+sANYUyFfzDxfu8a6+tf4hGkUsce/ZrqkGq9mI9Oj63e16qhysZdvJ+6ivoQ0LYSLui+4LyjuzhL9LPNkhfUohVklxIpkxyYE2y9ap67U=
Received: from DS7PR07CA0002.namprd07.prod.outlook.com (2603:10b6:5:3af::8) by
 SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Thu, 21 Sep 2023 05:55:30 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::42) by DS7PR07CA0002.outlook.office365.com
 (2603:10b6:5:3af::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 05:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 05:55:29 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 00:55:24 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct gpu clock counter query on cyan skilfish
Date: Thu, 21 Sep 2023 13:54:21 +0800
Message-ID: <20230921055421.3927140-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921055421.3927140-1-Lang.Yu@amd.com>
References: <20230921055421.3927140-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 17bb6f03-fd1f-47e2-f75b-08dbba675c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqInRyKUJdpYj8+zVhnqt/8VWwQJzMhe1Ko6OA2G1Xy8r2aKp5HZOe3U47eCCtMKWzncUR75dNmF8ia4EMbFnH3vr0gd8tNB0jQi1ol52gFOL+4WPgqh1uKWQv4X0DbIzzlF67KApUn4vsqg7+ntAnezbmi5RR0sZL1J4iODWVycd0lqLOVuoO8c7VtCZzO5IvNVg5hmjx8e6oCiKEo3SisLvUFIOfRgPjjzD6JabRgONa9zqYLwqhiEo2tCyyO9goWH/hvUfOrIq2Pr4NDj3EF5kTvqfAiRBWlMDdEsChvSmThWtojNFNApeF2sr8ZvSiqluTV49Lxo2ft4t4ILn5RF7UfpmTEJBipWU2A/EpA1Re7YFnIowIPuYJC1jGwe6XyQNYidtWAAErnJZBji6NysOkldRDNKzlIAS29XYOPm58rqOKvrBFpgjLfkKfF+As+tCe2J9IxDvYjv2QuSuOBBkVdlpoTUxa3vyuykEI9c4QplL+KWJRnO248uHwMw2J99WYTzcehWHRrr2kcPqCLeCZDIIXJp4qsbbE0UbWphp5tZn8JBLPnd2k9QfA5apwpJmWjPbHjQJAq0yVUI7m8W9lTxuE91mGtGzFNoU+K+aCsoyG9nh4GVdUuuCT6ngk1Cp8eyPxocFG4BbZsDR3Sq9RTpB/fZOAc4vJRo6YuY09vXO+dCXSxm48zt/UhOr8R5qCVAc98ykXg64oyZZTAjPuH3zTVQoiAwv0773ND2lgYfRX5XCN9tsupCpMoaWF17PvfAYoDBZjE23Q04xA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(8936002)(8676002)(4326008)(86362001)(2906002)(41300700001)(5660300002)(36756003)(40460700003)(83380400001)(82740400003)(6666004)(7696005)(478600001)(36860700001)(316002)(356005)(81166007)(47076005)(40480700001)(70586007)(26005)(54906003)(6916009)(70206006)(336012)(426003)(16526019)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 05:55:29.8498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bb6f03-fd1f-47e2-f75b-08dbba675c7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cayn skilfish uses SMUIO v11.0.8 offset.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Cc: <stable@vger.kernel.org> # v5.15+
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1d671c330475..c16ca611886b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -102,6 +102,11 @@
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid			0x1580
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid_BASE_IDX	0
 
+#define mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish                0x0105
+#define mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish_BASE_IDX       1
+#define mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish                0x0106
+#define mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish_BASE_IDX       1
+
 #define mmGOLDEN_TSC_COUNT_UPPER_Vangogh                0x0025
 #define mmGOLDEN_TSC_COUNT_UPPER_Vangogh_BASE_IDX       1
 #define mmGOLDEN_TSC_COUNT_LOWER_Vangogh                0x0026
@@ -7313,6 +7318,22 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	uint64_t clock, clock_lo, clock_hi, hi_check;
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
+		preempt_disable();
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish);
+		/* The SMUIO TSC clock frequency is 100MHz, which sets 32-bit carry over
+		 * roughly every 42 seconds.
+		 */
+		if (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish);
+			clock_hi = hi_check;
+		}
+		preempt_enable();
+		clock = clock_lo | (clock_hi << 32ULL);
+		break;
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
-- 
2.25.1

