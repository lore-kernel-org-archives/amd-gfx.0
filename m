Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BE2C678DB
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 06:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FC510E0D9;
	Tue,  7 Mar 2023 06:22:24 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D753510E0D9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 06:22:22 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id ay14so44403935edb.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Mar 2023 22:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678170141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=seiMz2V9vYq+e8/akTv6h/xewbO5ysyEC/uhO1WJvDw=;
 b=baBD0iQ7jwX/ON5SGpy593Zhs78+NuQD+HdDBLyWw+B7CU1pEdkfCOqIJQ5JfV40Z8
 5thCgzAw4jIUVjmSnGuABW2sRXO6VxONdUaCoQ3h7FFA3zL5bj5vrPLOrHOjBIDpBRmc
 xgSTS5pDVh9668ZunRdcviT15WfTqzmxfEugxsrdJhBe9eybedLwBWuULIbC1RNxKcgk
 sgIgbjqiICmhiI80wyjyLDTzDGOA2la5LDdFwbwKJ1mcmRwvK+zp0nuVGzdD9mNnHu1B
 urWRJ5tIJmg2xAie+D4ayBdJM0HrbhNamoFlBJDJAKEnKF7u4hQWFEdM4EluBZrSGDzr
 X97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678170141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=seiMz2V9vYq+e8/akTv6h/xewbO5ysyEC/uhO1WJvDw=;
 b=UsfmWchNvI+1J7inpL46IIxn7RbQLApqdL12W5C5Csis+k/jHkqAXGxKP9AxIgLfMc
 aSY+2BXNlcIequIuWEdI9gDIjbzJmyebU8PnL9JaPSx5yswPYgzYINiV1SYPVTb82mJs
 TyzKg7zknSwvty0/7PE/qBTBrU+1keCzoti5j6krFVAyVFZsnCEJqclXOq3RpY+oYuIa
 HNVVLG+ZHnDqlgo0fFvrIz06YDTkJkCGKxbU2akTjNUDqhsf6oKnYGxZUKhqs7WMmYjV
 6H70AdjGVGzJgMNsU4K0h3l3PQWW1kLkJoxzivsanhu/zjN/g8n6r0FQ2rJHRfmRvYfc
 cUZQ==
X-Gm-Message-State: AO0yUKXWkC792SNjax9z+1xKt3+fBqnO6+BGp149igWLca3s0LZxtpLH
 jguGFPp5/z+EHhaPoh2TUhw=
X-Google-Smtp-Source: AK7set+n1QPZReymBVjkQjCnZl0N8xqt1fOtZbiA0T04JDD1jyIJ5GoCUrjCtfXdgmdw/+i1r3qqOw==
X-Received: by 2002:a17:906:3b4b:b0:85d:dd20:60a4 with SMTP id
 h11-20020a1709063b4b00b0085ddd2060a4mr12393934ejf.40.1678170141060; 
 Mon, 06 Mar 2023 22:22:21 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:447b:93b2:2cc7:bcfd?
 ([2a02:908:1256:79a0:447b:93b2:2cc7:bcfd])
 by smtp.gmail.com with ESMTPSA id
 l26-20020a170906231a00b008b69aa62efcsm5558442eja.62.2023.03.06.22.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Mar 2023 22:22:20 -0800 (PST)
Message-ID: <1ce9cf14-2d1b-29f8-57df-8e600b353f66@gmail.com>
Date: Tue, 7 Mar 2023 07:22:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: Fix the warning info when removing amdgpu
 device
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Li, Lyndon" <Lyndon.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230307021221.45890-1-Lyndon.Li@amd.com>
 <DM5PR12MB24698E2A9E22CB2F80FA8249F1B79@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM5PR12MB24698E2A9E22CB2F80FA8249F1B79@DM5PR12MB2469.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The commit message reads a bit bumpy. Generally best practice are:

Short (72 chars or less) summary

More detailed explanatory text. Wrap it to 72 characters. The blank
line separating the summary from the body is critical (unless you omit
the body entirely).

Write your commit message in the imperative: "Fix bug" and not "Fixed
bug" or "Fixes bug." This convention matches up with commit messages
generated by commands like git merge and git revert.

Further paragraphs come after blank lines.

- Bullet points are okay, too.
- Typically a hyphen or asterisk is used for the bullet, followed by a
   single space. Use a hanging indent.

Apart from that the patch is Acked-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

Am 07.03.23 um 03:23 schrieb Chen, Guchun:
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: lyndonli <Lyndon.Li@amd.com>
> Sent: Tuesday, March 7, 2023 10:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Ma, Jun <Jun.Ma2@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix the warning info when removing amdgpu device
>
> Actually, the drm_dev_enter in psp_cmd_submit_buf does not protect anything.
> And it is not used to prevent concurrent access.
> If DRM device is unplugged, it will always check the condition in WARN_ON.
> We'd better not keep adding commands to the list.
> Simply moving the drm_dev_enter/drm_dev_exit higher level will not solve the issue.
> Because psp_cmd_submit_buf is called in many places, such as psp_hw_init-->psp_load_fw, psp_suspend-->psp_xgmi_terminate, amdgpu_device_gpu_recover-->amdgpu_ras_suspend.
> So drop drm_dev_enter/drm_dev_exit in psp_cmd_submit_buf.
>
> When removing amdgpu, the calling order as follows:
> amdgpu_pci_remove
> 	drm_dev_unplug
> 	amdgpu_driver_unload_kms
> 		amdgpu_device_fini_hw
> 			amdgpu_device_ip_fini_early
> 				psp_hw_fini
> 					psp_ras_terminate
> 						psp_ta_unloadye
> 							psp_cmd_submit_buf
>
> [ 4507.740388] Call Trace:
> [ 4507.740389]  <TASK>
> [ 4507.740391]  psp_ta_unload+0x44/0x70 [amdgpu] [ 4507.740485]  psp_ras_terminate+0x4d/0x70 [amdgpu] [ 4507.740575]  psp_hw_fini+0x28/0xa0 [amdgpu] [ 4507.740662]  amdgpu_device_fini_hw+0x328/0x442 [amdgpu] [ 4507.740791]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu] [ 4507.740875]  amdgpu_pci_remove+0x5a/0x140 [amdgpu] [ 4507.740962]  ? _raw_spin_unlock_irqrestore+0x27/0x43
> [ 4507.740965]  ? __pm_runtime_resume+0x60/0x90 [ 4507.740968]  pci_device_remove+0x39/0xb0 [ 4507.740971]  device_remove+0x46/0x70 [ 4507.740972]  device_release_driver_internal+0xd1/0x160
> [ 4507.740974]  driver_detach+0x4a/0x90
> [ 4507.740975]  bus_remove_driver+0x6c/0xf0 [ 4507.740976]  driver_unregister+0x31/0x50 [ 4507.740977]  pci_unregister_driver+0x40/0x90 [ 4507.740978]  amdgpu_exit+0x15/0x120 [amdgpu]
>
> Signed-off-by: lyndonli <Lyndon.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 17 +----------------
>   1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 4c617faaa7c9..02f948adae72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -603,27 +603,14 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   		   struct psp_gfx_cmd_resp *cmd, uint64_t fence_mc_addr)  {
>   	int ret;
> -	int index, idx;
> +	int index;
>   	int timeout = 20000;
>   	bool ras_intr = false;
>   	bool skip_unsupport = false;
> -	bool dev_entered;
>   
>   	if (psp->adev->no_hw_access)
>   		return 0;
>   
> -	dev_entered = drm_dev_enter(adev_to_drm(psp->adev), &idx);
> -	/*
> -	 * We allow sending PSP messages LOAD_ASD and UNLOAD_TA without acquiring
> -	 * a lock in drm_dev_enter during driver unload because we must call
> -	 * drm_dev_unplug as the beginning  of unload driver sequence . It is very
> -	 * crucial that userspace can't access device instances anymore.
> -	 */
> -	if (!dev_entered)
> -		WARN_ON(psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_LOAD_ASD &&
> -			psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_UNLOAD_TA &&
> -			psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_INVOKE_CMD);
> -
>   	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
>   
>   	memcpy(psp->cmd_buf_mem, cmd, sizeof(struct psp_gfx_cmd_resp)); @@ -687,8 +674,6 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   	}
>   
>   exit:
> -	if (dev_entered)
> -		drm_dev_exit(idx);
>   	return ret;
>   }
>   
> --
> 2.34.1
>

