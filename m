Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6771EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 01:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD6C10E577;
	Fri, 16 Jun 2023 01:20:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24CC10E577
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 01:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPf6KLc09LhRX6zakO4+h8nYgphVu+dk334vwCjeqD8JrMKg/TH8oHEU5zSXnKtZqMFdjg7kWET1p6/2SpPIVUlOwO4gDKtA4alasrLyZyrROmEwyMF+Uo4m6ien5FR44zLL7YHH4nN3fwGsltHjz6xMsIAy23tHOPU5JRS5Rei+ARmTTv9SuPxFGIeK4O7UgdVJTg3uaJOKRMxEpqUM0v/7yCDza3bqc5cqXSwaYLEgrWRiv3mSvDAKRNfPj+LH66KAZRwTrALMTHqyMTfEjqI0/8jHX0j5z+lJaywvrbc7H9kNQhMMAQUyTtTQ2NeURKLovMgkCLyhUNc0blTPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nccoyBGs1WzOdSQ3KZPX+JaGP6epyiBYq1Z1BoocNA=;
 b=NDs7T1yQMr6SWk4hH9EfuOAf00MDhoQbRHOR1M7fecoS/mz78DLgV3pgRB/ggGZBrhfP7XSJKHDrrjdOUVwY1UeRTPaoQvyjHpePMKu/w6JWyWi3Lpekv1MoZk3OQPVQ3E6jS9WelpH/rnY0HLBFtSPAPkG7su5whqV3WOtUaxJnGDAs9La1q0AhIsi2LS5MidbvUy6Es2V0RC4iPJ5mH9AX/gef1QcMeUnNVd6BuQpInkVOit/PWQblxXtfZQyVUmS5G2C7VzYgvXe8WJF9yoN8WKgOfzmAYii5GPsITRYv7YTuxWoNq0B7Is71Cyc7TsiG8pW+A0Pr7A+F4CfiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nccoyBGs1WzOdSQ3KZPX+JaGP6epyiBYq1Z1BoocNA=;
 b=aRtD4ZTH2usa9U56AesCuXhnmFE5uidi7ruh/BN81Rq28pZ7r+R5Ymz61XIFFWJM6HWAlTyvOeHuL5eDiaD2UiId5WPIKiGcP0ufGHT6yoWfsT89InjFPeMa4Za6yEbsQ1JHBCEYQJkzquKTAIkW09I24FeGjzY2hKH0ZCjM8kk=
Received: from BN9P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::25)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 01:20:39 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::22) by BN9P221CA0003.outlook.office365.com
 (2603:10b6:408:10a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Fri, 16 Jun 2023 01:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.29 via Frontend Transport; Fri, 16 Jun 2023 01:20:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 20:20:38 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: update the LC_L1_INACTIIVY setting to address
 possible noise issue
Date: Fri, 16 Jun 2023 09:20:15 +0800
Message-ID: <20230616012015.3699013-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616012015.3699013-1-evan.quan@amd.com>
References: <20230616012015.3699013-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e195184-c9ac-41c6-52bd-08db6e07e590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: foTpIL9/kwx0MSjxN80r/Y5laxuD0FDDrDUwZ5A0vdFLryyUGpR133qAS7cehxXnE7oIObMzMV4ttitnzwTZ9gOb8Nibv98lpkObWHVfqV/JNkQDnVRIjoDMb6/fdGqEa6Ge2ulYBS9z7gsOQl437u7wVoJ1Er+cJ9iU3B/HGLhoeiySW2jQ6HB3G5uUg1gzZYAlEfK+ydG4KjYDEPcwBS46PyLdS0YIFjZw8l/V9R4c1sxOynBd91J8cdTojq3lHN1cYjm9zmC9HxSN2hKcl+X9zCtuzevBF4SpQv2iAmOkc7nm93ZQRAY632QD9Ny+O2cf97RIlvyLAJXtpNqLpiUwXeCnC/aKv+3bt7ZgJZEyhQVW7oP4ii6TDrIdCbl+M1fEJ1FgQ5NS9pL9j3PnSaW2lgFacIR787T3EX8OS1GiI1JI+6mIWgc7NewP9t2NDD4MC2qdU/VpiIP8Aa0zPNhAwbgzzOuAgGgO7z2YmLYqSEtbE/m0gKb3I9Ntzgb2l0bh5qhByMsZ3kjPzvFbphYnbPyJGAgOwEjiEKD8Z/hR5+i+yRphjrTi25yyB27mfeau/IoYWO9XUWu9MTDUggjf2hyWwenI9PoErH1WIutCVlyim115Q/QD7D2174ylKyS5z2C43SUFKNu/MbzJOr1xzJbYHt2uuHC9M8DQ5omkWgjZxAymplAEITpRqm49FLa/0iaOEpaWhyvGyu28KauWuL3QebiRi6Cu0krUQn4Lhiz+nUgRkncayll/GZL9qpV9CFq/J2XmlzJhwVf0Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(54906003)(41300700001)(86362001)(7696005)(6916009)(70206006)(8676002)(316002)(6666004)(8936002)(82310400005)(70586007)(36756003)(4326008)(40460700003)(478600001)(36860700001)(47076005)(44832011)(40480700001)(26005)(5660300002)(82740400003)(81166007)(83380400001)(1076003)(16526019)(2906002)(426003)(186003)(356005)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 01:20:39.7855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e195184-c9ac-41c6-52bd-08db6e07e590
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is proved that insufficient LC_L1_INACTIIVY setting can cause audio
noise on some platform. With the LC_L1_INACTIIVY increased to 4ms, the
issue can be resolved.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 7ba47fc1917b..4038455d7998 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -345,7 +345,7 @@ static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
 }
 
 #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT		0x00000000 // off by default, no gains over L1
-#define NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT		0x00000009 // 1=1us, 9=1ms
+#define NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT		0x0000000A // 1=1us, 9=1ms, 10=4ms
 #define NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT	0x0000000E // 400ms
 
 static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
-- 
2.34.1

