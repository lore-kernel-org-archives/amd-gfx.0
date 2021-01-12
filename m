Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB65C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281EB22DFB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281EB22DFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49EA88F0A;
	Tue, 12 Jan 2021 09:20:45 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E72F88F0A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 09:20:44 +0000 (UTC)
Received: from [192.168.0.6] (ip5f5aed06.dynamic.kabel-deutschland.de
 [95.90.237.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D25C920645D76;
 Tue, 12 Jan 2021 10:20:42 +0100 (CET)
Subject: Re: [PATCH] drm/amdgpu: enable gpu recovery for navy_flounder
To: Jiansong Chen <Jiansong.Chen@amd.com>
References: <20210111094938.2764-1-Jiansong.Chen@amd.com>
 <ea359d1f-169a-7b93-94aa-8bcaf38cef39@molgen.mpg.de>
 <BY5PR12MB4885C09A5D21C96E7A175753EAAB0@BY5PR12MB4885.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <cd083b58-352e-efbf-4e30-ce04009600f4@molgen.mpg.de>
Date: Tue, 12 Jan 2021 10:20:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4885C09A5D21C96E7A175753EAAB0@BY5PR12MB4885.namprd12.prod.outlook.com>
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
Cc: Tao Zhou <Tao.Zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBKaWFuc29uZywKCgpBbSAxMS4wMS4yMSB1bSAxMzoyNiBzY2hyaWViIENoZW4sIEppYW5z
b25nIChTaW1vbik6Cj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1
dGlvbiBPbmx5XQoKKFdoYXQgZG9lcyB0aGlzIG5vdGljZSBtZWFuIGV4YWN0bHk/IFNob3VsZCBi
ZSByZW1vdmVkIGZvciBwdWJsaWMKbWFpbGluZyBsaXN0cy4pCgo+IFdlIGp1c3QgZW5hYmxlIGdw
dSByZWNvdmVyeSB3aGVuIHRoZSBmZWF0dXJlIGlzIHN0YWJsZSBlbm91Z2ggZm9yCj4gbmF2eV9m
bG91bmRlci4KClRoZW4gcGxlYXNlIG1lbnRpb24gdGhhdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2Uu
IFNvbWV0aGluZyBsaWtlOgoKID4gTm93IHRoYXQgR1BVIHJlY292ZXJ5IGlzIHN0YWJsZSBlbm91
Z2gsIOKApgoKPiBBbmQgeW91IGNhbiB1c2UgZGVidWdmcyBpbnRlcmZhY2UgdG8gcGVyZm9ybSBh
IG1hbnVhbAo+IEdQVSByZXNldC4gSGVyZSBpcyBtb3JlIGRldGFpbAo+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9SYWRlb25PcGVuQ29tcHV0ZS9ST0NtL2lzc3Vlcy82MTYuIFRoYW5rcyEKVGhhbmsgeW91
LiBJdCB3b3VsZCBzdGlsbCBiZSBuaWNlLCB0byBoYXZlIHRoaXMgaW5mb3JtYXRpb24gaW4gdGhl
IApjb21taXQgbWVzc2FnZS4KCgpLaW5kIHJlZ2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
