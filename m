Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193E0C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 23:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F16C10E104;
	Mon,  6 Nov 2023 23:10:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D561210E104
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 23:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2pc+the7qcG4xYHrFkV+tzHvO4st3wBAisebbxaYBdaHrjH1VWklVkIFGgmPN2cJ7GzFRjk/ghrSYYQozBrFUgIDUtnu+63df2CY5Kgs4UDI5OlA3ZQsKpwz1GxGYwKLR+LfbVUV1ZbwRKR1gI9B7W4ETBI/AaaAJRDcejrf8ujGyiJnrh7CmSgtJLMBLnl3gXBZAgdK0HMCs4C4KL0HKSBQFkrcOLXJgGKea4sTuKrRLW20MWVpzbQxITiaQAqlVl1iP8hgJ+K2Nm5cHlFvTNh1mgpIqLNkVahRsUfViY4IQlq9ZwsSO2F1NnCLA4H1H0B+7qkWM+9Gn/nC0hDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u83elcwzxgq/4KuuLV7DvPmZwK374OIvLLde5kBhpak=;
 b=ZQJq+6qgCAbdmMre/tVXUtZmAlNJSKOwMM5R7nBN/Qb55bZKbRsfPEj89tADd3Ct+YuYlzTTvGdAqlQxeZDQW0a/lJzpJ4nL9vy2zjztcINfgCxUDBtvlWifMHkt+nr83wtR3vnwImdyCzaPszicUWJDnTkkvl6HXdk3UE1ml4HIAFYoRGnPgfMnszipAxZTJJWB2gZY1Z8sFF/gVHxu/QK+0RxbtvSAKOwoMGa7JHnT20r/vNw2ZuoliZenLuSWrdz5Q9uqRD6a4I5P+elrvYUQRInZ1gdpSPy8tGEFar37PYiG5JNhrAbSZy80o6rJ0s0s/UFzrViMbJy6pJggzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u83elcwzxgq/4KuuLV7DvPmZwK374OIvLLde5kBhpak=;
 b=KMRDI6KD7M/HOsXJmBwBDM+Ebj8qOIo9/VRYkDG029fxGY3rQwa9Ws1z8rydMmPog/18kDvE4OH8VwbYJwJlXcsWhJ8k9egGoaYzsQcOTdtetaJAJ7oPUwnGJNSe4oWTlp04ihofV77jxl96k3PZNM8380EXya2QAhy1RmqzDus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 23:10:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa%3]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 23:10:31 +0000
Message-ID: <4db20aad-c19f-4adf-ba13-97acbdb6ba16@amd.com>
Date: Mon, 6 Nov 2023 18:10:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Skip locking KFD when unbinding GPU
Content-Language: en-US
To: Lawrence Yiu <lawyiu.dev@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20231106071405.121981-1-lawyiu.dev@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20231106071405.121981-1-lawyiu.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0220.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d1fc1b-723c-4d20-29ff-08dbdf1d9311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drsm/pHgvnnGOYQjcq2zoWHktWu4YmrEsH1X82R95Sa0v1guABvfBqzZeeJelNrdc0IfW8xld7IwdMwcmNHI4WmRq8x/vBSiSwK4Or3G5l67E9CVqZU0Kjrs+J7Ot6Dw+iNs2qeDZrb/DrHWbKsFm+sEgz/rF2Wiih876cZNRakwayzscitd0iKt3zK5Ue6fukh8evWPhECQNUOdeKIa6sp3+yXaJx+khB3WJ6NnxpGJ2Z0cDGGoENrLmFrDKgIIWKuQCQpr6b7jTQkWqzMOYh0USgUs5cyDMYhUJFiW5/DufKSiz7v4BS3fJ0ySs0vCI/jwdl81ZuuI9O3yAL77PPVnNoLAVpElyzykQnDJrV6Ex4DOd1bj9wBiHDsFuqA/1wHY8LPBND5oy1AdPKOSeSAG9+RrYkDyMnMCDvAghzEJuPuSrk3g0CpkinOMAJqHWkpIrgnFMAjOSFOJIgSberhlwulNBXBH7mr7oqfv+cgBShG1AYz+KAAl+Gs1FmWaF2ZoyZLwPODwIufez3XerQk1AAC2CFKPYjShTZCdnqXeE84EZi8J63CPZWAegx/K4ele4a1Th9Fow5SA0TEazjGu2jI1ZYuwE31eRXgkrXYX4pe3CZ/Uc6rrHcZnBj2tn/m9FyeZwh0Cbk5vBel9VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(316002)(38100700002)(478600001)(53546011)(6506007)(966005)(6486002)(66556008)(66476007)(26005)(6512007)(66946007)(2616005)(5660300002)(2906002)(8676002)(36756003)(4326008)(31696002)(86362001)(8936002)(41300700001)(44832011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emV3VGQzZExGbnhpMkg3RXcxRHNkaG1xM0IxRldTMXRaT3huUlUyK1pvUHVq?=
 =?utf-8?B?YkZ4OVovd1FYNFh4WE5sRFp4QWc5Smw1bzlNd3JwSkVuQ1QvOE4zM1pycnln?=
 =?utf-8?B?c05CZ3pnekQ4UlRzK1BDSVZWS0xkbGNXQVN3cU9PbVRLVUo2QkNzOE12U2Rk?=
 =?utf-8?B?U3l0NnlUV2I0U0JTMldnWUo3cG1pditlOFRGNVdvcDgzTTkzZlo1MHIxakNr?=
 =?utf-8?B?YU03UW82U2NZR2F6cS9NaEFZNjJsaldCRVVDTS9TeWJSb1N0WlRQUTU4VE9o?=
 =?utf-8?B?NytpSUp3Z0twUzEyOUZLZVp5SlhpMEd4N1VLakREZUpUbXRiZGxnSTVMSWNo?=
 =?utf-8?B?ZEZKdTZmeGdGcUIzL1hWU0tCSldKa3hwb0dmdW5SUG91bHdBT055elpFQnFa?=
 =?utf-8?B?bTJLbDV2Vk56R2Uzb2NhOFJxcjN5d2RGZGZEMy9tNTN4WndDTW5nSUlCWmNu?=
 =?utf-8?B?VWtzVVNPSU1Rc21ZTnpWTXFFOWtleGZ1dk41V2laTUhESWFWclg4R3hVN0NZ?=
 =?utf-8?B?cE9ybG5jTXZQWXlySko4SE0rNDU5QXFEeHlRQS9uY1c2b2NzUEtLRWRGSm10?=
 =?utf-8?B?b2tObEhrVWN6Wm5jODFrVUpWRWx2R2l6VmdRcGVrazBBVXlzT29MSk5MUEJj?=
 =?utf-8?B?elpENXpZTkpQVmF2RXR4TnF5WFZXM3B0T3ZCT0V6Q1kwd29DWmNETm84dzZZ?=
 =?utf-8?B?dnZFZUlSbFd2TnRYMGJ6YnFCa3p4WlRObG92OENRQS9kOCtMVkhSN2h0aFZ4?=
 =?utf-8?B?aVFpbGVNQSsxN3F5dGhFc3ZjU1FnRXhXZW1tVmVocTU5dFp3WXZzaWRvSlps?=
 =?utf-8?B?N2ZoMldscGROZlg2ZHVURiszYk0rR0hRa2lCOEE2ZXFLR0oyd0hRVWNsRzJr?=
 =?utf-8?B?elZJQlBwSmE3REpncEcxMVU4N241S3l5cm5mYjhaYnd3U2NyNTBmZnpGMDY2?=
 =?utf-8?B?eXFDU2pOMm5DWXZhNFN3aUNqMzFIV1pDbThSRzlOd3dLcGErTG5Jemx4cHFQ?=
 =?utf-8?B?YmRIZHNRL09JVURUMjlwbk5uQjRnd3F1TkRyTTVtNExsUkZsN2pTeFkvUFZx?=
 =?utf-8?B?ZXJYOVZPdkl4bFhIT0w1L0YxMTRSME4zdjhhY3VialJNYkpKNHdLdW5yOGkw?=
 =?utf-8?B?a1ZuTm1vNUNGdDBiN0NmOXNYYm1Dcmk3RnYrV3UyV1Rja3Z4Um11YjM4OGdm?=
 =?utf-8?B?ZlRTK01DOFdZUTFWRDhpa2FRWlIxN2dvUTB6ZVluYmdHa1BFVjRiTlhaV1RM?=
 =?utf-8?B?ZE9yZDJpNDNrbGkxT0Qyb2JSSlNJbllFeGZGVUMzK2UxVTBaQ3BPVnlPSklw?=
 =?utf-8?B?K3dnYmxxN1hDdHpkTzZ0UUFndWE2Z21Za1MvbWlhSGZ0NzJOZ1dqa0h4Nkc5?=
 =?utf-8?B?Y0x2S3pwVW9hRXI1RHpaMGJYVWttS3JBeXRWMzc3Rk9xcmpsbmcwUU8yalZi?=
 =?utf-8?B?SlcyMExUby9FRyt6OGdYd0RVeDUyR2RhYnNPeHAxc3NjT1RYOUxmMXBuUm8w?=
 =?utf-8?B?UzZDSEZxanpPLzcxR3g0R3BkVnE1ajFKc21ZdnRiemU5bXM0dXJORzBSVDlp?=
 =?utf-8?B?dFVVSFFPS1ZLN0w1UzBqL09xY2JPLy9oRG5HVFdwdjFtNXYwS3hxcUdYWUlt?=
 =?utf-8?B?Z2NoWVlyMkkxM21xRFlYV25DaHlxbEhJZXJHcFdnbit5d084S0VINXRaSWU1?=
 =?utf-8?B?bEZDaUNLTGZkL1NnZVpkK1R0M3VpYWlOdGRYb2tSdEZxbmR4YWxydmhwczUr?=
 =?utf-8?B?Q2U4Q0tYT3l4RzBaRGtjSlFKSjlQbDFXa0trcWRINkZBUm1XcHh3a3NnL0Q1?=
 =?utf-8?B?akRheVNBNjQwTFZ5cDI4OFF5MlFSc1FrWlhvYzBVMkN6MEZ2NG9HLzJ5UURQ?=
 =?utf-8?B?MjV1ejV1YUhpSVdtRjNWbUhJaHczelQwMk5ud1JoT054K1RvbFBhNnhQYjVE?=
 =?utf-8?B?RGVIZDJxOHpIYUxVYUNGa25TY2lpUEJEcWtZZmVkUDZhU1R6dUFFd2orSm0r?=
 =?utf-8?B?VGZ1Q0FXSDQ2VGUxaDg1TEZYWXlqeVNlVCthQVo1Z2loNm9HdGpqOVpKZTU5?=
 =?utf-8?B?SDBYbmtwTjRDVFNRbVBuak1kQkg1TDBzSWF2RzAwTmJobnFaVzd0eHRXSG5X?=
 =?utf-8?Q?ZZkrITbdL2Xw3ZGDX5etNfCL0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d1fc1b-723c-4d20-29ff-08dbdf1d9311
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 23:10:31.9062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0x46lAtNNtPlGx9lNqJeYA+0eqwUHGsBpFb4zMkZB+2mgai5U93i6dmpqOId5xLGPX7oCzjsdKYvhRnIZT1REQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
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
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-06 2:14, Lawrence Yiu wrote:
> After unbinding a GPU, KFD becomes locked and unusable, resulting in
> applications not being able to use ROCm for compute anymore and rocminfo
> outputting the following error message:
>
> ROCk module is loaded
> Unable to open /dev/kfd read-write: Invalid argument
>
> KFD remains locked even after rebinding the same GPU and a system reboot
> is required to unlock it. Fix this by not locking KFD during the GPU
> unbind process.
>
> Closes: https://github.com/RadeonOpenCompute/ROCm/issues/629
> Signed-off-by: Lawrence Yiu <lawyiu.dev@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 0a9cf9dfc224..c9436039e619 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -949,8 +949,8 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>   	if (!kfd->init_complete)
>   		return;
>   
> -	/* for runtime suspend, skip locking kfd */
> -	if (!run_pm) {
> +	/* for runtime suspend or GPU unbind, skip locking kfd */
> +	if (!run_pm && !drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
>   		mutex_lock(&kfd_processes_mutex);
>   		count = ++kfd_locked;

This lock is meant to prevent new KFD processes from starting while a 
GPU reset or suspend/resume is in progress. Just below it also suspends 
the user mode queues of all processes to ensure the GPUs are idle before 
suspending. It sounds like this is not applicable to the hot-unplug use 
case. In particular, if there is no matching kgd2kfd_resume call, that 
would lead to the symptom you describe, where KFD just gets stuck forever.

What's the semantics of GPU hot unplug? Is it more like a GPU reset or 
more like runtime-PM? In other words, do we need to notify processes 
when a GPU goes away, or is there some other mechanism that ensures a 
GPU is idle before being unplugged?

If it's more like runtime PM, then simply call kgd2kfd_suspend with 
run_pm=true.

If it's more like a GPU reset, you can't just remove this lock. User 
mode won't be aware and will try to continue using the GPU. In the best 
case applications will just soft hang. Instead you should probably 
replace the kgd2kfd_suspend call with calls to kgd2kfd_pre_reset and 
kgd2kfd_post_reset. That would idle the affected GPU, notify user mode 
processes using the GPU that something is wrong, and resume all the GPUs 
again. You'd need to be careful about the sequence between actual unplug 
and post_reset. Not sure if post_reset would need changes to avoid 
failing on the removed GPU.

Regards,
   Felix


>   		mutex_unlock(&kfd_processes_mutex);
