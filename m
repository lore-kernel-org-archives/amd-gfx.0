Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A666C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 21:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08612611AD
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 21:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08612611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAAD6E1E0;
	Tue, 13 Apr 2021 21:19:25 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50CF6E1E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 21:19:23 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id r20so20984598ljk.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=enhHLE/5y2NdlKSskcLj+WinLbXmD8cGKb9xuV9HkB4=;
 b=qm6O8dQlxP59p9QcAZiByLt63o4HMtrvUwK4K7w+mg/kjx1MDaUSkRFQxesDbVuqMv
 1FamQg6A5/GAWF9nGEc3wYe+WOHEzmNmiV4cjGyfUB7IwDEUGfXxm8amD+4JiQKcpAQ8
 +ZTnAwV2HMKiYn668R6ks1ipSrCz1f/q5DpYwzrXqJcxOgLxQzZ9KupwfpGqow0ubBMj
 oltz1HVOgSo0QiIlYRR5fEafkO5Tn5JCFCVIJwefl5LuPJ7Poc9QQmftvwstzPs3tnpV
 N5Szl4MgcCe8oLevRieOedY0ITVCRdeLg362XbXiA4MJWLHxcu8OhADgW8ndw7qQYDjg
 guOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=enhHLE/5y2NdlKSskcLj+WinLbXmD8cGKb9xuV9HkB4=;
 b=JQODaLdPUmfiP7v4Z4buH97iCfftAWVuJW/8ZbdaF5XXsmwGNf3xYFaIFPMysV2Q3q
 ngFAT8UEORtycZWjQgpAkGbmBjEjsCNtOCI5sK64qbQCpSfDdYYhjb+gXhmikF/9J2JU
 4wLGpUpIxndAGns864ie5HHY1Mt62RHdDRFelDofdQemUb87b0bRqsPO87KtLPgOrVu1
 RzSq9faCZuJy5qBcdSExZvZ5Xbx6BGofBBwZ6MWEFqfsm0k0Cgq4SBKiPg/U4DaUvBXY
 qEVO1mlTyiQfqx8XlJXszAXQpGVW6b55LwTaKXRznXsS3JvUPLYlQYNcbd6SWCNAYnEb
 AmRg==
X-Gm-Message-State: AOAM533iFe6bYsQmRFgnOfwyS/+K+cZ7H9fGA3ao3Wg9oeE2Xemx3kNn
 pIxuArt6TqSxGKDLApQczkLY7OWVHuHx7hvYQ0M=
X-Google-Smtp-Source: ABdhPJwI9aKukGojq9kC2CBk6o4jWbmOxwHYprh8RiEyyePFzry2DSR3tbtouB3Vg1GcGTVEnF34BMeI7SJYF6LkkPk=
X-Received: by 2002:a05:651c:312:: with SMTP id
 a18mr11403270ljp.52.1618348761852; 
 Tue, 13 Apr 2021 14:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
In-Reply-To: <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 14 Apr 2021 02:19:10 +0500
Message-ID: <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCAxMyBBcHIgMjAyMSBhdCAxMjoyOSwgQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEhpIE1pa2hhaWwsCj4KPiB0aGUgY3Jhc2ggaXMg
YSBrbm93biBpc3N1ZSBhbmQgc2hvdWxkIGJlIGZpeGVkIGJ5Ogo+Cj4gY29tbWl0IGY2M2RhOWFl
NzU4NDI4MDU4MmNiYzgzNGIyMGNjMThiZmIyMDNiMTQKPiBBdXRob3I6IFBoaWxpcCBZYW5nIDxQ
aGlsaXAuWWFuZ0BhbWQuY29tPgo+IERhdGU6ICAgVGh1IEFwciAxIDAwOjIyOjIzIDIwMjEgLTA0
MDAKPgo+ICAgICAgZHJtL2FtZGdwdTogcmVzZXJ2ZSBmZW5jZSBzbG90IHRvIHVwZGF0ZSBwYWdl
IHRhYmxlCj4KClVuZm9ydHVuYXRlbHksIHRoaXMgY29tbWl0IGNvdWxkbid0IGZpeCB0aGUgaW5p
dGlhbCBwcm9ibGVtLgoxLiBSZXN1bHQgdmlkZW8gaXMgamVya3kgaWYgaXQgZ3JhYmJlZCBhbmQg
ZW5jb2RlZCB3aXRoIGZmbXBlZwooaDI2NF92YWFwaSBjb2RlYykuCjIuIE9CUyBzdGlsbCBjcmFz
aGVkIGlmIEkgdHJ5IHRvIHJlY29yZCBvciBzdHJlYW0gdmlkZW8uCjMuIEluIHRoZSBrZXJuZWwg
bG9nIHN0aWxsIGFwcGVhcnMgdGhlIG1lc3NhZ2UgImFtZGdwdTogW21taHViXSBwYWdlCmZhdWx0
IChzcmNfaWQ6MCByaW5nOjAgdm1pZDo0IHBhc2lkOjMyNzcwLCBmb3IgcHJvY2VzcyBvYnMiIGlm
IEkgdHJpZWQKdG8gcmVjb3JkIG9yIHN0cmVhbSB2aWRlbyBieSBPQlMuCgotLSAKQmVzdCBSZWdh
cmRzLApNaWtlIEdhdnJpbG92LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
