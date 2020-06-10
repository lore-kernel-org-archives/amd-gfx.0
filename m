Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8118FC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 07:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBDF2083B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 07:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBDF2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F312989AD2;
	Wed, 10 Jun 2020 07:38:32 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86088903B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 06:18:10 +0000 (UTC)
Received: from [192.168.178.35] (unknown [88.130.155.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 04AE620646DCF;
 Wed, 10 Jun 2020 08:18:08 +0200 (CEST)
Subject: Re: close() on some Intel CNP-LP PCI devices takes up to 2.7 s
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <b0781d0e-2894-100d-a4da-e56c225eb2a6@molgen.mpg.de>
 <20200609154416.GU247495@lahna.fi.intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <3854150d-f193-d34e-557e-41090e4f39b5@molgen.mpg.de>
Date: Wed, 10 Jun 2020 08:18:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609154416.GU247495@lahna.fi.intel.com>
Content-Language: en-US
X-Mailman-Approved-At: Wed, 10 Jun 2020 07:38:31 +0000
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBNaWthLAoKCkFtIDA5LjA2LjIwIHVtIDE3OjQ0IHNjaHJpZWIgTWlrYSBXZXN0ZXJiZXJn
Ogo+IE9uIFR1ZSwgSnVuIDA5LCAyMDIwIGF0IDA1OjM5OjIxUE0gKzAyMDAsIFBhdWwgTWVuemVs
IHdyb3RlOgoKPj4gT24gdGhlIEludGVsIENhbm5vbiBQb2ludC1MUCBsYXB0b3AgRGVsbCBQcmVj
aXNpb24gMzU0MCB3aXRoIGEgZGVkaWNhdGVkIEFNRAo+PiBncmFwaGljcyBjYXJkIChib3RoIGdy
YXBoaWNzIGRldmljZXMgY2FuIGJlIHVzZWQpIHdpdGggRGViaWFuIFNpZC91bnN0YWJsZQo+PiB3
aXRoIExpbnV4IDUuNi4xNCwgcnVubmluZyBsc3BjaSB0YWtlcyBxdWl0ZSBzb21lIHRpbWUsIGFu
ZCB0aGUgc2NyZWVuIGV2ZW4KPj4gZmxpY2tlcnMgYSBzaG9ydCBtb21lbnQgYmVmb3JlIHRoZSBy
ZXN1bHQgaXMgZGlzcGxheWVkLgo+Pgo+PiBUcmFjaW5nIGxzcGNpIHdpdGggc3RyYWNlLCBzaG93
cyB0aGF0IHRoZSBjbG9zZSgpIGZ1bmN0aW9uIG9mIHRoZSB0aHJlZQo+PiBkZXZpY2VzIHRha2Vz
IGZyb20KPj4KPj4g4oCiICAgMDA6MWQuMCBQQ0kgYnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiBD
YW5ub24gUG9pbnQtTFAgUENJIEV4cHJlc3MgUm9vdAo+PiBQb3J0ICM5Cj4+Cj4+IOKAoiAgIDA0
OjAwLjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIEpITDYzNDAgVGh1bmRl
cmJvbHQgMyBOSEkKPj4gKEMgc3RlcCkgW0FscGluZSBSaWRnZSAyQyAyMDE2XSAocmV2IDAyKQo+
Pgo+PiDigKIgICAzYjowMC4wIERpc3BsYXkgY29udHJvbGxlcjogQWR2YW5jZWQgTWljcm8gRGV2
aWNlcywgSW5jLiBbQU1EL0FUSV0gTGV4YQo+PiBYVCBbUmFkZW9uIFBSTyBXWCAzMTAwXQo+Pgo+
PiB0YWtlcyBmcm9tIDI3MCBtcyB0byAyLjUgcy4KPj4KPj4+IDExOjQzOjIxLjcxNDM5MSBvcGVu
YXQoQVRfRkRDV0QsICIvc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDAwOjA0OjAwLjAvY29uZmlnIiwg
T19SRE9OTFkpID0gMwo+Pj4gMTE6NDM6MjEuNzE0NDQ4IHByZWFkNjQoMywgIlwyMDZcMjAwXDMz
MVwyNVw2XDRcMjBcMFwyXDBcMjAwXDEwIFwwXDBcMFwwXDBcMFwzNTJcMFwwXDRcMzUyXDBcMFww
XDBcMFwwXDBcMFwwXDBcMFwwXDBcMFwwXDBcMFwwXDBcMChcMjBcMjcyXDEwXDBcMFwwXDBcCj4+
PiAyMDBcMFwwXDBcMFwwXDBcMFwzNzdcMVwwXDAiLCA2NCwgMCkgPSA2NAo+Pj4gMTE6NDM6MjQu
NDg3ODE4IGNsb3NlKDMpICAgICAgICAgICAgICAgID0gMAo+Pgo+Pj4gMTE6NDM6MjQuNDg5NTA4
IG9wZW5hdChBVF9GRENXRCwgIi9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6MDA6MWQuMC9jb25m
aWciLCBPX1JET05MWSkgPSAzCj4+PiAxMTo0MzoyNC40ODk1OTggcHJlYWQ2NCgzLCAiXDIwNlwy
MDBcMjYwXDIzNVw3XDRcMjBcMFwzNjBcMFw0XDZcMjBcMFwyMDFcMFwwXDBcMFwwXDBcMFwwXDBc
MDs7XDAwMDAwXDAgIFwzNTQgXDM1NFwxXDMwMFwyMVwzMjBcMFwwXDBcMFwwXDBcMFwwXDBcMFww
XDAKPj4+IEBcMFwwXDBcMFwwXDBcMFwzNzdcMVwyMlwwIiwgNjQsIDApID0gNjQKPj4+IDExOjQz
OjI0Ljk2NjY2MSBjbG9zZSgzKSAgICAgICAgICAgICAgICA9IDAKPj4KPj4+IDExOjQzOjI0Ljk4
ODU0NCBvcGVuYXQoQVRfRkRDV0QsICIvc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDAwOjNiOjAwLjAv
Y29uZmlnIiwgT19SRE9OTFkpID0gMwo+Pj4gMTE6NDM6MjQuOTg4NTg0IHByZWFkNjQoMywgIlwy
XDIwXDIwNWlcN1w0XDIwXDBcMFwwXDIwMFwzXDIwXDBcMFwwXGZcMFwwXDMwMFwwXDBcMFwwXGZc
MFwwXDMyMFwwXDBcMFwwXDAwMTBcMFwwXDBcMCBcMzU0XDBcMFwwXDAoXDIwXDI3MlwxMFwwXDAk
XDM1NEhcMFwwXDBcMFwwXDBcMFwzNzdcMVwwXDAiLCA2NCwgMCkgPSA2NAo+Pj4gMTE6NDM6MjUu
MjUyNzQ1IGNsb3NlKDMpCj4+Cj4+IFVuZm9ydHVuYXRlbHksIEkgZm9yZ290IHRvIGNvbGxlY3Qg
dGhlIHRyZWUgb3V0cHV0LCBidXQgaG9wZWZ1bGx5IHRoZQo+PiBhdHRhY2hlZCBMaW51eCBtZXNz
YWdlcyBhbmQgc3RyYWNlIG9mIGxzcGNpIG91dHB1dCB3aWxsIGJlIGVub3VnaCBmb3IgdGhlCj4+
IHN0YXJ0Lgo+Pgo+PiBQbGVhc2UgdGVsbCBtZSwgaWYgeW91IHdhbnQgbWUgdG8gY3JlYXRlIGEg
YnVnIHJlcG9ydCBpbiB0aGUgTGludXggYnVnCj4+IHRyYWNrZXIuCj4gCj4gQ2FuIHlvdSB0cnkg
dGhpcyBjb21taXQ/Cj4gCj4gICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvaGVsZ2Fhcy9wY2kuZ2l0L2NvbW1pdC8/aD1wY2kvcG0maWQ9ZWM0MTFlMDJi
N2EyZTc4NWE0ZWQ5ZWQyODMyMDdjZDE0ZjQ4Njk5ZAo+IAo+IEl0IHNob3VsZCBiZSBpbiB0aGUg
bWFpbmxpbmUgYWxyZWFkeSBhcyB3ZWxsLgo+IAo+IE5vdGUgd2Ugc3RpbGwgbmVlZCB0byBvYmV5
IHRoZSBkZWxheXMgcmVxdWlyZWQgYnkgdGhlIFBDSWUgc3BlYyBzbyAxMDBtcwo+IGFmdGVyIHRo
ZSBsaW5rIGlzIHRyYWluZWQgYnV0IHRoaXMgb25lIHNob3VsZCBhdCBsZWFzdCBnZXQgaXQgZG93
biBmcm9tCj4gMTEwMG1zLgoKVGhhbmsgeW91IGZvciByZXBseWluZyBzbyBxdWlja2x5LiBIb3Bl
ZnVsbHksIEnigJlsbCBiZSBhYmxlIHRvIHRlc3QgdGhlIApjb21taXQgdG9tb3Jyb3cuCgpPbmUg
cXVlc3Rpb24gdGhvdWdoLiBUaGUgY29tbWl0IHRhbGtzIGFib3V0IHJlc3VtaW5nIGZyb20gc3Vz
cGVuZC4gSSAKdW5kZXJzdGFuZCB0aGF0IHRyYWluaW5nIGhhcHBlbnMgdGhlcmUuCgpJbiBteSBj
YXNlIHRoZSBzeXN0ZW0gaXMgYWxyZWFkeSBydW5uaW5nLiBTbyBJIHdvbmRlciwgd2h5IGxpbmso
PykgCnRyYWluaW5nIHdvdWxkIHN0aWxsIGhhcHBlbmluZy4KCgpLaW5kIHJlZ2FyZHMsCgpQYXVs
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
