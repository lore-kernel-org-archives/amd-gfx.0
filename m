Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D67C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 09:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DECE8B66F;
	Thu, 21 Jul 2022 09:52:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2AEC2BCE8
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 09:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdpvo4ABfVma1qUK24m4c64kIFmeJRYzyfhPnzgqRlIoMLPqnZolHq5Wu1khRLiny2JiW2ON/A/EhXHqNXzuj7JHqjBmQi0aGa1+gHxONWHW6w181moQZWpp3MPOmqBpUxbdydzR3y1KNNZIl5MGHrdj8Q3No3NKLcZntqDDST2pUjoGq7EUxMsBGxRRZf0iRBkQOIJba/yoqqex49QbxG5jW1625Q1HPxISsuqzrbo6pNAzYeNATDHIMzuxNgjFuyY+C78kvP49Z91tKqLgj/IUSghPWIy/rK9cVl9PALQW9qPYBDGFw0PY9IiCfTTOs/cyVxrCZQzQeUrMXr9dww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LI59BSjO1rI5rHb33V0pP14ylDLtDIqr202DkR1trrI=;
 b=Y60UUmIFY+tO7AkqsbDczM8ohhHnuRtEakeG9r4SaWiKKiKlIoVpKXZchJdhi6WrQxhE3QrYpvVf2pNBVLj6nGE7kg1cc+zhzzaMRTqUmQSFZ1CcydKtniJMWJAg25zlJDRT9KpRg9b6MNaTuEGHiCWvuR1+fn0IXPc4cW6944X3wgBiHXvHKXef0dHW9XGyVMuvFUc0+XjyHvbUtF2CWyvv7zVEtkvS9BmnS2oBqlVnZKUKNWiKYQgnil3BVc/s+DsAXqTP3zDkaMHEKPN8+IRlyMfMWo8zZc/zKYN1lKMfLvgwmNAMDtg/TTL54pD6c15j4oFaENCDB1uzkGGd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI59BSjO1rI5rHb33V0pP14ylDLtDIqr202DkR1trrI=;
 b=qZ9oaLwTIQGkZp1pxQ0+TFhhklrpLpO3jIrXlLaRaQJFbICerW8ekhTWnz21m0ZuruSjkUHnFu4VvvSMy6CaLApdUUO0V1Zhyz/Yms1g/nC9IG4GQzAhdb/wlkdLyj/YRaI7GnFB4g8t9T6sz/pJ44mD0XuwZBcnBWowfvIpyA0=
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by MWHPR12MB1439.namprd12.prod.outlook.com (2603:10b6:300:12::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 09:52:27 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::78) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Thu, 21 Jul 2022 09:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 09:52:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 04:52:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 04:52:25 -0500
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Thu, 21 Jul 2022 04:52:22 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: add a compute pipe reset for SR-IOV
Date: Thu, 21 Jul 2022 17:52:07 +0800
Message-ID: <20220721095210.37519-3-horace.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721095210.37519-1-horace.chen@amd.com>
References: <20220721095210.37519-1-horace.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84128fbd-d14d-4934-683e-08da6afeb848
X-MS-TrafficTypeDiagnostic: MWHPR12MB1439:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peiJMbQ4ppIW7oyc3UmYBXhDojIWAzo30p7DZmwR9EGIgmPqtsak9jQwFAStekqJiN+bxTsecPnZGtG0pa7GbDXZ1QKvwnlyffydjpbjezAy7g7zZKrZJUFTgd3HTax2putMitcpYgG2clkdt3zt15x+8YUpqLVsH/fbSwKSUE126GL/MqeE8wFzKRR8rmQ125XuErGU0z2Vy6XLeaYS7uLB56sFhNbOCKOmIqx74ypjL8YGE7+Ql3MiexzK2RCtZYrYfenhG/PGhCDdiD6rpaxgnLg0Q4DFSKgHsQcOarC8xEUtYOZUQ5pEzKH8AgDJYC+cvl3qARQTgwNJONeAcfrjLCElvITKLt6DmSSaYE+iP3Q5IaNAuXv2kRvZKzfqPMj34I396M94Uf8buePrJi+qsMc3/9Zlm4VtgVmeMAH8nSz3/UWJjpwg3L+WcasUPbxN1/RubZydY0G111bHvJvqlWQAYyCQ+Ri4uTTcnrIhc1+NDaERWssKzEBOPNF+RKZcmWQECS/7kpgH7sAcmYicbbaadFpcCuXifNbbeSsGDtVfkGCcCQ7uhOTWiL/1TbN6rals5dAL/zx7d1xDv+VslCvXgE3W01I+NqsYI49CJI7WXqhjIY1KBCAspnukSDx1ptq0n8LHjUnEfOdpsN5mxq9Ri3A9PoQZv/CLNzuBaMwMMx13AgQzdMUs+dX/S+jYkzoqJcJUm3T79hCggaroKBe5uFCrD6FJDoozO8E1qbA0L/hjUchFVVeKanw3nNKSi88GHZ9z7DoPWvHG4aOk8HxYgCVumVlJ6DRrg7/lEbgGWwOaRkwUanc3F/LmWVr7gw4OzttJvhOOkRailA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(40470700004)(36840700001)(86362001)(83380400001)(356005)(81166007)(4326008)(8676002)(36860700001)(82740400003)(70586007)(70206006)(40460700003)(316002)(6916009)(40480700001)(54906003)(2906002)(8936002)(44832011)(7696005)(26005)(47076005)(6666004)(426003)(5660300002)(1076003)(2616005)(41300700001)(186003)(36756003)(478600001)(82310400005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 09:52:27.0462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84128fbd-d14d-4934-683e-08da6afeb848
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1439
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Under SR-IOV, we are not sure whether pipe status is
good or not when doing initialization. The compute engine
maybe fail to bringup if pipe status is bad.

[How]
For SR-IOV, disable the compute engine to do a pipe reset
before we do initialization.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0d8193b30fc5..b8f197a5ee84 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4586,8 +4586,12 @@ static int gfx_v11_0_hw_init(void *handle)
 		DRM_WARN("Invalid gb_addr_config !\n");
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-	    adev->gfx.rs64_enable)
+	    adev->gfx.rs64_enable) {
+		if (amdgpu_sriov_vf(adev))
+			gfx_v11_0_cp_compute_enable(adev, false);
+
 		gfx_v11_0_config_gfx_rs64(adev);
+	}
 
 	r = gfx_v11_0_gfxhub_enable(adev);
 	if (r)
-- 
2.25.1

