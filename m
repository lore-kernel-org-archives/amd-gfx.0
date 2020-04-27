Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB7CC54FD0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 03:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5842072A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 03:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lhXB7jf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5842072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C04D86E027;
	Mon, 27 Apr 2020 03:29:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC31D6E027
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 03:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUtAwJNGWbJqvvM4zjydE3vkk+aa551acCbmpr3OXgYsD6tXGJsoJPmnoDOkyCj0XbmpiNIbmb6M2VmGvGwqeMda/NOSoJ+KNXldjvWI+WXVK2/xh4B4OFi3R+U3ILX6rOrMgKvlOSD9MepqdaHmuiIs0pWI6lQkn4hqU2wuiEjqs6SDs7S+xJ8xTXm2eqMPlMlQktzINp+hfOYhiw61f9chOlLKMfDLJlfXnV0yHGSfFXih0ANXK+SOUuTQQvFHXf570BBIU2vRLPtgywkZZKB4HmEtY9plvU416ejTvlSp3ZvmZbjgh3uNIsa9YOtGtwmEFp830TLd8BIOc3wNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R42O0pxZyEqEHhbpUL3M8sJYXFa1uX6a0pty5mXOtGw=;
 b=WBxMMU9uFDzmuwNLn/BXU8o+CrKg2ow1y86dLvW/4pAL+N414DXq/HMA3svqUFCfbDiOjdjmhd0pQ6YT0J3xhBRdkgHR/PsPazZoNW/WhkUjGMlu8NgV5rXX/axUyigkjBgKQ1Atjl+/HU6hFKuQrCByLUP8R68HcvcMC+HSMbnl3jPWnZBaPPle7Nd8CcDWeA1a/zUjHDySkGckRnMV2DtYNgezjmmTta07ONyaBxOa9yuagBOBfYFRE1ENWRKA6UbODB6trUSDRmFUQIG1uBQ6mIbT7l+Z7DetZecSeuytUS7rn9G1UE5k9jBhD4sJSxayUPniPAi6TCmVJqIErA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R42O0pxZyEqEHhbpUL3M8sJYXFa1uX6a0pty5mXOtGw=;
 b=lhXB7jf776UGafFc05tYWrH6AKzFgt6KARHrav0RsvE2hmqIo4raPsePPLbaYO+6zufSm/sP796rnaSbJ5LhwqNUtxZu+jB0w2sdxcNd/xq0sn8ZDOmJzW4rv/yfxpo50Ml1MbTtCG/DRBw0XPMyRydehUX1+Vo7uaKAHYC5CBA=
Received: from MWHPR15CA0038.namprd15.prod.outlook.com (2603:10b6:300:ad::24)
 by MN2PR12MB3965.namprd12.prod.outlook.com (2603:10b6:208:168::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 03:29:37 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::2a) by MWHPR15CA0038.outlook.office365.com
 (2603:10b6:300:ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 03:29:37 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Mon, 27 Apr 2020 03:29:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 26 Apr
 2020 22:29:36 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 26 Apr
 2020 22:29:36 -0500
Received: from gamma.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 26 Apr 2020 22:29:35 -0500
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/powerplay: avoid using pm_en before it is
 initialized revised
Date: Mon, 27 Apr 2020 11:29:32 +0800
Message-ID: <20200427032932.13333-1-Tiecheng.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(428003)(46966005)(8936002)(6916009)(5660300002)(81156014)(6666004)(8676002)(82310400002)(86362001)(1076003)(70206006)(70586007)(356005)(478600001)(186003)(2906002)(426003)(7696005)(81166007)(82740400003)(336012)(47076004)(316002)(36756003)(26005)(2616005)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d77ac09-7cce-42b7-cc74-08d7ea5b3680
X-MS-TrafficTypeDiagnostic: MN2PR12MB3965:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3965951E8835378ECD09FD18E4AF0@MN2PR12MB3965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0386B406AA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76TjS73dtA4So1nOLd35FLrurMpKgSmFe3qzkdh9DV4nTHSmB0jFtsukAp+T99Z0XYzDgZ/fnhoLHSMQWrMv/gC6KdnwcvBcTeTIu5gZzgOsMLmqvgxjprw7lVDVCaAB/hK4G3Z/TyHxobjRRrAXoOsZLPBj7q2Kz523MLBbxSG7dQN1quSiID8wucrhrfriFWepOP7tNnS4QgGns3xKRgX1TalrjTa+AtigOmW5N5Czi3MEri5xpYCJ8JffJCVYe59J+6szRwPcgUUkyaSUfNoIgnehP0Fia7ATQUmW7uR4LJZs/azIV0IlozWrGxHoJjL4D4sYRvaDjfzdtmmkIvgBf5fLk7OlLGXo1gzNuqQBTrIUVosJnDvAU15uwEtWfEETYjfb/y1hA/Euc5WmJSAZ1LdeihebQlVN4tk3E7/KuAWwiAVhhIiplY6w6LkpKJOTVop0EiUuqnxIo6AZs2B9G6z7sSvOA9k1e7U0Zgh1AxD9UWEyqCy5F1iUUvHHE8nSTBZ+thurke94VLqa9g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 03:29:37.1969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d77ac09-7cce-42b7-cc74-08d7ea5b3680
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3965
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

hwmgr->pm_en is initialized at hwmgr_hw_init.

during amdgpu_device_init, there is amdgpu_asic_reset that calls to
soc15_asic_reset (for V320 usecase, Vega10 asic), in which:
1) soc15_asic_reset_method calls to pp_get_asic_baco_capability (pm_en)
2) soc15_asic_baco_reset calls to pp_set_asic_baco_state (pm_en)

pm_en is used in the above two cases while it has not yet been initialized

So avoid using pm_en in the above two functions for V320 passthrough.

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 71b843f542d8..fc31499c2e5c 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1438,7 +1438,8 @@ static int pp_get_asic_baco_capability(void *handle, bool *cap)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_capability)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->get_asic_baco_capability)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
@@ -1472,7 +1473,8 @@ static int pp_set_asic_baco_state(void *handle, int state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->set_asic_baco_state)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->set_asic_baco_state)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
