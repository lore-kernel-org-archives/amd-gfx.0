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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C92C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 06:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C6A613A7
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 06:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46C6A613A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73856E156;
	Wed, 25 Aug 2021 06:35:11 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006CA6E154
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 06:35:09 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 x2-20020a1c7c02000000b002e6f1f69a1eso3440284wmc.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 23:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=iBuUGFASfrlCy805gxXwxx0JsGdsonhl/C7YkCjvf/k=;
 b=OPqbeFi6ZX1O+XoU8OG8z25VyQapKndZ/IabgSa3fTlScXz4jROIumWopmkl9CISdO
 1+kiYgn6d+NiJAgGxF0ZtWVUKd0sHFBmV71mEp10QvoJANL8hZQwVDq0qe1T7CrAuQaN
 7C5u0Z8aCq8yjWkJ/3UAV2u/f7c4OyGAbGVzGqvcKFjQQpfNm8KvoguedngLBnKcishu
 5b2t3UNYRT1eoL6PQVKFPnIi5cnb5/M8HpeltDr63wKILDWxZrvOcwgTUWDEk7xBx7ZA
 8nM/q0t2Gibq1BXw0wJ2QUroc8USrEWryMhNGNmfBFATVFTGUbG2kz2vMBnX8UKdCE/3
 FCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=iBuUGFASfrlCy805gxXwxx0JsGdsonhl/C7YkCjvf/k=;
 b=OCLNuplqW2i2FODvQGTlml50ZF92BhiJda5SB5XDfn1Nz4AL1YrAIo0F8hhDgCVB4M
 nZ5r1FiWA8a6VqdHuaDJOdstxEi+2rGcZ3Xfuh1rDvs3z3E5UXPxFX5NNCbsgQhbSaCt
 So8oSBTOWeaSKrt5nm5eedpX3A8jl+YHP5zHC/qfpGiP7aZXGFSl4Nf0Dw1C+rqOAgfZ
 LCrikFbGw4iK8xEv7wxq62HW74n5o3aETidUP+zcd6AzXZtx55oqgDLZM3PtwlvsLOTr
 THzL99tdowoR13oF64Rr0gvIh7Nn9Wlcqx5CmUAvv4poIGHrckK51jbzrf1P2HvN+eFr
 k1Qg==
X-Gm-Message-State: AOAM5315K+o7pIH1N63etxOcLigaeOrdCXZDElSM6CcGanHTv8CqZneZ
 sQcUeqoJxJYb0EFZ88O5llF3t1oltlFpdKms
X-Google-Smtp-Source: ABdhPJxo7ALgzsAUfm3mEdcQE0h05kxljoeMbktDrtztO80q1TE8011TS/NsHg43jpAi11nQcdA4EA==
X-Received: by 2002:a05:600c:215a:: with SMTP id
 v26mr7678006wml.100.1629873308357; 
 Tue, 24 Aug 2021 23:35:08 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id n20sm365919wms.15.2021.08.24.23.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 23:35:07 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v2)
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210824133642.109072-1-tom.stdenis@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <de13fb00-3ce7-5f6c-8f22-e07e697de643@gmail.com>
Date: Wed, 25 Aug 2021 08:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824133642.109072-1-tom.stdenis@amd.com>
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



Am 24.08.21 um 15:36 schrieb Tom St Denis:
> This new debugfs interface uses an IOCTL interface in order to pass
> along state information like SRBM and GRBM bank switching.  This
> new interface also allows a full 32-bit MMIO address range which
> the previous didn't.  With this new design we have room to grow
> the flexibility of the file as need be.
>
> (v2): Move read/write to .read/.write, fix style, add comment
>        for IOCTL data structure
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 162 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
>   2 files changed, 194 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 277128846dd1..8e8f5743c8f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -279,6 +279,156 @@ static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
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
> +static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, size_t size, int write_en)
> +{
> +	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
> +	struct amdgpu_device *adev = rd->adev;
> +	ssize_t result = 0;
> +	int r;
> +	uint32_t value;
> +
> +	if (size & 0x3 || rd->state.offset & 0x3)
> +		return -EINVAL;
> +
> +	if (rd->state.id.use_grbm) {
> +		if (rd->state.id.grbm.se == 0x3FF)
> +			rd->state.id.grbm.se = 0xFFFFFFFF;
> +		if (rd->state.id.grbm.sh == 0x3FF)
> +			rd->state.id.grbm.sh = 0xFFFFFFFF;
> +		if (rd->state.id.grbm.instance == 0x3FF)
> +			rd->state.id.grbm.instance = 0xFFFFFFFF;
> +	}
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
> +
> +	if (rd->state.id.use_grbm) {
> +		if ((rd->state.id.grbm.sh != 0xFFFFFFFF && rd->state.id.grbm.sh >= adev->gfx.config.max_sh_per_se) ||
> +		    (rd->state.id.grbm.se != 0xFFFFFFFF && rd->state.id.grbm.se >= adev->gfx.config.max_shader_engines)) {
> +			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +			amdgpu_virt_disable_access_debugfs(adev);
> +			return -EINVAL;
> +		}
> +		mutex_lock(&adev->grbm_idx_mutex);
> +		amdgpu_gfx_select_se_sh(adev, rd->state.id.grbm.se,
> +								rd->state.id.grbm.sh,
> +								rd->state.id.grbm.instance);
> +	}
> +
> +	if (rd->state.id.use_srbm) {
> +		mutex_lock(&adev->srbm_mutex);
> +		amdgpu_gfx_select_me_pipe_q(adev, rd->state.id.srbm.me, rd->state.id.srbm.pipe,
> +									rd->state.id.srbm.queue, rd->state.id.srbm.vmid);
> +	}
> +
> +	if (rd->state.id.pg_lock)
> +		mutex_lock(&adev->pm.mutex);
> +
> +	while (size) {
> +		if (!write_en) {
> +			value = RREG32(rd->state.offset >> 2);
> +			r = put_user(value, (uint32_t *)buf);
> +		} else {
> +			r = get_user(value, (uint32_t *)buf);
> +			if (!r)
> +				amdgpu_mm_wreg_mmio_rlc(adev, rd->state.offset >> 2, value);
> +		}
> +		if (r) {
> +			result = r;
> +			goto end;
> +		}
> +		rd->state.offset += 4;
> +		size -= 4;
> +		result += 4;
> +		buf += 4;
> +	}
> +end:
> +	if (rd->state.id.use_grbm) {
> +		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +		mutex_unlock(&adev->grbm_idx_mutex);
> +	}
> +
> +	if (rd->state.id.use_srbm) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
> +		mutex_unlock(&adev->srbm_mutex);
> +	}
> +
> +	if (rd->state.id.pg_lock)
> +		mutex_unlock(&adev->pm.mutex);
> +
> +	// in umr (the likely user of this) flags are set per file operation
> +	// which means they're never "unset" explicitly.  To avoid breaking
> +	// this convention we unset the flags after each operation
> +	// flags are for a single call (need to be set for every read/write)
> +	rd->state.id.use_grbm = 0;
> +	rd->state.id.use_srbm = 0;
> +	rd->state.id.pg_lock  = 0;
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
> +		if (copy_from_user(&rd->state.id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->state.id))
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
> +	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
> +	rd->state.offset = *pos;
> +	return amdgpu_debugfs_regs2_op(f, buf, size, 0);
> +}
> +
> +static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
> +	rd->state.offset = *pos;
> +	return amdgpu_debugfs_regs2_op(f, (char __user *)buf, size, 1);
> +}
> +
>   
>   /**
>    * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
> @@ -1091,6 +1241,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
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
> @@ -1148,6 +1308,7 @@ static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
>   
>   static const struct file_operations *debugfs_regs[] = {
>   	&amdgpu_debugfs_regs_fops,
> +	&amdgpu_debugfs_regs2_fops,
>   	&amdgpu_debugfs_regs_didt_fops,
>   	&amdgpu_debugfs_regs_pcie_fops,
>   	&amdgpu_debugfs_regs_smc_fops,
> @@ -1160,6 +1321,7 @@ static const struct file_operations *debugfs_regs[] = {
>   
>   static const char *debugfs_regs_names[] = {
>   	"amdgpu_regs",
> +	"amdgpu_regs2",
>   	"amdgpu_regs_didt",
>   	"amdgpu_regs_pcie",
>   	"amdgpu_regs_smc",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index 141a8474e24f..ec044df5d428 100644
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
> @@ -38,3 +40,33 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> +
> +/*
> + * MMIO debugfs IOCTL structure
> + */
> +struct amdgpu_debugfs_regs2_iocdata {
> +	__u8 use_srbm, use_grbm, pg_lock;

You should consider using u32 here as well or add explicitly padding.

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
> +	struct {
> +		struct amdgpu_debugfs_regs2_iocdata id;
> +		__u32 offset;

What is the offset good for here?

Regards,
Christian.

> +	} state;
> +};
> +
> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
> +	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
> +};
> +
> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)

