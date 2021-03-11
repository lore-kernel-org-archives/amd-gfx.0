Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35402C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 14:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B654564FA9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 14:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B654564FA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 281956ED14;
	Thu, 11 Mar 2021 14:23:11 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC8E6ECEF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 13:52:01 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id d191so1350170wmd.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 05:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=GdXN3z4xkG8mhrjjLyuf+xPSPLFfHaqc7TyE3s6lR5o=;
 b=mzyHuGYkxuGBqtX56UH+ZqkeHQrY7cxjlNcTXAnF2iB0rcPRz1a0NOXIcbCaQA03iz
 EDY3iXzg3ylmx6DshXuHd/xYeDBmICAzMcMb1ziWGbtGMp88T3If/JFMeDUTgYLA5FaR
 lZzyUcqQNlTgrbOWxIiCNNkGXcN+YcAkRa7XtcndRuHIISjtS1bqOozbZsz1nC5hcsDD
 u26KEay0y9NGORuXLNCFAGzVfuTbflhbbVeY0FwDzd47mAegDitFXQlidZ+r3vc4qp62
 2wq4Ap9JOFRY2OG3rj7JvheiELYyUdtdiEu9Q/yHgDadrXZxY7kRNmrLS7Phdb9dJhjR
 /WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GdXN3z4xkG8mhrjjLyuf+xPSPLFfHaqc7TyE3s6lR5o=;
 b=GG/wU/RBIBDgYPsmEabD3ioY7bm83pJwmCtQYfKLMWGjZNBwOhlJuYffVT9XAFtaAZ
 a8zwqeaTesX42FDJY/chUYYgk/BnrPegWKgHY12CDTTUVjIjdrhrMDNao1sMVyPHbNS4
 GY66+DwGPx8fmYypqrOmhZ1sV+QUdXftBp3Za5gMxreqlzog7dnuz0Wk+ACsdxvzcxt7
 6053vwCQc5aiGeBB9GM4D0Y1WeNSgoYEWXEqgbzh+jYRPhLNlDH+8poiDB175rUNFMnV
 7l+inZUk/VCqN0sGY6W9OBMciMALKhuY7Nj4JnI0oehgo2ERdru4xOcqFFud4wfgcvML
 QvNA==
X-Gm-Message-State: AOAM533RjlF1Eh3AIOlKb3bFs55QYrD6S1HoHv3L4Hb2941EhZ6R+9mb
 LQzX9ljdT2t18To8VISxaLNKLg==
X-Google-Smtp-Source: ABdhPJwtZ3Lak0tbe7621fR5C5wI2ILNInbUcMVPIDqge9Cl2Uqimu1nbUPn2VLmqrVsQ9qrcxz2sA==
X-Received: by 2002:a7b:cd81:: with SMTP id y1mr8400832wmj.51.1615470715019;
 Thu, 11 Mar 2021 05:51:55 -0800 (PST)
Received: from dell ([91.110.221.204])
 by smtp.gmail.com with ESMTPSA id h10sm4119795wrp.22.2021.03.11.05.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Mar 2021 05:51:54 -0800 (PST)
Date: Thu, 11 Mar 2021 13:51:52 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Roland Scheidegger <sroland@vmware.com>, linux-kernel@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org, Anthony Koo <Anthony.Koo@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Colin Ian King <colin.king@canonical.com>,
 Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Jeremy Kolb <jkolb@brandeis.edu>,
 Kuogee Hsieh <khsieh@codeaurora.org>, Leo Li <sunpeng.li@amd.com>,
 linaro-mm-sig@lists.linaro.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org,
 Qinglang Miao <miaoqinglang@huawei.com>,
 Rob Clark <rob.clark@linaro.org>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Zack Rusin <zackr@vmware.com>
Subject: Re: [RESEND 00/53] Rid GPU from W=1 warnings
Message-ID: <20210311135152.GT701493@dell>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
 <16d4300e-bf29-1e85-317b-53d257890cb9@vmware.com>
 <20210308091932.GB4931@dell> <YEobySvG0zPs9xhc@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YEobySvG0zPs9xhc@phenom.ffwll.local>
X-Mailman-Approved-At: Thu, 11 Mar 2021 14:23:10 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCAxMSBNYXIgMjAyMSwgRGFuaWVsIFZldHRlciB3cm90ZToKCj4gT24gTW9uLCBNYXIg
MDgsIDIwMjEgYXQgMDk6MTk6MzJBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gT24gRnJp
LCAwNSBNYXIgMjAyMSwgUm9sYW5kIFNjaGVpZGVnZ2VyIHdyb3RlOgo+ID4gCj4gPiA+IFRoZSB2
bXdnZnggb25lcyBsb29rIGFsbCBnb29kIHRvIG1lLCBzbyBmb3IKPiA+ID4gMjMtNTM6IFJldmll
d2VkLWJ5OiBSb2xhbmQgU2NoZWlkZWdnZXIgPHNyb2xhbmRAdm13YXJlLmNvbT4KPiA+ID4gVGhh
dCBzYWlkLCB0aGV5IHdlcmUgYWxyZWFkeSBzaWduZWQgb2ZmIGJ5IFphY2ssIHNvIG5vdCBzdXJl
IHdoYXQKPiA+ID4gaGFwcGVuZWQgaGVyZS4KPiA+IAo+ID4gWWVzLCB0aGV5IHdlcmUgYWNjZXB0
ZWQgYXQgb25lIHBvaW50LCB0aGVuIGRyb3BwZWQgd2l0aG91dCBhIHJlYXNvbi4KPiA+IAo+ID4g
U2luY2UgSSByZWJhc2VkIG9udG8gdGhlIGxhdGVzdCAtbmV4dCwgSSBoYWQgdG8gcGx1Y2sgdGhl
bSBiYWNrIG91dCBvZgo+ID4gYSBwcmV2aW91cyBvbmUuCj4gCj4gVGhleSBzaG91bGQgc2hvdyB1
cCBpbiBsaW51eC1uZXh0IGFnYWluLiBXZSBtZXJnZSBwYXRjaGVzIGZvciBuZXh0IG1lcmdlCj4g
d2luZG93IGV2ZW4gZHVyaW5nIHRoZSBjdXJyZW50IG1lcmdlIHdpbmRvdywgYnV0IG5lZWQgdG8g
bWFrZSBzdXJlIHRoZXkKPiBkb24ndCBwb2xsdXRlIGxpbnV4LW5leHQuIE9jY2FzaW9uYWxseSB0
aGUgY3V0IG9mZiBpcyB3cm9uZyBzbyBwYXRjaGVzCj4gc2hvdyB1cCwgYW5kIHRoZW4gZ2V0IHB1
bGxlZCBhZ2Fpbi4KPiAKPiBVbmZvcnR1bmF0ZWx5IGVzcGVjaWFsbHkgdGhlIDUuMTIgbWVyZ2Ug
Y3ljbGUgd2FzIHZlcnkgd29iYmx5IGR1ZSB0byBzb21lCj4gY29uZnVzaW9uIGhlcmUuIEJ1dCB5
b3VyIHBhdGNoZXMgc2hvdWxkIGFsbCBiZSBpbiBsaW51eC1uZXh0IGFnYWluICh0aGV5Cj4gYXJl
IHF1ZXVlZCB1cCBmb3IgNS4xMyBpbiBkcm0tbWlzYy1uZXh0LCBJIGNoZWNrZWQgdGhhdCkuCj4g
Cj4gU29ycnkgZm9yIHRoZSBjb25mdXNpb24gaGVyZS4KCk9oLCBJIHNlZS4gIFdlbGwgc28gbG9u
ZyBhcyB0aGV5IGRvbid0IGdldCBkcm9wcGVkLCBJJ2xsIGJlIGhhcHB5LgoKVGhhbmtzIGZvciB0
aGUgZXhwbGFuYXRpb24gRGFuaWVsCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClNlbmlvciBU
ZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBPcGVuIHNv
dXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0
dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
