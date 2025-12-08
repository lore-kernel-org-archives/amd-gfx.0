Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5366D3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 15:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89AEC10E491;
	Mon,  8 Dec 2025 15:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C4Cjum2V";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B62D10E493
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 15:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMLw5jjWdZ6UebfE8vIbRznm23/o8ej1i6jl3yllwvlv+ascO+nUuSFmN0uZpX3WgCW8rcytboOj+Fo9VjbzuWtdMYfuDkMLNyN8iHuUVND9a5IcPsRGcPI+v0Cofw7OjK6tL6rC68Q/kxGFKRr/RZAZHxCGi4A/pedkoo3xVOBDIUu0XK0k/zbm78Z9M7C4/N4DuL9Fb+EKrWoRE0jPTRyztlQhv/DYRCUCFM50MoHrz7x5jR011IHrGK0MKfTIDwTZMa2WikwFOU0APSc4nyj7XJgBBTEni6q3a4CaXjaesJuUNl5ENiFWaJBf458tmax8tzdZmOGM/kgIF+KCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12ac/LZY8QYY1bE16VMHQ0DBKZ2Us1QGOslWN7WrEF8=;
 b=jr4F6t9UZHa7qhVaqBXYdz7gK4ndtPK16lP7HQoi3Cy872yYreJlFdfe0pEwU3+CoEiK6s/tVkDwVeHhw2oia/zl6YlgAJvZ/CztiQCAWjJpI+uUhg+cpZ4mDos3ngo7GTVx5//AMmIz8JvvMXlg6Qy9eKKKTbuu0em1DdE/gGq9neeh22ZPiCx1aCe0LrJ/BiuPyG+eU0JZwW+vvwmqAUaoRD1Ui0tTWi29A0TZwM169B6/0Nob8LL5zESIXw11JH0yIYMG4I3+3pGiO3gUnQPqbTmJj3RxUEACkmR0h/0WAOEhosoTRHBeNh3bYWhPSEADuiGJgMi/I0TQBvdBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12ac/LZY8QYY1bE16VMHQ0DBKZ2Us1QGOslWN7WrEF8=;
 b=C4Cjum2V80ctAd+atWJGY1xgLMF1iu2l8FS/s3SgiY0Tc6L8fQ02ch9MrHrV+Jfqc4P7Dm6e05+edOtXXycL3oFNShHfJaHMo5sionbCCOzhcTfjGPWd/Y5A0FBbSYzyNBCQlDY2kgUa9Di7CsToawG4rylPwc7al/jZdZplgqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:52:10 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 15:52:10 +0000
Message-ID: <b1f259ef-3aeb-4158-84f5-d2811eb8c529@amd.com>
Date: Mon, 8 Dec 2025 10:52:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] drm/amdkfd: Map VRAM MQD on GART
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com
References: <20251205214922.1095629-1-Philip.Yang@amd.com>
 <20251205214922.1095629-6-Philip.Yang@amd.com>
 <a90486e3-e27d-4f05-a129-82068f4c9093@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a90486e3-e27d-4f05-a129-82068f4c9093@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::38) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ee99ff-14a2-4b29-3e5e-08de3671bf4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akJTcFhEZWFwSTJhZ2dobFRPdUg1NWZ5bWtveS9WS1NiSnREeFkrM080Z05y?=
 =?utf-8?B?VTRrVHQ5ZUNRTXN4cnhMN3VzSXFyWXArcU4zOUM0N0lEQXo0Y2llTWVNNXB1?=
 =?utf-8?B?SFFycHpYbzFORjVzT2FaTGpFc3dmK2d2SGRYeDlxUjhtem9QNU42dExTcldL?=
 =?utf-8?B?d2pyZ2VwV0psMHpHVXFHQ1hxVkNCVVhlYlVXK3VjVjVsN1YwQlNDZHhwSDNK?=
 =?utf-8?B?VkNVd2JLaHlIQndXTmlUbk05NDVWdEVyOUU5QlRVbFdCZWVTSnZYTFhBMk4y?=
 =?utf-8?B?WVcyM1BwSXkvMjkvZzBoUE5yTU5jWExtNnBMWHZlMDk3VDJKaHhwWCtkU0dy?=
 =?utf-8?B?OUZVaTFTVEdJeWR1WGNYanZrcGNxNENkSjAzQzNyclkvQ0RwUnMzdmg0cGJ1?=
 =?utf-8?B?bEM5d0pLNDlzYkxEMkVmWTltQmc0Q29ad3NrdjYyV3h5R1oramJPN0ZYWUNN?=
 =?utf-8?B?KzZoOUhJUFkvejdBNXgvL0EzVm5Ud1AvT3ZlSXczK1MyL2c3WlEzYnkvUGFI?=
 =?utf-8?B?aFI4NkJoZGpzMHBNN1lhSUpoQjZIZkFLbk9ZbjVNWjhYVkRjRXRpVmJtVmJj?=
 =?utf-8?B?WitvTWF5bFJIYzdmdnplNGxubERvVk1VTkxubmlVSTBxazQyZnEvaEs2bko4?=
 =?utf-8?B?elBwblFybVA0NkpMVGJZWVM2ckNyQVIzci9EQUd1ZUtabzcvL3RQR3E3RDIx?=
 =?utf-8?B?cjRTdkE1M2F3M0IyUElxdzNaSVZ5NEJzRWtQdFpOT25uT050TDhpOElPMHhF?=
 =?utf-8?B?T0RjR3gwaDlET1cyQUtUazdrTWNNcHN4MUF0b1UvZU9TbGJXZ3liNnk5dTRY?=
 =?utf-8?B?V0hrMEE2Z09wcUhTU2tEWjdmbmR6a0lVNWlldURMNG05QVVWTzI0Rzd6eWRh?=
 =?utf-8?B?UTJZMDhOWXRaNW5SSCtCcVJKdERLWjE1TnBxSlFVdXhPV2dOK3h1M2t2YTE4?=
 =?utf-8?B?eUdRYUhTQTVlZDBnOWIxNFVpTExqemRoanU5cVoyNElYQi9UMThDZzZQZ3Bt?=
 =?utf-8?B?VVQrWnhlSnVnSUdwZkFqVlA1TXNiNTFiODJvbVhZRTEreHZkNnVFZDFHOWk5?=
 =?utf-8?B?c0NkYmJFMUpWbVJhNnVVbVE2VWVZSG93NFM4YWR5VnJmQUt4eVdxbCtjZDNo?=
 =?utf-8?B?cnFwTFlHSVJtTVpQM2V2YWprM0NBenJGRmExNkx2dTBRaG5IQXhhcUJFWk5Q?=
 =?utf-8?B?SWEyTEZ2dFA0ZmlXQ3V1QTl5SHdUbkR6QW1jaCtrVUZrZW0xYTZEWURNRUhp?=
 =?utf-8?B?WlNkamg5aVFnNHZWa2t0ZWhpTGpNaWNHMlRqZ1NrZU5DbUx1c0t3QXFIYnQv?=
 =?utf-8?B?RXFaNHZMNHZ4R1ZjYm1aU3FZeEVqbXd3MWpwKzl5SUdER2tJdGIzaXFVelhD?=
 =?utf-8?B?QUgxcmRzWmpJcmxRdXRjNGJRWDV3NFZSZVZtaTEvWG9vd21BWTlURGVMT3Ir?=
 =?utf-8?B?WmFZeDBVdWV3SW4zT05DZVZEOG01WlllOVRWOWdVMW01c3lQWkw3K3B4dFBU?=
 =?utf-8?B?UFdaeXFnZU9hTnc2UkZ3d1JRTmtkNyszT2N1clA1WU53TXpFbFQwb2Jkam1Z?=
 =?utf-8?B?U0Z3QXZGa2JHTXhNeGsrRHhCN2xXcUtLNWFYTFY3WTliUnM3MmhJWXYwRUZM?=
 =?utf-8?B?SW1PWE5pelhWRW02a202N1B4SHZhL2VVcjhKWkpZRElGY21FN3FLMTRNWmtT?=
 =?utf-8?B?M3dLaytmajJSNThiUlZ1WGxTcGtKellYSmFGNDBOQ2NxSzhmcU5sWFpKSHo2?=
 =?utf-8?B?amNDN0lmUkFnMHRYZmVPalBSZ2NqOWQ5Z3N0MWJaR3REYTZCUm53Q3FhN0Vs?=
 =?utf-8?B?Y2hvTXA5MjlYdVN0SXpYYThWc3Jrb0RxUVJQd2sveUYxbXhBNjQ4bTlkUTBy?=
 =?utf-8?B?bE4rbnVDUWFpZHlFTnFSL2ltSVBETzdMYXJDYTIySEM3T0lQMXkrZjRUNFhu?=
 =?utf-8?Q?ZIvhbxQkIC/NUb8GyFgfZJgiMbD7nrh7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0g2QSt0bmhQYi9rRFFiUStUZmI3QUEwTHdiWEs1QkJsYzZJdzM0NDk4TlhD?=
 =?utf-8?B?R2VYMHJCeFFMODhodi9BbW0zSGpCa3FXOWt2YkNlalIyd0VhTjBvTmNzZXA2?=
 =?utf-8?B?b1dPT0RORUF2bVpnUGc1djZvOXZnWGhVU1M4RTNibE9sNFU0RktzdW1KbzhG?=
 =?utf-8?B?d3A3SitnL21LWGNkU3FIRzQrckxJUkZlTk1QTXo0NzFZdndjZ3V4bmhHcUth?=
 =?utf-8?B?WmJBZTlCbGtPZ0JHWEppaEM0UUZ4akJ3K2JaZ0wvayt2NTJPalMyMnEvdURx?=
 =?utf-8?B?bkNnaEJ6L3JMSEptelA1a3k5ZVgwVGNWRlhNVTNRQTBhemZHWVVrRkdnUk1B?=
 =?utf-8?B?VTVkTTc5WVdONzBodEFIN2VrS21GVGFqZnRiUmNYSFFld0JaQ1BOZnpDdUlk?=
 =?utf-8?B?SU5DWWpQTE1kSU5GVURzaSttb1lDa1phN1RsVDU4TDVXMU1jUWkyaHlEYlQw?=
 =?utf-8?B?cDc1ZERLd0JEUThXNys1RnoweHJXR3VNdEczYW16RGVvM1N3andiRFN1YUE2?=
 =?utf-8?B?RzNYbzd2Rm1weWFuNEdqMVR5OGxUenRqa0Y5Mnh5K0RVS291dSs2cWtURUlV?=
 =?utf-8?B?bytzeXBwU2lCblROV1czbDBEQWJhUTBoZEo5TUoxVFdZSTg5cGhJZTJJVmpX?=
 =?utf-8?B?YzZmR1lPa1dKclZxTEZWcW9MQ01iOHNIekJYd2UrcTBLUFJIbUhDT2pNYnA5?=
 =?utf-8?B?azdrdU5KOEdoMzJmYWFKMGdsSjFOZ3RMbUs2cSttVVBuYmJhVWg5VjF6Vno0?=
 =?utf-8?B?Y2lRV2ExY2JVUGdDUjlSV3p4NjZkRlRaTTRONEtUcVpqWWlOZWRXUXpHcW1x?=
 =?utf-8?B?K3p3RWNHTzErZGtzbnZ4d0g0cXdiM210Z2M4anpJdHdjc2k5cStTQ3VpOXVF?=
 =?utf-8?B?cHNkRlFRV3FBVTVNSWltWjhXODVBZFdNUmM4ZEp5VFQ4c1ZsT1NuUmNhQ1lO?=
 =?utf-8?B?UUJqSXJxTCtPU2ZxYmxJcWhtenYzbWZwTWZ2NGk1M0FrejZ2bDRNWlFjOVNm?=
 =?utf-8?B?ajNXYitmKzNzSVM4MGpLeGpEZzRBb2JpdWwzNm1zKzlOS1cwVnVrRzhDMjMx?=
 =?utf-8?B?NHNxdzNHV3Rqc1V6VFV3bzYyVWRWUk1Ddy9ZNUlGUXJqRTErSTJwOWZKVktB?=
 =?utf-8?B?UEF6Rit5cVFiV2xUeXpmUS90MVZIaGVZZFhJQVFwRHRHWjFsbEY1ajJOQzRQ?=
 =?utf-8?B?MVZYSGxYaTJ0U1d4VUJYbEp4OWdwdnVSeHdmU2ZPekQwK2lJSTBMc1QrWUEv?=
 =?utf-8?B?VUFwdkN2bnJzTHI2SFB4VndYQzRFUElNTFp5RkNRbjZka2loUm9uRXR3SnFW?=
 =?utf-8?B?WEdUMHF3WENRMmU4U2xBZXh6UFk2dkRaMzVXSjY4SmZITWVBd2dlKzIrYkFy?=
 =?utf-8?B?RFJVVHRCUHhJNzBaSGQ5UStaOG5RM0d6a0NVUk1WdjdFN2tSRlJXUE9iVWY5?=
 =?utf-8?B?RUliUWpXZWhKZ2NZSy9BMlFuOFJsWkNGTGlEQ2Fob0MzOGpIcHViVHJhZmd1?=
 =?utf-8?B?MGpadlFLUkJaYUYyUzlmVEtIQ2U0VVUvSkFySlg5WG1wRVVmQkk2N3hpc0Za?=
 =?utf-8?B?TFlJdTBtRFhYNjMrK09WWG12WjVnNkhOOW4yeC93UThIdnV1UFpQZ2FhR3ZU?=
 =?utf-8?B?eTBFT084ZU0xNXB4VlR6YmwyYThHaVNRcG5zcUN1V2xIbkFmZDJkbk5yZm9E?=
 =?utf-8?B?NnJ0SDRYbVA2SDRxdlNKRVptNVYxdGlHY2pxeEpPK1gyM3VGL2FRRmZ6cUVI?=
 =?utf-8?B?OVJMcG5aR1A5MzBoSmFYZ1kvcnAzSGVaNXZ6Z1BkVVozTVhZaUthTFp5Zzlo?=
 =?utf-8?B?dStNdEU0Z3JJbzA1a0hhWWpqMzJHNjlXdURRaVpPNmhKTklKMW5YZ1gvZXE5?=
 =?utf-8?B?U055RVVTRkZuYW56YTVPVCtORFUzT1RyaWExb0F0NEpzVzRrZHBvY0IvZTdD?=
 =?utf-8?B?eGNYb1hHV3NLVWdCNUR3N0Z3ckxvZ0ZjcE9KSG9seVhqWmRaKzQ2dk0rdmYx?=
 =?utf-8?B?N2ZhdWJIdU1yL01Uc3Arc085Nm5XRTlSa3hoMHZHTzRtYndvYW1CNGw4VjJm?=
 =?utf-8?B?cVQxM2prZDUvU0FiMWRPRVFzSEw0Ky9tMVg1TEFPeWhjaDZ5bDdLOFEyd0JH?=
 =?utf-8?Q?GyCw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ee99ff-14a2-4b29-3e5e-08de3671bf4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 15:52:10.3313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pa+hZ2NlSKGLDTbpTgDWKxE5bQVutpBfh1eX/4MVKjZPl2eWsQFipEihA2T88o+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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



On 2025-12-08 03:40, Christian König wrote:
> On 12/5/25 22:49, Philip Yang wrote:
>> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
>> to GART as mtype RW caching, to reduce queue switch latency.
>>
>> Add helper amdgpu_ttm_alloc/free_gart_entries.
>> Add helper amdgpu_ttm_gart_bind_gfx9_mqd_vram to bind VRAM pages
>> to GART mapping.
>>
>> Add GART drm mm_node to kfd mem obj to free the GART entries after
>> MQD is freed.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 103 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   8 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   1 +
>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   9 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
>>   5 files changed, 122 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 4f8bc7f35cdc..fc6f4daa9b87 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -880,6 +880,42 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>   	}
>>   }
>>   
>> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
>> +				struct ttm_buffer_object *tbo,
>> +				struct drm_mm_node *mm_node,
>> +				uint64_t flags)
>> +{
>> +	uint64_t total_pages;
>> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>> +	uint64_t page_idx, pages_per_xcc;
>> +	uint64_t ctrl_flags = flags;
>> +	int i;
>> +
>> +	total_pages = tbo->resource->size >> PAGE_SHIFT;
>> +
>> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
>> +
>> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
>> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
>> +
>> +	pages_per_xcc = total_pages;
>> +	do_div(pages_per_xcc, num_xcc);
>> +
>> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
>> +		u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
>> +		u64 start_page = mm_node->start + page_idx;
> Don't use resource->start and ḿm_node->start directly. Use the resource iterators for that.
VRAM resource allocated with AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS in 
previous patch, is in one block, GART entries allocated from 
drm_mm_insert_node_in_range is always in one block. The MQD size is 32 
pages for MI300 and 6 pages for VG10, use contiguous allocation is fine 
unless the VRAM is fragmented too much, or I can remove the 
AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag in this patch, and then use 
resource iterators to update GART mapping.
>
>> +
>> +		pa += adev->vm_manager.vram_base_offset;
>> +		amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
>> +					   flags, NULL);
>> +
>> +		amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
>> +					   start_page + 1,
>> +					   pages_per_xcc - 1,
>> +					   ctrl_flags, NULL);
>> +	}
>> +}
>> +s
>>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>   				 struct ttm_buffer_object *tbo,
>>   				 uint64_t flags)
>> @@ -1017,6 +1053,73 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>   	return 0;
>>   }
>>   
>> +int amdgpu_ttm_alloc_gart_entries(struct amdgpu_device *adev,
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 num_pages)
>> +{
>> +	struct ttm_resource_manager *man;
>> +	struct amdgpu_gtt_mgr *mgr;
>> +	int r;
>> +
>> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> +	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
>> +
>> +	spin_lock(&mgr->lock);
>> +	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
>> +					0, 0, 0,
>> +					adev->gmc.gart_size >> PAGE_SHIFT,
>> +					DRM_MM_INSERT_BEST);
> That belongs into amdgpu_gtt_mgr.c and clearly not here!
Yes, I will move the helper function to amdgpu_gtt_mgr.c

Regards,
Philip
>
> Regards,
> Christian.
>
>> +	spin_unlock(&mgr->lock);
>> +	return r;
>> +}
>> +
>> +void amdgpu_ttm_free_gart_entries(struct amdgpu_device *adev,
>> +				  struct drm_mm_node *mm_node)
>> +{
>> +	struct ttm_resource_manager *man;
>> +	struct amdgpu_gtt_mgr *mgr;
>> +
>> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> +	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
>> +
>> +	spin_lock(&mgr->lock);
>> +	if (drm_mm_node_allocated(mm_node))
>> +		drm_mm_remove_node(mm_node);
>> +	spin_unlock(&mgr->lock);
>> +}
>> +
>> +/*
>> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
>> + *
>> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
>> + */
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 *gpu_addr)
>> +{
>> +	struct ttm_buffer_object *bo = &abo->tbo;
>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>> +	uint64_t flags;
>> +	int r;
>> +
>> +	/* Only for valid VRAM bo resource */
>> +	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
>> +		return 0;
>> +
>> +	r = amdgpu_ttm_alloc_gart_entries(adev, mm_node,
>> +					  amdgpu_bo_ngpu_pages(abo));
>> +	if (r)
>> +		return r;
>> +
>> +	/* compute PTE flags for this buffer object */
>> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
>> +	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
>> +	amdgpu_gart_invalidate_tlb(adev);
>> +
>> +	*gpu_addr = mm_node->start << PAGE_SHIFT;
>> +	return 0;
>> +}
>> +
>>   /*
>>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 72488124aa59..cb6123358843 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -185,6 +185,14 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>   		       u64 k_job_id);
>>   
>>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 *gpu_addr);
>> +int amdgpu_ttm_alloc_gart_entries(struct amdgpu_device *adev,
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 num_pages);
>> +void amdgpu_ttm_free_gart_entries(struct amdgpu_device *adev,
>> +				  struct drm_mm_node *mm_node);
>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> index f78b249e1a41..00e1e5b30a3a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> @@ -225,6 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>>   	      struct kfd_mem_obj *mqd_mem_obj)
>>   {
>>   	if (mqd_mem_obj->mem) {
>> +		amdgpu_ttm_free_gart_entries(mm->dev->adev, &mqd_mem_obj->mm_node);
>>   		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>>   		kfree(mqd_mem_obj);
>>   	} else {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index 14123e1a9716..5828220056bd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>>   			kfree(mqd_mem_obj);
>>   			return NULL;
>>   		}
>> +
>> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
>> +						       &mqd_mem_obj->mm_node,
>> +						       &(mqd_mem_obj->gpu_addr));
>> +		if (retval) {
>> +			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
>> +			kfree(mqd_mem_obj);
>> +			return NULL;
>> +		}
>>   	} else {
>>   		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>>   				&mqd_mem_obj);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 29419b3249cf..fdde907836fb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -252,6 +252,7 @@ struct kfd_mem_obj {
>>   	uint64_t gpu_addr;
>>   	uint32_t *cpu_ptr;
>>   	void *mem;
>> +	struct drm_mm_node mm_node;
>>   };
>>   
>>   struct kfd_vmid_info {

