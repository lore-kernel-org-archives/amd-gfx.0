Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B26CC64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 07:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD19910E962;
	Fri, 10 Mar 2023 07:35:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D0510E962
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 07:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBtV+iaNy18v1cXj551oD9fxxxAEpWccN3zOmiq3dJ2/hT7jbFt2qtoGxx5EP0YK28bB/FXrDNoKqBBrzdiBPA6nlw6qTI1O+WmcC7Jp2JJzx79+UMl+tRdcK80UsqDBQEE+wYrOWxTBMw0WELABMRgxImI1Gch/PK74Z8FeJcyYfRoAcrLADA1Ejb7dfaLQ8xcbamJAq4oz26qjG0QU3b3gdaqzx+N6Zacrq6tyjTy2iARqMkdFlRarj2e8rXpXoR64SpcVPd0cGHmN/il492fssTcjZxgwOWEUkpqe2yN42tZaY9XuQQhgEFHx9w8+GQZ+mp7748d8jU0sEPaZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFfBECwEqwCTDLCOscl0UI1Xj3dp95ueS9QYQ52WkZ4=;
 b=TOYq7rHqjm3qmZHw05/ZfENQ+gziEP7YQVAiiS+s3llc/R2WYzbQknNe9aLY6VYcn87FCKUwfaUc92/0BEGmvKDk7dYTPJPPEXaFaEpHGMtYuPU5BHQuVMV1HueXGK4iUzwuGiEy5FgctfqplCijpRC63pNhDCuskOs0/V+Uyf9rQiqzYPpWFLH4pDhxt9EI+XDg72RrD0phvHfXRAkL/zRCh5W2D7AgzTlPTPVZnqW4os8t3KGukvrfiP6T11yzOpmeZ/6jrTUwxWHvfmCFbq0TvRJ/vL5C4Z5NDAEJwxoKyKQT88R1T0mwF7vu9rkTxWlH8W/fYHPo4ZZYBuneng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFfBECwEqwCTDLCOscl0UI1Xj3dp95ueS9QYQ52WkZ4=;
 b=BoP+EPDrljQ671R0qFrAJRSXeOQ7l7//plTSI3IQ5ocE0iFirfezVSwXS5F5qIdwWgN12Jx1nlR4umsb4R39d9lLG69mJ9ktgq90wpzuomejwsJvaMZ3F1SuAd7j/XHnsbaeYKs+pxwaducFEwq7YolbljvB08xIlZTmVifkYaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 07:35:20 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 07:35:20 +0000
Message-ID: <c2b39247-b2ca-ed45-4131-863083a268e0@amd.com>
Date: Fri, 10 Mar 2023 08:35:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] drm/amdgpu: drop pm_sysfs_en flag from amdgpu_device
 structure
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com
References: <20230310050342.2902820-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230310050342.2902820-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 43630a7d-54be-4f50-8061-08db213a003a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mez/xUVh6CwUiIwvH0TLXsgK06ydPtrtL4/lzgLXNj+4zeQrkBItFGgiFKtR+pgghU+EWiH+kmCayzKk0bPD+XigzHutG45ViIAvBhTUHJebNf3ZehAzFF1Xi8A2QvdVDGq/DeTz1QmHKdgKDRUDGwKvhfirdEUjqTSBsFTPgxFAPGKhmEIB72aS1ZvWjGkxHiL2+rvauUVREOpRhkoaRpz6KtadIioacOwg71zoiQdvq0XK3c0cGfWAgtCEvUWuo1ps3Ps7Eccly6Wx6xBkLSPw3CsOeWTTwCj1BxTg4s7vhaQh2vVwCwmQELXX7MGLtq+lsp4bENhjy9yJPDGSVxxQPHx/mS/1spnu2G7LyE6QHaaENTPEIVXViRxpq/bA3urcn+oqDkDmWhwKf5vWX8OZMZqw0GAbZU6CPcMVgOrkkhcdzOwRY12+SxlWFZM5q5Kk2l1/ELEXGiqzSCDVvve11jumjd5dF/+iJIBpcyoKpkTlECp4rgPxTe/iA8S0kntIUOONvWFwWiyLJTy6S7WK4KZqSPu40QHLxcMC+131OAn8a0VvlTy+wxY2oes2PPiDRW6j8KI8u8KG4N/iLE1WU8hxndD7FOXPwSz8BNCRdy6whbJfAF0dHVwCt5EZx/h/d2aKihgPubFU0Tsf8TC/y0+kIQEtIAPyhSsRJNVf3lzQP+tLavDOQiVPUNhDJBFBXdxY47+KrjxT5+RYhcix36UYa0vJzq8m9oUamt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199018)(36756003)(6636002)(6486002)(5660300002)(316002)(66476007)(8936002)(2906002)(66946007)(66556008)(8676002)(41300700001)(186003)(86362001)(31696002)(6666004)(2616005)(6512007)(478600001)(83380400001)(6506007)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkQ5OFpTWjZ6Q0J1R0QyaU9rY2hLZ1BjT0loeEFWV2loMGdGNzh1eGt0NTRS?=
 =?utf-8?B?SEUrSlhkQ1dyVDkzWStOMEJNUmFlV3pla2dSQ2JmS3VxSTZ0NzYwSThqQXpQ?=
 =?utf-8?B?RjVZZmNSRkdyaWJ2YUdXUU05MHU3ZHlzRFl0YmZlZmhVbVppK01pZ1M3QVJX?=
 =?utf-8?B?R0lhMnE1THRsczhnbmtURVExUlYwZHZJNDVBQ0d3YkxBVXdpTFNwYzhJcllx?=
 =?utf-8?B?a1Rpa2tKMy9WYUt4aWJHY21CSnpNdnhuUlAvS2dYbjFQMWtSV01pWDhUZzhm?=
 =?utf-8?B?UitodTBTbG9sK0ZPR1VBZmlPUURRRGhHRkFjdjlLUlRmMUxFeEswWjAxUDRW?=
 =?utf-8?B?TUFuL2QzalpVMWwzVTJheGE3TzhXdDhDWVAzLzFMa3oxQXdCVVd4Q1JTUVZ4?=
 =?utf-8?B?anpxdXFvOEN5WVcxb2pybUdkUTBhNlMwMDJCMGNOaHlwMThFaG9RUEFKOCtn?=
 =?utf-8?B?c0tsZ1kyWVQ4cGRPRmkxUWdUWnF2S1VJRkdYaEhmV2lRU01NOTRSdmY4MlBQ?=
 =?utf-8?B?OUxmSW1ia1ZTbzJPbEUyVnBIdVRPaWJVK1dPakEweDZIaERjVksva3ZCTWNX?=
 =?utf-8?B?MWE3NUd4bVRnNW4vQy9yQXVhQ1pRckYwUVZWbDBJdFJ6N2Y3NVVvcXg0M2hx?=
 =?utf-8?B?aWl5U1BUSDVBaU43eE4rSkZzL1JlRUtqbFA4Tml4aGRMTDBxYkZ6RFptaXcr?=
 =?utf-8?B?MmhkazEzOUVZWUM2bWVtdjFYVU4yZzlpM3Jqa25GWmRKWlh5VUlHTFZRTDl6?=
 =?utf-8?B?UTFPVjYwSCtWRkZNejlUQmtsMUhKcVkxbFROOS8rOFpPb3p2K0VReE9ZU3FU?=
 =?utf-8?B?dG5Odk9vOWpQNG9FQ1FhUXE1Z3c2a0tGZmJJQXpyUGlVUG85eVVVQ082SXUw?=
 =?utf-8?B?c09YQ21oNGJCeWEvTUtDYmc1cmVsNFB0a1hIMU1FQjdiYzVkSUR6OSttUnZI?=
 =?utf-8?B?aE5xTDRZVkx4YXVvZXV1OHd5ZDJDZzJ4S3NUVkdnT2I0UVN5YUpBeW84RlVQ?=
 =?utf-8?B?U1hMRjBoYnVNOEdPZ3F3dlptYjI4RE1lTXNvT1V6QmFqNXV0VTRYUzZ1aFR6?=
 =?utf-8?B?WlYwZXI3OW5MbjU4TGNmM3JZSGdYNnBBdUUybDkweWR6cmloT3dNV3RZK0k4?=
 =?utf-8?B?ZS9OeTZUQ2lYUmlDcnhrRmtEYjJTR01tb3FXakVrdXRScUpQa1hNeWJCRjhZ?=
 =?utf-8?B?dVFJWE5pMU53MlN5Vk9DdXNrSGhRSVIzUzVPZ2ZvQXpXVU1mZ2pjbFZzclZK?=
 =?utf-8?B?cFMrS3RGZmlTYUdpSi9GQUZTMHB1K1p6OHcxYjNZRmsxTENlZExaSEtJaEh6?=
 =?utf-8?B?bDhYeC9uKytmbURYOWVHN3lGZWhudEdhM0o5dVZCSXRONFgyeFJ0NzdvUVcr?=
 =?utf-8?B?RWxuWHNJbml0L2NiSEJ0eVJFaTdjMGZxRUFCeDBzRGFpMlNFakJ6L0xVMUZu?=
 =?utf-8?B?QUZBMGhpalZtOFY5UlN1Z1VDSXRtbTNMeUQ2UjNwVTNwWUQ0Wmp0OTlsR3dp?=
 =?utf-8?B?OUtkdXYrWHVUc29yY1F6Y1AzcndqN2Z5R1lLQmJsd0pXYnNjVjM5Q2Y4K0xB?=
 =?utf-8?B?Uy9JcGwzMnN1T3UrMThFRjg4NUFxOWdNWVQraS81akdrOU1kT3QzWUxaVWVn?=
 =?utf-8?B?Yy9HS25SNk1JZnY2MzI5OCtaeS9nTUI1dEhJWUFHclhrSFRoNEtqaDM0Y1VZ?=
 =?utf-8?B?Z0w1bHhianBWVU52b0lzdFd6OFFqaEZJK005Vyt4SVBVV2R2OFhxU0hqTWJ6?=
 =?utf-8?B?aVhNNllGckZtdWFpZ2FUbzIxYjJ2VmY3K0V0Z0tCQU5PN1I1SFUxNkIrL1VB?=
 =?utf-8?B?T2h5UXlBQWw0bGN3MnNKbmNIUExHWDFYNHhRM2s3VUhNVW9PWFg3Z09lRExT?=
 =?utf-8?B?N241VEw3UnhRVFpmd3dhdDBIMFVFU2s3cjJJT2MyZjlBcHVkRDhQVTVVUTNP?=
 =?utf-8?B?Y3U5RDFMN1NUWXA0S0RuNWNUZ3RBTzFaYThRNytueEkrcXVDdWEvTXVuSlZh?=
 =?utf-8?B?aGtLRjBDOGJjYzRjN2xxdWtTRjNMa2JrVURuQXE4SHRlcUlsMzVoeTFxSXJ6?=
 =?utf-8?B?RU5ybkZ1MGFhQ2pJMnJqMldNUEtMbkhMeGR5V1kzVXJWb3pQWVhXM2FKbVdG?=
 =?utf-8?B?clJVamhlb1ViRzRpcFZQUWYrVk1RY3BWOXhsbSs0L293dk04UlNLWnNpZ2pv?=
 =?utf-8?Q?EjdUbruGZ3eu+JtjA2iJxFDJMbw0EAVCCu6X31KuGqeu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43630a7d-54be-4f50-8061-08db213a003a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 07:35:20.0741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YZGKqCJdDR62KDgulSjjTVNi2aqbchEpGsRgapcBHLjc13Yfm1WmGNGIEhx5Vk7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
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

Am 10.03.23 um 06:03 schrieb Guchun Chen:
> pm_sysfs_en is overlapped with pm.sysfs_initialized, so drop it
> for simplifying code(no functional change).
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++------
>   2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 164141bc8b4a..386729cc45d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1023,7 +1023,6 @@ struct amdgpu_device {
>   	bool                            in_runpm;
>   	bool                            has_pr3;
>   
> -	bool                            pm_sysfs_en;
>   	bool                            ucode_sysfs_en;
>   	bool                            psp_sysfs_en;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index da5b0258a237..41ef3368556b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3864,11 +3864,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	adev->mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
>   
>   	r = amdgpu_pm_sysfs_init(adev);
> -	if (r) {
> -		adev->pm_sysfs_en = false;
> -		DRM_ERROR("registering pm debugfs failed (%d).\n", r);
> -	} else
> -		adev->pm_sysfs_en = true;
> +	if (r)
> +		DRM_ERROR("registering pm sysfs failed (%d).\n", r);
>   
>   	r = amdgpu_ucode_sysfs_init(adev);
>   	if (r) {
> @@ -4011,7 +4008,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   	if (adev->mman.initialized)
>   		drain_workqueue(adev->mman.bdev.wq);
>   
> -	if (adev->pm_sysfs_en)
> +	if (adev->pm.sysfs_initialized)
>   		amdgpu_pm_sysfs_fini(adev);
>   	if (adev->ucode_sysfs_en)
>   		amdgpu_ucode_sysfs_fini(adev);

