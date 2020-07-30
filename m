Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9597C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D31E207F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScY9jwMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D31E207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA3356E968;
	Thu, 30 Jul 2020 20:04:40 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D921F6E966
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:39 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id r19so4615574qvw.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i2M9nRpCG0SHFOLHsFjQRNswBRbeT+6HcxAhQTmrNbM=;
 b=ScY9jwMbehGXN9Tf6Rn41VoM0XS0Sl+EaBx2uB+a1HTqaBSp0+4lSVkNDEEJUT6DJ7
 WO+cBaf5xQQL5y61/W8Efp6Ht+Gt6Ksho4p7ZV3Y85nubgonVbRxiQwDJObeWJ4QE93K
 +yq4aqBerZYwbV2oqXrHUUWoPt0EUHLp0J0bRFX5RS25Y5SXsWBZmSYn0IV23PKKAGbC
 qvmZTQ/VhngjdiRW0DIjvUOqE4F1ER8ALwv38bDioDgeU9PWqgiWqvqLBUQ2IMb/KoWd
 xUdIn0EfENH/pqGe3jb1AsCFmQuZZiJjz4UEDwVaGcX7iwo1+d9yIBK8SmfSoMDzW6pZ
 suiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i2M9nRpCG0SHFOLHsFjQRNswBRbeT+6HcxAhQTmrNbM=;
 b=TdbitHcCevKqhrva7GCQ7c5oLLsiQgIVz27/w9GDsOZs865cNwXLS6TXCwHC9WGiJr
 OOnjYkXBTP62xbMqOE8CDhiROu5hI1z2LsL9lnxTg3Ftzg0nRxHljLAw3AvjO0iD8T7Y
 pCHL41T58oaBChw9Na8iTtmqeGlByYdmgvx/NZJjLF9qjvgYYBJndDTgLe6gccqPRWy6
 YgeY0zfWpZlMiMQ18mL3/5WEo5uvn9oCMCvIRs/B1y4Z+O0i/3IF+4yt2gGks0bCCRgI
 bTUhbUV1qUfqYCa48DA2UJiKZ2RYEJ88Ny425LgbofbSEF8QL4a1MaxIapwkTuT+wgOF
 y2Qw==
X-Gm-Message-State: AOAM532iY3aChHTP2HE4Sv/QOji7bjzbGtfzgchIaq71rQDT+WlOnbpc
 uI3xWrpjv1S0+eVBdb2Ue/I7VeAO
X-Google-Smtp-Source: ABdhPJxp7id6yq/U+df6erglpNVNC6N5RQCWOFkK823WrhqzD5e08EIvAd5+qfSAycf2fk/3yNt4wA==
X-Received: by 2002:a0c:f849:: with SMTP id g9mr846829qvo.80.1596139478046;
 Thu, 30 Jul 2020 13:04:38 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:37 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/17] drm/amdgpu/gmc: disable keep_stolen_vga_memory on
 arcturus
Date: Thu, 30 Jul 2020 16:04:11 -0400
Message-Id: <20200730200414.40485-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200730200414.40485-1-alexander.deucher@amd.com>
References: <20200730200414.40485-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSBzdXNwZWN0IHRoZSBvbmx5IHJlYXNvbiB0aGlzIHdhcyBzZXQgd2FzIHRvIGF2b2lkIHRvdWNo
aW5nCnRoZSBkaXNwbGF5IHJlbGF0ZWQgcmVnaXN0ZXJzIG9uIGFyY3R1cnVzLiAgU29tZW9uZSBz
aG91bGQKZG91YmxlIGNoZWNrIHRoaXMgb24gYXJjdHVydXMgd2l0aCBTMy4KClJldmlld2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClJldmlld2VkLWJ5
OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKaW5kZXggZmM5
ZTE4YWFhNzZlLi4wYmQ3YjM3OTc1MzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nbWMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ21jLmMKQEAgLTQ0OCw3ICs0NDgsNiBAQCB2b2lkIGFtZGdwdV9nbWNfZ2V0X3ZiaW9zX2Fs
bG9jYXRpb25zKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXN3aXRjaCAoYWRldi0+YXNp
Y190eXBlKSB7CiAJY2FzZSBDSElQX1ZFR0ExMDoKIAljYXNlIENISVBfUkFWRU46Ci0JY2FzZSBD
SElQX0FSQ1RVUlVTOgogCWNhc2UgQ0hJUF9SRU5PSVI6CiAJCWFkZXYtPmdtYy5rZWVwX3N0b2xl
bl92Z2FfbWVtb3J5ID0gdHJ1ZTsKIAkJYnJlYWs7Ci0tIAoyLjI1LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
