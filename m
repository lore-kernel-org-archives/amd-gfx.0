Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1C6C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 22:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF48310E583;
	Thu, 15 Dec 2022 22:11:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B42B10E581
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 22:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di0C9YoetYtllqf8YwGX/IXHItuQ6KHFXfrPO0EmOznH5GDyiLLZ6Wnwulst9N7Ak3jALKj9IIGqx5z+iob27LIcaF2wprwy4/DKOPGmh8P/oLpVacmM3SmoDZZ37+cSHfan5jBgqzLWNSX86rxNFiDJexFUxJSzZ+NZXnLlC0UB1l0CGGy/LScOPU+lEu6JmbgfVBxbB74q3b5jfOJfHBOW6EwDElbo22F2sLLoidGsB/8h9ZoSotIKxz+GZI+z4gOPOeWmsMiK9c8c84QSUKDEGxcdsHEgqM5V3iUp0H1/QyoLqGbq4glOG8Tm452sIi4VVDvLn+Kbc/BrLiuyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGK0ylQpOdOdFcoXv+0ebgIFr126VspQdMCvZtZaQiI=;
 b=D/8c7PCNjllpfnNNPt8YKAwlfu7RLroNXRdP6okn8ssMZFLFivZbDwQNfLUsTP8zj4OzeY3uIgOH1i9+VB533wlvt6SC2fS37u0OwqaPFiXU8pzQuI9EkhmwAuBJBRNpVFWtURGJsdMJcJULa1abVyQ6M8yixzkq7j3YkUKrYazQdDs380gth6bUTL/Okfx8xsDVtCgX/eh0mBQBEmMSx+7hdFFClevGGjjtHgk82O+rJEUxVWnF3quMRtoejrbSvh52NVOxySA1MkuuYULnRWXHYT3E61o5JNHDCs5Tzn0XBfxTRF1CRfb44sg+/Ol8mYpvp2hb3gBoQXS9sWul2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGK0ylQpOdOdFcoXv+0ebgIFr126VspQdMCvZtZaQiI=;
 b=YePlwURNzj8FHdV+naJRWc+VG0FwqAFqvPmBg7C4YT76wb7Px2h2opIQ59wLfGlmTv2bhOyCQ6helQ4C93Cnfwzg/w5PDpw6Ay9N7KY8ux3CaTAeCJg4j8nSvmhHZkvzK6h/C4ktJQCISpnaWTQdTmjxQsaF1Q3VG3Tc6TK9LDU=
Received: from BN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:e4::19)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 22:11:17 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::57) by BN0PR02CA0014.outlook.office365.com
 (2603:10b6:408:e4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 22:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.8 via Frontend Transport; Thu, 15 Dec 2022 22:11:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 16:11:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
Date: Thu, 15 Dec 2022 17:10:57 -0500
Message-ID: <20221215221059.509565-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215221059.509565-1-alexander.deucher@amd.com>
References: <20221215221059.509565-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de41427-3a9c-48ba-99cb-08dadee949b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2d3mLk3O9Ajghrx9OTBtLYLPW46/U9+IgIAVRWjCh93prdqiUj6Qn/phz3njNpswI5CUBlm7/yV06+zZU2UMjyROItrkh9I7miqOgGR2dLH259ngrLj58CeVtpWtywO0p4xegWWJeAnjfVEXbbAMSpm3+DqOV5oKELpPNS5iP8CaPWmd6reklXheovnq5An8p9eCAo1+1Lu4NPgHe2rGGurPbQEnjFGpYhZG21MZ39/4M9+WYmOFZB0o0xg1K6Uj/s35v3rpvDNI8vdgSMVzI5ejh9E22LAiYa1BG8Xzu0idMDvFXlOGbjYW2iRlx6mCEyV3aNBvr2YiSvfKdajooXpfIpq/T3qPbIAbRnpTNRajkBAmaqnpiYzib1HQddpBK3KcAWiKHZyEONKiapO6zJWgO66sFSaPJdaXepLh4Hn8gLAR821XTmV10phNZz6OJA+2ZQN7g3wnAFdqjvmKHtEzuIIXyBDbFzE4U8wnhCtxOqdYD4HuGyn8E51wIm8FXG3cMzVL4z+PFL67PRzS2vykrgF56NBLTZxwa86uxKSZjlV+cfUiQyyEBFAyrrgSr4THpNNk/d3DSO3XcYkmomBD/WekFE7p+PGURR2kjuJziMNe16CH/eLTlipfBuWaX4aYJHcfa07omrIxbQ5qvpokNmQOoyzx14KJSfGjuOEKdQtplHW48XirQv/6UEwH5gfbKVRw+OAS+IKkZyglVInaR0WhKdRM6wS+zWpUwDgRm184RhPGHT4klDXLCuU5ob5aTNenBC3avm7efVX29O9Oy3foP7uHr+HKAYFdP5k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(36756003)(40460700003)(86362001)(6916009)(54906003)(316002)(26005)(186003)(478600001)(15650500001)(8936002)(5660300002)(2906002)(70206006)(70586007)(41300700001)(36860700001)(4326008)(82310400005)(82740400003)(356005)(81166007)(8676002)(6666004)(7696005)(16526019)(336012)(47076005)(426003)(2616005)(1076003)(83380400001)(32563001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 22:11:17.1352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de41427-3a9c-48ba-99cb-08dadee949b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA 5.x is part of the GFX block so it's controlled via
GFXOFF.  Skip suspend as it should be handled the same
as GFX.

v2: drop SDMA 4.x.  That requires special handling.

Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a99b327d5f09..5c0719c03c37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3028,6 +3028,12 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
 			continue;
 
+		/* SDMA 5.x+ is part of GFX power domain so it's covered by GFXOFF */
+		if (adev->in_s0ix &&
+		    (adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 0, 0)) &&
+		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
+			continue;
+
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
-- 
2.38.1

