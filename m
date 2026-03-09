Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB25F417E3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D331A10E50D;
	Mon,  9 Mar 2026 14:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bjh8Sl8S";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA35E10E50A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWGam3zQMYvlya/UALbBXoL0pDC2WKXsU+I7PqRlvC7K2xou3KROdqEZ4PjSbZpqUS33LMdHdPLk+1lqkTuC75cuUdOfbknTxeHXtmZhFx5npUlEAduROXf3W+7skxxCBsXYMQGsuia/utsNlccq/JvmZHt+FTwqjeGul00AvgLz9B7oxAPIRKRso8Zy3KID90gPcNg+k62lco5K3woCYxye7ZFYghaYVniewx5Ga/LHdtwH/6o41MycdDh6Kq4r28a/UY1KoxJpDgQobZDwVnp2QH3Ejy4aF6nErCLdO8kh0wbi4vGCvywSY+7o1mviyILQb5NiFaQlMM3WXL+5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA2FzedU1j888CDsLN6BbXHQuTN+51gI4t5VdOWRCUk=;
 b=WNxbgmDGoBE8acoorcIVurvzbH4fEylnaW8qByV22rXOFgu676aWuPCA9aMwWr7oJ2AD+NXQo+tO1favH2egr2c31R9TwtCRw3fo4vYOQRab2ODj+GZCjPHUQU4Fdmz7JViI2CrLeRBBvESbYF1qiR+oSTqDcvw7562VoY55VY8LA00yKtxfwZCw0J+4E1rpLVz7YoLSwZ37etEfaaz2RXxsudccY+vPWoR+GABGxBJa3UgAGvhJKKWrv6rvEOIJGmocCaFrKgXsx4CuF8IoB+S/vvkjREPjArN6sn15gNahq/c23vF+nFda6xW6qvbyrMskEOy34gOumL9GF8/qLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA2FzedU1j888CDsLN6BbXHQuTN+51gI4t5VdOWRCUk=;
 b=Bjh8Sl8SDtdyq3cJAHrrHUVNaDWbiw4Y697X801tkB6lRrueOH6gzlonXsUC2UfCuna6vrGAIoMI2b9x9oZwLS6bFUp1rwARiew+ZiMxP0wmZplWOhr7WVqr8/X8PdqN9MwKGVasLiJKDLn8BBOcj/ZbAo52bzvze+MY37ceY1A=
Received: from SN1PR12CA0063.namprd12.prod.outlook.com (2603:10b6:802:20::34)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:26:41 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::a5) by SN1PR12CA0063.outlook.office365.com
 (2603:10b6:802:20::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:26:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:26:37 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:26:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Alexey Kondratiev
 <Alexey.Kondratiev@amd.com>, Philip.Yang <Philip.Yang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: 57-bit enable for watch address on gfx_v12_1
Date: Mon, 9 Mar 2026 10:26:18 -0400
Message-ID: <20260309142621.2843831-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309142621.2843831-1-alexander.deucher@amd.com>
References: <20260309142621.2843831-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 44feff93-5153-4a84-c46e-08de7de7e1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: gF+ZwnFTEuTmcj0adV7kVObl7aB7EG+NGzkgWtcQUX/sCkjd3BKB/DBgngnXl5gZyAXZ7h/z9rNwYetp/86FiiykTtgQnsD7NqH7WlZUAlpRwyq3ld5PJsBpO5eOTYz1Q6Ey5nxtURSGM0/j7b9pFaxSuou1Xqyw0ZukyDNvaFqQo4jnnd+EEGVg23HEetGpkvI7P7Eh9jgGR0oTkd0fRk7RKyB7DGDwaX2uuD2j/hnePK7KbTNNp6P8oCdTYp5KlPGTmSrl5MeUnM0UwH1nj1TGXE7IPUTwb5KCdP7QgsUv5X6l7/mnTeA7yhmq5ma8/fjWpReMIX/xxGYwVfqX5GDgFusYyzcBdgL6q4RkyUiCQ1Q0l7g+QhK+IaH2NckPgNO4a7WxE8+QmVTXFngcqhfjbrI1UHDnCxdDcjAmqVuSdi9nm6QHfMceAuoYt9pF0XErgBjSfz/l7WrXlVG/aHomyjAkRgmzqJXNPfiwGo9A/6sP+499vEW4bDs8suz5p53L9oUHHOOa0X3cRHZt5f63bqBFhxc6f99oXMiF57w2gQ2qOCxWZdBWg2qFY5d1MFiqV+NmmUoPL1eDNIPVnAkVjBDylWzeK8fGaizdMdjLQKqeIdOd9FU33et6bifVIVnVa//boZv05mmgMQu/uoOrLGD2YWUQ4L/oBnjgbZAesHIGb3ccNJgw6fohaD3pGKJ1KZLgL/GoddGGgJABBBdXYrKXEZaUbEdasXXTIiilvc+ig8N0vcLGUZb5k69pEU5+Ecj6wzikwwflSwzgng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q/kO5arajgX6gUuYQg0fXV2te3E/nksE3otdPc9cC6mtyqKDE8ArALtv6FL80kcLy30E+Yvv22+h/og+Zgzzu28sHDd1CBaYLCqcFY0kZsamCMzY9RPxEYqDeDCzHTFJBapc8C55yp3qeROagW4Z5Q3jNU4nke/Q4m4J7UHqHqrns2WnsErg7lAR7MagfJ52TVCNMGD60Er9SCLY2O9YXEbDEFbHtuLrXm78nkTCujwjD/CmP+ZcYEUp38w/PKR3FGr/gTBWkU4cM4TOduGVG+TyAkSEYPm3ytrxrSr75Y/khMxMvQf2Fnn2P9Z7A+WmmzK5uCJDIdj1Dci/JRH7wV5CXf7QMMASUtV3clobykW5Zs8FUCXnj5Xx6LgC5utYNrP+a6VpyfajyQfk1Of5RyhGfNKLufnJ1VLo0iSeuzarSrtPRHd7ZZgbVLxLuszq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:26:41.3821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44feff93-5153-4a84-c46e-08de7de7e1e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
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

From: Alex Sierra <alex.sierra@amd.com>

Add 57-bit support for debugger set watch address API

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Co-authored-by: Alexey Kondratiev <Alexey.Kondratiev@amd.com>
Reviewed-by: Philip.Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
index 965c7e688535a..bcb180f9d3ff8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
@@ -330,7 +330,7 @@ static uint32_t kgd_gfx_v12_1_set_address_watch(struct amdgpu_device *adev,
 
 	watch_address_cntl = 0;
 	watch_address_low = lower_32_bits(watch_address);
-	watch_address_high = upper_32_bits(watch_address) & 0xffff;
+	watch_address_high = upper_32_bits(watch_address) & 0x1ffffff;
 
 	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
 			TCP_WATCH0_CNTL,
-- 
2.53.0

