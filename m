Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C8C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF309214AF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISTsgck+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF309214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938316ECB7;
	Thu, 12 Dec 2019 08:51:48 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D306ECB7
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 08:51:46 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p17so1541188wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 00:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=zGl6ZUCqu3VbabWXtw4yUinLosysj9pirBVgUt9MQbk=;
 b=ISTsgck+tqr2gvzAB1835vMV22hAS2AN5i945MAjk7TzX1g2oHSo9Y0IkUqRPjRn5S
 UmvT8vFwQWT1RvMo0UqVHKiVb4ZRi8UP8T0aAls/ojmy9v9En1ltTGh4eZuL9/SdW5h3
 8zcyWdE58bBoGseD21QaxumrAAB4K7UwvOat1ptjn6rdNg+unvNrrtKofvTDd0KMgBEk
 xqEEOsUYDnvARo22PWYGROqAyXuyjtHrC3Azt/J1aZbVqDJgWrGybNlM4soqDhgXCs1S
 IvZjmThG9nDUJB03m68E94sAcR21a5NdUkc9qCKaJgLvhDCn7vGE9KEGYIu9f9prAzmh
 Cruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zGl6ZUCqu3VbabWXtw4yUinLosysj9pirBVgUt9MQbk=;
 b=S7o6D9cOBv6xlWtmTBVJNQcdiowt8B0j3w//DTnj7t7jSxEolHzBscFl5u4OvBspW5
 +yojTC84H/KBOisy113znKcHjTsRZCeayvysMM+/LvdQtEI8vO8OeDPktCHYaS6S5t1X
 KMay5NPKayWCAtvE49iJyHtUPX+9AKtaoPRrNKAJu5ykQT7qIVwvYWgThAAqHPJNT6CP
 8wqlyWJtwVvnwY7/aDCqNMvgsBT0PV0KA9Uu6/Spzij1JAyvZHiDBPDUK0uVU2yioULg
 pOUnZXOs5uyPtmae4EfyUAe5SelYZ0omyoatG3KmgpEjkWgCd3zsV9K7+m3vVvlwBcme
 ajkQ==
X-Gm-Message-State: APjAAAWsDDWieqvGWv0SKrT9NEJ3soq4qwiWuzzZGuzVoe4fpaQl5tpW
 lU4nxgMJLydaXR7/k+Vu3ZoX6+ML
X-Google-Smtp-Source: APXvYqwD2hzjZ9DM5uvBh0pgHpWp5b7sDa98/zyBRt3vLGQr4LEmGxFQ/NU2Ut1caZe4Po29nJgI3w==
X-Received: by 2002:a05:600c:21c6:: with SMTP id
 x6mr4916926wmj.177.1576140705307; 
 Thu, 12 Dec 2019 00:51:45 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s15sm5226525wrp.4.2019.12.12.00.51.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 00:51:44 -0800 (PST)
Subject: Re: [PATCH 5/5] drm/amdgpu: immedially invalidate PTEs
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com, Alex.Sierra@amd.com
References: <20191205133940.3865-1-christian.koenig@amd.com>
 <20191205133940.3865-5-christian.koenig@amd.com>
 <afc4a884-dc56-867e-580c-7845e7de2257@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <98ce952f-f52d-bf60-00b3-d984b7c2184d@gmail.com>
Date: Thu, 12 Dec 2019 09:51:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <afc4a884-dc56-867e-580c-7845e7de2257@amd.com>
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

SGkgRmVsaXgsCgp5ZWFoLCBJJ3ZlIGFsc28gZm91bmQgYSBjb3JuZXIgY2FzZSB3aGljaCB3b3Vs
ZCByYWlzZSBhIHdhcm5pbmcgbm93LgoKTmVlZCB0byByZXdvcmsgaG93IGRlcGVuZGVuY2llcyBm
b3IgdGhlIFBURSB1cGRhdGUgYXJlIGdlbmVyYXRlZC4KCkdvaW5nIHRvIHRha2UgY2FyZSBvZiB0
aGlzIGluIHRoZSBuZXh0IGZldyBkYXlzLApDaHJpc3RpYW4uCgpBbSAxMi4xMi4xOSB1bSAwMToy
MCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IEhpIENocmlzdGlhbiwKPgo+IEFsZXggc3RhcnRl
ZCB0cnlpbmcgdG8gaW52YWxpZGF0ZSBQVEVzIGluIHRoZSBNTVUgbm90aWZpZXJzIGFuZCB3ZSdy
ZSAKPiBmaW5kaW5nIHRoYXQgd2Ugc3RpbGwgbmVlZCB0byByZXNlcnZlIHRoZSBWTSByZXNlcnZh
dGlvbiBmb3IgCj4gYW1kZ3B1X3N5bmNfcmVzdiBpbiBhbWRncHVfdm1fc2RtYV9wcmVwYXJlLiBJ
cyB0aGF0IHN5bmNfcmVzdiBzdGlsbCAKPiBuZWVkZWQgbm93LCBnaXZlbiB0aGF0IFZNIGZlbmNl
cyBhcmVuJ3QgaW4gdGhhdCByZXNlcnZhdGlvbiBvYmplY3QgYW55IAo+IG1vcmU/Cj4KPiBSZWdh
cmRzLAo+IMKgIEZlbGl4Cj4KPiBPbiAyMDE5LTEyLTA1IDU6MzksIENocmlzdGlhbiBLw7ZuaWcg
d3JvdGU6Cj4+IFdoZW4gYSBCTyBpcyBldmljdGVkIGltbWVkaWFsbHkgaW52YWxpZGF0ZSB0aGUg
bWFwcGVkIFBURXMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIHwgMTcgKysrKysrKysrKysrKysrKy0KPj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDE2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IGluZGV4IDgzOWQ2ZGYzOTRmYy4uZTU3ODExM2Jm
ZDU1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBAQCAt
MjU2NSw2ICsyNTY1LDcgQEAgdm9pZCBhbWRncHVfdm1fYm9faW52YWxpZGF0ZShzdHJ1Y3QgCj4+
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpibywgYm9vbCBldmljdGVkKQo+PiDCoCB7Cj4+IMKgwqDC
oMKgwqAgc3RydWN0IGFtZGdwdV92bV9ib19iYXNlICpib19iYXNlOwo+PiArwqDCoMKgIGludCBy
Owo+PiDCoCDCoMKgwqDCoMKgIC8qIHNoYWRvdyBibyBkb2Vzbid0IGhhdmUgYm8gYmFzZSwgaXRz
IHZhbGlkYXRpb24gbmVlZHMgaXRzIAo+PiBwYXJlbnQgKi8KPj4gwqDCoMKgwqDCoCBpZiAoYm8t
PnBhcmVudCAmJiBiby0+cGFyZW50LT5zaGFkb3cgPT0gYm8pCj4+IEBAIC0yNTcyLDggKzI1NzMs
MjIgQEAgdm9pZCBhbWRncHVfdm1fYm9faW52YWxpZGF0ZShzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCj4+IMKgIMKgwqDCoMKgwqAgZm9yIChib19iYXNlID0gYm8tPnZtX2JvOyBib19i
YXNlOyBib19iYXNlID0gYm9fYmFzZS0+bmV4dCkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IGFtZGdwdV92bSAqdm0gPSBib19iYXNlLT52bTsKPj4gK8KgwqDCoMKgwqDCoMKgIHN0cnVj
dCBkbWFfcmVzdiAqcmVzdiA9IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNlLnJlc3Y7Cj4+ICsK
Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChiby0+dGJvLnR5cGUgIT0gdHRtX2JvX3R5cGVfa2VybmVs
KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm9fdmEgKmJvX3Zh
Owo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvX3ZhID0gY29udGFpbmVyX29mKGJv
X2Jhc2UsIHN0cnVjdCBhbWRncHVfYm9fdmEsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmFzZSk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHIgPSBhbWRncHVfdm1fYm9fdXBkYXRlKGFkZXYsIGJvX3ZhLAo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiby0+dGJvLmJhc2UucmVzdiAhPSByZXN2
KTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFyKSB7Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3ZtX2JvX2lkbGUoYm9fYmFzZSk7Cj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0KPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gwqAgLcKgwqDCoMKgwqDCoMKgIGlmIChldmlj
dGVkICYmIGJvLT50Ym8uYmFzZS5yZXN2ID09IAo+PiB2bS0+cm9vdC5iYXNlLmJvLT50Ym8uYmFz
ZS5yZXN2KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZXZpY3RlZCAmJiBiby0+dGJvLmJhc2Uu
cmVzdiA9PSByZXN2KSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV92bV9i
b19ldmljdGVkKGJvX2Jhc2UpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51
ZTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
