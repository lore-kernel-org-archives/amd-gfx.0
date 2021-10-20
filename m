Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34254C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 06:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC9C61074
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 06:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDC9C61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36166E210;
	Wed, 20 Oct 2021 06:50:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4866E210
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 06:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyu5QDlh46YNYY3RsLaqcDeKo/OOJV+SjyOTPRrvx44e0XqFLYxBxKjkW7O/Wcu18actOy31c1NcEU72dUVsjUCcKqIlD7jMyFucXMp++uZ3RPdyfZy/+DcgJ1ViL7x9XKEJQPRYmie2qQGJfljahD7J6lNoNWcHSXSafraRkqx3QQ/pfshoxmjqNUOoMJzIwgo6ITWRA/yQxAq2LkLIIuIUjt4bIzd7JezMz0iDtyxN0Mom2VvzgXjXhfze5XjC300WNtFyB5+vdiwil1BF164pswrWFN1+TLHa+uR5cxI8ee6uvml7iUZBBl0Yt7B82UCC58iS/fevNWdsNdebyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crjRwmDhzLuTQLqwQX+8kFdI1qslepOIarOALO71LbM=;
 b=E7Etvl0LL3HKbIIhKYW2qZjUAxK7xWPctLWeJ+q9V8bqRxxU+8l4kxKZNRTVzTnGkpJT8zr2k4ZRnEXubnZZCPciLwWZYmgO4hn/V1+8FAlGfTFwVg5IFYxhF8O0kw1k6KJlJY/aMSwg/9tMzUr3z6wDtSWtX/3Y/mo/I0knVVqOnPGXrnmHWK7azKkQgcAB1xPUx6lxFqviHiwKwS07SLkU6M+1hiF2dJ5v5H1l26KTMl7Bv3hGxBvF1BJmMG9EZ0V9+0phn8YtYm3Q73d1MTgVGrN0eTbH2Xk02hp3wjU+8iDcsue0a3qx7SR4aSXgV8iK0Pjx3UYVAYJJgTrHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crjRwmDhzLuTQLqwQX+8kFdI1qslepOIarOALO71LbM=;
 b=zpgxltWk3qtbcK7Qys7107j+PGKsReTGtvhxt5e3aF9lVgZ+FxsVDpY7KjgDxaMWxWzaelZ37CZOYNKRaY0hGwcmIIrF3mauQS4XrkJCUT4MdZPSuevCt/P5HD6MT73xMWO9L3o95rbLdpO3ju5KLlMGKnXV82BGG9aQysCgxdA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1151.namprd12.prod.outlook.com
 (2603:10b6:300:e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 06:50:02 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4608.018; Wed, 20 Oct
 2021 06:50:02 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: do not pass ttm_resource_manager to
 gtt_mgr
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6c3e8c81-480f-ea2a-a98b-69866e6f3ff3@amd.com>
Date: Wed, 20 Oct 2021 08:49:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211019181449.12356-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR04CA0067.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::14) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:6048:8836:7968:5df6]
 (2a02:908:1252:fb60:6048:8836:7968:5df6) by
 AS9PR04CA0067.eurprd04.prod.outlook.com (2603:10a6:20b:48b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 06:50:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5867c6b1-2ea1-4b6a-f16b-08d99395d737
X-MS-TrafficTypeDiagnostic: MWHPR12MB1151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1151C36E38DFB7F6484D35E983BE9@MWHPR12MB1151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8mog2way426AOmCxGwA+UsHRzFL5IZyxQ81R/4GICyVabKcRJw/29AeJDuig1ozsBbh+jQVJfS/BLgIXu6FhNoGJ1vv5PYODwt6+TBAnSo6igsVOrX6cLgtI/E+BNsxqZBvju31/yqFpxg2uj3/017wnbdESFaidjYSxJJM5uLF6osSCCcH8Rc6pDs4j8hIFUTFfUTnAE6fp71HAMnP5FWbcWrQzcDwul5yNxLboq9aa8gyb953WC/Ewv/lV2+JROc2hRrVZKrocBnnM9sL83zQm9u780nKLcxMsrMUZ5Jcin0zWutxASRd8JLPtkFYYQy4xMZgRAIFrBuRVEsyIriN53Knv3mGVMtsqolVQ6fvltaGJ2GjNR7aeu64cTcY//yWiDMPVtQvMcYz3KRbvhj4MOO7WxfCa2T2nnN4R+3ZLCa1xQXls6TlQgbTe6q+01Tnn47JuTRA4GnjO3GLL32OzoRimt/5+UIvlRUT++USjw3tIfB0ci0q4e0L/hVz7IDZaweWMWedv84p0YlFB4WF+37E9ijLhuSVf/t66rAPYDHnEWXDUG4SYTXhuh/bhfF20c3MsPUpyVHdvbLldBkss3C6iT3SYzMkk5hlmGxy3ObZD4jMjSSTChkxLUbZB7YQBFKv52V0MzcbeAuNzjnW8bA0eQS1tckxOuhPkdniK3wPQXTPLgqBdev/yl9524kH8QHB+sfZQ9pv7SJQdh5S1Hv7dajwSRRkZHiKQ/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(66476007)(86362001)(8676002)(316002)(36756003)(66946007)(2616005)(31696002)(6486002)(66556008)(6666004)(2906002)(5660300002)(31686004)(38100700002)(4326008)(508600001)(83380400001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXhKNjBzckkxRHNNbjVvb3d5azV6Ylc2aGFxVkNTNUlPU0U5ZEJsUkdwNUxC?=
 =?utf-8?B?NHdOUXJXbmdlNEhIajVaSDljV3dOeDIxRmtCV3psc0hGM0JyNVNhMUNDdkFw?=
 =?utf-8?B?bnE1d1g2QUdHSWRKUk02UEQzcVM1Rk9MWnhnNTc5cGVBSytjWTdsV0paWUoy?=
 =?utf-8?B?MWlybGpmdmVhZndHZVMvL2Y2R2dUUm5qOUhVd2hlcXJzN2VRV1Nyc2FhNlJj?=
 =?utf-8?B?OHJjVjRMZnZ0ZE9Vd0M5N3ExR3FTblFCZHpDbjBaLzBiZlQyL0E4MDVKN1VZ?=
 =?utf-8?B?c2x3R3JnMXhCVDFORlB1MHllVjVqc3o3ZTNmVHJRd0gyOW04V0tWc0dXbW4w?=
 =?utf-8?B?S3NtU3FBKzd4VjJ4YU1uZWM4ZlovSUpKU0ZnMVltaFJhUXZFZTJXN25sVmpt?=
 =?utf-8?B?TmlhcDBheVczWlk5V2Rra2hYMG1INVhJeDVTK2RmbWQyNzgvWE41U256aWFN?=
 =?utf-8?B?ckVrOThLUHdDNWR0cFcrcklyVGJhajNrNHM3L1JMSkZmRmFJMXdlNVpYcWR1?=
 =?utf-8?B?bGtubXd2L1dXcDlnczc3OC9hdU1Rd0ZDRGUzYzdRcHN1Y1M2OU5FSCtXaGhU?=
 =?utf-8?B?cTIvNnJGR0x2REFqdjd6dWlWOW5WQzZyTG9iSEhnWnRsdUErdDZQbm9oWURR?=
 =?utf-8?B?UE5KaThNT3RBaDV6c3c5aXRIRWdTS09iYlRaSG1PdG5RRzJhY3BrRytJcSt1?=
 =?utf-8?B?REtZY2NEbWo2UWIrNngzWWZYdzgvTUo1Tnl6bnBKdGNLMWJ6VmpGTlZmcTZV?=
 =?utf-8?B?ZVUwSjFFN1NEby9STzNZSTByN0RxVS9GVHloS3FnYm04NGVEMDNzd3NDYjI0?=
 =?utf-8?B?anNPUnJTVTl1MWJBQlUyemJ6YlVzRUU2NDI0L3ExNlRxVHd2Z2ZVS0owZ0Yz?=
 =?utf-8?B?ck5CUlFnNk9yMWVEcjFaeDUvZm8rNlhpc29KeUdQU1BCcmZFTERjQTA1dUtC?=
 =?utf-8?B?eURtREFMZExZWUVTTlp1RFh3U3pRN2p4NE5mVU83cjkzaDJCRlVWM2JzL1pJ?=
 =?utf-8?B?VDRnOUdwbHlRQ0orekFqOUdhbjZlRmpDd3RycFNFNjJNS0ZiUG02SzFISlY4?=
 =?utf-8?B?Wkd5K0RBeEFHUzdINlZTd1liVDJ4c3JGVXZOaUNYNnZMTXlTZWlGQzFWdjQ3?=
 =?utf-8?B?NjR6TW5lYW82eE9hOTMvNCsxUjgwQ2dCVmpBYURRWUlsN1VxZHF3RVdOTnJI?=
 =?utf-8?B?cUFreTYxVjhYYkJaWG9LNjRjWCtXZGxwRFlEdkVoZWp4TXNnWWwrOGFobHlR?=
 =?utf-8?B?S01NbkVRZGhyRUVWM3R5KzgrMmpCNG9YTUlEMG0wY0RZb3RxOHNnRGFzcXBN?=
 =?utf-8?B?YWR1Y2N5RGNyZnhvM0gzVVl4NUxOclAyV2hieG9DQ2VnM3V6QzRJZkM2V2pl?=
 =?utf-8?B?bGlxeGlaVzlYZzdCWCtiL29MZWd1Y1dVU3B6U3hWdlNyVjhtbDljUFhvSHp0?=
 =?utf-8?B?ZE5FU1pZVlRQVk5oUHZCTTNiVWNFdFRoeWRhOEh3Und3TVBIcTZZWTdick5L?=
 =?utf-8?B?SU02MjhUUXJMenV1QmVmdmc1N1Y2VTBUem0yOUFiTnNFbDhHS1U4YWpXeVdo?=
 =?utf-8?B?S09aZTJ5WEthRUlaZ1BzeWdXR294SDd4c0hBM3FUYm0ybWc3RmNMdi9jUFRK?=
 =?utf-8?B?c0lmZHVnQk1JZ1dYNFVzS0kxc09RMWdyajEybFFMMlNBd3pkRXZQTkZsM28v?=
 =?utf-8?B?Z0QxL3JvRU1ZSDE3c0RiVlZ0UjlpWnJER0pNWmF6S1ZOZVpteCtjZXdJWmRi?=
 =?utf-8?B?dCsrcEwwaFFUNFlJd1dKdEl4Z1E2UVlzSlJWbWVCNGs2NHhmODBXTE5BU2FT?=
 =?utf-8?B?OEF6d29OWGNGUktZb2JwNVJqSy96MVJRUFI5eVp5L3VybWRkNjRqekRFTEsv?=
 =?utf-8?Q?UuX6BIoEdWyRX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5867c6b1-2ea1-4b6a-f16b-08d99395d737
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 06:50:02.2852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIGql3n7fvF0JHqGHM4vrb7qL5YhbXerYKniiAIbw+Hj4eNR2N+KOsYP8vQt62bY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1151
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

Am 19.10.21 um 20:14 schrieb Nirmoy Das:
> Do not allow exported amdgpu_gtt_mgr_*() to accept
> any ttm_resource_manager pointer. Also there is no need
> to force other module to call a ttm function just to
> eventually call gtt_mgr functions.

That's a rather bad idea I think.

The GTT and VRAM manager work on their respective objects and not on the 
adev directly.

Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 31 ++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 +--
>   4 files changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 41ce86244144..5807df52031c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4287,7 +4287,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   
>   	amdgpu_virt_init_data_exchange(adev);
>   	/* we need recover gart prior to run SMC/CP/SDMA resume */
> -	amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
> +	amdgpu_gtt_mgr_recover(adev);
>   
>   	r = amdgpu_device_fw_loading(adev);
>   	if (r)
> @@ -4604,7 +4604,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   					amdgpu_inc_vram_lost(tmp_adev);
>   				}
>   
> -				r = amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, TTM_PL_TT));
> +				r = amdgpu_gtt_mgr_recover(tmp_adev);
>   				if (r)
>   					goto out;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index c18f16b3be9c..5e41f8ef743a 100644
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
> +	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(adev));
>   }
>   
>   static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
> @@ -206,14 +204,19 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
>   /**
>    * amdgpu_gtt_mgr_usage - return usage of GTT domain
>    *
> - * @man: TTM memory type manager
> + * @adev: amdgpu_device pointer
>    *
>    * Return how many bytes are used in the GTT domain
>    */
> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev)
>   {
> -	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> -	s64 result = man->size - atomic64_read(&mgr->available);
> +	struct ttm_resource_manager *man;
> +	struct amdgpu_gtt_mgr *mgr;
> +	s64 result;
> +
> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> +	mgr = to_gtt_mgr(man);
> +	result = man->size - atomic64_read(&mgr->available);
>   
>   	return (result > 0 ? result : 0) * PAGE_SIZE;
>   }
> @@ -221,19 +224,20 @@ uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
>   /**
>    * amdgpu_gtt_mgr_recover - re-init gart
>    *
> - * @man: TTM memory type manager
> + * @adev: amdgpu_device pointer
>    *
>    * Re-init the gart for each known BO in the GTT.
>    */
> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
> +int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev)
>   {
> -	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> -	struct amdgpu_device *adev;
> +	struct ttm_resource_manager *man;
> +	struct amdgpu_gtt_mgr *mgr;
>   	struct amdgpu_gtt_node *node;
>   	struct drm_mm_node *mm_node;
>   	int r = 0;
>   
> -	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> +	mgr = to_gtt_mgr(man);
>   	spin_lock(&mgr->lock);
>   	drm_mm_for_each_node(mm_node, &mgr->mm) {
>   		node = container_of(mm_node, typeof(*node), base.mm_nodes[0]);
> @@ -260,6 +264,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,
>   				 struct drm_printer *printer)
>   {
>   	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> +	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>   
>   	spin_lock(&mgr->lock);
>   	drm_mm_print(&mgr->mm, printer);
> @@ -267,7 +272,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,
>   
>   	drm_printf(printer, "man size:%llu pages, gtt available:%lld pages, usage:%lluMB\n",
>   		   man->size, (u64)atomic64_read(&mgr->available),
> -		   amdgpu_gtt_mgr_usage(man) >> 20);
> +		   amdgpu_gtt_mgr_usage(adev) >> 20);
>   }
>   
>   static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d2955ea4a62b..b9b38f70e416 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		ui64 = amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_GTT_USAGE:
> -		ui64 = amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
> +		ui64 = amdgpu_gtt_mgr_usage(adev);
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_GDS_CONFIG: {
>   		struct drm_amdgpu_info_gds gds_info;
> @@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
>   			atomic64_read(&adev->gart_pin_size);
>   		mem.gtt.heap_usage =
> -			amdgpu_gtt_mgr_usage(gtt_man);
> +			amdgpu_gtt_mgr_usage(adev);
>   		mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;
>   
>   		return copy_to_user(out, &mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 91a087f9dc7c..6e337cacef51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
>   void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>   
>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev);
> +int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev);
>   
>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>   

