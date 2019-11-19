Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C57FC432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 20:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AC922445
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 20:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AC922445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 957F56E393;
	Tue, 19 Nov 2019 20:56:50 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40B46E393
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 20:56:48 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id k206so9428708ybb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 12:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MUMkC6G3t7tV5Rr4DS/gfw6H+4asXn99YPOQR2AFcAI=;
 b=IklKZcW1YOUNtBrnYCTNJqiWl2STC53OZkuYroBKN76Nh6rn8MrfCzEYi5gOB7h5y6
 vp0SQ9yiX+RHZ4plPzXr1FNe1++R2TyCEKqBWcEbXBQgo4aOOaUDHyEgDuOULp4OYIar
 t3a5012Ecfw7vJZ7ICDTMKW27/B0ELQMOLX+SNofAzfRbVdBL9FwY7oYyCI7Y+ab6dZz
 ygi9aP8BOVtxgVQaF2XetPk4+qsom+ZDECe8zbPqMsF6LJEkdwslk6Hrc+qfF4bmCRZx
 trYOGglp1a+LC9NkmUzcVp3i23dhyngRxb1RR1dpL2WM60eeguL9SZyV5zg9EvBh6/W5
 MFQg==
X-Gm-Message-State: APjAAAXvDaQphO3wm69WCjNycJ/zNJuy851StsalchmUc2e1cE3xNQG7
 /7SmXcUBElzQVirzps4iVgQN5cbg
X-Google-Smtp-Source: APXvYqwVItrmVMJYHOu+n2qbeoJgUsDps30n8WoajYacvRaIdHj03Fn2SWvA+bnpXoRgBcPu4XqWvw==
X-Received: by 2002:a25:4805:: with SMTP id v5mr11129467yba.66.1574197007529; 
 Tue, 19 Nov 2019 12:56:47 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c198sm12296097ywa.78.2019.11.19.12.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 12:56:46 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: add default clocks if not able to fetch them
Date: Tue, 19 Nov 2019 15:56:39 -0500
Message-Id: <20191119205639.244832-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MUMkC6G3t7tV5Rr4DS/gfw6H+4asXn99YPOQR2AFcAI=;
 b=S21j887ejvLXOoUu2QDosBxq3oqyvlchjMILLLY9rkLa0ccGIChdZ4MNjQyWEqbeAK
 05TznLGpuP5X6TLAgC0SQcpw9FLP46qriPaaSBvmmTFXSGMG+Tv9z2XWvm4hXfp7sgKX
 JF/k2ysZZoLsYIlvfg+e4A38dt2x5IBVJ7ns8FpafQR14APRy9uY9L1SsCK0xUnQb0T+
 XoqeXaEA/zSU7OLzv96ac06SefyxMoW+KWXhpFUdAws7htmBIczaVHl+kK8IBzUzoj3+
 1hgK35kxdVFuiHU2Vt/7/VOy1uQt7V66ONQF1zgJK78EUWk2CFPaVbMTEazcySxxARJk
 6lhQ==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191119205639.iPVr7eI-YdTQTR-OBDmgyz3-541Vx3EDl0TMwg9onJo@z>

ZG1fcHBfZ2V0X2Nsb2NrX2xldmVsc19ieV90eXBlIG5lZWRzIHRvIGFkZCB0aGUgZGVmYXVsdCBj
bG9ja3MKdG8gdGhlIHBvd2VycGxheSBjYXNlIGFzIHdlbGwuICBUaGlzIHdhcyBhY2NpZGVudGx5
IGRyb3BwZWQuCgpGaXhlczogYjNlYTg4ZmVmMzIxZGUgKCJkcm0vYW1kL3Bvd2VycGxheTogYWRk
IGdldF9jbG9ja19ieV90eXBlIGludGVyZmFjZSBmb3IgZGlzcGxheSIpCkJ1ZzogaHR0cHM6Ly9n
aXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvaXNzdWVzLzkwNgpTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHBfc211LmMgfCAzICsrLQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHBfc211
LmMKaW5kZXggMjI5Nzg4YmVlNTQ0Li5hMmUxYTczZjY2YjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jCkBA
IC0zNDIsNyArMzQyLDggQEAgYm9vbCBkbV9wcF9nZXRfY2xvY2tfbGV2ZWxzX2J5X3R5cGUoCiAJ
aWYgKGFkZXYtPnBvd2VycGxheS5wcF9mdW5jcyAmJiBhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3Mt
PmdldF9jbG9ja19ieV90eXBlKSB7CiAJCWlmIChhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MtPmdl
dF9jbG9ja19ieV90eXBlKHBwX2hhbmRsZSwKIAkJCWRjX3RvX3BwX2Nsb2NrX3R5cGUoY2xrX3R5
cGUpLCAmcHBfY2xrcykpIHsKLQkJLyogRXJyb3IgaW4gcHBsaWIuIFByb3ZpZGUgZGVmYXVsdCB2
YWx1ZXMuICovCisJCQkvKiBFcnJvciBpbiBwcGxpYi4gUHJvdmlkZSBkZWZhdWx0IHZhbHVlcy4g
Ki8KKwkJCWdldF9kZWZhdWx0X2Nsb2NrX2xldmVscyhjbGtfdHlwZSwgZGNfY2xrcyk7CiAJCQly
ZXR1cm4gdHJ1ZTsKIAkJfQogCX0gZWxzZSBpZiAoYWRldi0+c211LnBwdF9mdW5jcyAmJiBhZGV2
LT5zbXUucHB0X2Z1bmNzLT5nZXRfY2xvY2tfYnlfdHlwZSkgewotLSAKMi4yMy4wCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
