Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8D9C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 13:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD20613CA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 13:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD20613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 195C86EBAA;
	Wed, 12 May 2021 13:08:02 +0000 (UTC)
X-Greylist: delayed 455 seconds by postgrey-1.36 at gabe;
 Wed, 12 May 2021 09:44:27 UTC
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690CF6E1E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 09:44:27 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0bb800ec6923be2c5225a4.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0b:b800:ec69:23be:2c52:25a4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14A8B1EC01A2;
 Wed, 12 May 2021 11:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1620812210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=hVRfoW6q3II9JG/6HLWRqbnxdKNbxvXXpRAJyxfapS8=;
 b=ZCQo4h0sRBxJjafwgw8J6wplzIEy5Th06Y9CH1rhhNpsfRHd8Wnctnq2KLE7I0yriftw4d
 cxhj3iz80M8ggj6pfIvTAa7gN5GHig0nS5YGHskTDgzN+0iw+42ZWXlRhG6MpIuIAs4bQf
 bOPrJ2p1ETqQe5Mc5r4To6lHlxWdGH4=
Date: Wed, 12 May 2021 11:36:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mukul Joshi <mukul.joshi@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <YJuhs1WsqtJ7ta1L@zn.tnic>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210512013058.6827-1-mukul.joshi@amd.com>
X-Mailman-Approved-At: Wed, 12 May 2021 13:07:59 +0000
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
Cc: x86-ml <x86@kernel.org>, harish.kasiviswanathan@amd.com,
 lkml <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

so this is a drive-by review using the lore.kernel.org mail because I
wasn't CCed on this.

On Tue, May 11, 2021 at 09:30:58PM -0400, Mukul Joshi wrote:
> +static int amdgpu_bad_page_notifier(struct notifier_block *nb,
> +				    unsigned long val, void *data)
> +{
> +	struct mce *m = (struct mce *)data;
> +	struct amdgpu_device *adev = NULL;
> +	uint32_t gpu_id = 0;
> +	uint32_t umc_inst = 0;
> +	uint32_t chan_index = 0;
> +	struct ras_err_data err_data = {0, 0, 0, NULL};
> +	struct eeprom_table_record err_rec;
> +	uint64_t retired_page;
> +
> +	/*
> +	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,

Why does it matter if the error is a v2 UMC generated one?

IOW, can you detect the type of errors in GPU memory - I assume this
is what this is supposed to handle - from the error signature itself
instead of doing is_smca_umc_v2?

> +	 * and error occurred in DramECC (Extended error code = 0) then only
> +	 * process the error, else bail out.
> +	 */
> +	if (!m || !(is_smca_umc_v2(m->bank) && (XEC(m->status, 0x1f) == 0x0)))
> +		return NOTIFY_DONE;
> +
> +	gpu_id = GET_MCA_IPID_GPUID(m->ipid);
> +
> +	/*
> +	 * GPU Id is offset by GPU_ID_OFFSET in MCA_IPID_UMC register.
> +	 */
> +	gpu_id -= GPU_ID_OFFSET;
> +
> +	adev = find_adev(gpu_id);
> +	if (!adev) {
> +		dev_warn(adev->dev, "%s: Unable to find adev for gpu_id: %d\n",
> +				     __func__, gpu_id);
> +		return NOTIFY_DONE;
> +	}
> +
> +	/*
> +	 * If it is correctable error, then print a message and return.
> +	 */
> +	if (mce_is_correctable(m)) {
> +		dev_info(adev->dev, "%s: UMC Correctable error detected.",
> +				    __func__);

So put yourself in the shoes of a support engineer who starts getting
all those calls about people's hardware getting correctable errors and
should they replace it and should AMD RMA the GPUs and so on and so
on..? Do you really wanna be on the receiving side of that call?

IOW, whom does printing the fact that the GPU had a corrected error
which got corrected by the hardware, help and do you really want to
upset people needlessly?

> +		return NOTIFY_OK;
> +	}
> +
> +	/*
> +	 * If it is uncorrectable error, then find out UMC instance and
> +	 * channel index.
> +	 */
> +	find_umc_inst_chan_index(m, &umc_inst, &chan_index);

That's a void function but it could return a pointer to the instance and
channel bundled in a struct maybe...

> +
> +	dev_info(adev->dev, "Uncorrectable error detected in UMC inst: %d,"
> +			    " chan_idx: %d", umc_inst, chan_index);
> +
> +	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
> +
> +	/*
> +	 * Translate UMC channel address to Physical address
> +	 */
> +	retired_page = ADDR_OF_8KB_BLOCK(m->addr) |
> +			ADDR_OF_256B_BLOCK(chan_index) |
> +			OFFSET_IN_256B_BLOCK(m->addr);
> +
> +	err_rec.address = m->addr;
> +	err_rec.retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
> +	err_rec.ts = (uint64_t)ktime_get_real_seconds();
> +	err_rec.err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
> +	err_rec.cu = 0;
> +	err_rec.mem_channel = chan_index;
> +	err_rec.mcumc_id = umc_inst;
> +
> +	err_data.err_addr = &err_rec;
> +	err_data.err_addr_cnt = 1;
> +
> +	if (amdgpu_bad_page_threshold != 0) {
> +		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
> +						err_data.err_addr_cnt);
> +		amdgpu_ras_save_bad_pages(adev);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block amdgpu_bad_page_nb = {
> +	.notifier_call  = amdgpu_bad_page_notifier,
> +	.priority       = MCE_PRIO_ACCEL,

Nothing ever explains why this needs to be a separate priority. So how
about it?

> +};
> +
> +static void amdgpu_register_bad_pages_mca_notifier(void)
> +{
> +	/*
> +	 * Register the x86 notifier with MCE subsystem.
> +	 * Please note a notifier can be registered only once
> +	 * with the MCE subsystem.
> +	 */

Why do you need this? Other users don't need that. Do you need to call
mce_unregister_decode_chain() when the driver gets removed or so?

> +	if (notifier_registered == false) {

This is just silly and should be fixed properly once the issue is
understood.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
