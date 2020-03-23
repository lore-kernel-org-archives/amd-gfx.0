Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17EC4332E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 12:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAED2078B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 12:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8Yq/rB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAED2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 015BC89FC3;
	Mon, 23 Mar 2020 12:24:07 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF8E89FC3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 12:24:06 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id 65so107550wrl.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=y8nfLpSeWIj2CfUcCtXpxf1MLJZf/Wn8r8/p72FdE08=;
 b=L8Yq/rB/IFNsYsXanDz+ZIsPNtpIrghG/kmz+RA6OPFQMBY4J9w0FSau6Q6XKZjyTa
 h7Lb07FwQIRCNuhFGFBXSFA6+txkoEISoMb8KxvY5iHCnCgRVV9OX4reRI4flfOh8fKs
 Mkms5yXcTNXCLfeeLIpgt2ipEnUBiPP4HhIdgjVY2ZzFHKl8hvKFmtWY5lrJX/hl8dyq
 i2l92rEn39c70kJa2+Yqy751F/ONrcqWLIRSYopu4J/5XNXkXvZFtThQybUI/ddj3nYL
 CIleIgGgP62qVrLOYCQfLGCN1snCh0zmNBkOGFm13JrIof4cPEEKPaRFt26GDPY5339D
 MCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=y8nfLpSeWIj2CfUcCtXpxf1MLJZf/Wn8r8/p72FdE08=;
 b=FNI4CrrYOQ6wI4vvhhrul4N71Rr9qKudeERjrxFyweIh8YQs3peLnU++PJKeiNQsjb
 IG9R6FT8FRQlY7w5RmmPlrCAAT20hwnPCi10s36Be3FuU49gpWcdGCQoxvo70J6pGvyH
 kTi/f+/IUcBvoNNjSFiMVYqgFLIN3KUNyUJKCV0i9zsl3aFMqyM9evwprMEpQQ01Mnpk
 5UH8KCCqhvrLUh9LRhIwajSTr35d8MihHRX3j/OLb64izJjjmRzFLfmZixI8mVbImEkN
 DrMNkG3aXHh5rdykHsy/cPR/K8rKGjhfrzcFgx1iE7sdKzVgdoVL4HpcOBL6uh7hGRgV
 V1tA==
X-Gm-Message-State: ANhLgQ3qiSIAYVf7jLNTKylvOEhSoZX2XA6JPnaw2JDvMXV7bVz1AKwB
 JA4DcndqjqY4IS409tGIclVHpkJP
X-Google-Smtp-Source: ADFU+vsLgwiLuc26Nlja7n+gT76lolmS4vFCjq7dEBEx65ZKQ/KKrzuPMcucAmPt7SWgtUwOnJiijw==
X-Received: by 2002:adf:9dca:: with SMTP id q10mr29294972wre.11.1584966244623; 
 Mon, 23 Mar 2020 05:24:04 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id r3sm23960959wrm.35.2020.03.23.05.24.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Mar 2020 05:24:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: add full TMZ support into
 amdgpu_ttm_map_buffer v2
To: Huang Rui <ray.huang@amd.com>
References: <20200322154835.2702-1-christian.koenig@amd.com>
 <20200322154835.2702-2-christian.koenig@amd.com>
 <20200323082903.GB25240@jenkins-Celadon-RN>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ea8d4b27-4228-c8ab-a95d-1706d99f79a9@gmail.com>
Date: Mon, 23 Mar 2020 13:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200323082903.GB25240@jenkins-Celadon-RN>
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjMuMDMuMjAgdW0gMDk6Mjkgc2NocmllYiBIdWFuZyBSdWk6Cj4gT24gU3VuLCBNYXIgMjIs
IDIwMjAgYXQgMDQ6NDg6MzVQTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gVGhp
cyBzaG91bGQgYWxsb3cgdXMgdG8gYWxzbyBzdXBwb3J0IFZSQU0tPkdUVCBtb3Zlcy4KPj4KPj4g
djI6IGZpeCBtaXNzaW5nIHZyYW1fYmFzZV9hZGp1c3RtZW50Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4gLS0tCj4+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMzggKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMo
KyksIDggZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dHRtLmMKPj4gaW5kZXggNTNkZTk5ZGJhZWFkLi5lMTVhMzQzYTk0NGIgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4gQEAgLTMwOSwyMSArMzA5LDIxIEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9tYXBfYnVmZmVyKHN0cnVjdCB0dG1fYnVmZmVyX29iamVj
dCAqYm8sCj4+ICAgCQkJCSB1bnNpZ25lZCB3aW5kb3csIHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZywKPj4gICAJCQkJIGJvb2wgdG16LCB1aW50NjRfdCAqYWRkcikKPj4gICB7Cj4+IC0Jc3RydWN0
IHR0bV9kbWFfdHQgKmRtYSA9IGNvbnRhaW5lcl9vZihiby0+dHRtLCBzdHJ1Y3QgdHRtX2RtYV90
dCwgdHRtKTsKPj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+
PiAgIAlzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iOwo+PiAgIAl1bnNpZ25lZCBudW1fZHcsIG51bV9i
eXRlczsKPj4gLQlkbWFfYWRkcl90ICpkbWFfYWRkcmVzczsKPj4gICAJc3RydWN0IGRtYV9mZW5j
ZSAqZmVuY2U7Cj4+ICAgCXVpbnQ2NF90IHNyY19hZGRyLCBkc3RfYWRkcjsKPj4gKwl2b2lkICpj
cHVfYWRkcjsKPj4gICAJdWludDY0X3QgZmxhZ3M7Cj4+ICsJdW5zaWduZWQgaW50IGk7Cj4+ICAg
CWludCByOwo+PiAgIAo+PiAgIAlCVUdfT04oYWRldi0+bW1hbi5idWZmZXJfZnVuY3MtPmNvcHlf
bWF4X2J5dGVzIDwKPj4gICAJICAgICAgIEFNREdQVV9HVFRfTUFYX1RSQU5TRkVSX1NJWkUgKiA4
KTsKPj4gICAKPj4gICAJLyogTWFwIG9ubHkgd2hhdCBjYW4ndCBiZSBhY2Nlc3NlZCBkaXJlY3Rs
eSAqLwo+PiAtCWlmIChtZW0tPnN0YXJ0ICE9IEFNREdQVV9CT19JTlZBTElEX09GRlNFVCkgewo+
PiArCWlmICghdG16ICYmIG1lbS0+c3RhcnQgIT0gQU1ER1BVX0JPX0lOVkFMSURfT0ZGU0VUKSB7
Cj4+ICAgCQkqYWRkciA9IGFtZGdwdV9tbV9ub2RlX2FkZHIoYm8sIG1tX25vZGUsIG1lbSkgKyBv
ZmZzZXQ7Cj4+ICAgCQlyZXR1cm4gMDsKPj4gICAJfQo+PiBAQCAtMzUxLDE1ICszNTEsMzcgQEAg
c3RhdGljIGludCBhbWRncHVfdHRtX21hcF9idWZmZXIoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0
ICpibywKPj4gICAJYW1kZ3B1X3JpbmdfcGFkX2liKHJpbmcsICZqb2ItPmlic1swXSk7Cj4+ICAg
CVdBUk5fT04oam9iLT5pYnNbMF0ubGVuZ3RoX2R3ID4gbnVtX2R3KTsKPj4gICAKPj4gLQlkbWFf
YWRkcmVzcyA9ICZkbWEtPmRtYV9hZGRyZXNzW29mZnNldCA+PiBQQUdFX1NISUZUXTsKPj4gICAJ
ZmxhZ3MgPSBhbWRncHVfdHRtX3R0X3B0ZV9mbGFncyhhZGV2LCBiby0+dHRtLCBtZW0pOwo+PiAg
IAlpZiAodG16KQo+PiAgIAkJZmxhZ3MgfD0gQU1ER1BVX1BURV9UTVo7Cj4+ICAgCj4+IC0JciA9
IGFtZGdwdV9nYXJ0X21hcChhZGV2LCAwLCBudW1fcGFnZXMsIGRtYV9hZGRyZXNzLCBmbGFncywK
Pj4gLQkJCSAgICAmam9iLT5pYnNbMF0ucHRyW251bV9kd10pOwo+PiAtCWlmIChyKQo+PiAtCQln
b3RvIGVycm9yX2ZyZWU7Cj4+ICsJY3B1X2FkZHIgPSAmam9iLT5pYnNbMF0ucHRyW251bV9kd107
Cj4+ICsKPj4gKwlpZiAobWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfVFQpIHsKPj4gKwkJc3RydWN0
IHR0bV9kbWFfdHQgKmRtYTsKPj4gKwkJZG1hX2FkZHJfdCAqZG1hX2FkZHJlc3M7Cj4+ICsKPj4g
KwkJZG1hID0gY29udGFpbmVyX29mKGJvLT50dG0sIHN0cnVjdCB0dG1fZG1hX3R0LCB0dG0pOwo+
PiArCQlkbWFfYWRkcmVzcyA9ICZkbWEtPmRtYV9hZGRyZXNzW29mZnNldCA+PiBQQUdFX1NISUZU
XTsKPj4gKwkJciA9IGFtZGdwdV9nYXJ0X21hcChhZGV2LCAwLCBudW1fcGFnZXMsIGRtYV9hZGRy
ZXNzLCBmbGFncywKPj4gKwkJCQkgICAgY3B1X2FkZHIpOwo+PiArCQlpZiAocikKPj4gKwkJCWdv
dG8gZXJyb3JfZnJlZTsKPj4gKwl9IGVsc2Ugewo+PiArCQlkbWFfYWRkcl90IGRtYV9hZGRyZXNz
Owo+PiArCj4+ICsJCWRtYV9hZGRyZXNzID0gKG1tX25vZGUtPnN0YXJ0IDw8IFBBR0VfU0hJRlQp
ICsgb2Zmc2V0Owo+PiArCQlkbWFfYWRkcmVzcyArPSBhZGV2LT52bV9tYW5hZ2VyLnZyYW1fYmFz
ZV9vZmZzZXQ7Cj4+ICsKPj4gKwkJZm9yIChpID0gMDsgaSA8IG51bV9wYWdlczsgKytpKSB7Cj4+
ICsJCQlyID0gYW1kZ3B1X2dhcnRfbWFwKGFkZXYsIGkgPDwgUEFHRV9TSElGVCwgMSwKPj4gKwkJ
CQkJICAgICZkbWFfYWRkcmVzcywgZmxhZ3MsIGNwdV9hZGRyKTsKPiBNYXkgSSBrbm93IHdoeSBk
byB3ZSBuZWVkIG1hcCB0aGUgcGFnZSBvbmUgYnkgb25lIGhlcmU/IElzIGl0IGJlY2F1c2UgaWYK
PiBub3QgUExfVFQsIHRoZSBidWZmZXIgbWlnaHQgbm90IGJlIGNvbnRpbnVvdXM/CgpUaGUgcHJv
YmxlbSBpcyBhY3R1YWxseSB0aGUgb3RoZXIgd2F5IGFyb3VuZC4KCmFtZGdwdV9nYXJ0X21hcCgp
IGV4cGVjdHMgYW4gYXJyYXkgd2l0aCBub3QgY29udGludW91cyBhZGRyZXNzZXMgZm9yIApQTF9U
VCwgYnV0IHdlIGhhdmUgYW4gY29udGludW91cyBhZGRyZXNzIGhlcmUgd2Ugd2FudCB0byBtYXAu
CgpBdCBzb21lIHBvaW50IHdlIHNob3VsZCBwcm9iYWJseSBzd2l0Y2ggdGhhdCB0byB1c2luZyBz
Z190YWJsZXMgb3Igc29tZSAKb3RoZXIgYmV0dGVyIHN0cnVjdHVyZSwgYnV0IGZvciBub3cgdGhp
cyBzaG91bGQgYmUgc3VmZmljaWVudC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBUaGFua3Ms
Cj4gUmF5Cj4KPj4gKwkJCWlmIChyKQo+PiArCQkJCWdvdG8gZXJyb3JfZnJlZTsKPj4gKwo+PiAr
CQkJZG1hX2FkZHJlc3MgKz0gUEFHRV9TSVpFOwo+PiArCQl9Cj4+ICsJfQo+PiAgIAo+PiAgIAly
ID0gYW1kZ3B1X2pvYl9zdWJtaXQoam9iLCAmYWRldi0+bW1hbi5lbnRpdHksCj4+ICAgCQkJICAg
ICAgQU1ER1BVX0ZFTkNFX09XTkVSX1VOREVGSU5FRCwgJmZlbmNlKTsKPj4gLS0gCj4+IDIuMTQu
MQo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZh
bWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NyYXkuaHVhbmclNDBhbWQuY29tJTdDNDU2YTllNTYx
YWU0NGI2YmI5NDUwOGQ3Y2U3ODdmOTklN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3QzAlN0MwJTdDNjM3MjA0ODg5MjYzNDY2NzI1JmFtcDtzZGF0YT16b1ZBT240VVg0WTN2b01o
eUk0T3dFS3RlN1RnekdMQzVabUFqOVRrVyUyRlUlM0QmYW1wO3Jlc2VydmVkPTAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
