Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E607AC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 11:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85098613C7
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 11:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85098613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFF5B6E10B;
	Wed,  5 May 2021 11:01:50 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EBEC6E159
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 11:01:49 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id h10so1466109edt.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 May 2021 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vLuqqSrrmKXifX0NssYYA5zxVwR5wz0tA/CJn6mEyf8=;
 b=czFW++jcZxQxkGo4YRQkLaN+f3xl2s84Tox1NYKdGjN+VZPidhy5vciva7CecQpWlX
 6MqzN4WuP2ycq2gyXZeGriC1pTLYY/XLg0MEPL6wVk5/K1jmdGRP2HNCB02PLS6+MkcS
 eNK44Jzb8WFOLvQEEjGm+JE9uLX9Bwy3502DV0lUzBfVjz/L75zj9xTeUIyq5T+S2x/h
 +syg3jpGJ+yhY40UUneE0czqvsP4XfnxZV2D8hnA+RGqDTRATKSse5x6VMgQCPmU8z4Y
 QgEXwS9tTbKKWN5VGwevFPRGt9R2RyXprYqYRcPm0JNbSUlmiWlICHI9vZ7gp3xpKjZn
 pzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vLuqqSrrmKXifX0NssYYA5zxVwR5wz0tA/CJn6mEyf8=;
 b=b4RgDa6wrTNO2KFjQfn6zMfCv8v3lu7lVTKu8RUs9IH1WRQf0WGj2mDyawcXoaBdlU
 2T3qqmkK86dau4D72ejMyB9mYAW8RajhI41ayWxS1EfbdBcl8+W8mTUCBm3NerfIWv9w
 nklaMXRbExvc9rY3dGLd01t8j8SzP5SHR6jJR/D8I2siOvJ8MFFlMmuLxMB9+PnJXYhs
 Qylqyu6G1o2dfwvESix0H43/vpAnQ9O7L/q/Cb+S4AVoGENH7otkeM6vndaDp5VSYTr4
 Qs56gl8rgcS0GzAJ1j0E6iDVtygA1YCjqWrNafc2UO5tp7z6kjTY8PzLKcvzS+WFVPWE
 fiTw==
X-Gm-Message-State: AOAM531+wlcpbKOqZ3KXAcZBHCGJKi760luEASAELFIijP8Y05ahN2Ll
 oNWqEwIaPKNGN6OVnjpEWCM=
X-Google-Smtp-Source: ABdhPJxRIcKxRhzUgHF0eMQRaLWbNzpNX+7BefUDG10sGVGsStXBJ77eX4ZHlGDLgVGT7E0y2OoU0g==
X-Received: by 2002:a05:6402:144d:: with SMTP id
 d13mr31853772edx.101.1620212508437; 
 Wed, 05 May 2021 04:01:48 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:13b0:4041:4123:36fa])
 by smtp.gmail.com with ESMTPSA id zo6sm2732519ejb.77.2021.05.05.04.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 May 2021 04:01:47 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Xinhui.Pan@amd.com, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS: Add Xinhui Pan as another AMDGPU contact
Date: Wed,  5 May 2021 13:01:46 +0200
Message-Id: <20210505110146.11689-1-christian.koenig@amd.com>
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

U2luY2UgQ2h1bm1pbmcgWmhvdSBsZWZ0IEFNRCBsYXN0IHllYXIgd2UgYXJlIGRvd24gdG8gb25s
eQp0d28gbWFpbnRhaW5lcnMgb25jZSBtb3JlLiBTbyBhZGQgWGluaHUgUGFuIGFzIGFub3RoZXIK
Y29udGFjdCBhcyB3ZWxsLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIE1BSU5UQUlORVJTIHwgMSArCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJT
CmluZGV4IDY0ZWQ4Yjc3Y2ZhOS4uZTJjYjVhOGFjZGYxIDEwMDY0NAotLS0gYS9NQUlOVEFJTkVS
UworKysgYi9NQUlOVEFJTkVSUwpAQCAtMTQ5NzAsNiArMTQ5NzAsNyBAQCBGOglkcml2ZXJzL25l
dC93aXJlbGVzcy9xdWFudGVubmEKIFJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJTCiBNOglB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CiBNOglDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CitNOglQYW4sIFhpbmh1aSA8WGluaHVpLlBh
bkBhbWQuY29tPgogTDoJYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKIFM6CVN1cHBvcnRl
ZAogVDoJZ2l0IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9hZ2Q1Zi9saW51eC5naXQK
LS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
