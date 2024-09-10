Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F60FECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 14:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C288410E103;
	Tue, 10 Sep 2024 14:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iH+49ljQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37A210E103
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 14:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJAFHl6+9llrt8WI0jJfs37sxi6ZzlICbkKXQYDQ2Y3ZShiprE4awjtTsd8FLkZoK5lIRTd69bvamdqm3VePq+9IRUktDErQkun4iF31nc/QaY5alcLQBV5D5dRBFcedgdDe45Zo4UB5mpB4AWkNvwTQuPxvXMUGc5P4AnYMhaHzFs6VYf6rMGTDQYacPwcSfBVvuAxja8BW6CTBMDh/1Rd0MskSr2M6zAZPYQ2TzcQNc1X0v8IAH1CgfoCxxDlspfuUmMBQgSnpkuftOFHyl+oDzRW2gwbj2WMNI8g8387c57gyyCv6Ayy2IdcI/D554dkhtQsWMLm4mSWGr8LA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj71z9DbNm5Xm3OmIMJDEmXtqW+poKDfeW2Vjf0Da3o=;
 b=h3dMGO9MZCLJROQulBAvP1FK1nHAzIi/jV5RrJOP56i9K1K8WEky6WanCewO3S3/Zo2dwOrTz3QPKqUZoted6KU4XVN/z2Qk3mYfvSO+08kGToKXnWfVTTs/MRVy6+DnJhqxaRn9ALh5M8jRGgR7AAnX3W4eN93uexW8urTSkyJeprZ25pkynGg45//YorXLMrkQIhqygmgiiqWoLy4hfIGMJGMnLRntb5HVddEs1Dww3842uLF2gxZ/XHSPecYcQMExDQHa9OVKuD13VJuBEaMxyXAL/fFafLsW3lZ767lMPAXjPnXr8wQNTlhDGCcfmQhG/09FBl0KdlhnsMNBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj71z9DbNm5Xm3OmIMJDEmXtqW+poKDfeW2Vjf0Da3o=;
 b=iH+49ljQjY1+WEXP0L98pThqiKfwctJAhflEZjAXQZSr33qA6Z2Ah68H3+sIBTXzx0Bl5ij+6KEw33N1iuJclj4Cmpe7D1vP2Kak79N13KZyhuCNXoySJ2wfhF2H/eBmIKp6H96Vu16Y9iQMklJuZpwAxmPl+sBVXtQ8MA+M9nM=
Received: from BY5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:a03:180::36)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 10 Sep
 2024 14:32:07 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::c9) by BY5PR13CA0023.outlook.office365.com
 (2603:10b6:a03:180::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 14:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 14:32:06 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 09:32:03 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs
Date: Tue, 10 Sep 2024 20:01:46 +0530
Message-ID: <20240910143146.1942083-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 88bb52e6-ce0b-4152-0b66-08dcd1a5589d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVZwY2k2b0hIZlp0dFVEN3RGOVl4bnNWdVNqdXk0dnRrd1RTMWtiaWxkMndp?=
 =?utf-8?B?dHFqVnVITExGTFN1S3k0bTlpL2ZReUlHRm1wQ25Gek8zMGVyZ0VkZ1N0SGkx?=
 =?utf-8?B?OVFuYkNSZ1hwR2l5RjJSMFJIY1RndktnN25oY0JVcm43TFVqRzRFcEZoRTRT?=
 =?utf-8?B?WU95M2k4ODJaL2ZycmtkMHBKUUxEMW1HalpQeXRZMjNoL2dYdU5pOXRLTWZ5?=
 =?utf-8?B?bFo4MkRVSklyOFFPK2hEcVFKQU5lWE8xYXlYQ1hrdjBIVTBRR3VqZVgyUHF1?=
 =?utf-8?B?UUgwc2Rhak5rL211T0FTa2plMThqMlVOcnZtSnBWT0pjVml3ajJPM21aekJ2?=
 =?utf-8?B?Q3lxMjNhcWhJNk5jb2dOQnV3MkpuWGNpNk1kaVpIaXZDMmxadDF4WHJKQllv?=
 =?utf-8?B?aUxoSENFS0hHeVRadTN6dVFhVGllSy9IRzNGTkViZzUrYS9LRkpWbE44Mkpx?=
 =?utf-8?B?QXBqdzJTN2hlbVBsUWRKOCt3d2YwY2VBZk4wNHFGVWwrb0dTRWIySGJUWFIr?=
 =?utf-8?B?YkE4YllXSWdpUW0xdnpKbml4N2dSZng4NlpRMllsMU51YUI3bGRLN0JGcTh2?=
 =?utf-8?B?RFlYNlpwdkpsYndiUDFMb0Z6MWxROWlONFp1Qng0UDVsdU5OMzBpUmJ6dzZN?=
 =?utf-8?B?ZGRkY2VXdFBVS2QrYklKY3ZmclNnV0VGMDFXRTJ0Vnk2clg4ekVkdEVvYnM1?=
 =?utf-8?B?VGl2SzI3Z0RPdXZscCtkQkF0eUNmV25hT3VjOUxvbVBjM0taOXc1K05XZS83?=
 =?utf-8?B?clEvalVEZ1BNZ09Ha2VvNkFudVd2eFNQaU5hZnhMWmtVN2ZpVzhRWWhtaUN3?=
 =?utf-8?B?SlNoUGYrUkpEVUNUUWxtemRTZnNUeHRZTUt5S3BxYmFXT2xLdHVpR0xDL2ZD?=
 =?utf-8?B?UnMrS3BMZGxEdTUvVU5CRmJobDI1emlMaEJQRHhpVjhudTBydlNJQkpxM2Rq?=
 =?utf-8?B?bEYvWHI0NGdsOXZoZVlObXg5OXoyQlRFU0ErRzJtbnZTZHJ6OGh1Sm90aVZl?=
 =?utf-8?B?bElJbVhZaXB2S3VsNGh1UDBXTXlPK1MxMFoyY2s0SzBGUGVBcXQ0Qk9acm8z?=
 =?utf-8?B?Q0xaZVRZYVZzTHpmOGZyQ1ZRWTlyblRSWkw1aEE4R0NETkZLcitlamlqZEpn?=
 =?utf-8?B?Um80N1ZvYW41VGRwaUJiWmVra3dJVEEwMlZXekdTRVA4aFdyaWgrTkV5MVAx?=
 =?utf-8?B?dEVuUGpQZDRqZ2JWQzNjUjh4VnBOeXNSNzhlSkxJUGgwT0FIZGRxVitzcHJu?=
 =?utf-8?B?SGhWam5VUGw1QXRvWVZGUjJMUzdMRTNmQmhyQURObmJueEZXU3R3NXcyOEcx?=
 =?utf-8?B?Sm1ZbUZINExZL0lIOHEvVmRLSXArNkpwdWgxTVVDMFdWUXZwV0RCLzY4U2Z2?=
 =?utf-8?B?dTJxWXFyQ2JHdkEzZXpNdUVRWFJmcTFCMkhRVGN5NmliY25UUmwwYkJ3aDUr?=
 =?utf-8?B?V3dQQU9kTFV5UWg0Wk9kczk0KzBMaGs5TFVXREl2SzBYWm5RTmNqZ1kwbFc3?=
 =?utf-8?B?cUlaSDJmUmZtdm5WV3ZEbjFJTnRBR3p6TmVBYjRQUysyVmlMVEVLVWR5NWZG?=
 =?utf-8?B?S1NLM0ZET3dmMjNwRGVmVUlSQnVEMFFYdHRHQUUyZURZU1RBZWFqazROUEs3?=
 =?utf-8?B?Y3JWemd4VEJ3L0dkNzlHdDdOcGNZMHN4OVk5VHBxZzJXY1NrMWswNWZSa3Vt?=
 =?utf-8?B?eEUrSkM3a3ZlbjRuallsMjFYSmEyVVZCTDF5SXFRUXROZ2FIOXhXOVhBL0dn?=
 =?utf-8?B?T21xQnZaZnFWcXFUR2h6OXZLeGRaVUEvRGFMVWpRT1FiQy92cDBpRHpYSS96?=
 =?utf-8?B?VEhlYnArQ1B4akhteTJNbnJ3aWZCM1pVOGZ1OVN4cGZpUVA4R3FHS3MyYnRR?=
 =?utf-8?B?YzAvOXpNZ0xScGlHaHZQQkNCRTVhek9haWZRVm82Y0xQN29qbS9GWXZjV1lu?=
 =?utf-8?Q?mjFQ4ceI4ltMblEhrMNc+5N9Xc2RJptf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 14:32:06.4701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bb52e6-ce0b-4152-0b66-08dcd1a5589d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
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

JPEG_4_0_3 has up to 32 jpeg cores and a single mjpeg video decode
will use all available cores on the hardware. This debugfs entry
helps to disable or enable job submission to a cluster of cores or
one specific core in the ip for debugging. The entry is populated
only if there is at least two or more cores in the jpeg ip.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    | 71 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h    |  1 +
 3 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index cbef720de779..37d8657f0776 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2095,6 +2095,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	if (amdgpu_umsch_mm & amdgpu_umsch_mm_fwlog)
 		amdgpu_debugfs_umsch_fwlog_init(adev, &adev->umsch_mm);
 
+	amdgpu_debugfs_jpeg_sched_mask_init(adev);
+
 	amdgpu_ras_debugfs_create_all(adev);
 	amdgpu_rap_debugfs_init(adev);
 	amdgpu_securedisplay_debugfs_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 6df99cb00d9a..edf0a50dd345 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -342,3 +342,74 @@ int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 
 	return psp_execute_ip_fw_load(&adev->psp, &ucode);
 }
+
+/*
+ * debugfs for to enable/disable jpeg job submission to specific core.
+ */
+#if defined(CONFIG_DEBUG_FS)
+static int amdgpu_debugfs_jpeg_sched_mask_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *) data;
+	uint32_t i, j;
+	uint64_t mask = 0;
+	struct amdgpu_ring *ring;
+
+	if (!adev)
+		return -ENODEV;
+
+	mask = (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
+	if ((val & mask) == 0)
+		return -EINVAL;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+			if (val & (1 << ((i * adev->jpeg.num_jpeg_rings) + j)))
+				ring->sched.ready = true;
+			else
+				ring->sched.ready = false;
+		}
+	}
+	/* publish sched.ready flag update effective immediately across smp */
+	smp_rmb();
+	return 0;
+}
+
+static int amdgpu_debugfs_jpeg_sched_mask_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *) data;
+	uint32_t i, j;
+	uint64_t mask = 0;
+	struct amdgpu_ring *ring;
+
+	if (!adev)
+		return -ENODEV;
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+			if (ring->sched.ready)
+				mask |= 1 << ((i * adev->jpeg.num_jpeg_rings) + j);
+		}
+	}
+	*val = mask;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_jpeg_sched_mask_fops,
+	amdgpu_debugfs_jpeg_sched_mask_get, amdgpu_debugfs_jpeg_sched_mask_set, "%llx\n");
+#endif
+
+void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+	char name[32];
+
+	if (!(adev->jpeg.num_jpeg_inst > 1) && !(adev->jpeg.num_jpeg_rings > 1))
+		return;
+	sprintf(name, "amdgpu_jpeg_sched_mask");
+	debugfs_create_file(name, 0600, root, adev,
+				 &amdgpu_debugfs_jpeg_sched_mask_fops);
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index f9cdd873ac9b..819dc7a0af99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -149,5 +149,6 @@ int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev,
 int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
+void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
 
 #endif /*__AMDGPU_JPEG_H__*/
-- 
2.25.1

