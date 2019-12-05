Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AF9C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF192245C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF192245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB766F4E4;
	Thu,  5 Dec 2019 13:03:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7863A6E0CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 13:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLnAzwdvULmvbHrRDNfxTq+aqXmJAUIG+0S2O4vWaFmU4FNC2OC8z6vBtE3Jjx84MII23wHBr0L3AvEKkzJlZ/LjAo58Xv2WSo/Eb4Ziz39qNME/DX4kzKegzhDLxsO71OhdIKsGqnfaNZSxCoaiCvo5/Q9ezwWN8YvvZxFFr63wCg8/opsrIKED/7HDhsprUnP0fhDvwnV85YnPG+re6as1fspdVIbUTQ3piTvAe5NbeNJFjamild0WOGn+VsQBlpYOQGtqNnEUglJPL2tTF573lqbQhQTZWeVdzSG/W5aWeNtCTVM4KtC6EUWx/+y9ojshVtc/l8sp3QQ052gJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMWXmO7J+t7WnC3ULcuMv9PEFnSywtkUIDrUxmcjuL4=;
 b=ZsZ+tAGYqRhuhHL+nhJLM/+TkXVRFlxt69PYWiMmp4csztQK2fffQGBXd9n8mq37NmkCS+A/aU7/MHmsbdm9G3zKNaNrn57jAi9UT0JSvLzsvUTligidjhAoVPKDc3XY0bFQ9sljG42LExOH2VzRdVILpaLR1nTN0H4FfC9FOXBCrCo8Uewd/RqmHSUovQfpWUJUoVm+HxGzsm8oiFUJ5bsv32neckzKoQm+fIxJjkrwtENTUP55mZesjBnGBd5ATIEQfCi9CSrvwlpIMP0fbRn7JlKB3ZMDJyRq6BCb5BZ8hZBUBfeFqEyR1NSGO2EN3XIoCi2cSiiVxIbctPpM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB2360.namprd12.prod.outlook.com (52.132.208.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 5 Dec 2019 13:03:10 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 13:03:10 +0000
From: "Das, Nirmoy" <Nirmoy.Das@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Nirmoy Das
 <nirmoy.aiemd@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Ho, Kenny" <Kenny.Ho@amd.com>
Subject: Re: [RFC PATCH] drm/scheduler: rework entity creation
Thread-Topic: [RFC PATCH] drm/scheduler: rework entity creation
Thread-Index: AQHVq1o44R5qBOWs4EWWkm8sTdgD0KerYOQAgAAXxoCAAAj6mQ==
Date: Thu, 5 Dec 2019 13:03:10 +0000
Message-ID: <DM5PR12MB23768833C317283FCC25646E8B5C0@DM5PR12MB2376.namprd12.prod.outlook.com>
References: <20191205105259.78636-1-nirmoy.das@amd.com>
 <6ad43025-72b0-2c94-9406-347856ea26ed@amd.com>,
 <5163725d-f108-25d6-e92f-e10c9663a7f4@amd.com>
In-Reply-To: <5163725d-f108-25d6-e92f-e10c9663a7f4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-05T13:01:56.5291834Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
x-originating-ip: [2.247.252.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4420b942-92cd-4022-3be7-08d779837b01
x-ms-traffictypediagnostic: DM5PR12MB2360:|DM5PR12MB2360:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2360D84F62640220893E41778B5C0@DM5PR12MB2360.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(8676002)(33656002)(66476007)(66946007)(71190400001)(6636002)(66556008)(66446008)(14444005)(110136005)(99286004)(71200400001)(76116006)(26005)(186003)(86362001)(91956017)(14454004)(478600001)(64756008)(74316002)(4326008)(81156014)(55016002)(30864003)(8936002)(229853002)(54896002)(25786009)(81166006)(9686003)(2906002)(11346002)(76176011)(53546011)(6506007)(102836004)(7696005)(5660300002)(52536014)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2360;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9dGegYqxTm86duNYafigTdevyQDlZh3QzZlLEwBC02OPvV1T7aTTMJZ9chJWw13zAgyPo53/nPx2niyuog0r8H56pA7Nj/n56T7Eu3kJJeSYKHYPbF3fAjAluLBibAOVF/WwdWx15g+RZ3Vhnkj+PeNqcGXIAGMA/Oj72GWo9HAgpMFX/+Jzi4VblBLl/xWT0iKiP4QNTtzKuO1XSUZgMQyt3+5vc/D7BBI9/bh1JNP6hog4FKTKeQtdL+Xacnuc8FnGJp4S2csvVZkh7DYO4Gt7U7y0tLqA0DNd7cujv5+LpJYIcLRg6lGQoi7tg54AhaTnrtan6EsoHwF0266soWxZxBKlo67okoKGeJqYZqovNXtvDxMmJFgD7k27nTM98mSoQqsjbC1zTQzY2MYp5BVrc2ffpECLJ2A/LrXlF1B1kpPR1AKDIu/A6UAQmeWx
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4420b942-92cd-4022-3be7-08d779837b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 13:03:10.6080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVRQVP5URoPh1Ot3Dg5JpaBR+AjVdZ2d9l3fdv3vk9sJK4RuEGS7jp+cw7TURjEpJIaxb8BzGsSrXHh5OR2+6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMWXmO7J+t7WnC3ULcuMv9PEFnSywtkUIDrUxmcjuL4=;
 b=frwxhDKQ8JYfuEwfhuxfwDvyl3oQIAxsw+PCJqr+vIgA64oLaMvq86e4uP1Gqo2UxLCagkLZNLzlGwtLzOZU1coxDi2QaDCSUHR9yPk75b9As+QeFSwZ735/ElcDZh/sa5F6BWjGhIUo/Mtsr7dqOgKOD5wxXKOpN/vYaALSw3s=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1843003548=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1843003548==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB23768833C317283FCC25646E8B5C0DM5PR12MB2376namp_"

--_000_DM5PR12MB23768833C317283FCC25646E8B5C0DM5PR12MB2376namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks Christian,


I will modify and resend.

Regards,
Nirmoy
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, December 5, 2019 1:29:49 PM
To: Das, Nirmoy <Nirmoy.Das@amd.com>; Nirmoy Das <nirmoy.aiemd@gmail.com>; =
Deucher, Alexander <Alexander.Deucher@amd.com>; Ho, Kenny <Kenny.Ho@amd.com=
>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Das, Nir=
moy <Nirmoy.Das@amd.com>
Subject: Re: [RFC PATCH] drm/scheduler: rework entity creation

Am 05.12.19 um 12:04 schrieb Nirmoy:
> Hi Christian,
>
> I am not exactly sure about drm_sched_entity_set_priority() I wonder
> if just changing
>
> entity->priority  to ctx->override_priority should work. With this
> change drm_sched_entity_select_rq()
>
> will chose a rq based on entity->priority which seems to me correct.
> But is this enough to fix the old bug you were
>
> talking about which mess up already scheduled job on priority change?

Yes, that should perfectly do it.

>
> okay I just realized I need a lock to make sure
>
> drm_sched_entity_set_priority() and drm_sched_entity_select_rq()
> shouldn't happen at the same time.

Yeah, you probably need to grab the lock and make sure that you get the
priority to use while holding the lock as well.

Regards,
Christian.

>
>
> Regards,
>
> Nirmoy
>
>
> On 12/5/19 11:52 AM, Nirmoy Das wrote:
>> Entity currently keeps a copy of run_queue list and modify it in
>> drm_sched_entity_set_priority(). Entities shouldn't modify run_queue
>> list. Use drm_gpu_scheduler list instead of drm_sched_rq list
>> in drm_sched_entity struct. In this way we can select a runqueue based
>> on entity/ctx's priority for a  drm scheduler.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  |  7 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  |  7 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c  |  7 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  |  7 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 14 +++--
>>   drivers/gpu/drm/etnaviv/etnaviv_drv.c    |  8 +--
>>   drivers/gpu/drm/lima/lima_sched.c        |  5 +-
>>   drivers/gpu/drm/panfrost/panfrost_job.c  |  7 +--
>>   drivers/gpu/drm/scheduler/sched_entity.c | 65 +++++++++---------------
>>   drivers/gpu/drm/v3d/v3d_drv.c            |  7 +--
>>   include/drm/gpu_scheduler.h              |  9 ++--
>>   11 files changed, 69 insertions(+), 74 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index a0d3d7b756eb..e8f46c13d073 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -122,7 +122,7 @@ static int amdgpu_ctx_init(struct amdgpu_device
>> *adev,
>>         for (i =3D 0; i < AMDGPU_HW_IP_NUM; ++i) {
>>           struct amdgpu_ring *rings[AMDGPU_MAX_RINGS];
>> -        struct drm_sched_rq *rqs[AMDGPU_MAX_RINGS];
>> +        struct drm_gpu_scheduler *sched_list[AMDGPU_MAX_RINGS];
>>           unsigned num_rings =3D 0;
>>           unsigned num_rqs =3D 0;
>>   @@ -181,12 +181,13 @@ static int amdgpu_ctx_init(struct
>> amdgpu_device *adev,
>>               if (!rings[j]->adev)
>>                   continue;
>>   -            rqs[num_rqs++] =3D &rings[j]->sched.sched_rq[priority];
>> +            sched_list[num_rqs++] =3D &rings[j]->sched;
>>           }
>>             for (j =3D 0; j < amdgpu_ctx_num_entities[i]; ++j)
>>               r =3D drm_sched_entity_init(&ctx->entities[i][j].entity,
>> -                          rqs, num_rqs, &ctx->guilty);
>> +                          sched_list, num_rqs,
>> +                          &ctx->guilty, priority);
>>           if (r)
>>               goto error_cleanup_entities;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 19ffe00d9072..a960dd7c0711 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1957,11 +1957,12 @@ void
>> amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool
>> enable)
>>         if (enable) {
>>           struct amdgpu_ring *ring;
>> -        struct drm_sched_rq *rq;
>> +        struct drm_gpu_scheduler *sched;
>>             ring =3D adev->mman.buffer_funcs_ring;
>> -        rq =3D &ring->sched.sched_rq[DRM_SCHED_PRIORITY_KERNEL];
>> -        r =3D drm_sched_entity_init(&adev->mman.entity, &rq, 1, NULL);
>> +        sched =3D &ring->sched;
>> +        r =3D drm_sched_entity_init(&adev->mman.entity, &sched,
>> +                      1, NULL, DRM_SCHED_PRIORITY_KERNEL);
>>           if (r) {
>>               DRM_ERROR("Failed setting up TTM BO move entity (%d)\n",
>>                     r);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> index e324bfe6c58f..b803a8882864 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> @@ -330,12 +330,13 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>>   int amdgpu_uvd_entity_init(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_ring *ring;
>> -    struct drm_sched_rq *rq;
>> +    struct drm_gpu_scheduler *sched;
>>       int r;
>>         ring =3D &adev->uvd.inst[0].ring;
>> -    rq =3D &ring->sched.sched_rq[DRM_SCHED_PRIORITY_NORMAL];
>> -    r =3D drm_sched_entity_init(&adev->uvd.entity, &rq, 1, NULL);
>> +    sched =3D &ring->sched;
>> +    r =3D drm_sched_entity_init(&adev->uvd.entity, &sched,
>> +                  1, NULL, DRM_SCHED_PRIORITY_NORMAL);
>>       if (r) {
>>           DRM_ERROR("Failed setting up UVD kernel entity.\n");
>>           return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> index 46b590af2fd2..b44f28d44fb4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> @@ -240,12 +240,13 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>>   int amdgpu_vce_entity_init(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_ring *ring;
>> -    struct drm_sched_rq *rq;
>> +    struct drm_gpu_scheduler *sched;
>>       int r;
>>         ring =3D &adev->vce.ring[0];
>> -    rq =3D &ring->sched.sched_rq[DRM_SCHED_PRIORITY_NORMAL];
>> -    r =3D drm_sched_entity_init(&adev->vce.entity, &rq, 1, NULL);
>> +    sched =3D &ring->sched;
>> +    r =3D drm_sched_entity_init(&adev->vce.entity, &sched,
>> +                  1, NULL, DRM_SCHED_PRIORITY_NORMAL);
>>       if (r !=3D 0) {
>>           DRM_ERROR("Failed setting up VCE run queue.\n");
>>           return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index a94c4faa5af1..ec6141773a92 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2687,6 +2687,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
>> struct amdgpu_vm *vm,
>>   {
>>       struct amdgpu_bo_param bp;
>>       struct amdgpu_bo *root;
>> +        struct drm_gpu_scheduler *sched_list[AMDGPU_MAX_RINGS];
>>       int r, i;
>>         vm->va =3D RB_ROOT_CACHED;
>> @@ -2700,14 +2701,19 @@ int amdgpu_vm_init(struct amdgpu_device
>> *adev, struct amdgpu_vm *vm,
>>       spin_lock_init(&vm->invalidated_lock);
>>       INIT_LIST_HEAD(&vm->freed);
>>   +        for (i =3D 0; i < adev->vm_manager.vm_pte_num_rqs; i++)
>> +           sched_list[i] =3D adev->vm_manager.vm_pte_rqs[i]->sched;
>> +
>>       /* create scheduler entities for page table updates */
>> -    r =3D drm_sched_entity_init(&vm->direct, adev->vm_manager.vm_pte_rq=
s,
>> -                  adev->vm_manager.vm_pte_num_rqs, NULL);
>> +    r =3D drm_sched_entity_init(&vm->direct, sched_list,
>> +                  adev->vm_manager.vm_pte_num_rqs,
>> +                  NULL, DRM_SCHED_PRIORITY_KERNEL);
>>       if (r)
>>           return r;
>>   -    r =3D drm_sched_entity_init(&vm->delayed,
>> adev->vm_manager.vm_pte_rqs,
>> -                  adev->vm_manager.vm_pte_num_rqs, NULL);
>> +    r =3D drm_sched_entity_init(&vm->delayed, sched_list,
>> +                  adev->vm_manager.vm_pte_num_rqs,
>> +                  NULL, DRM_SCHED_PRIORITY_KERNEL);
>>       if (r)
>>           goto error_free_direct;
>>   diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> index 1f9c01be40d7..a65c1e115e35 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> @@ -65,12 +65,12 @@ static int etnaviv_open(struct drm_device *dev,
>> struct drm_file *file)
>>         for (i =3D 0; i < ETNA_MAX_PIPES; i++) {
>>           struct etnaviv_gpu *gpu =3D priv->gpu[i];
>> -        struct drm_sched_rq *rq;
>> +        struct drm_gpu_scheduler *sched;
>>             if (gpu) {
>> -            rq =3D &gpu->sched.sched_rq[DRM_SCHED_PRIORITY_NORMAL];
>> -            drm_sched_entity_init(&ctx->sched_entity[i],
>> -                          &rq, 1, NULL);
>> +            sched =3D &gpu->sched;
>> +            drm_sched_entity_init(&ctx->sched_entity[i], &sched,
>> +                          1, NULL, DRM_SCHED_PRIORITY_NORMAL);
>>               }
>>       }
>>   diff --git a/drivers/gpu/drm/lima/lima_sched.c
>> b/drivers/gpu/drm/lima/lima_sched.c
>> index f522c5f99729..a7e53878d841 100644
>> --- a/drivers/gpu/drm/lima/lima_sched.c
>> +++ b/drivers/gpu/drm/lima/lima_sched.c
>> @@ -159,9 +159,10 @@ int lima_sched_context_init(struct
>> lima_sched_pipe *pipe,
>>                   struct lima_sched_context *context,
>>                   atomic_t *guilty)
>>   {
>> -    struct drm_sched_rq *rq =3D pipe->base.sched_rq +
>> DRM_SCHED_PRIORITY_NORMAL;
>> +    struct drm_gpu_scheduler *sched =3D &pipe->base;
>>   -    return drm_sched_entity_init(&context->base, &rq, 1, guilty);
>> +    return drm_sched_entity_init(&context->base, &sched,
>> +                     1, guilty, DRM_SCHED_PRIORITY_NORMAL);
>>   }
>>     void lima_sched_context_fini(struct lima_sched_pipe *pipe,
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c
>> b/drivers/gpu/drm/panfrost/panfrost_job.c
>> index d411eb6c8eb9..84178bcf35c9 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
>> @@ -542,12 +542,13 @@ int panfrost_job_open(struct panfrost_file_priv
>> *panfrost_priv)
>>   {
>>       struct panfrost_device *pfdev =3D panfrost_priv->pfdev;
>>       struct panfrost_job_slot *js =3D pfdev->js;
>> -    struct drm_sched_rq *rq;
>> +    struct drm_gpu_scheduler *sched;
>>       int ret, i;
>>         for (i =3D 0; i < NUM_JOB_SLOTS; i++) {
>> -        rq =3D &js->queue[i].sched.sched_rq[DRM_SCHED_PRIORITY_NORMAL];
>> -        ret =3D drm_sched_entity_init(&panfrost_priv->sched_entity[i],
>> &rq, 1, NULL);
>> +        sched =3D &js->queue[i].sched;
>> +        ret =3D drm_sched_entity_init(&panfrost_priv->sched_entity[i],
>> +                        &sched, 1, NULL, DRM_SCHED_PRIORITY_NORMAL);
>>           if (WARN_ON(ret))
>>               return ret;
>>       }
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
>> b/drivers/gpu/drm/scheduler/sched_entity.c
>> index 461a7a8129f4..e10d37266836 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -38,9 +38,9 @@
>>    * submit to HW ring.
>>    *
>>    * @entity: scheduler entity to init
>> - * @rq_list: the list of run queue on which jobs from this
>> + * @sched_list: the list of drm scheds on which jobs from this
>>    *           entity can be submitted
>> - * @num_rq_list: number of run queue in rq_list
>> + * @num_sched_list: number of drm sched in sched_list
>>    * @guilty: atomic_t set to 1 when a job on this queue
>>    *          is found to be guilty causing a timeout
>>    *
>> @@ -50,32 +50,34 @@
>>    * Returns 0 on success or a negative error code on failure.
>>    */
>>   int drm_sched_entity_init(struct drm_sched_entity *entity,
>> -              struct drm_sched_rq **rq_list,
>> -              unsigned int num_rq_list,
>> -              atomic_t *guilty)
>> +              struct drm_gpu_scheduler **sched_list,
>> +              unsigned int num_sched_list,
>> +              atomic_t *guilty, enum drm_sched_priority priority)
>>   {
>>       int i;
>>   -    if (!(entity && rq_list && (num_rq_list =3D=3D 0 || rq_list[0])))
>> +    if (!(entity && sched_list && (num_sched_list =3D=3D 0 ||
>> sched_list[0])))
>>           return -EINVAL;
>>         memset(entity, 0, sizeof(struct drm_sched_entity));
>>       INIT_LIST_HEAD(&entity->list);
>>       entity->rq =3D NULL;
>>       entity->guilty =3D guilty;
>> -    entity->num_rq_list =3D num_rq_list;
>> -    entity->rq_list =3D kcalloc(num_rq_list, sizeof(struct
>> drm_sched_rq *),
>> -                GFP_KERNEL);
>> -    if (!entity->rq_list)
>> +    entity->num_sched_list =3D num_sched_list;
>> +    entity->priority =3D priority;
>> +    entity->sched_list =3D  kcalloc(num_sched_list,
>> +                      sizeof(struct drm_gpu_scheduler *), GFP_KERNEL);
>> +
>> +    if(!entity->sched_list)
>>           return -ENOMEM;
>>         init_completion(&entity->entity_idle);
>>   -    for (i =3D 0; i < num_rq_list; ++i)
>> -        entity->rq_list[i] =3D rq_list[i];
>> +    for (i =3D 0; i < num_sched_list; i++)
>> +        entity->sched_list[i] =3D sched_list[i];
>>   -    if (num_rq_list)
>> -        entity->rq =3D rq_list[0];
>> +    if (num_sched_list)
>> +        entity->rq =3D
>> &entity->sched_list[0]->sched_rq[entity->priority];
>>         entity->last_scheduled =3D NULL;
>>   @@ -139,10 +141,10 @@ drm_sched_entity_get_free_sched(struct
>> drm_sched_entity *entity)
>>       unsigned int min_jobs =3D UINT_MAX, num_jobs;
>>       int i;
>>   -    for (i =3D 0; i < entity->num_rq_list; ++i) {
>> -        struct drm_gpu_scheduler *sched =3D entity->rq_list[i]->sched;
>> +    for (i =3D 0; i < entity->num_sched_list; ++i) {
>> +        struct drm_gpu_scheduler *sched =3D entity->sched_list[i];
>>   -        if (!entity->rq_list[i]->sched->ready) {
>> +        if (!entity->sched_list[i]->ready) {
>>               DRM_WARN("sched%s is not ready, skipping", sched->name);
>>               continue;
>>           }
>> @@ -150,7 +152,7 @@ drm_sched_entity_get_free_sched(struct
>> drm_sched_entity *entity)
>>           num_jobs =3D atomic_read(&sched->num_jobs);
>>           if (num_jobs < min_jobs) {
>>               min_jobs =3D num_jobs;
>> -            rq =3D entity->rq_list[i];
>> +            rq =3D &entity->sched_list[i]->sched_rq[entity->priority];
>>           }
>>       }
>>   @@ -308,7 +310,7 @@ void drm_sched_entity_fini(struct
>> drm_sched_entity *entity)
>>         dma_fence_put(entity->last_scheduled);
>>       entity->last_scheduled =3D NULL;
>> -    kfree(entity->rq_list);
>> +    kfree(entity->sched_list);
>>   }
>>   EXPORT_SYMBOL(drm_sched_entity_fini);
>>   @@ -353,15 +355,6 @@ static void drm_sched_entity_wakeup(struct
>> dma_fence *f,
>>       drm_sched_wakeup(entity->rq->sched);
>>   }
>>   -/**
>> - * drm_sched_entity_set_rq_priority - helper for
>> drm_sched_entity_set_priority
>> - */
>> -static void drm_sched_entity_set_rq_priority(struct drm_sched_rq **rq,
>> -                         enum drm_sched_priority priority)
>> -{
>> -    *rq =3D &(*rq)->sched->sched_rq[priority];
>> -}
>> -
>>   /**
>>    * drm_sched_entity_set_priority - Sets priority of the entity
>>    *
>> @@ -373,20 +366,8 @@ static void
>> drm_sched_entity_set_rq_priority(struct drm_sched_rq **rq,
>>   void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
>>                      enum drm_sched_priority priority)
>>   {
>> -    unsigned int i;
>> -
>> -    spin_lock(&entity->rq_lock);
>>   -    for (i =3D 0; i < entity->num_rq_list; ++i)
>> - drm_sched_entity_set_rq_priority(&entity->rq_list[i], priority);
>> -
>> -    if (entity->rq) {
>> -        drm_sched_rq_remove_entity(entity->rq, entity);
>> -        drm_sched_entity_set_rq_priority(&entity->rq, priority);
>> -        drm_sched_rq_add_entity(entity->rq, entity);
>> -    }
>> -
>> -    spin_unlock(&entity->rq_lock);
>> +    entity->priority =3D priority;
>>   }
>>   EXPORT_SYMBOL(drm_sched_entity_set_priority);
>>   @@ -490,7 +471,7 @@ void drm_sched_entity_select_rq(struct
>> drm_sched_entity *entity)
>>       struct dma_fence *fence;
>>       struct drm_sched_rq *rq;
>>   -    if (spsc_queue_count(&entity->job_queue) ||
>> entity->num_rq_list <=3D 1)
>> +    if (spsc_queue_count(&entity->job_queue) ||
>> entity->num_sched_list <=3D 1)
>>           return;
>>         fence =3D READ_ONCE(entity->last_scheduled);
>> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c
>> b/drivers/gpu/drm/v3d/v3d_drv.c
>> index 1a07462b4528..c6aff1aedd27 100644
>> --- a/drivers/gpu/drm/v3d/v3d_drv.c
>> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
>> @@ -140,7 +140,7 @@ v3d_open(struct drm_device *dev, struct drm_file
>> *file)
>>   {
>>       struct v3d_dev *v3d =3D to_v3d_dev(dev);
>>       struct v3d_file_priv *v3d_priv;
>> -    struct drm_sched_rq *rq;
>> +    struct drm_gpu_scheduler *sched;
>>       int i;
>>         v3d_priv =3D kzalloc(sizeof(*v3d_priv), GFP_KERNEL);
>> @@ -150,8 +150,9 @@ v3d_open(struct drm_device *dev, struct drm_file
>> *file)
>>       v3d_priv->v3d =3D v3d;
>>         for (i =3D 0; i < V3D_MAX_QUEUES; i++) {
>> -        rq =3D &v3d->queue[i].sched.sched_rq[DRM_SCHED_PRIORITY_NORMAL]=
;
>> - drm_sched_entity_init(&v3d_priv->sched_entity[i], &rq, 1, NULL);
>> +        sched =3D &v3d->queue[i].sched;
>> + drm_sched_entity_init(&v3d_priv->sched_entity[i], &sched,
>> +                      1, NULL, DRM_SCHED_PRIORITY_NORMAL);
>>       }
>>         file->driver_priv =3D v3d_priv;
>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>> index 684692a8ed76..9df322dfac30 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -81,8 +81,9 @@ enum drm_sched_priority {
>>   struct drm_sched_entity {
>>       struct list_head        list;
>>       struct drm_sched_rq        *rq;
>> -    struct drm_sched_rq        **rq_list;
>> -    unsigned int                    num_rq_list;
>> +    unsigned int                    num_sched_list;
>> +    struct drm_gpu_scheduler        **sched_list;
>> +    enum drm_sched_priority         priority;
>>       spinlock_t            rq_lock;
>>         struct spsc_queue        job_queue;
>> @@ -312,9 +313,9 @@ void drm_sched_rq_remove_entity(struct
>> drm_sched_rq *rq,
>>                   struct drm_sched_entity *entity);
>>     int drm_sched_entity_init(struct drm_sched_entity *entity,
>> -              struct drm_sched_rq **rq_list,
>> +              struct drm_gpu_scheduler **sched_list,
>>                 unsigned int num_rq_list,
>> -              atomic_t *guilty);
>> +              atomic_t *guilty, enum drm_sched_priority priority);
>>   long drm_sched_entity_flush(struct drm_sched_entity *entity, long
>> timeout);
>>   void drm_sched_entity_fini(struct drm_sched_entity *entity);
>>   void drm_sched_entity_destroy(struct drm_sched_entity *entity);


--_000_DM5PR12MB23768833C317283FCC25646E8B5C0DM5PR12MB2376namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Thanks Christian,&nbsp;</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"text-align: l=
eft;">
<div><br>
</div>
I will modify and resend.</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"text-align: l=
eft;"><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"text-align: l=
eft;">Regards,&nbsp;</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"text-align: l=
eft;">Nirmoy&nbsp;</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 5, 2019 1:29:49 PM<br>
<b>To:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;; Nirmoy Das &lt;nirmoy.ai=
emd@gmail.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Ho=
, Kenny &lt;Kenny.Ho@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<br>
<b>Subject:</b> Re: [RFC PATCH] drm/scheduler: rework entity creation</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 05.12.19 um 12:04 schrieb Nirmoy:<br>
&gt; Hi Christian,<br>
&gt;<br>
&gt; I am not exactly sure about drm_sched_entity_set_priority() I wonder <=
br>
&gt; if just changing<br>
&gt;<br>
&gt; entity-&gt;priority&nbsp; to ctx-&gt;override_priority should work. Wi=
th this <br>
&gt; change drm_sched_entity_select_rq()<br>
&gt;<br>
&gt; will chose a rq based on entity-&gt;priority which seems to me correct=
. <br>
&gt; But is this enough to fix the old bug you were<br>
&gt;<br>
&gt; talking about which mess up already scheduled job on priority change?<=
br>
<br>
Yes, that should perfectly do it.<br>
<br>
&gt;<br>
&gt; okay I just realized I need a lock to make sure<br>
&gt;<br>
&gt; drm_sched_entity_set_priority() and drm_sched_entity_select_rq() <br>
&gt; shouldn't happen at the same time.<br>
<br>
Yeah, you probably need to grab the lock and make sure that you get the <br=
>
priority to use while holding the lock as well.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Nirmoy<br>
&gt;<br>
&gt;<br>
&gt; On 12/5/19 11:52 AM, Nirmoy Das wrote:<br>
&gt;&gt; Entity currently keeps a copy of run_queue list and modify it in<b=
r>
&gt;&gt; drm_sched_entity_set_priority(). Entities shouldn't modify run_que=
ue<br>
&gt;&gt; list. Use drm_gpu_scheduler list instead of drm_sched_rq list<br>
&gt;&gt; in drm_sched_entity struct. In this way we can select a runqueue b=
ased<br>
&gt;&gt; on entity/ctx's priority for a&nbsp; drm scheduler.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c&nbsp; |&nbsp; 7 &#4=
3;--<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp; |&nbsp; 7 &#4=
3;--<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c&nbsp; |&nbsp; 7 &#4=
3;--<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c&nbsp; |&nbsp; 7 &#4=
3;--<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp; | 14 &#4=
3;&#43;&#43;--<br>
&gt;&gt; &nbsp; drivers/gpu/drm/etnaviv/etnaviv_drv.c&nbsp;&nbsp;&nbsp; |&n=
bsp; 8 &#43;--<br>
&gt;&gt; &nbsp; drivers/gpu/drm/lima/lima_sched.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 5 &#43;-<br>
&gt;&gt; &nbsp; drivers/gpu/drm/panfrost/panfrost_job.c&nbsp; |&nbsp; 7 &#4=
3;--<br>
&gt;&gt; &nbsp; drivers/gpu/drm/scheduler/sched_entity.c | 65 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;---------------<br>
&gt;&gt; &nbsp; drivers/gpu/drm/v3d/v3d_drv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 &#43;--<br>
&gt;&gt; &nbsp; include/drm/gpu_scheduler.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 &#43;&#43;--<br>
&gt;&gt; &nbsp; 11 files changed, 69 insertions(&#43;), 74 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt;&gt; index a0d3d7b756eb..e8f46c13d073 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt;&gt; @@ -122,7 &#43;122,7 @@ static int amdgpu_ctx_init(struct amdgpu_d=
evice <br>
&gt;&gt; *adev,<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_=
HW_IP_NUM; &#43;&#43;i) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdg=
pu_ring *rings[AMDGPU_MAX_RINGS];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_rq *r=
qs[AMDGPU_MAX_RINGS];<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_sch=
eduler *sched_list[AMDGPU_MAX_RINGS];<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned nu=
m_rings =3D 0;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned nu=
m_rqs =3D 0;<br>
&gt;&gt; &nbsp; @@ -181,12 &#43;181,13 @@ static int amdgpu_ctx_init(struct=
 <br>
&gt;&gt; amdgpu_device *adev,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (!rings[j]-&gt;adev)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; rqs[num_rqs&#43;&#43;] =3D &amp;rings[j]-&gt;sched.sched_rq[priori=
ty];<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; sched_list[num_rqs&#43;&#43;] =3D &amp;rings[j]-&gt;sched;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for =
(j =3D 0; j &lt; amdgpu_ctx_num_entities[i]; &#43;&#43;j)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; r =3D drm_sched_entity_init(&amp;ctx-&gt;entities[i][j].entity=
,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rqs, num_rqs, &amp;ctx-&gt;guilty);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sched_list, num_rqs,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &amp;ctx-&gt;guilty, priority);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; goto error_cleanup_entities;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt; index 19ffe00d9072..a960dd7c0711 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt; @@ -1957,11 &#43;1957,12 @@ void <br>
&gt;&gt; amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, boo=
l <br>
&gt;&gt; enable)<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdg=
pu_ring *ring;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_rq *r=
q;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_sch=
eduler *sched;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring=
 =3D adev-&gt;mman.buffer_funcs_ring;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rq =3D &amp;ring-&gt;s=
ched.sched_rq[DRM_SCHED_PRIORITY_KERNEL];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D drm_sched_entity=
_init(&amp;adev-&gt;mman.entity, &amp;rq, 1, NULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched =3D &amp;rin=
g-&gt;sched;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D drm_sched_en=
tity_init(&amp;adev-&gt;mman.entity, &amp;sched,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1, NULL, =
DRM_SCHED_PRIORITY_KERNEL);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br=
>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; DRM_ERROR(&quot;Failed setting up TTM BO move entity (%d)\n&qu=
ot;,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
&gt;&gt; index e324bfe6c58f..b803a8882864 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
&gt;&gt; @@ -330,12 &#43;330,13 @@ int amdgpu_uvd_sw_fini(struct amdgpu_dev=
ice *adev)<br>
&gt;&gt; &nbsp; int amdgpu_uvd_entity_init(struct amdgpu_device *adev)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;uvd.i=
nst[0].ring;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; rq =3D &amp;ring-&gt;sched.sched_rq[DRM_SCHED_=
PRIORITY_NORMAL];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; r =3D drm_sched_entity_init(&amp;adev-&gt;uvd.=
entity, &amp;rq, 1, NULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; sched =3D &amp;ring-&gt;sched;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; r =3D drm_sched_entity_init(&amp;adev-&gt;=
uvd.entity, &amp;sched,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1, NULL, DRM_SCHED_PRIORITY_NORMA=
L);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&=
quot;Failed setting up UVD kernel entity.\n&quot;);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<b=
r>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
&gt;&gt; index 46b590af2fd2..b44f28d44fb4 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
&gt;&gt; @@ -240,12 &#43;240,13 @@ int amdgpu_vce_sw_fini(struct amdgpu_dev=
ice *adev)<br>
&gt;&gt; &nbsp; int amdgpu_vce_entity_init(struct amdgpu_device *adev)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;vce.r=
ing[0];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; rq =3D &amp;ring-&gt;sched.sched_rq[DRM_SCHED_=
PRIORITY_NORMAL];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; r =3D drm_sched_entity_init(&amp;adev-&gt;vce.=
entity, &amp;rq, 1, NULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; sched =3D &amp;ring-&gt;sched;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; r =3D drm_sched_entity_init(&amp;adev-&gt;=
vce.entity, &amp;sched,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1, NULL, DRM_SCHED_PRIORITY_NORMA=
L);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r !=3D 0) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&=
quot;Failed setting up VCE run queue.\n&quot;);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<b=
r>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; index a94c4faa5af1..ec6141773a92 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; @@ -2687,6 &#43;2687,7 @@ int amdgpu_vm_init(struct amdgpu_device =
*adev, <br>
&gt;&gt; struct amdgpu_vm *vm,<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_param bp;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *root;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_sch=
eduler *sched_list[AMDGPU_MAX_RINGS];<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;va =3D RB_ROOT_CACHED=
;<br>
&gt;&gt; @@ -2700,14 &#43;2701,19 @@ int amdgpu_vm_init(struct amdgpu_devic=
e <br>
&gt;&gt; *adev, struct amdgpu_vm *vm,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;vm-&gt;invalida=
ted_lock);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;freed);<=
br>
&gt;&gt; &nbsp; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D =
0; i &lt; adev-&gt;vm_manager.vm_pte_num_rqs; i&#43;&#43;)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sched_list[i] =3D adev-&gt;vm_manager.vm_pte_rqs[i]-&gt;sched;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* create scheduler entities for pa=
ge table updates */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; r =3D drm_sched_entity_init(&amp;vm-&gt;direct=
, adev-&gt;vm_manager.vm_pte_rqs,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.vm_pte_num_rqs, N=
ULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; r =3D drm_sched_entity_init(&amp;vm-&gt;di=
rect, sched_list,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.vm_pte_num_rq=
s,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, DRM_SCHED_PRIORITY_KERNEL);=
<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<b=
r>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; r =3D drm_sched_entity_init(&amp;vm-&gt=
;delayed, <br>
&gt;&gt; adev-&gt;vm_manager.vm_pte_rqs,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.vm_pte_num_rqs, N=
ULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; r =3D drm_sched_entity_init(&amp;vm-&gt;de=
layed, sched_list,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.vm_pte_num_rq=
s,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, DRM_SCHED_PRIORITY_KERNEL);=
<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_=
free_direct;<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c <br>
&gt;&gt; b/drivers/gpu/drm/etnaviv/etnaviv_drv.c<br>
&gt;&gt; index 1f9c01be40d7..a65c1e115e35 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/etnaviv/etnaviv_drv.c<br>
&gt;&gt; @@ -65,12 &#43;65,12 @@ static int etnaviv_open(struct drm_device =
*dev, <br>
&gt;&gt; struct drm_file *file)<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ETNA_MA=
X_PIPES; i&#43;&#43;) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct etna=
viv_gpu *gpu =3D priv-&gt;gpu[i];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_rq *r=
q;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_sch=
eduler *sched;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
gpu) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; rq =3D &amp;gpu-&gt;sched.sched_rq[DRM_SCHED_PRIORITY_NORMAL];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; drm_sched_entity_init(&amp;ctx-&gt;sched_entity[i],<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;rq, 1, NULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; sched =3D &amp;gpu-&gt;sched;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; drm_sched_entity_init(&amp;ctx-&gt;sched_entity[i], &amp;sched,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 1, NULL, DRM_SCHED_PRIORITY_NORMAL);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/lima/lima_sched.c <br>
&gt;&gt; b/drivers/gpu/drm/lima/lima_sched.c<br>
&gt;&gt; index f522c5f99729..a7e53878d841 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/lima/lima_sched.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/lima/lima_sched.c<br>
&gt;&gt; @@ -159,9 &#43;159,10 @@ int lima_sched_context_init(struct <br>
&gt;&gt; lima_sched_pipe *pipe,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct lima_sched_context *context,<br=
>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t *guilty)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq =3D pipe-&gt;base.sche=
d_rq &#43; <br>
&gt;&gt; DRM_SCHED_PRIORITY_NORMAL;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched =3D &amp;p=
ipe-&gt;base;<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; return drm_sched_entity_init(&amp;conte=
xt-&gt;base, &amp;rq, 1, guilty);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return drm_sched_entity_init(&amp;context-=
&gt;base, &amp;sched,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1, guilty, DRM_=
SCHED_PRIORITY_NORMAL);<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; &nbsp; void lima_sched_context_fini(struct lima_sched_pipe =
*pipe,<br>
&gt;&gt; diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c <br>
&gt;&gt; b/drivers/gpu/drm/panfrost/panfrost_job.c<br>
&gt;&gt; index d411eb6c8eb9..84178bcf35c9 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/panfrost/panfrost_job.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/panfrost/panfrost_job.c<br>
&gt;&gt; @@ -542,12 &#43;542,13 @@ int panfrost_job_open(struct panfrost_fi=
le_priv <br>
&gt;&gt; *panfrost_priv)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct panfrost_device *pfdev =3D p=
anfrost_priv-&gt;pfdev;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct panfrost_job_slot *js =3D pf=
dev-&gt;js;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; NUM_JOB=
_SLOTS; i&#43;&#43;) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rq =3D &amp;js-&gt;que=
ue[i].sched.sched_rq[DRM_SCHED_PRIORITY_NORMAL];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drm_sched_enti=
ty_init(&amp;panfrost_priv-&gt;sched_entity[i], <br>
&gt;&gt; &amp;rq, 1, NULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched =3D &amp;js-=
&gt;queue[i].sched;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drm_sched_=
entity_init(&amp;panfrost_priv-&gt;sched_entity[i],<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &amp;sched, 1, NULL, DRM_SCHED_PRIORITY_NORMAL);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON=
(ret))<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return ret;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; diff --git a/drivers/gpu/drm/scheduler/sched_entity.c <br>
&gt;&gt; b/drivers/gpu/drm/scheduler/sched_entity.c<br>
&gt;&gt; index 461a7a8129f4..e10d37266836 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/scheduler/sched_entity.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/scheduler/sched_entity.c<br>
&gt;&gt; @@ -38,9 &#43;38,9 @@<br>
&gt;&gt; &nbsp;&nbsp; * submit to HW ring.<br>
&gt;&gt; &nbsp;&nbsp; *<br>
&gt;&gt; &nbsp;&nbsp; * @entity: scheduler entity to init<br>
&gt;&gt; - * @rq_list: the list of run queue on which jobs from this<br>
&gt;&gt; &#43; * @sched_list: the list of drm scheds on which jobs from thi=
s<br>
&gt;&gt; &nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; entity can be submitted<br>
&gt;&gt; - * @num_rq_list: number of run queue in rq_list<br>
&gt;&gt; &#43; * @num_sched_list: number of drm sched in sched_list<br>
&gt;&gt; &nbsp;&nbsp; * @guilty: atomic_t set to 1 when a job on this queue=
<br>
&gt;&gt; &nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; is found to be guilty causing a timeout<br>
&gt;&gt; &nbsp;&nbsp; *<br>
&gt;&gt; @@ -50,32 &#43;50,34 @@<br>
&gt;&gt; &nbsp;&nbsp; * Returns 0 on success or a negative error code on fa=
ilure.<br>
&gt;&gt; &nbsp;&nbsp; */<br>
&gt;&gt; &nbsp; int drm_sched_entity_init(struct drm_sched_entity *entity,<=
br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct drm_sched_rq **rq_list,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; unsigned int num_rq_list,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; atomic_t *guilty)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler **sched_list,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; unsigned int num_sched_list,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; atomic_t *guilty, enum drm_sched_priority priority)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; if (!(entity &amp;&amp; rq_list &amp;&a=
mp; (num_rq_list =3D=3D 0 || rq_list[0])))<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (!(entity &amp;&amp; sched_list &amp;&a=
mp; (num_sched_list =3D=3D 0 || <br>
&gt;&gt; sched_list[0])))<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EIN=
VAL;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(entity, 0, sizeof(str=
uct drm_sched_entity));<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;entity-&gt;list=
);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;rq =3D NULL;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;guilty =3D guilty;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; entity-&gt;num_rq_list =3D num_rq_list;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; entity-&gt;rq_list =3D kcalloc(num_rq_list, si=
zeof(struct <br>
&gt;&gt; drm_sched_rq *),<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; GFP_KERNEL);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (!entity-&gt;rq_list)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; entity-&gt;num_sched_list =3D num_sched_li=
st;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; entity-&gt;priority =3D priority;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; entity-&gt;sched_list =3D&nbsp; kcalloc(nu=
m_sched_list,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(st=
ruct drm_gpu_scheduler *), GFP_KERNEL);<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if(!entity-&gt;sched_list)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENO=
MEM;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_completion(&amp;entity-=
&gt;entity_idle);<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_rq_list; &#43;=
&#43;i)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;rq_list[i] =
=3D rq_list[i];<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_sched_list; i&#43=
;&#43;)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;sched_l=
ist[i] =3D sched_list[i];<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; if (num_rq_list)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;rq =3D rq_l=
ist[0];<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (num_sched_list)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;rq =3D =
<br>
&gt;&gt; &amp;entity-&gt;sched_list[0]-&gt;sched_rq[entity-&gt;priority];<b=
r>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;last_scheduled =
=3D NULL;<br>
&gt;&gt; &nbsp; @@ -139,10 &#43;141,10 @@ drm_sched_entity_get_free_sched(s=
truct <br>
&gt;&gt; drm_sched_entity *entity)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int min_jobs =3D UINT_MAX,=
 num_jobs;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; entity-&gt;num_rq_=
list; &#43;&#43;i) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_schedul=
er *sched =3D entity-&gt;rq_list[i]-&gt;sched;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; entity-&gt;num_sched_=
list; &#43;&#43;i) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_sch=
eduler *sched =3D entity-&gt;sched_list[i];<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!entity-&gt=
;rq_list[i]-&gt;sched-&gt;ready) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!entity-&gt;sc=
hed_list[i]-&gt;ready) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; DRM_WARN(&quot;sched%s is not ready, skipping&quot;, sched-&gt=
;name);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; continue;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; @@ -150,7 &#43;152,7 @@ drm_sched_entity_get_free_sched(struct <br=
>
&gt;&gt; drm_sched_entity *entity)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_jobs =
=3D atomic_read(&amp;sched-&gt;num_jobs);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (num_job=
s &lt; min_jobs) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; min_jobs =3D num_jobs;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; rq =3D entity-&gt;rq_list[i];<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; rq =3D &amp;entity-&gt;sched_list[i]-&gt;sched_rq[entity-&gt;priority=
];<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; @@ -308,7 &#43;310,7 @@ void drm_sched_entity_fini(struct <=
br>
&gt;&gt; drm_sched_entity *entity)<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(entity-&gt;las=
t_scheduled);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;last_scheduled =3D NULL;=
<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; kfree(entity-&gt;rq_list);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; kfree(entity-&gt;sched_list);<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; EXPORT_SYMBOL(drm_sched_entity_fini);<br>
&gt;&gt; &nbsp; @@ -353,15 &#43;355,6 @@ static void drm_sched_entity_wakeu=
p(struct <br>
&gt;&gt; dma_fence *f,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_wakeup(entity-&gt;rq-&gt;=
sched);<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; -/**<br>
&gt;&gt; - * drm_sched_entity_set_rq_priority - helper for <br>
&gt;&gt; drm_sched_entity_set_priority<br>
&gt;&gt; - */<br>
&gt;&gt; -static void drm_sched_entity_set_rq_priority(struct drm_sched_rq =
**rq,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum drm_sched_priority priority)<br>
&gt;&gt; -{<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; *rq =3D &amp;(*rq)-&gt;sched-&gt;sched_rq[prio=
rity];<br>
&gt;&gt; -}<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp; /**<br>
&gt;&gt; &nbsp;&nbsp; * drm_sched_entity_set_priority - Sets priority of th=
e entity<br>
&gt;&gt; &nbsp;&nbsp; *<br>
&gt;&gt; @@ -373,20 &#43;366,8 @@ static void <br>
&gt;&gt; drm_sched_entity_set_rq_priority(struct drm_sched_rq **rq,<br>
&gt;&gt; &nbsp; void drm_sched_entity_set_priority(struct drm_sched_entity =
*entity,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum drm_sched_prior=
ity priority)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; spin_lock(&amp;entity-&gt;rq_lock);<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; entity-&gt;num_rq_=
list; &#43;&#43;i)<br>
&gt;&gt; - drm_sched_entity_set_rq_priority(&amp;entity-&gt;rq_list[i], pri=
ority);<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (entity-&gt;rq) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_rq_remove_en=
tity(entity-&gt;rq, entity);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_entity_set_r=
q_priority(&amp;entity-&gt;rq, priority);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_rq_add_entit=
y(entity-&gt;rq, entity);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; spin_unlock(&amp;entity-&gt;rq_lock);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; entity-&gt;priority =3D priority;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; EXPORT_SYMBOL(drm_sched_entity_set_priority);<br>
&gt;&gt; &nbsp; @@ -490,7 &#43;471,7 @@ void drm_sched_entity_select_rq(str=
uct <br>
&gt;&gt; drm_sched_entity *entity)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq;<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; if (spsc_queue_count(&amp;entity-&gt;jo=
b_queue) || <br>
&gt;&gt; entity-&gt;num_rq_list &lt;=3D 1)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (spsc_queue_count(&amp;entity-&gt;job_q=
ueue) || <br>
&gt;&gt; entity-&gt;num_sched_list &lt;=3D 1)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence =3D READ_ONCE(entity-&=
gt;last_scheduled);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/v3d/v3d_drv.c <br>
&gt;&gt; b/drivers/gpu/drm/v3d/v3d_drv.c<br>
&gt;&gt; index 1a07462b4528..c6aff1aedd27 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/v3d/v3d_drv.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/v3d/v3d_drv.c<br>
&gt;&gt; @@ -140,7 &#43;140,7 @@ v3d_open(struct drm_device *dev, struct dr=
m_file <br>
&gt;&gt; *file)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v3d_dev *v3d =3D to_v3d_dev(=
dev);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v3d_file_priv *v3d_priv;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v3d_priv =3D kzalloc(sizeof(=
*v3d_priv), GFP_KERNEL);<br>
&gt;&gt; @@ -150,8 &#43;150,9 @@ v3d_open(struct drm_device *dev, struct dr=
m_file <br>
&gt;&gt; *file)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v3d_priv-&gt;v3d =3D v3d;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; V3D_MAX=
_QUEUES; i&#43;&#43;) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rq =3D &amp;v3d-&gt;qu=
eue[i].sched.sched_rq[DRM_SCHED_PRIORITY_NORMAL];<br>
&gt;&gt; - drm_sched_entity_init(&amp;v3d_priv-&gt;sched_entity[i], &amp;rq=
, 1, NULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched =3D &amp;v3d=
-&gt;queue[i].sched;<br>
&gt;&gt; &#43; drm_sched_entity_init(&amp;v3d_priv-&gt;sched_entity[i], &am=
p;sched,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1, NULL, =
DRM_SCHED_PRIORITY_NORMAL);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; file-&gt;driver_priv =3D v3d=
_priv;<br>
&gt;&gt; diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_schedul=
er.h<br>
&gt;&gt; index 684692a8ed76..9df322dfac30 100644<br>
&gt;&gt; --- a/include/drm/gpu_scheduler.h<br>
&gt;&gt; &#43;&#43;&#43; b/include/drm/gpu_scheduler.h<br>
&gt;&gt; @@ -81,8 &#43;81,9 @@ enum drm_sched_priority {<br>
&gt;&gt; &nbsp; struct drm_sched_entity {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; list;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_rq&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; *rq;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct drm_sched_rq&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; **rq_list;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; num_rq_list;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; num_sched_list;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; **sched_list;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; enum drm_sched_priority&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priority;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spinlock_t&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rq_lock;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct spsc_queue&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job_queue;<br>
&gt;&gt; @@ -312,9 &#43;313,9 @@ void drm_sched_rq_remove_entity(struct <br=
>
&gt;&gt; drm_sched_rq *rq,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity);<br>
&gt;&gt; &nbsp; &nbsp; int drm_sched_entity_init(struct drm_sched_entity *e=
ntity,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct drm_sched_rq **rq_list,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler **sched_list,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_rq_list,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; atomic_t *guilty);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; atomic_t *guilty, enum drm_sched_priority priority);<br>
&gt;&gt; &nbsp; long drm_sched_entity_flush(struct drm_sched_entity *entity=
, long <br>
&gt;&gt; timeout);<br>
&gt;&gt; &nbsp; void drm_sched_entity_fini(struct drm_sched_entity *entity)=
;<br>
&gt;&gt; &nbsp; void drm_sched_entity_destroy(struct drm_sched_entity *enti=
ty);<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB23768833C317283FCC25646E8B5C0DM5PR12MB2376namp_--

--===============1843003548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1843003548==--
