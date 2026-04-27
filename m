Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4642EFF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 15:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C4A10E079;
	Mon, 27 Apr 2026 15:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YrMOKJep";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C523A10E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:35:30 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12c7288cfb9so253450c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777304130; cv=none;
 d=google.com; s=arc-20240605;
 b=BsddYUnCDLr+/SStqv4keDhU6xhzbV9HMhBp8xwxCEfeu7eZldvP16MGJee3H6mN7f
 A95lfpwN87UPueOfd2Hpy53xzWbMQg/qG0OZlo7ZBSU6kdvYHGW9+SIsBt7v+2IxFkfg
 ONqr7HPc64Jb03us5C0ZVtNmMEWZ0w0+qaTUIfsgqjyBzBl1Qfm2uUUsfhJXzlCQcJJC
 Qzsg9FNn7UcSzeQJf4O8GQj9357OufMj97G2DxScS2ZDVagKYSbH2TvyVfULwEX7pUjw
 iB5YdboqM3zZpvEpniUCIUq+kREGLmibKw2kYMEV5Y8bglww2XvaV4Tim+pMgOP2kE21
 T1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dUG1owCtdaqvig85KQ2IbO2Vel9OdhWCiDXK2J0e7Ag=;
 fh=s6Kc2U++VwxK292YD97FYJXbuW+ltm04ITpsis9l5mw=;
 b=XGkgNBT7VTWkOC88xnchOveT5ag1vhoWKr9B7gaNl1RC9/9trHhto65p7eyTji6vMP
 Pat9yYopobx8SpFSamELAXrKAdSlt3PoaruJKW5Jnpr+8nHe38eSZmiqJMTG6bTp86Wq
 7HslVZiU4X4DTjnxOG2PjTN8WZy+2/hfuXOfTnXurXgqCIJSW3VKo83QCzS03OGGZF8C
 Lt0/+DADivYxupUY2FivChGqsrMhENxOELPAHw+DWnn+Z6Z31MgphW/fSDRECvTYyJKR
 Ij8i+V3KDfyT9JvYHJzMeZpu5H8p8CxKjokK5pLD98cfDcbplhL1fWt41rO+oQvk58hN
 U9zg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777304130; x=1777908930; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUG1owCtdaqvig85KQ2IbO2Vel9OdhWCiDXK2J0e7Ag=;
 b=YrMOKJeprzmzLF3ajmaRguRSNAwh6dEsMC9TYazuXO06iQyhKm9a8dVfu0h9M5nRll
 /15FlVqRVVqS273JGaUvaPalcOUAI3ELcjoTySW5pibag22RnWFw5D5YnuuuPKAOEevZ
 LObT+aKb+VwvTqyBVztz2OfrLQYhtxjzL32CrOPUUxb35itHdzDgSZFe2LIHwl8Tte3m
 TlqCzKUkQkYJsViczB7Ed+ht8XVRDOfhYXi8g6bvGvPQOko5v9f6qiCMBdwIAA7K8nuN
 YWW0+hc2sCQtLYuMuSzsFMKe4MnQnSKJHczOGjLcDMUekn89rQFusibJ8sWp2L6du7ww
 vEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777304130; x=1777908930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dUG1owCtdaqvig85KQ2IbO2Vel9OdhWCiDXK2J0e7Ag=;
 b=O1D83o74Yo2kJLGWXjszWPNDLTA8yKp67F0Sxtww5xwH/wAlH0K9h3TRevxF0juCkQ
 JLEDClnOBkenxUbjrLMssZsmaGssgTkCPaRYeybsurkM1wBf3g40BcrepAaQD+FtWHHy
 awsLfgWmQj4SBBiMdmrdSDgOuZkU7qJ2jOzwG2xsYZ1g/bn8TaV7+vEAS3/i9fIgbczf
 g+CgLJwUEF7aOfCInnTZ7l5AbIwN4QgDiRdPzmNquFSNqzM9eI1mMBulTecdlqSGKwUt
 8X7xugfho5Rd2C7jO08wtNAH/4ZH7gNeVwmgIBUgKC5riU6yy2TkQqoUQZmEZX6Qv1oK
 ucgg==
X-Gm-Message-State: AOJu0Yxe0b/DzSUm3DNhL/rPHxDEhw+Qd6kvV/xHVawAZU6cjX3jyBSQ
 sHmSE97YefZ1Zqp3wvVuFCyt3/uWjOGCyVVFV7oHiETRtxmCY/oGI2dtCFzZ9M6PTyB77SI0JPh
 uxgyJRgJYp2UpgogYNcikRADRjbd5lZc=
X-Gm-Gg: AeBDieucI/+KAsJY1oa0nsX6DZlVeCZg2A5upiqHaYaTmoPU0bLC+pbVF+DXMhTIz74
 l4WobGOUvDY+cyrcolmNB08AVMTvV74dpTPpa7PQ3PlTDzrTSty9nCJZ1blQCMjmvjd/68dIGDF
 cWqKtnjrla/SYURasUcLq+eLiZclV0pJ6NLL7dZiqsO1lrFc5EnwTYpiT/WenhfWaEwcHGrMHMi
 vouDgATHj9fRI8deES42OgzHssZ1yx7jmEz0JW92OzzdR73K0Iqm3yAQ9MIjooqx9j7C5PF1q5W
 17Y3du6yAMRMTko1STDQK5XSChMSG65rYeMWhsTVM5aO6D1sP1rQ/sStc+WKuk3NfQoArpeGDiV
 sOVj0
X-Received: by 2002:a05:7022:2527:b0:12c:897a:5219 with SMTP id
 a92af1059eb24-12c897a58a8mr7198254c88.5.1777304129734; Mon, 27 Apr 2026
 08:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260427152248.1349143-1-yinjie.yao@amd.com>
In-Reply-To: <20260427152248.1349143-1-yinjie.yao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Apr 2026 11:35:18 -0400
X-Gm-Features: AVHnY4Lu5VCcO95yGsSF7-j-HmqE83Qh5RlejX1PyrO8ZqCVsZE7P5rwmP60yPw
Message-ID: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/vcn: set no_user_fence for VCN v2-v5
 enc/dec rings
To: Yinjie Yao <yinjie.yao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Leo.Liu@amd.com, Alexander.Deucher@amd.com, 
 Ruijing.Dong@amd.com, Christian.Koenig@amd.com
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

On Mon, Apr 27, 2026 at 11:24=E2=80=AFAM Yinjie Yao <yinjie.yao@amd.com> wr=
ote:
>
> VCN encoder and decoder rings do not support 64-bit user fence writes,
> reject CS submissions with user fences.
>
> Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>

Can you split these per IP version?  That will make it easier to
backport.  Same for the JPEG changes.  Ideally also with a Fixes tag.
WIth that fixed, the patches are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 2 ++
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 2 ++
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 3 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 1 +
>  9 files changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index e35fae9cdaf6..0442bfcfd384 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -2113,6 +2113,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs =
=3D {
>  static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_DEC,
>         .align_mask =3D 0xf,
> +       .no_user_fence =3D true,
>         .secure_submission_supported =3D true,
>         .get_rptr =3D vcn_v2_0_dec_ring_get_rptr,
>         .get_wptr =3D vcn_v2_0_dec_ring_get_wptr,
> @@ -2145,6 +2146,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_=
ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> +       .no_user_fence =3D true,
>         .get_rptr =3D vcn_v2_0_enc_ring_get_rptr,
>         .get_wptr =3D vcn_v2_0_enc_ring_get_wptr,
>         .set_wptr =3D vcn_v2_0_enc_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 006a15451197..8b8184fe6764 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1778,6 +1778,7 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgp=
u_ring *ring)
>  static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_DEC,
>         .align_mask =3D 0xf,
> +       .no_user_fence =3D true,
>         .secure_submission_supported =3D true,
>         .get_rptr =3D vcn_v2_5_dec_ring_get_rptr,
>         .get_wptr =3D vcn_v2_5_dec_ring_get_wptr,
> @@ -1879,6 +1880,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_=
ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> +       .no_user_fence =3D true,
>         .get_rptr =3D vcn_v2_5_enc_ring_get_rptr,
>         .get_wptr =3D vcn_v2_5_enc_ring_get_wptr,
>         .set_wptr =3D vcn_v2_5_enc_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 6fb4fcdbba4f..4924da5af5e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1856,6 +1856,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_=
sw_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_DEC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_DEC_SW_CMD_NO_OP,
> +       .no_user_fence =3D true,
>         .secure_submission_supported =3D true,
>         .get_rptr =3D vcn_v3_0_dec_ring_get_rptr,
>         .get_wptr =3D vcn_v3_0_dec_ring_get_wptr,
> @@ -2036,6 +2037,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct a=
mdgpu_cs_parser *p,
>  static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_DEC,
>         .align_mask =3D 0xf,
> +       .no_user_fence =3D true,
>         .secure_submission_supported =3D true,
>         .get_rptr =3D vcn_v3_0_dec_ring_get_rptr,
>         .get_wptr =3D vcn_v3_0_dec_ring_get_wptr,
> @@ -2138,6 +2140,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_=
ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> +       .no_user_fence =3D true,
>         .get_rptr =3D vcn_v3_0_enc_ring_get_rptr,
>         .get_wptr =3D vcn_v3_0_enc_ring_get_wptr,
>         .set_wptr =3D vcn_v3_0_enc_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 5dec92691f73..bbdd017cbafb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1994,6 +1994,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ri=
ng_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> +       .no_user_fence =3D true,
>         .extra_bytes =3D sizeof(struct amdgpu_vcn_rb_metadata),
>         .get_rptr =3D vcn_v4_0_unified_ring_get_rptr,
>         .get_wptr =3D vcn_v4_0_unified_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index ff3013b97abd..10e8fc2821f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1775,6 +1775,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_un=
ified_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> +       .no_user_fence =3D true,
>         .get_rptr =3D vcn_v4_0_3_unified_ring_get_rptr,
>         .get_wptr =3D vcn_v4_0_3_unified_ring_get_wptr,
>         .set_wptr =3D vcn_v4_0_3_unified_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index 1f6a22983c0d..1571cc5a148c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1483,6 +1483,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_5_unified_=
ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> +       .no_user_fence =3D true,
>         .get_rptr =3D vcn_v4_0_5_unified_ring_get_rptr,
>         .get_wptr =3D vcn_v4_0_5_unified_ring_get_wptr,
>         .set_wptr =3D vcn_v4_0_5_unified_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 6109124f852e..d5f49fa33bee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1207,6 +1207,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_un=
ified_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> +       .no_user_fence =3D true,
>         .get_rptr =3D vcn_v5_0_0_unified_ring_get_rptr,
>         .get_wptr =3D vcn_v5_0_0_unified_ring_get_wptr,
>         .set_wptr =3D vcn_v5_0_0_unified_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_1.c
> index c28c6aff17aa..54fbf8d73ca6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -1419,6 +1419,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_un=
ified_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> +       .no_user_fence =3D true,
>         .get_rptr =3D vcn_v5_0_1_unified_ring_get_rptr,
>         .get_wptr =3D vcn_v5_0_1_unified_ring_get_wptr,
>         .set_wptr =3D vcn_v5_0_1_unified_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_2.c
> index c3d3cc023058..bbc172db91a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -994,6 +994,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_2_unif=
ied_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> +       .no_user_fence =3D true,
>         .get_rptr =3D vcn_v5_0_2_unified_ring_get_rptr,
>         .get_wptr =3D vcn_v5_0_2_unified_ring_get_wptr,
>         .set_wptr =3D vcn_v5_0_2_unified_ring_set_wptr,
> --
> 2.43.0
>
