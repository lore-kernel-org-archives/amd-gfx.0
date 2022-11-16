Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89A0C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 16:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836BD10E4DD;
	Wed, 16 Nov 2022 16:38:47 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B630E10E4DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 16:38:42 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id s206so19108636oie.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 08:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LoZKgZrnJUJH08Xr0uhn5WSBPxsaxRjz20Tz/F6tBHs=;
 b=eLpMYNr5QeCJMDL5XR3Qa9BhhFTRYQBAqVmFJklyPzoXcwPkz2zV1gkbfwgvK0kdXi
 LAZ+GOZ90HckDKOKzS7hM+aLWbTdwCE3bUK867HuHWSnEuHFdYCgzdMj52NABPTg2wY4
 9uot78wC0Cy6wkpfhM7HXoAIK26ibIhnTxSMkMeAX0ZkTa3LpIi1/vPmi/KXJREB/tfd
 0W7a1g+pSrQjtijCctj36rZ4uaSL1qFnsEln8Q59rcGjTivXfWEsWBtElKI5DjWsWnkW
 05rb+SIKMYJMi05zPMNB0fjRwCp7kRc3cyhgSktnNW6pmbNqvQvfWE+jPH5EmYpEPUao
 hGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LoZKgZrnJUJH08Xr0uhn5WSBPxsaxRjz20Tz/F6tBHs=;
 b=3I9cL6s4pgRxo7//sSQ1GLH7of1DedTUueTZWPhDcjRAYJ+SnexjBjVVNUUueOYmBd
 YpId4/j35afjbhlf2ItTjgO4sJexpJ03THi0GavBpInHMqlB77mEAf8SNl0lSo01L4gW
 VrGqZMbN0lNsYv1yTi3yBhrMjaT2MhK/gHydUBehWEna/2Ytkt5JWM3wjbc+ruYdvjze
 z0wzj2azF/86kZ37xCzzy+cNyddWgB0ah0xoX9MJ6C17d7/B0J8CtYqVOwMlpUPoLYnu
 KkmMA8CVD1JIpXfMWCLo+cPKamsD1k5UYIldF3VQy3XLDNYDxH0Y4t9QHZN0TjF7YYrk
 XjBg==
X-Gm-Message-State: ANoB5plvXNqPBTBovhoeT8K9wpwZjQ9GagjVhzP9UaqJjKD77mXAdXP0
 8nIv0MP6lhedu/duddiNIGSXTKgTVwHZhN+SuSMAghZz
X-Google-Smtp-Source: AA0mqf7PqxaEMEvE/YdAjGmVkgEt0BgmeNLyzmAE1ZBlC+Rr4KxailU7xryszda/wqQVqccrDKjRBuIx5YLu/FKIiqc=
X-Received: by 2002:a05:6808:295:b0:357:670f:9e4e with SMTP id
 z21-20020a056808029500b00357670f9e4emr2118833oic.46.1668616721984; Wed, 16
 Nov 2022 08:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20221116160111.3226-1-christian.koenig@amd.com>
 <20221116160111.3226-2-christian.koenig@amd.com>
In-Reply-To: <20221116160111.3226-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Nov 2022 11:38:28 -0500
Message-ID: <CADnq5_MccS8DkM9kLmamDH3wcNeJZeczAqqHc+gfxFLRrb-GSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: stop freeing PSP buffers during suspend
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000fb230705ed991ac5"
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
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000fb230705ed991ac5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I was thinking something like this would be more straightforward.

Alex

On Wed, Nov 16, 2022 at 11:01 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That the PSP code tries to free the memory during suspend is quite
> broken and leads to problems during resume.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 30 ++++++++++---------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 0a8c30475dda..470cd660c450 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -511,11 +511,10 @@ static int psp_sw_fini(void *handle)
>         kfree(cmd);
>         cmd =3D NULL;
>
> -       if (psp->km_ring.ring_mem)
> -               amdgpu_bo_free_kernel(&adev->firmware.rbuf,
> -                                     &psp->km_ring.ring_mem_mc_addr,
> -                                     (void **)&psp->km_ring.ring_mem);
> -
> +       psp_free_shared_bufs(psp);
> +       amdgpu_bo_free_kernel(&adev->firmware.rbuf,
> +                             &psp->km_ring.ring_mem_mc_addr,
> +                             (void **)&psp->km_ring.ring_mem);
>         amdgpu_bo_free_kernel(&psp->fw_pri_bo,
>                               &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
>         amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> @@ -2635,8 +2634,6 @@ static int psp_hw_fini(void *handle)
>
>         psp_ring_destroy(psp, PSP_RING_TYPE__KM);
>
> -       psp_free_shared_bufs(psp);
> -
>         return 0;
>  }
>
> @@ -2651,7 +2648,7 @@ static int psp_suspend(void *handle)
>                 ret =3D psp_xgmi_terminate(psp);
>                 if (ret) {
>                         DRM_ERROR("Failed to terminate xgmi ta\n");
> -                       goto out;
> +                       return ret;
>                 }
>         }
>
> @@ -2659,40 +2656,40 @@ static int psp_suspend(void *handle)
>                 ret =3D psp_ras_terminate(psp);
>                 if (ret) {
>                         DRM_ERROR("Failed to terminate ras ta\n");
> -                       goto out;
> +                       return ret;
>                 }
>                 ret =3D psp_hdcp_terminate(psp);
>                 if (ret) {
>                         DRM_ERROR("Failed to terminate hdcp ta\n");
> -                       goto out;
> +                       return ret;
>                 }
>                 ret =3D psp_dtm_terminate(psp);
>                 if (ret) {
>                         DRM_ERROR("Failed to terminate dtm ta\n");
> -                       goto out;
> +                       return ret;
>                 }
>                 ret =3D psp_rap_terminate(psp);
>                 if (ret) {
>                         DRM_ERROR("Failed to terminate rap ta\n");
> -                       goto out;
> +                       return ret;
>                 }
>                 ret =3D psp_securedisplay_terminate(psp);
>                 if (ret) {
>                         DRM_ERROR("Failed to terminate securedisplay ta\n=
");
> -                       goto out;
> +                       return ret;
>                 }
>         }
>
>         ret =3D psp_asd_terminate(psp);
>         if (ret) {
>                 DRM_ERROR("Failed to terminate asd\n");
> -               goto out;
> +               return ret;
>         }
>
>         ret =3D psp_tmr_terminate(psp);
>         if (ret) {
>                 DRM_ERROR("Failed to terminate tmr\n");
> -               goto out;
> +               return ret;
>         }
>
>         ret =3D psp_ring_stop(psp, PSP_RING_TYPE__KM);
> @@ -2700,9 +2697,6 @@ static int psp_suspend(void *handle)
>                 DRM_ERROR("PSP ring stop failed\n");
>         }
>
> -out:
> -       psp_free_shared_bufs(psp);
> -
>         return ret;
>  }
>
> --
> 2.34.1
>

--000000000000fb230705ed991ac5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-psp-don-t-free-PSP-buffers-on-suspend.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-psp-don-t-free-PSP-buffers-on-suspend.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lajvaci00>
X-Attachment-Id: f_lajvaci00

RnJvbSBjZDczZjhhOTQwNzkyOTBlN2M5NDRmM2QzMTA1ZGRmNzVhYzFjNDNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMTYgTm92IDIwMjIgMTE6MjY6NTMgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L3BzcDogZG9uJ3QgZnJlZSBQU1AgYnVmZmVycyBvbiBzdXNwZW5kCgpXZSBj
YW4gcmV1c2UgdGhlIHNhbWUgYnVmZmVycyBvbiByZXN1bWUuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgNTYgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCAwYThjMzA0NzVkZGEuLmQ5Y2I0
YzRiODI4OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bz
cC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwpAQCAtMTcy
LDYgKzE3Miw3IEBAIHZvaWQgcHNwX3RhX2ZyZWVfc2hhcmVkX2J1ZihzdHJ1Y3QgdGFfbWVtX2Nv
bnRleHQgKm1lbV9jdHgpCiB7CiAJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZtZW1fY3R4LT5zaGFy
ZWRfYm8sICZtZW1fY3R4LT5zaGFyZWRfbWNfYWRkciwKIAkJCSAgICAgICZtZW1fY3R4LT5zaGFy
ZWRfYnVmKTsKKwltZW1fY3R4LT5zaGFyZWRfYm8gPSBOVUxMOwogfQogCiBzdGF0aWMgdm9pZCBw
c3BfZnJlZV9zaGFyZWRfYnVmcyhzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKQEAgLTE4Miw2ICsx
ODMsNyBAQCBzdGF0aWMgdm9pZCBwc3BfZnJlZV9zaGFyZWRfYnVmcyhzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCkKIAkvKiBmcmVlIFRNUiBtZW1vcnkgYnVmZmVyICovCiAJcHB0ciA9IGFtZGdwdV9z
cmlvdl92Zihwc3AtPmFkZXYpID8gJnRtcl9idWYgOiBOVUxMOwogCWFtZGdwdV9ib19mcmVlX2tl
cm5lbCgmcHNwLT50bXJfYm8sICZwc3AtPnRtcl9tY19hZGRyLCBwcHRyKTsKKwlwc3AtPnRtcl9i
byA9IE5VTEw7CiAKIAkvKiBmcmVlIHhnbWkgc2hhcmVkIG1lbW9yeSAqLwogCXBzcF90YV9mcmVl
X3NoYXJlZF9idWYoJnBzcC0+eGdtaV9jb250ZXh0LmNvbnRleHQubWVtX2NvbnRleHQpOwpAQCAt
NzQzLDM3ICs3NDUsMzkgQEAgc3RhdGljIGludCBwc3BfbG9hZF90b2Moc3RydWN0IHBzcF9jb250
ZXh0ICpwc3AsCiAvKiBTZXQgdXAgVHJ1c3RlZCBNZW1vcnkgUmVnaW9uICovCiBzdGF0aWMgaW50
IHBzcF90bXJfaW5pdChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKLQlpbnQgcmV0OworCWlu
dCByZXQgPSAwOwogCWludCB0bXJfc2l6ZTsKIAl2b2lkICp0bXJfYnVmOwogCXZvaWQgKipwcHRy
OwogCi0JLyoKLQkgKiBBY2NvcmRpbmcgdG8gSFcgZW5naW5lZXIsIHRoZXkgcHJlZmVyIHRoZSBU
TVIgYWRkcmVzcyBiZSAibmF0dXJhbGx5Ci0JICogYWxpZ25lZCIgLCBlLmcuIHRoZSBzdGFydCBh
ZGRyZXNzIGJlIGFuIGludGVnZXIgZGl2aWRlIG9mIFRNUiBzaXplLgotCSAqCi0JICogTm90ZTog
dGhpcyBtZW1vcnkgbmVlZCBiZSByZXNlcnZlZCB0aWxsIHRoZSBkcml2ZXIKLQkgKiB1bmluaXRp
YWxpemVzLgotCSAqLwotCXRtcl9zaXplID0gUFNQX1RNUl9TSVpFKHBzcC0+YWRldik7Ci0KLQkv
KiBGb3IgQVNJQ3Mgc3VwcG9ydCBSTEMgYXV0b2xvYWQsIHBzcCB3aWxsIHBhcnNlIHRoZSB0b2MK
LQkgKiBhbmQgY2FsY3VsYXRlIHRoZSB0b3RhbCBzaXplIG9mIFRNUiBuZWVkZWQgKi8KLQlpZiAo
IWFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpICYmCi0JICAgIHBzcC0+dG9jLnN0YXJ0X2FkZHIg
JiYKLQkgICAgcHNwLT50b2Muc2l6ZV9ieXRlcyAmJgotCSAgICBwc3AtPmZ3X3ByaV9idWYpIHsK
LQkJcmV0ID0gcHNwX2xvYWRfdG9jKHBzcCwgJnRtcl9zaXplKTsKLQkJaWYgKHJldCkgewotCQkJ
RFJNX0VSUk9SKCJGYWlsZWQgdG8gbG9hZCB0b2NcbiIpOwotCQkJcmV0dXJuIHJldDsKKwlpZiAo
IXBzcC0+dG1yX2JvKSB7CisJCS8qCisJCSAqIEFjY29yZGluZyB0byBIVyBlbmdpbmVlciwgdGhl
eSBwcmVmZXIgdGhlIFRNUiBhZGRyZXNzIGJlICJuYXR1cmFsbHkKKwkJICogYWxpZ25lZCIgLCBl
LmcuIHRoZSBzdGFydCBhZGRyZXNzIGJlIGFuIGludGVnZXIgZGl2aWRlIG9mIFRNUiBzaXplLgor
CQkgKgorCQkgKiBOb3RlOiB0aGlzIG1lbW9yeSBuZWVkIGJlIHJlc2VydmVkIHRpbGwgdGhlIGRy
aXZlcgorCQkgKiB1bmluaXRpYWxpemVzLgorCQkgKi8KKwkJdG1yX3NpemUgPSBQU1BfVE1SX1NJ
WkUocHNwLT5hZGV2KTsKKworCQkvKiBGb3IgQVNJQ3Mgc3VwcG9ydCBSTEMgYXV0b2xvYWQsIHBz
cCB3aWxsIHBhcnNlIHRoZSB0b2MKKwkJICogYW5kIGNhbGN1bGF0ZSB0aGUgdG90YWwgc2l6ZSBv
ZiBUTVIgbmVlZGVkICovCisJCWlmICghYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikgJiYKKwkJ
ICAgIHBzcC0+dG9jLnN0YXJ0X2FkZHIgJiYKKwkJICAgIHBzcC0+dG9jLnNpemVfYnl0ZXMgJiYK
KwkJICAgIHBzcC0+ZndfcHJpX2J1ZikgeworCQkJcmV0ID0gcHNwX2xvYWRfdG9jKHBzcCwgJnRt
cl9zaXplKTsKKwkJCWlmIChyZXQpIHsKKwkJCQlEUk1fRVJST1IoIkZhaWxlZCB0byBsb2FkIHRv
Y1xuIik7CisJCQkJcmV0dXJuIHJldDsKKwkJCX0KIAkJfQotCX0KIAotCXBwdHIgPSBhbWRncHVf
c3Jpb3ZfdmYocHNwLT5hZGV2KSA/ICZ0bXJfYnVmIDogTlVMTDsKLQlyZXQgPSBhbWRncHVfYm9f
Y3JlYXRlX2tlcm5lbChwc3AtPmFkZXYsIHRtcl9zaXplLCBQU1BfVE1SX0FMSUdOTUVOVCwKLQkJ
CQkgICAgICBBTURHUFVfR0VNX0RPTUFJTl9WUkFNLAotCQkJCSAgICAgICZwc3AtPnRtcl9ibywg
JnBzcC0+dG1yX21jX2FkZHIsIHBwdHIpOworCQlwcHRyID0gYW1kZ3B1X3NyaW92X3ZmKHBzcC0+
YWRldikgPyAmdG1yX2J1ZiA6IE5VTEw7CisJCXJldCA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVs
KHBzcC0+YWRldiwgdG1yX3NpemUsIFBTUF9UTVJfQUxJR05NRU5ULAorCQkJCQkgICAgICBBTURH
UFVfR0VNX0RPTUFJTl9WUkFNLAorCQkJCQkgICAgICAmcHNwLT50bXJfYm8sICZwc3AtPnRtcl9t
Y19hZGRyLCBwcHRyKTsKKwl9CiAKIAlyZXR1cm4gcmV0OwogfQpAQCAtMjcwMSw4ICsyNzA1LDYg
QEAgc3RhdGljIGludCBwc3Bfc3VzcGVuZCh2b2lkICpoYW5kbGUpCiAJfQogCiBvdXQ6Ci0JcHNw
X2ZyZWVfc2hhcmVkX2J1ZnMocHNwKTsKLQogCXJldHVybiByZXQ7CiB9CiAKLS0gCjIuMzguMQoK
--000000000000fb230705ed991ac5--
