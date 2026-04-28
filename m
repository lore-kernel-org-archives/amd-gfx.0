Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10A2FF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 11:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7CE10EB06;
	Tue, 28 Apr 2026 11:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0vj1M3o7";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC01010EB06
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fa/jciARQGxjRktYC6bOZRc6IGPRwnxaWhWYhTdsq/gaYsTqis0rqAbFGuvoyxFRHyfQTy7yTsJSExMPUOReMwU7fa7RIcqh3uAKL1ZcTdH0HiWezjEJ7B4bdWPKsHPC83IvIL2/qzYonD5iLaWJ6Ctfd3QBCIizl73rRqDJCY4aRLFt6YbqMPw01ucKEiz8+L6y9JzDdSA5L92w5sDk2/sSEMQXL5Iu3vwUlKXv7k6eAtthZ/Tm5ZZ337MLsgY3fkL+3T34ViI9DU1QLvck39juszclBBOCP7CaY4Dgsw0VhA9UXJfHOM1Wanenuv2Wlr/mkA+bjULFQ4VpXakokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwvorouXOu7+H14ema1wNPGXAYJk+uX4BrJNsMTsz7o=;
 b=MtiBB34lNgf2sTDs3lNOIyS7iQv5JzLY+cqlHb69lMb9NIHTcpmrl+zZrNqYJw8MPcwK2xFOztEnJENvJWRWcXjr5XrWwL8xrzG/AKRUVr+ZB/FKDGC65Ja9bAtmd8eaAfqEhBbqWaH1HtyNjr/eNc4t3Axw0e+JlwBgDr8UWJoTsIu6zfjfWtSym8C/Fwyxflr5L9G7ZK4ov6SB3Ea7yTX+QB3Akbe/xxLDaNOXJjXjMsvt87cC6YVcxD3IXdb9Le8B3JI4DzAk62K2gykiwCjStPIMPw/MbrFVKfhxWMTzGfEFRasiHx1VFSZ9XH7Xi8YE8FysM/YZQuwgHa4N6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwvorouXOu7+H14ema1wNPGXAYJk+uX4BrJNsMTsz7o=;
 b=0vj1M3o7nT58SNqxN17g8v7AiYoiyn7Ip7GzpiyX/5k1CyFFLNNuwVjqjc9aBNJi8BZDafs4abMINr6bbZHPqWBLVuNbgrw5VdL8G781j0z4T3u4b8LwqcTTDMjjheQYlS510r4kqdlm6lbPYaS8pH1P8qEpHlIGhDldrk5nge4=
Received: from SA0PR11CA0108.namprd11.prod.outlook.com (2603:10b6:806:d1::23)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.16; Tue, 28 Apr 2026 11:13:06 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::78) by SA0PR11CA0108.outlook.office365.com
 (2603:10b6:806:d1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 11:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 11:13:04 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 06:12:50 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Emily.Deng@amd.com>, <haijun.chang@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: Sync the pf2vf structure between guest and host
Date: Tue, 28 Apr 2026 19:12:39 +0800
Message-ID: <20260428111239.431728-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1c1ff7-0253-4fe3-ab5a-08dea5171e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: fNCwG+ib/HHPw4Ky5K1OYtHl+8DPxSCv+GKi2PWq/o41So6o0nvW6BjvUuClO1duR6+m15sXFVb5RaxMUCsFEZ/DPnm3k7uhcP54YGqpHXikWiYSvTLqapvLCpuv9uykUsIyCZ9Ocuk5jeBXuii8uzfOtWzTv72Ub9g4E0MwFSs3o099WkrT7kFtbrIMTN5Zzis8iMZLEN+u4kIMzvyF3A+7O4pQJK4kOWl2nJNngC3aK+o/qJaaNycyUY8s2MvAKUQfYisBDe9PqZA1wlT93C7tlFkr9UlH6/K5AU5qRKO3WKmfqDPin9xaC4Iqg6bGm5ZI6LBRqwS+sLktQjqDZ+y5PkvfC4dSCQccb8mntXtSOqQMEBOH/7/tvHEvmXw/KQaHWTxx9dMp5XtDk4lkYbl1jxBRZpYJDVAJJALcz+DvYKXtndL0tSStgqIR3DQ1DYBfvN9O2S5RfcUYtTGbr+0v3c3FNUbZYGVkTz9S3GV/lwRTAjzsMKGLi/zRfcOLhP6Hb6ZBbood1vRs16M1EQHYVUd1UywyHtBMqUvnpRruJ2MnZN2Rj2U+c70qXJ4yX6YiKdaPqAX5depoCkWapNA0qQoT3CbedCxOHirYLpxXQVaytjl7y9uR/GRRKOSx0EcKyZTdvXihhfkAgB9ocGcJ7oWkl4M8ZxeeE167jM/18qBdtl+sLN3OlihT6q+uH7D7KbrXkc+u/E8yD1X+Lt/RwvdonMU7dn4AObZh/76W7YGskHgefBMf/4Czq8WjJDnSTY3v9DIUSme6qdj+2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iRMeHTRxWFtlld3dom1C/oBLf836hmStP6tn2jlKr5GQVGSy4MNk3PuMa+JZNEsUzLRDIJVcKKful+ofPeJN+WL3ws0goUJczPlc2oqeeQU0V1u3Iwm6jr9znI7wRJmUUP5Z9Z5lC7H3xX1eja20vHl0iGO/9EddLF/weJvP2aM1m6d8YvRX8g/dfClj+82wcow+nN2En01eJatM3RW4C+UTcAweHWLDZTIq2dC1oiR7t6UcSxEFXY4VYKPPAyV1fI/2dhxGIVOsgwj9gemaHBdIbPUCWX2W44wYbnAXXt/3596gyt//UxbTAvPr4JkbNYed4KyJX9JyCkr8QImzNOvSkIqzmDpAqksr+h8Tm7Z8XOheMV/xW9WLOMk8PdJ9N7S310K065t/I1MZ6PCjGusPCx4Hbmb/BnRTW2WzzkOMxbSqVSg2cNeqwsVnlY0s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:13:04.0757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1c1ff7-0253-4fe3-ab5a-08dea5171e1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
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
between the guest driver and the host driver.
The pf2vf message info structure must be kept in sync
between both sides to ensure correct interpretation of fields.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 9da0c6e9b869..d563deec0916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -163,6 +163,8 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_RAS_CPER = (1 << 11),
 	AMDGIM_FEATURE_XGMI_TA_EXT_PEER_LINK = (1 << 12),
 	AMDGIM_FEATURE_XGMI_CONNECTED_TO_CPU = (1 << 13),
+	AMDGIM_FEATURE_PTL_SUPPORT = (1 << 14),
+	AMDGIM_FEATURE_UNITID_SUPPORT = (1 << 15),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -441,6 +443,8 @@ static inline bool is_virtual_machine(void)
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
 #define amdgpu_sriov_is_mes_info_enable(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_MES_INFO_ENABLE)
+#define amdgpu_sriov_is_unitid_support(adev) \
+	((adev)->virt.gim_feature & AMDGIM_FEATURE_UNITID_SUPPORT)
 
 #define amdgpu_virt_xgmi_migrate_enabled(adev) \
 	((adev)->virt.is_xgmi_node_migrate_enabled && (adev)->gmc.xgmi.node_segment_size != 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 847cfd1fd004..9dcf0b07d513 100644
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
@@ -314,6 +316,13 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t more_bp;	//Reserved for future use.
 	union amd_sriov_ras_caps ras_en_caps;
 	union amd_sriov_ras_caps ras_telemetry_en_caps;
+	/* PTL status response for guest */
+	uint32_t ptl_enabled;        // PTL enable status: 0=disabled, 1=enabled
+	uint32_t ptl_pref_format1;   // Current preferred format 1
+	uint32_t ptl_pref_format2;   // Current preferred format 2
+	/* unit ID assigned by host; vf_idx [0..254] maps to unitid [1..255] (0 = pf) */
+	uint8_t unitid;
+	uint8_t padding[3];  //use the 3 bytes to align
 
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
-- 
2.48.1

