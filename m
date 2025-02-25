Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231E4C021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 08:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C896910E5B5;
	Tue, 25 Feb 2025 08:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E7aocM2k";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454F910E5B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 08:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJ/s6t9fYmSJq9FrpOKvKEdviJdbSP1QwPxgB2Xq0E9lO99/NBjnK88UT+dU2mMty/5nwSVLTCAuqgFzKXLh7PnoT26M4sf5uPI7RfV10tD6Ia0pGMlcXi33JK1f+zMJVsKNAHwt8HSB50y5U67E/fMVZqwh30IBpH93399Ow/+o4bndrNy8VyPAnp2k2hnwiUQQpG2hCzP/MX6TeZna9On4/XR++CP8Xz4ukdjf2TMlS63hSoZDhP11s4CrwPJ5bm9ufyQYhUHm0R0tKH30QF+9lJr7wPjKyTkBfaOzshAVad7nL9pDSra4KZyijA45EV5ZFfVwtsNZEmxq1PfgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY91cJsiZje1ShTuLqgKCWSWgKs3bXPujc2kRm3Hi34=;
 b=TKGDKwL+WcJPZFYuzouQIiXG7cO6jDShiz6rTqU0SbAtu8EGOtrxe4ByDUYMAhN4Yp5OY9hju4NgvKRf1nfsg2cDJH2vYNxkDxh+bBM+yDmEvmXUN6ioGHduSObdj4v3uzfTfW+VXtmKao9ZmXn1O+hnpq/agLBi8BWvYzV7/gQDWH3N0t81XYUDX3od7XBJl8i4R1SXpcHSuwO/vQmqOJj1nrTRBKLnKoF42IPt/URrk2mVlSxcF0e/lKQc/SQbNKG0wahzFJ7+RtCO4BU8Ly39vMrhmNmRubz54+gdEt+SrwHw2kTkul1WrL1I/qJKKleQIhFFvmJcvE1VI66uwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY91cJsiZje1ShTuLqgKCWSWgKs3bXPujc2kRm3Hi34=;
 b=E7aocM2kl+cRfvOomenwgtrnKfDNKl6KCUNvqQFB99oOTLJ0CTyM4PkxACs27WqnGH1RKSmymmh0g/3pEFmbeQN4tdHvEyd3xnPPf9UWLR0h/2GmMK9/jAzmO0gXwuJHo/bIEgzPyHivnRh22/uFJptQav1YnehAUVFX5XtIFIA=
Received: from CH0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:610:e5::15)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 08:43:24 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::a2) by CH0PR03CA0250.outlook.office365.com
 (2603:10b6:610:e5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 08:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 08:43:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 02:43:22 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 25 Feb 2025 02:43:16 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH v4 1/3] drm/amd/amdgpu: Increase max rings to enable SDMA page
 ring
Date: Tue, 25 Feb 2025 16:43:13 +0800
Message-ID: <20250225084315.40087-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a59627-09fd-4333-d690-08dd557876ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9JQswAvgydI+R1EF35+hokaJmfTpBszkBX6o+3zaWHRm1HKah1/C1b7IhvK6?=
 =?us-ascii?Q?h9MhWKukwad7P+BuF69b4PzglvLyfe+o7Vdex6PnOzLNQvUFbyXdrxJZi2rI?=
 =?us-ascii?Q?IXkxe8R/O4Gbb9PoDv5znt+4q6PmAbMtvTwyxVqxuUoZqns+IaQBaf3L/48M?=
 =?us-ascii?Q?eHMqYVzlXPROIRPIE9oXAEKD5VdDNoh0rp7m5I5u2kmtv1/DRLjS6ug0Z809?=
 =?us-ascii?Q?fWhTaxdy95uFlOmHdN/vtAQyjaEcZIU1KJFLFeh05gZauvgW0/eB81C9fZoq?=
 =?us-ascii?Q?TdXsSTG7R70QsnNmkMWRCOmY3uYnspa73YWh7JZQwzOu1pzkBtt/k+HfQy0W?=
 =?us-ascii?Q?Dj2aY7IDfGV+yXRE28dD2e19rM4kd+O5J70Nw3txWF+qS7pAQ+22AOqXWyWA?=
 =?us-ascii?Q?VyYMWh4RQHpqkL833tdxQN7Q+Flce+gFrwRiIrRzvs30JKYjJmi8uWHvoExJ?=
 =?us-ascii?Q?YJqWRdmHGIZtWnpSwJeI+8yKK+wuL+3EK7t49vevzHDhP19GuWOQHb5LI5FX?=
 =?us-ascii?Q?GLodXGwjN8uuXzxDzJy5Ita0cHJnbwISfbfAyiLiMk4KTL0IXNUNEDJIXxoj?=
 =?us-ascii?Q?ntwZNauG6yhuBQ1mSqc/Nxb85sExTamT9vqSNJQ4ZffxGREXAbpnJvULnfzN?=
 =?us-ascii?Q?pMF8B9zx4+nX9Fnoi6QQbV8RnmjRBpVU/naUEgHVsD/Awpow57Z8fK2Srxu2?=
 =?us-ascii?Q?cJCutoh5+3c19x2wXda6xt3stu6IhpSEo7DLb6Jfw++30GYaLPCrdPJGkcZc?=
 =?us-ascii?Q?Jk+vPBfF8zKU6kuTx7iok4lDBxYYlQwmbm/IAd+t4vNS4w81IJns+jB5p8XW?=
 =?us-ascii?Q?5MTSz5Y65iBBjferQAlxeQ1iRM+d7DJy1PCO2pZYwRLmnJoup/1g0ZOmbtTj?=
 =?us-ascii?Q?AuNLusAflEiLF4vM1PVj2R6Ddpti2EEuiLQev1/onNYNabFIeLCGQx2Jja++?=
 =?us-ascii?Q?uScL649EtUyP2+T8RINjXqs78AFcwOrqfy0v1Kz1sz9DbsuGTAwkxOwG2FTW?=
 =?us-ascii?Q?O4TWDdwUhFZVJW/NbABR7rMgyaJCcjaUidFJznrnmssZo2nHYml5cQOg/xCf?=
 =?us-ascii?Q?49j1kEq0B32gtmaSRJDBWLKIWL2nDaGhc0tLTQ6FLP5HXbVQ6VYmd+jcXxyD?=
 =?us-ascii?Q?KPxlkWJEshVQ/epHcHH0VWGgkRk5pZby2yzHBKutlkZ97mT/zY+tSONnZUJX?=
 =?us-ascii?Q?G6yIQdYhn5saK5k1YvmLxSyL7nhB6XSk+X/ZJ9sbS+fltoY+x30w7f6INZog?=
 =?us-ascii?Q?ZQ11/cOpWzWCASo7tG2bpjv6KYqzRJKTTdKsAwUgBWzJ6WW5rJV2aE0K+WRG?=
 =?us-ascii?Q?Svd8t2sGGsFirXyRFeOYftaYknJ+4H2sM2F3a7hYKwHAr6KptJ8FaRHLmfTm?=
 =?us-ascii?Q?G7Dy6vsltUz8OSkSx7Hlqn1X9e6XQN3ZHFUVnFxfqxgVgRzvBh9JQmw7cnxw?=
 =?us-ascii?Q?LxNznruqRGB8CQoznuTyrdAXflISht+ldDu5EjIx/ckE06drGF31agtJ5fcE?=
 =?us-ascii?Q?Pze36qQbKirel8k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:43:23.5652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a59627-09fd-4333-d690-08dd557876ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Increase the maximum number of rings supported by the AMDGPU driver from 132 to 148.
This change is necessary to enable support for the SDMA page ring.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 52f7a9a79e7b..4224f8fa1614 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		132
+#define AMDGPU_MAX_RINGS		148
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.25.1

