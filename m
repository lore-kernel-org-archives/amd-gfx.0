Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B762CC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8ED10E8B5;
	Wed, 10 Jul 2024 19:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zXsHWmtV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD0A10E8B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkDn5t6wjFkYMN+Qm1FbJkC1S32qW7Ri0Qk4esXwLcGso58lw5joiYv59VexTj8QPuuuTL8TKF1W91UwhtGi6/GUMevvRf2Ut6YzOYWqqLyz/NZGftGFSYUYHP+H+8X0pNF25u3q6mNvqHFb7QBRZIOGSbXEZR5G5i46SoLBaNtu6U+ycQYgVcIM9acGkwI0GF+NoFBPVSLIseT1mQ+ywkwD2d5oYgztJqUQsUPfxL7ju/wydAoWEYwJjfWNoWqaxczUnY9XN117e1BpjO37pInv/P4MtOR+mayUC/C6ngu1jPtmCXYb4oeRODyRU6oiIVC8VkQXYEhG4gZZKs+n8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKRbvGaUt2YbHQSr74zDcbF95WzovqqNZVAFLAGnHpc=;
 b=MbIx7faiooiNmjD8fd3ayrUAAMb1IeIgczLvqK951y6bMQaW3XALqSmCTgNFsGw+vttQsvk4OqI45RGnulFZULGjsfGuwRDza7G20hGvzhM+brrIYRxMbgd11dMfem055Vdrdt0Cpi+9Ffd/Is+8U8Hv3yoUKYSBPdHCmQ44jDM20vEK9pAcW2v1aEmxWDKZVWTZMkpkA0F3dm+6uLcVwwstyeWV0uONDoI67TG/m0gGKrJ6kcydkYiv1S1uv08khkyLluke92WwtCIqeNADHFk0t5Jjrc2OrLLC7ghWOQQqD7RoyLs/VuFnKbMIxZGhvckscZgpYFLXy5cwRgJNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKRbvGaUt2YbHQSr74zDcbF95WzovqqNZVAFLAGnHpc=;
 b=zXsHWmtV48AXSheMPAPKgI9xX4nxRx2u2B3cFg2tvPfdmbugic3nsn/EkvwZ7srAQ4LpqSVF0gFoaZqM8KEJN0z0pYCm18x/MjlSEz7w0BLTMnH8mr0EGWOU+Pp/po6syNVttxVNLa/XZKqslTkaMocQEohiTIZAhY1VfJqaPkc=
Received: from BL1PR13CA0126.namprd13.prod.outlook.com (2603:10b6:208:2bb::11)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:39:07 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::9f) by BL1PR13CA0126.outlook.office365.com
 (2603:10b6:208:2bb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:06 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:05 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Chris Park <chris.park@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>
Subject: [PATCH 23/50] drm/amd/display: Deallocate DML memory if allocation
 fails
Date: Wed, 10 Jul 2024 15:36:40 -0400
Message-ID: <20240710193707.43754-24-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f11aa28-e55e-46c2-d7bd-08dca117f6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bPT8Ufwc1NrUGzPETgoAhWt18YCqxgnl1XH7itbs4+DPvsSuXQBbgCw+nLxl?=
 =?us-ascii?Q?SIHxJUnn76aiAeMyFeVfKexnTMVvFSXidDu/IQVGQS7fu/rjqsALEmVmqp15?=
 =?us-ascii?Q?8F+OX4yPlruuz8DAstpbVTccSbBL5sp8ntf3YiQOfst1UXnz6ddXvB0QwX1X?=
 =?us-ascii?Q?1VNb178QF9zYE5Q1A75PL2LLoPRvxIxyuxV/W18wuCV40XeAXJZn9LNU2dMg?=
 =?us-ascii?Q?0XzNcPk3oPy/2QRFFAmEs9oZTnWBSzWmtSG+vSsDjbLtuaFpJI0PmZPkqsia?=
 =?us-ascii?Q?vXTPMHE45qUHEVxhMQxEH0YycAUaeZ9tA1k1eyKbqnP1udomlScUTY9jm5YM?=
 =?us-ascii?Q?CO6SPQ7IEMfZjKQ+jA1ICgw/yv7Og3e+KRFqeIy5hmLR37uiBSH4nB8i9h3u?=
 =?us-ascii?Q?iWf92hb3QiMw0a9TYooSZk5b9h43J7VrgB+IKtOZ5LAQcdF30jLb8n0+BILi?=
 =?us-ascii?Q?G981TN/TxWMxQfQTIzQA5ciGCDZlumpH1aCYOvReqMZpyc700Kpkq3ldpAyo?=
 =?us-ascii?Q?CXNFbO6TLFcOaYqSl4cOBnU59WLkCjVUfLKz/YAV5aaLlYL0J5j9QeRvozxU?=
 =?us-ascii?Q?WUDMkmwxEeRHZ0l3xypPOzR6Y3d9uuASAmvvluG8s+V6qK0+u6Uu6QlckgEd?=
 =?us-ascii?Q?M5PuF9A/6r2i4n81+lzrF8urbm4mQ0ySL5ImyU4ISLOduDHNfGWMuDohpzgE?=
 =?us-ascii?Q?l0S2OVwSWJUviVDfn5W0HMTcw4GFjz3txsV5JnOW0MSGpt/SzyPPfASxaoFK?=
 =?us-ascii?Q?WU8fPSxwN+Z8jLN2GPD+7l2BoQ8qAwShMPrcab7BqsAK4ar+P+rOUugEEDdI?=
 =?us-ascii?Q?DB+HtheNALYrcnfNUDXQ+skFzZL7dioCJ/p/qzeCDrvLxxsDv4U1Ha2GSxAo?=
 =?us-ascii?Q?892NZWSnO8FAPjOGcjCapNWZsQOYnxZe5NCL/cvI1Qs3GogwRQ+1p76B4moe?=
 =?us-ascii?Q?xHJp4OM1A96H0D2MW9ifaVB/8Q3aY7oMut+I2sjuuVlL3XFlTXzN8BD0I6rj?=
 =?us-ascii?Q?vMV9mstJQpi5SOZKLP7lWI8hlkIvj3KCg/eL48arBAPbUHxqzNN59wG5Ug2E?=
 =?us-ascii?Q?I7KH/lx6+X/rptsQ1mBXPiyX41xN16JTAacnWH+2O7DNWKIY69LboB5q7425?=
 =?us-ascii?Q?ml5NOZe0Guq5CHrfRFk3ZAgFfWLPBRLp18nYwVmCvQ7/O8lDAuZotoz7JOGV?=
 =?us-ascii?Q?cCD20aw+x/Ci/Sw116vVK5OJZVRmveO1yeH3V/gF9NEYzf/2OAQPznPT0lim?=
 =?us-ascii?Q?BzQ2eFvuRWftoXl+FQ2uUnDot7lhOtiJx2MlgmB5dPL4c9HJ2tk6d1qSM7f9?=
 =?us-ascii?Q?asBNfkY3B3rGAnJBmAUtA4b8XaWajdnAt6nQh4vdc0PexZkCxV4Tx2qxcql4?=
 =?us-ascii?Q?AC+8vvoQ90l3UVP1fYQAsg9TtM6x2pBCZTkyILQyyF+7CKlhM8tLyJmm04ne?=
 =?us-ascii?Q?FfPPY3njptsB6qxKXOf+myb8AJ74Y+nC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:07.5477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f11aa28-e55e-46c2-d7bd-08dca117f6dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
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

From: Chris Park <chris.park@amd.com>

[Why]
When DC state create DML memory allocation fails, memory is not
deallocated subsequently, resulting in uninitialized structure
that is not NULL.

[How]
Deallocate memory if DML memory allocation fails.

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index e990346e51f6..665157f8d4cb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -211,10 +211,16 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 #ifdef CONFIG_DRM_AMD_DC_FP
 	if (dc->debug.using_dml2) {
 		dml2_opt->use_clock_dc_limits = false;
-		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2);
+		if (!dml2_create(dc, dml2_opt, &state->bw_ctx.dml2)) {
+			dc_state_release(state);
+			return NULL;
+		}
 
 		dml2_opt->use_clock_dc_limits = true;
-		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source);
+		if (!dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source)) {
+			dc_state_release(state);
+			return NULL;
+		}
 	}
 #endif
 
-- 
2.34.1

