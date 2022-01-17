Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2145C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 16:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E0A10EE3C;
	Mon, 17 Jan 2022 16:22:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9BC010EE3D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 16:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS3XdaFTXTqiVpHxB935JQ5hnVMyBICnlFGCLYVu4FfdLLIU0nLnNHMV4kj4iVbAc3pc3WbqYuC7NXOrmep2ZCkoJLhZu+V+dt1da8gth53ou4kut3/sFvQnrRScucNEA/JfXJXPQ7hO3uHyhz1gLB4PNVlnqjVwMu6AaCJlBkNDtGj0yR7aVpPYevStXCm+cAiYeq2dn9Z50Mfea4Q7OuKyVZkHoFDK8oKUp0UGR3mos5dk/Bw1sUP6Scfjl1jYPBXVlXzq1jq4/wFnvGPY9mY4l9zzISRoIofl7Ppu/p+BhbtkwsBBqcgauGlFgBYBidcnmYIADwCbr8WNL0Y/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7IWhu4GYz86dL64QeNnwL767S6iS8Auedb4cEh7jeA=;
 b=jvO8TlE0AZiatgSRuHteCdzU9ScrocEfDakpXUm2C35+AbKuTKKtF+5NHJ5TDsdawDbmA+Dx/at/uT1/sfT6Sr6yDph0agfka9nA2IuB+os6+D12mwU/tGC69QumJJLSu8NeCUfoYi7Az3Hg+SgHi6gcJHp7lA/8z/8eMNJ/DpL5KSpgcJFvvvPc20RrUXposKhWkeo3aI9j5AOpN77H640hC06y40CQCDk9+z/36hCbYzIsJG7YW05duoCBJj5I7RsaNDXEeFBfjNxONt+y17ggnj667e36OgcKnTL1eL8ROXTB79i5k1qZpb9KyeJ3uOQ8uvnHP9j4HEOySLtnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7IWhu4GYz86dL64QeNnwL767S6iS8Auedb4cEh7jeA=;
 b=DQbQBtMhjfjqjq2fCd7h/FHzrYnG+enLDdBtyt6ImTgXBlSvBKSNmBdVUDvbrbGu5u1Ph9mEc7e1DTJCq8Kf0Vo/H5SjTtFshTh8wRzLi35hK9qTE3RNUO2gJM7vew3bA+JKd0B6UsgesIOFv8uhzHMmyuTBPGQSlChzalNi7Fs=
Received: from BN6PR17CA0035.namprd17.prod.outlook.com (2603:10b6:405:75::24)
 by MN2PR12MB3615.namprd12.prod.outlook.com (2603:10b6:208:c9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 16:22:03 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::53) by BN6PR17CA0035.outlook.office365.com
 (2603:10b6:405:75::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Mon, 17 Jan 2022 16:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 16:22:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 10:22:02 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 10:22:02 -0600
Received: from haijun-target2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 17 Jan 2022 10:22:00 -0600
From: Marina Nikolic <Marina.Nikolic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Enable sysfs required by rocm-smi tool for One VF
 mode
Date: Tue, 18 Jan 2022 00:21:53 +0800
Message-ID: <20220117162153.30906-1-Marina.Nikolic@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f45d535c-bb91-445e-f337-08d9d9d57ef7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3615:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3615C90C7ABF40033FA664AB8E579@MN2PR12MB3615.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocN0IRU9nHxxfxF8KSyEwR6zgtZwYFiHS3ugJPlxpKsFZwPetqIc4Bm7OAFm5jBXCIEH1h9I/HUFZ2ueW8NAjr7QZtTs9ToylKao1COIWZiTZGwYFqEpGk9HnllNSzjXAFderbbV4j7lMXOdMj/Ijw8GYpAQnUtCLt1H6m1qbTYzYd5neubIeNl+pUJ5wHIloXAlxKN0GOuyt0Rm7Vl3siCs5GiaqDTJYBZX4/ZcgR7y21LQFBQF1DtbVPmAn4wa5bLR4tgy49U+NOrEqX8qhH1mMhw3Dq3ii2yg715gs/cCJWb9VgH9vmWLAOflL9ZfVkKnSnegNKemmnynFOGe+C+S1fCb5qWh0lDcJfrsMTNxySvz5BdrAooOFnXRB5anFr+vAP1YSg7sxA1UZb47ojwtFzyiwgST05xrS+Y+5nhIYSX6b9EmJCBYvkiiL4SUvAd4wHnaTbOfFxFV3gbfGmQe4iqN2JZnM20+Otxhli3j6zRee70Pe+uJVbLGOof4P856HHcuANf7wdO4T8Mbn6Oup5kWGsRWKWup8Fs0xKlQyXySaUiPCCjgWQ3oMx0GvM0wtPxdMBVgaSeuSG8xRjPCe/EpsX3cn2U4mzDTZgtDYMsItQ5ifx/LnVZhAXG+5ohWOXJ/HnUsEUsSnzjYrd3FdiFCD2NaWn3ur1x4GTce3wXJqUIXBXBAyFFEssTSqKT6TiGa96nNZnCasR0zTQWGTTjlqlCqWFDNWB0Ju7ydgUTeVDvcQEIEi3WqEzMeaBj3VRmoVDkOL63iwL15Q5b0n6MceIjOoMnsjczl0nw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(2616005)(36860700001)(186003)(426003)(336012)(508600001)(70586007)(70206006)(316002)(8676002)(40460700001)(54906003)(82310400004)(1076003)(47076005)(8936002)(81166007)(4326008)(6666004)(86362001)(5660300002)(83380400001)(7696005)(356005)(6916009)(26005)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 16:22:03.0607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45d535c-bb91-445e-f337-08d9d9d57ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
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
Cc: milan.mitrovic@amd.com, nikola.veljkovic@amd.com,
 Marina Nikolic <Marina.Nikolic@amd.com>, greg.kitchen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable power level, power limit and fan speed
information retrieval in one VF mode.
This is required so that tool ROCM-SMI
can provide this information to users.
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c              | 17 ++---------------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |  2 +-
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 1b03ad7a21ad..bb7d03cd814c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1903,8 +1903,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -3152,19 +3152,6 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	/* there is no fan under pp one vf mode */
-	if (amdgpu_sriov_is_pp_one_vf(adev) &&
-	    (attr == &sensor_dev_attr_pwm1.dev_attr.attr ||
-	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
-	     attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_target.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_enable.dev_attr.attr))
-		return 0;
-
 	/* Skip fan attributes if fan is not present */
 	if (adev->pm.no_fan && (attr == &sensor_dev_attr_pwm1.dev_attr.attr ||
 	    attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 4e37cd8025ed..7ea0427f65d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -134,7 +134,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         1),
 	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 0),
 	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
-	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
+	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 1),
 	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
 	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    0),
 	MSG_MAP(PowerUpVcn,			PPSMC_MSG_PowerUpVcn,                  0),
-- 
2.20.1

