Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E02ECA5FE4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EBC10F9DB;
	Fri,  2 Oct 2026 19:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tJNYPb80";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B915810F9E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIUOsaQwTDRkR7nAmeANiT9+ZZQ3wqMbU2wimtRnQ3ah3a6HlIPxIjgmQzpC4ayPtAyzU48wWT9AEsTOmHTGGSMxPsFArIZpn3asDTzd+Ps3gDjV0Gm0oQQnZYL8ejaTBDMRhQVG17qgsbKFHo+eKGJKlrFnTSF+VVAMdl8DnPPwiyQF1U94z/P/vGvmjb2m5EZMcL2tTAeKHPkj6XMdgwq7sZXoYuT2CeqkJXh3o5Ee7SDHZwFw2/VWAIxe9NAD1Au/eKTFD8Z5QmHDUHsNA9DsT6KmBFuAm1DDZE8ZaeVbS+bFR/Yt5dG/XB15G0Y/lBlXn+y4lZV0uohooBmWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or5VBxuDKUvN3IdeZyWs6w6QQ22c1vFAzbDK207CXpc=;
 b=P4QlZk/SPVE5C7EHeDBD/BRfg4RurMx3hdwHlJacqYnCUFiych5Df6V1BaTzMcv+r7iZ21cHT6ira+sVyJeID/ISf3X2lBFZQ6ZxqLqfsFt+FJCm4/SZ9nie2+LWHWstsYs61jBb8OsreZnBLAt3KjtdP3NoaJpTfhiJ3o0OSJeFSGlSr/t7M4OYWn02TSOBr+eZhM/KN35MSfB13AK/3nl1jDy64eMSvz1DuWvkIqqAzaHzuZGoiTH8QW+F45YJX/XlttRiDkb6pRX+CX5bH+jUNaBbmY7Fpcuh/21eF1XRy042UCaZFLG47Xm6bJUxQEH2nl8TLlfYV7dMrEK18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or5VBxuDKUvN3IdeZyWs6w6QQ22c1vFAzbDK207CXpc=;
 b=tJNYPb80COmvjRNe9d7UuuX/0lgFp/LDilTJUPqLnzJ6mGZGo4618eaUGx3xUCs8Q4PziKmvTicdIvbpjKwyrHx2t+BXqcAwostGYWhl4qc/ZxrwxczMJFhf2q8yPB2NJ58pwftMNqY8hAzN7O9+F/EzpU0peT8xABENPbjGVUM=
Received: from BN8PR04CA0056.namprd04.prod.outlook.com (2603:10b6:408:d4::30)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 19:33:24 +0000
Received: from BN3PEPF00022BDB.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::9d) by BN8PR04CA0056.outlook.office365.com
 (2603:10b6:408:d4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:33:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BDB.mail.protection.outlook.com (10.167.248.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:22 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:17 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Sridevi Arvindekar
 <Sridevi.Arvindekar@amd.com>, Ilya Bakoulin <ilya.bakoulin@amd.com>, "Sridevi
 Arvindekar" <sridevi.arvindekar@amd.com>
Subject: [PATCH 13/17] drm/amd/display: Handle virtual link encoder
Date: Fri, 2 Oct 2026 15:32:36 -0400
Message-ID: <20261002193240.3441018-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BDB:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 2011e4b8-bd6a-4e6e-0897-08df20bc05bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: CsI5q8RVfxAKW5MjMjxCp3HygAsYWyU9gfMzA+V+hOPzyH2UZxRtnCz8K/XyDRrQZtTK+k+chRhGyWA54yTAXVhRv0VzcVgAPIjhbMHEo3eq4to/eAGvwIUdFZi6NQKZRJxQ6hKC79WaBWkAC9a3p+sRlW3jAT35Gtxv/PIOlyZ8QOAxW37EicPxo2G2crAdLMALMc3sGeW9mAJHgZmRp0OYNYJb3Ic2LDu5WsT51GHFHsOWNsLO7zQNlcP4yDISdiDsifujsTChXqUA0s4/RjIpQQZqkolUtqy5uVjkhxWnipO/bf8tqyJHxVFX25oABrillxI5IViGigB96aUQtf89vv8n7VhISNaif+4rcnAJ0BYJPUkKMqlf2dtlsqbw3Q1Z9SiphuGqj203pkIFeK8zMW+jAh+qF/2cRyGX8JXl9D5pZ+Rh/RPyXACzoB1ogk39v4+HVmafyLSe937+TlJ2S8ptBKtOTe5SCxVgdK2JRivHOrueBW2R1BxFlB5aHQKEVwar79/4PF+ORktH4G4lyiukZZ7MMv22HvJrMoJfZwHBAesXZd2E90FwgMdYjjrVtJja9Z7dF66ePWjRs30lS/LB4lOOvK8PJmukddaL3lRPqMTJSeIwm0oTjDafB42ShjwHUk73h5FyNdQFUZlMLcCybkx/2wYzHClA2GcBE0BpoHhg6WjBp42oenyAOXSz56R8K3beJQ+HMl16LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r7TlH0M5yOCDWTZwk1pCpJzrBp9ZcnxMjk1se0S8mbDzsn3ZxDeMofcAA+li1wWUjqiNFRwBtD41Azr05R5AMnRFatN4u4cDhxydRIBIUzhFLkrRU5IKmIg4qTQL/9m4lLbH/qQX8hJKUbM6vDa3X3pSwkUCEZnXcTuiyUioz9YgUBU/vKRvl2vt3sm3NPi1YAQ/E/49mSqHaN9WNDpxAozbv+PVfksZ8Rn49OJ9aG6mMxGfQF53yaD8PQiyxzynkOHa29hm2wOan6Xl+GJfchHXHVI+rqiK4pU2ArDeb0+m9F+R17CeUk35i/CmVCIwLvkCNSN8RQbQNu+QLkPDA7LAw2oWdF4M2Ce52niFQuXnOw+FGHaPZu3gS6uta+gbtMf8aGSdjdwfc2dytLamQQzbhCZZYTvJlKMEvGOyBAITSSzc4d6FB+gZr0KfZNkz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:23.1650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2011e4b8-bd6a-4e6e-0897-08df20bc05bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BDB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893
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

From: Sridevi Arvindekar <Sridevi.Arvindekar@amd.com>

[Why/How]
Fix check for virtual link encoder

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7e42790ad575..187486d978da 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3019,7 +3019,7 @@ static inline int find_fixed_dio_link_enc(const struct dc_link *link)
 {
 	/* virtual links own their link encoder directly and are never
 	 * registered into pool->link_encoders[]. */
-	if (link->connector_signal == SIGNAL_TYPE_VIRTUAL)
+	if (link->link_id.id == CONNECTOR_ID_VIRTUAL)
 		return -1;
 
 	/* the 8b10b dp phy can only use fixed link encoder */
-- 
2.34.1

