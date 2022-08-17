Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B975C25B08
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 13:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 910999382F;
	Wed, 17 Aug 2022 13:44:34 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55DB937E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 13:44:21 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id bb16so15387191oib.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=Jc3M8m5cUpVdf93DtLZOUTxZrMOkYSXxoEa9ydsAtHs=;
 b=MFONbdlM3bsFrumzw1kJbM2EQPQfe6eoO/QHWRmyKtIrKGvbq8JMPinfE71jXIzpSu
 11eFrveYYgeQns7quoPg0wGC8ARRrYusKSnmLt6hXV8+yVEYGXIxDd5w0kPoa+hNUj5O
 Xu1VVUNs3tgTYZplgIfQVV8VacHhLKT06UP1hxQyz3IDv7teJQrOBmbuh+I6ytSCdSHA
 aRzBaG2/oHk9JBaJnaNWZwX5sJ3xgD5RNFhiUVJasDJch3mWpgJ+yB0LFh+HeM7CsPkl
 FiV37SuK9F79mb4jQNVOTtJNwDKOqPVPNlW4/poi11iWur1Rn6Fbw2pJCKrqqmdQyKI2
 jxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=Jc3M8m5cUpVdf93DtLZOUTxZrMOkYSXxoEa9ydsAtHs=;
 b=teI1UNONX6t043MkKM3oJzndmqXm7rd6DKARazdMS2I7dvB5ZJ2zrGMtOfc0XB6crp
 QBKmLobV8dz6bW4AdCmbtNPTG8lA6SmrV0SDHnNz7dgiYw/DT1YjZeVeW84ds5JoQq9W
 ws+NErs6dYcountql9+1HQ5s6H0rtpl4bNV4zx5G71dcAMYOFK2H9zoUm9yjWC+0u4+T
 jkJBZprGKhPY8TJNCb6MOoGmqKzOcuwhrIgvMKR1GqGJ6QRbk3HTGzy/83imuEGaF/ol
 EZMfZ//lxvODFrQ7I9scDfzHupDEXKLS5d8xAW1kiddE5hpoa+lQ82bdCNyoU4HKnc0X
 E4qg==
X-Gm-Message-State: ACgBeo35d5Ag3WFtpwYu15Ae3DpgYpp0lKnG7MdxhdQ8ksWP1m7TlavZ
 Th5rH9ZEZdJxWDZiOYoNSqenKpm9c7bRwZ7FB1FwUMKCEbY=
X-Google-Smtp-Source: AA6agR7ML/ivQXB5c32zfgv08BSE7CQOSuxYp+CJ+FAT/GXk1QSvomrPK6oC7GkUII0dtOJ//thbSfONj9MXhov1pDk=
X-Received: by 2002:a05:6808:ecb:b0:33a:3b54:37f9 with SMTP id
 q11-20020a0568080ecb00b0033a3b5437f9mr1479126oiv.33.1660743861194; Wed, 17
 Aug 2022 06:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220815070512.452430-1-YiPeng.Chai@amd.com>
 <CADnq5_NLzjD+4q0vF8n8JRaOf3iiGYoNN+W9K3FPLEP+_FHjUg@mail.gmail.com>
 <CH2PR12MB42155B12C1A2C1D7101EAA2EFC6A9@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB42155B12C1A2C1D7101EAA2EFC6A9@CH2PR12MB4215.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Aug 2022 09:44:10 -0400
Message-ID: <CADnq5_NyNxCdJOC6d0du=+AAYA13xCFVXZRjsXEJT_rXSQTm-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: TA unload messages are not actually sent to
 psp when amdgpu is uninstalled
To: "Chai, Thomas" <YiPeng.Chai@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 16, 2022 at 10:54 PM Chai, Thomas <YiPeng.Chai@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Alex:
>   When removing an amdgpu device, it may be difficult to change the order=
 of psp_hw_fini calls.
>
> 1. The drm_dev_unplug call is at the beginning in the amdgpu_pci_remove f=
unction,  which makes the gpu device inaccessible for userspace operations.=
  If the call to psp_hw_fini was moved before drm_dev_unplug,  userspace co=
uld access the gpu device but the psp might be removing. It has unknown iss=
ues.
>

+Andrey Grodzovsky

We should fix the ordering in amdgpu_pci_remove() then I guess?  There
are lots of places where drm_dev_enter() is used to protect access to
the hardware which could be similarly affected.

Alex

> 2. psp_hw_fini is called by the .hw_fini iterator in amdgpu_device_ip_fin=
i_early, referring to the code starting from amdgpu_pci_remove to .hw_fini =
is called,
>    there are many preparatory operations before calling .hw_fini,  which =
makes it very difficult to change the order of psp_hw_fini or all block .hw=
_fini.
>
>    So can we do a workaround in psp_cmd_submit_buf when removing amdgpu d=
evice?
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Monday, August 15, 2022 10:22 PM
> To: Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>=
; Chen, Guchun <Guchun.Chen@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: TA unload messages are not actually sent=
 to psp when amdgpu is uninstalled
>
> On Mon, Aug 15, 2022 at 3:06 AM YiPeng Chai <YiPeng.Chai@amd.com> wrote:
> >
> > The psp_cmd_submit_buf function is called by psp_hw_fini to send TA
> > unload messages to psp to terminate ras, asd and tmr.
> > But when amdgpu is uninstalled, drm_dev_unplug is called earlier than
> > psp_hw_fini in amdgpu_pci_remove, the calling order as follows:
> > static void amdgpu_pci_remove(struct pci_dev *pdev) {
> >         drm_dev_unplug
> >         ......
> >         amdgpu_driver_unload_kms->amdgpu_device_fini_hw->...
> >                 ->.hw_fini->psp_hw_fini->...
> >                 ->psp_ta_unload->psp_cmd_submit_buf
> >         ......
> > }
> > The program will return when calling drm_dev_enter in
> > psp_cmd_submit_buf.
> >
> > So the call to drm_dev_enter in psp_cmd_submit_buf should be removed,
> > so that the TA unload messages can be sent to the psp when amdgpu is
> > uninstalled.
> >
> > Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index b067ce45d226..0578d8d094a7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -585,9 +585,6 @@ psp_cmd_submit_buf(struct psp_context *psp,
> >         if (psp->adev->no_hw_access)
> >                 return 0;
> >
> > -       if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
> > -               return 0;
> > -
>
> This check is to prevent the hardware from being accessed if the card is =
removed.  I think we need to fix the ordering elsewhere.
>
> Alex
>
> >         memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
> >
> >         memcpy(psp->cmd_buf_mem, cmd, sizeof(struct
> > psp_gfx_cmd_resp)); @@ -651,7 +648,6 @@ psp_cmd_submit_buf(struct psp_c=
ontext *psp,
> >         }
> >
> >  exit:
> > -       drm_dev_exit(idx);
> >         return ret;
> >  }
> >
> > --
> > 2.25.1
> >
