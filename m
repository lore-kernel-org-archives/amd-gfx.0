Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373C6CCF9F1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C83F810E806;
	Wed, 29 Oct 2025 17:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qMN+APTv";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C4C10E806
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYfop1kS9Q7K0qkxmOQfdQXOkP0Zcvmt1GXsibcctvkRUWZXi+lf2ILaEjDB+1lGujXvU8weeMATxKXryZINPWuAVcLg2mC1sx9E6qJOwfbyq/8wI1DB4G0jen0X3+ZmmkemI+DY3jm16Bs8aQAG6ktDbOz+SwBzoauspuPhXszgc0qJl3JMolDkyjXp7h0NHRrwFRV/eJTKwxDkI/r9WnMPglmqYFg2JZdOh+qRsa0KS17ZiYRe5412ZXq6M8Xj1oJIASZQV96wD4q5eSV9oNwcECI1YYx+MyNbkTPEJSvselwKdjU9GEVsCNIPe/5+6yl9p+1CMYUryXbQHASqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfcHuBA2Ti7k9R+Jm//Zoc1CQtxhZsTcv6bY7uOKrUQ=;
 b=uOPjR5qZAAEpFDRGQ8IwzcPfailLK3YnrMrz33DuSeN7tnFOWGzhVmSgV6RAiZSdFHH6pgaBl7lkZYUsRt0OFjnfAUPiULBN6NGQQSfwI4S78Sc4uhnVWMWV3NhHm1XfmwzDVxvN7sx7r5SUGycHAiEptrZAcDnF6eZpMIBeGyWmNlqmWMKhRYysAaTeayOmVOCzy9O6pdklsqokZKHORqQwD88ncGXoYvH6tNtIXR4pQgJbKchFRuA31CDcfBzZKzNm7eRD1dK+iRL+KRhtFU+4CYd7zXbcVVro9RqE9WA0NE+tjopbIPPAgr/HrG1NUWqEIy/qBjWqh/3/aZKOSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfcHuBA2Ti7k9R+Jm//Zoc1CQtxhZsTcv6bY7uOKrUQ=;
 b=qMN+APTvoF8SpwgR+FNpMr5C/+hyzxvIG8K2e8OL5kuRlQTva4EE4tKworOwWE1EOvzVyn1zIzNiJMv7g5vjZdLxmiaAP5BAGkqjd+LbAcLdKTLUuezxwCbTWMi/d5pHcJuaYz6AEjr5nKyqBqKG4oB6eXhuEX4D73KFEaOj2n4=
Received: from MN2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:208:23c::31)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 29 Oct
 2025 17:53:14 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::83) by MN2PR18CA0026.outlook.office365.com
 (2603:10b6:208:23c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:53:14 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:53:06 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Update CONFIG option check to enable 57-bit
 VA support
Date: Wed, 29 Oct 2025 13:52:41 -0400
Message-ID: <20251029175242.2861740-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175242.2861740-1-alexander.deucher@amd.com>
References: <20251029175242.2861740-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f03da7-0e38-422f-68d0-08de17140883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KJ44oIN9sacwWTKTjFDjvW6zEkzVqzNOLnYnUsftxTwE0BpbkjuaSbXK0Lhr?=
 =?us-ascii?Q?NFciJjGMyjTEc6Zjr+NE3QU9SJk7lxQ5Hr7C+XvkVs4+yPZdM04WBnEqoQ7P?=
 =?us-ascii?Q?cbEFLYzN4do1eV6XEy9LBLhIr3s0YOVHIrywqS/kEP786nIDJpxxPAVwNwGh?=
 =?us-ascii?Q?ZWDV4h1RFsELs44Kcr/uvqauNeTC4w3PVE93Zd0DpeCUSxHjic+6n/2Lz9e2?=
 =?us-ascii?Q?VuvJS/sDKNfYGH63af4ARk5HbgfbKveBuQOXw5sMzlTfImNZRvpv1oIk7nVr?=
 =?us-ascii?Q?181MfozbRccHgJT0ZZlbcNVomVAjpSfOn/Gv2sAUGUdq9l2m91HQTrHToZjF?=
 =?us-ascii?Q?cSM1h6nWM6Ov+OACfTpcTGS1a43Tj+0JA5cEjUvK00x+mtYj9gvFFw150Cdd?=
 =?us-ascii?Q?flLzy3zln0+D4FjFMCjZjJ6kOEUuwhASWPmWU7MBuZT3fk+8UAOW0HX9sptk?=
 =?us-ascii?Q?tcP94IrIZjvu0t4V8kK6HPzMKbhCU9Tg/J3jYjl1rCCeEmzckXW3DaAB5d+D?=
 =?us-ascii?Q?/mbcWoM04k0LfIe+daMhfAYhKwAMLUva01pP0mmGqbll16036Sk3k12yTDPy?=
 =?us-ascii?Q?h4eqdKGTGwkf3zQRHjHrFrWvdkSJqOIzmwCuNksuctiy7LZkmJYBIOLkR1tw?=
 =?us-ascii?Q?p0UgGCaCvLGnZXyEwU6UbxnNx/QgZMzNph7zzF+0mTB4X1ocUF/vt8x7nKuF?=
 =?us-ascii?Q?n0YQ7OVRtPuhLjCk+7h0roxAR+3AX0bVG5v3Hi1kLwWcOy/TxKR817EaktQR?=
 =?us-ascii?Q?PS1fvbkgBSeT3kn8XUwJyMl9vh9mPpX9u7HCetrMoOP/VMAM7m/2wgfjV4wn?=
 =?us-ascii?Q?B4qqLBIqE53kUwATaQc45f2lVukgKrB16mmlr0eCJWcTPSt7HTdv89UikJ67?=
 =?us-ascii?Q?t1RKizpPiqlYQj4W7QENqZ47AI/+0jSdUgR/d4Gv1kaA4rzCuGTyhxlJAO5M?=
 =?us-ascii?Q?Qdyh4q21FyNs03xOm+tPNdUYYIeNtN5D9fPMabkAx/fLBF/Wm8uUv6pXrpYC?=
 =?us-ascii?Q?ip/V8LakS2OHM3H/zmFae6642iptL8miZAmFIPw4tEMwEXWGWqD+03rmc2kG?=
 =?us-ascii?Q?kouIUUNY4A940DZ0Xjnv/UYbkx1gNfBq9MmRrYUAYVP/UkDyb3Y9v6rO9D7J?=
 =?us-ascii?Q?jYjraeS0T52FKf4iSTY/lZjid4cmN/EDOuhRIJSdtXPN+4Vyx35yTdc1tIHD?=
 =?us-ascii?Q?Sb4NJltZYgsQXzpdUMdeQCkYquQjxkrx/HqR1cq1B7g8Jdq0KuDpVzXtazve?=
 =?us-ascii?Q?zxdhgC4P62fZAawo7naPcBrnl3WbYkCDzcQFBlixBqa1+dBYJJT42HjUwxEb?=
 =?us-ascii?Q?6S7lnpVbY5VegfMDUULCeR8JrXPrCVpbPSsbkj33J8x1j+JkJj7E9A4PBpZ/?=
 =?us-ascii?Q?kklHGgUnWdq2AtugUpFQWjLDfoon7hV9wbkA928TQkRyAk3d9zrnNkO2BT9V?=
 =?us-ascii?Q?d7FgsqwgUCm1htG+RbIsQs4RdClW13/y3uWNw/bn//0m7K+aXFCLfg9tilNu?=
 =?us-ascii?Q?rP2NvBNPegLL8qaDS/ufcm/ns9eW5xyqOa9sKBjj0BzkPVlzDNS/sSF/l0Ho?=
 =?us-ascii?Q?KCwQG+QglPaWEuE+M7g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:53:14.2377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f03da7-0e38-422f-68d0-08de17140883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
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

From: Mukul Joshi <mukul.joshi@amd.com>

The config option, CONFIG_X86_5LEVEL, to check for 57-bit support on
x86 got dropped in 6.16 kernel. Make the corresponding fix in the driver
to check for CONFIG_X86_64 to enable 57-bit support.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index df67a9752a390..56b5ee732260f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2356,7 +2356,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 	unsigned int vm_size;
 	uint64_t tmp;
 
-#ifdef CONFIG_X86_5LEVEL
+#ifdef CONFIG_X86_64
 	/*
 	 * Refer to function configure_5level_paging() for details.
 	 */
-- 
2.51.0

