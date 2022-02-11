Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056BEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 13:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AFE810EB90;
	Fri, 11 Feb 2022 13:21:54 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 883CF10EB90
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 13:21:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DItYKSC8bXJ1gPplDhK09N1OB2HHcRjHHYJdrl/fSGluM5CPqp4tr+e8xcBi+R4TXhwDwE9MNzblgIJIlXBzP5lhIRg0b2/4rhrquT45FnAh6OlTi0A2QL3kVZZ3+gGuS0lxlPG0wHPzFS9aaOy5ouDFINNPAiSG72w0BzkRju+QCAKnarTOn3ftxR28lT8tbd7tZoOIetFgsaEmzlAur1SAPwl47CKv9eNQwPpLnYWez/qTGS99XGqYFYvpFEOcPNB7aFDxqGevFSQdckYt8AX/YuXXKYomB8Obp97zENTHR7rvG+lKdc5Fc7nQ8G30ZwVecSSkY0ebTutJYF9IWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WF1Ap/Wn6Fu5emkpI7ZNV4gpk9FQeg92AC7aBqh4md8=;
 b=WCDuHl/Ws+Is/N29WHT5bzIqDPCcZ6CGCmA+Xfh6K6CwiYyGcx79Jj1BpHsWXpFDd+id3KvtygMBgR6aZiksXRzviTP17YmCtsNLbEiwMa5bOp3VFFR/1zKj/Nr77PsjGx4Ffcm9dkS+LtF454jGNDany84MNtP6E813CLBxSsgB8nwVCHXN9cO+TZ4SxYSQCMort6rqQn39g5b5NdELC2WM6Gh63xBY5L7FHk03pdNcRsKb7xLSsszyqtwF5o5n5b+wcYk9Qjf/nYLSJ/f9k6TnzJL0dFxlirJgWAvfhrPUxnBfAyuq70LNW9wTIG1Y8rGP+43kmB3z9pUwBDrhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF1Ap/Wn6Fu5emkpI7ZNV4gpk9FQeg92AC7aBqh4md8=;
 b=LIMd8Sdbjnk6Fa6m65e5xpCFqlbnorG1RR2EEHX5m/a2i1T6/LBVp41mzVpMCEa/zg4F1rLIEf2W/y5YRYTXcge5UkK3BKwLXYfoGiKtcZ1AkYdZXct+vP7fJS9ez1dqFl/q6q2v/pI36jqVpkYZZAtknMuRcB/o5i/24ZvJEMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN6PR12MB1940.namprd12.prod.outlook.com (2603:10b6:404:fd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 13:21:50 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d0d1:eba5:5729:c636]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d0d1:eba5:5729:c636%5]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 13:21:49 +0000
Message-ID: <f1cbb596-e813-f2dc-f95c-ceadb0f1c557@amd.com>
Date: Fri, 11 Feb 2022 18:51:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 12/12] drm/amd/pm: revise the implementations for asic
 reset
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220211075209.894833-1-evan.quan@amd.com>
 <20220211075209.894833-12-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220211075209.894833-12-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::27) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1843bfa-49e1-4187-255b-08d9ed6175a3
X-MS-TrafficTypeDiagnostic: BN6PR12MB1940:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1940FA4C726F411A52D3DC2797309@BN6PR12MB1940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNY5AX/7KsYduieqbaXYmm7eUFqwsYnyvThBxPHPVvC3l8FN52flrdfHgN2agZOJaWb5pKkrcCyXYjvVU/g2nv1rBYIxa+MB36JiKsDfEQKHt9n49R7IukgplBNUI/Iy3UsHr3HGuOFP5BmnUrXLkzxV8Hpytjg3lVi4QVCajcLgCyJJVPrznvDz/gmYEabv/lX25fgEyDTlKkKHwUfkCFgX1jA3LE7iqUWATyddWChhFtY60kQogme1JmyL8Op8kqoxT3+roNdJkVkL7XbWLyaFeHUgjS3aYSfJZdQxjxXSMK8v0cJfZUrkxRdYPBsdcL0gFS8aioT+07W697t64w7oMsb5c/aIkIjW/SUIeco3e+TcmdCKAu6hIQ2COtW2ScYqVuTdD1fyg1MkyoKfTijh9qX95eqPW+S/Wp/BeGMaEzJxERZECRSJ9bTQqIy/3uU3iX+wOxhI2ErOQiaW3PA7F9LZTblYHlSuAGvcDY5iUPC3oiWH8kpdIFnxUNZz9ktlXuyxvuf3PL2FvXvvU2imXcTbnDyQpcsSJ/NjkadLOMbosQPiMh16icRLtQGyMxnN3IQSPAkA5Vk4xwi++pns1wk5DVa3yNMA0B9z17O1qFiWP/AgJybrFhIScnCSHrU8ZMtI/3hzVaSC/+NhAr2r5srZzULxXYiVX8CDRKO6wanlHRnjWi2h7qoxCT87oHWcxev8Q1blfC5rGAJK8s9nb0AZl3IRPphzp9JoaCYyRxJ/yO+8e6vaENhglhuw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(8676002)(53546011)(6506007)(2906002)(316002)(4326008)(38100700002)(66476007)(66946007)(66556008)(508600001)(86362001)(6486002)(5660300002)(31696002)(30864003)(83380400001)(36756003)(2616005)(31686004)(186003)(26005)(8936002)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNna0JrdkJ4d1hHVGRKSHVkWVp4SzczYVFNOG8vZ2pOVTQraDYrRjhURWNY?=
 =?utf-8?B?Zzk3VStsbFI0bFJYMkhjVW54YVpkRzNJTVdLbHJvVCsrRm5COU8zS2tNMXJa?=
 =?utf-8?B?MXlrVW1jVlFSb2VGOHVESDRYR3dHdDB1aEZTOGxJTnRBSC9GcFcwejVSb2FS?=
 =?utf-8?B?RDZRNDZhczkrZ1JCWXZ2VHp0dEEwOTJnSlhZQ0dqSUZGYllQSFdMcUtOcXRm?=
 =?utf-8?B?VFF6WWs1czBpWkVDSUNIWGR1TnNqbTJTcGZMNXNtS0dJejU0cHMzKzZpcnM1?=
 =?utf-8?B?ZWtPT1hCL0Fnd0pkOGIwb3ZPWFNaQ1FZY203VnFHZTFjYWVWQklzelE3QVMr?=
 =?utf-8?B?Q1BEbUkzdHVncWd4T09mR0VQTUtWenFTa0RjQXV4aFhYKzl6STBjT1VQM1B2?=
 =?utf-8?B?YUIra0tDVk5zUzAwNWFQeXA5elp0WlhudStFVC8yWVlJd2x0MFJPclBhWk9x?=
 =?utf-8?B?dUI2UGtQYWpxaGdXR2xSdG9yL21LLzFvU0t2T09FOWJUWWJMQzR6TjUvNnhW?=
 =?utf-8?B?ajk5ZzMySnEvcnN5dVlCSkcxb293Y3V0VnVtaitIdVJ3YmcxbHhLVXRTc2xC?=
 =?utf-8?B?dEIwZEJxSW9Uamd5TkFKSkxpNDZRVnlDRURUNy9hSGtqL3Z0SEZtWGQ5NzVR?=
 =?utf-8?B?UXhyNjhiVW5Xa2paSGFBdE5uMGNkUmZVZGkzRkp0S0NzNXhFNk9jWVdQaXZG?=
 =?utf-8?B?WndtSmRDc3dMTmVmS3NEQ21FMTBZUWxIelJqRWFYQWQ1UHJZZVg0a1dBUGhx?=
 =?utf-8?B?NFdpck92Y25LYUhnNzY3MzhaWDBCK0Q1K0s0OXI3b2FzKzgxc1RMeTFqUGFC?=
 =?utf-8?B?eVlJQzJnVWVkUG5CTzlvRE1wbGZoU3dHRDRHUk1tQzFTWmsrYndHSjJTWW4r?=
 =?utf-8?B?RW9ZV1ZmWkQ0L2h2bFhhL1dydXh5emZ3UHRsZlA3cjhYNlljSEpoWUZnY3d1?=
 =?utf-8?B?WlF1THFCY3phdjErcGhYb21WSXUvL3dnaGpGVENxYkZSc0RTZ3FrYnk2RlVr?=
 =?utf-8?B?NVlsV2FrVXZ6aDI1eVhudk9YeVBkV05nOTFpQUR3YnhnU3hqa2hzSmMva1la?=
 =?utf-8?B?YW5Qd2lodWJjZytLSVltUjI2K0tlVWttbmdXRUNSTC80UUt5TlhWRER2cElz?=
 =?utf-8?B?Q3N3eUNGZUFTY085R3pEUWRwNU5rYWl1cnNoYXFmUU1OV0dtYlg0d0dUNENC?=
 =?utf-8?B?Z0RtbWFWZ0FpamRLRXdqejJYVnR3cUFjdktkRWJkODVQSWE3QTVRSE5RbmNp?=
 =?utf-8?B?MEVNSy9FNUkxdDhZSzJ5TFcvcy9qWCsxaWQ3VDhBRmNxeDhSdGxOOURkYnhr?=
 =?utf-8?B?TzdWM0E1dmZYbENTNlBkV05zYUNzdVdmV2dJK2l3Q1lYQS9DZGpjTmFJVDdo?=
 =?utf-8?B?M1lFeW1jTkdScUhpNVc1Rnkyd0ZiUldTUmNIU1ZXMW9XVzkvakt6QjVMT0x6?=
 =?utf-8?B?aVJacVZJUGJKMjJHMitZQWhWMmdsdjhobFpQaDBMU1ZSUk9RQ0J5NlJMZWJt?=
 =?utf-8?B?aEhSZGZMUlFhK2NROXErVGZlVHBKTVgvM29BMk5vSTIzdDV1b3cxdVdNNTBi?=
 =?utf-8?B?VlE5cXZPazA1NFRoek55Z0MzalRqMEp6NURYakVYZnByWkZ6UkU5bVQxaDM4?=
 =?utf-8?B?S2JTZmJJUndyRzhrbXptcmhKbmdEVGR4clFUbGowWVFqdUordTFLY2Q1Ujln?=
 =?utf-8?B?UHNUMGs1RUdPcGhRakFOWHdWSi9zUldjWFEvZFcwREkrQ2hLNVpNdHhZZHJn?=
 =?utf-8?B?NnRneWtNUUNJMFBaU01qQ1dhNENmM2pKSUY1d09lYkhuaTZnRVp0c2Nqbktk?=
 =?utf-8?B?bXk3b21GVmJMMjN0Q1dCU3BNb3ltYys2VmdtNlp6NkI3N3pVd1RwZHk2bGR1?=
 =?utf-8?B?VVlxSDd5MlZ3M2FSSmxrN2l2TCthZEVWQUlBQUhlYmh1d1VVK3NIYmh6NjZG?=
 =?utf-8?B?SzZOcjlzNCt3cjRtZDBHc3FEaE5pTFpmc3pBS0lGL3RHRmt2cVFvaTNkaWhD?=
 =?utf-8?B?WUx6N092dE43cGIyUTJqTFEwSXhybnBIa0JFSUVVVVg0MktYYkFtNVdZQ1pZ?=
 =?utf-8?B?MC9iSHJGTSs0TnpWRVgvemlRNGloVjJvb1NUZHQ3eEFMNmtpY3l6OUkwQ3Ru?=
 =?utf-8?Q?hynw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1843bfa-49e1-4187-255b-08d9ed6175a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 13:21:49.6809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7xV9mRRimyMEEVwtDaUfWcCaAvHKKU5/E9I4EWfsuPfOorLmXywfJPlo+YUwkOz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1940
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
Cc: Alexander.Deucher@amd.com, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/11/2022 1:22 PM, Evan Quan wrote:
> Instead of having an interface for every reset method, we replace them
> with a new interface which can support all reset methods.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I4c8a7121dd65c2671085673dd7c13cf7e4286f3d
> ---
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +-
>   drivers/gpu/drm/amd/amdgpu/cik.c              |   4 +-
>   drivers/gpu/drm/amd/amdgpu/nv.c               |  13 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.c            |  12 +-
>   drivers/gpu/drm/amd/amdgpu/vi.c               |   6 +-
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |   7 +-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  89 ++-----------
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  13 +-
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  86 ++++++++----
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 126 +++++++++++-------
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   3 -
>   12 files changed, 180 insertions(+), 185 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index a545df4efce1..22b787de313a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -128,7 +128,7 @@ static int aldebaran_mode2_reset(struct amdgpu_device *adev)
>   {
>   	/* disable BM */
>   	pci_clear_master(adev->pdev);
> -	adev->asic_reset_res = amdgpu_dpm_mode2_reset(adev);
> +	adev->asic_reset_res = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_MODE2);
>   	return adev->asic_reset_res;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7931132ce6e3..b19bfdf81500 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4504,9 +4504,9 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>   
>           amdgpu_device_cache_pci_state(adev->pdev);
>   
> -        if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
> +        if (amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_MODE1)) {
>                   dev_info(adev->dev, "GPU smu mode1 reset\n");
> -                ret = amdgpu_dpm_mode1_reset(adev);
> +                ret = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_MODE1);
>           } else {
>                   dev_info(adev->dev, "GPU psp mode1 reset\n");
>                   ret = psp_gpu_reset(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index f10ce740a29c..786975716eb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1380,7 +1380,7 @@ static bool cik_asic_supports_baco(struct amdgpu_device *adev)
>   	switch (adev->asic_type) {
>   	case CHIP_BONAIRE:
>   	case CHIP_HAWAII:
> -		return amdgpu_dpm_is_baco_supported(adev);
> +		return amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
>   	default:
>   		return false;
>   	}
> @@ -1434,7 +1434,7 @@ static int cik_asic_reset(struct amdgpu_device *adev)
>   
>   	if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
>   		dev_info(adev->dev, "BACO reset\n");
> -		r = amdgpu_dpm_baco_reset(adev);
> +		r = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_BACO);
>   	} else {
>   		dev_info(adev->dev, "PCI CONFIG reset\n");
>   		r = cik_asic_pci_config_reset(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 494e17f65fc3..2e590008d3ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -414,7 +414,7 @@ static int nv_asic_mode2_reset(struct amdgpu_device *adev)
>   
>   	amdgpu_device_cache_pci_state(adev->pdev);
>   
> -	ret = amdgpu_dpm_mode2_reset(adev);
> +	ret = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_MODE2);
>   	if (ret)
>   		dev_err(adev->dev, "GPU mode2 reset failed\n");
>   
> @@ -458,7 +458,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 13):
>   		return AMD_RESET_METHOD_MODE1;
>   	default:
> -		if (amdgpu_dpm_is_baco_supported(adev))
> +		if (amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO))
>   			return AMD_RESET_METHOD_BACO;
>   		else
>   			return AMD_RESET_METHOD_MODE1;
> @@ -476,7 +476,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
>   		break;
>   	case AMD_RESET_METHOD_BACO:
>   		dev_info(adev->dev, "BACO reset\n");
> -		ret = amdgpu_dpm_baco_reset(adev);
> +		ret = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_BACO);
>   		break;
>   	case AMD_RESET_METHOD_MODE2:
>   		dev_info(adev->dev, "MODE2 reset\n");
> @@ -641,6 +641,11 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static bool nv_asic_supports_baco(struct amdgpu_device *adev)
> +{
> +	return amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
> +}
> +
>   static const struct amdgpu_asic_funcs nv_asic_funcs =
>   {
>   	.read_disabled_bios = &nv_read_disabled_bios,
> @@ -657,7 +662,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
>   	.need_full_reset = &nv_need_full_reset,
>   	.need_reset_on_init = &nv_need_reset_on_init,
>   	.get_pcie_replay_count = &nv_get_pcie_replay_count,
> -	.supports_baco = &amdgpu_dpm_is_baco_supported,
> +	.supports_baco = &nv_asic_supports_baco,
>   	.pre_asic_init = &nv_pre_asic_init,
>   	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
>   	.query_video_codecs = &nv_query_video_codecs,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index a216e625c89c..15ee56406bc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -508,7 +508,7 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
>   	if (ras && adev->ras_enabled)
>   		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
>   
> -	ret = amdgpu_dpm_baco_reset(adev);
> +	ret = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_BACO);
>   	if (ret)
>   		return ret;
>   
> @@ -553,7 +553,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 2):
>   		if (adev->asic_type == CHIP_VEGA20) {
>   			if (adev->psp.sos.fw_version >= 0x80067)
> -				baco_reset = amdgpu_dpm_is_baco_supported(adev);
> +				baco_reset = amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
>   			/*
>   			 * 1. PMFW version > 0x284300: all cases use baco
>   			 * 2. PMFW version <= 0x284300: only sGPU w/o RAS use baco
> @@ -562,7 +562,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>   			    adev->pm.fw_version <= 0x283400)
>   				baco_reset = false;
>   		} else {
> -			baco_reset = amdgpu_dpm_is_baco_supported(adev);
> +			baco_reset = amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
>   		}
>   		break;
>   	case IP_VERSION(13, 0, 2):
> @@ -599,7 +599,7 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
>   		return soc15_asic_baco_reset(adev);
>   	case AMD_RESET_METHOD_MODE2:
>   		dev_info(adev->dev, "MODE2 reset\n");
> -		return amdgpu_dpm_mode2_reset(adev);
> +		return amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_MODE2);
>   	default:
>   		dev_info(adev->dev, "MODE1 reset\n");
>   		return amdgpu_device_mode1_reset(adev);
> @@ -613,10 +613,10 @@ static bool soc15_supports_baco(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 2):
>   		if (adev->asic_type == CHIP_VEGA20) {
>   			if (adev->psp.sos.fw_version >= 0x80067)
> -				return amdgpu_dpm_is_baco_supported(adev);
> +				return amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
>   			return false;
>   		} else {
> -			return amdgpu_dpm_is_baco_supported(adev);
> +			return amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
>   		}
>   		break;
>   	default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 6645ebbd2696..de510de5e62a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -904,7 +904,7 @@ static bool vi_asic_supports_baco(struct amdgpu_device *adev)
>   	case CHIP_POLARIS11:
>   	case CHIP_POLARIS12:
>   	case CHIP_TOPAZ:
> -		return amdgpu_dpm_is_baco_supported(adev);
> +		return amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
>   	default:
>   		return false;
>   	}
> @@ -930,7 +930,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)
>   	case CHIP_POLARIS11:
>   	case CHIP_POLARIS12:
>   	case CHIP_TOPAZ:
> -		baco_reset = amdgpu_dpm_is_baco_supported(adev);
> +		baco_reset = amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
>   		break;
>   	default:
>   		baco_reset = false;
> @@ -962,7 +962,7 @@ static int vi_asic_reset(struct amdgpu_device *adev)
>   
>   	if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
>   		dev_info(adev->dev, "BACO reset\n");
> -		r = amdgpu_dpm_baco_reset(adev);
> +		r = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_BACO);
>   	} else {
>   		dev_info(adev->dev, "PCI CONFIG reset\n");
>   		r = vi_asic_pci_config_reset(adev);
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 892648a4a353..8d9c32e70532 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -300,6 +300,7 @@ struct amd_pp_clocks;
>   struct pp_smu_wm_range_sets;
>   struct pp_smu_nv_clock_table;
>   struct dpm_clocks;
> +enum amd_reset_method;
>   
>   struct amd_pm_funcs {
>   /* export for dpm on ci and si */
> @@ -387,12 +388,10 @@ struct amd_pm_funcs {
>   	int (*set_hard_min_dcefclk_by_freq)(void *handle, uint32_t clock);
>   	int (*set_hard_min_fclk_by_freq)(void *handle, uint32_t clock);
>   	int (*set_min_deep_sleep_dcefclk)(void *handle, uint32_t clock);
> -	int (*get_asic_baco_capability)(void *handle, bool *cap);
>   	int (*get_asic_baco_state)(void *handle, int *state);
>   	int (*set_asic_baco_state)(void *handle, int state);
>   	int (*get_ppfeature_status)(void *handle, char *buf);
>   	int (*set_ppfeature_status)(void *handle, uint64_t ppfeature_masks);
> -	int (*asic_reset_mode_2)(void *handle);
>   	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
>   	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
>   	ssize_t (*get_gpu_metrics)(void *handle, void **table);
> @@ -410,6 +409,10 @@ struct amd_pm_funcs {
>   	int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *size);
>   	void (*pm_compute_clocks)(void *handle);
>   	bool (*is_smc_alive)(void *handle);
> +	int (*is_asic_reset_supported)(void *handle,
> +				       enum amd_reset_method reset_method);
> +	int (*asic_reset)(void *handle,
> +			  enum amd_reset_method reset_method);
>   };
>   
>   struct metrics_table_header {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index f237dd3a3f66..b72945f6a338 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -196,107 +196,42 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>   	return ret;
>   }
>   
> -bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
> +int amdgpu_dpm_is_asic_reset_supported(struct amdgpu_device *adev,
> +				       enum amd_reset_method reset_method)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	bool baco_cap;
> -	int ret = 0;
> +	int reset_supported = false;
>   
>   	if (!amdgpu_dpm_is_smc_alive(adev))
>   		return false;
>   
> -	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
> +	if (!pp_funcs || !pp_funcs->is_asic_reset_supported)
>   		return false;
>   
>   	mutex_lock(&adev->pm.mutex);
> -
> -	ret = pp_funcs->get_asic_baco_capability(pp_handle,
> -						 &baco_cap);
> -
> +	reset_supported = pp_funcs->is_asic_reset_supported(adev->powerplay.pp_handle,
> +							    reset_method);
>   	mutex_unlock(&adev->pm.mutex);
>   
> -	return ret ? false : baco_cap;
> +	return reset_supported;
>   }
>   
> -int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
> +int amdgpu_dpm_asic_reset(struct amdgpu_device *adev,
> +			  enum amd_reset_method reset_method)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	void *pp_handle = adev->powerplay.pp_handle;
>   	int ret = 0;
>   
>   	if (!amdgpu_dpm_is_smc_alive(adev))
>   		return -EOPNOTSUPP;
>   
> -	if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
> -		return -ENOENT;
> -
> -	mutex_lock(&adev->pm.mutex);
> -
> -	ret = pp_funcs->asic_reset_mode_2(pp_handle);
> -
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> -}
> -
> -int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
> -{
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	void *pp_handle = adev->powerplay.pp_handle;
> -	int ret = 0;
> -
> -	if (!amdgpu_dpm_is_smc_alive(adev))
> +	if (!pp_funcs || !pp_funcs->asic_reset)
>   		return -EOPNOTSUPP;
>   
> -	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
> -		return -ENOENT;
> -
>   	mutex_lock(&adev->pm.mutex);
> -
> -	/* enter BACO state */
> -	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
> -	if (ret)
> -		goto out;
> -
> -	/* exit BACO state */
> -	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
> -
> -out:
> +	ret = pp_funcs->asic_reset(adev->powerplay.pp_handle,
> +				   reset_method);
>   	mutex_unlock(&adev->pm.mutex);
> -	return ret;
> -}
> -
> -bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
> -{
> -	struct smu_context *smu = adev->powerplay.pp_handle;
> -	bool support_mode1_reset = false;
> -
> -	if (!amdgpu_dpm_is_smc_alive(adev))
> -		return false;
> -
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		support_mode1_reset = smu_mode1_reset_is_support(smu);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> -
> -	return support_mode1_reset;
> -}
> -
> -int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
> -{
> -	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = -EOPNOTSUPP;
> -
> -	if (!amdgpu_dpm_is_smc_alive(adev))
> -		return -EOPNOTSUPP;
> -
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = smu_mode1_reset(smu);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 49488aebd350..bda8b8149497 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -374,15 +374,6 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
>   				    enum PP_SMC_POWER_PROFILE type,
>   				    bool en);
>   
> -int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
> -
> -int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
> -
> -bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
> -
> -bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev);
> -int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
> -
>   int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>   			     enum pp_mp1_state mp1_state);
>   
> @@ -542,4 +533,8 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
>   						  unsigned int *num_states);
>   int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>   				   struct dpm_clocks *clock_table);
> +int amdgpu_dpm_is_asic_reset_supported(struct amdgpu_device *adev,
> +				       enum amd_reset_method reset_method);
> +int amdgpu_dpm_asic_reset(struct amdgpu_device *adev,
> +			  enum amd_reset_method reset_method);
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 81ec5464b679..3edc05296e01 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1177,20 +1177,6 @@ static int pp_set_active_display_count(void *handle, uint32_t count)
>   	return phm_set_active_display_count(hwmgr, count);
>   }
>   
> -static int pp_get_asic_baco_capability(void *handle, bool *cap)
> -{
> -	struct pp_hwmgr *hwmgr = handle;
> -
> -	*cap = false;
> -
> -	if (!hwmgr->hwmgr_func->get_asic_baco_capability)
> -		return 0;
> -
> -	hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
> -
> -	return 0;
> -}
> -
>   static int pp_get_asic_baco_state(void *handle, int *state)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
> @@ -1242,18 +1228,6 @@ static int pp_set_ppfeature_status(void *handle, uint64_t ppfeature_masks)
>   	return hwmgr->hwmgr_func->set_ppfeature_status(hwmgr, ppfeature_masks);
>   }
>   
> -static int pp_asic_reset_mode_2(void *handle)
> -{
> -	struct pp_hwmgr *hwmgr = handle;
> -
> -	if (hwmgr->hwmgr_func->asic_reset == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return -EINVAL;
> -	}
> -
> -	return hwmgr->hwmgr_func->asic_reset(hwmgr, SMU_ASIC_RESET_MODE_2);
> -}
> -
>   static int pp_smu_i2c_bus_access(void *handle, bool acquire)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
> @@ -1394,6 +1368,62 @@ static bool pp_is_smc_alive(void *handle)
>   	return false;
>   }
>   
> +static int pp_is_asic_reset_supported(void *handle,
> +				       enum amd_reset_method reset_method)
> +{
> +	struct pp_hwmgr *hwmgr = handle;
> +	bool reset_supported = false;
> +
> +	switch (reset_method) {
> +	case AMD_RESET_METHOD_BACO:
> +		if (hwmgr->hwmgr_func->get_asic_baco_capability)
> +			hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr,
> +								    &reset_supported);
> +		break;
> +	case AMD_RESET_METHOD_MODE1:
> +	case AMD_RESET_METHOD_MODE2:
> +	default:
> +		break;
> +	}
> +
> +	return reset_supported;
> +}
> +
> +static int pp_asic_reset(void *handle,
> +			 enum amd_reset_method reset_method)
> +{
> +	struct pp_hwmgr *hwmgr = handle;
> +	int ret = 0;
> +
> +	switch (reset_method) {
> +	case AMD_RESET_METHOD_MODE1:
> +		return -EOPNOTSUPP;
> +	case AMD_RESET_METHOD_MODE2:
> +		if (!hwmgr->hwmgr_func->asic_reset)
> +			return -EOPNOTSUPP;
> +
> +		ret = hwmgr->hwmgr_func->asic_reset(hwmgr,
> +						    SMU_ASIC_RESET_MODE_2);
> +		break;
> +	case AMD_RESET_METHOD_BACO:
> +		if (!hwmgr->hwmgr_func->set_asic_baco_state)
> +			return -EOPNOTSUPP;
> +
> +		ret = hwmgr->hwmgr_func->set_asic_baco_state(hwmgr,
> +							     BACO_STATE_IN);
> +		if (ret)
> +			return ret;
> +
> +		ret = hwmgr->hwmgr_func->set_asic_baco_state(hwmgr,
> +							     BACO_STATE_OUT);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>   static const struct amd_pm_funcs pp_dpm_funcs = {
>   	.load_firmware = pp_dpm_load_fw,
>   	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
> @@ -1446,12 +1476,10 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
>   	.set_min_deep_sleep_dcefclk = pp_set_min_deep_sleep_dcefclk,
>   	.set_hard_min_dcefclk_by_freq = pp_set_hard_min_dcefclk_by_freq,
>   	.set_hard_min_fclk_by_freq = pp_set_hard_min_fclk_by_freq,
> -	.get_asic_baco_capability = pp_get_asic_baco_capability,
>   	.get_asic_baco_state = pp_get_asic_baco_state,
>   	.set_asic_baco_state = pp_set_asic_baco_state,
>   	.get_ppfeature_status = pp_get_ppfeature_status,
>   	.set_ppfeature_status = pp_set_ppfeature_status,
> -	.asic_reset_mode_2 = pp_asic_reset_mode_2,
>   	.smu_i2c_bus_access = pp_smu_i2c_bus_access,
>   	.set_df_cstate = pp_set_df_cstate,
>   	.set_xgmi_pstate = pp_set_xgmi_pstate,
> @@ -1460,4 +1488,6 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
>   	.get_smu_prv_buf_details = pp_get_prv_buffer_details,
>   	.pm_compute_clocks = pp_pm_compute_clocks,
>   	.is_smc_alive = pp_is_smc_alive,
> +	.is_asic_reset_supported = pp_is_asic_reset_supported,
> +	.asic_reset = pp_asic_reset,
>   };
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 3773e95a18bf..bab5ddc667f9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2503,18 +2503,6 @@ static int smu_set_xgmi_pstate(void *handle,
>   	return ret;
>   }
>   
> -static int smu_get_baco_capability(void *handle, bool *cap)
> -{
> -	struct smu_context *smu = handle;
> -
> -	*cap = false;
> -
> -	if (smu->ppt_funcs->baco_is_support)
> -		*cap = smu->ppt_funcs->baco_is_support(smu);
> -
> -	return 0;
> -}
> -
>   static int smu_baco_set_state(void *handle, int state)
>   {
>   	struct smu_context *smu = handle;
> @@ -2537,40 +2525,6 @@ static int smu_baco_set_state(void *handle, int state)
>   	return ret;
>   }
>   
> -bool smu_mode1_reset_is_support(struct smu_context *smu)
> -{
> -	bool ret = false;
> -
> -	if (smu->ppt_funcs->mode1_reset_is_support)
> -		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
> -
> -	return ret;
> -}
> -
> -int smu_mode1_reset(struct smu_context *smu)
> -{
> -	int ret = 0;
> -
> -	if (smu->ppt_funcs->mode1_reset)
> -		ret = smu->ppt_funcs->mode1_reset(smu);
> -
> -	return ret;
> -}
> -
> -static int smu_mode2_reset(void *handle)
> -{
> -	struct smu_context *smu = handle;
> -	int ret = 0;
> -
> -	if (smu->ppt_funcs->mode2_reset)
> -		ret = smu->ppt_funcs->mode2_reset(smu);
> -
> -	if (ret)
> -		dev_err(smu->adev->dev, "Mode2 reset failed!\n");
> -
> -	return ret;
> -}
> -
>   static int smu_get_max_sustainable_clocks_by_dc(void *handle,
>   						struct pp_smu_nv_clock_table *max_clocks)
>   {
> @@ -2705,6 +2659,82 @@ static bool smu_is_smc_alive(void *handle)
>   	return false;
>   }
>   
> +static int smu_is_asic_reset_supported(void *handle,
> +				       enum amd_reset_method reset_method)
> +{
> +	struct smu_context *smu = handle;
> +	struct amdgpu_device *adev = smu->adev;
> +	int reset_supported = false;
> +
> +	switch (reset_method) {
> +	case AMD_RESET_METHOD_MODE1:
> +		if (smu->ppt_funcs->mode1_reset_is_support)
> +			reset_supported = smu->ppt_funcs->mode1_reset_is_support(smu);
> +		break;
> +	case AMD_RESET_METHOD_MODE2:
> +		switch (adev->ip_versions[MP1_HWIP][0]) {
> +		case IP_VERSION(11, 5, 0):
> +		case IP_VERSION(12, 0, 0):
> +		case IP_VERSION(12, 0, 1):
> +		case IP_VERSION(13, 0, 2):
> +		case IP_VERSION(13, 0, 1):
> +		case IP_VERSION(13, 0, 3):
> +			reset_supported = true;
> +			break;

Patch 2 drops mode2_reset_is_support(). What about changing to 
is_reset_supported() and avoiding other checks here?

	return smu->ppt_funcs->is_reset_supported(smu, reset_method);

Thanks,
Lijo

> +		default:
> +			break;
> +		}
> +		break;
> +	case AMD_RESET_METHOD_BACO:
> +		if (smu->ppt_funcs->baco_is_support)
> +			reset_supported = smu->ppt_funcs->baco_is_support(smu);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return reset_supported;
> +}
> +
> +static int smu_asic_reset(void *handle,
> +			  enum amd_reset_method reset_method)
> +{
> +	struct smu_context *smu = handle;
> +	int ret = 0;
> +
> +	switch (reset_method) {
> +	case AMD_RESET_METHOD_MODE1:
> +		if (!smu->ppt_funcs->mode1_reset)
> +			return -EOPNOTSUPP;
> +
> +		ret = smu->ppt_funcs->mode1_reset(smu);
> +		break;
> +	case AMD_RESET_METHOD_MODE2:
> +		if (!smu->ppt_funcs->mode2_reset)
> +			return -EOPNOTSUPP;
> +
> +		ret = smu->ppt_funcs->mode2_reset(smu);
> +		if (ret)
> +			dev_err(smu->adev->dev, "Mode2 reset failed!\n");
> +		break;
> +	case AMD_RESET_METHOD_BACO:
> +		if (!smu->ppt_funcs->baco_enter ||
> +		    !smu->ppt_funcs->baco_exit)
> +			return -EOPNOTSUPP;
> +
> +		ret = smu->ppt_funcs->baco_enter(smu);
> +		if (ret)
> +			return ret;
> +
> +		ret = smu->ppt_funcs->baco_exit(smu);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>   static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	/* export for sysfs */
>   	.set_fan_control_mode    = smu_set_fan_control_mode,
> @@ -2744,11 +2774,9 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	.enable_mgpu_fan_boost            = smu_enable_mgpu_fan_boost,
>   	.set_active_display_count         = smu_set_display_count,
>   	.set_min_deep_sleep_dcefclk       = smu_set_deep_sleep_dcefclk,
> -	.get_asic_baco_capability         = smu_get_baco_capability,
>   	.set_asic_baco_state              = smu_baco_set_state,
>   	.get_ppfeature_status             = smu_sys_get_pp_feature_mask,
>   	.set_ppfeature_status             = smu_sys_set_pp_feature_mask,
> -	.asic_reset_mode_2                = smu_mode2_reset,
>   	.set_df_cstate                    = smu_set_df_cstate,
>   	.set_xgmi_pstate                  = smu_set_xgmi_pstate,
>   	.get_gpu_metrics                  = smu_sys_get_gpu_metrics,
> @@ -2759,6 +2787,8 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	.get_dpm_clock_table              = smu_get_dpm_clock_table,
>   	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
>   	.is_smc_alive = smu_is_smc_alive,
> +	.is_asic_reset_supported = smu_is_asic_reset_supported,
> +	.asic_reset              = smu_asic_reset,
>   };
>   
>   int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index bced761f3f96..ce9cd0522a40 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1392,9 +1392,6 @@ int smu_get_power_limit(void *handle,
>   			enum pp_power_limit_level pp_limit_level,
>   			enum pp_power_type pp_power_type);
>   
> -bool smu_mode1_reset_is_support(struct smu_context *smu);
> -int smu_mode1_reset(struct smu_context *smu);
> -
>   extern const struct amd_ip_funcs smu_ip_funcs;
>   
>   bool is_support_sw_smu(struct amdgpu_device *adev);
> 
