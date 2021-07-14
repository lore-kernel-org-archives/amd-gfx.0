Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA472C47E48
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 20:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ADCB610CB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 20:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADCB610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23406E4FF;
	Wed, 14 Jul 2021 20:32:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A73A6E4FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 20:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626294750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OxicdESZtSsE1XlutUm+MWeszqFKD6QeBINVHmWH91o=;
 b=hmvyQ8q2rIyUYTjrIsekvXMvxffHVKaYzjJ6Fu+9KN+bSkUOuOXCCo2f2rhrkJz4lXTRiy
 qBWYapzwIL+m9B5chqJqpMbDTVI2jvj+o5YdGbQIZquWk4BytDYgjHLdSDqF/znMvzV1a9
 pL3tPorOUKMwvdJvxzPN79F3HzMMWRc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-LZBn5r-INjS9qvRTI1RzoA-1; Wed, 14 Jul 2021 16:32:28 -0400
X-MC-Unique: LZBn5r-INjS9qvRTI1RzoA-1
Received: by mail-qt1-f198.google.com with SMTP id
 100-20020aed206d0000b029024ea3acef5bso2662120qta.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 13:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
 :user-agent:mime-version:content-transfer-encoding;
 bh=OxicdESZtSsE1XlutUm+MWeszqFKD6QeBINVHmWH91o=;
 b=ZVwb3oSM/LD1w/zgndyctpRw/Jb3tWeJ8IP1ooV0gMnfIf+o3CjW8rKjDCwhRc7osZ
 3VTFgcGjgdsfrhWUF5vWykfODFSg07ihDqtoZvXEn0Tz2VtAeiTz2smf/gu28zwdVqTg
 HsrZn4ITdiUZhS5S/VQgWujWT6fJNy4dkD1x6CUJJMxAj+kmK9reSCsiJkHb2KSZno7Z
 xOVmaYNi27eghe7JhUcCoKgg6McElL9YZib8vDMDbWzf1pDf4rEKlmLaRa/HgEvsE3jK
 roOJqHnorExOPp0055hrg+4sW1lcXUQyrTXW2GjNQq5EezY82EvHgAMtsl7D5DFAgAtV
 oRkg==
X-Gm-Message-State: AOAM533KUi4kBQJlSN1aJPhjMSAMJnYAGqD9CAPVnQUiZ3TZ4UmUwTuj
 Qp6StV61Q9m5Wn4KS144mu5LOP/daYmVsJYb6kDhi4XOJIOCPQep4P5/AC7HEcSd1oT5xkJb8/7
 ftSNq5Ka6qdfgSRTt/tlssR1Flw==
X-Received: by 2002:a05:6214:242f:: with SMTP id
 gy15mr12535321qvb.0.1626294747593; 
 Wed, 14 Jul 2021 13:32:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFtQ14FbsB0BEAiFsPKb8Om98zdCR57hgqcLo3xfvVsS2QWW/f3fRfEiclgHf8PetYds9m0Q==
X-Received: by 2002:a05:6214:242f:: with SMTP id
 gy15mr12535306qvb.0.1626294747375; 
 Wed, 14 Jul 2021 13:32:27 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net.
 [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id x9sm1196113qtf.76.2021.07.14.13.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jul 2021 13:32:27 -0700 (PDT)
Message-ID: <5a2b5d77c100a21b3d9e4eb0048c36a94cd1e4ea.camel@redhat.com>
Subject: Help needed for EVoC/GSoC/Outreachy
From: Lyude Paul <lyude@redhat.com>
To: Xorg Members List <members@x.org>, "mesa-dev@lists.freedesktop.org"
 <mesa-dev@lists.freedesktop.org>, xorg-devel <xorg-devel@lists.x.org>, 
 "wayland-devel@lists.freedesktop.org"
 <wayland-devel@lists.freedesktop.org>, nouveau
 <nouveau@lists.freedesktop.org>,  dri-devel
 <dri-devel@lists.freedesktop.org>, IGT development
 <igt-dev@lists.freedesktop.org>,  amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Date: Wed, 14 Jul 2021 16:32:24 -0400
Organization: Red Hat
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: board@x.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkhIEFzIHNvbWUgb2YgeW91IG1pZ2h0IGFscmVhZHkgYmUgYXdhcmUsIGFmdGVyIGhlbHBpbmcg
b3V0IFgub3JnCnByb2plY3QgdGhlIHByZXZpb3VzIHllYXJzIHdpdGggcmVnYXJkcyB0byBzdHVk
ZW50IG91dHJlYWNoLCBUcmV2b3IKZGVjaWRlZCB0byByZXRpcmUgZnJvbSB0aGlzIHBvc2l0aW9u
IGluIGhvcGVzIHRoYXQgc29tZW9uZSBlbHNlIHdpbGwgYmUKYWJsZSB0byBzdGVwIHVwIGFuZCB0
YWtlIG9uIHRoZXNlIHJlc3BvbnNpYmlsaXRpZXMuIEFzIHN1Y2gsIHdlJ3JlCnRyeWluZyB0byBm
aW5kIHBlb3BsZSB3aG8gd291bGQgYmUgd2lsbGluZyB0byB2b2x1bnRlZXIgdGhlaXIgdGltZSB0
bwpoZWxwIG91dCB3aXRoIGdldHRpbmcgdXMgaW52b2x2ZWQgb25jZSBhZ2FpbiBpbiBzdHVkZW50
IG91dHJlYWNoCnByb2dyYW1zLgoKSW4gdGhlIHBhc3QsIFgub3JnIGhhcyBiZWVuIGFjdGl2ZSBp
biB0aGUgR1NvQyBwcm9ncmFtLCBvY2Nhc2lvbmFsbHkKT3V0cmVhY2h5LCBhbmQgb3VyIG93biBF
Vm9DIHByb2dyYW0uIEFzIG9mIDIwMjEgdGhvdWdoLCBHU29DIGRlY2lkZWQgdG8Kc2hvcnRlbiB0
aGUgYW1vdW50IG9mIHRpbWUgYWxsb2NhdGVkIGZvciBhIHN0dWRlbnQgdG8gd29yayBvbiB0aGVp
cgpwcm9qZWN0LiBUaGlzIHVuZm9ydHVuYXRlbHkgcG9zZWQgc29tZSBwcm9ibGVtcyBmb3IKWC5v
cmcvZnJlZWRlc2t0b3Aub3JnIGFzIGEgbG90IG9mIHRoZSBwb3RlbnRpYWwgd29yayB0aGF0IHdv
dWxkIGhhdmUKYmVlbiBnb29kIGZvciB1cyB0byBoYXZlIHN0dWRlbnRzIHdvcmtpbmcgb24gd291
bGRuJ3QgcmVhbGx5IGZpdCB3aXRoaW4KdGhlIG5ldyBHU29DIHRpbWVmcmFtZS4gV2hpbGUgaXQn
cyBjZXJ0YWlubHkgcG9zc2libGUgdGhhdCB0aGVyZSB3aWxsIGJlCnByb2plY3RzIHRoYXQgY29t
ZSB1cCBpbiB0aGUgZnV0dXJlIHdoaWNoIGRvIGZpdCBpbnRvIHRoaXMgbmV3IHRpbWVsaW5lLAp3
ZSB0aGluayBpdCdkIGJlIGEgZ29vZCBpZGVhIHRvIHN0ZXAgdXAgb3VyIGludm9sdmVtZW50IGFn
YWluIHdpdGgKT3V0cmVhY2h5IHdoZXJlIHRoZSBwcm9ncmFtIGlzIGEgZ29vZCBiaXQgbW9yZSBm
bGV4aWJsZSB0aGVuIEdTb0MuIFdlJ3ZlCmFsc28gaGFkIHByZXR0eSBnb29kIGV4cGVyaWVuY2Ug
d29ya2luZyB3aXRoIHRoZSBPdXRyZWFjaHkgY2FuZGlkYXRlcwp3ZSd2ZSBoYWQgaW4gdGhlIHBh
c3QuCgpUaGUgb3RoZXIgbWFpbiB0b3BpYyBvZiBkaXNjdXNzaW9uIGlzIGFyb3VuZCB0aGUgZmFj
dCB0aGF0IG91ciBvd24KcHJvZ3JhbSwgRVZvQywgaGFzbid0IHJlYWxseSBoYWQgYW55b25lIGF2
YWlsYWJsZSB0byB2b2x1bnRlZXIgdG8gaGVscApydW4gaXQgZm9yIGEgd2hpbGUgbm93LiBGb3Ig
dGhvc2Ugd2hvIGFyZW4ndCBhd2FyZSwgRVZvQyBpcyBhIHByb2dyYW0Kc2ltaWxhciB0byBHb29n
bGUgU3VtbWVyIG9mIENvZGUgdGhhdCBYLm9yZyBzdGFydGVkIHJ1bm5pbmcgd2l0aCBtdWNoCm1v
cmUgcmVsYXhlZCByZXF1aXJlbWVudHMgdGhlbiBHU29DL091dHJlYWNoeSBpbiBvcmRlciB0byBo
ZWxwIGZpbGwgdGhlCmdhcHMgZm9yIGFueSBleGNlcHRpb25hbCBjYXNlcyB3aXRoIHN0dWRlbnRz
IHdobyB3b3VsZCBvdGhlcndpc2UgYmUgbGVmdApvdXQgYnkgdGhlIHJlcXVpcmVtZW50cyBmb3Ig
R1NvQy9PdXRyZWFjaHkuIFR5cGljYWxseSB0aG91Z2gsIEVWb0MgaXMKdXN1YWxseSBjb25zaWRl
cmVkIHRoZSBsYXN0IHJlc29ydCBhZnRlciBhIHN0dWRlbnQgaGFzIHRyaWVkIGdldHRpbmcKaW50
byBHU29DL091dHJlYWNoeS4KClNvLCB0aGUgdHdvIGJpZ2dlc3QgdGhpbmdzIHRoYXQgd2UgbmVl
ZCBhcmU6CiogQWRtaW4gdm9sdW50ZWVyKHMpCiogTWVudG9ycywgbWVudG9ycywgbWVudG9ycyEg
V2UgcmVhbGx5IG5lZWQgdGhlc2UgdGhlIG1vc3QuCgpTbywgd2hhdCByZXNwb25zaWJpbGl0aWVz
IHdvdWxkIGJlaW5nIGFuIGFkbWluIGZvciB0aGlzIGVudGFpbD8KCiogRmllbGRpbmcgcXVlc3Rp
b25zIGZyb20gcG90ZW50aWFsIEdTb0MvRVZvQy9PdXRyZWFjaHkgcGFydGljaXBhbnRzLgrCoCBN
b3N0IG9mIHRoZXNlIHN0dWRlbnRzIGFyZSBqdXN0IGxvb2tpbmcgZm9yIHNpbXBsZSBkZXRhaWxz
IG9mIGhvdwrCoCB0aGVzZSBwcm9ncmFtcyB3b3JrIGFuZCBhcmUgbG9va2luZyBmb3IgcHJvamVj
dCBpZGVhcy4gUmVzcG9uZGluZyB0bwrCoCB0aGVzZSBpbnF1aXJpZXMgaXMgbW9zdGx5IGp1c3Qg
YSBtYXR0ZXIgb2YgcG9pbnRpbmcgc3R1ZGVudHMgdG8KwqAgdmFyaW91cyBwYWdlcyBvbiBvdXIg
d2lraSBvciByZXBseWluZyB3aXRoIGZvcm0vc3RvY2sgcmVwbGllcy4gTW9zdCBvZgrCoCB0aGUg
c3R1ZGVudHMgYXQgdGhpcyBwaGFzZSBleHBlY3QgdG8gYmUgaGFuZGVkIGEgcHJvamVjdCBhbmQg
YSBtZW50b3IsCsKgIGFuZCB0aGVyZWZvcmUgZW5kIHVwIGxlYXJuaW5nIHRoYXQgdGhleSB3aWxs
IG5lZWQgdG8gY29tZSB1cCB3aXRoCsKgIHRoZWlyIG93biBwcm9qZWN0IGFuZCBtZW50b3IuCiog
Rm9yIHRoZSBzbWFsbCBoYW5kZnVsIG9mIHN0dWRlbnRzIHRoYXQgbWFrZSBpdCB0byB0aGUgbmV4
dCBwaGFzZSBhbmQKwqAgZmlndXJlIG91dCBhIHByb2plY3QgaWRlYSwgdGhleSB0aGVuIG5lZWQg
dG8gZmluZCBhIG1lbnRvci4gVXN1YWxseQrCoCB0aGUgYWRtaW4gd2lsbCBoZWxwIG91dCBieSB0
YWtpbmcgYSBsb29rIGF0IHdobyBwcm9wb3NlZCB0aGUgcHJvamVjdArCoCBpZGVhLCBhbmQvb3Ig
bG9va2luZyB0aHJvdWdoIGNvbW1pdCBtZXNzYWdlcyBhbmQgbWFpbGluZyBsaXN0IGhpc3RvcnkK
wqAgdG8gdHJ5IHRvIGZpbmQgc29tZW9uZSB3aG8gd291bGQgYmUgYSBnb29kIGZpdCBhbmQgd2ls
bGluZyB0byBtZW50b3IKwqAgdGhlIHN0dWRlbnQuIFNvbWV0aW1lcyB0aGlzIGhhcHBlbnMgcXVp
Y2tseSwgYW5kIHNvbWV0aW1lcyBpdCByZXF1aXJlcwrCoCBwb2tpbmcgYSBsb3Qgb2YgcGVvcGxl
IC0gYW5kIG9jY2FzaW9uYWxseSwgdGhlcmUgbWlnaHQgbm90IGFsd2F5cyBiZSBhCsKgIG1lbnRv
ciB0byBiZSBmb3VuZC4KKiBJZiB3ZSBoYXZlIGEgc3R1ZGVudCwgcHJvamVjdCwgYW5kIG1lbnRv
ciB0aGVuIHRoZSBuZXh0IHN0ZXAgaXMgaGF2aW5nCsKgIHRoZSBzdHVkZW50IHdyaXRlIHVwIGEg
cHJvcG9zYWwuIE1hbnkgc3R1ZGVudHMgc3RhcnQgb3V0IHdpdGgKwqAgb3Zlci1zaW1wbGlmaWVk
IHByb3Bvc2Fscywgc28gYSBsb3Qgb2YgdGhpcyB3b3JrIGlzIGp1c3QgZ2VudGx5CsKgIG51ZGdp
bmcgc3R1ZGVudHMgYW5kIGdldHRpbmcgdGhlbSB0byByZWZpbmUgdGhlaXIgd29yayBpdGVtcyBp
bnRvIGEKwqAgd2Vlay1ieS13ZWVrIHN5bm9wc2lzLiBUaGVyZSdzIHVzdWFsbHkgYSBnb29kIGJp
dCBvZiBiYWNrIGFuZCBmb3J0aArCoCB3aXRoIHRoZSBzdHVkZW50J3MgcHJvcG9zYWwsIGFuZCBv
Y2Nhc2lvbmFsbHkgdGhlIG1lbnRvciBtYXkgYmUKwqAgaW52b2x2ZWQgd2l0aCB0aGlzIHN0ZXAu
CiogVGhlIGFkbWluIHRoZW4gd29ya3Mgd2l0aCB0aGUgc3R1ZGVudCB0byBjb21lIHVwIHdpdGgg
YSB0aW1lbGluZSBmb3IKwqAgdGhlaXIgd29yaywgdGFraW5nIGludG8gYWNjb3VudCBhbnkgdmFj
YXRpb24gdGltZSB0aGUgc3R1ZGVudCBtYXkKwqAgaGF2ZSwgYWxvbmcgd2l0aCBjb29yZGluYXRp
bmcgdGhlIGZyZXF1ZW5jeS90eXBlIG9mIG1lZXRpbmdzIHRoYXQKwqAgd2lsbCBoYXBwZW4gYmV0
d2VlbiB0aGUgc3R1ZGVudCBhbmQgdGhlIG1lbnRvci4gSWYgdGhlIG1lbnRvciBpcwrCoCB1bmFi
bGUgdG8gYXR0ZW5kIGFsbCBvZiB0aGVzZSBtZWV0aW5ncywgaXQncyB1c3VhbGx5IHVwIHRvIHRo
ZSBhZG1pbgrCoCB0byBjaGVjayBpbiB3aXRoIHRoZSBzdHVkZW50IHRvIHNlZSBob3cgdGhleSBh
cmUgcHJvZ3Jlc3NpbmcgYW5kCsKgIHBvdGVudGlhbGx5IHByb3ZpZGUgdGhlbSB0aXBzIGlmIHRo
ZXkgZ2V0IHN0dWNrLgoKQXMgZm9yIGJlaW5nIGEgbWVudG9yLCBpdCdzIHByZXR0eSBtdWNoIGFz
IHNpbXBsZSBhcyBpdCBzb3VuZHM6IHlvdSB3b3JrCndpdGggc3R1ZGVudHMgd2hvIGhhdmUgcHJv
amVjdHMgdG8gaGVscCBmYW1pbGlhcml6ZSB0aGVtIHdpdGggdGhlCnByb2plY3QgYXQgaGFuZCwg
aGVscCB0aGVtIG91dCB3aGVyZXZlciBuZWVkZWQsIGNoZWNrIGluIG9uIHRoZWlyCnByb2dyZXNz
LCBhbmQgZ3VpZGUgdGhlbSBhbG9uZyB0aGUgd2F5IHRvd2FyZHMgcmVhY2hpbmcgdGhlaXIgcHJv
amVjdApnb2FsIGFsb25nIHdpdGggZ3JhZGluZyB0aGVpciB3b3JrLgoKUGxlYXNlIGhlbHAgc3By
ZWFkIHRoZSB3b3JkIG9uIHRoaXMsIGFuZCBjb250YWN0IGFueW9uZSB5b3Uga25vdyB3aG8KbWln
aHQgYmUgaW52b2x2ZWQgd2l0aCB0aGlzISBXZSdsbCBiZSBoYXBweSB0byBwcm92aWRlIG1vcmUg
aW5mb3JtYXRpb24Kb24gaG93IHlvdSBjYW4gZ2V0IHN0YXJ0ZWQuIFJlbWVtYmVyLCBmb2xrcyBs
aWtlIG15c2VsZiB3b3VsZG4ndCBiZSBpbgp0aGlzIGNvbW11bml0eSB3aXRob3V0IHByb2plY3Rz
IGxpa2UgR1NvQyA6KS4KCi0tIApDaGVlcnMsCiBMeXVkZSBQYXVsIChzaGUvaGVyKQogU29mdHdh
cmUgRW5naW5lZXIgYXQgUmVkIEhhdAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
