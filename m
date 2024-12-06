Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46812E77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 13:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C589F10E3EC;
	Fri,  6 Dec 2024 13:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hKi15cy8";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4904B10E3EC
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 13:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDFO+Trs4dxlBp4xJ0VvWYjzrqdifGbb+U+9DERqWjcyx1y2m/dmWP7lkxUgssGiHLTsfhUgoBwhCKqKsZQAIqlXPsEmo7Drs874Al7s6yQCKoS/+8FPKI6ZJmRnTi5LtS71m9Au4aVrJGw5YAYqMZVvIaYbtsGE31Q4x4CBUmisyaR2Gxv+/P++I/GSy2/g5Bek83Vn+MGDooGNosU1arJQLnOs0csIrcaRRkg/m3NvaO+a/0DL3lirDUOYS3WVE4lzXsQzkV/TYqPzy59gbbpS2LgdCDZ0Ewphh4eWmKe8gRy6lGYU16FQiyKtfJ1FHuyXCObSmiOfSZvWsNulng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw1ujKghnACtwG+eQgIkQwpCi5MqUh4buCUNDGESgF8=;
 b=Y2oIVerzCbprb//Z46imB4jergh7JObOSfauzI1IXR3DDc7pL1695GCeD65U+BqtPp/qFaxFxHxssPkjYX5rfcFHfowzzLMYnd+fkbjBZubxWtfmLORAKoyw+ajqOFZLSeJi7dQHuSeW5HbO1NXBPDhtbxj4aaIagTQ54bdImEekUpk9SBhyTuqZfq71WDVFuskgVHsKH1+TPDEG72e82MCzHnY7WvqdePz9gOK4D59FHjcZXj1/YDGS3Kw5o1UyQs8fuCZqt036AkBc5/jLvLxE1PCRyqsGwvO9fTQPtp9DoV5lRfMgJU79x6liIpT3N62RfisyCfGAuB6skWju1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw1ujKghnACtwG+eQgIkQwpCi5MqUh4buCUNDGESgF8=;
 b=hKi15cy8yLil0QEFBjY7ohMxfPj++lTo7uPHEFK9PdTnDMPwHElZrimTBURqmIfe4Ebsld8MFl0nKoMJpRyqn7jPRNag9GG+fZc2iR1ORRCqSFmXA9FIzjj44NsV73WNcIQwbl5euTN/3TlQNvOT4TbnQBJ9VLslWeegAof5beM=
Received: from BYAPR06CA0028.namprd06.prod.outlook.com (2603:10b6:a03:d4::41)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 13:00:14 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::46) by BYAPR06CA0028.outlook.office365.com
 (2603:10b6:a03:d4::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Fri,
 6 Dec 2024 13:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 13:00:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 07:00:11 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: Revert state if force level fails
Date: Fri, 6 Dec 2024 18:29:55 +0530
Message-ID: <20241206125955.3516880-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: d297b91e-c3de-45a3-9b65-08dd15f5ec95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kipnB1iE5khDSXTfhefEGNrcwESx+I2zyd6JKF/lgygq9U05b3jd02Pg6nay?=
 =?us-ascii?Q?CDbEpMqBuWEgRtAOGDRQGQf/OTZio8+8+fPvV+stDyaoSKYB7je9WmVeLabP?=
 =?us-ascii?Q?YBMAWeB/vkEiJ4lMNdgNmR+UiypWw3S33E0EOK4VXGsXb+i6CR+ucSykF63e?=
 =?us-ascii?Q?QXIDFczqc27s2dJyG2UkRsKCKlWQ14X2+jHfgr4tfXZIrUAYn2rYRs9tq0LP?=
 =?us-ascii?Q?7yy1Cxl5Ik/8nXQ2gUYFw0VKDUUxGQLFk0VbL+Jhx/LXZ7YWuyR/qGH5eJBY?=
 =?us-ascii?Q?2e6nw8z2bE157oA210Ygo4nD0rlY5f+WPMjhLWDOb3bygCHiovKJ67v0Du1X?=
 =?us-ascii?Q?MOoXcDlxPZQM4g1jkdkD2lke262aJpL0Mecwx1MniVGFWqg6mgp+5o+yU4T/?=
 =?us-ascii?Q?NA4Ofmq1KU4Aud+GoWQUyHPOlgPpGfFCEIfpt5hmSB4eV9wxTDyOgkW1AGUC?=
 =?us-ascii?Q?a+YTEpIagvDMm+jBnz1nlvmA0aBrc7U4dDKAhSAmOFyNaFOrMyxRvDC64XV+?=
 =?us-ascii?Q?SMk1ZiKEU/SVEtsRGnQhNG+cezLJpd40bCO/cDvhze7HsjpnYZwxhoP51von?=
 =?us-ascii?Q?xhSIQDp304IvXV6sCuRKqPmYlNG4U38N83Kd5bI0HClIciTpUYC7z57c7Qg5?=
 =?us-ascii?Q?mpldZMPoVxB7AazeinSm8U0HGS/Cn048r1SA1fUb+3/9S9KshtzBvTVjORce?=
 =?us-ascii?Q?jGQ7gjwPLSCCbJZtga9T9HuAsOLnAj3GbCUNngd8j7ylmu03myNP9zidYdg1?=
 =?us-ascii?Q?f7lhtenwgeIxGNdNnMeVjFV4Zdf3GjjyDDLkixRyOLShtTL2kSflhANPlVhC?=
 =?us-ascii?Q?oQe37nnmi8LlM56YBGzFJT6IZBo4KzJDsENzwfkpMtv9PXoGBZBthBkMj1Ok?=
 =?us-ascii?Q?Dtmxo4XaA0HMcA+KHW4DW/3MjFsHzirryeiv9KNUyFNiE6IRlj4gdTx2WZ8K?=
 =?us-ascii?Q?/9rEl8IV6PtivL2Gz+DMinkHEJ5aHlN9mvv2MT9NjgDfkbtFFj9C+FO1ZlxE?=
 =?us-ascii?Q?3ptsqQy4GlsjFFeXdtC4feqiLJ5zWqKhvuaMwRK0oOOnQxk407xkRTI0neE5?=
 =?us-ascii?Q?Uq/H8jQO40HSaDM5Uu8FI+vhc1CXj+agGHG7k/o8WHfyI/iOtN6crlcjMnko?=
 =?us-ascii?Q?wIvTrI32iITnzf8yf1a30WZr+36i5pjCxqp3wAUE/kgnPiy8yRn/C0tQoVJ1?=
 =?us-ascii?Q?/8EULG1sj760Oaz8NqWBF/Qu6zG+ADhLymZZTIEJ4f/VDKiKlHt8yF1Cp2qO?=
 =?us-ascii?Q?qSpiM8wD3Wf6pMtAMwhyt/lLy+w6vr6EqSD1a/GF4NDXI1SQB5eFTKeF0HmP?=
 =?us-ascii?Q?3dhynJrRQwKS+S5P5dvf2DRBL1lzPfSgx0c+JKz17WMJ1t+c2j/DTciwcJoK?=
 =?us-ascii?Q?97I4FmnWzFJ0x01h0lx8NkL3qLp4NtNpo4LSFS8EOFR6fjmMVtQwIUMLwmhB?=
 =?us-ascii?Q?74QvBPhXnySwZCZl9EChjNt1PyO+WkT6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:00:13.5470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d297b91e-c3de-45a3-9b65-08dd15f5ec95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

Before forcing level, CG/PG is disabled or enabled depending on the new
level. However if the force level operation fails, CG/PG state remains
modified. Revert the state change on failure. Also, move invalid
operation checks to the beginning before any logic that could change SOC
state.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 58 +++++++++++++++++------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 4d90e3f0bd17..6a9e26905edf 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -987,6 +987,24 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device
 	return level;
 }
 
+static void amdgpu_dpm_enter_umd_state(struct amdgpu_device *adev)
+{
+	/* enter UMD Pstate */
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					       AMD_PG_STATE_UNGATE);
+	amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					       AMD_CG_STATE_UNGATE);
+}
+
+static void amdgpu_dpm_exit_umd_state(struct amdgpu_device *adev)
+{
+	/* exit UMD Pstate */
+	amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					       AMD_CG_STATE_GATE);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					       AMD_PG_STATE_GATE);
+}
+
 int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 				       enum amd_dpm_forced_level level)
 {
@@ -1007,6 +1025,10 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 	if (current_level == level)
 		return 0;
 
+	if (!(current_level & profile_mode_mask) &&
+	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT))
+		return -EINVAL;
+
 	if (adev->asic_type == CHIP_RAVEN) {
 		if (!(adev->apu_flags & AMD_APU_IS_RAVEN2)) {
 			if (current_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
@@ -1018,35 +1040,25 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 		}
 	}
 
-	if (!(current_level & profile_mode_mask) &&
-	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT))
-		return -EINVAL;
-
-	if (!(current_level & profile_mode_mask) &&
-	      (level & profile_mode_mask)) {
-		/* enter UMD Pstate */
-		amdgpu_device_ip_set_powergating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_UNGATE);
-		amdgpu_device_ip_set_clockgating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_CG_STATE_UNGATE);
-	} else if ((current_level & profile_mode_mask) &&
-		    !(level & profile_mode_mask)) {
-		/* exit UMD Pstate */
-		amdgpu_device_ip_set_clockgating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_CG_STATE_GATE);
-		amdgpu_device_ip_set_powergating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_GATE);
-	}
+	if (!(current_level & profile_mode_mask) && (level & profile_mode_mask))
+		amdgpu_dpm_enter_umd_state(adev);
+	else if ((current_level & profile_mode_mask) &&
+		 !(level & profile_mode_mask))
+		amdgpu_dpm_exit_umd_state(adev);
 
 	mutex_lock(&adev->pm.mutex);
 
 	if (pp_funcs->force_performance_level(adev->powerplay.pp_handle,
 					      level)) {
 		mutex_unlock(&adev->pm.mutex);
+		/* If new level failed, retain the umd state as before */
+		if (!(current_level & profile_mode_mask) &&
+		    (level & profile_mode_mask))
+			amdgpu_dpm_exit_umd_state(adev);
+		else if ((current_level & profile_mode_mask) &&
+			 !(level & profile_mode_mask))
+			amdgpu_dpm_enter_umd_state(adev);
+
 		return -EINVAL;
 	}
 
-- 
2.25.1

