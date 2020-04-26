Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408E5C55191
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 10:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075012070A
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 10:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LICorDPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075012070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE88189BF5;
	Sun, 26 Apr 2020 10:40:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFC189BF5
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 10:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8zuTPk79Wi4YzxZZSfyx8124EDHjNWKuY6MinXcNCqXdaoZ/fWuV0+KdCTvrrNJQTtFJGJPsW3w1P3XbfORtW6q/Ji0uHs5IMu+iXjjTzZ0JF1uIlp/jQJ3tFWVP8/GjIKdCByjBo89bnsLk8iVi4G+kd10WnSBY5jxc9IjDT//TxJphic4VSKkPNQJ4ikkT6JYjBM4FScxv4lgg+LLvo3BVT/Wv3RpAeo1HBsje9TSl2lvgJTN4UWZ3rIwmUJ2zzxUtxvM8S7As2Kvie6MZqSAOULQsJg9ose3Ill4pKA9/5ls0sRZyMs3kb9PLdkrP8PDd7I1+Jtk+kYuvmUEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vccB4a+tS9L8pLAKE6qrknmmKhjK1zkFBmOV0y77gps=;
 b=l6yZRBlMhgBDzY3fDtPrhztZ4cDTHRWaqVE3DPCkrjnH0wDCLB9ky64yt05jK5xCQCW4oyCfevrtsJPIcmlNYpCtyVKnFxTxDp1xfctlu7eq2a3eWN5paMvAoHTK0HbBVkG0CB0ynKixzLMZcNXdGZYM8hEcDxafdkLz960rMGCikaVPsciKVhcK98/jxTWMwQe0ifLWkORXOn4KAhACopSM+N1zJDdPfhkGaRrHtMv+D7zg9To5KgDKFLuu+yvZVMZiqdwNevrz2dGe+DDdjKCzG5pdXkZaJWacQxep9hbzHUEUGDOrk0yS+nM8HfvT1xwoGnm9KdYsYpZDDVlvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vccB4a+tS9L8pLAKE6qrknmmKhjK1zkFBmOV0y77gps=;
 b=LICorDPHHmfo9w40TqNGgJ0O0Ids5fZRMgd46TPzciWdo8uTpeEYeJTS8w4ltACC1oljeuwY4u3a7YWVojzicpfmCTtIk3FDA6vLJjQMpg3jeYF+4idy+4VM+XtXw5FdvFsA4r9bSQ06aMtw+NF7sOF5JgyG5wKw/M6q4wNcLg0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 10:40:49 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 10:40:49 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
To: jianzh@amd.com, amd-gfx@lists.freedesktop.org
References: <20200426100945.17066-1-jianzh@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f75532c3-d640-e481-dc99-b30812ee0da9@amd.com>
Date: Sun, 26 Apr 2020 12:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200426100945.17066-1-jianzh@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::33) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR07CA0020.eurprd07.prod.outlook.com (2603:10a6:208:ac::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.9 via Frontend Transport; Sun, 26 Apr 2020 10:40:47 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b79c20fb-fb49-40d0-3d66-08d7e9ce4899
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:|DM6PR12MB3179:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3179EC2294385D238005640983AE0@DM6PR12MB3179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(66476007)(5660300002)(36756003)(6486002)(478600001)(66556008)(66946007)(6666004)(31696002)(86362001)(186003)(4326008)(2616005)(316002)(16526019)(31686004)(8676002)(81156014)(52116002)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nTPZZtl9ipLg1V7LE98iY7UG2hG0aZTPDXRetXZDHkrWLseMuGENZNKFytHZZlWjM1obBUy3SfEAY8srlJSp5ssbthSZPLvRBJlzUc3QlQHBre6Yd5dzQpAvdSEiEWIZ2F9oBBJp7toEMNnSLeE31nY5m1rZChYJ+4iQNRrot5heLBKdLAIyHC1+yi/XHEu4Vk9XhUJUiPxws5wuD4STXon+gHzNznSxa/uQT+4gpPLA1p55njkB/2qFFk9U0CvM5+KgEBqNbeZLJDwamnxFIMK6p14SCaSwkjHP/n7tvyhILfswL8Zl2Rr/9aolvB67viB8EK3ml4AekSc4hdSU82yZxHddmY+GhuQpOQZRMrCyDq5cwMU8HqMw6SuaC63L8C4tyg0dCFa1uTMkptajVD3h+c1L3vn0+7XPMjRVYuBkbdI1cOjdhj5P0D9PG3B
X-MS-Exchange-AntiSpam-MessageData: 0jZk30uNWO7QyZSBq32oCnBaCe13wDGN0UnssNQhB/1XTEPVjtrANNfa1lsBuJ+bbcBuNEXAgrGX9+uyQn00qUBgZc/N36r9fyAIGFPrtHNAWpw0z87+MQ5hQd7DIk+LW3EtcO1LAUIjcm70PwSM3LrZ6ERW+P4gPzQsvPgrnw8rUwKSLpHy6vDQadasJQASVY1uGdGSkvJEWLFbh6K/VWuwlhxEr3QeUtgqeCNvY/xJSxqlyak87pxweZHnLw3VL2J4jB6wYB3dFYthc8piGTu6/xfudQSd2PhGtWbDDpNl8uWBlvhB8LHURGr7xVEYda4gYJGXSeNqvOA4YCnH7c5n6p5Pfm4L3INmy3QdG8Ml7+O2bRzg0vifsTMTOUi3kB+l5R54gkEEEr1sCXkY9jsD5V1zWLI8WwKqzH0AeoMdDdnJ6f31rH3T/2DQJ6jLDLZ7G4eYtbMYOvk6xAsGcFcpkOM3aszPHw3dBMCwVhvuOGI4EBit2r/q27Xd0SVsUUAFRNa6B620Lj6vpMXYrhiX4sxVpQnMZNX0wfD271zYWXxw1NcM+PMc5jbF8czKnP5UVkwZJmprr23PJC7OaWfRobD2tbEZmorWuVW6GtM/Iu2LDn5K0nvvgGTLa11IjkYGXi6Ni5ofhKUGg2posIFG7O1njkQpkKoeTYrNwrYPg7lHe58YTF0HWENrgoZLeQG9ZThSOXqDxa0RkF6ZREnHXJY3IdnPuJz3O0mUGwddVqvk1ArvAqVV29mbmgzXGABjjMPFgCoH6rtRzFQ4weo8aOAzuvA0nGoNhZO2zzelQZeUOIAZGsMpt/HI00hqPzX8p2SjS7A8ztVxiiqnXpLlYljICiHsIb2TUCtXT3g=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79c20fb-fb49-40d0-3d66-08d7e9ce4899
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 10:40:48.8583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyjUe/Vb7jzQgCA6qx44tBMwdYGccBN1aFPJsz7rQ0SUuTHe/ag9y2EMI9lxhVpH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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

Am 26.04.20 um 12:09 schrieb jianzh@amd.com:
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
> v2: (1) changed 'registered' to 'app_listening'
>      (2) add a mutex in open() to prevent race condition
>
> v3 (chk): grab the reset lock to avoid race in autodump_open,
>            rename debugfs file to amdgpu_autodump,
>            provide autodump_read as well,
>            style and code cleanups
>
> v4: add 'bool app_listening' to differentiate situations, so that
>      the node can be reopened; also, there is no need to wait for
>      completion when no app is waiting for a dump.

NAK, exactly that is racy and should be avoided.

What problem are you seeing here?

Regards,
Christian.

>
> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 82 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  7 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>   4 files changed, 92 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index bc1e0fd71a09..6f8ef98c4b97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -990,6 +990,8 @@ struct amdgpu_device {
>   	char				product_number[16];
>   	char				product_name[32];
>   	char				serial[16];
> +
> +	struct amdgpu_autodump		autodump;
>   };
>   
>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 1a4894fa3693..04720264e8b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -27,7 +27,7 @@
>   #include <linux/pci.h>
>   #include <linux/uaccess.h>
>   #include <linux/pm_runtime.h>
> -
> +#include <linux/poll.h>
>   #include <drm/drm_debugfs.h>
>   
>   #include "amdgpu.h"
> @@ -74,7 +74,85 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> +{
>   #if defined(CONFIG_DEBUG_FS)
> +	unsigned long timeout = 600 * HZ;
> +	int ret;
> +
> +	if (!adev->autodump.app_listening)
> +		return 0;
> +
> +	wake_up_interruptible(&adev->autodump.gpu_hang);
> +
> +	ret = wait_for_completion_interruptible_timeout(&adev->autodump.dumping, timeout);
> +	if (ret == 0) {
> +		pr_err("autodump: timeout, move on to gpu recovery\n");
> +		return -ETIMEDOUT;
> +	}
> +#endif
> +	return 0;
> +}
> +
> +#if defined(CONFIG_DEBUG_FS)
> +
> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
> +{
> +	struct amdgpu_device *adev = inode->i_private;
> +	int ret;
> +
> +	file->private_data = adev;
> +
> +	mutex_lock(&adev->lock_reset);
> +	if (!adev->autodump.app_listening) {
> +		adev->autodump.app_listening = true;
> +		ret = 0;
> +	} else {
> +		ret = -EBUSY;
> +	}
> +	mutex_unlock(&adev->lock_reset);
> +
> +	return ret;
> +}
> +
> +static int amdgpu_debugfs_autodump_release(struct inode *inode, struct file *file)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +
> +	complete(&adev->autodump.dumping);
> +	adev->autodump.app_listening = false;
> +	return 0;
> +}
> +
> +static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct poll_table_struct *poll_table)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +
> +	poll_wait(file, &adev->autodump.gpu_hang, poll_table);
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
> +static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
> +{
> +	init_completion(&adev->autodump.dumping);
> +	init_waitqueue_head(&adev->autodump.gpu_hang);
> +	adev->autodump.app_listening = false;
> +
> +	debugfs_create_file("amdgpu_autodump", 0600,
> +		adev->ddev->primary->debugfs_root,
> +		adev, &autodump_debug_fops);
> +}
>   
>   /**
>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
> @@ -1434,6 +1512,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   
>   	amdgpu_ras_debugfs_create_all(adev);
>   
> +	amdgpu_debugfs_autodump_init(adev);
> +
>   	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>   					ARRAY_SIZE(amdgpu_debugfs_list));
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index de12d1101526..72f6fe5c7596 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -31,6 +31,12 @@ struct amdgpu_debugfs {
>   	unsigned		num_files;
>   };
>   
> +struct amdgpu_autodump {
> +	bool			app_listening;
> +	struct completion       dumping;
> +	struct wait_queue_head  gpu_hang;
> +};
> +
>   int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_fini(struct amdgpu_device *adev);
> @@ -40,3 +46,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>   int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e6978a2c26b7..8109946075b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3912,6 +3912,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
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
