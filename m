Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE69EC433E1
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 17:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE35F20774
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 17:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE35F20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86FCD6E2E9;
	Tue,  9 Jun 2020 17:15:21 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1715189F55
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 15:44:21 +0000 (UTC)
IronPort-SDR: ZtLt2J6yxQnX5QMGwxk8u/1DhBt6ZRgVEaQ9sO7q+lqY4AJKE99k0n7eqNqbWkBqdATviUjRO6
 tigoKq02xFcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2020 08:44:20 -0700
IronPort-SDR: B3OCjkA00+WDlux1lmQ1P9O1e4pJaj2LD9l02uW46lOwaDhjnF5OXOF6p9F2gYMvkW+Gnsg+Ka
 2B7QtNL69Agg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; d="scan'208";a="379769157"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
 by fmsmga001.fm.intel.com with SMTP; 09 Jun 2020 08:44:16 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 09 Jun 2020 18:44:16 +0300
Date: Tue, 9 Jun 2020 18:44:16 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: close() on some Intel CNP-LP PCI devices takes up to 2.7 s
Message-ID: <20200609154416.GU247495@lahna.fi.intel.com>
References: <b0781d0e-2894-100d-a4da-e56c225eb2a6@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b0781d0e-2894-100d-a4da-e56c225eb2a6@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Mailman-Approved-At: Tue, 09 Jun 2020 17:15:18 +0000
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
Cc: Mario Limonciello <mario.limonciello@dell.com>, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 it+linux-pci@molgen.mpg.de, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gMDksIDIwMjAgYXQgMDU6Mzk6MjFQTSArMDIwMCwgUGF1bCBNZW56ZWwgd3Jv
dGU6Cj4gRGVhciBMaW51eCBmb2xrcywKPiAKPiAKPiBPbiB0aGUgSW50ZWwgQ2Fubm9uIFBvaW50
LUxQIGxhcHRvcCBEZWxsIFByZWNpc2lvbiAzNTQwIHdpdGggYSBkZWRpY2F0ZWQgQU1ECj4gZ3Jh
cGhpY3MgY2FyZCAoYm90aCBncmFwaGljcyBkZXZpY2VzIGNhbiBiZSB1c2VkKSB3aXRoIERlYmlh
biBTaWQvdW5zdGFibGUKPiB3aXRoIExpbnV4IDUuNi4xNCwgcnVubmluZyBsc3BjaSB0YWtlcyBx
dWl0ZSBzb21lIHRpbWUsIGFuZCB0aGUgc2NyZWVuIGV2ZW4KPiBmbGlja2VycyBhIHNob3J0IG1v
bWVudCBiZWZvcmUgdGhlIHJlc3VsdCBpcyBkaXNwbGF5ZWQuCj4gCj4gVHJhY2luZyBsc3BjaSB3
aXRoIHN0cmFjZSwgc2hvd3MgdGhhdCB0aGUgY2xvc2UoKSBmdW5jdGlvbiBvZiB0aGUgdGhyZWUK
PiBkZXZpY2VzIHRha2VzIGZyb20KPiAKPiDigKIgICAwMDoxZC4wIFBDSSBicmlkZ2U6IEludGVs
IENvcnBvcmF0aW9uIENhbm5vbiBQb2ludC1MUCBQQ0kgRXhwcmVzcyBSb290Cj4gUG9ydCAjOQo+
IAo+IOKAoiAgIDA0OjAwLjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIEpI
TDYzNDAgVGh1bmRlcmJvbHQgMyBOSEkKPiAoQyBzdGVwKSBbQWxwaW5lIFJpZGdlIDJDIDIwMTZd
IChyZXYgMDIpCj4gCj4g4oCiICAgM2I6MDAuMCBEaXNwbGF5IGNvbnRyb2xsZXI6IEFkdmFuY2Vk
IE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIExleGEKPiBYVCBbUmFkZW9uIFBSTyBXWCAz
MTAwXQo+IAo+IHRha2VzIGZyb20gMjcwIG1zIHRvIDIuNSBzLgo+IAo+ID4gMTE6NDM6MjEuNzE0
MzkxIG9wZW5hdChBVF9GRENXRCwgIi9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6MDQ6MDAuMC9j
b25maWciLCBPX1JET05MWSkgPSAzCj4gPiAxMTo0MzoyMS43MTQ0NDggcHJlYWQ2NCgzLCAiXDIw
NlwyMDBcMzMxXDI1XDZcNFwyMFwwXDJcMFwyMDBcMTAgXDBcMFwwXDBcMFwwXDM1MlwwXDBcNFwz
NTJcMFwwXDBcMFwwXDBcMFwwXDBcMFwwXDBcMFwwXDBcMFwwXDBcMFwwKFwyMFwyNzJcMTBcMFww
XDBcMFwKPiA+IDIwMFwwXDBcMFwwXDBcMFwwXDM3N1wxXDBcMCIsIDY0LCAwKSA9IDY0Cj4gPiAx
MTo0MzoyNC40ODc4MTggY2xvc2UoMykgICAgICAgICAgICAgICAgPSAwCj4gCj4gPiAxMTo0Mzoy
NC40ODk1MDggb3BlbmF0KEFUX0ZEQ1dELCAiL3N5cy9idXMvcGNpL2RldmljZXMvMDAwMDowMDox
ZC4wL2NvbmZpZyIsIE9fUkRPTkxZKSA9IDMKPiA+IDExOjQzOjI0LjQ4OTU5OCBwcmVhZDY0KDMs
ICJcMjA2XDIwMFwyNjBcMjM1XDdcNFwyMFwwXDM2MFwwXDRcNlwyMFwwXDIwMVwwXDBcMFwwXDBc
MFwwXDBcMFwwOztcMDAwMDBcMCAgXDM1NCBcMzU0XDFcMzAwXDIxXDMyMFwwXDBcMFwwXDBcMFww
XDBcMFwwXDBcMAo+ID4gQFwwXDBcMFwwXDBcMFwwXDM3N1wxXDIyXDAiLCA2NCwgMCkgPSA2NAo+
ID4gMTE6NDM6MjQuOTY2NjYxIGNsb3NlKDMpICAgICAgICAgICAgICAgID0gMAo+IAo+ID4gMTE6
NDM6MjQuOTg4NTQ0IG9wZW5hdChBVF9GRENXRCwgIi9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6
M2I6MDAuMC9jb25maWciLCBPX1JET05MWSkgPSAzCj4gPiAxMTo0MzoyNC45ODg1ODQgcHJlYWQ2
NCgzLCAiXDJcMjBcMjA1aVw3XDRcMjBcMFwwXDBcMjAwXDNcMjBcMFwwXDBcZlwwXDBcMzAwXDBc
MFwwXDBcZlwwXDBcMzIwXDBcMFwwXDBcMDAxMFwwXDBcMFwwIFwzNTRcMFwwXDBcMChcMjBcMjcy
XDEwXDBcMCRcMzU0SFwwXDBcMFwwXDBcMFwwXDM3N1wxXDBcMCIsIDY0LCAwKSA9IDY0Cj4gPiAx
MTo0MzoyNS4yNTI3NDUgY2xvc2UoMykKPiAKPiBVbmZvcnR1bmF0ZWx5LCBJIGZvcmdvdCB0byBj
b2xsZWN0IHRoZSB0cmVlIG91dHB1dCwgYnV0IGhvcGVmdWxseSB0aGUKPiBhdHRhY2hlZCBMaW51
eCBtZXNzYWdlcyBhbmQgc3RyYWNlIG9mIGxzcGNpIG91dHB1dCB3aWxsIGJlIGVub3VnaCBmb3Ig
dGhlCj4gc3RhcnQuCj4gCj4gUGxlYXNlIHRlbGwgbWUsIGlmIHlvdSB3YW50IG1lIHRvIGNyZWF0
ZSBhIGJ1ZyByZXBvcnQgaW4gdGhlIExpbnV4IGJ1Zwo+IHRyYWNrZXIuCgpDYW4geW91IHRyeSB0
aGlzIGNvbW1pdD8KCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvaGVsZ2Fhcy9wY2kuZ2l0L2NvbW1pdC8/aD1wY2kvcG0maWQ9ZWM0MTFlMDJiN2EyZTc4
NWE0ZWQ5ZWQyODMyMDdjZDE0ZjQ4Njk5ZAoKSXQgc2hvdWxkIGJlIGluIHRoZSBtYWlubGluZSBh
bHJlYWR5IGFzIHdlbGwuCgpOb3RlIHdlIHN0aWxsIG5lZWQgdG8gb2JleSB0aGUgZGVsYXlzIHJl
cXVpcmVkIGJ5IHRoZSBQQ0llIHNwZWMgc28gMTAwbXMKYWZ0ZXIgdGhlIGxpbmsgaXMgdHJhaW5l
ZCBidXQgdGhpcyBvbmUgc2hvdWxkIGF0IGxlYXN0IGdldCBpdCBkb3duIGZyb20KMTEwMG1zLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
