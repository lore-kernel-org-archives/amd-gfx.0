Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD726D13590
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 06:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA0E10E5A8;
	Tue, 29 Oct 2024 06:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qnH6eHL6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4CD710E5A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFBFBqGZOBsIrDP+ZDuA8Q5O683m5g4ZrWZwjpaBB2Cb0tqm3V3T3dxJQVYdCd3eJT8fu9quNMjqgXrGUeZdbDNlqZ7S0Gzp3W38ghAH+KvEKBUud6c/cXjJ/uV4VcVNgXU8HL5GoGnfMDA/7pCP1lPTt4azXqR8f3DmjUg5qHdeRvqNt5epeZp/6LtFLdrgFhwDFC9hoe33JKlWErq1500QWTvCdvOJtqkOAbSPbM3W/8kyj3oOuz9+geDZ2bHL/gqZR0NArPHMApJEs4KGHXKDPf+r/A3oNBSwx2pacSMhImGWfZpyJs6BwE416PgozPkWlj59lOqKY8ze2DR9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv7uz0jWYSa5yYiAryGbSJA6kbtzF9YdD6TaVRkMbC0=;
 b=ps0UwlOybYdcpaQawb8QA5JZvF8p/1pd/NDQvMAKP1nFQuGbs0rmWbFXjeoqawbyfz/F+GJeNN1+ApmUURtNBPT9ESUVuj4OHPaJ92oqtOS96L71iEcma+k6SAYrPYyWhtI9yuVkzU/s4Z1IK1DeEOe1euo1lxv1iF07upz+Jyc1HEJ8wmmZsXK290s9tLBmryYz9MiEWJWTV+Lk+0f7FnnfAawPqNVFBdtZShkG+R5j9MNwL1LBBwz3TdtQl5peecQ4+eflmg5jtPzzJcxKRij1XCalASj2poi7vE5aZYVUYp5zaQ0O62RRWlhYv42piu7c/qEJjSXwBPdkE3jaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bv7uz0jWYSa5yYiAryGbSJA6kbtzF9YdD6TaVRkMbC0=;
 b=qnH6eHL6b38PM/VgRKe9uzoNleaBSe+1WNx7lBj5pPb3NYjj6m4ufWWaQPlGe0NUU++zzp1BlKXPLSffagXXnudfpgSKsbFjVfKY3vVlaG2qgowQe/bsiqzoT+wZkCS6GRlLqHJ4eGEiQ9+uy1s8MPcCsXYnCkTNdPe+fky0rKk=
Received: from PH0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::35)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 06:42:06 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::33) by PH0P220CA0012.outlook.office365.com
 (2603:10b6:510:d3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Tue, 29 Oct 2024 06:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 06:42:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 01:42:04 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 29 Oct 2024 01:41:57 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V4 4/5] drm/amdgpu: Add sysfs interface for vpe reset mask
Date: Tue, 29 Oct 2024 14:41:35 +0800
Message-ID: <20241029064136.3057034-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029064136.3057034-1-jesse.zhang@amd.com>
References: <20241029064136.3057034-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|IA1PR12MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 5145dd50-d031-4119-056d-08dcf7e4cdb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ES53jXouO8Yk59ddbwllb++8fE4R8WNRtsit0ljbedjF8swJePwKdTnl2Grw?=
 =?us-ascii?Q?QeyofERQv+C3+XHagshfzAjq7y31Uv3dDMD5NkVkHJ4N35b/RfuL2NX2+5Km?=
 =?us-ascii?Q?/Cxvd8NeAZL0ww37rASPnHD93VYywymU7kj7G0uK5KtB9TXMrPPRMnnFmWu2?=
 =?us-ascii?Q?2XJubM0lx0VPSNUWtdwY8Zdy0UQq4RWX4HokuyGgoSdy0zBgUvBTCGq/JzRp?=
 =?us-ascii?Q?dYHhOtC6w0DeQeSSH7dCGK3QjwpbCc3L0latSD+Gx3y04c2gQPY1wqtS24Yf?=
 =?us-ascii?Q?JivIvAnGlZ89O4nzh7x9bOKqbtgs6TE7bY4HhdcKVmAUaKGrqXW6WAd+HRL+?=
 =?us-ascii?Q?Hq+OFWJD2ob9N9yJstxkAW2830qBoGc/4QRFddF6jokMq+e2SWzpQcNOnrhp?=
 =?us-ascii?Q?hYPgLHB3hTdRW9Aq/6UnXTf1EryeRCwUY/0Ir/qvOz85qkyl6mx/06vsSAW/?=
 =?us-ascii?Q?54fzhoNRzNlu3mSBq8b34D3dVjTZYt5VIhagSgsvohu5ZdMeC1dapyK03+uI?=
 =?us-ascii?Q?OhnvoIKIjefyWPpV60R/pgy1hYGzCEDfBzSD/chgHwyKxAa09Qx8oYEv9mvi?=
 =?us-ascii?Q?zYKQJhUu2zTo4tv6izmVV6tQnsyNPCJGCYFS8RqKbZEtMDbhhQfOO5jH6JvW?=
 =?us-ascii?Q?5KDb9ByBIUt57bL2qgo6PASXLhq8GmJmsHQ2AFrtGK6xQBsp7xorDBk9Xn15?=
 =?us-ascii?Q?2oTKKyiTO+qGWDLH6T2X99nEBUZxnhhBkoEBKG95II5qdlTYPgtsNlBcLReG?=
 =?us-ascii?Q?ImltHnvU7bVteALKvj+/cRsiSzUoj1pwy6US5QIe43mss+O2mt0Tb3/vWIpf?=
 =?us-ascii?Q?caJAnXGe3PsySCJzxtfSWo6XDEg2V0fSFT2kblJkqhurF4dNOExVx9Mu+KcA?=
 =?us-ascii?Q?pTx+LshGTxf55KkoOEszc0/R5Ot+n5V3QcvxyRB48Fif7TdKgn5lJlUL1uDS?=
 =?us-ascii?Q?97EkFe/BdhgEL9I77zSj/erwH13g42eE+nbQOcfeoEY8p5kocmugNuyoHGWP?=
 =?us-ascii?Q?JgfFUDoSM+4JlxaPuExRfu5zAQWpv3fz+qFp37KxyjrU7XbDZLHR7npwitzi?=
 =?us-ascii?Q?tuy7oF3MGzCMMrG4gZlWocmhQ0jZQA0oU2tD1a4T6gTX7EAaDMs8wkxU0Z3l?=
 =?us-ascii?Q?rkN5y467DiRZCH3BIMVlR5Emas4N4ntv3u64nSB57RKm8p6N2slHd7c+9Waw?=
 =?us-ascii?Q?Wza7RdpzBnLmVkerQkXkfijQEgUOu8AhZE2+4aFCXCZutBWrz7iz0Zo3GpAM?=
 =?us-ascii?Q?2UKXB6x+DJC8F5+qTN4+sAx5ejShwPIGx+/laKVUS+VL6UakWgX3PAyTR4BF?=
 =?us-ascii?Q?Rs1vIcfXEvUErc4SH8r73HqfKCaeuuXesAca+3VSsfxAjB8tF7IicNd4R76l?=
 =?us-ascii?Q?3f9RiIEFGcvDudH0bytL6albk+BmAZzpQMDy4cx2DcFCkOZfbA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 06:42:05.4693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5145dd50-d031-4119-056d-08dcf7e4cdb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224
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

Add the sysfs interface for vpe:
    vpe_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)
v3: add a generic helper which takes the ring as parameter
    and print the strings in the order they are applied (Christian)

    check amdgpu_gpu_recovery  before creating sysfs file itself,
    and initialize supported_reset_types in IP version files (Lijo)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 43 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h |  3 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 6d96e1f21e20..85d1013bba9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -377,6 +377,13 @@ static int vpe_sw_init(struct amdgpu_ip_block *ip_block)
 	ret = vpe_init_microcode(vpe);
 	if (ret)
 		goto out;
+
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->vpe.supported_reset =
+		 amdgpu_get_soft_full_reset_mask(&adev->vpe.ring);
+	ret = amdgpu_vpe_sysfs_reset_mask_init(adev);
+	if (ret)
+		goto out;
 out:
 	return ret;
 }
@@ -389,6 +396,7 @@ static int vpe_sw_fini(struct amdgpu_ip_block *ip_block)
 	release_firmware(vpe->fw);
 	vpe->fw = NULL;
 
+	amdgpu_vpe_sysfs_reset_mask_fini(adev);
 	vpe_ring_fini(vpe);
 
 	amdgpu_bo_free_kernel(&adev->vpe.cmdbuf_obj,
@@ -865,6 +873,41 @@ static void vpe_ring_end_use(struct amdgpu_ring *ring)
 	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
 
+static ssize_t amdgpu_get_vpe_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->vpe.supported_reset);
+}
+
+static DEVICE_ATTR(vpe_reset_mask, 0444,
+		   amdgpu_get_vpe_reset_mask, NULL);
+
+int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->vpe.num_instances) {
+		r = device_create_file(adev->dev, &dev_attr_vpe_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->vpe.num_instances)
+		device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
+}
+
 static const struct amdgpu_ring_funcs vpe_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_VPE,
 	.align_mask = 0xf,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
index 231d86d0953e..695da740a97e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -79,6 +79,7 @@ struct amdgpu_vpe {
 
 	uint32_t			num_instances;
 	bool				collaborate_mode;
+	uint32_t			supported_reset;
 };
 
 int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev);
@@ -86,6 +87,8 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_init(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_fini(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe);
+void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev);
 
 #define vpe_ring_init(vpe) ((vpe)->funcs->ring_init ? (vpe)->funcs->ring_init((vpe)) : 0)
 #define vpe_ring_start(vpe) ((vpe)->funcs->ring_start ? (vpe)->funcs->ring_start((vpe)) : 0)
-- 
2.25.1

