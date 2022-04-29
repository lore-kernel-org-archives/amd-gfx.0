Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8B4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEAC10F354;
	Fri, 29 Apr 2022 17:47:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B9C10F306
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFAh7o+8OOJV03hNhKP8CLRVMHIM21MSjLntJR0Ufz00v+UPrOyfZwDEJTEC2r/UFeoiX5CmbseNogU+XubkeIDvXCPRFx/C3wPBgfyrhqPchmHG8zJOVDJ31utRgbxil3A/graLXxOFhgwgwtDAjb1zMMmvnzHr/VkGVjJi4Bz1/bJgq8kfI8aVVKFnysXu3d09f9nDUW7BJXREZrm0yTd5/C8yYFccgT/ifSCkJKRCEsR6Qnahb5mmAV/khGS/9PfvAJKl4dSl+3YWWS4PbmHwSM/ZRtOpEQ8WsUfJGR/UdtS62BPOWQCkpHVmIcyIQbwu1Ll+dpykq82zz/+Lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC163EmMCmKhVy1ed7NH27sa12zle1cyLfa7dTNzneg=;
 b=dD8me9Q5H7SoQE/zRp4FaDSj+FNelAQSBAJBpod+SsDz9sCKf4713c6CZ6DG+X0QPMwqTBxfYxlW9tYtduhd9dnU3AkljxejzWyrU3mGQANtKRjvXn+WJCNLjjNIH0e7PczM+Xlhq/3sQaQs8qb+QWy7ztdLvnMEo/vyBClemBg/2J8OYU2gslRxGsFPBpjM0ptfpGUEebdNrcYBgDLtJ+/BAh127xHidhAfOgmLfiu/tDkKT0KiuP9qAdL4adhkmIH2pfWBcqQaTKufCt8dLSOiEFTQwtLcMr1zlHEZeTJ9bgEzL+ZUp6WCEZVTvO9inFTNwKVYFfrYLlKNpVbsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC163EmMCmKhVy1ed7NH27sa12zle1cyLfa7dTNzneg=;
 b=UFIZ4DeBKB0RwjLxhNHHRVDViNNkkCeR/k+8p7xS1GfkknivS/yb2zEhSdfPfaAGfv052i+J4flDia2o2dUs0dnnQjOKVbcsdUwXyvwAg4tCU0GH6e+nbr0qIsg9838lWBxjZsFh2qvu8eNOiERlKG0n9YiHHmNsQbsyRYGkIV0=
Received: from DS7PR06CA0004.namprd06.prod.outlook.com (2603:10b6:8:2a::19) by
 MN2PR12MB3982.namprd12.prod.outlook.com (2603:10b6:208:16c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:46:56 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::92) by DS7PR06CA0004.outlook.office365.com
 (2603:10b6:8:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/73] drm/amdgpu/sdma5: associate mes queue id with fence
Date: Fri, 29 Apr 2022 13:45:42 -0400
Message-ID: <20220429174624.459475-32-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6e8f355-42a6-4d3c-f978-08da2a084105
X-MS-TrafficTypeDiagnostic: MN2PR12MB3982:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3982C9E8D7328857CBA9AC58F7FC9@MN2PR12MB3982.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3CTJFYIqhau6uMbLIISyIeW4LUcoF4L/XDzVrPGsbgSnKFUmdblUroeTHSVvAIehzl8W2x4wK/v0bDwKSnfynPSv9thaVNM3zYrbkI/oriynQ/dSwimaUghtUgOnj5e3eY4xoT1wAzr9loQCymrC7X80x9Bc63eAaC0RTyMgG6rAjQj7LYSKCPTlcM+ZeCbcD10IC3CiDmwgjBwKdhBaTwxF9klmHDaTtHioPIrB+B3IzhxFVpgMftE3c3ZeAVD+AtKse1rMx4ELovEJeJ+SNwIH/uAJEiNg5zb/wnIFqsOqD1YOL/Y5/PhpUCFqGqxTs4NYDONi8kjSm8tr6vRPOHGQm3GjXJmlksBLifs/JSBUQkYE/gh6zdx5C3+rywGxwfjn6zdAXBX++Xgc37nZapLVJdoN/oSPauM9eT25RKEU3l7VOhgJYgtgAZ8o9ZWDvP+ZoKmpdOrhxBrGYB18Q0VdRZDqc6/QMsoGJyD8lopfjleVpFpJyBpE2IUDY64SsPjslZ0t5uMew2P42D+hfX/2ehWixRXoAMPBjshuF6PajiICK1xWtCmpDZr/GG9kRQOgZLtiigkqMrNrMQYwgkrhx9vnBD/yDD1lNIfB1S0wskeYIsidN9IkmP85y97b63Wyq5AWwX7x532qjnMV1FpBt96N/WG3byLYX+WRJhApXpUOM4rsFVm1u9qddqpAyHoBnbImF6i3AKHKy5OeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(508600001)(83380400001)(4326008)(40460700003)(2906002)(86362001)(36756003)(54906003)(6916009)(316002)(70206006)(70586007)(82310400005)(5660300002)(336012)(186003)(16526019)(356005)(81166007)(47076005)(66574015)(2616005)(1076003)(36860700001)(8936002)(26005)(7696005)(6666004)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:56.4424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e8f355-42a6-4d3c-f978-08da2a084105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3982
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 30d12c9df911..b73e45597031 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -562,9 +562,11 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	}
 
 	if (flags & AMDGPU_FENCE_FLAG_INT) {
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

