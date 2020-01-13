Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1228BC33CAD
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 12:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E53207FD
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 12:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQwGwewI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E53207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DD388E6B;
	Mon, 13 Jan 2020 12:10:05 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243896E083
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 12:10:04 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id b19so9357023wmj.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 04:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fNsRwaZTW9xfcLn5GsA4YhuFc+wJkIHvkyt9nQU7/bg=;
 b=JQwGwewIaIIm6rRbupKK5dO9XXu27HtRXj1VULZ5GFsRrdK7gDeyvFW/MykxTOG5Z+
 QP9zvOIABKbihZJl/8a72QHNsgQrooVdsihRYL/l6pSIwaHut8SICF4+nmC8lnXrsCQK
 XJ2VGk0TWOu2IHWyfKCpkCDQ5gDjSrXkm6oYs+BFssmktC1FWC87NJywNexPun/uZ/J6
 kjAj5ugXVDTTV0Ed595CzS67Qnp8MedLZJO0AVW9dSB3MjEA8dRbp9W/70ju2Rs5vN64
 kyLhC8XuAnf7jwV7n97ZRVR5G26unaA6VtJ/eUMaZrQ6UHNKVdwDhOFHMt1bjDH1Dtxa
 VbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fNsRwaZTW9xfcLn5GsA4YhuFc+wJkIHvkyt9nQU7/bg=;
 b=mHLbS6808WsYvz8Qs8Bx03UCnHyIy+OrSYgG1KVBhszN9pZSw4dOD0NSDbBGSma0SF
 LJ+kTdRk28qKI7hEcDjtNdob9iPXOQLk6F4NyfvtlorpvnamSGwGzcw2z9gQYjCb90zr
 vS1BpKNz4HCyQENSvUY6qxuam9+iqt8NqKje/+JTAy1NPwg84bZIy5qdCR0hH0q0DHUp
 PPyduh1ZwiqFLo8kQM6+2pdHLXVZ0QH2CbQT6aAPBPYzEVPv9BMRu5yuFpjBzYNEC3He
 l13TbaxijpfCOmk//vlltd5Am0CrvJPEC9/dGadGi3+qPgg+96hsPfFEUf2tjlQz3lW2
 TDSg==
X-Gm-Message-State: APjAAAWLZDPog+Lm/dnr33NDUqJLj1+GQcyywUOT2NMubLczcN0JiUhQ
 hUA9Zqb+/VXGGAheWf6hWOxlAbV7
X-Google-Smtp-Source: APXvYqxlb+Ugt/f+5ODPZ5NxRxasZl+a9Le8nB1tG44fwEQFGkwWj+sfIzh5r/h+GsapCFO1I5WAOA==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr18957377wmc.119.1578917402357; 
 Mon, 13 Jan 2020 04:10:02 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id c195sm14889656wmd.45.2020.01.13.04.10.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jan 2020 04:10:01 -0800 (PST)
Subject: Re: [PATCH 1/7] drm/amdgpu: Avoid reclaim fs while eviction lock
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200111183938.126310-1-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <50bf87cb-dd72-2926-47ff-6033687903b8@gmail.com>
Date: Mon, 13 Jan 2020 13:10:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200111183938.126310-1-alex.sierra@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMDEuMjAgdW0gMTk6Mzkgc2NocmllYiBBbGV4IFNpZXJyYToKPiBbV2h5XQo+IEF2b2lk
IHJlY2xhaW0gZmlsZXN5c3RlbSB3aGlsZSBldmljdGlvbiBsb2NrIGlzIGhlbGQgY2FsbGVkIGZy
b20KPiBNTVUgbm90aWZpZXIuCj4KPiBbSG93XQo+IFNldHRpbmcgUEZfTUVNQUxMT0NfTk9GUyBm
bGFncyB3aGlsZSBldmljdGlvbiBtdXRleCBpcyBsb2NrZWQuCj4gVXNpbmcgbWVtYWxsb2Nfbm9m
c19zYXZlIC8gbWVtYWxsb2Nfbm9mc19yZXN0b3JlIEFQSS4KPgo+IENoYW5nZS1JZDogSTU1MzFj
OTMzNzgzNmU3ZDRhNDMwZGYzZjE2ZGNjODI4ODhlODAxOGMKPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNDAgKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIHwgIDYgKysrLQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCBiOTk5YjY3ZmY1N2EuLmQ2YWJh
NGY5ZGY3NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAg
LTgyLDYgKzgyLDMyIEBAIHN0cnVjdCBhbWRncHVfcHJ0X2NiIHsKPiAgIAlzdHJ1Y3QgZG1hX2Zl
bmNlX2NiIGNiOwo+ICAgfTsKPiAgIAo+ICsvKioKPiArICogdm0gZXZpY3Rpb25fbG9jayBjYW4g
YmUgdGFrZW4gaW4gTU1VIG5vdGlmaWVycy4gTWFrZSBzdXJlIG5vIHJlY2xhaW0tRlMKPiArICog
aGFwcGVucyB3aGlsZSBob2xkaW5nIHRoaXMgbG9jayBhbnl3aGVyZSB0byBwcmV2ZW50IGRlYWRs
b2NrcyB3aGVuCj4gKyAqIGFuIE1NVSBub3RpZmllciBydW5zIGluIHJlY2xhaW0tRlMgY29udGV4
dC4KPiArICovCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhbWRncHVfdm1fZXZpY3Rpb25fbG9jayhz
dHJ1Y3QgYW1kZ3B1X3ZtICp2bSkKPiArewo+ICsJbXV0ZXhfbG9jaygmdm0tPmV2aWN0aW9uX2xv
Y2spOwo+ICsJdm0tPnNhdmVkX2ZsYWdzID0gbWVtYWxsb2Nfbm9mc19zYXZlKCk7Cj4gK30KPiAr
Cj4gK3N0YXRpYyBpbmxpbmUgaW50IGFtZGdwdV92bV9ldmljdGlvbl90cnlsb2NrKHN0cnVjdCBh
bWRncHVfdm0gKnZtKQo+ICt7Cj4gKwlpZiAobXV0ZXhfdHJ5bG9jaygmdm0tPmV2aWN0aW9uX2xv
Y2spKSB7Cj4gKwkJdm0tPnNhdmVkX2ZsYWdzID0gbWVtYWxsb2Nfbm9mc19zYXZlKCk7Cj4gKwkJ
cmV0dXJuIDE7Cj4gKwl9Cj4gKwlyZXR1cm4gMDsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSB2
b2lkIGFtZGdwdV92bV9ldmljdGlvbl91bmxvY2soc3RydWN0IGFtZGdwdV92bSAqdm0pCj4gK3sK
PiArCW1lbWFsbG9jX25vZnNfcmVzdG9yZSh2bS0+c2F2ZWRfZmxhZ3MpOwo+ICsJbXV0ZXhfdW5s
b2NrKCZ2bS0+ZXZpY3Rpb25fbG9jayk7Cj4gK30KPiArCj4gICAvKioKPiAgICAqIGFtZGdwdV92
bV9sZXZlbF9zaGlmdCAtIHJldHVybiB0aGUgYWRkciBzaGlmdCBmb3IgZWFjaCBsZXZlbAo+ICAg
ICoKPiBAQCAtNjc4LDkgKzcwNCw5IEBAIGludCBhbWRncHVfdm1fdmFsaWRhdGVfcHRfYm9zKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKPiAgIAkJfQo+
ICAgCX0KPiAgIAo+IC0JbXV0ZXhfbG9jaygmdm0tPmV2aWN0aW9uX2xvY2spOwo+ICsJYW1kZ3B1
X3ZtX2V2aWN0aW9uX2xvY2sodm0pOwo+ICAgCXZtLT5ldmljdGluZyA9IGZhbHNlOwo+IC0JbXV0
ZXhfdW5sb2NrKCZ2bS0+ZXZpY3Rpb25fbG9jayk7Cj4gKwlhbWRncHVfdm1fZXZpY3Rpb25fdW5s
b2NrKHZtKTsKPiAgIAo+ICAgCXJldHVybiAwOwo+ICAgfQo+IEBAIC0xNTU5LDcgKzE1ODUsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKPiAgIAlpZiAoIShmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQpKQo+ICAgCQlv
d25lciA9IEFNREdQVV9GRU5DRV9PV05FUl9LRkQ7Cj4gICAKPiAtCW11dGV4X2xvY2soJnZtLT5l
dmljdGlvbl9sb2NrKTsKPiArCWFtZGdwdV92bV9ldmljdGlvbl9sb2NrKHZtKTsKPiAgIAlpZiAo
dm0tPmV2aWN0aW5nKSB7Cj4gICAJCXIgPSAtRUJVU1k7Cj4gICAJCWdvdG8gZXJyb3JfdW5sb2Nr
Owo+IEBAIC0xNTc2LDcgKzE2MDIsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVf
bWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAlyID0gdm0tPnVwZGF0ZV9m
dW5jcy0+Y29tbWl0KCZwYXJhbXMsIGZlbmNlKTsKPiAgIAo+ICAgZXJyb3JfdW5sb2NrOgo+IC0J
bXV0ZXhfdW5sb2NrKCZ2bS0+ZXZpY3Rpb25fbG9jayk7Cj4gKwlhbWRncHVfdm1fZXZpY3Rpb25f
dW5sb2NrKHZtKTsKPiAgIAlyZXR1cm4gcjsKPiAgIH0KPiAgIAo+IEBAIC0yNTM3LDE4ICsyNTYz
LDE4IEBAIGJvb2wgYW1kZ3B1X3ZtX2V2aWN0YWJsZShzdHJ1Y3QgYW1kZ3B1X2JvICpibykKPiAg
IAkJcmV0dXJuIGZhbHNlOwo+ICAgCj4gICAJLyogVHJ5IHRvIGJsb2NrIG9uZ29pbmcgdXBkYXRl
cyAqLwo+IC0JaWYgKCFtdXRleF90cnlsb2NrKCZib19iYXNlLT52bS0+ZXZpY3Rpb25fbG9jaykp
Cj4gKwlpZiAoIWFtZGdwdV92bV9ldmljdGlvbl90cnlsb2NrKGJvX2Jhc2UtPnZtKSkKPiAgIAkJ
cmV0dXJuIGZhbHNlOwo+ICAgCj4gICAJLyogRG9uJ3QgZXZpY3QgVk0gcGFnZSB0YWJsZXMgd2hp
bGUgdGhleSBhcmUgdXBkYXRlZCAqLwo+ICAgCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGJv
X2Jhc2UtPnZtLT5sYXN0X2RpcmVjdCkgfHwKPiAgIAkgICAgIWRtYV9mZW5jZV9pc19zaWduYWxl
ZChib19iYXNlLT52bS0+bGFzdF9kZWxheWVkKSkgewo+IC0JCW11dGV4X3VubG9jaygmYm9fYmFz
ZS0+dm0tPmV2aWN0aW9uX2xvY2spOwo+ICsJCWFtZGdwdV92bV9ldmljdGlvbl91bmxvY2soYm9f
YmFzZS0+dm0pOwo+ICAgCQlyZXR1cm4gZmFsc2U7Cj4gICAJfQo+ICAgCj4gICAJYm9fYmFzZS0+
dm0tPmV2aWN0aW5nID0gdHJ1ZTsKPiAtCW11dGV4X3VubG9jaygmYm9fYmFzZS0+dm0tPmV2aWN0
aW9uX2xvY2spOwo+ICsJYW1kZ3B1X3ZtX2V2aWN0aW9uX3VubG9jayhib19iYXNlLT52bSk7Cj4g
ICAJcmV0dXJuIHRydWU7Cj4gICB9Cj4gICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uaAo+IGluZGV4IDEwMDU0N2YwOTRmZi4uYzIxYTM2YmViYzBjIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKPiBAQCAtMzAsNiArMzAsNyBAQAo+ICAgI2lu
Y2x1ZGUgPGRybS9ncHVfc2NoZWR1bGVyLmg+Cj4gICAjaW5jbHVkZSA8ZHJtL2RybV9maWxlLmg+
Cj4gICAjaW5jbHVkZSA8ZHJtL3R0bS90dG1fYm9fZHJpdmVyLmg+Cj4gKyNpbmNsdWRlIDxsaW51
eC9zY2hlZC9tbS5oPgo+ICAgCj4gICAjaW5jbHVkZSAiYW1kZ3B1X3N5bmMuaCIKPiAgICNpbmNs
dWRlICJhbWRncHVfcmluZy5oIgo+IEBAIC0yNDIsOSArMjQzLDEyIEBAIHN0cnVjdCBhbWRncHVf
dm0gewo+ICAgCS8qIHRyZWUgb2YgdmlydHVhbCBhZGRyZXNzZXMgbWFwcGVkICovCj4gICAJc3Ry
dWN0IHJiX3Jvb3RfY2FjaGVkCXZhOwo+ICAgCj4gLQkvKiBMb2NrIHRvIHByZXZlbnQgZXZpY3Rp
b24gd2hpbGUgd2UgYXJlIHVwZGF0aW5nIHBhZ2UgdGFibGVzICovCj4gKwkvKiBMb2NrIHRvIHBy
ZXZlbnQgZXZpY3Rpb24gd2hpbGUgd2UgYXJlIHVwZGF0aW5nIHBhZ2UgdGFibGVzCj4gKwkgKiB1
c2Ugdm1fZXZpY3Rpb25fbG9jay91bmxvY2sodm0pCj4gKwkgKi8KPiAgIAlzdHJ1Y3QgbXV0ZXgJ
CWV2aWN0aW9uX2xvY2s7Cj4gICAJYm9vbAkJCWV2aWN0aW5nOwo+ICsJdW5zaWduZWQgaW50CQlz
YXZlZF9mbGFnczsKPiAgIAo+ICAgCS8qIEJPcyB3aG8gbmVlZHMgYSB2YWxpZGF0aW9uICovCj4g
ICAJc3RydWN0IGxpc3RfaGVhZAlldmljdGVkOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
