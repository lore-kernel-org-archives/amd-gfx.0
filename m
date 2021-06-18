Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96602C48BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 20:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA486124C
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 20:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA486124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407436EA96;
	Fri, 18 Jun 2021 20:35:01 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CF116EA7C;
 Fri, 18 Jun 2021 20:34:59 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id l12so11872855oig.2;
 Fri, 18 Jun 2021 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iQNzXJ3TwOzpw9bYBccWuBhdgfIg21YN1ripdW4KJLQ=;
 b=PXPa92zF007eLHXmzfYr64ztYgQFfHXWc4GdymN1kuuhixG+E9cA8yhyO3w18C/nX3
 ddmO+aa0Z9iyfg9l4ghcCyLCyeRJmQqtcRr/pBsTkyv92EC6RoB+vt4+O/7uchG95kUI
 6QpKN3iVSt9qf2fBybUKzh+86phHmVqgo60hMHQHfbK4ujFZVENAoenDVtbBVKL0pYiB
 ufyom+qds2k9GgHNAyHxojZX+5iVqRSl8ax3jk48j627JKeXbymhv6LsWcxxiIhqO/DY
 T+Pklw7VZImai7dpUSXEjcxyiAbmj41WKnjC6O3OYMm61Cceimd4fgkQVCdtMviFM8X+
 7G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iQNzXJ3TwOzpw9bYBccWuBhdgfIg21YN1ripdW4KJLQ=;
 b=IP+OphwZLJamjkhp/TAKrH7HpmvB1eyy4UGUXHlYGTxKSalPTpKWdpyd2jRBd+EpEw
 wEFE/b9L1rENLE03PjbAOsT4nfyHqhkJcuQQYlMH8tpRGf2q3SPvSkBW9oj1Xc5077zo
 tUp1eKc6OYHHlYYhCcqDjqfvzT08SrGrM33PgJP22hxW3kqd4oypw//KU/a1H0rFDzSv
 BwTyWWKeCHVQ/pXKN7OaXqIaCD1tzmSYDqeo5Zi/hf0E2uNkrFuOKKmlm+rZsF9Hcwwg
 iL0sXBPrsta3gLRgtHhjMhIqvV7vbVUYYxvxS37y/L8UNUGd8KmZGOQNIGPuLWO6jqKy
 dbbg==
X-Gm-Message-State: AOAM530tn8eR/e7Dm2wLVoFQVPMgJhmRlNZixOLDRTRQMeujEhjLsrEy
 cgYrFmee78Z0QbRS2AQaeIejaWaqr/INj92sNkI=
X-Google-Smtp-Source: ABdhPJyhSi9zAgTqHX3Mdd5ODSa6ar3uqjpvAyhe4sA58n+09kvDn9XoVr8fFxP2daFSRzmysgT1McWb1Hq+wDrnjq4=
X-Received: by 2002:a05:6808:c3:: with SMTP id t3mr15182503oic.5.1624048498773; 
 Fri, 18 Jun 2021 13:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210617011632.187690-1-pulehui@huawei.com>
 <7758a4ef-0b8e-8873-fac0-7db7a2f6402b@amd.com>
In-Reply-To: <7758a4ef-0b8e-8873-fac0-7db7a2f6402b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jun 2021 16:34:47 -0400
Message-ID: <CADnq5_PJu+ZXWbTVyxRE7vdSfBx7=w_mhtob8+EQUeMfKMJ6bw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove unused variable 'dc'
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Anson Jacob <Anson.Jacob@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 xinhui pan <Xinhui.Pan@amd.com>, Roman Li <roman.li@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, zhangjinhao2@huawei.com,
 Dave Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Pu Lehui <pulehui@huawei.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgSnVuIDE3LCAyMDIxIGF0IDM6MDQgUE0gSGFycnkg
V2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDIwMjEt
MDYtMTYgOToxNiBwLm0uLCBQdSBMZWh1aSB3cm90ZToKPiA+IEdDQyByZXBvcnRzIHRoZSBmb2xs
b3dpbmcgd2FybmluZyB3aXRoIFc9MToKPiA+Cj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHNyLmM6NzA6MTM6Cj4gPiB3YXJuaW5n
Ogo+ID4gIHZhcmlhYmxlIOKAmGRj4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1z
ZXQtdmFyaWFibGVdCj4gPiAgICAgNzAgfCAgc3RydWN0IGRjICpkYyA9IE5VTEw7Cj4gPiAgICAg
ICAgfCAgICAgICAgICAgICBefgo+ID4KPiA+IFRoaXMgdmFyaWFibGUgaXMgbm90IHVzZWQgaW4g
ZnVuY3Rpb24sIHRoaXMgY29tbWl0IHJlbW92ZSBpdCB0bwo+ID4gZml4IHRoZSB3YXJuaW5nLgo+
ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFB1IExlaHVpIDxwdWxlaHVpQGh1YXdlaS5jb20+Cj4KPiBS
ZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4KPiBI
YXJyeQo+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbV9wc3IuYyB8IDIgLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMo
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG1fcHNyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbV9wc3IuYwo+ID4gaW5kZXggZjdjNzdhZTBkOTY1Li43MGE1NTRmMWU3MjUg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbV9wc3IuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG1fcHNyLmMKPiA+IEBAIC02NywxNCArNjcsMTIgQEAgYm9vbCBhbWRncHVf
ZG1fbGlua19zZXR1cF9wc3Ioc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFtKQo+ID4gICAg
ICAgc3RydWN0IGRjX2xpbmsgKmxpbmsgPSBOVUxMOwo+ID4gICAgICAgc3RydWN0IHBzcl9jb25m
aWcgcHNyX2NvbmZpZyA9IHswfTsKPiA+ICAgICAgIHN0cnVjdCBwc3JfY29udGV4dCBwc3JfY29u
dGV4dCA9IHswfTsKPiA+IC0gICAgIHN0cnVjdCBkYyAqZGMgPSBOVUxMOwo+ID4gICAgICAgYm9v
bCByZXQgPSBmYWxzZTsKPiA+Cj4gPiAgICAgICBpZiAoc3RyZWFtID09IE5VTEwpCj4gPiAgICAg
ICAgICAgICAgIHJldHVybiBmYWxzZTsKPiA+Cj4gPiAgICAgICBsaW5rID0gc3RyZWFtLT5saW5r
Owo+ID4gLSAgICAgZGMgPSBsaW5rLT5jdHgtPmRjOwo+ID4KPiA+ICAgICAgIHBzcl9jb25maWcu
cHNyX3ZlcnNpb24gPSBsaW5rLT5kcGNkX2NhcHMucHNyX2NhcHMucHNyX3ZlcnNpb247Cj4gPgo+
ID4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
