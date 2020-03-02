Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C04C3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6CB217F4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="neiMV4tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6CB217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=pm.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54BA6E554;
	Mon,  2 Mar 2020 16:18:33 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22206E530
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:08:43 +0000 (UTC)
Date: Mon, 02 Mar 2020 16:08:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
 t=1583165321; bh=iSz9D4BaSeSiRRWSvn9TL3x9mu2IRPBCLNzvEIW7tC0=;
 h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
 b=neiMV4tAyJrpw5VH5KUB2oEEK3Jua+AW62ycMtNbWHIqyqypzTHtIIS4uccvvZewK
 fcXrr1PaeGLld+jDZWLB0HLgadyEfTPmS6emv2/ikP34mASMp/0eRpBMonR+2GRdwW
 X/Le/3mdLfBFAMBSp9nGlWLrmlBzKL85Vy/jXbeg9W62Q76bzPIGEQagPvrBTcF3BO
 SYrb6TO4fOGdfyvD1KFZn5JENnmzRenSH6lDRsaE0P4lr+m5GV+BJgZ1OPLKdWcnGl
 D6JdaHMW4eAX2GiSxZG9XGH08CvuO2+df4PAEP6UJ6l6xcBdWbF1Dl7iSqR1peO//Q
 mTNaGBdoD3hsw==
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Josh Fuhs <Joshua.Fuhs@pm.me>
Subject: Problem w/ OpenCL and amdgpu w/ ASRock Challenger 5700 XT
Message-ID: <pLJ94m2EVdRP_9hakGSs10rU_yB2JxRChSrGz7Zg6YBDxXJdRO8KdsYeup57jRfqMW_7T7hm_hutblaK8UIsLz3SIsfZnEZGm4qH8xwbB1E=@pm.me>
Feedback-ID: Z662AikR9l0kvOVYg-m6awgxgDvAwWrs2Bm3gEUXm9LfoVZ1m76tPXUIXwvGIf4o-c-y35FVaJ-GCj--pnTrbw==:Ext:ProtonMail
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 02 Mar 2020 16:18:32 +0000
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
Reply-To: Josh Fuhs <Joshua.Fuhs@pm.me>
Content-Type: multipart/mixed; boundary="===============1959971524=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.

--===============1959971524==
Content-Type: multipart/alternative;
	boundary="b1_9cefd88827ce1939084e44750f8a840b"

This is a multi-part message in MIME format.

--b1_9cefd88827ce1939084e44750f8a840b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGVsbG8sCgpJJ20gaGF2aW5nIGRpZmZpY3VsdHkgZ2V0dGluZyBPcGVuQ0wgdG8gc2VlIGFuIEFT
Um9jayA1NzAwIFhUIEdQVS4gSSBoYXZlIGdvdHRlbiB0aGlzIHRvIHdvcmsgd2l0aCBhIFNhcHBo
aXJlIGNhcmQsIHdoaWNoIEkgaGF2ZSBiZWVuIHVzaW5nIGFzIGEgcG9pbnQgb2YgY29tcGFyaXNv
biBvbiBhIGRpZmZlcmVudCBzeXN0ZW0uCgpXaXRoIGFtZGdwdS0xOS41MCBhbmQga2VybmVsIDUu
NS42IG9yIDUuNnJjMywgY2xpbmZvIChlaXRoZXIgdmlhIGFtZGdwdSBvciBzdGFuZGFyZCkgcmVw
b3J0cyB6ZXJvIGRldmljZXMgYXZhaWxhYmxlLgoKVGhlIGtlcm5lbCBmb3VuZCB0aGUgQVNSb2Nr
IGNhcmQgYW5kIGZpbGxzIG91dCB0aGUgL3N5cy9jbGFzcy9kcm0vY2FyZFggZmlsZXN5c3RlbSBq
dXN0IGxpa2UgdGhlIFNhcHBoaXJlIGNhcmQuIEkgc2VlIG5vIGVycm9ycyBpbiB0aGUgbG9ncyB3
aXRoIHJlc3BlY3QgdG8gYW1kZ3B1LgoKT3V0cHV0IG9mICdsc3BjaSAtbm4gfCBncmVwICJWR0Ei
JzoKCiIiIgo4MzowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXIgWzAzMDBdOiBBZHZhbmNl
ZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTUQvQVRJXSBEZXZpY2UgWzEwMDI6NzMxZl0gKHJldiBj
MSkKYzI6MDAuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyIFswMzAwXTogQVNQRUVEIFRlY2hu
b2xvZ3ksIEluYy4gQVNQRUVEIEdyYXBoaWNzIEZhbWlseSBbMWEwMzoyMDAwXSAocmV2IDQxKQoi
IiIKClBhcnRpYWwgb3V0cHV0IG9mIGNsaW5mbzoKCiIiIgpQbGF0Zm9ybSBOYW1lICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBBTUQgQWNjZWxlcmF0ZWQgUGFyYWxsZWwgUHJvY2Vz
c2luZwpOdW1iZXIgb2YgZGV2aWNlcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAK
IiIiIgoKU29tZXRoaW5nIHRoYXQgbG9va3Mgb2RkIGJldHdlZW4gdGhlIGNhcmRzOgoKQVNSb2Nr
OgpwY2llX2J3OiA5MjIzMzcyMTY2MDUyNTk5OTExIDQxOTQzMDQgMjU2CgpTYXBwaGlyZToKcGNp
ZV9idzogNDE5NzU2OCAxODQ0NjYzNzAzNjcwMzg3NDQ4OCAyNTYKCklmIHlvdSBrbm93IG9mIGFu
eSB0b29scyB0aGF0IHdvdWxkIGhlbHAgbWUgdG8gZGlhZ25vc2UgdGhlIHByb2JsZW0sIG9yIGlm
IHRoZXJlIGlzIGEgYmV0dGVyIHBsYWNlIHRvIGFzaywgYW55IHBvaW50ZXJzIHdvdWxkIGJlIGFw
cHJlY2lhdGVkLgoKVGhhbmtzIGZvciB5b3VyIGhlbHAuCgpKb3NoCgpUaGFua3MgZm9yIGFsbCB0
aGUgaGVscC4KCkpvc2g=


--b1_9cefd88827ce1939084e44750f8a840b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdj48ZGl2PkhlbGxvLDxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkknbSBoYXZpbmcg
ZGlmZmljdWx0eSBnZXR0aW5nIE9wZW5DTCB0byBzZWUgYW4gQVNSb2NrIDU3MDAgWFQgR1BVLiBJ
IGhhdmUgZ290dGVuIHRoaXMgdG8gd29yayB3aXRoIGEgU2FwcGhpcmUgY2FyZCwgd2hpY2ggSSBo
YXZlIGJlZW4gdXNpbmcgYXMgYSBwb2ludCBvZiBjb21wYXJpc29uIG9uIGEgZGlmZmVyZW50IHN5
c3RlbS48YnI+PGJyPldpdGggYW1kZ3B1LTE5LjUwIGFuZCBrZXJuZWwgNS41LjYgb3IgNS42cmMz
LCBjbGluZm8gKGVpdGhlciB2aWEgYW1kZ3B1IG9yIHN0YW5kYXJkKSByZXBvcnRzIHplcm8gZGV2
aWNlcyBhdmFpbGFibGUuPGJyPjwvZGl2PjwvZGl2PjxkaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5U
aGUga2VybmVsIGZvdW5kIHRoZSBBU1JvY2sgY2FyZCBhbmQgZmlsbHMgb3V0IHRoZSAvc3lzL2Ns
YXNzL2RybS9jYXJkWCBmaWxlc3lzdGVtIGp1c3QgbGlrZSB0aGUgU2FwcGhpcmUgY2FyZC4gSSBz
ZWUgbm8gZXJyb3JzIGluIHRoZSBsb2dzIHdpdGggcmVzcGVjdCB0byBhbWRncHUuPGJyPjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+T3V0cHV0IG9mICdsc3BjaSAtbm4gfCBncmVwICJWR0EiJzo8
YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4iIiI8YnI+PC9kaXY+PC9kaXY+PGRpdj44Mzow
MC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXIgWzAzMDBdOiBBZHZhbmNlZCBNaWNybyBEZXZp
Y2VzLCBJbmMuIFtBTUQvQVRJXSBEZXZpY2UgWzEwMDI6NzMxZl0gKHJldiBjMSk8YnI+PC9kaXY+
PGRpdj5jMjowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXIgWzAzMDBdOiBBU1BFRUQgVGVj
aG5vbG9neSwgSW5jLiBBU1BFRUQgR3JhcGhpY3MgRmFtaWx5IFsxYTAzOjIwMDBdIChyZXYgNDEp
PGJyPjwvZGl2PjxkaXY+PGRpdj4iIiI8YnI+PC9kaXY+PGRpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PlBhcnRpYWwgb3V0cHV0IG9mIGNsaW5mbzo8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+IiIiPGJy
PjwvZGl2PjxkaXY+PGRpdj48ZGl2PjxkaXY+UGxhdGZvcm0gTmFtZSZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBBTUQgQWNjZWxlcmF0ZWQgUGFyYWxsZWwgUHJvY2Vzc2luZzxicj48
L2Rpdj48L2Rpdj48ZGl2Pk51bWJlciBvZiBkZXZpY2VzJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDA8
YnI+PC9kaXY+PC9kaXY+PGRpdj4iIiIiPGJyPjwvZGl2PjxkaXY+PGRpdj48ZGl2Pjxicj48L2Rp
dj48L2Rpdj48ZGl2PlNvbWV0aGluZyB0aGF0IGxvb2tzIG9kZCBiZXR3ZWVuIHRoZSBjYXJkczo8
YnI+PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BU1JvY2s6PGJyPjwvZGl2PjxkaXY+
cGNpZV9idzogOTIyMzM3MjE2NjA1MjU5OTkxMSA0MTk0MzA0IDI1Njxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PlNhcHBoaXJlOjxicj48L2Rpdj48ZGl2PnBjaWVfYnc6IDQxOTc1NjggMTg0
NDY2MzcwMzY3MDM4NzQ0ODggMjU2PGJyPjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
SWYgeW91IGtub3cgb2YmbmJzcDthbnkgdG9vbHMgdGhhdCB3b3VsZCBoZWxwIG1lIHRvIGRpYWdu
b3NlIHRoZSBwcm9ibGVtLCBvciBpZiB0aGVyZSBpcyBhIGJldHRlciBwbGFjZSB0byBhc2ssIGFu
eSBwb2ludGVycyB3b3VsZCBiZSBhcHByZWNpYXRlZC48YnI+PC9kaXY+PC9kaXY+PGRpdj48ZGl2
Pjxicj5UaGFua3MgZm9yIHlvdXIgaGVscC48YnI+PGJyPkpvc2g8YnI+PC9kaXY+PC9kaXY+PGRp
diBjbGFzcz0icHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2sgcHJvdG9ubWFpbF9zaWduYXR1cmVf
YmxvY2stZW1wdHkiPjxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLXVzZXIg
cHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2stZW1wdHkiPjxicj48L2Rpdj48ZGl2Pjxicj48YnI+
VGhhbmtzIGZvciBhbGwgdGhlIGhlbHAuPGJyPjxicj5Kb3NoPGJyPjwvZGl2PjwvZGl2PjxkaXY+
PGJyPjwvZGl2Pg==



--b1_9cefd88827ce1939084e44750f8a840b--


--===============1959971524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1959971524==--

