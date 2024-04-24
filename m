Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13D7C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 02:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 528C811292B;
	Wed, 24 Apr 2024 02:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kZ+0X2xV";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D799E11292B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 02:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJ91YykECw2M5rl1Cl7dHwGSyyZ9Iz+6gpDBhkltRyOn+HAX5I98nRr/OQwW415YBusiALNXNEE3EMiPInULn8CO2UKfjVFUm9Tfzsemf7vWCjzjzSe494dEgL7/s9zveEIzalL95OcbNhSpGEMlTAyKD9xqXyDspQY6uIFp/ie1aq1sOdH9pcX21tl6AWejslzi0G7hLA79WK+QZe/ldI8LxBY5AYOvLQE9WwR+NUncJaOADqqdNhebBTnwnw7lcyIj2E8wZwWSsIPJrF5zSw3IXfgqSu5lOHaQl9OXufzxd1oSWt2v4KOjXuaEUBYDrXpWblHODeaaoeZCN34lBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXJlJzmDUbVFI3GqLph/ARHH7G1ZZCZp8skqYnptObw=;
 b=U/Co2scv75oagGtGnltvGFdPL242KWAYDsi3qQdWVXnapwkOlujc5C2xAviuawAvs+59bR3YsgyV/Cb9DT+U2GDdbZNArDYA65Vxbfb+H5X6ftdNEwaQBMXrif/JCKwXjiiyF1nacdMyip0dV01RUn1Jn8X+TSuoxQxVAF3tDy8SR/Sn05KWev69kWcBCTNsy7WxO+p91ZonrERbCS4+PpIlIaxUEC4B1CuC5AVCnu3f99apd5ZUPldfialt9jVJsogs3lbk7BICoSOYxix2BogJs8mR17FofiaCQI95Jo0Cv9pLzqQs3FK6ulOVnPG1/f1LI5w3AZ9vMQ+KaOzUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXJlJzmDUbVFI3GqLph/ARHH7G1ZZCZp8skqYnptObw=;
 b=kZ+0X2xVMbnYrXbaM9UEMoRcKyu1DL+ADOjVP4hg9cc8486aE3zVXgc/Yv8JHlUEmF4V3xrJCp/ryAf6QW2orBZ/TuIjYsRHay/SMjjg789HVe1Emuea7ECwBhlTYs42ItrWLcp2YhONtl52ZFAwE+8Xx5CmvQQv8+LiALLncpQ=
Received: from BL1PR13CA0137.namprd13.prod.outlook.com (2603:10b6:208:2bb::22)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 02:49:42 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:2bb:cafe::57) by BL1PR13CA0137.outlook.office365.com
 (2603:10b6:208:2bb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 02:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 24 Apr 2024 02:49:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 21:49:41 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 21:49:34 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <tim.huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/4] Initialize the last_jump_jiffies in atom_exec_context
 before it used
Date: Wed, 24 Apr 2024 10:49:34 +0800
Message-ID: <20240424024934.727489-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: b238ac52-6e4c-4a99-0454-08dc64093100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2Klkj9iFQ3bnDJn4YGZ6tRyFL4j8+Jq6pn0ewwx83olurOsDzCMYbUbyqZYr?=
 =?us-ascii?Q?jufcGbJt2PAGhzJ5hwpjGu1ck1AEx8ZSk0cCCzPCotgiNYx5Szx/KY3FBDcz?=
 =?us-ascii?Q?+TCayrlr/IBj5d6UnADJduM5t4QY33+Ev4Pci44f2zeov73986GvFbDNSKqQ?=
 =?us-ascii?Q?1EaL47AiEnWgw0X3TNqlxP0E5m6R3e36J1DgEsYMuZCGeDkXgsNk2F44osVw?=
 =?us-ascii?Q?USgkmUpuNuO8Hk8Cl9br75u2H79CfS8lQb2mBUhbv/uvcSFtl0WL9AosT3Vk?=
 =?us-ascii?Q?4YtT3KrRWHH6aXEKtCQ1jYagzJkJP2mL0S1DoplzGFC531p8bvL+0MI1Tcpo?=
 =?us-ascii?Q?Z9l5K7XAqoGwBLNJawul1K3sr1B3J3/YQ2FAQqsza6hNyJxOzDQ/BT7kwxwW?=
 =?us-ascii?Q?UPedVht+IgIsr08AWxYqlX3XH4Nt/XGO8tiNB8X9SykZusDWEe5bA/n2B+TL?=
 =?us-ascii?Q?Ep3motcAT3N3TKIvoPpnKj/e8Grcor2d+DLWkg6YJqk8sQNMGRa8oROPh3d+?=
 =?us-ascii?Q?ryBwwF6UekIWLEXAM5lNEjVSq2rtKAtmBySpN0AVjAs82RIM+5U4et06AGI/?=
 =?us-ascii?Q?VEXYTC/jAg6Vt34e7lVg7nAMljpg+eEYTEhT0hd60bVXPt2nLul4RSnfGqfZ?=
 =?us-ascii?Q?k/AhKO8+02cR9lMGAnONr8bGM9U5S4Sb8qvLKlNnrImD3vZse0lo8Dxk7vZT?=
 =?us-ascii?Q?hXYQltrM/7uV2SovbGDvo4evzpKvWqrjV9eXfndKDKxXtqalgWhTH5f4KjOY?=
 =?us-ascii?Q?FOi6bUovsUeKsqoxNDxzPhPABRIHZfghpPKhBjs6BYVcu3fLSjCUejiQI2go?=
 =?us-ascii?Q?lT7covWOgOs/m59kI/gGaDtgDYSIyDyo2Rn/lnb4MAsKv68shhnnHb3X6uMi?=
 =?us-ascii?Q?jyTF4TV5LMgwdwv8ehKXepbBPU5VGC+2l9Xe0dXge3RGHixvOEPeErzxFid2?=
 =?us-ascii?Q?HFQWv7VRdnFw84f576swT3mnhu2Bx7bN5vj6HzUgJqOHeayFrAQFd+S+O2MG?=
 =?us-ascii?Q?EoE5Iskn+J1AXOIVVu/bEL0I0ce6/YoPDHxNxEJ1TvYRQJ7hcZ6VgQkED0rj?=
 =?us-ascii?Q?eNVPZVwMX1YjnfXtYyFZB84gTZk1kReUQf43AXNS/aa33Rst7uss6L7XrhDO?=
 =?us-ascii?Q?H73gikeYjEySmPvAopQOJUxhKDTd2sRH5f/Wp+BhEZ7O3Zswj6OsdZ138QGa?=
 =?us-ascii?Q?JVuDFrGe4cjOyJ/ubZotpDr1set+vFmxTJAMwN4Cqw+V2rU9TzpU9xd2ROXJ?=
 =?us-ascii?Q?CLGkkU2TmXIYpz9Sjq8GPoz6GSquGkTUavRbS17kWsUQ59utZmvogFb5GrA8?=
 =?us-ascii?Q?6A9Q7V5NIBG2BYlGK54mKPfi7G0b+5+1iLfoYp2nr9MrWt2Vo7Wl6f2hqC2S?=
 =?us-ascii?Q?+n7ky09pAOPyriSGOcWzSmqsb5Fn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 02:49:41.8867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b238ac52-6e4c-4a99-0454-08dc64093100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483
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

From: Jesse Zhang <jesse.zhang@amd.com>

The parameter "last_jump_jiffies" should be initialized before being used in the function atom_op_jump.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 72362df352f6..d552e013354c 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1243,6 +1243,7 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	ectx.ps_size = params_size;
 	ectx.abort = false;
 	ectx.last_jump = 0;
+	ectx.last_jump_jiffies = 0;
 	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
 		ectx.ws_size = ws;
-- 
2.25.1

