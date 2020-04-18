Return-Path: <SRS0=W5zw=6C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D05C38A2B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 11:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C10F21D7E
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 11:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxShl3oz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C10F21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F15236E454;
	Sat, 18 Apr 2020 11:13:14 +0000 (UTC)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3ABA6E423;
 Sat, 18 Apr 2020 11:13:13 +0000 (UTC)
Received: by mail-io1-xd42.google.com with SMTP id u11so5371231iow.4;
 Sat, 18 Apr 2020 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AKMSMR1+WcKScxmI8ZwhCHzKARdDK8BPgfIVeOPP3NQ=;
 b=NxShl3oz6Q30kTK3NvrVwK2Aeje3puDPaUPaSuFIf+Tul0fzP52Uj2eNBDCNhmJ1Bf
 P4t9J8zInqnHnw9rRB8zBIRWk0Ehte+z33Iu3W1o6PLQD4ErCsfrY0upRyXgdRityTuW
 nUP/WIIDLdSfQdZsSqKpu183FPXq7LATHzX5XGzZWHtRednZ9l8XKeXHWyXPcDbndZ9Y
 xbQnfydroKws/JpGJdyt9f/7Jw4iPai1p7MWrXH2LpimAMYPdT5Ul2xUtW1MTKMVvF1W
 UiQFx5voHiArwoqz7yVkD/Gq6VSZxbz0mT6588bzvH+ev2ealVPGere0mh+zVSQgoebZ
 YgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AKMSMR1+WcKScxmI8ZwhCHzKARdDK8BPgfIVeOPP3NQ=;
 b=Qjw+fiBVhZUSPFZYZ6gsRmy06Usod1JbXKZiDupI73LFGpefUckBZpBuoDGQxsKDo0
 EMLvdou03pndMZvXUwTv8eGoLOrNA9YIiYqzO2iKQVPKROG8L4vEHdqspysgr6691WSV
 LMDWj0T5R2YFDDaCugXrXnLOV3Eq7On8B+Q1ZE+tuaadrcCSxNBAmtOo5HFERgg7u3oi
 nODMaUsZO/nmkYpV7nEpWZ6gTzaK7tYrlt9VQiaBy1WBB9pCTnsq7NpWVR2Ng3beRAcB
 KgbuTNqAWAXj8UpJOk3936nL1u1gMHZx2ERHmQ6OromqujEHVyvvzwTHrEIyx86gO4L6
 Z1Qg==
X-Gm-Message-State: AGi0Puai+tFD3oCvxGDyfA0XgH2QkToxQt3IUZ515Iptu0y8l2C65i+M
 zmsimBoL/ME3j4KsHnxfZ3SAUta0Rmq3vZxrsl7SUKuCwbZlJg==
X-Google-Smtp-Source: APiQypI6ME07ywIOTKFOnfStd4PcGNqAgLq4WzfXLmCV8qaP5LE3hKSXM4O9rfAAiWR/WBkZhkh/dVK66rSScDxP47Q=
X-Received: by 2002:a02:a68e:: with SMTP id j14mr7422107jam.86.1587208392947; 
 Sat, 18 Apr 2020 04:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN=SNp7Ub3KHmsGrg+5R1g13HMea2+Jw+hTer3g74q21Q@mail.gmail.com>
 <4a9ae285-f126-c83b-b55f-36bd7a4403a0@gmail.com>
In-Reply-To: <4a9ae285-f126-c83b-b55f-36bd7a4403a0@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 18 Apr 2020 16:13:02 +0500
Message-ID: <CABXGCsNSni7cjufva_n-VZQ4HKY2osBL4JB2kk_z7Pzv2u10MQ@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 0000000000000026
 after switching to 5.7 kernel
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU2F0LCAxMSBBcHIgMjAyMCBhdCAxNDo1NiwgQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gWWVhaCwgdGhhdCBpcyBhIGtub3du
IGlzc3VlLgo+Cj4gWW91IGNvdWxkIHRyeSB0aGUgYXR0YWNoZWQgcGF0Y2gsIGJ1dCBwbGVhc2Ug
YmUgYXdhcmUgdGhhdCBpdCBpcyBub3QKPiBldmVuIGNvbXBpbGUgdGVzdGVkIGJlY2F1c2Ugb2Yg
dGhlIEVhc3RlciBob2xpZGF5cyBoZXJlLgo+CgpMb29rcyBnb29kIHRvIG1lLCBzbyBpdCdzIHBp
dHkgdGhhdCB0aGlzIHBhdGNoIGRpZCBub3QgZXhpc3QgaW4gdGhlCnB1bGwgcmVxdWVzdCBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExNDkyMDgzLwoKLS0KQmVzdCBSZWdhcmRz
LApNaWtlIEdhdnJpbG92LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
