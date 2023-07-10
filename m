Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB59FEB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 16:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 526E610E26E;
	Mon, 10 Jul 2023 16:54:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B0010E26E
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 16:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9YidETaCrfYGHuuUb9q9tYVeKuuQwZDkMCD8k/rgE5vBUMFKA1UsJ80XSlNIsztqj6+xoGcDTY77q+ecWg5MvbfWsODB90P2yXOGuLphKwkLfNcCNRD1rKtUYNRu6FN/xJ+SvL0XvPJV++GwKQTQgE6NUusJxxTlNR3tEPxkbvgxcKt+udLAL/BKZLByDjIMkCJPoSweuP6B7YNLPnk6O+C8yg5Na8ijh3ntGEPNPN7aXFNkcR1P65CUQ1VwVMgrMhf5Dossk1WD0W2nwiWLOPQeIzauC35Uod6EdQM2iau0gcJEhRpTndbFblBw78mreq1rDlliFYRXmjkNnWzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xKMgPNg8ld7mMXWcIVBqEg1IdcsihtmTAynSa8zyrM=;
 b=EuXdOK3QQz9fS8xx1NpNNf1av5zj4f7tYUUNMOjRyERGW5nWPC4Lq4NSI/cuRkrsxHPJYbumiT6k9j1sUWhSZUPfHSR5kROYXRUR6Kqr6H3HmJqfR/MWor+nrc84+xDque6t7PwQYGfbomMUNmyve41dRc3bKlkJLEew51xbmUDuesKZKwH7zy/4NLs63Sfco6l3AF7POTbNFNCpxgpPt0Hj7cl0ylbOL6rIRdiNGGdib7St8mF2CoPU0PNnCYUfV0fRhBOzhYprbFIYholLRWNQflRA5fM8JvehmUozyY6IGg/xSknS+NhRhRVVFWl1bzsS7pcDoz1sJXx0TWj6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xKMgPNg8ld7mMXWcIVBqEg1IdcsihtmTAynSa8zyrM=;
 b=PpK6bHI+dXkWco4vGweTDcAPVGJGFKLCKhYGFHEqQt9rK6xY9I3O3kIb17RBKt/pdG4y0dOyv0a2qcJO99rw2kU/aHeTV7arC6U1S2SxBAlNK2nhCrRf31UZbpJZIUpoSmF7ZZfuDTgkKq3lEljfueWYZETSXhJrpf1p+R6h1YE=
Received: from DS7PR03CA0352.namprd03.prod.outlook.com (2603:10b6:8:55::32) by
 BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 16:54:45 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::f4) by DS7PR03CA0352.outlook.office365.com
 (2603:10b6:8:55::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 16:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 16:54:45 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Jul 2023 11:54:42 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <leo.liu@amd.com>, <veerabadhran.gopalakrishnan@amd.com>,
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: update kernel vcn ring test
Date: Mon, 10 Jul 2023 22:24:25 +0530
Message-ID: <20230710165425.257696-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: d4703b79-c287-4d57-2334-08db81665d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hh7Mc7t7lZMAbkiJ+iMN65RCZ1RxFfalBFFvX3aoQAP545fjObBRH/zVgPJa/k7cOCgyc3meWHCBebgCCLUgCSVJuIzPMWNbrrn9tasdeEVlZZA9XFxgB36xu3KiWmwy7bzxvqZ0GbXYzDL765fDJF75ML7+0ZEyHUpE8MuVD3Q0ECJLw+dHpr+2d3HEEmwkg3Sj6Pcpzx5/upGkgORSF9jziEaXGTLAfzJwaaVeW8M6Y4x+mOpZl328ta/LOP0JUEIKhYxFQFpX9kH78Xf3GbqDfNIJQrWSDhh8ytyvRVH3HHM1Lis36mNRG1vfpV8n+SZ9SMXIZnMbA1XH5TSV59H2PCUcMojepJGjOLTsMIv4M964kTiNVoX96Tm7dGT1MPo5T0N6CTwaBPh2Php1pI+PR95mPm5iTEwPnWbkuEUAuNELuaYcKyjk3Oa37wwk4RAiq5ydP1bYl4mkbp3MzMSOB6jAWRL1jMTlCXu7vFNjNWpapYGYicthVF5iFmnn2YLcqcd18/XA1uUwPH9nVDPjdVHiZ4vtngwh9CGXV9X5PsEMVNmSfrxXpQdQtoixyKljXxS9hOb945pHTCnFfZ+dMHbDw0JK627/cfBWJTVNkhzz/r0IvQGn+olmKT1/G6U+hgxpwPZt5FAU1GTdb/jnnj3bOllm4VvZemvr+RDSJZSVvqRqywQuiCSXmrk3J/VKcbkDZ53Y99N1RBwqfuvnydDXuEsLSQY5GeeZPD2hG1YXuWCbdk995OUj1DL1wfYQDXjDyJRU/tdN/ZZs+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(7696005)(478600001)(110136005)(54906003)(1076003)(26005)(70586007)(186003)(16526019)(336012)(70206006)(2906002)(82310400005)(41300700001)(6636002)(4326008)(316002)(44832011)(5660300002)(8936002)(8676002)(356005)(81166007)(82740400003)(86362001)(36756003)(47076005)(36860700001)(2616005)(426003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:54:45.5046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4703b79-c287-4d57-2334-08db81665d59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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

add session context buffer to decoder ring test fro vcn v1 to v3.

v3 - correct the cmd for sesssion ctx buf
v2 - add the buffer into IB (Leo liu)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 76e9a2418286..4ee5f933e420 100644
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
@@ -546,6 +547,19 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	}
 	ib->length_dw = 16;
 
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data0, 0);
+	ib->ptr[ib->length_dw++] = lower_32_bits(session_ctx_buf_gaddr);
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data1, 0);
+	ib->ptr[ib->length_dw++] = upper_32_bits(session_ctx_buf_gaddr);
+	/* session ctx buffer cmd */
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.cmd, 0xa);
+	ib->ptr[ib->length_dw++] = 0;
+	for (i = ib->length_dw; i < 32; i += 2) {
+		ib->ptr[i] = PACKET0(adev->vcn.internal.nop, 0);
+		ib->ptr[i+1] = 0;
+	}
+	ib->length_dw = 32;
+
 	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r)
 		goto err_free;
-- 
2.25.1

