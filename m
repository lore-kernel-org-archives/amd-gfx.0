Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F590C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1798613BF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1798613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926946ECC6;
	Wed,  2 Jun 2021 14:40:58 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8291D6ECC6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 14:33:28 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id l2so2552823wrw.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=457+N/Rh8MOrxunbiCqh3NZ4tXXcJQCrqwWFpwHmuoQ=;
 b=uActT3hvfwlLPIZ6RHgWI18UgapOBE6UhJ2FV+Z+7kx0FYvKBWb1JGMK+67m4XiN9W
 6KPxYFTp5kApYGtKlboWnuuZKOMlm55yon52q3jbgurwUFvSAZaacGVCHpXtSaZLG8r+
 MJN7c8Z58Duav2e+ZBSjATW+gRHrbGOFQl1xeUto/T3dFqI1TZOKJmL+QZmah37Sx6zO
 ha4P1AtfU02ImH5mnEFK0btmUyvMrEeraouty6b/pRgossm0hMwhryMK9NxXtJaOWuo3
 auIC+ZbLq7w/uCK8T+qn2Ejsr5/wyntXgh3uyC7WkVgTX13doyl1Vym8AkivxbZitD/T
 OnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=457+N/Rh8MOrxunbiCqh3NZ4tXXcJQCrqwWFpwHmuoQ=;
 b=L++SeeZxtVSLqMKXL5mFBLbYRs3rwf/rZJzdV50aaZojSdKR4gumArYD9BGbXlAvCB
 W1J9HhQcVy0j065GWisRU/USrZ3bdFALxm5aO3ZwObefnBpR8Qi+vAyQygKxFb1r43N0
 6Uy0NJjzfjxDV528UEjTBsxcCtQK55TelG/MKtAfbOabvOW6LkLoOMnA9YE843OccwfC
 o3hSrvjgCperBpf1U3HcLIppydke4Mi2ghafP/qIY6UdI24UntsB+Blv1Cna8SFhOFLb
 ZA+HgS/G8CAKWXDGE3C1QwMZNJFInYQywGf3FV78OfnK/KnI+7FBiOYXqd3GBfLnRtrm
 BIAg==
X-Gm-Message-State: AOAM531tWQ4Duy5IdS1WGuwM//XUnzqEPLGH612qxwWF2JhQBb52PYSW
 hdf5mwjFF/KPIwdstIt8JvXLRg==
X-Google-Smtp-Source: ABdhPJyVZdTdil8cZTIEEb4JxiStiib0c/SBUoFAYxulgJqOyRrYcJQd+VVKJ3BGvVLvI19muxWRrw==
X-Received: by 2002:a05:6000:508:: with SMTP id
 a8mr33884629wrf.315.1622644407227; 
 Wed, 02 Jun 2021 07:33:27 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
 by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 07:33:26 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [RESEND 16/26] drm/amd/display/dc/dce/dce_transform: Remove
 superfluous re-initialisation of DCFE_MEM_LIGHT_SLEEP_CNTL, 
Date: Wed,  2 Jun 2021 15:32:50 +0100
Message-Id: <20210602143300.2330146-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 02 Jun 2021 14:40:57 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9wc3AuYzoz
NzQ6MjI6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYbW9kX2hkY3BfaGRj
cDFfZ2V0X2xpbmtfZW5jcnlwdGlvbl9zdGF0dXPigJkKIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291
cmNlLmM6Mjg6CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FzaWNfcmVn
L2RjZS9kY2VfNl8wX2QuaDo1Njg6NDM6IHdhcm5pbmc6IGluaXRpYWxpemVkIGZpZWxkIG92ZXJ3
cml0dGVuIFstV292ZXJyaWRlLWluaXRdCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9k
aXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6MTU3OjE0OiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8g4oCYbW1DUlRDMF9EQ0ZFX01FTV9MSUdIVF9TTEVFUF9DTlRM4oCZCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmg6
MTcwOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhTUknigJkKIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBfcmVzb3VyY2UuYzoxODM6
Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFhGTV9DT01NT05fUkVHX0xJU1RfRENF
NjDigJkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlNjAvZGNl
NjBfcmVzb3VyY2UuYzoxODc6Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmHRyYW5z
Zm9ybV9yZWdz4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FzaWNf
cmVnL2RjZS9kY2VfNl8wX2QuaDo1Njg6NDM6IG5vdGU6IChuZWFyIGluaXRpYWxpemF0aW9uIGZv
ciDigJh4Zm1fcmVnc1swXS5EQ0ZFX01FTV9MSUdIVF9TTEVFUF9DTlRM4oCZKQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjE1
NzoxNDogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmG1tQ1JUQzBfRENGRV9NRU1fTElH
SFRfU0xFRVBfQ05UTOKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9k
Yy9kY2UvZGNlX3RyYW5zZm9ybS5oOjE3MDoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g
4oCYU1JJ4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYw
L2RjZTYwX3Jlc291cmNlLmM6MTgzOjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhY
Rk1fQ09NTU9OX1JFR19MSVNUX0RDRTYw4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6MTg3OjM6IG5vdGU6IGluIGV4cGFu
c2lvbiBvZiBtYWNybyDigJh0cmFuc2Zvcm1fcmVnc+KAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vaW5jbHVkZS9hc2ljX3JlZy9kY2UvZGNlXzZfMF9kLmg6NjQ1OjQzOiB3YXJuaW5n
OiBpbml0aWFsaXplZCBmaWVsZCBvdmVyd3JpdHRlbiBbLVdvdmVycmlkZS1pbml0XQoKQ2M6IEhh
cnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5n
LmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERh
dmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBm
ZndsbC5jaD4KQ2M6IE1hdXJvIFJvc3NpIDxpc3Nvci5vcnVhbUBnbWFpbC5jb20+CkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX3RyYW5zZm9ybS5oIHwgMyAr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV90cmFuc2Zvcm0u
aCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX3RyYW5zZm9ybS5oCmlu
ZGV4IGNiY2UxOTRlYzdiODIuLmU5OGI1ZDQxNDE3MzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX3RyYW5zZm9ybS5oCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX3RyYW5zZm9ybS5oCkBAIC0xNjYsOCArMTY2LDcg
QEAKIAlTUkkoU0NMX0ZfU0hBUlBfQ09OVFJPTCwgU0NMLCBpZCkKIAogI2RlZmluZSBYRk1fQ09N
TU9OX1JFR19MSVNUX0RDRTYwKGlkKSBcCi0JWEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2MF9CQVNF
KGlkKSwgXAotCVNSSShEQ0ZFX01FTV9MSUdIVF9TTEVFUF9DTlRMLCBDUlRDLCBpZCkKKwlYRk1f
Q09NTU9OX1JFR19MSVNUX0RDRTYwX0JBU0UoaWQpCiAjZW5kaWYKIAogI2RlZmluZSBYRk1fU0Yo
cmVnX25hbWUsIGZpZWxkX25hbWUsIHBvc3RfZml4KVwKLS0gCjIuMzEuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
