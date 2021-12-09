Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ADAC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFB510EF57;
	Thu,  9 Dec 2021 16:55:08 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5FE210E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 16:02:00 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 n17-20020a9d64d1000000b00579cf677301so6635198otl.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Dec 2021 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=V30SLukSq2//sQY295Sane2rkypJRsKCVpvIfJ75ozA=;
 b=AgdXwAK75YYbXJ6lvLsuOZANWK8u5WMBp0hARBVh8JAW3Bim8VO0XaHM7+AgifFGHO
 YMYABU6iWY0VXH5gvGYgyMBZV8Joc/yHM/Rz0ogULD80Pg9EvKzgyX80MHWpPh90Cry4
 pEyOZ9Yo7P80dzDX/Mwb5Y1Gu/306wciRCx6vfOsXH2soznIkSQYdPfd5JMxJCdpko2l
 +nYFbazix5t1mnyFrvPBagX3rr4y9L5auRNw+QvPnzwDzRR3D0kQJRPXtUt2DJG2xT93
 WdtsY0rB3/keAqQFSlxIMPcUIE+bV5pIASRfrsds5zmrURjdDveVexyWL/UUXHQfmqnK
 SQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V30SLukSq2//sQY295Sane2rkypJRsKCVpvIfJ75ozA=;
 b=u7lGWxJy9q5e+nC6NHYuPpCsWbGEJr8IOEIBog5IPsrzJLsfDq4vmVeOgGrCJ2315Z
 DLGkidnIhTIyz7odgYj53vZcr72z/qj8fXM0WKDG1LSH8W8g7ePXkNFRmlup3jdtQKAz
 +qjA3ysycoahnYwfXgglaMt97f0vcxUFTqxHtO6lCWiU2AW4UG1T4bo4i8G86lcRv2Or
 NlpVhkCJneN4qsNRNtPC4wb7IAlCWrpbTkBZ4fNo2H4z+7DcQXnxlORwhsBFayQ1gHa3
 AphWvSXX1VI5Tgkf/FppLeAQdqkXDs/ZAf+COUG71otghzG4n3EPhYOGGFWNd9E7muu4
 2+zg==
X-Gm-Message-State: AOAM533jxFK7FnESY3sIyQOiGpb2j1AL1kiG3YXZeN2mvgA4h4pLYQiT
 VHmbve+t7GsweUZ7ZI2WdUTWLHZtDEF72AaJqyg=
X-Google-Smtp-Source: ABdhPJzINeqcnc+qFakbHmikoSfMT0y0BBuQIV8oqyGE34CFa/Rk+99My5wfwk1HJHYkE6JpEyRG5g2y84a6x7ooNdM=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr6255093ota.200.1639065719716; 
 Thu, 09 Dec 2021 08:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20211209051822.1163450-1-Yuliang.Shi@amd.com>
In-Reply-To: <20211209051822.1163450-1-Yuliang.Shi@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Dec 2021 11:01:48 -0500
Message-ID: <CADnq5_MRBPn=5yRY-UrF43vDqnFdNofv-hNhY_885RCyoRM3Fw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix incorrect VCN revision in SRIOV
To: Leslie Shi <Yuliang.Shi@amd.com>
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
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, "Chen, Guchun" <guchun.chen@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 9, 2021 at 12:18 AM Leslie Shi <Yuliang.Shi@amd.com> wrote:
>
> Guest OS will setup VCN instance 1 which is disabled as an enabled instan=
ce and
> execute initialization work on it, but this causes VCN ib ring test failu=
re
> on the disabled VCN instance during modprobe:
>
> amdgpu 0000:00:08.0: amdgpu: ring vcn_enc_1.0 uses VM inv eng 5 on hub 1
> amdgpu 0000:00:08.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test =
failed on vcn_dec_0 (-110).
> amdgpu 0000:00:08.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test =
failed on vcn_enc_0.0 (-110).
> [drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERROR* ib ring te=
st failed (-110).
>
> v2: drop amdgpu_discovery_get_vcn_version and rename sriov_config to
> vcn_config
>
> Fixes: 36b7d5646476 ("drm/amdgpu: handle SRIOV VCN revision parsing")
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 +++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 15 ++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  2 +-
>  4 files changed, 8 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 552031950518..53ff1bbe8bd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -380,6 +380,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_devi=
ce *adev)
>                                   ip->revision);
>
>                         if (le16_to_cpu(ip->hw_id) =3D=3D VCN_HWID) {
> +                               adev->vcn.vcn_config[adev->vcn.num_vcn_in=
st] =3D
> +                                       ip->revision & 0xc0;
> +
>                                 if (amdgpu_sriov_vf(adev)) {

We can probably just drop the conditional here and just clear the high
bits for everything.

Alex

>                                         /* SR-IOV modifies each VCN=E2=80=
=99s revision (uint8)
>                                          * Bit [5:0]: original revision v=
alue
> @@ -388,8 +391,6 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_devi=
ce *adev)
>                                          *     0b10 : encode is disabled
>                                          *     0b01 : decode is disabled
>                                          */
> -                                       adev->vcn.sriov_config[adev->vcn.=
num_vcn_inst] =3D
> -                                               (ip->revision & 0xc0) >> =
6;
>                                         ip->revision &=3D ~0xc0;
>                                 }
>                                 adev->vcn.num_vcn_inst++;
> @@ -485,14 +486,6 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_de=
vice *adev, int hw_id, int n
>         return -EINVAL;
>  }
>
> -
> -int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn=
_instance,
> -                                    int *major, int *minor, int *revisio=
n)
> -{
> -       return amdgpu_discovery_get_ip_version(adev, VCN_HWID,
> -                                              vcn_instance, major, minor=
, revision);
> -}
> -
>  void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>  {
>         struct binary_header *bhdr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.h
> index 0ea029e3b850..14537cec19db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -33,8 +33,6 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *=
adev);
>  int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_i=
d, int number_instance,
>                                      int *major, int *minor, int *revisio=
n);
>
> -int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn=
_instance,
> -                                    int *major, int *minor, int *revisio=
n);
>  int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 2658414c503d..38036cbf6203 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -284,20 +284,13 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_rin=
g_type type, uint32_t vcn_instance)
>  {
>         bool ret =3D false;
> +       int vcn_config =3D adev->vcn.vcn_config[vcn_instance];
>
> -       int major;
> -       int minor;
> -       int revision;
> -
> -       /* if cannot find IP data, then this VCN does not exist */
> -       if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, =
&minor, &revision) !=3D 0)
> -               return true;
> -
> -       if ((type =3D=3D VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE=
_DISABLE_MASK)) {
> +       if ((type =3D=3D VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCO=
DE_DISABLE_MASK)) {
>                 ret =3D true;
> -       } else if ((type =3D=3D VCN_DECODE_RING) && (revision & VCN_BLOCK=
_DECODE_DISABLE_MASK)) {
> +       } else if ((type =3D=3D VCN_DECODE_RING) && (vcn_config & VCN_BLO=
CK_DECODE_DISABLE_MASK)) {
>                 ret =3D true;
> -       } else if ((type =3D=3D VCN_UNIFIED_RING) && (revision & VCN_BLOC=
K_QUEUE_DISABLE_MASK)) {
> +       } else if ((type =3D=3D VCN_UNIFIED_RING) && (vcn_config & VCN_BL=
OCK_QUEUE_DISABLE_MASK)) {
>                 ret =3D true;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 938a5ead3f20..5d3728b027d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -235,7 +235,7 @@ struct amdgpu_vcn {
>
>         uint8_t num_vcn_inst;
>         struct amdgpu_vcn_inst   inst[AMDGPU_MAX_VCN_INSTANCES];
> -       uint8_t                  sriov_config[AMDGPU_MAX_VCN_INSTANCES];
> +       uint8_t                  vcn_config[AMDGPU_MAX_VCN_INSTANCES];
>         struct amdgpu_vcn_reg    internal;
>         struct mutex             vcn_pg_lock;
>         struct mutex            vcn1_jpeg1_workaround;
> --
> 2.25.1
>
