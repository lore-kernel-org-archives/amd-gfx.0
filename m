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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45444C47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 19:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB65E61260
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 19:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB65E61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 733B66E1EE;
	Mon, 31 May 2021 19:37:34 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747F36E1EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 19:37:33 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id l3so18168302ejc.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=JVVwEcZ0hzdreEtAj6zIjuNWdhOutvDU71B//bKhvVE=;
 b=hhi15UIyBMOdZ3Ob1/0ZWaZrZuFnYmYaF63nPrSSN6V6wOAc4pnNbOuFXG5HA/TTKx
 LKinHqYVn0XzcWwduxcM970zvICM2kfvRBeIQbV4d3JgxIn/eReeOCY4v2Bjr2+h8+SH
 klbs5Cmi1bghE3HyyiwbJEDLt4mdxsog/4Owfiyhpf/C5NGWvymL+XkdWraHZPaD9xOR
 dVpi2Yc0WMU75oOhJCCM3IMh6goObiIpG1wchBpBo1suSo+u8f5WR/gjdqbi0CdJ4K2D
 xzUIE6HExj9TXaETn8cEMDa8PNlWYVVrOdpjcRwx5b9wdUUcgSC0NIFkNZq7cRa9n3mp
 bi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JVVwEcZ0hzdreEtAj6zIjuNWdhOutvDU71B//bKhvVE=;
 b=CdY/GATkCM/A9Ka4nbOPoMvkIfAP64yZtZEYcHqR5Br3RYXGbQKD77hPAGG5qAAhgp
 A71uVo/+8HfocX7MJtpML2C5DNBsoIzguMaKFteawQC91Gu/VBA+vE2YwN763M5LJc0X
 vXIIlb330yFJ789CbFXM9jQdjyTsgMM3RrcIjRAyXknxIz+vY5Hf9plhMDO1lsZPfuzE
 hHI7DlAnc3ENQ9u0Tl3IHnTmG2RB7Jf9G+DsIUUnYb8aLTCM/se/Da8gNsa+6qEngT01
 iFYnnILDpuWfCV0qYmJ71YERhHC1438ioIey/JiK2iTw7o39aHtLZuWp1xE9ifRBxBcI
 BgvA==
X-Gm-Message-State: AOAM533qF7jB2vgowelLJN2xbMOVgBT+IBiLy7RkgKhEBxp/W5/37Gx+
 qitJTpx6ZGBfd9/TlgC09tB3KiXQ7sk=
X-Google-Smtp-Source: ABdhPJw5fUXM8IRBGvvFk5XqQW6lngGHlEAEQaNnAVO3UYg7EFGayGBFZ4jfD590M1mTOmp+VSwupw==
X-Received: by 2002:a17:906:b10e:: with SMTP id
 u14mr24096025ejy.546.1622489852117; 
 Mon, 31 May 2021 12:37:32 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:b94:4956:bad4:7c81?
 ([2a02:908:1252:fb60:b94:4956:bad4:7c81])
 by smtp.gmail.com with ESMTPSA id f18sm6336645ejz.119.2021.05.31.12.37.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 12:37:31 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix a bug on flag table_freed
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210529225101.459466-1-jinhuieric.huang@amd.com>
 <a048b42a-71c6-97c5-0e15-44cb3f3847a2@gmail.com>
 <0e44e35b-2acd-1954-47e4-b5a1f8c3dc49@amd.com>
 <ac9584d2-ef0a-3cae-631e-a0dd42c5555c@gmail.com>
 <bac6a9f2-046c-a0a4-69de-94499c589026@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <08e6d6d2-e8fa-1656-1ff3-aef25b724918@gmail.com>
Date: Mon, 31 May 2021 21:37:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bac6a9f2-046c-a0a4-69de-94499c589026@amd.com>
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

CgpBbSAzMS4wNS4yMSB1bSAxNjozMCBzY2hyaWViIEVyaWMgSHVhbmc6Cj4gT24gMjAyMS0wNS0z
MSAxMDowOCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pgo+Pgo+PiBBbSAzMC4wNS4y
MSB1bSAyMDoyOSBzY2hyaWViIEVyaWMgSHVhbmc6Cj4+Pgo+Pj4gT24gMjAyMS0wNS0zMCAxMjo1
NCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+Cj4+Pj4KPj4+PiBBbSAzMC4wNS4y
MSB1bSAwMDo1MSBzY2hyaWViIEVyaWMgSHVhbmc6Cj4+Pj4+IHRhYmxlX2ZyZWVkIHdpbGwgYmUg
YWx3YXlzIHRydWUgd2hlbiBtYXBwaW5nIGEgbWVtb3J5IHdpdGggc2l6ZQo+Pj4+PiBiaWdnZXIg
dGhhbiAyTUIuIFRoZSBwcm9ibGVtIGlzIHBhZ2UgdGFibGUncyBlbnRyaWVzIGFyZSBhbHdheXMK
Pj4+Pj4gZXhpc3RlZCwgYnV0IGV4aXN0aW5nIG1hcHBpbmcgZGVwZW5kcyBvbiBwYWdlIHRhbGJl
J3MgYm8sIHNvCj4+Pj4+IHVzaW5nIGEgY2hlY2sgb2YgcGFnZSB0YWJsZSdzIGJvIGV4aXN0ZWQg
d2lsbCByZXNvbHZlIHRoZSBpc3N1ZS4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBI
dWFuZyA8amluaHVpZXJpYy5odWFuZ0BhbWQuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gwqAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA0ICsrKy0KPj4+Pj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Pgo+Pj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgCj4+Pj4+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+Pj4gaW5kZXggMGRlZTJl
ODc5N2M3Li45NWI5NGM5NWFkYWMgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4+Pj4+IEBAIC0xNTgyLDkgKzE1ODIsMTEgQEAgc3RhdGljIGludCBh
bWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IAo+Pj4+PiBhbWRncHVfdm1fdXBkYXRlX3BhcmFt
cyAqcGFyYW1zLAo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogY29tcGxldGVs
eSBjb3ZlcmVkIGJ5IHRoZSByYW5nZSBhbmQgc28gCj4+Pj4+IHBvdGVudGlhbGx5IHN0aWxsIGlu
IHVzZS4KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB3aGlsZSAoY3Vyc29yLnBmbiA8IGZyYWdfc3RhcnQpIHsKPj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBNYWtlIHN1cmUgcHJldmlvdXMg
bWFwcGluZyBleGlzdGVkICovCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKGN1cnNvci5lbnRyeS0+YmFzZS5ibykKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHBhcmFtcy0+dGFibGVfZnJlZWQgPSB0cnVlOwo+Pj4+Cj4+Pj4gSW4g
Z2VuZXJhbCB0aGlzIGlzIHRoZSBjb3JyZWN0IGFwcHJvYWNoLCBidXQgSSB3b3VsZCBwdXNoIHRo
YXQgCj4+Pj4gZGVjaXNpb24gaW50byB0aGUgYW1kZ3B1X3ZtX2ZyZWVfcHRzKCkgZnVuY3Rpb24u
Cj4+Pj4KPj4+Pj4gYW1kZ3B1X3ZtX2ZyZWVfcHRzKGFkZXYsIHBhcmFtcy0+dm0sICZjdXJzb3Ip
Owo+Pj4+Cj4+Pj4gU28gdGhhdCB3ZSBoYXZlIGhlcmUgc29tZXRoaW5nIGxpa2UKPj4+Pgo+Pj4+
IHBhcmFtcy0+dGFibGVfZnJlZWQgfD0gYW1kZ3B1X3ZtX2ZyZWVfcHRzKC4uKTsKPj4+Pgo+Pj4g
VGhhbmsgeW91IGZvciB5b3VyIHJldmlldy4gSSB3YXMgdGhpbmtpbmcgcHV0IHRoZSBjaGVjayBp
bnRvIAo+Pj4gZnVuY3Rpb24gYW1kZ3B1X3ZtX2ZyZWVfcHRzKCkgc2luY2UgcHJldmlvdXMgcmV2
aWV3LCBpdCB3aWxsIGNoYW5nZSAKPj4+IHJldHVybnMgb2YgdHdvIGZ1bmN0aW9ucyBhbWRncHVf
dm1fZnJlZV9wdHMoKSBhbmQgCj4+PiBhbWRncHVfdm1fZnJlZV90YWJsZSgpLiBJZiB0aGUgcmV0
dXJucyBhcmUgbm90IHVzZWQgYnkgb3RoZXIgCj4+PiBmdW5jdGlvbnMsIGl0IHNlZW1zIG1ha2Ug
YSBzaW1wbGUgY2hhbmdlIGNvbXBsZXggZnJvbSBteSAKPj4+IHBlcnNwZWN0aXZlLiBDYW4geW91
IHNoYXJlIHRoZSByZWFzb24gb2YgeW91ciBzdWdnZXN0aW9uPwo+Pgo+PiBCZWNhdXNlIHlvdSBj
YW4gYWxzbyBvcHRpbWl6ZSB0aGUgYnVsa19tb3ZlYWJsZSBoYW5kbGluZyBpbiB0aGF0IAo+PiBm
dW5jdGlvbi4KPj4KPj4gRS5nLiBidWxrX21vdmVhYmxlIHNob3VsZCBvbmx5IGJlIHNldCB0byBm
YWxzZSB3aGVuIGEgdGFibGUgd2FzIGZyZWVkLgo+IE1ha2VzIHNlbnNlLiBJbiB0ZXJtcyBvZiBi
dWxrX21vdmVhYmxlLCBob3cgYWJvdXQgdGhpczoKPgo+IMKgwqDCoCDCoMKgwqAgwqDCoMKgIHdo
aWxlIChjdXJzb3IucGZuIDwgZnJhZ19zdGFydCkgewo+IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqDCoCAvKiBNYWtlIHN1cmUgcHJldmlvdXMgbWFwcGluZyBleGlzdGVkICovCj4gwqDCoMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIGlmIChjdXJzb3IuZW50cnktPmJhc2UuYm8pIHsKPiDCoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIHBhcmFtcy0+dGFibGVfZnJlZWQgPSB0cnVlOwo+
IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgYW1kZ3B1X3ZtX2ZyZWVfcHRzKGFk
ZXYsIHBhcmFtcy0+dm0sICZjdXJzb3IpOwo+IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCB9
Cj4gwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIGFtZGdwdV92bV9wdF9uZXh0KGFkZXYsICZj
dXJzb3IpOwo+IMKgwqDCoCDCoMKgwqAgwqDCoMKgIH0KPgo+IEl0IHNob3VsZCBzYXRpc2Z5IGJ1
bGtfbW92ZWFibGUgZmxhZywgYW5kIGFsc28gc2F2ZSBmcmVlaW5nIAo+IGN1cnNvci5lbnRyeS0+
ZW50cmllcywgd2hpY2ggYXJlIHByZS1hbGxvY2F0ZWQgaW4gdGhlIGJlZ2lubmluZyBvZiAKPiB0
aGlzIGZ1bmN0aW9uKGFtZGdwdV92bV91cGRhdGVfcHRlcyksIHRoZSBwcmUtYWxsb2NhdGlvbiBj
YW4gYmUgc2F2ZWQgCj4gaWYgbmV4dCBtYXBwaW5nIGlzIGEgc21hbGwgcGFnZSBhcyB3ZWxsLiBJ
dCBzZWVtcyB0aGUgbW9zdCBlZmZpY2llbnQgCj4gYXBwcm9hY2ggZm9yIG1lLgoKV29ya3MgZm9y
IG1lIGFzIHdlbGwsIEkgd291bGQganVzdCB1cGRhdGUgdGhlIGNvbW1lbnQgdG8gcmVhZCBzb21l
dGhpbmcgCmxpa2UgIk1ha2Ugc3VyZSBwcmV2aW91cyBtYXBwaW5nIGlzIGZyZWVkIi4KCkNocmlz
dGlhbi4KCj4KPiBSZWdhcmRzLAo+IEVyaWMKPj4KPj4gVGhlIG9ubHkgY2FzZSB3aGVyZSB0aGlz
IGRvZXNuJ3QgbWF0dGVyIGlzIHZtX2ZpbmkgYW5kIHdlIHJlYWxseSAKPj4gZG9uJ3QgY2FyZSBm
b3IgdGhhdCBzcGVjaWFsIG9uZS4KPj4KPj4gUmVnYXJkcywKPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4K
Pj4+IFJlZ2FyZHMsCj4+PiBFcmljCj4+Pj4KPj4+PiBSZWdhcmRzLAo+Pj4+IENocmlzdGlhbi4K
Pj4+Pgo+Pj4+PiBhbWRncHVfdm1fcHRfbmV4dChhZGV2LCAmY3Vyc29yKTsKPj4+Pj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXJhbXMtPnRhYmxlX2ZyZWVkID0gdHJ1ZTsKPj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+PiDCoCDCoMKgwqDCoMKgwqDCoMKg
wqAgfSBlbHNlIGlmIChmcmFnID49IHNoaWZ0KSB7Cj4+Pj4KPj4+Cj4+Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
