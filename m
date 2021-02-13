Return-Path: <SRS0=DGdK=HP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370D2C433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Feb 2021 16:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A9C60203
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Feb 2021 16:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A9C60203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9581B6E852;
	Sat, 13 Feb 2021 16:38:00 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690046.outbound.protection.outlook.com [40.107.69.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44006E852
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Feb 2021 16:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzH+3r3+aUS+VBWephvyjpWqTEsAvCVEwUh+dtCVE1hnhY5lGJ5GGKoUcAPfmVIBGSz7b1tgTGx1c0hsHg8qpuV94mJMM0+YpVszYix8ThfAzoqbPCTVijeBCpdGToHIKnwjxHmmdyR8uJOFd8sehzsKDF2QIWMS7+xP2HrS2xOYCvUNfdwINncQax+3gsnXtUF3lD62L4hBSTuvewlabrcEOMahSTLFDDuopZ5RKZ4r/G2jH2RdKsHswekWFqUaOevy06PG1EO2aS0zgDfikI16jjz1xGoppHx1A8dq2rBV+LUzwFHnlEGT84KgLgtcbZFa9PHWVVFOXpw1KQAzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEWKq8C6eJHDuf85LgeXexHCCZsiFcutz1ClB8xb0a4=;
 b=Xc6+KMD+ZtD+4uvDnGa4+gj0DWLSTNrkR4mnZ0UdQoECA4VKjIb4XqTykT9MXGPqiRX2+ouTC1dXdRAfUobfSMOkcfvAu2tQf9mEGEtu47Rdm4Emny6eEbepWojoF+V7/h13q1ZhxgSho1fVDrEWTFSTsPWRIFvaohmh7eGv6L4mDKcdpMLdWFvfeWjubyMy5M1IKYQD0+lmj0Jf1PEOHiXWsciE2AJu9isOkwLRPX8T4QHxw29bLHVDBiTfAVlM+yjV5ND992GcBc2Fn0Dna3tH6RmnUlxUmGPSh21qoitSK45GCbAiOV2HPj5dGvAvECliOdlT7MPpSCupTNUuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEWKq8C6eJHDuf85LgeXexHCCZsiFcutz1ClB8xb0a4=;
 b=sx5WP0QbBWhnShXtccNZDajhAeSORssmqNx4e2uMmbHnt4YjEtMK/G5SKDOWR61OjwucOoc8+D4D9L38kSQOq+5WH/3RzqOi0RF3CpNM+HURAhCmsA6H+FIJ5MvG7/6Yo6FjV6j+EuMOJcKxvgYzL1jr3qGYV9Rta6Z2ZjSAmUI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB2920.namprd12.prod.outlook.com (2603:10b6:a03:139::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sat, 13 Feb
 2021 16:37:57 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03%3]) with mapi id 15.20.3846.034; Sat, 13 Feb 2021
 16:37:57 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: clean-up unused variable
Date: Sat, 13 Feb 2021 22:07:25 +0530
Message-Id: <20210213163725.17202-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210213163725.17202-1-shashank.sharma@amd.com>
References: <20210213163725.17202-1-shashank.sharma@amd.com>
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: BM1PR0101CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::24) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shashanks-target.amd.com (165.204.158.249) by
 BM1PR0101CA0062.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Sat, 13 Feb 2021 16:37:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6337a4b8-3301-4314-e515-08d8d03db81d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2920:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2920B861B3CBB40067895E09F28A9@BYAPR12MB2920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rypJ//2az4tgUFWTiJ9j4Hf7PTD6Lz0ke+l6pUT5/xPjKhnYh9+i1Ds/L3NC55aoWGa6faHTsq34kvvwfImZePVH8Pog2nNmjMC5jA0mos9MC6uxtF3/K9pgsLNDNoSN4egHWBS8QsbrGpJ9GyusvbnmanikjuPFbi0e7R12WTqd/Ox/faydF//u5xCgSPTLiRS03OlfXPA11QHMDA35b8Dk6TzyB2ce8e2n51cUugBrvMwFflRyLkcxuGed2OECa4DjYWhdQovMlScZ3lk87aazv62QAfc4NXXSJwY8tkfZWkDB698i5O1pAT1b2L9T4Xn4QZJjufRlJ+Sp6LFr+flLST9v6HzbSSqqMM2pecEneeihScDgMw1zle2WlIk9H9jZbfpJ936zJev9bhtqnGO3t+JTwfliGeoTUbZHlwD18yM8Fq09fEBEmH3qdVR4zXNZl9ui4hlJi4CXXcA6T/q2LY1hsr5l/Tl7vDvvB1iYVVcxnIEYv5JKPIFXEXAFSMQL5LhdVyxgYXl+DOxMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(8676002)(186003)(26005)(1076003)(16526019)(316002)(956004)(2906002)(6666004)(2616005)(8936002)(7696005)(6916009)(5660300002)(44832011)(54906003)(4326008)(66556008)(36756003)(66476007)(6486002)(86362001)(478600001)(52116002)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N7l1aRPD7vrh7MI7I8Z4dQEyJh+ugO8J66wN1EfLOV1H+mpKlG+XP4qE69Si?=
 =?us-ascii?Q?Ie83dNYTde+4YuEnkrNVmlF+Y4FdBzKzmyC4G7StGWIGTHD33njZ7IZWrhs/?=
 =?us-ascii?Q?0KBbj4X5NIy7CqvtqLWa2XRhrSr1ZGQAr6Wi4N5jRbL8H1BKIYu2Xoz/Se2/?=
 =?us-ascii?Q?wO2PPd+MtCskIRIoiagtaTVwEUrqDkOQV3jKMzWbq49g5+j5wD1dTcSkfqh4?=
 =?us-ascii?Q?FGPaoKzWcXE5zSA3d4m8272iEwqAOo54MTRdfjskzMkJvgKXxM2TBkQcKiv2?=
 =?us-ascii?Q?xZPCqW5BvSI/bbnlNm2BkWhL0+zKTqZW3ah5PnMTi2k4pknwNVxB7kS57bxF?=
 =?us-ascii?Q?qRDU/cq5Fn4tD1qXwqoPLa9G1P2N/EnR5ezBDRuduDkukR1Rh7kccZm8OU2Y?=
 =?us-ascii?Q?hixy1s2MWI4PuZ03oPPtxMguT1OCL5K2yqlTSwr/hOfPg70XSNKw1Bx8SvKk?=
 =?us-ascii?Q?Q3CjdvCnZpTBz626wwEWqEPIougz2UwtIWaaJIWmeQS7AQByTzUgX/CtZOVc?=
 =?us-ascii?Q?L/o97pPg1rvTXxdXm/Xtw3DtZcVTTooz451qdXeeRaDnUVADVTTSekUhnsJD?=
 =?us-ascii?Q?0GGsurRdR9V96VXMO4dwHCoJ/hc39U47GcGTDqwe0dNAmcu1t5Z6rkkvFV2C?=
 =?us-ascii?Q?j9p4TBv3Y6+Zv2da1oK2iutUm4G+RIeYVrc+vv/FKcmudqT33Q4b3TepX/I5?=
 =?us-ascii?Q?I/3KA8iu5mxIZr4dy3Gh+SUE3v49zCZJTBZBQWT9hWrtBg+6cPn/aLUlPdZ5?=
 =?us-ascii?Q?4+XgHvrRXog8PL2PswPMRt3QGt1Q1bBke7lXRaF+j6jcG9pyom2+NFAjpTXi?=
 =?us-ascii?Q?jLCDSqP9e7Bdfz6yEVMERl3e906tmyBaD2yyyrqTdotq6DlMHsi9He+gEol0?=
 =?us-ascii?Q?JgLfCBOs673Jq6CdLCxpSOALloSJYfelxgVEJLRwjLAeGea/bB4gC2J6pf3G?=
 =?us-ascii?Q?Y+WCOI8NCNL8SneJyeuDPmdjFFSYir0asH080LA/lPjjUsRG6PPImlShrX8S?=
 =?us-ascii?Q?eKss0+Rr+wvQuhp91NeodpRWYtrtPawHjHBdociZM2EP1762d+JPh/t543H0?=
 =?us-ascii?Q?jnBQPA+6J/eJmAGigo8/yTK281S1WJaPAT9uY6hUI5aCUy4cKmULECaKcr8H?=
 =?us-ascii?Q?5cPUDAn4bzCL8NnKvwjZEWXjYkxOcQBp2gI6owAUyybErExmrEr/zw44X8Bh?=
 =?us-ascii?Q?eVceenKwFgk629bAkZPwz4HUf+1pmCV6Dc8TEtuP0cITFQECV7UHeH1ikDMP?=
 =?us-ascii?Q?Me8qWfywPqJO8pLSVKtFZJwaEYjVm9ya2Ex0vSMpMg9osZzpuif5uh6pxcw3?=
 =?us-ascii?Q?DMK6s2XIgtPmO0fR7Q5h75Sy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6337a4b8-3301-4314-e515-08d8d03db81d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 16:37:57.7442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPvi3oYCSWz/OoPjlIcj2zZ3qKtlIBDcW7IcEhk5lYDIPKAXZU8lZscTGm+eTLzAK2YWc/KsibPlxGv5W99HPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2920
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
Cc: Deucher Alexander <alexander.deucher@amd.com>,
 Koenig Christian <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Variable 'bp' seems to be unused residue from previous
logic, and is not required anymore.

Cc: Koenig Christian <christian.koenig@amd.com>
Cc: Deucher Alexander <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index db62f3c9d6a5..d3e4d6a06bbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -435,17 +435,9 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 	struct dma_resv *resv = dma_buf->resv;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_bo *bo;
-	struct amdgpu_bo_param bp;
 	struct drm_gem_object *gobj;
 	int ret;
 
-	memset(&bp, 0, sizeof(bp));
-	bp.size = dma_buf->size;
-	bp.byte_align = PAGE_SIZE;
-	bp.domain = AMDGPU_GEM_DOMAIN_CPU;
-	bp.flags = 0;
-	bp.type = ttm_bo_type_sg;
-	bp.resv = resv;
 	dma_resv_lock(resv, NULL);
 	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
 			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_CPU_GTT_USWC,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
