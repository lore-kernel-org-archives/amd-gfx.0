Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2045ECAAD4
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 21:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BCB10EFC0;
	Mon, 29 Aug 2022 21:18:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A86610EFA9
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 21:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwTfSqIHlteKFAsr88B2hR3awlUDca8AORePyxQkcnAPO6zz95N146zSFb5KutScbTo5JngmIf2MsIHSzHaAWfR37s7lrr/qK/D7K3IzdxPugFDpV/wx+q9ZRH2apU/m3coOkLo64v59VjqosGOjDZLVjyyWXenU0U83qEer1sEJK+JGFnhq6gPYYe3qkca5PO1NAIVAoqOeqKs/DPAsgO08AHE1bzj15pA+HipmJohnUlT/Jdtr2QBtpYs1ejWH3X8jNrRi0CgB4p6zYjpcn9hz2iVKKnwqqNrZKptHR0RfBRtob7HVEy1OHC2MlytP+RsTrdsVcowcpSVYbDujfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwLJmnHarMzTx5HUch6I9eF20jXxamLosh+ul2lB/cE=;
 b=UM4vy/se5hgU3QoTRGPTkyfsQRl9zzr6Ljh41MH6A+KUi2wltDYGfiZTS2z1kd/nZt235BXZklfppUJVTmPtVIab+tgsA7FNZbS16ucgVWz0azW9PVYqUDGG9xJ2ilcaPzVN0lryVA8+znAgqol3sXwmzCmeKaUzWqgcWEJiaKxFfRokFY4uuz31CCb9Q6vvnhYp5W5V5jkByPSIsQwlXoCFyJvsih4Iz/WbWldS9YX+YVVymUxCDvJyeVnkcUabI7g6Ruo+a3TTxYqonZ89VV02/Hsno6vhTi414d48dPUwXBp3dvnLQj0PAY37aUtNTcetH2kdqSjybRTbNhV22w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwLJmnHarMzTx5HUch6I9eF20jXxamLosh+ul2lB/cE=;
 b=u93BLcwtX+4dY+/yNqu01PDqmi45OyHKv51XjLbbiLqg274Dcqbl4LO12Ysn4xD7N9YcOLrHJWu1tJVIY/ZOgSp8Ms+x02BWHGX5Xpc4Y1J7tI7Fkug4N21hPxZbANJSwKwXyKERbYJVuRLKbXTDXs9QYKQzXYZQqTaRFSkUUAg=
Received: from DS7PR05CA0074.namprd05.prod.outlook.com (2603:10b6:8:57::22) by
 BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 21:18:27 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::cd) by DS7PR05CA0074.outlook.office365.com
 (2603:10b6:8:57::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Mon, 29 Aug 2022 21:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 21:18:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:18:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amdgpu: init gfx config for gfx v11_0_3
Date: Mon, 29 Aug 2022 17:17:51 -0400
Message-ID: <20220829211756.1152505-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829211756.1152505-1-alexander.deucher@amd.com>
References: <20220829211756.1152505-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d809fef0-b0a5-4a05-2091-08da8a04037c
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDOrBmKpu7JYIoTtK+rrqmCYre9yINsAhAzRLTQ1boA0/XLx+Aa+Rc0jK6d+0SHTdrIJy64dZpXTUBlgMqopbKNTk+V3eB3W4eknU6Uu0taccW+4fPRIzVEvonCTLtl0Qs0VhcVJRNQVCb7aqO2QPT/x2xj9JmpL1ca3PApB8A1Akyb6WVVia8sxHssQJMfVvCjRNbdYGaDDndQbXSA2DVXOz3VWfKqR9/86Obm2/4cvTGfVcXkft/t5jouINyTNgYLApwg2+OcuqK9+CIo73tu30Z1Ls6y+1YEwnbc06xOS/574iYdzefCMQlDuPh86l4B/xmaIYTfDQBtm+VVXecgCaMllbHp5tDptmXIYA4ugX1a4tmQv7KvqsglR79vvR7FqTbY0EMUcqaqlQ5SVV9w+3El0/VSlRg4K56Ad8OY7KZ9eyl/kSnao9U/uSwiZiHmQILPiobJoVF9zpKuHBJMO33FLa4tdVfkEQ1VMv1MVbCYPG1ics4o8Vr2GPzvyKp4cDgzZKfUK8X1RjmLK8SNHHEa7TkHbcRP2Pcigkpwkjs+Rgg5LyG6EJpwxq3ZJPxc+lZFVMhBPBnDhaRYRycXuGiaCiQ/FMRGl7Tt5pH/jf1Qk5BOiZxcNNHscgN/ARyYLiLqDJ8zfMlUztoV0dVFTBSNrXe9TMVOAVyxFSVUa3lyXsOPJLoJBWGuFkH350gxJuNFFyrwpIE264+5sGmfM9hVJbyoTtrO2j6t6qIyM8LOodgPciLNnPKr9sskZGXV1kCAZ5lfpxTbK+8uWR4GRzOJRnrPhBPg+PioL8TV8W2QnlvMcuWEpgx/E3TVY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(40470700004)(46966006)(36840700001)(5660300002)(54906003)(8936002)(8676002)(4326008)(2616005)(426003)(47076005)(1076003)(36860700001)(70586007)(2906002)(316002)(6916009)(36756003)(6666004)(478600001)(41300700001)(7696005)(70206006)(86362001)(82310400005)(356005)(16526019)(82740400003)(40480700001)(186003)(336012)(26005)(81166007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:18:26.8377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d809fef0-b0a5-4a05-2091-08da8a04037c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5544
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

initialize some gfx config for gfx v11_0_3

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8114953f1268..f2d126b110e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1114,6 +1114,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1549,6 +1550,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
-- 
2.37.1

