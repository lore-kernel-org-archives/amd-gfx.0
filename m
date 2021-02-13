Return-Path: <SRS0=DGdK=HP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C050C433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Feb 2021 16:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF84160203
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Feb 2021 16:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF84160203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A236E851;
	Sat, 13 Feb 2021 16:37:54 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690060.outbound.protection.outlook.com [40.107.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7986B6E851
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Feb 2021 16:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+ZKSf0uNjK4Dqr2RXLBaXlZc2+xKU2sKg900Y8HXDQobsEX1H9LTuQ8R8siceR4XFzPpC7yVXg8GHcWsUhJJjXNr7CHx6+Ck0nU5W0OK2Xy+6RaT0v+l+LZHbkZ8N8030E+FlTCtIEo7JzDAJOaCutQucVAFf/uMojgHdgK6h0CERiTxK+ZNBrXwa1R/SKkFezWNhGohOpGSpncMHy1gdkE6nkt9EOxllqDEL88muc9u2F9VuccR+Re0+8V4mOaoQZHKMjoATHU3Wn1SktH0MiznAYpjs0sc+LOHlFt66OFl+MpN3CMzsd3rzyE8bWpAfi/UXx+N85/MyWYWPxrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdPAW6UFD95Q0zCcBhPp7F4QiuQDDdUamDzAGGUWP+c=;
 b=nzwKl6cQ0m64A9y9ea3fCybV+tXM9+l5Wq/lDfWruNAlUR80NYAmHLM2QHli5YkFzJxgBLOMFhq3Mlz3JPd8tEkeeI3534rLr3sjOsK3b5acan9kapCQOyC7/8mj9Ms+UThmKKMh5SqcwjRftCEZuxRqhcCc7fqyilAoXk/AMEaNJxs0oDCLvZCb3q/eL+5eCyCji7dZcGjbm5emB2Mueni+e2getf1e2I9EOmkNSNjVuWsiai6GmzoXWSTFjyzeIwIQ2eeRppmDiZV4ne2wpd4nkUcL5yySSztD+hEzxPIqxOprfRIz78ZHKj6wmXPKaOLgbBYDNpACccr4wKmjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdPAW6UFD95Q0zCcBhPp7F4QiuQDDdUamDzAGGUWP+c=;
 b=yuU+3JN7De0VWDFyp6QtQlS7YBsYgud5+AO5Hl6t+QAC/ts72QeIDc4veYEAQFLxO3gmgkBURzAjTdKiiyxnlPWJx+dzE9HiuqLCqpHZ2VfN40kev+jNAuLcoh0oMPDN/mCg4UkUy80oWo7qSw9OesmQai+scHUU1xlikr19EdQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB2920.namprd12.prod.outlook.com (2603:10b6:a03:139::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sat, 13 Feb
 2021 16:37:50 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03%3]) with mapi id 15.20.3846.034; Sat, 13 Feb 2021
 16:37:50 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Set GTT_USWC flag to enable freesync
Date: Sat, 13 Feb 2021 22:07:24 +0530
Message-Id: <20210213163725.17202-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
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
 Transport; Sat, 13 Feb 2021 16:37:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77373b66-9ba7-4e09-7411-08d8d03db3e1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2920:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2920B239D648D9452D64477BF28A9@BYAPR12MB2920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edpx7aaR2WQnMP10qQykU+dCaCUHX8CBq+XdQKclorEGkZOJ8p6n0FpUYiZuHub/IEbgpimPKtu+lABu9mbqrUTbbblyGui8Y38c9/2ElcRcmoeTC3uTLZr6urMTUkMbzcymOXIw3WyL3sVgvD7JMnOHVWq1RgvLMimgSlGdSynARohBiam/VxJqkp4Xr/+JqRZX01BCGmGVld39hEFIRhetwrydQa8GJnsKpNMQxgQCRJnzDGs7slGzJfRyxS2n8f+DnseOtkmHDvu6Vc4xPgwCcfHW1NzrAALwWsN7ONyhQ0ACZI1GYp4Cv5N0UjtSJCUf87uHh3+a6m/8sbwp2mmkUGkGiP/FsJq+TQrnkA/+Fhb+RrlKhCZEFBzBsqgb3Rf4zYnkNmiPfDFGRTF+WYxr41NXS9S1KRbTizFdtnelb0f4lITx6LKhqzvSYec1V55sQAa0AVSMMguEyvuOxkW5cO06paQkOuY8LfVRIbVwkMJxCUPY9ySuFr9FW18xQBPhbpaXx3sO9U/fPZQmMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(8676002)(186003)(26005)(1076003)(16526019)(316002)(956004)(2906002)(6666004)(2616005)(8936002)(7696005)(6916009)(5660300002)(44832011)(54906003)(4326008)(66556008)(36756003)(66476007)(6486002)(86362001)(478600001)(52116002)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6mjkiwqEzqmP7U1xJnB2NP9Hs2WLeYpaPwLkw4KKLiy3MKXvPmPis3T4My2v?=
 =?us-ascii?Q?Jm0us3mQ30gLh18Q44PWSsi4jZNp5X2u4KgATIGHuasoiolhz4dAFRJUsg5o?=
 =?us-ascii?Q?ibv2snlCSRLJKTDJ4xkvyGwZFoMAWjrdhbwKg7gP5u2Y9yX0v5kH+gMeomrX?=
 =?us-ascii?Q?peYNXWjf3AYL/szuztcZ66YUYXfekbfi1LOcYfqyxJ2XMSeuykSL8V5o2l14?=
 =?us-ascii?Q?FtT3ta5w44SfcAwgxafyK0PeApqi1SDpSy7eSKXYaFcTnzXdxYPKdZc+ECjo?=
 =?us-ascii?Q?jmkB2z63OTeSIJ9l31RWJKVnwiLmvW7IR+UCSRKK21IUTWgBg2tMH6BjsJL8?=
 =?us-ascii?Q?75b4qDaaYov9Bxig5bSNodJLKqhh8+3QLqZ//6YjRayaaysXDrwll7d31OIJ?=
 =?us-ascii?Q?GlfDdjWoWOAC5Vgh0m5JeYEya5eEE+CbUkvq4CTghJgETWA4X4wCKBW8k/U1?=
 =?us-ascii?Q?1uUp/85EXQaL1MXgnKfTH3Hp94FpgYnymVGxtlFIQBVZFC1QzGf6Ey9edZPe?=
 =?us-ascii?Q?ewuaW421UqWoifRng/NM3gBLRM9Y+H4RmJ5eqgonIOPVoCBW2O72qLRzPhSz?=
 =?us-ascii?Q?ADCsLpmrNqxY7yEU0nFrA9pJ8rAiFQGCJDBa0gC3NgY55EwgEFNqFPS6OVjd?=
 =?us-ascii?Q?Mek4S3LnzqQOK5fTL+Uoc9sl5ff6k93qQKui0bhC1imdiHa/sF89fkP5sWLW?=
 =?us-ascii?Q?sk9DYQDqqA43EPHebLIGrWE98xt0h6IlD7YlrqVxvqryP4V6pp5cZJccYkXx?=
 =?us-ascii?Q?yAV0u9b5Tp1wZowW4fNGlOIIoixsPaKE+3xX3o6x0XjaZCxysMHsjEqPw/7d?=
 =?us-ascii?Q?GwUSE9DqqvRincZkrn0tuVNrfNYXIWh8cJdHpFMunniwZj9z/SQ+KlIRW1Yf?=
 =?us-ascii?Q?8pnmitdnEg8ri65MAavnAklrET8/bKaELa51CLLvvqIwyXrPZTWUruErWoZY?=
 =?us-ascii?Q?svR7WdrgS5/x2dZ8d+ss3+d8JeRZUaPWhkWIMs2zvl1hXPM3M5tN3xZr6gl6?=
 =?us-ascii?Q?bKXNl8PLLe4tSp/bYdgbuYiBqoIN9BhVZGbrovyc7SkooYH08hSnDpIPx61+?=
 =?us-ascii?Q?FfAgkh9I/1U1PA5pdITqZ+Gb1hgsNhrEeqM/wazyVfpMrnJUT3HPPeXUVfYR?=
 =?us-ascii?Q?ofhStTJfRDtHwv89DwIjuHa+iU4sYv7+ooSqbvMCMsHKhzibDWurHQORiFYo?=
 =?us-ascii?Q?vQFQPS29+yvYeqMRn8DLkOqT2EI4a5W/0m5iHzkNzK4I6ToUOtL5cYDvPBRn?=
 =?us-ascii?Q?hc1Bh4gXdAZ/5RUlB1T59bHIP7H331BPb6GSegXEOElrLWK8YUod++68OGFl?=
 =?us-ascii?Q?M/RBF/zfN4pr6yqOZ1KDyUXE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77373b66-9ba7-4e09-7411-08d8d03db3e1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 16:37:50.4693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaW8wJvS9opX3qI6MiELcCJ6wh04iurGb1aemzWB2OfzYeN+wpioo8g94s9TnCzGXRDV6/Wkg+X2KQa4ru8XoA==
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

This patch sets 'AMDGPU_GEM_CREATE_CPU_GTT_USWC' as input
parameter flag, during object creation of an imported DMA
buffer.

In absence of this flag:
1. Function amdgpu_display_supported_domains() doesn't add
   AMDGPU_GEM_DOMAIN_GTT as supported domain.
2. Due to which, Function amdgpu_display_user_framebuffer_create()
   refuses to create framebuffer for imported DMA buffers.
3. Due to which, AddFB() IOCTL fails.
4. Due to which, amdgpu_present_check_flip() check fails in DDX
5. Due to which DDX driver doesn't allow flips (goes to blitting)
6. Due to which setting Freesync/VRR property fails for PRIME buffers.

So, this patch finally enables Freesync with PRIME buffer offloading.

Cc: Koenig Christian <christian.koenig@amd.com>
Cc: Deucher Alexander <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 47e0b48dc26f..db62f3c9d6a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -448,8 +448,8 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 	bp.resv = resv;
 	dma_resv_lock(resv, NULL);
 	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
-			AMDGPU_GEM_DOMAIN_CPU,
-			0, ttm_bo_type_sg, resv, &gobj);
+			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_CPU_GTT_USWC,
+			ttm_bo_type_sg, resv, &gobj);
 	if (ret)
 		goto error;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
