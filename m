Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C401CD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 04:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E30E10EBDF;
	Thu, 28 May 2026 04:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yIhGyNgB";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012035.outbound.protection.outlook.com
 [40.107.200.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EDFC10EBDE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 04:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R98RQ5aphfnZuRw1ciVGCqOxkq7DGSZuqV5YjJE8zots81AI5aBGAKF6iwKhHP3URFCDtiTnObMC06GyTCGGwg06y60GSDNOCtopBhSFbyeH0lz1VSmCkyEZfUlgYJPp3lllj2SXf78Wkj35innJyktfse6E/0tjDdxTCOMTTgxF3Px3cGy7ZyeuOS/qd/0BDHSz+YIJeCzPC+f7rGZS9ZqxEA9ncnnTpf7QV14uBIWensbJVAOaJa91l4XJzGOD49ZGIXvvsV0Xo9i8RbdgITRkXQnP6WILP6YNacYSVWPa8hsZdjQ+CseER7zoUkjKYMhKDKhXuuLfSvzyu/DS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iu88cZe5E2aP8Bnt8Ah/kZdfshzwG8cBOl6SWe652Tw=;
 b=VvceHhh5Da/6mb/Kl2Em1chXKVUGkW3Ranux/DzeXN106TIyPMwrZaJjgk2QjJOfBcKv7ekX89gSH+RwoTXn/dLO39NF9/1/A7OOe0xBmeu4IXsMuQK18AEFBOPrOPGDJz4aEq6cH/X80e8Nf2J/EbImqUY9AVZQ6z3NHnknjI166GKR87pWDH74eAeh8CqrgCfwrtzmWLCiUHGV/Iabob7pNYzufFdU6MtEIxifnu4XEp4ovT/FraXPX5HpJjdULa5yBPz26N1XEwT5MR9MqxJlRTbDyeG8j6azJAukNPoxk/iSGy+ALOsXEspttz+mwste/810ef+0UpsCt+nkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iu88cZe5E2aP8Bnt8Ah/kZdfshzwG8cBOl6SWe652Tw=;
 b=yIhGyNgBavYvtgII1bVonnk7EOy23IgTxLCqGilIdIeDv0LJuYNKiMiko97Qi8qaj/9PJQL3nbZB6C3j7Nm7IYx3LL/xsYmZex3NpnWvvnrEu4Sr8AfoeFlsPCnl658cvmEqzeN0dNihZqW0FJB9B5gERdRChRcRjOCOkb2zob4=
Received: from SJ0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:a03:2ef::26)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 04:34:42 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::1a) by SJ0PR03CA0201.outlook.office365.com
 (2603:10b6:a03:2ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 04:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 04:34:41 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 23:34:39 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: validate RAS EEPROM tbl_size before record
 count
Date: Thu, 28 May 2026 12:34:04 +0800
Message-ID: <20260528043408.237209-4-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260528043408.237209-1-candice.li@amd.com>
References: <20260528043408.237209-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d429560-9024-4ed6-5d6a-08debc726fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: rY8JXfBCUP0rQKc0BeyWPAYmKIyuN6FW9MqtYLDsYLL3y3JGFmgzy1VQjClm9DDUh7hR30aDoZW07vxQnQgs0WxbwjUWp6LWwbKw4Va5sLTdmNQzuWUgha6LLjTFMUGsR5ogAs92JTklFpEmZGkHuduDot6gMdAOcFxN3ReE+buSdMqxS1aejYyUy7cseTJr1cw3oCWPOoXvAv9dG1i7y7moBlS2fQYkwmbtLhcFsTB10srSZF8GZmqIh1mNQDfQkHmR/qxV2d3eXdY/0DOEWlc6FF/OSMPtfEsVM2WDC50/5Qcobr9/NrWue47iRHuB31fAX/qk5TXG2B+DC7kknhBVTfepJy5srY0OF/WqwxSV/3M0AFyTI2ywfg8J4udZoHhCOAU7wYr0xUXh7K5WZu7glIvssmAGxriI1FxC/9FaG9xj/wlDdCEbXC71kGZJgWqaAkF/+c4BCTIUJWti7sVhdAB4SQr6FxsQFn6ZE8SUCw5OkPiJYnvH2UFkCpCaICaTtz9bhqqZM6Nw4GaqorJMFnDDPUjjdLUt3gB/lRnFTdXAOcspSIdDY1PjOFbZjEVuZG4ufLldYGMTxR0CbzZYNx2DxsezO6+nrWtPYBQ1GnNn0rPf8kAENfCZJrAT3/6nU1H/jjAHc6lX/n8KmlpDU4pDd/kFru00BdvAP2Zg4CBi/RHxMV0TzVy6rRUKVGxG+hHssPHD6lSBteiB+E/v9c7QINUjpDTWfah8svc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gpJvbNpNTv6ZN7FeNH0gx05kvHZlnTcmawe2CusHapCOL9e4m40/n9Hiy3voRbkb9/njOe2y7fCtVQDwOUY3JEAlU3b+hz80fIAydhPeN8FkzdXqRcewGeHxytr7RTlQFqOoJjJ3yDWzmc6rugq8+TKEbG12mUyGa74UNlASY30t+q1rFlrSC4NlG7TITJxi7OGEgFL4Ioi1G7/pFl/HjI6annNA0TmuyA7PiJDWHDDe/PiPWGqkns8r8aPSMF++V16JCFbAM36pyKQBUfbCiR7YyZAA6Mo08Q+TS81GyESzPJYfjMnxXDBEKUww3+c0/ipJDj82/4abjPd0deDhP1lds4pkFpMSJ/kzHy6QAdUPzCmWFQMWzOfniuDgY3Q7eQ7WPAtPrhNl7ehKUz7Nd+uP7Y+u2LPQ5yYuAQFoYqKd3alb8oH4P+V4lCarAbTJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 04:34:41.7307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d429560-9024-4ed6-5d6a-08debc726fa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
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

Corrupt EEPROM data can set tbl_size below the table header size.
Guard the RAS_NUM_RECS macros against undersized tbl_size and reset
the table during init when tbl_size is below the minimum for the table
version instead of trusting the header.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 30 ++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index c61389a079822e..159edaf2ba7576 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -145,12 +145,15 @@
 #define RAS_RI_TO_AI(_C, _I) (((_I) + (_C)->ras_fri) % \
 			      (_C)->ras_max_record_count)
 
-#define RAS_NUM_RECS(_tbl_hdr)  (((_tbl_hdr)->tbl_size - \
-				  RAS_TABLE_HEADER_SIZE) / RAS_TABLE_RECORD_SIZE)
+#define RAS_NUM_RECS(_tbl_hdr)						\
+	(((_tbl_hdr)->tbl_size < RAS_TABLE_HEADER_SIZE) ? 0u :		\
+	 (((_tbl_hdr)->tbl_size - RAS_TABLE_HEADER_SIZE) / RAS_TABLE_RECORD_SIZE))
 
-#define RAS_NUM_RECS_V2_1(_tbl_hdr)  (((_tbl_hdr)->tbl_size - \
-				       RAS_TABLE_HEADER_SIZE - \
-				       RAS_TABLE_V2_1_INFO_SIZE) / RAS_TABLE_RECORD_SIZE)
+#define RAS_NUM_RECS_V2_1(_tbl_hdr)					\
+	(((_tbl_hdr)->tbl_size < RAS_TABLE_HEADER_SIZE +			\
+	  RAS_TABLE_V2_1_INFO_SIZE) ? 0u :				\
+	 (((_tbl_hdr)->tbl_size - RAS_TABLE_HEADER_SIZE -		\
+	   RAS_TABLE_V2_1_INFO_SIZE) / RAS_TABLE_RECORD_SIZE))
 
 #define to_amdgpu_device(x) ((container_of(x, struct amdgpu_ras, eeprom_control))->adev)
 
@@ -1610,14 +1613,27 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	switch (hdr->version) {
 	case RAS_TABLE_VER_V2_1:
 	case RAS_TABLE_VER_V3:
-		control->ras_num_recs = RAS_NUM_RECS_V2_1(hdr);
+		if (hdr->tbl_size < RAS_TABLE_HEADER_SIZE + RAS_TABLE_V2_1_INFO_SIZE) {
+			dev_err(adev->dev,
+				"RAS header invalid, tbl_size %u smaller than minimum %u, resetting table\n",
+				hdr->tbl_size,
+				RAS_TABLE_HEADER_SIZE + RAS_TABLE_V2_1_INFO_SIZE);
+			return amdgpu_ras_eeprom_reset_table(control);
+		}
 		control->ras_record_offset = RAS_RECORD_START_V2_1;
 		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
+		control->ras_num_recs = RAS_NUM_RECS_V2_1(hdr);
 		break;
 	case RAS_TABLE_VER_V1:
-		control->ras_num_recs = RAS_NUM_RECS(hdr);
+		if (hdr->tbl_size < RAS_TABLE_HEADER_SIZE) {
+			dev_err(adev->dev,
+				"RAS header invalid, tbl_size %u smaller than minimum %u, resetting table\n",
+				hdr->tbl_size, RAS_TABLE_HEADER_SIZE);
+			return amdgpu_ras_eeprom_reset_table(control);
+		}
 		control->ras_record_offset = RAS_RECORD_START;
 		control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
+		control->ras_num_recs = RAS_NUM_RECS(hdr);
 		break;
 	default:
 		dev_err(adev->dev,
-- 
2.25.1

