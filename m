Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C35C3A5A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED7D206F6
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp8Y7lB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED7D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD436E5CA;
	Mon, 20 Apr 2020 15:30:26 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8D16E5CA;
 Mon, 20 Apr 2020 15:30:25 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id s10so3569942wrr.0;
 Mon, 20 Apr 2020 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PD5DeOdqi6e0MkxPAfwdJyP3eDR+86tLjrIumXPzzT4=;
 b=bp8Y7lB6hXvn9JH54tFD2UDbpwmiblTLlKAIT3+DCmvZle1bg3aC3vYn1nqOyiR5OY
 HgL3OGsbeJva2GrenO/QQ9jEXf99AjvliEDPB66I7Q3lm0BMgokvt7k9nT4P1r6k8aCn
 5PLeAowMTscry4PrfawUrthTM4pC+ndE/nZL5Zv9YlQ0cyO1KWbw11HmyXClk5QiMx+G
 1A+0vJ5x/0My02ge4tzFk8os5rcxhHmpPqt88QASYX3j7OJFqLDkeX20CT4Ald8jIsYD
 jUITLIwrB69buHlkbfNn8nJX2dyIUQkrPgAK9AToP92RpJSZ0C5ftuPFuOyAtZ5ipn3C
 ralw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PD5DeOdqi6e0MkxPAfwdJyP3eDR+86tLjrIumXPzzT4=;
 b=XsFhJEUrHUbPHgYvaDcFM98G3jZp7kw5MFUxnwEAqzb2p4zz5akTOz5AC8QJ/pJRRP
 hCiCrMRLtd+hBgan0YkabcnTC5MExCkOs/xD6yHDspg0E6oa1nkZwY1bM309qTI1I1dj
 NuKwAD8TGWzBgQqDM/bgBpgYwzhl1x3T5ZXOappANoygTk2l7FK2qkcl6khi/TI/7BGX
 hQ9HfeynFBNDL8f7AIpdRXyuybvB5uxqA3EHSz99eD104GQi4GsQ1jtfMUhoUVDTBILh
 IcDi9DgrwWQ26+Auoh1jlmYa2llzT0yGHbLpkoz6bNpCASnu79ngFA+cowtGPWhwq3bd
 SMFQ==
X-Gm-Message-State: AGi0PuZYSSNKz/wPtYp7JI4igOyb0LuGGt4rf6KR6rpL5RhpHsXtvgsZ
 /T2zWiW5hio3j6FdlcaLjlaRZ5tz7lbDa/25UMg4DGuV
X-Google-Smtp-Source: APiQypJNVGW7y4CcAc7fYlBuLAQtsl07x5NtoSods0LPEQbSJ1ymdgu97+hTSGZ3nDodKZ90UfA1dTb1tUYmxNTUDzs=
X-Received: by 2002:a5d:498d:: with SMTP id r13mr20138167wrq.374.1587396623955; 
 Mon, 20 Apr 2020 08:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN=SNp7Ub3KHmsGrg+5R1g13HMea2+Jw+hTer3g74q21Q@mail.gmail.com>
 <4a9ae285-f126-c83b-b55f-36bd7a4403a0@gmail.com>
 <CABXGCsNSni7cjufva_n-VZQ4HKY2osBL4JB2kk_z7Pzv2u10MQ@mail.gmail.com>
In-Reply-To: <CABXGCsNSni7cjufva_n-VZQ4HKY2osBL4JB2kk_z7Pzv2u10MQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Apr 2020 11:30:12 -0400
Message-ID: <CADnq5_NXtSfn1C8kceQ_Bfmu9LbgRTPVq_s6yk-6BG23ZB10Qg@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 0000000000000026
 after switching to 5.7 kernel
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU2F0LCBBcHIgMTgsIDIwMjAgYXQgNzoxMyBBTSBNaWtoYWlsIEdhdnJpbG92CjxtaWtoYWls
LnYuZ2F2cmlsb3ZAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFNhdCwgMTEgQXByIDIwMjAgYXQg
MTQ6NTYsIENocmlzdGlhbiBLw7ZuaWcKPiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5j
b20+IHdyb3RlOgo+ID4KPiA+IFllYWgsIHRoYXQgaXMgYSBrbm93biBpc3N1ZS4KPiA+Cj4gPiBZ
b3UgY291bGQgdHJ5IHRoZSBhdHRhY2hlZCBwYXRjaCwgYnV0IHBsZWFzZSBiZSBhd2FyZSB0aGF0
IGl0IGlzIG5vdAo+ID4gZXZlbiBjb21waWxlIHRlc3RlZCBiZWNhdXNlIG9mIHRoZSBFYXN0ZXIg
aG9saWRheXMgaGVyZS4KPiA+Cj4KPiBMb29rcyBnb29kIHRvIG1lLCBzbyBpdCdzIHBpdHkgdGhh
dCB0aGlzIHBhdGNoIGRpZCBub3QgZXhpc3QgaW4gdGhlCj4gcHVsbCByZXF1ZXN0IGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE0OTIwODMvCgpJdCBzaG91bGQgc2hvdyB1cCBp
biB0aGUgbmV4dCBkcm0tbWlzYyBQUjoKaHR0cHM6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9kcm0v
ZHJtLW1pc2MvY29tbWl0Lz9oPWRybS1taXNjLWZpeGVzJmlkPTg2MjNiNTI1NWFlN2NjYWYyNzZh
YWMzOTIwNzg3YmY1NzVmYTZiMzcKCkFsZXgKCj4KPiAtLQo+IEJlc3QgUmVnYXJkcywKPiBNaWtl
IEdhdnJpbG92Lgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
