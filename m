Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA4AC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 15:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADA210E013;
	Wed, 26 Mar 2025 15:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UFrhJQ8y";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B816110E013
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 15:07:55 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-301317939a0so2009816a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743001675; x=1743606475; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tT5Vf/X5Wh23cy9/dXIXvlNA+gepNKIloX8ZBiXws98=;
 b=UFrhJQ8ymSMELdgNQQNgeYLTDtuGebwq/ITkwrwyCG1BauPDE0GZLUGjexc3hg5XLC
 BBhzJIkOdf3pzjlLO3at2RRYHbyOO3fzJD6vPgnQyPv0ji16aT7J9GE22K9RFps1yxek
 5Q/UNUQEq+ADffoZYcKYj6NGb+Y53f414/QXLNI2KZGs5E94V9QQzPEYP6nHBXCG8fwx
 QlrHgYkKhyFBBlT1GUSLgm5yyiRVlycMqKGc5H4UlDiNgo0ziza+Oiqsy1j+BxQSD1L3
 byoG0iwc4lbiamXPtuseQsOg0AbMGW8lxjgLxPznJPTSZv2UYoaqT6t6tA5To1JP4D43
 D0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743001675; x=1743606475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tT5Vf/X5Wh23cy9/dXIXvlNA+gepNKIloX8ZBiXws98=;
 b=pETkeg2DFb16gh6pd9kJ6FZS2NswMA8CV0QXtGD0ol3flMo1rwjChL5bbdGPXdSqdH
 AYk/rCsRYDtxSSygBpdU+pB3u8AH682gluKu2+72V2utK16zXBlDJel8VdN5vYD88kqg
 llHOTmq8zozm6P2RKTYjmDKMvi6ZH++gYZkjC9O3hSpOrtqJW/KzqZFx0zC6T8y28JEv
 h/ZmljXJYl1HR1sHQOsVQr/JsgejIpVZCMPHnGcyepr9sNmS1aUikAexnlqK0Lsnaxib
 869fno7wv6HTyC7/Lc/cwJl5hMxGrfbj1JSwjwihhD2EkkkZMgUANtaZlzatAOzZofVm
 oPag==
X-Gm-Message-State: AOJu0Yyys90AdXZpDCjWZXgt3JVZrG80Hq8k5k5GILvh3l1qMGE+XhAV
 kRZNvA7HliDRvW2f+v5Ob9oyV3Ru0KzuQWokAav+Ph2rj7UyR9w+6EDWl/iEbdAR4LVpkDFY1aq
 zGjYt6sEIOGKDhGVZhv17EwAFyM8=
X-Gm-Gg: ASbGnctvJ248SDAiVnvMWFQFEQ7yKy4C+fqW7eROmT9g4Hn1x272/rbXOmQ5Apkqtsk
 H1rDhe3Dum6jBopMIKl+lWOaU/79hqNvZ7BBssiqVNGIfoGcf4dVfWg6LM/IPs/xw2X96tsWSEh
 ot1eleGqmAMEydma/PBwVmeubUaw==
X-Google-Smtp-Source: AGHT+IEYtw/7NaJtLP1cF18iSyIdAIpxtFx9plGwe+7RAoA3wEcLSx3oMGFVkYyyZJ9q8/2XV9mqcHvZc3rUQed1dbA=
X-Received: by 2002:a17:90b:4b51:b0:2ff:7c5a:216d with SMTP id
 98e67ed59e1d1-3030ff0e874mr13308353a91.5.1743001674355; Wed, 26 Mar 2025
 08:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250326045650.770578-1-kenneth.feng@amd.com>
In-Reply-To: <20250326045650.770578-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Mar 2025 11:07:42 -0400
X-Gm-Features: AQ5f1JpNclBMDSm891_7Hkwq8uWBFkG-xS-f2TV0zxc5Ung5JqZPHBXeZDMhDzw
Message-ID: <CADnq5_PL8twwX9CMNBKMdyso5U+G_8P4MLXpBTFOoHXZxMOigw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: port the workload profile setting logic
 into dm
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kevinyang.wang@amd.com, 
 alexander.deucher@amd.com, harry.wentland@amd.com
Content-Type: multipart/mixed; boundary="000000000000a4b78206314033fd"
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

--000000000000a4b78206314033fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 1:22=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> Port the workload profile setting logic into dm before MALL optimization.
>
> Background:
> MALL optimization strategy has changed in the firmware.Previously, firmwa=
re does not
> care what workload type it is, once there is a request from DAL for MALL,=
 firmware immediately
> trigger the MALL setting sequence on the SoC, so called D0i3.x idle power=
 sequence.
> Now, before the D0i3.x sequence starts, firmware always check if the work=
load type is default,
> if it is not, then abort the D0i3.x sequence.
>
> Issue:
> Due to this strategy change, the task is moved to driver to make sure if =
gfx is really idle and
> if it is, reset the workload to default. Without this task, when DAL's wo=
rk task for MALL optimization
> tries to do the optimization request to DMCUB->pmfw, the workload type is=
 always 3D fullscreen or compute,
> then MALL will never be applied.
>
> Why:
> The idle task for setting workload type back to default interval is 1 sec=
ond currently. The DAL's work task
> to optimize MALL always starts before the idle task for setting workload =
type back to default. There is no way
> to ask the idle task in the base driver to reset the workload type ahead =
of the DAL's MALL setting work task
> kicks off. There could be a workaround which sets the idle task interval =
to 10 millisecond. However, this causes
> some call trace issues in which the workqueues is flushed.

That should already fixed by this commit:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dde35994ecd2dd6148ab5a6c5050a1670a04dec77

>
> Side effect:
> This solution is to port the logic in idle thread to DAL: check the fence=
 and make sure gfx is idle, then reset the workload
> type. It is fine that when DAL's work task exits the MALL optimization, i=
t does not set back the workload type to 3d fullscreen
> or compute since the work task in base driver can make sure the workload =
type can be set back once there are jobs in the ring.

I guess this works because the workload ref count gets clamped to 0,
but this call is not balanced.  It also doesn't handle the VIDEO
profile that gets set when using VCN or the COMPUTE profile when KFD
queues are active.  Those would also prevent the idle optimizations.
Also what happens if the profile changes after DC optimizations are
enabled?  Does that cause the optimizations to exit or will they stay
intact until DC tells it to exit?

So I think we have two options:
1. always disable the 3D, compute, video profiles when entering the
DAL optimization. subsequently, additional job submissions may change
the workload.  will that be a problem?
2. Add a helper to pause workload profiles while the DC optimization
is active.  If the profile only has to be changed while enabling the
DC optimization, we can just call it right before and right after the
dc optimizations.  Something like the attached patches should be a
good starting point.

Alex

>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 29 ++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 36a830a7440f..2adb3b72ed05 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -244,6 +244,20 @@ static void amdgpu_dm_crtc_vblank_control_worker(str=
uct work_struct *work)
>         struct vblank_control_work *vblank_work =3D
>                 container_of(work, struct vblank_control_work, work);
>         struct amdgpu_display_manager *dm =3D vblank_work->dm;
> +       u32 i, fences =3D 0;
> +       int r;
> +       enum PP_SMC_POWER_PROFILE profile;
> +       struct amdgpu_device *adev =3D drm_to_adev(dm->ddev);
> +
> +       if (adev->gfx.num_gfx_rings)
> +               profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +       else
> +               profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
> +
> +       for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> +               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx_rin=
g[i]);
> +       for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTA=
NCES); ++i)
> +               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.compute=
_ring[i]);
>
>         mutex_lock(&dm->dc_lock);
>
> @@ -271,8 +285,21 @@ static void amdgpu_dm_crtc_vblank_control_worker(str=
uct work_struct *work)
>                         vblank_work->acrtc->dm_irq_params.allow_sr_entry)=
;
>         }
>
> -       if (dm->active_vblank_irq_count =3D=3D 0)
> +       if (dm->active_vblank_irq_count =3D=3D 0) {
> +               if (adev->gfx.num_gfx_rings && !fences && !atomic_read(&a=
dev->gfx.total_submission_cnt)) {
> +                       mutex_lock(&adev->gfx.workload_profile_mutex);
> +                       if (adev->gfx.workload_profile_active) {
> +                               r =3D amdgpu_dpm_switch_power_profile(ade=
v, profile, false);
> +                               if (r)
> +                               dev_warn(adev->dev, "(%d) failed to disab=
le %s power profile mode\n", r,
> +                                                                       p=
rofile =3D=3D PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
> +                                                                       "=
fullscreen 3D" : "compute");
> +                               adev->gfx.workload_profile_active =3D fal=
se;
> +                       }
> +                       mutex_unlock(&adev->gfx.workload_profile_mutex);
> +               }
>                 dc_allow_idle_optimizations(dm->dc, true);
> +       }
>
>         mutex_unlock(&dm->dc_lock);
>
> --
> 2.34.1
>

--000000000000a4b78206314033fd
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-pm-add-workload-profile-pause-helper.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-pm-add-workload-profile-pause-helper.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m8q26mpa1>
X-Attachment-Id: f_m8q26mpa1

RnJvbSBjZjEwODExZmI4YWU0MDQzOTQ4NDYwOWU1ODA4ZmU2ZTQ5OTY5ZjI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMjYgTWFyIDIwMjUgMTA6MjY6MjUgLTA0MDAKU3ViamVjdDogW1BBVENI
IDEvMl0gZHJtL2FtZGdwdS9wbTogYWRkIHdvcmtsb2FkIHByb2ZpbGUgcGF1c2UgaGVscGVyCgpU
byBiZSB1c2VkIGZvciBkaXNwbGF5IGlkbGUgb3B0aW1pemF0aW9ucyB3aGVuCndlIHdhbnQgdG8g
cGF1c2Ugbm9uLWRlZmF1bHQgcHJvZmlsZXMuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogLi4uL2dwdS9kcm0vYW1kL2luY2x1ZGUv
a2dkX3BwX2ludGVyZmFjZS5oICAgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRn
cHVfZHBtLmMgICAgICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X2RwbS5oICAgICAgIHwgIDIgKysKIDMgZmlsZXMgY2hhbmdl
ZCwgMjIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5j
bHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUva2dk
X3BwX2ludGVyZmFjZS5oCmluZGV4IDkxODlkY2I2NTE4ODEuLjQ0MjRhNDRhMmRlZGEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmgKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2tnZF9wcF9pbnRlcmZhY2UuaApAQCAtNDE0
LDYgKzQxNCw3IEBAIHN0cnVjdCBhbWRfcG1fZnVuY3MgewogCWludCAoKnNldF9wcF90YWJsZSko
dm9pZCAqaGFuZGxlLCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBzaXplKTsKIAl2b2lkICgqZGVi
dWdmc19wcmludF9jdXJyZW50X3BlcmZvcm1hbmNlX2xldmVsKSh2b2lkICpoYW5kbGUsIHN0cnVj
dCBzZXFfZmlsZSAqbSk7CiAJaW50ICgqc3dpdGNoX3Bvd2VyX3Byb2ZpbGUpKHZvaWQgKmhhbmRs
ZSwgZW51bSBQUF9TTUNfUE9XRVJfUFJPRklMRSB0eXBlLCBib29sIGVuKTsKKwlpbnQgKCpwYXVz
ZV9wb3dlcl9wcm9maWxlKSh2b2lkICpoYW5kbGUsIGJvb2wgcGF1c2UpOwogLyogZXhwb3J0IHRv
IGFtZGdwdSAqLwogCXN0cnVjdCBhbWRfdmNlX3N0YXRlICooKmdldF92Y2VfY2xvY2tfc3RhdGUp
KHZvaWQgKmhhbmRsZSwgdTMyIGlkeCk7CiAJaW50ICgqZGlzcGF0Y2hfdGFza3MpKHZvaWQgKmhh
bmRsZSwgZW51bSBhbWRfcHBfdGFzayB0YXNrX2lkLApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9k
cG0uYwppbmRleCAwYmNiODJiMmYzYWUwLi4wZTRkMjQzNjQxYzhmIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL2FtZGdwdV9kcG0uYwpAQCAtMzgxLDYgKzM4MSwyNSBAQCBpbnQgYW1kZ3B1X2RwbV9zd2l0
Y2hfcG93ZXJfcHJvZmlsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlyZXR1cm4gcmV0
OwogfQogCitpbnQgYW1kZ3B1X2RwbV9wYXVzZV9wb3dlcl9wcm9maWxlKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAorCQkJCSAgIGJvb2wgcGF1c2UpCit7CisJY29uc3Qgc3RydWN0IGFtZF9w
bV9mdW5jcyAqcHBfZnVuY3MgPSBhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3M7CisJaW50IHJldCA9
IDA7CisKKwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQorCQlyZXR1cm4gMDsKKworCWlmIChw
cF9mdW5jcyAmJiBwcF9mdW5jcy0+cGF1c2VfcG93ZXJfcHJvZmlsZSkgeworCQltdXRleF9sb2Nr
KCZhZGV2LT5wbS5tdXRleCk7CisJCXJldCA9IHBwX2Z1bmNzLT5wYXVzZV9wb3dlcl9wcm9maWxl
KAorCQkJYWRldi0+cG93ZXJwbGF5LnBwX2hhbmRsZSwgcGF1c2UpOworCQltdXRleF91bmxvY2so
JmFkZXYtPnBtLm11dGV4KTsKKwl9CisKKwlyZXR1cm4gcmV0OworfQorCiBpbnQgYW1kZ3B1X2Rw
bV9zZXRfeGdtaV9wc3RhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkgICAgICAg
dWludDMyX3QgcHN0YXRlKQogewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9p
bmMvYW1kZ3B1X2RwbS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X2RwbS5o
CmluZGV4IDcyNTY1ZmFiNjA2NzMuLmRmODg1MGEwMWVhNmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vaW5jL2FtZGdwdV9kcG0uaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL2luYy9hbWRncHVfZHBtLmgKQEAgLTQxMCw2ICs0MTAsOCBAQCBpbnQgYW1kZ3B1X2RwbV9z
ZXRfeGdtaV9wc3RhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiBpbnQgYW1kZ3B1X2Rw
bV9zd2l0Y2hfcG93ZXJfcHJvZmlsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkg
ICAgZW51bSBQUF9TTUNfUE9XRVJfUFJPRklMRSB0eXBlLAogCQkJCSAgICBib29sIGVuKTsKK2lu
dCBhbWRncHVfZHBtX3BhdXNlX3Bvd2VyX3Byb2ZpbGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCisJCQkJICAgYm9vbCBwYXVzZSk7CiAKIGludCBhbWRncHVfZHBtX2JhY29fcmVzZXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogCi0tIAoyLjQ5LjAKCg==
--000000000000a4b78206314033fd
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-drm-amdgpu-pm-swsmu-implement-pause-workload-profile.patch"
Content-Disposition: attachment; 
	filename="0002-drm-amdgpu-pm-swsmu-implement-pause-workload-profile.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m8q26mp20>
X-Attachment-Id: f_m8q26mp20

RnJvbSBlYzVkNmUyMDM3ZmRiMzRjNWRkZTQ3NTU3ZWIyOWMzNTAxNzUyN2QxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMjYgTWFyIDIwMjUgMTA6NTQ6NTYgLTA0MDAKU3ViamVjdDogW1BBVENI
IDIvMl0gZHJtL2FtZGdwdS9wbS9zd3NtdTogaW1wbGVtZW50IHBhdXNlIHdvcmtsb2FkIHByb2Zp
bGUKCkFkZCB0aGUgY2FsbGJhY2sgZm9yIGltcGxlbWVudGF0aW9uIGZvciBzd3NtdS4KClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYyAgICAgfCAzNiArKysrKysr
KysrKysrKysrKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRncHVfc211
LmggfCAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jCmluZGV4IGEwMWI2
MjQ0ZDk5Y2QuLmQyM2NmZDViYThkYzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vc3dzbXUvYW1kZ3B1X3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
YW1kZ3B1X3NtdS5jCkBAIC0yMzk4LDcgKzIzOTgsMTEgQEAgc3RhdGljIGludCBzbXVfc3dpdGNo
X3Bvd2VyX3Byb2ZpbGUodm9pZCAqaGFuZGxlLAogCQkJc211X3Bvd2VyX3Byb2ZpbGVfbW9kZV9n
ZXQoc211LCB0eXBlKTsKIAkJZWxzZQogCQkJc211X3Bvd2VyX3Byb2ZpbGVfbW9kZV9wdXQoc211
LCB0eXBlKTsKLQkJcmV0ID0gc211X2J1bXBfcG93ZXJfcHJvZmlsZV9tb2RlKHNtdSwgTlVMTCwg
MCk7CisJCS8qIGRvbid0IHN3aXRjaCB0aGUgYWN0aXZlIHdvcmtsb2FkIHdoZW4gcGF1c2VkICov
CisJCWlmIChzbXUtPnBhdXNlX3dvcmtsb2FkKQorCQkJcmV0ID0gMDsKKwkJZWxzZQorCQkJcmV0
ID0gc211X2J1bXBfcG93ZXJfcHJvZmlsZV9tb2RlKHNtdSwgTlVMTCwgMCk7CiAJCWlmIChyZXQp
IHsKIAkJCWlmIChlbmFibGUpCiAJCQkJc211X3Bvd2VyX3Byb2ZpbGVfbW9kZV9wdXQoc211LCB0
eXBlKTsKQEAgLTI0MTEsNiArMjQxNSwzNSBAQCBzdGF0aWMgaW50IHNtdV9zd2l0Y2hfcG93ZXJf
cHJvZmlsZSh2b2lkICpoYW5kbGUsCiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRpYyBpbnQgc211X3Bh
dXNlX3Bvd2VyX3Byb2ZpbGUodm9pZCAqaGFuZGxlLAorCQkJCSAgIGJvb2wgcGF1c2UpCit7CisJ
c3RydWN0IHNtdV9jb250ZXh0ICpzbXUgPSBoYW5kbGU7CisJc3RydWN0IHNtdV9kcG1fY29udGV4
dCAqc211X2RwbV9jdHggPSAmKHNtdS0+c211X2RwbSk7CisJdTMyIHdvcmtsb2FkX21hc2sgPSAx
IDw8IFBQX1NNQ19QT1dFUl9QUk9GSUxFX0JPT1RVUF9ERUZBVUxUOworCWludCByZXQ7CisKKwlp
ZiAoIXNtdS0+cG1fZW5hYmxlZCB8fCAhc211LT5hZGV2LT5wbS5kcG1fZW5hYmxlZCkKKwkJcmV0
dXJuIC1FT1BOT1RTVVBQOworCisJaWYgKHNtdV9kcG1fY3R4LT5kcG1fbGV2ZWwgIT0gQU1EX0RQ
TV9GT1JDRURfTEVWRUxfTUFOVUFMICYmCisJICAgIHNtdV9kcG1fY3R4LT5kcG1fbGV2ZWwgIT0g
QU1EX0RQTV9GT1JDRURfTEVWRUxfUEVSRl9ERVRFUk1JTklTTSkgeworCQlzbXUtPnBhdXNlX3dv
cmtsb2FkID0gcGF1c2U7CisKKwkJLyogZm9yY2UgdG8gYm9vdHVwIGRlZmF1bHQgcHJvZmlsZSAq
LworCQlpZiAoc211LT5wYXVzZV93b3JrbG9hZCAmJiBzbXUtPnBwdF9mdW5jcy0+c2V0X3Bvd2Vy
X3Byb2ZpbGVfbW9kZSkKKwkJCXJldCA9IHNtdS0+cHB0X2Z1bmNzLT5zZXRfcG93ZXJfcHJvZmls
ZV9tb2RlKHNtdSwKKwkJCQkJCQkJICAgICB3b3JrbG9hZF9tYXNrLAorCQkJCQkJCQkgICAgIE5V
TEwsCisJCQkJCQkJCSAgICAgMCk7CisJCWVsc2UKKwkJCXJldCA9IHNtdV9idW1wX3Bvd2VyX3By
b2ZpbGVfbW9kZShzbXUsIE5VTEwsIDApOworCQlyZXR1cm4gcmV0OworCX0KKworCXJldHVybiAw
OworfQorCiBzdGF0aWMgZW51bSBhbWRfZHBtX2ZvcmNlZF9sZXZlbCBzbXVfZ2V0X3BlcmZvcm1h
bmNlX2xldmVsKHZvaWQgKmhhbmRsZSkKIHsKIAlzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSA9IGhh
bmRsZTsKQEAgLTM3NTksNiArMzc5Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kX3BtX2Z1
bmNzIHN3c211X3BtX2Z1bmNzID0gewogCS5nZXRfcHBfdGFibGUgICAgICAgICAgICA9IHNtdV9z
eXNfZ2V0X3BwX3RhYmxlLAogCS5zZXRfcHBfdGFibGUgICAgICAgICAgICA9IHNtdV9zeXNfc2V0
X3BwX3RhYmxlLAogCS5zd2l0Y2hfcG93ZXJfcHJvZmlsZSAgICA9IHNtdV9zd2l0Y2hfcG93ZXJf
cHJvZmlsZSwKKwkucGF1c2VfcG93ZXJfcHJvZmlsZSAgICAgPSBzbXVfcGF1c2VfcG93ZXJfcHJv
ZmlsZSwKIAkvKiBleHBvcnQgdG8gYW1kZ3B1ICovCiAJLmRpc3BhdGNoX3Rhc2tzICAgICAgICAg
ID0gc211X2hhbmRsZV9kcG1fdGFzaywKIAkubG9hZF9maXJtd2FyZSAgICAgICAgICAgPSBzbXVf
bG9hZF9taWNyb2NvZGUsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L2luYy9hbWRncHVfc211LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRn
cHVfc211LmgKaW5kZXggMjdjZWNmOTY4OGNjYi4uYTg1NWFlMjQ5YzczOSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL2FtZGdwdV9zbXUuaApAQCAtNTYwLDYgKzU2MCw3
IEBAIHN0cnVjdCBzbXVfY29udGV4dCB7CiAKIAkvKiBhc2ljIGFnbm9zdGljIHdvcmtsb2FkIG1h
c2sgKi8KIAl1aW50MzJfdCB3b3JrbG9hZF9tYXNrOworCWJvb2wgcGF1c2Vfd29ya2xvYWQ7CiAJ
LyogZGVmYXVsdC91c2VyIHdvcmtsb2FkIHByZWZlcmVuY2UgKi8KIAl1aW50MzJfdCBwb3dlcl9w
cm9maWxlX21vZGU7CiAJdWludDMyX3Qgd29ya2xvYWRfcmVmY291bnRbUFBfU01DX1BPV0VSX1BS
T0ZJTEVfQ09VTlRdOwotLSAKMi40OS4wCgo=
--000000000000a4b78206314033fd--
