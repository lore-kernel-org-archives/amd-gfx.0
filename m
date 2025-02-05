Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09523C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB83310E154;
	Wed,  5 Feb 2025 03:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gy3Bijgl";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B312510E72A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iT2WT3fzujPyb7EJp1QlWqbxqEPmPmA7uwOKi91m8eAPlpyUJ9xWSiKV254wvhbj3aRgb2BWyCrc45VDul1K7sJIZDeNpDCNsO1MgrvQJeZB6fEb5tiW/f3bo4IAGD9cemi9973jywMwwI+Bj3bPtowIfpDg7IXN2WAWg6FfAj+1H/f2chfalTgZ6vBbr5I4EQh7EErHFQyOW9HHb7EKEuDNfXhaxfIaMF66zY++yUGprfddL3wU35W8PqEoH0CT1OtnQuuKsEaugqOJcEeTE4UL4XEjzXNiUsTn0sJYIyPLFzPVX6XntAaXSGV0EdCHVB3ofhYi2KLqFUFaZ16PxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBWyw0zfZqSWuR8KAUO2X8rL0Og5QRq+vrqh8Xqc3+w=;
 b=uEDbt+UCtwDzmsi1O7vAtoydE271MDSJ6Oz8a7OUgIASblYrz/T0AzumWpFExvwoM7UYFVQ1nOGf74/qDUmA7+cWFBsMZhLeuWHLSWLejzRHDi7bdCcUKV+F/uTI6n39yhPsFNbN7jS2xt5p6ymVBgTFLzzPKKIOvq0pbO6xbr4FIeeqQEk65lkOzHfP0liaBM/FCME9dQX7nrn/zIRir9JW4lPsWrzQ/yhRbxhgePeAXTZFbKfG547+5K4bgmSFQhdP/+L9njfnYTDawg5SfKNv5RLlDwEYySGd+IV5ld3NyAWrabgJTkOlMw5tqUF5zMm99aLfBZCO4pZgaQv/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBWyw0zfZqSWuR8KAUO2X8rL0Og5QRq+vrqh8Xqc3+w=;
 b=gy3BijglWbyb1qr2axMEmcHPZ9IiY5sJCaBX2QDy7WP1nX+3ld6O1TQ7RYoMjS1w0ZE8Hqe2f1+jyYRBnKkg4NxqdYZCbbZ2FR+TLvea5wv++WqT7RLnsVlGY5AtD6f7cjcc3eKoA7CyeOlT7VTf4xHkDmW9ucTMqPb4MNVje2E=
Received: from MW4PR04CA0177.namprd04.prod.outlook.com (2603:10b6:303:85::32)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 03:14:07 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::c4) by MW4PR04CA0177.outlook.office365.com
 (2603:10b6:303:85::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 5 Feb 2025 03:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:14:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:12:11 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 21:11:51 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Leo
 Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 "Zaeem Mohamed" <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, 
 "Wayne Lin" <Wayne.Lin@amd.com>
Subject: [PATCH 12/12] drm/amd/display: Add DCN36 DM Support
Date: Wed, 5 Feb 2025 11:08:57 +0800
Message-ID: <20250205030857.2608094-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250205030857.2608094-1-Wayne.Lin@amd.com>
References: <20250205030857.2608094-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 589813c5-0d25-49f1-8f5e-08dd4593268d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hUIIh0fB/UkmAA+wkTvSpiQ1tTggB/4oG6PKvFpiywJqkAb8dk9stMf7+v0k?=
 =?us-ascii?Q?bNDNo8MtyCnF5cZYYfhTPBidUkgn5m5FUQB3m8GR4HnTdP4TD8zbie7mRJgv?=
 =?us-ascii?Q?41jkwF5GEeeXBLNV1A6hF8BPAneVLhoe89ctoC6EATI7VxF8qYWq8zi2xDPJ?=
 =?us-ascii?Q?ywcBVfYM4WdoHEvQ8C5x4BxSz6j25xSToma+2b/2jMKDNUM+llm8WnFYt7sY?=
 =?us-ascii?Q?h11OttPdJWV8sivwmsm317HB0OsB7T9enUbYb6IvXIA/54zmGLGc17g/0rIK?=
 =?us-ascii?Q?Ay+pwaNY0UL5n9zfGCUzxTVy+iRcexnYY0ZR9jNPM4DaNvI8KpFsKJ6nEGl0?=
 =?us-ascii?Q?mDecC07ZLXY1wbeVHzChAEYyU+WmbuJAdZi+lOFA4nqDNgVLIL5KWTqH+QWo?=
 =?us-ascii?Q?Lf69qNOrybMPBriX7I9ezgDzpBwJGr/dFWHoxtlc48zTcWz9OHYai4mRF8hk?=
 =?us-ascii?Q?cIzR5YRBOUXTwlzlmknVrtgA1zCJCl2Nn2uVBatzUN6ZmTW8ZpkNCG42Vhfm?=
 =?us-ascii?Q?4PzkxLW5k3qBli8yQdP9IeuVjWiwBjwNSdqXRzJ5nucNd9YwrI9t2BwzEgrX?=
 =?us-ascii?Q?jE2CsM5lf3160GH8Zoar64j8BBsD4b8w2HhmCy7NNAzXI6vROyOtipyva6jX?=
 =?us-ascii?Q?q7QD9XBDZRa0mThyWJCvxqpwfKscUyrRsvbQyH+DkWBSjfXBgUKidvhPL7vT?=
 =?us-ascii?Q?N0ScvkJCsYISPsjoDM4MKkFu8Ro3q/ymM7JabihTSxidNqomNj0VD9xA1FN9?=
 =?us-ascii?Q?Ed3CcXyb5BLKz23zqAe6y+bWCzjkQrP+FB9a83x0ffs4PLOvU+xBKyzzj9QG?=
 =?us-ascii?Q?RMxiuiJtTA6l07UeLvdJGUKheHEwD8KjIj1KFA1TBAtyhGOrR8oC+4jPDT98?=
 =?us-ascii?Q?g7Iu5HScHdApjj8I4Cay05sXIhl0G+aEOfQD+VGZnG0suu7uyZwsUyc4O7Dv?=
 =?us-ascii?Q?YvSlPjqoIGL9fdhLUzgzqHa0Qs2QcO0OEjLQ6ANMfoe3MSlkYSLuvA8aO+1s?=
 =?us-ascii?Q?oZetzDF9T90XazdT4H+stMhgZaFbiE4iQXkkDmq+jCYQ5qC1B/bbV3fE3MyL?=
 =?us-ascii?Q?6KFAo664pmKbNr/KpuMDMEbv8OzjJPU0IRA8QQfWbF3E93z1j/ATZUMnaVQN?=
 =?us-ascii?Q?fAKCPYWDEKTkRZs3sTkYmoFjuTXN1z6OOrKGSgcSqVIqRrNqiUg/tnLB6+aL?=
 =?us-ascii?Q?z+UpbrAvZGaXppwd3sqFfg9mcRIeRvOvP6DJmKeMiQlsi7MWNMIx2/u726CF?=
 =?us-ascii?Q?Hs4pr/VzUTGwvLQGhNfjkKqJQDlrJxg6VYr+wnu82UI5HbLQpfdk/j08wbZM?=
 =?us-ascii?Q?g9ORTzG5U9rv1ms5Z/720YC/l/8TugkGBdYMsCODbLXYyECvBVNe/fVW6jj6?=
 =?us-ascii?Q?T5dqRpixpcQgU0riUKnodIqTmSzEDJg4Y7mAItF6MaI1N20oi/yQdWexjqcl?=
 =?us-ascii?Q?A2VPakp6o29NxZAJb1AJ8wuoFXSEo9aRrBglR6DKIQzLmo9iDcJ7gMWlKtFP?=
 =?us-ascii?Q?q6HDEjeVfQ+SIaY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:14:06.3611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589813c5-0d25-49f1-8f5e-08dd4593268d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
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

Add DM handling for DCN36.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a8421c07b160..b26ae1dd1fd7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -154,6 +154,9 @@ MODULE_FIRMWARE(FIRMWARE_DCN_35_DMUB);
 #define FIRMWARE_DCN_351_DMUB "amdgpu/dcn_3_5_1_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
 
+#define FIRMWARE_DCN_36_DMUB "amdgpu/dcn_3_6_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
+
 #define FIRMWARE_DCN_401_DMUB "amdgpu/dcn_4_0_1_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
 
@@ -1266,6 +1269,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	case IP_VERSION(3, 1, 4):
 	case IP_VERSION(3, 5, 0):
 	case IP_VERSION(3, 5, 1):
+	case IP_VERSION(3, 6, 0):
 	case IP_VERSION(4, 0, 1):
 		hw_params.dpia_supported = true;
 		hw_params.disable_dpia = adev->dm.dc->debug.dpia_debug.bits.disable_dpia;
@@ -1277,6 +1281,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(3, 5, 0):
 	case IP_VERSION(3, 5, 1):
+	case IP_VERSION(3, 6, 0):
 		hw_params.ips_sequential_ono = adev->external_rev_id > 0x10;
 		break;
 	default:
@@ -1831,6 +1836,7 @@ static enum dmub_ips_disable_type dm_get_default_ips_mode(
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(3, 5, 0):
+	case IP_VERSION(3, 6, 0):
 		/*
 		 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
 		 * cause a hard hang. A fix exists for newer PMFW.
@@ -2334,6 +2340,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
 		case IP_VERSION(3, 5, 1):
+		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
 			return 0;
 		default:
@@ -2459,6 +2466,9 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	case IP_VERSION(3, 5, 1):
 		dmub_asic = DMUB_ASIC_DCN35;
 		break;
+	case IP_VERSION(3, 6, 0):
+		dmub_asic = DMUB_ASIC_DCN36;
+		break;
 	case IP_VERSION(4, 0, 1):
 		dmub_asic = DMUB_ASIC_DCN401;
 		break;
@@ -5061,6 +5071,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(2, 1, 0):
 	case IP_VERSION(3, 5, 0):
 	case IP_VERSION(3, 5, 1):
+	case IP_VERSION(3, 6, 0):
 	case IP_VERSION(4, 0, 1):
 		if (register_outbox_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
@@ -5084,6 +5095,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
 		case IP_VERSION(3, 5, 1):
+		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
 			psr_feature_enabled = true;
 			break;
@@ -5101,6 +5113,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
 		case IP_VERSION(3, 5, 1):
+		case IP_VERSION(3, 6, 0):
 			replay_feature_enabled = true;
 			break;
 
@@ -5250,6 +5263,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
 		case IP_VERSION(3, 5, 1):
+		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
 			if (dcn10_register_irq_handlers(dm->adev)) {
 				DRM_ERROR("DM: Failed to initialize IRQ\n");
@@ -5392,6 +5406,9 @@ static int dm_init_microcode(struct amdgpu_device *adev)
 	case IP_VERSION(3, 5, 1):
 		fw_name_dmub = FIRMWARE_DCN_351_DMUB;
 		break;
+	case IP_VERSION(3, 6, 0):
+		fw_name_dmub = FIRMWARE_DCN_36_DMUB;
+		break;
 	case IP_VERSION(4, 0, 1):
 		fw_name_dmub = FIRMWARE_DCN_401_DMUB;
 		break;
@@ -5520,6 +5537,7 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
 		case IP_VERSION(3, 5, 1):
+		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
 			adev->mode_info.num_crtc = 4;
 			adev->mode_info.num_hpd = 4;
-- 
2.37.3

