Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76710C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF326186A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF326186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE756E1C0;
	Wed, 17 Feb 2021 19:00:33 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA21B6E1C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 19:00:31 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id p2so3922802edm.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 11:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ykCAFUzqVNsEPgl0VhMVK/gZ1GJuZopumNi6NQSi9kg=;
 b=qWXiRTgB0q27olWN9SNMeDJwazFnGbTssOL4UHWn7YEjf/2lhHqNrwX8XnkVnWtauS
 ncJgbWsSMVdKuUa+1COrG4NUNljki1ban+CnbLPpdr8M2fcwVuH3lfpWmZ+5F50tElC3
 /q2difAb7KSyIOa6cUTfgHmhbhs29doySAVaCbKRKMCZHLCm1HWS0i5BeYnmgg4lMYCE
 akKTxOU6XxVnjg8aVTOoaifyM5OFUJDpg7cRkdzUeWMgePIFWPC38GnRbm5sZ0oYRdTd
 qm3wkWpbEpTJeWfG2X7byT88Jkx3rZ7QkPicgqGrp9/M4SrInXTlQWeQJhsWV2HDgREX
 jzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ykCAFUzqVNsEPgl0VhMVK/gZ1GJuZopumNi6NQSi9kg=;
 b=Pn2lfyrqwZjNvCYF4xW72zOLnlhJzfp6hLZiIjOWTSAIG1Wc/VFzmh72N3g6pcnsiC
 YWIgiqpd0JDoG5PwJhgxdE2kN8ik22h87c5BiPzssedhT86zxZuy9tvNRcinUicvijDr
 r3v0XVDgd+ZO99LpETFL50OWaEMbw4tkbsjQDhfgTM3RSCAhCQyZgz+ahKDQL4+V79lF
 AZgzyT5s4ZVBvIp6IS73bnKeBxcQkT1BvlrIcMMPj4lHUOINKE6w6cg7p03kiiYGUsJ5
 jR1Bi2FVfwOwHmqL+vXvKUGujfMNlgcrZExnAZLU+yOPHP6KBHfREbB+RoSY5NN1hjHY
 DffQ==
X-Gm-Message-State: AOAM532TTMjvn9obCmoR36fancuoqKmfe+mJfag9pwHrzbMezngEm0qt
 ToFeilTtZsceHVdc52D7gkw=
X-Google-Smtp-Source: ABdhPJyrJ+U9CuE+Svn8bDnGX6HLKtRBN+FxZM8dMDdiyu2ay5NWuRY8OZAostQAzc1j8qznDaVoKA==
X-Received: by 2002:a05:6402:3589:: with SMTP id
 y9mr280168edc.344.1613588430462; 
 Wed, 17 Feb 2021 11:00:30 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:b7c6:d2d7:631c:11b7])
 by smtp.gmail.com with ESMTPSA id r4sm1562710edv.27.2021.02.17.11.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 11:00:29 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ramesh.Errabolu@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amdgpu: new resource cursor
Date: Wed, 17 Feb 2021 20:00:21 +0100
Message-Id: <20210217190028.16409-1-christian.koenig@amd.com>
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
Cc: Arunpravin.PaneerSelvam@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWxsb3dzIHRvIHdhbGsgb3ZlciB0aGUgZHJtX21tIG5vZGVzIGluIGEgVFRNIHJlc291cmNlIG9i
amVjdC4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KLS0tCiAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgg
ICAgfCAxMDUgKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTA1IGluc2VydGlv
bnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmVzX2N1cnNvci5oCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jlc19jdXJzb3IuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
ZXNfY3Vyc29yLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi4xMzM1
ZTA5ODUxMGYKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmVzX2N1cnNvci5oCkBAIC0wLDAgKzEsMTA1IEBACisvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMCBPUiBNSVQKKy8qCisgKiBDb3B5cmlnaHQgMjAyMCBBZHZhbmNlZCBN
aWNybyBEZXZpY2VzLCBJbmMuCisgKgorICogUGVybWlzc2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCwg
ZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24gb2J0YWluaW5nIGEKKyAqIGNvcHkgb2YgdGhp
cyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9uIGZpbGVzICh0aGUgIlNvZnR3
YXJlIiksCisgKiB0byBkZWFsIGluIHRoZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBp
bmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0aW9uCisgKiB0aGUgcmlnaHRzIHRvIHVzZSwgY29weSwg
bW9kaWZ5LCBtZXJnZSwgcHVibGlzaCwgZGlzdHJpYnV0ZSwgc3VibGljZW5zZSwKKyAqIGFuZC9v
ciBzZWxsIGNvcGllcyBvZiB0aGUgU29mdHdhcmUsIGFuZCB0byBwZXJtaXQgcGVyc29ucyB0byB3
aG9tIHRoZQorICogU29mdHdhcmUgaXMgZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRo
ZSBmb2xsb3dpbmcgY29uZGl0aW9uczoKKyAqCisgKiBUaGUgYWJvdmUgY29weXJpZ2h0IG5vdGlj
ZSBhbmQgdGhpcyBwZXJtaXNzaW9uIG5vdGljZSBzaGFsbCBiZSBpbmNsdWRlZCBpbgorICogYWxs
IGNvcGllcyBvciBzdWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUgU29mdHdhcmUuCisgKgorICog
VEhFIFNPRlRXQVJFIElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5Z
IEtJTkQsIEVYUFJFU1MgT1IKKyAqIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQg
VE8gVEhFIFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLAorICogRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSIFBVUlBPU0UgQU5EIE5PTklORlJJTkdFTUVOVC4gIElOIE5PIEVWRU5UIFNIQUxM
CisgKiBUSEUgQ09QWVJJR0hUIEhPTERFUihTKSBPUiBBVVRIT1IoUykgQkUgTElBQkxFIEZPUiBB
TlkgQ0xBSU0sIERBTUFHRVMgT1IKKyAqIE9USEVSIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBB
Q1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLAorICogQVJJU0lORyBGUk9NLCBP
VVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SCisg
KiBPVEhFUiBERUFMSU5HUyBJTiBUSEUgU09GVFdBUkUuCisgKgorICogQXV0aG9yczogQ2hyaXN0
aWFuIEvDtm5pZworICovCisKKyNpZm5kZWYgX19BTURHUFVfUkVTX0NVUlNPUl9IX18KKyNkZWZp
bmUgX19BTURHUFVfUkVTX0NVUlNPUl9IX18KKworI2luY2x1ZGUgPGRybS9kcm1fbW0uaD4KKyNp
bmNsdWRlIDxkcm0vdHRtL3R0bV9yZXNvdXJjZS5oPgorCisvKiBzdGF0ZSBiYWNrIGZvciB3YWxr
aW5nIG92ZXIgdnJhbV9tZ3IgYW5kIGd0dF9tZ3IgYWxsb2NhdGlvbnMgKi8KK3N0cnVjdCBhbWRn
cHVfcmVzX2N1cnNvciB7CisJdWludDY0X3QJCXN0YXJ0OworCXVpbnQ2NF90CQlzaXplOworCXVp
bnQ2NF90CQlyZW1haW5pbmc7CisJc3RydWN0IGRybV9tbV9ub2RlCSpub2RlOworfTsKKworLyoq
CisgKiBhbWRncHVfcmVzX2ZpcnN0IC0gaW5pdGlhbGl6ZSBhIGFtZGdwdV9yZXNfY3Vyc29yCisg
KgorICogQHJlczogVFRNIHJlc291cmNlIG9iamVjdCB0byB3YWxrCisgKiBAc3RhcnQ6IFN0YXJ0
IG9mIHRoZSByYW5nZQorICogQHNpemU6IFNpemUgb2YgdGhlIHJhbmdlCisgKiBAY3VyOiBjdXJz
b3Igb2JqZWN0IHRvIGluaXRpYWxpemUKKyAqCisgKiBTdGFydCB3YWxraW5nIG92ZXIgdGhlIHJh
bmdlIG9mIGFsbG9jYXRpb25zIGJldHdlZW4gQHN0YXJ0IGFuZCBAc2l6ZS4KKyAqLworc3RhdGlj
IGlubGluZSB2b2lkIGFtZGdwdV9yZXNfZmlyc3Qoc3RydWN0IHR0bV9yZXNvdXJjZSAqcmVzLAor
CQkJCSAgICB1aW50NjRfdCBzdGFydCwgdWludDY0X3Qgc2l6ZSwKKwkJCQkgICAgc3RydWN0IGFt
ZGdwdV9yZXNfY3Vyc29yICpjdXIpCit7CisJc3RydWN0IGRybV9tbV9ub2RlICpub2RlOworCisJ
aWYgKCFyZXMgfHwgIXJlcy0+bW1fbm9kZSkgeworCQljdXItPnN0YXJ0ID0gc3RhcnQ7CisJCWN1
ci0+c2l6ZSA9IHNpemU7CisJCWN1ci0+cmVtYWluaW5nID0gc2l6ZTsKKwkJY3VyLT5ub2RlID0g
TlVMTDsKKwkJcmV0dXJuOworCX0KKworCUJVR19PTihzdGFydCArIHNpemUgPiByZXMtPm51bV9w
YWdlcyA8PCBQQUdFX1NISUZUKTsKKworCW5vZGUgPSByZXMtPm1tX25vZGU7CisJd2hpbGUgKHN0
YXJ0ID4gbm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUKQorCQlzdGFydCAtPSBub2RlKystPnNpemUg
PDwgUEFHRV9TSElGVDsKKworCWN1ci0+c3RhcnQgPSAobm9kZS0+c3RhcnQgPDwgUEFHRV9TSElG
VCkgKyBzdGFydDsKKwljdXItPnNpemUgPSAobm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUKSAtIHN0
YXJ0OworCWN1ci0+cmVtYWluaW5nID0gc2l6ZTsKKwljdXItPm5vZGUgPSBub2RlOworfQorCisv
KioKKyAqIGFtZGdwdV9yZXNfbmV4dCAtIGFkdmFuY2UgdGhlIGN1cnNvcgorICoKKyAqIEBjdXI6
IHRoZSBjdXJzb3IgdG8gYWR2YW5jZQorICogQHNpemU6IG51bWJlciBvZiBieXRlcyB0byBtb3Zl
IGZvcndhcmQKKyAqCisgKiBNb3ZlIHRoZSBjdXJzb3IgQHNpemUgYnl0ZXMgZm9yd3JhZCwgd2Fs
a2luZyB0byB0aGUgbmV4dCBub2RlIGlmIG5lY2Vzc2FyeS4KKyAqLworc3RhdGljIGlubGluZSB2
b2lkIGFtZGdwdV9yZXNfbmV4dChzdHJ1Y3QgYW1kZ3B1X3Jlc19jdXJzb3IgKmN1ciwgdWludDY0
X3Qgc2l6ZSkKK3sKKwlzdHJ1Y3QgZHJtX21tX25vZGUgKm5vZGUgPSBjdXItPm5vZGU7CisKKwlC
VUdfT04oc2l6ZSA+IGN1ci0+cmVtYWluaW5nKTsKKworCWN1ci0+cmVtYWluaW5nIC09IHNpemU7
CisJaWYgKCFjdXItPnJlbWFpbmluZykKKwkJcmV0dXJuOworCisJY3VyLT5zaXplIC09IHNpemU7
CisJaWYgKGN1ci0+c2l6ZSkgeworCQljdXItPnN0YXJ0ICs9IHNpemU7CisJCXJldHVybjsKKwl9
CisKKwljdXItPm5vZGUgPSArK25vZGU7CisJY3VyLT5zdGFydCA9IG5vZGUtPnN0YXJ0IDw8IFBB
R0VfU0hJRlQ7CisJY3VyLT5zaXplID0gbWluKG5vZGUtPnNpemUgPDwgUEFHRV9TSElGVCwgY3Vy
LT5yZW1haW5pbmcpOworfQorCisjZW5kaWYKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
