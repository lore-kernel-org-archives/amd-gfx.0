Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A054ECAAA3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A387110E24D;
	Fri, 26 Aug 2022 18:44:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F2B10E0CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmf1D9XVdMYHIKK4YPnHDJCj6jJhLlHOfRVaaIsJa6iFNzLnwswSPjMLI0lpb9gP6nhr93dCu1tgdGnHnpGeCUDZfBciO4PX1K4kX9VXWURiyCSqSl3O4vl17X573CUkijge9ImmOhGu68huwt6z8Ksg5HRiVpZUXfp2zBk2+YF2gThGZ38M1uLv4Ol8uoURkMaQUxTwBlgZbKFYZspOT8bXFjNNmzRkeUiVLxcxeGfijXGBmQ9LHEngSzleePhep4JEnSglci7f2E/LCpRqW26nOAHznw99z7Y7N11CSnd/D/oXUdz91HrPzbdW6l1JHOU+L4FCwCvvvZcppszndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNPP0MvTHNRm2ULXHCLZk9Na2ExuNagDGdGTf8NOeM8=;
 b=Rx2WiNfSlppYPlATIwrR4gOJ+wgrEItT5lzJwVtom3OS2UzDGySLcyse5MFXZe0JDfzxBGgATVfGLejcYDDJlFrrPDZHRPhzwJ7PkCXQK6Oxi3x4/4YFZrTuOmUvasFTcEKjo3phLtjlJscxHCoiZ16CaY+Om5421RYgRtpxnR62Is+cmtkQ9WSBQMeNDyz+ElWUfQkiLzuej85XrT4PNV8pXreHSQV/Ss/HJBXdwVWIaghELpmQScrTJHBeV274/FiqE1Ypncb78cSvnvVvhEu1v2q7xWjCwzkTjDScy3JcT39vBEegYua7Am3lk9i5BmOlsejMjPFhMjuZsCyIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNPP0MvTHNRm2ULXHCLZk9Na2ExuNagDGdGTf8NOeM8=;
 b=zpP+EFZHedsGigQ/S9WyU6cyE5Z4f5QQ6hLlG8cXW5XYOepLOqvZLvruPqnJvyGVe7tG1wKyoC+z1HngMIS8fEFWVfmzNI1bQ/55nZeo3AEepf/hj4TK1tfVa4x0saQjHQXtLyQAITeoXeCpK8Q+LQxlC0HTXP/W4W9B8GOx1to=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:43:57 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::53) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Fri, 26 Aug 2022 18:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:43:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:43:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: add new ip block for PSP 13.0
Date: Fri, 26 Aug 2022 14:43:39 -0400
Message-ID: <20220826184339.855360-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826184339.855360-1-alexander.deucher@amd.com>
References: <20220826184339.855360-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44bd2213-a8ac-4506-ae8c-08da8792ee41
X-MS-TrafficTypeDiagnostic: MN0PR12MB6246:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JL/7WSV6VBRrWf3hMo/GG4420+XfDeaBZQNZLQ6CKtwcFa83ijKbBxb1PyaNpsbsduA4jW+9dEc1x1q97SW2CLvAWjxcgiWzs2ptE+iM+yKqB3blt3PsedfczSuT1BVBk0zdHCTa2+2K4KgqzDEwaZ72+pfOkKTfP1L2poGYtZGGpNRf3omLG9q2Bj0fhbr9Bv/63mhAH/X6XPL5kCcB6DuXnbsdLOL8+2dF+bpsPbxC619FFRzobSaBFJmFVNztGoK3aKGFED0sk6NCLxaGKiwmPXdrQZHs7nax3erXK/fs1wPQp4BS/YlZXXaEPvzeGDhOTFGZUJD8pEf9ZlEQM0cNQiHam61MZpKtqba2YmeltZESiQx7MPP6S0TtRiyXOsNoNQS5qsPhRjS29GrScn2ajoeRaDkDx5W/qaTUq/ghRwGhCpT+ribkgI3rrVO4NST2M9mhB1PiHxrqxNOtB4utOF9uLqiNXejYsntrmqhnq9bu9GUp3Up0aI/HAR+U/rWTJUqkUv+iEJKAhVO7IOvO7hnXy63B+qAudnuF5f4MJ1wLgljEDf+2+qR8NOeQKJlK7GHdJkAmM5aclrrzHec90k5NllXaWAvHKCvslNgtg201CbuqIcemlAGY0myK8jQpRG01UMw4LLOJFBXuFKwLyOTMf5Cops/PWI9Amlar61wJkP9y/w6s3Jrq+N1eHMuskJk9JsKoBQNfaLOeBWYKbWaY4t7rEoCgVdGrlSdxb3sn+8nbgW1ny/tAXPDhq1u+m9MKoePjH7Ik8SWWCOfTAQ1TAE3z9FbZgz1hv34=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(40470700004)(46966006)(36840700001)(478600001)(41300700001)(2906002)(4744005)(8936002)(40460700003)(6666004)(26005)(5660300002)(7696005)(86362001)(82740400003)(82310400005)(356005)(40480700001)(81166007)(2616005)(426003)(36860700001)(47076005)(186003)(336012)(83380400001)(1076003)(70206006)(6916009)(8676002)(4326008)(54906003)(16526019)(70586007)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:43:55.7978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bd2213-a8ac-4506-ae8c-08da8792ee41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Frank Min <Frank.Min@amd.com>

Add ip block support for psp v13_0_10.

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c2e8a9fe81f7..533e40dea5c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1634,6 +1634,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
+	case IP_VERSION(13, 0, 10):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
 	case IP_VERSION(13, 0, 4):
-- 
2.37.1

