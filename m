Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32092C5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 09:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A041207FA
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 09:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A041207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05C86E8DE;
	Wed,  6 Nov 2019 09:36:55 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A0B56E8DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 09:36:54 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c17so2523845wmk.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Nov 2019 01:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=CWlWktNjps5V7oUFAyEx5KGzwLx9iqMFwbvA11IcL8c=;
 b=kObLkHgq4JOWRsxhwTWuZmN7w3t8rtQNxxZelRJoNhrvm7qcmm/MlC4++hjtOrhmi0
 Clt8iJNVJ1ze9QuzUv3bZcarVKVG6XR8lOZuo0y/CQbalASuAyGXW5068R1rC0IvZqpk
 gGWIPr+7mbABtaKYG8rFFmx/lYSjUyxk10FeogQ84wtN3TgPB+15qmGYGgvlEn7dLdKL
 IhM0RAIW/HLHznmWuBNDPmNYxxC1mr4BDz9dlzV63wRdplkRBbL6q9hvNZoj5pkqEAAN
 y9yLF/LqcuGCXyztRPBouTgdzKJXdZ0jHX33qmYHWSiORzhhYoU5Gf923+mj7LErv0AN
 ATew==
X-Gm-Message-State: APjAAAXiFo0GCwtHsyzU1VuU9eqYqhz1wrxKq3aXez93Yq6xNMr/SUNn
 KVyPcAty6A/TsMNiI+Tbc53TnFfF
X-Google-Smtp-Source: APXvYqx9+hdfXRj4DnJJZAp0O59zKHtd0x7L9mxjk8d3xSRPY3byy5UkfJOfv5qv9zI5/W0PK5QrXg==
X-Received: by 2002:a1c:48f:: with SMTP id 137mr1609926wme.68.1573033012832;
 Wed, 06 Nov 2019 01:36:52 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u187sm2299296wme.15.2019.11.06.01.36.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Nov 2019 01:36:52 -0800 (PST)
Subject: Re: [PATCH] drm/amd/powerplay: Protect backend resource when unload
 driver
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "Zhang, Zhexi (Jesse)" <Zhexi.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1573021862-10078-1-git-send-email-zhexi.zhang@amd.com>
 <MN2PR12MB3344E5BA8192D27C0A9D61B0E4790@MN2PR12MB3344.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <30aabf13-6a67-9e38-41d0-bad7dff2f7cf@gmail.com>
Date: Wed, 6 Nov 2019 10:36:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB3344E5BA8192D27C0A9D61B0E4790@MN2PR12MB3344.namprd12.prod.outlook.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=CWlWktNjps5V7oUFAyEx5KGzwLx9iqMFwbvA11IcL8c=;
 b=m5kcgNgk1lYijtgNRI9/N3Hb20dDUbh1GXVaRedl2UwUX8RIc1JXeuvpo6hbr7CJYC
 v4+Y5CnKD9dSu4VyclVyhB1Xnl5xvJ4b/73YnhjZN/MWrlZ/GEp6NVN/XdOl5f3G7ier
 6r8qu1rN6jHokanpGF8fYH9fGX16dK1vwEBrZpMqRYOTgvZ/CKA/7lvLQvMq+5LsfBnh
 3ZFegpjW9r5tUIoBJ58wDJmJe5HfROG7sXjfFviOVqdr/H64+OmTL+sfFaQvuR+7lba6
 zg9Zq79v3zXelU0y/Xx0N9Nb6ak5QNUbhNlE/8q9KMc9/OggsRSQscX+opHRUxDHh0JP
 5ocQ==
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106093651.VMjpzvv-PB7FisvDKLSnXGv36qwBbrNikCRBowJFm-8@z>

QWdhaW4gdGhhdCBsb29rcyBsaWtlIHRoZSB3cm9uZyBhcHByb2FjaCB0byBtZS4KCkhvdyBhcmUg
dGhlIFVWRC9WQ0UgcG93ZXIgZ2F0ZSBmdW5jdGlvbnMgY2FsbGVkIGhlcmU/CgpXZSBtb3N0IGxp
a2VseSBqdXN0IGZvcmdldCB0byBjYW5jZWwvZmx1c2ggc29tZSBiYWNrZ3JvdW5kIHdvcmtlciBp
bnN0ZWFkLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKQW0gMDYuMTEuMTkgdW0gMTA6MTMgc2Nocmll
YiBRdWFuLCBFdmFuOgo+IEkga2luZCBvZiBmZWVsaW5nIHRoZSBjaGFuZ2VzIG9mIFZDRSBhbmQg
VVZEKG9mIHZlZ2ExMF9od21nci5jKSBhcmUgbm90IG5lZWRlZCBhcyB0aGVyZSBpcyBhbHJlYWR5
IGxvY2sgcHJvdGVjdGlvbiBpbiBwcF9kcG1fcG93ZXJnYXRlX3V2ZC92Y2UuCj4gQ2FuIHlvdSBo
ZWxwIHRvIGNvbmZpcm0gdGhhdD8KPgo+IFJlZ2FyZHMsCj4gRXZhbgo+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgSmVzc2UKPj4gWmhhbmcKPj4gU2VudDogV2VkbmVz
ZGF5LCBOb3ZlbWJlciA2LCAyMDE5IDI6MzEgUE0KPj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4+IENjOiBaaGFuZywgWmhleGkgKEplc3NlKSA8WmhleGkuWmhhbmdAYW1kLmNv
bT4KPj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTogUHJvdGVjdCBiYWNrZW5k
IHJlc291cmNlIHdoZW4gdW5sb2FkCj4+IGRyaXZlcgo+Pgo+PiBHdWVzdCBkcml2ZXIgY2FuIGJl
IHVubG9hZGVkIHdoaWxlIGVuZ2luZXMgc3RpbGwgdXNpbmcgc29tZSBiYWNrZW5kIHJlc291cmNl
cwo+PiB3aGljaCB3aG91bGQgbGVhZCB0byBndWVzdCBkcml2ZXIgdW5sb2FkIGZhaWx1cmUuCj4+
Cj4+IE5lZWQgdG8gYWRkIG11dGV4IGxvY2sgdG8gcHJvdGVjdCBiYWNrZW5kIHJlc291cmNlcyBm
cm9tIGNvbmN1cnJlbnQKPj4gb3BlcmF0aW9ucwo+Pgo+PiBCZWZvcmUgZW50ZXJpbmcgcG93ZXJn
YXRpbmcgbW9kZSwgVkNFIGFuZCBVVkQgbmVlZCB0byBjaGVjayBpZiBiYWNrZW5kCj4+IHJlc291
cmNlcyBhcmUgc3RpbGwgYXZhaWxhYmxlLgo+Pgo+PiBDaGFuZ2UtSWQ6IEljYzM0ZjkzODE4NzQz
ODU2YzRlZmJiYmY5NDgwZTRkOWYyZTBkMWUxCj4+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5n
IDx6aGV4aS56aGFuZ0BhbWQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9hbWRfcG93ZXJwbGF5LmMgICAgICB8IDQgKysrKwo+PiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jIHwgNiArKysrKysKPj4gICAyIGZp
bGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYwo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYwo+PiBpbmRleCAwMzE0NDc2Li5jODI1NzBi
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJw
bGF5LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxh
eS5jCj4+IEBAIC0xMzQsNyArMTM0LDkgQEAgc3RhdGljIGludCBwcF9od19maW5pKHZvaWQgKmhh
bmRsZSkKPj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBoYW5kbGU7Cj4+ICAgCXN0
cnVjdCBwcF9od21nciAqaHdtZ3IgPSBhZGV2LT5wb3dlcnBsYXkucHBfaGFuZGxlOwo+Pgo+PiAr
CW11dGV4X2xvY2soJmh3bWdyLT5zbXVfbG9jayk7Cj4+ICAgCWh3bWdyX2h3X2ZpbmkoaHdtZ3Ip
Owo+PiArCW11dGV4X3VubG9jaygmaHdtZ3ItPnNtdV9sb2NrKTsKPj4KPj4gICAJcmV0dXJuIDA7
Cj4+ICAgfQo+PiBAQCAtNjYyLDcgKzY2NCw5IEBAIHN0YXRpYyBpbnQgYW1kX3Bvd2VycGxheV9y
ZXNldCh2b2lkICpoYW5kbGUpCj4+ICAgCXN0cnVjdCBwcF9od21nciAqaHdtZ3IgPSBoYW5kbGU7
Cj4+ICAgCWludCByZXQ7Cj4+Cj4+ICsJbXV0ZXhfbG9jaygmaHdtZ3ItPnNtdV9sb2NrKTsKPj4g
ICAJcmV0ID0gaHdtZ3JfaHdfZmluaShod21ncik7Cj4+ICsJbXV0ZXhfdW5sb2NrKCZod21nci0+
c211X2xvY2spOwo+PiAgIAlpZiAocmV0KQo+PiAgIAkJcmV0dXJuIHJldDsKPj4KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5j
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMK
Pj4gaW5kZXggNDY1MzgyMzMuLmY3MmJhNzAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jCj4+IEBAIC00NjE2LDYgKzQ2
MTYsOSBAQCBzdGF0aWMgdm9pZCB2ZWdhMTBfcG93ZXJfZ2F0ZV92Y2Uoc3RydWN0Cj4+IHBwX2h3
bWdyICpod21nciwgYm9vbCBiZ2F0ZSkKPj4gICB7Cj4+ICAgCXN0cnVjdCB2ZWdhMTBfaHdtZ3Ig
KmRhdGEgPSBod21nci0+YmFja2VuZDsKPj4KPj4gKwlpZiAoIWRhdGEpCj4+ICsJCXJldHVybjsK
Pj4gKwo+PiAgIAlkYXRhLT52Y2VfcG93ZXJfZ2F0ZWQgPSBiZ2F0ZTsKPj4gICAJdmVnYTEwX2Vu
YWJsZV9kaXNhYmxlX3ZjZV9kcG0oaHdtZ3IsICFiZ2F0ZSk7Cj4+ICAgfQo+PiBAQCAtNDYyNCw2
ICs0NjI3LDkgQEAgc3RhdGljIHZvaWQgdmVnYTEwX3Bvd2VyX2dhdGVfdXZkKHN0cnVjdAo+PiBw
cF9od21nciAqaHdtZ3IsIGJvb2wgYmdhdGUpCj4+ICAgewo+PiAgIAlzdHJ1Y3QgdmVnYTEwX2h3
bWdyICpkYXRhID0gaHdtZ3ItPmJhY2tlbmQ7Cj4+Cj4+ICsJaWYgKCFkYXRhKQo+PiArCQlyZXR1
cm47Cj4+ICsKPj4gICAJZGF0YS0+dXZkX3Bvd2VyX2dhdGVkID0gYmdhdGU7Cj4+ICAgCXZlZ2Ex
MF9lbmFibGVfZGlzYWJsZV91dmRfZHBtKGh3bWdyLCAhYmdhdGUpOwo+PiAgIH0KPj4gLS0KPj4g
Mi43LjQKPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
