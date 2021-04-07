Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DECC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 18:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84CE6124C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 18:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84CE6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7502E891A1;
	Wed,  7 Apr 2021 18:06:30 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2072B891A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 18:06:29 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id h19so4271541lfu.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Apr 2021 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DyBm95F+3/SfdAPdI+iZIYttoNbi6kTKipkfV2vV3q8=;
 b=U02AtdVu7GmuXw614lHDvn33aAMYx6obajAVA6gYKQDX/9ERHsQhYsNVJpx5f8behT
 ZdpkYFxstdbGj+B0lLjtWpDpTPPMJB9o47gxSPScDWB1OdrO7VFImIs2SYNU9yJR6TbZ
 /+wpMxhc6Ge/qXGdcfCxTov7kQH7XVd7Vk3+GRxwz9H1pVPpqDX1jsLkBnerUVmzBE7D
 Fwy6clYk+4BWRDm8UaCLckTU5QmaOgqEXb27jYU2PM/ddHy8CzQKETz2f0xvGPlwyilr
 gXk2cGGfKDWCbyNqeXJS2pWSQvXTCF1TDHGwibnnct2hl8D13iCHOteQRrKzmGjcH1Z5
 y7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DyBm95F+3/SfdAPdI+iZIYttoNbi6kTKipkfV2vV3q8=;
 b=nAh8gFgct+0C6KM7FCkbx4Vr1U88AZu5TBGS+Gbf2BLPViRnKfK+61rJ5HsGqNH+Lo
 576wg8hUs2GYsJgzA9CF5JiJ3lZBVF7PzGll4zknPauV7yH15ACSn5KK+a8hgu6NRJLD
 YQiCVc6qG6jIjNeRdKLhTOf78W0tWx4dmk6xvF6rB1umF0tWQEK5Zi/s73bZ/fXmt/gS
 GCcwELwaTgfXqXRG3EY2nswMVBhVkglNGigYGZvKkYBdDADy/ZkWDhb00k9lCJy4tN6K
 9/tuVh1CMH5CsF9DS6/1kgsrJcU2Jfrax7LMdVl428HMoANBllgAflCAToRXIGIkrZWN
 4gnw==
X-Gm-Message-State: AOAM5333zQqOR8CA6UIIAMBKnH1FCoMxOvqgTpKQlk4XXBdT+c0YZp/I
 fkKN+4sjJ3wak/EGXqOMfk3iwkJ7TEtGlUSkj9xIHJ3psp4G9w==
X-Google-Smtp-Source: ABdhPJxbedDQfFngxb5MnIjHVo8kZt/AflxaLuJHiAlFzP3+GOaDxAjS7moJ8B+rFfcC9oBtZQLM3OCXEL+SJnrGyQ8=
X-Received: by 2002:ac2:42cf:: with SMTP id n15mr3262180lfl.573.1617818787412; 
 Wed, 07 Apr 2021 11:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPAdv6wCWmzh6OQmDX1LOf_FEu_wH=4K9HDd_rToTdwrQ@mail.gmail.com>
 <7d30982e-a893-858c-2237-a09a183ff2d0@gmail.com>
In-Reply-To: <7d30982e-a893-858c-2237-a09a183ff2d0@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 7 Apr 2021 23:06:15 +0500
Message-ID: <CABXGCsN6GX4ksbFo9fhd6XGxNyED9qoBqYf0Ph1pwG3qArGtjg@mail.gmail.com>
Subject: Re: Unexpected multihop in swaput - likely driver bug.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Dave Airlie <airlied@gmail.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCA3IEFwciAyMDIxIGF0IDE1OjQ2LCBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmlnLmxl
aWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBXaGF0IGhhcmR3YXJlIGFyZSB5b3Ug
dXNpbmcKCiQgaW54aSAtYk0KU3lzdGVtOiAgICBIb3N0OiBmZWRvcmEgS2VybmVsOiA1LjEyLjAt
MC5yYzYuMTg0LmZjMzUueDg2XzY0K2RlYnVnCng4Nl82NCBiaXRzOiA2NCBEZXNrdG9wOiBHTk9N
RSA0MC4wCiAgICAgICAgICAgRGlzdHJvOiBGZWRvcmEgcmVsZWFzZSAzNSAoUmF3aGlkZSkKTWFj
aGluZTogICBUeXBlOiBEZXNrdG9wIE1vYm86IEFTVVNUZUsgbW9kZWw6IFJPRyBTVFJJWCBYNTcw
LUkgR0FNSU5HCnY6IFJldiBYLjB4IHNlcmlhbDogPHN1cGVydXNlciByZXF1aXJlZD4KICAgICAg
ICAgICBVRUZJOiBBbWVyaWNhbiBNZWdhdHJlbmRzIHY6IDM2MDMgZGF0ZTogMDMvMjAvMjAyMQpC
YXR0ZXJ5OiAgIElELTE6IGhpZHBwX2JhdHRlcnlfMCBjaGFyZ2U6IE4vQSBjb25kaXRpb246IE4v
QQpDUFU6ICAgICAgIEluZm86IDE2LUNvcmUgKDItRGllKSBBTUQgUnl6ZW4gOSAzOTUwWCBbTVQg
TUNQIE1DTV0gc3BlZWQ6CjIzNjUgTUh6IG1pbi9tYXg6IDIyMDAvMzUwMCBNSHoKR3JhcGhpY3M6
ICBEZXZpY2UtMTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcyBbQU1EL0FUSV0gTmF2aSAyMSBbUmFk
ZW9uClJYIDY4MDAvNjgwMCBYVCAvIDY5MDAgWFRdIGRyaXZlcjogYW1kZ3B1IHY6IGtlcm5lbAog
ICAgICAgICAgIERldmljZS0yOiBBVmVyTWVkaWEgTGl2ZSBTdHJlYW1lciBDQU0gNTEzIHR5cGU6
IFVTQiBkcml2ZXI6CmhpZC1nZW5lcmljLHVzYmhpZCx1dmN2aWRlbwogICAgICAgICAgIERldmlj
ZS0zOiBBVmVyTWVkaWEgTGl2ZSBHYW1lciBVbHRyYS1WaWRlbyB0eXBlOiBVU0IKZHJpdmVyOiBo
aWQtZ2VuZXJpYyxzbmQtdXNiLWF1ZGlvLHVzYmhpZCx1dmN2aWRlbwogICAgICAgICAgIERpc3Bs
YXk6IHdheWxhbmQgc2VydmVyOiBYLk9yZyAxLjIxLjEgZHJpdmVyOiBsb2FkZWQ6CmFtZGdwdSxh
dGkgdW5sb2FkZWQ6IGZiZGV2LG1vZGVzZXR0aW5nLHJhZGVvbix2ZXNhCiAgICAgICAgICAgcmVz
b2x1dGlvbjogMzg0MHgyMTYwfjYwSHoKICAgICAgICAgICBPcGVuR0w6IHJlbmRlcmVyOiBBTUQg
U0lFTk5BX0NJQ0hMSUQgKERSTSAzLjQwLjAKNS4xMi4wLTAucmM2LjE4NC5mYzM1Lng4Nl82NCtk
ZWJ1ZyBMTFZNIDEyLjAuMCkKICAgICAgICAgICB2OiA0LjYgTWVzYSAyMS4xLjAtZGV2ZWwKTmV0
d29yazogICBEZXZpY2UtMTogSW50ZWwgV2ktRmkgNiBBWDIwMCBkcml2ZXI6IGl3bHdpZmkKICAg
ICAgICAgICBEZXZpY2UtMjogSW50ZWwgSTIxMSBHaWdhYml0IE5ldHdvcmsgZHJpdmVyOiBpZ2IK
RHJpdmVzOiAgICBMb2NhbCBTdG9yYWdlOiB0b3RhbDogMTEuMzUgVGlCIHVzZWQ6IDEwLjgyIFRp
QiAoOTUuMyUpCkluZm86ICAgICAgUHJvY2Vzc2VzOiA4MDUgVXB0aW1lOiAxMmggNTZtIE1lbW9y
eTogMzEuMTggR2lCIHVzZWQ6CjIxLjg4IEdpQiAoNzAuMiUpIFNoZWxsOiBCYXNoIGlueGk6IDMu
My4wMgoKCj4gYW5kIGhvdyBkbyB5b3UgZXhhY3RseSB0cmlnZ2VyIHRoaXM/CgpJIGFtIHJ1bm5p
bmcgaGVhdnkgZ2FtZXMgbGlrZSAiWm9tYmllIEFybXkgNDogRGVhZCBXYXIiIGFuZCBzd2l0Y2hp
bmcKdG8gR25vbWUgQWN0aXZpdGllcyBhbmQgb3RoZXIgYXBwbGljYXRpb25zIHdoaWxlIHRoZSBn
YW1lIGlzIHJ1bm5pbmcuCgoKLS0gCkJlc3QgUmVnYXJkcywKTWlrZSBHYXZyaWxvdi4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
