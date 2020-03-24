Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EE9C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 17:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BC0206F6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 17:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uPQVmLgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BC0206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2482D89D81;
	Tue, 24 Mar 2020 17:58:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EB089D81
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 17:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkhAHXl66cmcpcsUMI/0xZfRRDr9QUacW+0Qp2jGHQ6cfR4/XMidcqM3D9oIB3w6HA8RjxN9IlR7XTbKJ7iZUowro3VmkuHyUM/DBY/JfRofu9QRXvEaCAnBGhzNgqzT7H3Hxbsu/IuCdzzufgI33IQrHBySdb1qptnsRm70uYxz7Cd/pC9HYqca8QP+MroG4rAG4YO6Uxv4PvrR+vW563m18OeZICf37oL6wHKqrRGgcn+mt3euglYxWbI8NNbh6R6fsJc2Jx0pbmqLgjAmQZNedRPNozID8boYDrxyMBGDAfcE+Q6gNYp+RBrOOBNUiNb8/+5SQIeOIVzU5hm2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrC0wsx8O4XZusXWXGq6f5PYKUkRdO/+O4NyyzgqYR8=;
 b=PoBAl2Ysr9PKitpTPfFYKTTZ5t+ViCTzsyDI6Lo0Lieg4Ao7/iaSYr9MMO7OygT3txnKcYQ1D2En6mLoioNCG308d3mhjxZGpeAu6tcVsZUmMT5qoaGyvXrf26UzhqRMWXOVIb64fTg1b0tq8DVE7Am61KBmnfIyel91De5XpXyQd4YIezpxDvkK8+n7vsEOoCSuOC0qN6Ar3Vaz9YMdC/8FMTVLNlCRTIonbUqsrSr5i1V0HFNmJ+LcfAzVyi5j5znlwUDE1FVgQmL8bUbXQV0UMGzEj00qDzzFT72TBV/qErtQ12jP6cxKR6FDte26sMksAG79tTVN7u4t12/VJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrC0wsx8O4XZusXWXGq6f5PYKUkRdO/+O4NyyzgqYR8=;
 b=uPQVmLgIATvJawGdXIn1LgHP9oYEeySmFofyiZ8z5y/dRpljeR5MnU0/T5SXmT46KEQ6RcysF7+jN9JSDzABNvsdzSUucKdIGNd6tSTqPcjjpmk89v0WEtPjpaGB52QY1/LUSAHiy4sN8MfgprjHa0QESpcLH/+2ZBQCUDFEHBo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB2501.namprd12.prod.outlook.com (2603:10b6:4:b4::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 17:58:49 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f%11]) with mapi id 15.20.2835.021; Tue, 24 Mar
 2020 17:58:49 +0000
Subject: Re: [PATCH] drm/amdgpu: hold the reference of finished fence
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Tao, Yintian" <Yintian.Tao@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20200323142247.3175-1-yttao@amd.com>
 <2a6a579f-062c-3911-d06a-d4e51f5815a3@amd.com>
 <SN6PR12MB2800A5049C6AB62B7A002AC987F10@SN6PR12MB2800.namprd12.prod.outlook.com>
 <be0e40cf-3ecf-ebe8-2d73-1dd937450c18@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f6c79722-8b95-5ea5-7910-5c11b9308d21@amd.com>
Date: Tue, 24 Mar 2020 18:58:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <be0e40cf-3ecf-ebe8-2d73-1dd937450c18@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 17:58:48 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9826bf88-f74e-44f9-f7bd-08d7d01d014c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2501:|DM5PR12MB2501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2501226D07C0D29AA24E9D0D83F10@DM5PR12MB2501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(4326008)(110136005)(66556008)(45080400002)(2906002)(6486002)(316002)(66946007)(36756003)(6666004)(30864003)(16526019)(66476007)(966005)(186003)(478600001)(53546011)(81156014)(8676002)(6636002)(81166006)(31696002)(86362001)(8936002)(31686004)(52116002)(5660300002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2501;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwWhLYtfNRX/KBCI4009k/rdCNUW2ekSSXjmUmwYtjzSvMJVyVEx0bwULiRCEDtkjQJNIyWwWHlM/qoUtHUIjNksfamjPsaQ0ZrwaiwfFkQmLtRzSB68u0kTm1wZSRUBlS+fbcidT/8c+Ej/TcglJsjCYz/9CPeOJvCY5c31WOxDq9VU9wyuVQZPS5sp9LJ/13Q4AoqI94MB7aB/jActCC4NKRbZTesjGD3lzTp+DsTomKxKnqLhkaQDOhIvf5mAfdfMqnhu20kaS412EE28jAznCtqrtjDiXpjTjg8IQgzNVvkp7FyjRqO+E3cW5PScqOo9S5/snCxIYqXjXcobQXF0lyBYQcNj7Vt+ROzQZu51vj032YK3Bht7BBxeaBcv3YhHhWWSz+9pI/qH3gTSc5XtCyCErec3TGvuaOpqlDuqRS21OkhkxHdK6tvmritlaIZqpvayUHlpP1buN0KDT/eznAtHpglDf3uYn2+UsU4=
X-MS-Exchange-AntiSpam-MessageData: axm3Y9GdCBSIee2vlEh7LVrhbt3oHEg2CAKKH4DoIZYvqSXg4ZhpcSuwwacbiQrkj1b2k691TAaw8UB30Nl9EvF5pBaMVhZKeYpG989nqe8/u1caeMjH71Zgiyrdsiwkk+Mv8D+j3jP/+iRFJHx97x59bqub5gTQ6tXPbFzeIB+wD0ouUUFEUUZy15QU0bhCxvI8xPoX/wgLLzcCjQQpJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9826bf88-f74e-44f9-f7bd-08d7d01d014c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 17:58:49.4293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84HUd1HjWi1shK2HBAL/vSa7huw9LtzuOCylZlNxB2oZUsX0ap2g5JRVCh5SFiNs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2501
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0916496890=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0916496890==
Content-Type: multipart/alternative;
 boundary="------------3E701180CBF8BAACBA4DF71D"
Content-Language: en-US

--------------3E701180CBF8BAACBA4DF71D
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

There is a misunderstanding here:

> Did you find out why the zero refcount on the finished fence happens
> before the fence was signaled ?

The refcount on the finished fence doesn't become zero before it is 
signaled, it becomes zero while it is signaled.

CPU 1 calls dma_fence_signal(fence) without holding a reference to the 
fence. CPU 2 at the same time checks if the fence is signaled and frees 
the last reference because it find the signaled flag to be set.

The problem is now that dma_fence_signal() wants to set the timestamp 
after setting the signaled flag and now races with freeing the memory.

That's a really hard to hit problem, but it indeed seems to be possible.

Christian.

Am 24.03.20 um 15:52 schrieb Andrey Grodzovsky:
>
> This is only for the guilty job which was removed from the 
> ring_mirror_list due to completion and hence will not be resubmitted 
> by recovery and will not be freed by the usual flow in 
> drm_sched_get_cleanup_job (see drm_sched_stop)
>
> Andrey
>
> On 3/24/20 10:45 AM, Pan, Xinhui wrote:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> Does this issue occur when gpu recovery?
>> I just check the code,  fence timedout will free job and put its 
>> fence. but gpu recovery might resubmit job.
>> Correct me if I am wrong.
>> ------------------------------------------------------------------------
>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
>> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>> *Sent:* Tuesday, March 24, 2020 11:40:06 AM
>> *To:* Tao, Yintian <Yintian.Tao@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>
>> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Subject:* Re: [PATCH] drm/amdgpu: hold the reference of finished fence
>>
>> On 3/23/20 10:22 AM, Yintian Tao wrote:
>> > There is one one corner case at dma_fence_signal_locked
>> > which will raise the NULL pointer problem just like below.
>> > ->dma_fence_signal
>> >      ->dma_fence_signal_locked
>> >        ->test_and_set_bit
>> > here trigger dma_fence_release happen due to the zero of fence 
>> refcount.
>>
>>
>> Did you find out why the zero refcount on the finished fence happens
>> before the fence was signaled ? The finished fence is created with
>> refcount set to 1 in drm_sched_fence_create->dma_fence_init and then the
>> refcount is decremented in
>> drm_sched_main->amdgpu_job_free_cb->drm_sched_job_cleanup. This should
>> only happen after fence is already signaled (see
>> drm_sched_get_cleanup_job). On top of that the finished fence is
>> referenced from other places (e.g. entity->last_scheduled e.t.c)...
>>
>>
>> >
>> > ->dma_fence_put
>> >      ->dma_fence_release
>> >        ->drm_sched_fence_release_scheduled
>> >            ->call_rcu
>> > here make the union fled “cb_list” at finished fence
>> > to NULL because struct rcu_head contains two pointer
>> > which is same as struct list_head cb_list
>> >
>> > Therefore, to hold the reference of finished fence at 
>> drm_sched_process_job
>> > to prevent the null pointer during finished fence dma_fence_signal
>> >
>> > [  732.912867] BUG: kernel NULL pointer dereference, address: 
>> 0000000000000008
>> > [  732.914815] #PF: supervisor write access in kernel mode
>> > [  732.915731] #PF: error_code(0x0002) - not-present page
>> > [  732.916621] PGD 0 P4D 0
>> > [  732.917072] Oops: 0002 [#1] SMP PTI
>> > [  732.917682] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G           
>> OE     5.4.0-rc7 #1
>> > [  732.918980] Hardware name: QEMU Standard PC (i440FX + PIIX, 
>> 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
>> > [  732.920906] RIP: 0010:dma_fence_signal_locked+0x3e/0x100
>> > [  732.938569] Call Trace:
>> > [  732.939003]  <IRQ>
>> > [  732.939364]  dma_fence_signal+0x29/0x50
>> > [  732.940036] drm_sched_fence_finished+0x12/0x20 [gpu_sched]
>> > [  732.940996]  drm_sched_process_job+0x34/0xa0 [gpu_sched]
>> > [  732.941910] dma_fence_signal_locked+0x85/0x100
>> > [  732.942692]  dma_fence_signal+0x29/0x50
>> > [  732.943457]  amdgpu_fence_process+0x99/0x120 [amdgpu]
>> > [  732.944393] sdma_v4_0_process_trap_irq+0x81/0xa0 [amdgpu]
>> >
>> > v2: hold the finished fence at drm_sched_process_job instead of
>> >      amdgpu_fence_process
>> > v3: resume the blank line
>> >
>> > Signed-off-by: Yintian Tao <yttao@amd.com>
>> > ---
>> >   drivers/gpu/drm/scheduler/sched_main.c | 2 ++
>> >   1 file changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> > index a18eabf692e4..8e731ed0d9d9 100644
>> > --- a/drivers/gpu/drm/scheduler/sched_main.c
>> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> > @@ -651,7 +651,9 @@ static void drm_sched_process_job(struct 
>> dma_fence *f, struct dma_fence_cb *cb)
>> >
>> >        trace_drm_sched_process_job(s_fence);
>> >
>> > +     dma_fence_get(&s_fence->finished);
>> >        drm_sched_fence_finished(s_fence);
>>
>>
>> If the fence was already released during call to
>> drm_sched_fence_finished->dma_fence_signal->... why is it safe to
>> reference the s_fence just before that call ? Can't it already be
>> released by this time ?
>>
>> Andrey
>>
>>
>>
>> > +     dma_fence_put(&s_fence->finished);
>> > wake_up_interruptible(&sched->wake_up_worker);
>> >   }
>> >
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cxinhui.pan%40amd.com%7C65933fca0b414d12aab408d7cfa51165%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637206180230440562&amp;sdata=z6ec%2BcWkwjaDgZvkpL3jOMYkBtDjbNOxlXiAk4Ri5Ck%3D&amp;reserved=0


--------------3E701180CBF8BAACBA4DF71D
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">There is a misunderstanding here:<br>
      <br>
      <blockquote type="cite"><font size="2"><span style="font-size:11pt;"> Did you find out why the zero
            refcount on the finished fence happens <br>
            before the fence was signaled ?</span></font></blockquote>
      <br>
      The refcount on the finished fence doesn't become zero before it
      is signaled, it becomes zero while it is signaled.<br>
      <br>
      CPU 1 calls dma_fence_signal(fence) without holding a reference to
      the fence. CPU 2 at the same time checks if the fence is signaled
      and frees the last reference because it find the signaled flag to
      be set.<br>
      <br>
      The problem is now that dma_fence_signal() wants to set the
      timestamp after setting the signaled flag and now races with
      freeing the memory.<br>
      <br>
      That's a really hard to hit problem, but it indeed seems to be
      possible.<br>
      <br>
      Christian.<br>
      <br>
      Am 24.03.20 um 15:52 schrieb Andrey Grodzovsky:<br>
    </div>
    <blockquote type="cite" cite="mid:be0e40cf-3ecf-ebe8-2d73-1dd937450c18@amd.com">
      
      <p>This is only for the guilty job which was removed from the
        ring_mirror_list due to completion and hence will not be
        resubmitted by recovery and will not be freed by the usual flow
        in drm_sched_get_cleanup_job (see drm_sched_stop)</p>
      <p>Andrey<br>
      </p>
      <div class="moz-cite-prefix">On 3/24/20 10:45 AM, Pan, Xinhui
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:SN6PR12MB2800A5049C6AB62B7A002AC987F10@SN6PR12MB2800.namprd12.prod.outlook.com">
        <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left"> [AMD Official Use Only - Internal Distribution
          Only]<br>
        </p>
        <br>
        <div>
          <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
            font-family: sans-serif; font-size: 11pt; color: black; ">
            Does this issue occur when gpu recovery?<br>
          </div>
          <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
            font-family: sans-serif; font-size: 11pt; color: black; "> I
            just check the code,&nbsp; fence timedout will free job and put
            its fence. but gpu recovery might resubmit job. <br>
          </div>
          <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
            font-family: sans-serif; font-size: 11pt; color: black; ">
            Correct me if I am wrong.</div>
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
              on behalf of Andrey Grodzovsky <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com" moz-do-not-send="true">&lt;Andrey.Grodzovsky@amd.com&gt;</a><br>
              <b>Sent:</b> Tuesday, March 24, 2020 11:40:06 AM<br>
              <b>To:</b> Tao, Yintian <a class="moz-txt-link-rfc2396E" href="mailto:Yintian.Tao@amd.com" moz-do-not-send="true">&lt;Yintian.Tao@amd.com&gt;</a>;
              Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
              Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
              <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: hold the reference
              of finished fence</font>
            <div>&nbsp;</div>
          </div>
          <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
                <div class="PlainText"><br>
                  On 3/23/20 10:22 AM, Yintian Tao wrote:<br>
                  &gt; There is one one corner case at
                  dma_fence_signal_locked<br>
                  &gt; which will raise the NULL pointer problem just
                  like below.<br>
                  &gt; -&gt;dma_fence_signal<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;dma_fence_signal_locked<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;test_and_set_bit<br>
                  &gt; here trigger dma_fence_release happen due to the
                  zero of fence refcount.<br>
                  <br>
                  <br>
                  Did you find out why the zero refcount on the finished
                  fence happens <br>
                  before the fence was signaled ? The finished fence is
                  created with <br>
                  refcount set to 1 in
                  drm_sched_fence_create-&gt;dma_fence_init and then the
                  <br>
                  refcount is decremented in <br>
drm_sched_main-&gt;amdgpu_job_free_cb-&gt;drm_sched_job_cleanup. This
                  should <br>
                  only happen after fence is already signaled (see <br>
                  drm_sched_get_cleanup_job). On top of that the
                  finished fence is <br>
                  referenced from other places (e.g.
                  entity-&gt;last_scheduled e.t.c)...<br>
                  <br>
                  <br>
                  &gt;<br>
                  &gt; -&gt;dma_fence_put<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;dma_fence_release<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;drm_sched_fence_release_scheduled<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;call_rcu<br>
                  &gt; here make the union fled “cb_list” at finished
                  fence<br>
                  &gt; to NULL because struct rcu_head contains two
                  pointer<br>
                  &gt; which is same as struct list_head cb_list<br>
                  &gt;<br>
                  &gt; Therefore, to hold the reference of finished
                  fence at drm_sched_process_job<br>
                  &gt; to prevent the null pointer during finished fence
                  dma_fence_signal<br>
                  &gt;<br>
                  &gt; [&nbsp; 732.912867] BUG: kernel NULL pointer
                  dereference, address: 0000000000000008<br>
                  &gt; [&nbsp; 732.914815] #PF: supervisor write access in
                  kernel mode<br>
                  &gt; [&nbsp; 732.915731] #PF: error_code(0x0002) -
                  not-present page<br>
                  &gt; [&nbsp; 732.916621] PGD 0 P4D 0<br>
                  &gt; [&nbsp; 732.917072] Oops: 0002 [#1] SMP PTI<br>
                  &gt; [&nbsp; 732.917682] CPU: 7 PID: 0 Comm: swapper/7
                  Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp; 5.4.0-rc7 #1<br>
                  &gt; [&nbsp; 732.918980] Hardware name: QEMU Standard PC
                  (i440FX &#43; PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by
                  qemu-project.org 04/01/2014<br>
                  &gt; [&nbsp; 732.920906] RIP:
                  0010:dma_fence_signal_locked&#43;0x3e/0x100<br>
                  &gt; [&nbsp; 732.938569] Call Trace:<br>
                  &gt; [&nbsp; 732.939003]&nbsp; &lt;IRQ&gt;<br>
                  &gt; [&nbsp; 732.939364]&nbsp; dma_fence_signal&#43;0x29/0x50<br>
                  &gt; [&nbsp; 732.940036]&nbsp;
                  drm_sched_fence_finished&#43;0x12/0x20 [gpu_sched]<br>
                  &gt; [&nbsp; 732.940996]&nbsp; drm_sched_process_job&#43;0x34/0xa0
                  [gpu_sched]<br>
                  &gt; [&nbsp; 732.941910]&nbsp;
                  dma_fence_signal_locked&#43;0x85/0x100<br>
                  &gt; [&nbsp; 732.942692]&nbsp; dma_fence_signal&#43;0x29/0x50<br>
                  &gt; [&nbsp; 732.943457]&nbsp; amdgpu_fence_process&#43;0x99/0x120
                  [amdgpu]<br>
                  &gt; [&nbsp; 732.944393]&nbsp;
                  sdma_v4_0_process_trap_irq&#43;0x81/0xa0 [amdgpu]<br>
                  &gt;<br>
                  &gt; v2: hold the finished fence at
                  drm_sched_process_job instead of<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_process<br>
                  &gt; v3: resume the blank line<br>
                  &gt;<br>
                  &gt; Signed-off-by: Yintian Tao <a class="moz-txt-link-rfc2396E" href="mailto:yttao@amd.com" moz-do-not-send="true">&lt;yttao@amd.com&gt;</a><br>
                  &gt; ---<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c | 2 &#43;&#43;<br>
                  &gt;&nbsp;&nbsp; 1 file changed, 2 insertions(&#43;)<br>
                  &gt;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/scheduler/sched_main.c
                  b/drivers/gpu/drm/scheduler/sched_main.c<br>
                  &gt; index a18eabf692e4..8e731ed0d9d9 100644<br>
                  &gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
                  &gt; &#43;&#43;&#43; b/drivers/gpu/drm/scheduler/sched_main.c<br>
                  &gt; @@ -651,7 &#43;651,9 @@ static void
                  drm_sched_process_job(struct dma_fence *f, struct
                  dma_fence_cb *cb)<br>
                  &gt;&nbsp;&nbsp; <br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_drm_sched_process_job(s_fence);<br>
                  &gt;&nbsp;&nbsp; <br>
                  &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_get(&amp;s_fence-&gt;finished);<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_fence_finished(s_fence);<br>
                  <br>
                  <br>
                  If the fence was already released during call to <br>
                  drm_sched_fence_finished-&gt;dma_fence_signal-&gt;...
                  why is it safe to <br>
                  reference the s_fence just before that call ? Can't it
                  already be <br>
                  released by this time ?<br>
                  <br>
                  Andrey<br>
                  <br>
                  <br>
                  <br>
                  &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(&amp;s_fence-&gt;finished);<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  wake_up_interruptible(&amp;sched-&gt;wake_up_worker);<br>
                  &gt;&nbsp;&nbsp; }<br>
                  &gt;&nbsp;&nbsp; <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                  <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cxinhui.pan%40amd.com%7C65933fca0b414d12aab408d7cfa51165%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637206180230440562&amp;amp;sdata=z6ec%2BcWkwjaDgZvkpL3jOMYkBtDjbNOxlXiAk4Ri5Ck%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cxinhui.pan%40amd.com%7C65933fca0b414d12aab408d7cfa51165%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637206180230440562&amp;amp;sdata=z6ec%2BcWkwjaDgZvkpL3jOMYkBtDjbNOxlXiAk4Ri5Ck%3D&amp;amp;reserved=0</a><br>
                </div>
              </span></font></div>
        </div>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------3E701180CBF8BAACBA4DF71D--

--===============0916496890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0916496890==--
