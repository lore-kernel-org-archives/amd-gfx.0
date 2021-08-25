Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB49C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 15:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26390610E6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 15:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26390610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC9A6E2D8;
	Wed, 25 Aug 2021 15:01:14 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34D96E2D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 15:01:13 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id d26so16586054wrc.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=al7HCLB9LSLLnqo3CWlrKU8zPrqs3oHiPB4KUoujeUg=;
 b=FaNDmH5Ns9xt70QPLA0O4RQHlb0/IA+Mv1G+AjKENnP5i1OwW1X1Lcz2UsHfPqwzpH
 Fitlu0PrXlMzHfJcvQ25jiHUHoeJKgAqbENVQ1BvirHZSrmnGpY6VOdFerhGnuojyNBT
 QHoVuIaAG9aDk13bxVU8YbHt04KC1pyJlZMPUkbuhq0C/BJ2Qz/5TmsZwZrLczEp42sf
 PZ9rV3UYiXXL22Fn0aRXW2elniCFr8G1rpeUIVCJfccFBmE5Zp1KfWQmgNgaHR/91cXn
 ityq0SyoDMtt+zZT4Wzws+ZsPFCHxV0tlJzhA4l8g1quqc+KntyuWbMZnPn3Txs7OyPU
 r1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=al7HCLB9LSLLnqo3CWlrKU8zPrqs3oHiPB4KUoujeUg=;
 b=Db83F7Qz5niB0mGj4982YIAszJjrhQyxQhqLpu+U+qzv99JER/8BJt8XBrzJD0DOui
 3nznU7UlYHxZ5NR4iL9EVW7Ic+ZuFD79GAAA97bobFFii+GEEjbYKSev8XnFYEMD8BoS
 ++jMP8H6/NTJSsOd8nkeMLorpr50q/FBDCT8Cs4HbePk8zPq2SBaVqX3zKqakichWqq4
 mVRFMVblVdm/fxFoTvIyAkZkSLZo2eUPXu8B9EM3aQhryNk1/b3kiqO0If+fa7ZdU06z
 +A91NMVwpDZxCSBfcbaHhXpMCgGHe7SH4cu9G5/QmOffNDmLJucswEQz2nkmDEsMF046
 dilA==
X-Gm-Message-State: AOAM532WAzW2UT0WXtTMN98w/0bUBFKA39SfAP/5xe87vK+xyJoD9wn1
 oknmQk70NHYtEVHUWy7vKLoZ1qlSIY8=
X-Google-Smtp-Source: ABdhPJytJZ5wQDqc1QOFN71jeuPzVF7bpqydR61bWDDXqa3FbKkbpuwhPqCj3yCxEnCazzA2rSdHFA==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr25332092wrs.127.1629903672283; 
 Wed, 25 Aug 2021 08:01:12 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:de26:aaa6:84e1:c609?
 ([2a02:908:1252:fb60:de26:aaa6:84e1:c609])
 by smtp.gmail.com with ESMTPSA id r129sm5725636wmr.7.2021.08.25.08.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Aug 2021 08:01:11 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v4)
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210825130926.230698-1-tom.stdenis@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <71e0b52f-728c-56dd-6d57-3897012deb0d@gmail.com>
Date: Wed, 25 Aug 2021 17:01:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825130926.230698-1-tom.stdenis@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

Am 25.08.21 um 15:09 schrieb Tom St Denis:
> This new debugfs interface uses an IOCTL interface in order to pass
> along state information like SRBM and GRBM bank switching.  This
> new interface also allows a full 32-bit MMIO address range which
> the previous didn't.  With this new design we have room to grow
> the flexibility of the file as need be.
>
> (v2): Move read/write to .read/.write, fix style, add comment
>        for IOCTL data structure
>
> (v3): C style comments
>
> (v4): use u32 in struct and remove offset variable
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 158 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  29 ++++
>   2 files changed, 187 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 277128846dd1..6450f210f6c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -279,6 +279,152 @@ static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>   	return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, size, pos);
>   }
>   
> +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
> +{
> +	struct amdgpu_debugfs_regs2_data *rd;
> +
> +	rd = kzalloc(sizeof *rd, GFP_KERNEL);
> +	if (!rd)
> +		return -ENOMEM;
> +	rd->adev = file_inode(file)->i_private;
> +	file->private_data = rd;
> +
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file *file)
> +{
> +	kfree(file->private_data);
> +	return 0;
> +}
> +
> +static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 offset, size_t size, int write_en)
> +{
> +	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
> +	struct amdgpu_device *adev = rd->adev;
> +	ssize_t result = 0;
> +	int r;
> +	uint32_t value;
> +
> +	if (size & 0x3 || offset & 0x3)
> +		return -EINVAL;
> +


> +	if (rd->id.use_grbm) {
> +		if (rd->id.grbm.se == 0x3FF)
> +			rd->id.grbm.se = 0xFFFFFFFF;
> +		if (rd->id.grbm.sh == 0x3FF)
> +			rd->id.grbm.sh = 0xFFFFFFFF;
> +		if (rd->id.grbm.instance == 0x3FF)
> +			rd->id.grbm.instance = 0xFFFFFFFF;
> +	}

What is this stuff all about? And can't we do this during the IOCTL?

> +
> +	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
> +	r = amdgpu_virt_enable_access_debugfs(adev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}

Maybe replace that with "goto error" style error handling and just "if 
(r)" is the more common style in the kernel I think.

> +
> +	if (rd->id.use_grbm) {
> +		if ((rd->id.grbm.sh != 0xFFFFFFFF && rd->id.grbm.sh >= adev->gfx.config.max_sh_per_se) ||
> +		    (rd->id.grbm.se != 0xFFFFFFFF && rd->id.grbm.se >= adev->gfx.config.max_shader_engines)) {
> +			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +			amdgpu_virt_disable_access_debugfs(adev);
> +			return -EINVAL;
> +		}
> +		mutex_lock(&adev->grbm_idx_mutex);
> +		amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
> +								rd->id.grbm.sh,
> +								rd->id.grbm.instance);
> +	}
> +
> +	if (rd->id.use_srbm) {
> +		mutex_lock(&adev->srbm_mutex);
> +		amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.srbm.pipe,
> +									rd->id.srbm.queue, rd->id.srbm.vmid);
> +	}
> +
> +	if (rd->id.pg_lock)
> +		mutex_lock(&adev->pm.mutex);

Is the locking order ok like this or could userspace cause problems here?

BTW: Do we need a lock for rd? It might be rather bad if userspace is 
causing a race here and we take a lock but never drop it because of a 
concurrent IOCTL.

> +
> +	while (size) {
> +		if (!write_en) {
> +			value = RREG32(offset >> 2);
> +			r = put_user(value, (uint32_t *)buf);
> +		} else {
> +			r = get_user(value, (uint32_t *)buf);

Could be that I'm wrong, but I think get_user returned the number of 
bytes copied and not the error code, but I tend to mix that stuff up. 
Please double check.

> +			if (!r)
> +				amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value);
> +		}
> +		if (r) {
> +			result = r;
> +			goto end;
> +		}
> +		offset += 4;
> +		size -= 4;
> +		result += 4;
> +		buf += 4;
> +	}

I'm really wondering if it wouldn't be simpler to have the 
prefix/postfix code in separate functions and this here in the main 
read/write function.

> +end:
> +	if (rd->id.use_grbm) {
> +		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +		mutex_unlock(&adev->grbm_idx_mutex);
> +	}
> +
> +	if (rd->id.use_srbm) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
> +		mutex_unlock(&adev->srbm_mutex);
> +	}
> +
> +	if (rd->id.pg_lock)
> +		mutex_unlock(&adev->pm.mutex);
> +
> +	/* in umr (the likely user of this) flags are set per file operation
> +	 * which means they're never "unset" explicitly.  To avoid breaking
> +	 * this convention we unset the flags after each operation
> +	 * flags are for a single call (need to be set for every read/write) */

Mhm, is that a must have? Usual semantics for IOCTLs is that they set 
behavior which stays the same for subsequent read/write operations.

Just a bunch of random thoughts on the code.

Christian.

> +	rd->id.use_grbm = 0;
> +	rd->id.use_srbm = 0;
> +	rd->id.pg_lock  = 0;
> +
> +	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +
> +	amdgpu_virt_disable_access_debugfs(adev);
> +	return result;
> +}
> +
> +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, unsigned long data)
> +{
> +	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
> +
> +	switch (cmd) {
> +	case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
> +		if (copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->id))
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *buf, size_t size, loff_t *pos)
> +{
> +	return amdgpu_debugfs_regs2_op(f, buf, *pos, size, 0);
> +}
> +
> +static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __user *buf, size_t size, loff_t *pos)
> +{
> +	return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1);
> +}
> +
>   
>   /**
>    * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
> @@ -1091,6 +1237,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>   	return result;
>   }
>   
> +static const struct file_operations amdgpu_debugfs_regs2_fops = {
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
> +	.read = amdgpu_debugfs_regs2_read,
> +	.write = amdgpu_debugfs_regs2_write,
> +	.open = amdgpu_debugfs_regs2_open,
> +	.release = amdgpu_debugfs_regs2_release,
> +	.llseek = default_llseek
> +};
> +
>   static const struct file_operations amdgpu_debugfs_regs_fops = {
>   	.owner = THIS_MODULE,
>   	.read = amdgpu_debugfs_regs_read,
> @@ -1148,6 +1304,7 @@ static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
>   
>   static const struct file_operations *debugfs_regs[] = {
>   	&amdgpu_debugfs_regs_fops,
> +	&amdgpu_debugfs_regs2_fops,
>   	&amdgpu_debugfs_regs_didt_fops,
>   	&amdgpu_debugfs_regs_pcie_fops,
>   	&amdgpu_debugfs_regs_smc_fops,
> @@ -1160,6 +1317,7 @@ static const struct file_operations *debugfs_regs[] = {
>   
>   static const char *debugfs_regs_names[] = {
>   	"amdgpu_regs",
> +	"amdgpu_regs2",
>   	"amdgpu_regs_didt",
>   	"amdgpu_regs_pcie",
>   	"amdgpu_regs_smc",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index 141a8474e24f..dcf20859c866 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -22,6 +22,8 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    *
>    */
> +#include <linux/ioctl.h>
> +#include <uapi/drm/amdgpu_drm.h>
>   
>   /*
>    * Debugfs
> @@ -38,3 +40,30 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> +
> +/*
> + * MMIO debugfs IOCTL structure
> + */
> +struct amdgpu_debugfs_regs2_iocdata {
> +	__u32 use_srbm, use_grbm, pg_lock;
> +	struct {
> +		__u32 se, sh, instance;
> +	} grbm;
> +	struct {
> +		__u32 me, pipe, queue, vmid;
> +	} srbm;
> +};
> +
> +/*
> + * MMIO debugfs state data (per file* handle)
> + */
> +struct amdgpu_debugfs_regs2_data {
> +	struct amdgpu_device *adev;
> +	struct amdgpu_debugfs_regs2_iocdata id;
> +};
> +
> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
> +	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
> +};
> +
> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)

