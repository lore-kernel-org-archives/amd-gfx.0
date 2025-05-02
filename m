Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D3DC3ABA3
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 13:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6768D10E191;
	Fri,  2 May 2025 13:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H2Yknfom";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337FE10E191
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 13:14:00 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-73de140046eso252422b3a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746191640; x=1746796440; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MEuvexB6rEKKCloqgfzmQwySqS/VwIwQS6Qsh4m0jmA=;
 b=H2YknfomSQjj6n8Z2DB+xfk7Ln/GWNV2Ct669bdypvyiPJmeqs3BXWQtaff9oynucE
 COQSUvaRaW3TVMbgFyEm4v8qUKqvaVj79mDD0D0zhzj9hjh2whahK5IOhAs6f4CYYhup
 vAvQIpN8OucuTLwd+8e4/InJjlqtTP5v0A6TK9NW0kUIPkYIRt7F8Y0kj7bqUKSJuafU
 275gpsQmiLZIhVM5C6+yXYj43veWiElfhf5eDLSnMhGL2V1K5nnZ6Q+E7dHvZrHGU0Ff
 IiWzAqz6QVh6GhUgf0hR/l7MmPaUrewiIT5M51g2fFxCvYtn1mwvJRcfcbxcorjWuN59
 P80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746191640; x=1746796440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MEuvexB6rEKKCloqgfzmQwySqS/VwIwQS6Qsh4m0jmA=;
 b=H0c7cDNrvEnAHOo73RkTd+I2anzjWe1cDPG8bFNqTog3w5hyXawL4dLDanMaNArFT+
 SwLd3aruuRDxnlS/Wn33gDdjzzzOdRVFqQjfOKzFQsxNuduUreMjGi+aY1+CfRumYGgu
 Cgh302tsTvtujwARTxPJyIVuQt/cjSuw2dkQbIKAQTO88corwCz08wMfk0Fht+WQhi/O
 hMrf6B9WJYBOwSY+DxlftSjY8HpVzGH3r/4r4Ntgy10ot5un+e17knvA8lnc3Dbmxk/h
 MGGSOcDk3P2xV8pTg8QJGGmEopZnnyIt3kExCbwMZ0Gfu8KGWYGEyTa9QR1AbTb6Wf6+
 G3kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL5Z5DHrlIc5yzUKrV6WG3/P1CbL4AIrBY4w60Gt1UFn7h9JFPy3y6BQCB8VdgGhtyzK89zQGx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRqDlpdoKQ2jiEOy1TJR46neSHqRDQGG9liUgXjy4p5IAEgeVQ
 lYCwPm2BbJ6HyQsDq2QW8zNBuJ76wQUoahiLuserrSXDjm0OFkB5+rHdsp7+Wpg/pfSgjFenLxH
 uAW1Lxynovsfw2m3BZDwZSsWJoI70gw==
X-Gm-Gg: ASbGncur6Xqe+mpeQzG5uSGe7AinqqogGA/n0J9wxX9839ka4at7byYa1T1PaBNYqYX
 4xuDjtbdEtAPT8o8UDuP5aFrIkgOEMG+HS6SJ6/FSVnggSgJrTWB/bO5ehtUVxtcMhKVJYjt3Yt
 LW6gVawT2Jy2jARAs7iR+k3w==
X-Google-Smtp-Source: AGHT+IHZO3E9znbkmBPb4YnqjEBXweThfqJzWniaKensQhQX7Nosvqb0Z84YvWhajVb/+NI3zJSSbI99+T85x706VWI=
X-Received: by 2002:a17:90b:4ace:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-30a4e579edemr1718719a91.2.1746191639603; Fri, 02 May 2025
 06:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250501200931.358989-1-alexander.deucher@amd.com>
 <20250501200931.358989-2-alexander.deucher@amd.com>
 <591ce362-8150-4c81-a9b0-2752e0f27d15@amd.com>
 <CADnq5_M8KQyCPZ5iXJBqmHyuzHOomXWNfDvxwJnmXZ45a=T-6g@mail.gmail.com>
In-Reply-To: <CADnq5_M8KQyCPZ5iXJBqmHyuzHOomXWNfDvxwJnmXZ45a=T-6g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 May 2025 09:13:48 -0400
X-Gm-Features: ATxdqUE_5km1Bt0FZaJdZFb0EvF_XRWvSq9mqS6TqoQstUUcXcmdG7tguZp-fX4
Message-ID: <CADnq5_MhNS1Mff2JZqtzuqYg=xmpM_vDtRwka6NcTU1aUvixiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix pm notifier handling
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="00000000000063843b063426ecd4"
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

--00000000000063843b063426ecd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 8:56=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Thu, May 1, 2025 at 5:19=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > On 5/1/2025 3:09 PM, Alex Deucher wrote:
> > > Set the s3/s0ix and s4 flags in the pm notifier so that we can skip
> > > the resource evictions properly in pm prepare based on whether
> > > we are suspending or hibernating.  Drop the eviction as processes
> > > are not frozen at this time, we we can end up getting stuck trying
> > > to evict VRAM while applications continue to submit work which
> > > causes the buffers to get pulled back into VRAM.
> > >
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
> > > Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification cal=
lback support")
> > > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Rather than removing the callbacks (and thus introducing the "other"
> > bugs with memory pressure), I've sent an alternative series.  LMK what
> > you think of this instead.
> >
> > https://lore.kernel.org/amd-gfx/20250501211734.2434369-1-superm1@kernel=
.org/T/#m6cdc075af911868667ea6fc849bcd196477d6c20
>
> Series looks good to me, but I think a variant of this patch (with the
> evictions still in place) still makes sense so that we can properly
> set the suspend and hibernate flags in amdgpu so that we can optimize
> the evictions for suspend on APUs.  Will respin.

I think this set still makes sense for stable, but then if your patch
series lands, we can apply the attached patch on top of that.

Alex

>
> Alex
>
> >
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++--------=
---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 22 ++-----------------
> > >   2 files changed, 15 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> > > index 71d95f16067a4..d232e4a26d7bf 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -4974,28 +4974,29 @@ static int amdgpu_device_evict_resources(stru=
ct amdgpu_device *adev)
> > >    * @data: data
> > >    *
> > >    * This function is called when the system is about to suspend or h=
ibernate.
> > > - * It is used to evict resources from the device before the system g=
oes to
> > > - * sleep while there is still access to swap.
> > > + * It is used to set the appropriate flags so that eviction can be o=
ptimized
> > > + * in the pm prepare callback.
> > >    */
> > >   static int amdgpu_device_pm_notifier(struct notifier_block *nb, uns=
igned long mode,
> > >                                    void *data)
> > >   {
> > >       struct amdgpu_device *adev =3D container_of(nb, struct amdgpu_d=
evice, pm_nb);
> > > -     int r;
> > >
> > >       switch (mode) {
> > >       case PM_HIBERNATION_PREPARE:
> > >               adev->in_s4 =3D true;
> > > -             fallthrough;
> > > +             break;
> > > +     case PM_POST_HIBERNATION:
> > > +             adev->in_s4 =3D false;
> > > +             break;
> > >       case PM_SUSPEND_PREPARE:
> > > -             r =3D amdgpu_device_evict_resources(adev);
> > > -             /*
> > > -              * This is considered non-fatal at this time because
> > > -              * amdgpu_device_prepare() will also fatally evict reso=
urces.
> > > -              * See https://gitlab.freedesktop.org/drm/amd/-/issues/=
3781
> > > -              */
> > > -             if (r)
> > > -                     drm_warn(adev_to_drm(adev), "Failed to evict re=
sources, freeze active processes if problems occur: %d\n", r);
> > > +             if (amdgpu_acpi_is_s0ix_active(adev))
> > > +                     adev->in_s0ix =3D true;
> > > +             else if (amdgpu_acpi_is_s3_active(adev))
> > > +                     adev->in_s3 =3D true;
> > > +             break;
> > > +     case PM_POST_SUSPEND:
> > > +             adev->in_s0ix =3D adev->in_s3 =3D false;
> > >               break;
> > >       }
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_drv.c
> > > index cec041a556013..6599fb6313220 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -2572,10 +2572,6 @@ static int amdgpu_pmops_suspend(struct device =
*dev)
> > >       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> > >
> > > -     if (amdgpu_acpi_is_s0ix_active(adev))
> > > -             adev->in_s0ix =3D true;
> > > -     else if (amdgpu_acpi_is_s3_active(adev))
> > > -             adev->in_s3 =3D true;
> > >       if (!adev->in_s0ix && !adev->in_s3) {
> > >               /* don't allow going deep first time followed by s2idle=
 the next time */
> > >               if (adev->last_suspend_state !=3D PM_SUSPEND_ON &&
> > > @@ -2608,7 +2604,6 @@ static int amdgpu_pmops_resume(struct device *d=
ev)
> > >   {
> > >       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> > >       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> > > -     int r;
> > >
> > >       if (!adev->in_s0ix && !adev->in_s3)
> > >               return 0;
> > > @@ -2617,12 +2612,7 @@ static int amdgpu_pmops_resume(struct device *=
dev)
> > >       if (!pci_device_is_present(adev->pdev))
> > >               adev->no_hw_access =3D true;
> > >
> > > -     r =3D amdgpu_device_resume(drm_dev, true);
> > > -     if (amdgpu_acpi_is_s0ix_active(adev))
> > > -             adev->in_s0ix =3D false;
> > > -     else
> > > -             adev->in_s3 =3D false;
> > > -     return r;
> > > +     return amdgpu_device_resume(drm_dev, true);
> > >   }
> > >
> > >   static int amdgpu_pmops_freeze(struct device *dev)
> > > @@ -2643,13 +2633,8 @@ static int amdgpu_pmops_freeze(struct device *=
dev)
> > >   static int amdgpu_pmops_thaw(struct device *dev)
> > >   {
> > >       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> > > -     struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> > > -     int r;
> > >
> > > -     r =3D amdgpu_device_resume(drm_dev, true);
> > > -     adev->in_s4 =3D false;
> > > -
> > > -     return r;
> > > +     return amdgpu_device_resume(drm_dev, true);
> > >   }
> > >
> > >   static int amdgpu_pmops_poweroff(struct device *dev)
> > > @@ -2662,9 +2647,6 @@ static int amdgpu_pmops_poweroff(struct device =
*dev)
> > >   static int amdgpu_pmops_restore(struct device *dev)
> > >   {
> > >       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> > > -     struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> > > -
> > > -     adev->in_s4 =3D false;
> > >
> > >       return amdgpu_device_resume(drm_dev, true);
> > >   }
> >

--00000000000063843b063426ecd4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-handle-eviction-in-pm-notifier.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-handle-eviction-in-pm-notifier.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ma6teg6c0>
X-Attachment-Id: f_ma6teg6c0

RnJvbSA5MGZmYTIzNjA0YjcwY2FlOTM0NTM4MGFkZmIzNzQ2ODNlYWFiNmNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IEZyaSwgMiBNYXkgMjAyNSAwOTowOTozMyAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IGhhbmRsZSBldmljdGlvbiBpbiBwbSBub3RpZmllcgoKVXNlIHRoZSBuZXcg
UE1fU1VTUEVORF9QT1NUX0ZSRUVaRSBhbmQgUE1fSElCRVJOQVRFX1BPU1RfRlJFRVpFCmFjdGlv
bnMgdG8gaGFuZGxlIGJ1ZmZlciBldmljdGlvbi4gIFByb2Nlc3NlcyBoYXZlIGJlZW4KZnJvemVu
IHNvIHdlIGNhbiBzYWZlbHkgZXZpY3QgcmVzb3VyY2VzIHdoaWxlIHN3YXAgaXMgc3RpbGwKYWN0
aXZlIHNvIHdlIGhhdmUgbGVzcyByaXNrIG9mIHJ1bm5pbmcgb3V0IG9mIG1lbW9yeSB0bwpldmlj
dCBWUkFNLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8
IDIxICsrKysrKysrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jCmluZGV4IGQyMzJlNGEyNmQ3YmYuLjVhOGYwMjNmYTIwMWUgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTQ5ODEsMTkgKzQ5ODEsMzYgQEAg
c3RhdGljIGludCBhbWRncHVfZGV2aWNlX3BtX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9j
ayAqbmIsIHVuc2lnbmVkIGxvbmcgbW8KIAkJCQkgICAgIHZvaWQgKmRhdGEpCiB7CiAJc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBjb250YWluZXJfb2YobmIsIHN0cnVjdCBhbWRncHVfZGV2
aWNlLCBwbV9uYik7CisJaW50IHI7CiAKIAlzd2l0Y2ggKG1vZGUpIHsKLQljYXNlIFBNX0hJQkVS
TkFUSU9OX1BSRVBBUkU6CisJY2FzZSBQTV9ISUJFUk5BVEVfUE9TVF9GUkVFWkU6CiAJCWFkZXYt
PmluX3M0ID0gdHJ1ZTsKKwkJciA9IGFtZGdwdV9kZXZpY2VfZXZpY3RfcmVzb3VyY2VzKGFkZXYp
OworCQkvKgorCQkgKiBUaGlzIGlzIGNvbnNpZGVyZWQgbm9uLWZhdGFsIGF0IHRoaXMgdGltZSBi
ZWNhdXNlCisJCSAqIGFtZGdwdV9kZXZpY2VfcHJlcGFyZSgpIHdpbGwgYWxzbyBmYXRhbGx5IGV2
aWN0IHJlc291cmNlcy4KKwkJICogU2VlIGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9k
cm0vYW1kLy0vaXNzdWVzLzM3ODEKKwkJICovCisJCWlmIChyKQorCQkJZHJtX3dhcm4oYWRldl90
b19kcm0oYWRldiksICJGYWlsZWQgdG8gZXZpY3QgcmVzb3VyY2VzLCBmcmVlemUgYWN0aXZlIHBy
b2Nlc3NlcyBpZiBwcm9ibGVtcyBvY2N1cjogJWRcbiIsIHIpOwogCQlicmVhazsKIAljYXNlIFBN
X1BPU1RfSElCRVJOQVRJT046CiAJCWFkZXYtPmluX3M0ID0gZmFsc2U7CiAJCWJyZWFrOwotCWNh
c2UgUE1fU1VTUEVORF9QUkVQQVJFOgorCWNhc2UgUE1fU1VTUEVORF9QT1NUX0ZSRUVaRToKIAkJ
aWYgKGFtZGdwdV9hY3BpX2lzX3MwaXhfYWN0aXZlKGFkZXYpKQogCQkJYWRldi0+aW5fczBpeCA9
IHRydWU7CiAJCWVsc2UgaWYgKGFtZGdwdV9hY3BpX2lzX3MzX2FjdGl2ZShhZGV2KSkKIAkJCWFk
ZXYtPmluX3MzID0gdHJ1ZTsKKwkJciA9IGFtZGdwdV9kZXZpY2VfZXZpY3RfcmVzb3VyY2VzKGFk
ZXYpOworCQkvKgorCQkgKiBUaGlzIGlzIGNvbnNpZGVyZWQgbm9uLWZhdGFsIGF0IHRoaXMgdGlt
ZSBiZWNhdXNlCisJCSAqIGFtZGdwdV9kZXZpY2VfcHJlcGFyZSgpIHdpbGwgYWxzbyBmYXRhbGx5
IGV2aWN0IHJlc291cmNlcy4KKwkJICogU2VlIGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9y
Zy9kcm0vYW1kLy0vaXNzdWVzLzM3ODEKKwkJICovCisJCWlmIChyKQorCQkJZHJtX3dhcm4oYWRl
dl90b19kcm0oYWRldiksICJGYWlsZWQgdG8gZXZpY3QgcmVzb3VyY2VzLCBmcmVlemUgYWN0aXZl
IHByb2Nlc3NlcyBpZiBwcm9ibGVtcyBvY2N1cjogJWRcbiIsIHIpOwogCQlicmVhazsKIAljYXNl
IFBNX1BPU1RfU1VTUEVORDoKIAkJYWRldi0+aW5fczBpeCA9IGFkZXYtPmluX3MzID0gZmFsc2U7
Ci0tIAoyLjQ5LjAKCg==
--00000000000063843b063426ecd4--
