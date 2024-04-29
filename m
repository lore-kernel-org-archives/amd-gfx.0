Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0579C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 07:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FB210E364;
	Mon, 29 Apr 2024 07:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y9cxDhl9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA78710EC3C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 07:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km4plU2b0AYm58oTdT/DA5czoUNOAbib83RhBLYXI7Q6Itvc6cu7tGPffMbRcVm2uAlBLlyzvOkjp1wJ4C1wBEzRULzNFZdyxz6Hz4FMSyobwqlCWkqOACPArDe2wOu2x4L13qucKL/+EXx10ZGvSwu+7h51jFHc0a0zN3fcrllCM61Cz5ItlCLkExOoDek9j89l9Agy8LoAHv0EtRMy2p5kaYL19AlkMwmcpFAp455PqUrtMnWHSBDtCAOmRk7oI8iop7EHkDgqemtyj/dazL5DfmQgUMNJvjinOgnzjCO0b5MgYne09B7vmRJlsdScjWBCKUYwWvn5qnuyZKfhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecM5txjqSK6aD2Y0isomtt9CZFzGjyNpJ0yC+7hus5A=;
 b=dl6d/xWsXEGWVNzy+oIfnijXPL2f4yzBQKTXZHymZZVj1DaMnqbkDkxEl4VN9EDxlXWhkioMeUfKaUUu7AWPW+xJrikASCt4KH9rxJ6nUhlhym3dIOB71w7zzp8IUnj0J7ZOX9/QyCna05NVFLFWFd6STIgGhGq3DkjtMBcRJLn/9RkjT6OyuiE2QGQ3PTJSlQ9BSNaBCb0rcS22mBKmu3/yELQjMoSO+JblnWxy0CU4gAgUWy600qNjgFD5ZUToGzaoXU2KO16q0PqdDU69TYRjDgw7DaAV6JXtHQGFkAfFdpGK9y5M+7ODEc/PBk/UEdYKrJ12asyUnq4qvU7KMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecM5txjqSK6aD2Y0isomtt9CZFzGjyNpJ0yC+7hus5A=;
 b=y9cxDhl9TmYM3yL32191I1hRG1ywspZWrdt2ZDdWRviKqf4es5uufhVD1fUEeV4lZscMpxJfrSqU5pjQIL4tzdmd2lAg1+fkIM41j4o4qlrZaXtxPLKAxLMo5ugsHuHVI8cDfkWx0mn2CO2QttfeEC2ybMJbU8Tw/xvkfgZ1FUc=
Received: from BN8PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:d4::22)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 07:58:50 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::16) by BN8PR04CA0048.outlook.office365.com
 (2603:10b6:408:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 07:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 07:58:50 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 02:58:48 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu/pm: Fix uninitialized variable
 agc_btc_response
Date: Mon, 29 Apr 2024 15:58:31 +0800
Message-ID: <20240429075832.168593-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcce5d2-9c0a-4287-64d8-08dc682234ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7e7Bnhf14uWa1H7ptRK/6BHIVOLL/f9k59k9H3IQ89PPQYA/gVsF2IZMkysj?=
 =?us-ascii?Q?8RRN7uBLwG1vLbLNqNl3YUyHCKCkH18X9VSQjgQDUSxJq6Pgok+GCu+8exsh?=
 =?us-ascii?Q?cDuaQSNjq9NNIgw63pqwIzeT4KwbrqJsC3ujt5e4ljzwAIlTOT+naCSu8RFI?=
 =?us-ascii?Q?iS2Htzr919Zn0GgOsP8SQ2+LJ96SqCsqM0RMP+qFj0I6VXUPXWHBR6yNUq14?=
 =?us-ascii?Q?1ImI9Sgar7YNedCXRcYpLD7UxBwVWWH3mmmRy47oMY4QTpdSNAM66lYAhkqG?=
 =?us-ascii?Q?+XNCga3Ssvilvhb0CXQA7feszAR63irFgItNZD2K33nAsepgplr25qexAVJw?=
 =?us-ascii?Q?hdOY+PaYfVuSG7jx3vq8ugWR10Afxh6WlYkGqDP/6eYiJAboS7p1IYClzAW8?=
 =?us-ascii?Q?s012up2RRd0WA0wELA5YCl+yrHWJEiE3ZNXGCZ5znjurMxHCVTOK1I0a1tCJ?=
 =?us-ascii?Q?j5WQ3RKThofqfz0aeVU+bzXsvgBiIWeC+WNc+nuBGV0JyDWCGrijq9QJf5Xl?=
 =?us-ascii?Q?A1PFVb2ySpKPxrv4UNbMqtlOK4QvQjou7NMv4CuPeZbCbso/INWgLKdVp51T?=
 =?us-ascii?Q?sdD+2S3J64GOFnP8tEYNE8TD9rQupUAH6iyxxAkEdB8giCVR5b5iPYKApBrw?=
 =?us-ascii?Q?5UQseJi+KolRyO9lo+HhO0zwHipruv22UliMZVwz7LVQM1nia5sxO+scDvaH?=
 =?us-ascii?Q?BJTC5RXzEljJ7QmCU33eWjt/f4Wv2EGZwGM02NlT+IbZNk/4aghE37xpMvMO?=
 =?us-ascii?Q?r12RuDOQviykKXKKe3kpdQlNcSR2QaBDBT40PYuEluxSqPGyvmDG4PTpmIM0?=
 =?us-ascii?Q?OZyAWc2aNB4775T1iuALZGqdrFwm1gLoMKZbFWYBWVe4EPrmYjv44slZocSZ?=
 =?us-ascii?Q?8chAa6dLJ3vCz4eUL/kWB0VjnLBv/9w5QyJt90N2PhTSFiQZH4oPqo57wJ83?=
 =?us-ascii?Q?w6wKJUcfp7LdUpjBJ4ZxX+aC7w2wYeXDP99AR5kStmKE6zEuvGjNPI+cO9yP?=
 =?us-ascii?Q?MqfWKhj0+ikCGVpGghzv71rrzLd2SeMWoHvtfeaukSI5Lcl3gWKTFjirDYgY?=
 =?us-ascii?Q?p/AGDGAtO879xpMQwiCOsj0/956RYo93pdDI6Erbi658X33c4fx/IptbY0cQ?=
 =?us-ascii?Q?1qYcwUDK19thGqvrtkTYlp2w1gWXXHiB00HxOwVee/78DON1zcaJ9gysB6bH?=
 =?us-ascii?Q?ysxUT+/teiPmHHUCBmcuz5G8z1d5/BeoX5jhhWSUSLI5jGxbFcE7u359Gr/w?=
 =?us-ascii?Q?jqKYGHpVzpIYHgKxAzXsiug7eYlyB6iG+Yn97bq2TNb2hu5whvxhgy8b8Ra1?=
 =?us-ascii?Q?4M5iGE8pq/JBSDcIwBO7G9wuSXag1DqfV0luOqx0JoF46B3E8j+ZiLS1rpaU?=
 =?us-ascii?Q?PgZYDuQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 07:58:50.1320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcce5d2-9c0a-4287-64d8-08dc682234ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
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

Assign an default value to agc_btc_response in failed case

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index b602059436a8..744232ba4af9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2350,15 +2350,20 @@ static int vega10_acg_enable(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 	uint32_t agc_btc_response;
+	int ret;
 
 	if (data->smu_features[GNLD_ACG].supported) {
 		if (0 == vega10_enable_smc_features(hwmgr, true,
 					data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_bitmap))
 			data->smu_features[GNLD_DPM_PREFETCHER].enabled = true;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_InitializeAcg, NULL);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_InitializeAcg, NULL);
+		if (ret)
+			return ret;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunAcgBtc, &agc_btc_response);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunAcgBtc, &agc_btc_response);
+		if (ret)
+			agc_btc_response = 0;
 
 		if (1 == agc_btc_response) {
 			if (1 == data->acg_loop_state)
-- 
2.34.1

