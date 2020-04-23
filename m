Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D713C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D017A2076C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R2SDtNVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D017A2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8237389FF6;
	Thu, 23 Apr 2020 09:32:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EDAB89FF6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 09:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz7ln3+TD55pRH7X23IvCFrc56qqYZlqXhzk5oaPpOU0aK2alH4WtUXrDPbZuTPba1/HBEqwnA8LOIiIINRXpg3ZvJuyYs5Im7m1vHpXZRy2Nultu4f0WEFym4cLZv0IIIhlhEqjEGOMLTLOXMSDs2L1qM2lxbuESw+TRo4SULbcCgwbkyig5+XHONCxxYNpMVCMG2yoT0zg01BsPHS+I8kVQkdS3hU9QNYa8w+yXhILEZuvdqX3c9v/GZ4Y0fJg5wE8IuPoZikbxdGnwaULyWcZ3CKEPEMBT3eHfPF0dqwpYiU0KA/ssWGeIvtFvMlOAnkL01mDyXJfvDbhCAgcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQeC/EjXL3fBHNO/BP1DqPr7Nu1Iaxv4DZKGTsvBOKE=;
 b=Us54V79AjsCQpkbM414gKKK4yOK8vjF3F84z1n7Sf2s3Cznb5e2lsxjwJANpZ0B80wdea9o8wtS5JBHnIT9cbacUG7VIKnI5KVGZeyPLBeStlOHPbg7uKUhKSdB+1hCgxJPH9/MXIHN4+6g7clziSUVYe8Oy1oLe1DsZRmTyn0+Nc8ZYWQcZn2xsyRzpTsnjGbli0TWEQGRZG+GG+eeEEWhSfUrtOPKhbcm3AvsOPus2FstiYUn2lz5oYoWXWxp8z/FZ4LTtgKPSyVtpDAI2nqR8pAbQwylLPpNChiqASxEXlzcZbklbOQIT/QB1tB14doVWqdGhv9IVzEMP8hJqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQeC/EjXL3fBHNO/BP1DqPr7Nu1Iaxv4DZKGTsvBOKE=;
 b=R2SDtNVJiP73ZFvMQyQjWCm+94ebsakJZCDqpIbrGCs7uneT8x5Z23pkd6Un3rBNsWo++SouuekwwCnomyUsDR2XS80wvo8+LIn36NJAaneENdFZ41J7g9m2/VMyzwDjW41n18tdnjwUKE/awHMi9AzCwCOxvAawJG6gAJXVKx8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Pierre-eric.Pelloux-prayer@amd.com; 
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MW2PR12MB2473.namprd12.prod.outlook.com (2603:10b6:907:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Thu, 23 Apr
 2020 09:31:59 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::950a:443b:a92f:4e46]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::950a:443b:a92f:4e46%5]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 09:31:58 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
To: jianzh@amd.com, amd-gfx@lists.freedesktop.org
References: <20200423071941.17440-1-jianzh@amd.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <0cf441dc-0a87-c350-95f4-5ed99078f39c@amd.com>
Date: Thu, 23 Apr 2020 11:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200423071941.17440-1-jianzh@amd.com>
Content-Language: fr
X-ClientProxiedBy: PR3P192CA0051.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:57::26) To MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.219] (109.190.135.109) by
 PR3P192CA0051.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:57::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Thu, 23 Apr 2020 09:31:55 +0000
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a2b4286-70c0-4c60-c977-08d7e7692b90
X-MS-TrafficTypeDiagnostic: MW2PR12MB2473:|MW2PR12MB2473:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24739FC6D6B14915C9BDACE18DD30@MW2PR12MB2473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(8936002)(478600001)(16526019)(2616005)(4326008)(2906002)(956004)(5660300002)(6666004)(16576012)(55236004)(52116002)(53546011)(186003)(36756003)(316002)(31696002)(66476007)(66946007)(66556008)(81156014)(86362001)(26005)(31686004)(8676002)(6486002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKmsxBSxN3c2dvE2WMSe7bL0YGsvR4axUKWTq8QfW0W5QOFWyTbYUzcbRST8tASqCnHPaO6owYc7aVN3OGXxCILQZkdjKDl0dozQ10N3Muse3CMz++lqjkMQqmQsgQQJp2Xcs8EDFfPXWrYx1cR403FDN8soLHvSZ7QptD28Pb3a6z9Tm5Jqx8aDcav8K9XjtWbUqkUdX7/T0+63DWRnMPsvR1tX8qgRaznj8enpXjJ4hBWz9Gv/PoHV5K8mAHPChgLRVXO/LRlpwyjuZ+0kSZmegQ7SbMgVHPrKBUP1xXnomqwI83ha6UJPcb1c23UqO5/T3yqjHFxw5AIQunOYlDeW3SJwhS+zmWczzDdmdRW3Qda8pzz5jQWJE4AXa8tu3UpW7nNwB84DhkR0M92SDrquh7rXGWgqaix7IPS405w4ZnntV3CgkjFeCparc7Fk
X-MS-Exchange-AntiSpam-MessageData: I3amCcydWylHOWrSKE87C2wYnx6MkHJlxGW5gfXTIydP/h4T6RQbac1MW4L+C0f9aGJP/lik/hyzJAPgkzTYvw9LYiWbMOpQRsV2W250YN/CxNaQJENASj0+Qkp26zZ8LP+bCgDbU/wmR8p3AqlWFw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2b4286-70c0-4c60-c977-08d7e7692b90
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 09:31:58.7434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8Lf2E/i6koudu1fIClLosNszn7UdTRJbZtHm8VhvfyNIhnlRdLR3dgz7mtcQ7beAgKnT68FeYJA4dIi6hlaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2473
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
 Felix.Kuehling@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Monk.Liu@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

The build fails for me with this patch applied (poll_wait, POLLIN,
POLLRDNORM and POLLWRNORM are undeclared).

Adding "#include <linux/poll.h>" to amdgpu_debugfs.c fixes it.

Pierre-Eric

On 23/04/2020 09:19, jianzh@amd.com wrote:
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  9 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>  4 files changed, 97 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index bc1e0fd71a09..a505b547f242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -724,6 +724,13 @@ struct amd_powerplay {
>  	const struct amd_pm_funcs *pp_funcs;
>  };
>  
> +struct amdgpu_autodump {
> +	bool				registered;
> +	struct completion		completed;
> +	struct dentry			*dentry;
> +	struct wait_queue_head		gpu_hang_wait;
> +};
> +
>  #define AMDGPU_RESET_MAGIC_NUM 64
>  #define AMDGPU_MAX_DF_PERFMONS 4
>  struct amdgpu_device {
> @@ -990,6 +997,8 @@ struct amdgpu_device {
>  	char				product_number[16];
>  	char				product_name[32];
>  	char				serial[16];
> +
> +	struct amdgpu_autodump		autodump;
>  };
>  
>  static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 1a4894fa3693..cdd4bf00adee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -74,8 +74,91 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> +{
> +#if defined(CONFIG_DEBUG_FS)
> +	int ret;
> +	unsigned long tmo = 600*HZ;
> +
> +	if (!adev->autodump.registered)
> +		return 0;
> +
> +	wake_up_interruptible(&adev->autodump.gpu_hang_wait);
> +
> +	ret = wait_for_completion_interruptible_timeout(&adev->autodump.completed, tmo);
> +	if (ret == 0) { /* time out and dump tool still not finish its dump*/
> +		pr_err("autodump: timeout before dump finished, move on to gpu recovery\n");
> +		return -ETIMEDOUT;
> +	}
> +#endif
> +	return 0;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
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
> +
> +	adev->autodump.registered = true;
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
>  /**
>   * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>   *
> @@ -1434,6 +1517,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  
>  	amdgpu_ras_debugfs_create_all(adev);
>  
> +	amdgpu_debugfs_autodump_init(adev);
> +
>  	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>  					ARRAY_SIZE(amdgpu_debugfs_list));
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index de12d1101526..9428940a696d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>  int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>  int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>  int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3d601d5dd5af..44e54ea7af0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>  	int i, r = 0;
>  	bool need_full_reset  = *need_full_reset_arg;
>  
> +	amdgpu_debugfs_wait_dump(adev);
> +
>  	/* block all schedulers and reset given job's ring */
>  	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  		struct amdgpu_ring *ring = adev->rings[i];
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
