Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1D6C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 21:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C4A10E588;
	Mon,  4 Apr 2022 21:43:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D1F10E588
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 21:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0Z9fCb59pkYZSonpxo4pHUSUsKw+ZrtloWAaq+ol7fbHgXLvc9dilfcGMgHrP+gSz5uJwEyiT2fLTGpmSLH/MMbpxyqhyCse0RmLUD4TCFt05O5oZCVqoh2UENCPbtGJ75Y8sLnrV0UKtXWTu0WV7IBDhLKu+N3b5reVy/lesKHsO5Vjzbv5C++XXeOmYN294Xx6KkohvFrNTwqWM+BWbc1LuavaUDUKk7seLomsHDZI3rKBBAYus2RpcSeariFEa2gOte36tK9SqYMP2QntzeY8b/NE9heCitGGTcqXQ68/ibM6ZZYSRuOPKw6mho4Sh7vnK65gH3ma2w7mvn4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hx7UKdbFxEn/8A9asYkAkmwKSm3yIFNHud+R5G/8hT8=;
 b=HCqmltUSSWxH5qZJXurF9gWtAqWO607NAOJGUhuxg4ozjU7EFfhROJvpQfRo4WnwtBgjXJdEw7OFsznWTRr6yleUmV5jxloCKBcrqpyQi+nVZOnZVWnI5sKDhkDmRuG5yySUIUsQIvwYKfKVCrF+pprlBkrFLJZIxzepjzRGbedYQuMqo2cU537+BfFU9iF/uNesDlGzPY+2omUq8RzLTsK1w8vrxcOm97/JGdEyLyPS3QcZf16xrSVH56svISFpEWs5plbFQw5uX6SkP5sSokcYKiRIhtr6cxB20xPmISLw6rYLObus4RUClevvMmQ8l9L11/W2uLD4tNmCQLRsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hx7UKdbFxEn/8A9asYkAkmwKSm3yIFNHud+R5G/8hT8=;
 b=SrUK0vk8qor7Lvcq/4mA0KKYUr1DTicSF0Bl4qno9INHmIc2Nu94ayLarnBOaVRhB5oiR32lgPNzVFswj2sRBtTyC6OgFcjm2KK0rddkcfF8FEQcDzfr7L95uVPlXuS44NYKf8eVTT20gnr+5FIYdnWUU1eLhPomVs+g6/dtkLI=
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 21:43:42 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::48) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 21:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 21:43:41 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 16:43:41 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Add missing NULL check in svm_range_map_to_gpu
Date: Mon, 4 Apr 2022 17:42:55 -0400
Message-ID: <20220404214255.11902-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f03ff005-fcd4-41fc-2313-08da16842f9c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4206:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4206E51E146954F5C269D59FE6E59@MN2PR12MB4206.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQ11rvMKCYPzTbKPlPiBcS8JaXyKWa+C3PvwMw8INYMlU9deaxZuCPeXvZ8cPCFImVkoa+flkDTv9HOQ7K6mYWFy3L+WtEzhTGzMkX0jX+as/BWhaxByWVrf/gfxjmBu2dphe4VqtgkDGJcrLRKanCnWWi6r2Ioe61f0yuyObneq/9NNHXzvKbv9RPfk9iPzwLzIZcyGxUpIOzGzbFg2jwedXDVUJCsb8jWU0ghTB1Je4j18RyN+mZHUYs2fqF7w2BTn6gCaI2zLj8/PHyPlJ4k8WUIb32dawnDxHLkp0LQg7Ytdi0ctkgYeqLEnrHe9YsXDNaicb+6ZYbIC2pU2/hn8yISoN1CsoyRKdLwtVEwK46Qbm6JDtAeF6PclrAvu5YGCdoTiG3GZbNX/nkHIKNAR2HcIU3eGflX8Mypjq0LpHjcPO9OAPE8vCjFOQ1UyvG/gWe2YXEFgA1QPa7uWyx2s1Y1fx8Nuk15Q7cI8A9LqHZ6E3bZCMTgrEnKeeJKa4Nmb2gtQxxGxlAKDyb2YkPDWXKzKwbfFtnfSe1VnwkHukiaXJqfhVjxn1iZW1hZbSgwQbUpPeBchubq4+eR5aBUWbGqCSvDr290nIHZgWW+jk+kZVSmFtgm1ezCheA3Ti8Usf0AsBIxjs7CQJ6EUPD9UYT9t3Ap5vAmZPRc0937QKI21vd7f5NWh24l1M3310uOAuEwAmtdmt32wqSH/ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(4744005)(5660300002)(356005)(36860700001)(508600001)(426003)(1076003)(336012)(8936002)(40460700003)(2616005)(26005)(186003)(83380400001)(7696005)(16526019)(54906003)(47076005)(86362001)(2906002)(6666004)(8676002)(316002)(4326008)(6916009)(70586007)(36756003)(70206006)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 21:43:41.5821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f03ff005-fcd4-41fc-2313-08da16842f9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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
Cc: Philip Yang <Philip.Yang@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

bo_adev is NULL for system memory mapping to GPU.

Fixes: 05fe8eeca92 (drm/amdgpu: fix TLB flushing during eviction)
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 907b02045824..d3fb2d0b5a25 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1281,7 +1281,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 					   last_start, prange->start + i,
 					   pte_flags,
 					   last_start - prange->start,
-					   bo_adev->vm_manager.vram_base_offset,
+					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
 					   NULL, dma_addr, &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
-- 
2.35.1

