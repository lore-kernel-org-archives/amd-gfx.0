Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B888FEB64DB
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 17:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3846610E530;
	Thu, 15 Jun 2023 17:49:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A9510E530
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 17:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/x91Qrx/NMrf1dFiUEJuSXZ8urZIQECbWc8O99SVaxP7Gd2bIp8v7tw+QuHq2Eh3B40G9ptQltKxEm7SiC1zMnMVwPdZch9z+o3g+LIAfRy5FsmNaV6RH864jyIBXUPxxgmoyqAdZAcieQVgOTXPKAft75MotLfT2PkgtoDyUZwaeprQrbBZTgfrmWuJXgKZ0r5NFpQlF39T5xNBbeSBBPnrZQ7iXFqKtQ0kLhEHZgvyiL1ubu/5OFaVdoyv+fhaW4MSCCTMdUiKBlxRBrn3T06bmYZQoc6xiGBaxxTyv21/qmyCVkoGvVx5ztLStLdXDibxqttlOGkGwbN0k6k1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7sZBmaBwBvdqrSq2dMq0fjzKmxiUCoLUyioy0uNXDY=;
 b=XgAfrp5Bw0G6bBt/lTkBh47qt0I4164yfdSjPag8o/qvC1eBRiGrGRM6e+Ofl/DiVttLRLT0MfDCPvjWvMaj7kILxrBhbhshkxGxF1q6AcxDJitrYl1lwpO/ZhjIWssc6In53Jy6wFdHH0T7kBl5SQLjxBw2u1xldRw/lQMzTx1S6tKTekn+JYUUTXm7UPkG69XUbLUsI1RyH/rQC4zW25Ca0WHS+gUgR3AiZV/0RT49/hUMLfPXp/dowmYW4SvSNmapX9ZiGQPcv/I6UisLGHb2m7O/z9VDyLrmznIYcim3UR3vVbJ6pYojEKToebp81/Mgnluux21xMODnJoeOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7sZBmaBwBvdqrSq2dMq0fjzKmxiUCoLUyioy0uNXDY=;
 b=3U6Ekh98ZIHUYzzdsvnNTL2I0ytNH5/qM9N1A3gQx7hGfq7wg0z6kYyHkM4+rOwFnEoapo67TtuuDVTa4cW9wmxktp72uXEQUZktMWKrR1DAzhXHgP9Z3VtVvpKUdpo1NDC8o6zJ62xVhmXClKcXIu40hh23Rqu/+O6Lv2AXT8I=
Received: from SA1PR03CA0014.namprd03.prod.outlook.com (2603:10b6:806:2d3::10)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 17:49:37 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::72) by SA1PR03CA0014.outlook.office365.com
 (2603:10b6:806:2d3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 17:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 17:49:37 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 12:49:36 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: port SRIOV VF missed changes
Date: Thu, 15 Jun 2023 13:49:20 -0400
Message-ID: <20230615174920.25499-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615174920.25499-1-Zhigang.Luo@amd.com>
References: <20230615174920.25499-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b2ade7-9749-470d-e63a-08db6dc8e322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyecIeMLlnKto0VeTRGNygKD2H0/SRQ9SEPB7jEAN8XI7VHBhGXQHN+hwnUAnJ9AY6hLKqazhU8+67dP56aPEQVbzqH2At8mms09pkcG+aQ13GzhnRtwPA7VqeOJnhthx9hBLb1ALDu+AXbg23uK4qdZjrdlspu3vUj+gsGouxNXC8a7cyi2veyMcD98u0utfyOZn2Vnl88VLDeiDrUEtGWiGOAxIIHb/5OIU9xKCvrmaVvMXO0nP/4mX0DjZVIVNBefWdRcvVnu+C0097TEdtbH85+vCmhlNsIeRD8XSqPc/c5rPiUCdE3gIIsUVxhgauRDpELJDj4BqLmzmx4THCYmuRU8VFWDx4htw8Z/ZOdF+Cs/9K2u08IPMEUMfovU/IpX+Yi6aAd6SAdAz1kAjW4I8fIOO7LK6FnTP+XKdQHNnsIBoAhgTF8csGCf4trj7IKCxa5WAHbV9haS5S9QfIyvBPcuJluaWg3FIIRSXlk7VY/10tWIkZxze56JODx+/lvn+pIhMhQ4SaxRB8vyRhC7c6SeD+1ajady14I/W7urnVxh2yE33mksnFoyF2ooNfJ6Mk4NgMWB6z5RSiLB7uzcddjrCG98G35Lalz8XJmV5pUVH4OvwdE6DcX0kuXFH7KG7Xhkp3i5ymoNiZSpBdJgRttNiDoa5h3VOLNtms1b4Drl7F1b6x4ONN+6jQm1T4g2CttTo0T6SM/epaGrLgK1UazvUN1w7oZwyKhG9WHp9p/x//velUD/63zlEiWZbZgvNTo3B4PjuvhPibgbvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(36756003)(2616005)(86362001)(70206006)(6916009)(6666004)(54906003)(4326008)(478600001)(316002)(70586007)(7696005)(40480700001)(8676002)(8936002)(356005)(5660300002)(41300700001)(82310400005)(2906002)(81166007)(186003)(83380400001)(1076003)(26005)(16526019)(336012)(426003)(36860700001)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 17:49:37.4034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b2ade7-9749-470d-e63a-08db6dc8e322
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
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
Cc: alexander.deucher@amd.com, Zhigang Luo <Zhigang.Luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

port SRIOV VF missed changes from gfx_v9_0 to gfx_v9_4_3.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: Id580820376c8d653e9ec5ebf5a8b950cd0a67e1a
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c1ee54d4c3d3..76b189bd244a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1762,6 +1762,8 @@ static int gfx_v9_4_3_xcc_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
 		mutex_lock(&adev->srbm_mutex);
+		if (amdgpu_sriov_vf(adev) && adev->in_suspend)
+			amdgpu_ring_clear_ring(ring);
 		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, xcc_id));
 		gfx_v9_4_3_xcc_mqd_init(ring, xcc_id);
 		gfx_v9_4_3_xcc_kiq_init_register(ring, xcc_id);
@@ -1960,6 +1962,16 @@ static void gfx_v9_4_3_xcc_fini(struct amdgpu_device *adev, int xcc_id)
 	if (amdgpu_gfx_disable_kcq(adev, xcc_id))
 		DRM_ERROR("XCD %d KCQ disable failed\n", xcc_id);
 
+	if (amdgpu_sriov_vf(adev)) {
+		/* must disable polling for SRIOV when hw finished, otherwise
+		 * CPC engine may still keep fetching WB address which is already
+		 * invalid after sw finished and trigger DMAR reading error in
+		 * hypervisor side.
+		 */
+		WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id), CP_PQ_WPTR_POLL_CNTL, EN, 0);
+		return;
+	}
+
 	/* Use deinitialize sequence from CAIL when unbinding device
 	 * from driver, otherwise KIQ is hanging when binding back
 	 */
@@ -1984,7 +1996,8 @@ static int gfx_v9_4_3_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	gfx_v9_4_3_init_golden_registers(adev);
+	if (!amdgpu_sriov_vf(adev))
+		gfx_v9_4_3_init_golden_registers(adev);
 
 	gfx_v9_4_3_constants_init(adev);
 
-- 
2.25.1

