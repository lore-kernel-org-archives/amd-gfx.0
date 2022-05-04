Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FC2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 15:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9AD410EA05;
	Wed,  4 May 2022 15:04:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D9510EA05
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 15:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/dhcpG+I0L3dKUdUENmIpGyHIt2SIAbfYdRuZ+pQcbqwjU6r/2ICqcWq89+mXwLiGvL2dvoKsQKpoGtnVbId229l1ZDnvV2ZHQTFj6105Qhx9y2QZRxeC3w6uv4Ds5HAua+KVryvlEA4QEFzOB5moo85QFs1upuVxOh8B8bdrAyOVP2Knwjad3q0x0w0ufA1pOFMQesqQQ9OyOnFBAsHsxSR+u6g997+vpBrS5tIpTpNlsIV6hYZUlKxQTLdkvnCw+DqSZDxK+1gNP1fBiJ0FXfUA+4ClzxHvVPFBux3akFsvJRAIbr5cKloIsIDLRLcOcmyRL2/eldx1HmKZgorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flmhrUDDskPHNZsjoEj6sjI6HDmwmNtI4t4Oo+5QxsE=;
 b=EftC+itHWl1Yc6R6fBxguHbDTlIBO24q3OxSNOY6TMNWrVWSy9NigL56r3gX7BK7582s1FRl15/s9FO0raXX6joZ/jCHYC41pl7hK4dx/eu5Ew0JRo0us0ElSkQERbAJ7UGGz0xg8MDJGrv56aJXeKjhwR7g9tDCjg94kHyBBhsklK/dmrBcEMYu4QojYtZytWQqg1cnbGQfBqopP9DSDAKmABIbRkcMdfnErEp0hbmoLCj8Vjbh1jUwITqyioU3qHsxnJOEGiyEv36TnX5r/FV8M8mD+CcQ/Av1aEi3b1gz7UAwl3o5V77yzbD4PMC3Bf5lz8MPhOAMzPosHxCE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flmhrUDDskPHNZsjoEj6sjI6HDmwmNtI4t4Oo+5QxsE=;
 b=njzErQkJRjn7Z3RWzgxTo/xCVC8FxC0TSfPc3MotwprNjTQH3JErkIxJAkqTLUJbAoRFKH2A4wOIMuen/65KbpXxQjlMPGVONmI8gM04F4YCSYdXxQjPQk/mR2kGLpWZ9Sn1I8lms6ldljh2pOb+vId7PGF6TLEH97rnMxC3kZU=
Received: from DS7PR03CA0282.namprd03.prod.outlook.com (2603:10b6:5:3ad::17)
 by CH2PR12MB3782.namprd12.prod.outlook.com (2603:10b6:610:23::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 15:04:29 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::e) by DS7PR03CA0282.outlook.office365.com
 (2603:10b6:5:3ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 4 May 2022 15:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 15:04:29 +0000
Received: from jz-tester.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 10:04:27 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdgpu/vcn4: replace ip based software ring decode
 with common vcn software ring decode
Date: Wed, 4 May 2022 11:04:15 -0400
Message-ID: <20220504150415.667764-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504150415.667764-1-James.Zhu@amd.com>
References: <20220504150415.667764-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8042ca10-e63e-4e2f-4464-08da2ddf6367
X-MS-TrafficTypeDiagnostic: CH2PR12MB3782:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB378282E870444DF030173F93E4C39@CH2PR12MB3782.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vo2cX7ifb58VWqCfAaZbi+/rjDzboBjAFLLQA+R4/icTsWnum3fLlnhYgZz2IcmDOh8aVT7zftxB1ruPkLJRlm3eJ4bHeF63fGxuUXrtUfrCdhXV6s14G8NGCnzEQvW2/K4QBb0Ff/LI5SI7OlYXLa28LTt2mixHFqyl00BwJ9v7XUf/8f47dTIv4BQcgftepk4W5sg53S/uOIjqEvMbmBqetha3zhljDdIfUxxifJNrfwGAvX2AptmYvknE6ZpK/Lfsb+4d+PaykE1+GvLUPRxTl89msAB6tqaZLJIu8P63VjfvEhB6004nUVHCQpnm6IX5/PYAL2n+ifGUhJW7Z5NxC8y1xXk3aNCY8sefYzrlAeGxR01rJbd+VaTp3tNdGwhJ1SnL0hHcL2d2ngYxZGqgfbsZr8mw8X11TkMu+t5geuzw3iupdmZdZaiaur2aAT6ycMtc6wTdZ4lECnKx+WWkVDtZavItqgp+vSUARcB3BW8UzK6qC0c4OBLk58gtPO0ZT5YXSZnQtJhFl4PWb2/0G8e0OUl0tfOuZQ/3m39bp/3RpXkaVfsPXmpDM2PBB4Gfxf8rFTgDQeSnWDOuZwyiEwSR2kS8W4UNg+DNNiKqHIIU4T3M4CKSAkr+nnhLX5wO0xOGbJJ8LpN3lk3i8NlDqVF/wCphmoZCmX56pmqXpmi4V8kn9EzP1ELuhJDROhYnZxQ1wBsDV8guKhcmUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(2616005)(81166007)(316002)(36860700001)(8936002)(5660300002)(6916009)(83380400001)(82310400005)(186003)(16526019)(336012)(426003)(2906002)(1076003)(47076005)(40460700003)(36756003)(86362001)(4326008)(70586007)(70206006)(8676002)(508600001)(356005)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 15:04:29.4078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8042ca10-e63e-4e2f-4464-08da2ddf6367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3782
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace ip based software ring decode with common vcn software ring decode.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Christian Koenig <Christian.Koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 652f8b4c0b09..bb74ff314e75 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -29,7 +29,7 @@
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
-#include "vcn_v3_0.h"
+#include "vcn_sw_ring.h"
 
 #include "vcn/vcn_4_0_0_offset.h"
 #include "vcn/vcn_4_0_0_sh_mask.h"
@@ -1490,22 +1490,20 @@ static const struct amdgpu_ring_funcs vcn_v4_0_dec_sw_ring_vm_funcs = {
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-		4 + /* vcn_v3_0_dec_sw_ring_emit_vm_flush */
-		5 + 5 + /* vcn_v3_0_dec_sw_ring_emit_fdec_swe x2 vm fdec_swe */
-		1, /* vcn_v3_0_dec_sw_ring_insert_end */
-	.emit_ib_size = 5, /* vcn_v3_0_dec_sw_ring_emit_ib */
-	.emit_ib = vcn_v3_0_dec_sw_ring_emit_ib,
-	.emit_fence = vcn_v3_0_dec_sw_ring_emit_fence,
-	.emit_vm_flush = vcn_v3_0_dec_sw_ring_emit_vm_flush,
+		VCN_SW_RING_EMIT_FRAME_SIZE,
+	.emit_ib_size = 5, /* vcn_dec_sw_ring_emit_ib */
+	.emit_ib = vcn_dec_sw_ring_emit_ib,
+	.emit_fence = vcn_dec_sw_ring_emit_fence,
+	.emit_vm_flush = vcn_dec_sw_ring_emit_vm_flush,
 	.test_ring = amdgpu_vcn_dec_sw_ring_test_ring,
 	.test_ib = amdgpu_vcn_dec_sw_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
-	.insert_end = vcn_v3_0_dec_sw_ring_insert_end,
+	.insert_end = vcn_dec_sw_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vcn_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
-	.emit_wreg = vcn_v3_0_dec_sw_ring_emit_wreg,
-	.emit_reg_wait = vcn_v3_0_dec_sw_ring_emit_reg_wait,
+	.emit_wreg = vcn_dec_sw_ring_emit_wreg,
+	.emit_reg_wait = vcn_dec_sw_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-- 
2.25.1

