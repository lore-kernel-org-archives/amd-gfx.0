Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C341C2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 07:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D8320774
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 07:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3OUon04O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D8320774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1EF6EA86;
	Fri, 24 Apr 2020 07:47:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A29C46EA86
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 07:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXu71y5hqwGlRHtfu4qBofwBxsW4trb63wMknhrzT+iDdYs6qbZsTEl4L+Eo5DVaxBNS04X24bM7w1YA/BXIT6cHPtvjvwp0nfrA9vGMMbAubk48ftto7IbgZKA9gaYrQGF4slvDpjfidgfn594gAls2tZOeArQA/kQmLDQFrveDipLxeqRKiJlhCgtV5dnVhHfiPKZQJdZC5ak5W9B89FnUZb/eEmNTjtZapovy/rync2irKQHy6OCX4I8Wp6D9Yiq/ry1n855Map+9Qwbu2zA8QP3XfZck0YfjHPDFl/1NDkYBkDaLmmkp6jTt45I0Hv3CNV7JFQ3zSSsfnzz0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5na8QH3mrKF6pq/OKMKTASHas6hEKhDT//z7Jo58vC8=;
 b=SJ82wK5q20MHGbCHnEu8Ikxf6tKBa9rLMZAm+DeuwCFTs2A9RKcTpoxC9stYbH9ZL618detdqHFQzZXX/Pmd1hU/KH/osb5n02PVFXOK/++Khz3BCnZ+0Mmmlj2QKETi3JHvltCp0INACh9CAoIMoii1yBIDGk+1i5eyZYajIrJT9c1rM74XqFJMdpzw37lKTLAgklKJyi5tc3DS0i6R9mSbYf1DgGcpekveGSFzfncnJ8edyDVanA4euxbG/qdreoZxHOnuHcUeFueDPp2ToK5dyd7iGuiArWxO5jVFL+xXbUS4FoGuB+Y3PHHNWQILl2VWa7lnkt8i2JHYi9chEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5na8QH3mrKF6pq/OKMKTASHas6hEKhDT//z7Jo58vC8=;
 b=3OUon04OFBWQpXiMOM8Q0Hmnxr7WTvPLEvQQihvuA4d59MCvYI5p0A7GM8c8L836NOB4xO+oSRrqwodyHjxX5cEgdudJKbWlivKi5nRM1ewu8KMQ2QZfLg3WBg50C30shqoXko9E7RBN8Oxf08o1HE5S1ugULjakAgAxiUgb0qA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Pierre-eric.Pelloux-prayer@amd.com; 
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MW2PR12MB2492.namprd12.prod.outlook.com (2603:10b6:907:8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 07:47:04 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::950a:443b:a92f:4e46]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::950a:443b:a92f:4e46%5]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 07:47:04 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200423071941.17440-1-jianzh@amd.com>
 <01ebed4a-b376-f5aa-3740-2006119271dd@amd.com>
 <BY5PR12MB3844DC59B0DACE73ABDF2E27E1D30@BY5PR12MB3844.namprd12.prod.outlook.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <8078fb6a-c398-a02a-da6f-79a67e5d9e3d@amd.com>
Date: Fri, 24 Apr 2020 09:46:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <BY5PR12MB3844DC59B0DACE73ABDF2E27E1D30@BY5PR12MB3844.namprd12.prod.outlook.com>
Content-Language: fr
X-ClientProxiedBy: PR0P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::31) To MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.219] (109.190.135.109) by
 PR0P264CA0091.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 07:47:01 +0000
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc2677d3-feb0-4c05-b0e6-08d7e823adf7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2492:|MW2PR12MB2492:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2492576C5588617AA631408D8DD00@MW2PR12MB2492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(66476007)(26005)(31696002)(8936002)(81156014)(956004)(6486002)(8676002)(66946007)(86362001)(2616005)(52116002)(110136005)(31686004)(316002)(5660300002)(4326008)(36756003)(54906003)(16526019)(186003)(66556008)(2906002)(478600001)(53546011)(966005)(6666004)(16576012)(55236004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dgS7flTUNvYDCvYbjmOMXcg2XNU/Lex/BO5xMcmA+KhNYfeK/FXq5iLGO4P+KJEJQ0WS9I000AbJjo8qjhr4OUfijPQ7Wpdmq2/XGvbBqVEOYAyFP4iUTDXqTovw9/kKS0LKF3qK51XiUNm0N5by0umuyovYbcw8H1cUOk3/VCTCd8vjV5i+vzMYnKPuLwp+cwaRNPFKfNHzFG2VIB1D+F01BK7rftCkQDj+IO1FMKOy3iXC3KYeT8/tPFlXJfLnpev+FUvTMfBXGelRP9uTMxdKbdfLZ6IYxwqvIl4+Gt8Aiqf+MukAqtYmQWspjGEfsRxLTYdZyJ9fR6nmtz+IdNgEyWd1SDplTsHoDCwwO1jpmKvSESeqDSqS+F1HPYccuqQFdAjaylKl+wn3Bkk05xC3n4b4Y48Wtvngm3i2TkhB1ru2EI7CI8J48GBOZTFQlDxps3bshPIqNETgytkm95GWfJe90ayZSHTpG/pnOs=
X-MS-Exchange-AntiSpam-MessageData: aitEJxGLIkczaWIVECeb2A30PIrcbQnDR/KqW6Oynw5iCa4/eOHAQ2/gD4tmtr3RLIYmWgueN1+NWm88/Ag+DEYpzjmE/mgxSCToGmn94v0+55feUNgh4xRlvVJipDC22RRGmws9Rtb562o3pM3b0w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2677d3-feb0-4c05-b0e6-08d7e823adf7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 07:47:04.3341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8m0RxYpG04/wUCEGYehTxrC6oDEvl6woeot61BIOe6Br2BgOfEgLQGAQxCCmmdbycQgHHvfY6O8TB4wijSbINg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2492
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Jiange,

FYI I'm working on adding a new "--autodump" command to umr that uses this feature.
This is not yet merged but you can find the code here: https://gitlab.freedesktop.org/pepp/umr/-/tree/autodump

> (3) At the same time, considering the use case of this node, I believe that only the first GPU reset is worthy of a dump.

If it's possible I'd like to be able to do multiple dumps instead of limiting ourselves to only the first one.

Thanks!
Pierre-Eric



> (4) I didn't implement race condition guard because I believe that this node caters for a cautious super-user and a single client is enough to do all the work. I can add the logic if you think it is necessary.
> 
> Jiange
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com> 
> Sent: Thursday, April 23, 2020 4:53 PM
> To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
> 
> Am 23.04.20 um 09:19 schrieb jianzh@amd.com:
>> From: Jiange Zhao <Jiange.Zhao@amd.com>
>>
>> When GPU got timeout, it would notify an interested part of an 
>> opportunity to dump info before actual GPU reset.
>>
>> A usermode app would open 'autodump' node under debugfs system and 
>> poll() for readable/writable. When a GPU reset is due, amdgpu would 
>> notify usermode app through wait_queue_head and give it 10 minutes to 
>> dump info.
>>
>> After usermode app has done its work, this 'autodump' node is closed.
>> On node closure, amdgpu gets to know the dump is done through the 
>> completion that is triggered in release().
>>
>> There is no write or read callback because necessary info can be 
>> obtained through dmesg and umr. Messages back and forth between 
>> usermode app and amdgpu are unnecessary.
>>
>> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  9 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 +++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>>   4 files changed, 97 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index bc1e0fd71a09..a505b547f242 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -724,6 +724,13 @@ struct amd_powerplay {
>>   	const struct amd_pm_funcs *pp_funcs;
>>   };
>>   
>> +struct amdgpu_autodump {
>> +	bool				registered;
>> +	struct completion		completed;
> 
> Registered and completed seems to have the same meaning.
> 
>> +	struct dentry			*dentry;
>> +	struct wait_queue_head		gpu_hang_wait;
>> +};
>> +
>>   #define AMDGPU_RESET_MAGIC_NUM 64
>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>   struct amdgpu_device {
>> @@ -990,6 +997,8 @@ struct amdgpu_device {
>>   	char				product_number[16];
>>   	char				product_name[32];
>>   	char				serial[16];
>> +
>> +	struct amdgpu_autodump		autodump;
>>   };
>>   
>>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct 
>> ttm_bo_device *bdev) diff --git 
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 1a4894fa3693..cdd4bf00adee 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -74,8 +74,91 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>>   	return 0;
>>   }
>>   
>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev) { #if 
>> +defined(CONFIG_DEBUG_FS)
>> +	int ret;
>> +	unsigned long tmo = 600*HZ;
> 
> In general please declare constant lines first and variable like "i" or "r" last.
> 
>> +
>> +	if (!adev->autodump.registered)
>> +		return 0;
>> +
>> +	wake_up_interruptible(&adev->autodump.gpu_hang_wait);
>> +
>> +	ret = 
>> +wait_for_completion_interruptible_timeout(&adev->autodump.completed, 
>> +tmo);
> 
> This is racy, in other words it can happen that a new client opens up the debugfs file without being signaled but blocks the reset here.
> 
> You could use two completion structures to avoid that.
> 
>> +	if (ret == 0) { /* time out and dump tool still not finish its dump*/
>> +		pr_err("autodump: timeout before dump finished, move on to gpu recovery\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +#endif
>> +	return 0;
>> +}
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>>   
>> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct 
>> +file *file) {
>> +	int ret;
>> +	struct amdgpu_device *adev;
>> +
>> +	ret = simple_open(inode, file);
>> +	if (ret)
>> +		return ret;
>> +
>> +	adev = file->private_data;
>> +	if (adev->autodump.registered == true)
>> +		return -EINVAL;
> 
> Probably better to return -EBUSY here. And this is racy, and might need a lock e.g. multiple clients could open the file at the same time.
> 
> If we use a struct completion for registered we could use the spinlock of that one for protection here.
> 
>> +
>> +	adev->autodump.registered = true;
> 
> You also need to reset the completion structure here otherwise only the first GPU reset would work with this.
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_autodump_release(struct inode *inode, 
>> +struct file *file) {
>> +	struct amdgpu_device *adev = file->private_data;
>> +
>> +	complete(&adev->autodump.completed);
>> +	adev->autodump.registered = false;
>> +
>> +	return 0;
>> +}
>> +
>> +unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct 
>> +poll_table_struct *poll_table) {
>> +	struct amdgpu_device *adev = file->private_data;
>> +
>> +	poll_wait(file, &adev->autodump.gpu_hang_wait, poll_table);
>> +
>> +	if (adev->in_gpu_reset)
>> +		return POLLIN | POLLRDNORM | POLLWRNORM;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations autodump_debug_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = amdgpu_debugfs_autodump_open,
>> +	.poll = amdgpu_debugfs_autodump_poll,
>> +	.release = amdgpu_debugfs_autodump_release, };
>> +
>> +static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev) {
>> +	struct dentry *entry;
>> +
>> +	init_completion(&adev->autodump.completed);
>> +	init_waitqueue_head(&adev->autodump.gpu_hang_wait);
>> +	adev->autodump.registered = false;
>> +
>> +	entry = debugfs_create_file("autodump", 0600,
>> +			adev->ddev->primary->debugfs_root,
>> +			adev, &autodump_debug_fops);
>> +	adev->autodump.dentry = entry;
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>>    *
>> @@ -1434,6 +1517,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>   
>>   	amdgpu_ras_debugfs_create_all(adev);
>>   
>> +	amdgpu_debugfs_autodump_init(adev);
>> +
>>   	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>>   					ARRAY_SIZE(amdgpu_debugfs_list));
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> index de12d1101526..9428940a696d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>>   int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>   int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 3d601d5dd5af..44e54ea7af0f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>   	int i, r = 0;
>>   	bool need_full_reset  = *need_full_reset_arg;
>>   
>> +	amdgpu_debugfs_wait_dump(adev);
>> +
>>   	/* block all schedulers and reset given job's ring */
>>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>   		struct amdgpu_ring *ring = adev->rings[i];
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
