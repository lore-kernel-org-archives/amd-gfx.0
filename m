Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E34EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 10:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5534610E599;
	Thu, 20 Jul 2023 10:23:21 +0000 (UTC)
Received: from out-13.mta0.migadu.com (out-13.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA3C10E58C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 09:17:47 +0000 (UTC)
Message-ID: <5c91b8dd-5342-0eb2-aef4-dbb865d6dfda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1689844665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twWOXbWYEQiWDLte803PU4TQyX4ZqCM5632vlvyl10U=;
 b=DB4eeuEjhTPCPJI9o1K6etLTAH2GlZQ2jKXZfEFtglosq8nta+hFXp6Q19BwC13rtbePUk
 4Xqaig9i/B8Qj2QmJCTE40PIJtYSpL9nzXN3Fq/R/yxGavRbtAQmKtatqPuKqCmNMKb0uF
 SIeyywuFj8e2ghKEwpEuU+vXBHjeWk8=
Date: Thu, 20 Jul 2023 17:17:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/9] PCI/VGA: Improve the default VGA device selection
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20230719193241.GA510805@bhelgaas>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20230719193241.GA510805@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Thu, 20 Jul 2023 10:23:18 +0000
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
Cc: linux-fbdev@vger.kernel.org, Sui Jingfeng <suijingfeng@loongson.cn>,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 2023/7/20 03:32, Bjorn Helgaas wrote:
>>    drm/amdgpu: Implement the is_primary_gpu callback of
>>      vga_client_register()
>>    drm/radeon: Add an implement for the is_primary_gpu function callback
>>    drm/i915: Add an implement for the is_primary_gpu hook
>>    drm/ast: Register as a vga client to vgaarb by calling
>>      vga_client_register()
>>    drm/loongson: Add an implement for the is_primary_gpu function
>>      callback
> There's unnecessary variation in the subject lines (and the commit
> logs) of these patches.  If they all do the same thing but in
> different drivers, it's useful if the patches all*look*  the same.
>
> You might be able to write these subjects as
> "Implement .is_primary_gpu() callback" for brevity.


This is a very good suggestion, I will adopt this.

Thanks, really.

