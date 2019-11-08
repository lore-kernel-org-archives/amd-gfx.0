Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5821BFC6196
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 21:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375052084D
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 21:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375052084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00AB86E0C4;
	Fri,  8 Nov 2019 21:28:18 +0000 (UTC)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B8C6E0C4
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 21:28:15 +0000 (UTC)
Received: by mail-il1-x143.google.com with SMTP id q1so5700502ile.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Nov 2019 13:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dn86zogeYJDmr8ejJH+kBkkqL4RmdjXOvjJ7mDqTpr4=;
 b=rpD+cNdPnbhPmbHwxgVNfGGX46dh1oqEIB6Uv387m3PHTIwAMMrab2foC6+x9KtkIr
 x+Ox+KR5VXDlEkFdJjNJ6+ojb+4UHJTPXL5IGjjZlm/Lq3FuTTnSFMyWsSk/HUiIZghm
 auTVS4r0NIqMDkk4BZUAcu7zF0zNRvhGt8q39iYtj8RU/mS4oJMQS+WmOuRlXbnWAxaA
 nUH124nVnf6PVZ3k1eb0JZPvUMrZyxSj+khWaw0guQl/mWul6nOroHzDqUJ9c/CnTtxX
 /0jZSu+MgVAsHKgZ2fBntGdJMbTJOblIHPenug87PPYKqj1Bl9DU7HeN91sp1S4R5v9o
 LXKQ==
X-Gm-Message-State: APjAAAWuGN9PPuNny69m6H1bCP61MrU0d+w9f/QLAqz0eCMNsLG3DiZ+
 v0jC3w/cB8CkSw6O06HPCQ1OaphhH9rVsA==
X-Google-Smtp-Source: APXvYqyF9c0ukWdxLnbwJ7N4HaZlT0eIbRY/C1Kvt6SVhhdHjuFr8o+7ZzB3+98eabEO/FLHRsOz0Q==
X-Received: by 2002:a92:db10:: with SMTP id b16mr15621672iln.1.1573248494989; 
 Fri, 08 Nov 2019 13:28:14 -0800 (PST)
Received: from localhost.localdomain ([2602:47:da84:5600:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id
 g11sm961732ilq.39.2019.11.08.13.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 13:28:14 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	Evan.Quan@amd.com
Subject: [PATCH v2 0/3] navi10: Implement overdrive pp_od_clk_voltage
Date: Fri,  8 Nov 2019 14:28:05 -0700
Message-Id: <cover.1573248368.git.mcoffin13@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dn86zogeYJDmr8ejJH+kBkkqL4RmdjXOvjJ7mDqTpr4=;
 b=i+ZVg0m3rixu3MylBkKjdVHTKIeo+YCKQQWn3W95Peu4Y/im/WxmseOXwsP48bVTIX
 52L2RbzDRggIZUnXhCHv5FAtq2TlNhhWpC2WGZQtU42d7OVynZIjao6pQv78XGm6jzLI
 zBLohBQvWIh+WWQLvwksU6dmqX3XoUPIPB/6iwHl9kuhNQJ+SM/rcHomN8Xf2rQt7huk
 YaKI54BdIQgEjLxp4B8tklAS2asLHAG8iD/r/gq+FVKuZPgDpyIee0dQI+h/7lglAG5L
 qoWfaZzij+ghVrVREuhqpI0Dhp4C4vOJrcqAd5CscS1IaAivgmvGrgretu5pnC8rSbGu
 Ct2w==
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
Cc: Alexander.Deucher@amd.com, Matt Coffin <mcoffin13@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108212805.t935wmltZhHAAW0bIi2DL7GN6Bpsh1CMqr-OvY17ttM@z>

W1doeV0KQmVmb3JlIHRoaXMgcGF0Y2hzZXQsIG5hdmkxMCB1c2VycyBjb3VsZCBub3QgdXRpbGl6
ZSB0aGUgb3ZlcmRyaXZlCmZ1bmN0aW9uYWxpdHkuIFRoaXMgcHJldmVudGVkIHRoZW0gZnJvbSBv
dmVyY2xvY2tpbmcsIG92ZXJ2b2x0aW5nLCBvcgp1bmRlcnZvbHRpbmcgdGhlaXIgY2FyZHMuCgpb
SG93XQpTaW1pbGFyIHRvIHRoZSB2ZWdhMjAgaW1wbGVtZW50YXRpb24sIGFkZCB0aGUgcHBfb2Rf
Y2xrX3ZvbHRhZ2UKaW50ZXJmYWNlIHRvIHRoZSBuYXZpMTAgcG93ZXJwbGF5IHRhYmxlLgoKW1Bv
c3NpYmxlIEFsdGVybmF0aXZlc10KVGhpcyBjb3VsZCBhbHNvIGJlIGRvbmUgbW9yZSBnZW5lcmlj
YWxseSBpbiBzbXVfdjExXzAgY29kZSwgYnV0IHdvdWxkCnJlcXVpcmUgbW9yZSBzaWduaWZpY2Fu
dCBjaGFuZ2VzIHRvIHRoZSB2ZWdhMjAgY29kZSwgYW5kIGZlYXR1cmUtZ2F0aW5nCmJhc2VkIG9u
IGNoaXAgY2FwYWJpbGl0aWVzIGluIHRoZSBzbXUgdG8gZGlzYWJsZSBvdmVyZHJpdmUgZm9yIGFy
Y3RlcnVzLgpJIGNob3NlIHRoaXMgcGF0aCBzbyBhcyBub3QgdG8gY29tcGxldGVseSByZWZhY3Rv
ciB0aGUgdmVnYTIwIHNpZGUgb2YKdGhpbmdzLCBhbmQgaW50cm9kdWNlIFNNVSBjb2RlIHdoaWNo
IHdvdWxkIG5vdCBwbGF5IG5pY2VseSB3aXRoIG5ldwpBU0lDcy4KCnYyOiByZWJhc2Ugb2ZmIGxh
dGVzdCBjb2RlLCBhbmQgcmVtb3ZlIGFuIGluY29ycmVjdCBib3VuZHMgY2hlY2sKCk1hdHQgQ29m
ZmluICgzKToKICBkcm0vYW1kZ3B1L25hdmkxMDogaW1wbGVtZW50IHNjbGsvbWNsayBPRCB2aWEg
cHBfb2RfY2xrX3ZvbHRhZ2UKICBkcm0vYW1kZ3B1L25hdmkxMDogaW1wbGVtZW50IEdGWENMS19D
VVJWRSBvdmVyZHJpdmUKICBkcm0vYW1kZ3B1L25hdmkxMDogSW1wbGVtZW50IG9kIGNsayBwcmlu
dGluZwoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjExXzAuaCB8ICAg
MiArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgICAgfCAyODIg
KysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBf
cHB0LmggICAgfCAgIDIgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8w
LmMgICAgIHwgIDI3ICsrCiA0IGZpbGVzIGNoYW5nZWQsIDMxMyBpbnNlcnRpb25zKCspCgotLSAK
Mi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
