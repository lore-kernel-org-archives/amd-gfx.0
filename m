Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1754AC433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 19:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C862071B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 19:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I3VFQPxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C862071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36DD76E8F5;
	Tue,  1 Sep 2020 19:45:38 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750057.outbound.protection.outlook.com [40.107.75.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9686E8F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 19:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVSjtcfC3IfddAmDu7hnuxcrY2pzuYtKoDEnj050YPgCCv1ST95lPseOl2zmFUZ33r+kaY+pHYZ40r1YBxU5uH3PyRB7LLcu5RdV/e808ebDFMJUGJV4xQmc6GFFJ5nQw0/L/IREMshn5+zDnnc6a0qOAItdFLpT5DotHys4RLZFp/3iE3mqaUWHF7ik82PHtYytr83E4o/EeTlEKVW07jHdQWmfCfVl+Bb4UuGMzC9cF0UJpZN/K0uT3Ar4otynAy3/CW6ejwh9X7vNFnbMP77r8umC0hfjOVZD3TmhayqmAFqH4Z5kgcx4ZEfcF4Msi38HqHPuoqLMNFfSKR84EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCjz/+aCBsedAxcb5sJMx+e9Nmtix/xn+AdU+aey0nk=;
 b=FHlzF7YfIra6fripYmmJYPesacZiv+A7Gt22mXrU6UB+10YoG9F9Aheppzav8xWrhwfaRbH+qE/uNqyDEufakjuV4QSWbdc2+gq5P91j7GcGphyv+ffS9CVou3ZPZdwfK/+K2+ONasr3gpC3G6TZ/F6VZrPReGbe9fMmxpfC6JCv8jlWdyIcOeDCl/lad/jgvJvu6/Xpk31Mqs3snmhffy78pM7Mg2Zb1TVe+GkpzVYlwmypIYOJBgYPdZeIyyahNS2KkFRvVKaUwtKyflWvGQK4kYzNcDH+h7R/CgXqQ6lWBIH8YRoac2fC17Kb83EL/2VVY4Fc5FSSJJxmKwlZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCjz/+aCBsedAxcb5sJMx+e9Nmtix/xn+AdU+aey0nk=;
 b=I3VFQPxqOK/71Gh+Tjw/2+HWGvQLn4tGh8ljuFVaPPLoq5cEMETBhQUnZVqmBsGhRBRBiplBgxDePJbmVjYBlTUplGeaObPBAl61IZbzJyoPoT3NGYKoIQCOc55sTxDTeP2THjBqWz4YyaiIKxjzRCFdHcRD7L6EfJpgeRu8HrU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 19:45:35 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 19:45:35 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] Revert "drm/amdgpu: disable gpu-sched load balance for
 uvd"
Date: Tue,  1 Sep 2020 21:49:27 +0200
Message-Id: <20200901194928.22386-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: BN6PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:404:65::27) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN6PR17CA0017.namprd17.prod.outlook.com (2603:10b6:404:65::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 19:45:33 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67fa3d2b-4774-4f24-026f-08d84eaf97e1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0188:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01886C93FC7FB726B02BDE028B2E0@DM5PR1201MB0188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XoPToVT6g3M4nvHvFPIi/ytGvtPsNWnFV2ZHlRJVELyqPR0r6lt2YpKxH2NkOQGJuAkNkGDZSfI/vOslSRT91IjFgw/MJTq+sTMbKJin8h8Nbqw6pgI9BCH+sNbFRSdhBiIrulfdEEoTeSDV2wW4GLc3b0ME8oMvsGR4KTtkQIahJjW0B5L5VayY9fnw/v7PKt9I+vYqTwTVd/aaFKHJOVNhoDesv0yVKLJvkK4MOra53B0LvTsOqK6E2deV+xBLcns3GCmgO74XLScF4jJH4b5As5EPGGfWeGzLY4he8TSiCCcRY7qh64DjFWfR4wgkK8N66NRYFL/8na227sJYnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(4326008)(186003)(66946007)(16576012)(86362001)(478600001)(6486002)(66556008)(44832011)(6916009)(316002)(66476007)(2906002)(6666004)(83380400001)(5660300002)(26005)(52116002)(8936002)(4744005)(956004)(1076003)(2616005)(8676002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: F/h2wyhZhThHp/muPw1CaFMgExZv9m8r/CmbqTdfUwWfMgpNzpfVUfgI9Cez8lgmLAhrlPLFuCYlFh6YenBpbn+2B10L6NNu8znAAqAU41wbzm/kW5wMHPPDOevGCr0HpSQnhHS5Z0Z4hykehQhwP5ByvF0NT+3EuV/nP91SnhISZ77n150FTBc5a4xvo0ZpIFaGssJHXa/G8Dl/wAVbGQ+VW1RiEOGwp7Vjfq3T227F2HDL1h64SsVcoEnMIvi5pDK8yCWM2t69+eZEULSElbQT5AVfEm+i8LQ7qPDKvNbdXLEdEBM+ydnoaWg3ZBb4Msk6JmROUC1fiScnrkBDQDwJA2+GNR9lK9LCRFbFFgwGP7fTq26UqQgTpQCxJJj+APYNfFtEvBMcJfkeLveL8DrEJYtj6hv31s7z2CAtzP8IEDppx69DyqLT5AluoRlQWBJLw9O1SyNY/sH27QEJtetNrLlebz0y59wvXEjby7BfBQVisvMLJElmpQWR+3/Ugf4LyUGYqPTmkJeWmXUCggLKvABreJw6RC+tsJbm4u6kPgtbyPDg40941qKhwR1MFsuCP6pN+P3ZI0ZDidNq/gg0KrK9f7qST0axcOacWVwouL4MkNKdxkM540PR1RlGK9XRu7yuHoZqh8upBH8vcQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fa3d2b-4774-4f24-026f-08d84eaf97e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 19:45:35.1441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miuOqcSoW4nr7FRWD+79Lqi5dkAgXKL0X9sdTR2+wH+f8rd3hQzyionTtnrOdrPnzLiDuVJHxthICO1ueiqAkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0188
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
Cc: Tianci.Yin@amd.com, pmenzel+amd-gfx@molgen.mpg.de,
 Nirmoy Das <nirmoy.das@amd.com>, alexander.deucher@amd.com, Leo.Liu@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit e0300ed8820d19fe108006cf1b69fa26f0b4e3fc.

We should also disable load balance for AMDGPU_HW_IP_UVD_ENC jobs.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 7cd398d25498..59032c26fc82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -114,9 +114,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
 	num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 
-	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
-	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
-	    hw_ip == AMDGPU_HW_IP_UVD) {
+	if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
 		sched = drm_sched_pick_best(scheds, num_scheds);
 		scheds = &sched;
 		num_scheds = 1;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
