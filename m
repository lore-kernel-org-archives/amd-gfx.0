Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDE2C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 11:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B09224BD
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 11:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B09224BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F62A89FED;
	Mon, 11 Jan 2021 11:57:57 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B72B89FED
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:57:56 +0000 (UTC)
Received: from [192.168.0.6] (ip5f5aeab5.dynamic.kabel-deutschland.de
 [95.90.234.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 13074206446A2;
 Mon, 11 Jan 2021 12:57:53 +0100 (CET)
Subject: Re: [PATCH] drm/amdgpu: enable gpu recovery for navy_flounder
To: Jiansong Chen <Jiansong.Chen@amd.com>
References: <20210111094938.2764-1-Jiansong.Chen@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <ea359d1f-169a-7b93-94aa-8bcaf38cef39@molgen.mpg.de>
Date: Mon, 11 Jan 2021 12:57:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111094938.2764-1-Jiansong.Chen@amd.com>
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

RGVhciBKaWFuc29uZywKCgpBbSAxMS4wMS4yMSB1bSAxMDo0OSBzY2hyaWViIEppYW5zb25nIENo
ZW46Cj4gRW5hYmxlIGdwdSByZWNvdmVyeSBmb3IgbmF2eV9mbG91bmRlciBieSBkZWZhdWx0IHRv
IHRyaWdnZXIKPiByZXNldCBvbmNlIG5lZWRlZC4KClvigKZdCgpXaHkgd2FzIGl0IGRpc2FibGVk
IGJlZm9yZT8gV2VyZSBzb21lIGJ1Z3MgZml4ZWQsIHRoYXQgaXQgd29ya3Mgbm93PwoKSG93IGRp
ZCB5b3UgdGVzdCB0aGlzPyBJcyB0aGVyZSBhIGNvbW1hbmQgdG8g4oCcY3Jhc2jigJwgdGhlIEdQ
VSwgc28gaXQgY2FuIApiZSByZWNvdmVyZWQ/CgpQbGVhc2UgZXh0ZW5kIHRoZSBjb21taXQgbWVz
c2FnZSBhY2NvcmRpbmdseS4KCgpLaW5kIHJlZ2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
