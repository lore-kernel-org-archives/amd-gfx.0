Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA69CD98E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440D810E794;
	Mon, 15 Jun 2026 23:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EkENBaLR";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EFD110E77E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4/5SmFiAuq0cfANjJTisxVHxiFGn8zCMFIw+1eAEzVx4Pb1/1JbDhYbUlgQbeuZo+8m5JIFD1WLbEKwVbEGRifc2DLj3GmyHkXYwU8h+o0q+u4/CKG1H3mVDuQF3g7GW1zElmXoAYKT0dHTL/QcpPCI9fdi6Seuim1rt4o+7z+B5Uty+kFaIaq0PciX3By3y8lqKu11t8tIYn3bbhn6GjHVHO6tzDJ0//7uL0qSxfKfnyVDUmBu18wzQTfzogwSQVfkU+HZBTNQQZER2PTaqmnehxuTF9oJhvc6DfzJ7Nw9k17bUXRBzbFPGMAiHdp1eKL6lB48UcSVumCoX7LIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyNK+nMzl3mCOyUje3BTgQJ9AKD6W38Y/Ha3rGl+mWQ=;
 b=kzJrcwtLjJmS0GJKVfCEDHmLsVUURGIR5lXtTlrU26JLN/fePT/syQUIKvECjsPeC1o4/Bbxhf6rMWdFxwA5utvvHx95/tUPwKdpTU0AdZD3Uy3o1swz0ebPEoswpc7Qi0JN7S1KzN102JJtc/45YMK+gMi6/erd5fl9LHgNeoswGxuB74uNp5ZPbIeE7uzLwz9GQdBSI8fav41GIFFSz3n9vJk3LOUy+1qwr0d5X2LeKssgre76R9Z/a8lW9FFXn+Foi5OUfs2e8bcP0ovKEpmGLUCoseXcoi32g5Eu9AjQRfsPkKupwKpZS1VUWhI8sdSlCS3N6y5jQWGr+Hw87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyNK+nMzl3mCOyUje3BTgQJ9AKD6W38Y/Ha3rGl+mWQ=;
 b=EkENBaLRGc01iUU+SaFbzE/DcwLfyCaMNBzHPQ2fDBkKP3j09At8/U3jsu55nwLMxLYuAUa07DD0atz1XpYUL8zuBeRuwg/AAbZq+yG2FXLgd9LQdjJNhu2QWNA1qmT1pbL+1fdYDclzZ/yC/aRO5vhFJpxCEkz1fyNZabDCHmw=
Received: from SN7P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::17)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:17 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::87) by SN7P220CA0012.outlook.office365.com
 (2603:10b6:806:123::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 41/43] drm/amdgpu/gfx11: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:43 -0400
Message-ID: <20260615235645.737189-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bc5f82-ccee-4086-603c-08decb39d489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UNJhfI2CpWehcru0iHtb6qDa3CBPReklPDeYnZ0uwq3rbaa08u6I/MvlrIBBtLIJhd52eesAamr0EjNc+4Q+Fzrm5LbnKQld5kaG3h9OSTirS4UABnF+LKOTmMQaeBLBTMUJRCjOQVTtZsuF0L4PRssO66xraZa8xbNwtlkiiLpcpLn8AcJs5Es3DHUFlZqr5t81Bp94Pa4wsHVvua00bbmiVJcwyR1kK5iWBUaxFNeNcZ7KbCXBuHsAaysGLm8WDfITtXsli5QtV6Mo/+11kXEqDFsUwzYSfgnDEQTco398hmgGYF1kzosQcFbWXFGRlrhhW7ky/lzQmHkRdBS0X8ok4zExdj6I5VDHQJLcLuN0yVOuNmqwr+BZUt9/bMBT1EV3DK1c19NShJ5DCIp9VY3orp8VwN/Zd6sgtayTjCnESgozTHCtLUxgdlKTGqAkS1Php9AxaVuB9lPLMCGhFV2TtgIDX249Rayp1zvnph81lwHWDUrcjGUuqlWEKXBzFp80ivKjVgSJXkY0wI0nc3X1lNKbAXGWsCwELIEK3ZOJ84Uu32XCX6f4YigECoGk8lExpF6JfpGApG3/WsVZTgOqi1bFERenBjhO/+o0da4g7ZEhke0hF4fTL36bY5q2Rs6rUrR8Vh3rGOdFT4NGjrdDSPZea5uglZWc56ZH68i3dDdy7CJAYmP6FH/C8pIJCFAHE9JcirBVYWeGdpN8MFzqlcygGyUBSCHp8gDQLiE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8bJbp1yFqwwvaf20L27qetj5KQ7mwL6zIzPWY2edKbf7PagVXtCigUIJEu407cMvcVy3cD/wLth8n2eLxg76ZwoJBapqDg6NLgNwRBVOqBUPh/MUif9qv9wZqlklkN7AhnK6JS98tyMczLb0fBIT57KKHjKJYzpyKXnfD15UATsBFnZfyGYoW28cRSUihrO7znWfzJBJOiG/OHoi7e4FrtaGcnLe5ldyicIiFDizvBTkP3Tkyzwik1dXvDsS69nyGWkNe1HnvFDWCj29LeVhLoZj+zu2xh8wGU1KTEA2cCKjkXhpotG3FCKZNQ8nDh4CU/hjzY6NJlp2IiDuvjas3jdRGUGLcXRKdtJy9mbHP6ms5jYCkbgwdM8kFZLLlFbAbEh2vtzmq0JikWKgtcbXdmEL1UHmJz0rEX7LhElq/RwEC6y1UqgLbl0D+IWItJU+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:17.2185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bc5f82-ccee-4086-603c-08decb39d489
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ec6f3f2e934c4..687fe28b9fafb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1135,8 +1135,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x300;
 		break;
 	default:
-		BUG();
-		break;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -5959,13 +5958,16 @@ static u64 gfx_v11_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "gfx_v11_0_ring_get_wptr_compute() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -5979,7 +5981,7 @@ static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx11 now */
+		dev_warn(adev->dev, "gfx_v11_0_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
@@ -6731,7 +6733,6 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 			}
 			break;
 		default:
-			BUG();
 			break;
 		}
 	}
@@ -6811,7 +6812,7 @@ static int gfx_v11_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 		}
 		break;
 	default:
-		BUG(); /* kiq only support GENERIC2_INT now */
+		/* kiq only support GENERIC2_INT now */
 		break;
 	}
 	return 0;
-- 
2.54.0

