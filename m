Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B27C433B4
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A789861480
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A789861480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648AA6ECE3;
	Sun, 25 Apr 2021 07:31:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE4F6ECDB
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOBT8N0yl/ryNvg1Afp9flZUQ3HlpjHlYBLcnNcZ5tYqBHon8tPY/oE9X+FPpL6UE9OMrXCuitvtY8m1DsEiDvfJM+B1pISpiv+CHuPdfuxxw9eIJzyw7Ils8O7k+hl4gFDM7N+5/vLeXdZp5tcqMN+bNGkzGllrzyOAFakxmak51R+fOi66MZImx99R/6iX7Zpe6Tu5FbweoBFhglMhdxDfCaGeiJm/ZtJWr9GzrQ6cVQQA5pd4OJPL+5Zp/z+jI3IBvh9zsPtnc0RHYalymuZWrFktzyeG2nv0v4AZNJfu0g5Pn2YtL3iW+OoQGmgY20shDN6ks3L3TenBhHfFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3crTN2GqJca3mD91C79bkyzep/XbfKOf6o90ybx+VY=;
 b=dSMq2191sHOhIQ39lf2ksgjU8UbtchAQt7r8zOfbBf49GYDx+KJCXpIVvHfLOCxro6KwvEZeFrsyku/n8WgBwjySu0dRXkq9Oqz7tfgisueii5PFgnkDX6wJLDhwU7YN8N5ThERwkc57iqRB/UVybIdJCm8ZIKxbcWCKTMcZDYHxkBnIhquNS3FFLNYCNjdFUc35aTN9UKwR/1IBN2JzB+5+IoxWYFJei9Wb6mgv8ADf5Ltk8iIfltAsrKCEk5cZg7U6589bTfYPrVazYzxI4HAM6F0RTUdU+g4Z9ttK+hfPqavTBEoGFt69n60cfoBO1yqH7WXmRqkDHySPsG6pYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3crTN2GqJca3mD91C79bkyzep/XbfKOf6o90ybx+VY=;
 b=NgKeY8UwuZp2Op683lPF7Er3R9dfpWVs9zncD0pLep42lrGP1wuKPRGvsg+oG2n+PZrZLAk8UPNGpQc+hmA5Vbn+SjMf1qVT/JhiG2SFswfNyyDuvAtlOmtYwAZm+mdzRPUhxKa/12Gy5YdreP165Eontj3mqK73suKbm0mrk44=
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by CH2PR12MB3989.namprd12.prod.outlook.com (2603:10b6:610:23::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Sun, 25 Apr
 2021 07:30:59 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::bc) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Sun, 25 Apr 2021 07:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Sun, 25 Apr 2021 07:30:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 02:30:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 02:30:58 -0500
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Sun, 25 Apr 2021 02:30:57 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Change the sdma interrupt print level
Date: Sun, 25 Apr 2021 15:30:48 +0800
Message-ID: <20210425073047.45484-2-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210425073047.45484-1-Feifei.Xu@amd.com>
References: <20210425073047.45484-1-Feifei.Xu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7d8b1ce-e211-4562-645f-08d907bc122a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3989:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3989D6EDC7DEAD70FBC97E52FE439@CH2PR12MB3989.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q12kEuFozxqhGq9XlX+4erEDqlc6d/eFNbFtY5bPLuOncsF+JpnO4MK89k+Pr14ZvVU/XiEQ5ynBgcn8y8Fqsm54c74gNZyEOQ5uRMOOIRnWwDZA49cYyIIuEWisk2SS2fX+UwzEsOekUpIedqWNVIIeS5W9N52mOCWm+qlKNurV8qKfa+zQsfdkHrruxflZjzllxzJl9PO0uuSDuYP8CY8csQ14IXtcJYx1fzvQGLwpuA7Gle50mMfQHESXI3nN/xIex62pTqeXb2YaqIaO6bpxAEaZGVvCpqYmQ0vhyj9CWLFM2cCGwsSJQBNlxjmjrqHaTwP6B5JvoK6N4ibUivliWcCpT7Yzwes/dTN6OHgK6MpjAVR6/vkIDbM8r7QGhsfxJenjaJZ9FOAVbTOrYwWegOlwkvi3s4I3QyBBNup3OUcWNZMr1wRfV/js88q4BJa+3GGSVvMvRgTgdnLmdeO+F24ufzGTL+0VgUohwb9ZG92uRZYsMQrY4iBUwpMQeQoR7bAQHnSgayqCJKNvNN9rxE35m3HBJxUHkm2IMjvHJP5CN264a0sCR0bd51dMfk4Ri81qFp8v87gfmjPma9nibYDjSnZphJ+mtjXctP+G00ZN2/CHV2USMCdM/zQ8hf1r2ThuJSIra4Df+9tFsnvWgXlDhkx2foVXFdnFrBBY+0v8rf8LxJYFR5NU5xOw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(36840700001)(36860700001)(1076003)(336012)(54906003)(2906002)(2616005)(36756003)(47076005)(8676002)(426003)(186003)(4326008)(6666004)(7696005)(82740400003)(5660300002)(70586007)(26005)(83380400001)(82310400003)(356005)(81166007)(316002)(8936002)(86362001)(478600001)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2021 07:30:58.9190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d8b1ce-e211-4562-645f-08d907bc122a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3989
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change the print level into debug.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 2800b1b1f2ff..7870fd09d98d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2220,7 +2220,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
-		dev_err_ratelimited(adev->dev, "sdma instance invalid %d\n", instance);
+		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
 		return -EINVAL;
 	}
 
@@ -2230,7 +2230,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-	dev_info_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
 		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
 		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
@@ -2243,7 +2243,7 @@ static int sdma_v4_0_process_vm_hole_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err_ratelimited(adev->dev, "MC or SEM address in VM hole\n");
+	dev_dbg_ratelimited(adev->dev, "MC or SEM address in VM hole\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2253,7 +2253,7 @@ static int sdma_v4_0_process_doorbell_invalid_irq(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)
 {
 
-	dev_err_ratelimited(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
+	dev_dbg_ratelimited(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2262,7 +2262,7 @@ static int sdma_v4_0_process_pool_timeout_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		"Polling register/memory timeout executing POLL_REG/MEM with finite timer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
@@ -2272,7 +2272,7 @@ static int sdma_v4_0_process_srbm_write_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		"SDMA gets an Register Write SRBM_WRITE command in non-privilege command buffer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
