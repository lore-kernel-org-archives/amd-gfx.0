Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ABFE8783D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C8D10E6A6;
	Tue,  3 Feb 2026 15:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lJ+0qgok";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F2F10E6B2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAtqOJcuOWe7489lAGEBqD6SRhSv7qDty0HAu91RxSvlMCjlFkTSDftXZzBR84JdMTuXPqxlfCj4kPUNFqFMKy0R6fRcxRID4AR6Ln0vNE5ttX6TKcUfbqdYUqyxhGJalhG844nHgjELTVD61H4zasK7TAiSrx9/3c7Aitr6ROfm4KiJnkRSFdxalKSshsH4j7uLyayr83dgna8+GdwvM5cuVpkF+rsFK2msmbM6F31EWexFeEeT+Gvsv2iuplyxZ4SoSrOSRh4Cdo2OIA0PQGA2FBEOUxpmMt0AjoGX9ipwmbq9lowpBpKPW7GL1/LAgfLzfWk7qK0vO1CoUJ564w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prwXswgIIP7geeepjDGFCN8PML+yjPuU3Gphdl+uWrI=;
 b=uVQ0iJBO9UJFON+aYhiaQe6JkhBxeWsky2MqkQXgX9Bi2E2J+YIS9UfSEeI2E325iSYPjTxZKJnNxTNnG8NFf3VvhWmr6H/CbP+gEjat6PzaJgFC+ZuM72581ysLuKGVfTDOIMEvotknEa00BNK8YY7DCezr+ecjFigZbE4SOo4URvn7bmRtK+U83fZ+EyeAoAYYhADGiC9gVZJ6zVVhLFIYvgn0Qibi4ccydolFG+O77eZhf8YXD/ykREnjQuK9R5qAyHgcmD5rpLeUaYzwt7dvbA8ttgjew8pCQD8nMAOUQ9YasoOYeExxAdUVDf11SOteb04MYeqs4E0UT61t6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prwXswgIIP7geeepjDGFCN8PML+yjPuU3Gphdl+uWrI=;
 b=lJ+0qgok5C/POhRbieZzuRVJ59JNaKdsMPxPYQoSPI7rEmcNudPq7hVZMOG9fJ3FJK+VbvJ6XsNelAgEXUHZJmm+PNvmHdQSqTilfjKCEmVpoHv36VwJJNiMuSye2i+N3GlSxCzE97oRRf0RfwH4RfStOLATDokReAjlPlKQMX4=
Received: from BN9PR03CA0601.namprd03.prod.outlook.com (2603:10b6:408:106::6)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:13:36 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:106:cafe::d7) by BN9PR03CA0601.outlook.office365.com
 (2603:10b6:408:106::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:35 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:31 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Muaaz Nisar <muanisar@amd.com>, Sreeja Golui
 <sreeja.golui@amd.com>
Subject: [PATCH 09/16] Revert "drm/amd/display: mouse event trigger to boost
 RR when idle"
Date: Tue, 3 Feb 2026 23:01:51 +0800
Message-ID: <20260203151229.3673042-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3e92f0-96c8-4060-6ea3-08de6336cddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2aF0+iDDoq3K0PJMPEJv/add9KRlQ8p3q+MM7C9UmjjM4YPSoYhncxctEi3y?=
 =?us-ascii?Q?OzSrRrZ2+YIYtPBSv4GpPYwufDY3KTWBlRowj7CFecmF6z/jyfGP83b/p7Cb?=
 =?us-ascii?Q?JEhL+etoVu9iMbgCniRy6Szu2xikRgwMOj1jvD1rZOSt+vKICT2+4XW9eqmU?=
 =?us-ascii?Q?gA+B5ns69cc1QF+ELW6bsByWtmQBbzXSeNQTP7jcqOZ+kh3An114ax77BzXu?=
 =?us-ascii?Q?w7vQ2K0k1YsmRTBm4aeiZkucrQAVA9n+UpZ4p9jvQfP8OmmUWmG8zvFo1VjG?=
 =?us-ascii?Q?RUx/ik26XjTuoi+erWN5yqrmrxtNQD4GbrllpUER5aWg1K572Tay2CuSylbJ?=
 =?us-ascii?Q?azqqXUovh9xWMBlXd2ZE1bsC6Fu10Efe8MMHw71QhlHbq1bP0V3aMoHtElso?=
 =?us-ascii?Q?Sptdv23qRYWVdiXs7mtSBR3iqHSmeDon0iAzb+9dQxtuA7jNYom0p+31PlEL?=
 =?us-ascii?Q?7VfiiVGkFcKf7utl2qPKytpsKUJfy+0cJcvl3MksMubgcDYqzdyYlss3xTaQ?=
 =?us-ascii?Q?z2gKyVHl5mSm/MnOATR548zCLzvzPV1SXnzx4B1TdiE9dOKhnebPhfPoYKh4?=
 =?us-ascii?Q?I1z/kEHs3rFaGQW+oK4AEnkOXq0nJCDUIdHhh5lZwjI8A9ptPMruSylIuYsZ?=
 =?us-ascii?Q?6AcAKiMd7oN+FGfip15ldD74mM/9nM+wqaidEpZhzQ3YqKeUfR6Ik1xnT3Ho?=
 =?us-ascii?Q?8CUM2c19T3iXrmqthwYaqHHZxD0cQwlKGAzIi4ClJMqKQNHJ/ac4/FSCIBk1?=
 =?us-ascii?Q?daDBzR/PbveKXKtHuUK3B/5QOdQLHPoK0wr1Qth581kU6rUgBWRMy2k0rIsh?=
 =?us-ascii?Q?giYzNqfuhPLChpsazcOQPnypcxD6RPDjtXzs+f1HGWRw+KOUDWAXVSVI0XUh?=
 =?us-ascii?Q?U3hO1Buh8ZSlez/xD2mmFBMWajE2iHXCdNDNGBanMpXcNBnl0smQ7QHixKnL?=
 =?us-ascii?Q?+IQPy+eYQ2GLRfb3OzEwhJNYOg6N7rPfV5JPvvS+B4V/fLSK0IF4armFX8tI?=
 =?us-ascii?Q?UtdDQa5PI9lXAann6we2zwtzPyV7vOwGQa1rvHQ7m/dcYck8spc7eUQbVi2W?=
 =?us-ascii?Q?PMoXqBlChxPlGQSs1701z0uW4NqlW3al35dt9qSo7pUBRg8U2B++FCAuzYMU?=
 =?us-ascii?Q?2li9dMl5jh83RKYy+uKhsdqMLYWs+Ir/6Z+0OueZ9xor3MJ5vQDJjChv2bUK?=
 =?us-ascii?Q?XXjy8P9+/JZPMalncVXuRYIKxJapRcLRwbGwwY6XmLaiJnIAEJIeE8UUgrO4?=
 =?us-ascii?Q?6JbrqLfTgy3nvJSZRertphuP9oquMQ+9gQ6V9kRzC4HP2f7uvGCElPi2mywE?=
 =?us-ascii?Q?1qmJZ82MspheWpc6twNyy+ltVaXd/pqP+OGpoYUKCV0tQjmReXhTpyEk55yo?=
 =?us-ascii?Q?EyRxdkf6iZ5kEvk0bKDL8ipQ5tqKUFIzIjIzCfDcY7X1qUJJIyumWXKQuvyR?=
 =?us-ascii?Q?TA8jRpnEaNUKLUEO1ma4MFMB+/yxToGGudtLeiBv97mSeFVNv7bp5T8YWfED?=
 =?us-ascii?Q?18TqmGjv2XUSepFfzqwniSRCguKrGEAeIEG9OczUmoBnJaq9fNKCAp/o9ZUB?=
 =?us-ascii?Q?SjYGB5pQSVEF3Kf5MfWsRUbQ4JGBqSE2mGGfAmJLa+52aq4f0p9JkYG03ynm?=
 =?us-ascii?Q?AYQYeNoLR5oG1iJtsgrGcBFyHtQSOemVqkmKRu8gewA26LebYdPxM19go7gS?=
 =?us-ascii?Q?tCFazQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gV3Etqva/uojk8CbMg8riZGACuPVJGsjS+3s8MsFgvy5UreoawZjmFrTkwwGkFgXVe1f+VFH2vdCG2ds7FF2NrWE8L3uUNdNBiOV3m4ekGrO1O+kWVWJcWZG7XBSn0yhTXmHHeB5yCkw7ROTFDQphbm5OusZsl/vWl/WM/8pCfRskIOEEtAxUESlT5QgYbXKTizaz8lNDvopiPMRhpop2c3jJj6POP+ztNy1QaCIdt86pXuNrdg8jI9enpB/b0K2AC3IGvrYLWJvOGtkg/GGHA/ao1+fmMj7XmnnXlM1rRbA8swmZ/lk4z2TMnyJIFOpROo2gftkp4mOeUQKKKN/38CfsEsxkW6Pkgy/Cy+i9GfR/fapesycqo9VagVjt2SHkoVy9UiI5VP784liOXT28M0sv+9AfhLCgsLEZ4VMqTwnNVIDezIPV3bJENhixjeo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:36.5922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3e92f0-96c8-4060-6ea3-08de6336cddc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
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

From: Muaaz Nisar <muanisar@amd.com>

This reverts commit 67f77421bdb59680ff047cb230a4f00946539e6b.
It cause some regression.

Reviewed-by: Sreeja Golui <sreeja.golui@amd.com>
Signed-off-by: Muaaz Nisar <muanisar@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index f59020f1a722..9349cccc8438 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -515,19 +515,6 @@ bool dc_stream_program_cursor_position(
 			}
 		}
 
-		/* apply manual trigger */
-		int i;
-
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
-
-			/* trigger event on first pipe with current stream */
-			if (stream == pipe_ctx->stream) {
-				pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
-				break;
-			}
-		}
-
 		return true;
 	}
 
-- 
2.43.0

