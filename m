Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E08CA9EC9
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 23:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA0D20869
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 23:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA0D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuetzel-hh.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E716E8AF;
	Mon,  4 Nov 2019 23:10:52 +0000 (UTC)
X-Greylist: delayed 401 seconds by postgrey-1.36 at gabe;
 Mon, 04 Nov 2019 23:10:51 UTC
Received: from mail.ud03.udmedia.de (ud03.udmedia.de [194.117.254.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259316E8AF
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 23:10:50 +0000 (UTC)
Received: (qmail 24866 invoked from network); 5 Nov 2019 00:04:08 +0100
Received: by mail.ud03.udmedia.de with ESMTPA; 5 Nov 2019 00:04:08 +0100
X-UD-Smtp-Session: ud03?335p7@QjY/VY2W/sjCdf4e
MIME-Version: 1.0
Date: Tue, 05 Nov 2019 00:04:08 +0100
From: =?UTF-8?Q?Dieter_N=C3=BCtzel?= <Dieter@nuetzel-hh.de>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: [amd-staging-drm-nex] Planned move to 5.4-rc6+ soon?
Message-ID: <fa2e4af9689cc1fd566876ff8438a90f@nuetzel-hh.de>
X-Sender: Dieter@nuetzel-hh.de
User-Agent: Roundcube Webmail/1.3.10
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=nuetzel-hh.de;
 h=
 mime-version:content-type:content-transfer-encoding:date:from:to
 :cc:subject:message-id; s=k1; bh=8rI/LPqz+iPSm9NndSnTla0bf35gleg
 oA/E2mElLHfA=; b=UWmtQ6mUg1nZg+yiMwW9QZSW5MK0CxxYbng39Ge2sGJ11cV
 7fUfVYstkxl11DX1h+McRimzOY2PWrH6KpKzQo+1Dwo6bQ+DnI/AYrFj4dtkbpRZ
 +nhJOyVOamASDi3TlHicvRY93+nE1t/oyIT8nviOnb2cDnY9zbgB4GJOq27Y=
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
Cc: amd-devel <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191104230408.v1LV_IGl6WG-PGw8S2ORG022c1yeEeMEoqI1yboguho@z>

SGVsbG8gQWxleCwKCmxpa2UgQU1ELi4uOy0pCgpbV2h5XQo1LjMtcmNYICgtcmMzKQotIGhhcyBi
cm9rZW4gKHJlZ3Jlc3NlZCkgYmxvY2sgbGF5ZXIgKENEL0RWRCwgZ2FtZXMuLi4pIC0gZml4ZWQg
aW4gNS4zIApmaW5hbAotIEFDUEkgKHBvd2VyIG1hbmFnZW1lbnQpIHJlZ3Jlc3Npb24gLSBmaXhl
ZCBpbiA1LjMgZmluYWwKLSBVU0IgMy4xLzMuMiByZWdyZXNzaW9uICg1LjAwMCB2cyAxMC4wMDAg
TWJpdC9zIG1vZGUsIGluIHVzZSBoZWF2aWx5IApoZXJlKQogICAgZXZlbiB3aXRoIEFNRCdzIHBh
cnRuZXIgQVNNZWRpYSAoQVNNIDIxNDIrIGNoaXBzKSAtIGZpeGVkIGluIDUuNC1yYyAKKCEhISkK
LSBOYXZpIHByb2JsZW1zIChlLmcuIFNETUEpIHNvbWUgcHJvZ3Jlc3MvbWl0aWdhdGlvbiB3aXRo
IDUuNC1yYwoKW0hvd10KU3dpdGNoIHRvIDUuNC1yYzQgKG9yIGJldHRlciAtcmM2KSBhcyBzb29u
IGFzIHBvc3NpYmxlCgpCYWNrIHRvIHBwIHBvd2VyIGNvbnN1bXB0aW9uIHRlc3RpbmcgdGhlbi4u
LgoKR3JlZXRpbmdzLApEaWV0ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
