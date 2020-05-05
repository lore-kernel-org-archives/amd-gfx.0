Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9293C47247
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 15:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84C3206B9
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 15:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="N+27bzh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84C3206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6275F6E7D7;
	Tue,  5 May 2020 15:40:45 +0000 (UTC)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE43B6E7D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 15:40:13 +0000 (UTC)
Received: by mail-pj1-x1042.google.com with SMTP id a5so1322473pjh.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2020 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bSFaPsY9Q06ol7z3I9i5NZy6Mx1BYRJOSiQQ/ADJ9Gg=;
 b=N+27bzh+IMZfcRnh55NZgeIVBEml3gus4hp7iFUF6zcjpxNRyptB9OdCDWaJewid8l
 zzggysGdilyS219iat2RsDVXdStYATE8skmp1BvkxX5T9jRUe2HsvL7E8uFvItikAObz
 b9gwPB/r+co6aVYZdf0ShOVytK37AWhko/qoZYFNboprhcDhWsLbd8cCM/IIjsTSpz0l
 f0N33fSctiP/mSHFqqUFrW/2BkUX+VQR/hx6ChD1Nv4YIqbI+uTvDE1JGGvhyFc4EI5/
 crIBcVXx9W3f0frtN+DBlHtDkiDZWz/viDcRZu+ychATsekTG9x5kHtynjiBy6DeCqjM
 owQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bSFaPsY9Q06ol7z3I9i5NZy6Mx1BYRJOSiQQ/ADJ9Gg=;
 b=SAAMn6ULJjF9sS1ULapo9BbnH7sb1wMp3Vs4ZjUu/ECTx5ygVDRXMTYaG7mPo+aQ8b
 PAeFz2KR9GTKVr9HIC8kh/n0vGUEUgAwVg8j8fTih6aEwCBv2g0Xvvj6qVFvmQ2wSZEs
 1WfUc9dDF+PV0txJzpE22owm7EARwcoPblcNoSeoLfiLirlQzQAZWmyXE2GErwxTm9QO
 mqFep+7Tu3GeZvFbU6wN1Ep2heagkzSKM7GuwDKETf6x0dv7B47n6PlhTn1GTem9Q6mB
 C+beJN+6a4iYFqojXNYxrwnKXHl2NT+90QvdMx//fupMk9hT9g0BoEQij1Bi/V1uosjk
 clXQ==
X-Gm-Message-State: AGi0PuaUs459E9a45CiFTdePN7nvGOAt4Z2dKR1wtLoMDMwVE/HChveS
 MxT7PjoeSX1r0kQqVpivxGwSu70euVza0+BJWHMj2w==
X-Google-Smtp-Source: APiQypJk7WFBLwQNHlWpEpX+GDFUCZgtHUU8RxuEIsH3h6aMqRYcSuecN1kdds/zND2KUHypdFOJyiF/OToVqwLaK+A=
X-Received: by 2002:a17:90a:8c85:: with SMTP id
 b5mr3737036pjo.187.1588693212806; 
 Tue, 05 May 2020 08:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200505141606.837164-1-arnd@arndb.de>
 <e4a852b2-807b-bc73-7328-bcc399341085@amd.com>
In-Reply-To: <e4a852b2-807b-bc73-7328-bcc399341085@amd.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 5 May 2020 08:39:59 -0700
Message-ID: <CAKwvOd=JLsksy5adE_rnRKetqAMcSFsJPHXVsidOP9RPo+YpCA@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: fix integer overflow on 32-bit architectures
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailman-Approved-At: Tue, 05 May 2020 15:40:43 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, David Airlie <airlied@linux.ie>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Kent Russell <kent.russell@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>, Evan Quan <evan.quan@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VlIGFsc28gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQURucTVfTmR0Wmg1X1JHRFdL
SjljXzQyWEx2cm5jQ3M1RERVMVlTcHRmWlA5NEtYa1FAbWFpbC5nbWFpbC5jb20vVC8jbWU3MDdl
MDllOTJjNmU0ODcyODVlOGJiMzgyYTYwN2U0ZTc4MmMyNDkKCk9uIFR1ZSwgTWF5IDUsIDIwMjAg
YXQgNzoxNyBBTSBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IHdy
b3RlOgo+Cj4gQW0gMDUuMDUuMjAgdW0gMTY6MTUgc2NocmllYiBBcm5kIEJlcmdtYW5uOgo+ID4g
TXVsdGlwbHlpbmcgMTAwMDAwMDAwMCBieSBmb3VyIG92ZXJydW5zIGEgJ2xvbmcnIHZhcmlhYmxl
LCBhcyBjbGFuZwo+ID4gcG9pbnRzIG91dDoKPiA+Cj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmM6NDE2MDo1MzogZXJyb3I6IG92ZXJmbG93IGluIGV4cHJlc3Np
b247IHJlc3VsdCBpcyAtMjk0OTY3Mjk2IHdpdGggdHlwZSAnbG9uZycgWy1XZXJyb3IsLVdpbnRl
Z2VyLW92ZXJmbG93XQo+ID4gICAgICAgICAgICAgICAgICBleHBpcmVzID0ga3RpbWVfZ2V0X21v
bm9fZmFzdF9ucygpICsgTlNFQ19QRVJfU0VDICogNEw7Cj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+ID4gTWFr
ZSB0aGlzIGEgJ2xvbmcgbG9uZycgY29uc3RhbnQgaW5zdGVhZC4KPiA+Cj4gPiBGaXhlczogM2Yx
MmFjYzhkNmQ0ICgiZHJtL2FtZGdwdTogcHV0IHRoZSBhdWRpbyBjb2RlYyBpbnRvIHN1c3BlbmQg
c3RhdGUgYmVmb3JlIGdwdSByZXNldCBWMyIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPgo+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgo+ID4gLS0tCj4gPiBJJ20gbm90IHN1cmUgdGhlIGt0
aW1lX2dldF9tb25vX2Zhc3RfbnMoKSBjYWxsIGlzIG5lY2Vzc2FyeSBoZXJlCj4gPiBlaXRoZXIu
IElzIGl0IGludGVudGlvbmFsIGJlY2F1c2Uga3RpbWVfZ2V0X25zKCkgZG9lc24ndCB3b3JrCj4g
PiBkdXJpbmcgYSBkcml2ZXIgc3VzcGVuZCwgb3IganVzdCBhIG1pc3Rha2U/Cj4gPiAtLS0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMiArLQo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gPiBpbmRleCA2Zjkz
YWY5NzJiMGEuLjJlMDdlM2U2YjAzNiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCj4gPiBAQCAtNDE1Nyw3ICs0MTU3LDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfZGV2aWNlX3N1c3BlbmRfZGlzcGxheV9hdWRpbyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiA+ICAgICAgICAgICAgICAgICogdGhlIGF1ZGlvIGNvbnRyb2xsZXIgZGVmYXVs
dCBhdXRvc3VzcGVuZCBkZWxheSBzZXR0aW5nLgo+ID4gICAgICAgICAgICAgICAgKiA0UyB1c2Vk
IGhlcmUgaXMgZ3VhcmFudGVlZCB0byBjb3ZlciB0aGF0Lgo+ID4gICAgICAgICAgICAgICAgKi8K
PiA+IC0gICAgICAgICAgICAgZXhwaXJlcyA9IGt0aW1lX2dldF9tb25vX2Zhc3RfbnMoKSArIE5T
RUNfUEVSX1NFQyAqIDRMOwo+ID4gKyAgICAgICAgICAgICBleHBpcmVzID0ga3RpbWVfZ2V0X21v
bm9fZmFzdF9ucygpICsgTlNFQ19QRVJfU0VDICogNExMOwo+ID4KPiA+ICAgICAgIHdoaWxlICgh
cG1fcnVudGltZV9zdGF0dXNfc3VzcGVuZGVkKCYocC0+ZGV2KSkpIHsKPiA+ICAgICAgICAgICAg
ICAgaWYgKCFwbV9ydW50aW1lX3N1c3BlbmQoJihwLT5kZXYpKSkKPgo+IC0tCj4gWW91IHJlY2Vp
dmVkIHRoaXMgbWVzc2FnZSBiZWNhdXNlIHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0aGUgR29vZ2xl
IEdyb3VwcyAiQ2xhbmcgQnVpbHQgTGludXgiIGdyb3VwLgo+IFRvIHVuc3Vic2NyaWJlIGZyb20g
dGhpcyBncm91cCBhbmQgc3RvcCByZWNlaXZpbmcgZW1haWxzIGZyb20gaXQsIHNlbmQgYW4gZW1h
aWwgdG8gY2xhbmctYnVpbHQtbGludXgrdW5zdWJzY3JpYmVAZ29vZ2xlZ3JvdXBzLmNvbS4KPiBU
byB2aWV3IHRoaXMgZGlzY3Vzc2lvbiBvbiB0aGUgd2ViIHZpc2l0IGh0dHBzOi8vZ3JvdXBzLmdv
b2dsZS5jb20vZC9tc2dpZC9jbGFuZy1idWlsdC1saW51eC9lNGE4NTJiMi04MDdiLWJjNzMtNzMy
OC1iY2MzOTkzNDEwODUlNDBhbWQuY29tLgoKCgotLSAKVGhhbmtzLAp+TmljayBEZXNhdWxuaWVy
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
