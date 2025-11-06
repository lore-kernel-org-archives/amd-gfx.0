Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA22DCCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 08:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7292F10E837;
	Thu,  6 Nov 2025 08:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LB3ayyvT";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F74110E837
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 08:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZfGPn5bml87I40tBIg6XRdbV6mxA2FGF/U+G1dv99KeplzmSnYmFV6XGnQay38/oVRDwT1oJOekHNTcHaKK6qkqhYwRk+z1uQagr5pEg47quFJ2aoO4qfGRRGsC+WjLgx0LXfv2TZBcUmxKUWYDPH6Qmnikyp4CYc8q494dQODZZnFB3LfvXtED0zIIhYUPOjsSDHZB2v0iOZCNpbJD4GnVXvfVz5yIqVLdE65jGkhjXrPlQFw8/z/xsEamfawvbjCONQkZH0eUkI+E1LQGzCH9LvhOCVvgvnM68A69h8skeALlETlnXFhUihwPpmY8WHJBXtCe8DERaAmSQU6rGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DylWrugQTp3PCoKc5cy+ikpV1woAUKKOjvTwdYftE0=;
 b=auK7cRfi20cyU8FGYHLA8EeTEv7GGntBMWl/t0Tol6q0FdZDNOrUetzG2aApEhRY7znImIe59Nq0uuHnLhcAiE4QXmNHvqgdFWICzWOUOTkdHrIpsppqSpFZG0UfQuC31oqLAp2Svj6A5MXfVOROtnl9VO9FtGg/8BRaQTm8OprA8CC6MRx8AoqBvRt7zmmYPhYcXtj3VLIZVkfiUlMWLbKLX9GqR6jjALNTBF+7G1Et3m7tOyoMwBgZC4lohAxWCQVgfOIH73B5Vt7Wv6PjOuYPFPGgRJhd/mDj0eYg4Tfo3EMJLx7NeB5cScuJomMV1qQLrf4jrMaKioHNbbjUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DylWrugQTp3PCoKc5cy+ikpV1woAUKKOjvTwdYftE0=;
 b=LB3ayyvTCM/2hXjD+NwKCEUgpm9IGn0JcWmXews/xazynkJO33Ak8jvS9ECyoZhfc2oAUy+OOZ1P3ppKDDtEkzRM4TtEv844SoJSfqEXAju5vh0Q4pWlAhR8AsMV0uNGvzV/6W4NuDs0W40PkCB0Xyj4ZpePTbdQxZqv8x6pg4E=
Received: from SA0PR11CA0029.namprd11.prod.outlook.com (2603:10b6:806:d3::34)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 08:23:18 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::eb) by SA0PR11CA0029.outlook.office365.com
 (2603:10b6:806:d3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Thu, 6
 Nov 2025 08:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 08:23:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 00:23:14 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid xgmi register access
Date: Thu, 6 Nov 2025 13:52:55 +0530
Message-ID: <20251106082255.935782-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: af2005b1-789c-44f0-ec31-08de1d0dbd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VCwkyWB/E32EhNe6I20cFEYSiPjT4OL/Ekr7HOVnjCAsGygV3xHsC/1iWvEd?=
 =?us-ascii?Q?VnCeqSTSHIlHXkcHn+VMcSx+JAlVNm7kgbob9GA/wCgUgXS0nnrJobqMoh6D?=
 =?us-ascii?Q?8cwK7zHjO0I5DiVcj2ixXxxQe+YIezP2ivDKwijsXYe+FJKBwI5d5/Agwc4C?=
 =?us-ascii?Q?QkH8IetGLljEywxbicBSaY+t+in/EA6GLEd97yjLALrakwBTJV51QIiJ6DFh?=
 =?us-ascii?Q?FsopxmhcFsE0E863mjm5No+750D1MNuyOkf2Nlb+HamcOn8d9tXZcYthrQUD?=
 =?us-ascii?Q?c5+HQx201R5bAMcOyqKBCEtMvGBMGzpsCKBJ05vUuvCj+LWq0P3cCz2fSYw1?=
 =?us-ascii?Q?yRuLZMgq7dNRxatEzxdjGq06jNW15W6qbPUWMoPew1cEhNLmLv6ZaWvMtUds?=
 =?us-ascii?Q?Ki3q/GlDdl/X24b3XUydHrxMJkXglcJXx4ENGUcXlwf6ihniUNP5p1q7vnZf?=
 =?us-ascii?Q?SWFd0b2owoFI3UT9n+xnzaOd22/meky9xk7rkBsAiOeORLDKqfn6w7GBvzVl?=
 =?us-ascii?Q?KvHLmvUggRna2kTXTw1JjHwRxjyu3BEqpGD77+bKbIZoeu4pXLhlD4jlnvIy?=
 =?us-ascii?Q?FGn6NyWK+loJQSqW4UCzvJ2uqUj33M+T9vkczjIPKoVtqpkUdCoU1ErKcQe2?=
 =?us-ascii?Q?DMSaBBIbo/mLNOjYybUalBOoFi3825Ca3PDYVqqlxPZCHqD96TZJK3tW7n7t?=
 =?us-ascii?Q?/3/dcJ7f+oPaJOh81L9A0eJ1B10eGQmEEhJGczwbhPo1hiB8O8a5XR24UC4e?=
 =?us-ascii?Q?lk/sJfCEdVGIchfwYLjiM3YRDlfIgGCw/G4jxQP2LTI8Yjf0ozrOwxg2xLVV?=
 =?us-ascii?Q?kKIsqEeiAg+51sNrO9aR/GIF/iUDMsCqvPv5oYQChbZhLw092C3GD+0Vtyu0?=
 =?us-ascii?Q?EoK/2BL+S3xW/nO2N4Wor3kgdI6s/0OH7vJU8ahb8yVsEe1ZmTLlz5KVKhOS?=
 =?us-ascii?Q?3WNjGpJLXNvO/bd4+DsSi2E9WKvdcxripsSGN0sDqWZaFrMHAF0762uYe57A?=
 =?us-ascii?Q?1PhC7qMhU3kY24sREuw/4UdPfHRa35C35SqtRzTnLGpTVSlha/EC2neigiyB?=
 =?us-ascii?Q?gXEPfN2/oX15WyBEHz9WqAjyVJtJcWxjGIrU4KuMNMqqYFRLdCcRHzjnv8cZ?=
 =?us-ascii?Q?Yk2Wr36qS3WrPlyj2d5DRcEUrHFHCl6yk8n/DJHRjWqhCt9P+u4OwPbIXAI4?=
 =?us-ascii?Q?1DOZh301S5/GJKmrVHhU8+a14oPym+rSlPs40XLOgfswlyN5GBqW7oL/Gwmc?=
 =?us-ascii?Q?OU81XUWqXLk3eNlHM5I0vKzcOC35dnxH4JHiNKRG7CPsmo+diYf0Li0EJyn0?=
 =?us-ascii?Q?KGlk3SK9ME2a3KP1i1i1jIOP2DOEYLz/I0OYu0L7EVjEQQzJzgTF78Gc4A3i?=
 =?us-ascii?Q?KjRDhgEkrzG1qg8xJtRcCEo7XlVgOy0XmGW2OjDZEWgggTyGyFygf2+lb/oY?=
 =?us-ascii?Q?e7IMfsMuEul0fQkG1sdhJidd3/5Q4dx3HmW2xxobL0pFnBbTGFvGOA2AtWT1?=
 =?us-ascii?Q?ysmR3Pwrxd/DMLScdFhKh7G5G4APiotEITyAFpnYZhL2FYMIMC9RFVzVVJe5?=
 =?us-ascii?Q?MSxvACQqt2OzZu1gHrg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:23:18.3192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af2005b1-789c-44f0-ec31-08de1d0dbd78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
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

On single GPU systems, avoid accesses to XGMI link registers.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 1ede308a7c67..1823ce74b990 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -298,6 +298,9 @@ int amdgpu_xgmi_get_ext_link(struct amdgpu_device *adev, int link_num)
 {
 	int link_map_6_4_x[8] = { 0, 3, 1, 2, 7, 6, 4, 5 };
 
+	if (adev->gmc.xgmi.num_physical_nodes <= 1)
+		return -EINVAL;
+
 	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
 	case IP_VERSION(6, 4, 0):
 	case IP_VERSION(6, 4, 1):
@@ -342,6 +345,9 @@ int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev, int global_link_num)
 {
 	u32 xgmi_state_reg_val;
 
+	if (adev->gmc.xgmi.num_physical_nodes <= 1)
+		return -EINVAL;
+
 	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
 	case IP_VERSION(6, 4, 0):
 	case IP_VERSION(6, 4, 1):
-- 
2.49.0

