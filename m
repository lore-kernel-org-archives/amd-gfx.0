Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04949103E189
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2F310E0E9;
	Wed, 18 Mar 2026 14:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WrQmOi7T";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD2E10E0E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYFL4cTlhB4li5cF1JopcBpWjMoqqjx2J77D0XxTVRtYHXhwB72+jlxqnwtQ0bHBRiViLzdt1OHv8RXeY4dtKclrgzrl/VavYcyp+3QZ3gFkHgCUFdfNFKW/7wY0qTUubqZjVuf4bl0XvwRSgMD1T+V+ekNR8+xDIMngbzTypAovDXvjxEbtxuBD1mufrWZIVqo079mbkr6uXFRWIuX+PIhMVMz7PbgGgiMTw8XOBOaJoNP4wvkWv8wSdmfvIrEmgPScXGz3CREk25F816HIsnFvX+XYaVawBMl7LMtiL1Gi2ertAWFZY2N37NosKHA+bf6/EgolkIQrgKUF4SMpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvIHO53FdwJRg7MrofOwi4VAuwHswvUcZ+gWbVyRkmA=;
 b=cCTvHaylORFYyY2KrNHDlE8SW8aaBixqy4mnolcUkvzSLtnwPaK5qp/7YCdawQ2kvcTWlKEG9vreYJy8BMI4wafUYbvnVcV4UpCTisjTeQjol0HGHfNBaDgkeEkWQesRl1brA3QFD1NTU0hFcfB4pIJFhD49ro3O8Ri8LoVTzQ2u1iJ8BuzH0vmklB9HHKB0POlxzTczpg0rLC7zXvu7vahcreErMyq3r1SGucSgIGkSNBPWIUuLQ08vQQw/81KhEbmu/9++HXtFTTIl98cmjg+jhONwR7a1Eapg/lWZQvbuDTLBoAqGBW3BAAZqEFT0Uc5+T8u4oJkdpqacjGcOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvIHO53FdwJRg7MrofOwi4VAuwHswvUcZ+gWbVyRkmA=;
 b=WrQmOi7TNZJdNnRpq1juWgqBSfATRfVIRPjnPguHAgfALE//HxdlVuPVZOUHKBs7tBHmOTlzdIj6Lq2OxZu7Pl8/Le+yi+eOOIwIO8xYjSjl6XdgMyLiXAbafvdrAgJGMgTuC5coNhkSAivCbTIM7ErcSp7pzj94tQdcGF0C7rM=
Received: from BYAPR07CA0050.namprd07.prod.outlook.com (2603:10b6:a03:60::27)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:11:42 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::55) by BYAPR07CA0050.outlook.office365.com
 (2603:10b6:a03:60::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:11:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:41 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:11:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/9] drm/amdgpu/si_dma: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Wed, 18 Mar 2026 10:11:21 -0400
Message-ID: <20260318141129.583333-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 359c2fe5-c210-40eb-23cb-08de84f847a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: OAVVvNpdvEkWTz1O4neG4epQPSlKKdFFnvCXOiDW9Cpt+MUI5PQa8/aRCM+rWUnznhVI40sVmX+x/vQvnzcWOk1Suz/H2NlpMZakHQ36wj4dzmo/B5cCGMSd93Btmmr9khZXVkCGGoS1nMZkwDcBbTHkgeC0mNQz4ln/Kk8zl4+ECwI7AIVJ8HJpVJo6fGvPE6wX4GQ8tBY9rbIrtDJY/5BL3bFw1x93R2J6h/HQHD8KPzGUxrcyKieySpdK8eUJltgyrEtWwRqs79n+VG/H2acfJO/R+WyjhBWvcbk0JZxyxCbHD7euXlC2p3i62nqpIhbUxJ31zkHDmzEeTMlYL9KtHbGWSu+ZNnzxHIEp6Y9hqfcnfBHJ0C4T/jL+GeBs4uGlwZzgy6WmC285cDbOr1ZhR46Hp2xCqKgf/nb2teRmb3SdqJg4pFVIn12A1tIezwAOa25REg1NV6hduR4pgsEzMMxXvyW1FHzjTQY1Wplixb2Dgn3cMa4/e85AlR8pwfSX0yfEDKXVmwf3WFEjgTT5Bxiqa+u6nQdfL4z6OG9jR4eqvcROro3JCHzskFv3oVwz1C4b4fcvLvZaKHy/O0tfQpiksNgRIOtX7AilIuZ1lJbzreqJ8V+vjhvgQVlsj+z0QVcqyjw8oaTIT2wHPuwQYg8wY3Yi+YndGJcvwliq9NsCLkdYeDBywu/Ce//SSMEN1UHv9UXbwIo/olLiFz/PgeQEdATUDt300UINAGlsL7nUQ/usym7B13tJBmkmR7eBzSUf1hc45EhWmLJmPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JWEdUosRLo55HPuyBYxMz44+h+3VSpYBsuElb+/xR+oPReCRfO/Z/YZCegaQK6karESQlm1pF4iyRZDu/es6QThJ5jWzsbr9Duh5/HrHDxf2PSnTYODq1BfYjUn/zWjnBV74hFy2uZ2yhDdsifc83KN06dBSFs6Y715NKQxNkWfj8VsJt1dhdOt8bEwkGFboOJLo61CeNqiceGxxuk/hIn4SQuEWeHVemrmatGU20VOIA/XSGkgqr6+ch3wu2NYrXOlxJ0nvfzlM/s8lY/jdoZJPfFidAAcJzKgw8wg9uXGsDYN7Vm0/YvCtKyDk21OydHKCrdrLOmYA8/KQ1gHa78g4Sc8NRsP2qnjAWkRsAMxsqwcKWHsGOQG+tc4rat6TJbFtrG8CUr2zXwKZAtOyqnt7CoOXwTtcMD9hWcL03/zY1NlatT1cSBx8oZOcvqce
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:11:42.1050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359c2fe5-c210-40eb-23cb-08de84f847a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 3e58feb2d5e4f..7cf9dfbf11196 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -149,7 +149,7 @@ static int si_dma_start(struct amdgpu_device *adev)
 		ring = &adev->sdma.instance[i].ring;
 
 		WREG32(mmDMA_SEM_INCOMPLETE_TIMER_CNTL + sdma_offsets[i], 0);
-		WREG32(mmDMA_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+		WREG32(mmDMA_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 10);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

