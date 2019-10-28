Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76595CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B462217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B462217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D196EAB1;
	Mon, 28 Oct 2019 21:43:57 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4534A6EAB9
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:56 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id r134so4375881ywg.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/OTNWTrnNayQGKE2n9NJY1VA8uQkKW2cZ+erBCv1+bA=;
 b=WM/hIOWHWl+XGaIVGxPwKKbu8d51JPq2L2K28MOUMRAFy3V04hShuOKgXK6B3LBmdn
 xc13pjMFppTVSmZF3WYgsZLbpCMK0D/8XhrPmxI52JGTAjsXVPhlUv9rzl5mjlf1vMJj
 O1/TUuhn0PN2l4DQUyA+r02N5bIa9/2mV0vDqgoIFzb701L3QVWSnHm0w96H/R6L1glv
 F162M1TlsI2bSL72e3Uf2zIEMClxdZi9UKbo43Rxxl/vmSfSwVj8fxewzI+yOmxfOhAY
 Pvgn8KHbKxU4a/fplVRYWmRsY2Mw8jPIVLfD6YSbDKOfPi90kMGE2aphkJD3kv9imME4
 +EiQ==
X-Gm-Message-State: APjAAAUySWYWf0XueDnO9z6Wky/KMxmGOs0QvampUxb6FVRvrHpgxkS9
 zAFkPqTq8ZvsGD1EgDEED6P7+lSFOzA=
X-Google-Smtp-Source: APXvYqzMJYvx+lRePoavyZ4w9Mlok1ABzCceZAveHW1gIZhzAtqIOUPHCuQjoSLZmIkO4mPDwQkQCg==
X-Received: by 2002:a81:52cd:: with SMTP id g196mr14534370ywb.83.1572299034999; 
 Mon, 28 Oct 2019 14:43:54 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:54 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 18/21] ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD
Date: Mon, 28 Oct 2019 17:42:13 -0400
Message-Id: <20191028214216.1508370-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/OTNWTrnNayQGKE2n9NJY1VA8uQkKW2cZ+erBCv1+bA=;
 b=e+n2Al6vVh+LJ58tv+dvyBeY41CjBhkBwBQny1mfRpu39y1AChTb085w/1vVXdr7Lq
 ekdtatIyw2Fs1suOrSgy7Kds5elQtfVDjqjSFqU826rdqgUdHO74AXog54JpH8NhLOAl
 b9gEoB1yaJ+G+fCSMLuAZFb8t5BR3Trz1/UChsq7m7GYaaZGKqXRY2CvhRbP7uKT/vnv
 YpyWbYUfCfTJr3EOHguKP9tjCpV0qxG4gQcUs2bw9Ry1Zs918/Unw4iwDI5OhnbzZ3bI
 wjg9dwNMLTi1C60C5dLUXlwngKNOHDEjgIeLgZDe11hRz04X1Pgx83FBBhKqHCoTIK9I
 OVwQ==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028214213.tPOCcy2bzW9PRTPxfFwi-GixQD1aGVghMUodERKghfk@z>

T25seSBlbmFibGUgdGhlIHZnYV9zd2l0Y2hlcm9vIGxvZ2ljIG9uIHN5c3RlbXMgd2l0aCB0aGUK
QVRQWCBBQ1BJIG1ldGhvZC4gIFRoaXMgbG9naWMgaXMgbm90IG5lZWRlZCBmb3IgYXNpY3MKdGhh
dCBhcmUgbm90IHBhcnQgb2YgYSBQWCAoUG93ZXJYcHJlc3MpL0hHIChIeWJyaWQgR3JhcGhpY3Mp
CnBsYXRmb3JtLgoKQWNrZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCgp2
MjoKLSBjaGVjayBDT05GSUdfQUNQSQotIGZpeCBwY2kgcmVmIGxvZ2ljCgpzb3VuZC9wY2kvaGRh
L2hkYV9pbnRlbC5jIHwgNDkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3Bj
aS9oZGEvaGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IDFlMTRk
NzI3MGFkZi4uYWI2YzRlN2M0NjhiIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRl
bC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKQEAgLTM1LDYgKzM1LDExIEBACiAj
aW5jbHVkZSA8bGludXgvY2xvY2tzb3VyY2UuaD4KICNpbmNsdWRlIDxsaW51eC90aW1lLmg+CiAj
aW5jbHVkZSA8bGludXgvY29tcGxldGlvbi5oPgorI2lmZGVmIFNVUFBPUlRfVkdBX1NXSVRDSEVS
T08KKyNpZmRlZiBDT05GSUdfQUNQSQorI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4KKyNlbmRpZgor
I2VuZGlmCiAKICNpZmRlZiBDT05GSUdfWDg2CiAvKiBmb3Igc25vb3AgY29udHJvbCAqLwpAQCAt
MTM0NSw2ICsxMzUwLDM0IEBAIHN0YXRpYyBpbnQgYXp4X2Rldl9mcmVlKHN0cnVjdCBzbmRfZGV2
aWNlICpkZXZpY2UpCiB9CiAKICNpZmRlZiBTVVBQT1JUX1ZHQV9TV0lUQ0hFUk9PCisjaWZkZWYg
Q09ORklHX0FDUEkKKy8qIEFUUFggaXMgaW4gdGhlIGludGVncmF0ZWQgR1BVJ3MgbmFtZXNwYWNl
ICovCitzdGF0aWMgYm9vbCBhdHB4X3ByZXNlbnQodm9pZCkKK3sKKwlzdHJ1Y3QgcGNpX2RldiAq
cGRldiA9IE5VTEw7CisJYWNwaV9oYW5kbGUgZGhhbmRsZSwgYXRweF9oYW5kbGU7CisJYWNwaV9z
dGF0dXMgc3RhdHVzOworCisJd2hpbGUgKChwZGV2ID0gcGNpX2dldF9jbGFzcyhQQ0lfQkFTRV9D
TEFTU19ESVNQTEFZIDw8IDE2LCBwZGV2KSkgIT0gTlVMTCkgeworCQlkaGFuZGxlID0gQUNQSV9I
QU5ETEUoJnBkZXYtPmRldik7CisJCWlmIChkaGFuZGxlKSB7CisJCQlzdGF0dXMgPSBhY3BpX2dl
dF9oYW5kbGUoZGhhbmRsZSwgIkFUUFgiLCAmYXRweF9oYW5kbGUpOworCQkJaWYgKCFBQ1BJX0ZB
SUxVUkUoc3RhdHVzKSkgeworCQkJCXBjaV9kZXZfcHV0KHBkZXYpOworCQkJCXJldHVybiB0cnVl
OworCQkJfQorCQl9CisJCXBjaV9kZXZfcHV0KHBkZXYpOworCX0KKwlyZXR1cm4gZmFsc2U7Cit9
CisjZWxzZQorc3RhdGljIGJvb2wgYXRweF9wcmVzZW50KHZvaWQpCit7CisJcmV0dXJuIGZhbHNl
OworfQorI2VuZGlmCisKIC8qCiAgKiBDaGVjayBvZiBkaXNhYmxlZCBIRE1JIGNvbnRyb2xsZXIg
YnkgdmdhX3N3aXRjaGVyb28KICAqLwpAQCAtMTM1Niw2ICsxMzg5LDIyIEBAIHN0YXRpYyBzdHJ1
Y3QgcGNpX2RldiAqZ2V0X2JvdW5kX3ZnYShzdHJ1Y3QgcGNpX2RldiAqcGNpKQogCXN3aXRjaCAo
cGNpLT52ZW5kb3IpIHsKIAljYXNlIFBDSV9WRU5ET1JfSURfQVRJOgogCWNhc2UgUENJX1ZFTkRP
Ul9JRF9BTUQ6CisJCWlmIChwY2ktPmRldmZuID09IDEpIHsKKwkJCXAgPSBwY2lfZ2V0X2RvbWFp
bl9idXNfYW5kX3Nsb3QocGNpX2RvbWFpbl9ucihwY2ktPmJ1cyksCisJCQkJCQkJcGNpLT5idXMt
Pm51bWJlciwgMCk7CisJCQlpZiAocCkgeworCQkJCS8qIEFUUFggaXMgaW4gdGhlIGludGVncmF0
ZWQgR1BVJ3MgQUNQSSBuYW1lc3BhY2UKKwkJCQkgKiByYXRoZXIgdGhhbiB0aGUgZEdQVSdzIG5h
bWVzcGFjZS4gSG93ZXZlciwKKwkJCQkgKiB0aGUgZEdQVSBpcyB0aGUgb25lIHdobyBpcyBpbnZv
bHZlZCBpbgorCQkJCSAqIHZnYXN3aXRjaGVyb28uCisJCQkJICovCisJCQkJaWYgKCgocC0+Y2xh
c3MgPj4gMTYpID09IFBDSV9CQVNFX0NMQVNTX0RJU1BMQVkpICYmCisJCQkJICAgIGF0cHhfcHJl
c2VudCgpKQorCQkJCQlyZXR1cm4gcDsKKwkJCQlwY2lfZGV2X3B1dChwKTsKKwkJCX0KKwkJfQor
CQlicmVhazsKIAljYXNlIFBDSV9WRU5ET1JfSURfTlZJRElBOgogCQlpZiAocGNpLT5kZXZmbiA9
PSAxKSB7CiAJCQlwID0gcGNpX2dldF9kb21haW5fYnVzX2FuZF9zbG90KHBjaV9kb21haW5fbnIo
cGNpLT5idXMpLAotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
