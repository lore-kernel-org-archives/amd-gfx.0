Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B056C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D171711394F;
	Wed, 24 Apr 2024 08:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/LmRJB/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919A511394F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvfWe6cmGxbiA6U40SUX6QQaZbBqh1IUKBcVOnsg020VwD0QkOO3fQhWi1tJTDWfkFuNokhBk0vr3VS6K7cKOUvWj78Av4mA4HMPZfBH2gfOs1aoW3tLU/PnDI3UU5taL0G9VJsvYnbQDwILW627IgVp0BAk0ESTABHFgtvEz1dGXTEUMwkWfnWPEbdPOjJfAk56cH6OouA6EqKEpwLRHPyOpTG4WeHbN3/6rg2k9VM9Fr0XHnrdklxOEYOTklmi7o5eA9iJZfEwvEVc7nSnrR4l9H+VTKQ2X4Qy3/ckO1+ETzA7w5E8o9NDsd7Jh1Q8G9MMMt+UratI5unpv2EfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/vMuBhsJQdIPCUlEmqiovJUzMUiLYNzQfNPUhL6I0U=;
 b=IVU2hnbhyTCdk7P8Q6J/CcVFrfFXi5rchScITKP6jHBrG1SWkBdZ0F3DkVNVY2pMjYK3jbythZJh8zGwKVpi5YgZUFerflNIGZJqsIJ5A5QEJTKtWEb5SltMkvX06rNAj55RxHWYfewhOyd2e8PPfWVdEEDKNc1ar296CPZfBZgX3a7rt9nqQaT2Z6iD5Tn/ihsQKnDe3FdPdyQzurgeADK6VNn5bUDdScfdzYJvQxL/tTKKZKvpl1Q38IODh82uaCSQRMSIR/H5LWfw8zQvwfLIxbnO2DswQuT5sSDPX0JupAN/vuSf1ZEaGo3e1aMj0h/7RVRNjgJkdC53wMHu8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/vMuBhsJQdIPCUlEmqiovJUzMUiLYNzQfNPUhL6I0U=;
 b=h/LmRJB/NzAJRFFS7zGBC/J1mnrHm58D6+bm6IN7BTAFCSGt/9mM7Qo1jdESiqv/fLt8RvEccCNmCi6yaps3Uyrs+mMNQbiltYP4cP0i6m8In9cugPBjo4CWlJK9zOjcYsH4mL/NiBGOk2iNSFxCHkfSQ4aVvMg1VprvVVbxNYE=
Received: from BN9PR03CA0396.namprd03.prod.outlook.com (2603:10b6:408:111::11)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:50:37 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::f0) by BN9PR03CA0396.outlook.office365.com
 (2603:10b6:408:111::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.32 via Frontend
 Transport; Wed, 24 Apr 2024 08:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:50:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:50:36 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:50:27 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 05/46] drm/amd/display: Check pipe offset before setting vblank
Date: Wed, 24 Apr 2024 16:48:50 +0800
Message-ID: <20240424084931.2656128-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b97ca2-a196-4cbe-4abc-08dc643b9ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3xdJ//83W8lJk7d59hhpeXPejsBFPRuQlPOtj99BOkWONM5o3+SXft8dUsdG?=
 =?us-ascii?Q?W56r/c/60elpDHGTporT4DXHkdMkhudrDwtBRMQvw//8/BxcRzITpZauN57a?=
 =?us-ascii?Q?yDogg6Wak+q2F1+JK8KXoV0FBeEBPixp5gghhb/A6CsOqM98QLbaugWdQVpE?=
 =?us-ascii?Q?0Oxjt5tOWd0S/ULW/hBvUyexwflpEqshnTZ6yd47k7/AJiBoPWB5xOuN2mRM?=
 =?us-ascii?Q?F9NkDcI6i06pEaY4rHgp/yL9cEfW0xPbqPJtsw2fO/Gq7skJhm6FLCjx7w2B?=
 =?us-ascii?Q?1XU/CbQkTkQaHhdEjGT0Pyan6z0AJ9bP5C8PoDJdZh7B8+sutpnX3kNmg4wJ?=
 =?us-ascii?Q?u8r7GaM5EuJJdk+1eoGCDwhnna3om7LKH9xgZncMx0Dq28/7kBB2kyTyUHqq?=
 =?us-ascii?Q?FHYqfbL/Oh7usBpiZ1uSGmqSc05Ev6jCa1UvI7Pb7aj1TdUR/guUan5yfDbo?=
 =?us-ascii?Q?H8d0ZYfsbu7w4okVFHUJ+qNrvJo08Q2yt8tvaKNSbhrn2PDnYFBNUd+BG/F5?=
 =?us-ascii?Q?0niloJBHo1yDlSseFWMGcm06jKB1CAF6bFi/vsC5WtZoennYS3sYpYQrw8aq?=
 =?us-ascii?Q?nncJRXYoXdbJgc0M2t+uid6lJLL+NFfDN+cGXBjR8dAYzYbk5ZSx7hxjcGlN?=
 =?us-ascii?Q?DfIagP+x6cKmrI1ib+vbmabiByT2o6LH4SuERiYQwtN2Cucq9Bi+t5Vs42bE?=
 =?us-ascii?Q?WugZVMEMeuhX79AUuiHBzGjY9gU+proe/DXMD2Zug3uU0mOLddXHhduUHmQd?=
 =?us-ascii?Q?yl7xlbX3LyhiVCFqvlaZQOVW7tkyymf3wrlaPh+9s2Dud7b+3/jiRM4S3gbm?=
 =?us-ascii?Q?cIawGEIB0TKfho2hk5BXaYi+b+VTCZ9fhenHma0/JI6EbvRAe+Fp76qadWaK?=
 =?us-ascii?Q?0hY4sZlffRtctx+UTIpjjlj5PQKJ3JwlyKKEjCO3vFNJs2YCb8jt5xoc7hmC?=
 =?us-ascii?Q?AkRXINotMEPKFYk/Y/ckxQYJddTBAo+Fs3qyg6Cz2NLao+Ljm/dFAJKC9MdO?=
 =?us-ascii?Q?eRPGppBsiTntIDJugxo8V6YWrn73hRw1HJAd6UC6A2vcyRio+pqj8eWo2iSR?=
 =?us-ascii?Q?VxdAiFYPFYbLQTVncKR5b3MuD2/M5/V7K07UY0cMSJu6/66p9P0n0xjEU8cR?=
 =?us-ascii?Q?QGaZAMLrPDpmtW3CthBIc3sfPdNKOeKQdgch6MGVww5UK2U2RmhaqqjY+NEA?=
 =?us-ascii?Q?DniQXTioV/iZBCp3J6o09BLPKEh4a6TPeudowZGtc4np2vx3Nz9W4NJ6LeqB?=
 =?us-ascii?Q?BFVUNcHJOIquGotE24PHqPFWGqA6n8vjQfjEdSEvkFER2i3vKUvKBqFMFTVj?=
 =?us-ascii?Q?G70gaXObF5+E77/zSCWhF1pEyA2k4+c3q2VZB4ObiwSCTyt5mKEp9KPFqiTy?=
 =?us-ascii?Q?r70926NcGTIsF0dA7CPZaIzxHXTm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:50:37.3225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b97ca2-a196-4cbe-4abc-08dc643b9ca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
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

From: Alex Hung <alex.hung@amd.com>

pipe_ctx has a size of MAX_PIPES so checking its index before accessing
the array.

This fixes an OVERRUN issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/irq/dce110/irq_service_dce110.c    | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
index 1c0d89e675da..bb576a9c5fdb 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
@@ -211,8 +211,12 @@ bool dce110_vblank_set(struct irq_service *irq_service,
 						   info->ext_id);
 	uint8_t pipe_offset = dal_irq_src - IRQ_TYPE_VBLANK;
 
-	struct timing_generator *tg =
-			dc->current_state->res_ctx.pipe_ctx[pipe_offset].stream_res.tg;
+	struct timing_generator *tg;
+
+	if (pipe_offset >= MAX_PIPES)
+		return false;
+
+	tg = dc->current_state->res_ctx.pipe_ctx[pipe_offset].stream_res.tg;
 
 	if (enable) {
 		if (!tg || !tg->funcs->arm_vert_intr(tg, 2)) {
-- 
2.37.3

