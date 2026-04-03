Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3762E7E358
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 09:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 849F310F3EB;
	Fri,  3 Apr 2026 09:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TQQHv5Cn";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1215910F3EB
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 09:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuuXFr7g1zuj3uoHijFcQL6zJ1A7Gztb6r/X3Pn8xHz0a6OmwafQqTp6Ek0Glr7+F/mvrBBLOb6yQRlsYSriZsMEH2jvRs6niRloZsFuaJgRM+grL0leuVKgQf34gwW3xQi9eiL4OeozqbmMwjMt7vrO+B/sm17lUI1zEipdhCjOkOOJJJyEzDiPBRixcXEUe4N8/GyasMvJ18/l1QOgPg/zDVv+1u0LOUa8vzejONXqHrLxOFE5XvyJbOsXpbcBmSQjUp0uzuzdS8pouUl3u6LtQwtK0hSoWs71sR/+6uElSOWCqVna+fTNr6N63c1o8sYcZo/80ziod9S+tC8iZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/On9BV00T6bYIVnao3ZgbsLeO0h0/XeZE26L1Nh2S8=;
 b=a473ew3nNwG+/7bjW7rh/YfFEPgvxnaygJbJWUYr4qjTkfoxHwWeWa/1e565TsVjpdm+9IKeLLqhqYEscqJ+85WVR139Ey8TjByvyrNjGsr1+0kDpj+LlNdru6zLT4JBqjUNw8xIQLO1clqDbG3Pa1Y6Goa77Xkp57ebCc+pVPeuuDFxypAZo/yZJiMGPQxLM1v5wsjteYLiBFOlNvn3ho8W5p/4+Nk5k5+QFZjPb+9BOoAVOZkLTrHd99jbNdcwQ8SL931lIaHaqccOvca1ra2gXNUiFwI6RQOulxvpXdEcMxUqrELJNs8eskZ+j+8BJvKPM1J7ZgH7us5UsxMoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/On9BV00T6bYIVnao3ZgbsLeO0h0/XeZE26L1Nh2S8=;
 b=TQQHv5CnkbhAwm9A+y53KCyqtKM/GXCNZrl0pWzmsgG6Qs4KV1v+C4fXf5O6aVYqTmUZ3WH506rFQJ9Rycrry3Gif3zXne1DlHbgDMpWecyYCTBpfSCqc+7rEwyPv3AlK/jwbLb0qM+YY+5nZCMkl1dx5Uz5B6uRaQ494N7QL/E=
Received: from SN7PR04CA0105.namprd04.prod.outlook.com (2603:10b6:806:122::20)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 09:25:44 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::54) by SN7PR04CA0105.outlook.office365.com
 (2603:10b6:806:122::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Fri,
 3 Apr 2026 09:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:25:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 04:25:43 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Apr 2026 04:25:37 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 "Jesse Zhang" <jesse.zhang@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/gfx11: enable per-pipe reset support for
 compute queues
Date: Fri, 3 Apr 2026 17:24:36 +0800
Message-ID: <20260403092529.2238333-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260403092529.2238333-1-Jesse.Zhang@amd.com>
References: <20260403092529.2238333-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 1876d074-a337-4509-868e-08de9162fb4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: itU+wi3rfXIIR3VycpMkh4qJT0gO9v5NvafBjwlVnTOU0KMUjBxRCqbuOXUBJ5eVqAT9CapOyRByKCHw/eS0PZzeQEYQTSvtrN/qfpJN7J+Jas5+dkQbKVF1jnXU1LG0amM6hQOMIcWSg/w57OZ953eEu2nKcMz7Cky3jJIT/a/ucvEhjfY9Vc9GChJFM7bQZSVaR3RHRfmAkpyfNI8Df02Q5kJBEK472uK9FHXywUIRbiYjLBlpLGPUzW/Pa9j3vwm6EqN/4i/kMR0EZLSXj/Jpr+42Gw1rMB68FHz6nKYEdZKuhAadylId3qtEcIIkD/UUDFHWj0zlwkggygalKpt+9AVvhluGvrAZPimMXqoozH+aA4rhpVt01+nLgb1Chgg11K5xqzZSK2gZPe7fxVx+3Q9eyRemsq76jG9F4Vq1/LtcD5pHd7lQQsEcu/XEa1kOc6IXRsTopSiXVtYEU728+t2HnJYKZVXm0joZaZ+H0Gygbb7oOK8teEFX6FIv6Xo2tZ9EevopIuXvFJuH3rc+mE/PQQh7hb55DKLH2re3q4r1R+8XvMxxyQybmhlexMK/MDcD1jQuNinXuQAmACWAZV8PCIDzajFEYxgiggfn+NN/qS/0CKUNFYg0qc4UKJ0VCF55iAm5ru4PFezcLqiqEdbMw+Pyl+AD+kDXmG7eVOQTtbinBmirM7bIaqkYoislvB3gtwrVpyprNdWxiGfMWeFLB672KaSvSYVMIdkAmtNZsZsJfAzAq+whznCg3EMBYaaJjWjc4G+E8+ZmWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nLcHzFVDSQx43ElCdw7EIYOJ1I4PD418dDEVToYtxAML/b0OO2LOEYoiLpdMrkG1Bk4IcqDLLM8YdADjYrRlpxTeHZXAXKXP9MCWKnKIYjwfcNqjFMEcqnI/YNVznuyNbJi/ptHT2GMxy1raQuJoMnRS7loo+/JFzmCADmQccU4qa3GjvUuv3xfIZiIPVbXammPLLI/US77onWFvtkIYmprSdlL5a7qDv46SGPAgkQg8i4ZqA1wp9aUZhu6hIpu0LtS+xvvH0iLGwlndvK/Z66TO6nwVykeO1phyLofctEC4DtT+7m2lScJsetxPCrcoRC3WQgviGWJamvJz9yCiP325S9E+Js2Z5nZ2B6ukDTFYj1fzQha9nCX1I6KsgaCU2H36Pw+U04KXLhmTGE1QoKp/ZR7SNnbxEAIjBCJWINLaISOWXjVKDtwoav/eAXbl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:25:44.1691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1876d074-a337-4509-868e-08de9162fb4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
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

Previously, the per-pipe reset sequence was incorrect, leading to unreliable
recovery and potential firmware hangs. The reset logic has now been fixed
to properly handle HQD cleanup while the pipe is held in reset before
bringing it out of reset.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 18b92990179d..43a89816f794 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1851,6 +1851,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	default:
@@ -1858,6 +1859,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	}
@@ -6906,6 +6908,11 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
+static bool gfx_v11_compute_pipe_reset_support(struct amdgpu_device *adev)
+{
+	return !!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_PIPE);
+}
+
 /*
  * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
  * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
@@ -6941,7 +6948,7 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	uint32_t reset_val, clean_val;
 	int r;
 
-	if (!gfx_v11_pipe_reset_support(adev))
+	if (!gfx_v11_compute_pipe_reset_support(adev))
 		return -EOPNOTSUPP;
 
 	gfx_v11_0_set_safe_mode(adev, 0);
-- 
2.49.0

