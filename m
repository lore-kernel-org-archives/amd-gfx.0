Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CDAC369D1
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 13:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B686510E6A9;
	Wed, 23 Apr 2025 13:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h1CMkiNh";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 976E810E6A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 13:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4iwXurdYFChykFw9iY5rDv9lX03eY3Knbu4zeSHGR6fkN6cHTcMqyJ2yqtfqP+sAX9hhsosan9KdTGV05IRdK3h6Lj6/XeOch6EPhwRSbIoLxJun9s6MJhilRo68cFFxvpPlbAMXQNTqpBnlxpYUP3pKLg4S18YCmOCmavUdc6KEE1yg2DUpXhdr7n/wDKcbZpFoEIGPhks3vh7+xuybFhpu/hjLZ81w1inkx0XMu65vRoopKc+JQrJBD1IgCHC/cmW3Yup1xuRtUMO3xemzEDf9bid6H5AoEMvCayWmLZHf1HOL4QRU5fbIhfQlvC9iHxoMt2MdSUvSEhL2dCpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdTM7kHLsSTtDHRffDKfMM3r/4jTWWfM/ollTTXGKVE=;
 b=LhbQQBj5tP5x0piA4CG/C90iTkp/bqG3nk3B2EtnoEDPjMMtnkOAz/OMwVKg66t5R1fhtUjUviY+AYToykelcwwD0CRHsBwGeUssuP8GnbIiGwytAwgs/B4meIMaL+vEs9sPBlJwUELSvlxh8UHjlXEOYzzlF0VKVPUph6Aw54JmWSLOXxwTaFP+DTO1nujryR/HR4e+nABZBxwNdRoHPSaydFgB5dMd8FymRbXUU3M787OGLgUZQfZp8nXxK61DaHBuv/nGBxlYQ3KAEyplVAYYwVUBfX+3d5l8/5sFTJ7rTNEig4uQIT9jSwdKp5hRNmtu8wKZJDz7jAjyQ06tKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdTM7kHLsSTtDHRffDKfMM3r/4jTWWfM/ollTTXGKVE=;
 b=h1CMkiNhXD2M7Nch2rbcwwpMv/jBXSK2duXzTukYmwAC4A+YlaWVjeeWWBbi36MjIH0aSlMQ+lha7Fb/8gFVkttb34On/ZfBvabqQSZotruKy+pqsJfYnHgweT50VoBVJTImVxCPLNhKx55VhHEB0ZQXL7HTTPqG7n9OF6W3HTY=
Received: from BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::35)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 13:32:12 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::74) by BL1P223CA0030.outlook.office365.com
 (2603:10b6:208:2c4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 13:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 13:32:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Apr 2025 08:32:08 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Yihan Zhu <yihanzhu@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Fix NULL pointer dereference for
 program_lut_mode in dcn401_populate_mcm_luts
Date: Wed, 23 Apr 2025 19:01:56 +0530
Message-ID: <20250423133156.3877781-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ede460-471b-4cba-f7bc-08dd826b4101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CfFhwwDxJg56U/7/VhqZMZ7ztvN2P2i9fvpGZCxKnRfeGUDCalTubmMPch0y?=
 =?us-ascii?Q?wyC1DjxU4DLewnuvMbyMMcx/Co/PimZrPkoiZAC7zihrF7um5WznceaHh+Hu?=
 =?us-ascii?Q?UpFY4tzDCU/lupVdKeUaTBwz1byFjJ9TM/3LEkhvyOCRqHSohsAbJMq2K0Mz?=
 =?us-ascii?Q?q+GNCDGwHPTrhcEo4IBS4ntLfrn8RmH49lioLM6X8bcieuYauv2KWoZQf2P/?=
 =?us-ascii?Q?tlKUPwg0rN4RXQSs99snPm3K9ycgcPKoilgLVn6zbiDF4CHTVrWMfTDacoxN?=
 =?us-ascii?Q?j1ZKKjPgFJmTSD7nMV+O2XDvXgC7Lt34w2wyEYjSxaAHQ5GelxyrjWsZKEI+?=
 =?us-ascii?Q?alTygSggbAGK4LJ0AfyB322iBgCE9b4bSkqj1vw3/VkSeEsgrbebrZkJIGDH?=
 =?us-ascii?Q?hzWkXnQZb7cDsRP7/uSl/JCEptqxBlod9CctjgjPvZo1fjdb9n6CXYlmfkw0?=
 =?us-ascii?Q?R0NALAeWBoYHI/GPuMmZaq+nZPlCFX0zK09H+/Y1dS70P9fgwv7uo6y/Jr3t?=
 =?us-ascii?Q?YQqphmHU6QBdHbMzAb4T4imQ0bAx8aQEQNWZGMPgr1xrJh6knb37pRlLv6rg?=
 =?us-ascii?Q?z6lelTRMGlY8DOoSJ34VZQnv2mNM+twdHNTImDGVHnMIk5iNJhN8ws4RrmtU?=
 =?us-ascii?Q?324REs9KC1bmBPc9VPp85th5X1AezHl/KCxfjvqI2MHkqR9HiXu7pHdgRkG/?=
 =?us-ascii?Q?ayUNSpFBZonMsJ0//4jp7BCDR29IrhaB8lQgR1FsSorM5Udi8+XUaU8t1G+M?=
 =?us-ascii?Q?9AtXow91dlsJdA6zH0uXWum28xUTfgteeoNCVBJDF9xmW7mgbHhBwG8CgCbl?=
 =?us-ascii?Q?gpr+xE8SJippVXXf/hfsIaMps/t6Ut5BBpEVvjVVX+EZWAQ4uImaWzjIsxFL?=
 =?us-ascii?Q?JocjJULfG6lBPr1mmEVLGo541yUOqs+aOwuATIUVslkadCFWlvrigsUz8lX0?=
 =?us-ascii?Q?S5EMZoII9s8wTPSTM0Y+eztFkLurdn3inechHmCpfv3gyGW18xRa/KuInH/O?=
 =?us-ascii?Q?ZGR6139PSgHphHvh098vgrek0JumGgI+zCgeZo1QOvgs61X3LkW1Fjlf9w5+?=
 =?us-ascii?Q?KYiydJhonP/JU+cXfBJCvR88RE/MqIW4bfPnPnFSRf5KVnh4PwU/GCw8b1Lj?=
 =?us-ascii?Q?foaG2kfjFfUF1UaoaaDMdxWLjqvur0eKMmEypUnMBqd/cs4iilyX1ycPo2IK?=
 =?us-ascii?Q?D99W40GeYidZShTm0d/+YXiXQwjllrs8WhjA/hrO9RwvfO4//yfKbi3l677J?=
 =?us-ascii?Q?HRu23BpJJhJOAuh980Kaudbwq0kuFz9+6uTJAbdjGJnx8+D1+d5VV3FDrM0J?=
 =?us-ascii?Q?fXWxk973ceKzBqFg0Ye8pELxHsb5rOQjvOYg65gX2gkWkXLBjhPL5kC+l+Xo?=
 =?us-ascii?Q?5mFS+UvHLekr4EIueSZOiqskjxFMXPVIkcN0RIVq0TDrWSJfIYg0NSMijEsy?=
 =?us-ascii?Q?OUY/G3jIgJWONq9sGCBv7gnk7Qd4q1mjbmxZpk9jyr5jxmzD/FFdzecwUK2I?=
 =?us-ascii?Q?aSGE84DtKzxl6tGr6xtlHvk6z0TLm2UVSOBM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:32:11.9769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ede460-471b-4cba-f7bc-08dd826b4101
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
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

This commit introduces a NULL pointer check for
mpc->funcs->program_lut_mode in the dcn401_populate_mcm_luts function.
The previous implementation directly called program_lut_mode without
validating its existence, which could lead to a NULL pointer
dereference.

With this change, the function is now only invoked if
mpc->funcs->program_lut_mode is not NULL

Fixes the below:

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c:720 dcn401_populate_mcm_luts()
error: we previously assumed 'mpc->funcs->program_lut_mode' could be null (see line 701)

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c
    642 void dcn401_populate_mcm_luts(struct dc *dc,
    643                 struct pipe_ctx *pipe_ctx,
    644                 struct dc_cm2_func_luts mcm_luts,
    645                 bool lut_bank_a)
    646 {
	...
    716                 }
    717                 if (m_lut_params.pwl) {
    718                         if (mpc->funcs->mcm.populate_lut)
    719                                 mpc->funcs->mcm.populate_lut(mpc, m_lut_params, lut_bank_a, mpcc_id);
--> 720                         mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_ENABLE, lut_bank_a, mpcc_id);

Cc: Yihan Zhu <yihanzhu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 8611eb9607df..ae7194da5987 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -717,7 +717,8 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 		if (m_lut_params.pwl) {
 			if (mpc->funcs->mcm.populate_lut)
 				mpc->funcs->mcm.populate_lut(mpc, m_lut_params, lut_bank_a, mpcc_id);
-			mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_ENABLE, lut_bank_a, mpcc_id);
+			if (mpc->funcs->program_lut_mode)
+				mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_ENABLE, lut_bank_a, mpcc_id);
 		}
 	}
 
-- 
2.34.1

