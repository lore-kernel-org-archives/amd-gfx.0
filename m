Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABC0CCD199
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 17:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D0210E499;
	Mon, 20 Oct 2025 17:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WcSnKK4i";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD39610E498;
 Mon, 20 Oct 2025 17:28:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8390E448C0;
 Mon, 20 Oct 2025 17:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D63C4CEF9;
 Mon, 20 Oct 2025 17:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760981318;
 bh=XoBtTVIfyCks+3vvS0y9uJAoDlapnqVQpQnuzzSfF34=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WcSnKK4iDS6gPA+JCDA/Z1VumuFkDT4duTisGd1ZPAtcbjeztp7eAmEx6CxakyzNo
 lDKwiRz/S6EPF9pYjk+RBRtiKxE5JdH+cfaOPqFd5MrGoCGsjmlDEoQ0KFgv9jLT/5
 NRnESVeL2/kBb9s6u9ITQ36EKBP6gg6J0NnDHAXlQFb6hwZREmu336yBqWAoi41O+h
 jH2Je8EZ1tOoA0VOw0acAmyWKtOUMNUH7qaM/8+QyMK5FGVhOHY5Bu35km62417HZG
 2NaXyg6/3tkPI1joejAKNBJLCE+Lpji1QQ/U9eRX4etPmUzWQnr17rpRZSJCmzILfT
 Z/1VrmtoO4/Mw==
Message-ID: <85c039ef-e189-48c1-8bf7-50ac0c2484e2@kernel.org>
Date: Mon, 20 Oct 2025 12:28:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on
 success
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org,
 lenb@kernel.org, pavel@kernel.org, simona@ffwll.ch,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org
References: <20251020165317.3992933-1-superm1@kernel.org>
 <20251020165317.3992933-4-superm1@kernel.org>
 <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com>
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



On 10/20/2025 12:21 PM, Rafael J. Wysocki wrote:
> On Mon, Oct 20, 2025 at 6:53 PM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> The PM core should be notified that thaw was skipped for the device
>> so that if it's tried to be resumed (such as an aborted hibernate)
>> that it gets another chance to resume.
>>
>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 61268aa82df4d..d40af069f24dd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
>>
>>          /* do not resume device if it's normal hibernation */
>>          if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
>> -               return 0;
>> +               return -EBUSY;
> 
> So that's why you need the special handling of -EBUSY in the previous patch.

Yup.

> 
> I think that you need to save some state in this driver and then use
> it in subsequent callbacks instead of hacking the core to do what you
> want.
> 

The problem is the core decides "what" to call and more importantly 
"when" to call it.

IE if the core thinks that something is thawed it will never call 
resume, and that's why you end up in a bad place with Muhammad's 
cancellation series and why I proposed this one to discuss.

We could obviously go back to dropping this case entirely:

if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())

But then the display turns on at thaw(), you do an unnecessary resource 
eviction, it takes a lot longer if you have a ton of VRAM etc.

