Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3B8C28B25
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 366F910E74E;
	Thu,  6 Mar 2025 18:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a8Jp+OdZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9D710E74E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aM1GYtryhKaDRJmd/PUZiNyzjxYRMUlvgJ7oWmWgzpgKgrmGtwt53ksDOdSafbeaVYFc5fdNp+YlEOgGWP8eNCCDc+wSrvpezw68+7kp5C7VmPswtvjoaobPFHyYW9p7ybtes9rApN37y9rOzSTJDKEVyxfk0ASAyVUaHHyTk1XhReTItVCQUOimPEKOSog5AnFJGqAnkVu931R2dFXK4rWH/7MADLnKGq852PP3EHJCq8C/t14VbKCLio7lfSEwDjznfRRWpey9zN6JvQxWsFpguGRgVkwKNAYFFFMqMpM/zAbKhgkaIb/XPxdD/IzEEoueUi81kkQ7NuFMNyHt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72izItD0xrYAlFZ23XBHojUIWl3kzHYqmSCZ3S9AEo4=;
 b=HDIwJB4aqWoGxQiSegKWmCUDXcWs7l3S6RE882iga4z5ojYd8xQImkgMgwqVNRBCu+nruTvsoJhiK3qQEKtxm/lDwnP3mq5jGvJ+bz7tmPqhrBjwgSP2cs4gS1ds5dn6T4aOCqMaV3wAQ5zPxp5k0kPYlB4g/FzWgvJAoUyKML1Iofw7Bj+cCaf7DmUBME20lYQsJS5MSkDVR6CQWyn+KSe4fupG9hdk/Ud6KkIQtgGE0lo3AN5fin/XD7GsCG5ET6oU3CZ0VtBQ/8AtXk7FVfSx5PO6cfIi0nwVv0sDF6sloyNQWhS/2bKqiVrE63SDSoXNcUL2rj555dsWwAyV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72izItD0xrYAlFZ23XBHojUIWl3kzHYqmSCZ3S9AEo4=;
 b=a8Jp+OdZHQVgUYqoGwMVKevwduMRRSFYw9rQODeHHIiOGwxk7h6qYAFAIjqrRvXyKhjA8OOyYU5KVmJeQBKesAoDpnpj+XL8FNxsDiivxIOP66PnKjVO0GTKwbd9uLh7KMmSTWDedLMW9hCOiBRf+43ZFDTKj30QnNFAvb4+3TU=
Received: from MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21) by
 LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 18:46:30 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::c6) by MN2PR01CA0052.outlook.office365.com
 (2603:10b6:208:23f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 18:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
Date: Thu, 6 Mar 2025 13:46:03 -0500
Message-ID: <20250306184612.8910-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306184612.8910-1-alexander.deucher@amd.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: ae617a74-678f-4a6a-30e9-08dd5cdf3596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N8fSNX/hpbqZzzqEZ3jxNZ/UVyXUTxm3+PpwGo/isGVOUtzztrLJzpAgDu/t?=
 =?us-ascii?Q?scvC7k4Ay5xb0fs2w/QoY7+nlzcee9wq3fiLVdHSW1vb0G78cc84a44rouEb?=
 =?us-ascii?Q?wkp0T2VPs7BGV44OlDPZhGhb5tDPP0iswPYVFs60GidqUzUc8Ni53BUEkS8S?=
 =?us-ascii?Q?f6QcRh6lbzEkv3odTKE6u/tQd7wipBgBCpYwjv/swvpKFRps2Q58oVPGJOKX?=
 =?us-ascii?Q?qpvKb/LypLRj8F7Kj0Wi47La9GUknljLvx4BXUbUiQn/jkRccIE/o136LxLZ?=
 =?us-ascii?Q?2D1Thh0GsMKVI4QEa4g5/aChrHcmer/9QtajwfZeysFuSrWg7RpKoCLNdkAc?=
 =?us-ascii?Q?03ozZbUCtX/kA2JfALS1Sl9l/52mX/4+H3Z3J3dCbVXVUSnmJdJSNoaVRRaK?=
 =?us-ascii?Q?xWetwMbZaWJyRiWGrYvP8ALGlPmiOKHDF1/bdG46oJlRQ2bj7rnhqHwqIUUD?=
 =?us-ascii?Q?FPZpvwyEIz7ovFjOV5gKbHIhSZn7RcxrsqW3j4nbnZgYuOr1o4+UzoFou6MC?=
 =?us-ascii?Q?pPZ5GJ734GZbfINwqTIeLpDYFZK0oIX7z3/gq1gAJRrAJzl2wZSzEf6EJ+QV?=
 =?us-ascii?Q?pHlP9dbcQVsE+MQ2LO+Hktq0tdnXalrQKFmEwSRjZ6u9KGzrOoMtslZqV2ii?=
 =?us-ascii?Q?kiDRCf9smDM0d9Vg99fzq6+GoyvGlDP7tP92GnWSw+aIZbJGWcg72RlvW3uY?=
 =?us-ascii?Q?ph1u+UuCCYOBCcXuD2W2zWhhnAG7oN1w0P9O6r7MoZ6bJHApOIBxq1ELtFjk?=
 =?us-ascii?Q?6bekpuKZgIATClJDiqHgZ3hcIb93feTgIMztsvAqhZlpD/uYoz6swkbIxKT1?=
 =?us-ascii?Q?muCHu5aecJkVkMZnLq3Jajs2veiixAFZ7JEvzNdoW9vziPfdnLGQLgULuovg?=
 =?us-ascii?Q?JEci1csqUGSsrh/Ka/p6cUC6eW5WCgXBkSP8NyTZHgsvwBXXNQNMGFB6tNC1?=
 =?us-ascii?Q?IhKrhOKMP1k39xX8/2MsP+2639UL7I8zrd/WEA1ix/gF52IkJqovB0KPm3n3?=
 =?us-ascii?Q?ZJbvoD/6B39DN4VFiqafQQ6Kt29YG5u9NJxfOzFCy29kPwUhMei+2ydJlrPM?=
 =?us-ascii?Q?VgSUdPSvK+eU9jTJYAmadmP2IQbKWPBHKUzK+Q84oPRUdYtt0UNjjeprRAMz?=
 =?us-ascii?Q?BzB5SggMqfUgNjj7lvGuqZyI5AeXXZHjF3ACFdIyEXo9UkR1GL15ZdPiwIIq?=
 =?us-ascii?Q?f90zetmMO7NT4favLXah8MTQEx66GKJvhKMHwXLRz4mDShFew/XydJsXHXZn?=
 =?us-ascii?Q?j9mSKhlaCY1y3C0xCJ3jHwc6StC0YLkaRBt+IGTHmbK4a2wUvVseOBvUHTeP?=
 =?us-ascii?Q?S9gX2Hl/TFPqDfwY6Qp2Kx1KYXEWwziNSyZlD+T5G1Zy0kGBhE/TDX9OAt2k?=
 =?us-ascii?Q?tx89Dkveo6l016ZMTNmV0oeovQC29vgp1FyP2ADOGhu9Z6cUVUhQs13W4P/E?=
 =?us-ascii?Q?BOq3VsR5koeGbtPYcLZjAOWtO6PUI3xkdp3h33+w4eEglc8LNxxWe8m0KU0W?=
 =?us-ascii?Q?5MGXgUNg9ssxUzw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:30.2351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae617a74-678f-4a6a-30e9-08dd5cdf3596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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

Add proper checks for disable_kq functionality in
gfx helper functions.  Add special logic for families
that require the clear state setup.

v2: use ring count as per Felix suggestion

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a194bf3347cbc..4083b4d0595a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1544,6 +1544,9 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
+	if (adev->gfx.disable_kq)
+		return -ENOTSUPP;
+
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ddf4533614bac..8fa68a4ac34f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -483,6 +483,8 @@ struct amdgpu_gfx {
 
 	atomic_t			total_submission_cnt;
 	struct delayed_work		idle_work;
+
+	bool				disable_kq;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
-- 
2.48.1

