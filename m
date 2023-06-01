Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D165C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 19:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1802510E5AC;
	Thu,  1 Jun 2023 19:32:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5239D10E5AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 19:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1P5CKmc1yDeLsoXMCTn80oFE5pLLcW9+g36avKTV1A3YQoClQUYCWg8w1mvnZ7BN8Qi+sh6cvomqvBN1R+byFIMUxcTjY/wse6Q7eNOLrGOxYOe2EFtCN9jVS0jyyEGnOdvoVZwHNBQkPsJvFUVMNGMsFtokx2P9WUZE8+acVq5aBPNodUqyI+7qVbTLpKjapZP2UhwjNT/gHnWm85k/EzxQbvXzEkbB7mXGUIiZ+eshPgwMUlQfdzDJ+5HWVlnPgI/iZ518McZxxLoji7hXZHtYhVji5+jgAveFuu/vs58fxn+R2By2Ny6SZ1HsoiRVbgxWCpNe4oUh7qZJB0qRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8D1ishwm4h9BCuSgtCqJL/N4wDKgVSAgqeEYz7orLA=;
 b=NRbAsoYMw82MRLB/5WW4SrMkzygxCYkDqkx94KzucFnoBCB5dWhgogN3guZTL5f6ZnTTLpNy4ZtyORf4K5Dw8cRM7M7ApD4F+Gj3DzcgBYVAfkAIpvaLZsD9FNN/0ozBBpO9ZlBErMgw9VT/3PMPpTf9KJg6G00oBbhCHIREiZLMuHpmcS8Fh+7LqnUCCbGQ7tjBMFP1ZfFzGRi0RTCAmP6VpKeWAOigOXI4BfcuJl9h2vEr9b0rYQxpLqBrEsY6t5WCmo8j0d62NwV3advRxwLxrfLjCB1bCk/I+Il4aVLKtVHfd6DI4njrZMefKyiqmkmYnG4GzGSRTTi4pqNmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8D1ishwm4h9BCuSgtCqJL/N4wDKgVSAgqeEYz7orLA=;
 b=1+D7+IGuMMjpRGFoTdHMu/OHweiEzM6FuW9fgloHaMOI2dF9kjtKr4pDq5rZ+Z6vZt0AU0orpXXdoZT2O5caVeIJJI+GGAWIQCZtYwJd9f8RvPwMOPEriUPlL/4mCMyWjr2Y8NIDsM5/DiBOQSs596RtnOpAGCOUz3pW5xQ+PFQ=
Received: from MW4PR04CA0229.namprd04.prod.outlook.com (2603:10b6:303:87::24)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 1 Jun
 2023 19:32:19 +0000
Received: from CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::e6) by MW4PR04CA0229.outlook.office365.com
 (2603:10b6:303:87::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT105.mail.protection.outlook.com (10.13.175.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 19:32:19 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:32:18 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Signal page table fence after gfx vm flush
Date: Thu, 1 Jun 2023 15:31:16 -0400
Message-ID: <20230601193117.13143-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230601193117.13143-1-Philip.Yang@amd.com>
References: <20230601193117.13143-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT105:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e9bec6-aa18-4125-300f-08db62d6ea3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Arbm+KmBFws9W4AKnPwBcVUheeJgmQ7dayKQrAHMxF7s1Wvsb8y4Ra3njhuaXFW2yG7DeQZud27eKXwX1NXrpTsLQ5gg2C3f4WHbDYpDXDIrXnefIwwRgPH522aeceLwAcTLcCJbjBUyFOKryyD7NQl1t2CIAZicBi3NvDRKrl72FebnVwk3p68Mol8FqQpvXhJZnA7++VVWtIIyP4gEvTM0Go0+/gdYJQT3u5lBq4nowdA9gwtv51SOHPTaaRntT4NEouQHkpNikA3wqMP7jFgq5JMhruALPo07l4mgdLF1JntVVnAGJN4Fr8MHZUeG26fh8RwLY3SEZT1DF4V+st3amAL9EDFy242KeSzmNN9cPvVrR7adJc9hJxxm+rebz2mS1En08sjylhU5m/hX64GWy3nrsV65pMKzxjMOzJpc+J5KjU0vt1E+A11oAxUIfgE/DOLrIUGislqJoFqHV/Jkty6ZZiJnWWapBg/PgfLKY31IxJWxe1pcdd8GpXikwRax1kD25wR9MvrTf48GZNMFzPqqNYTFqiUST828Ov2thaV3Gb5CPbKKxeCFJ8KlBbvPxJ7PnlH7MpmvKeGFXnuN943Lm8Z5IfgZBfNrnvo/LzlsIq7iKXUglmS89DiVoJ+hC6OfoWZJx0mqyvI+vT3KRdXLeB8Nv0s6oLnKEpG98thigZp7ayk0f4CMjDR1q0sRVoxzeI13DWWcYfmiRAduB/FW1cdIL4+/pTNuTE4+UgeUP8jSRPnQ/rzzCrR91dsUCMYK+VtJWKc/ZErA4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(47076005)(4326008)(81166007)(356005)(82740400003)(40460700003)(6916009)(36756003)(2906002)(8936002)(40480700001)(5660300002)(70206006)(41300700001)(70586007)(8676002)(316002)(86362001)(4744005)(186003)(26005)(2616005)(7696005)(478600001)(82310400005)(1076003)(16526019)(54906003)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:32:19.3856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e9bec6-aa18-4125-300f-08db62d6ea3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To free page table BOs which are fenced and freed when updating page
table.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index e0d3e3aa2e31..10d63256d26b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -219,6 +219,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 			amdgpu_ring_undo(ring);
 			return r;
 		}
+
+		if (vm) {
+			/* Signal fence to free page table BO */
+			dma_fence_signal(vm->pt_fence);
+			dma_fence_put(vm->pt_fence);
+			vm->pt_fence = amdgpu_pt_fence_create();
+		}
 	}
 
 	amdgpu_ring_ib_begin(ring);
-- 
2.35.1

