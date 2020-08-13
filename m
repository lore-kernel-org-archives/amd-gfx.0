Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902DC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 19:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CA820829
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 19:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TEzlRVbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CA820829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10DC6EA21;
	Thu, 13 Aug 2020 19:58:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A91CD6EA21
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 19:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYOLPZsDzfq95MMMLxXBsbGoRtvW3Si1DLd3XEnVzx2mnOu4/bsfzG+7heDY1WX/vOwAM2qp/B7t5Gwfl76Czuu4jwM0Ps9fcoBkke9nf74SuVJ6OcpB9XekeiveW4DGt5+ZzvvSHkXannhyauJKPiKtba/dOVoJ1Nl7x4Ij4jN/oRcCxayhI2IpzYzdcxP1Hgf9SheARVHT/wWrECyDh7FErhuIr7uOWfvcm+Oy8HnQXjNC2xuye7LckEPKPSIuuE6xGSODLuWXBd6EcyDi4QthxCDbQwBP3NMP8VRrliWPcRwLsmPi7R7s+2bpoO5WEpp/u3kUxyq62DJjsG4uQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UEZ3jEyL7rhSBrvrPrRd4XxqJQKUEO+Rg2BV668AvQ=;
 b=W6mxlHu5wvIXRXIygzBRvrhX364Qu7Lc9slVO+XvIcwjip/6aBhseHSF6DwmuUNm9uN5Y07ZKWzJwLrz0f5TcY41F5Ji1d4UWPZAdUqaBoaafq1A0f/6ToR7Ax9j0MsDchWPR8vF7stxdkbWlxc/1pFNSHD7D4vKhl9Z0IgwK0Czvn4HQ34PEUz6SwU+oG0vVOXgK8n13cpByQDgNzjdi/GzzFuUt3z9ye5XNS5vibdz0hSNXqtBYPQaFANn8ur628u1BWRsUJSgYwCUoBsVMqEWYqcG53l827PAggcjMdWNo0205cvbL++G2H8DUiInWu17IPh6zLpH726lmqLfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UEZ3jEyL7rhSBrvrPrRd4XxqJQKUEO+Rg2BV668AvQ=;
 b=TEzlRVbskowCa5PrhuR+8sA4N9w0oGdPhopL4luvDaMO1X9qKEQPAEUEAi+EXKUZr8PhTeeNPdbKcpQa8KKHPKfNwFLeCgnGKNW0UjW/dHjWDBRKd8QWFZiWWSX3CIRTm3lRdQ63fB+ufSNinwXhc7uv3exl03r6ElERTuZzvhw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3066.namprd12.prod.outlook.com (2603:10b6:5:11a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Thu, 13 Aug 2020 19:58:05 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::fdf2:2816:f580:6d01]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::fdf2:2816:f580:6d01%7]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 19:58:04 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn3.0: only SIENNA_CICHLID need specify instance
 for dec/enc
Date: Thu, 13 Aug 2020 15:57:47 -0400
Message-Id: <1597348667-17504-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::28) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 19:58:04 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8880d664-a8eb-4ffc-1536-08d83fc330f8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3066A05D2AEBD38CA3C12467E4430@DM6PR12MB3066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQ9vyC3OMlTkSxmYFW7GnC00q5jw6yL40kOAYxNZ/tH45pcb7DDz39Z+C9WKFH7OPCdpx96eInwt2QNJ4hapqt1NIMk2FPrgDcs6H9VpE4p/szOllO9tkMpBMrEP4LunoXp4zKwJVIFCy/V9kyBK0tKb8hhvhI51R/ED5iaUFoNd+iJ3hsjXlPEAEEylq4Bbqf2QUp0FDcRZiqKfzY4TQn/FumZw7CV6PwXEknVsioJNvdzuPtFgZ5XS69Gk2CZbAGjiAhaoEQ3aVXJeUlTMOkEm0aiSCAMBKjdOMcCC4nWve8Xs5/Ga3L/AWWKtzG/e+1xD6KQTv2B4wNfY050vaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(8676002)(8936002)(316002)(83380400001)(66946007)(26005)(5660300002)(2906002)(6666004)(66476007)(66556008)(478600001)(6916009)(86362001)(2616005)(7696005)(6486002)(16526019)(36756003)(186003)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pnxf7Fbi/x1u+wkYWTY4uGNj1MA+riz2TfRkyNb3X3URtsjEaF17FfH7u8O1/eO5+7Gk9P5eVe0AwDZSBPAm20FsU1FcZy+6NjDRdjKKBdraQ8NnXTXdzJqc9dg55llJmCKsUz0IuSO68xBAYlZ6f6v7SBvdNQiCMQB0ikBrListWh9j01Y9sRRk3RcJ8tWHwXE8qMjjoLlJh5kIilOrdBoZuF3OeyE0d7gbKwBRL6x+yImnrB74Q8VutA6+vP6uwLvSsnJLd0uV5XlJxvLm47PVA/leV9wT0QNStdNBp6j6Y+dJ0nn8rYvWy5iIfdZa1ZU25G2OgMrGZRq2gxjQqsRQtkTM0qQegVCDlTBu4h+0ytcVJCXI0O+AuBqQaFEgfTWz+eFQb46S4DgpKukmK/eh1KHZEppZrD1rZKGe4RmtXiz3yGTVxI7Re4FsI9ATZ87Kpzb+HpKF/nDKrAE9PrhXnpx/LLQ7k8WN3ed6fDGnBSxUMOYkTp5IgCZAGvMSjZgA2I3nWHL0C5fuuupdB3QPl5l0o+O4kUwZkblfsBUYsJqVOD+VErWnn9EERnPkpPhE0oQgoeU909vDFO5nLdA2iOQVo+5PuBUzbASwA9YEQWtPeng83UOvsOnONCqm/oiL76yrW79bklpsk+F2ww==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8880d664-a8eb-4ffc-1536-08d83fc330f8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 19:58:04.8440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Od7QnpfgNMVDPNmgDG+1s6glGCn2VJSuK27Q9vSsAX0q0sNaq2owKU1MW00SHypE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3066
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only SIENNA_CICHLID(VCN3) has 2 unsymmetrical instances, there're less
codecs on instance 1, we use 0 for decode and 1 for encode.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 63e5547..589d6cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -198,7 +198,7 @@ static int vcn_v3_0_sw_init(void *handle)
 		} else {
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
 		}
-		if (i != 0)
+		if (adev->asic_type == CHIP_SIENNA_CICHLID && i != 0)
 			ring->no_scheduler = true;
 		sprintf(ring->name, "vcn_dec_%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
@@ -222,7 +222,7 @@ static int vcn_v3_0_sw_init(void *handle)
 			} else {
 				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
 			}
-			if (i != 1)
+			if (adev->asic_type == CHIP_SIENNA_CICHLID && i != 1)
 				ring->no_scheduler = true;
 			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
