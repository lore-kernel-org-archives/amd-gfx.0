Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F793CC6B0F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 07:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46C610E077;
	Tue, 13 Oct 2026 07:13:24 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C7710E077
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 07:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptLSgqu0lH/j4p2+gj7aDWyGFGBWr4ijTtt3+apobKv413Y3VO05cn3sSFfdLwSy6W39unYV5OVlLomSeblmbii17HWR2rOlbIdwQ94piRXqfjmST9HcHHePhRDgUn6KmQcOJP5+At8Ls9VB9iEJGkUf9R7tISnMTEtDgdhIjO4t8ZxdG/pe0iESsJvl5JXT3BtHGzw3EU0i6uQLXT9xyGCaWBQVo1M36AT/DauMZVrQiNVOxu2wRxI1IhxbKPb26Dhokto8e7VMwTy3ezMUvmLvksD6djR4HtGe0SyF779lLxNzaYFMbetReAIblyQFeLWJPgT7PuZ8eH7BtrU9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/1EO0AdJGgnsBGKCMBhVxVw9jPa+ILwpzuC4RNg/1Q=;
 b=SrueegE55qpoPy29YF+n1azgPlvR3IzbOpzwHo0GslJGxTvP/qEXtmykmWytlTo+AFK02eFfDv8h/031tDPAmicm90kUaYLNgBn+KVE6Ow3ben+jn/hrKwr0caweLoKKzsVFjw8IximqE+JTb/8P6cJNg/TrSA+ea21fHIQ8F4AF5+t+ZMKsKm03ww3wbF4vy+UdwgvHlGRDSErh4U+o2hskgJtwkrse65jk6bppCLMaxPzYSgE3V1WLt1lhnapvXqEPyLfi1hFskucYWpqYvV6uSpYFkSfS+16VFnw+uxfT64nfFkJIVOanX14cwC/CI2/wqouR0/uN/Z6qTVS2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/1EO0AdJGgnsBGKCMBhVxVw9jPa+ILwpzuC4RNg/1Q=;
 b=Ko2ilxE1B3avzl9iFwtKr41utPs5Ono2P5b0+TCeQZQDV6Df8P0XfTN0mwYSGg/306If5kgjHeNJBAB7fx4zlpJ8ZuPqeBjM4ZHvPS+NbiKFg8+92lNineeqt6zgq2kMrwu3+9G2ARWhBtdB581GwXCSOIesO2gKMVUuLbQvOuw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CHBPR12MB047581.namprd12.prod.outlook.com (2603:10b6:610:369::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:13:15 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 07:13:15 +0000
Message-ID: <c0230e72-5a35-4e4a-a834-4b9413f611d2@amd.com>
Date: Tue, 13 Oct 2026 09:13:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] drm/amdgpu: use dedicated SPM VMID from the
 reserved path
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261012092429.3937825-1-sunil.khatri@amd.com>
 <20261012092429.3937825-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261012092429.3937825-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::18) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CHBPR12MB047581:EE_
X-MS-Office365-Filtering-Correlation-Id: b937ad02-deea-4ac2-fec1-08df28f972f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wTWeIAe4uZ3Y4XEMNoZPin1FFx1mw0DKX+x1Szkzh52SI5BWWKOZFe03YY9J/2LjbIRYoe9RLVuUloVcSRVILVmqRjLuBfrASvJRrqdjAIam2lQVhCopIpiLaDMpuVjBeg4cDaAm5RdAVMSm8ntBvSnhTXqADu2eA7HUpBWzWGJfHf2hMM+TN73nOf9b/yiETanh3DHsOSYkZ9C3emnZQA5Vh/tvE32BeGlh5cY+7YDpqWd8iCtHiloOVwlLctosThSzuLFRNfLMUVE05GpeemNZWz1NXkoJyaZNv/J0zm1hToTCG2/GKJXldR/lwmFLzC7r846F54mvzHnyALrmMdIYOgvGEmA33BmxBcixbK9vrvaY3KDjboo0Sh3XZtVXJ0VGq7pdD0qZIFYDnMY2j/L2w89o09AHFi87pPGjAMmcOgQ/FglaqtTWHZnRt/303keSNIl+OHUVYM3M0/LEu0pbi+WMzNrld6SiuOVypAQwM4HFxjVmTMRMsgGX2jt38IB4B35o+RxlFOtzB+dAN0Gzwdggu51jDw16dRl2snMeGe1oFwEuEUTlagr5b4661rC5z9BIJn0OxdN0R3Vd600dCyLvy9d62zl+4Zm28hWJYt68XhD62xCOxSNdg6xGVGyQmDY+9Ld7uQ+6xDKzdCtjNRxr07yWshNR081p5fA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXlUdFN1Z0JXdFhERURSU29LNXhoV01nWE9IMkxZQnNnTlQxNUlTZzlGSG5q?=
 =?utf-8?B?VWJkeFZZYWFmOHFMT0JvMUFWUG5sMkt5UjNXRXZiTGxWYzdRb3Rxb254QVpr?=
 =?utf-8?B?dGgxWVVMQ3lGQ2dsdVZ6WE5TS1ZuUDB3Y3hoSjJMSmhlSFVESDdsUWg4M0RZ?=
 =?utf-8?B?RGw2ak41bitrQ1BCVUYvZ2R6Vy9WVlk2SFpodjl2bExtMmlkS3BRVnd3OGdC?=
 =?utf-8?B?d05wdTM0azVrdjh3dG9IMjFnNlZMWkYvMnBPamJTY2dCbDZldWZYbjJOc2lo?=
 =?utf-8?B?cEhoUkdhQ0VnbUpkdWVpdEt5OHZrVFZKUVFNNS95SFFTS2hWbkY0SW5VU0Uy?=
 =?utf-8?B?QTd0dEd3c3c5c1BEN0NmWlhyRThmOGJnZmVFQ1dFVy9FeVRGSWM3dEMxSGZB?=
 =?utf-8?B?UXlFajJpOEpqc3V5L1BibnlZTUNmZmJ3SmRXaUpOVExCZWdVN051Sm9tMUM0?=
 =?utf-8?B?ODI2UFBlaFNIc2ZpMjNvZ2orTmxIRWM4dDZkM09MM1grb2hzbUg0VG1MeDJT?=
 =?utf-8?B?NVRVME1qS1pjcUxQUzd4d1FUVkxEaFkrMlRQWW80c2RMTFhHK1RMU01iQzBG?=
 =?utf-8?B?ZFVxS21mRFk2YWwvb1c4RE4rZU9TbnVQSjdlUFlybHhVaGxEUHIvOEtYSW1Y?=
 =?utf-8?B?TVpQSXZqV2xUK3hETDMydTMrY2ZvU25PRFF6aG5JNFlVTlhZeUNnTWhKb2Zq?=
 =?utf-8?B?VWloK1hFL2xoSDJTQlcrZXRscWEwQmV6cittL2lVa2V2Y2gwT1o4dmhPUThz?=
 =?utf-8?B?V214YldxdlVYZElMb0VYNjZFeWJkbmlSdTNXRXhuOWlWMUNHdmZKQUFodXli?=
 =?utf-8?B?blVhYjBqdmEzV2ZVenM0Y2crTGNlekxmN2praFBkTFY3c2JrNjhRekRHYmxK?=
 =?utf-8?B?bm1kWmZNMUhCTHRKWTJqOUZFRS9RRkRmaUdzTXlhVGZpOE5jUm5FR0NjUU1j?=
 =?utf-8?B?YTNsd25KTFFSbVRIZGVseDVrQVVMdHVob3g2dU8zekJocGRNMHlLbEJkZ3JH?=
 =?utf-8?B?cjJlRll5NU9UOHNUbGRSS0s5N2Y2QmFyVnZPL2hUeVVWb0ducUgwK2IrbWlF?=
 =?utf-8?B?S3k0cDRPWHJzYzlKZmM5STZYeWUxdVBtaEQ4UDcwOW9PSkhmTHpDMkxvMkky?=
 =?utf-8?B?QnRzUzIvazFyY1BEZHFWYjd3K051SUZvNHB6dGFNRUFtSmpCVjZDcExELzhZ?=
 =?utf-8?B?ekNsNG5CQUpxbWU1MW4ybmNRbTNsc2Y1NWMxSDFFK2xhc281MnlnYURFRnk1?=
 =?utf-8?B?T25UUWNmMFNONmpTczlDeXo0WkpPdnNoNE92bmhXekxSVVo5UGpXc3R1MmJk?=
 =?utf-8?B?VVVEYXlRbFI0cllMUS85Mm82V1FEZjRiNXFicWdaVHgra3JnekllNm5TaDhL?=
 =?utf-8?B?UVo2eTRzcUhFVThqOVBJOHphL1BQei9BSzJpRVM0aFBobmZVTnJ0Q3R4VWJX?=
 =?utf-8?B?aDNlREdzWTBySnB6NHgxMVo5VVE2T2c1TGJCSUQyMFFxMWhzdklhNU96UlA1?=
 =?utf-8?B?aUw3NURTWTlOTzVSSjNtMUY2UklZeHRHbDdmc3Z2T0c3OVdseUNPc0xreGpG?=
 =?utf-8?B?MUJ3QVQvTE1HL1hkbUprajlXb0gvdE5oMTFmWkNNbmQ2UFZNYmQ1RlpqeU1r?=
 =?utf-8?B?eFR3YVRxRlppTkptdEI4dnhDQmY0dk5WWkR4cURmMHlmaFRKN1o0QTJSZEtU?=
 =?utf-8?B?T1QrNHVucUczV2o0Qzd4cGUzWll5WW5SdkhsTGR1WXdsbDZ4amZ5M0xHWHJ6?=
 =?utf-8?B?emVDMEVGM3ZScXpQOU1OdmVkbmdDTlpsRmhWWVhiMVBrcDZEN3JRR2hMM0N5?=
 =?utf-8?B?WUdHRGh6STJ6Tm04a1JEOEhwTE1BOVNPcFJEVjdNbXBTMVFJRG1qWWZVL2hK?=
 =?utf-8?B?Tlo1cjRwb2NjRkZXbDFVRUxKV0loNDF2UXU4T0xTa0dqUlI0K2NObVZ0cjZ4?=
 =?utf-8?B?cGRwTHo1bGg1WkhZZG5lVS9YL0ZIOW5jZ1cvQ09ucGxtblVrcWVXck16ZmJh?=
 =?utf-8?B?ejlPTTdvZnZkZUhzOWZHUUJ1QU9wRkY5TWdPM3NlMG84QnpMQkVvZWFGQmNu?=
 =?utf-8?B?bHhKT0hOcldscTFHOFlEYlVOTWhxeTlhYnUzTVpsS3NWeDhVSmxEQVRTS1Z4?=
 =?utf-8?B?OWkwZlZJUmhENnMzRFRkcXJZRnlUTld4amdZSjZZRndiZE5zNit4ZmtYL2lp?=
 =?utf-8?B?R1hxOVJLSFBZZm1IVDBSSytWa1JsTjkxLzIrbUN6a055LzJHQU9lM2pKVEpt?=
 =?utf-8?B?NkFUTHRndFhpMVQybFVtY0VheUpkTVBYRmJYekU5eWZiVWluQUx4aTB4dkFB?=
 =?utf-8?Q?lWpqn1T3c6lOqZEpV+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b937ad02-deea-4ac2-fec1-08df28f972f6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:13:15.3322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vz0U9VkivKEx1UR5mkR+tcIdE011erokbWVWRpatJhx5ite685c15ZKI6M38laUj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB047581
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



On 10/12/26 11:24, Sunil Khatri wrote:
> Use the spm vmid which is dedicated for the SPM only and update
> the function paths accordingly.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index ed1efde29a9a5..3617de2368d5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -551,9 +551,12 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		r = -ENOENT;
>  		goto unlock;
>  	}
> -	/* Remove from normal round robin handling */
> -	id = list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid, list);
> -	list_del_init(&id->list);
> +	if (!adev->vm_manager.spm_vmid) {
> +		r = -ENOENT;
> +		goto unlock;
> +	}
> +
> +	id = &id_mgr->ids[adev->vm_manager.spm_vmid];
>  	vm->reserved_vmid[vmhub] = id;
>  	id_mgr->reserved_vmid = true;
>  	mutex_unlock(&id_mgr->lock);
> @@ -577,8 +580,6 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	mutex_lock(&id_mgr->lock);
>  	if (vm->reserved_vmid[vmhub]) {
> -		list_add(&vm->reserved_vmid[vmhub]->list,
> -			&id_mgr->ids_lru);
>  		vm->reserved_vmid[vmhub] = NULL;
>  		id_mgr->reserved_vmid = false;
>  	}
> @@ -627,6 +628,10 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
>  			&adev->vm_manager.id_mgr[i];
>  		for_each_set_bit(j, id_mgr->vmid_mask, AMDGPU_NUM_VMID)
>  			amdgpu_vmid_reset(adev, i, j);
> +
> +		/* out-of-pool VMID, not covered by vmid_mask */

Better write "The SPM VMID is not part of the normal kernel pool, reset it anyway in case it is used with kernel queues.".

> +		if (adev->vm_manager.spm_vmid && AMDGPU_IS_GFXHUB(i))

If would be nice if we could rather come up with a loop over the GFXHUBs only.

E.g. something like this:

for (i = AMDGPU_GFXHUB_START; i < AMDGPU_MMHUB0_START; ++i)

> +			amdgpu_vmid_reset(adev, i, adev->vm_manager.spm_vmid);
>  	}
>  }
>  
> @@ -711,6 +716,10 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>  			amdgpu_sync_create(&id_mgr->ids[j].active);
>  			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
>  		}
> +
> +		/* out-of-pool VMID; create its sync here */

Something similar here.

> +		if (adev->vm_manager.spm_vmid && AMDGPU_IS_GFXHUB(i))

Same for loop here as well.

Regards,
Christian.

> +			amdgpu_sync_create(&id_mgr->ids[adev->vm_manager.spm_vmid].active);
>  	}
>  }
>  

