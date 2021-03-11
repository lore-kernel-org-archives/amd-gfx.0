Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C77C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 12:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6017D64FD9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 12:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6017D64FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2110D6E52D;
	Thu, 11 Mar 2021 12:20:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708916E52D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 12:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahFr0V3NsvuwvwB+lhU8tWh/SvhjvDkypqg81dYLokT0SEQSX2rkgQDfr65JW+N8F3HctIS/zzEo40Ali6ToeQDhy0XZ/c9yoPzGrW0q8A0ymbnqtg0GnNcXpOJtVtKixYTdgBJBX/omkXIDO1SeMGt50pitKPhpNz6HwJeWL91L2UGLwb0SlSi2cNMoiWFHqFz82eITdgzh8Lcp4KkfLYCCQZs2LmjUUIy5OsuRrhLIEQgdPbkf/PepGHJI+hGnMX2GZQgD4qVDDpml/arlizj7eZUqC6u79fGugFouggBYBlan3Q9OuZSJodTFpbEL4HPs5JafzfMHn0PG1tDGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7SI27UFpUf/DLWVClAqtcruOpaHHtJ5WexhTbJmhVI=;
 b=cKU+EPHKbStIGY/F2ceocrFXLZq+XLVH2JpIqV+4VHSLb/Q6tNZ4kwynT4IcXUI/+y0utF3Y1+pgqvJUmhKgUno9hr8feUbnn+Q9MJKhtakjilxhC3rzgnyT9Obl5IHvDJM/pYTHZcpWC1u/bO4haC8mXwfwhA7z1kRgG3tydfSEEExcVAgAEZgjSfVLXMirZGpUu6O8UdFa3AWDeWnEO0nJFF2i5gzgM7/DQMcTnqmdlT1iV4tsbLW56XE2tKMlFBJkM3IrVSJz3hNLirgUuDc1Ymf/o3My2J0Mk2gWxN3hvixZYYxzEYghHgAw3Gx1SCvkIfxjGbR81S+fM4M3bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7SI27UFpUf/DLWVClAqtcruOpaHHtJ5WexhTbJmhVI=;
 b=CSOBV8kmFWJEN/TfQe5FFXotpHw9P9h+vTsKLkC57+m2whwCBYd74+dZA2Zm9rIX+ubsJXdyBQmMFGyDrYycnkTV/HbtMvvwW7JMJVlg5A2mqGEkcKbi47YBlSIfUzv+8IjMyhbpPVgPuURRyUpblemyTu+hQnf41kBVHY60GmI=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Thu, 11 Mar
 2021 12:20:08 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc%9]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 12:20:08 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH v7] drm/amd/amdgpu implement tdr advanced mode
Thread-Topic: [PATCH v7] drm/amd/amdgpu implement tdr advanced mode
Thread-Index: AQHXFju1UE+NnWQNtkW8Cn+tvO40R6p+mZuAgAAbTjM=
Date: Thu, 11 Mar 2021 12:20:08 +0000
Message-ID: <DM5PR1201MB0204B2725774B55A2DA57706BB909@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <20210311055838.980188-1-Jack.Zhang1@amd.com>,
 <a7108500-6d23-f674-959b-94fc988ba3af@amd.com>
In-Reply-To: <a7108500-6d23-f674-959b-94fc988ba3af@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-11T12:18:48.1780789Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.140.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9043bab9-09be-4e80-6649-08d8e48802d2
x-ms-traffictypediagnostic: DM6PR12MB4250:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4250DAC2BE1B18475C7C7D69BB909@DM6PR12MB4250.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zijIUZ+EhcD6bozXSYruxAizuzZTWWKFJsMSl5PSQ8vWY95zlTwOTuQE/187O0p1/1k9rlchWM/vBdat1ETnrg8SDFZEmVl9V9mXNqs0uZ2ZRrWordUX6ajgRdLqDGAbT/IHhYEjQZW8xC8mFt+p9pnDbbruN3mVWVENrJpR0TJUH6grhEL+64LLw+zypqAKHxtzK6dsglshOQJ0+/6K1RALRgpoDocMptuDxOhYk+yqqOvsjo+9NxRtjK3chRRin1pbAdNaRmVma7OiymBYJUpxOay9oTmeZzVuJjdCMwePubEX7624Q1xyebZF2p2+gPI6SuJYnq/mpwm9hJgwJeQ9mKKREM+MHn2a6gbiWmS9GGoqbCGoavbFx6Q3z2ISadUmCqfAKYBq6AfiOfw/Zqg9dQpDgp4Ps3BB36aMnZNkgoFJO7alNYoaHT3jegvOk3np7TV/3MeecnICMM+nHn0qULBRGxmyVewYNNH9kzJccagsaWIjUbyxHPtjO9dceD8P5ONqwM6ckZLdD4Gxsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(5660300002)(86362001)(53546011)(76116006)(71200400001)(33656002)(52536014)(8676002)(66946007)(9686003)(8936002)(30864003)(6506007)(83380400001)(66476007)(55016002)(66556008)(26005)(110136005)(6636002)(91956017)(64756008)(7696005)(478600001)(186003)(316002)(2906002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x8xlJOGnisBH9mXGPzEjXeDbnN2A561akKL5PRAd6RfYTx8UxEZOlPKC5WPU?=
 =?us-ascii?Q?dT2sW8btIm7CxAno4+/AJrMBByQEcZDDdn6TJ+TJIx9Jk96TglPn/XsBsomb?=
 =?us-ascii?Q?I1IDIdT188cnF+hxYHwpMCW33iFMsao0V4HqSzUsNB16SVLKCzwUXyC5+65o?=
 =?us-ascii?Q?uCBoT0/+29Uvmc/o2NzzMVvrht9dqr6Rh4HhJBh8hjR/RvqHrkL6m2j4O7cv?=
 =?us-ascii?Q?huRk3uxWFw2j1f7Te9yOiqyvd5NPCnlQ0wyEt4xeqrUiW28QGr+TFXPlCsxg?=
 =?us-ascii?Q?XEsEs+96TfpTlJulR1V0PEHgq4o6FaIxVTK+La1iwHVyG9r8uLy+MogY65vd?=
 =?us-ascii?Q?Ke/opsQ1eIKgZIBDKOZJv1Dq+Secbk1R2EiT7bWnYCV7Qfdgt78dYS8gaEwR?=
 =?us-ascii?Q?FGBXyhZHJAIS3L60Pf7HNq2GEahShFpllcOLYhh2ZTYnbpsj3TKLqg7q3UwK?=
 =?us-ascii?Q?4XpfS/hb+na61YLhcTWEz497YObHJfzj+vYmqZLimNvE2f8/PAzDb4vVJ+OT?=
 =?us-ascii?Q?28fAS51Sj8SOMrJElPHXxoloyTbSOwhsr1WjysXnF9kRwzUerirkRWX0iut1?=
 =?us-ascii?Q?e+Ng7+zFishZm74O1mcOAL2fvXY8O820cbI1Mj/nRo45rXyQxD91wBCo6Smd?=
 =?us-ascii?Q?8iVrls7zAWi5tT+g+qVaA31DrseC/njPaslkNcS61KLMTgMkh3Riwuk223Ph?=
 =?us-ascii?Q?UNurLjBi4Wu+0cYtc8CNZMJDlcE2ABF0/qFrfrN2W14pznvUBsl5eu4UDi/b?=
 =?us-ascii?Q?XLfzI+sjN1mowjqCd2Le0fs/AXWLs7mRlqKGh0UuJZ/vTX8BQgTT8LcX4+2E?=
 =?us-ascii?Q?pNnaXKuXSxflnFoMiqYb5w+/BGjfaNILPuH+wUrwuxY0e1BXwA2JlGY96JdW?=
 =?us-ascii?Q?Whm529MaE/llEqMCbsG0tiRq6Z0PIfot/tD2Fp895peqXmakiwot3HdWou+O?=
 =?us-ascii?Q?nLwlg/9EVrmMsCLZljhdypKippMMtPUV2JVWLcedGLoYE1DJpDco5PqFVD0l?=
 =?us-ascii?Q?JZN+E8g2huG7Sa2ZQXHydnxp9Z7RkLZ1Avxgg8BPgkAlZC3okpHOTSGITtmo?=
 =?us-ascii?Q?5ijesnNexsHIINMoZUZphJKYRqhyg8zWIk/tS7vgfOhIn8ijXgTfuXaqj0/c?=
 =?us-ascii?Q?N8feMwtCn4O3z56z7ZOkeA6l0deqsgroO2DdYmBdjHluaKu2Tw8RoAWfFRnT?=
 =?us-ascii?Q?eUwRxtmCvAESmesCawpnB5TzR+vB1D5nvmrcrtDX3KhK/PdJH677XOYMwd7b?=
 =?us-ascii?Q?Vt9VClfrllZuxIoa3dsfsUI4IL5V51luxoNCFQXMP67svycq/36lSitRH68X?=
 =?us-ascii?Q?xTAmFQhbJa+4zw0k0i7dxW/4gadVghpXMtbJ24/OcZS8Xw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0204.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9043bab9-09be-4e80-6649-08d8e48802d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 12:20:08.4914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcCr4Oee96/AnkcbgU+YQ/PB+8J39kZThWox5bYjXzACzU4tfp3Bohkv8JoHDCyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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
Content-Type: multipart/mixed; boundary="===============0010920588=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0010920588==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB0204B2725774B55A2DA57706BB909DM5PR1201MB0204_"

--_000_DM5PR1201MB0204B2725774B55A2DA57706BB909DM5PR1201MB0204_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

hi?Christian?

Good idea?thank you for these efforts.
I will update in next version.

Jack

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, March 11, 2021 6:41:05 PM
To: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org=
 <amd-gfx@lists.freedesktop.org>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd=
.com>; Liu, Monk <Monk.Liu@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH v7] drm/amd/amdgpu implement tdr advanced mode



Am 11.03.21 um 06:58 schrieb Jack Zhang:
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
> 2. For whole gpu reset(vram lost), do resubmit as the old way.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  63 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
>   drivers/gpu/drm/scheduler/sched_main.c     | 107 +++++++++++++++------
>   include/drm/gpu_scheduler.h                |   3 +
>   4 files changed, 142 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e247c3a2ec08..5b182ade26ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4639,6 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>        int i, r =3D 0;
>        bool need_emergency_restart =3D false;
>        bool audio_suspended =3D false;
> +     int tmp_vram_lost_counter;
>
>        /*
>         * Special case: RAS triggered and full reset isn't supported
> @@ -4788,6 +4789,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>                }
>        }
>
> +     tmp_vram_lost_counter =3D atomic_read(&((adev)->vram_lost_counter))=
;
>        /* Actual ASIC resets if needed.*/
>        /* TODO Implement XGMI hive reset logic for SRIOV */
>        if (amdgpu_sriov_vf(adev)) {
> @@ -4805,6 +4807,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_device=
 *adev,
>        /* Post ASIC reset for all devs .*/
>        list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>
> +             if (amdgpu_gpu_recovery =3D=3D 2 &&
> +                     !(tmp_vram_lost_counter < atomic_read(&adev->vram_l=
ost_counter))) {
> +
> +                     for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {

Starting from here I would put this into a separate helper function in
amdgpu_ring.c.

You should also probably use checkpatch.pl once more since a couple of
lines below might result in warnings.

Christian.

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
> +                                     drm_sched_resubmit_jobs_ext(&ring->=
sched, 1);
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
> index d82a7ebf6099..bb0a129d1f40 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -361,40 +361,16 @@ static void drm_sched_job_timedout(struct work_stru=
ct *work)
>     */
>   void drm_sched_increase_karma(struct drm_sched_job *bad)
>   {
> -     int i;
> -     struct drm_sched_entity *tmp;
> -     struct drm_sched_entity *entity;
> -     struct drm_gpu_scheduler *sched =3D bad->sched;
> -
> -     /* don't increase @bad's karma if it's from KERNEL RQ,
> -      * because sometimes GPU hang would cause kernel jobs (like VM upda=
ting jobs)
> -      * corrupt but keep in mind that kernel jobs always considered good=
.
> -      */
> -     if (bad->s_priority !=3D DRM_SCHED_PRIORITY_KERNEL) {
> -             atomic_inc(&bad->karma);
> -             for (i =3D DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_K=
ERNEL;
> -                  i++) {
> -                     struct drm_sched_rq *rq =3D &sched->sched_rq[i];
> -
> -                     spin_lock(&rq->lock);
> -                     list_for_each_entry_safe(entity, tmp, &rq->entities=
, list) {
> -                             if (bad->s_fence->scheduled.context =3D=3D
> -                                 entity->fence_context) {
> -                                     if (atomic_read(&bad->karma) >
> -                                         bad->sched->hang_limit)
> -                                             if (entity->guilty)
> -                                                     atomic_set(entity->=
guilty, 1);
> -                                     break;
> -                             }
> -                     }
> -                     spin_unlock(&rq->lock);
> -                     if (&entity->list !=3D &rq->entities)
> -                             break;
> -             }
> -     }
> +     drm_sched_increase_karma_ext(bad, 1);
>   }
>   EXPORT_SYMBOL(drm_sched_increase_karma);
>
> +void drm_sched_reset_karma(struct drm_sched_job *bad)
> +{
> +     drm_sched_increase_karma_ext(bad, 0);
> +}
> +EXPORT_SYMBOL(drm_sched_reset_karma);
> +
>   /**
>    * drm_sched_stop - stop the scheduler
>    *
> @@ -533,15 +509,32 @@ EXPORT_SYMBOL(drm_sched_start);
>    *
>    */
>   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
> +{
> +     drm_sched_resubmit_jobs_ext(sched, INT_MAX);
> +}
> +EXPORT_SYMBOL(drm_sched_resubmit_jobs);
> +
> +/**
> + * drm_sched_resubmit_jobs_ext - helper to relunch certain number of job=
s from mirror ring list
> + *
> + * @sched: scheduler instance
> + * @max: job numbers to relaunch
> + *
> + */
> +void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int ma=
x)
>   {
>        struct drm_sched_job *s_job, *tmp;
>        uint64_t guilty_context;
>        bool found_guilty =3D false;
>        struct dma_fence *fence;
> +     int i =3D 0;
>
>        list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
>                struct drm_sched_fence *s_fence =3D s_job->s_fence;
>
> +             if (i >=3D max)
> +                     break;
> +
>                if (!found_guilty && atomic_read(&s_job->karma) > sched->h=
ang_limit) {
>                        found_guilty =3D true;
>                        guilty_context =3D s_job->s_fence->scheduled.conte=
xt;
> @@ -552,6 +545,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler=
 *sched)
>
>                dma_fence_put(s_job->s_fence->parent);
>                fence =3D sched->ops->run_job(s_job);
> +             i++;
>
>                if (IS_ERR_OR_NULL(fence)) {
>                        if (IS_ERR(fence))
> @@ -563,7 +557,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler=
 *sched)
>                }
>        }
>   }
> -EXPORT_SYMBOL(drm_sched_resubmit_jobs);
> +EXPORT_SYMBOL(drm_sched_resubmit_jobs_ext);
>
>   /**
>    * drm_sched_job_init - init a scheduler job
> @@ -903,3 +897,52 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
>        sched->ready =3D false;
>   }
>   EXPORT_SYMBOL(drm_sched_fini);
> +
> +/**
> + * drm_sched_increase_karma_ext - Update sched_entity guilty flag
> + *
> + * @bad: The job guilty of time out
> + * @type: type for increase/reset karma
> + *
> + */
> +void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type)
> +{
> +     int i;
> +     struct drm_sched_entity *tmp;
> +     struct drm_sched_entity *entity;
> +     struct drm_gpu_scheduler *sched =3D bad->sched;
> +
> +     /* don't change @bad's karma if it's from KERNEL RQ,
> +      * because sometimes GPU hang would cause kernel jobs (like VM upda=
ting jobs)
> +      * corrupt but keep in mind that kernel jobs always considered good=
.
> +      */
> +     if (bad->s_priority !=3D DRM_SCHED_PRIORITY_KERNEL) {
> +             if (type =3D=3D 0)
> +                     atomic_set(&bad->karma, 0);
> +             else if (type =3D=3D 1)
> +                     atomic_inc(&bad->karma);
> +
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
> +                                     if (entity->guilty) {
> +                                             if (type =3D=3D 0)
> +                                                     atomic_set(entity->=
guilty, 0);
> +                                             else if (type =3D=3D 1)
> +                                                     atomic_set(entity->=
guilty, 1);
> +                                             }
> +                                     break;
> +                             }
> +                     }
> +                     spin_unlock(&rq->lock);
> +                     if (&entity->list !=3D &rq->entities)
> +                             break;
> +             }
> +     }
> +}
> +EXPORT_SYMBOL(drm_sched_increase_karma_ext);
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 1c815e0a14ed..4ea8606d91fe 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -321,7 +321,10 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sche=
d);
>   void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_j=
ob *bad);
>   void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recover=
y);
>   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
> +void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int ma=
x);
>   void drm_sched_increase_karma(struct drm_sched_job *bad);
> +void drm_sched_reset_karma(struct drm_sched_job *bad);
> +void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type);
>   bool drm_sched_dependency_optimized(struct dma_fence* fence,
>                                    struct drm_sched_entity *entity);
>   void drm_sched_fault(struct drm_gpu_scheduler *sched);


--_000_DM5PR1201MB0204B2725774B55A2DA57706BB909DM5PR1201MB0204_
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
hi&#65292;Christian&#65292;<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Good idea&#65292;thank you for these efforts.<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
I will update in next version. <br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
Jack<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 11, 2021 6:41:05 PM<br>
<b>To:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;; amd-gfx@lists.fr=
eedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Grodzovsky, Andrey &lt=
;Andrey.Grodzovsky@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Deng, E=
mily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v7] drm/amd/amdgpu implement tdr advanced mode</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
Am 11.03.21 um 06:58 schrieb Jack Zhang:<br>
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
&gt; 2. For whole gpu reset(vram lost), do resubmit as the old way.<br>
&gt;<br>
&gt; Signed-off-by: Jack Zhang &lt;Jack.Zhang1@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 63 ++++=
++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp; 2 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c&nbsp;&nbsp;&nbsp;&n=
bsp; | 107 +++++++++++++++------<br>
&gt;&nbsp;&nbsp; include/drm/gpu_scheduler.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3=
 +<br>
&gt;&nbsp;&nbsp; 4 files changed, 142 insertions(+), 33 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index e247c3a2ec08..5b182ade26ad 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -4639,6 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restart =
=3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended =3D fal=
se;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int tmp_vram_lost_counter;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Special case: RAS tr=
iggered and full reset isn't supported<br>
&gt; @@ -4788,6 +4789,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
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
&gt; @@ -4805,6 +4807,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_dev=
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
<br>
Starting from here I would put this into a separate helper function in <br>
amdgpu_ring.c.<br>
<br>
You should also probably use checkpatch.pl once more since a couple of <br>
lines below might result in warnings.<br>
<br>
Christian.<br>
<br>
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
m_sched_resubmit_jobs_ext(&amp;ring-&gt;sched, 1);<br>
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
&gt; index d82a7ebf6099..bb0a129d1f40 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; @@ -361,40 +361,16 @@ static void drm_sched_job_timedout(struct work_s=
truct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; void drm_sched_increase_karma(struct drm_sched_job *bad)<b=
r>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *tmp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched =3D bad-&gt;=
sched;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* don't increase @bad's karma if it's from =
KERNEL RQ,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because sometimes GPU hang would cau=
se kernel jobs (like VM updating jobs)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * corrupt but keep in mind that kernel=
 jobs always considered good.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_priority !=3D DRM_SCHED_PRIORI=
TY_KERNEL) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; atomic_inc(&amp;bad-&gt;karma);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D DRM_SCHED_PRIORITY_MIN; i &lt; DRM_SCHED_PRIORITY_KERNEL;<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq=
 =3D &amp;sched-&gt;sched_rq[i];<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;rq-&gt;l=
ock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_saf=
e(entity, tmp, &amp;rq-&gt;entities, list) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_fence-&gt;scheduled.context =3D=3D<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;fence_context) =
{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (atomic_read(&amp;bad-&gt;karma) &gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bad-&gt;sched-&gt;hang_limit)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (entity-&gt;guilty)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; atomic_set(entity-&gt;guilty, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;rq-&gt=
;lock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (&amp;entity-&gt;lis=
t !=3D &amp;rq-&gt;entities)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_increase_karma_ext(bad, 1);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_increase_karma);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +void drm_sched_reset_karma(struct drm_sched_job *bad)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_increase_karma_ext(bad, 0);<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sched_reset_karma);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * drm_sched_stop - stop the scheduler<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; @@ -533,15 +509,32 @@ EXPORT_SYMBOL(drm_sched_start);<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sch=
ed)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_resubmit_jobs_ext(sched, INT_MAX);=
<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * drm_sched_resubmit_jobs_ext - helper to relunch certain number of =
jobs from mirror ring list<br>
&gt; + *<br>
&gt; + * @sched: scheduler instance<br>
&gt; + * @max: job numbers to relaunch<br>
&gt; + *<br>
&gt; + */<br>
&gt; +void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int=
 max)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *s_job,=
 *tmp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t guilty_context;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool found_guilty =3D false;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(s_j=
ob, tmp, &amp;sched-&gt;pending_list, list) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct drm_sched_fence *s_fence =3D s_job-&gt;s_fence;<=
br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (i &gt;=3D max)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!found_guilty &amp;&amp; atomic_read(&amp;s_job-&gt=
;karma) &gt; sched-&gt;hang_limit) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found_g=
uilty =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; guilty_=
context =3D s_job-&gt;s_fence-&gt;scheduled.context;<br>
&gt; @@ -552,6 +545,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_schedu=
ler *sched)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dma_fence_put(s_job-&gt;s_fence-&gt;parent);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; fence =3D sched-&gt;ops-&gt;run_job(s_job);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; i++;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (IS_ERR_OR_NULL(fence)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_=
ERR(fence))<br>
&gt; @@ -563,7 +557,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_schedu=
ler *sched)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt; -EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
&gt; +EXPORT_SYMBOL(drm_sched_resubmit_jobs_ext);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * drm_sched_job_init - init a scheduler job<br>
&gt; @@ -903,3 +897,52 @@ void drm_sched_fini(struct drm_gpu_scheduler *sch=
ed)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched-&gt;ready =3D false;<b=
r>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_fini);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * drm_sched_increase_karma_ext - Update sched_entity guilty flag<br>
&gt; + *<br>
&gt; + * @bad: The job guilty of time out<br>
&gt; + * @type: type for increase/reset karma<br>
&gt; + *<br>
&gt; + */<br>
&gt; +void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type=
)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *tmp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched =3D bad-&gt;=
sched;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* don't change @bad's karma if it's from KE=
RNEL RQ,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because sometimes GPU hang would cau=
se kernel jobs (like VM updating jobs)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * corrupt but keep in mind that kernel=
 jobs always considered good.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_priority !=3D DRM_SCHED_PRIORI=
TY_KERNEL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (type =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;bad-&gt=
;karma, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else if (type =3D=3D 1)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;bad-&gt=
;karma);<br>
&gt; +<br>
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (entity-&gt;guilty) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; atomic_set(entity-&gt;guilty, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (type =3D=3D 1)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; atomic_set(entity-&gt;guilty, 1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
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
&gt; +EXPORT_SYMBOL(drm_sched_increase_karma_ext);<br>
&gt; diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h=
<br>
&gt; index 1c815e0a14ed..4ea8606d91fe 100644<br>
&gt; --- a/include/drm/gpu_scheduler.h<br>
&gt; +++ b/include/drm/gpu_scheduler.h<br>
&gt; @@ -321,7 +321,10 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *s=
ched);<br>
&gt;&nbsp;&nbsp; void drm_sched_stop(struct drm_gpu_scheduler *sched, struc=
t drm_sched_job *bad);<br>
&gt;&nbsp;&nbsp; void drm_sched_start(struct drm_gpu_scheduler *sched, bool=
 full_recovery);<br>
&gt;&nbsp;&nbsp; void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sch=
ed);<br>
&gt; +void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int=
 max);<br>
&gt;&nbsp;&nbsp; void drm_sched_increase_karma(struct drm_sched_job *bad);<=
br>
&gt; +void drm_sched_reset_karma(struct drm_sched_job *bad);<br>
&gt; +void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type=
);<br>
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

--_000_DM5PR1201MB0204B2725774B55A2DA57706BB909DM5PR1201MB0204_--

--===============0010920588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0010920588==--
