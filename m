Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E51CD4F25
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 15:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A2410E2D2;
	Tue, 12 May 2026 15:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4wAcdUwE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB0410E4E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 15:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SX6mfj54EcqadU4+qcVFMiy0xGKi7V+J5OYlFLpbhGDOa3z0sv/0aLkKy1PefeoYChdv78BNZJfNLnHAs7HrOAVISN0+UnVIOaR5VsrgJyBVFuxglCgZ8Uo9BVRAloimSXVCqw/qYUqZ82+MsFYWAcJuJ8/K/orllN695N+t/v/KXkSO+BJsz361gD8qY/raTjbBb04UAJ79NMDyTjBIPi/EHkgc516w8cZNZr5nfOAIayDCjwU3pSHP/+lTMk0wbHj25dLW+SzYhChzus4tBVim6zAoWFtMqzGIKbceNRImO7UbVT6LbfUwHEKqaXiGt8h1VbKoRSeyL9fZ8C95ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsHQQwmnL19BOustLKl4sO2IqseQPTQgD+9rHhxhcpM=;
 b=mD/Bdm1OlLP6T4Wy1/s7Zw+04lsLce/K7NRjMhTDGbF1TLTqzVsoZOSxqSu1VQEwRjdm9j+GjQCdIuSyPdyeSIL75t8pEKRCza8pZUvmrLyD0qUT898V7tIoulVPleS9GURRKCcD/QgI5R0ttwleZZ4PNrmlGUzrk5exfP0C3+LExWmoMgDy5NbGNY5jqo9jfG2pr4fSMyVhqYoEM2XH1i1nkCPDIL9mkaAblz93ZC3+ss8TSvCXMiOvbACszyvwzUbR4vQQE2WvVwqzeLM7DNGgUr3CT1iUYEtILZRmYjtzOMfblQnsFNgu3Y52xInXQHIBEliUnsCJg+O1vbZmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsHQQwmnL19BOustLKl4sO2IqseQPTQgD+9rHhxhcpM=;
 b=4wAcdUwEcAbz6JPfR4N9/XLAm3kx6ABQdsn3OecrY3OXePWl1Jv/7uEcJDpwJCMwW7AoTWM/MqvVwxEuAOjBUBvCd24An8a3ssBciK9t8ijBKxBFtCrRSpdhnqJGcVBZgS/UtdsD1rOuYMaGQxVmXq74GiTRoXrfaHbA443IFhY=
Received: from BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 15:09:43 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::1b) by BY5PR03CA0010.outlook.office365.com
 (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 15:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 15:09:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 10:09:41 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <yunru.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix discovery offset check under VF
Date: Tue, 12 May 2026 20:39:24 +0530
Message-ID: <20260512150924.206200-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: b5eede88-b980-4ecc-96d3-08deb0387f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 80EfKpkk5THTEN6w3FpdQuLjEmJpl73khJWMSjRU4tFl0sER4lrVxC3WRQ1Jw5FopanNEr2AYUcXs4UfemNmE90e6ZZQBkFTwlX/X+p6otmuGA7tKnWEiBKX7HFev0ziSMtRUhaZnL81iaWhSPVFBk9OWH6aqBMAIgrNrBo0Qh7u+J/VpF4UG0seKHhxee9hrYgoA9j+xmbsn30dKO6dPDkwBvO7fl5r8ABgR1LQdwLpFnwe3vn7qx2Bo4IvSUO23/CKiLpO+feSjrHJzy11U+QcfA/VOQDJsKTaUo0YrW/x47vaEMn6blM8S4VK1bPVsRToF5GOk22xhzAASRDOgzIy2pPcDj9td0MCU3enqdX57LSlgoVL/gPsu0pNcjfyalHX3P1qTIYjJKFUZFc/VblozCQShaPcj3lKezJjA+WdL9iBn9gXYQ76BHmyXcn879UyabOVLqFTnFRFTsA0s3Ytk9zkFWOc20OZCagPcRcEYeeukFo6Bz9rX06p9EKNHFSyax6NJ4m/JqAG6E/lW/9ghIAepAaHPxmhSdVu8jV7wVwAtunm5mNHP16eeLl2qqh7vaZeEYMvSoehoTUbCMfdZUJS81QduWqQZ/pDylqs56Djd/fUzMh57fnfERU6VFheposLvD9x8i4XfCpcqrH/cF0CkwSzN/H/yjrDkOTJdMVbAgB2qt1eG84zunP6BTMyK8Ew3vgEZbcoYME5XEI8Y0bjCvI0AmKG/PLaYXs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hhgSVfDropCPhjtv5W4H/jfhUi79hO4ppXq2r3LA0b6lbSeN92aMB8vqbl/Dfvmu3uIg90kqIAiHsqCgyQX8J+cL7uOIL2V+1quw06C86Rtl/X91QQe5cKFCricSO8CXmT5QMNsW7BErfC9P3ZnQ967an6V5G2PbDW2AHlTCwFnJsTNphqvpnQ4LkQX8PhQInRNtoqRiUr0gjiJ5r+evg7KCWb0fEzNNT/RCuQf+gC10XA3kD4wv3WvxsL+izw11gyjnT3ERtlFRtdqvV1x+drhBdrk16a8q0wMtG5+C0ncOwZRTP4x8YLVjba6/X6H/AnqhkttDUybCTX4stj449oW8szl7bdmU28P1otYmUxGqSbnR316ASwK7LPN1vbKWtPNcF1roRzGDx28I1NMvPNEojrukI2+jSa/i8o3XlzfGEHI2SWBkXAg3vmZuMKYj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:09:43.3343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5eede88-b980-4ecc-96d3-08deb0387f53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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

Discovery table may be kept at offset 0 by host driver. Remove the
validation check.

Fixes: b69911681fd5 ("drm/amdgpu: fallback to default discovery offset/size in sriov guest")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index bbb807a16a50..8e3b6a4050e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -305,7 +305,7 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
 			adev->discovery.size =
 				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb << 10;
-			if (!adev->discovery.offset || !adev->discovery.size)
+			if (!adev->discovery.size)
 				return -EINVAL;
 		} else {
 			goto out;
-- 
2.49.0

