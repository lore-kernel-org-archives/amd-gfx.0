Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C25C5ACD6
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 07:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0516720753
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 07:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIHBbDgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0516720753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A5989009;
	Wed, 18 Mar 2020 07:51:27 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8467D89009
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 07:51:26 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f7so2054282wml.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=2smigOsKI8Y4aV8QsE4hMIm9Ha60hUOjK9rgHP9d01s=;
 b=TIHBbDgnqkIJs2BQLVTFnYJy7Ap86Fy18zMUo29N+gxZk+ldJcyfsNVBwPX5paBFKQ
 IrkteRJm63p7UPiEtqrWrEjxV1xv55tsWZ/q7Zhr9HhgzW10MiFNKQEE5LJlgXS74HBo
 qas5u0eftAlArqe5txWiwhATdcvC1leUDBIklBOhyY63xGg21vmNOuNE4O60l9zjhP4X
 CMoy9faA0X6Q4Wbky7xddi+Y4hHawzWkdrQG5rkvjr6KmQcGVm+t3n/UwyGwQX4JunNo
 4QvIX6G/lMFDp0a1lEnN47wQi2VcnJ1hFwmJppXbG8WD4S1vfcI1B5M7sBjT9XpUOmKS
 O8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2smigOsKI8Y4aV8QsE4hMIm9Ha60hUOjK9rgHP9d01s=;
 b=Zd+ZzGg8WYgAkaKvFwAaBHPD5uGxqh1z79Ha81WNWYaLA9MUYdDNSX3Mgfbfg2zjIb
 TCb6WuHx+VhOg0dXBIRPbiKfxQm4qRn+oEUKO5MJxDzW2J8yIhloH2tVlG14CNrSW52T
 Ir6sJ4fTEFbCTo5/7gUUfHB+4H98T3sCilTfPQlEzlquWxizjmSb0ALHZM8WtvJbiy3+
 +CyilR/vH+sW4d+cXqnAilmAGfXbQhhRgYH3sCxqXQ9vCw+42Y5Rcuxgj8fZHR//04zy
 BccKFeC9MifnpFUWpG0LlGWD4eUx8tzuilrTWSh7ptUJymaS9A1WQ60Lr34Ze4oL7q5s
 WlMA==
X-Gm-Message-State: ANhLgQ3G5RT2nDx5XZhLmfyh7H7oAhQrHIIR8A/Xn5s9GW3Sm3hkaVcB
 tLYNlKHFvA5hsNPiSRp7mhc=
X-Google-Smtp-Source: ADFU+vsG6+xUW9S4Y79j4xnve4fQavHow9upP2Gpatw76PENvF33ZY790d+lOT04fBGDegYF8PBQtA==
X-Received: by 2002:a7b:cc8a:: with SMTP id p10mr3720675wma.10.1584517885066; 
 Wed, 18 Mar 2020 00:51:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j39sm8766466wre.11.2020.03.18.00.51.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Mar 2020 00:51:24 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close v2
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org, Monk.Liu@amd.com
References: <20200316132235.82022-1-christian.koenig@amd.com>
Message-ID: <9e4b394a-59e3-cae7-1dd2-63c0a692cefb@gmail.com>
Date: Wed, 18 Mar 2020 08:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200316132235.82022-1-christian.koenig@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGluZz8gWGluaHVpIGNhbiBJIGdldCBhbiByYiBmb3IgdGhpcz8KClRoYW5rcywKQ2hyaXN0aWFu
LgoKQW0gMTYuMDMuMjAgdW0gMTQ6MjIgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IFRoZSBw
cm9ibGVtIGlzIHRoYXQgd2UgY2FuJ3QgYWRkIHRoZSBjbGVhciBmZW5jZSB0byB0aGUgQk8KPiB3
aGVuIHRoZXJlIGlzIGFuIGV4Y2x1c2l2ZSBmZW5jZSBvbiBpdCBzaW5jZSB3ZSBjYW4ndAo+IGd1
YXJhbnRlZSB0aGUgdGhlIGNsZWFyIGZlbmNlIHdpbGwgY29tcGxldGUgYWZ0ZXIgdGhlCj4gZXhj
bHVzaXZlIG9uZS4KPgo+IFRvIGZpeCB0aGlzIHJlZmFjdG9yIHRoZSBmdW5jdGlvbiBhbmQgd2Fp
dCBmb3IgYW55IHBvdGVudGlhbAo+IGV4Y2x1c2l2ZSBmZW5jZSB3aXRoIGEgc21hbGwgdGltZW91
dCBiZWZvcmUgYWRkaW5nIHRoZQo+IHNoYXJlZCBjbGVhciBmZW5jZS4KPgo+IHYyOiBmaXggd2Fy
bmluZwo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dl
bS5jIHwgNDMgKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI2
IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nZW0uYwo+IGluZGV4IDViZWM2NmU2YjFmOC4uNDljOTFkYWMzNWEwIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+IEBAIC0xNjEsMTAgKzE2
MSwxMSBAQCB2b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0cnVjdCBkcm1fZ2VtX29iamVj
dCAqb2JqLAo+ICAgCj4gICAJc3RydWN0IGFtZGdwdV9ib19saXN0X2VudHJ5IHZtX3BkOwo+ICAg
CXN0cnVjdCBsaXN0X2hlYWQgbGlzdCwgZHVwbGljYXRlczsKPiArCXN0cnVjdCBkbWFfZmVuY2Ug
KmZlbmNlID0gTlVMTDsKPiAgIAlzdHJ1Y3QgdHRtX3ZhbGlkYXRlX2J1ZmZlciB0djsKPiAgIAlz
dHJ1Y3Qgd3dfYWNxdWlyZV9jdHggdGlja2V0Owo+ICAgCXN0cnVjdCBhbWRncHVfYm9fdmEgKmJv
X3ZhOwo+IC0JaW50IHI7Cj4gKwlsb25nIHI7Cj4gICAKPiAgIAlJTklUX0xJU1RfSEVBRCgmbGlz
dCk7Cj4gICAJSU5JVF9MSVNUX0hFQUQoJmR1cGxpY2F0ZXMpOwo+IEBAIC0xNzgsMjggKzE3OSwz
NiBAQCB2b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAq
b2JqLAo+ICAgCXIgPSB0dG1fZXVfcmVzZXJ2ZV9idWZmZXJzKCZ0aWNrZXQsICZsaXN0LCBmYWxz
ZSwgJmR1cGxpY2F0ZXMpOwo+ICAgCWlmIChyKSB7Cj4gICAJCWRldl9lcnIoYWRldi0+ZGV2LCAi
bGVha2luZyBibyB2YSBiZWNhdXNlICIKPiAtCQkJIndlIGZhaWwgdG8gcmVzZXJ2ZSBibyAoJWQp
XG4iLCByKTsKPiArCQkJIndlIGZhaWwgdG8gcmVzZXJ2ZSBibyAoJWxkKVxuIiwgcik7Cj4gICAJ
CXJldHVybjsKPiAgIAl9Cj4gICAJYm9fdmEgPSBhbWRncHVfdm1fYm9fZmluZCh2bSwgYm8pOwo+
IC0JaWYgKGJvX3ZhICYmIC0tYm9fdmEtPnJlZl9jb3VudCA9PSAwKSB7Cj4gLQkJYW1kZ3B1X3Zt
X2JvX3JtdihhZGV2LCBib192YSk7Cj4gKwlpZiAoIWJvX3ZhIHx8IC0tYm9fdmEtPnJlZl9jb3Vu
dCkKPiArCQlnb3RvIG91dF91bmxvY2s7Cj4gICAKPiAtCQlpZiAoYW1kZ3B1X3ZtX3JlYWR5KHZt
KSkgewo+IC0JCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7Cj4gKwlhbWRncHVfdm1f
Ym9fcm12KGFkZXYsIGJvX3ZhKTsKPiArCWlmICghYW1kZ3B1X3ZtX3JlYWR5KHZtKSkKPiArCQln
b3RvIG91dF91bmxvY2s7Cj4gICAKPiAtCQkJciA9IGFtZGdwdV92bV9jbGVhcl9mcmVlZChhZGV2
LCB2bSwgJmZlbmNlKTsKPiAtCQkJaWYgKHVubGlrZWx5KHIpKSB7Cj4gLQkJCQlkZXZfZXJyKGFk
ZXYtPmRldiwgImZhaWxlZCB0byBjbGVhciBwYWdlICIKPiAtCQkJCQkidGFibGVzIG9uIEdFTSBv
YmplY3QgY2xvc2UgKCVkKVxuIiwgcik7Cj4gLQkJCX0KPiAgIAo+IC0JCQlpZiAoZmVuY2UpIHsK
PiAtCQkJCWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUpOwo+IC0JCQkJZG1hX2ZlbmNl
X3B1dChmZW5jZSk7Cj4gLQkJCX0KPiAtCQl9Cj4gLQl9Cj4gKwlyID0gYW1kZ3B1X3ZtX2NsZWFy
X2ZyZWVkKGFkZXYsIHZtLCAmZmVuY2UpOwo+ICsJaWYgKHIgfHwgIWZlbmNlKQo+ICsJCWdvdG8g
b3V0X3VubG9jazsKPiArCj4gKwlyID0gZG1hX3Jlc3Zfd2FpdF90aW1lb3V0X3JjdShiby0+dGJv
LmJhc2UucmVzdiwgZmFsc2UsIGZhbHNlLAo+ICsJCQkJICAgICAgbXNlY3NfdG9famlmZmllcygx
MCkpOwo+ICsJaWYgKHIgPT0gMCkKPiArCQlyID0gLUVUSU1FRE9VVDsKPiArCWlmIChyKQo+ICsJ
CWdvdG8gb3V0X3VubG9jazsKPiArCj4gKwlhbWRncHVfYm9fZmVuY2UoYm8sIGZlbmNlLCB0cnVl
KTsKPiArCWRtYV9mZW5jZV9wdXQoZmVuY2UpOwo+ICsKPiArb3V0X3VubG9jazoKPiArCWlmICh1
bmxpa2VseShyIDwgMCkpCj4gKwkJZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gY2xlYXIg
cGFnZSAiCj4gKwkJCSJ0YWJsZXMgb24gR0VNIG9iamVjdCBjbG9zZSAoJWxkKVxuIiwgcik7Cj4g
ICAJdHRtX2V1X2JhY2tvZmZfcmVzZXJ2YXRpb24oJnRpY2tldCwgJmxpc3QpOwo+ICAgfQo+ICAg
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
