Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3B3FEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB35010E63F;
	Wed, 18 Mar 2026 01:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xyy9ERkr";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFB910E5FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQb+sASA4XoYkpr4w/lG944u8McMetuDuefsZyjaONOde3LbrWTq1UhKQiUJeUPGlKnt8P5D0zP10F4+13Aw3rTfRlyagUVZtcGR21UYLj9J8Jeq1u62EV77prda50vk2WoPYr9C4ZBWpI4Iuu/1XKrS0HrLMmJ0pGbVjSJ2zuenHfPYe64tTWenMp0Ffraz/MPQ2N2EJjPpgs76pz3Fhdv7ZORDd7nKh3dezKsympYGER3jkOilAz1lErmAtC9likfxWeL+hjxV7APdDVLV86Bvl9mOi+VZX5FvfunHo36nMlW2DJNtgBNg8v5cukkkGfC510XpUJfQ9mKXMpaW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkHtZuCtznyLQ4xt8/Ai/5u3SI2EOvzmUQ3pfgkuNnQ=;
 b=YikqbtK2SVrgTVpBk71xrsKgxmOQCbVd4eFqTiiWwIqOusxTfay5j8SLVRNMJdn+QbNNSt1Eu0GT1Y7lLHDSDijWa6LNAGdpXrf+WjmRCPcut95IDn2yAhsgoUSfsc2wRQ/FaGBd0u3dRpRg4JbAjsQCFQzvvAUccXRuHMcZxfFc+UgCPup6BHuuT6ISrBn5BDSEMnvLNOBbKwyz6W5Gjni1/n+LxMUX5ztyyoPvxL2QFxkc21v5Le1KmeRJNbj1wRi0r24pHZUavyg+2oyaZALzQ2Cj+1dwTggoFSa7pqT9mP8s/COROraD6cmMtiQtjBARYiwC32UipoqH/BuYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkHtZuCtznyLQ4xt8/Ai/5u3SI2EOvzmUQ3pfgkuNnQ=;
 b=xyy9ERkrvqJID6GvoP3Z+yWXbc7VyPGQrolfcAoGoQB1b8W5eJ6ORoNJIkqxf8Dmr3Ommt46KFJW/fg40boO30Hrx/2/IA2YqBn/V3VK6/zX6V3S+zWWx2bGQ8UMH2DwkFX2lzhxgmcsXK2J0Pq1LwmXdQKmdTQf6s61VR/dGx8=
Received: from SA0PR11CA0140.namprd11.prod.outlook.com (2603:10b6:806:131::25)
 by SA1PR12MB999229.namprd12.prod.outlook.com (2603:10b6:806:4db::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:00 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::eb) by SA0PR11CA0140.outlook.office365.com
 (2603:10b6:806:131::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:00 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:56 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 16/31] drm/amd/display: remove disable_sutter touch pstate
 debug code
Date: Wed, 18 Mar 2026 08:59:25 +0800
Message-ID: <20260318010224.513094-17-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SA1PR12MB999229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0233f0-ef1d-4dbe-cea8-08de8489f601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: EbM2oo1/EIJTYXnLWEz9zwhOzJ6majaWl9w1EGVM36gg2BoDfMtpAmIwpjNbpIEb64YhmUXxDW/GGPgcIIB15eNajzwGzljUzOykZTSLFUefMDKcc0SSlcRI09X58ekjHX5Q1n/Oyz0rWPUKQCILxjFw+ltgnAwWAka5ZvQNq8xCdgE8EnwicV/nFuuwk4I5LgIFkUx7nrecc7Stl72qkbpWkO30Mdlh+Y3a2r9m0J4aafNERwY69qzPbl2Da76zx5ET9TVatwblwkm/1WCrUeQpAiSSm7W7g3P+9AAmSWP9aA58Bcz2Km+Lw7NalL5oezsaTTUGT6OdL8BjFi+oOHkd9s5nA+teWLdccK6p1PtnXssyzjemcheJJWx8L0P36W4F5V5BXtcy3cuNe2X4YR0UbWVFtwMaT54QpFoCSk2qrVEcU2X74FrIb9BwCmpbhqheMN7t79uGh8HMhfT/uSOBfu/P4SOaKWaAk6ROxMPoFf82PTJnV2wti3+el+31Gy5n9WkxC9DLPO+XXl86bpTvtju9gKJIpsCY+X+HwabOv8SrTDzRdwFQr/LTO/ofvGX1iRKkJ9VYOnzr3locIIM5kdAFiSklUxHFLC4l/mcKJnggDPLlUQuaa2AtHrVmK4rajyj99iEbfhBCb8774ZyK8RbIZucS1sSadBsIZbT6ppdtFSZt5eMYusFeCySDVaagg+qzs5QegSYE2rPAQ7qDxqUzIStS5bj6805GXWa06sZMufDSaeakYz9W7D4nhaSGgCjQ3XEbEipaLXZNSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GJaa+bxgL2OA8yUCSIDLonxK3e4k3x0Cqnc5JmYnFrLYiLJ2slZxRkAHOLRrZ2QY6+qndNAnh49iHRl3FXN8zoJKzJT2QiDlG/CMVJt7yeK/55XAKM4tIYqGurX5+ix+M/GxAs2qL8RjN70/17UMRymr26OkhVB79+4JB0l5rd42mHqz7XdXgxpNkFtXehfR/g6aUsJDWh0u59vT+YJJDQoJcBmlrMVE+LjKS/EVkq7plXuxUhEwkjSerCbJjZVGTbo6nrxlsyQVZSxjrrizfwUxKD5Etwfd6o2089sjBRk1n08WJOIKLy7Y9xqODX0DC3U6K+shy3AAkrt5BHnTPlYg1ds86ilndx2JT8XlCRXIZniZXelaPzLhXawxoG1zIE4RDSmBZzfcgf8uHoY1RglLWdvZJKeD3hfegNpjQW7vskVVeIsK5N2Fdx87jwyn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:00.5588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0233f0-ef1d-4dbe-cea8-08de8489f601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999229
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
diags is using disable_stutter, this will cause issue when pstate switch
enabled

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c   | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
index 8582dcab1f22..a436fa71d4b4 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
@@ -430,15 +430,6 @@ static void hubbub42_allow_self_refresh_control(struct hubbub *hubbub, bool allo
 	REG_UPDATE_2(DCHUBBUB_ARB_DRAM_STATE_CNTL,
 			DCHUBBUB_ARB_ALLOW_SELF_REFRESH_FORCE_VALUE, 0,
 			DCHUBBUB_ARB_ALLOW_SELF_REFRESH_FORCE_ENABLE, !allow);
-
-	if (!allow && hubbub->ctx->dc->debug.disable_stutter) {/*controlled by registry key*/
-		REG_UPDATE_2(DCHUBBUB_ARB_DRAM_STATE_CNTL,
-			DCHUBBUB_ARB_ALLOW_DCFCLK_DEEP_SLEEP_FORCE_VALUE, 0,
-			DCHUBBUB_ARB_ALLOW_DCFCLK_DEEP_SLEEP_FORCE_ENABLE, 1);
-		REG_UPDATE_2(DCHUBBUB_ARB_DRAM_STATE_CNTL,
-			DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_VALUE, 0,
-			DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_ENABLE, 1);
-	}
 }
 static void hubbub42_set_sdp_control(struct hubbub *hubbub, bool dc_control)
 {
-- 
2.43.0

