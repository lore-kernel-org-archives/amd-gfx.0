Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EB4FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A7A10EAE4;
	Tue, 28 Apr 2026 10:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="snr5N5Si";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6550210EAE3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+gNiG0lDFU+DLuZqg0Jc+ppsJjGzaNQRNilpNfs+ozRu5DcHwNsmwP+Q+jP+1zC/09cJGriN5WFeWN+d34aXY3cxerYxvhO5RF2wTDOh/DeDzgl1cVnCEhHqdOzWskqRyxX0BlLXRqJ20YaWzqZA+ge1ztpswz9+UQh7Rbt59b7y3m+MkQD/LbGASw+jx64NnmDsGRJSGZj7iUAFG8q/+YlU62cnBSgTh5WoNPAhx970OgzDbC8K6yGXP80py8/GxkAx0hIMx4nRRz85E0j6uql8qoGeB7Y1kwYAibpHeUKkQG7AJxM2NHZTiCn9pYlUc1xEJwfEDDbkvCbOu8jrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/rNNqpZOZqguVVE9NacgtK48/gmmNVpQVE1V8wz24Y=;
 b=tk61s3fexn0IuMi+Qv2/1r514EJcxvSZYRAmB8FVs6UI7iP/0cNqvBlQzQ5t6AlCVrQ6GRyv4NspTofN5bCfsf+qk0c+FHK4THDMs+rdGz4i2lO8baGcaXORAGVUb6o8+M/Yz6dUj0UfgDayU7qFMf6vDBkHgRA3bsDZ/l1CUNGDq+yrcR5eAxr/ufTYQUmERpI9Evfp4xcNxfFov6frt+oVRXfev3I6fCO2VInikBduGgHahhmHYugwkdomh5NSW1euYMC61UhE1Ic0u3Q7Ic2EP4dO4ue+dRqdiUJuRga3sAvhSigCiuUfIOCZLpAQn51V78qIV9G96gptRhVE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/rNNqpZOZqguVVE9NacgtK48/gmmNVpQVE1V8wz24Y=;
 b=snr5N5Si0gnGvkLHvS/iP/C+Ti25jUNU4j7P5zsCllpnjU4afIKBtRlD3Y1AX+hw+d8PuBrR0z4cpyKKKZpSKbX3jO1heN0xYIrPnrHJv5oyibz1Mb7S3dIsPJhr+oNm5Ar5yjJ7oPvjX+6inSLZnGi62RfHeLrsuMi4B6qjEnQ=
Received: from BYAPR06CA0037.namprd06.prod.outlook.com (2603:10b6:a03:14b::14)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 10:42:49 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::57) by BYAPR06CA0037.outlook.office365.com
 (2603:10b6:a03:14b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 10:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:42:48 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 05:42:46 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Emily.Deng@amd.com>, <haijun.chang@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: Sync the pf2vf message info structure
Date: Tue, 28 Apr 2026 18:42:34 +0800
Message-ID: <20260428104234.428945-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: f17b6461-0518-4c48-b5cf-08dea512e40f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yvA67Nj3ZPdRiPRBeym3fy9aJAnLSrRournTDGmA1usRmPQr3ALPI4cwIWCdHjfdVsHpkv4dLWJatAaanu+rQCPbpwq2/O4+zB4bi9YVXSTfRyeqglD04Dz4BlDSuu1TQUB3mwWhmXTeSVNdEPWv1wpcCSFviWoXWO7CL0ga+sfBobZT7vIIOcSqrAPj7AfOtOI86eyCTWsMgo9Cg2N8xIggBEpZ9LWzzK7Fy4cyW9sV4o7VW8DuGcsTncLuULcsUcWWxc7J6oWP51z8p9Zl2ObL3/8Us1C3VT+SmiXeFNKoDyFIYyW6sgflfVSpo4WaDgQDCaQsUEREJu0WB/5h1nMyRvCHPiPrMQepvo1LrrpLihXxwnas+K+idyLCeitIa2O6XEh88R6lWScaK5Zfp1ar5LVBGcuwsJZ1XiqVgUhGki9WqXzJb+UvsgwdVoCFEdgGX3qb0+TlYqYEmmggdIUtE6+dIkZeH++mmU+txVP7eWUfALU1D7Dg95u6QVouYHke0qIkgag387DkRfcjWPD7CmH5MYXmUaQruKJy5d3JCcdvg9WQMmEYN1aiK+J9wOo/BU30+4j37ZQlsw2vfucGLciFMWWcoOyni5nN3S26LpfoY8Xapme4Mv0YU7Dm3cXuhZnK81Hl20tcEjkGDiNRzVcukLByoJCUlmc+MTRT2edMEmT/PpYfpWS2jYqBJVckE/1Ob8jiWTm9pB9k8tx9pGeV4cRBo7HvG+4hn7gdcIYAu4Gg0doGXcRf/yNOF5uYKbTZ8cWBCUeih1Eo0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /38y6X4PdDlsk3pWmlt79FDg2oHakRhB2q2UVMBI/I+6ZdIYw0d91jEzmGW1xuTUbV6fxt+P3FxYST52/FNNnPywpEpgEzuoEZWoP38qkDHjsyt/sj/GuJWW+7ou04r918x13nqPe/SqcSAqUwWxGtKKT4imJ9t3Kvjd4aMf9dK3CyiVNKLLYP53eknd7LErsMKt8g7A1cTLrv47ZH56zBXLBD4gxwnI9vLHXlDzUjHJCjIDHWCzhtw8BbjDXxCJLHsUaYKa9QnMFgnrU7YNDolosfSbt/+SKqsriwbBcIuA0wdjolStgmPUCyp4cqmSkUfIANEKjXFgQvswzWfHfSDGRwX5iD8sIDXWTdUfacnSSjIpq8vhRt/jLPxi30+ljd/2mg1Ly/mWxD6IewA7F76M22JTmzQhU6HkeBX5MM3i/Slw2TW2mi3scREm//6U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:42:48.6080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f17b6461-0518-4c48-b5cf-08dea512e40f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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

There are gaps in the pf2vf message structure
betiween the guest driver and the host driver.
The pf2vf message info structure must be kept in sync
between both sides to ensure correct interpretation of fields.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 9da0c6e9b869..5f889382fe4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -163,6 +163,8 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_RAS_CPER = (1 << 11),
 	AMDGIM_FEATURE_XGMI_TA_EXT_PEER_LINK = (1 << 12),
 	AMDGIM_FEATURE_XGMI_CONNECTED_TO_CPU = (1 << 13),
+	AMDGIM_FEATURE_PTL_SUPPORT = (1 << 14),
+	AMDGIM_FEATURE_UNITID = (1 << 15),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -441,6 +443,8 @@ static inline bool is_virtual_machine(void)
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
 #define amdgpu_sriov_is_mes_info_enable(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_MES_INFO_ENABLE)
+#define amdgpu_sriov_is_unitid_support(adev) \
+	((adev)->virt.gim_feature & AMDGIM_FEATURE_UNITID)
 
 #define amdgpu_virt_xgmi_migrate_enabled(adev) \
 	((adev)->virt.is_xgmi_node_migrate_enabled && (adev)->gmc.xgmi.node_segment_size != 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 847cfd1fd004..7af60c704722 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -162,7 +162,9 @@ union amd_sriov_msg_feature_flags {
 		uint32_t ras_cper		: 1;
 		uint32_t xgmi_ta_ext_peer_link	: 1;
 		uint32_t xgmi_connected_to_cpu  : 1;
-		uint32_t reserved		: 18;
+		uint32_t ptl_support		: 1;
+		uint32_t unitid_support		: 1;
+		uint32_t reserved		: 16;
 	} flags;
 	uint32_t all;
 };
@@ -256,7 +258,7 @@ struct amd_sriov_msg_pf2vf_info_header {
 	uint32_t reserved[2];
 };
 
-#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (55)
+#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (59)
 struct amd_sriov_msg_pf2vf_info {
 	/* header contains size and version */
 	struct amd_sriov_msg_pf2vf_info_header header;
@@ -314,6 +316,12 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t more_bp;	//Reserved for future use.
 	union amd_sriov_ras_caps ras_en_caps;
 	union amd_sriov_ras_caps ras_telemetry_en_caps;
+	/* PTL status response for guest */
+	uint32_t ptl_enabled;        // PTL enable status: 0=disabled, 1=enabled
+	uint32_t ptl_pref_format1;   // Current preferred format 1
+	uint32_t ptl_pref_format2;   // Current preferred format 2
+	uint8_t unitid;
+	uint8_t padding[3];  //use the 3 bytes to align
 
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
-- 
2.48.1

