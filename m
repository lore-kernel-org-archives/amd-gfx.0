Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF33FC47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6D761090
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6D761090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E29B6EE29;
	Thu, 27 May 2021 04:28:36 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F376EE29;
 Thu, 27 May 2021 04:28:34 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 v19-20020a0568301413b0290304f00e3d88so3223294otp.4; 
 Wed, 26 May 2021 21:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gQjxsSRS4ydNcXF9pucXevV0+AhUrLegN/w6TYUgMI8=;
 b=QlQmjDn6z94Pppj7T6ya1xFBxp8g7V7WNNOAuKdXGgb3KDrkqtwkVDa6QjqQfRWAxp
 IehrTUHtLS6NFrBncRzcTsQYiZLw15sRT9wEdEuiJcwgEBde2WYAlf+7AmR9kfiGNuZ/
 q4lE4PWUKlArihSjZ0aEAajWdrfiiShwI9I3Zrqfw+sskK/FPr8tndpzOOWMHVEuRSyI
 AablOMg/nR5ZmgAAx6xrK52OsbC8erqhiH3+7HcgZZV5Ko0y/XryB6h6vXXQsoArMNOG
 1B6TC8GDa4ygPY+cHmdd8QpGCUk6GYBr2iasz6lLidikx0ODqbPVS8CEinxSeBkQ/t6D
 EZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gQjxsSRS4ydNcXF9pucXevV0+AhUrLegN/w6TYUgMI8=;
 b=b/J+JgTgS741XHpdaNXEOns/yNM0PKQ9EoCHpnw257Fjn/6+ENVVcKCfyAab6DNEXP
 V/nfNoWi99fheAAdPBNYMp6CkliTk5970zZaPD8vumAtbapOfWbj3VqB989BvN9iGkCk
 WCScdskyF6hlgZyFJo2BipgEzOd6XSzHK6hjkcF2YKwZS3HaXLtslc307MmKIZ5bSF4R
 e2h03SfHJ/0SLOrIgnR3gZl3joLRtaz4xaMuD6PqXuJis8Me+xk91PPyTwk4emhYiliO
 Y8Oiuy5nHj/70dcCBa0SZCMHWadkJEwOMs1dM0lYIflKWPg3zUzkdOjJUmCsb7r2MSQF
 E+Sg==
X-Gm-Message-State: AOAM531ePrEl3cRa4PjsILI3yoTpPwjkbwmCfWFTpn/KGQuAlyKPAJTF
 J+NirZUtT7j3GQp8xG3BAKHrAwQWL6r6D+8kqG77JuJ8
X-Google-Smtp-Source: ABdhPJwiWfCa9s13Zp943GQapPrNqWbSjjx7yv0ThfuE4qmncVu1XyBw6yoOio/ydrfKDSgu+OHAnDnDtboArgAq9J4=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr1339496otl.132.1622089714372; 
 Wed, 26 May 2021 21:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-25-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-25-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 May 2021 00:28:23 -0400
Message-ID: <CADnq5_MnDkxiRYmLa4J8ezVXhX6VSL4rffTCRpaeq7f+BVqoag@mail.gmail.com>
Subject: Re: [PATCH 24/34] drm/amd/display/modules/hdcp/hdcp_psp: Remove
 unused function 'mod_hdcp_hdcp1_get_link_encryption_status()'
To: Lee Jones <lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDggQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwX3BzcC5jOjM3NDoyMjogd2FybmluZzog
bm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhtb2RfaGRjcF9oZGNwMV9nZXRfbGlua19lbmNy
eXB0aW9uX3N0YXR1c+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCj4KPiBDYzogSGFycnkgV2Vu
dGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gQ2M6IExlbyBMaSA8c3VucGVuZy5saUBh
bWQuY29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4g
Q2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBE
YXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8
bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9tb2R1bGVzL2hkY3AvaGRjcF9wc3AuYyB8IDEzIC0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9wc3AuYwo+IGluZGV4IDI2Zjk2YzA1ZTBlYzguLjA2
OTEwZDJmZDU3YTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21v
ZHVsZXMvaGRjcC9oZGNwX3BzcC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L21vZHVsZXMvaGRjcC9oZGNwX3BzcC5jCj4gQEAgLTM3MSwxOSArMzcxLDYgQEAgZW51bSBtb2Rf
aGRjcF9zdGF0dXMgbW9kX2hkY3BfaGRjcDFfbGlua19tYWludGVuYW5jZShzdHJ1Y3QgbW9kX2hk
Y3AgKmhkY3ApCj4gICAgICAgICByZXR1cm4gc3RhdHVzOwo+ICB9Cj4KPiAtZW51bSBtb2RfaGRj
cF9zdGF0dXMgbW9kX2hkY3BfaGRjcDFfZ2V0X2xpbmtfZW5jcnlwdGlvbl9zdGF0dXMoc3RydWN0
IG1vZF9oZGNwICpoZGNwLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gbW9kX2hkY3BfZW5jcnlwdGlvbl9zdGF0dXMg
KmVuY3J5cHRpb25fc3RhdHVzKQo+IC17Cj4gLSAgICAgICAqZW5jcnlwdGlvbl9zdGF0dXMgPSBN
T0RfSERDUF9FTkNSWVBUSU9OX1NUQVRVU19IRENQX09GRjsKPiAtCj4gLSAgICAgICBpZiAobW9k
X2hkY3BfaGRjcDFfbGlua19tYWludGVuYW5jZShoZGNwKSAhPSBNT0RfSERDUF9TVEFUVVNfU1VD
Q0VTUykKPiAtICAgICAgICAgICAgICAgcmV0dXJuIE1PRF9IRENQX1NUQVRVU19GQUlMVVJFOwo+
IC0KPiAtICAgICAgICplbmNyeXB0aW9uX3N0YXR1cyA9IE1PRF9IRENQX0VOQ1JZUFRJT05fU1RB
VFVTX0hEQ1AxX09OOwo+IC0KPiAtICAgICAgIHJldHVybiBNT0RfSERDUF9TVEFUVVNfU1VDQ0VT
UzsKPiAtfQo+IC0KPiAgZW51bSBtb2RfaGRjcF9zdGF0dXMgbW9kX2hkY3BfaGRjcDJfY3JlYXRl
X3Nlc3Npb24oc3RydWN0IG1vZF9oZGNwICpoZGNwKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgcHNw
X2NvbnRleHQgKnBzcCA9IGhkY3AtPmNvbmZpZy5wc3AuaGFuZGxlOwo+IC0tCj4gMi4zMS4xCj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
