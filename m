Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24036CD3436
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 09:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B019D10E195;
	Wed,  6 May 2026 09:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GTtS00M2";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD4C10EA7D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 09:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpGjWwR0T6PHmABpX/aEz1nOmso/x2pG6KlYFiUlOPF/RZ86NZ0rU6hL4hC6pZ3yx71yMegaQsvIROX2aBCss9w8C0/Y+FzpIAE5Dm8Ycf7q76RwPU+oxoOl28wPitBr1mNdDHMMoP36JwxqEPtMohUb7yONrwBV9ePErOXVMKEF7m1HEk2htKhpsNrqjxWHI3GoQWPUvHUg3409k5nGmeD8+HfWknTHEACCKUt41emJv52iByhURCMduN6syOkLhndDcDNSn8pMytos2RtV1S5LEheP60QDvJf2FUygIO8Gruxadjoo3xv4fYn3CgEXf8EN0U3CSbVLtt7EbQuUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALi3tvJdnLkwqLs7pAkWRWioq9QoxfMHePiGVND91jk=;
 b=b5j/bgdVGSvgSBXBQ5/i1P5BUxh1jxazL6eluG2qLlLj3knz7+AvmahrGgHwSmqEW0EeoWSMIyTY0zXKNjEWBaAld9rH6Oc53d0epltIq3tquzR1TAlanRNvNPNpYS7M95NBNroTWjO9IK48zDVTH4Q338N5YXuzMytslcq++8+d6jzFPivdvSY12CFAfyegwKQO43j+WeYJA80TyhmaiXumhuyOCVV6fzz0ZvyhvcmN6d8YPf2TZNIbV7dVcbWL+bNjJ4iME38ia3VlewaeQVihTFv8iJPwWPaUVnxc1O6ydGz+WwAuXpWDetvYHERPAg32UvTFr8nW1w/z36Kifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALi3tvJdnLkwqLs7pAkWRWioq9QoxfMHePiGVND91jk=;
 b=GTtS00M2NpGhvxzK3HZiYLjzR54+srUxz3vSIT6Ni+0QaSHpXL6YkO8aoGjXE5HTn9kOecBL8nDGZ8Cj0T+Azmx5zA5KU8RuUsmsPwXMwLQ4xe3xpxD0EsYhCZmXWuVfRCtxmAdreIgQy/hAJDE4SsAliJATAZck1WOMMpeyK2U=
Received: from CH2PR18CA0053.namprd18.prod.outlook.com (2603:10b6:610:55::33)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 09:26:28 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::bc) by CH2PR18CA0053.outlook.office365.com
 (2603:10b6:610:55::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Wed,
 6 May 2026 09:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 09:26:27 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 04:26:25 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Emily.Deng@amd.com>, <HaiJun.Chang@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: Sync the pf2vf structure between guest and host
Date: Wed, 6 May 2026 17:25:59 +0800
Message-ID: <20260506092559.546713-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e299a9-ea6b-4ceb-063f-08deab518cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2PI8il7SBNakbTKuxIiz7wUgSq3TA2mifbuOrTlJ/AcoZTvrpDSKXocOCQiuKPAbAsUkrFHf5sMsQDqSpck9wITBsjsea+BjcCAgFVfeUfThTQvLMhHaslRbvjFvjQVV7IE6asfqjm8hiFhDBTYDJmAnmgA2DlywJnj7L5nFwsQ5ZcXs2ho4KWuD6ViHOzt7wgVhbLyYU8ryu/gggrTxHimVmozRS18SlSmU3kKwYk8ml3f6Wj8BiKBBB+J+e0V0gT9YTjNJHE+B6yjaUdb9pR0V64AABELd4xKmf6W8sOpTPe6QPyTgF7NZygluGHLLIPvSaL3lF9ScT7RWugXGQlR2SzrnMEbhwVz5B2HaGEVD7CqgAZbNqxvH1CRyRaDFl/NNY0B4kILmhaU83Muo9Emtx9aCGFIMDGyS3Anqqr9p2FYevBu7HXmulaFRp0i55k6ZVu3cKViXXGegif4vyLz1yIrA5Au0vRvEUo+c0ytD9pPEtrzZprEJQ5GleseEZqg+4XKFSkTqaxAnWAFh0L5jEkWpgXdFNGF+ESl7uuOR40LGR6OuOCoYkSt6W9U38QATNKvnK4//g3jlLBFjbXes3HeYRlKqVltaICim+gBIgXc1zyxgrENzZNpVFUwsx5KQK31Z8m9Ky1dtZGK7B4WBDIk2lGs1SpkpTD438elPW5LdR+G3jub+x6opaHDggOS/+HCh+ePIwxqoFvs7DT1sFssmQpVL02A+6bSPNbw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dBhvPjpqg3+2h16ZDitfikFDPdTFQtlXf52OoSq1KAj2hkYkEedkaDZ4f8dQzfWBxtpfejJQt+tVnA3o6Jts0v0lUjfUtHnNrDKECG4sonfrXLzhF2UfcDIlRKfgz0cw0Ava2Efblx5hfM7hhmbOBN0Q7nT9jgPcavNG0Wv5TehguJynAX4Hfzb/nYJ02Ahz3CKAlxpaSawmnJzenlG2UBpQnvQWBYP5xFbrOQhnQ5Gv4oBkUs7evxOPNcKBkgsT9bw9XSUl5M4BF311xWVjeGxJLzxMRTn08iaonITCWNwZZhlxSlcVlP5WfNX35D194ytCTwnWL9WKCEbJo7xe3fTMY6zlAmG5/nPnBYvcHfBWa0wysxERTDy1Q+wi4qac3NaEX5RJmxjCImfxKTjizTFzq0G0zEWtCCW+mOchhUNMhWQuf/0gRG3S3WkceWhc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 09:26:27.4558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e299a9-ea6b-4ceb-063f-08deab518cc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
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

