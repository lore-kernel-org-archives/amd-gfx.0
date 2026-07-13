Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6563DC44509
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB4B10EC7E;
	Tue, 14 Jul 2026 08:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=squebb.ca header.i=@squebb.ca header.b="ZOrtxssr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IGj23SL7";
	dkim-atps=neutral
X-Greylist: delayed 518 seconds by postgrey-1.36 at gabe;
 Mon, 13 Jul 2026 21:41:26 UTC
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D6010E179
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 21:41:26 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D4B8814000B8;
 Mon, 13 Jul 2026 17:32:47 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
 by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 17:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1783978367;
 x=1784064767; bh=YVO66dwtkD3NeXv09l5YFuW1pV0F3oSa91ho8hTgCMI=; b=
 ZOrtxssrNRAQeS4x3vGLvQxIy3HtmkrTyWecyAkLolbkpgjwa7iWlXEQkusOsKZJ
 fb0ftaU6Le0yhQJGrPLo4r9uuU8/n9cqk+3oG7SlllMfYCSbLnxM2htjuAfiJD/B
 sU1i2O2G43nyZIIRhEQZ+mcxk/0UMw1leEog9yDyor/w6bXCzBHAqPIMKSSRiXJc
 BxKBkVC+iKVMgSLQFYMpzInq9I9258VSTXCcAsXGp3RdgZxpmRpHfXVzFVIqDY/G
 my3mLzt2N6Bm6Bkh6nphkmCPiVHmvY2PSqs/1VlbfltkLadbqMtpVMiPIqzW4jlh
 bAso1YrOjRLaZkpnYB25WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783978367; x=
 1784064767; bh=YVO66dwtkD3NeXv09l5YFuW1pV0F3oSa91ho8hTgCMI=; b=I
 Gj23SL7SJuT+DJP5714qJvOuXjXcUb4fZJNqtz6zYW91VKvMShjjWSgcqQONIUwY
 UBhkvPLJmQ2gLbfWFavD66ODq0XcgeX6h0kD8YZNgYB3rU4OpBSST1sFiDfVx+HO
 6y6e1GhisXI2YtZV2Wqg1cR6Sl3YRwJIDZPKn5VFHbh2HylARmVyxPVcDAgYKq6m
 nLkWmxPfxy3T/jP6OfmTOkqM0AX5C+CZ+LfhKkhmu3j+QiKBmVFYUHnY1WkOt7ln
 CkG9F73SiyQdbqO3wFCiC325gTHY1KvMKAK0+L3e55dV4DJChGVhCYkyi8M4NnGL
 6RcZehzfriEN0BCf04wjw==
X-ME-Sender: <xms:f1lVauz4pPVy_YJlhEjjaoJK3CQZ-eUnNAp8430A127p8Wf-IRRrjw>
 <xme:f1lValHYAMwzuK5ltOqGrH-YnXodTQqjApiyLeG9e7vMvCFOXbCISOHKWwV5oTn3l
 dEqazElEPvitRFg6gpRAA-T4eH6hgZLzvFipIfofHtnjN2ZQX0WxH3z>
X-ME-Proxy-Cause: dmFkZTE0rk0j3tbkAwY1sHMHywWc+HsGZY4JGfo+NzNBq2hFUDqN6fJlBIsbk0laOsE2p+
 PTDN+qfOKugSNVspnMApKwpMtyqAX7vg9B+sKnFIZcgZvnz81BwVDN+cUEE5Vq4ygZgATg
 f/9L6w14ZN60n7YoATkQsTtNTFzmvhAuWxNVBRe1TDKMzCHpb0E8cXizCjFSqs01iXAc7Y
 Ab/5zc/D6xkbgSiQHXzdBPyp701a2Lbo1y4zMga465xd7U3XWuLMHY49sYI76wtG/tzMbZ
 QcXvZaqvknfRSh/C0gLA9BptchJflNBQac8hMf2xalDH0fJlIXKr998IsqgQcTN+mx07Qi
 rsolYJ8dPGhdJHRIF8iGnuIe8jSKQ8UtgULGi9KKTdnnZqDS4ZESD0+QqC1IQuKSMkJSeQ
 dFtT0doyFvdWJNvSi5Gr863K0tyQtzcKUWdBIkZi9Wbf6XTtEhG25EjhIbmxZqk2EqyHAy
 oAThKwM6qGOf1wxykTT/ioiTz18kgcG96DRjwoEEP6u1eFCcAMJ8Yzb40N34LaPLQtPUg2
 33PthTZ3v3MMxmsLyn70BMhHyp9n+Nszo0rh+S1fiwrNpdjAVn++XaFhN2XLDDXyk+ByiR
 +z0L1FNwTp2NgXjHxH+S0/5xfF2xwzXW1jQF8Hd8yBWonv9nl7tsV4uQT/Dg
X-ME-Proxy: <xmx:f1lVatbdCvPG0NWkxyjFLcAESwndtwn4lU-zz9Ra39e7UADkTtGS6w>
 <xmx:f1lVaiPGVi0oQUR0qVvr0vDbcnVOYvZxVElAblTgP_wrRnITIU__Vw>
 <xmx:f1lVaqYEe_PC5OUmFbpAo8MUIxn0QK6YmRCX0hnCuVACtMybdLK5PA>
 <xmx:f1lVao1sLL1MV2-HiaTFUroOpeRI1J3D7mDYTgfBKZ69O2a3zWJntQ>
 <xmx:f1lVakOLK6ZtONS89IKtOHbaDq-qY8Y91F-v0NtrqZj1P6N4C_ij1WKM>
Feedback-ID: ic2b14614:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 4E4BF2CE03BD; Mon, 13 Jul 2026 17:32:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: APXOgOBcCE4N
Date: Mon, 13 Jul 2026 17:32:27 -0400
From: "Mark Pearson" <mpearson@squebb.ca>
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: "Aaron Ma" <aaron.ma@canonical.com>, mrh@frame.work
Message-Id: <e3883839-e431-4ad1-aa01-b8b96c089e29@app.fastmail.com>
In-Reply-To: <20260713195313.1739762-1-mario.limonciello@amd.com>
References: <20260713195313.1739762-1-mario.limonciello@amd.com>
Subject: Re: [PATCH] drm/amd: Create a device link between APU display and
 XHCI devices
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 14 Jul 2026 08:29:45 +0000
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

Thanks Mario

On Mon, Jul 13, 2026, at 3:53 PM, Mario Limonciello wrote:
> Some AMD APU multi-function devices expose an integrated USB xHCI
> controller. In some circumstances (such as larger VRAM), the PM core
> can resume can fail when the xHCI controller is resuming in parallel
> with the GPU/display function.

Minor: extra 'can' in there (before 'resume').

>
> On affected systems, the xHCI controller can complete pci_pm_resume
> and start resuming USB devices while the GPU is still in its much
> longer resume path. This race condition leads to USB device resume
> failures followed by:
>
>   xhci_hcd ...: xHCI host not responding to stop endpoint command
>   xhci_hcd ...: HC died; cleaning up
>
> Create a device link from any xHCI controller sharing the same PCIe
> root port as the APU display function. The link uses DL_FLAG_STATELESS
> and DL_FLAG_PM_RUNTIME to ensure the GPU completes its resume before
> the xHCI controller begins resuming USB devices.
>
> This device link is done specifically in amdgpu so that if the
> platform firmware has been modified such that this issue doesn't happen
> the version can be detected and the workaround skipped.
>
> Suggested-by: Aaron Ma <aaron.ma@canonical.com>
> Reported-by: mrh@frame.work
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221073
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 +++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 11 +++++
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 45 +++++++++++++++++++
>  3 files changed, 68 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 4314dff4ac996..c1ceec7a1986b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1366,6 +1366,14 @@ static void smu_feature_cap_init(struct 
> smu_context *smu)
>  	bitmap_zero(fea_cap->cap_map, SMU_FEATURE_CAP_ID__COUNT);
>  }
> 
> +static int smu_set_power_dep(struct smu_context *smu, bool enable)
> +{
> +	if (!smu->ppt_funcs->set_power_dep)
> +		return 0;
> +
> +	return smu->ppt_funcs->set_power_dep(smu, enable);
> +}
> +
>  static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -1427,6 +1435,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (!smu->ppt_funcs->get_fan_control_mode)
>  		smu->adev->pm.no_fan = true;
> 
> +	smu_set_power_dep(smu, true);
> +
>  	return 0;
>  }
> 
> @@ -1449,6 +1459,8 @@ static int smu_sw_fini(struct amdgpu_ip_block *ip_block)
> 
>  	smu_fini_microcode(smu);
> 
> +	smu_set_power_dep(smu, false);
> +
>  	return 0;
>  }
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h 
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index f8fd93999617d..7ea7c4a5279be 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -749,6 +749,9 @@ struct smu_context {
>  	bool pm_enabled;
>  	bool is_apu;
> 
> +	/* Power dependency link from an integrated xHCI controller to the GPU */
> +	struct device_link		*usb_power_link;
> +
>  	uint32_t smc_driver_if_version;
>  	uint32_t smc_fw_if_version;
>  	uint32_t smc_fw_version;
> @@ -1618,6 +1621,14 @@ struct pptable_funcs {
>  	 */
>  	int (*ras_send_msg)(struct smu_context *smu,
>  			    enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
> +
> +	/**
> +	 * @set_power_dep: Create or destroy a power dependency link
> +	 * from an integrated xHCI controller to the GPU so that the GPU is
> +	 * resumed before the USB controller during PM resume. @enable is true
> +	 * to create the link and false to tear it down.
> +	 */
> +	int (*set_power_dep)(struct smu_context *smu, bool enable);
>  };
> 
>  typedef enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c 
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 2fe006de927a3..2abdfef8644e0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1701,6 +1701,50 @@ static int 
> smu_v14_0_0_restore_user_od_settings(struct smu_context *smu)
>  	return 0;
>  }
> 
> +/*
> + * Link any xHCI controller sharing the GPU's PCIe root port as a 
> consumer
> + * of the GPU so the GPU resumes first, avoiding an xHCI resume race.
> + */
> +static int smu_v14_0_0_set_power_dep(struct smu_context *smu, bool 
> enable)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	struct pci_dev *gpu_pdev = adev->pdev;
> +	struct pci_dev *root_port, *usb_pdev = NULL;
> +	struct device_link *link;
> +
> +	if (!enable) {
> +		if (smu->usb_power_link) {
> +			device_link_del(smu->usb_power_link);
> +			smu->usb_power_link = NULL;
> +		}
> +		return 0;
> +	}
> +
> +	root_port = pcie_find_root_port(gpu_pdev);
> +	while ((usb_pdev = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, 
> usb_pdev))) {
> +		struct pci_dev *usb_root;
> +
> +		usb_root = pcie_find_root_port(usb_pdev);
> +		if (usb_root != root_port)
> +			continue;
> +
> +		/* Create device link: USB (consumer) depends on GPU (supplier) */
> +		link = device_link_add(&usb_pdev->dev, &gpu_pdev->dev,
> +				       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
> +		if (link) {
> +			smu->usb_power_link = link;
> +			drm_info(adev_to_drm(adev), "USB controller %s D0 power state 
> depends on %s\n",
> +				 pci_name(usb_pdev), pci_name(gpu_pdev));
> +			/* Only create one link for the first USB controller found */
> +			break;
> +		}
> +	}
> +
> +	pci_dev_put(usb_pdev);
> +
> +	return 0;
> +}
> +
>  static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
>  	.check_fw_status = smu_v14_0_check_fw_status,
>  	.check_fw_version = smu_cmn_check_fw_version,
> @@ -1734,6 +1778,7 @@ static const struct pptable_funcs 
> smu_v14_0_0_ppt_funcs = {
>  	.dpm_set_umsch_mm_enable = smu_v14_0_0_set_umsch_mm_enable,
>  	.get_dpm_clock_table = smu_v14_0_common_get_dpm_table,
>  	.set_mall_enable = smu_v14_0_common_set_mall_enable,
> +	.set_power_dep = smu_v14_0_0_set_power_dep,
>  };
> 
>  static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
> -- 
> 2.43.0

Tested on my T14 G7 AMD platform and confirmed it fixes the issue (which I am able to easily reproduce otherwise).

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
