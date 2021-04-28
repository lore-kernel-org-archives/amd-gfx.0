Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6398C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 14:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567B56100B
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 14:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567B56100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C416F6E21D;
	Wed, 28 Apr 2021 14:13:45 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B866E21D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 14:13:44 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 65-20020a9d03470000b02902808b4aec6dso53693521otv.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UQ24cfdbS49ZBVir7rdSWYkJgQHp09bzLZPRxE/y7RQ=;
 b=K3LtzWOJrfzeyxnHD+LscQw+/utAnncjC4zyBheRjZ/SyQHFcR+MtGLTTquTwxpUEv
 +kOePceMuX5867q+N3PoZTohCn7PU6QxdlQGWeGh8f96kPNyvKFED29HrjiOEhfpYZGG
 IFpvGEQyA6pCYFO4mtbmdie8bi8DWAtu35U1GI909ojEWLc3Xr2lAUd0kchFQ8f5myn1
 L1FreX5No31vy22/mJLB2fwzjyyLylRcSiEKAdYe1naZ2a0BHjV9zb1h+DvJGbtfIYY+
 66guoB75EoUEOXWcb+swMbGUdSoh1el1GVZKpHMCPZnMS807FiopDFWbhys5ySylwMHX
 Cggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UQ24cfdbS49ZBVir7rdSWYkJgQHp09bzLZPRxE/y7RQ=;
 b=In1swQA1FpbcuNSgHiFUrWoGZK/UuTg0YT+9ORm+JW52HKeiJlhRFQHRGc2z5RyyB8
 vvblrYrx3CKkM4Ugwc+2bdfp0HM34N0w6T6BWq/ZRlXwDk0BLmXhjEWC22cQMQOe9Pr9
 ExkEqG3xLTwwbS2YWD1rm5pqqfnYzdSxcD9UZo3BMWDFwd/hO7C27Q/vIV8P8anFnYe2
 GqG+cgwFll85K6u06wbTiR5H6VBKqmlQ/Om243ZFO2oBkYyNXiEq8jQHqdNSQMu90BE4
 V82s6K06g/EPnpeIsheQROCetao7KEd46JmODyMb4+hhbAmEs5Ud1RWyHx2EXYDMug0w
 3fUg==
X-Gm-Message-State: AOAM532ni4+epltjU/jfbf8+iScz8qxA/0WqXV/s6QQ67SwKyxrppOgL
 A6Ybo+eutK/U20la3jZ0LVz+qKuktedAE5jEafs=
X-Google-Smtp-Source: ABdhPJwdj/rpJ2rVtkNXBUbrZtx/WoY7WVzVkCp9TKi7Jtrb07IBUEqF/2Jv+y0Up3Wsz1gWQJAsX4bS0PRYQe56IdE=
X-Received: by 2002:a05:6830:18d0:: with SMTP id
 v16mr10387818ote.311.1619619222143; 
 Wed, 28 Apr 2021 07:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <0CFB0C48-3A23-4BDB-AD15-DEC9E348EC58@me.com>
In-Reply-To: <0CFB0C48-3A23-4BDB-AD15-DEC9E348EC58@me.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Apr 2021 10:13:31 -0400
Message-ID: <CADnq5_MAmc0s9pp27uSFTDSYWsiHrgEBzANMvPjgjXnaV_g9+Q@mail.gmail.com>
Subject: Re: VEGA 20 (Aka Vega12)
To: Rodrigo Luglio <rodrigo.luglio@me.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBBcHIgMjgsIDIwMjEgYXQgMTA6MTIgQU0gUm9kcmlnbyBMdWdsaW8gPHJvZHJpZ28u
bHVnbGlvQG1lLmNvbT4gd3JvdGU6Cj4KPiBJIGhhdmUgYSBtYWNib29rIHBybyB3aXRoIHZlZ2Eg
MjAgd2hpY2ggdXNlcyB0aGUgYW1kZ3B1IGZpcm13YXJlIHZlZ2ExMiBhbmQgd2hlbiBpIGJvb3Qg
YW55IGRpc3RybyB0aGUgZ3JhcGhpY3MgZ2xpdGNoIGFuZCB0aGUgY29tcHV0ZXIgZnJlZXplcy4g
SWYgaSBpbnN0YWxsIGFtZGdwdSBwcm8gb24gdWJ1bnR1IGl0IHdvcmtzIGZsYXdsZXNzbHkuIFdv
dWxkIHlvdSBndXlzIGhlbHAgbWUgZGVidWcgdGhpcyBhbmQgZml4IGZvciB1cHN0cmVhbT8KPgo+
Cj4gUGxlYXNlLCBsZXQgbWUga25vdyB3aGljaCBraW5kIG9mIGxvZ3MgYW5kIGluZm9ybWF0aW9u
IEkgY2FuIGF0dGFjaCBpbiBvcmRlciB0byBzdGFydCBkZWJ1Z2dpbmcgdGhpcyBpc3N1ZS4gSeKA
mWxsIGJlIG1vcmUgdGhhbiBoYXBweSB0byBiZSBwYXJ0IG9mIGl0IQo+CgpQbGVhc2UgcHJvdmlk
ZSB0aGUgcmVxdWVzdGVkIGluZm8gb24gdGhlIGJ1ZyByZXBvcnRzLgoKQWxleAoKCj4gQnJpZWYg
c3VtbWFyeSBvZiB0aGUgcHJvYmxlbToKPgo+IEkgaGF2ZSBhIG1hY2Jvb2sgcHJvIHdpdGggdmVn
YSAyMCB3aGljaCB1c2VzIHRoZSBhbWRncHUgZmlybXdhcmUgdmVnYTEyIGFuZCB3aGVuIGkgYm9v
dCBhbnkgZGlzdHJvIHRoZSBncmFwaGljcyBnbGl0Y2ggYW5kIHRoZSBjb21wdXRlciBmcmVlemVz
LiBJZiBpIGluc3RhbGwgYW1kZ3B1IHBybyBvbiB1YnVudHUgaXQgd29ya3MgZmxhd2xlc3NseS4g
V291bGQgeW91IGd1eXMgaGVscCBtZSBkZWJ1ZyB0aGlzIGFuZCBmaXggZm9yIHVwc3RyZWFtPwo+
Cj4gUGxlYXNlLCBsZXQgbWUga25vdyB3aGljaCBraW5kIG9mIGxvZ3MgYW5kIGluZm9ybWF0aW9u
IEkgY2FuIGF0dGFjaCBpbiBvcmRlciB0byBzdGFydCBkZWJ1Z2dpbmcgdGhpcyBpc3N1ZS4gSeKA
mWxsIGJlIG1vcmUgdGhhbiBoYXBweSB0byBiZSBwYXJ0IG9mIGl0IQo+Cj4gSGFyZHdhcmUgZGVz
Y3JpcHRpb246Cj4KPiBDUFU6IDIsNCBHSHogOC1Db3JlIEludGVsIENvcmUgaTkKPiBHUFU6IFJh
ZGVvbiBQcm8gVmVnYSAyMCA0IEdCIFJhZGVvbiBQcm8gVmVnYSAyMDoKPgo+IENoaXBzZXQgTW9k
ZWw6IFJhZGVvbiBQcm8gVmVnYSAyMCBUeXBlOiBHUFUgQnVzOiBQQ0llIFBDSWUgTGFuZSBXaWR0
aDogeDggVlJBTSAoVG90YWwpOiA0IEdCIFZlbmRvcjogQU1EICgweDEwMDIpIERldmljZSBJRDog
MHg2OWFmIFJldmlzaW9uIElEOiAweDAwYzAgUk9NIFJldmlzaW9uOiAxMTMtRDIwNjBJLTA4NyBW
QklPUyBWZXJzaW9uOiAxMTMtRDIwNjAxTUEwVC0wMTYgT3B0aW9uIFJPTSBWZXJzaW9uOiAxMTMt
RDIwNjAxTUEwVC0wMTYgRUZJIERyaXZlciBWZXJzaW9uOiAwMS4wMS4wODcgQXV0b21hdGljIEdy
YXBoaWNzIFN3aXRjaGluZzogU3VwcG9ydGVkIGdNdXggVmVyc2lvbjogNS4wLjAKPgo+IFN5c3Rl
bSBNZW1vcnk6IDMyIEdCIDI0MDAgTUh6IEREUjQKPgo+IERpc3BsYXkocyk6IENvbG9yIExDRDog
RGlzcGxheSBUeXBlOiBCdWlsdC1JbiBSZXRpbmEgTENEIFJlc29sdXRpb246IDI4ODAgeCAxODAw
IFJldGluYSBGcmFtZWJ1ZmZlciBEZXB0aDogMzAtQml0IENvbG9yIChBUkdCMjEwMTAxMCkgTWFp
biBEaXNwbGF5OiBZZXMgTWlycm9yOiBPZmYgT25saW5lOiBZZXMgQXV0b21hdGljYWxseSBBZGp1
c3QgQnJpZ2h0bmVzczogWWVzIENvbm5lY3Rpb24gVHlwZTogSW50ZXJuYWwKPgo+IFR5cGUgb2Yg
RGlwbGF5IENvbm5lY3Rpb246IEludGVybmFsCj4KPiBTeXN0ZW0gaW5mb3JtYXRpb246Cj4KPiBE
aXN0cm8gbmFtZSBhbmQgVmVyc2lvbjogQW55IGRpc3Rybwo+IEtlcm5lbCB2ZXJzaW9uOiBBbnkg
a2VybmVsIHVwIHRvIDUuMTIKPiBDdXN0b20ga2VybmVsOgo+IEFNRCBwYWNrYWdlIHZlcnNpb246
IE5vIHBhY2thZ2UKPgo+IEhvdyB0byByZXByb2R1Y2UgdGhlIGlzc3VlOgo+Cj4gQm9vdCBpbnRv
IGFueSBkaXN0cm8gYW5kIHRoZSBzY3JlZW4gZ2xpdGNoIGFuZCB0aGUgY29tcHV0ZXIgZnJlZXpl
cyBTb21ldGltZXMgaXQgdGFrZXMgbGlrZSA1IG9yIDYgc2Vjb25kcyBiZWZvcmUgaXQgZ2xpdGNo
IGFuZCBmcmVlemUuCj4KPiBBdHRhY2hlZCBmaWxlczoKPgo+IFBsZWFzZSwgbGV0IG1lIGtub3cg
aG93IGNhbiBJIGdldCB1c2VmdWwgbG9ncywgc29tZXRpbWVzIElgbSBhYmxlIHRvIG9wZW4gYW5v
dGhlciB0dHkgYW5kIHJ1biBzb21lIGNvbW1hbmRzLgo+Cj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
