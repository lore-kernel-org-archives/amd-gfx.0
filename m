Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C73C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 17:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EDA10E0D0;
	Thu, 11 Jan 2024 17:26:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E94A910E0D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 17:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEKyAPtJxekENgKC+w8axyVLLGf7NVSfgaGUmfBrg1lM2OKA+J5/4PagDcbqvQZ3aYVaOTzZM3yBSJb/PGe/Jq0p/nAP7p5xp3pxzJF96TZDqraKrVDB1nM5dEv5X/384HPwPb8ULb17rLu+LddqRik4wbABYuPpD9lER0d6QmFqraMTn/+FHJ2BoU8GO2+dN4Cp7IX+hli+y/BWYU1IYcH/vQwvUSLqdYecBbcOe/CcN+mewAbEUeTd9zMOHNIOaJBhVNooW/SJGjei57iTA9++Zcf1tqaWsoYLMzo423bxrqhaCOArUd284OnnghIsrwZpe4DbXrlsXzJRAkPA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BKHArUp75IutZPDFWUQtrjZN97+2na1yR9I5TNtxmk=;
 b=Vn4V4/3FBW8C/9e9I+MP4Mxurqmbm95rv+d0hzJss8oOFILcEeJ7kFhudJIfWMGsH+Vf0XaFve188K7GPDDWuVUG90YcwjfOwzbr7nP7dBVsImXm23xWiCMRK0JM8Fsnj+Po48MugT22f27NaX9cgiT5X3Tmr2I0YIftRq2AB6fa5itlUwhF4Ui8NW0Ai4PNXddcXRtjR4eowH/f3iRWXPgjlnrirvHl+kXMvNSBbqsVhzpeGk8koGoWROPPcHLJsO3iGDan2xm9d95BsFgAPaVRPzdvKFzvhW05o/0h4lMEE+rrt8RBUcFrf8m5b8jz1+e1hUcMcGcnQ9EbsMPJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BKHArUp75IutZPDFWUQtrjZN97+2na1yR9I5TNtxmk=;
 b=Mk6DDpjW358GExgIz1DYL1kFCIvt5UPynW5ZhgLvEsBwb8qVmZOCTDM3w1koIcV7f/r9Ji1xXdO1DcYMjlShe+BnfTos3mLj8Ww0v8Vnbnxm7xjf3nFX8vf0suLe91H/2QM7xGMThIXQIXFBG5YCYtSwE88g7y/WEdh8FPc0lnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 17:26:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 17:26:33 +0000
Message-ID: <55d546b6-4775-4ff5-9ec6-2853ecb7bb46@amd.com>
Date: Thu, 11 Jan 2024 12:26:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix variable dereferenced before NULL
 check in 'kfd_dbg_trap_device_snapshot()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240105105203.2776015-1-srinivasan.shanmugam@amd.com>
 <20240110155604.525797-1-srinivasan.shanmugam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240110155604.525797-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0254.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d6ae73-6832-4372-2709-08dc12ca7494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdIoNvcZ12hWr6KRD6wPces62CNj7MB4ApO/My81IlW6IjiheG7KeXkZxTBlztT3pxM5T+HQh5XeSQwZv4TrNqk0/R1VPrQHXLQGGPDJ16zRQK+Cr1pPPBiAwFXIumHpV9F/Qx0j7mstAEO0O3kLmiO0skPcPDlnrgSV1aohmc7VMkG6aDb1FbjPWKxxPuUkpFAVz19eB2/gyxtQOc/0cb2hPzfF5EKYOl2yu8855SoMxj7aRSEGoUrFIvAE3jl16LsHfZADt6+qPKbJc1zeRBfWh1zGYEY3PAH6b6lv/1GxiefxAg5nY1RaAA+v5QVUYorj0g5s8gCN0f1ajBRqQAUJbOBFETxzMXkp2/7wlXv6fryHWIykNBc7kCy4ckXZOZfV6LXD8q6tVBXhYI5dTjwO6iPpMRSbtaMTQLVl8hlpFXjFAcZs9kkf3xmd6L8KLUW6WBRGtAs85889MSV+yMA/xu4F7VwLpYoQk+92ZK6sNuXHUMUxq3eynhht76GdElzZQ3uW0LsrH01QDViSeIdLtzwAymFTovhs70FrVqneoWV4YvSgt/u4qlJgzXXxhGvKvNE5FAKKauD1FZPWGt1LP4koZRVmFKVZLioR3EDKG4TrvwCasUVbOXFqi9p9sm3K47TRTQzaJkyT1K35KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66574015)(36916002)(66556008)(316002)(6636002)(478600001)(66946007)(66476007)(53546011)(6506007)(110136005)(26005)(2616005)(4326008)(44832011)(6486002)(2906002)(5660300002)(83380400001)(6512007)(8936002)(31686004)(8676002)(38100700002)(31696002)(41300700001)(36756003)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkNrQ1dlTXhhWlJjM1FYVEFJN3FhcDVqOGhDdTV4WlRoSitVWHZlMHJXZERH?=
 =?utf-8?B?UHpXUVNnUVRFOE9TSnpmMjBGSWJibDVCRWtQdmJUWFk4QUFyWjBSSGdjUWtx?=
 =?utf-8?B?bHJkOTBNOUNQcFJTc3NLbklzTW1odFJwSGtvYXdYSVFDaEFlS2JwT0t5bFZw?=
 =?utf-8?B?Z000YUJZRFhkVnozSW5vZE1YdGZ1MUUxSTBaMFlrbTZiV3BMN1pMZE1YY051?=
 =?utf-8?B?cmx1K1dxaFJPUFRnNHZrd0JNa211TGRrSDgyempUN2gwNzU4KzhsRHQ3a0dN?=
 =?utf-8?B?R2hTb1c2OStML08rSFhFak0walp1YVVNNEFKak5kSE1LMzBuYUJSK0UwdnpU?=
 =?utf-8?B?T3Fqd3p6ZWg2ZXFmSnlYcElER1pNQUc4N2dBeFNsczZvWGttZE52QndqSTRC?=
 =?utf-8?B?YWFER0ZUVFdQSnhrS1JOWGdLVXppcTdvMWxSd05hdFczaFpWYmFlTjVVanMv?=
 =?utf-8?B?c3lBWm9PaFpuTUxKUUI2RWVlemc0dWhjVWRHZ2pFcDhFQTdkNGRjd3VjQmVj?=
 =?utf-8?B?WXIwRkZweFdIWDJzald2b1FndlN4VUhaR2tNL2VPbDROdHhra0l3OVIyRzQ4?=
 =?utf-8?B?MzBOL0MzLzY4bXFienp0WDArOW5DK242ZzA5eFE5OHB0NVJMRTd5VS9zeWdr?=
 =?utf-8?B?ZWxqNjJwc1dXOEJDeHhZcEc5LzlEQ3UzQ3pKaWJUdlBHR0psbFNzTnhuR1Ny?=
 =?utf-8?B?NUJ0MlF6Sk1zWHN0RXkvWnB4aERzaHFlMWl2TjBTQ0pTYTk5YVRnQTluTjVP?=
 =?utf-8?B?eFRSK2pGdFVVZld0QjJkdCtqQmpwS3FsaDcxUk5FN1RNR0VmbnQ2TkFEbHVD?=
 =?utf-8?B?NHhFVDVVMGV3SzU4VzVXUGZDTnovTmt5R0NRNWQ4dS9zbDRVODNodlRSemsw?=
 =?utf-8?B?aWhTTjNyY3FyL3piTVlzWitDaFZ0dWdIZDVORm9TeEVkM3BiSEd1MDRIQ3Ju?=
 =?utf-8?B?bHdiWHNOOElnekt0clVPc0xtRjByQ0FCMWFUeXRRN0ltb2lrd3h5NjNvWWda?=
 =?utf-8?B?NGpRVzd5K1lxV2tGQkdMTjc2aHRRQmZxNlo0VEI5Z0ZudkwyQlBBUnRlSjUr?=
 =?utf-8?B?cFk2cVJGVFBad1c0RHdMN0FBTGtvNXZnTjVYWEhCOThtbGwwUGZMUHRtdmNJ?=
 =?utf-8?B?cC9DQjJnOUxROXZjY1dsLzQ0Mzg3b2tDcVl6ZjlQMUpVQ0lRVjFteUdrZ3BN?=
 =?utf-8?B?TURCaHR4algyb3pwd3ZTeDMvQnVhQWJ0RHVyUzRuVldaUXBOTzNldWdPRjRZ?=
 =?utf-8?B?QnhFeFpkOUhQTkhUZkNISEtsZ0hXQnVEbGpQMmFFTlphL0F5UTlLaUZ3OWZE?=
 =?utf-8?B?RDRGdGQzaTU2dHVpREQ5cFBHQVJYTmtKUW5aWXNjU3g4SUlZbHBIQzlnVWFI?=
 =?utf-8?B?ZEJWSnBNTHkvUWdGaFdJcXRoeUNNTFR6Qm15UGJTQVVUZncyWUg4blV2Y0tw?=
 =?utf-8?B?NGZXNWNYS2syMGpLLy9yU3BIVVRvVlV1UG1Mai80MlIvaS9kNkVwM2J4dnow?=
 =?utf-8?B?cEkvejB5MFJsZnhTMjYwVHUyVVNRRTRubCs1SWVhL2JqT1lNRzVrYkVNNHBh?=
 =?utf-8?B?Rzl1T1hETzVuSGVVamdIRlI5UnBDVVlKekR3T3VhWEVwenc0TmMvekZwei9q?=
 =?utf-8?B?UWJsR2ZjaHN1eGMySzkwMlZ3NWhSUURCSlVOTVlYN0lyTk1XNEZ4VlNIOGZW?=
 =?utf-8?B?Y2RFR3prWTFqL1dIS1kzTTMwdlBmeWNXV1JyWHhYWHRKOWpsSGx1VFZWNzJq?=
 =?utf-8?B?SURtWDlaR2pSTkRBNUdraVpKUnRyMTY5WmtHdW9YdVhYY0hod0ZaKytEeHl1?=
 =?utf-8?B?dmdwYUF4TXlEeW8wVVFpeVI4ekVGVHpMckxLcmV1WDNVSW5yRTBPcXlYdm9m?=
 =?utf-8?B?ODlka0h4aHRYSWo3K3ZSRlZoZ29FUUgvaTRvZ05Ob0FObTZZZ1BtUy9NdjFT?=
 =?utf-8?B?NDhpd21QZXRKWERGT1lxaS9aYmkwRFozZ000SEoyR3QxQ2FUemwya2FNa1ZR?=
 =?utf-8?B?MkRVUW1nZU81eENzMjNXd1FsQjlJTkJmUFNEN3BMbGJ3R3pIZkdqSDlCUkNG?=
 =?utf-8?B?QlVjaEljelZxMDVCTkdkaU9jVlh0RVVhWWpkR0V5b1lUVHUreVJlRXFzdlMv?=
 =?utf-8?Q?/5by4cz74qkHVFflIVxkIHCb0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d6ae73-6832-4372-2709-08dc12ca7494
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:26:32.9775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/jmkfBFiP73NR98IeGNMoLVS5V3cM13ivMRhDgVrki+dYfUXn40z/6qhpkViEhxlcUVAkoyJkfakkCcXbhUaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2024-01-10 10:56, Srinivasan Shanmugam wrote:
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_debug.c:1024 kfd_dbg_trap_device_snapshot() warn: variable dereferenced before check 'entry_size' (see line 1021)
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> v2:
>   - Changed from u32 to unit32_t for consistency (Felix)
>
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 9ec750666382..d889e3545120 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -1018,12 +1018,14 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
>   		uint32_t *entry_size)
>   {
>   	struct kfd_dbg_device_info_entry device_info;
> -	uint32_t tmp_entry_size = *entry_size, tmp_num_devices;
> +	uint32_t tmp_entry_size, tmp_num_devices;
>   	int i, r = 0;
>   
>   	if (!(target && user_info && number_of_device_infos && entry_size))
>   		return -EINVAL;
>   
> +	tmp_entry_size = *entry_size;
> +
>   	tmp_num_devices = min_t(size_t, *number_of_device_infos, target->n_pdds);
>   	*number_of_device_infos = target->n_pdds;
>   	*entry_size = min_t(size_t, *entry_size, sizeof(device_info));
