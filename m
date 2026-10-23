Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2B606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mzjavhvZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B57112A46;
	Fri, 23 Oct 2026 09:08:59 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDDA10E5FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mp60HWEWYx1l3nK59FgPTLHqkoe7K404CIfKbmWojJSA2axpkASUdAbKoryyFzKEJdrx97P3/J2nP9o8HIsf3tznKfdsBT5pnwbRRiUyhaHi7CvVv3Zlmue9fFCr+z1hBsfmD8yybQIq4hmpDQmuf1yLqhfBwhyEXoafkuHJEVWVeBj/UNsbXPVRFujIdi2/HxHhYTPhvaZWpFPorTjMUVnO8uylWn65IdqiHBrxpD/RWFX2emc19f9mpN2eVSJxae3VuFE8T3yTkhl09/VxsYWkWnt70ldSZhZ0xlkIN0RgfaT3ApCTLFZ/29TTplj4GO09sbfHeIsULjafQLtmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSTPA+8r5UejuUv0pymzMdZ+FPVlcTO+Y76YRQ1dKvo=;
 b=NFesEx2n2MbMl8jZtG7EM7w3A/BTw5jSMDkUf7lF8O5A836kSk2Ryf91om6fwKH+XMTGKJv4nWYJf0A7MrB6pQDtDWVdByXeZ1Q+4HQAd4QbIBsbi02anmCl7kncWg08H3WEFeISfMRMScQBIoSiAsohoXsYuVrCecSYoTZt5dwaD4wBmitBCETJMDo5RqVsp2m8E/4Rg6CfQkWXpHc0UgMVTfg4saVuddp0+Eb+vfH52zRc2nY7J12rG0B89c0D9rDPjZJUEtzIH96GlfsVrKumMHWMfmeX4uCtdC4N0heOAt92bU/gvMa46T/ticPVNbTT5cOzoZAhk4fs46uSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSTPA+8r5UejuUv0pymzMdZ+FPVlcTO+Y76YRQ1dKvo=;
 b=mzjavhvZnrMMiNZhk4L1w1nnL/pHuyPPWy3AXIbjXY1yR4fKiFc/VfSzKZ4ACS1q0nd08LYZt0zdyz1r7qD6ScTDjMlmCUKIE4mtYck5TBPJwk2IOLdEdu/nPh6/uNR9tl3PFMtaD8tHvxG+8sruehyAXCSfwszhLsvn7nd+1hk=
Received: from BN9PR03CA0639.namprd03.prod.outlook.com (2603:10b6:408:13b::14)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 09:08:48 +0000
Received: from IA0PEPF00000041.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::aa) by BN9PR03CA0639.outlook.office365.com
 (2603:10b6:408:13b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 23 Oct 2026 09:08:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000041.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:08:47 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:42 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 03/13] drm/amdgpu: introduce PMC ioctl handler
Date: Fri, 23 Oct 2026 17:08:35 +0800
Message-ID: <20261023090845.670581-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000041:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: b945f95f-4cec-4191-0e4b-08df30e53f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|10067099003|11063799006|5023799004|56012099006|261009223027099003|261022075727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: cfmeO98Y/Gq39AN8pNJVihYccB7iEjhcCUvAZ2Z5pGtcSLqykB2O40OE3kTDCFr/vIrgQqGRHZAxHru5NREOH/lq243tyaecpBg7gRwjDHC0akfBBMlihYS0v68zaqwii5QCFj2O3fHTnFylUKwoBkAmiol+18Mg5SfUcUQgdiFcY1KnlRKTbJhF6+mPCYCzhpJTM8hSLiYFbIl3tp6Q21BSSjD7DqDXE+nge0AKodWUjoaI45C0MZx3ZlhuwGCIkwPYTWX9fTyDym1AHQPz2YvplG5Y2KIP6ZskpQNlcr0xtYaiQkseTJtnURZWEzMD9KipA1YdsjtACBTp3HVq10Qd/BFkuxcLV3RwTFIqxIlwbNxiyVOwZ5UKFsdliQQrw5JmPB7t9WFBqi0nA55un8YFBPxnu3aRJJF0DahskQqu8L2PWBayrSdLVbhKSnArOBqMgltw/JUj3FyabjqW1i1pTjd6bxC87iFrJkVCbAoWX+fWRFa8rNClYcYwrL596O5Ffjd2s5HIO0Wg9szjBaKlbjIo4oD7+Fq6vqOJZwPBvNOQSE0nPhDqruop0xtmY1LVNset1fLOcDTljCIpPQPXMfgCvCppCUN9w7mjm8VNYjlZDqyORtEUnQ1r2soBKA/yGIa7Wzr1dRLZ2//j/4C1d3W4mLmuld0jqPlJutAC48bvUOAeRdulTNk3PhqpdXcCnq8lwd25zsa9b5sPBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZblCVKbAahKTmZsXc6IsfHuO2eMoLs5tSLy1LT+XSjfneIIUy3OMuF/6k0i8Avyky/WhvS92MHbxJKgPl9yeW15TpfGUlbtPzd5+oDQ+icBtV1uRU7X8+AC6xj/7DFuN0svOxOi4DFtIj2kGp3kb+nL5ZhFlK90iIs/5oGQOMHofgbiMLODzOy42yIdSR37tlDiunLgFDyaEk/JESGsWV688eYWxlKDK35DJ482R49Dxp2fVGUnaNhhgwf3JlZa66u/6XWWXDp+Noc+kmuvMlO7uPVcjWzc2AJcas75BOAntAue81dTAbI/aggpV4biwVfbsrVrGrdUx7GejA1NgrFzJq72EV7wAT+5Sg54ApOpjuMzOjCQn5iEtsKxJEdkiNzrlho1wMghHHsmPfM0Yq0wddE6629UaIaeZziO/qbzifv2ZgOi8iawL0Mk2x3nV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:08:47.7148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b945f95f-4cec-4191-0e4b-08df30e53f4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000041.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit introduces ioctl handler for PMC.

In this commit, the handler only performs
basic checkings, including permission and whether
user queues are enabled.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 35 +++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 04902696adab..134660a4a4d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -23,9 +23,40 @@
  */
 
 #include <linux/errno.h>
+#include <linux/capability.h>
 #include <drm/amdgpu_drm.h>
+#include "amdgpu.h"
+#include "amdgpu_userq.h"
 #include "amdgpu_profiler.h"
 
+static int amdgpu_profiler_check_access(struct drm_device *dev)
+{
+	if (!perfmon_capable())
+		return -EPERM;
+
+	if (!amdgpu_userq_enabled(dev))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int amdgpu_profiler_pmc(struct drm_device *dev, struct drm_file *filp,
+			       bool enable)
+{
+	int ret;
+	struct amdgpu_device *adev;
+
+	adev = drm_to_adev(dev);
+	if (!adev->pmc_profiler.supported)
+		return -EOPNOTSUPP;
+
+	ret = amdgpu_profiler_check_access(dev);
+	if (ret)
+		return ret;
+
+	return -EOPNOTSUPP;
+}
+
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct drm_amdgpu_profiler_args *args = data;
@@ -37,7 +68,9 @@ int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *f
 	case AMDGPU_PROFILER_OP_RESERVE:
 		return -EOPNOTSUPP;
 	case AMDGPU_PROFILER_OP_PMC:
-		return -EOPNOTSUPP;
+		if (args->perfcount_enable > 1)
+			return -EINVAL;
+		return amdgpu_profiler_pmc(dev, filp, args->perfcount_enable);
 	default:
 		return -EINVAL;
 	}
-- 
2.53.0

