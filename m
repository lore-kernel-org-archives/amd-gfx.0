Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AADCC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9C620728
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9C620728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA326E635;
	Fri, 15 Nov 2019 16:51:03 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082C36E996
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:51:03 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id m16so8598226qki.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4qojIgGbWEnHYfN+shtVDFUDibgxQlLZqNEeWIlyiqA=;
 b=hHqBOJTEm+emmzhUJlWWM6Sv7bn/wdhLiLM3UrJdU7f+aPjlgGIDX9ZJXZI9Qnni/u
 AiPxR+5sRycQw6z54NEkzO3vxusQ+Z1XxtBNzBzcsrZYQQ+qfAMf8bSTLqt7W/iDfR/l
 KYYGidq9+jLICoy+fcnFzJfLAVt5i9nM234nIomLS9QjvKUbiotOUDLW4THgRv3nMUyB
 3WLOpOqbTep3tbtzIIzij3Y6tzvSKo/LF+xuf8iEFELy3/zP0NO7Rv80IbtoBV4trACR
 EfyLk9g01MVrES5cyMNh9Vg8osVWWV9sE7wvh6Kotur21qyT0s6mjtlrgzRw7IqiXM1Z
 c84A==
X-Gm-Message-State: APjAAAU7k05H08WzQcGijRVOMA5V6FwNOYTXzp3sh1wXLpBWs3vVs6h5
 0euADgFYIIDbUXBe9mLCBOmrBucJ
X-Google-Smtp-Source: APXvYqx8zWWe9iN+OHngtO6IBQGnPAjCQGrhhGw8F5lc25PXwubLu0JRPffOnhe99olIpvVSIIrQPw==
X-Received: by 2002:a37:470b:: with SMTP id u11mr13595211qka.172.1573836661881; 
 Fri, 15 Nov 2019 08:51:01 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:51:01 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 15/20] drm/amdgpu: enable runtime pm on BACO capable boards if
 runpm=1
Date: Fri, 15 Nov 2019 11:50:33 -0500
Message-Id: <20191115165038.56646-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4qojIgGbWEnHYfN+shtVDFUDibgxQlLZqNEeWIlyiqA=;
 b=SpM0Uh/QsUtC36uuYwiwGmlUU/sbXM1nibYLSieH6JFEER108IkPpW//9qpkPyM6/M
 0tdtziZy7XuigeACpL3zOjAF7+1xGgtpeTsSlKHJu8RH5HvB6cNftxPHuN4h9Amt8udI
 KpRd6ApRceGJ1Sme4p8TaWB4VjAIzLw0+9BWtV9D0BTauSERP+s24sVRzPxVbJ7tGe83
 ZNV9asGmkRoLWSMbb+fMSSw3/Zvp9gUj7tvQ8nRMWDZR36bfqOcKPVKkxIgnPu/A2NsL
 9dW6fgfsCNbnfP2YJQa+UEFieO3NyK+vBxrEfY0Rr9OYLHXLP46cuFXKuggQD5BOcV/f
 srCg==
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
Message-ID: <20191115165033.yxSf3Emi6isRACdpiRQ3NuQfLbdnjBKLK5BqMMT-9-4@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpFdmVyeXRoaW5nIGlzIGluIHBsYWNlIG5vdy4g
IE5vdCBlbmFibGVkIGJ5IGRlZmF1bHQgeWV0LiAgWW91CnN0aWxsIGhhdmUgdG8gc3BlY2lmeSBy
dW5wbT0xLgoKUmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgfCAxMSArKysrKysrLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKaW5kZXggODliMDIxYzU0YjkzLi4xNjlkYjk0
MWY5MzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKQEAgLTE1Nywx
MCArMTU3LDYgQEAgaW50IGFtZGdwdV9kcml2ZXJfbG9hZF9rbXMoc3RydWN0IGRybV9kZXZpY2Ug
KmRldiwgdW5zaWduZWQgbG9uZyBmbGFncykKIAkgICAgIXBjaV9pc190aHVuZGVyYm9sdF9hdHRh
Y2hlZChkZXYtPnBkZXYpKQogCQlmbGFncyB8PSBBTURfSVNfUFg7CiAKLQlpZiAoKGFtZGdwdV9y
dW50aW1lX3BtICE9IDApICYmCi0JICAgIChmbGFncyAmIEFNRF9JU19QWCkpCi0JCWFkZXYtPnJ1
bnBtID0gdHJ1ZTsKLQogCS8qIGFtZGdwdV9kZXZpY2VfaW5pdCBzaG91bGQgcmVwb3J0IG9ubHkg
ZmF0YWwgZXJyb3IKIAkgKiBsaWtlIG1lbW9yeSBhbGxvY2F0aW9uIGZhaWx1cmUgb3IgaW9tYXBw
aW5nIGZhaWx1cmUsCiAJICogb3IgbWVtb3J5IG1hbmFnZXIgaW5pdGlhbGl6YXRpb24gZmFpbHVy
ZSwgaXQgbXVzdApAQCAtMTczLDYgKzE2OSwxMyBAQCBpbnQgYW1kZ3B1X2RyaXZlcl9sb2FkX2tt
cyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB1bnNpZ25lZCBsb25nIGZsYWdzKQogCQlnb3RvIG91
dDsKIAl9CiAKKwlpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19ib2NvKGRldikgJiYKKwkgICAg
KGFtZGdwdV9ydW50aW1lX3BtICE9IDApKSAvKiBlbmFibGUgcnVucG0gYnkgZGVmYXVsdCAqLwor
CQlhZGV2LT5ydW5wbSA9IHRydWU7CisJZWxzZSBpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19i
YWNvKGRldikgJiYKKwkJIChhbWRncHVfcnVudGltZV9wbSA+IDApKSAvKiBlbmFibGUgcnVucG0g
aWYgcnVucG09MSAqLworCQlhZGV2LT5ydW5wbSA9IHRydWU7CisKIAkvKiBDYWxsIEFDUEkgbWV0
aG9kczogcmVxdWlyZSBtb2Rlc2V0IGluaXQKIAkgKiBidXQgZmFpbHVyZSBpcyBub3QgZmF0YWwK
IAkgKi8KLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
