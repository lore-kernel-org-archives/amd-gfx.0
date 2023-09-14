Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BBBEEAA6E
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 20:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C30410E1BD;
	Thu, 14 Sep 2023 20:23:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0980510E1D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 20:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of7wuHFFeJxhkfmleL7CooW3tk4ZPnTHik9EGdNcTC4AMtsigXzgyrxeA3fNJXWi2YWyYI3dDFSX8Y80gdDEZWoltrsbJrE3uL1szXC2yXtNywEya+7ixmEGvKsZShhhGkX+jSHGpe36Jb6X9PxiCmG8Dq2q/+Opz0YHAy9Qw2upyaOQORca9ewGLBA5zBx3RCHGdmEzmWbf23Xs5A9Z8OOrQQhVmDIqyUsPGTBfqG6VeMkbqvmoOcOWl/xbw1ct6frv30MRO7o2Xesfh5MJEULM8uzhNxqEAtZ1abLPYYgLaLqfACD1dLqZ0kn4qRgBrez1gN2DbTeZUg65djevAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlEBQLPF6b4tHDBmead07+lCllBjZC28DsoK0TMC668=;
 b=kkVM8jUnuzV6R8icUKNC4n9nMLmHc9LOHQrAsPdWnvguv62f/ATro7/cr4ZhMWHdRYguSzUOipWKvN5ov9GRWMsXu5PALXoUqPWD91WeMpQHE7rLTk6tIqzM8fMs2kSdnDtXzYJoV6ZSI6odjuFIqGII0HUjL6fp/O1Tac0BlkwpT9fYrJjdR3YdDItJjqW9YAgtfROMRcbVQ0TpbOKRDke5Lsrimyh3giWA6L9+44dnyGbl9fBlk52YuSsh9vf1r3YweJZ6yBfYACJuPibY/nk+O7MeBKQq59GyU2UrvheCWHRQmG3ADthyO6eO/RGIFO2/bqSCl/9gDF0UbUte4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlEBQLPF6b4tHDBmead07+lCllBjZC28DsoK0TMC668=;
 b=b2Ny4T7qW8h5SbUSdAKG0UFW6fy7y4LrWtLW1IK4nYG2sZMi2s6lDMvLMmFmaD40CIJrWc03m8yEd/W53JQi7/UO5e/77oLG8ItXAq48fy6+RiaEeLRcedfSqRhggQNiry2Si2CDj6OU6XEzeeIOb7qMpCI00f0R2P0MnK2waKk=
Received: from PH7PR17CA0011.namprd17.prod.outlook.com (2603:10b6:510:324::20)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 14 Sep
 2023 20:23:19 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::6) by PH7PR17CA0011.outlook.office365.com
 (2603:10b6:510:324::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 20:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 20:23:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 15:23:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu/gmc11: set gart placement GC11
Date: Thu, 14 Sep 2023 16:23:02 -0400
Message-ID: <20230914202304.695340-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914202304.695340-1-alexander.deucher@amd.com>
References: <20230914202304.695340-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: fe64047c-f145-49c7-bbcc-08dbb5606f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQLcj9USiyrgqKRzoOsVOPR1w5R0m1pSyyJ0T+fNjgh3omytXX7Dzf7W9rjwqJhNAyHAaX2GUVDicYnvtlvv6ml4fo7/uTo+DLES1mcxHcXQ5SQQf+LE7TEk4uOB8WfuPW8msMU/yZbdKtRWVpOrOccX/0SasFuXznYiTDBBvF8ORV7+vipo96MRT4Sw8mPMgy3WMwQThgvdqgCX3fcTI8olepF8U4BQ+RdAXeCvQNAyHxR+Uwp8ZHYXcgndaKhH7YfykY12J1AueXf0ZP6uWJfO+gsdjvaRwD6glMT5+/KsI3wc6jb8kHXgEJwm/HiQvHdk4PTsEzzcMeSKxL7xgljN8h99+NQTyFcm4XMIzkED+6xSqjrmr2NJR9kkvJKzh5Qzota0E/AYUCa7W2m7zjHSfzwmGWlWfsO4q8TWpfS8Ifv3oihHLIPJpRQHhSc2Y3yyGaxhC78GOflELAt3r9hjZ4WM5B1URKJv2vY2EiOKyl/y+kdbuhz17WfGNcFoTiWFKgwJzOoA/EdrVz+D2zX5/HUO8NC1yOqEYMflPhw9V1CnExrwIlz1QjGK6TCK25f+PpWm0nkLYBEiBrRIolruEYXhynV+WDN0D3u61XV3NsAhBV7qM7ckY3jNKUkF7j9dOmk2cOHPm3P+8wxp8apVTtgup6ThfLIaliIGb/4/imjsYfbLrh5ricGxmf8THUJPBKVkiVGjHcD/4sApQxCaEZICB5pZZEKaTUMhLdPDHAKpZlwRT19WbjjCBrdfzBf4dghkrSPctYxyLKetvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(186009)(451199024)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(36756003)(86362001)(40460700003)(40480700001)(70206006)(478600001)(426003)(336012)(1076003)(26005)(16526019)(5660300002)(70586007)(316002)(7696005)(6916009)(41300700001)(8936002)(2616005)(4326008)(8676002)(2906002)(36860700001)(47076005)(6666004)(82740400003)(356005)(81166007)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 20:23:18.6894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe64047c-f145-49c7-bbcc-08dbb5606f0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Needed to avoid a hardware issue.

v2: force high for all GC11 parts for consistency (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index e1f47f9c1881..e8dc002b5a79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -740,6 +740,9 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 	else
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 
+	/* force GART to avoid a hw issue in GC11 */
+	adev->gmc.gart_placement = AMDGPU_GART_PLACEMENT_HIGH;
+
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
-- 
2.41.0

