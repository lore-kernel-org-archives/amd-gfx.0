Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5503AC77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 12:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E069A10E0CB;
	Fri, 28 Apr 2023 12:18:59 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5069110E0CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 12:18:57 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-504e232fe47so17951717a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682684335; x=1685276335;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D9AqZ2oHGQdSD3NZes4g+JTiecg1fKl1T7qYaeMPeDU=;
 b=BTi3LXMd77dYhLlJZvzEfp9bOqPVk6/Z+zJYMqWXlezsWQsFo6UeTI6ZadJ0Pk3XWO
 BryAL6sGqWDEtI73FrkKjuK8IjCJ1IkUy3MXp07wsbILk6qUCuRLCIthWCGlLOklCrBM
 kwoTSRECKqIJfEvNmVI+Q1iw1UwbW9UneMwcWFiyG0p5kIEYH1Q+FqM1r9GYf6XCmCPh
 7+MXC1/ACTtIGk5TichfyQZGPAziJHp5Nwvpm74GDdgJQ4f0LcIrkJY3SmvJn+p7WKXB
 +u7vAFAo1g5kZr/omJvVCCzR7RuQd363SktXnUSwKIG5k17WnTBmNLt4mRwkxT6xCa1k
 wlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682684335; x=1685276335;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D9AqZ2oHGQdSD3NZes4g+JTiecg1fKl1T7qYaeMPeDU=;
 b=Cok11wJXdgYNjP/9OiIGtigCpaH7XFIFh7nM+JIZmheRX3ddfzGeUv1oWOKO9p3XOx
 k84N9acB8celG3gpN/WM1sy6PC68+Jv5ebG7av3uxI7FtMKEusWtmjVKBE14ECiIw0Ho
 OB3F9JoyM0CIuthBAovmeiTHZ5d+9ZCgPb5pLAI1GesENDhbxeLdl3iyWZXVE1GjvZv/
 RqiMcLtit975+0JYJvvdDeNoImQUAYtSp/T3AfiZ8LiYWCGVrNIGxA4weE++O/7NW30b
 KHdvqIqGp0sTddjFQypIYcGyfiAy3SZiTsWX2oaxGchP0CsNTeOjrQHTM4utmPmW0hZH
 0pJw==
X-Gm-Message-State: AC+VfDxM6JZDisIg7xgTgbT8zJ79j6Wn6ZmU+EUYRrebqVrh5ccrNg/I
 X01YVwj1kQNWiSXtXIwfo2kLWXwWV5Y=
X-Google-Smtp-Source: ACHHUZ6whfmIjNP8X+4gAN6ZavTDPR5myu5+yOC9mbnHztMgsoeVPAhpulolSyruhfHk1o/7JNkDGQ==
X-Received: by 2002:a05:6402:47:b0:506:92d7:6dce with SMTP id
 f7-20020a056402004700b0050692d76dcemr4634848edu.15.1682684334892; 
 Fri, 28 Apr 2023 05:18:54 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:beb6:5db0:ea7:9b07?
 ([2a02:908:1256:79a0:beb6:5db0:ea7:9b07])
 by smtp.gmail.com with ESMTPSA id
 p6-20020aa7d306000000b004fd1ee3f723sm9010284edq.67.2023.04.28.05.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Apr 2023 05:18:54 -0700 (PDT)
Message-ID: <bffdf48a-28ce-ce06-59e6-a0654b3b67fd@gmail.com>
Date: Fri, 28 Apr 2023 14:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix style problems in amdgpu_debugfs.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230428104815.4183212-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230428104815.4183212-1-srinivasan.shanmugam@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.04.23 um 12:48 schrieb Srinivasan Shanmugam:
> Fix the following issues reported by checkpatch:
>
> WARNING: please, no space before tabs
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: sizeof *rd should be sizeof(*rd)
> WARNING: Missing a blank line after declarations
> WARNING: sizeof rd->id should be sizeof(rd->id)
> WARNING: static const char * array should probably be static const char * const
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> WARNING: Prefer seq_puts to seq_printf
> ERROR: space prohibited after that open parenthesis '('
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 28 +++++++++++----------
>   1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 547abe155820..b95e458f86c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -56,14 +56,14 @@
>    *
>    * Bit 62:  Indicates a GRBM bank switch is needed
>    * Bit 61:  Indicates a SRBM bank switch is needed (implies bit 62 is
> - * 	    zero)
> + *	    zero)
>    * Bits 24..33: The SE or ME selector if needed
>    * Bits 34..43: The SH (or SA) or PIPE selector if needed
>    * Bits 44..53: The INSTANCE (or CU/WGP) or QUEUE selector if needed
>    *
>    * Bit 23:  Indicates that the PM power gating lock should be held
> - * 	    This is necessary to read registers that might be
> - * 	    unreliable during a power gating transistion.
> + *	    This is necessary to read registers that might be
> + *	    unreliable during a power gating transistion.
>    *
>    * The lower bits are the BYTE offset of the register to read.  This
>    * allows reading multiple registers in a single call and having
> @@ -76,7 +76,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>   	ssize_t result = 0;
>   	int r;
>   	bool pm_pg_lock, use_bank, use_ring;
> -	unsigned instance_bank, sh_bank, se_bank, me, pipe, queue, vmid;
> +	unsigned int instance_bank, sh_bank, se_bank, me, pipe, queue, vmid;
>   
>   	pm_pg_lock = use_bank = use_ring = false;
>   	instance_bank = sh_bank = se_bank = me = pipe = queue = vmid = 0;
> @@ -208,7 +208,7 @@ static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
>   {
>   	struct amdgpu_debugfs_regs2_data *rd;
>   
> -	rd = kzalloc(sizeof *rd, GFP_KERNEL);
> +	rd = kzalloc(sizeof(*rd), GFP_KERNEL);
>   	if (!rd)
>   		return -ENOMEM;
>   	rd->adev = file_inode(file)->i_private;
> @@ -221,6 +221,7 @@ static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
>   static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file *file)
>   {
>   	struct amdgpu_debugfs_regs2_data *rd = file->private_data;
> +
>   	mutex_destroy(&rd->lock);
>   	kfree(file->private_data);
>   	return 0;
> @@ -324,7 +325,8 @@ static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, unsigne
>   	switch (cmd) {
>   	case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>   		mutex_lock(&rd->lock);
> -		r = copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->id);
> +		r = copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data,
> +				   sizeof(rd->id));
>   		mutex_unlock(&rd->lock);
>   		return r ? -EINVAL : 0;
>   	default:
> @@ -863,7 +865,7 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
>    * The offset being sought changes which wave that the status data
>    * will be returned for.  The bits are used as follows:
>    *
> - * Bits 0..6: 	Byte offset into data
> + * Bits 0..6:	Byte offset into data
>    * Bits 7..14:	SE selector
>    * Bits 15..22:	SH/SA selector
>    * Bits 23..30: CU/{WGP+SIMD} selector
> @@ -1429,7 +1431,7 @@ static const struct file_operations *debugfs_regs[] = {
>   	&amdgpu_debugfs_gfxoff_residency_fops,
>   };
>   
> -static const char *debugfs_regs_names[] = {
> +static const char * const debugfs_regs_names[] = {
>   	"amdgpu_regs",
>   	"amdgpu_regs2",
>   	"amdgpu_regs_didt",
> @@ -1447,7 +1449,7 @@ static const char *debugfs_regs_names[] = {
>   
>   /**
>    * amdgpu_debugfs_regs_init -	Initialize debugfs entries that provide
> - * 				register access.
> + *				register access.
>    *
>    * @adev: The device to attach the debugfs entries to
>    */
> @@ -1459,7 +1461,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>   
>   	for (i = 0; i < ARRAY_SIZE(debugfs_regs); i++) {
>   		ent = debugfs_create_file(debugfs_regs_names[i],
> -					  S_IFREG | S_IRUGO, root,
> +					  S_IFREG | 0444, root,
>   					  adev, debugfs_regs[i]);
>   		if (!i && !IS_ERR_OR_NULL(ent))
>   			i_size_write(ent->d_inode, adev->rmmio_size);
> @@ -1494,12 +1496,12 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>   		kthread_park(ring->sched.thread);
>   	}
>   
> -	seq_printf(m, "run ib test:\n");
> +	seq_puts(m, "run ib test:\n");
>   	r = amdgpu_ib_ring_tests(adev);
>   	if (r)
>   		seq_printf(m, "ib ring tests failed (%d).\n", r);
>   	else
> -		seq_printf(m, "ib ring tests passed.\n");
> +		seq_puts(m, "ib ring tests passed.\n");
>   
>   	/* go on the scheduler */
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> @@ -1982,7 +1984,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   		amdgpu_debugfs_ring_init(adev, ring);
>   	}
>   
> -	for ( i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>   		if (!amdgpu_vcnfw_log)
>   			break;
>   

