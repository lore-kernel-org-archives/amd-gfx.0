Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEDFCF3194
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6347010E692;
	Wed,  2 Oct 2024 04:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zKNlgXHH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 262E410E68A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnAJVbtqxga5nf9bpShFurhoqHhSd4EJSQvDXZeVRDo3seM6mxtz8DT6sfjFJApG68ET9g53nGdHGCgU14KXOWQjpQv7Se+O6SkmjanjdS6jj6IQNiF0vzsvwNkLrmSn+6sgY0UFFrCJQp2JQHkd1ksVyB9pFcuch/8NOhdI7l+zfu4Oylm9wO0YihgeZIay2QW9MryWokpNxYSuB9BUDJbs7Vv076uz+8U0+8RZDEp2DeOsUcycmUvLGXeAT7fSw5sBfpzjZ9raHT+rBiBLzmivTBuXa7AddfIFfknaqlCejXh5MU6wdO1I2C3so1RsYdACrHlwRcKnZfelUOu71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkw08vZw9hzt1/ufacJhPrU09PM6ze3A9vLGusILbRs=;
 b=twyrsyAHOyMB6aZPy5efsytAkXWIueb884v92DbvKsC4BTAbsOw0d1iDSEhjf0W67QIZRhsk4GWrhHFsYl14IXXCNznztNszQTAD40Rfs904FkgSTd0tjrAeshOlg6SO1TPafwuEl0MAAo1wYwFxkd6cibr1LQ9RScHJBQ6GUa15Qk1JcMSBQHgJkykAIlqD51FWXUrCt7gok01Cvhv3/AQjo1nrH/DsaI8Tbqw/3KlP9X4/LzgEwD0MPXYYnVVMQNmK1RVWfCwFlZ8j3EG8OHDvAvgw3cW3mx6Kd33ALo2vKXc80p8LXxMn1zDA4+xrQTr8/cYL22PHq2j3KtUMeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkw08vZw9hzt1/ufacJhPrU09PM6ze3A9vLGusILbRs=;
 b=zKNlgXHH7jGcNlDpjVSsvsAl60n4VSp4CFxySrD0YlwTMtBGsx/nxOSJC6uOKovqEO8CEokj+TSy3y8M6LsWQ+aAWsk+YmK+VggyQlhSC0FF1Z/aGsMpfdnuAojWmloP6/1mKgBo7kVDo81+7EydYMDh/U6hPSDPqiatuGNZyOI=
Received: from SJ0PR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:334::19)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 04:38:53 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::92) by SJ0PR05CA0104.outlook.office365.com
 (2603:10b6:a03:334::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:52 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:47 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 07/18] drm/amdgpu/vcn: separate gating state by instance
Date: Wed, 2 Oct 2024 00:36:16 -0400
Message-ID: <20241002043627.102414-8-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 6175b1b8-86d4-4b5c-324d-08dce29c1e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z+uD/DkhYUIcO1m/hbvekJ6mRBSWgvCsF+2XumtgbjxYbyd/LBEraLxM8Gds?=
 =?us-ascii?Q?DdjdfvNZq0Bn9227IMsDbiav+gdi5uDuroL9FaNt8WU+gmTq00u71jMMxO8P?=
 =?us-ascii?Q?jJkQXQgpXkBdrluiuKLMO2B7+VhMblgWlvDEiqtDKVDx0GvMY6oGsgBmJR5p?=
 =?us-ascii?Q?NJzUqxk2qlcR5m9F8XfcI494M2xj01fj1hIuB8nddj8QE1dN/XR/4kXVBaGO?=
 =?us-ascii?Q?mqlQiWvYKs0WQNBh42tJk9Dzi/Df4MfuWHIHDyFcS1M8NacoZXV68d01223h?=
 =?us-ascii?Q?Fbx2OOCZJiOE2fZiyL1cXPk7QOUDNq8lpZeuDH/bTrU9wWdvts8FMhEnNJAA?=
 =?us-ascii?Q?atlt/TKPhr94C0jXIua49BGHeuEtaJbLmRcKIQxrKCxuvw9zzOak8ukkoVr7?=
 =?us-ascii?Q?PtH52KuFTKYvrgHzCGlkllrylEo4y+m1M79RCbaVOc1dBPP8LATsCkwEkgLh?=
 =?us-ascii?Q?uMYA+N0cEvGSxffpG66hQkPTH5lJzdmmX8ywQiyd5/RDLVPtNOyu1z6Bzdki?=
 =?us-ascii?Q?sEol8RwyytFrre6MvLjcsaLN3U6eAKil8CO0l7GXHu/PKF1VaSD0g66NyKzR?=
 =?us-ascii?Q?41A1BFCYq25pmNRwqx/a+JZvhbvDpff98VFbcTf+w9y4V9vC4GG/28jvPZ7J?=
 =?us-ascii?Q?6iqYYY3nzb5EHK0i3vZTRZZrOcOoBm+2Eipu0hMR5vubnDvazTL24ob6qxmM?=
 =?us-ascii?Q?lbLEzsfEwqTJOqs5nFDBRIHqy0zAGEmdblaIyOUIrmOqNtny7BR0h3MxtFgn?=
 =?us-ascii?Q?VBeOeRBA17Zf7VmAkjqS5rZLM6983601IeAiPcE0E5KfIFekr2fXaIdlzjxE?=
 =?us-ascii?Q?YZFwj4MySLiF63cztHN56CJw4DjO4JVq/sgiNMWJIv1FzfA+Wp4aKQHlggvA?=
 =?us-ascii?Q?diSZIAy2yhz+bSZnV20uQo3uLWN+OaMhwJyXHR2SR2pzcmy5qI+ZalACElN8?=
 =?us-ascii?Q?qrpUUWOXqdcVXPXAFB+l6e27FdpG6i7GNIMePFfPxa48be9Y/ogKY4dDU/Xj?=
 =?us-ascii?Q?K5NkgEIr86XJRx+9lfxlhzQB5VXldIO79Ag4G3CJlFIek5OQ8+noa1goVWPa?=
 =?us-ascii?Q?bU+tg8w/qpKv1PxH2ceGZYtu3Ioab5pLvq1LDOb0mGX9p72cy22t3fOCsEjM?=
 =?us-ascii?Q?VAHGUCzQ+ZLJSBt8h/yDWaebWRd0/cezas40SER+J/GeksNvz2f5x6mNY13Y?=
 =?us-ascii?Q?1eV+TORA1w+DqvrqK79z+p0O05DnWnTzGUIIckKAVbIKgrRjnSCViKO/K7fx?=
 =?us-ascii?Q?Sq6meQb+g4mMpbc+ZDR5vquUPpYtWG7VJhOWdruhoyPtuOOhtG63QvVwF+Hp?=
 =?us-ascii?Q?16TfWNiojdewE059uDwLggzl9OGeBMGQ8z2mVqutd9E5kzOIV85uWJjaYhzh?=
 =?us-ascii?Q?DxTfK7YneuF1GmoR+KXKBTF8eJqC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:52.9774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6175b1b8-86d4-4b5c-324d-08dce29c1e51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

vcn gating state should now be based on instance. For example, instance 0
can be gated while instance 1 is ungated, or vice versa.

Therefore, change the cur_state to be an array, so that it can track the
gating status for each vcn instance now.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  8 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 23 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 38 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 41 ++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 41 +++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 23 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 23 +++++++------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 +-
 10 files changed, 114 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 2a1f3dbb14d3..f6717f780acd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -308,7 +308,7 @@ struct amdgpu_vcn {
 	struct delayed_work	idle_work;
 	const struct firmware	*fw[AMDGPU_MAX_VCN_INSTANCES];	/* VCN firmware */
 	unsigned		num_enc_rings;
-	enum amd_powergating_state cur_state;
+	enum amd_powergating_state cur_state[AMDGPU_MAX_VCN_INSTANCES];
 	bool			indirect_sram;
 
 	uint8_t	num_vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 6717ff692d8d..bafdd6d5ff24 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -279,7 +279,7 @@ static int vcn_v1_0_hw_fini(void *handle)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		(adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
 		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
 		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 	}
@@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(void *handle,
 	int ret;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state[0])
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1822,7 +1822,7 @@ static int vcn_v1_0_set_powergating_state(void *handle,
 		ret = vcn_v1_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.cur_state[0] = state;
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index be6998ed56bc..72e36fbaad39 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -316,7 +316,7 @@ static int vcn_v2_0_hw_fini(void *handle)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+	    (adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
 		vcn_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 
@@ -1812,11 +1812,11 @@ static int vcn_v2_0_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.cur_state[0] = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state[0])
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1825,7 +1825,7 @@ static int vcn_v2_0_set_powergating_state(void *handle,
 		ret = vcn_v2_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.cur_state[0] = state;
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 7ab0314b27ec..09b342ad02cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -397,9 +397,10 @@ static int vcn_v2_5_hw_fini(void *handle)
 			continue;
 
 		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
+		    (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
+		     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
 			vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		}
 
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
 			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
@@ -1832,16 +1833,18 @@ static int vcn_v2_5_set_powergating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if(state == adev->vcn.cur_state)
-		return 0;
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (state == adev->vcn.cur_state[i])
+			return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_5_stop(adev);
-	else
-		ret = vcn_v2_5_start(adev);
+		if (state == AMD_PG_STATE_GATE)
+			ret = vcn_v2_5_stop(adev);
+		else
+			ret = vcn_v2_5_start(adev);
 
-	if(!ret)
-		adev->vcn.cur_state = state;
+		if (!ret)
+			adev->vcn.cur_state[i] = state;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 38452446fcb0..ee9a40443d65 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -430,8 +430,8 @@ static int vcn_v3_0_hw_fini(void *handle)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-					(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-					 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
+				(adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
+				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
 				vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 			}
 		}
@@ -2163,25 +2163,27 @@ static int vcn_v3_0_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
-	/* for SRIOV, guest should not control VCN Power-gating
-	 * MMSCH FW should control Power-gating and clock-gating
-	 * guest should avoid touching CGC and PG
-	 */
-	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
-		return 0;
-	}
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		/* for SRIOV, guest should not control VCN Power-gating
+		* MMSCH FW should control Power-gating and clock-gating
+		* guest should avoid touching CGC and PG
+		*/
+		if (amdgpu_sriov_vf(adev)) {
+			adev->vcn.cur_state[i] = AMD_PG_STATE_UNGATE;
+			return 0;
+		}
 
-	if (state == adev->vcn.cur_state)
-		return 0;
+		if (state == adev->vcn.cur_state[i])
+			return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v3_0_stop(adev);
-	else
-		ret = vcn_v3_0_start(adev);
+		if (state == AMD_PG_STATE_GATE)
+			ret = vcn_v3_0_stop(adev);
+		else
+			ret = vcn_v3_0_start(adev);
 
-	if (!ret)
-		adev->vcn.cur_state = state;
+		if (!ret)
+			adev->vcn.cur_state[i] = state;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 078bb30497e0..aaecc680b631 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -355,11 +355,12 @@ static int vcn_v4_0_hw_fini(void *handle)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-                        (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-                                RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-                        vcn_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+				(adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
+				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 			}
 		}
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
@@ -2040,25 +2041,27 @@ static int vcn_v4_0_set_powergating_state(void *handle, enum amd_powergating_sta
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
-	/* for SRIOV, guest should not control VCN Power-gating
-	 * MMSCH FW should control Power-gating and clock-gating
-	 * guest should avoid touching CGC and PG
-	 */
-	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
-		return 0;
-	}
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		/* for SRIOV, guest should not control VCN Power-gating
+		* MMSCH FW should control Power-gating and clock-gating
+		* guest should avoid touching CGC and PG
+		*/
+		if (amdgpu_sriov_vf(adev)) {
+			adev->vcn.cur_state[i] = AMD_PG_STATE_UNGATE;
+			return 0;
+		}
 
-	if (state == adev->vcn.cur_state)
-		return 0;
+		if (state == adev->vcn.cur_state[i])
+			return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_stop(adev);
-	else
-		ret = vcn_v4_0_start(adev);
+		if (state == AMD_PG_STATE_GATE)
+			ret = vcn_v4_0_stop(adev);
+		else
+			ret = vcn_v4_0_start(adev);
 
-	if (!ret)
-		adev->vcn.cur_state = state;
+		if (!ret)
+			adev->vcn.cur_state[i] = state;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index be7b0bfba27a..87c04c512357 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -318,8 +318,11 @@ static int vcn_v4_0_3_hw_fini(void *handle)
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
-		vcn_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE) {
+			vcn_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		}
+	}
 
 	return 0;
 }
@@ -1627,25 +1630,27 @@ static int vcn_v4_0_3_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
-	/* for SRIOV, guest should not control VCN Power-gating
-	 * MMSCH FW should control Power-gating and clock-gating
-	 * guest should avoid touching CGC and PG
-	 */
-	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
-		return 0;
-	}
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		/* for SRIOV, guest should not control VCN Power-gating
+		* MMSCH FW should control Power-gating and clock-gating
+		* guest should avoid touching CGC and PG
+		*/
+		if (amdgpu_sriov_vf(adev)) {
+			adev->vcn.cur_state[i] = AMD_PG_STATE_UNGATE;
+			return 0;
+		}
 
-	if (state == adev->vcn.cur_state)
-		return 0;
+		if (state == adev->vcn.cur_state[i])
+			return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_3_stop(adev);
-	else
-		ret = vcn_v4_0_3_start(adev);
+		if (state == AMD_PG_STATE_GATE)
+			ret = vcn_v4_0_3_stop(adev);
+		else
+			ret = vcn_v4_0_3_start(adev);
 
-	if (!ret)
-		adev->vcn.cur_state = state;
+		if (!ret)
+			adev->vcn.cur_state[i] = state;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 0e70df04ceb9..2092360e133a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -305,10 +305,11 @@ static int vcn_v4_0_5_hw_fini(void *handle)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				(adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
+				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
 				vcn_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
 			}
 		}
@@ -1534,16 +1535,18 @@ static int vcn_v4_0_5_set_powergating_state(void *handle, enum amd_powergating_s
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
-	if (state == adev->vcn.cur_state)
-		return 0;
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (state == adev->vcn.cur_state[i])
+			return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_5_stop(adev);
-	else
-		ret = vcn_v4_0_5_start(adev);
+		if (state == AMD_PG_STATE_GATE)
+			ret = vcn_v4_0_5_stop(adev);
+		else
+			ret = vcn_v4_0_5_start(adev);
 
-	if (!ret)
-		adev->vcn.cur_state = state;
+		if (!ret)
+			adev->vcn.cur_state[i] = state;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 6b38927024d1..045ac9c8d8be 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -269,10 +269,11 @@ static int vcn_v5_0_0_hw_fini(void *handle)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				(adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
+				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
 				vcn_v5_0_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 			}
 		}
@@ -1261,16 +1262,18 @@ static int vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_s
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
-	if (state == adev->vcn.cur_state)
-		return 0;
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (state == adev->vcn.cur_state[i])
+			return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v5_0_0_stop(adev);
-	else
-		ret = vcn_v5_0_0_start(adev);
+		if (state == AMD_PG_STATE_GATE)
+			ret = vcn_v5_0_0_stop(adev);
+		else
+			ret = vcn_v5_0_0_start(adev);
 
-	if (!ret)
-		adev->vcn.cur_state = state;
+		if (!ret)
+			adev->vcn.cur_state[i] = state;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 449925105889..86001682e13e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2112,7 +2112,8 @@ static int smu_hw_fini(void *handle)
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
 
-	adev->vcn.cur_state = AMD_PG_STATE_GATE;
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		adev->vcn.cur_state[i] = AMD_PG_STATE_GATE;
 	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
 
 	if (!smu->pm_enabled)
-- 
2.34.1

