Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6979C3A5A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 06:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75142145D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 06:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75142145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8786C6E25F;
	Mon, 20 Apr 2020 06:59:13 +0000 (UTC)
Received: from mail-m127108.qiye.163.com (mail-m127108.qiye.163.com
 [115.236.127.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E9136E125
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 00:56:51 +0000 (UTC)
Received: from vivo.com (wm-13.qy.internal [127.0.0.1])
 by mail-m127108.qiye.163.com (Hmail) with ESMTP id 21F458422E8;
 Mon, 20 Apr 2020 08:56:16 +0800 (CST)
Message-ID: <AA2AnwCHCIqvuawqjhyAZKo2.3.1587344176120.Hmail.bernard@vivo.com>
To: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogUmV0dXJuIG1vcmUgZXJyb3IgY29kZXMgaW4gYW1kZ3B1X2Nvbm5lY3Rvcl9zZXRfcHJvcGVydHkoKQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <a00cc21a-383f-67ca-cdc5-b727ae59d31c@web.de>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail (
 [127.0.0.1] ) ; Mon, 20 Apr 2020 08:56:16 +0800 (GMT+08:00)
From: =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date: Mon, 20 Apr 2020 08:56:16 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VISEJLS0tJSU5LTUxKT1lXWShZQU
 hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSEtJTENOSUlON1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6Okk6FQw4MzgyCg0OGgwKERMCOiEwFElVSFVKTkNMSE9PSkxNSUpJVTMWGhIXVRkeCRUaCR87
 DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBT01OQjcG
X-HM-Tid: 0a719515f416986ckuuu21f458422e8
X-Mailman-Approved-At: Mon, 20 Apr 2020 06:59:07 +0000
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
Cc: opensource.kernel@vivo.com, Chunming Zhou <David1.Zhou@amd.com>,
 Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cgrlj5Hku7bkurrvvJpNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPgrlj5Hp
gIHml6XmnJ/vvJoyMDIwLTA0LTE5IDE3OjM0OjQ3CuaUtuS7tuS6uu+8mkJlcm5hcmQgWmhhbyA8
YmVybmFyZEB2aXZvLmNvbT4sYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcsZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyxBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+LCJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPixDaHVu
bWluZyBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgrmioTpgIHkurrvvJpBbmRyemVqIFBpZXRy
YXNpZXdpY3ogPGFuZHJ6ZWoucEBjb2xsYWJvcmEuY29tPixEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+LERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4sRGhpbmFrYXJhbiBQYW5k
aXlhbiA8ZGhpbmFrYXJhbi5wYW5kaXlhbkBpbnRlbC5jb20+LCJKb3PDqSBSb2JlcnRvIGRlIFNv
dXphIiA8am9zZS5zb3V6YUBpbnRlbC5jb20+LEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+
LE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT4sU2FtIFJhdm5ib3JnIDxz
YW1AcmF2bmJvcmcub3JnPixsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLG9wZW5zb3VyY2Uu
a2VybmVsQHZpdm8uY29tCuS4u+mimO+8mlJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFJldHVybiBt
b3JlIGVycm9yIGNvZGVzIGluIGFtZGdwdV9jb25uZWN0b3Jfc2V0X3Byb3BlcnR5KCk+PiBUaGUg
ImlmKCFlbmNvZGVyKSIgYnJhbmNoIHJldHVybiB0aGUgc2FtZSB2YWx1ZSAwIG9mIHRoZSBzdWNj
ZXNzCj4+IGJyYW5jaCwgbWF5YmUgcmV0dXJuIC1FSU5WQUwgaXMgbW9yZSBiZXR0ZXIuCj4KPkkg
c3VnZ2VzdCB0byBpbXByb3ZlIHRoZSBjb21taXQgbWVzc2FnZS4KClN1cmUuCgo+Cj4qIFdvdWxk
IHlvdSBsaWtlIHRvIGFkanVzdCB0aGUgcGF0Y2ggc3ViamVjdD8KPgo+KiBIb3cgZG8geW91IHRo
aW5rIGFib3V0IHRvIGFkZCB0aGUgdGFnIOKAnEZpeGVz4oCdCj4gIGJlY2F1c2Ugb2YgYWRqdXN0
bWVudHMgZm9yIHRoZSBleGNlcHRpb24gaGFuZGxpbmc/CgpUaGlzIGlzIGEgZ29vZCBpZGVhLCB0
aGUgY29kZSB3aWxsIGJlIG1vcmUgaW4gbGluZSB3aXRoIHRoZSBMaW51eCBzcGVjaWZpY2F0aW9u
cy4KSSB3aWxsIGFkanVzdCB0aGlzIHBhdGNoIGNvbW1pdCBtZXNzYWdlIGFuZCBtb2RpZnkgdGhl
IGNvZGUuIEkgd2lsbCBzdWJtaXQgaXQgYWdhaW4uCgo+Cj5SZWdhcmRzLAo+TWFya3VzCg0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
