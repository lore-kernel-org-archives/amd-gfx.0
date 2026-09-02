Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0003C624D0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A4C10F1C0;
	Wed,  2 Sep 2026 12:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IUjZYfCi";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A53110F1BE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVDZ2fxpXQTvYAkewb5yuJU9HUgf7iDtFNRplruRdxcBosmR5WCjQUigJMqyb4Gq3MTYSlwyS9CbiviLIP+vMrSrEdAbHOzmSC3e+k8zHz82/VbR3uOdeYGRE9+7v3i/PBFeIE9rSIum9y+wGKRs5ffBHO3ic0SfVS1krfWJeMRGU+MnGU0RC5ni0A++At2yiQH+nNKNVuOQYyz3sP+Vm0tEnLmprqVgpIWG908R/nexQI9T91XNOPpLiql5W8pDSKG8ohqC+NaGauxT030Fja4IDNJF5c8PrGW5fywaCL1epcQjOgi9DWJ06OF41g/tQjqduT0TNKOREgNFSWMdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LIUlt8IhRjF0lnC5Z4ddE37+UE0ZKjmax5SEUdioAE=;
 b=R4VY7cTezzaQ/G102bu2E8yiYSZVVfMNCv4YGGk46cIp1W0Z7ksuYdAdoaJ8x11dkBn2IMWNfmQG/NaIR+k/5GH8PTcyToRCduxFWL0r6qwY95pdrqYXTLsedvp530MfGK7/TBEt6n+Sa5vQ69bGMcJiGg/nFpLAMmXBSZ8tm1xz20GPKBRoLeaRa/1xJ7VGpVpPy/ef7iPTl3K4o14+vitsHfNI3duxv7uPt3hubdFsFRrHmN3KunrITHFt52QKbOFsZr1l7vNfVg8nKWunbtNb7wTvCnREjm8n3BtPtE6vneWTtuXRHMgN39YiSLoKfkyBRmRO6dKCTNBs8+MfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LIUlt8IhRjF0lnC5Z4ddE37+UE0ZKjmax5SEUdioAE=;
 b=IUjZYfCiTG9duLhhN+ferD9WqV/p9PNo6xZSHvaAbmA0rDQGtlFi4yUdNhoWTCrr3NCEZTtL3EnKwMxiYxaT5iM7kEO/Kzl7/PjX1d5nbbfJ98dIUsZsGyRIyNP/LrL/KhgAqNSb0b6IdNA3odaW9eVK1gW1rYF6kSKva1ftXuI=
Received: from MW4PR03CA0296.namprd03.prod.outlook.com (2603:10b6:303:b5::31)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:41 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::ad) by MW4PR03CA0296.outlook.office365.com
 (2603:10b6:303:b5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 12:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:40 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:38 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 17/18] drm/amdgpu/userq: complete userq eviction fence in
 pre_reset
Date: Wed, 2 Sep 2026 20:50:00 +0800
Message-ID: <20260902125001.621629-17-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 675b175a-15af-4d9f-29bc-08df08f0cb18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: nNkrYhle5TUeIYKhhvcMOq3Bhq3j5krVlg9qlH4jqhJy7oqH3XQx2m0crkwA7kMbeUFkec1wHOkpPQteCkgYL2suW+am3KK/Gc6+k85zAhcugRUhUQJxtQFER+TFLnKIC4Fwy9HlKv7W+XtBfYvByrjhKjqFCjX81olPkM2W+UX+hvByvtNalvjvdHhCZfEFclATWoNugWOYNeWXCgI5GABZAwN5AOGAp/umn7D2tQG/Sv9pMKW702Utv2eP2EkutJqzhN0ICfPE9hXcYpevClMzqAtxmy3y9DpVeif8ZHkpZ6GD9X4k3FlAOrINAR8SAdxEV+MBCIytxhKT6Ul0rx6XF0UNXIhjr5f3VEkkSFzmOD7rpFGaEj9pmvJOXsjxZj9KxA6/sJAizSZErtlkfyh/RycsyMxdsaGXZcFURwK12DsxkEXXe/Y9Zcr0+KqQPGWN4lgbjJ3VQ5ej93cUV9kShaIuczjQa2mgI2M09KQ3DmpUpThknukwjhyAF9ggSYvwmD2r4b7dxfkKM5NaWpuxe+SkCHqj9DuDHH0w/+P5U8l2JgOAG0qTZAxU66Wm8ZiAF11oWKT/tyJTgvNpXgqYlt1Zthk669ayj2cm+qRF0rOCMfCND4R62kYcLf9K3ZAhvDhkHW3H1YCiZMt0IqNEzHsnrAy1IA79/pXM6kUcgbv/AwvxkRERM9KYCWf80ZMyxTy6kwcgltPlF3uMZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NvIGlRjSdQt627b2nhVj/klvP2/ommNKBgjm57GMTmIu/BoGGYEWqfFJrteqo6t+6yB79vWHJnObWiWRjezokEB1kAG34eGwHZEXXhjGyb0jM7776woS2xO18zirDNEo1KweAyb1qAEb+cmpzWseOr9xJBoYkwG1SZ7KV2X9yZsfqxb5OUeDHAR9GYGWwoe+O2MCUt4ww+maO0zVZoP9M0x2V/Dd2wYQ3D11bVdfbE6VZY2kOcvPxBpDvQMJckxxRLzTQrW3h7E8C6H97hzj4RTLUA9Ihk3M4s9rudaD9lu9ZHhbqT5t2MS5SlLuXvzd5o9byuKYIcmpcP9qNB8RroR4b+JMFCJ1lrNOV4wgtjEF3OZDh9fv41z18Vgjzcs6X0P3597WyAq0tOAIAjkyMvzJGToZmx6HbS9KVg5EZ/UNil7WrCgVBmqUiSklZjVS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:40.1156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 675b175a-15af-4d9f-29bc-08df08f0cb18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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

Complete the userq eviction fence before gpu reset.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index b556fbb1c31e..49a938436b08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -443,6 +443,9 @@ void
 amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
 {
 	struct dma_fence *f = userq->last_fence;
+	struct amdgpu_fpriv *fpriv = userq->userq_mgr->file->driver_priv;
+	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+	struct dma_fence *ev_fence;
 
 	if (f) {
 		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
@@ -452,8 +455,14 @@ amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
 		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
 		amdgpu_userq_fence_write(fence_drv, wptr);
 		amdgpu_userq_fence_driver_process(fence_drv);
+	}
 
+	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
+	if (!dma_fence_is_signaled(ev_fence)) {
+		dma_fence_set_error(ev_fence, -ECANCELED);
+		dma_fence_signal(ev_fence);
 	}
+	dma_fence_put(ev_fence);
 }
 
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
-- 
2.34.1

