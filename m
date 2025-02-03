Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E62C02192
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB0410E57E;
	Mon,  3 Feb 2025 21:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1BVH+Min";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8E010E57D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhdcPNMmfeSSa/IPzbJKHVNjWT7j/YEG1e9nTIxKd0NCnxcXP2gv5tl9ui4caecS/uOKeuUZrfZiVu0s9xoxzFVjVZ5R/yRPw3TP53yamar1XJLYHQGEEwoYcP0mZhtHNbLPEA5z5CdIz1e/1h7+3A7nw7Gcqf8wdhl7OtnYQPQxihfTUNUzkmG+UWAczEfvtMd3TIsAyxoY1Gw6tNi0dDG2BzOtG5F6zoiy0JzQIfrgMqqbvPk69tFjgJtVHw01WtVMZ7EM7m7Yx+ApjBrcd2iZhs1ZCvv0TVmo1d7u8Bmz6Xl2ZYvLXEX5zilZzKBogIXxqqbNWZoQ9Ff5rDvmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWQf2JAqNTTisVm8Pt3e57R+UQoOHjG1FOBea9qLJm8=;
 b=ehUCOyajmG9uILp6626lJt5eRWsKrv5pSVrlkk+4qiBdXeFRNV9CP4Hdg2YrHstmeX9IPe0N6qCxU6d1IXtGcNjrjCzry491A7Gnjqfgcm6U2uHiBAYq3l0BykXOuqpB9zMYQepfWQrU+xEzKNwxYKiNiSlP1OcD/wtgC8+N+QFOSqo80tCfYPOP8azB8Kjb/rfQfezGOXcw2EWS5QYdCoKl0o5PdCkcjApuczHiL8+NgbzIHu0jwBsI+Q+MdvG8gWxW7pIdFp17ywbBe6UCC3ioDz3LZNT2X+xj1wPqk3f7LIaHTlyVO+lQERD5MY6vbKieuNllF72FoPiMJ5Wd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWQf2JAqNTTisVm8Pt3e57R+UQoOHjG1FOBea9qLJm8=;
 b=1BVH+MinCx2nb1mNVCl9kiZaRPX/jRQKRjOueWS2EcX9BfoAifWsuqCbqsRFbsxyramuE46hpkuup9ebc07vQJqnGLvV+bpkW/OslVuaGufH5Btq1Dfa7kduaUdlSQUVqqJZ15swvVXEDcT6zpJV8YoRgHdhILh6jACVa78cueI=
Received: from MN2PR06CA0023.namprd06.prod.outlook.com (2603:10b6:208:23d::28)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 21:44:08 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::cb) by MN2PR06CA0023.outlook.office365.com
 (2603:10b6:208:23d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 21:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:44:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 15:44:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>
Subject: [PATCH 04/11] drm/amdgpu/gfx9: use amdgpu_gfx_off_ctrl_immediate()
 for PG
Date: Mon, 3 Feb 2025 16:43:41 -0500
Message-ID: <20250203214349.1400867-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203214349.1400867-1-alexander.deucher@amd.com>
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec13034-205c-4ea8-7e0d-08dd449be308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFV6Y0ExYmFJWW91T1AzZ21MZ3lHaHRFL1hLS0RiWFEyWC9jSmowckpMVEhX?=
 =?utf-8?B?NjV3QkIzMUdvZ3JuV0hqRkxIeGJWR0s2QXNTMlBsR0dCKy9WSTM0eFNVZGxy?=
 =?utf-8?B?eWpqL3g5OVA0Z0pFTkJXSkQ4dldZdXltdEtPTk0rOWhNdkVjdysrQ0Q3NnB1?=
 =?utf-8?B?cngyc1paVzliV2UrV0dEZXBneWQ5bjBoL2EyaXlBLzJpYnV6NGh5ZTJ0bW83?=
 =?utf-8?B?YS9yUzVxWmg4T2Y0MklTMGdHUHdmZVFkcmp0eEcyK010ckVSQndYTUN5L0Zp?=
 =?utf-8?B?bHlpTjB1M05ST3I4Nko3eTFTbjh5TEF1WERiMzFRSW12enNBSHpCMHJhOVZO?=
 =?utf-8?B?bWF2UGkxMkhQSHJCZnVSYVFzMHMwcU4zWkNZalJWb1BRTzA0dzNrOWdUM0Vk?=
 =?utf-8?B?bk4xaFZZa0RZM2lRUjhlSmllSVJNOUpEMHZ4bW04cFA0enRaZGp1dnoyNUVk?=
 =?utf-8?B?R1VIQmFHSDZOVFdPcUtBdDNrQytZalhHS3FjYmRwcUVDNVcyVDIvUHljb0RF?=
 =?utf-8?B?U2NYQXVHNW5zZXlMcVZqbWlwWDRWcGdxZXFIRDBFMzBRN1I0c2o3SVZqZCtz?=
 =?utf-8?B?M0l2VHVtcFhmMG02NitHdEZBL0E4MStzb0pmSlMxZXN0anR1SzRsRGZUTUtr?=
 =?utf-8?B?dWkwVmtRSWd6Y1B2QWdFblozdzhqZUJzSUVQd0YyS2RoL1VlaStxNExXRjlO?=
 =?utf-8?B?VGhqejg2SU5LZlhaWlZtZWNYNnhKUHF0RzJmQTgyZzh0ZHpqdVJRbFZZUUc2?=
 =?utf-8?B?RkVYUWd4QVBSeFRaQkpxcG95RDNLREFDSVk5K1V4dWxFZlVDRFRPdVVGb1ow?=
 =?utf-8?B?djRSR1hwdmRITmhESXVRWmJhUHhVQnc0dG9uR000ZWo1QXhhM2g5bHlCMURz?=
 =?utf-8?B?aDV0aGpGc2ROdjZpeFBNSW1QK1lQd3krN01ZMVBnWGkzU293cm5yc2ZkTno0?=
 =?utf-8?B?elNDSG9uaEpMWnMzRU4wRFN4eFdoQTRBcml6MXhSOHR2RlJuSVppNlZpMGJH?=
 =?utf-8?B?UlJscERwZ21XdTB5Skt5TnRQTGdzMWhIRjM5UUE1aW93MDBFZFpXYU5GNTFv?=
 =?utf-8?B?UjNkbUMzUkNxM2tYVmZyeUo5TTArc2FXZWNmRFZ2cEw5TGVpZVVsS284ZDJw?=
 =?utf-8?B?WHVkaFpZN0NKa0hwbGZZNXFzUDd4U2Z0RmdWNjIzQWhseGFIY2xrYnpPeUhC?=
 =?utf-8?B?MW1zSWtsUjdYeTloamwyOXdJdnNLbVBaWnZUdkgwcUIyeEVJZDdkRm5SVVhJ?=
 =?utf-8?B?Zm5SUG5wYU03TWNkYzRpTFp5YnZrelNtTnR1dXB3bCtveEFtWkF0ZGRuc2c4?=
 =?utf-8?B?OTFiNCtsWVUzS0J0VUJRQ250U1RLdSs5L3VnYnp6KytqU0NOMGc5b29Vd241?=
 =?utf-8?B?MXVaQVpwNnBGc2RqVCtZUGdPZktMc2o2K0RYbExBbHpiOTlCZ2h4MnNmZUZh?=
 =?utf-8?B?cE9wLzI0WHpLU0dIRzF6ZmRtVUhlczV1NXh0eGoxNHNwTjJMZStMRzlZdHUr?=
 =?utf-8?B?cGhueXFiYkdGSGJ0SnBaajBZZjQySW50S2hqWGNQT0txSzhSTHhuU2IzeWhG?=
 =?utf-8?B?Y2tSalM5dUhYWU1PVzJBVCs3VmpmVnd2S1NiMWlwMUN2QVJLd0kybGNFWXlQ?=
 =?utf-8?B?dnp0NGpCU25VdUxLeE1pUnlkcVhyQ0g5Ky9lYjBPc05BY1JCaFIwNGpIS0x4?=
 =?utf-8?B?U0k1eGlQYnhwei9zeFA4M1dlRjRyQkMvMVJwa1BqaHladjIyTXJaNEdTMGM1?=
 =?utf-8?B?emd0V09FelJERW0xblVBcXhCWEwzY29OWk9RK0tRNEdjY3ZsT2t0TC8wbUhl?=
 =?utf-8?B?UmRTRTgyWFRmdThxc2VJVExTSUloRGtFT01wQnNXTzd1RGkvVWtHaTkwN2VG?=
 =?utf-8?B?QWd2VkNDVlNnMTNqVTZSTWlFSGF0aW5taEFsOEdHWUdXUkgwN01jNDMvWTdi?=
 =?utf-8?Q?T4waZfpWqbU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:44:07.5457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec13034-205c-4ea8-7e0d-08dd449be308
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
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

Use amdgpu_gfx_off_ctrl_immediate() when powergating.
There's no need for the delay in gfx off allow.  The
powergating is dynamically disabled/enabled as for
RV/PCO on compute queues and allowing gfx off again as
soon the job is submitted improves power savings.

Suggested-by: Błażej Szczygieł <mumei6102@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3861
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a666832ecefea..dbb9df7913316 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5241,7 +5241,7 @@ static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(9, 1, 0):
 	case IP_VERSION(9, 3, 0):
 		if (!enable)
-			amdgpu_gfx_off_ctrl(adev, false);
+			amdgpu_gfx_off_ctrl_immediate(adev, false);
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_RLC_SMU_HS) {
 			gfx_v9_0_enable_sck_slow_down_on_power_up(adev, true);
@@ -5263,10 +5263,10 @@ static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		gfx_v9_0_update_gfx_mg_power_gating(adev, enable);
 
 		if (enable)
-			amdgpu_gfx_off_ctrl(adev, true);
+			amdgpu_gfx_off_ctrl_immediate(adev, true);
 		break;
 	case IP_VERSION(9, 2, 1):
-		amdgpu_gfx_off_ctrl(adev, enable);
+		amdgpu_gfx_off_ctrl_immediate(adev, enable);
 		break;
 	default:
 		break;
-- 
2.48.1

