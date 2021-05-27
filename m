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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8D0C4708A
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B38C613D4
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B38C613D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88F26EDFD;
	Thu, 27 May 2021 03:43:06 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593336EDF9;
 Thu, 27 May 2021 03:43:05 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 69-20020a9d0a4b0000b02902ed42f141e1so3156960otg.2; 
 Wed, 26 May 2021 20:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jfHExiAwx1yhDJ7z9SPOraFBPqMXoh5n46J3TLD6IxI=;
 b=qCrx8FvXM97lUfDQtGc7hqeqQ944hYWWSoZujRCyYfzaH2s5JMDv2t2lz5CDYr8a4Y
 RdafEpU06bBsenrmamIC2itw/iiggx/c8Rzq+H6/Z6je69wxAOlgrSenGLJhTxZ1f8vU
 3VegTt+cwG8QpP0YCRg2HEaApzeqy9m2YmRI1GFSSsxZnaxrLm+nLUHCvamNrv1LmqwX
 JnvuRQEKuANxoS7lJlLC7H2mQnaoiPzkcrDVygrPJ2JXOQmmI7UzucPCas1t778Umb5k
 0d6kKCIh6v0DwJcdZgXB9P9jQlmnX9K/Z7G6DP6U2uQi+Nb/gqn2TWQxSJjaWKxJU2Ji
 FUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jfHExiAwx1yhDJ7z9SPOraFBPqMXoh5n46J3TLD6IxI=;
 b=LaHoKUF23aGnHtxDOz4c8MJE9yYIVcjH8pyBncrrrZmBf4clNpuV0sXdFbmLDanCSo
 gA0kep5Zq0KgQtdNy145als3mTlIKodIYfC0CynrjtsAUsum10D5KZ8wbfs4RvwKjIEF
 I5mgfncHgqgdo5kc/jPhV4c6dZYGK9DbinQi8/r3npvbNJaoqhRTQNCkj87+R1IBhWUj
 tDicZACBjcxEA2alnhP5Y2qoZVRD/oGepYcOQfEyPVa2heultcvHPygwzybzDZiIBtWv
 2FLbunBbTIq/NP0L/wtc4pQKA3H7DqZFcX94DumdBxeHAM6GMCnVAmrD0mi0olcCVaj8
 8c/A==
X-Gm-Message-State: AOAM531w82iv9CQQ5dnp2nUKUQbmF/PI0KETSEEvRqR5vHDVf8DJDlXL
 hbzgIfx+79pUtZ5G57qFcWTaV1Niei07zbnGyXw=
X-Google-Smtp-Source: ABdhPJyZnqxxgDnJ6PHbltuqV9e7YpgMP1k4fxHJNb1XSn7Xny5N88vOTGA/oxzG3Dqra1oAamTpwHWFw2t+Zsk06wA=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1174607otl.311.1622086984587; 
 Wed, 26 May 2021 20:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-2-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-2-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 23:42:53 -0400
Message-ID: <CADnq5_PhozjNvOjvoMQRr-oqNz_vOjHtuW45wCK80jHKYscV7A@mail.gmail.com>
Subject: Re: [PATCH 01/34] drm/amd/pm/inc/smu_v13_0: Move table into the only
 source file that uses it
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
Cc: David Airlie <airlied@linux.ie>, Kevin Wang <kevin1.wang@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDcgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9wbS9pbmMvc211X3YxM18wLmg6NTQ6NDM6IHdhcm5pbmc6IOKAmHNtdTEzX3RoZXJt
YWxfcG9saWN54oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJs
ZT1dCj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+Cj4gQ2M6IEtldmluIFdhbmcgPGtldmluMS53YW5nQGFtZC5jb20+Cj4gQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
Pgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9zbXVfdjEzXzAuaCAgICAgICAg
ICAgICB8IDYgLS0tLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxk
ZWJhcmFuX3BwdC5jIHwgNiArKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9pbmMvc211X3YxM18wLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9zbXVfdjEzXzAu
aAo+IGluZGV4IDE2ODc3MDk1MDdiM2QuLjYxMTlhMzZiMmNiYTAgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvc211X3YxM18wLmgKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL2luYy9zbXVfdjEzXzAuaAo+IEBAIC01MSwxMiArNTEsNiBAQAo+ICAjZGVmaW5l
IENURl9PRkZTRVRfSE9UU1BPVCAgICAgICAgICAgICA1Cj4gICNkZWZpbmUgQ1RGX09GRlNFVF9N
RU0gICAgICAgICAgICAgICAgIDUKPgo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IHNtdV90ZW1wZXJh
dHVyZV9yYW5nZSBzbXUxM190aGVybWFsX3BvbGljeVtdID0KPiAtewo+IC0gICAgICAgey0yNzMx
NTAsICA5OTAwMCwgOTkwMDAsIC0yNzMxNTAsIDk5MDAwLCA5OTAwMCwgLTI3MzE1MCwgOTkwMDAs
IDk5MDAwfSwKPiAtICAgICAgIHsgMTIwMDAwLCAxMjAwMDAsIDEyMDAwMCwgMTIwMDAwLCAxMjAw
MDAsIDEyMDAwMCwgMTIwMDAwLCAxMjAwMDAsIDEyMDAwMH0sCj4gLX07Cj4gLQo+ICBzdHJ1Y3Qg
c211XzEzXzBfbWF4X3N1c3RhaW5hYmxlX2Nsb2NrcyB7Cj4gICAgICAgICB1aW50MzJfdCBkaXNw
bGF5X2Nsb2NrOwo+ICAgICAgICAgdWludDMyX3QgcGh5X2Nsb2NrOwo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jCj4gaW5kZXggZDYy
Y2M2YmIxYTMwNS4uZDZjZTY2NWJhYWYzYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jCj4gQEAgLTc4LDYgKzc4LDEyIEBA
Cj4KPiAgI2RlZmluZSBzbW5QQ0lFX0VTTV9DVFJMICAgICAgICAgICAgICAgICAgICAgICAweDEx
MTAwM0QwCj4KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBzbXVfdGVtcGVyYXR1cmVfcmFuZ2Ugc211
MTNfdGhlcm1hbF9wb2xpY3lbXSA9Cj4gK3sKPiArICAgICAgIHstMjczMTUwLCAgOTkwMDAsIDk5
MDAwLCAtMjczMTUwLCA5OTAwMCwgOTkwMDAsIC0yNzMxNTAsIDk5MDAwLCA5OTAwMH0sCj4gKyAg
ICAgICB7IDEyMDAwMCwgMTIwMDAwLCAxMjAwMDAsIDEyMDAwMCwgMTIwMDAwLCAxMjAwMDAsIDEy
MDAwMCwgMTIwMDAwLCAxMjAwMDB9LAo+ICt9Owo+ICsKPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBj
bW4yYXNpY19tc2dfbWFwcGluZyBhbGRlYmFyYW5fbWVzc2FnZV9tYXBbU01VX01TR19NQVhfQ09V
TlRdID0gewo+ICAgICAgICAgTVNHX01BUChUZXN0TWVzc2FnZSwgICAgICAgICAgICAgICAgICAg
ICAgICAgUFBTTUNfTVNHX1Rlc3RNZXNzYWdlLCAgICAgICAgICAgICAgICAgICAgIDApLAo+ICAg
ICAgICAgTVNHX01BUChHZXRTbXVWZXJzaW9uLCAgICAgICAgICAgICAgICAgICAgICAgUFBTTUNf
TVNHX0dldFNtdVZlcnNpb24sICAgICAgICAgICAgICAgICAgIDEpLAo+IC0tCj4gMi4zMS4xCj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
