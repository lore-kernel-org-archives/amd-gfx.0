Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50620C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B3D910E34B;
	Wed, 26 Apr 2023 21:22:06 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF57010E329
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RavOZ2N47UDv6923ECAywbhtbH8wu4mFnjRT0kO7PgY6Mj+6IUOCr4R0/uvE+WoOrDFXaCK628bNfAnt4c8rdo1Xn54NoUUr1yDW2+B/i2VFl/yG5BTlw1CXaNRMjJ5DDaCa6GeBEmCXTZQkWkbLtqbYWwc5oCo2XA3BmrtiKViHdeavJbzxnzssAsPcaFOYxVEuSPRgMiYEev/vAXo+jMmvv+h+dr7CNLx0nC0Bl2QfqsaWzD3nh5tvJPxT21plR1zhWiRzgrt/YiiVxSV9CWjUjamYSCrz499GjAtHP4jStQHcC7CHNJugcWntCXD3chd6v6YT1qDriEsMV0mD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZl/DUF8oERbeDATHgY9qb/kr4jPGyRaK6p+rT/bX7U=;
 b=ltR8BcLa8uE01itxUGxn7bQLL8ZlYxEq1kiwYAFHywIPsNtzjS5Mx10h+CH/+X0Fhq2aedfPsUX6Cu8/B1fIcfI7E/yE//dHzFBFM06K5HhzcH5HnnpvO5PknHKIZHLhwN5R3cVkiFEqItTRJ2MHtsVq6UD0HuxrWl54+qCVquSwiZdXr3Or0bgMfix3ntNOU6AahcmKNj5zIcJyU4FHcbgI3bB6F8n8d5zpeiHxqe7keadQ/638+byFPpqXzT79Z/5ABImHQmZ4DNJxgmDdEuFcw/i/l68vBAgIgA9ASBeMsk+5bNnWPO0ZcdRsAlaqGq3jB3iIMN7XgB5MHIVWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZl/DUF8oERbeDATHgY9qb/kr4jPGyRaK6p+rT/bX7U=;
 b=hGREfoBmZMHgk3E7qqrfLjnF5fOEB6De8VMc93H6RdsaW/uz/tLt6lTRYT1vW9Cev7Wtuf52ME9QV+SoiIJB/vn3zwb3LzsmApb08sMhesoHwoUPsfqp/IVPaoevgZOvZt2b9B1rqVVU6XoWDA7SycWVgOu8MmJZCRzYjcumjxU=
Received: from DS7P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::21) by
 MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 21:22:02 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::5b) by DS7P222CA0028.outlook.office365.com
 (2603:10b6:8:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 21:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 21:22:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 16:22:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amdgpu/gfx10: use generic [en/dis]able_kgq() helpers
Date: Wed, 26 Apr 2023 17:21:35 -0400
Message-ID: <20230426212143.7696-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426212143.7696-1-alexander.deucher@amd.com>
References: <20230426212143.7696-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: df8446fa-519a-488b-ae9c-08db469c46c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raA2SC4NpqRkCudP7hPQu2x9AVGXA1xZ1FG4C5DjnnUh1uJx3ixuF1kZSvFzZxQcryKZ0r+R2zXpW/6M3jPP671HDhfFGmFA/4ogMIUr/91U1BaYSl1eIO9R02tUKZgYWeCi8TKZIJ0w6GM9qmhLMoyzCChbXhuV1O8Hr6TFO22zad2c9r3EHg/ETkYqHanWwAa1D5uIH+IwaDWjOZC1nHAR9hg9sElhJPTAPct7neU2/cA9P+ua3AOcETGOq6jhkJW7yZa3JcUfrqDQ3JFQdeKV4BV5rBU89phn0xS+SDV7UNETUFg/bFJrWcyORQCTN8Tv9iwmKEaAPrAC7pchNF83R/NicF8MBBPLwU7cQerPJYGoBudR5NbQyTf1R2U0gXX+8Hdbzg1bnjXpBtqH1aafQKRgrrlnuvJTwLIFTsBzvkLoWB+gq1M2/Xpjfpi294aEml6Qd0R3kGnMJO/UXyNCCdiNv6zFpmazD+vwLdfeKlx5KaaLUHWTVzjMqKLewl9QEZ5VVMBxgVz/YOyUrVzCWffmXhP7Yq2KholZc6LaSa6i3icvVvfl2FAjS3MRAByMtq703gLMjfR+ymuhXzi3ZF340Efj06MoXSnEdeevmoR47iSOOB8QCwmSrAQb5fGOEQDdSrg5a1eKcV6fZfT0omSEp/BBNFVpacJdOOB9U+TzN20W8Fhlw1YNAbdXjsAoi1KVkJNmoYBsEp+CXKJ5wIVlUI7wM+y+eTMowQN0teFV46XrLh8xLIHOdBS3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(2906002)(86362001)(26005)(186003)(47076005)(1076003)(16526019)(83380400001)(36860700001)(478600001)(70586007)(70206006)(6666004)(7696005)(54906003)(40480700001)(40460700003)(426003)(336012)(36756003)(2616005)(81166007)(356005)(82740400003)(8936002)(41300700001)(316002)(6916009)(4326008)(5660300002)(8676002)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:01.8478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8446fa-519a-488b-ae9c-08db469c46c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And remove the duplicate local variants.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 48 ++------------------------
 1 file changed, 2 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 25be4485dcd5..24d7134228b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6462,28 +6462,6 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v10_0_kiq_enable_kgq(struct amdgpu_device *adev)
-{
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
-	int r, i;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
-		return -EINVAL;
-
-	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
-					adev->gfx.num_gfx_rings);
-	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-		return r;
-	}
-
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.gfx_ring[i]);
-
-	return amdgpu_ring_test_helper(kiq_ring);
-}
-
 static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 {
 	int r, i;
@@ -6507,7 +6485,7 @@ static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 			goto done;
 	}
 
-	r = gfx_v10_0_kiq_enable_kgq(adev);
+	r = amdgpu_gfx_enable_kgq(adev, 0);
 	if (r)
 		goto done;
 
@@ -7178,28 +7156,6 @@ static int gfx_v10_0_hw_init(void *handle)
 	return r;
 }
 
-static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
-{
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	int i;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
-					adev->gfx.num_gfx_rings))
-		return -ENOMEM;
-
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
-					   PREEMPT_QUEUES, 0, 0);
-	if (!adev->job_hang)
-		return amdgpu_ring_test_helper(kiq_ring);
-	else
-		return 0;
-}
-
 static int gfx_v10_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -7210,7 +7166,7 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
-			r = gfx_v10_0_kiq_disable_kgq(adev);
+			r = amdgpu_gfx_disable_kgq(adev, 0);
 			if (r)
 				DRM_ERROR("KGQ disable failed\n");
 		}
-- 
2.40.0

