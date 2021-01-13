Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DC6C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCCD22EBE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCCD22EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 094CF89C86;
	Wed, 13 Jan 2021 03:28:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E9089C3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 03:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeAB3DZRU83kZ6/pkzVwlOuD2FeRxKk6paqk659arRppYV9/oCwwunhSPLLEN069NlqsdspYC21VJE61FqpiBvhNbg5IYCxWhnmhkxEWKJKDz9UsI/mJR1so4X2PL27HOAY5/tu98prjZZABnngcwClY5wAFxI4FR7j1E+Nu0G+ST+URKhEg1ku69oq4H0n/d2G44jrNQeInx6YzHrWwfC3JBNE3Hxep+wcQetncAJrLlUQDudv7f3i7K3Btq+dQo/pZG86qp1VzwgZVG4SLpNd833k+zJCqMybbbBQXMWwYIktj5qwomSUot65+pX5LlNrrrKsyWn85OnZiDA8Y0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCxsuMtvBQUzY3dvc/5EgKNlpv4K+P6sG1MLplKeLE8=;
 b=C6ux3ZWhIWrLutMLmPW++cf0g56WTLcHT5FgcPsvi9bXT6M1Gjs2YyPqZ/N/VdmzHNs6co+9z9wskoYXjEYvyHLHVfU35G+3hUyjiyBhRIhM56XIONHUJO8kHm5K0EJ5SlnFlMOiPfI+K99cXwxcIEhAUcfuMk3r4WAnGOJanVqqGDfm3o89nAeNnd8mOeqFwbNn50HlC+I3YOHVMiU/5EWh2MGo4fXHTNuNvAkxfsz8wLgElcRmT//YO0mOTVa2CvCbbATtlYxu/8utXtStK8fUj1v2zy8AwWX6EWR1Vwl3eTMtDKT2mH9xOyn2H0tVH/21OLD5ZTRpcCDPFq/K+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCxsuMtvBQUzY3dvc/5EgKNlpv4K+P6sG1MLplKeLE8=;
 b=LAo2qJ47hJtLqiPJWpI0GOwtKdajLvh58TtvFjA3lXMH5TBMu+5eBEPIVzKBI4Bul1akCmh/9ouCz3bgnOsodOjfQfH3Du9ZjlDzSPa3RyAn+IZ1zaKBhP8pat5DhsXroBuHOna62DbbEOeF5vSuetoxRkONAbW4b3bq+ChZg9o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 03:28:07 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 03:28:07 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] amdgpu/pm: Powerplay API for smu ,
 changed 4 dpm functions to use API
Date: Tue, 12 Jan 2021 22:27:25 -0500
Message-Id: <20210113032726.2475-8-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113032726.2475-1-darren.powell@amd.com>
References: <20210113032726.2475-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 03:28:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a82c6eec-ded7-4af4-2b4c-08d8b7733e89
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38171946A6840C64201353CBF0A90@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpsOgiJdKKPmQ8iptQQ8ofeQZZ26BTH0YSbtpd5QinwY+UcOrUG7/LA29iug9EzSh7Ihanz/9VscnxhjP1PT/myzrui/kHWT80wFVA1GXJGUcP+f5gqbYE+Mv0mLcqT8qiCZJfUvz5/4u90e8sFRxkAis+MweKgwdd36ZwyT5/Ton6nft6An17Ue45boOc4ilLs7NQlpdgP28Oeyj67jP01cmbtdZKItFUT1nSzs24N5ZC3atrIhVsTqdj3i7nXtkfc16562RjFDwTAIHnxO/KknfXtHUnlzagRL7NkAPppqBfssC2UYb6OyZmrr60p2PbrtAdaHv4RNbBN7TiQ5tpvuCOIINi9pbY4FQt1REpwObzCjecXA2d1L3J+P90U3+ayWMGD0BsyXi/OAjghZl9ouCaxFjUStwl/E8y6A0dzy5vnLosDDQp2eBIgsbOpG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(5660300002)(69590400011)(66556008)(4326008)(6506007)(8936002)(36756003)(8676002)(6512007)(6486002)(6916009)(66476007)(186003)(44832011)(66946007)(86362001)(1076003)(26005)(956004)(30864003)(52116002)(478600001)(16526019)(316002)(2616005)(6666004)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lrgeJvMUJZRiRjF7v6kvP5re60gSB1DkJXgHK5fGRhaSeOKe9AGM4i5MFtvW?=
 =?us-ascii?Q?vglLqm3O/Gnh3ED1FMYodL6AriyRZczo844//vLfi7HBp8Ymqm+x685W5zr6?=
 =?us-ascii?Q?J91OscpXBzNyzo8Fe1hgNp1pZ80cQlbg3gLf5WaRE57c31e9C2XLqxAg+Gve?=
 =?us-ascii?Q?74IuXKmv3n6nq6pKxcXhBguPNqA5BNsSH87dUDaocQUrj7BQPMTEjDugjmOb?=
 =?us-ascii?Q?VKhincnkffE9OvvIeQyWm5UG7KyACn8ICcjO+QpLKlgQKl/+IBCOrOJ9Hg61?=
 =?us-ascii?Q?kpmTJtswk8PbK2a7Y28wHZ8tQ+Wp8aH8csloO4u5+i2PTQDUySEjvfX9c+5Y?=
 =?us-ascii?Q?mYiXOLz2+1Fk+w/bRDTBNIUx1Hj+5MC9q4UOBNxgw6wn809hwPHdtCucilRI?=
 =?us-ascii?Q?fFyPxIdiAfBGsCkgM4srbH8vSKMMvJHeCQWp4QfR5X/7nel18sWjuv4hI2xs?=
 =?us-ascii?Q?4jX2lWVNO+NEUObYjn+LI7krFij//iWdCDlta6WzOwbQQMNG7idZ/VFcxwPp?=
 =?us-ascii?Q?GdJaJyp/MkXYzXMK722Pnf9TLOwzrTwEXYUZlZdTAcjaMleTX8zmeFri/9Lj?=
 =?us-ascii?Q?JNUD7zi+zMBFeDW1bVoe8IGLS94bUJZYj4uOjb15QCBiOt0Y3Ak3At57ny3t?=
 =?us-ascii?Q?Ok94+lWC7nkhEDwQdu/XeKIKW+rdyG+KdyNd4PUC6jXgd67LFMk4hyUdcV+i?=
 =?us-ascii?Q?ASULkt3HO7mBAk6hVWWRXa9U2utExHMPVaGtgAH8cdG1JOElVuASWCVWq/Wf?=
 =?us-ascii?Q?xohQ7B950c6VDG0fqIYdGnjSyp0D9zF+mDUItOwoCGZktSar4SELJ0zNO4h8?=
 =?us-ascii?Q?5XvtscPVQeN5JZvsTb+d3REGKKXPlSUsY4gXru9NI/zRcIlNNLEhC+qzhw+T?=
 =?us-ascii?Q?w1hEjYkyiMsCu7wawSlG8ezYeWTFkFVXC2JuR46Dspe1iAJayvr6df0XUKqC?=
 =?us-ascii?Q?Jyp7nH6Wp5KhFyqW1IyJeJNQOU52w/i1rxac4akpWeH+RN0EVhbEF1HsBYdD?=
 =?us-ascii?Q?3l3C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 03:28:07.0224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: a82c6eec-ded7-4af4-2b4c-08d8b7733e89
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3pGdyXC2epWJVqVJcq+r1cPQjdmZTa0GZtPjcQaE/jmK5GivhURX40JOP77Td9EO/V9WW5TGAN/mGi6aM+zqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v2: fix errors and warnings flagged by checkpatch

New Functions
  smu_get_mclk        - implementation of the Powerplay API function get_mclk
  smu_get_sclk        - implementation of the Powerplay API function get_sclk
  smu_handle_dpm_task - implementation of the Powerplay API function dispatch_tasks

Modified Functions
  smu_dpm_set_power_gate - - modifed arg0 to match Powerplay API set_powergating_by_smu

Other Changes
  removed special smu handling in dpm functions and called through Powerplay API
  call to smu_dpm_set_power_gate via Powerplay API now locks mutex for UVD and VCE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 96 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  7 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 49 +++++++++++-
 3 files changed, 86 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 8ae2df82addc..0a6bb3311f0f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -911,50 +911,28 @@ amdgpu_get_vce_clock_state(void *handle, u32 idx)
 
 int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 {
-	uint32_t clk_freq;
-	int ret = 0;
-	if (is_support_sw_smu(adev)) {
-		ret = smu_get_dpm_freq_range(&adev->smu, SMU_GFXCLK,
-					     low ? &clk_freq : NULL,
-					     !low ? &clk_freq : NULL);
-		if (ret)
-			return 0;
-		return clk_freq * 100;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	} else {
-		return (adev)->powerplay.pp_funcs->get_sclk((adev)->powerplay.pp_handle, (low));
-	}
+	return pp_funcs->get_sclk((adev)->powerplay.pp_handle, (low));
 }
 
 int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
 {
-	uint32_t clk_freq;
-	int ret = 0;
-	if (is_support_sw_smu(adev)) {
-		ret = smu_get_dpm_freq_range(&adev->smu, SMU_UCLK,
-					     low ? &clk_freq : NULL,
-					     !low ? &clk_freq : NULL);
-		if (ret)
-			return 0;
-		return clk_freq * 100;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	} else {
-		return (adev)->powerplay.pp_funcs->get_mclk((adev)->powerplay.pp_handle, (low));
-	}
+	return pp_funcs->get_mclk((adev)->powerplay.pp_handle, (low));
 }
 
 int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block_type, bool gate)
 {
 	int ret = 0;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	bool swsmu = is_support_sw_smu(adev);
 
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCE:
-		if (swsmu) {
-			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
-		} else if (adev->powerplay.pp_funcs &&
-			   adev->powerplay.pp_funcs->set_powergating_by_smu) {
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
 			/*
 			 * TODO: need a better lock mechanism
 			 *
@@ -982,7 +960,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 			 *     amdgpu_set_dpm_forced_performance_level+0x129/0x330 [amdgpu]
 			 */
 			mutex_lock(&adev->pm.mutex);
-			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
 			mutex_unlock(&adev->pm.mutex);
 		}
@@ -990,12 +968,10 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_GFX:
 	case AMD_IP_BLOCK_TYPE_VCN:
 	case AMD_IP_BLOCK_TYPE_SDMA:
-		if (swsmu)
-			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
-		else if (adev->powerplay.pp_funcs &&
-			 adev->powerplay.pp_funcs->set_powergating_by_smu)
-			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
+			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
+		}
 		break;
 	case AMD_IP_BLOCK_TYPE_JPEG:
 		if (swsmu)
@@ -1003,10 +979,10 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 		break;
 	case AMD_IP_BLOCK_TYPE_GMC:
 	case AMD_IP_BLOCK_TYPE_ACP:
-		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->set_powergating_by_smu)
-			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
+			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
+		}
 		break;
 	default:
 		break;
@@ -1512,36 +1488,30 @@ void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
 			amdgpu_fence_wait_empty(ring);
 	}
 
-	if (is_support_sw_smu(adev)) {
-		struct smu_dpm_context *smu_dpm = &adev->smu.smu_dpm;
-		smu_handle_task(&adev->smu,
-				smu_dpm->dpm_level,
-				AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
-				true);
-	} else {
-		if (adev->powerplay.pp_funcs->dispatch_tasks) {
-			if (!amdgpu_device_has_dc_support(adev)) {
-				mutex_lock(&adev->pm.mutex);
-				amdgpu_dpm_get_active_displays(adev);
-				adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
-				adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
-				adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
-				/* we have issues with mclk switching with refresh rates over 120 hz on the non-DC code. */
-				if (adev->pm.pm_display_cfg.vrefresh > 120)
-					adev->pm.pm_display_cfg.min_vblank_time = 0;
-				if (adev->powerplay.pp_funcs->display_configuration_change)
-					adev->powerplay.pp_funcs->display_configuration_change(
-									adev->powerplay.pp_handle,
-									&adev->pm.pm_display_cfg);
-				mutex_unlock(&adev->pm.mutex);
-			}
-			amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
-		} else {
+	if (adev->powerplay.pp_funcs->dispatch_tasks) {
+		if (!amdgpu_device_has_dc_support(adev)) {
 			mutex_lock(&adev->pm.mutex);
 			amdgpu_dpm_get_active_displays(adev);
-			amdgpu_dpm_change_power_state_locked(adev);
+			adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
+			adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
+			adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
+			/* we have issues with mclk switching with
+			 * refresh rates over 120 hz on the non-DC code.
+			 */
+			if (adev->pm.pm_display_cfg.vrefresh > 120)
+				adev->pm.pm_display_cfg.min_vblank_time = 0;
+			if (adev->powerplay.pp_funcs->display_configuration_change)
+				adev->powerplay.pp_funcs->display_configuration_change(
+							adev->powerplay.pp_handle,
+							&adev->pm.pm_display_cfg);
 			mutex_unlock(&adev->pm.mutex);
 		}
+		amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
+	} else {
+		mutex_lock(&adev->pm.mutex);
+		amdgpu_dpm_get_active_displays(adev);
+		amdgpu_dpm_change_power_state_locked(adev);
+		mutex_unlock(&adev->pm.mutex);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 3c0b6209ab6a..edd911ac8e5a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -727,16 +727,21 @@ int smu_set_watermarks_for_clock_ranges(
 extern int smu_display_configuration_change(struct smu_context *smu, const
 					    struct amd_pp_display_configuration
 					    *display_config);
-extern int smu_dpm_set_power_gate(struct smu_context *smu,uint32_t block_type, bool gate);
+extern int smu_dpm_set_power_gate(void *handle, uint32_t block_type, bool gate);
 extern int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
 			   enum amd_pp_task task_id,
 			   bool lock_needed);
+extern int smu_handle_dpm_task(void *handle,
+			       enum amd_pp_task task_id,
+			       enum amd_pm_state_type *user_state);
 int smu_switch_power_profile(void *handle,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en);
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max);
+u32 smu_get_mclk(void *handle, bool low);
+u32 smu_get_sclk(void *handle, bool low);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 enum amd_dpm_forced_level smu_get_performance_level(void *handle);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index dbcf853abb47..e846a9c6617f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -138,6 +138,34 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	return ret;
 }
 
+u32 smu_get_mclk(void *handle, bool low)
+{
+	struct smu_context *smu = handle;
+	uint32_t clk_freq;
+	int ret = 0;
+
+	ret = smu_get_dpm_freq_range(smu, SMU_UCLK,
+				     low ? &clk_freq : NULL,
+				     !low ? &clk_freq : NULL);
+	if (ret)
+		return 0;
+	return clk_freq * 100;
+}
+
+u32 smu_get_sclk(void *handle, bool low)
+{
+	struct smu_context *smu = handle;
+	uint32_t clk_freq;
+	int ret = 0;
+
+	ret = smu_get_dpm_freq_range(smu, SMU_GFXCLK,
+				     low ? &clk_freq : NULL,
+				     !low ? &clk_freq : NULL);
+	if (ret)
+		return 0;
+	return clk_freq * 100;
+}
+
 static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
 					 bool enable)
 {
@@ -213,7 +241,7 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
- * @smu:        smu_context pointer
+ * @handle:        smu_context pointer
  * @block_type: the IP block to power gate/ungate
  * @gate:       to power gate if true, ungate otherwise
  *
@@ -224,9 +252,10 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
  *    Under this case, the smu->mutex lock protection is already enforced on
  *    the parent API smu_force_performance_level of the call path.
  */
-int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
+int smu_dpm_set_power_gate(void *handle, uint32_t block_type,
 			   bool gate)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -1553,6 +1582,18 @@ int smu_handle_task(struct smu_context *smu,
 	return ret;
 }
 
+int smu_handle_dpm_task(void *handle,
+			enum amd_pp_task task_id,
+			enum amd_pm_state_type *user_state)
+{
+	struct smu_context *smu = handle;
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+
+	return smu_handle_task(smu, smu_dpm->dpm_level, task_id, true);
+
+}
+
+
 int smu_switch_power_profile(void *handle,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en)
@@ -2721,10 +2762,14 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_pp_table            = smu_sys_get_pp_table,
 	.switch_power_profile    = smu_switch_power_profile,
 	/* export to amdgpu */
+	.dispatch_tasks          = smu_handle_dpm_task,
+	.set_powergating_by_smu  = smu_dpm_set_power_gate,
 	.set_power_limit         = smu_set_power_limit,
 	.get_power_limit         = smu_get_power_limit,
 	.set_mp1_state           = smu_set_mp1_state,
 	/* export to DC */
+	.get_sclk                = smu_get_sclk,
+	.get_mclk                = smu_get_mclk,
 	.enable_mgpu_fan_boost   = smu_enable_mgpu_fan_boost,
 	.get_asic_baco_capability = smu_get_baco_capability,
 	.set_asic_baco_state     = smu_baco_set_state,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
