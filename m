Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1409CC7EE31
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A979510E815;
	Wed, 25 Jun 2025 21:07:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UiZOPcpf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A16B10E803
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN0kTrgOefVNs3rokysslRUzWyZF4YJBo7cvI5b64zxm0fb+0j21oen73Y3hglLkdfSbD/hzBv8PNg8+cIKzp8AwSdJrznDTUFa23JtjAHkJKvR0i/bO8FhbGT3ZgJoIGusIc/53R78pmSgQ6HYw5NBCM/gPU8h4UGIwfIsbOZjY+RfevBg5Tj1e6f+PEE4SWdV09sr52i3jl1eklf98w4Aj2wxVTvIK2ZDTsg5ArCB5q1AZrP05aLU0oZPDHnYRLa1uIrnN7lsKhEPRwIsmyoWeej8IwLWAwJw/ZjjOsTP+5/pD5G0MMcgAtJAIDSezVUd6wOqs7pXiFRM0HzEZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEfvl7gBfYyZ9t2ZhvSSlRj664kmzFOWlLW5L3oy29A=;
 b=brtcvMjsKGj6+FNAqMzBBlvGhihWqwhdo47FOeUDvUOgVtDOwRxA+7V3rJTwELprqzsZzmgG9vbu3Le6xZBVceGU87Cx1IYyh9MySGzt024luIwfA6u9Q1ZILd0zdr8Uiqk6OtlseBECs0Q3kShdVXLDudOMMD5h+TXpUfEhJ9oYBJrxGZz/U4sow+KdghzXOG/R6ZSwgOPX7qtdL/cgocbPeYga7Uc7hkIBoHvJaVa6NXMTTpksVSOINJsTFNb1+Oy7nMOIzu1HIr6ecuW1lbhMZ5vO8Zu2Il6eOoQF7tK3z+ZmjVr4q/lzTUY/qmgFxZmLnwL71WLMHnUxgdlQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEfvl7gBfYyZ9t2ZhvSSlRj664kmzFOWlLW5L3oy29A=;
 b=UiZOPcpfRlR38bIvEUC0M73tjazHUB49/auEr4wiBJAF8LppKQDAb6yL42fz5PR/dqNevMywFlnIZRqjlT5yhtJAVSwoc0IDOY3E2gWDTrmRLb7Lc5Mx2wYTCPidu6X1/EuFfOFdsJaqINHEklDS8BbWKMTZoJtMYJU3PFF4qt8=
Received: from BYAPR02CA0060.namprd02.prod.outlook.com (2603:10b6:a03:54::37)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 21:07:10 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::66) by BYAPR02CA0060.outlook.office365.com
 (2603:10b6:a03:54::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 20/30] drm/amdgpu/jpeg4.0.5: add queue reset
Date: Wed, 25 Jun 2025 17:06:28 -0400
Message-ID: <20250625210638.422479-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 264bb7c7-1812-4597-0386-08ddb42c3fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jXABb43m8Myk8r8I/q3bVjqI/71PYdtirLDlbxqaK0Hyv+sENV+J+6UhSe5H?=
 =?us-ascii?Q?sMZvXrOG9sOOCFcawH0X4B+yhgPbbETVs6lSO6hB1ioaXL2onhUx8CYeAlJS?=
 =?us-ascii?Q?rjVF5r725L2tH0W7DYGYcfqwz4+OH2UJ1BgsFWOfhIrquy+M43GZDK5Zn/Rk?=
 =?us-ascii?Q?6+TbSmKHKDTMc0rAryp3y0xTyxIPz7GJfbkvzUKP3QmbsWSncf1fapyQY69N?=
 =?us-ascii?Q?XcKNdKOS66YUwFI+vhjLb5kJsWHvFol87XkoKUe6RVtLMPQT5g+sRnVX8jpo?=
 =?us-ascii?Q?zw5fT1MYJk0gePtWRSu+i+eyCGUfI+Wacn7Q/KXfYqMgQ1qVtFcz93kyh/Gu?=
 =?us-ascii?Q?AlvfTMipn1G98uWzcUxRRqRqYMmZ8PqrBsHuOdOGlwaTr5PiMnbwqzwP3nJv?=
 =?us-ascii?Q?Dw7kobSvgu0Ss8AL9Gg6fwPFDVZAV5BqUfkJVbw0OQO/hff+vMy0PXOFWQGE?=
 =?us-ascii?Q?51JwLjc4m3SckTdldoxzb3Muc733RARRxWkroigtz9uLV/U4u7x7sSrqgv9l?=
 =?us-ascii?Q?qoK1B49SPNIhnacGWlEmtY0XOM5jAoKO+iV9NWIW/owUWiDL95CJttitXyVr?=
 =?us-ascii?Q?9t/qp4/3ZZINUmXQwg69dJwegGWCxwbuRcrew/8PuSWZmdXZadB74fWyOtr/?=
 =?us-ascii?Q?thRrR3z5ctq6yidJM0CNRGEu4VeEknSKVRhuTmoff/Bp+6DLRbKCIbiLnnRt?=
 =?us-ascii?Q?wShoiUaOAte0ld3UK26Qey6dvCNgc6Q9Ld4xFNSwZcHmqoMNQxxXKbtpJO+7?=
 =?us-ascii?Q?W8Dif2Gh6Ny2vvlmcckVL+6K5fmzcgZvlWspser1fQKrl5yeuiWS42i+AfCV?=
 =?us-ascii?Q?e6VitLxJoS5t5QnjZPicNF+HHL8wSo3GVBOAdlH5xwQ95yagdLTOvBi6bKu9?=
 =?us-ascii?Q?EZ7/boReAfW/yODoHIGmu6rym12l/i3NRKiBHLoRZwbBi6wFuce5fmc5fuMS?=
 =?us-ascii?Q?YZOPEPKsCsiqbXFKwvRgI5uDZOBsFDg412kgCUfQo7CGpA2ypnrXwhPnybYP?=
 =?us-ascii?Q?1irF4bG5ajc0Cj4P0PBGLc3+8FQXfMYp8NcTqBRs2vQcRiDSG6YYV1MB7Te/?=
 =?us-ascii?Q?6Z4+MVqEY7KYPWWbz82SGKc5P+n3f6Dhr5lMBAQI9duyjbxpZjlKsMBO0Uj2?=
 =?us-ascii?Q?M/hZSemvlsd/ij+v7qQKQ4MzBSkDO+57CN3L7SauloxdSyuPHh5BhTMUtWVl?=
 =?us-ascii?Q?pkvPB9g771icnepDpyjziT8owZRt2G8/nArzfgXgyt2KtwJ3AwVwzet7fUXC?=
 =?us-ascii?Q?Bl4XMS9iX5fOI5UOSqchrVqEjl+JpCkL1nKwRjah5lOn8uPSaFiKAulXWlrP?=
 =?us-ascii?Q?Wg3TYMTyCmqUVSakHlOsDlefZDCWKJ72tPNLiJ9klqMjeuz8zhpomB7fU3/j?=
 =?us-ascii?Q?MeubKNLxHCmWl7OOFfdIRINP6Jd7SXP0QskXfoVNf35s5inonYmTFOOiElxB?=
 =?us-ascii?Q?LomsVqawB+/JCv7osek/3Ak/pM7WBTs9uff5FlD+DUOMBMpj2yvYg+hGqoIU?=
 =?us-ascii?Q?2lgqLfWAQyi+afbrBXFotR9FKlAx1ha8hic1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:09.8894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264bb7c7-1812-4597-0386-08ddb42c3fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 974030a5c03c9..e6e90496135b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -767,6 +767,16 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	jpeg_v4_0_5_stop(ring->adev);
+	jpeg_v4_0_5_start(ring->adev);
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.name = "jpeg_v4_0_5",
 	.early_init = jpeg_v4_0_5_early_init,
@@ -812,6 +822,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_5_ring_reset,
 };
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

