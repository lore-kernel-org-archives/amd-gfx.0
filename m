Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2925C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 06:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C00389023;
	Thu, 17 Nov 2022 06:08:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D02710E54A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 06:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGRkqWo/L2iHu5DvFiaujGQ8JTPXfMyi3jXY2IVAt3BlOFt4qZv4J8ju8XhhWVI7Qs5fXhtGEw5S72xQJxSr649+MqQeqY5EWFAeOQbvYzo+YysjdB+ix5Mkat1Z4/FFurgXNZ3oIUNZ3V/ZByhpK3XgpS1LzjRGUbXoeOshSMivYILMrKDpxqYIqtIUje0L0h3NTAhl+8k+27JM25TNnymo+/UwByPkCT8WcdD+4e4T4CqJTdgHE2GuEqHwvoDgM5PbAIYgnuuP+fdrcAHBPorRbDJTzwFczPTMVbQEU/ElHvfCZ9ymqqOnH6JuspYSB37owDB0TKOm8d7/DZgjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPU/eohzac7V1d8Y0hjUaNlnM3ISbvS6yT/zMrpqd0E=;
 b=B9zdXqEfBJvf7ZxB+XfhgvrCaQhssUIgxAr5QMoja+PnsECszWONGMDGhkTMHXMrYmdVCObreOggkR7jTW+CUtDwE7VSgmjZXJ/mqvYuECOur/wV3zoNrYIa+ZgXC8FfuzzhKEeCLwpSTinyf8IEZSDrHee3GIN4mAnT5csZINaUVPKdDcOuBUGoVRaVg6eZBOTN0/vGDJm2gHBIAYKRTHWlITracZ2sJMuWdUIyXWi4NBayp8+eEm5/Fv1QTcmU/t6z9H4xF31T5ipHPtb6r+mMGB7tfAdBy3IEYW3Z93ypkc1E92Ly2BQ7gRx7DHKhrfNKr6HWgKJbAeYRV0QSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPU/eohzac7V1d8Y0hjUaNlnM3ISbvS6yT/zMrpqd0E=;
 b=iiojmF26lxhzB9z/IqJGOhboaRNuawQHpQrxRimds0K6jeU1QRHiyPD+nHfpJ5zjHcYWZxlQ6n9R0fEjoIdlz0roojj4OxLzgAs1E3c2w4vbawqxinGjZNlTEnDV25SjhJhHbBUKqHYAB1HQTKdgi2z2Y4LakF3KgniaLDm6m6o=
Received: from BN9PR03CA0851.namprd03.prod.outlook.com (2603:10b6:408:13d::16)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 06:08:45 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::a1) by BN9PR03CA0851.outlook.office365.com
 (2603:10b6:408:13d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Thu, 17 Nov 2022 06:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 06:08:44 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 00:08:42 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: enable RAS for VCN/JPEG v4.0
Date: Thu, 17 Nov 2022 14:07:48 +0800
Message-ID: <20221117060755.13655-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: b44d3cc3-c1b1-46f9-adfe-08dac8622f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: co2t/iqHLWjK8A5tNa6woirJJquaiJZ3U12T9KIqxlFhCQMpXRRxMIoUWSCx5oM4o8NP7noQZ05vFHkBwo7TIf66sfZUFzVBKQsk3B8jsUVSgOl3lXflZmgYRvvnGja9wd2DNQ22bXbHOCMvLly1dI24HEPF7IdhtZMoLNKs553E/3TwTu4qzfjfRhzbpjN645sW4/MPDoo+V8wnUQKr5930XGdpiYFraYgDiHYMXX08rQD/MC+c4azEPkBq3TdGJMV++mjoIX1eTy2YgjabB/jhVGosLNlKclhuSz/DFt+iJD1ME74de7voHGJMEzbBkShQg2Kk8d3llOfPYn6eYXtsPeSUPuCkR7Wasm+mPOaO07W2TqZhhLS+GszXnui15jiicmdElkzRya30uz/YdUgigagO4DuZglMX/juTERQLuZPSY83EC+z1apQroc03DVEVA9Yr4WP/Dp5R3r7xCoIBhqdl5yjSnjmS7xeLuoeHX/aqUbrtgDaLabjjpIyXsmANz/o7NNGdMmfcn493yUFD0B3dJtlGcpgq1ZlnrzwnsE4vY7s9G2MMfOHUfANyYp3v4uUveKVq9myjpv/9YJebZIiSQq0WVZ8fl9MfCkKIOziLzE3EmmTeNKHfYnusbszYE6czN+DyzbhAjSgHHUf/22uVcCvRZUaav98CBXhKzqVkarumt+Lqw6HtOrxLOmJEFg7b5SbSJ8/FUHerqimq/QkhVX5n+wQj3vKVAp8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(8936002)(82310400005)(70206006)(36756003)(40460700003)(2616005)(1076003)(86362001)(40480700001)(41300700001)(8676002)(82740400003)(70586007)(426003)(47076005)(4744005)(186003)(16526019)(4326008)(336012)(26005)(5660300002)(478600001)(316002)(110136005)(7696005)(54906003)(81166007)(83380400001)(6636002)(356005)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 06:08:44.8898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b44d3cc3-c1b1-46f9-adfe-08dac8622f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set support flag for VCN/JPEG 4.0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 693bce07eb46..e6feb2750a89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2343,7 +2343,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 				adev->ras_hw_enabled |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
 							    1 << AMDGPU_RAS_BLOCK__DF);
 
-				if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(2, 6, 0))
+				if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(2, 6, 0) ||
+				    adev->ip_versions[VCN_HWIP][0] == IP_VERSION(4, 0, 0))
 					adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__VCN |
 							1 << AMDGPU_RAS_BLOCK__JPEG);
 				else
-- 
2.35.1

