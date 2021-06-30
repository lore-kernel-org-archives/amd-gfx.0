Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E3FC11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 11:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A1B613EE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 11:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A1B613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3B76E98F;
	Wed, 30 Jun 2021 11:14:38 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB1366E993
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 11:14:36 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id t3so2663319edc.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 04:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=VDatxhlQogKy9pn0kXTMuaHAxvtXaO/yhwZcdOjU/EM=;
 b=ZkdGw2tsC5AT7xZPzzMge7IdInwNOsXs/Ev5intsr9peSvgLp2ImxPVGOTDLsa0m+Q
 C4x7JWGCfLtJL4KtcB8svM6raIlXMxU+DJOipGaT5Hy4bG44Lzm6waeK6agMmDt69T8b
 HkmR7UUQDlK30rCl99PXXYtRsnapUa1ooy/KAZG/Hw5dXolkimc8FCpsnZoyeAMDLqYV
 183j6HzPUukIg8GF980cVkPkzveaMD8AKI490ODFh9aht0VgalvAKk83dQS9wvXqauQr
 8RK6Qkmj4HdybQGleNM4auO7qR0Ju1HMPbNFZSjiHAJRMAeNKcCZsO8fFetDudR8IZCB
 xmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=VDatxhlQogKy9pn0kXTMuaHAxvtXaO/yhwZcdOjU/EM=;
 b=SRBeawk8cz8DeeVWrAKUF/mEBPhPwpmDNvHc2KGDyGSccPEY5YST97T57OncwY6Ayp
 tjgrtdTcypmqgh4zRRublW3t0rfm/hmpXVYtmqumVJDDlp8fImh5zIqC9xUtEPiHGsjn
 boTBxEZ+qZ8eh/x/O2YK79SeksQ3qWoH3Bn5qxOrTbZ7+V4mnBr5B8t+nG0anxJjZkE6
 Ph2eqsnYkD38W5lZ2SKvAECPz1IAbLD+O1Pht5gEkoBnoytoEVv8suA1G6rpCgkl2vgS
 rp8//ijipVGwKyWIe9OsV8p6LGpFX2hmHfG/EIqrqF6/5wD3ZiNaXFCvkHBVsDS0rR/A
 l6sw==
X-Gm-Message-State: AOAM533ClnfYeWDq93GPBoPgmY/nuOHSdq4lpQckie+KYpQde+q7myn2
 3hdzJpeSiVBIEKZupvD5tXg=
X-Google-Smtp-Source: ABdhPJw8giOFw8ePaOnLJi54aN2qCdbz2Bbe0CCMjzkh2P5iSrBJDEHKm1gWJEM8EPPPrgx6XVJpBQ==
X-Received: by 2002:aa7:da02:: with SMTP id r2mr27076617eds.350.1625051675333; 
 Wed, 30 Jun 2021 04:14:35 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:fd79:22d7:4c21:2421?
 ([2a02:908:1252:fb60:fd79:22d7:4c21:2421])
 by smtp.gmail.com with ESMTPSA id i4sm886686edt.34.2021.06.30.04.14.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jun 2021 04:14:34 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay (v4)
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210630101012.2006307-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <93f00743-d94f-41de-c0a1-9b6b2391e74e@gmail.com>
Date: Wed, 30 Jun 2021 13:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630101012.2006307-1-YuBiao.Wang@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzAuMDYuMjEgdW0gMTI6MTAgc2NocmllYiBZdUJpYW8gV2FuZzoKPiBbV2h5XQo+IEdQVSB0
aW1pbmcgY291bnRlcnMgYXJlIHJlYWQgdmlhIEtJUSB1bmRlciBzcmlvdiwgd2hpY2ggd2lsbCBp
bnRyb2R1Y2UKPiBhIGRlbGF5Lgo+Cj4gW0hvd10KPiBJdCBjb3VsZCBiZSBkaXJlY3RseSByZWFk
IGJ5IE1NSU8uCj4KPiB2MjogQWRkIGFkZGl0aW9uYWwgY2hlY2sgdG8gcHJldmVudCBjYXJyeW92
ZXIgaXNzdWUuCj4gdjM6IE9ubHkgY2hlY2sgZm9yIGNhcnJ5b3ZlciBmb3Igb25jZSB0byBwcmV2
ZW50IHBlcmZvcm1hbmNlIGlzc3VlLgo+IHY0OiBBZGQgY29tbWVudHMgb2YgdGhlIHJvdWdoIGZy
ZXF1ZW5jeSB3aGVyZSBjYXJyeW92ZXIgaGFwcGVucy4KPgo+IFNpZ25lZC1vZmYtYnk6IFl1Qmlh
byBXYW5nIDxZdUJpYW8uV2FuZ0BhbWQuY29tPgo+IEFja2VkLWJ5OiBIb3JhY2UgQ2hlbiA8aG9y
YWNlLmNoZW5AYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jIHwgMTMgKysrKysrKysrKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYwo+IGluZGV4IGZmN2U5ZjQ5MDQwZS4uOTM1NTQ5NDAwMmExIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiBAQCAtNzYwOSw3ICs3NjA5LDcgQEAgc3Rh
dGljIGludCBnZnhfdjEwXzBfc29mdF9yZXNldCh2b2lkICpoYW5kbGUpCj4gICAKPiAgIHN0YXRp
YyB1aW50NjRfdCBnZnhfdjEwXzBfZ2V0X2dwdV9jbG9ja19jb3VudGVyKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQo+ICAgewo+IC0JdWludDY0X3QgY2xvY2s7Cj4gKwl1aW50NjRfdCBjbG9j
aywgY2xvY2tfbG8sIGNsb2NrX2hpLCBoaV9jaGVjazsKPiAgIAo+ICAgCWFtZGdwdV9nZnhfb2Zm
X2N0cmwoYWRldiwgZmFsc2UpOwo+ICAgCW11dGV4X2xvY2soJmFkZXYtPmdmeC5ncHVfY2xvY2tf
bXV0ZXgpOwo+IEBAIC03NjIwLDggKzc2MjAsMTUgQEAgc3RhdGljIHVpbnQ2NF90IGdmeF92MTBf
MF9nZXRfZ3B1X2Nsb2NrX2NvdW50ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJ
CQkoKHVpbnQ2NF90KVJSRUczMl9TT0MxNShTTVVJTywgMCwgbW1HT0xERU5fVFNDX0NPVU5UX1VQ
UEVSX1ZhbmdvZ2gpIDw8IDMyVUxMKTsKPiAgIAkJYnJlYWs7Cj4gICAJZGVmYXVsdDoKPiAtCQlj
bG9jayA9ICh1aW50NjRfdClSUkVHMzJfU09DMTUoU01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VO
VF9MT1dFUikgfAo+IC0JCQkoKHVpbnQ2NF90KVJSRUczMl9TT0MxNShTTVVJTywgMCwgbW1HT0xE
RU5fVFNDX0NPVU5UX1VQUEVSKSA8PCAzMlVMTCk7CgpJZiB5b3Ugd2FudCB0byBiZSBleHRyYSBz
dXJlIHlvdSBjb3VsZCBhZGQgYSBwcmVlbXB0X2Rpc2FibGUoKTsgaGVyZS4KCj4gKwkJY2xvY2tf
aGkgPSBSUkVHMzJfU09DMTVfTk9fS0lRKFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09VTlRfVVBQ
RVIpOwo+ICsJCWNsb2NrX2xvID0gUlJFRzMyX1NPQzE1X05PX0tJUShTTVVJTywgMCwgbW1HT0xE
RU5fVFNDX0NPVU5UX0xPV0VSKTsKPiArCQloaV9jaGVjayA9IFJSRUczMl9TT0MxNV9OT19LSVEo
U01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VOVF9VUFBFUik7Cj4gKwkJLyogQ2FycnlvdmVyIGhh
cHBlbnMgZXZlcnkgNCBHaWdhIHRpbWUgY3ljbGVzIGNvdW50cyB3aGljaCBpcyByb3VnaGx5IDQy
IHNlY3MgKi8KPiArCQlpZiAoaGlfY2hlY2sgIT0gY2xvY2tfaGkpIHsKPiArCQkJY2xvY2tfbG8g
PSBSUkVHMzJfU09DMTVfTk9fS0lRKFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09VTlRfTE9XRVIp
Owo+ICsJCQljbG9ja19oaSA9IGhpX2NoZWNrOwo+ICsJCX0KCkFuZCBhIHByZWVtcHRfZW5hYmxl
KCk7IGhlcmUuIFRoaXMgd2F5IHRoZSBjcml0aWNhbCBzZWN0aW9uIGlzIGFsc28gbm90IAppbnRl
cnJ1cHRlZCBieSBhIHRhc2sgc3dpdGNoLgoKQnV0IGVpdGhlciB3YXkgdGhlIHBhdGNoIGlzIFJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoK
UmVnYXJkcywKQ2hyaXN0aWFuLgoKPiArCQljbG9jayA9ICh1aW50NjRfdCljbG9ja19sbyB8ICgo
dWludDY0X3QpY2xvY2tfaGkgPDwgMzJVTEwpOwo+ICAgCQlicmVhazsKPiAgIAl9Cj4gICAJbXV0
ZXhfdW5sb2NrKCZhZGV2LT5nZnguZ3B1X2Nsb2NrX211dGV4KTsKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
