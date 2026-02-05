Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BD8ECD9A9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 21:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0848210E187;
	Thu,  5 Feb 2026 21:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="etGWXEhQ";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E76D10E16C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 21:50:06 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1233608c7e9so149689c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 13:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770328206; cv=none;
 d=google.com; s=arc-20240605;
 b=EUnNZ4Fu8rCEUPTt5J5O7dAj+DQhAFWsDgEL8jqUha5ZxK5/dlzwLvjObJM87J7xRK
 qvLX+SifixSUazW1jCHgxJ9ZxFLv8vG9iM+OyB1utj7KP5i/E+iFNKu09kpRc14Bq7rw
 0cYbvLP3wDHk42Bc3HLXJgVK/x29+M1fYi5mrZORgOoorazRbmvWzIsJ910St7DD5h5f
 ILhYHUpyDNH3cG4HyZg74gckglHe/R7aF0w2gpK9WUJyScMljw8GQySoH4EdgC3diF9B
 NCzFR50kdkuD0fwllH5oZFCpytSCStAkx6JBhTeUOe1kG4c+ViXVo/ZtVky7+JJBKRcU
 xt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GW7U3rTTIg/YTqii2bN2cGgxryFu9l5Ay+twYrUARM8=;
 fh=s3a+KaV8LOWxb+ETmMHAMcT1g/YDVxlXbdgxFBgi2aY=;
 b=i2MTMEry3nxAGcLyfiNRqroOQ83+g6NyOCkRBfg7nEFRlUsZlGfYbx06y25Uf+ap+Q
 EggMDgDQYCVJF7rZfn8fwf88Bn6UxBW8IeY/ocJJTbieHcYSWDiqHp1eXN1ci/GCAd51
 cdRPoDY9F6UegQ1CY8wtkXcAmG2pZtGF4a8JGUDx5m1ilMlIQTH5hgUF7qrpM4yB/akS
 oc7MSb5fAZ3cE/FPWEW5AY9qy3xujnzpwQ8CYEn3lLhPNpwDv2OrTR4F+4fX4zCERRbe
 lIPbt3sKi1jcDMU2UB8KA6zN48bBP4nmqxzStQOZWWC5ialHhhhIU+d06ApUM7SNnZKV
 osJg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770328206; x=1770933006; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GW7U3rTTIg/YTqii2bN2cGgxryFu9l5Ay+twYrUARM8=;
 b=etGWXEhQUWQkuTnoszSxxY3k9QtbwAyYzIatmxtnNLjN1dqKtUsNXmL12Txg6Zg2G/
 E/0xJQOltOLTEhAGjq51/4WZYj2xloswWcsmk2Qe+FsIflxCC3b4Fyzp291W2zmdXm4R
 KWp2JJSGEfd8aV6BpU0m6+ug5Rl+rKKMwyl++gxeIvIiddztl+YHoMIqzGjdYfhu8nxf
 TMJiXBqxJ7PyxBgsuEzClFkhenenjSq0Bnn4AjgIkk+tksyD6Flk6yttwVpg6/VmLkj9
 CcSxmgqgp3gUZmwQ3lxyZE2mFUIEunQ7Qy8s98sZpoDJiUtSnYXKH2Fo5ECFfipZV5hr
 rXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770328206; x=1770933006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GW7U3rTTIg/YTqii2bN2cGgxryFu9l5Ay+twYrUARM8=;
 b=TKHnsRdSusia7SKS+8go7fd16RW4Ge3NcYc9OODItBbO7rZ0xTr5hR7WlS85xwUAMr
 SXU2bRqWwyIr7xF98Kjw4Vvqdb2pf5UOdUDSmTW6i17o7Qu9gBJeUWFtCn4sgXgda8r3
 pv1xAgGWpSghZFN2oDREy0YH6QgeYkiNd376ewsDklEaFd0RQ4XcxCKuJX5yJ8rooyW5
 391vDwY5WOmxCW3Yf075ovUsQVF/SyX/zZUP8QP+2+JvIaDAVkiuhuoNy/PtjI+p3J1j
 xugK8dm4/UksvOHdr0Gu9Zt2CONUlB/mZNkKA4KvNoGy4fQLJl26iBVC09F2bZbqqiXV
 /B1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpO0pMi3FQM/EZWb5BbSEIlMsNgtPInx+waVOIPuOtFFIpurlyBiNcXUEkis/NdU/5ep4o9KMo@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZMDwkebuuxwL1wG3z+icfAxFNLQ4+wHRq24vJorBVg3wMwz+X
 7h0Yd6Tdas4/qjIQ4H6SXnQxR1sA7j+vfXBRyWp4F2E0dPfDq1pvB0QopTrxUeDxrmlg7+tQdj/
 mMnv4CBWUCMbyx3c7EgXtO+unqHtRL1lQJQ==
X-Gm-Gg: AZuq6aLIKqAW25aBsIEmyuM6O/iHALD3o6+uENiu2oNHJYqelVhwtDx+iP9EqC1QknA
 fiGbJp243THr3pF9khTeN0KZ7DAOsB/Nbj3BYK5erbPNRjG1F/IzILy6Nkvop/NCBEsCmPh+Y6e
 LYbgr0Qx0c1sZ601cuGGOo/lEN8sYUmBnCiklyeWWPixXvlxIIN9YjP68Xf0A1U67YnCPOKg9bY
 0HXQY/e0g7K6ZYLdzk1jZZmiInA3eyUJUafVFCVrO4ed4/BMeTqnjeVxCS0niAcilVEEocr
X-Received: by 2002:a05:7022:2497:b0:119:e55a:95a3 with SMTP id
 a92af1059eb24-12703fd1d27mr147078c88.5.1770328205839; Thu, 05 Feb 2026
 13:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20260205065130.654921-1-perry.yuan@amd.com>
 <20260205065130.654921-16-perry.yuan@amd.com>
In-Reply-To: <20260205065130.654921-16-perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 16:49:54 -0500
X-Gm-Features: AZwV_QgeVUea0mnFMpFT7PJnlltkgKsMfyRSPxp5qEIaaSTxi5t6Zr5R7v8AgeM
Message-ID: <CADnq5_Mxq-tXWDdReSetswwR-2x_DZWgOczGqXQzMyyJn2qaKg@mail.gmail.com>
Subject: Re: [PATCH 16/22] drm/amdgpu: Refactor PTL control into public API
 and internal implementation
To: Perry Yuan <perry.yuan@amd.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 yifan1.zhang@amd.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 5, 2026 at 2:02=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wrot=
e:
>
> Separate the PTL (Peak Tops Limiter) control logic into a stable public
> API layer and an internal implementation layer.
>
> v2: revise commit info
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Would be nice to re-generate the patches with this squashed in earlier
in the series.

Alex

> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 77 +++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  2 +-
>  4 files changed, 48 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index f491fd2e4ed9..74eb57332e07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -526,7 +526,7 @@ static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_dev=
ice *adev,
>                                 enum amdgpu_ptl_fmt *fmt1,
>                                 enum amdgpu_ptl_fmt *fmt2)
>  {
> -       return psp_performance_monitor_hw(&adev->psp, cmd,
> +       return amdgpu_ptl_perf_monitor_ctrl(adev, cmd,
>                         ptl_state, fmt1, fmt2);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 982494abbf1d..f0b1157d7a21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1239,48 +1239,25 @@ static int psp_ptl_fmt_verify(struct psp_context =
*psp, enum amdgpu_ptl_fmt fmt,
>         return 0;
>  }
>
> -int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
> -                              uint32_t *ptl_state, uint32_t *fmt1, uint3=
2_t *fmt2)
> +static int psp_ptl_invoke(struct psp_context *psp, u32 req_code,
> +               uint32_t *ptl_state, uint32_t *fmt1, uint32_t *fmt2)
>  {
>         struct psp_gfx_cmd_resp *cmd;
> -       uint32_t ptl_fmt1, ptl_fmt2;
>         int ret;
>
> -       if (!psp || !ptl_state || !fmt1 || !fmt2)
> -               return -EINVAL;
> -
> -       if (amdgpu_sriov_vf(psp->adev))
> -               return 0;
> -
> -       if (amdgpu_ip_version(psp->adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4=
, 4) ||
> -                       psp->sos.fw_version < 0x0036081a)
> -               return -EOPNOTSUPP;
> -
> -       if (psp_ptl_fmt_verify(psp, *fmt1, &ptl_fmt1) ||
> -                       psp_ptl_fmt_verify(psp, *fmt2, &ptl_fmt2))
> -               return -EINVAL;
> -
> -       /*
> -        * Add check to skip if state and formats are identical to curren=
t ones
> -        */
> -       if (req_code =3D=3D PSP_PTL_PERF_MON_SET &&
> -                       psp->ptl_enabled =3D=3D *ptl_state &&
> -                       psp->ptl_fmt1 =3D=3D ptl_fmt1 &&
> -                       psp->ptl_fmt2 =3D=3D ptl_fmt2)
> -               return 0;
> -
>         cmd =3D acquire_psp_cmd_buf(psp);
>
>         cmd->cmd_id                     =3D GFX_CMD_ID_PERF_HW;
>         cmd->cmd.cmd_req_perf_hw.req    =3D req_code;
>         cmd->cmd.cmd_req_perf_hw.ptl_state    =3D *ptl_state;
> -       cmd->cmd.cmd_req_perf_hw.pref_format1 =3D ptl_fmt1;
> -       cmd->cmd.cmd_req_perf_hw.pref_format2 =3D ptl_fmt2;
> +       cmd->cmd.cmd_req_perf_hw.pref_format1 =3D *fmt1;
> +       cmd->cmd.cmd_req_perf_hw.pref_format2 =3D *fmt2;
>
>         ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr=
);
>         if (ret)
>                 goto out;
>
> +       /* Parse response */
>         switch (req_code) {
>         case PSP_PTL_PERF_MON_QUERY:
>                 *ptl_state =3D cmd->resp.uresp.perf_hw_info.ptl_state;
> @@ -1288,9 +1265,10 @@ int psp_performance_monitor_hw(struct psp_context =
*psp, u32 req_code,
>                 *fmt2      =3D cmd->resp.uresp.perf_hw_info.pref_format2;
>                 break;
>         case PSP_PTL_PERF_MON_SET:
> +               /* Update cached state only on success */
>                 psp->ptl_enabled =3D *ptl_state;
> -               psp->ptl_fmt1    =3D ptl_fmt1;
> -               psp->ptl_fmt2    =3D ptl_fmt2;
> +               psp->ptl_fmt1    =3D *fmt1;
> +               psp->ptl_fmt2    =3D *fmt2;
>                 break;
>         }
>
> @@ -1299,6 +1277,41 @@ int psp_performance_monitor_hw(struct psp_context =
*psp, u32 req_code,
>         return ret;
>  }
>
> +int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_cod=
e,
> +               uint32_t *ptl_state, uint32_t *fmt1, uint32_t *fmt2)
> +{
> +       uint32_t ptl_fmt1, ptl_fmt2;
> +       struct psp_context *psp;
> +
> +       if (!adev || !ptl_state || !fmt1 || !fmt2)
> +               return -EINVAL;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               return 0;
> +
> +       psp =3D &adev->psp;
> +
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 4) =
||
> +                       psp->sos.fw_version < 0x0036081a)
> +               return -EOPNOTSUPP;
> +
> +       /* Verify formats */
> +       if (psp_ptl_fmt_verify(psp, *fmt1, &ptl_fmt1) ||
> +                       psp_ptl_fmt_verify(psp, *fmt2, &ptl_fmt2))
> +               return -EINVAL;
> +
> +       /*
> +        * Add check to skip if state and formats are identical to curren=
t ones
> +        */
> +       if (req_code =3D=3D PSP_PTL_PERF_MON_SET &&
> +                       psp->ptl_enabled =3D=3D *ptl_state &&
> +                       psp->ptl_fmt1 =3D=3D ptl_fmt1 &&
> +                       psp->ptl_fmt2 =3D=3D ptl_fmt2)
> +               return 0;
> +
> +       return psp_ptl_invoke(psp, req_code, ptl_state, &ptl_fmt1, &ptl_f=
mt2);
> +}
> +
>  static enum amdgpu_ptl_fmt str_to_ptl_fmt(const char *str)
>  {
>         int i;
> @@ -1356,7 +1369,7 @@ static ssize_t ptl_enable_store(struct device *dev,
>                 return count;
>         }
>
> -       ret =3D psp_performance_monitor_hw(psp, PSP_PTL_PERF_MON_SET, &pt=
l_state, &fmt1, &fmt2);
> +       ret =3D amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, =
&ptl_state, &fmt1, &fmt2);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to set PTL err =3D %d\n", ret)=
;
>                 mutex_unlock(&psp->ptl_mutex);
> @@ -1412,7 +1425,7 @@ static ssize_t ptl_format_store(struct device *dev,
>         ptl_state =3D psp->ptl_enabled;
>         fmt1 =3D fmt1_enum;
>         fmt2 =3D fmt2_enum;
> -       ret =3D psp_performance_monitor_hw(psp, PSP_PTL_PERF_MON_SET, &pt=
l_state, &fmt1, &fmt2);
> +       ret =3D amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, =
&ptl_state, &fmt1, &fmt2);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to update PTL err =3D %d\n", r=
et);
>                 mutex_unlock(&psp->ptl_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index 1ab7255718df..711f15d21940 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -662,7 +662,7 @@ void amdgpu_psp_debugfs_init(struct amdgpu_device *ad=
ev);
>  int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
>                            enum psp_gfx_fw_type *type);
>
> -int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
> +int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_cod=
e,
>                                u32 *ptl_state, u32 *fmt1, u32 *fmt2);
>  int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev);
>  void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 472e2f41fed2..1682adb1231f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2388,7 +2388,7 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct =
amdgpu_device *adev, bool sta
>         }
>
>         /* initialize PTL with default formats: GFX_FTYPE_I8 & GFX_FTYPE_=
BF16 */
> -       r =3D psp_performance_monitor_hw(&adev->psp, PSP_PTL_PERF_MON_SET=
, &ptl_state,
> +       r =3D amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &p=
tl_state,
>                                                         &fmt1, &fmt2);
>         if (r)
>                 return r;
> --
> 2.34.1
>
