Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5008C7EE39
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5297910E81F;
	Wed, 25 Jun 2025 21:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eMg7E84f";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A6FB10E807
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm1guu1Z5cz71cEh9zeTKuitRDoYWyKV1/8kA3S+llwj8EqdHtLVI8+dHWbdGQqGhzen7WiGzh1l5IoYco28cbGlKAWSkmT+hvyAI0NjMggREnXwWgUhB5sUsnpngsHo+lZQAT6vjCC7rxL5vSJz+3vWhncP6WtRj7+1E3LH3z/qr2umL3X7BL4eVoqYFXuOBbF65cVwP+5RQQo+GiYMPIvCgF6uUmGz41Mgvw5Madc26y2+32UmZ/9U16MhKIu+6O5PjqavWgR1bMhCM1iAfKqjSg+f8abFsDfLxBBOdD4bvSt8x+MtAx1MeNeJGkqUVHEp0fetTWkermVAC6oFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1aE+n6vOIIcTyD0tJb3qdXNZ8hyo7zb6YRzBI5AR1A=;
 b=IVhs78MrNbIe99UuXo7omDv3akCutvokqlBi1L899xErJQJwGF0lPT1Lq7fWhZFVDfXpr0SA/SPqo1NhrBsPvkQFLkpTNopshlT/AwBfI8t/WGZ7Jo5tgdJc0AZL4EcAg3ku3hUmCUNypR8kaeg69cuzfJRD6uRSAfcCDovAHy9PRRUwDqgIEs1JkpHHihmJgDs/USFHb1Y3dja1Jvuf4ZKOnHxg2rdn0Xaa7/hsx5fzxgc8lTIBMAx40vYWbU6XR0ImJCEyLwf5Bl5jfLsyeJr4SjlOagYFmfE5Fdbe+0aiatbOv5jJm+xxNogSVms2tL7+0LuQuh5qkDvgpMCERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1aE+n6vOIIcTyD0tJb3qdXNZ8hyo7zb6YRzBI5AR1A=;
 b=eMg7E84fu7Kf/v9PHvp9VmtxtlZAj1MPNXpQnK2Q/hC8/IEofYyyKCDduhLXhHDuKbQwizcu/SCMlb43CfVM+cuG2yvZWT0sDueQPfQS4n8UYNRmtFBxM/oLjI+I3HKhySJoxDRPXgRAy7FhOvP5ckgLWZ4wciCkXCccAe1HVtY=
Received: from SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::29)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 21:07:10 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::d4) by SJ0P220CA0006.outlook.office365.com
 (2603:10b6:a03:41b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 21:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 21/30] drm/amdgpu/jpeg5: add queue reset
Date: Wed, 25 Jun 2025 17:06:29 -0400
Message-ID: <20250625210638.422479-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: b631a59f-3e75-48de-b3c1-08ddb42c3ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G2av3BaJpwsamyqyTIOu7pXuxuAqQt6jyaP0X/VTVh5bZQ2cms4xWW8TQZ0N?=
 =?us-ascii?Q?Pzgg9M9o8QI4ulVwWjWEPdLCBi3nS4Y0guv0UPECjwIrYkNtS6GJbzBGWoqU?=
 =?us-ascii?Q?OQkJKkQEZBGx8RapTWLS4zp8MDBqWTLqeWne5dXGNEdmjbGBSYjOtVn41VPb?=
 =?us-ascii?Q?1W+kW4LbM52KwKfe8pDQC7mbYpVIV2BBPfS6Ostgim/g9ZOXrP/nUhESVuWT?=
 =?us-ascii?Q?RFalTNOt0Pc+6+XQnDYSOl/qvVLyW+QlK7iNvzdblPHmPguLdXKoQ2+Rs1go?=
 =?us-ascii?Q?Gmlx9siXkCsFoVVYNpBGggDF+LOb8mghM8C8yDdTocrICsmidaGsu4Lwm575?=
 =?us-ascii?Q?MZQO/QkninOIOsRWAAZfyxKYtliZKfSiJAAYL91NWJVI8bHCTCuqU3bC6FXs?=
 =?us-ascii?Q?brpf+ddsZ5kMlyf3qcevPJ0S+4Bq0Wt6gJnlaPGl3xhiG19q0IrZBBoJBuC2?=
 =?us-ascii?Q?klgbbEbix5GHGp0Iz6ASCY07r0nnMH/SU9vohp81XhNABuUbpP7zX9ESqnna?=
 =?us-ascii?Q?9CIF4iN9fl20chdskiVB9yaK9JNQPd7ffobZ8rOE3PPtaxMVO7djNHPtTuxr?=
 =?us-ascii?Q?cVCCUTXjYyqXkdAjARmgM8gPHVpIYoFTfyTviNLiPPPkPha8hxpwt5WGZgBP?=
 =?us-ascii?Q?yJieb79SWDe/Lg0Lp77zpGZXTHw3VoGA8X0NhzzFy/3tMKms1nYSRiYKolEG?=
 =?us-ascii?Q?E8uE0/Xq4eCBgpB8ZPncwkEYh93SKveEqQghR+1dgS75QT7Lu54+4L/Rq6gN?=
 =?us-ascii?Q?IQFtIhEswpBdVCnH1UcIpReXrDfMLZArXl3sjbxUd2s68VyJBOGg4FgKhGpW?=
 =?us-ascii?Q?K9+KZ8uVRQN8lJk2X+but0g2aT3MdQcp2lNfUbhOgqXnR0R8dPFEd9DyNW/u?=
 =?us-ascii?Q?jBdtG+aXLysRuwHMRxLUdTOEN5NenABNst0ALY7JMp6m9GGjilx16pwfK9zX?=
 =?us-ascii?Q?OYOzWPZwCdz5HqUjq5opQ7GNMpK0dD+6Lbg84Fbk9cUJyGpebuDduHuCO5cE?=
 =?us-ascii?Q?OKk4R0FrDZuMmg4Odr/wmYehG1U8/daHpcXDCdZtfzEX3APEa3h82dlryLsV?=
 =?us-ascii?Q?akoCxkOrGQ4VqcPioZAq79QWd7XgTpM3tOLd12pF+Gx+sob9QUmK9GzyRktA?=
 =?us-ascii?Q?MuXQg+uuMtMIw6w8L2rBB/HOUMRSbX4c8i2Cj7HDcPpZagSPrDx6YpC4OGBn?=
 =?us-ascii?Q?euN+z71K/dSugZw4Y0vyCDXJAR5DVYvHlOy23G8RbNDJCpXksOyQEgtYCXrs?=
 =?us-ascii?Q?NvPw3M8zrR4KlXjlhPF29u4jl2ZQBfirT7T4l2vDhAwm2OJtVA2g3drXwlMS?=
 =?us-ascii?Q?jhiU58FDnjOqvi8Q4dP1qUECEVbyIA/IUcn6EsDlYY3f7zrw8F88WtwwCp7s?=
 =?us-ascii?Q?ymA94ic2v0HJZeDDULSYDUqTb8XmB19Xgt5MR79U1TI3laQb5/7kCkHCJVSv?=
 =?us-ascii?Q?hUVHfAO/R9pHRMye7pKHQvDPbDlc7OUAdIxj4891az9VzrvPNkn05pX4AXEL?=
 =?us-ascii?Q?ecwCuHRR6Iqku4Rbun7MAEpbNWAmtFYKf/ur?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:09.9899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b631a59f-3e75-48de-b3c1-08ddb42c3ff7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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
2.50.0

