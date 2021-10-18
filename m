Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9209C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 22:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424E060F25
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 22:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 424E060F25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26C96EA79;
	Mon, 18 Oct 2021 22:52:07 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE5096EA79
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 22:52:06 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae8cf.dynamic.kabel-deutschland.de
 [95.90.232.207])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id DCB9961E5FE33;
 Tue, 19 Oct 2021 00:52:04 +0200 (CEST)
Subject: Re: [PATCH 1/5] drm/amd/pm: Slight function rename
To: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <20211013031042.53540-2-luben.tuikov@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <580a9f54-1cbc-27b0-f5d8-05db2180b69a@molgen.mpg.de>
Date: Tue, 19 Oct 2021 00:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211013031042.53540-2-luben.tuikov@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

Dear Luben,


Am 13.10.21 um 05:10 schrieb Luben Tuikov:

[…]

A small nit regarding the subject. It’d be great if you made it a 
statement by adding a verb (in imperative mood). git standard messages 
are doing the same with *Merge …* and *Revert …*.


Kind regards,

Paul
