Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690C0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 04:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92B510E4D8;
	Mon,  7 Mar 2022 04:03:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE2210E4D8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 04:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj3smwzMdW0/Cw9jNE7R8thZHEQG6G41HvgAEbz9znCqSYWfmCVNUgW4nfnDcS+ZVxTcGJvKKouM31KuDpWm3Xe0R/Pi6AWGaBrYgn9+/WyUxFmhHIMvVofKHRQgF/oa+1UykLMoHiMBtHUl/YqNz9EbkEu4s9UfDoG2/Ai/hWbgzbRY1lafxG+dmoJKhfDYHNXIDtjtJcYenSJv+XwNICs9494h0n/RKH6L1aS5tz6FSsaYJ4Ju84gkMXVMYTGFC3c7SFKgRXBylDkvB3zjQGL+JmFLKfctBmdIMMxU7a5mOAO8sXwG8WZ+1YMC9DHJ9+jq6oHNj87qUf2RqpWfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zke5Wkt/sPm6CXZ62+65tmwPjO7X/4POJZFYDh47mLQ=;
 b=ShyGlZJo2mG6JBpoFemIFrboUTiQZpSfji1bNrl6NncjONSfUVxSSSEtbM+Aql3c9iNUHK37+HYaJ2UNwOsIm18/ItLLax4N+v5tUGaX3tFjx2joKF3LUEeUIGN+bwVuzF7Eex8lV8yzJWbk9MJftSwWI2i5eFLEMMu4QZtJRX5XCEHy8+YN/hyQGuIznK8VbVs/R5tM87bRx7xxZan/62BpCRop7s1K7JVtxvBUuASdqdUYLwKyJJZ7xszBrZLrsDtsDo+qfuxjI2X2fE2hzjIBiU2OmQUCT7niduLbs3Kd34nq5RbRLZUDN3cMQBb1cgkln3ShHlIFiFZb+8vmGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zke5Wkt/sPm6CXZ62+65tmwPjO7X/4POJZFYDh47mLQ=;
 b=pcKUXakVhNof7vs8WhRIoC9ASOrJuGKgKfVwAWv79DnBvcfuigSZLsKyzRWt9L6kYTL5+PyK3M02yOVC/O4w4BEuiB1JYsjG2uun8yICbV+YkFUcM0iy8kRgKfhaak/9Ux1RYL4BJqQIoK3kTpmfk61yV2wbesdC54/oi0NeN64=
Received: from DS7PR03CA0148.namprd03.prod.outlook.com (2603:10b6:5:3b4::33)
 by DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 04:03:26 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::2b) by DS7PR03CA0148.outlook.office365.com
 (2603:10b6:5:3b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 04:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 04:03:25 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 22:03:22 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix a wrong ib reference
Date: Mon, 7 Mar 2022 12:03:09 +0800
Message-ID: <20220307040309.350870-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a5dfa77-2c16-4388-9826-08d9ffef6df6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1242:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12429E49687CC381EE3EF901FB089@DM5PR12MB1242.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNgoQSBsXEmO+DbkTQBP8v50xBro8HZY5+MJKMx9nqn6LKqTwKHszUSLS9yxdfxmCQusLGMGSTpNv+V8mSaB/36D+QuIHITcIzqR8wIBm8Be5Nq0fgzE1tCxtEfQd3Jdf56E9d8/ZPqPT1XVapVHLhid6R1LQOGKEnp/MDtMx7M0H8GTPot9Vg9sqXOsYYvSpBIGRin7D/eeCb5ImekuZTCBHoiCM5Pi4FyPVWobSam92fPtnlicTun2Y9BBdt9FOzbrXkU7C53ehhOv36Ow2UKVzYU892Sz32qpEaqzB7fEYMcT/aZG9XpXe81fppNikjBD/4us1CLZnjF+yycMpN8LKPvIc1flwL/ffGvnqw/Slhx90Upw/7sw56LYhTtp441ndXRGCwRFLT1H7uF8DlqUQp1MSrGnlUNAOYq6/cwTu7+l1UxJzjXJofZ6McklwvZtLNXwiRi0p+kXq9lvHGBMZj0xCbfhTf5h7ByspcbMA5UqFIuSthHiDGK1FwxHj7AxOnVqTkoE49qCTJ18y89ELecty66HJrnQ1fB/OIjqfuqa+/g3Wg8Darjej7NYTPYcWm50szC//zXJKH+n9raCajaJjAlBIK3YDY2Rc40wdRb5UVnv02nz8k/AC7PGo7v6knLdkJiQn/01iszCYtZEus1p3dSwmPqUJ252wrkdstNCkYoYvz+CkQTSvfFwP+Ved4GLV30MQZxoZLVC+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(8676002)(70586007)(70206006)(5660300002)(82310400004)(16526019)(6916009)(316002)(47076005)(36860700001)(54906003)(8936002)(83380400001)(81166007)(356005)(40460700003)(36756003)(508600001)(1076003)(426003)(336012)(26005)(2906002)(7696005)(6666004)(86362001)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 04:03:25.5842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5dfa77-2c16-4388-9826-08d9ffef6df6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It should be p->job->ibs[j] instead of p->job->ibs[i] here.

Fixes: 1027d5d791b7 (drm/amdgpu: use job and ib structures directly in CS parsers)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 662cb66493a4..e8a3078a85cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -783,15 +783,12 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 				memcpy(ib->ptr, kptr, chunk_ib->ib_bytes);
 				amdgpu_bo_kunmap(aobj);
 
-				r = amdgpu_ring_parse_cs(ring, p, p->job,
-							 &p->job->ibs[i]);
+				r = amdgpu_ring_parse_cs(ring, p, p->job, ib);
 				if (r)
 					return r;
 			} else {
 				ib->ptr = (uint32_t *)kptr;
-				r = amdgpu_ring_patch_cs_in_place(ring, p,
-								  p->job,
-								  &p->job->ibs[i]);
+				r = amdgpu_ring_patch_cs_in_place(ring, p, p->job, ib);
 				amdgpu_bo_kunmap(aobj);
 				if (r)
 					return r;
-- 
2.25.1

