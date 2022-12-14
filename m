Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FB8C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 15:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEADE10E41F;
	Wed, 14 Dec 2022 15:43:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C50410E41F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 15:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu2gc79bxa1vpJSpChsKByLx1JBOqFMmp/BuzUjZaQT1N6EPPNiPmisscbYaM77u8cZlvGGqxrctLNEtCBK+M5D5NkzEaFHk5OCAyiiKXppdBt6cwldoz9UaD9KV1+xhCedHhrqdLJ63MTfWbEsjt/CO+bssTUSyoLKqgcKPaaoa6AVa//NXDn9GXUFq8P3katZO8bHS9UrC8tvKW5rfKQg6UNn4VbRipqHgFtwwnnez8zK/zCL+hBCcmhpGjkjtMifpa4FzPIFwjXrFeGz+KpiaAz8dgcyx2GWDQb/e/1+7TpW0Ybj+kWZx8nAHim/PiiiM2CgJLXoF5Zx+mmJ23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN7jt/ixnPsMMTMksXIQna5EBXNRqDHyk2klDTMkIjo=;
 b=CBulLFwWXIgWdiF13zrW8GUkQJ3oVCrdG1aRwi/6wU0p4YHpgBhQGFa5H5XqHapwXeD676lKxFfdLvqN7yCaX2ygRbu40txGWADny9o9UpCb5YiUlue6NxAyKO7+YSLBgf6wPCNqoveuD4ilfcK/GSbKHYBMusjv5yDkZZQ8m2x0eYwVsfhuvKlm7xtqPfq2EWHmf+luijchsjzOPfy13ImTFFCFRhf0umOIXUXjFRylN7B3dkc1aq2j5yHWl5/2VLQDXVWQrSyYcXLoYK0ILJo99xeTVP0DA0I0Uk4W8GqTnywMnrKmg5VLw7V9sxFIWhgry755dLbTw0Enot5Mig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN7jt/ixnPsMMTMksXIQna5EBXNRqDHyk2klDTMkIjo=;
 b=bFzAwfr4wv6jvLCy3p9CN7pcgErXG8s/u9xTpc6HmOyxyiXgV1Q1zPueCg7zo5lscWuBJaObKaNj7ad6v5YUg3ez6LSRTFk+J8UBVOqWhyTadR3Bp/WlBFQ7Mb69aVOdzxlWpGxU9SNIW9l40jKXmc7MMlVCU+oTLZd+/MaPdLM=
Received: from DM6PR06CA0006.namprd06.prod.outlook.com (2603:10b6:5:120::19)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 15:43:16 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::16) by DM6PR06CA0006.outlook.office365.com
 (2603:10b6:5:120::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 15:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 15:43:16 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 09:43:15 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: Fix kfd_process_device_init_vm error handling
Date: Wed, 14 Dec 2022 10:42:48 -0500
Message-ID: <20221214154249.2981-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: acc70551-7e89-446e-6e2b-08dadde9eb0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LJE8JT1FBs1V5MWwfs4cqlfCGd+3jS4IiGFcjn2gm0IWsu00spuAhy6T2qDWbLglrUYCReh2ToM2aAWw5BDvPVsMlN1NWN1a1ZQgRziV5EY/sOnIJ1xkxcI9fwGT5fAIiEuBEQaVZ1z1rtGZ7eTFAXoHMHXQP+sElkCaDnRj2Rwy3iCuWodv27S/H1pjnG+Nqnzcm5ve8YoAZtW75f6mn7dNJFyW887HYJ2cVfxY6Te3H5ziGhkwkZS6vXTRPjpbNXvTSy/M4PhnRo6i7Koegdj2Zr8GuiZ/ykn0rHH5LfIRdxAogjkQV4zHdR5yTcQuQy41UCyEnMXQHv8H5SWwiuammF/E6sAuriSnj8KA0F5s5BAtMiO8FIhPByqTvvFin/LM37VfQ5QUeGwuK5XxbTU3HUxRj2FrZ6uadu1u9kF/0oFiBQzxf+hyYc8Wdst3fIcG3RCkBlU617KV4li4b51uIeAJEDaSrskT6aw9Jl4h2Ek23/0lqCeT+T+0LxukuK+UwyZYivtRTmy2VyI4pzhZd8eV32IIsbALZlotmkrT5iqHTQyP6/nIiyrfuKkRcIn0zhjDovYLAhq5FrT4pO4pDgCCw2soLq21TqGtQRo7XUAEXz4QSe+ojROqS25+B227oyBaY9e2IpstclddqWgmefX9SZqwkY0ly6rwLiIbGfo9jB1mfPLdCyEZimApSiNufVkUSQj9vElsQE1jyCptJZATlPWSPdOUpYk5Sc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(6666004)(8936002)(54906003)(5660300002)(426003)(47076005)(82310400005)(6916009)(2906002)(36860700001)(316002)(16526019)(41300700001)(336012)(7696005)(478600001)(1076003)(86362001)(2616005)(8676002)(70206006)(4326008)(36756003)(83380400001)(40460700003)(70586007)(26005)(186003)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 15:43:16.6275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc70551-7e89-446e-6e2b-08dadde9eb0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Should only destroy the ib_mem and let process cleanup worker to free
the outstanding BOs. Reset the pointer in pdd->qpd structure, to avoid
NULL pointer access in process destroy worker.

 BUG: kernel NULL pointer dereference, address: 0000000000000010
 Call Trace:
  amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel+0x46/0xb0 [amdgpu]
  kfd_process_device_destroy_cwsr_dgpu+0x40/0x70 [amdgpu]
  kfd_process_destroy_pdds+0x71/0x190 [amdgpu]
  kfd_process_wq_release+0x2a2/0x3b0 [amdgpu]
  process_one_work+0x2a1/0x600
  worker_thread+0x39/0x3d0

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a26257171ab7..6caa9dd57ff1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -689,13 +689,13 @@ void kfd_process_destroy_wq(void)
 }
 
 static void kfd_process_free_gpuvm(struct kgd_mem *mem,
-			struct kfd_process_device *pdd, void *kptr)
+			struct kfd_process_device *pdd, void **kptr)
 {
 	struct kfd_dev *dev = pdd->dev;
 
-	if (kptr) {
+	if (kptr && *kptr) {
 		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
-		kptr = NULL;
+		*kptr = NULL;
 	}
 
 	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->adev, mem, pdd->drm_priv);
@@ -795,7 +795,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
 	if (!qpd->ib_kaddr || !qpd->ib_base)
 		return;
 
-	kfd_process_free_gpuvm(qpd->ib_mem, pdd, qpd->ib_kaddr);
+	kfd_process_free_gpuvm(qpd->ib_mem, pdd, &qpd->ib_kaddr);
 }
 
 struct kfd_process *kfd_create_process(struct file *filep)
@@ -1277,7 +1277,7 @@ static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd)
 	if (!dev->cwsr_enabled || !qpd->cwsr_kaddr || !qpd->cwsr_base)
 		return;
 
-	kfd_process_free_gpuvm(qpd->cwsr_mem, pdd, qpd->cwsr_kaddr);
+	kfd_process_free_gpuvm(qpd->cwsr_mem, pdd, &qpd->cwsr_kaddr);
 }
 
 void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
@@ -1598,8 +1598,8 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	return 0;
 
 err_init_cwsr:
+	kfd_process_device_destroy_ib_mem(pdd);
 err_reserve_ib_mem:
-	kfd_process_device_free_bos(pdd);
 	pdd->drm_priv = NULL;
 
 	return ret;
-- 
2.35.1

