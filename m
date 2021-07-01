Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD35DC11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 10:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8039361418
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 10:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8039361418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3906E069;
	Thu,  1 Jul 2021 10:47:48 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9196E069
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 10:47:47 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id i24so7756068edx.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Jul 2021 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=t3dzIm6wV5O9prFqAplcXEikC9i5E6dEz75GxpA8m9A=;
 b=eTjxFhofB4laY/4l3gUsINTDE+WCsgFpNNIWR1fa1Rv1UGxXQnppP8Wyfmk9PyuBWt
 1Fmb/lAT6nsnBRWndhtWqT4bLUVM0eNKe2HUt1AMViwyP1D8oNAkvyoWAM6/hWAy2Eoh
 P7xnEAk7/5jlRs/EF89vT1uB0zX+jYZNWVQSGD7a+RAkJV+iqOevt0xPXvALb5FVe5Gw
 Ju0vlPrmorDeZFyIulePM8QXonWbVMZph6t8qqTrCzzcobhInRY/th1NfcJC17l/LTTn
 gNNtLm02P34FB/exR3CzioCIENQ5IWzq0F3PBq6EqXnIb28Z4CDRiA899wbU469erirV
 sAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=t3dzIm6wV5O9prFqAplcXEikC9i5E6dEz75GxpA8m9A=;
 b=Yh2oBDLoNbrKeXKzHYmaU/9QqEb9rX2aDDh0PukCKwCNEtXADUwK8/MYKjOomiS36t
 N3wfGFe9KEyaeKYr8IBnr+SvN5vN4ZIsKUFJmSTFWYPZO6N89vDv1RgkJm1hOImDPSSK
 oMSApMVVwVgQ2AjJAM6/r3gNa/p/Xa33De/i4M4t1xoWgYEn+tOMi9UQxTNG66FjviB+
 RBzYZsnJp+Rbn+rntNjbvxTuIrYeTaDonNtx73fjOounHSjECvvZEKYMRLuE9rcvi8y7
 QmPKBuiUwXSj86/OpRWJUU87TVdb+BLX3kWuUcgiuD92X7QP9DEkG0018OiSPL8iv0tE
 GExg==
X-Gm-Message-State: AOAM530nMdvUivnpkLjIl7SCOfqLg7/cAuCX30RjMIcqZM9wnAWWj6jw
 BuRUS61s9cA7Bpyh547HLO0=
X-Google-Smtp-Source: ABdhPJz80V0wor1UR+zgr3bXs2jXS+qZLtEcfFVePkdq1Td5fctIRY2/4491Nn6tzM+1vWIyHXHUMQ==
X-Received: by 2002:aa7:da02:: with SMTP id r2mr34137972eds.350.1625136465857; 
 Thu, 01 Jul 2021 03:47:45 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8c07:8ec5:3c97:d783?
 ([2a02:908:1252:fb60:8c07:8ec5:3c97:d783])
 by smtp.gmail.com with ESMTPSA id g23sm4397539edp.74.2021.07.01.03.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jul 2021 03:47:45 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay (v5)
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210701095705.2133251-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8fc1c4de-10af-a64f-c993-ed939adce9f0@gmail.com>
Date: Thu, 1 Jul 2021 12:47:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701095705.2133251-1-YuBiao.Wang@amd.com>
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

CgpBbSAwMS4wNy4yMSB1bSAxMTo1NyBzY2hyaWViIFl1QmlhbyBXYW5nOgo+IFtXaHldCj4gR1BV
IHRpbWluZyBjb3VudGVycyBhcmUgcmVhZCB2aWEgS0lRIHVuZGVyIHNyaW92LCB3aGljaCB3aWxs
IGludHJvZHVjZQo+IGEgZGVsYXkuCj4KPiBbSG93XQo+IEl0IGNvdWxkIGJlIGRpcmVjdGx5IHJl
YWQgYnkgTU1JTy4KPgo+IHYyOiBBZGQgYWRkaXRpb25hbCBjaGVjayB0byBwcmV2ZW50IGNhcnJ5
b3ZlciBpc3N1ZS4KPiB2MzogT25seSBjaGVjayBmb3IgY2FycnlvdmVyIGZvciBvbmNlIHRvIHBy
ZXZlbnQgcGVyZm9ybWFuY2UgaXNzdWUuCj4gdjQ6IEFkZCBjb21tZW50cyBvZiB0aGUgcm91Z2gg
ZnJlcXVlbmN5IHdoZXJlIGNhcnJ5b3ZlciBoYXBwZW5zLgo+IHY1OiBSZW1vdmUgbXV0ZXggYW5k
IGdmeG9mZiBjdHJsIHVudXNlZCB3aXRoIGN1cnJlbnQgdGltaW5nIHJlZ2lzdGVycy4KPgo+IFNp
Z25lZC1vZmYtYnk6IFl1QmlhbyBXYW5nIDxZdUJpYW8uV2FuZ0BhbWQuY29tPgo+IEFja2VkLWJ5
OiBIb3JhY2UgQ2hlbiA8aG9yYWNlLmNoZW5AYW1kLmNvbT4KClRoZSBwcmVlbXB0aW9uX2Rpc2Fi
bGUoKS9fZW5hYmxlKCkgd291bGQgc3RpbGwgYmUgbmljZSB0byBoYXZlIEkgdGhpbmsuCgpBbnl3
YXkgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4gCmVpdGhlciB3YXkuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+IC0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAxOSArKysrKysrKysrKyst
LS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gaW5kZXggZmY3ZTlm
NDkwNDBlLi41ZjRlYWU5Yzk1MjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYwo+IEBAIC03NjA5LDEwICs3NjA5LDggQEAgc3RhdGljIGludCBnZnhfdjEwXzBfc29m
dF9yZXNldCh2b2lkICpoYW5kbGUpCj4gICAKPiAgIHN0YXRpYyB1aW50NjRfdCBnZnhfdjEwXzBf
Z2V0X2dwdV9jbG9ja19jb3VudGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgewo+
IC0JdWludDY0X3QgY2xvY2s7Cj4gKwl1aW50NjRfdCBjbG9jaywgY2xvY2tfbG8sIGNsb2NrX2hp
LCBoaV9jaGVjazsKPiAgIAo+IC0JYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7Cj4g
LQltdXRleF9sb2NrKCZhZGV2LT5nZnguZ3B1X2Nsb2NrX211dGV4KTsKPiAgIAlzd2l0Y2ggKGFk
ZXYtPmFzaWNfdHlwZSkgewo+ICAgCWNhc2UgQ0hJUF9WQU5HT0dIOgo+ICAgCWNhc2UgQ0hJUF9Z
RUxMT1dfQ0FSUDoKPiBAQCAtNzYyMCwxMiArNzYxOCwxOSBAQCBzdGF0aWMgdWludDY0X3QgZ2Z4
X3YxMF8wX2dldF9ncHVfY2xvY2tfY291bnRlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
PiAgIAkJCSgodWludDY0X3QpUlJFRzMyX1NPQzE1KFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09V
TlRfVVBQRVJfVmFuZ29naCkgPDwgMzJVTEwpOwo+ICAgCQlicmVhazsKPiAgIAlkZWZhdWx0Ogo+
IC0JCWNsb2NrID0gKHVpbnQ2NF90KVJSRUczMl9TT0MxNShTTVVJTywgMCwgbW1HT0xERU5fVFND
X0NPVU5UX0xPV0VSKSB8Cj4gLQkJCSgodWludDY0X3QpUlJFRzMyX1NPQzE1KFNNVUlPLCAwLCBt
bUdPTERFTl9UU0NfQ09VTlRfVVBQRVIpIDw8IDMyVUxMKTsKPiArCQljbG9ja19oaSA9IFJSRUcz
Ml9TT0MxNV9OT19LSVEoU01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VOVF9VUFBFUik7Cj4gKwkJ
Y2xvY2tfbG8gPSBSUkVHMzJfU09DMTVfTk9fS0lRKFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09V
TlRfTE9XRVIpOwo+ICsJCWhpX2NoZWNrID0gUlJFRzMyX1NPQzE1X05PX0tJUShTTVVJTywgMCwg
bW1HT0xERU5fVFNDX0NPVU5UX1VQUEVSKTsKPiArCQkvKiBUaGUgR0ZYIGNsb2NrIGZyZXF1ZW5j
eSBpcyAxMDBNSHosIHdoaWNoIHNldHMgMzItYml0IGNhcnJ5IG92ZXIKPiArCQkgKiByb3VnaGx5
IGV2ZXJ5IDQyIHNlY29uZHMuCj4gKwkJICovCj4gKwkJaWYgKGhpX2NoZWNrICE9IGNsb2NrX2hp
KSB7Cj4gKwkJCWNsb2NrX2xvID0gUlJFRzMyX1NPQzE1X05PX0tJUShTTVVJTywgMCwgbW1HT0xE
RU5fVFNDX0NPVU5UX0xPV0VSKTsKPiArCQkJY2xvY2tfaGkgPSBoaV9jaGVjazsKPiArCQl9Cj4g
KwkJY2xvY2sgPSAodWludDY0X3QpY2xvY2tfbG8gfCAoKHVpbnQ2NF90KWNsb2NrX2hpIDw8IDMy
VUxMKTsKPiAgIAkJYnJlYWs7Cj4gICAJfQo+IC0JbXV0ZXhfdW5sb2NrKCZhZGV2LT5nZnguZ3B1
X2Nsb2NrX211dGV4KTsKPiAtCWFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgdHJ1ZSk7Cj4gICAJ
cmV0dXJuIGNsb2NrOwo+ICAgfQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
