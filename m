Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEEDC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 03:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABCC60F4B
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 03:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5ABCC60F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07E66F3A5;
	Fri, 30 Jul 2021 03:25:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C1A6F39C;
 Fri, 30 Jul 2021 03:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=UoUNO6SpxNZD8Kp5rDs7cJKyFvYdXqxIuqfJvEub1Mw=; b=ucmvasQyzJtn31aB4P2X78i/2y
 WGRcNUGJMLzlw2x+7VuL1yP5J+LpB1ljOzytIidamb08eRhyfn+niwxax2AqAUcd4dKXm6p1/VeRZ
 4MmxD9NN8f1wCwmYjvaq+XMPwWJYS5wk7Ha1LIia9iJjncXjq0VqYnz1PpILaJHVZKrfr0ckfA5GT
 +ccKpF25wV1W6pn+aKw/1PZjJV8YuVzDBPkmMQ31TFY3hWJ0RP3GbKCtpqsaGrssPFUp2dMX5Kk7y
 U/0J0FFaYn8slPT3+tOa+NXhXdmHD7RFanIAVP7UWcT9TBPZZGCwoTgmyTl7JrCHq7aAQf6Cn42ro
 oHvha7RA==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m9IoO-006n2H-Cd; Fri, 30 Jul 2021 03:03:48 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -next] drm/amdgpu: fix checking pmops when PM_SLEEP is not
 enabled
Date: Thu, 29 Jul 2021 20:03:47 -0700
Message-Id: <20210730030347.13996-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 30 Jul 2021 03:25:07 +0000
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
Cc: Randy Dunlap <rdunlap@infradead.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 dri-devel@lists.freedesktop.org, linux-next@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

J3BtX3N1c3BlbmRfdGFyZ2V0X3N0YXRlJyBpcyBvbmx5IGF2YWlsYWJsZSB3aGVuIENPTkZJR19Q
TV9TTEVFUAppcyBzZXQvZW5hYmxlZC4gT1RPSCwgd2hlbiBib3RoIFNVU1BFTkQgYW5kIEhJQkVS
TkFUSU9OIGFyZSBub3Qgc2V0LApQTV9TTEVFUCBpcyBub3Qgc2V0LCBzbyB0aGlzIHZhcmlhYmxl
IGNhbm5vdCBiZSB1c2VkLgoKLi4vZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Fj
cGkuYzogSW4gZnVuY3Rpb24g4oCYYW1kZ3B1X2FjcGlfaXNfczBpeF9hY3RpdmXigJk6Ci4uL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmM6MTA0NjoxMTogZXJyb3I6IOKA
mHBtX3N1c3BlbmRfdGFyZ2V0X3N0YXRl4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlz
IGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuIOKAmF9fS1NZTV9wbV9zdXNwZW5kX3RhcmdldF9zdGF0
ZeKAmT8KICAgIHJldHVybiBwbV9zdXNwZW5kX3RhcmdldF9zdGF0ZSA9PSBQTV9TVVNQRU5EX1RP
X0lETEU7CiAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KICAgICAgICAgICBfX0tT
WU1fcG1fc3VzcGVuZF90YXJnZXRfc3RhdGUKCkFsc28gdXNlIHNob3J0ZXIgSVNfRU5BQkxFRChD
T05GSUdfZm9vKSBub3RhdGlvbiBmb3IgY2hlY2tpbmcgdGhlCjIgY29uZmlnIHN5bWJvbHMuCgpG
aXhlczogOTFiMDNmYzZiNTBjICgiZHJtL2FtZGdwdTogQ2hlY2sgcG1vcHMgZm9yIGRlc2lyZWQg
c3VzcGVuZCBzdGF0ZSIpClNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZy
YWRlYWQub3JnPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpD
YzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogIlBhbiwg
WGluaHVpIiA8WGluaHVpLlBhbkBhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW5leHRA
dmdlci5rZXJuZWwub3JnCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Fj
cGkuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKLS0tIGxpbmV4dC0yMDIxMDcyOS5vcmlnL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hY3BpLmMKKysrIGxpbmV4dC0yMDIxMDcyOS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYWNwaS5jCkBAIC0xMDQwLDcgKzEwNDAsNyBAQCB2b2lkIGFtZGdwdV9hY3Bp
X2RldGVjdCh2b2lkKQogICovCiBib29sIGFtZGdwdV9hY3BpX2lzX3MwaXhfYWN0aXZlKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQogewotI2lmIGRlZmluZWQoQ09ORklHX0FNRF9QTUMpIHx8
IGRlZmluZWQoQ09ORklHX0FNRF9QTUNfTU9EVUxFKQorI2lmIElTX0VOQUJMRUQoQ09ORklHX0FN
RF9QTUMpICYmIElTX0VOQUJMRUQoQ09ORklHX1BNX1NMRUVQKQogCWlmIChhY3BpX2dibF9GQURU
LmZsYWdzICYgQUNQSV9GQURUX0xPV19QT1dFUl9TMCkgewogCQlpZiAoYWRldi0+ZmxhZ3MgJiBB
TURfSVNfQVBVKQogCQkJcmV0dXJuIHBtX3N1c3BlbmRfdGFyZ2V0X3N0YXRlID09IFBNX1NVU1BF
TkRfVE9fSURMRTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
