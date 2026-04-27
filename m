Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F923FF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304C610E7F7;
	Mon, 27 Apr 2026 16:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i7BGseci";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDC010E7F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIM8n8/TYFGQQH+YTy8uPWbM6WIhTLVy8usUtmEA9zEM1I6AsvKbvnZF9/nxO0jf1e1juGb0MY5/OmGtmDhCoEekOmMEViEMaRD7IJWmOkUyaZlryEQ5c1UJ/6xXoaZFKOBe6VayuQwJSc1/MgJfRSxwzbEZTMPutRfC4esJkUq7PZwAiXc5oIP8jAjpBGOoIZdHplYuTornBCu7vf+ck+xOsKvJBCPY/V8woBerN9lLwD0zf2wZaAGYd19SJCkfaGtSh8WGTvV0n4iL0eC8cZ7HXWHz06aKoXoj/hyN3S26PW3cQXLkhwuh0IZMqKLOhW7fO+jw4pdity8biNddJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty7SqkcHjVY7yejxiyOnXBNHck9RKZpTbdBrw48wGp4=;
 b=d6fR5IkrTb+H8Uc/r0nSia8/N0PhceTxu83aAUfeX2pTr7zer97zmMdUNVWM1zBHmSaoeBGmb0HB9D7DWLzDKVKwbI5DWj0rg7G85U7D7Fb+ptsUtz8xnHsMKNAmP6fD++b7gAmTd7UoC3E2VzyduXQsL5V+uxaKfnPt+7SUiKTiv3zTokvGBELjdH/Y1X8ZtXdmpYB1Gp+qfHtFYTixjcYIMVCaxtBTio2AYq/myKPyNm8YYsMEeL6GK8VCTfzKJ1LwfMiTMTe1r6TpvxMS8VSSrIu6U+VKBjvOTBdvqO8snNSuLfCzTtzJLNAgBjJur2wH+T6Z3A/D3dEF+n8daA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty7SqkcHjVY7yejxiyOnXBNHck9RKZpTbdBrw48wGp4=;
 b=i7BGseciDbXPLCud+4Orcby7RTR5TwlgGPDdp5PJBsSSQzNA/9U85rmXDxwwCGZemqS0jYLERu2sXivZ+7v4SyjDw2AgiMS/4a6DXHjJDEL7INhOGy6rUKFjReYb7wm8qmdGWCJOkgDxzN18mZVGNWhe1Do4nMEGpqRzlkzMnbA=
Received: from BN9PR03CA0768.namprd03.prod.outlook.com (2603:10b6:408:13a::23)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 16:00:11 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::26) by BN9PR03CA0768.outlook.office365.com
 (2603:10b6:408:13a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 16:00:11 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 11:00:03 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 18/19] drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.2
 ring
Date: Mon, 27 Apr 2026 11:58:56 -0400
Message-ID: <20260427155857.1370151-18-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd48987-8c62-4418-6a16-08dea4760fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: nPfzBGjNq/nx1xdUZYhHcq2vn34fsdvnYfUBMS12R4T0bj7/S947BliTNfS9NQ05shQuWiLZPA1GeIM4Yp7709yst6VWM/ksom6iQUlbPNwj9F+m4x7CahekUszdgWt6YDj5JHoxWVwmRuYGgk4O+OlLghSm9ibJCgHCdz5hs2mvqcGPaOwWbTz3HTk8tZNFCksfh+LfU/BBZ1yyLZ5zT/yWSDhFVy3+aeB2JIM8mKDbJ0kehc58wA8eVkRIeon0wmOZ0+OVXiLrKCIEpZY3xCeg181KikFwRSxNW2sCpLnWj/ju1xgVVJq+JHiBbCZ505ykziQMD4/CsUqWAEkDsJy4bYDW8PbQ4uL9yaPGdo9KSbEml0wc+us1v/X9Vvu11LKt+ltlM2KhhWrqhAHIpVUcgqQm6/p0MEIQHX7J3qmMzlcHWCbssjFyOkrmx2aECTaflosJR45WzMWmzQ6glhfkoAMt3B7CJRxE7crUUNR67vD6LlcI0yfyu6aeFTbIubS9EXMp1sMWI+HrbUl9Iij2DGXZcBBK1sfdljvg6sh5WjQPp9paT+euqnqh0N8v1LZh6K98UcBaYUVVsK00+hTjaybtAwT6l+pUJZyzZitpAF7PLvSW5ohhW/L21S2cJWymSRPDZbNq4xv4VKfGYnaV/BytzPODVnUekg+U05y57s3tsO68BQq9chPt1aiW1ORfUyVeMvLAqQlo8abQd/FEKunmg6GasLQpxM9eLCZhSsYMuCXML5nz33fZAzYfZn/QeB1z8bmLDGC0MgpHTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ck5yn42WXetCo9t4bHp8rfvECKZfsvEyXrhs4/Ncdd4+s69sxheQcPBylNijrkxTrtLeyCjhQ1dxDckGMRk6E+//15cVG0vARaURcsCPQ2jDVKh2BHAWdvPy+m0/1OIWPy8LMGqcVLoX5sZpciLWGl887lMdLLDMwUCYGT6GonkExeSCREglJlEbwFVKOexCNKCBZGPGdQQXjYGaElO0BdfbpDRvqK+sqJR25DcTWyxbpPTGOOSSTfWhpqxaBg9C40pbtCOT0wgG9YPOJ/A3ruTVbbDEdvj8pTMzvSint1IfUTLItoos7PikUAbIkosLhXFUdH2TZD3Enl5NOx8qShdpk/bncfiA4aU5PJ6ULK8wA+dgSrFQzyWaunwsMKmM3ND4IPULDHajipBZenTHWUFI+wesKBkijlkVgJB/bnQobKPCb6nbMDfIu6cd2zby
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:11.2702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd48987-8c62-4418-6a16-08dea4760fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
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

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: cf95cbe90308 ("drm/amdgpu: Add JPEG_v5_0_2 IP block")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 285c459379c4..7a4ecea6b39a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -703,6 +703,7 @@ static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v5_0_2_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v5_0_2_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_2_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_2_dec_ring_set_wptr,
-- 
2.43.0

