Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B2DFCB61A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7759D10ED58;
	Fri,  6 Mar 2026 15:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PZx/DdPU";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013064.outbound.protection.outlook.com
 [40.93.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38F610ED54
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JekwD0L8fH8gjacRG0dCTLrwdFOfe+5vXh3LDxyQ5OB3nA3pkoQrxr0AfVfF2ate0yRuz/9WGCwblN3MVL5GupcI5tdthvQErGt4NEvo1NUcClDDz3uaXp/wnPrsI72/ffA8JQUHRxF+467Mj/OSTmqQolMZXydIe4S4PBf028814YfwQIyCDalFad+7SGBuQRlWrEYksVJFy8zrkajFxcwRfA/uNtwELfgN6aE2FW0jH9I6PYIVCWqlUcyWdj4F+gAnCQPGfC+ntXZ7IAcZ9pkQ3TzAZ6Cdmu3U/M/Bug+77wI9Lap5BdnQVXJNo5w5S+E7pLajGGESwNVXvXvxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVFdeG8N+YBM9+8bmE4DesaHtantsZKt6I2Xe75DhHo=;
 b=q7WhSkyj3YHzCdaTkuO0nEVtjrOXz/k/k1tFp8jURyK8o90s67WyMzwqMjzvLsC5O8fazjP+WfBOUihZFnK90EYtQw/YvuFP26kQFyY9iQoA1muxMTQ60Ms/cGIgPxRIyGE5z5AcXxGYFdaGYBfjcJZcKB8M2a6Ihi8M7zadJUqJWmMw3WmjCL0fb4GniBwJiT487IjBr20yurHwGtEyPd0Oh25OL1YZxopJYY9sA5UvgZ8ek2ybnXWBP/FRJFM+se14Z/hX1uwPsF+PZwGt0qTPlVyH4EidDp2lyJbhi/TX+xq1mLkiFjrn7xfIXTAalYHqUsoSHffo1ISOWj7eBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVFdeG8N+YBM9+8bmE4DesaHtantsZKt6I2Xe75DhHo=;
 b=PZx/DdPUrtD1ddBjLsETkE0iRDxz962jqeYPJALVSii6Ee+2pOobVogbHVcKM3n6qEtGH6EByqvZi1TRjqCqYVfrIn/8r1g5kXRQKNxfzkWnjfRzn4C0zlikmIxdx73yf3F10e/jWlWofDx47v7Q6xcLXDagVAaTSdSUIegEZgw=
Received: from SA9PR13CA0022.namprd13.prod.outlook.com (2603:10b6:806:21::27)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 15:36:28 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::c) by SA9PR13CA0022.outlook.office365.com
 (2603:10b6:806:21::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 15:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:36:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:36:27 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:36:26 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:36:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Use memcpy to update IPD table for sriov guest
Date: Fri, 6 Mar 2026 10:36:15 -0500
Message-ID: <20260306153615.21854-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306153615.21854-1-alexander.deucher@amd.com>
References: <20260306153615.21854-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: d0953f25-d5a8-4f99-5b77-08de7b9621ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: ydne3pMGvtgDCtno9RPj2EQP3gP+kvDnTVF14Ib6k/JMjlXRJsbqyrCmh70qfd+kRW6002xPLCes+VM6D9P74uEcuw03yIOvHIjaealnkxbRLGey33wE7yMy1H7jQNOKZTRkFbnZtT1Mx8tUpat6UF+hoONcFFd/Hibw9sJCa7LNbo3Ju/TZoIyJ9T4HKFvYMFsWSe5G9tMTbivSEow7shGoFXLauioHsDHgYWkXDXXSZBpNc4DejiXtuqvoADqrGC4DhvYAEdYsFnwER/iGKx1wpDojHs0mFXnqaDhN/i+NgX16TrWYgZDFT+FFivhrEyNT4qhpQzmjVTANn67BqjY6g2HspnwokBPeaqLMfAifXvK9gs7Oa5SqNed9/1ERmfOATbncnmhqqjpQd5C0oMBW/MkO4kgPP2AIms4TcWE26xwehJczfsA2WeHvffY+7p2l9EhYAZmC5hmYHNi5/5RzEZwlQT+m/ew6yujdYy/v6XPhXIINNDa1pg6qd1GZDp0BoFgHOBJBVFueHKDu9lJvKEpZvgIWe14URrHQ6hvRKzuufrNQg28KlKrKfw7bD1eyyHUqGgawwPUGXZhJzz46eYmVWG+Gu2uw7YSr/SFVA5Q+kJqPv0qbLwURijS66I0e5qBaE0Td0QwmwMRb3Q3wEdO5JGAJDmQmgiNnsSv+XR9A7gt49RpEyVUZn1h3+b/Nnhrm4vSrm9HAWngynQry9E2etx1vBKg7raTIWSw2/jo3h/B48jME1ZpchzN5VdqRazlpvAzLOcT8Wht2Ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XB3jIGoYBRsv7Dzn3VIB3m+YAUoT//OBHFNsLSzWx7nf+Op0pUIGop8j0PWW9hF11NeToDFuAkBFk3UTCLpi7QQCWe5mSJifXbzwFI8tLembu4j3wICUUUhk/DLnQoav7tfsJPKg+QJcgJVecBK9c+FwZ95Q1/M5V64DNkdEKF/+4thtdBfU/lvG25mY1Sp2uoYeJGp8uP+X4p3Q2KGeQGu4aMHeM1ketbOAhekKDU5sJe1/R/dbt25L0T+fUTNkSo3dsG0y9uySptfOWP9uqRSxcST2pyEKgKwQoSUP+22I7KM5sAWly6m9l9x3jf3A8Q+M11i2Vm7AsZZ24EFT5QBjrTzxqxIFjJtO4XUaxNFyJcvbdFwo5M4HMLtEQi16LXC3UZH/21EHo40aBwMr+/KerHuIJLjGJrjqs6a4R3d5okC2RgOduqZmhbmOdYtD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:36:27.6875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0953f25-d5a8-4f99-5b77-08de7b9621ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

On some hardware configuration, sriov guests
cannot access mm_index and mm_data. Update the
IPD table via memcpy in these cases

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  3 ++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 36dc0add26f32..daa2a27718edb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -356,10 +356,15 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (!is_tmr_in_sysmem) {
-		amdgpu_device_vram_access(adev, adev->discovery.offset,
-					  (uint32_t *)binary,
-					  adev->discovery.size, false);
-		adev->discovery.reserve_tmr = true;
+		if (amdgpu_sriov_vf(adev) &&
+		    amdgpu_sriov_xgmi_connected_to_cpu(adev)) {
+			ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
+		} else {
+			amdgpu_device_vram_access(adev, adev->discovery.offset,
+						  (uint32_t *)binary,
+						  adev->discovery.size, false);
+			adev->discovery.reserve_tmr = true;
+		}
 	} else {
 		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 886fbce0bfd1d..9da0c6e9b8695 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -162,6 +162,7 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_RAS_TELEMETRY = (1 << 10),
 	AMDGIM_FEATURE_RAS_CPER = (1 << 11),
 	AMDGIM_FEATURE_XGMI_TA_EXT_PEER_LINK = (1 << 12),
+	AMDGIM_FEATURE_XGMI_CONNECTED_TO_CPU = (1 << 13),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -412,6 +413,9 @@ struct amdgpu_video_codec_info;
 #define amdgpu_sriov_xgmi_ta_ext_peer_link_en(adev) \
 ((adev)->virt.gim_feature & AMDGIM_FEATURE_XGMI_TA_EXT_PEER_LINK)
 
+#define amdgpu_sriov_xgmi_connected_to_cpu(adev) \
+((adev)->virt.gim_feature & AMDGIM_FEATURE_XGMI_CONNECTED_TO_CPU)
+
 static inline bool is_virtual_machine(void)
 {
 #if defined(CONFIG_X86)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index a841f342a3ebb..847cfd1fd0046 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -161,7 +161,8 @@ union amd_sriov_msg_feature_flags {
 		uint32_t ras_telemetry		: 1;
 		uint32_t ras_cper		: 1;
 		uint32_t xgmi_ta_ext_peer_link	: 1;
-		uint32_t reserved		: 19;
+		uint32_t xgmi_connected_to_cpu  : 1;
+		uint32_t reserved		: 18;
 	} flags;
 	uint32_t all;
 };
-- 
2.53.0

