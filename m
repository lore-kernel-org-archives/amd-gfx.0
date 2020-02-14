Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2871C47409
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 23:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9B32081E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 23:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="raLSWtEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9B32081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232326E898;
	Fri, 14 Feb 2020 23:59:53 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92FFF6E890;
 Fri, 14 Feb 2020 23:59:51 +0000 (UTC)
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 039B2206B6;
 Fri, 14 Feb 2020 23:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581724791;
 bh=kdcvtJLmnTtzWUQS0+tFQbmbizzUANyG9omQMu4DSRo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=raLSWtEZHlFlaXAJTM8RqjpN+mb5UJy42NT1cOjfH8kY9ByeF2ZLivS+3qfWn8S9q
 QZJEkNTe/0RXnJJI8sUxzmXpTLb0DbZPpn5i+ONXTK7FNmWA5EMb4rJh5GzSaG2AZf
 Qf0F5A52NVjAD/3qlr5/TB+G9r9XeaIed7r6V9SM=
Date: Fri, 14 Feb 2020 18:59:49 -0500
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL 5.5 155/542] drm/amdkfd: remove set but not used
 variable 'top_dev'
Message-ID: <20200214235949.GG1734@sasha-vm>
References: <20200214154854.6746-1-sashal@kernel.org>
 <20200214154854.6746-155-sashal@kernel.org>
 <20200214214429.GA4193448@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200214214429.GA4193448@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: dri-devel@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 14, 2020 at 04:44:29PM -0500, Greg KH wrote:
>On Fri, Feb 14, 2020 at 10:42:27AM -0500, Sasha Levin wrote:
>> From: zhengbin <zhengbin13@huawei.com>
>>
>> [ Upstream commit d191bd678153307573d615bb42da4fcca19fe477 ]
>>
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/gpu/drm/amd/amdkfd/kfd_iommu.c: In function kfd_iommu_device_init:
>> drivers/gpu/drm/amd/amdkfd/kfd_iommu.c:65:30: warning: variable top_dev set but not used [-Wunused-but-set-variable]
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 1ae99eab34f9 ("drm/amdkfd: Initialize HSA_CAP_ATS_PRESENT capability in topology codes")
>> Signed-off-by: zhengbin <zhengbin13@huawei.com>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c | 3 ---
>>  1 file changed, 3 deletions(-)
>
>Unless all of these "unused bt set variable" patches are needed for
>"real" fixes, there's no need to add them here as we are NOT building
>the kernel with that option enabled any time soon from what I can tell.
>
>So you can drop a ton of these patches from all of these AUTOSEL
>branches please.

Sigh, I confused the -Wno-unused-but-set-variable flag we pass in the
makefile with -Wunused-but-set-variable. Sorry about all this noise,
I'll drop it.

-- 
Thanks,
Sasha
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
