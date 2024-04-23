Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3565FC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 13:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A68B610EA21;
	Tue, 23 Apr 2024 13:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tHplkXEp";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D2D10EA21
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 13:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4uplVVwEIsOkVhIGahlzsme8/C1KL9GXekjXGKAMP/6qzxlMjfFyDpk88e/eVVrGW6gHc673yOUoZXQN5hLISNeZoCHXWHwq95nDTqwx/IW4/WRaMlGQBRkvHb1Kce7Bc1hJn6ssoXjB4BYXqnxbMmYldZmjezycEfjkWYYOXFdoag9GZnMY8RT0bI1qZAkcRChBtekJLfOS4njyWF+OLUzTI73Iopd8JLaQFs66EiAXl3mleSZlJOeLtdnFOtlBIUF8oosHKT8iyMJHdjrAY8/6iTowQ6q96lRBsd4V3LrxKmozHBnekkFGupCf+4aAS0ggRkJKHLIgxiAW9e/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXX+xRkT3BB8HmNEh25ajRXHuU3aswSj7qYUPw7r3wM=;
 b=FI+xSGG3DENth/pp9XK6t955xGIe77hWZ2IHwX+vQEXXjwMmgvvzrjl+zihxDD3oq7hzHM4YXW3o1KVPuOjFz5+mAAbu6tsDZccORHkqMlU8t6jh6snzulWZg99aNQCqTm5etSeD/jrbH/cO/AZ/CTmF6/2carN0vPt3/pDoj4YK/Inu6JSmJ+oIETUKHgS9BgkcPtsz+vsqd/Frx2fxmWJPTNpj8toSywpSwhxV0zhcUKVziE77L5GhNRpqQj31rvC58LpGwO3JhTpiS7+kialgQgy0Hqds1m1eeHuMmowMy9Ibh4fttpwi434HahoqZ04ssYgMz4oWBq6x3JuEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXX+xRkT3BB8HmNEh25ajRXHuU3aswSj7qYUPw7r3wM=;
 b=tHplkXEpUkzG1aSrYnrDr4o9ORke2Po9cw68+vmGisd0pON0QvNL+vQ2IrYHvYsYc40Tg8u/8Sl7jwFydh2E8MIwQp3mWSJkv1DM9/ISDvGWlrPDly/Li6hFR7RuEBJs+/P3AUGyFmAsO1h32iJlfVqwsI+4bbwljBDb05U6Vwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 13:32:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 13:32:36 +0000
Message-ID: <a7779c0e-124e-4fee-b884-b0cc7075554d@amd.com>
Date: Tue, 23 Apr 2024 15:32:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] drm/amdgpu: Skip dma map resource for null RDMA
 device
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240423130450.25200-1-Philip.Yang@amd.com>
 <20240423130450.25200-7-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240423130450.25200-7-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 12db795e-ab08-4178-edb0-08dc6399d6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0pPeDQ1RExVdGVUOEt0TGR5dGE4UEwxdHZPdmZTSzNoNFBpZUlTZDJuZ1A2?=
 =?utf-8?B?bXYySFkwSUtKaUZnUi9yZEZ0dlNOS1ZLK0J5Vm1Dc3NJRUNBeldVUkJRSkpM?=
 =?utf-8?B?dUtRakQ4enFiYnRuSUp5Q2QwUzBOQXVkTkJsK0FISkt5b3VnUms4ci9xK3cx?=
 =?utf-8?B?SVpHNlJ2VzZHMXFuZzlJdGJiYkE4cEtXd0ZTaWdwbEZIdWlpb0lxMVp0NHhJ?=
 =?utf-8?B?V05rSlBGWVRqZWkwZlVqMGZLak83WUtDVklFZWF5bVFIZCtvenFtbUdRSnc2?=
 =?utf-8?B?blNCUVdKcGFJS24yNVd3UEZ1QUFVYmx1SjBQbncremRKaktiVHV0UDRzKzVm?=
 =?utf-8?B?bm5IK2pKQWQ0Tmd0TTF4Y08vRE9JZThTSWhCWXZnUU9rWEY0MHliUVgrejdx?=
 =?utf-8?B?c0VwbkFrSVNUOFBEdWNlc1NZQUlmRDR0ZVg5Ulg0Mjk4U3dPdGx0M2dTL3Fl?=
 =?utf-8?B?dk5ZcVJ5YXg0S3p3UVdIMC8xMW5yKy9zQ00vcG5laE5ISi9HVVhjRWkxMEVH?=
 =?utf-8?B?RjA2RWR6NzBkclJNcjBBaUI1YjE3UUloc29icUZuaWprUXdsUTFGWWcvc0Vm?=
 =?utf-8?B?RWt4cVh3bEo5VTRBSm9SV1BsTHhXZlhlbzVaL0swb3Z4d1dTbG0rS3pHcVJ4?=
 =?utf-8?B?ZlJkMVZHZFJWY1EyTjMvaEIvaDVVZVpMVU1yNUlVQ0pieXJ5T2lGRUVmNFA2?=
 =?utf-8?B?TDNZSTlkdVIrdzlML29JVk16aTV6VittUlNVWGZaTFhDaTRsY015RDUxbjdH?=
 =?utf-8?B?V2JwaVVzSzhvWGRUSGJ4QklleG44ZlJXdmNRUitKbDFkSi9VZ1Q3UjNPU3RE?=
 =?utf-8?B?NzFmLy9RenZCTVlPbnhTbXMwT1I3LzVUY2pVS1p3Z01hSVJ5emNvRG1ZbVEz?=
 =?utf-8?B?QWlyMFhoczYzOGM5ang4TlArTlJxTmZwRjdzZk1ESElSbVV1TXZDSVpPZGhw?=
 =?utf-8?B?c3hHTVRVQk9yb2FRZDhtcjJQVXp3ZlRkZWdaNDJVTTNHMnJwbnc5RWdjZlpW?=
 =?utf-8?B?NVltZTZqWXFrNSs0VGR1dGpUSjQwcC80UGlDcGZkbmY2cTZEU3lSSi85azZu?=
 =?utf-8?B?OEhyVHFySGdhMHpvdDg5bUJpWjNIZmViNkVFeFh0L0NLTWYzOFhOL1A1Qmlk?=
 =?utf-8?B?OFNnZmNvb0NxSHNKRm11QWRNd2N4Z00yRm96R3psZkpzdlo1Z1YwdkVkVThC?=
 =?utf-8?B?Z052VUp4NXA3MlYvREZsblVKaGdpVHpwemI0NXovVmxvRWJjQ1psNEJEa28r?=
 =?utf-8?B?cDJDWXpLZXNTdzhqNEt5MXNqVTFNOGlLV0M2RHBlSjYwZ3NnS1NBRkdqMXdZ?=
 =?utf-8?B?cEJLeS9MOW9yY3FkQnorWE0rZVhVOEVUWVhsemtpaW9BODR4TjR0NmJTZ29W?=
 =?utf-8?B?Vlh6S2dZdmx5VmMzMXBrL2poTktwVGYwaUNQcXIyTi9JMzZVSmZ2VjVYSFlR?=
 =?utf-8?B?OU5VUmd4bkl4K2FXVWpKK1IvSWV6QXBiSytPZ2RrNGJJWlBIMlg4WGQ4YUtz?=
 =?utf-8?B?VG9KUHdsdHlqOElUcUVnV1g2UXJTRnNsdklKK1I4dmxPd2hLakh5RWlWT1Yw?=
 =?utf-8?B?L2VpSUZDOFhuVHRPSk1XMC9IT2gyREx0aUo0TEowYW5qa0k4WHIyQWxPcG1z?=
 =?utf-8?B?cVVScUpWMjZOdit5cFpoUkRDN01jYUFpUUdvM2tvRytPbTFMWnBUV2Q4T3Bq?=
 =?utf-8?B?WjZ6RkNDaWhUN0p2WndlTjJEbVVsNCtrcWhZZlF4ZUxzSHJFMEVjUFVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0ozUWlrUU5SRUZCckZYUTZTZzhubmdzbWpoaTZkdmpCNHZWVzVLL0VDRUNT?=
 =?utf-8?B?OERQY2txc2dSRS9Cd2twQ0RQWmE0OThGQ01XdEZPdkRNUEp5ZUt3ZHZwbFI3?=
 =?utf-8?B?ZTc4akxySURkNHVtd3BpbytCcUZYK1JXbHJuY0tkNjBUZ3Uvb05iN21PS2ly?=
 =?utf-8?B?MC9zYlNUZUNrWHkweG9TSW9JcXRPK0ZiTVZIbjlTeThndGd6d3g2b2lHRWZo?=
 =?utf-8?B?eXJRS25kSzBTa004R1FuMHJYYTBGcm5CaDNEQkM2NWxNc2Qwd1RUODY2SGJH?=
 =?utf-8?B?ZUlVSXBnUlNxYStLVjlmcjczdGhjTVdycUNZdjNBMmphMW9ZTENnc1phTHR1?=
 =?utf-8?B?ZXZzd0hkNW5DWHJLV3Z5Uld5MEJsZXgyRXF5cG9nTHVyTEREWmJ1dVlaTGt3?=
 =?utf-8?B?RnpDU1E4N2haNVpEMVhjN2Z5RTJzcERGSm81RnI4SGpiWW5PZDlFQmZ1cUVX?=
 =?utf-8?B?bksxUHZ2ZklTdFdxaUtlNjUwOVl2RFJESS94WXloVVBoWlhXNlU5WHNjL2Rk?=
 =?utf-8?B?SlZSVGJLeWZmSG9RYzFuUjFjU1V4VWlyWm44WisrKzRKRWVrWElDUm5jbTlu?=
 =?utf-8?B?di9ac0tsMG1zaWRxYldMZSsxL3VWU1UrN1RKVitIYzZpUVJMMERybnlobVBN?=
 =?utf-8?B?aWF1STNpTGlzVjB5ZWIyTDJnS2hubzB5UjFzZUsrRzgvS2xsbVVlV3NoaHhr?=
 =?utf-8?B?bVNTMFNFdVJYbStQcTBDMXgvTkdUOU5mNnNuajljSFB3Q1dUdElZQjRGSTU1?=
 =?utf-8?B?azZYeFlTaVVZQ3V2eGhqaW9YdnNwenYzN0NCZ2RHV0NsZVMrSWg1SkJSMlJH?=
 =?utf-8?B?REdpQUpwTUZ3RE9NaGZjRDVOUTdHVXBYU01WYWRiVGpXS1cxeGFaQlZDM01Z?=
 =?utf-8?B?MHpjYXNlaWt2V1cyMnI4WGRERVJhVEVYK1NGMkZvSU5pZWh0OVF2MTVybFpj?=
 =?utf-8?B?U2tJVUJMQXRrSHkyVGZlR3NvcHM2b1UyUTgzay9VY0Y2Q1VYKzI3c21vSU9S?=
 =?utf-8?B?NldzRU1JZ0ZyYVVxVmdFR21meG9oNjhGdzI0TnJMTzZCMUEyU2s0V2R4ajBB?=
 =?utf-8?B?REVwV2k2WG9HZWljMDkvT1dEVWxHYVNOYXd0Yyt6NldiTDg4MWtyY0VOMncy?=
 =?utf-8?B?NmVVVFh5MzBlNVJIb0lReXROaFpxZnJXSmxhQ3VwVThRTVRISWdDdWlmKzBL?=
 =?utf-8?B?cXZNcVVoclFkU1plZDZjOThVZnlxMlVRVGNtdEFOa3BXT1IvSWhORndoYzgv?=
 =?utf-8?B?K1V1emUrS1UxSXh5L1J4MitVVTZma3lLbWJERUlpdUNrOVR0cnFFNFhwam5S?=
 =?utf-8?B?TnppZHh1aEJFUGZlTlZNbktuN1FUcks2R0YrMmFsRWVtTUdLSmZ6MWN3U3hn?=
 =?utf-8?B?ODdYRVdva3JZMEVPaVZzalVpQ3h3OVp0OWpxQzhDYWVBZTBHNVh0THEvWEJq?=
 =?utf-8?B?VDVXVGxtL0dlWHF2enI2V0kwNU5rM3BkMGlCdWQycXQ4Tkh3a2dQTzF5b0hv?=
 =?utf-8?B?MzJuMjJGUDZrYno5bzlkaXYwTHo1djRES2FBRUxKQ3VkenZ3NDhDd2ZjaWp6?=
 =?utf-8?B?ZlA5a28xTUNiWUNxYlFKdENFUHpXT2xzV1d5TUVkMUl5V0pBaVBIZ0RINnBZ?=
 =?utf-8?B?U3ZtY1lFRHVid25Da1QydHpXYVBvN05GbE80N2svb0JBL0J4Q1czTVdRLzFO?=
 =?utf-8?B?cVBydXZZWDRnWWFXTFM4SUdHVGsvYWp1NGNiSXpFU09hUG5BV1BCd215eUdU?=
 =?utf-8?B?ZWdwSk53bVd2bmN0bHpSSnl2dDhnTUZqekpLNm5lM1VLY2RQTHlxdmhKZWdL?=
 =?utf-8?B?eTFXeGVrdVNmRXV6Qjk0UkVvdXlVd1FFUG1yUVQ0bC9zYlNMSmpXTldBaVRq?=
 =?utf-8?B?YkhVd29WUCtyMUpsRkFER3dvM01WWTU5bmtvR1JEUmdscGxwMys2aFd1bytC?=
 =?utf-8?B?UTFXQy82aTkvWWtweThic2JWTzYrOXBhS3A4bFQ2V0UzV2pvQk5IaE5neVVU?=
 =?utf-8?B?Slc3SlFpN28wSzdXNXc5YjU1RnFnY01IUEl4cjd5TW1JY3o1c0pOTjdSVWtk?=
 =?utf-8?B?VzJEbitUbjk3S2VCdFRYUWM1MFhuaENPN0tadytmcXJpREE5YWJ5S0lxaXNq?=
 =?utf-8?Q?8LnLNABFLAbB0e9b9V59yQ4zS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12db795e-ab08-4178-edb0-08dc6399d6a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 13:32:36.5172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUb5doClCVMPz2kax07AGkbnrt+9iR6VDjfSCV0vqRrIhcfK1Z1ZJY03j3NeFPFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108
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

Am 23.04.24 um 15:04 schrieb Philip Yang:
> To test RDMA using dummy driver on the system without NIC/RDMA
> device, the get/put dma pages pass in null device pointer, skip the
> dma map/unmap resource and sg table to avoid null pointer access.

Well just to make it clear this patch is really a no-go for upstreaming.

The RDMA code isn't upstream as far as I know and doing this here is 
really not a good idea even internally.

Regards,
Christian.

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 33 +++++++++++---------
>   1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 6c7133bf51d8..101a85263b53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -698,12 +698,15 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   		unsigned long size = min(cursor.size, MAX_SG_SEGMENT_SIZE);
>   		dma_addr_t addr;
>   
> -		addr = dma_map_resource(dev, phys, size, dir,
> -					DMA_ATTR_SKIP_CPU_SYNC);
> -		r = dma_mapping_error(dev, addr);
> -		if (r)
> -			goto error_unmap;
> -
> +		if (dev) {
> +			addr = dma_map_resource(dev, phys, size, dir,
> +						DMA_ATTR_SKIP_CPU_SYNC);
> +			r = dma_mapping_error(dev, addr);
> +			if (r)
> +				goto error_unmap;
> +		} else {
> +			addr = phys;
> +		}
>   		sg_set_page(sg, NULL, size, 0);
>   		sg_dma_address(sg) = addr;
>   		sg_dma_len(sg) = size;
> @@ -717,10 +720,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	for_each_sgtable_sg((*sgt), sg, i) {
>   		if (!sg->length)
>   			continue;
> -
> -		dma_unmap_resource(dev, sg->dma_address,
> -				   sg->length, dir,
> -				   DMA_ATTR_SKIP_CPU_SYNC);
> +		if (dev)
> +			dma_unmap_resource(dev, sg->dma_address,
> +					   sg->length, dir,
> +					   DMA_ATTR_SKIP_CPU_SYNC);
>   	}
>   	sg_free_table(*sgt);
>   
> @@ -745,10 +748,12 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	for_each_sgtable_sg(sgt, sg, i)
> -		dma_unmap_resource(dev, sg->dma_address,
> -				   sg->length, dir,
> -				   DMA_ATTR_SKIP_CPU_SYNC);
> +	if (dev) {
> +		for_each_sgtable_sg(sgt, sg, i)
> +			dma_unmap_resource(dev, sg->dma_address,
> +					   sg->length, dir,
> +					   DMA_ATTR_SKIP_CPU_SYNC);
> +	}
>   	sg_free_table(sgt);
>   	kfree(sgt);
>   }

