Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A510ECF9C7C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B67A10E7AE;
	Thu, 20 Nov 2025 18:18:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PcBWKgaV";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010043.outbound.protection.outlook.com
 [40.93.198.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224CC10E7AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMV5GiaxCP8gbYA6MoyczfpFcFt45ZoYxuURL9PiYk/eh7cIc2y7bJMTl3esLFlNDicNV8Sf4Ak28Y038p9qnHa8qnMpjS++p2bWcJWqmSAAjnlILzfjq3eG/CyM9Koigzfr0HQabLO34zxouWltY3sMmENjHHPriOveL4z5mMlDLviMEJCKlWX67ooElJFnufG4ZR0CiaI2h6bAsfHKcL1U2ftTR1xFfbc7631B5PfO8PwSUERmYNLyEMeQ0ZH777OANJ9vZ6KRODHqpf05TyrhoBEX7Xf3ZRSBX9MmyaXsdDxZMvWX95jlgmgQkSYdu/nnlslVY8MYI/UITsM0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tr631eYdARqAQKIQsCPPXRPFEI+XkY19ve95Je/0Q4=;
 b=T+QSzT7DhzVpDA7WO05cGYZkBrfwa/AKEAq8cwwzS18CNxS9Bebj/GgQnGI02ejHwwxvuVMWhuh9+B1FD1e9jfl5EU4JOBTtv3rqm6efJUQ05TynZF56s5XMp9/rbzftOobHu6KgG8R4+21COqXXR3g7SiJdWcXijCsoEZWDHnNhWDBjSOYwNsQY+qXcK3sn1As4ZYcEB3UnVPg2ZkqRt+E/dXQ1WPRTgcx7T3OBe/ijXeEjTE/mxcMTZ5s6odZKfNAP6BW//PKklhAleMTJLN4/JYMC9URDV5nwyFOltrgpah5HE1KjtrgtgrUCL6X8pTHjcn1CKLggJMYB+Cp9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tr631eYdARqAQKIQsCPPXRPFEI+XkY19ve95Je/0Q4=;
 b=PcBWKgaVeo82uldoc2SKDTrAQ+XUkGdoF7xgETUbWLE9os6xLD5VC0PhEqAx7xa/DhXS/srTffnToCQRSaaiDZ3U9g6hsDgMcMglimIWWO4ZF/shwOTeVugm2xBh0L7VvJlo8rVkzD55Snaqxrb1VLP414v99tnQ8pNlTrPY+us=
Received: from CH5P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::11)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:18:06 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::38) by CH5P222CA0023.outlook.office365.com
 (2603:10b6:610:1ee::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:18:02 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:18:00 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 05/26] drm/amd/display: Parse debug flag to PR FW
Date: Thu, 20 Nov 2025 11:03:01 -0700
Message-ID: <20251120181527.317107-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: d91c8f82-1c4e-425d-5dfd-08de286124d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WNkuBCwoTMeUz4lqdR32/wWnFSI667ZVX82k90tiT5wsvjmIx2N5Ivf2cGAd?=
 =?us-ascii?Q?jL/5psRoh830XnyFK5MlzcHhtFTUr+CVLBNUcY3DkfADHV1F2gOwsFZfGnri?=
 =?us-ascii?Q?F7PTbeHSVtcoyQhhuJPmuWLUODJYuyx9Tf9EGWq8IXcbaKqkCwqpytApblT4?=
 =?us-ascii?Q?VkJj/1E17JFFQpceAXSrLApbYX/nzf7otEEgzpdth4VVQL1sN9MPtRDN4MIq?=
 =?us-ascii?Q?wiE28pWvxozrxgDEqU9zULWDx96WeMvOhpwYbuFKYMAUMuwEX4/jCfmVcpxx?=
 =?us-ascii?Q?sbobsmR0yKkZ5NhWpH7YCLkyn/mo7Eld9papsoB/v8HpMg0zMgRP9elW+CBs?=
 =?us-ascii?Q?QRSkzHzq3zU/v4R5CDfM4xzmMPvfFds92ZGOKBCUjL16CVWLCAXzUoabf59z?=
 =?us-ascii?Q?k0HIgTBkN8uqn1arebNLER5ixcR9TtN6aMLo0djDoF/YyPdf6eh6Xtt1id94?=
 =?us-ascii?Q?ophm5/exZvcnA7MgkQov4CQeagQR92hHdRqSa4fHSles0UiJE+8TrBCYbq8e?=
 =?us-ascii?Q?nw57+cJGqKLEyecEW51Fe9SFdCuwKs5/HoFLePtBDHh9RRrMilwvbHOEBccn?=
 =?us-ascii?Q?bPP0+O3xWF5Zbyc2UEHX3HerFKRzQ/1+mlx44RvoS4M2AyGK0AVejYvTvuw0?=
 =?us-ascii?Q?5B9BldXeVfE8rVLv52AwPR+nMUnKVcy0f+LbfrqFc0bQcOxbo3f9agvGn8B4?=
 =?us-ascii?Q?/Nv3SR7XjcLPT1T6aFztjwQPiH0+sdgVBVE3wP1oRCBHviGYn5LutymLFffk?=
 =?us-ascii?Q?pvsSf5aMzVAEgs0y5Ig8aJTEzBr/ZWl5sqhByff3vG5imkw+Y6pPxDzixT87?=
 =?us-ascii?Q?uSJZhW975l/GI8Ln4OW2O2TrvEOaGKtwQxD0j0X5Wy0Q9W7CSA7gHfWJZeug?=
 =?us-ascii?Q?Zi3GCudHXDdxH3fNQBhKWl6Jmt2v9CpeplZ7Vtar2bScszHAoKgr5gCDwZSB?=
 =?us-ascii?Q?cIBOEjohHPhK4JslDFxEpo4FN2SA9Z0N7dIfi2N2fxNABO7PU3vvyzMFcxBb?=
 =?us-ascii?Q?kC8SoEK+AGNrHmcX6x52rWJeK8uQ0milmmDyM/Bo3aZtebX50JIfP6+mCY/C?=
 =?us-ascii?Q?3ia/c66GyGUXDAmiGadbyxe6CKcm11rQgSMgdX2adBDO7U7YZ+yqdq+WwsaQ?=
 =?us-ascii?Q?2o/0BbixA8OlGe6gzxDXnMF7z+2EN2j8afGS0dP0ezsSfolRN36IvO4SPgdg?=
 =?us-ascii?Q?em7EDjpbXk9IkkCyw/rtuobpdw8H76oPTYGdorYQ1CfwS2ENCvQ1o9QOHcPg?=
 =?us-ascii?Q?VYtl8CD4+/AayvAk/tChP1G/SvIPUAc0xjbGFhNNN8BWBhODTt4Q8EeoINqt?=
 =?us-ascii?Q?qet6jX9/9ZnmuKS2Z4SyylY/7jZt7y27wf/bK42QRtuJpt/9KYEt+hKge7iD?=
 =?us-ascii?Q?4hWxoz7h74pq3mm7+4dU0YRS7HZ2xh3Pbg9M9r2JwgspL6xIRWvZhsOAvFn7?=
 =?us-ascii?Q?b/hpWUnhL9coYCi+jiHxkr5k5zA7O2v3RLWgC7oeprqYSFkWAPCZbo9V0uNU?=
 =?us-ascii?Q?bWUUq6vHIjzKT4kL2+SWt7eEw49XSBuxcQcYHeJQCZmFKzUBvry8jrhDvhqL?=
 =?us-ascii?Q?GF80iColcPmGSk8X02w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:18:02.7361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d91c8f82-1c4e-425d-5dfd-08de286124d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
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

From: Jack Chang <jack.chang@amd.com>

[HOW & WHY]
Parse debug flag to PR FW.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 80ee6efe91e2..07f4f15851fc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1373,6 +1373,7 @@ bool edp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_co
 	cmd.pr_copy_settings.data.line_time_in_ns = replay_context->line_time_in_ns;
 	cmd.pr_copy_settings.data.flags.bitfields.fec_enable_status = (link->fec_state == dc_link_fec_enabled);
 	cmd.pr_copy_settings.data.flags.bitfields.dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
+	cmd.pr_copy_settings.data.debug.u32All = link->replay_settings.config.debug_flags;
 
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	return true;
-- 
2.43.0

