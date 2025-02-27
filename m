Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B63C282C1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 17:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB3310EB51;
	Thu, 27 Feb 2025 17:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lVA1WyvM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BBDB10EB51
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 17:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7fYmkR/FXF9tcVgFF50AJ0nEfSawvV2zA94464faDlIXBgT54BX/VOasHYZ+2VadHl4VuJFhNP0eL9HotUNeygRAMmrXYvzBYmVBHNOn35Y4HAuy24ZI+BNa9k2jepWKLT8Pne96Dxr/8OKC0nM2eCK/1xheNwqLT6//UEn0SeUv40rMqgrLuuEHa8Xq4z+qA3HqnIGd1j28B8HEUTYzax4zCra7R6fD09xdZVa9si+QOCJsI33WWBiLFC9SXtyeeZVAGR7TCJV+GbQel2NoufjVitQ8V6SbBsQRckvzsS39ul9q2RmUWNXFrH6RQQncwyvwuVpWUh303KFBeMJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WiI2QXPb/GeU5PpE4uLhUp0CA4YL9VHPcPBy8trfRc=;
 b=MVPUHpLM2LVv64CbaYhJQen1AZyNb3Z49cxN9UpEw4C9DMaQUhcxOOULerwCsinXAzy76aqITxZF5x/VR7+7SJTdCYaustoh5ytVhGqmRWnk+6EKEoLgbiC8uFB5yk6U8acJwrnguY2Aq5jyZvvGrY9fRaYiIpbb6e73ewMSfD5Ct9U0wtHdHuOo7Xh0y9aRHFraQ0G6808SwRDEJUevtekD5VQW6vuZzIpqyeP6ReebVpT/qxfkxfSQVCStZY9r3eC74J/La8O5ebtL4Ex8pwapWMVhS9ziOTFfqsTh/2RHVhuFHxyd6Y2k/4DotPLMafML/QWmv1ss+Vc1/GNdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WiI2QXPb/GeU5PpE4uLhUp0CA4YL9VHPcPBy8trfRc=;
 b=lVA1WyvMkcjFOY0hhmGzUmc/xV88ZIB7xjachjcYYcGOjiZOE0UJFKchvJDRi/r3agz0Cn9L8pJk+5Ywig6PXZhMRaws4frGRAQuuNsUToxG+5OaA5ujMpjTHfpZ4C4KHkMGEwK5aZ9j1SAfdleuRMkeyqWOq5C043H5kVKKrTM=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 17:31:32 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::d9) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Thu,
 27 Feb 2025 17:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 17:31:32 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 11:30:00 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: remove unused debug gws support status variable
Date: Thu, 27 Feb 2025 12:29:43 -0500
Message-ID: <20250227172943.3160167-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 73895c35-60ec-4a8b-edea-08dd5754939e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jgBalQwaLrjz8a4P9nb2aiz7FR1UOHpQu2tGBEU8X9mgZMds+k+8NuEEWGgm?=
 =?us-ascii?Q?rqGo01zt6js5fOHrFI6wGckYMpIj0UP4Rg53Bc6JdIAjeKl1SHx9Q+rB6//Y?=
 =?us-ascii?Q?fycSjMrC8APjBQEfaFSSnBkoFgwKyufICpY1KP/md7zAmcgfPpizvcyRYS4u?=
 =?us-ascii?Q?yEj3rGuWACwIM+rLilulaQescTu/JMLWLsP9VAuO7/e/HmsWcLnfPou1SpfL?=
 =?us-ascii?Q?Xd51US3EahfiWDiiP82ocgjLfCYmqKEvxOybXq8pP7vxvP9gahNshh8s8iU4?=
 =?us-ascii?Q?vY6jyTiTwW3dVngEqDKiNF/HU3Jv1ck1qMd2+VjlPxy6POA03W7x8v61azdX?=
 =?us-ascii?Q?0jkQ/yfFK0QmTOJydmHbw2Zc3M0DXEgv6Y/mCwykk3MNCQrl57Gzlfo0PnOk?=
 =?us-ascii?Q?Cu2aOH3oqHbRMQgga0icE6LnTVnATA+q8BFSm1IzbgRAQZ+YqlsaXPpxWS7M?=
 =?us-ascii?Q?uP4qSYMTwfINhImYZKcFOK3baWVPnnILOLvFKZBy+NZPMPRB3/QnUxltrBb2?=
 =?us-ascii?Q?kdGVZGieTznaJqtHJULJB8CzsA17UzWJTBtmzKm6okzz+f56TyVdk332ZEMG?=
 =?us-ascii?Q?z5Lrvp391TF89qRwou9J7KENEG+wmbfxW6i7aw/ghMvc7Ym+0rEoMsUJ+1oX?=
 =?us-ascii?Q?vzil9iwgnm9COGfL5UKiQW8YH55X5RBjlzX/lg5Siti8zbuMcTGbfyZMlhTD?=
 =?us-ascii?Q?DnN6ghS8Rn0QBMcjKhxOJoLksqAdtrxqfjRzsl8RkxX8rlOrTLw/9i/0hUHA?=
 =?us-ascii?Q?fzZzpoKeS+CgUUtMAVF/yrhZEBsZ3C6/iL4VFV+ggTi55vssPO2MrhQnsg9s?=
 =?us-ascii?Q?ChvWshlR+O5A8uGdU4F2NkEUHL49ZaL5fZkJ/U1A+9LnbWamrSXL/PsvQSSx?=
 =?us-ascii?Q?0XdUSwYhOGCMMB1+QaaD+hwBIo9hrvnjLav2hPcMJBAUC/jp4OZDRshm9Kpn?=
 =?us-ascii?Q?h+3szpkK1x/oOZVUlaPSJy609nuvrahQgtzZYfovh4h2jM4o4gy0IplaBXy5?=
 =?us-ascii?Q?PDp3QAQSj7KMl8Mon6EGyWPChGEzOoMGX6Mz61eerSe/buTMYj9OFXMFPU9N?=
 =?us-ascii?Q?0zykhHmTglm8GA3Zb2qNiYESj9iONJBBcE895M2QkUqiYzmRMONV05zuyYWx?=
 =?us-ascii?Q?lOJPKT0bsJcP+o310m3H/1VXO4p3Pi/MS4hhL0W3jiNthKOH9b91/JjTR6gV?=
 =?us-ascii?Q?GfMaxadOw3JZK4aouSfIPdVg/ibwuCZFKMQZDnIjmzlnNqsHKWZWQwx3kr/E?=
 =?us-ascii?Q?KbGaeJWx+VWfbEnQUGUvJIYGnZcx6rqooOHOO5b3SHu0CoLPX9yhfxrBmx09?=
 =?us-ascii?Q?KFulzA1gkMvoZRpBc3w1MnDzcXnPhskMBH37ANnBYScv2mWItehkd/Q1qb8C?=
 =?us-ascii?Q?VZbc9vu5DXu85Ce7lcyvkKgnXfQH8/8sfPRPDpbaoeo7T4N7UWknBo6WVRMS?=
 =?us-ascii?Q?lmPFyR7lO8zzmhARuAVQXwZzujGf8bmhQ6/W8d73OgLWI9mbMzV7pFiC+yQ2?=
 =?us-ascii?Q?agn7aCRk+IgKxug=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:31:32.0295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73895c35-60ec-4a8b-edea-08dd5754939e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
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

Remove unused declaration of gws_debug_workaround.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 59619f794b6b..43950f3e6672 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -289,7 +289,6 @@ struct kfd_node {
 
 	/* Global GWS resource shared between processes */
 	void *gws;
-	bool gws_debug_workaround;
 
 	/* Clients watching SMI events */
 	struct list_head smi_clients;
-- 
2.34.1

