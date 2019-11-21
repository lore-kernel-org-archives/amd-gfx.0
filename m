Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B91C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 21:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28892068E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 21:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28892068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABFE6E198;
	Thu, 21 Nov 2019 21:04:27 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC376E065
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 21:04:25 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z7so2723270wrl.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 13:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2Zy8TLFf/x96qboxSvzR/Vke67a80snl80ST3FLjBIU=;
 b=DjVsGh5uZlTv8ecjPvwijDOhNORiC7Cef3hr5ymqlttRCIjIFVOalrzbKFzCq6MxIA
 eReA6ZYRrj5cdhvfU4fL+uM7ZtIs7ikwJL77WcBYSxiSzJowVqyqb6DRsnKo5MYaUHrS
 bLNwC5ptopi01xJI4YTUDdjIgY3p3Q+w5YeDuqA/95YL9S/vkWSZ6hgCnLDkydr8RFkX
 SOCcBFlHd/wbSEaLylyubRetlm9k9sLdnZuT37g/QBiazqWzbCg9N8vfgIu6hv6+Oytz
 mi+Q4uKxaz+Zca3bNPg+eCFEqk2oc4jqN3spcSTQI5bP9WyDAsd2bd8GSlRaoU4zG1et
 59UQ==
X-Gm-Message-State: APjAAAUQk/hMeX+Mv5JnYMDLSXTCNnxZGoMR3+ono7vGY8gYRshUtk68
 e74cgrZGUQapezUaa6DQZbM=
X-Google-Smtp-Source: APXvYqxAJs+QzLHEXDWqvnwdVdeZ/Qo9eGjaAvdmfJpDxi4ONHfgDb6oNkqHPJYfJc98lUGgpvCU0A==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr13349734wrv.164.1574370264591; 
 Thu, 21 Nov 2019 13:04:24 -0800 (PST)
Received: from localhost (108.78.124.78.rev.sfr.net. [78.124.78.108])
 by smtp.gmail.com with ESMTPSA id 17sm886253wmg.19.2019.11.21.13.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 13:04:24 -0800 (PST)
Date: Thu, 21 Nov 2019 21:03:58 +0000
From: sylvain.bertrand@gmail.com
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: GFX[6-9] unconditionaly "allocate" the max of sgprs and vgprs to
 align on GFX10?
Message-ID: <20191121210358.GA20685@freedom>
References: <20191121201200.GA11433@freedom>
 <CADnq5_NyGhdzq2duXaqRjJi6djQS63SfD3Cu_Maom2e6rsi-TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_NyGhdzq2duXaqRjJi6djQS63SfD3Cu_Maom2e6rsi-TQ@mail.gmail.com>
User-Agent: Mutt/ (2018-04-13)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2Zy8TLFf/x96qboxSvzR/Vke67a80snl80ST3FLjBIU=;
 b=SNLr2+SnPGBcs43oRk3etb1r03Pokxx2hVF0NH6VgXRrnzaIz3A6X9Ub+lpCRL6AnU
 CmbNfS5a21eSbqagfjPkzA7Ev4wQ20iJ0am/gCcB0iBQpn3NzYocEXoSn5CzsryNBn+Z
 KEv2k/oRi9cD4Rb+JdTOXPJj2wWZejv2SJhS+9fL3n/iW5J5Sb3m1GBPa1gTRl/mcUWh
 NUxhPuBQglxv8TLttDgGOtEGAnH++3oRiGKwJPb9SuU3IsXc8GslBkcR/iVaPAIBLKp2
 XuVyzE7MJomuMSJfBwEhMKBz8FSg6WZM7zeo3DQLrCUZlwRLWThqx4Hi5ERWbDb9LSlu
 KLvQ==
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121210358.z_REMIuZrI52rcKQs106tvqeEml-M9fVIBwPpqfocuE@z>

T24gVGh1LCBOb3YgMjEsIDIwMTkgYXQgMDM6MTc6MTJQTSAtMDUwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgcXVlc3Rpb24uICBXaGF0IGFyZSB5b3Ug
YXNraW5nIGFib3V0PwoKT24gR0ZYWzYtOV0sIG1heWJlIGl0IGNvdWxkIGJlIGEgY291bGQgaWRl
YSB0byBmcmVlemUgdGhlIG51bWJlciBvZiBhbGxvY2F0ZWQKc2dwcnMgYW5kIG51bWJlciBvZiBh
bGxvY2F0ZWQgdmdwcnMsIGEgYml0IGxpa2Ugd2hhdCB3ZSBoYXZlIG9uIEdGWDEwLiBUaGVuIHdl
CmNvdWxkIHJlbW92ZSBhbGwgdGhlIHJlZ2lzdGVycyBhbGxvY2F0aW9uIGNvZGUgZm9yIGEgbGl0
dGxlIGJpdCBvZiBjb2RlCmNsZWFudXAgYW5kIGdldCBzaW1pbGFyIGNvZGUgb24gR0ZYWzYtMTBd
LgoKLS0gClN5bHZhaW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
