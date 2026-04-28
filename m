Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C03FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C3410EAFA;
	Tue, 28 Apr 2026 10:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mxj0a0WF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013069.outbound.protection.outlook.com
 [40.107.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E89F10EAFA
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0NPrUVEIQZGgenB0epTnGFyy1oy7K98WwHzDjFLGrltFqHuar7x/NvyWTzbJGaKxtxgBRmU8f0ewvevh5p+HLRKccppTeqQCV3A1bcWl/lsn84bP1ySx9y4jrDX62WkpSveYHxgp2fZ7hluPaK3/J7sqagfHI88+sCTmsqkIjAWM1M2GZfifxWKFOAWB/Q2M1Om/p/mHFMJlxy0uErngOt6Gg8ALvydvNvh9R+xWtESscH9qSnJ0GsDgLrb/bzsBppjhTShnYQZHKg6CEmmwmj43ZqqG/fvVKfa0+/VN+NRTdESv3kqcX/tpXt8M9VEhni1MSLuM4tPI71DkPz4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo75OJb0HNlz/Ka6Fs/iNnbT+8adowWq8iibooWIsrA=;
 b=RqIPzPL1E3MNryodIlOrHGx6lXDT50R3s1vY972fmaAM/3s5Tt5fDiT2MpTozdfiJnT2Qf0nIbElhfqh5JsLgRvIuIlwrOnweiI+S88dhjkII6arM4jj71LTzysBIu8c6UwaytiNbSBO6NT4aZSr0useC+IYacXpgxc9+CuUScHSwGh4HAfJUgTuj6uFNkrq9DnjQ9CBEDd+eMOoArsvuYrgzxujyFWVYC3pZVXLWmYRDz3L1UdF+5MCW003sTqpuNsq/0qh0kDeQK4SaZFpkX7wFuFfWH0gHHHRWF/sV/1dPeeCS5WAxEwgTf1UHTqoCOB1H29RlGxCVHOc+RfSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo75OJb0HNlz/Ka6Fs/iNnbT+8adowWq8iibooWIsrA=;
 b=Mxj0a0WFo8elXqFX+FWmhXFKqAXr+uh8PNTTbumXdwI89ObyiOw6JRrsiYYehwvDIvg2mupO3p/rhtqjH/T2Ef55Sg5WdFyBHFSXPVP/PJkMRA79hEEdwSlHc99RgxDweeWNmKv+kmugXrQbDyJdlFiv98J0KTFxdIuJYh8oMoE=
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 10:03:52 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::fb) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 10:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:03:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Apr
 2026 05:03:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Apr
 2026 05:03:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 05:03:43 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 11/11] drm/amdgpu/userq_fence: workaround SDMA UMQ
 first-submit doorbell race
Date: Tue, 28 Apr 2026 17:58:52 +0800
Message-ID: <20260428100239.1609179-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 811096e0-6fd7-44da-d485-08dea50d7378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: o/NUWDPxJrryPLDk4kPOZy7Vg25cul38wc9uuqdiSTGBXmBSVpoGvgjhmDvsYOD4TIOxeHjlASC/K/SxObjMnvllO9oL8EAeO+YEJkcYecDEWzjr3RtNarAKf++aUSubA8l4ZgtV40v2l0NMUxSG73oQIwbJRTOVsBOS99oZRDqUsOsUnX1Rr5V+FlfgEe7EWStzA7AeZ/nMofdWBycml3twjdSAT0iezS0tYqQsETdWECFc/neqTG/y9dmPcnXo5evIw7VIO+LH+HhxmfVDFrl7XPcWBzJ84cUkGlD+mEwzIJYCz/GuFZE75mA8Vh9RX3ePNqPf1ECPSuLTHaPhrUZw3iRdYv3UDijpoOl04KLwED16L/ZGZnmOthG8HBw67us/6w65g0NMLTyshuxTumOUYWgFgUms1+VuHq7D5uwbqvbMIuAJbn5KPT1mn4+JpgW8L13TFu2SdyM9Lm1o8DNNaEYf6Gr2D0uHXSN1VC6j83/OQc4v033ypA+CYJMRMxODMsmouEDA7eoJdxXm3jFvU/6Rl78tOhdq2NVi+nVsb+uzex374f+0I9K93z39/DCwEVQT94YNvLTTc659/FSk9EAQ4+S2qsPdjKjKGLsx6QskoZd/56MnhCxy2jOLsl9IOry7HOzgDpjGYNYA75CeEe9BkvKqubjm6aid3W1FYXxjRMf/lMcrEPAV8OCuzVGh/PDL/8bUIJ5sk53enaR5ih+L4GvVh55E7AkEgOKr24wz1KmEA41H3rq9FoDw5X3sYJEdJBbF4EMssikTTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: feyFyDQsJ0F3PkKYg+31HWPupLC4pv+d3pUgLGHWqkhaobKoZ7OelrC/1DzD7tHVrt8mNhuL1OJY0KApe6zN9GFiM/OohfEtw3QE/OcsGdFDgi4rfYRwAsbvuCUMiukyaJSmK7qWebRUxOKLdmQXTU/qG+sJXQzUW1NzNFYPbqi9oezWAxFoxAlYHB8zF+yu6l4JfU/ZPtED9PcoMUz8rU311WpYUTIH9TLutCwDTQ4pZBM8cYJfbeUHfCC5jXexpF3Xi8hZdKSfjgO8z/4BNb5h8gLUGRCqcXb3tYAZNMpV8BL+VCtkgWcZOhiDeaXaO2NXiLnKDNzv+cESflkDvaz5cWxJ0LUd4w/k3zgZWtgD2LPZ9ksu1boZPxhhtYhBfamgjkMmrUCgCJ5rS+r9cYKGPz30VfJjwkHsO+KyLp2aRc2/qsJjPxzfQijZo1Yu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:03:52.3381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811096e0-6fd7-44da-d485-08dea50d7378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

SDMA UMQ can hang on the first submission after creation because
userspace may ring the doorbell before LSDMA has programmed the HQD
doorbell offset. The doorbell write is silently dropped, and SDMA's
subsequent MCU_WPTR_POLL leaves the trailing PROTECTED_FENCE unread,
so the fence never fires.

Re-ring the doorbell from amdgpu_userq_signal_ioctl() after updating
wptr to ensure SDMA switches to burst-read mode and consumes all
packets. This is a workaround; remove it once the firmware issue is
fixed.

Verified by 100/100 successful iterations of
amd_basic --run-subtest cs-sdma-with-IP-DMA-UMQ run back-to-back on
navi48; previously hung intermittently between iter 7 and
iter 30+.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 6ef4cbd5d5da..d00ed5d4bbc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -535,6 +535,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto put_gobj_write;
 
+	if (queue->queue_type == AMDGPU_HW_IP_DMA && queue->doorbell_index)
+		WDOORBELL64(queue->doorbell_index, wptr);
+
 	r = amdgpu_userq_fence_alloc(&userq_fence);
 	if (r)
 		goto put_gobj_write;
-- 
2.49.0

