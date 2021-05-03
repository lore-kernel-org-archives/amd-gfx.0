Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AACC433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 14:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964BA6105A
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 14:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964BA6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1119889C9C;
	Mon,  3 May 2021 14:03:24 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6F789C9C
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 14:03:22 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id zg3so8017958ejb.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 May 2021 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=3UWrIoNENMyXeyOKGP4d1pYUJ7q2J0w06GLwpoUhLdA=;
 b=IHvnjXlBel+fEknwGr5IN9p0svYpNgpC93bRtqJLa3Yktj0fASyiLjzU/hy6X0QXFo
 P6MBggR0hxU+h+z5IA70SEMK3nNr2bqdbWWpAay0+xOAKFBADc9H3/K3toYz3v7Za1ed
 a6VvL0SG1B6xo4kuvf99YifO1ODd7PxFeoqAufJHf5OEuzYjl6YPkrnvHcbdMPmZwJ83
 FkInALCtgOWSoRINHZyYP3e6BRzaNhmve3rigijwrA37OH7LgmtQZ36oFB79Qqkk8EGZ
 nD8QDgI7lOm8s8ewW6pzcGvGBg8mMGhJj2QZzXlhJWg2x/BN42S094FFHLRGMbYubM1i
 fWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=3UWrIoNENMyXeyOKGP4d1pYUJ7q2J0w06GLwpoUhLdA=;
 b=nheLWi5vIxkjekZgB5kweJnYJf/dm097N/A5IfNVmoymMRMB54HnrjMBbQyalJGG71
 AAX23Dt2+CijDobBF82RuKCjmNr+ECSr3qXvnzA0vSucnM1WLCYWIe1/IGuJiEUKQ506
 Usl5U1pJURWnu6sdf2iiOZSphfM1hU9pfbYmWchLVci00ptb9+dINnMD36QT/3fEDUpr
 BzS7zZtJerUGeh8YhrvrFqXxsVUtGkSXIXjTqB44mbinAg1fgrNvrE9sIe7bsgALHbAp
 cA19b2QNgCGRxcO1T2H1yUbLXGuOPdAB1q9VOwY9gUDiqMvAZwHY5XSr4tX9ayAuRgLQ
 StRw==
X-Gm-Message-State: AOAM530I6OFQmyAdlhKCYTwHwFGYVas+j0UpLlzNcx4Gtl5gtY99/+cc
 SBTGi/5aOB3GiqaVDTviU2swobCaR+Y=
X-Google-Smtp-Source: ABdhPJwdSLJWEUvcyUfQy3dz9Yzn3yGP6d6jerrNPF61BAUmzfGZndpCoayv8vpU1+HG6zd9zg5QCQ==
X-Received: by 2002:a17:906:9444:: with SMTP id
 z4mr16897382ejx.330.1620050600811; 
 Mon, 03 May 2021 07:03:20 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3a91:af9f:fcbf:5d42?
 ([2a02:908:1252:fb60:3a91:af9f:fcbf:5d42])
 by smtp.gmail.com with ESMTPSA id re26sm11080418ejb.3.2021.05.03.07.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 May 2021 07:03:20 -0700 (PDT)
Subject: Re: [PATCH 1/2] MAINTAINERS: Fix TTM tree
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210503134736.1467003-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <854e937c-aec3-6f62-d0ba-1c13dd7423e8@gmail.com>
Date: Mon, 3 May 2021 16:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210503134736.1467003-1-alexander.deucher@amd.com>
Content-Language: en-US
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
Cc: David Ward <david.ward@gatech.edu>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMDUuMjEgdW0gMTU6NDcgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVFRNIHVzZXMgZHJt
LW1pc2Mgbm93LiAgVXBkYXRlIHRoZSB0cmVlLgo+Cj4gQ2M6IERhdmlkIFdhcmQgPGRhdmlkLndh
cmRAZ2F0ZWNoLmVkdT4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhlIHNlcmllcy4KCj4gLS0tCj4gICBNQUlOVEFJTkVSUyB8
IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKPiBpbmRleCBmMDNhMTk4
Y2JjNTIuLjI3ZWUyYTY1OTg2NyAxMDA2NDQKPiAtLS0gYS9NQUlOVEFJTkVSUwo+ICsrKyBiL01B
SU5UQUlORVJTCj4gQEAgLTYxMzQsNyArNjEzNCw3IEBAIE06CUNocmlzdGlhbiBLb2VuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAgIE06CUh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5j
b20+Cj4gICBMOglkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gICBTOglNYWludGFp
bmVkCj4gLVQ6CWdpdCBnaXQ6Ly9wZW9wbGUuZnJlZWRlc2t0b3Aub3JnL35hZ2Q1Zi9saW51eAo+
ICtUOglnaXQgZ2l0Oi8vYW5vbmdpdC5mcmVlZGVza3RvcC5vcmcvZHJtL2RybS1taXNjCj4gICBG
Oglkcml2ZXJzL2dwdS9kcm0vdHRtLwo+ICAgRjoJaW5jbHVkZS9kcm0vdHRtLwo+ICAgCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
