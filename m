Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EC8C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 14:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF11661424
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 14:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF11661424
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloudsdale.the-delta.net.eu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9736E9F3;
	Wed, 30 Jun 2021 14:50:44 +0000 (UTC)
X-Greylist: delayed 396 seconds by postgrey-1.36 at gabe;
 Wed, 30 Jun 2021 14:47:21 UTC
Received: from cloudsdale.the-delta.net.eu.org
 (cloudsdale.the-delta.net.eu.org [IPv6:2a01:4f8:1c17:4b6d::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F1656E9F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 14:47:21 +0000 (UTC)
Received: by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTP id a73432a4
 for <amd-gfx@lists.freedesktop.org>;
 Wed, 30 Jun 2021 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=hacktivis.me; h=from
 :date:to:message-id:mime-version:content-type
 :content-transfer-encoding; s=20190711_142157; bh=3Jou8V3Tq/puTr
 U0IOFXLCfmbVoQdXc6pGRYCW1sTtc=; b=NPQB6fib7Q28lI3HSHcBWeNkuHtxnm
 0MTsVIFerK2ZiOAQI9jj4m501MGAaTBqlDtX+CCWYEy9X7US2SNV/BkkX4M6vGeF
 duTc5MiUxmKfEI0BF5BLLY4XN1Dkt/TFkuQzRvC9rzFXcPQWzxIa18tGDoyl9EYm
 EjiYc2AhrZ1jUtBYSXaosBB9HeB8MTje1LNPXCMq8cNDetx2tG3r8fGBeqG8cXWC
 3Y82jK9uwaCdUBIURhxKK7Tc9vsj/PGvsXWRyTCuC1u+03FUrDxMxJ0pELJhrfzK
 ua1wlBeUOW36d8RyoKmBachjxCP8UaTJrVvDg4NQS19+ljQ3ijS17MavC4TQLFwc
 cB7NFmMZrXwccG3uwPobuIy3kRbzbYiE4jUyHLujTHtyxCAtZsPd1LOx076VZupX
 vtPDgG7+9tFxYphewIwX1ERAp7Q+/64D0H+XpK3TD5r7hTBl+ITb2Y/w8DXGSoi4
 s0HQG0r7PRIoM/HMOfNmexE0mDoN2rhiyZ2hmCL9dZ3xS9nGBa+FVShgrr1vDUC4
 yAXIYats7Zoy9d/yliLJPTS4YvYak1qmAiudiqsHMClyEoBfeDC2OOpYdLeh6ouH
 5USDaKnVVKI64taF017eR0NMJm/0QNdRuvFcw2mzt+u0KS/3nhjB9EBFjYoJXvnL
 SIQ56pmEMuMPk=
Received: from localhost (cloudsdale.the-delta.net.eu.org [local])
 by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTPA id c776c2f8
 for <amd-gfx@lists.freedesktop.org>;
 Wed, 30 Jun 2021 14:40:39 +0000 (UTC)
From: Haelwenn (lanodan) Monnier <haelwenn@cloudsdale.the-delta.net.eu.org>
Date: Wed, 30 Jun 2021 16:40:39 +0200
To: amd-gfx@lists.freedesktop.org
Subject: amdgpu raven2 hang on gst-plugins-base testsuite
Message-ID: <YNyCZ3bzLN6Cqly6@cloudsdale.the-delta.net.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 30 Jun 2021 14:50:43 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGVsbG8sCgogUnVubmluZyB0aGUgZ3N0LXBsdWdpbnMtYmFzZSB0ZXN0c3VpdGUgbWFrZXMgbXkg
TGVub3ZvIFQ0NTkgZW50aXJlbHkgaGFuZywgdG8KdGhlIHBvaW50IHdoZXJlIGV2ZW4gU1NIIGRv
ZXNuJ3Qgd29ya3MuCiBJIGFsc28gZ2V0IHF1aXRlIHJhbmRvbSBnbGl0Y2hlcyB3aGlsZSB1c2lu
ZyBtcHYsIHNwZWNpYWxseSBIVFRQIHN0cmVhbXMgKE5GUyBpcyBmaW5lKQphbmQgYnJvd3Npbmcg
dGhlIHdlYiAod2Via2l0LWd0aywgZmlyZWZveCwgY2hyb21pdW0sIOKApikgYnV0IGluIHRoaXMg
Y2FzZQp0aGUgZHJpdmVyIG1hbmFnZXMgdG8gcmVzZXQgYWZ0ZXIgYSBiaXQuCgpBUFU6IEFNRCBS
eXplbiA1IDM1MDBVIFBybyB3LyBSYWRlb24gVmVnYSBNb2JpbGUgR2Z4ClN5c3RlbXM6Ci0gR2Vu
dG9vIExpbnV4IChsaW51eCA1LjEwLjQxICsgbWVzYSAyMS4xLjMpCi0gQWxwaW5lIExpbnV4IGVk
Z2UgKGxpbnV4LWx0cyA1LjEwLjQ2KQpSZWxldmFudCBsc3BjaSBvdXRwdXQ6CjA2OjAwLjAgVkdB
IGNvbXBhdGlibGUgY29udHJvbGxlcjogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1E
L0FUSV0gUGljYXNzbyAocmV2IGQyKQowNjowMC4xIEF1ZGlvIGRldmljZTogQWR2YW5jZWQgTWlj
cm8gRGV2aWNlcywgSW5jLiBbQU1EL0FUSV0gUmF2ZW4vUmF2ZW4yL0ZlbmdodWFuZyBIRE1JL0RQ
IEF1ZGlvIENvbnRyb2xsZXIKMDY6MDAuMiBFbmNyeXB0aW9uIGNvbnRyb2xsZXI6IEFkdmFuY2Vk
IE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gRmFtaWx5IDE3aCAoTW9kZWxzIDEwaC0xZmgpIFBs
YXRmb3JtIFNlY3VyaXR5IFByb2Nlc3NvcgowNjowMC4zIFVTQiBjb250cm9sbGVyOiBBZHZhbmNl
ZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIFJhdmVuIFVTQiAzLjEKMDY6MDAuNCBVU0IgY29u
dHJvbGxlcjogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBSYXZlbiBVU0IgMy4x
CjA2OjAwLjUgTXVsdGltZWRpYSBjb250cm9sbGVyOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJ
bmMuIFtBTURdIFJhdmVuL1JhdmVuMi9GaXJlRmxpZ2h0L1Jlbm9pciBBdWRpbyBQcm9jZXNzb3IK
MDY6MDAuNiBBdWRpbyBkZXZpY2U6IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0g
RmFtaWx5IDE3aCAoTW9kZWxzIDEwaC0xZmgpIEhEIEF1ZGlvIENvbnRyb2xsZXIKCgogSSBoYWQg
aXNzdWVzIHdpdGggbWVzYSBzdGFydGluZyBvbiAyMC4xLjEwLCBhcyBzZWVuIGluIApodHRwczov
L2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvbWVzYS9tZXNhLy0vaXNzdWVzLzQxMDAKYnV0IGV2ZW4g
b24gdGhhdCB2ZXJzaW9uIHRoZSBnc3RyZWFtZXIgdGVzdHN1aXRlIG1ha2VzIHRoZSBkaXNwbGF5
IGNyYXNoLCAKdGhlIHdob2xlIHN5c3RlbSBkb2Vzbid0IGhhbmdzIGFueW1vcmUgdGhvdWdoIGJ1
dCBJIGNvdWxkbid0IHJlY292ZXIgaXQsCkkgY2FuIHNlbmQgZG1lc2cgYW5kIG90aGVyIHN5c3Rl
bSBsb2dzIHRvIGRldmVsb3BlcnMgb24gcmVxdWVzdC4KCmJ0dyBteSBkZXNrdG9wIChBTUQgUnl6
ZW4gNyAzNzAwWCArIEFNRCBSYWRlb24gUlg1NjAwWFQpIGhhcyBhIHNpbWlsYXIgc2V0dXAKYW5k
IHRoZSBnc3QtcGx1Z2lucy1iYXNlIHRlc3RzdWl0ZSBqdXN0IHdvcmtzIGZpbmUuCgpCZXN0IHJl
Z2FyZHMsCkhhZWx3ZW5uIChsYW5vZGFuKSBNb25uaWVyCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
