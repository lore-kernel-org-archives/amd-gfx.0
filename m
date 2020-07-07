Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D5EC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 15:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FC420674
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 15:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUiD82BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FC420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4460B6E037;
	Tue,  7 Jul 2020 15:07:57 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A0B89F3B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 15:07:56 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id l2so45408952wmf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2020 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fEo9AR/UX/vublPFxG1gjhseYQB5PCDTeKzhfj3Dwog=;
 b=IUiD82BRaF56CyHGmLJUQeuhxGww0aamyhe5auF872Tj0edTulqJyVSkrOyMr/M6hG
 aeCq7ossuSTk96qDzXhLIKGII/yHd7im9j16evltNdr6os7AeO3elsYPhCtpy2FTHSGF
 SvQuOQlVadeagAOZ9AFlNjLyM1KJTZTgcgNZ6bpOwCP0ugCh7lhf1tJs7LWVQxuJup3n
 js77+QldI8GEl/mPFthyQLGbm+Fu8bC749iItQ9L9aniByUkJA+0TelcA/am1b6IPGY0
 TaVhf/qzOwt1EjQgHmu/1Co6277FkK7H6vdWu6CaUxC/DCQYVlHic2lSdacvzxUFvoJM
 +PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=fEo9AR/UX/vublPFxG1gjhseYQB5PCDTeKzhfj3Dwog=;
 b=c7mrhaT0uL4ubmFpYU8h4rirBvijOC6lH8mEYnEB+CA/Io79BMthQ8lETednc9TN+p
 drIrfMCZHIWCs+CvdJyTKezEW5dSAUxmVImJGpKaFa/NFrpqtF3quntuGDbztDy4WOWm
 L3c6Nex6+GhZXyNKvyDyPTCVMQ342XmU9omUw2rfOLbm5oGGQXrMYfRp3C6o0+TuwpYR
 jLxG063tMoKiX80K9nzL1m2a9+VpSoxW0rv7mGUIa4j79iedFrrVNCMEK1tiU1MKVddY
 9rBb/T9XwlxzD/R4pdtlxwsRHaG6UTEKlThWi0HlBJ8mdiU+poK6DoixaumfsGovtS5+
 8kGw==
X-Gm-Message-State: AOAM531sbMvs/KUmbW+j5feZYerv+FdMH624H6UZqaU3YYKdyS+Odd9V
 iXutQqaVcHHFFAigSxkxlBk7ZPiP
X-Google-Smtp-Source: ABdhPJzu43u4GrMFGEk0Qk5E85E3tKvpzJdhRNTE7Ofd+3iHvBuJ4YQ/Agwuy8/sW9LPsqI8NGRsGw==
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr4461397wme.23.1594134474593;
 Tue, 07 Jul 2020 08:07:54 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id n16sm1121850wra.19.2020.07.07.08.07.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jul 2020 08:07:53 -0700 (PDT)
Subject: Re: [PATCH] tests/amdgpu: set emit fence flag for multi fence
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 christian.koenig@amd.com, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Gao, Likun" <Likun.Gao@amd.com>
References: <20200707131504.2994506-1-likun.gao@amd.com>
 <MN2PR12MB4078A186CF4FB3333A6837F9FC660@MN2PR12MB4078.namprd12.prod.outlook.com>
 <4d37be35-273b-898b-e5f2-9e5c77947f45@gmail.com>
 <18752702-af01-20b9-1570-d35af4c13acc@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0bbfcace-c56c-63fc-fc72-cd1730ddfa28@gmail.com>
Date: Tue, 7 Jul 2020 17:07:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <18752702-af01-20b9-1570-d35af4c13acc@daenzer.net>
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
Reply-To: christian.koenig@amd.com
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDcuMDcuMjAgdW0gMTY6MjQgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPiBPbiAyMDIwLTA3
LTA3IDM6NDAgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gVGhlcmUgaXMgYSBkb2N1
bWVudCBhYm91dCBob3cgdGhlIGxpYmRybSBjb3B5IG9mIHRoZSBoZWFkZXIgaXMgdG8gYmUKPj4g
dXBkYXRlZC4KPj4KPj4gQ2FuJ3QgZmluZCBpdCBvZiBoYW5kLCBidXQgb3VyIHVzZXJzcGFjZSBn
dXlzIHNob3VsZCBiZSBhYmxlIHRvIHBvaW50Cj4+IG91dCB3aGVyZSBpdCBpcy4KPiBodHRwczov
L2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvbWVzYS9kcm0vLS9ibG9iL21hc3Rlci9pbmNsdWRlL2Ry
bS9SRUFETUUKCkRhbmtlIQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
