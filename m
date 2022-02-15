Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F9CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 15:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B0710E48F;
	Tue, 15 Feb 2022 15:19:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1817C10E485
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 15:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdyX59wywG6r9hppRaS8GCMf3ntJkzSvdRTHiSUtQLgXhQr8x2TcyuZUMi78Obv1fcWEQUTEWPwQz8NlupAvxtI3jh/XDakkCH9IZGwBL7lwaezfT+OEhP5LF9zC+3q+aVvUHofQvY/IakYddrC9FqMKg0Y0Z6X+iygXcZQEI42p7intOSeCMS9FSkeonsI9h06VJllN/D4L0lowc6vg/nTxgLIDyw+h53lX9dKn1faWeUWDXn4Ts7IS9wZB4t0hhNKtKYqfV1xHNBea/O3O7DupPplS6uCoFf4TIFshcxUXlFAhVakOjsw46bqlfcCuqJ0UzjDXfqD7JunQ6WBSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JVDDaXqLFtc+DLR0fppEJL/OeRiZ/PzGUSNTIUrPGk=;
 b=J8eQNm50psOGI8hsYvRw45o9tPe9W42N3HZNUUpKFwg/vs15Pgg4NAbXKZ8T6Kw/gBw7gOExxuHfnGYUaCNt4HVh+shTv2kg1/CS6PpeeuDZZj+v7/AtxmL++v2vKbwv9SzYqpYDJFOAb1NesMuZKU9DiMKKoPh1qNkCescZXpU9NqqukJsIFcVo/nFzp2+2z3rberBpGzvTKzVmj6BO5fmO+lPOXFnzBTaSOHN1C4TLEjfPRkTTCGsSb5DIP+29LeUDc3I+8S59CC/rJrFKglP+kt1+jnbNAccXnEP/80cLx0npo1sZjCPvyMRFaLY4vI6nCPxQWsve0mpZwurmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JVDDaXqLFtc+DLR0fppEJL/OeRiZ/PzGUSNTIUrPGk=;
 b=A1HA3BtWw5OmdPya7URUcsAJ6lCYH8F1m8FnTR/msrVIYomx+VdfsGQp7p8hienoVfbqV0bIRFFaEIDJZW02pMdsfUVoqs4vK90Q+/OCPycmYewsGyfiRAMeSBZ7qaLjxvgQIN47H0CWfd769A5QTg6TnTa/LJJOQ0JBYr4DYVo=
Received: from MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) by MW3PR12MB4363.namprd12.prod.outlook.com
 (2603:10b6:303:56::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 15:19:44 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::5f) by MWHPR1701CA0008.outlook.office365.com
 (2603:10b6:301:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19 via Frontend
 Transport; Tue, 15 Feb 2022 15:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 15:19:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 09:19:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc10: add support for GC 10.3.7
Date: Tue, 15 Feb 2022 10:19:31 -0500
Message-ID: <20220215151931.2229745-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 115ec519-a73c-41ce-8a16-08d9f096982b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4363:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB43634010D1E35144E09CEC76F7349@MW3PR12MB4363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwFr7HeNeF6bRN5+ah3nIiXjajLjASNW6w18HS3dHK5thevQBAfI+8bjaery6ruInGMTWBjqW23/iHo1wyZXoN2pJRnr2t8GmHvdqRNFXtlCdiWI7ntAVkyPRl6kuRTWNH03rdQAfmGKIH2aOQhdZydynz7Qn7K6h71sThU83monLnR1vGRd5fSfoKYgN8fazrU5K2QoyiaEl7cnuwYBYkJovqFAo87PVq5DzPelf9XmXPckwTXJBRbkoAPVZ/hFG60j1VD9UXksW314cpYVrYzsSc6auBE9w1vMcLWOdN6mBkgW5Whqg9HkddCfYtVPTIMRZ/gSQKCayj/BuGkOByn5hWDtIuPTyqOm/LE1R2uujPPyZUQPJhBHho0LqdcWNa1dAKjX0SYJogcMokEoPvk+wiSYNmzs4MCfnYrATmAdG/5HrONgcVKM/yyGjbHvohRCYYhgmCQvSlbvZ1Qq8FbHQXrZuXUuU/ovlv5VBmQ65UPyl53BjUoldg2Nfw+nbrwDygZsxZ57zgi5G3oEws5Y9CokOiXTi0HxN7nO0eQvklf+iMq4bbazR4d9DBldh3UkSZULZvp3Aok+w2SCmJXq2yUMWQWTLg3YJYNPRG+1AAZxgVPKChkTqoFONovqHWkkImu2M4ovRoiL9ewxLLvQMdOAU9ptcSt0ffqve5f8igOcBRgWwUET2q90r4biFVHww5xC/a72uvSkLh9Bxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(36756003)(47076005)(336012)(426003)(16526019)(83380400001)(186003)(2906002)(40460700003)(5660300002)(8936002)(2616005)(86362001)(6916009)(36860700001)(70586007)(26005)(1076003)(70206006)(8676002)(7696005)(54906003)(81166007)(356005)(508600001)(316002)(6666004)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:19:43.6980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115ec519-a73c-41ce-8a16-08d9f096982b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Set gfxhub function and configure VM for GC block.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d1eaa990848a..481b7b872e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1211,6 +1211,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 7):
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 2fc8761ede1a..436374fc1f98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -714,6 +714,7 @@ static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		adev->gfxhub.funcs = &gfxhub_v2_1_funcs;
 		break;
 	default:
@@ -894,6 +895,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		adev->num_vmhubs = 2;
 		/*
 		 * To fulfill 4-level page support,
-- 
2.34.1

