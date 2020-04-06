Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06D3C2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95AE206B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VveaK+Vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95AE206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7901A89AB3;
	Mon,  6 Apr 2020 18:47:33 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B6589AB3
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 18:47:32 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id 31so740945wre.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Apr 2020 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2oM5japuIJ4WIRnKz8XwIDNP2DJHsY+6npRv9awiGWU=;
 b=VveaK+Vr8wuD17SRq2IXUYmDTCJp9q4PH9dowHB97xHq98IMldBmYHL9gdXcW+ivzh
 gus5Tk1rPUqbjQf1lRxpBEKsS+zVfN/5g/9aJ/wWJ7mzCDEbkeOwqm6oxC/Ay936ZJiw
 9HPiKU9JWeW0zrj959aIBUDsuBex8+Gwesg2B8CyeQPS9PstscJf80LjemKEczVo4xOk
 mwJmMP4yMCKAjdimXMrBaPgBoYBYa0RVfFzp2JMj4mF7xGVp/Qo7JHWff50H9/N16bAu
 msN8ewg35uLF18oAcyFKzzJTC/I3bl/PMnYpM3nTUne7d2/aqemaTKICbvpbq+0yj2JI
 r6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2oM5japuIJ4WIRnKz8XwIDNP2DJHsY+6npRv9awiGWU=;
 b=prDpo6oWROjY7FCMNIjaRtdbpL4o7g1KdgTImxzI1uP+9Lqt3d4ASNi312NANtxU6C
 V18wLGzQ+607jvLi7mIISK4Li9PFEiKf3NcDZLZ7ygAPde50Dv4v2hhAV4GlW6uQgsly
 81CWJ4aJwgQUVmEAs2DW6o4rw8C4+Onb+3smUUuFcqJDEIpaqTvKB+WQwjGNoLF6uGUj
 oxaNfb/D4sN/Y6oc48lFEeosl1QPN0bPBrwxsa7hfvRjaQQdHhsTrIOUGoA5o8hkG0Ge
 pgvifMb4W1FjA9by5148x8wz7W8SFNtIgMlJZTOG0Zby2J8XFEN3oU3twvqQWc/9g979
 Xoxg==
X-Gm-Message-State: AGi0PuYOCiRmZDHJATuNxc3v6umnuupKE2/q7h4Kaw18nmgiXlhipSka
 Sx7BSmgJUWixJcgmQzPY6SaC5ik4obxWxPIQgXDucA==
X-Google-Smtp-Source: APiQypKOD+9By1zow+GfMf4bRP6xlfBiYeCDPumZjK/qPY3uB3C2ZIuRJ567EsYJkHKO76FtivIYvyKuWRJ2cergDWw=
X-Received: by 2002:a5d:6742:: with SMTP id l2mr702874wrw.124.1586198850861;
 Mon, 06 Apr 2020 11:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
 <20200405204115.683559-31-Rodrigo.Siqueira@amd.com>
 <e6066d48-7666-50b6-c3c7-0e910b4ba3d4@daenzer.net>
 <20200406184421.ez2tll7llob3s6pb@outlook.office365.com>
In-Reply-To: <20200406184421.ez2tll7llob3s6pb@outlook.office365.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Apr 2020 14:47:19 -0400
Message-ID: <CADnq5_NBpsW5ZnfiFM3ttmLHPZ7-nZP7AhE098W8Zz=YaOhszQ@mail.gmail.com>
Subject: Re: [PATCH 30/36] drm/amd/display: Avoid create MST prop after
 registration
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Jerry \(Fangzhi\) Zuo" <Jerry.Zuo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBBcHIgNiwgMjAyMCBhdCAyOjQ0IFBNIFJvZHJpZ28gU2lxdWVpcmEKPFJvZHJpZ28u
U2lxdWVpcmFAYW1kLmNvbT4gd3JvdGU6Cj4KPiBIaSBNaWNoZWwsCj4KPiBJJ20gZ29pbmcgdG8g
YXBwbHkgdGhlIHBhdGNoc2V0IGJ5IHRoZSBlbmQgb2YgdGhlIGRheSBhdCBBTUQgcmVwb3NpdG9y
eS4KPiBJcyB0aGF0IG9rIGZvciB5b3U/IE9yIGRvIHlvdSBuZWVkIHRoaXMgcGF0Y2ggb24gZHJt
LW1pc2MtbmV4dD8KCkkgY2FuIGNoZXJyeS1waWNrIHRoZSBjaGFuZ2VzIG92ZXIgdG8gNS43IGZp
eGVzIG9uY2Ugd2UndmUgYWRkcmVzc2VkCmFsbCB0aGUgaXNzdWVzLgoKQWxleAoKPgo+IEJlc3Qg
UmVnYXJkcwo+Cj4gT24gMDQvMDYsIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+ID4gT24gMjAyMC0w
NC0wNSAxMDo0MSBwLm0uLCBSb2RyaWdvIFNpcXVlaXJhIHdyb3RlOgo+ID4gPiBGcm9tOiAiSmVy
cnkgKEZhbmd6aGkpIFp1byIgPEplcnJ5Llp1b0BhbWQuY29tPgo+ID4gPgo+ID4gPiBbV2h5XQo+
ID4gPiBQcm9wIGFyZSBjcmVhdGVkIGF0IGJvb3Qgc3RhZ2UsIGFuZCBub3QgYWxsb3dlZCB0byBj
cmVhdGUgbmV3IHByb3AKPiA+ID4gYWZ0ZXIgZGV2aWNlIHJlZ2lzdHJhdGlvbi4KPiA+ID4KPiA+
ID4gW0hvd10KPiA+ID4gUmV1c2UgdGhlIGNvbm5lY3RvciBwcm9wZXJ0eSBmcm9tIFNTVCBpZiBl
eGlzdC4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmVycnkgKEZhbmd6aGkpIFp1byA8SmVy
cnkuWnVvQGFtZC5jb20+Cj4gPiA+IFJldmlld2VkLWJ5OiBIZXJzZW4gV3UgPGhlcnNlbnhzLnd1
QGFtZC5jb20+Cj4gPiA+IEFja2VkLWJ5OiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVl
aXJhQGFtZC5jb20+Cj4gPiBUaGlzIHBhdGNoIGlzIG5lZWRlZCBpbiA1LjcsIG9yIG9uZSBnZXRz
IHRoZSBXQVJOSU5HcyBJIHJlcG9ydGVkIGluCj4gPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3Rv
cC5vcmclMkZhcmNoaXZlcyUyRmFtZC1nZnglMkYyMDIwLUFwcmlsJTJGMDQ4MDE3Lmh0bWwmYW1w
O2RhdGE9MDIlN0MwMSU3Q1JvZHJpZ28uU2lxdWVpcmElNDBhbWQuY29tJTdDODI1NjJkNmVmYzZh
NGM4NWFmZDEwOGQ3ZGEzYzc0OTAlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3
QzAlN0MwJTdDNjM3MjE3ODI1NTE5MDIzMzEyJmFtcDtzZGF0YT1oN1pWbGRLTWdQJTJGV2tNVnBq
biUyQlg2Znl0S29OWmkyNGxGak9kUzNRTVV0cyUzRCZhbXA7cmVzZXJ2ZWQ9MAo+ID4gd2hlbiBh
biBNU1QgZGlzcGxheSBpcyBjb25uZWN0ZWQuCj4gPgo+ID4gTm90ZSB0aGF0IHRoaXMgcGF0Y2gg
ZG9lc24ndCBmaXggYWxsIG9mIHRob3NlLCB0aGVyZSdzIGFsc28gb25lCj4gPiB0cmlnZ2VyZWQg
YnkgZG1fZHBfYWRkX21zdF9jb25uZWN0b3IgPT4gZHJtX2VuY29kZXJfaW5pdC4KPiA+Cj4gPiAg
Z2l0IGdyZXAgbXN0X2VuY29kZXJzIGRyaXZlcnMvZ3B1L2RybS9pOTE1Lwo+ID4KPiA+IHNob3dz
IGhvdyB0aGUgaTkxNSBkcml2ZXIgZGVhbHMgd2l0aCB0aGlzLgo+ID4KPiA+IENhbiB5b3UgZ3V5
cyB0YWtlIGNhcmUgb2YgdGhhdCBmb3IgNS43IGFzIHdlbGw/Cj4gPgo+ID4KPiA+IC0tCj4gPiBF
YXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0
cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGcmVkaGF0LmNvbSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDUm9kcmlnby5TaXF1ZWlyYSU0
MGFtZC5jb20lN0M4MjU2MmQ2ZWZjNmE0Yzg1YWZkMTA4ZDdkYTNjNzQ5MCU3QzNkZDg5NjFmZTQ4
ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcyMTc4MjU1MTkwMjgzMDQmYW1wO3Nk
YXRhPWg5Zm00eDRCM0tuMVU0YmxvWmJMZVpUYmp5Z1pDSElnb3lyb2FFVzklMkIzcyUzRCZhbXA7
cmVzZXJ2ZWQ9MAo+ID4gTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAg
ICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCj4KPiAtLQo+IFJvZHJpZ28gU2lxdWVpcmEK
PiBodHRwczovL3NpcXVlaXJhLnRlY2gKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
