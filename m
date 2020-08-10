Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8EBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 03:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC96B206E9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 03:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C/frqmWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC96B206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FA96E030;
	Mon, 10 Aug 2020 03:59:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A49F96E030
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 03:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dClZN9s8J78uGCPIZel01XHr3mQi82ZvXcpkmTbXh/NaqunIMB1qEi42zU/gEdBshBTXaPKig7V6qyRHJzQsEuC75xPqXklJlQNFQVmMRhRUrRi+j14OadeTT6z5Jg8aDwNBziQrqox8E0j5xeftik6Q8fcr+uFQezJ06fbha3871GgGnwHKNHDNkxegMCuIArYLnP9/husx7dfbLMSi70V3yFQ709JYMfkovu72Be9M3AL7K720LTusc55FV2z+WlRxG58W6CuOnh1JOX8YXcOjeuqxAEi2BH2mKFVplJ8dyy0qtwT/wCee9/eG7+JOGuuWz3g+sxxuIq9OCvnrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4ub0zTL+SjJ+mBdlNFK6/bBLEu1HhepufW/G/ndo2I=;
 b=PZyVN0xU6fcsbCtns7gLdgbwbr+zLVaJN66lU54UeQKWsJ/qsiAtRnn4LiWrH6lGOURdj743Om3XtXMzbqp+qGZXLc/AyZI3k5gxyQnWr4/Fdzh+u4DLI3/Eqm/7B/Ow3Wrh2XJy1F5oMsAnuyez1FWnXe7wx/7M5pbDa8Slo+jcyARIGrQQVv+Fz5KIHc0qyaKXXGcLz3JumZpdO0LCvfylCvGjNNRypNL651qIx/Vnjj+1bBgpQqlPeV+GhQsNNFNtuDyhW6PpOReHYYT8+Sl2mYUBN/l1Ds9kvZZhcEHMTmSE/aTMyVmY0HoVNGB/em8kGtNJ4AcMluNo+4Gfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4ub0zTL+SjJ+mBdlNFK6/bBLEu1HhepufW/G/ndo2I=;
 b=C/frqmWZB/8VyBJhhZTOazysJRALtyEV2ldFfEa+Uw/eortmabcHADFMKac+KpPCkWCjhuygdvK6MG7m/awOrzLjdoS3lHNeDNawXvSHHcc2ijTWGQkCumIRcOzOmc2bgTNHO6HdLk4m0czoyorM2rwKHnnjIkpSNLflKFz6fq0=
Received: from CO2PR05CA0099.namprd05.prod.outlook.com (2603:10b6:104:1::25)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 03:59:31 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::21) by CO2PR05CA0099.outlook.office365.com
 (2603:10b6:104:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.5 via Frontend
 Transport; Mon, 10 Aug 2020 03:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Mon, 10 Aug 2020 03:59:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 9 Aug 2020
 22:59:30 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 9 Aug 2020
 22:59:30 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 9 Aug 2020 22:59:29 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix reload KMD hang on GFX10 KIQ
Date: Mon, 10 Aug 2020 11:59:27 +0800
Message-ID: <1597031967-25513-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94cc2b3b-116c-42d2-a21f-08d83ce1c911
X-MS-TrafficTypeDiagnostic: CH2PR12MB4328:
X-Microsoft-Antispam-PRVS: <CH2PR12MB43289E015E66247A5E60B4DF84440@CH2PR12MB4328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCgqb0siZEGjzdVqJDsMzVagUvS1bL0mVQCgsZ4lOGsqiiXmUcc9CgWqB7fApZ4ggWGQajDInNq0w9nuCtldUXcZOUHSsxhGXwx6oHBNiupjb5KdER099iZv3mnRP/5ORdAVOG0FHdLSTmV+sWCTqIgDmrZlhkiMbs9AsA3Kawm4+inNh+BbguUqU+zhsTt6k0LEm1JMwKPWNvO5XoUf5hGPSD91YpeB++Om2y7s+ZY4frJ2zP9sjujxeJ/uCOE9PqMC7wbZpexM17/017WpAHk7Cyo0+/z+CEGFCOPEbjWjjmmS951WRTQKegFiyy4k1FsTLm1Qppb36VDgcRmRcICyxqsC4MpCdYIlblPB1RRfHwzRaXnUWX5scSs1nQqPjst52pdUTXikchgzlM4hSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966005)(6916009)(186003)(316002)(81166007)(336012)(478600001)(47076004)(70206006)(2906002)(82740400003)(5660300002)(8936002)(356005)(2616005)(70586007)(426003)(83380400001)(36756003)(82310400002)(4326008)(26005)(7696005)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 03:59:30.9880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cc2b3b-116c-42d2-a21f-08d83ce1c911
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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

GFX10 KIQ will hang if we try below steps:
modprobe amdgpu
rmmod amdgpu
modprobe amdgpu sched_hw_submission=4

Due to KIQ is always living there even after KMD unloaded
thus when doing the realod KIQ will crash upon its register
being programed by different values with the previous loading
(the config like HQD addr, ring size, is easily changed if we alter
the sched_hw_submission)

the fix is we must inactive KIQ first before touching any
of its registgers

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 622f442..0702c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6435,6 +6435,10 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 	struct v10_compute_mqd *mqd = ring->mqd_ptr;
 	int j;
 
+	/* inactivate the queue */
+	if (amdgpu_sriov_vf(adev))
+		WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
+
 	/* disable wptr polling */
 	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
