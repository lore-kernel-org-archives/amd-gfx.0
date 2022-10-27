Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4107FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA61F10E6C7;
	Thu, 27 Oct 2022 18:39:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AA310E6C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k126QX4N2GE4QvEtE4vpv7yuKXOSTfkiUkSyEMms0F1/IxmcndF3wO51GaJfPXWaF0EGY1bWRJwZl/BgXHbD34HOiw2WTN1kjwoYaHxNg8cZ8GDVNju3T/DPmSrQKGgea23ODM8pUErUoB4+aj6KViETtM5WKuju2lWGUfX0LEfrSkfP2p7qNHDQJx+DY8tw+vzE1crKo2GRustjMrrFXBgoLH6OeoZ6+NzERWUiel6hhUZGc9Q0Rtdoaek8ZVMCJy4gG6AUzMca5bFUQlwk2LJ+eFbBHQbfAOcKwKqtvRz4v92K3MHqnFERiKe7A04NRTGIbtKo7W+DziwPdgIU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJ9X6ZN20GBSli8I1OcKsHJYGrL9W3b3DX2GuUE2ucU=;
 b=gkmiJVk6zkfR/XyGNULkmbBG13ko5CGZsSxtyVo66dqzZcN/4JLFowP1URoWTa1ZE+Y1VDSMAuG0AO2VvP+iB5bWds6H2e4/iuwKbuRmcCugYtyiZ8B+IpHFjpXaHQ8IeDCuVBKhWWfitvoGckVuvnMg1H2VansfWP8DKYejdqEFFfYWHiByJE0sqYqWa6POnwCDfRCLZNg1S1hE5uGEL49nWW0ZZXniK8O8/g4JWWeZYgUPDHQFOZyOMAiod3dWp+qKWUfPFFjU8sEKErKsoUH3SzpI+FipzIhDtwnwAXmVtA6DnB3XcR9F0/tHGjhPT8a1ujGppnSbvYSvO5TziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ9X6ZN20GBSli8I1OcKsHJYGrL9W3b3DX2GuUE2ucU=;
 b=GbDc0nKUi+Yl6MJZ3DdfJRy6VtRgq2hltiH/mKAQGgleKTgcBzrLS4+yGnUpw3l2BgZIwXzbPj3ayerkAOx1VIeRkxWd2aGIxVT/FpNtK3yKZ9VHxrjgZ92mRKuEuvLChnh5LeSBPl6cdHp4WLTbHLctvSzmQ9BelsjqDnodvQg=
Received: from BN0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:e7::27)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:39:38 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::8a) by BN0PR03CA0052.outlook.office365.com
 (2603:10b6:408:e7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 18:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 18:39:37 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:39:35 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/18] drm/amd/display: Update DML formula
Date: Thu, 27 Oct 2022 12:35:29 -0600
Message-ID: <20221027183543.1117976-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ef3f4f-5528-43d6-d379-08dab84a9a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICDowyTiCYEstuZ9th6bBhAYsS7Od1h4Dqj5q+9Y/In8WGEemq/noC+plMBXXBH5AIj6dqOrMKmwWi1MDtJqRQiC0G6vsyDfG/LZLXe5t9gGoG5W74eLmnPrrqH9qPh+BceuPYUlF7GTTElw4EnvayKkoDZoDoMUIOUs9H5F6Zc+dbFwqywD6mQtsCltHqHuMdKTDd5oGbuLH9nrpEtpj43zcaFbp+HqdGm/hENs0xZetdvHX0CAeMRvOl/4YWms6py3CbbnzhxjfGJZLxtUIHQvdks7PJK6g6ezKZUpM+/E9/7NcS4jLZOFBV1bvXaXzI41TAmiNVu8Q6q2sPE8xRT+zzV/iIgrERFjlkBQt/jm8t4Ow/GFrEVVytHSr80nJ5f65zP/cqQgjXUW+KurXDO3g86dGfH1GqGcam2cdvNgTtWJTo9M0+AzsjFbFPn0ORx1lBfPNKoFwFEHIaJ7rq3YyX7MeZ62VlAgI614sujxr5sxmFNUXoZrf65eWyuE8ZYWA0sgprudeIpo+2i7/2n+FfiKgcVc4IRzerm48H9TgQVMlHnpDgW0S1JKhkXA0crrUrcNbO/pM9hvoDm/t/o0Ow5h/K+kY4vLTLiXS6Kgqm+kuV+RdXwIDkLwpd2+eqhOmbJFQ0gsYXUbzJ7/1FnXQWbBos+5y2/bvPJMjk8b32Mimfxl6qxcPTPTin/Hf2KbMYHD/0qzj92ughywAhA4krFl/FSyTpXLQMWJPLzpQMjf31WJEb1YcoykCYUhkHuh9XIwzGC2EMWWhTYvGeQleVaiuzj7BI9mSHuhJHfglzThgTctCZhKOeiH2czN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(2906002)(7696005)(40480700001)(70206006)(6666004)(316002)(70586007)(54906003)(4326008)(6916009)(478600001)(8676002)(26005)(36860700001)(5660300002)(44832011)(8936002)(41300700001)(86362001)(15650500001)(1076003)(16526019)(2616005)(36756003)(40460700003)(83380400001)(336012)(82310400005)(356005)(186003)(47076005)(426003)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:39:37.7656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ef3f4f-5528-43d6-d379-08dab84a9a0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
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
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Ariel Bernstein <Eric.Bernstein@amd.com>, wayne.lin@amd.com,
 Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
This is to update SW DML implementation.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c | 3 ++-
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index b612edb14417..45ab0ce50860 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -1052,7 +1052,8 @@ static bool CalculatePrefetchSchedule(
 	else
 		bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC;
 	/*rev 99*/
-	prefetch_bw_pr = dml_min(1, bytes_pp * myPipe->PixelClock / (double) myPipe->DPPPerPlane);
+	prefetch_bw_pr = bytes_pp * myPipe->PixelClock / (double) myPipe->DPPPerPlane;
+	prefetch_bw_pr = dml_min(1, myPipe->VRatio) * prefetch_bw_pr;
 	max_Tsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime;
 	prefetch_sw_bytes = PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY + PrefetchSourceLinesC * swath_width_chroma_ub * myPipe->BytePerPixelC;
 	prefetch_bw_oto = dml_max(bytes_pp * myPipe->PixelClock / myPipe->DPPPerPlane, prefetch_sw_bytes / (dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime));
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 0d12fd079cd6..53e3e7364ec6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -1074,7 +1074,8 @@ static bool CalculatePrefetchSchedule(
 	else
 		bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC;
 	/*rev 99*/
-	prefetch_bw_pr = dml_min(1, bytes_pp * myPipe->PixelClock / (double) myPipe->DPPPerPlane);
+	prefetch_bw_pr = bytes_pp * myPipe->PixelClock / (double) myPipe->DPPPerPlane;
+	prefetch_bw_pr = dml_min(1, myPipe->VRatio) * prefetch_bw_pr;
 	max_Tsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime;
 	prefetch_sw_bytes = PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY + PrefetchSourceLinesC * swath_width_chroma_ub * myPipe->BytePerPixelC;
 	prefetch_bw_oto = dml_max(bytes_pp * myPipe->PixelClock / myPipe->DPPPerPlane, prefetch_sw_bytes / (dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime));
-- 
2.38.1

