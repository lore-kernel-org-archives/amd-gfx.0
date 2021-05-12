Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2FDC43619
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E444C61420
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E444C61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590446EC63;
	Wed, 12 May 2021 17:31:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4D36E7E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lows05wUEyiI+Y1DVocmo3ynCdYssEo8P3CFHpbrfLI616AenWVSSgUgxqC9ETAFLoebybY2rAnFYlm8e3XPTF+WpsdcYwfxnEq/2Qmtl+8M4eEAhZofJrfc21UWTkzBeUtt2KR8bq83jwQDNBfUKxzhCm2FXMl6QZQwwC5xrSYXsE4WDs+r/FuD4BuDLFZyeCLC3g8/NJ9Y+bNThRKpzLhrz44ofVBrDM+/39uE52wdUrpuKjmVB4QgZgF3NhEmQjXBvB8deQyMcMSdya93dhGdjqzXsXvtCzB2yonZVRa8b7TpT5JE+Z0HShlJQZHY9sw9hhTlFbpyQbQpZGWw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPY18eJJWIYHMmG0Lh/WTjpfweBnLWwZLJ4ppSdB6s4=;
 b=T1PcHXp+MeP/CZ3aZjWmfUY2UO7yA0IQwmiiOA3QUl+8xT0KSy7tcRF8wWJ/Oyq0RxYFb/ilEQuD7GnGdzQTgiAxidAMyVr8H7dj7Y5ZEPQj37jXOPJY79lrHKXLOo5BGv65ehXANfqknrs2lZB4g/+s+WxQGcEzFbSmA6GR4YuTN1ZKr+1yfSpvkppfruNOfqfoSspAyKXJ1HytANic+NSzJPVMEJKoVFDdl8nMA7wWFm0w4FiSNIueT8HZv/tT0Q7RDdFRA88chE9hw+iyIEdxPO/RfE1KIMq2XQ3dzbf7+LAml4rvAkONN7/D3GY6s7Dgl5Pt6mm87MSVJF5WvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPY18eJJWIYHMmG0Lh/WTjpfweBnLWwZLJ4ppSdB6s4=;
 b=RUp5nMDlFAe1OzQ1mHtOyzoVT5XdBVWZCDFKCrUiDl3k2ro+mx7fay7i3yz24LSNQj+BuToZwNB2OO58dMCpc3NcZjN7PBDxBTZl0ifNZRWp9nit6S8DqHK02J4OlnXdxJZfju33YRENU2Q3VXdSXnG5n69e0R8GUhl3DjG6VJU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:15 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:15 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/49] drm/amd/amdgpu: add gmc support for beige_goby
Date: Wed, 12 May 2021 13:30:10 -0400
Message-Id: <20210512173053.2347842-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b323f38-bbf7-47bf-1e99-08d9156bbea7
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4915D426CE3FA8B5CE7FD578F7529@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11gUM9kcJ17RF9jAZr3GHOjctOc6ZmMI5vQH4uL79dWMxQQu0bP4A463rYizHiGpZ7Fi9UtKTQH/cHIScI5zaRLL1z4e9B1KGN1nfwXJrDifG5wiNVbyRS34dZJ0cuDWLmG1LNW0N/3yXb9swqCMAnnCCNeOMY6sWpTWAejdmapqgbo206merjd+gkJ3Yym/nmv5OUjOq/2yzBi4AhKXRHVZOSBmx6xSK7i4vxM3YbdSsMfqeanUd81kN9ubaPSNobrajUkEWGDic4WtPFX4OwX+YpYK8APr1kyDRFrg1enPVFq4JCzHCEGldVCVrfxllO0oS5DAapQSYzsi58foUN31ryaiMIjGuGLMcO6hKLS35SuJfi0ozjq14WDzWMqeiZLMPCYA2YJxgykI2yzsIG9R3rSylfdEfpKGj/KFtEIEPC6ukTBSc9aCK26SAYsRI+aEn6ZtxXQwwZvYcHrG2enBaN0L5VzXpHoJ003HHnGBSTw48uqwMEuVK3giItTif60WCesSJf7Iid6Dcz41vMKhoPnVXL/WtfyTJW++8Xp58Ibzu+lh4JxiC86b+jLnGdnbxrE/7l7ry9bUc5jXvmYPlRXWTXEA0VNHdmGYhJ5HETfq1V6GRfyutympcLXgvsAMWL+MrNCNM8XhWrvI/YFSGjsuQ4/nCvqITKcmsiH69h8HntIOL9n5dGBC4nnj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(8676002)(186003)(16526019)(8936002)(54906003)(6506007)(66556008)(478600001)(52116002)(6666004)(66476007)(38100700002)(6486002)(956004)(5660300002)(6512007)(26005)(36756003)(66946007)(6916009)(2616005)(86362001)(4326008)(1076003)(2906002)(316002)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mPKHOZgu6esdadTltW7UzKonpUbWweVbBnjI1SSk16tAs0W8vgSTCaV/Ked2?=
 =?us-ascii?Q?izydaB/K90svy8myxJ/tsWN9OQ61fWT7n7chpYdknsrtOZkCKn8ldR4oVgDT?=
 =?us-ascii?Q?XnK976Oju/Mu89odhFf/ppuYraCK+Q1MWgijoc9Ss77C6Ul3toZG2/lqU53G?=
 =?us-ascii?Q?r5tJIRF2ILIMdlvX+uVsAE2VajvcXN/0ARtBKDSbzjPxpXuzGFuNfNlnAnv9?=
 =?us-ascii?Q?sGD3r4dzH5ZEaI9RDTS/RaHua0yNdGiI0xpOTpMQ+QhPYH7VJoRQfVn7CDHA?=
 =?us-ascii?Q?aVUDHfjXrlbtS0ssyX+zHsWxA71zmVqmWjYAi84rU8wjGyHjf5lLBexmOd8l?=
 =?us-ascii?Q?/kzi2PhlfcF+HOeqb/Vl0yGmMR5v8HiBcwLJ7y94GXmF+p31augPRTzV4/5K?=
 =?us-ascii?Q?oesIB/IT/PWBO9AOGdOD9P/F87Kfsf21NSsZ+81a5vqMyUjJlPNz5UoTCiWk?=
 =?us-ascii?Q?e0CiZYSrelJKZ+vpK4jv2KrcDUFQuHgrIsU7qwZVDgardNOrmWBPsZB/LuYY?=
 =?us-ascii?Q?vfU8pxpxMI58t1zC85c5KcUFBhzd1hiIYypmGDm44S+WvDeivE57buM7Fiug?=
 =?us-ascii?Q?STcVq9M6rJMqMz9c7nWNjk8jRsnvRPT3J/eIZ+iYMVk4o1KqkDSJFIh2/sg1?=
 =?us-ascii?Q?F57gwcDgl6uveNfMrQHqc322bs2MPCbQVzSvt315ACmm6tsoDTRzTItYWQHt?=
 =?us-ascii?Q?OW2XXCGRR4cjBAERqWkV9wPc0YrrmGgL+FUyW3tJhToWZfjU2Iof1PjPcwfM?=
 =?us-ascii?Q?ZUilG0HObuCszwTkgFr8rFZcuZJJmO37NF1zHRVeXk4ouEp9wG82t3Y//PO+?=
 =?us-ascii?Q?eQl9svVN3kMxeN2xtD/nJLx0ix6MT67psIOCryqyYNLkMkOcb6+CATazpUE2?=
 =?us-ascii?Q?OJP90htqFCZUa9UHsGo+om6iJKFm3aYVO0kZg62L0wHr/NNxW58QgasuNQ4G?=
 =?us-ascii?Q?w8Se6KiKxUSe+n/9BNnFwW+K+OpjwGx+llMFE6Usq8ZaMLizx5ycuCLrl5BN?=
 =?us-ascii?Q?A2H4UpzK3L7xgySYzN1GOdjGDvLzSU6vbcBb+fxSz00saiFuvcbFswuWPPrq?=
 =?us-ascii?Q?sGBMojrPIq/mvZnaT9GX7eZ4m871yxTlcWkk4O/ZwDGivXuyV+mwwHH4GxP/?=
 =?us-ascii?Q?piRujZ19KExb0gF/pvZZD5qjAFrtgXoSm9mekADZjVl+351w8t8/3nq1gDum?=
 =?us-ascii?Q?ZdfBbwYfM4FQP9kAeNItH2mod/6Kmbl9rw6Yk9CGH/mfCP3EDWe+oyS8JJCL?=
 =?us-ascii?Q?bf3/P0qpOS04tt58j1dtuREumd99FuinFcYSlaLRG+NTeUlU/bWehNHbQlHb?=
 =?us-ascii?Q?Fn3D6zHZmd7iSSvloZTQWSkP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b323f38-bbf7-47bf-1e99-08d9156bbea7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:15.5078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kww84wpbrM2JjJ6YoRxVcQtYYTg7VWpy9rrR7apyTkJVBykFjKshFLgWFF8KtyCsnFbiwmjebRKTvkH2dIKDXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Same as dimgrey_cavefish

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 498b28a35f5b..cd28fcb247a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -796,6 +796,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		case CHIP_NAVY_FLOUNDER:
 		case CHIP_VANGOGH:
 		case CHIP_DIMGREY_CAVEFISH:
+		case CHIP_BEIGE_GOBY:
 		default:
 			adev->gmc.gart_size = 512ULL << 20;
 			break;
@@ -863,6 +864,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		adev->num_vmhubs = 2;
 		/*
 		 * To fulfill 4-level page support,
@@ -978,6 +980,7 @@ static void gmc_v10_0_init_golden_registers(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		break;
 	default:
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
