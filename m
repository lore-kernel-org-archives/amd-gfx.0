Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A338C4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DF810E2D1;
	Wed,  7 Feb 2024 20:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SNkdo+y1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F05D10E266
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqtiT/MdsNjqtGo0R0chCAD4aHoE7nvFVLs15seF+D0is1sqsciVxp8HHsZ2lsyebNGiyUnkbpLQPbwVMuE4zPqgaMf5G/9qrfZUxdvJ9Pzqym+wNuAKWxEWVGE/RZID1ud953HCsqCUct9qDlTkRwEsEwzG71vhN9a6RVd2uiwgchb8OcxTjcVTy/rATiDB6cjBe46MQqHx4zv6aXy3SKhGVdNh7AYP54tr6A617uDRc2kx/AYC7zGhu6FgoSNcsy8XLvzxPqrh92orUvLgTWA7dvzMW/LCNUyH97Rz8vx8AT21179kjals83CkRv5S2eLMrw+0P1kfS89hTYZ+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctTH2JbyVJyVmGTnsSDffVavQ/3f5cNkdSAJ/iWJU/k=;
 b=ZA+tdMik+FLCiO1I988fcqF3azsNipG9sXOV+S0fPLsklQ/PgpSVw/BdjZA/aycortg5mntfkNsyWjnDBE4o8YQ3y1Qst0JznwsAkoFapmVL3tKfU2gWb4AW4cjcPrb8eqG1/tZrchKpU50pgE9GhJfojFlYSNZCe+nc0icd1VlfSSYwqI6abilalAk52VHeTFy5yyc/oBIAc2GfElYBsfGddicTh1MvfgjUKd60ofQ+AdKJsqEE2/WTZfJ0IqIPHRjGh1fOGZEJZ1X0Ftl0jP47rsGUv/4p74UzftP+/zU09Yj9UZ7ujLYh3N7TeGl+JICCDJiuc2co+RIS26eO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctTH2JbyVJyVmGTnsSDffVavQ/3f5cNkdSAJ/iWJU/k=;
 b=SNkdo+y1ltRA3iLbJTh/klhy9kc7kLwT3Pd9ADj7qyiDaKuQwXK+1kFNH4b8/EQ1sf6r6BAQFC6ToW22fjicLa7bV29FEWuDZ37DaEK+xcof3OtqseKBDTLKawU7A1uk+2YYjoIXfvqx3WJbvMKEE6XvdAGKNEgiGzjA/03UdgQ=
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 20:52:10 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::bc) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Wed, 7 Feb 2024 20:52:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:09 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:09 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:08 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Zhikai Zhai
 <zhikai.zhai@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 01/15] drm/amd/display: Add align done check
Date: Wed, 7 Feb 2024 15:50:36 -0500
Message-ID: <20240207205200.1608684-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DM6PR12MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: dd784259-bb9b-4a4e-5cbb-08dc281ea797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UAa4hpET+oiFq7horyvCsuLkxAVGsR0PsJDkADC8AXBROa2LvSa3BqV840N+w4eStJmeiyXV1YxJm70eLAozUbxHnWnYXjHRZYAfKsZZZQEDM+vRrdDoBDnpvHW8DpMoFDwxjtqq51OSqLB6+sIAOggNfTkB6eXb2pD76a3Ztu2cOKrp8dahQPyYAyusTwvrIGRcGwcC4MYomKgDnKS0rjaAV/fXHtS5e0tGIMMzLKMTHtBVQoH5RpIKizuFr0e+sBCE55jqAs/4MLh2a6hPGuxSSYEglecp6x1z6qbV4plGucNVwcXQJyjvCBSRk3Q3TSjpErNWatnDa3cvqRw8a++ykkNsHaQFiQAvqQnBuCzGFfYs6/A9woYhrJpcmSrexBgmcST9VFiFDMdevGNkwRGVPRKKAu0uCZLWQFlShwOyS6w3xXGh8/4SBeB7yldSxU7UO5UFEwUt7z7QjbWOa+LiDKPj7PohNb3kHHxizlGH9fGdsBF5sOxgE6LYTBv5NIZKSKf2WQfd+PSLCT0n+IZDwu/YA70qSKtiFHVzYJ5Cm8LSk6LplFgqtufM4Pl7j0mXA7fCIq5xTjMAiLoxApikxnBrTcvUcdNAHjs1e6c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(41300700001)(26005)(478600001)(36756003)(426003)(336012)(356005)(1076003)(82740400003)(2616005)(83380400001)(2906002)(86362001)(81166007)(54906003)(8676002)(6666004)(316002)(70206006)(7696005)(44832011)(5660300002)(6916009)(70586007)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:10.2487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd784259-bb9b-4a4e-5cbb-08dc281ea797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
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

From: Zhikai Zhai <zhikai.zhai@amd.com>

[WHY]
We Double-check link status if training successful,
but miss the lane align status.

[HOW]
Add the lane align status check

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index e06d3c2d8910..e538c67d3ed9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -517,6 +517,7 @@ enum link_training_result dp_check_link_loss_status(
 {
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	union lane_status lane_status;
+	union lane_align_status_updated dpcd_lane_status_updated;
 	uint8_t dpcd_buf[6] = {0};
 	uint32_t lane;
 
@@ -532,10 +533,12 @@ enum link_training_result dp_check_link_loss_status(
 		 * check lanes status
 		 */
 		lane_status.raw = dp_get_nibble_at_index(&dpcd_buf[2], lane);
+		dpcd_lane_status_updated.raw = dpcd_buf[4];
 
 		if (!lane_status.bits.CHANNEL_EQ_DONE_0 ||
 			!lane_status.bits.CR_DONE_0 ||
-			!lane_status.bits.SYMBOL_LOCKED_0) {
+			!lane_status.bits.SYMBOL_LOCKED_0 ||
+			!dp_is_interlane_aligned(dpcd_lane_status_updated)) {
 			/* if one of the channel equalization, clock
 			 * recovery or symbol lock is dropped
 			 * consider it as (link has been
-- 
2.43.0

