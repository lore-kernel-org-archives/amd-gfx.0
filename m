Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7149EE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 05:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E9F10E0C0;
	Fri, 10 Jan 2025 05:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kKynILTQ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6534410E0C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 05:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5+af2Z5i7gL9NfO+0OeWraDEBhPHDqpsXrI/HeVrfDQMd1K7WGV81p/5Yqg0Hex4DxhHlPxqqUoNteOEQa6e4Dq3G/I7T6qgGl5XhgP7OC6N6qigSzlkm7Q7DxYjQupClEmOefOVDSskjAAFydpxiYyRy693HDsz1a3xGCALHK32Q4HOGb4YBiWLsCjTVJQkZP1tbil44jDmPMERw14jKjAfiwSsNAPfvnJJaJSbfKHws3FHiE1+scrydEw+xSQ8KM9Ky6PRxQbUcE5sunj5MCjvUW08DExX8y1uEvtPKoi9d+tR58q4r3P9HNuCrVHLZIA1T+s7kpL2EWRxctMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujo76d0sYa417HgW7CymG2MRyTx9+Asr3bhEzRGJzGE=;
 b=fe9NtsyMalEO8xwp+9rHay2bbYe+K+mVOjecb4TX7rSjL4PoaZrvWfF1KHPpf4CYyr7T9/uYcUdYUXiWzJgIK9PKmCm412E2wu/ETUX6QmFtuOuAdXPC4rxzeyt8rpoM3bdOO4hx+xU3Gh8fK8SkHlUVrkn/+Yqx+VZ7kEi0PDM7wv4uvTSD/GTFvlf+aUfKZ46rITRScTGGAc87YwI6n2HieOyHmWsOByMPUbod9EgcTyZYi+mWx4ymXvEHU5GbvXbcyJeJgnGRFN0wn0XUdloBIXV+GvELZLZrK2r0wkbTIdGrYTqppmTfmp4ue2g1ARrUxye6Y/PgGj+DLaXwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujo76d0sYa417HgW7CymG2MRyTx9+Asr3bhEzRGJzGE=;
 b=kKynILTQ6yW3VjI9niYlYKwfZNYj7RZhyoMp3O2Al2Jg/77HnCLk17BRr0Mcm0VYj2gOMkv/KSBX+01dQV/w3qDbF4pbO0Kbv/CwwdQ9g9CG+LVDE8KF0tZJ2dgBQJX7pJ5Jic4kHXZlPg9dRRWDehdMVdRnsPhqNeMu9i9GfpY=
Received: from BYAPR07CA0084.namprd07.prod.outlook.com (2603:10b6:a03:12b::25)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 05:22:08 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::6b) by BYAPR07CA0084.outlook.office365.com
 (2603:10b6:a03:12b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 05:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 05:22:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 23:22:05 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 23:21:58 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 9 Jan 2025 23:21:51 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/2 V2] drm/amdgpu/gfx10: implement iqueue reset via MMIO
Date: Fri, 10 Jan 2025 13:21:49 +0800
Message-ID: <20250110052150.3295085-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c6eefb-4a5f-4618-80ee-08dd3136ba22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dsocjMl9GED+Ju470O0yrgBx5qwBEVuCbS01TOXhrg2u9GHwBhmDcHm4tt21?=
 =?us-ascii?Q?lqqkmHVaqJBiDXXfU/i5cE1UmnIbe3G0izFBNUfQJcGOiHLrgIBzETPPKmX2?=
 =?us-ascii?Q?LPoRRU5WgovvvVwo8yyQzR/ZnjvUA69AhA/VfSxKg/VzJV+Gkn5Tt+mLZVQp?=
 =?us-ascii?Q?pQ9AUbAZ3Dq5fIzgpZ6tZ62Ib9TezSIl+nHR3VBOuEKJNVqPKCFNL+0gooc5?=
 =?us-ascii?Q?huIzF2LGo9yxQas8TTyhNxb4FlC7YbOH+dn6Ha+wLrQQg3+xU7e8Je9YMfB0?=
 =?us-ascii?Q?DtPVFpu4dKcw5ZTxqpq5JrAYcoEU8O/EMQDKbvOllqMUjhubyoBuApqfSk7K?=
 =?us-ascii?Q?/uupiz/uO8+6QhOPEVftTevCSRZs6dK1yvBApV9xquJNtybPDx3E0vYW66xX?=
 =?us-ascii?Q?LJs0GlWa7onijSvf2+bcKWySyDUSqTt2FCNf/uo62CkHGnSUqa1EACGDvJzP?=
 =?us-ascii?Q?ikIds6mbsn0E6kHfCzyC+tkhXDpfMt08P9YKesxxdjrFcLocCmWHsUJldzRT?=
 =?us-ascii?Q?vWjbws0qgNPHDgtcc5xR1az2iCZFPGFj7I2Cb5DVoTlXEhdB7nIE48qm3xFT?=
 =?us-ascii?Q?9+5wOg/H4/zVCLpXXRVR9uHM0pmxq+192FrhVdW6Htc3w8NG0N+TomoQvIBk?=
 =?us-ascii?Q?IKbfsKW/899kvySazHgEWxBTzb++iW+X6xKNpQZuNwDM78CEjQ6iOAic43qK?=
 =?us-ascii?Q?alZfHAkuWQ5hhTAeigwr8ZGCA8bsFbsrrURuoa5E4qa3yNy89RPuG5oCB7Ty?=
 =?us-ascii?Q?BfhtV13ULe+hDc3zroa7UiXXqAnW5tN2totql99ROOD7a1Fou/FO1H/+8a1U?=
 =?us-ascii?Q?n3NMj3Lo+P7GtfWG+MZJsSp3r5wTNSBOf/STlzcPuyv/BMcwEuifFRXksWsa?=
 =?us-ascii?Q?1/UzzUde6O7yRWyonqXt7VU2f8Fso3GpRAQw2xmFcDUpTULOFJPfOdTkHz00?=
 =?us-ascii?Q?DS3IJ/+wtaOKOyaBO1fLg1nFg83VLhMzAoERcHLrLPC0CHkGoOGSD1agQwYY?=
 =?us-ascii?Q?TwPxm2MCcYcT42MqNNy4XO00iEg5N6nSHzy4SnVgx4uxhNsyjsLI2/6I6oEg?=
 =?us-ascii?Q?72UBYTE0m3M7kPvRN8BJAzM/lz0YrPBqbX72CZct4gFIigij2FWBRpiHbCrd?=
 =?us-ascii?Q?j/vJBCaxbVF2emrblpLCBFWmyXyOJXdLhTDv7ueMDbGkeMvTkIMUcKAyuAIr?=
 =?us-ascii?Q?fD6bINNSwL3KtzKp33WxlCmJnxMgV5tw83GUdIkADZ+Z7S8dZrCZKUyvunh4?=
 =?us-ascii?Q?qqWrMfTMWLf2HJXQ8ndopFxN2S3QGiVqxagRBp4IADn1rq9Trkh7RZbHDASl?=
 =?us-ascii?Q?UFaOWZAt6/Xs8+tTtgAlIoMQn+1xXtr5mYmqNpzr7OvKCZNhZSQgiFvi3E8B?=
 =?us-ascii?Q?n5GiP/EPCrwvKazDnCOGyn1MPfmWIgSK1KLq+Ch7D6s6X1fhSD6gIRKGLlUN?=
 =?us-ascii?Q?ULy8T/8dJpDXiQfdvI911bMsGpz6umYzSr4a9l9+EAW62dwllXqHwTJi9mib?=
 =?us-ascii?Q?deWb5+jdJjrbFjw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 05:22:07.5578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c6eefb-4a5f-4618-80ee-08dd3136ba22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Using mmio to do queue reset.

v2: Alignment this function with gfx9/gfx9.4.3.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5ba263fe5512..6157e1126030 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3790,12 +3790,46 @@ static void gfx10_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
 	gfx_v10_0_ring_invalidate_tlbs(kiq_ring, pasid, flush_type, all_hub, 1);
 }
 
+static void gfx_v10_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t queue_type,
+					uint32_t me_id, uint32_t pipe_id, uint32_t queue_id,
+					uint32_t xcc_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = kiq_ring->adev;
+	unsigned i;
+
+	/* enter save mode */
+	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	nv_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0x2);
+		WREG32_SOC15(GC, 0, mmSPI_COMPUTE_QUEUE_RESET, 0x1);
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout)
+			dev_err(adev->dev, "fail to wait on hqd deactive\n");
+	} else {
+		dev_err(adev->dev, "reset queue_type(%d) not supported\n", queue_type);
+	}
+
+	nv_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	/* exit safe mode */
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+}
+
 static const struct kiq_pm4_funcs gfx_v10_0_kiq_pm4_funcs = {
 	.kiq_set_resources = gfx10_kiq_set_resources,
 	.kiq_map_queues = gfx10_kiq_map_queues,
 	.kiq_unmap_queues = gfx10_kiq_unmap_queues,
 	.kiq_query_status = gfx10_kiq_query_status,
 	.kiq_invalidate_tlbs = gfx10_kiq_invalidate_tlbs,
+	.kiq_reset_hw_queue = gfx_v10_0_kiq_reset_hw_queue,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
-- 
2.25.1

