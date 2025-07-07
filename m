Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119FAC83F0D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A1B210E53A;
	Mon,  7 Jul 2025 19:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AEfWuTkA";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A9DE10E537
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLfuadRSMO529H68Q+epNDuDT4VCosCv8sKbbciN05XWHL2/e5k9TiScAedkA4W6uvTQlKFmpmI56KfacQbesDWOuoPPGI8a2U00Mue8ZvZwp9OJghOgKnp42ohPEIP2IqAjJSvzy58g3INETHUbZEDDLQY2vdyy8l0kpCxyNb8zK8p3OjM23PpBultfvhsEK3xc3b4aN+SiVw3DfBKRSBuLbjmZZMMFrz7px/HNDeJ+4wYg3XjQdjoS/DKbSq9lP6977xKNnW6Vn39KKaqNc2Rz0baIlNDx86KXmMCTNbyGBiwt/oEKNa95OwTBzG/RpECOaCYG/dISqrPc1W1GmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dixyMWDPZPnxdnTVlxhfsWKG98IbeluqfE2LJYNDmq0=;
 b=dEnAkMerFsO0/tIqP3RwDFOtRhfbA5m0kCnw15LyBQ2MVlgQX3ckTBGHKSBmG05YfzPSNdOps5SuQ54b9BmtugJm3d6GDLjBU3khNkqsjwBzp6vC9EhJBYDj1eGsvQTjoREt+DHRJ7rc5dTgrvPwDfYuw57o2Mnqackhtfa9VRN0Qy2rcqTid5FPurWQe8OrQTeOV0cVccd0dzUUq3ybb5IbQvIteWQXYY8oQjaP4bJmmhDqaP1P3pHN0j1/xtAaJIkFUwB+tUYBaGinXwR1fFyRnuQLL/mxp0IrAowLl4gBgMlWVFvlp+hdgK/90geNpetwmcXuyQPh7jc37gitwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dixyMWDPZPnxdnTVlxhfsWKG98IbeluqfE2LJYNDmq0=;
 b=AEfWuTkAGE6KI6mKorJdQwzWhQ/TN2gRoNlsr/KpO3IixKywxaeY/x7BI0kJ9/pzD+DM76Ou61FZfv2aCCxK7pk27il574NA/ifG95RfpSbIZaLwl5P6ZEiVdupakVamBXSMymumBnpyHGKEotNGMXlwlgOMpHHVny+HK05rv2M=
Received: from PH7P221CA0090.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::25)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 19:04:23 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::38) by PH7P221CA0090.outlook.office365.com
 (2603:10b6:510:328::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 17/36] drm/amdgpu/sdma5: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:36 -0400
Message-ID: <20250707190355.837891-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: f56dd25b-fb1e-404b-970e-08ddbd8915e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OgZZv4OcUTDxK5TT+/1HoksGqtuZ2gGP3F1eDt0wanO6LJSRU23hl2CEhl/5?=
 =?us-ascii?Q?ijpBSO8eG/Yl4CRa5fzk5hDpf6aXc2KoBSKPHm+eWR0iSwN4AowuW+qr6UCB?=
 =?us-ascii?Q?NzkQU1DU7kiurEzcEyXAodbYXeSGZnkWO359LgtLSG+huwh1GSlNznzarB3o?=
 =?us-ascii?Q?OEnVlwv8KFVtbvrdAdiPI6L3AZOnoMaZlUKyFkjk1qsy05T4HZVW+qMRbQ+g?=
 =?us-ascii?Q?hfbOXmK3oY4+DfIa3Jo2VeppG0lA4n+VY7eYmWgozAtDBYIIO77Prdm4DMFw?=
 =?us-ascii?Q?/fS5IvGbgFebsnkHPEo/szmdKYmksbHIJHODEZmSqh2pKi4eL4Gmb9wHAZB0?=
 =?us-ascii?Q?0nTDVg188tCiPYQJTJ0OW8FMppC0mV8EgEqGoy+Uuc++oqtruOIiKh8DGd+W?=
 =?us-ascii?Q?DCnClltCKs2cTfEfu7Ov4KqESSzEtqgSPr3E9UaGElhifwy3GK6d8VoK0nGh?=
 =?us-ascii?Q?mhpEKmDcfHIeUPt1NxNWH3qNmqyZKedbmbNC8H0pR9I4Xy7JivLdLQ8ZDBJQ?=
 =?us-ascii?Q?oPasyaXjkVkK1rouvuIZFUp4CN9mu+sNN4L3V6mzCgTuDT9xEMwG8ebygREW?=
 =?us-ascii?Q?Ow0fcGrbTzlXjOePHnrVYtkuTlkLQGaOZ/JrCD7KiShKs1Ofohj1rvWuO53R?=
 =?us-ascii?Q?c6T12oAbeNXUA4+JjxeFSdF87xAFUBt4hNHTUPuUs3XdLRMzQCB8Ta97CCoB?=
 =?us-ascii?Q?fTkXAphf87p0ckH3/TLWPFoYjRrQCn7KwWYtgLLb6ydwXm0rHM6EuHJDP+1Z?=
 =?us-ascii?Q?WpEWXs4KIWPVAkMaZKIpOfks9kwX1giVmb6IqKexaOcxwFfeLnFmoFRmR2kj?=
 =?us-ascii?Q?Y6eZD6wQsrzojGIfEQK9YZAFvpHnQIvv9PlwZJ0xFMrqIbRx909ghMQYKUGH?=
 =?us-ascii?Q?89tmUARwUxWTFZS57c0lgAzjVFvdUD7+4Lcq/0ts7xC1eEBtIx7oacdUdmlx?=
 =?us-ascii?Q?zL4P72DgwVj5JXKsVtm5CaP32CD/mUQZxpf2OPXf7j+AxhCmZqGPKpUmlBm5?=
 =?us-ascii?Q?QllMhPcbrPzET4TlcoQD5rUuRcMnAg/Ch52ibxdoKJ0cUs3qP/x9vq+7cRZn?=
 =?us-ascii?Q?eEB4EikUbFo4aBWXiW1ds1k5saDKijQYEpM0lseone8Rr3fvt69VhMMNSuwl?=
 =?us-ascii?Q?WFzXyVBROUVDC0YlBnkKjXqthRhPsD/86sfcR7DPfqHZkzaBKT9b56bmr2V7?=
 =?us-ascii?Q?PrD3nhfLnC5EVAh100+6USdTvvIfCbzEzU/O+0MrI8WYnAYqwoqKfNlbhQ83?=
 =?us-ascii?Q?rsUO8iSh84Mq60sIKsZeXtwzy+MDjxX+L1UfNCup9ZYm3avEr66YVtdr1DTC?=
 =?us-ascii?Q?sFkZvAom0cmdJ5xPNEfj5zg5RKSnVlyQC1rsSPomuPA82i0LE/xWpDPu0hpV?=
 =?us-ascii?Q?eyjjZb+YAjVTxuArcpYsYeR/uCgZSAi0Z45Ux3Kb8/dLdpOB5tZOfZYfE5OW?=
 =?us-ascii?Q?TAVXUSugs0PBzz5Gq26PFgyir9vykoLpwuf7pnTggOjL5t4SSFd3kX8bPnf+?=
 =?us-ascii?Q?XQYLBMt9IJI20S9h14gO2ICY+VZzcqD2tWFs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:23.0874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f56dd25b-fb1e-404b-970e-08ddbd8915e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1d8ae5ef6e1c4..681fe48fb52a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1554,11 +1554,15 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
 	amdgpu_amdkfd_resume(adev, true);
+	if (r)
+		return r;
 
-	return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
-- 
2.50.0

