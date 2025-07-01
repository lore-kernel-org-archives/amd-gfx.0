Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB15C83038
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D6A10E62E;
	Tue,  1 Jul 2025 18:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oMQ1AUM0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C593610E2D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClqfKr2jW+Zr+KMN4p8h+h0giOtG3C4jQ/ZAE9knJYfgNzr/2MMViaqEXRBFVnD2YqjNqWR2Lq2yse59vvF89zvS3QgqqSIOO2rKqo1IQ0Jq0v2tGOKF2fJUQCnO4/xTN3KwWow0x/Ns5P4TG7snBP3WXgGPAlICw8wJOQ2vRn1FDts9y3scfpsIyLh/TN4x5eAQTKxeoXGfO94kJwFXD+a6KpvJnd35Mh5LYn3zARZKgdRm0V3GrtuLVyw938fXATC0YEbgsiWNA7T7QTz91hOSdKeSER+H/JqjkLvx4Z8ojjSWaNb3DduYnUJwcW7yFhRK+PM6c1knVP376r3H+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEfvl7gBfYyZ9t2ZhvSSlRj664kmzFOWlLW5L3oy29A=;
 b=wAibcI/L1LmnkSn6aBtvKI+mAsXgYaMBqgzXWPNcq7qw+jB7g1uafM+fPICmSWUUhJioJSuLbHo8oVvgZ2nG68kM4gdv7sxRoiml65MULInIhTS0nP5obXdMMSZ2mgwlhOsO+cWWXwysmTfMC3onFQREOU6Pj1F0Bh0SD2p0TWKmcf13QazOXTsRQRyyj5rGM16SrZtOiRJvBH/M/rZefoeXETJ6cchKZ0fLec4Tc6jLRsppiHlYdq83GgjPKznZe6buP7vJWZ3AJNGxtBvdpOCRwNls++w3wTqnOeEtkjb64fBuWKoB82tDY6s/BDCxJUEpeKrNbC+V+44nu4jM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEfvl7gBfYyZ9t2ZhvSSlRj664kmzFOWlLW5L3oy29A=;
 b=oMQ1AUM0thD1LFrS6KWmHAcwgvcxyF9fKHkUfBKQBo1bjbbqqKMVWD8JmeJLjXDyM5HNlUAYYhiRl9Mxkh6sZmkHT6N6mHPACQPJWGy+FRViT+FXU6TlSZgoyUjw8F4N/pALMe5YTlJhiYPScxkEaaUTOMqBnN3brcZa35L0dnU=
Received: from SJ0PR03CA0149.namprd03.prod.outlook.com (2603:10b6:a03:33c::34)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.31; Tue, 1 Jul 2025 18:45:17 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::4f) by SJ0PR03CA0149.outlook.office365.com
 (2603:10b6:a03:33c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Tue,
 1 Jul 2025 18:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 18/28] drm/amdgpu/jpeg4.0.5: add queue reset
Date: Tue, 1 Jul 2025 14:44:41 -0400
Message-ID: <20250701184451.11868-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: aa313036-9fdf-4673-17b5-08ddb8cf6c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gN7609PudAoTy+b8NaFrQ/xEbrGAT4tHc/OaV5HVYMjLTGJfJ918piVI0A++?=
 =?us-ascii?Q?nBnFR/SccP4t2WId8FOqvGisSsTZ2lu0Xa+0vFQZtkPqdT2r18lJicUgZuf3?=
 =?us-ascii?Q?L7s3SHh3gV2ExcZuS5nbyUuiHsbGDezj735tcVFnow0YRxzLK9q3kIDtPtwk?=
 =?us-ascii?Q?W8qfigdHN3/PTqDN7ZWV3jRiMim75gIVL197UPWV+sajal9GlaWwUXg1sPrI?=
 =?us-ascii?Q?0Gn/HtO3OFZN+LkwvPPgIrgZPkml8KLd+HaeFRIFsfa9Lh5J2Cw+tL0mgzFd?=
 =?us-ascii?Q?vZbPNYV+MCYFQlVgxzVRUKn5CxDwGYNTwJOOT7DTkV5/tZD4X1BMpbtn7Xow?=
 =?us-ascii?Q?0livoys7/XbVWge2KIloL3Uli81gI/TO8NUvMO9ZehQcgDDxROGMlbHMQawC?=
 =?us-ascii?Q?0povH4NLBj8L0bQlXf1pwnO6zLabo1DdTV/G0WWSrxkipJreDnE/9csPEsyc?=
 =?us-ascii?Q?6vMNfR+1ye690pscK0bRNhrr87rjPvk7+X/n7GP4TI7EeeSaTi8XOxDp9MA1?=
 =?us-ascii?Q?cQsEVFlcw0rJ0aCWT94QBHpdgQGhDAXNa0hfmvuVE4xzOXdrU9+8tPJ306JF?=
 =?us-ascii?Q?JSTuE8nLuTMA9wsRcwQLRtUcim+wdhy+l8h5flenXIt849NMiN1DOePqhlEN?=
 =?us-ascii?Q?BUd0JUO4OomJThhGNsUtLpeqtTfE4ICH/gzOYPGteNg+3Q/s+wAjqlxmM+Ma?=
 =?us-ascii?Q?1tYj0ZjkyZd+KhA0BmKkxAcsG2jLkK7i5o16ajOSHnnkelKT01OuNZeqcMCI?=
 =?us-ascii?Q?/ha+iPOmoZOPaB1zCytlEvfeqYQaELSaEj5uwp34dJQFJcCBurkeMrYXwJ5C?=
 =?us-ascii?Q?lzJJtEFwIhw4RqlcQDtX3G2DmesBIW9zW9egDA/mIti53KjeZvIVLVVA5Pvl?=
 =?us-ascii?Q?d2eaRU5+Do7FbfLJWMp5SYI1WY0yFZFy6iy5J7WRLLQozmk19mHZBbOWghEd?=
 =?us-ascii?Q?5vY2cmedtYq2xuQkFXX8RtH/TdBetZuKthlCWSXypphojcpKr93aE4sXe82q?=
 =?us-ascii?Q?jpG0VwmNWaxLgnSarSVTSbQPoHpeZFZcFByB/EE84r9JEsP/69/S2tHn3JHk?=
 =?us-ascii?Q?bbtvhyR418axKScT0W2cTlRKg7stiBHxYo4E5Gk8SgbgaIyea4TI4k7Y7N0s?=
 =?us-ascii?Q?0+9cj0LcRSkFsTMYaY4Rev+USzJV3L3F9ZkXMtRrpfKyr/Emh7VLOTz23l+z?=
 =?us-ascii?Q?Oy6GTltBQNSCFmvszdNnYKJXJBTIq8E/UWNWPyRg5g/So1O0ylu0X3us6NJQ?=
 =?us-ascii?Q?1rDjg6nNuF8skmASB+AY7BDcuWL1h3r+NR2Kt123Lf/Ms9RYeChK9QvQBwOT?=
 =?us-ascii?Q?9PXAoaFU7LiZ9unqNZyVkqDIcl0ZejemFQGZK2jh9WLzln7mo55ISmfhqXP2?=
 =?us-ascii?Q?BHjTyQpPo0nZoEqIo6UPq1KhAqCc98lbCfrrXUao6nfPP5MjgFhKgfQCtGPn?=
 =?us-ascii?Q?+4USxVIsS97uhjWMWMoqATj7CN8F6XXmhIBdN/uPwVSAk3QjXymHWQ8++U0/?=
 =?us-ascii?Q?1ctHHm798lKyOdbCb1OJxRwv/ZbOc5Rn6C+S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:16.5684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa313036-9fdf-4673-17b5-08ddb8cf6c0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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

Add queue reset support for jpeg 4.0.5.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 974030a5c03c9..e6e90496135b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -767,6 +767,16 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	jpeg_v4_0_5_stop(ring->adev);
+	jpeg_v4_0_5_start(ring->adev);
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.name = "jpeg_v4_0_5",
 	.early_init = jpeg_v4_0_5_early_init,
@@ -812,6 +822,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_5_ring_reset,
 };
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

