Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF0CD3748E
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA58910E838;
	Thu, 17 Oct 2024 13:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LBOxM6qF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D73610E822
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODSx96P9hIdnflv+6TwuRmDsciLaLFnHessJl49P5cEb+mEb+s6pITNanuSwaq4YmQJ996xezBlZJCYLlR6gBfoqQ7fexNjNbQ6JLiEvrNnQKLRMkh7qji9ThqsDJNw9BK7IzIaqbl9WfI43S8x32q2/JKyNE4vci2hTkdwznbq86ZGYIuwhuEcLBJ1PaiAumc8GxHSpYoIF2LpOkDCd6IlK6W01ocq16cU3on9vOJqGs3sMWrk42uaHemCnu7ewQtB+M5ZvRzP0dKFo/5ME9KoEY90kfZ0SaUNgweh2ixATdTFOfOi62dcuzvjGlP1qjzTkAXTtPASUjzXlPNP7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBmhSpYavlUZsJ6eC54svzHT4Le9WQtEgD9v2qrVSM8=;
 b=PEoZuFw8PMVurlWeBpXZgjRdse5oH9WCk63FkrYH2DXkswPaRP8ZIgJnPfb4IeNTSh5pij4MvWkDXc5KKzgbchOeE2LoV+Ai5gXCuWHJYyAjnnRePflHugk1AT3S4wnu4Jnz52ZxTn2xSkHqb6tjLwJwyE7dyMrxvdIwfw6Ye0MJQJQVtE4msPmshxmUBA7kBTnpsfgrUyuVO9cBnjSt3ZPHRTJOFtKHoUgeUSClxArjLVEQDDKEmnPgoLqUzSWrXjtz/GQykrv0P3uMsdjKQcSbrcqKAuVOcy6sYm81XlvH+r0vbqkNYkeamJovbaYAdlKMsyI3qqLh7jq4Pty3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBmhSpYavlUZsJ6eC54svzHT4Le9WQtEgD9v2qrVSM8=;
 b=LBOxM6qFnhD1Y1jX2uDqwlI5C/ZYnAxYSesMC7/QjEvj63mQRHJ3aOga0ays+A2HEXmIzh1O6IJk77Uuty8DmnX3KCvXbZTuQGGfsmCdSG4lb9+B5RBDxW8UrLTON9eEaTn8F1B5HWK2Wu3BAnRcuGiY3kK+Xax1eKVu+vQli/4=
Received: from BN9PR03CA0255.namprd03.prod.outlook.com (2603:10b6:408:ff::20)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 13:21:29 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::cc) by BN9PR03CA0255.outlook.office365.com
 (2603:10b6:408:ff::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:29 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:27 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 19/32] drm/amdgpu: set powergating state by vcn instance
Date: Thu, 17 Oct 2024 09:20:40 -0400
Message-ID: <20241017132053.53214-20-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 442738a0-8f2c-4fb1-21d6-08dceeae9c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DNbnTZhjdqwAxfyKqvgXa4OODGAKqfNaI57omOtGj+xO1QklOD3RanOI1rXW?=
 =?us-ascii?Q?MTrzBEuL3TA14RYnQReYSGp9NTS6ziwzbR1g1N/MusW9gl3PG8XhGR6NDMwQ?=
 =?us-ascii?Q?GjTz8sJSXnTHHcj7mYkWBGb7TlEenbwGW7Ptg86bJu5df5yxhqRBJbGNy706?=
 =?us-ascii?Q?i9NXmDirO52/lXV+aD4OmebZONGIHDhYoAFkWZZyxHZhVGih724PoePJ0Gjw?=
 =?us-ascii?Q?NQ62YigPRfagebFq7kIV7xaH4Vj/dImorLUYTFqasLBpnnPO2jYJyG6pKPU8?=
 =?us-ascii?Q?HbZAZ+BlqpvRBxUXNKDDne7OQzcTyK5cT6RKuWJodZssPAzWQEMkGIiHacaK?=
 =?us-ascii?Q?KAXUyz6mvZzJqbqTqmbKh3A6T/qXumMbJNRV/Pq60AUxoGdoCklSCf7OoCcO?=
 =?us-ascii?Q?2C1HuX0wEAhIErwsUUEAwKktatP/jleGW3TlJyaC1KTTP8xq7q2pO6GBJwbf?=
 =?us-ascii?Q?4hYttBATGIfxK4wSZg+WzMq3OQC7ZihgRcRKYfsqsV99qmujgzhYstnNpOTB?=
 =?us-ascii?Q?IGGw7Lmz6y87B3C9UGiLYB7gCR+WmUAzWSSm13eg0Lkc8A2EFRv9n70spPgW?=
 =?us-ascii?Q?1hIdIh8LghofP43lwwC/ioZrRYri7Pq20hnjmTyKhNFUkhxeUYYB1L1jv6jd?=
 =?us-ascii?Q?82fl77mS6Ej+pQcVA3bmjUI7ST47HZhtIIcbzn86QbFOB1VbCNrfWv3YXWhL?=
 =?us-ascii?Q?bgVlCdxga9YXNwRsfOxFsWlVZvrxwJmk6o6qLM/Tfpb0BHxdEdeJTyF+E/XS?=
 =?us-ascii?Q?BD335kw8dOPjP/VIC+iXZEfwbOd8ICJN//AyjqcyjkkLZcZhNFygm87Mafo9?=
 =?us-ascii?Q?DCx+gmxBSyC30aaoxPe4j68Uf1ZaPr2BufnwUn0gZDth4GXDWvFqSNuuDHq9?=
 =?us-ascii?Q?PqGpQWO3GQXT9S4NTf66nKIAXEf9t19iTTBhQtzyWzq5svgk9ar76SVXOdyI?=
 =?us-ascii?Q?9tA45Ma0r/oTiwnkL4i3DwyPIXXUeyVfpUTQ6Or1fdGcmxAw8UIQx8GL5ggU?=
 =?us-ascii?Q?yloJRUIWezxMiDHWZEnsaFa7N7/1aMwIlpSZpPx+G2Kaypn5pXPraHjvInQI?=
 =?us-ascii?Q?nqFNyA5KB5+1aImJ0B+0JeFexEgNqZT1UfndWr/2ehEzd645sxB+Qh0XL31C?=
 =?us-ascii?Q?dnGYmGG1HRWQH99MIzxS4d2t3t/lzwZM6hFHlL2v7IRq8UqFXcxDkQMeiHmh?=
 =?us-ascii?Q?8424A2UAabZJY4W+naKsZspPapv7/bHeXbX+sWqwQgA2cxOnO5P7U+PMvdKj?=
 =?us-ascii?Q?L+IxkEYr/MjqqC52iTWuxhxoRfmTOM4qo83i867f3QOAb3m/uC3Yskr8UzAK?=
 =?us-ascii?Q?qx8Icn17LwxOgU0atyF8L7rPr8jYgR/MfEkvhdyWCLqE9/7LnN01FkxYIzOG?=
 =?us-ascii?Q?7jNTLX1MlS3HOitnITTX/c9Ec2DexyCwDBgqAlImdNiN615eoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:29.6637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 442738a0-8f2c-4fb1-21d6-08dceeae9c82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Set powergating state by vcn instance in idle_work_handler() and
ring_begin_use() functions for vcn with multiple instances.

v2: Add instance parameter to amdgpu_device_ip_set_powergating_state(),
instead of creating new function.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c              | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c              |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                |  4 ++--
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                  |  6 ++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c           |  8 ++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c |  6 ++++--
 .../amd/pm/powerplay/hwmgr/smu7_clockpowergating.c   | 12 ++++++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c  | 12 ++++++++----
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c    |  6 ++++--
 22 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3442564fe174..53b7b7c0291c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -357,7 +357,8 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 					   enum amd_clockgating_state state);
 int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
-					   enum amd_powergating_state state);
+					   enum amd_powergating_state state,
+					   int inst);
 void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 426beab725b2..5ccfe7394e15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2141,7 +2141,8 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
  */
 int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
-					   enum amd_powergating_state state)
+					   enum amd_powergating_state state,
+					   int inst)
 {
 	struct amdgpu_device *adev = dev;
 	int i, r = 0;
@@ -2151,6 +2152,9 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 			continue;
 		if (adev->ip_blocks[i].version->type != block_type)
 			continue;
+		if (block_type == AMD_IP_BLOCK_TYPE_VCN &&
+				adev->ip_blocks[i].instance != inst)
+			continue;
 		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 95e2796919fc..78fd1ff28a57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -119,7 +119,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 
 	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 	else
 		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
 }
@@ -133,7 +133,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 
 	mutex_lock(&adev->jpeg.jpeg_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 31fd30dcd593..09844953a1fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1277,7 +1277,7 @@ static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
 			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 			/* shutdown the UVD block */
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							       AMD_PG_STATE_GATE);
+							       AMD_PG_STATE_GATE, 0);
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 							       AMD_CG_STATE_GATE);
 		}
@@ -1303,7 +1303,7 @@ void amdgpu_uvd_ring_begin_use(struct amdgpu_ring *ring)
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 							       AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							       AMD_PG_STATE_UNGATE);
+							       AMD_PG_STATE_UNGATE, 0);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 74fdbf71d95b..a061fb8a2fcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -344,7 +344,7 @@ static void amdgpu_vce_idle_work_handler(struct work_struct *work)
 		} else {
 			amdgpu_asic_set_vce_clocks(adev, 0, 0);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							       AMD_PG_STATE_GATE);
+							       AMD_PG_STATE_GATE, 0);
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							       AMD_CG_STATE_GATE);
 		}
@@ -378,7 +378,7 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ring)
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							       AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							       AMD_PG_STATE_UNGATE);
+							       AMD_PG_STATE_UNGATE, 0);
 
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4838a4ca44f8..e93d3ef2fdd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -410,8 +410,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_dec);
 
 	if (!fence && !atomic_read(&adev->vcn.total_submission_cnt)) {
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-		       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev,
+			AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_GATE, inst);
+
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 											false);
 		if (r)
@@ -436,8 +437,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	}
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+
+	amdgpu_device_ip_set_powergating_state(adev,
+		AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_UNGATE, ring->me);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 416d1a073173..6b2afcc3fb21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -330,7 +330,7 @@ static void vpe_idle_work_handler(struct work_struct *work)
 	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
 
 	if (fences == 0)
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE, 0);
 	else
 		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
@@ -406,7 +406,7 @@ static int vpe_hw_init(struct amdgpu_ip_block *ip_block)
 
 	/* Power on VPE */
 	ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
-						     AMD_PG_STATE_UNGATE);
+						     AMD_PG_STATE_UNGATE, 0);
 	if (ret)
 		return ret;
 
@@ -429,7 +429,7 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_block)
 	vpe_ring_stop(vpe);
 
 	/* Power off VPE */
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE, 0);
 
 	return 0;
 }
@@ -845,7 +845,7 @@ static void vpe_ring_begin_use(struct amdgpu_ring *ring)
 		uint32_t context_notify;
 
 		/* Power on VPE */
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_UNGATE, 0);
 
 		/* Indicates that a job from a new context has been submitted. */
 		context_notify = RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.context_indicator));
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index d5a5a5189ac6..a3b8bccf3c9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -735,7 +735,7 @@ static int uvd_v3_1_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 9e3ac12d0127..7dced60403ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -249,7 +249,7 @@ static int uvd_v4_2_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index a16c99d0b85d..f883cf8d2d2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -247,7 +247,7 @@ static int uvd_v5_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 5da51118a184..9cb78358e355 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -571,7 +571,7 @@ static int uvd_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 591db2da8067..92f369d08fec 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -639,7 +639,7 @@ static int uvd_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index f4bd28af41e1..72e01a0352ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -512,7 +512,7 @@ static int vce_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 679033481616..4ee0d479b0fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -523,7 +523,7 @@ static int vce_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index adcbf61411b5..d9c36d7213de 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -589,7 +589,7 @@ static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index f6886cf2a686..f093d66df1a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1861,7 +1861,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 			amdgpu_dpm_enable_vcn(adev, false, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-			       AMD_PG_STATE_GATE);
+			       AMD_PG_STATE_GATE, 0);
 	} else {
 		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -1891,7 +1891,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 			amdgpu_dpm_enable_vcn(adev, true, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-			       AMD_PG_STATE_UNGATE);
+			       AMD_PG_STATE_UNGATE, 0);
 	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5a9006bfc3cd..d4c264814b61 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1026,7 +1026,8 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 		/* enter UMD Pstate */
 		amdgpu_device_ip_set_powergating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE,
+						       0);
 		amdgpu_device_ip_set_clockgating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
 						       AMD_CG_STATE_UNGATE);
@@ -1038,7 +1039,8 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 						       AMD_CG_STATE_GATE);
 		amdgpu_device_ip_set_powergating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE,
+						       0);
 	}
 
 	mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 3cafc9493e88..b0443f20fe2a 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1675,7 +1675,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
 	if (gate) {
 		/* stop the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		kv_update_uvd_dpm(adev, gate);
 		if (pi->caps_uvd_pg)
 			/* power off the UVD block */
@@ -1688,7 +1688,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
 		kv_update_uvd_dpm(adev, gate);
 
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	}
 }
 
@@ -1702,7 +1702,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
 	if (gate) {
 		/* stop the VCE block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		kv_enable_vce_dpm(adev, false);
 		if (pi->caps_vce_pg) /* power off the VCE block */
 			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_VCEPowerOFF);
@@ -1712,7 +1712,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
 		kv_enable_vce_dpm(adev, true);
 		/* re-init the VCE block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index a8c732e07006..41dbf043f59b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1407,7 +1407,8 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCN,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_PowerDownVcn, 0, NULL);
 		smu10_data->vcn_power_gated = true;
@@ -1416,7 +1417,8 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmgr, bool bgate)
 						PPSMC_MSG_PowerUpVcn, 0, NULL);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCN,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu10_data->vcn_power_gated = false;
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
index f2bda3bcbbde..b496b77153e9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
@@ -120,7 +120,8 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 				AMD_IP_BLOCK_TYPE_UVD,
 				AMD_CG_STATE_GATE);
@@ -133,7 +134,8 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 				AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu7_update_uvd_dpm(hwmgr, false);
 	}
 
@@ -148,7 +150,8 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 				AMD_IP_BLOCK_TYPE_VCE,
 				AMD_CG_STATE_GATE);
@@ -161,7 +164,8 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 				AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu7_update_vce_dpm(hwmgr, false);
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 7e1197420873..2ccce2bc3b4a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1985,7 +1985,8 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
 						AMD_CG_STATE_GATE);
@@ -1998,7 +1999,8 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 						AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu8_dpm_update_uvd_dpm(hwmgr, false);
 	}
 
@@ -2017,7 +2019,8 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_PG_STATE_GATE);
+					AMD_PG_STATE_GATE,
+					0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
 					AMD_CG_STATE_GATE);
@@ -2032,7 +2035,8 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 					AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_PG_STATE_UNGATE);
+					AMD_PG_STATE_UNGATE,
+					0);
 		smu8_dpm_update_vce_dpm(hwmgr);
 		smu8_enable_disable_vce_dpm(hwmgr, true);
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index baf251fe5d82..64ef8c8398ff 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -3715,11 +3715,13 @@ static void vega20_power_gate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 		vega20_enable_disable_vce_dpm(hwmgr, !bgate);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 	} else {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		vega20_enable_disable_vce_dpm(hwmgr, !bgate);
 	}
 
-- 
2.34.1

