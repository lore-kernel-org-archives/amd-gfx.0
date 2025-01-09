Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FFBE77188
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 03:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B7E10E98B;
	Thu,  9 Jan 2025 03:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ebthsiG0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18DD10E98B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 03:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBY/WTMl4ERnu0zHQQZ/E1KgI0CCaap0jKuI2mJb4KrAOlGL24L9cfEfnxQKmSHUl3Gb61WV3O35iy9f/DypocJi+3ojUi4mhhFCDqHDCbLLue1v2ieRPaIrSiGJuSZ7iENJIiNUN+0Q9ocOP4OmCkxJFA9NpwlkZNrX/0EPtRBJrSBm3X4tBS86cYW9PsCQZhzjUGvPif9mB5Bv3Y+GVgIKic08SvrKyRHiSLb2z8rwCEsyZrAGMusMrtwLZx9aqse+J7cZhHJqG6J+hWiUrsGvHUtqhEQHIo7Dhrmm8i+Joc02xKW7vv6TG960BEYZWB5VfnF9u8CTi+sTOSuQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZjqOZvNT6PvUB453weBjmEP6aEc6zIS61MFpqVRGqI=;
 b=hutkoV0X5Eeso66elzL86LJFoJIe7ULFovtwNfAhKLSpzioWgGESQAwpCKoAeQlL0fnlSTREic68PgHWXReVd46VzCrX7Z379PYsiGD3Qe7AidxWmMwjgvUNrICSWEx5P0/I8M4F/6hsC67Ng/dAOUrh/c+dMkV3qJ03HU9oTHERqe6LldLl4Svplu/w4h6rXF/Gw3AUXm7lh6GUWU2Y1cMS8v/8A42B2+ZxstbR9fS2RfHNtqUkuTBVV5969zputBvHbHUNq5YKpmlTz09Joq/huF3Ler++mBvTfqXuNQ8nfdbgkatfXruNShq1LcVv1v9/60j0lHJa5C7DSTeLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZjqOZvNT6PvUB453weBjmEP6aEc6zIS61MFpqVRGqI=;
 b=ebthsiG0HMreqPfGsP7VCpuRxBjY/0OiBdkzMBeSHAcDkz2iBxhwr6/K09xOSCFYxjr8mGMDms7QEPOfRV/nLCw+yRAvoB1bpCfM/bEQDHALLYwan12qWNboKlxPynkTyKXnLn7xddkreloWVARogdhcAjogCxqVIcbIbiqkG9c=
Received: from SA9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::23)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 03:07:48 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::db) by SA9P221CA0018.outlook.office365.com
 (2603:10b6:806:25::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 03:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 03:07:48 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 21:06:14 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <Xiaojian.Du@amd.com>, Tim Huang <tim.huang@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: add support for SMU IP version 14.0.5
Date: Thu, 9 Jan 2025 11:01:32 +0800
Message-ID: <20250109030133.3887086-6-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109030133.3887086-1-tim.huang@amd.com>
References: <20250109030133.3887086-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7e619b-1a7d-4898-9c0c-08dd305acbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Sai0ZBv7am0763q0fnImukARZDGQizAsbGrZ2wjq8rQkzko8+HIiwqqDbGP?=
 =?us-ascii?Q?jIHgpINcg9sAUuqhzk9RTV6mqxqw+z/I0cKOwy6KByoFVQYCiBvEFsN4mbEF?=
 =?us-ascii?Q?lPupF7PR1t6yU/YPYNNM/Mt77OdW0FKSX7OWxLvJ9c6zGH7Lx4l60xEdIxx4?=
 =?us-ascii?Q?G+OkUK0FfSTOiR5SLbNg4nyN5zvg/bfDQKPm5vD0GYBbyzwnIrwK/SfyKyzQ?=
 =?us-ascii?Q?2xlKgvoAt3CM5FCuGOeginithlSLQsBK76kg1cdC1Dl9Nm75r7218Q2lwRmV?=
 =?us-ascii?Q?uN6qrDAcpNlptgTW/1bBTw26BrQClN1xQET5WAWv0Xa6uthrQppCMNdZvQ9l?=
 =?us-ascii?Q?WRHlHpK4dIv+SciLx5QWIImWRrV7UPI/CUF3zNud1sxdED/2Ts2pTkGlNPeH?=
 =?us-ascii?Q?6tNyJcGOjMoWdW/TR002c0Dwd04jif/wTpUqxNp+EmPRCisEBXg9811kGR4p?=
 =?us-ascii?Q?/0GcXOezKJax/7G9Xn6U8NG5bigBcylVS1hlnZLnQEwIShxzOGRO+7a2t6Fy?=
 =?us-ascii?Q?BHEK8HZTRZrQnQhuO7Sc6I7Bhtq1o1gQQ9GV9rNidxOOVsj0vFrweihIKnNK?=
 =?us-ascii?Q?nEjRpbIfXzL0HSaaf7/Vh6I+qdEIbt7vPtL/iwoRizQWZMC4jSsI1ZvdiEcq?=
 =?us-ascii?Q?qHBum4gDEvf8vLzBKfpKhKuvsRorQ7qFxrmsLQpbg+2fel3Rbj7vhMtstx1R?=
 =?us-ascii?Q?eVanxYi16hg9wS0f+vTKKKsLxhbvE3QnA7dZTaplQmedLDF0/jH3krHWCe20?=
 =?us-ascii?Q?16talh3f5HAYT0GaubwYhJhTWkUDXa4b/ZbS9m+koVpy2QNMgFEJP4pgzdiy?=
 =?us-ascii?Q?yfnNV2mwkWSKYDNKrCmANZW+iKtxUIHHMvoQXAecHKiZdoPC/EE54EZFXDmE?=
 =?us-ascii?Q?uKd6Hqm0ohVT+LsMHYLgu1GxtCTHAdkIKfVGfcZYV8/Xk/C+CSxRSZ3JkADq?=
 =?us-ascii?Q?nQWCHdhhx3ibsRrRhY/YX5OAiIJH9M5Zg2JPoPailVsiGfauTqA5xEShYpvn?=
 =?us-ascii?Q?tgpK8top/FU+yASPKu6G1mgxV4hw2m1Af5E7TA3tvsYooGxoQ8BxUofrzIgw?=
 =?us-ascii?Q?1SVdKK7nlrEHC3NkhmFRL8p611SmTo+e9uhfMkA/QC6KB3cdAc8Fra2kCTid?=
 =?us-ascii?Q?S0KG3aTwcC//DUH7HFnW/ZfkugIbMlxBpzoiUiF+KZ4V+zbBF6nL2hVTnQqs?=
 =?us-ascii?Q?LqmvzFfqSPVyhl7JYtt96TpJUxC2ObAyR/24KY7nAo9oEudc/n63khYgJzjr?=
 =?us-ascii?Q?G7Fr4+mnnj6B+6AMRebGSVOlsRLHgSLTJjGw7OgqFZtFZhJ+nmACr8Hc3P9o?=
 =?us-ascii?Q?duh/t/RTxOCsSVCbP9ic1olRgHYTczYCaWFOhsMcKRZivorsWS/BL0IP4+lA?=
 =?us-ascii?Q?+1WuLk9PM1bfi8BOQpPrV3Ere58ZSpWjuTAP9lO07wkUkpo0JTUtbuwEaFX8?=
 =?us-ascii?Q?Bb1AtlbDV/tB+nqr9vMnwnaJCQPKwl/7cpPJBzikxKZ/Asj6E5nozeFcMbhj?=
 =?us-ascii?Q?hshu8OTcLApD5LA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 03:07:48.2037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7e619b-1a7d-4898-9c0c-08dd305acbea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956
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

This initializes SMU IP version 14.0.5.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c             | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 49d3d017c657..60c340274543 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2088,6 +2088,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 3):
 	case IP_VERSION(14, 0, 4):
+	case IP_VERSION(14, 0, 5):
 		amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 2e86c730d192..a302f1ae6282 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -390,6 +390,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 4):
+	case IP_VERSION(14, 0, 5):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8ca793c222ff..d1f05493ce40 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -738,6 +738,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 4):
+	case IP_VERSION(14, 0, 5):
 		smu_v14_0_0_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(14, 0, 2):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 9b2f4fe1578b..adbb6332376e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -245,6 +245,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 4):
+	case IP_VERSION(14, 0, 5):
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
 		break;
 	case IP_VERSION(14, 0, 1):
@@ -769,6 +770,7 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 3):
 	case IP_VERSION(14, 0, 4):
+	case IP_VERSION(14, 0, 5):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.43.0

