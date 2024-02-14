Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369C9C48BEB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96EE410E701;
	Wed, 14 Feb 2024 18:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5bn4Uexp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB7310E69C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn3OTaGpTZLuw57tLbwZ8RDFVHcUkPYr+uIcq8NhCBVxZO1JqkbvkmZSZyT9dHCLN0ovJqKZSt/tCorGtnMtC0PuKXQ03h6KMqmpRfVKRTwFYZhvB1NNEyeZWrj9xDU2k58hVXFciC1vdHXZOIxXz7ojmQOBmeo0xQ9fKmWtiQUR2OfWnLiCOemG8Th0MB4X0wC8JVB1wiFpa38kxrXTrgqsBpif2/HX3iYY6gP3dERYRmkXLIHptqfC/uL4peRokgc/s2QE2VCnUESRkf89z0BnfushJVraEjWhRXOLsz1AMgvv4yUr6WSWUrSc8ldQqJZNEe5jDbXp8OjU9zsUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW7mD+9vAzI1uJvF6ZUtV45TVWaNaETXWO5pHjNUw2M=;
 b=LZ4IfbB/FS1i4JCUQM9/EQcJaRsRVWOr57WCp0Te6abC3MeCAmFN56li9E4csGgjZRAWp5piYGw64bGmeqMBzLkHU0db9bzZeJgQ8GM2SBFDwO7waLpXM+/TCgQcEz+CTrX3Vu3+zu0E+bm2niOgrVIZBQLHuuHmC/NzmeqLIeFZ3RpZcDXjc4UnBTVTgJ3gjo/X8wC0qVv2ZusQnvGBEmZ9nebDeJFEy46d1wOkZA24fy+WgOK74E1UI7et0+toV6dlkGm011Fung5Ti/mnCdG6/6fNnIn4h/nOkboLFHY7DF+kaMuUV7CLUZ0cNtVyeyKQBUZqeR1RosbvShRhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW7mD+9vAzI1uJvF6ZUtV45TVWaNaETXWO5pHjNUw2M=;
 b=5bn4UexpvBPMFdFaTbj21IUy+6luBx7S3nK2APz9ES/VldKdfg8Bs243y33ejuba5/eVvj2HV7eISvvcdiVE4k08vfd1Tj+9pNckZCzSXxykLoEjaULFxyGg8n5jWXaZNrYGa31Kc1rTA31rcKUKef/1+4a3fGUdGBw56Pg1HU0=
Received: from DM6PR08CA0042.namprd08.prod.outlook.com (2603:10b6:5:1e0::16)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 18:40:52 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::e6) by DM6PR08CA0042.outlook.office365.com
 (2603:10b6:5:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:52 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:50 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Martin Leung <martin.leung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 14/17] drm/amd/display: reenable windowed mpo odm support on
 dcn32 and dcn321
Date: Wed, 14 Feb 2024 11:38:45 -0700
Message-ID: <20240214184006.1356137-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: f1728130-01ef-45b2-cb8c-08dc2d8c7890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3858gafqNxegUN/bY+mwpEgYRc/EGaVpgdgJOxh0CSPb6Sl1ndBjrAySceF7sHGQkCNjE0qNW7MUVElrQ6u4nNTowHE1cW4yoMVmo0wskAogde2IkonZ0tfACKbvURkNdeU82uIg76+dWyTpd4ISkS6PSqdxGa/Xf29nNRZDgqoMJ9mkRlw6XItBiNIuiXwSXdQh9UAGWwDcCf9ffc8AKh3S4uHIgSdff/0H2pILxNyp6wJeNSCjymCq080kQr3ePNXv006vTs7HOWt+KfSxHOEcrLjtS2JI3xX2DBMBhhp8NKTuVpN6ztVOAF9Fc2qXRqmKr2a+i0xdyw7rtNnt6P9ZiizMZ7De0+d8gB4oPRXdTAhBPqctkpkEsGWsGEHTb66ii9YS7XQFnrk3ZZDzlcGOOrs8AouSRhDm6HKI6J6grH+8Oh/YK+mPGY/AFtr0SBdk7YuJTMWJnz/m5hjG6tTa4sF8ceCbx8jfc9TOQol3iyPRvaScCrzxFwrtBP/+R/DAzW6WjClcP2fJuw/UalvxhfTNEqhwALOsno+n/5XuATsd2Emw212BZ86pwT8nhxenDvDmYfCKpZ11DyKFsCW4vrAez1Sg5DpBF2zKx0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(4326008)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(356005)(83380400001)(82740400003)(81166007)(36756003)(2616005)(1076003)(54906003)(426003)(316002)(16526019)(6666004)(70586007)(336012)(6916009)(478600001)(70206006)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:52.0256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1728130-01ef-45b2-cb8c-08dc2d8c7890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
The feature was disabled due to regression found during testing. Now
that all the pending issues are addressed, we are reenabling the power
saving feature again.

The feature optimizes dispclk level when user is using MPO capable
broswers or watching MPO capable videos in windowed mode. The feature
achieves power optimization by utilizing free pipes to process incoming
pixels in parallel. So it reduces max dispclk requirements for each
pipe.

Previously ODM power optimization will be disabled when MPO plane is
present due to technical challeges. This is mainly because ODM divides
pixel workload with respect to stream but MPO plane position and size
are arbitrary with respect to stream. The pixel processing workload of
an MPO plane is not guarenteed to be evenly distributed across DCN pipes.
For example if a plane is moved inside single ODM slice, all the
processing for the plane is distributed to the pipe in the current ODM
slice, while the other ODM slices don't need to process this plane. If
the plane is then moved to the middle crosing two ODM slices, each ODM
slice gets half of the workload. This is especially difficult when the
plane itself has a large source rect which can't be processed by single
DCN pipe. In this case we can't enable ODM power optimization when the
plane is only within one ODM slice.

[how]
To overcome the challeges, new pipe resource management is in place to
make sure a plane is validated with ODM power optimization support if
it can be validated regardless of its position and the same pipe
topology can be used regardless of the plane's position. When the plane
is moved outside current ODM slice, we will set recout to 0 so the pipe
can be idling without the need to update pipe topology. When the user
resizes a plane, it may result in downscaling ratio changes. When the
downscaling ratio is above single pipe's threshold, we will seamlessly
exit ODM power optimization and applies MPC combine to support the plane.
when downscaling ratio becomes smaller, we will seamlessly enter ODM
power optimization again. All these pipe transitions happen
automatically and quietly when the conditions are met without any visual
impacts to the user.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 6f10052caeef..3f3951f3ba98 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2118,6 +2118,7 @@ static bool dcn32_resource_construct(
 	dc->config.use_pipe_ctx_sync_logic = true;
 
 	dc->config.dc_mode_clk_limit_support = true;
+	dc->config.enable_windowed_mpo_odm = true;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 6f832bf278cf..b356fed1726d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1760,7 +1760,7 @@ static bool dcn321_resource_construct(
 	dc->caps.color.mpc.ocsc = 1;
 
 	dc->config.dc_mode_clk_limit_support = true;
-	dc->config.enable_windowed_mpo_odm = false;
+	dc->config.enable_windowed_mpo_odm = true;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.43.0

