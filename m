Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BA8C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 22:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F9561353
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 22:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F9561353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B09536E056;
	Tue, 18 May 2021 22:05:42 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D406E056
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 22:05:41 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 t17-20020a4a3e110000b02901fab2f46a48so2572958oot.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CYYZQQBd8UfQzTn95EbbRMkq9YR9OlgQ0jpYYkNiaJ4=;
 b=QTWND5QPr1N5G1QY9vrQYGBl6soGPis2TWpUA5oahlXpVbbY6OyZxWzacfs7us8Dsu
 6vNo8Pb++X+EbDaax9MBUiMas5h7bUsDQkj3rsQtagvwh5tDar8rsX6zRRZJ0N132awo
 PVraqhoP1o6IUqlRY83mbA/0e9i5ovQUSZPNi7c+UK4FRfOkP26epfMAaIJUTaPoWNk6
 L4kP8G0WWaUB0DtslbzRB09SFhxqOJOvhmdOLT+FYOEkgk9po4ALRz1/EeAu3UovX4TD
 7JScPCrzyMMkW+U8wmFQB7z5Fx1loT20E6GyAgmk2zNXDBGsYXhgJr1MMEE2cGmPqJdx
 uwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CYYZQQBd8UfQzTn95EbbRMkq9YR9OlgQ0jpYYkNiaJ4=;
 b=Ui44la06sF6JHKjyXLDZ8fe5yUBPdfynat1P+V45ph1yAav+fTiFry/M30AT6Fjn4H
 REYTZw4vX2wPldGr0E0O5airwgwsCMr8hvEcq09F8u8nJjHDMnxk18mgkT7ytyaYsjiE
 YTAGRsUe0LJxSEdk55IYtiDWv0HeR8BEMJXsQSq5Xe7n1a0wBSQ1idegiTrGCQNbKV3t
 BbB0Xw2bi6woqCIv6scp4TJ7n7aHEopK0ILWh/tqY9CIaKiXqRpPBTsebRoFdKmmeG7i
 QIpyr0qRJHHRYWzgJPjeKzS/DqZM5pvgbC1TfWOfOyLd8QnQvGh7u/pmvdg3FyfCy4Lm
 HfIQ==
X-Gm-Message-State: AOAM532jbORDWn/toZW2RDF772YHGQ6xxOzD0D0jJhG1t4j9vtBVnFVQ
 /s/pn6bIL+4x/LEXZtYbEoGp5cIK39bbEGzLAfw=
X-Google-Smtp-Source: ABdhPJyQxKxDgNCtb+Wx8J5MTXkzbQYOArUmfcUr3Rtp7iewiY6cRgOELSkcfFqmQngwbx+q3umKb2atGvDvqPuddBc=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr6079379oor.61.1621375540694;
 Tue, 18 May 2021 15:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <a4ba9456-812b-5280-75fd-6dd66d1f9718@riseup.net>
 <22c25fa6-b3eb-b778-8598-3ce1947a3d0b@daenzer.net>
In-Reply-To: <22c25fa6-b3eb-b778-8598-3ce1947a3d0b@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 May 2021 18:05:29 -0400
Message-ID: <CADnq5_OVjssNi2niLZQs-TOyN5T5EFOnpwmpmbvHRgh_M0B=wg@mail.gmail.com>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
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
Cc: xgqt <xgqt@riseup.net>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBNYXkgMTgsIDIwMjEgYXQgMTA6MTEgQU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDIxLTA1LTE3IDExOjMzIGEubS4sIHhncXQgd3Jv
dGU6Cj4gPiBIZWxsbyEKPiA+Cj4gPiBJIHJ1biBhIEFNRCBsYXB0b3AgIjgxTkMgTGVub3ZvIElk
ZWFQYWQgUzM0MC0xNUFQSSIgLSBBTUQgUnl6ZW4gNSAzNTAwVSB3aXRoIFJhZGVvbiBWZWdhIDgg
R3JhcGhpY3MuCj4gPiBSZWNlbnRseSBzb21lIGJyZWFrYWdlcyBzdGFydGVkIGhhcHBlbmluZyBm
b3IgbWUuIEluIGFib3V0IDFoIGFmdGVyIGJvb3QtdXAgd2hpbGUgdXNpbmcgYSBLREUgZGVza3Rv
cCBtYWNoaW5lIEdVSSB3b3VsZCBmcmVlemUuIFNvbWV0aW1lcyBpdCB3b3VsZCBiZSBwb3NzaWJs
ZSB0byBtb3ZlIHRoZSBtb3VzZSBidXQgdGhlIHJlc3Qgd2lsbCBiZSBmcm96ZW4uIFNjcmVlbiBt
YXkgc3RhcnQgYmxpbmtpbmcgb3IgZ28gYmxhY2suCj4gPgo+ID4gSSdtIG5vdCBzdXJlIGlmIHRo
aXMgaXMgbXkga2VybmVsLCBmaXJtd2FyZSBvciB0aGUgaGFyZHdhcmUuCj4gPiBJIGRvbid0IHVu
ZGVyc3RhbmRzIGRtZXNnIHRoYXQncyB3aHkgSSdtIGd1ZXNzaW5nLCBidXQgSSB0aGluayBpdCBp
cyB0aGUgZmlybXdhcmUgc2luY2UgdGhpcyBiZWhhdmlvciBzdGFydGVkIGFyb3VuZCAyMDIxLTA1
LTE1Lgo+ID4gRnJvbSBteSBQb3J0YWdlIGxvZ3MgSSBzZWUgdGhhdCBJIHVwZGF0ZWQgbXkgZmly
bXdhcmUgb24gMjAyMS0wNS0xNCBhdCAxODoxNjowNi4KPiA+IFNvIGJyZWFrYWdlcyBzdGFydGVk
IHdpdGggbXkga2VybmVsOiA1LjEwLjI3IGFuZCBGVzogMjAyMTA1MTEuCj4gPiBBZnRlciBicmVh
a2FnZSBJIGp1bXBlZCB0byBhIG9sZGVyIGtlcm5lbCA1LjQuOTcgYW5kIGNvbXBpbGVkIDUuMTIu
NC4gSSBkaWRuJ3Qgbm90aWNlIGEgYnJlYWthZ2Ugb24gNS40Ljk3IGJ1dCBzeXN0ZW0gcmFuIH40
MCBtaW51dGVzLgo+ID4gU28gSSBib290ZWQgdG8gbmV3bHkgY29tcGlsZWQgNS4xMi40IHdoZXJl
IEkgd2FzIH4xaCBhbmQgaXQgYnJva2UuCj4gPiBBZnRlciB0aGF0IEkgYm9vdGVkIHRvIDUuNC45
NyBhZ2FpbiBhbmQgZG93bmdyYWRlZCBteSBGVy4KPiA+IFdoaWxlIEknbSB3cml0aW5nIHRoaXMg
SSdtIGJvb3RlZCB0byBrZXJuZWw6IDUuMTIuNCB3aXRoIEZXOiAyMDIxMDMxNS4KPiA+Cj4gPiBJ
IGFsc28gZGVzY3JpYmVkIG15IHNpdHVhdGlvbiBvbiB0aGUgR2VudG9vIGJ1Z3ppbGxhOiBodHRw
czovL2J1Z3MuZ2VudG9vLm9yZy83OTA1NjYKPiA+Cj4gPiAiZG1lc2cubG9nIiBhdHRhY2hlZCBo
ZXJlIGlzIGZyb20gdGhlIHRpbWUgbWFjaGluZSBydW4gZmluZSAoYXQgdGhlIG1vbWVudCk7ICJl
cnJvcnNfc2F0X21heV8xNV8wNzI4MjVfcG1fY2VzdF8yMDIxLmxvZyIgaXMgYSBkbWVzZyBsb2cg
ZnJvbSB0aGUgdGltZSBzeXN0ZW0gYnJva2UKPiA+Cj4gPiBDYW4gSSBnZXQgYW55IGhlbHAgd2l0
aCB0aGlzPyBXaGF0IGFyZSB0aGUgbmV4dCBzdGVwcyBJIHNob3VsZCB0YWtlPyBBbnkgb3RoZXIg
ZmlsZXMgSSBzaG91bGQgcHJvdmlkZT8KPgo+IEkndmUgaGl0IHNpbWlsYXIgaGFuZ3Mgd2l0aCBh
IExlbm92byBUaGlua1BhZCBFNTk1IChSeXplbiA3IDM3MDBVIC8gUGljYXNzbyAvIFJBVkVOIDB4
MTAwMjoweDE1RDggMHgxN0FBOjB4NTEyNCAweEMxKS4gSSdtIGFsc28gc3VzcGVjdGluZyB0aGVt
IHRvIGJlIGZpcndhcmUgcmVsYXRlZC4gVGhlIGhhbmdzIG9jY3VycmVkIHdpdGggZmlybXdhcmUg
ZnJvbSB0aGUgQU1EIDIwLjUwIHJlbGVhc2UuIEknbSBjdXJyZW50bHkgcnVubmluZyB3aXRoIGZp
cm13YXJlIGZyb20gdGhlIDIwLjQwIHJlbGVhc2UsIG5vIGhhbmcgaW4gYWxtb3N0IDIgd2Vla3Mg
KHRoZSBoYW5ncyBoYXBwZW5lZCB3aXRoaW4gMS0yIGRheXMgYWZ0ZXIgYm9vdCkuCgpDYW4geW91
IG5hcnJvdyBkb3duIHdoaWNoIGZpcm13YXJlKHMpIGNhdXNlIHRoZSBwcm9ibGVtPwoKQWxleApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
