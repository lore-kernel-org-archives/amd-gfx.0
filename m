Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA65C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 06:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB9C2237B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 06:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p+pxYWSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB9C2237B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 057376F420;
	Tue, 20 Oct 2020 06:49:11 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690089.outbound.protection.outlook.com [40.107.69.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BCFD6F420
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 06:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvGqXmjJ0elLZtgunjSEUvloRuJ6u/tFGgXTSgidBElVhe9fh726rPtLYmri8VZI7VyODqfxrl67tRl471iNnBU1Mr6ArrT341zEDzClaUdCnjyzedkzSkjxUkGbJvjdMU/pyATZ8R6EBJFEJhi4FNL1etPOX5ywOELV1oipXQnP0STnavFysBmg6hz4TK+OacZESqltWKqjEa2bg5Jcc09ZIyCKzs6FT9e74enfp6x8wGqvvLeOMnquR9hfoHlklSNC4rsZRlkYIEOj21gC/ng/EWqjeSqP2DcU4GaBN3Bg4k5oPb2No6FxXo2TmqrVyppkmKNObR1G76GmFU8LxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7/liSdnpzyR/LZCuvrUV5ZoV0HUOnjaIpDwleWzLrQ=;
 b=Dv4WcRO+I0PBxOh7Q3gnmthIm4hE9Viyg9tfdvKYCTokBSIAeN9XvF7QkVDoe6PzZi3frIc4hBjRmCMAYrlS1eW9J8IXtvdTP2AyZmzY7BGUpensolkvaeqCvxG3vVPmFI/cYjqifH9sXrrZvyO/9VFACbnuqQNAuNF7mz/JvipHIUCdUmgkG4pDDApJqgbpRdDvewuWk59cwO1VfZxAuasaRYDBFwFpotSTDQD0RFEhOm5i8XrVjc6/FpE3jwN4D7xk8iFK1r3h7V5Zze2ISWaIPLHx0IctE8TXw7kCqIHMHJDJ2UhAhct7j+FG0CmCc6YWJf83wh0sEp+Wmh6z9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7/liSdnpzyR/LZCuvrUV5ZoV0HUOnjaIpDwleWzLrQ=;
 b=p+pxYWSn75D5eCetfmTWXGbU0RBMDEaqr1U48hNxVZjssSdhQAgt5ZojIzp1wIZ1GNloYo/p8dKl1AsFMBKJ5Ot9f7ONTFBPWHti3hMx3YdYA0vaK8/ZYOFoLx+3y8HuxHSg9ZWTHsXej0nCyXpzRAIumNpy+aoXivc8zMlL448=
Received: from BN6PR20CA0064.namprd20.prod.outlook.com (2603:10b6:404:151::26)
 by BN8PR12MB3570.namprd12.prod.outlook.com (2603:10b6:408:4a::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 20 Oct
 2020 06:49:06 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::5f) by BN6PR20CA0064.outlook.office365.com
 (2603:10b6:404:151::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 20 Oct 2020 06:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 06:49:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 20 Oct
 2020 01:49:05 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 20 Oct
 2020 01:49:05 -0500
Received: from yifan-AX370-Gaming-5.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 20 Oct 2020 01:49:04 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix the display corruption issue on Navi10
Date: Tue, 20 Oct 2020 14:48:46 +0800
Message-ID: <20201020064846.3155-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef803e2b-9f47-47f8-5940-08d874c43d1c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3570:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3570846553F0F2F04F570812C11F0@BN8PR12MB3570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ev2SX8OXl7NMKPN3moBAov0iF3cJ9Wbu8hUmFH3Sl0FTJgtso6WZKf69mOUi5HQiDU+jf+edJmCPNSe5sNA8py/VOoKPbjxbfhoLFf6i4CjmKKZXqm65vzHwkEHeux29b/Bo5su5bG68Tmw09ZxWC6jUlmFhMtrGstTBRFWrQ03DbRB5YNCrvYQGh2IbT3ghsVNkHtijrF6TH8k8/h7EyKfT0X6GrVp30SC6uNPntAyJ3iFo9FLODhCvAT7U6NuTclhQ9lymqNvo0gj6xvosjCNckX3FOvtt9x/cvnly/XvyJT0xPlOBkjwcZmlngW96hqHr33DXsKwRGPqb9lop4+Z/sYuN+Ap2XYJa4NBlU8BKbMuAO8JtMIYLv1iSTtCbbQwMMLjJHrcAzHGmyiEyjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966005)(5660300002)(70586007)(8676002)(2906002)(4326008)(356005)(82740400003)(8936002)(81166007)(82310400003)(47076004)(70206006)(186003)(478600001)(36756003)(26005)(83380400001)(54906003)(426003)(336012)(6916009)(6666004)(86362001)(316002)(2616005)(1076003)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 06:49:06.0175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef803e2b-9f47-47f8-5940-08d874c43d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3570
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
Cc: sunpeng.li@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Screen corruption on Navi10 card

[How]
Set system context in DCN only on Renoir and Cezanne

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3d534a4da20b..6855aad7f312 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1061,10 +1061,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
-	mmhub_read_system_context(adev, &pa_config);
+	if (adev->asic_type == CHIP_RENOIR) {
+		mmhub_read_system_context(adev, &pa_config);
 
-	// Call the DC init_memory func
-	dc_setup_system_context(adev->dm.dc, &pa_config);
+		// Call the DC init_memory func
+		dc_setup_system_context(adev->dm.dc, &pa_config);
+	}
 
 	adev->dm.freesync_module = mod_freesync_create(adev->dm.dc);
 	if (!adev->dm.freesync_module) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
