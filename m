Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53560C47DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 06:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DE710E92A;
	Fri, 22 Mar 2024 06:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5HB5Tio8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57AA310E92A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 06:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZqZfUpuQY/5X8r+GiKWM7tja3wwJpCbeBkZ8PAR0PClHXor33JAgoPwhQ4lHUURpKG8w9bpvqtEgj9alep9gDh6epiV+GxcxwbYzYy/PjWy8+L4bqY6yAYRGdJwrKm2XSYD1DfRMfm5U8UK+JZPTdzDOaz9cDWWqo0DnuDNwUuoXVmiWjCSRR1hpzD5SdU4VYD8u/Y/CPuK4Q+QVrDfqH2tRWY14rEbTbc6e1FHMiJTAcgNt2sDYT9xwRb+z0TAbpeEwdaVuAYhVOrLUIFiDeigQ/U4pHjAa+y16GEZFOVLnKYEKY95IS6jML4j4ciyiwEhaHFD8ZixJghAgljOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJqNCaObuM5D+VqU90IZ3tJWEAzLMtk5MGV1YLCQRJ0=;
 b=bOggpIcr51olc1malqeTYU9b4sEbEOu/gWA8Qy3A703LV/Er8NUDaSlaRx0ZwpLFBo14hC6FefO9JRRivbPpmzk9lO22Y0a0I1hXwRX1jdfaI/pK54qr/nsU6Fh+iU8XFN8KXklGgX/8J3yKfGI+GnL2Uug/ZMmFk8y0VyxqpE3kbuE3HmsGkrkF3mKXXlsUZOAkawUs16c/sBjr0I9sFUMx6xwaPbrzUy+kgQa/zXRJvki/PMkNWYOrhSxFMORxdWAkhO0FYdudshpbYLl3ARoQJRRbQVoKE9FZ/Hd9DAM0S06C4M663FqEjabhD2T0fcSJZlIQ924DJAqL4CA7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJqNCaObuM5D+VqU90IZ3tJWEAzLMtk5MGV1YLCQRJ0=;
 b=5HB5Tio8KgiDSEZan8JacIiZTlcqiiE8AnXwGAIIprWIdpL5dLkxTyCTFXgy+Dz9XlZ2AfECR1gFmx13wZLOZIpd6GVRP9YOm0GASbiP/W7EkqeIlGvUaQRcvxj+uvc8ddZD/fotqfICrE2/FcMf6lrzUidBJrX9MK3tbkTvC3M=
Received: from DM5PR07CA0055.namprd07.prod.outlook.com (2603:10b6:4:ad::20) by
 IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Fri, 22 Mar
 2024 06:54:59 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::6c) by DM5PR07CA0055.outlook.office365.com
 (2603:10b6:4:ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 22 Mar 2024 06:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 06:54:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 01:54:51 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix truncation in gfx_v10_0_init_microcode
Date: Fri, 22 Mar 2024 12:24:39 +0530
Message-ID: <20240322065439.4154847-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 315f242d-ef20-4d76-3b4b-08dc4a3cfa5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQ0RiYIV/0b+TqqVnA36qWi2sdUUX5VxAYEOJb/8sTSO8weiGJo3OctkwBKD2i7kM6OKAaJ2i+L3C3U0EM8lwSwiFKKE7p9Fwy0MpNk7xd/vAg0aJ7StTVR2yMRt9jUqQeCmclY7u3viXvSyV54p9X/YVu8A65CeuxD709utaS89eWTDq0L+WTwJzuD6hMx5Chf5crJC2LeHmD2Lr0Q/hxWRXhLojI74nTv1RSLlsCHlrbQgMvcqszYrgZ9hRp/hlfYSzh8l/T+xlGHw+u19vVdbsRmOqUTfzHZMcBxixc+PDbswIDG8T3cQP9JLLkf/LREz7mlWdG2nst+JHHGpUZ9VeaFsK4hWPFaiilrv0x1Ea5bxyzHzoUCpQpSZZlkKNR3V7B8FWugGSZuiTauH/MqisSgkZxAs8vP8PnxaSutWLGGJuZXBzGxhjLd8HBsfjLZ82tgeLX3mZqqbPC95vP9Dt6bTQ2DIkazRjoR5ZBW+N/KSqdb6ZHUARzqOjQFR/IY81hLevyBWlGgNE6osE1YnmN2mH5s0KtE3O2QKke8bxEtd6XR0vILalueMnCihghbriDiETVllKWaIY7QqG8bXsjbibk95SwF5cTni7o+C5/7+mr9BWdlZXAWo0LgLBJMU8vaw25Sne2fmY4pSjjIShWbqSqjlnquHTTQ83woEVh7a0i9lwLVouIH1Z9qR9Z0lMXrGRs3++PDeN+zx+t7X2whyeSRJwygu6/yWosO0FzSsYj23Pznc96wkeBwr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:54:53.7540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 315f242d-ef20-4d76-3b4b-08dc4a3cfa5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
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

The total size of the fw_name buffer is 8 (for "amdgpu/") + 30 (for
ucode_prefix) + 5 (for "_pfp") + 5 (for "_wks") + 5 (for ".bin") = 53
characters.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c: In function ‘gfx_v10_0_early_init’:
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3982:58: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
 3982 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
      |                                                          ^~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3982:9: note: ‘snprintf’ output between 16 and 49 bytes into a destination of size 40
 3982 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3988:57: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 1 and 30 [-Wformat-truncation=]
 3988 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me%s.bin", ucode_prefix, wks);
      |                                                         ^~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3988:9: note: ‘snprintf’ output between 15 and 48 bytes into a destination of size 40
 3988 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me%s.bin", ucode_prefix, wks);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3994:57: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 1 and 30 [-Wformat-truncation=]
 3994 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
      |                                                         ^~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3994:9: note: ‘snprintf’ output between 15 and 48 bytes into a destination of size 40
 3994 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4001:62: warning: ‘_rlc.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
 4001 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
      |                                                              ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4001:17: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
 4001 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4017:58: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
 4017 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
      |                                                          ^~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4017:9: note: ‘snprintf’ output between 16 and 49 bytes into a destination of size 40
 4017 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4024:54: warning: ‘_mec2’ directive output may be truncated writing 5 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
 4024 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
      |                                                      ^~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4024:9: note: ‘snprintf’ output between 17 and 50 bytes into a destination of size 40
 4024 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f90905ef32c7..d524f1a353ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3964,7 +3964,7 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 
 static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[40];
+	char fw_name[53];
 	char ucode_prefix[30];
 	const char *wks = "";
 	int err;
-- 
2.34.1

