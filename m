Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD05CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BEF110E55C;
	Tue,  4 Nov 2025 08:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ry4zVY5N";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A8610E55C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 08:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOIBCJvX9eXd520GtoIZXi9kDDTreLdW059QxcWm7xVMOFGp3X0qcet0W3w+FJ21mDvpIZbkOXQDfhYpF/BarJsQkvs6zgTQqJMdmpNUovVR0dv/5I4FlCokNulgFsywV7v9GMwX+N7H3PIakF1hscuZShjrW/kOgUkAicHhVVZ9jYjI7HLC1ljbh2uzduJuK1poW5j2uspUMLVQeOkBgvrw81jopXSedbgzqWYL3Z1EPg3rPNLxHHsqeLY/MPQTcMuvlTlq7OBErQ2udqdvm67Z+q5fOYhd4f2KMVv971PpR+wwikY/rBFGEVWht0qtn/FULCvtqCmJqRp1AjWj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwVz6wy12k4VM5JpAEy1wcVKem2AE19+1VRkXP1Lt4U=;
 b=G/CuX0zoj2RGsbQIylp+Qy/rH0KpDRyvZoRb/76IAwYGXLAK+EiV+TFr3g1anA3q7PKoxvqibZRHOuy30DORq0MPp7OuHhp2nWv+6ShgI6UenvjUgjgC2tP9s6dAxro1uwxkKSKfnimB4tkFsrOs5/qrX0Vf4J+lVag4dx29ekj+PelY3Qhl8/LVn49CjKQScJciau90VGLws3hxxLF2otMnhNjaYgxAXbvIqo7KAy8b/lE2PdbjCW7GZ5PC40DXRNbdqyQkaZOIvAo9snVDijSNk2hL2F9zX9V+KD7/qkUOpQNQv6fuvoN9UTq39NaAFor4xFtup8HlNmGxWZNLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwVz6wy12k4VM5JpAEy1wcVKem2AE19+1VRkXP1Lt4U=;
 b=ry4zVY5NkgNL+0Dbw+lKB4XxnNKvt6VDLLJrLsx/eVxKMjtCX8VbSJUxn50/YLe+Jz3ZCKYE1EFFHQZhJtZwWUULEweZL0+kRQbj9C/h34oDigAft9yar7O/XCqYxdWMy+FITzFsNoshpqaGZwTBTdHfz03cuEL7q5qpSeRa8/Y=
Received: from CH2PR05CA0018.namprd05.prod.outlook.com (2603:10b6:610::31) by
 DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Tue, 4 Nov 2025 08:47:16 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::f4) by CH2PR05CA0018.outlook.office365.com
 (2603:10b6:610::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 08:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:47:16 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 00:47:08 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: support to load RAS bad pages from PMFW
Date: Tue, 4 Nov 2025 16:46:52 +0800
Message-ID: <20251104084657.1412130-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104084657.1412130-1-tao.zhou1@amd.com>
References: <20251104084657.1412130-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 2200d2a3-b3f7-4685-fcd3-08de1b7ec205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NXPxTTwDjPpwf+ajfZOl/cVHk36Umk+QGlaj8OpWtDV05hEZRgoeMBRN6MkK?=
 =?us-ascii?Q?MC0h98fOe7zJaxT+Jtgz4KLA9ob1Qmb7e792wYLMFY9uZWn9Im3MrHNXvkxH?=
 =?us-ascii?Q?LZcjA+W8KFWlSpbqhR1OqReLqfeGMxQWfDzrxpMGkGMgtiMW0YUBfx4Rsft2?=
 =?us-ascii?Q?zN5KnzqJTojSDZQMTillIK4jJIRvRkI/GxWjX2Ki1L4KpTsqitMc7oRGIMwK?=
 =?us-ascii?Q?ZWjK/XNyM1OPHzV8e/zFbElw3SFmOKQwHVvujYVp77i6NVVoWagqp1/Q7t0/?=
 =?us-ascii?Q?7P8TZ6g1uN240ZEVPliB88/+HP6OlRFRAnniRGcFiiVwjae638dFTWdu11Pa?=
 =?us-ascii?Q?hP4Fz4FpfMPFntCiDA14W/o3nax3TpA7Eh0Z/93PVt9VhxxFdUBB7y9vwzi/?=
 =?us-ascii?Q?hEMbG5FwwtNUGsnBjAFVNLvpnX5h8v/9DY9+BoD8SiVjAiha6mqyj+LZXyuB?=
 =?us-ascii?Q?cRNh14S/pgsK45PT7/3cSvn9wA4WX2rH9lJ6Fn9kR7IK7frNkRWm9cuk3NbT?=
 =?us-ascii?Q?tghK103h0mdH1G6ncVAJOzpHP++xvXV1crTZvThLCZGHc10pzooFgNzM5saI?=
 =?us-ascii?Q?YUyhwReeWmbQqMMR9oIDZ0ovfRtGYgvkf4xEMR0cYv4mczdMEWbG1EVJurUM?=
 =?us-ascii?Q?BBI6COCYosXE8rhdqpYDSTXntZz5PhDCSfC5xK/VSyv2oNKTLdNQFidhSwok?=
 =?us-ascii?Q?2bQYU/lkL5eIIq2Aim3KA+fKaTx/jxI3QP5HkRGDpBY6VogiWsqAbwYhdNOI?=
 =?us-ascii?Q?BIRNdbWMpqAiFepYOKDlfiyjx3gfftgwLqJmx1we9s5p5xpkB5NbnPyuqEUw?=
 =?us-ascii?Q?r4Au4VG2ROSC6BN2Exfz3sjWw4BWoFL4u7MTF/GLPOn94AJTsjITA0QeFbMj?=
 =?us-ascii?Q?5G41hIQVqmPEYRv4WrDlS3t0+nkGcX4cOKysC57CyjmNjxg/cZQtKAlUoyDY?=
 =?us-ascii?Q?73n7uA7r18qEK2c9eTQdtdwkahzAgLwqFRB68osaMBLf9HLEW2K9pA5r8ZDz?=
 =?us-ascii?Q?1pYcNjJxJxLkBNkox/+DJLtbuXFpX4i+mXf2rCrWCK6foComTMsvELRjaUqi?=
 =?us-ascii?Q?b98KHLaU9Y5DCvRMrSsqjLJwJEkBBuOKaS3xQRRkbAOFyZ8gTBtDIqUP/WGp?=
 =?us-ascii?Q?cimQ4gwteoHOykub5R4AYwEKfGbQTMmH1rplt2lsIGvqBdKo1tfAe62Icrf9?=
 =?us-ascii?Q?xBuK9AeLYCkz6rGFMctEOCpKtSjUDoZNYyZELGs4JYkOEwb9JQZe3Jnr69J7?=
 =?us-ascii?Q?gMwncNQeNdHjPH4DIblMH63aNB/8/mQXmoVMj3WQnf5hp4h3OIrmLCxH9Jwc?=
 =?us-ascii?Q?F27OPCduxlh1Gz7/KX5k+DVF2FOUzQwgDh9UWMuP3/R1y9Ap7GIf6S55QY9Q?=
 =?us-ascii?Q?j2gLIq0eT38Ev1vqOvtPUeo88ziStg/Bs0eLIUIg1sBqcedzTBaoCbTgqM/4?=
 =?us-ascii?Q?tPMgGpYNKwb0laOiCCxhqjVpAsrMGwXeGNmIk5XBjYhDQhsmKisoYCpp3BEB?=
 =?us-ascii?Q?6f/ZGUalJHSqjXporPE3bbNEjCM+vcF8NjYGiGw8o3jUEvH4UwYHTwMZyDiN?=
 =?us-ascii?Q?isxp6BCWN7Gprd75cgU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:47:16.7670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2200d2a3-b3f7-4685-fcd3-08de1b7ec205
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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

PMFW manages eeprom bad page records, update bad page loading
accrodingly.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7c929f93842c..3d2d1468c531 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3168,8 +3168,12 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 	int i = 0;
 	enum amdgpu_memory_partition save_nps;
 
-	save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
-	bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
+	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+		save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
+		bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
+	} else {
+		save_nps = nps;
+	}
 
 	if (save_nps == nps) {
 		if (amdgpu_umc_pages_in_a_row(adev, err_data,
@@ -3235,7 +3239,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 	if (from_rom) {
 		/* there is no pa recs in V3, so skip pa recs processing */
-		if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
+		if ((control->tbl_hdr.version < RAS_TABLE_VER_V3) &&
+		    !amdgpu_ras_smu_eeprom_supported(adev)) {
 			for (i = 0; i < pages; i++) {
 				if (control->ras_num_recs - i >= adev->umc.retire_unit) {
 					if ((bps[i].address == bps[i + 1].address) &&
@@ -3366,7 +3371,8 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 			/*In V3, there is no pa recs, and some cases(when address==0) may be parsed
 			as pa recs, so add verion check to avoid it.
 			*/
-			if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
+			if ((control->tbl_hdr.version < RAS_TABLE_VER_V3) &&
+			    !amdgpu_ras_smu_eeprom_supported(adev)) {
 				for (i = 0; i < control->ras_num_recs; i++) {
 					if ((control->ras_num_recs - i) >= adev->umc.retire_unit) {
 						if ((bps[i].address == bps[i + 1].address) &&
-- 
2.34.1

