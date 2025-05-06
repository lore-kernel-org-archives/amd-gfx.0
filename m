Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999DCC3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 08:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F79C10E5DF;
	Tue,  6 May 2025 08:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="InU8OycF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A50B10E1E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 08:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVjeskGw0sCBavyd62K31ClZq4db6Mz94soqvkXywqePTDUZu0U+wIDcqt0x9cH7S+Ry0qdk4/uJvEuPBZFrdI2Dv7+m1Zv5zr4ohYkmf0eMA5BnEB4wGJXGSxJfx6CoKXay731IZfuaAaH4sGbj6kOjNdos/UJlNwmXAHoLvAu7sRTbo4uDNXoZfOao0x1lasVcOIKJpJjmxDB1Bxj7h6N7BE+eV0xUDeaT1ofSq9mBkqxgifuUu48QjwID+kUZnYDH5TEaIbi1ArhlhKErnBnGnDmUy8dpB7jJAUehkdSPes7IE/daFPSCtWnKbVIGZVGtRu7Omvyziqm7GD9hvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfVVbEFF6vW2zqaIRdN+75JSn5HdJjVRqxSni8i3rLQ=;
 b=v6ZrbPaW2LoU3GjRCvrcqcdBC670bvnLnHMKphKoqW1g5vCHu07oFIUDWGEKK1MOCOhbr6Z3nLvO+DhJEc6qBRrP5IBvpgUVUPuoMNrKVP24H3gXEQbYlLuCxtydRp8FYc13cS63iQpxcHYDCJE0tz0QelfZ86IKZlqdgKkXhL0wmnIjN+0SFbqOpR3+2Et4f0hQ0/HlmTpHRLlBGIffGrIg4HYUfDn2MFWglOHBCpr1I0bkuOIOyev5Gp6YVFpHnfVfzS0wXGn0No/hQetfwk/CddnGgtH1NoSJDMPewquKB5n9UBWop80/dcwo04SPnQcjXi20MS+wV2Z788uONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfVVbEFF6vW2zqaIRdN+75JSn5HdJjVRqxSni8i3rLQ=;
 b=InU8OycFr8D/jALFbPy+BSZ46xXL15d37CozrITZS0AdyD8PpJZbKFyaBTIfN6l/YlGwLGISSv5TF+0lgvmORYJ1fo6qci0m5rTUGiPmph9LKEMlXP+tv3MkBS0uV9qzYnZOm0eKiiHvtNC9IIpJoxlkstAx2TKIWvQdi5w9src=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::994) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 08:58:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 08:58:42 +0000
Message-ID: <a4a35d14-2455-40a0-8879-c6c72e90ccbe@amd.com>
Date: Tue, 6 May 2025 10:58:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: unreserve the gem BO before returning from
 attach error
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250506084327.357722-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250506084327.357722-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: b62e7f91-35cb-4c9d-8a30-08dd8c7c3337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmVMb3VreitaQTNCTGMzT0l2VlA5a2pRMCt0eFcxYmFZTWpvYXdKTC8zSFE3?=
 =?utf-8?B?YTVLUkw5d3RhTkk0NVRwZ1Z0dXZpVFRDWm9aN0RRaTZBNVRsTXpNeDVTUXdt?=
 =?utf-8?B?bWZaUFVBSktBNWc2YmpRVlR0NXdBSWlCaTk3RzdVbjNBcFhSamQ1MDdNR3ZM?=
 =?utf-8?B?aWh2bTJuTGt0MVZNenQyRXRkcEViYjQyRHI4NGFreUFCU0llWm50V2w5c2l6?=
 =?utf-8?B?QXF0M2JNZjlwQVVpc1NYVXZZeHExRVpmdG9kYlp5NUVKZTY4WVRTMGR2MjlO?=
 =?utf-8?B?N1JTdE00T0tFOXhRTWxDSzIxN1BIQm91Z0JTcXVPYjNwNmd1dFlOMzJ5L0tr?=
 =?utf-8?B?NjNobWc0Q2JSQ3dHZWFEbUQ4cDI1SDBhSUxEN0VFOFBKSVg5bkFWbk5BVkZV?=
 =?utf-8?B?WkZxYUtTbWxBQjN6TExaSmU1NWhDZkZ3M21qSDBGcURyTXpGSjVlNFg0bldp?=
 =?utf-8?B?UjM3eUt3WDdwSFBHcnVIakYzdzJPQkZWbE1MelhYWEpiS1lrSkRQYWpSNENk?=
 =?utf-8?B?aGNlY0R5dUhjZTFxaUVBYTBUMDdYbTVIL2w0bllEeWpWR2UwSFNyY25rUytO?=
 =?utf-8?B?OVNoMkhRYlVWb3U3NWR1d1M3NUZqU2xhcFpsZkpQWkN0bEdOMjNqTGFWVXRW?=
 =?utf-8?B?dVgyc2NDQ2xFdnlqY3J1Uy9COHF2cVk4WWpNbFNib2dUaDJCNWJ6Wm9IS2ZD?=
 =?utf-8?B?M3RweXhvaGhMbVBZRXNaaUp5ZlRFVWhUZXNBUWF5dGZBSWdSTHdxSzVMcGNE?=
 =?utf-8?B?S3RuZ0ZFemZHUThlcTRQSEZNcTlUejhMYk50ejA4eG9BK2Y4MFg2UDI3c0Rj?=
 =?utf-8?B?V0liSUp4OGZrMExWem5CbWlsbmR6dmRoQU42M2JZNlJNVUgvN3BjVE9qZjlP?=
 =?utf-8?B?bFAxTlFza0psOERBMWNQN3UrU1RrT0JLaTZYTDh1bi9hWk1rbjNyUWp1VVB3?=
 =?utf-8?B?eUJYOExwSnNqQVJLNGJ5eEUvMlA5WUZOQnROYTNlak5wUW1UNm90Q1JQR05i?=
 =?utf-8?B?VGc4dnUrVmd2djdhaElHVkNKY0s4T0dOSWVNVSt4MStsNHJZcTA5bm5WV1Na?=
 =?utf-8?B?aGtKUHlpNm4vbEdTZThhTVBCbDIvT2ZXN1l0Zi9VcDBWdVBsNmVCZUJ6Y1Jl?=
 =?utf-8?B?VWl2Z2FCdWcyVS9yVlZBOC9LUDF4eC9IU2JQaTNZNVlzdGRoZm9BMjA5UThq?=
 =?utf-8?B?Qk91OHgxbDQvZFNzYzlFaWlJKysrbWNVVzhNL2w1QzVUWUxFS3dEQmRubCsw?=
 =?utf-8?B?cER6OUFOa2xDanA5UGRBSUN1Y2ZXNDdNem1uRU80SkZVc2tPaFZnM0ZYYnZz?=
 =?utf-8?B?VzJySzNWUlFxQ2R1QzF3bWg5MDIwclYxa3E5YjNkd2Roa25PcnNRV1N5L001?=
 =?utf-8?B?V21xVFR5dG93T3hYT0dBWmlEM2tYOXprcW5jUFBiNFl1VWwwaVRGVTFvVzRq?=
 =?utf-8?B?TkNxalljTEU5YzVCWVlTdGhBM2tkaWtEQ0pRbGpKNkIwajIrRUV1MTQ4U083?=
 =?utf-8?B?SUkwUjVRV01MR0YzeGlyR0FTUFd2NW5SakpqeXl1WmJLdFEwdjljc0pnUEgx?=
 =?utf-8?B?dFY3Ujd6Rk05ZDZwY05OVHIzZ0tTTi9PKzBWVitYUGhRZDlYTU5Wdm9sWVEv?=
 =?utf-8?B?TVE4RTZZYjl5Tkg4R3kwTnVPd1ZVSmxzZ2doNnNreHBOR1dWTUVaaHZOYVlT?=
 =?utf-8?B?ZEtTYm9CSEpXdXJJdzI3SUtaZUZGWjNuaHJkblhPenN3VUdqYVdWOS9qUUJQ?=
 =?utf-8?B?SDA0UDNXMkpqbEZvblBreU1zZjl4VVljdTJnVHp4VGdiOHVPNE5JUnNldG9Y?=
 =?utf-8?B?WkJJK2ZSTEdoN2dLTEFwOFAxWWZoTFY0Y21zVk5SaHlSQ1RNdUttR1BLQWRo?=
 =?utf-8?B?ZS9aOFhhcjJYWC9CazdEWkE2eTM0cHRFRDN2ZXBMclNDOGIxT3ludUcyaTBW?=
 =?utf-8?Q?vrp4e6nZgLY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVlNeXZDWk1JTDB0N2FmRzVycnNrdWVGeW9ZM1VKbkpGMkVSVGJzTGhRN3k0?=
 =?utf-8?B?RWtpVS8yZ0RVYVF4T2xZemdBWVhsV2ZyQWxvWWxqSGNFdEY0TjJ3ekhSWmMw?=
 =?utf-8?B?blhlK2Y4RGptbjRyNy9JMnpQT0o0a1hzZTJsTCt4RGx6czRoZ1R6dUpjMjFS?=
 =?utf-8?B?VURCSXZ1WXRQbEF2ZjVZMnU5c0I5WmJSdDkxRlZITjc1YUc2NkgrMVUxSzFr?=
 =?utf-8?B?SDFINnQ2YnhVdE5TbEFxZ2QyTEJ1VUIrQUttZUxKKy9ZKyszc2dQMDh6Q1lX?=
 =?utf-8?B?RjlMVVdnZ0Y1eHdJY3NFYTlwMGpnV2dFT3lCTloyYWE2d1lkSG9vQ3AwMnR4?=
 =?utf-8?B?K2hTdjVzcVZ5MkJPUGJHakxUOC95Q2JMQWVmZmJrb1pGeUlWMmFkWTk4NEUr?=
 =?utf-8?B?ZkRWUitTaFZGM2dsOVM0SlFEV2FWU1ZXbVF0cXMvNmYrKytiNVR0YWVRNnJx?=
 =?utf-8?B?RmZCelg3ZkJhaEh6TW5ZMXZGeGxZVGJJbkFWaUJlMGltWmY5ellZb2xRMk0v?=
 =?utf-8?B?UG9QTklCVG9yUHY4TWVBVjFsUkxWNG5OcmpBZHpmYnNDY254dlJiTzcvTW1G?=
 =?utf-8?B?aWg0WW5mNmphVUVyVzAwWm9pdkEwNTJFZkZyQjFXTUZubmhjUlE4aGp4UUsr?=
 =?utf-8?B?cEI0dzNEOW1Penl5VjAxQnhuU0Rpa2YwdExyS0VRb3FBSjQra3BHeVpZTjBw?=
 =?utf-8?B?WlpEUU5VTGUxWkJOdithaEN6ZmtMbWhvVDBhVUozRHQ0V3dBRFF4QkZ3K2Nn?=
 =?utf-8?B?VDhya3piQlZTNXFnZG5pTkVqT0J1cUtEZ3VWeTlDYUFtV3BRb0R6ZWFmNk1Q?=
 =?utf-8?B?Wms5SVJLUVZlNW9XM2srTDhTQnBHQW0yYzUvNGR4eEZjaXZlSFF6M0hpMjIz?=
 =?utf-8?B?dUlyc2NBWmFiUWlnTnJxRy82TVJRZGtGa1l4cWw5ZWttU3duQ1Y4aTFyZWow?=
 =?utf-8?B?Z0p6U2tpbkZoT3dVblJreWlBZ0cxRXByUEdyekR5dDB2NnBxaU9rUVNWS1E3?=
 =?utf-8?B?WGo1RllGUGJxb21WYjFJeEwvM0tIWDhPYldXVmlRUndlZ3hJbERWaTVCM0lR?=
 =?utf-8?B?S0VQT3RTMXdobS8ybkk4NlordTh0TGtFYW5PL242emNPd2ZGZ3JqQkh2UjY0?=
 =?utf-8?B?ZXN3WGZta1NqYzVvcjBCZE9La2xFc2k1VDQ2ZWZBdkFLcysydHRsUm9oTEJV?=
 =?utf-8?B?VnpQQ05TdjRlOXNET0lyVzhXMFZFck5aN2NTamlqS0VhbUtDekZKTU1CUERv?=
 =?utf-8?B?ZmwzVTFWZjVtZmZvQUc4eW4vdE1QNTVzdCtVcFBsdU9yV0N4andwMWlRNzRk?=
 =?utf-8?B?M0NvN2l5SHl3WlpGdndNcENFOUlVSnYzSHg3QkNXRURIYUI1RGtnMzJMZkxh?=
 =?utf-8?B?cit0LzZENFI4SEhKa3laSUFKZW05VDZGeThzUFJSZm00Z0h0Q0pmQURvanRx?=
 =?utf-8?B?dFIvMnBIbjhpeGNsTHpHMld2eVdVS3d5a0VxS0lUMnFUYW5PNU50YUdyRmph?=
 =?utf-8?B?SjI4ZTBJM2pKRzM2M01sMkh2YkNRQXM5QlkrbTdvS0orL0ZjUXNVUlV3SFcr?=
 =?utf-8?B?OGJWNUJmS3Ezbkp3bDhnWVdwem9OUlR4TTE4WTRIVWlnRXYwb01GZEdyd1ow?=
 =?utf-8?B?WXVVTkNBalV1ZTFsM0FSUHc3aEY3RzVLbWdXbW5PVm9RVm5RdmZtZmVsK0hO?=
 =?utf-8?B?bENoU2lsK1dTRGJlOUE5OUJZOUloZVhVOWpKYkVObVZiN2VpczlyRzhUVmRF?=
 =?utf-8?B?UTJZak41Y21xK1VQb0dncTFEZVozWFI1YnJKZUYyZitKWUVWRk1yeGlTWGlx?=
 =?utf-8?B?VVVHVGdOM1l0R2drUE5ISFlibDVYYXUxbzA5R0xpTENPZ0JQVzZEMC9MNzNO?=
 =?utf-8?B?Q0E1SHdBNGpGRTMybExienYzeDJxclhOZ21NZWhwSUIxcXpuenNVZHZlSmsx?=
 =?utf-8?B?MFRCT1N3Wk9DQlNieWRvWUFKbmkzQzRZTDVYcEpweTd5Q3VmdDVRcmVYbmt2?=
 =?utf-8?B?Q21FZjBBby9TTGRKY1lBbFY1c3lZd1BIMDRTNTZydFJrTlFPVXp0UTZtekgw?=
 =?utf-8?B?Q2h0QzB1MEtOK3ZHYlhHamkyaFdDZmRXbHp5WFRncWlIbWlBSGpqNWxHNlVQ?=
 =?utf-8?Q?Dzo0iBb/AMAykrhjd2dm+h1U/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62e7f91-35cb-4c9d-8a30-08dd8c7c3337
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 08:58:42.1293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6Uys1hcqw1pQxA+3POxtj9sEVblQ8KI5C0cJ+uwDLbN5MhMix1DloLahMsdcG3s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D
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

On 5/6/25 10:43, Prike Liang wrote:
> It requires unlocking the reserved gem BO before returning from
> attaching the eviction fence error.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f03fc3cf4d50..2c68118fe9fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -298,6 +298,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>  	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
>  	if (r) {
>  		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
> +		amdgpu_bo_unreserve(abo);
>  		return r;
>  	}
>  

