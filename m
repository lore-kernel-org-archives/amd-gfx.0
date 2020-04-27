Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5363AC54FD0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 01:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7444206A5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 01:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MBL4G1MS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7444206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9510B6E041;
	Mon, 27 Apr 2020 01:57:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188D289E2A
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 01:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVSyVYt0QjIXPzMKr1c+z61YlFI8e+Ji3fn2RSzIBP2mLIn2F++1LZ9O6PHlnzY/n+vVSIUDQNmryg9/GtPr16rLlf58MMJFRVhXdnOWQ87xMm7vuE18YAgPtjn1dGU1voEeynLFOhZdLs4wARcjy4n4HfRqDbJGuuoqgyV7RKyVhPcxKuLnvePKD311GeYqe8J/1McGwn+Nbe+b39F1Jy8FqRwEBpa+uNB+Yev5GThibp1Fz6+RODn64R4XLmGhnbQocBpEt2z3jn7q3i3hNHRHdGYoXxTwu5Tl+44YoyAKnlarEl8n4MMhYJBcdp8MqhRwQqQmA6Rw/latYsbSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92L+GqXcmXmZOvYyCJq0kSPw45bOLIM6BUMS5+QzfT8=;
 b=kNwOlbAst3QGuW3+WgKwnbf7fLPCNSX+xYIACEdD+KFt713iZ77kRosizYAGyM/FEbp+djEwVdoF0JNudlX7wT75BQkBsKCxS1pMc1xoz+AWbbnvRDdGU+IFSneVSI6dz67jQEYZD0r+uO4iEyERW+JfKHswgkxa+kVyAUqmeV1v3anjb0ESfj32s8tHgsz0kYQQ7PxjsUfvZ0S6DJoaAfycGNmIMF4RVsEXY0tgHKPSVuh1lxKDKY/9b7HDwZ1VE+x1Jve05GHQLLDa51J2jBcalqqA/uzAG/XE0SShG8LP+3m0s5b36aPGOtF/CCkqfq5FHuRKRn+xdC3NAwcJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92L+GqXcmXmZOvYyCJq0kSPw45bOLIM6BUMS5+QzfT8=;
 b=MBL4G1MSmoNJOXnijWeD8olVR86TEUXOCUyaGEV5BZpirCAjun91IV9wBc4i8d/lGnEzf2iJ73HkqugwpEGM6ZqY+WfBcDZZSzPs1cKrJ5NWAyj5xl57G+1+UCghR1EYfukTPdOsOiOZb1gF00XvPKs36hbcLamRv+ByI7gjRN0=
Received: from DM5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:3:23::13) by
 BYAPR12MB3255.namprd12.prod.outlook.com (2603:10b6:a03:12e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 01:57:13 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::99) by DM5PR13CA0003.outlook.office365.com
 (2603:10b6:3:23::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.14 via Frontend
 Transport; Mon, 27 Apr 2020 01:57:13 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Mon, 27 Apr 2020 01:57:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 26 Apr
 2020 20:57:12 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 26 Apr
 2020 20:57:12 -0500
Received: from gamma.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 26 Apr 2020 20:57:11 -0500
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Revert "drm/amd/powerplay: avoid using pm_en before it is
 initialized"
Date: Mon, 27 Apr 2020 09:57:08 +0800
Message-ID: <20200427015708.12423-1-Tiecheng.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(428003)(46966005)(81156014)(8676002)(6666004)(8936002)(2616005)(7696005)(4744005)(426003)(4326008)(70586007)(70206006)(47076004)(1076003)(336012)(186003)(5660300002)(86362001)(356005)(6916009)(36756003)(81166007)(82310400002)(2906002)(26005)(498600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 833a24bf-cb1b-4229-fda7-08d7ea4e4dd7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3255:
X-Microsoft-Antispam-PRVS: <BYAPR12MB325585AD02E52423EC61EC43E4AF0@BYAPR12MB3255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-Forefront-PRVS: 0386B406AA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Bip2xUjOY3lQQvn1XUeD7FxOoHaRLQED7l5YrLuvnqwJ6f0+rgyxv9r8Pq0l8q3/gUdfnrU7nDsvjL4t3BKRcfzCFiOoTnDgy7YvUucu8TNEG5M1uTSal+tf6lH1q3szGwK4kRDqlegZG3bJnsXTkDHYSvoDgThK5nkRmJTjUq3lOT0+UKIB5BhIO6EfSQK4LavR03GhOfqFDC5CyuRCKekxzPvN6pwd9B5vHDMCx3pX3qr23O+M+GUO5JQKr7cCAAk6veoTdqCGGLmSED7RJj3hK8xWdrNT8FtEMIr939PNN0AbfXnuNiOREi+WExUJas01iDSvP3EefUxh0th7G6gMHTy3A9lgAphHjL/aZ2wAd/LNXBjd1CON4X+1M6jkegPjg7BnQx7+tEtU2yXp3Qv1X8glPTwK3l7h6hkDAXQJ26wLgfy/feRlMGFxzhQWupBQZuXZRfya9nUXI0DDp1KH2UBHXOeeX9L7ne9/EZUdn/sGUoibr9ul3ua7omyrvt9n3Gp0kGF1m9DJQAfpg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 01:57:12.9654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 833a24bf-cb1b-4229-fda7-08d7ea4e4dd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3255
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
Cc: Tiecheng.Zhou@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 764a21cb085b8d7d754b5d74e2ecc6adc064e3e7.

The commit being reverted changed the wrong place, it should have
changed in func get_asic_baco_capability.

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index fdff3e1c5e95..71b843f542d8 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1455,8 +1455,7 @@ static int pp_get_asic_baco_state(void *handle, int *state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!(hwmgr->not_vf && amdgpu_dpm) ||
-		!hwmgr->hwmgr_func->get_asic_baco_state)
+	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_state)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
