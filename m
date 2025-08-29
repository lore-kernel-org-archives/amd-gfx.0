Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613FECA0FF9
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 18:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085E610EC2A;
	Fri, 29 Aug 2025 18:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KgykjH15";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C439810EC29
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 18:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIyQdRThuOZ4D9rAYuzQMTJkd/jSyWYkHPe3KSZ9vWBfiCLZabmWSyIGKG4qajBn5QFDBl7JjK2LAtM54Wg9iuywP423MxvBpVlpGoR2CB2cCCCfT4cnxpC8eO9w51X2BloUZUSB90L4yKXHDUXbl4RQ7dvNhi/gCpTu5VN07rldbmIcHEe30In/JHFy/CVuFMYsMXavcVVfPJ5wt+nS2ha1QZWRjBlqnzkmCx8WP5ZJ1uwvQl4gjQZcRupPmwZ+0eUzWp3zirTU/zqIQH3SIprlKrhDBppnBNl1SJ71KBfALAVTOoKZfjVmcv+XvUerMlmEIrtyHhzzeiVO4B/WEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC8X1MN62HetqCIBVYUX1qP9Z2bfzw/kShBBohr6pgc=;
 b=nd9o26BGnsDo15FoyIvTv65EOmj2u/tzHntiQYKtuVS2rTuDF+nn9ElBCoHNmDTfkrBr7iscphfIthylTiqgmaTQ02KyqX3GbNP+PK/csMou0rtdBTU16rMp4jg7HoWkVxs77SVQ44NTXnY5i/zobwQN1x0YRHSGfx+GrtovgVhsmoaK/pU0hGkK+B2ao7Zk97iFVzN9lJiLo2j5P6onO6shJjX2UL2tsMCFEhjeqRZqlNk0hzm6dT8HFSQJrH5uRR9EU9aQ0zHkeDvXcoiGugOn7FObNHlI9Vl+RoT0UOJ6BhHlO9Wb4PcRC/Crt44Y97q2yHY8c9vdxatZ8l9oxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC8X1MN62HetqCIBVYUX1qP9Z2bfzw/kShBBohr6pgc=;
 b=KgykjH153BVO2wrfl9iB0kvTxsd3FrQPsqTyEbwlQ3bURuEsWkI+Go030xBEGLx542whmbZGklMhKt8o6igLyHxJDP/kGeUsBVGn4llv2nj3dgu0Z7DBn/5nZoGO0ju88eolIhgUKZ1XUymNGe6eOPafBSjfCczu3GsKPg+TtXI=
Received: from CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 18:30:34 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::c) by CH2PR15CA0008.outlook.office365.com
 (2603:10b6:610:51::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Fri,
 29 Aug 2025 18:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Fri, 29 Aug 2025 18:30:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 13:30:29 -0500
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 29 Aug
 2025 11:30:29 -0700
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdgpu: Increment drm driver minor version for list
 handles ioctl
Date: Fri, 29 Aug 2025 14:30:16 -0400
Message-ID: <20250829183016.1342823-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a17f81-b7c6-45d5-9fc7-08dde72a2463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gBEzzrVFksix98iUvSIh7fQWq1TxPISRt4Pb8/YC9DwDZiaxac4wZsCxgbzN?=
 =?us-ascii?Q?PkZFkuvmzIb4Lu2gxMie616/o9RGkKyJRrmiYE72i8sf9layoKogACUb8Sao?=
 =?us-ascii?Q?arE5U8vdn1//v6PdxDxVv0LSVO/bQ7F3R7NARLI2utirqWWltzeLTddV2Pe/?=
 =?us-ascii?Q?Ht5/+tHRayoglUr0HNwf7WSOhCBNIMda93w31vjHYYL6Yafqyta/kyi7UTh5?=
 =?us-ascii?Q?z+EAIVOqy+GvggxeABxvRyWRu1u9zG3aWCpGgzDfIPUfgM6nu8Np5cXTxkc7?=
 =?us-ascii?Q?c/ixtffaW48NDQq9GR/tOpYpolrInhUfRyrdf8ZWUyIm5rhXQcAncAqgmx07?=
 =?us-ascii?Q?qGiKjkcy9IVcDpNzndC8FWYXIis9CeiqcX86xv19RzcsblmANJlcQpvxdZ/C?=
 =?us-ascii?Q?fbsmxTG49hduiPc9cntNXA2UBgQ0fwMGJyNdmqFwKR81O+HPKJePPvZCWDFk?=
 =?us-ascii?Q?KHeIJAn2usAe1fT1mguECnzSFvl9tqpA1uPaXaUedW31hUU+Il+qSj2SWQhs?=
 =?us-ascii?Q?7LsQiQR1pAojf6tl/NVrVmGLobho6fySEWH2CxSaaU/DlZypqW5DBDBdYpqG?=
 =?us-ascii?Q?kbMVbj6zRumVN+CHX/dbHU9dRW5DLNDERZwqxbzGhgKhA1r3GRxikLC+2A4I?=
 =?us-ascii?Q?KLjo5iNkLU+T2a7mayna81+1wL1GNipvjdbFLy5B1tqsjb5jDcaJCn4hCyoz?=
 =?us-ascii?Q?5hIQnnwSc5lqS6Zh16p69Yl3bt7t6EzY7dlx+CmnSodP9Ya6/w/2YSX0Ep5q?=
 =?us-ascii?Q?CUAwoZ28QDpFU9m9C2a0ByFZA54443d4DXJafin4EJPUvMWxSvKCylhDjcf3?=
 =?us-ascii?Q?Xmdr+SgfJre3ztEHePwzfAhyH7gjlJ60/kOzTLrzRtjRa77i8c/PrpHNQk9W?=
 =?us-ascii?Q?49LfuIkYafd/69l72WbpDPjD6BN1LEWpTURV4DMNiyzhCn1gMUpnMuBIIdU5?=
 =?us-ascii?Q?gs5bPLEpweMo/2PzUjLLAXWP/xvg0ZtTxlGeyd2sy/PGTX/GzbbqKvbhZvdC?=
 =?us-ascii?Q?+OwcVe366qDDLV+GAywgLvy1LekGeOWDnFMPACMhGfSLW19vM6/qLVA2bNqO?=
 =?us-ascii?Q?YMgEG/yqo4VZKGccRidGLWuZqTX3Q+1LHvOTG+olHMBUYIZWbVzd/vJbpzpn?=
 =?us-ascii?Q?fb0fgEKe1lkEPjgnaP34WVzqSJZ8i83W1juFepnRjlw2/cp+fx5GbdYFVGdA?=
 =?us-ascii?Q?/IulKcag2LrSy8sC8zDk2SBRuqjhr/jfwxFjmd6ZkvI4dpLRdBQbIdwB1w0H?=
 =?us-ascii?Q?Yo23liL90jpWUPb0+JfExQc4PInRrpBofbzq1J2ZbOF/YCmUfRn/zcFTFVV9?=
 =?us-ascii?Q?0eRt825CpUevPxvMS2skbkMNUYajwwgb93nprpl9nPH+xoUQDV2ciSXzpR8M?=
 =?us-ascii?Q?MKdGH6EKWQaFQYRY2i5dgA7LJ4FG1lYrX7LiqIzwVaqxxSeXWcuoHwf8HoHw?=
 =?us-ascii?Q?rzotTxcA/6HtuyVudLK5p1bPg+MgJSHqitoOWcv31qS/89qanGCRbQKKZfQv?=
 =?us-ascii?Q?lc1vNauT3U3z+8pn6OBkASnlmf5VP1yndeBH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 18:30:34.1073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a17f81-b7c6-45d5-9fc7-08dde72a2463
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
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

With the addition of the drm ioctl
DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES,
the drm driver version should be incremented (to 65)

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b42a2a32b0b7..e098a553d12b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -128,7 +128,7 @@
  * - 3.64.0 - Userq IP support query
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	64
+#define KMS_DRIVER_MINOR	65
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.34.1

