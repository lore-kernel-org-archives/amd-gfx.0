Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250CECAC5B5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 08:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD5910E3B9;
	Mon, 29 Sep 2025 08:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gR1+z7aA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A000F10E3B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 08:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQNZMewEBhSOcfApdPYF3UP0hyi+b7MxCzGFCTGdoTilpez8v+XQv11ev0rj5+o3gXC6pqrsGOQ5zOrmg4lsn714i9oLXdTFZG+8rpmXyGG32Nf9NpP0BqmS5bQmfvTZUgSMxbL2Pm395dFTNcGI48PcvFnExDZ4Pphx/yizfA2pwtsyHwvmZpOmTSDmSktz0VkzujuSUQIqASFcnx8RemXUCPy1FmqotFQ19LoE3D7Fk++V1Eb0TUe85FPoPZQBmc0VCvTNxGwbjsJlmyTl5gbUVR1HUWwHzB+Yl3bU0kXL97+JIvwqNRPE5bZia+xsN06rhrDGsrwoWioiri7I+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSjyJU9RELTRTcm6kuMuYOAXiXqZu2jJ2vdX/E6Baz8=;
 b=C09YSfnScnRZvIjidmUeyUpZJpNOkw3XICe7LqxtnUOUWh+wTRh+DSATS7FkNG5UyRG1DFNuSrupGTmf0dRF++4iLL5IpjeHPtRUSBQ9szFgaTx/c+QaTGLo9tEwAVwUGib2oRmWA4B5ifWNfHsEeyIpYMN+vybP9nxnwqA+Cz4tBPmZzKtiVPtyQY7M6qReGCpANDxo3bqfCr9oKuY5S2D6yq3HT4CkY2cdgAxL80yCQJktwQN4tEZS5LzUb42FG8+9ZNfB+DZxT5r2CStxPuJWoWSPvro65zUCfxvXZ0072OxrRXL7XX4AYEK81/JBmQ71epxB01ppkzBnT09Tig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSjyJU9RELTRTcm6kuMuYOAXiXqZu2jJ2vdX/E6Baz8=;
 b=gR1+z7aAEC6r8gYGiG2yN7GVROWC3jdvk2WKwEGC7QmPRwCwUTO6Wk0Q7NTZll3OccFjaq4WW3nvSbdcI1Q8bl2PMAjUtUvggtzCNHCIF9twzWYGvyUqJjeSYlnBOcw08wvpQY/ghAxcGylIvn/6SOkvvydpXzpHdopJ8/u3x9U=
Received: from SJ0PR03CA0167.namprd03.prod.outlook.com (2603:10b6:a03:338::22)
 by BN7PPFA42F4F89B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6dd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 29 Sep
 2025 08:10:07 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::d4) by SJ0PR03CA0167.outlook.office365.com
 (2603:10b6:a03:338::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Mon,
 29 Sep 2025 08:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 08:10:07 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 01:10:02 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 5/8] drm/amdgpu: validate the queue va for resuming the
 queue
Date: Mon, 29 Sep 2025 16:09:41 +0800
Message-ID: <20250929080944.2892809-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929080944.2892809-1-Prike.Liang@amd.com>
References: <20250929080944.2892809-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|BN7PPFA42F4F89B:EE_
X-MS-Office365-Filtering-Correlation-Id: 05971946-ddc3-450d-da11-08ddff2f9a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vyEfPWQk2CkWeSQF/MhIkHRg6Ux4n+mpb52F7+GXrZjZai21DsK7zNDWL02/?=
 =?us-ascii?Q?/Ab+7Xzh69LkcVqmZqx/TpzHt7i2f2TONMVx1y/Yt+OBHo793epjEX3+bCsF?=
 =?us-ascii?Q?SW3n15E7CCO3gY/zvfvB2GFB/agvDfEx6XGIQoh8zxTh/TP/fhlYD5LX5zFN?=
 =?us-ascii?Q?1iTDAxd5Cvv299eXyT3yRDFDUgCVA/vbVs6BOWkHWyYWu9/AbYhR3XZBBLfb?=
 =?us-ascii?Q?D8FzRLx/1M/xmdp4RLQUSY8dOtWUMQlv7XK1zly9r/RsTVCQIS3J6QW0FqGQ?=
 =?us-ascii?Q?SV2EG1S97nK8u8VD1bbRqFvvDTFYrPwzbG7Uc9JqcLvPqjsWjoDwqoHnF36E?=
 =?us-ascii?Q?DUvltw6G2omZpVHCNVAtajbPm4JSmNB/rybdwUcbPPyjngrVZ2UDOsKJyW4B?=
 =?us-ascii?Q?UiwJPBkBboC0H+Bg8VGEQxd7zglTVTnGAqvghGIjWBqwyNQJfTVxBWgb8PgK?=
 =?us-ascii?Q?UpRuxrhI2AdLg73eYy7hlAhU1z4OLR3YVtt5vRXtrOhVxRFtlZfJxYRZrIht?=
 =?us-ascii?Q?qkPZXcJms/xhiFIYUlaPalPIq/1KchnC1wy8httU/POned+Koghc/RGcNfnH?=
 =?us-ascii?Q?57+98itTgqtKXuBxWHPMKDL8fkXt1UO0UkiH185XEaKNrCSIqJcIl2rFt71X?=
 =?us-ascii?Q?cWqyWR61r4tLmSggiHENailxHjlEacdIB7lDnvCdGQifpg9zFP8rw2SP4TW9?=
 =?us-ascii?Q?IA9VfLxgNhDkQaAAgT2BiUmUk/6nTWfVeD62EtmUgFXcZQ+npGC07IDqkwfc?=
 =?us-ascii?Q?MXtxB2IZNaAyDlpWLQypShTuOfSe9SA8gSWgboPybQYbWIoOm8j6DeUK38Le?=
 =?us-ascii?Q?Apmiqc5C1ynt+agfvh0l/e6ry5BgKIapMy2DHk7HfiCHMxSdgV+wj5J5IBMW?=
 =?us-ascii?Q?jvtWs5VlvY6UKt0B8ZZbtu/40sALMqm6uXkHZ1vT7WvSjeNvxopjgeJ9DICx?=
 =?us-ascii?Q?WaVyvD81hPDBWu1MLGBywuTgZfmtm8iZnPqz6783QMO+Npe7ERDFbHicauxl?=
 =?us-ascii?Q?+oS1roeizn6zq2dTeQSz8ThlYCI4lOUJ0w6cX0Nao+mbfd2bgH2spR4gJ2Vj?=
 =?us-ascii?Q?v3OTpg54eo5BzS0bwuRpdzCHptp+WOg1bB74G/IbElb3AOvSS8wXUkG8mfxx?=
 =?us-ascii?Q?Fxc/WFsMXhsrDfD2PsLzJCB5rsnqu3tJXxGM4z1YgeUwBHsQEDS/sTMuss88?=
 =?us-ascii?Q?j0RAXrjM9e6mqsifthaaLomPpC2OYtQi7Y3W5H5AmTkXcRu7ZI0YArT75iDg?=
 =?us-ascii?Q?s9kX02RJ8KGSD0oM37WQM5X3yF67s7JkDAEBBWk3oS09Hqz4MZb3gxrvPZhw?=
 =?us-ascii?Q?KOMO12T7QUyLt/itzZv1luT356fBwnmZUzM2WCDvJbKWHMpITJL/K6J8EGki?=
 =?us-ascii?Q?JCXhwVVcxnM3pxKVnmp/ECtyb+2B6AMM/ba6gLLnYFSHQtUjh3UaXUY12V8h?=
 =?us-ascii?Q?tpwk7qMONyUmOt+fdnER5PR3GbMlCOFarh6BaE82pun4YdJYrTBpGNUzlaCF?=
 =?us-ascii?Q?av0uvFjcMcsWQQnFHHo1o2l1afG1llCIUw0AV0mm6bKoZ+gQOXDp1VBJmZb7?=
 =?us-ascii?Q?NHg62FRuQtsp4/VmHlU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:10:07.0381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05971946-ddc3-450d-da11-08ddff2f9a2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA42F4F89B
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

It requires validating the userq VA whether is mapped before
trying to resume the queue.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 93d92b6ea86c..15ab2f4c1952 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -116,8 +116,27 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 	return r;
 }
 
+static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
+	int r;
+
+	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
+		r += amdgpu_userq_buffer_va_mapped(queue->vm, va_cursor->gpu_addr);
+		dev_dbg(queue->userq_mgr->adev->dev,
+			"validate the userq mapping:%p va:%llx r:%d\n",
+			queue, va_cursor->gpu_addr, r);
+	}
+
+	if (r != 0)
+		return true;
+
+	return false;
+}
+
 static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
 					   struct amdgpu_userq_va_cursor *va_cursor)
+
 {
 	atomic_set(&mapping->bo_va->userq_va_mapped, 0);
 	list_del(&va_cursor->list);
@@ -778,6 +797,14 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+
+		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
+			drm_file_err(uq_mgr->file,
+				     "trying restore queue without va mapping\n");
+			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+			continue;
+		}
+
 		r = amdgpu_userq_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
-- 
2.34.1

