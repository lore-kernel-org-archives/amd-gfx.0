Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC8C48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 14:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FE7613EE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 14:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FE7613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C1D6EE97;
	Fri, 11 Jun 2021 14:53:14 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0AA6E591;
 Fri, 11 Jun 2021 14:53:13 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 f16-20020a05600c1550b02901b00c1be4abso8827595wmg.2; 
 Fri, 11 Jun 2021 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=PYz47Kpk149OD6JCGUi0G8oIJKajH8KhLCc+6vQzb9o=;
 b=kfqV8U1ZVFqdFBPC5nPEHpP5exRrjbG++Pc6/DJiTgJv8Jf8aMm6/ogvlZz+6ISSRl
 W5Xg5G/g4hSCd1Ii1pyJ00c/Lxojrqj0hXSHCHKcQ8hsmQbOAOhbass1voKrN+Oj1kvj
 DxbT/7UXRQckP6bZ45BI9csD9tGJmgRcMYZQ0Lyn8//5TJ0eS/jKpfE6DsBMcyQLAgd8
 XpVt/9ckuyV9IE6RbCbU6H2l7BhDp4k6yOyZNnLRgvGcxzo8i9VePJUceDfF8l+pdPeC
 iqj04qM1YQTWVfDuXXcSOeraHvH0TkemXNeIwhHbv8jwMS1vDM3R75TazfD5j0i2cj73
 4CDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=PYz47Kpk149OD6JCGUi0G8oIJKajH8KhLCc+6vQzb9o=;
 b=pmoqT65oZPb0+sER/LjBq3HvbAAK4JY+IaHRkE7uUhuZIezWhtzY3u/IKoNJPDmc8/
 QgtxbrQwDNuKJ3KF+J9NcMHEg7ZwrabaKA7M5ZAAgAuX468LQCaiiiqmfhFZb3XD3Ync
 m2wGSFoKHkxwTqKE/Phku6LH+LUVnZJZwM4Bi5UUqJhrX98OWq1DBcS2/WCbYZ6yh2ra
 dwaBs3TuOSiERRiaLHF03/2zb5qHopBErtEs4XmRd5uggkhQg+tM8bdrnN+Od6ru5yFw
 w6LKrE+BeXBaMhCW32POY4Bi/pVd9yUpe5vYfImpIhuz2XMnVDhZtKeOSlcXb3XOvLMq
 MIIQ==
X-Gm-Message-State: AOAM531SXxmC8ro1HtYe6bjfXYjsuz8v1n24OjhkqexfXR3Ei20i9Rcl
 6WXDQkk2/sv0ikwygDQkNbZabW2xC8k=
X-Google-Smtp-Source: ABdhPJyLqPaSTOBW9sPKneXzFaTZN9ctm+MQseLZz1Z1Skmq3itR2ESTRRI3QstDqI2Uw8oDpV7QVw==
X-Received: by 2002:a05:600c:4f0c:: with SMTP id
 l12mr4343817wmq.123.1623423192219; 
 Fri, 11 Jun 2021 07:53:12 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:bd94:4b9a:99c4:4bc1?
 ([2a02:908:1252:fb60:bd94:4b9a:99c4:4bc1])
 by smtp.gmail.com with ESMTPSA id n9sm6356665wmc.20.2021.06.11.07.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jun 2021 07:53:11 -0700 (PDT)
Subject: Re: [PATCH 1/5] dma-buf: fix dma_resv_test_signaled test_all handling
To: Daniel Vetter <daniel@ffwll.ch>
References: <20210611120301.10595-1-christian.koenig@amd.com>
 <YMN3nr1mTj09p8lT@phenom.ffwll.local>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2c91e4b4-e8c8-a9f5-420f-9cf0c1f9a67d@gmail.com>
Date: Fri, 11 Jun 2021 16:53:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMN3nr1mTj09p8lT@phenom.ffwll.local>
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxMS4wNi4yMSB1bSAxNjo0NyBzY2hyaWViIERhbmllbCBWZXR0ZXI6Cj4gT24gRnJpLCBK
dW4gMTEsIDIwMjEgYXQgMDI6MDI6NTdQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
Pj4gQXMgdGhlIG5hbWUgaW1wbGllcyBpZiB0ZXN0aW5nIGFsbCBmZW5jZXMgaXMgcmVxdWVzdGVk
IHdlCj4+IHNob3VsZCBpbmRlZWQgdGVzdCBhbGwgZmVuY2VzIGFuZCBub3Qgc2tpcCB0aGUgZXhj
bHVzaXZlCj4+IG9uZSBiZWNhdXNlIHdlIHNlZSBzaGFyZWQgb25lcy4KPj4KPj4gU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IEhtIEkg
dGhvdWdodCB3ZSd2ZSBoYWQgdGhlIHJ1bGUgdGhhdCB3aGVuIGJvdGggZmVuY2VzIGV4aXN0LCB0
aGVuCj4gY29sbGVjdGl2ZWx5IHRoZSBzaGFyZWQgb25lcyBtdXN0IHNpZ25hbGUgbm8gZWFybGll
ciB0aGFuIHRoZSBleGNsdXNpdmUKPiBvbmUuCj4KPiBUaGF0J3MgYXQgbGVhc3QgdGhlIGNvbnRy
YWN0IHdlJ3ZlIGltcGxlbWVudGVkIGluIGRtYV9yZXN2LmguIEJ1dCBJJ3ZlCj4gYWxzbyBmb3Vu
ZCBhIGJ1bmNoIG9mIGRyaXZlcnMgd2hvIGFyZSBhIGxvdCBtb3JlIHlvbG8gb24gdGhpcy4KPgo+
IEkgdGhpbmsgdGhlcmUncyBhIHNvbGlkIGNhc2UgaGVyZSB0byBqdXN0IGFsd2F5cyB0YWtlIGFs
bCB0aGUgZmVuY2VzIGlmIHdlCj4gYXNrIGZvciBhbGwgdGhlIHNoYXJlZCBvbmVzLCBidXQgaWYg
d2UgZ28gdGhhdCB3YXkgdGhlbiBJJ2Qgc2F5Cj4gLSBjbGVhciBrZXJuZWxkb2MgcGF0Y2ggdG8g
cmVhbGx5IGhhbW1lciB0aGlzIGluIChjdXJyZW50bHkgd2UncmUgbm90IGdvb2QKPiAgICBhdCBh
bGwgaW4gdGhpcyByZWdhcmQpCj4gLSBnb2luZyB0aHJvdWdoIGRyaXZlcnMgYSBiaXQgdG8gY2hl
Y2sgZm9yIHRoaXMgKEkgaGF2ZSBzb21lIG9mIHRoYXQgZG9uZQo+ICAgIGFscmVhZHkgaW4gbXkg
ZWFybGllciBzZXJpZXMsIG5lZWQgdG8gcmVzcGluIGl0IGFuZCBzZW5kIGl0IG91dCkKPgo+IEJ1
dCBJJ20ga2luZGEgbm90IHNlZWluZyB3aHkgdGhpcyBuZWVkcyB0byBiZSBpbiB0aGlzIHBhdGNo
IHNlcmllcyBoZXJlLgoKWW91IG1lbnRpb25lZCB0aGF0IHRoaXMgaXMgYSBwcm9ibGVtIGluIHRo
ZSBsYXN0IHBhdGNoIGFuZCBpZiB5b3UgYXNrIG1lIAp0aGF0J3MganVzdCBhIGJ1ZyBvciBhdCBs
ZWFzdCB2ZXJ5IGluY29uc2lzdGVudC4KClNlZSBkbWFfcmVzdl93YWl0X3RpbWVvdXQoKSBhbHdh
eXMgd2FpdHMgZm9yIGFsbCBmZW5jZXMsIGluY2x1ZGluZyB0aGUgCmV4Y2x1c2l2ZSBvbmUgZXZl
biBpZiBzaGFyZWQgb25lcyBhcmUgcHJlc2VudC4gQnV0IApkbWFfcmVzdl90ZXN0X3NpZ25hbGVk
KCkgaWdub3JlcyB0aGUgZXhjbHVzaXZlIG9uZSBpZiBzaGFyZWQgb25lcyBhcmUgCnByZXNlbnQu
CgpUaGUgb25seSBvdGhlciBkcml2ZXIgSSBjb3VsZCBmaW5kIHRyeWluZyB0byBtYWtlIHVzZSBv
ZiB0aGlzIGlzIG5vdXZlYXUgCmFuZCBJIGFscmVhZHkgcHJvdmlkZWQgYSBmaXggZm9yIHRoaXMg
YXMgd2VsbC4KCkkganVzdCB0aGluayB0aGF0IHRoaXMgaXMgdGhlIG1vcmUgZGVmZW5zaXZlIGFw
cHJvYWNoIHRvIGZpeCB0aGlzIGFuZCAKaGF2ZSBhdCBsZWFzdCB0aGUgY29yZSBmdW5jdGlvbnMg
Y29uc2lzdGVudCBvbiB0aGUgaGFuZGxpbmcuCgpDaHJpc3RpYW4uCgo+IC1EYW5pZWwKPgo+PiAt
LS0KPj4gICBkcml2ZXJzL2RtYS1idWYvZG1hLXJlc3YuYyB8IDMzICsrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAy
MSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtcmVz
di5jIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1yZXN2LmMKPj4gaW5kZXggZjI2YzcxNzQ3ZDQzLi5j
NjZiZmRkZTk0NTQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtcmVzdi5jCj4+
ICsrKyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtcmVzdi5jCj4+IEBAIC02MTUsMjUgKzYxNSwyMSBA
QCBzdGF0aWMgaW5saW5lIGludCBkbWFfcmVzdl90ZXN0X3NpZ25hbGVkX3NpbmdsZShzdHJ1Y3Qg
ZG1hX2ZlbmNlICpwYXNzZWRfZmVuY2UpCj4+ICAgICovCj4+ICAgYm9vbCBkbWFfcmVzdl90ZXN0
X3NpZ25hbGVkKHN0cnVjdCBkbWFfcmVzdiAqb2JqLCBib29sIHRlc3RfYWxsKQo+PiAgIHsKPj4g
LQl1bnNpZ25lZCBpbnQgc2VxLCBzaGFyZWRfY291bnQ7Cj4+ICsJc3RydWN0IGRtYV9mZW5jZSAq
ZmVuY2U7Cj4+ICsJdW5zaWduZWQgaW50IHNlcTsKPj4gICAJaW50IHJldDsKPj4gICAKPj4gICAJ
cmN1X3JlYWRfbG9jaygpOwo+PiAgIHJldHJ5Ogo+PiAgIAlyZXQgPSB0cnVlOwo+PiAtCXNoYXJl
ZF9jb3VudCA9IDA7Cj4+ICAgCXNlcSA9IHJlYWRfc2VxY291bnRfYmVnaW4oJm9iai0+c2VxKTsK
Pj4gICAKPj4gICAJaWYgKHRlc3RfYWxsKSB7Cj4+ICAgCQlzdHJ1Y3QgZG1hX3Jlc3ZfbGlzdCAq
Zm9iaiA9IGRtYV9yZXN2X3NoYXJlZF9saXN0KG9iaik7Cj4+IC0JCXVuc2lnbmVkIGludCBpOwo+
PiAtCj4+IC0JCWlmIChmb2JqKQo+PiAtCQkJc2hhcmVkX2NvdW50ID0gZm9iai0+c2hhcmVkX2Nv
dW50Owo+PiArCQl1bnNpZ25lZCBpbnQgaSwgc2hhcmVkX2NvdW50Owo+PiAgIAo+PiArCQlzaGFy
ZWRfY291bnQgPSBmb2JqID8gZm9iai0+c2hhcmVkX2NvdW50IDogMDsKPj4gICAJCWZvciAoaSA9
IDA7IGkgPCBzaGFyZWRfY291bnQ7ICsraSkgewo+PiAtCQkJc3RydWN0IGRtYV9mZW5jZSAqZmVu
Y2U7Cj4+IC0KPj4gICAJCQlmZW5jZSA9IHJjdV9kZXJlZmVyZW5jZShmb2JqLT5zaGFyZWRbaV0p
Owo+PiAgIAkJCXJldCA9IGRtYV9yZXN2X3Rlc3Rfc2lnbmFsZWRfc2luZ2xlKGZlbmNlKTsKPj4g
ICAJCQlpZiAocmV0IDwgMCkKPj4gQEAgLTY0MSwyNCArNjM3LDE5IEBAIGJvb2wgZG1hX3Jlc3Zf
dGVzdF9zaWduYWxlZChzdHJ1Y3QgZG1hX3Jlc3YgKm9iaiwgYm9vbCB0ZXN0X2FsbCkKPj4gICAJ
CQllbHNlIGlmICghcmV0KQo+PiAgIAkJCQlicmVhazsKPj4gICAJCX0KPj4gLQo+PiAtCQlpZiAo
cmVhZF9zZXFjb3VudF9yZXRyeSgmb2JqLT5zZXEsIHNlcSkpCj4+IC0JCQlnb3RvIHJldHJ5Owo+
PiAgIAl9Cj4+ICAgCj4+IC0JaWYgKCFzaGFyZWRfY291bnQpIHsKPj4gLQkJc3RydWN0IGRtYV9m
ZW5jZSAqZmVuY2VfZXhjbCA9IGRtYV9yZXN2X2V4Y2xfZmVuY2Uob2JqKTsKPj4gLQo+PiAtCQlp
ZiAoZmVuY2VfZXhjbCkgewo+PiAtCQkJcmV0ID0gZG1hX3Jlc3ZfdGVzdF9zaWduYWxlZF9zaW5n
bGUoZmVuY2VfZXhjbCk7Cj4+IC0JCQlpZiAocmV0IDwgMCkKPj4gLQkJCQlnb3RvIHJldHJ5Owo+
PiArCWZlbmNlID0gZG1hX3Jlc3ZfZXhjbF9mZW5jZShvYmopOwo+PiArCWlmIChmZW5jZSkgewo+
PiArCQlyZXQgPSBkbWFfcmVzdl90ZXN0X3NpZ25hbGVkX3NpbmdsZShmZW5jZSk7Cj4+ICsJCWlm
IChyZXQgPCAwKQo+PiArCQkJZ290byByZXRyeTsKPj4gICAKPj4gLQkJCWlmIChyZWFkX3NlcWNv
dW50X3JldHJ5KCZvYmotPnNlcSwgc2VxKSkKPj4gLQkJCQlnb3RvIHJldHJ5Owo+PiAtCQl9Cj4+
ICAgCX0KPj4gICAKPj4gKwlpZiAocmVhZF9zZXFjb3VudF9yZXRyeSgmb2JqLT5zZXEsIHNlcSkp
Cj4+ICsJCWdvdG8gcmV0cnk7Cj4+ICsKPj4gICAJcmN1X3JlYWRfdW5sb2NrKCk7Cj4+ICAgCXJl
dHVybiByZXQ7Cj4+ICAgfQo+PiAtLSAKPj4gMi4yNS4xCj4+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
