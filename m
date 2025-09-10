Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F2DCA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91B910E852;
	Wed, 10 Sep 2025 05:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3NwYR9ic";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8A610E852
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsVf54Au85NcufPnFpOuvxycKCJmNhXhftNGbT5NpWIT1etV1xAOR4nZHpZopkI8WhF9SeMsOZfz4PoChWVBkaCYgYAsgUHXwbYqydAhzgT1by5EnHkOGKKDPcpTXiCbKjQT10Ll45V1YeRXE3B6Mu8vqhVeS/L1wcw8GOvIwLOif/g6lIwQZvX8V+9z7hDNvoAx7DwwXhZsZEYtYyNAgs1CnoDOFJaqil9rRLhFU9dUMZHhg84h9O5of5K9dorJbKUn9oFeovN/mCezzJw8J1hrQK5rAT7u1w2d6iAsEsWJepB+C377lFdAyk6+MEE4sFHevIkg2QyddwqDxhuZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmgEA6H4ltZQm3FjF/WZtTjzALQts9h4RMvoiP72wbU=;
 b=T5P8uJ2Z02iXl7/Q0MmlFHQGawVkAHAF4hFlzWFrm4CJmszP4+TuSy271szIbnqOdIYhU5z8PCfGULnoDY+0GDx9YAJ+KGD20lWIQWNYIA0IUpErQVfCuFKyv/161mjsOcrYWNATjRQujDdTtWXw37wtctFMQ2nUWliiy8rXC0DWWvCoTOORYICdXqqg/la5xmXfywYIZrLFlr/jxJE8HtZZ7VF1PP7As6riXSfq5f+Neo2NCfBTH/0oyQSLWolwHgHWfXOvuNqREhnJsiuG62O/kPmUdpfDFZ48lKkVY7i5oOZdze5ipLLdYzWdkh6PzPpdC7QqrVA4KqBvG7a4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmgEA6H4ltZQm3FjF/WZtTjzALQts9h4RMvoiP72wbU=;
 b=3NwYR9icRkcwK2Efw0s3FwmLS6Ot0qtesPrcESP+nKO/0DIvXoUx6wswwhBDzHD18BRwFz5ViQyij+9Yy/V7Nab56l9KcjsEvha/R1wMe5s1sqerTJi1Y7J9PAIYZurUX5ghtHrpK5asF3KgUJDqtzcdz1EnCUtGKzMc+SQUbIY=
Received: from BN9PR03CA0953.namprd03.prod.outlook.com (2603:10b6:408:108::28)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:14 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::6) by BN9PR03CA0953.outlook.office365.com
 (2603:10b6:408:108::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 05:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:04 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:03 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:33:00 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 05/15] drm/amd/display: Allow RX6xxx & RX7700 to invoke
 amdgpu_irq_get/put
Date: Wed, 10 Sep 2025 13:30:28 +0800
Message-ID: <20250910053222.2884632-6-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 46714a7c-a227-4f83-58b8-08ddf02b8999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gaUr2bfKphpgMzl2107108KYB1dt8AULZyHxGfUj+6QBiKkLLgUUYtkIwBft?=
 =?us-ascii?Q?hKZScpIYyJrfPkhv7uE8K6wBnlVWqsK81CCexZ+ju+0S922tl7hScPp52xZz?=
 =?us-ascii?Q?idhFfw8NYdEV4/bTfja2TYyn/ruNGc68Sdrl5H9oxWp5cniw3mcAtNo58Dzv?=
 =?us-ascii?Q?YFvJy6O9VQo2c6eyZy2qYb6cGrxeVm3vXNCMJogp2tK3WbjA4dLcL8f7Ay02?=
 =?us-ascii?Q?tg9zxm6od/K4cdGvFYGvn+NchyXSe1SLdOqSyVpY918l/28sqG9RIm+Scju2?=
 =?us-ascii?Q?MAtLyNP54rlNVk35/r/8Z9l7jH2poinSqsAw2VGfPEA7OT7N/uWSS/wl2m1P?=
 =?us-ascii?Q?n+XwSO/sEKurh1XLexWc83gosm7PxoyhKP3ssFgyHa7jHaZpQJbahQrAArCF?=
 =?us-ascii?Q?RmnL/Sp1juXJNcgD/el2S64N/aOIvv8RibqrYzc/LbOK64zUePWoY8FEDHym?=
 =?us-ascii?Q?GAcHSpWEjZva5hAhjuzASV6X3NGDhZ2nVbhhohCr9tJoEcqZNPFc6Od2MTqt?=
 =?us-ascii?Q?2L1vuFxxBG3m1h3K8JtIMdFzlCMDNQwyiJaY4bXo/lnMmeT1vWqwt+/ZDh8F?=
 =?us-ascii?Q?2KmFE5Tb3E/srH1Fy4UKr4whrbhz2fYFrUifBr3tyScFcvehqs8/wLdS2qwy?=
 =?us-ascii?Q?c7EvbXFUgyFm1TIB0FrGi5Nf9nfzKOC4ZRofd3q9npRq/qyLKBphi+NuNZ9a?=
 =?us-ascii?Q?FmWuKHRyTufJFBcXc5xVu9mxrCvMX8cqbtTXVQ+aYEL40XqqtbSk3zPb/j1C?=
 =?us-ascii?Q?rlet8c6b661TiT7EmOMs2atvDXtS06wIAQQ4nhmdbuZkjFcKc7SqxUunK1g2?=
 =?us-ascii?Q?99nmLZmegjpVxNLH7083IaZkQyZEHpLCaEJ5zTcPcWYBQg5tnBUS8SQCgSOd?=
 =?us-ascii?Q?FvlZdBYoo4BG6KCLnVHxzgM2dC8TJ9D+RAqx4N2olnYhtE7sS3wyS7exjF4S?=
 =?us-ascii?Q?PWYCuGwjth67v8RWerJtVZfEjRQEBDhlKhDMl8HE0+9UrpiP7FKFtSKQzDrC?=
 =?us-ascii?Q?VuCaQdA2UEdP687DdKOmxU10OKVnLSCYY+tM+nXs8bKeI5+fXSeD7yRPiqcm?=
 =?us-ascii?Q?fs+yjrnI16wpDA+4CQDh1ZJMUsik/4qFwUaVpqCRlBHSyUZmGQK6CUGPrzt8?=
 =?us-ascii?Q?P62VuOPhgjbg8+DpemTCrjRCOnSRSP1Riy8Mr6Uk0ngb/4eIrxKbG5cAAimY?=
 =?us-ascii?Q?v04A2qYpW84Hdu4KSWzH69B7Pb5QK5gcmpwFOY5ZcHEt3B8cNdHGpRPU/DYA?=
 =?us-ascii?Q?Kfutryv/+/XR50Ih48JUPaUDX08xqGU8Bd+VR1N4tOEQz1o3FSDSpZt5pqnz?=
 =?us-ascii?Q?hi/4MtF69Lw8OtKb8O/8yK51s5Uz7jDWZwtEihSinKdT6GamCKYWl8wCJ1r5?=
 =?us-ascii?Q?vMZ3rk5/fgrXLEA3YY4syLj5hqe1SA9LsZKeZkJh8NSTCJ1RfsWvvGiDHysS?=
 =?us-ascii?Q?JnTBTrmcczPR1MAG0MmgymiY0P3jWnJlXaERSslm/JPKW8Mry0yqpQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:13.8850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46714a7c-a227-4f83-58b8-08ddf02b8999
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
As reported on https://gitlab.freedesktop.org/drm/amd/-/issues/3936,
SMU hang can occur if the interrupts are not enabled appropriately,
causing a vblank timeout.

This patch reverts "5009628d8509 drm/amd/display: Remove unnecessary
amdgpu_irq_get/put", but only for RX6xxx & RX7700 GPUs, on which the
issue was observed.

This will re-enable interrupts regardless of whether the user space needed
it or not.

Fixes: 5009628d8509 ("drm/amd/display: Remove unnecessary amdgpu_irq_get/put")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3936
Suggested-by: Sun peng Li <sunpeng.li@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fadc6098eaee..b088cb8ae780 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8796,7 +8796,16 @@ static int amdgpu_dm_encoder_init(struct drm_device *dev,
 static void manage_dm_interrupts(struct amdgpu_device *adev,
 				 struct amdgpu_crtc *acrtc,
 				 struct dm_crtc_state *acrtc_state)
-{
+{	/*
+	 * We cannot be sure that the frontend index maps to the same
+	 * backend index - some even map to more than one.
+	 * So we have to go through the CRTC to find the right IRQ.
+	 */
+	int irq_type = amdgpu_display_crtc_idx_to_irq_type(
+			adev,
+			acrtc->crtc_id);
+	struct drm_device *dev = adev_to_drm(adev);
+
 	struct drm_vblank_crtc_config config = {0};
 	struct dc_crtc_timing *timing;
 	int offdelay;
@@ -8849,7 +8858,35 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 
 		drm_crtc_vblank_on_config(&acrtc->base,
 					  &config);
+		/* Allow RX6xxx, RX7700, RX7800 GPUs to call amdgpu_irq_get.*/
+		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 3):
+		case IP_VERSION(3, 2, 0):
+			if (amdgpu_irq_get(adev, &adev->pageflip_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot get pageflip irq!\n");
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+			if (amdgpu_irq_get(adev, &adev->vline0_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot get vline0 irq!\n");
+#endif
+		}
+
 	} else {
+		/* Allow RX6xxx, RX7700, RX7800 GPUs to call amdgpu_irq_put.*/
+		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 3):
+		case IP_VERSION(3, 2, 0):
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+			if (amdgpu_irq_put(adev, &adev->vline0_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot put vline0 irq!\n");
+#endif
+			if (amdgpu_irq_put(adev, &adev->pageflip_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot put pageflip irq!\n");
+		}
+
 		drm_crtc_vblank_off(&acrtc->base);
 	}
 }
-- 
2.43.0

