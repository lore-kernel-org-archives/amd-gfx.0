Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C59FCCD190
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 20:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DAD10E69D;
	Tue, 14 Oct 2025 20:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cFKculNd";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724D710E698
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 20:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7oQVXdC4ZNopUoqh7Btd6qXKC1ScBtfkMloUFwlU/42KgeLP1+0goeqacZQIgm9SGp2TUF3R0ud4IK0mhQmH2R3f/EYTFld0P0rB8nmFtyfSHaFQQEJ5P9nWfYQpeMfiyRlXZpNDKWfMC5bHmTr2+IXG6OmOSnbpV7aPtPqJ4qdx8SXDpZNcrr0cC1bz5tbvzuGYBOV+TjVBJwEkY+1+Vqwa/ySVp5W1TRP0OVlD1q40kmZhmB2AEwyEWl0CYraiZkw0kpq33z1B0ol3UlNkOj/yqH0a0NzNTKJQY+2AKkPtWX/MNqYEezI//2WUNEMuATYHVMrhX19w5im3yC4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdCDuEdCA5Hso81EZoxG5Dd0iDXU/QAXFA0rqAEKCbQ=;
 b=vDvq7eZTjvFeLW40w2tCvYpct1U2r23i1JkGBMU24yqsxa8KXhmcXUHJbVv14OUIH4j2mulrpogL2vwN35McVBo+8YPQs+5cAMBddymy6/JPhy3vvinAHZw0Xz4amHUjSz6Q+8+z+32IiGOm6Q3wJFNvUjydnC/6EA+H0QO91zqXxc8mbkSkEiCBQgk3gnyoYBLjOSONezzMnDCO5yT4E4PK15adqRZT5lnfKVyErssTbSBWPJZqTZvXCoPN0xTDPdw5miNQE/w4uCWP5/gsVkgDBlto7l4f28ySktHgy+umFLjJmUUKVAoo6cEqfF3faLtMquytdq6P3Zr1xd3UoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdCDuEdCA5Hso81EZoxG5Dd0iDXU/QAXFA0rqAEKCbQ=;
 b=cFKculNdirERbr2DVTA6Yk2IQDMpDt411M3wi/rE3MRMZIjjlp+4umUTY1C6i+BuhuYZqB/rtqFaLTy86QWEzdOwyg8lfM9aK7Tv2AGqQbLsJiPcbqQC1a/vMXkNb38FTMF0pDR72zKcpgVsnAhypBwBEX8DzNXj/KvJZgdj2Cc=
Received: from SA1PR05CA0018.namprd05.prod.outlook.com (2603:10b6:806:2d2::18)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 20:14:00 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::e9) by SA1PR05CA0018.outlook.office365.com
 (2603:10b6:806:2d2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 20:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 20:13:59 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Oct 2025 13:13:58 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v4 2/6] drm/amdgpu: Add SRIOV crit_region_version support
Date: Tue, 14 Oct 2025 15:13:42 -0500
Message-ID: <20251014201346.9422-2-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014201346.9422-1-yunru.pan@amd.com>
References: <20251014201346.9422-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab9ee66-0ce9-49fa-c21a-08de0b5e364d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PhziBQqp0R2CNRjo4CP8+WWoBX6nY7CUbbVAZEpUUGL+uJId4cUyEfVpiGIA?=
 =?us-ascii?Q?X+6FnRGVutjNioSSCJXtez9lX4SShbisYvqHOhqijy9dn730C5cR2bzLAAlc?=
 =?us-ascii?Q?wciDF/acItzw7FnT4YgZly2EffNT9oThPAAie2u6iVUrcK3BGKlHLCtqXw4k?=
 =?us-ascii?Q?knzVHVn+2tltwCkSRgu3Z1xxbIqjHLC6oo4ALO2p2OypEOSKDlIOZ2np2LeD?=
 =?us-ascii?Q?UlEgYahRl/yLe7YT6uBAd9Fr2iFFqazKFA3lJXWNGxTmZPqKYdkrw8tAU+9D?=
 =?us-ascii?Q?UjLs9AgEOazo2UPBhC/TBtMzq9Syuho8TVAUGU6Oy/vQRy419+h70/BzjqMS?=
 =?us-ascii?Q?TLzO2x+WXl2BW6/qhqd6AlA2TNA9lWdnYLb/FIyPweyPJdtK9Ta51RRtr/bj?=
 =?us-ascii?Q?Mo+DW1RaLz7Jg7BDtzBIM1XuvlVC+MbX8EicT1mlNoGsLIR9jej3pzyMU8Nc?=
 =?us-ascii?Q?WmaDvmx13OeojlU8Z8JqvQ6MNFzmSCLER4tQgLBpYy7PcTyhZ6NdD7Ylqzvb?=
 =?us-ascii?Q?9BrodqtwYEnvebYlhr2xTGC847OUfDS7i2Cj/Xk76sCV0DDx5pK7TxeUCax9?=
 =?us-ascii?Q?WD9mRFI4iMnA3MPI/yxaFrTmHU4stU0KEpSu0OL3sE2K/+HBdn1S5q5V3T1N?=
 =?us-ascii?Q?E1TxJJ4U0ziB3LyEUSIIc++cG+lkpmh9P/YQraTJSZnPhWho/Zj0Mx6z2aEB?=
 =?us-ascii?Q?IxZpg+s/DPQDEk0sx9I4cgH/5+GIdRZ736V9rit3ZNw+W3xhu0+X6vDJ0aGp?=
 =?us-ascii?Q?DG+5UHzmnhURNwin4C+9SHDywdpUF08ub7kwBVrSNc/E/NYxsP4GEaHODWWI?=
 =?us-ascii?Q?B/wdg3wE53eQxTn3i8BUUB8W3RE3lhyCxdaYHeap0od8ujZGp5OUREnIbyi6?=
 =?us-ascii?Q?iarPMhMRdUmrgd3Tly/yFGoC5jjW4GsLaJ552aCQy9l37cLmx1yQPn9WPzGg?=
 =?us-ascii?Q?oVwiC4VdkTdUInZ2/gxfR2X6GIP3+Y+D5UQXaS0ZpBsuhftZVnV1UaAgjfbI?=
 =?us-ascii?Q?eGY4YgkdClDOVoQutPk56GV3P299+BUcrQ/EqIW+4jecbhtTigNpMv5g7OfB?=
 =?us-ascii?Q?O5WRNX0KHCgctYBn1XIGsygYzXPR2tLK7nZfHzrd6gUFi3OL/KcBP44wFHDk?=
 =?us-ascii?Q?WjhHVOkjPZOmeDLYGma4m310JJ4zt6xMpE7Ld006YD04ETtuDUaXaFAbB6hJ?=
 =?us-ascii?Q?rmgVxOcZdGey8eW9huqEM1sS/27sMxpJw6EAP6DXt3e0E/7EEvnRtwCfpjEv?=
 =?us-ascii?Q?QgBHD5ZQdXWaXvJZXv+CEZi9IxWEMsaGJMe6IVqkAIwphw8iecX7pMyRFAKD?=
 =?us-ascii?Q?Ts8B8MUYdGjAzLkRvesGJITlCTjBkp1SpMQpER/mBR10lWYj0hYDUQ4NZSUZ?=
 =?us-ascii?Q?qp2RLoNJ1Kir2wf2Blh3NteDBzjsiWsh3OaWdieLni7wj2Z4zhNDBf+bDxvi?=
 =?us-ascii?Q?28JIE22Q2mD9G1vXvDWLmKZGCU0bJX2u+TW1Y6oA4HKtsVicQdeMFlm4YLSe?=
 =?us-ascii?Q?S+A5MPXnROG+KfKMAPI7JJK24EfY9miQ3LQtLp1CCduIs+AhTC8puNUErwPZ?=
 =?us-ascii?Q?xBUREpQWrZUkeDVSpGk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 20:13:59.8470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab9ee66-0ce9-49fa-c21a-08de0b5e364d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  8 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c       | 23 ++++++++++++++-------
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index e95adf0407a0..39ab7d00379b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -150,9 +150,10 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
 		virt->ops->req_init_data(adev);
 
 	if (adev->virt.req_init_data_ver > 0)
-		DRM_INFO("host supports REQ_INIT_DATA handshake\n");
+		dev_info(adev->dev, "host supports REQ_INIT_DATA handshake of critical_region_version %d\n",
+				 adev->virt.req_init_data_ver);
 	else
-		DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");
+		dev_warn(adev->dev, "host doesn't support REQ_INIT_DATA handshake\n");
 }
 
 /**
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

