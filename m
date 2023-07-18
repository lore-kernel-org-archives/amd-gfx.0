Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFCDEB64DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 05:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA09A10E066;
	Tue, 18 Jul 2023 05:14:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD40010E066
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 05:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3jaxtgcGdlQZeqgdBMpVUdHPfGEsKjV5/fHZZxWsCaDe/n095zb89roHvWJOIGN6DgsujprBZjWvSouZaPECxR37UTAupVENbzF/53eXZn7tWRbwnLuk8MnItwalGf4EIeVR+LU2t3gf9nG3IpiP8e1PQaKeOhpthwH0EOvTydTiA/gI/O5zG535EnB4eusotKeV9tJMdG98KA7uKIgbg67ez6RpH2un/hdGYlfUbRfROrb86n/FCqpB1QwUeYWM50EcQefkGUaEqRDfbhKs7TRKtC2Dj1zoIUMPpgCOcUcuq0EsjN1QIQqspO34AJyouNciGAAjMrT3GM07csRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb1bNfuXbd5OcsKgaIHGrYU6SByl2gUPi9WONsjpb4g=;
 b=GuUnNlpV2pAQ57eNtHByk+OvsK0/eLYbNVAM/w69ggZ6/220frxUUqOYG9vgz9GlKuixSQ8tyV81Mhb7TOMmSdzUxyrzQ33aXNC15zg81PeEywdPQwRF6gqbroNXIg9sFTBnytyYrW2mt/MwZ5LV7OxBU767RH1TZC+FGbAtg5qIIwagU0v+Rkx3CbBLBduQI0YtAcqUEh6ZXOZ+3u24fw5FIHe6Z7V2iwP2nj5odIKRswxrPZ8IPxZvODbcI0EaURXxLYEQzyOWAQza3E6mn1w62EgCAaD2CZfIrKP4NcmwlavINi781JmszvmbGmSVP58HQLl2hzfkDTzdKZd0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb1bNfuXbd5OcsKgaIHGrYU6SByl2gUPi9WONsjpb4g=;
 b=MrJ15PFFqQfX2etL78/ImIWj+m3aSWiId4lM+bwzm8PXJLd7LeEFcDxunuUo2ThsJbMfN7u21PW+JyygAOuyLj4BNk+H7/xeNNq5osMrazWG00glcSSZMnE0+3MefIwKY88GlWp8h0fLFoSooHVyz0mQt8kA1tUI0z4osMeoW6c=
Received: from BN0PR04CA0040.namprd04.prod.outlook.com (2603:10b6:408:e8::15)
 by IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 05:14:01 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::55) by BN0PR04CA0040.outlook.office365.com
 (2603:10b6:408:e8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 05:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 05:14:01 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Jul 2023 00:13:58 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Allocate root PD on correct partition
Date: Tue, 18 Jul 2023 13:13:39 +0800
Message-ID: <20230718051342.217902-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|IA1PR12MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 033a059d-8d9f-489c-6684-08db874dcc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjTK5fbDmoegBdDJv2PAS/VESHfRCSDN0RBdBtzclpGzMJ9bk4mAGNT6LqitWQGuNy+5jBXjJY6/KgTcJrT1YwL8xsR3Dw5YTVuPWTyRGmX98BZw/Y+iu/I2vr/xu1fpAk8fOoSjYD1RMopFKHTUGsdpE/TsLjKFjHhEaTX2NbtjeL2LGL2x1YQ2m7SGajt55giEWC6TmOp121/iniFsBoOxuOiI+ECwuKD9w7GPpN0VIBZBZMUpjaYylOyDWUyOlezcLWKkPthQ0bA4lnK0rNx3Ip1bHM4NSE3tUluNSkAvcH7jWqN0+GxeUZ6QK0svSL5wRbeqDtGDZryRLMMt30iVArAF3PoVb55OnnEC7OoejXqtmDz5t61BxlhnIW8hnDRlWLF3jxy8VlP2x5zh9F27c2zUsh4Cn9sqYEsD+kN36MOdXE04K4Tvb3kAtjyUEutaHkuhlLU8MrbZDmfxbbZF3qsTeCk4zgQde5gQqbQ006mIbIOcE6c89FTgbErRbpQyYR4vL95iVg3kiC/NNque97XYJge1DfIYjEEVnKdCfmmcE/PaZSlY3cgmueAyj0oQrjQ2LM//yXTvkhqq7M+1DZhqyQ7UkuKojqgxqEA5xBiY+D5/6pXfZJhTM/7UdjyuFG52658j7DhCb+nFmoM9qY1HCLZaN784oTpb1F/tA0zS4kej2RgAlNJKbNSXGD8BtpGLk9f3n/uVLShwl+mY6CjJ1S1GLlljsxy+WCOKT1BAQBhaTgGcfcbUGmISlfyiufIpx9jjfQycZNym2hOvIdTvtZGLYoDwaN2liTw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(8676002)(7696005)(41300700001)(70586007)(2906002)(70206006)(8936002)(6666004)(356005)(86362001)(81166007)(6636002)(4326008)(36860700001)(316002)(2616005)(47076005)(44832011)(36756003)(5660300002)(426003)(16526019)(40460700003)(1076003)(83380400001)(186003)(336012)(26005)(40480700001)(82740400003)(110136005)(478600001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 05:14:01.1133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 033a059d-8d9f-489c-6684-08db874dcc39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

file_priv needs to be setup firstly, otherwise, root PD
will always be allocated on partition 0, even if opening
the device from other partitions.

Fixes: ffc6deb773f7 ("drm/amdkfd: Store xcp partition id to amdgpu bo")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 85a0d5f419c8..53a024cf0544 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1232,13 +1232,13 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		pasid = 0;
 	}
 
-	r = amdgpu_vm_init(adev, &fpriv->vm);
+	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
 	if (r)
 		goto error_pasid;
 
-	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
+	r = amdgpu_vm_init(adev, &fpriv->vm);
 	if (r)
-		goto error_vm;
+		goto error_pasid;
 
 	r = amdgpu_vm_set_pasid(adev, &fpriv->vm, pasid);
 	if (r)
-- 
2.25.1

