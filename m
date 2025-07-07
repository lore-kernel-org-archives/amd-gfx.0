Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB83C71130
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A879410E52B;
	Mon,  7 Jul 2025 19:04:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BFNY1lPX";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D6E10E52A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFURQIOOT+By8g5Tj/DxAoVDc7sSHAh31kTdiHWHEH5bHkIpmVr885fd3PZJZQRXcBV07aYUHpXOXREGmU5G84jKlJAhzn/tpCILBvtsmw6kHwKbVU7gPrjgtogg+O3tymVYXIP3S0uiE/iLh8BG1T7JVDf1ahAYZFsSYsxbhIBDr84EUP0AWBhBoixY0gpz/hRhpoyam7k9j3taKRJ5ff0Xt7kJSVcooiT0jUWVJTQWvxUzwdDltFB5GC/zpQEST/dq/4mSYuPY1T8AphdXbg9KtYvaSX0kB62S5U15HPneqVdPK6qav481Tk86hdocYr6XAr+tKMBUIXW1sbjdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlscUeCneayqPVE65qPPoqrcMW/EEDwszvtuUW5lx44=;
 b=ZMS4tXM/IWxZOCL2+fI8n945Zb96XK/3KNUTUWDk4zR8yMzS3T7ZnItG4Vdq8E6hYyYjcb+z1USA8jY8eX/UcY4RGH8WUMo7E/vNwKId6NpMVPDWCnOKTBP2HWhl75qValwnhSmm2ZogCMR/DH9XzIsQucvUeH7r75RoymuTRPd4N6RWdqK7emoQzm3DAV8OSuL7N/ggQrNLuhJIyd1W/xWH1ZTpjPoPSw1nAF2kkVJmdKlF2buyGq58ezwhsAXXcVLh33qAAWU536Zrn/CJHLqqUdA+SpUhNIkXpEUGtW/9JDAfLz12lCG3Xxq2Gy7GhygkZK+behbFiz4X0BnLGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlscUeCneayqPVE65qPPoqrcMW/EEDwszvtuUW5lx44=;
 b=BFNY1lPXUIPbTNzbyjtVTaZXK7vDesx6lXp/O1T9wKMaNjOhJABTM8olUbegXpl7LqIGe6R9a5J5Ae3CNUg55uAo1u0fSYxPcF4zugB9fuF8Cs3ci2GQ3vq47pkPchMuN7Sxpd3zCd5we3VCRIGy0ddaEwc4mLVm60wdUOR00sg=
Received: from PH8PR07CA0041.namprd07.prod.outlook.com (2603:10b6:510:2cf::29)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 7 Jul
 2025 19:04:28 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::54) by PH8PR07CA0041.outlook.office365.com
 (2603:10b6:510:2cf::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 27/36] drm/amdgpu/jpeg5: add queue reset
Date: Mon, 7 Jul 2025 15:03:46 -0400
Message-ID: <20250707190355.837891-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df50c72-c210-4768-72de-08ddbd8918de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iCBY1eVzxtjtIvhUvCLoiJrFSfN+QYwATWSo+hpkdyBXI5pC8gli8HrJ+r5I?=
 =?us-ascii?Q?8FFmROYMqgvZhhy1vNbohDOhQjSwH0jhAKbr2+xxeYG6y55q0Esy6krcCxu9?=
 =?us-ascii?Q?jb/ArGwVkekw4kTKs0H3Zg+/yBtCDJRs44lM39nX2O5w5TpqNbWTZA50BSEN?=
 =?us-ascii?Q?bB69powCszzzHCm7uZwCIOjsWOpg/d3IxX1LGrVNc+hzqT7cDifu6rZYINFi?=
 =?us-ascii?Q?i4VZspIopRZ8CbMcyav7WK0ygm/uOCTTlfLsyu4FTF2GWgM+KjJoeRi+xXur?=
 =?us-ascii?Q?J+zxer+KiGg3wL4fsrBkdW9+mukYMo0swrii6xK0+xjm4rKcidnaronhi1l5?=
 =?us-ascii?Q?PBUg5fWvWQ33BEDMttlHFN+RdEbMKBM+640JKSga2wYBR2xyLgEWw5UFmA3a?=
 =?us-ascii?Q?Bejpc7buMQiPpuwuSNLFhaDi/kilK1Ms1VeDns4YTn+0bS/PPgOWcBrI8OZO?=
 =?us-ascii?Q?EqE763C91XYL3TEoZmWDIo0eYT37YW/W307DBLCB6DJIJYif1rq2hjn5+CQC?=
 =?us-ascii?Q?qyahImwFpY6byQBFjk1PGgZyx1CwMIqBauBZ4qa+Qj31g/JCjFH7s1dhpUN6?=
 =?us-ascii?Q?U9BySdkmE22ISOeS5ZkvP5u0GAyGoRJ3fwRqcME9pkPVPSnozpOztfFEYefS?=
 =?us-ascii?Q?UGGuE5u/MGhfmspJDISKoEXMRbDCuVPpxArI984Ffxt0j+iXFtSkHAv/dBFc?=
 =?us-ascii?Q?aNSvHsM0p7LsBDrqqgXQQkGQb9krSlH9qxFuPcSG9l0qxIoEIPATffqjj9jy?=
 =?us-ascii?Q?DmU3VzbvfLKsbeWHeRMvkVEMXE9ViV6/dOVG7OWSGuoBX8ktWCsNqs1ZXbnm?=
 =?us-ascii?Q?bi/O+a/GezmjFYC1N3hpmzq1g/sLJu4eZ17AIVhFtXlYuLYaHD012TxoCZyO?=
 =?us-ascii?Q?WsfSL9ohjbQhbKBfih9PtpnF2QiZg+ELtyCIkDuvbC/D6tnZd7GWXBgvnVGY?=
 =?us-ascii?Q?Ri1ELDeQOtD4G32D5LWKQXkEalhj38PnYofF4+qfjcv6/1Al6pbSJ0iAKGzx?=
 =?us-ascii?Q?D2xCk4dE6jkMFft2z2fna+irRUS2ak7u3EvrC333JH3TLeHnXGUq/VQNKrJ9?=
 =?us-ascii?Q?zIq7F57I2RqWmI/EreozNMzSkcum3r0UlBiUkaO1VbaBNBtkLr6WamvHvxTT?=
 =?us-ascii?Q?zlMDCGUuXbYSz62ohR1LXTa0O3ojMaKTEDcV9ha+qL4UnEj3DAqlj8dKSilM?=
 =?us-ascii?Q?x2nQ33pJSCv3Cjfk+ax+/k2TLdWS3KEv7eokyendUz6hqTuo26OK3SvgK2qP?=
 =?us-ascii?Q?jME5e4UAcwvDxsNCOXUpepV+Mfn7huG8TKGD3ViLOs7cXrfJGkRC4GnJZ2cI?=
 =?us-ascii?Q?6rprjz8VHWE+rlh9xcajr124QjS9ZzK7Hk8eVEWXMz+L/s7coxxHec2fta0b?=
 =?us-ascii?Q?N7ofG+xVyhL+yVutvudO0kHYGrsqu4pkKJ4MqxMueK7FlcbDJ8KcpuDtzI3p?=
 =?us-ascii?Q?cLCwISHM64283hikTtY+zEr8X6UzQ81SqwyJ2b8+9rrWzI05T1pDqSgAuSvX?=
 =?us-ascii?Q?kSOupbSa4IHQY0H/YPjm4Qg2dfO8N13uPLiP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:28.1004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df50c72-c210-4768-72de-08ddbd8918de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
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

Add queue reset support for jpeg 5.0.0.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 31d213ccbe0a8..2630456990a6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -644,6 +644,25 @@ static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	int r;
+
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EINVAL;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	r = jpeg_v5_0_0_stop(ring->adev);
+	if (r)
+		return r;
+	r = jpeg_v5_0_0_start(ring->adev);
+	if (r)
+		return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.name = "jpeg_v5_0_0",
 	.early_init = jpeg_v5_0_0_early_init,
@@ -689,6 +708,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v5_0_0_ring_reset,
 };
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

