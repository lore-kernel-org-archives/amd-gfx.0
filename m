Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC51C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 17:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665E72225C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 17:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHEdFf3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665E72225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F056C6EA45;
	Mon, 26 Oct 2020 17:50:55 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260DC6EA1B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 17:50:55 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id 140so9184441qko.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MMZQlaEqO92QzC0pwJJFFZ4OVVRnA/cf8vWaWpoZs0E=;
 b=UHEdFf3RBIUH90m/ucVVmIcutPqZB1kiNXDj1BjTrGUFoUK5ciZv6xG1RCGkR8blEb
 oswRpdZtJ8s4kb8DcguGDwov4l6FY0dv30O1wFizjozpXhKKtWeGcHR8xf5ili+g4Uga
 Tfgr8fhMidyF0niVyJSqEv9WwH8szKbVgKeGna6pZK8zNCiCvXAhZO1PG8CB/wAf4FF0
 4qSrRbJTWKYIoItvFxdaVPyu1HuBc1l2o5+FWCmwdM15CsQWViQMGceGzoNoSQjjWnGl
 /qd2Omu1tolLJu+XpMR72efbW1Uy5oe4sP844h7Q039KqeLOtQ6RG9KfaIawMLKLvRU/
 2wVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MMZQlaEqO92QzC0pwJJFFZ4OVVRnA/cf8vWaWpoZs0E=;
 b=pUgKL0rQdIGUYsFPdStO7w2VWbuBQ0eTCdGP5EdCWxFlIOjpjEeMIJ6GKgcVmvrejp
 grlDQ2Q7K7O3k7toy+gArG1wvHglceLTkqjX4mpkeAIYK43poeaFo0kCjEBM3m3aFLlo
 Govu3dBJg+Ma0GNL71CXHgdo6lsH/wFJyb4MRAJlWjwk6c4J4ygrHwBuET7SgOu9IRUH
 Ge4eyf4zDcDD9F+XAHMlAGPP8ZXc28BD7gsWvloztojiaumP6Ux2kH/uA74D1B8EceMJ
 cVYZos3j0FQWPmWBGJNRKpj2EjI2lUT2vU4JuakAj/K1du/86MD4YZJ61utPAJzwROgD
 znoQ==
X-Gm-Message-State: AOAM531Tfsm91KELtVV2nKrPhrENLtt6yAk7G5rsH0VGT8SMIpzmeusy
 mK9hcAZX0Y07ZP/E3QZYskx6IAG366k=
X-Google-Smtp-Source: ABdhPJzc+U7S4T/m5GB/9cN3DUReCwGk83tZ1g1vI81MgWFrOWHDKtXOdapUoJeu5uYNnnD2VOEc3g==
X-Received: by 2002:ae9:f444:: with SMTP id z4mr17555850qkl.338.1603734654084; 
 Mon, 26 Oct 2020 10:50:54 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l30sm7388836qta.73.2020.10.26.10.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 10:50:53 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix indentation in
 defer_delay_converter_wa()
Date: Mon, 26 Oct 2020 13:50:45 -0400
Message-Id: <20201026175045.1064936-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhpcyB3YXJuaW5nOgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5
L2RjL2NvcmUvZGNfbGlua19kZGMuYzogSW4gZnVuY3Rpb24g4oCYZGVmZXJfZGVsYXlfY29udmVy
dGVyX3dh4oCZOgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUv
ZGNfbGlua19kZGMuYzoyODU6Mjogd2FybmluZzogdGhpcyDigJhpZuKAmSBjbGF1c2UgZG9lcyBu
b3QgZ3VhcmQuLi4gWy1XbWlzbGVhZGluZy1pbmRlbnRhdGlvbl0KICAyODUgfCAgaWYgKGxpbmst
PmRwY2RfY2Fwcy5icmFuY2hfZGV2X2lkID09IERQX0JSQU5DSF9ERVZJQ0VfSURfMDA4MEUxICYm
CiAgICAgIHwgIF5+CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY29y
ZS9kY19saW5rX2RkYy5jOjI5MTozOiBub3RlOiAuLi50aGlzIHN0YXRlbWVudCwgYnV0IHRoZSBs
YXR0ZXIgaXMgbWlzbGVhZGluZ2x5IGluZGVudGVkIGFzIGlmIGl0IHdlcmUgZ3VhcmRlZCBieSB0
aGUg4oCYaWbigJkKICAyOTEgfCAgIGlmIChsaW5rLT5kcGNkX2NhcHMuYnJhbmNoX2Rldl9pZCA9
PSBEUF9CUkFOQ0hfREVWSUNFX0lEXzAwNjAzNyAmJgogICAgICB8ICAgXn4KClNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RkYy5jIHwgMTQgKysrKysrKy0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19k
ZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZGRjLmMK
aW5kZXggZWYwZjUwZGI0OTA3Li41NGJlZGE0ZDRlODUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZGRjLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kZGMuYwpAQCAtMjgzLDE1ICsyODMsMTUg
QEAgc3RhdGljIHVpbnQzMl90IGRlZmVyX2RlbGF5X2NvbnZlcnRlcl93YSgKIAlzdHJ1Y3QgZGNf
bGluayAqbGluayA9IGRkYy0+bGluazsKIAogCWlmIChsaW5rLT5kcGNkX2NhcHMuYnJhbmNoX2Rl
dl9pZCA9PSBEUF9CUkFOQ0hfREVWSUNFX0lEXzAwODBFMSAmJgotCQkhbWVtY21wKGxpbmstPmRw
Y2RfY2Fwcy5icmFuY2hfZGV2X25hbWUsCi0JCQlEUF9EVklfQ09OVkVSVEVSX0lEXzQsCi0JCQlz
aXplb2YobGluay0+ZHBjZF9jYXBzLmJyYW5jaF9kZXZfbmFtZSkpKQorCSAgICAhbWVtY21wKGxp
bmstPmRwY2RfY2Fwcy5icmFuY2hfZGV2X25hbWUsCisJCSAgICBEUF9EVklfQ09OVkVSVEVSX0lE
XzQsCisJCSAgICBzaXplb2YobGluay0+ZHBjZF9jYXBzLmJyYW5jaF9kZXZfbmFtZSkpKQogCQly
ZXR1cm4gZGVmZXJfZGVsYXkgPiBJMkNfT1ZFUl9BVVhfREVGRVJfV0FfREVMQVkgPwogCQkJZGVm
ZXJfZGVsYXkgOiBJMkNfT1ZFUl9BVVhfREVGRVJfV0FfREVMQVk7Ci0JCWlmIChsaW5rLT5kcGNk
X2NhcHMuYnJhbmNoX2Rldl9pZCA9PSBEUF9CUkFOQ0hfREVWSUNFX0lEXzAwNjAzNyAmJgotCQkJ
IW1lbWNtcChsaW5rLT5kcGNkX2NhcHMuYnJhbmNoX2Rldl9uYW1lLAotCQkJCURQX0RWSV9DT05W
RVJURVJfSURfNSwKLQkJCQlzaXplb2YobGluay0+ZHBjZF9jYXBzLmJyYW5jaF9kZXZfbmFtZSkp
KQorCWlmIChsaW5rLT5kcGNkX2NhcHMuYnJhbmNoX2Rldl9pZCA9PSBEUF9CUkFOQ0hfREVWSUNF
X0lEXzAwNjAzNyAmJgorCSAgICAhbWVtY21wKGxpbmstPmRwY2RfY2Fwcy5icmFuY2hfZGV2X25h
bWUsCisJCSAgICBEUF9EVklfQ09OVkVSVEVSX0lEXzUsCisJCSAgICBzaXplb2YobGluay0+ZHBj
ZF9jYXBzLmJyYW5jaF9kZXZfbmFtZSkpKQogCQlyZXR1cm4gZGVmZXJfZGVsYXkgPiBJMkNfT1ZF
Ul9BVVhfREVGRVJfV0FfREVMQVlfMU1TID8KIAkJCUkyQ19PVkVSX0FVWF9ERUZFUl9XQV9ERUxB
WV8xTVMgOiBkZWZlcl9kZWxheTsKIAotLSAKMi4yNS40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
