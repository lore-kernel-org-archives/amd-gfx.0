Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAFEC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84692071B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84692071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8626E147;
	Fri, 22 Nov 2019 21:44:08 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D1B6E147
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 21:44:06 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id q140so2960000ywg.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 13:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYENIjArnsOjhA9ffVrRGheHs4eqvuQRpAYUpV5zbb8=;
 b=ch8R8N3NxvzRpKvyz1QPI6Wpf05ta5XWcKFDqwoELfoZbS+QSmxRiv4Q9Gz6a97PTC
 1VJMGEaxdR1OC7kfx4tnMCPeeBHcH1QpWFV9RpwXqxSMX4x+tyNicEzdcAV+iFpZIn8A
 jfIUt3n8dySEVi7phKnB79ah7G6uAKCYt+oIomCdpNevKEDKHpk2cdBKcc2f05fVGiAc
 6eM4m/tNQqZ2cp/0wttj9FTkHnr1ZDLYgifhN1mAi16h5hZysDbz0edgZ3BVgD9Mz4sj
 oJc8QumoQVeW5ZOHxdNoLcKitysus4UcRhBJM8ZedXlkEZo7t3FlKVT7uepahFyS+aFu
 6vDw==
X-Gm-Message-State: APjAAAUfqAIXWheUvtA7/5ZXGZA3P5WtvLi3yTj7DidSxAhcSpVeVaRj
 P/RJbKA84CoTKKUkKND6YkJtCIaX
X-Google-Smtp-Source: APXvYqwA3Yic3yjGiXJeV9UndcS0Q4L8RqTFvnw5cbDHTe+9NPKTOJCzm1LenWZATmekFOjxvrwydQ==
X-Received: by 2002:a81:f005:: with SMTP id p5mr11474085ywm.147.1574459045432; 
 Fri, 22 Nov 2019 13:44:05 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t15sm2111522ywh.70.2019.11.22.13.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 13:44:04 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de
Subject: [PATCH 4/4] ALSA: hda/hdmi - enable automatic runtime pm for AMD HDMI
 codecs by default
Date: Fri, 22 Nov 2019 16:43:53 -0500
Message-Id: <20191122214353.582899-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191122214353.582899-1-alexander.deucher@amd.com>
References: <20191122214353.582899-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QYENIjArnsOjhA9ffVrRGheHs4eqvuQRpAYUpV5zbb8=;
 b=agg5pZrSlcJgWUKMUO9YgPvy3DMz7lk+8H61AuEseYg69n9R427w3WJdUiT5ihflAZ
 aEHhZ3Kk/DzjXnEIHubHfFgchBRaYLESD8u4MAWvvR1D1IhxAJcyD6J3IVlyq7T6OG/Y
 HL0z7c+zAk8JgpYUyL02wfA0ndAuZ6SeXs6jGIA7hAfhMtbljpElVtip+EjefdZIWtWk
 AyCckcCDAH1w0cb9sz5zqvpGLz5VRtaEHhqGC7gKmQU12xDc9Uhdy90q19PyDTfDAjMz
 0/B3YnQSia7BRP3TKKVrzC0cpFf+VQvHUBIU9bUKHmHaWrPly4yijwQ34qU62WO1yG/y
 G5GQ==
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
Message-ID: <20191122214353.rv9lgmwO0TKpgPu4Obxiw5WZPmBUaJkkBQEetOiQgwk@z>

U28gdGhhdCB3ZSBjYW4gcG93ZXIgZG93biB0aGUgR1BVIGFuZCBhdWRpbyB0byBzYXZlIHBvd2Vy
LgoKUmV2aWV3ZWQtYnk6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KQWNrZWQtYnk6IEV2
YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX2hkbWku
YyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc291
bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2hkbWkuYwppbmRl
eCA3OTVjYmRhMzJjYmIuLjg3ODVmY2M4NTBiOSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9w
YXRjaF9oZG1pLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMKQEAgLTM5NjEsNiAr
Mzk2MSw3IEBAIHN0YXRpYyBpbnQgYXRpaGRtaV9pbml0KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVj
KQogCQkJCQkgICAgQVRJX1ZFUkJfU0VUX01VTFRJQ0hBTk5FTF9NT0RFLAogCQkJCQkgICAgQVRJ
X01VTFRJQ0hBTk5FTF9NT0RFX1NJTkdMRSk7CiAJfQorCWNvZGVjLT5hdXRvX3J1bnRpbWVfcG0g
PSAxOwogCiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
