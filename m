Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80E3C3600E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 17:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C45210E768;
	Wed, 26 Mar 2025 17:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T5pKAUy1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC81E10E768
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 17:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLrCkrQy/QRjEMIZabblORURiTASV2O7xkJBTafwzZddGXNCZvB9d6nFo5Pu8Im7/+Q2P8D8uvwMPKlth/0lAlKFSbos+ra9Q3Fmxi6Mtg5XQQ/fldEwsSWIW27v3tIIJ0LkzHl7VbGT8URvlZeMqKyTZcqh0V665WvGIK5O/bl5I5ZYd4AOoa8exNDwe2h6tdfrzowuDJ0RTB1JCJljE+VLJDkame3ZOjv9I3ZT+q5E4lTN2cEdwNkU9IMwiooSW9NEEm4Kw+QPLBNGmFBTRKc7cfAVTn3U1DYhXefjAQlaB/FsC92dXgXkBHJ4+lQL4AkyzCIsAqHUaE+ZVCO8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/+9PLrKKTXzacnsdK6zTm3SQD+H4t9Iv08k43VLj80=;
 b=uYVmg0UoZy6k1T7PZ2rIqOPj2LdLkgUU7kFrhFRgy0zeYZb5pFbChiFXJZZIWEP/AbwzMdtMVYyBBDfwpEUslEAzQblEFdExy8FJbPNScgKNteoZSnWZ6Qz9V+t/4mw/8nv006Gnk4z7wBtpdhQrDPjW6xLumEVykcIeGbT3tBzMqTs4xno+Du9vA09J2UNA47ewgMxQ64ocHVS5YC4Hsp8GufoT3YwBnWEKZuGAq4WDtnQJKPXHweKOc7PUWSyVQQRAUjvfzvk6z+ktbiGVxJ2IxdE+1+oOrJxrRSv6Uuq82Wy53HWq5lshMamVrblkJqOzCUJSdgHkMnpMK28vCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/+9PLrKKTXzacnsdK6zTm3SQD+H4t9Iv08k43VLj80=;
 b=T5pKAUy1xY3fswuh9wYeTqOczqpveJw0GuUWAY1tYS6Ta4+n1TXGSvC4f3jApRDp8TT4NgOgFR+snXNGj/b48LGRvrIMlfxdErhvLUE2OkQFD9+riVIwYxfF7dAc7uChg1OSm6U1OlpjeO6hpMXrdRi+cakSKKGk5DdB6Mbxkqs=
Received: from PH0PR07CA0107.namprd07.prod.outlook.com (2603:10b6:510:4::22)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Wed, 26 Mar 2025 17:51:36 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::8a) by PH0PR07CA0107.outlook.office365.com
 (2603:10b6:510:4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 17:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 17:51:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 12:51:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] Documentation: update KIQ documentation
Date: Wed, 26 Mar 2025 13:51:21 -0400
Message-ID: <20250326175122.1209403-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b52ece-efb7-4b3d-8434-08dd6c8eda3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wBGa7pWhoNasOFWAP5rJBg6t6QWGoN3UIzKmy47Fu6FmkvJem/cYfdFHV+/e?=
 =?us-ascii?Q?lWQTs36guIYsXIwNmKBju0LpA4lpYDv/kYpAfVu+a+XX6bAdUvwCZzzSdVP6?=
 =?us-ascii?Q?w1p+IEdm8rlgzTZxl9EMoRStkrnCpxGphLhYffk7INa+5hLkNafj/1Tlz7UJ?=
 =?us-ascii?Q?bVqyRYEE6U8Y/HwSBIErYc70mAox3TGl59vaEcntNKWMHxOgPvZdOOYjWW8D?=
 =?us-ascii?Q?Se5Pvux4EJcaJpoHBnQJI0sPWXHVVU5kL9dXL3+35zMCGW5VUS+KL1NQG//7?=
 =?us-ascii?Q?lwkuHeAImyoHUgx4TmZLbuFXEWwpOryos7jAkgSggDkqCMjh1BB74D2umkKZ?=
 =?us-ascii?Q?YVc5aesM9ymLa6/d/U7SRvGoG1GdajhDxJDlmWT7S3oMgGNZYy4Q9yd+Hhd9?=
 =?us-ascii?Q?HTH5l+Z3a5tdANlts7qT//i+IgVEXn54HKhLqTvAjRSF+KeEo5dYpvrC0FIX?=
 =?us-ascii?Q?DjPG5rsHXqIM/VRYumVC6Kh+HzYQ0TV7U+y0/kXdzlW1igW26cnRgGzEWtjf?=
 =?us-ascii?Q?cBOOgjMGBYCCREs58Uqdv1TnNe82FeCpy1ITP4ff5SBf6pmaT+BfvCprgZcA?=
 =?us-ascii?Q?bKK94eTwn9MyjsONFfqJML9EFXrT8jYkg/etAhGNMDPsWmwS2ei01p/QEnI1?=
 =?us-ascii?Q?gZnXMpseTXMVf6H1FbZz9LT9vEESd1nUbceqFjzCZPfJ+zk2c4/SX7NJ+b+b?=
 =?us-ascii?Q?2eP7e0LkGGaS6AcKDv0nNkkO/SUIr1bjo2XEbMB3POsyRdMKe/xhUxDLJAl3?=
 =?us-ascii?Q?+NxdKwFDIoGtJEKRdveNf3/FUS2syPHjq4LQsFuAysIwE90wbEFw6q3m/cGW?=
 =?us-ascii?Q?0hv56qJCbn9Io4byaYeRQdo88iJKSqYa3UuG5Tx3jvZfVaN+QJW+bXRq9qit?=
 =?us-ascii?Q?BfIEQR0i7ISn/vEJ9DofmbheJA7tGJBLg1eW0sZv8wcOcpXtM9j67X2erqhF?=
 =?us-ascii?Q?d7vTxKAzL5xxXh0l6D6aSZmvEtn6pWLcFozcKAahrxYD/7M8HpyC3mCyaSx5?=
 =?us-ascii?Q?n0et6bcGS7gHsUbshsf/GnsoXtaijaKDBzvwkBdFVayK/O35crKfFc0jb30L?=
 =?us-ascii?Q?LaLmG5z5XkjGbjY03+zfT3yAohU9/l7cFlDAZl/wZz4q96tEBauQwZ1vyY94?=
 =?us-ascii?Q?X7BjVWe4cKjOte5DHUVgNDZ3GsVF9Zga9uB/F26Z8QZ0gjN9JwS04MOlyx5Z?=
 =?us-ascii?Q?PMsYAN5E4sNylQwiOeyXwhP/7yhF2i1ZUD2kUDPGJM36yYPHUSRO8ktwJQrI?=
 =?us-ascii?Q?kchZrFfO7ZDH6qTG+BV0AtETWLZjJLd4yZAQ2VAVGuNTkWppMJRPt4cNrscI?=
 =?us-ascii?Q?ZjYOp1EYY3yl5D6/TUjuZjZwz2KtXWQa+ejfKMVIRto76E1OeP6Niig/tPQH?=
 =?us-ascii?Q?EnXj7HaVZsTwWMa10XbO2ZtXlcGk/bGA7+VpX0gY9AtFDnuDCOrodJNJNPlb?=
 =?us-ascii?Q?Q4Uv8mUzLstLM9yxNnPcDRl8rPaw0byaarCr2s6Fa+ozmoGdFNQzRiT6HHgZ?=
 =?us-ascii?Q?bIDEqRRN0qgyX0g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 17:51:35.6624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b52ece-efb7-4b3d-8434-08dd6c8eda3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
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

KIQ is replaced with MES on GFX 11 and newer.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/driver-core.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
index 7e3f5d1e9aaf4..81256318e93cf 100644
--- a/Documentation/gpu/amdgpu/driver-core.rst
+++ b/Documentation/gpu/amdgpu/driver-core.rst
@@ -140,7 +140,8 @@ Some useful constructs:
 KIQ (Kernel Interface Queue)
     This is a control queue used by the kernel driver to manage other gfx
     and compute queues on the GFX/compute engine.  You can use it to
-    map/unmap additional queues, etc.
+    map/unmap additional queues, etc.  This is replaced by MES on
+    GFX 11 and newer hardware.
 
 IB (Indirect Buffer)
     A command buffer for a particular engine.  Rather than writing
-- 
2.49.0

