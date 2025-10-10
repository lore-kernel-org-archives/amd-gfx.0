Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38D5CCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 11:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1170510EBD9;
	Fri, 10 Oct 2025 11:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m6Jts18L";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3417C10E28C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 11:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUiH5JyyCcPzDJ9fRVARC8cb9G/NwVyvqBMicjMpf+egVBSm/sk8zHfnZaVs7vrI5YzOj3XU6o2OmvskDrOgJirT6+ypZGSiY0M5QHXMM8a1+17howvnZOpQEwkV75xnmynJkgNW9b0xECcVBBGk3vOg/mQq4LbplJIPaIKVNE593mdT+sXm/vzrs1AFrzvZAsNilKKtKiDOQmOBxA6XCMemBWi4PlGySOLqKYrp3p9uSM8eb1DpPgM6OvwCJHg7mG5+PbQva2gWkB48SDsm+C7H1dhRn2MOZ139OGKQVzEB/QCuyjh1RDRo/wcJ6uWCHWlClzTxyofqy3T2QpnDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBqQ0oW6C36fSvHt22Gxl/7ln0YUZ4ZAcuScOh5OIx4=;
 b=HoHMBTL5vYJ+rqS0mEQ0puVrDtteI3VxGDNOX2tWFrrhlMKviTLU9Q39V71+WtTnsH6Rrr3x48Bq9wxuehKrXtCvE1hfr++Tqt7uh6kX0/OS14Z1ds6kBLellFvLhBJl8OC8aC4sjBkAvDD87RH0w5bmLoYhRFFkpNp7t6AK1p0Up/i3RoecJ7dM7hbN4MGgc273kkePbckLrAH2TA1DLnEJMV7OPLRprYqxilHtyOFksPPG4cprBL5rgFVWFvobREnpIqUBMmi73gWt83jMaY4gljtO+sMh9xba7nfehrVf0O1SGK2pTHX43TMEbWVKXl8YqkR5L6xz6twR9v2IXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBqQ0oW6C36fSvHt22Gxl/7ln0YUZ4ZAcuScOh5OIx4=;
 b=m6Jts18LnLFrvkPiG5fT36PEgsfiDFPsT4utcYFTIcUhC7HikCky0qnbSrOQ21eQ8EPwSHeuz4cjJVIAgpxADqvTNre3zq5Pu6h/PrTsCYyqFDK3FG4GrDVs6PIBEQUcYvR2CD3sL5m7nUk5q7nw6HT73KE2jAmIt/T+omLSA84=
Received: from CH0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::17)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:49:29 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::fb) by CH0P220CA0029.outlook.office365.com
 (2603:10b6:610:ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 11:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 11:49:28 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 04:49:25 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: re-enable power1_cap* hwmon nodes for gfx 11.0.3
 vf mode
Date: Fri, 10 Oct 2025 19:49:10 +0800
Message-ID: <20251010114910.2801961-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: e461fa5e-b7bb-432d-f8fb-08de07f311b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bsX2mmTiVUp/K5EXKyGTkO+L8h7heNKivsRxzUUenddvw0uVSj95m/vyN3He?=
 =?us-ascii?Q?7lU8yBVMSVo89XtfrFUfa5yALA7P0R1GReZRnEq5aWjrdz/l/d27C9Efjbo3?=
 =?us-ascii?Q?GkoOb51PW111VHl5Lz7++1dmsU6LRbVoRbHC5SVDJxQXjUwd54wNEv6zCSbr?=
 =?us-ascii?Q?g/TX3fgS7/YT+ZbKa/eNjY3N8HP8T7fduQy4Dmn4/X3zY+ZsLMSEOMuwhDgR?=
 =?us-ascii?Q?9ZzQ5UPLMY0Js8sB1t0dC3MOcVspDqBtqdUDBJtrly84G63h/zrUl5AXRm60?=
 =?us-ascii?Q?+B2JMTj9vTxF/LzUBqWPmcDFpVt8QT4f8AAqhKtpcAJMTXs5y0H1SIvz7Q/q?=
 =?us-ascii?Q?iyzIdeYpl3sfkKsaen9e0a/1OCNOlraykl9XUB8+jc4DyNxy/GtvbCqyCzAx?=
 =?us-ascii?Q?tqUvQDMBftJmYE5SKUoiMp40I7jX7fQAk4t8vOsbC8PiJ0R/dZKlTCcyfT0n?=
 =?us-ascii?Q?ImY6pycFxxYAUc0SVvlKtSZRwyaqCsSF0yeASFTT6FIbE9YwSExenhDtGlD9?=
 =?us-ascii?Q?7FRlpg1BIuanKjUr8E4kE1X1eelvRJChDccD1YAEXvQYujbmRvUP6l+9LkP2?=
 =?us-ascii?Q?CaTgjc14wkZzHM5ExH+P2CFsFpL7sTFxUxtzXNjxAKYdvImOHV5EsKoeqyrA?=
 =?us-ascii?Q?MQd/wbWSrqqFpQ5FyklyaIH2+y/vkOeamtii1atH10qSR7WZ83KU/m5lMeVF?=
 =?us-ascii?Q?icG6Bey+ISdgKksure2UMQG8wxN2PpsGFWfHi73+mJp66G/5G/0y3/NxEF+L?=
 =?us-ascii?Q?saDQTZYG7CzUgZtn7ZGVgcu5SI4OHrSfsg/Yih2/lG7SWj/Qz48O1xs0MIRS?=
 =?us-ascii?Q?LsbJMIZ80pz/MSbRo3OGZBRZjKtDRFFTju4n3ycp0b7udcHQoIYriQ96eN2N?=
 =?us-ascii?Q?TDjo6xNgMoiZbx/CxsG0frPR5KGDyJ/IvV27f0uFcdyOYa46B5azXay3PgqL?=
 =?us-ascii?Q?RY9dvZW75Po6C8UnkyL77pH4LZqYCYgIQ+hW+InAxRVpA1mJTMUEqkLRamU0?=
 =?us-ascii?Q?R4Rudru9Aw/qJRVBtc19JcikEFRJu1eRtwV2jDG+0oSYUC7AYHwpnGc1AyId?=
 =?us-ascii?Q?zbs+1q4UWqfTTUId7J855FkrGUKLMRIy8iSj63REdapuBJc2DZ/EtLmSv/JZ?=
 =?us-ascii?Q?eRDzq4WdfHXmCSaWOlOWeJSVW1abkDL7xlX/0fcDiugnUWgFQABGMUvhWAND?=
 =?us-ascii?Q?i086kz6DCE+XgYJxJ1KSSBPB6g5WRaUUcdNhK61hM5B00P4sDcZCXtt/j3aB?=
 =?us-ascii?Q?l7XPbXF1+R6t5v6pxmf2mA8deO4DoNJBilQOFiOhkT+tf762a+c+eHPEh71t?=
 =?us-ascii?Q?zyTrX4KwnE/WtoDzCsZMLKls/1RUAHBMVP6O+b1GALxJ4ob5tPT2MdpaGrlx?=
 =?us-ascii?Q?hH0MB+TegzzipqIfUpGUT50BkbrNijb++LhP65k+95LzDoZWy6y7PPlNy4CJ?=
 =?us-ascii?Q?zJ2cVRsJlFDH/gai/SOXs3EOeYy1sDb8pmWGi9uY2YhxHBMPGvLXjaptpntp?=
 =?us-ascii?Q?q/+u9il8Is1QKa9jaUPWSM1AJTjNC8h7TudRl1vaTNS57tYE2K90BVEfSGAd?=
 =?us-ascii?Q?A8TDHMgMPih4h+VmG4c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:49:28.8101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e461fa5e-b7bb-432d-f8fb-08de07f311b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
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

get power limitation information from pptable instead of sending PPSMC_MSG_GetPptLimit
to pmfw on gfx 11.0.3 vf mode.

Fixes: 21129c51c616 ("drm/amd/amdgpu: disable hwmon power1_cap* for gfx 11.0.3 on vf mode")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                  |  3 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 13 ++++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b5fbb0fd1dc0..4622dbf1cb91 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3721,8 +3721,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	    attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr) {
 		if (adev->family == AMDGPU_FAMILY_SI ||
 		    ((adev->flags & AMD_IS_APU) && gc_ver != IP_VERSION(10, 3, 1) &&
-		     (gc_ver != IP_VERSION(9, 4, 3) && gc_ver != IP_VERSION(9, 4, 4))) ||
-		    (amdgpu_sriov_vf(adev) && gc_ver == IP_VERSION(11, 0, 3)))
+		     (gc_ver != IP_VERSION(9, 4, 3) && gc_ver != IP_VERSION(9, 4, 4))))
 			return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 657dfdf76829..decb10ec0b0f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -448,9 +448,6 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
 						&smu_table->power_play_table,
 						&smu_table->power_play_table_size);
@@ -461,6 +458,9 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	/*
 	 * With SCPM enabled, the operation below will be handled
 	 * by PSP. Driver involvment is unnecessary and useless.
@@ -2464,7 +2464,10 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 
-	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
+	/* NOTE: PPSMC_MSG_GetPptLimit msg is not valid on vf mode, so get power limit from pptable */
+	if (amdgpu_sriov_vf(smu->adev))
+		power_limit = skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
+	else if (smu_v13_0_get_current_power_limit(smu, &power_limit))
 		power_limit = smu->adev->pm.ac_power ?
 			      skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
 			      skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
@@ -2474,7 +2477,7 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (powerplay_table) {
+	if (!amdgpu_sriov_vf(smu->adev) && powerplay_table) {
 		if (smu->od_enabled &&
 				smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
 			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
-- 
2.34.1

