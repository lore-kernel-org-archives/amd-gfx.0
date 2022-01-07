Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07BBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 15:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B40510E48F;
	Fri,  7 Jan 2022 15:34:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2317010E48F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 15:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsulOulDl1dXh88QAcJuZCu74/yL6+gLXLqMAsfAqiEJVH9GRVsbsKXQN291zK77vO3pyLAZRl5woZfY7IFBetyA/FwQ9ui6U4v0J7weHZzePJbj0thxlwN+K1bAcpEr3/FUDgM1vKevXh9p5nHzIcZ1plvD7d415VG745VpP/k58DeMUcDNN4vpATF7218mmQKtZUujzhdDpIR5XBAaJoQzxTCv9vXy0fY5tCjgjBNxOMwVuVdwoQJgNHE9XM1RMXDs5adleGSaZUm+0j8sUrEnsF+zXVQVMwhGlctF2P57Q9sz6WCeHbzfwdIRQNwpfcvSrMYD2ttSIISjz/mcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aeg5rsecsjAxzZUiys+mKVrfVcSIQ1Ss99z+eM7Xo8I=;
 b=HCV/1VohMbUMrA/XY3D8jLs+2Z8lhDZOMj6Y6n/tZPnjOMS9u5zDLC8785n/4/VtWT7F167pea3sJMdjAgpYKqeGXj3Kg53GAJiagiWqd3GFZsnJm+YjAQhtErMp/iIALrJaPBQyXAoUSTcc89+kUphgLFUwzMRs1X797ESPQCRJ+esBEZD9GlHMjVRH0U+iKefX+bFQl62iHlJz9jLY7NK7lKN2DpbKgI86snI9pgsr/eh1JaTHjXNnRhyB3QIV0w81+WCTuByxbgpV2OBar91KQhDt3iWEMjshCUsG5IBT5eYdvjjX07DlRI65is4cwEhCLpXCC5wdvdGRqbHp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aeg5rsecsjAxzZUiys+mKVrfVcSIQ1Ss99z+eM7Xo8I=;
 b=aGh+fWxZVHueJicBzbUdmejE1T/m/k581atsq+WGCy3+eVMrtKigyvJA+nb5UtqZTmPGxjsvRFa4t3AKa3Qkn78ulKzm74YCAZYz5KFgUUBSFpe3Ux3gLGlkq8ziOcmQBb2CWz9iZ8gL2jBT+AV0X96Y6CJzX3yPScqc4AAVUDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW2PR12MB2489.namprd12.prod.outlook.com
 (2603:10b6:907:d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 15:34:49 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 15:34:49 +0000
Subject: Re: [PATCH REBASED 1/4] drm/amdgpu: do not pass ttm_resource_manager
 to gtt_mgr
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220107085115.8820-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7acac7b3-5c7a-c52c-6f75-5a2c148fbe26@amd.com>
Date: Fri, 7 Jan 2022 16:34:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220107085115.8820-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6P194CA0059.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::36) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c145b2a5-2fa4-47cb-1f02-08d9d1f33dca
X-MS-TrafficTypeDiagnostic: MW2PR12MB2489:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2489E6060C5386E9254144D0834D9@MW2PR12MB2489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4NqvfZnkXG/OmqQtOaq58d75FTD76SiPjpwm2bWksgFdJHVgQxhkPg/7H5vwBjSyFFhgIGhq4lb1hV2VcAOeAL40P4+UhNwL0K7tSQw1QPfzMZtXIdyYob6sgUKTHTdPaX1HDKQ37pAU0YFKLLL/hvdaCsMhrjn9teA9oFQMFob/D5GpeAyUguS+id2JX+r1JaOwqzwb4j24a+Ic7CEb1dhKabypaVQqdVSBNHuFo/Emv1TcHfSYkvc+CgwUSdarhfqRUl4yOFZhVYoMgxVydBIko0PF8csnhd56jafw6vHe1VrAou6w4bqEDLVUo0rD1YkwFqCEW+3h1HIscv+fUpSi6AS2djviH2eH72kH6PYk6FATemNYQCfGpMg7j3FYiks8jj7iEuiJxBcQ3FFY51DUfy4pbmgX3HMTsfPDGtdz9tIyRygEsfLAcEZrx8ZMifcUi8EI0eQ/zpp1n9E19YvaVTne5XrL5mTYKIj9w4eNeIeg26SbISktsbWc+Ptzy2LCZz2zno94q58PgFcnT1h0fDemWf0G4YPiwVfy7FQBrsuLMC4mpt8hNkP3lSiHoVzGtEhuZrywgsbfy35QMzy73cZYG9oy956Vs6rTbJsiqfnNOpf3M0/AX66AMSeI8gP+nw2UMolGmgPjhbXnuv7eWnkHSBZSkJjntCiqsIY/R/jC06fGxbTxq1JQFXCnb5t4FXsbyH4ZNarLy9c8FKPQ2ymVrseyIVRhYsL6RU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8676002)(8936002)(36756003)(6512007)(86362001)(31696002)(6666004)(66946007)(6506007)(2906002)(66556008)(66476007)(6486002)(83380400001)(316002)(38100700002)(5660300002)(4326008)(2616005)(508600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDR4MlVCRE5FNzJ4UUt2K2MzNGdLQTdjaW1Hc0FRZ0dPdFJQcTV5RjFEaUQx?=
 =?utf-8?B?andSV2dPaUtKcjV0Q251YUsyVWJzbzhXTGprTnU4bXBMU0sxWnhTdEdYSVpr?=
 =?utf-8?B?ZVdOY2gxUHN4WVpxUTdFYXJKK2hhK3pCcVl2bjdkdXh2Y0o4T2MrbCtyQ0Ni?=
 =?utf-8?B?WlZuaU5vU2lzOHNlNzFRT2pFczZVM2FzWm9XdGQ1VmpDVzlnSTc3SW1SZzd3?=
 =?utf-8?B?SmZXSnArbEUvYjZ3UFRkN3BURUNGcjVFK0lYQlR3RWpwMGMyRWVFaE55TDNL?=
 =?utf-8?B?Qjgzd2pNUkxXTlg0eFRWaDZVc0ZYWk9zUElJbU00c1JUbUx2REovdGJMN1BK?=
 =?utf-8?B?dUZ6d0lmN0xMSTlvbmpHWlFVSWZoc253NHFLS1FaV0dtUkJOQWJSTUR3aHc4?=
 =?utf-8?B?ZG9DU3h0ODA5a0pQOVltTWx3SkFXUFhudGEvbEM0dzJ5M2lvb1RVTE9tc2gv?=
 =?utf-8?B?dXJLU0Nac0FBV2l6TjNlaUF1SHQvRmx2Mk5FNXZiREltL3l4c1ljbTJXZUtP?=
 =?utf-8?B?NEdEVHZ0Ni9MWlp5T0ZKdncrdW5sVHV3MmRsejBhVWRxQzY5WDZlM0kwSXA4?=
 =?utf-8?B?cXRIZHJDRSt6SFBEMmMvWWdCTVI5bGRxay94SXFnRkp1WjFUVXczU0RxWUU5?=
 =?utf-8?B?c0NwdXRLTDk1RGNDOWhrQVRoUTJDUW43T0d5RWpOaXBTMmRVZnpVYlovekhV?=
 =?utf-8?B?UDNZdkIzNHI2RjdmVXhvbW5DQXNiOFVCTldSbXpsTUdHdWZmN1g0YTBQRlM4?=
 =?utf-8?B?aU1QV1VIeWpUWFowQ3lrWEpzL2ZVMVB0eDNrdFZMMDV5dTFKZENIWDhpa2lT?=
 =?utf-8?B?TkJtQzVkemZOZ1NvY0hMWHNFYkZKd2pEMTNDQ2NMRXJIamhWa0cwNFdEcnJ2?=
 =?utf-8?B?amh5dmJpRDhZcVVLendTWFpJSXFUZ00yajdqYjZQRkptM1laQ014MFJVbFpL?=
 =?utf-8?B?UFVrSURDZ3BvT1c1d1VWd01ZeWE3dnptYzFaMy9UVlZxZjVtMnJsQ2xRN3NJ?=
 =?utf-8?B?Y2pOUy9PbHB4VTFqT1hxcEExcWJoQ0MvTVRFS3BkRGJISGV0TmQ1eTlwUEFV?=
 =?utf-8?B?K2ZPL213RHg3QTArOG5wRW1jWnlqOVpFaWNZT0Z4bzRob0pOK1VQcXdjUUlv?=
 =?utf-8?B?REVqaFF3Y1dpbURhTFQxOVN4a1pDalRIdVVpL1ZNWk1INGpsbXdtQVlGTkZi?=
 =?utf-8?B?djRjaG5PcCtjNTFpY1lzK3p6bXFTQ3Bhd3NCTEorZG9teFltSXlnbEE5cGwr?=
 =?utf-8?B?MDN6VEpoT0ZBaTNlanRBTFFVaENnU3p2Q1ZnczJoV0JxeFVmWVhhN2w2K1Ji?=
 =?utf-8?B?NWR4QUFtaTUxcnIxL1IxaU5ObEErMm9DV3dtMDJqWUZLVzlSa2pTbUFqUlk0?=
 =?utf-8?B?b2EvTnpoc1Q0alJlMWFvOHVMMThQRUZUYzNXZFVyL1E3d2NVbTdxVXFQMm1E?=
 =?utf-8?B?L1p4MWpGQ29QSTBTSTh0L0tWQnVNSWx5V1IyQUJpQVpYa3FPVkJHeHRTNDhD?=
 =?utf-8?B?aDVpWEFOcWlwRDJGcFNOcXB5czhiZ3R2dUxnN29GWlZ3SDB3ait5SkxINXU0?=
 =?utf-8?B?KzNHaWdmZGtvcW0rV3dmNC9qMW01VnlPZkp4eGNpVTFOc2xNZHgyNk9yVmox?=
 =?utf-8?B?VkJ6NTVqdmlheGQ4Mmhsd2xiQ25NTmZ4Mnd1VVZTN3F6T3Q5SG9CczBSTGsx?=
 =?utf-8?B?WmszN2Y4eWVCY2diaUE1eUZCUXpwZWV2QlRqazFUK0tRdS95YTd6QzhCcjhO?=
 =?utf-8?B?V2hMVUZ6RXhFYlAxRG9XZ0FkWlo3NUtrcTdmVDdnaUhkeUh5TDBKNEFXOHkz?=
 =?utf-8?B?VTAxTHY2bUYwUmRjcjM4bEJIbjc5ajc4MmlWYk9ua3JCWFJ4dWZRQ3lxTmpH?=
 =?utf-8?B?bjRXdTlYY0VDTnZJR0tpKzhwbDgwLzJFLzE2bldPZXd1UXd1ODc1Sy9LWUNV?=
 =?utf-8?B?aVk1UW44WTV3L1RRZHRGYm5pamhJa2NIa1ZCT0VMWWlIdEt6QlZhaE5RVk4w?=
 =?utf-8?B?bTVHSmZXZU9zZXNLZ2lwb0ZOd0FubDNCNTY5a1V5SVlsMy92Y1ZNYmlTWkdX?=
 =?utf-8?B?V21DNU12RU95S3MzemNFSTVybHRRVk9aS3lsbDkyWHh3Z0NsUUgxTUxpMWN6?=
 =?utf-8?B?dGlFbkg3ei9HQVBZOEJ4NEQ2Nk14UUlad2Z6TTU4dWluU3ViNTRQSW9kbktV?=
 =?utf-8?Q?vwZlTJSiVzmR3v5hNOfoB20=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c145b2a5-2fa4-47cb-1f02-08d9d1f33dca
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 15:34:49.5112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qz8pDFuZHEqlyIHbf/TUMEKFKvAPDtyFayRuNMEBZbyo5B0g9ADFemJPglBIBINX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2489
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
Cc: andrey.grodzovsky@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I've just pushed the whole set to amd-staging-drm-next.

Thanks,
Christian.

Am 07.01.22 um 09:51 schrieb Nirmoy Das:
> Do not allow exported amdgpu_gtt_mgr_*() to accept
> any ttm_resource_manager pointer. Also there is no need
> to force other module to call a ttm function just to
> eventually call gtt_mgr functions.
>
> v4: remove unused adev.
> v3: upcast mgr from ttm resopurce manager instead of
> getting it from adev.
> v2: pass adev's gtt_mgr instead of adev.
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 22 ++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 ++--
>   4 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3aab187520c6..58b9a5176082 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4357,7 +4357,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   
>   	amdgpu_virt_init_data_exchange(adev);
>   	/* we need recover gart prior to run SMC/CP/SDMA resume */
> -	amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   
>   	r = amdgpu_device_fw_loading(adev);
>   	if (r)
> @@ -4677,7 +4677,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   					amdgpu_inc_vram_lost(tmp_adev);
>   				}
>   
> -				r = amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, TTM_PL_TT));
> +				r = amdgpu_gtt_mgr_recover(&tmp_adev->mman.gtt_mgr);
>   				if (r)
>   					goto out;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index c18f16b3be9c..9151950e0cc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -77,10 +77,8 @@ static ssize_t amdgpu_mem_info_gtt_used_show(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	struct ttm_resource_manager *man;
>   
> -	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> -	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
> +	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr));
>   }
>   
>   static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
> @@ -206,14 +204,15 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
>   /**
>    * amdgpu_gtt_mgr_usage - return usage of GTT domain
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_gtt_mgr pointer
>    *
>    * Return how many bytes are used in the GTT domain
>    */
> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr)
>   {
> -	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> -	s64 result = man->size - atomic64_read(&mgr->available);
> +	s64 result;
> +
> +	result = mgr->manager.size - atomic64_read(&mgr->available);
>   
>   	return (result > 0 ? result : 0) * PAGE_SIZE;
>   }
> @@ -221,16 +220,15 @@ uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
>   /**
>    * amdgpu_gtt_mgr_recover - re-init gart
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_gtt_mgr pointer
>    *
>    * Re-init the gart for each known BO in the GTT.
>    */
> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
> +int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>   {
> -	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> -	struct amdgpu_device *adev;
>   	struct amdgpu_gtt_node *node;
>   	struct drm_mm_node *mm_node;
> +	struct amdgpu_device *adev;
>   	int r = 0;
>   
>   	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
> @@ -267,7 +265,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,
>   
>   	drm_printf(printer, "man size:%llu pages, gtt available:%lld pages, usage:%lluMB\n",
>   		   man->size, (u64)atomic64_read(&mgr->available),
> -		   amdgpu_gtt_mgr_usage(man) >> 20);
> +		   amdgpu_gtt_mgr_usage(mgr) >> 20);
>   }
>   
>   static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 651c7abfde03..763de822afa1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		ui64 = amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_GTT_USAGE:
> -		ui64 = amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
> +		ui64 = amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_GDS_CONFIG: {
>   		struct drm_amdgpu_info_gds gds_info;
> @@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
>   			atomic64_read(&adev->gart_pin_size);
>   		mem.gtt.heap_usage =
> -			amdgpu_gtt_mgr_usage(gtt_man);
> +			amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
>   		mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;
>   
>   		return copy_to_user(out, &mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 91a087f9dc7c..af1c4e414979 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
>   void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>   
>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr);
> +int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>   
>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>   

