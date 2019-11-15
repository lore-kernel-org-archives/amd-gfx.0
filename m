Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEABC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F4420723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F4420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EAF6E637;
	Fri, 15 Nov 2019 16:50:50 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA236E635
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:50:48 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id m125so8611625qkd.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jp8sobe6U2u/1BYRu0meomBohcsXcgJT/B6VFFnSNhY=;
 b=rJrmR6Jo3aTleXGw86b/oz8rq7We5HJWxQJNskx2rZfDiIhlGb181WgJArVWPEZCwx
 EuCiCTknRwT0De6mHU9uhUHYD3pabVuND9ChdZuBRYzm5x4ScS/MO8fRrFSq+BXbRBuu
 NJh1Gqn7+08oNiPIlb2e03fw2Onl0bdAVQcCv2GG5/N2Fz2x2FJFGpFVkRtl88jIalVx
 Uy0RKG6bAGgHBDISZP4nFiHWJsH8T7sCRi7PuHaqXWmcDu96mLeu2+Wpz6CzvFr8smtE
 5odiQCYW/JakdG1ubt0fTIURV6lCqsQJ1+OEOZ0rvWFU7WRIsCOoVxYQilx95seEFkmK
 Wtcg==
X-Gm-Message-State: APjAAAWXAw+TW7WoGUdjKf9eNz3U3RTkF+j+vrqkvnO0YyWM2OEBFkZ7
 APs7KzAvEn/OMTQEknI+4hG/EWO1
X-Google-Smtp-Source: APXvYqwWaQa8o0dQnDtY/M2B2mXXeP4TFBayHN/JKxxVC4lgxAzXhFEo3QF2BNI0f0KWDymMUpRoWA==
X-Received: by 2002:a37:a281:: with SMTP id
 l123mr13209328qke.135.1573836647772; 
 Fri, 15 Nov 2019 08:50:47 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:50:47 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 01/20] drm/amdgpu: add asic callback for BACO support
Date: Fri, 15 Nov 2019 11:50:19 -0500
Message-Id: <20191115165038.56646-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jp8sobe6U2u/1BYRu0meomBohcsXcgJT/B6VFFnSNhY=;
 b=aAp93I047Vl2VQRrYJgBx8KytGIYitYGKGgxj1ED8keEvjyUuvLcBZaDLm+99c1B/q
 sr0DAV87wpueuOWDHYi9bH+ohGGUUzT51pUMVjSqcAjLDBiN+UEzd3kE9DWKfOIlA9Rk
 DGcHtca1bs7oPe8PYwnVLVykebg736PFNv5RaW+uHpceiMWpWXQtCe0ByamvItKXCWf/
 BWvaPcjHjzNodb62mO0DPFXLfJ8NFt7VkQSSP4Keq7oNjeVnmVV13cKrgeSNbbE3GonG
 3kgOKPUKGVgweSQtzhAaWMk0DPpuC8ew23fIwFEBbLn12hWY3OEOWa6P4SeEJmnPH9hG
 qWeg==
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
Message-ID: <20191115165019.bUNBW0rjeMpUxs3IUjqlF41QxWVc34tFW84aTymaSWc@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpVc2VkIHRvIGNoZWNrIHdoZXRoZXIgdGhlIGRl
dmljZSBzdXBwb3J0cyBCQUNPLiAgVGhpcyB3aWxsCmJlIHVzZWQgdG8gZW5hYmxlIHJ1bnRpbWUg
cG0gb24gZGV2aWNlcyB3aGljaCBzdXBwb3J0IEJBQ08uCgpSZXZpZXdlZC1ieTogRXZhbiBRdWFu
IDxldmFuLnF1YW5AYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaAppbmRleCA0ZWFjMTU0OWQ0ZGUuLmQ5NTE5MDc5ODBiMSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKQEAgLTU5MSw2ICs1OTEsOCBAQCBzdHJ1Y3Qg
YW1kZ3B1X2FzaWNfZnVuY3MgewogCWJvb2wgKCpuZWVkX3Jlc2V0X29uX2luaXQpKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KTsKIAkvKiBQQ0llIHJlcGxheSBjb3VudGVyICovCiAJdWludDY0
X3QgKCpnZXRfcGNpZV9yZXBsYXlfY291bnQpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsK
KwkvKiBkZXZpY2Ugc3VwcG9ydHMgQkFDTyAqLworCWJvb2wgKCpzdXBwb3J0c19iYWNvKShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiB9OwogCiAvKgpAQCAtMTEyMSw2ICsxMTIzLDggQEAg
aW50IGVtdV9zb2NfYXNpY19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKICNkZWZp
bmUgYW1kZ3B1X2FzaWNfZ2V0X3BjaWVfdXNhZ2UoYWRldiwgY250MCwgY250MSkgKChhZGV2KS0+
YXNpY19mdW5jcy0+Z2V0X3BjaWVfdXNhZ2UoKGFkZXYpLCAoY250MCksIChjbnQxKSkpCiAjZGVm
aW5lIGFtZGdwdV9hc2ljX25lZWRfcmVzZXRfb25faW5pdChhZGV2KSAoYWRldiktPmFzaWNfZnVu
Y3MtPm5lZWRfcmVzZXRfb25faW5pdCgoYWRldikpCiAjZGVmaW5lIGFtZGdwdV9hc2ljX2dldF9w
Y2llX3JlcGxheV9jb3VudChhZGV2KSAoKGFkZXYpLT5hc2ljX2Z1bmNzLT5nZXRfcGNpZV9yZXBs
YXlfY291bnQoKGFkZXYpKSkKKyNkZWZpbmUgYW1kZ3B1X2FzaWNfc3VwcG9ydHNfYmFjbyhhZGV2
KSAoYWRldiktPmFzaWNfZnVuY3MtPnN1cHBvcnRzX2JhY28oKGFkZXYpKQorCiAjZGVmaW5lIGFt
ZGdwdV9pbmNfdnJhbV9sb3N0KGFkZXYpIGF0b21pY19pbmMoJigoYWRldiktPnZyYW1fbG9zdF9j
b3VudGVyKSk7CiAKIC8qIENvbW1vbiBmdW5jdGlvbnMgKi8KLS0gCjIuMjMuMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
