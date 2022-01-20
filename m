Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7D1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 05:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4C910E896;
	Thu, 20 Jan 2022 05:49:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747E010E896
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 05:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irAMI7z87CHbXcjnHdN6Tsotm4tbNGTkUb6jqVOBmbqQ037ZVHctnACDyzeO74z+hsfeNqu4h74vEwFDARwnsP96RsOO5tkDJOpdjQnWFQX3nmAn26B4R+GsDiW4BSn03zBw/KJknK9jEE9D2/y00QxhK6bLda/sboVOb4tjMGnXfebHcDFnwCW0Jc9xS3Bq2zXIWAlKkXfurUUaeX6HcqMAD5IhXxLFmA+UoSYBELr++ebNRb2HN5STzfq6mGRdyrJCUdToRVSumNkhAZZNcO6ooi97q3d9aOhz+0McR8v6mH3IA5UeNXPtfkIsr556fwBS3jQPmM9l+HZ1koVOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnPvryNPIZeL7XpXK2ThdWk2m+t8zQYtMVNU4oBZYcY=;
 b=hIBp6HOG+BNbO1GN5L/LUu9v7yyazKifNTGO3IP+IK3jsMRHeEUjx5jVw6HqnWvun8X8L4FA5Qjyb7qWHqgWA2NmF7zco385NbYkQMoI53d0p4Xze/FV83ip+JqYZuiUlxdLhHa6Z59xM6maNwtUZl81dejBLG9JOuN6WqfWktz0qLj2kD4HAFfaC7QHjzD+NSN8gLxDcKK0OzDPgmvsrGthNxqvvPFP1Ekw8aATAwex302GHrex6uSyLswibyD6MB3VsIntSyEDAY2hHVaPre1aGBN7Xq7wHNMnlU6op+adb5IQVwxYaXpTZxKH9ZnuWzbfsyKtR5kk0n866PO6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnPvryNPIZeL7XpXK2ThdWk2m+t8zQYtMVNU4oBZYcY=;
 b=o3LSWGgsVoG5kF+QgKuN/iersFAjKUgfMI6JRD+CYmSxWpsE0y2ewCpOVXzMrv5rLxz0M9MEcjkPig07PVeBYTBggye+HV3c/BdWdMsd2ZxjcNErsCmF9EDGtvPZkofDzHjduWXNReNR4a28P57mlvMxEqKjVeSLx4g+y83DCvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (20.178.1.22) by
 SN6PR12MB4704.namprd12.prod.outlook.com (20.177.250.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Thu, 20 Jan 2022 05:49:36 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 05:49:35 +0000
Message-ID: <bed5d7a1-d7a1-5f4e-3c7c-b69a81d033c0@amd.com>
Date: Thu, 20 Jan 2022 11:19:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 1/2] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Content-Language: en-US
To: yipechai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220120031850.350206-1-YiPeng.Chai@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220120031850.350206-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74f1ab30-e023-40d1-25dc-08d9dbd8a382
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB47042481FC601278169F7385975A9@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAwlJrrg4JT/kiCItzR6f9ZWQoUy2/VAu2wxtZSkmWbbOqpN8CogJG0CUSfjL2Lo05l4HwL+ItX1dDul05whJYlnXq56H3rdX5Xa0y2n55DVz4zMrHbystw7PNtkEZBjk0maCncJw5dC/CHN1c5RwiYu1uvcRMR/bnYsnx/levFaFgiJlsXitX8HMa2rouuAJTg5suy+010vL+RLo/pMr+es0KBobj7QJC6gqDxcUfH+J9R6FbgSVOfLQQB8n0iu+bRjh2Aj9Le/F/aVCdWI/zlrVMc7dZqFwvwtO0un0H5s7rkwkghsTtEyJ2434g6ux/io77adtOmNBa7zjBtkAzd7WTRPs0nmyhfDv8RcwvQ+H+88pX4dUBHbeyP86lfzcBEp2k6mm30FlbXHwtLnG5XMFmJJXQSDs0H/u+J9VgVS7ZIBQNywFdqS7fffJidLN1VCnm1MG6Ff0aNyfjwufjpRY/UccXjKjXn/+W5/iZW5uVhbmGD1jFxgUDWSA1EGVdONvQ0jtVojFe/AY6y3wnkfEl8ok2BtjGG8bvbotjUAG0KDK40qcitfskUBUgN6yUn19Jzf2IMilRq92eVnJusKhg/Cd17e6I6mYblZOmu/qBqNkjetVo3+D3gAWoPIWBFv89pNTGqYraHXBIF8E1PoSpm0erax1/gu7rPZVk6/1U+MdDE8osg456lr2aoRh5KP27hnCa5LssX5slHcW0vZsypllYn7CyDoDCFoAHUyasss4N87jedTuW/6Q2oHTNBm+zYf/fBB/3anw3bNlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(2616005)(31696002)(6486002)(2906002)(6512007)(53546011)(5660300002)(6506007)(83380400001)(38100700002)(8936002)(31686004)(6666004)(86362001)(8676002)(26005)(4326008)(36756003)(66476007)(66556008)(66946007)(508600001)(186003)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2E0dlYwdWZ0eS9aL2UweEJHZGw4N2g3M1F5clMyTUswdnN6MHprMFBRVEgy?=
 =?utf-8?B?dG1xankyK2M5aUQ3aHdGK3ZCQlR1bG5vYjBlRGtwL3NQVnplSDdzQkQyckU1?=
 =?utf-8?B?VjBMU2RoekF2RE41c29UMVMzeklISDVsWFQ4MlV0SkZNb0FnWkRZdXRnak9w?=
 =?utf-8?B?WlE4T00xS0FxM3hzeHNSV0hOR3Z6aEdHWUR4MU1tNWFlTUVJWStTM2NOcENK?=
 =?utf-8?B?ZXo1VWNxY1lXS0ZnNGp1VlRGclMvZ3I0Y0ZFdGprbnova2NUbWpSaUxvQTJx?=
 =?utf-8?B?NjBBU2lXVlEwNXM4V0hPcCs2Wk1xTklzWlNlcDI1Sml6QXdHQ3VzQzhWOUN2?=
 =?utf-8?B?VE10NUlQQjdyMzQvcXRZUXdmTWVmMkJnVDBidE9mZEV1d1U2VWlLY1lycnpm?=
 =?utf-8?B?TlhGNmpnNGtrcHQ1R3FZeWZQeXRNU1g5d05DbkNqaDhkbzhLbk1qQ1MwSHIw?=
 =?utf-8?B?SENhb2NKYitBSDVqb0FQTmpUeHZUMThxMzZFdEF4UnYyaElNMDh1Zk83MVha?=
 =?utf-8?B?VXVncStteG5acThxRE9laktySmMxVEFsTjFvM1ZaaWlKcUNSbnkxYmM1enZ3?=
 =?utf-8?B?N0txUThBNWU3YUtIRkFMSWNWSGxUa0MwNC82ZE5ORitlb0FCZlJZY2ZPeHVI?=
 =?utf-8?B?dVVKbVZLZlRUcFZ6ZUw1c0MzUHQ0bDFxcll0WCtvbE1ISjVPb05hLzVoTk9k?=
 =?utf-8?B?VlhER1NGcWhRVXBNdTJURTY3UUpKN2xnaGV3em9qSk1xTTBtRnVHa0FQQXlB?=
 =?utf-8?B?QllBZG5RRVNMUkwyNnBTR1lkY1djY0hIRTMrM2tCQzhCdEtSaGsxS2RKcXZZ?=
 =?utf-8?B?MVhTS1NXSkFsVkFlOGtEZFFEVDZMOXNucnZwQUpDYi9idUlhRDlpbGlVTnV0?=
 =?utf-8?B?eHIyeXFVRmFVTUMyZzlOT20xZGY4cldkdkpJOVRoNXd2K3hKTE1BUTN5Y2tY?=
 =?utf-8?B?QWRHMUR3MG9PQzdsYjU0V3VQWXMyWTJ6SXhENVpVc0wwUGtra3FNcjdEVjQ2?=
 =?utf-8?B?VjBES1UvRTkyTm1aY0Z3dFNTZGE0Q2kxTUhsN00vcW5uUDVOTWZQZnRPRjdQ?=
 =?utf-8?B?bDFIUzk1eGpMRFlUNkRYV21GbFBQNmlvSHhKOC9rMkRFNmxxczNxOWN0Nzlk?=
 =?utf-8?B?UHNWWnAyOHZGVGlZcnR3cTJLUVcyN3MzbklXVVgrbitpWHYxM0xtM0EvL21t?=
 =?utf-8?B?dk16WHQrTE13WlEwbkE1RExjUjZkTTduUy9ja00zcTNNaTg2R2FjMElpc1dr?=
 =?utf-8?B?aWRUTm5BS2RlQnIrSGFKL1VEZDVSUE13bnJzMVhaNjFWNmVGcTVVRWxRYnhK?=
 =?utf-8?B?dUxoS09yUlQ2Ky9lNE0zdC9QMDhBNkZYMmdUN2x6cDAwMGw0VFBHQTZpZWZI?=
 =?utf-8?B?eFhHS0xVVUR2N3JWNFk2VGhackMzdGxFTDRub3NrYklrMVRmVDJUY01Wd2dS?=
 =?utf-8?B?UnBsOXFGbVNKYkVQNzZBOTAwRnJvQXRQSmNDR2p3Vi9qbUlRb3lNQkU2SlRz?=
 =?utf-8?B?MHFMdzUrSVpKZXF0QnQ3QVJtWjNhdGU3OW51S2t6NDg5YVR3Vi83M1lTaHVh?=
 =?utf-8?B?cHdkOEJWYVZKV251cDFNcnA2bm9aRXU1cUpFbFRKOXZmWDdrZXY5dDdDQVRE?=
 =?utf-8?B?c0hySnhsOGpKNGNCbU43VW45OER2UUxrUkRaOHBJdnpxVHB3VEd6S205aFdN?=
 =?utf-8?B?UjFSMzAwOFJ5TW41aUVrZkp4LzEvM0pTSHZMaUg5SmgxbFR6UEVRV2s2blRS?=
 =?utf-8?B?OGc0RHQ1KzFFZDlJRk42eXE3NDlEZHc4MnN6SnkzdHY2SVN3K1VVeDYyR1V3?=
 =?utf-8?B?Y2pFZ1F1cS9KR2NuY3YralI0QmcxNmxZYkd1RGV0QzgrWEx6RWxmVWsrbCtM?=
 =?utf-8?B?ZXp4R04zTVNzSXRRRHNoS1VUQUQ2SUt4ZUlEajBnYkxCbmFBVjdOYy9obTE0?=
 =?utf-8?B?T2VHb2I2bllRM1FUL0NmNUk3OWh2MmY2alZZL051RFFSTjVVTzNDYjdoVkg2?=
 =?utf-8?B?M01qc1pBZ3NiWTZMRE1hWHlFWmExYW9yejZ6MG1kbHpDaSt3UGU3UjNpaG5H?=
 =?utf-8?B?M0dwZDI5Z2xZeGI5aHJKRmg1bkI3emh4RHlnS09uSlNTY0l4RDZ5a1RpSnZG?=
 =?utf-8?Q?adpQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f1ab30-e023-40d1-25dc-08d9dbd8a382
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 05:49:35.6644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWju57Z36EcgLKVwp9OHLISC32oU+RcyabH1tkowlDMFczf3eFyYw95zki85t5zT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: yipechai@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/20/2022 8:48 AM, yipechai wrote:
> Move xgmi ras initialization from .late_init to .early_init, which let
> xgmi ras can be initialized only once.
> 
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 ++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  5 +++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  5 +++++
>   4 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 3483a82f5734..788c0257832d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -436,6 +436,16 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
>   	} while (fault->timestamp < tmp);
>   }
>   
> +int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev)
> +{
> +	if (!adev->gmc.xgmi.connected_to_cpu) {
> +		adev->gmc.xgmi.ras = &xgmi_ras;
> +		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
> +	}
> +
> +	return 0;
> +}
> +
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
>   {
>   	int r;
> @@ -452,11 +462,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> -	if (!adev->gmc.xgmi.connected_to_cpu) {
> -		adev->gmc.xgmi.ras = &xgmi_ras;
> -		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
> -	}
> -
>   	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init) {
>   		r = adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, NULL);
>   		if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 0001631cfedb..ac4c0e50b45c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -318,6 +318,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
>   			      uint16_t pasid, uint64_t timestamp);
>   void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
>   				     uint16_t pasid);
> +int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev);
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
>   void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
>   int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 4f8d356f8432..7a6ad5d467b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -719,6 +719,7 @@ static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
>   
>   static int gmc_v10_0_early_init(void *handle)
>   {
> +	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	gmc_v10_0_set_mmhub_funcs(adev);
> @@ -734,6 +735,10 @@ static int gmc_v10_0_early_init(void *handle)
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>   
> +	r = amdgpu_gmc_ras_early_init(adev);
> +	if (r)
> +		return r;
> +

At this point it's unknown if RAS is applicable for the SKU. I think 
this failure check shouldn't be there (here and below one).

amdgpu_gmc_ras_early_init is return 0 always, that way also this check 
is not needed.

Thanks,
Lijo

>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index c76ffd1a70cd..3cdd3d459d51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1318,6 +1318,7 @@ static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
>   
>   static int gmc_v9_0_early_init(void *handle)
>   {
> +	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	/* ARCT and VEGA20 don't have XGMI defined in their IP discovery tables */
> @@ -1347,6 +1348,10 @@ static int gmc_v9_0_early_init(void *handle)
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>   
> +	r = amdgpu_gmc_ras_early_init(adev);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> 
