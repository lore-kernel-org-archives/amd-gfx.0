Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E616CD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 10:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A1210EDCD;
	Thu, 18 Jun 2026 10:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1wXN7FJH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED9B10EDCD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 10:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiYXqvrZJUvSWvhbvw3ZjaJoBlqhd3O0syOLk0LRt5bNzwNmrOLTHW1KjpUxhGXcmss/KQFdTAG8rbfmpJSqjGi351q14W2iaMeteWLYIKNE/9yLBqROqpri2AR88DbOiRaoEUcb/Nv3M+EpM6qnaoyyzzKM2296b9FR5Afh4KYU1KSbtaCfAUTHBxI3NSZkE9+cZXGPXcgMhANKZtJKrfodjcf2hVCX0/YgA2fg/zEep75SuZwvPpjk6hTEKDlJozUg37vE3kFiNV8XMcyHVPxhoikiwHEdNqqgJijHcG8a/xJBHbyKwd3mZiqEpgsg6Z1MsOnQlZYWo7A9E2eryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0QFIzqZkjfgIT1XCY6MbZ0cyO9d6/cLHJZk6ixKt2U=;
 b=dYnOQ8rQlkPOPf/9RZaWRtQOZSwJBQo1H6+FWdR4n49NEg0stsKoZtkTDAcGYyCjIm02dTaHgJ/ZNi+fz+FVV6az5TE0jd1LYoCtrkMARmmzbSaOTYm+BRE/W2QD/+ONil077kY6ls67FRI8Xu0iPu0mYllmolhxaCTO0ro2CX0n1ARQoQVvK8BoMJq6rT78V05zXo3ej+xfku9OU8CVVTL7X1ohvCSdzNA2wH7Tek2cdv7duEXQCFUjIb0JZiEMA539oANP6rE4wieh3xPgXz6Zm+MLqb9WH90lrsujd1c5KJEhz0ofSDt6dX+RHxYu8I+tuRywFW09LK1KYIBK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0QFIzqZkjfgIT1XCY6MbZ0cyO9d6/cLHJZk6ixKt2U=;
 b=1wXN7FJHPttlwfITsHXrhpGqDXUZe7e52HxVmAQb/wWTuUqO8q0+k0GtyiTwCgS94+xwU+ltnMsKFlj/7p1bO9oSQlndf/4AWL3KpeWZwrviMYR73rJ/ol+ZuMLMip0nxVcWloJ7Gnio9amGEdzEvcBLLVa0B079uqhbUi+7Xe8=
Received: from CH2PR14CA0049.namprd14.prod.outlook.com (2603:10b6:610:56::29)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 10:52:12 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::3f) by CH2PR14CA0049.outlook.office365.com
 (2603:10b6:610:56::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 10:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 10:52:12 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 05:52:10 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Ray.Huang@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdgpu: amdgpu_userq_restore_all return errors on failed bo
 reservation
Date: Thu, 18 Jun 2026 18:51:58 +0800
Message-ID: <20260618105158.93562-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: d2522bd8-311e-4348-7a8f-08decd27a71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: QiFDKa+Y5NcDkl6pBzXNyf1a6BiH/VSZFDX0eq+x15Ldgc+Ck7buI4RdF03RiUhIlEzYTSQnn3n6ACQGBFG51DzK5C65EMEDrInAump7Wj94+jyYoJsEu3lxke49oYRmcre/WeW+jkoFVfyJ2Wt8Kqi/WMQZGkXzqZRiZeo8ZQpoO/GxxKfhEmFc2a2p0TuwhrEay3q0AaJrembhWwGjkCunTkxZPWuBKgM9Bs6izA7ywugQmlfVY5eTh+S6Z65pLbv/169lE6yQ3eGekp7zYH8s1LhDP0eRaIaC0kIv5qsjdUJRa0c55/lME7fHPE/SkHwqLRqrqEWnMNB4RJDBUrzWsy6+dY2G6+NSdGhZ8YNoofpN+gD6N3fA/2bqMtP1vXYau0jxJX53Ny/VUtsdnQqCURbLL/oWIpKsVezP4zy0kCECegPuPz4szw19jvkzxbtgH3aKa3rVipQ+rHAybQge+7Ax8EQ0xuVZdXdVt73IcPR353oOqaDssZB6oM4Jer0z86xemQudkww+9XdZ2WHs1tIn10Rt5MRlCjp/FW1InccaJXBUm4XBc01pE7NS6xZIwRTiC+mVANw5rEjUHSPQR0f5j7Pp3+DLjurCtjZNN7RodrDwMkBsKpfsdlUIiKntzidIZaJOirwJGFmziIYbnYoX4lZZNg0SA8SNlnu475X0lgBgV2OMEQ2Ov2QU5IOI27luIwC1JXOfWFur17/EP0+uKM0zFtIyoj3JnRI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +4RzPCbOydDfJFSvOmHz1N+oGM0LGYZpZ5N7pv73XJKegb+VqNkkluI8iGgaXByD7o0OHtXf4RF9khQKeZHXltErRlRzuLJIsrb/N3X7EMXiEiFFYiZJEmX5FEkH4GoXb+YZKt5taJBsZEdwYMKsGKiRjYbHvEwTAxuYggE0nIgd6SZ3pRaS4hFaoqT+qHuzGnLtaeq03dE4WEgYEk39NmguEjYZ1isAh0eemQ/c6kMBrqHxtrXBanGxX0FuHpub+plilR8vf+24AVPcmv7chIV9TO8xnV5+aaqCg0/PPCarapo7H9JJYKwCZE1x2OFY3pYxNaMNio2dQes683bEniFtWRm7RTCE1iW/rriD1RJr+KkasXEs3eOgflst2RXxJbVCOxQ6qZJWIJoQ3Et6nCE0C7SEghqe2neeqV8R3abBekeKxUdKhuSxOMusJISj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:52:12.3783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2522bd8-311e-4348-7a8f-08decd27a71d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932
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

In amdgpu_userq_restore_all(), when failed to reserve
a bo, it should return a meaningful error code other than
"false" that means SUCCESS, which is wrong.

The caller should not ignore the return code of
amdgpu_userq_restore_all as well

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 95b680fc88c5..8b14870afbf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -894,9 +894,9 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
-
-	if (amdgpu_bo_reserve(vm->root.bo, false))
-		return false;
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
 
 	mutex_lock(&uq_mgr->userq_mutex);
 	/* Resume all the queues for this process */
@@ -1133,7 +1133,9 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 		goto put_fence;
 	}
 
-	amdgpu_userq_restore_all(uq_mgr);
+	ret = amdgpu_userq_restore_all(uq_mgr);
+	if (ret)
+		drm_file_err(uq_mgr->file, "Failed to restore user queues, ret=%d\n", ret);
 
 put_fence:
 	dma_fence_put(ev_fence);
-- 
2.54.0

