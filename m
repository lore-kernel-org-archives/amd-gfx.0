Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C53CD98E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165A210E788;
	Mon, 15 Jun 2026 23:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LQfs0LtL";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1741E10E77E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJBC9TJfQYaAElTZKx4/t+LYXCcw/l3wanHZn+fwZCZfubQpLKNm+fbEDFMbBYDvg1fEgxHQ1dCb8ZAfKMWtBZiBVmkXJgKQTxfNa42dLc1dsAgmIj5EOAbBffH9SU61Cq/efi+SWhOlTD7E/HLL2y/fM04o1q5AMeG9UnzyJ/fcZfphN0LkKSO+oLH2VManvhZSLUcRZVMqYqv60TaMC/Dq/LIXH/Icr5qizY5w1Xg54truMnrRYW2m1p+JdNhm2B+cd0gCyfNUt91yILWJT0qYwadu2rWEtSpfMEnCB6FC8IutLXTeCYQmh4k/sQDNYcjpPnxUkdP8oLZ8e1VWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46tJI+duD2Pncyy5KyPApQFmR/d4c24AXbNZhZBiDWw=;
 b=fAu8MSUAlr24EQ5g1Zr1WQ7oZkVNad9PfaNXZgC5tzg1DiaVAp8OTJ/Tfm80VGo9Hi0hDM71oXQhd407zBez6nmqa0EgAaRrfSQBpq4j94a8TYWDr1UrsdPkM6lMF1jrDe7s5yjTs/chkEX/2OV8SW9l2BqzJn4Yxr8R1OY4jRBFaOgKXOHQwsQCaYSiV25XNv/9U0Wp/D21e5R9dHJ2zZmGP4KBX440UdMp+zyPyJZ0FsxWuluXKwD0aJAcxYOhdTB1Sp1SFNYwDPlydk39kLBPLQH9Pl7Nr/4vMr81oZzp4Mixuq9lVwj/1BUuHHDq6aCUKgcisXHxaiRUj1wgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46tJI+duD2Pncyy5KyPApQFmR/d4c24AXbNZhZBiDWw=;
 b=LQfs0LtLZOyl9Asy9u2BbzfjxDAZRP4KASYvoXXKon+yvHVfHl7Qk9PzefwZPrVjmg5Z1ZeZ4GkCY79d7QQLALjr5sghCmYRHrgh31qTrMa1b8CbE6IkPMGnJvOnoYDrAtBB2NgzgbJ6BuQ7RYK2DuenKFvSair23CGM18l0e9I=
Received: from CH5P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::9)
 by DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:18 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::48) by CH5P222CA0024.outlook.office365.com
 (2603:10b6:610:1ee::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 39/43] drm/amdgpu/gfx9.4.3: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:41 -0400
Message-ID: <20260615235645.737189-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2fd863-315d-4ad5-cc1b-08decb39d4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: X+bSD8w/tvGV26X/xOnssmbKv3vyiOTWWyzOqvbMWp6g6AzZbkUeO2GtTxcxbH12TlNiPdrXSlVAPaEIEE2tNJ+6wKS8ofQE2myH4ZpQStAWs6ejWLsbcuZcaRxtjOxSnuugK9ZfSIysfweDKL8hKTTiLch6gDodmGvW5YqAYB1ZBnKlo0PL0dGwyd3Df0Fa/wGWhV8aObGVFaLGgrgIYM5QAPJH3xDn8e3iSt6hfLblAJN94C3sFN4IqtJ1zwH7SQtjJDGG4DIe2kyMwRTDb0Rhg33f4vDfZZNFs21IGC7+HRPvURI3PweiYu6BQyIDc7DrmOBC7FwPHSkeFYm5+ARokhHR4By0xrL6jmf8Wv2BYhrWO/ZlnZB2IA3p+gHK3drmcE3xkfew2Fu3ABJpJlbxzqQUTccIeoAuZOK+4xM6Mf6g9M5qqonAc7j6JElEftNyxH9JmymWur7Nj1HDJ0aoS0vKtYaCzxZEHLlMpVpyzVlfK/9ieIjqdawMhh2uoPA4nbWacA4mCJ4xL7rbFfXx0u9zCqEF/XwyVJW01fDxzsBOiU6FCpGJZQZOy6EYAESJpSi3KyvOFLrzntIol8n2J5cpij3Tv6vMpttkB3zEYiWTCoyxpeswhWcqjedJcYdtx/wAQUWQTKULVoIEJJkATi1l2sSbXagas/yWW8p+TJblFuniwQRUsi1h/Vwca5Cht9nunbvq6uAzzWNbZwua3NzCMhWPMXeaoQJ9ik8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2GpxjL+HuuA371Ytdlwnh5je2mSGcBT4SHvu716Q0ocTepDq8UG5AiXLBGyQWsUJuJ5gVhl5EU3NJ91RLy1DkM2qHpUpl56v1jRKqu0WVn4WQNqe1pe/PLAbju+U9UZGhr+W3K2ri+iuV+/UpyCdKifK9o438DBSz778/+VBJmJUMsIxM+aw6mF7PtA/z48Usq14E5ykcN5cooClih+4aTJ1NTeMSPtqEFQ798du1qz1jm2UJpMri29+hBBeTngPuT4u8BawYOds8lxOv42K1YSlgcGm4DB2brCgX9ytitg2+VwBQ+Mu/VRZApCLF8uWCKf07j/d5b7s1qdlcFsB9sL5sldqKh2eEzhWFynznDlfbX5iRRP+vOk7vIJDyl20v+tRg6zl/uinAv/xcAHkFxzRZc+cZTYyJ4f2yxJh+Ur4M+miybjcn5vss4ZaDbgC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:17.6448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2fd863-315d-4ad5-cc1b-08decb39d4cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2a36647b975a9..0c1987fd34f7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3012,13 +3012,18 @@ static u64 gfx_v9_4_3_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v9_4_3_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)&ring->adev->wb.wb[ring->wptr_offs]);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev,
+			 "gfx_v9_4_3_ring_get_wptr_compute() requires doorbell!\n");
+		wptr = 0;
+
+	}
 	return wptr;
 }
 
@@ -3031,7 +3036,8 @@ static void gfx_v9_4_3_ring_set_wptr_compute(struct amdgpu_ring *ring)
 		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx9 now */
+		dev_warn(adev->dev,
+			 "gfx_v9_4_3_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
-- 
2.54.0

