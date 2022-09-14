Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8A2ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B616610E813;
	Wed, 14 Sep 2022 03:55:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD9D10E813
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HikTQ2mupf9LWgtedqhqP5p/J0H6Syd3pL+5afMNxPTNryEZJC3xsUP1gvkFUdPZLlKkSzu4Gm/BTKIVGRiTbUfxqSux3TYj+5PEhHCXRmzDVoJ0kY0sn5snFApTmVjidnEEgkniAr64jsU70s3UXGhe0JriqJmYmiU7OW+jd4Mhsa14Fk/xXl0wS1qMNgvThKsvDUb+ZTy6vZiA8arzkKEQ7XjmnraYQrkI/MJikYq19v89DQSnflFEHeIEO8gJ8UxwCJBYKgyAobzJ7P4N65Ixp52vk1+8sgqRSCEGrC5hSG6Z8ca8WfQ5b6A7GYQ/+9xQYfds7tB2DVZ9mvYwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imNo3zM/gwrUIf9cLgfhPV2Dr1ioekFYOCt5TEUgt5c=;
 b=FRzjZpoutzc4hyI95cL35PUKpwmWpdqpcx4gJLot6GPYqWs82AH6ig1C+uPrQWtfYH4BgIhAyNz9fxDBh8zNmcxR7OoinATljvLwHEJ66cVnTNb8Xcl9FZd95ioSdKUHV7Nyop1qGFagbgr306DylIeX2oVo2k+Edcj+XUXRLO8xr3OV2hZDN+Gh7CMTivN7crMlTJckiAJKcdRRRI7NQuKAgmsfaCZkmjLVNIfLgjPk7CLeoYjuX7ytDLK5/mR3L5l6+EQMGxT3aBozxHqsbNtqg6HlOKh7GwRbfAXD1g/I8dvCXt+wl7v4+LKu6FtTVVIrRtvMKAybv+BGdsKvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imNo3zM/gwrUIf9cLgfhPV2Dr1ioekFYOCt5TEUgt5c=;
 b=bQOhD6uqnXZDXsVrbYaxpoHQQrfArXVXMb7Ku9g5OUjlW/XnAQ/nsM/Ueek3a5HJT26KY6dBwmgkEEcG8kxlyY2a33n4aBcaw9YrcU7GmbML+jTrEnsGsUT/6CCbqRbskgvoHzIndaWCAgJfG97EtD8yUZgYKDmXhTBPpDFkjLk=
Received: from MW2PR2101CA0035.namprd21.prod.outlook.com (2603:10b6:302:1::48)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:55:24 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::39) by MW2PR2101CA0035.outlook.office365.com
 (2603:10b6:302:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.5 via Frontend
 Transport; Wed, 14 Sep 2022 03:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:55:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:54:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:54:45 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:54:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 26/47] drm/amd/display: Removing 2 phys
Date: Wed, 14 Sep 2022 11:47:47 +0800
Message-ID: <20220914034808.1093521-27-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: e3917a20-cdcf-47c0-6636-08da9604f3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFzgDtNUkiC7IKPab+vQEUk6lIEKzg23VWh2+lZoySaOJU5Mr23ATPs2sg6VAQS8OUnm0vN44G2IkHoKsr0YThQhESfyys9j3GODeXo2e+qiEYixclvLv7QhlHbHD9heC36Yu2tg57CWAB351O9CeiFml6PHC+hE0yJTcRhxBf070VvsNv2BIimQQnAx2jdWpTB56BoRluCQ6XaAiJcFEsVVZgXiN6PdobxPFZeOYhsl5+XFT+5n2cTwq/zIrhvnervVgVqzQlTX2wvoqDnt0ru28d7ohhDKQ5tBppd5lCCptWZDDTZJS8YURRO0WYlDIhAmoxeIblAxQG7enM/La/Q00dZPw/vn+z2ZORm9a2gjIZ/A67/AoqO9ZNWwRC5R0fsXsGUW5R4v0YQ3CBSEgWxYLvPSllqV2TQadK/ZfrWnxWl3HuooS/YNDDviVdzh9O+AAst7Jr1dz9+dvDwvLp3QNDAzDZ59gzE+kcGahh/MRDasIH02meNenhQ1K2UqqtiHLg1o9D4IzADBP1TN2ywKMybT0uNO1Nw3BPz/ef0Y91Ddxgx38ykEFqw0IILt/BlhEAP6ffUEmePM7KA7QdNIl9nnakrsvsI8wEa2gL9lLeqtU2NGGXken2wFZaiEM+riQOHjz7dznF/5+MN5WR4sgRXSOK22Fjf1ZDM8vnO+8DppwPtvAbqoKm52UzRyRkjvygoB/6XOH9sZV8/6w+FoFVIKcZRqoUdPe3L/5OS07oBv3OmbJC1tm8oCTtXsXYPhrh4ypLLtYGScz6VXM3waTemkjym5Lmk5leCubuY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(356005)(81166007)(316002)(70586007)(4326008)(70206006)(54906003)(6916009)(47076005)(36860700001)(86362001)(336012)(83380400001)(41300700001)(7696005)(2616005)(426003)(6666004)(26005)(8936002)(186003)(478600001)(1076003)(8676002)(2906002)(5660300002)(36756003)(82310400005)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:55:23.8241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3917a20-cdcf-47c0-6636-08da9604f3c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Pavle Kotarac <Pavle.Kotarac@amd.com>

[WHY]
New dcn301 has 2 less phys

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index db172677d613..0c2b15a0f3a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -634,7 +634,7 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
-static const struct resource_caps res_cap_dcn301 = {
+static struct resource_caps res_cap_dcn301 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
 	.num_video_plane = 4,
@@ -1429,6 +1429,8 @@ static bool dcn301_resource_construct(
 
 	ctx->dc_bios->regs = &bios_regs;
 
+	if (dc->ctx->asic_id.chip_id == DEVICE_ID_VGH_1435)
+		res_cap_dcn301.num_pll = 2;
 	pool->base.res_cap = &res_cap_dcn301;
 
 	pool->base.funcs = &dcn301_res_pool_funcs;
-- 
2.37.3

