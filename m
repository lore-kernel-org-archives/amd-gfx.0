Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4137C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC0061029
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC0061029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A786EE2C;
	Fri, 14 May 2021 07:31:21 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4256EE2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:31:20 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id b25so43281179eju.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 00:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=MeWJn1lwkxmYF65NxG4LtJkp+p22LS33JHgIImsUXpE=;
 b=eAMMv9yTHNgm7dAJqLpDUz305VUqf3cXaecKNjOjZ17lbj6BrB+GxhXVpkdA6wVtMQ
 m1D0zwn/u3O9mkmOOkuft7E6HTDfPOCQ/XratpwmkWum7wuE+JkXgPClFqUuRbvgQ8CA
 rfGYTudoS/HQocrejIYSlIzl+DfSuAad2JwmQP2H0vdDOUGTX+yRsZY42ViyehWMsJtB
 94LzEdVsMxUdDMkHo+/pwiQn8GPZp5eJKFa8upUWBqpUK9Xvbk91ZGjRxE0Kao5bc2iV
 7bj7AR6c2/sWPt6psVSUTpwUE51kWoC/ZMsuAkAIxq50jzzu59SNRbD40XeenlE/0Fly
 qKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=MeWJn1lwkxmYF65NxG4LtJkp+p22LS33JHgIImsUXpE=;
 b=ZuRVUmruhwuM71dskW9OGvNOXuKmKzRkiIfsToTYrIMRRbNtFOzEwiTTKP96CGXxAG
 BrcrCpF/LJMtTOLXYqDTP4dk9gUrn8yr+LUUDhXBNbDnUAAlZbxDOjhS9j3nE0xEZQzl
 ov6en+IWM6tVzNeRtK56oG/+dx44pGbB9arcurgCL7ypl3/fvRsT/YlWmIdye8BPum42
 25hhQqszF32cTNXToZ5Wg32iJTYVs2BosXtPljyuuHBtU7NHQUO5LEGcJQJIoEBFNJRx
 OPiIVep/uFioQiOQ15QwFVRHNL0drfQo8PCGzyMHiWVxgySCpMFyfc4AiP6JNEwj2Y+T
 jL9Q==
X-Gm-Message-State: AOAM533kXhCGrnfX2+zWaRoaFW4s03k3ITm0WVkRroms2ezAq6yo/vnP
 SS32+Q5KybwrB67Kx9ehpa8=
X-Google-Smtp-Source: ABdhPJwrNtqFS9rXsOXwEQOwk1zWCpjPwDnD+DmCADTTUPTIoDfSqB4U3s42bWhiZUf1mbi5Kp2M5Q==
X-Received: by 2002:a17:906:2ed0:: with SMTP id
 s16mr22020058eji.543.1620977479574; 
 Fri, 14 May 2021 00:31:19 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:cf70:a0fd:8c48:efd4?
 ([2a02:908:1252:fb60:cf70:a0fd:8c48:efd4])
 by smtp.gmail.com with ESMTPSA id z12sm3898825edr.17.2021.05.14.00.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 May 2021 00:31:19 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: Don't query CE and UE errors
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210512170302.64951-1-luben.tuikov@amd.com>
 <9d7f82e8-6528-154f-9a23-bf78ff249505@gmail.com>
 <1d54c92e-1448-7aaf-9738-3a22e6799356@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4bebeded-99b7-9b60-b761-7a4d04415424@gmail.com>
Date: Fri, 14 May 2021 09:31:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1d54c92e-1448-7aaf-9738-3a22e6799356@amd.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, stable@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxMy4wNS4yMSB1bSAyMTozNyBzY2hyaWViIEx1YmVuIFR1aWtvdjoKPiBPbiAyMDIxLTA1
LTEzIDM6NTYgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTIuMDUuMjEgdW0g
MTk6MDMgc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4+PiBPbiBRVUVSWTIgSU9DVEwgZG9uJ3QgcXVl
cnkgY291bnRzIG9mIGNvcnJlY3RhYmxlCj4+PiBhbmQgdW5jb3JyZWN0YWJsZSBlcnJvcnMsIHNp
bmNlIHdoZW4gUkFTIGlzCj4+PiBlbmFibGVkIGFuZCBzdXBwb3J0ZWQgb24gVmVnYTIwIHNlcnZl
ciBib2FyZHMsCj4+PiB0aGlzIHRha2VzIGluc3VybW91bnRhYmx5IGxvbmcgdGltZSwgaW4gTyhu
XjMpLAo+Pj4gd2hpY2ggc2xvd3MgdGhlIHN5c3RlbSBkb3duIHRvIHRoZSBwb2ludCBvZiBpdAo+
Pj4gYmVpbmcgdW51c2FibGUgd2hlbiB3ZSBoYXZlIEdVSSB1cC4KPj4+Cj4+PiBGaXhlczogYWUz
NjNhMjEyYjE0ICgiZHJtL2FtZGdwdTogQWRkIGEgbmV3IGZsYWcgdG8gQU1ER1BVX0NUWF9PUF9R
VUVSWV9TVEFURTIiKQo+Pj4gQ2M6IEFsZXhhbmRlciBEZXVjaGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPgo+Pj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPj4+IFNpZ25lZC1vZmYt
Ynk6IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+Cj4+PiAtLS0KPj4+ICAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDI2ICsrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMyBk
ZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5j
Cj4+PiBpbmRleCAwMWZlNjBmZWRjYmUuLmQ0ODFhMzNmNGVhZiAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+Pj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4+PiBAQCAtMzYzLDE5ICszNjMsMTkgQEAg
c3RhdGljIGludCBhbWRncHVfY3R4X3F1ZXJ5MihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
Pj4+ICAgIAkJb3V0LT5zdGF0ZS5mbGFncyB8PSBBTURHUFVfQ1RYX1FVRVJZMl9GTEFHU19HVUlM
VFk7Cj4+PiAgICAKPj4+ICAgIAkvKnF1ZXJ5IHVlIGNvdW50Ki8KPj4+IC0JcmFzX2NvdW50ZXIg
PSBhbWRncHVfcmFzX3F1ZXJ5X2Vycm9yX2NvdW50KGFkZXYsIGZhbHNlKTsKPj4+IC0JLypyYXMg
Y291bnRlciBpcyBtb25vdG9uaWMgaW5jcmVhc2luZyovCj4+PiAtCWlmIChyYXNfY291bnRlciAh
PSBjdHgtPnJhc19jb3VudGVyX3VlKSB7Cj4+PiAtCQlvdXQtPnN0YXRlLmZsYWdzIHw9IEFNREdQ
VV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19VRTsKPj4+IC0JCWN0eC0+cmFzX2NvdW50ZXJfdWUgPSBy
YXNfY291bnRlcjsKPj4+IC0JfQo+Pj4gLQo+Pj4gLQkvKnF1ZXJ5IGNlIGNvdW50Ki8KPj4+IC0J
cmFzX2NvdW50ZXIgPSBhbWRncHVfcmFzX3F1ZXJ5X2Vycm9yX2NvdW50KGFkZXYsIHRydWUpOwo+
Pj4gLQlpZiAocmFzX2NvdW50ZXIgIT0gY3R4LT5yYXNfY291bnRlcl9jZSkgewo+Pj4gLQkJb3V0
LT5zdGF0ZS5mbGFncyB8PSBBTURHUFVfQ1RYX1FVRVJZMl9GTEFHU19SQVNfQ0U7Cj4+PiAtCQlj
dHgtPnJhc19jb3VudGVyX2NlID0gcmFzX2NvdW50ZXI7Cj4+PiAtCX0KPj4+ICsJLyogcmFzX2Nv
dW50ZXIgPSBhbWRncHVfcmFzX3F1ZXJ5X2Vycm9yX2NvdW50KGFkZXYsIGZhbHNlKTsgKi8KPj4+
ICsJLyogL1wqcmFzIGNvdW50ZXIgaXMgbW9ub3RvbmljIGluY3JlYXNpbmcqXC8gKi8KPj4+ICsJ
LyogaWYgKHJhc19jb3VudGVyICE9IGN0eC0+cmFzX2NvdW50ZXJfdWUpIHsgKi8KPj4+ICsJLyog
CW91dC0+c3RhdGUuZmxhZ3MgfD0gQU1ER1BVX0NUWF9RVUVSWTJfRkxBR1NfUkFTX1VFOyAqLwo+
Pj4gKwkvKiAJY3R4LT5yYXNfY291bnRlcl91ZSA9IHJhc19jb3VudGVyOyAqLwo+Pj4gKwkvKiB9
ICovCj4+PiArCj4+PiArCS8qIC9cKnF1ZXJ5IGNlIGNvdW50KlwvICovCj4+PiArCS8qIHJhc19j
b3VudGVyID0gYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9jb3VudChhZGV2LCB0cnVlKTsgKi8KPj4+
ICsJLyogaWYgKHJhc19jb3VudGVyICE9IGN0eC0+cmFzX2NvdW50ZXJfY2UpIHsgKi8KPj4+ICsJ
LyogCW91dC0+c3RhdGUuZmxhZ3MgfD0gQU1ER1BVX0NUWF9RVUVSWTJfRkxBR1NfUkFTX0NFOyAq
Lwo+Pj4gKwkvKiAJY3R4LT5yYXNfY291bnRlcl9jZSA9IHJhc19jb3VudGVyOyAqLwo+Pj4gKwkv
KiB9ICovCj4+IFBsZWFzZSBjb21wbGV0ZWx5IGRyb3AgdGhlIGNvZGUuIFdlIHVzdWFsbHkgZG9u
J3Qga2VlcCBjb21tZW50ZWQgb3V0Cj4+IGNvZGUgaW4gdGhlIGRyaXZlci4KPiAxLiBBbGV4IHN1
Z2dlc3RlZCB0aGlzIHdoZW4gd2UgY2hhdHRlZC0tdGhpcyBpcyB3aHkgaXQgaXMgY29tbWVudGVk
LgoKU291bmRzIGxpa2UgYSBtaXN1bmRlcnN0YW5kaW5nIHRvIG1lLCB1c3VhbGx5IGl0IGlzIEFs
ZXggd2hvIGluc2lzdHMgb24gCmRyb3BwaW5nIHRoZSBjb2RlLgoKPiAyLiBIZSBzdWdnZXN0ZWQg
dGhlIHNhbWUgdGhpbmcgbGFzdCBuaWdodCBhbmQgMi41IGhvdXJzIGJlZm9yZSB5b3VyIGVtYWls
LAo+ICDCoMKgwqAgSSBwb3N0ZWQgYSBwYXRjaCBpbiB3aGljaCB0aGUgY29kZSBpcyBjb21tZW50
ZWQgb3V0LS1kaWQgeW91IG5vdCBzZWUgaXQ/Cj4gIMKgwqDCoCBJdCdzIHRocmVhZGVkLCBpdCBh
cHBlYXJzIGFib3ZlLCAyLjUgaG91cnMgYmVmb3JlIHlvdXIgZW1haWwuCgpTb3JyeSBmb3IgdGhl
IHJlZHVuZGFuY3ksIGRpZG4ndCBoYWQgc2VlbiB0aGF0IGluIG15IGluYm94IHlldCB3aGVuIEkg
Cndyb3RlIHRoZSByZXBseS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+IEx1
YmVuCj4KPj4gV2l0aCB0aGF0IGRvbmUgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnCj4+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Cj4+IENocmlzdGlhbi4K
Pj4KPj4+ICAgIAo+Pj4gICAgCW11dGV4X3VubG9jaygmbWdyLT5sb2NrKTsKPj4+ICAgIAlyZXR1
cm4gMDsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
