Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA4CEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 06:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF78A10E077;
	Wed,  9 Aug 2023 06:36:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AEB10E077
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 06:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOTQHxhOQbtWCoNTZk2Gw+C5TKRgCbkcr3nAuEQ6zbLfubLxnh5yyClnIn7ZniHzvdI+tXq7hl/wZLrE6catwiK32ChG11lzhKTwa/53sHhFlZsHBLsm1PupOPjk/+N20viDRVuvQRcH/6ljq726Wfi7SfgecjFOmQ7mGSj3qCJrf/VPabyF4xY0RApxYce8txk3Qmk9MqvW1XJ5ecu3Xj83Zw+3A0EDsM1kVUM4vz6liUAum5Ozdh5iojOxfs72z5vjalxdXOMzH1Z9zl9xiGrB6D7V6nj5qPvUGo9TeAubKolkY9Atb1pX3zWIQC0SRQuOGuvx/MoaIixoLvOvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS90xsMF71R1uyh29EntXGxIJJl1C3/nzlMlsKbLrDI=;
 b=N/QJAUkrXIDyJzk2tX/Nvk1Q9tWZBaabGfhDd/brer9vDz0Sk7di/V82bxdbefRlPJOzW8KGY1WNgFHhb4NKDIyKTLLpFiu0gP2l1dpAnIKZDeDMC8Nld8Z/Y3TGnkM/EHCsafJJ8udXx/s7z0PLVlP162nUx/Tj+I46EH59pAT4Uef0Y4QXQJJKfbDEaF8Dt5BG9EsIvkrW0KTT1F+zULPzXELyJS0EeRuFnRd838IkQgzltXhb4GYeV7xWDxn9fWs/zNuTxBma7tbGRfhGezm6LUnWFJw83gQuFkFqoNArn0q96gHqe48/aooil5QrKwfpzPvShZ/J/Z48CxoF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS90xsMF71R1uyh29EntXGxIJJl1C3/nzlMlsKbLrDI=;
 b=AVr7YgK9VPZ+JVAy9jyuAr+q7bzta8QX5+qnN8CJa0TlbvNBCwLK6cNhBuLTMPVG3t9eHLq7N7629e43Y5jZXY70EdQveQKKFJn7rTNTsAqQCnygYtYMQRKtaLMcZjI5D08alS2VVXbXlHy8hZ13p6raIq0E5J+rxFe8y08J7Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 06:36:43 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 06:36:43 +0000
Message-ID: <f9c9d606-d1eb-7064-463c-0d7f917f27af@amd.com>
Date: Wed, 9 Aug 2023 12:06:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] drm/amdgpu: Fix missing comment for mb() in
 'amdgpu_device_aper_access'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>
References: <20230809054645.200739-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230809054645.200739-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: c60efadb-1d75-4603-79f4-08db98a2fe61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ppQbb6IWON1+lsc+JXAUwWiCeEQTihzrzhcq5mdEJQj+PKpYgcwwh5GfPhtctcVFH94WRuUgmPdq4jJnnEz4dNsIaM9+og3hNW/7F6Ljv0aH1FkxbiD30aOuETpVpe5EIJZix/UqZ4uvb4uI/ILwkak0biMx7nV58P1Hqe/tkOOI9aDu8bjo0LEkiyxipIdw5//c09oGK9i9N2L85V76Xs9AiMsantNv20SmKScLheE90IRvxkuPf6r8+OD3wUPW5MrplqU9rNgjCbuxbwWdszxXFsphdXPr4q8ZH0w4NniSi5yKKvo1sQWw+lMf78hkirto1tDDCVSpg0B7611CM0Mvuz87kOT6v8bfkMlBpmG13lJ0BK21wCteHzb3HuQ4A6hMkQNzmtD8iLRc/L19L56xR5eek0LDXIWxzu/YECc/bipkiqsKsszBOGMyr3FlTtJ2mlJ9xjZLBfhdEILEO5bqrBrJmWViEVSaVKYGVZDTTFfATD4U1pHc4wpOOiRKbkLvtVQIUKyO6AwCpm4OzwNKpB9BRuB+tuOszs8cOJ7u6DROMXUA4gPAnJhkK3LZ5jYzjVBjOO9iz5IJ2nHnaB7P+AQ9krPilUF4uvMYCBJQm2gp0Re5/slinAnbIiI4wk+BxTMu67iyKTYSvpd2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(186006)(1800799006)(66946007)(8936002)(8676002)(4326008)(6636002)(2906002)(316002)(66556008)(66476007)(31686004)(5660300002)(41300700001)(83380400001)(38100700002)(66574015)(2616005)(6512007)(6486002)(6666004)(478600001)(36756003)(6506007)(86362001)(26005)(31696002)(53546011)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1RpaURPUG5UTlBLNEwxVnJ5Nm0vV3dWQ291aUx2bGI4Lzg0T2dCK0cvSi9q?=
 =?utf-8?B?a21DanE2d01McTE0c0ZsMyt6WWxVL3J0ZzdEbkh2b0pvdnJwWjZLcFZzdVNr?=
 =?utf-8?B?a2tLai9MSkdISEtMTlk5N0hDam9PVjVkRjFIdGVWdGo4RTlZQy9mcFd2MVFG?=
 =?utf-8?B?MUsrRnR5RnJpcmtHQisyOW10aytDb0JxRm4xU0pkVWlZbkh5RzZPZGtTeXJj?=
 =?utf-8?B?RnpQSVR0NERxd3h6dzJLTHYzdjhKays4MW5QVzlaQnpDQkJ1MkNTb1ZWSTI2?=
 =?utf-8?B?NjJKL2tRMGhTaS9sbTJGUWtVSm9xWTZwSXJJZlNHZktqTHAzOVlaTEEzeE5J?=
 =?utf-8?B?c1F2aHROV0RtSG51amJsb0Qydk5NQ2laNGxOYnpjbk9BSGxsSnhVZnB1Rmhl?=
 =?utf-8?B?czlHT3RqT012UGdTZFptb1ZXL0N3YVJucTI2V25vTmpvakNYQnlLK3cydS82?=
 =?utf-8?B?U1FCcTBmUlh3WFRRQUFCelA2N05pWXpBYkFsWnQ4Rmx0VEVrWktIVXlTZFdI?=
 =?utf-8?B?RTdhZHFZb3RWSUFSNjFaMERLUlRrODFjTjZ0R1JmNm9FZ3Z0Wm5RRTJ4a1Zk?=
 =?utf-8?B?T3Z3S2lBa1IzMVZCTlpoWTVuMStOa29RTXZDT3BvVVRlUG81T3J0K1dCdlA5?=
 =?utf-8?B?K1BXVTZDOUVKVWFMKzlSN09BTVI4QlB5OUdtbDlYOTMva2hDUlhiSHhlT0Fi?=
 =?utf-8?B?VVhkM3I3Y0lyc1NOWFd1aCtHVjFaS0RpbjJIdElucEV0UE13aHZBSTJFZUhL?=
 =?utf-8?B?SlpRdjNXTTNvSHN6VVlPcE01T1VkcHZSczUzZGRoUWtaVlZuakRyQXJUTElx?=
 =?utf-8?B?Wnl3L0s3aGQzNkhZU3Q4eHIrc0Y1dlRQbWwzejhLeGNnQjdmSW1tdEJoSHE4?=
 =?utf-8?B?bjZuUmlueHZkMEE4U05qbEhMdkx3VFR6WWhXTC9taGNDN1VTVHBPVG5FaHcw?=
 =?utf-8?B?bGR3UTlxMjdLT3pBSWtkdUx2M3NqbzhwZkFUYmF0UVZ2TkpTQ3VHK3FIcjZM?=
 =?utf-8?B?TDJ5d1lxWFpKTllOTVR4Q29ZMmp2MHVKdzk5MEVhSHpsM0kwZHhNWlZEUVlQ?=
 =?utf-8?B?aXJINTZBWHBEdXV4a0lJTFlmL1VvWmxSc1lZUkVlcnRKTlgxazZQYk5hQTZC?=
 =?utf-8?B?YStiOHdlNThTTmtVN3NUUXUyMHpzZFRqR0NrV2Y5M256TVMvdHc3MDhyclBC?=
 =?utf-8?B?M0R2RkhBVm1UYytDaGZoZWVuaXFaV1dCVnlMZGhvVVQxSGRnaGxuMnYweERP?=
 =?utf-8?B?UGJ2VFFSVFM2UENObmpYaExjTTJmREYxSEdVeDlwNEMya1hGMG9DRlJtN2li?=
 =?utf-8?B?VVhYLzEra1pNaU85MkdINjMrVlhlcUdlYlRDMC9ybThoRWtseFczTE5sbnc2?=
 =?utf-8?B?L1IvMkxxY1RwMGxWcDJUZ0xxb2swYWRRVnZzVS9EendNUG04SHlQckI5akN6?=
 =?utf-8?B?Y2E2VktKeHlZaEUrWDNRa3U2cEEvZjQrSWhjYWRLL0lvVXVPR2k3NGZCVFZm?=
 =?utf-8?B?Y3JvYTMybmFjY3B5cXBJWUlyaWtMMkQyM3dSREx1SmQ0RVlIRGJ1eWpEbHFr?=
 =?utf-8?B?R0tMVThueGVNbFpHWEo0T0JVaGUvWEtqU0grV1ZXVzVWcVhET1FsNDN6TndK?=
 =?utf-8?B?UGFRekFCd1VTaWd3bFJEWWZqTklhYWlMTkZKUWtlL0dDZ0VIQXNJaGxkeDlD?=
 =?utf-8?B?Y2FFNVVVaG9lTVFHaUNHSmRiYXdBeXBsaXRiUXI3V2xhWHVnczdmNGp4SlJT?=
 =?utf-8?B?TmZXRlpRQk95K3FmS0VsSTRDY2l1L21UT3FhVGEvQXhGMGV0MUNtOTFpSW5k?=
 =?utf-8?B?N2FveTBOb25HSzQ2VVd1SFJ6YTNENHY1THUrcXFRUWg1QWdma0hDRVpJaFpn?=
 =?utf-8?B?TXNWRmswQkE4ZnZVRnQra0NHUnlPdFM1MXpqcG9aNFBOKzkzMUpVUmJ0MGtt?=
 =?utf-8?B?Z3l5QjY3cHlYR3RUU0xDNEt1dmgrNGpMdDhjcnJCaVJ3NDZ3TUtDajBHUFZW?=
 =?utf-8?B?QTVENDRBblU2R0trTVJ0KzZxelFldGVmZGcwUnVhem44Uk1GelVVOHI4RHJP?=
 =?utf-8?B?cWJPNnJsb0phT3F4cGFHVXl6R01QQSsxc2t6eXBiMjlwK1NOYkFBUzZoQmI3?=
 =?utf-8?Q?1EiWmZ0lgMnD33eIfU84DzOKm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60efadb-1d75-4603-79f4-08db98a2fe61
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 06:36:42.6916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eVngMH6TL5LcsrFtjAY1It6ym5qgx2Kh0U2558LN3lV5xq3WvbvuElZDJRajhiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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



On 8/9/2023 11:16 AM, Srinivasan Shanmugam wrote:
> This patch adds the missing code comment for memory barrier
> 
> WARNING: memory barrier without comment
> +                       mb();
> 
> WARNING: memory barrier without comment
> +                       mb();
> 
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v3:
> 
> Corrected title message
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4f818f13dc9d..bb65e12ed027 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -305,10 +305,17 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
>   
>   		if (write) {
>   			memcpy_toio(addr, buf, count);
> +			/* Make sure contents of system memory are copied/flushed
> +			 * without messing up order of writes to PCI device I/O memory
> +			 */
Make sure HDP write cache flush happens after the memory contents are 
sent over PCIe.

>   			mb();
>   			amdgpu_device_flush_hdp(adev, NULL);
>   		} else {
>   			amdgpu_device_invalidate_hdp(adev, NULL);
> +			/* Make sure contents of system memory drained/invalidated
Similarly, make sure HDP read cache is invalidated before issuing a read 
to the device. No reordering in both cases.

Thanks,
Lijo

> +			 * before copying contents from PCI device I/O memory
> +			 * to system memory
> +			 */
>   			mb();
>   			memcpy_fromio(buf, addr, count);
>   		}
