Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4730BE9A03B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 11:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFBC610E1C0;
	Wed, 18 Feb 2026 11:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DrXNFN46";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD1F10E1C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 11:39:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/C+BkFeblaRPqB23K5mKTM8+vK4P4E9TolX7u+5Z8e9r6VvIa+Y0V8U3pN67CppZkU30YlzpR6vtu5y+bspo4evlVGxAzq/Ni2DI0piqbivVizRHZ/fl0PX5DxwcHNrWsvtPR4HypedJ6h5w48jXZBEBKdEPmIAcDOKZt2gWTi09ypi3FADqiuBZyzSuyVsj9e3ukCn4D8CSYA7wBO/2ljFBebFEcWpGU3PeOpnQrWGpAV01d5yJ/5/71QDfLNXATK/s10n53TID5U+6n6OK2DNu2dBN9vyppSuwoktexft3xuNvl+oqpCHe66VgCkRRF04CtSyj9QggdPplCoxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoF9uV9UiAX+mDJbwULltQAFkR6KwKIdhMYmjnA3/lQ=;
 b=y2gsjqaYD4Oj+zKuXXqxYEoYdPUrEHZR5554f550Nftw0+z5qkjfG9xuFXG3WSsIqc3qizgtd8vIbHNr2KfBS6WZ/mO7CWp5IvXtGy7mdGwSk9yk/lxjhoBdZ8Fn6OIPWSUjzYgQkqA8q5k+kqMUZ/zeOdsxXnkF84U/vrbTyaF/yTnXSx7/uePKP3lCznw/rBOMOHh3Ts7y/s8kUpH5Q6aBZVnwFzJuVyDbMx1sWTWd+B2Mhw3q9SAH7MHWA3aguaLwuQpGgUUHGcz4e2B4BKckQXOkTxIp9XN3/+oHurKDB5QcKEYDVn52EKQc1dpVNZLJxn/QIBZpQe6tTnMPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoF9uV9UiAX+mDJbwULltQAFkR6KwKIdhMYmjnA3/lQ=;
 b=DrXNFN46oFOtx1hn5RXu1CjNFCw3FbHEr2NoN3SNEi6phVQK3f1rxzubIdmOC6oEocdLJtu57SmozND9Z3xuuHkk9e/HY/n7CgHSDtQO5On4BuhAUKeT3SMakPeQVlOWd3Wvl9IXcW4xYRNBQVcAugcSkxpdQshf7CK/ECs6vNc=
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 11:39:00 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::82) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 11:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 11:38:59 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 05:38:58 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Print full vbios info
Date: Wed, 18 Feb 2026 17:08:32 +0530
Message-ID: <20260218113832.1312089-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SN7PR12MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe36e85-0cc3-4f14-c48a-08de6ee24eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C3R8jOMukI2+x50WKxDVMuB5qeIcVAzsiXZwU4817o53Y1YkJKqvlQDTbELb?=
 =?us-ascii?Q?yMsb/SxivyJolyFW7Kpdj1Apbzva0Bep0YimYDcg/CE/P0IaypAVMf4VjAIY?=
 =?us-ascii?Q?pJHuqqu1vJfbMBR82ks0XVlE/fz3SCmydMUpFFD89R17N3aBOtRILZBUi7Tj?=
 =?us-ascii?Q?o5Uhn1xTuAAGxgDJMz4kkVEJsBJ2nWouUCuJqp5WuEO3gW8hH4Padez1qNZs?=
 =?us-ascii?Q?raUrGv52I1+GoocsRCI0RAg3WSpPwZKMQzVo87jH8HRGXA7K0iLHdBS1BAc3?=
 =?us-ascii?Q?zYDPg3lHI402FgFtRXQ//ZQBux8TUC3QgBY3erWlOR4TWxF0AW22S0iogW/M?=
 =?us-ascii?Q?LTPaS096FLXoz1+R5wu5M9ZxL70P08e2uKpoVAxTAiqP+EJrP9qju0cpXP8w?=
 =?us-ascii?Q?VXwi/hweDqzXrlaxwL8xr5KQVPIAXwhGwLxwgEV893zkLXTyzYVg5Dbm8RRp?=
 =?us-ascii?Q?6nv6909xpiYGG0Ja0U0xbh5J6bCxH/ryWBPWKsca8eNRVt/DgtNEFHPBD7kS?=
 =?us-ascii?Q?JHxXeXIGtrFoFdFi544kcAVzK+dRmvU+//pWQJBYDFr34RQNNo6J8RGnG0Aa?=
 =?us-ascii?Q?x+6shvuPbRJ6D9W0ABgREH9xhcAsmuaNhiMiORBH36wKinMQPYORQS+B3nLi?=
 =?us-ascii?Q?cxNjAHoG27se5HgEiuEB7mjS1hNIQqOucJ9jhYwJs4Tbywq5NW3ddnbVu3cZ?=
 =?us-ascii?Q?c3nPFrHesDA4kZGPsU3PdgRM4mYqaOzMHXbDg15vGuTAlv6BuMTkKLyPHQrM?=
 =?us-ascii?Q?A+fzKrwfg7jQ80u3WK8UaYEkCs07T59cw2Py/8Rduv3P6BUlA1fgyyDh2uhR?=
 =?us-ascii?Q?XyyubjQuoZs2f2cq1KO1Hns9h0bkV/HSc3ZlGYwxAZGj84bQQnBonmVTOuOW?=
 =?us-ascii?Q?YKUdO5vvLE2wM/8alaYvLOwieUrft2WoUbmEgjIPJlzOk1ePqEWuyS53nDFv?=
 =?us-ascii?Q?L4jWNyJ0W2dPPvdZfieusk9iASCBLHeCnutYG3nRd8ZVNzvzuJvf0rywSVfp?=
 =?us-ascii?Q?ThwRR/SeJfignqsfcn2cY6RadgzUFDEF/hmdmd0Qio03MOG2iRDYLZC2LI7+?=
 =?us-ascii?Q?yg2ZV/xHAOj9nupoeVYBK2rh9QWOjJy4LbRiIshztqZxvoq3N+TyvgKBF32e?=
 =?us-ascii?Q?sKY/eQsS9NnjsC5V+SwCsYK0gwl3vrVyNdsbG8OQI405tnoBJLP0rioBYn1m?=
 =?us-ascii?Q?dkeWjB42eHyaFWk/m2VLBfV2ocxLxt3falwIne2k4IfWaOJ34TC04H9LIt/s?=
 =?us-ascii?Q?2lmwJRQz2Qun/RQMh/tSN16oykoR/rmLXnAyV6kAorrQnQCuPCgrjiSco4Ai?=
 =?us-ascii?Q?V54UqDNngWUm7yM0k5+KWg0dXDltGVRoscFcrHhPeTUc4i+I1T17PfIVScDW?=
 =?us-ascii?Q?Btpxs812BCdUBsJHORFS4rpyO0jzea6nkBgXWMyT6D4dhqEHFj8Eey2wwyQn?=
 =?us-ascii?Q?wCLlpnt5LNjhnM3FCzj3E9qike/hB+4On32ZdJjvQnnRjvTSvq5Ts/Ltvn5+?=
 =?us-ascii?Q?Jp99KgKd+JmeTFrwEvAH7NyLuUonBxsT2CkIq1QkZTig0jrFS62ypnDUZv5E?=
 =?us-ascii?Q?QZ1ZOEhCDPhRuoWmCKBFBsuVfN6z83USFbpx55lChnHlY+R0k1ulVLeWuM6Q?=
 =?us-ascii?Q?oYmzOed9YcMQgqfri163j3Q1esGyYMwQabvF/0UbYOmE7+KfhGgEdvOv0Ah8?=
 =?us-ascii?Q?Ok8bvg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e/nXXQxRQinRxkMTa4aSgImWRps+URMAEsvw6187X6BCLYmqiZRlrIv7NmJkmfxalCJ7hNatCtht5MyJFsZpXSg5UcRs9mk6qgjY10xY2NvlChONP6jzb+zndzKlTVnTqkmLGovA7gBuWz62pMIX8Rh81kQXJoinqTeC6CBoNGWqAg8W20N4/dpyekXcUZx3ibnkJgh7Z55YwyO9RNjnYig045yVMsbbV9Gwtjl7PLQerr5mXZ/rRE3sX4aARujSPQZYVywV/6Ymb45PG9qzEo6RI+fql9Nq3edKU6QU5nd3j/SCHdwVGWPhO9w2R7SVoo150xx4Bz1KVVGXGPXj+3Aw29eEZmChVPAugQPhRvS3y8NkT8iIzfQHwIOtX9WlaQfCqgTKFl6DIoloxrmjgqDoWON0AqI/lmM21VwblamnaqzN70VgE9s3qgeOJ6xJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 11:38:59.8712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe36e85-0cc3-4f14-c48a-08de6ee24eee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145
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

Add build number, version and date to the existing part number print.

Example:

[drm] ATOM BIOS: 113-PN000108-103, build: 00159017, ver: 022.040.003.043.000001, 2025/07/27

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 371ee82a8912..cc5b6ea7f6d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1462,8 +1462,6 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
 
 		ctx->vbios_pn[count] = 0;
 	}
-
-	drm_info(ctx->card->dev, "ATOM BIOS: %s\n", ctx->vbios_pn);
 }
 
 static void atom_get_vbios_version(struct atom_context *ctx)
@@ -1520,6 +1518,30 @@ static void atom_get_vbios_build(struct atom_context *ctx)
 		strscpy(ctx->build_num, str, len);
 }
 
+static inline void atom_print_vbios_info(struct atom_context *ctx)
+{
+	char vbios_info[256];
+	int off = 0;
+
+	if (ctx->vbios_pn[0])
+		off += scnprintf(vbios_info + off, sizeof(vbios_info) - off,
+				 "%s", ctx->vbios_pn);
+	if (ctx->build_num[0])
+		off += scnprintf(vbios_info + off, sizeof(vbios_info) - off,
+				 "%sbuild: %s", off ? ", " : "",
+				 ctx->build_num);
+	if (ctx->vbios_ver_str[0])
+		off += scnprintf(vbios_info + off, sizeof(vbios_info) - off,
+				 "%sver: %s", off ? ", " : "",
+				 ctx->vbios_ver_str);
+	if (ctx->date[0])
+		off += scnprintf(vbios_info + off, sizeof(vbios_info) - off,
+				 "%s%.10s", off ? ", " : "",
+				 ctx->date);
+	if (off)
+		drm_info(ctx->card->dev, "ATOM BIOS: %s\n", vbios_info);
+}
+
 struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 {
 	int base;
@@ -1582,6 +1604,8 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 	atom_get_vbios_version(ctx);
 	atom_get_vbios_build(ctx);
 
+	atom_print_vbios_info(ctx);
+
 	return ctx;
 }
 
-- 
2.49.0

