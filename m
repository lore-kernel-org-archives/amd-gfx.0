Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF3CE77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 07:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E1B410E0FF;
	Mon,  6 Jan 2025 07:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4MB9/cdT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7747E10E59C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 07:17:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RL0MmoTUu+BA4AEfSp0uFzmnLoEEVuzc165Nh68xQzobItpD3dkv9auez4DJ3/Xu/fVPbUxRAFBfbAoy1GCsja2XRipt9N2aV5GrCuZODIE/0Ycn1s9kYAkLhJuCdQ8NAXQRPXFx6uQZ2UchZbjQxnuM8Ok95WfPv+hcOzTJyi9wjg1jw+v3ujvOvHmCN3p/SLSplT/jJtaVP3S/XKXnLDKPdNIju2JMGcH/GQmHBK9wckJE6erDV3xI+6TRGb2ZulPqqNeBSdq4qvvhN8mP4G5yaKYV9DN5U3B3HmGeb++gLXROS1tNZsr97t9g9YtqdNTZF69OOwW8SrGRrxacvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUMeLVgWCjRtmYrWmX0O+58K1Qekcs2wnFpDVraIhY8=;
 b=wiOPmfvxgfHvNlmh3164XuId/f39JZ9+ez5goqYOK9Fl2DHkpokMAa9cvs+OCqxO0Isq0XPFnR5lrnrov26WTwVobcC2YtIIzZEvnTppFsuBKSqc0u4/zTryfJDYYpfdWGBENbiYKrSfLbOF44DfdxoZ1GNHDbd6tEj1bCBeCdZM5HifqxsnFR6/0gUdLEMoiVF/VntquAGZnPX09IHco+B+1hkaShSpSTGpFptvYXES+iu/1vVcWrr9gaqHWEHmUPFW+LUTE3JYSBgZu1p+P9Mdn2YGlqCQEqykYhNsTLXg5utTcmWuF4D4TgOIpHcGy4Uz+vrt61OUF6P4Umgz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUMeLVgWCjRtmYrWmX0O+58K1Qekcs2wnFpDVraIhY8=;
 b=4MB9/cdTl5rgGYft7VVXUOR5NEWFBePzSBL7EsDizOlWckcbOOVo3atUCwe6sf9kQeIm78Tz/FV3t0c/X+1eg2AchQj5dypg/7E+f5MAZoUcglJGcifm9BNCifzunqF6tUgv/GQKKysalf8Hpu0CbUGDqYFrS/N6KtFNAtECqWE=
Received: from SA1PR05CA0018.namprd05.prod.outlook.com (2603:10b6:806:2d2::18)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Mon, 6 Jan
 2025 07:17:20 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::94) by SA1PR05CA0018.outlook.office365.com
 (2603:10b6:806:2d2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.9 via Frontend Transport; Mon, 6
 Jan 2025 07:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 07:17:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 01:17:11 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 6 Jan 2025 01:17:10 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <Jiadong.Zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx12: implement kgq reset via mmio
Date: Mon, 6 Jan 2025 15:17:07 +0800
Message-ID: <20250106071707.2561665-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250106071707.2561665-1-jesse.zhang@amd.com>
References: <20250106071707.2561665-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cf209c-6185-44c5-fa06-08dd2e22284a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3eeiiZLBMhrmHNX9L9h/CAseJj74xEgoLRpjwTE5J3XKxqBleEuPHAihi0kW?=
 =?us-ascii?Q?QDpO3V3h0DK0YLMIo3DHa4Pjx435RryxqalOorBWxT0wtnZ3bh0l6bQ4AIbb?=
 =?us-ascii?Q?bLjJV1zrB6g+6olk/ksuHfBEqng5PwQP6bVszdAIXJHCFFvcyzPBA/VPm1cl?=
 =?us-ascii?Q?CSxWfF2OlKEZT7fWLaDCCdhZu2QwxQJLWEjcvYO4Kg7CF4pWMrleBt94ysNG?=
 =?us-ascii?Q?5NfzzEXtXHCrzPVzwxzxBAJZb/vmBgf0Hg9sz0xlJku7TpeUFboJ1BC01/n8?=
 =?us-ascii?Q?DmPyJlfO8728nUEkPUFnW8A+X0D60Jwrq52GTePX9/9NUm8qFNQ80IiF4QZD?=
 =?us-ascii?Q?RufarPWnTmSBbieaca13fl0Jr9o21DmAmNdll8jnm4plBl+fO9kbYXA0BPvX?=
 =?us-ascii?Q?o2voVSPbMr4SYMcrB62GpZM7E/7nkanMGhSTJNm99bHgpwowCtKVRatoGvTy?=
 =?us-ascii?Q?ZzGhEBc0DikJbs6vKYwozTyQlHnzOUdSa2t9HEqYkxm72k5p7yJurQl5Bvrk?=
 =?us-ascii?Q?C1J4/3wkGhoojzPajOVSNx8GbED2B7vxPN750sDQD7MGXANyIxDRgKl+HCpy?=
 =?us-ascii?Q?8VkKTyjTV9XNMoTnKwMGruCTDHUKn7AUHRZFRN+8aKlM2bDMFTRRFRNDMAuw?=
 =?us-ascii?Q?7iXRxM5gT8mdHNi8ul6IWrVctlP8ly398z+pYMsv3LLHckiJvwOGtFfHSQL+?=
 =?us-ascii?Q?NcIzcLTMhociWhkzaPw50zsfspIN8hovk5eKJXPfIeG2p3W8VtM1sIlydbt5?=
 =?us-ascii?Q?FWkElcUWK7Tp352SnNPcGeX185F6AnUoB3BwhI7tci6kRqeEgFKWn9Fnjm6Z?=
 =?us-ascii?Q?13arfSio/7spdGW0Y91Gnhg0bhp38qyLwML/54DNmTFQDD4AkuEhGMpgf+dr?=
 =?us-ascii?Q?PPjebl1OvaF4VPivMxnMlz0U2mBqxrtD7Aq8GtWtExwolhH9++vehDAm5RmY?=
 =?us-ascii?Q?xwsIFBMuN1Pdv/PmR/9PrrXDhyCjIQqpAkfQbBREAHPHIoAAjLGx3HArCnGB?=
 =?us-ascii?Q?eeUrOdH97r6H79L22abbjGKSe1A/SKyqWLAS08n7jAHpO7HkutJuCa8D7d+r?=
 =?us-ascii?Q?0+dGGCdhNa5BF3weDmI0ZPocarrRMEsehiA6lSY4O05vgtmgA2E+x1KM6aMr?=
 =?us-ascii?Q?s/wO7qozhCo/6RpHGVqNHJbztHo8WxRktuLOx7LG7E/H1l1odnP1RKuMteZi?=
 =?us-ascii?Q?D3bkRTwU95mUeI/2zEotE4kfrJqLeuK7IMVeY5ZTYnmomOuzVe293lMMsIup?=
 =?us-ascii?Q?IfCQVoWXqEeLzqPxgFUQoc0ntW0y1bmNrNx+6ZOOKREntTe/h/vrg6KaJVsU?=
 =?us-ascii?Q?d8lckphLtWyHc0evp2vnO7YaPM8h3wAiYOUWGXksdL5mUcta/fJxegxhLj3z?=
 =?us-ascii?Q?huMFDarMx2lWUbySJuqV3KbPUTc3chzBooGOZrW9Wnn7D6PwC6nCfSgh3boc?=
 =?us-ascii?Q?lVx62qQvm/mBDgN94248w/WWrS7XGPHBvT+CJUvKCvwvymkHnj2Lriuv6q1f?=
 =?us-ascii?Q?dVePB80s/q4VBsc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 07:17:19.5465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cf209c-6185-44c5-fa06-08dd2e22284a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
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

replace MES kgq reset with MMIO.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 69941442f00b..ba2ab9296eb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5254,9 +5254,9 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
-		dev_err(adev->dev, "reset via MES failed %d\n", r);
+		dev_err(adev->dev, "reset via MMIO failed %d\n", r);
 		return r;
 	}
 
-- 
2.25.1

