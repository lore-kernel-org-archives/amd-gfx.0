Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3434CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C721112DD5;
	Mon,  1 Jun 2026 05:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="czKnVDA2";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FFA2112DD5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eN8X2GakMSk+MhU41w3iv/LlwMUiHm3R18NAd55tCpMHS9JmAXIuvLWkpCjV/GLwNmiV4hNiZkD3cONp1MzSlRJgj0atFZvzqPJH+e9/hKXTaPONp/K0MYNa8UPe5pi1ywJT6dRgHCwN2xrH9MUaa/USzePr2z9TZEFN2Pyf7DkyN3XfaVxOTadis405As85eRCvDmCusio9Gbn0PnK41abkeCN0IjPKIFB7g4ICTLUveI459tAiDkxVQKEMxBrB5fkOUELSDbOQHHLb2ZnvfK5UT3vyfJ7AlHunIrBY2a3OTvLILkuVG/+lTJjFTe/i2bga3q703+Nf9U6zq7v8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yz7xFJ8sS4IM46yPKTEKDY7F/pJmKWMY8Hyb4kB5wMs=;
 b=Dtzhym+Tu6Tq8G77xQnBRpTvV71VwhtBIVrIWCUSGpUXPqhmeSL372esgXVuj/grdsdQP3wIOLyaG2110MVfOIZsQ8Y4NBrOIzOBq9UumTgx3KT4bzAyq3wCBJwwXyXIBYwksm/ab0CEqy6UCK2IuPELXBOY53Nu5lV6V98uRjLoaPSPkUJXQMkDTz8HCmwd5YbUu1uL3prNLbJpXddvb/+9AqP7TezxJa6/2WClEv+YytProCXsV1fjYDXNp5t3N48lfepg9CXl6/j9O1aGnP/tgtXcb8lIYBwrybO4Dbtuk4JVPKCRzRBSuJuO4RAUWNqmFAW/PwRl5DU+1HE0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz7xFJ8sS4IM46yPKTEKDY7F/pJmKWMY8Hyb4kB5wMs=;
 b=czKnVDA2vePQvEy/5rtkWTtfA9NMuo9k1S185L1VCNboj4CWkPDJBQ/Lor5V5V01LPyRe/d5OdHr5/geAPcBrd3tpwIVj5roeRy/h5QaUMrQUgzohl4EMiAXKH/IUvy7yW56n1f+ZLf0fs4BbTnZmGj9H/Ua5X2PLSVObjFlzUg=
Received: from BN0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:e7::14)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:54:20 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::4b) by BN0PR03CA0039.outlook.office365.com
 (2603:10b6:408:e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:54:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:20 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:54:13 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 30/42] drm/amdgpu/gfx11: unmap the queue via MES on reset
 for MMIO path
Date: Mon, 1 Jun 2026 13:49:16 +0800
Message-ID: <20260601055034.3700921-30-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbfe33a-1476-4b4f-616f-08debfa239ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dAszrC4xutZ19VilJit5eMXGNDVTDI8RioTwREMlJ3GxwCFMPzLocKHZ+s7Z1C4a42cWkW67+4obfr5wXcvm6FWkVBFZ/tS0jTZA+BH3/q2LF/vnnxBJcgrsi/aoOR2w4vOLRKxQ3tE46O3MDT52GUtS+rqyAe8Ytlfws83VClG9n+lCm8lTeDHR2WCpaqDhwrBHn2n+I+zbEmc09l3J4Cfu26F9LVOV4bWXmneZWxCfMnGCbiygo7o4DV4r90eqch6NBNQCM2VRcThr+zpBHQyepQH1s3Da3AtoDuQ7izQVGlayDSahH2CImomGyq5VU2LA5a4Z0xRKF8OmRytlbpoXFeeyrkLXJl8Pyte7q6nXpNG1GhteVLPb5QXQ648bFrVzKHoJ5DHc3sxzBTedF7e02c/GdwGWr8I+tkA2p+ylPfPc+lyYWUukP91rR33QwFS+uFZFiJ+YaQC1aNEn2o9GCWS7nYEHdAPAKdEFb49YY8NEtRSrN5IJaAVZk027lhvG1+Oa4fe87+Ks8hncNZj3E4744sFTKTT6k88dR1FN3ArroubpC4xp+d6ATkTPw0DHwXII/aWj0B1ZW5bvGq0PO4Li5YMJqjh8ltxyCVQeppgXf/sI0DT996QV97palCYdpoCVc2kRz4F32PaW5YdKutiwWJcZTHe0kacAtJqWyTUSzXUyaO0QWsP9KVdhhYkI2/e3M3Expn7mhnw5erMt8+olPcquU442Y/k87K0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bSxHl/ApBgE+IFRdi8RqeI2oDVZ280yeR3tH3wGChLoJohuyhK6OFYXBirSbStG+eavCVEO/sKjGJrx3qiE2AAPudH8HhX4K/m/2tUzrXOPSLQyjbT3NNC/2dEISkjAo5ycJwoc2iApP+1vAqyivog1Xeke0VVuEdSIrHSFgEgm8sviaDpvkW5m6gbvoZAVDAmu4Q0rFMMKCgzN1Vvkw1yYjvpTi3H8viXXc3D3V8/PsvfMSJS8Xwp+RDdXXw8ieDJO2kGEIcW/TFtPf9EW31bgj0IXi79/E3qHYY/F/QsxXuayl/qqq63ByKRA2zE3M1qdAkXgntDGaRpQmyXJjHyxLd1zhs/ATjASZQKpfHIBe8PfYJNiZiTbdesmL8YNF1irUNUI9X+dnwyRiAldz5XZxac/1rt/80eHWnimtdm77BaIQZxr9TFVp3lqTVpZl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:54:20.5926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbfe33a-1476-4b4f-616f-08debfa239ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
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

From: Alex Deucher <alexander.deucher@amd.com>

To keep MES in sync.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1dd35aa6199d..455fe4b3c205 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6790,6 +6790,10 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
+		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
+						  RESET_QUEUES, 0, 0, 0);
+		if (r)
+			return r;
 		amdgpu_gfx_mqd_reset_restore(ring);
 
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
@@ -6817,6 +6821,10 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
+		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
+						  RESET_QUEUES, 0, 0, 0);
+		if (r)
+			return r;
 		amdgpu_gfx_mqd_reset_restore(ring);
 
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-- 
2.49.0

