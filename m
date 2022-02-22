Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0C5C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E19710E5DE;
	Tue, 22 Feb 2022 14:44:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876B110E457
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 14:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2bGh/PEl5xOOwNce7Jy0ZvuGdDdUeSL12A90eHju2js8XMWe6uA6a9/0bMrXenKT9NGO1q4z/84BCR5BHeLxz015VpOuhriI3gIJfoIwFFAMojHVpewiCF9E0KZbRPuVgN9hUBtxcr1om+8ZFLmyv05tz7aN6p2V3yQXhooN13XEqivULhmyVEZeKdtL1azObmmpuZ7dgX0VBGHpsE0V6aCzb5sdtXNAB/HWVyMtPLOrAQHj7ELujomhRIgEwUszWNynbl+eFc4KqwTkckuWIUWLBPaFoExuLV0dy5Tj531G3B4oj3tB0C4GmtyRbclKdoRMEDZMnM26BadxZ3eMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSvhqwsxLkYOxA/n21mqTQ7cpn5k2nFcaoiV+kH84GM=;
 b=VVMDAYHdgQAVLFCGtqIxJiQDUQfOZbk7C/B4LeDvu+jaJFhp0qzXJ/SpQbjlG+0+IWVGeIT3DLu9adjLCjRIgHDRYy4f9VKdhDV3vXj778Nd/3tp8Pd7lkN77ENXcE0hWdj6FXUXzLF4EIJMWfJ9vfyCCDWxrgIcnFSYjkDpijTMnCzk800x61uwh6KZ1VrrUsRObPB0fJydQEv+93eeE0Ofe7wJbSfDrIhzzmofqU0LXda2UJ3wypw6GT4yQFeeAk2mE0SVfvfkDvbMT6ApSDnYfL2CHaOqwN5dPScfTZWqhDqBlA5qYpJ7jLTS1L2r1bBOanW6tV0pDCYA8NXo/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSvhqwsxLkYOxA/n21mqTQ7cpn5k2nFcaoiV+kH84GM=;
 b=VyHb9RUVYDG2gTREYv/yFOCHWwK0gPbnqCFkpqBMBgDk5V/rPrSsLZARgmwYYww//6jO4Nqy1FQDpGcrrQ+0qezY3yl17pJcHzSnVpMWQhgj/SYGNeQgHk2CyX/EAlXszXHh7GeMYTWMYEle2tRY291E7/VXKv7iU17tFBHJSac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY4PR1201MB0264.namprd12.prod.outlook.com (2603:10b6:910:1e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Tue, 22 Feb
 2022 14:44:40 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.5017.022; Tue, 22 Feb 2022
 14:44:40 +0000
Message-ID: <bedd6d36-c74e-2acd-2708-1ae44a3b41c6@amd.com>
Date: Tue, 22 Feb 2022 15:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220222143742.2575-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220222143742.2575-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR03CA0028.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::38) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb192b62-dfe0-4795-9778-08d9f611daf0
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0264:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0264125D276B0BB8212F5AFF833B9@CY4PR1201MB0264.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Enq1PAhOaucMV51ZOjR6fzIXkNmVvirOXfgAUzSebE4s1lsvBhPRY7/HtRG3M32khI3cY1mP1di/tyZyE+VHM0DjOomu+cqcY3X5Wd4y/a5OPyii/LqzkUcCL5/AlP+pGhOoKCQX2I6Mlns3X0xdNjXdYpk+2AalQCDx+6qYev/EL42/CEYwXojXqNd+cpdJHs+AMbPARpA6VoS18Wxu8ytPLHrmm1re2YBrKiAUOQHjqu+Wh9lQq3hdj8kITu2bYktW64GSpwr7KwuFKNI7bMQInNazyCDXcAtTHt/zoryBA/pzTw72bkDedHe67k+ePZKU2cZocomL8dWuDAQ2wZzwE77jska6FEsKbktE4kaPZYv7Y+zjPGS3DJNCumtLpsBP7sasEhCMu5onQEmT8S3BkXV8YNqZSC0cCRDdN1yng01JFmhhaieZ9bVbKRl9X9sTbTDzhQ5VCzTFJgv8KGkHVM9D/jksVSLkcNI3EgTxdzibCiZEVVw48BPqFlCqTa2BUspffWRke0y+R1jqX5FKX7gmKDW3NfHipvfPjPsK89HvvMxxX/zaHMHIB0aGW4OccMGeUal/BX4+CrcBu7XYskCLDIMc5uVI7iqkOz0Eu19/VWXPgzI9iAolYJfm+kie5s93sqwnAJWBS6XKJ0BaIerrJQ3T2mcG/W44y+Yi4iSCMICtJ2TEv3Ooo2DIHbOXOOVJEskARAwYv52N+NhX8qRpzbTTCOUVyrzJlx/iiJVOyPHnddg12eUcPCuf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(2906002)(186003)(6512007)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(316002)(5660300002)(2616005)(8936002)(31696002)(31686004)(36756003)(6666004)(508600001)(6486002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzBlcURvK2ljZnBpWkI3K0lzU2pBZjRNRmdaUTFpNW9hSkwvWUc5b1VHTWpl?=
 =?utf-8?B?RlFUZFc3Z2E1MTRhaWIyTTh3bFBHT3NZZmhZYXJlaW1Xenp6NmRnb3BMY0xa?=
 =?utf-8?B?VEdFWUNRd3ZNYnFjdHVxQ2FCdU15N2VVd0ZXd2NDNmg1bXFIaXRFM1JWSnA0?=
 =?utf-8?B?WHNocUdZQnBjeWRTSmJOdk1mdXltNW1VTTc3dTFvNThsTTNXUzVzYzIzOVBT?=
 =?utf-8?B?Z1p2dFNjRWQ5d1E4U2MzTWRJZ3gvWjZlLzhxWWZMQmo0WmZnNUk0SjJHY1JG?=
 =?utf-8?B?Z2xwRHcvWkRJK1NUQUxLeW5RRDRpUGFobkxaci9QanlXbnhwaTAwVm1TRHFK?=
 =?utf-8?B?TmU3T21ZV3VYODNQQ3IzNlVzUnZZQ3JqT1o1bm9KREQ4dmdLK3FpMEx4Yy9s?=
 =?utf-8?B?dXZ6TXlUTUNwWWxQZGllcjJCTVMrTElhaVlWaEE3VkE4NGRlcU0wM3FsZlMr?=
 =?utf-8?B?anRuL3hZM2JHTnh1T0dYemdnV0FSMU4yQVdPWlQrNnY2MHR2VGpnRmVWY1FX?=
 =?utf-8?B?ZEovdUo0Zkc1L1JETDQxMWx0Wjk0MUwxd3NLNFd2SzJRcGNrWXFVQ2Y0WlR3?=
 =?utf-8?B?cGZ4bVNFRlpEeWlwVXhGRkhVNEgzZjhseTJJZmNyK25IbXJnU21hV0hXOXhq?=
 =?utf-8?B?Z3FmRVpLajBmdm1za1RqWjBleDRmbG9tTDdIcytpejdzMHVQdjFHQmU5ZjZu?=
 =?utf-8?B?bkhwZ1ZYTWdRN2RZQUZacHBiRDBMYVlEWUs1OVFQQkR0NkxteWxiRHJTTFpH?=
 =?utf-8?B?RjJ6WldGWWxDYTRrV3czRWQ2QmhnSFNhV1BSUlN0Y0NraWVzMEk2cytYYkVP?=
 =?utf-8?B?aU4vSTFtZkZjK0JseVBxaXNFR1ZVWWxkSWNqYlE4MmZYSDBOeE1PcGJ0bGZa?=
 =?utf-8?B?NFU2Umt5T3FhVWoyblAzRFBESTBQWFNHNkFNWnFEcXJtamJnWFF6MWFabzg3?=
 =?utf-8?B?Y1k2QTVCMDl1d2RDd3QwZm1xOHdIdmZuR1pmMmtlRVh0VDd2UlJtOXRVeGJS?=
 =?utf-8?B?N1FEclJ6Rk5wYURKYno5TnBlOE1Cb2EvbWppTlZiSWlJNEtOWnZhdy90UDZ5?=
 =?utf-8?B?eE9mclFYOVJiMDg1aDBSTlpRTnZZaDFhS0o0ZnBBQitKVUJzSUI5ZEIrUE9n?=
 =?utf-8?B?VitNQVNrRjVJRGlTRlhrb25iSTRGbWlmSE1FOFJmNHlPUkUxcWh6ZXgzNmFP?=
 =?utf-8?B?M0piR0VqYnpGcm14OUVWVlo3Rm5aQ0c0QUJHclVWSS8yanBRNlVlcVREemg3?=
 =?utf-8?B?QUJyRm9Wdlp0dStGT05STzhQWjI1b1Q0UXp4bVEvUGE5RUNmNVpSbFJEMzRy?=
 =?utf-8?B?NEVNQ0pycTZmdUsyMmpRWWo2TG9vemluYzVtemdVTTYvamV2VGVsVUpTZzlx?=
 =?utf-8?B?dnNUOGhQYWdKK2ZkWXNaWTFkU21zVUVQRGNtcjJFSjhnT3I0N1VKeml4WTdr?=
 =?utf-8?B?c0EybkJ6citrM3FMaUlFQUhzdzZUcExDc3pVSStPS0ZDVTlRYlZxaWxaakNH?=
 =?utf-8?B?eElDV2U2ZUQvZnJMM0lSSEg5dkFXd3hMZW8rcFdzMmRyaWNjcTRWN21pdWFq?=
 =?utf-8?B?MUJOSnU1VUNNOTR2YXJLY1lJRTBmTUdGb3IzcUlYd2dsMW1KcG0ra1VaZ3Fi?=
 =?utf-8?B?dHRaZTFvNFowOGlzZnpTTHBZKzdUays3M3V6Q0dBeVllZk5JL0RWVHBhdmRs?=
 =?utf-8?B?UGUyd2RPUXJxVkxwZE9qeElCRE1GVlNGcTVuUFR6QjQ3OVk3NzNtSjZqWGpB?=
 =?utf-8?B?c3hzQVdCeEpucE5kekIzZWN2TWI1eW1Rd1ROMEMwb3lrTEduZ2ZCcDEwRXJy?=
 =?utf-8?B?enZ0NlI3bHhUZDIzdXM0czZ5a2JhK0w1ZmsrVW5ma1BBM0tEL2lvL0ZHSTF2?=
 =?utf-8?B?SjhzNWNoa1BVSWg3cHBhOWFxQ004VUdGcWNNZVlrMUFUbDFYNXp5dEpMT1dk?=
 =?utf-8?B?YkZsL0tXUEE4aVQzTE5KTy9hY2h0Y1BNZkc1UHRENmprOUlOaTdyN2wxcDZ3?=
 =?utf-8?B?UjBuZUZwRjhHZHFoNTdRZUtBY0czZ3BFei9FcVNESWRmTzZFWm02VXR5VjNI?=
 =?utf-8?B?WEhhbGRzWXpKaGdCVElsMy9sUXRXU0d4WGhXdHJmTDZHcWlET1dNRTZQTkxS?=
 =?utf-8?B?TC92dWxOUm90Q1BpaDJ0THZaemMySDAyYWpGb21pTWI2VFRQNkFBblVvRFBM?=
 =?utf-8?Q?QUiB0AY4g+nF3hpdiyOwDJY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb192b62-dfe0-4795-9778-08d9f611daf0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 14:44:40.0525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kY1aKDHE5ZApqEGRXVo/10lWxa4tlL2AR7PrI6xtHumfouYPKpm1JvIlhZsw4b0n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0264
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



Am 22.02.22 um 15:37 schrieb Somalapuram Amaranath:
> List of register populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 81 +++++++++++++++++++++
>   2 files changed, 85 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..6e35f2c4c869 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>   
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
> +
> +	/* reset dump register */
> +	uint32_t			*reset_dump_reg_list;
> +	int                             num_regs;
>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..df6d9fb69657 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,85 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> +				char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char reg_offset[11];
> +	int i, ret, len = 0;
> +
> +	if (*pos)
> +		return 0;
> +
> +	ret = down_read_killable(&adev->reset_sem);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < adev->num_regs; i++) {
> +		sprintf(reg_offset, "0x%x\n", adev->reset_dump_reg_list[i]);
> +		up_read(&adev->reset_sem);
> +		ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
> +		if (ret)
> +			return ret;

You need to return -EFAULT here, not the return value of copy_to_user() 
cause that are the number of bytes which couldn't be copied.

> +
> +		len += strlen(reg_offset);
> +		ret = down_read_killable(&adev->reset_sem);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	up_read(&adev->reset_sem);
> +	if (ret)
> +		return ret;
> +
> +	*pos += len;
> +
> +	return len;
> +}
> +
> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> +			const char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char reg_offset[12];
> +	uint32_t *tmp;
> +	int ret, i = 0, len = 0;
> +
> +	do {
> +		memset(reg_offset, 0, 12);
> +		ret = copy_from_user(reg_offset, buf + len, min(11, ((int)size-len)));
> +		if (ret)
> +			goto error_free;

Same here.

> +
> +		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
> +		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1)
> +			goto error_free;
> +
> +		len += ret;
> +		i++;
> +	} while (len < size);
> +
> +	ret = down_write_killable(&adev->reset_sem);
> +	if (ret)
> +		goto error_free;
> +
> +	swap(adev->reset_dump_reg_list, tmp);
> +	adev->num_regs = i;
> +	up_write(&adev->reset_sem);
> +	ret = size;
> +
> +error_free:
> +	kfree(tmp);
> +	return ret;

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
> @@ -1672,6 +1751,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

