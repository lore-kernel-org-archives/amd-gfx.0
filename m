Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74083C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 17:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2CAC11DD;
	Mon, 25 Jul 2022 17:20:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71147C11DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 17:20:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2ulLpNHSXRkL5c4JJt4hd+JegCBt7FBZgHZWmN4xMN3Vc0OEe78mfNZ71siFhW7zVRUnBae6MOsakOhNqBw4mHPkMlESVdRSuOU2Qk49NyBwgML2s1/2PZY3inoYfQpEZ15HY7qW1l/7E7c2oZzRbsTmL+sMZqU/TdSr8KJKo7Lq0TFu+T89klyFMVE3lR3aD4awCYUL/ICn5ivNZqZ5A8lEh6KZ9nC9F39ZCxMfEPiUeLTGQJKFWal3unjcaLXI1+XTiapwUJ1zKOwu7JuSljVLuUTF0ILssHrOaJzxb5kwbMjiYSlIbt7MSPOZIU9rJz5BZI5D1Nov50LCHTTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFzAcQfHDamziv2jZnyRVw6taXd82EWY2rdnSdEEimg=;
 b=acCjVIyDAmGjakaU6eUAv5e5roidsYz+ZJcB+Ie/OObH3L3Sp0MlXt5+MnMM9Y25DakCE54czI1zu1g0wfhZiYiOWg5TBDWD/IARRExLoo1PCdF8MsWBJqlndVc26oCrQRw/GNoXfg/oOWSFmlOxVhCeD9ctFNEY6UnsWarFWiP8dJuZvrBCOIaTb4ziHIR0X53yF8UBzUsrVLBMEVimuIEJq+tSeeC+a1F1AMXF6oyvFZEhjgZuLadGSptabDv6HTSBAmmYbDmPQ/PHp3Ze+FkNgThRWG7Soso/qFvo7Jjc2NPDDo1FF0boYZzcwGSEb1dUU+cPbT2jTLdoVm8Q0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFzAcQfHDamziv2jZnyRVw6taXd82EWY2rdnSdEEimg=;
 b=nSp4ALHL8poXitbAzNezKFcCqRFB+kSCaHp7OquxhmNPjB+zJDAye5tujpnN1I/T/cDYrlHJzCJTloCAmlQ9m4C89KdS+KHS5oxitKw23yTAm/SMK5zLSmcNC8IA8B6+1W1W+IEpjD0tVX50VWlT6fg3U1Z6fPGUKl59GpaIctY=
Received: from DM6PR08CA0051.namprd08.prod.outlook.com (2603:10b6:5:1e0::25)
 by BN6PR12MB1348.namprd12.prod.outlook.com (2603:10b6:404:1f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 17:20:02 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::c8) by DM6PR08CA0051.outlook.office365.com
 (2603:10b6:5:1e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Mon, 25 Jul 2022 17:20:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 17:20:01 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 12:20:00 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdgpu: Allow TTM to evict svm bo from same process
Date: Mon, 25 Jul 2022 13:19:41 -0400
Message-ID: <20220725171943.9155-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34fcab37-5024-4dbc-e0c8-08da6e61e88b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1348:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fB/h6icRzmvg7kAIt6J5d4AFei+pIfAMY9JZcg9sirbfCAZOUfj0PTjHLrnQm6OfRvo5CckpvCINKhLZ2O4a1EjolN++CmJR6VZM1ZnGvdK7WA/GrtkjKIJiVbuB5u6FC+TnB252uC72HzsJiVdYiwTFiN1t/ONxXVgdzzcbHGD3ogEcsogEaoB9ArrcJ4HJoIoKHDZhZprWkoUQjL5MAoVP4MUj/tvndoXaN531SKE/y0u7vOrM/Z6JiSTY5pM8g7Wy2wJcJPMHPABdy4aB0DEUpPOHk6Fiotaqo6nZxY4LyJPAmtM+tC96UWBVIaMGnEDk+G1c/uNcn2jkjIOFrHRcrmh5n5e7QkeZSdsMEr11ruKgAm7RTVcLYzlk5vtHbUK5kVR8Y+N1tHetS2RQSTrbBaCKgmrMd0UXA4se5bpq6I7x7kQvYH46VGtQbjNaTK4UAI0FXpfIaR8M90uEkSK/+O4GKN4Pc40qqT2+9vpFE2b+8cgjNAqir5d5nbv3FriczGbESCkwaAgLRBKcoW82KrzH/WJap/97weK6S1IeFC9zoExLI0EuYFJ4chheb0IfCmqjgBl+du82w231kJ5T7KK1xNh9yXwE330bqFGpq08ZDywN98c9LWbN+nLxgw8vqNr52N2x5VSsfmYCryrHK0mfGADDg2aWK5Pk1SuSkyMUqSOwOqaRLfsEjSD5IWUcmLBqzbOAV1nUhAu+GzRfyWEBAUNPHafzoBgI/wkqbBB6hz8iRBEzyDbZ2ZxIU3OLUIjlc6k6VNZViPPwzDyWjnt7vMX0xi4gLLe2nNLTr2p+xoSTkYkgeZXuT2oW+Mnuyw/yUOYPwVCHl01y6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(46966006)(40470700004)(47076005)(336012)(426003)(1076003)(8936002)(478600001)(186003)(16526019)(26005)(2616005)(4326008)(316002)(5660300002)(40480700001)(36756003)(82310400005)(6666004)(2906002)(7696005)(40460700003)(36860700001)(86362001)(41300700001)(81166007)(356005)(83380400001)(70206006)(54906003)(6916009)(8676002)(70586007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 17:20:01.7617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fcab37-5024-4dbc-e0c8-08da6e61e88b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1348
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To support SVM range VRAM overcommitment, TTM should be able to evict
svm bo of same process to system memory, to get space to alloc new svm
bo.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1d0dbff87d3f..469785d33791 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -159,11 +159,14 @@ static void amdkfd_fence_release(struct dma_fence *f)
 }
 
 /**
- * amdkfd_fence_check_mm - Check if @mm is same as that of the fence @f
- *  if same return TRUE else return FALSE.
+ * amdkfd_fence_check_mm - Check whether to prevent eviction of @f by @mm
  *
  * @f: [IN] fence
  * @mm: [IN] mm that needs to be verified
+ *
+ * Check if @mm is same as that of the fence @f, if same return TRUE else
+ * return FALSE.
+ * For svm bo, which support vram overcommitment, always return FALSE.
  */
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
 {
@@ -171,7 +174,7 @@ bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
 
 	if (!fence)
 		return false;
-	else if (fence->mm == mm)
+	else if (fence->mm == mm  && !fence->svm_bo)
 		return true;
 
 	return false;
-- 
2.35.1

