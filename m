Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A0FC388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 13:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF872223C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 13:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF872223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B366E2ED;
	Fri, 13 Nov 2020 13:22:52 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95A56E2ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:22:51 +0000 (UTC)
Date: Fri, 13 Nov 2020 13:22:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1605273769;
 bh=PvE6oETp6RUTmf1oNs+4BdISDIrioU2Lx6HD9WfxxXg=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=gtDIgsWkaYz+Irk31QgFkPiCT2e1mEGt8OfYeaZ78kN0OGWzqR2ecte7plmxA0US4
 VGB6evH6h6zHcwY+YbxTCd14THlx+WaKoRHcy5bNFXG8oMQJeGUfiupvkoaythergO
 m2oUt8uHn2fxo6U8Ra+eSdbOvowoAPJk1YqvxmweSl3lD8UZB0TbVvpqAdLPoelpDA
 SA59biY8ELBn5Lkiuyj9Cnt48+pY+Pibj5uJ/tOA+jAlBYJ2gS+uUaa9wxUtLSXpTy
 FqweDE/c0G8O4Kc8aWE2qtziyhnvccoUApq+DR8liumdRZ0fGn537Ecs/md9AEztIA
 gQ6zQf5bNO37w==
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: add cursor pitch check
Message-ID: <oQKMxarb-CrP5YVk0cKDylHKjPfAM1grdifggNPWvKzSD0jMDMh23vwFyGPEe5Tlyv3HxKTs3ivkh3UlbJUeevD8QuqFWAc5kxunFM-sCjk=@emersion.fr>
In-Reply-To: <b4abedc5-676f-4f15-578c-4f5dfa318302@amd.com>
References: <dM9UpdTNt3rJxagA8swvzv6sXdjID2x67yd3tJg6A@cp4-web-030.plabs.ch>
 <d791cc9f-7aa5-b453-992d-1f0cf0f2a905@amd.com>
 <VvOH2mNsO3Zn9gYXOa0Vn7kKqb2MvC0MKJXONCsmsnVcPaN6dJdxoGIboXdhy4oIf147mLuUC6KejFj5TOgDisty73bUPnvds0sXL-Fp52s=@emersion.fr>
 <CADnq5_NbfqgHPWfd5+Z0au+T1rcVV_QbJAeWd9ChMK4mFOS-xw@mail.gmail.com>
 <b4abedc5-676f-4f15-578c-4f5dfa318302@amd.com>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexdeucher@gmail.com>, Harry Wentland <hwentlan@amd.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SG1tLiBJJ3ZlIHdyaXR0ZW4gbmV3IHBhdGNoZXMgdG8gY2hlY2sgdGhlIHJlbWFpbmluZyBwbGFu
ZSBzdGF0ZSBbMV0sCmJ1dCBJJ20gY29uZnVzZWQuIE9uIG15IFJYIDU4MCBtYWNoaW5lLCBpdCB0
dXJucyBvdXQgdGhlIHBpdGNoIHVzZWQgYnkKbXkgY3Vyc29yIGlzIG5vdCAxMjggb3IgMjU2LCBp
dCdzIDUxMi4gSGVyZSdzIGEgZHJtX2luZm8gZXhjZXJwdDoKCiAgICDilJzilIDilIDilIBEUk1f
Q0FQX0NVUlNPUl9XSURUSCA9IDEyOAogICAg4pSc4pSA4pSA4pSARFJNX0NBUF9DVVJTT1JfSEVJ
R0hUID0gMTI4CiAgICBb4oCmXQogICAg4pSc4pSA4pSA4pSAUGxhbmUgNgogICAg4pSCICAg4pSc
4pSA4pSA4pSAT2JqZWN0IElEOiA1MgogICAg4pSCICAg4pSc4pSA4pSA4pSAQ1JUQ3M6IHswfQog
ICAg4pSCICAg4pSc4pSA4pSA4pSARm9ybWF0czoKICAgIOKUgiAgIOKUgiAgIOKUlOKUgOKUgOKU
gEFSR0I4ODg4ICgweDM0MzI1MjQxKQogICAg4pSCICAg4pSU4pSA4pSA4pSAUHJvcGVydGllcwog
ICAg4pSCICAgICAgIOKUnOKUgOKUgOKUgCJ0eXBlIiAoaW1tdXRhYmxlKTogZW51bSB7T3Zlcmxh
eSwgUHJpbWFyeSwgQ3Vyc29yfSA9IEN1cnNvcgogICAg4pSCICAgICAgIOKUnOKUgOKUgOKUgCJG
Ql9JRCIgKGF0b21pYyk6IG9iamVjdCBmcmFtZWJ1ZmZlciA9IDEwNgogICAg4pSCICAgICAgIOKU
giAgIOKUnOKUgOKUgOKUgE9iamVjdCBJRDogMTA2CiAgICDilIIgICAgICAg4pSCICAg4pSc4pSA
4pSA4pSAU2l6ZTogMTI4eDEyOAogICAg4pSCICAgICAgIOKUgiAgIOKUnOKUgOKUgOKUgEZvcm1h
dDogQVJHQjg4ODggKDB4MzQzMjUyNDEpCiAgICDilIIgICAgICAg4pSCICAg4pSU4pSA4pSA4pSA
UGxhbmVzOgogICAg4pSCICAgICAgIOKUgiAgICAgICDilJTilIDilIDilIBQbGFuZSAwOiBvZmZz
ZXQgPSAwLCBwaXRjaCA9IDUxMgogICAg4pSCICAgICAgIOKUnOKUgOKUgOKUgCJJTl9GRU5DRV9G
RCIgKGF0b21pYyk6IHNyYW5nZSBbLTEsIElOVDMyX01BWF0gPSAtMQogICAg4pSCICAgICAgIOKU
nOKUgOKUgOKUgCJDUlRDX0lEIiAoYXRvbWljKTogb2JqZWN0IENSVEMgPSA1NAogICAg4pSCICAg
ICAgIOKUnOKUgOKUgOKUgCJDUlRDX1giIChhdG9taWMpOiBzcmFuZ2UgW0lOVDMyX01JTiwgSU5U
MzJfTUFYXSA9IDc5MgogICAg4pSCICAgICAgIOKUnOKUgOKUgOKUgCJDUlRDX1kiIChhdG9taWMp
OiBzcmFuZ2UgW0lOVDMyX01JTiwgSU5UMzJfTUFYXSA9IDEzMDIKICAgIOKUgiAgICAgICDilJzi
lIDilIDilIAiQ1JUQ19XIiAoYXRvbWljKTogcmFuZ2UgWzAsIElOVDMyX01BWF0gPSAxMjgKICAg
IOKUgiAgICAgICDilJzilIDilIDilIAiQ1JUQ19IIiAoYXRvbWljKTogcmFuZ2UgWzAsIElOVDMy
X01BWF0gPSAxMjgKICAgIOKUgiAgICAgICDilJzilIDilIDilIAiU1JDX1giIChhdG9taWMpOiBy
YW5nZSBbMCwgVUlOVDMyX01BWF0gPSAwCiAgICDilIIgICAgICAg4pSc4pSA4pSA4pSAIlNSQ19Z
IiAoYXRvbWljKTogcmFuZ2UgWzAsIFVJTlQzMl9NQVhdID0gMAogICAg4pSCICAgICAgIOKUnOKU
gOKUgOKUgCJTUkNfVyIgKGF0b21pYyk6IHJhbmdlIFswLCBVSU5UMzJfTUFYXSA9IDEyOAogICAg
4pSCICAgICAgIOKUnOKUgOKUgOKUgCJTUkNfSCIgKGF0b21pYyk6IHJhbmdlIFswLCBVSU5UMzJf
TUFYXSA9IDEyOAoKSG93ZXZlciB0aGUgY3Vyc29yIGlzIGRpc3BsYXllZCBqdXN0IGZpbmUuIEl0
IHNlZW1zIGxpa2UgYW1kZ3B1IHNldHMKZGNfY3Vyc29yX2F0dHJpYnV0ZXMucGl0Y2ggdG8gdGhl
IEZCIHdpZHRoIGluIGhhbmRsZV9jdXJzb3JfdXBkYXRlOgoKICAgIGF0dHJpYnV0ZXMucGl0Y2gg
PSBhdHRyaWJ1dGVzLndpZHRoOwoKSXMgdGhpcyBleHBlY3RlZD8gRGlkIEkgZ2V0IHRoZSBjdXJz
b3IgcGl0Y2ggY29uc3RyYWludCB3cm9uZz8gU2hvdWxkCndlIGNoZWNrIGZvciBhbGlnbm1lbnQg
aW5zdGVhZD8KClRoYW5rcywKClNpbW9uCgpbMV06IGh0dHBzOi8vZ2l0aHViLmNvbS9lbWVyc2lv
bi9saW51eC9jb21taXRzL2FtZGdwdS1jdXJzb3ItcGl0Y2gKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
