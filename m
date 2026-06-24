Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43CECDB47C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 09:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D60910EE46;
	Wed, 24 Jun 2026 09:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1W/UoTOX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F5E010EE41
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 09:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRxHgr0Wzk8Nwbf8EmeTCCWINPPQ6QSQFBhfYtoVPAMsCbyOj3bZHIQGdPUY/tYgecyfmYHRWboiMUu/+6rcoo8OueBFG2R9xehThfxpnC+u5JRcPxEJlXBE1aqUXh9x4r5hvWxotGwS5H4hkjExycU3XR36O2m+9ExOuKlCI5yE8Jq1p3cuX4iJsZyT4dptMjlpKYR7LVDXrzlPzdnEWXKSvVnG2AhPkdSIexCU4vOuFHMJyvTfI6WT3PMemn9GDw9Km4ErgHaY1QjQpWoqa+eR47SrK3BN/+8aSFY7/pzgeYXJsw3aMToF9KrC19tkREo1dfJaNVPaAVt1tNN3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXW59s4G2e1B+uDE+Eyc2yVtgSvHdpZl0pBMG2CACg8=;
 b=fqx2hLwjfIGAUY8k0sGn7qtwQzLOv9LGCFfI/RHEuenzNl5jCe+ddKz41Z/+sufWrSEFECPmjTuXa2V/2JqcyC+MjVG632hiRRL3iJpCcnsfi72aLB0gV2zTNM3dig2sKbkNWV1ox+kFy2gT1NiGOktwOT3ifRwiEgGsoyucUl727IuOKYRc411wUewODaby74y0Arlf9rNPJnch8MkpTaSeoS12Msmq4usNKt3CcoWOSK0GZMjpl8QeU5DrAsFusBJZYqlFcVLZQgbjiXJ+pEz8pFyTsW6PenMKGXx1aCmAQYAfACEDPiKn5zqmThST6v2DO7XBojHKMcQ06Bns1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXW59s4G2e1B+uDE+Eyc2yVtgSvHdpZl0pBMG2CACg8=;
 b=1W/UoTOXrCBdkVS5MfzaOVBzvvGGkb5xXY+tLdvVQ9z2UuvQrPiSrJZu6duTl7Plbyq6FU8cuql/RsdAMX01ptOzWc7wBtI2jvLl9RMgtX2LgiXUi5J4NEnfEEObhz7xcLKrAQHn4U2xuDwPj5nS+NzlLHRi24oqNAApZ52aPUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 09:37:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 09:37:46 +0000
Message-ID: <efab141c-e08a-4417-bf5b-960078f6742d@amd.com>
Date: Wed, 24 Jun 2026 11:37:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reject mapping a reserved doorbell to a new
 queue
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com
References: <20260624092602.24803-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260624092602.24803-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:408:fe::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db95237-9c96-48be-6242-08ded1d43fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: SQK18EYrkTULkR0gR276BAs+3Q1z/xBTjuaAv0w0O1wnXDFZzZ7+r07lV+U99+oln92QCqyNbIyxIBlQf7vyv1XnQ/6wKVLhjIu/Nk+5nltdPcJN1A5j7j6DTrwzQm8xgp2fTQU6l3hKajsUTqNchxyTtfw5Ixl//LRTPTzPSVUjdmKLxyTz07Y0fYoVHMzb1L393Z7gL1t0oMBiuRx/8r2TFGUhh51XdtreW2dlcukj6S2+vyRODQm/jESn2PKNP2JPjtU3WKd80r3hi4iBtu9xy+BGjAz2B8ngrjrfArZhLZw6VcPLFylfp3GAIrtv29VaXiJAPWWrlg957jzDxBnyito2QbKoxppOhkLqxwztlcTuoZCGhyCiLWDdTredgp/l8CC160bTCGX6YMnY+8T2cVydbMpYoNggV3m32GvB/OE56M1JTMc9G4PmwCXLee4xcCjo/Dd0rbUk3P5cLtysILRs3qzeep3dc5xC7RlBjXPQB9eGBx23bFSNUzsYruhuXtdvRzvFmjemqNwUwGg1LxSNEBTM6+WoBH0S7gbTItX1qIcwAXU3xWrKG0FA52s5dx2nA5gcZZYk8q2DpgZvQDr5uGD0m//nX+O5b7HV2zS7OcEhWef+evVpHWEPPFmbf4FKrOsEjZUmL4ZTpyN+q6XCyZBW99KItZWC1gQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHRUMU9FMy9ZVEFXY0RoYnZJaVIxaHFmM1ZZTVliWFNHNXJsOEJTTUFwdHdI?=
 =?utf-8?B?NlB4UEhKUUpTbUVUMkRoV3dTOEY2OElKd0Q2Uy81TmpYbFZSUHN1VnY4TFFE?=
 =?utf-8?B?bTZua1o1cDEzNzAvYTdJZUhpS3o1a3NnaUNPSXVsQ25OUXlkZnc4TExlZVNL?=
 =?utf-8?B?cGE5bHBVZlhqZm9vSnJLaUVmV3RpSmFMV2hiTjg4USsxYWMyM0RpWEdJY1Iz?=
 =?utf-8?B?NmorMW1FQ2M1Tk1sWFMvZzFMUklhTVpRYTdGbXNvUEd4WlUvaGNMZEZHZWhE?=
 =?utf-8?B?TlJCOFloQ2xxYWE4NER2MjRJRmxsNWJBMDlzamdoaEtGNU43aHRpUEFsdFMx?=
 =?utf-8?B?dUNpV09jM0drMitsaEpMRXhXenJqcDNiV01HdVJxRXROVW1zTGpRZlVwZ0lN?=
 =?utf-8?B?UlJ3cExkRG1YbUIvcWJjSmpaTjdHZ0JSY2xsN0IxcEt3Zk4yMHowa0VIdmQw?=
 =?utf-8?B?RHBrbXBtc1BvRjBYeGF5bDFpM2VsVXBwa1NrZGtlOEYvUFYyOHkvcFh2bmdn?=
 =?utf-8?B?cFZsVk1BVVc0b3hpaUZSNThoVE9oaFdST1J1T0NsdXduaklabnpBa1BoL25Z?=
 =?utf-8?B?QmhXZjdwZ096UHhRRkdYc0RNZDFsWmVud0xDNmpoMUtHblpYamx2RmtkL1I0?=
 =?utf-8?B?SFNkN3cvV2tHT2c4bURDZzJQY0dkRTB6TXZxbDc5dVNySmlqd3M1Zk9menZh?=
 =?utf-8?B?cVlWcldDTHlib0ZIdEtiTFpnVi9MS2pCaFBmRFdUZmN6akxPVnpBL2I3czhr?=
 =?utf-8?B?anQ4MU9LcnA0bVRmSUxFTjZreHFTc1M0TTMxYjhFak1DWXdLSlJBUzY0ODR1?=
 =?utf-8?B?OEpmNE51a0hPeFV5QW5WM1A2V2xudjl2VGVyRVQyM2R2dWgweHhYME44Yitq?=
 =?utf-8?B?c2dlYnlQMVB4ZWtzbU1WSi85OHEzNTE5aDZNTW5KZ0p2dit0M1d3dGVLeXNk?=
 =?utf-8?B?SDNPbFo5bTVTN0hKejZ6aUptVVBCbFF0N2N2akRyM2NENEE3YVVkUmk0VUpF?=
 =?utf-8?B?NE9OTnRSMWo0R1NNYmtoVzY0UEZyWmJQOHZZNzM3SS9ES3lORW4yYzBYVHFR?=
 =?utf-8?B?dzNHS1NSa0Y5MDArRGFUWXNwNDVKR01idHR2WEpQMG9kUVlwbi9lQjBHWGRL?=
 =?utf-8?B?dGd2SGFCSXQvQjJTZFVPUGxGci9kRjE1V0gwazZWd3pWaS9aVHVyeTNRRGE3?=
 =?utf-8?B?cTU2QUdpWDI0L3lGUDhYM1o5U09HZkhSMjZMTGhEN1lKdUNQMjhPSzNDUnln?=
 =?utf-8?B?WXl4MUdPbUdoTi9iT21jUzh5UnVSa0ZQL3FFeFNmMXV0WTdyV1JXem03MUIv?=
 =?utf-8?B?RHIzVnhUVkMrTE16QW5oaXZrM01LOWRlOGpyWkovZnhyYklSTVJGOER3WFMw?=
 =?utf-8?B?RDhJSVhDK0JETzlEQ0hkQjMrL0s1T1JCc1l2K0c4QVY2R1h6UlhUZmpScVJF?=
 =?utf-8?B?Tno2WXU2emJjV0s0NVBnMURzSFpyeWMzOEh0WEI5NDRkaFpVRjc4dWtVUFBD?=
 =?utf-8?B?T1E5aFBielZ5OEFVUGRVM3V2V0RPUVU4RU84cjgvTGxDdzNjR3R3amJjUEdj?=
 =?utf-8?B?dmRybzRicGRtYStHa1M1b0pvbEh1T3VOVy83b0pUZXRJdWd5VlBkZFp1QWll?=
 =?utf-8?B?Rk1uU1NKQVdrNEUvZkZLUUVvSHRtK1ZPbndBVlcvQzh5c0EvSXRqUnhOVDhT?=
 =?utf-8?B?TWNaMi9ScDRlWkpvOHNsUlNvMHlWVWk2QXBYdXFoUGdsb1BTeDArdVRRVWJZ?=
 =?utf-8?B?YU5HMnpvM21YeDd0ZVZNL3BPYUp4c0NLaGhvMkFobG9zS1dyNzlPQkZlREwx?=
 =?utf-8?B?Q09EemFjd1hmaDFnU2VPVm9NKyt5ZndLNkR6eXUyOExyeUxRTzk0bGQwaWJS?=
 =?utf-8?B?WXYwVGRyaStIV0lDakZWWGF6MVRpV25vZldpMjFjc1pzRDJoeXk0bWpDTnZp?=
 =?utf-8?B?TWJZdTZyYXk2KzRDQmxjMTlIWm1VK3JnTDg4OHgrRFp2aFJSYVF6MWtjL0pE?=
 =?utf-8?B?eDZrS2JzbWlDWEJIYmFBZHZSQnlhY3lIb3pzWFpQbXhXWmwzVTRxMlVtRUhF?=
 =?utf-8?B?OFNldC8xMmR1N3kveXovU0ZqeVpYSjRNV2U5Q0FrODI0cDNPSTZYZEV2clI4?=
 =?utf-8?B?ZUJWN25BaHpncDV0S2tmL1FXZjVHYmJ6Y2xvdVVSS0FFeFZQaEdSUzQ5UUlo?=
 =?utf-8?B?MkN4c1BFa0o5ejRRMVd6dWxNTXVyc1NkQ2ZBblZxVlBkcyt5ODhwb3FNMHRM?=
 =?utf-8?B?ay9YZGwrNThKeFppWE1UVDk4REs4bnZVM2dtSjRLVmVUU2xHSU1Ta2RkVFlj?=
 =?utf-8?Q?gb5DDnafT7ajHZ2r0D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db95237-9c96-48be-6242-08ded1d43fa6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 09:37:46.5750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOTJehllp5PmQzxyoub8/OniRCzlyVyP/4r48KwqIPcudlNSVHtvY6sLm16V58bT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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

On 6/24/26 11:26, Zhu Lingshan wrote:
> When creating an user-queue, the user space
> provides a doorbell BO handle and an offset within
> the bo to obtain a doorbell.
> 
> However current implementation using xa_store_irq()
> to store a doorbell, which allows a later queue created
> with the same BO and offset parameters to overwrite an
> existing queue and doorbell mapping.
> 
> This can cause problems like misrouting fence IRQ
> processing to a wrong queue, and mislead the cleanup
> process of one queue erasing the mapping of another queue.
> 
> This commit fixes this issue by replacing xa_store_irq with
> xa_insert_irq, which rejects mapping a reserved
> doorbell to a newly created queue
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index f45bc8cb815c..fb7e18c841ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -704,8 +704,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	/* Update VM owner at userq submit-time for page-fault attribution. */
>  	amdgpu_vm_set_task_info(&fpriv->vm);
>  
> -	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue,
> -				GFP_KERNEL));
> +	r = xa_insert_irq(&adev->userq_doorbell_xa, index, queue,
> +			  GFP_KERNEL);
>  	if (r)
>  		goto clean_mqd;
>  

