Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDFFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 02:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A412E10EF86;
	Wed, 27 Apr 2022 02:40:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E07410EF86
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 02:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx6hExYAuSgIKxqocXEsP1yWytggtPzCwrhN3Qz/H4z/QEpqw7NE9nR7akO5BjjhEPrLn1sU4vO4tf7FRh+lRa3olJXl9s56w2awtZMZqBa6vJ78Z/XNprXFZFeaUN2MZUS7g7FZDyXFaItwDOgTWk2SmljyFvufv9cq7GkP8qbKi6ZTbr2n2iaKHpQfxQSzyEL4HAGabg1myJNyMkObteojPO/aJ1rjlsZEf0/U2E9M5F6XTQRy+Z+9Peyx/7wrYW78P0e6ZVQ+iNutuL+JoCUxAf/m5lnx6Aej/jh2ytks9P/mS35fSSOKYh/JxWHhypBlWuZAUnHTHdv9aA24WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44nmuSzk/M29kaGM7djTY+/Qk9Q/vhfPMFD9S4q8lQM=;
 b=DbJyVES+7ute/KI1klxSCUFgPlrdvd6F27PQTv7A6agJ15uFK4K64EZJzqZ2FeZNcLBUDDUPDTm2VtcHbAXysEYLIJurIZ0lOvUpW7GokQCIKYP7As6sbz5oq9g72VqL7DhWk1gfpT0gTNax55hUflQD9f9AZV8vAD63g60nrE7wfTz8rlgiHN6QG1Mc9rTAt+yc6UGc1TPzs8UPeXjkpsGM11RrPquRqwyUwzuF2clqSnbHC9bBEs98msj95URFTfjN0Y35p1RLcWjmuZoUKJBGrZMx2tMpQplcqX7mOjc97w3O1pYf1tEtmiPe5wdmT4JOa5I2jVz8Ov2GYIXXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44nmuSzk/M29kaGM7djTY+/Qk9Q/vhfPMFD9S4q8lQM=;
 b=xP8jhFDp7m5cBRlqF6Wfjpqd+cJmt1IxekB5na2RFO3QoSqfUqGdj6ME7PHIpe6WXqg/fPBbPJmQ7ziqCl2Ov5oP5AbkJ1nG0FihD/HXeKN92dMCTiRJM7xaj4Q5eZBW4bx6QescD9NUYAZ/IsmO/tFrrZL8/sBoWcCtPYS+n3s=
Received: from MW4PR04CA0341.namprd04.prod.outlook.com (2603:10b6:303:8a::16)
 by MWHPR12MB1406.namprd12.prod.outlook.com (2603:10b6:300:14::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 02:40:43 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::4) by MW4PR04CA0341.outlook.office365.com
 (2603:10b6:303:8a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 27 Apr 2022 02:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 02:40:42 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 21:40:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 19:40:37 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 21:40:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] Revert "drm/amd/display: Reset cached PSR parameters
 after hibernate"
Date: Wed, 27 Apr 2022 10:39:54 +0800
Message-ID: <20220427023959.1241450-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427023959.1241450-1-Wayne.Lin@amd.com>
References: <20220427023959.1241450-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c82a69-7a7e-446c-2587-08da27f75325
X-MS-TrafficTypeDiagnostic: MWHPR12MB1406:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1406D1D94549EA29A5F4301AFCFA9@MWHPR12MB1406.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yruBWTo3VUPMyZXsA8ute2/uEMUPPNKQes1D0VkwNb+OCeqjt7Ml4DegJTApoBuRjLkozDLHHuBBdEWfaJzCuPG/CxmND1zPPwSRSBicZ0wIaEJ3NkPXBQGshOQ//nYdvPayk7lDUxwA13kwaLOOppgN9/tDSnkge5fmtrSn+hllVNtTkiFpfFh23VA30sH/Z5ufumC310U084RK2drwpGpHeiAXEcxLvQ4DT/pPFOW2MLCCfCuYssORN0lkMibnPW1bbb/3ht7D06TRHxEtuijzP2JId8Lw0XJ34Vzp+ic2+PBe0u+9S7nBeCnq83s5njfNaJ6LTS/Auadqxp1omRhT5FcW0roLl9sOt54OET2EMpveZbuKeAXtHo8ydQ6OlqGGy1nCWW82P3W81GGemXQu6kP/DkL5+bSRwrVDi0aO2V4g3vUdiQJ53OaPH/Sl5TKw5igPm8h1CGU0nILPweKQ8hE7YLvyLtRyqsDU5KZ2/uwMfy1KAvRfVzvVGcbOOS0p7+26EHoq/nOCtLLwLrY2n9kbyNPy6nU0yreLaq7VjWyMUiu5nHtQXD/wbaB5wUlQS95tOHxmJ9PC60FLM/TzWhqlFO8vwfUAN21zqrgrDFfTGQq27F8x4jzP0xLJZYYUgeFJjXnK0GVBkfFo2Q4Cm4nhWIfoJakhTjm3Er2L1rmTyIfh2AbLx9zRZ6oibJY4/8VhBTKpGT50pWGPMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(40460700003)(36860700001)(83380400001)(1076003)(36756003)(70586007)(54906003)(70206006)(5660300002)(8676002)(316002)(4326008)(6916009)(81166007)(86362001)(47076005)(508600001)(2616005)(336012)(426003)(8936002)(186003)(82310400005)(6666004)(26005)(7696005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 02:40:42.9976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c82a69-7a7e-446c-2587-08da27f75325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1406
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
Cc: stylon.wang@amd.com, Jayendran Ramani <Jayendran.Ramani@amd.com>,
 Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Harry Vanzylldejong <Harry.Vanzylldejong@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>

This reverts commit cee342f2d6a8b57ef8209720d5892d0ee22fd3c8.

Commit cee342f2d6a8 ("drm/amd/display: Reset cached PSR parameters
after hibernate") causes a system hang when game resolution is
changed. Revert it.

Reviewed-by: Jayendran Ramani <Jayendran.Ramani@amd.com>
Reviewed-by: Harry Vanzylldejong <Harry.Vanzylldejong@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 1eddf2785153..3d13ee32a3db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3317,14 +3317,9 @@ bool dc_link_setup_psr(struct dc_link *link,
 	 */
 	psr_context->frame_delay = 0;
 
-	if (psr) {
+	if (psr)
 		link->psr_settings.psr_feature_enabled = psr->funcs->psr_copy_settings(psr,
 			link, psr_context, panel_inst);
-		if (link->psr_settings.psr_feature_enabled) {
-			link->psr_settings.psr_power_opt = 0;
-			link->psr_settings.psr_allow_active = 0;
-		}
-	}
 	else
 		link->psr_settings.psr_feature_enabled = dmcu->funcs->setup_psr(dmcu, link, psr_context);
 
-- 
2.36.0

