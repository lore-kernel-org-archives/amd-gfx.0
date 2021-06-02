Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7383C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A293E61948
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A293E61948
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CE66EA7F;
	Wed,  2 Jun 2021 16:21:43 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886D16EA7F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:21:41 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 i12-20020a05683033ecb02903346fa0f74dso2912567otu.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QEPAaOMQzjNVAJ9kZCOVgR2vxr7NZTXtAD4sssmW9XA=;
 b=ojceZHGBBeDgp6luR7dj/sWvP/haupf01ScxA06y5hT/e0rkUNvYm2h0GMYgLOP4n3
 P4+Io6XoUajZOzlUD7lJE9rFfSn3pC26U5Mc1rl0pSKYtxVkUWaBC8y/JO4eCN8/pOTy
 gFOS+LDU80sGWwFvZI3oPykD2UXpYVudap4iukwaF8gNOGFROJXBOAUU5ClmpDSu+xgT
 KLY3d7eye0VQZrV51c5ln9tKjRK06g0EZUiZs7uUzxzJNOPgYGUrxp8KpLU+DcN3tvx4
 7/7NS901+r5zK0yuCl7cY9D2mel0gvIqNgjfCCYrPojEbaIuGaJZltmUAO6zt7PB4tnP
 jIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QEPAaOMQzjNVAJ9kZCOVgR2vxr7NZTXtAD4sssmW9XA=;
 b=HdNbTER/aLv06EK6GYz/o15uoR64AamJ18l24crQjrbZILtKJAGhP4xM0sPZMVVUcv
 cUVasbs2MXUXT9GCRrieV0CBtJcOqaiDgXFuw/6CnzcXzKFSq3zR55Q1NCcCIpoiD8p2
 f9W+T/LzNkmzyrzvrBEezA6kTfo7JQUY3MWEJB+YZj1Ebv5zDoSrX7CrYUGdDo1Yl82s
 katgOgPZwrBXuX3nnsFomvSlLw5BckfvwVds49iKsjvpMpjUIXwFi4VmW84Vx7h2j9L3
 inojP4RQhygORjjwMHkATIQ05MxOkVtBB8EQjn99GgAwVo2QINGqIWFHqib2P5xcihLl
 eFXw==
X-Gm-Message-State: AOAM5323RlBB9WhGp1PPMCCRnZMpGIotQGQGW7PGwiM59HM0AhiiPStq
 zU8wmNKancoS36ZpESUwlDR8+T+jbQMs/9CMzWE=
X-Google-Smtp-Source: ABdhPJzKtxXUE1d/9qIn63974f1ENgY2rt8nwyieHTT+XrvvXUHsU6xQiV1+6O+ZZ3Hsos1I6qu/+7IGjV+PAsKXGIw=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr27461396otl.132.1622650900723; 
 Wed, 02 Jun 2021 09:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210602095305.41936-1-michel@daenzer.net>
 <1cb79c0b-63f4-777d-29f3-552987aeb790@gmail.com>
 <CAC0gqY4iO3kXq_6zafWnfQehXCgzPLhzmuJ3qSnC-nSnw0MGHQ@mail.gmail.com>
 <CAJUqKUq8oshLvTaLfz6mR4qYY_B7RedXCqqOu56nG7rB6vYBRw@mail.gmail.com>
In-Reply-To: <CAJUqKUq8oshLvTaLfz6mR4qYY_B7RedXCqqOu56nG7rB6vYBRw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Jun 2021 12:21:29 -0400
Message-ID: <CADnq5_MoB7F0u719DR7Ho_wmXM6FmxA5yRwYchES_rMQOg7TYQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use drm_dbg_kms for reporting failure to get
 a GEM FB
To: Mark Yacoub <markyacoub@chromium.org>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFdlZCwgSnVuIDIsIDIwMjEgYXQgMTA6NTYgQU0g
TWFyayBZYWNvdWIgPG1hcmt5YWNvdWJAY2hyb21pdW0ub3JnPiB3cm90ZToKPgo+IGxndG0uIFRo
YW5rcyEKPgo+ID4gT24gV2VkLCBKdW4gMiwgMjAyMSBhdCA1OjU2IEFNIENocmlzdGlhbiBLw7Zu
aWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPiA+Pgo+ID4+Cj4g
Pj4KPiA+PiBBbSAwMi4wNi4yMSB1bSAxMTo1MyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+ID4+
ID4gRnJvbTogTWljaGVsIETDpG56ZXIgPG1kYWVuemVyQHJlZGhhdC5jb20+Cj4gPj4gPgo+ID4+
ID4gZHJtX2VyciBtZWFudCBicm9rZW4gdXNlciBzcGFjZSBjb3VsZCBzcGFtIGRtZXNnLgo+ID4+
ID4KPiA+PiA+IEZpeGVzOiBmMjU4OTA3ZmRkODM1ZSAiZHJtL2FtZGdwdTogVmVyaWZ5IGJvIHNp
emUgY2FuIGZpdCBmcmFtZWJ1ZmZlcgo+ID4+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc2l6
ZSBvbiBpbml0LiIKPiA+PiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtZGFlbnpl
ckByZWRoYXQuY29tPgo+ID4+Cj4gPj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiA+Pgo+ID4+ID4gLS0tCj4gPj4gPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgfCA0ICsrLS0KPiA+PiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+PiA+Cj4gPj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXku
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMKPiA+PiA+IGlu
ZGV4IDgxNzBlMjRjZTM3ZC4uMmE0Y2Q3ZDM3N2JmIDEwMDY0NAo+ID4+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+ID4+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+ID4+ID4gQEAgLTEwNTgsNyAr
MTA1OCw3IEBAIGludCBhbWRncHVfZGlzcGxheV9nZW1fZmJfaW5pdChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2LAo+ID4+ID4KPiA+PiA+ICAgICAgIHJldHVybiAwOwo+ID4+ID4gICBlcnI6Cj4gPj4g
PiAtICAgICBkcm1fZXJyKGRldiwgIkZhaWxlZCB0byBpbml0IGdlbSBmYjogJWRcbiIsIHJldCk7
Cj4gPj4gPiArICAgICBkcm1fZGJnX2ttcyhkZXYsICJGYWlsZWQgdG8gaW5pdCBnZW0gZmI6ICVk
XG4iLCByZXQpOwo+ID4+ID4gICAgICAgcmZiLT5iYXNlLm9ialswXSA9IE5VTEw7Cj4gPj4gPiAg
ICAgICByZXR1cm4gcmV0Owo+ID4+ID4gICB9Cj4gPj4gPiBAQCAtMTA5Niw3ICsxMDk2LDcgQEAg
aW50IGFtZGdwdV9kaXNwbGF5X2dlbV9mYl92ZXJpZnlfYW5kX2luaXQoCj4gPj4gPgo+ID4+ID4g
ICAgICAgcmV0dXJuIDA7Cj4gPj4gPiAgIGVycjoKPiA+PiA+IC0gICAgIGRybV9lcnIoZGV2LCAi
RmFpbGVkIHRvIHZlcmlmeSBhbmQgaW5pdCBnZW0gZmI6ICVkXG4iLCByZXQpOwo+ID4+ID4gKyAg
ICAgZHJtX2RiZ19rbXMoZGV2LCAiRmFpbGVkIHRvIHZlcmlmeSBhbmQgaW5pdCBnZW0gZmI6ICVk
XG4iLCByZXQpOwo+ID4+ID4gICAgICAgcmZiLT5iYXNlLm9ialswXSA9IE5VTEw7Cj4gPj4gPiAg
ICAgICByZXR1cm4gcmV0Owo+ID4+ID4gICB9Cj4gPj4KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
