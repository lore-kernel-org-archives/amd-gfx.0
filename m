Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A38C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 08:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FB52084D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 08:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GDKfj4br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FB52084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A5289D4B;
	Thu, 23 Apr 2020 08:52:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5F489D4B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 08:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIZE1U0V+JgvR/O7j6+t/FbU0nvdvf2s6h6/EVnpJe+A+ZfmwE1O8F9hgo2uR9SqQFcAajIpjrd3Wa8qdtE+d+gZ1fdsAFFORx9QARmeUVoUEhb8cTpIIMGgBDTHe+rN5HqjF+Yh1JBQdrhOEoXOQvqMiMye8fFiN08PFKJaxdlqwT3cqEiH4wVEBQDcmuFR7ldpETlLM1SChSsoZu+0sumzXi+xd6pw1q2rFTuBG06+5Ok0BEk+njPJZYve7dqoTinAJnXQk0T5vVqHjibMQgkz1CnBnHQ/Dvgo0Z0WtEnCv52w6pv9CdK5H+3XJT18qav/QwKtLZw8GDcCa7JDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtDy/k/ycZV8KOQzMwy/zNc8IFLlTlk0mdzXSl26H/M=;
 b=htSJSxI2KruLN2Uaff6sTZpgF+bnax+By7owW2GvorHJZfVVpPe+grW7O7KMf/nIc38MN/KcRGRHM4gVcFZKNR7tVkBAeE8HpYhjumnC1RWzR/qvMXckFy8LKtK+w688zT2v4pk0sVHjgPmmgoxqLeQ2aTDdTJgLonTHfzCo21z2FvbLLhDT/AYsEu7Cb6MTXoJ0NxpfUhk0bq3Q0oGHq8y8xDR6wqt72v6kOGHPy89Nbae9jzHqo7YEDxzuRuxgKQBaVvZEzwrW9S/Np26631e1sNmGoeUp4EhX3e+spIVgS+Oa0ZqyNwQ/PWtbS2Ysw3iKNAfqABoh6/I4sCNzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtDy/k/ycZV8KOQzMwy/zNc8IFLlTlk0mdzXSl26H/M=;
 b=GDKfj4brnU7+bRtVzHNyfKRpijGM1m+fxcRJIBG6FrNX6XkTSQR5jeGwpqbynHUbXlOcAthRnu/nTQmJF0EcepPotvHEraGC5sop6M65VLG/JfPP3ltFs/IAn2IpI+hIDt4B3TjhLBiC3cgHVa1XnhhU/P//ZS9ZstdB7fYIHak=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2650.namprd12.prod.outlook.com (2603:10b6:5:4a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 08:52:55 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.033; Thu, 23 Apr 2020
 08:52:55 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
To: jianzh@amd.com, amd-gfx@lists.freedesktop.org
References: <20200423071941.17440-1-jianzh@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <01ebed4a-b376-f5aa-3740-2006119271dd@amd.com>
Date: Thu, 23 Apr 2020 10:52:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200423071941.17440-1-jianzh@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 08:52:52 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1175800-2056-4c20-d148-08d7e763b678
X-MS-TrafficTypeDiagnostic: DM6PR12MB2650:|DM6PR12MB2650:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26500EDA35E8603AF69924C183D30@DM6PR12MB2650.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(6666004)(5660300002)(86362001)(8936002)(8676002)(31686004)(31696002)(36756003)(81156014)(66556008)(66476007)(6486002)(2906002)(66946007)(316002)(52116002)(2616005)(4326008)(186003)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPRsMAn/XzPuxW4RjuFKf99v0ZkGIhoWzY2LpTlGeNGNOpvQiMt9ryuZUuTIsKp92Qw3xBZWS4RhZJaTKm/2nZfa8BwzC9OqTRSp8oscVhzieb61+p7NaekI+kX5Aod3137G/MaTdKkXBmfeaZstAGjcbL8F5nWd1eDT+7j5jirObptMKdY79gWuMVVdoFFifVXAH+z4vACDqjrlN7Trp3I8GFFAgk7NDib2VvYjEFQbmttXsaHjIOFHfFoGphO0wDR2lzoEetH8Wji1V1tALKCU7WtEkkMCYFJ8Mth2XdmdoYARGES/xJuivZaZZmh/c4HxP8TSCIYiXDfQnnwgcQG/vYM1dIjAgT4XUVFPkl7Bz5KpGvSatbfoE1K9Pr9M02w13ouMOUzWlm7pCJ8DKWI1Zu59uJChA6NKknzwa72fKsFQRDpnfdkxUsYpOhxX
X-MS-Exchange-AntiSpam-MessageData: vIfRcmdg05/GVJh8/yAh83rSDxXlLNsyTRwpiSzyc8c5dTHN+6XLsFI5S+YcnGicCi2zvzKaJXbyg4rMs1GIz96SPKBcucyGlTT1Afr7WLPCMr5PAakaOokMP7J7SRleWm7FXrbxlV2Ggv+1TUqHsKtM1sCtAeka+rXRrL4RLVurflzR6Gq1EEYQZUQCpMTvUqE/xbCjWV0i+Ph8DSqmIcE6PVv8EqqJ67UmqmMtacmhoyZvG5kjuP9kJJMBrx8aUiKSCo4TWMtwFtElRtVWcv6USHzuee5lht84zHz0L7HAALX23FjT6pulGV/IomrtmqjZU1ynNQiy1E5o9Cj5SmPWWNVTaJzNrzQT5Pv9YPOYH0PYNTWTv7jdqQNevORGpsacmY6FFoxf1srxk5WIUaLLm9Al+stOsMLlGWHBVNfh/i/3TZ4xOH/QljIVGrCMF/mziRBiyhhc3tS+cntQNt+YoJU6oyLvpMbbvFhOA77f1ZtCkxbptkHMPHyBnEW5SOVKhKcRtcRhxHMQccrl4A2UrmtX3vxJkrP55T9Vghl3WFf7RpFdgiVe6iB+Ylg1i6QKaCwsbHwgTdS8vRlgOgDGXtfO1hVzFpAHM4mX3pjG6jAMDctpjmH6ElvR0etfWbk/AU9XYDl2gf0XnHpVB+CXpvMFGYouTgaYZImmaVRmbvSjZ8wsap+nNqK1dIaRBq9uP7Ua9/OwoVWJBbE5X+x/0jahrG/ALkzyOSrO38pl+fGpRGHNyMzdZ/19h3XfkU1eSi3te/VIL9p+QAPom/bB74k1pbsd/SbHjDVXyhYQ0RHnMci7FhBDXW3kkBXouhhH8fUDp4g1eaLyw04lrTRxQWu6WDJFQteQs7uw0EI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1175800-2056-4c20-d148-08d7e763b678
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 08:52:55.0232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwJwXOruhi0Q/Z2HLtiFwuORLBr+8BUyeucTxYKLqRHCDbSO5JFZWlXwXQAwmVJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2650
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
Cc: Pierre-eric.Pelloux-prayer@amd.com, Jiange Zhao <Jiange.Zhao@amd.com>,
 Felix.Kuehling@amd.com, Alexander.Deucher@amd.com, Monk.Liu@amd.com,
 Hawking.Zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.04.20 um 09:19 schrieb jianzh@amd.com:
> From: Jiange Zhao <Jiange.Zhao@amd.com>
>
> When GPU got timeout, it would notify an interested part
> of an opportunity to dump info before actual GPU reset.
>
> A usermode app would open 'autodump' node under debugfs system
> and poll() for readable/writable. When a GPU reset is due,
> amdgpu would notify usermode app through wait_queue_head and give
> it 10 minutes to dump info.
>
> After usermode app has done its work, this 'autodump' node is closed.
> On node closure, amdgpu gets to know the dump is done through
> the completion that is triggered in release().
>
> There is no write or read callback because necessary info can be
> obtained through dmesg and umr. Messages back and forth between
> usermode app and amdgpu are unnecessary.
>
> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  9 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>   4 files changed, 97 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index bc1e0fd71a09..a505b547f242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -724,6 +724,13 @@ struct amd_powerplay {
>   	const struct amd_pm_funcs *pp_funcs;
>   };
>   
> +struct amdgpu_autodump {
> +	bool				registered;
> +	struct completion		completed;

Registered and completed seems to have the same meaning.

> +	struct dentry			*dentry;
> +	struct wait_queue_head		gpu_hang_wait;
> +};
> +
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
>   struct amdgpu_device {
> @@ -990,6 +997,8 @@ struct amdgpu_device {
>   	char				product_number[16];
>   	char				product_name[32];
>   	char				serial[16];
> +
> +	struct amdgpu_autodump		autodump;
>   };
>   
>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 1a4894fa3693..cdd4bf00adee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -74,8 +74,91 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> +{
> +#if defined(CONFIG_DEBUG_FS)
> +	int ret;
> +	unsigned long tmo = 600*HZ;

In general please declare constant lines first and variable like "i" or 
"r" last.

> +
> +	if (!adev->autodump.registered)
> +		return 0;
> +
> +	wake_up_interruptible(&adev->autodump.gpu_hang_wait);
> +
> +	ret = wait_for_completion_interruptible_timeout(&adev->autodump.completed, tmo);

This is racy, in other words it can happen that a new client opens up 
the debugfs file without being signaled but blocks the reset here.

You could use two completion structures to avoid that.

> +	if (ret == 0) { /* time out and dump tool still not finish its dump*/
> +		pr_err("autodump: timeout before dump finished, move on to gpu recovery\n");
> +		return -ETIMEDOUT;
> +	}
> +#endif
> +	return 0;
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
> +{
> +	int ret;
> +	struct amdgpu_device *adev;
> +
> +	ret = simple_open(inode, file);
> +	if (ret)
> +		return ret;
> +
> +	adev = file->private_data;
> +	if (adev->autodump.registered == true)
> +		return -EINVAL;

Probably better to return -EBUSY here. And this is racy, and might need 
a lock e.g. multiple clients could open the file at the same time.

If we use a struct completion for registered we could use the spinlock 
of that one for protection here.

> +
> +	adev->autodump.registered = true;

You also need to reset the completion structure here otherwise only the 
first GPU reset would work with this.

> +
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_autodump_release(struct inode *inode, struct file *file)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +
> +	complete(&adev->autodump.completed);
> +	adev->autodump.registered = false;
> +
> +	return 0;
> +}
> +
> +unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct poll_table_struct *poll_table)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +
> +	poll_wait(file, &adev->autodump.gpu_hang_wait, poll_table);
> +
> +	if (adev->in_gpu_reset)
> +		return POLLIN | POLLRDNORM | POLLWRNORM;
> +
> +	return 0;
> +}
> +
> +static const struct file_operations autodump_debug_fops = {
> +	.owner = THIS_MODULE,
> +	.open = amdgpu_debugfs_autodump_open,
> +	.poll = amdgpu_debugfs_autodump_poll,
> +	.release = amdgpu_debugfs_autodump_release,
> +};
> +
> +static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
> +{
> +	struct dentry *entry;
> +
> +	init_completion(&adev->autodump.completed);
> +	init_waitqueue_head(&adev->autodump.gpu_hang_wait);
> +	adev->autodump.registered = false;
> +
> +	entry = debugfs_create_file("autodump", 0600,
> +			adev->ddev->primary->debugfs_root,
> +			adev, &autodump_debug_fops);
> +	adev->autodump.dentry = entry;
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>    *
> @@ -1434,6 +1517,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   
>   	amdgpu_ras_debugfs_create_all(adev);
>   
> +	amdgpu_debugfs_autodump_init(adev);
> +
>   	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>   					ARRAY_SIZE(amdgpu_debugfs_list));
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index de12d1101526..9428940a696d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>   int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3d601d5dd5af..44e54ea7af0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_full_reset  = *need_full_reset_arg;
>   
> +	amdgpu_debugfs_wait_dump(adev);
> +
>   	/* block all schedulers and reset given job's ring */
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
