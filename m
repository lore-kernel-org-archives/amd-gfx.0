Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0EBC0219D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB3010E3B4;
	Wed,  5 Feb 2025 18:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vtZgIsYG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C6B10E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipARsV1d0ZQsXJqIScIf2jjQutte/awuejWmKSdWQClLlX+z4w0MfI7731zTG8l+GjaxrfoD3WOSwMZ217ikn06qrmIz8qN76lOaulWcxP7yKXCNrw9YVkDugETkzfQ7F191KjVbmrBeC0q2TQqXBds4wKvYXEkgAAhN7hg6rfpcetKkZCnCnD6GPN8fHtMIobZ8P5rF0Qauo8H1y5js+aGnMZsc8jb/+MpSQOFg1aDDEi6ixsCM/jfSobAurbx+hYfGrhQxqmH1alflT2xX76yTw1yEnTnvhs095x/duiFKKVQ4WerNjNPSfvneJc6K9EdLmId9ACINfPVD8vmsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtUPTJeq3X1AdGJZagZoUCj43Pe5ILvTZY3JUxFZmEk=;
 b=A1B/f6AHYk/y7QnwXH0q4deDyOkNI8g2PSdrl5sFvXVstQrC8pw1vfy9yli/Zxgw8+2aUyLgh4TciG9c3xI27IFHBqEewOMKPJSU0C4PwaodEemhBXax2tnT/jj/av3pBBBnEGEoiLBc3scvmFHpxqcuh2hrwFWOz/KWOzxzsKockbX78fxwOHWXTemhVBG5Z7pj+HlITbthraY+/KkObXr+Iew7X3dPA9E0NCRO4UCQXL7+vXJ5d87lWHZRCdNU+fHJNN8Tfzl2nENBRSYI0Ro92sJ3xGg+P4uaKycTQOG0AkzWPbk3USEGKony72QgcqCAnOCFKaiOpBwXEbM4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtUPTJeq3X1AdGJZagZoUCj43Pe5ILvTZY3JUxFZmEk=;
 b=vtZgIsYGn0o7cJUYOUwHwNbLXdQNG5gxXXkuD2ozMueMfYOPbhyEGtyR5AYzmstl40rjpdHPxg7H1HFz+msULIdxQJgBdp5OMN5fnYFRbM3L+meTAy94+yp3+DkGykafFDUcyX+XequgGIR2CqSPyt7s/OizbBiabddpASBvBWg=
Received: from MW4PR03CA0032.namprd03.prod.outlook.com (2603:10b6:303:8e::7)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 18:41:16 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::27) by MW4PR03CA0032.outlook.office365.com
 (2603:10b6:303:8e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 18:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:41:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:12 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:41:11 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Karthi
 Kandasamy" <karthi.kandasamy@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>
Subject: [PATCH 12/14] drm/amd/display: Make dcn401_program_pipe non static
Date: Wed, 5 Feb 2025 13:39:27 -0500
Message-ID: <20250205184036.2371098-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 497d0e65-c382-4536-62bc-08dd4614ac2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sf3IHvTvgLlLZtYx6e7AibEoyijoImSYY4bxbDVzH668f5yFLQ6on4wZxBpY?=
 =?us-ascii?Q?5pQiq5eDsW8NRNBhZiK4hFushEYJYj0d1Ug6C1Zahto7VqhK3IemgFoNqmmW?=
 =?us-ascii?Q?IQrWhJX7rA/ySoChSc80+Dw3/CprV2tEAB3jUZ7YCzY402lLFJLEMCeRLEiH?=
 =?us-ascii?Q?3TD9xPNV0SopkjEwxrxbbryODhqONicc61b0HqYJCZQisRWc7W44WjkTYBYh?=
 =?us-ascii?Q?qepmIkVKT4no9vVN1pktxvhgaNm15e+eYTKbO3vba6id1s3n03sm5yL0zkba?=
 =?us-ascii?Q?MOrt9Kmz79jRM5BsXQim7F2J2LT7fOy5M7abK12mXc0ayPHo3Pxc73iX63T9?=
 =?us-ascii?Q?Oh9f2Hsb/4VBDDoV5Yj8aj5HbGGcTg8QGvB//ZkUheQ3V8sThwze6KAJuxg2?=
 =?us-ascii?Q?iv0sEA4c7vCi5x2nCxEGdqMgUUHwaPaw1cvW5e7jHYX348WQWduDVgHa0KDY?=
 =?us-ascii?Q?gdTYZCZ9BZoeAEUT/QhxnU/dNyneJYLWhlmPcFGZwLKui7fEN4CuDBuaAilK?=
 =?us-ascii?Q?odj7SZvZJq8pcPVQvIjqpfdRBi8jFxxk0ggGD2Um9ZOTomFTF6FXTIxgXbzH?=
 =?us-ascii?Q?v+9MWJ2wZIAno67QGfDrkVLoWXBXt+KfR2ZOXNEnxc1KHII7Dcz0NBpHa0cX?=
 =?us-ascii?Q?1pX1/3Fp2QnqrDevoVY8KAdWAlrpaQc3Zw4sCpXFEKBRXzSvfWCcc4MN7Y15?=
 =?us-ascii?Q?ZcSY7KR6mB0vIHhPuFIu+X+lhuVBD2HWyq2csz/G/PBvJOgWgyHQPK8FcIZ2?=
 =?us-ascii?Q?CadpXgktAqY0/HTIVB9h67Yg6veCHxbTAlL2SnF/gEIC7X45sqgd7dwpProj?=
 =?us-ascii?Q?OJxR/R9wjlOJnZvYguw1KNJaeJtX+7HJg5DtstPbAD74qI2QEANF+CtmL3zk?=
 =?us-ascii?Q?+EWpWU42lLdl1T7N3gZf+CU8awgxSJy+W5e6KApe/eA66tZcn0tyPbVSyFAY?=
 =?us-ascii?Q?zZqROAupeCVi4iZiTwrtKvazmyLHRkjDvCy354VWC6omv2oevaaaanSuWECh?=
 =?us-ascii?Q?TBUgg18VH+KVho7aAspVuz5WRKHo4GOeEJHWCvbkzhcNNpFzv2vCj/u5IYP8?=
 =?us-ascii?Q?m6lIxQwagifKViA3GMX1UlRaEUl5g/9tvKIvzgvv7/JmUnMTLJrJXiLXPe2I?=
 =?us-ascii?Q?wHY28XGjo15HSzyPeoYsWqnx/b6bcHSe80qb45xPmVeIG2xImYddDo5Gwhwq?=
 =?us-ascii?Q?RLdO3+yYaX2vd5f77XM5KN4QYE4HLdRUEoUKLOr2Zh+OCJy1jM3HZl8NQy7u?=
 =?us-ascii?Q?IQ4hzDqWPjAsRvLHJlbD2wPI6FpI+6Rj/5vxZP0rzkPgaKof13ufYkBY40qD?=
 =?us-ascii?Q?/8mFcbzZwfnVUJ3uas1y5FUUUWO6jL5ffZSs6p/pYhpJpKbz6fIrCpSm6sxk?=
 =?us-ascii?Q?h6Tn2308b1XChjqP8GePWIHAsVtZ0XGa5OLLQCw/6E3OwExS6ORH3PxaUMlP?=
 =?us-ascii?Q?ZVIBg/C+k3oqhCpdw2OE+Cll1CW6nSYMgVi47d/7hOnNIhIFiWEy3Icqf5PT?=
 =?us-ascii?Q?FkH0xm7DTgXcA/w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:41:15.6730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 497d0e65-c382-4536-62bc-08dd4614ac2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406
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

Allow reuse of code by making dcn401_program_pipe()
non static.

Fixes: 0ed6d68efd76 ("drm/amd/display: Allow reuse of of DCN4x code")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 8ad0ff669b7a..c4a37a95e812 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1934,7 +1934,7 @@ static void dcn401_program_tg(
 		hws->funcs.setup_vupdate_interrupt(dc, pipe_ctx);
 }
 
-static void dcn401_program_pipe(
+void dcn401_program_pipe(
 	struct dc *dc,
 	struct pipe_ctx *pipe_ctx,
 	struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index dbd69d215b8b..781cf0efccc6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -93,6 +93,10 @@ void dcn401_reset_back_end_for_pipe(
 void dcn401_reset_hw_ctx_wrap(
 		struct dc *dc,
 		struct dc_state *context);
+void dcn401_program_pipe(
+	struct dc *dc,
+	struct pipe_ctx *pipe_ctx,
+	struct dc_state *context);
 void dcn401_perform_3dlut_wa_unlock(struct pipe_ctx *pipe_ctx);
 void dcn401_program_front_end_for_ctx(struct dc *dc, struct dc_state *context);
 void dcn401_post_unlock_program_front_end(struct dc *dc, struct dc_state *context);
-- 
2.48.1

