Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5776EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 13:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E3110E685;
	Fri, 21 Jul 2023 13:30:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1320710E685
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 13:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhKAs7vIXSvleE++0yU2t2zOp3S5B5qGYRpI+ohStKgbHk7ZuNClamWl5UYy73Gx/tFwcYDLt5IH/29FEUruidBucNWu/wMJZ3csuqtJ2N/RsD4j7o+JTjWZqy2ceTHCqW1gRBZFXPKihCpoRYp+rmLC2pcz0LK59Tp1IBBoa06jlLwqmfyB6nMbHI8yUMaaR8O5i0Xk1T6yU79M0R3wZUYgssuh5tcVtY+TVM5qbSLZ2l4zK8Q2bNfTXmqBZ6q6sNJPeUeL5oGFGMA0HrG/ayfEsmzxs/bL/fU1LWqFJHBPXY6ufurnZNuSrVUqcqK1CUEVCMBQ88Zbz+azeIpVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze3rPJBh8EMDPTUcC1qd3Lui8GWi3dafHKQeWy5IVSY=;
 b=O39TG7Htiqyuxr6WoNZtR8CzctV4qj0J6GD9qUfiKDCkFOeAejJS23goWAezdJroBUFd7Hwbt8PrBZEL4BKR5ENRwPV0ptZVqdKHGmHmx6A2zeEuuYVZRHO8PhsXlkSGp9RT8E8lm6eZSjkbUKINrVO4ONDqyEQqPR9IgcOeIfXBYH7CUlw6gcMub7y9ipOd+bKiqMrgwhcKcrySEXH6sU/URgS2gFTYZBRknXTNMAhet5V3tMcrK/L2jld3hbMzFWBmaELhwElNMqBXMFcmWR7TtTOMfHcl4gnVP+79c4CDiNK5HStBykNUjnk+x2Yex3BPeOUXQWmdn4Kv9auYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze3rPJBh8EMDPTUcC1qd3Lui8GWi3dafHKQeWy5IVSY=;
 b=wrf3RSIny4ro9SVBQ888uzVZVZyRbwVQ0ohSFtezUj337M4CZVU8kqmopkpUt/8kslztg1ukBOIH0U1+SJrO8yjtoW3rEATsTPBr2c/ixKb2/37Khu/FDOikIoYfszf9HA03IEPVj73I7RZqQrZjTuv7imCo+kE5l7pqHMZHGB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 13:30:20 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2%4]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 13:30:20 +0000
Message-ID: <5a825e24-8629-d5c6-44f2-9a34de57b3ff@amd.com>
Date: Fri, 21 Jul 2023 19:00:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 6/7] drm/amdgpu/jpeg: mmsch_v3_0_4 requires doorbell on 32
 byte boundary
Content-Language: en-US
To: Samir Dhume <samir.dhume@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230720191940.780187-1-samir.dhume@amd.com>
 <20230720191940.780187-6-samir.dhume@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230720191940.780187-6-samir.dhume@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::7) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: b6deb1e7-a65e-4547-9cb0-08db89eea0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wb0RS5RrXq7OkdX9+dykM5uLRABJCUS+sn2SkNLXnFP+WR7IuqcxkNZaSsJGuKlug43KEas+X4GPT/upbzMhKsOoE3nTH7PxyMs2HV+TWdg81eE+djO6rY79JhQXj2HfhnEOI8+nbqOvsbgtFlSR66QqYhxIeUksypOlU4rt0rPNWVmPYtge5LetF86dBSQ9scbEsEJeE+sLCl/NtdxrQjJ//EFAuMFhSPso9UMPioCFnjQcuNNoKlPNykPv1k+9YcUEFioxT1A5FbWGh6TGkL3JyWK5qaPmtWFs3RVJZ0sRj3rIN3uzmoIqRk2AJjznCMYBQ/N4II70vqA58+CCLL/53MpgkPBgsBBDqpj5h/+pDYhO2uqkZKSOf2KsF+Fy5h7be89bJlMbUcbvcYJ7alLVToT7fQ6qoIjquyV0Nvs63ssnbSC7vRo0i7PQHvZuorWZTTJhCUOMch2yoFlHheElJ2ZbyXeyd7k4r6NbJxxp0SWELITkEjYsHcpPnQavpMVFDWXGmHml98FnhWIFxC5e2P3+5Vj4Ho84JYIEbpPua7hxo+c1a8KnGlj9I+JiJOy89Y81rwqRDDdExzZ1lCo8WOF+s1c4dBvaC/JN65wstmKQ8TPEAOnAq6rrOaj1BEBY6du1gkau/sQIjcUGMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(6506007)(53546011)(26005)(31686004)(2616005)(6666004)(6486002)(478600001)(83380400001)(4326008)(6512007)(186003)(66476007)(38100700002)(66556008)(66946007)(5660300002)(41300700001)(8936002)(2906002)(8676002)(316002)(86362001)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWxOQVo4QzN0L3o2c0s5WkxnNDcyTkIxYS8xZC96dmRuMWd2L2hHYitTeUU3?=
 =?utf-8?B?Z1hkbGc2Qkw1VUtkY2w0aUF4Ykl4b2JpMm1LMzJUd3VwZ3FZRjBIbitRWFho?=
 =?utf-8?B?TzluRk5ScXVZQWRhVE1NS09xRGRwQ3lnaEJZUDJLd0ZDSjk4dWk2eW5qcmh5?=
 =?utf-8?B?Sm03aHR0UVk4cUV0SGY1YktCYzh4MEIxeHFNcEdzRlMwcDlQQ1ZZYURPWDdN?=
 =?utf-8?B?VjZUL2pkRW0xVmVpZ3Z4b21lUys5S3h1NGo4UWR0QXEzK3Y1SkZpaFRFZExX?=
 =?utf-8?B?aW9RMi9pb2ZQNkhYR29yNCtSNUdkNHo1VWo1blpxcEtSSU9zQWFvd21YZnZa?=
 =?utf-8?B?RjZ0UTRvMzRQWHBuSWRyMm9pazR1V0pPQUZ6bUFYYWxQNDdabHZoL1dlelcx?=
 =?utf-8?B?V0NkOFlmTFBzYjh2M2tJVGtNNE55aUNVaGE3UTBvV2ZmRzlHUUxTWFNUb1pO?=
 =?utf-8?B?dnZZTVhFMjB0dTBINWxYaVB6dmMya3FLL24wVm1IL1NnRHRZSUZtdXlSUmhk?=
 =?utf-8?B?UlBtQzNXUWVnOHpSbEFtWjAwb1NtMU0wZmVKMEZJd0FqVkI4azZtZFpOSVRN?=
 =?utf-8?B?NVZWN2RUV3BrTmdqTi9nOHV0OEZHZlNxeUlWWEJ3d0pkOERzckZWVzJaMnll?=
 =?utf-8?B?TWJLeEpzbkZGZzBNK2RlVHBTVktYTSt0c0lhN0pIdGticlFsUFVoWUlzTWIr?=
 =?utf-8?B?VDRTY3hjM09oRG9XRmVlSWZQTllNbTZoYnIydFJmMFVJdU94dXozWWlCNGJm?=
 =?utf-8?B?dWxKV1gxODNGU2NNaFJTc0p2VUJ4a3k4Rmw3L2o1cnNqaTF2U1hjNWU1dUpC?=
 =?utf-8?B?MDBONXprUzdvQ0Y5RUNYNnRNaHpPdXZONzNPL01LT0Z6RjNqb2huUEJCOGpH?=
 =?utf-8?B?emZqYjdrWWtPTngyZHQ0cWFVOXE0TFJKcitEOHQ5UkhyRmJZdEEyL2tIWGtL?=
 =?utf-8?B?K204R2dES3pEQ2wwNTlueEVsTGcvOGRHTEY0RENFVU1XUkFxeDRad2ZGcFFT?=
 =?utf-8?B?MCtPZEJBUnp6NHpRNkhkOFNsMlBEZ1NqbXdYSllYR0J1Wm9WWE4vVW9xdVpV?=
 =?utf-8?B?Zk43QThiTE01OTNKMWs3YzBadGJ0cDBSNjVOOXJUVjZaS0szVzBjSGlxc1BU?=
 =?utf-8?B?a0lRMU1DOE96azRPL0RXN1E4akVDM2dRT2RENmR2elg1Qm1heWZKLy9sQ05k?=
 =?utf-8?B?dzBhOHZwaGdPUEt5d003clEyaDd0OHZyaUtQZk1KdGRmV2ZkSHBLMzNaNEJB?=
 =?utf-8?B?MW85azkyLytTOFlsNFNubkM0YkpsZi9NZzFGeFdleXBqYXBNSENYTjY3UGU1?=
 =?utf-8?B?WHRZVU1KQjI5aTgrWStqOTUwZ3BkaFlWMkJBcUZvVmxkVTJ2N3JXUlQrQVdU?=
 =?utf-8?B?MzJWL1pzTGJWQUxsbWZxWXdUZTlXRklyMllnek04aCtMeGlrL3Z6T09ZMW9U?=
 =?utf-8?B?dFpFOWhkQmVlL2Q2QUpvYWhmZUk3UVV5dm1EcCsvd3RUb2dDY0lsdnpqL3Bt?=
 =?utf-8?B?Qm9VQlZmR3pPR01qeTVJdkdXYlEzRlBqSGdwTmdQck52MUhFSVdEL2dHZFNP?=
 =?utf-8?B?YWt4QTdKNUtvQi9hSmYrUXFzbEFoY1hSOWNQM0tlcWFoZ05uQ1RaV3kxTmVV?=
 =?utf-8?B?ZFhoTmVXdWpTVU4vNlpDU2NWZmM5N2Zhb3pxTWorbHdxSG83SkN1UUlBWndN?=
 =?utf-8?B?T3JzVXRROFcxaG5vSzhUeTlBOWRLSC80NXZzVnJkZmZIWHMzaFZWYkUrTWVa?=
 =?utf-8?B?TXRDWmplem5IcEpxNDVoaVR3aU5DMkt3WTIwczFBQmI2SkNUT3d6VjYzRDc3?=
 =?utf-8?B?MmdYNU5nWFlOejY1V0RNY1FVaHRBV1VOR1k5ZXk1OFNXem8xRUJVMTJMTGV0?=
 =?utf-8?B?dzVzWmZvOW05UWdMV1RzNWY2dzVjaEs5N2RZSEFJNXhvUGNCWHl2UTR4UDNp?=
 =?utf-8?B?cm9ubnFESDlKalZRU0traSsxZXJyc2lTWFpBZmxHa04zRUNpTkhsRUdhTW9P?=
 =?utf-8?B?eUNaWTh5SDZ2VG5yb1llckt0d2k0Z3luRUk4dURualVrakloKzF5WVRvSlhX?=
 =?utf-8?B?VVVBdWRBN0hEd3c3NVI4L0k5TTU1YksweEhkb0dLWHFoZDh3Wm5sQm1WNFo4?=
 =?utf-8?Q?qqDkcZUwzNWlw4/na878h5BvD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6deb1e7-a65e-4547-9cb0-08db89eea0fa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 13:30:20.2731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyY33dziNVViRRYryKxbURHDnCA2oHXk/wJ0uUXKrgwJwyi6HORYoif8S+ixcj8z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392
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
Cc: gavin.wan@amd.com, zhigang.luo@amd.com, guchun.chen@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/21/2023 12:49 AM, Samir Dhume wrote:
> Signed-off-by: Samir Dhume <samir.dhume@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 85ee74fdb7e3..896e2f895884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -111,9 +111,20 @@ static int jpeg_v4_0_3_sw_init(void *handle)
>   			ring = &adev->jpeg.inst[i].ring_dec[j];
>   			ring->use_doorbell = true;
>   			ring->vm_hub = AMDGPU_MMHUB0(adev->jpeg.inst[i].aid_id);
> -			ring->doorbell_index =
> -				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -				1 + j + 9 * jpeg_inst;
> +			if (!amdgpu_sriov_vf(adev)) {
> +				ring->doorbell_index =
> +					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +					1 + j + 9 * jpeg_inst;
> +			} else {
> +				if (j < 4)
> +					ring->doorbell_index =
> +						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +						4 + j + 32 * jpeg_inst;

Is the requirement to have the index at a 32-byte aligned boundary?

Thanks,
Lijo

> +				else
> +					ring->doorbell_index =
> +						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +						8 + j + 32 * jpeg_inst;
> +			}
>   			sprintf(ring->name, "jpeg_dec_%d.%d", adev->jpeg.inst[i].aid_id, j);
>   			r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
>   						AMDGPU_RING_PRIO_DEFAULT, NULL);
