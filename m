Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03368C07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 18:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AD310E0E4;
	Tue, 27 Sep 2022 18:58:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D36910E0E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 18:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF+Kf7FXctKNTcB3hEXt84ffQL8kimOh0wP6MZ3HF5UeBX1A74zjGO84jpb+tHKGoVJN5dBAwhjYDRfJTqmrRQ0E6OrPxmvxgD72oUKN7PxYXO7Yhn31wbLBsv5Yvz1g3Al6WahulakQ+vb7YQbM4K6zcMJ2qhXT8709+K2lNbb3i/36flYbOT+zeafPxTdPrYxiPxUIL0l+9Pk+sPCl2t3u1rZvBY2YJzhnzHSAxj63UUaJ5hkRoYzpnMBz8j5Mt2aHlLQQuL5iFWW7+skxJ6fkkBV7sGfRBIRgin6owPMc/aSzIo7BqPozl3563SluZ3t/e95c/JKwzEHpMzNiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVyg0isHMWPhgwYPUjuIKsJyAWWw7rUCTkdGz6RxWUk=;
 b=T1H7SQ55tQC9dgitNeT6xo6fGin1fB3JKpOVjjekXGaO8GXscDPY/fvPWZEvOIAiVvjy5vvid3N5c2OyaRvjaYWszA2IgfQjBaUcP+8PUgmrB7Lf+Wt1+OGQBhA69W4Yy2Yv4hGJb7Wj3//oM6uDc7XUunD12dHHSaIwTtgbqZhrXx2BA5T/zQ2cCWExuZq1cBS9fz3cB7E2+JM4TSg/tc5G2nkFJBlzrXz3Aej0ztw8GignHtf4PSnpfwHrP7S2idKXUi4sYQS+qtWjmwNYUa1ZXzgVtscapon3LLgUKfj1IZaeIE0ePS6rkKF1OI2WCrUBJ9aWRNxaFzWLsOHv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVyg0isHMWPhgwYPUjuIKsJyAWWw7rUCTkdGz6RxWUk=;
 b=2h3pBLzf0ZTJG5T1yD4HlNav6oIFgkUjbJF32u4hmyiagm4ufOZZxQIV8UwfRDzpF0IxpauJ3wmBbj77nT82gWrin8LyxAs8bn7Uaho4Dx8k4xKeUd4KN0ta7FeOW8P898QFX3FLedwwWp0FyODr0tkgGH/CDoETofTCssODGhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 18:58:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.017; Tue, 27 Sep 2022
 18:58:04 +0000
Message-ID: <b3ad27b5-c101-3e73-cc30-fcb095587c62@amd.com>
Date: Tue, 27 Sep 2022 14:58:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/1] drm/amdkfd: Track unified memory when switching
 xnack mode
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220927154348.20274-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220927154348.20274-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 967997a7-7e52-499b-0f18-08daa0ba3548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Q4A6jK1GVAwP/Vy8B1nRaL2xC6tBIioAvwZsZY0x88SJzDkNLE+cgpYBnkZSScTHNwIK7919f4qsfMBKyevgY4/VxLhTrlvbpeM6+fPjRE45Yrt/fscFmYEBs1f9M286X85For1NtpRhycFhtxbkVO8+0LSVvgzIr0HTks0qz6V8AcLS50H4AH8Z2RkNhhse0nyYZyIcbThrbhXso9uuw76e+TAQ45tsyYu+UOMaCnCybjFSmr8LzZesZb4boTrl0P5pnX0dVFaC+C6nfrRWi2hdDHlgG0KEWJ0vppbABZ04+0ejEoiPdRaTeO7/hfOcjIBPTzkxVZ4spaBzkiEtPre0yAr+4Fe8g38yRR4k6z83cwro43laZRfIuxjQSmrja/vT9pp6YgaxYZYa11la4tDb+jJsK5lTte2Psz4EiC1kwvS7z23fAEYu3lBV9OoeCjX4sBQyLNDKNUEooodKSLSJrG749BShG2WKhTl1dq9ygtBvJ1nhFxMK9e+SSQCzgKifgfqx1Tpeh6BXQOitzzhtuAAvDaoda5Dwr3xB1PviUhMY3TSVJGa/bqnsk6Osup+3tO3fk4DVANMh4NkcGH8kASGLBZ7JvzugBtPqrPDkmUgIvT9D8Dbx+6oWbDOPeWIVCKIm+dNlYJeejfMcR4PcTi3w5oOsr87XqUPlKApAgsWaBCdV/97wSD995dtjN+vMqUuDU69BnPISAlqS/nLMagWxIlJ3sXhGJfj8WMew5L3tPQ/GZh5M+r8bYDL2otzTS4qewhQvnm3+2GaKShlhJCQwH5z7JuuTRw3i4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(66946007)(6486002)(316002)(478600001)(8936002)(31696002)(86362001)(36756003)(5660300002)(44832011)(8676002)(66476007)(66556008)(41300700001)(38100700002)(83380400001)(6512007)(26005)(6506007)(186003)(2616005)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2lKL0JYaUxxSVh6MmZwTlVWRHppdi9KTDFJQlBsZFBUTmhpYXZ5ODdQMkZP?=
 =?utf-8?B?eXpRRkltTXJ2TGJadUFFb1h0YXNmTTZETUdvM1kyVnQvWnQvWGo2Z3RTNWFN?=
 =?utf-8?B?a3JsbjFLZWovdmRCQ1JMWFFsSGVQOElpM0J4WEgrSU01YjcxT2Jxd2lmNDYv?=
 =?utf-8?B?ZjNNZjhWVmlrRzVEVCtGRFMzSWlROVJOY2NiTjh1SXlybDVrSUV5cnIzRkFw?=
 =?utf-8?B?RFNyQUQrdlVHL0VESFBhV05OQ1JpeE9CZ3FBbUhBUjhHbUp4NXZNRURvb0cz?=
 =?utf-8?B?MXBFK2JObFlXNWhGNUVkU01sbWNoQTFZNkZDOE5YSW5nTjZRRExoK2RqaEUr?=
 =?utf-8?B?OTVpTGdjRmtGYm1GQndaWmNXeWtBdCtRWHBPQW9pbmtEZXpZUnhVRHo3QklQ?=
 =?utf-8?B?VjFpV2c5V1ZqV08vNVdOeWRMbnF6cUltMFV2Zi9ubldVWDQvOGljRm0zdUlM?=
 =?utf-8?B?Nk1SVWFGTndoWjZjNGh5dUpESU1XaENEbjBwZFY3b1d1ZmtPR1kveWpObFFM?=
 =?utf-8?B?ZW1SQi9kb3NPZEI1enhpaXlyQmtLbW85NGlzbmxDbGFvc1hELzREMi85NExz?=
 =?utf-8?B?dEk3VmFJbmRJVnlOdW5SVVZZc1FvR1hIME1pUzF6dGwvUkVVTnJ5MW9UbHA3?=
 =?utf-8?B?YmVGV2JSYW9za1dPemx1NW5wWWE3RTBMUVZCUDIxNThTcUMrdDg5TjBKRFlV?=
 =?utf-8?B?ZFhTS0VmQXVTUnFwK0lkY052bE03T3hEMUNlSHAzenllVVFXeDRVWGlZclJG?=
 =?utf-8?B?dE9kUzJ1ZUdhQnFEUDB2emlrYlFOYng1STc3MWFGUUxSbG10NTZOdWFIOGcy?=
 =?utf-8?B?ck9KRTNHOXBZZ3d1T2c4Ry9SRWhHeXJEckFtM1ZuS2x4eVJlWS9nbkRPZDJz?=
 =?utf-8?B?MTV1MzJza0F6TmhyN2lZd1ZkRi8zb1lxUHpXU2d0OVZWakVEYTMraTl0aEFo?=
 =?utf-8?B?Y0NCY2tjVHM3OFlZeURjOXRURjlwdmgrMi9oVEp3cllDV09mMncvaG5qUWkv?=
 =?utf-8?B?eGIzQUV2TFQrek9aNEhpY1JmU0pVMzBSS1lJSUNsUTI1QW5BcVlONXphUzVF?=
 =?utf-8?B?NVJMUkQrZ1czalI0N3dCdFBNWWwxNGFDcjZ0OXAwT0pod2Vpa1FkWHVjWG5H?=
 =?utf-8?B?VWNpU1RBRHU0ZXgwNklZZnJyOWxQK0NaSlBBMVhrMVo0YmlmYmNCRFNiVmNQ?=
 =?utf-8?B?ZDB1bzdodlEzMHNlZm9MVVV6UG5qbTBud3RJRVRpdG84QXhnaGdlZW9jb1Vo?=
 =?utf-8?B?MUVDV0dMMEYzT1VDM1E3TjFiTFI0S3d4anRWdHVkWjhUYk1rTUk1dXRIT3lp?=
 =?utf-8?B?aFZPdVkzR01VSHdURHJkcFFSdGZpL0pqMm1reStvRmMvSEhoK0ZuMlB3S244?=
 =?utf-8?B?Qkl1WTB6VXJYWkJZSFR2UjVTTlZCZXd5djNGQm9UZEtEWWF3NFJXSHVIOTh1?=
 =?utf-8?B?NU0wOEtuanVqMCtoSUpPRzhQd0dRdGNXUHhqMXl1VmwwdTlHWjZXSjRUNGZG?=
 =?utf-8?B?azgvckJ5Mm9wUTZGZEdKc2FxS0lPOTB1alU3RU1KdkNybFpzc21QNk9SUkJD?=
 =?utf-8?B?WkgxOU9Nb0pHbEZxWGhodUNRc0RkMzE0STBDSjdnWVAxTTd4MlZCcklGSVVu?=
 =?utf-8?B?MHNubGJmMm4xK2l2WGpJS1BweG0xY01veUdwZ3ByNzNuZlZ2UGpFY2QrYTRv?=
 =?utf-8?B?bmY1R0JGNU9jNFdLMzJlMDRSa3paVzFZK3N4WGMvSkM5NDZKVXhzNlR3d2RC?=
 =?utf-8?B?aW5DWlE0ODUvVGp6Sm9OaGNjVmNsSGlBRS9pSENpYmRxc2R0S0xod0N4RFE4?=
 =?utf-8?B?Yy9kODA5WXJHTU9DRiszTCtHQUpyV0MxS1FZcEpHTE41MEJhL0N6NnkxcUxR?=
 =?utf-8?B?OEpqSUlBSUJWQU1oOENweGdEZndTV2Q4emxlV0xHZEZPWnlKNkdvcUFOeXFv?=
 =?utf-8?B?a1lwOUphd21Xb3c1aDFtTVB2UDRGKyt4Nk1xNGpVZnB1RHUrcjNqa3IrenB4?=
 =?utf-8?B?S0xlRVpRaG9kUUs4MWF6RERyQ01KU2p6VzZnN2VZUUNzdGp1NTFDNjNRQUxa?=
 =?utf-8?B?Z3VHZE9paE5vMTAzbERtZHRweWlEUWNVQTliSW8xdmpDeHFUcUY0Y1IvSjhl?=
 =?utf-8?Q?JyZetkAb+8KYFm8wxt/RshTU8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967997a7-7e52-499b-0f18-08daa0ba3548
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 18:58:04.6965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeV9QjCGSt1dubn2eow+GfNVmzOnkaRj8fuvtdI6jSCf5D3OSzGvop67PXeXWmYJQVMQ5OmJUdpW2Qhx0uT79g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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

Am 2022-09-27 um 11:43 schrieb Philip Yang:
> Unified memory usage with xnack off is tracked to avoid oversubscribe
> system memory, with xnack on, we don't track unified memory usage to
> allow memory oversubscribe. When switching xnack mode from off to on,
> subsequent free ranges allocated with xnack off will not unreserve
> memory. When switching xnack mode from on to off, subsequent free ranges
> allocated with xnack on will unreserve memory. Both cases cause memory
> accounting unbalanced.
>
> When switching xnack mode from on to off, need reserve already allocated
> svm range memory. When switching xnack mode from off to on, need
> unreserve already allocated svm range memory.
>
> v4: Handle reservation memory failure
> v3: Handle switching xnack mode race with svm_range_deferred_list_work
> v2: Handle both switching xnack from on to off and from off to on cases
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 ++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 44 +++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 +-
>   3 files changed, 64 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 56f7307c21d2..5feaba6a77de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1584,6 +1584,8 @@ static int kfd_ioctl_smi_events(struct file *filep,
>   	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>   }
>   
> +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
> +
>   static int kfd_ioctl_set_xnack_mode(struct file *filep,
>   				    struct kfd_process *p, void *data)
>   {
> @@ -1594,22 +1596,29 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
>   	if (args->xnack_enabled >= 0) {
>   		if (!list_empty(&p->pqm.queues)) {
>   			pr_debug("Process has user queues running\n");
> -			mutex_unlock(&p->mutex);
> -			return -EBUSY;
> +			r = -EBUSY;
> +			goto out_unlock;
>   		}
> -		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
> +
> +		if (p->xnack_enabled == args->xnack_enabled)
> +			goto out_unlock;
> +
> +		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
>   			r = -EPERM;
> -		else
> -			p->xnack_enabled = args->xnack_enabled;
> +			goto out_unlock;
> +		}
> +
> +		r = svm_range_switch_xnack_reserve_mem(p, args->xnack_enabled);
>   	} else {
>   		args->xnack_enabled = p->xnack_enabled;
>   	}
> +
> +out_unlock:
>   	mutex_unlock(&p->mutex);
>   
>   	return r;
>   }
>   
> -#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>   {
>   	struct kfd_ioctl_svm_args *args = data;
> @@ -1629,6 +1638,11 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>   	return r;
>   }
>   #else
> +static int kfd_ioctl_set_xnack_mode(struct file *filep,
> +				    struct kfd_process *p, void *data)
> +{
> +	return -EPERM;
> +}
>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>   {
>   	return -EPERM;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cf5b4005534c..13d2867faa0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -278,7 +278,7 @@ static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
>   	svm_range_free_dma_mappings(prange);
>   
>   	if (update_mem_usage && !p->xnack_enabled) {
> -		pr_debug("unreserve mem limit: %lld\n", size);
> +		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
>   		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>   					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>   	}
> @@ -2956,6 +2956,48 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	return r;
>   }
>   
> +int
> +svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
> +{
> +	struct svm_range *prange;
> +	uint64_t reserved_size = 0;
> +	uint64_t size;
> +	int r = 0;
> +
> +	pr_debug("switching xnack from %d to %d\n", p->xnack_enabled, xnack_enabled);
> +
> +	mutex_lock(&p->svms.lock);
> +
> +	/* Change xnack mode must be inside svms lock, to avoid race with
> +	 * svm_range_deferred_list_work unreserve memory in parallel.
> +	 */
> +	p->xnack_enabled = xnack_enabled;

This should only be set on a successful return.


> +
> +	list_for_each_entry(prange, &p->svms.list, list) {
> +		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
> +		pr_debug("svms 0x%p %s prange 0x%p size 0x%llx\n", &p->svms,
> +			 xnack_enabled ? "unreserve" : "reserve", prange, size);
> +
> +		if (xnack_enabled) {
> +			amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +		} else {
> +			r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +			if (r)
> +				break;
> +			reserved_size += size;
> +		}
> +	}
> +
> +	if (r)
> +		amdgpu_amdkfd_unreserve_mem_limit(NULL, reserved_size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +
> +	mutex_unlock(&p->svms.lock);
> +	return r;
> +}
> +
>   void svm_range_list_fini(struct kfd_process *p)
>   {
>   	struct svm_range *prange;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 012c53729516..e58690376e17 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -203,11 +203,11 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>   
>   void svm_range_set_max_pages(struct amdgpu_device *adev);
> +int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled);
>   
>   #else
>   
>   struct kfd_process;
> -
Unrelated whitespace change.

With these two issues fixed, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   static inline int svm_range_list_init(struct kfd_process *p)
>   {
>   	return 0;

