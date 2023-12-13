Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFF8C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 21:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEAFF10E87B;
	Wed, 13 Dec 2023 21:27:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE1210E81F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 21:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkL2tWriSDTT+72r3U9MZ65GWhBSPzcOX8AE51mqeE19mCYJwjMAoCMNX8i34EyMO/EJEoUjJq5NTd2rKrYZx6wMThDjKahBdK2U6XNvKc7bpN3x3iIpxUEkZA+rPZMNWvo9M3eqVB5M+PLqbiniP721DC8+Q/z6TAhMZ8DRkNBFqkETjcKBgyDw49Zxz/Pm5rN7lcAZO9a2p4B9OYP7iyAZxLWHIuME2AcPdDQdqB4qUUteWjg6QFKsa7i+aFZBSb3m1qUfBfQZun3RpizGgJ1Xcyy0LqA9YzZ/kmzc6lk6KwLLVFpzVYHWnGfdwilxUV9NtHdS1QOgNYGWKgN3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uBomX6FfavxRVFie2gAygq+V01HtUFrhMuECsbG37Q=;
 b=oIR8WYpXCAaCu0mgOpdqYsWGx4S2MfbAL/Y8HKx1kkyEl7eg0bU0Uy3LQIfqufCteiNKZvzscxFyeqZX5Ant2oTsJ6yYbjDnO+W9U+YvKQPQPhaP1JgmCsXE8bTINcN1YSyDzEm4YASzrFAlEhQq3eQPrAkuMFBIO/AOdszGBacC21e780TlLslq7oZstclXYiQ0DbCRFqY6+HRxMLKfZ68x9+0K/MuOgnH8zBahifugkURpy9zOZ0bni5znxVQGU/n+kHuzBW2uYiCspaSF4HraFWw/2j4V7ylKIBx315P41juD7PnwQJqDFBkOsr1uUXsEpVTSZnkMr4zX0EnkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uBomX6FfavxRVFie2gAygq+V01HtUFrhMuECsbG37Q=;
 b=kYyNx1NawQZ/Gaz7xe9Kus5M+DGELRLQBy/erFu/ZfL6c1zZfgXnf5RJ1hDzkl7uHXFiHOCkdgZ+wjU9B9lE5XuyFQym4MZhMa9zR42kJPzqxp0tT/JUQHlXGJqk/OXM4HBSfASmYF0cdspDIYzJS+42SEFsHxyUOB1yQ8VchrI=
Received: from CY5PR15CA0093.namprd15.prod.outlook.com (2603:10b6:930:7::21)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Wed, 13 Dec
 2023 21:27:44 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::49) by CY5PR15CA0093.outlook.office365.com
 (2603:10b6:930:7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 21:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 21:27:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 15:27:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: fall back to INPUT power for AVG power via
 INFO IOCTL
Date: Wed, 13 Dec 2023 16:27:27 -0500
Message-ID: <20231213212729.1965153-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213212729.1965153-1-alexander.deucher@amd.com>
References: <20231213212729.1965153-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: b4066a0a-cd48-49c9-f457-08dbfc225856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qc3QAUhKadOQmljVyETut0EkQ/gT/SWq24cUBX7XckBdjZpIuoZ+ZZsZRQUJ7IdYnmZG0tGbUGD+Q1yL6xeQgQCZsE2fL00k5AeANvON04xRh9v7/BD1SYsSGt7E3M0AEuAdaXitsPKFV9Ac9IjW16Ulnx6LJOziG6KySvgtLMdhMheOd+Bd+5tD99C0QY5lEk5EZKZmGoAiYsiKvyHRckOPvHwrBO5FYyAU0ZZSkd722KMT0FXkSySZSA06S3jP4uqmU/U0HJeBd05UKmO4LUEANMWKO4YmgGst22VCImNWA0n256S/sJ73OweBpHMrtnOtgOQaFZrG6WawBgSNbSE7+stKAppgZbBrECSKGSKEDTlnu4uoqSYVmax7pmtKc8KLT243UR3UvDbIsP92qnzKnSjM8TWZsuyFr2jXAYMUMnQ8BK60cmV+Q/FSyt8hB5qDPTJcDNM7tmvYiEyA2K7FGsCAC4hyGYwf1kDtq//Wl4CwPgW/BVBZlqbo4fuPkyWPGJBBhQRopd3o7LcuSN2HD6SWOhqUYitV4XY2UFqnuHFEynSShQ0wBlRCa8v/2NJrthkX3AmJeZIy1ds5r2ufvjLybPA7Ip0fqHFA0o1x1ancpzTKZzm+H4lHHih9+a++ezZn/3rj7fJBH1rGj0D2uM/9oAfiLhLBtWvM7mhY6BX/yWarKHW4h92mJ9DOFiXC+3udegE/mh22O/0BXKYMcJ8m4qfaej2rIhz8URwV3Q3FuvEXJOco/ZVy+pQh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40480700001)(1076003)(26005)(16526019)(336012)(6666004)(426003)(2616005)(40460700003)(82740400003)(86362001)(356005)(81166007)(7696005)(36756003)(47076005)(5660300002)(4744005)(2906002)(83380400001)(36860700001)(6916009)(4326008)(70586007)(316002)(70206006)(8936002)(8676002)(478600001)(966005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:27:44.3144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4066a0a-cd48-49c9-f457-08dbfc225856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
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

For backwards compatibility with userspace.

Fixes: 47f1724db4fe ("drm/amd: Introduce `AMDGPU_PP_SENSOR_GPU_INPUT_POWER`")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2897
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b5ebafd4a3ad..bf4f48fe438d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1105,7 +1105,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_GPU_AVG_POWER,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				/* fall back to input power for backwards compat */
+				if (amdgpu_dpm_read_sensor(adev,
+							   AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
+							   (void *)&ui32, &ui32_size)) {
+					return -EINVAL;
+				}
 			}
 			ui32 >>= 8;
 			break;
-- 
2.42.0

