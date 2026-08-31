Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257ADC61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B5610EA75;
	Mon, 31 Aug 2026 18:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j04mqFpH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791FA10EA21
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUZe/6KXEVO0FllA7z6My5l+eNOLLMYt2kBNXIIob/njw0QwY2VCbt6/a6PhPZRiU24BkTHv4QAqs/Dkrv7WCJtkAiQPjabL6kPXBY/i9Z/iyRu8NhuVh1iZnbWVjfYr2JeR0g5fVADHwYcCw7STX0WyYYRb+8FkkIgJNir3J0/IBjdpoC+FfWp4mE2SABHSpj5S3L+VnUnKvf6ZV3JKwie7sNhYiIqDL+JhUjZR/furmYUvEoRRGvouzsRb9Pt+zpi1yOE5NHmhPxvf1WCSUGjGIdbpafDd1h6sykxugPlrqyVpDAiFlYcPk0erUdkFdGu2urH6DRxmUbOnnjhvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZCZdgiP9WFerTU1qMITih6jGCw3rXIE1/BnOhRZG2M=;
 b=RZ5qosu2cyXRVjsHXYUmKwQq4venvJgSnC4LprAeT+MYjU3SMb5b/uTpw9DOcXSco+t365/Khv15KjlLuVFUqeknwijn+Wp0aZxEfwmGBOQUnIX8tFcNswcFjxe9NfsjteUaEvlpJmicSVtZ4EjlYDOfLwChTy3hkmN31PNVqQ78vaV8uUErb78mOU+c4dp8AplS3R1AZteVen8XHC9xM0nKTSMliws01daUXJcmpUt440FcCgCUGt8iAtqccmyMqEqViDC7JRc/oYB3+nxSRuNNNxYqxRuYnNPr84vYd6B3ewDPjqaKSztahkbMqawNwFnGgmUSqhNIOEB3oSREBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZCZdgiP9WFerTU1qMITih6jGCw3rXIE1/BnOhRZG2M=;
 b=j04mqFpH8+nrnvtuPCiAbqS/kUbdPktcIIDcnGImwS2YuSXMCDaSpC9l7ez18HznLSx1ChV5PrbVBnPmYyfYpNqMKXg0jyLtfJhyJNSftbG357jGxkSmyrMKkRmNENRdHHMaDJCFWuI02ZkzCC/byStiEcAmxtOmVFZTSspPpKA=
Received: from BN9PR03CA0688.namprd03.prod.outlook.com (2603:10b6:408:10e::33)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:04 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::4f) by BN9PR03CA0688.outlook.office365.com
 (2603:10b6:408:10e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 68/95] drm/amdgpu: Increase UALink soft ring size
Date: Mon, 31 Aug 2026 14:27:27 -0400
Message-ID: <20260831182754.1089811-69-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: c4aaa482-857c-48f8-4727-08df078dbca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fEoNDrMChLCxXnyliIOauz55a2ZXxuntpUG1MlFHh2us1hCWmlRwbmqpiRESCww1LJfZLlyHbvtoqCoAvGwJxRjnjfhBAiDSmHgNjiyEUcu2XS4WyRkktlxKwMW0cuNHsO2T3bfgIkyDCvclpwVBzcffv167gLpc5A7+ee5LsYoZq3kHm30jdR3naFr3yuAMfOk6Zl3jMYEAzF4l+C/6uNQWU8aHTy6nfsnBOxIN1WhVTcVRBdSkIO4KReIEbmdeylsZX1GexHZ6mcvpxZRzulagLLHgSgcRCvLyCuuBzD4AyX3/UXX5+bHgsMBgfsnE6Mf4WiYGm9MvffkU0OkcUZwUqm6L4Pfz3mTmNqs4hLKmfaFtsiIIQtTrFaicewc5mB5HiCBvxQKA7arxQBuBDcZyb6umoYaJV1zwyUWwQg3LDhT+gl/zL+G9/LqOFBNkRCopSxNyo3Rb9D9SC8N5w9ArtjZKSe04WZ/bcqlHsr3bAXBLJBMVrgdW/dtQp4bST1eaAhaaE7hNBS1YeIW+QhWbuuXkK+LAFpncD4KxfDxnZ891PHo8KM1zMHbW8hFfWjEy5hpsA6pAHMX2lHrm1jh1kF4K84JFr7mxMVlhYtdpCPDZ8dNSApeHFOeogh7Jcc3aI3zRQU3uS/+xn2d+BEj3uSgNtTuDDkwJx3y/5L3lxpsHFmqCd3M4JXy6hUNKfZWdpGicwCpJMst3bfaT6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vHQquRdozoWPbjrr5s3+g6GBTTeTr8oOvmt6Z1ALIqT40gp5vDb9684sdNchtk7ZE92OqCO+n2/hvS18HTWpMbI17VWdpvN0xZ5VIToAmC72/LiXUfAvsOtsDRDradLbcSa893qP88cOqoJUAwDcxI+AZWdXldbuENK9OMfJ4L51SW5519RcU3KI58nk20D30FO2Vhw96uO8OEtN7sl14aEJNSmcbu4Gs5btBoCM61cHFRiyJ8D3QbIT5058BR0uYbLfbJjiH/3aRSr6V8iM3ArGDloeUVWr8G8P/4Dw1HRYhYzSc47j/oMddOLzfoZp2dZ8JTOYsg+dMK1l3G9mKwyoyS+gq4y06EkPgRcfLb1CAjfsMd3Yi1bf6tjAZw44AaQrmTLjexdHit25RTsAOUUVh3L9iJkXlgg8uB5fdwV07kYL3mlOjjEXtO3mUiHi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:04.6250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4aaa482-857c-48f8-4727-08df078dbca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152
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

From: Philip Yang <Philip.Yang@amd.com>

The UALink soft ring overflows under bursts of interrupts from remote
GPUs. Size it at 16x the default soft ring to absorb the burst.

While here, read the source accel_id and context dwords before the
delegate path and log them, so the originating GPU is recorded for every
interrupt.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 17 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c       |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 11f834c97d937..8d74a89b40cf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -30,6 +30,7 @@
 #define IH_RING_SIZE	(256 * 1024)
 #define IH_SW_RING_SIZE	(16 * 1024)	/* enough for 512 CAM entries */
 #define IH_PSP_RING_SIZE (SZ_4K)
+#define IH_UALINK_RING_SIZE    (256 * 1024)
 
 struct amdgpu_device;
 struct amdgpu_iv_entry;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 84e556e0c4d19..d4a5304ee2d81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5403,13 +5403,6 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 		entry->ih == &adev->irq.ih ? "ring" : "ualink soft ring",
 		entry->client_id, entry->src_id);
 
-	/* Copy IH entry into ualink soft ring. */
-	if (entry->ih == &adev->irq.ih) {
-		dev_dbg(adev->dev, "delegate to ualink irq soft ring\n");
-		amdgpu_irq_ualink_delegate(adev, entry, 8);
-		return handled;
-	}
-
 	/* ContextID 4 dwords */
 	src_acc_id = entry->pasid;
 	dw0 = entry->src_data[0];
@@ -5417,8 +5410,14 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 	dw2 = entry->src_data[2];
 	dw3 = entry->src_data[3];
 
-	dev_dbg(adev->dev, "src accel_id %u context id 0x%x 0x%x 0x%x 0x%x\n",
-		src_acc_id, dw0, dw1, dw2, dw3);
+	/* Copy IH entry into ualink soft ring. */
+	if (entry->ih == &adev->irq.ih) {
+		dev_dbg(adev->dev, "src accel_id %u context id 0x%x 0x%x 0x%x 0x%x\n",
+			src_acc_id, dw0, dw1, dw2, dw3);
+		dev_dbg(adev->dev, "delegate to ualink irq soft ring\n");
+		amdgpu_irq_ualink_delegate(adev, entry, 8);
+		return handled;
+	}
 
 	msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
 	local_acc_id = adev->ualink.info->ppod.accel_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index c93ef937c4309..3745439b86b36 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -643,7 +643,7 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	dev_dbg(adev->dev, "ualink init ih_ualink\n");
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_ualink, sw_ring_size, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_ualink, IH_UALINK_RING_SIZE, true);
 	if (r)
 		return r;
 
-- 
2.55.0

