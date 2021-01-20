Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D7DC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 17:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431CA23358
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 17:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431CA23358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02716E434;
	Wed, 20 Jan 2021 17:23:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779306E32F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 17:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAnjaJ9F/KdWripObbRd902jOnxtvDFheeb+vygHT7X3Y3XFLOXEI3F1VwmJTegXA4X4MDXSGNKIejApgNhjAAADRyK61XRubHZ5mBCjSXL0t8lZHIHL0CGkl+066y8wFEADNR7rqQ/SgFXIcw0c4ihFc6JD5slQs4nnG0/F8IUGQZXV2vAFiP1/OCt4m2SYPoKeH5kQJ3/1mU2LrvwIZ8Pw6puCNNb2JuCkr1wz94k4xeON3TZyBkYOFmoTFRI+8HiQLhKXmUFv/lhrQpj+UgvoSWPuKfPF2qjyYEtJtejd5ECTG0vXAIoQOlJ1ExkWqPBVWXHtTW9hNWmmI6a3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbYYaljoPlf4sK4/cSK+sobm+BNr81Vpwosa18PVI0I=;
 b=DwOM4CWOYd9D+WXEEPRxuCVx3Xi5BDZT2Stko99IHAYNYVA5GvuzwMfq5ifP9xC3UPtXBcs0f9V/z4L8w+5UOS7WK1chfa6fct5k+qot8+qmCiq9AwtJIT2urUZPhTMmc9yPBnzdzCV5sy/lkOVV0UUbNXa4GD+GrMoQOa5cOdLz4eFcXwMB/gtzrcTBHgkR0rXFVyFYGtSTuy/8qq+7wg06WdqnY8m7P2eN4PMG1L6mJ3bDY1cbO1ycaXPQrwbdhXIZXizfAtJ7eVVKveiRqaNk5ZFzN9l3l1cVzqqgZCZ4BudelA1mVFIcIkjxInd+SvBPr36G9foGAxq4wE89Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=canb.auug.org.au smtp.mailfrom=amd.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbYYaljoPlf4sK4/cSK+sobm+BNr81Vpwosa18PVI0I=;
 b=3TTXoJoQSxe38KHMrFFXykqJH9No18zc1eiNdqHIy/hQpOTMexRVQX8Om9IBDm8LWiPRt7GrCTxE3p6G8TRJgftAiKOHPaCOd8sm13ch69WFSZCFOkj+arP0Yo1SnckFNhVkdeAnGlxaLFe70igE90zZp+U9o/9PzUJ6YyFDEuw=
Received: from BN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:408:ee::25)
 by BN6PR12MB1219.namprd12.prod.outlook.com (2603:10b6:404:1c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Wed, 20 Jan
 2021 17:23:19 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::3) by BN0PR04CA0020.outlook.office365.com
 (2603:10b6:408:ee::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Wed, 20 Jan 2021 17:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; canb.auug.org.au; dkim=none (message
 not signed) header.d=none;canb.auug.org.au; dmarc=fail action=none
 header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 20 Jan 2021 17:23:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 20 Jan
 2021 11:23:18 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 20 Jan
 2021 11:23:17 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 20 Jan 2021 11:23:17 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix unused variable warning
Date: Wed, 20 Jan 2021 12:23:06 -0500
Message-ID: <20210120172306.276209-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1d89ca2-a253-4d45-cc84-08d8bd681424
X-MS-TrafficTypeDiagnostic: BN6PR12MB1219:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1219A7638F4E4C564A13757FF9A20@BN6PR12MB1219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:275;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+koUem9gl5rjefplbm1m29D8douAX/VkMVdR8iXe1tAHFLHTNHsGwazx324kKtvOHV9v5oIraFPXz94CXyKYb5Fbagg2+7jNNAcdIpJYxbO4qVzFHG8k6gm+KJmdqaM+7ToetcXYC4bb/KJcEDJnMuZbU9XZhbikHEDKHfggXRccal88m5gHsRtp2tGs/15I7tFICjVR4pU6dE7C6SBM9MHvqTqHTESUQRnOAr2N9uyf9qkFBkt8WszADl26Y+NS4Yky5Ip+5QphzhA37buTHO04xgCoJZHcfA2iokCI4JRKfgNmLXhc4BOLOU1xeZGWY7pLQohMVQcQaDYxIgNlT09H8oZ9h++Or2kA5556g7R+5mfN5ohvPD5koZ5TNGQtTO87qTsmHMElsiHiN8CIvC9vXKdDdEeFCaduEf2JXfZc0+tnMYkJaNRAAXgpaiKUQXyQ+NqouBk3r8MwBC56jfQzLiFED0I+dX2Z4nFkjOhba6MIx4m/DyoSq8yMv6m
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(54906003)(26005)(82740400003)(81166007)(316002)(7696005)(6636002)(70206006)(83380400001)(6666004)(186003)(5660300002)(4326008)(37006003)(478600001)(1076003)(356005)(70586007)(47076005)(6862004)(426003)(2906002)(86362001)(8676002)(336012)(82310400003)(36756003)(8936002)(2616005)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 17:23:18.4689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d89ca2-a253-4d45-cc84-08d8bd681424
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1219
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
Cc: sfr@canb.auug.org.au, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
The dm struct is only being used if DCN config is defined and this
causes a unused variable warning if DCN option is not set.

[How]
Remove the compile flag so the variable is used (there also seems to be
a duplicate guard due to a bad rebase) so remove the outer guard to fix
the warning.

Fixes this warning
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c: In function 'dm_set_vblank':
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:5380:33: warning: unused variable 'dm' [-Wunused-variable]

Fixes: e177af8a43da ("drm/amd/display: Fix deadlock during gpu reset v3")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 83ec92a69cba..7c188c8eaeb1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5472,7 +5472,6 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
 		return -EBUSY;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (amdgpu_in_reset(adev))
 		return 0;
 
@@ -5492,7 +5491,6 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 
 	mutex_unlock(&dm->dc_lock);
 
-#endif
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
