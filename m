Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28A1C71133
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 10:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BEDC10E0CC;
	Fri, 25 Aug 2023 10:40:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED8BA10E0CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 10:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDlzgkPMV7RjwlNUB8UXws00q1eDQDuwLUvtbb7usj7fOqd7EffCc3/dBwlXm099qGvCQinkD/Q6/tMg+9UW0OmqkBNS/Zxun7HRX+HIKacLASvOAZlzULqPyTyPLtkqyOiLTMp86tZgJG30RjZ92EDcylSHSbgHQzSxNN9npE5rAmCorlWE3PCYAEUzLWK0Ldc8uBA0SgKlhKz/e5DSEYoiXcFNiw5yXR4FoNauDruM7x8h9GQzSW2T0EOpODMeTSqwKjy3lQap1mF+fAQD0oeF0owTnd/LPIr58O0uJuS8Hq3HcNvXwLO761QCZ17Tou7ilX8KMpJJVXs2nApN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIGNgE/S/rhO99j6TU0pjnFysBpBgxy3FtM2R7e6M10=;
 b=JkyAuhiS1qemrlEKsBAaX9Dgyb4dzss9vGwArcoUIhJNRIvHV6VRnyhBNSknPvSTLfoAUkbjbJhs6bBuXWqM1mQiNshJ2Y5LpxFlBNDziRdlH+M0RbjOSzP8zCDlB9yCKVjS5iiRu/vfxHUrBke0lv9Y3N6VEbHjx7v1jELVivv1NUJcExEKTLtwxwes2JCCNaX72NSW8YfGvoO0WWiigzF3oWTFgGSWrnfsOY5qovr3U6d+zCxhBhmB6BfpmAh6ZA9++PWX1TMajmkFbiVyES6GgI3A5tV83bNhZ6ktBGnodaGtdXZJFpAJIoPqwPbu87Zhuk2rm+0TeBSiePnGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIGNgE/S/rhO99j6TU0pjnFysBpBgxy3FtM2R7e6M10=;
 b=PE67rbEwGs9vaaIrm0LW2S/MW+dIsVK2MCUv4qHODnBAhQZlctMIFsDebkgtYELFU9iVu8VZZucXJoe7wFsDPO6pKhyBY3XO+jbFpIFJs4V/7toUbeUaLkQpTreBxG460wz0l4mp0Cr3tkDqo5lZ4HtRM++jJSCv2C6UMNiOgTo=
Received: from MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::7) by
 PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Fri, 25 Aug 2023 10:40:21 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::6b) by MW4P221CA0002.outlook.office365.com
 (2603:10b6:303:8b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 10:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 10:40:21 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 05:40:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Ian Chen <ian.chen@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix up kdoc format for 'dc_set_edp_power'
Date: Fri, 25 Aug 2023 16:08:34 +0530
Message-ID: <20230825103834.1176177-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c14f00-ff55-4fbb-24bc-08dba557aeb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zlgCekRRBhaxoBWha1O8RkzLHN1OCpvSqJXvn1jWrN/9HuW2HtcPqxoCUzTmUdf/YqoJ60oA9rCH16NNuWqKhdEsRKjA8JI7yHH4tjlM04cCeYkdm0KZkZ3JHGveU6nNeKX9eBZTWH9hvcl4YNV+g5SeNZJptpZOBc2+F3R0bbcYABJYjKBET0iPCW++q8du5Sh65H4PnejJOBFpiSAioSd+I3DC6Ko8J9ned9mSO5XRSA/t8/u+wKoHgm0qeq6zaulR7Bt6/8WB6UgyPs71myYZ/EGfjBHG+aeK0ySyyE3iW54fm3p1tGn5P7/k5sDZmSQaQWC9BpXZjQUE+Df01qnTUdYGELNo0YMZ58Zr+fuNQTFf4fJNOBz9qVAQSwxMyRIgsGrPAHahKi3OUwzvN/kaF5HFH+VrP2F40CL0E9kFfFrNAXyzF9pzC6cMl+5I1f8Og6Ix2cuWEFxrkH7gpctUPo4xYydIkwIH+2uNey+07sYEN5D/k+VZn9ThmwzOaaEoSLqX1MoKszEPAGd8A59vRFe788x7xAPIIEuNZb5fWEriBeBl0Udk+IrJxMwc9fWGft1umRaOioyixQUi4za0ANLurm9vCnqu1A7ebFmB5iaJbgm1S7OeVsHj1xe/HBe7lHCOpStNqGuLlBprmxrqTC2OHFbh7n20VIwzrJq3ww5CthdO97K2N0DZh6+eo65GNfFX/vxygJG+8Oo37qs0uTbTwciEyKHuWi7ofo+2zCVfR0R3MrNSdZtp+uQzh/9Jhw+beGitddCbTETg1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(356005)(86362001)(82740400003)(81166007)(36756003)(40460700003)(7696005)(478600001)(5660300002)(6636002)(70206006)(316002)(2906002)(54906003)(110136005)(4326008)(8676002)(44832011)(6666004)(8936002)(70586007)(40480700001)(426003)(336012)(26005)(83380400001)(16526019)(36860700001)(47076005)(41300700001)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 10:40:21.3561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c14f00-ff55-4fbb-24bc-08dba557aeb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following W=1 kernel build warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:5261: warning: Cannot understand  *******************************************

Cc: Ian Chen <ian.chen@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 025e0fdf486d..ed225e1a1299 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5258,13 +5258,16 @@ void dc_query_current_properties(struct dc *dc, struct dc_current_properties *pr
 }
 
 /**
- *****************************************************************************
  * dc_set_edp_power() - DM controls eDP power to be ON/OFF
  *
  * Called when DM wants to power on/off eDP.
  *     Only work on links with flag skip_implict_edp_power_control is set.
  *
- *****************************************************************************
+ * @dc: Current DC state
+ * @edp_link: a link with eDP connector signal type
+ * @powerOn: power on/off eDP
+ *
+ * Return: void
  */
 void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
 				 bool powerOn)
-- 
2.25.1

