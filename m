Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D75CAC5BB
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 04:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797A710E265;
	Fri, 10 Oct 2025 04:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yYGSmalb";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013068.outbound.protection.outlook.com
 [40.93.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE7510E265
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 04:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujt5YAh+YHK0RmFMQHk4Ax/Ys4hpZO9TbGJKvW3ZJZdliHmp/jGsjLFla1vLVYk2hE2CWGoFiX01T7XIynLlezaVcpQ78dhTdSTAvCwvEDybhVUbOtCNsjxfU8/sZGFlqO9/cYU6oVaFCY8Dt1/mD7hnwZz+bFQxrHaejCvbfaznECf4esIT/1CvCBBJVR5aMZtISvi8zKnaNsXBIf34/D5LtyiDTBvbGMO+/ZaEe35glrV12/NMQEgpxsisDnu+iam7SkE/r996Z49cQuTynBtwBSv+EVzMwBDeaqrXmhitBbi7AdfsWbpfqG6lZaKJtmZPahx+Vr243c7Zl2cCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR47N7501/P0VcsxxXf+BY0We6RKvAou12imf27C/lI=;
 b=yL3t3uHbCD/Pvux4YYDRXMGjW0hJH9wt5kVgYln+J6/aGOdWASvTiTLAU9zbSdoukh8S2ULRQWj84Oe+neo18RPrZdNRXx2gXa+WnEFBmMfEybkhMEUphpc8uA5N9eIaz1Pa6wYGDnb32uvFLXPnwjSSjHHzVgCy8wxZcHdG1NPeeBvarAALxPNHFGo35u+oYzndJEJJoVCtUgwa+pWrCt7UByUt6hH9q/Gw/MlJsj6sR6BLzXPcvhQA9wMPgQK+30oIc3IL9pwLW1u36p3DXuXaSpc+8dfd5ROCflZwa40fOBzELmElhNffqX/0WFf6LRJMv4/Xj5rDhU3/3vDvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR47N7501/P0VcsxxXf+BY0We6RKvAou12imf27C/lI=;
 b=yYGSmalbXFkkJlXGNFZkcIgh8zmiroNkz3T9mTGfi3A5CAaun+TkBZIdYDlvPNkH0qLNYntRucsqPnF1Dv09SGU9Iv3KV48Oq5RanKbvGvrjNdSQmCA1fguPiklnHuwjzwBwkRf68666ApeV7jhwLwtb4N+nvzl0XFjhkffEee4=
Received: from MN2PR05CA0063.namprd05.prod.outlook.com (2603:10b6:208:236::32)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 04:43:24 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::ec) by MN2PR05CA0063.outlook.office365.com
 (2603:10b6:208:236::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via Frontend Transport; Fri,
 10 Oct 2025 04:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 04:43:23 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 21:43:23 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: Add SRIOV crit_region_version support
Date: Thu, 9 Oct 2025 23:43:05 -0500
Message-ID: <20251010044309.11822-2-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010044309.11822-1-yunru.pan@amd.com>
References: <20251010044309.11822-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9c7533-f0ce-44f4-9dc9-08de07b78bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gpkEh8uJobeQfhdmnMh3VBKfagod7O7tbdCZMOCDji2tikHn/kvMbgMUtZPW?=
 =?us-ascii?Q?xZ88PURJW2YQ0q1fvnzw9dPx3XqhVrEulYj8HELFBaoqu8HlKexXXHyNsB3M?=
 =?us-ascii?Q?YxRBVzW7+J0EXhBwH1gfYDiXXOldlDwVH8gGY1LDz6w2xZthqOIhvP0PxOmb?=
 =?us-ascii?Q?WdzDDaxs+AbhIS5NUFTj2kZDDR8HR3eyNAKPO4ZtF8v5h75N1mFSx1WkcD9c?=
 =?us-ascii?Q?DW1ZsinQbiUBppUr8MKMjJVJ9VpxXelIskYYj23BsoMOU9slnx1u0821iG5a?=
 =?us-ascii?Q?7BhGQ3gaBZarO7x7YK8+AEvoERALf9ISxquUl0m19ushvLW3FfZGi7aZuwh6?=
 =?us-ascii?Q?ZKVJsuUFeJfJFfeww3C0ruKPV9MSBB9Qadb69x37Xfm3Lr6Not93Z2dcrDeZ?=
 =?us-ascii?Q?F66xGXtR00QxkONS19e9efDUyzVYuS9wCNcD/PunSxkfag9mF40HjL6JBYy3?=
 =?us-ascii?Q?AG5u16X/CFeGOi4nAm53OLntzc7jprBod49D1Zo1qZiD0PzZoHFS80hcIa5L?=
 =?us-ascii?Q?eES5YZESPJ80eNK5y1wx4eSSx9ZvKm6jFelQbjw5CvbRB5jZ/CbFWmCplvR4?=
 =?us-ascii?Q?4hToFTHGMo1W94FGmRgKiO/SKMYas38VUoWxeAq+EKftFvrUpwcCaGmdCnqB?=
 =?us-ascii?Q?Nt2dfrCQkwkLF/qlyDR6YBmLQoXsia59TD7U6C7Ba9Kf67CVqChCVPP3/77d?=
 =?us-ascii?Q?OT9jY+DW70qioN4KrBaTD/hvi/AUeiPl13qUlcEshZLL0lyEYzmeMzuKZndv?=
 =?us-ascii?Q?XeQp+8k8BsLY30C4JFKJWtqhBOYKlA8f9KDJDau0+7n6H4q3JiIA0KPvOuu5?=
 =?us-ascii?Q?4IVqpUb5tc6zrre4xRBl8mmSOMebCMf3z0qvdG4gSDIVClaIKjtuGiSayHoz?=
 =?us-ascii?Q?OgxEA3W85OZxtsq+MIKKn2cMP6l2d7a4SIR0gAcoXXwlZJTJ6TtZq+T9lBqY?=
 =?us-ascii?Q?+F2DFycPiGyPngfxOTok3UN5W1NAAuTOCcST/ZRKXJfI2lam4mlUlq3WLKOw?=
 =?us-ascii?Q?PuPa+lUdtQVvtdh32IbU5ZK/BRFMcC5M6t/aiM13TK7NnpBgBln5H5Z8460k?=
 =?us-ascii?Q?ddVcscKHtbNgjnfhTRDoGvIDNhH7C33SiMrk3aL6StJf5bgLrEiNP55FpbF6?=
 =?us-ascii?Q?7mdLirrSFKMp0P56Gw7n1sij6IMEtV0EWxdGpgOE4xDxbxkvMStH+42stY7D?=
 =?us-ascii?Q?A5Y67LfP18P7V6nfnYdnxhquVsaj+ayj2QdienJbQI8H8rzSB1k5wpgqALkb?=
 =?us-ascii?Q?CF4kSSNxa4858MxdXuhjqj0tgZiMSR3upg/lidZCiLClyka+rJAkES0bLxfb?=
 =?us-ascii?Q?mmdleL9poN/BOFFl3Ogl3KBRpTHUHKSmOwxlGYu9nFzsc2menPRD1ENrtkpN?=
 =?us-ascii?Q?cseIW8/zKG0gJGecOkOKx7QPD0VmZI5DOy9iX0nEEMJs0Uw/uStoswe620qM?=
 =?us-ascii?Q?IGuqezMpPhafJOggKWZcpAbjK8jIbHtaGppsaW0PRM+jxaSESe0MyNmqqxDO?=
 =?us-ascii?Q?TsExyzsrVm/9dHy7Y9TxPVqCLgnEJziThviAR45pC+AS2KuDEwbe1T3rZAGq?=
 =?us-ascii?Q?xFAO+iMy2DqZTvftGXI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 04:43:23.8731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9c7533-f0ce-44f4-9dc9-08de07b78bce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
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

1. Added enum amd_sriov_crit_region_version to support multi versions
2. Added logic in SRIOV mailbox to regonize crit_region version during
   req_gpu_init_data

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  8 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c       | 23 ++++++++++++++-------
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index e95adf0407a0..3a6b0e1084d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -150,7 +150,8 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
 		virt->ops->req_init_data(adev);
 
 	if (adev->virt.req_init_data_ver > 0)
-		DRM_INFO("host supports REQ_INIT_DATA handshake\n");
+		DRM_INFO("host supports REQ_INIT_DATA handshake of critical_region_version %d\n",
+				 adev->virt.req_init_data_ver);
 	else
 		DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d1172c8e58c4..51ff73b1fcd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -262,6 +262,11 @@ struct amdgpu_virt_ras {
 
 DECLARE_ATTR_CAP_CLASS(amdgpu_virt, AMDGPU_VIRT_CAPS_LIST);
 
+struct amdgpu_virt_region {
+	uint64_t offset;
+	uint64_t size_kb;
+};
+
 /* GPU virtualization */
 struct amdgpu_virt {
 	uint32_t			caps;
@@ -289,6 +294,9 @@ struct amdgpu_virt {
 	bool ras_init_done;
 	uint32_t reg_access;
 
+	/* dynamic(v2) critical regions */
+	struct amdgpu_virt_region init_data_header;
+
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
 	uint32_t vf2pf_update_interval_ms;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 3b35154e2df6..b53caab5b706 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -65,6 +65,11 @@
 	(AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1 + \
 	 AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
 
+enum amd_sriov_crit_region_version {
+	GPU_CRIT_REGION_V1 = 1,
+	GPU_CRIT_REGION_V2 = 2,
+};
+
 /*
  * PF2VF history log:
  * v1 defined in amdgim
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index e5282a5d05d9..cd5b2f07edb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -222,12 +222,20 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 				adev->virt.req_init_data_ver = 0;
 		} else {
 			if (req == IDH_REQ_GPU_INIT_DATA) {
-				adev->virt.req_init_data_ver =
-					RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1);
-
-				/* assume V1 in case host doesn't set version number */
-				if (adev->virt.req_init_data_ver < 1)
-					adev->virt.req_init_data_ver = 1;
+				switch (RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1)) {
+				case GPU_CRIT_REGION_V2:
+					adev->virt.req_init_data_ver = GPU_CRIT_REGION_V2;
+					adev->virt.init_data_header.offset =
+						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
+					adev->virt.init_data_header.size_kb =
+						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW3);
+					break;
+				default:
+					adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
+					adev->virt.init_data_header.offset = -1;
+					adev->virt.init_data_header.size_kb = 0;
+					break;
+				}
 			}
 		}
 
@@ -285,7 +293,8 @@ static int xgpu_nv_release_full_gpu_access(struct amdgpu_device *adev,
 
 static int xgpu_nv_request_init_data(struct amdgpu_device *adev)
 {
-	return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
+	return xgpu_nv_send_access_requests_with_param(adev, IDH_REQ_GPU_INIT_DATA,
+			0, GPU_CRIT_REGION_V2, 0);
 }
 
 static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,
-- 
2.34.1

