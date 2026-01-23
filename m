Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE96D7237B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 12:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0997C10EAC5;
	Fri, 23 Jan 2026 12:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LwKSM/fS";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3478310E125
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 12:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEWOX7MzrkshbnHv454gpG3viVqn0BthuuXl4/ftNeq9TENjP6JBbKhR5R7gOZqCbgAh+W4VNyKPbD+ti+OMBAM/IegIbvBCuQLrqskh9zle6jciG5PLZR82xa0pWmJ/esksi5T+NyJu1FH0k0ZT3Xo7MD1LCrkKlZ8aCubbRVzot4ODlZpEH6k7VCnkjTOCcI15WdBI2PJXMze8J1pe3EYHh0ffLs5z4xhYBXw8yc3MjuRu8enBwPauA2jrQjXrHjrbtYBJTlm6PGVwbyeJ/OUD6DbbdsDjpakqO+uwqJwVNw8fTPcN9j0c2GkXvwVVqQdTzr9OooRJN9OK+r+Pcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgCOaLKR2m8eqrDjIDcJYZAAWr4FupGnFgFwMe6R9Rg=;
 b=gAbhibp87giz9dho/YLiQfpwgPoX1/N9dswp3YW7/I4HabB/ww9c7PLB1Bti05YLhPwKps4UaLgqwdHH1s3PnZIizhw8bf9Oz/G0aWvWrl7Uug3yubMBvlXbvnOVj4GjBE9GDb9OWtUQexwbzjQV/VGyhMUI/BtS9vZmtP6xUb673q/yhkJjOFz5ppA/gbutf+nKHtyQVy9CwJsnABUMz3PKCoZEtT6bFxa6+LExwzZJ9WnAYECEPf3nba0JCcHzhQjkHWcGdiGVCtpfyejgnPsPjSJWZgBKdbeAoHCwcODrOcXZPAYKoGJzjGQTwqjuOBdXU6bR9RHaO7MCFT6+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgCOaLKR2m8eqrDjIDcJYZAAWr4FupGnFgFwMe6R9Rg=;
 b=LwKSM/fSaE++IhmKqTq+8+NhoX379shl7Ud07ZSQjVn59r2DxFEjCjZ/8KLYJ2NzVr7xyfVGdo/92NJBEKOJyCxwLCCliWGpeUILKPPM8rTJ8PqP0pExA/UerCvcmsoNf5iESlaIQMnyL7tp6bCw6xpnRBEbQiH/+n/WP7FGLFg=
Received: from BN9PR03CA0984.namprd03.prod.outlook.com (2603:10b6:408:109::29)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 11:59:56 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::b5) by BN9PR03CA0984.outlook.office365.com
 (2603:10b6:408:109::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Fri,
 23 Jan 2026 11:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 11:59:55 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 05:59:54 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amd/ras: statistic xgmi training error count
Date: Fri, 23 Jan 2026 19:59:31 +0800
Message-ID: <20260123115931.3857571-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 35550d9b-46a4-4d0a-c542-08de5a76ec81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9IvZTt7gSwxnOfwrpZnaJDrrxcRu7T3COk8oH6Va4FB9GBKGOnBSlQZqHioe?=
 =?us-ascii?Q?D2HnJaQf5Wp/QXv2hLhPhr9F4TYmAfBsA6iVEeDhT+C2nzi/w/V1wy5KmN4i?=
 =?us-ascii?Q?JBHQeoejziUXU7f84qYwe+aU98vP+nrQyEZuuxt+NddPytAj2mx7H6+2yZ7v?=
 =?us-ascii?Q?jNlLWAPqiAHjea0mRiOaAZqRkEb+7T8L33kJHBRlUjeqIssELkXXc7tE8B25?=
 =?us-ascii?Q?g8gYrGYxpj4Yw1MSSnY1LImcgrGQEn4s9Zrj9OOulabzRemZx81byuGT7PAR?=
 =?us-ascii?Q?W7EXYEPWvoVU07T30PPJkK8WVq8+ai93pemmT1EMTVdyMf/PMPXEYwfCxd4C?=
 =?us-ascii?Q?fxsbfCzG6RN5L9voxnMRl8/zUsi3do3E85wxvF5h4Oc+axMkfJUGWwb0OPel?=
 =?us-ascii?Q?tGJ02KoKSelsUR0vQEmOWCESAvb+jm77emTBQJzZBi17HsLx2/TfM9jFjLLa?=
 =?us-ascii?Q?ZUw4HoXH84JOoLt8QenL61tW9Fj4s7qWkuyDk1HIgtLLQS4HjUq57oMlGQJz?=
 =?us-ascii?Q?OoueX5m4/L4C17Z7m0XR+ECfMLBSgbCCI3RoMNOnvzsg+uwV4z0Zmwdqdm8P?=
 =?us-ascii?Q?1vWuzhu9YNwBRAMlpR1xYhWDt6BYrRr18PRFB2w5T6G+9gAZvzsoXuY6OZ3Y?=
 =?us-ascii?Q?hbmJ4+Blxjz4uk6JszjLUG6DjvDNjlZ37XFFeyhpf8ljzpTjccsNd3A6v9IS?=
 =?us-ascii?Q?h33Fv748kUGWnxbTWI4h+Ay8Hn3HYw0U0p6wbVvRAulbYyZIZ1/EOjj7Eeur?=
 =?us-ascii?Q?Wzu0gGIopLg8NTRuOtu6ovLlakosGTbk3u4+3R200aiPFw+UMLp6cGWK7fiD?=
 =?us-ascii?Q?p/wYBZ0836UjWkRsXJDuSLcEIoI/OY8/OcXzpl0UB5lco5chnbwliEE2FS28?=
 =?us-ascii?Q?yUpZYbL6REeAREWWbmhpFubs+TPFMlYIlSfvU2kFinJO6D3zfhpnf82gNJte?=
 =?us-ascii?Q?qem3AMva6zthZa5jElEoYpauCTOQWygGxmL+GyphSUnsxG1xn19b/ZTBvCbX?=
 =?us-ascii?Q?JxamB3ULE+1hwcHcqLx55yANPoEvMOZ68Wfzy84nYqF1SCz5fnpz6fqlY2WO?=
 =?us-ascii?Q?LID5Df23Tvj8J4wUisz2XlLxIPPQr54rIFkMP2QzItLaQhmwXH929dFknHR6?=
 =?us-ascii?Q?xKEniDSyrjC2ZtbwApLITkYghO2jU9EVkF1eNPccSitGA/NZD7y0m0p2wVzv?=
 =?us-ascii?Q?o/Wvjx9c6A/s0k+PR5rV3L4zhOxZ9iEltGUky1vzqT5Nx3U8S3Fnm2BmlZNe?=
 =?us-ascii?Q?ijQLiRKVEtlSRGVsSy2LzX8PuCLEQhHPXDB+namTKubiyXi1Aav11lx8zIuC?=
 =?us-ascii?Q?lEvgZPu0AEvxJym/4ELrMQLqZ8sTn3BYktV+RAFIidXQ4Qlfykk6+BNfyLiG?=
 =?us-ascii?Q?coGi+ygkaZV8/bq4TvDlEk3t9vjPUSdCCMk26/KKB7LCh0ca0FxXgLtKIVaE?=
 =?us-ascii?Q?15FSE9ee0q2O1hyY/YsBlyQDhid1jN9tszQn9CzREk2OmHiOli4sguFppMZC?=
 =?us-ascii?Q?BzdouiP36FeuaKKUHAziHf2b7uKwSuaC93d06Hr5YjyB2dE21h3nYuPfLDqR?=
 =?us-ascii?Q?q3gaKln+RKonARzIANsHo49HtxGkQ6oN2aAsccp6A8TQDc0jgF9zWZNfTG4+?=
 =?us-ascii?Q?r4l51qjMNcVW0+BmW/48ASOYkoOgWpgRsQapAXDGs+Ly71KywT602axVJ+y3?=
 =?us-ascii?Q?2nzYSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:59:55.3333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35550d9b-46a4-4d0a-c542-08de5a76ec81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702
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

Report xgmi training error uncorrectable error count.

Change-Id: I7f2edf00ed37b5a4f13115ab2f0f914f07fc8519
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
index 29df98948703..210fbd8851a6 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
@@ -299,7 +299,7 @@ static int aca_parse_xgmi_bank(struct ras_core_context *ras_core,
 
 	count = ACA_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
 	if (bank->ecc_type == RAS_ERR_TYPE__UE) {
-		if (ext_error_code != 0 && ext_error_code != 9)
+		if (ext_error_code != 0 && ext_error_code != 1 && ext_error_code != 9)
 			count = 0ULL;
 		ecc->ue_count = count;
 	} else if (bank->ecc_type == RAS_ERR_TYPE__CE) {
-- 
2.25.1

