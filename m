Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A210C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 13:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FA061100
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 13:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7FA061100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0507A6EBA0;
	Wed, 22 Sep 2021 13:08:50 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF0236EB80
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 11:40:37 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0efa008ea00e11d58cbc58.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0e:fa00:8ea0:e11:d58c:bc58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D7F71EC051E;
 Wed, 22 Sep 2021 13:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1632310832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=tei5VEk46/vgxQtg8qR60le/A/E3Os9/MyCI0V+1IWU=;
 b=erym6u3FYSc9xDzK/+A4ZS9nnNujVrv0n6pr3LTIz1VQqWyfdOS7zCQEXU9nOOami+kKSz
 SWdbJndsJ/z5rhu8bjtGOSGmpiLbjaDYuQqcDlUBFlZlpBj6G2MIcvGZvoHtQp4BycYgH/
 Ml7ZBpoiU5pw2FWxHqjBs8+VzsVmZzg=
Date: Wed, 22 Sep 2021 13:40:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mukul Joshi <mukul.joshi@amd.com>
Cc: linux-edac@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
 yazen.ghannam@amd.com, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCHv2 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Message-ID: <YUsWLw1gSD/AQbcH@zn.tnic>
References: <20210511152538.148084-2-nchatrad@amd.com>
 <20210913021311.12896-1-mukul.joshi@amd.com>
 <20210913021311.12896-2-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913021311.12896-2-mukul.joshi@amd.com>
X-Mailman-Approved-At: Wed, 22 Sep 2021 13:08:45 +0000
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

On Sun, Sep 12, 2021 at 10:13:11PM -0400, Mukul Joshi wrote:
> On Aldebaran, GPU driver will handle bad page retirement
> even though UMC is host managed. As a result, register a
> bad page retirement handler on the mce notifier chain to
> retire bad pages on Aldebaran.
> 
> v1->v2:
> - Use smca_get_bank_type() to determine MCA bank.
> - Envelope the changes under #ifdef CONFIG_X86_MCE_AMD.
> - Use MCE_PRIORITY_UC instead of MCE_PRIO_ACCEL as we are
>   only handling uncorrectable errors.
> - Use macros to determine UMC instance and channel instance
>   where the uncorrectable error occured.
> - Update the headline.

Same note as for the previous patch.

> +static int amdgpu_bad_page_notifier(struct notifier_block *nb,
> +				    unsigned long val, void *data)
> +{
> +	struct mce *m = (struct mce *)data;
> +	struct amdgpu_device *adev = NULL;
> +	uint32_t gpu_id = 0;
> +	uint32_t umc_inst = 0;
> +	uint32_t ch_inst, channel_index = 0;
> +	struct ras_err_data err_data = {0, 0, 0, NULL};
> +	struct eeprom_table_record err_rec;
> +	uint64_t retired_page;
> +
> +	/*
> +	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
> +	 * and error occurred in DramECC (Extended error code = 0) then only
> +	 * process the error, else bail out.
> +	 */
> +	if (!m || !((smca_get_bank_type(m->bank) == SMCA_UMC_V2) &&
> +		    (XEC(m->status, 0x1f) == 0x0)))
> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * GPU Id is offset by GPU_ID_OFFSET in MCA_IPID_UMC register.
> +	 */
> +	gpu_id = GET_MCA_IPID_GPUID(m->ipid) - GPU_ID_OFFSET;
> +
> +	adev = find_adev(gpu_id);
> +	if (!adev) {
> +		dev_warn(adev->dev, "%s: Unable to find adev for gpu_id: %d\n",
> +				     __func__, gpu_id);
> +		return NOTIFY_DONE;
> +	}
> +
> +	/*
> +	 * If it is correctable error, return.
> +	 */
> +	if (mce_is_correctable(m)) {
> +		return NOTIFY_OK;
> +	}

This can run before you find_adev().

> +static void amdgpu_register_bad_pages_mca_notifier(void)
> +{
> +	/*
> +	 * Register the x86 notifier only once
> +	 * with MCE subsystem.
> +	 */
> +	if (notifier_registered == false) {
> +		mce_register_decode_chain(&amdgpu_bad_page_nb);
> +		notifier_registered = true;
> +	}

I have a patchset which will get rid of the need to do this silliness -
only if I had some time to actually prepare it for submission... :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
