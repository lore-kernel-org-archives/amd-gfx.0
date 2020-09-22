Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E3FC2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 12:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D6C2399A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 12:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCtHLV34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D6C2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C1D6E864;
	Tue, 22 Sep 2020 12:54:51 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FB56E864
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 12:54:49 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id nw23so22656579ejb.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 05:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aEUKq9lV44D1Nt8MNs59LCnOcxWItFm7Zxegm/J3rA8=;
 b=WCtHLV34hkvcOF+YgvmBRzmpRISXXqst6zA/vHblBICmvcpWpFi2Gb+72txgs86NP3
 ZJJtLXAtrnufaMHNMLRX3quL4rRCjbFCyzW5Alk4pm3HwMzE6ljCuJb4LI8moAd8r0YH
 DqFrzjQ3Z46Kt/icGy1BbdLcYFVQ1c28FjLqtGE41zrQfvtP5hOzpADOttZJ8b9az5Oq
 gjDHfGl1369Q3LLuU4sj0b/HoE20GfF+HSJUGGtyl5izmru7w5DS8AuECVL+Wma2TbsN
 4f5iwcfLqZxBpQBpgmSx9zyPA99/Ap65S4vQpQz3tCa1yAGqwzaRkCVozXHTb77k9KXz
 noAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=aEUKq9lV44D1Nt8MNs59LCnOcxWItFm7Zxegm/J3rA8=;
 b=QcOo1+UKn5fP4NWoHcfmOpiFtth6SXDWDReasJniVWnh9OK1T+X7q2yDKPjEnbhC4E
 CKzLgaVrReOb9RPihfgCY8y5aYxeQy/Xv2quuKk33JpmH6Sz6qdxPVv6VJ7MdmoLc974
 nWQB5Tcy1I+ziNG86fuGT65pNc1zA9T0qfuTx3RRyC40fdjqEIMoK6BO81A/NxIM3yvO
 rmHMdPFZTDxFcH682nfF+Ju0QPQY10yoVeB9LsgGeWCQC534qTFyjPkrcqE9iLmCo5VY
 oydazpGCOVCS2cKP184YFI8rw1qatoy1e94s4ROA6QONJJIrmLuIrd3Ew+/9+cH3HM7v
 5NcQ==
X-Gm-Message-State: AOAM533x2Vkwo42z5dpei6Dqmu5kLUd2UbG0xhvQ2m2BO2DeUdgDLr0e
 eM2N+Y8o7oNq7pPk5j5YDhs=
X-Google-Smtp-Source: ABdhPJwvaGE6UTxtUrCx64zMYJWYDREBYxOM8fMKbxYaQkRTTwoJ1z29/+ewJBL0PdyP6ey4empUTw==
X-Received: by 2002:a17:906:ce3b:: with SMTP id
 sd27mr4751241ejb.433.1600779288386; 
 Tue, 22 Sep 2020 05:54:48 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id r9sm10896441ejc.102.2020.09.22.05.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 05:54:47 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add uid info to process BO list
To: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200921191803.18549-1-madhav.chauhan@amd.com>
 <be158145-41b9-c319-8e46-cda88d5cb9c2@gmail.com>
 <BL0PR12MB2433A91BE80EF2D8DFAB85E09C3A0@BL0PR12MB2433.namprd12.prod.outlook.com>
 <9ebed42d-06f2-bbd6-f702-8e707ea1ac84@amd.com>
 <BL0PR12MB2433166825CCE596D7B2ACA69C3B0@BL0PR12MB2433.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <be1c3d53-e8a8-c6f4-48e1-96a36f2643f0@gmail.com>
Date: Tue, 22 Sep 2020 14:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BL0PR12MB2433166825CCE596D7B2ACA69C3B0@BL0PR12MB2433.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Surampalli,
 Kishore" <Kishore.Surampalli@amd.com>, "Patel, Mihir" <Mihir.Patel@amd.com>,
 "Saleem, Athar" <Athar.Saleem@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDkuMjAgdW0gMTI6Mzggc2NocmllYiBDaGF1aGFuLCBNYWRoYXY6Cj4gW0FNRCBQdWJs
aWMgVXNlXQo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBLb2VuaWcsIENo
cmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPgo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRl
bWJlciAyMiwgMjAyMCAxMjoxNSBQTQo+IFRvOiBDaGF1aGFuLCBNYWRoYXYgPE1hZGhhdi5DaGF1
aGFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBTdXJhbXBh
bGxpLCBLaXNob3JlIDxLaXNob3JlLlN1cmFtcGFsbGlAYW1kLmNvbT47IFBhdGVsLCBNaWhpciA8
TWloaXIuUGF0ZWxAYW1kLmNvbT47IFNoYXJtYSwgU2hhc2hhbmsgPFNoYXNoYW5rLlNoYXJtYUBh
bWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
U2FsZWVtLCBBdGhhciA8QXRoYXIuU2FsZWVtQGFtZC5jb20+Cj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZGdwdTogQWRkIHVpZCBpbmZvIHRvIHByb2Nlc3MgQk8gbGlzdAo+Cj4gQW0gMjEu
MDkuMjAgdW0gMjE6NTUgc2NocmllYiBDaGF1aGFuLCBNYWRoYXY6Cj4+IFtBTUQgUHVibGljIFVz
ZV0KPj4KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+Cj4+IFNlbnQ6IFR1ZXNkYXks
IFNlcHRlbWJlciAyMiwgMjAyMCAxMjo1NCBBTQo+PiBUbzogQ2hhdWhhbiwgTWFkaGF2IDxNYWRo
YXYuQ2hhdWhhbkBhbWQuY29tPjsKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4g
Q2M6IFN1cmFtcGFsbGksIEtpc2hvcmUgPEtpc2hvcmUuU3VyYW1wYWxsaUBhbWQuY29tPjsgUGF0
ZWwsIE1paGlyCj4+IDxNaWhpci5QYXRlbEBhbWQuY29tPjsgU2hhcm1hLCBTaGFzaGFuayA8U2hh
c2hhbmsuU2hhcm1hQGFtZC5jb20+Owo+PiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBTYWxlZW0sIEF0aGFyCj4+IDxBdGhhci5TYWxlZW1AYW1kLmNvbT4K
Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogQWRkIHVpZCBpbmZvIHRvIHByb2Nl
c3MgQk8gbGlzdAo+Pgo+PiBBbSAyMS4wOS4yMCB1bSAyMToxOCBzY2hyaWViIE1hZGhhdiBDaGF1
aGFuOgo+Pj4gVUlEIGlzIGhlbHBmdWwgd2hpbGUgZG9pbmcgYW5hbHlzaXMgb2YgQk8gYWxsb2Nh
dGVkIGJ5IGEgcHJvY2Vzcy4KPj4gTG9va3MgbGlrZSBhIGJpdCBvdmVya2lsbCB0byBtZSwgd2h5
IG5vdCBnZXQgdGhlIHVpZCBmcm9tIHRoZSBwcm9jZXNzIGluZm8/Cj4+Cj4+IE5vdCBzdXJlIGlm
IEkgZ290IHlvdXIgcG9pbnQgLCBidXQgdXNlZCB0aGUgc2ltaWxhciBtZXRob2QgaW1wbGVtZW50
ZWQKPj4gYXQgZHJtIGxldmVsIGluc2lkZSBkcm1fZGVidWdmcy5jLiBUaGFua3MKPiBHb29kIGFy
Z3VtZW50LCBidXQgSSdtIG5vdCBzdXJlIGlmIHdlIHNob3VsZCBkdXBsaWNhdGUgdGhhdCBoZXJl
LiBXaGF0IGRvIHlvdSBuZWVkIHRoaXMgZm9yPwo+Cj4gVGhhbmtzLCBXZSBuZWVkIGRldGFpbHMg
b2YgQk9zIGFsbG9jYXRlZCBieSBhIHByb2Nlc3MgYW5kIGFzc29jaWF0ZWQgVUlEIHNvIHRoYXQg
d2UgY2FuIGRvIG1lbW9yeSBwZXJmIGFuYWx5c2lzIHVzaW5nIHNvbWUgc2NyaXB0cwo+IFRvIGZp
bmQgdGhlIHRvcCBjb25zdW1lciBvZiBHUFUgbWVtb3J5IGFuZCBzZWUgaWYgdGhvc2UgYXBwbGlj
YXRpb24gY2FuIGJlIG9wdGltaXplZC4KPgo+IENsaWVudHMgaW5mb3JtYXRpb24gYXQgRFJNIGxl
dmVsIGRvZXNu4oCZdCBwcmludCBsaXN0IG9mIEJPIHBlciBwcm9jZXNzIGFuZCBzaW5jZSB0aGF0
IGlzIGhhbmRsZWQgYnkgYW1kZ3B1IGRyaXZlciBzcGVjaWZpYwo+IEZ1bmN0aW9ucy4gIFNvIGFs
bCB0aGUgQk8gbGlzdCBpbmZvcm1hdGlvbiBhdCBvbmUgcGxhY2UgaXMgcmVhbGx5IHVzZWZ1bCBh
bmQgbmVlZGVkIGJ5IG91ciBjdXN0b21lcnMgYXMgdmFyaW91cyBvdGhlciB2ZW5kb3JzCj4gQWxy
ZWFkeSBwcm92aWRlIHRoaXMuCgpXZWxsIHRoYXQgaXMgZXhhY3RseSB0aGUgZXhwbGFuYXRpb24g
SSBkaWRuJ3Qgd2FudCB0byBoZWFyIDooCgpTZWUgYm90aCB0aGUgZHJtIGNsaWVudCBsaXN0IGFz
IHdlbGwgYXMgdGhlIGFtZGdwdSBHRU0gaW5mbyBhcmUgb25seSAKZGVidWdmcyBmaWxlcyBhbmQg
b25seSBpbnRlbmRlZCBmb3IgcHJvdmlkaW5nIHNvbWUgaW5mb3JtYXRpb24gZm9yIApkZWJ1Z2dp
bmcgYW5kIGFyZSBub3QgMTAwJSByZWxpYWJsZSBmb3IgdGhlIHVzZSBjYXNlIHlvdSBoYXZlIGhl
cmUuCgpUaGUgZmlyc3QgcHJvYmxlbSBpcyB0aGF0IG9uIG1vZGVybiBpbnN0YWxsYXRpb25zIHRo
ZSBmaWxlIGRlc2NyaXB0b3IgaXMgCm9mdGVuIG9wZW5lZCBieSB0aGUgWCBzZXJ2ZXIgaW5zdGVh
ZCBvZiB0aGUgYXBwbGljYXRpb24uCgpTbyBmb3IgZXhhbXBsZSB5b3UgZW5kIHVwIHdpdGg6Cj4g
cGlkwqDCoMKgwqAgMTM4MiBjb21tYW5kIFhvcmc6Cj4gwqDCoMKgIDB4MDAwMDAwMDE6wqDCoMKg
wqDCoCAyMDk3MTUyIGJ5dGUgVlJBTSBAIDB4MDAwMDAwMmEwMAo+IMKgwqDCoCAweDAwMDAwMDAy
OsKgwqDCoMKgwqDCoMKgwqAgNDA5NiBieXRlwqAgR1RUIEAgMHgwMDAwMDAwNmM3Cj4gLi4uLgo+
IMKgwqDCoCAweDAwMDAwMDkwOsKgwqDCoMKgwqDCoCAyNjYyNDAgYnl0ZSBWUkFNIEAgMHgwMDAw
MDVlODAwCj4gwqDCoMKgIDB4MDAwMDAwOTE6wqDCoMKgwqDCoCAyMDk3MTUyIGJ5dGUgVlJBTSBA
IDB4MDAwMDA0ZTIwMAo+IMKgwqDCoCAweDAwMDAwMDkyOsKgwqDCoMKgwqAgMjA5NzE1MiBieXRl
wqAgR1RUCj4gcGlkwqDCoMKgwqAgMTM4MiBjb21tYW5kIFhvcmc6Cj4gwqDCoMKgIDB4MDAwMDAw
MDE6wqDCoMKgwqDCoCAyMDk3MTUyIGJ5dGUgVlJBTSBAIDB4MDAwMDAwMjgwMAo+IC4uLgoKVGhl
biBuZXh0IHByb2JsZW0gaXMgdGhhdCB0aGUgYW1kZ3B1X2dlbV9pbmZvIGlzIGNvbXBsZXRlbHkg
aW5hY2N1cmF0ZSAKcmVnYXJkaW5nIHRoZSB1c2VkIG1lbW9yeSBvZiBhbiBhcHBsaWNhdGlvbiwg
c2luY2UgdGhlIHNhbWUgQk8gaXMgCnNvbWV0aW1lcyBvcGVuZWQgbXVsdGlwbGUgdGltZXMuIFRo
YXQncyBhbHNvIHRoZSByZWFzb24gd2h5IHdlIGRvbid0IApwcm92aWRlIGEgdG90YWwgb2YgdGhl
IGNvbnN1bWVkIG1lbW9yeS4gSXQgYmFzaWNhbGx5IGp1c3QgaW5mb3JtcyB5b3UgCndoaWNoIGhh
bmRsZSBpcyB3aGF0LgoKVGhlbiBsYXN0IHRoZSBkZWJ1Z2ZzIGZpbGVzIGFyZSBub3QgYSBzdGFi
bGUgaW50ZXJmYWNlIGFuZCBub3QgbWVhbnQgdG8gCmJlIGNvbnN1bWVkIGJ5IHNjcmlwdHMgYW5k
L29yIGZyb250ZW5kIGFwcGxpY2F0aW9ucy4gWW91IHNob3VsZCBpbnN0ZWFkIAp1c2Ugc3lzZnMg
Zm9yIHRoaXMuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiBNYWRoYXYKPgo+
IENocmlzdGlhbi4KPgo+PiBSZWdhcmRzLAo+PiBNYWRoYXYKPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+
Pj4gU2lnbmVkLW9mZi1ieTogTWFkaGF2IENoYXVoYW4gPG1hZGhhdi5jaGF1aGFuQGFtZC5jb20+
Cj4+PiAtLS0KPj4+ICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMg
fCA2ICsrKysrLQo+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dlbS5jCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0u
Ywo+Pj4gaW5kZXggZjRjMmUyZTc1YjhmLi5jMTk4MjM0OWVjN2IgMTAwNjQ0Cj4+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4gQEAgLTg5Miw2ICs4OTIsNyBAQCBz
dGF0aWMgaW50IGFtZGdwdV9kZWJ1Z2ZzX2dlbV9pbmZvKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9p
ZCAqZGF0YSkKPj4+ICAgICAJc3RydWN0IGRybV9pbmZvX25vZGUgKm5vZGUgPSAoc3RydWN0IGRy
bV9pbmZvX25vZGUgKiltLT5wcml2YXRlOwo+Pj4gICAgIAlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2
ID0gbm9kZS0+bWlub3ItPmRldjsKPj4+ICAgICAJc3RydWN0IGRybV9maWxlICpmaWxlOwo+Pj4g
KwlrdWlkX3QgdWlkOwo+Pj4gICAgIAlpbnQgcjsKPj4+ICAgICAKPj4+ICAgICAJciA9IG11dGV4
X2xvY2tfaW50ZXJydXB0aWJsZSgmZGV2LT5maWxlbGlzdF9tdXRleCk7Cj4+PiBAQCAtOTA5LDcg
KzkxMCwxMCBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZWJ1Z2ZzX2dlbV9pbmZvKHN0cnVjdCBzZXFf
ZmlsZSAqbSwgdm9pZCAqZGF0YSkKPj4+ICAgICAJCSAqLwo+Pj4gICAgIAkJcmN1X3JlYWRfbG9j
aygpOwo+Pj4gICAgIAkJdGFzayA9IHBpZF90YXNrKGZpbGUtPnBpZCwgUElEVFlQRV9QSUQpOwo+
Pj4gLQkJc2VxX3ByaW50ZihtLCAicGlkICU4ZCBjb21tYW5kICVzOlxuIiwgcGlkX25yKGZpbGUt
PnBpZCksCj4+PiArCQl1aWQgPSB0YXNrID8gX190YXNrX2NyZWQodGFzayktPmV1aWQgOiBHTE9C
QUxfUk9PVF9VSUQ7Cj4+PiArCQlzZXFfcHJpbnRmKG0sICJwaWQgJThkIHVpZCAlNWQgY29tbWFu
ZCAlczpcbiIsCj4+PiArCQkJICAgcGlkX25yKGZpbGUtPnBpZCksCj4+PiArCQkJICAgZnJvbV9r
dWlkX211bmdlZChzZXFfdXNlcl9ucyhtKSwgdWlkKSwKPj4+ICAgICAJCQkgICB0YXNrID8gdGFz
ay0+Y29tbSA6ICI8dW5rbm93bj4iKTsKPj4+ICAgICAJCXJjdV9yZWFkX3VubG9jaygpOwo+Pj4g
ICAgIAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
