Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D77C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C17FE10EAB3;
	Thu,  6 Jun 2024 21:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e4tKreuJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2902410EAB1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNBc+9LR+WbUicjhuHT0iyc5j3IJKta4tHBZGpqPRbHI4vwKlmamtwsBxgQUOYdUA0aN54qbrKUht3N9lEvDEcyAWpvCNQlARojHBHJXtWNgaYhBsGTSSYsAbnhuyK8BGWhMyDJjrE970ZDrOIMC6p613FX39hMY3aRHyd6b1jkwxIjVIoVNHFfpI7zBkiUHuvAtEm0oGr0yByNiVWgIZKhix2fwOwqs4LfIj13ELo+i45qTNe/491vMSS1k0gFGGrxA4Kl1qvOZSAPxvwfFeejIbzpE/hBhOU5KrjCD6NTh9KDodmSyONNE+fMD1KC1JOhz/jyJQCCKHjzuiGp4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zBzZqTZEcOk9wdgx7F3LAipJmJSWuxZu5ADwLxdglY=;
 b=N0UZHSYg2zEI3S4WzewMTWMtNxVV65P6CtffJs8ZEnQH2wl/s+tP2UqSpYWodwxUbVvr0tLDbO3L6pQTvgoaASxZ/YklXjva2OX4XXmZ0HrV0wL1rMqR/c11LYiTPq611oSkSkD+Y0WdpvHPvZsaxoSE3v9IgnxbJ8Eb2ax52C5KHQUzh4ZrKlS5ZmTNn3a+3Dc38sDTj9xzOeX2oC2KSsyP9pmR82hE8Sf1pRGtcMg9lxxKUr0C6uJ7uzgwSxAvU5mnvdcfEStdfnTy9GLlRbBzs9hLXOe6xuJnKaX1GgpshVVen3MZ1qBs03OKOejZdrr7Q42fgKrcF7TcqZVNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zBzZqTZEcOk9wdgx7F3LAipJmJSWuxZu5ADwLxdglY=;
 b=e4tKreuJokKB7cgVvAx2GeuYlF58TgN180lOJtS0v1byQwg5sLzeH3TbCauh+bQJRBsuK0YvSIC/N3NlwKcIS216UGuwOb/d0Jxh6lcescYp8qTv8/aTruyEPoTUQ4Tziw9sMejfkQGTAh6AtmsK6KQIE9ap+VeRSFBfv65Hfxw=
Received: from SN7PR04CA0058.namprd04.prod.outlook.com (2603:10b6:806:120::33)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:02:12 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::35) by SN7PR04CA0058.outlook.office365.com
 (2603:10b6:806:120::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:11 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:09 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Daniel Sa <daniel.sa@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 14/67] drm/amd/display: Return after Init
Date: Thu, 6 Jun 2024 16:58:35 -0400
Message-ID: <20240606205928.4050859-15-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 7481096c-cb55-4bb4-ae6c-08dc866bef99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pwIqZHJQbLFnfzg4WS99nnRSfQoI9s51TMgJ8UaHBuF67VaagEu2uq2EM7HQ?=
 =?us-ascii?Q?aNGP0mAuGx+MUjVQ++BFb5OwRU8qrTiE62+i7NgL/B8r5uQJVMfqPzKsUt+R?=
 =?us-ascii?Q?tWQACHcO23BoGWULZ5z6fOXNxpiPvYtIPXPecXpBF56oO9W+KuqV1Oeu9ckJ?=
 =?us-ascii?Q?J+CnEnIEBfSotLpw6zXHi06hMKUtfaWVLMhB78k4xrMNejlyhOLH6Mn8lg3E?=
 =?us-ascii?Q?CjrNCX7R6bKnDZqhth69sBaJaLyfCBQKn65oMGrzGThA4D4N9nreA3uH4GSV?=
 =?us-ascii?Q?7ZWSjWay3BQ6mPifVjdzp/m8/Jwzew/+ThYfjOOj+vr0xB0RxMdAQrDpnAwy?=
 =?us-ascii?Q?Q5/I3GaEWriME1wyh6Gx+3upyqqCg8Pu8us/1nYSPsF9bXBhjZcnkjYrTy5M?=
 =?us-ascii?Q?Ec3rgl1jHNNh8gagMlE9C0bIwGatELqV6ARejDTT7SKbill89qyHWmseIpI+?=
 =?us-ascii?Q?IXgzh89Fq9Fy8bawbODe0We40HTrPhFabeyiXUpaqKXbRjyk1u1S9ckCGEuc?=
 =?us-ascii?Q?eD4WsAPsbuzxWelpuTEj6sWyZvILnzSE5kBavRlQZMNb4eY9AScnXHbKfrcM?=
 =?us-ascii?Q?YmI8gRMc/gc0lKBcsdoTPOC0nlxJ1AVoYb0WdEP3NOXzTLDL2ISEMYrKtlPf?=
 =?us-ascii?Q?tM7VW16Jc8oPRGMwHQKmXIZpAEmilq87+V/mTdVV3GDF29drplWBDErADBlT?=
 =?us-ascii?Q?BUMigEZ1vyrvI4SX0v6wp0gVrrmtnLiosxbbmsbbvwskyPUFf2YZdur5B1Wp?=
 =?us-ascii?Q?+WafA7nnAfYOaMPSLTHmFFH/CMpF3WxGL7pA2okDnq4RgDrNk3xFbPPc65EO?=
 =?us-ascii?Q?C/jom/oWZ0eOBDuOpWC7YoFZlOJA/pWJuphZh+o9uv6bXEqDih/RMkk+28cz?=
 =?us-ascii?Q?QbpfhjxMmASHrauxusAQgwE+pZ9aoWyyqvRZYXcSwsah5hDyCR8rJZVJIqo4?=
 =?us-ascii?Q?CK9XWAwmaWdtg0AtJ2La2VUTd1rjZAI7mS+5cA4+tiW4sagYu3bI6LejduqD?=
 =?us-ascii?Q?4Dbc3WG0+X1vWthYnb17oyDy1Lal1LbBhRZdGeFRerGtJHwZwwbFXqQrMQKS?=
 =?us-ascii?Q?emxOAjYgDIXSJOHArZfuyPxWyO0pze6I7IA1SmwPX60NGIzueNolAgliSFji?=
 =?us-ascii?Q?DBD3gM9W2ca78NHr8D3ngNWLjP8ILYOO/R2EauqIiDFmaILyh2qBiWme6gev?=
 =?us-ascii?Q?jWBLfqGuPwoQFWkRAC4VBoZXWz+hkzqnZ/nwpJnOqV6Ig85S7OGqg+B9I1gh?=
 =?us-ascii?Q?LEgqbJv1/RknxEPmfYspo1s+r5rCK1Lu0A0NKfNezVOBSmd9smyA8BCvQR/j?=
 =?us-ascii?Q?tUvDxjYXbI7z8llXQ+wnuUC7GJ4fK/EipYaQzNg7/HGMZH0sGpKJjX82yfgG?=
 =?us-ascii?Q?Mi2Lnf0hBCsnII3rhYx8Ad7P2/oBmDNMiXxM1HJkIRswyLdLDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:11.8591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7481096c-cb55-4bb4-ae6c-08dc866bef99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
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

From: Daniel Sa <daniel.sa@amd.com>

why:
DML21 being overwritten after init.

how:
After initializing, early return.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Daniel Sa <daniel.sa@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 17cc2fdd7d34..f5c2ab0c0d58 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -740,6 +740,7 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 	// TODO : Temporarily add DCN_VERSION_3_2 for N-1 validation. Remove DCN_VERSION_3_2 after N-1 validation phase is complete.
         if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version == DCN_VERSION_4_01 || in_dc->ctx->dce_version == DCN_VERSION_3_2)) {
                 dml21_reinit(in_dc, dml2, config);
+		return;
         }
 
 	// Store config options
-- 
2.34.1

