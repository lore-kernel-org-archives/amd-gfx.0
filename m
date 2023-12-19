Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEEDC46CA2
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 07:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5DF10E192;
	Tue, 19 Dec 2023 07:38:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CEB10E192
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 07:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+uUlgY74/B3r5cKpRnteqDlanLS34WCJYEUBMb4Q0Fdlkatvgo0rFbYd+M3ohOyEbHYzsoQCxUbEi+JcPQ/W9CC2fNz3gZ/tZ/y5HhB4xu8VAgrnFuID3V3ffoDsOYa57trZG0jrZTGSGS72jpqOBxFFgD3XgC4cpWe0Wd6qdsiUvCZQxgkdTGUqIPIw+4EPfXYajJQHBwbURImf62DI2vnnWRe3Xv74gPR7p/p0ronY8luif6fkV+LgV9o8ke6gJqja4N1f/vz7QZym9WoDHfL5NeN7kSPmIkBojUwey/iLCYKOVVlSO1o7oqDI2mymFGhT0sbYwLYpN+KzpIJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTuGbYEfwqT9FnLHT9pVTP1rNpoA0fokN4eUCOjUZUc=;
 b=k0vf9n4YA/tR2oMYRTHpgI45egUY4zClCxaxR03o3ao1yEA2WmEecfSZJnTwWWAIyTMA8eDMGMgq80jcb+V0fIfVipdYXY6zK4aHUVe/S5Zfugux/8N2NRyQSrRyu/lHlAv7JqdoIgKiasyuxz1mUCjec11HAaMb3EwlxaWI0ctSLluFLHuy++MpRUm96+Ti7IUif7L7qL82IKNMgGYaPp1cHbX0K62hFBgIW3AzAXXtFo3XMCyfgO4igrRkDRNdxM28A3iNY7ynxWuWe7m+aWlz531N2vd7FobZYbsveJZshm6isXCQLWNUt/7vv5lMQX4/GGVAhQaO2m9FboCr6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTuGbYEfwqT9FnLHT9pVTP1rNpoA0fokN4eUCOjUZUc=;
 b=ZPfYd+8gHvGUCbbYFETX73h9uMyl7IVJOA5mBB/6cw+rK7IUlb0vX4ozCtlO6kS6h2aqRYv7A0JlTIJo/cRy4erIIaWSUpF8gaHJmE25r69vfUP/9UTEq9WdMl4lNiO85RPc/OmHmK/UZGr3Ra5WbthYCwOG1aYYgSTFDpGo2jk=
Received: from DS7PR03CA0067.namprd03.prod.outlook.com (2603:10b6:5:3bb::12)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 07:38:19 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::42) by DS7PR03CA0067.outlook.office365.com
 (2603:10b6:5:3bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 07:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 07:38:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 19 Dec 2023 01:37:52 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Adjust kdoc for 'dcn35_hw_block_power_down'
 & 'dcn35_hw_block_power_up'
Date: Tue, 19 Dec 2023 13:07:34 +0530
Message-ID: <20231219073734.149142-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: c36fef69-90d8-4129-4c7a-08dc00657845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1V/ug8qspqjxzPYudRlEdIVr02qgtkdGgSzNVwLl25kJRYCLDe1FTCdAGKo3MXEBW5LLBV2k2a9hZGcE0eDezVnA+CuqKPqQBhNHHteNcxKKUVPuzQoVU+kH30+A8lZd9ayiHqClXOQDJ5UR6AsN0fimseOwtnR1pY0/oL85NkUaVZdAXeKVch4vBsGY4tZYaMhl9r+H5+xH5YpzM95oaPHVxaFHVRT2eHtwnq1cmdSmgDqA+1nErSMFNZnr5hQj7IoqUo9VVtHLL2Zu9kxfjvDljx2GcZlV3ERWxCBqzcsmz0qPkmLLDpMZY3sPNIz18FOg/P2cIEyv8VBS4Hgws8Vm+QY75En6Q7/K/awQ6qUrWV3APaZb/ljg44F8fB+U6fnSsgpKjFj8Dx53Vsim/Z9+dlYUGyOrreJFivyTGJnvmnf2C8+WVBaldlEP230DynuU26qh7RPh/5fUPXCLaeIsizxNQtlev5XAXTANMq1yiltK9LeuyODZeItJe5zWvWq/3rhTebT6Pd9E5YYQpBAPybkH13OawwssgPlzIMZK8KH4etILijKUhBW3rcrDZwluE/cr/aVZ7FHwqCl/3rzuOuVOJaYAI5JzJqvv9zDZMCkVN0IsYHXmiRAJLOK2OnN4Bf1gsVHm0DRg2uVpakS7O8hhK2gptA0QewfCd28MGbkscYp4FNgZ1NhdoQaXcFIXSdYLhx6WUlFUR1zit1JA199wP+p2P83S0IxJwBTdcIasfXxfzlTDRgC/LWC3dEKE8tN75FAk6mYlJfCsnFdIU3NOgXTFfUd5J1dewP1sbm41CHiuGVQAC5LENjKx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(8936002)(4326008)(8676002)(44832011)(5660300002)(2906002)(7696005)(6666004)(478600001)(110136005)(70206006)(70586007)(54906003)(316002)(6636002)(41300700001)(356005)(36860700001)(40480700001)(47076005)(86362001)(36756003)(81166007)(82740400003)(40460700003)(83380400001)(26005)(426003)(336012)(1076003)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 07:38:18.8490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36fef69-90d8-4129-4c7a-08dc00657845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
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
Cc: Charlene Liu <charlene.liu@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Srinath Rao <srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:1124: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Charlene Liu <charlene.liu@amd.com>
Cc: Muhammad Ahmed <ahmed.ahmed@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Srinath Rao <srinath.rao@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 66 +++++++++++--------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index ad710b4036de..782c26faf276 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1120,21 +1120,27 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		update_state->pg_res_update[PG_HPO] = true;
 
 }
+
 /**
-	 * power down sequence
-	 * ONO Region 3, DCPG 25: hpo - SKIPPED
-	 * ONO Region 4, DCPG 0: dchubp0, dpp0
-	 * ONO Region 6, DCPG 1: dchubp1, dpp1
-	 * ONO Region 8, DCPG 2: dchubp2, dpp2
-	 * ONO Region 10, DCPG 3: dchubp3, dpp3
-	 * ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will pwr dwn at IPS2 entry
-	 * ONO Region 5, DCPG 16: dsc0
-	 * ONO Region 7, DCPG 17: dsc1
-	 * ONO Region 9, DCPG 18: dsc2
-	 * ONO Region 11, DCPG 19: dsc3
-	 * ONO Region 2, DCPG 24: mpc opp optc dwb
-	 * ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED. will be pwr dwn after lono timer is armed
-*/
+ * dcn35_hw_block_power_down() - power down sequence
+ *	ONO Region 3, DCPG 25: hpo - SKIPPED
+ *	ONO Region 4, DCPG 0: dchubp0, dpp0
+ *	ONO Region 6, DCPG 1: dchubp1, dpp1
+ *	ONO Region 8, DCPG 2: dchubp2, dpp2
+ *	ONO Region 10, DCPG 3: dchubp3, dpp3
+ *	ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will pwr dwn at IPS2 entry
+ *	ONO Region 5, DCPG 16: dsc0
+ *	ONO Region 7, DCPG 17: dsc1
+ *	ONO Region 9, DCPG 18: dsc2
+ *	ONO Region 11, DCPG 19: dsc3
+ *	ONO Region 2, DCPG 24: mpc opp optc dwb
+ *	ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED. will be pwr dwn after lono timer is armed
+ *
+ * @dc: Current DC state
+ * @update_state: update PG sequence states for HW block
+ *
+ * Return: void.
+ */
 void dcn35_hw_block_power_down(struct dc *dc,
 	struct pg_block_update *update_state)
 {
@@ -1172,20 +1178,26 @@ void dcn35_hw_block_power_down(struct dc *dc,
 	//domain22, 23, 25 currently always on.
 
 }
+
 /**
-	 * power up sequence
-	 * ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED
-	 * ONO Region 2, DCPG 24: mpc opp optc dwb
-	 * ONO Region 5, DCPG 16: dsc0
-	 * ONO Region 7, DCPG 17: dsc1
-	 * ONO Region 9, DCPG 18: dsc2
-	 * ONO Region 11, DCPG 19: dsc3
-	 * ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will power up at IPS2 exit
-	 * ONO Region 4, DCPG 0: dchubp0, dpp0
-	 * ONO Region 6, DCPG 1: dchubp1, dpp1
-	 * ONO Region 8, DCPG 2: dchubp2, dpp2
-	 * ONO Region 10, DCPG 3: dchubp3, dpp3
-	 * ONO Region 3, DCPG 25: hpo - SKIPPED
+ * dcn35_hw_block_power_up - power up sequence
+ *	ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED
+ *	ONO Region 2, DCPG 24: mpc opp optc dwb
+ *	ONO Region 5, DCPG 16: dsc0
+ *	ONO Region 7, DCPG 17: dsc1
+ *	ONO Region 9, DCPG 18: dsc2
+ *	ONO Region 11, DCPG 19: dsc3
+ *	ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will power up at IPS2 exit
+ *	ONO Region 4, DCPG 0: dchubp0, dpp0
+ *	ONO Region 6, DCPG 1: dchubp1, dpp1
+ *	ONO Region 8, DCPG 2: dchubp2, dpp2
+ *	ONO Region 10, DCPG 3: dchubp3, dpp3
+ *	ONO Region 3, DCPG 25: hpo - SKIPPED
+ *
+ * @dc: Current DC state
+ * @update_state: update PG sequence states for HW block
+ *
+ * Return: void.
  */
 void dcn35_hw_block_power_up(struct dc *dc,
 	struct pg_block_update *update_state)
-- 
2.34.1

