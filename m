Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8C4C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 12:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2526E64E85
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 12:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2526E64E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A582D6E3DB;
	Fri, 26 Feb 2021 12:05:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F02746E3DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 12:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2Tl6Llv5aTKM+JM9JQm1kBgh1kpTsfEUgAkefu2rrRQrbE9lN1Vl6gfF7euG/DLVK1FiWeAi5OpSHbtY6n3Tm+G+R9u/OA43KyTLAaS6qyZOp5VtOZ42DYxmnOUXdmabCxxqGT9SGYmh49zWB552Y00eBZ8zSdjABmcr2DDfLOeQkvQm/Tvg+O6ccRPwlAkmSyEaonSRYKNd4cO6/viEm7L/BOr1q/btaiekdgwVQFFtpPIjN16ysa9acDVJ0lpeQOWM5epoOmX/zvBPmT5dqpCh/QjXzLMfHkHK33zezwR06nqX7cLHGrgyR6HSE6bhlgIxAz6bzPixybuchvOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hmJMX+gvQoqIUstpN04tSt1XFPyy41WWJ9tlHjHRX8=;
 b=BhRqcsezT0V2xVqzFGK8/Ieuu/mtMjmFGMMKA+xgBGn+5ODqdwqFYnZpIGyk7dhQEtmUoDf4Hx3wHsVFG+YrYSz01hS4j22048+kvt/iUQp0YLHyNBFgixSTNyNG80S5vRGUB+pZusxxPapBPFHHcseq0Gkv5DjGozo6n/ek++MtmOILuxfIReTnxPL735/0AVem/rryfwojhk1jOHAkwJ9lBv59vP9xlEVtkOLVA7lSl4fxAFP0TQchqj3woSrdfIqbWLxOV0JYOcaNlfSKeBTGlcPPaN2NH5GHYGdYPEZTbUg7ipsTRoVYLjUPsCntPvDy3u4g1IeSNCvmi/3rVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hmJMX+gvQoqIUstpN04tSt1XFPyy41WWJ9tlHjHRX8=;
 b=VHDdGSKVnWQ+/ssXkNEKfUGY2Z+4/QcnF5ZBvWpcjGKRkOR5kdcGOAKQZPLUHxGbupbXhu5iQ3SEF47jUrF6ZfdgxpPvcWRMnK8ni8XGTihAMuryndky3/7ogacjiP1ivna7hG+b5/MONw6x2wlRo0D9X+t9KZ5aBJM33914Za8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3677.namprd12.prod.outlook.com (2603:10b6:208:15a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 12:05:14 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 12:05:14 +0000
Subject: Re: [RFC] a new approach to detect which ring is the real black sheep
 upon TDR reported
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <DM5PR12MB1708D28565B445EABA872A3B849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <f65d8f80-a283-933a-82bb-97b415689460@amd.com>
 <DM5PR12MB17086F07E3EAC0C9CA03B94D849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <DM5PR12MB17084EADC1B4C8603C864E84849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <60210231-7153-784a-d4d9-759a5b8b2180@amd.com>
Date: Fri, 26 Feb 2021 13:05:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM5PR12MB17084EADC1B4C8603C864E84849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:6c1e:37ec:4f8:3a9e]
X-ClientProxiedBy: AM0PR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:6c1e:37ec:4f8:3a9e]
 (2a02:908:1252:fb60:6c1e:37ec:4f8:3a9e) by
 AM0PR01CA0090.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Fri, 26 Feb 2021 12:05:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8fc66ac8-7dee-4c24-f6d8-08d8da4ec5da
X-MS-TrafficTypeDiagnostic: MN2PR12MB3677:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3677575F1673ED37B085A785839D9@MN2PR12MB3677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNqhRovh1GDbkhxC0yq6Irbm6J2GqZLqbnNj8qnvhhA+86iml2uyfIChYRtP/gp64QxxzCk1Seag9qZqn4k8vNZQGKzhLJr/7LfP1C2G9/F5aVRiJJU604+8NdH3AVq6/xfxuKKhrOAG0JiBeqigXVHgeljD7yc/JjTmLLe+hJHg/ZoOLeCkAuaeNYdclURJWAxnWazQKIJA38oZiMSqs9DnRgHRZRmtalVSrchu36Mo8h198ORmgFOS//FUjIBs5ltGLB7XJIsX12XPyAT9eMOA5iS/J2hkZoLwiH7NJ8chS/GsIyarKbPqjl5W8JRG1gNaJcZA5eaW58e9ck9lm34b9ykfXptMR2fIE6b9a6hReDGtTmsqumJ4LdM+qHYwykx5jlAIS3ZXBUTvuAL4x55/x5nLZw+gi3sv1ngvRayc7HVizfWN6ngTvNQtIfuAOMGEKMnUx+clrUlicF3JjIdplyesKEkM2wM9Y4lMszGEyP9Ty/yy9yhLtooTLThsna4IeEKpwNnGQN/Ivdy6xr4LyFtqnW7GD/fjcI6P12cBoG4R5uCtdI1tnLrd1loI/nwTC7goW1vwW2fvk/24kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(66476007)(2616005)(110136005)(6666004)(86362001)(66556008)(66946007)(186003)(31696002)(6486002)(53546011)(8676002)(54906003)(52116002)(316002)(83380400001)(16526019)(478600001)(2906002)(30864003)(4326008)(8936002)(31686004)(33964004)(5660300002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UFRoOE1WaGZFUThPb29qaS8yLzdIK0QxcGwxcjlMNnhpWldFZmFJZDYydkhZ?=
 =?utf-8?B?TVRiV0JJb2dyckNld3o4NThKdGcyOXdVM29WMUwxRUNMUWdYQVF3Q0NCUm1J?=
 =?utf-8?B?M2ZpT2hYVXUvOXJiRGc2RnRXS3pXa3BkVDhpcmt0TE9XUGF5TUxKNUJFcGhm?=
 =?utf-8?B?aHREdVVnaUNwR0J3aWdkSzB1TWo0M04yUWtoMTh0aEZVNWpUa2lIdkhaa25a?=
 =?utf-8?B?NmQ5dXQzZFpMbHpNWFNBcUhUbHYvdUNKZDkxZ0NZZk9hUEtIc3FielBEcjZq?=
 =?utf-8?B?ZEpVMTkxcitDUWVGaXpLc1VMazJSSm9ZY2RldWI3N0huSE8wcE9sWHRhZXZK?=
 =?utf-8?B?ZTlnTm5PNC93ZTg5R1FNb0RHYXAyZnppMWMydGVnYyswY3piVTJyZU16MzJZ?=
 =?utf-8?B?ZW9jbVcvUHZzRmw4T0NXelJoSXZCelYrZFZ0NWQyRVlTcmJqaFpQQ0EwYzVw?=
 =?utf-8?B?TDM1NkRkUm1GQzk4Tzk3TmRpNmlBUlZJS0lRU0NtVDA4Q3l3MFE1WVlGSjlq?=
 =?utf-8?B?RllPS0MrelNVQk1pT2JWeDhUUThTWFBGZFJ5ZmgxWG9IVjFWR3ViSTJZb2VK?=
 =?utf-8?B?UEVJYUhmMXJTNVR4SEhPRnRPQkpjU016NkdJSjBobmdkVTVLbWMyT2VUN3po?=
 =?utf-8?B?S1ptYXBqQzhSWU05Q3NDMTJyVExDeHhyZFk3dlUrMSsvRmY0S29jUmE3TFJR?=
 =?utf-8?B?bGJlUU1YS3MweGhIM1dPT2oxNWkxUWZzbFVTWmI0YlhSVXJ4MUFRMlYwbDJz?=
 =?utf-8?B?WVJNUjJFVHVEMjFDbWY2Z1Z5VWo1YVRRVERKcVhEV3d5MGcvTGVIK3BwT3R4?=
 =?utf-8?B?aTdrRzBKU0pCSU8yRmJGTlZMWFF5Vkt3UmpsVzI1Sm1CdURZRmd6VGticE1v?=
 =?utf-8?B?YnhHcG5QQmR2elhucFFVTW45NW1kOHhyUTh5S2ZmOXhtK2JhWlRPUGlETmJw?=
 =?utf-8?B?NVhuSnZEc2ZYejM0QkN3cVA0aUNYU09iOUVzenhTMzJTY1ZBQnZ0K0VLQk13?=
 =?utf-8?B?NjF5bWhEd2J3ZStPY29OZDRtdHVnRXlBTTUwVktQV1RydDZMVFJ6blN4bDh5?=
 =?utf-8?B?dnZnMTBLdHI4a25zS1NuZlFYL0hDVmJ2OFRsM0xuRUN5VUpISVZmWEk2bUpy?=
 =?utf-8?B?Z1ZqcjUrOTVPY1RxelhrOTFUZ1REc0k3OE1RV1dvZzVGbXdRMnkzVitYZW1t?=
 =?utf-8?B?dkE0TVU0MU5uSmZIdE91VlppR1l3eW12RDV5RUJZMFNLbndnOXltMW11UXEy?=
 =?utf-8?B?Zm9EZXVNaGJRNFV3YXRxYUt5M1lVTVpqLzJYd2pEM3FOaDBLL1BUNkp3azBW?=
 =?utf-8?B?TWtRU09qQ3J2L2tNb0tMY3pwUmZNQWlEbzZaVi9IQmUvTjdic2l3aDFyN3NX?=
 =?utf-8?B?MGV5ODVWMVY1WTBpaDBzVHoyWDRacnpNOUNHQithbnBqUEpYQkRYVlllc0pT?=
 =?utf-8?B?OHNxcFIwTzRoVWdBRWJLS3R4b21uc0R6cHFNVnUrL25lYTdKZFExK2lpVkxD?=
 =?utf-8?B?TVU4a0NIUE4xTFRGb1did2s2b3RlWG9PZzZLZ1d2VGZvOGY1Vk8rQitCWjZS?=
 =?utf-8?B?Z2VuZjloQzgzK2ZDMGZXRFhVZ3FsZkxIcVY0UlVzNE9mRjlKUnZBYlB0cTFX?=
 =?utf-8?B?UzQ3QXEvU0hjWHR2K0lpOVhYSElqMy9hM3ZJaEJ1SG0vaDlXaFpRZmFvaWY1?=
 =?utf-8?B?UnNGQXJXZDZtdDB3WVVDM0dSck13dTNKRXBtZU5OZ2k1WEtyT0o5L2ZFY2xo?=
 =?utf-8?B?VmprcjlFZ2l4alhlNnM0THRXNm83SHFpbXh0dFZOQUxxWW1saFZCSmU2d3Bt?=
 =?utf-8?B?Ym83YmVORkowZDdzZ2FLbGcvUFdqZERERExlRGtnekJWdTEwRDRKV0JQczkw?=
 =?utf-8?Q?SmsvqJ54M8Gm2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc66ac8-7dee-4c24-f6d8-08d8da4ec5da
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 12:05:14.4165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Guqf0MQgFF6ldzpFHgV+zirCZkyKEzWmkvszoNLyGV31mCxBQOyXs0/8NjJinTQJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3677
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: multipart/mixed; boundary="===============0605880659=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0605880659==
Content-Type: multipart/alternative;
 boundary="------------22646C439C77004E14115047"
Content-Language: en-US

--------------22646C439C77004E14115047
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah that is exactly the stuff which doesn't works at all. We got 
feedback for multiple people that this whole approach of tying the job 
to the tdr was not a good idea at all.

What we should do instead is to have a pointer in the scheduler fence to 
which job it belongs. Freeing up the job when the scheduler fence is 
signaled is then job of the driver and not the scheduler any more.

The scheduler then gives the scheduler fence to the driver when a 
timeout is detected and the driver can do the rest of the handling all 
by itself.

But this problem is orthogonal to the suggested solution here.

> do you have a better solution or idea we review it as another 
> candidate RFC ?

I don't see much other option either. We could do something like only 
allowing one application at a time to use the gfx/compute block, but 
that would be even worse.

If we do this we should probably make it configurable as a module parameter.

Regards,
Christian.

Am 26.02.21 um 12:57 schrieb Liu, Monk:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> static void drm_sched_job_timedout(struct work_struct *work)
>
> 279 {
>
> 280     struct drm_gpu_scheduler *sched;
>
> 281     struct drm_sched_job *job;
>
> 282
>
> 283     sched = container_of(work, struct drm_gpu_scheduler, 
> work_tdr.work);
>
> 284
>
> 285     /* Protects against concurrent deletion in 
> drm_sched_get_cleanup_job */
>
> *286 spin_lock(&sched->job_list_lock);*
>
> *287     job = list_first_entry_or_null(&sched->ring_mirror_list,*
>
> *288                        struct drm_sched_job, node);*
>
> *289*
>
> *290     if (job) {*
>
> *291         /**
>
> *292          * Remove the bad job so it cannot be freed by concurrent*
>
> *293          * drm_sched_cleanup_jobs. It will be reinserted back 
> after sched->thread*
>
> *294          * is parked at which point it's safe.*
>
> *295          */*
>
> *296 list_del_init(&job->node);*
>
> *297 spin_unlock(&sched->job_list_lock);*
>
> *298*
>
> *299 job->sched->ops->timedout_job(job);*
>
> Thanks
>
> ------------------------------------------
>
> Monk Liu | Cloud-GPU Core team
>
> ------------------------------------------
>
> *From:* Liu, Monk
> *Sent:* Friday, February 26, 2021 7:54 PM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; 
> amd-gfx@lists.freedesktop.org
> *Cc:* Zhang, Andy <Andy.Zhang@amd.com>; Chen, Horace 
> <Horace.Chen@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> *Subject:* RE: [RFC] a new approach to detect which ring is the real 
> black sheep upon TDR reported
>
> [AMD Official Use Only - Internal Distribution Only]
>
> See in line
>
> Thanks
>
> ------------------------------------------
>
> Monk Liu | Cloud-GPU Core team
>
> ------------------------------------------
>
> *From:* Koenig, Christian <Christian.Koenig@amd.com 
> <mailto:Christian.Koenig@amd.com>>
> *Sent:* Friday, February 26, 2021 3:58 PM
> *To:* Liu, Monk <Monk.Liu@amd.com <mailto:Monk.Liu@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> *Cc:* Zhang, Andy <Andy.Zhang@amd.com <mailto:Andy.Zhang@amd.com>>; 
> Chen, Horace <Horace.Chen@amd.com <mailto:Horace.Chen@amd.com>>; 
> Zhang, Jack (Jian) <Jack.Zhang1@amd.com <mailto:Jack.Zhang1@amd.com>>
> *Subject:* Re: [RFC] a new approach to detect which ring is the real 
> black sheep upon TDR reported
>
> Hi Monk,
>
> in general an interesting idea, but I see two major problems with that:
>
> 1. It would make the reset take much longer.
>
> 2. Things get often stuck because of timing issues, so a guilty job 
> might pass perfectly when run a second time.
>
> [ML] but the innocent ring already reported a TDR, and the drm sched 
> logic already deleted this “sched_job” in its mirror list, thus you 
> don’t have chance to re-submit it again after reset, that’s the major 
> problem here.
>
> Apart from that the whole ring mirror list turned out to be a really 
> bad idea. E.g. we still struggle with object life time because the 
> concept doesn't fit into the object model of the GPU scheduler under 
> Linux.
>
> We should probably work on this separately and straighten up the job 
> destruction once more and keep the recovery information in the fence 
> instead.
>
> [ML] we claim to our customer that no innocent process will be dropped 
> or cancelled, and our current logic works for the most time, but only 
> when there are different process running on gfx/computes rings then we 
> would run into the tricky situation I stated here, and the proposal is 
> the only way I can figure out so far, do you have a better solution or 
> idea we review it as another candidate RFC ? Be note that we raised 
> this proposal is because we do hit our trouble and we do need to 
> resolve it …. So even a not perfect solution is still better than just 
> cancel the innocent job (and their context/process)
>
> Thanks !
>
>
> Regards,
> Christian.
>
> Am 26.02.21 um 06:58 schrieb Liu, Monk:
>
>     [AMD Public Use]
>
>     Hi all
>
>     NAVI2X  project hit a really hard to solve issue now, and it is
>     turned out to be a general headache of our TDR mechanism , check
>     below scenario:
>
>      1. There is a job1 running on compute1 ring at timestamp
>      2. There is a job2 running on gfx ring at timestamp
>      3. Job1 is the guilty one, and job1/job2 were scheduled to their
>         rings at almost the same timestamp
>      4. After 2 seconds we receive two TDR reporting from both GFX
>         ring and compute ring
>      5. *Current scheme is that in drm scheduler all the head jobs of
>         those two rings are considered “bad job” and taken away from
>         the mirror list *
>      6. The result is both the real guilty job (job1) and the innocent
>         job (job2) were all deleted from mirror list, and their
>         corresponding contexts were also treated as guilty*(so the
>         innocent process remains running is not secured)*
>
>     **
>
>     But by our wish the ideal case is TDR mechanism can detect which
>     ring is the guilty ring and the innocent ring can resubmits all
>     its pending jobs:
>
>      1. Job1 to be deleted from compute1 ring’s mirror list
>      2. Job2 is kept and resubmitted later and its belonging
>         process/context are even not aware of this TDR at all
>
>     Here I have a proposal tend to achieve above goal and it rough
>     procedure is :
>
>      1. Once any ring reports a TDR, the head job is **not** treated
>         as “bad job”, and it is **not** deleted from the mirror list
>         in drm sched functions
>      2. In vendor’s function (our amdgpu driver here):
>
>           * reset GPU
>           * repeat below actions on each RINGS * one by one *:
>
>     1.take the head job and submit it on this ring
>
>     2.see if it completes, if not then this job is the real “bad job”
>
>     3. take it away from mirror list if this head job is “bad job”
>
>           * After above iteration on all RINGS, we already clears all
>             the bad job(s)
>
>      3. Resubmit all jobs from each mirror list to their corresponding
>         rings (this is the existed logic)
>
>     The idea of this is to use “serial” way to re-run and re-check
>     each head job of each RING, in order to take out the real black
>     sheep and its guilty context.
>
>     P.S.: we can use this approaches only on GFX/KCQ ring reports TDR
>     , since those rings are intermutually affected to each other. For
>     SDMA ring timeout it definitely proves the head job on SDMA ring
>     is really guilty.
>
>     Thanks
>
>     ------------------------------------------
>
>     Monk Liu | Cloud-GPU Core team
>
>     ------------------------------------------
>


--------------22646C439C77004E14115047
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Yeah that is exactly the stuff which doesn't works at all. We got
    feedback for multiple people that this whole approach of tying the
    job to the tdr was not a good idea at all.<br>
    <br>
    What we should do instead is to have a pointer in the scheduler
    fence to which job it belongs. Freeing up the job when the scheduler
    fence is signaled is then job of the driver and not the scheduler
    any more.<br>
    <br>
    The scheduler then gives the scheduler fence to the driver when a
    timeout is detected and the driver can do the rest of the handling
    all by itself.<br>
    <br>
    But this problem is orthogonal to the suggested solution here.<br>
    <br>
    <blockquote type="cite">do you have a better solution or idea we
      review it as another candidate RFC ?</blockquote>
    <br>
    I don't see much other option either. We could do something like
    only allowing one application at a time to use the gfx/compute
    block, but that would be even worse.<br>
    <br>
    If we do this we should probably make it configurable as a module
    parameter.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 26.02.21 um 12:57 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite" cite="mid:DM5PR12MB17084EADC1B4C8603C864E84849D9@DM5PR12MB1708.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:503861270;
	mso-list-type:hybrid;
	mso-list-template-ids:1492292582 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1279491622;
	mso-list-type:hybrid;
	mso-list-template-ids:-1736673670 67698703 67698689 67698703 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level3
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1655448059;
	mso-list-type:hybrid;
	mso-list-template-ids:-1584207202 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheadera92f4c5c" style="margin:0in"><span style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">static void drm_sched_job_timedout(struct
          work_struct *work)<o:p></o:p></p>
        <p class="MsoNormal">279 {<o:p></o:p></p>
        <p class="MsoNormal">280&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched;<o:p></o:p></p>
        <p class="MsoNormal">281&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;<o:p></o:p></p>
        <p class="MsoNormal">282<o:p></o:p></p>
        <p class="MsoNormal">283&nbsp;&nbsp;&nbsp;&nbsp; sched = container_of(work, struct
          drm_gpu_scheduler, work_tdr.work);<o:p></o:p></p>
        <p class="MsoNormal">284<o:p></o:p></p>
        <p class="MsoNormal">285&nbsp;&nbsp;&nbsp;&nbsp; /* Protects against concurrent
          deletion in drm_sched_get_cleanup_job */<o:p></o:p></p>
        <p class="MsoNormal"><b>286&nbsp;&nbsp;&nbsp;&nbsp;
            spin_lock(&amp;sched-&gt;job_list_lock);<o:p></o:p></b></p>
        <p class="MsoNormal"><b>287&nbsp;&nbsp;&nbsp;&nbsp; job =
            list_first_entry_or_null(&amp;sched-&gt;ring_mirror_list,<o:p></o:p></b></p>
        <p class="MsoNormal"><b>288&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
            drm_sched_job, node);<o:p></o:p></b></p>
        <p class="MsoNormal"><b>289<o:p></o:p></b></p>
        <p class="MsoNormal"><b>290&nbsp;&nbsp;&nbsp;&nbsp; if (job) {<o:p></o:p></b></p>
        <p class="MsoNormal"><b>291&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></b></p>
        <p class="MsoNormal"><b>292&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Remove the bad job so it
            cannot be freed by concurrent<o:p></o:p></b></p>
        <p class="MsoNormal"><b>293&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * drm_sched_cleanup_jobs.
            It will be reinserted back after sched-&gt;thread<o:p></o:p></b></p>
        <p class="MsoNormal"><b>294&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is parked at which point
            it's safe.<o:p></o:p></b></p>
        <p class="MsoNormal"><b>295&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></b></p>
        <p class="MsoNormal"><b>296&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            list_del_init(&amp;job-&gt;node);<o:p></o:p></b></p>
        <p class="MsoNormal"><b>297&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            spin_unlock(&amp;sched-&gt;job_list_lock);<o:p></o:p></b></p>
        <p class="MsoNormal"><b>298<o:p></o:p></b></p>
        <p class="MsoNormal"><b>299&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            job-&gt;sched-&gt;ops-&gt;timedout_job(job);<o:p></o:p></b></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <p class="MsoNormal">Thanks <o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
          <p class="MsoNormal">Monk Liu | Cloud-GPU Core team<o:p></o:p></p>
          <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Liu, Monk <br>
              <b>Sent:</b> Friday, February 26, 2021 7:54 PM<br>
              <b>To:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <b>Cc:</b> Zhang, Andy <a class="moz-txt-link-rfc2396E" href="mailto:Andy.Zhang@amd.com">&lt;Andy.Zhang@amd.com&gt;</a>; Chen,
              Horace <a class="moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com">&lt;Horace.Chen@amd.com&gt;</a>; Zhang, Jack (Jian)
              <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a><br>
              <b>Subject:</b> RE: [RFC] a new approach to detect which
              ring is the real black sheep upon TDR reported<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="msipheadera92f4c5c" style="margin:0in"><span style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">See in line<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <p class="MsoNormal">Thanks <o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
          <p class="MsoNormal">Monk Liu | Cloud-GPU Core team<o:p></o:p></p>
          <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;
              <br>
              <b>Sent:</b> Friday, February 26, 2021 3:58 PM<br>
              <b>To:</b> Liu, Monk &lt;<a href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">Monk.Liu@amd.com</a>&gt;; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                amd-gfx@lists.freedesktop.org</a><br>
              <b>Cc:</b> Zhang, Andy &lt;<a href="mailto:Andy.Zhang@amd.com" moz-do-not-send="true">Andy.Zhang@amd.com</a>&gt;;
              Chen, Horace &lt;<a href="mailto:Horace.Chen@amd.com" moz-do-not-send="true">Horace.Chen@amd.com</a>&gt;;
              Zhang, Jack (Jian) &lt;<a href="mailto:Jack.Zhang1@amd.com" moz-do-not-send="true">Jack.Zhang1@amd.com</a>&gt;<br>
              <b>Subject:</b> Re: [RFC] a new approach to detect which
              ring is the real black sheep upon TDR reported<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">Hi Monk,<br>
          <br>
          in general an interesting idea, but I see two major problems
          with that:<br>
          <br>
          1. It would make the reset take much longer.<br>
          <br>
          2. Things get often stuck because of timing issues, so a
          guilty job might pass perfectly when run a second time.<o:p></o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">[ML] but the
          innocent ring already reported a TDR, and the drm sched logic
          already deleted this “sched_job” in its mirror list, thus you
          don’t have chance to re-submit it again after reset, that’s
          the major problem here.<br>
          <br>
          Apart from that the whole ring mirror list turned out to be a
          really bad idea. E.g. we still struggle with object life time
          because the concept doesn't fit into the object model of the
          GPU scheduler under Linux.<br>
          <br>
          We should probably work on this separately and straighten up
          the job destruction once more and keep the recovery
          information in the fence instead.<o:p></o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">[ML] we claim
          to our customer that no innocent process will be dropped or
          cancelled, and our current logic works for the most time, but
          only when there are different process running on gfx/computes
          rings then we would run into the tricky situation I stated
          here, and the proposal is the only way I can figure out so
          far, do you have a better solution or idea we review it as
          another candidate RFC ? Be note that we raised this proposal
          is because we do hit our trouble and we do need to resolve it
          …. So even a not perfect solution is still better than just
          cancel the innocent job (and their context/process)<o:p></o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">Thanks ! <o:p></o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
          Regards,<br>
          Christian.<o:p></o:p></p>
        <div>
          <p class="MsoNormal">Am 26.02.21 um 06:58 schrieb Liu, Monk:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="msipheader251902e5" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
              Public Use]</span><o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Hi all<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">NAVI2X &nbsp;project hit a really hard to
            solve issue now, and it is turned out to be a general
            headache of our TDR mechanism , check below scenario:<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <ol style="margin-top:0in" type="1" start="1">
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">There is a
              job1 running on compute1 ring at timestamp
              <o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">There is a
              job2 running on gfx ring at timestamp<o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">Job1 is
              the guilty one, and job1/job2 were scheduled to their
              rings at almost the same timestamp
              <o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">After 2
              seconds we receive two TDR reporting from both GFX ring
              and compute ring<o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1"><b>Current
                scheme is that in drm scheduler all the head jobs of
                those two rings are considered “bad job” and taken away
                from the mirror list
              </b><o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1">The result
              is both the real guilty job (job1) and the innocent job
              (job2) were all deleted from mirror list, and their
              corresponding contexts were also treated as guilty<b> (so
                the innocent process remains running is not secured)</b><o:p></o:p></li>
          </ol>
          <p class="MsoListParagraph"><b>&nbsp;</b><o:p></o:p></p>
          <p class="MsoNormal">But by our wish the ideal case is TDR
            mechanism can detect which ring is the guilty ring and the
            innocent ring can resubmits all its pending jobs:<o:p></o:p></p>
          <ol style="margin-top:0in" type="1" start="1">
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l2 level1 lfo2">Job1 to be
              deleted from compute1 ring’s mirror list<o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l2 level1 lfo2">Job2 is
              kept and resubmitted later and its belonging
              process/context are even not aware of this TDR at all
              <o:p></o:p></li>
          </ol>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">Here I have a proposal tend to achieve
            above goal and it rough procedure is :<o:p></o:p></p>
          <ol style="margin-top:0in" type="1" start="1">
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level1 lfo3">Once any
              ring reports a TDR, the head job is *<b>not</b>* treated
              as “bad job”, and it is *<b>not</b>* deleted from the
              mirror list in drm sched functions<o:p></o:p></li>
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level1 lfo3">In
              vendor’s function (our amdgpu driver here):<o:p></o:p></li>
          </ol>
          <ol style="margin-top:0in" type="1" start="2">
            <ul style="margin-top:0in" type="disc">
              <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level2 lfo3">reset
                GPU<o:p></o:p></li>
              <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level2 lfo3">repeat
                below actions on each RINGS * one by one *:<o:p></o:p></li>
            </ul>
          </ol>
          <p class="MsoListParagraph" style="margin-left:1.5in;text-indent:-9.0pt;mso-list:l1
            level3 lfo3">
            <!--[if !supportLists]--><span style="mso-list:Ignore">1.<span style="font:7.0pt &quot;Times New Roman&quot;">
              </span></span><!--[endif]-->take the head job and submit
            it on this ring<o:p></o:p></p>
          <p class="MsoListParagraph" style="margin-left:1.5in;text-indent:-9.0pt;mso-list:l1
            level3 lfo3">
            <!--[if !supportLists]--><span style="mso-list:Ignore">2.<span style="font:7.0pt &quot;Times New Roman&quot;">
              </span></span><!--[endif]-->see if it completes, if not
            then this job is the real “bad job”<o:p></o:p></p>
          <p class="MsoListParagraph" style="margin-left:1.5in;text-indent:-9.0pt;mso-list:l1
            level3 lfo3">
            <!--[if !supportLists]--><span style="mso-list:Ignore">3.<span style="font:7.0pt &quot;Times New Roman&quot;">
              </span></span><!--[endif]-->&nbsp;take it away from mirror list
            if this head job is “bad job”<o:p></o:p></p>
          <ol style="margin-top:0in" type="1" start="2">
            <ul style="margin-top:0in" type="disc">
              <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level2 lfo3">After
                above iteration on all RINGS, we already clears all the
                bad job(s)<o:p></o:p></li>
            </ul>
          </ol>
          <ol style="margin-top:0in" type="1" start="3">
            <li class="MsoListParagraph" style="margin-left:0in;mso-list:l1 level1 lfo3">Resubmit
              all jobs from each mirror list to their corresponding
              rings (this is the existed logic)<o:p></o:p></li>
          </ol>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">The idea of this is to use “serial” way
            to re-run and re-check each head job of each RING, in order
            to take out the real black sheep and its guilty context.<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">P.S.: we can use this approaches only on
            GFX/KCQ ring reports TDR , since those rings are
            intermutually affected to each other. For SDMA ring timeout
            it definitely proves the head job on SDMA ring is really
            guilty.<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">Thanks <o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
          <p class="MsoNormal">Monk Liu | Cloud-GPU Core team<o:p></o:p></p>
          <p class="MsoNormal">------------------------------------------<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------22646C439C77004E14115047--

--===============0605880659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0605880659==--
