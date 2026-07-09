Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64D5C44509
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E6010F6E3;
	Thu,  9 Jul 2026 21:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HBFcdD/u";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F20910F6E4
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVtg3PMsalc31M2dSKkiylcL9uOwbmduLSmUDjxgx42inaH+wxY4Qw1+qj6gLqnaHExBuq1BKov+9d/XF6B1ORSYtXjuP4RQnsdcpTQzFLrvziqdAuRx4tf5I6ta38FKN7XsohQ/ucje9qCze9bOpzEYbDzrTLjTkC3rEnXFHSFk/C3KvY74IsHblkK0krkMfQUY9IHEwtIDPObF2N6SVM9pV68RJsuYAzSj+/8qogulB+t+GDSizt3j8yta7f++bXISwHMBTMkqq8ub0mSQn8jYziBKC66+XAh7sdohmN9zUm1do1rpGy2gBNf+Jxb74oX/pCPdr8RN7Rbsoj2sZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2lmmxY9odNvcCh/g5EVq9VQubxPLihVfN0Qf0oO1O8=;
 b=pUkOt2h5Ht6JhpuDr+NJlRbviFP5bA8YlDn32Enexxc+v89VUCNWMxcMoGfh8uY9ffp+myUKURx788Yx/iBD00hrXbVVrJNvM3pA4a3l9YEMqI1585iCAWW2L26SkAOt+f1Q98NN3T64liF5xwCEfBq8iFSwrY1jLXGKUS2P5IScrn6YG6rpsuRw/N4z8HLm2ofos1oJ2MGZtkRa2lvlUu3HgLEwHWKZKtp0Rj0dtIX6k27LYLdXiN0WqC+g6aPVtsLPKqegiA+dVJiL8KaXLZT3gYsmAp8tCn1hbd7JjUj2qsR++5xCaCu/b085rZ1KCDqz10O0SelvPmoRQ/SV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2lmmxY9odNvcCh/g5EVq9VQubxPLihVfN0Qf0oO1O8=;
 b=HBFcdD/u/AVVq70VHkzNHNhHZ0TRHc+k4FW+AEG8cRgvMXCXRTc6iCt65wZ3KBdp6zqh8JLz6Sm17P7DRux4iUOeu4Oe3lQbQ5h9kd2+QHIdFmrd3YtlLJoS/PZlsh9xg9u5c8atf3JYSjftFev2RNS/RpFVX5qErnXZw12iaIM=
Received: from BN9PR03CA0484.namprd03.prod.outlook.com (2603:10b6:408:130::9)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Thu, 9 Jul
 2026 21:02:24 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::42) by BN9PR03CA0484.outlook.office365.com
 (2603:10b6:408:130::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:24 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:04 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 37/80] drm/amd/display: Fix 8K Mode Not Parsed by EDID
Date: Thu, 9 Jul 2026 16:48:05 -0400
Message-ID: <20260709205936.5719-38-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a0dea0-4968-403d-6183-08deddfd6001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|11063799006|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: UrAG0c7Kk70lJ7wUJIv/cyvr4IQxdndE793mhtNhf3Or29EgFjiB7j8Fz3dMDA5G19wuvM13mtRIcR+QCIio93CvXvzq//MGswvBBO9ORoVCVNke5rI72ylSP3Rt6c8KQXiFuh9KaCDJ0WdTmStxcSgyZEbcciE+Dy2zhXTTAb0uc3n7y1SuvR+bSJzqd9WUKKAFY/9bqMCmxIDp7eq8Qt2gcg0acydXi0mc9ikAdIwYMPU+/rsb4Hpgsw2jn3yYMzqLgTRJCSrFrI9IP4i9zE443K+JEgKWZoLRdmKV/0QMAGuNIxGx+gH+CrQfoKe5v1xdGn5BR1KNqgD++imiwPTcGxUKpvo+y56zA0iitRmMLbT320KsTawFRU59Nkc8Cz9fdiwDU9Sual196RzpihUa3/1h0EsQETcuJUy2NGIdzUxnXLytQkNrkJVHNOVqTLVM+bQPbJtayEg5GMX8JKGpjLCOs5YomEkOf1grm4SBh8I1P5VD2tnnH3XJ/gaCkOuTImNfifZasqbrzzE/Y5kCNbfiTLQCz2GxaAAuR5RuKJ2U67swWPCgK98tVVRqsgiezANI9Yu70xaIK5TWyR8CSReFMDn3yM1zWLddI2tf/FyF2/H0vHNVOt0YYyuVkvyYovHpyifshjMdGRhZPYa1wGIFIsL1Ag9zycUoRwHNGE7LgrwKEsE/Eq3wZ9K05P5G2lfVHL8T9af5kTk+NA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(22082099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DkQNU9dLCNzUNIFdOkvgwi1+x4fNHxAIELc7Ri2OD0/X0jHfCa7pkgKUszLomOYwx8irRupKMvx+E/5wWqgolIMKjoayRFb+wCS6ooHp69pJRCI29BrakAq5FHD+yVxgqSLDsiLPFEeOJAB2+6/z/t9l3XOdSVE/j9UR9cF5MJDWuLV5PBCRmCvf0fyaVchitWedt7YR0M7Gu8oBFujO23krLqlEk/r1HFv88ywBPEa/tK5KvJaXnMnOGwtmrs1CfKW3JtI4rTlMm8VD8Yrkk8axT4CRJwKSxWQp+2yALgoY94vwEvfELfVAcI0ymXSz4OL09F2zeu4SEWNtv8eu/QLNiUCkoLkU5tiSpxOPBmn2xpoo9Vk3wMQUjDq/YTP3DamgFEuCcf6XmO3ino+0SIofoPfdc7Y2BUy5f7Sw3FWDJ6wxht2zVPB6M7aVK+/e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:24.0019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a0dea0-4968-403d-6183-08deddfd6001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[why]
The 8K120/8K240 timings live in DisplayID extension blocks 2 and 3
of this EDID. The EDID is a 4-block (512-byte) HDMI 2.1 EDID
that uses HF-EEODB.
drm core reads and parses this correctly, but amdgpu rebuilds its own copy.
Only 2 of 4 blocks were copied into sink->dc_edid, that leads to
drm_edid_connector_add_modes() never sees blocks 2 and 3.

[how]
Directly populate edid_blob_ptr with a blob whose length is the full,
and HF-EEODB-aware size.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d177489a2684..c59da4f447fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1256,11 +1256,25 @@ enum dc_edid_status dm_helpers_read_local_edid(
 			continue;

 		edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
-		if (!edid ||
-		    edid->extensions >= sizeof(sink->dc_edid.raw_edid) / EDID_LENGTH)
+		/*
+		 * Use the length of the EDID property blob populated by
+		 * drm_edid_connector_update() above. It reflects the true number
+		 * of EDID blocks, including any HDMI Forum EDID Extension Override
+		 * Data Block (HF-EEODB) count, which the raw byte 0x7e extension
+		 * count can hide (e.g. HDMI 8K sinks).
+		 */
+		if (!edid || !connector->edid_blob_ptr ||
+		    connector->edid_blob_ptr->length > sizeof(sink->dc_edid.raw_edid))
 			return EDID_BAD_INPUT;

-		sink->dc_edid.length = EDID_LENGTH * (edid->extensions + 1);
+		/*
+		 * FIXME: amdgpu_dm today does not consider the HF-EEODB, which
+		 * may contain additional mode info for sinks. This is a
+		 * workaround until dc_edid is refactored out from DC into
+		 * amdgpu_dm's ownership, allowing amdgpu_dm to use drm_edid
+		 * directly
+		 */
+		sink->dc_edid.length = connector->edid_blob_ptr->length;
 		memmove(sink->dc_edid.raw_edid, (uint8_t *)edid, sink->dc_edid.length);

 		/* We don't need the original edid anymore */
--
2.55.0

