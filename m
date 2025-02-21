Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602B8C021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE1410EAC8;
	Fri, 21 Feb 2025 15:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VD1AAkb9";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF6810EAD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IffZFwSabcC4oIZAqwAuGU7OhdpEWSy74XKzwUK+IgntqYqlsPUzWyoMofpVw6XN4ywf6oRY8gsiixD91GjvUM0rpTr6gQH3LR/jG/AFQmIBI79JfXJee+nxFe25SnwvilN7VZMBA7lBARf5bmY9xuvjpOMjiMMD2PUZsuadp8iy9sFBjftyrHEpGeTnTHrhC529kbqP8gNp+4EwBz6gS5WTrvCN4A0683Tt78VX+VqJEq64fn6jIdk6DtUWgCk85u2HkKpc557KJdmp1A7O3+1SrZ3Nf/fYORDGQ7321itw/BI49WbK/wQTjhnzfcGhvfOmuAcj7XN24Aw+WHvXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R081jv5q5ZnRdjnlvuRbkOPLqptYpuS5ij+Y4wn93yE=;
 b=TmQl86FZotmIa1KAK2MnV1Wor2KYJxV/YnwSzY4oXVfkDi6RSKpDELQXYSBLVUTBvxjH/VNFUS8sirEVwW/JFQCodWMHMxgLhBBxAsaonfRdMPFsfEWxG9Z9JwCCD+sq55k1k0UV05QwXOj4AKX0SIU94tsnkre2mx0pR3Jzj/AHsdQuEIjOrNoNHuEEf0H4iM+mssZPJBFhkvOW/nyso12kyht6wqJLYacanrBDMRg8N4WNkkBN7IrdA1lpiRW4XZW+oq+AueZTdvfSX7hdWTEyStaUoxnICAHnvsDbGYj36NzzckEaT1sFMykZdLWinZGKgM2gB1wrDhdF02+sJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R081jv5q5ZnRdjnlvuRbkOPLqptYpuS5ij+Y4wn93yE=;
 b=VD1AAkb9uq7yyuuY1GEm+26NjS4YuzQwHchlVhSYzTAnCQs78VtO5ff4RD8WxdjsRWkPB3V5BJZU07fzt3Vnth9TEDIeeVBfeYfqouXicufHguGsF7VB06cr5/D2s7g/UaBBoqexr4paZuhv02jnwuGz7qK6tbXfHE4hf7K15Rg=
Received: from BN1PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:e1::31)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 15:57:59 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::8d) by BN1PR12CA0026.outlook.office365.com
 (2603:10b6:408:e1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 15:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:57:58 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:55 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 09/24] drm/amd/display: Fix unit test failure
Date: Fri, 21 Feb 2025 10:57:06 -0500
Message-ID: <20250221155721.1727682-10-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ff44c6-7827-4a1b-cc7d-08dd5290830a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YP8x3CFORQxEwXV/3QssQ7RDlRfI+s8HvBI3IBSEddSPz6XdChUaTPU8uOCR?=
 =?us-ascii?Q?6aYHLldzcrTmQeBrmlJeOzk7GpIbMdbpSOpivcrx8Fe8DQHE9QZF7u6RY01+?=
 =?us-ascii?Q?azGbcfQrWPfsc/FxNJ5iFJYYloXyOXQslBigcb//GyPfBeI5dZBFMej8qSU1?=
 =?us-ascii?Q?cht7VjgU/khgHzQrxdtGbI+/Cw/jJczJ6KA8Cptz/njX5Vzx+OmOpeCaMUna?=
 =?us-ascii?Q?Wrgy3DWgxm9h/Gzih4KC4AIgjkNqBD9huX9iR1Xei/OeQ+dkNUPd8qFaHYRm?=
 =?us-ascii?Q?VSkvGHuN5VwyiDOf4yi6p3xBbcSNT/KulYJ9sf3brnMpNeneK9T94GoDd+7D?=
 =?us-ascii?Q?jGV1PZ4C82q6L0C8+55QW97knk2GxcqJFel3cxTE/pzpXLRHPOc4H/EcO96Q?=
 =?us-ascii?Q?ZH3wAUJuiIsRHr9CR6D6iziIjaYIbGeIJxboHon4zR/H2C8eAwRcuCFw4EFb?=
 =?us-ascii?Q?kRl2JB9+AFFEE9Qo6b+DHDbJaM1scmPXpfElYajyMojKAmOlHnV3IgO583oc?=
 =?us-ascii?Q?mc/IGIN5BHNhNZzCvZnUfx880yEmpjHU2/hiViK95A/gWzFVYH7zG8McNjfs?=
 =?us-ascii?Q?bXC7R/7vhharJsrSrb2fHRON83/DGjZP0uMTtPPQrqZwS5YlfS0pEbWHFv/2?=
 =?us-ascii?Q?mkI6EM99x9gDjRbag28LkoKiDT3IweYBYMkRFPeI4Ut2u5xa3PFqo1MrP44j?=
 =?us-ascii?Q?bAy+d61CJSD6Om4jY6oHgkyR1OPamR/Wh5zcfYIyoUPRhYU6lF1baAQzNkX5?=
 =?us-ascii?Q?W0DU3yBhSBKxCvNP91z1iQxwyJnJwTzTU9fGKleYtDhh6D1aIMu6xfmprfuW?=
 =?us-ascii?Q?NvrZQ3Y75iB4RXJ5FY8dQsXaD578Z73BvY2tdosQiqdtyH553RY8TkxRKipm?=
 =?us-ascii?Q?ZoGb52Yu6F+LDdGYP92/wdLv0M0xpB/mYazuVoxCE4UV54ihaZnmynKKYN9s?=
 =?us-ascii?Q?sWknOBmXOUmEgQ+9e/429Nl5ooez9NLjiMnwXQ6Uuk1yO1QOiVH8qyaW7jAI?=
 =?us-ascii?Q?7NTfw9le0DyuB7In4xtPmLYWcYNy/YxQ9uyWFANIjXTzWqyACtfudoEAt5FR?=
 =?us-ascii?Q?ERNUP3MQZKssyaLNDPdMj8xRoTRy2YhMi2veXgtRagnRS5ozbNnntMNzmpWA?=
 =?us-ascii?Q?stZIhUdxekYPOKxXvEiEI3n8e4jeB2RcLtz1CAO8kOfRf40Gve5GuUY2F7V0?=
 =?us-ascii?Q?f5Co1BVfkgLOIEu2443VdeSlrw63qmdhZ3QZkJ2qarAU6aO/VMAtWy5xf4Vp?=
 =?us-ascii?Q?AHEFWXrRLRMMtLu6oqr7jeRlVjXMSuBa0eqMvcQwILqHiDZ4ReElVn91BFEZ?=
 =?us-ascii?Q?1cEjdLb4U6yYwynd+W+2Fkui2yy6IFWwjYIAAIhBSs6Rm9bEynj9TJenaS/q?=
 =?us-ascii?Q?S5Sdevvmn3Gn9BX39xjVHmFOS/afQFY3JW8hwREN0SPnWMVtZIUQePr1tlgj?=
 =?us-ascii?Q?reijUaVG2LCBDbDOjWT9txKL9UnEgduo9CUm+YwPeq4rMrsYAAer2RlkQ/Vz?=
 =?us-ascii?Q?PjKgsvviQCQiiNA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:57:58.2988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ff44c6-7827-4a1b-cc7d-08dd5290830a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Some of unit tests use large scaling ratio such that when we
 calculate optimal number of taps, max_taps is negative.
 Then in recent change, we changed max_taps to uint instead
 of int so now max_taps wraps and is positive.  This change
 changed the behaviour from returning back false to return
 true and breaks unit test check

[How]
Add check to prevent max_taps from wrapping and set to 0
 instead

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 047f05ab0181..ad77cef57ac7 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -1026,12 +1026,18 @@ static bool spl_get_optimal_number_of_taps(
 			lb_config, &num_part_y, &num_part_c);
 	/* MAX_V_TAPS = MIN (NUM_LINES - MAX(CEILING(V_RATIO,1)-2, 0), 8) */
 	if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) > 2)
-		max_taps_y = num_part_y - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) - 2);
+		if ((spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) - 2) > num_part_y)
+			max_taps_y = 0;
+		else
+			max_taps_y = num_part_y - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) - 2);
 	else
 		max_taps_y = num_part_y;
 
 	if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) > 2)
-		max_taps_c = num_part_c - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) - 2);
+		if ((spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) - 2) > num_part_c)
+			max_taps_c = 0;
+		else
+			max_taps_c = num_part_c - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) - 2);
 	else
 		max_taps_c = num_part_c;
 
-- 
2.34.1

