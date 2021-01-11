Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AE8C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 21:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D7522CB2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 21:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D7522CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA44089C55;
	Mon, 11 Jan 2021 21:51:22 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97DE89C52;
 Mon, 11 Jan 2021 21:51:21 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id m25so187754lfc.11;
 Mon, 11 Jan 2021 13:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DpKyJxgz/kDKF4w0QpSfkKSwc8QdmlZ1/wqnkxJFVtg=;
 b=J2gN7DigSzXMjR26SwttE56zrz3W7Z/uQLQTd9ukj6qbovk7M4cha2CVykXPj1z27E
 eM5WNGtPQiyxQQEKmXlxiEoeEcqT2JIle40AuTsIqVtaNzwYBYmlOpFxOLc6PegL8l+e
 AC1AFKVJLqrRIKamd5fVKlbC+3YMudrOf2/dzHCOrxJ7wQ/TO3tdoia8h7zQMdNUsjC/
 ATLgSLJBM+dKVo49BXA4Poqf5prCTuiTSLayZaSK5siCj0yrxG2m1HqVTOPb8RzZdmoH
 CeDzp7g+uCVQ/Hqlzm+rDvBDbg2tIrQH6hJ+yZp0tla1IxfLtU0xQrNQ6og+P5u+LgiY
 ItUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DpKyJxgz/kDKF4w0QpSfkKSwc8QdmlZ1/wqnkxJFVtg=;
 b=fT6kxxAtnqojee/q4heoLsY/q/fmfDasOJvRbfLVfxWaX7MhZ2z05VbYux32WMmn+0
 LYHEuQcMZELdGhNFvqX70KPU8yvyhrzYff+Ab+c5qtNUDGUUAVvhTn6qRIpluBDR5vZ/
 xvsM9/RNkShmRLvYi0CPx30ivpXy9Z6GdRSzlfkBt8rxlLznMvZl38lfdsp9P57bOiL9
 0gttjLEJmr2xfba7M27i1EFbhUoOSB/2gYSwZKksLIFPH4fKicAN9v1oDhoEFTzIFeSG
 ojiFijC1qPyOaMzC1V62OJD8aQDp+7g+P0yffFsSUwy26biMvIppx78VU7m/rXX+tiBZ
 3tJA==
X-Gm-Message-State: AOAM533l4n2FWpu8a6BG1ggYEcenSSD1orqOUKlchAAwgxPwc7NaAUzo
 hGWrjxuI61BeX6ZU0J2oAis5gEo9WHpPOPwMmPo=
X-Google-Smtp-Source: ABdhPJzc6UzGgMcUd8OAMsFVuBKMHsr4j4AmR+jXSc8W8Sqa3i89zVWlmMuvasJGl8v8499zHcSd/VQ1jl2hCeiQ9SU=
X-Received: by 2002:a19:cb45:: with SMTP id b66mr708982lfg.441.1610401879923; 
 Mon, 11 Jan 2021 13:51:19 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
 <816e944c-72bc-d94d-449f-bfb915382290@amd.com>
 <6e55d84c-7b9a-167c-34cf-9e980f8e2354@amd.com>
 <CABXGCsM8yYNz7gQW26a4hHwBR+MunXoopHEiyDJdC-muNrRxkQ@mail.gmail.com>
 <77b696b9-3248-d329-4f7d-5e27a21eabff@amd.com>
In-Reply-To: <77b696b9-3248-d329-4f7d-5e27a21eabff@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 12 Jan 2021 02:51:08 +0500
Message-ID: <CABXGCsMYkKrrTw3DTPJjLq+6oQnyXATCYi0DbqkO_UuYjvJjLg@mail.gmail.com>
Subject: Re: [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
 framebuffer with error -12
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKT24gVHVlLCAxMiBKYW4gMjAyMSBhdCAwMTo0NSwgQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEhpIE1pa2UsCj4KPiBV
bmZvcnR1bmF0ZWx5IG5vdCwgdGhhdCdzIERDIHN0dWZmLiBFYXNpZXN0IGlzIHRvIGFzc2lnbiB0
aGlzIGFzIGEgYnVnCj4gdHJhY2tlciB0byBvdXIgREMgdGVhbS4KT2sKCj4gQXQgbGVhc3Qgc29t
ZSBwcm9ncmVzcy4gQW55IG9iamVjdGlvbnMgdGhhdCBJIGFkZCB5b3VyIGUtbWFpbCBhZGRyZXNz
IGFzCj4gdGVzdGVkLWJ5IHRhZz8KWWVzLCBmZWVsIGZyZWUgYWRkIG1lLgoKPiBJIGNhbiB0YWtl
IGEgbG9vayBhdCB0aGlzIG9uZSBoZXJlLiBMb29rcyBsaWtlIHNvbWUgbWlzc2luZyBlcnJvcgo+
IGhhbmRsaW5nIHdoZW4gYWxsb2NhdGluZyBtZW1vcnkuCj4gQ2FuIHlvdSBkZWNvZGUgdG8gd2hp
Y2ggbGluZSBudW1iZXIgdHRtX3R0X3N3YXBpbisweDM0IHBvaW50cyB0bz8KJCAvdXNyL3NyYy9r
ZXJuZWxzL2B1bmFtZSAtcmAvc2NyaXB0cy9mYWRkcjJsaW5lCi9saWIvZGVidWcvbGliL21vZHVs
ZXMvYHVuYW1lCi1yYC9rZXJuZWwvZHJpdmVycy9ncHUvZHJtL3R0bS90dG0ua28uZGVidWcgdHRt
X3R0X3N3YXBpbisweDM0CnR0bV90dF9zd2FwaW4rMHgzNC8weGQwOgptYXBwaW5nX2dmcF9tYXNr
IGF0Ci91c3Ivc3JjL2RlYnVnL2tlcm5lbC0yMDIxMDEwOGdpdGY1ZTZjMzMwMjU0YS9saW51eC01
LjExLjAtMC5yYzIuMjAyMTAxMDhnaXRmNWU2YzMzMDI1NGEuMTIwLmZjMzQueDg2XzY0Ly4vaW5j
bHVkZS9saW51eC9wYWdlbWFwLmg6MTA1CihkaXNjcmltaW5hdG9yIDIpCihpbmxpbmVkIGJ5KSB0
dG1fdHRfc3dhcGluIGF0Ci91c3Ivc3JjL2RlYnVnL2tlcm5lbC0yMDIxMDEwOGdpdGY1ZTZjMzMw
MjU0YS9saW51eC01LjExLjAtMC5yYzIuMjAyMTAxMDhnaXRmNWU2YzMzMDI1NGEuMTIwLmZjMzQu
eDg2XzY0L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmM6MjEwCihkaXNjcmltaW5hdG9yIDIp
CgokIGNhdCAtcyAtbiAvdXNyL3NyYy9kZWJ1Zy9rZXJuZWwtMjAyMTAxMDhnaXRmNWU2YzMzMDI1
NGEvbGludXgtNS4xMS4wLTAucmMyLjIwMjEwMTA4Z2l0ZjVlNmMzMzAyNTRhLjEyMC5mYzM0Lng4
Nl82NC9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90dC5jCnwgaGVhZCAtMjIwIHwgdGFpbCAtMjAK
ICAgMjAxICAgICAgc3RydWN0IHBhZ2UgKmZyb21fcGFnZTsKICAgMjAyICAgICAgc3RydWN0IHBh
Z2UgKnRvX3BhZ2U7CiAgIDIwMyAgICAgIGdmcF90IGdmcF9tYXNrOwogICAyMDQgICAgICBpbnQg
aSwgcmV0OwogICAyMDUKICAgMjA2ICAgICAgc3dhcF9zdG9yYWdlID0gdHRtLT5zd2FwX3N0b3Jh
Z2U7CiAgIDIwNyAgICAgIEJVR19PTihzd2FwX3N0b3JhZ2UgPT0gTlVMTCk7CiAgIDIwOAogICAy
MDkgICAgICBzd2FwX3NwYWNlID0gc3dhcF9zdG9yYWdlLT5mX21hcHBpbmc7CiAgIDIxMCAgICAg
IGdmcF9tYXNrID0gbWFwcGluZ19nZnBfbWFzayhzd2FwX3NwYWNlKTsKICAgMjExCiAgIDIxMiAg
ICAgIGZvciAoaSA9IDA7IGkgPCB0dG0tPm51bV9wYWdlczsgKytpKSB7CiAgIDIxMyAgICAgICAg
ICBmcm9tX3BhZ2UgPSBzaG1lbV9yZWFkX21hcHBpbmdfcGFnZV9nZnAoc3dhcF9zcGFjZSwgaSwK
ICAgMjE0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2ZwX21hc2spOwogICAyMTUgICAg
ICAgICAgaWYgKElTX0VSUihmcm9tX3BhZ2UpKSB7CiAgIDIxNiAgICAgICAgICAgICAgcmV0ID0g
UFRSX0VSUihmcm9tX3BhZ2UpOwogICAyMTcgICAgICAgICAgICAgIGdvdG8gb3V0X2VycjsKICAg
MjE4ICAgICAgICAgIH0KICAgMjE5ICAgICAgICAgIHRvX3BhZ2UgPSB0dG0tPnBhZ2VzW2ldOwog
ICAyMjAgICAgICAgICAgaWYgKHVubGlrZWx5KHRvX3BhZ2UgPT0gTlVMTCkpIHsKCj4gUGxlYXNl
IHVzZSB0aGlzIG9uZSBoZXJlOgo+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0v
YW1kLy0vaXNzdWVzL25ldwo+Cj4gSWYgeW91IGNhbid0IGZpbmQgdGhlIERDIGd1eXMgb2YgaGFu
ZCBpbiB0aGUgYXNzaWduZWUgbGlzdCBqdXN0IGFzc2lnbgo+IHRvIG1lIGFuZCBJIHdpbGwgZm9y
d2FyZC4KaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMTQz
OQpPaywgbGV0J3MgY29udGludWUgdGhlcmUuCgotLQpCZXN0IFJlZ2FyZHMsCk1pa2UgR2F2cmls
b3YuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
