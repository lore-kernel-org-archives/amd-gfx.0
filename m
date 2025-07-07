Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89523C83F16
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70AB110E541;
	Mon,  7 Jul 2025 19:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0YGTAWuH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC05F10E53F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKaxEDvsaeGtiJBkAVcVtvXaBhRS3vUqK2jgexuUCuT1AIQlSPiQvV7gJqBsu3/ayOVb6NUoj6a9eYcTOzaxlVBFfHdCtu/U3NbTJWl9oY2Fxhn7ioNz3ZBrbcH7afMRSwJrQ3RwQDXi/RIkkKnAsJa5DoVq4MuZE/JQZ7yW2zNsI1MeawO1IC68ewxHwPNXiwF9G7OV3aZqUPmCqu7Nfek4127FN1wdkj5O01eCg4mOTQcgysRdO1cTnPfYka6ulsmI4Zlmxi70zWCERQPgA2i3MB32sHnNnu6Y8oN4AtXGbkHdkipa1Y74pQlF818YVo1LwaPCB3HtkQXIZK7upg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCASZ+yn7s4D0qf/JWT2DvoA3FLFBYWxyHxwbSqiIww=;
 b=GpQOLw3S+ZM5sSoRreVi+XVZuS+UrApjs5+uBDfQFfPiTjZ6piTPPHzQKqy3JilbN4RUUX50WH1DVb3DzpEOfJGi36eoPiq44puKgwih8Cb1HZDES102CTyZsu4lc08F9Qtwhr0ghkzVcHyFBvDIpe9wQmhanQSHDrF128kGw5djPI0bcAbaEg8BUHj2MBG9zV/uGxXiBCpZODl+qneshC47o2RRHnAfKEP1VLn9wQEoYaCacj0XApLd2sMY0xY0dtR1cpliHkYITXXOKPFGKXlmYSJ8C+uHlPEw0ySd6gtsUC2m+N/Izue+SHagVQ21gIkP28AnFRRHQJFfH4NP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCASZ+yn7s4D0qf/JWT2DvoA3FLFBYWxyHxwbSqiIww=;
 b=0YGTAWuHx4xJoegx/K+QenmQyUNzx8LSHTq0I4Lbj2ev1p4VnflICshEA0AW4j/vohXepdsORgJhBuenBStFwwvD8qScRXgR+GQVRhZYW6+XpTCrt+XJ5XtECxKndkDcyBgEhJtvyJ8ii7higla9AgPRf/K0L9cS/q0uP98MLSs=
Received: from PH7P221CA0086.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::13)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 19:04:27 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::ff) by PH7P221CA0086.outlook.office365.com
 (2603:10b6:510:328::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 26/36] drm/amdgpu/jpeg4.0.5: add queue reset
Date: Mon, 7 Jul 2025 15:03:45 -0400
Message-ID: <20250707190355.837891-27-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a69d455-f25d-4d36-5802-08ddbd891870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pq9dUWAqU48mxFUsw8xG+CLexcjk2AfjzhllvLRpLjH07VZ0MWRg3Y1sNpdr?=
 =?us-ascii?Q?7zmN2ywAkERKwziBDbV80ciW1eqQ0MDNBCEeoQ1afdnLmGjJUGWsszsg4hO6?=
 =?us-ascii?Q?Ebl5+n2KUWHopmTpscIonarhusQ84lASGfWVbXXygxbndPqKUHJK7NALFIyG?=
 =?us-ascii?Q?WiCDkCfSOG9veAJj0KdzMTeNGq1FAo4cnm9yIbMFjhorxIz4xwX5eewUSLym?=
 =?us-ascii?Q?UW1/U7vTYgKdioMziDkWnte64u55ydvCTLzzJ2UDN9nyGUrwH75M3Odc5Jcj?=
 =?us-ascii?Q?jsDo6f7Kfp96+XkFH0X2eRDWwQbNEPUq5Ia48T+zAFu0fL8p7dbfJq5TTS1k?=
 =?us-ascii?Q?MXJXZGqbCRDfEmsv4WEp1sv4yP5sfWORxGgkOLHpA6Tg0QnVHlSDgKvzQxFc?=
 =?us-ascii?Q?ZowG9fQpbUMHDHmLwv57WpX0E4B8QOQuerAvSe2dmyJ/bwBJ+a84T3Rn4nfE?=
 =?us-ascii?Q?JbYBYY+QjUWbjbUMi7v3V4OIZXIxRPEUivptkFqNCSSgi6m6huQJUFcrOLwM?=
 =?us-ascii?Q?jbSyGW/7OGxc1TOB+fnNZUfvTPMLfV+kOpt5lRbKATMdhtyl1EoZxDnv+iKk?=
 =?us-ascii?Q?x4hWi5mFhSdGmRTAmZqXQaRCPkLhQ1vFgqm1EddEGM+LcsQQgw/Bvt1eHl90?=
 =?us-ascii?Q?5lR5PdW4XLHW8radGVK3as6KiGpBwaCXaK9coh/72bUUcbyOjyL+pyW0cFlk?=
 =?us-ascii?Q?re8/LnR51uoYK/r9sZa3Zt3lCcK74AoxPXuMjRXIe5etwGIdbbPPESQvF/EK?=
 =?us-ascii?Q?vpG8kfXLBh28B2oXDrzM1ONW4WDPU1G5NV1+Xl5H0HYNnezLSzbN7KJu/joL?=
 =?us-ascii?Q?K2ARFhZ/hJbkfSoJhOQKuMGnJurhEuoJcsrJfPUfx0DRff7IMLRud3QF+tol?=
 =?us-ascii?Q?93Do1JcNoRa2zJX3CAWcXB/OsghN+1n3xOuxmmQykLWUE1cAdcL7yiueMlGp?=
 =?us-ascii?Q?7qrwH+5R3YmxO5O2jasgNaOBm7SNDL4E/6lilXgFbLr3aBlk/91j4OGlV8vJ?=
 =?us-ascii?Q?Vk6ThtqNyX5V3avB5aXIRvqyCxgtKtDXSO/fSRdoL9lwFWqKqXohRMDvIaPU?=
 =?us-ascii?Q?UdoKaKWy2tM84kupAIF16E18X2THoS9mDoLDBaBDxiAbOjM4uhFeU1LnMBQX?=
 =?us-ascii?Q?O96X8elTD+KYHWYdemCVCRIld02SGK/q4XKdes/SDSYsDipubquPZ/6OfGbY?=
 =?us-ascii?Q?z/Hmp/2TSbz/662zlmz0IhrPPMXgkmHWxHYfrOVaLrhXP8gRUc9SGS01+XC3?=
 =?us-ascii?Q?XPNUt3L1gaveZ5KBh3WGLTCam+xWXUHGlQwn+fP7H5cHIYPYvrgELq0s82G7?=
 =?us-ascii?Q?n42z/pjCPYnvAhssc8Q5bzsVize7lY/C3xRaft1+a/0azkDPw+Rt74Sx6txr?=
 =?us-ascii?Q?/3so36VvEOpMzsaamFN8glay9XIDULM4pdfYhxnU+5YdyS2Z5+TJhHoSMHwI?=
 =?us-ascii?Q?cEql/84N9tvFgPhcXdsgqG3ApZcXrfHjC9tz61Zqaa1QJ2amuu6OeQE6BBr/?=
 =?us-ascii?Q?ScmGl3NB7y1thwbSZ3WuvX+/A4XDkex5sVy/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:27.3771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a69d455-f25d-4d36-5802-08ddbd891870
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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

Add queue reset support for jpeg 4.0.5.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 974030a5c03c9..34b35c810af8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -767,6 +767,22 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	int r;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	r = jpeg_v4_0_5_stop(ring->adev);
+	if (r)
+		return r;
+	r = jpeg_v4_0_5_start(ring->adev);
+	if (r)
+		return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.name = "jpeg_v4_0_5",
 	.early_init = jpeg_v4_0_5_early_init,
@@ -812,6 +828,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_5_ring_reset,
 };
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

