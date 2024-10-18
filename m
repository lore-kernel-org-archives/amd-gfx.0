Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960DAD2FFE0
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 09:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE2B10E074;
	Fri, 18 Oct 2024 09:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UCmebndS";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4112A10E074
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 09:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSf3o/rw5c0k2lH5c88hG9KET6Gq26CWql9ThTF2JSES927CQoTapZLZwP6qZ63b6FvjkXWeurvtQVJjovfWXyZ77LRmEjOSI4OXQfZ21HklQp8u/63/9S9KQ+chkubEYIGWtuOfkNJ+uuuugucWLgidcX9oFPKuDDMBLus5FFgiImh1s/SeDYI0NwESlPqBI1ODMtgsrxhESXIP/IXBR15n9bFX++TK7sbdj6mawSosKq+PH4Xp4O1GqK2SYRxjFkMqz+LqSc4YT5B23iIZ2E9gGklnY8o/1a5LY6XQUx3AFTzorjlNKWWsieLyDsUuxdchJKQ9MeTkGTad9AtgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pswX9cs/O7V7YDYZKSasfKYk4FMbFOgHYDe4TTpHYew=;
 b=hU37AiVta1VgNAq2NcHF1qfX0Q8ly5rB/rQc3/YY1k/HYvR9cFARlrukPP6nAxPN9sS+LDkOVikcIOWpQVMobWL5BQw0xVHI4T7RkxuSzIddUYN48qY9f5mUvjF9PlBpqibMAO7o07o1YCyXuoRRGrcOw6AuCOevyUQz1r7DCQC17qa61873Q9EZrg+vva+r2TaUb1pfbBLLTckR6Ipf0LBwLvOscGea/KFCQ4jUPmxti6Ac6yUgto9xJvP22wVhtOhHKEkqpoM1WTV6hC4ZzNi+f9k/sDjl/irKTRFBv+yYWgNLdKZpwgq7VkSqxpSWO6aJPnkJFbSA0XrmV9CGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pswX9cs/O7V7YDYZKSasfKYk4FMbFOgHYDe4TTpHYew=;
 b=UCmebndSysL7JR7fIq7Iof/h+aE86GV0zns7BXT7QTq2lQ+RgTaeCe2AgrY7n6ut/LDYcGfN6v7mlt6vTJYCYMtAsV3V0gbbbuh3S8cd0hMvhMVYLzWEn6p3VWxIFT3ct3Qe+feKU3+8V8FuJIhFhvxpzpNM7ZUIS0DLeft5zhs=
Received: from SJ0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:a03:2ef::24)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 18 Oct
 2024 09:46:37 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::90) by SJ0PR03CA0199.outlook.office365.com
 (2603:10b6:a03:2ef::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 09:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 09:46:36 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 04:46:34 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr
Date: Fri, 18 Oct 2024 17:46:02 +0800
Message-ID: <20241018094602.30492-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d9fc81-76fa-4fcc-7cd3-08dcef59c1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VWxXqHRcjIIaVL2WJ+BpUXYcowFyGJymPrz48OAQSmdbwaogFhIYBGABGxTl?=
 =?us-ascii?Q?uLxi/6Ob0WpBcZFM6aF36WTy7VYVnR3lE6QS1JHQYUJWMdcsdo/yS+WUFDLv?=
 =?us-ascii?Q?o14KsGYJzkDvMbWELMZ3f9Du2Z/95xpVz19MxNsATxbQg6X6VOrg8EY63MS+?=
 =?us-ascii?Q?d6sNZzhsovc4H6KwvTCbB1zkEEvRaEWSi0O2Dg3kdqjci4vtbLL5ELy54BFV?=
 =?us-ascii?Q?FMqq73bnrtPHZpUkecnM5ggRVlPpMFpzgv+6ZBbIqXTHDVdG312v8AgtVoPe?=
 =?us-ascii?Q?DuqAPnrm+6X/3teYN1xo8Fu1G72bWkQ/DME/pxTu45dgxhgjPZwnfOHLQJmM?=
 =?us-ascii?Q?DF8Sl4gnOujT96rZgcsVIcST7+I40gINsV5hwxzcdED2dDxxSNrwXskwXdIQ?=
 =?us-ascii?Q?Y6sNgQF1WnimITDVi7mKbdDNyRLwe1QY+7+g+ATys3808Jo997X0ebZh80RR?=
 =?us-ascii?Q?AbAuZrPvPGG7089wORslnu1oYo4PvsfTLNeaJnLRaEx7aIC4Bqk0y3HUZ8GM?=
 =?us-ascii?Q?ujhnr6iFaCP/TVGUCdR5XXnUaIOhDgKfbcLidpKPsq279knl8X232pXcFsJ6?=
 =?us-ascii?Q?KyCVehNKNT4GaQp2LOdfJYNPyNEocJNadENPodRcLBaXtnLoEpbbHBRzmwTa?=
 =?us-ascii?Q?+qiAinBh0vJyAlkJxZyjS/Rfy0+WJM1wVDwxvKomCwtJL1UCv5sGh3GEir5a?=
 =?us-ascii?Q?vkgYcM3dDqAJgYXbuQ4TzxJUlEsE0s+y/AjX844NBJkS0aHsfEuIC9JdcUPJ?=
 =?us-ascii?Q?6U2p/JXpwjTJ/4za3yrMy8pLzZZGs89J7HHAOSy2BpHferWQrA+jQPp8bb+r?=
 =?us-ascii?Q?Ydn/XvhWOcZiLnxwn0PNQg9fEzj4ff1ncHidxCAUE7CLD2BRWBwj1pe84Qcj?=
 =?us-ascii?Q?0igo0msWYQ5JDaCE/k4XoREvipsaTnFeVvNZtqta8+F5Bh0paHW0U92/U0NX?=
 =?us-ascii?Q?0zTwDHeEIJC+UK4zH6yKPZm4yBS9QAL7CVDU7fIDAyLu/vzIgtIFW4apvE/m?=
 =?us-ascii?Q?8g7BkpfuFnRi4eRnan1qX9rioejZum9vsiUIPGvrlSN5sj8wMgD5G74ph7pS?=
 =?us-ascii?Q?R6+5YW1XcLrsJ15NAZB6P8uKok9yzQEDm0jkDMS/+NM7hBGIm0tVg7qYnceT?=
 =?us-ascii?Q?47hg/M3cOWu8zH2FigPnpQqpq8MavK4n7JCXWnOREMuD1YvFJwi+I6ijkkYA?=
 =?us-ascii?Q?1XY/09UOginCBB9CQjp+1cpcqGh80mS0Bp5GJ2q549MLzs+L9hp5fzDhw+6G?=
 =?us-ascii?Q?aFofDGgAfq0Pi0e1oFq2+MjiIAjPpQhYAblopJurTACTwVFisM6oc5gjeXBD?=
 =?us-ascii?Q?bvYVqnYedrI4Jd+NfXUJgumEgSXSrcJYftgyQm3QzWDs3lJM9ImXOcegTFXS?=
 =?us-ascii?Q?UWuf8iJ6ci+Glx0vwpCAIyA4FGmAAhfhWuviXQfHOgh7DN94qA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:46:36.2047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d9fc81-76fa-4fcc-7cd3-08dcef59c1e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
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

Free sg table when dma_map_sgtable() failed to avoid memory leak.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 74adb983ab03..0637414fc70e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -812,7 +812,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 	/* Map SG to device */
 	r = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
 	if (r)
-		goto release_sg;
+		goto release_sg_table;
 
 	/* convert SG to linear array of pages and dma addresses */
 	drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_address,
@@ -820,6 +820,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 
 	return 0;
 
+release_sg_table:
+	sg_free_table(ttm->sg);
 release_sg:
 	kfree(ttm->sg);
 	ttm->sg = NULL;
-- 
2.25.1

