Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36B6C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 17:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E34214D8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 17:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="oMLp30bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E34214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=pm.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095AA89BFF;
	Fri, 31 Jan 2020 17:56:56 +0000 (UTC)
X-Greylist: delayed 518 seconds by postgrey-1.36 at gabe;
 Fri, 31 Jan 2020 17:56:55 UTC
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch
 [185.70.40.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0817C89BFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 17:56:54 +0000 (UTC)
Date: Fri, 31 Jan 2020 17:48:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
 t=1580492895; bh=Pr1xwOedX2qaLojjhP7G/LGUawkjuhJnBnXZO+hRYkU=;
 h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
 b=oMLp30bJHv2igYKXVrHaohKFaTwoqSB+5tpvHZs7UFz7DGc8XWOrU2UsQSPEOdyaL
 ulBMOUOUAxc0hjLO+RjijaWQ3TMl7qFs9qmanISX9JwDBNvXIBXazvfkk1p2nGH3NK
 2sRYkS/62ovgxv6HWEPdg6TmFonga81DzwtzY/tHBHrv2T0ZaBWK34EjHj3W6qcsfJ
 N0bvHgQ1FZEB+zFirP0GRYjaN5dnDICK1YUdaKSEAbkHgsQV+yzURC375EadLPLfR/
 g18RFleZYsWP57Ye2RyiQpy06o084ShNxOIaokaFa9N4CBI2uCqjid6PKGNknl7v1L
 vIevgREpoXlUA==
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Josh Fuhs <Joshua.Fuhs@pm.me>
Subject: Asking for Direction
Message-ID: <_a89rdMCBfe551EYsOQQ9AS8gdX2eNTS9VmWelbIZo6asP2FTaRqmNsPHEluPZ6wLVCDUqQIHYiHMQbNsen89RQjb_R4LfpmApIdOjf2fNM=@pm.me>
Feedback-ID: Z662AikR9l0kvOVYg-m6awgxgDvAwWrs2Bm3gEUXm9LfoVZ1m76tPXUIXwvGIf4o-c-y35FVaJ-GCj--pnTrbw==:Ext:ProtonMail
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
Reply-To: Josh Fuhs <Joshua.Fuhs@pm.me>
Content-Type: multipart/mixed; boundary="===============0759272755=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.

--===============0759272755==
Content-Type: multipart/alternative;
	boundary="b1_7ca004cd8a0bd679f64ac8de55348254"

This is a multi-part message in MIME format.

--b1_7ca004cd8a0bd679f64ac8de55348254
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGkgYWxsLAoKSSBhbSB0cnlpbmcgdG8gdXNlIGEgUmFkZW9uIFJYIDU3MDBYVCB2aWEgT3BlbkNM
IHdpdGgga2VybmVsIDUuMy4wIChJIGhhdmUgYWxzbyB0cmllZCBrZXJuZWwgNS4zLjE4KSBvbiBV
YnVudHUgMTguMDQuIEkgaGF2ZSBub3RpY2VkIHRoYXQgdGhpcyBjb21iaW5hdGlvbiBpcyBtdWNo
IHNsb3dlciB0aGFuIGV4cGVjdGVkLiBJJ20gdHJ5aW5nIHRvIGZpbmQgb3V0IHdoeSwgYW5kIGhv
dyB0byBmaXggaXQuCgpJZiBJJ20gaW4gdGhlIHdyb25nIHBsYWNlIHRvIGFzaywgd291bGQgeW91
IGJlIGFibGUgdG8gcG9pbnQgbWUgaW4gdGhlIHJpZ2h0IGRpcmVjdGlvbj8KCklmIHRoaXMgaXMg
YSBrbm93biBvdXRzdGFuZGluZyBwcm9ibGVtLCBhIHJlZmVyZW5jZSB0byBhIGJ1ZyBvciBzb21l
dGhpbmcgZWxzZSB0aGF0IHdvdWxkIGxldCBtZSBkaWcgaW50byBpdCB3b3VsZCBiZSBncmVhdC4K
ClRoYW5rcwoKSm9zaCBGdWhz


--b1_7ca004cd8a0bd679f64ac8de55348254
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdj5IaSBhbGwsPGJyPjxicj5JIGFtIHRyeWluZyB0byB1c2UgYSBSYWRlb24gUlggNTcwMFhU
IHZpYSBPcGVuQ0wgd2l0aCBrZXJuZWwgNS4zLjAgKEkgaGF2ZSBhbHNvIHRyaWVkIGtlcm5lbCA1
LjMuMTgpIG9uIFVidW50dSAxOC4wNC4gSSBoYXZlIG5vdGljZWQgdGhhdCB0aGlzIGNvbWJpbmF0
aW9uIGlzIG11Y2ggc2xvd2VyIHRoYW4gZXhwZWN0ZWQuIEknbSB0cnlpbmcgdG8gZmluZCBvdXQg
d2h5LCBhbmQgaG93IHRvIGZpeCBpdC48YnI+PGJyPklmIEknbSBpbiB0aGUgd3JvbmcgcGxhY2Ug
dG8gYXNrLCB3b3VsZCB5b3UgYmUgYWJsZSB0byBwb2ludCBtZSBpbiB0aGUgcmlnaHQgZGlyZWN0
aW9uPzxicj48L2Rpdj48ZGl2IGNsYXNzPSJwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jayBwcm90
b25tYWlsX3NpZ25hdHVyZV9ibG9jay1lbXB0eSI+PGRpdiBjbGFzcz0icHJvdG9ubWFpbF9zaWdu
YXR1cmVfYmxvY2stdXNlciBwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay1lbXB0eSI+PGJyPjwv
ZGl2PjxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLXByb3RvbiBwcm90b25t
YWlsX3NpZ25hdHVyZV9ibG9jay1lbXB0eSI+PGJyPjwvZGl2PjwvZGl2PjxkaXY+PGJyPklmIHRo
aXMgaXMgYSBrbm93biBvdXRzdGFuZGluZyBwcm9ibGVtLCBhIHJlZmVyZW5jZSB0byBhIGJ1ZyBv
ciBzb21ldGhpbmcgZWxzZSB0aGF0IHdvdWxkIGxldCBtZSBkaWcgaW50byBpdCB3b3VsZCBiZSBn
cmVhdC48YnI+PGJyPlRoYW5rczxicj48YnI+Sm9zaCBGdWhzPGJyPjwvZGl2Pg==



--b1_7ca004cd8a0bd679f64ac8de55348254--


--===============0759272755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0759272755==--

