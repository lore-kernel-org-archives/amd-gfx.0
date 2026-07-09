Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CACCC44508
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 07:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2858110F7EA;
	Fri, 10 Jul 2026 07:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kt7UasVB";
	dkim-atps=neutral
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C9E10E2A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 17:34:54 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-738a5cc517eso55508137.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2026 10:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783618493; cv=none;
 d=google.com; s=arc-20260327;
 b=k9D2ZbHw/Woe9lmPs83pJp/n9pVS3D3LnFgMQXqjLdyPlWHe0+/sL1qDvYJa6LfR+b
 XCOSvam//b8pikeTFAuc3WJhS7OrJd04GN8VdaKja7uJhKfiZfcR5HS8PzqmYX4dUAPa
 HI9tuRyoay8004RATjGPWrXQEbxK6hRzbox9IhcmSvzKlVhM+TRGC/ZrNcn3tH/QSj/b
 VzuMo0P7a3DBTN6iI1ESrKFIrPmRANJgXvtCtdJIMHLEXDRl3EvxbNxOkDYzCEMsR5b/
 +2oc7l/Nuo+bH7xoQJj/hEZPT1qkyTYjR0nSjWCLVBmraOrfNr2NySG01BERzN8DRNZ0
 AnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=HoTls+/3jNNwhhK7JPnNWelIETxDTsvMuGQrUxLI1QU=;
 fh=aDVewn9wtm+aWJrQRWZE0+nBOMbKT1ntYn7AxGKz7vM=;
 b=JrGHXTfqvm1NnXYifVMmkVgxFpr26IFe1euxWMp4hS2a/V1lKd9FFRKApDtVWyH+QK
 oZtwyHvyKZhS0hn/jPFROJY0qkNxoDXg1Irq7Pa2VHOc4V8WXOJAZTKk6Y6AfrPstw3I
 lT69/Y2dc78/L5Wtm4CSxO7X/VFqymufkiOKbxpBkv3mzlhLwJYI+5AqMU1TsWahw0Z8
 0GXbi+oPqdUsLHtCkRm+z+ET1uCBY+KVgz/cQ7cbRV9TLKJ86agq+8kS4qoBIIUSTD7r
 2g6U0Ftp3BAKs28ZBFhSRlwN3PW+nHluXCs1jEWBdJZ6ns+D+OekB4pealKkQdo3Lc+T
 Oc1w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783618493; x=1784223293; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HoTls+/3jNNwhhK7JPnNWelIETxDTsvMuGQrUxLI1QU=;
 b=Kt7UasVBySdaVfkKSyfOJxvKjrzZ9dBUiMvrXIrTo6ee1RbDI0yu6o5ilk703zT6fI
 xcoMYm21FYXCvBktg6mRiNyKqTZd99DvV8jIAy1zwEWAdAkh5zrRGUMp9VQrHRRpxMal
 Z5Qx6ogftSkCA58zAlrNTBOeGxTBfBMlX6uJi1IZpK9PSCCP4BsTd4pK7qUtNE8S7WVS
 X5GE7N4RyRoSFmjnx4E3ku8yoqXSxsUzZhY03gExG6FvQxcAokDsiDyz2/NNdlgQmWxC
 NwXjvVEcjgvrruOK+fyH/1SYPov8ILZhKpPWGjPGKjT+i8kh2xep/k/VR6UU16z23wf1
 mr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783618493; x=1784223293;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HoTls+/3jNNwhhK7JPnNWelIETxDTsvMuGQrUxLI1QU=;
 b=EXGBTlPEbDNTpCrQzEeeeTWxnlV3ZhgRFHaQayF2X/Ht0awfqC4n80lhCOKB14uNg6
 pRmxgdY7gWUSOMflpDf8EbP1vS+SFWSx0Skh3ugfcwBuJoCTjWGNxzLMBpTXN9/Acb0E
 HMb9Wbuzm2P8tdZbWiOuaEe7hrFVLvSYDLJmuzKRcxSzQl+ufIc/iOPGoqiTGTPcckpC
 NGRD10frK0WfAaS3Ytbtb08/YVRGR5urOkEipiN4vLYgyjtN+wHW4eDmyDneux+NeTbk
 Adu+07bVkkgZT1L1029soTakaJvLxNHhUY4cT4Zo+2xDsvcPJcKHzBop8Oxv1N88NSFI
 CBQw==
X-Gm-Message-State: AOJu0YxjWXl1AI54PExJP+Rug6W/j5ympTk66csbA5HJ70gUVDHCmk3K
 7E/JEFD98RtBW50KiJQRDxZ+WSREWNbqCntCZyYUx2Rbg5lOoc75aen+vQoSqCMjVPnr5yRmAu1
 eG3GSnfc9hWCCdpsFAUAhf/EGdV84Omv1+CABCY8=
X-Gm-Gg: AfdE7cmZH9f6RLgOGJyJEOb0WVXEUw0UOOFF5jDs97jZY3i8TunE7hBemWBFUKxWiqN
 X+9O+h7Z5AZBuq9G2FrS1LXKDBM6ANrga5QAs2bCFXFbl6tbVeccb/TxQFCJqXnuNi4LgONVjSN
 Ju5jDXSqUGk0dt5QmJPwKKCLpV1NLnNJtWZfGcJ2uRs8G65ve6Xo+8VTNWhbFZjwaVW/zK85zZF
 wNkDrGt2SO6d6hfcO+Dp8jm43JvVOhrATTFw9u5F2sRKpfpcA0vZtT0hsvo7GvnT2Jb1Gtqqw==
X-Received: by 2002:a05:6102:424c:b0:726:e81f:f3f9 with SMTP id
 ada2fe7eead31-744e0367abamr4896967137.15.1783618493480; Thu, 09 Jul 2026
 10:34:53 -0700 (PDT)
MIME-Version: 1.0
From: Andriy Korud <a.korud@gmail.com>
Date: Thu, 9 Jul 2026 19:34:41 +0200
X-Gm-Features: AUfX_mxcky_ruoxBYkY3q96T0DwdPSRMhA5FTxEHqjS75bvh7qTH869YkOzzMag
Message-ID: <CAOidqQCv-M7oHt9jMMGo2LvhGyXDfNwjfeP+2tASOvg+yRF9mg@mail.gmail.com>
Subject: [PATCH drm-amd] drm/amd/display: dce100: skip non-DP stream encoders
 for DP MST
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mario.limonciello@amd.com
Content-Type: multipart/mixed; boundary="000000000000b81cc10656310ae3"
X-Mailman-Approved-At: Fri, 10 Jul 2026 07:19:09 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000b81cc10656310ae3
Content-Type: multipart/alternative; boundary="000000000000b81cc00656310ae1"

--000000000000b81cc00656310ae1
Content-Type: text/plain; charset="UTF-8"

Hi,
On DCE8-class ASICs (e.g. Bonaire), the resource pool contains digital DIG
stream encoders plus one analog DAC encoder. When assigning a stream
encoder for a second DisplayPort MST stream, if the preferred digital
encoder is already acquired,
dce100_find_first_free_match_stream_enc_for_link() falls back to the first
free pool entry. That entry may be the analog encoder, whose funcs table
lacks DP hooks such as dp_set_stream_attribute. The subsequent atomic
commit then dereferences NULL function pointers in link_set_dpms_on() and
crashes.

Skip encoders without dp_set_stream_attribute when the stream uses a DP
signal (including MST). Use dc_is_dp_signal(stream->signal) for the MST
fallback path instead of checking only the link connector signal.

Tested on:
- GPU: AMD Radeon R7 260X (Bonaire / DCE8)
- Board: Supermicro C9X299-PG300
- Setup: DP MST daisy chain, either hotplug second monitor or have it
connected on boot
- Kernel: 7.1.3 (issue observed since 6.19)
- Result: kernel oops without patch; dual monitors stable with patch

Thanks,
Andriy Korud

--000000000000b81cc00656310ae1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>On DCE8-class ASICs (e.g. Bonaire), the resource po=
ol contains digital DIG stream encoders plus one analog DAC encoder. When a=
ssigning a stream encoder for a second DisplayPort MST stream, if the prefe=
rred digital encoder is already acquired, dce100_find_first_free_match_stre=
am_enc_for_link() falls back to the first free pool entry. That entry may b=
e the analog encoder, whose funcs table lacks DP hooks such as dp_set_strea=
m_attribute. The subsequent atomic commit then dereferences NULL function p=
ointers in link_set_dpms_on() and crashes.<div><br></div>Skip encoders with=
out dp_set_stream_attribute when the stream uses a DP signal (including MST=
). Use dc_is_dp_signal(stream-&gt;signal) for the MST fallback path instead=
 of checking only the link connector signal.<br><div><br></div><div>Tested =
on:</div>- GPU: AMD Radeon R7 260X (Bonaire / DCE8)<br>- Board: Supermicro =
C9X299-PG300<br>- Setup: DP MST daisy chain, either hotplug second monitor =
or have it connected on boot<br>- Kernel: 7.1.3 (issue observed since 6.19)=
<br>- Result: kernel oops without patch; dual monitors stable with patch<br=
><div><br></div><div>Thanks,</div>Andriy Korud</div>

--000000000000b81cc00656310ae1--

--000000000000b81cc10656310ae3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amd-display-dce100-skip-non-DP-stream-encoders-f.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amd-display-dce100-skip-non-DP-stream-encoders-f.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mrds9t8b0>
X-Attachment-Id: f_mrds9t8b0

RnJvbSBkNzcxNzhmZTZmMmNiZjU0ZjZiZThjMWUzYzQ5MTA4ODQ5ZTUzZWJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyaXkgS29ydWQgPGEua29ydWRAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDkgSnVsIDIwMjYgMTk6Mjc6MzQgKzAyMDAKU3ViamVjdDogW1BBVENIIGRybS1hbWRd
IGRybS9hbWQvZGlzcGxheTogZGNlMTAwOiBza2lwIG5vbi1EUCBzdHJlYW0gZW5jb2RlcnMKIGZv
ciBEUCBNU1QgT24gRENFOC1jbGFzcyBBU0lDcyAoZS5nLiBCb25haXJlKSwgdGhlIHJlc291cmNl
IHBvb2wgY29udGFpbnMKIGRpZ2l0YWwgRElHIHN0cmVhbSBlbmNvZGVycyBwbHVzIG9uZSBhbmFs
b2cgREFDIGVuY29kZXIuIFdoZW4gYXNzaWduaW5nIGFuCiBlbmNvZGVyIGZvciBhIHNlY29uZCBE
aXNwbGF5UG9ydCBNU1Qgc3RyZWFtLCBpZiB0aGUgcHJlZmVycmVkIGRpZ2l0YWwgZW5jb2Rlcgog
aXMgYWxyZWFkeSBhY3F1aXJlZCwgZGNlMTAwX2ZpbmRfZmlyc3RfZnJlZV9tYXRjaF9zdHJlYW1f
ZW5jX2Zvcl9saW5rKCkgZmFsbHMKIGJhY2sgdG8gdGhlIGZpcnN0IGZyZWUgcG9vbCBlbnRyeS4g
VGhhdCBlbnRyeSBtYXkgYmUgdGhlIGFuYWxvZyBlbmNvZGVyLAogd2hvc2UgZnVuY3MgdGFibGUg
bGFja3MgRFAgaG9va3MgKGRwX3NldF9zdHJlYW1fYXR0cmlidXRlLCBldGMuKS4gVGhlCiBzdWJz
ZXF1ZW50IGF0b21pYyBjb21taXQgdGhlbiBkZXJlZmVyZW5jZXMgTlVMTCBmdW5jdGlvbiBwb2lu
dGVycyBpbgogbGlua19zZXRfZHBtc19vbigpIGFuZCBjcmFzaGVzLiBTa2lwIGVuY29kZXJzIHdp
dGhvdXQgZHBfc2V0X3N0cmVhbV9hdHRyaWJ1dGUKIHdoZW4gdGhlIHN0cmVhbSB1c2VzIGEgRFAg
c2lnbmFsIChpbmNsdWRpbmcgTVNUKS4gVXNlCiBkY19pc19kcF9zaWduYWwoc3RyZWFtLT5zaWdu
YWwpIGZvciB0aGUgTVNUIGZhbGxiYWNrIHBhdGggaW5zdGVhZCBvZiBjaGVja2luZwogb25seSB0
aGUgbGluayBjb25uZWN0b3Igc2lnbmFsLiBSZXByb2R1Y2VkIG9uIFJhZGVvbiBSNyAyNjBYIChC
b25haXJlKSB3aXRoCiBEUCBNU1QgaG90cGx1ZyBvZiBhIHNlY29uZCBtb25pdG9yIG9uIExpbnV4
IDYuMTkrLgoKU2lnbmVkLW9mZi1ieTogQW5kcml5IEtvcnVkIDxhLmtvcnVkQGZhbGNvbnZzeXN0
ZW1zLmNvbT4KLS0tCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL3Jlc291cmNlL2RjZTEwMC9kY2Ux
MDBfcmVzb3VyY2UuYyB8IDkgKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL3Jlc291cmNlL2RjZTEwMC9kY2UxMDBfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9yZXNvdXJjZS9kY2UxMDAvZGNlMTAwX3Jlc291cmNlLmMKaW5kZXgg
YjkyZDRmMzc4ZDYwLi5iZWFmMmU2NTQ2NzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9yZXNvdXJjZS9kY2UxMDAvZGNlMTAwX3Jlc291cmNlLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL3Jlc291cmNlL2RjZTEwMC9kY2UxMDBfcmVzb3Vy
Y2UuYwpAQCAtMjksNiArMjksNyBAQAogI2luY2x1ZGUgInN0cmVhbV9lbmNvZGVyLmgiCiAKICNp
bmNsdWRlICJyZXNvdXJjZS5oIgorI2luY2x1ZGUgInNpZ25hbF90eXBlcy5oIgogI2luY2x1ZGUg
ImNsa19tZ3IuaCIKICNpbmNsdWRlICJpbmNsdWRlL2lycV9zZXJ2aWNlX2ludGVyZmFjZS5oIgog
I2luY2x1ZGUgImRpby92aXJ0dWFsL3ZpcnR1YWxfc3RyZWFtX2VuY29kZXIuaCIKQEAgLTk5Miw2
ICs5OTMsMTIgQEAgc3RydWN0IHN0cmVhbV9lbmNvZGVyICpkY2UxMDBfZmluZF9maXJzdF9mcmVl
X21hdGNoX3N0cmVhbV9lbmNfZm9yX2xpbmsoCiAJZm9yIChpID0gMDsgaSA8IHBvb2wtPnN0cmVh
bV9lbmNfY291bnQ7IGkrKykgewogCQlpZiAoIXJlc19jdHgtPmlzX3N0cmVhbV9lbmNfYWNxdWly
ZWRbaV0gJiYKIAkJCQlwb29sLT5zdHJlYW1fZW5jW2ldKSB7CisJCQkvKiBEUC9NU1QgbmVlZHMg
YSBkaWdpdGFsIGVuY29kZXI7IHNraXAgYW5hbG9nL25vLURQIGVuY29kZXJzICovCisJCQlpZiAo
ZGNfaXNfZHBfc2lnbmFsKHN0cmVhbS0+c2lnbmFsKSAmJgorCQkJICAgICghcG9vbC0+c3RyZWFt
X2VuY1tpXS0+ZnVuY3MgfHwKKwkJCSAgICAgIXBvb2wtPnN0cmVhbV9lbmNbaV0tPmZ1bmNzLT5k
cF9zZXRfc3RyZWFtX2F0dHJpYnV0ZSkpCisJCQkJY29udGludWU7CisKIAkJCS8qIFN0b3JlIGZp
cnN0IGF2YWlsYWJsZSBmb3IgTVNUIHNlY29uZCBkaXNwbGF5CiAJCQkgKiBpbiBkYWlzeSBjaGFp
biB1c2UgY2FzZQogCQkJICovCkBAIC0xMDE0LDcgKzEwMjEsNyBAQCBzdHJ1Y3Qgc3RyZWFtX2Vu
Y29kZXIgKmRjZTEwMF9maW5kX2ZpcnN0X2ZyZWVfbWF0Y2hfc3RyZWFtX2VuY19mb3JfbGluaygK
IAkgKiByZXF1aXJlZCBmb3Igbm9uIERQIGNvbm5lY3RvcnMuCiAJICovCiAKLQlpZiAoaiA+PSAw
ICYmIGxpbmstPmNvbm5lY3Rvcl9zaWduYWwgPT0gU0lHTkFMX1RZUEVfRElTUExBWV9QT1JUKQor
CWlmIChqID49IDAgJiYgZGNfaXNfZHBfc2lnbmFsKHN0cmVhbS0+c2lnbmFsKSkKIAkJcmV0dXJu
IHBvb2wtPnN0cmVhbV9lbmNbal07CiAKIAlyZXR1cm4gTlVMTDsKLS0gCjIuNTUuMAoK
--000000000000b81cc10656310ae3--
