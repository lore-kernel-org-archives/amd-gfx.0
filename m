Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F7CECE58A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC5010E6B6;
	Mon,  9 Sep 2024 20:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VYRhCIzE";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B5C10E6BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:58:06 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2055548469aso3910505ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725915486; x=1726520286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgMcm2cLBEO/h5QfjB1E2VUDKaJZoj2pdevldXL8tFw=;
 b=VYRhCIzEIrrpCrY03ZivK5YXbxHrwYp5sOf2tISpuQ28Ep7KR/mrWEb2eAkIkkJxlz
 NIy/msfCXmw9DTwNE0S6AgnphKbidkzp/8x/3g3amzYj8+zHr824PpFE4TuTrZR8Xv8F
 0EFOXfDFIT8SIkF2GBeeBCXK+pja8P1WAeBFCdvsW5OlvXtDd6dVCRpvrXmwETktQ76r
 uOlozbdsQaGbBkEt1S0JanLF691FBZiD7qtGcRd4ymg4a7q7SIjGCS4wkZFpZGqqwIGl
 ZahiPwYdn7gCaw5GZ/b4Bov0a1jO9Bn1+PfebNC+4AXHfRgBQIxvu6Mo8RWhx4J7mB//
 NI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725915486; x=1726520286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgMcm2cLBEO/h5QfjB1E2VUDKaJZoj2pdevldXL8tFw=;
 b=spfzzR1gvyU4iSI5aA7FXkVh3d7lGya3Pb5FJhPIOltNoTDELSMd0CTnud/aY8H8ZM
 ydVyKG/QWPHDQgstAsvJNyD+9WhPqDEvBBPRJEbqz3KMupjCVhLfZrI1Qi12oHVe/RBp
 9gg96EbZxr2hap8sJrvi+ZM63H8/K+zP6Uv2wdSdMsn89KAT3L3pTPrD3zQHNTIJEp4z
 xuSem2jIPVW962t9xDp3Cee5BYICnhLfb/Gl/rM2PH4yUEAtVb513ku/qYrZ/YWpXCvw
 lLUOkbiq5k/4I7XLAsp/cfKQP5PdDDlLAb1YZHT5o7FFboX+79ciSbvZsFCIwIMzus1Y
 0REA==
X-Gm-Message-State: AOJu0YzpPnHYYF4lkDvzmUhY439l1Hu/lcprFFVObzD5lehsUPqyt5aB
 ndbR1MaoWzZhnwRv0sN9h3xGHx0lBv8gSotKcw8Nlnp6F8cPeIQWS64ZfUfeXqYQe4lxSZWfP84
 z7BfHA8rphk3N1xeYTjlmFYVp0g1bV3aC
X-Google-Smtp-Source: AGHT+IE3q1ld9HYX5aONPnxLw+Khrg4PbeSXfybib2Wqg8uzE2+6baX9MO5GKl1qqeWPB8kOc7ldtA+gSbpOvwiCkUw=
X-Received: by 2002:a17:903:11d2:b0:207:d98:52ec with SMTP id
 d9443c01a7336-2070d985353mr40439655ad.14.1725915485677; Mon, 09 Sep 2024
 13:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-2-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-2-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 16:57:54 -0400
Message-ID: <CADnq5_OAFC34hOsUru+iYNKE7RoTwJSdKkt36tOfB=htbVOT=Q@mail.gmail.com>
Subject: Re: [PATCH 01/10] drm/amdgpu: Add init levels
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
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

On Mon, Sep 2, 2024 at 3:34=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add init levels to define the level to which device needs to be
> initialized.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 14 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 54 ++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 6e6580ab7e04..fefdace22894 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -820,6 +820,16 @@ struct amdgpu_mqd {
>                         struct amdgpu_mqd_prop *p);
>  };
>
> +enum amdgpu_init_lvl_id {
> +       AMDGPU_INIT_LEVEL_DEFAULT,
> +       AMDGPU_INIT_LEVEL_MINIMAL,

Add some comments here to define what they mean?  E.g.,

+       AMDGPU_INIT_LEVEL_MINIMAL, /* minimum needed for reset at load time=
 */

> +};
> +
> +struct amdgpu_init_level {
> +       enum amdgpu_init_lvl_id level;
> +       uint32_t hwini_ip_block_mask;
> +};
> +
>  #define AMDGPU_RESET_MAGIC_NUM 64
>  #define AMDGPU_MAX_DF_PERFMONS 4
>  struct amdgpu_reset_domain;
> @@ -1169,6 +1179,8 @@ struct amdgpu_device {
>         bool                            enforce_isolation[MAX_XCP];
>         /* Added this mutex for cleaner shader isolation between GFX and =
compute processes */
>         struct mutex                    enforce_isolation_mutex;
> +
> +       struct amdgpu_init_level *init_lvl;
>  };
>
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v,
> @@ -1623,4 +1635,6 @@ extern const struct attribute_group amdgpu_vram_mgr=
_attr_group;
>  extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
>  extern const struct attribute_group amdgpu_flash_attr_group;
>
> +void amdgpu_set_init_level(struct amdgpu_device *adev,
> +                          enum amdgpu_init_lvl_id lvl);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 61a189e30bcd..4fb09c4fbf22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -144,6 +144,42 @@ const char *amdgpu_asic_name[] =3D {
>         "LAST",
>  };
>
> +#define AMDGPU_IP_BLK_MASK_ALL GENMASK(AMDGPU_MAX_IP_NUM - 1, 0)
> +
> +struct amdgpu_init_level amdgpu_init_default =3D {
> +       .level =3D AMDGPU_INIT_LEVEL_DEFAULT,
> +       .hwini_ip_block_mask =3D AMDGPU_IP_BLK_MASK_ALL,
> +};
> +
> +struct amdgpu_init_level amdgpu_init_minimal =3D {
> +       .level =3D AMDGPU_INIT_LEVEL_MINIMAL,
> +       .hwini_ip_block_mask =3D
> +               BIT(AMD_IP_BLOCK_TYPE_GMC) | BIT(AMD_IP_BLOCK_TYPE_SMC) |
> +               BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH)
> +};
> +
> +static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *adev,
> +                                            enum amd_ip_block_type block=
)
> +{
> +       return (adev->init_lvl->hwini_ip_block_mask & (1U << block)) !=3D=
 0;
> +}
> +
> +void amdgpu_set_init_level(struct amdgpu_device *adev,
> +                          enum amdgpu_init_lvl_id lvl)
> +{
> +       switch (lvl) {
> +       case AMDGPU_INIT_LEVEL_DEFAULT:

Can move the default case here.

> +               adev->init_lvl =3D &amdgpu_init_default;
> +               break;
> +       case AMDGPU_INIT_LEVEL_MINIMAL:
> +               adev->init_lvl =3D &amdgpu_init_minimal;
> +               break;
> +       default:
> +               adev->init_lvl =3D &amdgpu_init_default;
> +               break;
> +       }
> +}
> +
>  static inline void amdgpu_device_stop_pending_resets(struct amdgpu_devic=
e *adev);
>
>  /**
> @@ -2633,6 +2669,9 @@ static int amdgpu_device_ip_hw_init_phase1(struct a=
mdgpu_device *adev)
>                         continue;
>                 if (adev->ip_blocks[i].status.hw)
>                         continue;
> +               if (!amdgpu_ip_member_of_hwini(
> +                           adev, adev->ip_blocks[i].version->type))
> +                       continue;
>                 if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_COMMON ||
>                     (amdgpu_sriov_vf(adev) && (adev->ip_blocks[i].version=
->type =3D=3D AMD_IP_BLOCK_TYPE_PSP)) ||
>                     adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_IH) {
> @@ -2658,6 +2697,9 @@ static int amdgpu_device_ip_hw_init_phase2(struct a=
mdgpu_device *adev)
>                         continue;
>                 if (adev->ip_blocks[i].status.hw)
>                         continue;
> +               if (!amdgpu_ip_member_of_hwini(
> +                           adev, adev->ip_blocks[i].version->type))
> +                       continue;
>                 r =3D adev->ip_blocks[i].version->funcs->hw_init(adev);
>                 if (r) {
>                         DRM_ERROR("hw_init of IP block <%s> failed %d\n",
> @@ -2681,6 +2723,10 @@ static int amdgpu_device_fw_loading(struct amdgpu_=
device *adev)
>                         if (adev->ip_blocks[i].version->type !=3D AMD_IP_=
BLOCK_TYPE_PSP)
>                                 continue;
>
> +                       if (!amdgpu_ip_member_of_hwini(adev,
> +                                                      AMD_IP_BLOCK_TYPE_=
PSP))
> +                               break;
> +
>                         if (!adev->ip_blocks[i].status.sw)
>                                 continue;
>
> @@ -2803,6 +2849,10 @@ static int amdgpu_device_ip_init(struct amdgpu_dev=
ice *adev)
>                 }
>                 adev->ip_blocks[i].status.sw =3D true;
>
> +               if (!amdgpu_ip_member_of_hwini(
> +                           adev, adev->ip_blocks[i].version->type))
> +                       continue;
> +
>                 if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_COMMON) {
>                         /* need to do common hw init early so everything =
is set up for gmc */
>                         r =3D adev->ip_blocks[i].version->funcs->hw_init(=
(void *)adev);
> @@ -4196,6 +4246,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>         amdgpu_device_set_mcbp(adev);
>

Add a comment here to make it clear where and why we change the init level.

> +       amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
> +       adev->init_lvl =3D &amdgpu_init_default;

This pointer assignment can be dropped.

>         /* early init functions */
>         r =3D amdgpu_device_ip_early_init(adev);
>         if (r)
> @@ -5473,6 +5525,8 @@ int amdgpu_do_asic_reset(struct list_head *device_l=
ist_handle,
>         }
>
>         list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> +               /* After reset, it's default init level */
> +               amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT=
);
>                 if (need_full_reset) {
>                         /* post card */
>                         amdgpu_ras_set_fed(tmp_adev, false);
> --
> 2.25.1
>
