Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25657C77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6053C10EC64;
	Wed, 29 Mar 2023 20:26:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E510210EC5A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrW+lbTXEJsGfW3LzzwRlzr70teAcg0REDE+VQqxbvGAOh7SNIhMQgeoEUAwdSYp4lBl9eJEG3zAyDXkwal3BI8mzBk9uJN60fQCNPZhgaQYV44N620QJuIT6yZ8TpEi1rr2cYHD2ZfjcLPx+0tL3b5u9uzyoLNHRCtXn1+psYcTUUpCVd3nY2rFwCE2VU9Z8HfHLoKyjn4uhmQRfLVheCSYnAkv5pZtU+QcWpEbOi7sNddJ8nO8gwjX9Rdcx8NYiaLo5K+FKhvgXPYbS4gwgCzGtG6/wkVAV0HT10MXq45nPrP+M3o/+VypeOJ1sBxhgRIvhuqXVbPphEdxkbY+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRPGM/0qqz/I5TdhVzLcHb/ZsEdUKfL+JeWuonKndJ4=;
 b=OMT7qTnQveHhD/4vLl7bWQ26kR8nYKemQsOeJcsDZYikwX+ePwz+U44iXHdRdEsXQZmt+c80za3OEjT3xGr0SzoaSrXerBYRQg6YRDvVIyfX1CIQBFzbYzHqScOZQqv4DUDYmkgr/109Zn9RErwD4gVuk9ZYTgWmcDeCBoszuJsltxBASQ7fWl3jFy5XPUKc1TjbIkSvQ9vqH+W1p16xvl8BK8SOnZtVpgliMjs8lyG50AhJwmDLYAM6gpAcSJpfGyhXtZqEVTJyZGEW7vHAHmgfgRNfKeRDo2bx9eMHpmDgRRandD7/xm4Bxxwm5sBjQzEf+iFkJZSnF/Qpuk86Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRPGM/0qqz/I5TdhVzLcHb/ZsEdUKfL+JeWuonKndJ4=;
 b=K2up1jUz20i3K60kuSnIyPEesPVR1HaXbMTMzZotB7FT6qEMLX0f8zb2RmCj/rzPXgEHWBgqT0ymCWtVAjFkq7VC5rVvuf07u+vNzbT4acTnHMN03rKNXKQccs+9OoDdl1bWBjuq3dW/jEaOgtZmm4NktrhHtxXni/6VMaL5/Ew=
Received: from DS7PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:3bb::18)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:26:07 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::88) by DS7PR03CA0073.outlook.office365.com
 (2603:10b6:5:3bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amdgpu: Fix interrupt handling in GFX v9.4.3
Date: Wed, 29 Mar 2023 16:25:44 -0400
Message-ID: <20230329202548.1983334-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329202548.1983334-1-alexander.deucher@amd.com>
References: <20230329202548.1983334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|DM4PR12MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: cb529cf2-d70d-4089-666b-08db3093d393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33VFpRLI/XXZH+sV6MjOn3xr4PPcDh1OBpLSeIPb3aOl5cHtYWQ30Mi3ZlFpWR9IguP80Fh/onUErISAXbVQHNpp5MZHj8A3hIhad5bIHhYRmBBPUGjCyqLjKTkCPxcbnTsaq4wXfyH/6AjbebX3fo/nINwJoC9RuB/g4TAl2mdyHtynhL5TIiC4bFJR2hSZH0+T7AQZE2AFcqf1f06NInUuI0rIptOvcR6XSos1EAvA627qFFKj5Iyk23S787a9e04suyvViz6Qp/2iOlqug4iZ5gfGZBSieJcBKjD/UqHEzw9QgmgyB2pWFhUmLst5wI087TnC7/4aBmzHeuYOe5HUYxY4ESka/vsk2HDfLeIQUJKOMaKcpd0m7IY71mxaSSa0d8aK6vLrKddUszXGTKUrG5N4B+gp9Hd5Q8P03VRXm0PkCYsjC9iTJThkaelZSIDAKBK7/KQcGgxn9XsWQqco19tX629ScTXRU7sRY/Zjgg3ks2hi3ec/9zQQcan4qU3M8PBCtNgnuouRNvOR7nQak9nAQFHII4RC0R1j6Zu8aTO75/DIhjMDQb1veWrWSesdxeJ/3OcbH9yu/OeRR7vpHGqJW3DIPhPBrGWqWUnm4HDy2tmSPjbEgtvjLNtMXn0FfTDGo+kvMSzDybunD5mCVDRvK4PED80jVA8mEhhxE0A5ofmXua0wjmLIF3yAkimI00coBgl/Phk8JDC5OKRINjHTwTFf75N5eV+Qqqg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(26005)(40460700003)(7696005)(4326008)(8676002)(41300700001)(70206006)(82740400003)(70586007)(6916009)(356005)(36860700001)(2906002)(81166007)(5660300002)(8936002)(36756003)(478600001)(40480700001)(86362001)(82310400005)(316002)(54906003)(2616005)(6666004)(16526019)(186003)(47076005)(1076003)(426003)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:07.0254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb529cf2-d70d-4089-666b-08db3093d393
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

IH follows a different identification scheme for its clients. Get the
right mapping of xcc instance from IH node id.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 35 +++++++++++++++++++++----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index caa0b3e1c877..ca55e522a168 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2736,11 +2736,24 @@ static int gfx_v9_4_3_set_eop_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
+{
+	int xcc;
+
+	xcc = hweight8(adev->gfx.xcc_mask & GENMASK(ih_node / 2, 0));
+	if (!xcc) {
+		dev_err(adev->dev, "Couldn't find xcc mapping from IH node");
+		return -EINVAL;
+	}
+
+	return xcc - 1;
+}
+
 static int gfx_v9_4_3_eop_irq(struct amdgpu_device *adev,
 			    struct amdgpu_irq_src *source,
 			    struct amdgpu_iv_entry *entry)
 {
-	int i, phys_id;
+	int i, xcc_id;
 	u8 me_id, pipe_id, queue_id;
 	struct amdgpu_ring *ring;
 
@@ -2749,14 +2762,19 @@ static int gfx_v9_4_3_eop_irq(struct amdgpu_device *adev,
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	phys_id = node_id_to_phys_map[entry->node_id];
+	xcc_id = gfx_v9_4_3_ih_to_xcc_inst(adev, entry->node_id);
+
+	if (xcc_id == -EINVAL)
+		return -EINVAL;
 
 	switch (me_id) {
 	case 0:
 	case 1:
 	case 2:
 		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			ring = &adev->gfx.compute_ring[i + phys_id * adev->gfx.num_compute_rings];
+			ring = &adev->gfx.compute_ring
+					[i +
+					 xcc_id * adev->gfx.num_compute_rings];
 			/* Per-queue interrupt is supported for MEC starting from VI.
 			  * The interrupt can only be enabled/disabled per pipe instead of per queue.
 			  */
@@ -2774,18 +2792,25 @@ static void gfx_v9_4_3_fault(struct amdgpu_device *adev,
 {
 	u8 me_id, pipe_id, queue_id;
 	struct amdgpu_ring *ring;
-	int i;
+	int i, xcc_id;
 
 	me_id = (entry->ring_id & 0x0c) >> 2;
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
+	xcc_id = gfx_v9_4_3_ih_to_xcc_inst(adev, entry->node_id);
+
+	if (xcc_id == -EINVAL)
+		return;
+
 	switch (me_id) {
 	case 0:
 	case 1:
 	case 2:
 		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			ring = &adev->gfx.compute_ring[i];
+			ring = &adev->gfx.compute_ring
+					[i +
+					 xcc_id * adev->gfx.num_compute_rings];
 			if (ring->me == me_id && ring->pipe == pipe_id &&
 			    ring->queue == queue_id)
 				drm_sched_fault(&ring->sched);
-- 
2.39.2

