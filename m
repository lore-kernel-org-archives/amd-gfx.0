Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 07:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4CD60F9F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 07:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B4CD60F9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1496EB1B;
	Tue, 19 Oct 2021 07:23:36 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8410B6EB1B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 07:23:35 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef98.dynamic.kabel-deutschland.de
 [95.90.239.152])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6675761E5FE00;
 Tue, 19 Oct 2021 09:23:33 +0200 (CEST)
Subject: Re: [PATCH 0/5] Remove 0 MHz as a valid current frequency (v4)
To: Luben Tuikov <luben.tuikov@amd.com>
References: <20211018234913.42349-1-luben.tuikov@amd.com>
Cc: amd-gfx@lists.freedesktop.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <a653a699-69a9-9671-4bfd-e02f3d22fc2f@molgen.mpg.de>
Date: Tue, 19 Oct 2021 09:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211018234913.42349-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dear Luben,


Sorry, two more style nits.

1.  Could you please use 75 characters per line for the text width of 
the commit messages. Currently, especially 4/5, are hard to read being 
so short.

2.  No idea, what is done in amd-gfx, but for me it is more common to 
put the iteration number (reroll count) in the PATCH tag in the 
beginning. No idea, how Patchwork deals with it.


Kind regards,

Paul
