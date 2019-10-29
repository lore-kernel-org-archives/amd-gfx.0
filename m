Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F98CA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249C42086A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249C42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F4D6E2CA;
	Tue, 29 Oct 2019 12:42:32 +0000 (UTC)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C4B6E16D;
 Tue, 29 Oct 2019 09:19:52 +0000 (UTC)
Received: by mail-pf1-x441.google.com with SMTP id q26so5472441pfn.11;
 Tue, 29 Oct 2019 02:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=VQh5oRSrn/jaJpLx3QrkWsF+eR7SZm+MJ/X6BG8VNCk=;
 b=ONgi5Jdxlq6OUZ9/TX61c3qOT4iKd2Say75bS95PC9xAkfl7FVxf7ppp7KQOLbEQG6
 8jgoOcnj9n0v0v8aZBdma63X4hG7AVPqn2uWTwitHI4Mbdg4Kkx8O+WaVdJatZdhqdT1
 AbPKye8o5B1Uu0oc5J8mp3258gumwyVR04nD4izJOpY5Nu/D5wXaLOj2Cv/NzzG7//zJ
 0oHwcNeSWbzhcylpBkHG06a/keQ3GW6XECcn02nqP+3K1PLE4uQUlmjsGUAfzqR4WoBU
 X4XtSulg8H+mwRGbYDDs+WZqas+nIoRmTnlDlg0A1cxlfnkusaAxV7ijgP7+inuxXKDc
 Va7Q==
X-Gm-Message-State: APjAAAWXEL4GwkGFCvs4ksYGQ6qJHhRDAsj6p9SYgQUEJXXfDvWv+U5c
 KjweeLEKo4DJEhjuGdUmKg8=
X-Google-Smtp-Source: APXvYqy1UQHX5TYjIfx2Ppc5n9sA+ugVLJUG+NpLME8hrS1nyMrwsO4VWwFQqfXlPEwYoDneY4FW4A==
X-Received: by 2002:a62:6411:: with SMTP id y17mr26055073pfb.158.1572340791899; 
 Tue, 29 Oct 2019 02:19:51 -0700 (PDT)
Received: from saurav ([27.62.167.137])
 by smtp.gmail.com with ESMTPSA id i7sm1691256pjs.1.2019.10.29.02.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 02:19:51 -0700 (PDT)
Date: Tue, 29 Oct 2019 14:49:43 +0530
From: Saurav Girepunje <saurav.girepunje@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 tom.stdenis@amd.com, xywang.sjtu@sjtu.edu.cn, Jack.Xiao@amd.com,
 sam@ravnborg.org, Kevin1.Wang@amd.com, saurav.girepunje@gmail.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm: amd: amdgpu: Remove NULL check not needed before
 freeing functions
Message-ID: <20191029091943.GA10258@saurav>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Tue, 29 Oct 2019 12:42:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent;
 bh=VQh5oRSrn/jaJpLx3QrkWsF+eR7SZm+MJ/X6BG8VNCk=;
 b=uxs0uwpFgkNBtfpybCdyu7Hxl0sazaEpDe6OVN/XLuv0QfEAaizwFdoXk1N8Ez4U77
 FWXhlodBqy63DTFmodqIUg8GsY+BXuMK4A2ShaSNKw/bpOsSxazJtpa0y9ytv6Fmj/t6
 93eMignZ/0T+J7QCTWiK4lILtBJ3NiiYtqP1bbYll/OKeLuuUPPyVEMabcMuJ8Qo5VxC
 XIgTX+YaO1ynvmNWoIUuCmggyj22t/k4mAJ1wSO19GmQ8MoUSxoGiCNSlqrAPHI3BZ74
 Kbwnqjww9rwrpPHjsy02EJK8+AMmunuWrZydY70UaPJYSDYg7I4AI79wc89tc4m+FXgj
 /gKA==
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
Cc: saurav.girepunje@hotmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029091943.R93Nmr1sfdXoQbvh2xzyTuMGyO4OTd4Jt6rBfiPxORM@z>

UmVtb3ZlIHVubmVlZGVkIE5VTEwgY2hlY2sgYmVmb3JlIGZyZWVpbmcgZnVuY3Rpb25zCmtmcmVl
IGFuZCBkZWJ1Z2ZzX3JlbW92ZS4KClNpZ25lZC1vZmYtYnk6IFNhdXJhdiBHaXJlcHVuamUgPHNh
dXJhdi5naXJlcHVuamVAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZWJ1Z2ZzLmMgfCA2ICsrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGVidWdmcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RlYnVnZnMuYwppbmRleCA1NjUyY2M3MmVkM2EuLmNiOTQ2MjdmYzBmNCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCkBAIC0xMDc3LDggKzEwNzcsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV9kZWJ1Z2ZzX2liX3ByZWVtcHQodm9pZCAqZGF0YSwgdTY0IHZh
bCkKIAogCXR0bV9ib191bmxvY2tfZGVsYXllZF93b3JrcXVldWUoJmFkZXYtPm1tYW4uYmRldiwg
cmVzY2hlZCk7CiAKLQlpZiAoZmVuY2VzKQotCQlrZnJlZShmZW5jZXMpOworCWtmcmVlKGZlbmNl
cyk7CiAKIAlyZXR1cm4gMDsKIH0KQEAgLTExMDMsOCArMTEwMiw3IEBAIGludCBhbWRncHVfZGVi
dWdmc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiB2b2lkIGFtZGdwdV9kZWJ1
Z2ZzX3ByZWVtcHRfY2xlYW51cChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKLQlpZiAo
YWRldi0+ZGVidWdmc19wcmVlbXB0KQotCQlkZWJ1Z2ZzX3JlbW92ZShhZGV2LT5kZWJ1Z2ZzX3By
ZWVtcHQpOworCWRlYnVnZnNfcmVtb3ZlKGFkZXYtPmRlYnVnZnNfcHJlZW1wdCk7CiB9CiAKICNl
bHNlCi0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
