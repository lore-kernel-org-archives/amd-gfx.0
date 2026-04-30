Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD8CFF8873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 16:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F65510F3B0;
	Thu, 30 Apr 2026 16:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FuYld/IR";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6047F10F3B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 16:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE8A7W11x7cjhK/8uLquRFCYUE9W1dAZiRGdMOPwAy13+P95iMURGcg5JyqepWiuO3EsDawoAA7n1tu9sCoQpCeJAQjBAenXjv5d5bAOO/xRvQQDg+kf5tr0GL5sX5ntqs86TwbDf1ftGZny3BaBXvBigNPeEJ3RRnrdQUZ0MmVB2oZyBhA8tXGZdKjO5vNLd3RW8xAl/m9BAs9bUO2If1bNpN26lB8FKYvIrTvGiDDbPWF7ifUAaMiBATTj2cRmMQAyep67y9KwVLzrFL4bE8GQSoZXiJH0o6+Vfh9hGoedXosAI7w+Fjzh+y2c1Cg0aFmuVvDxt9icCFMkiPhMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gafl+D6Nsgxjy0aqv9xcOtXCL1p2InBq6fuwRTLSOkQ=;
 b=V1JnsLjtxKotnj+8HBxDIp3kr2HXa0bRFys0EosAnC5GH/Oix/y1l0FmQxNVOwvLwlkyNJ9Xe65weZHrAgXRrDJjXgCuWb/uzTTSIwSxCvFjFXETthZQRBmQHECKsUnwF/Bnt44X0cdv3m0MyjLSgxR5zyrZ38VsNLFZLNrn1GiHxzQ0k4Cg0LgpF73Z7296SvZ88wDPTmSTqmKxZ7p28kaut2Ybx74Qt8DkRwj5CsL7JC+tY8bVsQtZmvGer56CdefkHXA5yK2rsLDOpTNvIk1Sj0eRFp04UOhmQHD8XlsHkgDx6E6T4SUs7Q3yG3qM8RIEh9a/Rvsy6H6Tct1ztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gafl+D6Nsgxjy0aqv9xcOtXCL1p2InBq6fuwRTLSOkQ=;
 b=FuYld/IRvx0CnMyBcpjy+qE8D64Q1fK3sYqLeWshyaWnQwFiveJnIzyBNNkWb3LsqtnjhYvEXYF+tKAJEz/vsSspZoEYBIZu3uUvpxm7Ylr9LkZJSX82PCF4CHxbM9MxJTY/d/h3KAcfG29IixyZR50sd8ulmGuJucSeNJQeMfY=
Received: from CYXPR03CA0072.namprd03.prod.outlook.com (2603:10b6:930:d1::27)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 16:12:29 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:930:d1:cafe::20) by CYXPR03CA0072.outlook.office365.com
 (2603:10b6:930:d1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 16:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 16:12:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Apr
 2026 11:12:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Apr
 2026 11:12:27 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 11:12:20 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v4 06/10] drm/amdgpu: add AMDGPU_INFO_DOORBELL
Date: Fri, 1 May 2026 00:03:34 +0800
Message-ID: <20260430161146.2851078-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf65aab-0cb4-4dc9-60f5-08dea6d3464f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ayzgv3edqG4S4uy5eMfhrH8aEartgjqa4W7EtVTt2Bd31JN0NUOX6G0egMMvFyKS1kvwaHaC27j38f8bgoTErZl0q98bkp3MPZ3TssUuY478slMFn2KMdC8VwwPXz+z6FLaZYQefLN/XwM89mmqbJ7BscafbnKrPKLta43Bz2IWPfqnNQiDLZltczk1kmxoiIfSQ1GoUq9nwqd+OgEuf7K+wN9U72r0zRfOrOKsmd8nT5CRy3zG6+axVc+AO4+OSOXMNqgV1a8Guc5lASQyPy8neoTnhHsPNl0IY83xcThDN2bvILlFuyunrdyvhKan/8OJ6IIdylPq4np51qyP6WxP5aTrV0ug9WTgaRmdGbgpkqjEBvXNqwVnf8q2LSIgwEESQod3V6SR3a85OfLRuPgM65ZKiMJmlP96/ukorWAtjtWdEE6u/hoXkx5+LU8x/UIR60S6Qh6IvfBAqku+CWEcjVVt8Rc9Vscjqo2CDXfPRPVynh7+g1EBis4Zv96HgRYdd880+V0rZK6ZHF7po9u6QMVGhGCuPOmLb2IURXZeQ4HBz6fjPkTZZA/3/M64zI1sB25UDNQMhXQALIHCwyBUxu6zzShCYejxLHGIprI2hKpTJN7JYOHYQpiSVaii+OT/KEOgpzTttsa/qvsQ2eYHLxyD9uni3Sgs7SEBR/BA5CBtulFZomWBHBXOTPM9MiQignN5/LZ9pASvqtElhoU8VS0+hqsD/l9thJ6VorhTVz7ruU+15W42a+arMCMuvgk6xUNfeU5WIavUu30hdzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wJrjoFhxpSJ2JmcdvhyCdNdVXWvOKQ/jgD5cXGxK0Sa73drveSQR/RZn9kMdU6whMo5tLnZWkb76Ht5Sx1ZsnJ0CIM9Tw9xlurERlQJoXi6EStdtUTanrOh+Fr4wA0R6atl+JcwalFBgmgnx7wMDmq4GkElQ0PX8uKuBDvdgl3iwb3Yo5ZigffhJt8rnCanGpLOjbaZTxk4F4mPBr9+mhLPypb0PaBM8z5pH2OUyjf6IUG/0A8iCKaf22xfH3f+rQnR8bIa2tgpVFQKO+0ozuNf4Iwim4MlhKTS5NYQ/o5V/3LrkeC1crrkoEzqCKVQbCgT6nRScNDOouMeEk1MOPCbflVbDqQL6E4obyc+I1y2aJ4/JtiecQe+bKBj1uHI00dmqK2PxjFTAvsVDucWU7boTZk3pf2UuNfZMdG9h5QPHWDVvwpWdFNZv93ghh96J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:12:28.0304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf65aab-0cb4-4dc9-60f5-08dea6d3464f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937
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

From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>

Use it to get the doorbell range and aggregated doorbell enablement
and offset.  This patch only supports VCN for now.

V2 - drop VPE and use vcn.agdb_offset saved in
     umsch_mm_agdb_index_init() (suggested by Alex)

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 include/uapi/drm/amdgpu_drm.h           | 13 +++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d88e4994c8c1..a3beeff800bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1425,6 +1425,24 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_DOORBELL: {
+		struct drm_amdgpu_info_doorbell doorbell_info = {};
+		/* note: may need to check asic_type */
+		switch (info->query_hw_ip.type) {
+		case AMDGPU_HW_IP_VCN_ENC:
+			if (adev->agdb_bo) {
+				doorbell_info.agdb_enable = 1;
+				doorbell_info.agdb_offset = adev->vcn.agdb_offset;
+			}
+			doorbell_info.index_start = adev->doorbell_index.vcn.vcn_ring0_1 << 1;
+			doorbell_info.index_end = (adev->doorbell_index.vcn.vcn_ring6_7 << 1) + 1;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return copy_to_user(out, &doorbell_info,
+				    min((size_t)size, sizeof(doorbell_info))) ? -EFAULT : 0;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 82624b44e661..f07920594295 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -368,6 +368,7 @@ struct amdgpu_vcn {
 	struct mutex            workload_profile_mutex;
 	u32 reg_count;
 	const struct amdgpu_hwip_reg_entry *reg_list;
+	uint32_t		agdb_offset;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 062ae4741fd6..3ffdd2f8c418 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1276,6 +1276,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* query doorbell info */
+#define AMDGPU_INFO_DOORBELL			0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1677,6 +1679,17 @@ struct drm_amdgpu_info_uq_metadata {
 #define AMDGPU_FAMILY_GC_11_5_4			154 /* GC 11.5.4 */
 #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
 
+/* for AMDGPU_INFO_DOORBELL query */
+struct drm_amdgpu_info_doorbell {
+	__u32 index_start;
+	/* could be equal to index_start */
+	__u32 index_end;
+	/* aggregated doorbell, 0 for disable */
+	__u32 agdb_enable;
+	/* if agdb_enable, it is a value in [index_start, index_end] */
+	__u32 agdb_offset;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.49.0

