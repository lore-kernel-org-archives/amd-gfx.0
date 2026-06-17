Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844E7CD98F1
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 10:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200C310EF88;
	Wed, 17 Jun 2026 10:30:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BEJoxMW9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13FC810EF88
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 10:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRXrdlGOF/lPF4jHdcHWqmXyc9V7okSrD2DvXtJUIS2pMpKqNvOMgG38RCUXT1PahZTeYnhTUYsgfdrHd2/4MsHonNRAM3CJADb1j3Llueqtd6ysVmI7mP+FoObRHG3gSE4YciGpl1Gc2DnPKzaaT2dbkp7McLiYfl2X1ji1MKhfV2bWQGPrtX0iv2xWk74YMGJe3tjJDX0LnX9x8cyHWElsn6AUvzhLODW1BVoRj0xanKXnzd2wn9wwAbuwAyPItd9RCpukD/Tr3ZhvoZobpQnhRvlyAg0ReKsHk7rnUGO0LiAvF6c40LdU4SdL/9oIiNtYdwoJeh4s/0KL+zx8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=cWEoztjvM0Rig3Wy7K7726dvTTmpwmBcoZkkmzlPxGbNgRHkW9cQPPL+cRUqcz9xkiqxke1oNoTqTQkvvoZsAVyxMGXxscYNjSkvm/EVSSUKxtmFXLhMNv/cdeadCu5X9bEl6eIRc9+HFj6K+oQJBWR2Dv5PPBYU6v3tksKeNDSdtZgQuUaZouerMcflW4Ex+D+IlJq5h0x36bGOxAx9cUtj8vszX517kM/qil4872AqEkK108jL7oN9ug0cjPRBLgNPBQlRT6NdQA53vU53q8fMYVRwhcZT81AUCjHwE7Cah3rpiZ8T4fF2K2wWBtXmP4MJPR2Y4c7DAHmhq6+3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=BEJoxMW9zVJjvcpY+hThD5JdfCpkCWbzfvg2jVSXp/1AvO2m/h+1PxgfcZ6NlWcfME3pOeDxDy1Aq9ajjLIM7pvAc0UdExz1t6lXs17EpH4Z4QLLE0TleH9s4njNEFmESrtHPKUhzYmAKXqzEZEHJT0Gjqe2HXZpwQcAh3tAgkM=
Received: from DS7P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::21) by
 SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 10:30:14 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::31) by DS7P220CA0033.outlook.office365.com
 (2603:10b6:8:223::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 10:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 10:30:14 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 05:30:14 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 05:30:11 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v5 2/4] drm/amd/pm: add IP_VERSION(11, 5,
 1) to vclk/dclk DPM sysfs whitelists
Date: Wed, 17 Jun 2026 16:00:10 +0530
Message-ID: <20260617103010.12759-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cefb28-93d1-4455-5dcc-08decc5b6b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 70yfMxT1pRm1IvmloHS9OYAA/Sri2JtKbEktImKEEjtGhWDZ68gwLGkqu/jfwBFcMKcAGT8lSe2K7CQ86al/ZeN+IWKDOWYkeMSO3DsqTf+Olqu5LVXPR7GO/VZib71cboY9bDtmRcNdoE5OGN9o4BpHkfL9can3Jpww60KK8uEVlwnDtcb+uJEHXxN6XS42Su0zCwbz/PWcUSGFgSyBCcMN0DK3OFBxfOYEthHbfHslg5HXVdhoEtlPIFi9OraxqDadDLRFGsSuZCYP0dkEZQbf/XOgSoXea0hN2K62SL9w5DcSQZCSXk9QyqoL6gvc3mDBcQc89KnrBQrXeTfErGYMPWq//QNf46gTkgbPosr47YCQ8PclhTVgfPXv6Im/8anzq3kXYGpxju7FKPsfjM72KLtqOGgIand6PbIziD+i9+doiwmG/vG7aKz2CJ6A3I2/Xp2xTPP727f4SnIwYF1aU6BbiFxHSmGykj+ZjZcoJOPXCmWWF39PZj3K3aKYt32r4vL0fZbQMuaQfjxIrXH2nqsxUnUXksrsYLVrS5dvfgdf9vn969jsjVBLj2D6k7zVCJP9GonYvPQ/SLwawyrVyvDA32/Nr+i3ztEFPDJC7c8rEdq8VhyW1syF2AI9df2E/aMCzAupx29kPm/yDl0Civi5f6tUAtMcHWdUemzBUiDFvgpCbLaY/27TtzL232/tH3G5rJ56da52i8JEZwCC9hHObEBelKFS4BYCs00=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: McN1kXTiQJ8o90CkTaK3MIWKDNpDhe9QIV6TRs6pFOIKQ3SYdVMN0rqRM/Oj39LQf3cE949V8abllZNw4ghthUq7pmiJXOIXSHUdwi0rWrC3jEpGSK9alNjER5eXjxs/5qKlIxsnNtDKmJTbpQADAqUcGl2JsCqHrh3KBxc977+C0sNOzJj/znegLjVv4BeJXI8QwH4ksNHpglhRJsmuyOtt8lpBA7/JO9S7W+8HuGKlKpDhKlSXs2vajbvgADXdVSksinp0MEDZNaU3XdHdodkv0Cx6o/YFG1jhcQp6dR5QrRmVtIbWIR9/XS6x2vxaSKuQ1nwcuAT0RYOLKo9C5LCLGR5fB9Qu/1B8Iw7PdEClp4WOvquUVJS7QvISB1y2ItnCj0PI/c10kNjQ7cYDsD7h5u4UmjS52aBPRbkKevLAsyQU1LDJ1AV/AGUGk4QS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:30:14.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cefb28-93d1-4455-5dcc-08decc5b6b22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733
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

Add IP_VERSION(11,5,1) to pp_dpm_vclk and pp_dpm_dclk visibility
whitelists so these sysfs entries are exposed on Strix Halo (GC
11.5.1). Add IP_VERSION(11,5,1) to pp_dpm_vclk1 and pp_dpm_dclk1
whitelists with the existing num_vcn_inst >= 2 guard since Strix
Halo has two VCN instances.

Without this, amd-smi reports N/A for VCLK0, VCLK1, DCLK0 and
DCLK1 clocks.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index dfebe67c164d..305852f5b153 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2027,6 +2027,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 0, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 4) ||
 		      gc_ver == IP_VERSION(11, 5, 0) ||
+		      gc_ver == IP_VERSION(11, 5, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      amdgpu_is_multi_aid(adev)))
@@ -2035,7 +2036,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
 		       gc_ver == IP_VERSION(10, 3, 0) ||
 		       gc_ver == IP_VERSION(11, 0, 2) ||
-		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(11, 0, 3) ||
+		       gc_ver == IP_VERSION(11, 5, 1)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2048,6 +2050,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 0, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 4) ||
 		      gc_ver == IP_VERSION(11, 5, 0) ||
+		      gc_ver == IP_VERSION(11, 5, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      amdgpu_is_multi_aid(adev)))
@@ -2056,7 +2059,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
 		       gc_ver == IP_VERSION(10, 3, 0) ||
 		       gc_ver == IP_VERSION(11, 0, 2) ||
-		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(11, 0, 3) ||
+		       gc_ver == IP_VERSION(11, 5, 1)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
 		if (amdgpu_is_multi_aid(adev))
-- 
2.43.0

