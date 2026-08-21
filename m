Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7796C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CFFB10F356;
	Fri, 21 Aug 2026 16:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SNdOK8GI";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87BD410F356
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYBexJjtmwIYO4uG5AGwzU3DkOgrmlimBM9qA9uHAy0KQ1LG41UkotUpZkPiIWOIU7OJjIR6gVIYGKxHepVrm6biy/SwXHErY4jWh/3jgDc6E4A2P/53K91FAQU2IcPIwbfSIf2XS66ZbVZ6k3/5uo9fpl3SIkN1ZATGzjtHoVNO/X9ATfEjWNF4NFf3eXsDT3vxyRkeg9FE8wokioNCjV+3b/kIZ4K62TT1AasiUc0dwNs1OJEpsR/g/W2jtVrlBaKXQm4aML7fS/WBzkU/rD2xHT37iOMPHNFUrBQt3g5hN8SZ66ZfdiLELHh8ZTtu5hmOozXqRtasRrBnS7y1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7DazUPOrhrgvadvoaHyA4yUd8vYs7u9D4o2cVZLcLA=;
 b=cQmR31iH/A9EspN/3BiMZyQHZQzWKnJ6vDh9MJxt887cv0SA7/cWKo7AOiOy77N997PhWjQjs0eSVj+KdMDZndOVCgk9RX1yUAOLIEh9XNJLoaLCwy0cYPhiKk3PM1KQ207EmiqkImQjLyl1o5LkCdo44P6mpGCWENJ8hlpRlC0rA+6lyN2tRRy3MN6SI1sfMWQd+xYZKPRCumSJ2J/lvbh+Nj4bTuJ+kEWma9uTt2GnB2Nieo+YX6SuHB89dM3gxL6YEofeZ4r60r/X/Ndd93hzTqMWVp6vd89fpHOTkHKwgQtUkTahHaHNW07K+eX5rE3zBQ2OjZvRxijNzexfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7DazUPOrhrgvadvoaHyA4yUd8vYs7u9D4o2cVZLcLA=;
 b=SNdOK8GIUqFbKqEgpVeaON9+aB6u/ybJCopP3VA8Ui5wM7jozIaYW6UYLpCx6jChSxb6z66VPUC+w3nXcDnJuvIuy2mAV8Kc29YQq9dGmrQ7bEnpOq9KKaPoLImxd9E6S9i1tqrvbLyAuTYlBiMhryo5zdPPG3NeccwwGUi2mf8=
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:16:01 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a9) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:15:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:53 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:15:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: add memory partition sysfs init/fini for GC
 12.1.0
Date: Fri, 21 Aug 2026 12:15:41 -0400
Message-ID: <20260821161546.754333-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161546.754333-1-alexander.deucher@amd.com>
References: <20260821161546.754333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a7f4eb-a025-4007-a901-08deff9f7da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 75nkW61JUJZw7HBhH029w3Z04GhZgDDhPEBdOJl4iONrBTxxvVG73zI/Qpye5wO9sOwiEADRYJVVBLKl9rEldltc2vuOH/+EIep/TvjNVgDkBjQy8TExQxrpOcEGh5/2SLIyH+8Trbn1CJBPDAOOsK31yN54gi0cUvYleg1MNhrjHcdoU2Wy4zTaliSH2aornOTNEtFcDdBtAcGhQiC2Ky9L6mYzFXhemdRxvAgK5xB06tnhFMbP+NCJ4shvBkEMWSgpMzZjEnBCVFkYENBNZsqELSNNsJKHOOyP9AoAWvWyyxDuRiAtLr9QNpYFabFCB/CzzAZ2mfgKCeSaU5T+sJHfrpVVW/oHLHLJqebLaMbELDB1rTLAV/oD7lFz930YCVDzxX+h6zfN9yZ2isYigRhTdj+o8ukEd9RhQh/MJA1+R+5IbzpD6HLaFcVWNNWx/JgjGPoMjxuO0mvwYBCFGKb+zog20cpIWHm7p1ciIRoUu7ElNlhJRR1d/+12x+68/xZRmvtRQlXYYNaMQCG614qol2W2YFKBxKRh/9QIIrqTZZeeuo7bovzYIh03DmysKtzrz9degdadYXOuY3+qoHloP5/kL2jUdMvqBn7fAKOHyBjyWihLiyCffCtyuS9BbTlGFzLB1UeiwVb3oF1xyMVR5BE2nxpu7QLQewxg8+3f8IjuJg1h2N9lWw5ZH6p2akHE2rd1YU0baTEN3jDk9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r28KQu0AGRGVdyTkSl7vg/M856MvTXc54cd+kidscpuv6pt/IlYtTh6H0Me/6lb4NomX52c0LtBPeXdwYsqIERNvU5P407QR6Ru8NmXQj1WqwjLNl1KY5/oaJsFonSpImoupcqu+0FF72OLqWQvxD1VhJ37V75bLXVj9SkXyiWC8LEysJkKCl34kEczML9T9BSmcI4z3hWj+nrNi6e5B6TeGw+ErMTJQ/T8QzW20lUTOMdxvCNNGr0WbTwbZiXciIacZWPubdttCSkMdzDSXxjPhAqHIxTqTpnBlN0wDv1NLiYmbIRZAbVawAEDIaxASCpHDQHoUTIXlypP/IiagLkiUcbqPwE/FfNYGwfkSgwMHinTXuafAwUsZnyR+ij8F9e6aVFoGVujpPI05kC6TAv/TaIwpKs/qVt81ZXnrFcLmCYr/wPlU7reYb3bz7BPx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:15:59.9682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a7f4eb-a025-4007-a901-08deff9f7da6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616
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

From: Le Ma <le.ma@amd.com>

Add the nps sysfs node for GC 12.1.0

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 27f9f6a4f3fa4..a30942f35faaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -966,6 +966,9 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0))
+		amdgpu_gmc_sysfs_init(adev);
+
 	return 0;
 }
 
@@ -985,6 +988,9 @@ static int gmc_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0))
+		amdgpu_gmc_sysfs_fini(adev);
+
 	amdgpu_vm_manager_fini(adev);
 	gmc_v12_0_gart_fini(adev);
 	amdgpu_gem_force_release(adev);
-- 
2.55.0

