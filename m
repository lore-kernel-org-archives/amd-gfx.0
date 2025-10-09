Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB9BCAC5BB
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 03:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 589B310E904;
	Thu,  9 Oct 2025 03:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dD3WOfFI";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE96010E904
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 03:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaVbI/sjEH1JtUL7+enzJmGngwKYxdT12R+YSgL6PfxfeRu/gDzeFYaSv3fUm2mq2BjGfczDpaInLl2jX5+MLyHzjGg6BoPGs1wko57+8ge0JoJ85Znc5Ag0oMOGjR3y9TyaxtWWeBQLcuWJCtMwLAzrUnS/+9auUOI66JZlZO1Lvx/jvU6dcvd1wS13x82yYs7s4EomRiRA6Jf6WGCASa21XHIgQMu36+HbURrI2O7JKeBCC3CKBNsNYU2Hs3fo/I7JL7Wv6wgcHpVZWWIoKggR2RWs6Pv8j29mfMYQkQ4fdl0+vCRDupouLRbmqYLrFgajmqTTXgLWzzzAvPkJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lbj5Jx+zNvzU7yaFejlHJogvDx46dDe0F2ww9tCp59I=;
 b=QXXp8+54WdsuSOL0Tas4gw7aLvUkn/yjAS3WATnQ3nOPMHR/zSK8abhbakX3GfExE48JzkoUZZnLuS5iCNJJe4ma8X2757yQ9556QuD5RJQX2CH9ZpJNd84QvOf+8H340WVmzOf0FfUkQO6tPL3wSIXQxalny6Yg4cd7J7jc+MHmbRECBXMHjarLh3PhyJCvrp2BIZMlMtqEgxJTIsbvToYGz6UkGMIa9yrnbzzaG1pcqgx1W0teK7phwexXwDKS46+L7UIJTxe7bUHpwrjroaZmxRbW9OUm2NrNDG2E1vFexw/pa865zMxJb+Uys6Sq0si+OpHiLjk2Qgf+n2MA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbj5Jx+zNvzU7yaFejlHJogvDx46dDe0F2ww9tCp59I=;
 b=dD3WOfFIfYICOL06m4+YKR5CnKY7QVoIS0RkqsQLIfthS50MJxuJ/CKlDrHgJc4zsdN3tii2O8vKOlFXcLcDI6/YcwRMmH8GINYv7BxoqKwgZDIFQD8gBN+uZywDMoKorU/qIVEfzlSN5a854QTeIMGVG1vt+6F9mwcZdd4/lJU=
Received: from DM6PR02CA0101.namprd02.prod.outlook.com (2603:10b6:5:1f4::42)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com (2603:10b6:61f:fc00::621) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 9 Oct
 2025 03:30:25 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::f6) by DM6PR02CA0101.outlook.office365.com
 (2603:10b6:5:1f4::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 03:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 03:30:25 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 20:30:21 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Shravankumar.Gande@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: Add SRIOV crit_region_version support
Date: Wed, 8 Oct 2025 22:30:02 -0500
Message-ID: <20251009033002.24968-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 18334ef0-3219-47c9-8fbe-08de06e42f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VA7kM2vHhiFC8VjkTXy/YtFMzkHd7rnhIh4LwV2esv89rqbS59hrujMI+422?=
 =?us-ascii?Q?wAGlQtA8RjwvcHbqqg+avfGO1GxK7lSWTrRhbFhk4CTzskd/ZR41ud6M1lRZ?=
 =?us-ascii?Q?7F+YUs9Xf8P6lrJm5HEqlDS3wmJ489/Tn48OBuM6nFFcReI+nVgr1B4ZTPOK?=
 =?us-ascii?Q?Dn7O/hUIegQUHrRowwsA0daswIxOpFLKQpCHFuuEUaKcdlGrdalpjZeJE27H?=
 =?us-ascii?Q?epYZv6sawtpwyRJrDzJB8l3dv7daFK9bmfNzMqIPMYbyaVxq8ydbUcLi8hsT?=
 =?us-ascii?Q?qDNTpouH/+2+FI0haVzf0qfFzpgGIn7zS0XU9otej0OY0wPrQkGJ2qE4tQAz?=
 =?us-ascii?Q?xsFBdHpyUFDq44MT09RBhA1xeM4ebJ6BQhyfu/m7r5iKlsk8Ae6UG9vfINaV?=
 =?us-ascii?Q?ah5BcVtPAwjCe10dYeNTUDCx+FxucL84n6aRHHs1NfDDeuuC/HtfbuD16QPq?=
 =?us-ascii?Q?+v9YinRgSShCYcwjxuwn7QSDV4gwnhF0LkqRGnZTFvABGlfulrfFEqAmCZ55?=
 =?us-ascii?Q?GNNxdoXLIjx45ft8LNZCsw2B3Mt9Qri80HOMQxZjvmhOr1Ab3JW8DncMnT5e?=
 =?us-ascii?Q?+jat9H3v1varIYw2RcNP1ihpoGAPTGLlrrQK6gLHVC2ZAZgZLO82/VNPGkbp?=
 =?us-ascii?Q?R1aJMA4VGbWRpPgAjh37IyuN6ZJxrJ7MM1DmLCmwOUGe4lgpjD18uxrxFn4a?=
 =?us-ascii?Q?vXO4HFr6oF+AEISVieWsTiQJ+pxtikToFaBxjgBeuUBK6uuMPYA/x+OQWQ/6?=
 =?us-ascii?Q?28fC8ceVIs1obeDe0ScLi1PKSfDWqR1BaqHHCft7m8Z6MvZ+rsh/rD4+gVZc?=
 =?us-ascii?Q?uQRKo9tJqRQS+Y8OhEMpoX7KvtYLgjlNXNTUe2akKU/jwHx3KO9NG8khrC1d?=
 =?us-ascii?Q?6E5kF9PqWCJ8TCllKAuz+vkNLzVqkJ45ct5+HH5npy7dWEjNMi1UFlOhcxiX?=
 =?us-ascii?Q?zmh+8WddeQKOhBrK7nCtzmIiNzC+BuIHAw4A/7NOea9+VImHesRcm/3zFJuP?=
 =?us-ascii?Q?0F/m/S8U4SKAJCAr7IBKK0ziGmsdBjEbZVCRbObnFct+7Q5L+ymvI36iKwUr?=
 =?us-ascii?Q?/iiO+KhT0Wa8S5wCOvMLi8NSb6ObYGO9pSMk4UWCsd6zsj5NHtUFjRf2NPPK?=
 =?us-ascii?Q?sXAL/j8wFdDMwnTQZ5omxkFvExBbA9Ob8WtDwnZ07cvofVIDm3DxhQnok4CY?=
 =?us-ascii?Q?s8i8CZCk06DaN/fKacwBR+KP7vNvzvGc83ZuQHRDQh3Zx3ayt1n4y+X8DcMV?=
 =?us-ascii?Q?lUXByUlmQu0zo5S/XWDzzQ0fgkfR+UADlIFH1zlIY4+0ufjsSElTZ4EHaDx6?=
 =?us-ascii?Q?SyOfxrV8JD1KsIFuddaUvySPyE8FmQ9fEoJkxhl4g1T7l+l8HPkcbf487OHc?=
 =?us-ascii?Q?Q/jUpJrNm7ywnukv2Pr/ReBMX+A0Vr3u3LlDp/7VhaidEr1PLB6ZjFMCnVX1?=
 =?us-ascii?Q?n6bj2VKpXepvUX8K1g3sYAAQ/AWq5+yTICpYqbzjWy2BO/xZgUujlZt2PbTp?=
 =?us-ascii?Q?JKu+xfRtoFozPdeIJAUyFLfV44VqbmuzjJmjVSkjRGcCbqYzMqjbBPpzCou0?=
 =?us-ascii?Q?wWiPc6g1HeidfRT5p00=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:30:25.1803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18334ef0-3219-47c9-8fbe-08de06e42f83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c       | 23 ++++++++++++++-------
 4 files changed, 27 insertions(+), 8 deletions(-)

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
index d1172c8e58c4..2a0627596bd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -289,6 +289,10 @@ struct amdgpu_virt {
 	bool ras_init_done;
 	uint32_t reg_access;
 
+	/* critical regions v2 */
+	uint32_t init_data_header_offset;
+	uint32_t init_data_header_size_kb;
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
index e5282a5d05d9..5f7ae3763b60 100644
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
+					adev->virt.init_data_header_offset =
+						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
+					adev->virt.init_data_header_size_kb =
+						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW3);
+					break;
+				default:
+					adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
+					adev->virt.init_data_header_offset = -1;
+					adev->virt.init_data_header_size_kb = 0;
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

