Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B49C17441
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C300D20818
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C300D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8AF6E26C;
	Mon, 11 Nov 2019 17:48:55 +0000 (UTC)
X-Greylist: delayed 1308 seconds by postgrey-1.36 at gabe;
 Mon, 11 Nov 2019 17:47:25 UTC
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com
 [192.185.146.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDD889A75
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 17:47:25 +0000 (UTC)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
 by gateway33.websitewelcome.com (Postfix) with ESMTP id 37E8C611B7C
 for <amd-gfx@lists.freedesktop.org>;
 Mon, 11 Nov 2019 11:25:36 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id UDRXigYbM3Qi0UDRXi0cfY; Mon, 11 Nov 2019 11:25:36 -0600
X-Authority-Reason: nr=8
Received: from [187.192.2.30] (port=45762 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.92)
 (envelope-from <gustavo@embeddedor.com>)
 id 1iUDRU-001CZi-Un; Mon, 11 Nov 2019 11:25:33 -0600
Date: Mon, 11 Nov 2019 11:25:43 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Mikita Lipski <mikita.lipski@amd.com>, Lyude Paul <lyude@redhat.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH] drm/amd/display: Fix unsigned variable compared to less than
 zero
Message-ID: <20191111172543.GA31748@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.2.30
X-Source-L: No
X-Exim-ID: 1iUDRU-001CZi-Un
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.2.30]:45762
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-Mailman-Approved-At: Mon, 11 Nov 2019 17:48:54 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
 Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=obJGNctpNomw0ORl8GMTnOXHVQTOW6QwMfGlRbchZDQ=; b=viQc/KpkyqpjaooaNayckCTFw5
 jPT+0IfyxeHPWb8eVLnXjU0UNzYGM+p0EvVAX8Ex1+EUwP1W+zbACBcdlQaS8+bCFJnU7q1PjsXXu
 bC0NPhCyZxaLPIp76IzUT8B2V/swRFzeHxsKtalaVs43Pc8DQ+vNNE1B+cJA78YL3wZ6fl9fZegLg
 n4/aIk6NZOtbzzNEKxJad2pCp/locExG7MJulTuSwcfXn/84kPBCbUQGwylAdhgCNHGmU9h4XCBqs
 Br+CFXHcgMvh2BTDHzYfbkhfWPE8MP1uDDjm0hnx5Tltn0FYqZ7SvKEb7Peel/MPrZ9EbCzSs3rHL
 giAKWVQg==;
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111172543.39l1NU3hw1NCG7Xmt_Ft274CQlEQL2AAFmQ-FJStUKI@z>

Q3VycmVubHksIHRoZSBlcnJvciBjaGVjayBiZWxvdyBvbiB2YXJpYWJsZSAqdmNwaV9zbG90cyog
aXMgYWx3YXlzCmZhbHNlIGJlY2F1c2UgaXQgaXMgYSB1aW50NjRfdCB0eXBlIHZhcmlhYmxlLCBo
ZW5jZSwgdGhlIHZhbHVlcwp0aGlzIHZhcmlhYmxlIGNhbiBob2xkIGFyZSBuZXZlciBsZXNzIHRo
YW4gemVybzoKCmRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
LmM6CjQ4NzAgICAgICAgICBpZiAoZG1fbmV3X2Nvbm5lY3Rvcl9zdGF0ZS0+dmNwaV9zbG90cyA8
IDApIHsKNDg3MSAgICAgICAgICAgICAgICAgRFJNX0RFQlVHX0FUT01JQygiZmFpbGVkIGZpbmRp
bmcgdmNwaSBzbG90czogJWRcbiIsIChpbnQpZG1fbmV3X2Nvbm5lY3Rvcl9zdGF0ICAgICBlLT52
Y3BpX3Nsb3RzKTsKNDg3MiAgICAgICAgICAgICAgICAgcmV0dXJuIGRtX25ld19jb25uZWN0b3Jf
c3RhdGUtPnZjcGlfc2xvdHM7CjQ4NzMgICAgICAgICB9CgpGaXggdGhpcyBieSBtYWtpbmcgKnZj
cGlfc2xvdHMqIG9mIGludCB0eXBlLgoKQWRkcmVzc2VzLUNvdmVyaXR5OiAxNDg3ODM4ICgiVW5z
aWduZWQgY29tcGFyZWQgYWdhaW5zdCAwIikKRml4ZXM6IGI0YzU3OGYwODM3OCAoImRybS9hbWQv
ZGlzcGxheTogQWRkIE1TVCBhdG9taWMgcm91dGluZXMiKQpTaWduZWQtb2ZmLWJ5OiBHdXN0YXZv
IEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmggfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaAppbmRleCA2ZGIwN2U5ZTMzYWIuLmE4
ZmM5MGE5MjdkNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5oCkBAIC00MDMsNyArNDAzLDcgQEAgc3RydWN0IGRtX2Nvbm5lY3Rvcl9z
dGF0ZSB7CiAJYm9vbCB1bmRlcnNjYW5fZW5hYmxlOwogCWJvb2wgZnJlZXN5bmNfY2FwYWJsZTsK
IAl1aW50OF90IGFibV9sZXZlbDsKLQl1aW50NjRfdCB2Y3BpX3Nsb3RzOworCWludCB2Y3BpX3Ns
b3RzOwogCXVpbnQ2NF90IHBibjsKIH07CiAKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
