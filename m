Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E3CC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 20:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DB2206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 20:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ABndUtX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DB2206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA5786E88D;
	Fri, 24 Jul 2020 20:31:39 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8FA6E890
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 20:29:46 +0000 (UTC)
Received: by mail-lf1-x141.google.com with SMTP id v15so1320478lfg.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rN5RMUW/56gaFNCn9cuYichcDB+Mu1aPFaim03Y9pNc=;
 b=ABndUtX222DsXCRyLiuR08D4nTyyZmgGC2ovL55ed45uZT14odfvFGQhNKX3Vm9PWv
 md1/mNmLLeG75u2/dzJ6n9XdWSGLSp+BtCTnU5dWEKfY+RGK4X4nhF7Ta1cIgMcklTrh
 ZIPc5vt8aGQ89cJrTZe3k4/Jna1PAuDK2WEfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rN5RMUW/56gaFNCn9cuYichcDB+Mu1aPFaim03Y9pNc=;
 b=DdcwKutppESmDL5Gzi9dxbY/n2MgCHL7uFuXQa4QKZoLYATCBlNRz+/xyZF4lmuOWV
 EJnoz6thTADjhLvnAmr0zu+Zw1XbWFpEpmZe36z/5CzVoreRuDFes8WUz9oWSr2Og+Iq
 /eXgvrjStgVlM8xmYvY0oECfT1r3TIMRAxn/0ndyhukfGqydE0PEMD2kXHUjZOlGN1wy
 ydKLNdSJg2nx0t0HCDQAjsY9qCoYIsiPbmRXRrWctYxiw1NFYW9fCCOMBhZ0GEllOcqQ
 6DCEE16ixpCWzdHA2C1ObpiBOBgPHXyByvpJ3mTzia1qrXhHaRttrsQfDloOCuTbLuww
 EhSA==
X-Gm-Message-State: AOAM531MqmVqTCnYers1tyDEsVmaXA6pORWzJe1DT80J1LQ8l6GZRTsY
 PAVGn8FIuQTZA2pMvcvy3oIWv6fwgH0=
X-Google-Smtp-Source: ABdhPJyByFtTgC3GOZVPoeRgO8U7nyLV+EHytVwoa3cQEVepj09ZppGUIu/kOSfYEof2sywI7Hen4w==
X-Received: by 2002:a19:3f07:: with SMTP id m7mr5155652lfa.68.1595622583952;
 Fri, 24 Jul 2020 13:29:43 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com.
 [209.85.167.48])
 by smtp.gmail.com with ESMTPSA id w19sm471336ljh.106.2020.07.24.13.29.42
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 13:29:42 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id m15so5194130lfp.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 13:29:42 -0700 (PDT)
X-Received: by 2002:ac2:521a:: with SMTP id a26mr5747786lfl.192.1595622582122; 
 Fri, 24 Jul 2020 13:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
 <20200703142939.28663-3-pmenzel@molgen.mpg.de>
 <50e7239f-9fab-8484-7aec-085acc5ec658@amd.com>
 <7e5b2284-0549-185c-4afd-f7d193e2faf9@molgen.mpg.de>
 <54ad054c-2cf4-765e-4ecc-44e2b98422f0@amd.com>
In-Reply-To: <54ad054c-2cf4-765e-4ecc-44e2b98422f0@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Jul 2020 13:29:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxP-2tFBX9ctP242TsgJhtp7yhNrkG6Tj+Ng=FiT1FbQ@mail.gmail.com>
Message-ID: <CAHk-=whxP-2tFBX9ctP242TsgJhtp7yhNrkG6Tj+Ng=FiT1FbQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Change type of module param
 `ppfeaturemask` to hexint
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Approved-At: Fri, 24 Jul 2020 20:31:39 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKdWwgMjQsIDIwMjAgYXQgMTI6NTQgQU0gQ2hyaXN0aWFuIEvDtm5pZwo8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEJ1dCBzaW5jZSB5b3UgYWxyZWFkeSBhZGRy
ZXNzZWQgTGludXMgY29tbWVudHMgYW5kIGl0IGxvb2tzIHJhdGhlciBjbGVhbgo+IEkgdGhpbmsg
SSBjYW4ganVzdCBwdXNoIGl0IHRvIGRybS1taXNjLW5leHQgb24gTW9uZGF5IGlmIG5vYm9keSBv
YmplY3RzCj4gb3ZlciB0aGUgd2Vla2VuZC4KClllYWgsIG5vIG9iamVjdGlvbnMgZnJvbSBtZS4K
CkFkZCBhIG5vdGUgdG8gaXQgdG8gdGhlIHB1bGwgcmVxdWVzdCwgc28gdGhhdCB3aGVuIG15IGJp
cmQtYnJhaW4gc2Vlcwp0aGUgcHVsbCBkdXJpbmcgdGhlIG5leHQgbWVyZ2Ugd2luZG93IGFuZCBJ
J3ZlIGZvcmdvdHRlbiB0aGlzIHRocmVhZCwKSSBkb24ndCBnbyAid2h5IGlzIHRoZSBkcm0gdHJl
ZSBtb2RpZnlpbmcgY29kZSBmaWxlcyI/CgogICAgICAgICAgICAgTGludXMKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
