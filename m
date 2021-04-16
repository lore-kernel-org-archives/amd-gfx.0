Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49006C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 22:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077766137D
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 22:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077766137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD306E049;
	Fri, 16 Apr 2021 22:31:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9CDA6E049
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 22:31:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asYHJyDjJlPqtON2lyhV/nF8CevfqpuO7TaoJrQ6RQXTuoQezsFMS2LorzurWejcShMITgwJJIPkJYaKBmqIUe2g8znubcafRT78SQrnlaAtUSPdO5ZJ8Ob7TiBatf7DbMt+ywPgaMsknTpINQHxHqh8hy8l2OKAWSE0aFxfWsEuKZLzuOxfy9Sh3eGJsPosWiHDUaLG2EFzKLYU9GByHnHIJ2YifCD/usCND3NzJMuRnu2outdw6wOyx+17K5NY+Jpu359/6d8T50pUVx3QHZPupPBKg4Tp/99h5I/XThHgFoT6sA3YixfRlr6kvQ9/y0eEK25R2P0Wtsy2I3+QNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDr4GgUSqfdknIbwYB5LYquRyf40V3FfFTUx80fs4lk=;
 b=PoSq3HvqvLLqjQLZ4IyM21RxjBZoBoB7KvoQWZtJN6UyYa7hk37Tx9a02zf+DEH5W0yIoXjLvb/W0V0OiMBQ9gru8iQKX3/eFSLTjVVycwNNEIL7rIB3WysqfHlOfcFpoubAANiVyweXzxG6jM1vu4DR/DdKdDhmjUXl3sZJs2dDbfvPMVhpnLFB9dcsAUytzIogtJCetkUYN3BMq865rtjXr0bRaZ9wXyoOKK4M+hijZX/mS+ZLp8r8D0pIHLgV0FFZ9kW7dccTERcnV5DDflWEUQFT8J1E/BGbhEj0vzsiYJc9VDjXWkIlwg2RnmbNtHALyvmxIyUe0/5AvqyuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDr4GgUSqfdknIbwYB5LYquRyf40V3FfFTUx80fs4lk=;
 b=gXXDusTfB0+CtoDY9Orb8e0sE0v91JHtCSyBd8CAc7wth7pVZ60mFYgctFy4KUYCzwWA8HI05n/L4Wr8xQ59SXVQ6gvflDr0iAfOowCsFFNDXq+BCoayxw6dQGC4crP3lzs57tquFhvaQ+wpHulVJcSPGV5UKQHZ73SjTMtwEQg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3452.namprd12.prod.outlook.com (2603:10b6:5:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 22:31:08 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a%5]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 22:31:07 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] amdgpu/pm: set pp_dpm_dcefclk to readonly on smu_v11 gpus
Date: Fri, 16 Apr 2021 18:29:56 -0400
Message-Id: <20210416222956.4580-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416222956.4580-1-darren.powell@amd.com>
References: <20210416222956.4580-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.190]
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.190) by
 YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend
 Transport; Fri, 16 Apr 2021 22:31:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8032d3b2-b431-44d8-74ae-08d901275421
X-MS-TrafficTypeDiagnostic: DM6PR12MB3452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34529BB58E3076829F1C7844F04C9@DM6PR12MB3452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqBK4e2ocK0MdG3nrmWs5FoOVaXqUOaTf0fYf5vC/cXUnVlMYMpg9iegpxwZrD88qCcaRHjr6OiQrD3sqOdQ4wgm8eTQG3S96Jpgi7BiFK3bec3ee/siVe3qvlq7P9BTpbox/yYlwCkwc9mGkwEP9Z5mdALVUIfFvp9Y+mVx0HWwA6LblGWDk6mC+cXT7MBRkMqA5brYNFwwfj60ZHuderTIH+bkajvsNuGEmJOCLs3b4OP19HkuJ1e7VDtXU+T5EuUXO/TTip82cCum0PDtCWi1UNQuuG4XAT3YtWl+v95dKRPQ6rI+vxrjLK2vtwNdLsl92rpp9gpMXn5Wpk1HrvhwFTbybNQfkDbGL6Fs18xNNaxxOgqo0YuSvj/lrKssD9UqKxMCZJbBeBklhYb29V+93akGL/uU48wuQZ7pXLpJs2KhtnUm+2NB9R+t/bjeqcASp1r5D/qhQf2ssAYFNXb52cuCYi7dLeKHklKf3RVIe2gJ4IX9BIybhPEH9Qgnx7TmOFXtgaWW2c78QYn0wzE9M3bZ15oJvBOzgu1OkNzTMFjEGjcRZmzuP48iTff5OI9RKyB9R8SlSaWIkfyp9cYV9UkZwQ/SCmgMqAgYWbr8r9OpjP1weEJZhT7BHxrdVHSNUNsOOvGC4hiqWB2GhqbXlNtYbHPB0rleio8mpldC9iHUwVV0h6VAwL4v22XY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(6916009)(69590400012)(186003)(86362001)(6506007)(6486002)(6512007)(36756003)(8936002)(52116002)(8676002)(478600001)(66476007)(83380400001)(2616005)(4326008)(44832011)(956004)(6666004)(1076003)(5660300002)(66946007)(38350700002)(316002)(2906002)(16526019)(66556008)(38100700002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tDqn55rSY0FIs2FO3dw0ybkMeX+91kcu+0W4Wk04EuN5GPKKNoXS0xrGfAsA?=
 =?us-ascii?Q?DJj2kvkB/n9lZwnPThPYf86SSwqjOZwI/qVJ8uT7laq4pJTcNzJVRtcS4WtT?=
 =?us-ascii?Q?x+vVlQQiegur4p77u9ZZMDeyx77KzgYV3c+pkMBFcV22knAuJXrnlM6ozEZc?=
 =?us-ascii?Q?Lv561uzF6kA7BzgjQoD0m/qsnw1etNc+v3kyt5S7IIwBmEnBHStWi8WTd4/w?=
 =?us-ascii?Q?I9uTgieBNRt9cTOpWCK2KCzkTiV7M6A5jxRWSkfoa0xOzyHhAXXDLMsXh3wM?=
 =?us-ascii?Q?Rwr3I0c6h4/0/UDRx+qpLUXTg22SSgJ44srNBmxJZPJ8VYaqSX7DAzocKxbf?=
 =?us-ascii?Q?w4fU3B4Moy1t1V/kwb6DCcw+U4UVUn5dzOGI2otZusJGZ1zuEnXoI0SgSwSF?=
 =?us-ascii?Q?fEt5/eShIDcIkbYtRAPY170IkMhUCJGp85KdbhGvs0b3L0ZPOxvHa6e+sucP?=
 =?us-ascii?Q?F5CFC41To6Mm3xsOvpehB0ES0mgQbwng8mE6Ok+x8BKmOYB05Dhk3/j6Yg0L?=
 =?us-ascii?Q?pb71hsRvXRg53t2LK6nAPnzu8bU9COxPQ3ZSURZwpuDjVQX9FcSicDGESPCv?=
 =?us-ascii?Q?eGa2IKZjoBtyWPCAHDBYyEetPAXndUMQpLo3d+KR8wgWnNtvRVZ1xoLU2ddp?=
 =?us-ascii?Q?mWNhhrbD//4XLQVTY3/QB98X8CtSVMKzs8Qwghnskj6vo8/5wZBa2FM1Fgav?=
 =?us-ascii?Q?W+i0H6UhRgYlcZ7bCxUTyZlAp6Br4RPl83MHYqjmyhavPgQL9tft6OChyuIe?=
 =?us-ascii?Q?/L9/HbyyRA0CHdQOHQjdTXs0PPhmfzfhMs/MjV7BdEUKzy0DUh8xY+oVQSp5?=
 =?us-ascii?Q?wSBJWo7x5ml5Q/c1nnREDxQTeS1kupCL7EFJmdAOJQ3dgYISLXrQIUs3Dwze?=
 =?us-ascii?Q?IOLN5ssQUSrEvADl2nW7oLw0QGwCa5amfoEKUrE2qTr6AHpcYHs7gPELgaRy?=
 =?us-ascii?Q?jKqyzR+UondeZXKMtGrItTvmXOKxwm7IP7OhtO/po5Rd40pcOfeRT8vnvj11?=
 =?us-ascii?Q?NWH5ouoXhWkghTmnO9xgRIVeq7e0XXeQKPoSehV8l8niH7iTsMvjX6Hh87Hf?=
 =?us-ascii?Q?ImvO+b+O/rhG7lKc4rPMHAAau0IdLcCQSB6P0V7ZFKL33JWpVVHmx8aV2Iqc?=
 =?us-ascii?Q?jb1f5IPEIgtWryYS7gbiOUhOlJZvNA/Hsmy/4du2rDRDm0UubViT8NPiHEHC?=
 =?us-ascii?Q?8Mk8ZxLIpPCC00XFaksB9a+J2J4mRjF4V0+yZEAMLXfRIxwPpMnWPp50J9lw?=
 =?us-ascii?Q?GPneNuD8s6/y8ZDFAsBSTo/IgQCIJ7kAnknAYcEFuC+Kdx9VzsMlGneDuhuq?=
 =?us-ascii?Q?1kuioa4CDuju0262gD2rc66T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8032d3b2-b431-44d8-74ae-08d901275421
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 22:31:07.8385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsfQEOe+fIl2jhquPWYQNv9wALY1heoKP0T3zB8QnnwSm8eKxz2GfOXyTjwnwzhHsHetTWlyKsipqFM4bn6VyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Writing to dcefclk causes the gpu to become unresponsive, and requires a reboot.
Patch prevents user from successfully writing to file pp_dpm_dcefclk on smu_vv11
parts and gives better user feedback that this operation is not allowed.

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 204e34549013..317e9b47db53 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1891,6 +1891,19 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		}
 	}
 
+	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
+		/* SMU MP1 does not support dcefclk level setting */
+		if (asic_type == CHIP_NAVI10          ||
+		    asic_type == CHIP_NAVI14          ||
+		    asic_type == CHIP_NAVI12          ||
+		    asic_type == CHIP_SIENNA_CICHLID  ||
+		    asic_type == CHIP_NAVY_FLOUNDER   ||
+		    asic_type == CHIP_DIMGREY_CAVEFISH  ) {
+			dev_attr->attr.mode &= ~S_IWUGO;
+			dev_attr->store = NULL;
+		}
+	}
+
 #undef DEVICE_ATTR_IS
 
 	return 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
