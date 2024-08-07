Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BABC52D7B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3271D10E439;
	Wed,  7 Aug 2024 07:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="awtUPaeB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C4710E439
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYFZbctiWYWvP7Rm4ChSdGGTEkz1fQ11yob9gf687W/6lR12GhwXeFLKFhK91LkW7QUv2oyJA7/S9hrGeVbHAMu2lOyH1RFE/GW/POxr0XCrXoqYWl1p7eAcsRg84POtekSm03n39OGLDDT2n4IDYWoiXAi7/37+g+4wvdEYvKPw1xav593Wl7gJiuCucetFylGxHqLaRiGw+zgjzgkKQM2dJ+NOk+ZLkVtK3gvwuvRTJlnQAqB8eKAWsiyK25hhWDKuIbCv9SZWylRpwmGdmkXvr7lX3Tln0CPV8eh+fpWCz+VazkmTkFQtFuJn6Eu8ZnMSvGkTmGvxi2kcVYzh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42CFAapV3Anbyfz3+XNNN4u0H1aGMJAhZKNngOVL3GA=;
 b=L8wXY9ZLlvj3MTUV6JJMFhMFMTo4hry1zQhyQVygqZTsTtiLNDG5Qb2NYhnjnfIas0CXJC4BNCU6NQCtR10fnPACiC9BFIDDHShWweAOEgYziFFlgCnBBkfadWFlrs3zl2OpRrJCuQnjA8Vqe6MgqgqqirSOPGsLxqBxeLmMuIGUL3dd6Np59EMC2jwhmVend7dspuTZAK+MnQ8EqRkFMCIDbMV2+pHtqhuuzCpfwb+CSkOp3Ly0vw+DnoZ/6+w5RJAFu5zc+9X0Ef/kjWYNXk2A+PAAKva80qs+VU5mMH4v8o7Vs7twdERyU8tV4TXkSl7xMrZZRs19r9sG4Mk+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42CFAapV3Anbyfz3+XNNN4u0H1aGMJAhZKNngOVL3GA=;
 b=awtUPaeBJ+1EdcRV3Awtr60bW2LPW1iboHdP194gtnm8I9QpUTMDVPuOk6zteCWAzrIF6aXJE6XXmHlRWfk9jMRGi2bUSg0P2mxZKXfSJPH02EJfcZu0x/N+lcd096KlhVlfAHH8mOa23ruweZl66fUsP6CHlDgVDen3RfEMRoo=
Received: from BL1PR13CA0190.namprd13.prod.outlook.com (2603:10b6:208:2be::15)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 07:56:38 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::cf) by BL1PR13CA0190.outlook.office365.com
 (2603:10b6:208:2be::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.10 via Frontend
 Transport; Wed, 7 Aug 2024 07:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:56:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:36 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:56:34 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 09/24] drm/amd/display: Check null pointer before try to
 access it
Date: Wed, 7 Aug 2024 15:55:31 +0800
Message-ID: <20240807075546.831208-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 6113de1e-1eac-4a8b-02aa-08dcb6b6772a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EuVyNfEyxY7CY/XTwSOF50A8oKIrEWcgdp65KkHRBJgUSd4qYKvqEdxBBy63?=
 =?us-ascii?Q?X26BQ70AuvBrp3BqZf+iEjpfY+PefDOZaXwX5tRYY+k245Xz7istxGgc34uf?=
 =?us-ascii?Q?pzZs3P5VwUIzdOZVQrvylnCmVqisxhKOaSSqiHxE7MqG2MmChX3hplWi7hMh?=
 =?us-ascii?Q?wSlD9sq1ifra8wrzIerl9sAROFwdqboBIoCdOE0i5jjtYpkHJej8Y/DQ4+Yz?=
 =?us-ascii?Q?QKOsvn0irj+ofG4lf4ceMn4rsopryCYff4Fiq8h3b63+J6wr7cD5pwqmGkpI?=
 =?us-ascii?Q?MG2VijWf8BmldXLhbbtKhZi7zKzzWsXQVqNZ+J7NTlZqXVYdS1hhQD3RTU4a?=
 =?us-ascii?Q?1XlZLCcSfqE5qIXczX3GuQxIOzOnGzPIhUNo/viYyL8SF903VdBLFJNGpKxh?=
 =?us-ascii?Q?QmQVK8lQKH4zCctimTRn5qld4wxMgB3l+0imv61eJtjKMi7i5slzVPtXE88U?=
 =?us-ascii?Q?fCw6j5FU+v9ieo4rs8Y+1AA0U1qCImQorDsKYNWxIYFc+RX5na7iPAKSiL6E?=
 =?us-ascii?Q?EJAJoO/crF4KDU07zywmS+mZi28vz5BTtzYLSUhRhGz+h4zM7rSg7h13g3QE?=
 =?us-ascii?Q?dQDdJZoCMGfTpVnTnJaWT1b122vLUjFEW2saN4Z/xlpeM5iMbNaKbN4la4Y+?=
 =?us-ascii?Q?40sarxQpT+k/ZbV+IM/VFqnqsHSEstJRxwqEKeNytG2ReyV9f87pu+n2G93d?=
 =?us-ascii?Q?hMUVw8yGfbLtimzpR9kkHpuxxSU/G211JcqVToQXt7t9KjwDexvsZcC8qGwK?=
 =?us-ascii?Q?c+Kwf5JlA36XECdUAHfpEl0TCfXIVvi33DmiSI4XqODxBBA6Y+mRqVtfRJ71?=
 =?us-ascii?Q?10OGWt6MJrcc9ecYOFOQDirokiucyFa30hJnU+MJCHEkgAd26xGPHiLuofPp?=
 =?us-ascii?Q?ERbPP5d7ko2C1CZoUfn+rzpWyK8KFZhQ4RZFgiSSrsIZH1ZIE9RTmcPc8jO6?=
 =?us-ascii?Q?JqKIqMNTocJU/aKRdhIeltI61Ow/pwx40sESAr3FeiSULITVH7Vd7AvpsI4o?=
 =?us-ascii?Q?oHr+5NzvNUTvqs1gQvDnr7vgIjm5p0fWKu8C0HQ+2zucJ6rA1UDiJqOmlHDy?=
 =?us-ascii?Q?TutGNZNkD+082t6L8Tr0RJaQUGdhFSPmDB2CFSLu+h3z8LKEBGqEIRMZJCoe?=
 =?us-ascii?Q?XPQyu5lHGnQ6oWhH9kNee3KEQfYUAn82G7iHCcCVC3FKvfw96K5QkgXicrSo?=
 =?us-ascii?Q?378YvYq6+dFBFXYhgXiVy0HwRxaH79WOTD6alC8cjnWiB44B2EUOlKh/bCcj?=
 =?us-ascii?Q?gD6Eni6G8O7/ZXab8Bc/1ViLvViuOqB2QrhFDNRjShZDz2IM9HC4A0hufro2?=
 =?us-ascii?Q?PjUINDfvNuqUxEDfCnppMs48f8wpFApbVf3mqZQAM0W9Ewg+sJ9xkOysYZsQ?=
 =?us-ascii?Q?WHfW3AUmDSJREL57o+H63OpQjpUsGsTHNqWLpQJh1RwoBf0Dw9ArHW99YKq/?=
 =?us-ascii?Q?KjLuNY4YnVS9LvFA9wjr1MSfnyFBN36e?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:56:37.8687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6113de1e-1eac-4a8b-02aa-08dcb6b6772a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[why & how]
Change the order of the pipe_ctx->plane_state check to ensure that
plane_state is not null before accessing it.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 425432ca497f..a68da1a7092d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1932,6 +1932,11 @@ static void dcn20_program_pipe(
 	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult))
 		hws->funcs.set_hdr_multiplier(pipe_ctx);
 
+	if ((pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult) ||
+	    pipe_ctx->update_flags.bits.enable)
+		hws->funcs.set_hdr_multiplier(pipe_ctx);
+
+
 	if (hws->funcs.populate_mcm_luts) {
 		if (pipe_ctx->plane_state) {
 			hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
@@ -1939,13 +1944,13 @@ static void dcn20_program_pipe(
 			pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
 		}
 	}
-	if (pipe_ctx->update_flags.bits.enable ||
-	    (pipe_ctx->plane_state &&
+	if ((pipe_ctx->plane_state &&
 	     pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change) ||
 	    (pipe_ctx->plane_state &&
 	     pipe_ctx->plane_state->update_flags.bits.gamma_change) ||
 	    (pipe_ctx->plane_state &&
-	     pipe_ctx->plane_state->update_flags.bits.lut_3d))
+	     pipe_ctx->plane_state->update_flags.bits.lut_3d) ||
+	     pipe_ctx->update_flags.bits.enable)
 		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
-- 
2.34.1

