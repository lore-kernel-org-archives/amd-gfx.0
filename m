Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AF6C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C09910EAAB;
	Tue, 10 May 2022 20:46:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F218610EAAB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBmDGyw7QTtBGvovkV260wH4ipsqsHp38ZQi4qrkXKmWGnvDhtdIAVxdmychx9sjPVHuAGibC8jalTLwki1kNG/MDJpSpBualUt23UK0yzX/vAq2WHhiCoiEHdoRTw/1zlGw2oxxYbBk2ZsYjzH6CVwyaiSqBoVZgNoFNf0witvCQLmIcKu2aLmH/hHxeYG7zwVqFcnrAMUG2bkueUzRhdwX5CcVnAuCJnHQ2RdYn04AFm7jRzhlYJXgV8C3qNtii8QItys9hIvMfaYe3y2dNJ6CVMbtyffjNux7kM5trJHH9mpZavs0XbSh9deW0fcw7l90+xxy6aydftVCX7C4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNof+IDnAD8FpN9AU+Ka6P9+h3ULjjk557M/jtSGRvw=;
 b=NUK1XytXdmwfAJsraLAA/iAbFfdddHTCn2Vns/fKU2Xz09aFrUjNfu8Q8z5lrTN37Q6SvwE2NfqCNuY1ktyk2HMEYV5YdkX1M/9V1hBG2OhBJ3Nk5fBFnPM1oIF4VHlIZQRDAG+RK5nppiB+K4gkCVMn5LUsMH3ibM/5QNZ90IZdNnduedooH0FP0dSLtNxbOKygYKD3iulXUj2AH5TSXGtxZuuah85GpEeIHZLsdDseeDaV/lzfF3ktc5X1kxsIgjt7FNw2xHz5uyMOe8jRnjBwrShfz+Rg7ZzwRiANFV+9zql5MlKEGn9RLHimJbMtHr+1a6SULESzS675ZYJx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNof+IDnAD8FpN9AU+Ka6P9+h3ULjjk557M/jtSGRvw=;
 b=rBAuh7M7vQOenFipfjVdMzwwLrmS4D/qEsabWbV+BObji89nFv4fHj1E5mRT4KIcc74VatIAF4tA8n8EQCIHAiuhEGYnw7ARHxgcQ34n9jVIUgQkoAtNb3tTEi7RQNgRWfNHI2vMUxR+w7b0u4lqCeUEXekPNvD2dEKaXbY0H6Q=
Received: from MW4PR03CA0295.namprd03.prod.outlook.com (2603:10b6:303:b5::30)
 by MN2PR12MB3037.namprd12.prod.outlook.com (2603:10b6:208:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 20:46:34 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d0) by MW4PR03CA0295.outlook.office365.com
 (2603:10b6:303:b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Tue, 10 May 2022 20:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 20:46:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:46:32 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:46:28 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 15/19] drm/amd/display: calculate psr config settings in
 runtime in DM
Date: Tue, 10 May 2022 16:45:04 -0400
Message-ID: <20220510204508.506089-16-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d2d0250-7f39-444b-d76b-08da32c62bb4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3037:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30378DB961FF39045729B22B8DC99@MN2PR12MB3037.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+I/cICUm38h6SXehgSrSQiNTRlNkfDgTDZeaYS3+v82pPyeadre8mSqD4UDO1ojWoNferNazs3LSJHdGHStaMOlXk9sH19NM9nlRBVa7f29784oT/zhAgWgvJsX2nrFECKuPTsPv1KyzJukXCRrhfQjmrwC1+eSMWM1kqwx4MpwMloGMCR4J0dmq1EL8JKiA4X6hj1jhdTqngmkmA3MkUgYBeXi5djK9uUE9Yqf4E6X1qBw6UhGf3Nc3buWqrN7fuJJTY+UGbVgn1FyxeaFtmuhUixO2S77X+rG9B4DKQP5Bn4CRx6mMUqmg38p+H2EIPwFllLKE/ZDs7BweP5BCn40aK0Zub7+Uw350KsqX1siad1fxAiarp6Ctu82ChobhcUrmAyKZxeJxF2Sp021ZVYCCNAH82sFbHaqB1mL414QFFXgTgzlMVOX+g6O2tTtO8pJ92mP9st/F9bwoLcWDZxmNZOkwKkjKkV08Ao2kvFq9sQcSg/bRz4D2Hntrwum9nktRGj8SFvOEwUbY7ChW+XKZkbKIRqWqCYupLCZNC3URjmM8iqu96GbLvva9nHbKceGyFVAqiNG82qRka8cPdWGNjbMqudZd/5G6CwUR9VkrCJiIxiJIIhtVcrweW34vBmz9D1nx85EvWWZLf8z8/xPj01brRUY2ClQCfAI/fjYmdAiFfAxwU72x2A0Av+bTGsPhZLHZdxeOECfr9RxKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(26005)(86362001)(4326008)(82310400005)(186003)(336012)(83380400001)(47076005)(426003)(70586007)(70206006)(1076003)(5660300002)(8676002)(2616005)(36860700001)(36756003)(356005)(54906003)(6916009)(81166007)(40460700003)(2906002)(7696005)(6666004)(508600001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:34.2656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2d0250-7f39-444b-d76b-08da32c62bb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3037
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Currently the psr configuration parameters are hardcoded before
feeding into the DC helper before passing to DMUB FW. We'd rework
to call a shared helper to calculate/update generic psr config
fields which are relying on the stream timing and eDP sink PSR
caps to avoid hard-coding.

[how]
- drop part of hard-coded psr config fields by replacing w/ the
  call of helper from DM before feeding into DC link setup psr
  helper
- For those DM specific psr config fields, e.g. allow smu opt, is
  not to be set/updated from the shared helper but to rely on the
  DC feature mask
- for the psr version field in psr_config structure, since only
  the field psr_version of DC link psr_settings matters for that
  fed to DMUB FW, thus no need to set/update the psr_version field
  of psr_config structure.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 141fd2721501..52508bdda8e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -97,19 +97,24 @@ bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
 	struct dc_link *link = NULL;
 	struct psr_config psr_config = {0};
 	struct psr_context psr_context = {0};
+	struct dc *dc = NULL;
 	bool ret = false;
 
 	if (stream == NULL)
 		return false;
 
 	link = stream->link;
+	dc = link->ctx->dc;
 
 	if (link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED) {
-		psr_config.psr_version = link->psr_settings.psr_version;
-		psr_config.psr_frame_capture_indication_req = 0;
-		psr_config.psr_rfb_setup_time = 0x37;
-		psr_config.psr_sdp_transmit_line_num_deadline = 0x20;
-		psr_config.allow_smu_optimizations = 0x0;
+		mod_power_calc_psr_configs(&psr_config, link, stream);
+
+		/* linux DM specific updating for psr config fields */
+		psr_config.allow_smu_optimizations =
+			(amdgpu_dc_feature_mask & DC_PSR_ALLOW_SMU_OPT) &&
+			mod_power_only_edp(dc->current_state, stream);
+		psr_config.allow_multi_disp_optimizations =
+			(amdgpu_dc_feature_mask & DC_PSR_ALLOW_MULTI_DISP_OPT);
 
 		ret = dc_link_setup_psr(link, stream, &psr_config, &psr_context);
 
-- 
2.25.1

