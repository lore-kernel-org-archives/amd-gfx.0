Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32F2CA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 16:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5413A10E03C;
	Tue, 12 Aug 2025 16:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eJ8YwLgp";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71EF810E03C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 16:09:03 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2400a0c3cf7so8341535ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 09:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755014943; x=1755619743; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CuwZhayvbD7WWgkVgR2Ghkmi4v5seLTMHIINyCXKtV8=;
 b=eJ8YwLgphxlYEn6P8vMSTIlKCFxtt3/nXaertcoYdwYTqQ3k+BQ9ULq/n+JK+AQ55c
 3IfLpcnmXVxmIQj1NB5QbOJeX1DNIfy+P+X3NPF9cnE48a7eDJ3ah9FakHZJG34yILPt
 mM1Q4znMfsd9E2Cwf3Uw5+3yEwQBL9YQB4F/MAKelIRYVuxdld/DUuSBFX8hs13z47E4
 huG64dhJYM+G4Gd9UhuGTSobBKmQ+WYXTLU3XOr49ifYzklMmXXyU45LngIoEUas0EPz
 T4bnC+7eM8M2JsQT0/igVfhOuR81oQKAAQ0NY+NiSfIhEVcdehuHVntixTR3njKO1F22
 CMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755014943; x=1755619743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CuwZhayvbD7WWgkVgR2Ghkmi4v5seLTMHIINyCXKtV8=;
 b=I1AnDYgNBJkqzq6BNwRX2utvUUXsidaNiBe34Rudg/avkzvf0tMgMV+TQxMWlJTu0z
 rlbKVAExh8sk76tNyzuZu4V/w7ser/2+JGN04WQMVGxQGIVVXhSyD75OqoBHg94P3lL3
 9C3dGsspjD64MAY+ZZPudi7JtJLaCa3s2sJp43wE9BzAQno8tFGWIcuObdoILwYE549B
 wGEY5Y88iQrx5FnvterBUAO26aawRuIl1404PuuM/pKZNCkPKBjS0PvdA6I7s+mAQ4up
 b4X2Hdr69VI7Mr63S015TcFL4cpiSYjYRp6plP4Yz7ab6/9Tpd+Z7zy+9k4HcY9Aumwz
 THow==
X-Gm-Message-State: AOJu0YzopVdmo6lS3vDhEROybWYJ8lxk/Gam2TRLK4rBt4j2emjUwGdt
 7g+XVm5OBX7N/fieWLAH7vFT2RclW/O83/rX7dDflH7y6Ogaj/AiugASNeme1RPhnKXL6dtpklN
 Vhl3vYk0P1eTtLom0Yh4e0hUDGsTUfjovIA==
X-Gm-Gg: ASbGncvZ4kUMSRriMvG0GRgMTBQA5PBDQg8kU6euMbdRH5Ky8WBRB6Vhwx6dYc9KQTT
 mSDkXfq0yV3QMVBkBpPpizF5ejJq8MdjRKXck8d3+MCxB9cWz0QvAorKtPJqEXH0xnNw+g6rNPQ
 SnFs5wJ99KL31QEC75AJgpfaPy2zI4IXOdCwC7XAwB79g3F6ABWkSriU5AzllqO3ueeZ1LUMPlF
 85SErs=
X-Google-Smtp-Source: AGHT+IGDOgTe3JqxJWHaihh5XuEX21ZrWjEHDQjRfJKr2N5BxydZMEyUBE3DQ7J7OMDQIJetrRYFlrJqNHjB+CZUZjU=
X-Received: by 2002:a17:903:184:b0:240:1879:c2fd with SMTP id
 d9443c01a7336-24306906f98mr14508805ad.2.1755014942640; Tue, 12 Aug 2025
 09:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250812145610.1300497-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250812145610.1300497-1-sathishkumar.sundararaju@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Aug 2025 12:08:50 -0400
X-Gm-Features: Ac12FXx2q1r6ae6rRgrVNV1SPxKhdCXWxUe_JeVVIscYKIrQ2MW5Efoq2fCnQDA
Message-ID: <CADnq5_P=kmQLOyjyGbOcW248TGO52nUNQo2xOK92rBRyPvAmmA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: Fix video_profile switch race condition
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>
Content-Type: multipart/mixed; boundary="0000000000003b64e2063c2d4239"
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

--0000000000003b64e2063c2d4239
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:56=E2=80=AFAM Sathishkumar S
<sathishkumar.sundararaju@amd.com> wrote:
>
> There is a race condition which leads to dpm video power
> profile switch (disable and enable) during active video
> decode on multi-instance VCN hardware.
>
> This patch aims to fix/skip step 3 in the below sequence:
>
>  - inst_1       power_on
>  - inst_0(idle) power_off
>  - inst_0(idle) video_power_profile OFF (step 3)
>  - inst_1       video_power_profile ON during next begin_use
>
> Add flags to track ON/OFF vcn instances and check if all
> instances are off before disabling video power profile.

I think you could also just look at the outstanding fences on the
other instances.  Something like the attached patch.  Either way works
for me.

Alex

>
> Protect workload_profile_active also within pg_lock and ON it
> during first use and OFF it when last VCN instance is powered
> OFF. VCN workload_profile_mutex can be removed after similar
> clean up is done for vcn2_5.
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
>  2 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c18..da372dd7b761 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -445,16 +445,16 @@ static void amdgpu_vcn_idle_work_handler(struct wor=
k_struct *work)
>         if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>                 mutex_lock(&vcn_inst->vcn_pg_lock);
>                 vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> -               mutex_unlock(&vcn_inst->vcn_pg_lock);
> -               mutex_lock(&adev->vcn.workload_profile_mutex);
> -               if (adev->vcn.workload_profile_active) {
> +               adev->vcn.flags &=3D AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst->=
inst);
> +               if (adev->vcn.workload_profile_active &&
> +                   !(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_MASK(adev->=
vcn.num_vcn_inst))) {
>                         r =3D amdgpu_dpm_switch_power_profile(adev, PP_SM=
C_POWER_PROFILE_VIDEO,
>                                                             false);
>                         if (r)
>                                 dev_warn(adev->dev, "(%d) failed to disab=
le video power profile mode\n", r);
>                         adev->vcn.workload_profile_active =3D false;
>                 }
> -               mutex_unlock(&adev->vcn.workload_profile_mutex);
> +               mutex_unlock(&vcn_inst->vcn_pg_lock);
>         } else {
>                 schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIME=
OUT);
>         }
> @@ -470,14 +470,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *r=
ing)
>
>         cancel_delayed_work_sync(&vcn_inst->idle_work);
>
> -       /* We can safely return early here because we've cancelled the
> -        * the delayed work so there is no one else to set it to false
> -        * and we don't care if someone else sets it to true.
> -        */
> -       if (adev->vcn.workload_profile_active)
> -               goto pg_lock;
> +       mutex_lock(&vcn_inst->vcn_pg_lock);
>
> -       mutex_lock(&adev->vcn.workload_profile_mutex);
>         if (!adev->vcn.workload_profile_active) {
>                 r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
>                                                     true);
> @@ -485,11 +479,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)
>                         dev_warn(adev->dev, "(%d) failed to switch to vid=
eo power profile mode\n", r);
>                 adev->vcn.workload_profile_active =3D true;
>         }
> -       mutex_unlock(&adev->vcn.workload_profile_mutex);
>
> -pg_lock:
> -       mutex_lock(&vcn_inst->vcn_pg_lock);
> -       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> +       if (!(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst))=
) {
> +               vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> +               adev->vcn.flags |=3D AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->i=
nst);
> +       }
>
>         /* Only set DPG pause for VCN3 or below, VCN4 and above will be h=
andled by FW */
>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index b3fb1d0e43fc..a876a182ff88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -366,6 +366,10 @@ struct amdgpu_vcn {
>         struct mutex            workload_profile_mutex;
>         u32 reg_count;
>         const struct amdgpu_hwip_reg_entry *reg_list;
> +#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
> +#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
> +#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
> +       u32 flags;
>  };
>
>  struct amdgpu_fw_shared_rb_ptrs_struct {
> --
> 2.48.1
>

--0000000000003b64e2063c2d4239
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-vcn-fix-video-profile-race-condition.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-vcn-fix-video-profile-race-condition.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_me8qde3m0>
X-Attachment-Id: f_me8qde3m0

RnJvbSA2ZGIxOGFjZmE4YWFlMjM5YzM2ZTY3MzYzMDhhZjg4NzA5OTc5NjcxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgMTIgQXVnIDIwMjUgMTE6Mzg6MDkgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L3ZjbjogZml4IHZpZGVvIHByb2ZpbGUgcmFjZSBjb25kaXRpb24KCklmIHRo
ZXJlIGFyZSBtdWx0aXBsZSBpbnN0YW5jZXMgb2YgdGhlIFZDTiBydW5uaW5nLAp3ZSBtYXkgZW5k
IHVwIHN3aXRjaGluZyB0aGUgdmlkZW8gcHJvZmlsZSB3aGlsZSBhbm90aGVyCmluc3RhbmNlIGlz
IGFjdGl2ZSBiZWNhdXNlIHdlIG9ubHkgdGFrZSBpbnRvIGFjY291bnQKdGhlIGN1cnJlbnQgaW5z
dGFuY2UncyBzdWJtaXNzaW9ucy4gIExvb2sgYXQgYWxsCm91dHN0YW5kaW5nIGZlbmNlcyBmb3Ig
dGhlIHZpZGVvIHByb2ZpbGUuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Zjbi5jIHwgMjkgKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE3
IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uYwppbmRleCA5YTc2ZTExZDFjMTg0Li5kY2VjODZkYTZmZDIzIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCkBAIC00MTUsMTkgKzQxNSwyNSBAQCBz
dGF0aWMgdm9pZCBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVj
dCAqd29yaykKIAlzdHJ1Y3QgYW1kZ3B1X3Zjbl9pbnN0ICp2Y25faW5zdCA9CiAJCWNvbnRhaW5l
cl9vZih3b3JrLCBzdHJ1Y3QgYW1kZ3B1X3Zjbl9pbnN0LCBpZGxlX3dvcmsud29yayk7CiAJc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSB2Y25faW5zdC0+YWRldjsKLQl1bnNpZ25lZCBpbnQg
ZmVuY2VzID0gMCwgZmVuY2VbQU1ER1BVX01BWF9WQ05fSU5TVEFOQ0VTXSA9IHswfTsKLQl1bnNp
Z25lZCBpbnQgaSA9IHZjbl9pbnN0LT5pbnN0LCBqOworCXVuc2lnbmVkIGludCB0b3RhbF9mZW5j
ZXMgPSAwLCBmZW5jZVtBTURHUFVfTUFYX1ZDTl9JTlNUQU5DRVNdID0gezB9OworCXVuc2lnbmVk
IGludCBpLCBqOwogCWludCByID0gMDsKIAotCWlmIChhZGV2LT52Y24uaGFydmVzdF9jb25maWcg
JiAoMSA8PCBpKSkKKwlpZiAoYWRldi0+dmNuLmhhcnZlc3RfY29uZmlnICYgKDEgPDwgdmNuX2lu
c3QtPmluc3QpKQogCQlyZXR1cm47CiAKLQlmb3IgKGogPSAwOyBqIDwgYWRldi0+dmNuLmluc3Rb
aV0ubnVtX2VuY19yaW5nczsgKytqKQotCQlmZW5jZVtpXSArPSBhbWRncHVfZmVuY2VfY291bnRf
ZW1pdHRlZCgmdmNuX2luc3QtPnJpbmdfZW5jW2pdKTsKKwlmb3IgKGkgPSAwOyBpIDwgYWRldi0+
dmNuLm51bV92Y25faW5zdDsgKytpKSB7CisJCXN0cnVjdCBhbWRncHVfdmNuX2luc3QgKnYgPSAm
YWRldi0+dmNuLmluc3RbaV07CisKKwkJZm9yIChqID0gMDsgaiA8IHYtPm51bV9lbmNfcmluZ3M7
ICsraikKKwkJCWZlbmNlW2ldICs9IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZ2LT5yaW5n
X2VuY1tqXSk7CisJCWZlbmNlW2ldICs9IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZ2LT5y
aW5nX2RlYyk7CisJCXRvdGFsX2ZlbmNlcyArPSBmZW5jZVtpXTsKKwl9CiAKIAkvKiBPbmx5IHNl
dCBEUEcgcGF1c2UgZm9yIFZDTjMgb3IgYmVsb3csIFZDTjQgYW5kIGFib3ZlIHdpbGwgYmUgaGFu
ZGxlZCBieSBGVyAqLwogCWlmIChhZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX1ZDTl9E
UEcgJiYKLQkgICAgIWFkZXYtPnZjbi5pbnN0W2ldLnVzaW5nX3VuaWZpZWRfcXVldWUpIHsKKwkg
ICAgIXZjbl9pbnN0LT51c2luZ191bmlmaWVkX3F1ZXVlKSB7CiAJCXN0cnVjdCBkcGdfcGF1c2Vf
c3RhdGUgbmV3X3N0YXRlOwogCiAJCWlmIChmZW5jZVtpXSB8fApAQCAtNDM2LDE4ICs0NDIsMTcg
QEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Zjbl9pZGxlX3dvcmtfaGFuZGxlcihzdHJ1Y3Qgd29ya19z
dHJ1Y3QgKndvcmspCiAJCWVsc2UKIAkJCW5ld19zdGF0ZS5md19iYXNlZCA9IFZDTl9EUEdfU1RB
VEVfX1VOUEFVU0U7CiAKLQkJYWRldi0+dmNuLmluc3RbaV0ucGF1c2VfZHBnX21vZGUodmNuX2lu
c3QsICZuZXdfc3RhdGUpOworCQl2Y25faW5zdC0+cGF1c2VfZHBnX21vZGUodmNuX2luc3QsICZu
ZXdfc3RhdGUpOwogCX0KIAotCWZlbmNlW2ldICs9IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVk
KCZ2Y25faW5zdC0+cmluZ19kZWMpOwotCWZlbmNlcyArPSBmZW5jZVtpXTsKLQotCWlmICghZmVu
Y2VzICYmICFhdG9taWNfcmVhZCgmdmNuX2luc3QtPnRvdGFsX3N1Ym1pc3Npb25fY250KSkgewor
CWlmICghZmVuY2VbdmNuX2luc3QtPmluc3RdICYmICFhdG9taWNfcmVhZCgmdmNuX2luc3QtPnRv
dGFsX3N1Ym1pc3Npb25fY250KSkgeworCQkvKiBUaGlzIGlzIHNwZWNpZmljIHRvIHRoaXMgaW5z
dGFuY2UgKi8KIAkJbXV0ZXhfbG9jaygmdmNuX2luc3QtPnZjbl9wZ19sb2NrKTsKIAkJdmNuX2lu
c3QtPnNldF9wZ19zdGF0ZSh2Y25faW5zdCwgQU1EX1BHX1NUQVRFX0dBVEUpOwogCQltdXRleF91
bmxvY2soJnZjbl9pbnN0LT52Y25fcGdfbG9jayk7CiAJCW11dGV4X2xvY2soJmFkZXYtPnZjbi53
b3JrbG9hZF9wcm9maWxlX211dGV4KTsKLQkJaWYgKGFkZXYtPnZjbi53b3JrbG9hZF9wcm9maWxl
X2FjdGl2ZSkgeworCQkvKiB0aGlzIGlzIGdsb2JhbCBhbmQgZGVwZW5kcyBvbiBhbGwgVkNOIGlu
c3RhbmNlcyAqLworCQlpZiAoYWRldi0+dmNuLndvcmtsb2FkX3Byb2ZpbGVfYWN0aXZlICYmICF0
b3RhbF9mZW5jZXMpIHsKIAkJCXIgPSBhbWRncHVfZHBtX3N3aXRjaF9wb3dlcl9wcm9maWxlKGFk
ZXYsIFBQX1NNQ19QT1dFUl9QUk9GSUxFX1ZJREVPLAogCQkJCQkJCSAgICBmYWxzZSk7CiAJCQlp
ZiAocikKLS0gCjIuNTAuMQoK
--0000000000003b64e2063c2d4239--
