Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F0DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E5610F687;
	Fri, 29 Apr 2022 17:47:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3668110F23E
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rmv1JNbBe81S92DAoG0xeh/jq2Q2t03qZdeobFD4iktX8WS8fnOukdadFshje8UY+C1lGKgF057hL6MNUay/NvtruLbPeADos3j6lP4wPIR7en05Jd7AaUbuH8qz7mNBrO+PQNxUBugMWArfXEPuiQ5ZQBzKSMnS11ce+/0dI5YGkC8mdL6bgdeMCUL+HdvUZOgfnnU4mD1B7WawfMb5Kur+D3PsL2lXpCMCDhvXqL1rYQEyqvXw88dbPC1eV3hzj0MxJfTCQ8tcD6xPiXhBsvHvTwPxtX3C60vcgo24H1Fdnc0lSb2A/NBa1GXednh8ck01ttLI4iY3jbUityK01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQ5hwlocVq9mjq3wyhYLUo0/x0DpxCN4wjQZah0t26k=;
 b=NGRykEgjBcNxtTOhtRIOXw5pUgdz0QfCYSDkZjM+nDafwcC9ywAFH+0gbSsUVR7rQedDaTFsTrPsv6kARE52X9J61KPIswLneO3YVbMefBn1Xd7r5P6yuScpFD4kqtguGVdKXclFfA8p/skar8YoICwU6U2GqajSHQkzLIip4TxOehjGg5QDGimwwxnqekaCvt9r7PnhxytjSIoxKqMLIk3MQ+snxOuRj5dUi8gj8dDOm7cKPc4ddLv55HLh8YuAnkqquoholaOvZoWSX+xTlYk2FbxLgrwKl7P7WmFE6XRGyKU7PkjFA5XBvz26Hu8mp0LDHrZCi/YTxK14S4bSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ5hwlocVq9mjq3wyhYLUo0/x0DpxCN4wjQZah0t26k=;
 b=kQ119Qb0Nd4DmtrutVF4cZPusvPIegFHkY0+lERE/OY4e7pBwS92H3aQMXKljhcTETlAOH289Tk12ggWG4iOBAi+9+me74ECbDUv+oMZLhJJB4rYtKPtRDM7E7Ath4E12Xpw+XGS8Befwzv9DurteqQTL90sameslPyD5/9qdyE=
Received: from DS7PR06CA0011.namprd06.prod.outlook.com (2603:10b6:8:2a::6) by
 DM5PR12MB1404.namprd12.prod.outlook.com (2603:10b6:3:77::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 17:46:53 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::fb) by DS7PR06CA0011.outlook.office365.com
 (2603:10b6:8:2a::6) with Microsoft SMTP Server (version=TLS1_2,
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
 2022 12:46:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/73] drm/amdgpu/sdma5.2: initialize sdma mqd
Date: Fri, 29 Apr 2022 13:45:36 -0400
Message-ID: <20220429174624.459475-26-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3453b1d-46ca-4bfd-f405-08da2a083f0e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1404:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB140454CE136B7FD67573B4F5F7FC9@DM5PR12MB1404.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3c2sRoUyHozf17lXgGCfe9eayqjEqmlb7KPeffTYLWrG9Ez2p3L+euJLkX34KOx+rLy9RbCwxk/dk3YI3CYweojOpJs/ydjQY6NMEaDtztjYwE5QUDXmIgfckSQTl9lrVx7Jks4nzndRhZIWYPG4ufXpiP4CRriTEfjnz2MhaVB2l2yZa8aB8BI017cY2SzXmvkle9RgYDVI9qWYsV0F9fLJ7Q6Pe3As5jsWnFrZeHbXAeZsCxZMRgDu7sGyEfLUg8AIWYie5L4fJ2Nk3JOARRFwzSwf2tsn9kbGY7naPVww7vQZN/Ol9cUAJft4d7MTiyDgPM8/eGXdWXLt65JiB/xx5Bj3UbPXi5C6rL3wBGXe8INoX4OXGN7oWSdU8s5mdYT16LIIIrRLpKqs9F0FAPairZnixL0GhmFIsHjdp7reXTcYZ0INMS6yHshk4/Vmz/Thj+OpMza3c1FiSA+Z/0JpRewfZy5gPDAY7rsb6FKWrPd9T4EWDvFPbiVS4HJd8iqcsOqYWsD9jOTli1wvyGJKAa0YrH80gHL2OTwpetPvbug7FO4mjmjTS9i0hoEc1l523MGmcsca6HbbWvglqvV1xawCw6Twap1aLS3+aTOSOwpcrvrvcSn7MsK3vtxkDpP1eO331hrnpVJ04Ze587CCFBzkmLJPgAQFW7czNznUZ+mbswH2TKO7H9S7gcJ7SQybh0VUgOSuQEWCN9HiYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(86362001)(36756003)(16526019)(8936002)(40460700003)(336012)(5660300002)(47076005)(66574015)(426003)(36860700001)(186003)(316002)(83380400001)(6666004)(7696005)(26005)(2616005)(82310400005)(81166007)(2906002)(356005)(1076003)(70586007)(70206006)(4326008)(6916009)(8676002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:53.1458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3453b1d-46ca-4bfd-f405-08da2a083f0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1404
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

Initialize sdma mqd according to ring settings.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index bf2cf95cbf8f..f67801c5a6c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -903,6 +903,49 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 	return r;
 }
 
+static int sdma_v5_2_mqd_init(struct amdgpu_device *adev, void *mqd,
+			      struct amdgpu_mqd_prop *prop)
+{
+	struct v10_sdma_mqd *m = mqd;
+	uint64_t wb_gpu_addr;
+
+	m->sdmax_rlcx_rb_cntl =
+		order_base_2(prop->queue_size / 4) << SDMA0_RLC0_RB_CNTL__RB_SIZE__SHIFT |
+		1 << SDMA0_RLC0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
+		6 << SDMA0_RLC0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
+		1 << SDMA0_RLC0_RB_CNTL__RB_PRIV__SHIFT;
+
+	m->sdmax_rlcx_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);
+	m->sdmax_rlcx_rb_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
+
+	m->sdmax_rlcx_rb_wptr_poll_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, 0,
+						  mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
+
+	wb_gpu_addr = prop->wptr_gpu_addr;
+	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits(wb_gpu_addr);
+	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr);
+
+	wb_gpu_addr = prop->rptr_gpu_addr;
+	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
+	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
+
+	m->sdmax_rlcx_ib_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, 0,
+							mmSDMA0_GFX_IB_CNTL));
+
+	m->sdmax_rlcx_doorbell_offset =
+		prop->doorbell_index << SDMA0_RLC0_DOORBELL_OFFSET__OFFSET__SHIFT;
+
+	m->sdmax_rlcx_doorbell = REG_SET_FIELD(0, SDMA0_RLC0_DOORBELL, ENABLE, 1);
+
+	return 0;
+}
+
+static void sdma_v5_2_set_mqd_funcs(struct amdgpu_device *adev)
+{
+	adev->mqds[AMDGPU_HW_IP_DMA].mqd_size = sizeof(struct v10_sdma_mqd);
+	adev->mqds[AMDGPU_HW_IP_DMA].init_mqd = sdma_v5_2_mqd_init;
+}
+
 /**
  * sdma_v5_2_ring_test_ring - simple async dma engine test
  *
@@ -1233,6 +1276,7 @@ static int sdma_v5_2_early_init(void *handle)
 	sdma_v5_2_set_buffer_funcs(adev);
 	sdma_v5_2_set_vm_pte_funcs(adev);
 	sdma_v5_2_set_irq_funcs(adev);
+	sdma_v5_2_set_mqd_funcs(adev);
 
 	return 0;
 }
-- 
2.35.1

