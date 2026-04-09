Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ED4E99050
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD7AD10E8DD;
	Fri, 10 Apr 2026 07:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=nppct.ru header.i=@nppct.ru header.b="otQ+y9zR";
	dkim-atps=neutral
X-Greylist: delayed 451 seconds by postgrey-1.36 at gabe;
 Thu, 09 Apr 2026 18:16:49 UTC
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B898210E057
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 18:16:49 +0000 (UTC)
Received: from mail.nppct.ru (localhost [127.0.0.1])
 by mail.nppct.ru (Postfix) with ESMTP id 380F01C2529
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 21:09:14 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:content-language:subject:subject:references:to
 :user-agent:mime-version:date:date:message-id; s=dkim; t=
 1775758153; x=1776622154; bh=Z6VJas5O1TGJ28DeGbupUhtgkajrhZGcBwA
 fc4PV2gg=; b=otQ+y9zRzciI3m6FByq2z8/Rz7WeYnPoz6yAj7h1hTW8v+BhK6r
 k7YCfYPbFbS6RdtbRmfbNYDniFdz91JTcy0SG4TCIkFtc37HvABQWEQoe6Gy6baA
 XJbSoG7kFMc+c3wkhUaS1OZbnPIxQGhwY0Qx5eEhnOFTEVTI/RqWFGv8=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
 by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id AQJMt7NnFCI4 for <amd-gfx@lists.freedesktop.org>;
 Thu,  9 Apr 2026 21:09:13 +0300 (MSK)
Received: from [192.168.1.67] (unknown [95.221.18.101])
 by mail.nppct.ru (Postfix) with ESMTPSA id 88C341C060C;
 Thu,  9 Apr 2026 21:09:12 +0300 (MSK)
Message-ID: <bfcff656-9b76-482d-941c-ee0e8da6d05d@nppct.ru>
Date: Thu, 9 Apr 2026 21:09:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: benjamin.cheng@amd.com
Cc: David.Wu3@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, leo.liu@amd.com,
 ruijing.dong@amd.com, lvc-project@linuxtesting.org
References: <20260326122918.3486416-4-benjamin.cheng@amd.com>
Subject: Re: [PATCH v2 2/4] drm/amdgpu/vcn3: Prevent OOB reads when parsing
 dec msg
Content-Language: ru
From: SDL <sdl@nppct.ru>
In-Reply-To: <20260326122918.3486416-4-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:07:32 +0000
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

Hi, Benjamin,

I'm working on a related fix for 'vcn_v3_0_dec_msg()' that you might
want to be aware of. In you update bounds check:

     if (size < 4 || offset + size > end - addr)

the 'offset' and 'size' fields in the VCN decode message buffer are
both u32 values sourced from userspace. The check performs 32-bit
arithmetic before comparison against the 64-bit 'end' value, allowing
a crafted message with offset=0xffffffff and size=1 to wrap around
to 0 and bypass the bounds check.

Fix this by cast 'offset' to u64 before the addition so the
comparison is done in 64-bit arithmetic.

Best regards,
Alexey Nepomnyashih

