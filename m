Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC9ECA0EE4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 06:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD5A110E2D1;
	Tue, 26 Aug 2025 06:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vsWkXOwL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 715A810E2C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 06:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnWPH3A2P9izVzRuAOQrUTjkPVRRoaZPUbgewSDPtMXxcebUimi+RnJinz+x05yUDM/8yhKItEmEQguSHYobyJHZ1HWjDrmMJSXj4acUJl1KmS0bX7nVrUs/7yWasJYPzsCROOa0Bdy3S9cu7FNlPik2o4d/KnviJNAfl9/HPeNSYn8Cw0TPPKrivyay09TYVz6Toh3Lg8lBvCmlvxl/pOCU6kUZoYzwJQLyywl3zudFCUutZU/ZTUxmCztOK/Ga3NZPnzjopf2QoFtM04Qq5nshdJS4mGxjZmRlsSSOS3WxUqwYzgRzhgUZ+EAXuy2H93q9p/0j+Hw2klmC3STIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCjUHaamzeg7b1QWBPXqn5jIHn0wvtG81IqsigyFMjg=;
 b=doEew0LifveJHhUVYzUMA3ubtturNBdrKN+X5BdOqMYpp+iAZVysutG/vw0bxLS5Mde6BateAPH7OunoWOAQXiObC5z4PGwS9NLQhOA2lXgv8N8t3ONlvk4twTVFi3xiBsHtyokjcMPKirqiY8fqnkTKn6a6Ic4GSqvs/lMdZnzYi1C1G9n5D/ucjlxKeE+c1UdQWXsjaxz2PXnSFAHLLlyLCgsYvlSXh3yN7fuY6pO/NK+W7DKxLiZFWd+SayMSI6AAPaKtcNQD1hV8YPz5+Qp45FX5mp9nA/Ojw+3imwc480ovYokGGlucLVwjJitr5SOjCnBIElUGOKyR3FxkJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCjUHaamzeg7b1QWBPXqn5jIHn0wvtG81IqsigyFMjg=;
 b=vsWkXOwL7gwDY86ggQVDqE0GstOmiUVyVMALJxhB+nLJE+hI0jPRL3r93nCVHG0RBjhJZWY0VmbMzke7zvO5dkyfDz8YAvJrNmBg8fqVi966qV80hf09rMTUwzozU7BYwaJw2JQFvngdunDrw6D5OBWYOZ5McBUiNbI6Nq4m+Gg=
Received: from SA1PR04CA0022.namprd04.prod.outlook.com (2603:10b6:806:2ce::17)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 06:03:00 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::67) by SA1PR04CA0022.outlook.office365.com
 (2603:10b6:806:2ce::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 06:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 06:03:00 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 01:02:56 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/amdgpu: unified amdgpu ip block name
Date: Tue, 26 Aug 2025 14:02:45 +0800
Message-ID: <20250826060245.334880-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826060245.334880-1-kevinyang.wang@amd.com>
References: <20250826060245.334880-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: dabb3754-b46f-4113-6a9b-08dde466360a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SO7i8yL4UhfdUXzYgvqCVax6CZJkC2WMflVV1gQzwCN9u3/xZA+nPFeDgGwV?=
 =?us-ascii?Q?cfw1TLzhgrKqFnB/rm1FnLNHWWALYLz81TXc+sj+qSWsnRVuqpStLARPP8Om?=
 =?us-ascii?Q?qSZ57hpc26ZSYSf4NI7/J4M9OjP/aYJBrWS6HQpWFtLBBYj2OEAxFynagmEH?=
 =?us-ascii?Q?Vn36ZUPZpC2tgKiB2DsmHcI0KLxO2j6yunCiykIKVt9+qOILcc11+Vh0qkF6?=
 =?us-ascii?Q?fJn/JoEAwSD7OQDWBNe3JfIQYcofZaS/O5vi6KO1t6evMlIlm+oRO0EAosvP?=
 =?us-ascii?Q?DQqpZ4xo/1c42wXnJSNaMeaAMtlDTucENnLLGg3w/2JvA6ATKCr7tV5hFqvX?=
 =?us-ascii?Q?/WSUnZAt/b4vYuLA1tLTh4bXmb2Q6g+qbzcJ+Q83SIVzp4KML4rys/z3NNxX?=
 =?us-ascii?Q?f8GaCMimBQWcEjdoom4uQIWTfwBayF7W6aYR59iSYoOg0ANv4vTWhIVoD2T4?=
 =?us-ascii?Q?E9fIdOEhFJcCrY1k/wYsHoXY4cuSoTRPjyJ8heUX+6Dbuv5Lqn+MP5YvRexB?=
 =?us-ascii?Q?fPS2BOmICQT366pPV+2NArsCSn3bh3f2sbsJ41/ubIsKw3/5CukQuiapcUuA?=
 =?us-ascii?Q?l4jhXnlqvdzmkZ3/EfDu2U+ijCHHYcbFWImxnjKWv9vDVhMYrlO8wetg/JiM?=
 =?us-ascii?Q?xkhudW3/06YcIHyvtXDYMTwXJoNkyt9z54PjWF2hS85qT3u+tQeDxMGw6U0V?=
 =?us-ascii?Q?tmhx/wpqKLAvJI0kLyrmZ1KcIE7uG67Kh0hA3kGnp5GKmhYHyQs9ic/GfeZn?=
 =?us-ascii?Q?CJVM72KV4ANKAD9b0ApdjhHM+/PgUI8nCxAOQ38sWrCwIf5Mz2mTw6+Mxw5Q?=
 =?us-ascii?Q?PuetnYBYOZrglv7kEQulHgf5Xn1M/XzhtMsOQWd5pUyoRC0a8b7qm+T0Zdbw?=
 =?us-ascii?Q?WpLm/iGiw81Y09JDK0lYB7gcQOs1TYiC9ZA053tU+2jL2bmNTR6bjojHvGJ6?=
 =?us-ascii?Q?Jm2m+tt/Wbpa8V+bbf6RKczmSMzMai1UVh89HKSoCwKkJ13gxbnsDI8pBcdR?=
 =?us-ascii?Q?bUUvB380kfDovBG2fMTaUsrZ6fYd/ZNCt19WFutCHkf0QTS/BjfJq6Eo0uMz?=
 =?us-ascii?Q?BFkfZlHKCw2og/U2Ybnsj2scAJVf/2S4xZliJL2lAeaBRhim/c5rE6/80Zkg?=
 =?us-ascii?Q?d5wIhHpzcRw0NoMKXDnU6kgpayV4IdSNmnf8WDmIAK8Fam7NA+cAp1Ky37Df?=
 =?us-ascii?Q?ywtr8DYcVzw9XcmLWvYqWLAMd2jVsNh6pDZuPjR1vlcn0+jUpAB4ayoHU76d?=
 =?us-ascii?Q?00KmdVUtZyR4L80YvG2LrbsYL2F/iBHpbiPXAkKvceHSNkNTcaKM0grIdIje?=
 =?us-ascii?Q?+TEmSw/4DjNZMyh77HLkyQqak1jbUqwYZetvqQ+IOgTYL0lNOKvzPTR+m1JP?=
 =?us-ascii?Q?neAqtDcjF2Dz8WOP5wnZhusBRCtw8SwLxSZ6iwefjgDvxOLVVBJRfdBjxNzZ?=
 =?us-ascii?Q?ECykJaXVa2/H7v2Dwi6QQxdiOBUTK5jKAjLY3tF8sIFQal7pVE9WAm/wCwwQ?=
 =?us-ascii?Q?xOXgsUzglg2HGF94DWygibS5ptXNhjp9/hVi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 06:03:00.0271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dabb3754-b46f-4113-6a9b-08dde466360a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
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

1. Unified amdgpu ip block name print with format
   {ip_type}_v{major}_{minor}_{rev}

2. Avoid IP block name conflicts for SMU/PSP ip block

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 35 ++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e117494e8054..5754b1fe77be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2447,6 +2447,33 @@ int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
 	return 1;
 }
 
+static const char *ip_block_names[] = {
+	[AMD_IP_BLOCK_TYPE_COMMON] =  "common",
+	[AMD_IP_BLOCK_TYPE_GMC] = "gmc",
+	[AMD_IP_BLOCK_TYPE_IH] = "ih",
+	[AMD_IP_BLOCK_TYPE_SMC] = "smu",
+	[AMD_IP_BLOCK_TYPE_PSP] = "psp",
+	[AMD_IP_BLOCK_TYPE_DCE] = "dce",
+	[AMD_IP_BLOCK_TYPE_GFX] = "gfx",
+	[AMD_IP_BLOCK_TYPE_SDMA] = "sdma",
+	[AMD_IP_BLOCK_TYPE_UVD] = "uvd",
+	[AMD_IP_BLOCK_TYPE_VCE] = "vce",
+	[AMD_IP_BLOCK_TYPE_ACP] = "acp",
+	[AMD_IP_BLOCK_TYPE_VCN] = "vcn",
+	[AMD_IP_BLOCK_TYPE_MES] = "mes",
+	[AMD_IP_BLOCK_TYPE_JPEG] = "jpeg",
+	[AMD_IP_BLOCK_TYPE_VPE] = "vpe",
+	[AMD_IP_BLOCK_TYPE_UMSCH_MM] = "umsch_mm",
+	[AMD_IP_BLOCK_TYPE_ISP] = "isp",
+};
+
+static const char *ip_block_name(struct amdgpu_device *adev, enum amd_ip_block_type type)
+{
+	int idx = (int)type;
+
+	return idx < ARRAY_SIZE(ip_block_names) ? ip_block_names[idx] : "unknown";
+}
+
 /**
  * amdgpu_device_ip_block_add
  *
@@ -2475,8 +2502,12 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 		break;
 	}
 
-	dev_info(adev->dev, "detected ip block number %d <%s>\n",
-		 adev->num_ip_blocks, ip_block_version->funcs->name);
+	dev_info(adev->dev, "detected ip block number %d <%s_v%d_%d_%d>\n",
+		 adev->num_ip_blocks,
+		 ip_block_name(adev, ip_block_version->type),
+		 ip_block_version->major,
+		 ip_block_version->minor,
+		 ip_block_version->rev);
 
 	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
 
-- 
2.34.1

