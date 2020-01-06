Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE52C33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 23:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1324420731
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 23:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br/TjG7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1324420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9228C6E595;
	Mon,  6 Jan 2020 23:08:34 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C44989BC2
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 23:08:33 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id t2so51797259wrr.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 15:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DWUIAD5kem/rNzWqP7L3T5KhUDVw1Bf02CB6f+iy/Cc=;
 b=Br/TjG7fPY42WNPzq81w/NYystW1kFp/H2rpSf7Neddn2U2q1BvvydJacvf/7mrbau
 54tn4WyRgkkhvfJlxNeIdD43awv/OzY+qEdF1teF9BrSwnhvYT+WUGDDJWJ/hq+mWOCM
 vAy2Q7RGvMcZl7S61nD8w6FVeVZTfLAttaS89iD/c19xn9MAH/IEBzWUZpTPHOasTTqg
 WbCIq4I02XCOfQYdPZdJz6vIW4MXVaC2ZQTa3I6jTM5KeQRWPL9DoomkKHgwNT9Na3Hp
 Y3sUP+G3xHMycPmn90WBPNxkynwONyHia4Vx/DAeZSh37IDj5zzdZJnfS7AxNTp74Sm8
 b8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DWUIAD5kem/rNzWqP7L3T5KhUDVw1Bf02CB6f+iy/Cc=;
 b=KyjJMQa5Zu1+U71WAwuQnBrCmnBhLEbJzFR+cZcj4stLJvMc6tojHDhAEFPi4qZUMr
 IsuhvPdEvMpZyso0gH5Rur/cJp4gn5emrS3/meuYxyhAF4sUCApNC5+oVY7lmrj1vBrs
 KoLUi8scfPeqTOTv5sPsca0y/ggIdO9sLCDxf+XOrfz2VDXHXZirRbNX/cQ11AINU3Bj
 FBOmAEcpo7MEK8sr+StMXqaEkfwe2lbM1l/jVCqLoXsi9No5TvMFT9TGwuJdsXaj4Li/
 bL/7zaINGTa/WwLQxWvnmYQ4bHtN4p3/WMAKpdPw4L4BZoN6g9cjeP5hSA/U8wDkknO/
 lcSA==
X-Gm-Message-State: APjAAAVgdahzjQCBln+mgfsssw9xQoCKZol97Vnm6W127GCM9ChynE4a
 EtblAgKiL4FjIkViuUb/ImcQcEGHJ/6hgmumlYY=
X-Google-Smtp-Source: APXvYqyW+Qq7G8fqw5cY8JB43RgMfMtCAz+0qJhA99xlgvzXuazfnVL6tMkbUqlNY4NSD4yMeOqvyLjSmJdsbl2l288=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr92478845wru.154.1578352112038; 
 Mon, 06 Jan 2020 15:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20200103094726.32428-1-evan.quan@amd.com>
 <MN2PR12MB3344F5C72C95B6F0BD2BA887E43C0@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3344F5C72C95B6F0BD2BA887E43C0@MN2PR12MB3344.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jan 2020 18:08:20 -0500
Message-ID: <CADnq5_N+XS7Qywm664a3M=5M5x+v-poJv5RwB=5zF6SKVFJ_qw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: issue proper hdp flush for table
 transferring
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 6, 2020 at 1:34 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Ping..
>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> > -----Original Message-----
> > From: Quan, Evan <Evan.Quan@amd.com>
> > Sent: Friday, January 3, 2020 5:47 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Quan, Evan <Evan.Quan@amd.com>
> > Subject: [PATCH] drm/amd/powerplay: issue proper hdp flush for table
> > transferring
> >
> > Guard the content consistence between the view of GPU and CPU during the
> > table transferring.
> >
> > Change-Id: Ib3cebb97a1c8fb302eb040483bbaf089ae00c6a9
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c        | 15 ++++++++++-----
> >  .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c   |  5 ++++-
> >  .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c  |  5 ++++-
> >   .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c  |  5 ++++-
> >   .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c  | 10 ++++++++--
> >  5 files changed, 30 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > index a56ebcc4e3c7..e1b64134bbd8 100644
> > --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > @@ -529,8 +529,14 @@ int smu_update_table(struct smu_context *smu,
> > enum smu_table_id table_index, int
> >
> >       table_size = smu_table->tables[table_index].size;
> >
> > -     if (drv2smu)
> > +     if (drv2smu) {
> >               memcpy(table->cpu_addr, table_data, table_size);
> > +             /*
> > +              * Flush hdp cache: to guard the content seen by
> > +              * GPU is consitent with CPU.
> > +              */
> > +             amdgpu_asic_flush_hdp(adev, NULL);
> > +     }
> >
> >       ret = smu_send_smc_msg_with_param(smu, drv2smu ?
> >                                         SMU_MSG_TransferTableDram2Smu :
> > @@ -539,11 +545,10 @@ int smu_update_table(struct smu_context *smu,
> > enum smu_table_id table_index, int
> >       if (ret)
> >               return ret;
> >
> > -     /* flush hdp cache */
> > -     adev->nbio.funcs->hdp_flush(adev, NULL);
> > -
> > -     if (!drv2smu)
> > +     if (!drv2smu) {
> > +             amdgpu_asic_flush_hdp(adev, NULL);
> >               memcpy(table_data, table->cpu_addr, table_size);
> > +     }
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> > b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> > index aa0ee2b46135..2319400a3fcb 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> > @@ -137,7 +137,7 @@ static int smu10_copy_table_from_smc(struct
> > pp_hwmgr *hwmgr,
> >                       priv->smu_tables.entry[table_id].table_id);
> >
> >       /* flush hdp cache */
> > -     adev->nbio.funcs->hdp_flush(adev, NULL);
> > +     amdgpu_asic_flush_hdp(adev, NULL);
> >
> >       memcpy(table, (uint8_t *)priv->smu_tables.entry[table_id].table,
> >                       priv->smu_tables.entry[table_id].size);
> > @@ -150,6 +150,7 @@ static int smu10_copy_table_to_smc(struct pp_hwmgr
> > *hwmgr,  {
> >       struct smu10_smumgr *priv =
> >                       (struct smu10_smumgr *)(hwmgr->smu_backend);
> > +     struct amdgpu_device *adev = hwmgr->adev;
> >
> >       PP_ASSERT_WITH_CODE(table_id < MAX_SMU_TABLE,
> >                       "Invalid SMU Table ID!", return -EINVAL;); @@ -161,6
> > +162,8 @@ static int smu10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
> >       memcpy(priv->smu_tables.entry[table_id].table, table,
> >                       priv->smu_tables.entry[table_id].size);
> >
> > +     amdgpu_asic_flush_hdp(adev, NULL);
> > +
> >       smu10_send_msg_to_smc_with_parameter(hwmgr,
> >                       PPSMC_MSG_SetDriverDramAddrHigh,
> >                       upper_32_bits(priv-
> > >smu_tables.entry[table_id].mc_addr));
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> > b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> > index 39427ca32a15..715564009089 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> > @@ -58,7 +58,7 @@ static int vega10_copy_table_from_smc(struct pp_hwmgr
> > *hwmgr,
> >                       priv->smu_tables.entry[table_id].table_id);
> >
> >       /* flush hdp cache */
> > -     adev->nbio.funcs->hdp_flush(adev, NULL);
> > +     amdgpu_asic_flush_hdp(adev, NULL);
> >
> >       memcpy(table, priv->smu_tables.entry[table_id].table,
> >                       priv->smu_tables.entry[table_id].size);
> > @@ -70,6 +70,7 @@ static int vega10_copy_table_to_smc(struct pp_hwmgr
> > *hwmgr,
> >               uint8_t *table, int16_t table_id)
> >  {
> >       struct vega10_smumgr *priv = hwmgr->smu_backend;
> > +     struct amdgpu_device *adev = hwmgr->adev;
> >
> >       /* under sriov, vbios or hypervisor driver
> >        * has already copy table to smc so here only skip it @@ -87,6 +88,8
> > @@ static int vega10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
> >       memcpy(priv->smu_tables.entry[table_id].table, table,
> >                       priv->smu_tables.entry[table_id].size);
> >
> > +     amdgpu_asic_flush_hdp(adev, NULL);
> > +
> >       smu9_send_msg_to_smc_with_parameter(hwmgr,
> >                       PPSMC_MSG_SetDriverDramAddrHigh,
> >                       upper_32_bits(priv-
> > >smu_tables.entry[table_id].mc_addr));
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> > b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> > index 90c782c132d2..a3915bfcce81 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> > @@ -66,7 +66,7 @@ static int vega12_copy_table_from_smc(struct pp_hwmgr
> > *hwmgr,
> >                       return -EINVAL);
> >
> >       /* flush hdp cache */
> > -     adev->nbio.funcs->hdp_flush(adev, NULL);
> > +     amdgpu_asic_flush_hdp(adev, NULL);
> >
> >       memcpy(table, priv->smu_tables.entry[table_id].table,
> >                       priv->smu_tables.entry[table_id].size);
> > @@ -84,6 +84,7 @@ static int vega12_copy_table_to_smc(struct pp_hwmgr
> > *hwmgr,  {
> >       struct vega12_smumgr *priv =
> >                       (struct vega12_smumgr *)(hwmgr->smu_backend);
> > +     struct amdgpu_device *adev = hwmgr->adev;
> >
> >       PP_ASSERT_WITH_CODE(table_id < TABLE_COUNT,
> >                       "Invalid SMU Table ID!", return -EINVAL); @@ -95,6
> > +96,8 @@ static int vega12_copy_table_to_smc(struct pp_hwmgr *hwmgr,
> >       memcpy(priv->smu_tables.entry[table_id].table, table,
> >                       priv->smu_tables.entry[table_id].size);
> >
> > +     amdgpu_asic_flush_hdp(adev, NULL);
> > +
> >
> >       PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(h
> > wmgr,
> >                       PPSMC_MSG_SetDriverDramAddrHigh,
> >                       upper_32_bits(priv-
> > >smu_tables.entry[table_id].mc_addr)) == 0, diff --git
> > a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> > b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> > index f604612f411f..0db57fb83d30 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> > @@ -189,7 +189,7 @@ static int vega20_copy_table_from_smc(struct
> > pp_hwmgr *hwmgr,
> >                       return ret);
> >
> >       /* flush hdp cache */
> > -     adev->nbio.funcs->hdp_flush(adev, NULL);
> > +     amdgpu_asic_flush_hdp(adev, NULL);
> >
> >       memcpy(table, priv->smu_tables.entry[table_id].table,
> >                       priv->smu_tables.entry[table_id].size);
> > @@ -207,6 +207,7 @@ static int vega20_copy_table_to_smc(struct pp_hwmgr
> > *hwmgr,  {
> >       struct vega20_smumgr *priv =
> >                       (struct vega20_smumgr *)(hwmgr->smu_backend);
> > +     struct amdgpu_device *adev = hwmgr->adev;
> >       int ret = 0;
> >
> >       PP_ASSERT_WITH_CODE(table_id < TABLE_COUNT, @@ -219,6 +220,8
> > @@ static int vega20_copy_table_to_smc(struct pp_hwmgr *hwmgr,
> >       memcpy(priv->smu_tables.entry[table_id].table, table,
> >                       priv->smu_tables.entry[table_id].size);
> >
> > +     amdgpu_asic_flush_hdp(adev, NULL);
> > +
> >       PP_ASSERT_WITH_CODE((ret =
> > vega20_send_msg_to_smc_with_parameter(hwmgr,
> >                       PPSMC_MSG_SetDriverDramAddrHigh,
> >                       upper_32_bits(priv-
> > >smu_tables.entry[table_id].mc_addr))) == 0, @@ -242,11 +245,14 @@ int
> > vega20_set_activity_monitor_coeff(struct pp_hwmgr *hwmgr,  {
> >       struct vega20_smumgr *priv =
> >                       (struct vega20_smumgr *)(hwmgr->smu_backend);
> > +     struct amdgpu_device *adev = hwmgr->adev;
> >       int ret = 0;
> >
> >       memcpy(priv-
> > >smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table, table,
> >                       priv-
> > >smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
> >
> > +     amdgpu_asic_flush_hdp(adev, NULL);
> > +
> >       PP_ASSERT_WITH_CODE((ret =
> > vega20_send_msg_to_smc_with_parameter(hwmgr,
> >                       PPSMC_MSG_SetDriverDramAddrHigh,
> >                       upper_32_bits(priv-
> > >smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].mc_addr))) == 0, @@ -
> > 290,7 +296,7 @@ int vega20_get_activity_monitor_coeff(struct pp_hwmgr
> > *hwmgr,
> >                       return ret);
> >
> >       /* flush hdp cache */
> > -     adev->nbio.funcs->hdp_flush(adev, NULL);
> > +     amdgpu_asic_flush_hdp(adev, NULL);
> >
> >       memcpy(table, priv-
> > >smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table,
> >                       priv-
> > >smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
> > --
> > 2.24.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
