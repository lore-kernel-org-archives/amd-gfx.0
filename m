Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48974C43381
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A812399C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A812399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812906E8F9;
	Fri,  8 Jan 2021 20:24:18 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE396E8CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:24 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id q18so10188219wrn.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ch2gYAE2vDuTmkFhr3daFGk6qkpCbvS5cnZ4t3WwTr8=;
 b=eWMH5So3djuul8qB47/3pj9n9lXtnPj8xRPt9BjaVXr7omscVJhIB4YxEbAeWG+kVU
 V523YJopK++IkvFlH40/ocBNKEE2KCzUFsXZ0acwbVrjjcZE+vmVs6wcpIwM+lUH/TWE
 UGvwUmNRSZ2SXHtSNNkw+HlzMeX1+JmaaOV7SXPjUcI9jfmdroTxKE9uyW52BcyHNRcr
 Fd1/Ewe7GlTTC+mkHhelgArACGCH3CX9bsBdJWFtx+AtspM2pDGmxvUQo5eNd9HRSfef
 O/sIm9IVFTencRTxkmeiCoxBIA/tlAeVeCAzhZr2WZiz43T+nJLkvEXeP2Ch9JztHmSa
 /pCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ch2gYAE2vDuTmkFhr3daFGk6qkpCbvS5cnZ4t3WwTr8=;
 b=QLcLC2gsz3yKB8RESX6qpLeVk5c/mgoJyK4cs2SUkYdJs0WU59t0RAAouK9yeR9mYE
 S8n9rI97/BxNAgiAQJBWfZ6SCSNrR85bC/KTpzSJcJT205x12+ERoh/TTdtTOjLFK0Nb
 wWj+QINZHkNhqKsXxcHb/Ay+MXt9MRsoSBoZp5yEBlwAcCr8yfO5P5Jal8rkZM9+fm1t
 O0/Nkslwml8rMcrPUSdORfVIf2U3K6I58HdrwqYbpfJ8/K5MGBoO9W0lMLM62oZAHGM2
 zsE+QdJAqI4KjZB5tAFsCX6H6IWjFehAT5nRa9UJr/nOdFWvlgVdDlauiEULV03nBz9P
 N7zA==
X-Gm-Message-State: AOAM5332AcMF6D5e1JN01xzPyWzsOIH0X9pnTksPTyPt7YjU2L05DblF
 iu28sZM6lLCybz0V7aCKYWFQ6Q==
X-Google-Smtp-Source: ABdhPJyWHXz1lvcQZIGRwW+Sx8oVGMph2zWCusorEAyZWKLb5aQ14ApYuk5uNjw20CEbFeXTCbxgnw==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr5300851wrv.132.1610136922870; 
 Fri, 08 Jan 2021 12:15:22 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:21 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 13/40] drm/amd/display/dc/basics/conversion: Demote obvious
 kernel-doc abuse
Date: Fri,  8 Jan 2021 20:14:30 +0000
Message-Id: <20210108201457.3078600-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Jan 2021 20:24:14 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iYXNpY3MvY29udmVyc2lvbi5jOjg2
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdtYXRyaXgnIG5vdCBkZXNj
cmliZWQgaW4gJ2NvbnZlcnRfZmxvYXRfbWF0cml4JwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvLi4vZGlzcGxheS9kYy9iYXNpY3MvY29udmVyc2lvbi5jOjg2OiB3YXJuaW5nOiBGdW5jdGlv
biBwYXJhbWV0ZXIgb3IgbWVtYmVyICdmbHQnIG5vdCBkZXNjcmliZWQgaW4gJ2NvbnZlcnRfZmxv
YXRfbWF0cml4JwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iYXNp
Y3MvY29udmVyc2lvbi5jOjg2OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVy
ICdidWZmZXJfc2l6ZScgbm90IGRlc2NyaWJlZCBpbiAnY29udmVydF9mbG9hdF9tYXRyaXgnCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2Jhc2ljcy9jb252ZXJzaW9u
LmM6ODY6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ3BhcmFtJyBkZXNjcmlw
dGlvbiBpbiAnY29udmVydF9mbG9hdF9tYXRyaXgnCgpDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5
LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVk
QGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExl
ZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2Jhc2ljcy9jb252ZXJzaW9uLmMgfCA5ICsrKy0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFzaWNzL2NvbnZlcnNpb24uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvY29udmVyc2lvbi5jCmluZGV4IDI0ZWQwM2Q4Y2Rh
NzQuLjY3NjdmYWI1NWMyNjAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9iYXNpY3MvY29udmVyc2lvbi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9iYXNpY3MvY29udmVyc2lvbi5jCkBAIC03MywxMiArNzMsOSBAQCB1aW50MTZfdCBmaXhl
ZF9wb2ludF90b19pbnRfZnJhYygKIAogCXJldHVybiByZXN1bHQ7CiB9Ci0vKioKLSogY29udmVy
dF9mbG9hdF9tYXRyaXgKLSogVGhpcyBjb252ZXJ0cyBhIGRvdWJsZSBpbnRvIEhXIHJlZ2lzdGVy
IHNwZWMgZGVmaW5lZCBmb3JtYXQgUzJEMTMuCi0qIEBwYXJhbSA6Ci0qIEByZXR1cm4gTm9uZQot
Ki8KKy8qCisgKiBjb252ZXJ0X2Zsb2F0X21hdHJpeCAtIFRoaXMgY29udmVydHMgYSBkb3VibGUg
aW50byBIVyByZWdpc3RlciBzcGVjIGRlZmluZWQgZm9ybWF0IFMyRDEzLgorICovCiB2b2lkIGNv
bnZlcnRfZmxvYXRfbWF0cml4KAogCXVpbnQxNl90ICptYXRyaXgsCiAJc3RydWN0IGZpeGVkMzFf
MzIgKmZsdCwKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
