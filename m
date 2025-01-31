Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0413C0218A
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 02:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD1110E154;
	Fri, 31 Jan 2025 02:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ak+KM9m";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588C410E154
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 02:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3wa91t6mwb3T5NLrnkTNMTwzliVTiRfW4Skz4JOsetXaUyyrdWr/kwi6Lg0Eq3+kPIv2KG8HiF++zyH7+8D2JLUG2kGx1zX9UVCCdgzIU2SQyIBRTGfoBz5SZbTlpQ7S4x/j79ItQ8wXXRMNEm41Iauf4EH7ZhNw9dsuQ67i/v+2JKNgKxW8e+D4htYnV4lSBmvGNV2/EHxcLIOV4UkFFp7QOER+bWeRThmTRb/AcqDhc5xKcIQkbKJ+j69rLhjicTERenkw0KgWaQmXag4G7oIImzLkd3xmgaXmZxTKsm1b0rBdtEDY6N6Z2rpmTCGc08j9cOiP5zo4xY6yP+ttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84ZogmJdeOPw/gGemOGEKUlOe3k/yEnmNbMWmjp2CB8=;
 b=nWerZsrxmM+FXgVlzMej46TS7mFOd0D7y+hxA6mu2pjLq3P0nynzvJbRogY96BJBPrrRWtUNqSeY9FMKpnC3iHtSpaM/d+b3/0r1fHxCBz0xSA3WLFvZIwLzcHATypcQP4+0AdB5/uZRgIwNJ3goHgkuPxR3Im6SNhE5/EXfXvV67C9GlFHou175mFIm/mKSY3e2Ya34QU8jkSJ4iup5QU0y9+WA5laL9ENyvBeiVawxgswRUl9oUD5lGKIWFOrXzt3kkUYtXBlA+rndVdkc7YtjtW1HX7qqEMyq/TydzBMJmlluVpvsKM+jtvq/ZVmdYXarEzsSPbsJ6ayID64wCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84ZogmJdeOPw/gGemOGEKUlOe3k/yEnmNbMWmjp2CB8=;
 b=1ak+KM9m40+8axp+E6Lt+CowWuWIdVRIXtFFfHdFqRYSTTjElh2HcMovv6xx0CHbHzIIISKotGYACzbGDIquC/2LU1DHkmpEtpnvWIsr2P5oqcoIaxSzoNyHzEF9+eYkzZKGiwhIFUzGVH35d6jO9rhhIfvAbY0yyz9qh1NPAf4=
Received: from DS7PR05CA0051.namprd05.prod.outlook.com (2603:10b6:8:2f::12) by
 DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Fri, 31 Jan 2025 02:32:21 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::ae) by DS7PR05CA0051.outlook.office365.com
 (2603:10b6:8:2f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Fri,
 31 Jan 2025 02:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 02:32:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 20:32:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx: add amdgpu_gfx_off_ctrl_immediate()
Date: Thu, 30 Jan 2025 21:31:51 -0500
Message-ID: <20250131023152.1188183-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131023152.1188183-1-alexander.deucher@amd.com>
References: <20250131023152.1188183-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3151d8-c9b3-440b-280d-08dd419f7d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmd5V3RWY2lLcXpLWDBuaWczOTY2bWlaQXpKcVJvS01RR0M4cUdKUS8zc0tv?=
 =?utf-8?B?b2trVzFhUkdRY0p6L0QrbkkyQTBicVM1WG9tZ3RNa2NmMFQ0NkZjb1pwQ1Jt?=
 =?utf-8?B?bzQ5V2ZYVUNuQnNkTTJiNDUyczdwYVhlUTEya1Y0ZXBFdkhoUHV1clRSQ1Vu?=
 =?utf-8?B?ZWlwaU1QdGFuNjgyU2pzNEdSM0FrNG1ZcE9zRnF1d0MyTkJKOGsxYXk2YWdv?=
 =?utf-8?B?Y2QwZmE2d2I3TkhSK0dXSmZOYURKd1Bzc2RrM3J2VS91eGVZb3hzT2lEMTlt?=
 =?utf-8?B?SmtUMFpDbTBMeHg0QUtRUHVaaitIQ2tUS2dIZno1K1Z5WFlzYXRTN1RsVWNZ?=
 =?utf-8?B?MGsyTmNxZjdMaU9UTktZTVc3WEw1aDhDaXZPRDNPME4xN28wYzk1Mk1acG4x?=
 =?utf-8?B?YVYvcjhQRVR5UzI3OUJ4SVBVVGU0cVVwY1JUdHhUOUZwR2VydlBNK1JSeWIz?=
 =?utf-8?B?RVFKUnBpRmk1THo0YkpoZFh6VUNuQnB4NWhVOWgwQ2hsR2JseEdKbmhabktO?=
 =?utf-8?B?eTdmV3NaOHNaZDRzeTFxVTN4REdROFhLU2JONnM3ajBrSEFCaGNza2t1dnFL?=
 =?utf-8?B?ZnJpelJYbnY1OE9OakR1MWR4enlubWROMURudHhqcURxdDVxRFhCZWRCaXFF?=
 =?utf-8?B?Tzh5VktJYXVIMmNRS3paMC9VbjlOekNvdkdlbXJWcXBySVU2MUpuYlY2eGhE?=
 =?utf-8?B?RWUyNVhYOEFjT245VW1JMjBxajR2Y3ZwSkM5a1R5bG5yK0pCWEkwSGI5NlRD?=
 =?utf-8?B?TW1DVXlQNmJ1STNjYmsvdnkxYTFKUkNPN1BWNkxKb3ZlWXc0K0lncnZLMkNI?=
 =?utf-8?B?OUtGTzBHNXFab1VpbmpLYnZndCthMzBobzhWajFqUXMvRGxEOTRwcGlHMmZJ?=
 =?utf-8?B?MjRyQkRUdzdOMFRpeFlSKzd0RXVPbE9IbzhoYjFsdk1JcjFZQy9STFBua1Y1?=
 =?utf-8?B?UHY0TDkyMkJtQjF4SVBNRmpGWXJIZjRvRTVmcTA2OUVvdXJMMEpCWnRSa1FO?=
 =?utf-8?B?MmJOWDBTYWw0OFoxTzBUZkxVbWd4NE1xWktHRkNBZVVad3doTmMzQlZvaGt1?=
 =?utf-8?B?YUdHTytZbW9CT1dJQ0NYNHdHWUJHQk53ZjZLYzRPRXEwbzZEOGNnSXVJeFF5?=
 =?utf-8?B?V093bW5DR3ZQcXlKSDN3aS9Oemh6ZXNjWUsva1A3cTR0YmUyQ2xmT3JyMXBr?=
 =?utf-8?B?Z0NqT0RBWXdqQjJqMHJvajYvZnVWbkRXcUxnMjdLbVQ2eE9uZUljTW5YcWo2?=
 =?utf-8?B?d0k1K1ZQZFhpUFBEU1dVdGdyYnp4UkZ1a21SMW40WGpkeVplNHJ1eXRYNm9k?=
 =?utf-8?B?RCtYSnBvTUVTV1VyV1JQZVJSV0FMWlRUZ1htbFlxUm10MVE0UEZmbGlQS29l?=
 =?utf-8?B?RnRqWnlOa3hZYS9hSzdQcC9acm5nWU9zVlQxTjllYUVPcHU0Ymphb1FsZDZF?=
 =?utf-8?B?bnhTanpFd05lVXJpZzhpdElhYzg0Ym5yTWJ4VDNJQ09TVjA3N25kY1hSQ2RE?=
 =?utf-8?B?NVJhVnRWQzE3THBIaStNN0FCSEhxWWdpMVpFWng4ZElXM2FiVHBwa2dvem9D?=
 =?utf-8?B?c1pRb2NQQ3NGNVRPZ0NrTEMyeGdpMHlZTzVQSGQwc3hJUm5CMWVmL24zM0pW?=
 =?utf-8?B?YktMVVdmVjV6ZEsyeCtrUlBJZyt3akdlWFRnN2h0U09WdzhOUU9xelQ4ZG80?=
 =?utf-8?B?WnRlQmoydTdzOFRaaHlEYTNleUZKNWozQnBWcnNxNXJVU0w3eXhCaXpuamE5?=
 =?utf-8?B?MnB4UXZPSUQwSjk2eVBHeHJObUlkdmNrZ1lOQlFidEJ6cVpGZU5EMERpUGlW?=
 =?utf-8?B?NXU5TVorYTh2TUlvczE1RWFUY0dDS1lBSGw5SXFnVWlJdDVRS29CMkpRZUI0?=
 =?utf-8?B?bnBjR0dKWk9mSnpncGpTaEZYcTl1QmE3N2lpT0EvcHZreE1qcENQQnN3R2t2?=
 =?utf-8?B?VHo1ZWdiZW5NT3pKTTVkTmIvTkgzRXlGaGxCUng5a09LSW5iaDJrdU9XV0ZJ?=
 =?utf-8?B?V0M0UmhjalVRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 02:32:21.6737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3151d8-c9b3-440b-280d-08dd419f7d83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295
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

