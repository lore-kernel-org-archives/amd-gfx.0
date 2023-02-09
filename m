Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F84C636D7
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 14:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D511910E22F;
	Thu,  9 Feb 2023 14:12:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CB510E229
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 14:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP0zcTTMtQRV6HWlBtcNa5B8ZbO/+81gRDeTBiyupUMRlt1psOZ14GM1+6tPWDEadv4RVypAAcJKOysRnxxKWeFwHxOCr0eVAifdwEM84ljDzHx6qog++6HTtSljqA+WHrof3v1w8IxnwLXfifPHW87U6KAxN2gexI/GPQ0p+gJKtQVRRSbqh7/UssL1aHfhUnhLZUQgxbdrYKNo7sVUEuwa09VO+fM9+Lk9m1g8yhHbocQTl7pOxQyvZyU+dewzBhLuhw+Fr5/OJ1iUwn+fd4AkvB6LFMyflzRekh97fSTXqES9Pni/Knx0vyDKCh0NLal2AoiADDitOyViCN6xkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jmPQP6uZ6gVjKWCsF61fAtHVjfeyLHQxsY3lQ+okvI=;
 b=YQukWMoe8FyAqm4Mm/4pry1Vn0pOyu1JheGKaKmNj1mg1mreonqlSuCfa0GWkh0j9Ca8EKJWxyLIgsKaMawY5iRP0ZECf3mye602H8bHWABGvYeZ6J0nXDRpczuv6byNGjJnLdOBwIaewDOGDB0E0HiCK2bLcsKdq3byHTUp3kC/qK6MPzaNgFxTs+cNs3W+9H9ulD66q9TVQcOANAZ8QXB1ST2SCKy7GVZCGZYx9/XBkdd05zTh6GGxXN9rhmV61MLa2n823JqzNCFkn8DNJ5RD5JhQ2u0tON2NRALU29siY29TaL4fpX/WTQo9NVPMglTnrLBkPOOhIVIbIwLoQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jmPQP6uZ6gVjKWCsF61fAtHVjfeyLHQxsY3lQ+okvI=;
 b=Zas03Ghjk3tfdZAWESUMNlkNiQWHE2LyrYHfCIEo99QplTCOS5AwFMc3uz3uUyWoYdcql0et3YblQppi+1GFWAer1USEJWvftBEzWPQeHmyyMCrdfyXRcV/6MSRbqqmCLtOliXmwHia6fEO4hqT5DDWlqaVcHae8RYKij/wh3B0=
Received: from MW4PR03CA0030.namprd03.prod.outlook.com (2603:10b6:303:8f::35)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 14:12:12 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::46) by MW4PR03CA0030.outlook.office365.com
 (2603:10b6:303:8f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Thu, 9 Feb 2023 14:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Thu, 9 Feb 2023 14:12:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 08:12:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] Revert "drm/amd/display: disable S/G display on DCN 3.1.5"
Date: Thu, 9 Feb 2023 09:11:50 -0500
Message-ID: <20230209141150.612825-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209141150.612825-1-alexander.deucher@amd.com>
References: <20230209141150.612825-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: d2711672-5a15-4d3d-6ca2-08db0aa7a36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: osjTCYI5YSwRuVfhxwVvMScqiBXd0ooDv2yrQhRqxuueOz8BDmc3v7UZXdLrRassE9zw6Yx7VRSEqspPO47mcFp/Xl2HeGlbmCgyeidmKxhCD5qO3W9SdtFNPBALzZj3IYRVkmbqis/9O3wd4C6AuRMBnwwtpt1WHQ1Tf2EF/6eOwL9fw2IoM/XwPXtFXjAXxmIVJfMYBjGoZ7udBGZTLV0YUF1fJLxqS2zrDWq2xxpOI0wRRokaKwa1QRFby/5I0zjxM5/HsALPxGxKQ6piLyT7uSk6twDzQiBfAsRhNSPIN2+0uxpnY9Hx3isilBuegMi5R3fXTKe1h4Kf3ZiN5KExAiazG5COsohULOd2l/SFacRB/NwffzVxBH/HF7bryTqU795FjkD+AJrdIOFOMfe2cvcWMx7CXfbsf28l5hHgj/xuq6tVbTDON6ybNHDF+y4FkoXQTho7pRk0eGrZ2Zivadf6kpNrAH85ccqiB881U/Cifk7mqrF4GyvkEYvWkgG1loa4K1EzUcbg/2sM+oSxeJvkMpEVHhnxhlS/Zd7BMjCfxsIBodYYELbfD9RHz4Fd3TDS44RU50I2DLdT3Ntpyulzw4fC0IkbJ172+0s3X9TNbo+qPSXB0qHyITJZ6n/5FgyDBSclZyjAOnj5DZcdMrtRGRzH3lc7vN9SuChw+YY6fkGlIIKXthqjWxmUp93OIK4XQybZ3GMjymeFM4CvezOkczYWRHPR+uuDxYg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(82740400003)(36860700001)(81166007)(316002)(5660300002)(8936002)(41300700001)(6916009)(70206006)(4326008)(70586007)(8676002)(86362001)(47076005)(2616005)(426003)(336012)(2906002)(478600001)(6666004)(26005)(186003)(1076003)(16526019)(7696005)(356005)(40480700001)(36756003)(82310400005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 14:12:11.9390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2711672-5a15-4d3d-6ca2-08db0aa7a36e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
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

This reverts commit 3cc67fe1b3aa1ac4720e002f2aa2d08c9199a584.

Some users have reported flickerng with S/G display.  We've
tried extensively to reproduce and debug the issue on a wide
variety of platform configurations (DRAM bandwidth, etc.) and
a variety of monitors, but so far have not been able to.  We
disabled S/G display on a number of platforms to address this
but that leads to failure to pin framebuffers errors and
blank displays when there is memory pressure or no displays
at all on systems with limited carveout (e.g., Chromebooks).
We have a parameter to disable this as a debugging option as a
way for users to disable this, depending on their use case,
and for us to help debug this further.  Having this enabled
seems like the lesser of to evils.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f7ba65fd8f48..7f16be84f3b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1571,6 +1571,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 4):
+		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support = true;
 			break;
-- 
2.39.1

