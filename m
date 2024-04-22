Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D85EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 224B8112BEF;
	Mon, 22 Apr 2024 15:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mugnGMiF";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF40112BEF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9u5JdGartNu2fkEtKxLDYiGOk7zXTT4ae8ZPfBxSFo2FvrEcSZth1RhZhDeDFiHq7H+M+270IWv95IvjWYpl4S3BU0zcKs+zDtBubm3+ZOJ20u89ht2UkHOkMnJNwrRTSvhBJkywAoT1y+/tv2M7bLhjXhWj5d4g0Tirn/oengQlRXw+sjw/2Q2QO7DH/uNrHiUOwOowrJvriFCXuTCCPh0cVMOhcJNbQhAvXO5gKx/RsLN1dj9CFFldyspBq5pxC2TFTUh108mFEDv9NtZQWhnDIXK2YKpQaBBQjm4vFCHjGmsILMvuRqcmaQQQSjD89rO7pKxEj01slkAbBqbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAaeErhFSwmL5Zsjx6aikvgA1qSoVu675gwBL/fUH1c=;
 b=TOcte8kie9aqw4VNwi894Vi5ZcISMsBxR5a9VfHMSvrUzxhv7s1BdQ7jD8TMwTPsikyR5pfjmVU5cS4vTr0AgCY6xIDHJM7c/ve9fUBjMGurZhgl/63iHddrKzLbiI6RiZy9sXfv0fLsQqgwSkxF/5EKMmp2yIIQ7//Yk0giXlsAXwR1i4NxZMBSodU97pTPPZj9nzqPvv8LVGGZ9yU/3P8zKxZxJaZWWA4MOZPHgjvEx/SGpC5JtkcJE2fbuOSsoykn/rrtE108rOtE4SdoumuafqmouR1mQ0e3Jz3uPOE7KT7Ol5JF8noPLl6oybtUq9Z4aTul+TxDnM2orBTYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAaeErhFSwmL5Zsjx6aikvgA1qSoVu675gwBL/fUH1c=;
 b=mugnGMiFBIytF99gIrgOHN9bW0tf3RBiwamCAJkI8daf6TuV6dk/TvcYm2x2Z/DbW1gxHyK7EfxKHZCgt/RTk3b6DcY0oXhr97xBt/ZxEG1gv+8CWunWlPfkSIUzjoUEXpUjheLz/w71+bM24/AMun+IjtVtqMi5Ve0ozPIwjRs=
Received: from PH8P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::21)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:22 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::53) by PH8P222CA0019.outlook.office365.com
 (2603:10b6:510:2d7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:21 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:29:15 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 12/37] drm/amd/display: Ensure that dmcub support flag is set
 for DCN20
Date: Mon, 22 Apr 2024 11:27:21 -0400
Message-ID: <20240422152817.2765349-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: e0064935-adad-4ced-df25-08dc62e0fbe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bjCtjbw7dk2kjymwTdHBcywtLplF2LALNQHes1oKeFju0KP5Dfh0Jz4BLxqa?=
 =?us-ascii?Q?Gm9MPDbAk3oZ8IXxEijY1dxoPxNC8codTqn8PisGCYT63nOH/Hk+FNHK9SZp?=
 =?us-ascii?Q?diAU7GUDy/jHR0XVxaF6bYcIByj9bVos4OQCvutMcXEEcX2YVmrKOy5Gs3Lv?=
 =?us-ascii?Q?hIZAsuWPjDmIpXbrRI2vWSvFxuCWx9ttRe7NHGO1Xwp86iRg+X9I0EgjrFeZ?=
 =?us-ascii?Q?TeQHms05TYvJ4bRWNNI6lp9rrS9dTZeyo2Lzl3SyU3jXqJ2BhVOr+J0S0GkC?=
 =?us-ascii?Q?uccwjRBFujk4YdMS0gGdShzUctc821nnyTGKBeDz0EXZhs1XAboyp4fJcGwr?=
 =?us-ascii?Q?SlO5jBhZjDBBBdIz4m+Xxrtc9H8lmqrWJequdq3OnlbhTm6VQZB6Fgwan1v1?=
 =?us-ascii?Q?i6PCtwgNXlNb1e2CVP/m6xSGWYPXp4iv9og2bmm2lZMlKFPkFjlyZOe60IYH?=
 =?us-ascii?Q?EOmTW8OGPHObS+JqvZhdAqM2xT7qMJuQ8g0798lO6wrCL4l9L0zaku6Mqu1M?=
 =?us-ascii?Q?bqkQq5cv+pEEAQBio3Ga6AEVSX+6/93uXHy6zhNUlZXDiuL1byG12ztdMql7?=
 =?us-ascii?Q?fqgmSMbmk609TEqUsRT0q9acwYXwxnMdCzGoGzNYOoaDTKaYnjUT/eGgUwJP?=
 =?us-ascii?Q?7GGfa+47PeWpwo/izFbNgjOCExIhepV29/Jj5wYk0Fs34VIBPIc4hVBS7Bo7?=
 =?us-ascii?Q?W17dYkarn6b4JU9YRHkFLnb/QpCLjOHqlVuNUnOKljrIxkc+3yMb1Owjt9kj?=
 =?us-ascii?Q?iGXLOc3A7A+lPler6ME64YlKE8lQiJ22OkE40C8li51MRBDib/yr8++QU4Co?=
 =?us-ascii?Q?4TDH/v+AFsKb9r8zRazXvRF0Y4aFRXA+lf8UdTAac400mvTB/ia2edsoVFfg?=
 =?us-ascii?Q?TSTtDF6Fx+UaYeAtUnaaOC9SlCxSzaRNppzr3UYQUF3NV+faBo6mKlA+FgcM?=
 =?us-ascii?Q?t7+RTM3tNsTBgnTZlooJ1vooQePa3IBxPCCKtSWX9wOIFW5/SBLTUZCDctWQ?=
 =?us-ascii?Q?HSo5iQ3swDvo/Kvg7gkdxO0QkxAVBhg7h/lIo/bqSSF2Aeh5iE+no+hJHmV2?=
 =?us-ascii?Q?YPF2VwUm5cSuSaAFT8la8fW+Y+/YQkdbGRrXWUcRcxEFnDicNvCoZ51lFYAM?=
 =?us-ascii?Q?olT4Wy8UR1p5VcKkNEtlZUlIwGzNbFkFwT+jQJJOEPfmrCs61lp3NOCo08v6?=
 =?us-ascii?Q?cjzrfuaUPoe7RbIR83+7pmttRKwsAMrEDiJVBdSC17ayFzeOvO+vtQLBKHQv?=
 =?us-ascii?Q?3+APMXl8Tg6FrKXZO6Nw0hiK16UACjE6BOnAffCgqa7nbq/CjHOYyWj+e93J?=
 =?us-ascii?Q?t1jiAo1VaVu4y8XzUYJclGR2IFK5KTiWKdsOoIr1be86qFGsKqwRFNB8ifhM?=
 =?us-ascii?Q?f9orCZWWiojzrKTaoTlBEasm1VrN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:21.7419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0064935-adad-4ced-df25-08dc62e0fbe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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

In the DCN20 resource initialization, ensure that DMCUB support starts
configured as true.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index a8173b7880eb..fd5fdb7f4eea 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2452,6 +2452,7 @@ static bool dcn20_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
+	dc->caps.dmcub_support = true;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
-- 
2.44.0

