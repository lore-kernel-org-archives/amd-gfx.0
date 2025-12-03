Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC7CD12D71
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 14:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E98110E82C;
	Wed,  3 Dec 2025 14:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3itz5PmN";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC5410E82C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 14:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuC/8e4K7kdGYJsmwjQRt48FNhsOJ7ZYbmdSox4G7LLTO2mYIO8MGpe6NCirUOqWy+UgRD44/iKmYtG2sVipIr/eS5Df0NW+MZiw7eE6GBmBv+ZO2CP7Ey+UimYOOl1GoTV2tHh85KS2PuIXPOqtnqKaVR68rTjaJe7R0FivHtCIDfStcEb+j8iBxgzmxsD21MN2QRfpPdJ9uPVpYTckuMsJFtNr8BE+U/KqyIj18oRhEr8hZeT7/11ONM13EzxEidC+2WMKGF7Vaa43rJM/gcHtrA3uzbvsuNyhkL+XW1wf4xmUDppaQZSNWcZ19h/b1F63YbdDgUxTWZuXexeHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kvi1RsaUQAmRt3H4/gtgi9+m1SDxOY1yMNP2asVWpMA=;
 b=PL4aD6kTN6Ye0mJS5m6OYJeRA98cGYfrHZJYs5Vy6dDL8ZtQcLLHvI4dAqjKeKWux/REJat3Ztnx218JwhsoDkgmthgULS8zN305iRvMXTieWrX6ijI6+9pgn++ndCit1uM23osNFgy3hRRqHdlbYfUT1kwLBfKeTT0Q0Cnf1CLVfHlWTd629pGRB8R3VuoeHaC1lt4izkrrtr8Xc6XiQNVi5ojG65dGr1pJbWb6maceuuge9TY7rpVWqGU6NssCsJRm8Nr877EZV7QRLCfPiqdOJxMLM3Yj/wS8vthfRL2t40GkDJ96Ew3gGSgV86dh0/rKyt0PgkBdS80atHbVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kvi1RsaUQAmRt3H4/gtgi9+m1SDxOY1yMNP2asVWpMA=;
 b=3itz5PmNV6Mdf86O78EWByD/diu+0mJ7FDnW8QJ1g8PikyPPiy4aUPdJVyb6kHU48xSnxrziKOLbsWHm/p5YnVUJXconoXY/i9y1Un4MPdzs8Dt/TJhDXH2tqaxL3GqxA3fxVdR+coqB/les9qmfN/EtsWmHtctFcvsUef2bMPA=
Received: from CH2PR20CA0011.namprd20.prod.outlook.com (2603:10b6:610:58::21)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 14:44:53 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::f7) by CH2PR20CA0011.outlook.office365.com
 (2603:10b6:610:58::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Wed, 3
 Dec 2025 14:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 14:44:53 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Dec 2025 08:44:51 -0600
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH v5] drm/amdgpu: Ignored various return code
Date: Wed, 3 Dec 2025 09:44:35 -0500
Message-ID: <20251203144435.62300-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: cc68a19e-223e-472a-94e2-08de327a850a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pprZVs+qxr0rDy98uVBrEAQQ72auvv/dSwMQC7JzcOzIV5Q5CuMSln29wZj5?=
 =?us-ascii?Q?2r2/WlPqylboSL9u4ibOWZsQUagQk1h5kT6HSn7bwfVN0teOxafbAu/ZyAcI?=
 =?us-ascii?Q?tR5VZHVwsqQZdPOnHeGZTIagzVANHfBL+qCWh8GCRvAcDlGm4Mh4j0hbsQH9?=
 =?us-ascii?Q?nN+pSxjUFy0XKZ443xk801CP5TLX6oXBeqbw5NiTDL1jIIC1Mu5ouJJXHMe5?=
 =?us-ascii?Q?6/Y93wWVdANGVZv8LwqgRbi3TpTzMX8FCSgvJ+eDkhizKHmLiVlMyw8mLR7a?=
 =?us-ascii?Q?dnYi8/X4/EVi7YTBqqgBobGIPYi/5tMw/nC5tP2/66rvVpJYTzvhmoNUJwI7?=
 =?us-ascii?Q?mJx/sI5iNYcYTQpwaX2OV9QDEmAzsiCF+EVOp/GMHgiZrveTYMSQblr0DDcT?=
 =?us-ascii?Q?tMHJXrhaPyYwUI04tB2sXTCyIT3nwT3SBI1HVTzXnXvrSYtSv6Fq0+L4+X6J?=
 =?us-ascii?Q?qZziUlIG+P6hxLV6pSewbpRrJs0wQ2DHXUdvk3dg0mrBA+SUhVt8rQeiZ3NU?=
 =?us-ascii?Q?+Q4gev4UlDvYu5LQblNHrq9/xWl3xmx4dow8hrO1Fd+Wf6Odntt3y5VN7rYI?=
 =?us-ascii?Q?+bfwWk5Qgb3PFphALZwwZVNvSTETUJBkgB3CrMMt0EN6t0jhL0Z6h1AS01Q7?=
 =?us-ascii?Q?gSpRzre4CNnUwaUbrnU7YHWn4dc+5Q8ls7K4dIiXrbKS+yAvQ89FES2JnmU3?=
 =?us-ascii?Q?GWvS8IzLm3zSXdtu7bzF0HJ+fIYEU3cOAf7y3sZKhADg0IeRyiCcnWXHuV8W?=
 =?us-ascii?Q?0uCalTH6hkrXIUsD9T/79etp9IA4vm0uWcjY4/O6iHd/6zUbSULXxz6kP+/5?=
 =?us-ascii?Q?g+Q84UezxNautAPWEijkXhz5Hcu9aRBTEqwtNTi9M9meuH4EBMFrad+/aGqf?=
 =?us-ascii?Q?06KB6M6HaxICknbroD2d4quEWO8iPvrpeywzwL0rVzvgUHSHzS+AnsVY/mAs?=
 =?us-ascii?Q?IDNj16rUMQatLG58IjY5kVQ5wEZ6St9rDSXn3ZnOuU3OokqplObgwByzwg8Z?=
 =?us-ascii?Q?3K1u7d5DrA0d5BQNOatplSVOLsVZ0FzA6PBuGkVUaakbZQ8IHRB8Nq6p5WSP?=
 =?us-ascii?Q?2fh1Y6SlqlbTZIiWxuvDK4PLOHXhhqHAn95nknvvkYNnCXWmKDpSt6hCFN/O?=
 =?us-ascii?Q?3RUWnbu9+5UXQ9F2HBBpTA6kBS0QCpztLOY9Imu3fbIqBcLQiO0AihyEM/b5?=
 =?us-ascii?Q?yOMXEmoH0j+DmzktQc2IInWteMBxKdMreIuWKQaYJjiX4swVdSUIjkRmGmvK?=
 =?us-ascii?Q?pPv+Qv6bep8+fBB92OVRwGXQfds6a7V27BHWTOQ3ec4678eum934buELQHjO?=
 =?us-ascii?Q?YbBbdv5NQt3FMde1ILDJuvmBIg0geZiuP6D0o2xREINxjKf3MKjHEZ/oIfSE?=
 =?us-ascii?Q?8D4BrIUivcRHSqqNDPQaSzoEsV2oc5cl3BDlhfl4mX56eagAscmZH2gNSsxQ?=
 =?us-ascii?Q?aAqT0gSmiGR50EYp19EgT/cH9ahlo41FS5dXQ/gcmlg6RnJJkH1f0dvqUep8?=
 =?us-ascii?Q?pgYnL0HuQPFmLaNzhjPKy6eIgWFfjvJSHmkbHrPqQi+c2TqQGe8kotMBgGQm?=
 =?us-ascii?Q?n0Uh/PFzNf7Qpue53OU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 14:44:53.1853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc68a19e-223e-472a-94e2-08de327a850a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
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

The return code of a non void function should not be ignored. In cases
where we do not care, the code needs to suppress it.

Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 +++-----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 8 ++++++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a2879d2b7c8e..02259886f93a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -312,8 +312,7 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
 void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 {
 	if (amdgpu_device_should_recover_gpu(adev))
-		amdgpu_reset_domain_schedule(adev->reset_domain,
-					     &adev->kfd.reset_work);
+		(void)amdgpu_reset_domain_schedule(adev->reset_domain, &adev->kfd.reset_work);
 }
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
@@ -714,9 +713,8 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 		if (gfx_block != NULL)
 			gfx_block->version->funcs->set_powergating_state((void *)gfx_block, state);
 	}
-	amdgpu_dpm_switch_power_profile(adev,
-					PP_SMC_POWER_PROFILE_COMPUTE,
-					!idle);
+	(void)amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_COMPUTE, !idle);
+
 }
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 041237861107..66ded3c07eef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2796,8 +2796,12 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 		 * SET_SHADER_DEBUGGER clears any stale process context data
 		 * saved in MES.
 		 */
-		if (pdd->dev->kfd->shared_resources.enable_mes)
-			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
+		if (pdd->dev->kfd->shared_resources.enable_mes) {
+			ret = kfd_dbg_set_mes_debug_mode(
+				pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
+			if (ret)
+				return ret;
+		}
 	}
 
 	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
-- 
2.43.0

