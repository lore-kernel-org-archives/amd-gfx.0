Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AC7EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 07:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A25310E324;
	Tue, 11 Jul 2023 07:28:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6FD10E324
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 07:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBRPbyx+teaVdS0/C0GaIHqJuD9pSIbIH1FFgNlLMQ3kt2G6HNZwYXgh8V16eTFozRhz+xKzxzegRSbXtVgPCl/z8/OhyVhUIs44cMbrI1CMtCBGCwTQp8Lorhe4unVgke5fSUA3GGGAzCvre/AceC92mE5ZonWMA97QWw+lOQ+qxo0vfCITXd/FDmLu+ahmlk7L1Y6a8+mzspQoj/U+80je0PP2oqZhv5AqgWgLXfTsseIyafC1GHmGWH8k0HEBsSWodLEybq0ngDWUy6YLnqiDpwLgTTdpR0XDr71TaRgLgBzPNj0wgF1lMPSshMy0rjnuAmHuggL+VSd/G33Z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRiHF3tk30lhhEm/n1mUhjESP+SxA+4mub9RCy10atU=;
 b=P57+X8pht4raZT+Qbwvm0KhBepJDg95+VSY6F2b/c0fyZfrMy4eJY2MUpOHaNZLCIXSo8abQATdYhfvyU8xHS3pCUD7n/NstjkLYQ1bAxnvy+YeHy4KHVvAhJcRLUJ3HM8QMgAnT2zTCCACS+cwbEng7gCJeNA25TAUmZnnXK/fHt/eNSrBLN2s+UXSUs2JP9HxdDTpqayk+icAzSzwthblOUzxBUwntICecypfY3/k20vs8qnuqkcrEQ/ha8u3XkuFS3xTrW+FGg+tK5XPqTyRSO9QzKe0myiLGjKTlUAQkKUANGy6xzgMNBCrpSGWgwJc5S5GGMys2tutclthrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRiHF3tk30lhhEm/n1mUhjESP+SxA+4mub9RCy10atU=;
 b=HTVsk7+lLOMbdx/X6N1ieymDNjEJuEtGJU1me5f/V0myTZUH3dlxmGjY+zglH615xxdJonL347oekKaNstYo7w9BtIz7q1OttElyqeybNMkHSQ8dykmw8hwZsV2jX4HOiQJbOYqU50DrlP1CsRU0cJyOS/Y0CN4lx/iewjWImt4=
Received: from MW4PR04CA0107.namprd04.prod.outlook.com (2603:10b6:303:83::22)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 07:28:55 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::51) by MW4PR04CA0107.outlook.office365.com
 (2603:10b6:303:83::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 07:28:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 07:28:55 +0000
Received: from llvm-tr1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 02:28:52 -0500
From: Shirish S <shirish.s@amd.com>
To: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: enable/disable PSR feature at run time
Date: Tue, 11 Jul 2023 12:58:37 +0530
Message-ID: <20230711072837.41854-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 09001369-2386-4610-006f-08db81e07bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4LvvC8Jcb/Icvtc/MWg9VqOnd/yxWvGps3xZyIbt1pYT7iBKG55J46bGIbuWbsO2nrB5SumYdjwYbHUZnHmG0qRf1SA0BFymq/0FRoNtLm2jUrBxrAlwWBu1sOy7FpmGxtuCf4VHcQ3FmwofBmaC54nQ6d0/PivGZMAMVju9yrqufTZGJ2IQV0UQXt6V+xtOnNlwN47Qei9+ZQ9ex1xngFil+kt8BThD2qmo/IC8yw//FAtJoZGlqMKY1Kw5ZzXr3Y/GX4YAzIjCBsa/9jWFc+y9hpL+bMzuRRNeYP/ZUINCj0a23ysxJgWm+BsHgS/SeYoTrYFe/+RRHA6w7pgaLEiAXMLIam+R31FlbmV+vqw025H3YXb7vc2uPUhJt/qPqN2Gf/OwCrHlY3BXqWXHGLTezkaHt3N17BSosjXq7RWk4yAhJ6UlFQWYnZRGdiz28mykY7d3FNy+bno2SkRpysv5RtuTlNbGXNdoHvUu05DMhZ/HTk5clIeG/FfW4JZZL6hKt/f3XPeNQh7WYAjYp39LjH+5aBEFh7rnZ+MkCl294ZTMXQaDLAGhg85duBIUgm38wSP17aeE4BcI8LOp5M1NpWhjh+7XMadFMZRaHJjEYROaTX96mDPeJg7uzgY9DX6frpxBHS/xCsuu2AF1kpUUgdEvGsb+r6V7LxJ2HlL1+WlXFowFQa74hduaE7SC9dg7xd2hJxFzgT+/FAa5vXbG2i+2B5Wg3HWysxhRh8m82bDl/hqW/bRxzyO6ScDGSkZKODy14mTA4VuwtVHpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(82310400005)(82740400003)(40460700003)(40480700001)(36756003)(7696005)(6666004)(54906003)(70206006)(110136005)(70586007)(356005)(81166007)(26005)(186003)(1076003)(2616005)(5660300002)(316002)(2906002)(8936002)(8676002)(16526019)(426003)(336012)(83380400001)(4326008)(36860700001)(6636002)(478600001)(41300700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 07:28:55.0529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09001369-2386-4610-006f-08db81e07bc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Per current architecture, PSR feature is disabled by default for DCN < 3.
This makes it impossible for those pre-flashed device users to try newer
(psr capable) panels without altering OS (boot params).
Also on Chromebooks its not sustainable to have custom dc_feature_mask.

[How]
amdgpu_dm_set_psr_caps() in its current form does a decent job to evaluate
and discard links that are not capable of PSR feature.
If the current implementation has gap, going forward it needs to be
addressed either by adding appropriate ways to detect and discard the
panels or by iteratively blacklisting the same.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++-----------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 073bf00c6fdc..0fcafe1a071d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4313,7 +4313,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	s32 primary_planes;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
-	bool psr_feature_enabled = false;
 	int max_overlay = dm->dc->caps.max_slave_planes;
 
 	dm->display_indexes_num = dm->dc->caps.max_streams;
@@ -4405,24 +4404,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			      adev->ip_versions[DCE_HWIP][0]);
 	}
 
-	/* Determine whether to enable PSR support by default. */
-	if (!(amdgpu_dc_debug_mask & DC_DISABLE_PSR)) {
-		switch (adev->ip_versions[DCE_HWIP][0]) {
-		case IP_VERSION(3, 1, 2):
-		case IP_VERSION(3, 1, 3):
-		case IP_VERSION(3, 1, 4):
-		case IP_VERSION(3, 1, 5):
-		case IP_VERSION(3, 1, 6):
-		case IP_VERSION(3, 2, 0):
-		case IP_VERSION(3, 2, 1):
-			psr_feature_enabled = true;
-			break;
-		default:
-			psr_feature_enabled = amdgpu_dc_feature_mask & DC_PSR_MASK;
-			break;
-		}
-	}
-
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
@@ -4471,8 +4452,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 				amdgpu_dm_update_connector_after_detect(aconnector);
 				setup_backlight_device(dm, aconnector);
 
-				if (psr_feature_enabled)
-					amdgpu_dm_set_psr_caps(link);
+				/* Determine & Set PSR caps*/
+				amdgpu_dm_set_psr_caps(link);
 
 				/* TODO: Fix vblank control helpers to delay PSR entry to allow this when
 				 * PSR is also supported.
-- 
2.17.1

