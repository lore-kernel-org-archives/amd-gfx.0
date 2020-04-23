Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F346C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD69208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cmsvcSpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD69208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8163E89E59;
	Thu, 23 Apr 2020 07:02:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2417589E59
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2kWjNw28fU+sa+C3oN/1c8TcukBm+T/5c4/BgBSU9uDswBXBtHhtW86OXrCsScswBgRx0/xQvWmd1ymZuT6tWHyGqjjcgAGbWMVyASs1faMqRE1vCEyfI5n/EIgd3rHlzgpe4b9V9n4lw0YvDTfo/Hs5jO0dJdWTiXnMTGLK/fgH5ZC3CMyokKiLeJT/LX4LKrHwBffbO1QVmLUb7oJDTCPE1WOnkKUpZdNDX9du6NaEHGzye6/+XZuAlcTA3OJYEJICcF9VCaSF+loXtdJIO+tJ7xyCuZIwr6yZ1LTs1vS9akFPQxkuKRwLRzHEbMk43gclxni6FxN2prjDyG8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8S4o4sf5HnY8gB6Gi5FuiNbcVW05nl2X9VwMPIFggg=;
 b=BZvqAoVSuF5nnMx2pOeuYaK8uwxZPwpIugDtb61hfgZTFA9hv5RBr5tjX9MqoV/KONLWdW76UG8NdsJylYpxf97p2AM048PS5ejj5/1eLgT5hD1MSfR68EmSRz0Hbc+3LWPrqubpaAqctyHSP8QQNF6jbzo6jL1cJCblO+qPPiqEe8H16js9o1rROkGym85s81oACfYdFBTVhNrQYYRe2Pxq/DAvnGAenD12IyD9GuMjU4IegbmC0GV7mJi5g0V2PUlhYyP3YtwMRR+3gKnlRbCitb+D6Y2XRLcZD+k/04SlJxsLnxExv8fgHbOPaabMwHFcPKwqcAS8pje3Ux05rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8S4o4sf5HnY8gB6Gi5FuiNbcVW05nl2X9VwMPIFggg=;
 b=cmsvcSpTtm0ZQydOlSy+8Bp+OqhIZC4fsUqHXmdIDN0zuLSzN4K1UxbwBX59LERyp5TPm6epaNSV6VeY/B1dXgRx5gZRCZJOHCLsh7frTtMvEouW/kS1k6OjLJR76HPW082sBZEq0PXWuAN8d46/wwo3wMWkws1IgN4rqwPiYug=
Received: from MN2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:208:234::19)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Thu, 23 Apr
 2020 07:01:58 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::c6) by MN2PR16CA0050.outlook.office365.com
 (2603:10b6:208:234::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 07:01:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 07:01:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:55 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:54 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Apr 2020 02:01:54 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: clear the messed up checking logic
Date: Thu, 23 Apr 2020 15:01:43 +0800
Message-ID: <1587625306-20704-5-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(428003)(46966005)(426003)(6666004)(4326008)(82740400003)(2616005)(8676002)(81156014)(478600001)(26005)(47076004)(2906002)(8936002)(82310400002)(316002)(356005)(81166007)(4744005)(7696005)(6916009)(186003)(70586007)(86362001)(336012)(36756003)(70206006)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d92deef-54fd-4793-da54-08d7e754368e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4305:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4305F406806039B6C894434584D30@BY5PR12MB4305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vVPyTRhYn/yE1fbooU6Gi43eApVASE1k1jnstQ3dyGZ5aGMErUOKsU7d2Dcd8Z1r2UkQ6ODJ82zvOmUSQ5xS2wtVC3GVjcrVvxRQkM+LNOgcFB97aJWs2rBuOnNEyvDTDfSw2e4NR6sLLeewIRx0QIXrusyQFhA5LvapRc1akumKYvZlrN8iqYnrv5m5owrdWqvGas4HFNgCR00LmqqLB5OeLhTP96GyGwl2WOGv2Kcxufm9QErrM74Q/6YwCiiVM8fWzaJLE3SJ98yj1eLvRbhyJjcbW1U0urwIMyMZEigpaGNtsNVMm+5uT5fL3kYcj1CtjIRV/iK7rpeTRnY6zryVcndUwCT3S9uP4MC4b71dG0+PUVFmMadJdSGu5YwXyOWTB/pCRaNvLNsSun4SBNzSf52++76skx1LNRcu+ROvTGKhZ9rD8lFgJmoEC2wvOPSfZNRtZhKoNk+CLYu9g50AU7zEhZ7/eWwKM44w02uZmUlpLNZxueb1Pr/Wdsq+HSMYlYqr11cdxYFDF8txA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:01:57.4385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d92deef-54fd-4793-da54-08d7e754368e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

for MI100 + ASICS, we always support SW_SMU for bare-metal
and for SRIOV one_vf_mode

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 2bb1e0c..361a5b6 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -571,15 +571,10 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_VEGA20)
 		return (amdgpu_dpm == 2) ? true : false;
 	else if (adev->asic_type >= CHIP_ARCTURUS) {
-		if (amdgpu_sriov_vf(adev) &&
-		    !(adev->asic_type == CHIP_ARCTURUS &&
-		      amdgpu_sriov_is_pp_one_vf(adev)))
-
-			return false;
-		else
+	      if (amdgpu_sriov_is_pp_one_vf(adev) || !amdgpu_sriov_vf(adev))
 			return true;
-	} else
-		return false;
+	}
+	return false;
 }
 
 bool is_support_sw_smu_xgmi(struct amdgpu_device *adev)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
