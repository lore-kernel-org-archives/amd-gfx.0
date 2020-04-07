Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F89C2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 06:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCD42051A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 06:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kMh7W1Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCD42051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 528B26E2EF;
	Tue,  7 Apr 2020 06:10:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770045.outbound.protection.outlook.com [40.107.77.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B326E2EF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 06:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jT5wGHxz+sKLA5TP8STZfT9kKUmyTdtt3yr0vah6zyTcnnY7gCTSLGme4lK3R4ZhLaPr+h2kvJFOYrOf32/2SgcrbbG+lOEb4dLF+1K95tDADy8TG3GqnfbOvQEnNu7pluqJ5CNXWtxSbpdp9aIO37zb/VEo2GnlbSO1nCAERLyFqREBKSInuXVOgMuYf41a1iNYqrPjZc+sm1iPTOuouBhxLpEfPVxF4iyIqPQNYw7vnGCHH1r68EwKyAxDFM654Nl9sd77kNrh/lptmtaMbaUI8FZqlwrB/VW6p6cXUufUKhihbBKoEmLLiXvRbKw0TDgl3Zzy+SqxNWxRzsihMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3hWuRKXciQ3Yc2TiUxxT+9EjQaBp+lruAjtsNdWOos=;
 b=W1BwjsdI+BMWebB4kglFVxdXphGOxU8ClCQqhXJqd4JUhgaHI34oS1ar0vLZubHsUs4Qdx8Yx9SacfNKYdtCqXL+Hl7nHk0NX72pbFz5QbgyBd6U64EIi2h3k+zd9u01ChIfi2FHhg0fBlgASYeJGRJOPYpaUwkwQUJHsg5Zi6QhQXH+lRtd24tINGka/PaNgWjTl+W+49aOg7ZIK7Xt+xW/EW3aNPuYvCfX0lQFsM4wUsZ0gN2T4sm8AjUeeYtKVF9y+uYQSCxREKmQ9Uu5x8ytqA6LRhrBvQ5qHKAhZCnzyAU2a/t657XepQPrgJupxE0zH/3LI+ErnK3OhnBeuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3hWuRKXciQ3Yc2TiUxxT+9EjQaBp+lruAjtsNdWOos=;
 b=kMh7W1Xq8YQwO8Xv/TNMZvguVfsJqG0RK7HLBpSvohMkFNuPZlEUT76Z1+LvKffJ4l2IXig4TuGCM138jbhOAXpi5muNISO4eBOF0P4hPIKDQv8JPK0aFDJEjwy1HZp/6+8SYkhKqc+KUoliMQ+uCd+d+fT6limVBYv/eJfWdoI=
Received: from DM6PR06CA0070.namprd06.prod.outlook.com (2603:10b6:5:54::47) by
 BL0PR12MB2529.namprd12.prod.outlook.com (2603:10b6:207:4e::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Tue, 7 Apr 2020 06:10:47 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::9c) by DM6PR06CA0070.outlook.office365.com
 (2603:10b6:5:54::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Tue, 7 Apr 2020 06:10:47 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 06:10:47 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 01:10:46 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Apr 2020 01:10:45 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Date: Tue, 7 Apr 2020 14:10:43 +0800
Message-ID: <1586239843-30435-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(428003)(46966005)(36756003)(82740400003)(426003)(47076004)(5660300002)(2616005)(8936002)(186003)(70206006)(26005)(316002)(336012)(6916009)(70586007)(356004)(478600001)(86362001)(8676002)(4744005)(7696005)(4326008)(81156014)(81166006)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f1b473-452f-4913-fc2a-08d7daba69ec
X-MS-TrafficTypeDiagnostic: BL0PR12MB2529:
X-Microsoft-Antispam-PRVS: <BL0PR12MB25296400926B7B17A3564205BBC30@BL0PR12MB2529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 036614DD9C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlyP15YAWNGpGTU55Gy9sQGePIN/KQxq1WKWQEcmZ+l7vsXAwPXfRe+do15TIOYMqVub5YQUb1BTwnuozajoQKH4Jo/pr4WTKTxrUhQOocIbibP4iBZD68TeicGK5WZzM1HBPjyr824ax6othdhtRrpx8FsnV1usekRCIEe5un81SkQSAgzivh142qBmZorpCnMpz6Bo7/j5Wi1b8a3FC607NDhl9VXk0JVBIWnFElfeNAdnNLQurEA/527Pd27y4m1OeJc3zVbAdWPLXup+PrQI9DQMA4+BLL4MLHa9Un/W6/K7HURv5A2kZ3R/y7hISHIyfwrkjJlUDr7Zy6WDTKzvXPjOkal+etgGTDC+2zi71o2EsAeuDnnqrVvQL98pJuUMSMh5Y5/1r0I+lPFzjlKP5DVktyJ0EI7AeQFDiseP1vPssFAs3/V23u3LHjVAcIK5BgBF8wszE3XH2kTTk/dal5+lZ9oNX6/zIc+JvW6BCS919qhLWeZCcC/IaicKA6d6UITFUtaYlrD6S9qcBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 06:10:47.1275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f1b473-452f-4913-fc2a-08d7daba69ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2529
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kfd_pre_reset will free mem_objs allocated by kfd_gtt_sa_allocate

Without this change, sriov tdr code path will never free those
allocated memories and get memory leak.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d94eff9..2e1f955 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3852,6 +3852,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	amdgpu_amdkfd_pre_reset(adev);
+
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
