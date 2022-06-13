Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B897C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 08:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D7610E671;
	Mon, 13 Jun 2022 08:00:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6FD10E99F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 08:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv72VZWuXtTTGRkNxnfORX0FCqvVxaZeIo+SoMFCCu09wqRbi8uFry+mLSqSlEbpzyBA7pT0vnvAl0GrfYugm1On3X+grr3ivcG1Pd1uaj+icilmfxshNtd2NmucaLrj5eHJMEtXMQpnaCh/yA/ajFgvgO4yLsgJRwSzt6Iq77tZgTBjtZj1VWvtIGaKaUtAyNGpS6Tk8a3UZlHh3L4J693pLSrE5nGbG/kWhfgFHI+AQIjZWVZuRyk2i/RkFfKpxI47113+7d64ByYp5SwuqWPYlrNj8tb3fAfPuM0KZo4QBrYo5LAAfNJBN5cKTNbfece+HKRfP9ejorfC/xBdTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRigQzCoRqtN3prfTI8Prcth/iv2aXWiBJMf2NThxCU=;
 b=CiRFyz5VpxUsIJ1vk9qIEco4AnjSHsN2m1CibG3n40anYLMG9j4/q5XYt/+eqyKyaAOk/XR4SdbsOnznqseNLLjsDhPu2HwYd4hSN+NrwBGWgG5btNIbIsQIIFwMHMeHuWosm8duEEROWkIOD+8XxE3X3cISOPFimfcust8GUdz9l78x0eh9rmaKlq2ExZZ1fM8+btSeRtqMfOfKmChzb0OyE2VHk/eKfnLaSZc5EjjkZU4AsLHRvI5r90wlSGyzkY14NWnUUwE1bJeCbNBPj7RdqQ+2O/egBkWAvNuchV2CWIFXY9fTjhupBDJ8TTES29fVXvQHciWJjTtl6ggRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRigQzCoRqtN3prfTI8Prcth/iv2aXWiBJMf2NThxCU=;
 b=xz2kQCWQQYr4ZKCckvzZDLpV51RoUvSRc9RyNRMI3zxhGA/0dbzTnNCWbdVyL7RqyNOCxPGeMimwQRXd1SoFWKh+riQD5hQIdgB5sEaHouYhEzBmqzmJqqRIVDazUyciGe/HCLR09r+vQKsFl8TqhNc8fjbxzyYWTOq//QE640s=
Received: from MWHPR14CA0035.namprd14.prod.outlook.com (2603:10b6:300:12b::21)
 by BN6PR12MB1905.namprd12.prod.outlook.com (2603:10b6:404:fe::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 08:00:14 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::53) by MWHPR14CA0035.outlook.office365.com
 (2603:10b6:300:12b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 08:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 08:00:14 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 03:00:11 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: simplify vm_validate_pt_pd_bos
Date: Mon, 13 Jun 2022 15:59:56 +0800
Message-ID: <20220613075956.720375-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e217861-d0a2-4148-d1ea-08da4d12bf8d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1905A05CD34BB2126CC6C91CFBAB9@BN6PR12MB1905.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wI2tFUeCC+dZpRol+pA8wXPjbR58QFH9qOfeb2gRvgL5F54h4clfiyW5UkzNqM5/97aPWvU+lMOTvU3ZgaPEeam6ghOGGlQm/5kLC27fa1Oxq09xzyBDK0r8dbFLHlS0FEfwhEgHVDh39KfNXrK/Z3Ed/KQKfrywyycGjXUMeea4p7YjSJGUtimuDFmdXXSdMI6Of5/6P05x5U+qkPS8fMwkDtB2WCpSty/93Yz6PwgJm78fir8Zujpsr8E0GngeZVo6sTuG0P/a0amTnSriicYiz6fJPZ3u0rZ9RDJM6cWnvMIOSjUq2h/ykjT44NKV3eJdp57Caj9zLLIdcuy9JjPnUCthUuc4Uw5/K40pV53pZyFjgMgx/pTdPemQddvcM4cxRL0wfmd1LjcGV8sKVOF5bHbrCtyd7d1iGdIW3IUMSlzSTJlDpl1P6ojRCa2e3IG5MjTop9kVZbletU0jjdWNjh65T2vxQRTrQ+OZdTBdAFmmaFj439n36FxkEyx6ZzNlrEaBCt6VThaQKWelIZB/MVymQjaheY+lqmEx5IlSpER1vzXDWoZyrHkHQR/U32b5plSEBvh/HlFQZHd+3BPPkeGoVxxxEx7WQghuYSU4UXCcJf0Y+rrH1++DxajLpmfuVxS/9shnWX1qUSCvNvESPMdlyEJVhm0B8tzyRmsQUcKIHB0oA19r34oeIEkH17v8v3tB5z/gQmtAZM9Mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(70586007)(508600001)(70206006)(316002)(6916009)(26005)(54906003)(82310400005)(86362001)(36756003)(5660300002)(4326008)(2616005)(8676002)(2906002)(8936002)(81166007)(186003)(1076003)(47076005)(16526019)(426003)(40460700003)(336012)(6666004)(36860700001)(356005)(7696005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 08:00:14.2964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e217861-d0a2-4148-d1ea-08da4d12bf8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We don't need to validate and map root PD specially here,
it would be validated and mapped by amdgpu_vm_validate_pt_bos
if it is evicted.

The special case is when turning a GFX VM to a compute VM,
if vm_update_mode changed, we need to map the root PD again.
So just move root PD mapping to amdgpu_vm_make_compute.

v2:
 - Don't rename vm_validate_pt_pd_bos and make it public.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 --------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  5 +++++
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 6a3bd8b9a08f..3805eef9ab69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -425,22 +425,8 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
 		return ret;
 	}
 
-	ret = amdgpu_amdkfd_validate_vm_bo(NULL, pd);
-	if (ret) {
-		pr_err("failed to validate PD\n");
-		return ret;
-	}
-
 	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
 
-	if (vm->use_cpu_for_update) {
-		ret = amdgpu_bo_kmap(pd, NULL);
-		if (ret) {
-			pr_err("failed to kmap PD, ret=%d\n", ret);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 703552f9a6d7..08fda57f5aa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2225,6 +2225,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	} else {
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	}
+
+	r = vm->update_funcs->map_table(to_amdgpu_bo_vm(vm->root.bo));
+	if (r)
+		goto unreserve_bo;
+
 	dma_fence_put(vm->last_update);
 	vm->last_update = NULL;
 	vm->is_compute_context = true;
-- 
2.25.1

