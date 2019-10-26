Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289C2CA9EA0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 08:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025E020B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 08:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025E020B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4BA86E49F;
	Mon, 28 Oct 2019 08:24:07 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F00AD897E0
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Oct 2019 08:00:35 +0000 (UTC)
Received: from localhost (unknown [89.205.133.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EFAB22084C;
 Sat, 26 Oct 2019 08:00:34 +0000 (UTC)
Date: Sat, 26 Oct 2019 10:00:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] drm/radeon: Fix EEH during kexec
Message-ID: <20191026080032.GA554748@kroah.com>
References: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Mailman-Approved-At: Mon, 28 Oct 2019 08:24:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1572076835;
 bh=YXMQf5PUTMkCC2s+CE+39AbzWTqptkOht2Sq57tjNEw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jwXBsxUR/7gmBK7NOUOjgaueLmoNE2diYy8YjeJgqoNIWycx6QKzpjKEuEqojwrqC
 Nr1pI/y9R1CAP2/Zl9Sa7kINANKmqdzvWoXP3sKFNRl6H1C3RAgnzvKO+Y6lNIKHi3
 jN7ECHpWhVJ5gS2cvFgmQWhbw23OHszHhFfgHg00=
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191026080032.nMutL1_UMbIOZUsYoBvA-vwc9FHZMjcfS7Sf93GJgiw@z>

T24gRnJpLCBPY3QgMjUsIDIwMTkgYXQgMDM6NDA6NTBQTSAtMDUwMCwgS3lsZU1haGxrdWNoIHdy
b3RlOgo+IEZyb206IEt5bGUgTWFobGt1Y2ggPGttYWhsa3VjQGxpbnV4LnZuZXQuaWJtLmNvbT4K
PiAKPiBEdXJpbmcga2V4ZWMgc29tZSBhZGFwdGVycyBoaXQgYW4gRUVIIHNpbmNlIHRoZXkgYXJl
IG5vdCBwcm9wZXJseQo+IHNodXQgZG93biBpbiB0aGUgcmFkZW9uX3BjaV9zaHV0ZG93bigpIGZ1
bmN0aW9uLiBBZGRpbmcKPiByYWRlb25fc3VzcGVuZF9rbXMoKSBmaXhlcyB0aGlzIGlzc3VlLgo+
IEVuYWJsZWQgb25seSBvbiBQUEMgYmVjYXVzZSB0aGlzIHBhdGNoIGNhdXNlcyBpc3N1ZXMgb24g
c29tZSBvdGhlcgo+IGJvYXJkcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBLeWxlIE1haGxrdWNoIDxr
bWFobGt1Y0BsaW51eC52bmV0LmlibS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX2Rydi5jIHwgMTQgKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKykKCjxmb3JtbGV0dGVyPgoKVGhpcyBpcyBub3QgdGhlIGNvcnJlY3Qgd2F5
IHRvIHN1Ym1pdCBwYXRjaGVzIGZvciBpbmNsdXNpb24gaW4gdGhlCnN0YWJsZSBrZXJuZWwgdHJl
ZS4gIFBsZWFzZSByZWFkOgogICAgaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRl
c3QvcHJvY2Vzcy9zdGFibGUta2VybmVsLXJ1bGVzLmh0bWwKZm9yIGhvdyB0byBkbyB0aGlzIHBy
b3Blcmx5LgoKPC9mb3JtbGV0dGVyPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
