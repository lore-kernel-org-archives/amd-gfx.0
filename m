Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D854C982D2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 19:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D20D10F0D4;
	Thu, 17 Sep 2026 19:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UZBZ1BZv";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013003.outbound.protection.outlook.com
 [40.93.196.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA0A10F0C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 19:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbQWLpcyHUrzviDgx0luZL3STxN4HRf0S5l1Ntw3hx+VM/N2sXzh7pA/r+9SN20JmmTN5L/P1dLdah/PysBWgJ8G2ONVe9vl/5ShUb3b+6S0bbLfKPMO/VR9GTh3o4OfqSvrJWDcw+X8WQBzp3S6AlRYDaTyv/K20rwriTUW/PG/6YJTRp2F2yiRKwwc8b+/qny891uR/rKE14aJLaCHZ2pIb0KdySfgBDOXcHjqQEwPc2Z9AA6b+FbudEV0F7beR0x+kzJ29jy35C5WVVHGilZI7BR1+8uQ2iTDVPUALRfmqbElA4j9fKyuYKm+ZisT2sWx9ML6XcK7qRyLBblB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcozfArsctQBw/3kYQLwLeLIMOHFfCGvOOfF9RBrT5s=;
 b=AYXx7YLJ8Lxqqx4fDSwO98ZacP56nmeMp6KJKj9vrTACBdiqj1ljaH5MpPCmBax9I0fcbtq6FwlTKP1JKApJAp7bVh8OKb5EozqqskfNtmxsm44gG4vXv3NiacCFx9++QIdyG63SqnsMnHKr7e/3eeM5CUxzDyB9fu02ayck2sxv7MX0AlTovZ6+Lx6rmPbvRwSPhU/1cpeEgd1cBGSWK/dGtcXBp3Nx4Gwzs35Sj7IzQ2ayYAZydfZXsmYzA60xPBWRIvYvTxiFn2wfJCSVnu9Cl/WK5skRh66S07eqpARRrAU54M6j5FynmjrFOchPm/mjIiGnoKgu8QKZkuACqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcozfArsctQBw/3kYQLwLeLIMOHFfCGvOOfF9RBrT5s=;
 b=UZBZ1BZvmHaxoZwPSiWc/2zAMCiCCAtAZCyqSi/YJCnRc1k2SejKIzsczIYSn5m/O5lWW41CTop5hFu8xTuwv+kTfk6UNNBEm5bHmuHA8cvH2SUHpXpI75yBhovegUVxbSZ9x6+/dHpmdtVTxpMcQYDVKOfUGJ70YZmNX00pTek=
Received: from MN0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:208:52d::8)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 19:58:31 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::82) by MN0PR04CA0016.outlook.office365.com
 (2603:10b6:208:52d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 19:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 19:58:31 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 14:58:24 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v2 6/8] drm/amdgpu: prevent suspend in fault handler
Date: Thu, 17 Sep 2026 15:58:07 -0400
Message-ID: <20260917195812.72917-7-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917195812.72917-1-shahyan.soltani@amd.com>
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 032b8251-c1d0-42df-96bb-08df14f60c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: C4NztPsHi5/TNDW3+wFbwiabN9WSFH1IcmDgk+JXq7+rIjuYp1B0ZKntcEuVNfNbcRnGf84hnOXVFnE9rPdn7i2sdSh+HXLpZwec6tPGvjWdxrEDmbkpnYTc0EfRewK2I3jBGzFeZO4GDjutfWgt1pVpd6nIBVCtjKuNhL+3/47eb2pMI762xErwKaLpF3upXhJw/ZBjwR1eNQsOASPSr6LYFcTtI2EQLMknDtssl5N/LgvAuIsh8lelP1vbiY6KmhLfNUcMIOnCKS0GptuLMrBL+nidUou/zUn3XkntrI9BShRNOKa8rnpkm/Q8uK/K9ZoYoq2M98JIHm4tU7SZBaoUjGH42PujgXkmXfCWLgCQnYRbpaB+A/d4z1oqco/qnfJye00tP6qg41y5ST0q0y/XznLT1qWLAAFYNh601YHP60dffV1GXPnn57aRpFSIwlLb/kkJlfK88mbuZBPWpgE5Boo/xqtAt0vnkz6AGlaJ3+uHZfWLnaMKYr0sAmonmxXPSr/CgpSUSoJyqGRtJzM2WxH2p2E18Ewl5d/EYDWNF7vJ4MTJ39RIR82Ro6vevcb8+NFT0AhIrh+yysXEUIFq1jWMZgi13OFj8jp5yvXK39H1oDcGQJCFA7W9r9lVpItSL230K/6lsfh7gxCuh2I8Ai7CCMOVOAgGeRTJYWrtV8opZ/NhFwe9MBogVeRTocOjC5/WEiSy2HURr2pl+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O16nhiAJR0hQ43Gga6fqOIn6rLNzhl0TTrtCf5T3fEYs7++QdctZL6RM4WnBMz7IOOnNI+bOGDQsAP1S6MSF0DFsw4K3/lBpW7nxWqnGme4PFw+ZmJyGGy9wQwYTzFbTKOJFKfQu1qzb5TPdIckI/Kw9nN7Ml6AJnTW/Z+VDzD9PdIiyuWF2f4Xir6pIbKLyYUeBLVJauKGmkSruufv//bU5w0sGiypedMYK8zt7Rg8Ste/0Xh0jl3zkmQ9ucx4ftC0J0vtE8+CxCyDfiCN15kzIeFYc8JF+mcBhOfNnhbpdwAgw9uXeg0AK+e0BvCxqi+WIT3TShGfYVmxvXzR8U9ceHLZRKbCR/NZq62WgsiehLcLendzOUkwFq2Ujn+2rXsdXsibWjgZM2W2uQxzzWS01cTfKJ6LByN0AW26S+QebynLrHwqQpiFQ04H6ayJV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 19:58:31.0202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 032b8251-c1d0-42df-96bb-08df14f60c57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Temporarily increment the PM reference count during page handling to
ensure the GPU does not enter a sleep state.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
v2 (Shahyan): Added commit description
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e54d30f75b2e..cc6b7c4a947d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -129,6 +129,8 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 		return ret;
 
 	if (drm_dev_enter(ddev, &idx)) {
+		pm_runtime_get_noresume(ddev->dev);
+
 		ret = amdgpu_bo_fault_reserve_notify(bo);
 		if (ret) {
 			drm_dev_exit(idx);
@@ -138,6 +140,7 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 		ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
 					       TTM_BO_VM_NUM_PREFAULT);
 
+		pm_runtime_put_noidle(ddev->dev);
 		drm_dev_exit(idx);
 	} else {
 		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
-- 
2.55.0

