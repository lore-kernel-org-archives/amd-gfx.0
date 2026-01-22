Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68178C44536
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 06:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0557D10E8EB;
	Thu, 22 Jan 2026 06:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="AviskXnW";
	dkim-atps=neutral
X-Greylist: delayed 367 seconds by postgrey-1.36 at gabe;
 Thu, 22 Jan 2026 06:45:18 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 883F010E249;
 Thu, 22 Jan 2026 06:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=8CK5jvCEjZaFYLQYoZXkEENe4Tnp4vbjlGczZ89edr4=; b=A
 viskXnWYQ0DpZ3HeAt0DEjXT7KX5KRh0ZUetPugTt8Mz2JZ+b5R1Un+4YewTXuWF
 Fy5XKZ6dX0VN6AHtif4EVGM85Cgq3eNuVnjibGsWGUsqUho0bHVzYmJg6sFiVFi9
 6QrQFX1rjlcsWsaeCAPI1u4Qw6AiGv6mZ6zy4chWSI=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-107 (Coremail) ; Thu, 22 Jan 2026 14:30:33 +0800
 (CST)
X-Originating-IP: [58.22.7.114]
Date: Thu, 22 Jan 2026 14:30:33 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, 
 "Rodrigo Siqueira" <siqueira@igalia.com>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Sandy Huang" <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Andy Yan" <andy.yan@rock-chips.com>,
 "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>,
 "Dmitry Baryshkov" <lumag@kernel.org>,
 "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Rob Herring" <robh@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 kernel@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re:[PATCH v7 09/22] drm/rockchip: Add YUV422 output mode constants
 for VOP2
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260121-color-format-v7-9-ef790dae780c@collabora.com>
References: <20260121-color-format-v7-0-ef790dae780c@collabora.com>
 <20260121-color-format-v7-9-ef790dae780c@collabora.com>
X-CM-CTRLMSGS: VGsUV3BsdXM9MTc2OTA2MzQzMjEwNF80ZGY5MTA1NWM2ZGEzOWU1N2NiM2Y4Y
 WE1NDkyMWViMA==
X-NTES-SC: AL_Qu2dC/ydvEwo5SCeZekfmUgWjuw/WsG1v/Ul1YBSP556jCHp1zA+YHtOI0XuzsGkOiqykTu2XSVH2/VTe6Bkepsbla4s24V6ov96gBpNliJpeg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <ce42aa7.51d0.19be465c36f.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: aygvCgDXvwQJxHFpWHhcAA--.14313W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbCxQnpSGlxxAleLwAA3J
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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

CgpIZWxsbywKCkF0IDIwMjYtMDEtMjEgMjI6NDU6MTYsICJOaWNvbGFzIEZyYXR0YXJvbGkiIDxu
aWNvbGFzLmZyYXR0YXJvbGlAY29sbGFib3JhLmNvbT4gd3JvdGU6Cj5UaGUgUm9ja2NoaXAgZGlz
cGxheSBjb250cm9sbGVyIGhhcyBhIGdlbmVyYWwgWVVWNDIyIG91dHB1dCBtb2RlLCBhbmQKPnNv
bWUgU29DLXNwZWNpZmljIGNvbm5lY3Rvci1zcGVjaWZpYyBvdXRwdXQgbW9kZXMgZm9yIFJLMzU3
Ni4KPgo+QWRkIHRoZW0sIGJhc2VkIG9uIHRoZSB2YWx1ZXMgaW4gZG93bnN0cmVhbSBhbmQgdGhl
IFRSTSAoZHNwX291dF9tb2RlIGluCj5SSzM1NzYgVFJNIFBhcnQgMiwgcmVnaXN0ZXIgUE9TVCpf
Q1RSTF9QT1NUX0RTUF9DVFJMKS4KPgo+U2lnbmVkLW9mZi1ieTogTmljb2xhcyBGcmF0dGFyb2xp
IDxuaWNvbGFzLmZyYXR0YXJvbGlAY29sbGFib3JhLmNvbT4KCiAgIFJldmlld2VkLWJ5OiBBbmR5
IFlhbiA8YW5keXNocmtAMTYzLmNvbT4KCgo+LS0tCj4gZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlw
L3JvY2tjaGlwX2RybV9kcnYuaCB8IDQgKysrKwo+IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKykKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9k
cm1fZHJ2LmggYi9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX2Rydi5oCj5p
bmRleCAyZTg2YWQwMDk3OWMuLjQ3MDVkYzZiOGJkNyAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fZHJ2LmgKPisrKyBiL2RyaXZlcnMvZ3B1L2RybS9y
b2NrY2hpcC9yb2NrY2hpcF9kcm1fZHJ2LmgKPkBAIC0zMCwxMCArMzAsMTQgQEAKPiAjZGVmaW5l
IFJPQ0tDSElQX09VVF9NT0RFX1A1NjUJCTIKPiAjZGVmaW5lIFJPQ0tDSElQX09VVF9NT0RFX0JU
NjU2CQk1Cj4gI2RlZmluZSBST0NLQ0hJUF9PVVRfTU9ERV9TODg4CQk4Cj4rI2RlZmluZSBST0NL
Q0hJUF9PVVRfTU9ERV9ZVVY0MjIJOQo+ICNkZWZpbmUgUk9DS0NISVBfT1VUX01PREVfUzg4OF9E
VU1NWQkxMgo+ICNkZWZpbmUgUk9DS0NISVBfT1VUX01PREVfWVVWNDIwCTE0Cj4gLyogZm9yIHVz
ZSBzcGVjaWFsIG91dGZhY2UgKi8KPiAjZGVmaW5lIFJPQ0tDSElQX09VVF9NT0RFX0FBQUEJCTE1
Cj4rLyogU29DIHNwZWNpZmljIG91dHB1dCBtb2RlcyAqLwo+KyNkZWZpbmUgUk9DS0NISVBfT1VU
X01PREVfWVVWNDIyX1JLMzU3Nl9EUAkxMgo+KyNkZWZpbmUgUk9DS0NISVBfT1VUX01PREVfWVVW
NDIyX1JLMzU3Nl9IRE1JCTEzCj4gCj4gLyogb3V0cHV0IGZsYWdzICovCj4gI2RlZmluZSBST0NL
Q0hJUF9PVVRQVVRfRFNJX0RVQUwJQklUKDApCj4KPi0tIAo+Mi41Mi4wCg==
