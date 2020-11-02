Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA262C388F9
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 19:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FE422275
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 19:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRZ/RNA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FE422275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2ABB6E321;
	Mon,  2 Nov 2020 19:58:11 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D8536E321
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 19:58:11 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id w1so14469348edv.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 11:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=p9PEo+ny35qWNB3Kt52BIfcr1L55HCtTwlmief9704Y=;
 b=pRZ/RNA/r+cwvkBpFOhUYPC3MLi7isek4btoFpafSYC6iFZ3sRgMYbynwFwauSr1F9
 xVSbUpE94MEUkOZGPUkQloF6TETCf12/qlPe53cSZesqG54dXIrXRDRkCTQsDl91THMj
 heWg3kRD//pCIt/d62Kq/3T1ThiFVU3X2foR1KCZY+afTZj0Vi2Msaub+2iQtp2CUVnJ
 kH7ex1JmqiEhZX3/YgHIeSsIFAybrW7+rWzw9M4c6o0z0WIyFRFC7NNO1eC5tjcik91B
 CUzxis/7IVEIWEFYpaFtKmC9WVZIdsdtT76zY9hXZwhIYYcL4dOJiXTRbQysgILPrUsn
 2VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=p9PEo+ny35qWNB3Kt52BIfcr1L55HCtTwlmief9704Y=;
 b=oIeIXYNJGRRpBhnvdL5AgubrpyDv/xid0ItvvaOx8orl/iMg0d7kn4mO8D1WNQxXKo
 xzQ9pnbgtyUM8CvXnkPnj1BmrUz1xLIwdlfdT0vB8750n9q3Tn6SQMvjLVGIk63C8EGi
 9OvPceJHV5imSUC4CqT7ZZ0jbhWdPX7rWbG+L0YZ+br+Ns+VJGoPAb3SLpsrJ07aJbOQ
 60kqwuxyb7Ne9Et0MMmovdE0M9JErvEQKd4ONa9l6kXIELe8n36KjJdkuSt8Z9Fuxkas
 dTNbuF4tTnofDEucEQ6i2VxN0jCRTvLxl7aO/7hGqCcABbrPU0wwjs6FmFbV3deVDSvj
 yK/A==
X-Gm-Message-State: AOAM5308sFA0Fsz1EtLVIc2m0b3gWAu6Z9VjOdMIL9rMB9MJ3Pf1Q7t+
 RMRdjjlsLqKJaOxngTLXUojZVt1Nwf8=
X-Google-Smtp-Source: ABdhPJwoOKN/ou7btnCOJpHXY4clOZMKvFrfoU2pflynqqjBuMrlZ4V9TjvAqjKGVk1H0D3NRQls7Q==
X-Received: by 2002:aa7:c44d:: with SMTP id n13mr2282807edr.138.1604347089920; 
 Mon, 02 Nov 2020 11:58:09 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id dp1sm10007239ejc.74.2020.11.02.11.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 11:58:09 -0800 (PST)
Subject: Re: [PATCH 2/3] drm/amdgpu: enabled software IH ring for Vega
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20201102113353.1422-1-christian.koenig@amd.com>
 <20201102113353.1422-2-christian.koenig@amd.com>
 <CADnq5_PfY=f9gC6pEu-xzO_Z-Z1ggnW5UrR56oh9e4z96MYNBA@mail.gmail.com>
 <29159f4d-e769-193c-b304-d21693519be1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <87eea327-ede5-054b-e8da-c8b5c7ba11e9@gmail.com>
Date: Mon, 2 Nov 2020 20:58:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <29159f4d-e769-193c-b304-d21693519be1@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMTEuMjAgdW0gMTk6NTkgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIwLTEx
LTAyIHVtIDE6NTMgcC5tLiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPj4gT24gTW9uLCBOb3YgMiwg
MjAyMCBhdCA2OjM0IEFNIENocmlzdGlhbiBLw7ZuaWcKPj4gPGNrb2VuaWcubGVpY2h0enVtZXJr
ZW5AZ21haWwuY29tPiB3cm90ZToKPj4+IFNlZW1zIGxpa2Ugd2Ugd29uJ3QgZ2V0IHRoZSBoYXJk
d2FyZSBJSDEvMiByaW5ncyBvbiBWZWdhMjAgd29ya2luZy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+PiAtLS0KPj4+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgfCA3ICsrKysrKysKPj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCj4+PiBpbmRleCA0MDdjNjA5M2MyZWMuLmNlZjYxZGQ0NmEz
NyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5j
Cj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYwo+Pj4gQEAg
LTkxLDYgKzkxLDkgQEAgc3RhdGljIHZvaWQgdmVnYTEwX2loX2VuYWJsZV9pbnRlcnJ1cHRzKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gICAgICAgICAgICAgICAgICB9Cj4+PiAgICAg
ICAgICAgICAgICAgIGFkZXYtPmlycS5paDIuZW5hYmxlZCA9IHRydWU7Cj4+PiAgICAgICAgICB9
Cj4+PiArCj4+PiArICAgICAgIGlmIChhZGV2LT5pcnEuaWhfc29mdC5yaW5nX3NpemUpCj4+PiAr
ICAgICAgICAgICAgICAgYWRldi0+aXJxLmloX3NvZnQuZW5hYmxlZCA9IHRydWU7Cj4+PiAgIH0K
Pj4+Cj4+PiAgIC8qKgo+Pj4gQEAgLTYwNiw2ICs2MDksMTAgQEAgc3RhdGljIGludCB2ZWdhMTBf
aWhfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4+PiAgICAgICAgICBhZGV2LT5pcnEuaWgyLnVzZV9k
b29yYmVsbCA9IHRydWU7Cj4+PiAgICAgICAgICBhZGV2LT5pcnEuaWgyLmRvb3JiZWxsX2luZGV4
ID0gKGFkZXYtPmRvb3JiZWxsX2luZGV4LmloICsgMikgPDwgMTsKPj4+Cj4+PiArICAgICAgIHIg
PSBhbWRncHVfaWhfcmluZ19pbml0KGFkZXYsICZhZGV2LT5pcnEuaWhfc29mdCwgUEFHRV9TSVpF
LCB0cnVlKTsKPj4+ICsgICAgICAgaWYgKHIpCj4+PiArICAgICAgICAgICAgICAgcmV0dXJuIHI7
Cj4+PiArCj4+IFNob3VsZCB3ZSBvbmx5IGVuYWJsZSB0aGlzIG9uIHZlZ2EyMD8KPiBJdCBhZmZl
Y3RzIG90aGVyIEdQVXMgYXMgd2VsbC4gSW5jbHVkaW5nIHByb2JhYmx5IHNvbWUgTmF2aSBHUFVz
LiBXZSdsbAo+IHByb2JhYmx5IG5lZWQgYSBzaW1pbGFyIGNoYW5nZSBpbiBuYXZpMTBfaWguYy4K
Pgo+IElzIHRoZXJlIGEgd2F5IHRvIHJlbGlhYmx5IGRldGVjdCB3aGV0aGVyIElIIHJlZGlyZWN0
aW9uIHdvcmtzLiBPciBkbyB3ZQo+IG5lZWQgdG8gYWxsb2NhdGUgdGhlIHNvZnQgSUggcmluZyB1
bmNvbmRpdGlvbmFsbHk/CgpXZSBjYW4gYWxsb2NhdGUgaXQgdW5jb25kaXRpb25hbGx5IG9uIFZl
Z2EgYW5kIE5hdmksIGl0J3MganVzdCBhIHNpbmdsZSAKcGFnZSByaW5nIGJ1ZmZlciB3aGljaCBp
cyBvbmx5IHVzZWQgd2hlbiBuZWVkZWQuCgpXaGF0IHdvcnJpZXMgbWUgbW9yZSBpcyB0aGF0IHRl
c3Rpbmcgc2hvd3MgdGhhdCBJIGNhbid0IGV2ZW4gZW5hYmxlIElWIAp0cmFjaW5nIG9yIHJpc2sg
dGhhdCBhIHNpbmdsZSBDUFUgYmVjb21lcyBzbyBidXN5IHdpdGggcHJvY2Vzc2luZyBJVnMgCnRo
YXQgSSBnZXQgInN0dWNrIGZvciAyMyBzZWNvbmRzIiB3YXJuaW5ncy4KCldlICpyZWFsbHkqIG5l
ZWQgdGhlIGhhcmR3YXJlIHRvIHdvcmsgY29ycmVjdGx5IGVpdGhlciBieSB1c2luZyB0aGUgQ0FN
IApmb3IgZmlsdGVyaW5nIHBhZ2UgZmF1bHRzIG9yIGJ5IHJlZGlyZWN0aW5nIHRoZW0gdG8gdGhl
IGRpZmZlcmVudCBJSCByaW5nLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFJlZ2FyZHMsCj4g
IMKgIEZlbGl4Cj4KPgo+PiBBbGV4Cj4+Cj4+Cj4+PiAgICAgICAgICByID0gYW1kZ3B1X2lycV9p
bml0KGFkZXYpOwo+Pj4KPj4+ICAgICAgICAgIHJldHVybiByOwo+Pj4gLS0KPj4+IDIuMjUuMQo+
Pj4KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Pj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
