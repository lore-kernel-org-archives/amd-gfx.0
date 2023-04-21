Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DE8C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 13:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B3710EE09;
	Fri, 21 Apr 2023 13:40:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1794610EE09
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 13:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYCCI6HXsurvtTU+32e/C0Hg8INxoMuArJ2MC/9lPou91KjCQ8psDxTjQX23mJ7cj5a2iBsxaXWjDwN8d5x28Ci38qyJfEuDnGv0/DDidouXiZYZvDX66vnt3T+smG9Sn0N60UGL14cFWEubnHj2wJ/qNMvWv/U3l/8hTM9i3lhpHZKxxYuVkH6QSVh5veAu7eK0ImwMBWxhXY4zimu9qFmq4twxFUrshPFcrKH8yt0pMoX2FAoyQu2DEurfjyYHkf+DuEws5cPsMqcBb/qvEu29cknE1xZFSS2cA1f2PIAxDjl99TdR+s9JR0MxxphLwvN/DVz6QqcfOAcDoS57uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT3mRQQpw25sEq4a/Fg6C3KTFV6lo8y6/8JomOVdCow=;
 b=WYH2KiAJid7P2kOE5u+n3CavbTfPaUan3vOfkNZCigp40CXVXV5aMeERVwwAnSGX7EtAxWDRDcn0rJrQ8u59/9Wf4Kq2qD5PPkiUV76QqpByC/JAZITX2vIl+OvciIyxZcZP9abE1yeh/aQalGaH69KY6b+M8hv8Jzc8+mQ+DV8YkS0mehgm5bu/nCr9n65z9yBJvPujLx2cpZAWzpPk0dWfhEPyBrootNYKDtXpnY10vc+X7JO2YCIUcHs05yh0DVwiScwAz2QG3C+/ZKvMjEd6fudh5yTSZakANsI/7F6umB3lDAIKtBCd61F3GGqcm+q2FZxsxixVDIsGoHdHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT3mRQQpw25sEq4a/Fg6C3KTFV6lo8y6/8JomOVdCow=;
 b=GeTdfauotgKlMpmPVcmcY4wUeLXkc90Et/749xWCtJ1ub3thIkdgiuLhnSCUvU8bNJcsqzwbmwsNQo9NozUUSFABxniPWVi4LvokPU9ouYE0pEWtEkvURx8NwmTGw9EvKNB0uOet4tR+9605fd2TbumQXD5qaJznlybmdxWzWmg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 13:40:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::34de:5470:103b:594b]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::34de:5470:103b:594b%5]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:40:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/8] drm/scheduler: properly forward fence errors
Thread-Topic: [PATCH 1/8] drm/scheduler: properly forward fence errors
Thread-Index: AQHZc39cvkpdgTN+lUm+iOn/vsDzha81O6aAgACHRICAAANs9w==
Date: Fri, 21 Apr 2023 13:40:24 +0000
Message-ID: <BL1PR12MB5144DF199535F1DC66F981F4F7609@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230420115752.31470-1-christian.koenig@amd.com>
 <3d5dc70c-982a-8d86-cab2-f205c90c869d@amd.com>
 <99c31d32-05e2-70bc-c6fc-216eb2832d14@gmail.com>
In-Reply-To: <99c31d32-05e2-70bc-c6fc-216eb2832d14@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-21T13:40:24.618Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB6310:EE_
x-ms-office365-filtering-correlation-id: 861f01dc-1a7c-47ca-5745-08db426df60d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVjeH9Hnz4mmrpFTRMx+wq3ZZQNNAo6lhbSvjJqdIwDLKMVD8rHOX+7OU5kHPqEGBz1c1IFg3pXnV6Ro/UI5NT5ZY6N8+0yr48OF7+FTgmNNvV1KeqMrwUUFSk+pL7zy30QWrWF373QvZziOOMQVBq1wQfZESAFnGGKE2Wub1gNGE1HceJpxVV1+LgMCKgrEWIsm7kIAFiGb5et8+IjTl1ctWLIs2L4J1kiraxl9PEooTSvzDDwEmrNi6CsaA8FNcFn9xZ9/Zc9ZqGAOBr4Zn8vaugHofdLhIlS3L1HliVUhgOpQVo+VQn3KFo6svBzYF5e9gZ83ehJEm3/NegLdZUSCFMy/0iW4LqZYukqB8+YeSToiWjidZBxB/xv6NXCR/4t+6o64cbt9ln0L5kJYhTzH5w1F2PIdzrGW4ErGFPdWwhj6QQ8RkcRHTEMr6wc5yJfpizHLjk8uPoH2ti7t92wMY3z3zF/3pSHsp3cOYhcoMIOL263KbrM6vj64Jv73AB8BH9i8AH8FMSblNIWUwvUQ/ydIwtUfPmKk6i1y6dFHkOAj5HN8bfr/aCQ/n9FldfkrXo/2Xl5Usq4hq43f6W+89xkThSQN3BFbRj+JH9SLCfvYuVY9H1cDURfjqdOx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(186003)(38100700002)(122000001)(6506007)(26005)(71200400001)(38070700005)(9686003)(53546011)(55016003)(33656002)(5660300002)(66574015)(52536014)(8936002)(8676002)(2906002)(83380400001)(478600001)(86362001)(7696005)(110136005)(76116006)(66446008)(66476007)(41300700001)(66556008)(64756008)(66946007)(316002)(4326008)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NAE+GyGINLfQ086XsFoPA2r/LXakGWlTwOBxo2hgXP9txAY5eiUIs/r0RW?=
 =?iso-8859-1?Q?zPWAsenI5OJMI6vdTkAE4XVN8bce8vYCXnJ4ZvO1UIcPLkM1S6MkzfbtVT?=
 =?iso-8859-1?Q?AQjROPdMJveh2fvV7g17ubTopxg8M8EiR0iilzxboq5yIYyPW/WoFR6Dw8?=
 =?iso-8859-1?Q?KfdM3WdiJO10/zQ3e0xZ2SakFe9n6ShbVKbQGOqGYM50/h5Hnp+/F0Rqy6?=
 =?iso-8859-1?Q?zOZi99/MycHDuTMyK8QInAHL0WK5lk7A20ByQ//XzPnXIbNp/3Uc/VHPMa?=
 =?iso-8859-1?Q?vqxkpEQiI55JdQZ1N9DGMeh+F8GPyyUHLZsdIYyXXjMRyFZ8n908QwLIIk?=
 =?iso-8859-1?Q?uiBMN+Vx5yobFDLWIQBfFUVoYoivBGFhfXlBQNaRye8NdtKN9o2TFjwIxj?=
 =?iso-8859-1?Q?MH2oqtl3j9IvViNgx/MSPklSS/ZqStNoevYRG9+ZPVSsS743UYjCWbGrow?=
 =?iso-8859-1?Q?q18R54eCTn31eKUWr+k6akdY3cawPm/U/WJWcWsuYtc+C+kDwM4GtLjDXW?=
 =?iso-8859-1?Q?aalRqmljuRIR0L+OfajETfhMYiQRpn/UCoUvU+pY/X0Y2mvj8qgDUJRE3C?=
 =?iso-8859-1?Q?o75kk1kZJc9H+g6NNL0LHBUKZrF9t/oVNov6qO10eKk8GMQmGsfX0U0YTs?=
 =?iso-8859-1?Q?bpZa/MuQrv22RFyb7mIALke+KiLXGy3YnCs7VCKU3mFZd6IUb4t96cE9jy?=
 =?iso-8859-1?Q?OKUEysLYjcQ8x1QY6Hk4nFJHHGstMWR4HFdpSHVRMGVW+HRj5wZ9XWJw9V?=
 =?iso-8859-1?Q?4Mq1bmq8R50YJe6jD9X9U1x6wcqS5V7JLCn/M9xfZo4TQNoXSOfParzOpk?=
 =?iso-8859-1?Q?TF1X2frnYUqjuU0ZDbM/CbwMKGgnajrGdzZhHBG7mj7odyKXakVkYjZNsg?=
 =?iso-8859-1?Q?GNLg7dMB3C65r0PjkaY47xI3oxBm4fJXDn78SKdFL1DeeNgla1KGKrkSi4?=
 =?iso-8859-1?Q?Zpqeq/LRTuTqBs1OXiauX5JssEUpOmNCE+cKYW7D6feLrZ4JPtb75Vas+k?=
 =?iso-8859-1?Q?/L7SFA+0KHi1vBjTJSSrHsYBfL7haq9inKD2B3u95xlwvIehx6Cem72qqm?=
 =?iso-8859-1?Q?vGfKYmZnJ5LwUjhvrHd5S9eFCpENQYLo2nR7JD7EZCqxTreOy4BkFYVcWL?=
 =?iso-8859-1?Q?jVR5oyyL/04hkkLtQpcqWPzaSdTQ+LoCYoFmQA9PE138Qqq8fBIwKt6OG7?=
 =?iso-8859-1?Q?dmgKTKeM35gPMbSGbgcC9doVFk3PWrC3wW393ZKUp7q9LTJUmRNyDS5Q+o?=
 =?iso-8859-1?Q?VM5nuZoF2WUD+RkrxIlwFQhwWSWC/Sziw0dJFba736XU+Qd897m13Pp+pN?=
 =?iso-8859-1?Q?pJl8SHFne8NMbJ/7AltdcjhBLRGTQM/mub/qvGcU/wydhzwPuqBNmVRlSl?=
 =?iso-8859-1?Q?yiMZtAWYGEonSWJWB6kxPLN3MWWg8wOyiTcDEa24e9/ukDoA39PNznTEH2?=
 =?iso-8859-1?Q?ndTnWbvKm8TScCCGDn4oRaBVRSq7pUteShPUYFoy+fbuuXaPcVarCH4WKg?=
 =?iso-8859-1?Q?mmIfDHnGCBM08CdtTNpwUpUgl7fz1WS6eDF47dQ9KTVv5snGHkV88bOIaT?=
 =?iso-8859-1?Q?OTTaSMq1nbbmF7DJhjdymZOhGQa7wopy5caaTqrNm8U59jhgHWrYIkVNOW?=
 =?iso-8859-1?Q?UetXiTPd/kPgE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144DF199535F1DC66F981F4F7609BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861f01dc-1a7c-47ca-5745-08db426df60d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 13:40:24.9885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6wswITt1kMsAHbw2ZNi+3rbXI0rhYcK3yUm5aOD+I3TK2B4tm+Ymd9uDEAtiFJCgQ3cQYQELpsT3XHxMAbwJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144DF199535F1DC66F981F4F7609BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Sure.  We can pull it into amd-staging-drm-next as well if we need it for a=
ny customers in the short term.

Alex
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Friday, April 21, 2023 9:27 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>
Subject: Re: [PATCH 1/8] drm/scheduler: properly forward fence errors

Alex can I merge that through drm-misc-next or do we really need
amd-staging-drm-next?

Christian.

Am 21.04.23 um 07:22 schrieb Luben Tuikov:
> Hi Christian,
>
> Thanks for working on this.
>
> Series is,
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>
> Regards,
> Luben
>
> On 2023-04-20 07:57, Christian K=F6nig wrote:
>> When a hw fence is signaled with an error properly forward that to the
>> finished fence.
>>
>> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c |  4 +---
>>   drivers/gpu/drm/scheduler/sched_fence.c  |  4 +++-
>>   drivers/gpu/drm/scheduler/sched_main.c   | 18 ++++++++----------
>>   include/drm/gpu_scheduler.h              |  2 +-
>>   4 files changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/=
scheduler/sched_entity.c
>> index 15d04a0ec623..eaf71fe15ed3 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -144,7 +144,7 @@ static void drm_sched_entity_kill_jobs_work(struct w=
ork_struct *wrk)
>>   {
>>       struct drm_sched_job *job =3D container_of(wrk, typeof(*job), work=
);
>>
>> -    drm_sched_fence_finished(job->s_fence);
>> +    drm_sched_fence_finished(job->s_fence, -ESRCH);
>>       WARN_ON(job->s_fence->parent);
>>       job->sched->ops->free_job(job);
>>   }
>> @@ -195,8 +195,6 @@ static void drm_sched_entity_kill(struct drm_sched_e=
ntity *entity)
>>       while ((job =3D to_drm_sched_job(spsc_queue_pop(&entity->job_queue=
)))) {
>>               struct drm_sched_fence *s_fence =3D job->s_fence;
>>
>> -            dma_fence_set_error(&s_fence->finished, -ESRCH);
>> -
>>               dma_fence_get(&s_fence->finished);
>>               if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
>>                                          drm_sched_entity_kill_jobs_cb))
>> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/s=
cheduler/sched_fence.c
>> index 7fd869520ef2..1a6bea98c5cc 100644
>> --- a/drivers/gpu/drm/scheduler/sched_fence.c
>> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
>> @@ -53,8 +53,10 @@ void drm_sched_fence_scheduled(struct drm_sched_fence=
 *fence)
>>       dma_fence_signal(&fence->scheduled);
>>   }
>>
>> -void drm_sched_fence_finished(struct drm_sched_fence *fence)
>> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int result=
)
>>   {
>> +    if (result)
>> +            dma_fence_set_error(&fence->finished, result);
>>       dma_fence_signal(&fence->finished);
>>   }
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sc=
heduler/sched_main.c
>> index fcd4bfef7415..649fac2e1ccb 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -257,7 +257,7 @@ drm_sched_rq_select_entity_fifo(struct drm_sched_rq =
*rq)
>>    *
>>    * Finish the job's fence and wake up the worker thread.
>>    */
>> -static void drm_sched_job_done(struct drm_sched_job *s_job)
>> +static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
>>   {
>>       struct drm_sched_fence *s_fence =3D s_job->s_fence;
>>       struct drm_gpu_scheduler *sched =3D s_fence->sched;
>> @@ -268,7 +268,7 @@ static void drm_sched_job_done(struct drm_sched_job =
*s_job)
>>       trace_drm_sched_process_job(s_fence);
>>
>>       dma_fence_get(&s_fence->finished);
>> -    drm_sched_fence_finished(s_fence);
>> +    drm_sched_fence_finished(s_fence, result);
>>       dma_fence_put(&s_fence->finished);
>>       wake_up_interruptible(&sched->wake_up_worker);
>>   }
>> @@ -282,7 +282,7 @@ static void drm_sched_job_done_cb(struct dma_fence *=
f, struct dma_fence_cb *cb)
>>   {
>>       struct drm_sched_job *s_job =3D container_of(cb, struct drm_sched_=
job, cb);
>>
>> -    drm_sched_job_done(s_job);
>> +    drm_sched_job_done(s_job, f->error);
>>   }
>>
>>   /**
>> @@ -533,12 +533,12 @@ void drm_sched_start(struct drm_gpu_scheduler *sch=
ed, bool full_recovery)
>>                       r =3D dma_fence_add_callback(fence, &s_job->cb,
>>                                                  drm_sched_job_done_cb);
>>                       if (r =3D=3D -ENOENT)
>> -                            drm_sched_job_done(s_job);
>> +                            drm_sched_job_done(s_job, fence->error);
>>                       else if (r)
>>                               DRM_DEV_ERROR(sched->dev, "fence add callb=
ack failed (%d)\n",
>>                                         r);
>>               } else
>> -                    drm_sched_job_done(s_job);
>> +                    drm_sched_job_done(s_job, 0);
>>       }
>>
>>       if (full_recovery) {
>> @@ -1010,15 +1010,13 @@ static int drm_sched_main(void *param)
>>                       r =3D dma_fence_add_callback(fence, &sched_job->cb=
,
>>                                                  drm_sched_job_done_cb);
>>                       if (r =3D=3D -ENOENT)
>> -                            drm_sched_job_done(sched_job);
>> +                            drm_sched_job_done(sched_job, fence->error)=
;
>>                       else if (r)
>>                               DRM_DEV_ERROR(sched->dev, "fence add callb=
ack failed (%d)\n",
>>                                         r);
>>               } else {
>> -                    if (IS_ERR(fence))
>> -                            dma_fence_set_error(&s_fence->finished, PTR=
_ERR(fence));
>> -
>> -                    drm_sched_job_done(sched_job);
>> +                    drm_sched_job_done(sched_job, IS_ERR(fence) ?
>> +                                       PTR_ERR(fence) : 0);
>>               }
>>
>>               wake_up(&sched->job_scheduled);
>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>> index ca857ec9e7eb..5c1df6b12ced 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -569,7 +569,7 @@ void drm_sched_fence_init(struct drm_sched_fence *fe=
nce,
>>   void drm_sched_fence_free(struct drm_sched_fence *fence);
>>
>>   void drm_sched_fence_scheduled(struct drm_sched_fence *fence);
>> -void drm_sched_fence_finished(struct drm_sched_fence *fence);
>> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int result=
);
>>
>>   unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sche=
d);
>>   void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,


--_000_BL1PR12MB5144DF199535F1DC66F981F4F7609BL1PR12MB5144namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Sure.&nbsp; We can pull it into amd-staging-drm-next as well if we need it =
for any customers in the short term.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Friday, April 21, 2023 9:27 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/8] drm/scheduler: properly forward fence error=
s</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Alex can I merge that through drm-misc-next or do =
we really need
<br>
amd-staging-drm-next?<br>
<br>
Christian.<br>
<br>
Am 21.04.23 um 07:22 schrieb Luben Tuikov:<br>
&gt; Hi Christian,<br>
&gt;<br>
&gt; Thanks for working on this.<br>
&gt;<br>
&gt; Series is,<br>
&gt; Reviewed-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt; Luben<br>
&gt;<br>
&gt; On 2023-04-20 07:57, Christian K=F6nig wrote:<br>
&gt;&gt; When a hw fence is signaled with an error properly forward that to=
 the<br>
&gt;&gt; finished fence.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<=
br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_entity.c |&nbsp; 4 +--=
-<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_fence.c&nbsp; |&nbsp; =
4 +++-<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c&nbsp;&nbsp; | 1=
8 ++++++++----------<br>
&gt;&gt;&nbsp;&nbsp; include/drm/gpu_scheduler.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&gt;&gt;&nbsp;&nbsp; 4 files changed, 13 insertions(+), 15 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gp=
u/drm/scheduler/sched_entity.c<br>
&gt;&gt; index 15d04a0ec623..eaf71fe15ed3 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/scheduler/sched_entity.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/scheduler/sched_entity.c<br>
&gt;&gt; @@ -144,7 +144,7 @@ static void drm_sched_entity_kill_jobs_work(st=
ruct work_struct *wrk)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job =3D =
container_of(wrk, typeof(*job), work);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; drm_sched_fence_finished(job-&gt;s_fence);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; drm_sched_fence_finished(job-&gt;s_fence, -ESR=
CH);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(job-&gt;s_fence-&gt;pa=
rent);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;sched-&gt;ops-&gt;free=
_job(job);<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt; @@ -195,8 +195,6 @@ static void drm_sched_entity_kill(struct drm_s=
ched_entity *entity)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while ((job =3D to_drm_sched_j=
ob(spsc_queue_pop(&amp;entity-&gt;job_queue)))) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct drm_sched_fence *s_fence =3D job-&gt;s_fence;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; dma_fence_set_error(&amp;s_fence-&gt;finished, -ESRCH);<br>
&gt;&gt; -<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dma_fence_get(&amp;s_fence-&gt;finished);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!prev || dma_fence_add_callback(prev, &amp;job-&gt;fi=
nish_cb,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_entity_kill_jobs_cb))<br>
&gt;&gt; diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu=
/drm/scheduler/sched_fence.c<br>
&gt;&gt; index 7fd869520ef2..1a6bea98c5cc 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/scheduler/sched_fence.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/scheduler/sched_fence.c<br>
&gt;&gt; @@ -53,8 +53,10 @@ void drm_sched_fence_scheduled(struct drm_sched=
_fence *fence)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_signal(&amp;fence-&g=
t;scheduled);<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -void drm_sched_fence_finished(struct drm_sched_fence *fence)<br>
&gt;&gt; +void drm_sched_fence_finished(struct drm_sched_fence *fence, int =
result)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (result)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; dma_fence_set_error(&amp;fence-&gt;finished, result);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_signal(&amp;fence-&g=
t;finished);<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/=
drm/scheduler/sched_main.c<br>
&gt;&gt; index fcd4bfef7415..649fac2e1ccb 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt;&gt; @@ -257,7 +257,7 @@ drm_sched_rq_select_entity_fifo(struct drm_sch=
ed_rq *rq)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * Finish the job's fence and wake up the worker =
thread.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -static void drm_sched_job_done(struct drm_sched_job *s_job)<br>
&gt;&gt; +static void drm_sched_job_done(struct drm_sched_job *s_job, int r=
esult)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_fence *s_fenc=
e =3D s_job-&gt;s_fence;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sche=
d =3D s_fence-&gt;sched;<br>
&gt;&gt; @@ -268,7 +268,7 @@ static void drm_sched_job_done(struct drm_sche=
d_job *s_job)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_drm_sched_process_job(s_=
fence);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_get(&amp;s_fence-&gt=
;finished);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; drm_sched_fence_finished(s_fence);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; drm_sched_fence_finished(s_fence, result);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(&amp;s_fence-&gt=
;finished);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up_interruptible(&amp;sch=
ed-&gt;wake_up_worker);<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt; @@ -282,7 +282,7 @@ static void drm_sched_job_done_cb(struct dma_f=
ence *f, struct dma_fence_cb *cb)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *s_job =
=3D container_of(cb, struct drm_sched_job, cb);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; drm_sched_job_done(s_job);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; drm_sched_job_done(s_job, f-&gt;error);<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt; @@ -533,12 +533,12 @@ void drm_sched_start(struct drm_gpu_schedule=
r *sched, bool full_recovery)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma=
_fence_add_callback(fence, &amp;s_job-&gt;cb,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; drm_sched_job_done_cb);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=
=3D -ENOENT)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; drm_sched_job_done(s_job);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; drm_sched_job_done(s_job, fence-&gt;error);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (=
r)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEV_ERROR(sched-&gt;dev, &quot;f=
ence add callback failed (%d)\n&quot;,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; } else<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_job_done(s_job)=
;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_job_done(s_job,=
 0);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (full_recovery) {<br>
&gt;&gt; @@ -1010,15 +1010,13 @@ static int drm_sched_main(void *param)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma=
_fence_add_callback(fence, &amp;sched_job-&gt;cb,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; drm_sched_job_done_cb);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=
=3D -ENOENT)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; drm_sched_job_done(sched_job);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; drm_sched_job_done(sched_job, fence-&gt;error);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (=
r)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEV_ERROR(sched-&gt;dev, &quot;f=
ence add callback failed (%d)\n&quot;,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(fence))<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; dma_fence_set_error(&amp;s_fence-&gt;finished, PTR_E=
RR(fence));<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_job_done(sched_=
job);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_job_done(sched_=
job, IS_ERR(fence) ?<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; PTR_ERR(fence) : 0);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; wake_up(&amp;sched-&gt;job_scheduled);<br>
&gt;&gt; diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_schedul=
er.h<br>
&gt;&gt; index ca857ec9e7eb..5c1df6b12ced 100644<br>
&gt;&gt; --- a/include/drm/gpu_scheduler.h<br>
&gt;&gt; +++ b/include/drm/gpu_scheduler.h<br>
&gt;&gt; @@ -569,7 +569,7 @@ void drm_sched_fence_init(struct drm_sched_fen=
ce *fence,<br>
&gt;&gt;&nbsp;&nbsp; void drm_sched_fence_free(struct drm_sched_fence *fenc=
e);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp; void drm_sched_fence_scheduled(struct drm_sched_fence =
*fence);<br>
&gt;&gt; -void drm_sched_fence_finished(struct drm_sched_fence *fence);<br>
&gt;&gt; +void drm_sched_fence_finished(struct drm_sched_fence *fence, int =
result);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp; unsigned long drm_sched_suspend_timeout(struct drm_gpu=
_scheduler *sched);<br>
&gt;&gt;&nbsp;&nbsp; void drm_sched_resume_timeout(struct drm_gpu_scheduler=
 *sched,<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DF199535F1DC66F981F4F7609BL1PR12MB5144namp_--
