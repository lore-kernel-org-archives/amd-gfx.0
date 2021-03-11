Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3FDC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 12:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94C964EFD
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 12:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94C964EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFEB6EC1D;
	Thu, 11 Mar 2021 12:10:48 +0000 (UTC)
Received: from mail1.protonmail.ch (mail1.protonmail.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55166EC1D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 12:10:46 +0000 (UTC)
Date: Thu, 11 Mar 2021 12:10:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1615464644;
 bh=manDk0vK6QxgbQXEWS1xhL6jEFQkWBmVmxyfmOvBmek=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=cU0ga0n1zyVX+vQ7NwpPeLv58RDKmLRSX6YTlD2yCnEVRJ8j8JIV1UYEyPXp84PE9
 vPR/2kya26ccQbVQ7/c5dQ5hPOWBdrCF0/zTbb+u86oJMeBmFDt/PjfC1OsFi67Rq7
 evkaIs/GVdQCfitb+zh3U7aMeErHR1zZ0YdpG6IFqnFNQ+I6zLxlg4ZSJ7ujTLRoA3
 gdC4Gou9ISs7mgs21oABraGfuvBXk6QXJdliI5APzSfhsNyjUQ+/6ZZPiDbzxE23xN
 HCL7SbWGN9pjrDBtOE7LY2PEnSC3czHrcHOgMNLihnnjNvc8S3OBT0XzME93B4jjUd
 C8f0gQOl6vaEQ==
To: =?utf-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 0/5] amd/display: improve atomic cursor checks
Message-ID: <OlOrZse4H1w18QcjDxxswj-tCs1GMJuhZ0S0hYTrcTkXEO-OjALqKgi1vc8hb46TvH9-J3Ri39_qsRHoevbiHgv88dQx8fcWUPKIRrH19KQ=@emersion.fr>
In-Reply-To: <07f53c21-920d-7494-8195-c678216610a4@daenzer.net>
References: <20210310145019.2877-1-contact@emersion.fr>
 <a4fe57bf-33f2-43f5-0170-2135c6a919df@daenzer.net>
 <mg9Sasg2hDaWhKchS7MJOG1GxFgyK7EjamocMRigAuCcwDNJhI5DGVLItXCxyKqNkEl8E2kgsnijtkSMI_YMTe8_Rjmn0Sh8PB32YNTfH1c=@emersion.fr>
 <07f53c21-920d-7494-8195-c678216610a4@daenzer.net>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1cnNkYXksIE1hcmNoIDExdGgsIDIwMjEgYXQgMTA6MDUgQU0sIE1pY2hlbCBEw6RuemVy
IDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgoKPiBPbiAyMDIxLTAzLTExIDk6NTcgYS5tLiwg
U2ltb24gU2VyIHdyb3RlOgo+ID4gT24gV2VkbmVzZGF5LCBNYXJjaCAxMHRoLCAyMDIxIGF0IDY6
MjAgUE0sIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+ID4+IE9u
IDIwMjEtMDMtMTAgMzo1MCBwLm0uLCBTaW1vbiBTZXIgd3JvdGU6Cj4gPj4KPiA+Pj4gQ2hhbmdl
cyBpbiB2MjogZHJvcCAiYW1kL2Rpc3BsYXk6IGZhaWwgb24gY3Vyc29yIHBsYW5lIHdpdGhvdXQg
YW4KPiA+Pj4gdW5kZXJseWluZyBwbGFuZSIuIFRoaXMgcmV0YWlucyB0aGUgY3VycmVudCBiZWhh
dmlvciBpbnN0ZWFkLgo+ID4+Cj4gPj4gUGF0Y2hlcyAyICYgMyAoYW5kIHBvc3NpYmx5IDQ/IG5v
dCBzdXJlKSB3b3VsZCBzdGlsbCBjYXVzZSB0aGUgc2FtZQo+ID4+IGlzc3VlIGluIHRoZSBzY2Vu
YXJpbyBkaXNjdXNzZWQgaW4gZm9sbG93LXVwcyB0byB0aGUgZHJvcHBlZCBwYXRjaAo+ID4+IChk
aXNhYmxpbmcgYW4gQVJHQiBvdmVybGF5IHBsYW5lIHdpdGggYSBZVVYgcHJpbWFyeSBwbGFuZSBh
bmQgdGhlCj4gPj4gY3Vyc29yIHBsYW5lIGVuYWJsZWQpLCB3b3VsZG4ndCB0aGV5Pwo+ID4KPiA+
IFllcywgYnV0IHRoYXQgc2hvdWxkbid0IGJlIHRvbyBtdWNoIG9mIGFuIGlzc3VlIGluIHByYWN0
aWNlLCBzaW5jZQo+ID4gdXNlci1zcGFjZSB1c2luZyBZVVYgYW5kIG92ZXJsYXlzIGFsc28gdXNl
cyBhdG9taWMuIERyb3BwaW5nIHRoZSBwYXRjaAo+ID4gYXZvaWRzIHRoZSBpc3N1ZSB0byBiZSB0
cmlnZ2VyZWQgd2l0aCBsZWdhY3kgdXNlci1zcGFjZS4KPgo+IFRoZSBsYXN0IHNjZW5hcmlvIGRp
c2N1c3NlZCBpcyBhYm91dCBhdG9taWMgS01TIHVzZXIgc3BhY2UgdHJ5aW5nIHRvIGRpc2FibGUK
PiB0aGUgb3ZlcmxheSBwbGFuZS4gRGFuaWVsIHNlZW1zIHRvIGFncmVlIHRoYXQgbm90IGJlaW5n
IGFibGUgdG8gZGlzYWJsZSBhbgo+IG92ZXJsYXkgcGxhbmUgaXMgdG9vIHN1cnByaXNpbmcuCgpX
ZWxsLCBhbWRncHUgY2FuIGFscmVhZHkgcmV0dXJuIGEgZmFpbHVyZSBpZiB1c2VyLXNwYWNlIHRy
aWVzIHRvIGRpc2FibGUgdGhlCm92ZXJsYXk6CgotIFVzZXItc3BhY2Ugc2V0cyB1cCB0aGUgcHJp
bWFyeSBwbGFuZSB3aXRoIGEgc2NhbGVkIEZCLgotIFVzZXItc3BhY2UgZW5hYmxlcyB0aGUgb3Zl
cmxheSBhbmQgY3Vyc29yIHBsYW5lcyB3aXRob3V0IHNjYWxpbmcuCi0gVXNlci1zcGFjZSB0cmll
cyB0byBkaXNhYmxlIHRoZSBvdmVybGF5LCBrZXJuZWwgcmV0dXJucyBhIGZhaWx1cmUgYmVjYXVz
ZSBhCiAgbm9uLXNjYWxlZCBjdXJzb3IgaXMgaW5jb21wYXRpYmxlIHdpdGggYSBzY2FsZWQgdW5k
ZXJseWluZyBwbGFuZS4KClNvIHRoaXMgc2VyaWVzIGp1c3QgYWRkcyBhIG5ldyBlcnJvciBjb25k
aXRpb24uCgpJJ20gbm90IGEgZmFuIG9mIGFkZGluZyBrZXJuZWwgaGFja3MgbGlrZSBzZXR0aW5n
IHVwIGEgdHJhbnNwYXJlbnQgRkIsIHdoZW4KdXNlci1zcGFjZSBjYW4ganVzdCBhdm9pZCB0aGUg
ZmFpbHVyZSB3aXRoIGF0b21pYyB0ZXN0LW9ubHkgY29tbWl0cyAoYW5kIGUuZy4KdXNlIHRoZSBv
dmVybGF5IHRvIGRpc3BsYXkgdGhlIGN1cnNvciBpbWFnZSBpbnN0ZWFkIG9mIHRoZSBjdXJzb3Ig
cGxhbmUpLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
