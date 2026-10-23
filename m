Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B6606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dcHEqLtJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3AB112C86;
	Fri, 23 Oct 2026 17:13:19 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1DD112AD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 13:16:38 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-7cc30120465so21427137.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 06:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792761397; cv=none;
 d=google.com; s=arc-20260327;
 b=jjWlbdsPDcZUmq4NiDMLXEzn6pQPZzer/9Civ3jBZ085fhoJTvxJ/vb+3h0oDVBYc3
 JtPn63I2iK7FnVeVN+ure70nGZQLMpFnA9HW02GLRdTOJOdMgF/pT8mdLTvVnkkhLyoZ
 xusPF+MxmXpAUx5xYBRtiI8DMXh2m8K7lnCSnJFdxiLq29kIzQNFBFJkCCpQSZ4r4c7e
 pWbrYkay0IaXyuinWorBZuhjDctT6gtpVSUMhSfObezg7IQ/1U9A3JxIoxG/C3N7IJqP
 zEJe9sAuhDxjUx7jtPB/0K9pG4z469ThZrhriLY+iN4fHHVjAA5ct6+m/LV9ZZ4Y3z/J
 glJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SvPWt5kc8oTXYnV3exS7/M+VlApnQZ0+MJIbsgNitck=;
 fh=NwdhToZDq5Q0SszqYOjPeakwp0DfjqOm5RzRMBNrLA4=;
 b=epK0UU0AQAJr9iglHMZzmSPidd2WPnFZQhsQ/IyeDQY/9UTZFDF1tFURaqKkr/QVb9
 OSHynqxlOcaju+QivrDY5XyaVDMQOn3uBaAIhM35AjEw2OOQsDu9hjjUEY7qEMwN04fD
 jOpFtPsb4Cqueuxo26w8ysRI9rFez6PYjdiIodeJAEu2ZNTcHzaBjvJBmhwdMfa8PCwR
 NzV5LV8u6DaTRvRh9dJdNwVluNKLhQSt/TryjTrMG/xESfa48T7l+1h5hC1VdBBR4Ft3
 0MProUPWqCCVLVZpN1aUlaFqmsIu0/jHAnSb5zbHEj7InPfe3nEa0Mlnhk4YHGrP5Mac
 BE+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792761397; x=1793366197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SvPWt5kc8oTXYnV3exS7/M+VlApnQZ0+MJIbsgNitck=;
 b=dcHEqLtJq1LtXlRZ8BM47LaqjHUOKM01SZweWvcYYEVor7c02v1goDTrWcI89QFLxV
 sOyigJBZTYnh7QzTT7JLHPHgK2nJ7Blt2SnM3ZTur3UeG4jDvgsb+pyyyiL8hbqV6sQw
 CtFRYjf481GPWXgGc/fd/RHQTqLeUCjdx6i1IWK6E2wwKJCq1Lm5bWj71BwBu5VvAs8u
 YqIttIVa+vEajmTtuJxHv+o0UEr2TVQbzvFEB5FAibh45+tC+ECGke1hGSxvlbauxAjZ
 HQC+JoOzuVU1PQ/GQXQMzNb07Iz+CfVeAAcy5jAq0qLUlAFsIO2DtQhFmCx6Nio4cjhz
 cyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792761397; x=1793366197;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SvPWt5kc8oTXYnV3exS7/M+VlApnQZ0+MJIbsgNitck=;
 b=rtCsjeoaRgUAdZ9MAi2Nds2aDPdnSHyv3lDYtKyW7PtWfiOmPnhfsu4s7AqnUboBAT
 GItGVqqOUgsbqln/6eyzQ+zQi4ZxZkbMxZoBG7fg3hW3Z2WrQHdYWiSLzdeI+ag3AeUv
 nilB39t+AFGYFz6IuVdIJ5/Xv0sLLAnc0JX64UhFLYhICEQMifOoPmT8SkHakNN3gKFt
 H8k4IVPY3DDT89I5rpc8GBmNPqtl3oYBlNBU9o2s8hHDMGlMhwRKXIrj0lPXPWiIsbKI
 Buy4K62+FLUAuvCizmGHfdQDxTu++bt3bbhgLA3YfKHeXvxsdoebGaNr+edM++L+m0Wo
 bviQ==
X-Gm-Message-State: AFq9FYJwqTurKgInkGlFmR3fGKB7uUFHshSSizvzGJFPnBo67pRiGuZv
 Xs4VnVszCEc+YO23wGuDezuRk80fvoE2v0ibF/91/QIdW3Ws9oMpReMYlOaxj63655YRmNcRW+C
 k6ONAiygzqfnCyuaVf6/PlqVMwWw9nAQ=
X-Gm-Gg: AYBFou1TjYp5PRBg/ijIYLRdlbq0s0FAynSG+BASi7l6c+saWJnEjd0a0QSgIe0t4N7
 clHdfU7fiX0ckZ/PBByKxS+Hs5zVTsyUvXo8J45hPeHcuYayqMsZ39Ffa5IUGwlyn9xXX6htpXo
 mGKVH9X9JSGOUBMRpL3wuPmR92bW1j9HDYpynLrzU0BJXqOYBujBOLgwO/Ova8x3AzybP8PULn7
 nk5Obtnv1sb7qBRTDRf8oIfJNnAdcagefL+BIp/xQK8FGoMvheVbPKL/5x4tYE8KhmLP98p89qu
 n+xehk/h34hUrYJEvv78gH1Tn/NpzayeUoQwOpsHVo2r2f43AJi5F0W5uGuEsijJXH4yl8Yy/di
 DAgQLGR8WqMn4Vm9KpVzrHDsYREzCnYRxJVKDIxfCt8sTfMFaekz2WOuIjqUTIQwe3ZtKHHi92L
 eyTFPOm2PU5gHjafCLGCgemOc=
X-Received: by 2002:a05:6102:a187:10b0:7ae:545d:f97c with SMTP id
 ada2fe7eead31-7ccc3338886mr785917137.3.1792761397291; Fri, 23 Oct 2026
 06:16:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022014728.84081-1-amber.lin@amd.com>
 <20261022014728.84081-4-amber.lin@amd.com>
 <CADnq5_OhOCymFFs8oiZPGTjq8dJFx16PCA2aZ=yUnAnshS9aGw@mail.gmail.com>
 <CH3PR12MB50440642D2F50DC54E37A1EB54E1642@CH3PR12MB504406.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB50440642D2F50DC54E37A1EB54E1642@CH3PR12MB504406.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Oct 2026 09:16:24 -0400
X-Gm-Features: AclHuK8m0q8CNi10m_tAJy5fpCLCk8U9g4gfYUicRYhaDtYtkJDF2WBh76rYqEw
Message-ID: <CADnq5_Mp30K1eU+oOifCubMLb=phKbZU21WxXSs5YreSdS-1jQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Correct hung queue number for reset
To: "Lin, Amber" <Amber.Lin@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 10:20=E2=80=AFPM Lin, Amber <Amber.Lin@amd.com> wro=
te:
>
> AMD General
>
> Regards,
> Amber
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, October 22, 2026 11:40 PM
> To: Lin, Amber <Amber.Lin@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Liu, Shaoyun <Shaoyun.Liu@amd.com>; De=
ucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 3/3] drm/amdgpu: Correct hung queue number for reset
>
> On Wed, Oct 21, 2026 at 9:56=E2=80=AFPM Amber Lin <amber.lin@amd.com> wro=
te:
> >>
> >> In an ASIC supporting multi-compute partition, the number of queues
> >> varies with the compute partition mode. We need to adjust the hqd_info
> >> offset to get the correct hung queues doorbell offset and hqd_info.
> >>
> >> Signed-off-by: Amber Lin <amber.lin@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 54
> >> +++++++++++++++++--------
> >>  1 file changed, 37 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >> index 58766b27e150..5bcab09b15c6 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >> @@ -108,6 +108,24 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32
> >> num_pipe,
> >>
> >>  static void amdgpu_mes_userq_notify_unmap_work_handler(struct
> >> work_struct *work);
> >>
> >> +static int get_num_queues_per_xcp(struct amdgpu_device *adev, int
> >> +num_xcps) {
> >> +       int i, num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_=
mask) : 1;
> >> +       u32 num_queues =3D 0;
> >> +
> >> +       for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> >> +               num_queues +=3D hweight32(adev->mes.gfx_hqd_mask[i]);
> >> +
> >> +       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
> >> +               num_queues +=3D
> >> + hweight32(adev->mes.compute_hqd_mask[i]);
> >> +
> >> +       num_xcc /=3D num_xcps;
> >> +       for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> >> +               num_queues +=3D hweight32(adev->mes.sdma_hqd_mask[i]) =
*
> >> + num_xcc;
> >> +
> >> +       return num_queues;
> >> +}
> >> +
> >>  int amdgpu_mes_init(struct amdgpu_device *adev)  {
> >>         int i, r, num_pipes, num_queues =3D 0; @@ -222,21 +240,18 @@ i=
nt
> >> amdgpu_mes_init(struct amdgpu_device *adev)
> >>                 goto error_doorbell;
> >>
> >>         if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, 0,=
 0)) {
> >> -               /* When queue/pipe reset is done in MES instead of in =
the
> >> -                * driver, MES passes hung queues information to the d=
river in
> >> -                * hung_queue_hqd_info. Calculate required space to st=
ore this
> >> -                * information.
> >> +               /* When queue/pipe reset is handled by MES instead of =
by the
> >> +                * driver, driver provides the buffer for MES to store=
 the hung
> >> +                * queues information. Calculate required buffer size,=
 which is
> >> +                * the number of maximum queues. This number varies wi=
th compute
> >> +                * partition mode. We allocate the biggest size, which=
 is SPX,
> >> +                * num_xcps =3D 1.
> >>                  */
> >> -               for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> >> -                       num_queues +=3D hweight32(adev->mes.gfx_hqd_ma=
sk[i]);
> >> -
> >> -               for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
> >> -                       num_queues +=3D hweight32(adev->mes.compute_hq=
d_mask[i]);
> >> -
> >> -               for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> >> -                       num_queues +=3D hweight32(adev->mes.sdma_hqd_m=
ask[i]) * num_xcc;
> >> -
> >> +               num_queues =3D get_num_queues_per_xcp(adev, 1);
> >>                 adev->mes.hung_queue_hqd_info_offset =3D num_queues;
> >> +               /* Double num_queues. The first half is to store doorb=
ell offset
> >> +                * and the second half is to store hqd_info.
> >> +                */
> >>                 adev->mes.hung_queue_db_array_size =3D num_queues * 2;
> >>         }
> >>
> >> @@ -526,8 +541,9 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct=
 amdgpu_device *adev,
> >>                                             uint32_t xcc_id)  {
> >>         struct mes_detect_and_reset_queue_input input;
> >> -       u32 *db_array =3D adev->mes.hung_queue_db_array_cpu_addr[xcc_i=
d];
> >> -       int hqd_info_offset =3D adev->mes.hung_queue_hqd_info_offset, =
r, i;
> >> +       u32 *db_array =3D adev->mes.hung_queue_db_array_cpu_addr[0];
> >
> > Does mes.hung_queue_db_array_cpu_addr still need to be an array?
>
> No, it doesn't need to be an array. Since we guard the access in amdgpu_g=
fx_mes_reset_compute function and only one XCC can perform detect_and_reset=
 at one time, one hung_queue_db_array is enough. My original series include=
d reverting the patch that added xcc copies of hung_queue_db_array. I was t=
hinking to submit that revert in the next series (clean up), but I can do i=
t in this series too.

Sure.  Either way.  Might be better to do it now so it doesn't slip
through the cracks.  Just wanted to make sure I wasn't
mis-understanding the change.

> Since we are in this topic, I have a question here. Besides of the xcc co=
pies, amdgpu_mes_init also allocates AMDGPU_MAX_MES_PIPES copies of hung_qu=
eue_db_array buffer. Is it required for gfx 10? In gfx11 and after, we only=
 use MES pipe 0 for detect_and_reset so we shouldn't need AMDGPU_MAX_MES_PI=
PES copies.

gfx10 doesn't use MES so it shouldn't be an issue.

Alex

>
> >> +       int hqd_info_offset, r, i;
> >> +       int num_xcps =3D 1;
> >>
> >>         if (!hung_db_num || !hung_db_array)
> >>                 return -EINVAL;
> >> @@ -537,8 +553,12 @@ int amdgpu_mes_detect_and_reset_hung_queues(struc=
t amdgpu_device *adev,
> >>             (queue_type !=3D AMDGPU_RING_TYPE_SDMA))
> >>                 return -EINVAL;
> >>
> >> +       if (adev->xcp_mgr)
> >> +               num_xcps =3D adev->xcp_mgr->num_xcps;
> >> +       hqd_info_offset =3D get_num_queues_per_xcp(adev, num_xcps);
> >> +
> >>         /* Clear the doorbell array before detection */
> >> -       memset(adev->mes.hung_queue_db_array_cpu_addr[xcc_id], AMDGPU_=
MES_INVALID_DB_OFFSET,
> >> +       memset(adev->mes.hung_queue_db_array_cpu_addr[0],
> >> + AMDGPU_MES_INVALID_DB_OFFSET,
> >>                 adev->mes.hung_queue_db_array_size * sizeof(u32));
> >>         input.queue_type =3D queue_type;
> >>         input.detect_only =3D detect_only; @@ -554,7 +574,7 @@ int
> >> amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
> >>
> >>         *hung_db_num =3D 0;
> >>         /* MES passes hung queues' doorbell to driver */
> >> -       for (i =3D 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
>
> Can mes.hung_queue_hqd_info_offset be removed after this change?
>
> Alex
>
> > +       for (i =3D 0; i < hqd_info_offset; i++) {
> >                 /* Finding hung queues where db_array[i] is a valid doo=
rbell */
> >                 if (db_array[i] !=3D AMDGPU_MES_INVALID_DB_OFFSET) {
> >                         dev_dbg(adev->dev, "MES: hung queue doorbell
> > 0x%x\n", db_array[i]);
> > --
> > 2.43.0
> >
