Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A10C71159
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E672410E47B;
	Tue, 17 Jun 2025 03:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hr5hk1Rp";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B6DE10E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttRpAykPgVMazG53n96OQXIMoHOanJp+xKQRdEBeeTqLqumBzwUp3JhW2afkY0H3yliJCVA84xLO4pw5fKEVGAuK9TfWqmM68xt1bWuf/FIzIJ/G6JRWxmGOZnvWCb37cdv6wlqFIveggSG/iEA4xTpVS55DLDLduoNSUKoPTuAZ4waCisQXDqT0EJpgdb/CBXdtGVVMi3UfNT6sf6Nw2m+uzfZpCTWgs2tVL+BWmPBfLzdQYjfFoAGNpKvXcg9ErnVQKlg4699awuectiAMuxMrW4sVquqxneQ7ZxIQkLgBw9Ynpd6FwHFXwSiNzn2rtyTqCYvJk87nVQdBdqpGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSZPzPbqmYuzdPpyOdARb28BtDpbMAwryVamBibBJWs=;
 b=AuKLfVaMN4vZxlvx/Iw/+wisB7UwmTe5TTnu63jomAuRqOnP6R2LVraA9Xm3VdZq6+zJ+TiXZ2uu3z/uuVgf8oddfVbQM3Nk7WcHqwpNGUyvDkS7GZhr4ob9LWe5ftr1WmdtGsmbEcsPbn+kzXm7kFaETQiXpsKsXR5VOXTYjNpjCC4X29zT6GCeaa3LA4nb9W4bhgAK0Eta305Y8DgXI/Vicr9Uuky/Skac33zDJ4loVBYcnXO3Rd3ERdSMs6eUk5mEEa9l7Z1D09D3yTz5Se4xMz6wEk28JrWE9L9nqhfovb6BhuD6F0X4U5ltPjb2wVaV5mnHIKmdLiN3HDMCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSZPzPbqmYuzdPpyOdARb28BtDpbMAwryVamBibBJWs=;
 b=hr5hk1RpaaQorO98MLkDw3yobV784IN2m8Nm018Hav7ykYEih0m4WXDl/lrqMK0mmdzTwRLBvXp0ivJvOjPI2HV3bEGDICEdD3lNixvy6BKM7e1uDze5gxkaFW3qZorfs+crNM2EzkjlT3EK7xKjYXpBmZNDT0z9TrJlJjZaiyw=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:37 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::e) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 17 Jun 2025 03:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/36] drm/amdgpu/sdma5: init engine reset mutex
Date: Mon, 16 Jun 2025 23:07:45 -0400
Message-ID: <20250617030815.5785-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6213f5-fb8e-4824-e34e-08ddad4c40ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l5/CkYQmr2OltFUtjUJiHXpJ24+P1CjEck1xBPZUd0GYtH+q6t5T4IY1BEh0?=
 =?us-ascii?Q?vPRi6OfecJ+20fRgJtggvIVWl07Fb5+qt2pOvoQI+i8BSQG/YKEhJ4t7D68J?=
 =?us-ascii?Q?/+0yzSapKiEYgGuVG2QXQRqA0LI96zYR3cInEzDMAYvMAJFpxsjDzawOiHAh?=
 =?us-ascii?Q?+gpZfu/C1v3zUB7+9lQhbhPADQTT+Mi5L0Qp3lODKVdQi8hf37oFef4NsxN0?=
 =?us-ascii?Q?9Ak4geB60Yr//v7PtToVFvyWIa2vzqFS7b/IAZbjsyHpXazihu6nZbLABs9/?=
 =?us-ascii?Q?uex9qVYmMLITjAIqf3g+ifeEKx4y/WXx1RE9xFcGXRqftDya78Viw1EdH9zA?=
 =?us-ascii?Q?eirYfqI7naIkBKcTcSV6E/45qkyE9fWIpHBCPtuPRQLhmCPDKCkB0EPOYVa8?=
 =?us-ascii?Q?sZow+YOYAuTrMRrS3i7qmRC8ANbXiiia9JMBiBkgYBg4+ScA6KgGPYytRwh8?=
 =?us-ascii?Q?/TmsKp31moIzwspHKvfaRTuef8GoxnhlSltbzGVqebf3hzX281B6AzXjRbl3?=
 =?us-ascii?Q?JsqNwz1A0vcZWBRxZJzHXfIDNdV2tnisKtww7dD0Nhsc0OOC28yfPuJzTcrj?=
 =?us-ascii?Q?FcAcs1MfUYzmD8OF+rlexR3OcybVVwM+tWeiiY50fT2pmCfteD/WN5kZIHAi?=
 =?us-ascii?Q?S6a9d9Ps+6tqRUZdkr152MykKpkotBVsCcDcF9pisRnaZEgqSc2YThnzktgK?=
 =?us-ascii?Q?9C5uyZYu2L+eLAVPRi8n5xyVuAWsSre4kkZBGIZRzMsVgKvBls88jsFzz/2B?=
 =?us-ascii?Q?XC3PGHHlAGrm+ewDjezmMmVVe3U5d+zxW3xCZrmRBp07dYNfN36HynLZaBWL?=
 =?us-ascii?Q?mC3jxJmaFUs5UM3o54yQ6RlPDxa4bDDTyIL9tQm28/N0AgNG5fubceLwqVfZ?=
 =?us-ascii?Q?o25RHNRRe3y6fsmnGUXBWy+3KDFXuFILL3dTZ9MuAGtuS2a3FYHXYbSEvZBW?=
 =?us-ascii?Q?jZGlWDQD2qmxCA7mgpwZTQU4mLwO5Z5unPbkcInRZBkI6dIPZRRunOq/7+EC?=
 =?us-ascii?Q?3jJVg7nlaX4Z3FZzxTXSmT2+o8aQ2w0bwBCvCVhQsHy8wGm/GbY6bDEPnGUj?=
 =?us-ascii?Q?yFkscCFL2Fm6fvMarfoLLEDKeDovUT7fk153OVTfEIiDM10rFoFfikSYs2K1?=
 =?us-ascii?Q?bJhQMexBHYSuJSnXHTw+CzTmTp/KnCmN63YIOFOxeBMe2szVMoi1imqk9QPs?=
 =?us-ascii?Q?OxNbppyhA4MX7SO0nclSiksNcGWLqwxg8d2ytgE+j8OF4csvyHbW/9QWq5+x?=
 =?us-ascii?Q?JFCeF+byrJTbg999wa5qgHQDXfKxAw72/H7Ns2rgd5zvaFkWSk72ThODAbzp?=
 =?us-ascii?Q?+/iCzm5SQNgYB7sj0pKQmSkRDxigM6JrXqGdY799eiJzcXYbLELN9Npm/nMV?=
 =?us-ascii?Q?2texFsGoZedm2LHeCGLgoJ2RGP8hAuFO/vhHNVc0aKmny0D6C0SlrVkgGYBm?=
 =?us-ascii?Q?Ctxau+Cmg/b+B5ch+vSeCckRo0qTmOC6uzXhvIRyzpJqpkB/atT2AAZG39PC?=
 =?us-ascii?Q?dRy3e3DmTYTaDWOq1pKO67Wglt1Xmhd633jD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:36.9400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6213f5-fb8e-4824-e34e-08ddad4c40ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
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

Missing the mutex init.

Fixes: e56d4bf57fab ("drm/amdgpu/: drm/amdgpu: Register the new sdma function pointers for sdma_v5_0")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 2d94aadc31149..37f4b5b4a098f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1399,6 +1399,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
+		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
 		adev->sdma.instance[i].funcs = &sdma_v5_0_sdma_funcs;
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
-- 
2.49.0

