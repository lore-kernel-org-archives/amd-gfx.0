Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B62C54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 13:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173E510E905;
	Thu, 26 Jan 2023 13:56:58 +0000 (UTC)
X-Greylist: delayed 600 seconds by postgrey-1.36 at gabe;
 Thu, 26 Jan 2023 10:56:43 UTC
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20EC10E2BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 10:56:43 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4P2cp53NNMz9sSm;
 Thu, 26 Jan 2023 11:46:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espindo.la; s=MBO0001; 
 t=1674729997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxhZh3hJF4hylpVAxVI3gLKcRWRw/KJhGWahEaNDrDM=;
 b=MsvlwEo5xlZc/F/kMf6QBvwXsUWGroBW5iom9q9vEtz35aXvXr64gegxgCEJ+gh0csG5kt
 BAIAGWhpUqWYwuzjLH+9ZqMmhpZZWREVeZXX9lbOR/bzSB/e+CKG+vjU0vHEI9ll/8MZ2o
 MXQFqHub0qLtIF3WYHC13jj3NLEUQ5QI32yNODh7Onr6DeDSlL//AriIJdhc9QtuQaD9Ej
 Ddv0hk1p6RHYmivK4e+HLrq2t3yD/Es6JdYHOOkN816o6ugt40sxcX4dQ/XL9SblwYTzjQ
 i702KikF2B3r0wGvjmRixiR5MMzGoRHTYLrVebwHVAnGr+z3BSxzrAUFgExQJg==
From: Rafael =?utf-8?Q?=C3=81vila?= de =?utf-8?Q?Esp=C3=ADndola?=
 <rafael@espindo.la>
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd: Allow s0ix without BIOS support
In-Reply-To: <20230125183339.15664-1-mario.limonciello@amd.com>
References: <20230125183339.15664-1-mario.limonciello@amd.com>
Date: Thu, 26 Jan 2023 09:46:34 -0100
Message-ID: <87ilgtshdh.fsf@espindo.la>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 26 Jan 2023 13:56:56 +0000
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mario Limonciello <mario.limonciello@amd.com> writes:

> We guard the suspend entry code from running unless we have proper
> BIOS support for either S3 mode or s0ix mode.
>
> If a user's system doesn't support either of these modes the kernel
> still does offer s2idle in `/sys/power/mem_sleep` so there is an
> expectation from users that it works even if the power consumption
> remains very high.
>
> Rafael =C3=81vila de Esp=C3=ADndola reports that a system of his has a
> non-functional graphics stack after resuming.  That system doesn't
> support S3 and the FADT doesn't indicate support for low power idle.
>
> Through some experimentation it was concluded that even without the
> hardware s0i3 support provided by the amd_pmc driver the power
> consumption over suspend is decreased by running amdgpu's s0ix
> suspend routine.
>
> The numbers over suspend showed:
> * No patch: 9.2W
> * Skip amdgpu suspend entirely: 10.5W
> * Run amdgpu s0ix routine: 7.7W
>
> As this does improve the power, remove some of the guard rails in
> `amdgpu_acpi.c` for only running s0ix suspend routines in the right
> circumstances.
>
> However if this turns out to cause regressions for anyone, we should
> revert this change and instead opt for skipping suspend/resume routines
> entirely or try to fix the underlying behavior that makes graphics fail
> after resume without underlying platform support.
>
> Reported-by: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2364
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>

I have tested this patch on a Gigabyte B550I AORUS PRO AX with a 4350G
and can confirm that the errors are gone and the power consumption during
suspend is down to 7.7 W.

Thanks,
Rafael


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 57b5e11446c65..fa7375b97fd47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1079,20 +1079,16 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_dev=
ice *adev)
>  	 * S0ix even though the system is suspending to idle, so return false
>  	 * in that case.
>  	 */
> -	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> +	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
>  		dev_warn_once(adev->dev,
>  			      "Power consumption will be higher as BIOS has not been configur=
ed for suspend-to-idle.\n"
>  			      "To use suspend-to-idle change the sleep mode in BIOS setup.\n"=
);
> -		return false;
> -	}
>=20=20
>  #if !IS_ENABLED(CONFIG_AMD_PMC)
>  	dev_warn_once(adev->dev,
>  		      "Power consumption will be higher as the kernel has not been com=
piled with CONFIG_AMD_PMC.\n");
> -	return false;
> -#else
> -	return true;
>  #endif /* CONFIG_AMD_PMC */
> +	return true;
>  }
>=20=20
>  #endif /* CONFIG_SUSPEND */
> --=20
> 2.25.1
