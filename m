Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0182AC19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 03:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D7110E07F;
	Wed,  5 Mar 2025 03:25:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Kh0C7mL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1195210E07F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 03:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGyH3shV5qoFzeev/YBPB5Lzt0tIBv/RQl38bBeMXu3UqvB2EqRz19PjlP5pJOOMqUTqTd0ca4UweF9ll1crulkLcxxKsq087ckfXoIvNv8SWDCNV08zkuLmMjPvj/EODUN6BcuprqXnMrbsvr7rTmK3lacLGnT+M/Ih8A6LXmwiwNLBZFgwakFHZHFLfTCUBznsd198Sq8QO8qrafU1inUJ444BoBkUtmttgSkzyB5FIYJzbRUbwIEHpnooEo6FS6ZxzJreNtJuxJRv5rBSlWEu2DVD/x0qH9A5yKb0f/otDepcs2M1ytm3ZQ3/IOZyCVeArgkCjmDE234c3KHq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4XIsLcNViRrN6l1IdRgXReVzAG9ujYjIaufZuCcL6w=;
 b=FoNt0p6pFvWy7uaqyU+KpXM4bgtnZNhAr9fiUwgZkOTMd8vH9XR4uDPlw4g1tRCGrGJi9our0w6epLeMuriEgAUVNSGccZbR2zutrUUIWnCD5qM6eIdqZAnQzi6V4HmmXiqP9bgb2a2q5kiwGR5WpeM1wIy6IChEwzW+pHNElX3aG/+rJoj0DaNdbyyIfHCyY2QqMhr2AORocRbndaYbTgqaEpC25zQrwKLTMU8H8jcetC88UuoTLbyXjRm54ChpbAu28YMMV/xX4gGe8uajxFyHnOVWUGdAIZ6l6dUDV+mWh9E3RR2YLRo6f+QdIfAS8Y8svgi1cymM1ThVwg/Auw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4XIsLcNViRrN6l1IdRgXReVzAG9ujYjIaufZuCcL6w=;
 b=4Kh0C7mLd1WTTchbhesByoJbPD+SryOwROQD9Hk+pcX48wzsbxxV7mY4G967R23dFrNZLwsAmzY5iXOtuppq7z+rMybn7E+rJEl2PZlBHm2Ciu83PKYxsBvLZ+Ta6l90A4nKZ4vuf0uxek6JEgW9rflEhzT6Cq6XgaNOsFN7O2g=
Received: from BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45) by
 SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 03:25:29 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::d4) by BYAPR01CA0068.outlook.office365.com
 (2603:10b6:a03:94::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 03:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 03:25:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 21:25:28 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 4 Mar 2025 21:25:21 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, <jiadong.zhu@amd.com>,
 "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v7 1/3] drm/amd/amdgpu: Increase max rings to enable SDMA page
 ring
Date: Wed, 5 Mar 2025 11:25:18 +0800
Message-ID: <20250305032520.1745117-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 7451d156-51a1-4232-e640-08dd5b95610d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g/X1AAf4wB9rPtYDVs20FIzssdkv0RVz1h1khZjzo8mgNjN2GChbPTnPIb3m?=
 =?us-ascii?Q?b6+aaqf/3Nr5igVugpVT2airkx1HoJRbkhUYx+zOQxoWEaT3MNvXw/YVyWLz?=
 =?us-ascii?Q?9R6rvj4RQ4P2GPt9GSdFy4pud31q795OsNswJFjh5oztHvEsmISGtKosMh06?=
 =?us-ascii?Q?M8X0OIhYBue0q6nxli1SRHjvNPeoqi1iDtH58U51PyiWTGV8/ut+z1cfJwtN?=
 =?us-ascii?Q?lH7KtoDNlbX2/0dfrMYF0E3rIlWViuOkv8CvA8LWk3qaKQMoQSbj+BjHoQAL?=
 =?us-ascii?Q?ilEfHHmgquyvkr63dnvy6G+4y0x6u7r7dQSks73IDH9WWlPtXAJ+KTIrgh3W?=
 =?us-ascii?Q?S6A8GW9ziJ+vWwZjd0jGJwhSGLS0V69NXkwJrlW6q60Wgy4DQC2mLkl0RI7s?=
 =?us-ascii?Q?ZQEshviuNaQzajaT39tSlUjQrzuKDnwVGbCSbhTJye9P1h6Imea2tR96EOAE?=
 =?us-ascii?Q?XHrzJQihUySBwYWk45m7oyc1GIG8DSLywEyHHjIDkotFasN6kXR5aERrpTaM?=
 =?us-ascii?Q?/F5w4IK8A6537wBD/pUwBGKXSdgqXL0DT7ZwDdQCpEAoRaMmfyZTtfGUKA0Y?=
 =?us-ascii?Q?uNvRhRSQVroKKzhmtrPivuJkzveoxmsDfVfdukFnetzkiSDcNbzep0EusofY?=
 =?us-ascii?Q?7y5Ev3gZ4pjP4tFris3tnan5su8PaIqfijwkeoxuVNXYv9oyxkSl5jggcYMt?=
 =?us-ascii?Q?t5+LCcceyXEWhO3VbVIXKxrfzItJ+5F7XUbbRfEd1vRgpdCmGfr3ckHa8PD/?=
 =?us-ascii?Q?fjfM78/ogxWTP0pKLF3wx90IeOkGICVW3lsZ33gW0xwThf1P67P0GhBMdKdD?=
 =?us-ascii?Q?A4RjUI7oMQ3WBS5UkFntLl74UyHd9PZxVg9TldC5zUjj3QNNbbq3NMlDHE2m?=
 =?us-ascii?Q?+Q5xuIQ0Q8qexGD4YDDgvD197iiGOWT3s3KbcM7LsE/j0ASM0bD9Giu0igVL?=
 =?us-ascii?Q?jWQCZzuscv9bFXQwU0lxyZxC1ww/rqrc3fFVv+Uw7hdH7zNfa19RVFZDkApI?=
 =?us-ascii?Q?qN0f75dAWP6X/G6FrXT1c8Ee1l3e4EHsDfJ6hxLAhcLiaKB3sEApxfJrAQr3?=
 =?us-ascii?Q?zDHZHAkbt+WZcO9mW0/Wu+cgNM7U9ZitiCu/gn8d9KQJn5i+SMmXba2BY69A?=
 =?us-ascii?Q?ge0MzmwwWsXGYewKD3+gy3OvJO2OG9E2IBssztE1WPAhxFQ/q1FwUjUDzp/M?=
 =?us-ascii?Q?o83g2uTCnntSgnyrkf188Zmm/R7vFuXH38NObC5IWQV7k7tVM2ptKLgJ1nSH?=
 =?us-ascii?Q?hoFFsM0HiotWOp6Y+TvLlFonzMTuVB5KyvzmNq/C8I5V73Vx+3z99VwTEChR?=
 =?us-ascii?Q?tqYxQEuQsUBCkLYr76VwLIae6sW/WwMVoEQ52eJcO2q5f6LaQ3eEeSymfEiV?=
 =?us-ascii?Q?9WmgSH7RDRUZNjQzaw6iQQevpBcAO69rys+MXuxaZqXM1vOpqghvMN43DlYK?=
 =?us-ascii?Q?W8P3jQMDGCn3N0U2QFa6keAmx3rnRBadO6CU+Aar/4wBZmUSV+hGMJmQ1N7F?=
 =?us-ascii?Q?8rgCH863/l0/SDE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:25:29.1315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7451d156-51a1-4232-e640-08dd5b95610d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
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

Increase the maximum number of rings supported by the AMDGPU driver from 133 to 149.
This change is necessary to enable support for the SDMA page ring.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b4fd1e17205e..bb2b66385223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		133
+#define AMDGPU_MAX_RINGS		149
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.25.1

