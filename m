Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DEDC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AF061453
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AF061453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6842D6E9E0;
	Wed, 21 Apr 2021 19:41:13 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750084.outbound.protection.outlook.com [40.107.75.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747D96E9E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 19:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtokLnvhsVNXa1eiKkoPZH54XCa4mpsQLM1taGveGcxy790L0Bm1+Oi5tz45K580D8kvC3AGXNbW+Fof3hzCTpCEZzfpCENa7zk5sfKw1omSwNvGzI2LojmoFOvNJtnujMm167DvLeOqgquz/u+z4hP3YfTggKxG+0zQyCd60Trr1/Ue76pXgn2CoAMAY7BKBc7SWVBtsQ+wnqtif4M47rqorASTN+kwOwmrfuOEYhOUd8gswrsakWpcyifTjpI7freYv9Q7JRaZVgAw/4q+gAtQ6JefkYQZ+bD4K7bC9viWJ1TGAz833dqTS1m7Xatsi9Jqgom+rO6fZjCQ1NxZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmKBYE4qXi5Dx6sGyUyirg2aRBVBpqucZ7onWhJX//U=;
 b=RgunCcxPgdLbX1jyyHzX7JpVj2nqPnzWnJ8lyvnMLT78hNtEjBJTSyiFxOd3zioU4HReBwOyUIP4sDMzrfwRbN5CKYHhYY/c1DJjVcsLftpraZPCkoqQWyYF8L5/DdAtvCZkAHcsqIqdN/xgIaILq5tVER2fCrhrCBCiASdUyq3elux1LmUN1QvYVs3sq1CZHWkyZQwkcf6Wo2lyQGwBtsqjLltMrlJgVQK+6omtgzeh7boDOFlW402NmDZkY69kXlCBmO9sfJH4vfrZjYHWlipVpwh/Q4agYTaB+Ub/XL5OFjuiZmySIw81oqVcGyF4vRvhmPKEbrqiaTm2DHOFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmKBYE4qXi5Dx6sGyUyirg2aRBVBpqucZ7onWhJX//U=;
 b=S5EhLB9HmTjzRy2frRlNrNAa4xzph4R56OftdtZbvEemgGi/12Xo5NUhpG7NzvUBS5gXzmxkkF6QkuDAVGpoZOROrBdHkF7BcOMbIWnQnpGEe5SvIkjCRXAs4ziRpG072DTgAF7mrh6L4z5HMggQ3zpSZzGmwgzy9DhT3wqd2UY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 19:41:11 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4042.019; Wed, 21 Apr 2021
 19:41:11 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: set attribute access for default ranges
Date: Wed, 21 Apr 2021 14:40:55 -0500
Message-Id: <20210421194055.15893-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210421194055.15893-1-alex.sierra@amd.com>
References: <20210421194055.15893-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:806:125::33) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7PR04CA0178.namprd04.prod.outlook.com (2603:10b6:806:125::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 19:41:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f70f426-2863-4e0b-2093-08d904fd6a80
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4413FD039BB8A1DED4F14570FD479@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5UuY9Ybk8U590xAdDPlR5PSaUm77ITUalEWOIXy1hQs/WDD+rdOv/i8k/1VhHsmE2GDuE37At5gyZMc4bUda5kcAhnx8tPUSZfT6fw3dXMhYK6kKwJlzNOj0CtRwpoNzOU0xgxNj4K6hSQmMRPWUwuVxyYw5LbFA6LWoQrkm5yySmGYfb0HElVK7CQDSvHUShav98g1xem/JkFY0GEQRm+xWXP18Wi/q8CkG4sE9D5IupJzpos8eB6CC5XPlHJiSFtqTs5dr9b65mq6coxHil5MQ/2+mVAQ1FXOwtue6ilowUO43H4SokdGFoIKYcgV0s/ULOf7NJPvyK7Bogp5umiKYnVChjX9okUdiIljnpAKXqbo0ERdLwVlSmP72XfeFCACRyQL2BGZTCUBqNUPjHlt0XTKuhrlhJX5KTaDKc4172TEbrw+fuT1UNk6TkYYVKLeShFWYWSDN5uMHu1CMTveEcdc+rdGSK3pHsS36sHw1cRNY23j3zdxQVYr6Z80nvdiqaQvPqE6deHbk4WGDeNMv9pwSBVc3pLF/lzUuLJn47m26YhzeX7YjsZJsjEgCPFvgkM6HzwHXYsp0dlyYMN08yrsQEx6JQZbLYHD+oUTfi6YWA/fd0W+FmmJUYV866pFmg8gR9zPG1dhbEQBKvRT9RmHEHNqpeGX9FXKKPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6486002)(478600001)(5660300002)(44832011)(6666004)(956004)(1076003)(4326008)(2616005)(86362001)(7696005)(52116002)(16526019)(2906002)(6916009)(316002)(26005)(186003)(36756003)(83380400001)(66556008)(66476007)(66946007)(8936002)(8676002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?43i9Kogn6Q9tJVDTYiuRlldMKcqsJupD1+LaZnkTlHAsLsgfrJ0fbBJ15Hu9?=
 =?us-ascii?Q?cxpEjvC3Jn4JPtOgp8lT4qtCVpVKxH7xrlY3riqbG7VubT1pb7GLwjUqVaJw?=
 =?us-ascii?Q?+N1ZD+sygJsfk3sFdjE38h5fxqBWGjDr4QN2ITR48sEVsy5Foa6stGNeTWH+?=
 =?us-ascii?Q?QNMj+qmABTFSS3FTuXTic8eqlRgHxHpTquU6EcOR09dnwy/V1DdzButb/Up4?=
 =?us-ascii?Q?jjynIYFky/YyiiR7oVh5D+LIqs84/gTHNelNap30jHSX0Wu7/vux6TJTlTtj?=
 =?us-ascii?Q?5t/7rv4TIUWw7yEeO7Qtpfg6E5uPwZ7DON9iOypSWeddSs83u/D2kwU0nskV?=
 =?us-ascii?Q?J+yMf72F0kjvCUI+7kn/p82e/8vvdj42ijy8bz4hqd0CA9r5D8Tn0K83m/aG?=
 =?us-ascii?Q?QH3TmF51dtIFg8iUinDEiZ9HykHMAsow3/UDRBNzYHXrWhqVzcp0CTIJ1mqQ?=
 =?us-ascii?Q?hj3rFt1xT3iOQFXjJpPeOKhyN/JyWK7mjJgFk0zuj1Hh8M21X8xDfDUzgKjn?=
 =?us-ascii?Q?GO4gOUgLSAap/dGdu5uS/a3r/X+einHZtOZIhNARN7mjqeGqbuefaa0fBxnq?=
 =?us-ascii?Q?jKasc/nweepIo3oRwNxCA3ECJ6TWdsWkw+1mJ9fYVYZYFBr2D0JM9eH108/N?=
 =?us-ascii?Q?KQ1rV8VnkHtL6tU6UNhtrAXyjR+tY3H1l9ISklwKTfZiIRKeibBzKxq7Q33f?=
 =?us-ascii?Q?IrC/R3RohC8TAa45CeeBYX6VaUOin7gOHLhndpGITTSqQeuvDS6ek3J/qxd2?=
 =?us-ascii?Q?rfsGpC0VQSIKVOrO50q+WXG7xRok+0I2p7zklBKj7VAZUC1OqL4geKW+1QSn?=
 =?us-ascii?Q?kR7w0hacYJxmbsm0y3Inw6CR6r/1D9PHii8cH9qqc0u2YFTRuG4I/B9vIrZX?=
 =?us-ascii?Q?7MpF6WkmVT3c/0H45RYtvRRWjTWSi6xklNTiK9E53Ev6jsjqNJUMtH8+QfrZ?=
 =?us-ascii?Q?i/524hmtaGq4KWTh9+GxYgqAcuzmgc2+kOrg3im6dosZItlX8YS7GknZXI+g?=
 =?us-ascii?Q?wVITGeZXMFPnfFmBObgmr7fkGuCQmpKqrLzrJChkTS6TDvuXREhcVoptrvSj?=
 =?us-ascii?Q?qWqhFKpp51phMCaAoR5gvs3jk5jxN47cofjV3q6i4cczhM4NwEYsHH4kPUOd?=
 =?us-ascii?Q?pYL63kwUlJOxUsjGOhgjk7OAVrs4P8k5dqPUFZeIxpld/3v0Kh6FNS9whw3v?=
 =?us-ascii?Q?Z1PsmojUx47dwlcAA3I34nR5xpvVGI2yGFBSgUOx4/STWlC9WvG7/Wq3tKyU?=
 =?us-ascii?Q?HF3d3l6ssmPEIuMDy0CflikRAgS0UAZyS3Ziyw1Egvnq6G8UzlKmixYZupO5?=
 =?us-ascii?Q?CKYgLcUE8ES+iwaDz2ML4NvD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f70f426-2863-4e0b-2093-08d904fd6a80
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 19:41:11.1506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fan6S8709XjE8ZjBNwVHRKSnpdwgGpHRgrCwwFkYPPj6Ph8FWFtR7z8RscGQrw6q5dIdJny2YCOHbiLGd01JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Attribute access value for default ranges is set, based on
process xnack on/off.
XNACK ON has GPU access attribute for unregistered ranges through page
fault. While XNACK OFF has no access attribute for unregistered ranges.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 99dfbd2dc164..783a889c5047 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2963,12 +2963,11 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 		pr_debug("range attrs not found return default values\n");
 		svm_range_set_default_attributes(&location, &prefetch_loc,
 						 &granularity, &flags);
-		/* TODO: Automatically create SVM ranges and map them on
-		 * GPU page faults
 		if (p->xnack_enabled)
 			bitmap_fill(bitmap_access, MAX_GPU_INSTANCE);
-		 */
-
+		else
+			bitmap_zero(bitmap_access, MAX_GPU_INSTANCE);
+		bitmap_zero(bitmap_aip, MAX_GPU_INSTANCE);
 		goto fill_values;
 	}
 	bitmap_fill(bitmap_access, MAX_GPU_INSTANCE);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
