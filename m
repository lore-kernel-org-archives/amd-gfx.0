Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4FDC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 14:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02666101B
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 14:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02666101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889396EE7F;
	Fri, 14 May 2021 14:01:33 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8670B6EE7F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 14:01:31 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 d3-20020a9d29030000b029027e8019067fso26457491otb.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hleHhyLZCPc3AfznOA8dbc049X8KYCdc2EE+VcZDKW8=;
 b=TvZeYT3B1dauF9KvnxvG+eF1wHi/bBRkDFERP0QU/xOETsRkO65izUDjLp6CFh/kLq
 T01dPz//inpulXLr6UKFheIiHmP2i7ZDRZfHY8c+W2dBxfzAWxkzHn6eDCTBsNbOYsHt
 e2GVw2hEIc2T+wBc+dN51PHnxZ+amIu9TR/gyn2w1tyPgS/CdcX4r7jipa/WXHhWzmLT
 tcZAg9KPB0NI7LS1VwEF3UrdWZWOy+Hzo5SvQhcj3YLIUkmoY1JoMf19XJlUpk9YPmpt
 kloaSYJS501rm9XrmfBr8qPexrkBcbMSvrCdAQP4kVHvqYTbNrKeR08Y5sVo0ZanqE/6
 LwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hleHhyLZCPc3AfznOA8dbc049X8KYCdc2EE+VcZDKW8=;
 b=LxA96r1m6Jkro/eNznJZxhFilKB6LyWvd4kkEjPaYeoCKtXbRgcaLglBk0TdTc4MJL
 ZOzdy5HlYtQkfPUX/IMQIsohhbIIbPzzqZOALv3zgRHsfRn1KdEE+H62hoovbXhaa3EH
 l6QNx2RFNtrMpEFXTQdWpT8p4r7EWSjXiUpHvaYIpWmepHHG2V4zI4ZURXlyZyUZL7cn
 RT5H62s5LOEpyS+lMJT1aLzDxAt9tYWp1zcALp6aKzt8Gqd78sYx7r/unHEMoCQtWDrg
 olKpJ+JAWgX5jRmEdCJjTiTJX8hiBFqIMbmZqR0kFaGdMMIkR9ivzLtqDtT9o9YEhJyW
 tfWA==
X-Gm-Message-State: AOAM5331Due9Ode8R/JSaplunSgOobfDQZ2Hp3ED7LLJCv7l6tguDHnL
 x/jKqQc23WnQ7dkivZOFxNANjh5JX5EoBZnJ7f0=
X-Google-Smtp-Source: ABdhPJy8TsgS645e5NguWSEecKr2y+iPywLP1a+gfgxl+Qs+V3RiCYM67B7Bljd0VdtpAdxkBkxnDc0rzW7AM120D/U=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr9304838otl.311.1621000890909; 
 Fri, 14 May 2021 07:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <a5c987b3-e2bf-7c80-3362-fe3e6cb1d44c@gmail.com>
 <20210513174539.27409-1-david.nieto@amd.com>
 <CADnq5_NtPNk_6uhgPu8dSE-RPgRwMXYBHFvQ50WzEj_3N2bbHA@mail.gmail.com>
 <942da2f6-1aa2-3ec8-19fb-68be0da5f03d@gmail.com>
In-Reply-To: <942da2f6-1aa2-3ec8-19fb-68be0da5f03d@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 May 2021 10:01:20 -0400
Message-ID: <CADnq5_M_kwqPpGXbg9S0h-cz0FxqYX6bjidQuUS-qbaeJ0QqOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: free resources on fence usage query
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBNYXkgMTQsIDIwMjEgYXQgMzoyNiBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAxMy4wNS4yMSB1bSAyMDow
MCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiA+IE9uIFRodSwgTWF5IDEzLCAyMDIxIGF0IDE6NDUg
UE0gRGF2aWQgTSBOaWV0byA8ZGF2aWQubmlldG9AYW1kLmNvbT4gd3JvdGU6Cj4gPj4gRnJlZSB0
aGUgcmVzb3VyY2VzIGlmIHRoZSBmZW5jZSBuZWVkcyB0byBiZSBpZ25vcmVkCj4gPj4gZHVyaW5n
IHRoZSByYXRpbyBjYWxjdWxhdGlvbgo+ID4+Cj4gPj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTSBO
aWV0byA8ZGF2aWQubmlldG9AYW1kLmNvbT4KPiA+IFNlcmllcyBpczoKPiA+IFJldmlld2VkLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4KPiBSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4gPiBXaWxs
IHB1c2ggaXQgbW9tZW50YXJpbHkuCj4KPiBUbyBkcm0tbWlzYy1uZXh0IG9yIGFtZC1zdGFnaW5n
LWRybS1uZXh0PyBZb3UgbmVlZCB0byByZWJhc2Ugb24gdXBzdHJlYW0KPiBmb3IgdGhlIGxhdGVy
LgoKZHJtLW1pc2MtbmV4dCBzaW5jZSB0aGF0IGlzIHdoZXJlIHRoZSByZWxldmFudCBwcmlvciBw
YXRjaGVzIGxhbmRlZC4KCkFsZXgKCj4KPiBDaHJpc3RpYW4uCj4KPiA+Cj4gPiBBbGV4Cj4gPgo+
ID4KPiA+PiAtLS0KPiA+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHgu
YyB8IDggKysrKysrLS0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0
eC5jCj4gPj4gaW5kZXggMDFmZTYwZmVkY2JlLi45MDM2YzkzYjRhMGMgMTAwNjQ0Cj4gPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gPj4gQEAgLTY2OSwxMSArNjY5
LDE1IEBAIHZvaWQgYW1kZ3B1X2N0eF9mZW5jZV90aW1lKHN0cnVjdCBhbWRncHVfY3R4ICpjdHgs
IHN0cnVjdCBhbWRncHVfY3R4X2VudGl0eSAqY2VuCj4gPj4gICAgICAgICAgICAgICAgICBpZiAo
IWZlbmNlKQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiA+PiAgICAg
ICAgICAgICAgICAgIHNfZmVuY2UgPSB0b19kcm1fc2NoZWRfZmVuY2UoZmVuY2UpOwo+ID4+IC0g
ICAgICAgICAgICAgICBpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCgmc19mZW5jZS0+c2NoZWR1
bGVkKSkKPiA+PiArICAgICAgICAgICAgICAgaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQoJnNf
ZmVuY2UtPnNjaGVkdWxlZCkpIHsKPiA+PiArICAgICAgICAgICAgICAgICAgICAgICBkbWFfZmVu
Y2VfcHV0KGZlbmNlKTsKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4g
Pj4gKyAgICAgICAgICAgICAgIH0KPiA+PiAgICAgICAgICAgICAgICAgIHQxID0gc19mZW5jZS0+
c2NoZWR1bGVkLnRpbWVzdGFtcDsKPiA+PiAtICAgICAgICAgICAgICAgaWYgKHQxID49IG5vdykK
PiA+PiArICAgICAgICAgICAgICAgaWYgKCFrdGltZV9iZWZvcmUodDEsIG5vdykpIHsKPiA+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBkbWFfZmVuY2VfcHV0KGZlbmNlKTsKPiA+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4gPj4gKyAgICAgICAgICAgICAgIH0KPiA+PiAg
ICAgICAgICAgICAgICAgIGlmIChkbWFfZmVuY2VfaXNfc2lnbmFsZWQoJnNfZmVuY2UtPmZpbmlz
aGVkKSAmJgo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICBzX2ZlbmNlLT5maW5pc2hlZC50
aW1lc3RhbXAgPCBub3cpCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICp0b3RhbCArPSBr
dGltZV9zdWIoc19mZW5jZS0+ZmluaXNoZWQudGltZXN0YW1wLCB0MSk7Cj4gPj4gLS0KPiA+PiAy
LjE3LjEKPiA+Pgo+ID4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiA+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+ID4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiA+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+ID4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
