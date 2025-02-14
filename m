Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E326FC021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 982A610EBF7;
	Fri, 14 Feb 2025 08:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1x9HPm1Z";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B5F10EBF4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwC63J35TVphY3uX8B00X5JHcBUhHfN+wi4nFBLxD5zub9FOd2XFSw8tjluTk5SxwS0Oww1FhBivn5DZxdeQolgr7s1advADF4oai1eod0otV1kD3r3XmP5ttHE/ROr2z9xgyPLeb+EuLFFiI93MYGgAjnE2hKA42OCF1+4xYrHCD0y6F5aMNIF8DL2S9jFDwhqz5FO6+cQ4t4tS/nv3AqbOBI9J18IUGJbhW6k1W4FT348033SnmZ+ZGGtomV8B4zl4l9CVH6a8Fvig7dNASoRiYmg73aomP7YaXYzcQFEpnXODvomF4a4/1ODivnV78tb3f9MQQu1jHHqWCjr+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLHkw/lymg6KUutnE6nuLq8aWYnZgTtGNAWFdmXvz24=;
 b=yBwyi7cPZ0PPCI2zLML+5TDHid6Gm64oeOR87eJmnPq2rmK+9BvnAlpeI47xjB/vQvu5EQYEPIsMEdAbN/OqFM2aa9ei0lmx2h84pG13QQ8snFgLKTSIkhLVoASta90JUiK+WQswnfacBHkfRdyX+JGLLmEyHpGj3O5wHcX7Zxn/Hvw6VzfuRPcQ2a3Ifq/wuC9gEUF4uYCrgdqrIFmhDHBTtcrDCROjueJ3Yf14Zl02/aL2frfQHX/ftdZKXWZVEDkp7o2OHidD3kRgZLzZUnmY7ZjfOlgk0KINCtAmzkNdolEoqiNOA1edMLdQSuHEEUlHzIIexhb6DSgqTaWAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLHkw/lymg6KUutnE6nuLq8aWYnZgTtGNAWFdmXvz24=;
 b=1x9HPm1ZHqOvygFLyjz0aCF5b8xNh2ynJKVpRCSrQTyJgiv6X+f9Td5KrZRVppK8Xc1MjBWJ6OcCQB5Kp+XsWq7nvxKVDUYjRIq582FoCjuTryJhXnnXaf7QTc7eS2lmn/kx5sk3AicaCOIdQU1FSl9599SICLTKH0iQPIohBB0=
Received: from BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::15)
 by CY8PR12MB7339.namprd12.prod.outlook.com (2603:10b6:930:51::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 08:08:06 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::93) by BL1P223CA0010.outlook.office365.com
 (2603:10b6:208:2c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Fri,
 14 Feb 2025 08:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:08:06 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:08:04 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH v2 11/12] drm/amdgpu: Commit CPER entry
Date: Fri, 14 Feb 2025 16:07:18 +0800
Message-ID: <ca3d49e51534aa7301fbaf49812ef02eef866de2.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|CY8PR12MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: d3bb9cf0-fac6-4cb3-9c8d-08dd4cceb663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?veje3agPWQEJ8nypTwa0MeH1nhZ/3kkJ3VSFgGz5EOZEZQuk3K3LbhSDsU4V?=
 =?us-ascii?Q?by/0HnZ44B1YkR5runk/N6VGGTEziuJ03Q1ekFqewlvZAPoGS9DV06lc3S+j?=
 =?us-ascii?Q?3XDpOC0w6bZCtANRsR3F50NYI+Zn2xxF3QoiCi5nuZhWeIMVlCnbXYtnoNMv?=
 =?us-ascii?Q?0YlllyUB0A4xW//Hbnv2sAdVm3L4l9BRrP7NhWUR3ZqlRu9Mb6DjandazuFc?=
 =?us-ascii?Q?FJuWSzZVdD6sthARLbS2IP2Nh4jEAb4iOlsOOyBtrzXWq8VOqjuTnc5yiS0P?=
 =?us-ascii?Q?l4Y4fzHO5Za3fucKJZOaHwYxUq5uCRCGNTCD3nT5piQtMkWt7+vUZF3efvBS?=
 =?us-ascii?Q?k9REPERSwdQdfQKu1yb09G4MHkEailln8O9fw3RiYBpY6c+RW46Hd2GS48rr?=
 =?us-ascii?Q?niFqjDSHZYq6axN9eZMNHi7J9SDv08bEzPk6Keftm24+dx93mTt0AXJjB7Cy?=
 =?us-ascii?Q?O06TfSo/Tax+TgB7IrOHnGEW1zQeNncifLhYd/ZIkl7iTjZ4G4d3rRu733Db?=
 =?us-ascii?Q?FBRTvr9OOsiUDwPcxXlkAvAUKqGtC8t9u3fY0+bQtmh/xFBY7k20t7mZdcEn?=
 =?us-ascii?Q?u0DW9z7b6faMosVIGsFP6jxjUoErXEHOgGYfkla3Gy53TKNTmdbm9MG6iY2c?=
 =?us-ascii?Q?OOgRQHliXnQRgki7ptxfxaJ+3eTX8WWqUuz5GsZ+AtdIIAlKSym8lqq/uPD9?=
 =?us-ascii?Q?/JkSQl3mHguofM5/sP0o/kJoKZauFTKcwIvxa9rK5MmV5lEGiZeqaRraHt8b?=
 =?us-ascii?Q?Djj5DY8keT2zudsOfJQe0DxoNSEuDbGgGhV2zOrSQD8xPPoDlE0OZ/gfbE+i?=
 =?us-ascii?Q?7T85bhwwlJ5YxltVmWuFAX/BEc5hAkNgWzfRL0oWQRWs7lEWE3oXIBY6dxDy?=
 =?us-ascii?Q?mn0KPB9qmMcSLqXRMjSoXcQ8995bYuyICx7QlQgd0jpZSjMPUPFFgWWMoqWq?=
 =?us-ascii?Q?LBvXQgwW/9w7rByBgQF5SbzmlcSn5Hroz4P6YkIJhlNdMz1FOXHL1vQJWLfd?=
 =?us-ascii?Q?K7NcuqxjzHLIjReqfQO+V0SXpPHpyOHONUAoSCUK98QM9np2l1eSJvJzi+6q?=
 =?us-ascii?Q?ANuxG2wwWurewYKUpnr60wlRfY3pGOZg78bmI687TNYZwZyPrxpAALgx2TAK?=
 =?us-ascii?Q?CA8GlKDFilh6lNEpVa7JMGK7PZegltfx4o33TsBx3xlpMoAfTfMVIQUZ8R03?=
 =?us-ascii?Q?Lu1caXjQGmDJqUBr8qYTE7Pyfd6SZyBTSOULZNgyqKNmNlVWK82rYeYdHTiH?=
 =?us-ascii?Q?2lAwnPHyYe9spLasMSaO6wsO4o09ndF+LmYYXHN+gUBRNUfeEoZqd68Dt7yA?=
 =?us-ascii?Q?4fzBfA+RzGmdaN7N7rZGEqQeQjoe5j6Qvv37ZitaUmPkYfY6TV87M0DHP31g?=
 =?us-ascii?Q?sQo1KBcvsmcE1ilKHXoMERCE01I2t31pd27R1q6nsUUD4e7FJczXntSqf3KS?=
 =?us-ascii?Q?+7NRt1ZxVT0q51haaL5l8kY7MXKoL3lkrnl3iURqCQWuD3gD5SPYLp5Dv33s?=
 =?us-ascii?Q?YCNjBhVnwH5INdc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:08:06.2808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bb9cf0-fac6-4cb3-9c8d-08dd4cceb663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339
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

Commit the CPER entry to the ring buffer.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 0bdc08fba3b1..00f953ed6740 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -280,6 +280,7 @@ int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
 {
 	struct cper_hdr *fatal = NULL;
 	struct cper_sec_crashdump_reg_data reg_data = { 0 };
+	struct amdgpu_ring *ring = &adev->cper.ring_buf;
 	int ret;
 
 	fatal = amdgpu_cper_alloc_entry(adev, AMDGPU_CPER_TYPE_FATAL, 1);
@@ -302,7 +303,7 @@ int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
 	if (ret)
 		return ret;
 
-	/*TODO: commit the cper entry to cper ring */
+	amdgpu_cper_ring_write(ring, fatal, fatal->record_length);
 
 	return 0;
 }
@@ -329,6 +330,7 @@ int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
 {
 	struct cper_hdr *corrected = NULL;
 	enum cper_error_severity sev = CPER_SEV_NON_FATAL_CORRECTED;
+	struct amdgpu_ring *ring = &adev->cper.ring_buf;
 	uint32_t reg_data[CPER_ACA_REG_COUNT] = { 0 };
 	struct aca_bank_node *node;
 	struct aca_bank *bank;
@@ -377,7 +379,7 @@ int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
 			return ret;
 	}
 
-	/*TODO: commit the cper entry to cper ring */
+	amdgpu_cper_ring_write(ring, corrected, corrected->record_length);
 
 	return 0;
 }
-- 
2.34.1

