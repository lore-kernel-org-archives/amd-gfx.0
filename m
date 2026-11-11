Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47E606A88C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v9YHOjBh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5862E10F298;
	Wed, 11 Nov 2026 14:44:39 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D804910F5D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 14:44:32 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-36dc4797082so86504eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 06:44:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794408272; cv=none;
 d=google.com; s=arc-20260327;
 b=MJKm/LKtSC9CH2aQsv/0gXivfu37LFCHgvHdrCWKCwrxIQ0M674zWPbwbbbChuaU0H
 W/lJ581YfUdxO8Sbit+1zQXGOX4U4fp4hJYyGCOtWLgdWwNwUZK0cwXkJ3Y/5BTTsg+b
 mtXuVi/x1B9N/imAiJFpNv23GOdFOudX279pNREPTkb7t+3E95wQqxiELP+udaqUaLmy
 j+4deKvM2+cbyeB0MIkjthbZzD5j4Ugm8jqxlwivl+O+V3/gWj1h0+6L71qhlkKzL4op
 KZGH3KKieXbesZ86LZOtBaughmIhj13c8q1Y0ETFMtmDnNyMGvLp5uI779wamx/wd7y8
 EOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N+aaUOhs5sub5iinHmy22ebPl8VsWKHnOLxTTINF70U=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=sQlzegynMem0wMA2g2bM1uFeozs+c7fQCuoUqByti8LVvijVHRcb31skkt7i/1dgp7
 6qmhNRkCwkOObjvlehHgc1BsYbFtz3orAgT9GMacZXaCkHspq2kY0Q608Nr6ft5TsVVk
 cD/BuRnhXRTYkQQlKp7h2OrUkbE+Hv+UvhlDURxK8PtuzVlPdXVdvIH2mUKJgSVDVkwr
 V6FMnfZRPn6D9LwWTU/zZn9DGWKfVMpc4RhCqMJk5NMLVIlAAzEQwGYMYFc1n/fzQhaD
 fHZMB/xkQf3Za7n3goeKCXJCnA2Pf3obRCNpOhaw79F8rmjlBPsvzdhto70AQMDrMXpJ
 yhCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794408272; x=1795013072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N+aaUOhs5sub5iinHmy22ebPl8VsWKHnOLxTTINF70U=;
 b=v9YHOjBhuQ51J9qZy2YECG5b9cidhvEoLY4PwGcTiGTPCwQ4bIbv5FQKFx44V6ka0Z
 forFHQtnWov1HAjguJCJN4JnJhfU0PnW9Pr1xQNSEYFC9pUzaROz1AIJDE2PNkKpHeqd
 2RPChDhFgg5bunfWz4UEZvQutRMXAdST2GT7CH2lDjGnHRVRNhIjw1Q2Pgc/SelWph0m
 OTlG/pmMPiI3NQd34iSItOaR7WkSCUxvlYUzBQUWhPJPOVUs/57xYSi9xWQIEWPRLUQ9
 i9WFEu9UOBphbwVtGTCCCWTbHV8qfi0ZLS5saRktNciQ5O7/mO7lTa4uVVlH/SzI/JLQ
 fGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794408272; x=1795013072;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N+aaUOhs5sub5iinHmy22ebPl8VsWKHnOLxTTINF70U=;
 b=d/YeNiGMZ5RPWkPgacvFsMHQNxmAfIvVvXiSDkYzyGm8maLWRTZdrAPP0OPNNtcGYY
 UNTVq14XFdHWzRlJT84+SIkQ9O7JMENY3/wxya7KoUqHgkMB0zyrU0oX+WqHCdocv9z3
 nvp9cYFo3Fw+kpqYKqwGeeNcsso3nLNCV9zkM03gTuZGQgZWzTOCfyf9U/wzIpWuZ+uO
 zjoY6o2G9i0tOlNaps2aTS51jz+LtnZ0clpNgl+1NeS8mlIo78gdNEKogjgsCmbnykIn
 ZUWI1olxeYnCbAf8/TFQqipgrNkzUKS6EFJ60a6nRNj0nqq2NRTpZst8U+btjJCe7F5a
 imUQ==
X-Gm-Message-State: APuU4Z+qlTYdYopIK5mweAGbnU/mXTA2tlO4MQkLPUSwtnzvqKroXrTA
 LUwxCjAj/i+luHnN263TuLdvpVwPD6Fo5/E6mP3XmWwOJcEq/w+lUbHTbtA0t66BokQ6EQl8nVp
 cVdgqVnwJ0RKNRNz2jwKW2xJ5k6gRHd8=
X-Gm-Gg: AYBFou0zs/LlEchDN9JMuX34yyO7ERoCeYpYdQIG/VQS+VFAG0K3IISC68aLh22mxTk
 jLSitGmIGNifMziVF9euNC28kA6eOQ+kQcCQK8rXI9HPj4t6fN2/vFpTqBqPeGg3Ha9gFWR9Wyq
 3XfKDgQlnx9wQwAksqaQ3pdgGSpXRWh9amTGZVN81fJY6Rh2zJ3A2HQL4LaJ/8hbBOYKWVwEpjR
 DdyvnJMJcHYOECeFxkFoIwXondGr1X5QORBkRHul7wghwhh1+uapAG3yyQX5MeObc3y6rVeXkKT
 +ANy+u22gMdfxhossQ+g5334ix/DE0FGTkc4ntQPC2dSRnYIq7TU14raw/A709sUVQAbz0S237L
 PM+l4JTij3uohUiWMTEAi7eBotVoqU2ZZ18MZ7gWJXBbiW29DE1+uj//gUrWkYFeo6JWu0iJgb2
 4+8w5T0OdWB7ujhNYY1ZZrv6sln2edc+akwqOBFWIGHHj/87/y2sb2f8rvb+asmth4wEnoeQ380
 AyiZn+h
X-Received: by 2002:a05:7022:5f1c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1b3c02e9530mr3280193c88.2.1794408271600; Wed, 11 Nov 2026
 06:44:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109165009.763473-1-mario.limonciello@amd.com>
In-Reply-To: <20261109165009.763473-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 09:44:19 -0500
X-Gm-Features: AclHuK_U8bJhmQ9UcaPBDMQKdc2d818EXdwV7hJL4X-SU6TeLZf6slbh1qFkT1Q
Message-ID: <CADnq5_NVNFZ6id_KCnbR6Y0AZBDyLP=K4t0qVTXj=_3DaMaNAQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Select the firmware signing scheme the PSP
 reports
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 11:56=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Some platforms ship BIOS with either a default or an alternative trust
> authority, so firmware for every IP must be signed with the matching
> scheme.
> The PSP advertises which one is in use in bit 6 of C2PMSG_63, and in bit =
28
> whether this is a preproduction part, which needs firmware of its own.
>
> Add amdgpu_psp_init_fw_variant() which reads those bits through amdgpu's
> own MMIO, and keep the result in adev->firmware.sign_type and
> adev->firmware.preprod next to load_type. It is initialized once, after I=
P
> discovery has populated the register bases and only when firmware is load=
ed
> through the front door (the PSP). Only MP0 15.0.0 reports it. For all oth=
er
> ASICs, SR-IOV VFs and an inaccessible register (all ones) the defaults ar=
e
> kept: AMDGPU_FW_SIGN_DEFAULT and not preproduction. A preproduction part
> that also reports the alternative scheme is not expected, so warn about i=
t
> and use the default firmware.
>
> Firmware for preproduction parts is named with a "_p" suffix before the
> extension and firmware for the alternative scheme with an "_l" suffix (e.=
g.
> "foo.bin" becomes "foo_p.bin" or "foo_l.bin"). Production parts on the
> default scheme use the plain names. Do the substitution centrally in
> amdgpu_ucode_request() so it covers every IP that loads firmware through =
it
> (PSP, SMU, DMUB, GC, IMU, MES, SDMA, VCN, VPE, ...) without each loader
> having to care. There is no fallback to the default file: it would be
> rejected anyway. Declare the variants of the Medusa IPs with
> MODULE_FIRMWARE() so that initramfs generators include them.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Cover PSP 15.0.9 too.
>  * Cover MODULE_FIRMWARE declarations for more files.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 32 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 25 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  7 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 16 ++++++++
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  4 ++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  4 ++
>  drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 37 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  2 +
>  drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  2 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  2 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  2 +
>  15 files changed, 143 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index c170bf3b61281..799a76e1cfe77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2098,6 +2098,10 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>                         amdgpu_ip_version((adev), GC_HWIP, 0) =3D=3D IP_V=
ERSION(9, 4, 4);
>         }
>
> +       /* Needs the register bases, and must be known before requesting =
firmware */
> +       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)
> +               amdgpu_psp_init_fw_variant(adev);
> +
>         total =3D true;
>         for (i =3D 0; i < adev->num_ip_blocks; i++) {
>                 ip_block =3D &adev->ip_blocks[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index c0ed3e24b6840..4f060666f12a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -403,6 +403,38 @@ static uint64_t psp_get_runtime_db_header_pos(struct=
 amdgpu_device *adev)
>         return pos;
>  }
>
> +/*
> + * Which firmware the platform needs, as reported by the PSP in C2PMSG_6=
3: the
> + * signing scheme and whether this is a preproduction part. The defaults=
 are kept if
> + * the ASIC doesn't report it or it can't be read.
> + */
> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev)
> +{
> +       bool alt, preprod;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +
> +       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
> +       case IP_VERSION(15, 0, 0):
> +       case IP_VERSION(15, 0, 9):
> +               if (psp_v15_0_0_get_fw_variant(adev, &alt, &preprod))
> +                       return;
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       if (alt && preprod) {
> +               drm_warn(adev_to_drm(adev),
> +                        "Preproduction part with alternative signing, us=
ing default firmware\n");
> +               return;
> +       }
> +
> +       adev->firmware.sign_type =3D alt ? AMDGPU_FW_SIGN_ALT : AMDGPU_FW=
_SIGN_DEFAULT;
> +       adev->firmware.preprod =3D preprod;
> +}
> +
>  /*
>   * Helper funciton to query psp runtime database entry
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index 975d123593588..9b04e51f589ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -631,6 +631,7 @@ int psp_ta_invoke(struct psp_context *psp,
>
>  int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data,=
 bool load_ta);
>  bool psp_is_xgmi_ta_supported(struct psp_context *psp);
> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev);
>  int psp_xgmi_terminate(struct psp_context *psp);
>  int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
>  int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.c
> index d2ce526dd95cc..eeb056dcad2c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1527,6 +1527,27 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_=
device *adev, int block_type,
>         snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev=
);
>  }
>
> +/* Add the suffix of the firmware variant before the extension: foo.bin =
-> foo_l.bin */
> +static int amdgpu_ucode_set_suffix(struct amdgpu_device *adev, char *fna=
me, size_t size)
> +{
> +       const char *suffix =3D ".bin";
> +       size_t len =3D strlen(fname), base;
> +
> +       if (adev->firmware.preprod)
> +               suffix =3D "_p.bin";
> +       else if (adev->firmware.sign_type =3D=3D AMDGPU_FW_SIGN_ALT)
> +               suffix =3D "_l.bin";
> +
> +       if (len < strlen(".bin") || strcmp(fname + len - strlen(".bin"), =
".bin"))
> +               return 0;
> +
> +       base =3D len - strlen(".bin");
> +       if (strscpy(fname + base, suffix, size - base) < 0)
> +               return -EOVERFLOW;
> +
> +       return 0;
> +}
> +
>  /*
>   * amdgpu_ucode_request - Fetch and validate amdgpu microcode
>   *
> @@ -1555,6 +1576,10 @@ int amdgpu_ucode_request(struct amdgpu_device *ade=
v, const struct firmware **fw,
>                 return -EOVERFLOW;
>         }
>
> +       r =3D amdgpu_ucode_set_suffix(adev, fname, sizeof(fname));
> +       if (r)
> +               return r;
> +
>         if (required =3D=3D AMDGPU_UCODE_REQUIRED)
>                 r =3D request_firmware(fw, fname, adev->dev);
>         else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.h
> index 7c809692807fc..a77758c07be23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -571,6 +571,11 @@ enum amdgpu_firmware_load_type {
>         AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
>  };
>
> +enum amdgpu_firmware_sign_type {
> +       AMDGPU_FW_SIGN_DEFAULT =3D 0,
> +       AMDGPU_FW_SIGN_ALT,
> +};
> +
>  enum amdgpu_ucode_required {
>         AMDGPU_UCODE_OPTIONAL,
>         AMDGPU_UCODE_REQUIRED,
> @@ -606,6 +611,8 @@ struct amdgpu_firmware_info {
>  struct amdgpu_firmware {
>         struct amdgpu_firmware_info ucode[AMDGPU_UCODE_ID_MAXIMUM];
>         enum amdgpu_firmware_load_type load_type;
> +       enum amdgpu_firmware_sign_type sign_type;
> +       bool preprod;
>         struct amdgpu_bo *fw_buf;
>         unsigned int fw_size;
>         unsigned int max_ucodes;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 6c12d8aa3c769..1df2725d31e0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -66,6 +66,8 @@
>  #define FIRMWARE_VCN5_0_1              "amdgpu/vcn_5_0_1.bin"
>  #define FIRMWARE_VCN5_0_2              "amdgpu/vcn_5_0_2.bin"
>  #define FIRMWARE_VCN5_3_0              "amdgpu/vcn_5_3_0.bin"
> +#define FIRMWARE_VCN5_3_0_ALT          "amdgpu/vcn_5_3_0_l.bin"
> +#define FIRMWARE_VCN5_3_0_PREPROD      "amdgpu/vcn_5_3_0_p.bin"
>
>  MODULE_FIRMWARE(FIRMWARE_RAVEN);
>  MODULE_FIRMWARE(FIRMWARE_PICASSO);
> @@ -95,6 +97,8 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
>  MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
>  MODULE_FIRMWARE(FIRMWARE_VCN5_0_2);
>  MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_ALT);
> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_PREPROD);

Are there really 3 different FW variants?  I thought there were just 2.

Alex

>
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>  static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5d068a9d9c72c..3d82cfbd14f17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -134,13 +134,29 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_p.bin");
>
>  static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] =3D {
>         SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/imu_v11_0.c
> index 09dc01a425d13..a409911939d38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -44,7 +44,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_p.bin");
>
>  static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 60b27278a598b..e9778f950738a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -61,7 +61,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v15_0.c
> index abaa40b6def90..148d62e68225b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> @@ -32,11 +32,19 @@
>  #include "mp/mp_15_0_0_sh_mask.h"
>
>  MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_p.bin");
>  MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_p.bin");
>  MODULE_FIRMWARE("amdgpu/psp_15_0_5_toc.bin");
>  MODULE_FIRMWARE("amdgpu/psp_15_0_5_ta.bin");
>  MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_p.bin");
>  MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_p.bin");
>
>  #define regMPASP_PCRU0_MPASP_C2PMSG_64                                  =
       0x4280
>  #define regMPASP_PCRU0_MPASP_C2PMSG_64_BASE_IDX                         =
       2
> @@ -108,6 +116,35 @@ static int psp_v15_0_0_ring_stop(struct psp_context =
*psp,
>         return ret;
>  }
>
> +/*
> + * C2PMSG_63 bit 6: 0 =3D default firmware signing, 1 =3D alternative
> + * C2PMSG_63 bit 28: 0 =3D production part, 1 =3D preproduction part
> + */
> +#define PSP_V15_0_0_FW_SIGN_ALT                BIT(6)
> +#define PSP_V15_0_0_FW_PREPROD         BIT(28)
> +
> +int psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev, bool *alt, bo=
ol *preprod)
> +{
> +       u32 val;
> +
> +       if (!adev->reg_offset[MP0_HWIP][0])
> +               return -ENODEV;
> +
> +       val =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_63);
> +       if (val =3D=3D 0xffffffff) {
> +               drm_warn(adev_to_drm(adev), "Unable to access regMPASP_SM=
N_C2PMSG_63\n");
> +               return -EIO;
> +       }
> +
> +       *alt =3D !!(val & PSP_V15_0_0_FW_SIGN_ALT);
> +       *preprod =3D !!(val & PSP_V15_0_0_FW_PREPROD);
> +       dev_info(adev->dev, "PSP firmware: %s signing, %s part (C2PMSG_63=
=3D0x%08x)\n",
> +                *alt ? "alternative" : "default",
> +                *preprod ? "preproduction" : "production", val);
> +
> +       return 0;
> +}
> +
>  static int psp_v15_0_0_ring_create(struct psp_context *psp,
>                                  enum psp_ring_type ring_type)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h b/drivers/gpu/drm/amd=
/amdgpu/psp_v15_0.h
> index ebd612103526f..2915ddcfff312 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> @@ -26,5 +26,6 @@
>  #include "amdgpu_psp.h"
>
>  void psp_v15_0_0_set_psp_funcs(struct psp_context *psp);
> +int psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev, bool *alt, bo=
ol *preprod);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 4845588c4c247..2586d49f1e940 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -56,6 +56,8 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_l.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_p.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_6_4_0.bin");
>
>  #define SDMA1_REG_OFFSET 0x600
> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vpe_v2_0.c
> index c92c5fc59aeb9..cefb8d739faf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> @@ -31,6 +31,8 @@
>  #include "vpe/vpe_2_0_0_sh_mask.h"
>
>  MODULE_FIRMWARE("amdgpu/vpe_2_0_0.bin");
> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_l.bin");
> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_p.bin");
>  MODULE_FIRMWARE("amdgpu/vpe_2_2_0.bin");
>
>  #define VPE_THREAD1_UCODE_OFFSET       0x8000
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> index 0ea8f9a582ccc..b28d67b4e70aa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> @@ -62,6 +62,8 @@ MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
>  MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
>  MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
>  MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_ALT);
> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_PREPROD);
>  MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
>  MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> index df3e776c1ad14..219e9c0427441 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> @@ -61,6 +61,8 @@ int dm_init_microcode(struct amdgpu_device *adev);
>  #define FIRMWARE_DCN_36_DMUB           "amdgpu/dcn_3_6_dmcub.bin"
>  #define FIRMWARE_DCN_401_DMUB          "amdgpu/dcn_4_0_1_dmcub.bin"
>  #define FIRMWARE_DCN_42_DMUB           "amdgpu/dcn_4_2_dmcub.bin"
> +#define FIRMWARE_DCN_42_DMUB_ALT       "amdgpu/dcn_4_2_dmcub_l.bin"
> +#define FIRMWARE_DCN_42_DMUB_PREPROD   "amdgpu/dcn_4_2_dmcub_p.bin"
>  #define FIRMWARE_DCN_42B_DMUB          "amdgpu/dcn_4_2_1_dmcub.bin"
>  #define FIRMWARE_DCN_60_DMUB           "amdgpu/dcn_6_0_0_dmcub.bin"
>  #define FIRMWARE_RAVEN_DMCU            "amdgpu/raven_dmcu.bin"
> --
> 2.56.0
>
