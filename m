Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA0C47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 10:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187BF60FEF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 10:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187BF60FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8CC96E1DE;
	Mon, 31 May 2021 10:32:36 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F0E6E1DE;
 Mon, 31 May 2021 10:32:36 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id v5so14362171ljg.12;
 Mon, 31 May 2021 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=usO9+/gM4Zo9jeFsuuS4Ase+VqK8oMXSDPbQWD0BH1w=;
 b=XwNwPBrSXKB9gX0XCTa3nwqkyw+5/qHAMgz3KXUors7ZL1z6gPgD9vKKpVWtof3Aoq
 n4bdgXVkVFXgkxUGBUbB/u7AWWdDbbosvFfAU4o3s/ZVqjt+zGU6MHfg9g8Gh3BsZXVY
 wW4IEh7MRHIOO09XpEm+04Vc+qsOyd/WsAYYpj9+PZm4XnhetnyLMskHqbzb3qj/HCqy
 tV4bJiEHIm1OvR24COPmoj3F2xPBHx9WlblS9YUL04dbQRxXv5V8xxHqjdsqqEgMci+8
 8zjm6achdVxcwOGx08gPyYbe/znHksWCqprF3gn+3MnOr98JO2OA1BGL9LMY9QbcwawY
 DO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=usO9+/gM4Zo9jeFsuuS4Ase+VqK8oMXSDPbQWD0BH1w=;
 b=UDEfU5WmErzf2cDS5Dm4oc13vazdPXXQKyuKnMUmOYu72loNzpJ3jVNs968hoY7FE+
 /pBcpFKPO1xpM8dB4RoVGNDQvKXkGbAN830586zINTUxk2biXlYngbD4u5uSDTtw2cwU
 HudkUzssor3hfWvqYp9Vo0wl+OX3WQ3K+4uhOLFn6/Bz8SCwkB8FQ/B2wsn1Rrjp6UgN
 C1SjlUQPNFHo3TvaVvsCP7qWcY8+pYS4kdfa4T2PUIGjgVVi5ISK8qq3NUDpVynI9p6y
 dWyZLJtHIsbVJRCNexh0+om0muQONDv3B8X+XRSfjAwEcfneBCVrjK/mxSWRMFD7/v9q
 SLog==
X-Gm-Message-State: AOAM530lxdaH+Rsag0c7PwGZyM6rHB27Zg22atpgHgpbjfpL6UqwRYJc
 6YCNBwAoTGXf8d6CakI5zYY=
X-Google-Smtp-Source: ABdhPJwW7RCDsAOWoNOxEfbaI5cD1RW+UpupiDrRVHG/n9wESVlsAso4aDH+TORmmRT62MQgDxNZhw==
X-Received: by 2002:a05:651c:105a:: with SMTP id
 x26mr16157353ljm.440.1622457154572; 
 Mon, 31 May 2021 03:32:34 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:b94:4956:bad4:7c81?
 ([2a02:908:1252:fb60:b94:4956:bad4:7c81])
 by smtp.gmail.com with ESMTPSA id j1sm1298342lfm.55.2021.05.31.03.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 03:32:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/ttm: cleanup and add TTM_PL_FLAG_TEMPORARY
To: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>,
 "Yu, Lang" <Lang.Yu@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210527013051.4302-1-Lang.Yu@amd.com>
 <DM6PR12MB4250B79297F587313D7645EBFB3F9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <14d7f047-cf6d-c84a-14ff-3f1d833a770b@shipmail.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <883bd629-e3ad-07a2-8952-994f42cb02be@gmail.com>
Date: Mon, 31 May 2021 12:32:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <14d7f047-cf6d-c84a-14ff-3f1d833a770b@shipmail.org>
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzEuMDUuMjEgdW0gMTE6NTIgc2NocmllYiBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpOgo+
IEhpLCBMYW5nLAo+Cj4gT24gNS8zMS8yMSAxMDoxOSBBTSwgWXUsIExhbmcgd3JvdGU6Cj4+IFtQ
dWJsaWNdCj4+Cj4+PiBIaSwKPj4+IE9uIDUvMjcvMjEgMzozMCBBTSwgTGFuZyBZdSB3cm90ZToK
Pj4+PiBNYWtlIFRUTV9QTF9GTEFHXyogc3RhcnQgZnJvbSB6ZXJvIGFuZCBhZGQKPj4+PiBUVE1f
UExfRkxBR19URU1QT1JBUlkgZmxhZyBmb3IgdGVtcG9yYXJ5Cj4+Pj4gR1RUIGFsbG9jYXRpb24g
dXNlLgo+Pj4gR1RUIGlzIGEgZHJpdmVyIHByaXZhdGUgYWNyb255bSwgcmlnaHQ/IEFuZCBpdCBk
b2Vzbid0IGxvb2sgbGlrZQo+Pj4gVFRNX1BMX0ZMQUdfVEVNUE9SQVJZIHdpbGwgYmUgdXNlZCBp
biBjb3JlIFRUTSwgc28gc2hvdWxkIHdlIGluc3RlYWQgCj4+PiBzZXQKPj4+IGFzaWRlIGEgbWFz
ayBpbiB0aGUgUEwgZmxhZyBmb3IgZHJpdmVyLXByaXZhdGUgdXNlPwo+PiBIaSBUaG9tYXMsCj4+
Cj4+IFRoYW5rcyBmb3IgeW91ciBjb21tZW50cyBhbmQgYWR2aWNlLCBHVFQgbWVhbnMgR3JhcGhp
Y3MgVHJhbnNsYXRpb24gCj4+IFRhYmxlIGhlcmUsIHNlZW1zCj4+IGEgZ2VuZXJhbCBhY3Jvbnlt
LiBUVE1fUExfRkxBR19URU1QT1JBUlkgbWF5IGFsc28gYmUgdXNlZCBieSBvdGhlciAKPj4gZHJp
dmVzLgo+PiBJIGhhdmUgbWFkZSBvdGhlciBwYXRjaGVzIGZvciB0aGlzLiBQbGVhc2UgaGVscCBy
ZXZpZXcuCj4+Cj4+IFJlZ2FyZHMsCj4+IExhbmcKPj4KPiBNeSBwb2ludCB3YXMgcmVhbGx5IHRo
YXQgdGhlIGZsYWcgbmFtaW5nIGFuZCBkb2N1bWVudGF0aW9uIHNob3VsZCAKPiByZWZsZWN0IHdo
YXQgY29yZSB0dG0gaXMgZG9pbmcgd2l0aCB0aGF0IGZsYWcuIElmIHRoZXJlIGlzIG5vIHNwZWNp
ZmljIAo+IGNvcmUgVFRNIHVzYWdlLCBJTU8gd2Ugc2hvdWxkIG1vdmUgaXQgdG8gYSBkcml2ZXIg
c3BlY2lmaWMgZmxhZyB0byAKPiBhdm9pZCBmdXR1cmUgY29uZnVzaW9uLiBJbiBwYXJ0aWN1bGFy
IGEgd3JpdGVyIG9mIGEgZ2VuZXJpYyBUVE0gCj4gcmVzb3VyY2UgbWFuYWdlciBzaG91bGQgYmUg
YWJsZSB0byBrbm93IHdpdGhvdXQgbG9va2luZyBhdCBhbiBvbGQgCj4gY29tbWl0IG1lc3NhZ2Ug
d2hhdCB0aGUgcGxhY2VtZW50IGZsYWcgaXMgaW50ZW5kZWQgZm9yLgo+Cj4gU28gaGVyZSB3ZSBh
ZGQgYSBmbGFnIHdoZXJlIGNvcmUgVFRNIGZvcmNlcyBhIGJvIG1vdmUgb24gdmFsaWRhdGUgYW5k
IAo+IHRoYXQncyBpdC4gQW5kIHRoYXQgYXBwZWFycyB0byBiZSBob3cgaXQncyB1c2VkIHdoZW4g
YW4gYW1kZ3B1IGJvIGlzIAo+IGV2aWN0ZWQgdG8gR1RULCAoYnR3IHNob3VsZCBpdCBiZSBhY2Nv
dW50ZWQgaW4gdGhpcyBzaXR1YXRpb24/KQo+Cj4gVGhlIG90aGVyIHVzZSBpcyB0byBmb3JjZSB0
aGUgYW1kZ3B1IGRyaXZlciB0byB0ZW1wb3JhcmlseSBhY2NlcHQgaXQgCj4gaW50byBHVFQgd2hl
biB0aGVyZSBpcyBhIGxhY2sgb2Ygc3BhY2UsIGFuZCBJTUhPIHRoYXQncyBhIGRyaXZlciAKPiBz
cGVjaWZpYyB1c2UgYW5kIHdlIHNob3VsZCBhbGxvY2F0ZSBhIG1hc2sgZm9yIGRyaXZlciBzcGVj
aWZpYyBmbGFncyAKPiBmb3IgdGhhdC4KPgo+IFNvIHNob3VsZG4ndCB0aGlzIGJlIHR3byBmbGFn
cywgcmVhbGx5PwoKV2VsbCBvbmUgZmxhZyBtYWtlcyBzZW5zZSBmb3IgdGhlIHVzZSBjYXNlIGF0
IGhhbmQgdGhhdCBkcml2ZXJzIHdhbnQgdG8gCnNpZ25hbCB0byBUVE0gdGhhdCBhbiBhbGxvY2F0
aW9uIGlzIG9ubHkgdGVtcG9yYXJ5IGFuZCBub3QgY29uc2lkZXJlZCB2YWxpZC4KClRoYXQgd2Ug
dGhlbiB1c2UgdGhpcyBmbGFnIHRvIGltcGxlbWVudCB0ZW1wb3JhcnkgR1RUIGFsbG9jYXRpb25z
IHRvIAphdm9pZCBwcm9ibGVtcyBkdXJpbmcgZXZpY3Rpb24gaXMganVzdCBleHRlbmRpbmcgdGhh
dCB1c2UgY2FzZS4KCkNocmlzdGlhbi4KCj4KPiBUVE1fUExfRkxBR19GT1JDRV9NT1ZFCj4KPiBh
bmQKPgo+IEFNREdQVV9QTF9GTEFHX1RFTVBPUkFSWQo+Cj4gVGhhbmtzLAo+Cj4gL1Rob21hcwo+
Cj4+PiBUaG9tYXMKPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+PiBGcm9tOiBZdSwg
TGFuZyA8TGFuZy5ZdUBhbWQuY29tPgo+Pj4gU2VudDogVGh1cnNkYXksIE1heSAyNywgMjAyMSA5
OjMxIEFNCj4+PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IENjOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPjsgSHVhbmcsIFJheQo+Pj4gPFJheS5IdWFuZ0BhbWQuY29tPjsgRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsKPj4+IFl1LCBMYW5n
IDxMYW5nLll1QGFtZC5jb20+Cj4+PiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkcm0vdHRtOiBjbGVh
bnVwIGFuZCBhZGQgVFRNX1BMX0ZMQUdfVEVNUE9SQVJZCj4+Pgo+Pj4gTWFrZSBUVE1fUExfRkxB
R18qIHN0YXJ0IGZyb20gemVybyBhbmQgYWRkIFRUTV9QTF9GTEFHX1RFTVBPUkFSWSBmbGFnCj4+
PiBmb3IgdGVtcG9yYXJ5IEdUVCBhbGxvY2F0aW9uIHVzZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5
OiBMYW5nIFl1IDxMYW5nLll1QGFtZC5jb20+Cj4+PiAtLS0KPj4+IGluY2x1ZGUvZHJtL3R0bS90
dG1fcGxhY2VtZW50LmggfCA1ICsrKy0tCj4+PiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS90dG0v
dHRtX3BsYWNlbWVudC5oCj4+PiBiL2luY2x1ZGUvZHJtL3R0bS90dG1fcGxhY2VtZW50LmggaW5k
ZXggYWE2YmE0ZDBjZjc4Li45ZjVjZmM3YzJkNWEgCj4+PiAxMDA2NDQKPj4+IC0tLSBhL2luY2x1
ZGUvZHJtL3R0bS90dG1fcGxhY2VtZW50LmgKPj4+ICsrKyBiL2luY2x1ZGUvZHJtL3R0bS90dG1f
cGxhY2VtZW50LmgKPj4+IEBAIC00Nyw4ICs0Nyw5IEBACj4+PiDCoCAqIHRvcCBvZiB0aGUgbWVt
b3J5IGFyZWEsIGluc3RlYWQgb2YgdGhlIGJvdHRvbS4KPj4+IMKgICovCj4+Pgo+Pj4gLSNkZWZp
bmUgVFRNX1BMX0ZMQUdfQ09OVElHVU9VU8KgICgxIDw8IDE5KQo+Pj4gLSNkZWZpbmUgVFRNX1BM
X0ZMQUdfVE9QRE9XTsKgwqDCoMKgICgxIDw8IDIyKQo+Pj4gKyNkZWZpbmUgVFRNX1BMX0ZMQUdf
Q09OVElHVU9VU8KgICgxIDw8IDApCj4+PiArI2RlZmluZSBUVE1fUExfRkxBR19UT1BET1dOwqDC
oMKgwqAgKDEgPDwgMSkKPj4+ICsjZGVmaW5lIFRUTV9QTF9GTEFHX1RFTVBPUkFSWcKgwqAgKDEg
PDwgMikKPj4+Cj4+PiAvKioKPj4+IMKgICogc3RydWN0IHR0bV9wbGFjZQo+Pj4gLS0gCj4+PiAy
LjI1LjEKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
