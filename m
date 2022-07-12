Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F63C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 14:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E99262BB4A;
	Tue, 12 Jul 2022 14:29:02 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97AC592749
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1r5cKoCBLeY0U9MbeMCCSehvKkBFp3u8ycBh8EdISHg=; b=GIo2HdTw7m+kJmUDy9En0Ewqtu
 50tkaj0fz5L0Bug3hqwkd6tI07vLN5l3CnyJRLXg8vx+8bwAEHuw/Qk8zKXvhDZr7BnrEVGbRE+iA
 1UZwvf4tu9od273xSo/b1NdLti4UK4bgtJcZTPd8K52UKu2cjFqr5GQmKsOTvCqg9gZjiXCEXW+Mm
 jvMVW582IxkhJqr8KMfu1n143W8VC3n7trdIiLkoaa7sNekU8MU55ubgswjswO0c+9H8iP9fRq+62
 o4F8vEZjveskgjNZD09oGT2/AONuiUDpNSVD1N7eyrEs3mWX8tB7bzURKWC0wirQZGDOpxxc0v2wn
 8FQvGmhg==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oBGsk-00DdfU-UY; Tue, 12 Jul 2022 16:28:59 +0200
Message-ID: <9aa983a2-ba63-77c8-e530-8f6ed6d32463@igalia.com>
Date: Tue, 12 Jul 2022 11:28:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/pm: Prevent divide by zero
Content-Language: en-US
To: Yefim Barashkin <mr.b34r@kolabnow.com>
References: <20220712020106.46730-1-mr.b34r@kolabnow.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220712020106.46730-1-mr.b34r@kolabnow.com>
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Às 23:01 de 11/07/22, Yefim Barashkin escreveu:
> divide error: 0000 [#1] SMP PTI
> CPU: 3 PID: 78925 Comm: tee Not tainted 5.15.50-1-lts #1
> Hardware name: MSI MS-7A59/Z270 SLI PLUS (MS-7A59), BIOS 1.90 01/30/2018
> RIP: 0010:smu_v11_0_set_fan_speed_rpm+0x11/0x110 [amdgpu]
> 
> Speed is user-configurable through a file.
> I accidentally set it to zero, and the driver crashed.
> 
> Signed-off-by: Yefim Barashkin <mr.b34r@kolabnow.com>
> ---


Reviewed-by: André Almeida <andrealmeid@igalia.com>



Minor nit, I would write this commit message like this:

Speed is user-configurable through a file. I accidentally set it to
zero, and the driver crashed:

divide error: 0000 [#1] SMP PTI
CPU: 3 PID: 78925 Comm: tee Not tainted 5.15.50-1-lts #1
Hardware name: MSI MS-7A59/Z270 SLI PLUS (MS-7A59), BIOS 1.90 01/30/2018
RIP: 0010:smu_v11_0_set_fan_speed_rpm+0x11/0x110 [amdgpu]

Fix that by checking user input value.
