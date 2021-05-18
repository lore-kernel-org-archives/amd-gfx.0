Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C3C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6362611B0
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6362611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593536E0D8;
	Tue, 18 May 2021 18:06:16 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86F36E0D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 18:06:14 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id k14so12528529eji.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=W781wm4je5X5vBzI/7qDNu/f4oczEfHTo4w8ol1/Ib4=;
 b=WC9msysQixsPHmdcEB/jltmiyQjyEW/NPN/yWuDRptnw7MbrF/5mXJiKpu/MOr4Rtq
 XsA4ZSzweyQkKuWWGJxoy6Lvu0g7kvWk+1tZrN4FtfY+al0/ERHiPGbYwfJYqJr90dCd
 Ji7ws7QWsIgaYpJLuWCMUpLFSd+gsZVaAVumuM0EM1EmvxEpBqKDpXvDMCuOIfU7azZH
 k44X8pTdbYxsgcYkXaP8IR5IQdFilBpte+jGNxp1lNdtMVxQjvRG1stOqXdqmaCOuSZ1
 DRILXaqxWkn6ld1mRq25XEFSLAAX/IQTvsnBaFGe9nzjRBrILge2b0E4H6l3w1P1Hzcc
 Xs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=W781wm4je5X5vBzI/7qDNu/f4oczEfHTo4w8ol1/Ib4=;
 b=cKQdCAOZEVkTuUhgndzHBwfFAqcjB9sQHr3WC3VCY2FSKGTbQcG/d2XhRgc9OjusLf
 lng7Vh/GZ/f4pCOxB3ismnxb7hVPOi8IicY0MqJnht26FXJTChgGeD03bkbqKPtZs7x/
 ppdbl9qO3ciQ8g2IVvtTlCz0ojYwsknygB1QmvucpLdaKtPCQGMeMNV9tM9u+9J5JZOi
 8QjBF2Ed4ys8z69KhY9MHJQyIZOHmHjHw5gNMJcetl5nOuoEDivyBFzMVhhNw3QIh3h6
 sG+tzmdDguq/A7cdNmwcYe/gntfSmPy4iJ5sr9awfzTBuuKH8wVtx/8roOGiUqGQMKgX
 Oi2g==
X-Gm-Message-State: AOAM531NakNTrQhuI0pdDAeW+pF4Abis0Rw7qSfblz+3rAidMrXiPsEy
 5ku0lUr1ciOttBz1kxeuJBssqqCwJyY=
X-Google-Smtp-Source: ABdhPJwu6y+AAYAJr7RsvyVCElgndIwIZV8XpBPe+dq5hZael9G7HMWCjP9EWwUW2IuLCShiDo9GuA==
X-Received: by 2002:a17:906:1d43:: with SMTP id
 o3mr7337702ejh.466.1621361172767; 
 Tue, 18 May 2021 11:06:12 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:88c7:d7d9:22ef:f850?
 ([2a02:908:1252:fb60:88c7:d7d9:22ef:f850])
 by smtp.gmail.com with ESMTPSA id bm24sm6732299edb.45.2021.05.18.11.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 11:06:12 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/vcn1: add cancel_delayed_work_sync before
 power gate
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1621350686-25923-1-git-send-email-James.Zhu@amd.com>
 <352509e8-a836-f803-fbda-e31e0283dc41@gmail.com>
 <af3751e7-c65b-b1d2-ac84-d88509ad9e31@amd.com>
 <bc35c564-0b25-3e9d-7bf7-04762405f640@gmail.com>
 <f2f9cd8e-2ed5-9b6f-6fd7-ee523c493061@amd.com>
 <efcc2430-836b-7fcd-71f9-b2ba45258177@gmail.com>
 <fb1e33bf-b597-baef-b7fe-094c8128f4c5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c2262f26-b83c-1290-a19e-fdb4905b2411@gmail.com>
Date: Tue, 18 May 2021 20:06:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fb1e33bf-b597-baef-b7fe-094c8128f4c5@amd.com>
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

QW0gMTguMDUuMjEgdW0gMTk6MDQgc2NocmllYiBKYW1lcyBaaHU6Cj4KPiBPbiAyMDIxLTA1LTE4
IDEyOjM2IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE4LjA1LjIxIHVtIDE3
OjU5IHNjaHJpZWIgSmFtZXMgWmh1Ogo+Pj4KPj4+IE9uIDIwMjEtMDUtMTggMTE6NTQgYS5tLiwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pgo+Pj4+Cj4+Pj4gQW0gMTguMDUuMjEgdW0gMTc6
NDUgc2NocmllYiBKYW1lcyBaaHU6Cj4+Pj4+Cj4+Pj4+IE9uIDIwMjEtMDUtMTggMTE6MjMgYS5t
LiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4+IEFtIDE4LjA1LjIxIHVtIDE3OjExIHNj
aHJpZWIgSmFtZXMgWmh1Ogo+Pj4+Pj4+IEFkZCBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMgYmVm
b3JlIHNldCBwb3dlciBnYXRpbmcgc3RhdGUKPj4+Pj4+PiB0byBhdm9pZCByYWNlIGNvbmRpdGlv
biBpc3N1ZSB3aGVuIHBvd2VyIGdhdGluZy4KPj4+Pj4+Pgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4gwqAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyB8IDE5ICsrKysrKysrKysrKysrKysr
Ky0KPj4+Pj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Pj4+Pj4+Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3Zjbl92MV8wLmMgCj4+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25f
djFfMC5jCj4+Pj4+Pj4gaW5kZXggMGMxYmVlZi4uNmM1YzA4MyAxMDA2NDQKPj4+Pj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCj4+Pj4+Pj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwo+Pj4+Pj4+IEBAIC0yMzAsMTAgKzIz
MCwyNyBAQCBzdGF0aWMgaW50IHZjbl92MV8wX2h3X2luaXQodm9pZCAqaGFuZGxlKQo+Pj4+Pj4+
IMKgIHN0YXRpYyBpbnQgdmNuX3YxXzBfaHdfZmluaSh2b2lkICpoYW5kbGUpCj4+Pj4+Pj4gwqAg
ewo+Pj4+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7Cj4+Pj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmc7Cj4+Pj4+Pj4gK8KgwqDCoCBpbnQgaTsKPj4+Pj4+PiArCj4+Pj4+Pj4gK8KgwqDC
oCByaW5nID0gJmFkZXYtPnZjbi5pbnN0LT5yaW5nX2RlYzsKPj4+Pj4+PiArwqDCoMKgIHJpbmct
PnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICvCoMKgwqAgZm9yIChpID0g
MDsgaSA8IGFkZXYtPnZjbi5udW1fZW5jX3JpbmdzOyArK2kpIHsKPj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgcmluZyA9ICZhZGV2LT52Y24uaW5zdC0+cmluZ19lbmNbaV07Cj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIHJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4+Pj4+Pj4gK8KgwqDCoCB9Cj4+
Pj4+Pj4gKwo+Pj4+Pj4+ICvCoMKgwqAgcmluZyA9ICZhZGV2LT5qcGVnLmluc3QtPnJpbmdfZGVj
Owo+Pj4+Pj4+ICvCoMKgwqAgcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKPj4+Pj4+Cj4+Pj4+
PiBUaGlua2luZyBtb3JlIGFib3V0IHRoYXQgdGhpcyBpcyBhIHJlYWxseSBiaWcgTkFLLiBUaGUg
c2NoZWR1bGVyIAo+Pj4+Pj4gdGhyZWFkcyBtdXN0IHRvIHN0YXkgcmVhZHkgZHVyaW5nIGEgcmVz
ZXQuCj4+Pj4+Pgo+Pj4+Pj4gVGhpcyBpcyBjb250cm9sbGVkIGJ5IHRoZSB1cHBlciBsYXllciBh
bmQgc2hvdWxkbid0IGJlIG1lc3NlZCAKPj4+Pj4+IHdpdGggaW4gdGhlIGhhcmR3YXJlIHNwZWNp
ZmljIGJhY2tlbmQgYXQgYWxsLgo+Pj4+Pgo+Pj4+Pj4gW0paXSBJIHBvcnRlZCB0aGlzIGZyb20g
Y3VycmVudCB2Y24zIGh3X2ZpbmkuIEp1c3Qgd2FudCB0byBtYWtlIAo+Pj4+Pj4gc3VyZSB0aGF0
IG5vIG1vcmUgbmV3IGpvYnMgd2lsbCBiZSBzY2hlZHVsZWQgYWZ0ZXIgc3VzcGVuZCAKPj4+Pj4+
IHByb2Nlc3Mgc3RhcnRzLgo+Pj4+PiBJdCBtYXkgYSByZWR1bmRhbmN5LCBzaW5jZSBzY2hlZHVs
ZXIgbWF5YmUgYWxyZWFkeSBzdXNwZW5kLiBJIGNhbiAKPj4+Pj4gcmVtb3ZlIHRob3NlIGlmIHlv
dSBhcmUgc3VyZSBubyBzaWRlIGVmZmVjdCwKPj4+Pgo+Pj4+IFdlbGwsIHdlICptdXN0KiByZW1v
dmUgdGhvc2UuIFRoaXMgZmxhZyBjb250cm9scyBpZiB0aGUgaGFyZHdhcmUgCj4+Pj4gZW5naW5l
IGNhbiBiZSB1c2VkIGZvciBjb21tYW5kIHN1Ym1pc3Npb24gYW5kIGlzIG9ubHkgYmUgc2V0IHRv
IAo+Pj4+IHRydWUvZmFsc2UgZHVyaW5nIGluaXRpYWwgZHJpdmVyIGxvYWQuCj4+Pj4KPj4+PiBJ
ZiB5b3UgY2hhbmdlIGl0IHRvIGZhbHNlIGR1cmluZyBod19maW5pIHRoZSBlbmdpbmUgd29uJ3Qg
d29yayAKPj4+PiBjb3JyZWN0bHkgYW55IG1vcmUgYWZ0ZXIgR1BVIHJlc2V0IG9yIHJlc3VtZS4K
Pj4+IFtKWl0gSWYgSSByZWNhbGxlZCBjb3JyZWN0bHkgdGF0IGh3X2luaXQgd2lsbCBiZSBjYWxs
ZWQgZXZlcnkgdGltZSAKPj4+IGFmdGVyIEdQVSByZXNldCBvciBzdXNwZW5kL3Jlc3VtZSwKPj4K
Pj4gWWVzIHRoYXQncyBjb3JyZWN0Lgo+Pgo+PiBCdXQgYmVmb3JlIHRoYXQgYW5kIGR1cmluZyBH
UFUgcmVzZXQgdGhlIHJlYWR5IGZsYWcgaXMgdGhlbiBmYWxzZSBmb3IgCj4+IGEgc2hvcnQgcGVy
aW9kIG9mIHRpbWUgd2hpY2ggd291bGQgcmVzdWx0IGluIHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMg
Cj4+IGNyYXNoaW5nIHdoZW4gdGhleSB0cnkgdG8gc3VibWl0IHNvbWV0aGluZy4KPiBbSlpdwqAg
QXBwbGljYXRpb24gc2hvdWxkIGhhbmRsZSBzaXR1YXRpb24gd2hlbiBzdWJtaXNzaW9uIGZhaWxl
ZCAKPiB3aXRob3V0IGNyYXNoLk1heWJlIGRyaXZlciBzaG91bGQgcmV0dXJuIC1FQUdBSU4gdG8g
YXNrIGFwcGxpY2F0aW9uIHRvIAo+IHN1Ym1pdCBqb2IgbGF0ZXIgd2hlbiBncHUgaXMgdW5kZXIg
cmVzZXQvc3VzcGVuZC1yZXN1bWUuCgpObywgYnkgZGVzaWduIGRyaXZlciBzaG91bGQgYWx3YXlz
IGJlIGFibGUgdG8gYWNjZXB0IGpvYnMgZXhjZXB0IGZvciB0aGUgCmNhc2Ugd2hlbiB0aGUgaGFy
ZHdhcmUgaXMgdW5yZWNvdmVyYWJsZSBicm9rZW4uCgpUaGlzIGlzIGhvdyB3ZSBoYXZlIGltcGxl
bWVudGVkIHVzZXJzcGFjZSBhbHJlYWR5LgoKPj4gVGhlIGZsYWcgZXNzZW50aWFsbHkgc2F5cyB0
aGF0IHVzZXJzcGFjZSBjYW4gc3VibWl0IGpvYnMgdG8gdGhlIAo+PiBzY2hlZHVsZXIuIFByb2Nl
c3Npbmcgb2YgdGhvc2Ugam9icyBpcyBvZiBjb3Vyc2Ugb25seSBzdGFydGVkIGFmdGVyIAo+PiB0
aGUgaGFyZHdhcmUgaXMgcmUtaW5pdGlhbGl6ZWQsIGJ1dCBwdXNoaW5nIGpvYnMgZG93biB0aGUg
cGlwZSBpcyAKPj4gc3RpbGwgcGVyZmVjdGx5IHZhbGlkIGluIHRoYXQgc2l0dWF0aW9uLgo+IFtK
Wl0gSSBhbSB3b25kZXJpbmcgaWYgaXQgaXMgcmVxdWVzdGVkIHRvIHN0b3Agc2NoZWR1bGluZyBu
ZXcgam9icyAKPiBiZWZvcmUgc2F2ZSBiby4KClllcywgdGhhdCBpcyBndWFyYW50ZWVkLiBUaGUg
aGFyZHdhcmUgYmFja2VuZCBkb2Vzbid0IG5lZWQgdG8gd29ycnkgCmFib3V0IHRoaXMgaW4gaHdf
ZmluaSgpIG9yIG90aGVyd2lzZSB3ZSBoYXZlIGEgYnVnLgoKQ2hyaXN0aWFuLgoKPj4KPj4gQ2hy
aXN0aWFuLgo+Pgo+Pj4+Cj4+Pj4gSWYgeW91IGhhdmUgYW55IGlkZWEgaG93IHRvIGRvY3VtZW50
IHRoYXQgZmFjdCB0aGVuIHBsZWFzZSBzcGVhayAKPj4+PiB1cCwgY2F1c2Ugd2UgaGFkIHRoaXMg
cHJvYmxlbSBhIGNvdXBsZSBvZiB0aW1lcyBub3cuCj4+Pj4KPj4+PiBKdXN0IHNlbmQgb3V0IGEg
cGF0Y2ggZml4aW5nIHZhcmlvdXMgb3RoZXIgb2NjYXNpb25zIG9mIHRoYXQuCj4+Pj4KPj4+PiBS
ZWdhcmRzLAo+Pj4+IENocmlzdGlhbi4KPj4+Pgo+Pj4+Pgo+Pj4+Pj4gSSd2ZSByZW1vdmVkIGFs
bCBvZiB0aG9zZSBhIGNvdXBsZSBvZiB5ZWFycyBhZ28uCj4+Pj4+Pgo+Pj4+Pj4gUmVnYXJkcywK
Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICsgY2FuY2VsX2RlbGF5
ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uaWRsZV93b3JrKTsKPj4+Pj4+PiDCoCDCoMKgwqDCoMKg
IGlmICgoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9WQ05fRFBHKSB8fAo+Pj4+Pj4+
IC3CoMKgwqDCoMKgwqDCoCBSUkVHMzJfU09DMTUoVkNOLCAwLCBtbVVWRF9TVEFUVVMpKQo+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCAoYWRldi0+dmNuLmN1cl9zdGF0ZSAhPSBBTURfUEdfU1RBVEVf
R0FURSAmJgo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0MxNShWQ04sIDAsIG1t
VVZEX1NUQVRVUykpKSB7Cj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHZjbl92MV8wX3NldF9w
b3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfUEdfU1RBVEVfR0FURSk7Cj4+Pj4+Pj4gK8KgwqDC
oCB9Cj4+Pj4+Pj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+Pj4+PiDCoCB9Cj4+Pj4+Pgo+
Pj4+Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
