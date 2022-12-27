Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E80C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Dec 2022 17:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B808C10E15C;
	Tue, 27 Dec 2022 17:10:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEEB10E15C
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 17:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6nO0VfDf91+mIcuEcwGa0ccYMyJjssZieAokIFbKu8CwdfeBoduC1C4Se/AKPA7BdYxaJzrr+Dckv2oU7iYhPPUmlPtm9WeiRErWgl8+mlawroyI9pfX0MFP5Gtpl0vGnWSxWYpqJrNdpzKaz0Y27zv/ZIrzycd8kyP77Gkk8b5f9xMyRmdhbOIsM5YWs7MrlQWHVJQuCzunnOMoKQwqddA2JwndYFY16B++u618muz6fy528xH5sexRNtAorl9882PM4CcqFXOFBH5JfZ9xhnzwpfetj3Wm0DQ5VQRZP1FmMTNkn950rD81Lv0bGlFU+pPZEtsT1lwaMpd/PrREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6YoJQ+qp5JbO/xl84XE0IUhNvUz363QdC0IdJGj5Es=;
 b=f3mTrmB+C+V/iCY1M2c/PMdIE7gFgqyH3WEySfbgqsvl9xnRiXp/AL3GJZFFuLzRVvZMCkWY3fdwIfiNm8Dfvm6zXhKjeAydtf7VwXUxxX8kftnty/lc0hwdNSq8aLxYG36PezbAvjje1y35Ph/nztM/lWGjd7bGQ5uP8jeJIj/kdOmETYf7nHqDrks3ICUrQVg1dbzCVnWL9LmzG505K7F2qitSmBqAKwmmHjzCLGJXcICpjUZPfGfv273c6FgFxDLrWKScaS8ze85B1SUM1krpK1SLG+0LvVeMXR1o83pRP3TOPAM0nipPWrIlS957/I4F2cTLg6HANhT6jPSH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6YoJQ+qp5JbO/xl84XE0IUhNvUz363QdC0IdJGj5Es=;
 b=r0ht0aXkPPh706uNGlvixvhu+ABX5zpTDIRACYcjm7fjYtoasuErn4Luf2rxJv/4boOLSoh/eGfJ6wiwY7GT9SDwSwaMrXz3YOJgbfDi7UW+SY6SpKQGW7B0WQD+vSMA8eZ5L5dOR0MDpn67LSVxd/LE2JcR9b8O8ucK76hXBtc=
Received: from MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::14)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 17:10:39 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::4e) by MW4P222CA0009.outlook.office365.com
 (2603:10b6:303:114::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.17 via Frontend
 Transport; Tue, 27 Dec 2022 17:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Tue, 27 Dec 2022 17:10:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 27 Dec
 2022 11:10:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: simplify cases
Date: Tue, 27 Dec 2022 12:10:20 -0500
Message-ID: <20221227171020.106726-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 0472428f-dac9-4898-5d18-08dae82d4699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrh0mP4p/IHSoRYuuIKYJLIaJdtN+6AwyvrGXDGiv3JYmu2XOc8/mzmn7ATJbXYoOZEZZ3sQ4LA7JKNnHkkoOyPPVrcFaDHgn8Kklqm6zALMPWO1wK9SyGtm7C4ujxGvPQCxIeMTU5EWoyiM8RLbO6oM0LcnjOEjrH6yZ+THtLAgOEasJXWZiFyWTy2qU9iDDfkL5YOBxLmlqh/wp6ApDNcDcbyEj8EAj6Cj0Boie4M+q0Z81t6eUtjPipiW18/9rVQJKuu+4WOvYknSifUrae3xg3BwQ9Q2DKW6FMkhc4rduBY5Aglcby+g9AXdVou2qQsQsjTGPJiP+UiEB+Ng6rKoi49jCBHvvb+S4qx9Q+bnBdNB9E1lsKQl+Jeaz+Avy299a9CvPOhMSs1GkMFC58UTdnQyLehN7HeGRpB02s7BAjMP4nMRTcWyvaNomZf5OlBZ7Dk0PDJT0bpld6HTzOoV/hZiuwNHYZ9dUtVvvInEQT3lI6q+o8bge7//QKska2+OagMwUzmDF4gA3i5vvjFHWxhRnFC27OG3NCxIcVDhO2KVh5pTotcUxtH0kdlvNrVHWdYbgXIMisms7pNHjuz/qYG7Lgh/dffpjgpJ9xJIc/FYmVqrxjeUJ1ds6+qpgznJzgKOV9r66n5VU6B0h+8WVH2rkk9W0nvnWkeKfSOSEOT4KNAntNA46Ho/oTTKN6EbzYuq7tXroUyk22u4i/IRbV0leABz4Sv4j8/kN/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(7696005)(82740400003)(81166007)(86362001)(26005)(186003)(16526019)(36756003)(426003)(40460700003)(336012)(316002)(5660300002)(4744005)(83380400001)(8676002)(4326008)(1076003)(2616005)(70206006)(70586007)(40480700001)(8936002)(6916009)(356005)(47076005)(82310400005)(2906002)(36860700001)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 17:10:38.0568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0472428f-dac9-4898-5d18-08dae82d4699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A number of of the gfx8 cases where the same.  Clean them
up.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 091fc2bb8ce5..521dfa88aad8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -263,23 +263,12 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_FIJI:
-		gfx_target_version = 80003;
-		f2g = &gfx_v8_kfd2kgd;
-		break;
 	case CHIP_POLARIS10:
 		gfx_target_version = 80003;
 		f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_POLARIS11:
-		gfx_target_version = 80003;
-		if (!vf)
-			f2g = &gfx_v8_kfd2kgd;
-		break;
 	case CHIP_POLARIS12:
-		gfx_target_version = 80003;
-		if (!vf)
-			f2g = &gfx_v8_kfd2kgd;
-		break;
 	case CHIP_VEGAM:
 		gfx_target_version = 80003;
 		if (!vf)
-- 
2.38.1

