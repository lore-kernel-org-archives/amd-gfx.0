Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56BAC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AAB1112BF3;
	Mon, 22 Apr 2024 15:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZZJjrHWS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313E4112BF3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cgq42+Dw52DNfcIVNL/0OjToPGRgssjXv+N5t921yxSwYaPiCImqFLn8CQsicABPHhA3PETrzPpUH0sJmbPjLn8W+IzaT6ztea80pXuBCOx7eQYG2vfh7Uzz6jcSVtMfrTAm2sdJXw2Xe4fSkvbrZ5nRJKCj8qkQXRTK6iOea97IIc5qht9MamKO+uNQd1KDr9Odsl8qlrQOdHTXp1oX2CDQEfgIhw2PjJoqMzxYl15H0+UM7Xm6J9ZpnC5a6bgmGCFY64/zeVOhzrzLzJEcBbFJk/AbIjE4JKCbPj7hVPDMQgJnuGbL101eWm9BNr96DmPS+qIl6EB/3Iw5FbVGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPqkcHQNQBybpU45naSOZLChpZ1EgNDKY3/gwtu6zfg=;
 b=EdrMSXCBZv68vLco8q0/0BoAwWjJ3zj08IN2OwZkhOTgtEg8RiFzyyE5ZaBhkBMv6vezSO92KLJu6M/unEUGbyhlJA/oLWKDnCHy7bhcG4j3QH8os5fNTCzlaWOWuD6WBPvmVI+PhKLdtsHg/3muVGZoYaKT/a5r7zER1ZT8n5MDOee7RTB+qCYUH/aohK7al8ZJ/PV7mKlIyYonwKXGryHHzn5z5Cd66O9PVl93hRIPNyha0KEAwuFTjLfJOio7Y1TfUKlVWlK2tzL7aqiLhD/p/PLzWxAWAwxRORkqsICluvt+LcLY9rUfCebS3MOtm/bGvgGm2Z09HZZTLAmjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPqkcHQNQBybpU45naSOZLChpZ1EgNDKY3/gwtu6zfg=;
 b=ZZJjrHWSfl7+agG0Sd5d5Cp8pF/SDG7gTW+TFT3ULc0CJrdpVavgLSKeDQQvZdKKZwYvdcxmiBqkAUWtMjgIlcB/kYslIxyAnJ5LwMtYZky/4TnISyXUOrBgHT67lsZkwncx9DxARsnnsTK7sdA2tsyBSmwamkGAz4TKnPQFJFE=
Received: from PA7P264CA0112.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::15)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:39 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::77) by PA7P264CA0112.outlook.office365.com
 (2603:10a6:102:34c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:38 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:29:37 -0700
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:29:27 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Martin Leung <martin.leung@amd.com>, "Aurabindo
 Pillai" <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 14/37] drm/amd/display: Drop unnecessary semicolon
Date: Mon, 22 Apr 2024 11:27:23 -0400
Message-ID: <20240422152817.2765349-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3dcbbd-a35f-462b-d0f4-08dc62e105dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?delExxefmb5e1SOPIU4dEqS+BT8Og+NQovWNwdTrQ5B6lGt27jioyKoSrdrk?=
 =?us-ascii?Q?I1ldAsVn1efd0N9G9PZSKDo4phYdN2uiJ2WjR5zZ9upinvSRr0NFdN8tiFH9?=
 =?us-ascii?Q?lXtN16nHN0+suGGu8lemoJe5/HY2ZWVMrp5d4Guo3EbJFE6/iUv+amUUASvr?=
 =?us-ascii?Q?LkFi6+wnwTYUGIWk+BmRrzivlrQPmwO18T1TGDeIP9jdPhVpdNviPDayayJ+?=
 =?us-ascii?Q?L1/eR93aRBLwy9mGTRmEVESWRs8XEpwmQDT63cB+X+CPFep/AzbCG0Ge23h0?=
 =?us-ascii?Q?8jz5MRNwymTrPw80PGnImzMumEyNfc2bk0CfHDmQWue5u8qHLFGHvqsS/axj?=
 =?us-ascii?Q?sK48QbuqGOlvMMAmByEx6iCjulxSPUNPG4+NFnSfKoMzkI+k8r981cQ4gBiI?=
 =?us-ascii?Q?rvZKsYK4GNH87RglLZ9zZRcPINVQu+QFuOLb4MdukLskTkIXUApuoZnQWHSb?=
 =?us-ascii?Q?JUqurmprCo4PBC+UuDda4VXpBwrAlaE30fitaijH65Hd20qTPZM6JAfFcPr5?=
 =?us-ascii?Q?MkXjEN0jYjjToevNGDrQNEekTE3BfcnpEGZ1FF4jyVgyL4GTtmq4cXTxolTA?=
 =?us-ascii?Q?STHVdvrEKXCloj1Foq3x3I49+lblauAUBgN199JRJHZvtcMAdQnl+2cBx0yb?=
 =?us-ascii?Q?Q/xuqcxfRZiHM66WvptQgaF27oC8JRxIepIxus7FC3vzlny873041QF1UORw?=
 =?us-ascii?Q?77wzuTgQv8G3L0XBbRbEkSGAdoiA59RGgkLuY18eB08c6fjZqzafpjf9ZZam?=
 =?us-ascii?Q?RcyWuRJmNCCimn+W1z3hmmoe6XQbo30KCu/w+A+No5DyV6CvA6CLvEhsQtCY?=
 =?us-ascii?Q?O9lOl+yafs7SU23KwGkjy6g1QEW37e4n54/E0GoBzZ8QwWIricNwpJu+7Mzb?=
 =?us-ascii?Q?OzKBVYRS2vykzggTYA8mVZO5krU8SGavvAxstJFPilu6uaM1BTm8QOqrquwX?=
 =?us-ascii?Q?JETWYSDPY0G69fFrMDWhBk0dwaPn6itUTmjUDI2p1D8AVrU0l+77ejbM5onK?=
 =?us-ascii?Q?tpcytMNyGVIwVneldNQEFo7PmDQul9kfQF+3e2UXZTthayCsMSn7rCCHTvOZ?=
 =?us-ascii?Q?lB50Q4LJ8lMweB/k08f8Bj3Gr2iVzI2+wdanyHea4tNVIuz4AP1scz6tUO3G?=
 =?us-ascii?Q?soIV1XQq6A34BtW855DstUMM00Bjn2vgddZW1Pq36ltBbCyrQDnNxWQ3nfbx?=
 =?us-ascii?Q?AT4pYMUev+YJP4EtW64/fXXlufvDI2gI+e2wxs/OHesc3iKBZhmYLs2/vGEW?=
 =?us-ascii?Q?GhRH1UCj1qwlVeXQ9sDYTk8DIK1vU4MbeTSTUgEN/NyLZjngo9cpoEGl/2ig?=
 =?us-ascii?Q?0a9ShzVwu+/zAUsK3OPu0CHSPl+PUYQei0otXsBJh2M5qF0K+3Knfm79FInn?=
 =?us-ascii?Q?rTy26k4iPmbcVlrZEhLrWV6ldQpE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:38.4729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3dcbbd-a35f-462b-d0f4-08dc62e105dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
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

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

Drop unnecessary semicolon that can create a problem of double semicolon
in some compilers.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h
index aca389ec1779..edb7f9653cb6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h
@@ -42,8 +42,7 @@
 	OPP_MASK_SH_LIST_DCN20(mask_sh)
 
 #define OPP_DCN201_REG_FIELD_LIST(type) \
-	OPP_DCN20_REG_FIELD_LIST(type);
-
+	OPP_DCN20_REG_FIELD_LIST(type)
 struct dcn201_opp_shift {
 	OPP_DCN201_REG_FIELD_LIST(uint8_t);
 };
-- 
2.44.0

