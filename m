Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D32EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 17:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95F610E420;
	Tue, 11 Jul 2023 17:48:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FBBC10E420
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 17:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdeUI1jL42XKQkJGurqT6Ywn3ZEajLDuJnR+1XOxPz7R43+P76H7h1l49HPAfVxZKX7LSiUUFHXvnOBUJhiUoLeJYPigcSz5dVh264PBiCLhqIyuMZpcv0QKWN0IScwqWdHMjPcPS8nzIj/0ikvFgy1VHgqRs6/PTxID3hWS4NmSi2PHeA91REo8qP8ac4kk0K3k6akZr7fO6V+pxeDifwcBsp40tqdgyabceeF5LqY9R1OKcjhWfotMyL297wEvx2R+Yh6rhXqYbKWsOw4VOxQGu+k5XnFHCuMsil+fZUeQCjwlV5j5/rVzJnLJF3IBPyV0qFUZ1/lzy40ES6l7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYfaXYOAm+vfj5kGaB732tZxSH18wDV9tty+/5Pn+O0=;
 b=Yu8Jpz3mXpPNLyCK6jCs+wiRUsC0qtpHkRUlLD6bGjlsOa6aFyyht3qyjRx5fdfGvGitlD334jnBmEliMFhJXKOygKPLBcHobPMzHKB+BRuUpRhKS/NwW3A9t2rTrMp1D8UJT0WfP/NbRGAcsdQfW45i/QJGlJykZiICN6U+XpsQJANmsHCLTO/a+JCNDVSG65CFcduLlHS64BgMHbRoPs3I+ONUK2b7GjDZSi23cHdKeWrFHTKhdGR2J++ibPm8IoeKHvh/D/Y80EqyBYaIxJTrxOGotZ2K/QnOkixUZyN+FsTeEiSUvDa5E2AbjhQbect9hTn6hsgtZ0M3XFY2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYfaXYOAm+vfj5kGaB732tZxSH18wDV9tty+/5Pn+O0=;
 b=HCeS4aomyTnQpuVSbYH3MPYAhNpybJoc0eeayWhuKnmFHkprcdBiZWEJM/NANPooKK80BRfnRJPqPp21hnQjo8CLDwRdEmdZ5Rd1ofCBfYaY43CbNVeFeM7kkykBk50uEujz601ENJ22Jmyc/VRtx7QX/kNZYPwiYuqCcf17V4o=
Received: from BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21) by
 MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Tue, 11 Jul 2023 17:48:07 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:80:cafe::d2) by BYAPR01CA0008.outlook.office365.com
 (2603:10b6:a02:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Tue, 11 Jul 2023 17:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 17:48:06 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Jul 2023 12:48:03 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <christian.koenig@amd.com>, <leo.liu@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: update kernel vcn ring test
Date: Tue, 11 Jul 2023 23:17:05 +0530
Message-ID: <20230711174705.3945441-2-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230711174705.3945441-1-saleemkhan.jamadar@amd.com>
References: <20230711174705.3945441-1-saleemkhan.jamadar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a2cf75-a82f-4b01-f8d1-08db8236fbd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtEUENVZP+xo8mUB1uW6EWAEHNQ5/gkMLCAIs+PiESLk8fWCGNdGkmPg3sAnMdD77ovitA/5KRSvE2mfwIHvLKdxRV1iRyZGmhNiUg5QCEhNeVwheGHpUGkB56UqmG97c2HcnxMeIGOONx56MqikxsGkf/dnnxSuuk6GiTHu+utnRhpLloHl+oRtTu8HlDn7jYlcNeVs+2FNllQG8TRB9cq1VeM9oSe6zxGhCQx2tUqjSjcnypZIgnJzja1yA7iBgpcNouAmAku6VXL04Olx70dbCN5yJPgy1rjH0L4DAQsQ2FYQGxSlWSE4aAShwnvNqEmAtVDTFAY0M4budxTHOWeSjTYvZ4pvcrnfEdOZkjjezu3acZuh5oWVB1sApkcmXtS/mvhQ7TxRRStlpwllQOfOLraciXqGyv3T5kT+PT4qu3H/OwwzhhDxUILriX2ddZ+4hUoE5fC8wrbgaADW9NxWT8w5Gy8HLUHqyxKPFn0wpfn5+id66iAyOyIAZ9W0dDBICbIcyLLn0fA2OdN8dNw9pxr/rwujzCiko1DaD23YFPtcFuPrlfhWKFG5UgQtEbiEkVfOsb6lchpJDZcbmNe65psh+IzcX2E07+5AdG2v/8MJL1RACAKTNvfxsGh5G0tH/eH2/O1KFV1jh+FWM5BZRhIInRWIBleO2y9tRPviJVx99A5u+7lBOdAiAArJryNqbOOldwkZIMTl90997OqhHeRtgJTVclOx06HzUv9oYaibwenZbSLdHtoDNd+QdxCZekHjsiwrYbPD84F/zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(478600001)(83380400001)(47076005)(1076003)(2616005)(16526019)(186003)(26005)(336012)(426003)(36756003)(40480700001)(40460700003)(36860700001)(316002)(82310400005)(2906002)(41300700001)(356005)(82740400003)(81166007)(70586007)(70206006)(6636002)(4326008)(86362001)(44832011)(8676002)(8936002)(5660300002)(110136005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:48:06.6937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a2cf75-a82f-4b01-f8d1-08db8236fbd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
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
Cc: sathishkumar.sundararaju@amd.com, srinath.rao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add session context buffer to decoder ring test for vcn v1 to v3.

v3 - correct the cmd for sesssion ctx buf
v2 - add the buffer into IB (Leo liu)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 8966ffb2f4a0..5c2aa925dd79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -539,6 +539,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 				   struct dma_fence **fence)
 {
 	u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
+	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
@@ -552,13 +553,23 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
-	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
-	ib->ptr[1] = addr;
-	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
-	ib->ptr[3] = addr >> 32;
-	ib->ptr[4] = PACKET0(adev->vcn.internal.cmd, 0);
-	ib->ptr[5] = 0;
-	for (i = 6; i < 16; i += 2) {
+	ib->length_dw = 0;
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data0, 0);
+	ib->ptr[ib->length_dw++] = lower_32_bits(session_ctx_buf_gaddr);
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data1, 0);
+	ib->ptr[ib->length_dw++] = upper_32_bits(session_ctx_buf_gaddr);
+	/* session ctx buffer cmd */
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.cmd, 0);
+	ib->ptr[ib->length_dw++] = 0xa;
+
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data0, 0);
+	ib->ptr[ib->length_dw++] = lower_32_bits(addr);
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data1, 0);
+	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.cmd, 0);
+	ib->ptr[ib->length_dw++] = 0;
+
+	for (i = ib->length_dw; i < 16; i += 2) {
 		ib->ptr[i] = PACKET0(adev->vcn.internal.nop, 0);
 		ib->ptr[i+1] = 0;
 	}
-- 
2.25.1

