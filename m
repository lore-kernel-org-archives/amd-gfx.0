Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8B3C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 03:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC0564FA1
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 03:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC0564FA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15EB6E44F;
	Thu, 11 Mar 2021 03:24:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8417E6E44F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 03:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9eNdNONW7ff/gsUebS47wyieI/33P9ra+4b3dB5PzBt922anrAgotMUq2kGo522FLMzarlmKt9nOuc7M2G1AmbHrS/uVcFbnvKtspcm+OjvSCcS3hjoLidBUI/28Z9fRyXOSeGSasgjkFAUEtsezqzJTwuQ9NLK2YFmLBDVgH82SkrQbVKyC6hVQEshAHkBNypIaio3TXuQekH2nQeAFoYakVtF5zCP1Z2XSU3T2B4WLpYuAu0svLj339YSC0xapc5jQY+MCgk2i9C0ziZdsBaE+WBggEFSZH3dTO1lREYv1pM4kO+06T+xTkpRLtdCRABRyqU623M8vda4wC9zoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jr9yT8avraKqoXedRBJCLxxRBCYzSXrWq47dJ+CffU=;
 b=nRzfDtUerKXWTWxaxvxEWu8qKQuAKDTVjgWmDwSwy0adWzE8LYAmB8UybH4k6n2EUL/Y+9/JnsElXNXbSgXW3gjwId3F8f2LVbaTmTQ5xmsOjEoGffrPW3VJ3VED6dw16qr0Coaj2oHi76MBz0AEYam0JSFLvYuTzjX8UODFJX1TbImg+cE/i1BlFIMsR5OvkryNhwcfPtgixPnvZvlVn61+Gk5xUo097iI0OMvWe6U18PKIL26iUHUJkw1tuK8iQzwHU8hyKEsyaFIXH9f4ziffryM76zguETsG9ZW4/DdLSWA2a8CMwIKPaAcrT10BARnNzU6RSq/3yMWXpcRUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jr9yT8avraKqoXedRBJCLxxRBCYzSXrWq47dJ+CffU=;
 b=hJfrgDe+saQjMINUUXwQ9nsTvbyjDk9Q/L56v8ha3C+JkIJq4ZWHVAlwJ09RqfkQ1NgnpuHRyD1hvMBcY5VoLsi+Ov5conAaH9NxRRoYa8r57hpBfpqOJv3MDxWj93rD+EnYkIilSjB3nCgCFdycJOiPAjDpN+fIBYhlxCFPVsw=
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 11 Mar
 2021 03:24:26 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.029; Thu, 11 Mar 2021
 03:24:26 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Deng, 
 Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH v6] drm/amd/amdgpu implement tdr advanced mode
Thread-Topic: [PATCH v6] drm/amd/amdgpu implement tdr advanced mode
Thread-Index: AQHXFbHt3OoRWo2cDUObVvab2UN6NKp9ZtkAgAC0fYCAAAO2zA==
Date: Thu, 11 Mar 2021 03:24:26 +0000
Message-ID: <SN6PR12MB462321467D1D08B5180004D8EA909@SN6PR12MB4623.namprd12.prod.outlook.com>
References: <20210310133302.933854-1-Jack.Zhang1@amd.com>
 <8c1b4379-6068-e2f4-5994-531d731548de@amd.com>,
 <DM5PR1201MB02040D6A57CEFFE820528441BB909@DM5PR1201MB0204.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB02040D6A57CEFFE820528441BB909@DM5PR1201MB0204.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [99.228.232.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d59a8ebe-d297-4eb6-9d03-08d8e43d2c89
x-ms-traffictypediagnostic: SN1PR12MB2493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB24937039520D23F1EB4C1941EA909@SN1PR12MB2493.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LsSrfGA72yn26FZ2B4YIiYJHaPjiNgNn6pWDIE8mMPClmfazzaGN816Lk1g6BvYw0pdMYieFWcqCw9ocUzKrFW4Bf1UEfl2YexhcXieeTHT6qdD0NNIlpPbNEsfQA+kAifS7+d6mOei1MX1AJDm29Wwz//gjk84NybmYd108nwy5031f9R9lnJzhowK/RqGJbtnl2uA5ta0JXKX5k6fFMOl26uzTBR4xFdk18eB/muZaSPHcGL7WLsU/aRhTS4DgFxZ2LBMEa5ARxRsX7PF8S5JF31or8eOz/TVt6is+dPfvSmKcBgB7uEh6c9pM4h3QsvIjv/KucdLoJVJGuA8UO96OXyuwCDTOfqhiYlZNLUBBdnrqR456Jz3Gq18RfXBbbDMHFmFeKVjZDMPhQb+eFLHOF5d2nbRY9GcxXsdDNzmz08pJJnGjbhoIS5D88EYfDf6IPXsEUlSsfF6uFvfm9xcDVTvk3hi0SfSHCB0R9IVTt+arpWEMf/ABp6EIh+KGI8Xjv7akqCAUNvXpoqM6aQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(110136005)(30864003)(66556008)(66476007)(8676002)(33656002)(6506007)(52536014)(76116006)(5660300002)(7696005)(86362001)(316002)(26005)(53546011)(186003)(91956017)(6636002)(71200400001)(66946007)(66446008)(8936002)(478600001)(2906002)(83380400001)(64756008)(9686003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?lpl4GlZlmjLhvaOhedRPLOAlEVOa76aQ6Ml43XktIrXGMDQKvjQS/gOO?=
 =?Windows-1252?Q?ubLsea0+Dlzn/ENCAgUI0dCOPEpvZpLeeEEXxbE+nQ76SlOKJon/yyxF?=
 =?Windows-1252?Q?AkmeTjzz+r+VI1atjtIf+rtuzQOydYFRD5+czdfcbRZSQVg+sGjaIa0I?=
 =?Windows-1252?Q?QOuoixUQ83aRvPTW9C2wXJMOCGqWhntyGAAzFuxTsCj9et+LVWQW2qMQ?=
 =?Windows-1252?Q?qOAa87VIE+FuS7g2PXQTnvOG4xAX218G1lFC5Rz+Sxej8NzbSphP1yoP?=
 =?Windows-1252?Q?ZwOX1q6Db7/1fvjkewqcg2EPwc6l8U6t96jwb5zwSHrW5mFQfn5MsaRT?=
 =?Windows-1252?Q?6PZJ43j3Goe9H4sBamSkTPcVX4+N4N2oHVVJZZL3rkeU7JVzMhfW/tNc?=
 =?Windows-1252?Q?w0nF9H0bSxcg6PQZ1jChfxoJZ54nNX30sIzZoi9iliAzRNyDGMpipgvh?=
 =?Windows-1252?Q?cCr21x0rjCF/KkwKOCM4yMzYusm6SDQJgb1if9GwBD7Sl1iGDG1wLH0f?=
 =?Windows-1252?Q?0KNb8DuKWVYc7wpqJpZPS/S5mpkifRMPH+AUqSmSY+moyyJLWyZHrY4A?=
 =?Windows-1252?Q?xW9NkVGv0/tWOpL6/uR1ZIRSuYUSuymDgkguTWNzPydOvaOR9mk6ShD6?=
 =?Windows-1252?Q?xnQxGgN1Rt0YWythMCyaMf/WEiq9DDO4VN/jPdIXHChj4fuz+jQ1yMFh?=
 =?Windows-1252?Q?5TMj/Lx+huMOKV5zTGmJPZIFmpGl4/Fk4tCA9mUFhIKNE6oQJTi2O7Jn?=
 =?Windows-1252?Q?8uyZEITjugdVJvNvAvOWajFUuKMflR29VrtGxvOwY+Z/7QE5KP3pjSKL?=
 =?Windows-1252?Q?nm5xHzEcOe+mvSCYbdxNPlEsvZ8raR9LzfAPi0l7NWDadu1iDq92ktgX?=
 =?Windows-1252?Q?HMdJ1m1PLTDUNThAMIcCn41TXlUJedVxepgS4eWIlmfUh0B0cxopRCsZ?=
 =?Windows-1252?Q?L9hTjBn52pi8un8t5N0z28hO7cI+kKrpVh0Ap7JrTXXTeu4wXJ1ocFa0?=
 =?Windows-1252?Q?TpQCukF967Q6/r6m6zRC/E5SjNuQRI1nf3cc0mG4oX3LiweAu3Txcf7J?=
 =?Windows-1252?Q?DkNEu6alo/B3fAsqG3kVELE+qzd2IkzKsU7INzhHdGhGYT6LLsUFUmMJ?=
 =?Windows-1252?Q?eiByCAH2OZIt/qMqv1DzCBLsIpfHhGrsONFmmw7B1YA9FGxI51FD6qCI?=
 =?Windows-1252?Q?6ExOykcRtVBiB1kC49UCttobApYimqGDAd+T/zWjl2tVKUfrQJYypmJI?=
 =?Windows-1252?Q?BBtBqHNyoWZxoa6LQ9Z3YklP+6kp1uN+xyNyyUtn/ByXCKgUX8ZnCWf7?=
 =?Windows-1252?Q?teS2SSlOBWOvG2KqXGH1CPcg7hw93k8tBIjQrgjdin5BSo1hTfMj1PpD?=
 =?Windows-1252?Q?5a6PUw9LzDiwA7VWS/km62GKNGW7oVz7iSI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59a8ebe-d297-4eb6-9d03-08d8e43d2c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 03:24:26.2540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOd1zclmTQsDbkH5IUShdYrRLgzQIpaj/OoYo+Kl+zADCYMBLYUXw4Ub1X9NmiTEO8IlHmrBrMipsEwULY7jvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
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
Content-Type: multipart/mixed; boundary="===============1887369014=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1887369014==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB462321467D1D08B5180004D8EA909SN6PR12MB4623namp_"

--_000_SN6PR12MB462321467D1D08B5180004D8EA909SN6PR12MB4623namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

You can just rename drm_sched_resubmit_jobs to drm_sched_resubmit_jobs_imp =
and create a wrapper function drm_sched_resubmit_jobs which will call that =
function with MAX_INT and so no need for code change in other driver will b=
e needed. For amdgpu you call directly drm_sched_resubmit_jobs_imp with 1 a=
nd MAX_INT.

Andrey

________________________________
From: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Sent: 10 March 2021 22:05
To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>; Koenig, Christian <Christian.Koenig=
@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: RE: [PATCH v6] drm/amd/amdgpu implement tdr advanced mode

[AMD Official Use Only - Internal Distribution Only]

Hi, Andrey,

Thank you for your review.

>> This is identical to drm_sched_resubmit_jobs in all but the 'int max' ha=
ndling, can't you reuse drm_sched_resubmit_jobs by passing max argument=3D=
=3D1 for the find guilty run and then, for the later normal run passing max=
=3D=3DMAX_INT to avoid break the iteration to early ?

Due to C language doesn't support function overloading, we couldn=92t defin=
e function like the following(compiler error):
void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched, int max =3D I=
NT_MAX);

We have to rewrite every vender's  code where call the drm_sched_resubmit_j=
obs if we defined the function like this.
void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched, int max);

Meanwhile, I also explored the Variable Arguments in C, But it still cannot=
 meet the needs very well.

Do you know some other methods that could help us to make this happen?
Otherwise, I'm afraid we have to define a separate ways as patch V6 did.

Thanks,
Jack

-----Original Message-----
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Sent: Thursday, March 11, 2021 12:19 AM
To: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org=
; Koenig, Christian <Christian.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com=
>; Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH v6] drm/amd/amdgpu implement tdr advanced mode



On 2021-03-10 8:33 a.m., Jack Zhang wrote:
> [Why]
> Previous tdr design treats the first job in job_timeout as the bad job.
> But sometimes a later bad compute job can block a good gfx job and
> cause an unexpected gfx job timeout because gfx and compute ring share
> internal GC HW mutually.
>
> [How]
> This patch implements an advanced tdr mode.It involves an additinal
> synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit
> step in order to find the real bad job.
>
> 1. At Step0 Resubmit stage, it synchronously submits and pends for the
> first job being signaled. If it gets timeout, we identify it as guilty
> and do hw reset. After that, we would do the normal resubmit step to
> resubmit left jobs.
>
> 2. Re-insert Bailing job to mirror_list, and leave it to be handled by
> the main reset thread.
>
> 3. For whole gpu reset(vram lost), do resubmit as the old way.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
>   drivers/gpu/drm/scheduler/sched_main.c     | 75 ++++++++++++++++++++++
>   include/drm/gpu_scheduler.h                |  2 +
>   4 files changed, 148 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e247c3a2ec08..dac0a242e5f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4639,6 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>   int i, r =3D 0;
>   bool need_emergency_restart =3D false;
>   bool audio_suspended =3D false;
> +int tmp_vram_lost_counter;
>
>   /*
>    * Special case: RAS triggered and full reset isn't supported @@
> -4689,9 +4690,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
>   dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already =
in progress",
>   job ? job->base.id : -1);
>
> -/* even we skipped this reset, still need to set the job to guilty */
> -if (job)
> +if (job) {
> +/* re-insert node to avoid memory leak */
> +spin_lock(&job->base.sched->job_list_lock);
> +list_add(&job->base.node, &job->base.sched->pending_list);
> +spin_unlock(&job->base.sched->job_list_lock);
> +/* even we skipped this reset, still need to set the job to guilty
> +*/
>   drm_sched_increase_karma(&job->base);
> +}

I think this piece should be in a standalone patch as it comes to fix a bug=
 of leaking jobs and not directly related to find actual guilty job. Also, =
this is not the only place where the problem arises - it also arises in oth=
er drivers where they check that guilty job's fence already signaled and ba=
il out before reinsertion of bad job to mirror list. Seems to me better fix=
 would be to handle this within scheduler code by adding specific return va=
lue to drm_sched_backend_ops.timedout_job marking that the code terminated =
early - before calling drm_sched_stop and so drm_sched_job_timedout would k=
now this and then reinsert the job back to mirror_list itself.

>   goto skip_recovery;
>   }
>
> @@ -4788,6 +4794,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>   }
>   }
>
> +tmp_vram_lost_counter =3D atomic_read(&((adev)->vram_lost_counter));
>   /* Actual ASIC resets if needed.*/
>   /* TODO Implement XGMI hive reset logic for SRIOV */
>   if (amdgpu_sriov_vf(adev)) {
> @@ -4805,6 +4812,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_device=
 *adev,
>   /* Post ASIC reset for all devs .*/
>   list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>
> +if (amdgpu_gpu_recovery =3D=3D 2 &&
> +!(tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)))
> +{
> +
> +for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> +struct amdgpu_ring *ring =3D tmp_adev->rings[i];
> +int ret =3D 0;
> +struct drm_sched_job *s_job;
> +
> +if (!ring || !ring->sched.thread)
> +continue;
> +
> +/* No point to resubmit jobs if we didn't HW reset*/
> +if (!tmp_adev->asic_reset_res && !job_signaled) {
> +
> +s_job =3D list_first_entry_or_null(&ring->sched.pending_list, struct drm=
_sched_job, list);
> +if (s_job =3D=3D NULL)
> +continue;
> +
> +/* clear job's guilty and depend the folowing step to decide the real on=
e */
> +drm_sched_reset_karma(s_job);
> +drm_sched_resubmit_jobs2(&ring->sched, 1);
> +ret =3D dma_fence_wait_timeout(s_job->s_fence->parent, false,
> +ring->sched.timeout);
> +
> +if (ret =3D=3D 0) { /* timeout */
> +DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n", ring->sched.=
name, s_job->id);
> +/* set guilty */
> +drm_sched_increase_karma(s_job);
> +
> +/* do hw reset */
> +if (amdgpu_sriov_vf(adev)) {
> +amdgpu_virt_fini_data_exchange(adev);
> +r =3D amdgpu_device_reset_sriov(adev, false);
> +if (r)
> +adev->asic_reset_res =3D r;
> +} else {
> +r  =3D amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, =
false);
> +if (r && r =3D=3D -EAGAIN)
> +goto retry;
> +}
> +
> +/* add reset counter so that the following resubmitted job could flush v=
mid */
> +atomic_inc(&tmp_adev->gpu_reset_counter);
> +continue;
> +}
> +
> +/* got the hw fence, signal finished fence */
> +atomic_dec(&ring->sched.num_jobs);
> +dma_fence_get(&s_job->s_fence->finished);
> +dma_fence_signal(&s_job->s_fence->finished);
> +dma_fence_put(&s_job->s_fence->finished);
> +
> +
> +/* remove node from list and free the job */
> +spin_lock(&ring->sched.job_list_lock);
> +list_del_init(&s_job->node);
> +spin_unlock(&ring->sched.job_list_lock);
> +ring->sched.ops->free_job(s_job);
> +}
> +}
> +}
> +
>   for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>   struct amdgpu_ring *ring =3D tmp_adev->rings[i];
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 865f924772b0..9c3f4edb7532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compute_=
multipipe, int, 0444);
>    * DOC: gpu_recovery (int)
>    * Set to enable GPU recovery mechanism (1 =3D enable, 0 =3D disable). =
The default is -1 (auto, disabled except SRIOV).
>    */
> -MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 =3D
> enable, 0 =3D disable, -1 =3D auto)");
> +MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 =3D
> +advanced tdr mode, 1 =3D enable, 0 =3D disable, -1 =3D auto)");
>   module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>
>   /**
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index d82a7ebf6099..340a193b4fb9 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -395,6 +395,81 @@ void drm_sched_increase_karma(struct drm_sched_job *=
bad)
>   }
>   EXPORT_SYMBOL(drm_sched_increase_karma);
>
> +
> +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int
> +max) {
> +struct drm_sched_job *s_job, *tmp;
> +uint64_t guilty_context;
> +bool found_guilty =3D false;
> +struct dma_fence *fence;
> +int i =3D 0;
> +
> +list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
> +struct drm_sched_fence *s_fence =3D s_job->s_fence;
> +
> +if (i >=3D max)
> +break;
> +
> +if (!found_guilty && atomic_read(&s_job->karma) > sched->hang_limit) {
> +found_guilty =3D true;
> +guilty_context =3D s_job->s_fence->scheduled.context;
> +}
> +
> +if (found_guilty && s_job->s_fence->scheduled.context =3D=3D guilty_cont=
ext)
> +dma_fence_set_error(&s_fence->finished, -ECANCELED);
> +
> +dma_fence_put(s_job->s_fence->parent);
> +fence =3D sched->ops->run_job(s_job);
> +i++;
> +
> +if (IS_ERR_OR_NULL(fence)) {
> +if (IS_ERR(fence))
> +dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
> +
> +s_job->s_fence->parent =3D NULL;
> +} else {
> +s_job->s_fence->parent =3D fence;
> +}
> +}
> +}
> +EXPORT_SYMBOL(drm_sched_resubmit_jobs2);

This is identical to drm_sched_resubmit_jobs in all but the 'int max' handl=
ing, can't you reuse drm_sched_resubmit_jobs by passing max argument=3D=3D1=
 for the find guilty run and then, for the later normal run passing max=3D=
=3DMAX_INT to avoid break the iteration to early ?

> +
> +
> +
> +void drm_sched_reset_karma(struct drm_sched_job *bad) {
> +int i;
> +struct drm_sched_entity *tmp;
> +struct drm_sched_entity *entity;
> +struct drm_gpu_scheduler *sched =3D bad->sched;
> +
> +/* don't reset @bad's karma if it's from KERNEL RQ,
> + * because sometimes GPU hang would cause kernel jobs (like VM updating =
jobs)
> + * corrupt but keep in mind that kernel jobs always considered good.
> + */
> +if (bad->s_priority !=3D DRM_SCHED_PRIORITY_KERNEL) {
> +atomic_set(&bad->karma, 0);
> +for (i =3D DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
> +     i++) {
> +struct drm_sched_rq *rq =3D &sched->sched_rq[i];
> +
> +spin_lock(&rq->lock);
> +list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
> +if (bad->s_fence->scheduled.context =3D=3D
> +entity->fence_context) {
> +if (entity->guilty)
> +atomic_set(entity->guilty, 0);
> +break;
> +}
> +}
> +spin_unlock(&rq->lock);
> +if (&entity->list !=3D &rq->entities)
> +break;
> +}
> +}
> +}
> +EXPORT_SYMBOL(drm_sched_reset_karma);

Same as above, very similar drm_sched_increase_karma, I would add a flag an=
d just reuse code instead of duplucation.

Andrey

> +
>   /**
>    * drm_sched_stop - stop the scheduler
>    *
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 1c815e0a14ed..01c609149731 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -321,7 +321,9 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sched=
);
>   void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_j=
ob *bad);
>   void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recover=
y);
>   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
> +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int
> +max);
>   void drm_sched_increase_karma(struct drm_sched_job *bad);
> +void drm_sched_reset_karma(struct drm_sched_job *bad);
>   bool drm_sched_dependency_optimized(struct dma_fence* fence,
>       struct drm_sched_entity *entity);
>   void drm_sched_fault(struct drm_gpu_scheduler *sched);
>

--_000_SN6PR12MB462321467D1D08B5180004D8EA909SN6PR12MB4623namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<div style=3D"color: rgb(0, 0, 0);"><font face=3D"segoe ui westeuropean, se=
goe ui, helvetica, arial, sans-serif"><span style=3D"font-size: 12pt;">You =
can just rename drm_sched_resubmit_jobs to&nbsp;</span></font><span style=
=3D"font-family: &quot;Times New Roman&quot;; font-size: 14.6667px; backgro=
und-color: rgb(255, 255, 255); display: inline !important;">drm_sched_resub=
mit_jobs_imp
 and create a wrapper function</span><span style=3D"background-color: rgb(2=
55, 255, 255); display: inline !important;">&nbsp;<span style=3D"font-famil=
y: &quot;Times New Roman&quot;; font-size: 14.6667px; background-color: rgb=
(255, 255, 255); display: inline !important">drm_sched_resubmit_jobs
 which will call that function with MAX_INT and so no need for code change =
in other driver will be needed. For amdgpu you call directly&nbsp;<span sty=
le=3D"font-family: &quot;Times New Roman&quot;; background-color: rgb(255, =
255, 255); display: inline !important">drm_sched_resubmit_jobs_imp
 with 1 and MAX_INT.</span></span></span></div>
<div style=3D"color: rgb(0, 0, 0);"><span style=3D"background-color: rgb(25=
5, 255, 255); display: inline !important;"><span style=3D"font-family: &quo=
t;Times New Roman&quot;; font-size: 14.6667px; background-color: rgb(255, 2=
55, 255); display: inline !important"><span style=3D"font-family: &quot;Tim=
es New Roman&quot;; background-color: rgb(255, 255, 255); display: inline !=
important"><br>
</span></span></span></div>
<div style=3D"color: rgb(0, 0, 0);"><span style=3D"background-color: rgb(25=
5, 255, 255); display: inline !important;"><span style=3D"font-family: &quo=
t;Times New Roman&quot;; font-size: 14.6667px; background-color: rgb(255, 2=
55, 255); display: inline !important"><span style=3D"font-family: &quot;Tim=
es New Roman&quot;; background-color: rgb(255, 255, 255); display: inline !=
important">Andrey</span></span></span></div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Jack (Jian) &l=
t;Jack.Zhang1@amd.com&gt;<br>
<b>Sent:</b> 10 March 2021 22:05<br>
<b>To:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Den=
g, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH v6] drm/amd/amdgpu implement tdr advanced mode</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - Internal Distribution Only]<br>
<br>
Hi, Andrey,<br>
<br>
Thank you for your review.<br>
<br>
&gt;&gt; This is identical to drm_sched_resubmit_jobs in all but the 'int m=
ax' handling, can't you reuse drm_sched_resubmit_jobs by passing max argume=
nt=3D=3D1 for the find guilty run and then, for the later normal run passin=
g max=3D=3DMAX_INT to avoid break the iteration
 to early ?<br>
<br>
Due to C language doesn't support function overloading, we couldn=92t defin=
e function like the following(compiler error):<br>
void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched, int max =3D I=
NT_MAX);<br>
<br>
We have to rewrite every vender's&nbsp; code where call the drm_sched_resub=
mit_jobs if we defined the function like this.<br>
void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched, int max);<br>
<br>
Meanwhile, I also explored the Variable Arguments in C, But it still cannot=
 meet the needs very well.<br>
<br>
Do you know some other methods that could help us to make this happen?<br>
Otherwise, I'm afraid we have to define a separate ways as patch V6 did.<br=
>
<br>
Thanks,<br>
Jack<br>
<br>
-----Original Message-----<br>
From: Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;<br>
Sent: Thursday, March 11, 2021 12:19 AM<br>
To: Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;; amd-gfx@lists.freedeskt=
op.org; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Liu, Monk &lt;M=
onk.Liu@amd.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
Subject: Re: [PATCH v6] drm/amd/amdgpu implement tdr advanced mode<br>
<br>
<br>
<br>
On 2021-03-10 8:33 a.m., Jack Zhang wrote:<br>
&gt; [Why]<br>
&gt; Previous tdr design treats the first job in job_timeout as the bad job=
.<br>
&gt; But sometimes a later bad compute job can block a good gfx job and<br>
&gt; cause an unexpected gfx job timeout because gfx and compute ring share=
<br>
&gt; internal GC HW mutually.<br>
&gt;<br>
&gt; [How]<br>
&gt; This patch implements an advanced tdr mode.It involves an additinal<br=
>
&gt; synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit<b=
r>
&gt; step in order to find the real bad job.<br>
&gt;<br>
&gt; 1. At Step0 Resubmit stage, it synchronously submits and pends for the=
<br>
&gt; first job being signaled. If it gets timeout, we identify it as guilty=
<br>
&gt; and do hw reset. After that, we would do the normal resubmit step to<b=
r>
&gt; resubmit left jobs.<br>
&gt;<br>
&gt; 2. Re-insert Bailing job to mirror_list, and leave it to be handled by=
<br>
&gt; the main reset thread.<br>
&gt;<br>
&gt; 3. For whole gpu reset(vram lost), do resubmit as the old way.<br>
&gt;<br>
&gt; Signed-off-by: Jack Zhang &lt;Jack.Zhang1@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 ++++++++++=
++++++++++-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c&nbsp;&nbsp;&nbsp;&n=
bsp; | 75 ++++++++++++++++++++++<br>
&gt;&nbsp;&nbsp; include/drm/gpu_scheduler.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +<br>
&gt;&nbsp;&nbsp; 4 files changed, 148 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index e247c3a2ec08..dac0a242e5f5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -4639,6 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp; int i, r =3D 0;<br>
&gt;&nbsp;&nbsp; bool need_emergency_restart =3D false;<br>
&gt;&nbsp;&nbsp; bool audio_suspended =3D false;<br>
&gt; +int tmp_vram_lost_counter;<br>
&gt;<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * Special case: RAS triggered and full reset isn't s=
upported @@<br>
&gt; -4689,9 +4690,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_device=
 *adev,<br>
&gt;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Bailing on TDR for s_job:%llx=
, as another already in progress&quot;,<br>
&gt;&nbsp;&nbsp; job ? job-&gt;base.id : -1);<br>
&gt;<br>
&gt; -/* even we skipped this reset, still need to set the job to guilty */=
<br>
&gt; -if (job)<br>
&gt; +if (job) {<br>
&gt; +/* re-insert node to avoid memory leak */<br>
&gt; +spin_lock(&amp;job-&gt;base.sched-&gt;job_list_lock);<br>
&gt; +list_add(&amp;job-&gt;base.node, &amp;job-&gt;base.sched-&gt;pending_=
list);<br>
&gt; +spin_unlock(&amp;job-&gt;base.sched-&gt;job_list_lock);<br>
&gt; +/* even we skipped this reset, still need to set the job to guilty<br=
>
&gt; +*/<br>
&gt;&nbsp;&nbsp; drm_sched_increase_karma(&amp;job-&gt;base);<br>
&gt; +}<br>
<br>
I think this piece should be in a standalone patch as it comes to fix a bug=
 of leaking jobs and not directly related to find actual guilty job. Also, =
this is not the only place where the problem arises - it also arises in oth=
er drivers where they check that
 guilty job's fence already signaled and bail out before reinsertion of bad=
 job to mirror list. Seems to me better fix would be to handle this within =
scheduler code by adding specific return value to drm_sched_backend_ops.tim=
edout_job marking that the code
 terminated early - before calling drm_sched_stop and so drm_sched_job_time=
dout would know this and then reinsert the job back to mirror_list itself.<=
br>
<br>
&gt;&nbsp;&nbsp; goto skip_recovery;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; @@ -4788,6 +4794,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +tmp_vram_lost_counter =3D atomic_read(&amp;((adev)-&gt;vram_lost_coun=
ter));<br>
&gt;&nbsp;&nbsp; /* Actual ASIC resets if needed.*/<br>
&gt;&nbsp;&nbsp; /* TODO Implement XGMI hive reset logic for SRIOV */<br>
&gt;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; @@ -4805,6 +4812,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_dev=
ice *adev,<br>
&gt;&nbsp;&nbsp; /* Post ASIC reset for all devs .*/<br>
&gt;&nbsp;&nbsp; list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi=
.head) {<br>
&gt;<br>
&gt; +if (amdgpu_gpu_recovery =3D=3D 2 &amp;&amp;<br>
&gt; +!(tmp_vram_lost_counter &lt; atomic_read(&amp;adev-&gt;vram_lost_coun=
ter)))<br>
&gt; +{<br>
&gt; +<br>
&gt; +for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
&gt; +struct amdgpu_ring *ring =3D tmp_adev-&gt;rings[i];<br>
&gt; +int ret =3D 0;<br>
&gt; +struct drm_sched_job *s_job;<br>
&gt; +<br>
&gt; +if (!ring || !ring-&gt;sched.thread)<br>
&gt; +continue;<br>
&gt; +<br>
&gt; +/* No point to resubmit jobs if we didn't HW reset*/<br>
&gt; +if (!tmp_adev-&gt;asic_reset_res &amp;&amp; !job_signaled) {<br>
&gt; +<br>
&gt; +s_job =3D list_first_entry_or_null(&amp;ring-&gt;sched.pending_list, =
struct drm_sched_job, list);<br>
&gt; +if (s_job =3D=3D NULL)<br>
&gt; +continue;<br>
&gt; +<br>
&gt; +/* clear job's guilty and depend the folowing step to decide the real=
 one */<br>
&gt; +drm_sched_reset_karma(s_job);<br>
&gt; +drm_sched_resubmit_jobs2(&amp;ring-&gt;sched, 1);<br>
&gt; +ret =3D dma_fence_wait_timeout(s_job-&gt;s_fence-&gt;parent, false,<b=
r>
&gt; +ring-&gt;sched.timeout);<br>
&gt; +<br>
&gt; +if (ret =3D=3D 0) { /* timeout */<br>
&gt; +DRM_ERROR(&quot;Found the real bad job! ring:%s, job_id:%llx\n&quot;,=
 ring-&gt;sched.name, s_job-&gt;id);<br>
&gt; +/* set guilty */<br>
&gt; +drm_sched_increase_karma(s_job);<br>
&gt; +<br>
&gt; +/* do hw reset */<br>
&gt; +if (amdgpu_sriov_vf(adev)) {<br>
&gt; +amdgpu_virt_fini_data_exchange(adev);<br>
&gt; +r =3D amdgpu_device_reset_sriov(adev, false);<br>
&gt; +if (r)<br>
&gt; +adev-&gt;asic_reset_res =3D r;<br>
&gt; +} else {<br>
&gt; +r&nbsp; =3D amdgpu_do_asic_reset(hive, device_list_handle, &amp;need_=
full_reset, false);<br>
&gt; +if (r &amp;&amp; r =3D=3D -EAGAIN)<br>
&gt; +goto retry;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* add reset counter so that the following resubmitted job could flus=
h vmid */<br>
&gt; +atomic_inc(&amp;tmp_adev-&gt;gpu_reset_counter);<br>
&gt; +continue;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* got the hw fence, signal finished fence */<br>
&gt; +atomic_dec(&amp;ring-&gt;sched.num_jobs);<br>
&gt; +dma_fence_get(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +dma_fence_signal(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +dma_fence_put(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +<br>
&gt; +<br>
&gt; +/* remove node from list and free the job */<br>
&gt; +spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
&gt; +list_del_init(&amp;s_job-&gt;node);<br>
&gt; +spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
&gt; +ring-&gt;sched.ops-&gt;free_job(s_job);<br>
&gt; +}<br>
&gt; +}<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
&gt;&nbsp;&nbsp; struct amdgpu_ring *ring =3D tmp_adev-&gt;rings[i];<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; index 865f924772b0..9c3f4edb7532 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compu=
te_multipipe, int, 0444);<br>
&gt;&nbsp;&nbsp;&nbsp; * DOC: gpu_recovery (int)<br>
&gt;&nbsp;&nbsp;&nbsp; * Set to enable GPU recovery mechanism (1 =3D enable=
, 0 =3D disable). The default is -1 (auto, disabled except SRIOV).<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU recovery mechanism, (=
1 =3D<br>
&gt; enable, 0 =3D disable, -1 =3D auto)&quot;);<br>
&gt; +MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU recovery mechanism, (=
2 =3D<br>
&gt; +advanced tdr mode, 1 =3D enable, 0 =3D disable, -1 =3D auto)&quot;);<=
br>
&gt;&nbsp;&nbsp; module_param_named(gpu_recovery, amdgpu_gpu_recovery, int,=
 0444);<br>
&gt;<br>
&gt;&nbsp;&nbsp; /**<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; index d82a7ebf6099..340a193b4fb9 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; @@ -395,6 +395,81 @@ void drm_sched_increase_karma(struct drm_sched_jo=
b *bad)<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_increase_karma);<br>
&gt;<br>
&gt; +<br>
&gt; +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int<br=
>
&gt; +max) {<br>
&gt; +struct drm_sched_job *s_job, *tmp;<br>
&gt; +uint64_t guilty_context;<br>
&gt; +bool found_guilty =3D false;<br>
&gt; +struct dma_fence *fence;<br>
&gt; +int i =3D 0;<br>
&gt; +<br>
&gt; +list_for_each_entry_safe(s_job, tmp, &amp;sched-&gt;pending_list, lis=
t) {<br>
&gt; +struct drm_sched_fence *s_fence =3D s_job-&gt;s_fence;<br>
&gt; +<br>
&gt; +if (i &gt;=3D max)<br>
&gt; +break;<br>
&gt; +<br>
&gt; +if (!found_guilty &amp;&amp; atomic_read(&amp;s_job-&gt;karma) &gt; s=
ched-&gt;hang_limit) {<br>
&gt; +found_guilty =3D true;<br>
&gt; +guilty_context =3D s_job-&gt;s_fence-&gt;scheduled.context;<br>
&gt; +}<br>
&gt; +<br>
&gt; +if (found_guilty &amp;&amp; s_job-&gt;s_fence-&gt;scheduled.context =
=3D=3D guilty_context)<br>
&gt; +dma_fence_set_error(&amp;s_fence-&gt;finished, -ECANCELED);<br>
&gt; +<br>
&gt; +dma_fence_put(s_job-&gt;s_fence-&gt;parent);<br>
&gt; +fence =3D sched-&gt;ops-&gt;run_job(s_job);<br>
&gt; +i++;<br>
&gt; +<br>
&gt; +if (IS_ERR_OR_NULL(fence)) {<br>
&gt; +if (IS_ERR(fence))<br>
&gt; +dma_fence_set_error(&amp;s_fence-&gt;finished, PTR_ERR(fence));<br>
&gt; +<br>
&gt; +s_job-&gt;s_fence-&gt;parent =3D NULL;<br>
&gt; +} else {<br>
&gt; +s_job-&gt;s_fence-&gt;parent =3D fence;<br>
&gt; +}<br>
&gt; +}<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sched_resubmit_jobs2);<br>
<br>
This is identical to drm_sched_resubmit_jobs in all but the 'int max' handl=
ing, can't you reuse drm_sched_resubmit_jobs by passing max argument=3D=3D1=
 for the find guilty run and then, for the later normal run passing max=3D=
=3DMAX_INT to avoid break the iteration to
 early ?<br>
<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +void drm_sched_reset_karma(struct drm_sched_job *bad) {<br>
&gt; +int i;<br>
&gt; +struct drm_sched_entity *tmp;<br>
&gt; +struct drm_sched_entity *entity;<br>
&gt; +struct drm_gpu_scheduler *sched =3D bad-&gt;sched;<br>
&gt; +<br>
&gt; +/* don't reset @bad's karma if it's from KERNEL RQ,<br>
&gt; + * because sometimes GPU hang would cause kernel jobs (like VM updati=
ng jobs)<br>
&gt; + * corrupt but keep in mind that kernel jobs always considered good.<=
br>
&gt; + */<br>
&gt; +if (bad-&gt;s_priority !=3D DRM_SCHED_PRIORITY_KERNEL) {<br>
&gt; +atomic_set(&amp;bad-&gt;karma, 0);<br>
&gt; +for (i =3D DRM_SCHED_PRIORITY_MIN; i &lt; DRM_SCHED_PRIORITY_KERNEL;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; i++) {<br>
&gt; +struct drm_sched_rq *rq =3D &amp;sched-&gt;sched_rq[i];<br>
&gt; +<br>
&gt; +spin_lock(&amp;rq-&gt;lock);<br>
&gt; +list_for_each_entry_safe(entity, tmp, &amp;rq-&gt;entities, list) {<b=
r>
&gt; +if (bad-&gt;s_fence-&gt;scheduled.context =3D=3D<br>
&gt; +entity-&gt;fence_context) {<br>
&gt; +if (entity-&gt;guilty)<br>
&gt; +atomic_set(entity-&gt;guilty, 0);<br>
&gt; +break;<br>
&gt; +}<br>
&gt; +}<br>
&gt; +spin_unlock(&amp;rq-&gt;lock);<br>
&gt; +if (&amp;entity-&gt;list !=3D &amp;rq-&gt;entities)<br>
&gt; +break;<br>
&gt; +}<br>
&gt; +}<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sched_reset_karma);<br>
<br>
Same as above, very similar drm_sched_increase_karma, I would add a flag an=
d just reuse code instead of duplucation.<br>
<br>
Andrey<br>
<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * drm_sched_stop - stop the scheduler<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h=
<br>
&gt; index 1c815e0a14ed..01c609149731 100644<br>
&gt; --- a/include/drm/gpu_scheduler.h<br>
&gt; +++ b/include/drm/gpu_scheduler.h<br>
&gt; @@ -321,7 +321,9 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sc=
hed);<br>
&gt;&nbsp;&nbsp; void drm_sched_stop(struct drm_gpu_scheduler *sched, struc=
t drm_sched_job *bad);<br>
&gt;&nbsp;&nbsp; void drm_sched_start(struct drm_gpu_scheduler *sched, bool=
 full_recovery);<br>
&gt;&nbsp;&nbsp; void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sch=
ed);<br>
&gt; +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int<br=
>
&gt; +max);<br>
&gt;&nbsp;&nbsp; void drm_sched_increase_karma(struct drm_sched_job *bad);<=
br>
&gt; +void drm_sched_reset_karma(struct drm_sched_job *bad);<br>
&gt;&nbsp;&nbsp; bool drm_sched_dependency_optimized(struct dma_fence* fenc=
e,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity);<=
br>
&gt;&nbsp;&nbsp; void drm_sched_fault(struct drm_gpu_scheduler *sched);<br>
&gt;<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_SN6PR12MB462321467D1D08B5180004D8EA909SN6PR12MB4623namp_--

--===============1887369014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1887369014==--
