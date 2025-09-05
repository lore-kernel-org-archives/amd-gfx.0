Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DC7CA1013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 09:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DAF810EB4D;
	Fri,  5 Sep 2025 09:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jqoY/Zxy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB9710EB4D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 09:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNk3TiRyt74kxJMZkyitobRJr60bzft2++A9DUWNUMwJL5j5ppFY5FYKS10pqOF8QpLF/YNL9Cf+gZCh1emZ1DpS0y7mGJVu1+yoHev0SzYTKNJZxHG1Vg1UeQNODmRaF+8C8onaNVj7BeMASvGVGuWAIVZoKbHEFn1ed55pd7trcfOTjKCzTGeQX2d1JlgSwkqTUTWSHWsb/T+TjTiyj0l5gHDE056yZRtaurlTwEaIEnlbkMzk4QdDHlF5u05UGkAb9rr2tB90abVLSy94idHBq+/eLlYACmha0MbK5GJ9GO2R760KNq/7FsJTzAdnWZ62nCSXxzYSrhqwkn7FsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSLuYD3F8KNKuVAg9GjguV7+tJCpH95nwv89cgoBTsc=;
 b=lwjQ+wlAwvaLjZ/Ung+i3bWvlD7guISDZ1rCE0x56ukas2lar+rKjNdUIE1jfYl0pnxdJIaASzRwd2pG55lpQpHAD4A6vEB4SqjK/KMM9KVMlDND0TkbJEkApfUN7q7ebFoUsdWVBfAB+Xa1416HnqbipZ8GRPHbKZ8zjWeWac+r5MgvprBOQWVD9gXTLUD3Jgcj7S035HsZm7CN2PnxVMmEMHuB5D8KRYclFSv16fS2cPoMkNdd9LrAdgS8hutes7GR+MHqVjWEoXbnj6CNN60tPcFNs/f8kXWb+nyIgBBRCeLSTOyWA/CEJBfqW5OdH2Gf4IOCGptMpxTrQMVvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSLuYD3F8KNKuVAg9GjguV7+tJCpH95nwv89cgoBTsc=;
 b=jqoY/ZxyfBGkRPIUGsPfek31mznTtPoGUvrXxuCu4mZUKRXb8CWZ0g/RMral0gNKHXU9z1OBnGXzol5A4SEDmX8eUmTSNZcB901F79f9V6XyGYlJnH2DovXUi0ZvWSWd8croZ2Dbg4yqjTHesEY+rXAfoHzGjr4RVyPjjcY+fic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 09:41:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 09:41:39 +0000
Message-ID: <9a121c6f-ecb2-4c5a-9ebf-09cc33263126@amd.com>
Date: Fri, 5 Sep 2025 11:41:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix memleak of ring sched and fence driver
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Deucher Alexander <Alexander.Deucher@amd.com>
References: <20250905023432.929822-1-lincao12@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250905023432.929822-1-lincao12@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe5f483-f078-438d-dcce-08ddec60699b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlJQS1BMQzFScWVTaS9aSnJrVE91WjMrcU4yc3RvTUd2K0pYZE1WbHFTRWhr?=
 =?utf-8?B?elp3eGJQQWxwWUlSN1NsK3NmZzhjL3F2YUVsTjFodUxWYUdpN3VTck1rckhG?=
 =?utf-8?B?V2F5dnphdDFVVnJqN2N5dmFDblhFTE1Ma1lnb2lOMzRSUU1jRTJFaDNKOUpi?=
 =?utf-8?B?YVVodGZRd3NyMHhSZUlFU0NXbHIyQUtiMVhqcW91anJDQ29CNURoMjQxaFlw?=
 =?utf-8?B?RmU1WFRFV1Zua0liZmZHY3hoYXdkRXE2R21jTzRCbGhySlBMaDMzMUhzNm80?=
 =?utf-8?B?bG1wUmpNTEJUa0dZZGxJL3l2VW9XRjRzSlZnZGUwK1ZsU1JBd1owbzR4bTQw?=
 =?utf-8?B?YzJaSzVJREl2RE1adW5jVFlrRjFtZWlKUEtwZzlHR3RLa2JNK2g5b1dhbElP?=
 =?utf-8?B?QVZia0FYd1E2N2dNM2VuVWxwaXJRNkNLVTBzQU0vSlBFcHkyM2RSSU9Rd1Ft?=
 =?utf-8?B?UkNSdE5FY2ptQ016MjVSRWNBSGR5SmhwenpCTnhrTTA2RHR3YXl4bkZrdVVm?=
 =?utf-8?B?VVBnempEZ043UisxSDRtVFFtaFZaUGVrQWJXU0hmTjQwR0xqU0xhc2lCNDYz?=
 =?utf-8?B?dDR3Q1AzS3JTTzFzdnBIaDZrYVZOeFYxc29YUmhGV3IzTkc2MTNHRG5CcmRN?=
 =?utf-8?B?aiszY0NGY1l4MnRUSFIxMVhBOVFmVGpPUTA3WCtkbXAxTC9LcjdKWDFYMmpE?=
 =?utf-8?B?UWo1QkpxaE9JNWh0bDlSQXF5cE9JeklHa1RPVzdhemk4OGsxaTlhNEdBVGQ0?=
 =?utf-8?B?ZzJjRytxZjRLSWtUcE5BSmREQnh6V0NPdXdBcjAvM3I0b1B2VFhSenR4bzlI?=
 =?utf-8?B?Zzk3SlMrT21oTWlJQ05OMzhPdUJ4Z1Z3cEJQV3VQcFdYQS9OUytPOWd5aktD?=
 =?utf-8?B?NlRBRC9VOHU5Q1pnVkIvd0JvTXpxK0FiN2RyS01DMlNac1BGRVdoYkJXTFN4?=
 =?utf-8?B?TXhsdlVyM3N4ZS9zZmN4bmZsWTJ6Q1Z3NUdVb2s2WW96dGY4OTdjYkhCWXpp?=
 =?utf-8?B?MitRTW1SdkpBL1dCd2tWN2RIL2V0S1FlN2doT2tLbzB0bFFJdTFJMTliejAy?=
 =?utf-8?B?eU5OZFdxNDIwaTljWlFCYnlXQWV1d2QrbjE2Ny9OSXdoY3FCanZ5SjVrWEln?=
 =?utf-8?B?eDRaeTFta2x5QU1CeUM2RVFhN1YxdXgvSlVZUHJ4UU9nVE9OVDQyZFhTbFZ4?=
 =?utf-8?B?Q2JQUndRdk45TWRjYWtyYWxpOWkyTkxrVGFNQWlKeVh1WmNmSVltUmZNc0c2?=
 =?utf-8?B?dk9wb09LTS9NbzgxUUx1alBycUU4eTJvbm1MOTkzWEdPazZ0RHYrMmxUZk5v?=
 =?utf-8?B?dktBQ29jd3FVSXlBTENDTkJHV1MzcTZmVU5ZWDZDRG9iSXArL3owSWhhVUdF?=
 =?utf-8?B?VW9zSFNVbWI3UjU5Y0ZpR3dzNDBOUUVXODhYV3VVRkVOQTM2U3krTzR0ZTgr?=
 =?utf-8?B?dGlpQ2tJalpyUzg4MzRBcVZBV0VGQmEvREtaQm95RmlvaWdGLzhMQnZ6Sk5B?=
 =?utf-8?B?dFM4NGtwdUVNY1RaQmxhQS9LY2dtQTlSUmRNMVU3UVFvbDJIeURTSEFhdVhE?=
 =?utf-8?B?S2JCZHpFQjk5Qll4bWMreFBXRFlOV3J4dFpDblkvMVVHdGwrVVVIL2hzd3JV?=
 =?utf-8?B?bkFVOGRuUzNtZVJFY281dFVuRkkrVFNyQ3ZGaGpseXBoOWM1bnlCSEMweEJl?=
 =?utf-8?B?YW5MeXZXR1JReFAwcmthbU1DRWx5N3kvNVlHYkxtTFRObmhuYUdYMzBGNjhn?=
 =?utf-8?B?RnRTQU1PMXBFWTRBOXdNK0o4M0JidmdnbDhtY2g3NjN6bG53anViRWttVkJO?=
 =?utf-8?B?MGx1ZmlvcTFObG9RYzQwajBvN3Fnd1lMWVBad01DRlZwcnVycmxCUmdPdmI5?=
 =?utf-8?B?TlU1ekdNeFBER0pPcXlzeHQwMHZrRDVCSjR5YnZjSE42enc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmJlT29ObDZZK3BibVljMkZ6Zk53ZXRLalUwQlZ2RTJyeU4zN2JucHZqVkE3?=
 =?utf-8?B?T3pCaHRyVzRicUhIems2cVoxUjRCUHFsb3dRV251ZStlcVJzbzJKbCtXd1VR?=
 =?utf-8?B?eXBiMThIeGhqWmFZc1B5Um8vQW1VeWZFdXZpZEhCVy9ob052cTRuaThwbjNz?=
 =?utf-8?B?cnVsb2dDUjFZcEVzNElwQ1M4QnRxMEhHWU02VnVmbGpUU1pXbEx1OFNXSll0?=
 =?utf-8?B?Q2NRTEErSXJBd2N2MUxxa1M5bG9FS2hIL3l2am9XRW4yOGUyaGFZbU4yMDdH?=
 =?utf-8?B?V0xGN1BtWjI0bFVMTzJyNmxmMThJaWtReEs2QUYxRnMrdjc5dytDeThudGs3?=
 =?utf-8?B?MXNsKzhwei9Cak5pREc3UFhCY0QremViOWFlMWcrZW9oQXB2SWVLUlVMcHNt?=
 =?utf-8?B?d1FVZXduSjJDVFR4TVRMQ0cyeUFwOUR4UDREbHZQUzhVTFJscDcxR3RRVzJ3?=
 =?utf-8?B?cHIxN3ZjdjRsT1BvT1BubmZuTVpzdFZnUC9VeVNWSW9Rb1E0cEJwLzBZVVM5?=
 =?utf-8?B?aHFZQkROWWlwYUlYQlpWVmpMTFpoamNWSnVTbWJqcy9SU2FjK2dKSStkU3lu?=
 =?utf-8?B?NEhRdVphNERjbGxJZEZwclZlanlLem14bFdSd1N2TVVtbHF0MVA0RDlVNWZT?=
 =?utf-8?B?OXpjaVFTNXBlUTA0WUh4NWpaYmp6cXFCUlBsL0g1dTdGQS9vb1B3Z3JFTS9N?=
 =?utf-8?B?RmhOR2hJNnRjVlpKMDFmektzRTFZOGZkb0VJMFViM2dkaElSdTdNUGo1clBr?=
 =?utf-8?B?SFhML24rdWVSQ1E2VmQ3TGtRdURNZWJ4MHZMZk51RVhsZjRPUTNhSGFEczJ0?=
 =?utf-8?B?Q0V3dTZGV0ZNeU1tbUdzODhWQmY5aVN6R3pwbGtQVnpZUG8zSVJmYXFudmdX?=
 =?utf-8?B?Vml4aktBdW42RjFVbldrbTBkN3piOXcvam9mcXBMMzFHN0VITFJTVHkzYzJR?=
 =?utf-8?B?TVhwdGJtU3M3UWl5Y1Zvd29rUHJHWEIrVkYraHorRXQ5Y3J3cFB2N1RiODdk?=
 =?utf-8?B?b251eUl5d2x5M0kzQUZzWFpneUVHWjdlK2YrdUxZMmFkNzl0TmhEUkJ5cDIv?=
 =?utf-8?B?OUh5Uzc4OUhtTHFDOWU4NnBFTWplRHpwRmMrU2xmYTJPTTFRQ3dqTEN5bkVq?=
 =?utf-8?B?UWoreVdacHRCNDAyNDN0MWNJNmJsMks5Tm8vTDBmdXhKall0NDl0c01QeTds?=
 =?utf-8?B?bE1MUjhJdnhHQkE1VmFuN29kQ09hek9WZEFKWEp2MmkrLzdhN25SZXdsZWt3?=
 =?utf-8?B?dWxWZS9pbC9XSWdVeWxEaVV6cjk3dkF4OTRib2EvTm1EeDhIczB2U21FM0J5?=
 =?utf-8?B?YWhZSFdIWVhnTDF0Q3pjalcva1lxYmtFZ09UZGw5dWlpbjFoNWZ1SjdEKzk2?=
 =?utf-8?B?Y2NReFpJYWJuNC9HS1dHN0ozeWpwQjRiVVExcWhBWGRyZ2FPcWxlSHJYMHpX?=
 =?utf-8?B?eVBCRzI5UHI5d0QvQ0tiVHVYeGk1V21sVVNWVGdLYmdVZ095aGhCS2lZbEJt?=
 =?utf-8?B?UXU0OUZjaEh0M0ZwQ0tQSlRqdXRZdVI1R0hpTG9EK0cvUXE4T2dUYVR2VDRT?=
 =?utf-8?B?RDhvN3JaUldQWXd3ZDN6YmxxVG9XbnIxZWh4UHhjVjFYbkFpNU5BYU5ITDhK?=
 =?utf-8?B?R25kbDRzSm93blN5SmVCSjVwUS92S2ZRSHJHREIxYkYwRTRHcnBFSEVydHZM?=
 =?utf-8?B?aldhbEw4QkRidEYrRjdwNGI0b0o3alplVittVTkrWkZUWkJmbzJXbktaWDBB?=
 =?utf-8?B?d3VnOTNob0tnVFNsUEtKSURNbUR1N283ZmIzcE9pei93bkEwbGxKUGowb295?=
 =?utf-8?B?MGpmaW1IcnJxbUJOTjloSFlCZ1NZbGxiUVZodElLS2hpa2FTbUMyK0l3SDlS?=
 =?utf-8?B?WXFyS2hKYXFYdDk1VFAxcmlRQ0g3WkQrbHBrTERCNXpGeW52MUJScmNoYmFE?=
 =?utf-8?B?dUlRS3QzaUNsWXRCQUp3alRSUzNXZS9YTFlQSUpUOGMyR0lMeHVibGwvVE5l?=
 =?utf-8?B?OXltWHFOR09KZ2w0VDNmTmk2K21OTHBaSkg1aUZrRWpXUHBXYkp3NE5QRCtI?=
 =?utf-8?B?STdScU1LRU9DcEd1WE84UGhUQ1h2MExwRUp1UFEyYUdveTVLUlBUNkgycDA5?=
 =?utf-8?Q?m2Dcqgbf6ow0owGNTx8SQD4uB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe5f483-f078-438d-dcce-08ddec60699b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 09:41:39.1183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RievhGAL1UFVh55SrmehAs+diFv1O7VEoy7UHi6TZ9Vf3WHywyAgDG6MkXXECJ6P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
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

Alex already send exactly that patch yesterday.

Please review that one instead.

Thanks,
Christian.

On 05.09.25 04:34, Lin.Cao wrote:
> commit 4220d2c7c41b ("drm/amdgpu: remove is_mes_queue flag") set
> ring->adev->ring[ring-idx] as NULL at the end of function amdgpu_ring_fini()
> which will cause function amdgpu_fence_driver_sw_fini() skip
> drm_sched_fini() and free fence_drv.fence then cause memory leak.
> 
> Remove set rings[ring->idx] as NULL to fix this issue
> 
> Fixes: 4220d2c7c41b ("drm/amdgpu: remove is_mes_queue flag")
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 6379bb25bf5c..486c3646710c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -421,8 +421,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  	dma_fence_put(ring->vmid_wait);
>  	ring->vmid_wait = NULL;
>  	ring->me = 0;
> -
> -	ring->adev->rings[ring->idx] = NULL;
>  }
>  
>  /**

