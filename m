Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE83C05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 18:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AFA510E090;
	Tue, 14 Feb 2023 18:31:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED41910E090
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 18:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMHege20GbJo8mqLFmcqld2EloDX6MEPU1y7f2VzmCDvUARWxHrKSdZ4atgPzLxQi2fU5dg6XqJRQ2b+go8YFVfjvIJS81SLDjZJLUriRznbDXYZBL2hjtdLy41d6aAAYDc7fzKnC+yhvx2ugALeAMjVwpmNgKXxbpZaLcx9GY1LNNL9DSSQa7WJjNu70i7K/Du3XVnF0DOqNaQqDxzZ4qa0k9uudBIYNiw3LJCTgpBa4iMxThYnJOR6N58GVmJHFh/DL1tuLVgXaIWL9kEGzBMP2hmbvfCrrRizeHN0Jga82uAx8Hggh29AiWiEf1ab9v54T0/+Gkz47VLhtXY8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwU++tF7DDvkZDO1iUGKFl6jyywy5f9GIujTcWd/rCU=;
 b=WCo5nT+73D7ASb3oj/5hO5JnN9lXhZOVHA7NkIieXIWCVlp2u3C6n+mNLAdXNXWD2vcTYpPVEaqSqV5MP0iEubu2tmeqnHEPDUBkSMgljVgyyIvieBkcOOA4IH0YUuLed0I103bc1Y8qhjWnn718pRuZW7IPn0AqfbE96T+PINPb/tPG6muJM1ags6sxGuLR5aeDcE6F6Fvu8la9WBAiqPKPi7Xfx7iHRswpQ8puOgHgO86ErLCvv0G4pm8+OFhBTUbuTONvcXhpY0RnIwbEzbaX6kXQ/Q5/+cklaJ39/75ECl4wrI5oDU7LSSheSCt6+hyz2o/ZeIAAyqE9RUskiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwU++tF7DDvkZDO1iUGKFl6jyywy5f9GIujTcWd/rCU=;
 b=AN2/RRH5zjxDxZO8Fu/dYoN0OdHcnoH9WlsO+C+LcPSdylpcw4pciL32acqHSZkPdy/wNMJttL5Eyc4AKDLYxcy2M36boT+nu+bnpNnyUIDT9L43iyaULdgrNuuIL0x445vJTy+T5b6mqOh9sg9RSAlMBaMKRDywbpXoDl1Ooww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 18:31:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 18:31:22 +0000
Message-ID: <7cfbd8c6-7865-2fe3-ac93-d3b264f2b4ab@amd.com>
Date: Tue, 14 Feb 2023 19:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/8] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-6-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230214161510.2153-6-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 10141436-138c-4199-ccd9-08db0eb9ac33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zz/NpteSRg3rOVjX31ckxSc+Okq/uEQpqsZmcDC3qow8MUyPwOS6s5RE5peFrdjWgmGNjn3WMhTAGXFbEX3XmVR3bs5Sf+A4Shh5yMFhIhg2ZtZF5lIkCo+i8qtu1SBkklZvVzRiPApFkgIhxx3Qp3F1H1Obm5PQiY0xfSQcJZ4EkEygd5Nwcdei9Cvy4dLxo4ErmNaBAmhA3lhSyLiieS5q4pV1Lb+1z4fOmNdrQGu8G0YhR5KUpUIHC2kgtxtC+6JVxnUrhhyiWevgDnOr4dbAGXH94OjELnrCmtgImY/TbF2Uml7PLyX/pWdSFcqgsNyHB7c1o9Sl1YsmL15ygnU/TT4XxThDHT0dIGOhDqVT3fa7Z9FnJr+UZyBevgG1w7A/Ahhq7/36MsrbKORUFpgQUcXWwX4zbo3M9q1VMYW0JMx4Xwa8cflttXyLydu8TMvSuxYGILM1aFEaS+ZX2LRvJgr4iUxfZJVxG1wh1mc0X9b1suL3FOBS+gpdfCq2DjG2+d0/saaLwy21zMPvrmmI6Ea/6wZRQFJUzbeaXpw7aZ7T8k3WGRsNryEkPw2tqII9VHlD3TVvAQ6kGiUw7ZWAiBu2YdBsAu37dyrqWpEVghQRemiUHPJSJIPIEEXwwpYkPIYBZCmFMo1UUA+stj3JCvTIB1eUkZ8RL4MlR0J4fdRvUrx+ISDkKUSak8AigKKooADkPryR7n2gWmYEUalcDniqlAxOr7NxIZEXEpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199018)(31686004)(5660300002)(83380400001)(6486002)(31696002)(186003)(2906002)(36756003)(6506007)(6512007)(86362001)(478600001)(41300700001)(6666004)(66476007)(2616005)(8936002)(66556008)(316002)(66946007)(4326008)(8676002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxoSXByS2htOTIrSWpwdmRUclZTbFdJeEVwMkd2Rk41UWJ2OXNiZzR6aXpP?=
 =?utf-8?B?RnZvRE5IYzJOcmlEYVJOdUJYazVuQmdvTWxkSzZDbmt2OFJ3L212V3BNc0JS?=
 =?utf-8?B?VFpRb1FoeXZSU3RKaVJpcDhSQTJER1RKRDBpeXdJQ1p0ckhBbGEwRFAyQnUr?=
 =?utf-8?B?MkxmZUhaRS9TVTQ1OHByVHg3dEY0SStYV0FsbWtmZnN1bmxwSUh4U1ZsV2dY?=
 =?utf-8?B?Z3FmMjZRRlY4REJFYXlURS9RYitxR2J1ZHRYWm1tZE85UHdraEFZNm9Kd1Zt?=
 =?utf-8?B?bndpa0REekZ1UkxhYlRuMTFGd2dtOU5FRmg2T1FIcEhVaGM3QisxUmVwWnBF?=
 =?utf-8?B?cjRGbXB4eit1Ny83U1JoeHJDK3RxUmNjT0pDVi9GQnFKWitiSXRZU0Ftd0JW?=
 =?utf-8?B?TE9TQ2lsMjUvUGt2MVVRc3M1b21sZEtrS3IyQlExVXZoL1Z5cWRPRkRYaUxR?=
 =?utf-8?B?S0ZTMXNUU05mYmFCYm1XL1VLUzNETEVMYmthNHYzU1Z5anpuZnQ1Q2NlMmNE?=
 =?utf-8?B?K0txRDZsallSVVFLa3NDN3NCTWlIUWZwdU9Dc040UUszQUZjWCtrTFhNM0c1?=
 =?utf-8?B?aHp4MWFBWURYTHZhdDZxVnpWb044ZUxUVStzNHdOSFZqR1lGWGRBcWVUOTBi?=
 =?utf-8?B?OUE1L3hSWHlISXUzd1FYY3Y1NlRVbVZKMFpJVEU5Sk9yb3V5U0MrV2xxZWxq?=
 =?utf-8?B?aEFpdWF3d2VGcDZkSjdna255RjJlSldpZDlWblRMQU95eEszOUQvdlNmQ1dL?=
 =?utf-8?B?ZndoMlBYWkd6a3F2VXdtb2hnNllaa2pscEZKcTZHWDFia0VNaU9RakJnZ3Ji?=
 =?utf-8?B?RTArVVhZRmNvSkR3OXBoMGNzN1FmelJKSGNZSlcxc0lhbEJGMmZ0L0FnZlRH?=
 =?utf-8?B?VkM0RW9BdnRBMm9naFp4OW96NDdSWHR0KzduRUh0SnljeHV1aVJwTWJOa0Ew?=
 =?utf-8?B?czhjZzJFOFN5alVFL3VwSTZRVkhycFhsTlROSFlXa3F1SXZYOHdYcFg2bk92?=
 =?utf-8?B?R0todERMMHRUaUZLVk55Q2pJYjZBeSs0aFVaM0w2MzVYTmQycXlweDUzR0dN?=
 =?utf-8?B?cS9sbnpkd3ZreTludXpsOWJqL1pJdk9FV2RISXNvd3ZHZDR4bi9GMkE0N2Rt?=
 =?utf-8?B?S2lYaDFwSGpIL1luNFdqVnQ3WkZnMWFadlgxcjl1aGZ1bjVJLzVvMm84MGZD?=
 =?utf-8?B?aDZMM05veG54bHZTc0E3alJPRHordTJoNmErOTdmK2tMa0FaVW5WYW9NQmJ2?=
 =?utf-8?B?c1VHOEI0VWJhQWk4YStHcnNSVjNpSnBpN2FzcDc5RmVBTEN2aHJYdmVmdDFN?=
 =?utf-8?B?WXF6U0dFd3pYTS9CeTdBMkhpdTFERWhBUnA0bXVLN3lyUXhTa3lXaFREM04v?=
 =?utf-8?B?U0IrZXFGc3dVUUd2elFLNHlzNUtNNXRUR2owR3pKZW9PWlZ6ZWM4dGVJUisx?=
 =?utf-8?B?Vmp2dkxQeGxUUlpLc2h3akV6dTFlbW9hdUtDRW1aYzZRbkhBaFcrWUtSSHAv?=
 =?utf-8?B?M0lMbDUvRXp6Tk95TUcxUlFhSW1xNjFIeExiSnZFWnBCdjgxdEVqTlo1TmQx?=
 =?utf-8?B?VldoV0RvSDgrcW9OejVrYjhhQTREQkZVbTV5Z2M0WjZjdlEvTjNjL3FmeVRm?=
 =?utf-8?B?TnU2U3BQWHE5K09UUjRILzIzQzJEWFBrN2d0Q1A1aU8yKzdhUm1oY2RMaDZj?=
 =?utf-8?B?Q1pITEFBc213MnNaclNMaW1lY3h3OU90TVZJdHE2clBINyt3Mm5QV0FDRUs3?=
 =?utf-8?B?VThadDNFek1BTEk1TG1tTHhoYnRDd0E2YXA1NkluTDBoTE4wYWlLTyt0eTdG?=
 =?utf-8?B?ZDRPZjNzcUpoNytmaVJnUFRKcW42bFVGRXR3M2ZJbXA3Vk5RUEk3bnZDa2lk?=
 =?utf-8?B?R0tORGJER2ZwZGRsQ0dRV1pFYWx0KzlVemQwa3o3TGsyM0ZUVWNwZHdQSTFM?=
 =?utf-8?B?aTVMN2lFT0IrTlYyL3BnYWc3L1lzaE5NOHdmSVRTYUlHQ1pyMy8rNGR6QXFO?=
 =?utf-8?B?cHBNL01MMEF5UlNJNzdUelU3Q1M2MDJ1SHRFRHYxTDdWbnpSVnF6NkFGUC8z?=
 =?utf-8?B?QmgxWmlPc2lkTXBaMm1KSXpCRXhncHZETFJnbE0xeWJyallMK0JaVHNjbStG?=
 =?utf-8?B?RE80T2JtQjNFYmZqMitxekRWbTQvVXVXUkJ2amlVczZXWW9jUDYyZko0U1lp?=
 =?utf-8?Q?nDopNMLBc243LmRpCX+quDsFcHgdgd8UbT8ZZMz5HBjf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10141436-138c-4199-ccd9-08db0eb9ac33
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 18:31:22.5746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRhfYg+jHBQQzyr121dSItoLNrJEXb4ydyrkelZze2uVzkFrtcwP6fFLvGKj9w0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.23 um 17:15 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch adds changes:
> - to accommodate the new GEM domain DOORBELL
> - to accommodate the new TTM PL DOORBELL
>
> to manage doorbell allocations as GEM Objects.
>
> V2: Addressed reviwe comments from Christian
>      - drop the doorbell changes for pinning/unpinning
>      - drop the doorbell changes for dma-buf map
>      - drop the doorbell changes for sgt
>      - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 ++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 11 ++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  1 +
>   3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index b48c9fd60c43..ff9979fecfd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   		c++;
>   	}
>   
> +	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
> +		places[c].fpfn = 0;
> +		places[c].lpfn = 0;
> +		places[c].mem_type = AMDGPU_PL_DOORBELL;
> +		places[c].flags = 0;
> +		c++;
> +	}
> +

Mhm, do we need to increase AMDGPU_BO_MAX_PLACEMENTS?

I think the answer is *no* since mixing DOORBELL with CPU, GTT or VRAM 
placement doesn't make sense, but do we enforce that somewhere?

>   	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>   		places[c].fpfn = 0;
>   		places[c].lpfn = 0;
> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>   		goto fail;
>   	}
>   
> -	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
> +	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */

Should we enforce that user space can only allocate 1 page doorbells?

>   	return true;
>   
>   fail:
> @@ -1014,6 +1022,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>   	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>   		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>   	}
> +

Unrelated change.

Regards,
Christian.

>   }
>   
>   static const char *amdgpu_vram_names[] = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 0e8f580769ab..e9dc24191fc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>   	case AMDGPU_PL_GDS:
>   	case AMDGPU_PL_GWS:
>   	case AMDGPU_PL_OA:
> +	case AMDGPU_PL_DOORBELL:
>   		placement->num_placement = 0;
>   		placement->num_busy_placement = 0;
>   		return;
> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   	if (old_mem->mem_type == AMDGPU_PL_GDS ||
>   	    old_mem->mem_type == AMDGPU_PL_GWS ||
>   	    old_mem->mem_type == AMDGPU_PL_OA ||
> +	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>   	    new_mem->mem_type == AMDGPU_PL_GDS ||
>   	    new_mem->mem_type == AMDGPU_PL_GWS ||
> -	    new_mem->mem_type == AMDGPU_PL_OA) {
> +	    new_mem->mem_type == AMDGPU_PL_OA ||
> +	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>   		/* Nothing to save here */
>   		ttm_bo_move_null(bo, new_mem);
>   		goto out;
> @@ -586,6 +589,11 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>   		mem->bus.offset += adev->gmc.vram_aper_base;
>   		mem->bus.is_iomem = true;
>   		break;
> +	case AMDGPU_PL_DOORBELL:
> +		mem->bus.offset = mem->start << PAGE_SHIFT;
> +		mem->bus.offset += adev->doorbell.doorbell_aper_base;
> +		mem->bus.is_iomem = true;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -1267,6 +1275,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>   		flags |= AMDGPU_PTE_VALID;
>   
>   	if (mem && (mem->mem_type == TTM_PL_TT ||
> +		    mem->mem_type == AMDGPU_PL_DOORBELL ||
>   		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
>   		flags |= AMDGPU_PTE_SYSTEM;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 967b265dbfa1..9cf5d8419965 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -33,6 +33,7 @@
>   #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
>   #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
>   #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
> +#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
>   
>   #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2

