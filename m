Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C2CCD129A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56634112E97;
	Wed,  3 Apr 2024 19:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KDFN2Fhl";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBEA112E8C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRirMCP8a78g6OfoIJ9pdYy/cZCOudmfYodrHdtVeJaP2f6NGFzOXlPNgKRXIfSLtXWYJ8cmpzu7KuOdbU9eMx0e0UcxjZuBtswaI0nlC1JNjAsU5qvNMUMrd+AbJNo+8AWOD1NBmCAOboS37+UYRgIIUM5DtZfyfTMuh/pR5oabZaGI6FNga+/dF0Excv77QXNoIMUr0JRYhuNoe7XtUAeB6ItfS/K5OACyI43oQh93aFpj3/Ij2tz5L4LM4k3x/nImvazmUTlTr/JQGZVHS61wgd2ecIBEXgSvFO6fIdydMyIVXfkr1WI+aMWgzFlBx/61eRIM47lCFqxEAlAJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAwHNKo1J43x9GTnb+V/pY5+nc3anffjDmeqkFyj0PA=;
 b=R28a0BN8faDd4TmAmW+sB8py7oU3JtTw+JlHh+EI45XeDOeyWidShH6H7cZCpJUYb5yRrK0IePjc5V90W7+gYFgRtLQPKlWlIDcm5mc3Me5N/rZIgkr4NxwkxWUWfULnA8wd5wEE3uf+rOU7H/549+SoNfSRYSuMsAwYj1DzAkmG68jQjPwvy/ToO8OdjrpBEdPTYoZluNxkGml3RfplE9H2h+V/kF7VK6UyDJQNAZs7kLdL8KrYURJW8u2lt6mLZNHHrtrQth9kXjfobexC7T0aKpQHL4fBonpB5oNBC4l5auF4NInhn4iBAlyPyJnauL+/fdxqzjSSFvtq5O0D1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAwHNKo1J43x9GTnb+V/pY5+nc3anffjDmeqkFyj0PA=;
 b=KDFN2FhlKhi/OPAKhb43y2ay86xqhfppe1adBDSJACrJvouOgY2prMInXAOO+DjrW3yVd9/pKjYMMvbThOsoWduynTv2b3TPvLDyzy0x5lN8XusNNOP4CP/A8nAgO85MFRN6VcqgloS/y8V1oPZR+hC4YxP9bzx/vqyQ9oydA7U=
Received: from CH2PR07CA0033.namprd07.prod.outlook.com (2603:10b6:610:20::46)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:53 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::64) by CH2PR07CA0033.outlook.office365.com
 (2603:10b6:610:20::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:53 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:49 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Figo Wang
 <shen-hong.wang@amd.com>
Subject: [PATCH 22/28] drm/amd/display: Disable P010 Support of DCN 1.0
Date: Wed, 3 Apr 2024 15:49:12 -0400
Message-ID: <20240403195116.25221-23-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acf4109-3e28-4e67-5097-08dc541782c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYwyvcCaUGcNbyJIFD1K1RrQTtAleRJOtWTt4JKMrr2VDrn/1jnkMoHBXgHYUNwkN4MZ04DcMi21I9K913TqcQp4//2mOKh+hDuGSGUjYX+YG12fDTYeNzymrkzdXp9vKjcuYfvZerZV/yx0wZwEQgtjmpoYJJNdJMaaIufqU5q7Ab4uohFReDfoGPwn81+BdO8OqSHL6fBqUaDDjI/2IbvyXSLASzwz9wuEXZCklxk/4oiJRTuSRgE+twFV6R7zdOnudhgdmHMv2gn15GgoytbKRLxCsw6fCOkIERBUboa+LRAloiqmNQ4o5v9dWkiiUrrz9oSb8NaZDSRSGinYhAUTGWgcR3FLttYy6kISf8MNRc5j/6ciqT13bEXJFPkjRgnnT0sPqJRzNQb8aDZ6hBjNBIuUT1V8hs5Mgic22MPQAROmUj9nVNd2v+XrFq3870nZHOnXsI2a63KEYKpr+4fqybv50P/OphFBQmx3hpTHpL4CUpitrv2nGILEKbPMjhzXAbMKG5ppxd198l18E5ZthGGGVJpqoX1W0F+dz7iU00o7PDCjQFoZrN5cxFLMVVDKDd2Z61Z0ePOXf1BNEk8L5xXExavzRrDvgukUZHkP1Z2LBr9qRQK8vvjUjVcxR60EreyfIAiqAoxI8oPwXtgFic7X8Ob9lG+6+dxDjEf2y9Y0ouNwAJ1WZr4wYWmUAO6kXyQtm4fpqvvUp6/sbyx/CrKTh6Emorx2LMFKzCSouoJHz6d3kg8fnA0Lf2qC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:53.4355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acf4109-3e28-4e67-5097-08dc541782c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
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

[WHY]
DCN 1.0 is not ready for the P010 support.

[HOW]
1. Set the P010 plan_cap of DCN 1.0 to be false.
2. Let the DM do the plan cap initialization of DCN 1.0.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Figo Wang <shen-hong.wang@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index d08d10969251..81fa2ac781f9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -513,7 +513,7 @@ static const struct dc_plane_cap plane_cap = {
 			.argb8888 = true,
 			.nv12 = true,
 			.fp16 = true,
-			.p010 = true
+			.p010 = false
 	},
 
 	.max_upscale_factor = {
-- 
2.44.0

