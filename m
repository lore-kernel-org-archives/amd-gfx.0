Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A66FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 09:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E1D10EAAB;
	Thu, 26 May 2022 09:54:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018CA10EA98
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 09:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcWsMUIdpX8ex9IHbtlMB905+EIDHjO6QmKvczIs8irS2S+6ZfQg9VQzUrODgGY3ZFcdG6vPuTs9z4BuUi1bhSBTl6tTYIqhVupYHgQAKNzDw/4CHDgn9i8jQ1whS0jykildmz7A7iC+dOGj9rSJoIzsP0LItAJn3BuHSI3yXqFUv9Zj6d3UYwZwV22UzNksZrxLk9sWCrMe+KrxX3sgF+Qzg2H4jIU6sf8032ENdvmsHGANrNAzyorv39C7/bYqo1JWicoqyIb1iAy7C0a3nAEr4z+Iubpj/spA6mQHTKoyLn+JqMihPsB01noJyDXQOChHvHQ0TEOvsswXP74GBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nX9tzxZs7bPCWSIJHcEqZ+2Y0wHrHRjhgPzMjalaoc=;
 b=WsNiTX9Bo8o7fih5Ja9GNv5Ma/XYeGrs+EN9A5zyTAhVxo+DRy2ySXMvuSe64CkV6vqBkE+nzJFpSoHKDROjdaDimFW1m0fGIqUKrn7F5xvNS2bnR51OgyoKRPygNmFoPL704yx2tiqUtdRYAG8YKFCywV1LAxSi3dey4lzKboMy7Pl6rnLx0Y6Z+m9ffu9OsASLy9qWsqpFWs9Ak0apO0QhE6lXHGsQWpdYKihgZDvfQVnDQa7jNdob1p6/29ztPL/nedQ8ZQY5IFUvCF2so80OLSCOqlR9s0qdJfAiylzRy++45UOi8I186etNwQLZk2BglQy6o55AFNrhmHi10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nX9tzxZs7bPCWSIJHcEqZ+2Y0wHrHRjhgPzMjalaoc=;
 b=w+4WxHdayslJQHvXjbc6HfJdoU+kGVeG78mTNUbaZPikYiiPyUGEbTI1qxOJwFscqBLMjIVxisIqJDIUqLcyqZY5xj8PvBKk5wCm9hDGfdv4w4FxzaDVhL5bUoXNNI9vkKT4xNsYpPgjgq01t/1i7AF2NBzZ4hrqEr16RWLKVGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BN6PR12MB1923.namprd12.prod.outlook.com (2603:10b6:404:107::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 26 May
 2022 09:54:35 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3%2]) with mapi id 15.20.5227.023; Thu, 26 May 2022
 09:54:35 +0000
Message-ID: <483cf4d0-ef9d-ea0c-e0ea-8c006051ba55@amd.com>
Date: Thu, 26 May 2022 11:54:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] drm/amdgpu: save the reset dump register value for
 devcoredump
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220526094839.36709-1-Amaranath.Somalapuram@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20220526094839.36709-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0033.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::46) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f506fdc-8fda-40ad-6b5f-08da3efdbd96
X-MS-TrafficTypeDiagnostic: BN6PR12MB1923:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB19237C61F8FF1817A961C316F2D99@BN6PR12MB1923.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWTTc+ojQOdRfNUoPvcHW5uVKGnO91qSx6whIPCGzLjoTUTDRauNizlneHqj1QVHBLxfmxJ35kVa/YZtWxLqNPZ0GFVlXITGTCWKPydeYRusqDoReNgda0aBHMe0aVy1Wk6VTSHgB/04vft2rCJAuES8FgXQH5tH+qQK1Oti40mFqQXpzOcvRa06f6gckKxWp5D+spggCnw6V5c/C/OzOCdwlZdhjYZL2XoNRnFN+dli/Gk/nA7dX4I/prbI/hV6Kqe8NpopvCRlTUT6xG2LKe08ioEYMGAfmC6qkuZ4Xuf6ZT8+3BVid5A5Fn047GK14pspY65Jh6P8X4H8P3FY8kCrrFqDO1Yc1jfKZstXnOlBGR8MWgwawm9ZFfZ6HEbX/yRJdJNMfWgttKgio4f8uMwvt6oLDJiCWnPePdUaF9WUWGWHo6/ARY9Ntuto/82FsZpvi7bUeP+MtkTJPt5SS5q/nTruOZ1UrAN6gD6n1VBrInTPJ/Z3T+l9UA/rkVL/836AaH5pTrIuvZv9rD2nmoDOqItrWTAyH7/Wx4Z+6urTHyVSmQQFIzqWFPCu9UkbssVbc/OvXES9kz0sDmlIVxPfe2eob5sY8jlgUb2bwI7FgHDa4r+YSBv5ZQejqZjGaczXbIt00YH/9Hh5GVqLKELjVz1cXz+qPvPHCKeDSOoljkq6uBu/uV5rhmwsQjxKR0RsqCYOBC6KuFYC/gmFlxRDl3QkuMKMljl6Wob9UiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66946007)(4326008)(6512007)(316002)(53546011)(2616005)(26005)(83380400001)(8936002)(66476007)(31696002)(186003)(66556008)(31686004)(86362001)(36756003)(6506007)(2906002)(6486002)(508600001)(6666004)(38100700002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nyt3T2lTdkp0clRkSUlkNWp3TlVMRUdrM1czVW9oeExnWERmL3g2cFhtbnov?=
 =?utf-8?B?YmZLeG1ueHNjYmtHbDFKK3ZZc2dkUVNXNloydGEvcS83NmNoSGVKaGRpQWhE?=
 =?utf-8?B?b1lXTEcyelJjWEM0RDk3My9UZTEzb2NWMDl5dUxYVVBGVmM5OHNodmZLdHd6?=
 =?utf-8?B?MmxNM0JHUVdDMEEwQzhuc1laYktUZXpMY2l3cnh5ZHVDSWdGeU5DVkdMYzQ3?=
 =?utf-8?B?NG9yT3lkTHdPWUJTYVQ0Y1ZEN3JPVUFlSzNTWXY5WEVkLzdMVkYzekV5aE1j?=
 =?utf-8?B?SktkM28yODBTN0pGWVU5K0liWk1xYmM0QlpTUXBxM3c2UExiaC9WSUZIaHBr?=
 =?utf-8?B?Y254M3RGakZ4MFVLb3VYTi9leWlBMWpLMXU0aXNhcTBIZGFibmlkdkplREZJ?=
 =?utf-8?B?TExPR3JMdjlNWnhYOVFKSFo1Y1ZsWXVHbnZZK1o3R0tWdW1vYXM0dDdQV1F3?=
 =?utf-8?B?TnpLT2Q2S0hCSENyYVF2b2c4bnUwZytTUjBOd2pCV1JLWDdCdnBNdklFSWRI?=
 =?utf-8?B?dUtLd1RrUUlpbEdlT2RqRUxzSy9LY1hwc2FxTHVoWUtITUNscGs1T3NCS2Y5?=
 =?utf-8?B?cDM0OFA2UndOdXlYVXF1ay9nV1ZZOTF5ZnB0TmpnWjc0Z3h3RVBEN3EyZGx6?=
 =?utf-8?B?M1FGLzZpYlk2V3NhRTBLR1QrWmc4T2c0QXdDZEwyd2tiN216RUh4dFc5ckpL?=
 =?utf-8?B?djJBWmRFcURqN3hJUTM0VFREMFA1RHJocm84U1l4QWVhWFJ0RVcvZFA0MkNZ?=
 =?utf-8?B?RCsyMXcvRmJBdjczT2tDMU9IdHcyZjNMeUNiNFNTUjZYZDhiTnlyTTNHbzNN?=
 =?utf-8?B?V3BwNzR6Z2tYbThoWW55RUQ1a3orU2RuR05oVk5yRkY1Yndja0NWWVlGK0pT?=
 =?utf-8?B?cFM1YlJLZENacnJUNzRhZW1WclNVQ3JYZWNwbDZoOHZlUml1MzhtK3drL0pQ?=
 =?utf-8?B?d3pmYVZMdS9EREhyYS9Wck5BZ2dubU90Vk9MSXBZL0JKSUJRYXM1QmtENlM0?=
 =?utf-8?B?NlZRYlM1Zk5XUTVlbWFFMncxbUdTUmozQVl4aE13dU5FVER6d3p5QitiVi9X?=
 =?utf-8?B?NWd0d2ZRTmZNcStJMTU2Uk9iaXE1MVNyQjhFbGpQUGdBME9JejFVWEE4T1F4?=
 =?utf-8?B?cklEUWo4UTBLbTN0TC9NS2Jib0dvQldTd0loYmFjWEFEL043RDBpNGZTN2x1?=
 =?utf-8?B?MnFiTExYZ2oxbjNETnh0Z3E0ZVd5UW0vSUZLMUNIYUt5WjRDQ2RzRG96Y3hw?=
 =?utf-8?B?RVJwRmdlRjhzZG9jRkxyOVJiQU55Yjg5RnF3MnAwVDNtQ1ZRZFVWQ2hybEZT?=
 =?utf-8?B?Yjd0dWtFQldvMTdSS3F5L1VRRVIwalZSejRyTzFOdFBoWmx5c1hHU3E4bUFP?=
 =?utf-8?B?YmNnbFpkeURTTmU3aVB5c09jVkEyYWQ2NFVwVEgrZE5aMEFmVHNJU3JnZ2ky?=
 =?utf-8?B?SlRXTnVsR0lnRmU5NDBJdDRLa0lCVXplZnBBRVpNUStQbCtGeENZUXBkcFFW?=
 =?utf-8?B?SHZnQ21jL2h3SHN2WXAydmRsTmV6SnFLL1VzMmFBdjBwaHZEeE1rVzNMV21I?=
 =?utf-8?B?dmREYkoyWGlvdE43QW85N01yWjFxS3JZY3hIbEYvSkUxd1dGdXcwV1ZwL1dW?=
 =?utf-8?B?dXI1UmU0L3VZY21mYzNyT3pEbjllSXRKcTVFNTA0NEMzdHZRa0laWU84Y29F?=
 =?utf-8?B?cG5uNXlpNGlqMFc2N2phMnNHYVdDUlFsYXJqQzlvUU1xV0V3Q0dsOHJlNGRq?=
 =?utf-8?B?N01mM3RVclZ1Uk9FNU53UjVIaGNiMkVWYnEySHFoNVVmVWRzZTNMdnZWTTE2?=
 =?utf-8?B?N1R3K1BmZkd4bjMySHVnSFR0NFVFUDlTczFmYXc5MENqMGUyd3ppdmVnZWxN?=
 =?utf-8?B?YmV4WUpXbUxxZ2FCdUNCSWRVaTNZdDBuQ2hoUFZ5MVVNWklSaXBRSHVsU2Vq?=
 =?utf-8?B?WElLQ0lwamZRSjYwVnp4SGpUeEhIVXdueWZhVUJmWUYwMjBxYTBEOHU3SnQ5?=
 =?utf-8?B?WUI0ZCs1S1Z2TXhEQ3pzK05MMnFldUtCVFJQaEpubVpVNERYVXdhdHU3UjA4?=
 =?utf-8?B?cy9rSnFOekxoYkxLSkJJM1kyV0o0N09wa3BYNDBHR2R6UHlqUllyOWRFVkpB?=
 =?utf-8?B?NjlKOXZaRklpVU1adUUrRWdqamQrc1lZaHQ0UUEzSmNFMmJkRkN1MHF4MTJL?=
 =?utf-8?B?VmQ1WnpnRnBVblRVRE5uNVJzcTlwdEZrcXdhWkM2Wmk1UGd5SWM0QWdGODJz?=
 =?utf-8?B?dThlN0lEMk1QVjhZTHQ0eXJwdDZpNjJ5cDhuM1FCQkVod3JBZ0w3N0dpK0hW?=
 =?utf-8?B?Q2ZYQWlCNXlsemNINkMwRFNqVkc1L3ptRmhxYkx2T2lCQWtpYXJTUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f506fdc-8fda-40ad-6b5f-08da3efdbd96
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 09:54:35.7726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LW0LcTanqQlR+Nf5NWfRDsxqPpJEcg9CGN7JtZh/xkOrMDvqf9NQfJLoW63PTJbsEwSwUmI9gz7u07NuYDjsgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1923
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Amar,

On 5/26/2022 11:48 AM, Somalapuram Amaranath wrote:
> Allocate memory for register value and use the same values for devcoredump.
> v1 -> V2: Change krealloc_array() to kmalloc_array()
> 
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 6 +++---
>   3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 76df583663c7..c79d9992b113 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1042,6 +1042,7 @@ struct amdgpu_device {
>   
>   	/* reset dump register */
>   	uint32_t                        *reset_dump_reg_list;
> +	uint32_t			*reset_dump_reg_value;
>   	int                             num_regs;
>   
>   	struct amdgpu_reset_domain	*reset_domain;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index eedb12f6b8a3..f3ac7912c29c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1709,17 +1709,24 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>   		i++;
>   	} while (len < size);
>   
> +	new = kmalloc_array(i, sizeof(uint32_t), GFP_KERNEL);
> +	if (!new) {
> +		ret = -ENOMEM;
> +		goto error_free;
> +	}
>   	ret = down_write_killable(&adev->reset_domain->sem);
>   	if (ret)
>   		goto error_free;
>   
>   	swap(adev->reset_dump_reg_list, tmp);
> +	swap(adev->reset_dump_reg_value, new);
>   	adev->num_regs = i;
>   	up_write(&adev->reset_domain->sem);
>   	ret = size;
>   
>   error_free:
>   	kfree(tmp);
> +	kfree(new);
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4daa0e893965..866b4980a6fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4720,15 +4720,15 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   
>   static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>   {
> -	uint32_t reg_value;
>   	int i;
>   
>   	lockdep_assert_held(&adev->reset_domain->sem);
>   	dump_stack();
>   
>   	for (i = 0; i < adev->num_regs; i++) {
> -		reg_value = RREG32(adev->reset_dump_reg_list[i]);
> -		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
> +		adev->reset_dump_reg_value[i] = RREG32(adev->reset_dump_reg_list[i]);
> +		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
> +				adev->reset_dump_reg_value[i]);
Please fix the alignment with the line above, after that, please feel 
free to use:
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

- Shashank
>   	}
>   
>   	return 0;
