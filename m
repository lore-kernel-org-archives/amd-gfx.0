Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FF8C87FD1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A9610E439;
	Mon,  4 Aug 2025 11:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zRIF6At4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D69B10E437
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvY3sRBbh3p9hs2CN1BbidHwh5sSourEW8uryIVRie53Cmlgm69eHcgNWZy4HBH5MQmMEuVChMZCEUE67m00HrrBUH96zI7nXhzZUVPNiFXjij4tJP68Kqs5L9NtORpzRs48inwib5a/nvH4yabA0e1Myd3Xu5tBFqRN1WmCVpBGSKNdPK5O9Qpz35Y4UzJdWvh0jz9WZv3HlpyfnOiikOkejX0/54AUGesnb73v/mH5Ol9MD806Z2HwriWPVsoU3gyD8KZzwBK/XOrY66Gr3Qt69krOgh6CdtAqSldk/nl8aMfLIW1PRpNCB532/qmJsX8uqJR92KpHCWPLuSiknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsPYyOOLiuRKPU4f9KaxaSZGhtV2C7+yeD6eiHnsTJg=;
 b=ANsp3OWtp54tGxwDnB2c8pXdCA5cgj5khix+HqvHM1SfH/i7hGEhEA2C7wGuMHUmlwlYPfb0HGIkg8DWgphLyJ+88tXsfdpScJ1GqqG6P6AhvKAJSFf2fPv6Sk7+nsNWVlGN0YwOlbtmZrCZr4Z515gQH5okA9wQzAEbBJXkDrU62YWEN73jHaCF5hJTHeTQob0hPHRX3e4xg8QhyfxP/Oz1MRatVxUSszVN5jbkR2R27baqiIvU1/e9ksp8z7vDjc6yD3SuSO5DqAYqgP/H+BxE04nChjhgjh8fK7R8OuKBR3yj15T+tKHyltbBgHybaaIy1bZ3HCLGBVoJSCL6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsPYyOOLiuRKPU4f9KaxaSZGhtV2C7+yeD6eiHnsTJg=;
 b=zRIF6At4yFxqqSlKhJIU7Owzd8Ee6HrGRyXqRx5Jp0wS9FjVC06s54PXSgsNDsTKNj6WTk1FEadBQZK7hd6saoF33e0tp799KN6PA7LS8L4IwEdrYK7oJENa4KgwISmf0wOtdpiC1FeaLtLWe7k4xTVE6aKR++hJypZ91sUzXww=
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 11:06:34 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::71) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8 via Frontend Transport; Mon, 4
 Aug 2025 11:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:33 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:31 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 03/13] amdkfd: find_process_by_mm always return the primary
 context
Date: Mon, 4 Aug 2025 19:05:40 +0800
Message-ID: <20250804110550.261311-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250804110550.261311-1-lingshan.zhu@amd.com>
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: e8645a03-8c61-4664-7c01-08ddd346f90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h00LupZWgxpQroEskUAfQhh9XMCcWY3KI5La9UC0uOtQaYglcoAT7d5lztdX?=
 =?us-ascii?Q?GSoAXEfoHiCeHFLcKCz62wVM41D2JtxRqMxFtUiv8yAfxjrhW7A6+tgCj/YF?=
 =?us-ascii?Q?llG2bu2HAid0EiC46sGwfdKMEW2f+0cB4y8NR405M/zISi4c4ajA+mJDvADA?=
 =?us-ascii?Q?Mijl8QCO9WfthSchObYxbzeoyUcm7Bmg8EMpWq+Xb/89JjpZFaC3QHNN7jV5?=
 =?us-ascii?Q?H8Qvxf6Pm/TEgl9bb/bTBuiheXSqdU439FFxWhQLq69NE4B+djvwxfrX8CFK?=
 =?us-ascii?Q?ZNvh5ozAu506sZjE5XIpQGZXe/zxB0SueT84AfUTUy1eB3/V9gMbHLP3N7m3?=
 =?us-ascii?Q?UmcZDfRbkv8klJVg2AiVWGHnuMt1kw6F9zNZ+Od48pMQApNZY6DbKPzEd524?=
 =?us-ascii?Q?oW1Px56LSzZE/caFD6HbRk9attlDoA6sG7Wui3IoEmDoIJdKzEpL0VypT/uJ?=
 =?us-ascii?Q?Xo73Nw9u/rm0DMtaEoe2Jfr4ypfI7YqskXdxae/dsJWkHACSjQDZAP4/rcaP?=
 =?us-ascii?Q?d8c7yw9mtYDQp3iCJvQWnKfew3H/T84hVBMemWAAkezpIAzwYZvd/dJegQ4B?=
 =?us-ascii?Q?2koK6OTGBNSA1JWdjlWcdX3kmH17w+yipxzoOyURr2WInD2RchZJcRd7wbBo?=
 =?us-ascii?Q?VnNbq5zmloHNj2gAxzhM3yPEJYVClYNNOS0LCqrqRmF5ouY71WC2iz+TPnj2?=
 =?us-ascii?Q?0MesCzDJfcRyWjbBs4BUAm1DVXV0fjchB2ViXFZSxiuiYYBExV/wQWSdFuuS?=
 =?us-ascii?Q?YvafTY/6e+AMLbGUxj8lVu8ZOzdY2sA/I70Po+4QaRtCEnpO5AuHrQnE+fae?=
 =?us-ascii?Q?QWqRXAFfLw2Ey6dkBYgOXADYdr/M2XcoTcu9CbCsogGsirZWKQpMZ9RNJMEC?=
 =?us-ascii?Q?Fty+jeo433u4kcXegnaAljMT42SLl9VL7RCuDW/lXEgJZRBBLF1LiPOPn/4s?=
 =?us-ascii?Q?TE27nZ/+W0iwiE8lm1S4129y9cpKj5dVAGWi60FFv4T+waalrhB2B9Pz3hzQ?=
 =?us-ascii?Q?k8+SXOLiH1OdDXCzZ9AFRuDwzSM7fcLys6p9+TiGsOK74a5YnTZFIe0Qi3JF?=
 =?us-ascii?Q?xcP0uRNs+IDdSDxMXjZsbW2cndoI1ASqh9rDMO480gQ93al6/nlHjImvNDHS?=
 =?us-ascii?Q?Rpo22n3S6UjVfSya3P9i4+rPe/jJkVqN+PdNRK9JVXm5pwgTtJwJjZxcTv8a?=
 =?us-ascii?Q?zi7ej59hZ06T8vv26dXsWoGb1kcsDW1kY03prp6H4ZS7sb+i4Xh3JerzUTGZ?=
 =?us-ascii?Q?oe6yobrinobrrfMeYYJHWYZZuWlHNjtCc8wyIOiYC8Ut6tZvq6hXOiHa6nWV?=
 =?us-ascii?Q?B1pv4aseyBH/YNiL8IFA/D/06j/vkq97P0KBO/2RJL+hjo8Gnz09is6UHKG6?=
 =?us-ascii?Q?OHTRHOYG7DdR0kiPl0pZhBiaFQFsKRWfQ9J4TR8fbq9zFGrxO+AWKeW7MdS0?=
 =?us-ascii?Q?lSapfRMHCZOxuMV2tl3B1ISc2t2o2fVHDCYAqw47AQrzsabFteUuDZuxjEoL?=
 =?us-ascii?Q?xBCEJtkrVbd9+oF6IoQOlHyoVl63ZM9O9pbJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:33.4770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8645a03-8c61-4664-7c01-08ddd346f90e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882
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

Up until this commit, the kfd multiple contexts feature has
not been fully implemented in mainline kernel yet.

For backawrd compatibility, not break existing use cases,
this commit changes function find_process_by_mm, let it
always return the primary kfd_process.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 762e306d85db..88421e57a072 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -935,7 +935,7 @@ static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 
 	hash_for_each_possible_rcu(kfd_processes_table, process,
 					kfd_processes, (uintptr_t)mm)
-		if (process->mm == mm)
+		if (process->mm == mm && process->primary)
 			return process;
 
 	return NULL;
-- 
2.47.1

