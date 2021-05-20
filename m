Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B214C4363E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FABA61001
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FABA61001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A0B6F481;
	Thu, 20 May 2021 12:49:19 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BC96F428
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:42 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 f19-20020a05600c1553b02901794fafcfefso4627860wmg.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6mgshcP2pz5KQTmITqtWPb+8Vos4vgRG6+nB+UjzMjU=;
 b=tUt9PCzCAgYSzeHm+P1Ghip4HpN8YnHaAQec9JZBmLu/UiSm3dqz+0Eq4AUl1JeewR
 GPJihct9FOVQk7MB2BFf56q8fgx85aYR1AVv4Qb6uC8h6Ig9DVcUY7MNDzmrmoDmnIVb
 b/aDxqtCCaItHxQN4Vue6SffHLJ7GJRadEFaztJ5Q8avyChaDNrAD+Ve16oA+kOl3BzC
 I4cIFXOmH4nMVxIsG+Ishev7ik97tI0aY9qluBFyK3K2uGqRy9bxMoPdkvr2l4hkolMs
 M8aDaXX0uZ1vnu1y9mtQxAFhZKb3Dmtkr/iNiF1oT3caN0gj4X66CvQgpZcatQCGQTDQ
 Ig2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6mgshcP2pz5KQTmITqtWPb+8Vos4vgRG6+nB+UjzMjU=;
 b=rxtG9BwAYUpwFtl99VxK6CirLtgIPnm/4cccOGDdIxaSd0F4HQcCU5kqdcr7MoCuDx
 iUhtCs4R2Wt98plw3eV3rbCG484mfCZMb2wIsVyH2ywFZDg1Vhhstp9Zuu8IisMTxS8O
 v0WrkLh9MuLfiLfS7pcMw6AHPtEJmFB//ce0ZfYoMzBAsqNUceP7N81FoeragfC1okz7
 CdF9u5YuauiVsBqf+4EfdXrP5rAjNk9GApeTaRsVYYg0mwVsk26Gu7DVaGzIOP83lLix
 fmCs5/lx/XYXgjlsNn8Qih03U2vdbL0wcsZAKehxGQDh9AK+Wsp1d1ohiGhJy1e7paj1
 abnQ==
X-Gm-Message-State: AOAM531uqtnoAlypnvJxAaTx3aD/A3p30Rpf8fmM7TBWoQ4iNnh99Jui
 XyEPnBchYem1nzFdnnOuYOCSPQ==
X-Google-Smtp-Source: ABdhPJy7Digd+9bRZbHP/CdiStM7jlSFRh4jCbRvATVAcPCDbZlUSdF/nEVi4DaSTU2nAfXjcoZCBQ==
X-Received: by 2002:a05:600c:2054:: with SMTP id
 p20mr3758231wmg.165.1621512221171; 
 Thu, 20 May 2021 05:03:41 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:40 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 38/38] drm/amd/amdgpu/smuio_v13_0: Realign
 'smuio_v13_0_is_host_gpu_xgmi_supported()' header
Date: Thu, 20 May 2021 13:02:48 +0100
Message-Id: <20210520120248.3464013-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc211aW9fdjEzXzAuYzo5OTogd2FybmluZzogZXhwZWN0aW5n
IHByb3RvdHlwZSBmb3Igc211aW9fdjEzXzBfc3VwcG9ydHNfaG9zdF9ncHVfeGdtaSgpLiBQcm90
b3R5cGUgd2FzIGZvciBzbXVpb192MTNfMF9pc19ob3N0X2dwdV94Z21pX3N1cHBvcnRlZCgpIGlu
c3RlYWQKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAi
Q2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFp
cmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5j
aD4KQ2M6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KQ2M6IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
ClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc211aW9fdjEzXzAuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NtdWlvX3YxM18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zbXVpb192MTNfMC5jCmluZGV4IDNjNDdjOTQ4NDZkNmQuLjM5YjdjMjA2NzcwZjYgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdWlvX3YxM18wLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc211aW9fdjEzXzAuYwpAQCAtMTA2LDcgKzEwNiw3
IEBAIHN0YXRpYyB1MzIgc211aW9fdjEzXzBfZ2V0X3NvY2tldF9pZChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIH0KIAogLyoqCi0gKiBzbXVpb192MTNfMF9zdXBwb3J0c19ob3N0X2dwdV94
Z21pIC0gZGV0ZWN0IHhnbWkgaW50ZXJmYWNlIGJldHdlZW4gY3B1IGFuZCBncHUvcy4KKyAqIHNt
dWlvX3YxM18wX2lzX2hvc3RfZ3B1X3hnbWlfc3VwcG9ydGVkIC0gZGV0ZWN0IHhnbWkgaW50ZXJm
YWNlIGJldHdlZW4gY3B1IGFuZCBncHUvcy4KICAqCiAgKiBAYWRldjogYW1kZ3B1IGRldmljZSBw
b2ludGVyCiAgKgotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
