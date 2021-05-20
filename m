Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F73C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8F0611AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8F0611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC7D6F510;
	Thu, 20 May 2021 19:25:45 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CAD06F510;
 Thu, 20 May 2021 19:25:44 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id u11so17448505oiv.1;
 Thu, 20 May 2021 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jP7V9on14Wbn9cVMjkYpwwbeii1k8feXDpcOLaFr/ZA=;
 b=qcjvQOaL6FVCN/qtvhskOg/KM52KS0jZicEMg+rFrj0xPFxkUMDJVwoj5hq4EP5rAY
 dwx7/Bye5cm40OO0t3CjjT6Ui8XjuolUyPYtrL25XM1RdoSIiDQ32rsQfoPUn10G8+fR
 cuL7rmfMeb8Lb6qeMd/5A9MQpUfzCUZN6Kmp45SnlrXi+qTrpLPeX5lzMMJsQIsapP4k
 w2xW+vB/SAUul57FbZ4+Nnk5JGdn8BckMe91jfo1aNwIoHqIldJMG+DXa05EznVv6RH4
 Q6wSlVI74UuV4Q0+rT0l94VsScXDRL7xh0RtOm3N/bNbYYg1uYMWbWCo5McxmK3Px/af
 Phpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jP7V9on14Wbn9cVMjkYpwwbeii1k8feXDpcOLaFr/ZA=;
 b=GCWX/TiZ1refhppDXOrMGsnbNc+V5cBBdomzJahjTxxd3x5EX3msY8IfRl6KueV5Qz
 BRqXPs9ionLbh/IZuGqBda2dNcpaPUkDKvshly+D3v1WqkqonXDEjQc/kbAU6URG2R+/
 IuBVFPovSv1VWS8wbU2CnidMIdYFXd5dinSvSL9ZU6MrIoNibhPWU6oBITed1RYPgPKw
 PJmh0uPCD9lDvFiQuiILXB4knhY+IA1NpiAW+9Sk3J+sbJSH9mWDU7Tmubd1kQMWZ2TO
 YyH+medZXFULszGZol2wc+iA/fcp/ud+2y4tIC16u5qYmcbsCV3N0Ql8Rm2dC/KfcAbd
 SLTg==
X-Gm-Message-State: AOAM5311hDTwqHImC+2B1nFdDwpQlFzKgvmrZjuFaohsvMGU4cOkr7tW
 4FuJYEWToK7yFQcGMxTDyhXty5NvC8/CrHBSff8=
X-Google-Smtp-Source: ABdhPJw/IRLYslkqMnEsahf4i98spgdQTKKRx48jW+eoP6/J47a/swlS5KwPFjt0AO1JUByC+7OoBBEUxd/D4/T5iBw=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr2496065oiw.123.1621538743810; 
 Thu, 20 May 2021 12:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-37-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-37-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:25:32 -0400
Message-ID: <CADnq5_OpCwYAJOX1wDSpkYFg8wt9VroU0PmPstcgSe=h7cw60A@mail.gmail.com>
Subject: Re: [PATCH 36/38] drm/amd/amdgpu/vcn_v1_0: Fix some function naming
 disparity
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y25fdjFfMC5jOjc3NTogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgdmNu
X3YxXzBfc3RhcnQoKS4gUHJvdG90eXBlIHdhcyBmb3IgdmNuX3YxXzBfc3RhcnRfc3BnX21vZGUo
KSBpbnN0ZWFkCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmM6MTExMTog
d2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgdmNuX3YxXzBfc3RvcCgpLiBQcm90b3R5
cGUgd2FzIGZvciB2Y25fdjFfMF9zdG9wX3NwZ19tb2RlKCkgaW5zdGVhZAo+Cj4gQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7Zu
aWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGll
ZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9y
Zz4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyB8IDQgKyst
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCj4gaW5kZXggMGMxYmVlZmEzZTQ5OC4u
MmM5YWYxODY4M2ZlYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
Y25fdjFfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwo+
IEBAIC03NjUsNyArNzY1LDcgQEAgc3RhdGljIHZvaWQgdmNuXzFfMF9lbmFibGVfc3RhdGljX3Bv
d2VyX2dhdGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgfQo+Cj4gIC8qKgo+IC0g
KiB2Y25fdjFfMF9zdGFydCAtIHN0YXJ0IFZDTiBibG9jawo+ICsgKiB2Y25fdjFfMF9zdGFydF9z
cGdfbW9kZSAtIHN0YXJ0IFZDTiBibG9jawo+ICAgKgo+ICAgKiBAYWRldjogYW1kZ3B1X2Rldmlj
ZSBwb2ludGVyCj4gICAqCj4gQEAgLTExMDEsNyArMTEwMSw3IEBAIHN0YXRpYyBpbnQgdmNuX3Yx
XzBfc3RhcnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gIH0KPgo+ICAvKioKPiAtICog
dmNuX3YxXzBfc3RvcCAtIHN0b3AgVkNOIGJsb2NrCj4gKyAqIHZjbl92MV8wX3N0b3Bfc3BnX21v
ZGUgLSBzdG9wIFZDTiBibG9jawo+ICAgKgo+ICAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2lu
dGVyCj4gICAqCj4gLS0KPiAyLjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
