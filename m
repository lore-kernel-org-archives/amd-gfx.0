Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B15C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 03:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A7D61058
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 03:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38A7D61058
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59A1588065;
	Wed,  3 Nov 2021 03:53:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D0FD6E05F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 03:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIkWMPbevfvjM8mFbkLtJOxsxxRm6xW7YA0wWVeGdFERtFmQSk2RWZ5iqzzBYyCc0fKYYtwbuDX+/h3gIB3hpyDZjXBLtOsNuy35PfgneQkJwQxLlwRPffxf/FFPURQef8NfDwpFMgHgIKKipI3sUccz8/loDy/fX5izgrBBX/jYJQO9wh9v0odvGJUsjWxwzPFWKnL4qYyJvaL6pFTKNe8q8iGEpcrBrZQt9qZnb0pjzaW5m+KmSwerOz0OinE7ODBUqsg3B61HVK2Whkx/EDkqO/FmavgoUmxIWSyr/zfEjAwia6myzuHIeCn+XN6JdTwApZBLwEP9uOi+o5XJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9DwcYq03LgTa72HPcFlmr+KFkGTy0Qi14S/lC2102Y=;
 b=MQmftrtPtPnlFsx3B3bnLzBO4QjiebyNIpAM7m0GUjOOZjJWG8Z/RmewTv2KDt9qSvGE18stqhG7vd0w7IEc1UKVwqw5syANaFXkYVbLiWa/Dysu9pEseys3uJCyp2oMHYNu8N7tdZHnRkdaB9nAOQ86XBbOOum3essDnRvdb7LvkydZLRufpTTVnPTH8EqWK+BHCfa8qkpaf/6aSvlr1tU3M0fj5xKl4zDwFTlS9PmpLhb1WBbBmTFl6dvI48TrIOmgTDqgR6ZHEmJS7I2y/kNaHAgN/sV+r1rg7J/yZh/Q+OVzENW4rss+jYbJbln+kObPfCZpJ5zeJtXhsWcD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9DwcYq03LgTa72HPcFlmr+KFkGTy0Qi14S/lC2102Y=;
 b=4Gl4pICl4uda1yDuL8I9u1Mit1QeGVcWqH62eEu0WOyzhoge3HxVaE8LPGTUXOm9zekPkofVdTw/GgcoR/HezO5gQzYMK+ZTbtgJlKgaAwmYPyolz0pZkNcSupTK8qB1yMccbHoGDzx5WviIuzVCdkZQN+1+At8gNMzZdgL8/18=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 03:53:28 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4649.019; Wed, 3 Nov 2021
 03:53:28 +0000
Message-ID: <e390c469-5584-4157-ccaa-3be588b4143a@amd.com>
Date: Wed, 3 Nov 2021 09:23:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/2] drm/amdkfd: fix boot failure when iommu is disabled
 in Picasso.
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211102192324.3402-1-James.Zhu@amd.com>
 <20211102192324.3402-2-James.Zhu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211102192324.3402-2-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::30) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN1PR01CA0090.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 03:53:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8694aa-94ec-41ff-dfa2-08d99e7d7e2f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3930:
X-Microsoft-Antispam-PRVS: <DM6PR12MB39301F6E5BF5526053BDBCC3978C9@DM6PR12MB3930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+Oc5f6IUX3Z8zjgXzDP2ZwcPirBGoD0GYZucbFFOuZmUfPUA6B23rRhKAt84HLoBZ7PvU4e+pA1Uanz1ASVoBY1KBaS/vdW4bqocmiTWHwuWSJ8RPokGRQBmO5QKC1iWObdcpG8aIOowlYAQaiI7gLap7kBmnskOVmPX2Ra8Sm1hEn6jXZTZ63dOtD3tAy3G69PVs3LzWctTMOcEl69UnY9bo8EYxXCciG3LiA7bELnacQ2r7pV7oPWvoultv8mFbFCCszgZsxB2Rkm1F4JC7bl6mfaAZxNQsnnJodYIeHWJMftSKl0PKjEGyvHWnUFVA298Dae4Q+hkWKbSwfxTTSfkNM6RVlerRShMv+elL0mZcmqRWlE9joMiSEVJV57nHoL2mkrk1EBaniWdaG4tE4zpWyP7nJvL34uq32I+YfCQixGAiHcv9GbpJwbDozCmgXgu3mV9+zaUtlirHfu7Onzk9GU4W3Y55b8vTder/UasmtKoBOA60cnuANH5GLLgs97pRNe9PvoOB5+XAD60fZkjgHCDPIIESK9hxt7JloKjDN586hcJw0TWkY3mQChqcWLZZmleIzWLgijv9Fc++EYktY4v3F5tKMwXC+PkVMBq4Q2na1ge3I6Ec8CajPN63AUlTBPCsK/tgqjdUQcphADjhIbFRcO/wMura8lIaHJM+UdYLduQM05z9LlR05Y5WisDfE8Hl2GIRYudmmn7alyTgvlKBcz9G6CwZFWdmn5rtyiNxjbnpoOqwtg5hmnBqxFUE4T/v/0RW6KSLQSPJ1v9oSdTgaY4EdEATTzaeu4aoz686YllAHs01cSDj5g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(16576012)(83380400001)(6666004)(508600001)(966005)(6486002)(2616005)(956004)(2906002)(86362001)(8936002)(186003)(26005)(66556008)(31686004)(4326008)(66476007)(5660300002)(8676002)(36756003)(31696002)(53546011)(38100700002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3BGbjVQNVRSSm9IYm5kNW9neWtBS2thY1owK3dpZ1RKemFETXJReHJRSzFy?=
 =?utf-8?B?M0xuRDRUOGdHQ3ZiSGxvNS9rQnZOamlsTTRoN01hTGRieXA3UTYxMkUvaHJv?=
 =?utf-8?B?eWNSa1FwMnpQOFk3bUlidHNFUkhIMzdBWStrdEtDL3RJdUhlWDROVmxrMmxR?=
 =?utf-8?B?ckR6M1I1YXZWZGtxYWRBdzc4NUlwVzhrSS9kdVBadEE4SkJVZlFvVzR3VVJl?=
 =?utf-8?B?RnRNZXg3cFozdkF6Q2VpbmdUdy82dkZWbm82akI5enBiZkhkNE9pd1pEaTlx?=
 =?utf-8?B?YldLcnV1aHQxOTZ3N1dGME9UNTBJbHA3clhYWS9CZnJvSUs1Q0Jya2MreGdh?=
 =?utf-8?B?K1BPTlJDZ3JnZDVrVno1cG84RytxS3hZV2tWcnFreks0MXhYekJTSC9OZWJn?=
 =?utf-8?B?TFpoQkl3L0RDdlg4UnZBazF3bmdHWVZsaHJzUjZZc0RTbkhSQnRsWmNFcGEx?=
 =?utf-8?B?OUhqMU9tRGJ6RitQc3I1bDM3anBycTRmMk5XVkVEWmtQd3RRckhzSUxXQ0ky?=
 =?utf-8?B?MWV0N0tqdWw3ZVNOMjhDL0hPTW9BbzBOT0ZxOFp4ZktiSEVSRG5UV1BZRDdM?=
 =?utf-8?B?ZTZPLzVLclovbCtPMFJwaVFienV3TTFsNnRXNTRjMUlES2tRVzRXM0RxcWUr?=
 =?utf-8?B?UFA5SWJUOFB2ZlRRd0kvY0U4bWVJR3RWdUhpeTZGYk5EeXVFNWlIaDJuYnJR?=
 =?utf-8?B?NHpqSjd3bkFpb09VUFM2ZEpGdGxTeit6ak1veXlVbXk3WHhDUGhmV1ZILzVn?=
 =?utf-8?B?alJrRmsxVXA0SXBncFRYWGpDK2wzejBWd0xieHVvdnpQYXZ1Slh1MHlPdHh0?=
 =?utf-8?B?ZzcyM1YvWGFJL1JoNG5LK2hkb1JNWUVLVmdDUHJ0a3RDRW1nWDZ2THdHdFdH?=
 =?utf-8?B?VlRnUDNySWNSSmEwMHJ2RHUrN0lJdUNUeXMxL3F3MUIrbFc5NFhJaFlEZlpW?=
 =?utf-8?B?YkpxdDhJdnNnRjNFZmdoTy9jRzMzZnBKTEVpUWJKZkswaVN4UEVVTGxmOVEv?=
 =?utf-8?B?NXN0RWgwaHZCSGhMRFBoL0wrZFRZNTNTcFcvQXB6TFhRNnJnTXJRMmlLYjdE?=
 =?utf-8?B?aXA1dU5HZ2Q5Q0FQRmpKZHFGM04rM092d1lJamtFQWphRUlkNG1ZcmEzSVdT?=
 =?utf-8?B?Q0VEK0taRGVCUGtrWmJZbWN1TURlTjJyeGVFeUszaEExaXVsMUo0RlVjLzc5?=
 =?utf-8?B?c2I2S1RLVkxjSE9jTWN4REJqMjl3a3I1aC80V01panlLb1pqZ21PK2RWVEpu?=
 =?utf-8?B?eWVuY1QwVHZMUGhLdkRIWFN6eHFDTk1zd0dGYy91OExzeXBMMzdXeXl1WGFU?=
 =?utf-8?B?eVRTSEVqS2xLdGo0SlhCS3JGcHE4bUZCR3JJdXBqOUFTMDVMQVNPZDBabWsy?=
 =?utf-8?B?ZlV2QWQ0ZUh0TWZJaHZCWTYvZDdLOWJpSGkrd2ZkVzV5VnRuM0pXOEhxSzli?=
 =?utf-8?B?MnpydlRCRXFDWHlGOTRzcnc4S3d4VEZ4YnlENDBmMHhMa0JLeVUvaG5MK2tr?=
 =?utf-8?B?RGEyaUkzREJLYnY5U2hHWFlpYVVLWjNicmUrajNUUFF6bDRmS3RocUR6anU0?=
 =?utf-8?B?N0Q2R2gwREhieDh3eGdtWkhUOWZCL08vY0tkdjY0bXZBS2prSjBZWTRmeEhv?=
 =?utf-8?B?clJsdktBS05HTWtOOVQraTBuYVZDMUlhamlYWW5FMXZ4Y3FDRHhqbGd1Mi9N?=
 =?utf-8?B?ekxBUTU1THRoZzB3dVB4VUU2MTN5TXFKdFpqK0NGT29QZDhSN2NtR1ZxVzNo?=
 =?utf-8?B?bjZ0OWhyRHVWUXlVZVIwU2QzQUQ4bk5oVkxDVlBuRHRwVVB5UHlvUTRBUjg2?=
 =?utf-8?B?WWhVeS9aTlZwVW9iNFNOY21pVytJdk9acFRKbUpqalo3a0pIeWxXd0xtNTMv?=
 =?utf-8?B?ZVY4YjFoK2diMDBtNlFaUDdtYXpWV3BXVWd2ZjVOVy9wODZrT1UyV2hvRnZD?=
 =?utf-8?B?RE85elcwYnJEMUtGcFFSd0ZROFB5b0FjQXpxd3MrbjZHbDVEVmdiRzRaUWJl?=
 =?utf-8?B?NlRrMVZ4V1hPWlVUMmFsRVMrSndaMHd5WFlQcjk2bkxlN0pCNkNXVGp3UGFU?=
 =?utf-8?B?Nit4SkdyUG5VelVXSm1BYVNZWDhwRFh5UVkwVFZFVlNKaWhMKzI0MFcvVEVj?=
 =?utf-8?Q?NYQU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8694aa-94ec-41ff-dfa2-08d99e7d7e2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 03:53:28.0689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFKOxZt2sF+uYNurpa39B450QzCDH6+rEaHLPGd3l8NFyCHIwodP5ml5iyDZ/F9n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3930
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com,
 youling <youling257@gmail.com>, jamesz@amd.com, zarniwhoop@ntlworld.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/3/2021 12:53 AM, James Zhu wrote:
> From: Yifan Zhang <yifan1.zhang@amd.com>
> 
> When IOMMU disabled in sbios and kfd in iommuv2 path, iommuv2
> init will fail. But this failure should not block amdgpu driver init.
> 
> Reported-by: youling <youling257@gmail.com>
> Tested-by: youling <youling257@gmail.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Reviewed-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 3 +++
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e56bc925afcf..f77823ce7ae8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2398,10 +2398,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   	if (!adev->gmc.xgmi.pending_reset)
>   		amdgpu_amdkfd_device_init(adev);
>   
> -	r = amdgpu_amdkfd_resume_iommu(adev);
> -	if (r)
> -		goto init_failed;
> -
>   	amdgpu_fru_get_product_info(adev);
>   
>   init_failed:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index be26c4016ade..7677ced16a27 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1031,6 +1031,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   
>   	svm_migrate_init(kfd->adev);
>   
> +	if(kgd2kfd_resume_iommu(kfd))
> +		goto device_iommu_error;
> +

This also brings a duplicate iommu resume in the reset path -
https://elixir.bootlin.com/linux/v5.15/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L4612

Thanks,
Lijo
>   	if (kfd_resume(kfd))
>   		goto kfd_resume_error;
>   
> 
