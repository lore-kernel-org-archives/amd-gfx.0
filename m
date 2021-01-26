Return-Path: <SRS0=fKyo=G5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F6C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 14:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145FF230FC
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 14:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145FF230FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B9B6E452;
	Tue, 26 Jan 2021 14:32:18 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6883E6E452
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 14:32:17 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id f11so19772813ljm.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 06:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9bMKL3NLiISIhuoWywI8w28sB2JvUz2qFE3uQLpy1lM=;
 b=cpb45VTbgZt6ol3z4vfdrWyJ3LMv3cxGx3G1Q5HrQAqyWVZEe3ZNfcatWedO25X6sd
 i0JaI/piTYzdgKrsAXunppTdYiZlvt9oPFO6E68QhnZNCLWnuJ28b16PRv8w+cg0xFA2
 sv8yYu1sY7u/GUBVvbzvc76P7eZEz9hwmvytt6FBsHxjtlE47/leA7dVjYRKU7c0DWjI
 UmExZxS5XFK+dkr71g08FVBYJ4jjCXY4c5qg+3WkVslA4jIac+LonMHSMI2jAjzCu8VM
 Vi1zs6njZLsqEv+aVbVkC8OEN2VhadQX4islC/Ehc0pVLK5Bk3DJVUWB8ny+zpCn7hNu
 xmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9bMKL3NLiISIhuoWywI8w28sB2JvUz2qFE3uQLpy1lM=;
 b=tdWA6Jymh/kYzyZesWtVZjy4DQuhe+t81GLSDnfiEarBhdlpcjU/PelPJs3I7OW6cs
 zMAzRUa6YCgVRgLrAMEG21huzAd7OU6aRfjffYY3QFZB04Ymg9Ry8C9ATw+1sBGoJ/pc
 2NzeoRGlMG91pr2IYA5GQy53OipVIJfoPrDomUSnV4a+w8jxz3AjzCSYiIpCHRuig64J
 H0Z3NRdn8DZQ30srL8l9x7Exm8JBxjVe1FElZ15ksSw2KGx35nkK5E9SSpFb7ocVyX9J
 F1yON073kL2dMz+C+kFdal6GcmeueUkFGeFS/dbCrjj8CxjmPWZGpaWg+M0yEOgMr9io
 mkTQ==
X-Gm-Message-State: AOAM530mZdWKEq4L1sFtcPZF1Fl5/7s49Eoba8rWPHnPk4GjL2BUdBRG
 BrP6wwyQJS1BSEfFJGFlmYyPYEzyCrRdZw==
X-Google-Smtp-Source: ABdhPJwH/SJ40yz524xIutVtYORZ120Epn8o05oaWWKQRYht7Kb4aFto9y/xa7+ge+5MEc+0BOuSmQ==
X-Received: by 2002:a2e:88c2:: with SMTP id a2mr3057037ljk.415.1611671535476; 
 Tue, 26 Jan 2021 06:32:15 -0800 (PST)
Received: from localhost.localdomain (c83-254-138-119.bredband.comhem.se.
 [83.254.138.119])
 by smtp.gmail.com with ESMTPSA id y3sm3209945ljc.131.2021.01.26.06.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 06:32:14 -0800 (PST)
From: =?UTF-8?q?Ernst=20Sj=C3=B6strand?= <ernstp@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Add DC feature flag to disable audio
Date: Tue, 26 Jan 2021 15:31:55 +0100
Message-Id: <20210126143155.16479-1-ernstp@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
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
Cc: =?UTF-8?q?Ernst=20Sj=C3=B6strand?= <ernstp@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2l0aCB0aGUgcHJlLURDIHBhdGggeW91IGNvdWxkIHNldCBhdWRpbz0wIHRvIGRpc2FibGUgYXVk
aW8uClRoaXMgYWRkcyBhIHNpbWlsYXIgZmVhdHVyZSBmb3IgdGhlIERDIHBhdGggd2l0aAphbWRn
cHUuZGNmZWF0dXJlbWFzaz0weDEwLgoKU2lnbmVkLW9mZi1ieTogRXJuc3QgU2rDtnN0cmFuZCA8
ZXJuc3RwQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5jIHwgMyArKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjX3Jlc291cmNlLmMgfCA3ICsrKystLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kYy5oICAgICAgICAgICAgICAgfCAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVk
ZS9hbWRfc2hhcmVkLmggICAgICAgICAgfCAxICsKIDQgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IGU0OTBmYzI0ODZmNy4uMzIyZDk0MzliOWMy
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMKQEAgLTEwMTMsNiArMTAxMyw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtX2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJaWYgKGFtZGdwdV9kY19mZWF0dXJlX21hc2sgJiBE
Q19ESVNBQkxFX0ZSQUNUSU9OQUxfUFdNX01BU0spCiAJCWluaXRfZGF0YS5mbGFncy5kaXNhYmxl
X2ZyYWN0aW9uYWxfcHdtID0gdHJ1ZTsKIAorCWlmIChhbWRncHVfZGNfZmVhdHVyZV9tYXNrICYg
RENfRElTQUJMRV9BVURJTykKKwkJaW5pdF9kYXRhLmZsYWdzLmRpc2FibGVfYXVkaW8gPSB0cnVl
OworCiAJaW5pdF9kYXRhLmZsYWdzLnBvd2VyX2Rvd25fZGlzcGxheV9vbl9ib290ID0gdHJ1ZTsK
IAogCWluaXRfZGF0YS5zb2NfYm91bmRpbmdfYm94ID0gYWRldi0+ZG0uc29jX2JvdW5kaW5nX2Jv
eDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jl
c291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJj
ZS5jCmluZGV4IDY4YjY1YTA5MGQxNy4uNGNjMGQyMzA4Yzk4IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMKQEAgLTIxNDEsOSArMjE0
MSwxMCBAQCBlbnVtIGRjX3N0YXR1cyByZXNvdXJjZV9tYXBfcG9vbF9yZXNvdXJjZXMoCiAJCXRy
dWUpOwogCiAJLyogVE9ETzogQWRkIGNoZWNrIGlmIEFTSUMgc3VwcG9ydCBhbmQgRURJRCBhdWRp
byAqLwotCWlmICghc3RyZWFtLT5jb252ZXJ0ZXJfZGlzYWJsZV9hdWRpbyAmJgotCSAgICBkY19p
c19hdWRpb19jYXBhYmxlX3NpZ25hbChwaXBlX2N0eC0+c3RyZWFtLT5zaWduYWwpICYmCi0JICAg
IHN0cmVhbS0+YXVkaW9faW5mby5tb2RlX2NvdW50ICYmIHN0cmVhbS0+YXVkaW9faW5mby5mbGFn
cy5hbGwpIHsKKwlpZiAoIWRjLT5jb25maWcuZGlzYWJsZV9hdWRpbyAmJgorCQkhc3RyZWFtLT5j
b252ZXJ0ZXJfZGlzYWJsZV9hdWRpbyAmJgorCQlkY19pc19hdWRpb19jYXBhYmxlX3NpZ25hbChw
aXBlX2N0eC0+c3RyZWFtLT5zaWduYWwpICYmCisJCXN0cmVhbS0+YXVkaW9faW5mby5tb2RlX2Nv
dW50ICYmIHN0cmVhbS0+YXVkaW9faW5mby5mbGFncy5hbGwpIHsKIAkJcGlwZV9jdHgtPnN0cmVh
bV9yZXMuYXVkaW8gPSBmaW5kX2ZpcnN0X2ZyZWVfYXVkaW8oCiAJCSZjb250ZXh0LT5yZXNfY3R4
LCBwb29sLCBwaXBlX2N0eC0+c3RyZWFtX3Jlcy5zdHJlYW1fZW5jLT5pZCwgZGNfY3R4LT5kY2Vf
dmVyc2lvbik7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Yy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKaW5kZXggNzFkNDZhZGUy
NGU1Li4yYWI2ZDc3MGM2NmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kYy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCkBAIC0y
OTcsNiArMjk3LDcgQEAgc3RydWN0IGRjX2NvbmZpZyB7CiAJYm9vbCBtdWx0aV9tb25fcHBfbWNs
a19zd2l0Y2g7CiAJYm9vbCBkaXNhYmxlX2RtY3U7CiAJYm9vbCBlbmFibGVfNHRvMU1QQzsKKwli
b29sIGRpc2FibGVfYXVkaW87CiAjaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04pCiAJ
Ym9vbCBjbGFtcF9taW5fZGNmY2xrOwogI2VuZGlmCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRl
L2FtZF9zaGFyZWQuaAppbmRleCA5Njc2MDE2YTM3Y2UuLjcyMDJkODE2YTk3ZSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaAorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oCkBAIC0yMjAsNiArMjIwLDcgQEAgZW51
bSBEQ19GRUFUVVJFX01BU0sgewogCURDX01VTFRJX01PTl9QUF9NQ0xLX1NXSVRDSF9NQVNLID0g
MHgyLAogCURDX0RJU0FCTEVfRlJBQ1RJT05BTF9QV01fTUFTSyA9IDB4NCwKIAlEQ19QU1JfTUFT
SyA9IDB4OCwKKwlEQ19ESVNBQkxFX0FVRElPID0gMHgxMCwKIH07CiAKIGVudW0gRENfREVCVUdf
TUFTSyB7Ci0tIAoyLjI3LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
