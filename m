Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECCBCAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 17:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB8010E3D4;
	Thu, 11 Sep 2025 17:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gdI8ODg/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4330210E3B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 17:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+GpnYEsITlJCWB6iF62PmFANauaeturuj530h7ehCNwDdeKnsmvFLccWEz5IyVqp6PoEeKDepJwLvnEtuJRjGHr8jYU5wU1VmILJjyQjVl4lAUm18xWNDm+Y0j5MD7YvzUUocUZGj1av8hicSF1RhNgRWwzVoqvpBwwJXvSFlon8I7EXj7BRvdHK//b4QbvS1m0quCnAPf02wGQhe/zV5FGwPPv12f3hoTeNHf4/aO/Q13tekgpNt0n6OC8CAY4tKKk25AU9aNC7Gl4CjNDzD3VbqCNROOOLYKerAufQkM4th+uxUWeC7NmmH6Y6Rk5Coe7+42fC0wCY9tw4RCOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpgM45ajqApsQnVSiR3QCHMoceYa0UtyMI62NIaVzCE=;
 b=f/pfdMWPSN/UsBN3qAadEZB9CvOpG1Rud/SO1zpmEL50nKsIojHrRuT5QdIfHgaZIb6KZPOG0/Hi/u9HPjXvIofu6GMYw+1xPyosddQqYcWuxatAff2QTE8seYVeN1Jm65Y5GEH0KLovTUX7edqeHfEuRhYd6d8nVxVH+/Jsq0XCG9Ef9WQo31tWrq1xg0zce04AjHZ8YPjyqvoZdKd1dZH+WTsmUDMhUXwRJhBegbKbJ3G9qwTbFzBGMK+oh3QAZJ3SeV6w2d9/CKQv88Igi+gz7idf0ADDJXU0P1LaNXxz07b0GQmKA7+xiD8saoZS0Z3hVq0mWIgf1313nCXfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpgM45ajqApsQnVSiR3QCHMoceYa0UtyMI62NIaVzCE=;
 b=gdI8ODg/Mpg8d+v1eaBD+W5i7DUdJ8o/dcfBXQQoXh3dQ5f0nymE70qNU/PHhA93akys177FDNMQjI103GraGFOl3vjCtDI+kzOINja4uNHuM/tWdi4uPvvPAwDpF0lsEbRDf6rTva6eO4nzFwqfcIqvmrxyhd2dIe2GdQApkFM=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:25:16 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::7b) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.24 via Frontend Transport; Thu,
 11 Sep 2025 17:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 17:25:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 10:25:05 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/sdma4.0: adjust SDMA limits
Date: Thu, 11 Sep 2025 13:24:45 -0400
Message-ID: <20250911172449.3340848-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5e25bd-2f89-4f85-e31c-08ddf1582bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yCeCuJvLCVYZlGidoSkOXrMNw+LOVG45yLgooB/SR8IwDhAIgS3Pq68BYG8u?=
 =?us-ascii?Q?zM1UCx+BrJ++Kk0toRSKNDP8HBbtsi41Je0dzPytsMA4OYl8MdRh7mXPx4JH?=
 =?us-ascii?Q?v/Vtr40Zxh58PiA4yIzRKjC824QvqFQeKa7kog4wz0EMLGMCEMBNVnujHkMR?=
 =?us-ascii?Q?GCjm39FSh9DHxVsXsN5kddIjoUisjkeVMHA7fW8iz3nQgb+n9gS+qvoRPPwO?=
 =?us-ascii?Q?+JTulWTaB6IRP2QSZiEgis+pvzUoiB2Mw5ZgC6xs+NHFccleHm0wY6DEVnBu?=
 =?us-ascii?Q?ETRTefzkLabXTVnTPGo5Cnslna/xABhT5kNA7RbvfBgwF5TC8VnSx6rW8K0O?=
 =?us-ascii?Q?rHW6CVcOGiskn/Oib0W/LYVDP5ZBJQs8UDIj8A9to7TZo8lFmAdai8GhYOwa?=
 =?us-ascii?Q?gdCls9G2qPHdeV30PXQH2MSNs4xRVH1PihhmZUh/Fo0K/dLOnir2gVqR7P8R?=
 =?us-ascii?Q?RplQ9pt6dI1SOrfCWlOFc4AYdINCON70U9HoT4ZgV3DWlDWVFR3FRL3kf7YO?=
 =?us-ascii?Q?UxSoJCqANdVpBMNLAFyq7a83tZL0DJsPvb71UE+nn7UfLhqAmxd72dk7DvZV?=
 =?us-ascii?Q?LwEkX6vzyRIdPNVO77C6dsLtsGeitdBVuso8kP/3h+V3N3xsBCHeGH1HWnVf?=
 =?us-ascii?Q?HrVoDqxkHXuwELD5xvOFCTgp9YSnEeZ100s9tmMQ/p1QkiYwLvDGkbHhBx5U?=
 =?us-ascii?Q?JHFWYXC6Tikx0x6zh4QQB3kLP6EzyWR+AjRbfIPLQYPFkIPm2nG3zD8CZVWE?=
 =?us-ascii?Q?54lxvqwV1B3aXtVEacwQ7+cOETVjkC+k9dh//Tg7lehKZYzSHQanURwJ6ZA4?=
 =?us-ascii?Q?OzvYXjfLb+HFnCt2n5B2/vNuaGJNAIPmbKPskQEzGgo3F2jnG7HHAsupvqI9?=
 =?us-ascii?Q?OyK635SiI+fD5uEMTS39UVZjxug05ic/9QS2b1htGrfPGsTCBGgMX14sEoCC?=
 =?us-ascii?Q?UofQlUnSwGB0gfhsmuDxA0G2xcB1wcstCp9M600EqKzA7sYNDnzntHbRWkct?=
 =?us-ascii?Q?ZhN+3hXn6cylaHxk9D+iJeO9oKdLXioJ6nlNEiw7tyIwtNgE957YIJ6w0HQk?=
 =?us-ascii?Q?2ytwEDEhYV+ESm+aU2fvkPP2kJ4rXRfSj0NcQcxHqJeYda62Gs/njU6QeH1n?=
 =?us-ascii?Q?LXmKpmghAoU/+BkuXC2xoy7nzSUT02XDZ2rexvxlMzk1CpOYbpznklHV2G65?=
 =?us-ascii?Q?A2asBupVmIDxeZsZkbBFsO5cMmkffj7HENLLasratXv1v3rRUwhKFK0Kab78?=
 =?us-ascii?Q?hMr05egVXM9h6Y+aVM4ZR4Y1DoafqZT8se5T2RyO5E+W75xbEDtiEPbT4kY9?=
 =?us-ascii?Q?gslvUBxF1mishI0n3tBRp5GRYWqekL+KvhlVyF6o3sxi6+8ONK/1KGpsm5Mj?=
 =?us-ascii?Q?/I1Jzvjq6DNA2fV9rIuBAQVOnttB0dgrlA4K9UX5V+qltEqCp1Eqc01q/jmJ?=
 =?us-ascii?Q?3TEce4yiByT3pwisM3LIHBmrpY0y1rJydp7z0Ic7Q4UoaxAdkEiRjW9Q/1u+?=
 =?us-ascii?Q?g+hQ186l6iGHcJRWua5kmQbUeT+poXmBWKAU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:25:15.0324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5e25bd-2f89-4f85-e31c-08ddf1582bd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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

SDMA 4.4.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index f38004e6064e5..627c4bef443b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2597,18 +2597,31 @@ static void sdma_v4_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v4_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 22,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v4_0_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 22,
+	.fill_num_dw = 5,
+	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
+};
+
+static const struct amdgpu_buffer_funcs sdma_v4_4_buffer_funcs = {
+	.copy_max_bytes = 1 << 30,
+	.copy_num_dw = 7,
+	.emit_copy_buffer = sdma_v4_0_emit_copy_buffer,
+
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
 };
 
 static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
+	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >= IP_VERSION(4, 4, 0))
+		adev->mman.buffer_funcs = &sdma_v4_4_buffer_funcs;
+	else
+		adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
 	if (adev->sdma.has_page_queue)
 		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
 	else
-- 
2.51.0

