Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD81C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 14:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD8011302B;
	Wed,  8 May 2024 14:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vALUU3sq";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5311511302B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 14:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao+9BANhzNr0JmbQkVMejQ0b+CuMlt+3gyQsEFgFSjZ6pIma3KZS4A/NEpwMobKWT1sC4j4nRLN0bSsUlCeiUNSs/6U4uTsnn+cY/iRWNRQxZivmuaoXE4D1daWoGQYv+9zg9OrImARgEBXk/1mImRgj4qnEBdpBbKmFX6hcJ4E9P/U/E/8Az6pdbfWoiP8m4IpknWKn7VtprWKrjkw7p0XZQcPKMR7Y9NJe3XtZ9t/UQcKeIH5/lKliMQZ9Ri/aI3+0aocS3oFpSHH6uXw6tY2SDfnWLHGoxjTKXD7L6iMyDduHXSXkv2BE2mngds4IVJwpQ4vsiMFMA8NeqGZLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJt9intR1aVDTOuVRPQzuiIzAgmdPHutS70t+f4pNB0=;
 b=IqU1FgwIe9AYhBpcLHnRwpgY5e/6nAkp9/sIN3Sr6enGAKDyyu5kAxaqcOe4jD9D0TTPaGrOFHfowhUVVxrKR2+6czuGrAMn4dZFueHkRuGtyNRtN1iHdWTmKgOfjMT/0oep0jBjE2aGdUMr8VVzqSVelnprlgmoM6C6puLAQ6gNjHDOjmy1IXKOCeLB46mjpDhRo6CcO8HkiKI37/mGIkTjgYudBq4+1qaIyhVAe3gna325HHKsvpsSYHqkpG+CPiL7i+ezePfis8PAofHI1wlLzwDbu3rg/JXrX0sEX85qt2dkZWl992iYyt/ZyW31aockT50K8JZRz437eLElSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJt9intR1aVDTOuVRPQzuiIzAgmdPHutS70t+f4pNB0=;
 b=vALUU3sqA64wjC55sGJH2R2MV9HHNST33Dvf/tY2drlhWTiTqDRvzU2VaBZ9emXjdwSQ5zLsxWhKAoCx6eH0i4nyxEW8zXqlz64udf/u33zgFjZCxZFV/KtUV5jDLuTICaxJ/EuymnQnTrah7U0inOfpnuGmH4orKiZBktzBTn0=
Received: from MN2PR22CA0016.namprd22.prod.outlook.com (2603:10b6:208:238::21)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 14:51:41 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::69) by MN2PR22CA0016.outlook.office365.com
 (2603:10b6:208:238::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 14:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 14:51:41 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 09:51:40 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 3/3] drm/amd/amdgpu: Enable ISP in amdgpu_discovery
Date: Wed, 8 May 2024 10:51:26 -0400
Message-ID: <20240508145126.254324-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d506b2-50a6-47c1-55f8-08dc6f6e5f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P79Abnz/fSgQCTiCMekemvuupyXp35iWtT0WPKOVkQ70vl+hEBO5bvnHqwko?=
 =?us-ascii?Q?eeA7GI530O1YJlgCXun19bz8Q+glo/ZDMmJlHKviVxSJHA9sD5bKeR6wXQoi?=
 =?us-ascii?Q?ALX4e8XTbogysgGfhE4h8FWns9ad6N7r77kHesSlO0BlmHiLat9Ew9SPmPjF?=
 =?us-ascii?Q?Z4SkZd1vsUld9nOEjayIx4IRMDxvQRKsUJvpLUTKHK75MW3g/ikHUCzHcHMR?=
 =?us-ascii?Q?I3HO8bAU5IWAjr5GRp0lkz9yuv0eMzmNC6lay6KTzFxWg+a5ZYlv6rw9x+UJ?=
 =?us-ascii?Q?VxvpTR1sJqRUqeesCCb62yzCzX0VbMxWHvXYxiZv1ue0/j+kBRdKN3aeTwM+?=
 =?us-ascii?Q?uRYMsboJO5A4bjFbqtCLrvLfQpB5q/dhr3EmTQ6TkOJaTGlAlhj+QnvYrHTC?=
 =?us-ascii?Q?YX1z/wBAHCsxLVzkJ1/QXsjcVGL0/5XJFHKfj7K5GDWVG2a1XUJRkHIyO+Pv?=
 =?us-ascii?Q?Xzm8DLSoOfJtV6uAlN5pqqr6BXnTCrfN5iNLX8DWoyJ9Nk8Vm+ngk8ioKmTr?=
 =?us-ascii?Q?NRW2DYGITS4s5w/STyzxYW+JTBT//EoE/QsvVG9aVEEPIOH3ssNwlhJC8aid?=
 =?us-ascii?Q?+fIs7c8CjEd/PfjmlRPqzLIr/49/G8p0H7smMA5YiM33iSCVol8gD+nD+mbJ?=
 =?us-ascii?Q?0wovAcmAa/hoRED1DqWcs6ml1q6+FG1+g9VsY0zHgCYI20LVuLj5LxGjdgEF?=
 =?us-ascii?Q?y83XTR8gvET1aL0gce3vqDdim6NRMxuJ0UHto6dy5skFUUJ/L1f6ctD0Ns9E?=
 =?us-ascii?Q?loQVbB5OfeRgsh2am3gVsjMzKEIuNNhLOWzw2Y0nXTzUa1KgbiaYTmsW7KA4?=
 =?us-ascii?Q?BkCnp0zgD5t3/NWsG5Fh42UhQtLhcV9a8s3VKU2FbzH3zzetU4ExfFh5A1Za?=
 =?us-ascii?Q?TpiFZG3wdUf0okEpZvLz/URTz1yKMIzKpYUloHcnuT0imM/2vnPTZfZtPtk7?=
 =?us-ascii?Q?siFe/7mK7aPk4qGCMPdFQI0GCCj1eNNvgC0nThdUJicQOH0eaNsffJaSUSko?=
 =?us-ascii?Q?MFtQMovNNrQDC/OxDVjLFtfpnM9zrzHga7W51YK7nhowU4tAoXHMC+nJLeoh?=
 =?us-ascii?Q?hdOjlP9K2TGkgcscKZKoYRNy6X/zbUWUc+Y+H4UdfADLzPDGh7QJQsFXXR53?=
 =?us-ascii?Q?LnaWQIkVo8/EA03gztYMdV65wb5hpvnXebzjEhrv4YifrudwTddt2+5FpsGa?=
 =?us-ascii?Q?iTdT51c2T7JtQBtp1tGUNzDZKNTO7xqJlvJFTuD134HXa3lvGCJDSYYwlAJA?=
 =?us-ascii?Q?SYgH/Febeo0130iQPazGYmY23kv2RvVqNfugxZSOGzrc7R2P2hJBB0hfXqp/?=
 =?us-ascii?Q?hewjEvmYKk0+GeK0FGOEEaUAkzp4LhthrShVuwrKbxDkQcSKGtUkUH47Nla+?=
 =?us-ascii?Q?DXpnQBo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 14:51:41.1578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d506b2-50a6-47c1-55f8-08dc6f6e5f12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
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

Enable ISP for ISP V4.1.0 and V4.1.1 in amdgpu_discovery.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6586feab8c2c..82d064adaa49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -107,6 +107,7 @@
 #include "jpeg_v5_0_0.h"
 
 #include "amdgpu_vpe.h"
+#include "amdgpu_isp.h"
 
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
@@ -682,6 +683,10 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 			adev->sdma.sdma_mask &=
 				~(1U << harvest_info->list[i].number_instance);
 			break;
+		case ISP_HWID:
+			adev->isp.harvest_config |=
+				~(1U << harvest_info->list[i].number_instance);
+			break;
 		default:
 			break;
 		}
@@ -2303,6 +2308,20 @@ static int amdgpu_discovery_set_umsch_mm_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int amdgpu_discovery_set_isp_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
+	case IP_VERSION(4, 1, 0):
+	case IP_VERSION(4, 1, 1):
+		amdgpu_device_ip_block_add(adev, &isp_ip_block);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -2829,6 +2848,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = amdgpu_discovery_set_isp_ip_blocks(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
-- 
2.34.1

