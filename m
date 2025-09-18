Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94187CAC5A0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 12:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B3F610E17F;
	Thu, 18 Sep 2025 12:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZX98Uqr";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA51410E17F
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 12:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHMaOnTqYmUK9HGdL5w5OpbkgorA93Qm1uATM9ADbnMlPPoHT1VQMI2uSkHbkdt+cUEcOn8mx6ylyqV1klgvMm85+n+kwvnXDioAHp7h6YnPk33ActJA3SPvIxfqY4YiKXZWiCkeSJqzNlHff757jagj+Ytj9pi1LdTx39XH7LmaVJXPwPEhCo8tiEb8lR+AoC3GsFNemU0pxVIUyAlAq9E2Li/O4nHHzbmZQdMyP7WmOEgMtticwvfwGpCwZu8R6emwy9S1BLrCe54p0+WPy8ASyxlnQTK01P2tptmKO4yqLRini+ooJmKmJGmb0NYLi39ge0WMo461u+8qwPfNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcqKXNSLkeaiu3VZnU/dmYeXl/8S8pmApAjjEOn9z3M=;
 b=LriBJ4ruihyufy8KgSrgHz03cD2gT5AW7jIgSkFm3ncC+wQ/nDTJ7s2IRs5fQaSZlRmmX5tu8EuGB6QSTufNVIESa5iVQOo5uJ8YqncMP+Su6E5t/gbsq3TAAHSnbtN/JxDe1zqWWbcOpxauRqld2gPbOQYXkEtp0GtG1QwGfxyBg9KjlOAGpiHjd5jq3TEe2CxFkLNnUM4T1SpU8B4R93/fbsL5bp56U8cQ4+ItHRo6v0GMAK6T26OhUXbRSAMV8xdAJE3EhiyXhGMprLUSfiBPJSu5xu09HB8fvb1lJO4woumBFsSz9ZGOPQNR5cPYVZHOOR4Lhgtxu3Xon0Qftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcqKXNSLkeaiu3VZnU/dmYeXl/8S8pmApAjjEOn9z3M=;
 b=TZX98UqrthyeAjdimA8p9rvekh+/3iLAK/2cxCUBkcVf2YsS22DrM2N4zZaf8N5fzW5nW+MxDI5nnK7UT/A7UKSMD0C4zHbZdX/BQHM48tkMQX7zw3BPG20fKVTSdHyD2rr9KFBBaV0v9NXN6VrEE+yloxkfpJqRvM7i25+RYOY=
Received: from BN9PR03CA0114.namprd03.prod.outlook.com (2603:10b6:408:fd::29)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 12:31:10 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::59) by BN9PR03CA0114.outlook.office365.com
 (2603:10b6:408:fd::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 12:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 12:31:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 05:31:01 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Mangesh.Gadre@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix vbios build number parsing logic
Date: Thu, 18 Sep 2025 18:00:38 +0530
Message-ID: <20250918123038.3099984-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f338c93-495a-4df7-2b86-08ddf6af3f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fgp7WTMal0ccGi9LcJqnaz/bxoPQpCZ+Bsqp35Knp3Yygq3ez8oWxkECtWWM?=
 =?us-ascii?Q?BrUPpKlVHeCdQedFRjTgIrUSk8aGJ9VttPAkjd9lppQn46UJKtrwBbsMxm4k?=
 =?us-ascii?Q?deIHQmDWPxIL5tRpfC1Gg4UE+S2ZkXZa7QeOvO1vcnlsJNN83mOhMU/2x3VI?=
 =?us-ascii?Q?tTfOfOEf796lSZlOv+gToK97+0ueOrCWstN2zuj9SFTR5s75Ewn0QH0jurJE?=
 =?us-ascii?Q?aWNFQMk8hFdG5g39OOXc4mjFsaITwA8n+u31N2UPiNhhMIV87vbfN6C+6SRi?=
 =?us-ascii?Q?3+IMZfi+cjkXF3vPr3cUCr6RVfPK62d0Sq099DW8aIdNGTngetY3iyMgwvXi?=
 =?us-ascii?Q?qXALafwS4O/btG8TnhPOSVejg7vawZljjN6w55tolUMl45b17VWXD6xQelwe?=
 =?us-ascii?Q?SD0kqvReIn2VjUNQQmUnUrC+8BMPA4cYEBPGZxoAr6Thc2FF0eJ3IsUnAkoB?=
 =?us-ascii?Q?vhZUY4Wboh3Vgi6XZhvIv9vi7yP6ZuwmtOBG97QhvFO/bHJAE7VCtCdY/kTh?=
 =?us-ascii?Q?moUE42/3Ybf9NHvogSsTljbt+sjmYQ8PkmgT8v/unsTzl1e3kZ8+bcfJKPZJ?=
 =?us-ascii?Q?lVcRHJe1CflsN1Y8X632KISZZiYoY8V588p609AUwZJJ4E+TZpKF6WkJK+HJ?=
 =?us-ascii?Q?GEcZ9ZEl6dEdHmEDPbHgW8+OKH12EFj4bOLIHx3YPxUU/17IWtBx15Lq0UCZ?=
 =?us-ascii?Q?8sSOgYWYUttYcMD3rIaYUzbAUk/yETxD9CiSG41UVxykDaERV6WQUUaB7KcN?=
 =?us-ascii?Q?reqhq0pL7P0xxlk37L/qsN9LnHXGWrMd1E0aNuPbCW6WBQU+59Egq+JNTr5J?=
 =?us-ascii?Q?E2jcpL7mQTyeeO7lqOiszV7OAHi3V8pxNUOAVywGLIwT24LAPnL50NlEY/OW?=
 =?us-ascii?Q?z+K7pzQvuXuEj1zryybKeWVxVv507I02uGpQZfipyU8IrsA60JSQvvXm9Jt1?=
 =?us-ascii?Q?aM7jhEmaqTHE6gutR3WV3m8ljRa2p+Zn4Q/I8pMkoNQ+kSp1NlRYYepmX1bc?=
 =?us-ascii?Q?m9BR9o5aHewFOIYXf6PPQW8sWSgERnK3I7d9T0SVQC5OCs65SG43nVLvU0s+?=
 =?us-ascii?Q?yg9VXqL495yrO0DWxzs5v4y78AjFjk+VhmqUrUQe2hh1sgeBrick4ViDO7Az?=
 =?us-ascii?Q?Gj3Zr1zRr5tl8xZKCWlVJOBsl4pY6QrBxTxHXGBd+1WPiWMR0Keeq8dnvc4M?=
 =?us-ascii?Q?79k5keegCLAOamro1iTl3U6Up1KiMc/zRCrA1HE4JmyuXlYMiAC2mJdICIgc?=
 =?us-ascii?Q?IxrOInV5Lx7i0p4IFm65naIhzxc2NNK5qiMZnA7vm+BF9F1BMJyWPQgWyxkz?=
 =?us-ascii?Q?7tTYs2UvOIbloqFF3Vb8m7haZvbh1CEQqtUOkqxPNdeDCyU0xieRz3NroZj4?=
 =?us-ascii?Q?gY5Bpi6zwwGhNko7bT1nJxnbFrbk6C8dCKGCw0/87ZutuHQBve1+iBA7GLZu?=
 =?us-ascii?Q?c3DadbPdPI4Nf5f85nJNVO3hF0wuJfZ9gwozF0mWCwo9pMIYc6Q1xiW4/rOQ?=
 =?us-ascii?Q?uqDcqiVWTB7KM+6oeZgcfUxR1XWlcYfqELL8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:31:09.7263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f338c93-495a-4df7-2b86-08ddf6af3f45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
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

It's not necessary that the build string and atom header section has a
difference of 32 bytes. Use the remaining bytes in the section as copy
limit.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 1c994d0cc50b..7cc7aec1bff3 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1498,7 +1498,7 @@ static void atom_get_vbios_build(struct atom_context *ctx)
 {
 	unsigned char *atom_rom_hdr;
 	unsigned char *str;
-	uint16_t base;
+	uint16_t base, len;
 
 	base = CU16(ATOM_ROM_TABLE_PTR);
 	atom_rom_hdr = CSTR(base);
@@ -1511,8 +1511,9 @@ static void atom_get_vbios_build(struct atom_context *ctx)
 	while (str < atom_rom_hdr && *str++)
 		;
 
-	if ((str + STRLEN_NORMAL) < atom_rom_hdr)
-		strscpy(ctx->build_num, str, STRLEN_NORMAL);
+	len = min(atom_rom_hdr - str, STRLEN_NORMAL);
+	if (len)
+		strscpy(ctx->build_num, str, len);
 }
 
 struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
-- 
2.49.0

