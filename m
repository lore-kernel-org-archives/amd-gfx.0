Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1F3C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80FF10E43B;
	Tue,  9 May 2023 22:22:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C5210E435
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjr0tlYuTLTiQ0/iui3zO0tZP4hSY+7cFcXP7NSFEMSSFOyJUa5284gcMwfCPeyzJbAsIkr+sR8p1iOL1n6yDgDKbRtgR4baS/1yP+wFzio/FxXE0m8Cx+OAfQ12lZKpOYG4JirdbZ6Xg747s6zj5wxwQHA4dzHUR97xar4BNUy9QaR6hpSM9XKt74yt92TRJn0mrFCRwaqX+NyiAIhzEAH5qjoxVm6iNaGMkhq4O8FYggrFwNm+A3RdMm6jiQ3ulOkvE5wAG9/1iJx6UeO5QJoJU0eBz5DmA/XvZRlqdkT3H3lDJGeQW4cKLWWJCK/oQk52B4j1V7r7tCeHdpEWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT0zmyUZNI29/TQ0hsjX4GnMDykl+nnfFD+88wLO4Qc=;
 b=QrfCvg85T/725S4RXj3/Ut2SAY2dAbVJG4XenqZBjlAzAOL9JkyiK7qcUI2Mq1wJpfU9vijy5TgxOCG+F0LBNDwYQx+73FCurD6yWf4HjKHNx6XLXx504AL+sf/qH5PE0aeGM/IbFAoq5tH3a1ow2qvMC9t5/hvF3HKyQExQZ4pFDf8am7VAgw4ILMFgfTV2ZU5G8vxMS/P93pIEtgMIY9AueRqGydEpc3ZenyW7lsvdow/5+VFGQqOf+KKTkanZbxUAAHWvj9cr9Pe80OOGKkVJsFvglTvC/0A2bdQyF9oAj/dHz7FnqeneLcfN1EFNpx+FNCDTfPURC5+vO1TU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT0zmyUZNI29/TQ0hsjX4GnMDykl+nnfFD+88wLO4Qc=;
 b=dNzqx6dPflg0QsNTAIR7c+M0OuWlXDa8Y9+ur8y8EVqAIxBJDp64kI9LPoMTJrlvwQ883cHdN+OZEk4RtU1hZ/HoRB+VUo/unbgLvskkPF43u5UrMvYZvX6f5Ca1kDo1NrpmTnHj59oCvtezH3oM5D5P0XRr1Qn068ex4ilVfyo=
Received: from BN0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:ea::7)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:22:53 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::48) by BN0PR04CA0062.outlook.office365.com
 (2603:10b6:408:ea::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:22:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:22:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu: Enable NPS4 CPX mode
Date: Tue, 9 May 2023 18:22:36 -0400
Message-ID: <20230509222237.478097-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222237.478097-1-alexander.deucher@amd.com>
References: <20230509222237.478097-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 984567f5-99d7-438f-7158-08db50dbee78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsbUZ4S93GIQyI4fGZAxUMmLYH/Z+pDi6u1N4t+ocoxU11GS0ukF7jhyPZRkWrmN81+GVKov+GQXc+1+HAHXJ9bCQyekzMMlmeB9ZdaOLAIy+XGYMKr3YW3NoBt+TwcQPDSq8lMq2u2ldrsZY4Gn01yVK8U6x7on5XeJvqKXOXCg+V+NN88daUXdFInpum6PT7F8+lYjS86xGUaKXZZHvdS1xTBciR1mrP3L1VtPQrHlouDsmKsqLdqsfrk3dJ8+2C9z22JWnvzOBR2ueNctJu/NzKOgj1KYd0IZeinhHqEZi81+GnL074zjYRcuw1P7OgY9GibfeN3Tfj8zNItRHEXsmPmZtKmCsL1aLM6LaWnrchw4SwWiKqLfhH+B4q4LrBwwsHzpm/9SM4pE29hcOZfCrnY4wPN0tc/IzkqmnAquO+03d7BiEcXR7GXgMRxtuc/6rpw0GPFUkRZZEkYK/oq7vxsVzyj84yXddCtcai7V8UWvtdCmlUAUahrCXqLEj4Qq8a2EjjPMAjo+snVqARUjD1txYaRy+v3B03Cd8cxdcXvdIlQxR4XeXn96nlvn1kwDKWaqrhgiSH38e8w0Ocf1lZbrucGOPg1vg91DuIfDuts299FUxv2C8o3EKdtf0cF1JBTTYsuvqxFfrRsmcE7l1hNr8L1kAwsRf5gBtSk5TJJtEUw5HSbwyg5aahc/WIKvNBoYE5gy7apIpR5rXOvK8Oyqx2gaaGIdJI3JsCI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(2906002)(70586007)(40480700001)(40460700003)(316002)(86362001)(8676002)(70206006)(4326008)(8936002)(5660300002)(356005)(6916009)(41300700001)(81166007)(82310400005)(426003)(47076005)(336012)(83380400001)(186003)(16526019)(1076003)(26005)(6666004)(2616005)(478600001)(7696005)(82740400003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:22:53.1519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 984567f5-99d7-438f-7158-08db50dbee78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

CPX compute mode is valid mode for NPS4 memory partition mode.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 848049db00ab..97011e7e031d 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -281,9 +281,9 @@ static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 			adev->gmc.num_mem_partitions == 4) &&
 		       (num_xccs_per_xcp >= 2);
 	case AMDGPU_CPX_PARTITION_MODE:
-		return (num_xcc > 1) &&
-		       (adev->gmc.num_mem_partitions == 1 ||
-			adev->gmc.num_mem_partitions == num_xcc);
+		return ((num_xcc > 1) &&
+		       (adev->gmc.num_mem_partitions == 1 || adev->gmc.num_mem_partitions == 4) &&
+		       (num_xcc % adev->gmc.num_mem_partitions) == 0);
 	default:
 		return false;
 	}
-- 
2.40.1

