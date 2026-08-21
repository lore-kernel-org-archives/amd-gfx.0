Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01620C5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 09:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D94E10E290;
	Fri, 21 Aug 2026 09:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jd7RGja6";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2789F10F2C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljwu2EU9fSAbCSrKnXmEjXnm+nwfBbSwwvLpeCc9OPBm6rCDLTEezaPx65Qkhjz+o3utLE9yTDCFgJVyXgYiwBDuA+qMRimBW5So6Ew00NUT/2T6dTNYB6/T6B8HGNSrVlEvfSCbd69JT6O7JuWTjt1KN09W14RvG+H9qcmpcMX8jRsDsHi4wSQ1OlJGN93tTVi0Ltdi94hWL2fNAnTPkkkGFzbVbuQdAwEVlqXfOi2wkvj6D8+z0VSmHgkMtv6WV+24gOt6kxXKRi0/IIked8x8bbZ4wWnd1duwi164kFA09HqB0woY/Wt8WlDFq6gsTZLPVxnL62nF7XjND2Tnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfDEsqhx1ZZozfVrW2An0e1L9qmnyGvVzrZ05rQ+KjA=;
 b=q3LeOI709vl33cSmH/5YZ1IzVvz7vrPgI9MwlU2HhMqOFX+iTl++wJlN7igtz+ZpIB0i5ggZpb5Iz5i/bjymIgAkKatY/IV4LiaSnefeN7Md/4WTdUL6F7VVvK2fojnh775coKN6pEjUsoYEh6c0rqCgazRULkQNCYkLR5K99neim6xnHbwIT3LtmeJrnN8NqV2NcJKo1BsQOempKrEhvCV+4RqObrUQRrK+UEKkAeJSO5DNrbmxmS1JVRG4u8CB+4B0PWfMvMVoKli7lcWkVmwSfJtc+AICJKdbv8ZwWwPz+a7q9ASBtfXFDeKAKOfhUFXsqEi1S5vjzyTAiNKzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfDEsqhx1ZZozfVrW2An0e1L9qmnyGvVzrZ05rQ+KjA=;
 b=Jd7RGja6EimrAAlLcaLT+DoG54jVcVnNlTa8EEfg+rbyzB/mW38wjSpNmDwBAY+TOjmVuV4JriP/A3fj8tOm1ETawB+D73Cr7+sQ5ren3ApiCrm7pnNzWeKWtPMHyCZcN5VkQRGKiNEg3CIzfz8fOrdkO5uVF60YnCHnI4eYPBA=
Received: from CH0PR03CA0397.namprd03.prod.outlook.com (2603:10b6:610:11b::30)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 09:54:37 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::4a) by CH0PR03CA0397.outlook.office365.com
 (2603:10b6:610:11b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 09:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 09:54:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:36 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 04:54:35 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 06/10] drm/amdgpu/sdma7: implement update_mqd
Date: Fri, 21 Aug 2026 17:52:15 +0800
Message-ID: <20260821095427.2361126-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
References: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 25702f9c-4e1f-4dc1-d898-08deff6a363b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: jyFBX0pYx2fvxir16/ASIwoPqz46C2ZwzkaNSUyVEC1cZX3ys3sh8bF+T2hhh4n+cAr6adGcGgj9wqux41LeVhxTQQIA1sfZc8OPLsFdus0KGdDNb0krbvhRK9TK9Aa2viBVtHBLeQbhykyPjVajhuW9XqO/CUcCRO8ihTWFgd5ey8sM0MwSQpw0qLqNRnd3qQOV2XCyzSa7kEs1vEJiUfmaAV6OJAtrnjc/jgRihL8XgR4Q7oFY8BW1mPAxS8C/oaKqFN3WnYGnW7JnvxQEOK1UKAMkkKbRHXHmIMvnm1d2bbX0cJVn8KWNEEKmAhad6FOGVuqsg3n+YP54BSDDQgLm/Wm5NSWQkHJ/WLkDpObPIYp0nr0UXdYMIIbj47OvLIkm7CmRiuZcMr/yu3iZf4rOgNClN935lsXLY1k/wdObZOyi6XY0T+G4Sfh8cr4hI/+vI6wdKLF4GgdrkOOlMDDEl4PNvteCOV/WKuPQziL5IQX4ruHhNVV85BEy8iT653o8OwnXlsSzpjSVTdKzupFjcIeqfePw2su0i6ZE3oxVEl3wQa7Ez9wJz55RwlrLIdpWkydgjpozTkNWj6FBYqYF4aOhGM9k0vr+Dn4wsPCArrLG0dgG6FVzz1P/QKhYtEwZXUYccY+gIt5KEYtLTDtz4IjZd24pu0ybjPVJqnA3NZw+6bCHYB8dqygvZwvAmCJr3UcZAVgUhDTyyOPHww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s/yL0koFJIqpwJ1yStVuvLAT+a7bjGSYzH9ygeEhhwDsgXSFKsX8yoTDxRCrFhNaNZAOs055s8A1shcYMkOPqugxqTV84qidfOHYOJCqTRMtxhk0kS/nLkmhmqHwAVzM3Cjkec75Ox7Lmm9jsdNhyaLgIgvsz2J66aPaimYYo4BdOE0hlzPR42c0Fq1iQhAGzd5n8nUye1s+8l56wGntGDxPLyM7hlct659c29HLMx+Uak6CctgnChi2rqWE1gUyDJ2rWkmRA3LmUHf0xmp4FOf+2HlzNVCPg2G8V6hqqwAAY7ICN1B/RM/VJEc2SH/hq7ljSkwu2/lfFZfd+9Q6FzVO+S4Va/uHsI/W4mcN5yGXYIgoQJaZlLTAoHxU2sMRvgtFMPYk890l6xq3LyUacPHXa6tBMAe9MMBoLqEFnnuDOijGNLjz5uuYFv1Q9Ozr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 09:54:37.4380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25702f9c-4e1f-4dc1-d898-08deff6a363b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
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

Implement the update_mqd callback for sdma_v7_0 user queues. SDMA init_mqd
leaves the ring rptr/wptr alone, so re-run it to rebuild the HQD, then
restore the saved read pointer and forward the user write pointer. Force
IB_ENABLE on, since init_mqd seeds ib_cntl from the live IB_CNTL register
which reads back IB_ENABLE=0 on a stopped queue.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 2068e2e6e3d6..2ab24d99c5ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -905,10 +905,39 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	return 0;
 }
 
+/*
+ * SDMA update_mqd: init_mqd leaves the ring rptr/wptr alone, so re-run it to
+ * rebuild the HQD, then restore the saved rptr and forward the user wptr.
+ */
+static int sdma_v7_0_mqd_update(struct amdgpu_device *adev, void *mqd,
+				struct amdgpu_mqd_prop *prop, u64 user_wptr)
+{
+	struct v12_sdma_mqd *m = mqd;
+	u32 saved_rptr = m->sdmax_rlcx_rb_rptr;
+	u32 saved_rptr_hi = m->sdmax_rlcx_rb_rptr_hi;
+
+	sdma_v7_0_mqd_init(adev, mqd, prop);
+
+	m->sdmax_rlcx_rb_rptr = saved_rptr;
+	m->sdmax_rlcx_rb_rptr_hi = saved_rptr_hi;
+	m->sdmax_rlcx_rb_wptr = lower_32_bits(user_wptr);
+	m->sdmax_rlcx_rb_wptr_hi = upper_32_bits(user_wptr);
+
+	/*
+	 * init_mqd seeds ib_cntl from the live IB_CNTL register, which reads
+	 * back IB_ENABLE=0 on a stopped queue; the re-mapped engine would then
+	 * drain the ring without executing the IBs. Force IB_ENABLE on.
+	 */
+	m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
+
+	return 0;
+}
+
 static void sdma_v7_0_set_mqd_funcs(struct amdgpu_device *adev)
 {
 	adev->mqds[AMDGPU_HW_IP_DMA].mqd_size = sizeof(struct v12_sdma_mqd);
 	adev->mqds[AMDGPU_HW_IP_DMA].init_mqd = sdma_v7_0_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_DMA].update_mqd = sdma_v7_0_mqd_update;
 }
 
 /**
-- 
2.49.0

