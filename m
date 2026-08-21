Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54000C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB0710F361;
	Fri, 21 Aug 2026 16:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZwYH9iK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54BA910F362
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGESom8DNKaFnF5ipMDIWQi7bhxoyyp7np44fFmlUmb527j7V0ugXdjCwZ7bhA0XwWGE896f/AmeW4EWn3AY1By7g9/EZKC9nFhIGJn45Op/EMk88JOT8CIcGzuZDbc6klb+0I8pPJ2BGiZ4ZZ9k45GCyqDpB50wQXtsIddrrsE7hRAcMLnrC/BmVzyu/DFZxgyZhX2rZ+j8YF7tiiGuWXgC02u8f5amUzHxiMgmwm3zZnQfJ+XwkEgsEhtIdYzGac9kEMzbETynsI8QQ4Zncu3omPAkC9zAqsdHtd9vXzp0OKfPMkn8koHa9STjZnH2mvGA1xM49tiKJ6RP0KQ6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3RYAveQbbyRZPtHaU5FVzuxNgvXuVTjesSRNSTPIY4=;
 b=Eg/pyYFz0+nf7E0XBc33iRd+5qh4UPlQTuanUCzlWHFjh5LJWxC7sF09cRLoysgCJ2zmS1PU6MXcYOWxTdad8cAeAHPzS+AYCjPKHzxCKH2fNsjaxnau3Y3WH3az7bdR5hQaKzQWE710dtX+G8gc/mCOPdaAori4OD8fktmROPTYtR8C2v0vCgKckW3PY24LcDRxuzU4txWO9BY/N+OMRwN6RAqD66T21IMphlXkd1uQSXQfitxfTFxDOqTGZM0ugvaepllO3jD9mzVHqXFBzgE3g8Ouw4l6wCZcz0wg8AIWvFU33yYCnF2gJKmHQx+Sc01ALLsw81tPAxJJR24SgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3RYAveQbbyRZPtHaU5FVzuxNgvXuVTjesSRNSTPIY4=;
 b=JZwYH9iKz//viOind7y/JWodfTVv4LrGalzjbK7xSY+xowiqIzpauHft+5HLwoRcww/bCG+En9nHQd/uqnFPKmo5chLHViRYJp/dJs7F9ux6Z304JISydK9zeGN2stqArkDdrrB79Ow0A7VaaVxNvdoei5NSm8TxUKCXK8qb1uM=
Received: from SA9P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::10)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:10:14 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::50) by SA9P223CA0005.outlook.office365.com
 (2603:10b6:806:26::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Mangesh Gadre
 <Mangesh.Gadre@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/13] drm/amdgpu: Use mmhub inst_mask for gmc v12_1 vmhub
 setup
Date: Fri, 21 Aug 2026 12:09:49 -0400
Message-ID: <20260821160958.753063-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef07fcb-2117-4bac-a9a5-08deff9eaf1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 8hg0/XiGjkGlK2gNZhzySnLPAJe9X5XmouMnvgaO7gjS3t1w0ozn4hoL3EZMBYy27+J3kLTHYPoMoTgOCxerpOgx6YCBopEDsS7dU13MirtpEVRT9NyspUu2yPw6xE9OCHEJ+CMZvxo/sdsiB6eA5B7FQS11DHp/V2Xoc8G3otPEHahBu6A+gUdh+sVLpx/8Hh6wZYYKcKcq302I+NolCuD2vVUdqcmc4xZ4Ms60fS+UsE0rvc6ID2K4+T1C/CCUezoS5n2APU4mDzwXZVvAFA5mOIttOtk4o0rUd4Skbe6ijae0fOdf5gpisq4byu61KvYo2nmWgTQUQ8Qf8umYOdIkGYq9oF+2S81q6I3ULVX4YNhLYYsWORXQs1guw+wwOECF/zlOBwPWlUnaY0uIEDB1YrZsE4VWX+2ghg/BLxDNagFlbjqNPzipsSKfRWOetPt2FIYKsZfS542Xn8cGeiN6CTpIyd24+g6Aeklv9Yg2JWCaN9rhUefClzZNtL0t7WUWG8fhfwmahcZQFBvvl/kBVyAB4I0sMr/kvHwZ66jAfQYz+qqFgftregD9a8sic/SFP6aUg4Xv4QPqFlOzYQWrvmMQP64Lp5M/lI8sLT9pC0aVaAM7qzJ80wqYfswxvwU0aujXN41IbAsQhiSGZyhaNDkmH1kjLB6EWXrivINkmtKKqGz/bQttzgk7JPryz/Tg4guyhT7FTRjTFWld/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vu6jwPHeoWWkLNPxzfxYe5RU6D9iVy46xW1skt8Ip9CXL8tYvqWMg0t1yRSEDjmuSDutXRSQXiudFJTnjXVthm4PtoOk15X8RmnBNe32ZUWIAQTSrPttCKtviXWOo0/8CTQB+VRyL9Pz7kREW4PVDHl0tGEq6FHcWqi+BRBGvKJkbzGf4V4oXFVEpoUupMtY8WVfLLyItaq1OSrCDbG1upuXieYqjOkiJiGs+K7EOhMZrt7S0koDzNiDvcrEZ2Pxh2Nr6Xh5Gas8tSvAS630gM3M9Gf9+SqcemxT6Hvm4rsHSlPXAXypFKtqwA70PvugGJoEg1HC/5h58AoWanb345og4ZHo6czGoQU8ShGNtJkpdi3n8CjGhWjFl1aClzcGGXdITomvwknG9XSdYlv2V3+/91VFik+Hzu7OnrE59FKc3wGqnhGmnJbX1arbaGsX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:13.4967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef07fcb-2117-4bac-a9a5-08deff9eaf1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

gmc v12_1 currently derives the number of mmhub vmhubs
from the aid_mask when populating vmhubs_mask. This
breaks when mmhub is represented by mid and mmhub
inst_mask does not match the aid_mask.

Iterate over adev->mmhub.inst_mask instead so vmhubs_mask
reflects the discovered mmhub instances.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 2c7e3eae7b237..8ad0c1d0f9877 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -845,7 +845,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 1, 0):
 		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
 				NUM_XCC(adev->gfx.xcc_mask));
-		for (i = 0; i < hweight32(adev->aid_mask); i++)
+		for_each_inst(i, adev->mmhub.inst_mask)
 			set_bit(AMDGPU_MMHUB0(i), adev->vmhubs_mask);
 		/*
 		 * To fulfill 5-level page support,
-- 
2.55.0

