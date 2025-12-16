Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8025D637B9
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC1E10E89E;
	Tue, 16 Dec 2025 21:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yrqKFmIs";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012040.outbound.protection.outlook.com
 [40.93.195.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0DFB10E88E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3Er45Av6rQCokW3S7nr8nzlvGVrNkDzvUCfCy7IhQad+rmTOga3Kqc0qPgCEIhVU5Dm86dKXTaPrD18jBWVyENj+9YNdMCcyOqeEE5WA5qqZcW6iFy05juC2pcXsc2E2hHky9S+1gf1megeq+63pz31H6wE6C1pHqC9eUt/xv4NQhLRuBrVge71qxqoOpIl8nZ2j0jCkYMawuDH38oseGm7dB99UkrKPYAz1QSYSNvQrXejUmam8hk0xS9+vzghNgDiKthftREmCa2umaw5ELXWxWG6soernwrgR8IoRxUUB1mV/9Iw67xsb4ctTpd8O/YS+M8zWFmpjDZVaFKQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0/ht+xF9aEsz7Ny0gYlSEk/lo8SJ21kQBwDZYDoDjo=;
 b=mNmqfmsLzB+HNxgOIEjX0Ez4AKw/UsfB8Wp7Gmn2lUF0U8mYULOuC4hoYxt+OVauv0hUROYWovWGBeGq9UZItvVXT6kCw2cs7hmNomn2uSyTqDOCWfv92n7a/P2859TlXLNpeB2kC/a5WHwSF2UO6ahuI6pLRJsji25j5izdwvAWDo5mKUXSvR8Am9jnu35tI8skPmATqvwPccRFsdVm3KUMXEwIv8f7I3+smMyds6NyHJyKGGEQSjNYMOk6ELwgUcm9SbhPt2kYHlnL9upR4nNWiSHok+yq8e7LBw1zxHz7LJh4f0ORRmYuqld9SLcOG2sbzwYpq+5KYToX1r8oEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0/ht+xF9aEsz7Ny0gYlSEk/lo8SJ21kQBwDZYDoDjo=;
 b=yrqKFmIsqbf7E1jGg+xI+VK8Td9ks9hXN5i68q4apGLrXTt4Q4qnHjy0UkljzYqhtqrmlPpex0jujPB00wlKoF7qp7PgLEm63wbL1RObD490mxtV99xffkWo/nBpEuHrrurD0q+u6Esi32hu3pNltke0/a0csmEAlI9+YMQKop4=
Received: from BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::15)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:14 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::9c) by BL1P223CA0010.outlook.office365.com
 (2603:10b6:208:2c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:14 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add sysfs up clean for gfx_v12_1
Date: Tue, 16 Dec 2025 16:03:42 -0500
Message-ID: <20251216210349.1963466-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b51f49-5a1d-46d1-f277-08de3ce6aafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iD90L9LP2V/r/k3Leo6qJ2/SpzSi/i0nl1an+bgARiVoIvAQkOYhfQsSCYko?=
 =?us-ascii?Q?s+VLvdTZL1kKk7ZMtkC822aWzLn8egmN5VF2Zp6GLwbZ3JXJpfILMLxhndzc?=
 =?us-ascii?Q?VeuNiB0+z8Rk/W0SY2duxxxnT0hJeIP07ch6RSg96+GbkfEvHEVThJwu4J4W?=
 =?us-ascii?Q?wKJW6ADYfzlBzAjoAGnxxdbWiNWMUYU7J5aoROZ5yNXYwWXQYyYDG1rRSUgj?=
 =?us-ascii?Q?WX6VS9wnkeHYN7/4zyzbWlL0W/uhvVIg77CmktIjD6gGUcr4mYjCuL8tiB+9?=
 =?us-ascii?Q?6h30ndjY2jp9pLmWKxBOjvmiav+OKNl4huPm5ynhdp/F5vJr/YXCTJHFxOPw?=
 =?us-ascii?Q?/lQVf6qcNlXUPmmCKT/AqOLDCDH4Nzq2ZWdfzkyVXANOD4Z/knZMQsoxEsTD?=
 =?us-ascii?Q?ejhmXACdpl0tfKACuE3J4efpEf3NSAd+LY1EqapeGa/JpzZsu4e+fuumeNfN?=
 =?us-ascii?Q?GmftRP6JS2I9Z1a8jpY664zJsEJSAMmi5XR7OS78KcqQ+B3cOtRscctzBqC8?=
 =?us-ascii?Q?9l1C9hn5msFfSXNQTphhDIikN2lyy6N8kRBbJ3G/SlCKlXuge4ilNfda0149?=
 =?us-ascii?Q?PigBCLEQwVxeQbu73GyiC+EfvzIQ9ITMBG+mQYRn3ci2jJuAPhEssVcM2RLD?=
 =?us-ascii?Q?+eqzM16NZoMn7coBwBqmGxNVqwakde2MaEoFE51Shqe3/gRD75ilewMKbdVg?=
 =?us-ascii?Q?B1my5gcArJ5aPwEaV0pciJ7hc0wgpmviYBMjbzb6gnxSrayWxIQFG72O+Q33?=
 =?us-ascii?Q?5Ft9oCT1EPrkg/iq5oSC6h1PmUU3+IwVUz8JWJpfwrM8MDoW+ah03VM22Zod?=
 =?us-ascii?Q?E/FTG0KfRcX+bKTkaNKdQl5KFJVnTMlrN326GxQSgX+5eCBixsrAHtuOItKM?=
 =?us-ascii?Q?G9qSzoyd8MmBJohRcffBILa5unMs/RPhLR3k4O8N9okgLSLus/GwB7JTFhOS?=
 =?us-ascii?Q?MBCQkSc7hEH4nUr/8dxFB4Uz1X6nt4subnKBJbK2DmhaQkDkn3a6HBE5XbDW?=
 =?us-ascii?Q?czA0YHc3BmiA7WCqmqJ+O06ycbWF0OjPXQEYpzwhzBnegCQyAoCWlqbbiP1B?=
 =?us-ascii?Q?z1BvOhO76sQK6J1hbjcqucTobSNBZtjuW4mrt1NoX/6Xsi3xomZDF0aww/G/?=
 =?us-ascii?Q?MvcDRcLF7WuDcu3n1UygISnYCFcgElG9IIbs5JVd6iNn91dx+VP+/+Detoc+?=
 =?us-ascii?Q?J4zNNPRbjXl1sbG+Q73DiMznopcxqSxWfj1qgXQf8aB51B5wyfvYJLzZYbCY?=
 =?us-ascii?Q?/Z5LZNJjzaWnbiiEHCrNe0H6c9zA+jHVIZ30cSdbQnP0aqIiv0DxlUDPhmek?=
 =?us-ascii?Q?ilcVU2gJAnTSp2nNDKlEOg2a+xZS79+Gq3DaKaUFDDwGPguiR5sP4AQ8GPzO?=
 =?us-ascii?Q?vK2qjTm2eC5G0Qp/x1+lAqBMw4s8oClYbhfx1jPIAGU6mjdx8wwSNdmXJE9+?=
 =?us-ascii?Q?0P4jhQuRJHxNY59b8j+XCJOnnyHl4/noUnGG27FaP4xkCb4Nhipj3K2E0sxu?=
 =?us-ascii?Q?rr4Kv9CF9jYyWgrMEr2OscTsutdDvBWJSOXcdq6coEdiuL3MUb6XsgB15Q7D?=
 =?us-ascii?Q?g2lFrhtbFA6hNCw+VJY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:14.1586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b51f49-5a1d-46d1-f277-08de3ce6aafc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608
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

From: Asad Kamal <asad.kamal@amd.com>

Add sysfs clean up for gfx_v12_1 during gfx fini sequence. This will
prevent following crash while reloading driver

2645.490824] R13: 000055d0cb186330 R14: 000055d0cb185ed0 R15: 000055d0cb188f40
[ 2645.490825]  </TASK>
[ 2645.490836] amdgpu 0000:02:00.0: amdgpu: failed to create xcp sysfs files
[ 2645.490937] amdgpu 0000:02:00.0: amdgpu: sw_init of IP block <gfx_v12_1> failed -17
[ 2645.491018] amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_init failed
[ 2645.491098] amdgpu 0000:02:00.0: amdgpu: Fatal error during GPU init
[ 2645.491547] amdgpu 0000:02:00.0: amdgpu: amdgpu: finishing device.
[ 2648.549939] ------------[ cut here ]------------
[ 2648.549942] WARNING: CPU: 0 PID: 2459 at /tmp/amd.aIpOeG3c/amd/amdgpu/amdgpu_irq.c:

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 2251a2b1c5bd0..c419e60702c8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1282,6 +1282,7 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 		gfx_v12_1_rlc_autoload_buffer_fini(adev);
 
 	gfx_v12_1_free_microcode(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	return 0;
 }
-- 
2.52.0

