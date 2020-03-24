Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CE6C41621
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 10:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A51E20786
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 10:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nGcvNVkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A51E20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFFB08987C;
	Tue, 24 Mar 2020 10:59:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BAA28977A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 10:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1Q172ypjJKdmD1ca7wypi5syng5FEeOhb8vwIkhUXrf/ymdncaAq7TxZ83LRv5pQ4bcnNN1/P7lnA8cRpzK7gD7Nvt2g55DQZwprgpJnsor6gLSvWPJRYFt/dF2lC0yfSdI9c+FTbaRnyLOKaZ0LBs0ksk9qbQnYR8KGdI+J0kWk/ktXKrl6Jce6WirUXunor+qlg28HLkaByFHz4NuzxTBLPiLVojA60wGVi8BZtNLdAco87ad3h9t2BCw7zHT0ZbaFLcwAlQv9a4CSlanxX8hhcErNx8SUquNiO0vXNcvhqFqytr9p5wFBpdioo8oEmmChyIqxacogUfyZhiu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIE5v8DsbDVds3oqsHx9Y8cxwITztwPosDZ/AmL3Hs8=;
 b=Q+03zzrvA0Abhz1j2Sw26nGt5gp/5MQFb2g5szZmHg5g4t8kuRcglC5g1MyyMupGIthuQHiHJNLDkfzC38doH6wrDWnMKVOWR/JIUop0vdNn+jxoyeWtBNwsoDIyBN7g854NMcQ1faoehrTtoqoy6di+1XZKZFICb3mcJr5Oto1UYSB86g01zunb/uZtLD5nQsdvW93aFKcPHbMG6CdbtOpu6ZJ97crO/LTcWDJaM4KQFlxzuaORuX+YMa592YyFRjztRBLoCTGsN0rMBZRnGI4R8pb3gjLP27YPx23MEwLCKfVTlH+LOw7fmWNBuUMm+4neRR4hvsrldm6I15MJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIE5v8DsbDVds3oqsHx9Y8cxwITztwPosDZ/AmL3Hs8=;
 b=nGcvNVkBmzzupUy3TCY6Q3cTr+EQo1Vr/rR99yqgmcgwfblrqzFHXG5FHPjLCj3obZuJO2r+voJ31LwmlGbloYPnrv9QYM5T4CoKt47Bt+zlZuRfvqfLFqjBUsuXtMFejZlNFfcGH9ZfivnzbfxPGWa86dxR53gUhtazSP8SDBQ=
Received: from MWHPR14CA0013.namprd14.prod.outlook.com (2603:10b6:300:ae::23)
 by MN2PR12MB3469.namprd12.prod.outlook.com (2603:10b6:208:ca::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 24 Mar
 2020 10:59:00 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::47) by MWHPR14CA0013.outlook.office365.com
 (2603:10b6:300:ae::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Tue, 24 Mar 2020 10:59:00 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Tue, 24 Mar 2020 10:58:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 05:58:58 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 05:58:58 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 05:58:57 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: amends feature bits for MM bandwidth mgr
Date: Tue, 24 Mar 2020 18:58:52 +0800
Message-ID: <1585047533-10966-3-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585047533-10966-1-git-send-email-Monk.Liu@amd.com>
References: <1585047533-10966-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(428003)(46966005)(426003)(336012)(70206006)(4744005)(70586007)(86362001)(8676002)(47076004)(81166006)(36756003)(8936002)(2616005)(2906002)(81156014)(6916009)(4326008)(356004)(7696005)(6666004)(316002)(26005)(478600001)(5660300002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3469; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36b11424-e7f5-432a-6d8f-08d7cfe25b48
X-MS-TrafficTypeDiagnostic: MN2PR12MB3469:
X-Microsoft-Antispam-PRVS: <MN2PR12MB34699C224496003DBD780DE284F10@MN2PR12MB3469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:166;
X-Forefront-PRVS: 03524FBD26
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWCgQuW2cVChZ5su9G81tigaTBUUGGbdPG0JYqubmuMrT1A6e0e3xeIi+6SV/LILvrVLxLbveVUz5WkI432OED+MSmT6SIYKgtqgTjB6X9UevOxbLvZpm6K/dQexM7m3v4QiPLOPpGWSynNohw1UaeoGpu+rclOGJxnpKBAH8M7dP0kTdPQD4iM7jLTdLGkr+4GC17L2vWsQfztdQQye3Zl3TkbiL+WHbqI0h+ovYJwthge7wHJInHbCL3gPdWYke+toXcun5C5aW35lomp/X1gz0ucggV7ALygPf8ji1YN5BfYCwPgnkD0IidVVQHDXA7fWpSPU8tzxdnkfmQca46PmIc1DhlLC9qHEUFuGLAHkhYXn26GK+eHwfpurWHisSB82FWqWBWjmhNITWUQlYTfm9VaJoOoHygLQhg7/z1pnewdM30wrdawJBKchIFVZxVh0yIZHV1DhnOBWUkk6bVrS8CzEGUgCTNzOeysBOtjSreAqccs2SgVlFN2RA3DnDVf4K1XwBwD1gdRm8NHrhg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 10:58:59.5517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b11424-e7f5-432a-6d8f-08d7cfe25b48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3469
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

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f0128f7..0a95b13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -83,6 +83,8 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_GIM_LOAD_UCODES   = 0x2,
 	/* VRAM LOST by GIM */
 	AMDGIM_FEATURE_GIM_FLR_VRAMLOST = 0x4,
+	/* MM bandwidth */
+	AMDGIM_FEATURE_GIM_MM_BW_MGR = 0x8,
 	/* PP ONE VF MODE in GIM */
 	AMDGIM_FEATURE_PP_ONE_VF = (1 << 4),
 };
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
