Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D198C43600
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C636141C
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C636141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F9C6EC74;
	Wed, 12 May 2021 17:31:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B10AB6EC6B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D218Py1M1+p9uWukiKSfrmPJS/vQMMekh5a/s9Q5bnNEMpIir9MX90p+u0Kz4he6QRIv1t7FANcSqI9LYUuEEapO54vxYKqPDDJ/ewvsHM5t1nDhaboCJH1O9iuxpwdlI3ALvnaLkUYo0gpwuQ8IaMQkGL+SIDBTTPVbqLOZVG4GbqM/+JDTv9mAsrPjDzCC5SzochcpY0/AxVCMKOC4jcQDpJ2lt/E6sUy+Vu9F6nl9715bEeJmcpunFM9Oh+fU0dLAHQQA+M2fhcr3lwQrCOwEVk2qqrbgUDmG/iTgjFVqTczbnwf4xH5+k34cWzi7Od8cd5MNl0GMKH034hsn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMfQhtFRiOeWur1h5RC35Z7LnjkBjmGj7oLu8ApFr04=;
 b=dB5J/MxVvfHIa7WhIqcCQP0mo+OkJCZWhV2uwE/xj5euW837wOZWdANUWZyNRHyqu80wR6M7quDFlkNl2Or8QxW7cBgQAV9jRe6/wAkkLXEw6xoLThGEGamEMAGd74jhiSEzYnXtVxeEdozYXqMhaDhN+gICK9YOEbwrBBttBiwPjzp6U2EVcjl+2lwZ2Pa2iQUob2BevjY5P1M8EBTtjHPJa+mKNYKXPDUUMzCeSf4dHpKcqH3LMHmN073l9Sys+pBdGCbyzpEf/2TInWXclJbWNDVitxKREYJRGPDkaOyqjJoDWw9tSJuTBt99sLKtRBlTZb/zJ7/tDcPTEFs2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMfQhtFRiOeWur1h5RC35Z7LnjkBjmGj7oLu8ApFr04=;
 b=ynVv74zx/hSvWdHegIVRDt1mqUWRXjA57h0k80X1sX2u92Dd1P1EswuzysOalM+tF5WVYI2f5gJuGi4C1G/fdZCWdZAI0rxejzqkhxIjTPJdSV5qyvycJDrBLaEoYzGWy3Xz+rdWyN4yg1DmloKWK8Dewz8i/63K6g1px/uHSho=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/49] drm/amd/amdgpu: Use IP discovery table for beige goby
Date: Wed, 12 May 2021 13:30:22 -0400
Message-Id: <20210512173053.2347842-18-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a66de55-3da4-4bec-cc4f-08d9156bc3d9
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340A3A83502F93C47D634F4F7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSEOmJM3uplkwEMRZ/2sgvFSehTOYtqLjCocIVGaHv8DtDB7Bpxr4fmOhIkm/cW6JButxK8OiRK0G9qoiGc1t3i9MBGxzCJHXK61Pt8zUNmuGvHKhUrGqYUIbA6eQTPXtDil1gIQFV7BQfiBQANrR0Q1DW8vGaV0ZKlVldRyX4iUAphS2ocz0tN6UL46wG8TudUFS+TvIXssKE3BSAZtWJAk0VGg5cQQGpxyvASHZjdH0FmqiHgVO8sJAIm9bICPiScwcA8kCeZmd7MHuKyICjsCxwSx4n3iOVWi4T2uwXeJAi9+5dRb7DZOcGh8Yhzt7iFNVuv/ENpqfwgd+4WuOftVIow/QKF5Pi2OeXo2cgBJZVpoxuyUnJQ195WlgV2a5ELBJp9lJUoK4HO8F6eRleE3Q/50Rea3u7vf+sTJkSYwsPvf7UHIPWb0pSj1fqi9MavcZyc0G1vXFRsA2qRZhNWyLvC3FjCVBe6z6OIPoa6j2drlQhy9FzUT3MK5sYuKJ7PRWO7uYbC7Ur7TcLEuSPboEZPmvTM2Fcwylkzirjt1wu0S4DMqbnHcMgH7q5Wkq9qnuDQP+sZS+h3+UMbkStF+AGCA08E1cXwCwMLQG7B81OQG/tpKozJw69p5t5smUPxSah5wWRtkBC+YWnZ7/4Pq8O7O1i7Rc/MAhW3G56XHJ4EMYJWdxCp5o5QWVcfJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(4744005)(956004)(6486002)(8936002)(16526019)(1076003)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CmZWOO8EabuB3V1E1A4cxVwYO/0CaeAJQKagAQFM0vfWrJ5Plleg4Xgb9m4q?=
 =?us-ascii?Q?vLkDNUZt5WIfvh1xhHTKo1nDQiJESDu8xRgbLkXcCcNvvuGRErONFeSeaf1U?=
 =?us-ascii?Q?IDvDSrHvN/LouaIWYoo/59msSQHNvDrlgibW+F4gUuPiy5/Hx0VHugRRaPtz?=
 =?us-ascii?Q?MsG+HTmKHgzkidXflgiI8Js6y8WrcGljY9grMdg9Vm0es4Si0X43VQGXU8T8?=
 =?us-ascii?Q?ERWxThh46VRfqKYHq87o+uqDi3QiT5GnZoH5PFsepbWO8ncpLf4WQoMcdjqB?=
 =?us-ascii?Q?Do/nJ0MRyyI/ehQ/lTf/NkUSkyeVRZVX3TyIRM8Hbbm+iuiF5EO9vEfhlmff?=
 =?us-ascii?Q?WtBbQ6sU1p4xPT83az2U4DtGHU+dTRHZSFu0mOPCoxkmaYPvfW1HB7NmGsOR?=
 =?us-ascii?Q?oJA6vrQUpjhSAelXwi+YAXTl0mR1eZuFKGG+/WHT1mwxVn7iErZdXH+TMxX/?=
 =?us-ascii?Q?kqMUjg44BviPub0Nzw58EqsJbnBnz5eH9A50rNMAAOFuLfp5JYVN6jP6anLk?=
 =?us-ascii?Q?vxUa0GkVsvNR8hfgNUQQRu14Q/t7FU9ESjimnvpz3PCvIkx+GCIhJBJ4292B?=
 =?us-ascii?Q?oVZuztTAIawGI4gjSCfJxq466FSDkixCGiuhBtd+QuAkLA2P6XUR+FwEVny8?=
 =?us-ascii?Q?Vsrcy3a09CkpGeqT8/2El8xoHn7O+sW54z4r17g3rZJZEMr8+AgEqchrNTe4?=
 =?us-ascii?Q?gRW5dRQAFy53muOPyLmne1Kn3+qGIWlw5t76HsqOZhRAhvsR3d78rLKbW2Kb?=
 =?us-ascii?Q?38MNHnFrapH5w6FTNbPg9tt3HP5yFHRzB9aDHUgHwj8s1VW5qKTbgmtRgnXQ?=
 =?us-ascii?Q?5HnbqtfDpZsC4u+ObaKp/9okpbl/kAKXcHnh5B9GES93fnEhpcwg9/0lSsQs?=
 =?us-ascii?Q?FlE6rQ8xVTS4UYTRyck8hayvrLqS6vCP/vV1jrUJaQ18hFY/MYIuPSZSRCls?=
 =?us-ascii?Q?H95O4+onM1A02j8QaGsEmPHjTsiPL3eWu0dVxN1u+ccT/zcVJuev6Xd7iNCj?=
 =?us-ascii?Q?qLDhW9rkNE5rUZQAb+3bhcke2iIfJEDaeFkVMNMckqUZrXW4qMMihi3FBctc?=
 =?us-ascii?Q?1Df90bQ0+vyjXDWJY2jcd7NGCUdWtja/uhUqKnHZC5KVqvzBNc6xguLh0hzj?=
 =?us-ascii?Q?tETx7JgT2EizeHBNQ/25G97jSK8z2hVzZcBr5M/588kTCyBwTLgNZzFMvdgG?=
 =?us-ascii?Q?PU/1e/KM+6kCikUDKRVt2EHMhQHvCcDUK45LaDzgwCSuJv8RhHAkNLvCXV5H?=
 =?us-ascii?Q?ks4GOJhWIIp2NksFKOJcYpad7+ABEKwgdup7dnPmQ2rVuMh6ENUoG83l8zOw?=
 =?us-ascii?Q?kAUGDP2kxWnuS6NQVX/GROjL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a66de55-3da4-4bec-cc4f-08d9156bc3d9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:24.2783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKiw+UhNarGasmQ8y/wNS5haU33mgB5IvPOJi/5o6bs/PS5D+OhO8t4Wn4eA4YaJz6lGMMGrjE9g30VZatMG8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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

Rather than gpu info firmware.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3ccd5c3dd27e..ea3753ca4198 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1808,6 +1808,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 	default:
 		return 0;
 	case CHIP_VEGA10:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
