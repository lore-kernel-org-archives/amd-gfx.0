Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E88ACAC5B9
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 14:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C032110E0A8;
	Fri, 26 Sep 2025 14:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d5ZFMrV5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC4210E0A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 14:12:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 11E3461DF5;
 Fri, 26 Sep 2025 14:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A58C4CEF4;
 Fri, 26 Sep 2025 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758895958;
 bh=J3DpS5kZB6XptQTvvt2hoOfcWCkqxGjjmHDYrY3f++8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d5ZFMrV5mmjd4kVyQWI9YEeUlgWKYv0i0vEaPUlgjX/pHOLTOeZMrwRJI5QaCan77
 VDQY9kEW98Nl8yhmQYJHjfbUZSoSS1yNvfU96YPuyMqWDZg7kPnYm67YVFcglyG+jV
 JbvlQYm53XmbcTOmYTZw68SILW9XH5gMkkhZtXp5/+SvaxYNUJGgSjNT35SFszF74c
 Ra7j6lVLCPQDG8OiSflW0Vaq8zhPeVjbakhM1qL5kJkGFKaRqFgUzE9Co/eQLiLwiF
 l0qBDxetCTA3CcaLbkMHerAZD0o06TuH+pk6zmqWAKQbMyc3UNI4jh/9RkgBno3RN8
 gLttuh7y+ZHLQ==
Message-ID: <a1a6170e-2d91-4678-9147-6cb3fe534c93@kernel.org>
Date: Fri, 26 Sep 2025 09:12:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: hibernate: Fix pm_hibernation_mode_is_suspend()
 build breakage
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ionut Nechita
 <ionut_n2001@yahoo.com>, Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Crudup <kenny@panix.com>, amd-gfx@lists.freedesktop.org
References: <12746883.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <12746883.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/26/25 6:10 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 495c8d35035e ("PM: hibernate: Add pm_hibernation_mode_is_suspend()")
> that introduced pm_hibernation_mode_is_suspend() did not define it in
> the case when CONFIG_HIBERNATION is unset, but CONFIG_SUSPEND is set.
> 
> Subsequent commit 0a6e9e098fcc ("drm/amd: Fix hybrid sleep") made the
> amdgpu driver use that function which led to kernel build breakage in
> the case mentioned above [1].
> 
> Address this by using appropriate #ifdeffery aroung the definition of
> pm_hibernation_mode_is_suspend().
> 
> Fixes: 0a6e9e098fcc ("drm/amd: Fix hybrid sleep")
> Reported-by: KernelCI bot <bot@kernelci.org>
> Closes: https://groups.io/g/kernelci-results/topic/regression_pm_testing/115439919 [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   include/linux/suspend.h |    8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -276,7 +276,6 @@ extern void arch_suspend_enable_irqs(voi
>   
>   extern int pm_suspend(suspend_state_t state);
>   extern bool sync_on_suspend_enabled;
> -bool pm_hibernation_mode_is_suspend(void);
>   #else /* !CONFIG_SUSPEND */
>   #define suspend_valid_only_mem	NULL
>   
> @@ -289,7 +288,6 @@ static inline bool pm_suspend_via_firmwa
>   static inline bool pm_resume_via_firmware(void) { return false; }
>   static inline bool pm_suspend_no_platform(void) { return false; }
>   static inline bool pm_suspend_default_s2idle(void) { return false; }
> -static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
>   
>   static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
>   static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
> @@ -420,6 +418,12 @@ static inline int hibernate_quiet_exec(i
>   }
>   #endif /* CONFIG_HIBERNATION */
>   
> +#if defined(CONFIG_HIBERNATION) && defined(CONFIG_SUSPEND)
> +bool pm_hibernation_mode_is_suspend(void);
> +#else
> +static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
> +#endif
> +
>   int arch_resume_nosmt(void);
>   
>   #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
> 
> 
> 

