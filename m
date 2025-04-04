Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2547EC36010
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 05:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B563B10E009;
	Fri,  4 Apr 2025 05:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5PQcEpOp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CF210E009
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 05:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5XNjNzFE16XWhTjl0Y604k5sD++vTxmlukXrEJTlwgoPUKN59QPrkfEyXX8Vyu8mXzACLDLj8yNWYg7UfS05OQIGOwRyC6lvm/A0P533qE02mdvi44pzDM62bWcNGbxsAELb8/3eM3LRsKEV1X/pFlgPtGiO8b3I4r1i/3VsM8vkxUEYmLNE2mlRgQ46zHC3oUYeHQa06LfaayAVJ87EqKfgNSTJbB4Cb7f6skG/PN0QDN5Fd1AXkK7QOb/BYmb1k9pWOk0rUSu3KKTqayzQU6EW+gKIhTC4gQNr+PxbA0ViII/7fYq4jXQanKKlPRH43soYRrxDXB0X7jF9Re7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Dl94/7yBez/uUc466dmX+Lh0NsY6MOdGB4yIsAaeDY=;
 b=lKbrVWWQkK4oQm4qIhv0nPEBC30UkkxmiDo6fDf2w0uXSXdDEHAwNGYMbXCyyKNtCld9+JdDfMbE9H606tQuo623u+hnFUQFfqMdLSsi5mYI/XLsAkDR5e+rC0vgCZuVddAKBIfjffPezhXJ5yo8HbMHTVEvmlzdZ9AJDFb8X/M16PHxrlmSv7s8k1GX5xxo8TsFTxddXToIyVVeYHqMm8GUxtPKdpwIjKDLEjSGDMzJXZTRckTxd3agSdTheNgMPO0+d5x5LNyoQWSt5Y+v2GVXBnGYTjh7qUaImh/gP/D0SeLHXvy7m1bBes9eoHBxV/y6LoTxU5QrgR2T5qVzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Dl94/7yBez/uUc466dmX+Lh0NsY6MOdGB4yIsAaeDY=;
 b=5PQcEpOpQwmfayK001SF0R3ejgf/m1rOfRG7RE+dYqTGKUfRWV2V0bMcnN1veNd3C59M4Zhm2ZYXL3E0LDjv+5+X8+ErZYrM9BpouwR8JF12q3ORUUvf66IZhG/fIzFqHQx8GxU4TSJf0JJvnGzzxqea2nnTRXbCr/4YDP/m6JM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 05:15:08 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8534.045; Fri, 4 Apr 2025
 05:15:07 +0000
Message-ID: <ec5eaf52-2017-4328-b66e-50a394449d62@amd.com>
Date: Fri, 4 Apr 2025 10:45:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup amdgpu_vm_flush v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250402140213.13455-1-christian.koenig@amd.com>
 <20250402140213.13455-2-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250402140213.13455-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::14) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dcb8b6-09de-4fdb-bc82-08dd7337aa48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHkyVU5wVkZlM2JySTdtNkpXbTlQeFU2T0Evb3hmWnJlc0RKSU9heHA1dGRR?=
 =?utf-8?B?MlFHb3Q4cHY5TzdQdW5iS3dyR1VJRTlSeitiNWdmcGJ6U2h2bjRBNUh3dU51?=
 =?utf-8?B?OC96K1psTllKTURzcC9xOHpMWThUR3FrRmwxdDBxWURGK3BnSnk5dUNMRGlm?=
 =?utf-8?B?cVlmb1M2b3ZKK1ZEOS9yd09TNlZvV3NVbkxNRmw2b3RQckg3ZzV6S05ZcWNU?=
 =?utf-8?B?YzBLUzNuVmlHYnhLM3JoK2FaVmFQVk05U09ldmdtaU5OdnZTQVdmS2E3dEhl?=
 =?utf-8?B?RU9uaGJWTmdGcEV4SU8vZ01qM3hyTlNCbXZpcE9LeUV5a3ZUV2g4d0xBbnpI?=
 =?utf-8?B?NW03eGVwcTlKa0pTell0SGVKWXhVck1vU0kvd0ZIZ3RvR1B2NGVJQ29tNDFZ?=
 =?utf-8?B?Z1drVVA1aGZONmQzd3llc0piMGtNTVppTjBDenVJbDM2KzBlVDluaUhSZXJR?=
 =?utf-8?B?Q2RZdTd1RWw4MWJxSFVKZkRURlpGU0pjbTlFR1VyK1ZOUFpJY1FUL3cvTS94?=
 =?utf-8?B?blIxdndOcmFPSys0ZndiUjAxWFAzUk9UbzQwU0NhWjd0Zjg3Vzd2NGRhMVlx?=
 =?utf-8?B?Wk5iVHkzTlpKYTg2TmlOcmhiUkFBM1AyL1hSdUFWY1ByNmZ2RTRINmd0WGZO?=
 =?utf-8?B?YzVibDRqRUh2aVc0bFRVZzIxYWljMWxZTllub1loWlAwNjZrNTkrMkE2ZVBE?=
 =?utf-8?B?bWNQVFYzZ09OZktpSEp2WkI3ME8rTlhaM24renNRZCswRUdvRUV4d1VFd2F2?=
 =?utf-8?B?NmxqVUluREZWdU5Ec2RGSnhCVG5MdlRNZE5ZZVNSZW1qUmkvY1BEYnpiMWh1?=
 =?utf-8?B?VS9xSzk4OXlQS0JRdkh1QTY0UFkxblgyUm1NUzNybkhVNXhMQXBiUjVaK2dp?=
 =?utf-8?B?RFc5bExianIvVFRWT3hNVWREWVNsRTRBVlFhb0tPREo3TEJqL2pTeitmVGk0?=
 =?utf-8?B?RXBvYmlmZURCYlBhcTRrcWc3ajRDL1FWQ2hGRDVWOTQ5Q1NSbXZJckFGSDdy?=
 =?utf-8?B?cjkrclBoUExpSno3enVOdXlnZ3ZrSmJxWmFvdVI2V3psSS9LY1hjUlkweUpO?=
 =?utf-8?B?NXRoUkpaQzkxQzkrYjErREM5ZUdlK3ltaHRwalc3UWdjSk9KT1VOdWEwRUlw?=
 =?utf-8?B?bTZpa3hiQlE3M3Y3TENQcUNiOE9iVlpJWmZuN1RFSzNZeUxINkd4Q1daM3Ro?=
 =?utf-8?B?RHlXcEVITitRVUFQZUtHSzB3aFV2YXZidHBBaDAvSlNEaTB3Y2RSVXl2TVZU?=
 =?utf-8?B?Ym5YUDdiS2c2ZGlwTUozdHU1bG8ycXRTdW9BQXJNNmQ0R3V1ak1leWZZbTlL?=
 =?utf-8?B?Q1ZOR2J5RjBQTDdRSVRRSEVVUTNKem93ODZzdmx2cHFDZ1krbW54aGwveDNW?=
 =?utf-8?B?ckhYeldoQUdtU2FnOXVGZVdJK0d1WjB1WWliY1JPWi9NamgxOHlVdmNwbmF2?=
 =?utf-8?B?eE1xWUl1YWFFRnJLbmxTbzNqcEtoSmwwdmR0RkdIQnBJc1NkMmg3NzZhYmpa?=
 =?utf-8?B?WE9QZWlDR0xGcTQ3bk4ydHkzWXlEdThFVk9aejBXNEV6SHpuNmNiWjEzVGcr?=
 =?utf-8?B?VENYNC9oU2V4ZUtkNVR6cWdtN2dMM2JvbEpZSXB1T0lMbThUWlorUHJNSnoz?=
 =?utf-8?B?ZHVpUXQ3b3JyRHc5akt0VG1yVzJ1emo0cFRqSzRjNlM1MGRvQnhwZXY3ZUs2?=
 =?utf-8?B?ZDhLbDMrRWdqQWZ0SWhEOWhTd0dSTFFIeHUrb1ZmRGxOMENnZTFHam5JRmZr?=
 =?utf-8?B?N3hBcWVSRkJwOEYxR2hJM3kybHZyV2d5a1ZJZXB6Q3dacG5uSTRiL1grVm1q?=
 =?utf-8?B?T2RSQUkwWU1DVVh0alBXYnVLZHI1UzdmYUFYREpKVURRWXNobzh1UGphcDJQ?=
 =?utf-8?Q?2I8s3Jo6vsuEz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2JsY2NQcVc4NW1mRE50U1FQNHg0SFFWTHdNeTlUUEdTWEczUG1RdHlrOTA4?=
 =?utf-8?B?b0l5b3VUUTg5WXhzUnFDN3dJWlRxU2JtNy9Fb0ZlenFIa1E4L2IrbDdYd0Ir?=
 =?utf-8?B?OHNtV0JsVmpqSmtlazBmK2F5OGRzVjlZZ3ZuUFJIT2ROK2VUTU1GUy9oUUp6?=
 =?utf-8?B?RWJIZUhBMFJNTUlhZzY2K1JFR04rUXZZM1dId1JlRFNDSGNjdjd4VFpraUFU?=
 =?utf-8?B?ZVJnVGFmeUo3MVBVZ3NTK2hLY013Qzc3cjJoSkpoMWRIRXZuOWxsUG16SDdw?=
 =?utf-8?B?dTRPNmRqU3dtbFlHMDdaQTAwdS83b2dQVndRREt5STFuZ3N1U2RES1JIY2pz?=
 =?utf-8?B?VzVoTjhBcUJHQk1PWGptR3BpNmFpQzNKdVIwT0dCOUYwcnRxM2dXeHYvaTBy?=
 =?utf-8?B?ZjJ5K1JVRmVPUzkzNUE5Q1hxYlo4bmtybWxnRFRzaS93YnlGaW43MGVpaGp5?=
 =?utf-8?B?Zk1PKzdQeHA0d2EvVzlISnA2QWZHek9KaWh1YjNQSCtLQy9xa2Fpb0tITWFp?=
 =?utf-8?B?YTJySStBSWhNTW90NjBpZmZMY2NmUm9LSnFvZFZkbk5ObEVyc3NrelBOK3Qr?=
 =?utf-8?B?Vm9kZ0llSlh2Mm5xVEhORFhuaENoMnlvREQvUHRNNUM5U2lzME9ZbmszS2Nv?=
 =?utf-8?B?VU1wL2NoTldTNHB3aHBLZHlRWFU0V2lUVDIxTlFqM3FmTzRadTRuWWxLcDRU?=
 =?utf-8?B?S1BRQjd5YXErYzlCK2ljZ0syTDRnYjhiQUdjc3ZLK1A0SE5qVmtWeUtwMXlj?=
 =?utf-8?B?R1pUdFkrbGpIbUR2L3ZjK3NuTUxyOUdMeVJzNzd2b1VRQ2JncjhNWktuYk9l?=
 =?utf-8?B?djRjYTI1VjFSQ1hSd0xTeHJTalZxRVhIMytxazhaMzBDRzAvUUM2TmlwMVZx?=
 =?utf-8?B?TG0xM3kvRVBHWFJzN1lKSTVWenJSUGxoZFNzSGV3d1MxMmlEL25UWHh1MGNO?=
 =?utf-8?B?UkE4cDAyMGdTMnU1NHV5OTZNZjVOd2ErOFZDWW5Eb2ZQZk1xSmpjUlRrRkUr?=
 =?utf-8?B?TlV2VEZ5YlFFK1RvZzVBbE5KT0d6aFBPY2YxQWlRZDdaKy9vS2hQaHVCa0pC?=
 =?utf-8?B?ZE1TK2cwQlQ2SUgvRWYrQzlNTzBxMGxnd01POGFCWDBCcjZZWlZ5NkJ5Sjl4?=
 =?utf-8?B?WlNDaGUveUdnMW56M2w0Y1EyaU1mQSt3YlE0cnBrNllvOFFKQjVSV0VwcXBQ?=
 =?utf-8?B?Mm5EcVRqZkV2NFArZFNRdGc5VDNSVE8yRStsVnE3ZVFhSThqRk9jUXFybTdN?=
 =?utf-8?B?aVBwWHUxQjRoY3kyRndQUEl6NjBaWTArRGRKWnFXYk5nUE9oWElFanhReGFp?=
 =?utf-8?B?WVJSZDF5ZVhKZEF4RG43SndpL1VRQnpmTWlFNjhnejJVaHh4K1RTY3lER2ps?=
 =?utf-8?B?SHgxWi9XUXhOUVAveXdTUVNLYThzbzZYQmszdXR5MnJMTkN3Sks4YW1XTlZx?=
 =?utf-8?B?VG54WWdBNE00Wk10Z2tqMXdkRnJoWE0vVkUrTlpzK05XR2dPVkF0cGovTmlC?=
 =?utf-8?B?M2VKeTFVQlA0dUI5ZlFVMG9kMDMzVGljL0o0Y2EzZ2hzcFpRR0ZMM2VFT1Vt?=
 =?utf-8?B?OWhuRHhla053MzViUTh2bmxmVkp3dGZLOE5vRUNHVnRwazRJcG9DQ2RQV1dp?=
 =?utf-8?B?L2dyUEFmQ2FkQVFQQUNOTWtXREwxK1VLM085ZFRtNTJIRm1iand1K1dvdnph?=
 =?utf-8?B?WFlUL1NoRzhoZ1ZoTVlkR01qYXBrb0JFMkVzLzVTdzZycnczM095Y0h2Ynh5?=
 =?utf-8?B?cXNkYTRNdFpORXg0UWI1REpzR1lJVWVhT2lySVFQNEduVjlybkdSRXQxcXZ1?=
 =?utf-8?B?c3JFempIYkI3ckQzdFhGMlcvckt5MzdOU2U1dHZ2ZUpHRlVJdXQyQWxPT1kw?=
 =?utf-8?B?bndEV3hFUlh1c21yT1dVNE52OWwzV2plVzhhS3lHZUpyYTNwMnJGQXdtTjJy?=
 =?utf-8?B?SE1OWVo2QUFRU2ZMeFlDSmJ5TFpOU0dkbENoRmx4QTIwaXlTcEFJRHh0OXNn?=
 =?utf-8?B?akNtbURnd3oyclAxdFZma0dmNDZIZzgvdERIcS9nbUlzQTdTU2V1TzRZODhR?=
 =?utf-8?B?N3FJdVhEN053M3ovajg0UVlGaEN3OGxaZVBGSnRVM2IxTE0wOFpRc2VKNVQ1?=
 =?utf-8?Q?4qiGOwHEWII37YYDlQN7OBea8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dcb8b6-09de-4fdb-bc82-08dd7337aa48
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 05:15:07.6898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iD/vdQVmo1xoWppiKvIjNb/Z1Ya16H8csJZzTYu+su28uzT/frwsL56p6M8cBQGoQ4sQfhwBBvNWYfenzSwPhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416
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


On 4/2/2025 7:32 PM, Christian König wrote:
> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. Turned out
> that this has some negative consequences for some workloads. Instead check
> if the cleaner shader should run directly.
>
> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
> if the VMID has seen a GPU reset since last use and the gds switch
> setiing can be handled more simply as well.
>
> Also remove some duplicate checks and re-order and document the code.
>
> v2: restructure the while function
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 89 +++++++++-----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
>   3 files changed, 34 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 802743efa3b3..ff2ca984279a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -191,8 +191,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	need_ctx_switch = ring->current_ctx != fence_ctx;
>   	if (ring->funcs->emit_pipeline_sync && job &&
>   	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
> -	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
> -
> +	     (amdgpu_sriov_vf(adev) && need_ctx_switch))) {
>   		need_pipe_sync = true;


So based on this, Pipeline Sync (ie., wait for GPU to become idle) is 
needed only for SRIOV cases, like when SRIOV want to preempt ring 
buffers and switch to another ring buffers, might require 
synchronization to avoid clashes between virtual devices.


>   
>   		if (tmp)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b5ddfcbbc9fc..d7a4cb07defc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -596,37 +596,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
>   	}
>   }
>   
> -/**
> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
> - *
> - * @ring: ring on which the job will be submitted
> - * @job: job to submit
> - *
> - * Returns:
> - * True if sync is needed.
> - */
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -				  struct amdgpu_job *job)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	unsigned vmhub = ring->vm_hub;
> -	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> -
> -	if (job->vmid == 0)
> -		return false;
> -
> -	if (job->vm_needs_flush || ring->has_compute_vm_bug)
> -		return true;
> -
> -	if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
> -		return true;
> -
> -	if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
> -		return true;
> -
> -	return false;
> -}
> -
>   /**
>    * amdgpu_vm_flush - hardware flush the vm
>    *
> @@ -647,29 +616,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	unsigned vmhub = ring->vm_hub;
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
> -	bool spm_update_needed = job->spm_update_needed;
> -	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
> -		job->gds_switch_needed;
> -	bool vm_flush_needed = job->vm_needs_flush;
> -	bool cleaner_shader_needed = false;
> -	bool pasid_mapping_needed = false;
> -	struct dma_fence *fence = NULL;
> +	bool gds_switch_needed, vm_flush_needed, spm_update_needed,
> +	     cleaner_shader_needed, pasid_mapping_needed;
> +	struct dma_fence *fence;
>   	unsigned int patch;
>   	int r;
>   
> +	/* First of all figure out what needs to be done */
>   	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
> +		need_pipe_sync = true;
>   		gds_switch_needed = true;
>   		vm_flush_needed = true;
>   		pasid_mapping_needed = true;
>   		spm_update_needed = true;
> +	} else {
> +		gds_switch_needed = job->gds_switch_needed;
*[1]:* Should we need to check along with "ring->funcs->emit_gds_switch" 
ie., "ring->funcs->emit_gds_switch && job->gds_switch_needed;"
> +		vm_flush_needed = job->vm_needs_flush;
> +		mutex_lock(&id_mgr->lock);
> +		if (id->pasid != job->pasid || !id->pasid_mapping ||
> +		    !dma_fence_is_signaled(id->pasid_mapping))
> +			pasid_mapping_needed = true;
> +		mutex_unlock(&id_mgr->lock);
> +		spm_update_needed = job->spm_update_needed;
> +		need_pipe_sync |= vm_flush_needed && ring->has_compute_vm_bug;


*[2]:* Just to double check, based on the old code, Pipeline Sync was 
emitted, ie., whenever job needed vm_flush and that was OR'ed with 
"Compute rings had the issues on gfx8 , where pipeline sync was added 
before we switch the compute jobs", but despite of this compute ring 
issues, we might still need vm_flush -> for a job switching that is 
using same vmid as previous one, am I correct please? ie., should we 
need to retain something like this, same as old code ie.,  
"vm_flush_needed || ring->has_compute_vm_bug;" ?


>   	}
>   
> -	mutex_lock(&id_mgr->lock);
> -	if (id->pasid != job->pasid || !id->pasid_mapping ||
> -	    !dma_fence_is_signaled(id->pasid_mapping))
> -		pasid_mapping_needed = true;
> -	mutex_unlock(&id_mgr->lock);
> -
>   	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>   	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>   			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
> @@ -684,12 +655,13 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	    !cleaner_shader_needed)
>   		return 0;
>   
> +	/* Then aktually prepare the submission frame */


*[3]:* Could you pls correct the typo?


>   	amdgpu_ring_ib_begin(ring);
>   	if (ring->funcs->init_cond_exec)
>   		patch = amdgpu_ring_init_cond_exec(ring,
>   						   ring->cond_exe_gpu_addr);
>   
> -	if (need_pipe_sync)
> +	if (need_pipe_sync || cleaner_shader_needed || gds_switch_needed)


So with this checks, whenever cleaner shader or GDS (Global Data Store) 
Switches need to be emitted, we expect GPU to be in idle state , by 
emitting Pipeline Sync.


>   		amdgpu_ring_emit_pipeline_sync(ring);
>   
>   	if (cleaner_shader_needed)
> @@ -706,20 +678,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>   		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>   
> -	if (ring->funcs->emit_gds_switch &&
> -	    gds_switch_needed) {
> +	if (gds_switch_needed)
>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>   					    job->gds_size, job->gws_base,
>   					    job->gws_size, job->oa_base,
>   					    job->oa_size);
> -	}
>   
>   	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>   		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>   		if (r)
>   			return r;
> +	} else {
> +		fence = NULL;
> +	}
> +
> +	amdgpu_ring_patch_cond_exec(ring, patch);
> +
> +	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
> +	if (ring->funcs->emit_switch_buffer) {
> +		amdgpu_ring_emit_switch_buffer(ring);
> +		amdgpu_ring_emit_switch_buffer(ring);
>   	}
>   
> +	amdgpu_ring_ib_end(ring);
> +


By moving this here, we ensure that previous jobs  that those are 
dependent on current job are managed & complete, fully synchronized 
before any patching or switching buffers logic's are applied. In gang 
submissions, this is crucial. Ensuring synchronization before context 
changes prevents one job from interfering with another, thus enforcing 
isolation effectively.


> +	/* And finally remember what the ring has executed */
>   	if (vm_flush_needed) {
>   		mutex_lock(&id_mgr->lock);
>   		dma_fence_put(id->last_flush);
> @@ -749,16 +732,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		mutex_unlock(&adev->enforce_isolation_mutex);
>   	}
>   	dma_fence_put(fence);
> -
> -	amdgpu_ring_patch_cond_exec(ring, patch);
> -
> -	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
> -	if (ring->funcs->emit_switch_buffer) {
> -		amdgpu_ring_emit_switch_buffer(ring);
> -		amdgpu_ring_emit_switch_buffer(ring);
> -	}
> -
> -	amdgpu_ring_ib_end(ring);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index daa2f9b33620..e9ecdb96bafa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -493,7 +493,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       struct ww_acquire_ctx *ticket,
>   		       int (*callback)(void *p, struct amdgpu_bo *bo),
>   		       void *param);
> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> +		    bool need_pipe_sync);
>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate);
>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
> @@ -550,8 +551,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   			   uint32_t fragment_size_default, unsigned max_level,
>   			   unsigned max_bits);
>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -				  struct amdgpu_job *job);
>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>   
>   struct amdgpu_task_info *


Requesting for feedback's that is marked as *[1]* , *[2]* & *[3]* 
addressed ,  with this, the patch is:

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>


