Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84CFC44536
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAFF10E973;
	Thu, 22 Jan 2026 10:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KV+mfcQ/";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013022.outbound.protection.outlook.com
 [40.107.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D9210E975
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/9YDJSDMzt2NOxMlaSAooPcfHWJ+nIYhfqHDfdjSEwU39q9A55uZ+USCM+teikC+kGjHfq1KbhaPuVwIH1yYjSRetj5p+ey/ru11Qjd4rUl3GC4tx6kM43RRcb/K1BwWlg8X+9V7ZtsSdUoyK1BgjqlOhyFm1XQowE82nUSKQ6Cj8Nz3Mt7sZI3ppchK9Uiv4HAm7swjfiboMROxjEN30GvrXleDONX73ysiYCKKgyUdY/huxHuT+A1zF5iztkG/fq0aZ1JukjEwMT6o3T8H50Vif3V9QkiFmjJ+jXmhdwxcfWaDukLdwV65BvOg2WOsLxupcrcSgLEbEF+39OGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fl3Alx62+D4vnylekQd58mx9CyMpslgnZZyuhATamns=;
 b=bRX/LOym4OoadstNQdqjlDBuxWrGxnUIxUhUtKIAAky38dyz20WujjoKZb5e5wtMM9K7e/w6WIHKT5p8gEXCqZ2oZqXEZxbGjiRhpzLqXu0TFqecTn8Nt80KaPVEaYfCwEBwtV69WgcEXiu4YVY+ldB8KhPqsD79P+808MvuarsS/4vgC266Iu6xuyRMz+zrSQL926AQwdsHCBoVQWp5iHiubOTA7H4oY5+Z8W//lNNCHfn8NktT7WLCrNOeY3J6CyeJxPznfJ8h4X5DT+WqHMfNTCWcViWWZjw+b3O9R5K6HXvPvy7OiQjiRN+1D9utTe1zRs2gPmq0jMnqSrCrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl3Alx62+D4vnylekQd58mx9CyMpslgnZZyuhATamns=;
 b=KV+mfcQ/nESOeiE1Q+vt4gOCtNa3hDtgBaoAAV1RJE0jLss538eq4lOdJSdeUEmJBw75aa4xlTimyCEX7ribYNrRe9065FsVgwu8eZLN8R7lCrYui5vrCobj+XRTRPtQMHzIDcP/W3GxkFpVHUe8XC3zearU7BbD5HH3PkYY0FU=
Received: from PH0PR07CA0108.namprd07.prod.outlook.com (2603:10b6:510:4::23)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:41:58 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::f) by PH0PR07CA0108.outlook.office365.com
 (2603:10b6:510:4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 10:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:41:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:41:56 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH v4 08/11] drm/amdgpu: Add ioctl to get cwsr details
Date: Thu, 22 Jan 2026 16:09:57 +0530
Message-ID: <20260122104118.1682154-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122104118.1682154-1-lijo.lazar@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1c894f-24b8-4749-b028-08de59a2de71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G4dYWfuAV7skqWvL0fYoskrt44P5kmb4j7zPdGHBZ5dgLdhXxPLjYQL51+/l?=
 =?us-ascii?Q?Ajk2RFzKQyZl2qUVUaHnA+iiAUWeyEFSunaMqwKQlfDmK4ANTMFcb8VxQlf4?=
 =?us-ascii?Q?6oDJowFZnKOTNQoU7Uova7AOXb9RFcqL80cSI2jzNybgSGevfYyKjOsHQQXB?=
 =?us-ascii?Q?G+3+U6IDhyC6/CeNsYie1xaq2dK1x9m4XIdNTWLDX4ZjkOH2cZJXOEYotXkG?=
 =?us-ascii?Q?XbMIshq9aGZd4KvZUTGA3QMd4xE9j15BMDwB3BbpfAfKsKVJhsSaX5qFqJEB?=
 =?us-ascii?Q?5nqPnEFXcbAEep7NkT1+jdaBNZblqlm1vz/qaFQ6CBGcapaHuC7vvAkEfvOO?=
 =?us-ascii?Q?QIqX8PBUZn8JkRA45G4c1L+Edm9C6KsAfmQx9JMxWgSsOn8JC7qvhYBLXkjS?=
 =?us-ascii?Q?c1ucHtn8IusRDixClKnAjL6qsKmHMG5kbAGBS5DP/eqRkKhW42ziaOOm+Ywu?=
 =?us-ascii?Q?+G+21+Iu6KDLYARyNmsna0Aej7gOi6YzVhCIH8Pd3nPQPVIq/Nu9hUVhAOPj?=
 =?us-ascii?Q?vzgORfj+f0cl4wGZN3YF5aJQhegZVaZQbgEJ/p4ei1kWqztCWvBNWNktDi8w?=
 =?us-ascii?Q?nHvfI3CniGhE+YSh1oeHH+sbRDQpHwprYpFmtfs3WQAEP7x81zU+XnSCJ0wu?=
 =?us-ascii?Q?tB9vLPyY1/Fqbm/gObW0N+57MZFEuwk9lYIW8GL7qaTXOxXdpyYZSO323kl8?=
 =?us-ascii?Q?KH8WxmuBl9fQPDFQB3RuPGmpMwQi965FHIddk7PHxUn2KvzimoEdKtbhZ75z?=
 =?us-ascii?Q?XzJq32s1VJkE1qW3dAPd5Bbd/JWEIn4ozatXotbPqVOMEjT6G1oNoBdWvUX+?=
 =?us-ascii?Q?SFIO7WR2dBWJEn3MoOdrHWyBxQbkxLsyyxQZgJqnzHxa1ARwgKaT5cMgVcLl?=
 =?us-ascii?Q?aTAJ9Rh2woDP+Ej7kDWkVoaKfNm/ouzBTGl8kIscJnU1Jyq0exp60vv3P2JS?=
 =?us-ascii?Q?Jibz9YwsU2hLTTMPpg+jsdmqz1S4lx6pzVaguJR/cQp0aqPDPb3gvtp7Yyng?=
 =?us-ascii?Q?h9DDX/ICgs9mu7O9PyyfFTEKCNTvpn3+8yynPohYEzujtkLUvlGsrbHW93jG?=
 =?us-ascii?Q?CmAtcSYEZkHkQ3p7eBvsG4nskvVSqtGWPbIOrXhvUmRW92JgEWdaPwP2eBvX?=
 =?us-ascii?Q?YqVBlTjmEELH/Azuq9ZlFH/U03J/kFtaRwEFv28EY+NVB5vgC0Hjsj0WUqBW?=
 =?us-ascii?Q?+5aQ5Y8Edvds+mRhd1uoiacfXz2MYn6WMcMvalSmvDjES2kwWjSx7327QWYv?=
 =?us-ascii?Q?LRrrNVb63oAdFWjQPYYJaWlspEvXzanjItTEuzw2F6ZlDzIP6/b30/adtXVl?=
 =?us-ascii?Q?vEbkN5CxhsQi5kJBveVWX89gmzXWB7gPMDhuki6eF8AaXg0XsgBVzOxjamGG?=
 =?us-ascii?Q?T8IYowmlJEJMPStx2XHzFIHwzY2EjCwPeEP0zFoUlTYaq+prLO/yHosSlVdh?=
 =?us-ascii?Q?MlJCQxfK5QXHZpWrlZ9pMmgQGotQocxLi019aGRWqEh9sbACCt0rpxaj4dPD?=
 =?us-ascii?Q?8Gs+b8MRDIT72p3qhyeDMM6LotYpjM5132/O9l+gNH+UUlmi7g8sDzM58N9y?=
 =?us-ascii?Q?j+omP37AQBHffvkTRRO0KL9kbHIcVnu0O/gTa3yzL11Ry+x7ajUJnk4E8ez/?=
 =?us-ascii?Q?mSXUuMRMaILvtYbmIjt1QRiL+x/3aMpzSePH56G9OIkwK0BkkO6msohMg8+n?=
 =?us-ascii?Q?xaRmuQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:41:58.4359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1c894f-24b8-4749-b028-08de59a2de71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
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

Add an ioctl to return size information required for CWSR regions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 +++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index fed15a922346..992bcdf3fc1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1426,6 +1426,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_CWSR: {
+		struct drm_amdgpu_info_cwsr cwsr_info;
+		int num_xcc, r;
+
+		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
+		if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
+			return -EOPNOTSUPP;
+		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+		cwsr_info.ctl_stack_size =
+			adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+		cwsr_info.dbg_mem_size =
+			adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
+		cwsr_info.min_save_area_size =
+			adev->cwsr_info->xcc_cwsr_sz * num_xcc;
+		r = copy_to_user(out, &cwsr_info,
+				 min((size_t)size, sizeof(cwsr_info))) ?
+			    -EFAULT :
+			    0;
+		return r;
+	}
+
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ab2bf47553e1..c178b8e0bd3f 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1269,6 +1269,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* query CWSR size and alignment */
+#define AMDGPU_INFO_CWSR			0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1648,6 +1650,20 @@ struct drm_amdgpu_info_uq_metadata {
 	};
 };
 
+/**
+ * struct drm_amdgpu_info_cwsr - cwsr information
+ *
+ * Gives cwsr related size details. User needs to allocate buffer based on this.
+ */
+struct drm_amdgpu_info_cwsr {
+	/* Control stack size */
+	__u32 ctl_stack_size;
+	/* Debug memory area size */
+	__u32 dbg_mem_size;
+	/* Minimum save area size required */
+	__u32 min_save_area_size;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.49.0

