Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBACC48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 21:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6EF010E456;
	Wed, 14 Feb 2024 21:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fkK/N+B+";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC9210E456
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 21:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRZInCqiSJaXu0So501hDfCfx4CTEs/FspYiOitoXNDbTnD3i7v2brHAu07ytV/PHTMMcTn3XoIV8CtyEbLWZvKxFTr7cr5AY6KHGY0TAm/RsRzSZbsxPXWCABP67gSyuUY3RJIiHRdllNT6/WjlFjwctGGiJGKjYVSibOa/G9peyCWC7Pqxy800UroYihwWK/Q+f4+/NOdEQwayobRiD5qq+UK/NhuB6ZXB16o3x85BpDPHNnIKsBUQpvt43boWbhVAVBxfbreA0huPlsy1rOXFMVYfE6lXIEAeFdQHb/QjRCrvH/dbmHL8jwg29qLM4OH21TsV97YtwuLRSSe7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpceNGhRYcxqeP0U/bJDwY9DxGNWzufeyLpCbZfdPtI=;
 b=amOrLzDoxBBlqbPerYYUf3BX2WRZnsd86PmsyrpDAuwZG6yOk5S8FPJDFrXg1mHcZxyogc2tt5hBQ7tMq3L3YNs0rfRtU+xCeA34ydNtBrWecupTEkmEQtQapoeGviQdkfUmAgeW3Ztr5+kYNIStJJ+UpPs8qMJwnp7+kWTsZrqGru8VI8x4FlJjHix8P9mhwpoQ5bLNtVnsJyVn7bUWt9awsfbtxtG8KASSRS3wTMnO0bnLnheegji9eu7/dCMWOB1RJFagRwY6G14oJKeYxxeronP4ompVV7LK4yGr3FXP/7RsQB0JuctdrAcoFKQ04fRn9mqvf4/MJXRz3bGwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpceNGhRYcxqeP0U/bJDwY9DxGNWzufeyLpCbZfdPtI=;
 b=fkK/N+B+fg0aZMKoEREqAdF6KK5PzjhJCxrYG7sd3E9SMQus2EmFiqC5/eeL37d+8gaLqVK/WUWOAvllg1c0L4EcG0D4cQF8psOmB790OmPfLXZx/hA+n9SFZJIyxb7ar5P0cYGI1v9+HUZGsc6UVmufoaEHgq2LVcPHRsUdb8s=
Received: from CY5P221CA0154.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::22)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Wed, 14 Feb
 2024 21:35:48 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:6a:cafe::b) by CY5P221CA0154.outlook.office365.com
 (2603:10b6:930:6a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41 via Frontend
 Transport; Wed, 14 Feb 2024 21:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 21:35:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 15:35:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add SDMA 6.1.1 discovery support
Date: Wed, 14 Feb 2024 16:35:28 -0500
Message-ID: <20240214213528.2592338-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240214213528.2592338-1-alexander.deucher@amd.com>
References: <20240214213528.2592338-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: cdeb17b5-b005-430f-e315-08dc2da4e8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsQawMP0SF8ZrdZwma+oJbGMSR1sEzBvZqhg42+2+LjjqUY81mbe1UBPHGCyWCXwvqzxh2JwHM3co9o5v4SMoaaLWLbJ9lMNpvpSqLY/uDByt7o1b4glc4WLlBYhp/OV/mlVuFTVElo5NPjABUahqL3K0iaBQC4URSWKe/eyQMZkAKsX3Xr5lEOArFltqUMrXxaEykW+OIe7sVZWoWppAsOGjOMpqANpKFnu+iI9QoBcKRgbGaxy3Bg0q+ZD4C44TSpeNwtU43UDtfXS9bkvZmYFsf9O+F8MoMUSGjL7uqyObobrNEhAagcI53F4kjGBoiM2LJhRyF+Rin7jVcrw0pgkU4iqtElelxgOJB/RrPURtRNH02xhsYBHYu2cR8A4OXQWAlBlzLLCLFTwTKOujtFQcAZkrOMPupBPvzSDQo5h8X1Ik5L5JmII3PZQk+fbwTdMKXQJoc2HUFilMFM7zJdeOWHcCL6Vsvm1mR1jE1ke1TV0d/04hAmRXme90XK0IKX3s1uAEmusHi8HNT7akJuVoTLdIEzGK+1A8Jy1RWSF5am3FD2Aeos8q7ydazUKjvvXPUVUVmAaCbzIcTCxK/LN9s/uc7RIkDnINOcQne0LA7kpuAB9zU/T6/6aQj5BHb5TJJvYUfT9BHV4nNvtAuT8gXg5CozJqUGisGg3VsY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(36860700004)(1800799012)(82310400011)(46966006)(40470700004)(2616005)(1076003)(83380400001)(82740400003)(16526019)(26005)(7696005)(356005)(81166007)(426003)(336012)(478600001)(4326008)(6916009)(5660300002)(8936002)(41300700001)(4744005)(70586007)(2906002)(6666004)(316002)(54906003)(36756003)(8676002)(70206006)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:35:48.0794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdeb17b5-b005-430f-e315-08dc2da4e8b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add SDMA 6.1.1 support.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ea4ca1e6d7b9..3bd47d882205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2050,6 +2050,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 0, 2):
 	case IP_VERSION(6, 0, 3):
 	case IP_VERSION(6, 1, 0):
+	case IP_VERSION(6, 1, 1):
 		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
 		break;
 	default:
-- 
2.42.0

