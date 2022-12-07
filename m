Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CB4C352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B1410E3C9;
	Wed,  7 Dec 2022 15:11:16 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5291410E3C9;
 Wed,  7 Dec 2022 15:11:13 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id v82so21034455oib.4;
 Wed, 07 Dec 2022 07:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8OflrLHFJ+g4w8Hw8Ns486Go7C0erYTyeSQtkrS7r/8=;
 b=UbPUfOxH/CYzDN9iZHyUHMI/kYbf8YurMm54miRBQeeRSSkLw92oY0tsFH5TNrghth
 XTbnHEyGXhRESoFikAauMTqwgGKqa3/VJY53cPPr1ZjbhYb+Flkf+G5hV500dVFiimlP
 OQ/XSbPFwbiff2Q6RM/DasdIBVHLBFS0VGB1zFNJAfiC3uat46J7nF6RiYUkzwlr8t30
 IgRfoOSO3JWkuLVHmO36LPgDlZ7EhtwNoXB9Sdh7icLvPRlV5hEljtVrLr7IMxMJPoRV
 Ly/1E+M3IbfpdNreQ5MfpfMfcI3eDWuQPpqhuxMhc3T4ozoHYH1RpKn3kwYq+dhYyDsE
 cQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8OflrLHFJ+g4w8Hw8Ns486Go7C0erYTyeSQtkrS7r/8=;
 b=Q7eDeTW/XRUlWjNM19/f8eWCv23hJX2QDnOObCJijIcJ3upjPu8kGQmODWU7ENx0kO
 HLYs54bg/8u19SGcxfJJjek74rt8BcuuhHOHiibP3Q5ZwgAvkWivipdLdPvTZlCqUxOi
 FYP+t02cg1NT/kaeRHVNErwyXjEUlBH0QuGuEeON/waT37r3YHnqwQWlHV1tCPV9J9yR
 6ZzWhd7nZgjFgjHgCC55x5MmY59j6wSual2uk+N+dG8Ej89K9DCwh/7OTd/E4Si0NR5v
 jVKQRAZWHDCwm5jZap+SiE68WZ3BSoQ/H8xFF7ccoQ+REH/bKXaIjZ96n9e6o0fPkjnt
 Vyaw==
X-Gm-Message-State: ANoB5pmiR6lVxBIgX6LNawHAl0fFo4KkO0UJkMplR+PWz7hE8vB5uupq
 S2i3EO+Wl4N7nSwlooJOogmXlsoIHcInSaXixwI=
X-Google-Smtp-Source: AA0mqf40tlV5duv5+TtbVnyYx0eMhxGsB17UuNkj8JLI0E4gz+duS8rM5GrAp4TdhMsOSk4k0QlZel0d5xxII4cSiGs=
X-Received: by 2002:a05:6808:bc2:b0:35b:d93f:cbc4 with SMTP id
 o2-20020a0568080bc200b0035bd93fcbc4mr15642748oik.96.1670425872621; Wed, 07
 Dec 2022 07:11:12 -0800 (PST)
MIME-Version: 1.0
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Dec 2022 10:10:59 -0500
Message-ID: <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="000000000000c34bec05ef3e54c5"
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 amd-gfx <amd-gfx-bounces@lists.freedesktop.org>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000c34bec05ef3e54c5
Content-Type: text/plain; charset="UTF-8"

Does this patch fix the problem?

Alex

On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) <Jesse.Zhang@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
>
>     drm/amdgpu: try allowed domain when pin framebuffer failed.
>
>
>
>     [WHY&HOW]
>
>
>
>     in some scenarios, the allocate memory often failed. such as do hot plug or play games.
>
>     so we can try allowed domain, if the preferred domain cannot allocate memory.
>
>
>
>     Signed-off-by: jie1zhan jesse.zhang@amd.com
>
>     Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
>
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> index 1ae0c8723348..05fcaf7f9d92 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> @@ -39,6 +39,7 @@
>
> #include "amdgpu.h"
>
> #include "amdgpu_trace.h"
>
> #include "amdgpu_amdkfd.h"
>
> +#include "amdgpu_display.h"
>
>
>
> /**
>
>   * DOC: amdgpu_object
>
> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>
>                         bo->placements[i].lpfn = lpfn;
>
>         }
>
>
>
> +       retry:
>
>         r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>
>         if (unlikely(r)) {
>
> +               //try allowed domain when pin failed. just a workaround.
>
> +               if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
>
> +                       amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>
> +                       goto retry;
>
> +               }
>
>                 dev_err(adev->dev, "%p pin failed\n", bo);
>
>                 goto error;
>
>         }

--000000000000c34bec05ef3e54c5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-make-display-pinning-more-flexible.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-make-display-pinning-more-flexible.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lbdsf68g0>
X-Attachment-Id: f_lbdsf68g0

RnJvbSAyZmI5Zjk3ZmUyODIxNTU0YTJlMzg3ZWU5NTk0MjMwMmZiMTAwM2M2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgOSBNYXkgMjAyMiAxMjoxNjozMSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IG1ha2UgZGlzcGxheSBwaW5uaW5nIG1vcmUgZmxleGlibGUKCldlIG9yaWdp
bmFsbHkgdXNlZCBhIHN0YXRpYyB0aHJlc2hvbGQgZm9yIHdoZXRoZXIgdG8gdXNlCnZyYW0gb3Ig
c3lzdGVtIG1lbW9yeSBmb3IgZGlzcGxheSBwaW5uaW5nIGR1ZSB0byBoYXJkd2FyZQpyZXF1aXJl
bWVudHMgb24gQ2Fycml6byBhcm91bmQgcGxhY2VtZW50IG9mIGJ1ZmZlcnMgd2hpY2gKbW9zdGx5
IGJvaWxlZCBkb3duIHRvIG5vdCBtaXhpbmcgZG9tYWlucy4gIE5ld2VyIGFzaWNzCmRvIG5vdCBo
YXZlIHRoZXNlIHJlcXVpcmVtZW50cyBzbyB3ZSBzaG91bGQgYmUgYWJsZQp0byBiZSBtb3JlIGZs
ZXhpYmxlIHdpdGggd2hlcmUgYnVmZmVycyBlbmQgdXAuICBBZGQgYSBuZXcKcGFyYW1ldGVyIHRv
IGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX2RvbWFpbigpIGFuZCBjaGVjawp0aGUgc2l6ZSBvZiB0
aGUgYWxsb2NhdGlvbiBhZ2FpbnN0IHdoYXQgaXMgYWxyZWFkeQpwaW5uZWQgdG8gZGV0ZXJtaW5l
IHdoaWNoIGRvbWFpbiB0byB1c2UgZm9yIHBpbm5pbmcuClRoaXMgc2hvdWxkIGF2b2lkIHJ1bm5p
bmcgb3V0IG9mIHJvb20gaW4gb25lIGRvbWFpbiBvcgp0aGUgb3RoZXIgZHVlIHRvIHVzaW5nIGEg
c3RhdGljIHRocmVzaG9sZC4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2VtLmMgICAgfCAgMyArKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYyB8IDE4ICsrKysrKysrKysrKysrKy0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X29iamVjdC5oIHwgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bV9wdC5jICB8ICAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCmluZGV4
IDYyZTk4ZjFhZDc3MC4uOGVjZDRmMjVjNmYyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dlbS5jCkBAIC05MTgsNyArOTE4LDggQEAgaW50IGFtZGdwdV9tb2RlX2R1bWJfY3Jl
YXRlKHN0cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2LAogCWFyZ3MtPnNpemUgPSAodTY0KWFyZ3Mt
PnBpdGNoICogYXJncy0+aGVpZ2h0OwogCWFyZ3MtPnNpemUgPSBBTElHTihhcmdzLT5zaXplLCBQ
QUdFX1NJWkUpOwogCWRvbWFpbiA9IGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX2RvbWFpbihhZGV2
LAotCQkJCWFtZGdwdV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5zKGFkZXYsIGZsYWdzKSk7CisJ
CQkJCQlhbWRncHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucyhhZGV2LCBmbGFncyksCisJCQkJ
CQlhcmdzLT5zaXplKTsKIAlyID0gYW1kZ3B1X2dlbV9vYmplY3RfY3JlYXRlKGFkZXYsIGFyZ3Mt
PnNpemUsIDAsIGRvbWFpbiwgZmxhZ3MsCiAJCQkJICAgICB0dG1fYm9fdHlwZV9kZXZpY2UsIE5V
TEwsICZnb2JqKTsKIAlpZiAocikKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYwppbmRleCA5MTliYmVhMmUzYWMuLmVjMGFiYzRlNzMwYyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwpAQCAtOTIxLDcgKzkyMSw3IEBAIGludCBh
bWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoc3RydWN0IGFtZGdwdV9ibyAqYm8sIHUzMiBkb21haW4s
CiAJLyogVGhpcyBhc3N1bWVzIG9ubHkgQVBVIGRpc3BsYXkgYnVmZmVycyBhcmUgcGlubmVkIHdp
dGggKFZSQU18R1RUKS4KIAkgKiBTZWUgZnVuY3Rpb24gYW1kZ3B1X2Rpc3BsYXlfc3VwcG9ydGVk
X2RvbWFpbnMoKQogCSAqLwotCWRvbWFpbiA9IGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX2RvbWFp
bihhZGV2LCBkb21haW4pOworCWRvbWFpbiA9IGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX2RvbWFp
bihhZGV2LCBkb21haW4sIGFtZGdwdV9ib19zaXplKGJvKSk7CiAKIAlpZiAoYm8tPnRiby5iYXNl
LmltcG9ydF9hdHRhY2gpCiAJCWRtYV9idWZfcGluKGJvLT50Ym8uYmFzZS5pbXBvcnRfYXR0YWNo
KTsKQEAgLTE1MDQsMTIgKzE1MDQsMjQgQEAgdTY0IGFtZGdwdV9ib19ncHVfb2Zmc2V0X25vX2No
ZWNrKHN0cnVjdCBhbWRncHVfYm8gKmJvKQogICogV2hpY2ggb2YgdGhlIGFsbG93ZWQgZG9tYWlu
cyBpcyBwcmVmZXJyZWQgZm9yIGFsbG9jYXRpbmcgdGhlIEJPLgogICovCiB1aW50MzJfdCBhbWRn
cHVfYm9fZ2V0X3ByZWZlcnJlZF9kb21haW4oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCi0J
CQkJCSAgICB1aW50MzJfdCBkb21haW4pCisJCQkJCXVpbnQzMl90IGRvbWFpbiwgdTY0IHNpemUp
CiB7CiAJaWYgKGRvbWFpbiA9PSAoQU1ER1BVX0dFTV9ET01BSU5fVlJBTSB8IEFNREdQVV9HRU1f
RE9NQUlOX0dUVCkpIHsKKwkJdTY0IHVzYWJsZV92cmFtX3NpemUgPSAoYWRldi0+Z21jLnJlYWxf
dnJhbV9zaXplIC0KKwkJCQkJYXRvbWljNjRfcmVhZCgmYWRldi0+dnJhbV9waW5fc2l6ZSkgLQor
CQkJCQlBTURHUFVfVk1fUkVTRVJWRURfVlJBTSkgKiAzIC8gNDsKKwogCQlkb21haW4gPSBBTURH
UFVfR0VNX0RPTUFJTl9WUkFNOwotCQlpZiAoYWRldi0+Z21jLnJlYWxfdnJhbV9zaXplIDw9IEFN
REdQVV9TR19USFJFU0hPTEQpCisJCS8qIFVzZSBhIGZpeGVkIHRocmVzaG9sZCBvbiBDWiBkdWUg
dG8gaHcgcmVzdHJpY3Rpb25zCisJCSAqIChubyBtaXhpbmcgb2Ygc3lzdGVtIGFuZCB2cmFtIGZv
ciBkaXNwbGF5KSwgZm9yIGV2ZXJ5dGhpbmcKKwkJICogZWxzZSwgdXNlIGEgZHluYW1pYyBjYWxj
dWxhdGlvbi4KKwkJICovCisJCWlmICgoYWRldi0+YXNpY190eXBlID09IENISVBfQ0FSUklaTykg
fHwgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1NUT05FWSkpIHsKKwkJCWlmIChhZGV2LT5nbWMu
cmVhbF92cmFtX3NpemUgPD0gQU1ER1BVX1NHX1RIUkVTSE9MRCkKKwkJCQlkb21haW4gPSBBTURH
UFVfR0VNX0RPTUFJTl9HVFQ7CisJCX0gZWxzZSBpZiAodXNhYmxlX3ZyYW1fc2l6ZSA8PSBzaXpl
KSB7CiAJCQlkb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7CisJCX0KIAl9CiAJcmV0dXJu
IGRvbWFpbjsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaApp
bmRleCAxNDdiNzljMTBjYmIuLjE5N2FjY2IyZjQwMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuaApAQCAtMzMxLDcgKzMzMSw3IEBAIHZvaWQgYW1kZ3B1X2Jv
X2FkZF90b19zaGFkb3dfbGlzdChzdHJ1Y3QgYW1kZ3B1X2JvX3ZtICp2bWJvKTsKIGludCBhbWRn
cHVfYm9fcmVzdG9yZV9zaGFkb3coc3RydWN0IGFtZGdwdV9ibyAqc2hhZG93LAogCQkJICAgICBz
dHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2UpOwogdWludDMyX3QgYW1kZ3B1X2JvX2dldF9wcmVmZXJy
ZWRfZG9tYWluKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAotCQkJCQkgICAgdWludDMyX3Qg
ZG9tYWluKTsKKwkJCQkJdWludDMyX3QgZG9tYWluLCB1NjQgc2l6ZSk7CiAKIC8qCiAgKiBzdWIg
YWxsb2NhdGlvbgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtX3B0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fcHQuYwppbmRl
eCBiNWYzYmJhODUxZGIuLjI0N2E1NzE0ZGI0YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3B0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtX3B0LmMKQEAgLTUxMyw3ICs1MTMsNyBAQCBpbnQgYW1kZ3B1X3ZtX3B0X2Ny
ZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sCiAJ
YnAuc2l6ZSA9IGFtZGdwdV92bV9wdF9zaXplKGFkZXYsIGxldmVsKTsKIAlicC5ieXRlX2FsaWdu
ID0gQU1ER1BVX0dQVV9QQUdFX1NJWkU7CiAJYnAuZG9tYWluID0gQU1ER1BVX0dFTV9ET01BSU5f
VlJBTTsKLQlicC5kb21haW4gPSBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9kb21haW4oYWRldiwg
YnAuZG9tYWluKTsKKwlicC5kb21haW4gPSBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9kb21haW4o
YWRldiwgYnAuZG9tYWluLCBicC5zaXplKTsKIAlicC5mbGFncyA9IEFNREdQVV9HRU1fQ1JFQVRF
X1ZSQU1fQ09OVElHVU9VUyB8CiAJCUFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQzsKIAot
LSAKMi4zOC4xCgo=
--000000000000c34bec05ef3e54c5--
