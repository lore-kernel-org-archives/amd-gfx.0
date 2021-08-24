Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75160C4320E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3884861357
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3884861357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95CC89ED6;
	Tue, 24 Aug 2021 12:34:46 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C4389ED6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 12:34:46 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id q11so4132605wrr.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=PyTvnLVDAmcHLHm5plY3Z/31vUI20N6IGFxxnxGzLeM=;
 b=SEPIEAxid4PJ6NKIVXSwClSCBQ/gB7yvapMakks7Xvx6zpq58W8F5+YrS3Na9UyJjI
 IrSqteotRjHDWv+TO0UnKFeXHj216vtIVmM9jyypwcCXFG2l3itmvWwl08pI1zx4ufNj
 xI9iOSUw+VEqZszVWwgEh6Z6EcBoJ19POD4sID6x4NB0DORLQi1ngEkiIDJlpI/1rj09
 GgUW3dT8qQbT+d8Q9bfvXuaisf/RLOCxRdfWLV4zvOUpT1r09CfqQ5RcGOOiu3CdMq5C
 yiWHTlySVlk7FaG4LqAUQ1ox4n6Gp3xea7O0UO5c3Qy3N5XFfv2ZxDuGeImLVrgDqBf6
 lgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=PyTvnLVDAmcHLHm5plY3Z/31vUI20N6IGFxxnxGzLeM=;
 b=FexQUq3JPF4SQwVWd8ackNQHqKUvQaquunTyxfbBfV/rEEsb86uemP1IG2PxqvAocO
 xtWyazukWdNHEkiDu52g+IoPF3bE2fSbvgJ4C+OCT9ukJ6FIn1vqKz0LC8zPbI+5R7xj
 H4U/XsswaRdbFhku4jRcX2CFb2GP4pUhqOlbOnGReR5ExqiZmjBAOIXMPl7+Tb5EqhMV
 QHP8soyGWDIz9qELJk8qF3OouE1WKv9HCvp4FIIyURL3xNYbQG2Ixm2byqSFvxjwCf5A
 dXiykta6IQ7u7khi+SS5YC35z3AIYXx7oRqfBKGbRU3FGSGah08U8fG1qBqVolyeXoXN
 R34w==
X-Gm-Message-State: AOAM53348rHArl7rCtbL+QQZ0bUSU1jWbDGWrsQF46p4aSwzQxB0d6ki
 IPYcQ/qJWzrRDxId6oOcUD/19OM8ndMUXtFf
X-Google-Smtp-Source: ABdhPJwWpifx4ZTnpbVUaUrEp1fwkwhqhHaFxorneKXjgI0eOrrM3bEPBOM9h1btCWHbO5XuETae7w==
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr18838552wro.107.1629808484650; 
 Tue, 24 Aug 2021 05:34:44 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id g11sm3256120wrx.30.2021.08.24.05.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 05:34:44 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
To: "StDenis, Tom" <Tom.StDenis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210824121618.99839-1-tom.stdenis@amd.com>
 <f0ada58f-f6c8-89f1-3036-065c908696b2@gmail.com>
 <DM6PR12MB35475954BCF1B73048B662FEF7C59@DM6PR12MB3547.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <baeaf8da-6c4a-516b-823e-224a0ac80471@gmail.com>
Date: Tue, 24 Aug 2021 14:34:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB35475954BCF1B73048B662FEF7C59@DM6PR12MB3547.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 24.08.21 um 14:27 schrieb StDenis, Tom:
> [AMD Official Use Only]
>
> What do you mean a "shared header?"  How would they be shared between kernel and user?

Somewhere in the include/uapi/drm/ folder I think. Either add that to 
amdgpu_drm.h or maybe amdgpu_debugfs.h?

Or just keep it as a structure in amdgpu_debugfs.h with a comment that 
it is used for an IOCTL.

Just not something hard coded like first byte is this, second that etc....

> As for why not read/write.  Jus wanted to keep it simple.  It's not really performance bound.  umr never does reads/writes larger than 32-bits anyways.  It doesn't have to be this way though but I figured the fewer LOC the better.

I think it would be cleaner if we would have separate functions for this.

As far as I can see you also don't need the dance with the power 
managerment etc for the IOCTL. It's just get_user() into your structure.

BTW: In the kernel coding style put "switch" and "case" on the same 
column, otherwise checkpatch.pl might complain.

Christian.

>
> Tom
>
> ________________________________________
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Tuesday, August 24, 2021 08:20
> To: StDenis, Tom; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
>
>
>
> Am 24.08.21 um 14:16 schrieb Tom St Denis:
>> This new debugfs interface uses an IOCTL interface in order to pass
>> along state information like SRBM and GRBM bank switching.  This
>> new interface also allows a full 32-bit MMIO address range which
>> the previous didn't.  With this new design we have room to grow
>> the flexibility of the file as need be.
>>
>> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 177 ++++++++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
>>    2 files changed, 209 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 277128846dd1..ab2d92f84da5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -279,6 +279,173 @@ static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>>        return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, size, pos);
>>    }
>>
>> +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
>> +{
>> +     struct amdgpu_debugfs_regs2_data *rd;
>> +
>> +     rd = kzalloc(sizeof *rd, GFP_KERNEL);
>> +     if (!rd)
>> +             return -ENOMEM;
>> +     rd->adev = file_inode(file)->i_private;
>> +     file->private_data = rd;
>> +
>> +     return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file *file)
>> +{
>> +     kfree(file->private_data);
>> +     return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, int write_en)
>> +{
>> +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>> +     struct amdgpu_device *adev = rd->adev;
>> +     int result = 0, r;
>> +     uint32_t value;
>> +
>> +     if (rd->state.offset & 0x3)
>> +             return -EINVAL;
>> +
>> +     if (rd->state.use_grbm) {
>> +             if (rd->state.grbm.se == 0x3FF)
>> +                     rd->state.grbm.se = 0xFFFFFFFF;
>> +             if (rd->state.grbm.sh == 0x3FF)
>> +                     rd->state.grbm.sh = 0xFFFFFFFF;
>> +             if (rd->state.grbm.instance == 0x3FF)
>> +                     rd->state.grbm.instance = 0xFFFFFFFF;
>> +     }
>> +
>> +     r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> +     if (r < 0) {
>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +             return r;
>> +     }
>> +
>> +     r = amdgpu_virt_enable_access_debugfs(adev);
>> +     if (r < 0) {
>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +             return r;
>> +     }
>> +
>> +     if (rd->state.use_grbm) {
>> +             if ((rd->state.grbm.sh != 0xFFFFFFFF && rd->state.grbm.sh >= adev->gfx.config.max_sh_per_se) ||
>> +                 (rd->state.grbm.se != 0xFFFFFFFF && rd->state.grbm.se >= adev->gfx.config.max_shader_engines)) {
>> +                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>> +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +                     amdgpu_virt_disable_access_debugfs(adev);
>> +                     return -EINVAL;
>> +             }
>> +             mutex_lock(&adev->grbm_idx_mutex);
>> +             amdgpu_gfx_select_se_sh(adev, rd->state.grbm.se,
>> +                                                             rd->state.grbm.sh,
>> +                                                             rd->state.grbm.instance);
>> +     } else if (rd->state.use_grbm) {
>> +             mutex_lock(&adev->srbm_mutex);
>> +             amdgpu_gfx_select_me_pipe_q(adev, rd->state.srbm.me, rd->state.srbm.pipe,
>> +                                                                     rd->state.srbm.queue, rd->state.srbm.vmid);
>> +     }
>> +
>> +     if (rd->state.pg_lock)
>> +             mutex_lock(&adev->pm.mutex);
>> +
>> +     if (!write_en) {
>> +             value = RREG32(rd->state.offset >> 2);
>> +             r = put_user(value, (uint32_t *)buf);
>> +     } else {
>> +             r = get_user(value, (uint32_t *)buf);
>> +             if (!r)
>> +                     amdgpu_mm_wreg_mmio_rlc(adev, rd->state.offset >> 2, value);
>> +     }
>> +     if (r) {
>> +             result = r;
>> +             goto end;
>> +     }
>> +     result = 0;
>> +end:
>> +     if (rd->state.use_grbm) {
>> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>> +             mutex_unlock(&adev->grbm_idx_mutex);
>> +     } else if (rd->state.use_srbm) {
>> +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>> +             mutex_unlock(&adev->srbm_mutex);
>> +     }
>> +
>> +     if (rd->state.pg_lock)
>> +             mutex_unlock(&adev->pm.mutex);
>> +
>> +     // in umr (the likely user of this) flags are set per file operation
>> +     // which means they're never "unset" explicitly.  To avoid breaking
>> +     // this convention we unset the flags after each operation
>> +     // flags are for a single call (need to be set for every read/write)
>> +     rd->state.use_grbm = 0;
>> +     rd->state.use_srbm = 0;
>> +     rd->state.pg_lock  = 0;
>> +
>> +     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>> +     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +
>> +     amdgpu_virt_disable_access_debugfs(adev);
>> +     return result;
>> +}
>> +
>> +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, unsigned long data)
>> +{
>> +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>> +     unsigned char st[32], v;
>> +     int r, x;
>> +
>> +     // always read first 4 bytes of data
>> +     for (x = 0; x < 4; x++) {
>> +             if ((r = get_user(v, (unsigned char *)data))) {
>> +                     return r;
>> +             }
>> +             ++data;
>> +             st[x] = v;
>> +     }
>> +
>> +     // first 4 bytes are offset
>> +     rd->state.offset = ((u32)st[0]) | ((u32)st[1] << 8) |
>> +                                        ((u32)st[2] << 16) | ((u32)st[3] << 24);
>> +
>> +     switch (cmd) {
>> +             case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>> +                     for (x = 4; x < 32; x++) {
>> +                             if ((r = get_user(v, (unsigned char *)data))) {
>> +                                     return r;
>> +                             }
>> +                             ++data;
>> +                             st[x] = v;
>> +                     }
>> +
>> +                     // next byte contains the flag
>> +                     // we only consume the remainder of the state if bit 1 is set
>> +                     // this allows the subsequent read/write
>> +                     rd->state.use_grbm = (st[4] & 1) ? 1 : 0;
>> +                     rd->state.use_srbm = (st[4] & 2) ? 1 : 0;
>> +                     rd->state.pg_lock  = (st[4] & 4) ? 1 : 0;
>> +
>> +                     // next 6 bytes are grbm data
>> +                     rd->state.grbm.se       =  ((u32)st[5]) | ((u32)st[6] << 8);
>> +                     rd->state.grbm.sh       =  ((u32)st[7]) | ((u32)st[8] << 8);
>> +                     rd->state.grbm.instance =  ((u32)st[9]) | ((u32)st[10] << 8);
>> +
>> +                     // next 8 are srbm data
>> +                     rd->state.srbm.me       =  ((u32)st[11]) | ((u32)st[12] << 8);
>> +                     rd->state.srbm.pipe     =  ((u32)st[13]) | ((u32)st[14] << 8);
>> +                     rd->state.srbm.queue    =  ((u32)st[15]) | ((u32)st[16] << 8);
>> +                     rd->state.srbm.vmid     =  ((u32)st[17]) | ((u32)st[18] << 8);
>> +                     break;
>> +             case AMDGPU_DEBUGFS_REGS2_IOC_READ:
>> +                     return amdgpu_debugfs_regs2_op(f, (char __user *)data, 0);
>> +             case AMDGPU_DEBUGFS_REGS2_IOC_WRITE:
>> +                     return amdgpu_debugfs_regs2_op(f, (char __user *)data, 1);
>> +             default:
>> +                     return -EINVAL;
>> +     }
>> +     return 0;
>> +}
>>
>>    /**
>>     * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>> @@ -1091,6 +1258,14 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>>        return result;
>>    }
>>
>> +static const struct file_operations amdgpu_debugfs_regs2_fops = {
>> +     .owner = THIS_MODULE,
>> +     .unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
>> +     .open = amdgpu_debugfs_regs2_open,
>> +     .release = amdgpu_debugfs_regs2_release,
>> +     .llseek = default_llseek
>> +};
>> +
>>    static const struct file_operations amdgpu_debugfs_regs_fops = {
>>        .owner = THIS_MODULE,
>>        .read = amdgpu_debugfs_regs_read,
>> @@ -1148,6 +1323,7 @@ static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
>>
>>    static const struct file_operations *debugfs_regs[] = {
>>        &amdgpu_debugfs_regs_fops,
>> +     &amdgpu_debugfs_regs2_fops,
>>        &amdgpu_debugfs_regs_didt_fops,
>>        &amdgpu_debugfs_regs_pcie_fops,
>>        &amdgpu_debugfs_regs_smc_fops,
>> @@ -1160,6 +1336,7 @@ static const struct file_operations *debugfs_regs[] = {
>>
>>    static const char *debugfs_regs_names[] = {
>>        "amdgpu_regs",
>> +     "amdgpu_regs2",
>>        "amdgpu_regs_didt",
>>        "amdgpu_regs_pcie",
>>        "amdgpu_regs_smc",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> index 141a8474e24f..04c81cd4bcc7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -22,6 +22,7 @@
>>     * OTHER DEALINGS IN THE SOFTWARE.
>>     *
>>     */
>> +#include <linux/ioctl.h>
>>
>>    /*
>>     * Debugfs
>> @@ -38,3 +39,34 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>    void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>    void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>>    int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>> +
>> +struct amdgpu_debugfs_regs2_data {
>> +     struct amdgpu_device *adev;
>> +     struct {
>> +             // regs state
>> +             int use_srbm,
>> +                 use_grbm,
>> +                 pg_lock;
>> +             struct {
>> +                     u32 se, sh, instance;
>> +             } grbm;
>> +             struct {
>> +                     u32 me, pipe, queue, vmid;
>> +             } srbm;
>> +             u32 offset;
>> +     } state;
>> +};
> This stuff needs to be in some shared header then.
>
>> +
>> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>> +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
>> +     AMDGPU_DEBUGFS_REGS2_CMD_READ,
>> +     AMDGPU_DEBUGFS_REGS2_CMD_WRITE,
> Why not just using the normal read and write functions?
>
> Christian.
>
>> +};
>> +
>> +struct amdgpu_debugfs_regs2_iocdata {
>> +     unsigned char t[32];
>> +};
>> +
>> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
>> +#define AMDGPU_DEBUGFS_REGS2_IOC_READ _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_WRITE, struct amdgpu_debugfs_regs2_iocdata)
>> +#define AMDGPU_DEBUGFS_REGS2_IOC_WRITE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_READ, struct amdgpu_debugfs_regs2_iocdata)

