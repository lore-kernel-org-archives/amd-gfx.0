Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF86C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6B1239A1
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6B1239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FE66E8FA;
	Fri,  8 Jan 2021 20:24:22 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E116E8C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:16:00 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id e25so9470288wme.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TsGB1GbRM0lE0DyQTr0kdLB4zVZuV/mNjcQ+anLlZ8k=;
 b=G8ruob3uLWUoFGkXg2GA/wzh7YN3To9pFFqngX5lh6jb6ZP9fzcDMAWNtCSRMw0EJI
 ohAQAqhBbi7T7wkgQHXylQTgplUVDEbTlp08mvRxQzKt1Wv27/kJ12a0pJoYJYGYGUIH
 Vxd1p29aXq8Eo8L7IZ8M8Aa5x2upHls1cXhgf7hp67wDXkwFgiTd4GSceUNYdVJLGKEJ
 Gv+ZJB4i/GW//bkLwhkEQ87maDacEv19mt7dOsic8lCQnPaiqcDa+OwmNOYcm4iEk0AS
 Un+AiOhhi7OBWMPkB0i6OXUtl+noOlMnqhpL2mtwAuC1J2158geqv+1Lbns0tTZhK0Q8
 mVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TsGB1GbRM0lE0DyQTr0kdLB4zVZuV/mNjcQ+anLlZ8k=;
 b=C/TnPHhEvF5+WtY0VXL4CsAfS4e1m4VNwe+EzNaWVX32HkQBIn07zSySJ5d3OaSQx3
 0gDWTig9Ux64O/YuwGFiTqBfFi4u+OToaAqn7cWom8pALlNLpmSRrWNyZxajIeZNrTvW
 zHcTRc5jvxAFtLl2u0w3bcNPd8oCIxAziFCVhE34z+KytHhiteNcJHJpPHbiLcE5/hK6
 04wJE1Dn/FfBHMLNFG1FWG5gHx+N3gPqVllQyHCwuS30tqGUPTIZQFqLtsdF/G9jKxua
 tM1hKgYuGLxv/h8M43qyqJJgmTd1foCxUl2KHPxs6A+z9CWoXcHA4D1IkzXYlfpEqJEm
 V7uA==
X-Gm-Message-State: AOAM533EDNCGAoZZX/Nalxxa5alUOTtv7ikcEaeJr2ILB4HcNu7JIdEb
 cg4b4/JDhcICgojA2lIAEt2lDw==
X-Google-Smtp-Source: ABdhPJwwPGHcY+vfmrr91v+jp+f/K5LWjnXGsz3D0XwUCn+P1mL7BB+7RYk/8up01Y82mjEoOAJB1A==
X-Received: by 2002:a05:600c:1552:: with SMTP id
 f18mr4492260wmg.125.1610136959036; 
 Fri, 08 Jan 2021 12:15:59 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:58 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 38/40] drm/amd/display/dc/dce/dce_panel_cntl: Remove unused
 variables 'bl_pwm_cntl' and 'pwm_period_cntl'
Date: Fri,  8 Jan 2021 20:14:55 +0000
Message-Id: <20210108201457.3078600-39-lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX3BhbmVsX2NudGwuYzog
SW4gZnVuY3Rpb24g4oCYZGNlX2dldF8xNl9iaXRfYmFja2xpZ2h0X2Zyb21fcHdt4oCZOgogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX3BhbmVsX2NudGwu
Yzo1NDoxMTogd2FybmluZzogdmFyaWFibGUg4oCYYmxfcHdtX2NudGzigJkgc2V0IGJ1dCBub3Qg
dXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9wYW5lbF9jbnRsLmM6NTM6MTE6IHdhcm5pbmc6IHZh
cmlhYmxlIOKAmHB3bV9wZXJpb2RfY250bOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1i
dXQtc2V0LXZhcmlhYmxlXQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQu
Y29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6
IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IEFudGhvbnkgS29vIDxBbnRob255
Lktvb0BhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUu
am9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
L2RjZV9wYW5lbF9jbnRsLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY2UvZGNlX3BhbmVsX2NudGwuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY2UvZGNlX3BhbmVsX2NudGwuYwppbmRleCA3NjFmZGZjMWY1YmQwLi5lOTIzMzky
MzU4NjMxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2Rj
ZV9wYW5lbF9jbnRsLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9k
Y2VfcGFuZWxfY250bC5jCkBAIC01MCwxNiArNTAsMTYgQEAgc3RhdGljIHVuc2lnbmVkIGludCBk
Y2VfZ2V0XzE2X2JpdF9iYWNrbGlnaHRfZnJvbV9wd20oc3RydWN0IHBhbmVsX2NudGwgKnBhbmVs
X2MKIHsKIAl1aW50NjRfdCBjdXJyZW50X2JhY2tsaWdodDsKIAl1aW50MzJfdCByb3VuZF9yZXN1
bHQ7Ci0JdWludDMyX3QgcHdtX3BlcmlvZF9jbnRsLCBibF9wZXJpb2QsIGJsX2ludF9jb3VudDsK
LQl1aW50MzJfdCBibF9wd21fY250bCwgYmxfcHdtLCBmcmFjdGlvbmFsX2R1dHlfY3ljbGVfZW47
CisJdWludDMyX3QgYmxfcGVyaW9kLCBibF9pbnRfY291bnQ7CisJdWludDMyX3QgYmxfcHdtLCBm
cmFjdGlvbmFsX2R1dHlfY3ljbGVfZW47CiAJdWludDMyX3QgYmxfcGVyaW9kX21hc2ssIGJsX3B3
bV9tYXNrOwogCXN0cnVjdCBkY2VfcGFuZWxfY250bCAqZGNlX3BhbmVsX2NudGwgPSBUT19EQ0Vf
UEFORUxfQ05UTChwYW5lbF9jbnRsKTsKIAotCXB3bV9wZXJpb2RfY250bCA9IFJFR19SRUFEKEJM
X1BXTV9QRVJJT0RfQ05UTCk7CisJUkVHX1JFQUQoQkxfUFdNX1BFUklPRF9DTlRMKTsKIAlSRUdf
R0VUKEJMX1BXTV9QRVJJT0RfQ05UTCwgQkxfUFdNX1BFUklPRCwgJmJsX3BlcmlvZCk7CiAJUkVH
X0dFVChCTF9QV01fUEVSSU9EX0NOVEwsIEJMX1BXTV9QRVJJT0RfQklUQ05ULCAmYmxfaW50X2Nv
dW50KTsKIAotCWJsX3B3bV9jbnRsID0gUkVHX1JFQUQoQkxfUFdNX0NOVEwpOworCVJFR19SRUFE
KEJMX1BXTV9DTlRMKTsKIAlSRUdfR0VUKEJMX1BXTV9DTlRMLCBCTF9BQ1RJVkVfSU5UX0ZSQUNf
Q05ULCAodWludDMyX3QgKikoJmJsX3B3bSkpOwogCVJFR19HRVQoQkxfUFdNX0NOVEwsIEJMX1BX
TV9GUkFDVElPTkFMX0VOLCAmZnJhY3Rpb25hbF9kdXR5X2N5Y2xlX2VuKTsKIAotLSAKMi4yNS4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
