Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A142606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=liqV0pKe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5A610F8CD;
	Wed, 11 Nov 2026 01:42:37 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58FCD10F8CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybQeGPkPX36jmF8e+adtbTnVUeWXrLw5or0Sna1Ydkvm3T0URcptI99hkFEJqBPwT7xTB3AQM8fPlPEzyOJBhgwJP9fM76Y5ZJybIM/3qGeuJTxc6Kj9rGZvSJnT/frjPsxOjJur33Uv0D/X109wGmqkjO8wismWDN0p2V9Bv/ab9uWP3Ox571pHTO8cFFRvQGWUdmAZoGBm+dRAzFc02GcS0JN/hrCZ3IT4Lp/9mWjhf5m4sF+MPMk3sAK3uuqB+TH4xaZmn+TILSRAqEjV0zXfciICeJVXCCnQcvodK47dOLe6NSEu1dDaNDuySnk2K5v980GYMyQtRvpOiaHJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obAQzUEHQmofD+xezjjsrcMHyUqlLPujJkuruVqNFcs=;
 b=MctgyvHsicEhPpOU/AHrm45v7Yl8xl66Jb4aBUqFqE4KgvqJ0yBeIPXHKPywT8O+RPHtqtbA+msYqrtUAc0KlbyJopc2MkoDQXnNPCDcoKky0q2fe/GM5xeZo8CoFeE+lQBc4GzCi1z8hTHi3A9KfJWy1RvNalKQhdIQ7a6IC3i5LzqekT39xsIEqKJeE6eDgjJn767By9MjX/MPSZXZ4LiiM830ov/L5K2eSyCwlFxC3+jHYNEO0EL7lTpdXPdKjzmIki3wT9PLLAt3W+Umojzwh+/RW+zxogp2wz1SpZ+JngA1ruK0m6C+oXm7cP+y+g/VnWaii3dHKSu/wDv+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obAQzUEHQmofD+xezjjsrcMHyUqlLPujJkuruVqNFcs=;
 b=liqV0pKeD8PD1ELmnHYyAEUfyxdrfPEP8dH+A0i9fU53w8gzPRfvqpOV+4uEYC4ipL47z/LpdVo/eUCR2jecy6BdNLa5mjPFXLdHYadic0W5OiRbsfy5ZZqDVkdSEcAidYnhMhN2nzMhoUvkvKbCwdneVFVquqCmQk2vEOh0TLM=
Received: from BN9PR03CA0863.namprd03.prod.outlook.com (2603:10b6:408:13d::28)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:42:24 +0000
Received: from BN2PEPF0000A804.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::25) by BN9PR03CA0863.outlook.office365.com
 (2603:10b6:408:13d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 01:42:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A804.mail.protection.outlook.com (10.167.245.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:21 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:17 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Nevenko Stupar
 <nevenko.stupar@amd.com>
Subject: [PATCH 31/74] drm/amd/display: Updating missing assignments for DCN6
Date: Wed, 11 Nov 2026 09:28:37 +0800
Message-ID: <20261111014100.3596072-32-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A804:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: f7802200-6e68-4f50-84e4-08df3f95077d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|10067099003|261009221727099003|56012099006|261009221227099003|11063799006|261026121527099003|261022075727099003|261021121427099003|261021123027099003|261022113327099003|261102123227099003|261009220027099003|261009223327099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Jb/s9klSHMiX/djUIcHT72ohA4dMYnz7rWPDMWOa8CV8Nk6+HAFJmjak700BkMycHgrRKgALWAInl7EuWPx4F8z+sY2W4vNt3RgNG66ZuXLJ5Su49kLMoOqhCgHbEVDCrjZKkB3y42aG1lqKlt9CY3HN7PEUng68T9zPPvlxL/P7r+tnSoqPqKD7yBF/Ne8LtbhNWCUDkU8B+LiZcR3vXlzICTjBCc16ODjO0l9bknfQway9Psakk7i8LHUqUVTtyKsSZl3605ZjI+xTahszRVwYl1cZxwCfg84QrrkhXY8wmW5Ws8tkIaCAQ87yT01kSk4oyfvhn1hRcMYfwcr9MhbeVuJiIlOoCFeggWdBrl2hxs6qz0gvXyVyA52PAyjGqFrwFg+ZHE79ExpJeEJfMAQRayZ8S7UAHXYRmqYSrR1nnFdMvQ748lcnoTx8fQgOFmj8OdVN/aKdGvC7dAXdY/k20GbYilWQspFZId9ot6bOfnph2DJKEhwCym1rS2ZlNix6FnHMPHlLKZQlJts5YsR+BOU0nrMI9r6EIXm89EgULsTLiNqgfEAdQnCWpkd4TQczc0SofXNbCi+slo1EVWEZmUeZG3u7QGmzgwoUgdvF7D7OF9Wz1wzyDY+DbOvKvfRrBXn5nOHYbJIxz3DoyCpORcLv1DkJSGW0By4/7/+VGTGgKTwmjtaoN5X7HcFKzlPSv9vtiy2WnH9t33B+TA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(261009221727099003)(56012099006)(261009221227099003)(11063799006)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009220027099003)(261009223327099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vYx9UQg0O3hFkOtf73OUIYxFViyjWMoCRWhbvFsfib5M77+4G8gmSgs6GJ4d+Z0/+v6VfrN6rk7DdkggD6VzTRJfgNZxg3R1z9OgXvivfQPTsitu9oiQME80x6B0w50pgP8dBM9U/VD82LMKRecD0TiKrpjmHQmBMFAxjzhpJthwJtPrFryx2T1+diDjIcg1U3BXq/eIu48vHK38XVWDEPF7hyctzXivGzwYXEtEp36ceOgGxof+XOnQOr3YB/DnNlWLoXsSPUD6HUGj8YP2CIS5mcEQ2IvXUsvkKo09GCKWpgzjbbsnFwvGXVVVvdpfPHGC5AkwZ8E2/QV+Kkgn9rtbuwMLdps7jbLKD6HKksxttjzAb9pizJpGnceITGOeMCbARYHeV+ejxy4oSBFVAHvsZOgMlzTWdurlxmS31WM39gJU7LDVdIwCjk30kLAX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:21.7836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7802200-6e68-4f50-84e4-08df3f95077d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A804.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
The cap for limiting vtotal by FP2 is missing on DCN6.
Add back the cap. Also assign the function pointer
for getting vstartup_start.

Cc: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index d068d5682619..1d7074451ac1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -1958,7 +1958,8 @@ static struct resource_funcs dcn60_res_pool_funcs = {
 	.build_pipe_pix_clk_params = dcn60_build_pipe_pix_clk_params,
 	.get_power_profile = dcn60_get_power_profile,
 	.program_mcache_pipe_config = dcn60_program_mcache_pipe_config,
-	.get_default_tiling_info = dcn401_get_default_tiling_info
+	.get_default_tiling_info = dcn401_get_default_tiling_info,
+	.get_vstartup_for_pipe = dcn401_get_vstartup_for_pipe
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
@@ -2057,6 +2058,7 @@ static bool dcn60_resource_construct(
 	dc->caps.dmcub_support = true;
 	dc->caps.utm_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
+	dc->caps.vtotal_limited_by_fp2 = true;
 
 	pool->base.ctx = ctx;
 
-- 
2.43.0

