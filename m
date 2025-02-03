Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB4CC02192
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD7210E139;
	Mon,  3 Feb 2025 21:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rq3MXiuL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C0210E139
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+lXCDimRqRTEvXVBwYqvWw+LX7Shc1wl1G3pSXeiUFcz4j/9QrCu2os7hWk2OFGS85svluvSIlBrhNwIX382CJm4ICe0unEwkLqO6FZ6b8WApCCJ+x3/Bh/udtjZoFFfqfLxQefgYHG9O1JDfE9zBn3QuRc8FAdxZRYPtSLO2eA49inXan2Ba0okLSNgNIxBVT9LtVMzs8/I6cqtfW2oXEvFeUKaNr9pMLeTQDV5bpzxfPcEwXkTBkCJe2PuTHhO4VYSCKLNP5UmxICC2brDYt1BbEv3cL7sHKE2+hBLoUYwVPNCTcXMhZ04o5FdeIMGlbY51j5YmPswqs1JBIS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84ZogmJdeOPw/gGemOGEKUlOe3k/yEnmNbMWmjp2CB8=;
 b=EE68i/44rp/kMaOifsbhcN91TcX5dJo8OfMzL1poOsqgryzhaplf/++uFM/r9fWW9Xqk+3jgkjRJrG+tVKREJ3Cbqgl3BCqUjra34ZRrXyw2qGWnA1foGM+2Nh75CTFcY5dBgWmpPQ1Cz6R7J3ccLUKm+cge33jgt61Eemoeu98LhrYh9ZvtbIQyB88ZAxTyj+iI5xLyLK+4X4BuKAHU/bBh16FCQpEXzbJx5iQ7HyL4cIqWZEynt9bnmQzahx4L8QUvQZKQQAwUIjU2b3YKn+CPmcwzIHefP4xkrKeaZIq9QUc2cDrbHdcnPCjJdgtyDqFofbfa32bU0NDo3AgqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84ZogmJdeOPw/gGemOGEKUlOe3k/yEnmNbMWmjp2CB8=;
 b=rq3MXiuLMZJDJkipKWNnwZ+Vo9ShFg5MXqfumtxDTGiDAqUWTDeEuVOzDTXPiQhsZ61yYPFYYtEkdEmlQG5yVqcUKTAWeg6iN9YXbzAAbUwM19GUuk4WbqjbUG8jiB9frFphbYwGAbRI2rmZleiTsKExeSeZstF0J2BvpyXfWaw=
Received: from MN2PR06CA0008.namprd06.prod.outlook.com (2603:10b6:208:23d::13)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 21:44:06 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::32) by MN2PR06CA0008.outlook.office365.com
 (2603:10b6:208:23d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 21:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:44:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 15:44:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>
Subject: [PATCH 03/11] drm/amdgpu/gfx: add amdgpu_gfx_off_ctrl_immediate()
Date: Mon, 3 Feb 2025 16:43:40 -0500
Message-ID: <20250203214349.1400867-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203214349.1400867-1-alexander.deucher@amd.com>
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b914b5-b19e-47c0-852c-08dd449be26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXJrT3kxY2VHSXBKbGJiMExGWllLenAzU0ZOdzVjT2xEWE1sYU91bGpWQkFX?=
 =?utf-8?B?RWhJdmxPRkVuQVE0Smx4WGp1TlU1K2diNFRMT2xRSUpNWnlOckVKNytDS1ZD?=
 =?utf-8?B?RSs5TkNMaDFyWWh0VU1TUEtEVDNiM01ieDk2aHg3MTJZMlhDZ29jaFdpb2Vk?=
 =?utf-8?B?ZERmcUF4Tm9pcXh5QWM4L3dzREdRQzc4M0dYc1VjR3c3dW5FalNlbC94cUF0?=
 =?utf-8?B?cjI3WEpaTVNXZ0lCUzNabDlrdnRLV1hoTGRNNFQ4and0bjdyZGd2TEdaTisx?=
 =?utf-8?B?TXhqeGxoS0tyUHZHVHZVMUl6NDJYZEFjeG1XK00zV0x5R0RIWmFXblZoaUtX?=
 =?utf-8?B?K2NSVFYxR0R1UE5SWkNJcC9FQ3dSK0RpYThRSC9LZm51Zi8vTjRzVTF5QnY0?=
 =?utf-8?B?Qy9CamdPVzFvekhNNG5YbkRsR1dXckJKNmRhR0plOGNmNlc2MThNQTRFQk45?=
 =?utf-8?B?ampkOS9Zd2Y0NDJsM05iRWxmZGtVTnE2ZnJzL0kzeENtbUxLYzg5cWhWMCsx?=
 =?utf-8?B?WTRONHRIWGRCYm8rWjAzaUpXZlppK2VBZjl1am9IT0c5Vjh1UkxBb1BZd1M1?=
 =?utf-8?B?dWVDbVFtSGRtdVV0cGNYc3lLUGc2MjZDUUlvVGlDZkxWVlU1V1hrYU85S3pZ?=
 =?utf-8?B?WlI0Ymd0eHhHVnVRUy82cUI4dUN1dXZSZnFUdU9zcWQ2R1pOb1M2Mmc1Q1lE?=
 =?utf-8?B?VU1IQ1hFYTBkdlZkdURNRC9LREZ6eSttY3hsWng0MWZqT01nUG9BSFdIWnVT?=
 =?utf-8?B?WnNUK1BjRmRtYklZeTNkU3YvNVZtSGp2QzE2Wmo3VU45V0lSNFY5QmNFOW5I?=
 =?utf-8?B?dGIwUmVibGpzOXNCUHNUT1dPYjhyU0lpVTYrc0hDV0FJZmhVQmlJUlRSR1pr?=
 =?utf-8?B?R2FLZ09QTWJyTVlHMnE1YzNCMUY3WnFzZGxMWEZlVXVGeElISjdBbjJTUUZO?=
 =?utf-8?B?Zkw3Ym9NR0tmNnBuQm53ZU4yWUJyNWJDbkZ6MjBiT0JmMlk5aTJBNnRadFVw?=
 =?utf-8?B?bjREZVE3eVYyYlREaXhqNWd4T0wvamlZU3MrQVNER3l5NzhVVFoxUlFKM0ds?=
 =?utf-8?B?NTRSOWFCTnJYTUlDYjNYUm5WUGZJMUx5TzFoVG1nb0RHR2p4TTJQZmdpWVJo?=
 =?utf-8?B?K3cvTWI1U0czUXpucHdpZ3ZqT2c1Y3EzQUYySXNOMUVhQlpZM1cwZ2dBZG4w?=
 =?utf-8?B?VkxLTDNGbmJ2bCtVRFNvYVhmRnVIOGtCdFVsUk4xak8wZk5FN0FpZzhTaHd3?=
 =?utf-8?B?dzkwRzMralpKaGE3bGZyWm9yaGdTTVQzT3BidkllVlhkTlhIM0U4RjV0dytY?=
 =?utf-8?B?dWpiV2hZWmxYbG8zdGpOWjBrQ284SUZPVmZxZG1yNlBWQVdycWxzRWlrWkg5?=
 =?utf-8?B?NldlNDlDSXE0VjJXVXU4aWg4K21aZ0xMM2ZwbnBWSUJXRXVKQ2hQZUFSdDE4?=
 =?utf-8?B?eTJ6U0ZaVXVMUk90Z2FhUFhUVlBqYmhlSHZkdmxQWGYzeUJ2L25oMEFFaElE?=
 =?utf-8?B?RlpCL3ZuVzRDK21GZE5FTkpGZUIrOG51aUkvKzNvTUhZVXdta1pEeHQ2cElj?=
 =?utf-8?B?dEtrZDFkZGk1ZXdrNG1RbHR0dVI1bUxWclFFS1dQampzUHcwMlh3SUgvQnJz?=
 =?utf-8?B?WDNNdXpGSXY4Z2MvOEFLaEpUU0x1V3Brempmamtwa25Demh1MEN5alkyTWVX?=
 =?utf-8?B?eXFRRk4zdGpHUHE1QXk5UTlWbEFNNnY0YW1lbkU1QUxLL2tMdGdFUXJFeW1K?=
 =?utf-8?B?a1Z4MmxFclMzWEpabDNJak42TS9ETTJyRTQzNGFLcVJyektIQTZ0NHZvaURv?=
 =?utf-8?B?OE9zT0c4d2pFZStqekdrUzdMMDdGN1JoL2ZaZW5OdkEvOGdRSitBSHovRWJK?=
 =?utf-8?B?WVRIWURwdTB0amZmN21xSkFkYmU4Q3RySnlyWjRNVzJ6U28weDdzekNxYVE3?=
 =?utf-8?B?M3B3RG9tUE1xSWhXa0toUjFOcWd1WVVuZDRjWTZKekVvYjl0SjgxQW8zOXo5?=
 =?utf-8?B?SFExajhreENBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:44:06.5145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b914b5-b19e-47c0-852c-08dd449be26d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873
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

