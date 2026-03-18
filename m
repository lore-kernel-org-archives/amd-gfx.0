Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4FFFED9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C4810E65C;
	Wed, 18 Mar 2026 01:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oiwvnw/c";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01CFE10E65C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBE7Ul3JVe7Zdb1io0t/1+1f5W2eCLWONmXtsU34W8OtFXIxTLGlB3IT2HS0KQEoQOh2W1BX9iR8yg6G+tyJWxA9Hs0L8BRNKWwSVp4c1zP6d19a5h0BAmktzeE3kPedIfxAYTkMu1RPYkOQxDEtfPKVagl53G7v5CvJ7n6GtKIf/HjGHfEMCdxZyPgzKy9WRg/8G+KjPsiG0tG51WxkiEQ2hRYTt4Anw4PRAUQ/QqT+1IubZ9W/jOtuRG/+7z0Bq4sxVmdKa+bYB+VMhrbvXHsAU2naDUL0V/NF/3LOfMWPjSKOUb0Bxjtmv8Nq5d/DVScdEm87k2Jy/ECl2Yl/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtfU+gSrwD1vu7axKjMutmBAjDQMmz1sWtqNvE107cM=;
 b=HwuioqwRAf3LwgLLE761JtP7l9tmKOicXvrro794naVLMqzh2eYBtpQ2PO9W5/dGZOAOnramFtw/zWJAQ/mX9V7QkcI5wZTOyGtfsKs1ILDjWrFbqnzXtGLma7XZi+i6m2FKIx+Osf4L8kEDN/r7AtONTGbUNnvIi4BAI9i7+VquBurPfM91nkYLmuS0Ou0NbSv3wBY9binystOwhlRSqdiLvegvZLXYgMymaRaame+bSGPvY2KHT6ok4sYGd+OXKFSQF/Eg2WXfD3AWvUpCcmQ11mce2RfpU4YuP88+fFcTI5urxNzxmDZUo1Xi4XEyeTBdQ0oK2Wq95u+blK3KxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtfU+gSrwD1vu7axKjMutmBAjDQMmz1sWtqNvE107cM=;
 b=oiwvnw/c5Bl/vKVCoqcHnmX5kqRUHT0CGrETMInFzITsKlx2AkuMuKWiXIfjHlB3VD05IUJdeiZ2wBVQtyxpYnsIdVKn52sMJOMYYZOl43T92W6u6IScR+s24IvJJ1WuAemj0GFKZ1Sz+tVoaMrwi0ePXlrAjNEiTindrXbFHFM=
Received: from BLAPR03CA0097.namprd03.prod.outlook.com (2603:10b6:208:32a::12)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:40 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::43) by BLAPR03CA0097.outlook.office365.com
 (2603:10b6:208:32a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Wed,
 18 Mar 2026 01:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Wed, 18 Mar 2026 01:02:38 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:23 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 23/31] drm/amd/display: Hardcode dtbclk value in bw_params
Date: Wed, 18 Mar 2026 08:59:32 +0800
Message-ID: <20260318010224.513094-24-ChuanYu.Tseng@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 213f7f3a-7254-4a61-ef69-08de848a0c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: twuIGaUcT8vuRbWpYsdCRI6Rmp+qzqiavJSzOprFeaGY4HzevlruLz2lYC5JveTSMYeqa7wF48wLaOgtRviIJCkAo3H6Z6GKlJVBAQFximZGAfRUR+7XGE1qF1ArshaaOgOi0N1g7f/nBY0WooUuPrQi57yPt04niRgENSrfyWPgqg9PVapIka9caxkKLP72x3YmziN2aX0wkITBbH8lRlB54m3ioctY39mi/mwcL4Dyn+ggWQv2Y/qHEMd+FkpIIEzB3zLNikf7oaJf2vEQLXoe1sJ8Ry0fT/ZtFbsHBYLIr39x7dwWyeKoT7O7g3C4Rzip0NdZvTC9GUjpsyhHqXeTlw0l4LJe42NWKvbtEPrhjuuzAuZCOl7TTR/XQ6LJIYnPOyW0Oq86KDr5g2mFfx/yVsKoy5xIvekWXzcjZBxbXVZPx5Jv8G177HQwYYtog4yJzF426aNoFbpPpMlvjMKDIWWUMQ4+9IMOugl/fo4lDQ6vnmeylXKVayipjRLcbjBePW2uW4Y9Wi4kj9rBmnPs8haKm0LSEbnTvfdVygLLEg1LMLkRqlgE9bPW/hC3kuvCkAHVnp8gvfrLWKcsXp3viUuOPWfl757nsJCfkibs38swZ78RfFM+N8yLgtBtfXPpIcZk5stzaDHKPnbqxwZ4IebJ0XE30c6KBJY3evpAlUEca/N/9Qe7edIqtO/hqaNn4HcvhJ1jZH1bRUFA7SNGgjgXjNN+Sl0pXiZm2/aYHkZuC/d91/dQnPOgwWT1Z5qd2H7p/9jXGdK7JPqO1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rAjTEu7GThCsoJjHQuj4Ksk9gD7Cy9RWniIwtv3Z6zoA75+sXCyKg7wZmuSU6RmQRm71DzdFaeR0KrNk13V41K8IX8AjxXx7Oc/NZcOW2VA9o8qhjRfhkI/0qsgnu+azKQRftM7k/w3C8VoCBXXJ7PgPeyrMesrva+WHfB9B2RipYQ2tL8jiDSlfV4IqlqmN589aG6btWIYi1ZGaSKA5j9b4n6Rkk+Djagu6B2Xa+Ou9VxmY+978NCY+uWnIOOw/+YGMHc0+hviNh3+mkugJ/69Z0tOdS5IYbgZN1OlvypIwsm1tJQosF4nMwZB0jMzDuOE40bEAP3kA+thrwJk5TZozBf/p9L7c26RhqoewJsh6ggKNZuEZYhTleWva0YodgPJsSYEXxd6sy+pzr7t8o49vfsaa6J+gINR47XgW6xQ0p7aEEx5fZ6lblNmsoI7+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:38.2638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 213f7f3a-7254-4a61-ef69-08de848a0c7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[why&how]

dtbclk should always be 600MHz. Previous logic was to get the real value
from SMU, but this returns 0 when dtbclk is off. Not a problem during
boot when pre-OS enables dtbclk, but PnP was broken due to this.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 5671fe481d15..b4c6522e922c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -594,10 +594,7 @@ void dcn42_init_clocks(struct clk_mgr *clk_mgr_base)
 	dcn42_dump_clk_registers(&clk_mgr_base->boot_snapshot, clk_mgr);
 
 	clk_mgr_base->clks.ref_dtbclk_khz =  clk_mgr_base->boot_snapshot.dtbclk * 10;
-	if (clk_mgr_base->boot_snapshot.dtbclk > 59000) {
-		/*dtbclk enabled based on*/
-		clk_mgr_base->clks.dtbclk_en = true;
-	}
+	clk_mgr_base->clks.dtbclk_en = clk_mgr_base->boot_snapshot.dtbclk > 59000;
 }
 
 static struct clk_bw_params dcn42_bw_params = {
@@ -1069,7 +1066,7 @@ static void dcn42_get_smu_clocks(struct clk_mgr_internal *clk_mgr_int)
 			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels = dpm_clks->NumMemPstatesEnabled;
 
 			/* DTBCLK*/
-			clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz = clk_mgr_base->clks.ref_dtbclk_khz / 1000;
+			clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz = 600; /* Fixed on platform */
 			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels = 1;
 		}
 	}
-- 
2.43.0

