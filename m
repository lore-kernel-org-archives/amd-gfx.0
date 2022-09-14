Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F85ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DF410E81A;
	Wed, 14 Sep 2022 03:56:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576D710E818
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrW70nvBQhqwMgEey3e+RzWDM+dkQa0/seSPeUtISS1DUdyL5qg6h0LGNaynknO2F44sKcjypu8AVYyOuKdR2vdp/bYZs4jdD4c72DV0C0cQ+9Wq4/lTwRwqvHeJE7t2M2nhC2N8n1cCp+sq/rK2DxqcNLZhlom7vJ8dIuOY6PDQXQPbmcVTc9nLIIG7ugZyjwm0sC/G5HiCAA9mcbxgcPrA7WNEEo79FZ4lEPhUCRQPZ+cmz+ZrZM4WmOFZ0bhgwXnEIkonAiwHCfyAgJq5FHx0Lr89LQrRNKaAZqGXSfOFQ43HXoXQsXuVzw7p55aaA3S+x4mVrTpm8hopfKIaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlVNO7namICkGc8uoL8oE/A1vfKwf0Wdd13MZwQm0tM=;
 b=IxQMekQUxCmSojJiPkPEH2rcRvJgVPBq0bqH9Mpcf57IU+yunmm1O6aExDS1VKVjy17Rox37570DlvBc517QbX+iHsTOUp26vnL/DRDtPiB/QNK/I/BiTaGBfloxdQ/j+2vNA29jCo2fay4Q1xvxQx7ojqZ7t3RYXJpJJLCO9Bv8YG0woX+ysbqfn9TOZ3WuRnntejo9HJAdf5WVXOzUyZhR1nGWOZFeU8ydmvD7EvZdVCaHP04b+mDZBY57aA99QuMc7l03UmEXqt3zZz8+hGKzXJJVKI3W38RAY/qgOOAgDwRnoU+u++/rLzamw92dUl/PqHAPX7Oz+qiZGmwuCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlVNO7namICkGc8uoL8oE/A1vfKwf0Wdd13MZwQm0tM=;
 b=ZRrTOPcmiAxaf0jQ08oGk84XSLGtEufotnZ0VeIWkW5yviMtiz6dTQcWEuc62s9gSjbVccnfQ3MITEeiWCYtrDdjA3f9wqOVqHzrLlpK39ZJ++P3CySTWkNqYedqapBSL+pT9wVnmTVAR6y3exTF3Of17vsqGILkcdEwfGmTqQA=
Received: from BN8PR07CA0035.namprd07.prod.outlook.com (2603:10b6:408:ac::48)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 14 Sep
 2022 03:56:04 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::89) by BN8PR07CA0035.outlook.office365.com
 (2603:10b6:408:ac::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:56:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:56:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:55:49 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:55:45 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 35/47] drm/amd/display: Assume connectors are on single slot
Date: Wed, 14 Sep 2022 11:47:56 +0800
Message-ID: <20220914034808.1093521-36-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|BL1PR12MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dff8f8f-45e8-4281-c776-08da96050c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14hxp8C1BAK/Amv/mUTLr2Q0ErfGpB3FmCQvPN+f08SHQUPJ7MHqGF9zFumW3Cl3rDV0v0nnx0VNgLSG7XPlNSYOD04HJnSk0EmmRLAF6WfeHNOsRN2SOszirQ7A5dKARWF9oo8eXPFWwrI7mRnfWjjiUrL3HTtKSf5rNT9J1YI1l8eZXuhiIghRThCv70wgS6jd15gLObrUn0Z6/DtMREoGZSUq7ewWtD+mk+hyKsTo1Oaw0Z0V2835Md2atL1xWQmvIir1vKVCQsk2vQPmdvVXyUxzetb5QJS8Ocs0NEUliSbvHrT6F0hIdPW8YRz8/Z9hbhGJy5bWYDIL9JGSbnsoMzPY3X2WFiKeSMGS1HiFufYkXpj7pxRWFo/V27k3CzujDuAuDH0AY8ycRX/oss5uLT2iJFWArkKLnvXuvid5NHyR9rKDd9nBwFdW9lW2bqdJwXFJEcKLEWnvJLkZKhrezeBEEQVLHL464efJ2ciMJFKbXwocRZafXL7KwNZ+XTrTlO0njJ+7NoGWsTd+y/yCAT7PPY4WllLko/SoQUOd9Lfs70PBHKY0ENfGbg6VC5lWc8rxsFH01xYyHAs2sZYA8Fmcqz7jsltzab2exwp8dMF/E5JTIu7Vog0t064aoTRiUzjDTMKRIKTqeGz7ofl4O18k/qJhK2FUfAy6p3Wx5sc4MWDWorbfLFuDd9n7EF1kG7XL/IaNFeke/nJLd1Fnmz++T2kwnKSDccWoVxmZW3y5Y8tLkKpZxy+dMltH12Rikvqs8XYI1ytcwInyCOZnHjbizXMrVlIuAbTSHSi4vURwYYb30V8PWfW3vMid
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(6916009)(54906003)(316002)(7696005)(40460700003)(336012)(6666004)(2906002)(186003)(36756003)(86362001)(5660300002)(81166007)(82740400003)(1076003)(2616005)(40480700001)(4326008)(82310400005)(478600001)(70206006)(426003)(26005)(83380400001)(8936002)(70586007)(8676002)(36860700001)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:56:04.7478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dff8f8f-45e8-4281-c776-08da96050c15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
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
Cc: stylon.wang@amd.com, Jaehyun Chung <jaehyun.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
v1_5 display object table has no way for connectors to
indicate which slot they are a part of, resulting in additional
empty slots to appear in EDID management UI.

[How]
Assume that all connectors belong to the same slot.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index acbdb7926375..5d70f9901d13 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -3346,6 +3346,7 @@ static enum bp_result bios_get_board_layout_info(
 	struct bios_parser *bp;
 
 	static enum bp_result record_result;
+	unsigned int max_slots;
 
 	const unsigned int slot_index_to_vbios_id[MAX_BOARD_SLOTS] = {
 		GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID1,
@@ -3362,8 +3363,14 @@ static enum bp_result bios_get_board_layout_info(
 	}
 
 	board_layout_info->num_of_slots = 0;
+	max_slots = MAX_BOARD_SLOTS;
 
-	for (i = 0; i < MAX_BOARD_SLOTS; ++i) {
+	// Assume single slot on v1_5
+	if (bp->object_info_tbl.revision.minor == 5) {
+		max_slots = 1;
+	}
+
+	for (i = 0; i < max_slots; ++i) {
 		record_result = get_bracket_layout_record(dcb,
 			slot_index_to_vbios_id[i],
 			&board_layout_info->slots[i]);
-- 
2.37.3

