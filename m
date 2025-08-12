Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA27CA0EDC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 19:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313BE10E632;
	Tue, 12 Aug 2025 19:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E6R7HHfb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3CE10E3E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 19:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOGcUxYubsWhQDKyNBwGz5qD1yHLcCB4etB3Yjj0AQQBsY2zxc2VM8KztD5UTH7bvBO5iVRFUv/cuiAjOlRsK8Ce0BBU6sAi99npZlRpn8jq3G5loxeUEzKIPscP99xKlKqcAPNB8yF/CCa4xRmUbAjNmINjbgOf+JQBqUvqpjHTUqklClyN6VeF+5ggTeZLlJqq/r9N9X7w8qGZdhFP575KuXt3+w6E0LSW1obK8GYAHIP0/a/HvHtSLAi93jfrjVBbAEkXkvGEfeqZDqsx/J4GMkupFhmkmhvp2V5do2iWAfHEedHoJxdhiDwEodmoU62ooQkOORJjyCcfZoKmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWn59ZVu8Gav7YFd9461Z0p9RYYAefxyH+1WaZ3/AK4=;
 b=L9RP4K8AtreNovsgTCjHDEJzKNFGz3gxX1KoGivFD5Ps9dsXXGCdXvgkKwE0L3zAqJ6NOQJSeA1EnaEpOcxsQCeJKE5yGpifQ4hKQ2KEXPGNKAKay8Uik7+SMO2ubVqmHjYO6ZvBZ3iaYj/dPsGT+EeLmYiLZSOeFs7/oVyRSAArWKit4AvtYs98YhV2Y/CVPtAxqexFcdrOAvQbrMYV5h/tO+RUigeMuoGjruIPFQ0kKbhFy7X47LzINWfP6+JHxxeA3S7nYigUKcGWIQdwHxqdvmlnM44je/M/83MELt2szkg/cdUVJWo4+kGVKNt+72FDf/vUNXvxS5MjBqL0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWn59ZVu8Gav7YFd9461Z0p9RYYAefxyH+1WaZ3/AK4=;
 b=E6R7HHfbwnFQ6VpBW3nL0jq7kZYqu8MaUZHubpHos8k8eX568qQka77B4LN5fsssZbgoGzXlpnMEk73hzxfNljNKzI5aJOt7sZ+bQpnn3SOoYkiNBBn9KYjIJWoopxhFLsE/nAXjNMB3sZDUYmu9FSHuV9clePch8jsB13DthNs=
Received: from SJ0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:33b::20)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 19:12:53 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::4f) by SJ0PR05CA0015.outlook.office365.com
 (2603:10b6:a03:33b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 19:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 19:12:52 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 14:12:51 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v13 2/4] drm/amdgpu: Add ioctl to get all gem handles for a
 process
Date: Tue, 12 Aug 2025 15:12:29 -0400
Message-ID: <20250812191231.3534982-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812191231.3534982-1-David.Francis@amd.com>
References: <20250812191231.3534982-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 278a4d14-5feb-40f3-8d37-08ddd9d43cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x6fvurxsAtaKzbCbmf2r23N2aQI7zmptSaY3uu47ITlb/mZgJXsfT+/uyxlk?=
 =?us-ascii?Q?4493uw1ZDBlDnfaAwpGRuwjVTeBWxxmLDS+eGi3gOIe2I58+57AwSHHokkex?=
 =?us-ascii?Q?MuFaj6BMaSonDCpg4suYYfwY1fzqzVCBksLXgIHePchnkoDHAeI5OpEr0Ut5?=
 =?us-ascii?Q?RFdnDQB+fRUDkvN0dM0KPDzMoJNPg3tkjIF1o4XYz4S8oiNN3nVzODN3oTvW?=
 =?us-ascii?Q?Qp1RRdtheI50LIgIpusrNud5tLJCnxcGvybA8tQuyzVka8cztrP+2tSoMPkM?=
 =?us-ascii?Q?U19JrVWyLWWEQiSNNfJA3+N+NaRdAB6UYM4uxPfB82bccPmQXSx3Q9DCJIOz?=
 =?us-ascii?Q?BzAYA68RmX75hjs6Ax+8E54PGt89CSAhK+7RMnlJU7x6JtBEwWfDDfEVmIta?=
 =?us-ascii?Q?6eFWJbHCYBAbOy1tZwfRXsX7K9ishnBtx3sN1FkQAsKmDBfyUSHlJpvp6D9k?=
 =?us-ascii?Q?TTSu2sWpB4yZWsGHTUJEC7AgqMnsJ/ScA25NooHN7P6qkbSIkj/4gjjcrfSZ?=
 =?us-ascii?Q?UYPV46YDYLwfkNjgxeU9qpjSHXmKDebaPvb+OVE3WAcCXB7iar2JHA9qPW5h?=
 =?us-ascii?Q?ZDClfBVhpsyvpV5Le5UEWWm2DcJuLCbqUPZg/ywLjOUiVJRQRAAXro17Xffu?=
 =?us-ascii?Q?wFc5yaBQMWgtpeKgFSaKigMk88fhGEy39OLLlQDMgWw0OS9vow+Gm4RtptbW?=
 =?us-ascii?Q?8bwbv9OVjJWu374fb2+WmCFK/O8EHN7fWLe/6zRm4UlacoWPUtzatKcnFWkh?=
 =?us-ascii?Q?oeM9LOP4ThGX0FbeMK0BgMA9RpxxleKQXs4He1OEwK1w/5HSrNoJLnMlh0g1?=
 =?us-ascii?Q?H+oxaKEmHoiEsZEkiQYfppLNtRPPzX9WXDIgC6NLjlaK+xHXFcbkNADnOln7?=
 =?us-ascii?Q?thz7HA3YxrTgUmqR1dYsvIPnVa21lxC5RLZKdBfA1Ue+oCu4RXolVt1JJAzo?=
 =?us-ascii?Q?c1eadhg3ClN5ppRhSf1UeF9+d1brVi3+RdSuqaJ4xeA6JIUh/0ecW8JSO2xA?=
 =?us-ascii?Q?yNcxSQUz1v4VRMbW0BkDB5QyfjZTUjBlqBQc0Hmgj89bkIiQG6F4yuHKeU7A?=
 =?us-ascii?Q?gwKZHF3UwKGZ4MPzVpTS8kvuWRnFhNQeve5nWny4XqmSPmZq8xLiuIkqCG4b?=
 =?us-ascii?Q?fL3/dj/iBLbGkIHjAUPW6BLnaRcX895GMYKFP/Mzq3HzVrBLz6jtbvGKVI6B?=
 =?us-ascii?Q?PF5hF7oLD2UEx0QYm+R9XHnxfzLmQBd+7cWZ3f0zS34Med3p9Pf71t8PGrHp?=
 =?us-ascii?Q?bVsQ8D9AuwpyGCFt+YGo0WbzE8XJ5O49dVE4HL+cM/zx0YT1XkaBmZbQ30Yt?=
 =?us-ascii?Q?nKVjnRXjmrnEz6G4xdYnuUZVN3qjyriFEky2dtoA/0Y+cTLRZaCpP76ocy+x?=
 =?us-ascii?Q?133AUVeO+B75fsNz4nCONzRIPh0y+OtmrF3caFwgQDG3LJMVjguKqAVvp6Cr?=
 =?us-ascii?Q?z6Gjto3xLFtNQuD8iZIHELW9eOBSuCHWMoW/Hrx6bDhhTbGXiaXFvQI/QZ+c?=
 =?us-ascii?Q?8IZlVrvBELHexlEhjibr3SVelwqt60gzQJlO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:12:52.9309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 278a4d14-5feb-40f3-8d37-08ddd9d43cab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130
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

Add new ioctl DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES.

This ioctl returns a list of bos with their handles, sizes,
and flags and domains.

This ioctl is meant to be used during CRIU checkpoint and
provide information needed to reconstruct the bos
in CRIU restore.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 79 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
 include/uapi/drm/amdgpu_drm.h           | 31 ++++++++++
 4 files changed, 113 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4ff3a2eaaf55..f19795dddf9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3031,6 +3031,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index aefae3a9e6f4..8b44d10a8b57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1024,6 +1024,85 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+/**
+ * drm_amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
+ *
+ * @dev: drm device pointer
+ * @data: drm_amdgpu_gem_list_handles
+ * @filp: drm file pointer
+ *
+ * num_bos is set as an input to the size of the bo_buckets array.
+ * num_bos is sent back as output as the number of bos in the process.
+ * If that number is larger than the size of the array, the ioctl must
+ * be retried.
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	struct drm_amdgpu_gem_list_handles *args = data;
+	struct drm_amdgpu_gem_list_handles_entry *bo_entries;
+	struct drm_gem_object *gobj;
+	int id, ret = 0;
+	int bo_index = 0;
+	int num_bos = 0;
+
+	spin_lock(&filp->table_lock);
+	idr_for_each_entry(&filp->object_idr, gobj, id)
+		num_bos += 1;
+	spin_unlock(&filp->table_lock);
+
+	if (args->num_entries < num_bos) {
+		args->num_entries = num_bos;
+		return 0;
+	}
+
+	if (num_bos == 0) {
+		args->num_entries = 0;
+		return 0;
+	}
+
+	bo_entries = kvcalloc(num_bos, sizeof(*bo_entries), GFP_KERNEL);
+	if (!bo_entries)
+		return -ENOMEM;
+
+	spin_lock(&filp->table_lock);
+	idr_for_each_entry(&filp->object_idr, gobj, id) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+		struct drm_amdgpu_gem_list_handles_entry *bo_entry;
+
+		if (bo_index >= num_bos) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		bo_entry = &bo_entries[bo_index];
+
+		bo_entry->size = amdgpu_bo_size(bo);
+		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
+		bo_entry->preferred_domains = bo->preferred_domains;
+		bo_entry->gem_handle = id;
+
+		if (bo->tbo.base.import_attach)
+			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
+
+		bo_index += 1;
+	}
+	spin_unlock(&filp->table_lock);
+
+	args->num_entries = bo_index;
+
+	if (!ret)
+		ret = copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries));
+
+	kvfree(bo_entries);
+
+	return ret;
+}
+
+
 static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
 				  int width,
 				  int cpp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index 948449e46e90..51a040dc96e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -67,6 +67,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *filp);
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp);
+int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
 
 int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bdedbaccf776..59b423883e91 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -57,6 +57,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ		0x16
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
+#define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -77,6 +78,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
+#define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 
 /**
  * DOC: memory domains
@@ -811,6 +813,35 @@ struct drm_amdgpu_gem_op {
 	__u64	value;
 };
 
+#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
+
+struct drm_amdgpu_gem_list_handles {
+	/* User pointer to array of drm_amdgpu_gem_bo_info_entry */
+	__u64   entries;
+
+	/* IN: Size of entries buffer. OUT: Number of handles in process (if larger than size of buffer, must retry) */
+	__u32   num_entries;
+
+	__u32 padding;
+};
+
+struct drm_amdgpu_gem_list_handles_entry {
+	/* gem handle of buffer object */
+	__u32 gem_handle;
+
+	/* Currently just one flag: IS_IMPORT */
+	__u32 flags;
+
+	/* Size of bo */
+	__u64 size;
+
+	/* Preferred domains for GEM_CREATE */
+	__u64 preferred_domains;
+
+	/* GEM_CREATE flags for re-creation of buffer */
+	__u64 alloc_flags;
+};
+
 #define AMDGPU_VA_OP_MAP			1
 #define AMDGPU_VA_OP_UNMAP			2
 #define AMDGPU_VA_OP_CLEAR			3
-- 
2.34.1

