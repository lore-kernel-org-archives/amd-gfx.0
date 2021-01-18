Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A510C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 11:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA938222B3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 11:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA938222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BA789A57;
	Mon, 18 Jan 2021 11:26:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D158E89A57
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 11:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aky2686so7/P1LU7nCJT11zT1GGJfhIJrXCwk2PSlWJ4tO/KvaRRtCsPiUOiHGaJQanutnai+gs4CmHF7XL+RW5STtOFcdhJXxwVFfiuNO8flsUmDE7Yai2Ir6YExbx4/E1FfMWqxc3rV+8a+x18pE0/AmnsupHmd7wJiBBN+woYXhHMV58EUusJy7QKx9Dk24ZgjCm+SoYYCdPdiF5/1B5eAENHvJCJbtMAroP+TJDfvR12raOmjCx1PXZbNxQtRZmnvrfG6GPoJS1TcPZuY34DDi9AsYEvkx9XLQFK8BE47+U4H98iGVl8FCwlCeqU7zzci3cAxHwDksj2K+r5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JEGrXusOKpiOs2zzW9/2k97xlM7yCr0Vxs/gYTgCoM=;
 b=kwbjkDZM1XnBMaGmLVrC6KFt79mPHRFYvSpS67vEGnWP5st5TEGjkcldguOjl3gqujEjsIc1pUEgpdTLYYx2YvLkx0FHbWDjv5hiosZOIVf4vx4CfZwsMi3qQlV41KPix2ZTiwR8Ievd/re9ZnUj6CkjPIlKgRAWUE4qYInUPWMqyVsaYrK4GwOy+Puo1XCcDXUTxj4wXusd5fL0tYWjYkn7MboiEUYs2lrSo9a5As8JkmPh3z+eTqaPiKlUNa0jJOwNfhNefMAp9cuJW6thNjRy2YBVWAMxrHA8E06yDZM+KjBOtw67fABgWeo6/8XYEhCfwc/sumyvMMMf0ji5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JEGrXusOKpiOs2zzW9/2k97xlM7yCr0Vxs/gYTgCoM=;
 b=fpPpzrkU/XU38HMfkCgXZHijItyah4TGd73YmNhAxAhKBA3zzNZFyUBYqvEvjcIC9EY+eUtFpLDdUK3of9XZNt+nMo7ZWrwoeJ1v5IJWk7M/ahH1W5t8IKIsAy8VvBfhWbo9nMYBQ+i1ZzCGxoLZgNFJlQdPwuPhxQF/nFwQJDc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.14; Mon, 18 Jan 2021 11:26:25 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 11:26:25 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: modify GCR_GENERAL_CNTL for Vangogh
Date: Mon, 18 Jan 2021 19:26:07 +0800
Message-Id: <20210118112607.26171-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::18) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK0PR01CA0054.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Mon, 18 Jan 2021 11:26:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12514837-08e0-4210-2a88-08d8bba3e417
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0107F644FDB325CAE3E691E390A40@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fkaf6AqbpuZmld6wjrJd8zQrP9VkYDoQfzdEUpMB8xy1F2vcs1o5uJhYX4O+Q4q+/rL78nmBplupf/5iySOFVrGhq9wVtn2Jap/NRQMzBK0Ow7kjxc2U/X4C/LkT++BIcQDLbqsBjtoBEqKT8PLs+8n/uKKvmzDERXPyv5i3SKh42Zly6f2vqt1VHxZRbbzhHAvgrD2JmU1jXuw+6ZmdCqLbIinMWYx9IuSnlgXE4Cdpg0PC0MxJya+zPM00i34bzUuqzskHldd6dT7hQ6qj68qcMwrGv3B145vGzt5fFirBNm9TW0W6Dw2187JH8dMuH85Z9XDqk44jMjWlEKY3IEbnTnTJ1AZWuIQLZOUa+rXcNgu8EsBijBwxKl/6jS3aMd7Zidv1Qaxa38UW8xk5jJNWmNxOofu1sgvAwpD4RoSSSsShi3xychipq0ndqf8hG100UADfBU0CZ+ZHE5JAeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(6666004)(6486002)(83380400001)(66476007)(66946007)(66556008)(1076003)(4326008)(86362001)(5660300002)(36756003)(52116002)(316002)(7696005)(16526019)(2906002)(8936002)(956004)(2616005)(6916009)(8676002)(966005)(478600001)(186003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jO0y9yCtlb4CywW3x/pM2kYNNRQXzm0KyKRTYx30lCSLQGq5R1GvczDQ0gaw?=
 =?us-ascii?Q?sVmKYHIm14k/Ow6ODMlkC6H3M6xKTkmTieD/DbCpR5YKqj0jn4rI4s/ajsZk?=
 =?us-ascii?Q?QWXBGJi9/C/iSIBZBi3lLXX4x7mT9alfVDffRwg9DT7aB1X21qYgL8zv7xy9?=
 =?us-ascii?Q?qtfBm2j9EItjmkgp+cVRvQuxvkDELIW9kKMPvmYiSeh78WMZJxLm5pex0szD?=
 =?us-ascii?Q?9cAfxEWU/SW/bioQ3C0Rw6UcpMGkG4iZpmi7Z2mE7T28jS2xrTBqtdzSU7+6?=
 =?us-ascii?Q?9ez8iZixQJBcGT4PSFdLzZ8azm2Ydr72hq9xS+sCB1tygcLDDVxcVrWYv50w?=
 =?us-ascii?Q?0brtysEcY4Fy3oJpJ/n6Z566JqpPyXHBkCy9OWpLwAzv67XYDouUM8vrLDD/?=
 =?us-ascii?Q?Aa/I3utIXLITD2X5cihmHeQ5q9r2As/MjZdQn2CHqfPZR8USMk4YXnFoUUUs?=
 =?us-ascii?Q?usF59fowyOqMm2ioIWrKWN5En60BuQMQOVlMiUHWGknOYkhrMADm/u7REe0N?=
 =?us-ascii?Q?iUKF1aGfYnZNCo9JhSTUbNV99zXQg+6dewwLmS4HkSd5ihfJA/82LX1eYkQJ?=
 =?us-ascii?Q?5H2m3ha1W0ONoMbu5iNoCLdNLzezihvAe2ZD2wfnM+6LE72zNqROJrPrm+TC?=
 =?us-ascii?Q?2S+WK5If8WJUwoQw4UidZi3G/lmt7dzPdhZb9kzwIjGqz/ywb3PYjGMcNRNC?=
 =?us-ascii?Q?B+8ApMDMwYveBStLrtql2OzrcjIBe6bONEQfOrVhWtf0+B984DSFqEqjGjXb?=
 =?us-ascii?Q?DeQv3jbPI7gbpW9sFU3L9XEHMCltWtZ9aMiCjXWKJ2Bmcl4FlnpHefgPx8Hc?=
 =?us-ascii?Q?Tsm1MCmCe9vgBP2DX25TnZwMV/wRLUpvRF4+krEq/K3uh61/lw9BEQl+sCjh?=
 =?us-ascii?Q?cuZezklCwDn5yOEuIhpP6Df9mn90+XRUI+Rk9p7SagkyJg0VN2oGCVWlbY1I?=
 =?us-ascii?Q?/WzRIe25+7gGpXpBpDCkqa/ArOlDWAWaICNL7JoAUm7g9bobtb+lUvt94IWu?=
 =?us-ascii?Q?b0Ta?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12514837-08e0-4210-2a88-08d8bba3e417
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 11:26:25.5823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YOuusUxXHGSM2OjxBWbJqPfRrnvCFMWT/IMAWY/d5bzOOfJrzA4tmr0fuCuDFRguigtMpivUnPgpg3wSUqOMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GCR_GENERAL_CNTL is defined differently in gc_10_1_0_offset.h and
gc_10_3_0_offset.h. Update GCR_GENERAL_CNTL for Vangogh.

http://ontrack-internal.amd.com/browse/AER-11

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4d3b30a2dd45..1d604fcb9b77 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -118,6 +118,8 @@
 #define mmVGT_ESGS_RING_SIZE_Vangogh_BASE_IDX    1
 #define mmSPI_CONFIG_CNTL_Vangogh                0x2440
 #define mmSPI_CONFIG_CNTL_Vangogh_BASE_IDX       1
+#define mmGCR_GENERAL_CNTL_Vangogh               0x1580
+#define mmGCR_GENERAL_CNTL_Vangogh_BASE_IDX      0
 
 #define mmCP_HYP_PFP_UCODE_ADDR			0x5814
 #define mmCP_HYP_PFP_UCODE_ADDR_BASE_IDX	1
@@ -3243,7 +3245,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000142),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x000000e4),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
