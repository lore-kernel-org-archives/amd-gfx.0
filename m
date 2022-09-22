Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1F6C32771
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3552010EA0B;
	Thu, 22 Sep 2022 00:20:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A12D10E9F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQ6fcxAUMGsc/5vSgsIHHC5LUxK28aB3rQJ0vhgEyOb5i3am3MMy11f5kDa0viPgFSO0OLMCrzMRvsOWh2L2AQWhUEBQql8WAltVXpbxt4qHWj5yPSvT9108nMlH/TRL0RaGaGlp/t0CyGG1oUT71zalQKg4uIbvtvuN6pgeMuvNV0zb3IgaMfZu1dcDzDPHSlg8aak+z3ibYUFQ5weLgRq3W7lgdWnC1zn4vrczohvYLwwiBjEt/QF2ysBm9cAi5d4Bblxr3JwNgPQ+mceBuFDehfNLHSOUHcj0No/oqWBtj1jKOZZYrn5Usr/5EkpaxFe9a/poAgAwl0hGboLkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpCAWULtQjLrjwpWUhAj2FezVwhKV3uFmTPV6v9eKtU=;
 b=BAABtVKkwOTjN9Gcd2DxYkx4qja3z6JTPz7V/CLtdbf2vwbzADbgledrblQyYHC6KbGWRhJgBCk8iC2+aKgDuNEuoKH4ZTb6PYGrbxdD4OYJ2E4CUaSNaVOBg0ol2HrFqk55HUhoARzIhuF4JS6BufN5V7FWdOHAZvzfua5hNdEsEfILmDuVDMaqkytUkGnd0O+A4NFBLd82P1TJogtWAnfjFoOKT+P2nIKq5XdGuKLcWehwIdjDdw9GbPdn/tGddXlgs4iMMkakjkTDBfFD4HWb76kt5pkFmfyw3LAff+zyo3kRSyGr2SAtimGU9UCnjGaPjGDkkgQrOGjAsN2LWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpCAWULtQjLrjwpWUhAj2FezVwhKV3uFmTPV6v9eKtU=;
 b=WarnCXFvUKk1+OAo3ESWP3SS7COIGkmSTa6Gg9ImmXkljzLHCkOGAuSo41I7FDxo+vI+vo/gWVUj4/C7sE5NgkSPH14DeInG9+nYawmVFpYX7pgJEb+2A1MO8RoCFaE2Twr5TqucGPrlfpmOETV8JlYGr1L1RPzAc/2XLXsrYJ4=
Received: from BN9PR03CA0181.namprd03.prod.outlook.com (2603:10b6:408:f9::6)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:19:08 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::33) by BN9PR03CA0181.outlook.office365.com
 (2603:10b6:408:f9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:07 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:06 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/31] drm/amd/display: Fix audio on display after unplugging
 another
Date: Wed, 21 Sep 2022 20:18:04 -0400
Message-ID: <20220922001821.320255-15-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb85a93-6aaa-4a5d-2895-08da9c3010bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQzH2pKFPpWS3IPOWZInINAAvx6HyfoZwQJ4k62JrR8uKu/S0gLx3dv/ZkIdq9ON+ibBtO8DFlgKN41WnzUJKOXOoM3K+m1rXYZT48urHzk/YA3N6rart00/tA2dPMZkxf8NTHkml4CkHovjqq+kxlJoLyXcjK/K197I3iILeUpOxJLlZJpI804U70bhePQlhBgH7T7RIbxJ5VBtPqsgy9bgzOO9HugNm2PPT5+1m8gury9mAIxIln5lrwjUfc/PMywkOiCTS3VHGzdOyqhzKlgldpqbeQK0GVcZjnhOiLBo5sQV5BOjglz+dxgyB764pAbldWaPfVBN8mdMr7moHLCuakIF8yn+1GMR0u6MPpNoomkbMNuor1x8W+cO8y/r7YBUtdSnvAbiIyrQqvcqXvNzo+oRJIUEDDBa9yZXQKYj0C5mK7Xl0zkd0BkN0GCfQhA5030fQN9becTDnLSHWzLQZzDHo4xQ2vyYIj5a+ecpW4ShbT6hgsOCguEuF4d5xXettAU89K2yHaAVV6GpdYHgw/qnhqOtjfhZun4d02oZK277CDdVcmt1EKOZGH4QpqZUlNX+CJ2ae5MCLBInvLoLS1YMliZjzj75DSi+K0JPvm6vq8gPwSu1IJT0hcLg7Aj3CvP1z1ZNU4Mlzsb6d3T+Jxt0ogD5S/IKsMshUYrGSanK9IIUhjl29UGIFUiXSiNY+970af8/gS9d0tmqP1FCeqbot4UwRaHrA6gyDFaTxT0IANTofn/Jpf8Wz2IPoPysDu+u6oXxu5KvNbWM2K20jCfwv/roUcAK2NzHVcYgY2wsi69uAU0a111B0AER
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(4326008)(316002)(54906003)(6916009)(478600001)(70206006)(70586007)(82740400003)(5660300002)(41300700001)(8676002)(8936002)(26005)(1076003)(426003)(336012)(47076005)(2616005)(36756003)(2906002)(186003)(16526019)(36860700001)(83380400001)(40480700001)(81166007)(40460700003)(356005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:07.8916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb85a93-6aaa-4a5d-2895-08da9c3010bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Revert "dc: skip audio setup when audio stream is enabled"

This reverts commit c83f2553273a796b62411e73fb4fe19ec521f8a9

[why]
We have minimal pipe split transition method to avoid pipe
allocation outage.However, this method will invoke audio setup
which cause audio output stuck once pipe reallocate.

[how]
skip audio setup for pipelines which audio stream has been enabled

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 2341982ee0a5..d260eaa1509e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2178,8 +2178,7 @@ static void dce110_setup_audio_dto(
 			continue;
 		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
 			continue;
-		if (pipe_ctx->stream_res.audio != NULL &&
-			pipe_ctx->stream_res.audio->enabled == false) {
+		if (pipe_ctx->stream_res.audio != NULL) {
 			struct audio_output audio_output;
 
 			build_audio_output(context, pipe_ctx, &audio_output);
@@ -2219,8 +2218,7 @@ static void dce110_setup_audio_dto(
 			if (!dc_is_dp_signal(pipe_ctx->stream->signal))
 				continue;
 
-			if (pipe_ctx->stream_res.audio != NULL &&
-				pipe_ctx->stream_res.audio->enabled == false) {
+			if (pipe_ctx->stream_res.audio != NULL) {
 				struct audio_output audio_output;
 
 				build_audio_output(context, pipe_ctx, &audio_output);
-- 
2.25.1

