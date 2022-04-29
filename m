Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11606C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A440210F232;
	Fri, 29 Apr 2022 17:47:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5CB10F232
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1yrRZ32HcsNzeyI+o8whjYB2LclazeOgaA7JoRi4ZtsU157hCf7+YFp683Kl481C0B7/W2XE6niGobQo09pl+m/JfyfxoJkWrFEKvBrxJOn03kBd6EF9w7PdXUyYGcEWgST7BmjsDhXH1caDjgV0wrqDuTJphhjsyKbf5G4WFmJsFvNN1snKZa5G8RaeljOOtg707v8V+z+V5poR5TiIAcl8+/kOhlkdBh/r2MJh8JfQnYybHXdbMiB5AFv7Kyxr08iGT0vtEmdqa9axUqa4Pv2STYP3X82n3UeL3MAN/jwKPVIiH909ott3ZzkqKlkYOYc45rOuGGq1aNJm+Gnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQeKLfK+IsR26qvUSEYLuqSu+e3+jAyoRvtv+JKt2vM=;
 b=mSD1645/FBJrzBHzIJGWnQyvm9fRM/wrfmM+Y23NW+dsoA6Xd97gvAVz63SH44TA3RJuOH3gTzCuQTsTyAdJn5Yzg7eAxHEYWy3zuUapoksFj7hJk2KucaLmpYJr+bjO6BtLjzfDsE09g/L2rWXrjgwLBSTmTeEuT1jwjmvS3c1sdQcJRGX+4iUS1wq9WPJrmL3//OZGeUy36z8ohpSjOLcKtjo63d0h3nmo+pwoZAr6yYS2qvqxTIRyWtbRJmgBZbFZ52o9LAbzf1bnR5ifCVNuB8qDE7HzlMRj8OE+pGZJYF8fW0aWK/pEkokatS2sM7YKFJ+TO9HUZSN9tCJ+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQeKLfK+IsR26qvUSEYLuqSu+e3+jAyoRvtv+JKt2vM=;
 b=GjrNNli+aXsdVWHnRTKvYkGgF+6Oj8R+sjXDYFwYHLFd/DNVInLXSJvABpv/0z+O0XsDewCxdKPVDmQ7QoWymtglBgxPPXsgJgaeGxTCzKIsvgN2f4Nxse7OGOe76oDIsiwXTBrvIzJ42TNu49TMzTgs4cBEghx3YhZgdhu/tkw=
Received: from DS7PR06CA0009.namprd06.prod.outlook.com (2603:10b6:8:2a::28) by
 BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:46:53 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::cc) by DS7PR06CA0009.outlook.office365.com
 (2603:10b6:8:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/73] drm/amdgpu/sdma5.2: associate mes queue id with fence
Date: Fri, 29 Apr 2022 13:45:37 -0400
Message-ID: <20220429174624.459475-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96801a75-a1f0-4019-2b1c-08da2a083f48
X-MS-TrafficTypeDiagnostic: BY5PR12MB4322:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4322195FA9E1C09B9175CF3FF7FC9@BY5PR12MB4322.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ri85L88szwRhP0x5xDUiYaAQW+Om2ZD0Q/qrKGyEJVnuWlIm/eyNI/0uKR1PS33igYy7FJK59K07dm/s+zxmBLpnl/XOuUQlL4bj3H50a+Cj2lKoUWH7TLymXry0IzKrzshKEmGaIzT5iY1EWeAH+eHRALvs515sJtWBYZrccrz2aiYyD0X/R14CmcNBRjxivXX99b6BzISmRDhuShUeB3/G+Y0ui9C4j98WqKhhPBSWRtZHueuUoNSz4WoixJiPFftdPYtTHv09RA+vH+Da6uAyQIIFyG//voqgpgQphnSBJZy0UcW+uIY/Lq6PKb0Qw2g7T8ljmmlWgfsXme7EyI1w5es5C4vPBevB/4Vchzi/SqBpGQnOhlJfUwkIevAKnB7tZNrCvi1ok9ekbPE1lg7/kz+ur6nL3z0kSERG+m6j730vH60etfBeyyuzn3hEDrqAe0LYdjCZPalyVX4tD1Hd/UuIyVMtXeuhkOxvSFkNoQ8Cp62fxyNr3yyAI/yWQnq0O5D8yFkw0t1Z72y4tZfGzUZqnVGL3yjfuypG8Xa5qUooAzbxOqCsx5FHyL0zx9QDSayL//JZNemxrvfqTMNcW92w2V7vL3LRBcpGO8IfeCZ2Kj5ulzBd+CYP4beqDsooD62HKrkYFghz6ZVi2ALhWD8RcfJ4M4/aEwQk7H8FaSeC9DBvH6ErSgAZNqEbcrVzS60OSMVCa9ofG2y6tQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(2906002)(82310400005)(4326008)(36860700001)(83380400001)(36756003)(316002)(8936002)(6916009)(54906003)(70206006)(5660300002)(70586007)(8676002)(2616005)(1076003)(26005)(186003)(16526019)(7696005)(47076005)(6666004)(426003)(336012)(86362001)(40460700003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:53.5052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96801a75-a1f0-4019-2b1c-08da2a083f48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Associate mes queue id with fence, so that EOP trap handler can look up
which queue issues the fence.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f67801c5a6c1..0b7de18df5f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -460,10 +460,12 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, upper_32_bits(seq));
 	}
 
-	if (flags & AMDGPU_FENCE_FLAG_INT) {
+	if ((flags & AMDGPU_FENCE_FLAG_INT)) {
+		uint32_t ctx = ring->is_mes_queue ?
+			(ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0;
 		/* generate an interrupt */
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
-		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
+		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(ctx));
 	}
 }
 
-- 
2.35.1

