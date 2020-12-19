Return-Path: <SRS0=C/bZ=FX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5131BC3526C
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFF22343F
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFF22343F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A2189CDD;
	Sat, 19 Dec 2020 00:49:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D92FF89C6A
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Dec 2020 00:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atUwcSDKh9nJoglR7j/O7Wkg7UcHonp6bhC8S9GpFgAIweBJIffxoJYOvEpwM4HXKN96924xQ20HTfK06bgoO/msPOj9TdZWbEEFtHCAGkqEAtEGc9i+cSGnYQhxw+yMeiedIh8O0y1VQ+HnPuZUSXmtVrMx5I/jukail0hqiL+FiVGlVCvoLkmAKIHS1G1rqiswQa4z1WECjwhrFtNYKEO23OOq7hgi/zZ3Dhcv7crQZ615GvYjvBh6xPlat5oEMafAGsapfMi6qAtI6+0lwjq6maf9phdOHiOVBi2e/Psx93ySpUo/Hh2XDlHvQeSHBwYwkLgQZdJ6E48xyH6jyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTXlf+MSpZaMoG+8jXnluLOVYmYxv26C7JRAqGHQqyY=;
 b=esAAkhEBpEjyZZTYT8N8KDpA2zsmwBQACzC8mmAmZ9QWkWwckcukz8iytiVh/paMuUDllse/+W1sMUaDe/r1CwKMRtRUKz6GSSXi9tarNQT1NCjQ9+zOW7SA84stWKo3OaTlXN+arS4jB1g2epClqmT2AqmGxhhpVTWALr9fbgnm9sAw6ca4REDpexkLboK4k1FRZu9A7lzyP+6K2yxpqTX6oTVeVJRZfkEjazte8So+BK78260N/vw3nLCjww+W1QWiqWrHJXKaxU4jf26t7Q5NFKEg16ovQfw//0J+/V9Hk+YeN+CWbUGK+JMge6HZT/vfSgrRWcs6cLYz1BNYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTXlf+MSpZaMoG+8jXnluLOVYmYxv26C7JRAqGHQqyY=;
 b=CX7Xx9aIEGySdhnRNMcEkB27lVrChuwoPgFuJ+r4jQtdr2Gd9CiA9J0lL0/jkFQ6z/0QMK26l06SCN+u3M1Z39B5wmZQQtfL301i/4tTQ9JdnTloVKxudYeKnRhQPcZjZQ5KkQvHdubsYLHV8HuSFCKYv8iYU+237bnomP+4Dhc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2959.namprd12.prod.outlook.com (2603:10b6:208:ae::29)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sat, 19 Dec
 2020 00:49:08 +0000
Received: from MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804]) by MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804%7]) with mapi id 15.20.3654.020; Sat, 19 Dec 2020
 00:49:08 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] amdgpu/pm: Powerplay API for smu ,
 changed 5 dpm powergating & sensor functions to use API
Date: Fri, 18 Dec 2020 19:48:28 -0500
Message-Id: <20201219004831.13527-6-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219004831.13527-1-darren.powell@amd.com>
References: <20201219004831.13527-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To MN2PR12MB2959.namprd12.prod.outlook.com
 (2603:10b6:208:ae::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Sat, 19 Dec 2020 00:49:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f157c20-0993-4f80-206e-08d8a3b7e4ba
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32793B4FB0B90C1CD7DD3E68F0C20@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9Pf//wyUzxBcsDYYAV667qvaKKdQxNCnz5FvtDZuZ0iVr+1f6PvztdM5Cwj+yMhe2UNZEC1Z09SNcJ5UfX+YnybxzOeeu1mL1B7KPHNsTrpxWbZhgfK0xGJtUuDPkMXFcVbtqZTmeGPNmVZTGw0sCEMrwSNvBs5W8U/7C/3pq5H0nxGA8J40326dBI5IeMqMJ8eQwCdg2T0NWxClDM78mrBqfhWVjKDWuzGPnNallPVN8gnf/5nCUY6jKE+W0l4EzSaVD+AWHG/Tfg8pRWqLiGEzEHzXvUqlF9sKplsgQOgIdq9CEALkmmN17EYYKxlU8xSW3IuYj9R66pLd/Anf4ox5tW+Dcy8+uo/agWxIuF2zIWUo9Sy1bSjTUxGKIap
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2959.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(956004)(2616005)(44832011)(26005)(66476007)(66946007)(6506007)(6666004)(86362001)(66556008)(5660300002)(69590400008)(36756003)(1076003)(83380400001)(186003)(316002)(16526019)(52116002)(6916009)(2906002)(4326008)(8936002)(6512007)(8676002)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?craajU0IML2GNaAGJ22nO3kh2tsdwXuXNTHVy2NHMp8Vm9566px2kHLkA27r?=
 =?us-ascii?Q?EhyKfJ0uDv7K1M2ufy/9vzWNU5wVmuZfkkQEZMYeiNWaDfm9TZkV8Tf22Xiz?=
 =?us-ascii?Q?jYxFni3M6e4rZBdVkvmspRz53C/PuqbecpbXoo0CYxjQw1s2Kw3rYoLdPYX4?=
 =?us-ascii?Q?xQwh2pl2u0Y4L0oTraAsR10xQRXqAfCUiUyZI+VsyGeqgwO64lCU1AQAwAiq?=
 =?us-ascii?Q?Jk9uazBbnuTjiVdzly1AaAU5Uy7PuMqi/MdI/T7a553NRDEf1ocDamhfwulA?=
 =?us-ascii?Q?jAISzwOc5CSoPySN608Q8v208mS9yHTB21dLFrM3Ucdj/Fu6wG5pPVkxoqIP?=
 =?us-ascii?Q?VaOKLgg32j2yBI2pCBh/rH++5pL+rtwqq2EtW8CyqoWztFt9uGrRsWO9QNa4?=
 =?us-ascii?Q?bjRmEUCwREiIpHXrHG5RxNe0u7xvW/KaUK9gaMGNNHU3M6JRuUcQBgiZBzWP?=
 =?us-ascii?Q?ecPxFeRYt2xeu7MRYLNYUoT8rkD8IHJug9XBGGfT/NQEZwIRP+QxeGQjFKti?=
 =?us-ascii?Q?yiDoI/JIs6YQsIg5G8JVT32dJVrNhFJz3cgHfGLRmE5JM4w8Q5Q5BPVF1xGH?=
 =?us-ascii?Q?kg6Z2fqR3iNBP1vltFPda5K0V/6mrPOMRjYdoKtht6842gZpBcZor2ZCeQnP?=
 =?us-ascii?Q?Z/IbQGi/komQKRijTRX5wp30GfwFg+fdauCpIz8s+p2SFhu0nY308OzwKFO6?=
 =?us-ascii?Q?q8BsB3udzrL2feen+8GbjvQEuaDnNcrPeKc3hcV5z03TPpOTYgxi+IhFhE25?=
 =?us-ascii?Q?rrBP27Cn1JeoOP+X/MudCpA6VQLNOMZwZbhj+8FRg6UCN4b6zQW4MNMXz3K3?=
 =?us-ascii?Q?mrJE+f/69PrwyA7uIhe5Rz6aDNsDaBW+fC/3znwenh1Ux+oMxsKUwoOJ9+Nd?=
 =?us-ascii?Q?RGJY8PVZcrwwd31n19sdstTeXOc6UUqC8A+4N/JgIpTAkTBiznfLpoPS7r7T?=
 =?us-ascii?Q?d55RhQtcVTDnokL4H03snXntA9OKSAB9zUyWIj9OV5i12SAeM4GwhOLK5Mjp?=
 =?us-ascii?Q?rLM3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2959.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2020 00:49:08.3701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f157c20-0993-4f80-206e-08d8a3b7e4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzt+JvKWjSuWGmVfvsoAhxY3P+0l43/jD63a0hdXVlVPZV1gbhmGwzjLxoMQg7HegEk6S34l3VTm7wgzepxSzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
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

New Functions
  smu_get_baco_capability() - Implement Powerplay API get_asic_baco_capability
  smu_baco_set_state()      - Implement Powerplay API set_asic_baco_state

Modified Functions
  smu_read_sensor() - modifed signature to match Powerplay API read_sensor

Other Changes
  added 3 above smu Powerplay functions to swsmu_dpm_funcs
  removed special smu handling in 5 dpm functions and called through Powerplay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 86 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  7 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 72 +++++++++++++++++--
 3 files changed, 100 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index df5e7b573428..8ae2df82addc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1019,18 +1019,13 @@ int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_baco_enter(smu);
-	} else {
-		if (!pp_funcs || !pp_funcs->set_asic_baco_state)
-			return -ENOENT;
+	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
+		return -ENOENT;
 
-		/* enter BACO state */
-		ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
-	}
+	/* enter BACO state */
+	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
 
 	return ret;
 }
@@ -1039,18 +1034,13 @@ int amdgpu_dpm_baco_exit(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_baco_exit(smu);
-	} else {
-		if (!pp_funcs || !pp_funcs->set_asic_baco_state)
-			return -ENOENT;
+	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
+		return -ENOENT;
 
-		/* exit BACO state */
-		ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
-	}
+	/* exit BACO state */
+	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
 
 	return ret;
 }
@@ -1074,20 +1064,15 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 	bool baco_cap;
 
-	if (is_support_sw_smu(adev)) {
-		return smu_baco_is_support(smu);
-	} else {
-		if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
-			return false;
+	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
+		return false;
 
-		if (pp_funcs->get_asic_baco_capability(pp_handle, &baco_cap))
-			return false;
+	if (pp_funcs->get_asic_baco_capability(pp_handle, &baco_cap))
+		return false;
 
-		return baco_cap ? true : false;
-	}
+	return baco_cap;
 }
 
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
@@ -1105,32 +1090,20 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_baco_enter(smu);
-		if (ret)
-			return ret;
-
-		ret = smu_baco_exit(smu);
-		if (ret)
-			return ret;
-	} else {
-		if (!pp_funcs
-		    || !pp_funcs->set_asic_baco_state)
-			return -ENOENT;
+	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
+		return -ENOENT;
 
-		/* enter BACO state */
-		ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
-		if (ret)
-			return ret;
+	/* enter BACO state */
+	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
+	if (ret)
+		return ret;
 
-		/* exit BACO state */
-		ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
-		if (ret)
-			return ret;
-	}
+	/* exit BACO state */
+	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -1272,20 +1245,17 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size)
 {
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
 	if (!data || !size)
 		return -EINVAL;
 
-	if (is_support_sw_smu(adev))
-		ret = smu_read_sensor(&adev->smu, sensor, data, size);
-	else {
-		if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->read_sensor)
-			ret = adev->powerplay.pp_funcs->read_sensor((adev)->powerplay.pp_handle,
+	if (pp_funcs && pp_funcs->read_sensor)
+		ret = pp_funcs->read_sensor((adev)->powerplay.pp_handle,
 								    sensor, data, size);
-		else
-			ret = -EINVAL;
-	}
+	else
+		ret = -EINVAL;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 8471b42587d3..739d645df7ef 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -668,9 +668,7 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size);
 
-int smu_read_sensor(struct smu_context *smu,
-		    enum amd_pp_sensors sensor,
-		    void *data, uint32_t *size);
+int smu_read_sensor(void *handle, int sensor, void *data, int *size);
 int smu_get_power_profile_mode(struct smu_context *smu, char *buf);
 
 int smu_set_power_profile_mode(struct smu_context *smu,
@@ -699,11 +697,14 @@ int smu_set_xgmi_pstate(void *handle,
 int smu_set_azalia_d3_pme(struct smu_context *smu);
 
 bool smu_baco_is_support(struct smu_context *smu);
+int smu_get_baco_capability(void *handle, bool *cap);
 
 int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state);
 
 int smu_baco_enter(struct smu_context *smu);
 int smu_baco_exit(struct smu_context *smu);
+int smu_baco_set_state(void *handle, int state);
+
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index caed6a10ccd4..48b6e46a9702 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2003,20 +2003,23 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 	return ret;
 }
 
-int smu_read_sensor(struct smu_context *smu,
-		    enum amd_pp_sensors sensor,
-		    void *data, uint32_t *size)
+int smu_read_sensor(void *handle, int sensor, void *data, int *size_arg)
 {
+	struct smu_context *smu = handle;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	int ret = 0;
+	uint32_t *size, size_val;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (!data || !size)
+	if (!data || !size_arg)
 		return -EINVAL;
 
+	size_val = *size_arg;
+	size = &size_val;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->read_sensor)
@@ -2061,6 +2064,8 @@ int smu_read_sensor(struct smu_context *smu,
 unlock:
 	mutex_unlock(&smu->mutex);
 
+	*size_arg = size_val;
+
 	return ret;
 }
 
@@ -2341,6 +2346,27 @@ bool smu_baco_is_support(struct smu_context *smu)
 	return ret;
 }
 
+int smu_get_baco_capability(void *handle, bool *cap)
+{
+	struct smu_context *smu = handle;
+	int ret = 0;
+
+	*cap = false;
+
+	if (!smu->pm_enabled)
+		return 0;
+
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
+		*cap = smu->ppt_funcs->baco_is_support(smu);
+
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+}
+
+
 int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state)
 {
 	if (smu->ppt_funcs->baco_get_state)
@@ -2393,6 +2419,41 @@ int smu_baco_exit(struct smu_context *smu)
 	return ret;
 }
 
+int smu_baco_set_state(void *handle, int state)
+{
+	struct smu_context *smu = handle;
+	int ret = 0;
+
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
+	if ( 0 == state) {
+		mutex_lock(&smu->mutex);
+
+		if (smu->ppt_funcs->baco_exit)
+			ret = smu->ppt_funcs->baco_exit(smu);
+
+		mutex_unlock(&smu->mutex);
+	}
+	else if ( 1 == state) {
+		mutex_lock(&smu->mutex);
+
+		if (smu->ppt_funcs->baco_enter)
+			ret = smu->ppt_funcs->baco_enter(smu);
+
+		mutex_unlock(&smu->mutex);
+
+	} else {
+		return -EINVAL;
+	}
+
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to %s BACO state!\n",
+				(state)?"enter":"exit");
+
+	return ret;
+}
+
 bool smu_mode1_reset_is_support(struct smu_context *smu)
 {
 	bool ret = false;
@@ -2577,6 +2638,7 @@ static const struct amd_pm_funcs swsmu_dpm_funcs = {
 	.get_fan_control_mode    = smu_get_fan_control_mode,
 	.set_fan_speed_percent   = smu_set_fan_speed_percent,
 	.get_fan_speed_percent   = smu_get_fan_speed_percent,
+	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
 	.get_current_power_state = smu_get_current_power_state,
 	.get_fan_speed_rpm       = smu_get_fan_speed_rpm,
@@ -2590,6 +2652,8 @@ static const struct amd_pm_funcs swsmu_dpm_funcs = {
 	.set_mp1_state           = smu_set_mp1_state,
 	/* export to DC */
 	.enable_mgpu_fan_boost   = smu_enable_mgpu_fan_boost,
+	.get_asic_baco_capability = smu_get_baco_capability,
+	.set_asic_baco_state     = smu_baco_set_state,
 	.get_ppfeature_status    = smu_sys_get_pp_feature_mask,
 	.set_ppfeature_status    = smu_sys_set_pp_feature_mask,
 	.asic_reset_mode_2       = smu_mode2_reset,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
