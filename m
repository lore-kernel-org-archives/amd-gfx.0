Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23143C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 09:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7A414ACD3;
	Thu,  7 Jul 2022 09:51:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B398514AADC
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 09:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1NcitrSmLkXoS8JSzkNU4cySBkL/KzkjS8DErPIrzkRe7nfIMFP5iRnIK0oagtT0FQ+cgmXFA3YhGwb6Y9UKxPLQ8YD8Je+VJANEMd8uQToW3f3gAeok7EfnUuIouY8SCo6i7J0lSO5dZXpBLF6IpmlBhRMW8AVb5rNjbKiNpDai35UoLcEhoSc/TwQ6B4qBVlTh/FOxIP0/tCfWUZCPGCl8sqdF6mG2KF0oSNqsAkxqUXcC22l92RhSLM8dQRmjorN0aj1hpxyNLOXYlszzIC+ZKk+iFTtDZomlBnqb05L03BrT84sUsKxwI/3mGzlyS1CL4kh1qhf0HFKnRk5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmD/CglSiXCHJEA++WXs0B+NhdZL7qzjn7SDhpBAXuc=;
 b=MSyPGkJwFiC8Bx49whweVibxMRuCRbfWDN+R8DJ/HsyO79Jxlp5F+NA+bght4ayoycF8qIqIVs/IJLybsLv+ZhhQIgUeomMg0rQPCYGYblcr77bS/GRxlJ1+zhhJUDcwd4dlRPq2Hm7E6ZUR0slIXZe2GJZe0Acqj1RtBs4YtROKGIOg1dUKYOXxT6+lANt3j/+JDKPSb4XsKgTC5LjGFleCEKIvyYKHZoX5DXo2x8GLyUgo2w++AogFwRk8/JOMDU/3QHYtta8e1MqnpDKR1G+5mNv1PGnnCU6CvLy2hGWZsEov0Yg858FqduvmMAoz7rlcSdRQkWAp57IhjU7JNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmD/CglSiXCHJEA++WXs0B+NhdZL7qzjn7SDhpBAXuc=;
 b=TCa1GjYn97Av3AYbd6tp8By4iRgbn0Mwkjvir37+JvcdDU8WbzfKwBSM7yfZ0yQzirOxJIq9RHcl1MxyIFgMpzpqw8cWX/6F9KPdukUlOYLfqk13WZ5mBUh/yg4S6fAar2fn5KuxgR1FyW9B48n8zylurs5BJgOq4a0Zdc5cxm4=
Received: from BN0PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:e8::22)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 09:51:13 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::59) by BN0PR04CA0047.outlook.office365.com
 (2603:10b6:408:e8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 7 Jul 2022 09:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 09:51:13 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 04:51:11 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
Date: Thu, 7 Jul 2022 17:50:53 +0800
Message-ID: <20220707095053.6755-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d76000da-34df-4536-4a9f-08da5ffe3a79
X-MS-TrafficTypeDiagnostic: BY5PR12MB4274:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/lAfxV1YN32FdzZDhl31zkpTU/MXsgmA9mi4UuwH+V7SyOHMi/TGU3LyVdVzQCjemjxxBNyCyg21fWM452VleuPUISuUcd3EffUJnoL4mnVFNatPTo4k7RYDiYfJo+TIIUNsQUOmYkVnlQC7IEJz1/3y05NytzLWPsHjlzvvURisZ+iO4ekhFOdkQ6ZHGkvxTV1M8Yau1/r2zGo6x0ICG/yBZiDzucQEN+oe5BkH1TT9CQXBES0fD+rEN7Udi9SVJIv2rsbF29NoqtATcRUVUD7tko/TpskYsTom4ARUyhk9j5cN6u65Ad8Z4T6+MbiXIC939IjCXPWLw06OKvUwY871YlAiRGktW7nRNOv0tnCfez8MyYkjcwli2BGqOlyLW1byN7tcbTxQtE7YXAJ9lGuCg38EwiYyfFaIT/Cluf6rwAhBRy6+vQm4ONRFsAOhyX42WhmwORRP+tkX+w6anHgRp+k+5+Rlpovic48GD8yAc2OleTUPbKv1vEvFpVD0HEpdDK7bdoCEJQ+hMcHkYrHdUXpss6OrbIQLpEaFG1DnfvgU4O8cpXJ3M428PDVBROOBb04PaHvhjlzuxETGwyZ77XtGEur6VAY1OvXU81UzPbAge2XWJCC7RO61gjLzcB4My0x6UuLF9DXA2Uhjfc97RPlsQ9+E8X9rPBE1UdNjWqvNEj00piY7p604c7RW8343vR4ARZcrmViLBeVhzzuUnrPtLdRhbM7hj1Ijp61tIUp5TuIC9sNzPOddvEAfTINw6VUjLO5BxD3GvuaoxZO6BpBbIrRSlOpiykObNVo94erTrqKGKN5eg05GuFWYEPMyYvTL36Mi/Z7FB8tq+plL0bRrKOVjoHQ3c7kzb+B1FDkd4lhLFDJCVmvRP7c
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(40470700004)(36840700001)(46966006)(82310400005)(83380400001)(2616005)(426003)(86362001)(8676002)(40460700003)(316002)(47076005)(1076003)(336012)(16526019)(54906003)(186003)(6916009)(4744005)(26005)(8936002)(82740400003)(5660300002)(2906002)(81166007)(356005)(34020700004)(36860700001)(6666004)(41300700001)(70206006)(70586007)(36756003)(7696005)(4326008)(40480700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 09:51:13.3080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76000da-34df-4536-4a9f-08da5ffe3a79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fence is accessed by dma_resv_add_fence() now.
Use amdgpu_amdkfd_remove_eviction_fence instead.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0036c9e405af..1e25c400ce4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1558,10 +1558,10 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 
 	if (!process_info)
 		return;
-
 	/* Release eviction fence from PD */
 	amdgpu_bo_reserve(pd, false);
-	amdgpu_bo_fence(pd, NULL, false);
+	amdgpu_amdkfd_remove_eviction_fence(pd,
+					process_info->eviction_fence);
 	amdgpu_bo_unreserve(pd);
 
 	/* Update process info */
-- 
2.34.1

