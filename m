Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432F4C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Dec 2022 18:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE4E10E32D;
	Tue, 27 Dec 2022 18:24:17 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7313410E167
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 18:24:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6BCFC611F6;
 Tue, 27 Dec 2022 18:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFEBC433EF;
 Tue, 27 Dec 2022 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672165420;
 bh=IhO1foa7/IRw1C0r4ahk6UohIRi0GNIRvoVzvl8vp9k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Zy+QGM+IHBNIgM1t7FJjt/XLIoO/4/T/GalTNokt/hAijAUYhj4TDw/mEB07deE0I
 ecny/hcEHftXNadef43wKovOHC0Qc3IMeiY8D5yrpp0WHDlO9UuAQNXK7xVjhK6LDT
 aam3jIDhfsHAwfT1I9rcLQB7W0zLzMyDtPJ6PhSSxzJEyGnOMXwVt2+6psOIHqPu2b
 GvqS1z7ZafI2prczxcwWmJ/+Eos2HitGsSpI6ulPSHZruy2zt9co644Zo97rgS0NG8
 ykjUykcejnXYYSwfQ1PI8IPIxTcQTT9F6W4T2rOPLlhzlyOnCni1F5Rq3MkQH6BOIM
 VdiQFwLTx5fJQ==
Date: Tue, 27 Dec 2022 12:23:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guchun Chen <guchun.chen@amd.com>
Subject: Re: [PATCH 1/3] drm/amd/pm/smu11: BACO is supported when it's in
 BACO state
Message-ID: <20221227182339.GA452254@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123014307.263178-1-guchun.chen@amd.com>
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
Cc: evan.quan@amd.com, linux-pci@vger.kernel.org, lijo.lazar@amd.com,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Stefan Roese <sr@denx.de>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[+cc Stefan, linux-pci]

On Wed, Nov 23, 2022 at 09:43:07AM +0800, Guchun Chen wrote:
> Return true early if ASIC is in BACO state already, no need
> to talk to SMU. It can fix the issue that driver was not
> calling BACO exit at all in runtime pm resume, and a timing
> issue leading to a PCI AER error happened eventually.

This sounds suspiciously racy.

> Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")

To clarify, this patch avoids a driver problem, not a problem with
8795e182b02d.

See question below.

> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 70b560737687..ad5f6a15a1d7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1588,6 +1588,10 @@ bool smu_v11_0_baco_is_support(struct smu_context *smu)
>  	if (amdgpu_sriov_vf(smu->adev) || !smu_baco->platform_support)
>  		return false;
>  
> +	/* return true if ASIC is in BACO state already */
> +	if (smu_v11_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
> +		return true;

smu_v13_0_baco_is_support() is essentially identical to
smu_v11_0_baco_is_support().  Does it need a similar change?

>  	/* Arcturus does not support this bit mask */
>  	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
>  	   !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
> -- 
> 2.25.1
> 
