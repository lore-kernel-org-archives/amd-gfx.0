Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5FCC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 09:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C461910E257;
	Mon, 14 Feb 2022 09:29:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34A510E257
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 09:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRxXp7EOCoyZTj55ePNXPtwl+85t+sE+9nV3nAQJbKI0rrqchlf28gOa+cUeiBi/3ys4BxlevaZ3mrINR+gECyVlfSkzMA25lSzWC28eSkXNHYGpFMc9aWRM8IAOEjG5hHGqS61KZncpo+saYQRWlD2g9pkBTQU7un8ou7yuEfDBgBjrlWCkcs/vRXNcVIDSyEELtaSas0MTAo1f82uXeB9Kqo6bIre6rZf7E2nu+SOJ6VvTVex+Tt44RTQ7Iwt0yBAik5nS6+TJKk3Yv3GulpJWLgcNjQ/Aeajkq9ohi7P3L4vKSJPSw11X5Ai0x/vs9uI/ioIuhC6y9Zuw77FeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4t+1nRGr9lAwPi4oe1kdhxSqFJ7QQm/iR9PP4oam4M=;
 b=Ywa9LNjADJypZo1aLqW3/+g/nL6SDDCm8PrFk/gPJEW4364WWY5MtPTBFHyR9PnwlJxe0V/U+/UdhaW3yjPcUkLtBGD5SdrkuWj5MzD1JSE8pIb4HmKD6aKNLUXPn0P5N7q/Bjz7FWI9DC9Jap9HfUTWsNMfYU7Fr6LrtFzdfAHMNr3CfC2nIgJPIRujJGwrSXBeoMad14UBAGlafK0YCTN6EuLd/XW5D+/QIg37nRiSosEIyW28iER9d4jFjJFtXuFcVP8Z57bDbdgNQCJeHoRahvs8/t+3p8u4a5B6CxzmENTu9litvUBATz5cSiqjJGUSTiZ2ClV/cDmwuAJnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4t+1nRGr9lAwPi4oe1kdhxSqFJ7QQm/iR9PP4oam4M=;
 b=hDmJiad06IjzF6ylRnZcF+Iuo8U5NxpFEUFQXkF5WCKYnqzGUiDMsKl+1cJpoYyfL6RSMZd2WAE2TurB1iVHM23mL1YcHyBMqYjZr8Ug17cK1Q8CNbwBwadyuj3+umvD5EaKW7rXhM5o/lyJS/UK+Oi2PS+ebYE+TQWBVgdF+cY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB2841.namprd12.prod.outlook.com (2603:10b6:5:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 09:29:41 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4975.015; Mon, 14 Feb 2022
 09:29:40 +0000
Message-ID: <3a99c1c5-0eae-74a0-58e9-3477387467d3@amd.com>
Date: Mon, 14 Feb 2022 10:29:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220214091619.2820-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220214091619.2820-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::21) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5982cab-fe7a-4f00-c315-08d9ef9c86ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB2841:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2841A891A7226EB6D8308D0383339@DM6PR12MB2841.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qb5HQjRp3RhPVmrx4yfmigYJlZRkFSWjj0eCXUYabr0nQqM2HomPdj3Mz5Ed8QMwkAqx7iX30RJwg2vDObn2rRl81CcWqYsouQPGO+rzWmg3m3bPQ0agYYkm5V9KXdcabN+/mnbbUkcclwCqJ6hxTgCYZw08sqZYpv7LLyNyJXC6Tbyttjq3laex+Do6OCstdkQ3JjSP8/n4MqRWskVyUS+zJfHh3sw1hxZYfKMGxzEFbbEKpEO10uLshmDbO7g8k8PwkiB/jR5yGxCK9GKnx+Znyf3CjqJ92Urondu3w4YjlKsdS5iflng8fVx8+mg9RARGDzjsHAYZH0GJLJKOB6MjgR7pYxfM+Rzc1PavUCrqBOweWUhhEZ6h8gCbntDEHcYYbd6IGzz1ZoChM2piBy0ae3XJQTqg57AbSq+O5t9MyAwERs3MMmAWAA0cDT94y+I6LpsVH3J8S68Vd1twDFryQlRCm5lgNj6qSG9H+7WBdsG/pyAzIspV4NgqtKXLEyFWBMwPuKUtXiZzbrtdN/9KByaUSBsRYmrUbMd1rF4jwWwS/2yGMSerHTHu0rebtsV7cZ5kw63xZRGkZSmFcTFTB2xP5ITBCN4R0F0GJQarxbPGgcWf+bKDzvCuYdf+Vwo0wpEoygHJGaoyvBoPbCzol32J4yXhrtRb5p8Gqz30sIcqsy016dL2nUr4D6dDiVeNRKMtbgsrFz4q1U85feiZ+2rcFc/9kdBwwY0OAZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(8936002)(66556008)(66476007)(66946007)(4326008)(316002)(186003)(2616005)(31696002)(508600001)(6666004)(6512007)(6506007)(86362001)(6486002)(38100700002)(31686004)(2906002)(36756003)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGw0S2xrVkJ6RmlWdGEweko5QzliNzQwTmdZMnFRaXZMZW5QYlRrdFdZUmsz?=
 =?utf-8?B?VWdZUk80TWwvbHAzTHZHNTBwaldkM2RSeERZc2N1Nm5KYjd2TWVQbzVHSGR1?=
 =?utf-8?B?QUMxMjcvdVptY2ZiVExtNkkyMXo1ZHROdUNweEQxd1cxQnlnMlpRNjQyTGtp?=
 =?utf-8?B?NWMrdkRZN3hmb1JsckdMdnJOdmlML1ZvYnYrc1NjQmRabVFhSXZQUlFwSlY1?=
 =?utf-8?B?SGtsOG54ZllqZ0lVTXZPMnk0eHVydVRIbEZLSzFMaEhHalB6bHV0SnRFNnRO?=
 =?utf-8?B?RUI0NWg2UWUzQ3JaNnhBRnRYalFZbWZ5dnNyMXN3MzduTFdSMUdpNHpNZUNl?=
 =?utf-8?B?cDBVUlZ2QWRHY1FLZGh6UmwwS3VNWTJyZmRVdEtjbm5xRi9lblFXOXRiQU9i?=
 =?utf-8?B?ZE0waXQxTGltWWZJMS81N3hJd2VVWFo3VnUvMFpvQ1VHZVV2UGIxT1R4Sm9m?=
 =?utf-8?B?QUlDeUxjY2h3OUk4WFdGa1JJSVZLRE1DTFdWRHdiQmhNdXBJM0syQWd3R3VE?=
 =?utf-8?B?d2hkMHdJZmlNL1lWM3FGRjk4UzFselpGZmkvS1NtZkxQMkdtQllDQlBMZ2ZP?=
 =?utf-8?B?QmhIMUQ5SlZ6V3BjMlpNcmczbUoxOC9CZExyM2xDbGVCbFZsWGgxc3h5d1lD?=
 =?utf-8?B?c2lkSDNEenpWTWxWQUtFb3JEbWErYk9YOGRZTjNtKzh4ZHdjVDBpWng1Smg3?=
 =?utf-8?B?U1haSlljYXB1V0p6L3k0RlFLNjBKdzdVcXNwV1g4andyNUR0ZlA4T284U3J4?=
 =?utf-8?B?NGY3eXQ1NW9YMjJaK0pYaHRVb2lab2RXRUZKUTVsTjJCOWJBK0NRMWV1U0Y4?=
 =?utf-8?B?eWdwVEVSTnJIVU9jQXFOYkJYcGJiR2E5aTdTaUx3ZDFjYkhqbno4RFVvQ01z?=
 =?utf-8?B?K0prNzZnWWFJY2t5bEQ2aGVUZlF5aWZoSEU2QzdXUDd5MGhLN1R5cnJPRzNJ?=
 =?utf-8?B?WVQxSzJ1eDQ3RjZDRzZ5R2lxSmNXaktPZ08xamM4WUJkRUluTXQvTWRLTG4y?=
 =?utf-8?B?eEZZNktyT0J5aEIxWFdxbGpWNGpSTUpzaHhRMmlCT0g4QmlVQ1liNEVwcDJk?=
 =?utf-8?B?T1FraWpYbDJ0TzRWTXpBOTJrS3JRS0tvL0lMRmUzR3VCTnE2Z0d1SWpQMHda?=
 =?utf-8?B?UWNzTmNwUUtyd2dBMmpjZWZ0djRmZ3FCK0RHY3BxcjZ6RUQ2WmRxNUlITWwy?=
 =?utf-8?B?M2hrdGVkM0ZtOUdSTFVkVGQ0SkYxOURVRFptWU12Q1BKRjc3NS9YSXh0YUNr?=
 =?utf-8?B?ditWdlhpYmM2SkhPWjZjZXVEQTFBeDRmenpPY3ROWFE3QWFYVEJ5SXJSOEI5?=
 =?utf-8?B?aXZOYWRIaWlTODM4QW1wdE9YWGFlVHF0K1hORGozTFg1WE9tUjJGK1VEdFl5?=
 =?utf-8?B?VDVHaGpRamtGVjRaa3hBRElGd1ZsR01rWkVINTdrS1hPRHd6QXRJcUdhSVlI?=
 =?utf-8?B?Sm1yb3ZGdDBIdGpadXpqYmhORDBBdXMzNGZ1a2ZrSjN0UzlhaTJ2VGFXZ2FU?=
 =?utf-8?B?OHRRS0dkeUdlMnIrVkZsQnBqa0dUOGdpdjdxOGNGYkhQSUdBRXJEK1B4ODh5?=
 =?utf-8?B?OHhMR3VxQUhlV1Z3TkI3SDVJNnRqa0srZTN6Z3B5NmtRNUVzODlmanc0dUVj?=
 =?utf-8?B?REpNQTdRa2xqUW9RMUdFaG96UmJxNjFFUFpkMWVZS3Qxcm9yRlBrS1pZb2RI?=
 =?utf-8?B?MUFzbjl0RWtRRGMvaFI1WEhJUW9uWWlVVjRUYjRHZHhENkVMMis5ZUlxcjZi?=
 =?utf-8?B?alBMTlBDSzlmNy84QlpyQWFxUjhSVDcrbHcyaTUyZ3ltVXl3ZkFDUWtRdG4z?=
 =?utf-8?B?SEhDSTRmR1V0ODF0K1N0ODVlRzE0ekdiVGtmS1F1K0paSTl6VHRsc3VFZTRa?=
 =?utf-8?B?K3FpdXhGM0l0WWZwSngxSnRtSHpVeHBvT2hXWmhibHgxa0hBSSt6T2Fkbk9C?=
 =?utf-8?B?YnorNHRJdTJabGRiSjZiZ0tkVDF5OUZMaVJrT3JZcXRLWng3dFl0TDVMZ3FC?=
 =?utf-8?B?aUEvd1l2SGhXaVhhWjFuYS9kQklNN1FzZHhMWjVxQXZRakRtOTBqTUJQaW9p?=
 =?utf-8?B?QWdjMkYyVm5pVW1WWHpSL1hWaUhGSEM3Q2xIcnRnb0VVQXo2WWpqS0E2OVl4?=
 =?utf-8?B?SnVhZmdSNHE2WVNSOU1GZjJJeVBpZjVlLys2cnBlZU1NZm1Qc3d1UCtxYWtH?=
 =?utf-8?Q?kWpRIhj4S9wkKGAkBIZRumk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5982cab-fe7a-4f00-c315-08d9ef9c86ca
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:29:40.8913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbb7l7yfa6BfXozRQv7YqPKNbYCwyjV8tEWd/N3/JVixPlT5Iy7bqkZ58OW19BnG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2841
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



Am 14.02.22 um 10:16 schrieb Somalapuram Amaranath:
> List of register populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 80 +++++++++++++++++++++
>   2 files changed, 84 insertions(+)
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
> index 164d6a9e9fbb..6d49bed5b761 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,84 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
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
> +	if (adev->n_regs == 0)
> +		return 0;
> +
> +	reg_offset = kmalloc((adev->n_regs * 11) + 1, GFP_KERNEL);
> +	memset(reg_offset,  0, (adev->n_regs * 11) + 1);
> +
> +	for (i = 0; i < adev->n_regs; i++)
> +		sprintf(reg_offset + strlen(reg_offset), "0x%x ", adev->reset_dump_reg_list[i]);
> +
> +	sprintf(reg_offset + strlen(reg_offset), "\n");
> +	len = strlen(reg_offset);
> +
> +	if (*pos >= len)
> +		return 0;
> +
> +	r = copy_to_user(buf, reg_offset, len);

Maybe better copy that to userspace one register at a time. This is not 
performance critical in any way.

Same for the write function.

Regards,
Christian.

> +	*pos += len - r;
> +	kfree(reg_offset);
> +
> +	return len - r;
> +}
> +
> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> +			const char __user *buf, size_t size, loff_t *pos)
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
> +	if (adev->n_regs > 0) {
> +		adev->n_regs = 0;
> +		kfree(adev->reset_dump_reg_list);
> +		adev->reset_dump_reg_list = NULL;
> +	}
> +
> +	while ((reg = strsep(&reg_offset, " ")) != NULL) {
> +		adev->reset_dump_reg_list =  krealloc_array(
> +						adev->reset_dump_reg_list, 1,
> +						sizeof(uint32_t), GFP_KERNEL);
> +		ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
> +
> +		if (ret) {
> +			kfree(adev->reset_dump_reg_list);
> +			kfree(reg_offset);
> +			adev->reset_dump_reg_list = NULL;
> +			return -EINVAL;
> +		}
> +
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
> @@ -1672,6 +1750,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

