Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C43CA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 13:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E842087E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 13:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E842087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E1A6E395;
	Tue, 29 Oct 2019 13:43:13 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB5F6E395
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 13:43:11 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id n15so13671967wrw.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 06:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DrHdg6L2Z1EIbpG2fN1F3wszQxFCA8/Fk9WV8tqk/cA=;
 b=nyXU/aAEGgw6syXTty5YMP4YA+C8G3WpxM4MwMv5EwrpqWPCm99imJFQGkAYqlziJH
 d54cosxyeH/xRR6Y4n6JFlNtfEa7hMV3z/FITBX5Ds7jzN4MW+aDnoKZmir1hN7BeU9i
 nnX+3/Qj1W6Dbb25sZTI75Mnki2ZEUmf6j8T9u5MmxmSdYIqYtvmfveVVbn9x2bziXVr
 iLA7E+cLoqHEHXI/Y6L02EzxKiVWnfcmRm6spj9+oLO7vYYsMn83cX1qRMvRY/wJKDw5
 kG2/HJeEK1jvzP4TberhLRwaWVlUnUEY0A6YCT6DC490je3VSO9MFfUXeigTzJ9PpdQY
 WNcg==
X-Gm-Message-State: APjAAAUJDuLqTurjsLX08nN85NT86Tv60rs8h1l58248BEHOE3HbNFfw
 tpJf0SbyqczcywSINufsutjEIY8R3mSIEflMrk4=
X-Google-Smtp-Source: APXvYqyqTKyRZSouyoJhs52KTbYSNWJ5ZdE/+JPesZcfGcvTjP2djbo+3oB+H/J/BmL+siVqTuE7XIGcFX8xFUB6UzY=
X-Received: by 2002:adf:9bdc:: with SMTP id e28mr19043212wrc.309.1572356590346; 
 Tue, 29 Oct 2019 06:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHL+j0_2ir=8hHDoyqizweOUSV6XfqC-UCD15WuJ9vvptNLr0g@mail.gmail.com>
 <CADnq5_N0r8O2vQapGaary0L-OfdTdz-ezcMJK90+Gy2sPujYcw@mail.gmail.com>
 <CAHL+j08qsu1pSOZPLB9-XWw9ZmT2OamaWPBJV4T3Vzx_C8cD7g@mail.gmail.com>
 <67658520-b3f4-d2f9-7247-dd434ab5c30b@amd.com>
 <CAHL+j0-Nm+6VFXi_w4iciNdG40zubpqvh1RXs3MFfXJK2mFr0Q@mail.gmail.com>
 <CAHL+j0_=r1XBOzwiQmbZTVoRsZ5=Du3pAPd_n7pia81FegdHhw@mail.gmail.com>
 <57826a9e-5842-4ddd-a456-67d1d1b9a9ce@amd.com>
 <CAHL+j0-NJ8F4RpMJ5m9_9gk_t+zhwFwVmG6MMy4TBYa4XjnWEA@mail.gmail.com>
 <CADnq5_MTYe5z0gbtY0eCnUax2D=HZYBQF7YWPS86pikDXGVWOA@mail.gmail.com>
 <CAHL+j0_Dn9VZ7CN-yaaFP4kk39gWTKu4fLZ6SN4Dj17e2z+4RQ@mail.gmail.com>
 <CAHL+j08BgqmOoQHnsfE3xtZFsz14cOZ=Xui3o7mENJd3Fq0z0g@mail.gmail.com>
 <CAHL+j0-E83G4+xYDcJ2xB2abF9DXA78CXfP9LrVVktTmvsBYvg@mail.gmail.com>
 <CAHL+j0-D=AX7==2RRTXDaKEQwid8x817XO-upaDmCemMpvEF6Q@mail.gmail.com>
 <CADnq5_OL2ra6k8HHnAc=2Zp=bkKA6pLmGDacS3V+6RYHPgwtjg@mail.gmail.com>
In-Reply-To: <CADnq5_OL2ra6k8HHnAc=2Zp=bkKA6pLmGDacS3V+6RYHPgwtjg@mail.gmail.com>
From: Sylvain Munaut <246tnt@gmail.com>
Date: Tue, 29 Oct 2019 14:43:29 +0100
Message-ID:
 <CAHL+j09M_6Z8A9zrZkq_Ax=w3aTLanzPEH-GFZ+umESxENCSUg@mail.gmail.com>
Subject: Re: Spontaneous reboots when using RX 560
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=DrHdg6L2Z1EIbpG2fN1F3wszQxFCA8/Fk9WV8tqk/cA=;
 b=haD4uOvHGfd6wEEq4RF9OqW8q0Xq6KjKKpHncnpoEgxxczBoxBgSJ+uzTygNwkI3zf
 3gc+Gl5LWjsM0QuvHugVtL4NNFnWGbCm9Mr891pgKpeRNiPV45wwK2fd1/MicfIMBOPi
 bWdmkHq74IfZSsL6vuHCeU8zQwP4gR+DY4bJlwksSWnCQ2Uqnw2kh1LaAL/MjpSiUmUA
 /PWM1RbKkymfBhxjNJU/3LgtPXTY/jZAoLz4mT3T5b5ErAflx9P4xbf+QYGowBSDw99D
 7EpXkNXKiHAldKBgCudD6kD9E4oPFB5iy/WDvNC3qeNwno2xQgRodPnm6MeFQh0hglML
 Z9Ow==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029134329.aOWP-C5tRxlmsGLJRF-NwMOnoXlfiojKV78GGUXRabk@z>

SGkgQWxleCwKCj4gQ2FuIHlvdSBzZW5kIG1lIGEgY29weSBvZiB0aGUgdmJpb3MgZnJvbSB0aGF0
IGJvYXJkPwoKRGlkIHlvdSBnZXQgYSBjaGFuY2UgdG8gbG9vayBhdCB0aGUgYmlvcyBzZWUgaWYg
eW91IGNhbiBmaW5kIGFueXRoaW5nCmludGVyZXN0aW5nIGluIGl0ID8KKEkgZ3Vlc3MgeW91IG5l
ZWQgc29tZSBzcGVjaWFsIHRvb2xzIGZvciB0aGF0LCBJJ20gbm90IHN1cmUgaG93IEknZApmaW5k
IGFueXRoaW5nIGluIHRoZXJlIG15c2VsZikuCgpBZnRlciBhIGNvdXBsZSBvZiBiYWNrIGFuZCBm
b3J0aCB3aXRoIEFzUm9jayBzdXBwb3J0IHRoZXkgYmFzaWNhbGx5Cmp1c3Qgd2FudCBtZSB0byBy
ZXR1cm4gdGhlIGNhcmQgdG8gZ2V0IGFub3RoZXIgb25lIHdoaWNoIEknbSBwcmV0dHkKc3VyZSBp
c24ndCBnb2luZyB0byBhY2NvbXBsaXNoIGFueXRoaW5nIGV4Y2VwdCBmb3Igd2FzdGluZyAxIG9y
IDIKd2Vla3Mgc2hpcHBpbmcgc3R1ZmYgYXJvdW5kIC4uLgoKQ2hlZXJzLAoKICAgIFN5bHZhaW4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
