Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FCCC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659C064E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659C064E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3CC6EB51;
	Wed, 24 Feb 2021 22:20:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 245416EB3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnkG+Ljf4rbUIu3I3hVyJc6hlGQkTE5QQ7CIqBOoLzgyEctxEwmhRB/6Nz8GaelXSdRG0vHQVWlpVh5gWdAfMHb0RmHdJOLp3rsELhZF6QB+vgF7BUpxGwCesQ7JR+/aoViwfQ3Ck/ebuLLobZE6qgC+aAEl2cSNHQo2zgEUuN1vYWvoIMBSw+/5z0b/f+EM7ybCfXZZYVg9VbaMPWs89ce94CbLOxCbBkL2hvT3e+NTKUWc3rWH+UWfWtVwspvh5DYSAb7x2wrvenP3ooQU1pouTST8Q7KDNNnaU3NnbMrEWNLeNPtlkwid3hGGjeodRYMYGq/gBjZbmpHZPBtgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDGSLN9f0JeyDa/HtKt3ofJO+U62iIyC1u2Klo2T4PE=;
 b=i2vZ3TPrvbiAkuhtOJoihCSWZJB0XpN3xmeD/HLtvleO+VuAKHzhuil360y+m7H91j4BZ2t8Zi+kF4UhiqQip+Bnk8A7OmlhjfWFdaXoZOR6gtkOU6v6f138ZhG65J8jvDieH+QgYRr2wtBey78RwpmbLn67+9x0vsP3zJKUViiVEJPAAvtvU2VTECu1KTqEXeXu9Ji/KYwckQB+7XCo2lfwDIEyEl+zAHYgGtL8Mq0OHYJ51V3CV6RERz+mbkFJY13zag1NjPbmEPlWkqsjmL5RJPMVyxL6BkCV1nLIy4exlewKCh+SkRdaSWf0vKeOnNu1XunlJAakOGsvHHugmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDGSLN9f0JeyDa/HtKt3ofJO+U62iIyC1u2Klo2T4PE=;
 b=bJ3DT1tYiySvAP9njIEo9qj/OCdMvZZK7WRplBoJGjDbGRy7SXj03rH5RsxAGwcE0N728CGv/AKOKzV8hDdEUYOEEIGRRPdISvvPOY8d+0qhXfk2Tuop/n1DJR3/JMkEjisbjK6OCUI5fLO0wuscg2A2rVPsmS4A4xEggiY6Oas=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:27 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:27 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 061/159] drm/amdgpu: declare sdma firmware binary file for
 aldebaran
Date: Wed, 24 Feb 2021 17:17:21 -0500
Message-Id: <20210224221859.3068810-54-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 141e7bb3-d7a2-4c64-27ad-08d8d91254ac
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175171C764092E45B48AC54F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMqDHN18FQjNlYmHVDleLglKk8BtQsO7uqGHqkjwkjLXcsHJyiQb+/S8YDubrNlfxTp2ZKCh4IZQXx6X8ia1lh3SSc5uA+zs5LCt4zFqiyGZwv2wdEQug9bsQzLlbvkiVeuCcwJldH97T5XjfTqWPBWhviQ0NfeqDbzFSTBCNGKhqhd/8+K9LGTEKk2uEy468QbsZj5/MJnVpuziC6BEHAJGshRZUm/cW9BmlgodpVxLvQqGCVhdo4iGM7JzAs0U/eqaWob3dujEzIbdi7LPlYuHugNaPunrVJw5hDB4/rX2teoA4lc/WcOARutyGH6/7SipaiVPnV5c1N/1VO3FkrGZER+IP5w2KMG//cHmLIpW8ul7wzv9veln0yKouw5WmDW5vNCskcNLvIa3igC4yetoKY6f7w1U63qMNAR/yz4kTyeigLupMmEb+LSHIch0LOnR+5SMDRxNj7EsgCX7VNwXeeYbOYEIJcTJKIF+qr0921KcUUZ+mlJQHduRBHtJzGi6m1fQGCWsHoduLn82pPbJGNhEo83qSrogYVaOErV817loXLB09DQvI8yUEU/UpbU6AJ5qV5vAndl/tXsxrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(4744005)(6666004)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XrkLwcplfI2LAorT+b1IzA8f0Fat5n6ZnCCszhyVBXI+EzyvnSejNH69MP7Y?=
 =?us-ascii?Q?0T4LekEhKE9O/3hC5LjsyP1h6rDZGfapFredA1kS+aoBhWd7uRTzVorJzpkR?=
 =?us-ascii?Q?lGCOeKIgR7k44zsIqFiK7ADXQwxWs3NvYiZc1zXudP4E7R6MFRN/XZcaWYoq?=
 =?us-ascii?Q?ukpwsX08itp9HFVsMxfiY/uULJaMsrwmxY+X8n41AhDkkx8jZMCIBY6kFuCM?=
 =?us-ascii?Q?yNum5RG/EBLPMB1ui+YhyM1EOGoJRBf+rBPrEIs7k5ZyCzbw9gDrrR7t4XDv?=
 =?us-ascii?Q?8A67MRChLvFEbp16eeV/TPNGYJKab/xh37dFQe+z1jFPXhUCYWDZP5/d1/e4?=
 =?us-ascii?Q?YbWTwTNUpCkdiuKQ8umfNRULAbbobHvFlFLjqQ2YFHEtXM+2zwqDYN32dkin?=
 =?us-ascii?Q?Oz4xzI+znkvqt6f66I1M8QHcn1ohRJrBd4sFogQf2rn3xzaQJytU8yiSJReD?=
 =?us-ascii?Q?goS6JH1hj21dfbMTYpaCiNzVT3mx4K8y0TlnykYyO8Yy5AKhb+Qdiyh/+b0m?=
 =?us-ascii?Q?D9Kw2sJFPjZfev6Wd3pHmJ77NLPE/RYKtuajKitNB82Pnyvq5wx731ieUaAb?=
 =?us-ascii?Q?iDvrBUk5yaTYk2dZLoiJgiHMbmGn3E238WW+IA9XfoUc95uu+O3aBYUlAAYP?=
 =?us-ascii?Q?R8Y4AokjqpdFeET+E3j7aK5+/RV7vg/bGAwY4LMAXx9Qw6XrVzUi9jTvfv4x?=
 =?us-ascii?Q?o5bBG7GZ8V/zhaGfBZ/Nslpqa+x3cJ9dGWVxZrYfl0En5TypAkCqrg8wOXK/?=
 =?us-ascii?Q?zz5r/iqEEW5z0+F/Gy97LZE6xBbBzprg0PXhJAzqLe/jYUtFFAZTa4Q6KRV1?=
 =?us-ascii?Q?HE1t8tVvPKZHg9Z9PT65tTvACpLMD9EKQfgrUCbGUcMaKcYGh1sPHyj4JQEr?=
 =?us-ascii?Q?rVZ4hG9STSGi4yMI9rZN22qpjzFK3gBEDVBk+O+mid+QMXyBNqmJyRM1fI2s?=
 =?us-ascii?Q?zzsuORYJX2dKJtk+6t+UvB3fJeoAq1lhdepcFjlU6OjHIROUB1r8rIv6otEt?=
 =?us-ascii?Q?WB8y2wdWIyR1OHmJs5BYs6vVzLyjVe3wgJNWcB+de2tzhodnO0mwUuFJcHh0?=
 =?us-ascii?Q?5h2CRNUuqWMyngzHAqaOsNE2hxliXLDr0z875+u8O+T+N8iX87EWhAyNuX4M?=
 =?us-ascii?Q?iKXM6YhqTQO9a7Y3ZGRmAtRihB2LpiYX/GbYES34RTnXqbX6vVUXIohGiWmw?=
 =?us-ascii?Q?eVFZ0o6XOBZjtQznx5if7kT2QnuFUTd36lAdJz7oMNch0/v51dGHD5nF3k1D?=
 =?us-ascii?Q?l7dDx0RCz2+TGicG32jOWWUpfZ7Xmo8NjPQ4eVbFkChxLSwOClxtq80W61il?=
 =?us-ascii?Q?jAQselMVr7DC6HARaOSDCIzv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141e7bb3-d7a2-4c64-27ad-08d8d91254ac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:02.8581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zczWcjiugJihN2Oh6OiTu2JMnlfvOb6dP8thHaY70Cjue5ovXHP7jgttVX7QCqRa4T5QFj4ovjcybd2J3009cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kevin Wang <kevin1.wang@amd.com>

declare sdma firmware binary file for aldebaran

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index bcb3ef8b3fdb..17f6e59ea96a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -69,6 +69,7 @@ MODULE_FIRMWARE("amdgpu/raven2_sdma.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_sdma.bin");
 MODULE_FIRMWARE("amdgpu/renoir_sdma.bin");
 MODULE_FIRMWARE("amdgpu/green_sardine_sdma.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_sdma.bin");
 
 #define SDMA0_POWER_CNTL__ON_OFF_CONDITION_HOLD_TIME_MASK  0x000000F8L
 #define SDMA0_POWER_CNTL__ON_OFF_STATUS_DURATION_TIME_MASK 0xFC000000L
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
