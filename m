Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2508EC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 10:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547EEA8D43;
	Thu, 11 Aug 2022 10:01:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FCFD8B066
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 10:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrdkO8qv+TWr7nksmkCK3dECvjHI2RvXj6MnIJEzFW2vj8wL3zPwL8SpCr9aXnKe7GVPppqstLNBB5vzzavVhlCFXWOoIdCUoNAea2SgLZKjwdH6RZ8ExZ1mhwkO/jNrkAvtkMHuzu+oa7Fu6ZT3whOTQH69nRBp7FswvGJioc/HhClQ0v7/ShqJOKtzqJgHnWxXpo/qCQJE3Qf0buxQev2fynIbLQ4CT2aJWjRr+jZgXyJfF6iSY/Hfkb2UtwrF+7Z9QNJWF6r+yEe3brAYX8A680MrGGuWL6VKC3gw5wYnrSjLP6sNTn+A+NBRb1DEBjsI1E/mcm+HgbAUzEWZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb3kCUuo1zyB/CSFUhA9NbiYaMq5UbsfAnFM/UWgwDo=;
 b=eP3pYe9qXHkuLt6IDHePcezk6YSSWcrdhWRwd7ahcBhVggQsxjL9ph4j2UjnOZ9pUSGNdh5gVG4345k2IQMfgTsW8onv/BdyoL6+Jg3v7j/QySTcS3b3eeH2dG8QZp90omQKyzSsYxBCThGbegTE1LxHTuNfdiXC0pVqtv/x1ItH+KwSB/MAOWxVvaISWqVEJH8MGjHP6xieKYWdwPI5oig6uLlWFCMH8OGGObYfvakCBP77Y0ywS6E8GrDmsveaL83331Eik6NwbcFk6DDG8UAFOVytM9KqRLr3BOMJPuzIpRC3cki8lv2y+HndHWvXxlUMBeftKz6edlCRoZMt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb3kCUuo1zyB/CSFUhA9NbiYaMq5UbsfAnFM/UWgwDo=;
 b=tvake3ajYd+z/mfYXLQNk/WLPKOWEOAC4ZgUnQfuSkuuFY/B81vOrasct6MGQfd3YdPo0U8PpOihhd94jhxJpt8HzOP9W6WDlDAURc32WWBvC0s9oONmhAMnra9CNq3dI9c1lVtfHau8FLqxqKyoxbLIUAcQJCuJ4mdNfAAK+f8=
Received: from BN0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:e6::24)
 by BN8PR12MB3458.namprd12.prod.outlook.com (2603:10b6:408:44::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 10:00:51 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::93) by BN0PR03CA0019.outlook.office365.com
 (2603:10b6:408:e6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 10:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 10:00:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 05:00:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 05:00:50 -0500
Received: from sriov-SERVER4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 11 Aug 2022 05:00:49 -0500
From: Dusica Milinkovic <Dusica.Milinkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [Patch V3] drm/amdgpu: Increase tlb flush timeout for sriov
Date: Thu, 11 Aug 2022 12:00:39 +0200
Message-ID: <20220811100039.122346-1-Dusica.Milinkovic@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b3da61c-5e18-41aa-422f-08da7b805f65
X-MS-TrafficTypeDiagnostic: BN8PR12MB3458:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFYO9jRxjAswNjeswEvOlXowWYKN4INDkkvUjkykxc6TSHz5luIiAo1rRCMA+xMUWRiezONGTdsSJS+3bPilA1KrovK5yLZjR5gloeO9MHqJjXn+oQ+SCyA0Kr4ZkouBPSCViXUqW2Ehq+Hw3ipqHXtlDevJUVSRUUjtPsErU5Lv4cVPF8A3VsMOYrRCJNVIdDRiWcvLi8wfrFvofvqjrCsFGgfhv8Z1hjPlfahgrCE3h+cueHR/YDkMwYT4yjrRxBYYKQOvtSzmkt7x9U/VjYwRGWIzG7FA9xhh1iYWzWnhazVIyCPK+XBMbQ5sBveVin0+/MLzSsCRflEIAahgFZvHIh72PGVpV6rudZssSZFvjeFv801VC+NdHdvcI0sfSVzjeU8C6G+Nf0ELo8XQPFw9uFIBPopDnt+o16s97NW6esPwEuOnHMCL1YIH/4ljqjwDip0jlyoX8Pm3dZC3l6SMUJTml2NKjwbvai041D/RlyoSFF5t9J7OO27SD1x0zpKJjxtihN2IeUIMcpTWVnnV5JBjTLzeVgvT7YIfrk0nIxvoP1KyF5mPsPwJaJuZuCbTldBbzs82MRi+pvbSUaOzhYkfB77HtQgJ8sTiu/RtQbFW9j3gVaNMBlQmJ2mvbe47t3PitCapr0JsQUGVH9Q2WfBhfZ+zIzqSto6z79d2HGbuiPs5Nd3QzMPyYVAHqXIRIKDwyFZxIPV24q/Jzj9k6bW47bzVkSl7Vicba7qqOhFN0A7MUCDTdviS2wiAopJu6j13qG7++5H1RW3H7lrstb3HcO89ZMFjkEIf4Ere/yt6BLB9+51o1+lgBuav55ZHTHV74VtO7KRMBF7Keg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(40470700004)(46966006)(336012)(426003)(186003)(47076005)(1076003)(41300700001)(86362001)(40460700003)(2616005)(6666004)(7696005)(36860700001)(26005)(36756003)(40480700001)(82310400005)(83380400001)(316002)(6916009)(4326008)(70206006)(70586007)(2906002)(5660300002)(478600001)(8936002)(81166007)(356005)(8676002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 10:00:51.2223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3da61c-5e18-41aa-422f-08da7b805f65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3458
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
Cc: Dusica Milinkovic <Dusica.Milinkovic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
During multi-vf executing benchmark (Luxmark) observed kiq error timeout.
It happenes because all of VFs do the tlb invalidation at the same time.
Although each VF has the invalidate register set, from hardware side
the invalidate requests are queue to execute.

[How]
In case of 12 VF increase timeout on 12*100ms

Signed-off-by: Dusica Milinkovic <Dusica.Milinkovic@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5a639c857bd0..79bb6fd83094 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -320,7 +320,7 @@ enum amdgpu_kiq_irq {
 	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
 	AMDGPU_CP_KIQ_IRQ_LAST
 };
-
+#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9ae8cdaa033e..f513e2c2e964 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
+	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT : adev->usec_timeout;
 	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
@@ -437,7 +438,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
-		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+		r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			return -ETIME;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ab89d91975ab..4603653916f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
+	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT : adev->usec_timeout;
 	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
@@ -935,7 +936,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
-		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+		r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			up_read(&adev->reset_domain->sem);
-- 
2.25.1

