Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759C9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 16:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4BE10E11D;
	Thu, 19 May 2022 16:22:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A4D10E11D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 16:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ+v9p9bXADLd+uVz0Ba0Np9Rwfg86anBU9Nvvzx8KNWo83WwQ3tzb28mPoshqeK4IQiBbBdZVlcWy15bqoVWjAByoiOed2WpYxVYTKcug+ZmiO2qQZOKtW18CLKyirUqYcAB81HyAL+wCTtdarIrO4/u9gLJzzHwpwA32qAQsC8/r94eP8uBGoF3vN/+FCyGEgrqorxx031guYLShsH6a2bWDK5TOr/eolrUwKwQOfryuI7D5XqAlk1oucUiLTwGIRuRBkXprw5725hifY3Q9Pvg2rL4oHzxRzzHmZFutk54WHp44aQVZ3FfhCGOPFtv+zQ3JLqyOG4FfjV5XRcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbBfEcHrslQL9k/a+yfcX9y0r0B/PId2yP7hcetEaFo=;
 b=QCRead7aTHuvq0wVd2xYNzHjBhxY+OBKII5F3I8bSQ3tT5YS1T8hyzXPScRVf2bLp91XboLAP9PDJGh9h87hQZS2TaE//NQh4uEVqRHT3eYCUOP1UsD32O68vtrY9hj2UcYlZSHBr0wxZwb9mPKtblcWGFYgXWagLKHdRMjSQ8+K2Lgnk+dP9A+krdtoFM7nMqYnVU/5IdMWXIGyz2PQsAaIiSgRXKia3KvigTjHxPsHgqLa2ZNrlTY1aGtSYn00wEX98mxI7tOjPKwgG8jCahMkKE0B9gSllTBJpr3FRz+eYPAAYCfGa0ZHzcqGtjhsrmNxcZaVoMej8CI0zfzyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbBfEcHrslQL9k/a+yfcX9y0r0B/PId2yP7hcetEaFo=;
 b=PB1O9j2ngRJ1gw9bYiQGBOnfN04i2ZGP5uVWPbtoa1W7pZDISZP5lEm7gucuyLtJISEanP8/8Zpva6CmGKp9D7kW3hyX5dTvfhaWzjiJ5g6Rx/tH0Yl3tzF2/xmAXF7pdPNJ1LcEbFzLTj+M/0MxEG1LTXrR+lIQ/KVRqFkWZlM=
Received: from BN9PR03CA0533.namprd03.prod.outlook.com (2603:10b6:408:131::28)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 16:22:28 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::8) by BN9PR03CA0533.outlook.office365.com
 (2603:10b6:408:131::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Thu, 19 May 2022 16:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 16:22:28 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 11:22:27 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: remove acc_size from reserve/unreserve mem
Date: Thu, 19 May 2022 11:21:52 -0500
Message-ID: <20220519162153.6268-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbedfec7-68f6-4454-8b6c-08da39b3c44d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447A8DA4E34DB7092A03962FDD09@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fKMQTukBGn4ufss8x1VuIrOQcPAfopDCa2WNHcahF9gbM58WmWyFRXHyFj6ogqUNeaMaQ79bG3PrBBck6T3TCnXX62Eskj8AybDD9MN4lzyU97VTFrJkSNsHMRtzWxmtdyubvlO9/BSoa/ASxFs5OfdqUJswN2K3BrHPZjQpi2O/XlLr3r5Aeb0HuQtjSGSxYExrj2Zd7ofolAfex0X1Shx/jsildDls0nIMZERnfAdAUthUuLjgypViulajq5aYfJdqa1i6tzacWxaRWBKXSmeFDK9gc9m6J/3VVQ+IoDz3tvuh0c9sfthN93mMVvjMDKTXxg0bw2rezUiq0Pz+tsHOf03GO/Nb1T032gVS633aUhzDeSijimzyxsvCNT7w/yXjOvvFhrZVnyNQVoU82osWJSVUPaNAOjsNtxEqYvYJ05to0WKQj2IcOADWKBODFWICnCma+3lm+OscbZShP4SBJbIayg5w7ARJwbIXBdWy8kGXUiz/HkTk60Iyd3hBl4kcCFZjJ6gdhnQCEBeeTDw6xkfzLej7HNIUV4L/v8Wc+VSkoDiOaR5FcHBxHvqugWxGRhg9lB8jSzZ+cWJuPgJR2K0Y/eLMhKMHQiZySJRMFXDnMIuYUDzN2vmd4ql0uNYOzu7A6eVNeDKSfWZylSJSZWf8v9pcvv6ipF6nFdYMxMZ4v8OduffAqYLTy86Bvqev7KPcIGu0ztoD0kI2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(356005)(36860700001)(8676002)(86362001)(6666004)(8936002)(26005)(7696005)(40460700003)(44832011)(5660300002)(81166007)(70206006)(70586007)(508600001)(2906002)(4326008)(47076005)(1076003)(36756003)(316002)(54906003)(83380400001)(2616005)(186003)(6916009)(16526019)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 16:22:28.0910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbedfec7-68f6-4454-8b6c-08da39b3c44d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip Yang <philip.yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TTM used to track the "acc_size" of all BOs internally. We needed to
keep track of it in our memory reservation to avoid TTM running out
of memory in its own accounting. However, that "acc_size" accounting
has since been removed from TTM. Therefore we don't really need to
track it any more.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 59 ++++++-------------
 1 file changed, 17 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index fada3b149361..966714dd764b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -108,21 +108,12 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  * compromise that should work in most cases without reserving too
  * much memory for page tables unnecessarily (factor 16K, >> 14).
  */
-#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) >> 14)
-
-static size_t amdgpu_amdkfd_acc_size(uint64_t size)
-{
-	size >>= PAGE_SHIFT;
-	size *= sizeof(dma_addr_t) + sizeof(void *);
 
-	return __roundup_pow_of_two(sizeof(struct amdgpu_bo)) +
-		__roundup_pow_of_two(sizeof(struct ttm_tt)) +
-		PAGE_ALIGN(size);
-}
+#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) >> 14)
 
 /**
  * amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
- * of buffer including any reserved for control structures
+ * of buffer.
  *
  * @adev: Device to which allocated BO belongs to
  * @size: Size of buffer, in bytes, encapsulated by B0. This should be
@@ -136,28 +127,22 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
-	size_t acc_size, system_mem_needed, ttm_mem_needed, vram_needed;
+	size_t system_mem_needed, ttm_mem_needed, vram_needed;
 	int ret = 0;
 
-	acc_size = amdgpu_amdkfd_acc_size(size);
-
+	system_mem_needed = 0;
+	ttm_mem_needed = 0;
 	vram_needed = 0;
 	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
-		system_mem_needed = acc_size + size;
-		ttm_mem_needed = acc_size + size;
+		system_mem_needed = size;
+		ttm_mem_needed = size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		system_mem_needed = acc_size;
-		ttm_mem_needed = acc_size;
 		vram_needed = size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
-		system_mem_needed = acc_size + size;
-		ttm_mem_needed = acc_size;
-	} else if (alloc_flag &
-		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		system_mem_needed = acc_size;
-		ttm_mem_needed = acc_size;
-	} else {
+		system_mem_needed = size;
+	} else if (!(alloc_flag &
+				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
 		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
 		return -ENOMEM;
 	}
@@ -193,28 +178,18 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 static void unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
-	size_t acc_size;
-
-	acc_size = amdgpu_amdkfd_acc_size(size);
-
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 
 	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
-		kfd_mem_limit.system_mem_used -= (acc_size + size);
-		kfd_mem_limit.ttm_mem_used -= (acc_size + size);
+		kfd_mem_limit.system_mem_used -= size;
+		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		kfd_mem_limit.system_mem_used -= acc_size;
-		kfd_mem_limit.ttm_mem_used -= acc_size;
 		adev->kfd.vram_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
-		kfd_mem_limit.system_mem_used -= (acc_size + size);
-		kfd_mem_limit.ttm_mem_used -= acc_size;
-	} else if (alloc_flag &
-		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		kfd_mem_limit.system_mem_used -= acc_size;
-		kfd_mem_limit.ttm_mem_used -= acc_size;
-	} else {
+		kfd_mem_limit.system_mem_used -= size;
+	} else if (!(alloc_flag &
+				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
 		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
 		goto release;
 	}
-- 
2.32.0

