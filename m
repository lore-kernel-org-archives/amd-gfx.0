Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742FAC02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 09:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2662510E6A0;
	Wed, 22 Jan 2025 09:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mkSA/nPc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E7310E6A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 09:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCw1dvs7iZtB18TARP0vTzFiu9Es8VLJaQOmO6RT9c9I0Y6w3dwUuO1qQ37rlUgTpH0J3MABx292cVvpFDVNA9a7KvPLBKEZUj70I3skGa2YXa+pcd4reMbg6pcTQ1kbYjB01HOTQpcAnsOeSpSdgoO3CQO9qdGe3Rq4Fj88q1op4NDzb0vbsXqTGLSMktxh7+hwiJpx8N66sbSOT2nejHy9yNmkKxtZwTVCcG8kX2mRklTWp+UKQ2f4KTngFb1JxVrAg2p2eQ+5EjN2KbNPNKRavAIkbB9MxlJTd0plTJFexZX7qL/YQSR7Lo9wop0v95qGyNQhG+nieUOHj3HVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX54bXlF7r2FMlTJRTV56Xzzudn8wt1wwCsaRUJmnVo=;
 b=MShRXShXBDiqjt4PjU9ExNAlG3phnyepjKnMzH1MdPO3/E8FmY9Mil9JqA/xtH11+FkkU9zhIuAGAFO33rB+TdVrQri2jzhsE1C96bPGko5LZW115z9W6Qbk+J3G133r7hALZvEr6Va21nY5FBup4NGRDsEF9/hE6OUM2LACL0jTH6UAxmSy10oQ0BLyftyrjBjzOy1oJ6V/byem6rF7f5QWZA8IZm35+zExdO4FWVOIE+D46kT9hasF3ByzJcVgV9lEN0rseHkmkH4ZqARV37ocyVjn+yepmXgD7iXWJfEwtjDEV3bhcMIATn2pgoFbHrHVHtw2CFdxqLF393hceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX54bXlF7r2FMlTJRTV56Xzzudn8wt1wwCsaRUJmnVo=;
 b=mkSA/nPcNoM+ZtVPhBrEY23Vrsu7SyiCO5F9AX2voFdJMUPC4KK4HKnhDDaAmbt1j8yW/Ma3EIEK3UKEg5jc3wIS0efwhAlTjF5SP9sZ62zF+0h+bl+3eQQWrVh55CbTSxlJbMsrqjJNtz0r4mwfAsAx0MPv2fNdj9EHUYTrVN4=
Received: from DM6PR06CA0086.namprd06.prod.outlook.com (2603:10b6:5:336::19)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 09:56:26 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::4b) by DM6PR06CA0086.outlook.office365.com
 (2603:10b6:5:336::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Wed,
 22 Jan 2025 09:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 09:56:26 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Jan
 2025 03:56:23 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 6/6] drm/amd/pm: Update pm attr for gc_9_5_0
Date: Wed, 22 Jan 2025 17:55:43 +0800
Message-ID: <20250122095543.148993-6-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250122095543.148993-1-asad.kamal@amd.com>
References: <20250122095543.148993-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 58becfdd-3f00-4ad0-ef1e-08dd3acb0942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wd76BhWqsH3507ErUksZQKiYh2CSUBsFKwAKPV+JN8iCtAdW/uvvn2T8zMZ+?=
 =?us-ascii?Q?UQVLR/jters/OqPBZscINpz1cmfTolTchLjkjiBpSF0O7qK6BrOLbkRdNaun?=
 =?us-ascii?Q?gmezD3Cw1v8Iuyl95bUh+obUIg1egVc8Pv/8u/QDvLVpjVHRqD452SwzEQGY?=
 =?us-ascii?Q?vguYn6YvYoL3XQIfhzrrnHE9DC+emeC+64UWy8qHmX2t0QFGxmqz39iVjs0K?=
 =?us-ascii?Q?l2F/dewY3v2ffR+ku15RHyZSvo50O27CXb9WmWKsprM6/8dHMNdkavvHnHuU?=
 =?us-ascii?Q?/FZd4R12Wu9PN4syC8E+MigGl+onlgE/HWs8c38TPIlkzDudO+533+4TI6nk?=
 =?us-ascii?Q?2oT4DXy6pOZz6ic0Gw1M1XbSq75BSqo3Y4aa2hb4pqk/OHJ/v/b5RjvSXfTQ?=
 =?us-ascii?Q?Da7Vba6WypzXPIqp2516DAU2ZsXHStyC80CxawkZXsTK3HlhN3NkAudnfh/d?=
 =?us-ascii?Q?HQVSiwnsi37k+07iJh1MCyCw/atJqugtLClpZ11WCghabFG2wS/J5wZJP1/T?=
 =?us-ascii?Q?dWDS2ifH/VYpO9nBrHzGQP8bCCVw9E8bPRcOSkOEoYZ1xYiq7ktzGAq4Lb/I?=
 =?us-ascii?Q?bV8gmU81gHrKjLorW5yaRz1GUeafsfZlk/4LgGTj3a1j5xJ4YqOphNbbFknb?=
 =?us-ascii?Q?DJOAMy0KueGDcKS/4uX0byI32qgPWioc4phpTBQk6w2rgH9EErMGbTVAubS9?=
 =?us-ascii?Q?SA+pk+BVciL7GnDmkmngSmX3/HjihdrHAj/oltJz+AG4ZzDETE7r6TfuqWHO?=
 =?us-ascii?Q?j5B8oMURF8Qi/RoGKxLZb3HHNRWEXn1VsfgUJKXtBdcbWjOQdfIo9IhSNTMS?=
 =?us-ascii?Q?de7YHOp/EEKGJBG/rs+pRrD0G1pOfO/8Lp15jslCFlQjle46VN67WtHUUU7U?=
 =?us-ascii?Q?I9XCLAGxKA9yimXAQeS5s2BKEavvcm8V1rPx63u6qLTudDpPS17hKOOosOpn?=
 =?us-ascii?Q?ZzOoMKAxzsA2w/6vSmFHhPGms5yVp5Y4sgMsug4vBDwCV/kE/AyvJV6rueeq?=
 =?us-ascii?Q?eL8698CKrP4gqdzt/JF0v/TZYmpecD22JzTRkGl8/Ny87uLKgLUqzGze59zo?=
 =?us-ascii?Q?PmwypJR9ImTHUkmyvXhYTRUkZbhG5eboh/jCKUCAzrnpQsMXoe4Y1va20/TA?=
 =?us-ascii?Q?nHPtl/OwjFrVTdeQ00+42AjnWiG+tacSfAOwwrZi4ZbS/maiRBi5GIz7Hhgb?=
 =?us-ascii?Q?b1NMkyePHdXL6g2cnhWri5yuj9GT8ymPCDKKZ2d/7DtfSB64Y13o62+rkmpa?=
 =?us-ascii?Q?VsvfGEkeHQAms4op6TZ4r6CBauRlXSSaPogjXiSrevZVpt8R+Kw+47Qdw0Sj?=
 =?us-ascii?Q?iIxtQmUJ5iMqOYt5qU8M4SSOXioqybfygHtGO1mD/sRgztw08EEzbR0fW7+f?=
 =?us-ascii?Q?+ClFHHhc97Tckw1zuK53Ktl8AROMPAXvVmbGENUBUvwEl5/12ShOjkREP2C5?=
 =?us-ascii?Q?QwmsZEVfGhlf8lkfrzRSMrOB5XtVQytS9PvYKyDmKJ/xQsQ47tbB7Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:56:26.3538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58becfdd-3f00-4ad0-ef1e-08dd3acb0942
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
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

Update power management & clk attributes for gc_v_9_5_0

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e8ae7681bf0a..0aca0803514e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2006,9 +2006,10 @@ static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdg
 		return 0;
 	}
 
-	/* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
+	/* Enable pp_od_clk_voltage node for gc 9.4.3, 9.4.4, 9.5.0 SRIOV/BM support */
 	if (gc_ver == IP_VERSION(9, 4, 3) ||
-	    gc_ver == IP_VERSION(9, 4, 4)) {
+	    gc_ver == IP_VERSION(9, 4, 4) ||
+	    gc_ver == IP_VERSION(9, 5, 0)) {
 		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
 		return 0;
@@ -2087,7 +2088,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      gc_ver == IP_VERSION(9, 4, 3) ||
-		      gc_ver == IP_VERSION(9, 4, 4)))
+		      gc_ver == IP_VERSION(9, 4, 4) ||
+		      gc_ver == IP_VERSION(9, 5, 0)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2109,7 +2111,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      gc_ver == IP_VERSION(9, 4, 3) ||
-		      gc_ver == IP_VERSION(9, 4, 4)))
+		      gc_ver == IP_VERSION(9, 4, 4) ||
+		      gc_ver == IP_VERSION(9, 5, 0)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2120,7 +2123,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
 		if (gc_ver == IP_VERSION(9, 4, 2) ||
 		    gc_ver == IP_VERSION(9, 4, 3) ||
-		    gc_ver == IP_VERSION(9, 4, 4))
+		    gc_ver == IP_VERSION(9, 4, 4) ||
+		    gc_ver == IP_VERSION(9, 5, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
@@ -2416,6 +2420,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(9, 4, 2):
 		case IP_VERSION(9, 4, 3):
 		case IP_VERSION(9, 4, 4):
+		case IP_VERSION(9, 5, 0):
 		case IP_VERSION(10, 3, 0):
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 1):
@@ -3530,7 +3535,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 
 	/* Skip crit temp on APU */
 	if ((((adev->flags & AMD_IS_APU) && (adev->family >= AMDGPU_FAMILY_CZ)) ||
-	    (gc_ver == IP_VERSION(9, 4, 3) || gc_ver == IP_VERSION(9, 4, 4))) &&
+	    (gc_ver == IP_VERSION(9, 4, 3) || gc_ver == IP_VERSION(9, 4, 4) ||
+	     gc_ver == IP_VERSION(9, 5, 0))) &&
 	    (attr == &sensor_dev_attr_temp1_crit.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr))
 		return 0;
@@ -3605,7 +3611,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	if ((adev->family == AMDGPU_FAMILY_SI ||	/* not implemented yet */
 	     adev->family == AMDGPU_FAMILY_KV ||	/* not implemented yet */
 	     (gc_ver == IP_VERSION(9, 4, 3) ||
-	      gc_ver == IP_VERSION(9, 4, 4))) &&
+	      gc_ver == IP_VERSION(9, 4, 4) ||
+	      gc_ver == IP_VERSION(9, 5, 0))) &&
 	    (attr == &sensor_dev_attr_in0_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_in0_label.dev_attr.attr))
 		return 0;
@@ -3613,7 +3620,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	/* only APUs other than gc 9,4,3 have vddnb */
 	if ((!(adev->flags & AMD_IS_APU) ||
 	     (gc_ver == IP_VERSION(9, 4, 3) ||
-	      gc_ver == IP_VERSION(9, 4, 4))) &&
+	      gc_ver == IP_VERSION(9, 4, 4) ||
+	      gc_ver == IP_VERSION(9, 5, 0))) &&
 	    (attr == &sensor_dev_attr_in1_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_in1_label.dev_attr.attr))
 		return 0;
@@ -3636,7 +3644,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 
 	/* hotspot temperature for gc 9,4,3*/
 	if (gc_ver == IP_VERSION(9, 4, 3) ||
-	    gc_ver == IP_VERSION(9, 4, 4)) {
+	    gc_ver == IP_VERSION(9, 4, 4) ||
+	    gc_ver == IP_VERSION(9, 5, 0)) {
 		if (attr == &sensor_dev_attr_temp1_input.dev_attr.attr ||
 		    attr == &sensor_dev_attr_temp1_emergency.dev_attr.attr ||
 		    attr == &sensor_dev_attr_temp1_label.dev_attr.attr)
-- 
2.46.0

