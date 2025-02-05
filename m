Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7B2C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 08:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E59810E744;
	Wed,  5 Feb 2025 08:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="waOwrr7l";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F8210E744
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 08:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVzdO7NXlZdRb6r+ym4+WgorV4ZZ3xc8nQkbeoc3C5QVWS6nhiDqsMv5RBdON3COeWzOQh01YK7XKIgd63Xxz/mplx19SpCR6ayEQ14WGkCFYZzt+SXTMcRaU1zwzJDNGD9ORNqHjTu8HkKi5mLR0w1uT/eFpTNre6AMYdfeVY0FKG8P+BW6dG0Jfg+RZ/71jLmOxJhsfUdcnVdWXYRz7Znn1GiiMxV3jn03engXkEfqqCCd2didj+haBO2wSt2iXAwiQJxwBX7oycBeGF6Yv/L7x1fXhJ88t84zMZoWEIvwxdPxtl/omT979V+vLNNxu0KwKOPzMviwI5K8gvK+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm5BMGIDyrAxS12dUyAN9eTnpVcG8g4x12f8XeDJxMI=;
 b=mPdKxfQJZqfnWhVH/7ZHb1oCFgHIwyAFfV8pZlagQfaQ1gvB88flkGrnVa1q3iULsy7NcmRrHTsFW+DXTHyrq0cow3f1Ld27kh07spDU7q0yPu/pQtP6O1UyMaJty9SkZ4H+L6IY4jyNUQ+mvm6EY4ACavHl3TR5mIoYlxXW4AzDQmprLnctLkawYSWbYsz/BuyGdrKCXWkT4qI21oskwiTZRwaoO/xQtaMUeiHLzovNxARzx9CORQlkdFBJvGZJtEnMvgUx+/NlX4kCRA37M8QfdNtqKDY+v07Rwx2xqyOV13zhr0OesiJAsU3gDqkzHjznMNAfpNgbLoEFVxgUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm5BMGIDyrAxS12dUyAN9eTnpVcG8g4x12f8XeDJxMI=;
 b=waOwrr7lBCJ8f0zsW5QcOgqnE4pzA9nkgrPDzKLWX4NRarC9kRBTJFWaq+sWT6zR7+MJUOscJFScx5dwp8vd1eCjltYnsqpNgzbMT2LSw2tiIFzOgiOAzlPGUQ+aS4Fm6Y4+/ipXeDq9RBiEoMpLXD+0pNFAVM8aKsVNr9fsdNI=
Received: from CH0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:610:cc::20)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 5 Feb
 2025 08:08:19 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::38) by CH0PR03CA0075.outlook.office365.com
 (2603:10b6:610:cc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 08:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:08:18 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Feb 2025 02:08:16 -0600
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: properly free gang_ctx_bo when failed to init user
 queue
Date: Wed, 5 Feb 2025 16:08:02 +0800
Message-ID: <20250205080802.1162861-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f51029-37f4-475f-74fd-08dd45bc401c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IR/RTbRmwCyCZ504GxrpXMiPYgnCbT2dYLTFpFj95ZPB0TvXbV1CH5VRr2rp?=
 =?us-ascii?Q?+HZxvf3Gdd0LZrlWsDh//kOAAJGV/gUxcG5lvgjsJnZlkHwipqyEDt44JC38?=
 =?us-ascii?Q?ee4LgVNSTihlnDorpihxxKpgx7EywOq2/nhK2LrRBIt4jujLHT/AT72FWlWB?=
 =?us-ascii?Q?F/hLHsEkqP96s9FNiN2at8VTwyInckHbJGFS6lYWRmxU7bXfToSEceo+s7gA?=
 =?us-ascii?Q?BvnNNS1JQIpsyBMpQyUODE2YmFB9x+Xe42eldO30PovZGQHXK5RiVLEajQ0r?=
 =?us-ascii?Q?UpYWw0FSpJeZ1OUabvWapIKG1hKmxwqLi1myasLv2ujGytBOzP4k58H+uExi?=
 =?us-ascii?Q?evZNMyfoCW63rfFcoOMj7DyepfnXniykz1FOQu0erbWKBBprf++jeLlIr2Vi?=
 =?us-ascii?Q?AFwdjPjd7h0AfgmMmuZpQi/fun2BAMzYgsn2iq5/s6Lv8SckUkYw3MbNgLws?=
 =?us-ascii?Q?NmYTXvcEDI0KXbpdCnoKY28CJcXRLfuUfQkulFE6udys5dO41clLEXHmpB9d?=
 =?us-ascii?Q?Qf6P9R11aUeuHuDCBCt9MSTYBGM9pQ8Aqg2F8iNfwM1yV2ApMHjrc5qgNBIb?=
 =?us-ascii?Q?HiJI1LI9NgiY8JDKhYEpqb8580+y+FwKKfOTtQBAFlnfdpfo4YDuTk49gFQc?=
 =?us-ascii?Q?YFxD3gtvS4VWIuUzINtDv3iMiRflIXxZ/cS0MCTMGiTWkEq6a4famtBZqZpT?=
 =?us-ascii?Q?e/4En90EE5EHQJEr6/52Ct5y+9+LKfLMrh+JAD7XCqPdRdt6zqOVSv4gdVIA?=
 =?us-ascii?Q?dOoQ2LUMlcZjSioits2zm97REwZub0S2V/UWAhEpopLU6vL3JG8WyJpjmfYK?=
 =?us-ascii?Q?K+MsRI6R5o7qu5LZRmG2A5CQsZhEa4bhwZoOAF0BSmJ9dNik1PB3cD2pGDyE?=
 =?us-ascii?Q?n+OO3gTvkki5z2SOtWRkbDD6NqxV2aSNNTyvX4JMw0WFnm6AbzX5f3hELpLf?=
 =?us-ascii?Q?NXCP24hJDmwPXBPu+F8oon+CjMBU+yQY0Sd3zms1GPWkxwuBxy7gVvCIoBDe?=
 =?us-ascii?Q?MEHMoXydiyHoaUOWmscKnvbMObtyxDI/6madhZM/qM7jSkPrl7QAaIRdkibP?=
 =?us-ascii?Q?Usvo4sTgnYw9cWHNzy4rruTq04ZAKBNIgDgvU9yzTN4QIQkaKzp+SOZNZVxX?=
 =?us-ascii?Q?9K/P9B/fEsUSToYDpgBCNN88IqMY87kXdJwD6vCDzumJlyKMMGGbRDdZN+Ge?=
 =?us-ascii?Q?G8h0x15kcUIOJXb7qPZfnO943SoyGSwJjbThGX27BBeUD8roRr0Gowi7LVaL?=
 =?us-ascii?Q?TI59rX+CdlScUjMo9SI7679TCkxDZJWjIC4ixoTFkEUiufnBB8li8BYx5Zqg?=
 =?us-ascii?Q?pKhs3eY+O1aSCq5mwUBdEM13f74KZN8dsqDe+TFV1VbyZup+aKL0/eW9BTRe?=
 =?us-ascii?Q?vdhHC9a5EaW+f4VsgKyIKetAk8cbm+ItbnUNTt2dMiHJ7eJXtTiziWpRnvO4?=
 =?us-ascii?Q?e+69Nf4Uo4iYpysqLP59buIu6ZAzC4FBf8LIqv7miG+k4ebIIz22EThxZX+S?=
 =?us-ascii?Q?Arr/6EnTeUJs0EA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:08:18.7472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f51029-37f4-475f-74fd-08dd45bc401c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275
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

The destructor of a gtt bo is declared as
void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
Which takes void** as the second parameter.

GCC allows passing void* to the function because void* can be implicitly
casted to any other types, so it can pass compiling.

However, passing this void* parameter into the function's
execution process(which expects void** and dereferencing void**)
will result in errors.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Fixes: fb91065851cd ("drm/amdkfd: Refactor queue wptr_bo GART mapping")
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 750f967fecf5..0ce8d49ca16e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -295,7 +295,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	return 0;
 
 free_gang_ctx_bo:
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, (*q)->gang_ctx_bo);
+	amdgpu_amdkfd_free_gtt_mem(dev->adev, &(*q)->gang_ctx_bo);
 cleanup:
 	uninit_queue(*q);
 	*q = NULL;
-- 
2.43.5

