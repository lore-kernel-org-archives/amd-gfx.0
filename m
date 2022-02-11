Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B898C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 11:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817B810EAD0;
	Fri, 11 Feb 2022 11:52:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B376A10EAD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 11:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkqmIKY7smA9EFTv1L7FgKKWbUpTAlngN5OXqaIA98w12f2Tp+E/xS3exgQu1SmoNE/O9VGZHIYlwfxKi7qpYzW/3iOKR9il8nYDtEiL5gkkHCS0kOB/nGB/c7XQfB+zTtSglo8AGfCKW3zoqq0v9tubPvFfBc9VAI1pjZNtTpWnxyB8dmABdSRn7scrJVbGS2k3P7JYjcRT+VU4lPs8WsS4vP/oPNsx98SdqJ0PGHzhz9KLP+bFYnSrZxJXhf065hQ8GyhOS2ZRdaYZZd9HG2wmzjDZG9IrGg7CpW3LXn56unQzQz4zixTF/9Up3GbB0kFL6WHuxV1nFj/ACfPjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hlh7lkcSShRPeghajFuT6Hm4fDrVlQRTqkC6IEWn4g=;
 b=JGTDdrDZEeqPCtqgw3Uk9OZM8EYgS9y4E4N/usI0y8uN62yIGcMMXFw3ZNRqvp6ue6AkgBuZcvzzmdq9w4sI4G8/+lnGGbr4gUBxqXeU6a5bL+50pIPxDcYhQpPJmWvBDo05HfE3fKffqOPFlFuaaOMJyZLI8WLL9u3US/d1cwRgIOebNoUAcqWLGPri+xEMGgP5YrBYQYNslu4ppzRO81Ans+NowWasNuC9gL7r7NVcBpJ1sspSTndLWARFCGiWItZlmPRY4bvtAXsFbhKm0CHl9hlNuRN2IYPlJu1ew4a5POylGgUNjZU18XHGUX3+2a0EEoSq7qPRk0Ig3hu/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hlh7lkcSShRPeghajFuT6Hm4fDrVlQRTqkC6IEWn4g=;
 b=U9RkM+xAIB5eF7VQD1y6w92oshPpA2/ZPLbcB4rW6NvHN+1I5un1QCXsT4iMKkxd6mdzBT9awWv56JZAocohY07zlhgSUc+CFROGJGN8FCV1i6D2ew3aOgh3l8EBXz3bBwvLXEMuHspwY2e41C33NlbKeQqe5qylLYz9b87HSDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4971.namprd12.prod.outlook.com (2603:10b6:610:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 11:52:26 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4975.012; Fri, 11 Feb 2022
 11:52:25 +0000
Message-ID: <a7c372d6-0ea5-a41f-88c5-77784ebe0811@amd.com>
Date: Fri, 11 Feb 2022 12:52:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220211114740.10904-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220211114740.10904-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5P194CA0004.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf3363c3-d126-4f05-8288-08d9ed54f8a2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4971:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4971EA7C81B5CFFCDCA0D0A983309@CH2PR12MB4971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVWgA9vtiJeYkXyHeogZwYc6uJeDwqCuUYi+WyUjDrj0sYrsMcBScFbnCOkaoTggJN0Yibd3ohwZX/sE/FB7CXxKS9D2apojfA81c7bF91MYULsUl6KrqtJJfOgblEkDwX8B3ElkkxJQaUjdpmV8X1P1f26i8o2bQkyyQiIlqqGmlq7WmDRnwpciykXLgsFaWMFNohWLZlTePyKagaYkprA4LbOX2F9klKuZ2m/5BD6cPj/RJ5aPhXyWen9vpjRn+NZGaku3+ehs8IuYnFC76rznwG5WWeDvdPyN1sHWJ8898/OLoFathB2MTQtmrHxY0aq9Excgp7kt3wga5j3yrAIb34RnzolYxFaxGM9NO3T8nPFhW952xueSemlDdDJ4Kc+6TXHauk/R2ml7ZsbbKhuqCwnbv8LOKZAzIawNMyqzpqf9lxfd4iaBChczQPitCpT3Crlfvq9TIsBkg5zYi7kd4e9ZFsxUrFAH+UpHAINXF+LX/w46rd/rzKR9JrCkb2GrDDLpFK9eMyC5/s2wQETefD2CgdT2MJOWqXNO0AIHv5JzCaEl8kNuXhj6nKY4I7RwzzZg04PU38V1lBuVr1Yjs3rgOMiMP/cewYEQ0wcnf5NRAVqo0Rz93nHNOhuZAklcwdhvagTOFYj5BbsZOGDJthKf+8dIvADM00bAfPYIwK/Fl5XAc6hzjQ6aEkqM4bqYOH9sf8g4JToKWhWwzs62kbaJtdeYrgXPaaMEYa3FaEPZZXZayoheCpbfvzTy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(6486002)(5660300002)(66476007)(508600001)(38100700002)(66946007)(86362001)(26005)(186003)(31696002)(6512007)(6666004)(31686004)(6506007)(8676002)(2616005)(2906002)(8936002)(4326008)(316002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STAwaC96NlFoZFVYUWZxMEZZSlRreDlxMEZsY1ZQYlJPZUZwQmtGdEQ0NHlQ?=
 =?utf-8?B?Qm5QQ1dzR0p5UzgrN0pFTmtNL1lGRS9nbXZ1UWNObTlFbUdSWkFhN1BWU0FP?=
 =?utf-8?B?d0xWeVB5aXR2cHlTQjVoNzR5SVhBSW5BWitONVZSRFh0bm41dmtuTkh3SWRm?=
 =?utf-8?B?K3Y2RVBjdjNmN2F5elc3K1JlejFySjhETHU5RTRlc3NMZ3UvU0ovOEgra0c1?=
 =?utf-8?B?UzloVVRCVmtOdndlVkhHb2ptQ2dpcS9OdmlYQnJZclladUpmT29EaksvQ2dn?=
 =?utf-8?B?MUNPOHlXRzliMzlWd3Z0ZkZaWG8vRU9mVVJNei9ZY09MNXVYcFgrQ1dtQ2NE?=
 =?utf-8?B?WnFyYUk1bDcybmU1NzFjY1hkRjZ6VmU2dE1QQ0VnTXJEcENHNlVXWWt3Ujht?=
 =?utf-8?B?VzI2NlU1bHNPUmJuVVNVQlFCbzdtaGdDYmx5bnlHWllaaDN3aXRyUW44dzNS?=
 =?utf-8?B?SGM0QU9uZWI3VnpDbmF5anFkUGp6dGh6a0p2eG1ja3pzakxyVmkzMWxoc2NO?=
 =?utf-8?B?RHBiaU5Rem1jbHdrbmZjU1dqeUt2NW15VWMrTEJmNkw2SUt1L0h5VEwyWk4z?=
 =?utf-8?B?SXhmcHZia1RNaWFIcmxoa0NNaFV6bHovcTBhaDl6U084VkVBSUREN2VrOHJK?=
 =?utf-8?B?WjY4WGd6NTFKRVEwLzRRYWpmTHNLRDNTQmtDaitnQWhGTEVVazNUTUljWmJV?=
 =?utf-8?B?WkNQY0FELzJGM0NITjJ5VWYvUWI5dEp4NzNXR096ZTBHT2psd0F1K2lyQnk1?=
 =?utf-8?B?aXZQOFlGcUFtTSt4UWhJVzIzcUJlR04vK0NCOGNsWFdyQ2dtN3BZbjR6MUFV?=
 =?utf-8?B?TjVWNTBTUEJ2ZWxoSTJkYzRZNEdYUHJWbEJ1ekJRYmVSY0t6V2VFZW5zUnJH?=
 =?utf-8?B?OE01djgraWtBd3FoM2J1SzYxNENjejhsNHVDOG1HQWZnRXZObG1mNTFzQlFJ?=
 =?utf-8?B?UWpWWW5RNEZZbGdiVUNKcE5DUWQ5SGF4ZE5ySmNLZy81R1hrRmU1MXk2UUhK?=
 =?utf-8?B?SGtrYmxRVnhRejdXelk4d0w4U3RKT0hBSURTOWVkWjJCaU1HUW5WZHBpeDRT?=
 =?utf-8?B?b2JzTm51Y2VLUEpLdXZ5UUcwQUNzbXZyWUFWZi9Jbnd5OW1DVVZMUlF4d2pa?=
 =?utf-8?B?cDhaZ0x0bFp3eEJVb0JJQWxSM1QrSzZoaXdKaGRTeEt6dk4zK3l5L0lMZGFH?=
 =?utf-8?B?UERabS9NMHNhRWlVMnhCMmRCTlhlMXdLaDlJVm90TGFhN01tNHB1cUVCb0I4?=
 =?utf-8?B?QU8rVDVYZ3phZllwV0RJVWFVSlJ6SDVuRThrZkVxbjVnazFQdmcwcXA1S1Vy?=
 =?utf-8?B?dmltU29tM3Nab1dBTGZYRlVsSUZsSU4wY3YwcEs0QTBUMUYwclJUVVc3d0k3?=
 =?utf-8?B?ZVZnaEVyM1Y3MGtzaWFnZkVqRTRLeG5yUXRJTm1YblJMY0o4OEU1UThrK1ht?=
 =?utf-8?B?TVN4YTZSU1pSb1VuVk8zMlJnWDZZem5WMkpxbURIUEhlaUUvYmcxRHF0a1Zj?=
 =?utf-8?B?anhRNUdIU1hRSmhodEhrbDdUNEtBaHBKVFB1L3ZHbDdQcHNLYVBHbDZ4RjdW?=
 =?utf-8?B?WjZQSUUzUzBhbm96MDlFQWQzOG93RE1HYWtTYjMxaVFnWmFDcGRKSE1BTjRh?=
 =?utf-8?B?cVNiVjRYSjF4UzIvcDIxbUZCalBlWjBYZ2I3TUp5T2lLaWxILzY4N0xzaVNV?=
 =?utf-8?B?T0w2bDFseC8ydkRTUElVL0RDWDZlcjgzMzBLTGdzelJtWWI3bkJFN1ZsZklP?=
 =?utf-8?B?NlpwRzBRMmRSTm10UVFtY1Y0aEhOUEdPWGVBczMyMytjNDBsb1ZqNy9GNC9s?=
 =?utf-8?B?WXRFL3FGMDhZTFZ0TDJuT012MVd1Qmk4UHdCeThtZUNRNkVWeGd0eFhCVEc0?=
 =?utf-8?B?eDJkclNIcUQyYkFqVjdIMU5NelJpSUd1SEJrOEFOSUFBbU9WQ2ZvRjRVNlhl?=
 =?utf-8?B?TVp1T2NnVVZBUDB4aW1HYUtSdXZNNnIwOVFBdWZDaGpkKytWT3ZvY0kvL0Rq?=
 =?utf-8?B?ZTY1K3ppeHZ4blBQMmxLNjVBRWU0WktDODRWYkNuRWFlMDIrLzhtbUNUSDFx?=
 =?utf-8?B?eTVicmpXSnYzMFRzZVRha0lHZXU0aWk0REszQ1lUbm9qUDMzY08zZVh4Zmcw?=
 =?utf-8?Q?d2+s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3363c3-d126-4f05-8288-08d9ed54f8a2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 11:52:25.6883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amO4ZfTJHWuitYL9IRKHFG13jPC82P2kwk4ScZw7DxxYz8CtuPZkwpNxJnuzGrHb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4971
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.02.22 um 12:47 schrieb Somalapuram Amaranath:
> List of register to be populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 61 +++++++++++++++++++++
>   2 files changed, 66 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..b90349b86918 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -813,6 +813,7 @@ struct amd_powerplay {
>   
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
> +#define AMDGPU_RESET_DUMP_REGS_MAX     128
>   struct amdgpu_device {
>   	struct device			*dev;
>   	struct pci_dev			*pdev;
> @@ -1097,6 +1098,10 @@ struct amdgpu_device {
>   
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
> +
> +	/* reset dump register */
> +	uint32_t			reset_dump_reg_list[AMDGPU_RESET_DUMP_REGS_MAX];

Using an xarray or just dynamic allocation with krealloc_array would 
probably be better.

Regards,
Christian.

> +	int				n_regs;
>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..fb99f3d657a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,65 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> +				char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char *reg_offset;
> +	int i, r, len;
> +
> +	reg_offset = kmalloc(2048, GFP_KERNEL);
> +	memset(reg_offset,  0, 2048);
> +	for (i = 0; i < adev->n_regs; i++)
> +		sprintf(reg_offset + strlen(reg_offset), "0x%x ", adev->reset_dump_reg_list[i]);
> +
> +	sprintf(reg_offset + strlen(reg_offset), "\n");
> +	len = strlen(reg_offset);
> +
> +	if (*pos >=  len)
> +		return 0;
> +
> +	r = copy_to_user(buf, reg_offset, len);
> +	*pos += len - r;
> +	kfree(reg_offset);
> +
> +	return len - r;
> +}
> +
> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f, const char __user *buf,
> +		size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char *reg_offset, *reg;
> +	int ret, i = 0;
> +
> +	reg_offset = kmalloc(size, GFP_KERNEL);
> +	memset(reg_offset,  0, size);
> +	ret = copy_from_user(reg_offset, buf, size);
> +
> +	if (ret)
> +		return -EFAULT;
> +
> +	while ((reg = strsep(&reg_offset, " ")) != NULL) {
> +		ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
> +		if (ret)
> +			return -EINVAL;
> +		i++;
> +	}
> +
> +	adev->n_regs = i;
> +	kfree(reg_offset);
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
> @@ -1672,6 +1731,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

