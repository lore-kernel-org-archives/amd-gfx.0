Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1772C352A3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81A520661
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQNhgF6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81A520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2506EC7C;
	Mon, 10 Feb 2020 15:09:16 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70EA76EC79;
 Mon, 10 Feb 2020 15:09:15 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id t23so715007wmi.1;
 Mon, 10 Feb 2020 07:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zjyOrGYUj9i57jpKCj5rhWx6c0tUOFnm0t6zm6OvZdw=;
 b=cQNhgF6S4OiaD6AMlzvMJBMVMfI200m7v2pluST/tpBd9xArydz3pWfl5aWLh7UqSW
 ZfGCeL1ruQpxnLZn4bz+CnloCvrnDNMDI3AkoZFuidMEl/gnaGg7KGjXdv30MFRD3WOW
 erJh5wY3Ha4KL5c0zNzPTxtp3y4AtvHcS1ZgMFedIXukZU8/i1dVai4IUca1RZKHqklO
 f9btGIF0qjyxsyft2ZMDks+/jB31QZ/HrTnwjzuba1snbU7XfVS9Mz4y6PeYNOd/Gd/q
 g9ugUFvH49RUcApDCGSsUZPtkhSvOQ6EG6KaiCvhkEzwlTecq0Uri6NvugV3uohi1QEu
 hoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zjyOrGYUj9i57jpKCj5rhWx6c0tUOFnm0t6zm6OvZdw=;
 b=t+fRovhYDijAOHy3UOkSn2RqKpnQC7+ILEJyl9yOweX54RRf5QkToZyBJzzUgfLt8Q
 k+1KNbhB7Dmvq7wfHl6UpLCUQ7OIh5PSeWLgpcOHbvFy+Fm1213KpbRWjwFwO6XE6dap
 UsFY9XBu3wgTl9utpJ7TM1hTQk/f5ONfLaJQBa/O8kppGqNXvTYCSR0a+T+UnL2Q+Xvi
 qOAKJUFjqsPjTLNevE9Y6xyUvQ1sw55QPDKJUjjpkF4WvbIDIeBP1HSuThIh4A1Ol2v3
 DWVxf5KFrOH+UP8MCoiqNkhKY1POT8xFbTjW5jjSQ5XlCuSR754VpzdR6J/jKf2ZIVgj
 tgHg==
X-Gm-Message-State: APjAAAWJOzNQ+ySN4wDIjsMnYSPEkncAhC56WCrJ4+bnj/JpYRa41PE+
 S8ASq19MygvWD/i7MqnARTSU80NY
X-Google-Smtp-Source: APXvYqxuCSQz/w30RbQh1Q0bv73h/0xxoYBz5DYv/Ht+LaDg3QQ8SGqNKAAeX+vEg20nG6AlnZSQuA==
X-Received: by 2002:a1c:a515:: with SMTP id o21mr16106376wme.85.1581347354168; 
 Mon, 10 Feb 2020 07:09:14 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:7d3b:a71c:475c:1e99])
 by smtp.gmail.com with ESMTPSA id q10sm1021996wme.16.2020.02.10.07.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 07:09:13 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 2/6] drm/ttm: cleanup ttm_buffer_object_transfer
Date: Mon, 10 Feb 2020 16:09:03 +0100
Message-Id: <20200210150907.20616-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210150907.20616-1-christian.koenig@amd.com>
References: <20200210150907.20616-1-christian.koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIGZ1bmN0aW9uIGlzIGFsd2F5cyBjYWxsZWQgd2l0aCBkZWxldGVkIEJPcy4KCldoaWxlIGF0
IGl0IGNsZWFudXAgdGhlIGluZGVudGF0aW9uIGFzIHdlbGwuCgpTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fYm8uYyB8IDEyICsrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
dHRtL3R0bV9iby5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwppbmRleCAxZmJjMzZm
MDVkODkuLmMxMTA0Yzg4NTdiNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1f
Ym8uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCkBAIC01MjIsMTQgKzUyMiw5
IEBAIHN0YXRpYyBpbnQgdHRtX2JvX2NsZWFudXBfcmVmcyhzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmpl
Y3QgKmJvLAogCQkJICAgICAgIGJvb2wgaW50ZXJydXB0aWJsZSwgYm9vbCBub193YWl0X2dwdSwK
IAkJCSAgICAgICBib29sIHVubG9ja19yZXN2KQogewotCXN0cnVjdCBkbWFfcmVzdiAqcmVzdjsK
KwlzdHJ1Y3QgZG1hX3Jlc3YgKnJlc3YgPSAmYm8tPmJhc2UuX3Jlc3Y7CiAJaW50IHJldDsKIAot
CWlmICh1bmxpa2VseShsaXN0X2VtcHR5KCZiby0+ZGRlc3Ryb3kpKSkKLQkJcmVzdiA9IGJvLT5i
YXNlLnJlc3Y7Ci0JZWxzZQotCQlyZXN2ID0gJmJvLT5iYXNlLl9yZXN2OwotCiAJaWYgKGRtYV9y
ZXN2X3Rlc3Rfc2lnbmFsZWRfcmN1KHJlc3YsIHRydWUpKQogCQlyZXQgPSAwOwogCWVsc2UKQEAg
LTU0Miw5ICs1MzcsOCBAQCBzdGF0aWMgaW50IHR0bV9ib19jbGVhbnVwX3JlZnMoc3RydWN0IHR0
bV9idWZmZXJfb2JqZWN0ICpibywKIAkJCWRtYV9yZXN2X3VubG9jayhiby0+YmFzZS5yZXN2KTsK
IAkJc3Bpbl91bmxvY2soJnR0bV9ib19nbG9iLmxydV9sb2NrKTsKIAotCQlscmV0ID0gZG1hX3Jl
c3Zfd2FpdF90aW1lb3V0X3JjdShyZXN2LCB0cnVlLAotCQkJCQkJCSAgIGludGVycnVwdGlibGUs
Ci0JCQkJCQkJICAgMzAgKiBIWik7CisJCWxyZXQgPSBkbWFfcmVzdl93YWl0X3RpbWVvdXRfcmN1
KHJlc3YsIHRydWUsIGludGVycnVwdGlibGUsCisJCQkJCQkgMzAgKiBIWik7CiAKIAkJaWYgKGxy
ZXQgPCAwKQogCQkJcmV0dXJuIGxyZXQ7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
