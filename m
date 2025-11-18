Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC138CED24D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 09:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786E310E446;
	Tue, 18 Nov 2025 09:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5J9JB61g";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9564D10E14E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 09:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbk4tS3iruSi/Oq1bLRXNsCfUrWkpeall2rOzgHYGdvBEb0Lm/d8qKCzITWg3H11+85Fguwbs7lr8njkZbt2Wlncjh/UF5+WFHkQXE4AAbSkvxR2rdyLivHYrWR5OsGKXxKAwU8/cp+cP6li2TgebxR1OxZQ9kd9zs4m90IviQh2gXKLXBwivx3nlAU7m0nsPeIP0KpdB066uT3TiWdEGxXy0rE3PhBD6xVXpqEQ1KO9K2SvalD5wXUniU+ENZplYuzSueMZJOhPjX4NN9ty6BISzhSxUStKx3hp2cPKGTCcg39FrlPtilCF7us/zvcCDxtJ3TOdBtwaaJW6Ofu9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBgszdVFDxyDBixkqwttdByppnCfKQT9zdbm8VHWHXc=;
 b=zFpgmIGSDnbDhdAYV2R4IkQ+ueY6Z9MoP3PpLaPUOM7zL8NUX27/ZMYYfMM+xAa56J28g6tldaBV1vs07P5dn094/OJOE3RQH+pxpNKUbkZUhFXePdUGHiEskhT66w5A6G4styof4TTllWg5D5vmB97GjW9GbYlqn/PlsbR8eQ1hS6CfIzo2AJylf2vPneKIZye9OFsTjwm9FRoPqbeHQlUZa0n2YNqp2sTeIvHhnKDdWTHoo4gbicA3ak+lOz0qYKaVc84TfkjKXqXaPr0CeSFNqKicBKrYqchmpysrL+3tW9g1VtoaeHW3t4cKUqk/4Iz2Ic3I2PVWeirc5DeutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBgszdVFDxyDBixkqwttdByppnCfKQT9zdbm8VHWHXc=;
 b=5J9JB61gtjKaxJlJt66hLNO1YVRfqOrr98h0g3dfvidcCqrQdN3/QKWgYwWUyKIUn6Np+5NwEhr3DQ08Er2eJm6XC0ezyFm3p+RcZRZMEb8snFYagEHvhBZc9VCjoo3WgZLBqZKcgr//HDXqQt1qsGhw98hP2u6IVyV1eCMQp8M=
Received: from BL1PR13CA0309.namprd13.prod.outlook.com (2603:10b6:208:2c1::14)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 09:16:56 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::8c) by BL1PR13CA0309.outlook.office365.com
 (2603:10b6:208:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 09:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 18 Nov 2025 09:16:56 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 01:16:53 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: Add virt command to send VF ras command
Date: Tue, 18 Nov 2025 17:15:53 +0800
Message-ID: <20251118091559.959683-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 96978bc0-80bf-4929-4cb9-08de26833877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KoUjJa36U54nyz7bFK3OJAHSYKfi6IUbIuHi/TFxc4adzrWKq95dxrXw3e+s?=
 =?us-ascii?Q?a/k3JPNJXSFBbtTMTosM2cBk+dE1Qd4hbBNI7zRzViyqFV7jYSsVpLyY4H0p?=
 =?us-ascii?Q?yC5XymU2M1Yp1+vOf2UcXwuQ10goC5dHEXbSj2X/yiW03ENUuebm9mJPmT4I?=
 =?us-ascii?Q?VuYk6o5aMWna54BPU+Te4UW7dXs/GBNRii8ORUz7p6dnGkzKZHn6dH3PyNKf?=
 =?us-ascii?Q?HE/uEYoiAl0i3f70heu1oq7BHn1qYkWR5QnAF2jCyxfd8V3SdhDIlLXTjEw0?=
 =?us-ascii?Q?Q8GbvKC7crOWAdDGQSHNSRAE3XEW8BuxmO/Fdv8Uj1k9HmBv+GQeL0F18/aj?=
 =?us-ascii?Q?NPfyYGqnu8HYigJbB53USPUKivPeF1N7b6I7Wn5EFNw4ZBqg71I5wFXneMht?=
 =?us-ascii?Q?TQpQFAb7E/yZFGeFq45E+FEOnYKaK2OT72fJSl7VfWV/JgJW5XUC/C3g/sAq?=
 =?us-ascii?Q?VZU/nhNJuqNG480FbdZ5eLAjXVIhnFeL8r1qKvt4T7QhpWaOJ8fCX6YBerwl?=
 =?us-ascii?Q?Bs1sD7CeNyEJNaLpV4nldO5iSZJHH8F2tc4dyVKTRFhf0Bk567uEpiDdUeFs?=
 =?us-ascii?Q?22kd9sBxkM8gnTkmwE/SVst1AUIB0sjHLwh7fBDLYkM+jGoUoi+PaV6F/nrD?=
 =?us-ascii?Q?Gwqsp9R85cfR9GMOxR6yUum6ccK+v0RI/Finl7l5QYOA0XoWX2mCkKtkQkYq?=
 =?us-ascii?Q?WLdDwcmfNsYXrj3buz5e+wX1q0RdDMS2OuZMgIhOWg3K/qCItgJR1aNCt9AB?=
 =?us-ascii?Q?LTP1XSF99v3Pdx7TVevxbPdweKgo+WFtsslOzfyLRZEbfYaJssl5++u/0TFe?=
 =?us-ascii?Q?1VngQzr25jjG3v1gxVkjyGSGETwdPgc99yYXiYK8drTwEUVv2wRo/JSXcT13?=
 =?us-ascii?Q?w6yGk6kxa2d62tvAtfh9pWNE+PFlJpFdYK5bcAEnpmDtWouCUV/n4n96tInT?=
 =?us-ascii?Q?why2r6tJ+VKJCuD4R6ZaIdrAZEqyGsN3DQ0eomQzdgQSHr7e37HEI3RnihpL?=
 =?us-ascii?Q?4C69nGkNYlzgLCY6UDoPosWAU5zf5lNNt3Snhns809p+WQVi2FIrYlPoqPYz?=
 =?us-ascii?Q?ieUAnmk8ZD+P0ohFDrladCZla6so5TKUgrRcGUk5VMGIH8G6km+QBV4gQilA?=
 =?us-ascii?Q?Rii+fUojvbxplWju2e+2Yt5gibs4DFOazbiYWxnN3yu3wCXvawALqGTPbIRp?=
 =?us-ascii?Q?CcweaISh95c9jjcZRs2r8ZNBfxKDS4ppIesgW5md4J1MkjFSA4+IN1VwCfAT?=
 =?us-ascii?Q?HJhfviogMDc77loLNLOgL29lnt4FKFCNtfPdkUpksHXUqZ5tJ1D9jkknWkE5?=
 =?us-ascii?Q?onmp8p593DZwf0J8LZqhglG5GRCxCkz7z2CLjUztZa0Suoq1sGyNLFW7lvmu?=
 =?us-ascii?Q?sFbpx7/157m1/wZNRKDu4SkN+8LuAbRb+I1gQjlplaYiDRY386qQOBYjL4bA?=
 =?us-ascii?Q?WLULtH/8GRHlaJQpIWx0TaTgeWWN8DI2LFYBQknwMGMctGg3LZn2ilVW+H3a?=
 =?us-ascii?Q?dmQplsdZljNhnaMYdO0tJn7Lia0E0mCG3+jCc5nBzqF+5fqK82UWfsjlkCht?=
 =?us-ascii?Q?c4zsqT+x/O+PFuWN7hM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:16:56.2647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96978bc0-80bf-4929-4cb9-08de26833877
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464
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

Add virt command and interface to send VF ras command.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 25 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 13 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h    |  4 +++-
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 47a6ce4fdc74..2d48818773c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1845,3 +1845,28 @@ int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev, u64 addr, b
 
 	return r;
 }
+
+static int req_remote_ras_cmd(struct amdgpu_device *adev,
+			u32 param1, u32 param2, u32 param3)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+
+	if (virt->ops && virt->ops->req_remote_ras_cmd)
+		return virt->ops->req_remote_ras_cmd(adev, param1, param2, param3);
+	return -ENOENT;
+}
+
+int amdgpu_virt_send_remote_ras_cmd(struct amdgpu_device *adev,
+		uint64_t buf, uint32_t buf_len)
+{
+	uint64_t gpa = buf;
+	int ret = -EIO;
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		ret = req_remote_ras_cmd(adev,
+			lower_32_bits(gpa), upper_32_bits(gpa), buf_len);
+		up_read(&adev->reset_domain->sem);
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 01d5bca2dee1..608d966701a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -105,6 +105,8 @@ struct amdgpu_virt_ops {
 	int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
 	int (*req_bad_pages)(struct amdgpu_device *adev);
 	int (*req_ras_chk_criti)(struct amdgpu_device *adev, u64 addr);
+	int (*req_remote_ras_cmd)(struct amdgpu_device *adev,
+			u32 param1, u32 param2, u32 param3);
 };
 
 /*
@@ -483,4 +485,6 @@ bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block);
 void amdgpu_virt_request_bad_pages(struct amdgpu_device *adev);
 int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev, u64 addr, bool *hit);
+int amdgpu_virt_send_remote_ras_cmd(struct amdgpu_device *adev,
+		uint64_t buf, uint32_t buf_len);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index e7cd07383d56..78408b257afc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -209,6 +209,9 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 	case IDH_REQ_RAS_CHK_CRITI:
 		event = IDH_REQ_RAS_CHK_CRITI_READY;
 		break;
+	case IDH_REQ_RAS_REMOTE_CMD:
+		event = IDH_REQ_RAS_REMOTE_CMD_READY;
+		break;
 	default:
 		break;
 	}
@@ -585,6 +588,13 @@ static int xgpu_nv_check_vf_critical_region(struct amdgpu_device *adev, u64 addr
 		adev, IDH_REQ_RAS_CHK_CRITI, addr_hi, addr_lo, 0);
 }
 
+static int xgpu_nv_req_remote_ras_cmd(struct amdgpu_device *adev,
+		u32 param1, u32 param2, u32 param3)
+{
+	return xgpu_nv_send_access_requests_with_param(
+		adev, IDH_REQ_RAS_REMOTE_CMD, param1, param2, param3);
+}
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
@@ -598,5 +608,6 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_ras_err_count = xgpu_nv_req_ras_err_count,
 	.req_ras_cper_dump = xgpu_nv_req_ras_cper_dump,
 	.req_bad_pages = xgpu_nv_req_ras_bad_pages,
-	.req_ras_chk_criti = xgpu_nv_check_vf_critical_region
+	.req_ras_chk_criti = xgpu_nv_check_vf_critical_region,
+	.req_remote_ras_cmd = xgpu_nv_req_remote_ras_cmd,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index c1083e5e41e0..dc57a4f697ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -43,7 +43,8 @@ enum idh_request {
 	IDH_REQ_RAS_ERROR_COUNT = 203,
 	IDH_REQ_RAS_CPER_DUMP = 204,
 	IDH_REQ_RAS_BAD_PAGES = 205,
-	IDH_REQ_RAS_CHK_CRITI = 206
+	IDH_REQ_RAS_CHK_CRITI = 206,
+	IDH_REQ_RAS_REMOTE_CMD = 207,
 };
 
 enum idh_event {
@@ -64,6 +65,7 @@ enum idh_event {
 	IDH_RAS_BAD_PAGES_NOTIFICATION = 16,
 	IDH_UNRECOV_ERR_NOTIFICATION = 17,
 	IDH_REQ_RAS_CHK_CRITI_READY = 18,
+	IDH_REQ_RAS_REMOTE_CMD_READY = 19,
 
 	IDH_TEXT_MESSAGE = 255,
 };
-- 
2.34.1

