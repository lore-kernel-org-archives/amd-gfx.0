Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479C9C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D77F818B0DA;
	Fri, 22 Jul 2022 20:37:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F44818B0DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2KkWxeVgqENDACLSPefh5mvhOjjMJUJC7yDgTD5vgUP+r7dzqTwNuH+4rCrwlgAJ4AJbe6RMvRCcp4AMWm7KAhURbaDE1IVqBvxoeyMMDkYC4f5BHMp3t2T9bANgwQ9Gw46J25OT2yQWDNlcdv7xEYrN8iSe9wgIFGp8pzSy4BTYcH5zpBPk4QNCLXhC4/jXhmJtWl0XBPGZg/e5p7gFw+xffIJWiA8Nk7PCC2y2BhEzq1SPcMbye/NhKcg7iUpiGC7Z9h7dMn9SpvHB9l3fTSg5Ka+asK1cG4yR8MhKZPkkZOEHGm+XmeYDMp+RBY0l07D+KQBuu3faszMrd7/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTdx9r7nRufJxcO6bLrdcmHunl5c8QwYO/Up8EVX8bY=;
 b=KFvksEYQ24HsSdr+hYLWQ//+Fi7j3LyVh8/CHIRyaI9KV4nBV5XlXkdhCnWwVozaJIuFfi0FM9uArO3X4yr/YPY+sIno5GGZOPQvdyNJBQa3+pgPIZRePOL01tq090e5sZ0A5BsQIuqIDzzePqCQJnsXgY+6P6VUWoReUHnnvXb3ArXFuRg0fGziy4pR1nHulFJUyhmgAwCnjbGNGEcQBEECnNjQfeh6wg1RQnwHBMTs6G+gIydBgwRTcNx8pZl7lh2XQe7rQ/aNHjHqunQe3PP2Y53cHNMUNr/W4izZRPDT0SZQSqfEQdw9wzZSb7ozC5+zah6IeMzexhobYEldCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTdx9r7nRufJxcO6bLrdcmHunl5c8QwYO/Up8EVX8bY=;
 b=3JORp07yWYj3XiRojI6vi2N0PGCgvISJDazJkekItIwKhqPjkYBWweZANB4hTxKkIDMwPKFkvffx6wct/IYKJuMn0WymfXYnQ8re+w/kzsDXA9AduMoV+4LA/HD/OC2fZqKsqjVVOmZSh0hD11eV2DVqfFvIoLNutXUcHkxrMko=
Received: from MW4PR03CA0112.namprd03.prod.outlook.com (2603:10b6:303:b7::27)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:37:39 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::fe) by MW4PR03CA0112.outlook.office365.com
 (2603:10b6:303:b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Fri, 22 Jul 2022 20:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:37:39 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:37:35 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/31] drm/amd/display: Avoid MPC infinite loop
Date: Fri, 22 Jul 2022 14:31:07 -0600
Message-ID: <20220722203137.4043516-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 242bb0ab-dca6-4741-a6e6-08da6c2204e2
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6709:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuYHX67qtQTZKBjm5vnCSRmZbe1IJhbTaBVcKGcFQOpZQ/Ab079gw3vhihuP59jipQ52qFBFRENdizwEJvWaD8m0C1TSqI6d2up4y1h3vSLx0vQuYoo5pexTDicJZr25H9NRe6NP/swhFu4QLYJ9LrylgmBW4cB0fdXKkl64qVZLJ+863IeFXTF3tge0soaaN+bN94flyaGUPjhyvPHwwElGk0sn//ykfXiojGBDQIyvfccGlULFnZjh4lTMvcuLgvgUsvcXylo855PeaTJRMEC/fygA6wg3PT5G4uS5W0BGTEwgXDnaPNS662UekNNu3934fUO6PaMVnMtENzo7JsJUUEeI2cU8Ti1+oCl1GfiDHfrx5UGGxUMGeho2zREUrcU/afYK4Optyl2DanogObOk+5KivKtnIim/syteGz5B/dbN4BX1yIKaPXaLORGPhwQ+vR9cUT7L9FnmyDMwMKSGZ/BBR3mx5IR6KT0I3hLZ8W0ilFq6kqW5v+y5mgB5pMbW2bWnVEP4tYQx3AQhxs0zSVyobMrSwxhpr6diiqTVYuQJKqfSXZz0BEn2cisWBVTHcT/nct4Qsq2LkjyorzaPQd1FUfSotl3GXraT8/mYdX029wLBOwK95lQkqrL646hph7agix/747uNg9Vmj7ETtMsVMQNy5QmjSiPhigIxPGY0zzmEtZ58tm+BHejvDkKnP1bbLF9ttDzBgnrEV5u15kgVeydGClqt6PxKPZ1JypmtwYAR2jeusKCSrZbD9Y5ogomAKSIdFHAn/D5i3j43RST/of3tTxlm0qZMp9M+geEOIKexb9J/gWxWVZ+ETUEcPYtyMCmS7oqRX5Z4jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(40470700004)(46966006)(40460700003)(82310400005)(86362001)(81166007)(82740400003)(356005)(36860700001)(478600001)(8936002)(316002)(5660300002)(44832011)(336012)(4326008)(8676002)(47076005)(6916009)(426003)(1076003)(186003)(16526019)(40480700001)(2616005)(7696005)(2906002)(41300700001)(70206006)(26005)(6666004)(36756003)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:37:39.1122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 242bb0ab-dca6-4741-a6e6-08da6c2204e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, mark.broadworth@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Josip Pavic <Josip.Pavic@amd.com>,
 solomon.chiu@amd.com, daniel.wheeler@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[why]
In some cases MPC tree bottom pipe ends up point to itself.  This causes
iterating from top to bottom to hang the system in an infinite loop.

[how]
When looping to next MPC bottom pipe, check that the pointer is not same
as current to avoid infinite loop.

Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index 11019c2c62cc..769974375b4b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -49,6 +49,11 @@ void mpc1_set_bg_color(struct mpc *mpc,
 
 	/* find bottommost mpcc. */
 	while (bottommost_mpcc->mpcc_bot) {
+		/* avoid circular linked link */
+		ASSERT(bottommost_mpcc != bottommost_mpcc->mpcc_bot);
+		if (bottommost_mpcc == bottommost_mpcc->mpcc_bot)
+			break;
+
 		bottommost_mpcc = bottommost_mpcc->mpcc_bot;
 	}
 
-- 
2.37.1

