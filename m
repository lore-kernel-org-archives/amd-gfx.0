Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144B9EB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 08:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0F210E0DE;
	Mon, 10 Jul 2023 08:24:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A0410E0DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 08:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDzrkShGQfVfUJXcWsEpBdQnwNOJt6JHjtKeojwNSrGRlTm+ZCHl4shQemun/eUY0rHzyhJsywW0gfsOejzJ1GG9xnNKwKA3krrxQNwgECnNyW+73TCujbHDS04Cg2H3Es5cEtPYQIdrpc59Sj6KAXsrPf1n0kVPstmPPahA8+7K3xaxmPG9VoD63ji4whMqJL1x8uN9rKs3k1bzths0wUSd0w3pbc5b0vO/U608EHEey1ATlhWcelrsDWpLFIYtn/mcEZwXryqQaZz+I8SizsZQ6LJAKk+LaxbyhpQZBfCOwA7h6rajgi9nAQc8sY6jXVl3lwPX31Y+0Azac1nPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BawO3/CYp8t1m5v1BbdeSNTpGHf4xTHmIh9u5f3zf/o=;
 b=HoL8akSJxuimBrAVMG7KiUeUyFjecMb/aGlvmJYgZ6Qk8yMMqwZeRom+r6MfxerY4vszH7uoL1Fr3YM03l59379/F05JhNqgRmPZE70KYyFVXXJHZCSO8B1vK4oTKtQaowOcXIxB52ZuhZbc1PNZIHifgdXPfR8LI2KwlQIbucHSDXsMq16l4ORzp9/GEsW1Ja31xxyLE/7WAV0v2GBdm8Q+hc39rE0SNwG1WmM1feEH4al/hTvBDjjsllVtO1GVmemwwREheAPTIb46oSnQttUA2MvtSDHkOBVUAy6zGvcwJDKKS6KeDVDEL0eix2MKuT1jXQZIBZp9SCyEn5Q4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BawO3/CYp8t1m5v1BbdeSNTpGHf4xTHmIh9u5f3zf/o=;
 b=V/pHBCIJK66+VHtArjnCEzJdtjuhHAq45aQIXhGopSn1at1s/sx8h7Vttv1ZAI3dFF5LQUbWrn5wGXQlweiyOx5rDiCRxRjhdonqoGfgRdG+25NSGBcoD14yDltmSnUxkzc4tKn/Zdcm7VwQM0Z3/OM6v/P9nC1jsB5PnWbrRuQ=
Received: from DS7PR03CA0356.namprd03.prod.outlook.com (2603:10b6:8:55::22) by
 DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 08:24:25 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::90) by DS7PR03CA0356.outlook.office365.com
 (2603:10b6:8:55::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 08:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 08:24:25 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Jul 2023 03:24:22 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <leo.liu@amd.com>, <veerabadhran.gopalakrishnan@amd.com>,
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: update kernel vcn ring test
Date: Mon, 10 Jul 2023 13:53:57 +0530
Message-ID: <20230710082357.57516-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|DM4PR12MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: 9625f218-a831-487e-d0e2-08db811f125d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyyTeSgtGmupwxEwRUFPO04amKtSFvV9GfNc136a/HRMw2tHaF8uJtVlabVcwzhNMKgMMs+iyYV3m1LAQvGJgOwqnIjmDjsoS6yYVB0QJtlgUz4AXUS+omkIrtHYqSw4pAMMVqBcpgLL+MXoNtzls/nLtF0wZLBs+LunL86X3SyHqKcUPN5fX9ddY7ohi5AZ0YLC3MaFiYXzZfgLebfeO62s4DOXFS5Sq0W2ywcq3uoNkfki7PMwDXj6u2d5PghuvW4oGaTFCfsRQFbPRo+zWRgsjSYSet44n6krzci/cq/EBmSu1f4RVpq2X/I1m/nqnXvdRDYHlbYbryGw11IkI2sDGZ1l/Z29TRm7HYtSRmoz6lSfhNdvX7/OnHL4OSgmC1uYCwiHgOMpt1i2VUlHIKJYc+xw+jpU4Ty6UPamdOl/7eWMdmzxSyeRqQ69J0bo4tMBzZXs93OIrc++3IG47hnIOglxBHqWowfB1ihK9p9swUbO4EvhrwfYnh1DWMLuhrAzxasgQJyHJtNZvrsaCELr4TlgWOuVJwmhgRjyROUg1NnNSQIc66tVgOLU8my5GsKYKt08AW62sAoU3CRA/lTqT6BIIvTIQ5PUgJJ7BXlK1Cu6VAZw4yzIdV/sTPnvE7cTma9DVCyYAbEdzAhLnqhCCWoo8afAeJwrzV2ypV4kyzIwT10ycjElh2HIhk4bGZqr6RVipKB6EeL2tTxw5zPlTDOix2m60ysLXGbU07fkzjU3Uz3A5WFE5MMIcaSgIYmurFw/pCBH4jcqLhcMsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(82310400005)(82740400003)(40460700003)(40480700001)(36756003)(6666004)(7696005)(110136005)(54906003)(70206006)(70586007)(81166007)(356005)(36860700001)(1076003)(16526019)(26005)(186003)(2616005)(44832011)(5660300002)(2906002)(316002)(478600001)(8936002)(8676002)(47076005)(336012)(426003)(4326008)(6636002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 08:24:25.4383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9625f218-a831-487e-d0e2-08db811f125d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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
Cc: christian.koenig@amd.com, srinath.rao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add session context buffer to decoder ring test for vcn v1 to v3.

v2 - add the buffer into IB (Leo liu)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 76e9a2418286..4c44d76f69de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -521,6 +521,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 				   struct dma_fence **fence)
 {
 	u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
+	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
@@ -546,6 +547,17 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	}
 	ib->length_dw = 16;
 
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data0, 0);
+	ib->ptr[ib->length_dw++] = lower_32_bits(session_ctx_buf_gaddr);
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data1, 0);
+	ib->ptr[ib->length_dw++] = upper_32_bits(session_ctx_buf_gaddr);
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.cmd, 0);
+	ib->ptr[ib->length_dw++] = 0;
+	for (i = ib->length_dw; i < 32; i += 2) {
+		ib->ptr[i] = PACKET0(adev->vcn.internal.nop, 0);
+		ib->ptr[i+1] = 0;
+	}
+
 	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r)
 		goto err_free;
-- 
2.25.1

