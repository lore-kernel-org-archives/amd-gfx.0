Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306BCC0219B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 06:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC3610EA20;
	Fri,  7 Feb 2025 06:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x+hGgl2Y";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B8910EA1D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 06:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oe2Go7q9H8HzJOeAN4cp04EfYh7oOlRYSAszs6g6bZBl54543YIWOyARv3PS3n1AhdvBHtT8gVPlobUrQ49bXRtPcTp4kCMJE/D8zUJgKKmQPsTTeQvDJpBgkD550TrOMcbmBmpbZ0Cm3otrPWrUEky9rfeOBZaszp24ai1+NxjOBHDBRbjTRpULjrkO20kmyOGecgDB2K4ZuehQfbfdPZ2K4xwHasPyq3xRdRb4apKxh1w3/fY9PpD2rtChBic0YM+DDFINIsFWmgESqAXEDDKbL+Ip4+xPHdZDUyTHXULVSOkLlk7A3LZ0oai06dQu0Ygk01cM00TCGbeQXQRqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e24qiErQ0EHQ5BI5VivVh54/C2GCRfpX3xJocNlYpmc=;
 b=JVH8Dgo2rom1hhp1gdO52pX1oT4Ke/IATmpYrORvN19W2JQhF1S/fPP4qB1FPdvmVYNrNiqB1vybv3G4mEPqZL9IlImZ+kQxp8SXStrpm0mVpI8RgqpreSPkY0rgYw+ah/n4cDgJh0AqNpKMBzxv/WaTwRsc6M8G32XHfZYIt3RZIznWgZvEjiLdksxVJtiQYG2UzWOaJRd2ZWwUVAQsAr+F+SpURuhEWQ9IUpuw8R4j/in9R/bnbDJHR/gkrjLDvytmir60BKMFD555Li7/w4TNvrjI7AzCIeYh90ci9hvPk4Ct94c50GNcdlTisfC+n3qN2nDwy1Dc0HvZRowQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e24qiErQ0EHQ5BI5VivVh54/C2GCRfpX3xJocNlYpmc=;
 b=x+hGgl2Y9gyppTPgKao4VS//GlU97H2xU60bMfG55Hc2OgQHstsEXzinWZ1IWwHFkjE2aLZ8dKH+b+XmKFJp7d8uV1kFIdz5SCkIC7pv9TkSW9i9l+MFYOBMG8hC75m43Jw18ZFgGu/iAq1WpFpiche+4wh7Wjif7AVG8mphD2E=
Received: from BYAPR21CA0017.namprd21.prod.outlook.com (2603:10b6:a03:114::27)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 06:03:33 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::ef) by BYAPR21CA0017.outlook.office365.com
 (2603:10b6:a03:114::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Fri, 7
 Feb 2025 06:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 06:03:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 00:03:31 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 00:03:31 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 7 Feb 2025 00:03:30 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: set
 CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 for sriov multiple vf.
Date: Fri, 7 Feb 2025 14:03:20 +0800
Message-ID: <20250207060320.1564404-2-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20250207060320.1564404-1-Emily.Deng@amd.com>
References: <20250207060320.1564404-1-Emily.Deng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c836dc7-1efe-4328-de60-08dd473d26d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sdPZe5TNvc/EtjMDmxnl53zaL0lqygrGFgaja7ZfPb+w8wN/cGnQsbd/KZwN?=
 =?us-ascii?Q?d+TIoTwcl6sxafoC1efOkq5hreST1t3b+hiKCh0WDFS/Z1EvUT4xlif8iWSc?=
 =?us-ascii?Q?Mw2v2nnYyRBdS0wOxR7T4RyTsavPGrD7+kZ0ly/+in5yboQabu6ggVLLe6a1?=
 =?us-ascii?Q?IsKPGOLKSRQf95wJ05UweVVA/b8+/P5FZpd9IlLEKB6p1eyWbF9DwloFe1Yj?=
 =?us-ascii?Q?BOu+3OKEaC2w7wpdRbu1PEVQ8xd3u+5ZLWOiXrU7tburNJqVE/DoFxnFRhat?=
 =?us-ascii?Q?kbPdO928WBMbigrnoru7TLJTv1lC6XOZP5G8VtMj8yI47dvR7RykARjIh04P?=
 =?us-ascii?Q?TGKbhRaDbHdPxREBAR2o5ADRmRX3K9bydgsUL42o+3dImE34A6aeZIl56ZCc?=
 =?us-ascii?Q?a69A7P3qHCyODjV/Mslskyv4nQ/W4rSoshONOwe5hlmBhRlURqBfyP7TvXg7?=
 =?us-ascii?Q?ttmoYWTjxm9U0n54++0l8c4K+rU96bvyPPpXg7+HR1G8/b4J1XoeSnElRpC6?=
 =?us-ascii?Q?v2VBIM4K72Qwn1QCzO5xmfw94IpPNSD0fFCbL6zr6931ZI6m4B1/q5VptLFv?=
 =?us-ascii?Q?HLU5uWlFNDAGpipCPi+WgdYDUPYpwqkJp0W8YHlxlC5OsC4QLw8okkV52XfO?=
 =?us-ascii?Q?W5Hcw1hVyfdqL+6FFCe6fPip/nlxndG8IxxD6fUTWektp3nBtlHuN+3StIql?=
 =?us-ascii?Q?Q1FgN+pno/4tPEzlVZMvDdb7JlrFl3yQqUCbDIhh+Dquaardas6L2TtL6NJ+?=
 =?us-ascii?Q?2WotwD/u3D6lMrUhu4Ey++s2GJcutQWMH1fLpAvZsglnYrN3rCR9W7r21hpJ?=
 =?us-ascii?Q?tcccpCjo3cZHgzv1EpN2qfBujdLOvOICCZAZRzCMud2J01pjxEcyx2H5ghzJ?=
 =?us-ascii?Q?DlJHdMlwEMNdMqA1mYJ/QKkS6ajXAdUbQvwB55xdXJnSOAJg9GZ9VbvSp6Of?=
 =?us-ascii?Q?tBWUCvGOUT83guQNcNvZ0Vlj4+g0RGDxQC21zBfJULvSILxO/zCRsJD6kgNZ?=
 =?us-ascii?Q?zO+silSdbjnvwbUvVUOQHV2id+z+0onLa4B4UDB45k2O9Nx4uQV2wx94Ob+S?=
 =?us-ascii?Q?bi7iPfBQzChr3eMCuTOrf8I7RGWwxiPhiEBeV6wXo9F2Jv7gP15BWtvZqvMR?=
 =?us-ascii?Q?OfryAhJHuYSWkpHXWB8ywQMhWtmhR/8c3ElMQIgnXB2MddL7wcOYPn5PjjZt?=
 =?us-ascii?Q?F5DEZU9LC9ruO1K4+IJfMRGxLmZ1FgeMcj7PHfbiOHdQrckf9Peet2pcw0ly?=
 =?us-ascii?Q?Dbh2033EOwc4t1FmFKSL02tBw/IOl+dcYj56D91NokwGSMxaQJUOjg3sMHRY?=
 =?us-ascii?Q?9Li3LNnywMlv60Jk5ehmHgiwptMbcrrNOd9/256C3/5vci75P14X5Lju16K+?=
 =?us-ascii?Q?CWWDpzganNZXrzHqQtugbXFRsFeHXxX3qvcOEM4u8LqLOqWbGlJlDZc/05lQ?=
 =?us-ascii?Q?rxrYsGu2eL/tYcyzgvXIGYGhhQmVtqMF6JbVgZ6gH5FFVr1UpCc1jX0Qqy8M?=
 =?us-ascii?Q?hJvF2Gl+EfhBz3g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 06:03:32.5042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c836dc7-1efe-4328-de60-08dd473d26d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
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

In sriov multiple vf, Set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 to read WPTR from MQD.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 +++++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2ba185875baa..42251f2b9741 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1857,7 +1857,7 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
 				    DOORBELL_SOURCE, 0);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_HIT, 0);
-		if (amdgpu_sriov_vf(adev))
+		if (amdgpu_sriov_multi_vf_mode(adev))
 			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 					    DOORBELL_MODE, 1);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index ff417d5361c4..9e08bcfa37d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -551,7 +551,7 @@ static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 					1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
 					1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
-		if (amdgpu_sriov_vf(mm->dev->adev))
+		if (amdgpu_sriov_multi_vf_mode(mm->dev->adev))
 			m->cp_hqd_pq_doorbell_control |= 1 <<
 				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
 		m->cp_mqd_stride_size = kfd_hiq_mqd_stride(mm->dev);
@@ -724,6 +724,9 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		m = get_mqd(mqd + size * xcc);
 		update_mqd(mm, m, q, minfo);
 
+		if (amdgpu_sriov_multi_vf_mode(mm->dev->adev))
+				m->cp_hqd_pq_doorbell_control |= 1 <<
+					CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
 		update_cu_mask(mm, m, minfo, xcc);
 
 		if (q->format == KFD_QUEUE_FORMAT_AQL) {
@@ -746,6 +749,21 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	}
 }
 
+static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src,
+			const void *ctl_stack_src, u32 ctl_stack_size)
+{
+	restore_mqd(mm, mqd, mqd_mem_obj, gart_addr, qp, mqd_src, ctl_stack_src, ctl_stack_size);
+	if (amdgpu_sriov_multi_vf_mode(mm->dev->adev)) {
+		struct v9_mqd *m;
+
+		m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
+		m->cp_hqd_pq_doorbell_control |= 1 <<
+				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
+	}
+}
 static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		   enum kfd_preempt_type type, unsigned int timeout,
 		   uint32_t pipe_id, uint32_t queue_id)
@@ -880,7 +898,6 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->get_checkpoint_info = get_checkpoint_info;
 		mqd->checkpoint_mqd = checkpoint_mqd;
-		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct v9_mqd);
 		mqd->mqd_stride = mqd_stride_v9;
 #if defined(CONFIG_DEBUG_FS)
@@ -892,12 +909,14 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 			mqd->init_mqd = init_mqd_v9_4_3;
 			mqd->load_mqd = load_mqd_v9_4_3;
 			mqd->update_mqd = update_mqd_v9_4_3;
+			mqd->restore_mqd = restore_mqd_v9_4_3;
 			mqd->destroy_mqd = destroy_mqd_v9_4_3;
 			mqd->get_wave_state = get_wave_state_v9_4_3;
 		} else {
 			mqd->init_mqd = init_mqd;
 			mqd->load_mqd = load_mqd;
 			mqd->update_mqd = update_mqd;
+			mqd->restore_mqd = restore_mqd;
 			mqd->destroy_mqd = kfd_destroy_mqd_cp;
 			mqd->get_wave_state = get_wave_state;
 		}
-- 
2.34.1

