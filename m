Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB4EC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7BC20723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7BC20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B46C6E783;
	Fri, 15 Nov 2019 16:50:51 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496F26E637
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:50:50 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id d13so8624381qko.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5jWqSWkcr8Rvf8rBv65dsS38w4SQg0IVGsPkUDNSymc=;
 b=b51d2ChgyFkAZUajZ7nd+snVYLh42/MxPQQbniM3m9cUF3LgsCAb/wv5s1d0PjxG74
 ucKuCWbsNTPwuybpSgfwam7FWlqNVLzndo/k7U0wjWCviRwPmfzmz4o4NOdBKfjXE6vZ
 ePH/o9ZWURQDmkgs11544REZUy90Imgc3GqzFIT/ewRVnJrQBktkiieSzPxk8lPwO9ew
 qh5WE6axnVoUVDfwGfALeYbLNRKaaWR+FwPgiQr5sInrRY8MAmY4gHgMb05DPaGh+ONr
 qNL6KmRX34/KeSV/YhDpa8MKF9tDpp5VBIQ0zP8nuavM2WdpMXxPTVJx3CeOnbrdHGGE
 Bo1A==
X-Gm-Message-State: APjAAAUaHjAZyfDNPpjYset/6UdF29tnizZ0/OUOGqW451+GJimK+nIM
 X8lui85uAwhLuKNdDm3PlwOD7hkj
X-Google-Smtp-Source: APXvYqwUQN4Ql9efspU0qVkhPDNX5y515UaSRjj54wrpz4vvqvq1LDWOHRa+MzIcW6l4aJe0ILVY9g==
X-Received: by 2002:a37:6554:: with SMTP id z81mr13753900qkb.9.1573836649131; 
 Fri, 15 Nov 2019 08:50:49 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:50:48 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 02/20] drm/amdgpu: add supports_baco callback for soc15 asics.
 (v2)
Date: Fri, 15 Nov 2019 11:50:20 -0500
Message-Id: <20191115165038.56646-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5jWqSWkcr8Rvf8rBv65dsS38w4SQg0IVGsPkUDNSymc=;
 b=fQBalVcmuS7D569AzzAGn5yTvOZvdpQPU2UShbNTmLqwpKsEorCDhr7Dw4AWCciYfE
 PX/Up36rA7FEBlgy9zgDahv9Yd0plrB/BPAiZyX2mMX0hN6ANHfy1NH1hpuOAf66mPkp
 FHGCTwx/EJbUvbL+yDQyK04NBXQHEAg4JVRhiOnlPoOf9tayeVtQ7Q6oAkYZrLPrmXLm
 MzO5R0nYGBi/iYWhe0g5tjPXLwnI3gUy67Kfe5UlEBkRohVOW17XINHlZEjHBo/43jCo
 j4NEHyBQ726r5aj8j0ULGbMlM6I0nyIG4NokGn5F/T7BLjQm6gMbWnYQyD92mwng+J96
 1/Zw==
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
Message-ID: <20191115165020.TeSns6Xf4_DbI_3m_MYLEcPidGJW8CMncjkBZh4GlsY@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpDaGVjayB0aGUgQkFDTyBjYXBhYmlsaXRpZXMg
ZnJvbSB0aGUgcG93ZXJwbGF5IHRhYmxlLgoKdjI6IGRyb3AgdW5yZWxhdGVkIHN0cnVjdCBjbGVh
bnVwCgpSZXZpZXdlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4gKHYxKQpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8IDI0ICsrKysrKysrKysrKysrKysr
KysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMTUuYwppbmRleCAzMDVhZDNlZWM5ODcuLjFhY2JiMzhmNjM4NCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zb2MxNS5jCkBAIC01OTksNiArNTk5LDI4IEBAIHN0YXRpYyBpbnQgc29j
MTVfYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAl9CiB9CiAKK3N0YXRp
YyBib29sIHNvYzE1X3N1cHBvcnRzX2JhY28oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCit7
CisJYm9vbCBiYWNvX3N1cHBvcnQ7CisKKwlzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgeworCWNh
c2UgQ0hJUF9WRUdBMTA6CisJY2FzZSBDSElQX1ZFR0ExMjoKKwkJc29jMTVfYXNpY19nZXRfYmFj
b19jYXBhYmlsaXR5KGFkZXYsICZiYWNvX3N1cHBvcnQpOworCQlicmVhazsKKwljYXNlIENISVBf
VkVHQTIwOgorCQlpZiAoYWRldi0+cHNwLnNvc19md192ZXJzaW9uID49IDB4ODAwNjcpCisJCQlz
b2MxNV9hc2ljX2dldF9iYWNvX2NhcGFiaWxpdHkoYWRldiwgJmJhY29fc3VwcG9ydCk7CisJCWVs
c2UKKwkJCWJhY29fc3VwcG9ydCA9IGZhbHNlOworCQlicmVhazsKKwlkZWZhdWx0OgorCQlyZXR1
cm4gZmFsc2U7CisJfQorCisJcmV0dXJuIGJhY29fc3VwcG9ydDsKK30KKwogLypzdGF0aWMgaW50
IHNvYzE1X3NldF91dmRfY2xvY2soc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiBjbG9j
aywKIAkJCXUzMiBjbnRsX3JlZywgdTMyIHN0YXR1c19yZWcpCiB7CkBAIC05OTksNiArMTAyMSw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2FzaWNfZnVuY3Mgc29jMTVfYXNpY19mdW5j
cyA9CiAJLmdldF9wY2llX3VzYWdlID0gJnNvYzE1X2dldF9wY2llX3VzYWdlLAogCS5uZWVkX3Jl
c2V0X29uX2luaXQgPSAmc29jMTVfbmVlZF9yZXNldF9vbl9pbml0LAogCS5nZXRfcGNpZV9yZXBs
YXlfY291bnQgPSAmc29jMTVfZ2V0X3BjaWVfcmVwbGF5X2NvdW50LAorCS5zdXBwb3J0c19iYWNv
ID0gJnNvYzE1X3N1cHBvcnRzX2JhY28sCiB9OwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdw
dV9hc2ljX2Z1bmNzIHZlZ2EyMF9hc2ljX2Z1bmNzID0KQEAgLTEwMjAsNiArMTA0Myw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2FzaWNfZnVuY3MgdmVnYTIwX2FzaWNfZnVuY3MgPQog
CS5nZXRfcGNpZV91c2FnZSA9ICZ2ZWdhMjBfZ2V0X3BjaWVfdXNhZ2UsCiAJLm5lZWRfcmVzZXRf
b25faW5pdCA9ICZzb2MxNV9uZWVkX3Jlc2V0X29uX2luaXQsCiAJLmdldF9wY2llX3JlcGxheV9j
b3VudCA9ICZzb2MxNV9nZXRfcGNpZV9yZXBsYXlfY291bnQsCisJLnN1cHBvcnRzX2JhY28gPSAm
c29jMTVfc3VwcG9ydHNfYmFjbywKIH07CiAKIHN0YXRpYyBpbnQgc29jMTVfY29tbW9uX2Vhcmx5
X2luaXQodm9pZCAqaGFuZGxlKQotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
