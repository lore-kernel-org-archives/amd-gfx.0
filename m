Return-Path: <SRS0=ffWE=ZP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09703C432C0
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Nov 2019 18:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86042068D
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Nov 2019 18:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86042068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE596E043;
	Sat, 23 Nov 2019 18:23:26 +0000 (UTC)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9486E0B6
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Nov 2019 17:17:35 +0000 (UTC)
Received: by mail-oi1-x242.google.com with SMTP id a14so9431573oid.5
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Nov 2019 09:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wjG5V9HG8IU07D09hh8c+rVmt+60qsQH1qX8GG9AmCA=;
 b=oyxzliDIsqB703mH75MFIWa7Ptc1LSu2cKEHwuXGZviIyEqB590jPmyA430pAa3gBA
 5g5ecDccM/+OamyUS59Rnxe1GT1sIIQDjBDFlPltKnCJZIlTRhGQ+wEi2v6F/hc8vcrK
 0o5JQPV0zDR8w7Y5a2UKlTKMlCGU2C/QDyXHGdHYgSjxwkwURS0kUSnlQgtosvLEL5fp
 T1F2gVZpKT5pLJZfFXkwm190d1vjXZLzf8Rkvg0IKcZ5nBePN2+4K+zwNcoqWvJsdVQe
 uvwbvW4734Ejexm1EZTSsucjF4R0DhAS8kYhuNaSR6JMuOKQxC8MNgLKh7l8vzcfG2I6
 C1ag==
X-Gm-Message-State: APjAAAVpfTcRISPe4YsXweu81TnW4hV8deXNrQEN5eWAaRBReskoZmPt
 1iEOwk56g1pyKGSWY8z2t7Y=
X-Google-Smtp-Source: APXvYqzAYqY9PYPg3q5nQ2+DYAzGZeikrhKWk/VokZmDOJ5+CN1SAh0MtR1r6DshkhCX4ZMD6jKe2g==
X-Received: by 2002:aca:a9cd:: with SMTP id s196mr1920934oie.166.1574529454119; 
 Sat, 23 Nov 2019 09:17:34 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::7])
 by smtp.gmail.com with ESMTPSA id h79sm638051oib.3.2019.11.23.09.17.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 23 Nov 2019 09:17:33 -0800 (PST)
Date: Sat, 23 Nov 2019 10:17:31 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: Re: [03/14] drm/amd/display: Add execution and transition states for
 HDCP2.2
Message-ID: <20191123171731.GA1792@ubuntu-x2-xlarge-x86>
References: <20191107155628.19446-4-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191107155628.19446-4-Bhawanpreet.Lakha@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Sat, 23 Nov 2019 18:23:25 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wjG5V9HG8IU07D09hh8c+rVmt+60qsQH1qX8GG9AmCA=;
 b=Lx0uIV/VFAYVtdGSpDkHSGcvOZAI8yUPHx/8TQxMf3Sc9xOk3bSAERza6rgXI4yTlN
 QYXptwNuM4avLWToEfwNO6ewtbWxzce42v8lY6cXOCFOLDnpzLdHadYgDvCrdKFgeZ+d
 cSOuPru9zWRA5R0ry14BJquCgWkrW0m/UlZS9C9ewyUKw5aaoaHJP9nEclXycaxhRclX
 LI4nn+B86AonUBbf9VLds2vdpaA6O0l/zBhAqLZf2qafis1tprm5k+xMxgruLPLbR00M
 GeEZmfhv00q7jYhpzWdGIWmetjRt/fsJ3G8sg6wZgcWJlcSjdHspckJi3n6K+QOc3tA7
 9dAQ==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, Wenjing.Liu@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191123171731.wfAIX_jtZ5vffqk8CIMmCYIgy7RbmZ_uVYG1etVA1Vc@z>

T24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMTA6NTY6MTdBTSAtMDUwMCwgQmhhd2FucHJlZXQgTGFr
aGEgd3JvdGU6Cj4gVGhlIG1vZHVsZSB3b3JrcyBsaWtlIGEgc3RhdGUgbWFjaGluZQo+IAo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICstLS0tLS0tLS0tLS0tKwo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAtLS0tLS0+IHwgRXhlY3V0aW9uLmMgfCAtLS0tLS0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICArLS0tLS0tLS0tLS0tLSsgICAgICAg
fAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBWCj4gICAgICstLS0tKyAgICAgICAgICAgICAgKy0tLS0tLS0tKyAgICAgICAgICAgICAg
ICAgKy0tLS0tLS0tLS0tLS0tKwo+ICAgICB8IERNIHwgICAgLS0tLS0+ICAgIHwgSGRjcC5jIHwg
IDwtLS0tLS0tLS0tLS0gIHwgVHJhbnNpdGlvbi5jIHwKPiAgICAgKy0tLS0rICAgIDwtLS0tLSAg
ICArLS0tLS0tLS0rICAgICAgICAgICAgICAgICArLS0tLS0tLS0tLS0tLS0rCj4gCj4gVGhpcyBw
YXRjaCBhZGRzIHRoZSBleGVjdXRpb24gYW5kIHRyYW5zaXRpb24gZmlsZXMgZm9yIDIuMgo+IAo+
IEV4dGVuc2lvbiB0byAiNDBhNzAyZDQyNyBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBIRENQIG1vZHVs
ZSIgZm9yIDIuMgo+IAo+IFNpZ25lZC1vZmYtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3YW5w
cmVldC5MYWtoYUBhbWQuY29tPgoKVGhlIHZlcnNpb24gb2YgdGhpcyBwYXRjaCBpbiBsaW51eC1u
ZXh0LCA1MTQ2NmIzZmQyNzIgKCJkcm0vYW1kL2Rpc3BsYXk6CkFkZCBleGVjdXRpb24gYW5kIHRy
YW5zaXRpb24gc3RhdGVzIGZvciBIRENQMi4yIikgY2F1c2VzIHRoZSBmb2xsb3dpbmcKZXJyb3Ig
b24gYXJtMzI6Cgphcm0tbGludXgtZ251ZWFiaS1sZDogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L21vZHVsZXMvaGRjcC9oZGNwMl9leGVjdXRpb24ubzogaW4gZnVuY3Rpb24gYGxvY2FsaXR5
X2NoZWNrJzoKaGRjcDJfZXhlY3V0aW9uLmM6KC50ZXh0KzB4ZDJjKTogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgX19iYWRfdWRlbGF5Jwphcm0tbGludXgtZ251ZWFiaS1sZDogZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwMl9leGVjdXRpb24ubzogaW4gZnVuY3Rp
b24gYHBvbGxfbF9wcmltZV9hdmFpbGFibGUnOgpoZGNwMl9leGVjdXRpb24uYzooLnRleHQrMHhl
NjQpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBfX2JhZF91ZGVsYXknCgpUaGVyZSBpcyBhIGxp
bWl0IG9mIDIwMDB1cyBkZWxheXMgb24gYXJtOgpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92NS4zLjEyL3NvdXJjZS9hcmNoL2FybS9pbmNsdWRlL2FzbS9kZWxheS5oI0w2MAoKSWYg
dGhpcyBmdW5jdGlvbiBkb2Vzbid0IHJ1biBpbiBhbiBhdG9taWMgY29udGV4dCwgSSBhc3N1bWUg
bXNsZWVwCnNob3VsZCB3b3JrLgoKQ2hlZXJzLApOYXRoYW4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
