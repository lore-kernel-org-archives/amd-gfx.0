Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC38DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 16:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8789060527
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 16:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8789060527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1806E838;
	Tue, 26 Oct 2021 16:11:27 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 575526E838
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 16:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id B380720201B;
 Tue, 26 Oct 2021 18:11:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 7fVm64PDgUUQ; Tue, 26 Oct 2021 18:11:25 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 4404820201A;
 Tue, 26 Oct 2021 18:11:25 +0200 (CEST)
Received: from [127.0.0.1] by thor with esmtp (Exim 4.95)
 (envelope-from <michel@daenzer.net>) id 1mfP2q-000fWq-Te;
 Tue, 26 Oct 2021 18:11:24 +0200
Message-ID: <71deb3f1-4f46-43a7-98e8-99879d231dd4@daenzer.net>
Date: Tue, 26 Oct 2021 18:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-CA
To: Simon Ser <contact@emersion.fr>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc: Stylon Wang <stylon.wang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com
References: <20211026110740.152936-1-stylon.wang@amd.com>
 <0087f1c6-733e-4c31-63c5-c39da51138c1@daenzer.net>
 <b29f5d0e-a0d4-2a2c-d9ee-6e16541b9906@amd.com>
 <P81H3ot388-2r8h9f2D4jqbP7eys1TKtvXWTwXkgEWslTv6PcsQObN_hSX6KaH_MMkhscnt4TFF6B11fqho5Yd2a3q_qS-AUog7vaaylVrA=@emersion.fr>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amd/display: Fix error handling on waiting for
 completion
In-Reply-To: <P81H3ot388-2r8h9f2D4jqbP7eys1TKtvXWTwXkgEWslTv6PcsQObN_hSX6KaH_MMkhscnt4TFF6B11fqho5Yd2a3q_qS-AUog7vaaylVrA=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-10-26 18:08, Simon Ser wrote:
> On Tuesday, October 26th, 2021 at 18:03, Kazlauskas, Nicholas <nicholas.kazlauskas@amd.com> wrote:
> 
>> If it's just an error in the log without a functional issue then maybe
>> we should downgrade it to a debug statement in the case where it returns
>> -ERESTARTSYS.
>>
>> If this is a functional issue (DRM not automatically retrying the
>> commit?) then maybe we should take a deeper look into the IOCTL itself.
> 
> libdrm handles EINTR but not ERESTARTSYS. So, if the kernel returns ERESTARTSYS
> then Mutter will error out.
> 
> Should the kernel be fixed to return EINTR instead of ERESTARTSYS, or should
> libdrm be fixed to handle ERESTARTSYS?

The kernel is supposed to convert ERESTARTSYS to EINTR when returning to user space (when the kernel can't restart the system call itself), so user space doesn't need to handle the former.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
