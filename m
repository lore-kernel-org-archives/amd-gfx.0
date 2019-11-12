Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41866C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 19:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B56620818
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 19:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B56620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA28A6E519;
	Tue, 12 Nov 2019 19:21:27 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790071.outbound.protection.outlook.com [40.107.79.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086D46EBC9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 19:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFr91a4mc73VUI9FmHAUBsYZkCl0YVcUJXYK0C/y0+vqNXdHx9uOFR9938OItYNiE93WBeMp+nqEC5f7/hUOgMaY/iUkr0wKj0qwukobomg920NGlHmuTKnNhaUdRDPoVTv9s9WmzWuTsOVMN0tZI+HH2y9LhI1Ufd2+onlppAgxptKnUvPxrMbod/XO104yn6QlmcZF+teApUJrRtNCGR+D2pWQbFfyEogmnTYfr84U52jno19cgysRwarUdl+XkjgFQ1NQ0G7H0fopnsoDlAtrQ/OsQGREsxTLQT25HkMcn7GSB7dvlEr7BnrurKrAxP0CUZZ61MzwCsQcwkObAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YGXpFdSXnk6hzt9JsKRDvpH240kAQjd523cKdiDnCQ=;
 b=X7bH70ATlGRDF9mMaJA3c1Uf+PTIJ1qOcfkffe6+s/8VPNbBkqhNaRO+qHEo2KGN1yaCCvyBofh+PBkk055lr3BKJOzWYsN+bdLOknBcfje4aFCbEQMMgJkcDPKUB8nJmoAE8wJdQoeI5n/onUxJxbKVRDQgQPgHKeM+p6uQvgQKTg9iZjc7Djg/fez1GdpOUwLWxBLXNvyQh8Jf/AUQbQZkoaPjqXsF6FmaVDpatqVai0NaFrU7w748eKwAtiVlPwjEvgAxGq/kN1HKm44JZNau8wGy7RddiwAU/DPWvuPTBg2OBKfyyE8KXL6TIWB3tkYhNmP4l+jf8BrM/4Pc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1853.namprd12.prod.outlook.com (10.175.55.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 12 Nov 2019 19:21:24 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 19:21:24 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1573122349-22080-1-git-send-email-Emily.Deng@amd.com>
 <MN2PR12MB2975D4E26CED960B82305F308F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
 <MN2PR12MB2975E26D8A8352863BA01FCA8F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
 <c01acb29-72ce-a109-3ca5-166706327d61@amd.com>
 <MN2PR12MB29755CFCE09CEC0D9EB999D18F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
 <70c2c1cc-40b8-30da-7aee-f59fbc4d0d42@amd.com>
 <DM6PR12MB2971859C1BF16EE7E65B35B18F7B0@DM6PR12MB2971.namprd12.prod.outlook.com>
 <d6f9c508-3c23-c797-1cbc-7502dc4c0b13@amd.com>
 <DM6PR12MB29714AB9AD16FA3ABD7D62C28F7B0@DM6PR12MB2971.namprd12.prod.outlook.com>
 <dcc1124b-5e19-b018-7449-659a8b7d74ea@amd.com>
 <DM6PR12MB29710DFE90F22F5903499AFE8F7B0@DM6PR12MB2971.namprd12.prod.outlook.com>
 <91f4a0c4-23e3-a399-5cb1-fb01da922784@amd.com>
 <MWHPR12MB1453817C6F05A57FD431E159EA770@MWHPR12MB1453.namprd12.prod.outlook.com>
 <MN2PR12MB29750EDB35E27DF9CD63152C8F770@MN2PR12MB2975.namprd12.prod.outlook.com>
 <2f035f22-4057-dd9e-27ef-0f5612113e29@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <9269d447-ed32-81f7-ab43-cb16139096e2@amd.com>
Date: Tue, 12 Nov 2019 14:21:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <2f035f22-4057-dd9e-27ef-0f5612113e29@amd.com>
Content-Type: multipart/mixed; boundary="------------D7D3C42840796FBBBE0C9C93"
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45)
 To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f9b7517-4861-4842-5f40-08d767a58164
X-MS-TrafficTypeDiagnostic: MWHPR12MB1853:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1853982B8BCBD708D209C4F1EA770@MWHPR12MB1853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(199004)(189003)(13464003)(51234002)(52116002)(6436002)(76176011)(386003)(6506007)(236005)(66476007)(66556008)(6486002)(53546011)(6306002)(66576008)(33964004)(6246003)(66946007)(30864003)(966005)(478600001)(14454004)(5024004)(36756003)(14444005)(235185007)(54896002)(6512007)(66574012)(606006)(31696002)(7736002)(71190400001)(86362001)(26005)(6666004)(186003)(5660300002)(486006)(2906002)(446003)(11346002)(25786009)(2616005)(476003)(31686004)(81156014)(99286004)(21480400003)(81166006)(8676002)(6116002)(568964002)(37036004)(110136005)(316002)(16586007)(58126008)(65806001)(65956001)(66066001)(8936002)(2476003)(229853002)(3846002)(2501003)(579004)(559001)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1853;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1HB+9iCPMtq6PGGGPRNiy+obCVbp3vvn4ZdgRYzRtFBcPrvqypRAB7Om+xocIpSfUFB+ZgzoGbjvemMiCi+B9lVxLr+qdlYu6EdhvKqzJlenjg//Fyw0BB88F9vopM5zmzLs0+Lhq50iy2Lzrm276cN+bxIld23cXHkXuDxjI8boQ42/4GQ90gc8bYI/lLb7L3cgQAI/DiCTCzeY2LSRDiXQKmyplK/7oN7b4ywMnqsJJjnANmVvuA0IK03TM4f7rDcYGAEPUfcHdJLYDthxi/yvA5JQ8nlk6FAEoMi1t1EyYSQcee1EFXQd7FBTP3IMWOgmvVgMIXnExqVnDEKg4B+c9uOqzZqp8hSV71jw0o3QG6qwn4Y2slV9Ui3IaanWIsNTzficEjFzkSt8zq59ziFiFWz/wtRc/GwWQsrA7JLFuKbTUKH8AxCHxkseSRjqXPhf52RYGu7p3l8IbaMyOWhv3FZs4/corSRgZbwfL0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9b7517-4861-4842-5f40-08d767a58164
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 19:21:23.9955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9DDIhEJreFh73gIwBS1KIWujwkVPeXNxFg2iC7krj3zydkSeTYRrfFy+THtlp0N51S0oqJjj61xHJer0wmpyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1853
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YGXpFdSXnk6hzt9JsKRDvpH240kAQjd523cKdiDnCQ=;
 b=tUcvsaUbFCJb4FWBN2k2SHIbmo47At2KfUhKcSYlzphwLgizsX5vQemR6cMjnwaWtM0AqXE1atLyzB3W0cA+fbCUJghDWfmXv7bn67Yr2Rq/xzUj2DtLW02GF+KHJwmMO+mc1Wa83RA6m84ib/KnoZJbg3wB8RNmFlIcoO4XXVU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112192121.IsEQhi_2u8wikftE7X4I-BWYd5zkTuNDZ8TlKi4Q2CY@z>

--------------D7D3C42840796FBBBE0C9C93
Content-Type: multipart/alternative;
 boundary="------------C8D2A3CFA22F156CE08A2893"

--------------C8D2A3CFA22F156CE08A2893
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I was able to reproduce the crash by using the attached 
simulate_crash.patch - waiting on guilty job to signal in reset work and 
artificially rearming the timeout timer just before the check for 
!cancel_delayed_work(&sched->work_tdr)  in drm_sched_cleanup_jobs - 
crash log attached in crash.log. This I think confirms my theory i 
described earlier in this thread.

basic_fix.patch handles this by testing whether another timer already 
armed ob this scheduler or is there a timeout work in execution right 
now (see documentation for work_busy) - obviously this is not a full 
solution as this will not protect from races if for example there is 
immediate work scheduling such as in drm_sched_fault -  so we probably 
need to account for this by making drm_sched_cleanup_jobs (at least in 
the part where it iterates ring mirror list and frees jobs) and GPU 
reset really mutually exclusive and not like now.

Andrey


On 11/11/19 4:11 PM, Christian König wrote:
> Hi Emily,
>
> you need to print which scheduler instance is freeing the jobs and 
> which one is triggering the reset. The TID and PID is completely 
> meaningless here since we are called from different worker threads and 
> the TID/PID can change on each call.
>
> Apart from that I will look into this a bit deeper when I have time.
>
> Regards,
> Christian.
>
> Am 12.11.19 um 07:02 schrieb Deng, Emily:
>> Hi Christian,
>>     I add the follow print in function drm_sched_cleanup_jobs. From 
>> the log it shows that only use cancel_delayed_work could not avoid to 
>> free job when the sched is in reset. But don’t know exactly where it 
>> is wrong about the driver. Do you have any suggestion about this?
>> + printk("Emily:drm_sched_cleanup_jobs:begin,tid:%lu, pid:%lu\n", 
>> current->tgid, current->pid);
>>         /*
>>          * Don't destroy jobs while the timeout worker is running  OR 
>> thread
>>          * is being parked and hence assumed to not touch 
>> ring_mirror_list
>>          */
>>          if ((sched->timeout != MAX_SCHEDULE_TIMEOUT &&
>> !cancel_delayed_work(&sched->work_tdr)))
>>                 return;
>> +       printk("Emily:drm_sched_cleanup_jobs,tid:%lu, pid:%lu\n", 
>> current->tgid, current->pid);
>> Best wishes
>> Emily Deng
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11380.695091] Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11380.695104] Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11380.695105] Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11380.695107] Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11380.695107] Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.222954] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0 
>> timeout, signaled seq=78585, emitted seq=78587
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.224275] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process 
>> information: process  pid 0 thread  pid 0, 
>> s_job:00000000fe75ab36,tid=15603, pid=15603
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.225413] amdgpu 0000:00:08.0: GPU reset begin!
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.225417] Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.225425] Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.225425] Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.225428] Emily:amdgpu_job_free_cb,Process information: process  
>> pid 0 thread  pid 0, s_job:00000000fe75ab36, tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.225429] Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.225430] Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.225473] Emily:drm_sched_cleanup_jobs:begin,tid:2253, pid:2253
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.225486] Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.225489] Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262
>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>> [11381.225494] Emily:amdgpu_job_free_cb,Process information: process  
>> pid 0 thread  pid 0, s_job:00000000f086ec84, tid:2262, pid:2262
>> >-----Original Message-----
>> >From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>> >Sent: Tuesday, November 12, 2019 11:28 AM
>> >To: Koenig, Christian <Christian.Koenig@amd.com>; Deng, Emily
>> ><Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>> >Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
>> >
>> >Thinking more about this claim - we assume here that if cancel_delayed_work
>> >returned true it guarantees that timeout work is not running but, it merely
>> >means there was a pending timeout work which was removed from the
>> >workqueue before it's timer elapsed and so it didn't have a chance to be
>> >dequeued and executed, it doesn't cover already executing work. So there is a
>> >possibility where while timeout work started executing another timeout work
>> >already got enqueued (maybe through earlier cleanup jobs or through
>> >drm_sched_fault) and if at this point another drm_sched_cleanup_jobs runs
>> >cancel_delayed_work(&sched->work_tdr) will return true even while there is a
>> >timeout job in progress.
>> >Unfortunately we cannot change cancel_delayed_work to
>> >cancel_delayed_work_sync to flush the timeout work as timeout work itself
>> >waits for schedule thread  to be parked again when calling park_thread.
>> >
>> >Andrey
>> >
>> >________________________________________
>> >From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
>> >Koenig, Christian <Christian.Koenig@amd.com>
>> >Sent: 08 November 2019 05:35:18
>> >To: Deng, Emily; amd-gfx@lists.freedesktop.org
>> >Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
>> >
>> >Hi Emily,
>> >
>> >exactly that can't happen. See here:
>> >
>> >>         /* Don't destroy jobs while the timeout worker is running */
>> >>         if (sched->timeout != MAX_SCHEDULE_TIMEOUT &&
>> >>            !cancel_delayed_work(&sched->work_tdr))
>> >>                 return NULL;
>> >
>> >We never free jobs while the timeout working is running to prevent exactly
>> >that issue.
>> >
>> >Regards,
>> >Christian.
>> >
>> >Am 08.11.19 um 11:32 schrieb Deng, Emily:
>> >> Hi Christian,
>> >>       The drm_sched_job_timedout-> amdgpu_job_timedout call
>> >amdgpu_device_gpu_recover. I mean the main scheduler free the jobs while
>> >in amdgpu_device_gpu_recover, and before calling drm_sched_stop.
>> >>
>> >> Best wishes
>> >> Emily Deng
>> >>
>> >>
>> >>
>> >>> -----Original Message-----
>> >>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> >>> Sent: Friday, November 8, 2019 6:26 PM
>> >>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>> >>> Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
>> >>>
>> >>> Hi Emily,
>> >>>
>> >>> well who is calling amdgpu_device_gpu_recover() in this case?
>> >>>
>> >>> When it's not the scheduler we shouldn't have a guilty job in the first place.
>> >>>
>> >>> Regards,
>> >>> Christian.
>> >>>
>> >>> Am 08.11.19 um 11:22 schrieb Deng, Emily:
>> >>>> Hi Chrisitan,
>> >>>>        No, I am with the new branch and also has the patch. Even it
>> >>>> are freed by
>> >>> main scheduler, how we could avoid main scheduler to free jobs while
>> >>> enter to function amdgpu_device_gpu_recover?
>> >>>> Best wishes
>> >>>> Emily Deng
>> >>>>
>> >>>>
>> >>>>
>> >>>>> -----Original Message-----
>> >>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> >>>>> Sent: Friday, November 8, 2019 6:15 PM
>> >>>>> To: Deng, Emily <Emily.Deng@amd.com>; amd-
>> >gfx@lists.freedesktop.org
>> >>>>> Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
>> >>>>>
>> >>>>> Hi Emily,
>> >>>>>
>> >>>>> in this case you are on an old code branch.
>> >>>>>
>> >>>>> Jobs are freed now by the main scheduler thread and only if no
>> >>>>> timeout handler is running.
>> >>>>>
>> >>>>> See this patch here:
>> >>>>>> commit 5918045c4ed492fb5813f980dcf89a90fefd0a4e
>> >>>>>> Author: Christian König <christian.koenig@amd.com>
>> >>>>>> Date:   Thu Apr 18 11:00:21 2019 -0400
>> >>>>>>
>> >>>>>>       drm/scheduler: rework job destruction
>> >>>>> Regards,
>> >>>>> Christian.
>> >>>>>
>> >>>>> Am 08.11.19 um 11:11 schrieb Deng, Emily:
>> >>>>>> Hi Christian,
>> >>>>>>         Please refer to follow log, when it enter to
>> >>>>>> amdgpu_device_gpu_recover
>> >>>>> function, the bad job 000000005086879e is freeing in function
>> >>>>> amdgpu_job_free_cb  at the same time, because of the hardware fence
>> >>> signal.
>> >>>>> But amdgpu_device_gpu_recover goes faster, at this case, the
>> >>>>> s_fence is already freed, but job is not freed in time. Then this issue
>> >occurs.
>> >>>>>> [  449.792189] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring
>> >>> sdma0
>> >>>>>> timeout, signaled seq=2481, emitted seq=2483 [  449.793202]
>> >>>>>> [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information:
>> >>>>> process  pid 0 thread  pid 0, s_job:000000005086879e [  449.794163]
>> >>>>> amdgpu
>> >>>>> 0000:00:08.0: GPU reset begin!
>> >>>>>> [  449.794175] Emily:amdgpu_job_free_cb,Process information:
>> >>>>>> process pid 0 thread  pid 0, s_job:000000005086879e [  449.794221]
>> >>>>>> Emily:amdgpu_job_free_cb,Process information: process  pid 0
>> >>>>>> thread pid 0, s_job:0000000066eb74ab [  449.794222]
>> >>>>>> Emily:amdgpu_job_free_cb,Process information: process  pid 0
>> >>>>>> thread pid 0, s_job:00000000d4438ad9 [  449.794255]
>> >>>>>> Emily:amdgpu_job_free_cb,Process information: process  pid 0
>> >>>>>> thread pid 0, s_job:00000000b6d69c65 [  449.794257]
>> >>>>>> Emily:amdgpu_job_free_cb,Process information: process  pid 0
>> >>>>>> thread pid 0,
>> >>>>> s_job:00000000ea85e922 [ 449.794287]
>> >>>>> Emily:amdgpu_job_free_cb,Process
>> >>>>> information: process  pid 0 thread  pid 0, s_job:00000000ed3a5ac6 [
>> >>>>> 449.794366] BUG: unable to handle kernel NULL pointer dereference
>> >>>>> at
>> >>>>> 00000000000000c0 [  449.800818] PGD 0 P4D 0 [  449.801040] Oops:
>> >>>>> 0000 [#1] SMP PTI
>> >>>>>> [  449.801338] CPU: 3 PID: 55 Comm: kworker/3:1 Tainted: G           OE
>> >>>>> 4.18.0-15-generic #16~18.04.1-Ubuntu
>> >>>>>> [  449.802157] Hardware name: QEMU Standard PC (i440FX + PIIX,
>> >>>>>> 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014 [  449.802944]
>> >>>>>> Workqueue: events drm_sched_job_timedout [amd_sched] [
>> >>>>>> 449.803488]
>> >>> RIP:
>> >>>>> 0010:amdgpu_device_gpu_recover+0x1da/0xb60 [amdgpu]
>> >>>>>> [  449.804020] Code: dd ff ff 49 39 c5 48 89 55 a8 0f 85 56 ff ff
>> >>>>>> ff
>> >>>>>> 45 85 e4 0f
>> >>>>> 85 a1 00 00 00 48 8b 45 b0 48 85 c0 0f 84 60 01 00 00 48 8b 40 10
>> >>>>> <48> 8b
>> >>> 98
>> >>>>> c0 00         00 00 48 85 db 0f 84 4c 01 00 00 48 8b 43 48 a8 01
>> >>>>>> [  449.805593] RSP: 0018:ffffb4c7c08f7d68 EFLAGS: 00010286 [
>> >>>>>> 449.806032] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>> >>>>>> 0000000000000000 [ 449.806625] RDX: ffffb4c7c08f5ac0 RSI:
>> >>>>>> 0000000fffffffe0 RDI: 0000000000000246 [  449.807224] RBP:
>> >>>>>> ffffb4c7c08f7de0 R08: 00000068b9d54000 R09: 0000000000000000 [
>> >>>>>> 449.807818] R10: 0000000000000000 R11: 0000000000000148 R12:
>> >>>>>> 0000000000000000 [ 449.808411] R13: ffffb4c7c08f7da0 R14:
>> >>>>>> ffff8d82b8525d40 R15: ffff8d82b8525d40 [  449.809004] FS:
>> >>>>>> 0000000000000000(0000) GS:ffff8d82bfd80000(0000)
>> >>>>>> knlGS:0000000000000000 [ 449.809674] CS:  0010 DS: 0000 ES: 0000
>> >CR0:
>> >>>>>> 0000000080050033 [ 449.810153] CR2: 00000000000000c0 CR3:
>> >>>>>> 000000003cc0a001 CR4: 00000000003606e0 [  449.810747] DR0:
>> >>>>> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 [
>> >>>>> 449.811344] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> >>>>> 0000000000000400 [  449.811937] Call Trace:
>> >>>>>> [  449.812206] amdgpu_job_timedout+0x114/0x140 [amdgpu] [
>> >>>>>> 449.812635] drm_sched_job_timedout+0x44/0x90 [amd_sched] [
>> >>>>>> 449.813139]  ? amdgpu_cgs_destroy_device+0x10/0x10 [amdgpu] [
>> >>>>>> 449.813609]  ? drm_sched_job_timedout+0x44/0x90 [amd_sched] [
>> >>>>>> 449.814077] process_one_work+0x1fd/0x3f0 [  449.814417]
>> >>>>>> worker_thread+0x34/0x410 [ 449.814728]  kthread+0x121/0x140 [
>> >>>>>> 449.815004]  ? process_one_work+0x3f0/0x3f0 [  449.815374]  ?
>> >>>>>> kthread_create_worker_on_cpu+0x70/0x70
>> >>>>>> [  449.815799] ret_from_fork+0x35/0x40
>> >>>>>>
>> >>>>>>> -----Original Message-----
>> >>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> >>>>>>> Sent: Friday, November 8, 2019 5:43 PM
>> >>>>>>> To: Deng, Emily <Emily.Deng@amd.com>; amd-
>> >>> gfx@lists.freedesktop.org
>> >>>>>>> Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue for
>> >>>>>>> tdr
>> >>>>>>>
>> >>>>>>> Am 08.11.19 um 10:39 schrieb Deng, Emily:
>> >>>>>>>> Sorry, please take your time.
>> >>>>>>> Have you seen my other response a bit below?
>> >>>>>>>
>> >>>>>>> I can't follow how it would be possible for job->s_fence to be
>> >>>>>>> NULL without the job also being freed.
>> >>>>>>>
>> >>>>>>> So it looks like this patch is just papering over some bigger issues.
>> >>>>>>>
>> >>>>>>> Regards,
>> >>>>>>> Christian.
>> >>>>>>>
>> >>>>>>>> Best wishes
>> >>>>>>>> Emily Deng
>> >>>>>>>>
>> >>>>>>>>
>> >>>>>>>>
>> >>>>>>>>> -----Original Message-----
>> >>>>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> >>>>>>>>> Sent: Friday, November 8, 2019 5:08 PM
>> >>>>>>>>> To: Deng, Emily <Emily.Deng@amd.com>; amd-
>> >>>>> gfx@lists.freedesktop.org
>> >>>>>>>>> Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue for
>> >>>>>>>>> tdr
>> >>>>>>>>>
>> >>>>>>>>> Am 08.11.19 um 09:52 schrieb Deng, Emily:
>> >>>>>>>>>> Ping.....
>> >>>>>>>>> You need to give me at least enough time to wake up :)
>> >>>>>>>>>
>> >>>>>>>>>> Best wishes
>> >>>>>>>>>> Emily Deng
>> >>>>>>>>>>
>> >>>>>>>>>>
>> >>>>>>>>>>
>> >>>>>>>>>>> -----Original Message-----
>> >>>>>>>>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On
>> >>> Behalf
>> >>>>>>>>>>> Of Deng, Emily
>> >>>>>>>>>>> Sent: Friday, November 8, 2019 10:56 AM
>> >>>>>>>>>>> To: Koenig, Christian <Christian.Koenig@amd.com>; amd-
>> >>>>>>>>>>> gfx@lists.freedesktop.org
>> >>>>>>>>>>> Subject: RE: [PATCH] drm/amdgpu: Fix the null pointer issue
>> >>>>>>>>>>> for tdr
>> >>>>>>>>>>>
>> >>>>>>>>>>>> -----Original Message-----
>> >>>>>>>>>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> >>>>>>>>>>>> Sent: Thursday, November 7, 2019 7:28 PM
>> >>>>>>>>>>>> To: Deng, Emily <Emily.Deng@amd.com>;
>> >>>>>>>>>>>> amd-gfx@lists.freedesktop.org
>> >>>>>>>>>>>> Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue
>> >>>>>>>>>>>> for tdr
>> >>>>>>>>>>>>
>> >>>>>>>>>>>> Am 07.11.19 um 11:25 schrieb Emily Deng:
>> >>>>>>>>>>>>> When the job is already signaled, the s_fence is freed.
>> >>>>>>>>>>>>> Then it will has null pointer in amdgpu_device_gpu_recover.
>> >>>>>>>>>>>> NAK, the s_fence is only set to NULL when the job is destroyed.
>> >>>>>>>>>>>> See drm_sched_job_cleanup().
>> >>>>>>>>>>> I know it is set to NULL in drm_sched_job_cleanup. But in one
>> >>>>>>>>>>> case, when it enter into the amdgpu_device_gpu_recover, it
>> >>>>>>>>>>> already in drm_sched_job_cleanup, and at this time, it will
>> >>>>>>>>>>> go to free
>> >>>>> job.
>> >>>>>>>>>>> But the amdgpu_device_gpu_recover sometimes is faster. At
>> >>>>>>>>>>> that time, job is not freed, but s_fence is already NULL.
>> >>>>>>>>> No, that case can't happen. See here:
>> >>>>>>>>>
>> >>>>>>>>>>            drm_sched_job_cleanup(s_job);
>> >>>>>>>>>>
>> >>>>>>>>>>            amdgpu_ring_priority_put(ring, s_job->s_priority);
>> >>>>>>>>>>            dma_fence_put(job->fence);
>> >>>>>>>>>>            amdgpu_sync_free(&job->sync);
>> >>>>>>>>>>            amdgpu_sync_free(&job->sched_sync);
>> >>>>>>>>>>            kfree(job);
>> >>>>>>>>> The job itself is freed up directly after freeing the reference
>> >>>>>>>>> to the
>> >>>>> s_fence.
>> >>>>>>>>> So you are just papering over a much bigger problem here. This
>> >>>>>>>>> patch is a clear NAK.
>> >>>>>>>>>
>> >>>>>>>>> Regards,
>> >>>>>>>>> Christian.
>> >>>>>>>>>
>> >>>>>>>>>>>> When you see a job without an s_fence then that means the
>> >>>>>>>>>>>> problem is somewhere else.
>> >>>>>>>>>>>>
>> >>>>>>>>>>>> Regards,
>> >>>>>>>>>>>> Christian.
>> >>>>>>>>>>>>
>> >>>>>>>>>>>>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>> >>>>>>>>>>>>> ---
>> >>>>>>>>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>> >>>>>>>>>>>>>       drivers/gpu/drm/scheduler/sched_main.c     | 11 ++++++---
>> >--
>> >>>>>>>>>>>>>       2 files changed, 7 insertions(+), 6 deletions(-)
>> >>>>>>>>>>>>>
>> >>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >>>>>>>>>>>>> index e6ce949..5a8f08e 100644
>> >>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >>>>>>>>>>>>> @@ -4075,7 +4075,7 @@ int
>> >>> amdgpu_device_gpu_recover(struct
>> >>>>>>>>>>>> amdgpu_device *adev,
>> >>>>>>>>>>>>>            *
>> >>>>>>>>>>>>>            * job->base holds a reference to parent fence
>> >>>>>>>>>>>>>            */
>> >>>>>>>>>>>>> - if (job && job->base.s_fence->parent &&
>> >>>>>>>>>>>>> + if (job && job->base.s_fence &&
>> >>>>>>>>>>>>> + job->base.s_fence->parent
>> >>>>>>> &&
>> >>>>>>>>>>>>>               dma_fence_is_signaled(job->base.s_fence->parent))
>> >>>>>>>>>>>>>                   job_signaled = true;
>> >>>>>>>>>>>>>
>> >>>>>>>>>>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>> >>>>>>>>>>>>> b/drivers/gpu/drm/scheduler/sched_main.c
>> >>>>>>>>>>>>> index 31809ca..56cc10e 100644
>> >>>>>>>>>>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> >>>>>>>>>>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> >>>>>>>>>>>>> @@ -334,8 +334,8 @@ void
>> >drm_sched_increase_karma(struct
>> >>>>>>>>>>>> drm_sched_job
>> >>>>>>>>>>>>> *bad)
>> >>>>>>>>>>>>>
>> >>>>>>>>>>>>>                           spin_lock(&rq->lock);
>> >>>>>>>>>>>>>                           list_for_each_entry_safe(entity,
>> >>>>>>>>>>>>> tmp,
>> >>> &rq-
>> >>>>>>>> entities,
>> >>>>>>>>>>>> list) {
>> >>>>>>>>>>>>> -                          if (bad->s_fence->scheduled.context
>> >>>>>>> ==
>> >>>>>>>>>>>>> -                              entity->fence_context) {
>> >>>>>>>>>>>>> +                          if (bad->s_fence &&
>> >>>>>>>>>>>>> + (bad->s_fence-
>> >>>>>>>>>>>>> scheduled.context ==
>> >>>>>>>>>>>>> +                              entity->fence_context)) {
>> >>>>>>>>>>>>>                                           if
>> >>>>>>>>>>>>> (atomic_read(&bad-
>> >>>>>>>> karma) >
>> >>>>>>>>>>>>>                                               bad->sched-
>> >>>> hang_limit)
>> >>>>>>>>>>>>>                                                   if
>> >>>>>>>>>>>>> (entity-
>> >>>> guilty) @@ -376,7 +376,7 @@ void
>> >>>>>>>>>>>>> drm_sched_stop(struct
>> >>>>>>> drm_gpu_scheduler
>> >>>>>>>>>>>> *sched, struct drm_sched_job *bad)
>> >>>>>>>>>>>>>            * This iteration is thread safe as sched thread
>> >>>>>>>>>>>>> is
>> >>> stopped.
>> >>>>>>>>>>>>>            */
>> >>>>>>>>>>>>>           list_for_each_entry_safe_reverse(s_job, tmp,
>> >>>>>>>>>>>>> &sched- ring_mirror_list, node) {
>> >>>>>>>>>>>>> -          if (s_job->s_fence->parent &&
>> >>>>>>>>>>>>> +          if (s_job->s_fence && s_job->s_fence->parent &&
>> >>>>>>>>>>>>>                       dma_fence_remove_callback(s_job-
>> >>>> s_fence-
>> >>>>>>>> parent,
>> >>>>>>>>>>>>>                                                 &s_job->cb)) {
>> >>>>>>>>>>>>>                           atomic_dec(&sched->hw_rq_count);
>> >>> @@ -
>> >>>>>>> 395,7
>> >>>>>>>>>>> +395,8 @@ void
>> >>>>>>>>>>>>> drm_sched_stop(struct drm_gpu_scheduler
>> >>>>>>>>>>>> *sched, struct drm_sched_job *bad)
>> >>>>>>>>>>>>>                            *
>> >>>>>>>>>>>>>                            * Job is still alive so fence
>> >>>>>>>>>>>>> refcount at
>> >>> least 1
>> >>>>>>>>>>>>>                            */
>> >>>>>>>>>>>>> - dma_fence_wait(&s_job->s_fence->finished,
>> >>>>>>> false);
>> >>>>>>>>>>>>> +                  if (s_job->s_fence)
>> >>>>>>>>>>>>> + dma_fence_wait(&s_job->s_fence-
>> >>>>>>>> finished,
>> >>>>>>>>>>>> false);
>> >>>>>>>>>>>>>                           /*
>> >>>>>>>>>>>>>                            * We must keep bad job alive
>> >>>>>>>>>>>>> for later
>> >>> use
>> >>>>>>> during @@
>> >>>>>>>>>>>> -438,7
>> >>>>>>>>>>>>> +439,7 @@ void drm_sched_start(struct drm_gpu_scheduler
>> >>>>> *sched,
>> >>>>>>>>>>>>> +bool
>> >>>>>>>>>>>> full_recovery)
>> >>>>>>>>>>>>>            * GPU recovers can't run in parallel.
>> >>>>>>>>>>>>>            */
>> >>>>>>>>>>>>>           list_for_each_entry_safe(s_job, tmp,
>> >>>>>>>>>>>>> &sched->ring_mirror_list,
>> >>>>>>>>>>>>> node)
>> >>>>>>>>>>>> {
>> >>>>>>>>>>>>> -          struct dma_fence *fence = s_job->s_fence->parent;
>> >>>>>>>>>>>>> +          struct dma_fence *fence = s_job->s_fence ?
>> >>>>>>>>>>>>> + s_job-
>> >>>>>>>> s_fence-
>> >>>>>>>>>>>>> parent :
>> >>>>>>>>>>>>> +NULL;
>> >>>>>>>>>>>>>
>> >>>>>>>>>>>>>                   atomic_inc(&sched->hw_rq_count);
>> >>>>>>>>>>>>>
>> >>>>>>>>>>> _______________________________________________
>> >>>>>>>>>>> amd-gfx mailing list
>> >>>>>>>>>>> amd-gfx@lists.freedesktop.org
>> >>>>>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx 
>> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>> >
>> >_______________________________________________
>> >amd-gfx mailing list
>> >amd-gfx@lists.freedesktop.org
>> >https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--------------C8D2A3CFA22F156CE08A2893
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>I was able to reproduce the crash by using the attached
      simulate_crash.patch - waiting on guilty job to signal in reset
      work and artificially rearming the timeout timer just before the
      check for !cancel_delayed_work(&amp;sched-&gt;work_tdr)&nbsp; in
      drm_sched_cleanup_jobs - crash log attached in crash.log. This I
      think confirms my theory i described earlier in this thread.</p>
    <p>basic_fix.patch handles this by testing whether another timer
      already armed ob this scheduler or is there a timeout work in
      execution right now (see documentation for work_busy) - obviously&nbsp;
      this is not a full solution as this will not protect from races if
      for example there is immediate work scheduling such as in <font size="2" face="Calibri"><span style="font-size:11pt;">drm_sched_fault
          -&nbsp; so we probably need to account for this by making
          drm_sched_cleanup_jobs (at least in the part where it iterates
          ring mirror list and frees jobs) and GPU reset really mutually
          exclusive and not like now.</span></font></p>
    <p><font size="2" face="Calibri"><span style="font-size:11pt;">Andrey<br>
        </span></font></p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/11/19 4:11 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2f035f22-4057-dd9e-27ef-0f5612113e29@amd.com">
      
      <div class="moz-cite-prefix">Hi Emily,<br>
        <br>
        you need to print which scheduler instance is freeing the jobs
        and which one is triggering the reset. The TID and PID is
        completely meaningless here since we are called from different
        worker threads and the TID/PID can change on each call.<br>
        <br>
        Apart from that I will look into this a bit deeper when I have
        time.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        Am 12.11.19 um 07:02 schrieb Deng, Emily:<br>
      </div>
      <blockquote type="cite" cite="mid:MN2PR12MB29750EDB35E27DF9CD63152C8F770@MN2PR12MB2975.namprd12.prod.outlook.com">
        <meta name="Generator" content="Microsoft Exchange Server">
        <!-- converted from rtf -->
        <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
        <font size="2" face="Calibri"><span style="font-size:11pt;">
            <div>Hi Christian,</div>
            <div>&nbsp;&nbsp;&nbsp; I add the follow print in function
              drm_sched_cleanup_jobs. From the log it shows that only
              use cancel_delayed_work could not avoid to free job when
              the sched is in reset. But don’t know exactly where it is
              wrong about the driver. Do you have any suggestion about
              this?</div>
            <div><font face="Times New Roman">&nbsp;</font></div>
            <div>&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              printk(&quot;Emily:drm_sched_cleanup_jobs:begin,tid:%lu,
              pid:%lu\n&quot;, current-&gt;tgid, current-&gt;pid);</div>
            <div>&nbsp;</div>
            <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*</div>
            <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Don't destroy jobs while the timeout worker
              is running&nbsp; OR thread</div>
            <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is being parked and hence assumed to not
              touch ring_mirror_list</div>
            <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</div>
            <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((sched-&gt;timeout != MAX_SCHEDULE_TIMEOUT
              &amp;&amp;</div>
            <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
              !cancel_delayed_work(&amp;sched-&gt;work_tdr)))</div>
            <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;</div>
            <div>&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(&quot;Emily:drm_sched_cleanup_jobs,tid:%lu,
              pid:%lu\n&quot;, current-&gt;tgid, current-&gt;pid);</div>
            <div><font face="Times New Roman">&nbsp;</font></div>
            <div><font face="Times New Roman">&nbsp;</font></div>
            <div><font face="Calibri">Best wishes</font></div>
            <div><font face="Calibri">Emily Deng</font></div>
            <div><font face="Times New Roman">&nbsp;</font></div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11380.695091]
              Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11380.695104]
              Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11380.695105]
              Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11380.695107]
              Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11380.695107]
              Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.222954] [drm:amdgpu_job_timedout [amdgpu]]
              *ERROR* ring sdma0 timeout, signaled seq=78585, emitted
              seq=78587</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.224275] [drm:amdgpu_job_timedout [amdgpu]]
              *ERROR* Process information: process&nbsp; pid 0 thread&nbsp; pid 0,
              s_job:00000000fe75ab36,tid=15603, pid=15603</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.225413] amdgpu 0000:00:08.0: <font color="#00B050">GPU reset begin</font>!</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.225417]
              Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.225425]
              Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.225425]
              Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.225428] Emily:<font color="#00B050">amdgpu_job_free_cb</font>,Process
              information: process&nbsp; pid 0 thread&nbsp; pid 0,
              s_job:00000000fe75ab36, tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.225429]
              Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.225430]
              Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.225473]
              Emily:drm_sched_cleanup_jobs:begin,tid:2253, pid:2253</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.225486]
              Emily:drm_sched_cleanup_jobs:begin,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.225489]
              Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262</div>
            <div>Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02
              kernel: [11381.225494] Emily:amdgpu_job_free_cb,Process
              information: process&nbsp; pid 0 thread&nbsp; pid 0,
              s_job:00000000f086ec84, tid:2262, pid:2262</div>
            <div>&gt;-----Original Message-----</div>
            <div>&gt;From: Grodzovsky, Andrey <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com" moz-do-not-send="true">&lt;Andrey.Grodzovsky@amd.com&gt;</a></div>
            <div>&gt;Sent: Tuesday, November 12, 2019 11:28 AM</div>
            <div>&gt;To: Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
              Deng, Emily</div>
            <div>&gt;<a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a></div>
            <div>&gt;Subject: Re: [PATCH] drm/amdgpu: Fix the null
              pointer issue for tdr</div>
            <div>&gt;</div>
            <div>&gt;Thinking more about this claim - we assume here
              that if cancel_delayed_work</div>
            <div>&gt;returned true it guarantees that timeout work is
              not running but, it merely</div>
            <div>&gt;means there was a pending timeout work which was
              removed from the</div>
            <div>&gt;workqueue before it's timer elapsed and so it
              didn't have a chance to be</div>
            <div>&gt;dequeued and executed, it doesn't cover already
              executing work. So there is a</div>
            <div>&gt;possibility where while timeout work started
              executing another timeout work</div>
            <div>&gt;already got enqueued (maybe through earlier cleanup
              jobs or through</div>
            <div>&gt;drm_sched_fault) and if at this point another
              drm_sched_cleanup_jobs runs</div>
            <div>&gt;cancel_delayed_work(&amp;sched-&gt;work_tdr) will
              return true even while there is a</div>
            <div>&gt;timeout job in progress.</div>
            <div>&gt;Unfortunately we cannot change cancel_delayed_work
              to</div>
            <div>&gt;cancel_delayed_work_sync to flush the timeout work
              as timeout work itself</div>
            <div>&gt;waits for schedule thread&nbsp; to be parked again when
              calling park_thread.</div>
            <div>&gt;</div>
            <div>&gt;Andrey</div>
            <div>&gt;</div>
            <div>&gt;________________________________________</div>
            <div>&gt;From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
              on behalf of</div>
            <div>&gt;Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a></div>
            <div>&gt;Sent: 08 November 2019 05:35:18</div>
            <div>&gt;To: Deng, Emily; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a></div>
            <div>&gt;Subject: Re: [PATCH] drm/amdgpu: Fix the null
              pointer issue for tdr</div>
            <div>&gt;</div>
            <div>&gt;Hi Emily,</div>
            <div>&gt;</div>
            <div>&gt;exactly that can't happen. See here:</div>
            <div>&gt;</div>
            <div>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Don't destroy jobs while the
              timeout worker is running */</div>
            <div>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sched-&gt;timeout !=
              MAX_SCHEDULE_TIMEOUT &amp;&amp;</div>
            <div>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              !cancel_delayed_work(&amp;sched-&gt;work_tdr))</div>
            <div>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;</div>
            <div>&gt;</div>
            <div>&gt;We never free jobs while the timeout working is
              running to prevent exactly</div>
            <div>&gt;that issue.</div>
            <div>&gt;</div>
            <div>&gt;Regards,</div>
            <div>&gt;Christian.</div>
            <div>&gt;</div>
            <div>&gt;Am 08.11.19 um 11:32 schrieb Deng, Emily:</div>
            <div>&gt;&gt; Hi Christian,</div>
            <div>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The drm_sched_job_timedout-&gt;
              amdgpu_job_timedout call</div>
            <div>&gt;amdgpu_device_gpu_recover. I mean the main
              scheduler free the jobs while</div>
            <div>&gt;in amdgpu_device_gpu_recover, and before calling
              drm_sched_stop.</div>
            <div>&gt;&gt;</div>
            <div>&gt;&gt; Best wishes</div>
            <div>&gt;&gt; Emily Deng</div>
            <div>&gt;&gt;</div>
            <div>&gt;&gt;</div>
            <div>&gt;&gt;</div>
            <div>&gt;&gt;&gt; -----Original Message-----</div>
            <div>&gt;&gt;&gt; From: Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a></div>
            <div>&gt;&gt;&gt; Sent: Friday, November 8, 2019 6:26 PM</div>
            <div>&gt;&gt;&gt; To: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a></div>
            <div>&gt;&gt;&gt; Subject: Re: [PATCH] drm/amdgpu: Fix the
              null pointer issue for tdr</div>
            <div>&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt; Hi Emily,</div>
            <div>&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt; well who is calling
              amdgpu_device_gpu_recover() in this case?</div>
            <div>&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt; When it's not the scheduler we shouldn't
              have a guilty job in the first place.</div>
            <div>&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt; Regards,</div>
            <div>&gt;&gt;&gt; Christian.</div>
            <div>&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt; Am 08.11.19 um 11:22 schrieb Deng, Emily:</div>
            <div>&gt;&gt;&gt;&gt; Hi Chrisitan,</div>
            <div>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No, I am with the new branch
              and also has the patch. Even it</div>
            <div>&gt;&gt;&gt;&gt; are freed by</div>
            <div>&gt;&gt;&gt; main scheduler, how we could avoid main
              scheduler to free jobs while</div>
            <div>&gt;&gt;&gt; enter to function
              amdgpu_device_gpu_recover?</div>
            <div>&gt;&gt;&gt;&gt; Best wishes</div>
            <div>&gt;&gt;&gt;&gt; Emily Deng</div>
            <div>&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt; -----Original Message-----</div>
            <div>&gt;&gt;&gt;&gt;&gt; From: Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a></div>
            <div>&gt;&gt;&gt;&gt;&gt; Sent: Friday, November 8, 2019
              6:15 PM</div>
            <div>&gt;&gt;&gt;&gt;&gt; To: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
              amd-</div>
            <div>&gt;<a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org" moz-do-not-send="true">gfx@lists.freedesktop.org</a></div>
            <div>&gt;&gt;&gt;&gt;&gt; Subject: Re: [PATCH] drm/amdgpu:
              Fix the null pointer issue for tdr</div>
            <div>&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt; Hi Emily,</div>
            <div>&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt; in this case you are on an old
              code branch.</div>
            <div>&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt; Jobs are freed now by the main
              scheduler thread and only if no</div>
            <div>&gt;&gt;&gt;&gt;&gt; timeout handler is running.</div>
            <div>&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt; See this patch here:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; commit
              5918045c4ed492fb5813f980dcf89a90fefd0a4e</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; Author: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a></div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; Date:&nbsp;&nbsp; Thu Apr 18 11:00:21
              2019 -0400</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm/scheduler: rework
              job destruction</div>
            <div>&gt;&gt;&gt;&gt;&gt; Regards,</div>
            <div>&gt;&gt;&gt;&gt;&gt; Christian.</div>
            <div>&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt; Am 08.11.19 um 11:11 schrieb Deng,
              Emily:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; Hi Christian,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Please refer to follow
              log, when it enter to</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; amdgpu_device_gpu_recover</div>
            <div>&gt;&gt;&gt;&gt;&gt; function, the bad job
              000000005086879e is freeing in function</div>
            <div>&gt;&gt;&gt;&gt;&gt; amdgpu_job_free_cb&nbsp; at the same
              time, because of the hardware fence</div>
            <div>&gt;&gt;&gt; signal.</div>
            <div>&gt;&gt;&gt;&gt;&gt; But amdgpu_device_gpu_recover goes
              faster, at this case, the</div>
            <div>&gt;&gt;&gt;&gt;&gt; s_fence is already freed, but job
              is not freed in time. Then this issue</div>
            <div>&gt;occurs.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 449.792189]
              [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring</div>
            <div>&gt;&gt;&gt; sdma0</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; timeout, signaled seq=2481,
              emitted seq=2483 [&nbsp; 449.793202]</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; [drm:amdgpu_job_timedout
              [amdgpu]] *ERROR* Process information:</div>
            <div>&gt;&gt;&gt;&gt;&gt; process&nbsp; pid 0 thread&nbsp; pid 0,
              s_job:000000005086879e [&nbsp; 449.794163]</div>
            <div>&gt;&gt;&gt;&gt;&gt; amdgpu</div>
            <div>&gt;&gt;&gt;&gt;&gt; 0000:00:08.0: GPU reset begin!</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 449.794175]
              Emily:amdgpu_job_free_cb,Process information:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; process pid 0 thread&nbsp; pid 0,
              s_job:000000005086879e [&nbsp; 449.794221]</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;
              Emily:amdgpu_job_free_cb,Process information: process&nbsp; pid
              0</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; thread pid 0,
              s_job:0000000066eb74ab [&nbsp; 449.794222]</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;
              Emily:amdgpu_job_free_cb,Process information: process&nbsp; pid
              0</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; thread pid 0,
              s_job:00000000d4438ad9 [&nbsp; 449.794255]</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;
              Emily:amdgpu_job_free_cb,Process information: process&nbsp; pid
              0</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; thread pid 0,
              s_job:00000000b6d69c65 [&nbsp; 449.794257]</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;
              Emily:amdgpu_job_free_cb,Process information: process&nbsp; pid
              0</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; thread pid 0,</div>
            <div>&gt;&gt;&gt;&gt;&gt; s_job:00000000ea85e922 [&nbsp;
              449.794287]</div>
            <div>&gt;&gt;&gt;&gt;&gt; Emily:amdgpu_job_free_cb,Process</div>
            <div>&gt;&gt;&gt;&gt;&gt; information: process&nbsp; pid 0
              thread&nbsp; pid 0, s_job:00000000ed3a5ac6 [</div>
            <div>&gt;&gt;&gt;&gt;&gt; 449.794366] BUG: unable to handle
              kernel NULL pointer dereference</div>
            <div>&gt;&gt;&gt;&gt;&gt; at</div>
            <div>&gt;&gt;&gt;&gt;&gt; 00000000000000c0 [&nbsp; 449.800818]
              PGD 0 P4D 0 [&nbsp; 449.801040] Oops:</div>
            <div>&gt;&gt;&gt;&gt;&gt; 0000 [#1] SMP PTI</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 449.801338] CPU: 3 PID: 55
              Comm: kworker/3:1 Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE</div>
            <div>&gt;&gt;&gt;&gt;&gt; 4.18.0-15-generic
              #16~18.04.1-Ubuntu</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 449.802157] Hardware name:
              QEMU Standard PC (i440FX &#43; PIIX,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 1996), BIOS
              Ubuntu-1.8.2-1ubuntu1 04/01/2014 [&nbsp; 449.802944]</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; Workqueue: events
              drm_sched_job_timedout [amd_sched] [</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 449.803488]</div>
            <div>&gt;&gt;&gt; RIP:</div>
            <div>&gt;&gt;&gt;&gt;&gt;
              0010:amdgpu_device_gpu_recover&#43;0x1da/0xb60 [amdgpu]</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 449.804020] Code: dd ff ff
              49 39 c5 48 89 55 a8 0f 85 56 ff ff</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; ff</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 45 85 e4 0f</div>
            <div>&gt;&gt;&gt;&gt;&gt; 85 a1 00 00 00 48 8b 45 b0 48 85
              c0 0f 84 60 01 00 00 48 8b 40 10</div>
            <div>&gt;&gt;&gt;&gt;&gt; &lt;48&gt; 8b</div>
            <div>&gt;&gt;&gt; 98</div>
            <div>&gt;&gt;&gt;&gt;&gt; c0 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 00 48 85 db 0f 84
              4c 01 00 00 48 8b 43 48 a8 01</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 449.805593] RSP:
              0018:ffffb4c7c08f7d68 EFLAGS: 00010286 [</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 449.806032] RAX:
              0000000000000000 RBX: 0000000000000000 RCX:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 0000000000000000 [&nbsp;
              449.806625] RDX: ffffb4c7c08f5ac0 RSI:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 0000000fffffffe0 RDI:
              0000000000000246 [&nbsp; 449.807224] RBP:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; ffffb4c7c08f7de0 R08:
              00000068b9d54000 R09: 0000000000000000 [</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 449.807818] R10:
              0000000000000000 R11: 0000000000000148 R12:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 0000000000000000 [&nbsp;
              449.808411] R13: ffffb4c7c08f7da0 R14:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; ffff8d82b8525d40 R15:
              ffff8d82b8525d40 [&nbsp; 449.809004] FS:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 0000000000000000(0000)
              GS:ffff8d82bfd80000(0000)</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; knlGS:0000000000000000 [&nbsp;
              449.809674] CS:&nbsp; 0010 DS: 0000 ES: 0000</div>
            <div>&gt;CR0:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 0000000080050033 [&nbsp;
              449.810153] CR2: 00000000000000c0 CR3:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 000000003cc0a001 CR4:
              00000000003606e0 [&nbsp; 449.810747] DR0:</div>
            <div>&gt;&gt;&gt;&gt;&gt; 0000000000000000 DR1:
              0000000000000000 DR2: 0000000000000000 [</div>
            <div>&gt;&gt;&gt;&gt;&gt; 449.811344] DR3: 0000000000000000
              DR6: 00000000fffe0ff0 DR7:</div>
            <div>&gt;&gt;&gt;&gt;&gt; 0000000000000400 [&nbsp; 449.811937]
              Call Trace:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 449.812206]&nbsp;
              amdgpu_job_timedout&#43;0x114/0x140 [amdgpu] [</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 449.812635]&nbsp;
              drm_sched_job_timedout&#43;0x44/0x90 [amd_sched] [</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 449.813139]&nbsp; ?
              amdgpu_cgs_destroy_device&#43;0x10/0x10 [amdgpu] [</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 449.813609]&nbsp; ?
              drm_sched_job_timedout&#43;0x44/0x90 [amd_sched] [</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 449.814077]&nbsp;
              process_one_work&#43;0x1fd/0x3f0 [&nbsp; 449.814417]</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; worker_thread&#43;0x34/0x410 [&nbsp;
              449.814728]&nbsp; kthread&#43;0x121/0x140 [</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; 449.815004]&nbsp; ?
              process_one_work&#43;0x3f0/0x3f0 [&nbsp; 449.815374]&nbsp; ?</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;
              kthread_create_worker_on_cpu&#43;0x70/0x70</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt; [&nbsp; 449.815799]&nbsp;
              ret_from_fork&#43;0x35/0x40</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; From: Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a></div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sent: Friday, November 8,
              2019 5:43 PM</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; To: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
              amd-</div>
            <div>&gt;&gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org" moz-do-not-send="true">gfx@lists.freedesktop.org</a></div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Subject: Re: [PATCH]
              drm/amdgpu: Fix the null pointer issue for</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; tdr</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Am 08.11.19 um 10:39
              schrieb Deng, Emily:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sorry, please take
              your time.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Have you seen my other
              response a bit below?</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; I can't follow how it
              would be possible for job-&gt;s_fence to be</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; NULL without the job also
              being freed.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; So it looks like this
              patch is just papering over some bigger issues.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Regards,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Christian.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Best wishes</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Emily Deng</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----Original
              Message-----</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; From: Koenig,
              Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a></div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sent: Friday,
              November 8, 2019 5:08 PM</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; To: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
              amd-</div>
            <div>&gt;&gt;&gt;&gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org" moz-do-not-send="true">gfx@lists.freedesktop.org</a></div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Subject: Re:
              [PATCH] drm/amdgpu: Fix the null pointer issue for</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; tdr</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Am 08.11.19 um
              09:52 schrieb Deng, Emily:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Ping.....</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; You need to give
              me at least enough time to wake up :)</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Best wishes</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Emily Deng</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              -----Original Message-----</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; From:
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
              On</div>
            <div>&gt;&gt;&gt; Behalf</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Of Deng,
              Emily</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sent:
              Friday, November 8, 2019 10:56 AM</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; To:
              Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
              amd-</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org" moz-do-not-send="true">gfx@lists.freedesktop.org</a></div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Subject:
              RE: [PATCH] drm/amdgpu: Fix the null pointer issue</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; for tdr</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              -----Original Message-----</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; From:
              Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a></div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sent:
              Thursday, November 7, 2019 7:28 PM</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; To:
              Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a></div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer
              issue</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; for
              tdr</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Am
              07.11.19 um 11:25 schrieb Emily Deng:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              When the job is already signaled, the s_fence is freed.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              Then it will has null pointer in
              amdgpu_device_gpu_recover.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; NAK,
              the s_fence is only set to NULL when the job is destroyed.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; See
              drm_sched_job_cleanup().</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I know it
              is set to NULL in drm_sched_job_cleanup. But in one</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; case, when
              it enter into the amdgpu_device_gpu_recover, it</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; already in
              drm_sched_job_cleanup, and at this time, it will</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; go to free</div>
            <div>&gt;&gt;&gt;&gt;&gt; job.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; But the
              amdgpu_device_gpu_recover sometimes is faster. At</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; that time,
              job is not freed, but s_fence is already NULL.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; No, that case
              can't happen. See here:</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              drm_sched_job_cleanup(s_job);</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              amdgpu_ring_priority_put(ring, s_job-&gt;s_priority);</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              dma_fence_put(job-&gt;fence);</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              amdgpu_sync_free(&amp;job-&gt;sync);</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              amdgpu_sync_free(&amp;job-&gt;sched_sync);</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              kfree(job);</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The job itself is
              freed up directly after freeing the reference</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; to the</div>
            <div>&gt;&gt;&gt;&gt;&gt; s_fence.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; So you are just
              papering over a much bigger problem here. This</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; patch is a clear
              NAK.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Regards,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Christian.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; When
              you see a job without an s_fence then that means the</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              problem is somewhere else.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              Regards,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              Christian.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a></div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              ---</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 2 &#43;-</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              drivers/gpu/drm/scheduler/sched_main.c&nbsp;&nbsp;&nbsp;&nbsp; | 11 &#43;&#43;&#43;&#43;&#43;&#43;---</div>
            <div>&gt;--</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              2 files changed, 7 insertions(&#43;), 6 deletions(-)</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              index e6ce949..5a8f08e 100644</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@
              -4075,7 &#43;4075,7 @@ int</div>
            <div>&gt;&gt;&gt; amdgpu_device_gpu_recover(struct</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              amdgpu_device *adev,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              *</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              * job-&gt;base holds a reference to parent fence</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              */</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;
              if (job &amp;&amp; job-&gt;base.s_fence-&gt;parent
              &amp;&amp;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;
              if (job &amp;&amp; job-&gt;base.s_fence &amp;&amp;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &#43;
              job-&gt;base.s_fence-&gt;parent</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; &amp;&amp;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              dma_fence_is_signaled(job-&gt;base.s_fence-&gt;parent))</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              job_signaled = true;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              diff --git a/drivers/gpu/drm/scheduler/sched_main.c</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              b/drivers/gpu/drm/scheduler/sched_main.c</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              index 31809ca..56cc10e 100644</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              --- a/drivers/gpu/drm/scheduler/sched_main.c</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &#43;&#43;&#43; b/drivers/gpu/drm/scheduler/sched_main.c</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@
              -334,8 &#43;334,8 @@ void</div>
            <div>&gt;drm_sched_increase_karma(struct</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              drm_sched_job</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              *bad)</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              spin_lock(&amp;rq-&gt;lock);</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              list_for_each_entry_safe(entity,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              tmp,</div>
            <div>&gt;&gt;&gt; &amp;rq-</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; entities,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; list)
              {</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
              (bad-&gt;s_fence-&gt;scheduled.context</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; ==</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;fence_context) {</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_fence &amp;&amp;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &#43;
              (bad-&gt;s_fence-</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              scheduled.context ==</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;fence_context))
              {</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              if</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              (atomic_read(&amp;bad-</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; karma) &gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              bad-&gt;sched-</div>
            <div>&gt;&gt;&gt;&gt; hang_limit)</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              if</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              (entity-</div>
            <div>&gt;&gt;&gt;&gt; guilty) @@ -376,7 &#43;376,7 @@ void</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              drm_sched_stop(struct</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; drm_gpu_scheduler</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              *sched, struct drm_sched_job *bad)</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              * This iteration is thread safe as sched thread</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; is</div>
            <div>&gt;&gt;&gt; stopped.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              */</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              list_for_each_entry_safe_reverse(s_job, tmp,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &amp;sched- ring_mirror_list, node) {</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s_job-&gt;s_fence-&gt;parent &amp;&amp;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s_job-&gt;s_fence &amp;&amp;
              s_job-&gt;s_fence-&gt;parent &amp;&amp;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              dma_fence_remove_callback(s_job-</div>
            <div>&gt;&gt;&gt;&gt; s_fence-</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; parent,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &amp;s_job-&gt;cb)) {</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              atomic_dec(&amp;sched-&gt;hw_rq_count);</div>
            <div>&gt;&gt;&gt; @@ -</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 395,7</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &#43;395,8 @@
              void</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              drm_sched_stop(struct drm_gpu_scheduler</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              *sched, struct drm_sched_job *bad)</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              *</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              * Job is still alive so fence</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              refcount at</div>
            <div>&gt;&gt;&gt; least 1</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              */</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              dma_fence_wait(&amp;s_job-&gt;s_fence-&gt;finished,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; false);</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s_job-&gt;s_fence)</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              dma_fence_wait(&amp;s_job-&gt;s_fence-</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; finished,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              false);</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              /*</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              * We must keep bad job alive</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              for later</div>
            <div>&gt;&gt;&gt; use</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt; during @@</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -438,7</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &#43;439,7 @@ void drm_sched_start(struct drm_gpu_scheduler</div>
            <div>&gt;&gt;&gt;&gt;&gt; *sched,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &#43;bool</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              full_recovery)</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              * GPU recovers can't run in parallel.</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              */</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              list_for_each_entry_safe(s_job, tmp,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &amp;sched-&gt;ring_mirror_list,</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              node)</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; {</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence =
              s_job-&gt;s_fence-&gt;parent;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence = s_job-&gt;s_fence ?</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &#43;
              s_job-</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; s_fence-</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              parent :</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              &#43;NULL;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              atomic_inc(&amp;sched-&gt;hw_rq_count);</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
              _______________________________________________</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; amd-gfx
              mailing list</div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a></div>
            <div>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">
                https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
            <div>&gt;</div>
            <div>&gt;_______________________________________________</div>
            <div>&gt;amd-gfx mailing list</div>
            <div>&gt;<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a></div>
            <div>&gt;<a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
            <div><font face="Times New Roman">&nbsp;</font></div>
          </span></font> </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------C8D2A3CFA22F156CE08A2893--

--------------D7D3C42840796FBBBE0C9C93
Content-Type: text/x-patch;
 name="basic_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="basic_fix.patch"

@@ -647,14 +653,28 @@ static void drm_sched_cleanup_jobs(struct drm_gpu_scheduler *sched)
 {
        unsigned long flags;
 
+
        /*
         * Don't destroy jobs while the timeout worker is running  OR thread
         * is being parked and hence assumed to not touch ring_mirror_list
         */

        if ((sched->timeout != MAX_SCHEDULE_TIMEOUT &&
-           !cancel_delayed_work(&sched->work_tdr)) ||
-           __kthread_should_park(sched->thread)) {
+               return;
+
+       }
+
+       if (work_busy(&sched->work_tdr.work)) {
+               DRM_ERROR("DRM_ERROR work_busy - returning");
                return;
+       }


--------------D7D3C42840796FBBBE0C9C93
Content-Type: text/x-patch;
 name="simulate_crash.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="simulate_crash.patch"

@@ -647,14 +653,28 @@ static void drm_sched_cleanup_jobs(struct drm_gpu_scheduler *sched)
 {
        unsigned long flags;
 
+
        /*
         * Don't destroy jobs while the timeout worker is running  OR thread
         * is being parked and hence assumed to not touch ring_mirror_list
         */
+       DRM_ERROR("Sched name %s", sched->name);
+       if (!strcmp("gfx", sched->name)) {
+               spin_lock_irqsave(&sched->job_list_lock, flags);
+               drm_sched_start_timeout(sched);
+               spin_unlock_irqrestore(&sched->job_list_lock, flags);
+       }
        if ((sched->timeout != MAX_SCHEDULE_TIMEOUT &&
-           !cancel_delayed_work(&sched->work_tdr)) ||
-           __kthread_should_park(sched->thread))
+           !cancel_delayed_work(&sched->work_tdr))) {
+               DRM_ERROR("DRM_ERROR cancel_delayed_work false - returning");
+               return;
+
+       }




--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4007,6 +4007,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
                device_list_handle = &device_list;
        }
 
+       DRM_ERROR("Waiting for bad job to finish %p", &job->base);
+       dma_fence_wait(&job->base.s_fence->finished, false);
        /* block all schedulers and reset given job's ring */
        list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
                if (tmp_adev != adev) {









--------------D7D3C42840796FBBBE0C9C93
Content-Type: text/x-log;
 name="crash.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="crash.log"

[   32.270341 <    0.001165>] #PF: supervisor read access in kernel mode
[   32.270934 <    0.000593>] #PF: error_code(0x0000) - not-present page
[   32.271520 <    0.000586>] PGD 8000000460346067 P4D 8000000460346067 PUD 460345067 PMD 0 
[   32.272108 <    0.000588>] Oops: 0000 [#1] SMP PTI
[   32.272695 <    0.000587>] CPU: 5 PID: 99 Comm: kworker/5:1 Tainted: G           OE     5.3.0-rc3-test-kfd+ #8
[   32.273288 <    0.000593>] Hardware name: System manufacturer System Product Name/Z170-PRO, BIOS 1902 06/27/2016
[   32.273881 <    0.000593>] Workqueue: events drm_sched_job_timedout [gpu_sched]
[   32.274505 <    0.000624>] RIP: 0010:amdgpu_device_gpu_recover+0x319/0xc20 [amdgpu]
[   32.275101 <    0.000596>] Code: 30 c6 44 24 2f 00 48 c7 c2 08 a4 66 c0 48 89 6c 24 30 48 89 6c 24 38 e9 60 fd ff ff 48 8b 44 24 10 48 85 c0 74 56 48 8b 40 10 <48> 8b 98 80 00 00 00 48 85 db 74 46 48 8b 43 30 a8 01 75 1e 48 8b
[   32.276401 <    0.001300>] RSP: 0018:ffffa6940036bd40 EFLAGS: 00010286
[   32.277055 <    0.000654>] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffa69400369960
[   32.277712 <    0.000657>] RDX: 0000000000000000 RSI: ffff8a1b23a620b0 RDI: ffff8a1b23a61800
[   32.278357 <    0.000645>] RBP: ffffa6940036bd70 R08: 0000000000000000 R09: 0000000000000001
[   32.278999 <    0.000642>] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a1b1fa266e8
[   32.279636 <    0.000637>] R13: 0000000000000000 R14: ffff8a1b20140c00 R15: ffff8a1b1fa266e8
[   32.280276 <    0.000640>] FS:  0000000000000000(0000) GS:ffff8a1b26340000(0000) knlGS:0000000000000000
[   32.280925 <    0.000649>] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.281567 <    0.000642>] CR2: 0000000000000080 CR3: 0000000460f50006 CR4: 00000000003606e0
[   32.282211 <    0.000644>] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   32.282860 <    0.000649>] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   32.283503 <    0.000643>] Call Trace:
[   32.284182 <    0.000679>]  amdgpu_job_timedout+0x123/0x140 [amdgpu]
[   32.284819 <    0.000637>]  ? drm_sched_job_timedout+0x4d/0xb0 [gpu_sched]
[   32.285451 <    0.000632>]  drm_sched_job_timedout+0x4d/0xb0 [gpu_sched]
[   32.286086 <    0.000635>]  process_one_work+0x1f1/0x600
[   32.286723 <    0.000637>]  worker_thread+0x4c/0x430
[   32.287361 <    0.000638>]  ? process_one_work+0x600/0x600
[   32.287993 <    0.000632>]  kthread+0x101/0x140
[   32.288616 <    0.000623>]  ? kthread_cancel_delayed_work_sync+0x10/0x10
[   32.289250 <    0.000634>]  ret_from_fork+0x24/0x30
[   32.289886 <    0.000636>] Modules linked in: amdgpu(OE) amd_iommu_v2 gpu_sched(OE) ttm(OE) x86_pkg_temp_thermal video acpi_pad
[   32.290549 <    0.000663>] CR2: 0000000000000080
[   32.291212 <    0.000663>] ---[ end trace 8a8ed840f9d52369 ]---
[   32.291902 <    0.000690>] RIP: 0010:amdgpu_device_gpu_recover+0x319/0xc20 [amdgpu]
[   32.292582 <    0.000680>] Code: 30 c6 44 24 2f 00 48 c7 c2 08 a4 66 c0 48 89 6c 24 30 48 89 6c 24 38 e9 60 fd ff ff 48 8b 44 24 10 48 85 c0 74 56 48 8b 40 10 <48> 8b 98 80 00 00 00 48 85 db 74 46 48 8b 43 30 a8 01 75 1e 48 8b
[   32.294026 <    0.001444>] RSP: 0018:ffffa6940036bd40 EFLAGS: 00010286
[   32.294751 <    0.000725>] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffa69400369960
[   32.295478 <    0.000727>] RDX: 0000000000000000 RSI: ffff8a1b23a620b0 RDI: ffff8a1b23a61800
[   32.296200 <    0.000722>] RBP: ffffa6940036bd70 R08: 0000000000000000 R09: 0000000000000001
[   32.296920 <    0.000720>] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a1b1fa266e8
[   32.297634 <    0.000714>] R13: 0000000000000000 R14: ffff8a1b20140c00 R15: ffff8a1b1fa266e8
[   32.298341 <    0.000707>] FS:  0000000000000000(0000) GS:ffff8a1b26340000(0000) knlGS:0000000000000000
[   32.299047 <    0.000706>] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.299749 <    0.000702>] CR2: 0000000000000080 CR3: 0000000460f50006 CR4: 00000000003606e0
[   32.300452 <    0.000703>] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   32.301151 <    0.000699>] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   32.301845 <    0.000694>] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:38
[   32.302543 <    0.000698>] in_atomic(): 0, irqs_disabled(): 1, pid: 99, name: kworker/5:1
[   32.303239 <    0.000696>] INFO: lockdep is turned off.
[   32.303928 <    0.000689>] irq event stamp: 121070
[   32.304610 <    0.000682>] hardirqs last  enabled at (121069): [<ffffffff8409a8f9>] cancel_delayed_work+0x69/0xa0
[   32.305303 <    0.000693>] hardirqs last disabled at (121070): [<ffffffff84001c5a>] trace_hardirqs_off_thunk+0x1a/0x20
[   32.305994 <    0.000691>] softirqs last  enabled at (120778): [<ffffffff8500036a>] __do_softirq+0x36a/0x425
[   32.306678 <    0.000684>] softirqs last disabled at (120771): [<ffffffff8407c943>] irq_exit+0xb3/0xc0
[   32.307358 <    0.000680>] CPU: 5 PID: 99 Comm: kworker/5:1 Tainted: G      D    OE     5.3.0-rc3-test-kfd+ #8
[   32.308044 <    0.000686>] Hardware name: System manufacturer System Product Name/Z170-PRO, BIOS 1902 06/27/2016
[   32.308734 <    0.000690>] Workqueue: events drm_sched_job_timedout [gpu_sched]
[   32.309419 <    0.000685>] Call Trace:
[   32.310097 <    0.000678>]  dump_stack+0x5e/0x8b
[   32.310767 <    0.000670>]  ___might_sleep+0x20c/0x240
[   32.311429 <    0.000662>]  exit_signals+0x30/0x340
[   32.312086 <    0.000657>]  do_exit+0xc0/0xc80
[   32.312710 <    0.000624>]  ? process_one_work+0x600/0x600
[   32.313300 <    0.000590>]  ? kthread+0x101/0x140
[   32.313884 <    0.000584>]  rewind_stack_do_exit+0x17/0x20


--------------D7D3C42840796FBBBE0C9C93
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--------------D7D3C42840796FBBBE0C9C93--
