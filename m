Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68AACA1012
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 03:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441B910EB08;
	Fri,  5 Sep 2025 03:37:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bs+I3w7K";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FFF810EB08
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 03:37:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 886656028D;
 Fri,  5 Sep 2025 03:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF831C4CEF0;
 Fri,  5 Sep 2025 03:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757043440;
 bh=qDMa9X6Wx1ECm965Ub5bQzx0/N8bNtKkU2Lb4vmsAqw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bs+I3w7KCnRrNudEHppfA6CsHhWkFi6B/13Yx2szUibuo99BAWoz+vFfRV1EdorcL
 rqtT5TGDGvnlNdQ3ThiIOPRxmxgfpoB2FlaHtwdPqu+ooj3xDWKrM1Ddm0dCTU+NFj
 4C5zmgyi2Dj8RnNJX2kIayrfnDhOzNWtZ7TzHLgK6gVL50JKes2Sm0ObQVtuIdpZnF
 i+ZRfv/yztrPHllEuxmcRHgfONGwAjSDyv0xree/UJubWtG03keoTmX4brm5D5jjYN
 oI/IAJfp2USgdOipgeQ3uWBMlJayVJmORs3Ar3cnLTZN7J3A7pzUDcAAmn+aPH51NY
 9DPKhgZksLhbg==
Message-ID: <1cea0d56-7739-4ad9-bf8e-c9330faea2bb@kernel.org>
Date: Thu, 4 Sep 2025 22:37:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMD HDMI/DP audio broken after suspend since commit
 50e0bae34fa6
To: =?UTF-8?Q?Przemys=C5=82aw_Kopa?= <prz.kopa@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <967d5380-1db1-4252-a3b5-cfa283cf960d@gmail.com>
 <637bdb82-ca3b-4e11-8c59-d8fc75e6837e@kernel.org>
 <6fd5d5e1-2f4a-4640-a88b-8fc66bf54f75@gmail.com>
 <b033c364-476f-4cdd-8823-2a3bbddd9de4@kernel.org>
 <48206da8-c4a6-4b66-bcc9-7599fc891342@gmail.com>
 <13cba029-8c3d-48df-9f76-8b2ed0fff85d@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <13cba029-8c3d-48df-9f76-8b2ed0fff85d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/4/2025 8:03 AM, Przemysław Kopa wrote:
>> I'm attaching two new dmesg logs.
> 
> Sorry, I attached wrong files to my previous message. The proper ones 
> are attached to this one.

I'm guessing what's going on is a race between the HDMI device going to 
D3 through snd-hda-intel (which provides HDMI) and the prepare() callback.

The easiest solution will be to drop the prepare() and complete() 
callbacks, but I will need to think about this because we had a variety 
of reasons for adding them.

Have a try with this diff on 6.17-rc4.

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a0ca3b2c6bd8..d83aeeaf5653 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3127,25 +3127,6 @@ static void dm_destroy_cached_state(struct 
amdgpu_device *adev)
         dm->cached_state = NULL;
  }

-static void dm_complete(struct amdgpu_ip_block *ip_block)
-{
-       struct amdgpu_device *adev = ip_block->adev;
-
-       dm_destroy_cached_state(adev);
-}
-
-static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
-{
-       struct amdgpu_device *adev = ip_block->adev;
-
-       if (amdgpu_in_reset(adev))
-               return 0;
-
-       WARN_ON(adev->dm.cached_state);
-
-       return dm_cache_state(adev);
-}
-
  static int dm_suspend(struct amdgpu_ip_block *ip_block)
  {
         struct amdgpu_device *adev = ip_block->adev;
@@ -3571,10 +3552,8 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
         .early_fini = amdgpu_dm_early_fini,
         .hw_init = dm_hw_init,
         .hw_fini = dm_hw_fini,
-       .prepare_suspend = dm_prepare_suspend,
         .suspend = dm_suspend,
         .resume = dm_resume,
-       .complete = dm_complete,
         .is_idle = dm_is_idle,
         .wait_for_idle = dm_wait_for_idle,
         .check_soft_reset = dm_check_soft_reset,
