Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136AFC004D4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 00:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8438110E0D6;
	Fri, 20 Jan 2023 00:44:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6052010E0D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 00:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYvWYyCJ1AQUilw4JvddKAfp5V7CWdmhD72t3v4csnPTxXYzyd5iY+LhFDFlN6ccmoRljHRNI8BV496R0vUvbZEkBCzhH6xN1x6Po1uUxLOgYIx2Xp2Jv2tkmOncDGrxqpbG0fX2R3STnlSmt1hHfELC4L0pt6L2mW2FajLZS3dtFXbWu8/vXq6gqzOGxE/Uthfxs8P1fNJznnB0mjFcXplx9T9L3rV4Eb7+txdw8KhLMO5hE0X8owK9TECDJPjIBEWUqJxn/YGkPYk5+0e9TnQBG1vN+1A3Fd/HMLa26VrWGRU/QZpRQbA6vHLqIIWKKMfYBCW6XZFdMrB1HGM9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc9gd5MB89u9PBYbSTnGSrt4ezCCywJwX/7C3IS6oBI=;
 b=jQmZKrRmHLIoLLL3OWEKx8NPazg5CchpEUEVBiWngbU7pDMquMfkVnkA2qCwbCN3ab3NNVo4gj5y3wXtz5xyZ7NW5SEDBfXh9cTS1hZHbL3Gp2sYLauX+7764sErYgUWkNh20p8SE+ODGoLC8+pRmJ7sm08WLCj8c/qvj4GRV8BU1AsWZB/Z69/G+08/gpEOr5Di9FxW5f6HWu3xOfnvg01aJlYFvopeO01+oPefS7zzabNy75LcpHLbSbVRWWhrYA7j7boi35mkvOSjLHyL244LyN1QS+u2YiWj4Z0qtHgjrw50Cm7s+vMSXVKk5I6JVy54rihAkrvD27CcJTGvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc9gd5MB89u9PBYbSTnGSrt4ezCCywJwX/7C3IS6oBI=;
 b=jtZtjPbjV9UdWn7HWcj3jgi3tPq6b/zOpRqsuN3FifvNN7olxWAUTrdDAa0IDxRjO1MmC+asZGGEFUSG0qb51ZltiYNy3Nh9hKXe5qFe0NOUqZKE6PW3ZtAeJ7Il5VkqglHCSuAR3Bu7RLEZUv9qeGk+UPAVB1gkbIWhh1Rkk8E=
Received: from DM6PR07CA0057.namprd07.prod.outlook.com (2603:10b6:5:74::34) by
 SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 00:44:43 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::9d) by DM6PR07CA0057.outlook.office365.com
 (2603:10b6:5:74::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Fri, 20 Jan 2023 00:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 00:44:42 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 18:44:41 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove unconditional trap enable on add gfx11
 queues
Date: Thu, 19 Jan 2023 19:43:56 -0500
Message-ID: <20230120004356.3872152-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: f76da042-b66f-4a44-f5c5-08dafa7f8535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BzEj0biP3FD1iLvvMwcln0oV9XTKlrqXj7pfzrjw2Jykjr5IKQV1LmOcUNR7Euc0GBMnGdGuNJmQwda/wz5OOLcn0iEB/1r0gaXfswFVmbFAo+pRvZGwPq4ufOMtgmEGcD8GNnkqnM6109wofb6ngcdQ/fQh9NDcr99fHv2lQJABN0M2hZ16i2HVbtDUyDA8XSbN7Uq2fenI/S1lg9vTs73BLjrVZEddjf+UYzqbsx5MW54xZljlSo0S3Nx2aRRR/l35qi5FFLlG5o/ArYeVikh7yFwqeverGcWgWCKPhcDQmIn1Zyz8ZbOJ94uKqWLh963+OwZ1E4HDeR+Gp+hs5+BU2BFPOsSJ7DQJEmFBppQoO+ta9BHazf7QQ/uxUQ1oH4Vjlc6ZjpWgNVRUCPtz77hv3/xotK7ccxDyQ/+uyJTCciww4WB/A7Ed9G28waKEOkCaaCW7CPaOmWt8abvNWLNGLSvP/elYMIjsyLBQSZYRiNj1b/lhR1RPpWTl0iZoxcl/AALVp4qVwdOSOZudqTnatrg8aPP09yS7/ZBNXqiSEyAwhtA2jJZ24n8CasI0/Wojl2/vnOphQGV1Jw5rqEdB2oPswEXjynQ3h4+04rrrkfsZsIyaATxH71aH1KA05ns/JuFHcFcsH4pb/cpaxqS5mwEL2QCGAhXvbIuwaFe1sWl+wKnWGXB2OfBzUXG5jRW9dalJTzcihn9gZhCcASkMElpQAVVlywffZUrkPdg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(81166007)(70586007)(478600001)(356005)(86362001)(82740400003)(5660300002)(8936002)(44832011)(70206006)(2906002)(82310400005)(4326008)(6916009)(41300700001)(8676002)(40480700001)(186003)(40460700003)(336012)(2616005)(83380400001)(1076003)(26005)(16526019)(7696005)(316002)(54906003)(6666004)(426003)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 00:44:42.8261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76da042-b66f-4a44-f5c5-08dafa7f8535
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Graham Sider <graham.sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rebase of driver has incorrect unconditional trap enablement
for GFX11 when adding mes queues.

Reported-by: Graham Sider <graham.sider@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index bfa305079bfc..00e64838bb8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -190,19 +190,18 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.paging = input->paging;
 	mes_add_queue_pkt.vm_context_cntl = vm_cntx_cntl;
 	mes_add_queue_pkt.gws_base = input->gws_base;
 	mes_add_queue_pkt.gws_size = input->gws_size;
 	mes_add_queue_pkt.trap_handler_addr = input->tba_addr;
 	mes_add_queue_pkt.tma_addr = input->tma_addr;
 	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
-	mes_add_queue_pkt.trap_en = 1;
 
 	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL queues) */
 	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
 	mes_add_queue_pkt.gds_size = input->queue_size;
 
 	if (!(((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 4) &&
 		  (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) &&
 		  (adev->ip_versions[GC_HWIP][0] <= IP_VERSION(11, 0, 3))))
 		mes_add_queue_pkt.trap_en = 1;
-- 
2.25.1

