Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD49C4332B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 13:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D0F20663
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 13:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPHQuDlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D0F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFF66E2C0;
	Thu, 19 Mar 2020 13:41:06 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60BC66E2C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 13:41:05 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id h6so3037042wrs.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KzoYWUVshcvDRLZnIswhpn9rLpepvBtU5vUrhU2NxT0=;
 b=ZPHQuDlRPAbJ+DdE4t64nsf/VWxtigLgBWrqbcJQL4s9VGk4pYmdVwyNxiFj6fckIe
 7IF/d8eHSAjjaRswU+5NMz9vcxL24sGW7ajKE/Q1HjVW4j+AIDJ+ipHhgf9a34/YQOoo
 BCvOqi2y+0vBkbaOjsYgCVwnWCrEDJdCeYCAz+G0rakQfdk9MZ6qMHRK2Rw1bltwQm+Z
 89OA3090X2GG5XfKvGp8Gm7Na/bv/FgrtWLAWMYQ/Watwil85REcVSgn0B8kmJxglgVg
 6IdO8rLOq63GeLzowF8kbfisjY59PfeUK+l7oO2/ybJYefcwCyQdSHSZs9QiAOU/IXzJ
 rpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KzoYWUVshcvDRLZnIswhpn9rLpepvBtU5vUrhU2NxT0=;
 b=F3IvemYK39pW2nNLsD0+IlVeYs6J07Sv/MwmjECCWrE9BODN0U8r7gta2On3i73H3r
 IlzdrVcaAs5GJsQifm0Q3ZUA2gwwgaCHL5DqcTU0DPxK3IL/sxsPKTXP5k0d7HGJSQay
 NvCznYNpgFM9vRv17QC9Ah1dwmLspXopH/eNzCtdbhPIjZCMJMCmu55m5JbLoVCV297l
 QIdtHOSCn5vyOwmQ1FDG/Awxh2CYbwbeCdyahlsxphtgfnjda3/4PT5UyTfYRbLn66tp
 9+nHnKA5qhik13pWQ1OrxVwtQiSwRqiKwQNcYgx5caJZ0m2MRQQu/W9w55S5dYPejNRP
 bp3g==
X-Gm-Message-State: ANhLgQ0UGZFfmaXSJNRU7EVsIvHOhXjBj7dmjPWSMfPgBHkpdx9t7Od3
 AisZ2yHWOkUoVzC+Co80np/8P1mY
X-Google-Smtp-Source: ADFU+vshF9r10HoDg1Y5ZFuVrmwlhfISYxU8vLux93sNVExNK4BbfTtUYLzzkSiF2qbtiffE6Zr+Mw==
X-Received: by 2002:adf:fc8c:: with SMTP id g12mr4550393wrr.277.1584625263882; 
 Thu, 19 Mar 2020 06:41:03 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:eca2:7dcd:fca0:220d])
 by smtp.gmail.com with ESMTPSA id s131sm3243833wmf.35.2020.03.19.06.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 06:41:03 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add full TMZ support into
 amdgpu_ttm_map_buffer
Date: Thu, 19 Mar 2020 14:41:02 +0100
Message-Id: <20200319134102.25679-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319134102.25679-1-christian.koenig@amd.com>
References: <20200319134102.25679-1-christian.koenig@amd.com>
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
Cc: Felix.Kuehling@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBzaG91bGQgYWxsb3cgdXMgdG8gYWxzbyBzdXBwb3J0IFZSQU0tPkdUVCBtb3Zlcy4KClNp
Z25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAzNiArKysrKysr
KysrKysrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgOCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKaW5kZXgg
MmI1OTc0MjY4ZTYzLi5jN2VkNGUyZjg0NjAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMKQEAgLTMwNywyMSArMzA3LDIxIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9t
YXBfYnVmZmVyKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCiAJCQkJIHVuc2lnbmVkIHdp
bmRvdywgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAogCQkJCSBib29sIHRteiwgdWludDY0X3Qg
KmFkZHIpCiB7Ci0Jc3RydWN0IHR0bV9kbWFfdHQgKmRtYSA9IGNvbnRhaW5lcl9vZihiby0+dHRt
LCBzdHJ1Y3QgdHRtX2RtYV90dCwgdHRtKTsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9
IHJpbmctPmFkZXY7CiAJc3RydWN0IGFtZGdwdV9qb2IgKmpvYjsKIAl1bnNpZ25lZCBudW1fZHcs
IG51bV9ieXRlczsKLQlkbWFfYWRkcl90ICpkbWFfYWRkcmVzczsKIAlzdHJ1Y3QgZG1hX2ZlbmNl
ICpmZW5jZTsKIAl1aW50NjRfdCBzcmNfYWRkciwgZHN0X2FkZHI7CisJdm9pZCAqY3B1X2FkZHI7
CiAJdWludDY0X3QgZmxhZ3M7CisJdW5zaWduZWQgaW50IGk7CiAJaW50IHI7CiAKIAlCVUdfT04o
YWRldi0+bW1hbi5idWZmZXJfZnVuY3MtPmNvcHlfbWF4X2J5dGVzIDwKIAkgICAgICAgQU1ER1BV
X0dUVF9NQVhfVFJBTlNGRVJfU0laRSAqIDgpOwogCiAJLyogTWFwIG9ubHkgd2hhdCBjYW4ndCBi
ZSBhY2Nlc3NlZCBkaXJlY3RseSAqLwotCWlmIChtZW0tPnN0YXJ0ICE9IEFNREdQVV9CT19JTlZB
TElEX09GRlNFVCkgeworCWlmICghdG16ICYmIG1lbS0+c3RhcnQgIT0gQU1ER1BVX0JPX0lOVkFM
SURfT0ZGU0VUKSB7CiAJCSphZGRyID0gYW1kZ3B1X21tX25vZGVfYWRkcihibywgbW1fbm9kZSwg
bWVtKSArIG9mZnNldDsKIAkJcmV0dXJuIDA7CiAJfQpAQCAtMzQ5LDE1ICszNDksMzUgQEAgc3Rh
dGljIGludCBhbWRncHVfdHRtX21hcF9idWZmZXIoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpi
bywKIAlhbWRncHVfcmluZ19wYWRfaWIocmluZywgJmpvYi0+aWJzWzBdKTsKIAlXQVJOX09OKGpv
Yi0+aWJzWzBdLmxlbmd0aF9kdyA+IG51bV9kdyk7CiAKLQlkbWFfYWRkcmVzcyA9ICZkbWEtPmRt
YV9hZGRyZXNzW29mZnNldCA+PiBQQUdFX1NISUZUXTsKIAlmbGFncyA9IGFtZGdwdV90dG1fdHRf
cHRlX2ZsYWdzKGFkZXYsIGJvLT50dG0sIG1lbSk7CiAJaWYgKHRteikKIAkJZmxhZ3MgfD0gQU1E
R1BVX1BURV9UTVo7CiAKLQlyID0gYW1kZ3B1X2dhcnRfbWFwKGFkZXYsIDAsIG51bV9wYWdlcywg
ZG1hX2FkZHJlc3MsIGZsYWdzLAotCQkJICAgICZqb2ItPmlic1swXS5wdHJbbnVtX2R3XSk7Ci0J
aWYgKHIpCi0JCWdvdG8gZXJyb3JfZnJlZTsKKwljcHVfYWRkciA9ICZqb2ItPmlic1swXS5wdHJb
bnVtX2R3XTsKKworCWlmIChtZW0tPm1lbV90eXBlID09IFRUTV9QTF9UVCkgeworCQlzdHJ1Y3Qg
dHRtX2RtYV90dCAqZG1hOworCQlkbWFfYWRkcl90ICpkbWFfYWRkcmVzczsKKworCQlkbWEgPSBj
b250YWluZXJfb2YoYm8tPnR0bSwgc3RydWN0IHR0bV9kbWFfdHQsIHR0bSk7CisJCWRtYV9hZGRy
ZXNzID0gJmRtYS0+ZG1hX2FkZHJlc3Nbb2Zmc2V0ID4+IFBBR0VfU0hJRlRdOworCQlyID0gYW1k
Z3B1X2dhcnRfbWFwKGFkZXYsIDAsIG51bV9wYWdlcywgZG1hX2FkZHJlc3MsIGZsYWdzLAorCQkJ
CSAgICBjcHVfYWRkcik7CisJCWlmIChyKQorCQkJZ290byBlcnJvcl9mcmVlOworCX0gZWxzZSB7
CisJCWRtYV9hZGRyX3QgZG1hX2FkZHJlc3M7CisKKwkJZG1hX2FkZHJlc3MgPSAobW1fbm9kZS0+
c3RhcnQgPDwgUEFHRV9TSElGVCkgKyBvZmZzZXQ7CisJCWZvciAoaSA9IDA7IGkgPCBudW1fcGFn
ZXM7ICsraSkgeworCQkJciA9IGFtZGdwdV9nYXJ0X21hcChhZGV2LCBpIDw8IFBBR0VfU0hJRlQs
IDEsCisJCQkJCSAgICAmZG1hX2FkZHJlc3MsIGZsYWdzLCBjcHVfYWRkcik7CisJCQlpZiAocikK
KwkJCQlnb3RvIGVycm9yX2ZyZWU7CisKKwkJCWRtYV9hZGRyZXNzICs9IFBBR0VfU0laRTsKKwkJ
fQorCX0KIAogCXIgPSBhbWRncHVfam9iX3N1Ym1pdChqb2IsICZhZGV2LT5tbWFuLmVudGl0eSwK
IAkJCSAgICAgIEFNREdQVV9GRU5DRV9PV05FUl9VTkRFRklORUQsICZmZW5jZSk7Ci0tIAoyLjE3
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
