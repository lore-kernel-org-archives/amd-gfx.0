Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DECCE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 06:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1DF510E0B9;
	Wed,  8 Jan 2025 06:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iR7KgmFN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8C710E0B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 06:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MktRySRA7Ws86qme71dUfzyv4DOtG6/04/Z8EU1P7S1/cvZAz1KaWadUs9dZlkVgyLswnOV2M7E7f5dS4WG7OnSNjmie3Z8oJbK6g4b0Jc3I/yYmksDOrYQRv0y7WhnvT1cAnEK2qQefLLzEpmh7qkCfpGU8ds+nlgVzIjCcS1j4RYtvmKSFHAF8kjZLQYdPeR6O53Ozqwo0b7HeilcZ13MI8PDWWRp4G3AtHfbG1P9ZchKWHL2I52jL5oz7n0E1BxauDmO8L5CGbYi6J9MSPS328oU3Gj3jmX2pji75I9365j0er+eALzYuyEybMxawhby2/Hynt5ePMzZOpDln6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHEhMniR5XNCgTbF9bJPEU3PjNdHz+gTMExygGKYOWw=;
 b=RiVTNq9xKyxRWshbPG+bFa7APZBybc26g/iJRDQFMZk8kZzNhhOekIfRpoYlZ5ucCtVEHp2q0FhExJR+/Gohw19LqXWxh5LAjke/gaePSbukjuVkRmr8jPC6BJzJ1kRyJ6vPRea8V0xyI5xbVRwPQlQQePD5BbawcirnmaQ4t5t/yk8bCPPmC58y3ea5j4dfUMyamWLNc7SA0oFvt4FvWMUP09Z0q8IkPsHp7uTHxDrXL6MIB/D//rFKeu0d7JicT+Q2UpME8TmNT9TWUfm5tFhnYWj1Xj90RgIWwuBAA0c9QZtoIUwjx7rZzu6fD/ECvenyy2nuK2KrxWpQTWu3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHEhMniR5XNCgTbF9bJPEU3PjNdHz+gTMExygGKYOWw=;
 b=iR7KgmFNZpKBhw58moxAiom8JB+fDsoobc9thZ/jiiS5OkmYh5mIvy5M3s+sHnn+Co89C1kcsCfKpnQbWzVR4AClSDJuKQBiz7oo7JUm3A93J2xDOPh3Ao7iXq4DJVb4ntJHmrDue8aeIS/nJvH+DJwcrXQ30dfB6rOdiBOTQdw=
Received: from BN0PR04CA0175.namprd04.prod.outlook.com (2603:10b6:408:eb::30)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 06:47:58 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::4e) by BN0PR04CA0175.outlook.office365.com
 (2603:10b6:408:eb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Wed,
 8 Jan 2025 06:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 06:47:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 00:47:57 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 8 Jan 2025 00:47:56 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>, <alexander.deucher@amd.com>,
 <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH v3] drm/amd/pm: add the interface to set and save the bootup
 workload type
Date: Wed, 8 Jan 2025 14:47:52 +0800
Message-ID: <20250108064752.131717-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb83ec5-42a3-4c9b-a41c-08dd2fb0632d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vAdxmCxp++4Sa6/I27M3djsU4MNRGq0O7zUf2giMJ5EplmLbXmWwkIe+tsCY?=
 =?us-ascii?Q?DuIG40gJqopHgFktn+EnL4rXpGZQjFR/8bU7SdjsfFA0ar/FZdWMfUNlqBMB?=
 =?us-ascii?Q?qpYG0V9gPvoSmvojLQ3+AOjnNYKprHD2/lvLrhg2kiSS/QoI1XubuvEiuxHD?=
 =?us-ascii?Q?pQo75c6t8ak4MmhIZ4N3pWVuxech2njM3UflSdxsIwl/HSlnppBB3d2SYCSw?=
 =?us-ascii?Q?7NFFNGyi2lqvc6nIyBxtIuCID1Pvr60UuQttg5V2yNe0Vcl2lJYomig7Azcw?=
 =?us-ascii?Q?PMNKkHIPfXochO1xUj3Z2QFxi2IRydWti4U3FhRVKVz1V30/oH+b3aN5+9l5?=
 =?us-ascii?Q?zrG2rqktm2aBrx31vGz1TO3zfkuCEAe/6MSJNOD851Fya3GeszAZr1hMdo4f?=
 =?us-ascii?Q?s4vFMb9kTu2GXPPZCNf3HdrTCn7soVPOVLHhpDQySWBp02YQYqGN2xket94I?=
 =?us-ascii?Q?ABonJfOFkYWJJOWY1Fkf2ijQGVnw6GdR4x4xQuhW4jN7uOHXwP8/9wOIHowM?=
 =?us-ascii?Q?eJcPO3VOo+UpddUfVOW6XWPFlFqjXcMizPijiwMTZcFp2w1KXYBwHjEWINTj?=
 =?us-ascii?Q?hw7lyfYUTGBvddwKQXgnkLnYAFgmmgoeUOuXdfb9/XMIgPXoV7LnQHODrTYI?=
 =?us-ascii?Q?vD7QGtD8oLJBNW8mhmDq3J3/aiiiYd5tQ0SGVNjThUNz79lmzKA8UDRmsdxV?=
 =?us-ascii?Q?KbW02/NJ43WPEOmTwpt8paL81tocgiUnRWvE0uUkruGVOo7koWrUP49OiZcg?=
 =?us-ascii?Q?6jyUwksonhjSG1hifZCKrYISQxE7kvoGc25EdZPMMhPMoLw5sYXHVGAG2RjL?=
 =?us-ascii?Q?dS67gw0rUG0qDMHXW9ONAZXkufJPQiC9K3lLwLbnarzf32ESAYNGEtSXBBAR?=
 =?us-ascii?Q?NUnqhbWLWlF3cheiKgRXCp8fQL0CR7b8v8U6wF7XsGXfsNiGy+9iIgfhORb7?=
 =?us-ascii?Q?CRlCgkrFvpUz/8dfn8cGM8ajrLv4pAG9AEArGnhTx86deOS+jWQJJCM3Spxa?=
 =?us-ascii?Q?f64UUb132frjapFvgT86FWLmfktnIyM4DB/fjo0PgVZf8Tb2Rlaw/VSlBkRv?=
 =?us-ascii?Q?hN5+DXZmwDPpBmrKQSxj2kKip4TtdO0+JN28oCUQ0pGAS/n6hqofDn8KYJ+9?=
 =?us-ascii?Q?qgYFzem/ULX7o1m4HIyJH1AVQZjqRpkWl0098YreR14Dwf9tIknTsa2GSwxg?=
 =?us-ascii?Q?DUZhcTBHZXzkQtiHMIulglv0YWWoZEvQvmqFaYfFFf8sKiIoT2MMfQe8033N?=
 =?us-ascii?Q?fHqF/dBifw5odWYMGPxnZHf6TJvrYOP7f+AyVFcpsoEvh1E+6rScXoAoHb16?=
 =?us-ascii?Q?kyWHpWWbbqYCs9PC8pGSrv1TuFcBurCuXGJjvLjHaGJdd//YgQIYuwKgfrsY?=
 =?us-ascii?Q?BP46U8rN5E5ilLKOVFr3vjI2W17MwZkeDIPYWQCRhXrWbPGhGzSTj3fiJM5u?=
 =?us-ascii?Q?oP2BD2JpFxL4KOnWGMIx8jNANf+zU7Ljpp1ga8XaG0MK756hiTY9Y5jxfJWo?=
 =?us-ascii?Q?pk7gmjypZQSPv64=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 06:47:58.0382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb83ec5-42a3-4c9b-a41c-08dd2fb0632d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
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

add the interface to set and save the bootup workload type
v2: add is_support_sw_smu check and pm mutex lock.
v3: return before the scoreboard is set.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 44 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 4 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6a9e26905edf..e262c972d0f7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -349,6 +349,50 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *adev,
+						bool en)
+{
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	struct smu_context *smu = (struct smu_context*)(adev->powerplay.pp_handle);
+	int ret = 0;
+	int current_profile_mode;
+	int saved_profile_mode;
+
+	mutex_lock(&adev->pm.mutex);
+	current_profile_mode = smu->power_profile_mode;
+	saved_profile_mode = smu->saved_power_profile_mode;
+	mutex_unlock(&adev->pm.mutex);
+
+	if (en && current_profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT)
+		return 0;
+
+	if (!en && current_profile_mode != PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT)
+		return 0;
+
+	if (en) {
+		ret = amdgpu_dpm_switch_power_profile(adev, current_profile_mode, !en);
+		if (ret)
+			goto out;
+		mutex_lock(&adev->pm.mutex);
+		smu->saved_power_profile_mode = current_profile_mode;
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+		mutex_unlock(&adev->pm.mutex);
+	} else {
+		ret = amdgpu_dpm_switch_power_profile(adev, saved_profile_mode, !en);
+		if (ret)
+			goto out;
+		mutex_lock(&adev->pm.mutex);
+		smu->power_profile_mode = saved_profile_mode;
+		smu->saved_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+out:
+	return ret;
+}
+
 int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 			       uint32_t pstate)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 1f5ac7e0230d..5fe404bbb033 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -410,6 +410,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
 				    bool en);
 
+int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *adev,
+				    bool en);
+
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
 
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8ca793c222ff..a6f748361198 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1272,6 +1272,7 @@ static void smu_init_power_profile(struct smu_context *smu)
 				PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	}
 	smu_power_profile_mode_get(smu, smu->power_profile_mode);
+	smu->saved_power_profile_mode = smu->power_profile_mode;
 }
 
 static int smu_sw_init(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3630593bce61..c58fc31fb1d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -560,6 +560,7 @@ struct smu_context {
 	uint32_t workload_mask;
 	/* default/user workload preference */
 	uint32_t power_profile_mode;
+	uint32_t saved_power_profile_mode;
 	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
 	/* backend specific custom workload settings */
 	long *custom_profile_params;
-- 
2.34.1

