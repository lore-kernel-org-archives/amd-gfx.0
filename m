Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06980C7EE29
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 16:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EAB210E18A;
	Thu, 25 May 2023 16:15:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629CF10E18A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 16:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDSpdSBB1bD273KuXK9qvT8fDhfWhv+IDLlroTiHZE1H3lNasIzHf11Mdo8m3nKyNZgjThxZMuVzXLxczfMmrKSaZ/lV4FIadjY1rp0n1RLLqfEXAzCCeWL6ET/6hbGJVoNCunW8+42jH35RDViH0jx5oyQFI2+ULRRSluh3cSDj3vRlld3wbO0zbVywBkQvMITuobaGgj7twewdnnUmkJfT+CfloCw7pEwX+Dcsbrr1ZFF+8HMhcekMYmvnP8eVkbGKYM10fc7jOE/QSRl/qLcSp23X1SRWwVArcNXYpH91XtJjvjhLxgGz732d6TpSQJOnnJ3M0APrUajeFlBkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZnfxN7PAobJ3ExTfrFNIXo/bWQEWVm7ilrkTgxyQ9Y=;
 b=YsZ9Pfpw67QZu6mpZT5WZ2XsH9Ft8GDJvvFcs3ZLtomXPaFodZMQ3O3YrguoG8fk8CXldoPLblnVRMlz/eXecUpPdkr5wprBumlpWEeb8mM5M5UbaZ7OsvE5osvLHdzex3vIhQL/4SRaILrkYNuOW/n3baB3bZJEu7wMVIIGejIfNP5uFA5fpeh9cdGH3Akmiwcx6RLVscd5joOnCQXFrENHq5Xx67GM/63q5OJPgDMdPHG4Q8maPmbcg6492jO8vT08EM1SqurLNMidBsNWBe+wAb/wSeAv9LcpNXMGTt1ahzENXoTyz5WwxYfe7SU1RTQ+HjjmIQtuLO8uhVxYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZnfxN7PAobJ3ExTfrFNIXo/bWQEWVm7ilrkTgxyQ9Y=;
 b=naVOm7SF8d7qFdECiY3/OScuqRBKAlEWYMgPW2qrBYbTSnOy0p9goVNBAplZZUaxj1H+LdUWs27bpA7OQcbBv7wswucytNTY3NPvRMBgKJl5bOCVaYhVHJy2rRV9nPIKTMbuXmR8aJ/nl5mZuNMM08Y614N/eNtoDF99A8DrU8U=
Received: from SJ0PR05CA0099.namprd05.prod.outlook.com (2603:10b6:a03:334::14)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 16:15:11 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:334:cafe::c2) by SJ0PR05CA0099.outlook.office365.com
 (2603:10b6:a03:334::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Thu, 25 May 2023 16:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.31 via Frontend Transport; Thu, 25 May 2023 16:15:10 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 11:15:08 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix up missing kdoc in sdma_v6_0.c
Date: Thu, 25 May 2023 21:44:55 +0530
Message-ID: <20230525161455.750526-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ca9dd1-9dca-4d49-b0f1-08db5d3b36d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOgAL4w31EleFyNns2m6758RMNXTBe9GL4WYPkivdSDjF44151pwozed3gOpHioBPT9HRpD18f39zx8c1Ywyma29lBY+jGOgfiGxXi8OJ9de2esL06368W4pnp7X+IPnotlcI6Az0vvA3/rzoxBup5J8n8vSYdlzH0R0z++meCLDtDA6UVd7a4GvJBwlHfQymtq2yz3rA0zTu3CXSA2+VLnQ8Cee+3iwRGszNzewdJw9ySka4qlFmfl3duMg3EMwsH0WlZ0f2Q6bHgdv0hx/Wr0bTek11ZXqswEZ35NjBAhl+ArGSqizMz5vuPOz6i7mVffzE47DXr2cw9zv0nC84bn/gRw1DEj8twlzscrKJFEZytH753GNKar4FHc11vZKYrtChquNPg8zBEg2SWL9iRaxdQjVw7BPMUtALV5jojgxvYzfvM5mXIC0KftS1+nXffA2AE1F+8TClMTdIvY34o4OFL8R5Eh6cR9r9VupYikbpCjSXqkjVrfXt/uK1LThdT948k+lU2gGrdt9Ijs89t8G8DghRNYZZkNDZ+rZ6cOyl+kCWGhGwyvawKEzMBu0H1jj3YzWMCehmQp9W2eK7D6MQLW7I+z7bR2lj7/7qO+xdNeKNS+fFREvFLnrWEkJQtpuymogHTONkYeuTt53TmiLKOJPfRNFlQCEhYvRipzu1h6ZnKymCo6V8Au4bGPp+1sWmwX/qpLTY1xHcUHKLeji858Ws7ipHmfpfzAwEwMCm8Xi0s/U39Q9ijxK0lcWv1swC/TgdnsoB3xU44PTJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(110136005)(5660300002)(41300700001)(4326008)(6636002)(70206006)(70586007)(7696005)(40480700001)(8936002)(54906003)(8676002)(44832011)(478600001)(316002)(6666004)(26005)(1076003)(186003)(16526019)(40460700003)(83380400001)(47076005)(2616005)(66574015)(2906002)(426003)(336012)(36860700001)(81166007)(356005)(82740400003)(82310400005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 16:15:10.6144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ca9dd1-9dca-4d49-b0f1-08db5d3b36d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Address a bunch of kdoc warnings:

gcc with W=1
drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter or member 'job' not described in 'sdma_v6_0_ring_emit_ib'
drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter or member 'flags' not described in 'sdma_v6_0_ring_emit_ib'
drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:946: warning: Function parameter or member 'timeout' not described in 'sdma_v6_0_ring_test_ib'
drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1125: warning: Function parameter or member 'ring' not described in 'sdma_v6_0_ring_pad_ib'
drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1176: warning: Function parameter or member 'vmid' not described in 'sdma_v6_0_ring_emit_vm_flush'
drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1176: warning: Function parameter or member 'pd_addr' not described in 'sdma_v6_0_ring_emit_vm_flush'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 1c90b5c661fb..967849c59ebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -238,6 +238,8 @@ static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
  *
  * @ring: amdgpu ring pointer
  * @ib: IB object to schedule
+ * @flags: unused
+ * @job: job to retrieve vmid from
  *
  * Schedule an IB in the DMA ring.
  */
@@ -938,6 +940,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
  * sdma_v6_0_ring_test_ib - test an IB on the DMA engine
  *
  * @ring: amdgpu_ring structure holding ring information
+ * @timeout: timeout value in jiffies, or MAX_SCHEDULE_TIMEOUT
  *
  * Test a simple IB in the DMA ring.
  * Returns 0 on success, error on failure.
@@ -1167,6 +1170,8 @@ static void sdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
  * sdma_v6_0_ring_emit_vm_flush - vm flush using sDMA
  *
  * @ring: amdgpu_ring pointer
+ * @vmid: vmid number to use
+ * @pd_addr: address
  *
  * Update the page table base and flush the VM TLB
  * using sDMA.
-- 
2.25.1

