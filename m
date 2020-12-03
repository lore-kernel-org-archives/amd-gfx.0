Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251F6C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 20:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A339E221E3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 20:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A339E221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94ADE6E038;
	Thu,  3 Dec 2020 20:28:41 +0000 (UTC)
Received: from mail1.protonmail.ch (mail1.protonmail.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFEC66E038
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Dec 2020 20:28:39 +0000 (UTC)
Date: Thu, 03 Dec 2020 20:28:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1607027317;
 bh=D0gu4gLaYdgM5VrPtQab+8eLHfH9iaHV6EMeZxjk8eM=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=QY8bsNPMKDRjDDyLZFLbfNni3RVyj2xa6v82ezykPcrvDA0x4rdOLW28F2SjXUtWD
 0scjDHwwYXikxlwA9LOB4nCiuwaSc53gaQmHafvngM2h7wGMYkm1THSvL5RgVPDOdG
 98ooIGdiaeGWK4yjpA/aF9fnD/LswGK78nbdbis43Nw1J0LJ5vSUT7roDPTYJAM1DN
 f4bBX5+9ohLS5jBPv2OdLK/m4MuRt/akaFouMfkq/7IxMEdO/mpwlQKbxBuma5D6u8
 O5KQKwfswoO0aplVUnUOm8BfPVpl19gYe8yT5mqUEjHK5CCUXlBS/yF41uNnoGgL+l
 wa+rOMErm7KSA==
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 2/2] drm/amd/display: check cursor FB is linear
Message-ID: <dXWjBvTa1TVgePFCm7EW_zG2cykVljoxePhdVUd38fXrdi7kwWUyH6wer0-_ogpZmbzx3xFZaPYqt4cqUvvmajdhr54WZwgDv3Xvubswwsw=@emersion.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As a side note, here is the hw I used for testing:

- GFX8: AMD RX580
- GFX9: AMD Ryzen 5 3500U APU

Tried both Sway (modifier-aware) and gamescope (not modifier-aware).
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
