Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A505DC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 03:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4113F61184
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 03:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4113F61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1CA6EB1C;
	Fri, 16 Apr 2021 03:23:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C8E6EB1C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 03:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJPIxwgGhzeZBbNdONKquU+fxL0cMuvxsJImH2hicERClX5fkCzMksGifb/y5CFfoQpcHDiTFCd0yu0gQaz+rRP+f4XaAJu39wTmYmA5GuFP0ZSKlsv0TuXMfp5KumOKUqc8ZSepbxmwuHsBSruzslDJaPF7nakX/+2XCrqJpDzSssjsXIOYL+dxefjQxNZcs/YFOd0wTp5jtxIt9q0I0CpIPvX7v5XzdUEhCjd6Ue00yapOK14oGtgt6q7Vhef91PzFQ4PiyptLGjVb18a53oEyT/3Di+OhjlvwwZn3eU9N+33Jf/aXlhnXfyvVtmMwh3OF2nuwJsqMh3W9pO72EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+6gczte4kqt27CxbOAn9o6zKN3t+N7g5jz/POku62s=;
 b=hiSSawRNx2nY5JdBwHKi2xHCOfkUtslw8cGxIw84Rdyy9jwK5545BNfYFFUIUomVY7EsZA0qiefhPcJHJaHC9He2zgqERRyHubPLZZUZVGuQsrT8IH2yuZgs3CwxoPfCkIR9JCiOYGnij23tlhfVQMncEsMStNSNftxM175c5POhuT3btHVNjHllhYWx1YmSVoXaHnxQfjQo5giABLwIYKAySMokNr+pfpSZvuaRPJjs1EuNkRqzkBvOQQHB1DjUmZfFKQRFvnL68VzNEY0UAd0VT9RMAA32acnqIiSKlPGAJp2FgZ//Cb/xOnF52FIjrFboGwTbwBTSYNdT7Hyrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+6gczte4kqt27CxbOAn9o6zKN3t+N7g5jz/POku62s=;
 b=mjUHXXk003N3Tg4gvf3N/1o/fGZC7iRexcA3WEqu4DpER1EztEo7+jrD6kRdnmVMRqNQe80BrcTlJi+/ewmBtXr/Mw3QelIpsoQCHKMEcvJIuVwduq6nHyZyHXtHGRJYNkfm65CYkN0Pur/uGWgbzJhNBYH2ZejjrbdogNxHLu0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0045.namprd12.prod.outlook.com (2603:10b6:301:5a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 03:23:44 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 03:23:43 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable tmz on renoir asics
Date: Fri, 16 Apr 2021 11:22:30 +0800
Message-Id: <20210416032230.2681740-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:202:16::15) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.245) by
 HK2PR02CA0131.apcprd02.prod.outlook.com (2603:1096:202:16::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 03:23:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29b6b3f6-86fc-4070-1326-08d9008709a2
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB004514D35D90BF06C3C00C18EC4C9@MWHPR1201MB0045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8hqKnjbP7spo0ZklqgLGQfkKDeOcFagoAYFQbSCdjlAyvmKvzNai6KsEFYtulASX9ymT2aN7TxAyNZvSOH/pjZ2/ZyuteVP6daxiGK+uzOpjfDnt8lS439SfRFZp6pPKEK1GJOzLwxlFt3ZgECw611gO40DeSWdUgCh7nhIH7NL6bJNzMK9GzUi6AEIASBGwDCERiYvqalyii48AeiKQ3n7QP2BZ0ZEcm5hGILtKijvEiuLJi4V2338XNp8cq7egxd1JpMiXv3iX7XsMf2UiX4U5EFSgSSDITVbHrC43oax3y7rPpLHm3u4yKupDBz0Imd78kqTi0/+0J6kFUtBgNEpeT8mf3Ys04vr+R2TCFXEIb4KE3D33nwh1YLgUhizYijDV4MkgE88OTyB8sk5f+D/9I3Ig0xIlmcC/sstJqZXvA6RQRVDPnaYSSK7pp17bDZLerpf0fAdj7+ag2OHoGQDEY/WElpuYz8WppyBPXsYApx+0FyvDPFen3aSHreYumsHDFEYe9oI/O+k0/7L5cQtX1MkGHVZFzn3jfL2xQogJoGiyaRBtM6UYH2JPjCnx+L6hN7Z9m5s3hWhJcIlxzZoVVQuXMXTZADI7bOa1/5K5EbetNIvuYhc1CP20tXgRpm2NkKEa8cLWtgv1kx9M/61GBqNPts3cwFw/wE4EkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(86362001)(478600001)(83380400001)(66476007)(4744005)(66556008)(66946007)(8676002)(186003)(38100700002)(16526019)(26005)(38350700002)(5660300002)(956004)(52116002)(7696005)(8936002)(54906003)(36756003)(316002)(4326008)(2616005)(6486002)(2906002)(6916009)(1076003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N11sKyWxJ3kkMqnOD5fM48OKzTEQVPuDZxXEM9qLemCO9JW+Ip90Gj/paMrq?=
 =?us-ascii?Q?J5gmc6liOiaPqELmb5N8Ydlo39OsGSDeY8HASEfYWBuOWIIXbNw3oqsfJLig?=
 =?us-ascii?Q?8suBQSouagqDkp4ARsuubgZ6IUeaQrSv8JdOAIwoPg9+99oNIwg10/2GTD7V?=
 =?us-ascii?Q?NG98HZuEct0LZpzkGLBRT1ilMoVjuaQcKRcR2t7AybQkmdqMe363qH77rSpg?=
 =?us-ascii?Q?wWu098wNQ1kpo+IdDntJegQssrnM0Sn+FpNvKorBIhUW2mvvFAt2sanJG/US?=
 =?us-ascii?Q?HkjU8XQblbKycS78XRvnB4BgOW90nX3rmosi8do//Gsa6GqJNprdG3jYe6S4?=
 =?us-ascii?Q?d0duQKPewi5GWmfihCQH57YVMyjNsFY11oNEyTyFhW7qSrDqIkJLukcVzONF?=
 =?us-ascii?Q?1KbGneMZEYEf3laa+XrA9OswIY5Yz9miCo1gwWGgEcvFm+QKZrcRb2yYqYzs?=
 =?us-ascii?Q?lUoasj8WsEjVLp6NaNkirB47GVK4TE1/ZTPJRZFR+RQUEv/rW7y4kbjGXaZr?=
 =?us-ascii?Q?0VnGxBSIJ7g1vqvF/4X3hXYfoeXg/DlRQ5/oHncPE5rGF/JuNnM7DR3IVzOm?=
 =?us-ascii?Q?eCZbfpFlzqTcDYOhEJnRx6tDDq2eVjnRqqFkfRPepP8pev9Yxx5ySl3z6/u7?=
 =?us-ascii?Q?98BdLCfq8or/cDigbyLwLbAOvwye0hYm7LivfZT57BQcLjFnDBLNcGTgc7XI?=
 =?us-ascii?Q?6F4nTTfCIjU3LUAMBB8MHu9qMdupJmSJFeUKVVG0aT3qmHq7eZS8kgeAlgQW?=
 =?us-ascii?Q?amo4/IiIINcJw+8yWVoGbP0PEqQsTlZ6TAebTD7arqPMJjZQNqYzqHb7Ft/J?=
 =?us-ascii?Q?QueEFd9pcNgwXoSV876V8Qx43wpfgwAvkudNG30jQsS7mbgxMt7eXFfxGnpX?=
 =?us-ascii?Q?pmeULIS/iF7567iex716cklYDwJpU4VkO74UmJT001MzxGHjaS7OwKAiYqvH?=
 =?us-ascii?Q?BlDKzIQoCwlBJFkW3b6OdOG9CsmSY1chMr8Gx+oy+NNgwQgODCCj5s0Teqf6?=
 =?us-ascii?Q?gIqASd8go2fogVZhqQRWuNJ5JAb359L3UwLUz034LWSkiQ65W1QJ74vLsrAY?=
 =?us-ascii?Q?PJK3yKIAqGdySuImPqraqH7C4TRyh+DfYvZIqDWeIQN5MlBZB0P2hv966CHK?=
 =?us-ascii?Q?HiFt8k9wFRqN7XhB3vMQRm8wITCQnZDGingtn65eWnboe4CDOh43DHiO54qU?=
 =?us-ascii?Q?20/BGD/Qj+f1frrUJrflp20SIxAkdGhs+xkinYj+dmU01ceONNpYkVQqJaze?=
 =?us-ascii?Q?EpMEXnNfRzR1VgMWP0QNhmPC957C+rjZgm/7W4mic5ihueGvvmpN2LGWFE6F?=
 =?us-ascii?Q?rGYBEKJSkPo2gmA5nqXhNIBJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b6b3f6-86fc-4070-1326-08d9008709a2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 03:23:43.6565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QuIKB1J6UF6TRsiFxh8E9gsYtn3JePyY/uPVUgW3NEl64wGLWPyiAKmGoO3jhyCiTI+oSabPjFEnCdGZJeO0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0045
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
 Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The tmz function are verified on renoir chips as well. So enable it by
default.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Tested-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 1197f49eda18..c39ed9eb0987 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -487,6 +487,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
+	case CHIP_RENOIR:
 		if (amdgpu_tmz == 0) {
 			adev->gmc.tmz_enabled = false;
 			dev_info(adev->dev,
@@ -497,7 +498,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 				 "Trusted Memory Zone (TMZ) feature enabled\n");
 		}
 		break;
-	case CHIP_RENOIR:
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
