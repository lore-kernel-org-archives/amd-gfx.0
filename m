Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5703C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DDE6509D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DDE6509D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E436EB8D;
	Fri,  5 Mar 2021 14:23:20 +0000 (UTC)
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8243A6EB8E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 14:23:19 +0000 (UTC)
Received: from tux.applied-asynchrony.com (p5b07e8e5.dip0.t-ipconnect.de
 [91.7.232.229])
 by mail.itouring.de (Postfix) with ESMTPSA id 36D1911DD5E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:23:18 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
 by tux.applied-asynchrony.com (Postfix) with ESMTP id 1134EF01617
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:23:18 +0100 (CET)
To: amd-gfx@lists.freedesktop.org
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: [PATCH] drm/amdgpu/display: use GFP_ATOMIC in
 dcn21_validate_bandwidth_fp()
Organization: Applied Asynchrony, Inc.
Message-ID: <eac22f1b-ad84-ea5a-1c6e-ac55656f1be2@applied-asynchrony.com>
Date: Fri, 5 Mar 2021 15:23:18 +0100
MIME-Version: 1.0
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWZ0ZXIgZml4aW5nIG5lc3RlZCBGUFUgY29udGV4dHMgY2F1c2VkIGJ5IDQxNDAxYWM2Nzc5MSB3
ZSdyZSBzdGlsbCBzZWVpbmcKY29tcGxhaW50cyBhYm91dCBzcHVyaW91cyBrZXJuZWxfZnB1X2Vu
ZCgpLiBBcyBpdCB0dXJucyBvdXQgdGhpcyB3YXMKYWxyZWFkeSBmaXhlZCBmb3IgZGNuMjAgaW4g
Y29tbWl0IGY0MWVkODhjYmQgKCJkcm0vYW1kZ3B1L2Rpc3BsYXk6CnVzZSBHRlBfQVRPTUlDIGlu
IGRjbjIwX3ZhbGlkYXRlX2JhbmR3aWR0aF9pbnRlcm5hbCIpIGJ1dCBuZXZlciBtb3ZlZApmb3J3
YXJkIHRvIGRjbjIxLgoKU2lnbmVkLW9mZi1ieTogSG9sZ2VyIEhvZmZzdMOkdHRlIDxob2xnZXJA
YXBwbGllZC1hc3luY2hyb255LmNvbT4KLS0tCiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMgfCAyICstCiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYwppbmRleCAwNzJmOGM4ODA5MjQuLjFh
Y2FkZjlmNTYxOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
bjIxL2RjbjIxX3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjbjIxL2RjbjIxX3Jlc291cmNlLmMKQEAgLTEzMzksNyArMTMzOSw3IEBAIHN0YXRpYyBub2lu
bGluZSBib29sIGRjbjIxX3ZhbGlkYXRlX2JhbmR3aWR0aF9mcChzdHJ1Y3QgZGMgKmRjLAogIAlp
bnQgdmxldmVsID0gMDsKICAJaW50IHBpcGVfc3BsaXRfZnJvbVtNQVhfUElQRVNdOwogIAlpbnQg
cGlwZV9jbnQgPSAwOwotCWRpc3BsYXlfZTJlX3BpcGVfcGFyYW1zX3N0ICpwaXBlcyA9IGt6YWxs
b2MoZGMtPnJlc19wb29sLT5waXBlX2NvdW50ICogc2l6ZW9mKGRpc3BsYXlfZTJlX3BpcGVfcGFy
YW1zX3N0KSwgR0ZQX0tFUk5FTCk7CisJZGlzcGxheV9lMmVfcGlwZV9wYXJhbXNfc3QgKnBpcGVz
ID0ga3phbGxvYyhkYy0+cmVzX3Bvb2wtPnBpcGVfY291bnQgKiBzaXplb2YoZGlzcGxheV9lMmVf
cGlwZV9wYXJhbXNfc3QpLCBHRlBfQVRPTUlDKTsKICAJRENfTE9HR0VSX0lOSVQoZGMtPmN0eC0+
bG9nZ2VyKTsKICAKICAJQldfVkFMX1RSQUNFX0NPVU5UKCk7Ci0tIAoyLjMwLjEKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
