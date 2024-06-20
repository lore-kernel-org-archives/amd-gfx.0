Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E10C2BA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 01:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3E110E146;
	Thu, 20 Jun 2024 01:24:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pf+TxDRd";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DBB110E146
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 01:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgBw3z47/SZCX0Duk9VS212vdFsA+sWtqmB3b96enHAe3JToZYUMRqCEawV7nHG1AVqIkaBnYxi/zEWpqCKXGBR+Tcr56IW52Bx7UaNykzAyWvFxAqk71xhJGMDBfQGHNr/H8rcbIUhH3R8iAo75oCydJoIPTw/CEOC7tK+zbA54NjULvPADFglbN59HZB/LTYGwPUnmQbT4y32mypghYaQupn5DIx6Yfu5GQ9/oIrZCrTtzSb0E8dTmY08m3Wqq+T6jyIMNGL3qTlCoSSFcfzOZrKhhkx4RgrynKeKZckx6qzvRXLTvxw+NARr/g3y4TW4Bel2keaLT/kQVIJ2nSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZYH8Yi+Ez53PzG/bdUy4MkTPLqbliN+62scjo4nc2s=;
 b=eRm7y7F1DVZxkd+5nQmFor1zvCllOdkw/MIMThMm0cUCc7YzwMVEC6A7lilsy1zBYICmjZSedQi6GeCKtoM3+iqoLhfxDC/nvelFAnmR7zYYvwj/ySfHFADwq6AMEjyya/nP6+0HpFB+9YCHaV1/dkqrFMk+fkLmopCFlTZjhuGnY0R6cNrgn56f3RLorqybChG3qHyAxbvRxaltovW0VvxVy8+0+Lz/AOdoUCOCJf5uvYno8zfUnVJUf/YEdz1o/EGlC6JutHRVZhrqFFpB492JyU4Fu99f8GHQdJY1lx1fcDmp4OcxoNeonVoxbaMrL9+rneRlLKYzc21dNpz7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZYH8Yi+Ez53PzG/bdUy4MkTPLqbliN+62scjo4nc2s=;
 b=Pf+TxDRdmlVbj7o3Zw85bK6KXDQhk0wlkLzXA1qlexAwsmz6mMIYVdg3IP8BRCt10vx0mD7sbteOklFbjyng/n+tP4vTGXeokOsCf/UU32K2OnoMQKOrGOUtnXiRrjF5Hp3tpUYgXRBtNtmOBegj3dwJX7KfR4Og9b8s6Qlh9Ec=
Received: from SA1P222CA0107.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::28)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 01:24:38 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::39) by SA1P222CA0107.outlook.office365.com
 (2603:10b6:806:3c5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 01:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 01:24:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 20:24:37 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 19 Jun 2024 20:24:36 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sonny.jiang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd/pm: workaround to pass jpeg unit test"
Date: Thu, 20 Jun 2024 09:24:33 +0800
Message-ID: <20240620012434.1742537-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2eab4e-170e-41ee-3003-08dc90c7c09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|1800799021|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RX+1bM7th9KUUq9pZseyAdd+S1KN1w8VeBwjOFmu94vqLf3C0BNYc7sqqqTx?=
 =?us-ascii?Q?s7UC3Btk6e8NqaGwB7o0aCHDIh0yWZNhRkZsp9CxULcaNzkUgIMkD/OVRHWt?=
 =?us-ascii?Q?mpoqtIFtTkFDBxORPksB+SG0LQjH78EIeGJiFttLSCucCx/LvS+vjXxF2FFM?=
 =?us-ascii?Q?dhCINjg2IUXIg8BDCVwokUP0Hkj8pV+DjiyEsbnYfiwcD3GPlfuojae7EUi7?=
 =?us-ascii?Q?NSUyHLX8d+3TpKVampb3bhOlWa0MxWIBytQ7Uu8KyaXyQeCYWD7pcIPHQS5j?=
 =?us-ascii?Q?XBgSNJVEQZWdImerit/9+5xd67igiswgkq1dPVjyo/PhuBdw+DvHLAbiZS/O?=
 =?us-ascii?Q?bkjbwUPa4b81qmbQ836V6RO1+zX8L8s9qhRx/Waevhl0IOSNbnL//K0Roykv?=
 =?us-ascii?Q?EvMaX+G8zjmoj0TGSpJDYKlfKfPLd6OKMvP7CIW5gKd1hRoIrnOdwRFinxAN?=
 =?us-ascii?Q?mTyU4G1iP7VRxdS1dJxqZ2eYJT5UPiQvNh2smHWda2iUsm/NVNTrLYcymPU/?=
 =?us-ascii?Q?9jO4iLXuBkXjvVBfaMhTTV00zj8bEDo3zj31eaKh6nW7zQRalHoCH8m8I3zi?=
 =?us-ascii?Q?kLvQfYy9II3ykf5j44y5RlTSd+3Z+akc+THcm/pblE+AEyR9a/ZeXGkCOxii?=
 =?us-ascii?Q?MchTBomPGZMztOZgftor2CBh/bmpMeCFqrG1AK+WpacR8iswjWibZ+DJu/Z6?=
 =?us-ascii?Q?05uTJa3V3ZU5SZ4UrNN81BgecZGNFg7dOa06B/qE9S1XPsaP7QoTpUNapUA9?=
 =?us-ascii?Q?RNbhuOB7uMPwHkHk9oyF5fcSXFwG5lUWH/I04IwaRhfkttgCDL/72QmvS7XO?=
 =?us-ascii?Q?1xkKg1boyb5exqMYnZueaYhkP0BjHHw4nEFIVrhm+qgHCiU7baBKnUPxEsYD?=
 =?us-ascii?Q?mOFFHrrpgU69DoGJprei9zbrEwQM4y88YO7aOq3EKcnlSJ1eTF1JJPqaHvoC?=
 =?us-ascii?Q?bnSrffgODqu8mPL5ChbVHOPdCzooV1FZxRy4qUVERKJr2D2VqzSfLVw9/wZo?=
 =?us-ascii?Q?BIZSOWfCUjmCWV6yjgofMqH2k5cpttq2xRfC1D4BIjhIxevvNDTDDSl7LVR4?=
 =?us-ascii?Q?0Kio+dsBwOaKGdTHAoWB5Hr5ZAVOsit7BlMqhcgeeY7v/SRGlIvasY2YWcAd?=
 =?us-ascii?Q?PFwDtW0/FxQCnx0UrlpqqFN2rzM/DlBEb0yol2wUsfr1ui6Abej4jBMr8M63?=
 =?us-ascii?Q?jCs6pDwrS6ysBVdhni+PcGQuoeWg3n2wNOa1cjC+XuMHvnt0nq3elUSQjCoM?=
 =?us-ascii?Q?R2wm3jQn0LuCEX7ec1vpBSUvz93SrOP5Z31u7hbomZf++v53zulonTorYCjz?=
 =?us-ascii?Q?j4q0T1jFGUe587iEfO27H/7dYG5lrnMQxWUnq4UN9iv/n5lGYzN28MCh8Icr?=
 =?us-ascii?Q?bd0M57jq7ov9y99FVPmkG5hQHBfgJwupmH0/WfAroH2QXfxqGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 01:24:38.3536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2eab4e-170e-41ee-3003-08dc90c7c09f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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

This reverts commit a03b8169582453c01cbf76d8a92a8194d3421b13.
Revert this due to a final solution in amdgpu vcn:
commit eef47ed5f703377781ce89eae4b9140325049873
Author: Sonny Jiang <sonjiang@amd.com>
Date:   Tue Jun 18 11:11:11 2024 -0400

    drm/amdgpu/jpeg5: reprogram doorbell setting after power up for each playback

    Doorbell needs to be configured after power up during each playback

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  3 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 30 +------------------
 2 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8e694b576d1c..00384b381289 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -237,7 +237,6 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	/*
@@ -253,7 +252,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 		return 0;
 
 	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
-	if (!ret && !adev->enable_jpeg_test)
+	if (!ret)
 		atomic_set(&power_gate->vcn_gated, !enable);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 7179cdacf156..98ea58d792ca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1869,34 +1869,6 @@ static ssize_t smu_v14_0_2_get_ecc_info(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v14_0_2_set_vcn_enable(struct smu_context *smu,
-			     bool enable)
-{
-	struct amdgpu_device *adev = smu->adev;
-	struct smu_power_gate *power_gate = &smu->smu_power.power_gate;
-	int i, ret = 0;
-
-	if (!adev->enable_jpeg_test)
-		return smu_v14_0_set_vcn_enable(smu, enable);
-
-	if (!atomic_read(&power_gate->vcn_gated) || !enable)
-		return 0;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn,
-						      i << 16U, NULL);
-		if (ret)
-			return ret;
-	}
-
-	atomic_set(&power_gate->vcn_gated, 0);
-
-	return ret;
-}
-
 static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v14_0_2_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v14_0_2_set_default_dpm_table,
@@ -1919,7 +1891,7 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.system_features_control = smu_v14_0_system_features_control,
 	.set_allowed_mask = smu_v14_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
-	.dpm_set_vcn_enable = smu_v14_0_2_set_vcn_enable,
+	.dpm_set_vcn_enable = smu_v14_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v14_0_set_jpeg_enable,
 	.get_dpm_ultimate_freq = smu_v14_0_2_get_dpm_ultimate_freq,
 	.get_vbios_bootup_values = smu_v14_0_get_vbios_bootup_values,
-- 
2.34.1

