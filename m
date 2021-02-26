Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED53AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 14:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9085164DE3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 14:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9085164DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B2826EDF4;
	Fri, 26 Feb 2021 14:24:38 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C1D6EDF5
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 14:04:50 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id b3so6657816qtj.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 06:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:references:cc:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1JEukEMCcmHwVVmzZx32jRs8YD9yHp96jXQUebpSa2A=;
 b=FAiigxpJeoY+mHu/KqFnqWfdFvB4kY6VKG7Q9MzoXnWX+hNbIq93y0k5IvhuavhOuv
 lwBtMrCN8bsE0k9ebYGnZ0v7CvHAXhFvc53BOAXNJLGa6KKyspbk4hpIjP406tv19PI8
 cif/9w5z4EWZ/eipj0/saCXF2nO3fdwF98iCEypq31mWiEIC5QIh/s2+yvvhjoPj7y6H
 4gdu/UzQk0+1HduXiP6k5ondrd33CTIbLoqm7InpbePUEf2VoZXw7XPKTbTUz0zei1y3
 vilIbRHmL2+Kj855797dqexw5gruGyI4usaKN04aXU6J63PgZUA0Ma093ZpKGVBSRszQ
 /c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:references:cc:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1JEukEMCcmHwVVmzZx32jRs8YD9yHp96jXQUebpSa2A=;
 b=RXB7pazfxSeX2NKawx7pYFzPpC79IURapYlNjmCKNkEoH2inaXuWGeiHj/Kj3uu8zB
 y59k1jCDTy33sg8rJyOvnsnb/ODAJJZU2AJZ42y2xuypi87p6xlwd74o60pSXY+yjA+G
 cUqFif38mSEPe4HSbkHcHRJBrGl+vP86/jbh5n13+0vW5dgp/a2LN1KZeEwTcBfV4PHu
 9/5SNr9eNfR7vaTL3siOV93+jOBFXvs+8QLcmEKva1DlX2J2WQ2SHt9yKCfDc0D4yVhF
 +Yk022YK9XRdJy5ygoBD/LryLTGKA0mlMkjcl0r4IgAUfdLJzZjag0uWv1zMbh8yTipc
 /nTA==
X-Gm-Message-State: AOAM5302RnZzdOBitS6N26kjcw6UxTyCNIsVVdKQTJ3HaBTjCgL8VB2K
 CZo0XiQYHPqO9z4I+9ws6OE=
X-Google-Smtp-Source: ABdhPJy2y0mhcV3wA5TaQMS/fhDBHpi8UV40QX5s7qVf9sTr/2fm7ClsSxQF9F881fP/EHU3F4WtQQ==
X-Received: by 2002:a05:622a:28d:: with SMTP id
 z13mr2739657qtw.87.1614348289137; 
 Fri, 26 Feb 2021 06:04:49 -0800 (PST)
Received: from [192.168.2.122] (pool-108-18-37-54.washdc.fios.verizon.net.
 [108.18.37.54])
 by smtp.gmail.com with ESMTPSA id e190sm318469qkf.101.2021.02.26.06.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Feb 2021 06:04:48 -0800 (PST)
From: Cory Bolar <cory.bolar@gmail.com>
Subject: Re: [bug] tab crash on media playback
To: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>
References: <e281729c-d632-1cc2-a1c7-79b4d1cbdc66@gmail.com>
 <f4b795f8-9f79-a946-49dc-0aea27766bf6@amd.com>
Message-ID: <b091a944-a002-9f6b-c347-1314a0f64385@gmail.com>
Date: Fri, 26 Feb 2021 09:04:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <f4b795f8-9f79-a946-49dc-0aea27766bf6@amd.com>
Content-Language: en-US
X-Mailman-Approved-At: Fri, 26 Feb 2021 14:24:36 +0000
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
Cc: Cory Bolar <cory.bolar@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMi8yNi8yMSA0OjU5IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IENhbiBJIHNlbmQg
eW91IGEgZGVidWdnaW5nIHBhdGNoIHdoaWNoIHByaW50cyBhIGZldyBsaW5lcyBpbnRvIGRtZXNn
IAo+IHdoZW4gcHJvYmxlbXMgaGFwcGVuPwoKSSB3b3VsZCBiZSBoYXBweSB0byBhcHBseSBhbmQg
dGVzdCBhIGRlYnVnIHBhdGNoLgoKVGhhbmtzLAoKQ29yeQoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
