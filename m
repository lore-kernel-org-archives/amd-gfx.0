Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C13C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 18:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B92910E432;
	Fri, 31 Jan 2025 18:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oFzlvvK3";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68ACA10E423
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 18:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quRe7NFmTTjiXp3e8vWF3RG2HngGtwjlimi3WFv+8PhdniP7uvd9qvh6B0m5BnUAsuhCN+oV1QDFeLnNuFHMcCxnNSVXrdJzkY9s7hwYgZSuuvZngz0qEeS8UyJbX9oZho/rN9Y3TyAm4Lcpm+1ZBTTgtrjW0rth2fK/cnasGv1smSYAn8OXKt2dMahuTO1OV0lhcJWTGACzMMft5tQJq9Z9wAO3yOHlVda0k6gUSz1vsHJaO9uF37kXxcceFgjy6GogNxCjiw+EgPgRqaamHJudwCI/gDGGlzRUrVwsiM9Y9wcDsmtEOdvwLvyljzuKZA2LjgySzBHawcpeFVDUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84ZogmJdeOPw/gGemOGEKUlOe3k/yEnmNbMWmjp2CB8=;
 b=KXnCD3czFrn1wVkwbR17QWcvh2Zrd9rEdNywicav9zijowUkx/pXWKTzRPwY1vWNKJ96hgrzZ/W/mYgbEp0UbavftqQqFUIdtgDBRuis2y5Mn83Tk5N7cjk0PEWeSt8F4iLRff14aImQCfgPAfr7gtb2uYSlKyvf9Zr68lBBZ13rE9m7FUaSiYj2Npckn7rSSVhTb4P1LH0kxLYU8vS1wOPOnHujml7EU+NTxc3NBetUV3YRjhDQ8+1Weg7AY+Mq14mFMOXkHArNUHDlW8YiIYa8Blq91CueoHtoVxS87oLhoroVC51ckDq/vJ0RlRDHw2n3cc/WNO6wRblaIEyQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84ZogmJdeOPw/gGemOGEKUlOe3k/yEnmNbMWmjp2CB8=;
 b=oFzlvvK3cJiY87AdoygaFi1OH9Ogz/9GCDbQmKoC5qtr4GE72zxiMj9UGsU1SQlst3yOR9603D7/ARaTp1CD8g/pUTxiNWw2r8L38aL2BvyF9BthTRJ9KZAQ8qpr5zSV1iO3fHnGeVjlelWYwy6I2PNbeVu2602bdtsPUF+L5TU=
Received: from BN9PR03CA0118.namprd03.prod.outlook.com (2603:10b6:408:fd::33)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 18:59:20 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::e0) by BN9PR03CA0118.outlook.office365.com
 (2603:10b6:408:fd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Fri,
 31 Jan 2025 18:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 18:59:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 12:59:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>
Subject: [PATCH 2/4] drm/amdgpu/gfx: add amdgpu_gfx_off_ctrl_immediate()
Date: Fri, 31 Jan 2025 13:59:02 -0500
Message-ID: <20250131185905.2074016-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131185905.2074016-1-alexander.deucher@amd.com>
References: <20250131185905.2074016-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: fecc7467-d81d-4622-a58b-08dd42295eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmRqTzVDZWdHNkhXQk5xdWh0ZHJpdnoxNXk4WC9vRmY2VFIreGxhaWx5ZmhM?=
 =?utf-8?B?Y0c5aW5heHJaVHBKSFF5a0kwYmNTZlJZMHFySDRXSE0yMW1wUDZFMHdIcmR2?=
 =?utf-8?B?VDdGdU9RdGwvelN2aWxnUktta3k5bmg1cmNrSytvNi85VVhrY3BJWmdRL1RJ?=
 =?utf-8?B?L2lrM3BzbFZpbjdVSFA4WGxOaFVMNUFBek40VWJVVXFHTWVzWEo1YVhESkFC?=
 =?utf-8?B?U3JwL1V5SDNVZHVGSjlWQ1RhdW5BT3BxcEk3ZFYwOVNiK3dpcmNWR2lxWEF6?=
 =?utf-8?B?dGg5aUt2dWpoUU1EeUlDUlBNbU9zclRmMmxraGxFaEh4VU0zdDlZdEZ1VnBH?=
 =?utf-8?B?L0ZuSzBxNXBhcUgzWG9XcUFOd3Iva1BtS1ZSZzIrdkpUNUMvU1RDbzBtUERq?=
 =?utf-8?B?NGlEZk9sSUp6aklRVmlrcDVJOHJkNXQraGpBUi83MXoreEMvamVCNStrTjdt?=
 =?utf-8?B?VmdIMG8ydXVrN0JETFdpR2dnSDgrc0ljaURjLzBDaFhyLytiSkdvLzdlU0t0?=
 =?utf-8?B?MjgwT0p1QTRHY2ZMOXNVdHkvMlhVa3FLRXMxUGtWVmNoQ3FnWXp4MG9lYmR5?=
 =?utf-8?B?SUNSRkRiVkQ2NzdmK1R6d3JNamFFTnU3bDhuQXN1aTFYR24wUm5iQkdhQUcy?=
 =?utf-8?B?OUEwTVMweTg3c3pDcnBKb08rUXJERzAxdkg2bENqYlRQYXh1dFJ5QzhtMlVY?=
 =?utf-8?B?ZXRwNXp3OVFhS0pzR05qcTZ0NEcwZytUOVN2bU1ocUNoNTNVc1lrV01uMklG?=
 =?utf-8?B?KzZ0UVFGSHBqNzRMWWxiVGNGSGt5ancwSEFmcW53aFUyUlBFY1I1T3JKdExQ?=
 =?utf-8?B?amdlMnBqb2VFeFl5MkNKWld1bGFCSSsxRXZYQ1A1WkJnSWdEVXVKV1JsNTY5?=
 =?utf-8?B?c2t0clZKaXBuZmEvaFduUitWZGJwRjNjbm1vOVh5UUtwUkpheHo0eHFoVUt0?=
 =?utf-8?B?TmtKVUp6TWFzVGFLUWlLZGhOVkdCSUI3UUQwcDZOeTUyYXZVSkZOTXR6b2x3?=
 =?utf-8?B?YVFnT3R1NEhRbGxKaU1uUVpReVVpVlJNY2FWOEttUnBkRkNiTUo0b25admp5?=
 =?utf-8?B?cjF4cDVTWHhDRFFiNDI3ZVMwbjVkWlRTMFFacGJ5aUF3MlhIeUVwV0hwem5i?=
 =?utf-8?B?L1pZc0ZUbmVUWGMyWnh4Njl2OE9JbXdLWmlSKzd3QmZIQ0d3VVFrM2d5K3dI?=
 =?utf-8?B?RnFUa09pd01sVTM5cFVEdktkUFJEVDBRM0Zra2FuNCtkS3B3YkM2ZEdnLzZL?=
 =?utf-8?B?WG1YVnZTekhvQmJRN1VIUnZsN3BQVENkRGUwVUl0RTFGQTY3alFuUjcyM01B?=
 =?utf-8?B?VU44ck9jRU9wczhYMjV1TlhxYzgxdFVtSFpHSHQvOGl1eTJFTDRMUzRBYjc2?=
 =?utf-8?B?amFRMGJmSUVFLzZwMkFwWnZVZUQ1bCtnQlNXZFYyckh6OU14bGZ3Vk4vaHpr?=
 =?utf-8?B?TnNUYXZrajRsak85UmVMQWxzdTVESncwODZJbHJYU0pmZDUveVdRMmxpYTFa?=
 =?utf-8?B?R3NaME1hS2NPNURCZUlqaU5IQWUzeUgvRDQyZU9HeWZXMUhvcTY2R2s2TFZ2?=
 =?utf-8?B?eURac3NWc2UvRXRTcU1DZXBsNExVSUpONVhXcnp1ZnJ0R0M2RUNCQkpjcXFy?=
 =?utf-8?B?OE10cTdRYWxSWWpQckNnck55WkdkSkZ3K29ib0J1a1JuYVFHclM4SjNZUEhm?=
 =?utf-8?B?Vkg4ODdEQ1RFU1hjNTBoN2hFdFJ2YkRTNGJ3WGNDcnU1cW81dVk3TkQ2NnZQ?=
 =?utf-8?B?QTZPeENESGlGdFgwNDFrbEZBSjdDcS9PcS9VZTl0b3VFV25ucHdGamhIZjRX?=
 =?utf-8?B?cGttOXFiSy9WczgzU2FmcUdJa05CU29lTDR3eU5jRm95Nk5Oc2kzSmlCbk9V?=
 =?utf-8?B?UUUwR3M3S0dmOVJuQmRha0VaS1gwZFBTY09yL2l2dVV4aW85TlRGbm9Jc1M1?=
 =?utf-8?B?QkJqL3gvTGd2NmRNMDllOWRaRitUOENLNExYc2FiN0ZmNm1SU2tlN25ZZlFT?=
 =?utf-8?B?MGRzMnJSVVhBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 18:59:20.5842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fecc7467-d81d-4622-a58b-08dd42295eb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
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

Same as amdgpu_gfx_off_ctrl(), but without the delay
for gfxoff disallow.

Suggested-by: Błażej Szczygieł <mumei6102@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 53 +++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 645efe002d068..27f5318c3a26c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -771,18 +771,8 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
-/* amdgpu_gfx_off_ctrl - Handle gfx off feature enable/disable
- *
- * @adev: amdgpu_device pointer
- * @bool enable true: enable gfx off feature, false: disable gfx off feature
- *
- * 1. gfx off feature will be enabled by gfx ip after gfx cg gp enabled.
- * 2. other client can send request to disable gfx off feature, the request should be honored.
- * 3. other client can cancel their request of disable gfx off feature
- * 4. other client should not send request to enable gfx off feature before disable gfx off feature.
- */
-
-void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
+static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
+				   bool no_delay)
 {
 	unsigned long delay = GFX_OFF_DELAY_ENABLE;
 
@@ -804,7 +794,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 		if (adev->gfx.gfx_off_req_count == 0 &&
 		    !adev->gfx.gfx_off_state) {
 			/* If going to s2idle, no need to wait */
-			if (adev->in_s0ix) {
+			if (no_delay) {
 				if (!amdgpu_dpm_set_powergating_by_smu(adev,
 						AMD_IP_BLOCK_TYPE_GFX, true, 0))
 					adev->gfx.gfx_off_state = true;
@@ -836,6 +826,43 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 	mutex_unlock(&adev->gfx.gfx_off_mutex);
 }
 
+/* amdgpu_gfx_off_ctrl - Handle gfx off feature enable/disable
+ *
+ * @adev: amdgpu_device pointer
+ * @bool enable true: enable gfx off feature, false: disable gfx off feature
+ *
+ * 1. gfx off feature will be enabled by gfx ip after gfx cg pg enabled.
+ * 2. other client can send request to disable gfx off feature, the request should be honored.
+ * 3. other client can cancel their request of disable gfx off feature
+ * 4. other client should not send request to enable gfx off feature before disable gfx off feature.
+ *
+ * gfx off allow will be delayed by GFX_OFF_DELAY_ENABLE ms.
+ */
+void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
+{
+	/* If going to s2idle, no need to wait */
+	bool no_delay = adev->in_s0ix ? true : false;
+
+	amdgpu_gfx_do_off_ctrl(adev, enable, no_delay);
+}
+
+/* amdgpu_gfx_off_ctrl_immediate - Handle gfx off feature enable/disable
+ *
+ * @adev: amdgpu_device pointer
+ * @bool enable true: enable gfx off feature, false: disable gfx off feature
+ *
+ * 1. gfx off feature will be enabled by gfx ip after gfx cg pg enabled.
+ * 2. other client can send request to disable gfx off feature, the request should be honored.
+ * 3. other client can cancel their request of disable gfx off feature
+ * 4. other client should not send request to enable gfx off feature before disable gfx off feature.
+ *
+ * gfx off allow will be issued immediately.
+ */
+void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable)
+{
+	amdgpu_gfx_do_off_ctrl(adev, enable, true);
+}
+
 int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value)
 {
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6c84598caec21..ddf4533614bac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -554,6 +554,7 @@ int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
+void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_gfx_ras_fini(struct amdgpu_device *adev);
-- 
2.48.1

