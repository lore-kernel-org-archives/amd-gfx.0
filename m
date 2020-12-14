Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7827C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 09:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C40E207A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 09:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C40E207A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C799F6E10D;
	Mon, 14 Dec 2020 09:07:53 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5336E10D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 09:07:53 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id b73so16332468edf.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 01:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=QZvCgud633hUuByyafyDUUPjz7SggVoWKk8fA5FA1p8=;
 b=NKTZWTdDtQA7ur+zmVUljJRoOYc4wB/jyqSwq509xuKJDNYVmNYITVymiWMsbQFiTn
 o0ejTTKWvaNIrWVJKeLZsZumm5hTI+OaRvtxStEzIHivKUq97lvMfB4a0mhmQB4tgQjV
 I7w3gAFOjRJ7+UJXdSgI4u9NNRCy2cCc4T/Lqj9PeiPPruQYpuFRSFRZBKqcfGG/NEph
 S5uvRU+WA+cVPVcTjOwToqK+gxHmcWX7ujPnWXlBKyFuV1AK4dXvtfEytAkLNda3TQV2
 bJ3IdJPPGiNC/6EL9hhKPMAeoGeJpX6TQjaf7CJ5hRfZkPwKPHy717PnQHvcH1jBt1sy
 XPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QZvCgud633hUuByyafyDUUPjz7SggVoWKk8fA5FA1p8=;
 b=nJrh3EoEAe4AgxPsKkhf+owaBzUg9Svek38vry0vqEA2AWhwM+mCEPaF+CgyS1NSsO
 dJuJYsO2Iln2W5RKDp9B6E9SRr+6DDsJdynPgz14HtmbPdQzqtfYeiUcFXWm64jGnpog
 5VYUJbLmYVDvuXzBFe3F5He75tOczgE59+UI9q5e0fjXkwZGYwfgQ42qb8q+gm8YhEhI
 wjknfPCMeGQlSD9B89zStrhGUR4kXq1CyeCwraFUDbcvm/irheu0o5cgdbjVbsFXE5DH
 NzCAyc8sNzQvf/PL8CzqcaS1JC5bngpWgEcOx7t4ibGx7CBy+OUgJzE/lzrx2maCkTtt
 S+8A==
X-Gm-Message-State: AOAM533M+KeMzsJ4VFKvvkxMhijX0SXmor97VYzTgsuckVh9oyAaGB43
 6+BBxnaf2FJ+TFfS8vIBylGF9e/B+qY=
X-Google-Smtp-Source: ABdhPJy9dSABslVsthkt5chD7bneZkWuiRqB98STUtdJJctwqW++4el5YRnp/XB4Mgish5fKE+0eAg==
X-Received: by 2002:a50:e84d:: with SMTP id k13mr23363100edn.154.1607936871945; 
 Mon, 14 Dec 2020 01:07:51 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f17sm14908935edv.5.2020.12.14.01.07.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Dec 2020 01:07:51 -0800 (PST)
Subject: Re: [PATCH 26/27] drm/amdgpu: drop ih reroute function from psp v11
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
 <20201212154600.21618-26-Hawking.Zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8a473200-7a0b-abc8-8254-3bbd63d83f80@gmail.com>
Date: Mon, 14 Dec 2020 10:07:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201212154600.21618-26-Hawking.Zhang@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMTIuMjAgdW0gMTY6NDUgc2NocmllYiBIYXdraW5nIFpoYW5nOgo+IEZvciBhbGwgdGhl
IEFTSUNzIHRoYXQgaW50ZWdyYXRlIHBzcCB2MTEsIHZlZ2EyMAo+IGRvZXNuJ3Qgc3VwcG9ydCBp
aCByZXJvdXRlLiBhcmN0dXJ1cyBhbmQgbGF0ZXIgd2lsbAo+IGFsbG93IGtlcm5lbCBkcml2ZXIg
dG8gcHJvZ3JhbSBpaF9jZmdfaW5kZXgvZGF0YQo+IHRocm91Z2ggbW1pbyBkaXJlY3RseS4gbmF2
aTF4IGFuZCBvbndhcmRzIHdpbGwgb25seQo+IHN1cHBvcnQgZ3JiX2loX3NldCBjb21tYW5kIGlu
IHNyaW92IGNvbmZpZ3VyYXRpb24uCj4KPiBwc3BfdjExXzBfcmVyb3V0ZV9paCBpcyBub3QgbmVl
ZGVkIGFueSBtb3JlLgo+Cj4gU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPgoKVGhlIG9yaWdpbmFsIHBsYW4gd2FzIHRvIGltcGxlbWVudCB0aGlzIGZv
ciBWZWdhMjAgYXMgd2VsbCwgYnV0IHNpbmNlIGl0IApsb29rcyBsaWtlIHdlIG5ldmVyIGdldCB0
aGF0IGl0IGlzIHByb2JhYmx5IGJlc3QgdG8gcmVtb3ZlIHRoaXMuCgpQYXRjaCBpcyBSZXZpZXdl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jIHwgMzYgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNiBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jCj4gaW5kZXggYmQ0MjQ4YzkzYzQ5
Li5hNzM4YTdkN2UzODMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
cHNwX3YxMV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAu
Ywo+IEBAIC0zOTIsMzcgKzM5Miw2IEBAIHN0YXRpYyBpbnQgcHNwX3YxMV8wX2Jvb3Rsb2FkZXJf
bG9hZF9zb3Moc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCj4gICAJcmV0dXJuIHJldDsKPiAgIH0K
PiAgIAo+IC1zdGF0aWMgdm9pZCBwc3BfdjExXzBfcmVyb3V0ZV9paChzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCkKPiAtewo+IC0Jc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwc3AtPmFkZXY7
Cj4gLQl1aW50MzJfdCB0bXA7Cj4gLQo+IC0JLyogQ2hhbmdlIElIIHJpbmcgZm9yIFZNQyAqLwo+
IC0JdG1wID0gUkVHX1NFVF9GSUVMRCgwLCBJSF9DTElFTlRfQ0ZHX0RBVEEsIENSRURJVF9SRVRV
Uk5fQUREUiwgMHgxMjQ0Yik7Cj4gLQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgSUhfQ0xJRU5U
X0NGR19EQVRBLCBDTElFTlRfVFlQRSwgMSk7Cj4gLQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwg
SUhfQ0xJRU5UX0NGR19EQVRBLCBSSU5HX0lELCAxKTsKPiAtCj4gLQlXUkVHMzJfU09DMTUoTVAw
LCAwLCBtbU1QMF9TTU5fQzJQTVNHXzY5LCAzKTsKPiAtCVdSRUczMl9TT0MxNShNUDAsIDAsIG1t
TVAwX1NNTl9DMlBNU0dfNzAsIHRtcCk7Cj4gLQlXUkVHMzJfU09DMTUoTVAwLCAwLCBtbU1QMF9T
TU5fQzJQTVNHXzY0LCBHRlhfQ1RSTF9DTURfSURfR0JSX0lIX1NFVCk7Cj4gLQo+IC0JbWRlbGF5
KDIwKTsKPiAtCXBzcF93YWl0X2Zvcihwc3AsIFNPQzE1X1JFR19PRkZTRVQoTVAwLCAwLCBtbU1Q
MF9TTU5fQzJQTVNHXzY0KSwKPiAtCQkgICAgIDB4ODAwMDAwMDAsIDB4ODAwMEZGRkYsIGZhbHNl
KTsKPiAtCj4gLQkvKiBDaGFuZ2UgSUggcmluZyBmb3IgVU1DICovCj4gLQl0bXAgPSBSRUdfU0VU
X0ZJRUxEKDAsIElIX0NMSUVOVF9DRkdfREFUQSwgQ1JFRElUX1JFVFVSTl9BRERSLCAweDEyMTZi
KTsKPiAtCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBJSF9DTElFTlRfQ0ZHX0RBVEEsIFJJTkdf
SUQsIDEpOwo+IC0KPiAtCVdSRUczMl9TT0MxNShNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0dfNjks
IDQpOwo+IC0JV1JFRzMyX1NPQzE1KE1QMCwgMCwgbW1NUDBfU01OX0MyUE1TR183MCwgdG1wKTsK
PiAtCVdSRUczMl9TT0MxNShNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0dfNjQsIEdGWF9DVFJMX0NN
RF9JRF9HQlJfSUhfU0VUKTsKPiAtCj4gLQltZGVsYXkoMjApOwo+IC0JcHNwX3dhaXRfZm9yKHBz
cCwgU09DMTVfUkVHX09GRlNFVChNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0dfNjQpLAo+IC0JCSAg
ICAgMHg4MDAwMDAwMCwgMHg4MDAwRkZGRiwgZmFsc2UpOwo+IC19Cj4gLQo+ICAgc3RhdGljIGlu
dCBwc3BfdjExXzBfcmluZ19pbml0KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLAo+ICAgCQkJICAg
ICAgZW51bSBwc3BfcmluZ190eXBlIHJpbmdfdHlwZSkKPiAgIHsKPiBAQCAtNDMwLDExICszOTks
NiBAQCBzdGF0aWMgaW50IHBzcF92MTFfMF9yaW5nX2luaXQoc3RydWN0IHBzcF9jb250ZXh0ICpw
c3AsCj4gICAJc3RydWN0IHBzcF9yaW5nICpyaW5nOwo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gcHNwLT5hZGV2Owo+ICAgCj4gLQlpZiAoKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikp
ICYmCj4gLQkgICAgIShhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9TSUVOTkFfQ0lDSExJRCAmJgo+
IC0JICAgIGFkZXYtPmFzaWNfdHlwZSA8PSBDSElQX0RJTUdSRVlfQ0FWRUZJU0gpKQo+IC0JCXBz
cF92MTFfMF9yZXJvdXRlX2loKHBzcCk7Cj4gLQo+ICAgCXJpbmcgPSAmcHNwLT5rbV9yaW5nOwo+
ICAgCj4gICAJcmluZy0+cmluZ190eXBlID0gcmluZ190eXBlOwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
