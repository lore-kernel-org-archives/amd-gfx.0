Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC95C47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336B8610C8
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336B8610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E440D6ED0F;
	Wed,  2 Jun 2021 16:49:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914E96ED15
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnOtsH4/wD0kaiY2eEZZIFwGo6b+PexydeDno8Yri21SL1+sT3mYxw12pRm8baZ3tud1cTEKjyDlA+Ht/VCLEklpf32Idgu+FMccBcD55VSDmqW56st8AlkHJGVtr9jDYPBI0Ex/1C4hyrLfCQegwK+kpNizDVohBnppcrvvX8XInZk/955M3c1mBd2BtZ01X6ipEy8q6vZFL1ZycLc5/vhu7e8yT89+PKK2OyXjp3P4SnxLXnM2FqyrtzT8q/u4tYMcsZ4v1PIZ8JsGNiKpLOrxwr8wLfsanwg0xjr+cgGsLFgJBGg4G4XnimFW1PrPMOpD9BBgUfDoZU6JtxIKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQb83tm0hRPe2Qr6HLblf54HZv6sCWTjvpv1HF5iFGc=;
 b=Tsn/Bx2WtcHTf81pYCWV0C35ftCOGeCcrBHOq+Ljn83yDg6AynwEqez5BUaYU86QDrsbEKEvPozl5IyGhu+eL+5iqECqZtSpcBzS1foZi6JQ2fd4kvKqAgUjyPFJwpuotU6aD3dI94GKE56tdAsBVteKmVlaC4c9Lf+izgaDFbEOOu2b/2XcLokFdxnOWSLM9hq8jPRPNJwVq0qIknAm0NuJ93Xuar8Op1XO5O5HDbN4WgNd91gVI3mIP7nYoak9GYe3csFu61QBpWXpTFOt99+YcnmSWBbzle0rv8nM6JsLlsIivOfrsV7bY+jQGEtb3Cji1o/nT/zUfglU3OaHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQb83tm0hRPe2Qr6HLblf54HZv6sCWTjvpv1HF5iFGc=;
 b=PXprM5gmM2yahxgnU7KSXizde807O2tnJahzBukQRARQrcyamBjvgZM2md125weTkT4JO27MkpoBwhhNrHLtSijJHCp2Xam/3QhgldKj5Dd2A5GaI89ZVlzjNEoQLTQzzf4i+cyoXbmu9Css4HevFanHZs9j9ZjCqVibXzm56Io=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/89] drm/amdgpu: add yellow carp support for ih block
Date: Wed,  2 Jun 2021 12:47:46 -0400
Message-Id: <20210602164908.2848791-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6f7a2fc-2eea-4d35-2eec-08d925e66582
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB406377F4DB9661C444738B07F73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSoEYIQcP4KOp+J7WaSJXfGrdABAOHSftyNzljrHhrLYoFBfzu0p7zKneclXcgx9qWIJAqGseGt0KcbZ8zvkG8L9Sz3JFiR79HCnvSvAL3Ilh1jDOOZPnvVpyKSjyioH/oYG9yTfcV1m7x1hOYEcwE2IB12MpqzbuYdjQR3Zb5DmOihjcI9a4D/fG2xtOBEZDEzWDkFgff+pgWelHd++Gs9i3xYZCill2ZkLmeyT7kqk5v7TaRoPKJo0iPIx2O23plhKnyuuWFnEiy2DnHDIUNrCSb/ITPNjSNDy0BStgt7yyIgyL9HV2/Fqe2usDqhF0rWcwXUqlOg0Et2eT+xWpFwxRvn45WNDr21+Eu9fwYQgGkr21UOut0g8snOYCbJlZcNnNtVIekun1X5wVDXQQpzPOCrEuZGnKw8Ew59c4tku/LeulK1h5kIuAqjFlp00JY2KyJNhIgSZCS2MESXTEQrNzEMJDBOtiSPCfVTSnEB/kKeS5w6GpUlZwZvnxX+CrWilDF4oPgzNxWILYz84BFljJQTlnDk6TYh7cq4lkeWD7SbsWxGtMjBy7pa3/y1oGn1U71GET+BH3y3VLs1tyzdqA7rfLlgABdyDFgMHmbeYWoF9DyUPGU6eetvRrTVJlKlQ0xNKEX2Txlg8KE6DTdP2eT1eHCZz0ZVUuVkSp9bUhVSTKBrLrOqaEP7KST+d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(4744005)(83380400001)(66946007)(26005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?X5jUug0+94fxQDdnYzkZmIiXQoBRSCN2dpp+QeN+7RQcYDadC7/Zhb7kk65F?=
 =?us-ascii?Q?6sj6BIzFU1HSyUDZNYzoofRXmSRbhM3c2paxRbLB5UiJUeVBFTlKDIMcIsWD?=
 =?us-ascii?Q?LQYz2MJ2WiTIB5u24CujrbLyC7m6F0GknQgjgCxViJyoD14FDsenJByfXiJD?=
 =?us-ascii?Q?/JOd/NhaSOaqTj8x8W8uNUl/vzzj1duDNhlO8BSqZhar/Ep2Ict2t/NrxbL/?=
 =?us-ascii?Q?vgldcGVCLMc8ivfSy1h2tgysxUMUStkk7lIWm1mFwHVY8nLfnIwWMJykXl/N?=
 =?us-ascii?Q?FBUtz4X1WdGnkN93QeirJ2IarTbEdtPIii+TWpsSg6sCz55seW72ZRSR1If9?=
 =?us-ascii?Q?WmvuuTnVktj3NsKLRUDt2gD3nE1g5ybnzMjjR/EDjSJDCr2f5qVamDEGNtm6?=
 =?us-ascii?Q?f0HsIEyFCc9MR+QG79c6ChGYjyBJr0KLvtfkpEk2mKMXa2T1xgjtqSNS2oMo?=
 =?us-ascii?Q?6RpdxbIBxtpf2LQ2xCTqlEgpyeaa6P8eXkIT6jroLPgYbmeX/j+7I4TjmFaQ?=
 =?us-ascii?Q?94HYMvqLKZcjkD6Q32LLzCwBofznqc6Q8pkPkzHYI8T+TCfVA86WBwxDoggN?=
 =?us-ascii?Q?2lPeXiEUKPuifmU3AxuhOStGhSdKjZ4TCEzUYBInnY4+RK+93wbJJA+2uSvW?=
 =?us-ascii?Q?WXSeM+1da2hnB84t2tDpgkyajRO5r5e+yrgbhJ4B0NNBWjLeMIU9nnlQuWe7?=
 =?us-ascii?Q?YikAe5Y+jcE0HV7tx8AEJk6TZcupMUbLlqUpHUJlwBi98pGV1OG0qxsM4oq/?=
 =?us-ascii?Q?Kv8E8e0J6x6FhFy79Rq7Ab/EpU5U5KWsDU+GrA9cKOglfZar+Hf1FbdjwGZw?=
 =?us-ascii?Q?HKud6qSbIV7k2O1ZdPSqsNvCDoehUFylIrIwOYl3BhaIMTd5eFuw/v5I3oqu?=
 =?us-ascii?Q?3MwHE12xzUWRka9Wgo/12rPY2ieqHVuk8MW1XYlDJXZD5SXy2Ygk71cV0SAP?=
 =?us-ascii?Q?zWqVDcrX0q8si9mGML2iYmqwkrZvnu4erbxSSXi78H5MN5yrjTk/sDuQ55k/?=
 =?us-ascii?Q?WdStqgLM8fnlTGTT7u4scJ739TlomAKOTEEgqUmEnb/4vlK48asdqvvSIk3R?=
 =?us-ascii?Q?qXJjoxgv1jGIP19UjwyYlz1BaYA+S+R+xFI3r0+AuziA2KtnF4+viagv7IzX?=
 =?us-ascii?Q?bHZeR6TQ9XFV6fp1U4+/OpAZZbCjwliOXdpFHBRDlGb1JV191SoaiPUYREMi?=
 =?us-ascii?Q?mbb8p+RyRaj00uCsVsjvuxNBcCYlxfuwdCZ1kxdfKPB2L1Pqe1bj4RsCuSa5?=
 =?us-ascii?Q?mU+Jv4s6ebGrQk1gNCmqvADz7wIylOH6oyuTdf2lzd1SQ8VkWcS31l9c6q/B?=
 =?us-ascii?Q?gXsMU6JHMlEejX6nbmJJGGoH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f7a2fc-2eea-4d35-2eec-08d925e66582
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:32.7074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gy3v9LsR9WJEWBjJ8I3fNahc+VY+nm8FyfgP7gYLodx/dp3MRyeidsYOaln4QwfxIwzaTUX4vgk0GS2My1orDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch adds the support for yellow carp ih block.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 17ed61a34fbf..eac564e8dd52 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -328,6 +328,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 			case CHIP_VANGOGH:
 			case CHIP_DIMGREY_CAVEFISH:
 			case CHIP_BEIGE_GOBY:
+			case CHIP_YELLOW_CARP:
 				ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_Sienna_Cichlid);
 				ih_chicken = REG_SET_FIELD(ih_chicken,
 						IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
