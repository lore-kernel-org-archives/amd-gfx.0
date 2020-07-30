Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD02C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5131E20809
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U83jYdDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5131E20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A9B6E090;
	Thu, 30 Jul 2020 09:14:17 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 838D16E090
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 09:14:16 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id bs17so646003edb.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=PytPAg3Yka+TvJB9LP99opZyWyRoYu6qIsay9KfqPbM=;
 b=U83jYdDqXHewvq5rYWGNWNHiRd+NBxkXJu9LwV4devz9Sd5nRtpU396CJgACXl7zZ7
 Vmswx/6X47PD4CPKGVqwhYro5PcHWNKywDB5TSOqXFe5CpcOv9Hccq7ohl9p6K0XKdNR
 VLCnaF5QJkB3w0cknyyFSBueH3/Tae6qudn1lhn3Q9vWt1xHJWPGH1L/YeekqAKNdxtb
 p556axgeY7yWEeuKfyFDPVG/CcSBGuZ+sAtPK5ZwJcCv+C09CGTouOOWaHNoH1ftzDo7
 ykiYEoFp8s2v42tl6bzOb+oI7bbI+CeP+P5vXFhVU7i1L4IEycw8tLNejuitdb8NYUjl
 og4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=PytPAg3Yka+TvJB9LP99opZyWyRoYu6qIsay9KfqPbM=;
 b=FtZmNwlw6moHi2qkirc/uomMJH3AfquoKaRf+QuhJ7i5gXXUatzKJCZqvIFtrdVPQ/
 l9t0j5u3NHbopmSXbGDt/kYbsClxaogOT6cMTmUzsJZiG/IXT+8B+gUC74vo1n+WcpLv
 lnY1jIA8mgurXV51su9tJbn8eubWs6JpCdZYC8EwYM15gz0jZ4awSRSqkDM47rKuT+Xk
 NnsC/Zzr9UCa+mv6ppGuexEJSnjF3kP8s5CWKexUvsH4C00oM3oEY10sQB8wEGBtYAOX
 Wun48mhOx6BiQzUBRWZDS9BEEk8y/KEiKEMBtG8HEFehCVlX39Hxr9K2dylUGkhn/Kn1
 KVxA==
X-Gm-Message-State: AOAM530ejYfkaqej6z42lqt7F7zO+PXjBASv4sR4lxthFRplsuotZ5ml
 bBDbnwbTlq0C2RPOQdoR6KY=
X-Google-Smtp-Source: ABdhPJwvfJPUHbxNr2tAJxC8gYMifCpIOpIehDhxiL4rLDtRbSI7ET1nKpi3596DeChOxjIX3gB8cA==
X-Received: by 2002:aa7:c606:: with SMTP id h6mr1673815edq.363.1596100455213; 
 Thu, 30 Jul 2020 02:14:15 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id qn10sm5059911ejb.39.2020.07.30.02.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 02:14:14 -0700 (PDT)
Subject: Re: [PATCH 00/17] rework stolen pre-OS fb allocation handling (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200729173439.3698-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f15bbae6-5c72-0280-914f-6befc4a0ae03@gmail.com>
Date: Thu, 30 Jul 2020 11:14:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729173439.3698-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T25lIGNvbW1lbnQgb24gcGF0Y2ggIzE3LCBhcGFydCBmcm9tIHRoYXQgdGhlIHNlcmllcyBpcyBS
ZXZpZXdlZC1ieTogCkNocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4u
CgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAyOS4wNy4yMCB1bSAxOTozNCBzY2hyaWViIEFsZXgg
RGV1Y2hlcjoKPiBTcGxpdCB0aGUgYWxsb2NhdGlvbnMgaW50byB0d28gc28gd2UgY2FuIHN0aWxs
IHN1cHBvcnQgdGhlIFMzCj4gd29ya2Fyb3VuZHMgcmVxdWlyZWQgb24gc29tZSBwbGF0Zm9ybXMg
d2hpbGUgYWxzbyBhdm9pZGluZwo+IGFueSBhcnRpZmFjdHMgd2hlbiB0cmFuc2l0aW9uaW5nIGZy
b20gYmlvcyB0byBkcml2ZXIuCj4KPiBJbiB0aGUgZnV0dXJlIHdlIGNvdWxkIGludGVncmF0ZSBo
YW5kbGluZyBvZiB0aGUgaXAgZGlzY292ZXJ5Cj4gZGF0YSBhbmQgb3RoZXIgdmJpb3MgYWxsb2Nh
dGlvbnMgaW50byB0aGlzIGhlbHBlciBmdW5jdGlvbgo+IHRvIGNvbnNvbGlkYXRlIGhhbmRsaW5n
IG9mIGFsbCBvZiB0aGUgdmJpb3MgcmVzZXJ2YXRpb25zLgo+Cj4gdjI6IENoZWNrIGlmIGJvIG9i
amVjdCBpcyBOVUxMIHJhdGhlciB0aGFuIGNoZWNraW5nIHNpemUKPiAgICAgIE1vdmUgYWxsIHZi
aW9zL2Zpcm13YXJlIGFsbG9jYXRpb25zIGludG8gbW1hbiBzdHJ1Y3R1cmUKPgo+IEFsZXggRGV1
Y2hlciAoMTcpOgo+ICAgIGRybS9hbWRncHU6IGhhbmRsZSBibyBzaXplIDAgaW4gYW1kZ3B1X2Jv
X2NyZWF0ZV9rZXJuZWxfYXQgKHYyKQo+ICAgIGRybS9hbWRncHU6IHVzZSBjcmVhdGVfYXQgZm9y
IHRoZSBzdG9sZW4gcHJlLU9TIGJ1ZmZlcgo+ICAgIGRybS9hbWRncHU6IHVzZSBhIGRlZmluZSBm
b3IgdGhlIG1lbW9yeSBzaXplIG9mIHRoZSB2Z2EgZW11bGF0b3IKPiAgICBkcm0vYW1kZ3B1OiBt
b3ZlIHN0b2xlbiB2Z2EgYm8gZnJvbSBhbWRncHUgdG8gYW1kZ3B1LmdtYwo+ICAgIGRybS9hbWRn
cHU6IG1vdmUga2VlcCBzdG9sZW4gbWVtb3J5IGNoZWNrIGludG8gZ21jIGNvcmUKPiAgICBkcm0v
YW1kZ3B1OiBhZGQgc3VwcG9ydCBmb3IgZXh0ZW5kZWQgc3RvbGVuIHZnYSBtZW1vcnkKPiAgICBk
cm0vYW1kZ3B1L2dtYzogYWRkIG5ldyBoZWxwZXIgdG8gZ2V0IHRoZSBGQiBzaXplIHVzZWQgYnkg
cHJlLU9TCj4gICAgICBjb25zb2xlCj4gICAgZHJtL2FtZGdwdS9nbWM2OiBzd2l0Y2ggdG8gdXNp
bmcgYW1kZ3B1X2dtY19nZXRfdmJpb3NfYWxsb2NhdGlvbnMKPiAgICBkcm0vYW1kZ3B1L2dtYzc6
IHN3aXRjaCB0byB1c2luZyBhbWRncHVfZ21jX2dldF92Ymlvc19hbGxvY2F0aW9ucwo+ICAgIGRy
bS9hbWRncHUvZ21jODogc3dpdGNoIHRvIHVzaW5nIGFtZGdwdV9nbWNfZ2V0X3ZiaW9zX2FsbG9j
YXRpb25zCj4gICAgZHJtL2FtZGdwdS9nbWM5OiBzd2l0Y2ggdG8gdXNpbmcgYW1kZ3B1X2dtY19n
ZXRfdmJpb3NfYWxsb2NhdGlvbnMKPiAgICBkcm0vYW1kZ3B1L2dtYzEwOiBzd2l0Y2ggdG8gdXNp
bmcgYW1kZ3B1X2dtY19nZXRfdmJpb3NfYWxsb2NhdGlvbnMKPiAgICBkcm0vYW1kZ3B1OiBkcm9w
IHRoZSBDUFUgcG9pbnRlcnMgZm9yIHRoZSBzdG9sZW4gdmdhIGJvcwo+ICAgIGRybS9hbWRncHUv
Z21jOiBkaXNhYmxlIGtlZXBfc3RvbGVuX3ZnYV9tZW1vcnkgb24gYXJjdHVydXMKPiAgICBkcm0v
YW1kZ3B1OiBtb3ZlIHN0b2xlbiBtZW1vcnkgZnJvbSBnbWMgdG8gbW1hbgo+ICAgIGRybS9hbWRn
cHU6IG1vdmUgSVAgZGlzY292ZXJ5IGRhdGEgdG8gbW1hbgo+ICAgIGRybS9hbWRncHU6IG1vdmUg
dnJhbSB1c2FnZSBieSB2YmlvcyB0byBtbWFuCj4KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oICAgICAgICAgICB8ICAyMCArLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hdG9tYmlvcy5jICB8ICAgNCArLQo+ICAgLi4uL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYXRvbWZpcm13YXJlLmMgIHwgICA0ICstCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgICAgfCAgIDQgKy0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyB8ICA1NCArKysrLS0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jICAgICAgIHwgIDQyICsrKysrKysKPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCAgICAgICB8ICAgNiArLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jICAgIHwgICAzICsK
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyAgICAgICB8ICA2NCAr
KysrKystLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmggICAg
ICAgfCAgMjQgKysrKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQu
YyAgICAgIHwgICA2ICstCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAu
YyAgICAgICAgfCAgNTcgKysrKy0tLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjZfMC5jICAgICAgICAgfCAgIDggKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192N18wLmMgICAgICAgICB8ICAxMSArLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y4XzAuYyAgICAgICAgIHwgIDExICstCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jICAgICAgICAgfCAxMTkgKysrKysrLS0tLS0tLS0tLS0tCj4gICAxNiBm
aWxlcyBjaGFuZ2VkLCAyMjYgaW5zZXJ0aW9ucygrKSwgMjExIGRlbGV0aW9ucygtKQo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
