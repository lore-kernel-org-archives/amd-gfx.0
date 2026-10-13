Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53ACECA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E766E10F77A;
	Tue, 13 Oct 2026 11:19:11 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C96E10F77B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9aC9pj4tl/uVswKq6EY0K7mi5HG019wslqd1E3x1xX6tWRgIH5NctIzaCK1q4QvtjA0gpcKqxuttlLhp1EdbQaCocJ3ZXwFDYrbUrMvHVv8IaBtZ/PqWxfDmJg8FGu6gT64/qn7JM3sQoJwDrjkVr+gR1cfvGPzGdfpgei7ferZncdOzbf1kQp4abqSb5OUbHG7q1FQkIAH2bNs9ySLj26CK/MEIzXFAIubwfvhwCOIu6WrYNjNY32o15D8QobyfDAoMVDIdruil7RlXaEtFfKWYA379+pJotm8ypOwbWLtc0ZA5t5sJ+mZhKccglfpvEPGPD6+WK/ozQymcwwH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U1KK+OOaHlJPSr1JTS0nxuVHbuwtqKEJlbbqz06BlI=;
 b=dPBgktrDO/nWyYENzaHVFSClw+wkF8a66TOPMCqXyQtRg+tqSRFBYFPOpr+rWj5LI6aospkL/fHRnWHpmRfwFI/AA5/KKxhdMy83nxEBicRE/tseWuhkf/mVDaRKeg9oYYxmNGhsTA68+kw1H63Zd4GWJ0dSvrUtJ0PAI+uDYF1G8zKMkxG/b3GoU2AxpEjxODh8OhBPMcxXPB8TJsKZAqypVcREkIMPx89rEpGs/EnxePlUFWmflzUWrsLUvYp9ahGpPcFVZeW4InaDlBVEtW15S0EV/y6WkLu/vzc6GrG1lI17NGcxwKhzits06a69/61hn8E0hqrxZwS2jN35UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U1KK+OOaHlJPSr1JTS0nxuVHbuwtqKEJlbbqz06BlI=;
 b=RF/+W2dFaYdfofrhhciXSIPa3mqSlQj/2VOdoKKWmJ+8pzKt+jHyOH+5LxX1J4p5zZpszWXBN0mFzUhdlSq4Q71cKEQzG0bFkfNaj2DO3XhZGqMnTOY3iZjaiCgq10ASyivSmdjiF4vrddG8wXsG69HKv3XG2pPru6PDN1NqoxU=
Received: from DS1PR04CA0023.namprd04.prod.outlook.com (2603:10b6:8:243::17)
 by SAVPR12MB999169.namprd12.prod.outlook.com (2603:10b6:806:4e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:19:02 +0000
Received: from DM3PEPF000265C5.namprd03.prod.outlook.com
 (2603:10b6:8:243:cafe::98) by DS1PR04CA0023.outlook.office365.com
 (2603:10b6:8:243::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 11:19:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C5.mail.protection.outlook.com (10.167.23.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:19:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:18:55 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:18:41 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Sridevi Arvindekar <Sridevi.Arvindekar@amd.com>,
 "Ilya Bakoulin" <ilya.bakoulin@amd.com>, Sridevi Arvindekar
 <sridevi.arvindekar@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 20/30] drm/amd/display: Reset UPSP and pre-CSC registers on
 DCN6 DPP reset
Date: Tue, 13 Oct 2026 19:08:07 +0800
Message-ID: <20261013111616.2267344-21-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C5:EE_|SAVPR12MB999169:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcdf7bc-75e9-48b8-512a-08df291bc8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|261009223027099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2av5r5pumxfghf7XmLWCYYgOiJDICxBwbKPneBbcum7L6a4blpEwgbp4siXxSxtLXB6boaFX8N/mR0+FGDYqVmNCq35z1uUGpUeZZlNDS9BjiA9wiS/GKDY6psDIbMnmlMVqse5MCYgP9ZScydrNhAmzqPr3XRDhgghKC3ixnO5S3iwTBaMVigDFgCDUpVQyU70Ll9VEWB6PIZNAQ1S1KJlYe4cXqRnjxOm86XFFI9hWV9i3niLNPichW/9koMJL7QTwe8IGLkNFxAT9h/Ebo0MRu3HtJWywoVJwM3rTq4K+iLxioPRSR4iEnlAsgH9mMMPkk5GQuF7wKZxLY1F5Moyd73YmqPgUeZDA20GkRgIFm2r+s490eswXZpAueqMmvmMWBT8LNF3qHcl+yVLhRkkTy86LFQ2mNPJBcfaKEPfG76d0Jd8HJ0tIrGSdzhrXNrw3H76j41rx4Qt8KliVrGAVUR5OwrsS8nnGqHtG5D8UDdgNOE2pPVAkAfkMC6NJ5calbnaErY4jRwjM3g5kUkH4tVhONv91OlvdygfOrAHqKdDJaCg6/MNzoNWajyCsW979AuvlRXP8e6mWtzIX1qbShvoGJApppdfD/wZFF/eaCeUPJS1i9zkT7WtxI1AmE5odqqk2R3pUNzCwT2U6acaGc4eUabC1DvNgdzP8b0/HGpgGAGxWcO+5xzFXomqXD9LjLD9bZTor5eXMqA8/GA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(261009223027099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Y73D7jh+48NBEba6o0ngImjjxARInIJtq/WrWu1h30pf7+1pBRlk/StUxpWRVMinijJciBrC3HU8cdY+6mfCJanKO+3+sJBOQg8+oNdfWc7adJS7Ha0Pp5ONGmKHaYEgFEZATzgoqSlNJ2Kp9OAUtrAV45Vf6LoUOEASOLyXk9IjyRzL0s3P55LW22pAxVSFiy0tVMbMgHbm8vQkFQYjVw0sYlqRyRO4Nt8I6H7uZgw39vUhGWYYoQdmoSJy6TdXwsK4GGUDnSDuELpwxoI6qUUB0AfsAom+ZWVqvCaTJ7jgThhY+hUXRstyR5NZD9SUgC9yOo0f+9XV81pDk+yyVdA1jRg9pZsxDHGsok9nZMrPjtd/KhcvmP8uuGq8dzeSUiywREZMMPF8Le6fTqDNQK1Nl+FF0TDews+kp8uqVt/8RUpmWC1454x4qMgQpTZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:19:02.1286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcdf7bc-75e9-48b8-512a-08df291bc8f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999169
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

From: Sridevi Arvindekar <Sridevi.Arvindekar@amd.com>

[Why]
dpp_reset() only clears software state, so CNVC_UPSP_MODE and
PRE_CSC_MODE stay programmed on DCN6 after UPSP was used.

[How]
Add a DCN6 dpp_reset, dcn6_dpp_reset(), which clears both registers
when UPSP was in use and then calls the common dpp_reset().

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c    | 17 ++++++++++++++++-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h    |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
index 4218863d2a04..2ba8218e2ac2 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
@@ -316,10 +316,25 @@ void dpp60_full_bypass(struct dpp *dpp_base)
 		REG_SET(CM_CONTROL, 0, CM_BYPASS, 1);
 }
 
+void dcn6_dpp_reset(struct dpp *dpp_base)
+{
+	struct dcn60_dpp *dpp = TO_DCN60_DPP(dpp_base);
+
+	if (dpp->scl_data.upsp) {
+		if (dpp->tf_mask->UPSP_MODE) {
+			// Reset dpp registers used for upsp, lls
+			REG_WRITE(CNVC_UPSP_MODE, 0);
+			REG_WRITE(PRE_CSC_MODE, 0);
+		}
+	}
+
+	dpp_reset(dpp_base);
+}
+
 static struct dpp_funcs dcn60_dpp_funcs = {
 	.dpp_program_gamcor_lut		= dpp6_program_gamcor_lut,
 	.dpp_read_state				= dpp401_read_state,
-	.dpp_reset					= dpp_reset,
+	.dpp_reset					= dcn6_dpp_reset,
 	.dpp_set_scaler				= dpp60_dscl_set_scaler_manual_scale,
 	.dpp_get_optimal_number_of_taps	= dpp3_get_optimal_number_of_taps,
 	.dpp_set_pre_degam			= NULL,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
index f12a6061e5fb..7086ff773de8 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
@@ -522,5 +522,6 @@ bool dpp60_construct(struct dcn60_dpp *dpp60,
 bool dpp6_program_gamcor_lut(
 	struct dpp *dpp_base, const struct pwl_params *params);
 
+void dcn6_dpp_reset(struct dpp *dpp_base);
 
 #endif /* __DCN60_DPP_H__ */
-- 
2.43.0

