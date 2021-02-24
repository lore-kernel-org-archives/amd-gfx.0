Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88738C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 442D064EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442D064EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE286EBFF;
	Wed, 24 Feb 2021 22:23:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51166EBFF
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLOToXvCf2v1LJLCnj01egnaD52blQSPDz0bNufTInQ1Zg9hIn7o4ZLJzOw3XQqeVkOcJWYqYgz6H8UwHWIh7MCrWo0BkNI+4kIDH6T1/c8gYLcm+8vJgykyi4qkAZzrQERVO0hr9riUNPlWBggZrf22Fo4rxDc3mljmbhA3ziHZZOhSOz7lfiwctdOK8EPp1JFubzGi7VyLZWnoHKpVyYNrkZZ552/hD3CG5yaADAnyak+627I9tI9/B9RvgSz4Qrbaf+9YXUKxzAeiv+SFrMn/ZN73cTybzZem3cJu4DmrqFWGxEbQLiGYGsd8Ln/OJv8hA18SfZeW32Pdp7ySAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLPacRX+zFszgbrMuCjS5kpmjkBic5xXLIjEup2LFHg=;
 b=Z9XJAVZqBCZ/FRoy/4qds3rSwjhAnRPbdbVHLn5ulxMCb0cTkOTLb/gviGReniu+69WI48iX/Gd8VwzzBcifQJc1MOSlQ8RmmtWAQp8icpWoZE+Z/TIhD583LVD9dpg2NsoA1ve7s6un6dumHqnGPGzisZvagMfI+f2FBabv/k+m1k8x/ddCs67/KLkIkUyB4bip2NhcBXeRLYUCQtg0qJCy1XJLEwP6Bh3TtMkHJzjQ7f+Ilf/ShUS5XB7X2M2i7JxTea+3vwIH9HdgW4ZmcEePzOoi9e1vPx583RJT3rN8CrRRfU4M1wBWOkdF0xwfHg1oGgjb0h8RqQHUGpGZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLPacRX+zFszgbrMuCjS5kpmjkBic5xXLIjEup2LFHg=;
 b=cw5twMvuKSN5G7iUGOPag5n9lX/dRQHVeB2ZAk3UlabLQ/tstf+i67xa0/Qx5TIRLpwO02VGkDlANSsvI0Z4Y0ZE+YQxWsPZQJQY1XV+VVNIlNHF3Mb0psgZ2aOZ9Q9SqUT3VPjpztBgKAImxeLcp4MpJ/d+MXg/cxnFExmwX74=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4831.namprd12.prod.outlook.com (2603:10b6:208:1b9::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:23:11 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:23:11 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 158/159] drm/amdgpu: add psp RAP L0 check support
Date: Wed, 24 Feb 2021 17:18:58 -0500
Message-Id: <20210224221859.3068810-151-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:21:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9402dbcd-d6f8-4762-9ce3-08d8d9127bd1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB483134520EF19912615CD215F79F9@MN2PR12MB4831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiOEixX0F6xtJj5Qlq8+iVXqFOK9spHk2+SfMXu3vvUFrJaLBHvf/pY4+l7D9dT6imnWaNOy0HqL2cU530sEeMwSlpBxGZ/ZQstdBj5zQ74OU/MNv1cXOOQFdGNUJXGBS3qs2RIpJ1I9qYV8ayl2KHlBVj+RigYaCtN3MzNhEA/mQYBAmRqOFJv1MjWDhDgSlQjYz0EfYffN0LM++tDLOHDsibY/YXHkFwTHAG5W1Yg2Jg+kD64ltmuN9V9SofYAwSJQqjYqye8qTtpwLb23YJhRN4qNMRXbXX2p1h0RAH14jKI5TzfDnbAj7mSL2S/qbgFAf1KE0A2kDn0a8dow97Gx8oxGCFHwVWCOAkzm+TCh5jMFrixzPnRbNcM0CG5ejiKf0VJIxK3u4FwYQgIMBuCNVGdomH+N0QArPG6LHrhFz0O08Tnr8gwApGbGBj9qd9B608OHnjaeRSMuTrq3gD7I6ZDzU3nD5ycw/xQZ4P6FjX6bnQgCZdofRh/ajsavanl+DDBOxBPitQNQOP8oNVu6NDNN1rA4LIdzzBHYF+BnVUaxmA9zq+7+816aLy1K23U7HKdZ9e8QCAukHFbIBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(5660300002)(6506007)(6486002)(83380400001)(316002)(6666004)(1076003)(52116002)(86362001)(478600001)(54906003)(6916009)(36756003)(8936002)(6512007)(4326008)(8676002)(69590400012)(66946007)(66556008)(956004)(2616005)(26005)(2906002)(16526019)(186003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/r37jYiwt0c/2XgQJHQ73wwNMBQ6ziK+G3EEhCckH8CuhietX+uw5TW6HNu5?=
 =?us-ascii?Q?vsPHJkgZjqwvBBEkr1CafSiq7otkdaHQ1pzSBnWR0yb3EyoQSzeN+k1U/PN9?=
 =?us-ascii?Q?HDMWq5D9q7cTwVc/XWvM6wN61/kXfSp6dFmtbC6EEWS1f9uF+a8c8D3ZQUir?=
 =?us-ascii?Q?/+GLdN7ghhNHV7z0xTXGSjnyk8o3xxVnu91W3PXlxTYOL/SRoy1W6HKfDE+A?=
 =?us-ascii?Q?9xtw1bk5ADYG7jWZRIsocszqWIYIQKjqOfthMDiPe4hm+MawIXO0IuUcXr+0?=
 =?us-ascii?Q?9swBnShv90V2VC00OcPZTtf8fX8eJVNOKR7UKe5JyNGmN2frrKpGaffs3a6b?=
 =?us-ascii?Q?ASURKX0+1QwIv73FjGp8ooHwuTebbLBLEJhxLQx3JOk+Rr3yBfPqUUXXUflf?=
 =?us-ascii?Q?2t+QqundN99SYg8mJba5rLSjN4VvFdPiBM9VyFDFIwkAsTcav1stN4EkriiV?=
 =?us-ascii?Q?G4uS4qa28gqd1oh08CEpNyqfb0Tnmk3lyLhGlW0Ef6ub8ogjUqX0+rIn73Xt?=
 =?us-ascii?Q?d4bGlhZLAWFZh3xcin4D39Qxgk4VQTGUyxuh1+C7Q2pfduNp0Ssd11DaQkBv?=
 =?us-ascii?Q?xI9fD7Fv9jx23iFTeFVqbxW5lNKxCV5XuStRzWoC1wEzEgpPXqMbr1Pgmr2n?=
 =?us-ascii?Q?WLZtsnddRQSngwCZX6fxxzfTah/l+EdU9iD9FClvSY/deAq1gTh18c1mI+y4?=
 =?us-ascii?Q?1y3BXxdTWQT+raJuV1U1+FpaPn0THiAkMHryVS+SuqlcBOcRO1f1CyMjAsaE?=
 =?us-ascii?Q?Q0opUMcSsIQe2Y3aSjCWLeqUHnTq2H34C6atHVoMy94H1dUhiliZTJGH3aLi?=
 =?us-ascii?Q?9ukv8Myr+UkM3ovBymU0Xjq2Z2ttxHS837x3hN4W9Tha+mu3MPtp0RubOVLH?=
 =?us-ascii?Q?zDTwnEuDfOVn7qq7MX1ZisrbkwbytT2AKSsFKFv8oCnmYvTZXREah/gI5NCj?=
 =?us-ascii?Q?iS874ODrWEPStSCMygS3vaMk0X4YCvNj9PTpjQs8XO1WT1+iesNxpue2d3x5?=
 =?us-ascii?Q?MlIQIeYnc1dwsfepiC6GoSr2B7pGkYlmV/t3eXH6G9jJLcKfAHft+Y0CzNmR?=
 =?us-ascii?Q?oGhkrzWdIfN2jZhUAyNJbSegLGDtaCPf5tOyDiNnwePeLGvjE69/+/x7OTmQ?=
 =?us-ascii?Q?rmKCiNWR10hdh34CLWUd7WDfQHZoM/R1rwASwAsEAlYoInaO0cbI0fVbhPYA?=
 =?us-ascii?Q?ZebmsjFLL80TbMPsz1c02NPoXY4CVmbXhNoyVDFukzRCw34Hb2cpAzPK72lH?=
 =?us-ascii?Q?pw3qW48mc8LSJ95mg21lUFoBK2jqAy2ZIYs2Bap34/SFo8pw8WZpIJMuGmik?=
 =?us-ascii?Q?/FwfA1saKeeWg9p1LaxAP5zM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9402dbcd-d6f8-4762-9ce3-08d8d9127bd1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:08.4869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJsrfqS8dsixnf7J9o/g2pmZ7hYGxRGwNe3Of/MG6Lr6r6mlt43Hr0125SopOpEj/YVasO0UtB1NxBW9k/trZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4831
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

add PSP RAP L0 check when RAP TA is loaded.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index bf83625c6d20..3f2acdc839cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2363,6 +2363,7 @@ static int psp_hw_init(void *handle)
 {
 	int ret;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	enum ta_rap_status status = TA_RAP_STATUS__SUCCESS;
 
 	mutex_lock(&adev->firmware.mutex);
 	/*
@@ -2380,7 +2381,14 @@ static int psp_hw_init(void *handle)
 	}
 
 	mutex_unlock(&adev->firmware.mutex);
-	return 0;
+
+	ret = psp_rap_invoke(&adev->psp, TA_CMD_RAP__VALIDATE_L0, &status);
+	if (ret || status != TA_RAP_STATUS__SUCCESS) {
+		dev_err(adev->dev, "RAP: (%d) Failed to Invoke Validate L0, status %d\n",
+			ret, status);
+	}
+
+	return ret;
 
 failed:
 	adev->firmware.load_type = AMDGPU_FW_LOAD_DIRECT;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
