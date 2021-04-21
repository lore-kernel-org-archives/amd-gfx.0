Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3923C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 13:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12DE61439
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 13:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12DE61439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5257B6E9A4;
	Wed, 21 Apr 2021 13:59:05 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB366E9A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 13:59:03 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id l22so40475160ljc.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ib9EyqO0WAjoDZ6fdgzjZQ0H5z4tmjUfn5ViYgk5R6k=;
 b=fwhdPFJJ9tHWWJ38lpptmzBw7yy93iXiaOiuwx6es5qpjWPtijqkL4W5RcXHh4zEHk
 LttWzHBPpWKUjV92JxNCjvfathqf/stEnmcf9P2+Ot8Fz4nFILNHZpA2FRZSDN5hiDPn
 8dV8KEsr6J7e9L1JxNfPVLXEQCj2n9HnE5OzJ1VRKM3TXXDqVWqz0IO/bH2EHrQaVCRC
 dH+6qKg+wzS/59/9ho36IDSKOAJP2sgVJWMd7jUMTbvsMRymJEgWizkgi7i8ODjM6gx4
 4KhXNe/7ikzKG0EopujBaOApZkoKvr8U11c9TMGm0sou9CD5tlUbNrzibGJ+eFmHssgX
 Iriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ib9EyqO0WAjoDZ6fdgzjZQ0H5z4tmjUfn5ViYgk5R6k=;
 b=bYrTKxShUIElkYKSdTLkRct1XcbcLeWw3TmQSOPcgS2Dkmg3orI+FeLGrRV1Ew4y1Z
 0wgoHbe+xJUhYq5nYBeGDZAuLsYAh41fRd08h7rS9oRdEY/vLr2tQNoOr2ud1aoGyk6u
 +1Q5s7Qx2sw2bg2SODZNzAVVTwU4Cha1k97GYaCG5yYh6pGkIdlYYfvSpxSGO86WPb8b
 9ye+rR0fVhrXACV3uk1YDDMb0chR59tGVagIxpELkWs0NzgQqsaYicvDQJ4XVAZJ9EUL
 X2k3+uQKjeyKU4oYwO48g5i0FuCClKInzZ6355QIA6Z8i6qatWJnah6wPIpi1qav7yck
 Be4A==
X-Gm-Message-State: AOAM53025MUEQPD1aLwqMdvsLBEpVTAwsVG4Xch5OvWIk1XWjCpZ6oLu
 dZ4zo5SQKPeFyROh/IpgEdhhCIUmgwxf0ApECK4=
X-Google-Smtp-Source: ABdhPJzqg97MeQOjeuKmpKgeqPk5jSB2yj880kx1uDw1GzS9+dGZBRsnQW7kOxD5TZniJBkJ417W22ixCHEMaXNX8QM=
X-Received: by 2002:a2e:8987:: with SMTP id c7mr8239550lji.420.1619013541838; 
 Wed, 21 Apr 2021 06:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
 <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
 <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
 <CABXGCsP+qjMuPpi7o=mnuvcuRyViYxiT8qEsqS2kHwMSEs835A@mail.gmail.com>
 <fff4926a-8f20-8d31-611b-473e84d89af0@amd.com>
In-Reply-To: <fff4926a-8f20-8d31-611b-473e84d89af0@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 21 Apr 2021 18:58:50 +0500
Message-ID: <CABXGCsN_ZsQpeFOpkdJyn_JtG1imp4+Yrfr2msqQGUwNDoLpmg@mail.gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCAyMSBBcHIgMjAyMSBhdCAxMTo0MiwgQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPiBJIGNhbiB0cnksIGJ1dCBJJ20gbm90IHN1cmUgaWYg
d2UgZXZlbiBoYXZlIHRoZSBmdWxsIHBhZ2UgZmF1bHQgaGFuZGxpbmcKPiBmb3IgTmF2aSBpbiA1
LjEyLgo+CgpJdCB3b3VsZCBiZSBncmVhdC4gRm9yIG1lIHRoaXMgcGF0Y2ggaXMgd29ya2luZyBh
cyBleHBlY3RlZCBhbmQgSQphbHJlYWR5IGZvciBzZXZlcmFsIGRheXMgZGlkbid0IHNlZSB0aGUg
cGFuaWMgImtlcm5lbCBCVUcgYXQKZHJpdmVycy9kbWEtYnVmL2RtYS1yZXN2LmM6Mjg3ISIuCkFu
eXdheSBJIHdpbGwgd2FpdGluZyBmb3IgYW55IG5ld3MuCgotLSAKQmVzdCBSZWdhcmRzLApNaWtl
IEdhdnJpbG92LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
