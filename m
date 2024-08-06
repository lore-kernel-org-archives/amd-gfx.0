Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8189C3DA64
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 12:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A5910E342;
	Tue,  6 Aug 2024 12:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vi9LGO+2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDBA310E342
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 12:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vj7Lo7KFllSgd3yXr1E3DD0IO6BemzZU3VFfHenzXD7s3NBpyaPZrW0bvcpDpGeR5iIi/bVQAoIVFdMfVy+ALz6oS0izfyxBsgab7zb1ozwBWCDYn2dm1u19oLzJCbNbiFEsK4HvCe9Nxq6nJh7gQJBdfdREgnqRu3G1Qqbqc1AaQCLOe0+SHsdk/7PO7y+o6P61BC2gaENM7jTFFl7oryGIqe4NjAFD2orgKsX7HTOI+uIaK5z68+77hvWV5W96FqfT1jjrqG0Kt6KUP8ddaoKb9CtfYh7o7J/qR4Xse4WC7qrmR/pBwznEgfnXiFef4ccimwD9lC04Y8vMxbDotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul2V64vNf9M5G2alLBgqm9aYOj3tmsJDWAZy37QeW10=;
 b=ZE2y1SpWoyZwOmlNHuysqYCsLL4lYPVTAfwqvNnU/MSdn8NA3Reftex5LgLAEZ0iRVfwrLGx/PGWgybnSTNmS0lovO4TR53ToMZ8DHCH7vyJZBvaZyRJ918MfGMeugPRLVUrXhWSZUtejFPGt8yW4W4bYiLc7XppLua7+TJf4xyUU3z+3GMtsA5RVXGc9qpN39ZaX9YViirHI/+n1vTgHPYfdRXNA9SH+O6vJmk20kdvqXQoQe90vNAJ0pn21BM9K6Vr/qnBW0Z83AbRo//wqF4Jzfi1pulTGl8G8mGoYDmMpZdeoLfPy3itoRZQIQQGjAR3CWsfAHhK0jiXkbx/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul2V64vNf9M5G2alLBgqm9aYOj3tmsJDWAZy37QeW10=;
 b=vi9LGO+2zDQ2j8VYsf8LIyoB1na2tv+xHSaIw2Z81fufluhDHoj/zEbvwb/V8LvhRdzIXmqAq0icClZtd3iKqFoPIMo/G4xjoT/MIQE8mGZ3jdsQK7594xcnQQPySmxz8mG68OHHy96lOXB1SEUCt+J/6LuXXufBpClbAoluSbU=
Received: from SA9PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:20::28)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Tue, 6 Aug
 2024 12:41:08 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::ff) by SA9PR03CA0023.outlook.office365.com
 (2603:10b6:806:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Tue, 6 Aug 2024 12:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 12:41:08 +0000
Received: from mkmvskvorts01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 07:41:07 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH v2 1/2] Revert "drm/amdgpu: Extend KIQ reg polling wait for VF"
Date: Tue, 6 Aug 2024 08:40:43 -0400
Message-ID: <20240806124043.443643-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CADnq5_OdCBnP=E7oe0cOh3=HGJwXYavRGCH958=S8Px8smH99g@mail.gmail.com>
References: <CADnq5_OdCBnP=E7oe0cOh3=HGJwXYavRGCH958=S8Px8smH99g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 397d9c01-6d8a-4c54-5095-08dcb6150ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tIb8BGSaOa3qh5jcHqbFTwldGBlpfxrqSXP3mvRgceeRDzZOCg9dr01sE+kn?=
 =?us-ascii?Q?+yO7U39ekSimAg0cJIqIOoWBssFc7tWOVsAHImdyq5by5gsINIMZ1l4FVKF8?=
 =?us-ascii?Q?vvYFd+viIAq/aExXMZqIzMYOmrwHsrl3sG8pY35bM8FoL1sT7v7zjjy8mMeL?=
 =?us-ascii?Q?oWOi2lP8W6vHbSf96Sl3T6hHONybSepOF9yRRjff92mrI3XFy4mZ8Qa7N4tR?=
 =?us-ascii?Q?G89eiks+F+5aPzzrjZp4ERSvy27gXTQWjmrgPsCu7k792QvWkHiGZMa3DJr5?=
 =?us-ascii?Q?KKfQnd+TWcS2XJVeLsdyEjpcicYkJcxX6eZ5RESaz2Un9SBUDoVFfLwLF8Gz?=
 =?us-ascii?Q?gHJvIO+28BJFgl9iiTiD6l4A5Pd8iGSKBlMkaTXno2Sguxdd2vI8UNlQm9ds?=
 =?us-ascii?Q?lE33zMoLIxtwTf3Irm24iOHhtmVr4W9n/bYHGym0vMk4NLXyFF3S8FxtM/Il?=
 =?us-ascii?Q?ZNWy5B9eR2+003pZMWRIIOWrl/KVsm5pmjENcjxktEvi9pqY8rw0jH7H0zjU?=
 =?us-ascii?Q?x/KxaUe0gvJBbALe2epWxr+EVvxq5tD651BqLmZIKEZdDnVMl7KjtVjgZUSv?=
 =?us-ascii?Q?IHMa1uXEOg+H/aVdn+PmIvdWMVL5tZr05RmYQ9eocIwoq9Zl7FH3ErhXFr3R?=
 =?us-ascii?Q?l0pDDBV89zsbiNBc9C1oAuVHWQNPrnDbhaEZHwPvegoCAfXJbQ6FN+t+s9bA?=
 =?us-ascii?Q?c1mO+ud2xn4nqoWelUcGLujG8+QMJfHQrev/BzbJ5PmDdX8gfMZfzahspx7A?=
 =?us-ascii?Q?fgs9coxa7Dtr4oV9CzS9nHGq5HdP93VMAvFDqGvRIITI6rYR+z5wy4izD1YW?=
 =?us-ascii?Q?/WIQN4gyWYEKIyJBLaptkwNHCyAcB5dOBOGNdvvnRQuUnXYi3zjD8Fr3+vpg?=
 =?us-ascii?Q?HRQwpcaCMfdbr0LiM4Sck3QKSGleO+4RKgY8a+cBv5oKW8fqSkBl6/q96OM7?=
 =?us-ascii?Q?ZWRQ4bhXyfKfjhyoNjV6OEaJtxn85IDCryDqswdxTrQbTG0Lgf4vnG61JPtd?=
 =?us-ascii?Q?CRmTk/lns0B1R9+oM4dJ4VvmWt64LpBNRBrdCrnyVrzwAJasfRDXhaNK8Q5u?=
 =?us-ascii?Q?Sbq2NXkwGGf2svAixf8nuzx1JxxKmWrlv3daB4wyjnBSl4IcQpUELDWsNPCl?=
 =?us-ascii?Q?k8IWAKulSO9HwM0On16qY1fLkHYhuc/83azwoXPxVX22MvIG4MWETeIqEIAi?=
 =?us-ascii?Q?YW0ps2z2AnptoRro5JR+3T4mZGrk4Ycboa2mHbo/P5dCdlIS1ZFUXcJTVxkc?=
 =?us-ascii?Q?XiRaqpfPDs7YiZpBW7MCmazTbo5RZI56r872n5Lz4WcB3tOFGBX3ewQfJxJD?=
 =?us-ascii?Q?uSu4wnxZLIhKRzF0behP6L32Gd+QFUO4QGwAkEfnb6hyZ0z87W6IRTMn5eyv?=
 =?us-ascii?Q?G/p7PWOksJIJAtuun5MOrzLdabf9h4qIBgk/AAOE5A/NDBm04S0fk/bWIunJ?=
 =?us-ascii?Q?KApOgzY1gcS3YGvuibOSN3ciq/N0RGFz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:41:08.5044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 397d9c01-6d8a-4c54-5095-08dcb6150ba9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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

KIQ timeouts no longer seen.

This reverts commit b4d12cc00ad69e8a0dea2ece7202bacfd8b894fb.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 137a88b8de45..206360503136 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -347,9 +347,9 @@ enum amdgpu_kiq_irq {
 	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
 	AMDGPU_CP_KIQ_IRQ_LAST
 };
-#define SRIOV_USEC_TIMEOUT 1200000 /* wait 12 * 100ms for SRIOV */
-#define MAX_KIQ_REG_WAIT (amdgpu_sriov_vf(adev) ? 50000 : 5000) /* in usecs, extend for VF */
-#define MAX_KIQ_REG_BAILOUT_INTERVAL 5 /* in msecs, 5ms */
+#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
+#define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
+#define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
 
 int amdgpu_device_ip_set_clockgating_state(void *dev,
-- 
2.34.1

