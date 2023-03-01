Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9746C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 21:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7729310E327;
	Wed,  1 Mar 2023 21:09:23 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E5410E327
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 21:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhiLeBOtrJigwrIVsdbWqvVG71C/BamJYSpZVXjkL3FomEP8KUwdphVy4EREbgZ5YeZCb0QI5/8BQDf9yyVWxUsozikTCIXuY/tYjyNBs+nN1CBCLvciFsagg6Q4ZCm220nHedgpqNZy9OQb74LsFL0ROiChgRV8ZV194LclMCcDaMp9BprxhEaE5yapc+EQEGqaTWQUamCwuLLLdsaZ5+NXgGuGdjqBMFRGxhFv4jj2kWd1qmitWFl62aCk3KxvLXgvoPOexsxDxFrHMls8ZUouNtAXB1PyXf7qhUOGgP4/q2jl1YDHQeTNM7n750ZaUrmvV02ztj9cbBftIC36cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQFuVAAD7Ix9UnXlj5tVsRw0Cd+iEyIg0P5ZKuvpLKY=;
 b=Aiw65TkoRHvrP04TNJLrluKYxtt6OtFxoru0UM+VW52XkxANqFtgJBLgSZAhpwSipD9eF1pCIe3m4BCh3OGjhSgjJDGeoQAk6MKCivkQwixjddJw/ptT8I1NOo/No1m28ZRH0OZ5au+ZySi59LHAu5UAgjK4HIK0uA9W2EjUWbcmT7Uk9NndG+Ua8mnQIDZ2Bg/wuja56g+y5ayGhQ/rPhb/XkJ6KHTYJznSrsay2AJJog3onoC/b+oKsz8c2lk4kHPpcUV1UevsIKAiK5CZpzFb3vErjIx4ZQamRu3Og7qL/FXZ10DMQbkYNjPsJL0QRvlOnrq5rzM1utt5ewpu8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQFuVAAD7Ix9UnXlj5tVsRw0Cd+iEyIg0P5ZKuvpLKY=;
 b=2OcZKx8aVE/4HOHdNzHSatgOuvDIiVow272VGCAjwFtJlcsfpYAg8LMm15qok7oCXT6Hqs8lgymmz8jFPT1dYCYIa20BnC1Cbu53sEaaP9jwi0qMTRRCT6DKssvm36J1ZSmjcBL8vV34InVikG75FcoAzbQ2WwWAUMh+ZUaTEn0=
Received: from BN8PR16CA0009.namprd16.prod.outlook.com (2603:10b6:408:4c::22)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 21:09:19 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::60) by BN8PR16CA0009.outlook.office365.com
 (2603:10b6:408:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 21:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 21:09:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 15:09:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: skip ih2 rb allocation for IH 4.4.2
Date: Wed, 1 Mar 2023 16:08:51 -0500
Message-ID: <20230301210852.2098388-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301210852.2098388-1-alexander.deucher@amd.com>
References: <20230301210852.2098388-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: 8723b7c7-ee12-4959-9ddf-08db1a99390a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpF2Vvf+gdeFuhCFaok3QiKF5WbUI8MKBVTOk9HPzx1hU8HU+JAVCuEdNWQQ1tD9gYQ6hiNz5ECqzjZMWoaYAH7f07biuUOBmkCMp97NJ4oCuYnGmgm1/8xO/L0ICGA0iizJVdW3r9F60hJmV+RkGFcMUeYQp6XGXldpGNhs0sJ/3UXiEgmkVPjLz1C2/8TC4mB7yvZtwZgOsi4GqknXiffG+AIcPsECAN8LQipmwnKaLLE38in2GdQulFpbnhR7BXr60tmz0RZ3oibuT0za4bREQPAyFwWSG+2KNy2k0TKTkNMDherpyrsZnuvWS34aSA5Vz0Tl5HGJ51sq6g53foEYCeH+epTPjE//GaruvSoJPfHqyyINiLH7PQd2jrbaQviIBjN7hn4uI2C2g6S1Fr+ET+ZMH8s4N60iabHfUPSbt9dq9fMMC4BqXBQ6HZIy//BtghVAnaH8OjoNij7LI9808CQqdP7JfNsC/z35bhs3cA0tmxuLifviY4/k6BFoE/5lzdM3V7d/9i4U/tdkSlO/7J/ycAzaEtW2wTpdqd3QJz+swUj9fFQJZ17r2IB3J0SJFlsf1M1Xwir8Cf7o89iaJxMrSVOB/bw0pW6wwOy4b3T/D2I/WtxkCukAIw0/xUIiIdQO5s1KpiLMqcw9DOjia+haasMGVPzJu72toUk5bVuU3vraAn7Fhp5Mzd9ckA269jNxd9h17FAUDBw933YAQbo1vT1ISeIWRYNpmDjQLRXygi5tptBQ7cYguTULrqn3fGf5Coe2WoQnl8AmduC6T9f3nbb/3V8l/O8mO98=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(83380400001)(36860700001)(47076005)(426003)(6666004)(40460700003)(36756003)(8936002)(5660300002)(81166007)(82740400003)(478600001)(356005)(40480700001)(86362001)(82310400005)(2616005)(186003)(26005)(336012)(16526019)(1076003)(70586007)(70206006)(7696005)(2906002)(8676002)(316002)(6916009)(4326008)(41300700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 21:09:19.1903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8723b7c7-ee12-4959-9ddf-08db1a99390a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

No ih2 hardware on IH 4.4.2.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 44bfa233487a..827e2768f867 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -552,12 +552,14 @@ static int vega20_ih_sw_init(void *handle)
 	adev->irq.ih1.use_doorbell = true;
 	adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
-	if (r)
-		return r;
+	if (adev->ip_versions[OSSSYS_HWIP][0] != IP_VERSION(4, 4, 2)) {
+		r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
+		if (r)
+			return r;
 
-	adev->irq.ih2.use_doorbell = true;
-	adev->irq.ih2.doorbell_index = (adev->doorbell_index.ih + 2) << 1;
+		adev->irq.ih2.use_doorbell = true;
+		adev->irq.ih2.doorbell_index = (adev->doorbell_index.ih + 2) << 1;
+	}
 
 	/* initialize ih control registers offset */
 	vega20_ih_init_register_offset(adev);
-- 
2.39.2

