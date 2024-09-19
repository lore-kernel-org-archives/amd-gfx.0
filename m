Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A2BCF3962
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 16:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0518310E731;
	Thu, 19 Sep 2024 16:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e2ti0WSQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0DF10E0A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 16:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I55IlUDYkx+2oZ41gGaq03RYas9I9vPFG4bGT1+GQi3JuUSIwCnscyxuQvt4uy5wJUEE4zp2Ldj4V9ZIKsbk9Y3WB9UfQDBAEsoKtRJOSBqrV0FgyESrliJHCgP0+B0tDosRTOYMBJ8n6OGwNt1usZZKy/FW9+5JYkUCw4JEfcgNbNZNTJ08ye6sZmhjTAcM2fx3ETJMw/yttP+xTUcn2ly6evmi/hmtVS4R038f0ao9Mtl5TPgI5AIjL4uvc+tHvMohs43AGcL9M0p07CiHy9kVC1yRguBmQ0vWoxJtqraAG3mkj7R5AZ/3SM1JAKL/6GUwU8sfaiPre4Lhf1frsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MYIfnKYBvywHAZXWSP8UBtZix1nhAbMT0d6HePbXps=;
 b=mnNqoAvtB3ExbMALAPsqtKN73GMHcqktaqIyfNUI/HvlytbKU1s7xLAwau+IZJ9mw05B6qGZRtC/iey40JnZYjCiVjnsD856eqTkZc+PUvEcpjh9f1tv2MNmxOLyKnynGA1ARNxrLJsu1uZ6KFWQtyA7xMOZvMpHvjbOShWdeudYDJ86Tlha3qGQq/DnvJA+b+LZ3imWRMk3sgRqwkfDTViHymkVyvoXZumGxBrH8wWmKOeSnfVtEc5cyy/ql+p04D/xlh5WEatMAT3P66njkYGJNJMAbr0PyBo1JZ9llToWI7wfhCN27QiUau8quGxW3NXyO/nxzRKNrB13YiipFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MYIfnKYBvywHAZXWSP8UBtZix1nhAbMT0d6HePbXps=;
 b=e2ti0WSQvIQAwkn1ZftJKLDbV0xoVUwpl4jWBb8F/cJ4WE8Nx+2fr2jsjxdjj/AWYv1sVUjsMr3qEYmYVoyuSYTrvRDtlGA7yFu5OLxIW+E2kHKTXFErTryvsrNTb/hL/TA/kCGgrAzX8DOo0M4MoJf19SRdRi7EIcQyXrmCxbk=
Received: from SJ0PR03CA0333.namprd03.prod.outlook.com (2603:10b6:a03:39c::8)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 16:47:17 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4e) by SJ0PR03CA0333.outlook.office365.com
 (2603:10b6:a03:39c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 16:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 16:47:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 11:47:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx9: Explicitly halt CP before init
Date: Thu, 19 Sep 2024 12:47:00 -0400
Message-ID: <20240919164700.2579011-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919164700.2579011-1-alexander.deucher@amd.com>
References: <20240919164700.2579011-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac1f3ad-798f-433d-df5e-08dcd8cab89f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8wKY0QuaYZ2mRwq4CY49/hqLusztxAGptGRmV5fv1ecfBHwkT4p8FIqMtZYg?=
 =?us-ascii?Q?lF1/N/S87RGp2Rvxy0HuuCGHmcnaOwvWTJUOhOpBmnp7rmmRCD+qa/vf7IS4?=
 =?us-ascii?Q?+NFJ48jpF6tyV2tOo5oNSU9495Gz9jUMwFQi0DhiwZyME0hykyVEzMSYy8uz?=
 =?us-ascii?Q?6nS/jQ747uJihC1rPi9JyKVTZNPBlHTayN3xiwA4nWMCuBNBQBgCiSBWrn3f?=
 =?us-ascii?Q?UzBqEH8xnQMzl905eubzLLnfVAAZCsyc7MKDFb0NF5M/6Lto7QWamu1GtFc+?=
 =?us-ascii?Q?CpJgZhZkuBk5Obwuhrq/CXc+HegHlsqTrKxVAd82rfZT1cXsE9bUrllZ21MA?=
 =?us-ascii?Q?Ikmt+24hcvOJYHrusWYPKijx+Ygulc4h8u2KjSABhWilhMDo7+lHI2E/Xut6?=
 =?us-ascii?Q?b4IoONL6ukU0MVpW+hfUfsKJJhzRRVKxsGWMJjtNxfk5IRZ2EwSt44pkn8mm?=
 =?us-ascii?Q?+zOR3Z4q9El/0v+JTylyU9ThBnw/vebHRAwCGyTmKZpYBVMjzRppKHLJNdlz?=
 =?us-ascii?Q?tO7Jdykio/0Ul2vcFFPcKqWss1KCgtH/TqMWwQoposf59PfvAc8TL5XF6pr5?=
 =?us-ascii?Q?6xxrBgeMeFO5ZqXz0HmoSSW2r7mFt0ZWKJBz7VRfUbop0R8w1+QVQv72SD8o?=
 =?us-ascii?Q?NXgHwZ3vE8ls37Kh0zzrtwJDXQt6kyI4vEY3wc/1FcYCwW2XX/c/yKzKyrH3?=
 =?us-ascii?Q?nG3tEr6yfeoVGD5NiMOtEl1IhqjjunW8MADeH65f5S6+JuKXPj+2PNZnK4lX?=
 =?us-ascii?Q?t3RmmVbHAMc61D9OveylNEZmqPK+ogxMi2eGY42E5qRub1WWNXTB4ZCr5mMY?=
 =?us-ascii?Q?6wpqR8MtEM8I7JVArp08CQrcBXO7DGUdfeCHyHRdEj3jW6PqwOfViZHkIN7+?=
 =?us-ascii?Q?Rh3Lq4o4ZXt6jEPeNCkxaIolIEiFCyEH6j4YuucOF+V7Chbmxr2CqTzrD37d?=
 =?us-ascii?Q?EuJz/VXCi+UPbt2lbMzh46Ygi1A4dtxSmPMO2DJuN0cIygLC6hReEK+I1m/d?=
 =?us-ascii?Q?U4+XrI4VFncOiVBx/Qx6KrHY4aMMAApyl7tMj4TIwkmzIxbVEpFfJytheiMj?=
 =?us-ascii?Q?cC5oZqkf59PYHkqGcxLcP9xhJlkxFXOaWaoEYy0uk8rn49dY0BIRo47mXOVu?=
 =?us-ascii?Q?4UHd8Ga9aSbXz9wJ2baP4NFizfFqI5o4hzxA8D1nY68Y6UhpJa426f24W7ZT?=
 =?us-ascii?Q?HVnLgbbioNMkcABkXMW7nERkGQ5b0KbU3ADFBIqKfdM19Hr806Zg9sT9PcbD?=
 =?us-ascii?Q?Gvfqi1i9Mx8kgUnYUMeE+42cEqLvOkjylDj7gVOsSU9Q2LG+/KLbNI+lbYDZ?=
 =?us-ascii?Q?2EjPEhnTuBefDqla67c9TFb9x/tz2sq3VPD3Hz320+TKdtf6htj+5JvV9/xG?=
 =?us-ascii?Q?iT1Y1Qapm0lumQvDVkD7w2ugc/ADaXUIgJxoqJcYazUoVv8GAOgd07FxhLgb?=
 =?us-ascii?Q?X3V+xUYOE1UApRlKUdKRlGATy3mTGiaV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:47:17.0840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac1f3ad-798f-433d-df5e-08dcd8cab89f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335
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

Need to make sure it's halted as we don't know what state
the GPU may have been left in previously.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d4f19eb8ff6d3..3a3ef93f2f43a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3931,6 +3931,10 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
 			return r;
 	}
 
+	if (adev->gfx.num_gfx_rings)
+		gfx_v9_0_cp_gfx_enable(adev, false);
+	gfx_v9_0_cp_compute_enable(adev, false);
+
 	r = gfx_v9_0_kiq_resume(adev);
 	if (r)
 		return r;
-- 
2.46.0

