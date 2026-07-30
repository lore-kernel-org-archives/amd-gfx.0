Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49AEC55162
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 17:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EF010E1AD;
	Thu, 30 Jul 2026 17:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nAR/7LAI";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF2B10E1AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 17:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Df9nn2+M0csT8D3Ktp9ynThiJrZVR3vhxBQLuYeGFX1hCJVKWUGH/yvd5/XheELokBHD2ZWLM95TPC2jdTGAmWyH9Yv7A1oBK9PeAe5pLvrW6I0zQkPF49sXpXpyRw3joppMdxkC4yMSOSoIb8GtDdud0ddBMQEBYWpa+40H7WNc76VyBwjxLEYxPjLOe3S/lIoF4sYyZuMxE4RuHI+eCDna2A9FzarNzKSaNQ0Owt0jqZPyTKglhbOZAKZLuFmMGu+4NBQc9j9tScQFJeMgLaJYBoY5mvQ9TgGLMM16tqvO7NYHrAVUDcZwq26pnNm3NyD43tS2UC4o1emj0wLxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2vCME8dBNzm2RO5qEJlkYdLE5K+z6/5Yen/nvqlrMQ=;
 b=NdxvjWQub2HNn55dbyCCJwJCDJVzapZL3MopUAoYOVBNSRtBmOHbTd4wci9hRpVenDPsGGysfXM4cRUt9Gosm/KUA+lakPG97/hVW2pL21VNiBWK6fnISSCwtvyLXvgp/U/w3FxFXkd4nc4hpQ/NVYPnh2+H5wdfBsszq6rkoj2opHCiXShTl78VmM2l8cbzJaw4T7z7sx+jqYRBNCUbEZ/sZbzN4X2qYkiOCdU6GWHIfO3bwDslD7qjNpQjqCqlRbWkf5lIQ3t4lNo3xHoD/WqIKchcX34ixBVp34bhu1d/tJrJVEmUj/q/TBWi402cOwcyP87NR+wat3I1wv3oEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2vCME8dBNzm2RO5qEJlkYdLE5K+z6/5Yen/nvqlrMQ=;
 b=nAR/7LAIEHsr+px6193ahrSLTG68AJHPNmOB9qY21uKLBMJZwguFbdGDO3ILUwcajs61DmTR7Gv2ZPEnt8EM1KuwHV7+YM4KOuditsKnDbL4Y4Ce6Gim/wn5+J1yzkkniGKbmUhW13oYc0hHuH0gxokZU+yChABrAuhfSy8dVus=
Received: from SJ0PR03CA0120.namprd03.prod.outlook.com (2603:10b6:a03:333::35)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 17:03:06 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::7c) by SJ0PR03CA0120.outlook.office365.com
 (2603:10b6:a03:333::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Thu,
 30 Jul 2026 17:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 17:03:06 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 12:03:05 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Fix UVD min buffer sizes
Date: Thu, 30 Jul 2026 19:02:31 +0200
Message-ID: <20260730170230.11930-5-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730170230.11930-2-david.rosca@amd.com>
References: <20260730170230.11930-2-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: b5986f34-e8b9-4fde-bf81-08deee5c6cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1gv5/QY/5lyBXlJVTm3S8/oIHO11XUV0nf98AXmRjclwHkT/h0tJRzL3kip6wXloKgoeS+wJWeK6Mpraw3RcBodaRtW32jCLsXG3OAPqrDIK4h6eLj96Qo7r70mLgnhrCCf/V5tdWGUPydJlbwLGkjnXfpmNqWJHsWYgfL2K/CfHQ2go7eZ/6goxXRpJD59Qk42tw0mMPFcaFYcDuKqM7mN+eDCbLf7ZHb+4HTZr4GaZwKEl5312gXgTJT/UEEAj3vI6jFxECkJjXXYbhOFDLI+JvfVEEIInaJdiwtoRneNtEwokt6uNalbWyVfb42jov2qOWsgXNAUrUcWWMz4TRKSh44xY0hZ2CVLdza7dWd+K49jKvEnFZq4l7Ia/P/HSwTESChoj+o3IzmEVPad68n/5ZZj7boyMHdLGN8zCTFIDhKHswKSUV9J0g9UlG1UOGQUVTlxbgaCiSP5cir4yUg4/WIPayny3F9/Bc/13B2VeMbvfflNEmZmCFA/mLKoGkOfLWvdLz33J1rTc+6AogQlBuYR7P7kM3dyIdC2dEzv0MgzXsc/TLRuD5kpOiU9SZnsQp2zznqUlyNqtoE/4RYVXLS19jtCBRGgBCsENWU7jTKiltNRP0Nt4LihV1q58WYRUdYx4MZl2IDrvhd0SmTTnWQl++hM6lAZhdVnh5oc+NwRQjmMIiceaELb/MplS/ipBhFj5QxG06STBfXgv3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j/thwgSfIqYSwQr1F31ZScQbRwH9scanmUlevcMDwafEWXRpYx2AxEUW3CADKJwfYJjekgv7wpUwTvasdX+Gm/sLrnrYbZt8wGImC8oZC9HDX0S//WDvcc3oWi/7hw0ZfelXntf2fK5k9VyfYd5FbswonYyNVOiX0FLbuLrek9UP5E8xarV2K0AnCBn97VWALpsLjjLywctPiMUTyXsfPhM1jT5Ye2K35ztLllX0gkfsBZU86VnVt6OfuAEFN/6bfI5+Zvk3rM/uYwkaInVLG9TLme0x2oDCX85GFHBecbHSUisftacLM5UhILnyRYQVWTYbLP9QrSglY6f4ssKFhN5kk4yq8dis82NPodNuT7nrMnmQPdXAF5xhXlevf5p249u5TxEse53x5wg/B7moltiUx+TH4+yeDzZY89qCa9Ffy49a5UPo1c2OaBo7jhXP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 17:03:06.5233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5986f34-e8b9-4fde-bf81-08deee5c6cfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
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

Use correct size for message buffer = sizeof(struct ruvd_msg).
Add ITSCALING_TABLE_BUFFER size.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 947a6cd45881..e2d0f23d48aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -918,15 +918,16 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 				  ctx->buf_sizes[cmd]);
 			return -EINVAL;
 		}
+	} else if (cmd == 0x204 || cmd == 0x206) {
+		unsigned int min_size = ctx->buf_sizes[cmd == 0x204 ? 5 : 4];
 
-	} else if (cmd == 0x206) {
-		if ((end - start) < ctx->buf_sizes[4]) {
+		if ((end - start) < min_size) {
 			DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
 					  (unsigned int)(end - start),
-					  ctx->buf_sizes[4]);
+					  min_size);
 			return -EINVAL;
 		}
-	} else if ((cmd != 0x100) && (cmd != 0x204)) {
+	} else if ((cmd != 0x100)) {
 		DRM_ERROR("invalid UVD command %X!\n", cmd);
 		return -EINVAL;
 	}
@@ -1056,11 +1057,12 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser,
 {
 	struct amdgpu_uvd_cs_ctx ctx = {};
 	unsigned int buf_sizes[] = {
-		[0x00000000]	=	2048,
+		[0x00000000]	=	3556,
 		[0x00000001]	=	0xFFFFFFFF,
 		[0x00000002]	=	0xFFFFFFFF,
 		[0x00000003]	=	2048,
 		[0x00000004]	=	0xFFFFFFFF,
+		[0x00000005]	=	992,
 	};
 	int r;
 
-- 
2.43.0

