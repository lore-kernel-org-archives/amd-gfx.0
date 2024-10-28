Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96A2D3E2A0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D5810E52D;
	Mon, 28 Oct 2024 19:20:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jPymsZMg";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A6A10E52D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:20:10 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-71e4eb91228so324821b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730143210; x=1730748010; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkZZgZeudLOZshhdmXOp6P8vOlXfbzP7t6t51Qei2k8=;
 b=jPymsZMgIYcxHxHzeldVPsPEDvCfNdvm3OX+ulgeqI/e2QIekZafeqwwN3c+Z03jcj
 PXFjU+0hFvxPz5Y6HwBcRV9B6ZIGSqIkLxLAOVc64Neo02nHnu9Vdg03Sf14IJPsFssc
 Jvkka2ZBydoLRE2K1LGbiZKpYJW6JK/nXueDtyBz6HE8e5OUPDGlXuKqOlh+bPDo3Zah
 dwuTF3hSxNjtgFPOkn/pLrZAEFirNTjSYFszBiq2Y40UqTwdr126T7na2+iuO/JlTT6v
 qFtAdI+4as06Azrg3Tr7DPtSZBgbXb7tsmYZZFqfpTdFfz+jJ1goeb6JWs03zS2UclWZ
 5/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143210; x=1730748010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkZZgZeudLOZshhdmXOp6P8vOlXfbzP7t6t51Qei2k8=;
 b=vkYMcGMmUyLiuklP2yUKz6cZ+5zO9S15BUaTVGsPLokTUDFYtU8RFwGysZIlS81hs5
 iCYTQMQGdfpB1rao0JgCwMIFssGzYFuzd+mRNOxcG0pMzl12cmbqSdg7YYKpDUBl75O5
 d5hTZnqDuk/zATjLUZ56GAwtOQBj6wt7OFZRfYFgjVtnno5kl7NUQ4e1lKkFUDulS0OC
 XqHcYwbBrffPxUvj2SH0xYWguk5YnxSJTgeVgvOlZkfYyjKW7NyOOcstMolJLsLnmboA
 RmyiXaN7cemtKQK4Sme7IcHhBL5yII7t2iikZ9s9Vk+Wk8qa5LH1VxszdrNroVO1a4Nm
 /gHw==
X-Gm-Message-State: AOJu0YxG94cgGUuRokvfXjBpDj+GDlWTJeI7YaZlQ/MUyYKOjF0Q5JSj
 BYqSOMgcVsX8MiGbgS6/WP5MOzLnXHDJwIKV6Miscn/Ch7iOBnbTXSAYU8xM+7u/HxdxqZVCISU
 Ln0j8RGybG/s03Ye4WJYw4DBVpEpwV+46
X-Google-Smtp-Source: AGHT+IHuAVnjli7yX7ziyO0F57P707KFpIdaJiB+VBSU1oprgLDKE3462XPFw+WvDWhnny4OJBGN7xbcmFTvzxHhCi4=
X-Received: by 2002:a05:6a00:2da4:b0:71e:6895:fe9e with SMTP id
 d2e1a72fcca58-72063059e84mr5513762b3a.6.1730143209879; Mon, 28 Oct 2024
 12:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-11-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-11-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:19:58 -0400
Message-ID: <CADnq5_Mh-tSwvhEnrJFL=GqbtR9-GMeObtYrzb9M9DbX_U_CqQ@mail.gmail.com>
Subject: Re: [PATCH 10/29] drm/amdgpu: move per inst variables to
 amdgpu_vcn_inst
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Fri, Oct 25, 2024 at 12:53=E2=80=AFAM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Move all per instance variables from amdgpu_vcn to amdgpu_vcn_inst.
>
> Move adev->vcn.fw[i] from amdgpu_vcn to amdgpu_vcn_inst.
> Move adev->vcn.vcn_config[i] from amdgpu_vcn to amdgpu_vcn_inst.
> Move adev->vcn.vcn_codec_disable_mask[i] from amdgpu_vcn to amdgpu_vcn_in=
st.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 20 +++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  4 ++--
>  11 files changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 73f4d56c5de4..cce3f1a6f288 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1340,7 +1340,7 @@ static int amdgpu_discovery_reg_base_init(struct am=
dgpu_device *adev)
>                                  */
>                                 if (adev->vcn.num_vcn_inst <
>                                     AMDGPU_MAX_VCN_INSTANCES) {
> -                                       adev->vcn.vcn_config[adev->vcn.nu=
m_vcn_inst] =3D
> +                                       adev->vcn.inst[adev->vcn.num_vcn_=
inst].vcn_config =3D
>                                                 ip->revision & 0xc0;
>                                         adev->vcn.num_vcn_inst++;
>                                         adev->vcn.inst_mask |=3D
> @@ -1705,7 +1705,7 @@ static int amdgpu_discovery_get_vcn_info(struct amd=
gpu_device *adev)
>                  * so this won't overflow.
>                  */
>                 for (v =3D 0; v < adev->vcn.num_vcn_inst; v++) {
> -                       adev->vcn.vcn_codec_disable_mask[v] =3D
> +                       adev->vcn.inst[v].vcn_codec_disable_mask =3D
>                                 le32_to_cpu(vcn_info->v1.instance_info[v]=
.fuse_data.all_bits);
>                 }
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index aecb78e0519f..49802e66a358 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -99,11 +99,11 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>         amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, size=
of(ucode_prefix));
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
>                 if (i =3D=3D 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) =
=3D=3D  IP_VERSION(4, 0, 6))
> -                       r =3D amdgpu_ucode_request(adev, &adev->vcn.fw[i]=
, "amdgpu/%s_%d.bin", ucode_prefix, i);
> +                       r =3D amdgpu_ucode_request(adev, &adev->vcn.inst[=
i].fw, "amdgpu/%s_%d.bin", ucode_prefix, i);
>                 else
> -                       r =3D amdgpu_ucode_request(adev, &adev->vcn.fw[i]=
, "amdgpu/%s.bin", ucode_prefix);
> +                       r =3D amdgpu_ucode_request(adev, &adev->vcn.inst[=
i].fw, "amdgpu/%s.bin", ucode_prefix);
>                 if (r) {
> -                       amdgpu_ucode_release(&adev->vcn.fw[i]);
> +                       amdgpu_ucode_release(&adev->vcn.inst[i].fw);
>                         return r;
>                 }
>         }
> @@ -151,7 +151,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>         adev->vcn.using_unified_queue =3D
>                 amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(4, 0=
, 0);
>
> -       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[0]->d=
ata;
> +       hdr =3D (const struct common_firmware_header *)adev->vcn.inst[0].=
fw->data;
>         adev->vcn.fw_version =3D le32_to_cpu(hdr->ucode_version);
>
>         /* Bit 20-23, it is encode major and non-zero for new naming conv=
ention.
> @@ -270,7 +270,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>                 for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
>                         amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
>
> -               amdgpu_ucode_release(&adev->vcn.fw[j]);
> +               amdgpu_ucode_release(&adev->vcn.inst[j].fw);
>         }
>
>         mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
> @@ -282,7 +282,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_rin=
g_type type, uint32_t vcn_instance)
>  {
>         bool ret =3D false;
> -       int vcn_config =3D adev->vcn.vcn_config[vcn_instance];
> +       int vcn_config =3D adev->vcn.inst[vcn_instance].vcn_config;
>
>         if ((type =3D=3D VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCO=
DE_DISABLE_MASK))
>                 ret =3D true;
> @@ -362,12 +362,12 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>                         const struct common_firmware_header *hdr;
>                         unsigned int offset;
>
> -                       hdr =3D (const struct common_firmware_header *)ad=
ev->vcn.fw[i]->data;
> +                       hdr =3D (const struct common_firmware_header *)ad=
ev->vcn.inst[i].fw->data;
>                         if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_=
PSP) {
>                                 offset =3D le32_to_cpu(hdr->ucode_array_o=
ffset_bytes);
>                                 if (drm_dev_enter(adev_to_drm(adev), &idx=
)) {
>                                         memcpy_toio(adev->vcn.inst[i].cpu=
_addr,
> -                                                   adev->vcn.fw[i]->data=
 + offset,
> +                                                   adev->vcn.inst[i].fw-=
>data + offset,
>                                                     le32_to_cpu(hdr->ucod=
e_size_bytes));
>                                         drm_dev_exit(idx);
>                                 }
> @@ -1063,7 +1063,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *a=
dev)
>                         if (adev->vcn.harvest_config & (1 << i))
>                                 continue;
>
> -                       hdr =3D (const struct common_firmware_header *)ad=
ev->vcn.fw[i]->data;
> +                       hdr =3D (const struct common_firmware_header *)ad=
ev->vcn.inst[i].fw->data;
>                         /* currently only support 2 FW instances */
>                         if (i >=3D 2) {
>                                 dev_info(adev->dev, "More then 2 VCN FW i=
nstances!\n");
> @@ -1071,7 +1071,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *a=
dev)
>                         }
>                         idx =3D AMDGPU_UCODE_ID_VCN + i;
>                         adev->firmware.ucode[idx].ucode_id =3D idx;
> -                       adev->firmware.ucode[idx].fw =3D adev->vcn.fw[i];
> +                       adev->firmware.ucode[idx].fw =3D adev->vcn.inst[i=
].fw;
>                         adev->firmware.fw_size +=3D
>                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes),=
 PAGE_SIZE);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 765b809d48a2..ba58b4f07643 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -297,6 +297,9 @@ struct amdgpu_vcn_inst {
>         atomic_t                dpg_enc_submission_cnt;
>         struct amdgpu_vcn_fw_shared fw_shared;
>         uint8_t                 aid_id;
> +       const struct firmware   *fw; /* VCN firmware */
> +       uint8_t                 vcn_config;
> +       uint32_t                vcn_codec_disable_mask;
>  };
>
>  struct amdgpu_vcn_ras {
> @@ -306,15 +309,12 @@ struct amdgpu_vcn_ras {
>  struct amdgpu_vcn {
>         unsigned                fw_version;
>         struct delayed_work     idle_work;
> -       const struct firmware   *fw[AMDGPU_MAX_VCN_INSTANCES];  /* VCN fi=
rmware */
>         unsigned                num_enc_rings;
>         enum amd_powergating_state cur_state;
>         bool                    indirect_sram;
>
>         uint8_t num_vcn_inst;
>         struct amdgpu_vcn_inst   inst[AMDGPU_MAX_VCN_INSTANCES];
> -       uint8_t                  vcn_config[AMDGPU_MAX_VCN_INSTANCES];
> -       uint32_t                 vcn_codec_disable_mask[AMDGPU_MAX_VCN_IN=
STANCES];
>         struct amdgpu_vcn_reg    internal;
>         struct mutex             vcn_pg_lock;
>         struct mutex            vcn1_jpeg1_workaround;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 00d9fdd2869e..5ea96c983517 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -345,7 +345,7 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip=
_block)
>   */
>  static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
>  {
> -       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4=
);
> +       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->siz=
e + 4);
>         uint32_t offset;
>
>         /* cache window 0: fw */
> @@ -412,7 +412,7 @@ static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu=
_device *adev)
>
>  static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
>  {
> -       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4=
);
> +       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->siz=
e + 4);
>         uint32_t offset;
>
>         /* cache window 0: fw */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index de4067713d7b..e42cfc731ad8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -372,7 +372,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip=
_block)
>   */
>  static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
>  {
> -       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4=
);
> +       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->siz=
e + 4);
>         uint32_t offset;
>
>         if (amdgpu_sriov_vf(adev))
> @@ -428,7 +428,7 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *=
adev)
>
>  static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool=
 indirect)
>  {
> -       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4=
);
> +       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->siz=
e + 4);
>         uint32_t offset;
>
>         /* cache window 0: fw */
> @@ -1920,7 +1920,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_devic=
e *adev)
>
>                 init_table +=3D header->vcn_table_offset;
>
> -               size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4)=
;
> +               size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size=
 + 4);
>
>                 MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(
>                         SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 08f43a281a7f..b518202955ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -465,7 +465,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *=
adev)
>                 if (adev->vcn.harvest_config & (1 << i))
>                         continue;
>
> -               size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4)=
;
> +               size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size=
 + 4);
>                 /* cache window 0: fw */
>                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
>                         WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_B=
AR_LOW,
> @@ -514,7 +514,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *=
adev)
>
>  static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int =
inst_idx, bool indirect)
>  {
> -       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst_idx]->s=
ize + 4);
> +       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].=
fw->size + 4);
>         uint32_t offset;
>
>         /* cache window 0: fw */
> @@ -1287,7 +1287,7 @@ static int vcn_v2_5_sriov_start(struct amdgpu_devic=
e *adev)
>                         SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS),
>                         ~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
>
> -               size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4)=
;
> +               size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size=
 + 4);
>                 /* mc resume*/
>                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
>                         MMSCH_V1_0_INSERT_DIRECT_WT(
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 6002990d917b..63ddd4cca910 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -490,7 +490,7 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip=
_block)
>   */
>  static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
>  {
> -       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst]->size =
+ 4);
> +       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst].fw->=
size + 4);
>         uint32_t offset;
>
>         /* cache window 0: fw */
> @@ -540,7 +540,7 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *=
adev, int inst)
>
>  static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int =
inst_idx, bool indirect)
>  {
> -       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst_idx]->s=
ize + 4);
> +       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].=
fw->size + 4);
>         uint32_t offset;
>
>         /* cache window 0: fw */
> @@ -1375,7 +1375,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_devic=
e *adev)
>                         mmUVD_STATUS),
>                         ~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
>
> -               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->siz=
e + 4);
> +               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw=
->size + 4);
>
>                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
>                         MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN,=
 i,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 2c36f748176f..1a6257d324c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -422,7 +422,7 @@ static void vcn_v4_0_mc_resume(struct amdgpu_device *=
adev, int inst)
>         uint32_t offset, size;
>         const struct common_firmware_header *hdr;
>
> -       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[inst]=
->data;
> +       hdr =3D (const struct common_firmware_header *)adev->vcn.inst[ins=
t].fw->data;
>         size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes)=
 + 8);
>
>         /* cache window 0: fw */
> @@ -482,7 +482,7 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu=
_device *adev, int inst_idx
>  {
>         uint32_t offset, size;
>         const struct common_firmware_header *hdr;
> -       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[inst_=
idx]->data;
> +       hdr =3D (const struct common_firmware_header *)adev->vcn.inst[ins=
t_idx].fw->data;
>         size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes)=
 + 8);
>
>         /* cache window 0: fw */
> @@ -1334,7 +1334,7 @@ static int vcn_v4_0_start_sriov(struct amdgpu_devic=
e *adev)
>                         regUVD_STATUS),
>                         ~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
>
> -               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->siz=
e + 4);
> +               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw=
->size + 4);
>
>                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
>                         MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN,=
 i,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index eda67585768f..23a2a80129bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -377,7 +377,7 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device=
 *adev, int inst_idx)
>         uint32_t offset, size, vcn_inst;
>         const struct common_firmware_header *hdr;
>
> -       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[inst_=
idx]->data;
> +       hdr =3D (const struct common_firmware_header *)adev->vcn.inst[ins=
t_idx].fw->data;
>         size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes)=
 + 8);
>
>         vcn_inst =3D GET_INST(VCN, inst_idx);
> @@ -452,7 +452,7 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdg=
pu_device *adev, int inst_i
>         uint32_t offset, size;
>         const struct common_firmware_header *hdr;
>
> -       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[inst_=
idx]->data;
> +       hdr =3D (const struct common_firmware_header *)adev->vcn.inst[ins=
t_idx].fw->data;
>         size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes)=
 + 8);
>
>         /* cache window 0: fw */
> @@ -939,7 +939,7 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_devic=
e *adev)
>                 MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, =
0, regUVD_STATUS),
>                         ~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
>
> -               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->siz=
e + 4);
> +               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw=
->size + 4);
>
>                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
>                         MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN,=
 0,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index f24e1eef6606..e49ba5bc7fa0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -370,7 +370,7 @@ static void vcn_v4_0_5_mc_resume(struct amdgpu_device=
 *adev, int inst)
>         uint32_t offset, size;
>         const struct common_firmware_header *hdr;
>
> -       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[inst]=
->data;
> +       hdr =3D (const struct common_firmware_header *)adev->vcn.inst[ins=
t].fw->data;
>         size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes)=
 + 8);
>
>         /* cache window 0: fw */
> @@ -431,7 +431,7 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdg=
pu_device *adev, int inst_i
>         uint32_t offset, size;
>         const struct common_firmware_header *hdr;
>
> -       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[inst_=
idx]->data;
> +       hdr =3D (const struct common_firmware_header *)adev->vcn.inst[ins=
t_idx].fw->data;
>         size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes)=
 + 8);
>
>         /* cache window 0: fw */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 8ccd054975a1..900ca8ababc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -334,7 +334,7 @@ static void vcn_v5_0_0_mc_resume(struct amdgpu_device=
 *adev, int inst)
>         uint32_t offset, size;
>         const struct common_firmware_header *hdr;
>
> -       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[inst]=
->data;
> +       hdr =3D (const struct common_firmware_header *)adev->vcn.inst[ins=
t].fw->data;
>         size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes)=
 + 8);
>
>         /* cache window 0: fw */
> @@ -395,7 +395,7 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdg=
pu_device *adev, int inst_i
>         uint32_t offset, size;
>         const struct common_firmware_header *hdr;
>
> -       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[inst_=
idx]->data;
> +       hdr =3D (const struct common_firmware_header *)adev->vcn.inst[ins=
t_idx].fw->data;
>         size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes)=
 + 8);
>
>         /* cache window 0: fw */
> --
> 2.34.1
>
