Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C9AC021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 05:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842A510E39E;
	Thu, 13 Feb 2025 05:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HcLr0C0K";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0090D10E39E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 05:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awktclMr0VUdA4yeDse5/8H/X6j4db0BOejDuGdzSSwB05wp7trbfFwGtEUqilw7l6dyG1CQ209Kg6xQS1YwEnOb6/FirwS1NaNLFjYgyr2vnjhrd5V0X6CYhZqkAjv1W5KZwXXPGV/UVxWCHENGu+4hYGZTDfLvuXm5K6Ir7r9qq+6KQxnr6q5ZQ6/s5aKdSm7yptC1T0cyg8tXlBy2Tlv/uAE6Hg/2cmE0+T6p0b13NquuEt/OA45nf/ro6EBa5PqJEdxgKxHKpMgIOFhzyrh0/JbYJlTTbfFfYct9ZDimrbgWBg4J4doCh/Sqd4dXF9IXqROL+YRMJaxzDHvIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWHbIsYIsWsLBQE9S/naLcMwYwebXVV99vq0dYJmOvs=;
 b=OvoYMMFNpkX50pIMji2T6KtjsAlzGWazZIRCK67oswseFAXXXwyUCP1lwaqK3A1aB8aBqeMYHufqls3Zatgn1rr2HkWgDyVHO7MsT0VFF6aFNqLHPAkOJDNYxGef/uGRB0NeRMtPjcGAwI6pP75eNdjY7hDJqEvfu+4fGifmgH2xjaCxDpwNux6oQ1AlVw7EiFx7UHQIluok5eBgKySfSsMFMHvtdK0eo/tMHsp7nVvPx8h/NfKRvaO+yMTLaNQhl4MAR/TDgy6CO46nKIGmEzy4R7AAeL1qAHtQdm4YQmPU2lglWkNhKkLtKl2QMW8SzpS9TIB7kDDIu4dG8HHMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWHbIsYIsWsLBQE9S/naLcMwYwebXVV99vq0dYJmOvs=;
 b=HcLr0C0KB004gSSVZ6mp1WEgfr/+1tNG7dBftmyFA7HqZ4s5H4wk6+VQYfk2TKU3NE0Yb4HHxA8cQKDPHyFh7XTU5wt4kwv+1Rv/GCdzadHtTeZ5z2TBL9dNiSF8KxhH+xeg+K8vg3fLppf+IL2DQwwJAfP3OB2Qm03e16te6Do=
Received: from SA0PR11CA0135.namprd11.prod.outlook.com (2603:10b6:806:131::20)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 05:48:18 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::c6) by SA0PR11CA0135.outlook.office365.com
 (2603:10b6:806:131::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 05:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 05:48:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:48:17 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Feb 2025 23:48:05 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to check if the
 ring is guilty
Date: Thu, 13 Feb 2025 13:47:11 +0800
Message-ID: <20250213054715.3121445-5-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213054715.3121445-1-jesse.zhang@amd.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c856668-0ed3-4f8f-2eeb-08dd4bf20436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TZ6IIoSGezlgc6gVkED/ztpH9O6gFIagJe4avFHc4ZZ82C1m2iyjXcxkLiNx?=
 =?us-ascii?Q?BLDWw6n7am+T10V/VzpCqPWdINjcCxzaG/IrGloEQ3R7FaEcOUgyN+NW8wwS?=
 =?us-ascii?Q?h/rUldxbjV2s6rM6LON8eaAEUyrgf+GEcwQi8OvrUrdvDoxfhKk/IrY41j43?=
 =?us-ascii?Q?xngWVhvdV9zDrxtk5+yWw+F+biPJ1J8qmlCvZdy9zpFVtSe6lyvj/OcA9KN7?=
 =?us-ascii?Q?CrzbNtxn0n0gnPV2ZreMpEeUsPVjvFOMJVBVGL13QM5Uad86bz6KEulXUncW?=
 =?us-ascii?Q?bWAVjS1GvkUtBSmclZggFy01vO3lk5bEAKJAmT8wG8XkU2jV5HiREvVc92OZ?=
 =?us-ascii?Q?qdLON2BjthpXdYhAWrpnzu20vqm6tpxynJi/aNvpyeK7WwIANZI7HduLHKVj?=
 =?us-ascii?Q?xEQe6zPVHUpb0DmIDcwAUdlzvs+1hpjVudI3WHaMw+I5gxj6n8Y940tg1CrE?=
 =?us-ascii?Q?6vh1Kw2dVX98i0Po5Dut8hYdPpz8HaVjFTt9/TSRGIdrt+f+huDjhOiGLRk8?=
 =?us-ascii?Q?rE3JCuMdDL352iT3/f3naV8/Sn8wUBBw3KojOBSik8OurfMKRtp1kw3RcM7e?=
 =?us-ascii?Q?EUrDLERt4OTIUnkUtMb4wkbjL8fYEe9/hhdezV+217x9AsgkrFzKF/U0VUkm?=
 =?us-ascii?Q?l6wWypeevsFKc9D9O2lTnaAURLYb6AxjjPWHsWrctUCu4eWbQ2j3PVskQQeu?=
 =?us-ascii?Q?jPws4AzqgP8ySdwJgkA1Ngtyl58SIrIRot2ewLOVp8cfeewngp2XR3pJ4uAl?=
 =?us-ascii?Q?4qeLtpk3UWC+M+E3PnNNlZdga3YfJKDCMIodLbN0GafKHDmkK5787pCWlOSS?=
 =?us-ascii?Q?lXN7caBvF6SQD3UVA4ZekwjF23gWs7BdDvC9rhHCkAgqWkRIbfdGWZ+b+Khb?=
 =?us-ascii?Q?yoszlwrfPGfKU5qmEWRwe0OONyawJdKoppo6WlOOJsoXKjaeRGyATz/+kHUc?=
 =?us-ascii?Q?lo1KABqHM+xcG+aIA2Sz5Y2sOQOncft3p+hCdE6/GCamH6ZnFGDy+FZRn+9l?=
 =?us-ascii?Q?HLZRsiL40jYDXnSwzfTI36ZdkSAIdEqr7TbQj07pTJIbTL9qTVIQgCHC9J8Z?=
 =?us-ascii?Q?Qij0lotR38yWEyQrHKJNVLumsNympsZNsDR/VTtH0uO6iDvYI6IEsoMPouLR?=
 =?us-ascii?Q?Am3Zj0il2+vAdQjyLM20gWgf7S2w30avYhWRSRI78HNOTD4qGPmw+wvJyRRG?=
 =?us-ascii?Q?AId8QbuSgokUg1ndEx/V+r7ai1oZcwt/boJMTF4EFAsuq2ukfE0pcJfyrJ+P?=
 =?us-ascii?Q?e1UfsuI7qnl8iGO83CAmvG2xa6/8dNmROhunOdol+yLdajnpSMtX04ogS99e?=
 =?us-ascii?Q?pIHOCZrVXHnrVFrKL7mt5CGDc2xPlOX/XJEb0q2EcrLU8k1utv6bayzUFqL9?=
 =?us-ascii?Q?vuQnuAC7Ny6fEmUHmO9IOXfo2DNNPQGaVTUaaNvWejGBdJDQSoB38paJ+5aq?=
 =?us-ascii?Q?PV8AiFELG/PxgVeTV9EM4W3WqntoCGhBcxmYe5xstAdVRgCzBKvr35kIkrAJ?=
 =?us-ascii?Q?QCeD0VLpr812A68=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:48:18.0525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c856668-0ed3-4f8f-2eeb-08dd4bf20436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch updates the `amdgpu_job_timedout` function to check if
the ring is actually guilty of causing the timeout. If not, it
skips error handling and fence completion.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 100f04475943..f94c876db72b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -101,6 +101,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		/* Effectively the job is aborted as the device is gone */
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
+	/* Check if the ring is actually guilty of causing the timeout.
+	* If not, skip error handling and fence completion.
+	*/
+	if (amdgpu_gpu_recovery && ring->funcs->is_guilty) {
+		if (!ring->funcs->is_guilty(ring)) {
+			dev_err(adev->dev, "ring %s timeout, but not guilty\n",
+				s_job->sched->name);
+			goto exit;
+		}
+	}
 
 	/*
 	 * Do the coredump immediately after a job timeout to get a very
-- 
2.25.1

