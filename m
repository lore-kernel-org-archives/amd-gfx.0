Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9182C43215
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA14520728
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA14520728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D966E9A6;
	Fri, 15 Nov 2019 16:51:09 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64756E99F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:51:06 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id m16so8598391qki.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tLz/VLKnB1IPKE8d1KUr8XukeZ9FBVXcYJIk8ITPAWE=;
 b=GRqYmZMhlRPs/kKNH8QK9vg5rVAlaA6rru6gI7uAE4REGn/Ab8+4VY0xuaX1c5Dq/F
 WLTdksTEZgzsH6EN6Qz/KIkOUd4aeYlAnf55lo8irkaqwqsuxBA0gbMG45SvGstbhgRs
 6etnuob5ZnwZrBwFH4fQVaerZZF2N/jOR1bhqupBwyz+NXTLi1ehoAQxl/HIFHXW09oG
 vZWr8+xHrNWhCUs/cbOJkec8JtuFdoduQ+VcbsMkuN8dBV1+xlKD6eq11QPFjDaMYNEe
 xNejIc8I7ZIUN+uESzNHwaC2aLf1tLK3WhXxPb2vS1cT9LqNFrN0wCoDCIK0Rk+XzWqB
 jLAg==
X-Gm-Message-State: APjAAAUpOmlTlPTfJky03jF+J3wiXKMPsMYy5KYoRqPqfpKOud+FKZ8u
 3YPtU1zHna+rkIyPPUALRc0MneaC
X-Google-Smtp-Source: APXvYqzjkHM6ssye1kE7FAxKANBSwnDs9ma/Cld5Id0ce+XZqcyTcozVOHzvoFZkMrYR5ULbhbulvg==
X-Received: by 2002:a37:ef04:: with SMTP id j4mr13454835qkk.442.1573836665699; 
 Fri, 15 Nov 2019 08:51:05 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:51:05 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 19/20] ALSA: hda/hdmi - enable runtime pm for newer AMD
 display audio
Date: Fri, 15 Nov 2019 11:50:37 -0500
Message-Id: <20191115165038.56646-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tLz/VLKnB1IPKE8d1KUr8XukeZ9FBVXcYJIk8ITPAWE=;
 b=k2Mmq4xNDrMueFN+S5IYn0SLmlmdLuJ7XmfPyLwQg5xlOKgrJr+cTD4KhXAuB/ejY6
 OkwTzbmLX1Mg0DNj5ZHK4Uoi5KFg4xkB1CHjEbINwJexb1otsY/ECFLHr3PVkedBPJFs
 MKosveYfJWtHZPzHglxAG3sy2Lu6Opz1hAzSgs240DBPTwS8C1evxHHTMWPY3ZMf3dNZ
 /uu+nTHMPfGW9onwBEBrMo5eUhc/mXHuYIQku3h6r2ltHQ3+i6OkGUl3IhasJIGEBcIo
 iIsiOg17EaHpMoynE6TDXL1NmsPZ5FT/dUU1g4h1Kh0MEEVfn5vcNOzdKebBAaJF3kBz
 XBCA==
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
Message-ID: <20191115165037.Qu7DckJNaqEf2QUxDYV0IANb61rkfOma7a0ZoV-2faU@z>

V2UgYXJlIGFibGUgdG8gcG93ZXIgZG93biB0aGUgR1BVIGFuZCBhdWRpbyB2aWEgdGhlIEdQVSBk
cml2ZXIKc28gZmxhZyB0aGVzZSBhc2ljcyBhcyBzdXBwb3J0aW5nIHJ1bnRpbWUgcG0uCgpSZXZp
ZXdlZC1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgpBY2tlZC1ieTogRXZhbiBRdWFu
IDxldmFuLnF1YW5AYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgfCAzNSAr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIzIGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEv
aGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IDc5Y2E5N2Q2Yzgx
MS4uMTExYjlhODY5MTYyIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCisr
KyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKQEAgLTI1OTksMjcgKzI1OTksMzggQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIGF6eF9pZHNbXSA9IHsKIAl7IFBDSV9ERVZJ
Q0UoMHgxMDAyLCAweGFhYzgpLAogCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1J
X05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAogCXsgUENJX0RFVklDRSgweDEw
MDIsIDB4YWFkOCksCi0JICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBB
WlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCi0JeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhh
YWU4KSwKLQkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQ
U19QUkVTRVRfQVRJX0hETUlfTlMgfSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJ
SERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlfTlMgfAorCSAgQVpYX0RDQVBTX1BN
X1JVTlRJTUUgfSwKIAl7IFBDSV9ERVZJQ0UoMHgxMDAyLCAweGFhZTApLAotCSAgLmRyaXZlcl9k
YXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9O
UyB9LAorCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBT
X1BSRVNFVF9BVElfSERNSV9OUyB8CisJICBBWlhfRENBUFNfUE1fUlVOVElNRSB9LAorCXsgUENJ
X0RFVklDRSgweDEwMDIsIDB4YWFlOCksCisJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FU
SUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIHwKKwkgIEFaWF9EQ0FQU19Q
TV9SVU5USU1FIH0sCiAJeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhhYWYwKSwKLQkgIC5kcml2ZXJf
ZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlf
TlMgfSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQ
U19QUkVTRVRfQVRJX0hETUlfTlMgfAorCSAgQVpYX0RDQVBTX1BNX1JVTlRJTUUgfSwKIAl7IFBD
SV9ERVZJQ0UoMHgxMDAyLCAweGFhZjgpLAotCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9B
VElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAorCSAgLmRyaXZlcl9k
YXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9O
UyB8CisJICBBWlhfRENBUFNfUE1fUlVOVElNRSB9LAogCXsgUENJX0RFVklDRSgweDEwMDIsIDB4
YWIwMCksCi0JICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENB
UFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCisJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FU
SUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIHwKKwkgIEFaWF9EQ0FQU19Q
TV9SVU5USU1FIH0sCiAJeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhhYjA4KSwKLQkgIC5kcml2ZXJf
ZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlf
TlMgfSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQ
U19QUkVTRVRfQVRJX0hETUlfTlMgfAorCSAgQVpYX0RDQVBTX1BNX1JVTlRJTUUgfSwKIAl7IFBD
SV9ERVZJQ0UoMHgxMDAyLCAweGFiMTApLAotCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9B
VElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAorCSAgLmRyaXZlcl9k
YXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9O
UyB8CisJICBBWlhfRENBUFNfUE1fUlVOVElNRSB9LAogCXsgUENJX0RFVklDRSgweDEwMDIsIDB4
YWIxOCksCi0JICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENB
UFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCisJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FU
SUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIHwKKwkgIEFaWF9EQ0FQU19Q
TV9SVU5USU1FIH0sCiAJeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhhYjIwKSwKLQkgIC5kcml2ZXJf
ZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlf
TlMgfSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQ
U19QUkVTRVRfQVRJX0hETUlfTlMgfAorCSAgQVpYX0RDQVBTX1BNX1JVTlRJTUUgfSwKIAl7IFBD
SV9ERVZJQ0UoMHgxMDAyLCAweGFiMzgpLAotCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9B
VElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAorCSAgLmRyaXZlcl9k
YXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9O
UyB8CisJICBBWlhfRENBUFNfUE1fUlVOVElNRSB9LAogCS8qIFZJQSBWVDgyNTEvVlQ4MjM3QSAq
LwogCXsgUENJX0RFVklDRSgweDExMDYsIDB4MzI4OCksIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklW
RVJfVklBIH0sCiAJLyogVklBIEdGWCBWVDcxMjIvVlg5MDAgKi8KLS0gCjIuMjMuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
