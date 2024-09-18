Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6CCCCD1A0
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Sep 2024 13:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA2010E5A9;
	Wed, 18 Sep 2024 13:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ViTzmlE5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132F310E5A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Sep 2024 13:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEJ/YnZmAM+2hHVh0r4cFZluOW1ZA5CfufJ9lDb/steYICJ6UhMcTrv1pC120rAt924WLaGc29QPCGRAc3ROFQQv2jtNC/VJIzezL2JxW19j6jz7LvGczo/zhxpFtDPsUMr/8UAmx03Y+Bbo7iGYvWfwZJgCYIa3Ue7kXqJWe6YG+TRgTVwUePBpqarZ1KOc2lWiGXruu4wQk+DlfneLY7hjkDT1vPz1+HGbnZL99SEvbcD/WYyLFuYs1tGlEfZOOJU4cH1da9LPCHBmsME4MwEunXruXtCe7YHaXShq1W3KVLfU0simnUhv0o8LulpzKGAfItLBQ1Jz5dDrPl05Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a92fi654iANgnDcvwEUkRbKnaWg/51r6OpIzDA8Zde0=;
 b=srCCHe0yimsMgEhrtF2aDhvBizsVWY6jgcKy7p2o73meQzrogdHh+v+a8N1hyBFc7qeto4UHo+cTIUTDaxyMc+VBjKVCt/86i333lb1AfZgJOxhU7tJB0uDkFnlnA93h1jT23tFg3uie5kz24I0YCjwbB7r/IsKRWY1ZKUFtMHdGiElzefPyVLro7OnUjBjd1G8XYdF2jWt4bMn6IBf+JjK73cmBbwAdeF5tsjjTLH7z5dDnvhCkfRpmJC0rqt2jaHn4u1ICAwjpoqkXbarTI+MX6fn4IpJP1ptuuOgy3WbW5yrpNkSBqrRwUlFX5rUv0ulF9pKuFSHnDz6fLKj9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a92fi654iANgnDcvwEUkRbKnaWg/51r6OpIzDA8Zde0=;
 b=ViTzmlE52Ql30p2UKcJcFSXdeDGMi8WDLNBmAGZBap2ZRtbAtwZRB4jUFfdI5sb58Pey4OuT8flDi3Pl7G0qindOiKfMxuivT7raBpN9QNm1uU3dcaz2jbFjjhQ5+i5Z/y4D8tKtat1PW2nAAa36MMji63LCC/fTDwIvsVMDIQo=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 13:40:09 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::23) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 13:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 13:40:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 08:40:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes11: reduce timeout
Date: Wed, 18 Sep 2024 09:39:52 -0400
Message-ID: <20240918133953.3786248-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfa5419-04b6-42d4-6648-08dcd7e769b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3OPcVLYfxUDO5+G/W8qZ6zg2Flvgb2w1FONRQapJ0Gv5RwWxtgHaBqNx2WS5?=
 =?us-ascii?Q?qn9IfeVhDXb7md4utj3jMEzreR5jAGqfDBev4BXwL9HiXhh/yyp/62gFpCHq?=
 =?us-ascii?Q?rryUFuqRsh48Kdwhcw8hQ4erBX7OhPRKiV6zMLBPnT707kE9GKX0wXNv2I4s?=
 =?us-ascii?Q?rsG7nUqBmEtScbNtFh0/1AxYU33Kr+3YDlMoxxqz+5XKcx8BfUZWLZpykE6t?=
 =?us-ascii?Q?d8hcNBj70MN1DS+aG+pIpyduD9XNEsZtBEZiYFXnAJce2kzHXBLsm9+0bVh1?=
 =?us-ascii?Q?tCt+aa1N0aCpOFTlDv+cdBJXnHor8yQ97+tBDLIzl1I185vnOpeIVhHjjstd?=
 =?us-ascii?Q?nIn5TTTvLiWhjLQHejMo5Ig2DhMrxWF1slHy/6DPAXDoAqsLj30xqW+tfex3?=
 =?us-ascii?Q?5NIbbBkgedI4ZYbm4TGqnzMG8rOMDWOaL0KPWpQZF66k6PVxSoyM+FrDQcm2?=
 =?us-ascii?Q?bO31Xzpl8l0H90WozF3wrYMuelWaRV7AA8e9B9Dhy3KtBnCChDQoNj5+0s8g?=
 =?us-ascii?Q?jDP4uwfnoVVzYmVRFH/N0R9gmVVq8lpHtc8hq6F9wt+JouLLY6oI7JRdtAKp?=
 =?us-ascii?Q?FV5t1fw5NNjZQDsZzcNlhirT3fRsOWWptJo3amdcZcMF93sQpgvgK5bzLokJ?=
 =?us-ascii?Q?dz2wery1ZYtTUOC7q2/wR18z/ByX8oTkiSaXNtP0Yzom6fx+i4TCQVd6oRfV?=
 =?us-ascii?Q?DAyczMyD5GQzdvg9S5jwFQdrLq9JjaYhLUCzfLtZ8f2vy6xX8zZjJwDVrl4i?=
 =?us-ascii?Q?mcaGnQeW0G/dIN4p/Va0ZxwBP0km1DcPo3UrLV6wzFL9mu8H2g88Lo8l/Zlt?=
 =?us-ascii?Q?azwXcTVWHwBa32g1pc+3B9y09riMjcFLOrP9N82rBIKydzwwieXTRPPppMq4?=
 =?us-ascii?Q?7UTFR88mMhmLhWzETm70mS0sCHIIoNCQBR+jYadlfbr9MTfye/zp0Xxayd/v?=
 =?us-ascii?Q?nKrUB/lFiBGy2bHdtnkkYDOIqT/UOHq5jjzGtrQSiovBglQ4g019xK7E6rNG?=
 =?us-ascii?Q?riZmv4esJEfheeso9d64hMyGGzlMrwY6nyDwZH63H6ToYUbm/QMbQS4JROw0?=
 =?us-ascii?Q?eJvwtHdr8rsAYlokmMQsdWwvNY38luLXavMSKMB+2gmiw7Wq0BI3ErIQ3PoI?=
 =?us-ascii?Q?1s03zSJ62JU/Gcyb6h5/PrGG/XYBByfBDzRiY0iM6lUJ6q+555OriUEx2vhf?=
 =?us-ascii?Q?ffJsCUJu10B/tQg3lNlF+ynrKXSvlTabYDx3EAYgoRaj4fFy07EtNoCN2k5L?=
 =?us-ascii?Q?U0fD+FgvJ6qt2r/DV7Xj/vwJcP0g1Nfr20WJCICvhe9ki4p0gCws6Z9Hrpv8?=
 =?us-ascii?Q?WETBFgsw7XKCJ3DCPYeeTSNIp58+ki4xP1WudY3BjRlLkky03IO4CDp9tah2?=
 =?us-ascii?Q?4OgCe1iLylpCv1NS63b+3hIXYClN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 13:40:09.0186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfa5419-04b6-42d4-6648-08dcd7e769b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
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

The firmware timeout is 2s.  Reduce the driver timeout to
2.1 seconds to avoid back pressure on queue submissions.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/3627
Fixes: f7c161a4c250 ("drm/amdgpu: increase mes submission timeout")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 3c923719e32d3..e2b3f859a1c05 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -161,7 +161,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 						    int api_status_off)
 {
 	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
-	signed long timeout = 3000000; /* 3000 ms */
+	signed long timeout = 2100000; /* 2100 ms */
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring[0];
 	struct MES_API_STATUS *api_status;
-- 
2.46.0

