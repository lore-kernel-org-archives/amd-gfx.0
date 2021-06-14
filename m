Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FCDC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F7861241
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F7861241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA86889CB9;
	Mon, 14 Jun 2021 17:15:48 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498B489CB3;
 Mon, 14 Jun 2021 17:15:47 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id t7so2300216edd.5;
 Mon, 14 Jun 2021 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=f2ggNfCwsjFsKNCjSPM2g4hB/8aV6ufRdZTvgF1Gm8Q=;
 b=XrqB20qh+4udCmmjv41EdVMqHj++78gktMO+wsBgMmUU5yN9J5y/+xpJsJLY+AnPkx
 APL47+3Zs5Ci6fgfVHWNU7yGHdJueIg58EAEKjMcLl9BheqaggGZMmNtVOGXW6eEvIV0
 27BFuOi/wbhHs2g4BSOIkhnfYRpBI7/LYtn6ofFb54hf0ysVgjcCOe/KBvvHXg6ADFnC
 RBw2SjIhQxSIcHThxxbDwwRST2kH1lDi3VoWLK6YxfmIKIU2BNaiXKfu1q8LN+iq9lw2
 cM5qdsEI2H1RdPl4H69WjQG9TBgWKPeNyZOaSNIzb5/Fli+VrnNGahyrqdlNvYs2RVPR
 FSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=f2ggNfCwsjFsKNCjSPM2g4hB/8aV6ufRdZTvgF1Gm8Q=;
 b=pqV1eMJqxZtzoOENWNMGyEjB48XAekg9GKaTOCly5dYEeF1UrfsfuRagtMkOGFsSBw
 lB95++2Y0eZZvEzq3WSYCWsDue7zF16QGYkl98JVh9iDUupxykOSGH/m8DB/25vuwOnz
 3SKZ+XN+apmwDSTGLxJjb88CDidX/Qo3haHYnFGfBKZTHe5LrR801AwYiTjRYpB7kQRF
 ITI3dWq0Xc5iV2a4O+gkm3OmES3/Z8RldfEQF4w7q0/gzXMMJYsaQCATR+75Be4X5H9a
 zRo3wwNERl3V9hLjmRlUnNRF0DSeDokkGqB6vE1HfoYR6Ga8mJQhVveA66sanxLaUnBF
 QuDA==
X-Gm-Message-State: AOAM532liiUIE+TYZeOInOoR+bE+yrsYIGA/8btz2pZ0TJ+t6qKEUcuO
 X/L949Pe9+/3AL6ATLQEDNCTzYPMP8k=
X-Google-Smtp-Source: ABdhPJz3oaR/StdXDQdvFeoAS5rwFXqW347uNs+hR50ElpsZvPgcnujdqrzY3c2XS912L0qigKXiXg==
X-Received: by 2002:a05:6402:524b:: with SMTP id
 t11mr18682066edd.327.1623690945934; 
 Mon, 14 Jun 2021 10:15:45 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:e8cf:b51d:4c59:9c81?
 ([2a02:908:1252:fb60:e8cf:b51d:4c59:9c81])
 by smtp.gmail.com with ESMTPSA id m12sm7733794ejc.65.2021.06.14.10.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jun 2021 10:15:45 -0700 (PDT)
Subject: Re: [PATCH 1/5] dma-buf: fix dma_resv_test_signaled test_all handling
To: Daniel Vetter <daniel@ffwll.ch>
References: <20210611120301.10595-1-christian.koenig@amd.com>
 <YMN3nr1mTj09p8lT@phenom.ffwll.local>
 <2c91e4b4-e8c8-a9f5-420f-9cf0c1f9a67d@gmail.com>
 <YMN5do2/KUt85h5W@phenom.ffwll.local>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a88eacc0-c572-b296-e30b-ec606d716f8f@gmail.com>
Date: Mon, 14 Jun 2021 19:15:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMN5do2/KUt85h5W@phenom.ffwll.local>
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

QW0gMTEuMDYuMjEgdW0gMTY6NTUgc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+IE9uIEZyaSwgSnVu
IDExLCAyMDIxIGF0IDA0OjUzOjExUE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+
Cj4+IEFtIDExLjA2LjIxIHVtIDE2OjQ3IHNjaHJpZWIgRGFuaWVsIFZldHRlcjoKPj4+IE9uIEZy
aSwgSnVuIDExLCAyMDIxIGF0IDAyOjAyOjU3UE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3Jv
dGU6Cj4+Pj4gQXMgdGhlIG5hbWUgaW1wbGllcyBpZiB0ZXN0aW5nIGFsbCBmZW5jZXMgaXMgcmVx
dWVzdGVkIHdlCj4+Pj4gc2hvdWxkIGluZGVlZCB0ZXN0IGFsbCBmZW5jZXMgYW5kIG5vdCBza2lw
IHRoZSBleGNsdXNpdmUKPj4+PiBvbmUgYmVjYXVzZSB3ZSBzZWUgc2hhcmVkIG9uZXMuCj4+Pj4K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4+PiBIbSBJIHRob3VnaHQgd2UndmUgaGFkIHRoZSBydWxlIHRoYXQgd2hlbiBib3Ro
IGZlbmNlcyBleGlzdCwgdGhlbgo+Pj4gY29sbGVjdGl2ZWx5IHRoZSBzaGFyZWQgb25lcyBtdXN0
IHNpZ25hbGUgbm8gZWFybGllciB0aGFuIHRoZSBleGNsdXNpdmUKPj4+IG9uZS4KPj4+Cj4+PiBU
aGF0J3MgYXQgbGVhc3QgdGhlIGNvbnRyYWN0IHdlJ3ZlIGltcGxlbWVudGVkIGluIGRtYV9yZXN2
LmguIEJ1dCBJJ3ZlCj4+PiBhbHNvIGZvdW5kIGEgYnVuY2ggb2YgZHJpdmVycyB3aG8gYXJlIGEg
bG90IG1vcmUgeW9sbyBvbiB0aGlzLgo+Pj4KPj4+IEkgdGhpbmsgdGhlcmUncyBhIHNvbGlkIGNh
c2UgaGVyZSB0byBqdXN0IGFsd2F5cyB0YWtlIGFsbCB0aGUgZmVuY2VzIGlmIHdlCj4+PiBhc2sg
Zm9yIGFsbCB0aGUgc2hhcmVkIG9uZXMsIGJ1dCBpZiB3ZSBnbyB0aGF0IHdheSB0aGVuIEknZCBz
YXkKPj4+IC0gY2xlYXIga2VybmVsZG9jIHBhdGNoIHRvIHJlYWxseSBoYW1tZXIgdGhpcyBpbiAo
Y3VycmVudGx5IHdlJ3JlIG5vdCBnb29kCj4+PiAgICAgYXQgYWxsIGluIHRoaXMgcmVnYXJkKQo+
Pj4gLSBnb2luZyB0aHJvdWdoIGRyaXZlcnMgYSBiaXQgdG8gY2hlY2sgZm9yIHRoaXMgKEkgaGF2
ZSBzb21lIG9mIHRoYXQgZG9uZQo+Pj4gICAgIGFscmVhZHkgaW4gbXkgZWFybGllciBzZXJpZXMs
IG5lZWQgdG8gcmVzcGluIGl0IGFuZCBzZW5kIGl0IG91dCkKPj4+Cj4+PiBCdXQgSSdtIGtpbmRh
IG5vdCBzZWVpbmcgd2h5IHRoaXMgbmVlZHMgdG8gYmUgaW4gdGhpcyBwYXRjaCBzZXJpZXMgaGVy
ZS4KPj4gWW91IG1lbnRpb25lZCB0aGF0IHRoaXMgaXMgYSBwcm9ibGVtIGluIHRoZSBsYXN0IHBh
dGNoIGFuZCBpZiB5b3UgYXNrIG1lCj4+IHRoYXQncyBqdXN0IGEgYnVnIG9yIGF0IGxlYXN0IHZl
cnkgaW5jb25zaXN0ZW50Lgo+Pgo+PiBTZWUgZG1hX3Jlc3Zfd2FpdF90aW1lb3V0KCkgYWx3YXlz
IHdhaXRzIGZvciBhbGwgZmVuY2VzLCBpbmNsdWRpbmcgdGhlCj4+IGV4Y2x1c2l2ZSBvbmUgZXZl
biBpZiBzaGFyZWQgb25lcyBhcmUgcHJlc2VudC4gQnV0IGRtYV9yZXN2X3Rlc3Rfc2lnbmFsZWQo
KQo+PiBpZ25vcmVzIHRoZSBleGNsdXNpdmUgb25lIGlmIHNoYXJlZCBvbmVzIGFyZSBwcmVzZW50
Lgo+IEhtIHRoZSBvbmx5IG9uZSBJIHRob3VnaHQgSSd2ZSBtZW50aW9uZWQgaXMgdGhhdCBkbWFf
YnVmX3BvbGwgZG9lc24ndCB1c2UKPiBkbWFfZmVuY2VfZ2V0X3JjdV9zYWZlIHdoZXJlIEkgdGhp
bmsgaXQgc2hvdWxkLiBEaWZmZXJlbnQgcHJvYmxlbS4gSSB0aGluawo+IHRoaXMgaXMgb25lIHlv
dSBzcG90dGVkLgo+Cj4+IFRoZSBvbmx5IG90aGVyIGRyaXZlciBJIGNvdWxkIGZpbmQgdHJ5aW5n
IHRvIG1ha2UgdXNlIG9mIHRoaXMgaXMgbm91dmVhdSBhbmQKPj4gSSBhbHJlYWR5IHByb3ZpZGVk
IGEgZml4IGZvciB0aGlzIGFzIHdlbGwuCj4gaTkxNSBhbHNvIGRvZXMgdGhpcywgYW5kIEkgdGhp
bmsgSSd2ZSBmb3VuZCBhIGZldyBtb3JlLgo+Cj4+IEkganVzdCB0aGluayB0aGF0IHRoaXMgaXMg
dGhlIG1vcmUgZGVmZW5zaXZlIGFwcHJvYWNoIHRvIGZpeCB0aGlzIGFuZCBoYXZlCj4+IGF0IGxl
YXN0IHRoZSBjb3JlIGZ1bmN0aW9ucyBjb25zaXN0ZW50IG9uIHRoZSBoYW5kbGluZy4KPiBPaCBm
dWxseSBhZ3JlZSwgaXQncyBqdXN0IGN1cnJlbnQgZG1hX3Jlc3YgZG9jcyBhcmVuJ3QgdGhlIGdy
ZWF0ZXN0LCBhbmQKPiBoYWNraW5nIG9uIHNlbWFudGljcyB3aXRob3V0IHVwZGF0aW5nIHRoZSBk
b2NzIGlzbid0IGdyZWF0LiBFc3BlY2lhbGx5Cj4gd2hlbiBpdCdzIGFkLWhvYy4KCldlbGwgd2hl
biB0aGUgcmVxdWlyZW1lbnQgdGhhdCBzaGFyZWQgZmVuY2VzIHNob3VsZCBhbHdheXMgc2lnbmFs
IGFmdGVyIAp0aGUgZXhjbHVzaXZlIGZlbmNlIGlzIG5vdCBkb2N1bWVudGVkIGFueXdoZXJlIHRo
ZW4gSSB3b3VsZCBzYXkgdGhhdCBpdCAKaXMgbmF0dXJhbGx5IGFsbG93ZWQgdG8ganVzdCBhZGQg
YW55IGZlbmNlIHRvIHRoZSBsaXN0IG9mIHNoYXJlZCBmZW5jZSAKYW5kIGFueSBjb2RlIGFzc3Vt
aW5nIHNvbWV0aGluZyBlbHNlIGlzIGp1c3QgYnJva2VuIGFuZCBuZWVkIGZpeGluZy4KCkNocmlz
dGlhbi4KCj4gLURhbmllbAo+Cj4+IENocmlzdGlhbi4KPj4KPj4+IC1EYW5pZWwKPj4+Cj4+Pj4g
LS0tCj4+Pj4gICAgZHJpdmVycy9kbWEtYnVmL2RtYS1yZXN2LmMgfCAzMyArKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMjEgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEt
YnVmL2RtYS1yZXN2LmMgYi9kcml2ZXJzL2RtYS1idWYvZG1hLXJlc3YuYwo+Pj4+IGluZGV4IGYy
NmM3MTc0N2Q0My4uYzY2YmZkZGU5NDU0IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZG1hLWJ1
Zi9kbWEtcmVzdi5jCj4+Pj4gKysrIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1yZXN2LmMKPj4+PiBA
QCAtNjE1LDI1ICs2MTUsMjEgQEAgc3RhdGljIGlubGluZSBpbnQgZG1hX3Jlc3ZfdGVzdF9zaWdu
YWxlZF9zaW5nbGUoc3RydWN0IGRtYV9mZW5jZSAqcGFzc2VkX2ZlbmNlKQo+Pj4+ICAgICAqLwo+
Pj4+ICAgIGJvb2wgZG1hX3Jlc3ZfdGVzdF9zaWduYWxlZChzdHJ1Y3QgZG1hX3Jlc3YgKm9iaiwg
Ym9vbCB0ZXN0X2FsbCkKPj4+PiAgICB7Cj4+Pj4gLQl1bnNpZ25lZCBpbnQgc2VxLCBzaGFyZWRf
Y291bnQ7Cj4+Pj4gKwlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsKPj4+PiArCXVuc2lnbmVkIGlu
dCBzZXE7Cj4+Pj4gICAgCWludCByZXQ7Cj4+Pj4gICAgCXJjdV9yZWFkX2xvY2soKTsKPj4+PiAg
ICByZXRyeToKPj4+PiAgICAJcmV0ID0gdHJ1ZTsKPj4+PiAtCXNoYXJlZF9jb3VudCA9IDA7Cj4+
Pj4gICAgCXNlcSA9IHJlYWRfc2VxY291bnRfYmVnaW4oJm9iai0+c2VxKTsKPj4+PiAgICAJaWYg
KHRlc3RfYWxsKSB7Cj4+Pj4gICAgCQlzdHJ1Y3QgZG1hX3Jlc3ZfbGlzdCAqZm9iaiA9IGRtYV9y
ZXN2X3NoYXJlZF9saXN0KG9iaik7Cj4+Pj4gLQkJdW5zaWduZWQgaW50IGk7Cj4+Pj4gLQo+Pj4+
IC0JCWlmIChmb2JqKQo+Pj4+IC0JCQlzaGFyZWRfY291bnQgPSBmb2JqLT5zaGFyZWRfY291bnQ7
Cj4+Pj4gKwkJdW5zaWduZWQgaW50IGksIHNoYXJlZF9jb3VudDsKPj4+PiArCQlzaGFyZWRfY291
bnQgPSBmb2JqID8gZm9iai0+c2hhcmVkX2NvdW50IDogMDsKPj4+PiAgICAJCWZvciAoaSA9IDA7
IGkgPCBzaGFyZWRfY291bnQ7ICsraSkgewo+Pj4+IC0JCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5j
ZTsKPj4+PiAtCj4+Pj4gICAgCQkJZmVuY2UgPSByY3VfZGVyZWZlcmVuY2UoZm9iai0+c2hhcmVk
W2ldKTsKPj4+PiAgICAJCQlyZXQgPSBkbWFfcmVzdl90ZXN0X3NpZ25hbGVkX3NpbmdsZShmZW5j
ZSk7Cj4+Pj4gICAgCQkJaWYgKHJldCA8IDApCj4+Pj4gQEAgLTY0MSwyNCArNjM3LDE5IEBAIGJv
b2wgZG1hX3Jlc3ZfdGVzdF9zaWduYWxlZChzdHJ1Y3QgZG1hX3Jlc3YgKm9iaiwgYm9vbCB0ZXN0
X2FsbCkKPj4+PiAgICAJCQllbHNlIGlmICghcmV0KQo+Pj4+ICAgIAkJCQlicmVhazsKPj4+PiAg
ICAJCX0KPj4+PiAtCj4+Pj4gLQkJaWYgKHJlYWRfc2VxY291bnRfcmV0cnkoJm9iai0+c2VxLCBz
ZXEpKQo+Pj4+IC0JCQlnb3RvIHJldHJ5Owo+Pj4+ICAgIAl9Cj4+Pj4gLQlpZiAoIXNoYXJlZF9j
b3VudCkgewo+Pj4+IC0JCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlX2V4Y2wgPSBkbWFfcmVzdl9l
eGNsX2ZlbmNlKG9iaik7Cj4+Pj4gLQo+Pj4+IC0JCWlmIChmZW5jZV9leGNsKSB7Cj4+Pj4gLQkJ
CXJldCA9IGRtYV9yZXN2X3Rlc3Rfc2lnbmFsZWRfc2luZ2xlKGZlbmNlX2V4Y2wpOwo+Pj4+IC0J
CQlpZiAocmV0IDwgMCkKPj4+PiAtCQkJCWdvdG8gcmV0cnk7Cj4+Pj4gKwlmZW5jZSA9IGRtYV9y
ZXN2X2V4Y2xfZmVuY2Uob2JqKTsKPj4+PiArCWlmIChmZW5jZSkgewo+Pj4+ICsJCXJldCA9IGRt
YV9yZXN2X3Rlc3Rfc2lnbmFsZWRfc2luZ2xlKGZlbmNlKTsKPj4+PiArCQlpZiAocmV0IDwgMCkK
Pj4+PiArCQkJZ290byByZXRyeTsKPj4+PiAtCQkJaWYgKHJlYWRfc2VxY291bnRfcmV0cnkoJm9i
ai0+c2VxLCBzZXEpKQo+Pj4+IC0JCQkJZ290byByZXRyeTsKPj4+PiAtCQl9Cj4+Pj4gICAgCX0K
Pj4+PiArCWlmIChyZWFkX3NlcWNvdW50X3JldHJ5KCZvYmotPnNlcSwgc2VxKSkKPj4+PiArCQln
b3RvIHJldHJ5Owo+Pj4+ICsKPj4+PiAgICAJcmN1X3JlYWRfdW5sb2NrKCk7Cj4+Pj4gICAgCXJl
dHVybiByZXQ7Cj4+Pj4gICAgfQo+Pj4+IC0tIAo+Pj4+IDIuMjUuMQo+Pj4+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
