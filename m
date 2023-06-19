Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD1AEB64DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 12:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC3710E1F1;
	Mon, 19 Jun 2023 12:04:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA4710E1F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 12:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cILl93O4djBQHU22LIyQ4civFLHWizUcXHNuRAMZ4wZHhwczlMiqU35nUn22i6JdOcYvgewcnv7WghZHEtvmWjTczXje7qa1BcRNKSpwjxwStDCTCYQdd7LytZ+tkmbxwBfoO4MwzwjiGqgfUiaZnHDzPtTrkwR9j05eSKwGtkbhYLrpo5Od7yCxeAXCG0bEwHUK+iw4nThi/Q+S6RLU1CWLBQJic3jHWg4FEwNGBVHwAzL0078C8kqMo+9B72t2jbJELYjcJ1TIcMlw2lJS4jhfRPTEWdiwLkVaKXG9H8LuJUHF7xP/GdzLfxv2KAHZNXFvma9/IIQPDA81CHWG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWK3sEH5WIdQU2m618ciy7Orj/z2OUlD4FkSGpoi4y4=;
 b=aSeIR8SK5JQ+YQ6+XGhzv9ZjACUL1A0N5YpHobl5Epk2x2KfMuB6gRsy4a2vj9Y2+XxoQbo/q2h8UM8BMBEFcCUlTugc5nxkwKI+m5WOMI3MSAHk7i+3RQlF35DrZ8O8HeLX07lsWvEtjs6U41bWwnoI6tt6jP401YjldQhpRtxXf6BYYxFgGzu1WNUDUloXhkTsIHLHTHEwy0YEvfw3vB6s+uhKRHKFj1azLgXZarZFQPihOu7cDc6CjO8EfP0JcIQXjXM1oHobtY9kyIjz3l7KWGSugTU/nAE+ft8FLgeNw2R6KnX+8M1vm3Tj+rrQd0oYdgIreAMwMiB2rTy9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWK3sEH5WIdQU2m618ciy7Orj/z2OUlD4FkSGpoi4y4=;
 b=O9kvlPwAseCiikjQPE1uiwqVS0O3x/8hAVBMBvfcr5lAFpPteXVCoL9ziA/kk3Oem5ekJcm9/fPCB8YkKhyWhmUbDRGa8yHYq6s1r5iHcDH/1at4vvE5plxZn43/cvZOMZ+klYtUAt6REm70sIuRXzhyaYh3h91N4J+I1Nwxt2o=
Received: from PH8PR21CA0015.namprd21.prod.outlook.com (2603:10b6:510:2ce::12)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 12:03:59 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::9c) by PH8PR21CA0015.outlook.office365.com
 (2603:10b6:510:2ce::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4 via Frontend
 Transport; Mon, 19 Jun 2023 12:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Mon, 19 Jun 2023 12:03:58 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 07:03:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Qingqing Zhuo
 <qingqing.zhuo@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH] drm/amd/display: Remove else after return statement in
 'dm_update_plane_state'
Date: Mon, 19 Jun 2023 17:32:50 +0530
Message-ID: <20230619120250.4168839-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9e2220-d840-4350-e25d-08db70bd4399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmT/ID/CE37sdcRdjhV+kXsi4ibq1JPvdkAPdiTU9fsPdOtSQGjSFVArxKeHsRRjbw0t9/3/NkhRyKP/ME+keNwNLA65tJCmQT0tQi8KizUyiOCYHmRfF8SpMH3hXpnbNldMSHePF2Bz991IFt4TWbFRcQQhWLgcr8g3I49Py1tNuqi6c1BY/RdoKNeItb/+KdVmSlu4S7m1OKVMUORy7nhTYiSobkXAV3RgZUTkSgq+5kowJdj2ImdbiFS/5j+JMT6sYBs8swwIRtkc3yWlepA7+MxSM5I5AB4+6GEYWh8q9TbxQPVg13ARuOCcH6c7Q1LIw5Kxl7zkHUdqOZsRnQf+b4cY/jgnM581C9C9WwPik/evHPjet9TkdCTzkk/IIU44/W2XrQBcu9q34PeX0xPkc1cJNvprp1GQGTtED6bAgw9GAeHvSNALSbTxVQM2hZBUTGjAUGDuEeojFt0gjLLVMsz3WlsK9QQDVlDZEEHK/hyOyuGvI0F6VX7cKEfDeEiNZMYqtCCGktXfXlTUDutpVt7tLsvYRiAcSMT+TMlng5ZnFeXS1ASlUP9Y+r6cGaCdED2zPJR8l9fWtwE0WYEubVjjZ7GksvBZ0ZpOicxFQhYOUdOb/PJH0xcvFdp4fLGdVA6apPzZYKk7IZJcRDy1MLp/n8qgJNGPfn//QRtHkSsGZeoEh+RtlKNArnaSCg1dKhlYt/QTnKFtYFglBhD2kRKjqJs7EThz9tNbDVuduYxPorjGfXDAL0MahBdYZzaoFxYQW7oqBFBW4y5QKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(356005)(81166007)(82740400003)(40480700001)(40460700003)(36756003)(86362001)(6666004)(7696005)(16526019)(26005)(1076003)(186003)(8936002)(8676002)(44832011)(5660300002)(478600001)(110136005)(54906003)(316002)(41300700001)(4326008)(6636002)(70586007)(70206006)(2906002)(83380400001)(36860700001)(426003)(2616005)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 12:03:58.7720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9e2220-d840-4350-e25d-08db70bd4399
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
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

Else is not necessary after return statements, hence remove it.

Reported by checkpatch:

WARNING: else is not generally useful after a break or return
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:9776:
                               return -EINVAL;
                       else

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2446529c329a..e657214e0104 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9777,8 +9777,8 @@ static int dm_update_plane_state(struct dc *dc,
 		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
 			if (is_video_format(new_plane_state->fb->format->format) && *is_top_most_overlay)
 				return -EINVAL;
-			else
-				*is_top_most_overlay = false;
+
+			*is_top_most_overlay = false;
 		}
 
 		DRM_DEBUG_ATOMIC("Enabling DRM plane: %d on DRM crtc %d\n",
-- 
2.25.1

