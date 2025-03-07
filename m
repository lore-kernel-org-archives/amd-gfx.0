Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92FCC19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 03:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B94C10EA32;
	Fri,  7 Mar 2025 03:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iCW+PQAr";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001C410EA32
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 03:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCbh+Nx06hRW1CpjeIrPd1K8plQE5lnqNciKexRD26AKt9k0ivRpLKykVmbC4EprYp+YZaIKGXZYL9u/PtR4qMee13QEt/OjMxxh1uwtW6PPt+eAV/D8eGHtfCjJSa5/sz/Iwel3UknGhpGmIdnMcQoP95yhFq029fR2VRYKlPUU90BB1hVAsFx3rdeUbIIDIAOyi+5otYLpnZnQLaUBS+w5rrGguf4WMO2LxmGaD+qET5SqHmQ9ZmCXoXvVDFEQ96PLIuVl/ysrOIXJ+aXwX0CPp1oc3hW9KJI5HaAv1xZBS9YJWxomU8ww3En/TfOIJLuiWrbf8S1gF8Q2z6xhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZEDIbxNdCse5DcGGZuK141SNfAMiSXXSU2STmYs7iY=;
 b=ts9ic0FfbOWRtKR3VHA/YLPQ9a/mjOeACg2J8CHtuiJcl5vYIBrn205Xj8SsSdpi65ZOeyAcXRfyYeXC8K3TQI6niQZFB06RwiLzlfJ5qNYx/++vesN8THWimH7K6fdeaLQ3Bv6GGXGF4sCf5cavcV46jT2idysNoAv6qE2tgsNJe9mBvibwlxwbrMR9AG59ZGNpXlsU/Vq7dgkDVWae7mZxpJGVyyhaWtIx09pUj+7TL5t4MrH9HBM5VyYIhe0wXab8gZYDilVT/4D3MskbxmEV7zSuQXe5+LO3HjRyjtHc1xwlPLry6LOnAkxVeAnPDuo+UExWVEUKRFPINTd1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZEDIbxNdCse5DcGGZuK141SNfAMiSXXSU2STmYs7iY=;
 b=iCW+PQArOgINBc1Ylx82ahvG3R47fzaZ6zfmjELUdU7XaxdlmT6AokqL/pOTYpvL7E0hmw93w5TRS0znGK3KCD/1WbLgz8M/uORQwAcxWCXrW1RcrzpDyCgdNq2zdvTCAy2dWSvogko50yu9NwhwELMc7S+iMzexa5A/neekZv0=
Received: from BN9PR03CA0281.namprd03.prod.outlook.com (2603:10b6:408:f5::16)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 03:45:02 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::77) by BN9PR03CA0281.outlook.office365.com
 (2603:10b6:408:f5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Fri,
 7 Mar 2025 03:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 03:45:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 21:45:00 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 21:45:00 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 6 Mar 2025 21:44:59 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/display: reset the workload type when using MALL
Date: Fri, 7 Mar 2025 11:44:57 +0800
Message-ID: <20250307034457.595790-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fbbf6f-08f7-4057-e590-08dd5d2a70b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KLE3mpsACjz1j8lKI+vi/AmI7YMFfsh7Ol0VfdWZwt6dC1yGbDTFhfV5fBqh?=
 =?us-ascii?Q?UvyV6C4FtTVG53NGZx8rFYHdJv3JySBYgqonAVnSy1MCVgJF1j1C6Fk8YDGn?=
 =?us-ascii?Q?bU9mGjnn+ptUyZIO1Etk32dKPr3oya2tdcFMGA431T+1BjBFenZULeCywRsb?=
 =?us-ascii?Q?nTPXsdEtCnwgcFgWpdnVYUaGknUinGcfT4YU5aUXN32lqOxMK6aO4rG7hCdk?=
 =?us-ascii?Q?dIW5HiVKLAliuwkgYnq6p/3eRy/J4fEvE3zLjH2hQUN1e6bv7PVp5HKU3tio?=
 =?us-ascii?Q?USAKpAj7nBD9dLucOTrWM/4mMEnH25UDMFKPjmTXGwxdtROAkmR2P0dsXI4o?=
 =?us-ascii?Q?56DJF6XhOAb0s21D4R36aHlVX4mQ+xhUh8i+he9nNZtYeA5JDfn6Ozjckmsd?=
 =?us-ascii?Q?mvoI4/Qd4GJMoYnfqir40JgUlsMdAqENZfcUjNBHRFCJjJB4ZO6vR+VNc9dh?=
 =?us-ascii?Q?qkRUdkGuyp/r1rqLH+wFMraZrIH4sW/5UU5nfXTJ34mWtHMZ2OEqRADROolN?=
 =?us-ascii?Q?p9+yZp2OwwfrC/qLMnJL0P7eT9k/Wr21l8cmxhSSJU+ccJIk7ZZGZ0QRhV3w?=
 =?us-ascii?Q?gWcG02lO1AmA9KfOhjBorsHEyNn4JLanWSYrfNNiCTquXILZrv8fscqOgfp2?=
 =?us-ascii?Q?j64uH8PeVXaSY/v6XCF0/t1vTIGw+1/zWYnh6mBajBjhi4SnDeUEA14WJV3a?=
 =?us-ascii?Q?x/R2reJZYlJzJjO5BEzyhCvqHw7Kc3TfmQ+QTAkWcbbmjgfMwdQWIaFFbOWS?=
 =?us-ascii?Q?xvk73vk1Befp1lkI3kubLvpuuZwwIraLG789xqcVnltnJ5aGVvCJag37RUG6?=
 =?us-ascii?Q?qHTcLUPP+dyF3sg2IYAS2+E5olmnFVqnjdHAX4eJXV2GDUSALvYXuYpmwNEc?=
 =?us-ascii?Q?BWJhHe1NKB3+uGIEssG9NigS/PnRMHUynvXBMoBq/hs/8wLfy+X8kiLVm5Mu?=
 =?us-ascii?Q?1GXElOKpQ0rBwPid8Cs/LmaoaaOWwr8oKEN03GRWUsIevB70vKrmeO4LWgQk?=
 =?us-ascii?Q?Q6oTn+bFLYCr6bZabc6nfJAhPSnNFhAvT6z1DG/f5aTNq/Pcz52I+QviiHIJ?=
 =?us-ascii?Q?kGpivcAKKL2NycJhpLucZ2alk5W0i+IAakGiPEp7RiQYDp6PcXVeUVJQSIc2?=
 =?us-ascii?Q?xexhfmHvHaDDtlQhJIBrUREJ8yCfonZPBgNn7K77ujSqiFpssVlhNas14GDs?=
 =?us-ascii?Q?y7KSnb1dJSEL/wkD1yNyq44Zl6+m4KIEPZRGH6AkCc3r6BzL96uEU6w9en0y?=
 =?us-ascii?Q?0FSsCFWjplSNoS37zyySCVVpQFt3jqEN2IVMYSZ0Y29qCmaL3WlbYCQeuyGo?=
 =?us-ascii?Q?mH777qOsmJXV+5yJBkSIrCqLQ6oaFrU4qP1DSX6+ZNXf7+4/C4XA9wneIhbX?=
 =?us-ascii?Q?uI3gzA+qPXZSl6jr0wJDbubwjsILly96qAavX03XJw+5e8SlTrVpDO0HciOb?=
 =?us-ascii?Q?hiqq4Yo60cjdNV9+yF2EpLWR90N/3wYmvaoron2ZQoV4j9E0CE3A8J6nsyYv?=
 =?us-ascii?Q?bafKZ0r7bc0HajA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 03:45:01.7250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fbbf6f-08f7-4057-e590-08dd5d2a70b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080
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

Reset the workload type when using MALL.
When there is no activity on the screen, dal requestes dmcub
to use MALL. However, gfx ring is not empty at the same time.
Currrently the workload type is set to 3D fullscreen when gfx
ring has jobs. No activity on the screen and the gfx ring empty
state can not be synchronized to each other. By removing the
3D fullscreen workload when there is no activity on screen, the
event can be passed down to dmcub->pmfw, since pmfw only allows
MALL when the workload type setting is bootup default, then MALL
can be really used. And this does not impact the thread to detect
the ring jobs and can set back to the 3D fullscreen later.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 36a830a7440f..154936166896 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -244,6 +244,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
 	struct amdgpu_display_manager *dm = vblank_work->dm;
+	int r;
+	struct amdgpu_device *adev = drm_to_adev(dm->ddev);
 
 	mutex_lock(&dm->dc_lock);
 
@@ -271,8 +273,14 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
 	}
 
-	if (dm->active_vblank_irq_count == 0)
+	if (dm->active_vblank_irq_count == 0) {
+		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_FULLSCREEN3D, false);
+		if (r)
+            dev_warn(adev->dev, "(%d) failed to disable fullscreen 3D  power profile mode\n",
+					 r);
+
 		dc_allow_idle_optimizations(dm->dc, true);
+	}
 
 	mutex_unlock(&dm->dc_lock);
 
-- 
2.34.1

