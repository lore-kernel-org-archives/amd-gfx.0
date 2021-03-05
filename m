Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6304EC433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 07:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037CC60C41
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 07:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037CC60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E746EB08;
	Fri,  5 Mar 2021 07:55:01 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A4F6EB08
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 07:55:00 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id v13so1269919edw.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Mar 2021 23:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=+iVBj3UdgxVehnpcFSln6+ajj9Ed/2nxoTikVaLr5dI=;
 b=d4LuP7MhZVIdN6i1dEQS8/0JGfgvN0BjMSLWWfYAymfHSP6ZdtX5S9LfbvK5i1kpxd
 rvEyU5ShKV7BUq5yphQQN6rZGCkGu5/Y3d9dGbq9VMvoMfI/40m+kMcHm4lUGxq+yZSJ
 AImPrH7dxmq1hNLYHe2AaQRmKj2MURup9nl2SnxTwjxP765zQWiW8pmOkJoa6JIyMYAf
 jAU1DgN4SScOTVsJ9/SLH3hH6Vc8aAWrbvZ0kudjhpO1kPJ92DcGeXnR4YR+XejxW3b3
 tIayDIuwH1d1WGV4V4MPaLyiyvr2qGtqgr0uUMII1TwBEF+08u438uzO6jYL8hAaBELk
 2FGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+iVBj3UdgxVehnpcFSln6+ajj9Ed/2nxoTikVaLr5dI=;
 b=TISFnLv+btkZcxXcdiBG0AtRdzIIsHuFIewNSDxPnz8ROTWbakzS+qDLUMtXdq3poO
 2pBgoziyNY+42XaNFRFp/dFuiasmZuQS8NF8f8Gyyi38GGkxlRqScV55vk9yM0bl0QE0
 FQlO866+Qq9+4oNI9W/DDn13J7wpUczFanOR+N1lqOGryZcDyb87NgDzBb36YktYiYmU
 2iohqxYHpI2uRlH9xyMiOrlYuCyLqZHEjkPwGKkR5heoV01aBkO4KkYGxFOsEGk9dZGc
 Ks7NQSlNKk6jmkFLa6IIJC83gnZ9ly+W+Pn04/HihZC5UQi5I2pvnXoLi2BdfOWdZa9n
 g+Og==
X-Gm-Message-State: AOAM531aq26AlmjypJt0lSdRw/oqi1sPszLniB6w7E2RFxT3PCDZKqxb
 VeWVVM9y3OJdYT6RcjYKmK9h76DLPNx3bw==
X-Google-Smtp-Source: ABdhPJxq9PVxsQAmqpHM+2HdcUWVWVDMK7yocp8im0pJmKY9FlpAWT3sjZNeC9X6/DyQoWpU4oo14g==
X-Received: by 2002:a05:6402:50c6:: with SMTP id
 h6mr7968900edb.117.1614930898855; 
 Thu, 04 Mar 2021 23:54:58 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:9f0d:d59a:6448:4a90?
 ([2a02:908:1252:fb60:9f0d:d59a:6448:4a90])
 by smtp.gmail.com with ESMTPSA id fw3sm1008968ejb.82.2021.03.04.23.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Mar 2021 23:54:57 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Fix some unload driver issues
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210305012019.58196-1-Emily.Deng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3c929a45-c8d6-904b-25ce-2909e530dead@gmail.com>
Date: Fri, 5 Mar 2021 08:54:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305012019.58196-1-Emily.Deng@amd.com>
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

QW0gMDUuMDMuMjEgdW0gMDI6MjAgc2NocmllYiBFbWlseSBEZW5nOgo+IFdoZW4gdW5sb2FkaW5n
IGRyaXZlciBhZnRlciBraWxsaW5nIHNvbWUgYXBwbGljYXRpb25zLCBpdCB3aWxsIGhpdCBzZG1h
Cj4gZmx1c2ggdGxiIGpvYiB0aW1lb3V0IHdoaWNoIGlzIGNhbGxlZCBieSB0dG1fYm9fZGVsYXlf
ZGVsZXRlLiBTbwo+IHRvIGF2b2lkIHRoZSBqb2Igc3VibWl0IGFmdGVyIGZlbmNlIGRyaXZlciBm
aW5pLCBjYWxsIHR0bV9ib19sb2NrX2RlbGF5ZWRfd29ya3F1ZXVlCj4gYmVmb3JlIGZlbmNlIGRy
aXZlciBmaW5pLiBBbmQgYWxzbyBwdXQgZHJtX3NjaGVkX2ZpbmkgYmVmb3JlIHdhaXRpbmcgZmVu
Y2UuCgpHb29kIGNhdGNoLCBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiBmb3IgCnRoaXMgcGFydC4KCj4gU2V0IGFkZXYtPmdhcnQucHRyIHRv
IG51bGwgdG8gZml4IG51bGwgcG9pbnRlciB3aGVuIGNhbGxpbmcgYW1kZ3B1X2dhcnRfdW5iaW5k
Cj4gaW4gYW1kZ3B1X2JvX2Zpbmkgd2hpY2ggaXMgYWZ0ZXIgZ2FydF9maW5pLgoKRm9yIHRoYXQg
b25lIEknbSB3b25kZXJpbmcgaWYgd2Ugc2hvdWxkbid0IHJhdGhlciByZXdvcmsgb3IgZG91Ymxl
IGNoZWNrIAp0aGUgdGVhciBkb3duIG9yZGVyLgoKT24gdGhlIG90aGVyIGhhbmQgdGhlIGhhcmR3
YXJlIHNob3VsZCBiZSBpZGxlIGJ5IG5vdyAodGhpcyBjb21lcyBhZnRlciAKdGhlIGZlbmNlX2Ry
aXZlcl9maW5pLCBkb2Vzbid0IGl0PykgYW5kIGl0IGxvb2tzIGNsZWFuZXIgb24gaXQncyBvd24u
CgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1p
bHkuRGVuZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgMSArCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZmVuY2UuYyAgfCA1ICsrKy0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2FydC5jICAgfCAxICsKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
Ywo+IGluZGV4IGExMTc2MGVjMzkyNC4uZGUwNTk3ZDM0NTg4IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IEBAIC0zNTk0LDYgKzM1OTQsNyBAQCB2
b2lkIGFtZGdwdV9kZXZpY2VfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIHsK
PiAgIAlkZXZfaW5mbyhhZGV2LT5kZXYsICJhbWRncHU6IGZpbmlzaGluZyBkZXZpY2UuXG4iKTsK
PiAgIAlmbHVzaF9kZWxheWVkX3dvcmsoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsKPiArCXR0
bV9ib19sb2NrX2RlbGF5ZWRfd29ya3F1ZXVlKCZhZGV2LT5tbWFuLmJkZXYpOwo+ICAgCWFkZXYt
PnNodXRkb3duID0gdHJ1ZTsKPiAgIAo+ICAgCWtmcmVlKGFkZXYtPnBjaV9zdGF0ZSk7Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPiBpbmRleCAxNDNhMTRmNDg2
NmYuLjZkMTZmNThhYzkxZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmVuY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9mZW5jZS5jCj4gQEAgLTUzMSw2ICs1MzEsOCBAQCB2b2lkIGFtZGdwdV9mZW5jZV9kcml2ZXJf
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAo+ICAgCQlpZiAoIXJpbmcgfHwg
IXJpbmctPmZlbmNlX2Rydi5pbml0aWFsaXplZCkKPiAgIAkJCWNvbnRpbnVlOwo+ICsJCWlmICgh
cmluZy0+bm9fc2NoZWR1bGVyKQo+ICsJCQlkcm1fc2NoZWRfZmluaSgmcmluZy0+c2NoZWQpOwo+
ICAgCQlyID0gYW1kZ3B1X2ZlbmNlX3dhaXRfZW1wdHkocmluZyk7Cj4gICAJCWlmIChyKSB7Cj4g
ICAJCQkvKiBubyBuZWVkIHRvIHRyaWdnZXIgR1BVIHJlc2V0IGFzIHdlIGFyZSB1bmxvYWRpbmcg
Ki8KPiBAQCAtNTM5LDggKzU0MSw3IEBAIHZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9maW5pKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCQlpZiAocmluZy0+ZmVuY2VfZHJ2LmlycV9z
cmMpCj4gICAJCQlhbWRncHVfaXJxX3B1dChhZGV2LCByaW5nLT5mZW5jZV9kcnYuaXJxX3NyYywK
PiAgIAkJCQkgICAgICAgcmluZy0+ZmVuY2VfZHJ2LmlycV90eXBlKTsKPiAtCQlpZiAoIXJpbmct
Pm5vX3NjaGVkdWxlcikKPiAtCQkJZHJtX3NjaGVkX2ZpbmkoJnJpbmctPnNjaGVkKTsKPiArCj4g
ICAJCWRlbF90aW1lcl9zeW5jKCZyaW5nLT5mZW5jZV9kcnYuZmFsbGJhY2tfdGltZXIpOwo+ICAg
CQlmb3IgKGogPSAwOyBqIDw9IHJpbmctPmZlbmNlX2Rydi5udW1fZmVuY2VzX21hc2s7ICsraikK
PiAgIAkJCWRtYV9mZW5jZV9wdXQocmluZy0+ZmVuY2VfZHJ2LmZlbmNlc1tqXSk7Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jCj4gaW5kZXggMjM4MjNhNTczNzRmLi5m
MWVkZTRiNDNkMDcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dhcnQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0
LmMKPiBAQCAtMjAyLDYgKzIwMiw3IEBAIHZvaWQgYW1kZ3B1X2dhcnRfdGFibGVfdnJhbV9mcmVl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCQlyZXR1cm47Cj4gICAJfQo+ICAgCWFt
ZGdwdV9ib191bnJlZigmYWRldi0+Z2FydC5ibyk7Cj4gKwlhZGV2LT5nYXJ0LnB0ciA9IE5VTEw7
Cj4gICB9Cj4gICAKPiAgIC8qCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
