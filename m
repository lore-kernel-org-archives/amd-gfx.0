Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DDCEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 14:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E4288D18;
	Mon, 17 Jul 2023 14:58:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E2D88D18
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 14:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXYV9eeKdc0XB33BH+d2OtzmMbvN1U4mA1eah5yP2irjUqOWx+PLREANDX+msxox3pMcc8zs4b2Ka8YIgRPvBferESapM84ixPJ9BfPUgkFaOGLClnzSeeQ2iBO2xZoROazDov0wT9F8ngzBCeFLNlZnf56wcGeNjhqE+FcKnfe9brpFPO4eYG7xPRLK7aCf5wzkVpYo50FeBa44a6MOdaDY/q8FMdS+mM829NylE0lBeMBC8No8I0WBiWwoz+qCim9zX2joJggmhBJAp1p/zllMlFDVsS7WYVp0WvHN42XDCN7c0iDNcOeLqUjf/NXJ8vvCkaHnfxFrdqstd+LygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5K/1CQJC+iUGwUu5a55eqRNwTKq13W6Wvyn9gDpUmw=;
 b=A8Nu1/i1dYP1myXtdLMjZUcpAGDU/uAfaKXKSlWyvgwzUGyKUZXhCRIdGQ8CvgOh7tVAk4tFksLlShWMj5W/IhSYJ207JCyTQMyUkc7+iqJWwT4aoAjpd67uKKM77chDhV7l1qvE6wVYhrzt6gudrniib3RTfE6K+FzcMQ3jqDlC/j4+7KdpJ0GjXXy4/EknIDUf3fFeIwrpBIMgRVIlmL0vYeXWlipLyjEPtsr9CBrqoP2OdR6RDNPXjAlW5gpY5VDz10bS6A05yUNGHhfXlgDqo/GWxoH5FWbRM9Gmz2MU4xN78HGldpieq0l4z+lS+ctYB6cKLbjIJTRPL/l3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5K/1CQJC+iUGwUu5a55eqRNwTKq13W6Wvyn9gDpUmw=;
 b=mc5/EemCB9b3hyb7Da6BwQMgb3Lo/nU0lDYfsDJ4+dFQJ89yCC3VVzfFKSvrr9uLOU97Q9xM/8NeCLzXnvfsncN1w9DqdHGQay6nX+8SrBNvkhbwIPCxT2oMSbtty0/Aqegi6eOIao8y7Y9XBCEN0tLzkur0G/GJzTZ/C7M/ofU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Mon, 17 Jul
 2023 14:58:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:58:27 +0000
Message-ID: <96a59b0d-89aa-7cea-e14c-9a9188c64020@amd.com>
Date: Mon, 17 Jul 2023 10:58:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] drm/amdgpu: use a macro to define no xcp partition
 case
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, christian.koenig@amd.com,
 Philip.Yang@amd.com
References: <20230717022619.3833601-1-guchun.chen@amd.com>
 <20230717022619.3833601-4-guchun.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230717022619.3833601-4-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5a3109-ebbc-4cc8-0550-08db86d64704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpKbHpypR57800rIleQw65w1crCq2UWmM0+aYJmvoCk+vwNgAnmgWwWVw/q9qmen6KWC/FTK7M/ca73wLhusfr6JjhM3qpq2qxengFgrn/fDoFheUcbhIO3JpEt76Wi/OJH/0F/NLL6dmRSoCobfofkJHo7Ie4G7zFcpcgACPVk7/cM85JjNQRAUC9H11ryvhDHijyPxPdSJODhCRzcMU28sL92AS/mTDuL8LYNFxpsWwLMA2bwXmTJiKPyr/naTnhWLbN/u+3v3oCywmHwVAC8ApUas2seWhe9uRoGpE795zBzGrb/gQV6s5OJqt8FBMd0uk2esAGa0tFD+Ob0XeR66rfb3hpShSBxyYg6hqfF0FYRpm0xzWqdXD0DXGDPF0Nd9porNPkwJNPM7SKkh9+jUp4zZA/XZb6KFzn4hT4AJVGnoJZNwftpEqfVYd202ON22rKZqwGCQRjZEj7Isjme3tkU0wmzQCjMpxo5EpLKRVFw7Jc6l9rT5p+PB5gLrOK1Kw9GIr6PS29UHVi6HZiPelcCdj4xrfCrQMXGiZlUld9V2RGceECIKl4+ouDRT71pEybxQXa7eB7WHwrKl8MUTi/pwGy+L2YJbGxlGEpgp3kASMaKG6RJgm98/2fdtJjgFVW4RXUM++DdwNGWnoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(31686004)(2906002)(478600001)(6486002)(36916002)(8676002)(8936002)(36756003)(44832011)(41300700001)(316002)(66476007)(66556008)(66946007)(6636002)(6512007)(66574015)(83380400001)(38100700002)(31696002)(5660300002)(86362001)(6506007)(26005)(2616005)(186003)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3NmOGZGSE1hNGUzOSt5WkR5WWhxdmxpeUxxNGl0L1NZS25vQzdLWE5ncGRU?=
 =?utf-8?B?UEtvK1BqZm1FL01NdjhLNE82QjNTYlJTdngweG51SXVPWFArZlhqaHZ6cEdr?=
 =?utf-8?B?UWV2cUkrV0JBc2JhOUZUeFpFVmhOWVVYaEQyMFRRTzRiY2ZCQ3lGMnNKWVox?=
 =?utf-8?B?RzF0M1ErbHBoczRWUXFqTmVic3o3SlhPRzV4cWZLZUhvTDRRNGtTekoyM1Ft?=
 =?utf-8?B?SVQwNWFhaHRLWmhzaFlVV3ZybnZwOGlCQ3VDNnlIUEZYb0NlYnFNMkd3N0R0?=
 =?utf-8?B?RWJzdzh1dUJwa1RVQmFrQ1NRaEdBYWJtaGtERDZZS2RiRE4zZFB5OTgxQXhw?=
 =?utf-8?B?elRUcjJlQjZacm9adktJSTlwdW10UGEvMGFWNVFXcXR1RUU5NUFKRjNSSHdv?=
 =?utf-8?B?V2tWZ3BteWFzR0JrUlhhQUNycVN6TTQ0R1V2dTN0MVZmY0VTbElPajE3WDhE?=
 =?utf-8?B?c3RyTXBZNm5kTmJJbWlKV01rellZNTNRUXoyRlhqQnZiOEJRY1NJNHgvZmda?=
 =?utf-8?B?TmdzVlJuRi95c2V1dmZBcUJRMEswQ1RZZDQ3akR2cmQ5THk3WSs2SnB2ODl1?=
 =?utf-8?B?dDJwRmVMc2Mrclo0TnZ4QXVJQW5WeVpOenZidlROZERsVUxMMEcwcFlQYUVK?=
 =?utf-8?B?bHpNbGZMTjZrV0ZQQ3RMeDNmTHl4Ym9YMWRjR1VQanlpeitDTzIyTDhBOXdj?=
 =?utf-8?B?S1U0SldoekNJYitOY3ZXcFNaYzRXSTh1TUdRSTVYNWViZ1d1NUFwOGV4NFIr?=
 =?utf-8?B?OXl6OXVsMnpTanRWL1VtY0xBQm8xeTdSWjJ3b1Arb1dXM1gybmM4a2UzYVZZ?=
 =?utf-8?B?V2pGOWFmOS9tQUR1UmR6cXhEb2poNU90cTh1ZjhTd0pVN0hVZk1TRUhxM1RG?=
 =?utf-8?B?KzB2S2h4TmxGQmV0NTU2VnFmZWNpK05sVWoySHJ5OWNqNllQaGdvbTZOdU1R?=
 =?utf-8?B?NXJoR3NhbndOdFdYVncwYTQ2cTR6SGtnTEd6UmhoR3pIMHlReGt6NnNwVWY4?=
 =?utf-8?B?eWhMUGhTdUJzUFhxUFN4VGdJTzduMWxJR25vNE00Tk4vcXdZZHpWUlNpSXo2?=
 =?utf-8?B?K1V4cW5yRkdMTDRUUy9oZCtnQXc1QXY1M1VvdDVsOW9CT3lSLzN6ZTBNKzZ5?=
 =?utf-8?B?eEl0Wk9SNFF1enhUUjJZTytHeVNGbDhwRTFTMStGUW5JOTNCVmEvSU5sR25B?=
 =?utf-8?B?OG9qMkFoUGMwUVZFT1l3UVlHMFVuQm9nVnhoZ1NoMGt5STR1ZVgybGg4cFZE?=
 =?utf-8?B?eWhYcWRDaklrNG82ODFyb3Qxam9hSmM0RWlnc2ZmajZNRWkxeW5HeU8rK2Ni?=
 =?utf-8?B?ZXpCSDltTjlpcjNCT0xrMEZhcVJ3a2RkOUREZGtNRGRwWVArc3hRUjN3YUU1?=
 =?utf-8?B?RDU5aC8wT0xrN0w1bEtTZ1ZLa1pkUXZtN0FNOThINTRPL3ZuckN5UWZoRXIv?=
 =?utf-8?B?enUyUTJZYlBweWh0ZnVoVTRCVkFERWFCT1h5cXJvSG1VMlNlTmxweDBTZmpF?=
 =?utf-8?B?L2dISWF0aVArK3ZIVUlDR0FnS3BEODRLdEZRWUlTUGJEWWVBUzZ3eC9STVNY?=
 =?utf-8?B?bEtoT2hYdW1KQUlRa2dNWS84OGhuVXlDNmhjdnJWb2g5VWp0M0c0aTJvRi9M?=
 =?utf-8?B?dzRuV1AwUDhSUnIzNmNBeXVBR20yV2t6Sk1hTnlCOWxLVGluajk5M1VoQTMv?=
 =?utf-8?B?QkJHalFRVW8vSlJqMWU2b3lMbzF2ZU1ZNjJPTHhGazJ5Z2xaOXR6ZnZaUWVN?=
 =?utf-8?B?eS9YZW9EZTBlTFVPVWhCQjdCTjJSVTZqZDJSWXF6SzJGaENkRU8yMWRTdnhB?=
 =?utf-8?B?TVFKYVIvTkJCYy9QQmlYbkVDYzc3MU5KV1ZWVm9BVWFaelYxNnQ1cyt2S0N2?=
 =?utf-8?B?dG5JdlNYYXNzWThVbDlLZjlwamFlZmxpQlMrQUJSYXRxcy9hUTc1YUhxdlF0?=
 =?utf-8?B?ck1na1FTQnY3ekk0SUx4ZmtmMEd0V0ZuTDd6Wi9VV0RZbEhkaHRxUVpDOXFW?=
 =?utf-8?B?MEZrL2c2Qzk3MDB5SExiRlUyTmtPaWZ6Wm1HWHg4a0lwVTdZc2tobkJrcjJL?=
 =?utf-8?B?c1l4ejBUY3FDc04vTVZVdERjRzVZeUwwNkpnVEYzUGNrRlVqZjZ6OU1UREkz?=
 =?utf-8?Q?nimd8F2v0aRNTh4lyjrL5uVSm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5a3109-ebbc-4cc8-0550-08db86d64704
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:58:27.7548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gL35vtVS7MAaU1admEpDRBsm2G2rGsxlmmLv9RE87fvNOBOr0umd+KPPgy2uwqWdTzMQtx/wbpfgu0CMFPOWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
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

On 2023-07-16 22:26, Guchun Chen wrote:
> ~0 as no xcp partition is used in several places, so improve its
> definition by a macro for code consistency.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c          | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h          | 2 ++
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c       | 4 ++--
>   4 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a7f314ddd173..d34c3ef8f3ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1709,7 +1709,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
>   			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
>   		}
> -		xcp_id = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id;
> +		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
> +					0 : fpriv->xcp_id;
>   	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>   		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>   		alloc_flags = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index d175e862f222..9c9cca129498 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -363,7 +363,7 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
>   	if (!adev->xcp_mgr)
>   		return 0;
>   
> -	fpriv->xcp_id = ~0;
> +	fpriv->xcp_id = AMDGPU_XCP_NO_PARTITION;
>   	for (i = 0; i < MAX_XCP; ++i) {
>   		if (!adev->xcp_mgr->xcp[i].ddev)
>   			break;
> @@ -381,7 +381,7 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	fpriv->vm.mem_id = fpriv->xcp_id == ~0 ? -1 :
> +	fpriv->vm.mem_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ? -1 :
>   				adev->xcp_mgr->xcp[fpriv->xcp_id].mem_id;
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index 0f8026d64ea5..9a1036aeec2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -37,6 +37,8 @@
>   #define AMDGPU_XCP_FL_NONE 0
>   #define AMDGPU_XCP_FL_LOCKED (1 << 0)
>   
> +#define AMDGPU_XCP_NO_PARTITION (~0)
> +
>   struct amdgpu_fpriv;
>   
>   enum AMDGPU_XCP_IP_BLOCK {
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 16471b81a1f5..72b629a78c62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -68,7 +68,7 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
>   	enum AMDGPU_XCP_IP_BLOCK ip_blk;
>   	uint32_t inst_mask;
>   
> -	ring->xcp_id = ~0;
> +	ring->xcp_id = AMDGPU_XCP_NO_PARTITION;
>   	if (adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
>   		return;
>   
> @@ -177,7 +177,7 @@ static int aqua_vanjaram_select_scheds(
>   	u32 sel_xcp_id;
>   	int i;
>   
> -	if (fpriv->xcp_id == ~0) {
> +	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION) {
>   		u32 least_ref_cnt = ~0;
>   
>   		fpriv->xcp_id = 0;
