Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443FC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAE520659
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgAnGRoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAE520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D0016E0D6;
	Wed, 11 Nov 2020 18:45:16 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0643B6E0A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 18:35:50 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id c9so3148292wml.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 10:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M8WfWuBVHXpKLzkSsKEOW6BSD/IfhCkoHkgxrNpz2cI=;
 b=KgAnGRoSC1GGHgGKylBif9BORNSvke76zr6Ku+V2dpq5zX/ppUCMXa6BZ50PLao2Su
 wgMZIci54WmiIRlv8BP3RviUmpLeGnDrlWpT6nIPxFotxzTAPnKotPe48UujpPlgD+j1
 y1GFe4cT54dk/av5cvpir2oc4RKEJtEREIwDqO8uIAsrZA6vLqrSIwrugO7Kdxktf/1n
 APlL9KK3h7FFRXMHlz+ivY3DTvNGku3VsEE63RyF5f30IzuZl+NKcYSA4FkgXUhQm8Pl
 CSyACifcZE6IrPwhFTqwNJUSD2NAOtiS+lrdG37fTlJOeWaAa6tQWymx0POpAzKY9VAR
 fXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M8WfWuBVHXpKLzkSsKEOW6BSD/IfhCkoHkgxrNpz2cI=;
 b=dexOV5xlNQFY/PDzKoEcvi1yykoB4IA0wSEZDL6J3pC6efdrMuCKWF4xFadZ+UBe+P
 Z3Cr5CRdOVKiYWWX/U5j//52qemeb8wi/Le34N7F6TXtE3nII+LdWFjrNcBhj94pcGNh
 qSOkOOLEQkYdGi75WxqZ0baidKWqJBSwQphebqyGrfhRa0kj74mLnlEI7GZ9GZc5Qx78
 03sjqu6QhjmGDz2YNMILOo9fy/sPosd0yF8N453Ld4nADiyThSKbkJPQO7IZ4R71dOmf
 791PD42ukpnS/woNNLaKqQ31osmiaxZHENVb8uHV/34P8iDEX8k8G26GbYspX4TxfqWn
 x3yg==
X-Gm-Message-State: AOAM5338B9xL83Pcck8uLqBy+O4Idna2oz5VI6OfT7HNHeoQJahHnras
 8y3WaG4utPhRgIbbkjvwRu4aVQ==
X-Google-Smtp-Source: ABdhPJwzCQY8CRZfDnAapb8rqhTNiyryIG+qh+R7rglcXlJeolDgqhoxLc5LLh/U2O6/sDSnl1BcJQ==
X-Received: by 2002:a7b:cd92:: with SMTP id y18mr5624982wmj.178.1605119748648; 
 Wed, 11 Nov 2020 10:35:48 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 10:35:47 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 00/19] [Set 5] Rid W=1 warnings from GPU
Date: Wed, 11 Nov 2020 18:35:26 +0000
Message-Id: <20201111183545.1756994-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Nov 2020 18:45:15 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Slava Grigorev <slava.grigorev@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBzZXQgaXMgcGFydCBvZiBhIGxhcmdlciBlZmZvcnQgYXR0ZW1wdGluZyB0byBjbGVhbi11
cCBXPTEKa2VybmVsIGJ1aWxkcywgd2hpY2ggYXJlIGN1cnJlbnRseSBvdmVyd2hlbG1pbmdseSBy
aWRkbGVkIHdpdGgKbmlnZ2x5IGxpdHRsZSB3YXJuaW5ncy4KClRoaXMgZmluaXNoZXMgY2xlYW5p
bmcgdXAgUmFkZW9uLiAgQU1EIG5leHQhCgpMZWUgSm9uZXMgKDE5KToKICBkcm0vcmFkZW9uL2V2
ZXJncmVlbl9kbWE6IE1vdmUgJ2V2ZXJncmVlbl9ncHVfY2hlY2tfc29mdF9yZXNldCgpJ3MKICAg
IHByb3RvdHlwZSB0byBzaGFyZWQgaGVhZGVyCiAgZHJtL3JhZGVvbi9yNjAwOiBNb3ZlICdldmVy
Z3JlZW5fcmxjX3Jlc3VtZSgpJ3MgcHJvdG90eXBlIHRvIHNoYXJlZAogICAgaGVhZGVyCiAgZHJt
L3JhZGVvbi9uaV9kbWE6IE1vdmUgJ2NheW1hbl9ncHVfY2hlY2tfc29mdF9yZXNldCgpJ3MgcHJv
dG90eXBlIHRvCiAgICBzaGFyZWQgaGVhZGVyCiAgZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3M6
IE1vdmUgJ3JhZGVvbl9hZGRfYXRvbV9lbmNvZGVyKCkncwogICAgcHJvdG90eXBlIHRvIHNoYXJl
ZCBoZWFkZXIKICBkcm0vcmFkZW9uL3JhZGVvbl9lbmNvZGVyczogTW92ZSAncmFkZW9uX2F0b21f
YmFja2xpZ2h0X2luaXQncwogICAgcHJvdG90eXBlIHRvIHNoYXJlZCBoZWFkZXIKICBkcm0vcmFk
ZW9uL2NpX2RwbTogTW92ZSAnY2lfKigpJ3MgcHJvdG90eXBlcyB0byBzaGFyZWQgaGVhZGVyCiAg
ZHJtL3JhZGVvbi9zaV9kcG06IE1vdmUgJ3NpX21jX2xvYWRfbWljcm9jb2RlKCkncyBwcm90b3R5
cGUgdG8gc2hhcmVkCiAgICBoZWFkZXIKICBkcm0vcmFkZW9uL3NpX2RtYTogTW92ZSAnc2lfZ3B1
X2NoZWNrX3NvZnRfcmVzZXQoKSdzIHByb3RvdHlwZSB0bwogICAgc2hhcmVkIGhlYWRlcgogIGRy
bS9yYWRlb24vY2lrOiBNb3ZlICdzaV8qKCkncyBwcm90b3R5cGVzIHRvIHNoYXJlZCBoZWFkZXIK
ICBkcm0vcmFkZW9uL2J0Y19kcG06IE1vdmUgJ2V2ZXJncmVlbl9nZXRfcGkncyBwcm90b3R5cGUg
dG8gc2hhcmVkCiAgICBoZWFkZXIKICBkcm0vcmFkZW9uL3JhZGVvbl9hdWRpbzogTW92ZSAnZGNl
Nl8qKCkncyBwcm90b3R5cGVzIHRvIHNoYXJlZCBoZWFkZXIKICBkcm0vcmFkZW9uL2V2ZXJncmVl
bjogTW92ZSAnc2lfZ2V0X2NzYl8qKCkncyBwcm90b3R5cGVzIHRvIHNoYXJlZAogICAgaGVhZGVy
CiAgZHJtL3JhZGVvbi9jaWtfc2RtYTogTW92ZSAnYW1kZ3B1X2Npa19ncHVfY2hlY2tfc29mdF9y
ZXNldCgpJ3MKICAgIHByb3RvdHlwZSB0byBzaGFyZWQgaGVhZGVyCiAgZHJtL3JhZGVvbi9ldmVy
Z3JlZW46IE1vdmUgJ2Npa18qKCkncyBwcm90b3R5cGVzIHRvIHNoYXJlZCBoZWFkZXIKICBkcm0v
cmFkZW9uL2NpX2RwbTogTW92ZSAnc2lfKigpJ3MgcHJvdG90eXBlcyB0byBzaGFyZWQgaGVhZGVy
CiAgZHJtL3JhZGVvbi9jaWs6IE1vdmUgJ01vdmUgJ2Npa19zZG1hXyooKSdzIHByb3RvdHlwZXMg
dG8gc2hhcmVkIGhlYWRlcgogIGRybS9yYWRlb24vc2lfZHBtOiBNb3ZlICd2Y2VfdjFfMF9lbmFi
bGVfbWdjZygpJ3MgcHJvdG90eXBlIHRvIHNoYXJlZAogICAgaGVhZGVyCiAgZHJtL3JhZGVvbi9j
aWs6IE1vdmUgJ3ZjZV92Ml8wX2VuYWJsZV9tZ2NnKCkncyBwcm90b3R5cGUgdG8gc2hhcmVkCiAg
ICBoZWFkZXIKICBkcm0vcmFkZW9uL2V2ZXJncmVlbl9jczogTW92ZSAncjYwMF9kbWFfY3NfbmV4
dF9yZWxvYygpJ3MgcHJvdG90eXBlIHRvCiAgICBzaGFyZWQgaGVhZGVyCgogZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9idGNfZHBtLmMgICAgICAgICB8ICAzICstCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL2NpX2RwbS5jICAgICAgICAgIHwgMTMgKy0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L2Npay5jICAgICAgICAgICAgIHwgMTAgKystLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lr
LmggICAgICAgICAgICAgfCA0MCArKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vY2lrX3NkbWEuYyAgICAgICAgfCAgMyArLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9j
eXByZXNzX2RwbS5jICAgICB8ICAzICstCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2RjZTZfYWZt
dC5jICAgICAgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9kY2U2X2FmbXQuaCAgICAg
ICB8IDUyICsrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9l
dmVyZ3JlZW4uYyAgICAgICB8ICA4ICstLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdy
ZWVuLmggICAgICAgfCAgNCArKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW5fY3Mu
YyAgICB8ICAzICstCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbl9kbWEuYyAgIHwg
IDMgKy0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vbmkuaCAgICAgICAgICAgICAgfCAgMSArCiBk
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pX2RtYS5jICAgICAgICAgIHwgIDMgKy0KIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vbmlfZHBtLmMgICAgICAgICAgfCAgMyArLQogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yNjAwLmMgICAgICAgICAgICB8ICAyICstCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3I2MDAuaCAgICAgICAgICAgIHwgIDQgKysKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMF9j
cy5jICAgICAgICAgfCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlv
cy5jIHwgIDQgLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmggfCAg
OCArKysrCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdWRpby5jICAgIHwgMTcgKy0t
LS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2VuY29kZXJzLmMgfCAgNiArLS0K
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcnY3NzBfZHBtLmMgICAgICAgfCAgMSArCiBkcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3NpLmMgICAgICAgICAgICAgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9zaS5oICAgICAgICAgICAgICB8IDM4ICsrKysrKysrKysrKysrKysrCiBkcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3NpX2RtYS5jICAgICAgICAgIHwgIDMgKy0KIGRyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vc2lfZHBtLmMgICAgICAgICAgfCAgOCArKy0tCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3NpX2RwbS5oICAgICAgICAgIHwgIDUgKysrCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Ry
aW5pdHlfZHBtLmMgICAgIHwgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vdmNlLmggICAg
ICAgICAgICAgfCAzNSArKysrKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Zj
ZV92MV8wLmMgICAgICAgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi92Y2VfdjJfMC5j
ICAgICAgICB8ICAxICsKIDMyIGZpbGVzIGNoYW5nZWQsIDIxNSBpbnNlcnRpb25zKCspLCA3MiBk
ZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Np
ay5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9kY2U2X2FmbXQu
aAogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2kuaAogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vdmNlLmgKCkNjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBEYXZpZCBBaXJsaWUgPGFp
cmxpZWRAbGludXguaWU+CkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBs
aW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVs
Lm9yZwpDYzogU2xhdmEgR3JpZ29yZXYgPHNsYXZhLmdyaWdvcmV2QGFtZC5jb20+CkNjOiBTdW1p
dCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgotLSAKMi4yNS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
