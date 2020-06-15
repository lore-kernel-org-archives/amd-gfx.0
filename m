Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9080CC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 21:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE0720714
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 21:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="2GB7LupH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE0720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5236E524;
	Mon, 15 Jun 2020 21:48:37 +0000 (UTC)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410086E511
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 21:18:43 +0000 (UTC)
Received: by mail-pj1-x1044.google.com with SMTP id b7so327151pju.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=K+cMiKrRga91vCTBmD8D5XGxUlsSQ1EKO7QoeTvwQ14=;
 b=2GB7LupHwlZ6MZtJPWSNxp3apFXotPM40suzbHcMbHpAtfxMDlfoT68CSyoFNL8a5W
 Z0tAhownZcTP8TRk6IoslRw8BJAf1OXzJREAwoj7wWd3V14OSBwEBVF70E7hminRlU56
 2VsxRj20OP0xyXqNS18gd25MtW6DEU2un5q7P64tYWB4Fs7qzeb27Scj4voailQZlsxX
 kibSCzCnlI3uAzFI7DH/O+JIlSgCq0aVl2WDsd7HhTrTfAWwnO/iAvwlYH/1TAJRTivU
 y1ZhI4gCO2NoAYrkyYozZCRaczRqz8a/Xr9GEbYWOyr3GPdZ6rbRamLSMm4DX8QTnYXG
 f0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=K+cMiKrRga91vCTBmD8D5XGxUlsSQ1EKO7QoeTvwQ14=;
 b=MIvFeoSH/uLgoksfTeZPivSEbgfFV08e2fqISlOrceYyF8PT+gtW8+YxL7sW9KeqHq
 7D2SecGA4whznCfot+j8/+HpgXBT5ODo4rHaVyohp9KhaNfo4uS7puzwB5D8PK3KpUkx
 o5Ipxrmj1NYtNU9LUGwVLpqXYdskhPq5n0QN3vx0HiQ0FVai+fxrzPw6U9satzrAXS7u
 SdQQiO0WaLiMv0tRdpUmW6GFNqndEcCHZax6+6uOBGRPM/XOsIQRjHJIgsVC+b75lXP/
 lVlmm42XqZ+jhqDukw+PlkDlx+yH0Uf3ORwMNo42Z7HJzTWUSDh+MELDeN+4I1JYjniV
 +hQA==
X-Gm-Message-State: AOAM531svUY495DZDnSsLPY8tL7mt8firmoF+mRmvR2S5tObE7UhuPMw
 Ge/641jWlqVajMyV55U8bBNJww==
X-Google-Smtp-Source: ABdhPJyk8XIeff9RCB4w5FuIJDrmQLNmbSUdiTI79aWKrOQ2lLPVa5D7eCOAxgksAA4QZIZRamSHVA==
X-Received: by 2002:a17:90a:e509:: with SMTP id
 t9mr1153242pjy.189.1592255922875; 
 Mon, 15 Jun 2020 14:18:42 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d2f:b9d:749:9ce5?
 ([2601:646:c200:1ef2:d2f:b9d:749:9ce5])
 by smtp.gmail.com with ESMTPSA id g65sm14766552pfb.61.2020.06.15.14.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 14:18:42 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Date: Mon, 15 Jun 2020 14:18:39 -0700
Message-Id: <E39A5DE2-5615-41FF-9953-4F4C4E8499D8@amacapital.net>
References: <3908561D78D1C84285E8C5FCA982C28F7F66C849@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F66C849@ORSMSX115.amr.corp.intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (17F80)
X-Mailman-Approved-At: Mon, 15 Jun 2020 21:48:37 +0000
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
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, "Hansen, Dave" <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Ingo Molnar <mingo@redhat.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Yu,
 Yu-cheng" <yu-cheng.yu@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cgo+IE9uIEp1biAxNSwgMjAyMCwgYXQgMTo1NiBQTSwgTHVjaywgVG9ueSA8dG9ueS5sdWNrQGlu
dGVsLmNvbT4gd3JvdGU6Cj4gCj4g77u/Cj4+IAo+PiBBcmUgd2UgcGxhbm5pbmcgdG8ga2VlcCBQ
QVNJRCBsaXZlIG9uY2UgYSB0YXNrIGhhcyB1c2VkIGl0IG9uY2Ugb3IgYXJlIHdlIGdvaW5nIHRv
IHN3YXAgaXQgbGF6aWx5PyAgSWYgdGhlIGxhdHRlciwgYSBwZXJjcHUgdmFyaWFibGUgbWlnaHQg
YmUgYmV0dGVyLgo+IAo+IEN1cnJlbnQgcGxhbiBpcyAidG91Y2ggaXQgb25jZSBhbmQgdGhlIHRh
c2sgb3ducyBpdCB1bnRpbCBleGl0KDIpIgo+IAo+IE1heWJlIHNvbWVkYXkgaW4gdGhlIGZ1dHVy
ZSB3aGVuIHdlIGhhdmUgZGF0YSBvbiBob3cgYXBwbGljYXRpb25zCj4gYWN0dWFsbHkgdXNlIGFj
Y2VsZXJhdG9ycyB3ZSBjb3VsZCBsb29rIGF0IHNvbWV0aGluZyBtb3JlIGNvbXBsZXgKPiBpZiB1
c2FnZSBwYXR0ZXJucyBsb29rIGxpa2UgaXQgd291bGQgYmUgYmVuZWZpY2lhbC4KPiAKPiAKClNv
IHdoYXTigJlzIHRoZSBSRE1TUiBmb3I/ICBTdXJlbHkgeW91CmhhdmUgc29tZSBzdGF0ZSBzb21l
d2hlcmUgdGhhdCBzYXlzIOKAnHRoaXMgdGFzayBoYXMgYSBQQVNJRC7igJ0gIENhbuKAmXQgeW91
IGp1c3QgbWFrZSBzdXJlIHRoYXQgc3RheXMgaW4gc3luYyB3aXRoIHRoZSBNU1I/ICBUaGVuLCBv
biAjR1AsIGlmIHRoZSB0YXNrIGFscmVhZHkgaGFzIGEgUEFTSUQsIHlvdSBrbm93IHRoZSBNU1Ig
aXMgc2V0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
