Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FAKE_REPLY_C,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03BFC17441
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 17:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB1420679
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 17:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB1420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1E16EB8A;
	Tue, 12 Nov 2019 17:19:19 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277676EB8A;
 Tue, 12 Nov 2019 17:19:18 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C6C2520659;
 Tue, 12 Nov 2019 17:19:17 +0000 (UTC)
Date: Tue, 12 Nov 2019 11:19:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 1/2] drm: replace incorrect Compliance/Margin magic
 numbers with PCI_EXP_LNKCTL2 definitions
Message-ID: <20191112171915.GA167243@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6d86246e-504a-b762-aff8-0449dd6f3d31@daenzer.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1573579158;
 bh=85dgABjfLst0EJiLfQ6UppL83HD41+jlwGeYc+PJi5s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=xdL+G1zDFE46caLzbkDRg0br9X96M7qfTympBm/tlAae7Dosfy8oNmO241YvCY3ot
 o/AK0tQcwpY1drq9ZXLTRTg83BCM/T44eZYlb5MREr/qYT9bAmbRggcZgaxXabvtMW
 jK+xizZQdMqOiW5ALdmPKCHortPXcRVIeEtOVC2I=
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
Cc: David Zhou <David1.Zhou@amd.com>, Frederick Lawler <fred@fredlawl.com>,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112171915.WPu6QhIhjVgBWzo9z0_IME1QgwxFtmB90jeoaM0OmE8@z>

T24gVHVlLCBOb3YgMTIsIDIwMTkgYXQgMDU6NDU6MTVQTSArMDEwMCwgTWljaGVsIETDpG56ZXIg
d3JvdGU6Cj4gT24gMjAxOS0xMS0xMSA4OjI5IHAubS4sIEJqb3JuIEhlbGdhYXMgd3JvdGU6Cj4g
PiBGcm9tOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgo+ID4gCj4gPiBBZGQg
ZGVmaW5pdGlvbnMgZm9yIHRoZXNlIFBDSWUgTGluayBDb250cm9sIDIgcmVnaXN0ZXIgZmllbGRz
Ogo+ID4gCj4gPiAgIEVudGVyIENvbXBsaWFuY2UKPiA+ICAgVHJhbnNtaXQgTWFyZ2luCj4gPiAK
PiA+IGFuZCB1c2UgdGhlbSBpbiBhbWRncHUgYW5kIHJhZGVvbi4KPiA+IAo+ID4gTk9URTogVGhp
cyBpcyBhIGZ1bmN0aW9uYWwgY2hhbmdlIGJlY2F1c2UgIjcgPDwgOSIgd2FzIGFwcGFyZW50bHkg
YSB0eXBvLgo+ID4gVGhhdCBtYXNrIGluY2x1ZGVkIHRoZSBoaWdoIG9yZGVyIGJpdCBvZiBUcmFu
c21pdCBNYXJnaW4sIHRoZSBFbnRlcgo+ID4gTW9kaWZpZWQgQ29tcGxpYW5jZSBiaXQsIGFuZCB0
aGUgQ29tcGxpYW5jZSBTT1MgYml0LCBidXQgSSB0aGluayB3aGF0Cj4gPiB3YXMgaW50ZW5kZWQg
d2FzIHRoZSAzLWJpdCBUcmFuc21pdCBNYXJnaW4gZmllbGQgYXQgYml0cyA5OjcuCj4gCj4gQ2Fu
IHlvdSBzcGxpdCBvdXQgdGhlIGZ1bmN0aW9uYWwgY2hhbmdlIGludG8gYSBzZXBhcmF0ZSBwYXRj
aCAxPyBUaGF0Cj4gY291bGQgbWFrZSB0aGluZ3MgZWFzaWVyIGZvciBhbnlvbmUgd2hvIGJpc2Vj
dHMgdGhlIGZ1bmN0aW9uYWwgY2hhbmdlCj4gZm9yIHdoYXRldmVyIHJlYXNvbi4KCkdyZWF0IGlk
ZWEsIHRoYW5rcyEgIFdpc2ggSSdkIHRob3VnaHQgb2YgdGhhdC4KCldoaWxlIGZpeGluZyB0aGF0
LCBJIGFsc28gbm90aWNlZCBJIG1pc3NlZCBvbmUgY2FzZSBpbgphbWRncHUvc2kuYy4gIEknbGwg
cG9zdCBhIHYzLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
