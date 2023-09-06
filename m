Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88621EB8FD2
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 13:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C56310E64F;
	Wed,  6 Sep 2023 13:25:07 +0000 (UTC)
Received: from out-214.mta0.migadu.com (out-214.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::d6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494DE10E570
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 04:14:15 +0000 (UTC)
Message-ID: <eccd1d51-68f5-2bd8-890e-6d7c422abce6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1693973653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReUbfyeD3q8qKsZb9bv3mQc4hrhuGmFA0TdHPFwtCxA=;
 b=v516R8djVSQGBsC8dKVonWQw8LG8OnWSMj1zPxIIlXE12/9RexGW4MGevXucxjR0rNJrmV
 3BtBSLSs7/GM22h6yWJqwC6ViryP4klO1hhy4Sx/M0r1YrJ5F0rWpvqi2nfUBshaG1o+Kr
 NPnzupOYzec1IsJJ9tzGoxXDJhFy538=
Date: Wed, 6 Sep 2023 12:14:01 +0800
MIME-Version: 1.0
Subject: Re: [Nouveau] [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user
 to select the primary video adapter at boot time
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>,
 suijingfeng <suijingfeng@loongson.cn>, Bjorn Helgaas <bhelgaas@google.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <44ec8549-dc36-287e-4359-abd3ec8d22d6@suse.de>
 <5afd2efb-f838-f9b7-02a9-2cf4d4fd2382@loongson.cn>
 <773be4c6-0b3d-be39-7857-b3e2942007d9@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <773be4c6-0b3d-be39-7857-b3e2942007d9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 06 Sep 2023 13:25:05 +0000
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
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 2023/9/5 23:05, Thomas Zimmermann wrote:
> You might have found a bug in the ast driver. Ast has means to detect 
> if the device has been POSTed and maybe do that. If this doesn't work 
> correctly, it needs a fix.
>
That sounds fine.

The bug is not a big deal, I'm just take it as an example and report it to you.
But a real fix can be complex, because there are quite a lot of servers
ship with ASpeed BMC hardware.

Honestly I don't have the time fix it on formal way.
I have already tons patches in pending and I will focus on solve VGAARB related problem.


Because I want to test your patch occasionally.
So this series is useful for myself at corner cases.

