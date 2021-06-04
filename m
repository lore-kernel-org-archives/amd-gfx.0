Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FDFC4743E
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 17:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A47E613FA
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 17:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A47E613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39DD86F647;
	Fri,  4 Jun 2021 17:22:09 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6983B6F646;
 Fri,  4 Jun 2021 17:22:08 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 i14-20020a9d624e0000b029033683c71999so9789534otk.5; 
 Fri, 04 Jun 2021 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Jwj11W1dNddZwxmLESUbeDm5qnursrjwtNP8oMdIXWI=;
 b=YKmmPaGc5sg7zLTZfX1ibvETcdsD4jmzaW0Ls+6Sj8pO8eXxXueWQQqKdLrHk5kS74
 VnUuzn+h/weDs9F2Vv6B3JiDdFhF1W6z4h5AgjNjyvYWj7NAUka7qO7A2FX5li0wH8cS
 1ZlO0QtKzi1ErVH14szu9EO+OB19ycegljhT4xD4bgVcqifBPVJYBJKUYNFrxiZU/Gk6
 Mgq+bIRoCsgcuN9zw7xaBN4ZAVQbl+ll4fbE1ob8QP6SSNWwv3fFbRau9qZpsjhT0uZj
 z44q51wY1uzF+CrviLZrAvTrtu9oLcTZgqtMUkwsqlF5hGxFDfjiTzozrNuvbeYvSSYt
 DvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Jwj11W1dNddZwxmLESUbeDm5qnursrjwtNP8oMdIXWI=;
 b=OQTRRn/RGXLk6yy96d03faQltHDNZcgpHiLVfKlwrEPnw5psL8bXDxNd7BGpSd6TNn
 TL6iVMY4zHfjW7PcOAPbGZFQG5AeetH8dHHgCSRWrxvPAQXfnCJVa4go5pd8BpUWC8EU
 K651rYNVleTKBNCoP1e590dty4belV0qTXM4wGJ2WNcU4tXa09oWjL1JnglUS+SR2Tz8
 5ACNuz/iqkVFRBSfjeyA68Kyyz8M0fIxszLvXDLTSyoIuv71ASohPnVNZN501PX3rqkh
 dXg9hQ6OkCtWblVifgQBB0vCMbkBBEoB8mD6xdjUSXNt0wzj0CX7EJ27Xke/1/dLuWmH
 Mp4Q==
X-Gm-Message-State: AOAM530l8c/9GWE7y4sRFPTh9eLUj54Vod/o8FNqR4/tM8Nww9DddQyZ
 XMBcBHgMzfau+UGS1arpB539aEGiFKFcBodc6ok=
X-Google-Smtp-Source: ABdhPJzrq437/q2H6TQntwoQRnFiVMqEeerpbPpO8kP/VQO+tYZYnhHR6HxTrljeb/ZuXt3gH9tgIVk4+L1Oi3wZPE4=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr2007512otr.23.1622827327707; 
 Fri, 04 Jun 2021 10:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <87o8cnfr3s.wl-chenli@uniontech.com>
 <87im2ufhyz.wl-chenli@uniontech.com>
 <0689a006-a0a2-698a-12d8-cb11156e469a@gmail.com>
 <877djacbfx.wl-chenli@uniontech.com>
 <c4941cb6-8c40-aad1-e61a-2786ba1ab225@gmail.com>
 <87zgw6aull.wl-chenli@uniontech.com>
In-Reply-To: <87zgw6aull.wl-chenli@uniontech.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Jun 2021 13:21:56 -0400
Message-ID: <CADnq5_P=y1uvWNF2j2EzyQaZoFANQqrGvZ79PuagXXQPM10HaA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] radeon: use memcpy_to/fromio for UVD fw upload
To: Chen Li <chenli@uniontech.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZCB3aXRoIHRoZSBSQiBmaXhlZC4KClRoYW5rcyEKCkFsZXgKCk9uIEZyaSwgSnVuIDQs
IDIwMjEgYXQgNzo1MyBBTSBDaGVuIExpIDxjaGVubGlAdW5pb250ZWNoLmNvbT4gd3JvdGU6Cj4K
Pgo+IEkgbWV0IGEgZ3B1IGFkZHIgYnVnIHJlY2VudGx5IGFuZCB0aGUga2VybmVsIGxvZwo+IHRl
bGxzIG1lIHRoZSBwYyBpcyBtZW1jcHkvbWVtc2V0IGFuZCBsaW5rIHJlZ2lzdGVyIGlzCj4gcmFk
ZW9uX3V2ZF9yZXN1bWUuCj4KPiBBcyB3ZSBrbm93LCBpbiBzb21lIGFyY2hpdGVjdHVyZXMsIG9w
dGltaXplZCBtZW1jcHkvbWVtc2V0Cj4gbWF5IG5vdCB3b3JrIHdlbGwgb24gZGV2aWNlIG1lbW9y
eS4gVHJpdmFsIG1lbWNweV90b2lvL21lbXNldF9pbwo+IGNhbiBmaXggdGhpcyBwcm9ibGVtLgo+
Cj4gQlRXLCBhbWRncHUgaGFzIGFscmVhZHkgZG9uZSBpdCBpbjoKPiBjb21taXQgYmEwYjIyNzVh
Njc4ICgiZHJtL2FtZGdwdTogdXNlIG1lbWNweV90by9mcm9taW8gZm9yIFVWRCBmdyB1cGxvYWQi
KSwKPiB0aGF0J3Mgd2h5IGl0IGhhcyBubyB0aGlzIGlzc3VlIG9uIHRoZSBzYW1lIGdwdSBhbmQg
cGxhdGZvcm0uCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuIExpIDxjaGVubGlAdW5pb250ZWNoLmNv
bT4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZwo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl91dmQuYyB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX3V2ZC5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZk
LmMKPiBpbmRleCA4NWExZjJjMzE3NDkuLjc1M2RhOTVlNmFiYiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl91dmQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX3V2ZC5jCj4gQEAgLTI4OCw3ICsyODgsNyBAQCBpbnQgcmFkZW9uX3V2ZF9y
ZXN1bWUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gICAgICAgICBpZiAocmRldi0+dXZk
LnZjcHVfYm8gPT0gTlVMTCkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4KPiAt
ICAgICAgIG1lbWNweShyZGV2LT51dmQuY3B1X2FkZHIsIHJkZXYtPnV2ZF9mdy0+ZGF0YSwgcmRl
di0+dXZkX2Z3LT5zaXplKTsKPiArICAgICAgIG1lbWNweV90b2lvKCh2b2lkIF9faW9tZW0gKily
ZGV2LT51dmQuY3B1X2FkZHIsIHJkZXYtPnV2ZF9mdy0+ZGF0YSwgcmRldi0+dXZkX2Z3LT5zaXpl
KTsKPgo+ICAgICAgICAgc2l6ZSA9IHJhZGVvbl9ib19zaXplKHJkZXYtPnV2ZC52Y3B1X2JvKTsK
PiAgICAgICAgIHNpemUgLT0gcmRldi0+dXZkX2Z3LT5zaXplOwo+IEBAIC0yOTYsNyArMjk2LDcg
QEAgaW50IHJhZGVvbl91dmRfcmVzdW1lKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQo+ICAg
ICAgICAgcHRyID0gcmRldi0+dXZkLmNwdV9hZGRyOwo+ICAgICAgICAgcHRyICs9IHJkZXYtPnV2
ZF9mdy0+c2l6ZTsKPgo+IC0gICAgICAgbWVtc2V0KHB0ciwgMCwgc2l6ZSk7Cj4gKyAgICAgICBt
ZW1zZXRfaW8oKHZvaWQgX19pb21lbSAqKXB0ciwgMCwgc2l6ZSk7Cj4KPiAgICAgICAgIHJldHVy
biAwOwo+ICB9Cj4gLS0KPiAyLjMxLjEKPgo+Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
