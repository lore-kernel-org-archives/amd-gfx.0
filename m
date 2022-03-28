Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DA6C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E19ED10E439;
	Mon, 28 Mar 2022 13:07:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320CF10E43C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGPvQx28B/poeqORNtCmJZq9IO1GINZE78rWqpojH8XdMQQsxMftnxetJyPu/LUI4Hox71s58QJAtPNnqsSZcN5cGJNdtIHJUpxYxom7cD/ePt0QD5mIeH+N2Hian/iujhyl/WUJD8sixxpCugwp2CiEmDBMN5zlJqqwQm0Q7wCmYtplVJhSPshp7MWIw71bZyvAZOc8dxDqRh9vCNtB1YVcvD+/S4VoUX91ZY5fN2cQy9UsHjzTwuPcPoXTo5a0rqkMPhWPwOOa11MuYBQSIloh711UGNfml3ITuNsRZ+7rosZ8aVJs6aXOXtDt/hyS9gPiH5/mHvkRsFA0kyoRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9mZSh4NR9kXHMh5lNCZAmaq/rVO8AqgYv+5nH1X/HQ=;
 b=koFrm/HYRjuPxSoC3Atkq3FkkRh9HpQsoSKKmki0SIl8P4BxI2B8jZ1E1azPhHcL+WX58+m6B2xLJySZEbQ216t2um7lEWX9EVtCsscRGDqig1wgf8qWxe0zfEImY7yd3+ctiDgl3lqopdBmL3j89N4p64qiCHLSNG3v9w6JcAlp5F2yd3tbppl0zGfjNq6mMHbCCkVytlGzWSdEKZnePRusQtIYu3hZum6Ng0amW540kLaiktdPUwQtIJZGn3I6+VTOdmMBKvMVuU0sWw2I2kTf/693+iZqmxiBsv48fs0WVKedavBPEzrByodlUPWQ+oUv2SfXkHHXK/8TPQrzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9mZSh4NR9kXHMh5lNCZAmaq/rVO8AqgYv+5nH1X/HQ=;
 b=Uo0eR2oZiKmstKvux4IWyC1YlB4RNE3YEdfvWj0bGgL81JoYjLa6qkaXyG1uAmjJeN/saMc64IRYIljycaOtofaTMQobYF15N4PEXLKxDIaQ90F6Uq8BFaM92IwekYQ+UJB7tHQD42zdXqfOjdCW+FoZmGHjnVGm6M2CAE1ePkE=
Received: from BN6PR1101CA0014.namprd11.prod.outlook.com
 (2603:10b6:405:4a::24) by BN6PR12MB1506.namprd12.prod.outlook.com
 (2603:10b6:405:10::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 13:07:20 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::21) by BN6PR1101CA0014.outlook.office365.com
 (2603:10b6:405:4a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 13:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 13:07:20 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 08:07:19 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdgpu: Correct unlocked update fence handling
Date: Mon, 28 Mar 2022 09:06:58 -0400
Message-ID: <20220328130700.29642-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29168c0e-3a01-49ea-db69-08da10bbe45a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1506:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB150614430D0E60D46F566BB9E61D9@BN6PR12MB1506.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jgwbfPZDG47OZZXkVhpnPfOXAOoBFmvnTTlFL7w9cXP9wbM8LfmmmML6iyqrHlPz4HpWFTF9MFmOaxZKmyk0ao0zL1ce29UIiCh+okLfTE7RACGpDbmhqwLSpFcWK8j06VAcT+p3K92KhYmO+hMQJWnxGs4NWvjmoV2FqplVu5ZemLUJL+V2g0/0QNA490FKGYroFIzq2Goco7gUfHLD/ypxEZcDquYOfCVqYVU6Cij+8UWPmjowElDxbohxEc8Ua9JSaA43rhX/V7blcqzYpbNvfC5iRvXpu2yhlvWX5oudXHcIXaNmFJGdD17PVH+5thZ8Tjtix2N0z9IWjS31VIX3tTql4GF73421Os7gP5uN0VjLH//0sMvg70nWqWrf3oX547L7/WhtV1Ki+utY4xERKTTpzs+jnGPp290CXr9EAkm59MT5ssmffMi0ukgmwYd4xQMBF862BXLnN/SgPsaWD9b1ZZ+zG6jZn/90FZBnXxQ1kj7DcpqqB6w3iZv43zdGuvPHg/CjqWYt2vk0vqIdSj9WX6YV9y52u5e+2adBllEXWv1T9r9eaJ6HV2qdHygaRmMDofHS2BqiPnOlpL01d7N0rMHMVuZrYWTRQbwtHk1yF3cKYsEXjRwnstzfVIvBlxElqAqI7mHEPSjB+SRcCRsvVXG/RSFeDIoMVsXdebpiPHocZW8dRxJ590stCsiU0GFgdo7scawp19EpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(508600001)(36860700001)(40460700003)(2616005)(6916009)(16526019)(316002)(7696005)(356005)(47076005)(8936002)(81166007)(86362001)(83380400001)(36756003)(8676002)(54906003)(70206006)(70586007)(5660300002)(2906002)(186003)(4744005)(15650500001)(426003)(336012)(26005)(82310400004)(4326008)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:07:20.0091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29168c0e-3a01-49ea-db69-08da10bbe45a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1506
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fix two issues with unlocked update fence:

1. vm->last_unlocked store the latest fence without taking refcount.
2. amdgpu_vm_bo_update_mapping returns old fence, not the latest fence.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index dbb551762805..69fba68ff88e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -109,7 +109,7 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 	if (p->unlocked) {
 		struct dma_fence *tmp = dma_fence_get(f);
 
-		swap(p->vm->last_unlocked, f);
+		swap(p->vm->last_unlocked, tmp);
 		dma_fence_put(tmp);
 	} else {
 		amdgpu_bo_fence(p->vm->root.bo, f, true);
-- 
2.35.1

