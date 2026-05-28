Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E650CD5BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 06:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE03B10ECB4;
	Thu, 28 May 2026 06:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kq1rKLQr";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012048.outbound.protection.outlook.com
 [40.107.200.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1D910ECB4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCE0FfYaN0CGQhKErWkvZHC1aZ+YxxECdT9aKb3qzp/1gpq5ObGwBsiJrh+5bGUXuWSiNUvtTveWIsTQ43UZIO17fvjsc69G4YVKqpnK1KFLEFsEVLydBJpMJwSVm/xEwe2IKBy22qTReQ5/q+X+N9209M6vll1HMFxB5iXJXRjqWZshehqUebhiCViFFBrJA4GDS5D+HpsabS/4yyVlL1E7vZqnrcN0FuBKSRVzRlQV21GaZBLar6BTRK3fiOIq/A7JthwdJ+tKFrztYCNekDsbX3B85D5ujbgOXSg4NAJ/4hPJCGMpms22NgbsR85XqO+RPsCJqmb5/2mWmtaWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNPV9bUeu2Y4kbHYJKd8SqkNkS2JdEEuetGxnpTym9I=;
 b=pfNi0HNGPsZwCitDt5COP1UFwr7npe/cVlLCzybnCE66MLPpxRgmzyd37awCIIuvRWRG/MYHeu7tMccbmF/+IXdCzzgea3Var5rvDPCG6nvRGG2mY0en/wNlHdZRRBphgkDgxw0Xp/W6KzhPDNoWh9K0gDxnTn+JRg1AijEqKdlqZkY2KVZZEOD+5928t9O4c94w4zRRgwEAkD6lGo4z8fatDl9hOasBbksipWzR+mVTxRM/+ofJGhaCaTdHMVs5lKuYP0mtfZY3mTy99BgQbgpRXWAZJPvAveRmE/KW7ahSKJnE/vCKIhrKXO0ySvPqM94UzPbCY1lzkWSGFQhU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNPV9bUeu2Y4kbHYJKd8SqkNkS2JdEEuetGxnpTym9I=;
 b=Kq1rKLQriP2eTSNlboKFlXaX1EfIndG5BFdIPG92wYJE9xvVellPz2OMbVMs+PeEaB9LKWE8htHdIXGnUREQPsZ+29lw0rWHH7SwLvHNjAkae8HH3g5W1jL/AzGzp1HfQhivxgnt/PQIPjXDiXWyycvI+43JX7am9Be1DqqTbHQ=
Received: from IA1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::14)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:42:37 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::74) by IA1P220CA0008.outlook.office365.com
 (2603:10b6:208:461::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 06:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 06:42:37 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 01:42:35 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: Add support for SMU 15.0.5
Date: Thu, 28 May 2026 06:42:05 +0000
Message-ID: <20260528064206.12358-7-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: a7dda1bc-68ba-4844-8d28-08debc844e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: guC9tMB6BuauSyUI5JBWW34SQe4XEVwxIiKX8AXI2+puzEvUl3BvQC03iOLEWq7d+I0XpysVIvpjammW9qXsGUY4C9AIKzmtTgTVIy2kpg0Tm+BR9AmTUZn7lLoJUBXRpAAXuX6V4SH13pLwA29PkkEnbhWbNmabjNkkss8JdsswwVvWHVS6Z0GkYf6CQT7hmdMVbBsLeJI76CET5KBB/nQ6qd268M79S2mN1HAQ017DAMuGwWsLQKSgGYVXTVCSyAMZLzV8YFHojXMaZOo4TYA11k0Ql0sd0UTI0KweYpXVoa4ZU5KkASvps8GvQBHx+cod4g/GH/ey1ew7bUWt0XTdMOFswzI0N0Jci55acSCRceVS2oBoDmjmjM9E8ROR1kI14vNcV927MCY1nEgOemgcZLL9egOJ7yVNrwE4TD1DeBOH7g2WwSMrb78fRsOo3QHQHdd0fS7Is0hVaoGt70Z8FheS8KZsErxLZ0h2YH7e7PLycYjt2ijVkK8KXiRYNPgVDzdIj0pyAdN4v82ojUHicnQ4YdnTyjW8S9h8tp+PG0uB4vj2+ejAFVb+afUsNqhbil/4MaO3PtuLxZF4lzU6hYQHadNOzSkP4AfxAlaSz8eTljfWXKPlj/h7DhZOWb5CiPlo0lKqqkIRdgGZiFgyoHMvHd8UTl+IZ89xyfUa8ePrklLj1sgd1QxOxD49CocBHUfsfIecAk65/ednbMSAewa8uXU/K3cef7rMDpY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DFCNwefDI84AuxFON8USk9XEu0ZfTAuT29jd8BHudyC8peD4obSCuD8nC7ms/wNwL2M3433tXjehTV15D7unxLZNwK5cDNLBghzYYuQ+q7hwocUD46uXChW1sf419tkFUuBgUl8302Gd2adzoufoXTKu+8IG4px/FvTRI4M7pr1ZTKZOHhwCtwTYDaARI5zQgtOtfjju0YSHM+O7iPrk5XViFl9pncNSv1nwXHRAwQMn6L39W5PmHHoqThvcqX3kr4Gby5shHKW8Uw1xVHFSVYKqCnT118Fdh1NLRYdVjzU3fKu7fFRRox5Hm1VncZLNDOntSZt8usCb5HPQGriteJWBT+z1MbKGqMwdmNzOs03HUQAsrOu7nFJEigD0805oI0kEB//F7mo9Xg8PLbWiFlZKJ6Ktha3ioXCZSOITNHZGn3pi4opkfUIza2B9sT0L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:42:37.3267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dda1bc-68ba-4844-8d28-08debc844e9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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

Add SMU 15_0_5 and SMUIO 15_0_5

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 1af18c820d4f..de3c3d3939a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2348,6 +2348,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
 		break;
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 5):
 	case IP_VERSION(15, 0, 8):
 		amdgpu_device_ip_block_add(adev, &smu_v15_0_ip_block);
 		break;
@@ -3325,6 +3326,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->smuio.funcs = &smuio_v14_0_2_funcs;
 		break;
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 5):
 		adev->smuio.funcs = &smuio_v15_0_0_funcs;
 		break;
 	case IP_VERSION(15, 0, 8):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 337f9acacef0..ae44437af86b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -801,6 +801,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		smu_v14_0_2_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 5):
 		smu_v15_0_0_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(15, 0, 8):
-- 
2.43.0

