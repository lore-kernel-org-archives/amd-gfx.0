Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A39CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 18:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6694410EC79;
	Fri, 10 Oct 2025 18:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I1nxy4Yn";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A0710EC77
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 18:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yp3CRx+KcDtEk7TlP4ebvbExUlvoSGrKua5GuAaBVLxOiOKf1hVB9ANckVzn8t6oPJyxq9Dx2aDtVl6wJXSS/askwc3ISEq7yA7dYOp99+1rTZbkbQzX2KX1bfT4Fl90Xh8OkR+4je1DRtO3QAuY4u5WKaaoOZHzVoWf5uwvo+zg8fanqs6whr/HTHvDRDLxhCDgPiS8LJNd+yZ6D1ua8oh4gHSgmP1OeKoP9w4DvkHkiotuMxPl/fPwIfWiY+VdTvhOjmSX1d3Pt9utTb4tzs/lFPkDxDW98lphDX9okogrKK+rOpQ9RL/TxxRDAIcBGmhNN/jvfS6xcT33zaA3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAGGfm31fbTODK92fWnfj0dzqF9Gdr8duvD0XTMJ7zM=;
 b=M6pPB3HC5rRcirmqNJqh3xtM+0DQG7xC/AZ1TADfYVE/HIWNnOfq+fsjwEKHe6nLIBOvbIXol9Tv96bb6nvxMpmz6RIgKlgqI59zmsYxHHqDBMqxLLXOfj+oYzDCQbFbpa9YWv8cobX0bIiZa6UeoZpiVvTesL4v8e2yevbNhFoSX6UIoMnm7I9Jo37lKo5+NO/wb497xjz7cA1rMH+gC/NiDsjaxeNvOJ7T6RcYFQBy8kTZXW/x9W9/vwoIgtevniEWIU5oY/zeHwfrO3ER7FgXZ1SqgPyvPeCYRbRKxSmZ6+727lrLBC1HJyHfykkDcXWkBtuZfn+5ngbvdQZQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAGGfm31fbTODK92fWnfj0dzqF9Gdr8duvD0XTMJ7zM=;
 b=I1nxy4YnOZ0SE0WHzZtHRU0vc/LKuBf2pG2WYpKRHOTpCAPZt1YWb2I8spQFDWJJwS7k3uaYc19oblz+fA6EnX7uvRokgMCCyk0ntKsR9sNdaClfbf9AgPDv/qptR5p9jIiNSzCfBKFPxWisfw77V8JldlkrE4zY7bDpuPGuGbo=
Received: from CH0PR04CA0088.namprd04.prod.outlook.com (2603:10b6:610:74::33)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 18:49:03 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::d3) by CH0PR04CA0088.outlook.office365.com
 (2603:10b6:610:74::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 18:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 18:49:03 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Oct 2025 11:49:01 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v3 2/6] drm/amdgpu: Add SRIOV crit_region_version support
Date: Fri, 10 Oct 2025 13:48:45 -0500
Message-ID: <20251010184849.9701-2-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010184849.9701-1-yunru.pan@amd.com>
References: <20251010184849.9701-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e53bba8-ef0e-4bcf-cc5d-08de082daf05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l4hj6kq+plNIW731c1IcMf6qPtdKiw7QVfaMVM8J8ZDPyrgbAvy4tVDDoqBO?=
 =?us-ascii?Q?fewrg5FRng2D8qcq2XRlcqlIiSFIPrM+59RzeYxUiqb9ckcqwXFxrDEIfC1Y?=
 =?us-ascii?Q?ubfyCb9ZWMhbayc87VT+oWfQlzqfMt9VTiB6RS0fZPxmXbrfRohUDv3PJ8gO?=
 =?us-ascii?Q?H3l4I+w26hZSCOGaWo7wh/YXz0mSC+MBj9UR+oHU83y8kFiIdM9mOwx6xCA2?=
 =?us-ascii?Q?wyahMcR/I3xpozIxs92TAhIXdhMGr8S0qUJuiQsDlxsK6xWDFBvU1yXrZVRj?=
 =?us-ascii?Q?lC8mI2zhxZEjm2HHy4zK1i6q1IPrpg60qs8tvxhYOb7YgRbX0CXwFtre2Rhw?=
 =?us-ascii?Q?Lp2m+WcJxDF8KJlnodxKisSIytU+iOhaOwqeF9buNtfofQQl5244DdyGvq+h?=
 =?us-ascii?Q?L+jX+VU3TJH5/CWYv0IAyfpqDlvDoFqFec+WDji3xGjmHgn/0mXOLHssIRDk?=
 =?us-ascii?Q?AYqYWOOxB0jTj+zMjMz3u+BYnR9vri38YkWPqExskoDEoDBJBZW6At+J4l4U?=
 =?us-ascii?Q?XrOTukpYA6JXSImZpRjtTB4GcnwQiKeDxqaorT87BQ3enD4ta80NKsD3LhEj?=
 =?us-ascii?Q?UcN1kkWR/c8mGIMJqVA5cbezcz3w50tdUMOke41trYoNFQHzWrlJSMuD1suQ?=
 =?us-ascii?Q?Nx1DvaqGk2w9QfzkWo2IaigJm78JtgOa3DXJWmLhFJiiHNtC0iPRg6g3fTlq?=
 =?us-ascii?Q?9x4mgoeVHh1q0ah+aP739vyuzLN8c3IyTnfuC2BDsOt3YLQnRxEIiJ57KsDk?=
 =?us-ascii?Q?efpt4sVEElHbcaaRfuHMhE56/a2zSKpiEVHUTXMd9vBALZ4/T1ukH+3cnJpR?=
 =?us-ascii?Q?fMGgH7GRlujKtogL1xk1HgoSiiVyS1PpwQaqgSJrMn28DONcHimNLVRVxhmJ?=
 =?us-ascii?Q?ZGsk/4aIONBJLqfDjw8D+1vL4qdSd1xgkAxg3PfJ0YJBZJxXIp5wxdln2ldF?=
 =?us-ascii?Q?AoEFcCljnBI6CBTbSsiq716tRD14/Ra2yH1Pc7HyMfONZ4N1kX+KV1xCKu7/?=
 =?us-ascii?Q?y488gRI5NBRwlg2Jw4aFhn57GLnqVn5U+o2j3SuclphOzum7EFSO0VgtsJw8?=
 =?us-ascii?Q?o2Sjf7mn1iipednLdn1yeOtQXzBgGl4PYp2Frq0tlzsWbQXUGaQ4IvzHt4FB?=
 =?us-ascii?Q?+dTcaoH0Hijno/zn00fXTvsrce6kLdt6G7zUOD/n6qHfyS+Gz0r5GpUZo3Rx?=
 =?us-ascii?Q?4ECVjo2dNZWHnPIbzKIudLfuPRVMEU8v7UdA9TJj1sCx85HzNVe0iVDsF0Oi?=
 =?us-ascii?Q?qkW84/h5Z6u8s8UjYwOzXrT+GgRu+tODicKX9GmZk0Bq5zxOXzOpHZkAdNjd?=
 =?us-ascii?Q?RueCbLqcZLO6q2mt0dkCQXX0QeAllVsipfdG2TLcOp8GkQccH43gPUDhiUwD?=
 =?us-ascii?Q?fJCPhcOver73J0KHYTW8aNICDCtAKJKcV2rRWVzKKaHKrD9n3Yc77+8Y4EJ9?=
 =?us-ascii?Q?O8i4UI4RlwrdWRJJ6s4GvZW7dUqLx/t3Ha3AqgYUIQU52rbMVEAREel92ZKa?=
 =?us-ascii?Q?8snPKHJ5jjvcmVt0bhw+Hgp/tWPYXUjzisrfzoCy76zaK5HlYBm6GqqjTsVc?=
 =?us-ascii?Q?YmfTUdKISwI57mRz1Cw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 18:49:03.5585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e53bba8-ef0e-4bcf-cc5d-08de082daf05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
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
index d1172c8e58c4..36247a160aa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -262,6 +262,11 @@ struct amdgpu_virt_ras {
 
 DECLARE_ATTR_CAP_CLASS(amdgpu_virt, AMDGPU_VIRT_CAPS_LIST);
 
+struct amdgpu_virt_region {
+	uint32_t offset;
+	uint32_t size_kb;
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

