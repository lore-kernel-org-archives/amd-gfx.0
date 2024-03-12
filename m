Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912F8C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 06:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D844E10F020;
	Tue, 12 Mar 2024 06:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p/DFR1VR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2670410F020
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 06:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrX8KfzD/7IkT9fX6S8DPpzguyEK4w5CobU7fP2CsV53dWVvwOhktmj0VFhA92kW3TDmn/mcxUZmb+zSQRRxlp0rsAgeyebD+eRmxLKnoynMQtzfthLqHl1i60bCb3kpgf6OB4xRTXNXsr7rrdEYo/9xadtQA54bEQ6doU6cx6uLYfuT4po5u0hZNgGDZ1L1xGss5UtCFdcLpkwj4yUCK4MVfcM7iZiV88I4hIFqOqRGGDudXXQ9Kr+I9faxzV3NWcbU6LdCuE/bEot6tppmjO9EaeOF2LW22SsYjQgNFm+PZSyBzDfTQbY+BoBfLQERM3NBDW6J1IR1GFP2oHy6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64TZZZw2Fhp8kBqKf1BLpSK/OXpcdexH2aXQLNxV6Yo=;
 b=G8vY/NoTSwUgKybwuxKNFU8TAeZh+Xd74JLZLJkhHkMpYyqZuTBCaRbgT+5Z7Rro8eEVkH/UpVTJLBw6Cp8lNl7azdcaYnyzR9mXVH0HDW1yUQuob6j/eXmfkNb9QiqjflPxxWY6ulhmzrXiFgm6jUqEua09zO0z6vkZ0ma3DV37hPu0WW9er5SsFQCqRl+k4HR8NmlUe1o67PGOZpjYPtVZE14TY9eckEKePxaUQ0XcxsE9UzoIbH9t3kSh5Z7q7ec3vhmyTUHS5JoLvnGHovuWvx8g0NIEf0KKoiubcC9qh0TDAFVOIgNzpq9RHTuKY+Amn0r8e62hVkVhhXLtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64TZZZw2Fhp8kBqKf1BLpSK/OXpcdexH2aXQLNxV6Yo=;
 b=p/DFR1VRGcvJaxRm4lQbJb4J5PbJ1Va31MMKw2jQdONXT62vnOUKcFCMmK6RuHmB0IKdGDjjdtjr/4vmCsh6i9fR0Wiwau/xRnqXJ+Z15x94VPlPZO26L3bqw9460n6e6yJe0u3/++3tc9YeJwIPwESditetoWr4jDB2uFKvx+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 06:35:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.031; Tue, 12 Mar 2024
 06:35:05 +0000
Message-ID: <dc026133-0071-4e3d-8b91-1b02f0fc178f@amd.com>
Date: Tue, 12 Mar 2024 07:34:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240311222119.29917-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240311222119.29917-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0353.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 446b0642-558d-4580-d35b-08dc425e8dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MV3lejtzC9stFawRiAt5EigBmdqPwkX1+pVmEmLwPkn6/qdrTaLsCLle3GsY3neCeruSCY8WbNHh0qclETRxCGkEkl1qiZ52VTkq58XYX8P7Pk84nVRPCzvwCqfnZWhF3CuEYbteyhMiAAYbuK80M1gVSvW4upeWB2PlPOMwhoRhZplCyiV2BTJN2F+qX2tCo5tTHOTj3llIQiRurcwOZKNpo3bOwX5QQte54ilddaYBUthTFuchUku4nFsulTxnNBXv1ODtfwSnzzyL/PqInfUNbwP0Yf0S1ep/ez/bSRmBfexPlhtdbwtgGlpmyrOwONN2mZnPYL/jiHBQHfg5hU7TIvF32IKB13dyCINbf6M0ieeC9+Tj8qI+k7olEcnfK/VeN562eOqT3BLFA1JeQcRtd/ydEozM2FkNL0X3vIQRpm/EL6Jt6YYKZAvgoigaBweSly0v0cJcBnlJ0xXWREJA4odDbB6bE3BMuWXUYhusxBRx6FyewDJXOLxZOfja0xXviIbzyFWXCOn03WhVz4q4gMIhjPl+fr4UevunF6S0OHVQk2qcf8+aYHR6mSR/87bvBjHwzJGFJ+5+QB60tZyMNno7wE88U5gq0C0siYisjgNwMP9WLk00HdOitA5UUcOdwOUWY4azBYWF91DB454eTWbRv7hZsUcEdrwtfL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1pyd3BYRWo1dnlYUkJYakU1OE9ucXRQd3pQUWZ1TmlYNDhQcHZvQ3orTjhS?=
 =?utf-8?B?UTdXM2tOcVJzVXEzOXdsWFVVZXdlMFE3OVFPQVFUbytyMjQwaXpWVjZ2YzE1?=
 =?utf-8?B?aWdIa1NTNWJValNUQWZnQkNTM0p6RjdsQjNwaVB5NjFkRzFVYjhnam5WM25l?=
 =?utf-8?B?UjNXSjZtMzBROCtNUkIrUHIwZlhvQzZBMUJrWmd6bFF0enJqT2pzTE9jVmVX?=
 =?utf-8?B?U0lxQ1hsQWw5cUpQYnN6RUs3VnJscjdwUmF0dmdwZXdleFJ5aCtkTlJHZFVR?=
 =?utf-8?B?VVZFWS9qa0lsUVgwcS9ZbDlHcmloYWFUaDkvdSswdmR3cU9KZDhKS3lRcjNz?=
 =?utf-8?B?QnRGZWtzTlVHSUlBNDRja3N0N3pramNnU1k4NWZkQUdzMUp1RytQbVk3b1Fr?=
 =?utf-8?B?dWhYbUI0QWoyNE9aM1NONmtOQ1VIY2QyZUxWMVFxOGZGVlU0NVdjdmNnaUty?=
 =?utf-8?B?K3k4ekxzR09ZdWRrelIyZDNYclVzZzFVQnF4TStoZnducUsxQm1BaEJoQklw?=
 =?utf-8?B?WDdoNW0vdHpmWjFac1VKb0xhOWdTWGlzYVljSEYxUFU3d285T2FNajJjMk42?=
 =?utf-8?B?bi95bVN2bkVOT1FXMEZjSzY3dzRUbGJIRFA0OUV0QkFiWEVLVWpYUm40YURE?=
 =?utf-8?B?aWt3cnluNzBXTlpGZzV1VTBISy85eC9aa2UrQjI1WWZ1WHpKdWVZNHZuU2Qz?=
 =?utf-8?B?T3BwUWpIZVlES3BESXFiUWQ4V0ZObFNHUU40Y2pFSFNMdGZoUkhpb1BBN3B0?=
 =?utf-8?B?ME9nV0YrUUhMOEF5OFByZmpySHY1Um9iQXBCSllqWVBTbm54TGEvdlVDTXZI?=
 =?utf-8?B?RWFpSXRiY3NOckxvQUVLMm0yYXlIazVSK2wyVUJubTliZE9XK2UyNGhFb2Ex?=
 =?utf-8?B?Rm4vTGcwelBERWszSFJBajdndUtZUXlsUENKSktoNGlPb3JNdUozS09QN1JY?=
 =?utf-8?B?YWhqQlZHRkRzTUpTRFJpZEhGZFMxWUdYVXFtNDMrYWpyUm1YV3dwSTVNeEt5?=
 =?utf-8?B?T1N0YkhtNGZ0OW54QzZDTjFjQTFDak4wbEQ0NmdQZ2J2dDdqWFZKcktvdXVM?=
 =?utf-8?B?QXpQRUs2cDBtTStadmFGVGxTSERQVlEvZ2FhTVRSMG8xMlJhNyt4YUtvaEFI?=
 =?utf-8?B?TlJJeXJDWHFpRG42UncwMkg2U0RIR1BrYWlUZWFOTUNkYitZUXZCMVREVnFK?=
 =?utf-8?B?Uyt3a2NzUTZzRDZoQ0VwSDZHMGdyQmhuQ0d5QVhJSzRwZjh0TXdnUmRRNXR3?=
 =?utf-8?B?YUp4aE5kM0RFWEVUZWtCQnltMm50eFFuMUlmUHMwRTJ6dGFlV094MWxPSUNz?=
 =?utf-8?B?VnIyeUxXZmhTM3JGZWxSTUF3NnV1WDJNMTRaU0hPekJVdlBnUUt6bmlHd1lI?=
 =?utf-8?B?U0h4SXhZYnQzK2hyMXczTzFydHUvK2ZFWFlSUTNGamR0VlRCdDdBWkxWYjIy?=
 =?utf-8?B?NWo3V0kwUjVYcUpIemxGem00Q0FUM0R3UlJjTjhCeG9sekE4eG1kb1RnNFJi?=
 =?utf-8?B?MWZZV2M4SjRZTUJ0RnJELzFvVUhrSmt5KzMydFVvelhQRUtjeEUxdXdrVUJQ?=
 =?utf-8?B?bFIvWU5laDQ2eG1HVGozSWNKM29pRHNzTnE2TllyNmdGMDBycGhPaDk5R3VZ?=
 =?utf-8?B?WkQ5bVdIejVaMTFYeUxQdXdzcUQwVkFraU93eXRjTUc0T0FnaGRxUE9Jc1JI?=
 =?utf-8?B?MHJ1Y0Q2T0FGRU1DUGRYeUpxK0Qvc0laWlZHTWgvK21ueHU5bEJDZ3dyOFdQ?=
 =?utf-8?B?ZFU2U0VxT1V2TVVDeEh5ZndSeUJwaW91RHZqWE5semRrYXhjOFdFai9hSnhZ?=
 =?utf-8?B?OXBvQU9HSU82N2lDZTJHN0VVS0dvR2FnUm5RWWtmVjNhdy9VaUlOcE5VYUU2?=
 =?utf-8?B?V1paZk9uUEcwalIvZlZWQ3d4SlpZcHdtcE1uV1lwQVZlNTZDVExSTzBRcHZS?=
 =?utf-8?B?d1Z1aHFpam8rNmZMczJsZUl6WjdBNVZ0Y0owa2JwRWF4MDRqNjVRMkVua1RT?=
 =?utf-8?B?VUlPWlF3a1lVTmxMRkxTQzR2K21zSnhyNUxRSGhPUlNSSDdxdDNBZENWcXJX?=
 =?utf-8?B?MmxVNm9YNStvNEdORjF0a0V6cWtaQnJNM0R3QlVENUY2TXkwWmtsQjZkZ2RR?=
 =?utf-8?Q?toVM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446b0642-558d-4580-d35b-08dc425e8dc6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:35:05.5354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onpdp+X32M27Hu50xJictmjH5c6hVI0+28M2peb468weUSTDLGfsXyVwCUVMXGGW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
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

Am 11.03.24 um 23:21 schrieb Philip Yang:
> Otherwise amdgpu_ttm_backend_unbind will not clear the gart page table
> and leave valid mapping entry to the stale system page.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Good catch, that bug is probably in there for quite a while.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 75c9fd2c6c2a..b0ed10f4de60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -869,6 +869,7 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>   		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>   				 gtt->ttm.dma_address, flags);
>   	}
> +	gtt->bound = true;
>   }
>   
>   /*

