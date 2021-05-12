Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D08C43462
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C058261420
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C058261420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48ADA6E0C8;
	Wed, 12 May 2021 17:31:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A8D6E0B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgnHp73KopKcbw1QClzfSNqBUAIB+dwPIc+d6myswu17Qkd2oqBBu1NvA0GknTWIbgWyyyniCSNiCvgC88HdJzjyOHJtWJ5Zr5DuUooxnHdbTGOJ425BGImou7itwMQKRjFpl1ycCIxgZMwBPNULhZzrBfOSr7jo2AS9sPcMqCEfK/UHpQk6KmG30UxkglamvgAmYD7lccCulcLHBONThNSlL9kFtSO0fTH4hmf88hgTDjRtWSvmlGIgThDKbHp41N5I7yXwgFbSexg0XFmZIS+bLpqqc9MS5s7zJIY9xrf/cy0MzGGutekn2TJsHfGpv6JNJCvE8mkjPziC29nNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjNZyexsygDd2U2qEpn/4ebdtBbxlym7IMVGz19l/a4=;
 b=Kt+5vRC5VNgNlZaGzhi0UORf2K4ie8EjCJlA+/q3UGYmdyy1bNtECSqFbvXjLAwdEGIEhtEtSSMCZRrznsMI3b7DUD11cfYzXK3BA9DDVhp6YkkLS9fLHEveRZPCEjHzgrpeL5592SSZdP+ypA091msgtnyLM8qpenJf7h51kpJts8NoIEH6JG7pDKpiBrSDXDGFeSPq8FY8Kvx3IMCekyHePFCpQuTendvF/AJJF/zaF/KpgIKuPRelef6yn/BcjhjU8ku1nmaS+dHRcirQkv4xXWlwOzNN/YBhhgHHslS6lO6tw/IcGmaJJAlOucTygcJsUlQ1ZsHzYVhQL+GGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjNZyexsygDd2U2qEpn/4ebdtBbxlym7IMVGz19l/a4=;
 b=Z3NbmfwBA3/RmAQa/O6yQ6aWKY6QAEiZM8BMWjlowz1oPlHbzZ9YhH/eI0Nx5LvzvTh6/s28fQrR5/1W9KHf+HHN9ujiK0ycSVo0Jgzi1JvqHk65Y9nglE+udJtw2iD9seBNIjhSv75EtyKyTmqPrupBK+tYwKG2q8IT0g0ly/4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:14 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:14 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/49] drm/amd/amdgpu: set asic family and ip blocks for
 beige_goby
Date: Wed, 12 May 2021 13:30:08 -0400
Message-Id: <20210512173053.2347842-4-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 029842a8-0349-414c-a230-08d9156bbdda
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4915A3CD2AC9552542EB9C9EF7529@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HR7xI13ViqTFu48D/B5wxsl5AbHWAguIqVYJ9cHPGWq6sStqBVCIWijoyHKSNxz9fxnTFjpKII7gayPCcbiDz+iOOfBmFXWckGmjDJAaVkLVHNL6e6coiXABuRytZDA1gThnP86TjNe8QqKtnt9+RixtgOJCEtXCyXICkm+9isi6iDSZCzo5IFT2z2dCwwgsaix2Mt7UQsR7GI0cJBc+hC3JIWQVLY+b9TK+PJzo2/LTJkZFEmHixzul83gwUkBUgWGCgEwHfI3V5e9NZ/FMk5nGfU54h2VJHvb0994A5BR2YjzQHvb2yrLEm/qEmOzoP+gy6mqcty05MiC5iOymOT805Tw0xPtUsBVPVh7ZFjERdkXyWYkQcbiGPs+0K3gHO8XDqXK0iJ0TrRFM/6/YeNtJNsqxcFfjfhE+lJaFUoBVifmXWgm22z8EtBKniI8j5BaeItFEG7KgVh1K3+jjvxwKBda+rXnkQQ+FOuA1zA64OD+pwXeEEn5bOfuPOtFpZCPFcSBuc8OP3qw9/Kx67NsQVwJ9il/NcH+mxKdWj2K4tOW1gsybycoECEtK0jlh5gQB/yMXyvdPqN4E012ZrdhqUuhsUqkst2GVHnmg71M1AVlRKnLf6QKG1YBXYEA8TwtmPuRgG33A0tnpoufYUiTDfcQ8qAMvL8CGwgpYlTQpPjh6WJKG8hs+nfwNHWXh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(8676002)(186003)(16526019)(8936002)(54906003)(6506007)(66556008)(478600001)(52116002)(6666004)(66476007)(38100700002)(6486002)(4744005)(956004)(5660300002)(6512007)(26005)(36756003)(66946007)(6916009)(2616005)(86362001)(4326008)(1076003)(2906002)(316002)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?a5bnrXGiEOVVi0Ozg64tLlEuqjFTMNCKkbekKyscduxpiQNwo9MGDjWjCEQI?=
 =?us-ascii?Q?Z9sxQqTQIrnvnqHSeWvCUg2+qGUEdwWLYNDI9eTY45RxvYx7v5Nt4Kz5WfHw?=
 =?us-ascii?Q?VPEVA3bDc7MgBzBxhC9knc2u2ylDvOqvJVyibAbJD8AdARQvWOi0Dmje/cou?=
 =?us-ascii?Q?hyZYtTbDcQe6GiqdcVeBlB6IdcZBWaV1yMbRY5prNoSWOT7hpriYxlFhhxr7?=
 =?us-ascii?Q?ClvlztqfcfzjRQ7l4dBjMSGpafbFMK5KGARfTM3c5QqSOL4a4kvfQ1f5ODiu?=
 =?us-ascii?Q?t+0/cnXw4GPR0qNRgz/JbT3yhz4sBTUrdVT6xqSr5bPhmgGkurt90Jhmpmpx?=
 =?us-ascii?Q?EhWoKrsGjTEX6UlKbPD34doZ7ttQlzsjm5DjfhLVj32E5W7k8bJ0P79LtS6E?=
 =?us-ascii?Q?DW36oKUaXKgVjUFGgwPKJFBiUf5w4ZxDsHRkA3RUaXp+MGF+Svtjeflj8TnX?=
 =?us-ascii?Q?EQfehGJH127k+8Wo5zWMgY2GbO9tLcwzGetsz2PekGXjodyS19feFUtBlcrr?=
 =?us-ascii?Q?w6vTmCBl0BNSH/7kV+L2Jn2UgSX5GQT7mBenp8xi60+0oTWBIE9IkZLzzSYh?=
 =?us-ascii?Q?sBCtdypoSreCF/3l713VzsuL4sLJaKk3uI4Y7EAwFp/2YS6E7mqiX/aBmIvo?=
 =?us-ascii?Q?A2+YBSWXHJwgRIzRXvY2FmdCCr3Pkk0lVzkcWchsyAoUmlHWHuR6Y29mQ7R9?=
 =?us-ascii?Q?ceFmWwkEBSuRZQvE4Zisr1Apbe7eQMs9X/hCykoWz54A08NQSv7ttVtC4Oeu?=
 =?us-ascii?Q?wT2wISWZ4Lbn7EHefQJitpTj9VJ+rYkLi+op6B8dxL7ZZGoLNZoPrW31zD+a?=
 =?us-ascii?Q?1fwftQzc5qzBuBwPjxHzGi0JRxfd5ZRhaTV/BZieG+127+gexxH4weJ6KxF0?=
 =?us-ascii?Q?6BbhcgrYbvbAFFz1W5RD9xGDdcLGIF3jU4/0Hu1GEgdezXr7Qc0qFuq8Ui96?=
 =?us-ascii?Q?Qbc5XJe8fqsqzMOa6WAzgaOaohEQ5n/LOMjj6lxLzAwh/zVxnEj7D6IN6poc?=
 =?us-ascii?Q?qJ6LkKFs7V4mG0ce2uYh7SxmmelJLXKXu6QfkYEa1RokLaeGQR3SWQb98sJb?=
 =?us-ascii?Q?APgIdj/oYePn3q9RYWwbUak3MusGjRRI65b2ZebdMS6dBI3r+UMF3KvEYy8e?=
 =?us-ascii?Q?sCHyIWoHyByTjaXPp8TajK0NwsngYOEzQ7L7jSLo3ktmJGmRofXAc3+2g7y3?=
 =?us-ascii?Q?iLycz6md8dK07iLkWUIEHX+jASXMtdFuPpBy/1DwmgGNXYdOZndJYbnduwso?=
 =?us-ascii?Q?BVhOSsBav4Rkxf5giaDzYEIsQD1g2Fv+XKek3LtQ/DlnuxezsFrXh9GIEjvP?=
 =?us-ascii?Q?B4s6qiZ8pTtk+5rDIejh/oZG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029842a8-0349-414c-a230-08d9156bbdda
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:14.1925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iY3/H7cJefQSAr6KEtFtwGZQ4LSrxhkJbivAkHy9PxBVZcDXjCJprtsAqCtOAMsNCNOSc7HvDOknpkbQVILEA==
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

Same as navi series

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6a19e802d386..3ccd5c3dd27e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2021,6 +2021,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	case  CHIP_SIENNA_CICHLID:
 	case  CHIP_NAVY_FLOUNDER:
 	case  CHIP_DIMGREY_CAVEFISH:
+	case  CHIP_BEIGE_GOBY:
 	case CHIP_VANGOGH:
 		if (adev->asic_type == CHIP_VANGOGH)
 			adev->family = AMDGPU_FAMILY_VGH;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
