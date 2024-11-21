Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED9BD6ED29
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B077C10E92D;
	Thu, 21 Nov 2024 13:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LEcfj6/D";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2AF10E92D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/QNARUgGfucQ/5X70Gc3IqTOrpXZ9WtwLe2tv18vgEy1W0EI1TbnS8H0ZZLaWOCV8xmjt6KaINTrZmU5YjUdcai3yk5U/ydeiOjpJwdZaUeS7qJ0U3wylFYk91JeO7PvrrkmLY/Bsjx+sy6sg7rZ0VR1uuLUhR1Pdh/qkk7TXeHmq2tYo0pHI9V1XrzqVGYJFfSp22s1saCYDp81TFRgMEshxui2gseELlTZLcqXQ4fUsVhall92rb+e9eLnY96Ycgp7Azl5pi51Xd+uZeQKmiFqgcUSjueUAL1IFPvzjRB+aHbKEjZ4n45ajZb20zznaXhdQbphMgdilGlC8U+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yc2XFMhdNNEW0MWXxWmBV7RyeM2Ii9JO9ica/IFVYE=;
 b=mSnoNfEm82aO+UkWTn6glCAEcwZI9c6Wyx0KaENgGPsPNwDMXk9E7cVOzZpBCni2wAYhy6/ree4aQ26pR3ErCiRXyCuosfv0iTcrDiILpsmam4RTlxmXk1RdE4qT49CrIdtUMQzx+u6CWrz/yGo3jvoGO/i8GHxnWitQYy/gzYMzTYaZ2w3aJNdf1TNYt2LKweM8gsclUAgD2YW2sQhEiXTInqwFMwaMKUTCNMwj1TYRgirpziU0o+kUyHKYF/s/uNynMGVAxLpSmFr80l+qJMHoj/aUgHTzEoHz+gyaTo03bGviavjtLtc2w7S+boQ6Z0znfTsRXUYcvrLIOoOngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yc2XFMhdNNEW0MWXxWmBV7RyeM2Ii9JO9ica/IFVYE=;
 b=LEcfj6/Dka5cKBgRqKwub6dSlxw3RqzIBPy7pFi0Ao/Tq+dDpALnnk4b2WcGka3BmQ1Mubl+8t3lKct5wMwXl/xwP0UNpfioBKTGlIYRpvMj+mY8d0AYa+s6GpbhJy+1jHu6jseCE0zhNZJKLf4Kv+YC92yuYQpRSpDrhK6N8BQ=
Received: from SJ0PR13CA0212.namprd13.prod.outlook.com (2603:10b6:a03:2c1::7)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 13:11:26 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::63) by SJ0PR13CA0212.outlook.office365.com
 (2603:10b6:a03:2c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14 via Frontend
 Transport; Thu, 21 Nov 2024 13:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:11:25 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:11:22 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH 2/9] drm/amdgpu/gfx11: update mqd init for UQ
Date: Thu, 21 Nov 2024 14:10:48 +0100
Message-ID: <20241121131055.535-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121131055.535-1-shashank.sharma@amd.com>
References: <20241121131055.535-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f62302-8f0e-43b1-9d8e-08dd0a2e00ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gCOvQJNL3Xh6k1yUQrQAU99DXiUmqHFYmgibRoIIFRQUhG0pOaSRhVfrmRf/?=
 =?us-ascii?Q?vRAvgxY0emS8yXTAX8C0Vs1WwBLpO0x21x6wtID1ZODzkK+mtz0nKDEaGdVr?=
 =?us-ascii?Q?5+Fi495r++UJpKH9DRgad89yJvvluPRXL+skA+EOfL4HK0/o453OruSPrHuB?=
 =?us-ascii?Q?jgM1l3OfDcQt7SXmV2Y+8zNImGYBm/9+XJYqZPzqlFUAF9WowmsbNdro3/4Q?=
 =?us-ascii?Q?1NVV5j1LyGRC5algB0pHaFR+vx5GLDy/awK4DdTLhn7A/tP7r9zKiOtLHJSv?=
 =?us-ascii?Q?4qQScbDh3qYSu0N1xPGKQSdNb2hwsVbLaDtSMbHrhtwmGD8ASW8nW1R22y5g?=
 =?us-ascii?Q?u0WygBTxfEPUzl4K7uX+r+wKOSei9hCaaq9/AugBe4WNcu47rFej2YAyrWYs?=
 =?us-ascii?Q?J/X19YE2ghu/+46OT8eFve+6TpvkAsqF9kWfAj2keFJhfpTY8NSHYiu0UL/G?=
 =?us-ascii?Q?acxh7iLtZ0r9WktOuC3tsfJt0wF556M0Mc23RGhnXb0rXMynAmuc8USFy1JO?=
 =?us-ascii?Q?jH1I1exaPzSDyttfqTJA/6vB15lrQav4gffgL0wxTc6BSy0z0+4wzrR6vZUt?=
 =?us-ascii?Q?/8lroejuawfGYzDVnEZMadS1/sjEgQ0q39nV0XfKqqqO4WcznGDAAdjsr7cs?=
 =?us-ascii?Q?rTMF78Z7Tc299ZtGYRR/x10QNB+vsJsrwGcdX577AMbdBPyT0nboi5n1chyc?=
 =?us-ascii?Q?9EtFZkuNoBLXFhxtZHIkp7L47WwBMEUj0My2am8UUFwPtV17KrJ1pg/vTF8y?=
 =?us-ascii?Q?EGEFJidsHvCR+x1kDVfMKvueh9Hrw5QblG6CpT8lRzT8H5yba2t3XeehuwU2?=
 =?us-ascii?Q?L6edwGY++g7PaC2QuaHMPauyhKIhRWQz2cMqGxRL+/dPo95tsgmnMfROreQa?=
 =?us-ascii?Q?RRBHTWCtGiHc+xhxAuth9xoSj5K/iWNJ3NnzLvyi8Fc0QcgwtvPfOMBPbrqe?=
 =?us-ascii?Q?l99Kyk1nqnk3iXqwLul9k0neeBEjHhI5Yxy5nWXiE5lLQvtl0gQvdTBWvMx5?=
 =?us-ascii?Q?acftTJba6epWCnwJm0HRb8PFyQ4VrRLWfWPqzhbntoogi6B+NZjK3YZlolZ4?=
 =?us-ascii?Q?H6bimw+dQ0CZt3ecYttpoqz8ST8sBLTOU70wNTRUoB8sMtjzcVZCiaqLh01C?=
 =?us-ascii?Q?mvQQ9qJPZm83wTvQd5wsBLFbKK+QZ7XV6KaqG7wjN8T++0+FA5Ke6Zszai8c?=
 =?us-ascii?Q?71vccYMgMCiRLtb4k9a/KjclqLOEcDUKTTH7uD4SBdAEKVpoFcJgvqXKQ7dj?=
 =?us-ascii?Q?VmaEfYDrj20d50DmzcBhWqexMQc/GboGIupwNA5QxLBTaYsim10ZZbrbzshx?=
 =?us-ascii?Q?qTHo+hE0+M1DGRNfbK08epspqJfZqHgz6+hiMQVVEjCF/XnB96KsaJ7rnGUH?=
 =?us-ascii?Q?yEvkCX7H4z2CPWsZL+Jy0P5eEApnmykSVn4/KXGY+ZGP5VNVtg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:11:25.0754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f62302-8f0e-43b1-9d8e-08dd0a2e00ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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

From: Alex Deucher <alexander.deucher@amd.com>

Set the addresses for the UQ metadata.

V2: Fix lower address (Shashank)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 19851cbc00fd..5b9005e39b92 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4051,6 +4051,14 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
 
+	/* set gfx UQ items */
+	mqd->shadow_base_lo = prop->shadow_addr & 0xFFFFFFFC;;
+	mqd->shadow_base_hi = upper_32_bits(prop->shadow_addr);
+	mqd->gds_bkup_base_lo = prop->gds_bkup_addr & 0xFFFFFFFC;
+	mqd->gds_bkup_base_hi = upper_32_bits(prop->gds_bkup_addr);
+	mqd->fw_work_area_base_lo = prop->csa_addr & 0xFFFFFFFC;
+	mqd->fw_work_area_base_hi = upper_32_bits(prop->csa_addr);
+
 	return 0;
 }
 
-- 
2.46.2

