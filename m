Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC50C25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9232810E379;
	Fri, 31 May 2024 16:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S0LMbTHb";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4BA10E288
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oegm6R4+o6paaHumHMPyoBTCqPmd9qHcqL+c3CLRpZPq0STZGf4kGKig7SG9Tpy9iNpDYdaJoSOedHWmSHvOCEm1igaF8WJGfDCQyUmo09H48ddZQlIX6AUIpcYqp1yie86u3u6XOmlwE/1yE8crCBwoxjRaHCFQThFMDhwsGePjZ6tL5Em69QN2AyYM7RQLWjqwhCRLOull7ymq2X2FKEyyxCduMzHC7aCQX9J+I2tU7Y2mgIkSXlNt9/RA2+z6ydHh494x6S92Q075nPECAtFoKmD3rEEbzgl/eWuttkdDuD+6LZvlZ4Z6nJ/wm+0+r3nt+DwUcujH+146qN0L6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6pZtgrOKK1wk8NVL1noTh3DTzijcHFdVUzAqPz5/xQ=;
 b=VytDX+w/+S3zGSJ+P+v8MLQu5RG8vnjFYSgPsl8Qenp5KZRC3rO/EenqxxK7RKklj81qI4MT4zDA/T86hKVzXyhZTSGRgfHKx0gHl+BEjUQja0ywK7X4bpJuc23HVvHkRvG9U2EDBfOV49mKKW1TK+mp7d+qzV7h3eKDz92yKf2NfXppyNm8yhzSVLiZ48dMoykxJwwOdAN1Bmp1Y9bNk7+/RSCV/sxlsJwnF5ZHsW0+KJJAIUSbKfNGm2WlhkpnibVPmuxLVU+o+nBSN78clkD1EzCP5j3QKNN4kCho5tZEVDCV4+j7BQNTa8tz5IQZPeRhbaO2YjookjFKrp3e2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6pZtgrOKK1wk8NVL1noTh3DTzijcHFdVUzAqPz5/xQ=;
 b=S0LMbTHbfiytK5C0SwlP2j4hEZRz6GELocRVHZqblerYvgKToIEnp5+j43I5u6e9Nl2NzZy7BTbuSvuShdHXPz1ZsNXam+Sim5XP2XoId4PWgCVS5Y3sxIs+Hv8CKjNokXWnhVDSCHMS+oQIwdoMdM5oQq8X53RbxhIQYK0tCPs=
Received: from PH7PR10CA0005.namprd10.prod.outlook.com (2603:10b6:510:23d::11)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Fri, 31 May
 2024 16:52:33 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::97) by PH7PR10CA0005.outlook.office365.com
 (2603:10b6:510:23d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 16:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:33 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:28 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Chris Park <chris.park@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 07/32] drm/amd/display: Support new VA page table block size
Date: Fri, 31 May 2024 12:51:20 -0400
Message-ID: <20240531165145.1874966-8-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e9b15f-a588-4894-840c-08dc81921159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WvlOg475T1w7R26I5Ll2DZ/6jnnXsDv1IM0uCvj4Xv1R1m8u5iLWWq3Caa89?=
 =?us-ascii?Q?zVf+tM6V9rCW2yK5sQN/jikUy/l/IzEEDHNruS9OInqSbvdo3AwgIV5kYeiL?=
 =?us-ascii?Q?QWVnFQTHEoLj2yzjp0FJ1mEGX92faAwbdM55foxBLNJytvxO5Qw31k/F6YlV?=
 =?us-ascii?Q?goUZ+BPgoFFbFV78jrqf/A+Sp+18BnPd8+Soem4iSC5QMrGbVZ8KUK+e0cIf?=
 =?us-ascii?Q?ZYDfs/lMTV6oCmNQK069yEgmYA6EExRwbqqvby6f3uNeZC5nlgH0XwJYsw7T?=
 =?us-ascii?Q?wUH/mzxgJgqKu37s3gpxjP8XC9cefIz9XVMVhB7c4LgOQ0Bv0t+7kv2SpDdk?=
 =?us-ascii?Q?QQ3cpo+cSN+P+rtZr8a1hEUh+9IMinMQXlljLtOrYok1SojNrYmwomYz4m3d?=
 =?us-ascii?Q?CcTAFRxKJ+lxp8Bk3roGGqmLZiN4no5NIfHe0rrFOcfHKYyw71KHDO14Axsj?=
 =?us-ascii?Q?FMIToO8uHW56CcUW9rlWK6VXTTuQ8djiBndtkYdsan97JiQ1lq+DkR8MY7Fu?=
 =?us-ascii?Q?afHSy+n+8yiScBHvCtq9WXz5hKiqfCEdgX/bpRa0697R+B+wXU7/QuSDHoZ/?=
 =?us-ascii?Q?WBMz0ntZUP2VXKhgSw3cVNI/6UfQZS6vcKgJxC3tNCmMoX25DSC9oxjY1LYu?=
 =?us-ascii?Q?hNGY+gvotfeMB5MBBWlYTLVeQwmQzTQ+TWlk4T0vl7PKUKB3bqt1KWmpPF5j?=
 =?us-ascii?Q?6p4cEmUIUJX00nbDYwf7fT6j4TyVmuk9LLdNcU8gC6qtqACMe0GQIGdP9hag?=
 =?us-ascii?Q?0uqeQJ1Q5xkshds8XVjVI86MOqOoyQdTbq8SVCg6VPw44tVO24L5oqJpnowy?=
 =?us-ascii?Q?q7hASMWO2hCeKHG9/Aa9BHOketILy2jseCOxMKb+rQaDTw77ObrvRiraqLLo?=
 =?us-ascii?Q?VfeAKPQHplKFthpsRGlEB1SENd3U6xwV2Hmp8ywUOiTsqjMOLd+0fd24VND3?=
 =?us-ascii?Q?UlZv+yazohql7+UVszAZaXGwEOZ8X6jC32e2iItJZH/U9PYNe2y/Mj7Fj/Bb?=
 =?us-ascii?Q?D//NBUtk5/DiM5i6+4bb2bKFpWFGtl6IRbqXroT2p1YbkEdGHX4gO5eo2Vg6?=
 =?us-ascii?Q?5LZbvf7mTUyVqFu4TxE1Cwj6yauFNH1k1IE36ClcPzh7wARwy0zmiZzGJmMl?=
 =?us-ascii?Q?Wod96VSn9Zaw/ufdOSXFhMAKNB+aSmt/wD3bwFScLEagyhodpRTnNmtD9o2s?=
 =?us-ascii?Q?4MDDRLEomFYE5QcGV6pDYUKkYwxteWUDBE4Z/GRYhaINWlZWKVnguXrXptic?=
 =?us-ascii?Q?BmF0J2bcJPul7u7M288sYJrEduOaHhYTJNzjryhHPLLeeB4VSs5E0V1zTLy/?=
 =?us-ascii?Q?WDeaarwEGN71a4s7YKuZ6ji3SzWUAZ0qBTed3AfQnYUP9EWLZxkYBsqZk9qA?=
 =?us-ascii?Q?9IWHO+c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:33.4961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e9b15f-a588-4894-840c-08dc81921159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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

From: Chris Park <chris.park@amd.com>

[Why]
Page table definition increased up to 2MB.

[How]
Define new use case of page table for VA.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    | 27 ++++++++++++++++---
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  9 ++++++-
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
index c6f859871d11..8901bd80f7d1 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
@@ -339,15 +339,36 @@ static enum dcn_hubbub_page_table_block_size page_table_block_size_to_hw(unsigne
 	case 4096:
 		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_4KB;
 		break;
-	case 65536:
-		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_64KB;
+	case 8192:
+		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_8KB;
+		break;
+	case 16384:
+		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_16KB;
 		break;
 	case 32768:
 		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_32KB;
 		break;
+	case 65536:
+		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_64KB;
+		break;
+	case 131072:
+		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_128KB;
+		break;
+	case 262144:
+		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_256KB;
+		break;
+	case 524288:
+		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_512KB;
+		break;
+	case 1048576:
+		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_1024KB;
+		break;
+	case 2097152:
+		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_2048KB;
+		break;
 	default:
 		ASSERT(false);
-		block_size = page_table_block_size;
+		block_size = DCN_PAGE_TABLE_BLOCK_SIZE_4KB;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 1511400fc56b..a73cb8f731b3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -74,8 +74,15 @@ enum dcn_hubbub_page_table_depth {
 
 enum dcn_hubbub_page_table_block_size {
 	DCN_PAGE_TABLE_BLOCK_SIZE_4KB = 0,
+	DCN_PAGE_TABLE_BLOCK_SIZE_8KB = 1,
+	DCN_PAGE_TABLE_BLOCK_SIZE_16KB = 2,
+	DCN_PAGE_TABLE_BLOCK_SIZE_32KB = 3,
 	DCN_PAGE_TABLE_BLOCK_SIZE_64KB = 4,
-	DCN_PAGE_TABLE_BLOCK_SIZE_32KB = 3
+	DCN_PAGE_TABLE_BLOCK_SIZE_128KB = 5,
+	DCN_PAGE_TABLE_BLOCK_SIZE_256KB = 6,
+	DCN_PAGE_TABLE_BLOCK_SIZE_512KB = 7,
+	DCN_PAGE_TABLE_BLOCK_SIZE_1024KB = 8,
+	DCN_PAGE_TABLE_BLOCK_SIZE_2048KB = 9
 };
 
 struct dcn_hubbub_phys_addr_config {
-- 
2.34.1

