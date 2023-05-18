Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E576C7EE24
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 12:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17F2210E51E;
	Thu, 18 May 2023 12:21:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E0F10E519
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 12:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6SZyC5bEXH/Lsl04bk1cqGzTqYjPiqeGTfNfjoXcoZN0+VmTg3ewOVJtgk1fnfLRTMhxCGvLzlsRHhQZG3f0cZHHvAVpPgYyWSX93COkB3xnpUrIi7AMzvrMgvWl6AWDHKxqDV98ZV1yD5e1m9zxdPLOn//6ZIctKq/+w3pZze7iTb5g9HBIkWT9cMQyUjHA4WSv/CKKdrhfc3JKd/19XQw1/sONPk/qnRYe/8pAXJMThIw9TUPkb95v5SFypUX0w4pSHVdopgtbKPNtkJFQiMj16bhxyN8i/dQwIDEnk9NsPsBMy2HASuZKgfsPOZazQ87I0M4r5ut19GWej7N8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDddOjMAzm9Y0+if98UHeAWrFZLByuSBbCPuCBHdFCc=;
 b=cyB4ZOve3LqCXYupLU7QyCfq7OZtx5LyibxJsX1armSmNrCvvxB5PUc4RO6FBkOKaH0uBlV60eE634eJTJI4AYsj4iy4NcodG3pJ9qaObbKOmfj1yX4b0MiE1bz13SjmJEPOvw5a5VBdNyZzsXdfl0Ty5OzNICGANmyHOFTnCdtzdyU3+4iCNsO2PlYcoMnn3JVdAwOJ4VzNamcjLucJjUHabM/cDiHKv0QPlBm8XEiH+mqjSPxxn4uLviuYmoSOwEySJiZ4gEZWzEw3ivLtpoL3N2xieJfkU9ramCri10TrrNRvFjkYg9iZFfDozCTMx+39l8Lxf0KRSi9fDiPD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDddOjMAzm9Y0+if98UHeAWrFZLByuSBbCPuCBHdFCc=;
 b=0kgfQzTRxSBqwGwiSdpblxssVPptLeKSDUKCIqbng7h/g9NekzW6UUHVD/k30s9LVWkLZiwos3lkFXECj0NQ8HnF65YALkctyJND4ek4TFBWq4wi8AcQWBVls1HEoe0rGLBczVyWFEEnoxbZwQ9v4jvjM66kybaIdVQpep4M6QU=
Received: from MW4PR03CA0010.namprd03.prod.outlook.com (2603:10b6:303:8f::15)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 12:21:49 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::81) by MW4PR03CA0010.outlook.office365.com
 (2603:10b6:303:8f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 12:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 12:21:48 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 07:21:47 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/6] drm/amdgpu: fix the memory override in kiq ring struct
Date: Thu, 18 May 2023 20:20:58 +0800
Message-ID: <20230518122059.28815-6-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518122059.28815-1-shiwu.zhang@amd.com>
References: <20230518122059.28815-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4fc74e-25b6-4b36-8fe4-08db579a744a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxWXOTBea/uJ0OV3WTSGW3UM3VY99bd7e5mkQxUM3bVG42N91W8MdPkZ9L732HX2IUyvGEFQxC1L4Zirj180APb+NYQETbVMFFuJhrAlyhqcDkI5GsOOxk9zLYqFDyDcCU4gx68trbHcNaOW8NubxGTjk/y5bfyf8ed5mdUNqlzbkFWLVy6FVS5MApyiu6kdYe9cPyLIyIkQafQmpOrbvelWgDlQ3epuQZKdT6/kyHkpfCnCADMdXcVKXOq0Eahfgr4EFKzQLzLnV3Tyn8UFp9oBpTgH8kV+eNUn1A1NaIXjvE5yamnQYyry9MJiQPgEEsEPYZbUtboYqDYl/+vX4uZplzgap8+NPuIgt8n+oGtS3lbXXLl7yDj1D3tjOeQgixh4p9l4VRSo8QZ13xvAsTfig4ypRe31Oq3RJFpOTRiwwVSO12Z8Tiln/dF2wu3BgM7o3SOfZiia00IOhDPZKglS6ygLYunjgZak4f7YF8izphAbZTR6FlSkIi/7Ge3vWep49KPNjMYpYn/guNFfzBXHwGaN+XgHKFZSz9Di/gXiagyLdnwb79FfsRyvCR4Ya4yPNSiI+IJ6P2klTevIcW29pOdD7DYvwhML2S76uajTc3+hzz1iAC81x8QnQ8sTyYJ751r250+phJ0eiVDd3nFlr1ejrQnbWGx3nIl/sRugb8aXUbhn+T0SXUOMqJ4ijvru0LfTdkDo9H6E7AZmX7kHb9kWLIJf4tSN6MqgENXRV1CnxQewAoeXYdcAZLng/tSQt31/FN1yO/YCws3OZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(36756003)(7696005)(6916009)(316002)(70206006)(478600001)(70586007)(6666004)(336012)(4744005)(356005)(82310400005)(8936002)(2906002)(5660300002)(8676002)(44832011)(40480700001)(82740400003)(81166007)(41300700001)(186003)(26005)(36860700001)(16526019)(426003)(2616005)(47076005)(83380400001)(1076003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 12:21:48.9274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4fc74e-25b6-4b36-8fe4-08db579a744a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
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

This is introduced by the code merge and will let the
adev->gfx.kiq[0].ring struct being overrided

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8883d5ee13cb..460a771e34a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -448,8 +448,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 
 			ring->mqd_size = mqd_size;
 			/* prepare MQD backup */
-			adev->gfx.mec.mqd_backup[j + xcc_id * adev->gfx.num_compute_rings] = kmalloc(mqd_size, GFP_KERNEL);
-			if (!adev->gfx.mec.mqd_backup[j + xcc_id * adev->gfx.num_compute_rings])
+			adev->gfx.mec.mqd_backup[j] = kmalloc(mqd_size, GFP_KERNEL);
+			if (!adev->gfx.mec.mqd_backup[j])
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 		}
 	}
-- 
2.17.1

