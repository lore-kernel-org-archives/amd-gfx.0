Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D292C77B62
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DCD10E928;
	Tue, 28 Mar 2023 15:15:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E98F10E924
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu3XAKATg8Av1wXFpaPFDBEbm1UfFFsPOcVVlgECSFzimkL7TrnNR7VVQBhWpwea5VVJvked4tCmKO/EdavBOtxYRMaMJJVK2u9Ozn/XuLPhzll3m2AyI8Pm22xctCV5qlX5kwmmt5j8bfS5eF1xlGfS2DdU36X6E7GcLexdSSNSJIqEilD6lrsyte6GXDA6CJNVptlXTdBzNQ21DSRFlPZa/2hKeGMf0vwtjdz/5B8h63OB1RRFopOVWVsyLIXOLZy9ZA871xo54f5XTic6ikTUZ+zwtX0T1ClXcxdwuTa3l6yZ/M3AYZA/eo3vjbDfRQUEIXupL2qPgotuJp/Jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZzmEXFeDvDGDpwKJYYsLfPQi8SmvWCNX6XAMIdkEcA=;
 b=GK8lrlwDIjIosvApKNejakwVWJuiB3AnWcli4Yw45KlP2ivP0wiMrtWlNWpg359tV+U+YJ0ZamTv+5TI0y4i3hV2PoEwMaIFkxj0sq/mfMbFPkySzTmPSDTGTQ0VR/JVQpDNBkxL0WLBPqM359ajsKswqKXZCGfQcJLOoXOwuQTmMLNlB3X6qxCi6zJELEJTjPlmhXig7gzAqTIlsYAC2S4f2DmutYLk78+o8BmG/bwgv6o1UiGBPVIsWhYKzv8rwTFjvq3bJRvTnVg39CEY9i+/rwH3rIUaoetcoz0invQbmlBc2ZSdEJmJbSo/nSJHU6mh1fDyC40+7tOnpQHibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZzmEXFeDvDGDpwKJYYsLfPQi8SmvWCNX6XAMIdkEcA=;
 b=HWHh8S1C9Sp+rO6l6ArNwwknaO6wvyamJmOx97JjQEJqoFWmHuOO4jUiXObj81nZu3dxXs1QIArhzY5lZo4iwxkttXK5FRCyDCXCBANn9i5/r/85b2SPUjoycfwZWo8b78jh//M27pQ119skmuOpLZcbPwOLc8cvR/rFzshQK60=
Received: from BL1PR13CA0082.namprd13.prod.outlook.com (2603:10b6:208:2b8::27)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:14:47 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::b9) by BL1PR13CA0082.outlook.office365.com
 (2603:10b6:208:2b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/32] drm/amdgpu: add support for SDMA on multiple AIDs
Date: Tue, 28 Mar 2023 11:13:35 -0400
Message-ID: <20230328151344.1934291-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: dbface62-0c50-4f8d-32e5-08db2f9f2aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zyfO0WuW9GU1zju1LH3bxbmw7wrgfjrb+I04aedLQtfcdT2R47OL5wb5oPtnFSi7A2t73j/NzNPwcAwiIRQbI4rk40jj2jIYZU5LmkHkARQySzapmHvQAAj5tRgj80KZyhAhbspd7f6VaOnJfHt10lwhmq6v4y1qBoY/LEIpYkRPHCRZy7jsT9qogg+FEuZo1FQd0CpxEiGnypUMxWWg6TcdAXjZu/3dn+K/2VLTHlViHuGB2s6X8XtpYaypkSxV+TMqawFetI/R5k5vpI5wTBsqOpXvwRB0bFVKZ7AGkgaIbx53SQm9S1cuJ8i6jeNKTPuDsCKRHut/scoY6fGpCCckyuXiAROmAJSEFfb0YujrWc/JR3rQVS074eZPNgq3bbjG2QtIkJA7sIR+JC6h+FsyALW8xfpkVOA7i8feFORT0MeMTM8ucFKSTBPsbfZvUGAIKL4Tn7TDL5lMWlO1PdvwQUhQ2nsJixC6PF0bJbCd+Venp5AMB5oUu7Yw3F83fUoXq1PL0SsIZvCPgRLa+1s/jKufauR0Msh+xbYS8RCHs2AJYyZarPA5hQ4v3sWlh91j1Mb7iOOXfAGwyvJbXFssd9XzhRHrFiGbI0e5F1CwPWIZsnyvsxwyzb9+hkfWRNYjJyyvopQOtIAV0SjKAB9+rEj92GHFyY57pE0m3ayNEJTtGtfF4ancDyfrc65a8wlIIbNYZSEJYqAaXtDDeszGxgUrz0pVB4OE+ASkvg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(2906002)(82740400003)(81166007)(41300700001)(5660300002)(8936002)(86362001)(40480700001)(82310400005)(36756003)(40460700003)(356005)(7696005)(478600001)(336012)(2616005)(186003)(16526019)(83380400001)(1076003)(26005)(426003)(6666004)(47076005)(6916009)(4326008)(8676002)(70206006)(70586007)(36860700001)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:46.8885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbface62-0c50-4f8d-32e5-08db2f9f2aea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741
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
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Initialize SDMA instances on each AID.

v2: revise coding fault in hw_fini

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 67975dcede5d..632b77138fe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -37,6 +37,14 @@ enum amdgpu_sdma_irq {
 	AMDGPU_SDMA_IRQ_INSTANCE5,
 	AMDGPU_SDMA_IRQ_INSTANCE6,
 	AMDGPU_SDMA_IRQ_INSTANCE7,
+	AMDGPU_SDMA_IRQ_INSTANCE8,
+	AMDGPU_SDMA_IRQ_INSTANCE9,
+	AMDGPU_SDMA_IRQ_INSTANCE10,
+	AMDGPU_SDMA_IRQ_INSTANCE11,
+	AMDGPU_SDMA_IRQ_INSTANCE12,
+	AMDGPU_SDMA_IRQ_INSTANCE13,
+	AMDGPU_SDMA_IRQ_INSTANCE14,
+	AMDGPU_SDMA_IRQ_INSTANCE15,
 	AMDGPU_SDMA_IRQ_LAST
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 441d6911fd20..7deadea03caa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1253,9 +1253,10 @@ static int sdma_v4_4_2_sw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int r, i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	u32 aid_id;
 
 	/* SDMA trap event */
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for (i = 0; i < adev->sdma.num_inst_per_aid; i++) {
 		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(i),
 				      SDMA0_4_0__SRCID__SDMA_TRAP,
 				      &adev->sdma.trap_irq);
@@ -1264,7 +1265,7 @@ static int sdma_v4_4_2_sw_init(void *handle)
 	}
 
 	/* SDMA SRAM ECC event */
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for (i = 0; i < adev->sdma.num_inst_per_aid; i++) {
 		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(i),
 				      SDMA0_4_0__SRCID__SDMA_SRAM_ECC,
 				      &adev->sdma.ecc_irq);
@@ -1273,7 +1274,7 @@ static int sdma_v4_4_2_sw_init(void *handle)
 	}
 
 	/* SDMA VM_HOLE/DOORBELL_INV/POLL_TIMEOUT/SRBM_WRITE_PROTECTION event*/
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for (i = 0; i < adev->sdma.num_inst_per_aid; i++) {
 		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(i),
 				      SDMA0_4_0__SRCID__SDMA_VM_HOLE,
 				      &adev->sdma.vm_hole_irq);
@@ -1303,15 +1304,17 @@ static int sdma_v4_4_2_sw_init(void *handle)
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
+		aid_id = adev->sdma.instance[i].aid_id;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
 
 		/* doorbell size is 2 dwords, get DWORD offset */
 		ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
-		ring->vm_hub = AMDGPU_MMHUB0(0);
+		ring->vm_hub = AMDGPU_MMHUB0(aid_id);
 
-		sprintf(ring->name, "sdma%d", i);
+		sprintf(ring->name, "sdma%d.%d", aid_id,
+				i % adev->sdma.num_inst_per_aid);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
 				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
 				     AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -1327,9 +1330,10 @@ static int sdma_v4_4_2_sw_init(void *handle)
 			 * gfx queue on the same instance
 			 */
 			ring->doorbell_index = (adev->doorbell_index.sdma_engine[i] + 1) << 1;
-			ring->vm_hub = AMDGPU_MMHUB0(0);
+			ring->vm_hub = AMDGPU_MMHUB0(aid_id);
 
-			sprintf(ring->name, "page%d", i);
+			sprintf(ring->name, "page%d.%d", aid_id,
+					i % adev->sdma.num_inst_per_aid);
 			r = amdgpu_ring_init(adev, ring, 1024,
 					     &adev->sdma.trap_irq,
 					     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
@@ -1811,6 +1815,8 @@ static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
 				&sdma_v4_4_2_page_ring_funcs;
 			adev->sdma.instance[i].page.me = i;
 		}
+
+		adev->sdma.instance[i].aid_id = i / adev->sdma.num_inst_per_aid;
 	}
 }
 
-- 
2.39.2

