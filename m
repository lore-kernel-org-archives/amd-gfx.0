Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324D2C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 01:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002912076C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 01:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJOnXyDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002912076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A5489B55;
	Mon, 25 May 2020 01:03:16 +0000 (UTC)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8108689B55
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 01:03:15 +0000 (UTC)
Received: by mail-ot1-x342.google.com with SMTP id d26so12692904otc.7
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 May 2020 18:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FhKOaAqMvcCKlYLLAVgsgnsGIKLop4z8cdHUQcT0LtQ=;
 b=mJOnXyDvPsokBMV4kX34CgFafM0N2G/A5vItyUGcoZcYSHNjdClu8Y/dsLpjvUeAD+
 42uZNyasJH1feFKrHqfYrq6dilaV52HDm0zLtkSgxRIJ2RxuvAygONU1No8S8NaGD+fr
 U2ErG+GUb1lj6ueIC+LnAIsnsE/pNU2E/3WI315XJ5LKJ5j5cZOqVc/aBtGyQxNTPiNO
 yvN7GvSh9hW3JOG/pLFbn9I/BUzbqOaeaTs6e38RbpoA1dPFS0+nWjcJCVjEZSNjdS4k
 lec8/xlIiqGphS+XGutusa9bdaE3ujhj5vadqH7aTCdodIWGV+MoeubBRKg24HMMqqJa
 LxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FhKOaAqMvcCKlYLLAVgsgnsGIKLop4z8cdHUQcT0LtQ=;
 b=F2vJejJ+zuw2lonbSfeo1O1ZjgZl5l3mzfvPBJCDOHCTwI9gANpUqXxN2Fm0XxJP+R
 tbx9toDQihUlsm/KiMxwqB8veeEsBgqEcgC7yh9sZvuKx90IIMLt3z72XGuhXol1nSh1
 AtfVbRRGeFtMMTt8UujbUTdBN2c0I/7P75fZqzrunmOcVpdCeo/LdI1c94A6D/LWcjmH
 YjMBHa23z+3GpYkwR8m3N3ku3hZrkttwBlTIrOmYXbwmpl871qHoqQlpot5eZ1F7S1tx
 +aL0a+ozl3eqPwP5RgCBaImQ7B8dbShPVGwRGC5t4+59+SaCytifQtVkmZsOoKC9bNpG
 rlwg==
X-Gm-Message-State: AOAM532KAC35DTDVRW1Ty8d4tEoQs1w0yVxswe1VNkbH9LwVa2gsMtur
 5nh/8g+BYryrk1oAFKUT0bbgFlB877+a1WVBbI4=
X-Google-Smtp-Source: ABdhPJyuQ0N2o1RgDsGTwZahbbqQlmTkYZepmi8ddaS9dUJfEIU+P3Eoh05G87Jk504JFplIy1cchU7rqfKANBDQqE4=
X-Received: by 2002:a9d:ec3:: with SMTP id 61mr530808otj.286.1590368594485;
 Sun, 24 May 2020 18:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
 <CAEOHGOkbu5jy_1_bUD4H0U89YEc_9zOxsSdyZqmtqZNsdOyDkg@mail.gmail.com>
 <CAEOHGOkRYXZWN-20VagBEFFywRT=26xphP3JQeQD4AJuxxzg+Q@mail.gmail.com>
 <CADnq5_Nc+eoCKsQrHA-u0d7trv=MM=5iKv5G1R3TMCyot40OjA@mail.gmail.com>
 <CAEOHGOk-YO_B3gS7WayrBEAO4oxrUAGtR0o9ZzW8ehOypuc1YA@mail.gmail.com>
 <CADnq5_M2R93S6aQn8XtrC_JdHhB=ajC17D780koNvdnDFbWCpA@mail.gmail.com>
 <CAEOHGO=Tgook7i5R5Ucxn3Pg4ovZe+Fak5rntZ2P+UuwDJ+-Vg@mail.gmail.com>
 <CADnq5_Mef-FCri1_wriYgvmnkTNQpxaUfba9_hLSB-yVQHU9cQ@mail.gmail.com>
 <CAEOHGOm+ooti4JX6OD2zd7rOxbAVn1yQ22TwgS0hmiy8Ssf-Kg@mail.gmail.com>
 <CADnq5_O-u_dX84-=y8itZzsrxGLtboBaT5jPY4izzqSjwVtiqg@mail.gmail.com>
 <CAEOHGOmoyyiOSmTPP21mhavJ-qzgPSnWiLb9VFz4z9aSwao3Aw@mail.gmail.com>
 <CADnq5_P9pBvnHjeTDdcocQi1HnK4d6h-a+gsjpgfZ_zEjpDH3g@mail.gmail.com>
 <CAEOHGOmSDy2LRzexvUwqc8R4D5XWHmOO_r+9uh7To6BaH6ik6g@mail.gmail.com>
 <CAEOHGOkFBatRPaskkYv_c84sf-opOFTAi=j=NPj-qOePtdXYXg@mail.gmail.com>
 <dc6af43c-07bb-e334-79f7-80b4cb5135a8@daenzer.net>
In-Reply-To: <dc6af43c-07bb-e334-79f7-80b4cb5135a8@daenzer.net>
From: Javad Karabi <karabijavad@gmail.com>
Date: Sun, 24 May 2020 20:03:03 -0500
Message-ID: <CAEOHGOnPZgMbD_Rr75x6wnCS2TbeNWvZdTWpv0o57Tbo=2eYzQ@mail.gmail.com>
Subject: Re: slow rx 5600 xt fps
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TWljaGVsLCBhaCBteSBiYWQhIHRoYW5rIHlvdS4gc29ycnksIHRob3VnaHQgaXQgd2FzIG11dHRl
cgoKYWxzbywgb25lIG90aGVyIHRoaW5nLiBzbyBpIGhhdmUgYmVlbiBtZXNzaW5nIGFyb3VuZCB3
aXRoIGFsbCB0eXBlcyBvZgp4b3JnIGNvbmZpZ3VyYXRpb24gYmxhaCBibGFoIGJsYWgsIGJ1dCBp
IGp1c3QgaGFkIGFuIGVwaXBoYW55LCBhbmQgaXQKd29ya3MhCgpzbywgYWxsIGkgZXZlciBuZWVk
ZWQgdG8gZG8gd2FzIGFkZCBPcHRpb24gIlByaW1hcnlHcHUiICJ0cnVlIiB0bwovdXNyL3NoYXJl
L1gxMS94b3JnLmNvbmYuZC8xMC1hbWRncHUuY29uZgp3aXRoIHRoYXQgX29uZV8gY2hhbmdlLCBp
IGRvbnQgbmVlZCBhbnkgb3RoZXIgeG9yZyBjb25maWdzLCBhbmQgd2hlbiBpCmJvb3Qgd2l0aG91
dCB0aGUgYW1kZ3B1LCBpdCBzaG91bGQgd29yayBqdXN0IGZpbmUsIGFuZCB3aGVuIHRoZSBhbWRn
cHUKaXMgcHJlc2VudCBpdCB3aWxsIGF1dG9tYXRpY2FsbHkgYmVjb21lIHRoZSBwcmltYXJ5IGR1
ZSB0byB0aGUKb3V0cHV0Y2xhc3MgbWF0Y2hpbmcgaXQhCgp0aGF0IFByaW1hcnlHcHUgYmVpbmcg
YWRkZWQgd2FzIGV4YWN0bHkgdGhlIHRoaW5nLiBpbSBzbyBnbGFkIGl0IHdvcmtzIG5vdwoKU28s
IHRoZXNlIGFyZSBteSB0aG91Z2h0czoKdGhlcmVzIG5vIHRlbGxpbmcgd2hhdCBvdGhlciBncmFw
aGljcyBjYXJkcyBtaWdodCBiZSBpbnN0YWxsZWQsIHNvCnhvcmcgZGVmYXVsdHMgdG8gdXNpbmcg
d2hhdGV2ZXIgbGludXggd2FzIGJvb3RlZCB3aXRoIGFzIHRoZSBwcmltYXJ5LAppbiBteSBjYXNl
IHRoZSBpbnRlbCBncmFwaGljcyBpIGd1ZXNzLgoKbm93LCBvbiBhIHJlZ3VsYXIgZGVza3RvcCwg
dGhhdHMgdG90YWxseSBmaW5lIGJlY2F1c2UgdGhlIGdyYXBoaWNzCmNhcmQgaGFzIGRpcmVjdCBh
Y2Nlc3MgdG8gcmFtIG11Y2ggZWFzaWVyLCBhbmQgd2l0aCBmYW5jeSB0aGluZ3MgbGlrZQpkbWEg
YW5kIHdoYXRub3QsIGl0cyBubyBwcm9ibGVtIGF0IGFsbCBmb3IgYSBncmFwaGljcyBjYXJkIHRv
IGFjdCBhcyBhCnJlbmRlciBvZmZsb2FkIHNpbmNlIHRoZSBjYXJkICBjYW4gc2ltcGx5IGRtYSB0
aGUgcmVzdWx0cyBpbnRvIG1haW4KbWVtb3J5IG9yIHNvbWV0aGluZwoKYnV0IHdoZW4geW91IGdv
dCB0aGUgZ3JhcGhpY3MgY2FyZCBpbiBhbiBlR1BVLCBhY3Jvc3MgYSB0aHVuZGVyYm9sdApjb25u
ZWN0aW9uLCBpdCBlc3NlbnRpYWxseSBiZWNhdXNlIE5VTUEsIHNpbmNlIHRoYXQgbWVtb3J5IGFj
Y2VzcyBoYXMKd2F5IG1vcmUgbGF0ZW5jeQoKc28gdGhlIGZhY3QgdGhhdCB0aGUgZGViaWFuIHBh
Y2thZ2UgaXNudCBzYXlpbmcgIlByaW1hcnlHcHUiICJ0cnVlIiBpCmd1ZXNzIG1ha2VzIHNlbnNl
LCBiZWN1YXNlIHdobyBrbm93cyB3aGF0IHlvdSB3YW50IHRoZSBwcmltYXJ5IHRvIGJlLgoKYnV0
IHllYSwganVzdCB0aG91Z2h0IHlhbGwgbWlnaHQgYmUgaW50ZXJlc3RlZCB0byBrbm93IHRoYXQg
dGhlCnNvbHV0aW9uIGZvciBydW5uaW5nIGFuIGVncHUgaW4gbGludXggaXMgc2ltcGx5IHRvIGFk
ZCAiUHJpbWFyeUdwdSIgdG8KdGhlIG91dHB1dCBjbGFzcyB0aGF0IG1hdGNoZXMgeW91ciBncHUu
CmFuZCB3aGVuIHlvdSBib290IHdpdGhvdXQgdGhlIGdwdSwgdGhlIG91dHB1dGNsYXNzIHdvbnQg
bWF0Y2gsIHNvIGl0CndpbGwgZGVmYXVsdCB0byBub3JtYWwgYmVoYXZpb3IKCmFsc28sIGxldHMg
c2F5IHlvdSBoYXZlIE4gbnVtYmVyIG9mIGdwdXMsIGVhY2ggb2Ygd2hpY2ggbWF5IG9yIG1heSBu
b3QKYmUgcHJlc2VudC4gZnJvbSB3aGF0IGkgdW5kZXJzdGFuZCwgeW91IGNhbiBzdGlsbCBlbmZv
cmNlIGEgbGV2ZWwgb2YKcHJlY2VkZW5jZSBhYm91dCBwaWNraW5nIHdoaWNoIG9uZSB0byBiZSBw
cmltYXJ5IGxpa2UgdGhpczoKCiJJZiBtdWx0aXBsZSBvdXRwdXQgZGV2aWNlcyBtYXRjaCBhbiBP
dXRwdXRDbGFzcyBzZWN0aW9uIHdpdGggdGhlClByaW1hcnlHUFUgb3B0aW9uIHNldCwgdGhlIGZp
cnN0IG9uZSBlbnVtZXJhdGVkIGJlY29tZXMgdGhlIHByaW1hcnkKR1BVLiIKCnNvIG9uZSBjYW4g
c2ltcGx5IGRlZmluZSBhIGZpbGUgaW4gd2hpY2ggeW91IGRlZmluZSBOIG51bWJlciBvZgpvdXRw
dXRjbGFzc2VzLCBpbiBvcmRlciBmcm9tIGhpZ2hlc3QgdG8gbG93ZXN0IHByZWNlZGVuY2UgZm9y
IGJlaW5nCnRoZSBwcmltYXJ5IGdwdSwgdGhlbiBzaW1wbHkgcHV0IE9wdGlvbiAiUHJpbWFyeUdw
dSIgInRydWUiCgppIHJlYWxpemUgdGhpcyBpc250IGFuIHhvcmcgbGlzdCwgYW5kIGRvZXNudCBo
YXZlIG11Y2ggdG8gZG8gd2l0aAphbWRncHUsIGJ1dCB3b3VsZCBsb3ZlIHRvIGhlYXIgeWFsbHMg
dGhvdWdodHMuIHRoZXJlcyBhbG90IG9mCmRpc2N1c3Npb24gb25saW5lIGluIGZvcnVtcyBhbmQg
d2hhdG5vdCwgYW5kIHBlb3BsZSBjb21pbmcgdXAgd2l0aCBhbGwKa2luZHMgb2YgImF1dG9tYXRp
YyB4b3JnIGNvbmZpZ3VyYXRpb24gc3RhcnR1cCBzY3JpcHRzIiBhbmQgc3R1ZmYgdG8KbWFuYWdl
IGVncHVzLCBidXQgaWYgbXkgaHlwb3RoZXNpcyBpcyBjb3JyZWN0LCB0aGlzIGlzIHRoZSBjbGVh
bmVzdCwKc2ltcGxlc3QgYW5kIG1vc3QgZWxlZ2FudCBzb2x1dGlvbgoKCk9uIFNhdCwgTWF5IDIz
LCAyMDIwIGF0IDU6MTcgQU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3Jv
dGU6Cj4KPiBPbiAyMDIwLTA1LTIzIDEyOjQ4IGEubS4sIEphdmFkIEthcmFiaSB3cm90ZToKPiA+
Cj4gPiBhbHNvLCB0aGUgd2hvbGUgdGhpbmcgYWJvdXQgIm1vbml0b3IgdXBkYXRpbmcgb25jZSBl
dmVyeSAzIHNlY29uZHMiCj4gPiB3aGVuIGkgY2xvc2UgdGhlIGxpZCBpcyBiZWNhdXNlIG11dHRl
ciB3aWxsIGdvIGRvd24gdG8gMWZwcyB3aGVuIGl0Cj4gPiBkZXRlY3RzIHRoYXQgdGhlIGxpZCBp
cyBjbG9zZWQuCj4KPiBYb3JnJ3MgUHJlc2VudCBleHRlbnNpb24gY29kZSBlbmRzIHVwIGRvaW5n
IHRoYXQgKGJlY2F1c2UgaXQgaGFzIG5vCj4gc3VwcG9ydCBmb3Igc2Vjb25kYXJ5IEdQVXMpLCBu
b3QgbXV0dGVyLgo+Cj4KPiAtLQo+IEVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KPiBMaWJyZSBzb2Z0d2FyZSBl
bnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
