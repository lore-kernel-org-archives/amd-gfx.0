Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C910C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 12:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4D02067C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 12:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC3Wj92F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4D02067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678926E02F;
	Wed, 19 Aug 2020 12:58:11 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0779F6E02F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 12:58:10 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id 9so1989042wmj.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hju+RMdTcujQI1iZG4iOt3phY9wG9vAPXXn0PUAzHLg=;
 b=fC3Wj92F5MjyTYO5MChsUTlKc55dLtc3JjcfKpDBiHeIgJIOH5GsyB/VkCDEKeQtce
 LaCqtAW9aNyEQakx1g1RTwi6Tc8H0qV1MKPvZay0z27/hXTrGH4abPbWxZbelfzqbZW/
 nbGmFsT06nYO9YYybIefUp9IQGC+qOwkWzYZbVDRNRSZK01U1rmxFDu8kpi6sChc26dZ
 2Z/sNb/zfarfX2U/OvIVXFWhioF/N1QSdkZTGkhqxMM+asfs/JKhHI0mbTgIpjJMeQHi
 m+TO3EJd/0M3af4CJTRdgAQam+mLMP+zNmHqgNEhETmABhDk7SNExiKodZGdhpziDU5G
 QbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=hju+RMdTcujQI1iZG4iOt3phY9wG9vAPXXn0PUAzHLg=;
 b=sw0eWgzwkrladvUmTrp57kZc/Bl1ecLzo6e+1rBnNVAsbjRKHjPeNa99haOzZ2nNDx
 lmsAtgawK4uPG3YUKbO/CwYk3LFAat9b5yvRtGHBc1LoAbOLxuHxJJJymMjDgEP6WiOY
 w45Cfdc2Tr2/kcj8xLZPPNarfzp8lokqQIIWMVPk9UZAQE7hbCi4xQm3P6uyukArHRMm
 hLJm1apBIlVEalHnyCbQrvHY2ME0jMvdWJ+cYj09oyJUt5SHHKEdPCdALn+9EUug55Il
 dVEbEsn29FmQHTIrlobY9KYCW2nfPYOpvXNSlITx9neBzRhIbMJt/URCOel3aew5byof
 tXAg==
X-Gm-Message-State: AOAM530t32I5s1eYOAFbx+Nro1Ai+QJJ7RCk6SPLQOoydNqJKceC/XmM
 YR5bn4nJJESXCiC52eeByvWRfJ942Qs=
X-Google-Smtp-Source: ABdhPJxbBIUKZR+LS/fsZOZ2eXX4x/SvOp8eNsZ1BtGeqPNNKNYlL5a6lbBqu6bz0NNF7MsCOg4tAA==
X-Received: by 2002:a1c:b603:: with SMTP id g3mr4784620wmf.116.1597841888539; 
 Wed, 19 Aug 2020 05:58:08 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id h11sm40424927wrb.68.2020.08.19.05.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 05:58:07 -0700 (PDT)
Subject: Re: [PATCH v4] drm/amdgpu: add new trace event for page table update
 v3
To: Shashank Sharma <shashank.sharma@amd.com>, Nirmoy <nirmodas@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200813030414.188468-1-shashank.sharma@amd.com>
 <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
 <ea572a64-37e4-d3db-f884-59f34bbdce38@amd.com>
 <7dbb15c2-9b28-6c30-872c-e64fc51d4879@amd.com>
 <2bfb1e81-1c25-9cad-0bd9-dccb8fb18c33@amd.com>
 <e8aca13f-2399-0627-0208-c3085e6ec7f6@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4e6d00c9-5fd8-81a6-5420-ae95306d43cb@gmail.com>
Date: Wed, 19 Aug 2020 14:58:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e8aca13f-2399-0627-0208-c3085e6ec7f6@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTkuMDguMjAgdW0gMTQ6NTEgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gT24gMTkvMDgv
MjAgNjoxNSBwbSwgTmlybW95IHdyb3RlOgo+PiBIaSBDaHJpc3RpYW4sCj4+Cj4+IE9uIDgvMTkv
MjAgMjowOCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4KPj4+IEFtIDE5LjA4LjIwIHVt
IDEzOjUyIHNjaHJpZWIgU2hhc2hhbmsgU2hhcm1hOgo+Pj4+IE9uIDEzLzA4LzIwIDE6MjggcG0s
IENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4+IEFtIDEzLjA4LjIwIHVtIDA1OjA0IHNjaHJp
ZWIgU2hhc2hhbmsgU2hhcm1hOgo+Pj4+Pj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IHRyYWNlIGV2
ZW50IHRvIHRyYWNrIHRoZSBQVEUgdXBkYXRlCj4+Pj4+PiBldmVudHMuIFRoaXMgc3BlY2lmaWMg
ZXZlbnQgd2lsbCBwcm92aWRlIGluZm9ybWF0aW9uIGxpa2U6Cj4+Pj4+PiAtIHN0YXJ0IGFuZCBl
bmQgb2YgdmlydHVhbCBtZW1vcnkgbWFwcGluZwo+Pj4+Pj4gLSBIVyBlbmdpbmUgZmxhZ3MgZm9y
IHRoZSBtYXAKPj4+Pj4+IC0gcGh5c2ljYWwgYWRkcmVzcyBmb3IgbWFwcGluZwo+Pj4+Pj4KPj4+
Pj4+IFRoaXMgd2lsbCBiZSBwYXJ0aWN1bGFybHkgdXNlZnVsIGZvciBtZW1vcnkgcHJvZmlsaW5n
IHRvb2xzCj4+Pj4+PiAobGlrZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRoZSBwYWdlIHRh
YmxlIHVwZGF0ZSBldmVudHMuCj4+Pj4+Pgo+Pj4+Pj4gVjI6IEFkZGVkIHBoeXNpY2FsIGFkZHJl
c3MgbG9va3VwIGxvZ2ljIGluIHRyYWNlIHBvaW50Cj4+Pj4+PiBWMzogc3dpdGNoIHRvIHVzZSBf
X2R5bmFtaWNfYXJyYXkKPj4+Pj4+ICDCoMKgwqDCoMKgIGFkZGVkIG5wdGVzIGludCB0aGUgVFBw
cmludCBhcmd1bWVudHMgbGlzdAo+Pj4+Pj4gIMKgwqDCoMKgwqAgYWRkZWQgcGFnZSBzaXplIGlu
IHRoZSBhcmcgbGlzdAo+Pj4+Pj4gVjQ6IEFkZHJlc3NlZCBDaHJpc3RpYW4ncyByZXZpZXcgY29t
bWVudHMKPj4+Pj4+ICDCoMKgwqDCoMKgIGFkZCBzdGFydC9lbmQgaW5zdGVhZCBvZiBzZWcKPj4+
Pj4+ICDCoMKgwqDCoMKgIHVzZSBpbmNyIGluc3RlYWQgb2YgcGFnZV9zeiB0byBiZSBhY2N1cmF0
ZQo+Pj4+Pj4KPj4+Pj4+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4+Pj4+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
Pgo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogU2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFu
ay5zaGFybWFAYW1kLmNvbT4KPj4+Pj4+IC0tLQo+Pj4+Pj4gIMKgwqAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggfCAzNwo+Pj4+Pj4gKysrKysrKysrKysrKysrKysr
KysrKysKPj4+Pj4+ICDCoMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
wqDCoMKgIHzCoCA5ICsrKystLQo+Pj4+Pj4gIMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+Pj4+Pj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+Pj4+Pj4gaW5kZXggNjNlNzM0YTEyNWZi
Li5kZjEyY2Y4NDY2YzIgMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHJhY2UuaAo+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3RyYWNlLmgKPj4+Pj4+IEBAIC0zMjEsNiArMzIxLDQzIEBAIERFRklORV9FVkVO
VChhbWRncHVfdm1fbWFwcGluZywgYW1kZ3B1X3ZtX2JvX2NzLAo+Pj4+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFRQX0FSR1MobWFwcGluZykKPj4+Pj4+ICDCoMKgICk7Cj4+Pj4+PiAgwqDCoCAr
VFJBQ0VfRVZFTlQoYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzLAo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IFRQX1BST1RPKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKPj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3Qgc3RhcnQsIHVpbnQ2NF90IGVuZCwKPj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IG5wdGVzLCB1aW50NjRfdCBk
c3QsCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IGluY3IsIHVpbnQ2
NF90IGZsYWdzKSwKPj4+Pj4+ICvCoMKgwqAgVFBfQVJHUyhwLCBzdGFydCwgZW5kLCBucHRlcywg
ZHN0LCBpbmNyLCBmbGFncyksCj4+Pj4+PiArwqDCoMKgIFRQX1NUUlVDVF9fZW50cnkoCj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZmllbGQodTY0LCBzdGFydCkKPj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19maWVsZCh1NjQsIGVuZCkKPj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgX19maWVsZCh1NjQsIGZsYWdzKQo+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBfX2ZpZWxkKHVuc2lnbmVkIGludCwgbnB0ZXMpCj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIF9fZmllbGQodTY0LCBpbmNyKQo+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBfX2R5bmFtaWNfYXJyYXkodTY0LCBkc3QsIG5wdGVzKQo+Pj4+PiBBcyBk
aXNjdXNzZWQgd2l0aCB0aGUgdHJhY2Ugc3Vic3lzdGVtIG1haW50YWluZXIgd2UgbmVlZCB0byBh
ZGQgdGhlIHBpZAo+Pj4+PiBhbmQgcHJvYmFibHkgdGhlIFZNIGNvbnRleHQgSUQgd2UgdXNlIGhl
cmUgdG8gaWRlbnRpZnkgdGhlIHVwZGF0ZWQgVk0uCj4+Pj4+Cj4+Pj4+IENocmlzdGlhbi4KPj4+
PiBJIHByaW50ZWQgYm90aCB2bS0+dGFza19pbmZvLnBpZCBWcyBjdXJyZW50LT5waWQgZm9yIHRl
c3RpbmcsIGFuZCBJCj4+Pj4gY2FuIHNlZSBkaWZmZXJlbnQgdmFsdWVzIGNvbWluZyBvdXQgb2Yg
Lgo+Pj4+Cj4+Pj4gZ25vbWUtc2hlbGwtMjExNMKgIFswMTFdwqDCoMKgIDQxLjgxMjg5NDogYW1k
Z3B1X3ZtX3VwZGF0ZV9wdGVzOgo+Pj4+IHN0YXJ0OjB4MDgwMDEwMmU4MCBlbmQ6MHgwODAwMTAy
ZTgyLCBmbGFnczoweDgwLCBpbmNyOjQwOTYsIHBpZD0yMTI4Cj4+Pj4gdm1pZD0wIGNwaWQ9MjEx
NAo+Pj4+Cj4+Pj4gcGlkIGlzIHZtLT50YXNrX2luZm8ucGlkPTIxMjggd2hlcmVhcyBjcGlkPTIx
MTQgaXMgY3VycmVudC5waWQuCj4+Pj4KPj4+PiBXaGljaCBpcyB0aGUgb25lIHdlIHdhbnQgdG8g
c2VuZCB3aXRoIHRoZSBldmVudCA/Cj4+PiBUaGF0IGlzIHZtLT50YXNrX2luZm8ucGlkLCBzaW5j
ZSB0aGlzIGlzIHRoZSBQSUQgd2hpY2ggaXMgdXNpbmcgdGhlIFZNCj4+PiBmb3IgY29tbWFuZCBz
dWJtaXNzaW9uLgo+PiBOb29iIHF1ZXN0aW9uOgo+Pgo+PiBXaHkgdGhlc2UgdHdvIHBpZHMgYXJl
IGRpZmZlcmVudCA/IElzIGl0IGxpa2UgdGhhdCwgdGhlIGNwaWQtMjExNAo+PiBwcm9jZXNzIGNy
ZWF0ZWQgYSBwYWdlL21lbW9yeS1hcmVhIGFuZCBub3cgcGlkLTIxMjggdXNpbmcgdGhhdAo+PiBw
YWdlL21lbW9yeS1hcmVhIHRvIHN1Ym1pdCBhIGNvbW1hbmQgPwo+IE15IHVuZGVyc3RhbmRpbmcg
aXMgdGhhdCB0aGlzIGlzIGR1ZSB0byBhIHNlcnZlci1jbGllbnQgYXJyYW5nZW1lbnQsIHdoZXJl
IGEgY2xpZW50IHByb2Nlc3MgY2FuIGNyZWF0ZSBhIG1lbW9yeSBtYXAgYW5kIGZpbGwgaXQgZm9y
IHRoZSBzdWJtaXNzaW9uLCBidXQgaXQgZG9lc250IGhhdmUgcHJpdmlsZWdlIHRvwqAgZG8gdGhh
dCwgYW5kIHRoYXQgc2hvdWxkIGJlIGRvbmUgYnkgdGhlIHNlcnZlciBwcm9jZXNzIChsaWtlIFgv
d2F5bGFuZCBldGMpCgpUaGF0J3MgY2xvc2UgYnV0IG5vdCBxdWl0ZSBjb3JyZWN0LgoKT25lIHVz
ZSBjYXNlIGlzIHdoYXQgU2hhc2hhbmsgZGVzY3JpYmVzIGhlcmUgd2hlcmUgdGhlIHNlcnZlciBh
bGxvY2F0ZXMgCnNvbWV0aGluZyBvbiBiZWhhbHZlcyBvZiB0aGUgY2xpZW50IGFuZCBiZWNhdXNl
IG9mIGRlbGF5ZWQgdXBkYXRlcyB3ZSAKZW5kIHVwIHVwZGF0aW5nIHRoZSBwYWdlIHRhYmxlcyBp
biBhIGRpZmZlcmVudCBwcm9jZXNzIHRoZW4gd2hlcmUgCnNvbWV0aGluZyBpcyByZWFsbHkgdXNl
ZC4KCkJ1dCB0aGUgbW9yZSBjb21tYW5kIHVzZSBjYXNlIGlzIGV2aWN0aW9uIHdoZXJlIHByb2Nl
c3MgQSBpcyBraWNraW5nIG91dCAKQk9zIG9mIHByb2Nlc3MgQiBhbmQgYmVjYXVzZSBvZiB0aGlz
IHRoZSBwYWdlIHRhYmxlIG9mIHByb2Nlc3MgQiBhcmUgCnVwZGF0ZWQgaW4gdGhlIGNvbnRleHQg
b2YgQS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCgo+Cj4gLSBTaGFzaGFuawo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
