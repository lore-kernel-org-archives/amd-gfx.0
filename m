Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCC0C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 13:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7777A20738
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 13:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7777A20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC3D6E0DF;
	Mon, 13 Jul 2020 13:10:04 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4F16E0DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 13:10:03 +0000 (UTC)
Received: from [192.168.178.35] (unknown [88.130.155.162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 588D9206442E2;
 Mon, 13 Jul 2020 15:10:00 +0200 (CEST)
Subject: Re: [PATCH v2] drm/amdgpu: fix system hang issue during GPU reset
To: Dennis Li <Dennis.Li@amd.com>
References: <20200708074800.10093-1-Dennis.Li@amd.com>
 <b398cbc4-7dfa-c5de-e806-492e08f2da37@molgen.mpg.de>
 <DM5PR12MB2533EF1CF7F4AC2D83DCC2DDED650@DM5PR12MB2533.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Message-ID: <8cc739a2-b0ab-1423-b3d2-a823217ae168@molgen.mpg.de>
Date: Mon, 13 Jul 2020 15:10:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB2533EF1CF7F4AC2D83DCC2DDED650@DM5PR12MB2533.namprd12.prod.outlook.com>
Content-Language: en-US
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
Cc: Alex Deucher <alexdeucher@gmail.com>, Tao Zhou <Tao.Zhou1@amd.com>,
 amd-gfx@lists.freedesktop.org, Guchun Chen <Guchun.Chen@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBEZW5uaXMsCgoKQW0gMTAuMDcuMjAgdW0gMTA6Mzkgc2NocmllYiBMaSwgRGVubmlzOgoK
PiBJIHVzZWQgb3VyIGludGVybmFsIHRvb2wgdG8gbWFrZSBHUFUgaGFuZyBhbmQgZG8gc3RyZXNz
IHRlc3QuCgpJbnRlcmVzdGluZy4gSSB3YW50IHRvIGhhdmUgc3VjaCBhIHRvb2wuIDstKQoKU28g
eW91IG5vdGljZWQgaXQgZHVyaW5nIHRlc3Rpbmcgd2l0aCB0aGF0IHRvb2wsIGFuZCBub3QgYnkg
c29tZWJvZHkgCmV4cGVyaWVuY2luZyB0aGlzIGluIHByb2R1Y3Rpb24/Cgo+IEluIGtlcm5lbCwg
d2hlbiBHUFUgaGFuZywgZHJpdmVyIGhhcyBtdWx0aS1wYXRocyB0byBlbnRlciAKPiBhbWRncHVf
ZGV2aWNlX2dwdV9yZWNvdmVyLCB0aGUgIGF0b21pYyAgYWRldi0+aW5fZ3B1X3Jlc2V0IGlzIHVz
ZWQKPiB0byBhdm9pZCByZS1lbnRlcmluZyBHUFUgcmVjb3ZlcnkuIER1cmluZyBHUFUgcmVzZXQg
YW5kIHJlc3VtZSwgaXQKPiBpcyB1bnNhZmUgdGhhdCBvdGhlciB0aHJlYWRzIGFjY2VzcyBHUFUs
IHdoaWNoIG1heWJlIGNhdXNlIEdQVSByZXNldCAKPiBmYWlsZWQuIFRoZXJlZm9yZSB0aGUgbmV3
IHJ3X3NlbWFwaG9yZSAgYWRldi0+cmVzZXRfc2VtIGlzIAo+IGludHJvZHVjZWQsIHdoaWNoIHBy
b3RlY3QgR1BVIGZyb20gYmVpbmcgYWNjZXNzZWQgYnkgZXh0ZXJuYWwKPiB0aHJlYWRzIHdoZW4g
ZG9pbmcgcmVjb3ZlcnkuCgpUaGFuayB5b3UgZm9yIHRoZSBleHBsYW5hdGlvbi4gSXTigJlkIGJl
IGdyZWF0IGlmIHlvdSBhZGRlZCB0aGlzIHRvIHRoZQpjb21taXQgbWVzc2FnZS4KCgpLaW5kIHJl
Z2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
