Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ED1CA0EE4
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Aug 2025 09:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599EB10E08B;
	Sun, 17 Aug 2025 09:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g5LKyShr";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 785E910E08B
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Aug 2025 09:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ups0mWXrhMdxQGcjv3QXGtFnszWDduUx457/U8a6PcSBuqJ72Hw7VFhWzAWL3lEqEltXF/TACaLpyK77liLCtKpBiZdkEfTwtQfVoKeLcAVR+J16SkN5blRC+d1PFY8G7NCndvUGSYBH1vPDtnhs7LNqSPcVG7VCskSSIQPMDu/omkd1+j+ogyuJUA2BBeYfY5ulK5rPHaj2w88YhZRxtqyuRLYDGWTVzaKnPqys0QfDsYJZc6JEGK1mL0c5wBxkeU+v/v9LygM5wvVroYtomcncaXtezTMQbQL1IU3FudFKG7beCBvaGEE2biMp1NvG4pZnYs32JN5McKQrwVa5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD32/zW7Kjxl3FAETHcMQBVTzZfyDT5Fy6M/5rw5WOg=;
 b=aqvAXNZZFlUl+g7mgi/G/+/9MUg+/SKCNCh556kEtWnNWc3q7euN+B4Uy3eRPOx2n2HzR+uLkpzBmXN7iPIMR7+X45x0P87E01E3rdn3hr2UFPmUbcCROndoVRASz8q85FCjH8umUVCrau/zsZi8OTZsXhbFdRVlgrfOXpEF8KlrKtG130gYYUYzMfqm68Yqsqm3xug6mj9eZNZ/dVz9jV6q9bBkTcQoL30V2oYVy3cUWaxtKOrkY6K30p3DxsV9l8FEPbh+UDVBfiC4vVJ+zZZVJTKomEQHaCmrjtv4Amcn+C/mxznQNuesEMqlJNpt8ruEMAELYKD6mXOo6KWUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD32/zW7Kjxl3FAETHcMQBVTzZfyDT5Fy6M/5rw5WOg=;
 b=g5LKyShrFhZDJ5lbVbn3xEdexLgIVbIZWuzAXDDk0Oj3KWzuGod6ObV3qlaqUKgDXU2HUv4d8UDypOrbD6Z8zDLAddX7FUj8kRJSNUwGgjoAn9+hIPjatAvv9WxAtbBPI0xVl+Wk1vX9wl+lDoZTiQQBmAaW8+LduiHLHK3JbmI=
Received: from BYAPR07CA0087.namprd07.prod.outlook.com (2603:10b6:a03:12b::28)
 by LV9PR12MB9782.namprd12.prod.outlook.com (2603:10b6:408:2f2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Sun, 17 Aug
 2025 09:13:30 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::bb) by BYAPR07CA0087.outlook.office365.com
 (2603:10b6:a03:12b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.21 via Frontend Transport; Sun,
 17 Aug 2025 09:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sun, 17 Aug 2025 09:13:29 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Aug
 2025 04:13:26 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>,
 Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/4 v4] drm/amdgpu: Add functions to get/clear bank count
Date: Sun, 17 Aug 2025 17:13:17 +0800
Message-ID: <20250817091317.308809-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|LV9PR12MB9782:EE_
X-MS-Office365-Filtering-Correlation-Id: 45fff7b1-fb21-4f6a-3244-08dddd6e54a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qi1sL5EeYiVhS9mgQxmS4z+wPWma9Z2l+CD9EmM1dkXn7ub4z9+xLUbj1few?=
 =?us-ascii?Q?lVHHPmssUdCfdIoT3Bz2WKDl+azhG7ObX4uQPEEjT/q9W8vVoyX/RwFBgeCn?=
 =?us-ascii?Q?lVtnkafOYrLWM4KhV73UveO7mf3DYOVWFK2AwfsipkiiyvGCw6NAGeK8b3/z?=
 =?us-ascii?Q?SgGaoSF8T1x8oOpys6XT1TQmxYvbpQEetBLxabAy/8SVGsEHF8IFRgcGPBm/?=
 =?us-ascii?Q?C1zdUpSM4UhdUPEW2OxHeExQVIqgph4g0TU4NNM9XbqQlRK+nsPShN1BP11A?=
 =?us-ascii?Q?QGTPhdpAHKM9qAagX+78M0N+r+Sw9XVTwEY3uDGkWsPLvoaO3+ReyJHP3pIl?=
 =?us-ascii?Q?yhqipidYAKS1sWSgFeufA+CdaLc1+OI1ZLdRfvDVFo6NnCGepAMncezbeE1w?=
 =?us-ascii?Q?Rj6Jz3hQQ3iYxCFYaXesuqN10+N7g8Of1a4lZ3i20FtSwUYEahG1stu848rx?=
 =?us-ascii?Q?SazoTuAT/lqnhV33u2C9t3Nw2GgkFCeighg1g2VoNJ8xi/Kk13NLXQiYeMGn?=
 =?us-ascii?Q?r4SlmcqTKfr1iusOg6CVtXJWilP4UgNnXf5NC8x/IOJ4aMiBR09xebdiGLVv?=
 =?us-ascii?Q?karim0vTM0Mbvv6Nx7utM6w4VpLEVIuOMj0Lov3iDuUCJ7fhvRepaBG2CUqm?=
 =?us-ascii?Q?7PN3ykKWz4l8f1/Fs5IkszT0TvGS/NVxFlgDyv7DvkJ1xe/NjsGQ2gNWuvnz?=
 =?us-ascii?Q?Py/G62KBeYgh6BXVHla/nybCc+YJvcxE2FAK30PjXJVIJB84jeqiBD7tnV4A?=
 =?us-ascii?Q?68kIitk1oNex8LYVbUcIfFt2/5S76GXFU6qOnwdJJqISUDv988P3EezKX7Yt?=
 =?us-ascii?Q?8EznMKVspb6JqTu8R0UEd024P7mpcBdmq4WGG4kM+jAY+9D6LQFNGpBvT36D?=
 =?us-ascii?Q?NFkNirBY6NCKyq++oVuAo1g/ksX7YCT3CU2BbqhiJ7Koy+QDAKuSeNp/lVtI?=
 =?us-ascii?Q?5Kc/fv+chw7sAQmPGREEiZcuPZSkFZXg5ayAoLpKNsI7Zw/6r1pcF6Y2Pv2Q?=
 =?us-ascii?Q?Fh0fU0VAVp7EKkM7FaeQ4A5o9F2425tgL00J2/HnPpR9OAohVm4EnCnf4Tgx?=
 =?us-ascii?Q?ZOCvbN+xj1sfgNhKi+ccaI0PBXvesFn3aXBJudu9K5VSHKGZEJh31cgAU2IH?=
 =?us-ascii?Q?B645Wdci4rEfLmURRbYaM95krre03AfNFmJqaoxOsad3jElOJudL56xEJh1S?=
 =?us-ascii?Q?32BFLpSnHQEALz2y8F2tj7l6saMvo7tz+EOd6FqAbo/Aimx+3sr6+B36J3+x?=
 =?us-ascii?Q?am/iCtuQGSzgueDm2k8qJ1mIMUIR1knSHijY0iiEoO0sLRTCkfVd9Txwe7gk?=
 =?us-ascii?Q?p5D0ymMpWYvF0MfH9gWRB3dSgsiq3DES2WCqi23JuhOIxK4b1UetT48EEY6f?=
 =?us-ascii?Q?twE6W1wrRy30Cjy/SfamcBpSQ/NC4xZrAfQQ8exUXRH1cRvKWby2z1Zd9wIm?=
 =?us-ascii?Q?deeCDUIGJoerZmbuE3TlYX3Kp+aCfbhum31CnWC3TYGkDAnEfNnqLePmlKEV?=
 =?us-ascii?Q?BAM70kWhYuuFaTMFkbEX3q/kJwICs0WF5xvl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 09:13:29.1454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fff7b1-fb21-4f6a-3244-08dddd6e54a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9782
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

Add the amdgpu_aca_get_bank_count/amdgpu_aca_clear_bank_count interface

Signed-off-by: Ce Sun <cesun102@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 090bf6cf1b91..32164d62c4dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -480,6 +480,8 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
 		goto err_release_banks;
 	}
 
+	atomic64_add(banks.nr_banks, &aca->bank_count);
+
 	ret = aca_dispatch_banks(&aca->mgr, &banks, type,
 				 handler, data);
 	if (ret)
@@ -766,6 +768,7 @@ int amdgpu_aca_init(struct amdgpu_device *adev)
 	int ret;
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 
 	ret = aca_manager_init(&aca->mgr);
 	if (ret)
@@ -781,6 +784,7 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)
 	aca_manager_fini(&aca->mgr);
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 }
 
 int amdgpu_aca_reset(struct amdgpu_device *adev)
@@ -788,6 +792,7 @@ int amdgpu_aca_reset(struct amdgpu_device *adev)
 	struct amdgpu_aca *aca = &adev->aca;
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 
 	return 0;
 }
@@ -865,6 +870,11 @@ int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en)
 	return smu_funcs->set_debug_mode(adev, en);
 }
 
+size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev)
+{
+	return atomic64_read(&adev->aca.bank_count);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 38c88897e1ec..fd0b55469a2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -202,6 +202,7 @@ struct amdgpu_aca {
 	const struct aca_smu_funcs *smu_funcs;
 	atomic_t ue_update_flag;
 	bool is_enabled;
+	atomic64_t bank_count;
 };
 
 struct aca_info {
@@ -225,6 +226,7 @@ void amdgpu_aca_remove_handle(struct aca_handle *handle);
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
 			      enum aca_error_type type, struct ras_err_data *err_data,
 			      struct ras_query_context *qctx);
+size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev);
 int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
 void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
 int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
-- 
2.34.1

