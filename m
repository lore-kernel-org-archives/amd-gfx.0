Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F062CD1291
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F021112545;
	Thu, 28 Mar 2024 19:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WNT4MCJn";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB70112536
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJ+16k9Zmx5pZ45NWZ//R3DxjTf9V/lg2guaFeV6DncEgNYQtLZq8g5zTG4K0G1sj5nCmcJ72lAg56rETQxoBFBIUcm/XblQth27d9o07RnhPo7l4pSebeSW9gRxa5AAeK+GKH78TTDHtha0PFfIuwVzJ7XtYEKckL/bFOVnKEylZO6RvpZxd6R4ECNfr453FpDr+75rRf2doLZAwI8qBUyEN0utqQSVcQCExLNTRg7H5M8tnzqVF63N+RDzbiwDq01XaFiHCTAagXjY/kEzWCByWjD6kCdMo9WR1+xZNhElGz3DBc7D383W87hRYk++sCcZpbOtfMAsAJhix3oRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9qsWNIui9OjfYFJCYHYRPsq3z2cWQSyDPwQo2Peaf8=;
 b=O5Yfi2aia517lgNVKeAs42eb0sjAcs12RbPZVRRgcePqz0n/QLh1bD15yfkZV0hU1DmAtK7pR5QHLpzSTwf5enlx9SZlW8iGJ7sx+VR0Oax7KwTO87/qiIpJujT934dbfxQ3PCt36i8hdcSmwa6FicSYKGcX+JZafkKtd60Frnfcg8QbdgSsOXdxYEcfrf2KUo5cigClLu2ltZ3xLVvt725V6QrSxacGyXCPzwcAG2cIRiXsLOoIw6VMckXpXrz7wZ7RFl5CI/42Z5Ianvx9sjQlt29/vqYxkboJ7YJhHFRJxvADdXGLOml6JOQmNEl5c9xhVdbXD3XqzBMXe1H1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9qsWNIui9OjfYFJCYHYRPsq3z2cWQSyDPwQo2Peaf8=;
 b=WNT4MCJnhU+rx+J63eKgDIKLREum5gjWEH2+CLI77xJuvnnOJwKQ5B5Izr4AkJaC+fzx45CMZ6CNpIGKxX6zb/JUj6gzSeCAoT2kkV+JwXtrzOqGraL5qhQMPxLNTzaYP3GOhl9jeAWPSdY7X93MQ8ykah4fMd0YYEbeO02yyRI=
Received: from DM6PR21CA0027.namprd21.prod.outlook.com (2603:10b6:5:174::37)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:52:12 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::f0) by DM6PR21CA0027.outlook.office365.com
 (2603:10b6:5:174::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:11 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:11 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 42/43] drm/amd/display: Add color logs for dcn20
Date: Thu, 28 Mar 2024 15:50:46 -0400
Message-ID: <20240328195047.2843715-43-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|MW4PR12MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: faa03637-c89a-4d59-a657-08dc4f608fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qW9QVxMrlcihnB0gWs8Wgj3WI+vgKBlDwkPDK7EiA84MPXn/6JfwmDoyCHiMOs+Lk7ZjoJwUJrUpit7O68Jj8QIyhuGEaZicK8d8iU/Tuit7B2G11C594f7EumuWnvFSmbXLkmS8vnt0oZTEJWlpk8YvsagZC2Ql2KM8+St2ikhK0HXLW4X8OxUAA2KLyXykTnwXRme7FRp6/A0qL9fk+KYv9jVLrx/xGJ33rwQ7Ul1x2RY9Pb3+bQanjKwO72AVeymovYsN9UAWjtQm5d37isboTDED48BaMA2UYprQ477utQbvXtzT6F8OkmG7bVwj5/WTSnYmb3lMKmuN2FZLGCio4FoQG9jc8WXVrzLBdGVZyAPz+Uqaemk4rDliOq3PVNqtWcOi4cgtEcftIPcvvyCV9hWPGoign7Wih2dqtB9wSOcblV+uA7xNKRAyC5Xmwwa1o7/qGNEtIxeRnFHTsOVn2Y6aY5ow4BSu2bVxxuCFhdAyrn1Xty19LfPEiozOeq/Avfhz4TaqjYiGcOkb63cN8H6e51RDV4UlEsCLrMd21NSC2heOsWa0xHLNK9EC/XPKm7B0fSjudgOskrY1FlPMGY9A2XK/cM0AVlRNNolJ/Nxqa1+6N+0dmS7/t8Dyl5J4DpOAaCXqGkbJZRdYM+wghrKpl8A0gf1KgtuG8dY+ruYTLCfPtMYW76t8WwOMzn42HYVIzrAl/BdiFyt6x4cPYyl3Lq4grC8elUYCDzZ/zm2kHRoDflxhrzp37PM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:12.3083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa03637-c89a-4d59-a657-08dc4f608fa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708
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

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
index 884e3e323338..ef6488165b8f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
@@ -67,6 +67,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dce110_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
+	.log_color_state = dcn20_log_color_state,
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-- 
2.34.1

