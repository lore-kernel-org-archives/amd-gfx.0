Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47729ECD9A6
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 21:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E28AD10E101;
	Thu,  5 Feb 2026 21:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wu3xhkAl";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF8E10E101
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 21:39:01 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1233608c7e9so148461c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 13:39:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770327541; cv=none;
 d=google.com; s=arc-20240605;
 b=NuWXKp8bWs0Cm3C4G2o0oKNjEJ/qTHyW4DmHv4QmCAD+/6tukG2AJ0NRqLjsAhOSet
 Dqg1PaxDEOYdnJRHLWnWUtHaG9y6fUA2txPjQb99S9IL1RS4ImCKzmLY4Xw/aaQ2DFiv
 BtK/WT+xuCntDzMu1lvYoEHEvMMyTz4MK3V3QnpSJkChMRTM9VfTm1uKzB8JR1fAQaji
 TKab/pLNav35jqLu5xEiPuQo1Taf+WMQY18uzIMnUnME//YxJasfEFMGxd01KWkdPuHa
 pR00z1Sgt3z6ZEPtIsk1JuqTth8AhUASC3SCUsrsWPO49g2EFOwfc8LasZQMrxdr3GNT
 rtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=58Prg1o+hPbVXV2ce8g5eSxltQBA8+7+VmYspPMTyJo=;
 fh=Npm28iu3D02tCSFYIUyZ4/Kkq2BaYPMZddLOFsI7nig=;
 b=hS0Sh142qdToxAUaYZvBm2JTNI73gtq0NcWu/qLmivuqqWMz5ivekt028Z1va3FtKA
 /RizY3TxOL75YG5vOaZQs/ifcTi8vm8+7/a6WeCrPL3QXqyhwmSvoXZN8nDUHY8ARFz7
 z7ahbnDaz14KoQxQTPS6VtBBM3xq2y3BaFBQiHvJjoGgTPVbBbgmXSVIHmk7joI5m/nE
 9AT7D26lvhLNHYNDY68DHzsOdGb6xY9qT/w0ZlFvbSlKwsmEqIz0JipPtD1LPYwvN0/l
 hNSnCFwkBVmKKqpru3xuR/sc46xQmGrUfjbqPmfmlPbM/1oYNUZLVb+famxQMgur0WUS
 ijFQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770327541; x=1770932341; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58Prg1o+hPbVXV2ce8g5eSxltQBA8+7+VmYspPMTyJo=;
 b=Wu3xhkAljSQgMkRcjioTVfyrVQ5saiQ2z6JtUn+2MqYkm1LCMBOGOy13C22sNBJYEg
 x0AS32hPHgxowBdCqLCgWBOMtSumAt6rYC9CvZVylHkh/reGQqXD8tF7OD0drSqwUx27
 UBS2CnZiSLEUOCyGWkv6n/82wPOGlC5s/3gMZSDGuti8dZ4GcCjxfHahnwIm96sxbIAs
 eLALGoVqiEgt5gIrehDRXPQsw8AG0RgAMthhNExSitVVpcVMFeFw7QfUCAhqnP65+9Ho
 +9axgBoV0VRU6xb0x3PxOafpHGN5jEQmgPWhvOIOv4fYU2INkHRUiJ6CIyJeHPmUE4vg
 9Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770327541; x=1770932341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=58Prg1o+hPbVXV2ce8g5eSxltQBA8+7+VmYspPMTyJo=;
 b=KNkOntF46uzw1T5n+LsJ7yNFWIL/faGQl9JV9rPZmkCemn1s4JC5hYqmV3L6EYYTLk
 M7QI5r8OBd1dVRk/9EW9I8H5VwSwW/cmos90qR4bxu5wOAm2YdV3M1ZV5ncR3qrV2ktZ
 haPPCFdf122Ry1gVxptHNz6SdNw7BEKQPfSEicfbMdT1NPWAFRKpgvSzJQGNMEgKSgH1
 HlgluNn/XXUNMmxCY/bTk+63eaIdzDu9of1QgM3GFHtCpao3qY7MfFz9WR8VLFFaFdsa
 p5EdkmizqEnjkJj1/xF9oJKQPF83/fh/CKgPHBkl/gFng6QoiUSJLNl36SmF5JRwCQs8
 Iixg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy5pvY7cr6Gb7XNMaBIeIbWurNi1aTufwPYNKjrY2vMKAli/yLgxy3vKyoyfkkjTiEzBaJswcc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM/OPlYtVLm8pIW+P9amcIJGTqNCyZfYRrMPmdcofCXgme5HQZ
 +SKfPpjyQcANAfmXTygKmu13LeBunouDnK6Yw9WYvUwJdzDSAcUFT9fKcadHkC/vQt3xT9IVwf2
 2iBS0+V4/ntLSFUzIy4uOsphs1WE30eSVyg==
X-Gm-Gg: AZuq6aIF2cr96Cgwgiqiy2og/+bEf/Q6i/+/0cRjqRqow/XYv3GJwHAWlT7cH/GjNS2
 7lRGi4gkby69AVwTqqNqa5Nq+ZexjIlyWiWt4t9v/h/BN8UoW+q2MA9oonqe+rKwrLI/esHRjiS
 YiWxUgPqiULf+Gs2uGwPJNm/azMV+g715HdayawgKDBA7SSXz0t67AVqOf7uGdbhTfc+aMsQRln
 L+HuQEVVSUU/+V4zRQD8fdGkDbOTSf1LXt1VBAOJxspQOR1/YjGGadhAhOLCyTrW6r7KK9l
X-Received: by 2002:a05:7022:f9b:b0:122:33e:6ec1 with SMTP id
 a92af1059eb24-12703e56a4emr202720c88.0.1770327540903; Thu, 05 Feb 2026
 13:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20260205065130.654921-1-perry.yuan@amd.com>
 <20260205065130.654921-2-perry.yuan@amd.com>
In-Reply-To: <20260205065130.654921-2-perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 16:38:49 -0500
X-Gm-Features: AZwV_QhYzNI1kcEHVy-H3t6wi-IcTVA_RieAGFlDw5SzPgGB7vCXfO88SxvPlMU
Message-ID: <CADnq5_NNycQELEjJ1zOOrKLo+9tP9bjWuGEeztkd_TkXRjMKhA@mail.gmail.com>
Subject: Re: [PATCH 02/22] drm/amdgpu: add psp interfaces for peak tops
 limiter driver
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
> Introduce a Peak Tops Limiter (PTL) driver that dynamically caps
> engine frequency to ensure delivered TOPS never exceeds a defined
> TOPS_limit. This initial implementation provides core data structures
> and kernel-space interfaces (set/get, enable/disable) to manage PTL state=
.
>
> PTL performs a firmware handshake to initialize its state and update
> predefined format types. It supports updating these format types at
> runtime while user-space tools automatically switch PTL state, and
> also allows explicitly switching PTL state via newly added commands.
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 80 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  6 ++
>  include/uapi/linux/kfd_ioctl.h          |  9 +++
>  3 files changed, 95 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index b0540b009e84..2fbc3f95fedd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -679,6 +679,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_=
id cmd_id)
>                 return "SPATIAL_PARTITION";
>         case GFX_CMD_ID_FB_NPS_MODE:
>                 return "NPS_MODE_CHANGE";
> +       case GFX_CMD_ID_PERF_HW:
> +               return "PERF MONITORING HW";
>         default:
>                 return "UNKNOWN CMD";
>         }
> @@ -1197,6 +1199,84 @@ int psp_memory_partition(struct psp_context *psp, =
int mode)
>         return ret;
>  }
>
> +static int psp_ptl_fmt_verify(struct psp_context *psp, enum amdgpu_ptl_f=
mt fmt,
> +                                                uint32_t *ptl_fmt)
> +{
> +       struct amdgpu_device *adev =3D psp->adev;
> +
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 4))
> +               return -EINVAL;
> +
> +       switch (fmt) {
> +       case AMDGPU_PTL_FMT_I8:
> +               *ptl_fmt =3D GFX_FTYPE_I8;
> +               break;
> +       case AMDGPU_PTL_FMT_F16:
> +               *ptl_fmt =3D GFX_FTYPE_F16;
> +               break;
> +       case AMDGPU_PTL_FMT_BF16:
> +               *ptl_fmt =3D GFX_FTYPE_BF16;
> +               break;
> +       case AMDGPU_PTL_FMT_F32:
> +               *ptl_fmt =3D GFX_FTYPE_F32;
> +               break;
> +       case AMDGPU_PTL_FMT_F64:
> +               *ptl_fmt =3D GFX_FTYPE_F64;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
> +                              uint32_t *ptl_state, uint32_t *fmt1, uint3=
2_t *fmt2)
> +{
> +       struct psp_gfx_cmd_resp *cmd;
> +       uint32_t ptl_fmt1, ptl_fmt2;
> +       int ret;
> +
> +       if (!psp || !ptl_state || !fmt1 || !fmt2)
> +               return -EINVAL;
> +
> +       if (amdgpu_sriov_vf(psp->adev))
> +               return 0;
> +
> +       if (psp_ptl_fmt_verify(psp, *fmt1, &ptl_fmt1) ||
> +                       psp_ptl_fmt_verify(psp, *fmt2, &ptl_fmt2))
> +               return -EINVAL;


Do we need a FW version check for this?

Alex

> +
> +       cmd =3D acquire_psp_cmd_buf(psp);
> +
> +       cmd->cmd_id                     =3D GFX_CMD_ID_PERF_HW;
> +       cmd->cmd.cmd_req_perf_hw.req    =3D req_code;
> +       cmd->cmd.cmd_req_perf_hw.ptl_state    =3D *ptl_state;
> +       cmd->cmd.cmd_req_perf_hw.pref_format1 =3D ptl_fmt1;
> +       cmd->cmd.cmd_req_perf_hw.pref_format2 =3D ptl_fmt2;
> +
> +       ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr=
);
> +       if (ret)
> +               goto out;
> +
> +       switch (req_code) {
> +       case PSP_PTL_PERF_MON_QUERY:
> +               *ptl_state =3D cmd->resp.uresp.perf_hw_info.ptl_state;
> +               *fmt1      =3D cmd->resp.uresp.perf_hw_info.pref_format1;
> +               *fmt2      =3D cmd->resp.uresp.perf_hw_info.pref_format2;
> +               break;
> +       case PSP_PTL_PERF_MON_SET:
> +               psp->ptl_enabled =3D *ptl_state;
> +               psp->ptl_fmt1    =3D ptl_fmt1;
> +               psp->ptl_fmt2    =3D ptl_fmt2;
> +               break;
> +       }
> +
> +out:
> +       release_psp_cmd_buf(psp);
> +       return ret;
> +}
> +
>  int psp_spatial_partition(struct psp_context *psp, int mode)
>  {
>         struct psp_gfx_cmd_resp *cmd;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index 90df8e29f532..47c8becbf710 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -471,6 +471,10 @@ struct psp_context {
>  #if defined(CONFIG_DEBUG_FS)
>         struct spirom_bo *spirom_dump_trip;
>  #endif
> +       enum amdgpu_ptl_fmt             ptl_fmt1;
> +       enum amdgpu_ptl_fmt             ptl_fmt2;
> +       bool                            ptl_enabled;
> +       bool                            ptl_hw_supported;
>  };
>
>  struct amdgpu_psp_funcs {
> @@ -654,5 +658,7 @@ void amdgpu_psp_debugfs_init(struct amdgpu_device *ad=
ev);
>  int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
>                            enum psp_gfx_fw_type *type);
>
> +int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
> +                              u32 *ptl_state, u32 *fmt1, u32 *fmt2);
>
>  #endif
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index abb526c915c3..8db0c474a769 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1558,6 +1558,15 @@ struct kfd_ioctl_dbg_trap_args {
>         };
>  };
>
> +enum amdgpu_ptl_fmt {
> +       AMDGPU_PTL_FMT_I8   =3D 0,
> +       AMDGPU_PTL_FMT_F16  =3D 1,
> +       AMDGPU_PTL_FMT_BF16 =3D 2,
> +       AMDGPU_PTL_FMT_F32  =3D 3,
> +       AMDGPU_PTL_FMT_F64  =3D 4,
> +       AMDGPU_PTL_FMT_INVALID =3D 5,
> +};
> +
>  #define KFD_IOC_PROFILER_VERSION_NUM 1
>  enum kfd_profiler_ops {
>         KFD_IOC_PROFILER_PMC =3D 0,
> --
> 2.34.1
>
