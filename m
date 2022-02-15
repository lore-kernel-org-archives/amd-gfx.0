Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F283CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 16:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ACFB10E679;
	Tue, 15 Feb 2022 16:28:32 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBD310E679
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 16:28:31 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id vz16so5940922ejb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 08:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=NCbIgN3f7cA3NfbaLJMmJp2qBc/TWq9Hz+MjKvDNac8=;
 b=qyNuC3+3L3gTR9UL/Xe82Y1DdOMufaFQ4OrneL3aP995Rv9nUeO9HysNwyCUFAocMo
 aV8FIHCgaA3IgrScGX2rk/a+4yuoVaDfOkAWWGkpwH3lKj4b561DKWC+UcSXW5CBKE/M
 I4RH7+Jgu3G8FlX/iVPyxxyrtq4wasHkKWMfOp4TXO+DZUhGd8DleCfGBPpVKvxbv5UZ
 8iBAOwLe1743mQmkauksVxH4svDSox/MuyQ3QmFERwU7hkbL8xPodJXnzmJKTpOPipc4
 2NFmhgks5HkQeZubRksyyg/UJLzhAawspTHQSh8845yyuVBNm+IOqmlmJreIDKH04THN
 cdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=NCbIgN3f7cA3NfbaLJMmJp2qBc/TWq9Hz+MjKvDNac8=;
 b=DMlTrkinhr1uHFcYgmfUwO5BRBdCjUeQbr1bklkGaOwpwAtU9uawl/aku7h9U7lT4z
 x1sXoZil2BSPPgE7q/ZvAt9GgxYXpHp4uoDQ1bFlPuED215rgzU3a4Z7fizMfynsk9uZ
 gsthn7oJQ8I2Ob8gbuIBRsfDLS/m+G7TyXicxESN11JnglerhF5Tu7+DpxJ/5XjNR+jT
 gqTSEhI7pVfgKbZwsnzsfNSYu+XyG+LtFDaLUvHfETsDiOjjhb21bMI0tNLVo5nsiLqG
 YVR/YQS5V0+SjmdfC5IPfk1cnlD8+y4HOrm4MlyrXGnoo9OOfgRrUotkKuzxnC91mrg8
 irbA==
X-Gm-Message-State: AOAM530LWVihvufB5dpewjt5rXaOSTEcPL2xaCE/oolyJR6DIJ/w80rr
 /jWvD3Mkl+BEDtKXECOazBaqhaHt9U4=
X-Google-Smtp-Source: ABdhPJxpqrPjrG3rBjhqLOlyHspWtNxVkV39RDF758PQcuiGO6N9RL24/mrNHahXWtl8eEkfop/RCw==
X-Received: by 2002:a17:906:b01:: with SMTP id
 u1mr3470202ejg.312.1644942509741; 
 Tue, 15 Feb 2022 08:28:29 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:94b0:e8d4:1f08:1c17?
 ([2a02:908:1252:fb60:94b0:e8d4:1f08:1c17])
 by smtp.gmail.com with ESMTPSA id bl12sm11871937ejb.75.2022.02.15.08.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 08:28:29 -0800 (PST)
Message-ID: <d3fcaa72-2250-02ea-d095-f5febc616b32@gmail.com>
Date: Tue, 15 Feb 2022 17:28:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220215153610.2471-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220215153610.2471-1-Amaranath.Somalapuram@amd.com>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 15.02.22 um 16:36 schrieb Somalapuram Amaranath:
> List of register populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 +++++++++++++++++++++
>   2 files changed, 99 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..2e8c2318276d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>   
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
> +
> +	/* reset dump register */
> +	uint32_t			*reset_dump_reg_list;
> +	int                             n_regs;
>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..be4336574fec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,99 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> +				char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char reg_offset[11];
> +	int i, r, len = 0;
> +
> +	if (adev->n_regs == 0)
> +		return 0;
> +
> +	for (i = 0; i < adev->n_regs; i++) {
> +		sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
> +		r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
> +		
> +		if (r)
> +			return -EFAULT;
> +
> +		len += strlen(reg_offset);
> +	}
> +
> +	r = copy_to_user(buf + len, "\n", 1);
> +
> +	if (r)
> +		return -EFAULT;
> +
> +	len++;
> +
> +	if (*pos >= len)
> +		return 0;

I think we should probably move that to the beginning of the function 
and just return 0 when *pos is none null.

Alternatively you can implement it much more clever if you actually make 
use of this, e.g. return the register based on the current *pos.

> +
> +	*pos += len - r;

The - r part can be dropped.

> +
> +	return len;
> +}
> +
> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> +			const char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char *reg_offset, *reg, reg_temp[11];
> +	int ret, i = 0, len = 0;
> +
> +	reg_offset = reg_temp;
> +	memset(reg_offset,  0, 11);
> +	ret = copy_from_user(reg_offset, buf + len, (11 < (size) ? 11 : (size)));

Please use min(11, size) here.

> +
> +	if (ret)
> +		return -EFAULT;
> +
> +	if (adev->n_regs > 0) {
> +		adev->n_regs = 0;
> +		kfree(adev->reset_dump_reg_list);
> +		adev->reset_dump_reg_list = NULL;
> +	}

If would be better to swap that in after gathering the complete register 
list.

And you need to grab the reset lock while updating it to make sure that 
a concurrent reset doesn't touch freed data.

> +
> +	while (((reg = strsep(&reg_offset, " ")) != NULL) && len < size) {
> +		adev->reset_dump_reg_list =  krealloc_array(
> +						adev->reset_dump_reg_list, 1,
> +						sizeof(uint32_t), GFP_KERNEL);
> +		ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
> +
> +		if (ret) {
> +			kfree(adev->reset_dump_reg_list);
> +			adev->reset_dump_reg_list = NULL;
> +			return -EINVAL;
> +		}
> +
> +		len += strlen(reg) + 1;
> +		reg_offset = reg_temp;
> +		memset(reg_offset,  0, 11);
> +		ret = copy_from_user(reg_offset, buf + len, (11 < (size-len) ? 11 : (size-len)));
> +
> +		if (ret) {
> +			kfree(adev->reset_dump_reg_list);
> +			adev->reset_dump_reg_list = NULL;
> +			return -EFAULT;
> +		}
> +
> +		i++;
> +	}

I think you should completely rework that loop into a do { ... } while 
(size);

Regards,
Christian.

> +
> +	adev->n_regs = i;
> +
> +	return size;
> +}
> +
> +static const struct file_operations amdgpu_reset_dump_register_list = {
> +	.owner = THIS_MODULE,
> +	.read = amdgpu_reset_dump_register_list_read,
> +	.write = amdgpu_reset_dump_register_list_write,
> +	.llseek = default_llseek
> +};
> +
>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

