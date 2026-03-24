Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B62FEC0ED
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 17:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825EB10E612;
	Tue, 24 Mar 2026 17:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QSsXu4wi";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B9110E611
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 17:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFlXRsRUr8thaO9Wrr7ZvAMhXq/fr8SMshMD3ObofytfhghauGD88ggVN6lz22QuWu4DcdHyoZwrlWzApBKfnWhFnPU/PAjLKpMA5C4WUgnEoW1JWvi2SA4VEyDD9guliaQert0SqU829NbZZNJj/69irAeTUVUbhAKeEOfBA+6KcJTZVEQoiB8mqxz1nnDgabWa91/jRuba4oLIgEElcIgqmBRjevgQhFiOdYxqzFyAvLdrYYuM/M6oyxHqHUWo2eCvTENmrS8j3ZQr9yt7JypnVu7/LidRMSRbnn0QZ8kjn5cbXcclUspAXXRMXo+MF8cCtX1OKrOodee5Y7Bl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwJLQofj6q+xRWijEhIv+iUZfM9Q/ubCrlKVEr7U6HI=;
 b=ra3/NlEhVmhDhfJoOTDwHTijLoIJFvqtP3FBXEvTF8S5DtdAUUOrfnFCUDt62ac05wmbj2NtlEwtS4vW298+1f0xd75AB04n4M+AAb3L98i6d/UTWiMDWja4YSJ9ZuFRQflIrFsnIIWBuhSpHbwsU3GWK098yt4/bZd9mouA3XKdXG+snatezvuJOYfbMAra15/UDqCNoL5mmQ3p7TIlA8LlvxrP5+ho9oGwizkR6YH9jJRDMbhe+y0EehRjF7fozpKMF8xPnXbRGRrY6G2yWWTyjInfreV7OMjPMqo0p9/ZphWeVpt1DWutGDDKh8he+49QByETBdsLEgXsWMTx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwJLQofj6q+xRWijEhIv+iUZfM9Q/ubCrlKVEr7U6HI=;
 b=QSsXu4wi75PD8zxSXNgeZcmLqH9nwvtO4zQ/Lv2/c0CIyvnzC8qaHLDT52IO1D6fYUts1vpgpVVJ5HyyuHT4IUu0Yx90MMmVIlUaFi9FZyA6ujfsO06ByobUF6FPS+mD9Bz9o5x7mR/MVvibAW/FwpUW7BGMElBXvU810mTFYlM=
Received: from BY3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:39a::11)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Tue, 24 Mar
 2026 17:57:46 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::f6) by BY3PR03CA0006.outlook.office365.com
 (2603:10b6:a03:39a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:57:45 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:57:41 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH v2 05/10] drm/amdgpu: Update mes 12.1's suspend/resume
Date: Tue, 24 Mar 2026 13:56:47 -0400
Message-ID: <20260324175653.1325754-6-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324175653.1325754-1-Amber.Lin@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|BN7PPF48E601ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: f033fa9c-d052-40f7-57a9-08de89cedaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5TYoxfIu53Qotcvp185xgMLvqeuM9QmvRBHbdtlLJ/V8oK5hi4xmPMGcRXk5KmtBSUXB1PJc/Nz4JZYLoI8Wu31rY37X+8t53ITIbimAaLl1LDbrrfU3mXSMA4tNTFcEdifxjA37/m0g9WIUvJ21YTITi0rmSnJ4VjEkQQgIuK4vnu6+RFAuGG55u+s84FFZeYiA7oAdVt5yRmiVqrzqbtF1LqMfBtmYIcc8r2uSurOd8tAXYP/WwfUHpKLS2kDPvNxptP4ReHYGbr5rDFX9KJUEbJ7jm8D1VY+341AKiT+TyFL1A0mfdKbVgj5zleaKemDaMUsOci+0X1SZ4HAte3BXGyIjIjiqkxz42MKzv0DdVjhaDrMOfx/vyYnAaTdK/tN8Z13/BN9xD4PjbQyxlxyAIUkRJ+M/FgA3ytYiAQyAkJwMdlAIs6A6KLV23iLVFNcsydSz5ftvxF0UcjwhkFOVS2xHs4oiKafay7TBx5Od7UuWriCM5vQdhuoNCqFVec2d5HMushXSPh0BzywkYZAQxOqYQO0Ma1I7AwaCQBIovWG764ZYsap+d7xW52jAnJerYER1zAPzTBFigNL5LlXt8tJ8uqUe53KtptPfEbz/9rTfbMueqC7v006ag3a50i/4ZO7Oi4ozzYJ8Et7luqZDVtgSm6/RGYy3LBYQEqoPQ0fgqpETY9CCFW5krKCYkQ73i5XrgkAJQsLJIVfnLlVlrXZxoPXeiBkytHQ07AY1xYtun36jqhX/ACneHfqquvvE7VskgvVJQo3B4MzYPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: us6LZHtKJ+o67dN7rDRI0pFpjk8Nv+V1BjKIQxWDpz2Qo87IzxO+fomQIwNjCMM6he2ZgQhlIsw20eA37xWWrKWDsmqrjybYqlusRqRTPAAp8bFEPP75n/Bv+MnVJ2vueKROrHbQDjE2ouZle055HzqYFUOPtZp564QeGNKCq4JvjF4ZuKD2w5vfih1Qe04rXjvII9H7Cq4ThpY7ZwoBYSpGhumv1rjjwRSMqLyNaPqS1kM92jhW6T5XWP+fmRtgSeoeNSDL/C7fu0RKN6yvN8RA1HacX5mnR4OiTIzbXROJAEPsLWACOsZ1Es6xFHmmugwoxb5dAPa7YdoUbVBuFxP4kHT8qcK8+HdkUHYVJBBear3S/0zf3fJBLj5jAPIj7owddX190MuHXjUTo2kQbXuImjYIfFAp0z+59Wd4urKtMhx0hWSHFJfgbMEf2Iip
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:57:45.7046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f033fa9c-d052-40f7-57a9-08de89cedaaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5
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

Update mes_v12_1_suspend and mes_v12_1_resume to line up with mes_v12_0.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 70d80c2aed52..4b279259b9d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1888,24 +1888,12 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
 
 static int mes_v12_1_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = amdgpu_mes_suspend(ip_block->adev);
-	if (r)
-		return r;
-
 	return mes_v12_1_hw_fini(ip_block);
 }
 
 static int mes_v12_1_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = mes_v12_1_hw_init(ip_block);
-	if (r)
-		return r;
-
-	return amdgpu_mes_resume(ip_block->adev);
+	return mes_v12_1_hw_init(ip_block);
 }
 
 static int mes_v12_1_early_init(struct amdgpu_ip_block *ip_block)
-- 
2.43.0

