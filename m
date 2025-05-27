Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E646C54ED1
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 16:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA06B89823;
	Tue, 27 May 2025 16:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VGqGzqOZ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064EA10E18F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 16:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z17cIBgdoivXZLrxJFU5qe80SdHV3DN8q0X+RJFT/UuEErnHtMMnDsfY9C2zskfCzPnB/6n6ahy6fWS9kKnfru40FBKEcsR5naAQNT4K2VYm1RjymcUhKGg3CKndLNmvT/0YDz3F7Ti80SG9AZSqQ7fp0mjcfOlrQue4gERONEVQevPGFUs1eIzR4aoDRIAZl2Qo8k4XApzod4qs8PJVZrfT3pWsEqFmtDAFTFZ/ziA6qfx5aQmLG1CWyhDeM311uflAeewuTSZiZOH9UkhYm7RJz7JsYcIldbIajTloqFxHdiWUdx/mm0gNyw2VZNz3BbUO/S1BLlMKNsvxpobdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HeQ7U+0XrlFgEiE4SodhBP/0XL0bJC4fXFmsiFazQk=;
 b=aXIZR+e9nYDn9NZymuXl0uL4xZpVKd4K1S4BoIk/GX9u37bEwTobREzTg2T0oEQHTxB4AqBsEKOFqGqQuA3Peq6d9Y4h/MC32BL3uub4Zj5U26cWSAw4vnlOOnAq2mQpjtBCnDzKnYjVvUPUEOY41/mt+UkEr+ZXPhuwigNio7mPvSsdIdmjIYlCffVeQt0BCi/zoRu1ivkuQDEr9cBm8IMkXU1UeQnm7RJo7L6wtk59w5dEE1jE4icI/73gRJLpT+L0blNFLUso6a1anyymdk5fQfZPYFlekgp5rU0GgakRZR2DSlpmVud7+uwWq88Dx88sgC/xpfpsvZ6dEwYeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HeQ7U+0XrlFgEiE4SodhBP/0XL0bJC4fXFmsiFazQk=;
 b=VGqGzqOZ1Oyqe/Do5zi8fl9idtZIcPWRFZ1bzeo0Lt9iT3F1pYyS0BHm3NxNfngcEbWjHM/Vb0vIHdMFPC/S/YTKG/GTDyNv1Y1yvPVQb3jmdhRyIHM/1gVD9CeZTg2T+DQi/l/eJs6rmf98q2J3E2qgUhldfz3reyzk8YR/NIw=
Received: from SA0PR11CA0080.namprd11.prod.outlook.com (2603:10b6:806:d2::25)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 16:00:06 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::1a) by SA0PR11CA0080.outlook.office365.com
 (2603:10b6:806:d2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Tue,
 27 May 2025 16:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 16:00:05 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 May 2025 11:00:01 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Export DMCUB version to sysfs
Date: Tue, 27 May 2025 10:59:42 -0500
Message-ID: <20250527155942.476354-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 4757702e-1c21-4ac5-bc09-08dd9d378c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y6mBm5sivmfXoLlNPdk0Q4KtQhkW3XfEfAbwpkre7CsFoHSxAdwlcglVDqYr?=
 =?us-ascii?Q?t08Hqz6IL1p+MdhuAg1Do/AcNGEzqlFsfBFGvdFfyoHxNfuD7m3mHMeEtD5D?=
 =?us-ascii?Q?TIWpvIEvY5Lc0QabzH6R7ybkr32dkC5k4HQkNSzjSvf4pNVTjp1WBbAHzDit?=
 =?us-ascii?Q?GpCgN4u+dtwZGco6qx7fNJZ6vqrx0LQdFGtFF0wtQ5LVFR7dObF2GaWKQtJN?=
 =?us-ascii?Q?FtBHYqXy77c7C234hnEP05urc9lpYtM6nOKBCxJd4e+g+15wl8n22nzowF5M?=
 =?us-ascii?Q?VENXXOhjAclBhtjOHiin8v0unM0AwfXbMUudXdbHBSfdE0wDJTn0XjPeheF0?=
 =?us-ascii?Q?5kjWOhNFF964KJP8RWJhHac2NR4yhI25Q51jFf9QUbltXcNbDHWFrYqj9nfP?=
 =?us-ascii?Q?xKcyCpl/8BHaThg0QS5l2zyXgGlHQL5Aq7Zn5zHVlqfEU11eQxmamJvPPjMb?=
 =?us-ascii?Q?Sg9H36Lvka3pLmfeYZxiCHKoBJMiKc+J7QuOvFrr+u11JNWVoQlt4RIj6ZZ3?=
 =?us-ascii?Q?JOUJdqh6m1yM8ocD9IPwl+dyqgMPBZMRoOMry6raQc32sPsiM6OvIAr059MV?=
 =?us-ascii?Q?igTOtrfxQ6Pv+u01s5AfNoNP//AdUOqtrw6QKbxUfCLyKwgdNm0LJLXcfStJ?=
 =?us-ascii?Q?SzCzmZcG/Q8AU0kSXVDHbn8OLU84znuPqDDfnr6BZXlixWEWZ546b8kKtg3i?=
 =?us-ascii?Q?bWXs8Y89FMSKpXrvrZ7NNYxfiNCBcwd4uJX/ZQxJ32BqrTFbWv1qkllLYLjL?=
 =?us-ascii?Q?yged6e7xPjHs3ATSw63G5z93senuhi7nGL9Cj9791IooQvwo6hhI1U1dR2RW?=
 =?us-ascii?Q?uJlG0C2jqC8stUrTs+9JAbl5yOjXSU79PLD2LJo7txcFRcNMzlWh52i+OBrS?=
 =?us-ascii?Q?61uJq+b0ZsxypNkGUB/d0LdL3nik6G2MuXJyloeAGyg4XtyMCga1Smbp6y3+?=
 =?us-ascii?Q?tAqf2m1F2AmuHqS1fhlAWUq5RtvERme2h9qbSrXqoNTWXm2J/SP4ISsXJ9hT?=
 =?us-ascii?Q?A2YQu+dbtj4jM66AN6OZSLmWaZeaKFt2UBB8o9wyjpFUIB3i9RcGCzl/qrnk?=
 =?us-ascii?Q?80RLnvX1BD0YgU47WpilrNsqawykZZwUsmcHyhVgvBjLoU9FZCAz45DdVVe+?=
 =?us-ascii?Q?8vDpgSY/v8vjZ2jeeUX6y52Rf+ZSExGxHGJtj3zJlanw16XMxlDgpydRN+qj?=
 =?us-ascii?Q?iaCIlsgnfQxGittKphyq2ZiSLVTrO2VEK2tVo32QATgGeptYs0JaJ9dYQ75i?=
 =?us-ascii?Q?5v8uJnbG5r409Nvcxxz50zk0B7Hd8JQAfJ7FNsE8rzhUshRu5qIyCEHHlNyb?=
 =?us-ascii?Q?yinRE2fgDSBE4mc9rjFsUB8Od3bZUabx/aYqoNO45NYcGww0fsoenCwqFtKo?=
 =?us-ascii?Q?HhNwMjYSO3fCxlSDKVDlzNJLO+922/wSKcBUhINC9WTvCS4LSP0eBlSagxhk?=
 =?us-ascii?Q?bGvNcKrko/w86nhCMwDmT2/c/8f08g2ryM7VcooYFp88W2iqWBY50iWNSE3x?=
 =?us-ascii?Q?czlK/cbKJbv0/2AT1xlQP3mX9veBEzLB3DyU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 16:00:05.4603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4757702e-1c21-4ac5-bc09-08dd9d378c13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
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

For supported ASICs DMCU version is exported, but ASICs that support
DMCUB there is no information exported to sysfs.

Add an attribute for DMCUB.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 4a72c2bbd49e..2505c46a9c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -765,6 +765,7 @@ FW_VERSION_ATTR(sdma_fw_version, 0444, sdma.instance[0].fw_version);
 FW_VERSION_ATTR(sdma2_fw_version, 0444, sdma.instance[1].fw_version);
 FW_VERSION_ATTR(vcn_fw_version, 0444, vcn.fw_version);
 FW_VERSION_ATTR(dmcu_fw_version, 0444, dm.dmcu_fw_version);
+FW_VERSION_ATTR(dmcub_fw_version, 0444, dm.dmcub_fw_version);
 FW_VERSION_ATTR(mes_fw_version, 0444, mes.sched_version & AMDGPU_MES_VERSION_MASK);
 FW_VERSION_ATTR(mes_kiq_fw_version, 0444, mes.kiq_version & AMDGPU_MES_VERSION_MASK);
 FW_VERSION_ATTR(pldm_fw_version, 0444, firmware.pldm_version);
@@ -780,9 +781,10 @@ static struct attribute *fw_attrs[] = {
 	&dev_attr_ta_ras_fw_version.attr, &dev_attr_ta_xgmi_fw_version.attr,
 	&dev_attr_smc_fw_version.attr, &dev_attr_sdma_fw_version.attr,
 	&dev_attr_sdma2_fw_version.attr, &dev_attr_vcn_fw_version.attr,
-	&dev_attr_dmcu_fw_version.attr, &dev_attr_imu_fw_version.attr,
-	&dev_attr_mes_fw_version.attr, &dev_attr_mes_kiq_fw_version.attr,
-	&dev_attr_pldm_fw_version.attr, NULL
+	&dev_attr_dmcu_fw_version.attr, &dev_attr_dmcub_fw_version.attr,
+	&dev_attr_imu_fw_version.attr, &dev_attr_mes_fw_version.attr,
+	&dev_attr_mes_kiq_fw_version.attr, &dev_attr_pldm_fw_version.attr,
+	NULL
 };
 
 #define to_dev_attr(x) container_of(x, struct device_attribute, attr)
-- 
2.49.0

