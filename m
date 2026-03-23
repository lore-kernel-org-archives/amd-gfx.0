Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB6ED58CB0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 01:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B1610E22B;
	Mon, 23 Mar 2026 01:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JmMwDbol";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013064.outbound.protection.outlook.com
 [40.93.196.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A46510E22B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 01:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8VRJAkRfd1tlpeZ0vCxcvAixLZ6tEHOoiTa7UYoKWlPeTgeKQSJpPUzlkuptNx1q8gdLA6rI1mpGvnHWDOqCQ702k5fCeLAZqrsUTvD3MwcNUTd71mavTVtUy9g8I+MHNc8Ebnh1iyDcN5V7OPuQxri7DVPfFJO0LoVlD8zLui2Kz8lII9cY7LEEoIo21dghWBDdrHlTyof25QTUcPRRU9JYxGLjhDnLGXvfBe4VnZ67r+UvlbabuBtcL+cmYORTko2IY/lgMLoC6dHVeZh/QqKrTgDeLRSNyg6PXXs4gUeqwYfDodcJdXbUmM/W9hVVAZR1DIHYyfpV2xT+GgYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+A3DlUQ+tdGrZ4H/yDryh84mvpOIC6XsDFxGwZ6QcQ=;
 b=JQU6Db6OKFwFzpcZnuCKNUupbAWPPVCSmnQ7FlrcFlL1CbAEfvaGBxV1tOwX97IKu6TebiR6807W5ioBIFYeSfHq+W3hdf9Zm9FcVmD5H5SqgZ8I+do89uiZtxyE3d1ydFerh5cgQE2I+7aNo06ymZ1ZmNO9+jHQ9xa2GkN8PaygmHSmen5eKOpRYd/76aXbpOIklPCJc8U3NvAU2Qv54ysj231BKY9KTF+UuFPy9AY99EA69gGCO7GNd87DfAgDSz8xmSuarSQyRUdCttVHijCj1bCb6l37BmmOuElPid2btAr5Q2L6OkPnxHxAEZv4Z0hfsHtTK+DL3u+llCtQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+A3DlUQ+tdGrZ4H/yDryh84mvpOIC6XsDFxGwZ6QcQ=;
 b=JmMwDbolrUWG8OiQXhUtPwESU24e5drJo+lsZu4nhtAkiWVS64SkkCuRVPttJLaxfCr08Dl338QfhWnob19w5AcJyPwL4ud9B3EORVukbItZnL0FkfPS1z1b1FJKejsCqCPuk+Sx9zDntTMBT1RbE07KcPEA3xM1QbpR7ga+tAc=
Received: from SJ0PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:33f::21)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 01:29:23 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::6d) by SJ0PR05CA0046.outlook.office365.com
 (2603:10b6:a03:33f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 01:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 01:29:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 22 Mar
 2026 20:29:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 22 Mar
 2026 20:29:23 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 22 Mar 2026 20:29:16 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/vcn4.0.3: gate VCN reset on PSP FW for MP0 13.0.6
Date: Mon, 23 Mar 2026 09:28:36 +0800
Message-ID: <20260323012916.355223-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7c511b-6465-4d5f-9383-08de887b9d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5Ct1EZ+xRig1l0K0ZoT6FWVUPoi67vGspstSiI5j9GCpj7yJtHygARhy1Y+5wgLyrX8kzZ4JA2k3Kibf5IRFmyrhjrttMk1aZJxggyk7fVdUK9kgsjUsAIbKR3iwR/6M8Ummp9RUenJMMVD4rPV6jFYwoixucVhXr77/0a2yizMj8mn31aIxdz+zduTgafzlIT9dJHa6hzRmYi+zFtgcf/WeIHPBaPsPn1UgLscob/yjCEKhn5a7XVOsyYkJpwgyWr9rOPj0c5pO7V7zadeoZUxGjEVcsiNavgPPeKgNUUPEfrsiRJU0BFKTZ8IFoOU2UvzXpvfFH+HDP7WBLrSuAo6USmeCGMAtv2P2X6smW2cAw6PugQCzG8DYSDt4uBAKNXh+wmRcMp9ZsSQZZxgB0mIQG+bt5KhnhlRromxMgd/RQBQj1s1Q3bBSAYYXFJj7rRvEkxyvQqKMJ1/fGyIDv2HkIiWv+LALCkBryergI2HqZOOa3QyUVP7XXJGsqDUIioZqOldqdYEJXm/xB5hZDRXc9+QGKMwJp8woZsfqMYoLHYFmCcfWzDu6mURFV9hln+FE+fO7fxReBFS8DEtqk6VTQUmx32QhpKHmrpJBxLaKELe9YB/Y2fSJ1mFcgppEjWj7h279Nmc8T5/zged0ZgN7jLjNNTUq1LN4vxMA+fyEuu1Db5q5osUMbZnLS84VqrFyAOh6LT5PZBgAQZsTJ2O5CfhBQdymTghectctge5yL1Jvgea4r+ph1Tp1kGgDc/RSV4O6shTnQ4Q1EyEtVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iOYnsHyoqLfHOq8pv2x6HxEGo0ZZeY1kI4lCoX/2nveElFi3OKVwROWJaXhk6HgLpnxo+VJ2F59URojN7PeVzk1x+J7COtp76dLIBrFjBYxliV+Mm6Tx148MY5eCqMuRzqf99QFK30l/3iJDGu5vQHjxC9Xli8CoiRxHJJRfbhoCaWbAmboROgjCy6YZwE2nKEPWdEW8TGJT5VTDe6NRWZjp938VX3k0Bu1tCvGpqQmyfM69xCCYXOV8iyZeXMOoSCN2cwJjzNOTEvRci2vFC7atM3tfLNQg2HanhiRJFu7onuwER0RjcmeCyXGPmnsiZkVCC5b070mzV+UOjvNIh0EQ4lKIK02ezZ5N/BPjklUXlGJYRWDxuIB80Yb0nYFfWeU1f1I0VaJoSwvffOAXPa1trSGYTwH33ru0H8vfzwNcze5f7SescFV1wzMQu2DS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:29:23.8032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7c511b-6465-4d5f-9383-08de887b9d8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278
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

Add a PSP SOS firmware compatibility check before enabling VCN per-queue
reset on vcn_v4_0_3.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e78526a4e521..7cc8f6389152 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -134,6 +134,26 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static bool vcn_v4_0_3_is_psp_fw_reset_supported(struct amdgpu_device *adev)
+{
+	uint32_t fw_ver = adev->psp.sos.fw_version;
+	uint32_t pgm = (fw_ver >> 8) & 0xFF;
+
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(13, 0, 6):
+		/*
+		 * FWDEV-159155: PSP SOS FW must be >= 0x0036015f for pgm 0x01
+		 * before enabling VCN per-queue reset on MP0 13.0.6.
+		 */
+		if (pgm == 1)
+			return adev->psp.sos.fw_version >= 0x0036015f;
+		else
+			return true;
+	default:
+		return true;
+	}
+}
+
 static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -141,7 +161,9 @@ static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
 
-	if (amdgpu_dpm_reset_vcn_is_supported(adev) && !amdgpu_sriov_vf(adev))
+	if (amdgpu_dpm_reset_vcn_is_supported(adev) &&
+	    vcn_v4_0_3_is_psp_fw_reset_supported(adev) &&
+	    !amdgpu_sriov_vf(adev))
 		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	return 0;
-- 
2.49.0

