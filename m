Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61751D262B7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 03:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BEA10E688;
	Wed, 21 Jan 2026 03:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YnhD4NWS";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA31910E688
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 03:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuF1u+b/rZSgixYJOsnPNN+4yKCX5nlsb2a/+HgTqYVzILHVDa9C2/GU6CCS2nsxb2/ZHKwcz7Jg39cgQ8RoxRZvsjI0hQ7I+UPaW1hjnI/SBllLsQpsOivfvE+rT1nxL4t/dyd2BW6w4OmZ4yzRXMoE4iEAXRL/3sbnc+xmx97wDJXTboSYDorzQIY5b2EeEzTYh7uSosTrfDtz/wqkJKiG7VrtueQu2AQH8WrmhnsG2MCoZl2LVhr9wgdVwsnhy7VR5xhl+AMiKP97iNlJ3UBInDTp2WxY3XQb44kZd7XWoksO1/GjQgKLyOdsOig1uHz3l3R5nIcdAd9yAFf03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N21i0kJ/EkPoJL75fS/xcD0mp1i7huURWXoaBlqBfBo=;
 b=m56tNz0l9ZHnFXVzS3+4xGXsdR41JK9e4XNQldHQ56U3eCcVvvpsUPiitrOHiZR8rgEXYZIJWQBeuU7McNsxKJzt3J+UJ/yHnG9Mo7Z93YRsskN4n5z6f46kesmK2VwgYAqCMWEd93O+Rbxe8067L/hGttYDaF+ca7ZRu2RzebNVz0dGaPaBkkrX/IN+ajhSMb5sNsAToalw95DtEEcVn4SbSDLHwi0Dwl6ShU8EGv8JRMmw2jP03Hb69HkqqUp979zpH7y1XhV3RpXRZsuOgHDpRPLEmRX0J0UIU3TvBOMNgMH3Sj64Y85kDuL3asG6RrWf7Ql8F95bbmy1h7QTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N21i0kJ/EkPoJL75fS/xcD0mp1i7huURWXoaBlqBfBo=;
 b=YnhD4NWSi2Kdw66oxlPXsOXI+rI0Qo6iR/QaM1AqOhRPxUifzpJwIDRgEfeveLbs2z51cgtLL+SHkevWlmdkZKOekGXTeUKYqs1qUrTzc3ruwuQZjZxRUcZA4hgK4d8NJr8PvkpG7yR9F2qz9DSgDlXsofWsviQ1RC7gMktpQN4=
Received: from SN7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::13)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:01:29 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::fd) by SN7P220CA0008.outlook.office365.com
 (2603:10b6:806:123::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 03:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 03:01:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 20 Jan
 2026 21:01:29 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Jan
 2026 21:01:29 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 20 Jan 2026 19:01:28 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 06/10] drm/amdgpu/cs: return -ETIME for guilty contexts
Date: Tue, 20 Jan 2026 22:00:53 -0500
Message-ID: <20260121030057.1683102-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121030057.1683102-1-alexander.deucher@amd.com>
References: <20260121030057.1683102-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d38911e-0bff-497f-3f54-08de58996012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7hpndfv5d/b81Xd80ZhdYw/iyDqgdkVlRWOvSJx1++HU0ejqCzn9lijAHpE6?=
 =?us-ascii?Q?/+5uHSIP9AvJg23F6/z5uG7jL9lYq9GBrvNTiEgQ9emJgb+bxmy9OvPPFwiU?=
 =?us-ascii?Q?UlbgL9cpMImF6ILiZ/5lNp4axxP2D934piuKzhwLwR2gh96rijZTYlWu+dr6?=
 =?us-ascii?Q?01/DXQ7WQ5KSRehD9BImN2MLeqjn/m1Dizd5Ny8Av/Z+UulEHiyWZXn4en9Y?=
 =?us-ascii?Q?PlHp5PDSOLLr9ZSFAXOK5eJsheaFCOUPjdgOmQVdwlBjjme/OngDLJLfQ5ip?=
 =?us-ascii?Q?Oh5NCDoP3UA1d/SsLGCKNJXrt3KN5QDdOEfdTEZRAYN4OfFSLIpBYhn7WN8a?=
 =?us-ascii?Q?lE/P7bgIdPsYamxHDTMHVeF6MVXVYmDoiUOsDC5l/kF/2PQ6nuUugKz+qvW+?=
 =?us-ascii?Q?SJ2m3YFkCtCJ3vOYYkxhKhrVpngelK8A4jASeinTfbnVTbRCMnKI9WIG7Dxj?=
 =?us-ascii?Q?4/W+uZkBmuDYzAn0kifDPaxR39mtf7M56nZZunXFSWcQXQZ6emj3P4aDnemr?=
 =?us-ascii?Q?1LGwyqb31353GkXbjwK+tPBcGU77pxrEo+ukNEHpdHW8cZdmVkNhUv6dZY47?=
 =?us-ascii?Q?CMbsar0V8deHLmHP8PHaQGY8iiVZkygBy69aC4GWhTQTNnMieXS+sek5aHHz?=
 =?us-ascii?Q?+rIn1+GRQIvuips/jdMRThdffsL5A1Zj2Vq8ZD41OgwSgzIgwoz5vpFIO3I+?=
 =?us-ascii?Q?qTv4128NAlXWBzzxBFg3fuMDe6YNrH8T9QH8gTbJ7G1F4+C8hrRaTjImYjLD?=
 =?us-ascii?Q?95dp3vbmHfGikQfopYa1D5f74zhYSpTLlXH9uoQn5Ym+GD87mcKL/2N1kDS7?=
 =?us-ascii?Q?RUnfG7AZ8d5YbcIywk2I5KqgGwKq6uBI/haBHIBLg+D/tysNxi7mAvL1x96W?=
 =?us-ascii?Q?8AyCZl6TgAPxFpBOs4Rt1ZnMlTHDlE/xEFXwROvx4FyBmhSF34dhgKDeoRPu?=
 =?us-ascii?Q?uZekSC3ULC39AyQZhW2mUPzDotZUPNnAmcOozFrVijXhGY2GzjKNBwvlZKOk?=
 =?us-ascii?Q?g6Dx/HqQ/JDrKINO5C+WxebHtddPehcPTMMSOUtJorCiUCcenR1mlWcs+DxD?=
 =?us-ascii?Q?bRUNY8JgvB6upeuHdNNBQo+e6za6odLjQEMnbJ9MTya/XNbVnl5RHwgFXKVd?=
 =?us-ascii?Q?qeVfJfNSdp1rA+CMEcEMyeXI4XAJznpQpM5MWnK4Q2yFfSdOCrYNZDO9+8/Y?=
 =?us-ascii?Q?VDx3zZ2MOQsoixxOveyxpnmX4H9nYbZhJXSKrJcspOUwf71U5nwNl6QMR8Ey?=
 =?us-ascii?Q?pgdgDMxU52PV40Qd0UByLjzctEkhgwpGa7ki0LkeFb2qVwfMwenB+1UhmLbV?=
 =?us-ascii?Q?GxAAlzJ87Q9C4N83FR8iyeoBv7jJgBjPUUnr3AsZe3uQDggvIiqOdbwfAK/C?=
 =?us-ascii?Q?q3pieWw2dV9KaHxeKNXRQcb713L8VNR73C5G3sI759wLW8YOh/AzeoFq/Y6v?=
 =?us-ascii?Q?/PsVlvN/EwwKg0ZybQ/Xho+5Qb8wgGyJ4CkTl6oS6pczS8hcDGbsQvXu85Jc?=
 =?us-ascii?Q?R+uXK/Rf3EJeFfQkd+vsd8ofNZWhpkgm0jnRPGodd99Jct4oZZ5ZBAI4pADB?=
 =?us-ascii?Q?RMt1A+29HMOGP95t5/GS/W2hnDdFPdF3tUj/1CXTYP4IZ4lXCigmZpNL7B88?=
 =?us-ascii?Q?15IZuvFVYQnnpQtQeJL7N15nf45U1GsMG5MqKlvzGV+s8nbN4Uqy7N8Zv8of?=
 =?us-ascii?Q?GfekXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:01:29.7576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d38911e-0bff-497f-3f54-08de58996012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
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

Return -ETIME rather than -ECANCELED for guilty contexts.
Userspace only considers contexts to be guilty if they
return -ETIME.  Returning -ECANCELED means the context was
innocent.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 4d53d9cb8490d..3112a7c5be81f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -62,7 +62,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 
 	if (atomic_read(&p->ctx->guilty)) {
 		amdgpu_ctx_put(p->ctx);
-		return -ECANCELED;
+		return -ETIME;
 	}
 
 	amdgpu_sync_create(&p->sync);
-- 
2.52.0

