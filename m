Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283E1C54EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 17:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6438310E1C5;
	Thu, 22 Sep 2022 17:15:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CF510E1C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 17:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgl5FvodTUGrvnU2ctjMQbjPj2u456/yF0dO5tb+E5b79C74mWquOkVNNY5+yzw5DolwBePSVzNeoV4+Uigk9sSSnbZGqREBMynW+Bxmo9f39aGqAPFy6jam10RdNd2Sxhvu7EkSKi2CfiL1S7YhEBidmNm49vtjSI5/tBb53ZK0cei1UWvmgB6yMLnjfUTVhs0v6AxG0U1t+Kx1Y+ZU8otxlqKefTHhfNrJywVnJFt8+56SevdlD27nyfMMkFix602HSGbTYa8ABB0NOSCOHQyNqYrcH0P/pkU3LJRZjC9ZB7kYVI1XaOfdQEM4jIWOieYsLfin+WqkcvVbcXFPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJrpzD9JuuNZxW9QXJO9ORPk6o2WiDlVE27tJXVhkZQ=;
 b=NUyamq0iFTliP64Zyn3szde3SPsVc6lQ+1QX7y4czsymum1KZiHa+EPHaN09s1JdYylNWCSdv0q/vCqLKA9MjjxC9+Kv01PhqBcGZxkfF+ddmm0A1xDhpCOWf1nN5wpXCw0X9Cgt7IobaOBSwYZCkloL4NLE14XioVdsLj8x3U8lI1vfAR4UrwpySiTRXlNcZY7bQfvJ61Vmjjsw1WOzOR9vZhU1DdDqKjTAvqhAZx4VfkdcU4Vhm2VtvTSjnutghJNF5ktwa4PRTgsWvlAaNjox5PAq6cmp0IfrYvKDxU06YdAqf51XVVSNPO0w5YmXMLfEk08Z65D3I2GmEXHJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJrpzD9JuuNZxW9QXJO9ORPk6o2WiDlVE27tJXVhkZQ=;
 b=gspzkK3MMWOt1CxHuLSH+7UfdR45T1XxSI9yBd6h9OpszAKgEH/CyCKdkKV3RKq3gCH9cvOWWvaG0NYHzYgGSWJgAzKU3tn5JGM+4gU+9rHNsITpYODmbMeoPEpP1a3RL00CH+fK33RuSW/xzNoZrRsI7WE1Hikuf6W74653+00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 17:15:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:15:13 +0000
Message-ID: <807a60e1-7624-b824-dddc-31d532113b34@amd.com>
Date: Thu, 22 Sep 2022 19:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Fix VRAM BO swap issue
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220922152627.265948-1-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220922152627.265948-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0153.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bf6ccc-9282-4f89-38ec-08da9cbe02d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GF91U/gagYdlP//aCXuxQ5wAQ+WPRG30tpGd8NSlKzG7D5HMcyB4B1P+UWaHjoCxrvvsUEmw/+8lhPHxIJTfvo1G6LUbcn8nGukV9x/i/iiUjFImyq7lg9stZ4nxuaJT76QKZMzL9KZ5Amp11506yPgaJpq1AWnAWyBYxoM+3V5Ayoi+hEVi4Q0+BLFUKZNBGZod2Yyf2cVC2yoNHYLEXPPYeD3WiMjg8qQFFjIFZV4bhThmDO8PeYqR04rfzLjpOIq/diA3Kzw6HZ/CgtsOHK+hC4J5+6n8bqFPWueHaiIWVx8U+4SYftAplapODXMRGvA7KQ/A+PqJSLNseU2Wns2m+ApbeCCGYrugQNpsxiRAWxccveqrHrDvbpXeMwnSmDx6Zw6m1VEC9s3pONMs8UIPQK2YMZUJvVw3r28WSmrf+ReLhP6PytIOJt8YveQz4S8+juwd1gQdHRhriYM0DdtK+/BfvnLbgJADsfvi9KAbXWAGmRykx8hnaUei/ynok1BlLBNVcl/TYEYjWRn8yayan8GuovABUMIu4m5Ph8eL8z5Aj10xPMGuObEeO9DlDbFYeabyxfqcYF4CNc5BlesaUvwOgxql9FhHjTy9h6Kbl7JyZeC42OFmqsc76n0vdBI7cT161N2hNuIepW/f5p7SNqOz8RfaMbJ7Z6JEbJZp88794s0EWFZ0PxZjJX99FFLz+pWAwsSx+hhOzk9MSteSm0kB96CI1juryu2wg2IPAcgxwIQQdWtt67LQrU9zpmgpg99ephUQ1OTDt9mYZVIblA2MDWZVYfys0/0USYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(6486002)(478600001)(4326008)(31696002)(36756003)(5660300002)(41300700001)(316002)(8676002)(66946007)(8936002)(66556008)(66476007)(38100700002)(6512007)(2616005)(186003)(6666004)(6506007)(83380400001)(2906002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVHdVEvcG5KVmZ0bHpoM2I1cEZmaTZvRjhBTTcwZEwxSWZQelhLVmJaQ20y?=
 =?utf-8?B?elhnS3pSRHZyQnh4YzBEbWRMR3RZTWRYS2pmSnJhanR2QXIxVUZXZ1cwb0w4?=
 =?utf-8?B?bDlRRjMyMGhaSE9jaHRHYUJ2VGs2MWdxcTVCdHNIa2ZBbnpOU3JEQjQxK0RP?=
 =?utf-8?B?aXYwOHlzM1I1bU9WQWVHOUdLR1FKUU5nMWNxeWFxemwyV3MzNTlHaUszTENu?=
 =?utf-8?B?ZlZGeTYxdSs3aHVKdVJrUTBNbFBaSUtrMUNjNURyeC80L2I0dWJ0MUZvdlJj?=
 =?utf-8?B?VFc2ampPL29tNU8wUzRKczJ3YjBmN0dORU1KSHVkWjN5azVTdzhFT0pHSi95?=
 =?utf-8?B?YnUwbWZUMm9FTnJHWC9Bc1BhSEJWRGl3L3dVeE00N0Y4Y0ROV3RCTGErK0VY?=
 =?utf-8?B?ZXp5cVR4Y1Z1VmZCZ0dHckxhWUFpcUZoZHBtRm5URGxMNlk2UDFHR1I4S1Mx?=
 =?utf-8?B?YStrTmZmRHpLdytvMEorOFo1TkhaRjc0OHM0blV5T09tazRhN1FBbE0zNVBQ?=
 =?utf-8?B?dDVSTll0N2R3MUJiVFUvMjI4QStYWEtHelJxOERvTUxweFdlemdLZmJ2b01j?=
 =?utf-8?B?RDMxeUpyd3F5MW1mR1AyalYwUG1YQ3ZzWmZZbGI2dlI1RVZJNTBjY2dCVVhQ?=
 =?utf-8?B?Z3lxWXRreFhJU2N1MHd6U3RuRFpxa1h1RCtocjN3enJZM3pXTkJGQzhqYWkw?=
 =?utf-8?B?TlBEM1hobWduOE95YkU2OHdiUjRJM3dCelFTcTZmN3V3TTE1YzFVQStrNmZ3?=
 =?utf-8?B?V0NMNk5OUDZBdmE5QjlnMzh2akhNcDZJN1NKRnl0V2JsN1NSaWw4N1dyRTZp?=
 =?utf-8?B?Z2FtVmdLSWhRenJ5aXFQTmFiKzBKNWw5NkthbVpBb0s0VUh0Z2QzcVozSkhJ?=
 =?utf-8?B?K0xKUjcrZjV1WjAzZnBBRkdGS2doTytQaWc4aE4vTkZ5dmhFcWlSM1JBb1pQ?=
 =?utf-8?B?eGgyc1NvNVhMUWp6ZHg0dktWTy9GcUIvV05CVVpkUkpBMUkrNk5QK3RSd0cv?=
 =?utf-8?B?V2FBaGRBYTFrbDgrMzZVbmNRV2JRUGpWd2ZBM1RXbUppRmNpM0YyMGRwSjhN?=
 =?utf-8?B?NXNEOGJrWStsUnl2UTRDbEJHRmdwTlR5MG1IbkZ1R1JGNE9ERnJvZklOdTda?=
 =?utf-8?B?ekJrVWhCY2dyYUVLWEdNL2tadUdkZVF2WDgxVFpLWDBhYTdsYUhReEVWL1Bi?=
 =?utf-8?B?TFU2YkQ0SFEzY3lDNkpUSFhBbTYvRUR1aCtudXRzNkJpM0hHREpBUzBGNEky?=
 =?utf-8?B?UEFadzJKR24waGY5ODd2YVJoREw4aDNRSHNJdmloclkzaExuSWptdHo2Q2tP?=
 =?utf-8?B?Nk84Q0VocHZ1dDZCNHlib3VzM01tSmJadHhUOFE1akx4TjRhQnc5a2NQQ2lN?=
 =?utf-8?B?YWhYNEtTeEtFU0tUS0ZmZkdPRFBnSDFKYnBUM0p1UjVPalNjTnJXZm5hZUZ3?=
 =?utf-8?B?ZTY3TXQ5ZHBWOFhjYzZmWDdWaGJWdFV1SUp2K0VYT083RXRhbDhrZG1jZWRT?=
 =?utf-8?B?SjErMkV6MEhKMXNXUjdrcUJiZ3BkekpOOHVPMGdKaElCc2hZNmsvN2lsQlZC?=
 =?utf-8?B?RW0wZnhFZHpybzRyTVdkVE5OMEV4YTllUFkwV1BzdTcyTTFkV2dUQTAyU3U1?=
 =?utf-8?B?MkJwVkJFQTJISEdidlRITlJtVmduZm9YN2MvS0cvU28yVFh1eGdvUEJyQkYz?=
 =?utf-8?B?ZDNzUVJUN2RxU1ljbHhzY3hBZzROVkRNeEN0cXBDVlVNM1JMZTR2OWpTWnJ4?=
 =?utf-8?B?NlFxc3Fqd1B1bjFhN2haOCtuUS91QnhKVG1NY21RU2M0SlByMFpOdno4UWFP?=
 =?utf-8?B?TjZCWG9LRm1YS2gyQnhHdmpOWFFMdFBOdTRyNldadVA3b3hkOTRuanhWZzV3?=
 =?utf-8?B?OVF4bmRCYks0TFpXSTZ3cE9rSjlxSU9sTWJqUnllV1VWSHlGRkJhaTRLMXZn?=
 =?utf-8?B?YnlZZE1ZSnl2M1cwZzdaNjJ2NlROaXQrN3JWQmNxM3ZvV0l1clZoTFkzMWZ0?=
 =?utf-8?B?STBxZk03WHBBN0k2enV3MDNrY3VIL3g4bEtMR2dta21YV0NweXFFb1hyelJz?=
 =?utf-8?B?dGNpTWF4UkFNdnI3NWRpTXcrN0VBQnRIRjFRZm8xbm4vZC9MTHp1REcxaFNi?=
 =?utf-8?B?bXlkdHY1VjlGQWgvU2VmOXRibzRpMXBNenZqbHFNaDBpT2oySVRKTzdYY2Qy?=
 =?utf-8?Q?Nykai445CuXpomCE1ifpa5Q3Jd+xZggxY0ba0B7SmQXY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bf6ccc-9282-4f89-38ec-08da9cbe02d4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:15:13.2778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cT330gKeMkygQXLFlt7+1WhyiXvuG8VNdQ1L+6i1MfSBlx0Rf70cm6YAhC5ckMRU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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
Cc: alexander.deucher@amd.com, Jun.Ma2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 22.09.22 um 17:26 schrieb Arunpravin Paneer Selvam:
> DRM buddy manager allocates the contiguous memory requests in
> a single block or multiple blocks. So for the ttm move operation
> (incase of low vram memory) we should consider all the blocks to
> compute the total memory size which compared with the struct
> ttm_resource num_pages in order to verify that the blocks are
> contiguous for the eviction process.
>
> v2: Added a Fixes tag
>
> Fixes: c9cad937c0c5 ("drm/amdgpu: add drm buddy support to amdgpu")
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b1c455329023..b1223c8e30c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -426,6 +426,7 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
>   {
>   	uint64_t mem_size = (u64)mem->num_pages << PAGE_SHIFT;
>   	struct amdgpu_res_cursor cursor;
> +	u64 start, size, total_size = 0;
>   
>   	if (mem->mem_type == TTM_PL_SYSTEM ||
>   	    mem->mem_type == TTM_PL_TT)
> @@ -435,8 +436,23 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
>   
>   	amdgpu_res_first(mem, 0, mem_size, &cursor);
>   
> -	/* ttm_resource_ioremap only supports contiguous memory */
> -	if (cursor.size != mem_size)
> +	do {
> +		start = cursor.start;
> +		size = cursor.size;
> +
> +		total_size += size;
> +
> +		amdgpu_res_next(&cursor, cursor.size);
> +
> +		if (!cursor.remaining)
> +			break;
> +
> +		/* ttm_resource_ioremap only supports contiguous memory */
> +		if (start + size != cursor.start)
> +			return false;
> +	} while (1);
> +
> +	if (total_size != mem_size)
>   		return false;

I would completely drop this extra check.

>   	return cursor.start + cursor.size <= adev->gmc.visible_vram_size;

Instead of this you should be able to do all of this in one go.

Something like this here should work:

amdgpu_res_first(...
end = cursor.start + cursor.size;
do (
     amdgpu_res_next(....
     if (end != cursor.start)
         return false;
     end = cursor.start + cursor.size;
} while (cursor.remaining);
return end <= visible_vram_size;

Saves a bit of extra calculations and variables.

Regards,
Christian.
