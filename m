Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EFDC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 13:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4AD64FEE
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 13:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4AD64FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46676EA10;
	Wed, 10 Mar 2021 13:36:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65366EA10
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 13:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTbKtkrky1QWI07MEZcqM5w9eQmbTyMogyxnYJNFlfBc5BTXMdV1B8h7C4VsHpNSNFoGv4TlFbNtRgnHfblB7WOiM2Kb89Gnby6Qf+sNuEAjKjb2nhLQizpCNpINKzh5HMVRLWZgg+qSX7qP0Fw/HQ9Bv87FUn1iQVpLff8lLmCbkaUtBkKX5Iv8a/mfae+L0fefAXQ6WNcgxOHcp+yiWKrRsWjFxZvRF+GUFD/5uUJ5zUbj3Gk9Ng3RgSuD0Jx1jhEloCJHJE5ZI3rZQFr2nPbEeryeHyb8uik1yACI5r6YchU9x3gT/BuVBDau7JMd3Ej/WwkfxAIwR5WD2MTCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfLAOEuf9gWmUBCfBY6izA/O7zKmavaNzpWWRPZNw2c=;
 b=LR7AGGAMWoa4lSUUq9OmRZiDfNOGjPecrOOFkO51d/nUnDJe/YNmMrII8Vr/hMs6buZdyUhj9keO3OKRovR3tfN71CcieNajYXGrl4zmwuwnFHln2SunTCPYjjmAT/5NOLV+ymWmFKSPfohY5tuudLbrPmERvEcdmTpsQUBXEj33tF4cu45EzZ3oivgZ1hwdXP5hm32p1wTqUF7n2FRSLfjZ/SwlOGS6YqAoZWkpZsFCQ9NxsZdw2MQ+vg4WWhdzainXqAT8DwULvuK/DZPmPqU/V33064DVLj48UuXVTH2cxYD+LPI1Y77yGAGl+rCcepsZkY8G6OTXISEQlA/XPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfLAOEuf9gWmUBCfBY6izA/O7zKmavaNzpWWRPZNw2c=;
 b=iZlr7sB+rT3Lilh79datcGLDLHX6Tso/8LKvKVu0gSQDdtgQtRcTywKblP0sjdeNtKeFps6a9/0Oe6da3zY4IEV2hCiD43scOdE5v2XVEDSvGXBihVXFak3sbHEsa9W0JuM+Ukhts2Ha4pdu/QTqpfmRUZ7+9Vrw1XEl1kd9PQI=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Wed, 10 Mar
 2021 13:36:21 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc%9]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 13:36:21 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode
Thread-Topic: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode
Thread-Index: AQHXFZ9BggKFBBQx4ku18DddIDGpRap9LeKAgAALQKM=
Date: Wed, 10 Mar 2021 13:36:21 +0000
Message-ID: <DM5PR1201MB02044274BD6BB85B3828074FBB919@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <20210310111921.928619-1-Jack.Zhang1@amd.com>,
 <70e3aabc-6bb0-b88c-0e97-de42e1e8b8e6@amd.com>
In-Reply-To: <70e3aabc-6bb0-b88c-0e97-de42e1e8b8e6@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-10T13:35:09.2342991Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.140.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4405047c-a694-4730-ac30-08d8e3c97e28
x-ms-traffictypediagnostic: DM5PR12MB1754:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17548DDC413CEDB781A63541BB919@DM5PR12MB1754.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nTH5ylL4Nf18ibwh7MJyiGgZjddSwxcU6/AAT74f7HW/tNkqZk1eu6L5F4TMPAd1KQ2cUPWeFEkQX5adIPT5SVL4thfRIvV+SOd2ahQSjtjiaUxIrZsSJexkHiIyWfMCpO19sFT68WnC/3ZsOg3LSI2h/47lO9c4QOMTCXMNVL97vIDS1gx6ytC1UYJZhNfDFlE02s/LZ66Md+Lqkj4hJXOQvwB1NFpSHvxsnw1vFoNbgvJnpVZmuTAnbGFiR1UaA8yCmdMrzNtQmAPsaHtyCpv7xzpt1QCtHLC9UCyU6yN21lFhPRXjUta1fcHGTq7Q1dY3YqBhwcve5mvs4WtF2QkCTvhFUN2Nt+AhGwYChMUnVLMB0iwgZDRjmtbEoaEaXH/KWun+zjD7PVFN1yUCsscphxtis+A/yGiIpE0j7vMDrbBpwrQDUzCGGKcnXpiQQbqU71bfyghTO9T3i4kAls6ZF3QEzpNcYTeHaTXvdcjpoqb5KmhiNbb1Bq0OeZBPBAUDktPeXV7x+KbhDS62XQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(478600001)(7696005)(6636002)(55016002)(9686003)(53546011)(8676002)(6506007)(8936002)(186003)(2906002)(26005)(33656002)(71200400001)(316002)(5660300002)(66446008)(66946007)(64756008)(66556008)(66476007)(52536014)(76116006)(110136005)(91956017)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lBh6sCjYY/Kz1RgzIFbE7/8w+RJTbEIQZO2nyc6npdkAJy9SAfmp3jL400WQ?=
 =?us-ascii?Q?uvw/6GrKwhLbJ6W079tZ4F1BgmS3Bl0jTE7S9C93kw928z6T00xVicW5NkCz?=
 =?us-ascii?Q?c9eY6Zw+k/ohpSX2bHSIcxKZnS+VU3EZGPH7O38swwg7ziginOuaaSHUUfmx?=
 =?us-ascii?Q?pkV9HRq2LLSuCxmVBk/TgYM0OJ2UFQupJGU8AowlPUththHgHQPAvQuwzM5R?=
 =?us-ascii?Q?IiM1hVkOAurpFQPS3dszR1HNzoZl9p8CrCUa5qfaf7O5piYB+YXPjpozDN7O?=
 =?us-ascii?Q?RLonfnihi0CYafQyqA0343bsXD3fZH1Mj47FvFsqjShn9k+7HWZpgCxSoeJX?=
 =?us-ascii?Q?01sTJ7z3ECP+hdjq+NXjjwOokqcTowDIgM4M/GCJm8h1PHIFZyM/NXm0o/FW?=
 =?us-ascii?Q?H1ocY5uHAbhMUW64C779sXjhi+IWgOsuxeF0wTyliJPOj7/55srvHF8sHSr0?=
 =?us-ascii?Q?40j8/VGoNv5hi13WcjfEX3m3Ry+1lfG6IWNvWbgs/eaZIaf/L+SvTorBzR5z?=
 =?us-ascii?Q?V8pUoD3nPge5JSV6yKzBySOYSZh9NXv1hI0yDUWY3sPpsVdvTiKMaFx6hOaB?=
 =?us-ascii?Q?nQudp3R9kQc4yoYr1uixtuot2aEpyRiyHaPIbLK38jB61T+39drm0Eqs5VjM?=
 =?us-ascii?Q?ckhpmfuR7P0uWr7fFtDSF9sqF/cNYwOT2U2SNz5UynMZC8UqWzaUbI7ckW0E?=
 =?us-ascii?Q?qvtcEWf7ypAYQNiC/hyJe8ewXlvm0yGP4cZBY2L3gIRLyO+4zgMUkZEwWkEb?=
 =?us-ascii?Q?F3wbkn3GbyEXWFjbOAn22tmO3cfxVTP+Sy7ZI7uztREH4llTxgYwAOQn2N1U?=
 =?us-ascii?Q?Q53So3+8ycFWtn2Ft0Eq4wemeEj3PqYQGzm4ZWy6QJ9Nk56TNSjKKqpxKmEi?=
 =?us-ascii?Q?QzzeYUjXOaR0yUUrQYPXzzuHRiDnCtP7I3sqK3m46uXFQa6kZIM9vsT4V4Z9?=
 =?us-ascii?Q?XP6Ahm8J0cv6Pv7kwkzxywtBNzhM9/J5mp1R5skgkkintIiYfCfuawFv77VO?=
 =?us-ascii?Q?D9WqJbjuomejZcR8IwV0zloVx25vGpu9WI8KhTV2NtywZ5XjbRMIKF1I7Djz?=
 =?us-ascii?Q?P/HcmmZwJa4OVSN2+t9bmCf/ywJ2fwQyTqMsg5LIhQuXzwk8gzC7X+9IFfZ4?=
 =?us-ascii?Q?rmV8qUn6C3OYPAigs9eFF7rWaSrifOwoij4CdQTOYHCsYcro3oc70n2/shAo?=
 =?us-ascii?Q?0Nu3IIxp9AYTfGQvPdEIjZjMaq7begjFUt3Hu+df9aaUJ5dLCkSW+f8/7yba?=
 =?us-ascii?Q?pXcokAoj1BP6avmNlqGbGV5Xt831RQhd7QMKASXn1elKaRcIsMuPApAVz2QU?=
 =?us-ascii?Q?626PdcbZwVjCIqCbpbzeGO8xB0NsSuYB0vZQUm+WTqGGKQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0204.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4405047c-a694-4730-ac30-08d8e3c97e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 13:36:21.5512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJ8gb+4jFbo8rnCPqSQe60mdoXdpJz2JOhb29mCmZTDq2KJxXIBEz04iq4GEmMd8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
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
Content-Type: multipart/mixed; boundary="===============1619969695=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1619969695==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB02044274BD6BB85B3828074FBB919DM5PR1201MB0204_"

--_000_DM5PR1201MB02044274BD6BB85B3828074FBB919DM5PR1201MB0204_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks Christian? just did the checkpatch scan.  Please see the V6 patch

/Jack


________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, March 10, 2021 8:54:53 PM
To: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org=
 <amd-gfx@lists.freedesktop.org>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd=
.com>; Liu, Monk <Monk.Liu@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode

Am 10.03.21 um 12:19 schrieb Jack Zhang:
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
> Change-Id: I408357f10b9034caaa1b83610e19e514c5fbaaf2
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 73 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
>   drivers/gpu/drm/scheduler/sched_main.c     | 75 ++++++++++++++++++++++
>   include/drm/gpu_scheduler.h                |  2 +
>   4 files changed, 148 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e247c3a2ec08..02056355a055 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4639,7 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>        int i, r =3D 0;
>        bool need_emergency_restart =3D false;
>        bool audio_suspended =3D false;
> -
> +     int     tmp_vram_lost_counter;

Please keep the empoty line between declaration and code.

In general give that patch a pass with checkpath.pl since there are a
couple of other place which needs fixing at first glance.

Christian.


>        /*
>         * Special case: RAS triggered and full reset isn't supported
>         */
> @@ -4689,9 +4689,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_device=
 *adev,
>                dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as ano=
ther already in progress",
>                                        job ? job->base.id : -1);
>
> -             /* even we skipped this reset, still need to set the job to=
 guilty */
> -             if (job)
> +             if (job) {
> +                     /* re-insert node to avoid memory leak */
> +                     spin_lock(&job->base.sched->job_list_lock);
> +                     list_add(&job->base.node, &job->base.sched->pending=
_list);
> +                     spin_unlock(&job->base.sched->job_list_lock);
> +                     /* even we skipped this reset, still need to set th=
e job to guilty */
>                        drm_sched_increase_karma(&job->base);
> +             }
>                goto skip_recovery;
>        }
>
> @@ -4788,6 +4793,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>                }
>        }
>
> +     tmp_vram_lost_counter =3D atomic_read(&((adev)->vram_lost_counter))=
;
>        /* Actual ASIC resets if needed.*/
>        /* TODO Implement XGMI hive reset logic for SRIOV */
>        if (amdgpu_sriov_vf(adev)) {
> @@ -4805,6 +4811,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_device=
 *adev,
>        /* Post ASIC reset for all devs .*/
>        list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>
> +             if (amdgpu_gpu_recovery =3D=3D 2 &&
> +                     !(tmp_vram_lost_counter < atomic_read(&adev->vram_l=
ost_counter))) {
> +
> +                     for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> +                             struct amdgpu_ring *ring =3D tmp_adev->ring=
s[i];
> +                             int ret =3D 0;
> +                             struct drm_sched_job *s_job;
> +
> +                             if (!ring || !ring->sched.thread)
> +                                     continue;
> +
> +                             /* No point to resubmit jobs if we didn't H=
W reset*/
> +                             if (!tmp_adev->asic_reset_res && !job_signa=
led) {
> +
> +                                     s_job =3D list_first_entry_or_null(=
&ring->sched.pending_list, struct drm_sched_job, list);
> +                                     if (s_job =3D=3D NULL)
> +                                             continue;
> +
> +                                     /* clear job's guilty and depend th=
e folowing step to decide the real one */
> +                                     drm_sched_reset_karma(s_job);
> +                                     drm_sched_resubmit_jobs2(&ring->sch=
ed, 1);
> +                                     ret =3D dma_fence_wait_timeout(s_jo=
b->s_fence->parent, false, ring->sched.timeout);
> +
> +                                     if (ret =3D=3D 0) { /* timeout */
> +                                             DRM_ERROR("Found the real b=
ad job! ring:%s, job_id:%llx\n", ring->sched.name, s_job->id);
> +                                             /* set guilty */
> +                                             drm_sched_increase_karma(s_=
job);
> +
> +                                             /* do hw reset */
> +                                             if (amdgpu_sriov_vf(adev)) =
{
> +                                                     amdgpu_virt_fini_da=
ta_exchange(adev);
> +                                                     r =3D amdgpu_device=
_reset_sriov(adev, false);
> +                                                     if (r)
> +                                                             adev->asic_=
reset_res =3D r;
> +                                             } else {
> +                                                     r  =3D amdgpu_do_as=
ic_reset(hive, device_list_handle, &need_full_reset, false);
> +                                                     if (r && r =3D=3D -=
EAGAIN)
> +                                                             goto retry;
> +                                             }
> +
> +                                             /* add reset counter so tha=
t the following resubmitted job could flush vmid */
> +                                             atomic_inc(&tmp_adev->gpu_r=
eset_counter);
> +                                             continue;
> +                                     }
> +
> +                                     /* got the hw fence, signal finishe=
d fence */
> +                                     atomic_dec(&ring->sched.num_jobs);
> +                                     dma_fence_get(&s_job->s_fence->fini=
shed);
> +                                     dma_fence_signal(&s_job->s_fence->f=
inished);
> +                                     dma_fence_put(&s_job->s_fence->fini=
shed);
> +
> +
> +                                     /* remove node from list and free t=
he job */
> +                                     spin_lock(&ring->sched.job_list_loc=
k);
> +                                     list_del_init(&s_job->node);
> +                                     spin_unlock(&ring->sched.job_list_l=
ock);
> +                                     ring->sched.ops->free_job(s_job);
> +                             }
> +                     }
> +             }
> +
>                for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>                        struct amdgpu_ring *ring =3D tmp_adev->rings[i];
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 865f924772b0..9c3f4edb7532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compute_=
multipipe, int, 0444);
>    * DOC: gpu_recovery (int)
>    * Set to enable GPU recovery mechanism (1 =3D enable, 0 =3D disable). =
The default is -1 (auto, disabled except SRIOV).
>    */
> -MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 =3D en=
able, 0 =3D disable, -1 =3D auto)");
> +MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 =3D ad=
vanced tdr mode, 1 =3D enable, 0 =3D disable, -1 =3D auto)");
>   module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>
>   /**
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index d82a7ebf6099..99a6a8bddd6f 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -395,6 +395,81 @@ void drm_sched_increase_karma(struct drm_sched_job *=
bad)
>   }
>   EXPORT_SYMBOL(drm_sched_increase_karma);
>
> +
> +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int max)
> +{
> +     struct drm_sched_job *s_job, *tmp;
> +     uint64_t guilty_context;
> +     bool found_guilty =3D false;
> +     struct dma_fence *fence;
> +     int i =3D 0;
> +
> +     list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
> +             struct drm_sched_fence *s_fence =3D s_job->s_fence;
> +
> +             if (i>=3Dmax)
> +                     break;
> +
> +             if (!found_guilty && atomic_read(&s_job->karma) > sched->ha=
ng_limit) {
> +                     found_guilty =3D true;
> +                     guilty_context =3D s_job->s_fence->scheduled.contex=
t;
> +             }
> +
> +             if (found_guilty && s_job->s_fence->scheduled.context =3D=
=3D guilty_context)
> +                     dma_fence_set_error(&s_fence->finished, -ECANCELED)=
;
> +
> +             dma_fence_put(s_job->s_fence->parent);
> +             fence =3D sched->ops->run_job(s_job);
> +             i++;
> +
> +             if (IS_ERR_OR_NULL(fence)) {
> +                     if (IS_ERR(fence))
> +                             dma_fence_set_error(&s_fence->finished, PTR=
_ERR(fence));
> +
> +                     s_job->s_fence->parent =3D NULL;
> +             } else {
> +                     s_job->s_fence->parent =3D fence;
> +             }
> +     }
> +}
> +EXPORT_SYMBOL(drm_sched_resubmit_jobs2);
> +
> +
> +
> +void drm_sched_reset_karma(struct drm_sched_job *bad)
> +{
> +     int i;
> +     struct drm_sched_entity *tmp;
> +     struct drm_sched_entity *entity;
> +     struct drm_gpu_scheduler *sched =3D bad->sched;
> +
> +     /* don't reset @bad's karma if it's from KERNEL RQ,
> +      * because sometimes GPU hang would cause kernel jobs (like VM upda=
ting jobs)
> +      * corrupt but keep in mind that kernel jobs always considered good=
.
> +      */
> +     if (bad->s_priority !=3D DRM_SCHED_PRIORITY_KERNEL) {
> +             atomic_set(&bad->karma, 0);
> +             for (i =3D DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_K=
ERNEL;
> +                  i++) {
> +                     struct drm_sched_rq *rq =3D &sched->sched_rq[i];
> +
> +                     spin_lock(&rq->lock);
> +                     list_for_each_entry_safe(entity, tmp, &rq->entities=
, list) {
> +                             if (bad->s_fence->scheduled.context =3D=3D
> +                                 entity->fence_context) {
> +                                             if (entity->guilty)
> +                                                     atomic_set(entity->=
guilty, 0);
> +                                     break;
> +                             }
> +                     }
> +                     spin_unlock(&rq->lock);
> +                     if (&entity->list !=3D &rq->entities)
> +                             break;
> +             }
> +     }
> +}
> +EXPORT_SYMBOL(drm_sched_reset_karma);
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
> +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int max);
>   void drm_sched_increase_karma(struct drm_sched_job *bad);
> +void drm_sched_reset_karma(struct drm_sched_job *bad);
>   bool drm_sched_dependency_optimized(struct dma_fence* fence,
>                                    struct drm_sched_entity *entity);
>   void drm_sched_fault(struct drm_gpu_scheduler *sched);


--_000_DM5PR1201MB02044274BD6BB85B3828074FBB919DM5PR1201MB0204_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Thanks Christian&#65292; just did the checkpatch scan.&nbsp; Please see the=
 V6 patch<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
/Jack<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 10, 2021 8:54:53 PM<br>
<b>To:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;; amd-gfx@lists.fr=
eedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Grodzovsky, Andrey &lt=
;Andrey.Grodzovsky@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Deng, E=
mily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 10.03.21 um 12:19 schrieb Jack Zhang:<br>
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
&gt; Change-Id: I408357f10b9034caaa1b83610e19e514c5fbaaf2<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 73 ++++++++++=
++++++++++-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c&nbsp;&nbsp;&nbsp;&n=
bsp; | 75 ++++++++++++++++++++++<br>
&gt;&nbsp;&nbsp; include/drm/gpu_scheduler.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +<br>
&gt;&nbsp;&nbsp; 4 files changed, 148 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index e247c3a2ec08..02056355a055 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -4639,7 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restart =
=3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended =3D fal=
se;<br>
&gt; -<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; tmp_vram_lost_co=
unter;<br>
<br>
Please keep the empoty line between declaration and code.<br>
<br>
In general give that patch a pass with checkpath.pl since there are a <br>
couple of other place which needs fixing at first glance.<br>
<br>
Christian.<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Special case: RAS tr=
iggered and full reset isn't supported<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; @@ -4689,9 +4689,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_dev=
ice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Bailing on TDR for s_job:%=
llx, as another already in progress&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; job ? job-&gt;base.id : -1);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* even we skipped this reset, still need to set the job to guilty */<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (job)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (job) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* re-insert node to av=
oid memory leak */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;job-&gt;=
base.sched-&gt;job_list_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;job-&gt;b=
ase.node, &amp;job-&gt;base.sched-&gt;pending_list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;job-&g=
t;base.sched-&gt;job_list_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* even we skipped this=
 reset, still need to set the job to guilty */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sch=
ed_increase_karma(&amp;job-&gt;base);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto skip_recovery;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -4788,6 +4793,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tmp_vram_lost_counter =3D atomic_read(&amp;(=
(adev)-&gt;vram_lost_counter));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Actual ASIC resets if nee=
ded.*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO Implement XGMI hive =
reset logic for SRIOV */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {=
<br>
&gt; @@ -4805,6 +4811,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_dev=
ice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Post ASIC reset for all d=
evs .*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev=
, device_list_handle, gmc.xgmi.head) {<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_gpu_recovery =3D=3D 2 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(tmp_vram_lost_counter=
 &lt; atomic_read(&amp;adev-&gt;vram_lost_counter))) {<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AM=
DGPU_MAX_RINGS; ++i) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D tmp_adev-&gt;rings[i]=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *s_job;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!ring || !ring-&gt;sched.thread)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
ntinue;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* No point to resubmit jobs if we didn't HW reset=
*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!tmp_adev-&gt;asic_reset_res &amp;&amp; !job_s=
ignaled) {<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_=
job =3D list_first_entry_or_null(&amp;ring-&gt;sched.pending_list, struct d=
rm_sched_job, list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (s_job =3D=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 clear job's guilty and depend the folowing step to decide the real one */<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dr=
m_sched_reset_karma(s_job);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dr=
m_sched_resubmit_jobs2(&amp;ring-&gt;sched, 1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
t =3D dma_fence_wait_timeout(s_job-&gt;s_fence-&gt;parent, false, ring-&gt;=
sched.timeout);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (ret =3D=3D 0) { /* timeout */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Found the rea=
l bad job! ring:%s, job_id:%llx\n&quot;, ring-&gt;sched.name, s_job-&gt;id)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set guilty */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_increase_karma(s_jo=
b);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* do hw reset */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; amdgpu_virt_fini_data_exchange(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_reset_sriov(adev, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt=
;asic_reset_res =3D r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; r&nbsp; =3D amdgpu_do_asic_reset(hive, device_list_handl=
e, &amp;need_full_reset, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (r &amp;&amp; r =3D=3D -EAGAIN)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto ret=
ry;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add reset counter so that =
the following resubmitted job could flush vmid */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;tmp_adev-&gt;=
gpu_reset_counter);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 got the hw fence, signal finished fence */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at=
omic_dec(&amp;ring-&gt;sched.num_jobs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm=
a_fence_get(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm=
a_fence_signal(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm=
a_fence_put(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 remove node from list and free the job */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sp=
in_lock(&amp;ring-&gt;sched.job_list_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; li=
st_del_init(&amp;s_job-&gt;node);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sp=
in_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ri=
ng-&gt;sched.ops-&gt;free_job(s_job);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
amdgpu_ring *ring =3D tmp_adev-&gt;rings[i];<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
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
1 =3D enable, 0 =3D disable, -1 =3D auto)&quot;);<br>
&gt; +MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU recovery mechanism, (=
2 =3D advanced tdr mode, 1 =3D enable, 0 =3D disable, -1 =3D auto)&quot;);<=
br>
&gt;&nbsp;&nbsp; module_param_named(gpu_recovery, amdgpu_gpu_recovery, int,=
 0444);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/=
scheduler/sched_main.c<br>
&gt; index d82a7ebf6099..99a6a8bddd6f 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; @@ -395,6 +395,81 @@ void drm_sched_increase_karma(struct drm_sched_jo=
b *bad)<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_increase_karma);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +<br>
&gt; +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int ma=
x)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *s_job, *tmp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t guilty_context;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool found_guilty =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(s_job, tmp, &amp;sc=
hed-&gt;pending_list, list) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct drm_sched_fence *s_fence =3D s_job-&gt;s_fence;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (i&gt;=3Dmax)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!found_guilty &amp;&amp; atomic_read(&amp;s_job-&gt;karma) &gt; sch=
ed-&gt;hang_limit) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found_guilty =3D true;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; guilty_context =3D s_jo=
b-&gt;s_fence-&gt;scheduled.context;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (found_guilty &amp;&amp; s_job-&gt;s_fence-&gt;scheduled.context =3D=
=3D guilty_context)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_set_error(&am=
p;s_fence-&gt;finished, -ECANCELED);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dma_fence_put(s_job-&gt;s_fence-&gt;parent);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; fence =3D sched-&gt;ops-&gt;run_job(s_job);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; i++;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (IS_ERR_OR_NULL(fence)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(fence))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_set_error(&amp;s_fence-&gt;finished, PTR=
_ERR(fence));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_job-&gt;s_fence-&gt;p=
arent =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_job-&gt;s_fence-&gt;p=
arent =3D fence;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sched_resubmit_jobs2);<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +void drm_sched_reset_karma(struct drm_sched_job *bad)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *tmp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched =3D bad-&gt;=
sched;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* don't reset @bad's karma if it's from KER=
NEL RQ,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because sometimes GPU hang would cau=
se kernel jobs (like VM updating jobs)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * corrupt but keep in mind that kernel=
 jobs always considered good.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_priority !=3D DRM_SCHED_PRIORI=
TY_KERNEL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; atomic_set(&amp;bad-&gt;karma, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D DRM_SCHED_PRIORITY_MIN; i &lt; DRM_SCHED_PRIORITY_KERNEL;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq=
 =3D &amp;sched-&gt;sched_rq[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;rq-&gt;l=
ock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_saf=
e(entity, tmp, &amp;rq-&gt;entities, list) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_fence-&gt;scheduled.context =3D=3D<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;fence_context) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (entity-&gt;guilty)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; atomic_set(entity-&gt;guilty, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;rq-&gt=
;lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (&amp;entity-&gt;lis=
t !=3D &amp;rq-&gt;entities)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sched_reset_karma);<br>
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
&gt; +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int ma=
x);<br>
&gt;&nbsp;&nbsp; void drm_sched_increase_karma(struct drm_sched_job *bad);<=
br>
&gt; +void drm_sched_reset_karma(struct drm_sched_job *bad);<br>
&gt;&nbsp;&nbsp; bool drm_sched_dependency_optimized(struct dma_fence* fenc=
e,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm=
_sched_entity *entity);<br>
&gt;&nbsp;&nbsp; void drm_sched_fault(struct drm_gpu_scheduler *sched);<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR1201MB02044274BD6BB85B3828074FBB919DM5PR1201MB0204_--

--===============1619969695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1619969695==--
