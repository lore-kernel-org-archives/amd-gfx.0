Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1044CD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 21:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642DE10F5E6;
	Fri,  8 May 2026 21:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gxTKsf/d";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5874010F5E6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 21:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJ0WkZIREbkLJggbZRMxy01fbvim0sXAKKDscBn7keZGLsFpT4uTEKQ8V5sST9YcqkdxriNtzo/Jpiewr2CPsU8kLzvLPqYYCStxjBVgmppTFCvC36+K4CjKo0u9XhVssLSXPOQOoYXF8lVhxCZAga2V6iGC5vb1Ya85vrbLs6mLyGVHsiknj65yPkP+cTmFq9RhBZj9ebrERD3NGtg6It/3s5jFxMRno5XrlgrzgIM1CS/hBI1PWj13g1LziQ4u9JnfVc52QBr/cmrLS594XzIIkkt4MTdS9FCfxog+tsqPeAkH0sdIaBX3uqzfbfkCMXunNYRddcN2VVApS3P5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dxJA2/SWkhkwK0hwyJ/dCnVJjctBERcD0DY0lyvT2Q=;
 b=N/iC2TQyiMAsj7WEJcx3lxhOoSLhVrvwE1UBUyZECG08UAqljCjmXmPkYw6D4y6FSDulrcAQjur2r92bulbgvOHXwRoj7ng2OZNZhpswQbjCgqPpfzlLXAf1AwP6FP0ssb7mQTAllqhi4Bu3z0KlTgUOe8bqVdh/AnNeC0VB6aE+i6gDwM7frxfzd3R4YRlpP1Nno6Av0ws/fUQMGPJ9pgHDjoWsG/qta6R7fTdAoY0q1aZcV1Vrwt/OUfxSdxUJklWKqu1J6UjOyCQI8w5wIPzyPBdwAMVqgKLg889s14Ta5tbQGiCYhwZdqmd5bCCuLe/AsV0jR2ifdju3uj0QAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dxJA2/SWkhkwK0hwyJ/dCnVJjctBERcD0DY0lyvT2Q=;
 b=gxTKsf/dWINVAdxfZLX+kvbkFlqdaHwlZwaflPmgtCeXCy47JFQKWL6+F54Sq4D8bACCSijiYQzrA6qylMZKdYTVO/An0nHmqVEUK37PR3Y7lu424n+rrBrmNZxz69aUWGSjgT7i5k1rl4MLZg/6/gN9xjuH0dHrX9YBaCN9oK0=
Received: from BLAPR03CA0146.namprd03.prod.outlook.com (2603:10b6:208:32e::31)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 21:13:48 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::e3) by BLAPR03CA0146.outlook.office365.com
 (2603:10b6:208:32e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Fri,
 8 May 2026 21:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 21:13:47 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 16:13:47 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: Extend MQDs in HBM to gfx942
Date: Fri, 8 May 2026 17:13:30 -0400
Message-ID: <20260508211331.38805-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508211331.38805-1-kent.russell@amd.com>
References: <20260508211331.38805-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CY5PR12MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: b550f232-58f9-4795-eb3c-08dead46b1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: qc2kp+SfoJirjNwIEByFeEo2WGclAtkO9UlM+u68RonHKLJoSRbEYX/5Wwk6XnCHUuAZpKK+ibgSf+ZRhSY3hQChQDemnUbZ5Zc9pXyOaTAShylOWpBAZokO/ghZYurcJWcF/yBHt0blg0gyGmulYIB6qPu3mwpW+TRsp5/o0wKqVOWqtPgBUAwLOVpZYngyb1ulEAoKFup1ZMvcqsFuykq4xFg7vUkGQWhwCej8TeZzFO0Q4sL4fAyqr7MP3zyvgiwKFjNg4rLTpzGJfQo04mEvhDgFG2yIbqXgZsN3lho+gF8B35nVsOXY49s5/slviunIAXWg8CGAv6FvBb139zw2tYzmR+5CT0P7N2LThrMOKBLb7TPZFFM06oQEksN7sx94ppL4nEYdRV2y/hO0f4UI+4UFaYyzefkMtMBnn6ZXPEP/whJjdzMF+YVAKADInjoQMUynUGddW3ierQzjLT5yfPJdxlMBVifCdv+3yvU6hR5sRu6pGqHBwICF+cdhI6jL7TgW5GEqajS/MbEUP6XFQu78yG15Rw9G3hRUPXqdqwAMlJFaVYBizREBfHv0FidF5aG0DdossJCR5jkQBzZFBH5VtyBxaNDmouxn1aygTwC4ZOL84mjYjh83xc7joMoHEpEu7u4Qf8jk1YbjjlZSwWM2IVvhwHgWFjcpPuZb2NbBkOGsLhHV3PZK3nEqWwe5r0w+HBx0+7dCXRWAHH8VjDWF2Y+KKD+nsv2LeVk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3IYv8JutL8KRVCZ+2tP6QxLbBtKCNvEtCMigpCZOqBSjrOR1s/ttjN86C47igOgekIp3FwQOwiGlUkileeH4EHUWAvjvZp6UYRdHMbOshgW/IqUZiiWkHzb+FiFRCZ9/AU2+xZF42e3RNIuTwBsrw+rQr9E+LJwiNbainpDtIrfUWJ3EphqVxGvEHzxWFTgQ8zjV92FWY2Taswke4HcQJfmb/+x8mfNDZAOs7x6w5Nqs203kKVCL4brYNidEV7/o6KfBvq+lNstNIMDCPu89XnvtEKrK4OVWvlVMWgEzLLzYC0WjtV1tJAcwwTi+7+KaI38XIRXzJZ6+okj1JhjANZ873IGGZDYavETHCTDc7Ujgr/l28sQcxU4Disdoejwk0deXZzDKBt1gen0wZ8XavwK+cxDAU3hHLYiqznVoIcwwJf3PbRYrqbv6j0VALMIH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 21:13:47.4532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b550f232-58f9-4795-eb3c-08dead46b1c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
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

This has proven stable and performant on gfx943 and gfx950, so extend
it to the Aldebaran/gfx942 series

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 02b52f907f80..5970a1694286 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -322,6 +322,7 @@ bool mqd_on_vram(struct amdgpu_device *adev)
 		return false;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 2):
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 5, 0):
 		return true;
-- 
2.43.0

