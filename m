Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534BBC77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D275810E41F;
	Mon, 23 Jun 2025 16:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ksYoJFMm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3682A10E416
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKugj+8LpKFsYxcUJEySRAzehvtL6yMMnEyAyvMimBvXOmP9U5y640kkcqF5f+UX84WrvChZj+JUU3R5D7TE/hRionmmP8KdzzYib4msYorInI0RQpb1d0+qBz/MTkZzRiNDFU+UmNf9wmsMGkIehOhvZfsC7K48T9JjUxlgtT1qFZMYqPPWnavUu4aAEyjj0K6dHNwPdrkW75HBR+JAkypMChYXW/0oqW6ab/o3d8LoSFBu1DZnp4e1i0BvaW8xsG+SlNCxf501xtpNbuYg7wzXZQf+iWY1tXcQuLZj2W0NM8uk3NxNrqwcaG088d3bJL4FFphJYNR5JDkIAspyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA8B3ziFsUMI+Zvv4fNrcCorQHSUHfbF9NWomieNB+M=;
 b=o+wD3pxZk42D/kcPBmO4M1aB7a4gKnRevmCX/RImzIpxFvdgSvxPYgvuqMz1jVoRhYgOmPSDiea5vu5FgVrACKSA4h1FpoyWKD42OzcRJ3HIVNtlqAXvz7Yiu5lJK4sTLKiKH1oiqD1t0ibEq5WNWxC3/FwWnXXanEQ1UJV2mMNCKB1EmLKO+zCXptyEzvbr8RnCvlEkQLl9cTbmuNcBRPHsyCGyF0F8hPxNi4yhNcbL2FQs0DeaJmGXx/UHjeV5jEfDwkvU9vSWxkcNZvnRgpKT6y4uf0SR0BCd+3mSaVavsSdpJk4euF4WxSss+fn1RCx9UDrgnVPkn145Ed3nHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA8B3ziFsUMI+Zvv4fNrcCorQHSUHfbF9NWomieNB+M=;
 b=ksYoJFMm09Cssb31qYhVn/sjerK6nTeGAYyf9H+U6YLMjG9NVLRTJ+OVCGC1IntjlxjIOkD91FbJVpCsdcsbHPMQBVvlJeqLiWxe+s9VJBZYR4zfhbmr/eG2AZDFZ3MbfLLdNVuYPgJKYVRk9dNwfiSjQNAsDZ3Glwc6njKqj9k=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 23 Jun
 2025 16:15:10 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::48) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 16:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 22/31] drm/amdgpu/jpeg5: add queue reset
Date: Mon, 23 Jun 2025 12:14:28 -0400
Message-ID: <20250623161438.124020-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9700ed-9ee1-4a7f-0b7d-08ddb2712098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sWeMzT5e+lKCtZzLWbf+6FKfziO6Gy4VGkMEUBHQcLb3yqhiW+xFCFVGkP61?=
 =?us-ascii?Q?wuhi24NFC4JCV5MUw/mf11pZsT5j4UnTilFSjw8Jlz+G1I+ujfrQpU/Wqg6L?=
 =?us-ascii?Q?4alB52+W9nGBZMx7kppmaTDISngzj23ldDzeNjUjIeSbiMgbzvBrpAmUy0vX?=
 =?us-ascii?Q?rFQp8tOqDTRsd3Ia115OaJ1AIblreWzTa9X4suo/f+VLQJsRiU/wDyK8CzDr?=
 =?us-ascii?Q?Deu6YFFJ7sEfFXzgY6elg+YeK7lV0RJKW94koQSeAdofY754Dw5Q43GqBjla?=
 =?us-ascii?Q?2i9rYTegBJAJRuV4ayujcNmVQmUyOeq9QRielojxqIE6DDVBJFmruBVgqA1l?=
 =?us-ascii?Q?AnC7UGBatG7V0WXzDjxZIGNDGLHGVgzLQxhXX2Whnla4AVcmP+jCU7d9rEsJ?=
 =?us-ascii?Q?P5CcDm5n33knDkEF5LkA3ZrqMeyNe2OTsFtBhBznc5MLZtfz3JRTvFBVim8V?=
 =?us-ascii?Q?ngkTW4FpcYNuQmG5p7B08ByMEwy7qt+Z0JBKS8aVZSvLmcqZOotGR4pHvtJV?=
 =?us-ascii?Q?sp3zk7j7WIzh0wPfELrELxE5l4ASJu7AWRFmeYFUk+eqpgU7bkvybi0qqSio?=
 =?us-ascii?Q?m/c4+jVurjKtgh/QlqLUo3V15d9MbX2Fy9rNwHfBu4YoflUQ6B/gk/yLw7C1?=
 =?us-ascii?Q?klUJjp3rJaZfEaaVtH/xULyBZD38FLNOvZvB4d3O2OisfDJLkdv/DK6VNh5c?=
 =?us-ascii?Q?sheXhxHjHaTvDbaIYa9d8SdBdk2p0ATm019geesCBw5COcSTyYHO879JJIyS?=
 =?us-ascii?Q?m5D/ep/oJd7RMHt0xyucpm/Q7mm2NvjLV7hazWpXej3oN6idE/NZ5Q53ahnv?=
 =?us-ascii?Q?norAEXSdVYyVr76KJWl4aTWH2pBAKYNi2MGt3CemS3Otemf0qOE8JL+u00S8?=
 =?us-ascii?Q?0PK8A6yZT3ZLmWN6mHHm254RE0iRpDRzaxvF/KWPtC/5jZMh8RIfHIYnN2yA?=
 =?us-ascii?Q?+kGdDZsx0/7F7bbUplrzZUKKlUrZBwd8OfGc+0KrgWkq/0r9rDAKMG+V6/ZA?=
 =?us-ascii?Q?wSoau8eCiA404yfvQhQWDLkAjaYPvrmxbfd0D7d3/2ZZp3splnNUOTYACvIe?=
 =?us-ascii?Q?n4jGw1AxpiQqMJiESeoTsUGadZBhd8NwVtglB2XxoLOSiXq8jnoRi233dYAr?=
 =?us-ascii?Q?/RJingw2VqFXiIdnZ8f13nFYAFdtaukkj9po44W5ntuhg/9tV3RmydFSzatJ?=
 =?us-ascii?Q?sqFXnBTtWEAldkVRFQ0o62vvits3YwH1F/dkdxESvydS5SrHEJJCwsu++GIg?=
 =?us-ascii?Q?Qmb9x9Qjdpw95mXP3HiJ0C7W3WYp028OdhaNuuucalA2mqQtp7GxihwyUe+P?=
 =?us-ascii?Q?5yENft+p6av4ys/EItgaHc3l/YZb66nrNSRC20Yt6isorBT0jFn6KadZGid+?=
 =?us-ascii?Q?rBYvSGpX3ONxYBX6GLE9Zf0k575d28HWQkUJtz6jY25Qwt0Bf+hD3gG8zPKb?=
 =?us-ascii?Q?o2uklvPp+r+QmsbD3ZSJTmat5OSnV/Z5ISS0hrMOtze0P9iZyd7K/GiG+gCF?=
 =?us-ascii?Q?G4dBo8bctQ3Vr/OzfprL+/GVYVCFmpM/3FVZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:10.3942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9700ed-9ee1-4a7f-0b7d-08ddb2712098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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

Add queue reset support for jpeg 5.0.0.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 31d213ccbe0a8..351e21494365d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -644,6 +644,19 @@ static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EINVAL;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	jpeg_v5_0_0_stop(ring->adev);
+	jpeg_v5_0_0_start(ring->adev);
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.name = "jpeg_v5_0_0",
 	.early_init = jpeg_v5_0_0_early_init,
@@ -689,6 +702,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v5_0_0_ring_reset,
 };
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

