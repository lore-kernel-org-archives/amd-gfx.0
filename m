Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFE4C761A6
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 09:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A268810EA5E;
	Wed, 29 Mar 2023 09:50:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E7BC10EA71
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 09:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS63W1XyDVv6EmSciKxHY76UsBTHgJ/JfVZPdzm4ejJ5tkov7mWQgc0gjtjbxFmm/+Y9lkGYt9DQ8DtNJDqCvjVDFpTOSun5Q+wZuvKnO7pKJJGbnj7Ze6YQsLxtWzitJiG7a2MvdQAE+m9pVzGk1ty18B9eRzYX9Z+egq3NpdDuNPU9V0KCA0Pfns6sTmUTfLV7iMjjmA2Dn3shEc/1CehrEO6emQk3oR6OzePZTqMmNmyeYt1MZW2YHnH1azpgraEE4MCXdCmdNRik6HNPc2/vCPQYHZJB6BG5KTnNQ+iT9oogL3xwUeZWqI7ivDpe4zWg/fxeAVSA8G/sTRVnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHv50IUG2azS6+C71jmv7VKMXNvzBvNdo663e0HOxlY=;
 b=N2OwGfCwgwhrsCPfAIM6nnWByxRX+Mr6+LnKI3/h85MITDd/C63gPwgVN2hD8eOiUT/GX7688+ns+vG7T3Bd6iPTt9VhVit1YlmDZDRmtzXYTL8fWm1yVluYITDHYTTPeO1kiDfsJ1evqvQghYCg0gRw+x6I8I7IjzaZ4cP3jNs8jw3Z0SY8rKCJi8vE7dHV98SsWq0+JDoei4ju/jFbUaQwMHE3dGXWRYVh6m1uOSErcUti9r3AkwrOxJ5jOISr3ZNrTEIEGlssDZ326ejmCCxgYP2kboqTtxr7J2zP0c2W+/Qx8mZO7j8HUoT1tSNC/Dx5GxePYsSmdBrY6Snbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHv50IUG2azS6+C71jmv7VKMXNvzBvNdo663e0HOxlY=;
 b=zB+WO1Ahjuth/Z9sdX20AxT2DMm0fjqEWpUqHl+eeHNDpiarZUUODmdWb7SjWDyRD7NJGN0vOSyIX7CtmMNLvphkBRzVZZ8hH08ikBhI+H1uDqZ6W4kdClIH+v2F+bdNm4uUiN/EauxqXhzvNDb0SJf8NgJOVlCtXJ5gdXkDJu0=
Received: from CYZPR19CA0013.namprd19.prod.outlook.com (2603:10b6:930:8e::23)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 09:50:15 +0000
Received: from CY4PEPF0000C981.namprd02.prod.outlook.com
 (2603:10b6:930:8e:cafe::ed) by CYZPR19CA0013.outlook.office365.com
 (2603:10b6:930:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 09:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C981.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.26 via Frontend Transport; Wed, 29 Mar 2023 09:50:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 04:50:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 04:50:14 -0500
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 29 Mar 2023 04:50:12 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add MES KIQ dequeue in MES hw fini
Date: Wed, 29 Mar 2023 17:49:40 +0800
Message-ID: <20230329094939.3417283-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C981:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c3ef9f-51f5-4046-de5b-08db303aff47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8roZFi2RksdbK58peNvWgQ1sKwE81L2ZAdFVnk1VBEZb/4ZdeIuLVMF5czFmEkRf/ushYUXSpn4mXs+6GG3BhlAf0jDNSdMuhJdf4nJnGgr0fCPnF7PyMdC+aNBUo2X4BKWY44A9S8yDb5hsVgELS364HXjVVFGWpAjanjZSPa934c2QB1CDBJZhem8o7v+AnPxBSBGeSzYG1gt004NXR3174mcDEjtfycxEX1L2U/2XR7FO1MxG/M+frs8LvkRQXZiGBZNnIQSkrmRTjtZ/KTYWzRWbJMVKi3zpoxY8qGvY12dPtw9zKu2ST4zN6baVLupB99h0z0PCEbvzLdMxxJDyjZDdPXHiK/1ETIuX7d+T2y0dnMg6u/qVzVGfqhwrIsmAagg0CcxOFryUFTfPnPF9lk8cPpP/FwRQ4sWYx6Mg+p9HhpPICdv+n62VrvcxhBTVEKoAt0daOiRsfnGDSNXrD56jEal42lcpFG9hKO5mKQt0H1xLMsozagT493r1ArdftWMTOwtUrMTkbmJAx3MoseDQdnDgI6pq3NPqoi53/ZhH/hirIB72oDrmC1x3VzbvkPFqOflvIs+rkP3/jVM9n+XPugwb1zf6VTXbUEeRicvPJ5q/Nca0Zcb02PjdFDuxl2u1J5ktU0Adds/ks6B7HA8LWsuE2/35WuYTWN8pl42n/0HAFf+twN3tp/7Kji/d5tLDs2lgrqVmibrd+k/aHBHEkjhS6lKWTi2qPRtakkB572qkK57RaKFAXo0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(316002)(82740400003)(40460700003)(6666004)(86362001)(5660300002)(2616005)(356005)(81166007)(6636002)(110136005)(8936002)(54906003)(70206006)(41300700001)(70586007)(47076005)(36756003)(8676002)(4326008)(186003)(82310400005)(40480700001)(26005)(36860700001)(1076003)(83380400001)(478600001)(2906002)(7696005)(336012)(426003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 09:50:15.1099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c3ef9f-51f5-4046-de5b-08db303aff47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C981.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474
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
Cc: Horace.Chen@amd.com, Yifan Zha <Yifan.Zha@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Need dequeue MES KIQ under SRIOV when unloading driver

[How]
Modify mes_v11_0_kiq_dequeue_sched which was used to dequeue MES SCHED
to support veriable pipe.
Add MES KIQ dequeue in hw fini

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 5826eac270d7..6e97c28e3162 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1089,13 +1089,14 @@ static int mes_v11_0_sw_fini(void *handle)
 	return 0;
 }
 
-static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)
+static void mes_v11_0_kiq_dequeue(struct amdgpu_ring *ring)
 {
 	uint32_t data;
 	int i;
+	struct amdgpu_device *adev = ring->adev;
 
 	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
+	soc21_grbm_select(adev, 3, ring->pipe, 0, 0);
 
 	/* disable the queue if it's active */
 	if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
@@ -1121,8 +1122,6 @@ static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)
 
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
-
-	adev->mes.ring.sched.ready = false;
 }
 
 static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)
@@ -1176,8 +1175,14 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 
 static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev)
 {
-	if (adev->mes.ring.sched.ready)
-		mes_v11_0_kiq_dequeue_sched(adev);
+	if (adev->mes.ring.sched.ready) {
+		mes_v11_0_kiq_dequeue(&adev->mes.ring);
+		adev->mes.ring.sched.ready = false;
+	}
+
+	if (amdgpu_sriov_vf(adev)) {
+		mes_v11_0_kiq_dequeue(&adev->gfx.kiq.ring);
+	}
 
 	if (!amdgpu_sriov_vf(adev))
 		mes_v11_0_enable(adev, false);
-- 
2.25.1

