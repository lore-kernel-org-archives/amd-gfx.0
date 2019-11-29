Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CA2C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 15:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D77216F4
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 15:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D77216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE256E929;
	Fri, 29 Nov 2019 15:08:51 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22D36E922;
 Fri, 29 Nov 2019 15:08:49 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Nov 2019 07:08:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; d="scan'208";a="203761491"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
 by orsmga008.jf.intel.com with SMTP; 29 Nov 2019 07:08:46 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Fri, 29 Nov 2019 17:08:45 +0200
Date: Fri, 29 Nov 2019 17:08:45 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Wayne Lin <Wayne.Lin@amd.com>
Subject: Re: [PATCH V2 1/2] drm/edid: Add aspect ratios to HDMI 4K modes
Message-ID: <20191129150845.GF1208@intel.com>
References: <20191118101832.15487-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191118101832.15487-1-Wayne.Lin@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMTgsIDIwMTkgYXQgMDY6MTg6MzFQTSArMDgwMCwgV2F5bmUgTGluIHdyb3Rl
Ogo+IFtXaHldCj4gSERNSSAyLjAgYWRkcyBhc3BlY3QgcmF0aW8gYXR0cmlidXRlIHRvIGRpc3Rp
bmd1aXNoIGRpZmZlcmVudAo+IDRrIG1vZGVzLiBBY2NvcmRpbmcgdG8gQXBwZW5kaXggRSBvZiBI
RE1JIDIuMCBzcGVjLCBzb3VyY2Ugc2hvdWxkCj4gdXNlIFZTSUYgdG8gaW5kaWNhdGUgdmlkZW8g
bW9kZSBvbmx5IHdoZW4gdGhlIG1vZGUgaXMgb25lIGRlZmluZWQKPiBpbiBIRE1JIDEuNGIgNEsg
bW9kZXMuIE90aGVyd2lzZSwgdXNlIEFWSSBpbmZvZnJhbWVzIHRvIGNvbnZleSBWSUMuCj4gCj4g
Q3VycmVudCBjb2RlIGRvZXNuJ3QgdGFrZSBhc3BlY3QgcmF0aW8gaW50byBjb25zaWRlcmF0aW9u
IHdoaWxlCj4gY29uc3RydWN0aW5nIGF2aSBpbmZvZnJhbWUuIFNob3VsZCBtb2RpZnkgdGhhdC4K
PiAKPiBbSG93XQo+IEluaGVyaXQgVmlsbGUgU3lyasOkbMOkJ3Mgd29yawo+ICJkcm0vZWRpZDog
UHJlcCBmb3IgSERNSSBWSUMgYXNwZWN0IHJhdGlvIiBhdAo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvMTExNzQ2MzkvCj4gCj4gQWRkIHBpY3R1cmVfYXNwZWN0X3JhdGlvIGF0
dHJpYnV0ZXMgdG8gZWRpZF80a19tb2Rlc1tdIGFuZAo+IGNvbnN0cnVjdCBWSUMgYW5kIEhETUlf
VklDIGJ5IHRha2luZyBhc3BlY3QgcmF0aW8gaW50bwo+IGNvbnNpZGVyYXRpb24uCj4gCj4gdjI6
IENvcnJlY3QgbWlzc2luZyBpbml0aWFsaXplciBlcnJvciBhdCBhZGRpbmcgYXNwZWN0IHJhdGlv
IG9mIAo+IFNNUFRFIG1vZGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogV2F5bmUgTGluIDxXYXluZS5M
aW5AYW1kLmNvbT4KCk91ciBDSSBkaWRuJ3QgY29tcGxhaW4gYWJvdXQgYW55dGhpbmcgdGhhdCBs
b29rZWQgcmVsZXZhbnQsCnNvIEkgd2VudCBhaGVhZCBhbiBwdXNoZWQgdGhlc2UgdG8gZHJtLW1p
c2MtbmV4dC4KClRoYW5rcyBmb3IgdGhlIHBhdGNoZXMuCgotLSAKVmlsbGUgU3lyasOkbMOkCklu
dGVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
