Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C74C5ACC0
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 08:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F64920650
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 08:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UkwhbhqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F64920650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E4F66EA4C;
	Thu, 12 Mar 2020 08:08:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03AE96E048;
 Thu, 12 Mar 2020 05:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=gFogYY0/ImH1QufcGk6my12bIHUguG4a5p71bzDoCOs=; b=UkwhbhqOAz87LxbUSVhtkWzVvM
 MBrHjo2j2hz1s7U8WycJh4oUvDONSmz86VBpGj57m+963BcjnHP/SCwe1hOqgFvOTEFw7sZNo6TDg
 UD9k83tzSyfQBRZNnDi3+5NblrKyGk37ipjwHkihxAyVEiREaj0SN7N2fgTneyAMc+UMg90hgpz9k
 UByP278mvDVthyNfX5v5affR6EyQWVwRXTIbvwdzXmCG4vXUeyjeqrKRmF5lNyeafkYk3Mi7N5cIp
 +ajv7BfLamoJfVBdpFnlsFFFHXOPfuEIQpL8+y0gKMLoTBUEMyvvuKze4F0SrsAcRfsDqX5Yr07og
 a7uqDCiQ==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCGcP-0004dW-EG; Thu, 12 Mar 2020 05:42:53 +0000
To: LKML <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] drm: amd/acp: fix broken menu structure
Message-ID: <6c252c3d-5d0a-2a2f-4b8c-60d7622d1146@infradead.org>
Date: Wed, 11 Mar 2020 22:42:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Mailman-Approved-At: Thu, 12 Mar 2020 08:08:20 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+CgpGaXggdGhlIEtjb25m
aWcgZGVwZW5kZW5jaWVzIHNvIHRoYXQgdGhlIG1lbnUgaXMgcHJlc2VudGVkCmNvcnJlY3RseSBi
eSBhZGRpbmcgYSBkZXBlbmRlbmN5IG9uIERSTV9BTURHUFUgdG8gdGhlICJtZW51IgpLY29uZmln
IHN0YXRlbWVudC4gIFRoaXMgbWFrZXMgYSBjb250aW51b3VzIGRlcGVuZGVuY3kgb24KRFJNX0FN
REdQVSBpbiB0aGUgRFJNIEFNRCBtZW51cyBhbmQgZWxpbWluYXRlcyBhIGJyb2tlbiBtZW51CnN0
cnVjdHVyZS4KCkZpeGVzOiBhOGZlNThjZWMzNTEgKCJkcm0vYW1kOiBhZGQgQUNQIGRyaXZlciBz
dXBwb3J0IikKU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5v
cmc+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCAoQ2h1bk1p
bmcpIFpob3UgPERhdmlkMS5aaG91QGFtZC5jb20+CkNjOiBNYXJ1dGhpIEJheXlhdmFyYXB1IDxt
YXJ1dGhpLmJheXlhdmFyYXB1QGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYWNwL0tjb25maWcgfCAgICAxICsKIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKLS0tIGxpbnV4LW5leHQub3JpZy9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FjcC9LY29uZmlnCisrKyBsaW51eC1uZXh0L2RyaXZlcnMvZ3B1L2RybS9hbWQv
YWNwL0tjb25maWcKQEAgLTEsNSArMSw2IEBACiAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBN
SVQKIG1lbnUgIkFDUCAoQXVkaW8gQ29Qcm9jZXNzb3IpIENvbmZpZ3VyYXRpb24iCisJZGVwZW5k
cyBvbiBEUk1fQU1ER1BVCiAKIGNvbmZpZyBEUk1fQU1EX0FDUAogCWJvb2wgIkVuYWJsZSBBTUQg
QXVkaW8gQ29Qcm9jZXNzb3IgSVAgc3VwcG9ydCIKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
