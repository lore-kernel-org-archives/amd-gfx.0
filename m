Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C796C47256
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1682072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P6reiwsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1682072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7577C6E11C;
	Sat,  2 May 2020 21:34:51 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760074.outbound.protection.outlook.com [40.107.76.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA106E0F4
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPhCi5g6L0i1SozithmSaBmSY1V+vMvhUEQ7wiTmCu9nTFsEvA3Zrg02ZrcpaPkkn5hmvgQuciVGroP/sOciEv0+36MqQ1NoJhgSTfcwGHCo3xFxWzLfK7ZcOU6zLoDVWTa2OcIB+Y9JsOZJ5rwwdXJ/DN09UtLiS7zgfEHQZThyiooek82jhwjIyEjNHRWymjbhaN85IZP/npOxbQOBuReFhTcflPZEeu08xcVoAqNhQvkFIxSc63qllHwhicI18ihdIIR4t6wDtCXFnhq9QiQBMPr/vET3naoBKm3y+3O30yO6w/DYPzrThkg4/By6L0uosRjnfvPiVFROfLwcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWjyWLo/WppgiIy/ZloWZ1sPmb7vqNvLAycPUWH5UjU=;
 b=APJghaIkkf8p9r8/pTbDU5CS+wZbd7WKVRZGFkLSYm8yuiDPQhq2kRdXfY4IgxNyYGAaSvqfDJ8wgslWvV+BHT7v+t9gu9FHFLp1tt3es03AGPs4SuQcRVy+b8JoGlTVkkx1G8s9octK05Zy7+vY2MWFTSL5cI8ts9CcBbJCSPoyv79MPweNDuwPj2A7o4q/pz4645fMIprMd/IpskagpwhlQka9ZR+7fYfPHzqqIfOgOwZGhZEG7rdmwuJsMTGmDyiMNE+XipVSm3px0bLSNaTdc9NpeVA5X/Kf4frwiKbt6CWTibD/5/eS5oowrWqzIm99f4kW4zyH6mGUBdAt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWjyWLo/WppgiIy/ZloWZ1sPmb7vqNvLAycPUWH5UjU=;
 b=P6reiwsnI7n8IOjtLHha7laDPdX4kS+VTSllqPEJFubBPekY3em+iIAq03TcDJhd9K298Z/2DTGf6/6nPXK8FVuTGY0gV1ZbooWOaq5YbRe87TiVA7/PygTB8KIT56wTsNb/8vMOKWdPtFli1iRnUnUXj5AZUzxysD/7OXUbG04=
Received: from BN6PR17CA0045.namprd17.prod.outlook.com (2603:10b6:405:75::34)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sat, 2 May
 2020 21:34:48 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::e4) by BN6PR17CA0045.outlook.office365.com
 (2603:10b6:405:75::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 21:34:48 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:47 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:47 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:46 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: Update DCN2.1 DV Code Revision
Date: Sat, 2 May 2020 17:34:29 -0400
Message-ID: <20200502213443.39232-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966005)(44832011)(7696005)(36756003)(2906002)(1076003)(186003)(26005)(54906003)(6916009)(316002)(86362001)(8936002)(82740400003)(5660300002)(8676002)(70206006)(70586007)(4326008)(426003)(81166007)(336012)(6666004)(478600001)(2616005)(82310400002)(356005)(47076004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b176acdd-7f36-4417-65d9-08d7eee0a3bb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4268F8A96B855948FE3DC7E98BA80@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwpVaxJbHUU0RbTIqbqFp9VmNXjUAw+haotyC9a1lEMPMEBAI4Jy5zQ4+wVQj/QEboGCwgV4rLeeLTqAxwFUQzGTfPNT8l5q5ukkgosSTN6sDanuECm0221jb38GD1Akd2PtLm4bTxiUHBtZ0cb/dM1ztv2ETYf/xxlkGGhcLewjJWY1lhoHwJVtTfcTkM4/Qp4IsiRAdiqZlqu+9DdkubVkJv5gRf6lVxrAzLcdw7g4dyLUoqkXuLzt6cnQ1i0vCf4oKL/GikxsFkktogi7LLtwQLMyHWVWJabdNh6Yuw6petUizvaYsxQXnXbYBvyMFCAfVuGW2zH1lVAIezQpf+IjAgWW1zyDETlQPaRQnUFn3NPXIUXzkmaFpnr8B0V58jfB5XsnxicH7eYnS23Ejqsbimq/CWgdXZoFp3/rEdaNEURxHd1bMbDbiR5k/bjI8os8RmiRU18sQlfyU+rH+0TB1hTtxJZ7ZaOVw0xq9ehMw2dlr/vyWGzb7hfBEQPVxQyGvmAfeWGKYiCO3MokNA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:48.2837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b176acdd-7f36-4417-65d9-08d7eee0a3bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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
Cc: Sung Lee <sung.lee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY & HOW]
There is a problem in hscale_pixel_rate, the bug
causes DCN to be more optimistic (more likely to underflow)
in upscale cases during prefetch.
This commit ports the fix from DV code to address these issues.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 193f31b8ac4a..90a5fefef05b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -1200,7 +1200,7 @@ static void dml_rq_dlg_get_dlg_params(
 	min_hratio_fact_l = 1.0;
 	min_hratio_fact_c = 1.0;
 
-	if (htaps_l <= 1)
+	if (hratio_l <= 1)
 		min_hratio_fact_l = 2.0;
 	else if (htaps_l <= 6) {
 		if ((hratio_l * 2.0) > 4.0)
@@ -1216,7 +1216,7 @@ static void dml_rq_dlg_get_dlg_params(
 
 	hscale_pixel_rate_l = min_hratio_fact_l * dppclk_freq_in_mhz;
 
-	if (htaps_c <= 1)
+	if (hratio_c <= 1)
 		min_hratio_fact_c = 2.0;
 	else if (htaps_c <= 6) {
 		if ((hratio_c * 2.0) > 4.0)
@@ -1533,8 +1533,8 @@ static void dml_rq_dlg_get_dlg_params(
 
 	disp_dlg_regs->refcyc_per_vm_group_vblank   = get_refcyc_per_vm_group_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;
 	disp_dlg_regs->refcyc_per_vm_group_flip     = get_refcyc_per_vm_group_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;
-	disp_dlg_regs->refcyc_per_vm_req_vblank     = get_refcyc_per_vm_req_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;
-	disp_dlg_regs->refcyc_per_vm_req_flip       = get_refcyc_per_vm_req_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;
+	disp_dlg_regs->refcyc_per_vm_req_vblank     = get_refcyc_per_vm_req_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz * dml_pow(2, 10);
+	disp_dlg_regs->refcyc_per_vm_req_flip       = get_refcyc_per_vm_req_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz * dml_pow(2, 10);
 
 	// Clamp to max for now
 	if (disp_dlg_regs->refcyc_per_vm_group_vblank >= (unsigned int)dml_pow(2, 23))
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
