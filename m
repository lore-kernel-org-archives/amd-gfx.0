Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4323C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 18:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FE964F3A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 18:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FE964F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A256ED12;
	Thu, 25 Feb 2021 18:56:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521116ED12
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 18:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFep1kBGf/eDJ5i/PRbWv6aZgEw/aqvywhvp3smKD8agQ9XsXsvWrwe+cvUYmENJanMQERdPJFQyw73HJVBkW6PhuXRDr043+itIxSkk2tMyc7a72zHC04NGkZAM2iC4P+/BEakIch2oLOzvpRHn2wajTxX8NvWWbBLVD8ZtwIyATtjzeBVE+kNo4uw82V230UzTEFVhBhUh53QKow5t1CHBAdySApN63boOWUqdxs8ibJP3qy5kB/9SIRtJX+Mj5xKFGk3yDy8Vb/lF4V8YGATTz02JsUdVK4i5PArV21u/ja16L7qu3IXCVNDIgy5oPXUGOv4ZlPbBHW+8rr+tCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cmx6eDqtVXAKMk+QBK6EY7enRX+j2Xes7gacqMiTIE=;
 b=eqVLAS/tur/VlB+DwABxYXzCRUT+FMa41S+ZUfLp5Wt7XoVLMQ4Jbh3mc/eT/4cd4dzqr1hfiXxG+5qX6DF+Ftiz5HuTrx/JxhQzJPcCIXqvw+59p42dM99FHT/Q0xjQLrW754HqJtFbNYJVt1Zf61ppNc0bBQyjaFc7+e3t9Za55vow205VY5aGxNHBdMqd1SDKWecvKzE8kBLwc9zQb3S/stOdpBH6liqHi4XuAKvGYvSeAVtf9aWeH6wQvcayQ70qxIyXEUXO4x/M9wgjNMPJMRE+7jYiO4H59dPaE/4HHiWR2I70BP2iH6JH1oW1AD6JJnxs7rKcSlp+/vZ1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cmx6eDqtVXAKMk+QBK6EY7enRX+j2Xes7gacqMiTIE=;
 b=iOq5spZ2ZsawiPOUXKyvWwZl7l0ZjcTve17f9wrAcJiuxmc/gj/uwnhYVP6dj/ksjcuCu3sucvf/QmIBWlrpe59C9pyBvY1d1uQV1afC4uBayGsjS0PX0z5oHe5OlKnKlYEQGA25vXHHYsmehm+7fYzdYLc/mwYqeQ7q/M2ur3M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Thu, 25 Feb
 2021 18:56:38 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 18:56:38 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Make noretry the default on Aldebaran
Date: Thu, 25 Feb 2021 13:56:01 -0500
Message-Id: <20210225185602.661486-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225185602.661486-1-alexander.deucher@amd.com>
References: <20210225185602.661486-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:208:2be::31) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0206.namprd13.prod.outlook.com (2603:10b6:208:2be::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.14 via Frontend
 Transport; Thu, 25 Feb 2021 18:56:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 078f9afa-292f-4c7c-53de-08d8d9bf14e1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB445613560BC6288369DF8162F79E9@MN2PR12MB4456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEwaNMv9cauNTkIuktUeCK2g9QuKLNqSA8jbX3gOGBQCd8/kMMjv0ewcWWs/H5HlmTqFGr7Tf43NpKZaBH0aInp3SxSNM0ACAA4pHfH5n3+v82OWJbkIiAJb44FrPq/AhdOsMboAal0xV8LJZQllSr/KMJwxfTSo6PPmg5+cKEVblYWMr6znJH1xyhDI3aL0vZMEltSvILw/wYPlzqFZFe4vRiV4KwKnz76XWIvqo/Vwbufgs/o3z7UGmUb2MWHqrDhMlM5kzVOyDNf+ybIY4Zt9QSoJfvAy5f1cpFc6SQDRK8lv6JPJxO/gCbwZT0EJtytXMH9gZvFAmmfBHc+D+eGI44QzUYq1xJdwECxcH4aHJ9AdmhEukq+plfUNoenlr4Dm/JnXri/qGxj8xqIwxQNqsOsAi3vFAxSZFfBhJQuXgSKuyZWSgOJOoxZjoGsMbf6BzDrvIGc+wflGH8xuYigNXiweoU9rYw+I3Wgx2IWvZ02FMfNZ4PYHdyQQ92Mcpsws2gRqsDJz8VOt00UzRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(52116002)(186003)(6486002)(26005)(5660300002)(66476007)(54906003)(6916009)(956004)(16526019)(7696005)(8676002)(36756003)(2616005)(4744005)(316002)(6666004)(86362001)(66556008)(1076003)(478600001)(8936002)(66946007)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ANISc9GFLJcAlzoYt84Asb3kQ6nKTjha1IeKSOp1458KCBqPkophvLBA0amB?=
 =?us-ascii?Q?I58QnwnCXL+brp3452O+cwDYPV7YqL4M2V1w/1ROLUa0Jpk/xHvoKV3FiS3f?=
 =?us-ascii?Q?6woV1Fby4axchfAfuTnePyR0aGK9ACeFe107I8NWG93lhs8RTOpB27jKiJRa?=
 =?us-ascii?Q?6Vd0XftX5xapGO0LpJJRGn7Gfij/T5ZM3mOclLsPYlwlttAp211QkxA0gjEE?=
 =?us-ascii?Q?SJTOvxa6GvvrEEHMnTUhMRvKK8hJGCFFipycbe/nwENBaHcuAabepSAZYhx1?=
 =?us-ascii?Q?M1zo8AWIrBMxueKi/YoAZ+G/xgNmoZXH56WHzJ53gpCUzA7yZ+ZTSDsRYTz0?=
 =?us-ascii?Q?/sLhFGmXYt7czE0Dz6VvIllAw5SDw10TPmsy1ZHzQbRrlXVt4w6PVUk9VSXa?=
 =?us-ascii?Q?rR+rdiGCPFLHp+sk3ZyjSSD2jLsPKKvjinBDv87MAhvn+T1VCT5br9gHzQGz?=
 =?us-ascii?Q?8Ucvf3tjIZrlMe6nRe+pegPdXrkpZcfI5V7mruxrlap2vUvebITVhZWj5xu2?=
 =?us-ascii?Q?IG4I5i4kQ4jEdCXZe4ti7t4vyoBSXl9oprh4U7shpDeiY5DfLjbcxjkmLqWE?=
 =?us-ascii?Q?If4U+S9jU5rkO5Vcz03JFm2AhDb9pALeCmRQ7IADSQbMIGDaql8ciivDlMkw?=
 =?us-ascii?Q?5f3DBF1PHB/yvjusqi+xiV9aidC4nrJUTbc2WJBQGgQwyyeDajlxeNxEAbDU?=
 =?us-ascii?Q?BaBYALtPMCRRO8dqtOQ4u20Ws/4nw1ndL6CeJHv2QvWWto6zABbdE4YT8ttE?=
 =?us-ascii?Q?ZpBHOZ2+tp4GcIJLwRkYUnJtC/Uj8jhdDDc2R74X+Zltj15kXGTnBhlXKXAB?=
 =?us-ascii?Q?gmltgB3MH9PyuDRnx+jf7pSh/z4sl/e6YzASmfx+42aLMbisNm52h0d4smDh?=
 =?us-ascii?Q?PyZw4mrJe8x40AFjHpOkv565Ir8rQMYpibdjSOqQZ+SLmpOXR0Mf42rwnh4X?=
 =?us-ascii?Q?JY4Dp5J1s6hBvYesuYLaKiZ/ZhDebC1/nsgloP8eLJV8RU0ivxRYnINvLQdU?=
 =?us-ascii?Q?7ri9Uk6fe1bsxjA8CavBUKibEYWSxn6/7c0OeU9/Ea+GXYiv6LXll6udrUf6?=
 =?us-ascii?Q?pPwl+g2rwk4fi1LL98dPr4WM63V2QPgISBq8FBc+3irQg684hJXwgEg67hcv?=
 =?us-ascii?Q?8euxQGtqTqai3Ovv6Yt3Alk2YJVETHBqOFZ9kvxTgCel2FVRuOEJQayzfCMh?=
 =?us-ascii?Q?2Rd/LEWNfuEhd1Pgb7QWvz52r9tfFlXZWD2DbCQ55fQwajm6L05NEInR7JxZ?=
 =?us-ascii?Q?mkxKt9Qu/mGHz+gGBo9HSHqjZi7Ck8tJqga1sZLoUUZV3i5IT6/v2c4GsF00?=
 =?us-ascii?Q?WDasjrUnR7iuwvvHoUlInGmS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078f9afa-292f-4c7c-53de-08d8d9bf14e1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 18:56:38.7646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dekut963Aze6ENfnujNCujUVmHGcBTcSCQOUJzuiIswClkvcwRFelR2BzXejEy/UEn35/4wLQyijVHMHA2sBWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Felix Kuehling <Felix.Kuehling@amd.com>

This is needed for best machine learning performance. XNACK can still
be enabled per-process if needed.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Tested-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 6d9c660da27a..8a64f5e49cb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -508,6 +508,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 	case CHIP_VEGA20:
+	case CHIP_ALDEBARAN:
 		/*
 		 * noretry = 0 will cause kfd page fault tests fail
 		 * for some ASICs, so set default to 1 for these ASICs.
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
