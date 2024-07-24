Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4832C3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 06:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7614B893AB;
	Wed, 24 Jul 2024 06:47:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nK3cxQSj";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F79893AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 06:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7lVKMYtbOS40ZSUpIQ25L7hDjqyMwXkCSVA03aKcoqC6hvI+6nVKTZNtid83jVm6Q+6Eah/NW9TITlqIJlevsQmebeqaiEmx+X3g9b8YMcs74mFt8ht56lEa3WkKaiUftJW6IwXQz3qp7k7WCkMroYoICK+BuPODmdPaQrK04cV+JdjVBIuRTGG7d+XQ9o+f4PAUBwQTdcF8Fo1KOJBKm61ZHea08WkZAFsuSOrWtmrEM0fQFM7J4IQuknkzpzalZXGu+m1pTUS530RqHLzI5q6Uejxkoe5bRgrZ9uEuWYwMmldPynMk2Tgrw7OGJ5O3P7A16+imllYK0OMhgIy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+t+X4MTJwAdm1bL7ktUDK6JQNwzOz/kutgFBsy7ocI=;
 b=Lhuz9ZLo6V2IMMqfUJ9InCT0mvdsF9rg+0A9oyynHRQdOr75FQUVF9RX+6jP9l5e4qCjrvecSCXTkz4PsmAArJzqG7Pr1n/9FXy797vr97OSkoyoBVPU07ugPU5U/5ZCvBh3vJfZYrCv85adPoshQVkcsm97b32tNU620Vclb7FFgjYVyRtDZ0+rUdyrt1/q8kUfwe0qUDSWxH7urgXHcBzFflKWmWigRnlG7gKN21ytqSmPUT78QCOOiaAezoM83C9Q6Qv7FiCbYkJPkxyELI9O4DwPHzBGDLmjQfRKhq2NtZQAYVPvYcJCzDFmkIN8jwccFT/TvGODn9bz+CbbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+t+X4MTJwAdm1bL7ktUDK6JQNwzOz/kutgFBsy7ocI=;
 b=nK3cxQSjd2ypWVsvhi5Wbv6cN2bSHYwnTYcdDOYw2GY+1IanJOwm3DHZVHXdAXKGvuRvXtFlvLWKIzoJvaFAnnBKWOfBRBDfgxToNJt1sCXggUcgfN4wflT6fE1tKavLyuMbh+wRB5SqCSTqn02tO2r2UNGJCUuOxNtlPhJNL2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:51::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 24 Jul
 2024 06:47:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 06:47:04 +0000
Message-ID: <ac74832d-fc2b-447b-a51b-582597f06de9@amd.com>
Date: Wed, 24 Jul 2024 08:46:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: reset vm state machine after gpu
 reset(vram lost)
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240724030036.1350316-1-zhenguo.yin@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240724030036.1350316-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 20990aa3-ba79-4727-b9c8-08dcabac6d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M28xRDFvcm1oUDE2Tmh1Q2tZV3A2b0FRVDBCL0NQelFab2NQcldmVTloQ2ZR?=
 =?utf-8?B?M0Jjc1dWNHRLNmNCc2d3RTJCUlp4ODJxa0dQRjBRTWVDS3hESDlFQ0ZvUHVJ?=
 =?utf-8?B?RVM1QTBtMXJTOWVTUG5qcFVGNm9GMXQ1bW1WdStnYmJNZHdWT0w5dlBGQTBy?=
 =?utf-8?B?c2IwcVJkNURveVF1U2l0RG1yU0JqVmFqMkQ4ZTVlN0VRbHRRTVNnSk1lUVEv?=
 =?utf-8?B?cDlQZmZxSUdobHV0MmRQc2ZEc0F6UE1oM1RxRzlFYVgzYSs3dnhlYWRWMVlN?=
 =?utf-8?B?VS83UUszMHJqM08wclVlSGtTcmd0MDRmZG14WEtBTmI2NEFqeU1Rc25SSzEx?=
 =?utf-8?B?b1BEWTNhdnQrWjQ4bjJUSk1QUVVOaE5lN1BGMUhFLzhzem0xUEVGdS9Wc3lw?=
 =?utf-8?B?ajBLZy9aV1pJd3NiRGdpU2FhUWR6MGdVM2ZPMTMvV2JSeXlnZUJaVWsrbGxX?=
 =?utf-8?B?VEdpbjNXajhiTzZrMVBNT3QxcWxXMW5wcUZLSW00R0U1Zkl4QWE0WTZWcnZY?=
 =?utf-8?B?d0pLdFIzUytNd0NwcHlqenZCczUyU3pnK0cyVHRJVkg4bFVGTHUwRnVGcnBZ?=
 =?utf-8?B?a2VhWHV0bk9mdS9lUG51dDM4SXZzY3NYQ3djeWNlUW9CajRuWlhkVkhOUWNV?=
 =?utf-8?B?elRZUU9qbjJZZ0t4cEV2SmdSQlp3ODFvY1VSd0NpN0pKYXRyRXJHN2pUWU9O?=
 =?utf-8?B?TUF4M0p1cmZFUTJ1RENXazBMMHZTK3ZaVFYzdEJ6TC9sK1dpVXBpbzJuaXY1?=
 =?utf-8?B?UjV3MGRmb1Q5THNrcjhBSkpXcktidVRhRVNqM2R6eFRzbGNzKzJxd2pJQzBa?=
 =?utf-8?B?cVN0Z3dTaGVLTWFOa0x3MTFKUGl5VW0yZUNrZGVGUnM2L1pnMU9TZm1tWm5h?=
 =?utf-8?B?SFdJZ3RaS1g2RzJObUFYb2tlWEFrWm5STFJBOXMya0h5ekdqWjR2VWZIQ1FK?=
 =?utf-8?B?UHo3RURNTEEvSTRWWng1Qy9BQmhoMWdSbkxFZjk2VXNtVExNZjZ4alBjekt3?=
 =?utf-8?B?V1BVVitrUG5rbTFvam1vWmxWMm9NMURkSXAyRnUzc0R2MDRZMTFCc0xMSFVj?=
 =?utf-8?B?ZHB0U2RhdFQzZGFNdDNrSjIvOUJmTGVjaldzL01DR3ZCc2dldzV1VUZFK0Uy?=
 =?utf-8?B?d2E3cGFjVFpLT001QWN6eXZzRU1MODZxOEZOWEQxbUV0bXVQRDFNVFpROVpp?=
 =?utf-8?B?ejhqNUdEZmxoVnF6OHJlOUxJdkNjTW82M3l5WVloZERQWE5BUjNKTFdyMm0z?=
 =?utf-8?B?ZUFzQmZTaEducm1ZUjJPK0JSQzNKL21jdzNBaTNyaTMzVWJ6N2NsdkFXellX?=
 =?utf-8?B?NlBOV3J6cUdUQlROOVpXR2YvTkxaZkFVY1NjemVCdlFYa000TWNNdGpTTThM?=
 =?utf-8?B?aFNXOFVNNXRYMGFibWxUOHdEeHBxYTN0dmVUcmIzUXpIMU1md2NCL1FKSUVR?=
 =?utf-8?B?azljckc2aTI4L1BXVnh0Zm1nWFdNV2cwVG1UY1Zpd01Lc1l4ZE94TjBQZmtm?=
 =?utf-8?B?b2x1a1A3RlFucUhWaU5aU2RPWVlzakx3Zi9FYXpycEFmTFQ5d3dwVEdibDRa?=
 =?utf-8?B?aVR4K0xtcjVqdUZNNi8wTXZJTUtuT1hGL0ZPTjN4KzlCWWdhZk5oTFVOV1lC?=
 =?utf-8?B?MW5RYVRncHRrNlh3dzJhSXU1Z0x4Wjk3bDFneDlHdHBKSHA5WG00TjEzODUv?=
 =?utf-8?B?ZDdFMFFZM0x1WlFURFovMlVNdWlEdm9jM0RjaFZab3FSOFlQQ1hyazdRK3Y1?=
 =?utf-8?B?NU5FOVArLy8ycE4xQi84dmx6YVNWNDVKR1ZhWEVibzRmTVU4cnMzYUI4YThx?=
 =?utf-8?B?bmw3M0Y5L3J4VGtyckxlQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjQwSG40QVMreHcwZjN2YlprY0ZxcW05aTMrS1JOc2d0UlZwd1lqZnVvL0pj?=
 =?utf-8?B?L1d2RmtWVHJ2aU5EeHNRU0twQVhYL1IwRDAwZXdkTGJVdGlOTm9TT1ZmbGpF?=
 =?utf-8?B?TmZFSWgwMVhNZHpCQVlhcEZEMzZWVkdnNlhoQWNIV2ZRMWtGai9xaGMzc0o1?=
 =?utf-8?B?a0l4NXg5Z1UrWHR6WTlMQnpFUzNGaWN0VTcrV3FzYnZvOWpHaEhveHJpT3lE?=
 =?utf-8?B?M21aVVFKM1hpbExVMlE4anp6UTg3QUp6WFM0Z0dyZ2RrYlVaWG4xQzBmMDJ4?=
 =?utf-8?B?RmNYL1Nvc3lOVlo0cTJtYlhHL3gwYzFqUWh5SjkvV1l2ZXdIOE45aWVkSjZB?=
 =?utf-8?B?Q3hob3hxdXlXNU1hclpyVzkvTlFiM2JsOTF1ZlduQjRFVFBYZUhxVDVLKytL?=
 =?utf-8?B?cnFadGhDQ3IzOEVLYW9ZWXBWUS9lb3h6QWxheXA5aGx2Z3U3SFRqdm9rTXVy?=
 =?utf-8?B?N2pMbDl1dHpmVXVMeWp3d0xrWmxMN0hWRmZ1cTIwaG5vaTZpOThRN1pTOE5E?=
 =?utf-8?B?ZjRUOUVZVGQ4L0xCZytwMmQ4dzNXZFNiTFlka1h6SlF2SVdaL1NtSkFDVUJt?=
 =?utf-8?B?VGxsb2h5dEhYUk5meEdjZzVmbGE1b1N3QzFaZXBCRm5KSks2cU9sakJwN2M3?=
 =?utf-8?B?WGdHWlRmS3pMSml6UDRXRUw5cHZwTlg3YkxpUlNVOGI1SzB5b3VseVdjcFg2?=
 =?utf-8?B?eFVDa1BIOG1KNHV4WmMwUnk2Y2tiWGRENThoeHFOMDhzdWdOWTd4eFZSMXNm?=
 =?utf-8?B?emI5OXF2WkJzQmlHdFJTUitmU3p5MUdSN29ES2xvN2VtWVdSVUpNeFp2UWIv?=
 =?utf-8?B?bWR2Sm1qOUNDMDNESnNoSG0wd1ZUUTJpbnBUWWJQeEdkUlI1MTFHNWZ3TlJi?=
 =?utf-8?B?czcwZzZ3cFU2RjFSa1RRa3RuQVFTRVhTUHppL2pYL0tZOU1Zd1lGV1F2ZFpo?=
 =?utf-8?B?ayt6dTV6UXd2MkJPK1BoR0ErQTRUVEdTdjNVZ0EvZE10OXAxOGpVRUpjK241?=
 =?utf-8?B?SmhseGp4RG9lRkdhZVpaYnZVM29YYXVQZ2lWeCtvK2h6aDR5a1lBODBZTG5I?=
 =?utf-8?B?TnZQMi9uSFpBOGluQmU0dXdIbzhZWjc2NzlnclNzSVBSNm9NdHhZRExEM0pO?=
 =?utf-8?B?eHI1b3c3czBjaDBnMXlTNHFsazZRb0xXSDlWZ1lCVGt2SG1aSUVjazBGM2NX?=
 =?utf-8?B?NEtCTFlxVGM0TnZEYjNpSDdIMzQ0SS9zR3ZOb2VaYStzK3phR1VIemdiZDdp?=
 =?utf-8?B?T0o3U3ZvVUEyK240MnhtSmthN2Foek53d2c2YjB1OUw1bTN3UFVnWnNhNUZM?=
 =?utf-8?B?NHlPazhzSUZyZ1p2bTVYa3FKZ2JDZGNNQjNwRXRsTnhXNy9FSTVtTElrcjhI?=
 =?utf-8?B?eW9lTXVZN0hzYW9id3VTVjJaQjZoY2J2NzN0MjFtc0lENHNCS0sySXYvK3Fv?=
 =?utf-8?B?YUp2RGFyMlVFK2FZY3FpM1VMM0Z5cS9waE1sV1JwRU5LVWZ6QytXZERmV0JX?=
 =?utf-8?B?dkNGVlRkQVhNYXJkRFQ0bnppd1poRkFwQ1kyL0pjUFJ0MUhmTVMyNFFEOEtB?=
 =?utf-8?B?ekJXbXp0dEFIM0xXTXF4Vm9xT0pTY3lIVmZtcmU0S0RDRSthSS9jSGtudHFn?=
 =?utf-8?B?S2tzK3Q5UENQUmQ0dHNjYi91TDNBRnJodXJhZndtNzVpRzhFUFpDRngrN1pi?=
 =?utf-8?B?c3R1Wndkay9qYnFBN1R2aHBtZk5VWmEyNUQzWnJxTHpNN2ZpdzR1SHA5OFFQ?=
 =?utf-8?B?VUlSSzlSTVJnbkVPbzIrL3Mya3BNZlcvc2twT1pWWE1KYTRKYWl0NGI2VXd2?=
 =?utf-8?B?Ylk3VlcvcnRhdnYzME9lWm1zQk15eTYxVGVyTTVqTnRWWml1QzBhb3VCQ0th?=
 =?utf-8?B?SGZJcmlOdFMxRGpINWROWWJjMHhGUXZFbWovLzl5SUFkbTlQV3hqVVFCZFhk?=
 =?utf-8?B?aXRtKy8wZ3hwT3NxVThjZjIrL0F3Q1BHSzU4T0RqakRXUzZrREh0RkdwMUFa?=
 =?utf-8?B?d0FNVGNJWlU2MS83c2UwOWpNTm9NNDZaQjM4WFRMcjR5Y1I4eHNiRm5Xb3Az?=
 =?utf-8?B?V2JnMWMyL3FzVjRENFVBSzZ3ay9uUDJRYm5VSGtvMjVTN0Vyd2NTaWtWN1Zt?=
 =?utf-8?Q?NnGw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20990aa3-ba79-4727-b9c8-08dcabac6d96
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 06:47:04.2131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLP73QEGwAfIFA1IG1+WarLU0wXiOiTSuWjU1Hlkdya7HIg/z4X1rSPudW/kxvWW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097
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

Am 24.07.24 um 05:00 schrieb ZhenGuo Yin:
> [Why]
> Page table of compute VM in the VRAM will lost after gpu reset.
> VRAM won't be restored since compute VM has no shadows.
>
> [How]
> Use higher 32-bit of vm->generation to record a vram_lost_counter.
> Reset the VM state machine when vm->genertaion is not equal to
> the new generation token.
>
> v2: Check vm->generation instead of calling drm_sched_entity_error
> in amdgpu_vm_validate.
> v3: Use new generation token instead of vram_lost_counter for check.
>
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3abfa66d72a2..6c6170f0f318 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -434,7 +434,7 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	if (!vm)
>   		return result;
>   
> -	result += vm->generation;
> +	result += (vm->generation & 0xFFFFFFFFULL);

Please use the lower_32_bits() macro here.

With that fixed the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Thanks and sorry that I didn't initially got what the actual problem 
here is,
Christian.

>   	/* Add one if the page tables will be re-generated on next CS */
>   	if (drm_sched_entity_error(&vm->delayed))
>   		++result;
> @@ -463,13 +463,14 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       int (*validate)(void *p, struct amdgpu_bo *bo),
>   		       void *param)
>   {
> +	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
>   	struct amdgpu_vm_bo_base *bo_base;
>   	struct amdgpu_bo *shadow;
>   	struct amdgpu_bo *bo;
>   	int r;
>   
> -	if (drm_sched_entity_error(&vm->delayed)) {
> -		++vm->generation;
> +	if (vm->generation != new_vm_generation) {
> +		vm->generation = new_vm_generation;
>   		amdgpu_vm_bo_reset_state_machine(vm);
>   		amdgpu_vm_fini_entities(vm);
>   		r = amdgpu_vm_init_entities(adev, vm);
> @@ -2439,7 +2440,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->last_update = dma_fence_get_stub();
>   	vm->last_unlocked = dma_fence_get_stub();
>   	vm->last_tlb_flush = dma_fence_get_stub();
> -	vm->generation = 0;
> +	vm->generation = amdgpu_vm_generation(adev, NULL);
>   
>   	mutex_init(&vm->eviction_lock);
>   	vm->evicting = false;

