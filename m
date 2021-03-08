Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C8BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 18:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3366516B
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 18:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3366516B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E5326E83A;
	Mon,  8 Mar 2021 18:36:47 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3866E83A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 18:36:46 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id b13so16256759edx.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 10:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ibe/vCvycjADf9enteXzmNfrMhRAX/VusrumEK4Qm/U=;
 b=qBMUQjpndgBiS62X8kwDQgfUvW8rebX5IR2xsqksZ2/68/rUBY3Yym7HxfZoM6k6wk
 gJTKS22XfEIWw5dO+DSWqfT5owdWIOTXR32tdMd6JCXsYeTUmstjM83CMUxf9tRI3EEr
 fCDUuHWWdEXig+lxkYPzjyajNwyMT02i+b72ZwDTZKLcgtJJnFlw1TCKS4R37lOQJHGU
 +NDEWDFRMf6Ua+1IesY8NJ5VqwxA26eH8s4TzQ279CtLI7SAUs+9VHXnfcQRUCYL9V03
 357++dFBxRStSinGNQJ8PyPGQEBX96X57+sU89n3MVhrTbWDWOztpig3raLMSx7M0PGg
 +rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ibe/vCvycjADf9enteXzmNfrMhRAX/VusrumEK4Qm/U=;
 b=IKhv+MpG3VKwWS7ZPY+9s3LsdmNENtkLJRbl1pUyu39pWv7VC9DHqoSdtgCbZ+oD/n
 4LJChOJxHYoZVhSHlsYrOt0CiOLDyAFMBJqsp5morCpF9QAwSpLgw1fmc7wG/cUN5G8s
 CGpU3F0jvy6+lpBD7Z3H12nQA2qG1icf/hXrJUrFJX8TUpaiUWMDVJ8ZRJgatvPCYNuk
 QJ/f9SF6mlSfNtZUPUy9bubVtMd1GRTI+RQKGA6UzCaZxzn2BwXoIv8C0rU2CsTwDIDv
 Po0TTR3Su7xaObkAD65TD/jMu/XfLKGGDo5DuBhl8hp2oSWAvPjlgFgZvs4tqjO3Brtf
 XnYA==
X-Gm-Message-State: AOAM533EWTyB0LnRcZ1qQMR79UtK8PFB8sv+3TcVSpQ0udDZlr3E8y7+
 pHdBNq+Ob6wYiE8VqOY/fSeP4FEsZ8PBAg==
X-Google-Smtp-Source: ABdhPJxeLCvB0x8TpF0fp3aOEaD4cPMUTlvekyrIqWdBMDflRwoMyzVjM4QtfZfKquHDRN0ZKjQpbQ==
X-Received: by 2002:aa7:ce1a:: with SMTP id d26mr23556877edv.206.1615228605208; 
 Mon, 08 Mar 2021 10:36:45 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:5f05:a903:d4af:1240])
 by smtp.gmail.com with ESMTPSA id n16sm6972029ejy.35.2021.03.08.10.36.44
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 10:36:44 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/radeon: fix AGP dependency
Date: Mon,  8 Mar 2021 19:36:42 +0100
Message-Id: <20210308183643.36710-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308183643.36710-1-christian.koenig@amd.com>
References: <20210308183643.36710-1-christian.koenig@amd.com>
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

V2hlbiBBR1AgaXMgY29tcGlsZWQgYXMgbW9kdWxlIHJhZGVvbiBtdXN0IGJlIGNvbXBpbGVkIGFz
IG1vZHVsZSBhcwp3ZWxsLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9LY29uZmlnIHwgMSArCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vS2NvbmZpZyBiL2RyaXZlcnMvZ3B1L2RybS9LY29uZmlnCmluZGV4IGUzOTJhOTBjYTY4Ny4u
ODViNzlhN2ZlZTYzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vS2NvbmZpZworKysgYi9k
cml2ZXJzL2dwdS9kcm0vS2NvbmZpZwpAQCAtMjI4LDYgKzIyOCw3IEBAIHNvdXJjZSAiZHJpdmVy
cy9ncHUvZHJtL2FybS9LY29uZmlnIgogY29uZmlnIERSTV9SQURFT04KIAl0cmlzdGF0ZSAiQVRJ
IFJhZGVvbiIKIAlkZXBlbmRzIG9uIERSTSAmJiBQQ0kgJiYgTU1VCisJZGVwZW5kcyBvbiBBR1Ag
fHwgIUFHUAogCXNlbGVjdCBGV19MT0FERVIKICAgICAgICAgc2VsZWN0IERSTV9LTVNfSEVMUEVS
CiAgICAgICAgIHNlbGVjdCBEUk1fVFRNCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
