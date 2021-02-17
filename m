Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7AFC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591A364DE0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591A364DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EC46E1CF;
	Wed, 17 Feb 2021 19:00:43 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325546E9B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 19:00:41 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id lu16so9284933ejb.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 11:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mxtM1tCUKhbuQPXdTVlsOGo4bsl8Ch0XdCofT+/uXeE=;
 b=GYueDJk95R56vFW52vTq10Tr9CpBOZivx5x1dhJ96yK96qIoFjYMgNqt+WfJuQwYBk
 GhqTqfZDGn3TEVnTLKFtOy53jPjbO8G8bRwuXjbCX3lqaEkcidqJUxyB/w3ei4tx9qDM
 WjqaEtFSy2tkUv3ihUulALXzOpuCaZgI7MwJcSG3VlVsVb6gv7TpXTDXHe8xg3kJCgj7
 eVgb7K+bETLrT0f7PSjSTKjGuYtxw9yxUg8LVDtbvVIh3ZjF9NmU1vrOHjV+Ow8mtONE
 jcyEb33g/sJ6/EtJAJuZAZ25Ehwfv30ESS+m/gAsy5d/fBqiB3qWsXn2B8ly/HjxEYDy
 7VMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mxtM1tCUKhbuQPXdTVlsOGo4bsl8Ch0XdCofT+/uXeE=;
 b=sxfUALqmozJK79/vMs89NabQ0k/j7O3uGD1/kJTKOM5WGLRI2NolaDpMGuDCCmGrDU
 HqOy8BLn4sHBXXdtP2hx7LPSZOiO6F1XoODiJFAINJsd0YtXjOsFrnwM7R8HBs/2imI1
 /YIfwv2xX52LRXHTBuM+8qSsmvqlYzA+lbIATMrqTdlFX7ICn35uGUpW/RRDER9BWD3h
 3GWiXNfuG1CIuvG3XDI0OFDFq2ayZZFGCh+SSSZXXNS8Ml2QZzdnLtw2mbCfMQtNd8J1
 HZnU+Q3+JOA16C2U5vxivugXBRwKYyMOdzdhOGpKiUrxgvZ7H/xkhozaiCFSG+AyPlhp
 Tc+A==
X-Gm-Message-State: AOAM532LClkOb/wd+W1QcilSgaImBks5IuogamXU8BHLpV7EH1t+xHc4
 IjoAwQtIdLJu8/tZ+gE5DC4=
X-Google-Smtp-Source: ABdhPJyz9rbhMrSQhKqHpmKpPBvxHzlIpvw2f743qc2iNpOjuSZw2P5UCyuFM4JJE4ZzZy5EMM7bIA==
X-Received: by 2002:a17:906:38a:: with SMTP id
 b10mr404059eja.438.1613588434274; 
 Wed, 17 Feb 2021 11:00:34 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:b7c6:d2d7:631c:11b7])
 by smtp.gmail.com with ESMTPSA id r4sm1562710edv.27.2021.02.17.11.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 11:00:34 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ramesh.Errabolu@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amdgpu: use the new cursor in
 amdgpu_ttm_bo_eviction_valuable
Date: Wed, 17 Feb 2021 20:00:27 +0100
Message-Id: <20210217190028.16409-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217190028.16409-1-christian.koenig@amd.com>
References: <20210217190028.16409-1-christian.koenig@amd.com>
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
Cc: Arunpravin.PaneerSelvam@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VwYXJhdGUgdGhlIGRybV9tbV9ub2RlIHdhbGtpbmcgZnJvbSB0aGUgYWN0dWFsIGhhbmRsaW5n
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDE0ICsr
KysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwppbmRleCA4ZWM4MGEz
ODRiZTMuLjVmMThmM2Y1OTFmMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYwpAQCAtMTQ4OSw3ICsxNDg5LDcgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X3R0bV9ib19ldmlj
dGlvbl92YWx1YWJsZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCQkJCQkgICAgY29u
c3Qgc3RydWN0IHR0bV9wbGFjZSAqcGxhY2UpCiB7CiAJdW5zaWduZWQgbG9uZyBudW1fcGFnZXMg
PSBiby0+bWVtLm51bV9wYWdlczsKLQlzdHJ1Y3QgZHJtX21tX25vZGUgKm5vZGUgPSBiby0+bWVt
Lm1tX25vZGU7CisJc3RydWN0IGFtZGdwdV9yZXNfY3Vyc29yIGN1cnNvcjsKIAlzdHJ1Y3QgZG1h
X3Jlc3ZfbGlzdCAqZmxpc3Q7CiAJc3RydWN0IGRtYV9mZW5jZSAqZjsKIAlpbnQgaTsKQEAgLTE1
MjEsMTMgKzE1MjEsMTUgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X3R0bV9ib19ldmljdGlvbl92YWx1
YWJsZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCiAJY2FzZSBUVE1fUExfVlJBTToK
IAkJLyogQ2hlY2sgZWFjaCBkcm0gTU0gbm9kZSBpbmRpdmlkdWFsbHkgKi8KLQkJd2hpbGUgKG51
bV9wYWdlcykgewotCQkJaWYgKHBsYWNlLT5mcGZuIDwgKG5vZGUtPnN0YXJ0ICsgbm9kZS0+c2l6
ZSkgJiYKLQkJCSAgICAhKHBsYWNlLT5scGZuICYmIHBsYWNlLT5scGZuIDw9IG5vZGUtPnN0YXJ0
KSkKKwkJYW1kZ3B1X3Jlc19maXJzdCgmYm8tPm1lbSwgMCwgKHU2NCludW1fcGFnZXMgPDwgUEFH
RV9TSElGVCwKKwkJCQkgJmN1cnNvcik7CisJCXdoaWxlIChjdXJzb3IucmVtYWluaW5nKSB7CisJ
CQlpZiAocGxhY2UtPmZwZm4gPCBQRk5fRE9XTihjdXJzb3Iuc3RhcnQgKyBjdXJzb3Iuc2l6ZSkK
KwkJCSAgICAmJiAhKHBsYWNlLT5scGZuICYmCisJCQkJIHBsYWNlLT5scGZuIDw9IFBGTl9ET1dO
KGN1cnNvci5zdGFydCkpKQogCQkJCXJldHVybiB0cnVlOwogCi0JCQludW1fcGFnZXMgLT0gbm9k
ZS0+c2l6ZTsKLQkJCSsrbm9kZTsKKwkJCWFtZGdwdV9yZXNfbmV4dCgmY3Vyc29yLCBjdXJzb3Iu
c2l6ZSk7CiAJCX0KIAkJcmV0dXJuIGZhbHNlOwogCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
