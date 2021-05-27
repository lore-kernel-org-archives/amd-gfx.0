Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D04C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05267613C7
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05267613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED1E6EE0B;
	Thu, 27 May 2021 03:57:39 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E776EE07;
 Thu, 27 May 2021 03:57:38 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 r26-20020a056830121ab02902a5ff1c9b81so3144099otp.11; 
 Wed, 26 May 2021 20:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PjGMU2eJY7MAduIGnouTTmy3o2skeXkndWNlCEoNBuQ=;
 b=PTTEEebu/8sQ5ioSNf7911tKuN2wGLLQfH2cQNi0CzqN/ETQH+TsFzI1H25ulvzWQg
 6dLO5o51zMJlGzOzwReSjuFhd+6mUsKx1lkVOYOsnCoE0qOAzzget65iz7HXv3RAc/k4
 8PNoyifj2yNi2rMu8fmGSAyMpKeGwmLwcVfGGqApcdge2vt2altFTs51yH8iD03t6SGq
 vB2MVnygFqkZe5qx+6RmjA5NIsPU6g2O8MJmzUfFoLScITDaarOMdOh4RDbTbrPokdH9
 eBnjHb9PElXrztbqidvTP0SHjKhwb2+jjDXJOlcLF7yXz72zGxRF3v9qs5bZ5+kyAHSZ
 pC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PjGMU2eJY7MAduIGnouTTmy3o2skeXkndWNlCEoNBuQ=;
 b=d//GdbC0fx4TU2trNxzCMPnUowvyjcwnEXm8fjN1sjeUfPU9gROkWBN+PzZB5Y/dlw
 G99F6nvqrjmPfWQMPpVnpYUprKiseBE0o4ncfulG2k8DegZiAHHcb6tCc+hz3xOqiZAL
 TpZgk1XFGFoShyJCR9WNKrwgd5Bm4JOvo/DD9hO6nxHyGhTE/D1xOXch0evKhc7VEuRu
 FcfnioSNcNybEuk5/m6xa8JCJztjZH1ERaItRhv+pB7d6JN+H3M7Yt/E6gYWVHmPQkgL
 662g406DZ2vLqZ5df6QU6TRrEhm80jALnkIvKfH6fmNB5Q12vW4IIXn3DmUbvGEgbnvP
 knUQ==
X-Gm-Message-State: AOAM530LYiUd8SZL6qkYvSseAQ+lCF3KvVQ6G28yJzhUlOVWCwZ2ae9a
 xkte/nGFHUVxRJ/mXEK1tg7wNpxKZJ8KoT8aRJA=
X-Google-Smtp-Source: ABdhPJxl3eiIdARqk0LBovOakNpsqVIr2PbwJ9p56brQbaisMJonCXUkm68X8Ga/Zma/B50jfTWsbguJeMWeeB9pAZY=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr1255345otl.132.1622087857923; 
 Wed, 26 May 2021 20:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-11-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-11-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 23:57:27 -0400
Message-ID: <CADnq5_OteJ0ZZSKqbZ-j3KD7kGajoEyq-F7=VFbruvgxRQC6yQ@mail.gmail.com>
Subject: Re: [PATCH 10/34] drm/amd/display/dc/bios/bios_parser: Fix formatting
 and misnaming issues
To: Lee Jones <lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDcgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIuYzo5OTc6IHdhcm5pbmc6IGV4cGVj
dGluZyBwcm90b3R5cGUgZm9yIGdldF9zc19pbmZvX2Zyb21fdGFibGUoKS4gUHJvdG90eXBlIHdh
cyBmb3IgZ2V0X3NzX2luZm9fZnJvbV90YmwoKSBpbnN0ZWFkCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlci5jOjE1NjI6IHdhcm5pbmc6
IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIEJpb3NQYXJzZXJPYmplY3QoKS4gUHJvdG90eXBlIHdh
cyBmb3IgYmlvc19wYXJzZXJfZ2V0X3NzX2VudHJ5X251bWJlcigpIGluc3RlYWQKPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmM6MTcz
OTogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgZ2V0X3NzX2VudHJ5X251bWJlcl9m
cm9tX2ludGVybmFsX3NzX2luZm9fdGFibGVfVjNfMSgpLiBQcm90b3R5cGUgd2FzIGZvciBnZXRf
c3NfZW50cnlfbnVtYmVyX2Zyb21faW50ZXJuYWxfc3NfaW5mb190YmxfVjNfMSgpIGluc3RlYWQK
Pgo+IENjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPiBDYzogTGVv
IExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFu
aWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxs
ZWUuam9uZXNAbGluYXJvLm9yZz4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2Jpb3MvYmlvc19wYXJzZXIuYyB8IDYgKysrLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMKPiBpbmRleCBjNjdkMjFhNWVlNTJmLi45
YjhlYTZlOWEyYjk2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9iaW9zL2Jpb3NfcGFyc2VyLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvYmlvcy9iaW9zX3BhcnNlci5jCj4gQEAgLTk3OSw3ICs5NzksNyBAQCBzdGF0aWMgZW51bSBi
cF9yZXN1bHQgZ2V0X3NzX2luZm9fZnJvbV9pbnRlcm5hbF9zc19pbmZvX3RibF9WMl8xKAo+ICAg
ICAgICAgc3RydWN0IHNwcmVhZF9zcGVjdHJ1bV9pbmZvICppbmZvKTsKPgo+ICAvKioKPiAtICog
Z2V0X3NzX2luZm9fZnJvbV90YWJsZQo+ICsgKiBnZXRfc3NfaW5mb19mcm9tX3RibAo+ICAgKiBH
ZXQgc3ByZWFkIHNwcmVjdHJ1bSBpbmZvcm1hdGlvbiBmcm9tIHRoZSBBU0lDX0ludGVybmFsU1Nf
SW5mbyBWZXIgMi4xIG9yCj4gICAqIFNTX0luZm8gdGFibGUgZnJvbSB0aGUgVkJJT1MKPiAgICog
VGhlcmUgY2FuIG5vdCBiZSBtb3JlIHRoYW4gMSBlbnRyeSBmb3IgIEFTSUNfSW50ZXJuYWxTU19J
bmZvIFZlciAyLjEgb3IKPiBAQCAtMTU0OCw3ICsxNTQ4LDcgQEAgc3RhdGljIHVpbnQzMl90IGdl
dF9zc19lbnRyeV9udW1iZXJfZnJvbV9zc19pbmZvX3RibCgKPiAgICAgICAgIHVpbnQzMl90IGlk
KTsKPgo+ICAvKioKPiAtICogQmlvc1BhcnNlck9iamVjdDo6R2V0TnVtYmVyb2ZTcHJlYWRTcGVj
dHJ1bUVudHJ5Cj4gKyAqIGJpb3NfcGFyc2VyX2dldF9zc19lbnRyeV9udW1iZXIKPiAgICogR2V0
IE51bWJlciBvZiBTcHJlYWRTcGVjdHJ1bSBFbnRyeSBmcm9tIHRoZSBBU0lDX0ludGVybmFsU1Nf
SW5mbyB0YWJsZSBmcm9tCj4gICAqIHRoZSBWQklPUyB0aGF0IG1hdGNoIHRoZSBTU2lkICh0byBi
ZSBjb252ZXJ0ZWQgZnJvbSBzaWduYWwpCj4gICAqCj4gQEAgLTE3MjUsNyArMTcyNSw3IEBAIHN0
YXRpYyB1aW50MzJfdCBnZXRfc3NfZW50cnlfbnVtYmVyX2Zyb21faW50ZXJuYWxfc3NfaW5mb190
YmxfdjJfMSgKPiAgICAgICAgIHJldHVybiAwOwo+ICB9Cj4gIC8qKgo+IC0gKiBnZXRfc3NfZW50
cnlfbnVtYmVyX2Zyb21faW50ZXJuYWxfc3NfaW5mb190YWJsZV9WM18xCj4gKyAqIGdldF9zc19l
bnRyeV9udW1iZXJfZnJvbV9pbnRlcm5hbF9zc19pbmZvX3RibF9WM18xCj4gICAqIEdldCBOdW1i
ZXIgb2YgU3ByZWFkU3BlY3RydW0gRW50cnkgZnJvbSB0aGUgQVNJQ19JbnRlcm5hbFNTX0luZm8g
dGFibGUgb2YKPiAgICogdGhlIFZCSU9TIHRoYXQgbWF0Y2hlcyBpZAo+ICAgKgo+IC0tCj4gMi4z
MS4xCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
