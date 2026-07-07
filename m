Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41476C43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B497410EE23;
	Tue,  7 Jul 2026 15:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cWZqKuEU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012069.outbound.protection.outlook.com
 [40.93.195.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C7710EE20
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rowk9LQubERRyOSynRHutJ3lrQB2iJI5tKaJ7YPivyaiJu2hmkQlqsU9tIQtvG9J86QDIiDfAKL/q7Vjgk92ZEkvc188DzQnfApl11JZbyEqf8UQsCIkkEogs/tdFLx02KT4E2OOmyXNH4sl+3eV508Gox3evwQani++Gmz8B+limqvNDjLXSEP50lJYfexrMaErvGNDiUQqEZQrcFtAyKiBEi6FSHS7l4ntjbfS5WTaeOA/5A2xJL88cCFAkB9i/qvKlqEFs3fKmVoXxdPvq8e2NLcLytzzoTsEQ7NPvPt46DwIfvSBP8Cqxl7qboiJQDX3sQY5kofQhEeniiVNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MgMRZ8OAGtlC6z7jkCPtumBKglAY7HY73yJ2shO7tk=;
 b=Z6XIaBgLhT7UrMDaPNw23vUkD+2vo1GWWAfWfvLtco1U3sTIJFzl+5e9zaq3K26KBFpVYLC90jMhu9IJ1FvmVUSZg/bantc/3kyi9FqvLLuDdH0oLYa90qLbrkA7Uj1h6/DKO7xLPRlbir2oemGihMjO6l3AonctRo9UEt1N1AH5XBYlvgFFwA5hkoqK1gkuIo0elK7apvjbdtOf32DVBzhHU49ntTiZX8fr8ChC/dp1+NmAMfcvGVsELOwtZTWTLC6j0+5mBcN8CzRunlLSHVow4R8qPjGYjfz5sNrW8ZWhytbTFynqY6bPJIa73vN8Y9fg6ZE7rcNexMVL9NckOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MgMRZ8OAGtlC6z7jkCPtumBKglAY7HY73yJ2shO7tk=;
 b=cWZqKuEUaOktVSia9aAbKi64JvkJRDjavUyspfm5hxBI2NDDXvkcXfnZqQ5nzvMB+fDoRWUAIC54oGHGiU9s71hxnJPnS60QtXLXDeWCKhygEd9Rnm9Of4ScsaRDIvBEgy38R1VRiCYhWwkZCux0DsYOJx99HK+e35LEzLwHx4E=
Received: from MN2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:208:234::34)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:43 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::8c) by MN2PR16CA0065.outlook.office365.com
 (2603:10b6:208:234::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:35 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/30] drm/amdgpu/gfx11: drop all BUG()s
Date: Tue, 7 Jul 2026 11:42:01 -0400
Message-ID: <20260707154203.2603209-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: c8749d64-7051-47cb-2315-08dedc3e623a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3t4TSUMr52tJRtql/PbLf/RKEgBzHSWQchmMx5WRbM8oXLUMHNC4afrWFi2ypz4dKSTjjBPSQySG3uSPFrOFOO6hiDM0bEa6mxJxvH813FVsbDwsxERnEGlVkF42zy2lQf9MydMzKvr5xo83c7T4HTiB68Rt10CYzCKvFhLCjdyjWkWYBgZDQz1V7Djp8u0wIsJKBukPTY7Nl2rChEaguKJWDokIwWml4TzTiEAhh4LyDTrlEEk8KbEdY6JAIyHAwhQx4V09bnQ2hNkhttsiJJW+pm/9qCayMKcXpclRYbP+hlzdr0DQoNOc5zrL1W8n1+JUotiVA6FgIVSz+gYvyRQAqJlzypMMD8HmwHjMT5LWq6CfD+/+04jqR0w4X1rpIlYdc5uBN/yOFBKftTdCsAqDML+YgQSWFMFSKjbounqio2Y44nnFMVXWC4qZio5R4taINCKdtYoLu9YTY9W647AVd/Zx5dyCxo5FRD2QXZ6vqV7KmzWgaC9/vrAJwxLp5JIX4/LODeGbs/9xxHyMojyjqA4h9WE9xRBCFf0P9vqNadaCsylPiDdHpP3bO8+DVKNl90lj/NJLqTUq55iPmikLgT8OhfTYL4NKpFnMI3mWhqnsBlGTEn/GwRbbeLQ5CIrI4XQn07IHpDxdO8tmwgB4sqdASeWTsxVYTDQJXB2Cv0F5fUaxEI0RXFkvEodUnx67FbEeiaBbJfQO5tZZIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cQlNRN2H327QUUaKtbsbuiP8Kh5nOtz5N4vnPkIeORJJDk/X4A73hP19v3RzHSh/tSN6lZz3Yh4TFHpCQs3YM/gXRh72z7YhfoyjPs+qXZF6SIpB2UzOTQ6ixlEnomyNrbIQDg0hWlSTLvHgil3RfH4UQqlbIKlRsXQzNwvuNM+u1L/4sTvSP3qQLKzpi/yBueH7gQspNe0hEgsJ4+HAxxwrzuwUnfF7W28BzPajriM5rPjM2HlTxPC/UP5koznMPyxYpH+p7vhlSm13HOGVtiRM8YFHaLrgK9TdRSl9La9pZmr+/PlugUUCFg4bgOApKWOcIW9Bm/w9rk7sHacHxR0+3jq//wV06YFeBt/HIMmPdm9oS2SHAWB9Wmpk50Jv+utRmigHC9AHms33AZmQNkKOZjYpZYFMP05ByebcIAu10AehnERkpTKMYIET8U3y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:42.6811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8749d64-7051-47cb-2315-08dedc3e623a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
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
index d5cb653639a64..a286aee31f72f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1145,8 +1145,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x300;
 		break;
 	default:
-		BUG();
-		break;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -5958,13 +5957,16 @@ static u64 gfx_v11_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
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
 
@@ -5978,7 +5980,7 @@ static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx11 now */
+		dev_warn(adev->dev, "gfx_v11_0_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
@@ -6751,7 +6753,6 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 			}
 			break;
 		default:
-			BUG();
 			break;
 		}
 	}
@@ -6836,7 +6837,7 @@ static int gfx_v11_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 		}
 		break;
 	default:
-		BUG(); /* kiq only support GENERIC2_INT now */
+		/* kiq only support GENERIC2_INT now */
 		break;
 	}
 	return 0;
-- 
2.55.0

