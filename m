Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A139BCD3447
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2026 10:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F0310E0EE;
	Sat,  9 May 2026 10:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UgnCW4o0";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E83C10E0EE
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2026 10:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3GsOholRDoq6Zr6jgNommzeSiltHI4OofW/c+L0nHu+2Z2Z2mhgvZ8I0ZNsxShqJdMiEW0ngoUp0IVDH8hhwWZlIw6wOSABcr6vxWnWk6XPYhgYyuO+lW+iRGcp1F12WYG+pxAKhJDom/es5ayN/028EUobWbnb2ePXie6qqUAdge1w3ttD93RQwDCedi44ns1p2X3rGv7JT/1v//XAOwQUQXMkxoi/L8a3J1VkNgNpnN8TbxPAjgUN63AulsIQtnbTjxyXgZoEmGgla+iYBNa6JM82tBsXWy2DHl+U4nqY6N64bkHX3o8wCS1m6oYC03ngSbINw5wrkUzLKUMRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKNXcXTYkvkyNLM0DBA8KucEcHhURDISl+hino30jUg=;
 b=OTjEpKxcVwy+HcYjR2ZO7mS77zdtd1HiJkTBcqzkQgFCLoMf2ERH0qblcQJ7PMALSQesS3Zn6Q+d6u6IXj4A5/cXjf2+ixLQlIWXTLdYftOwBOJvra+RdeTkKMUlIfZe6xYdf+GhlXMVIHbRxnGnijm7wW1BGUw+0f7sabpUjocjtGaA49xgrAP1IYc5JseYS/L36RlGUMEHx9GBGV5dEB7mIG7dOzr74+DqdpsvXzDMtPPCe0YLz1mntxQ+7OoJf2CtLIBX9hKUeLCr5xh6M8GJPi/sjT8f5L+lVvaRIAxkHuLfIkde3XUQq1f3DXXIQDa8LMgph3Zulf37I1R5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKNXcXTYkvkyNLM0DBA8KucEcHhURDISl+hino30jUg=;
 b=UgnCW4o0LIzLupYYT4pjEPzP/Wt/RLTwKJWd3tqwnWybH5FFbwlPS5a8wQrTw33sRqT9GsiRmgG3lV1cBGLmrPb9I1IBK29pLWv8RXlb8l2etgZhI7UgZb3/r/yFL94+ss+UcUNAdT7EQ7r5jvMrrBzSdpF/yKEPO3MZdm+1UcY=
Received: from SA1P222CA0070.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::26)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:15:23 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::7e) by SA1P222CA0070.outlook.office365.com
 (2603:10b6:806:2c1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.21 via Frontend Transport; Sat,
 9 May 2026 10:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Sat, 9 May 2026 10:15:23 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 9 May
 2026 05:15:21 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <HaiJun.Chang@amd.com>, chong li
 <chongli2@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add guest driver CUID support
Date: Sat, 9 May 2026 18:15:08 +0800
Message-ID: <20260509101508.587490-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 0778b9b5-0274-4f75-173c-08deadb3e1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: v46uxCTEojeGS4JB8a/1yT3/xcAJo3LbRL6w7KVREACMMzw6pvDiB5PUKp8zFxNmsTlpJ0H0xq3X5W5YjFLEE/K944FA3LlhOo68fksU5q+oU+c4t1Y8E/0jfsFVL3eeujnQQ5QX7mjO4KHihky0Us9fbvVkOz3GCw3zlTVYOZJEDkw2qIIzCVTtvJmO6ITvyryT5OKH5cUP89hwCVnCfbto0UpWyniXC2JonI6clvlsZvXaiVDnTYZbzrviRsj/dYH/UFvg29vNtqrShV0iafIG/OQUouY+8oDdQ21NeMzM//1wugNd6iF760Ok1jNlcgRbxXvXIyqpSGRga0jJsfb0JGJv48sLBmwAR4f6Ro35RL3luqCgO1Bix3iKsQE3edq1SPudQmQDfaIoaeb6SxJcS431OZMxCq3v/ONaFwR50Vp4XovJh0BsediV3zxVHItt5ESiy2XkshJVf+lkCO7nFIFlmTn2seScTFgVTAXExZn3wLU2v6R4QrNSvwhFSoofPpKLdeEV8ylckLqdFrkfBCF6LJNxi6oTpe8SGU9cZig7kGf+3CQe9gVzZgqz+zonIdqk7c5lBNtijgnyiXD+pdkkcYrserk1YbsGEJgkKhm4C7oZovKRF8ou9DvzpiAuV66lW6tjzhC14RbuZSR5gsx46RInxLW81l/1+PafNgaFSCedAPtt2Ld7sYUa/cM+jRl4K5wqZSgO3ey0/f7SIV29hBtPq7YidGrkybk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AKr2kf6kLBVxFp5n3FJXLvSYAcYivrhrHG2rZg1RQ/NCHAT3xS+jfyDxYm8rgOPsiIjJsz41n91hRmPfYjxGa4tVt27oJ74R/X3ZLXnXyj+j6IdmMO/aCdyBzkBtvtd6+6VvEdjAkEYX9nKKrvte9NOIf5Vcjo26AFkb3PaBJDrBBxFDIYTNThVzRREBjp2hVqMgwG35gXism/L2w2s3ZmTeuXuClHxkLPlHGImdFbA9dtKjZl+fca5UxmgLtHymSdu0RDp4c7+ckJM6JakcOsxjhloYNBt9VEMpvnGWCw3IGU6UsuWCx/5B/AP5/juuCM9fEfO84qoNlkH8+yHSlieW+jRKgu1JudFtT++Rkycsk+n0SO6zCuPzDeur6UoypJ3NDFw5rb8qOqwLB8N/Uks+y05IDOmo5jTxYzXSMyk3buUQER/USZcZzNHSWdo9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:15:23.2840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0778b9b5-0274-4f75-173c-08deadb3e1e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
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

v2:
use debugfs_create_x64 and debugfs_create_x8 to create node.

v1:
1. Add guest driver CUID support
2. Do not expose vf index(variable "fcn_idx") to customers,
   replace the fcn_idx with pad.
   Only expose the unitid to customers.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 80b18bbd7f3a..98549a148695 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1074,6 +1074,7 @@ struct amdgpu_device {
 	long				psp_timeout;
 
 	uint64_t			unique_id;
+	uint8_t				unitid;
 	uint64_t	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
 
 	/* enable runtime pm on the device */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 979032ecaf79..129ff0851738 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2126,6 +2126,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
 			   &adev->pm.smu_debug_mask);
 
+	debugfs_create_x64("unique_id", 0444, root, &adev->unique_id);
+	debugfs_create_x8("unitid",    0444, root, &adev->unitid);
+
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6974b1c5b56c..45e89e104b5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -534,8 +534,12 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		if ((adev->virt.decode_max_dimension_pixels > 0) || (adev->virt.encode_max_dimension_pixels > 0))
 			adev->virt.is_mm_bw_enabled = true;
 
-		adev->unique_id =
-			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
+		adev->unique_id = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
+
+		adev->unitid = 0;
+		if (amdgpu_sriov_is_unitid_support(adev))
+			adev->unitid = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->unitid;
+
 		adev->virt.ras_en_caps.all = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_en_caps.all;
 		adev->virt.ras_telemetry_en_caps.all =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_telemetry_en_caps.all;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 9dcf0b07d513..d80f01c0e754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -295,7 +295,7 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t vf2pf_update_interval_ms;
 	/* identification in ROCm SMI */
 	uint64_t uuid;
-	uint32_t fcn_idx;
+	uint32_t pad;
 	/* flags to indicate which register access method VF should use */
 	union amd_sriov_reg_access_flags reg_access_flags;
 	/* MM BW management */
-- 
2.48.1

