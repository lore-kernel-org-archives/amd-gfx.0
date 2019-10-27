Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F042DCA9EA0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 08:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0F920B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 08:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0F920B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6066E45F;
	Mon, 28 Oct 2019 08:24:08 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC7F89C60
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Oct 2019 23:15:39 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id l3so1484296qtp.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Oct 2019 16:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rxZpFzuz60sIrSruV5Nd/Y3j5ItN6VqaItCAQPTMcIc=;
 b=ANoVjBAVGWa4Gey4PhOsUIVuGlLsiBBuuwQ8YA/Koz+nkAI6pKrBCP1JFy+uajECka
 H/6SUHL9x7vR1rggkpLjttL9T9Y5pjKFD467Jw0eq2eftvF87Yzm6IEnpAMVxKDUFy67
 bGk1zCkvHZ+Z0bYXxn1hF1A7q1SNEemCA8LP+QB587UxbAprOG6IK5c48zF1veo0+iXX
 SO/dM1tC7XXRhRfBC2U45sKb/sa8SxkbphMgXfSDvMvYIMW9rZUragqyCaBY23Kejcv2
 03PLtbg/dpsjMr1PJw/O5t/pXMr3qlu0HltmZ/zyKQQCZ7JH3QwRcKeZi8d8Uwb8YqUn
 NpGw==
X-Gm-Message-State: APjAAAVv9wlisggaB6QTasERGad2n3kGsoQRMb4U7Ob4158JG9tmkwoo
 GV7CeLASO1isGwiJk8GbHm3p3A==
X-Google-Smtp-Source: APXvYqxizxptV9dIppboKod3HPUerUoysc89bhjuseF5zgElGRhZk0mma/yLKAT2W01dKY3PL374/A==
X-Received: by 2002:aed:2907:: with SMTP id s7mr14732360qtd.265.1572218138170; 
 Sun, 27 Oct 2019 16:15:38 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id v3sm4707476qkd.78.2019.10.27.16.15.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 27 Oct 2019 16:15:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iOrl3-0006cG-2G; Sun, 27 Oct 2019 20:15:37 -0300
Date: Sun, 27 Oct 2019 20:15:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Subject: Re: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Message-ID: <20191027231537.GA25385@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-3-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191015181242.8343-3-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Mon, 28 Oct 2019 08:24:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rxZpFzuz60sIrSruV5Nd/Y3j5ItN6VqaItCAQPTMcIc=;
 b=Od2El8QyLa/H5hwR1OSJAf3wwqCt4YPdA06x5ONzTzr++XnoLDSgadVgdMez7X3dFP
 tdEahE8G7Opi2klzQQCY8N72Slkgu2gENIzdmOMZynjcyDNqNdUT7VdI1UwR1jjxB1Xx
 T5kaGcbHpgJX34PsmT9FXhQWl0cOm6OSOjnO2INOyBhh4k+H2PeDHKMzkEYr8e02iPey
 YGz9am7DB6flMKYfKUgbHUU3M+/EUsoohM3Agmo6YKNGHuF/JZtJCiGBrfONYvVWqEcM
 pP2icbaJd4446Zx+NzXtTTI04dmt7C92y1fYm+nKJmHTp9u3+ZW7AZUJngGk1C7eXHWd
 hdAA==
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-rdma@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191027231537.H79Td_QBsSFwziTYaSLxHW1mdodVMomxXSbDaa6xakQ@z>

T24gVHVlLCBPY3QgMTUsIDIwMTkgYXQgMDM6MTI6MjlQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgoKPiArc3RhdGljIHZvaWQgbW5faXRyZWVfcmVsZWFzZShzdHJ1Y3QgbW11X25vdGlm
aWVyX21tICptbW5fbW0sCj4gKwkJCSAgICAgc3RydWN0IG1tX3N0cnVjdCAqbW0pCj4gK3sKPiAr
CXN0cnVjdCBtbXVfbm90aWZpZXJfcmFuZ2UgcmFuZ2UgPSB7Cj4gKwkJLmZsYWdzID0gTU1VX05P
VElGSUVSX1JBTkdFX0JMT0NLQUJMRSwKPiArCQkuZXZlbnQgPSBNTVVfTk9USUZZX1JFTEVBU0Us
Cj4gKwkJLm1tID0gbW0sCj4gKwkJLnN0YXJ0ID0gMCwKPiArCQkuZW5kID0gVUxPTkdfTUFYLAo+
ICsJfTsKPiArCXN0cnVjdCBtbXVfcmFuZ2Vfbm90aWZpZXIgKm1ybjsKPiArCXVuc2lnbmVkIGxv
bmcgY3VyX3NlcTsKPiArCWJvb2wgcmV0Owo+ICsKPiArCWZvciAobXJuID0gbW5faXRyZWVfaW52
X3N0YXJ0X3JhbmdlKG1tbl9tbSwgJnJhbmdlLCAmY3VyX3NlcSk7IG1ybjsKPiArCSAgICAgbXJu
ID0gbW5faXRyZWVfaW52X25leHQobXJuLCAmcmFuZ2UpKSB7Cj4gKwkJcmV0ID0gbXJuLT5vcHMt
PmludmFsaWRhdGUobXJuLCAmcmFuZ2UpOwo+ICsJCVdBUk5fT04ocmV0KTsKClRoaXMgc2hvdWxk
IGJlIAogIFdBUk5fT04oIXJldCkKCkphc29uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
