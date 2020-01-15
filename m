Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB96EC33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 13:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D3C72467C
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 13:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fDjTchss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3C72467C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A5DD6E9DB;
	Wed, 15 Jan 2020 13:23:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3EC6E9DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 13:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKkEEcgIFpRyqOjS+Xq+iwbwYyDpMSKvHo2OZFMFAxId5aKq/Ll/SjJoxTPYDTMGj8FASRUr2qW8AopqdKrHJ4m9ManSJHKB+6MkO9FkbgGY7iw5Un5Y+Sayli3jNn9zmhCV/dEUu2DP2a0lcCcVOzlTJBQ/+TJAyc4HN8Opjawv0jS9EwRd3l7PtWeTt4AjtrZx27+ZM6nHSEYacpBSrk4tLrql+RsEBFdgUh5w1JaXFmRmS1ce4B/dJzVEWHOHOMttqyGxcfy3PzLZ4KB/PQZ8QP899FSDOsZ02XmzDfOTplprtuU76WqvKE4tsr7IyrA+SkOx3T6XTVksWZzzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRjJChEUh6E9PdO60lum/ewDgf7hPsZD47vBMKbZLSo=;
 b=HwER9Ruv/Uk0TxIXfwW8JZBFhvVSH7bcRB9WYud1WtlqQFgkS2oighhiTNo54NFbgyNjPEeOLxlxmBwFdWHlCeUkBwPnL4FVafuCAeylC3Vu4RKgy592BFD1h09zyooWKN4rh2BdloynzGV7aHU0ygWM5F/GMa47WImkAN7mj6jucqxqR6Cea5XPBOu+h47040orNccIYTUlhy8oEFFAb+kDvKG+k7TrP/i36+KzbppzkcAYBJcENyLk7Q0V0IB/5+xF61orreVqn9hSP0hmfE4JFt1tsIPxEy1hntvOT0pR+DzpRAfuA7/dDOjEPt3Yud+hvuOOgWS/BoLBoz4waQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRjJChEUh6E9PdO60lum/ewDgf7hPsZD47vBMKbZLSo=;
 b=fDjTchss+OhOBL4T1N4NBZnBLh6yaZstOmHJohwkr/mRowjd0OQtIDlTvpPcRGn5R2iW0GaocGlmgyDR8nJKweN11MlkJonhSLp4modfB0f9VQvj8FITZKERWNSSYk+W7XxM5XyHHunt37e+TfNQbf5/lUqkHjqfTxRmBFpJ9yo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1307.namprd12.prod.outlook.com (10.168.239.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 13:23:03 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 13:23:02 +0000
Subject: Re: [PATCH] drm/scheduler: fix race condition in load balancer
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200114154339.3519-1-nirmoy.das@amd.com>
 <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
 <862ad550-082d-7ece-1d4d-99801ab10428@amd.com>
 <8b4d2ea2-a28d-6eb4-2d50-02b5c450922f@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <a23d0e09-dd32-fd18-9ea2-a5bf724bfe7f@amd.com>
Date: Wed, 15 Jan 2020 14:24:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <8b4d2ea2-a28d-6eb4-2d50-02b5c450922f@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f2b:bb00:33a:7193:ff09:7830]
 (2003:c5:8f2b:bb00:33a:7193:ff09:7830) by
 ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 13:22:44 +0000
X-Originating-IP: [2003:c5:8f2b:bb00:33a:7193:ff09:7830]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ccdf7e33-ef3b-483f-ed14-08d799be0c52
X-MS-TrafficTypeDiagnostic: DM5PR12MB1307:|DM5PR12MB1307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13072BA834CF78A4BD7735388B370@DM5PR12MB1307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(189003)(199004)(66946007)(8676002)(478600001)(2906002)(6666004)(316002)(110136005)(81166006)(66556008)(36756003)(52116002)(6486002)(81156014)(8936002)(5660300002)(186003)(16526019)(66476007)(2616005)(31696002)(31686004)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1307;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIsYvrrZx2nNicR5P6ifwwmCY4RIB64mQgcw7x1PHc7XlN211qPWpGzLqSY9gh7Cmp8AV3HmKgj83qKf3DmE1TvC5otfZXunJIabF8cGVZf8TM2zaSpsCmP2zEx6151tlk8ks+2N/cLWHpD9cGM2pVTKKd3+TOZ8HWA7R/uRzTWiaSlA1d5KQja2XjZsVWPTAy6VRa8bSQUXw+C82yyajQO8XaK6jcdrUpbsRiAWpveMJw/4afBrOyyT76bVZ61Xrey4hV0wo8wFi8uzZte12dEyy6pEMXfbeBZDl77HEgJ+dKcOAARb5rDqaQ87uS6eHQmiVng8TnakOyJYs8jGbVG/554/7is8PYyUpe/7aDSQuRqiodUJVOQVBHwsjruiYxOCsveaw9RTpOdC0Lgx/gu7+HomRndhKxcsDMHi+I33kVtFs4vqAoWxcE48ySwH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdf7e33-ef3b-483f-ed14-08d799be0c52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 13:23:02.7860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JU1Olh8/hjU+YEqgYwSxVMcQyvGKWRUBzCC+Vr6LzyDYFb4DECyu46I3+LCTFSEacPNj1B7DjoCwqvMcxKfEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1307
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 pierre-eric.pelloux-prayer@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


>> I think I know why it happens. At init all entity's rq gets assigned 
>> to sched_list[0]. I put some prints to check what we compare in 
>> drm_sched_entity_get_free_sched.
>>
>> It turns out most of the time it compares zero values(num_jobs(0) < 
>> min_jobs(0)) so most of the time 1st rq(sdma0, comp_1.0.0) was picked 
>> by drm_sched_entity_get_free_sched.
>
> Well that is expected because the unit tests always does 
> submission,wait,submission,wait,submission,wait.... So the number of 
> jobs in the scheduler becomes zero in between.
Even with multiple parallel instances of amdgpu_test, I haven't seen any 
improvement in the load balance.
>
>> This patch was not correct , had an extra atomic_inc(num_jobs) in 
>> drm_sched_job_init. This probably added bit of randomness I think, 
>> which helped in better job distribution.
>
> Mhm, that might not be a bad idea after all. We could rename num_jobs 
> into something like like score and do a +1 in 
> drm_sched_rq_add_entity() and a -1 in drm_sched_rq_remove_entity().
>
> That should have pretty much the effect we want to have.
That's sounds good as well. I will create a patch.
>
>> I've updated my previous RFC patch which uses time consumed by each 
>> sched for load balance with a twist of ignoring previously scheduled 
>> sched/rq. Let me know what do you think.
>
> I didn't had time yet to wrap my head around that in detail, but at 
> least of hand Luben is right that the locking looks really awkward.
I was unable to find a better way to do the locking part. My mail client 
might've missed Luben's review, can't find it :/


Regards,

Nirmoy

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
