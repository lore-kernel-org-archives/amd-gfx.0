Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BCEC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9FB65100
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9FB65100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF6B89EA6;
	Mon,  8 Mar 2021 13:40:48 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE60B89EA3
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 13:40:47 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id w9so14718435edt.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 05:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F5X50fIPf7AS4Ikx9oASMV11s/Yp5h27CPWMvBf97p0=;
 b=nODiZTonSvEiq+yuvGXYNZUO0EX9LbfEKyJM0oHMiYPQIWWtJ7ILnqTTqeIx+CKkaK
 yCWg405pK/wWgBEvaMidgdevx0/jxpKjAifwQe7g4l1H7b+XYRIVQBDZl77ezcCJb3SM
 0oEHAMsPBlRpUPj3S8L3xKbBTjQ78h2rv4QHF8BzOM7kP0WNy1cg31rbevkBMKsE84or
 eWOr4RjKJSZsqEzH8y4n5RdfSlhPM+J6kSjqJWWTrVN+lg938QD1o6KnQ3Alai/szGML
 Veb+P02A5M/WQbpivEmvO1ADmpEtMsORL/2AqFcUQUu6+J0QR0RpCXOQT+O1yOUduXRP
 33Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F5X50fIPf7AS4Ikx9oASMV11s/Yp5h27CPWMvBf97p0=;
 b=ew9kHe1EHHYTMyHdMccUZhbSmfkIb/3/L7ozT18/VaHy0P7ZCJ5m3dtngr0jgq20l2
 jL7iX3dMk8SBAhhk4S/gH+SePOjRoiZwAoCdQTa2PtjIVoSkqYbdy2oT6PVICo4AH6H8
 9Uz+en5ZrFUZmS3hVUaWBQuaOD/5YMUAwmNOoCN6F7LvUk7hDh2RFK0YJGfUR0tI0ejs
 I+bBaGkCyoiHyNveyL9f73fO3lT66XsPcheH+9dNU7FLAgziv+vqZSZARy1vAY4lLakL
 jqQNTugLkEESoKavqWtkqg6wDjZkOOmxEtkJ4HUZCz9w0/BxpoTA2b93mgONS8f8kQPu
 Bsog==
X-Gm-Message-State: AOAM532n+IrO+ZnY0nPlsT1dghEcho2xxKiyCG1/NsrVm2n+8deQMtqP
 /HfiU/QTk58WJtcQgYmv+eLCjW3q7IB9dQ==
X-Google-Smtp-Source: ABdhPJz9iFFY4byOGx5vOP9JFS5P90FiVF4kH94F/85aL8LTB+Sa3/EwqxO8ZV+ZEGjROSJQznBiiQ==
X-Received: by 2002:a50:ec96:: with SMTP id e22mr22295908edr.385.1615210846279; 
 Mon, 08 Mar 2021 05:40:46 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f480:31ac:e949:bf58])
 by smtp.gmail.com with ESMTPSA id s18sm6655701ejc.79.2021.03.08.05.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 05:40:45 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Arunpravin.PaneerSelvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amdgpu: new resource cursor
Date: Mon,  8 Mar 2021 14:40:37 +0100
Message-Id: <20210308134044.133658-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

QWxsb3dzIHRvIHdhbGsgb3ZlciB0aGUgZHJtX21tIG5vZGVzIGluIGEgVFRNIHJlc291cmNlIG9i
amVjdC4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KQWNrZWQtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPgpUZXN0ZWQtYnk6
IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KLS0tCiAuLi4vZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yZXNfY3Vyc29yLmggICAgfCAxMDUgKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMTA1IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc19jdXJzb3IuaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMDAwMDAwLi4xMzM1ZTA5ODUxMGYKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCkBAIC0wLDAgKzEsMTA1
IEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBNSVQKKy8qCisgKiBD
b3B5cmlnaHQgMjAyMCBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuCisgKgorICogUGVybWlz
c2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24gb2J0
YWluaW5nIGEKKyAqIGNvcHkgb2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVu
dGF0aW9uIGZpbGVzICh0aGUgIlNvZnR3YXJlIiksCisgKiB0byBkZWFsIGluIHRoZSBTb2Z0d2Fy
ZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0aW9uCisgKiB0
aGUgcmlnaHRzIHRvIHVzZSwgY29weSwgbW9kaWZ5LCBtZXJnZSwgcHVibGlzaCwgZGlzdHJpYnV0
ZSwgc3VibGljZW5zZSwKKyAqIGFuZC9vciBzZWxsIGNvcGllcyBvZiB0aGUgU29mdHdhcmUsIGFu
ZCB0byBwZXJtaXQgcGVyc29ucyB0byB3aG9tIHRoZQorICogU29mdHdhcmUgaXMgZnVybmlzaGVk
IHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoKKyAqCisgKiBU
aGUgYWJvdmUgY29weXJpZ2h0IG5vdGljZSBhbmQgdGhpcyBwZXJtaXNzaW9uIG5vdGljZSBzaGFs
bCBiZSBpbmNsdWRlZCBpbgorICogYWxsIGNvcGllcyBvciBzdWJzdGFudGlhbCBwb3J0aW9ucyBv
ZiB0aGUgU29mdHdhcmUuCisgKgorICogVEhFIFNPRlRXQVJFIElTIFBST1ZJREVEICJBUyBJUyIs
IFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQsIEVYUFJFU1MgT1IKKyAqIElNUExJRUQsIElO
Q0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8gVEhFIFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklM
SVRZLAorICogRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5EIE5PTklORlJJTkdF
TUVOVC4gIElOIE5PIEVWRU5UIFNIQUxMCisgKiBUSEUgQ09QWVJJR0hUIEhPTERFUihTKSBPUiBB
VVRIT1IoUykgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMgT1IKKyAqIE9USEVSIExJ
QUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJX
SVNFLAorICogQVJJU0lORyBGUk9NLCBPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBT
T0ZUV0FSRSBPUiBUSEUgVVNFIE9SCisgKiBPVEhFUiBERUFMSU5HUyBJTiBUSEUgU09GVFdBUkUu
CisgKgorICogQXV0aG9yczogQ2hyaXN0aWFuIEvDtm5pZworICovCisKKyNpZm5kZWYgX19BTURH
UFVfUkVTX0NVUlNPUl9IX18KKyNkZWZpbmUgX19BTURHUFVfUkVTX0NVUlNPUl9IX18KKworI2lu
Y2x1ZGUgPGRybS9kcm1fbW0uaD4KKyNpbmNsdWRlIDxkcm0vdHRtL3R0bV9yZXNvdXJjZS5oPgor
CisvKiBzdGF0ZSBiYWNrIGZvciB3YWxraW5nIG92ZXIgdnJhbV9tZ3IgYW5kIGd0dF9tZ3IgYWxs
b2NhdGlvbnMgKi8KK3N0cnVjdCBhbWRncHVfcmVzX2N1cnNvciB7CisJdWludDY0X3QJCXN0YXJ0
OworCXVpbnQ2NF90CQlzaXplOworCXVpbnQ2NF90CQlyZW1haW5pbmc7CisJc3RydWN0IGRybV9t
bV9ub2RlCSpub2RlOworfTsKKworLyoqCisgKiBhbWRncHVfcmVzX2ZpcnN0IC0gaW5pdGlhbGl6
ZSBhIGFtZGdwdV9yZXNfY3Vyc29yCisgKgorICogQHJlczogVFRNIHJlc291cmNlIG9iamVjdCB0
byB3YWxrCisgKiBAc3RhcnQ6IFN0YXJ0IG9mIHRoZSByYW5nZQorICogQHNpemU6IFNpemUgb2Yg
dGhlIHJhbmdlCisgKiBAY3VyOiBjdXJzb3Igb2JqZWN0IHRvIGluaXRpYWxpemUKKyAqCisgKiBT
dGFydCB3YWxraW5nIG92ZXIgdGhlIHJhbmdlIG9mIGFsbG9jYXRpb25zIGJldHdlZW4gQHN0YXJ0
IGFuZCBAc2l6ZS4KKyAqLworc3RhdGljIGlubGluZSB2b2lkIGFtZGdwdV9yZXNfZmlyc3Qoc3Ry
dWN0IHR0bV9yZXNvdXJjZSAqcmVzLAorCQkJCSAgICB1aW50NjRfdCBzdGFydCwgdWludDY0X3Qg
c2l6ZSwKKwkJCQkgICAgc3RydWN0IGFtZGdwdV9yZXNfY3Vyc29yICpjdXIpCit7CisJc3RydWN0
IGRybV9tbV9ub2RlICpub2RlOworCisJaWYgKCFyZXMgfHwgIXJlcy0+bW1fbm9kZSkgeworCQlj
dXItPnN0YXJ0ID0gc3RhcnQ7CisJCWN1ci0+c2l6ZSA9IHNpemU7CisJCWN1ci0+cmVtYWluaW5n
ID0gc2l6ZTsKKwkJY3VyLT5ub2RlID0gTlVMTDsKKwkJcmV0dXJuOworCX0KKworCUJVR19PTihz
dGFydCArIHNpemUgPiByZXMtPm51bV9wYWdlcyA8PCBQQUdFX1NISUZUKTsKKworCW5vZGUgPSBy
ZXMtPm1tX25vZGU7CisJd2hpbGUgKHN0YXJ0ID4gbm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUKQor
CQlzdGFydCAtPSBub2RlKystPnNpemUgPDwgUEFHRV9TSElGVDsKKworCWN1ci0+c3RhcnQgPSAo
bm9kZS0+c3RhcnQgPDwgUEFHRV9TSElGVCkgKyBzdGFydDsKKwljdXItPnNpemUgPSAobm9kZS0+
c2l6ZSA8PCBQQUdFX1NISUZUKSAtIHN0YXJ0OworCWN1ci0+cmVtYWluaW5nID0gc2l6ZTsKKwlj
dXItPm5vZGUgPSBub2RlOworfQorCisvKioKKyAqIGFtZGdwdV9yZXNfbmV4dCAtIGFkdmFuY2Ug
dGhlIGN1cnNvcgorICoKKyAqIEBjdXI6IHRoZSBjdXJzb3IgdG8gYWR2YW5jZQorICogQHNpemU6
IG51bWJlciBvZiBieXRlcyB0byBtb3ZlIGZvcndhcmQKKyAqCisgKiBNb3ZlIHRoZSBjdXJzb3Ig
QHNpemUgYnl0ZXMgZm9yd3JhZCwgd2Fsa2luZyB0byB0aGUgbmV4dCBub2RlIGlmIG5lY2Vzc2Fy
eS4KKyAqLworc3RhdGljIGlubGluZSB2b2lkIGFtZGdwdV9yZXNfbmV4dChzdHJ1Y3QgYW1kZ3B1
X3Jlc19jdXJzb3IgKmN1ciwgdWludDY0X3Qgc2l6ZSkKK3sKKwlzdHJ1Y3QgZHJtX21tX25vZGUg
Km5vZGUgPSBjdXItPm5vZGU7CisKKwlCVUdfT04oc2l6ZSA+IGN1ci0+cmVtYWluaW5nKTsKKwor
CWN1ci0+cmVtYWluaW5nIC09IHNpemU7CisJaWYgKCFjdXItPnJlbWFpbmluZykKKwkJcmV0dXJu
OworCisJY3VyLT5zaXplIC09IHNpemU7CisJaWYgKGN1ci0+c2l6ZSkgeworCQljdXItPnN0YXJ0
ICs9IHNpemU7CisJCXJldHVybjsKKwl9CisKKwljdXItPm5vZGUgPSArK25vZGU7CisJY3VyLT5z
dGFydCA9IG5vZGUtPnN0YXJ0IDw8IFBBR0VfU0hJRlQ7CisJY3VyLT5zaXplID0gbWluKG5vZGUt
PnNpemUgPDwgUEFHRV9TSElGVCwgY3VyLT5yZW1haW5pbmcpOworfQorCisjZW5kaWYKLS0gCjIu
MjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
