Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E7BC9830E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 13:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 263AC10FA74;
	Fri, 25 Sep 2026 13:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qPFhbQ5y";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA0710FA74
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 13:19:06 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 71dfb90a1353d-5c7e0766671so25301e0c.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 06:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790342345; cv=none;
 d=google.com; s=arc-20260327;
 b=Hry9hdIMcF04pMyzSfrSG3teBs3CHwAO9LcstDXTgEfMo9gOhnFS903j8yw3yFZC0D
 epGxGMfFVD2hWLBynSJUsqpIMsQbVM80lJQnFmohV+QWMV0XJ8EVtb4tWu8qH4eYcTpE
 61S2HNYB8lNPpsSk4zL9ecfEE+LDdY3iqcyAWHCaF1DI98dO0oTlOYgv9OEfkq4Leu9g
 KRBwhd/Ne4iy4FF/EfsoJJqb7IOddvv+jHhbYK1zkTzE8E3KH6KSPpK/MFNLuyHkR5Mh
 Qi2DtXtoT7kyAfmFf6QnxKeEUMKeTra4gbI/Fs9HpmR9U+Zto4ee6MGeLe6JRZN9v4s/
 //4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v1T+887+ysRm648rHil2WXYMHOnrtYykJIIR4VYBxQ8=;
 fh=7R0NeYSBLxyC4G/C2BVcOA0tx0MyIsOyKRLGsUqzBkc=;
 b=QkXujtEwG2MG1/Yoii82hwyVmpkiuwNBky3tX0MgEBRd85t7uVJk2QkHgYnbij5hul
 0yVmNZKjfGgDKpTEMxnlXdSfDVybg1+XdJcwfheS7gVGCGw3+LcemY/oiHc9TopeHMHe
 7lLl1OZu+STiRvnJgrzgZz5SX9x8AN8StnDSMeBj7mcIDmXG+5qf5ltiHhdHt1QTRbmy
 lDt1tTigKVTlCqrPBxue5INM2HSzl+EmmN/SZ7pNgwdNxYEihjLcgUdbWna5CYP/wQeE
 02G5cgGuf9rJxm/LxPO0QPGw5cbl/Q1bJvRhwmg467trb4Z+Awky21Y/QtJm0KYf9y0i
 gC3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790342345; x=1790947145; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v1T+887+ysRm648rHil2WXYMHOnrtYykJIIR4VYBxQ8=;
 b=qPFhbQ5yelfK6hsLF1HGlwtyAuFYuBQ1+6c86RxF69csmW73rR1BpFueJaR4ORoSHJ
 Q3cuieJgu7en+Ym8yqvlwfiYs/w12nqMRFhI9i6G4c5UlB5aXb9ZPt6R625Dxi6sJOnR
 Sv8MBh/PQheDA9nf2vKzzR53ZhiE4F/t4w4Y4E7obpa8j/YSKxPp1QuetQLjrYAUTgue
 HTPDOkApfh+k7t/zEKHChXmXPXWqjR9VqPAh+TzqipUEOpPo+XELROS89vVl0a80uEq5
 WhHkkHiRYbKbijzk9a9h+38/bTnLqxkGIpbC9tihm5E1/ghmM4b80GCNarhlsochhXPe
 /i6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790342345; x=1790947145;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v1T+887+ysRm648rHil2WXYMHOnrtYykJIIR4VYBxQ8=;
 b=XXBunVh2ojfXyhFWqp7Gjdd/TCFaEIb2JuG1iozTiWKpA4aDsSKuuxiTLdaNMM21L1
 I84szgVz534b2cdFb/CuicPfQCnQg5Hzu3u9ez2U840sQZxaclFcNkHFjQCyHlLk9rAy
 N97scmze6aLJfL8eQ+Gk4KqOdYrmVlq+v/jF3dEdY2beQMLn1b6KuBsptv+UyL3fILxR
 8o6rQTVLFz7ZbdW9BIMw2uc/A6OGvKPiwi1bHphgXkH7s5cd42iFJFC4QgN9C27qMQf1
 BIbcWQMCmNkKC7fmhGxph+mY0c9WSA1bjRvX745Uq+uieqQq7xhNe9Vr3ZBiikPQ15DV
 o4XA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+MneM9UAtf4ZNbNu/JRWCFh96X4P9UDQed8OP62xjSgUWQ1MovGRwnNzms8E9apbC3dTLjpcD@lists.freedesktop.org
X-Gm-Message-State: AFuF++kGaFvPW1PuUciR5zD0ixUnfWUINHDSHDZ7se/EFm1L+RT1G6J5
 bQhoJHkqH14s9LGY29tC8tJZVDsckgDhlpwYB48MIX+nh00+lbq1T7KgIzX5k9PNctI5A2k4HwY
 PTJZhH6byeTOfeXmNMFp/vYNIrclYy8s=
X-Gm-Gg: AYBFou0DXNHvmd27JB5Dq9IqFulYzAldtHf1ZUYB3M6caBQA26UAtLcd0s1E2XGHCex
 zr5/LV/IlOsK50ruMwMkJxoBIeNjJoPFcJtvaWXu1XTXfA/FcdKQr7kRMRK/939A3e0lzWT7zIk
 N8wqQuyrB6jF4b+vE1Yjt8iyaTvKLJ7UnZfFZy9P+XuGsTs12UgQDeYfcdu6ZQX6XyuYWcB0MJe
 eo8J9+9IV4uALCjR4aWQKmZMjpsbzf50EnzU2uhPQzu3zx2ABzplcuRdauROALHse3ohjD5QZqu
 9pzZtkxXqKoKDSxgMzQFtrEOI2imqa91gFUu329/YStEJxyFyOUlk8aCMtUA42HZl6R3w7z6JL2
 hPtMq+WvXf5ZEkl4rEJHDDu4eGR05No5oelgoA2/3Rg==
X-Received: by 2002:a05:6122:2911:b0:5c9:e558:53da with SMTP id
 71dfb90a1353d-5cc4ac05f70mr1019989e0c.3.1790342345253; Fri, 25 Sep 2026
 06:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260925072444.18982-1-ayhancicek@gmail.com>
In-Reply-To: <20260925072444.18982-1-ayhancicek@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Sep 2026 09:18:43 -0400
X-Gm-Features: AclHuK8CdVe5loQJtszbEolTxrSAmN7yAW4OJnGnOhsKcaA4SE9RM2C-7EHSPEw
Message-ID: <CADnq5_PWzO-UqBJgduTy-X7bYnxSJyBZxL0TcsBue3S9cWyTUw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: extend MacBook VRAM-at-0 workaround to VERDE
To: =?UTF-8?B?QXloYW4gw4dpw6dlaw==?= <ayhancicek@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch
Content-Type: multipart/mixed; boundary="0000000000008403f5065c4e8ffd"
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

--0000000000008403f5065c4e8ffd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 3:46=E2=80=AFAM Ayhan =C3=87i=C3=A7ek <ayhancicek@g=
mail.com> wrote:
>
> The existing MacBook workaround reserves VRAM at address 0 for
> Polaris ASICs when the iGPU is enabled. This prevents cursor
> allocations from landing at address 0.
>
> A MacBookPro11,5 with Radeon R9 M370X (VERDE) hits the same
> failure mode. Hardware cursor updates repeatedly log
> "DC: Cursor address is 0!" followed by
> "DC failed to set cursor attributes".
>
> Extend the existing workaround to CHIP_VERDE. With this change,
> hardware cursor operation is stable, the cursor errors remain at
> zero during repeated cursor movement, and cursor disappearance
> and flicker are no longer observed.

Sounds like this may be consistent for most or all Macs.  How about
something like the attached patch?

Alex

>
> Signed-off-by: Ayhan =C3=87i=C3=A7ek <ayhancicek@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 1bf2a42fa..9e7f9cc2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1086,6 +1086,7 @@ void amdgpu_gmc_init_vga_resv_regions(struct amdgpu=
_device *adev)
>         case CHIP_RENOIR:
>                 adev->mman.keep_stolen_vga_memory =3D true;
>                 break;
> +       case CHIP_VERDE:
>         case CHIP_POLARIS10:
>         case CHIP_POLARIS11:
>         case CHIP_POLARIS12:
> --
> 2.55.0
>

--0000000000008403f5065c4e8ffd
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-make-Mac-FB-workaround-generic.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-make-Mac-FB-workaround-generic.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mugzl7210>
X-Attachment-Id: f_mugzl7210

RnJvbSBhOTIzODRiNzdhZjM4MTgzMTBiNDcxYzllZjA0ODRhMWE2NGU4MTY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IEZyaSwgMjUgU2VwIDIwMjYgMDk6MTY6MjYgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBtYWtlIE1hYyBGQiB3b3JrYXJvdW5kIGdlbmVyaWMKClJhdGhlciB0aGFu
IGFkZGluZyBhIGNhc2Ugb2YgZXZlcnkgY2hpcCB3aGVyZSB0aGlzIGlzIHNlZW4KanVzdCBjaGVj
ayBpZiB0aGUgRkIgaXMgYXQgMCBhbmQgdGhlIHNzaWQgaXMgYXBwbGUuICBUaGlzCnNob3VsZCBj
b3ZlciBhbGwgY2hpcHMgd2hpY2ggZmFsbCBpbnRvIHRoaXMgY2FzZS4KClNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgfCAxNyArKysrKysrLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jCmluZGV4IDFiZjJhNDJmYTYzY2UuLjkyYjMyMjE1
OTBmYjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKQEAgLTEwODYs
MjAgKzEwODYsMTcgQEAgdm9pZCBhbWRncHVfZ21jX2luaXRfdmdhX3Jlc3ZfcmVnaW9ucyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAljYXNlIENISVBfUkVOT0lSOgogCQlhZGV2LT5tbWFu
LmtlZXBfc3RvbGVuX3ZnYV9tZW1vcnkgPSB0cnVlOwogCQlicmVhazsKLQljYXNlIENISVBfUE9M
QVJJUzEwOgotCWNhc2UgQ0hJUF9QT0xBUklTMTE6Ci0JY2FzZSBDSElQX1BPTEFSSVMxMjoKLQkJ
LyogTWFjQm9va1Byb3Mgd2l0aCBzd2l0Y2hhYmxlIGdyYXBoaWNzIHB1dCBWUkFNIGF0IDAgd2hl
bgotCQkgKiB0aGUgaUdQVSBpcyBlbmFibGVkIHdoaWNoIHJlc3VsdHMgaW4gY3Vyc29yIGlzc3Vl
cyBpZgotCQkgKiB0aGUgY3Vyc29yIGVuZHMgdXAgYXQgMC4gIFJlc2VydmUgdnJhbSBhdCAwIGlu
IHRoYXQgY2FzZS4KLQkJICovCi0JCWlmIChhZGV2LT5nbWMudnJhbV9zdGFydCA9PSAwKQotCQkJ
YWRldi0+bW1hbi5rZWVwX3N0b2xlbl92Z2FfbWVtb3J5ID0gdHJ1ZTsKLQkJYnJlYWs7CiAJZGVm
YXVsdDoKIAkJYWRldi0+bW1hbi5rZWVwX3N0b2xlbl92Z2FfbWVtb3J5ID0gZmFsc2U7CiAJCWJy
ZWFrOwogCX0KKwkvKiBNYWNCb29rUHJvcyB3aXRoIHN3aXRjaGFibGUgZ3JhcGhpY3MgcHV0IFZS
QU0gYXQgMCB3aGVuCisJICogdGhlIGlHUFUgaXMgZW5hYmxlZCB3aGljaCByZXN1bHRzIGluIGN1
cnNvciBpc3N1ZXMgaWYKKwkgKiB0aGUgY3Vyc29yIGVuZHMgdXAgYXQgMC4gIFJlc2VydmUgdnJh
bSBhdCAwIGluIHRoYXQgY2FzZS4KKwkgKi8KKwlpZiAoKGFkZXYtPnBkZXYtPnN1YnN5c3RlbV92
ZW5kb3IgPT0gUENJX1ZFTkRPUl9JRF9BUFBMRSkgJiYKKwkgICAgKGFkZXYtPmdtYy52cmFtX3N0
YXJ0ID09IDApKQorCQlhZGV2LT5tbWFuLmtlZXBfc3RvbGVuX3ZnYV9tZW1vcnkgPSB0cnVlOwog
CiAJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSB8fAogCSAgICAhYW1kZ3B1X2RldmljZV9oYXNf
ZGlzcGxheV9oYXJkd2FyZShhZGV2KSkgewotLSAKMi41NS4wCgo=
--0000000000008403f5065c4e8ffd--
