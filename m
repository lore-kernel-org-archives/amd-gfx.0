Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5C3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB20610E6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BB20610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD9B6E874;
	Wed, 13 Oct 2021 15:09:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E34F6E874
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 15:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT41Xe3aKWB4YJtr4uiCV4c7jTNoKcszD3BykkAkJSxidU2LugyHJLWWdOoRLmNOX538o19cqiUllfj8/Z1arAVPCJpdDGfXhnTgT6AcWqu1crxBm615UeXRXjsgeoAsUfhsqNzuHy1r9NRao0DeRcQNKT389zZ3A04A7HRuw1g9pAUyO7EvJ4iL4GARxrZrwzwtMc+etJiD1HscOMS7Auys6IQPxfUjf0qFIqnCbZ8xWKOf8h8jhhCU0+/cfEwa598ivsPuVWwzW54yVoqmTXtYOocPZvMjSRpTcUJ6ModoEgHE5BihFSX5mb5rEjt6dOpFAhBrV8yiW7epkoBHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4o/d7Q/rhntYpUGwYtezGDo8ruwCDQLFPhvidRBHskg=;
 b=U8gnoNdVVvOMUKFj7kKJorbr2SoxD6XwXnl+n1tasObQ2zgar3X/KVahrGo/gcO5u4fvT2Mv0Irl50Kebeyp+ruLMgJKBUiMfZLiJhMDpqNzU9fiC83D2W7U3rkUSz6ycQwlPDzzEW6Yghjr1LvG8nL6E2S9IL04TXvFtM6vN4QG12v2TYjGiaG/S25f4aartet0uoswAKRB2uAcMdC9ZCxresB1NxBfFtSVuXUM5cDY43vSnxP8Yxkvhf5GrsqFt6dukORR5GzKC4lz/ZmErK4W5NTykHqDLGU+18Sg1qC7mdwnyVkTPVI7XCBopeE2vl0ovayPWVWtycQgvUqVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4o/d7Q/rhntYpUGwYtezGDo8ruwCDQLFPhvidRBHskg=;
 b=Y6AoKwNz+zq1JvwDcesXz6/ZlMRTU0jbU1ayCZI0CJvNONCkyWVerv9/PQC9jUvovyRZLpWjPLLP5jIUaZHwZdrQ5kbl3rZQZboGej4dpSZ2JFRRjJoQ76ROr9IL/fs/33US8bfxzhJw2kPPiXuW7tdlBFgwsJNXwvrXQ0Ww7Eo=
Received: from MW4PR03CA0282.namprd03.prod.outlook.com (2603:10b6:303:b5::17)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Wed, 13 Oct
 2021 15:09:16 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f6) by MW4PR03CA0282.outlook.office365.com
 (2603:10b6:303:b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Wed, 13 Oct 2021 15:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:09:15 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 10:09:13 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>, Nirmoy Das
 <nirmoy.das@amd.com>, zhang <botton_zhang@163.com>
Subject: [PATCH 1/1] drm/amdgpu: fix BO leak after successful move test
Date: Wed, 13 Oct 2021 17:09:02 +0200
Message-ID: <20211013150902.6646-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012121018.81693-1-nirmoy.das@amd.com>
References: <20211012121018.81693-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc1ee189-b4fe-4217-80c8-08d98e5b6c27
X-MS-TrafficTypeDiagnostic: CH0PR12MB5059:
X-Microsoft-Antispam-PRVS: <CH0PR12MB50597971F00084A47FF2AD918BB79@CH0PR12MB5059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHAjcR/J4BiZQK1eUdcsxm1RQsdO24mv+i6Hq+y9Cv/CdJFzUjKFCUZs8WkzZbzjptSILCOBgTP/fwRVWnt51p9eQH6xn0GONJxdXsushv8TvcrG6czvBIZ5xxC1vLJceFHRxAOmdHGrd2QnD5ZunNCR2xcjj22cyKKNlET0PwTB+1E0nprxP7h1YLg2QincTs+aQGW98RT7rosYc/ezuShcLXM/fnkMkC3utze/JL+JJM+yPO2Eb1+F+qyWBlmbpfE4o2ybnWI8jH+a7OdSflsy8T/gbT7RipQMdnF5JkI7r5z8cm5lbcGswPcYK3wyBkjE2Q6+3p/RmFBj1ShpxjciqKqTIOlqxe3uI4NzE9eclMr++qc474l81yu/2o/O2xjYvY0lIBuuzzzFP+JF/fmd2X+8ZkvCD72k8Vs3kPmeSFl9xyHJ5hgmgQl7ZWYDgnevHJiLQPqtqM/zVSXQYU0zpZg4OlkjpduR1ryzassg0eq5PJVKl7KqU5LCj/dCGbueG9n4qVrX292l0/eczWpljboreLMvFJKeCUqAzFm5QlUGiHmkJKcKmsLktBkARWY7SD5EqKUILP3N9IUDJ1azfjlTupFOADgqUmHT77vWpVEvbNAoz/jl+grTox/paevUd6OdbyfO/wfs73sDgZPuoyjYSj8rMLarrWGSLnN/4PL60+Lo5UvtuCrGhhniNYrmzxxLmC3fGV5mx2uc3jKcLr1ColaQAhfi4CYlwg8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(316002)(70206006)(36860700001)(44832011)(508600001)(82310400003)(2906002)(2616005)(4326008)(8936002)(36756003)(54906003)(7696005)(8676002)(5660300002)(26005)(1076003)(16526019)(81166007)(83380400001)(6916009)(86362001)(336012)(426003)(47076005)(70586007)(356005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:09:15.5879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1ee189-b4fe-4217-80c8-08d98e5b6c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
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

GTT BO cleanup code is with in the test for loop and
we would skip cleaning up GTT BO on success.

Reported-by: zhang <botton_zhang@163.com>
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 25 ++++++++++++------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
index 909d830b513e..5fe7ff680c29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
@@ -35,6 +35,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 	struct amdgpu_bo *vram_obj = NULL;
 	struct amdgpu_bo **gtt_obj = NULL;
 	struct amdgpu_bo_param bp;
+	struct dma_fence *fence = NULL;
 	uint64_t gart_addr, vram_addr;
 	unsigned n, size;
 	int i, r;
@@ -82,7 +83,6 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		void *gtt_map, *vram_map;
 		void **gart_start, **gart_end;
 		void **vram_start, **vram_end;
-		struct dma_fence *fence = NULL;
 
 		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
 		r = amdgpu_bo_create(adev, &bp, gtt_obj + i);
@@ -212,24 +212,23 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 
 		DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT offset 0x%llx\n",
 			 gart_addr - adev->gmc.gart_start);
-		continue;
+	}
 
+	--i;
 out_lclean_unpin:
-		amdgpu_bo_unpin(gtt_obj[i]);
+	amdgpu_bo_unpin(gtt_obj[i]);
 out_lclean_unres:
-		amdgpu_bo_unreserve(gtt_obj[i]);
+	amdgpu_bo_unreserve(gtt_obj[i]);
 out_lclean_unref:
-		amdgpu_bo_unref(&gtt_obj[i]);
+	amdgpu_bo_unref(&gtt_obj[i]);
 out_lclean:
-		for (--i; i >= 0; --i) {
-			amdgpu_bo_unpin(gtt_obj[i]);
-			amdgpu_bo_unreserve(gtt_obj[i]);
-			amdgpu_bo_unref(&gtt_obj[i]);
-		}
-		if (fence)
-			dma_fence_put(fence);
-		break;
+	for (--i; i >= 0; --i) {
+		amdgpu_bo_unpin(gtt_obj[i]);
+		amdgpu_bo_unreserve(gtt_obj[i]);
+		amdgpu_bo_unref(&gtt_obj[i]);
 	}
+	if (fence)
+		dma_fence_put(fence);
 
 	amdgpu_bo_unpin(vram_obj);
 out_unres:
-- 
2.32.0

