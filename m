Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30F1C02193
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5188910E582;
	Mon,  3 Feb 2025 21:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Vi5t3eU";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BC410E582
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHqpEW9ZxsmOcSnll4naq/1NDKK9D+PogJGcSexaptMf4z7Ss8WwcWex5/bboUtjYYG1ZJgg5v8s15xy4rt2AcsxpJ2iz1awv5Og0fhlRicOI+8jtqaVj1cm7dBqr9uHm8ZgLDGWRsemjgaCI+Bqjy7nL8TpnVeG0xbeJsX3petGd9k7gIvYaZ0GnWMVCgIhX4vNmQU9oKsb4vEdDcM8oarGnzO5A2wHtV+OIPSZ3ArmxVaAFfkI+PTUcfe0jFI0abi6lHwTd0/1Ivj8bmJiNMEiVYDXJfzP0K7esNRLeiWfOFev7Svp+B1Pm2XqFH62cZKE0tps1mvf7B74Kw2V/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzCl+3Ma9dLJ/nOF1c5x4i/cR1oszSMd155PRD2RlDU=;
 b=KyvnudlBB02HguaWnNHY50n8GIdUErznJhNtJtKjS8WRnibL0OLIW6r8OnI5Y/UpGrTGDuPKAQ2xi9PonuM/ZghLyAB858Mk4oJtdkvWgz07P8YXC+QxXyZXdL1rGCgoeOsqp0fitva3DGlJHyxfJ66PnDZS284egBDPDzB/XEEI4ZRkI/biVmVwa6JdX32VgXqzeCt4aWApMd7EXrKvm8w/u5cnw48HattzJ7ro9lWH169biD71o7LCeagyTD6knTSLIVtV5++wm25Ug06pN+Sq4FXYNIVmBvyWYnjX2vtCGYb4YpEhTsPT0tmxQGJyYEeuGk/AHXA9b4XjFB9E4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzCl+3Ma9dLJ/nOF1c5x4i/cR1oszSMd155PRD2RlDU=;
 b=1Vi5t3eU7iCJdkH3Iwaj9kuRFTnsCqoA1wYOr6aEL5EUB0BDuU3nUMd/F9OBeCKpQRasXIPT/B+zlY63Q2RQPdNg2W7jEXDvKgwWJuo2tZQ7H1Jx1h7tlWFsRlcHtdM+ESdyJdI7uej0FPpwDnhsbtHEDxb0chCX7RUIh0SQKyA=
Received: from MN2PR06CA0003.namprd06.prod.outlook.com (2603:10b6:208:23d::8)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Mon, 3 Feb
 2025 21:44:11 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::8) by MN2PR06CA0003.outlook.office365.com
 (2603:10b6:208:23d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Mon,
 3 Feb 2025 21:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:44:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 15:44:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/11] drm/amdgpu/sdma7.0: manually control gfxoff for CS
Date: Mon, 3 Feb 2025 16:43:48 -0500
Message-ID: <20250203214349.1400867-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203214349.1400867-1-alexander.deucher@amd.com>
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a19c11-7b8d-4dce-b3df-08dd449be525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q+pEriGoVr6azC60zhmZPRe14Yhl6HgkVLQd/qC9WmwMVYwA9cY/vBr+rdWQ?=
 =?us-ascii?Q?hB0jKk8GS4SH+qqsCPzT3RYTkn8d+6xEKoVsnYBLgtHhS39vXiu7/7m1j8Km?=
 =?us-ascii?Q?otwmeWvncIO5zGCMnxnkuUvwk019ogvrS7uDc3c8We77yQuvhMEu/eZIqdrP?=
 =?us-ascii?Q?atMQPnOlzgZMjZcRzq3Bp4jUvjP0sSBA3s+CszolmEJFFei+Xb43qC1czgkC?=
 =?us-ascii?Q?d2FRYDhPS/v5zI4HhLKn8qy5AwHrIPC+dFNGwYpM8L7ijJZAAVWekWwQe6hp?=
 =?us-ascii?Q?sGmyRDTB92DHxJq5lYyjeTa02n1Hw5/EZb88Cw8so18OpDXrThoMbzNNx9qJ?=
 =?us-ascii?Q?uvJj2BnipoyHN/c9IBkrPbAa0C2UWNs9fhoEHKV5+QJZs85M5mx2faVqIzn0?=
 =?us-ascii?Q?mJ1Byw5XqCxQnNQb91rbS06SzykV/p+gPfOxlGiKL3XK8y17eTB85zJxEzPi?=
 =?us-ascii?Q?K+M7GqUSVVX9R5jVMgEqv0sKTPakaCUhMvhLNA5grR3nfUyVnzxDfQkYWguI?=
 =?us-ascii?Q?dG2PPCa72O5EJGZUddaBCBTDcKYtaTpNSCDl2gkWmgc9h+QKKId4734UrLIL?=
 =?us-ascii?Q?vGIbIdzCRQcRCbzWQYz/5bqAotn+FpWPs9V0wdpOtTmr8T6/F+gF2yRNeDJx?=
 =?us-ascii?Q?qtycrK+PU+yGPmk4r9X9ZswyqB2z+2wacZMn2VmZQX1UgDJYR7n6zvUkHGTM?=
 =?us-ascii?Q?M9n+vvATxiFtHygRvT/WYT2EBwOX1GMail5vKI1xfv73QWBta2+yP19LmiTs?=
 =?us-ascii?Q?q07tk1qAmoS137+wvmmiPdIM51eLMz+Hztz9P4escYTO4jCg4jXDicquRW26?=
 =?us-ascii?Q?okIlj+EyUEvGFfmyxra5wVoB5l5ph0FijtXdeK4uu35Dja79HO4s/f56LXLj?=
 =?us-ascii?Q?32qhFy9sktoTn6dB9CtvrRK4VaVjs3lLckl5iJL28TF7N9n+PTLg3OEqurrd?=
 =?us-ascii?Q?UNhALy2IZDsujhBHnF+8h1+Q1YsuYcVMKG/Tqg7D1IYcEt/aNKWU2X9asEdf?=
 =?us-ascii?Q?v1fGZLSr283CJZ9JZHFQuVltVjwc+yfZAhsP40wSOC4akUJQtC2wt5DUnvXH?=
 =?us-ascii?Q?dNT34t+fOLslXt/iB+8BkfMevwu/vz5UhwkreUTJaeEDEHfPJWNDSk3JIMrq?=
 =?us-ascii?Q?nxUlBIkOSej70Rm4oSx2IMJ5dbDoe+Rk3kJI6rZNs5HmY+d1K2rSKV95TcFl?=
 =?us-ascii?Q?RqmiGcFo3o6Rsrz+eCyjg2c5RMAHYgouaBT+CfNFMv029eF1yHcpw78mNaW3?=
 =?us-ascii?Q?ncDBaeMQlNNkhPKG5g/YzZUfLva4zsr/odhz1WSqmKtB33Dd8VPbrECn/PsV?=
 =?us-ascii?Q?levnzbPCQsJDDNszVqaXfxVjyeHj4pbIea0pA11ADeerpFZgwhnHH6dTuS3x?=
 =?us-ascii?Q?fhpmRRit9nZoQGmcjHaEbEu9tV31lAWVHsTGRJ5eErtEypGDNN4WHoohA+JM?=
 =?us-ascii?Q?XYE5uNQzc7GgijXMVDgY+/tLlDBIXK3PTCEHWIZe+dGC3rxCYLNtm3vij8XN?=
 =?us-ascii?Q?uuEWNamJSjOXyTw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:44:11.0770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a19c11-7b8d-4dce-b3df-08dd449be525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
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

Manually disallow and then allow gfxoff in begin_use
and end_use to avoid any potential FW races when
ringing the doorbell.  There are no known issues
with gfxoff that this solves, but it shouldn't hurt anything
and shouldn't affect power usage since we are only
toggling it around the doorbell update.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 9b40ae67a92f7..53ca808fd1fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1646,6 +1646,16 @@ static void sdma_v7_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static void sdma_v7_0_ring_begin_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, false);
+}
+
+static void sdma_v7_0_ring_end_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, true);
+}
+
 const struct amd_ip_funcs sdma_v7_0_ip_funcs = {
 	.name = "sdma_v7_0",
 	.early_init = sdma_v7_0_early_init,
@@ -1701,6 +1711,8 @@ static const struct amdgpu_ring_funcs sdma_v7_0_ring_funcs = {
 	.init_cond_exec = sdma_v7_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v7_0_ring_preempt_ib,
 	.reset = sdma_v7_0_reset_queue,
+	.begin_use = sdma_v7_0_ring_begin_use,
+	.end_use = sdma_v7_0_ring_end_use,
 };
 
 static void sdma_v7_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.48.1

