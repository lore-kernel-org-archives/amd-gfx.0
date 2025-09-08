Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2A8CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 16:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B221D10E571;
	Mon,  8 Sep 2025 16:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NjsMjJ3d";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4588310E570
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 16:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkHTedzdf+nr1MSFE6qV1oOT+EC/6cJVyrWkTpWvRuJ0LXjBtYsqnaZrhZExYaz5dyCBDnmjCKTk4yxW2dOmjxx8W7lDTt8rHQR4+pVqO6DpwJbEZrkprWRoRyuARHTLgJptaIRChW++fr2ARolr+ArdYB/W0GRS3z2++GsFAW72Kd5AdIYlBfhL4Ry5e5Bx8XUE1zqtXcuk6f+aUJIJKajIseIff7zoS+jyyZspKuu5r3i77mZB2Vx7rxyMlfk1Ol14N/hLqeH41OTRkQ4hfxiUe+gG4iYZKdQvGGOSj0RtVHkrLvNjlsyb9IlDAvKM3zNkX7F7KAGqyGVB+gq73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/Y8lWsaU8Q4Xfrr9j/t98NUYG6Ry22Y8IKSVRDALOg=;
 b=cjRGNs7uiMlL4jgnqlGuyNklOD/0JQsCgzqLMxxFW10lx+LVEzbeir3tmtq2ab9odtFa1t0N/YcPdsZdP5EjbAlLoSmZBV2nKRHF36ozhYpAvEdgl4IzgFC0mnH1Wq4/W9tj7kduzqAnIGVo2NDL1cE4z/APmwB8JNgrKMHODnl1CbWMkKGwttnKBxXo6ErWe8UD0tMQwpdH/ZNH5uAkZvjMmcV2BrmcwqIXQ1c3KRgV8XO+vpY+HwyCZ/7HyzFf4E1NMBpFPe5Xn28VHcCwu50E56GZETRFlC88EfBd7FUyFdzGgM4SwockpJPG8dc+k4ShJchE+MNAfjCf+lm9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/Y8lWsaU8Q4Xfrr9j/t98NUYG6Ry22Y8IKSVRDALOg=;
 b=NjsMjJ3d8U+2HaMSIZ02Q3sl8StkHfSVaogMt5EywhsVDX8BJQZtFx4rJ2Lx2/Po4c2p6tvYCBZEOnC4aZhmfD6d/Q5pSnh51J8bZBoeED2q3/js6s0IOLyCpYnQ3Xr1oQayy7pMoejrBERlhZ1zM/I6zV7TyxFiYNYoQ00JeYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:39:26 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 16:39:25 +0000
Content-Type: multipart/alternative;
 boundary="------------cjcNa3oggDXXv90DWHz0ABD4"
Message-ID: <54c10f0b-74cc-4bff-96cd-3ae927444188@amd.com>
Date: Mon, 8 Sep 2025 12:39:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: clean up and unify hw fence handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: David.Wu3@amd.com, christian.koenig@amd.com
References: <20250905152552.5558-1-alexander.deucher@amd.com>
 <20250905152552.5558-2-alexander.deucher@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20250905152552.5558-2-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::27) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fd0607-5032-47db-00c3-08ddeef645c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVYyVzN6UFhVeDU1aUlSTkpGc29CZ1M1SnZBdnAwZE5QTFVOMTZwb1BnSm1k?=
 =?utf-8?B?Z2dIQjh5WXhkb1JHUHZka2pKMFg0dUppUCs4WmdQRUZXS2xXSzJBOFBYYzBE?=
 =?utf-8?B?ZU1iTlFEQUQwYUNTWUw3eWhQM1ExWmNkaW5iY2xKanBrWHkrVXRwOERTUlY4?=
 =?utf-8?B?UzV0dlVvV0cvUUw4d25MS0ZvNDBKQld1SUdCZG13Vzh3SUZ4SXRyeGVsL2w4?=
 =?utf-8?B?alhBTVJ0ZWtTaEo1RTduUTJJeUVDTzk1UEV4SWNlaTk2Y0RES1UvN1gxei9X?=
 =?utf-8?B?QzVKRUdkRFJoei9rYmJZOEtaTVl4dm9Zb05lbkw2TkF2YzF2bXlQUlFsRENP?=
 =?utf-8?B?QVlxVFFhQU84ZlhPTnFPUUJrOUxSeGlueUt3RENQemZQcUNUaWE2MlkrQkUx?=
 =?utf-8?B?ZktvN3JOclNIcTZMcEdQOUg4Rk04QWlQWUF1UVlPNExhU0tyOVVhYm1QTHBM?=
 =?utf-8?B?Z2FPb084eisrbVZLc2h1T2JrUDhiTTdxdTB6NUhWNkJzZjNMWWNpb3J5c204?=
 =?utf-8?B?aUxPRVV2bXdnSGhMVUxYUjhWcEhZTmcwc09IY2JNZEhVU2ZHSW1xMFF3N3dp?=
 =?utf-8?B?YWtpa0MrNTFHMjkxYkFSU3FYR0ZyMVg2K3JoUWRJTzEzQVNTQlZOZFJnV1Jz?=
 =?utf-8?B?MjRiVzJNQ015M3Z5UGgrV2cwWTBRcjZ5enZhQ0x6SVZPVFR6QVFyTjVyWkIv?=
 =?utf-8?B?UTNzaE5YSHZCZm5OUXdVbnRQSGQ5b2dBcWZ3eEtqd2xlTGpicjVKdW5SSzA3?=
 =?utf-8?B?V0NHUEtMS0ZjS21MTkN1c3BrSlY4TmY2WlBhS2VWYmpvVitCVm5saCtVMVpo?=
 =?utf-8?B?M3NCRmQwelYzNi8yZm51NmhlNlg5RGYyU2dIZDNPSzAxWlE1NEsrSk9VNlhr?=
 =?utf-8?B?eWo1NFZFRWVnV3dVakJRdXk4Qi9EdlhXL0pjM1FUdTRKNVpWR2E5SDJETEh1?=
 =?utf-8?B?MzZoR1BzYm1sUGp4UG1CcUZpZ09BOVZBQjJGbENSZ3hveXVVQ0ZPNkNndWhP?=
 =?utf-8?B?U29YY3I3RHN2NXBsRUQ2ZTBFbm9rUDc5QU5zTDlucnZnckdjb0lycm9MbW5K?=
 =?utf-8?B?QjFMYm9xdURBdUhYbG9JeGxMKzdtMnM5d1FWdGZxU2ZXbjllNHM4TjM2b2xO?=
 =?utf-8?B?d1lXSEE2RG5zT1NBYVJjUmxnOUszZWZIZU9jWS9obzNRRnM3N1BBNTJzVFB2?=
 =?utf-8?B?MTFmNVpsbE5uT3JzY05RSWVrS2ZhZFNYZzI4Vlk2VlFWemtTQmJwNUNBT2R2?=
 =?utf-8?B?cjVWOXM4a3oxTy9iRXE1ZUgzZDRMc1V3L2FCaGpEZlFyZ0JnQWwxZW1JTEZV?=
 =?utf-8?B?OUVtU0lBYWNmdU5rSFhnTlNHNXhTSmUwWDRoRXZuZGUzcUN4WUZQamdzY3BR?=
 =?utf-8?B?REhmVGVYd1p6MFR5NVdwcFNBRGEwZGJwVmFZV1dyY3k1SDkwQmt6LzI0WGZn?=
 =?utf-8?B?c210OGVaMVNmaVNBSW9jMWRkRHdTQSt6SFhSenBzWUl1WkxiV21wVDBYaDE0?=
 =?utf-8?B?MlhDT0RzTm9yd0xWU0J0V1hTUmVCNGxNT29UTEFrVDlHZ0ZRRzlBV0EwaktO?=
 =?utf-8?B?TWplRTlXeVRZdmZRYXFTeG81d0pMS0FPV0lxcHB1dUZRZWlubXBIY2VjQ2ht?=
 =?utf-8?B?eGhBZEszS0tzY1dhdWcwWGVvSjZleC9rU2kyMWlrT2NsYWRqS0Y4cjNWNG8y?=
 =?utf-8?B?MjNuWStUcVl5RTJiR2V0NmtoUnVhNWNVc0ZZV28rMFV3ZGtiek5XVUhkLzBC?=
 =?utf-8?B?b2JiR2xGeTc0RFNhWkdmOE03L0ZqVVdZUCtkTWJLSXhZWlA2bVVnSzBOdVZ1?=
 =?utf-8?B?SWpqU0l1dEw5ZmdzdUZwYnEyOGdicTJyRHZGeGREcFZWN2kydCt6ZUIzWWVj?=
 =?utf-8?B?NkYvM1lJYjRBUCtjT2JRc1gyTGNGVUM1ZW43QzBKYVMxMVRrTlRxWlJ6eTgr?=
 =?utf-8?Q?a0DaE8ajDzU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFYMkZsTHJVeUZMRlM4U29YRzl5c014eTlvOVN3aGhBQmhDYzBHZStjZGtV?=
 =?utf-8?B?WWMrcG9ISWRpRncyRmcweTY3STlkamV0cWtYM0d1OGY4ZTNDVFBpUWExbEFU?=
 =?utf-8?B?ZEF5Q0lOdlAvYUdZSG9RRnMzcVFEVHZYT201ZmdKM3lqam9MWXJGWHZaK2ly?=
 =?utf-8?B?NHJiNDljTlBGdmQwSnpQK2duYXBmWXh6SHlNeEhIR0U3dmlpaDNiZ0RRNDhW?=
 =?utf-8?B?VlB6UHV1V280eWIwK25lemZxK1c4ZFRscEsyZ2NjcE1xUWMxUHRHcGp1N1F0?=
 =?utf-8?B?cGhqQis4OWNWaUJhcjFRcnEvL3ovS3VwblYybkY1elRqaHVHN2VLOEZZZDR4?=
 =?utf-8?B?OVNyT3RRc0FvUEQ2bzZSVk1YWm4zSzhKRzRMTGxQQlNBNURjSzlHVE9KNE1p?=
 =?utf-8?B?a09jdGhzSFRkenFCcjFvbk1tVVVRbVIxOUtLOGVRbDFsWUswdDVzU3RheWtP?=
 =?utf-8?B?STJveUlMd2RoeG5ZU2FJUUxFbmwyOTFEVGVuYUhsOWIzTWl6alIrUGNDZUNN?=
 =?utf-8?B?d28vRXRGUmNMazNOQ2RvWUZ0SWtWSnRhcFF0TWc2SkF0aTVkdkhSTW5GTkRU?=
 =?utf-8?B?bVFXLzFnaTlpSmRjVkF2aEU0RWFnb3RoeU12MHloOHhtQ0gveUJIMHcvczBn?=
 =?utf-8?B?TER4a2JKZDBWbEhScEYvcFpWbmllNmxiUDE3anJkRnNHK3B0dGhMK3Q4Nmxy?=
 =?utf-8?B?U1lFT1JKQ1F4SFNYLzgyaTNiVzdEVVhTVVFUQldrd2lwODNtN3Fsb01yM3NF?=
 =?utf-8?B?MDd2dUJkeGdjcTNOVlNkUzVQejNGelg1RFNpRHplNkM1YWZsR21nOHp2NkQy?=
 =?utf-8?B?K3A0VUNaY1FvU0pkalBkcVhyTTlxelJpc3lqbUU3ajFrV1F5dmRRS1g3U3la?=
 =?utf-8?B?NXF1c0l0Y2cxbVVrZnM0c2JiS2ZucDdGMnFGQndDVnpYYThSYWNGdkF4ME1t?=
 =?utf-8?B?ZS9TMWhtcnRKUXlxc1R6aUtpVVhPV0l4TVhWY2MwaFVsVDgzbWx1SDI5aUph?=
 =?utf-8?B?eVM0Mks4MzF3SkVaV0pNU3BvTXF5NWlLNHRWenB1RW5lY0o2cys5V2dJN3VL?=
 =?utf-8?B?cVpyZ3BuSVNiVFZJVFJlODZCaXltMi9yWmFFQ3Y0S0taQnlmVHVxUmREcFBN?=
 =?utf-8?B?NXNteDhRbE5EY3Z3ZWxXYkV2b2JNSU9jYjEvRjZKS2hIck9kTk5mMlVJYmRa?=
 =?utf-8?B?cmpyNUlzM2cyeDRLQmxwSVorRThjWDFYL1FCcEFmc2JJaU8veGs0b0J2YSsx?=
 =?utf-8?B?dEliOUZIYzlnaFdQejhvSUViUTkvc05IbW1DRVFxNXpIeVZCTm9aN0hSZU41?=
 =?utf-8?B?c0xZTzVNTXE4VTZuckRKYVFXalRaOGcvQXU3YjhVWnhMK3hXMC91TlhIRDIr?=
 =?utf-8?B?bVJnZ1BkbFROd1BQWmdxSHJkUEVvVTlYcEhuR2h5SnE2c2V4L0NMM0V1R3Nx?=
 =?utf-8?B?Q1hqTlBWVGc3emVSd2I0YytwaytGQkwreEZYL3phb2FoWkI5NE5GaDFPWkNr?=
 =?utf-8?B?UEcySDVFWjZWMG1pMVFJaDF4SDFhTG1uUnhVazh5b1N2V3JpbjdNSjA4cm9l?=
 =?utf-8?B?U0FGbjZDNCtxRnlHUElhZUFOWWJXdSsxeWtVaGhnMUtTMnJ3cHc5VCtUU2JY?=
 =?utf-8?B?VnUxd1MzODRpcUFHUUE1NmN5Tkc5VGQ0Ry92Tm02S0tocVB5VGZjQWpqM0tG?=
 =?utf-8?B?R3VwWTVCZFFEemxJU0pueVpIMWFIOUlkVmJGelNQTVNGNXczSTVxWTBPclp1?=
 =?utf-8?B?UTlLYnNsRDE5Njd4R2VycDJkRTdBelEydVcvRDBrc1dNQXVMd2tTbG5wM0dC?=
 =?utf-8?B?ZnJVL0FvZFl4Vy90dkZvYmlHTnRadExLWkZiTmVXWjRjNy9EaWluRUtqRysz?=
 =?utf-8?B?OEVPM1N4UnVITHQyOGtkbHFaUHdNa1ViTjE3cVZ1anJySXc0alYwamZHT3hW?=
 =?utf-8?B?blp3MDZoZXp2QnpLRS8wRkhsL2xSUFQ0NHJzWHl2dGplUjB3YmoyWmZxZGFs?=
 =?utf-8?B?UFlIWUtveHRZSDc4dHo3YUFnWEFteEtFdTY3V25CSVd2OFY2ODRkQTNJYVNI?=
 =?utf-8?B?YjhuV2Z1Z1lzd1ltOVk5WFhxUlFLVStwaGlmMzh5ZjNTcTZSR2ZLTWhmMVJS?=
 =?utf-8?Q?gYTw6r5VtOMz6mq8k6D6/bXGF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fd0607-5032-47db-00c3-08ddeef645c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:39:25.8480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl6LrxTrs3izA6q5OT4kU3cntK4aXIsVUIYUAOmzjInVxIF3/oZcVceB7Nr6s/IOTsMmf3mbXnVFCM6AHrOMZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
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

--------------cjcNa3oggDXXv90DWHz0ABD4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

thank you Alex. The series is:

Tested-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

David

On 2025-09-05 11:25, Alex Deucher wrote:
> Decouple the amdgpu fence from the amdgpu_job structure.
> This lets us clean up the separate fence ops for the embedded
> fence and other fences.  This also allows us to allocate the
> vm fence up front when we allocate the job.
>
> v2: Additional cleanup suggested by Christian
> v3: Additional cleanups suggested by Christian
> v4: Additional cleanups suggested by David and
>      vm fence fix
> v5: cast seqno (David)
>
> Cc:David.Wu3@amd.com
> Cc:christian.koenig@amd.com
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 143 ++------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  17 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  43 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
>   8 files changed, 63 insertions(+), 167 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index a70651050acff..0a62727e74f0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>   			continue;
>   		}
>   		job = to_amdgpu_job(s_job);
> -		if (preempted && (&job->hw_fence.base) == fence)
> +		if (preempted && (&job->hw_fence->base) == fence)
>   			/* mark the job as preempted */
>   			job->preemption_status |= AMDGPU_IB_PREEMPTED;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bdfb80377e6a8..dded88bc374c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5802,11 +5802,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		if (!amdgpu_ring_sched_ready(ring))
>   			continue;
>   
> -		/* Clear job fence from fence drv to avoid force_completion
> -		 * leave NULL and vm flush fence in fence drv
> -		 */
> -		amdgpu_fence_driver_clear_job_fences(ring);
> -
>   		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>   		amdgpu_fence_driver_force_completion(ring);
>   	}
> @@ -6530,7 +6525,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	 *
>   	 * job->base holds a reference to parent fence
>   	 */
> -	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
> +	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
>   		job_signaled = true;
>   		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>   		goto skip_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 72f0f16924476..e9586aab2c474 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -45,16 +45,11 @@
>    * Cast helper
>    */
>   static const struct dma_fence_ops amdgpu_fence_ops;
> -static const struct dma_fence_ops amdgpu_job_fence_ops;
>   static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>   {
>   	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
>   
> -	if (__f->base.ops == &amdgpu_fence_ops ||
> -	    __f->base.ops == &amdgpu_job_fence_ops)
> -		return __f;
> -
> -	return NULL;
> +	return __f;
>   }
>   
>   /**
> @@ -98,51 +93,32 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>    * amdgpu_fence_emit - emit a fence on the requested ring
>    *
>    * @ring: ring the fence is associated with
> - * @f: resulting fence object
>    * @af: amdgpu fence input
>    * @flags: flags to pass into the subordinate .emit_fence() call
>    *
>    * Emits a fence command on the requested ring (all asics).
>    * Returns 0 on success, -ENOMEM on failure.
>    */
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> -		      struct amdgpu_fence *af, unsigned int flags)
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +		      unsigned int flags)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence;
> -	struct amdgpu_fence *am_fence;
>   	struct dma_fence __rcu **ptr;
>   	uint32_t seq;
>   	int r;
>   
> -	if (!af) {
> -		/* create a separate hw fence */
> -		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
> -		if (!am_fence)
> -			return -ENOMEM;
> -	} else {
> -		am_fence = af;
> -	}
> -	fence = &am_fence->base;
> -	am_fence->ring = ring;
> +	fence = &af->base;
> +	af->ring = ring;
>   
>   	seq = ++ring->fence_drv.sync_seq;
> -	am_fence->seq = seq;
> -	if (af) {
> -		dma_fence_init(fence, &amdgpu_job_fence_ops,
> -			       &ring->fence_drv.lock,
> -			       adev->fence_context + ring->idx, seq);
> -		/* Against remove in amdgpu_job_{free, free_cb} */
> -		dma_fence_get(fence);
> -	} else {
> -		dma_fence_init(fence, &amdgpu_fence_ops,
> -			       &ring->fence_drv.lock,
> -			       adev->fence_context + ring->idx, seq);
> -	}
> +	dma_fence_init(fence, &amdgpu_fence_ops,
> +		       &ring->fence_drv.lock,
> +		       adev->fence_context + ring->idx, seq);
>   
>   	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>   			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> -	amdgpu_fence_save_wptr(fence);
> +	amdgpu_fence_save_wptr(af);
>   	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>   	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>   	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> @@ -167,8 +143,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>   	 */
>   	rcu_assign_pointer(*ptr, dma_fence_get(fence));
>   
> -	*f = fence;
> -
>   	return 0;
>   }
>   
> @@ -669,36 +643,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>   	}
>   }
>   
> -/**
> - * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of ring
> - *
> - * @ring: fence of the ring to be cleared
> - *
> - */
> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
> -{
> -	int i;
> -	struct dma_fence *old, **ptr;
> -
> -	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
> -		ptr = &ring->fence_drv.fences[i];
> -		old = rcu_dereference_protected(*ptr, 1);
> -		if (old && old->ops == &amdgpu_job_fence_ops) {
> -			struct amdgpu_job *job;
> -
> -			/* For non-scheduler bad job, i.e. failed ib test, we need to signal
> -			 * it right here or we won't be able to track them in fence_drv
> -			 * and they will remain unsignaled during sa_bo free.
> -			 */
> -			job = container_of(old, struct amdgpu_job, hw_fence.base);
> -			if (!job->base.s_fence && !dma_fence_is_signaled(old))
> -				dma_fence_signal(old);
> -			RCU_INIT_POINTER(*ptr, NULL);
> -			dma_fence_put(old);
> -		}
> -	}
> -}
> -
>   /**
>    * amdgpu_fence_driver_set_error - set error code on fences
>    * @ring: the ring which contains the fences
> @@ -755,7 +699,7 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>   /**
>    * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
>    *
> - * @fence: fence of the ring to signal
> + * @af: fence of the ring to signal
>    *
>    */
>   void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
> @@ -786,15 +730,13 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>   		rcu_read_unlock();
>   	}
>   	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> -	amdgpu_fence_write(ring, af->seq);
> +	amdgpu_fence_write(ring, (u32)af->base.seqno);
>   	amdgpu_fence_process(ring);
>   }
>   
> -void amdgpu_fence_save_wptr(struct dma_fence *fence)
> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
>   {
> -	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
> -
> -	am_fence->wptr = am_fence->ring->wptr;
> +	af->wptr = af->ring->wptr;
>   }
>   
>   static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
> @@ -855,13 +797,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>   	return (const char *)to_amdgpu_fence(f)->ring->name;
>   }
>   
> -static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
> -{
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
> -
> -	return (const char *)to_amdgpu_ring(job->base.sched)->name;
> -}
> -
>   /**
>    * amdgpu_fence_enable_signaling - enable signalling on fence
>    * @f: fence
> @@ -878,23 +813,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>   	return true;
>   }
>   
> -/**
> - * amdgpu_job_fence_enable_signaling - enable signalling on job fence
> - * @f: fence
> - *
> - * This is the simliar function with amdgpu_fence_enable_signaling above, it
> - * only handles the job embedded fence.
> - */
> -static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
> -{
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
> -
> -	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
> -		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
> -
> -	return true;
> -}
> -
>   /**
>    * amdgpu_fence_free - free up the fence memory
>    *
> @@ -910,21 +828,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
>   	kfree(to_amdgpu_fence(f));
>   }
>   
> -/**
> - * amdgpu_job_fence_free - free up the job with embedded fence
> - *
> - * @rcu: RCU callback head
> - *
> - * Free up the job with embedded fence after the RCU grace period.
> - */
> -static void amdgpu_job_fence_free(struct rcu_head *rcu)
> -{
> -	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> -
> -	/* free job if fence has a parent job */
> -	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
> -}
> -
>   /**
>    * amdgpu_fence_release - callback that fence can be freed
>    *
> @@ -938,19 +841,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
>   	call_rcu(&f->rcu, amdgpu_fence_free);
>   }
>   
> -/**
> - * amdgpu_job_fence_release - callback that job embedded fence can be freed
> - *
> - * @f: fence
> - *
> - * This is the simliar function with amdgpu_fence_release above, it
> - * only handles the job embedded fence.
> - */
> -static void amdgpu_job_fence_release(struct dma_fence *f)
> -{
> -	call_rcu(&f->rcu, amdgpu_job_fence_free);
> -}
> -
>   static const struct dma_fence_ops amdgpu_fence_ops = {
>   	.get_driver_name = amdgpu_fence_get_driver_name,
>   	.get_timeline_name = amdgpu_fence_get_timeline_name,
> @@ -958,13 +848,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
>   	.release = amdgpu_fence_release,
>   };
>   
> -static const struct dma_fence_ops amdgpu_job_fence_ops = {
> -	.get_driver_name = amdgpu_fence_get_driver_name,
> -	.get_timeline_name = amdgpu_job_fence_get_timeline_name,
> -	.enable_signaling = amdgpu_job_fence_enable_signaling,
> -	.release = amdgpu_job_fence_release,
> -};
> -
>   /*
>    * Fence debugfs
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 7d9bcb72e8dd3..39229ece83f83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -149,17 +149,19 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	if (job) {
>   		vm = job->vm;
>   		fence_ctx = job->base.s_fence ?
> -			job->base.s_fence->scheduled.context : 0;
> +			job->base.s_fence->finished.context : 0;
>   		shadow_va = job->shadow_va;
>   		csa_va = job->csa_va;
>   		gds_va = job->gds_va;
>   		init_shadow = job->init_shadow;
> -		af = &job->hw_fence;
> +		af = job->hw_fence;
>   		/* Save the context of the job for reset handling.
>   		 * The driver needs this so it can skip the ring
>   		 * contents for guilty contexts.
>   		 */
> -		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
> +		af->context = fence_ctx;
> +		/* the vm fence is also part of the job's context */
> +		job->hw_vm_fence->context = fence_ctx;
>   	} else {
>   		vm = NULL;
>   		fence_ctx = 0;
> @@ -167,7 +169,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   		csa_va = 0;
>   		gds_va = 0;
>   		init_shadow = false;
> -		af = NULL;
> +		af = kzalloc(sizeof(*af), GFP_ATOMIC);
> +		if (!af)
> +			return -ENOMEM;
>   	}
>   
>   	if (!ring->sched.ready) {
> @@ -289,7 +293,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
>   	}
>   
> -	r = amdgpu_fence_emit(ring, f, af, fence_flags);
> +	r = amdgpu_fence_emit(ring, af, fence_flags);
>   	if (r) {
>   		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>   		if (job && job->vmid)
> @@ -297,6 +301,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   		amdgpu_ring_undo(ring);
>   		return r;
>   	}
> +	*f = &af->base;
>   
>   	if (ring->funcs->insert_end)
>   		ring->funcs->insert_end(ring);
> @@ -317,7 +322,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	 * fence so we know what rings contents to backup
>   	 * after we reset the queue.
>   	 */
> -	amdgpu_fence_save_wptr(*f);
> +	amdgpu_fence_save_wptr(af);
>   
>   	amdgpu_ring_ib_end(ring);
>   	amdgpu_ring_commit(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 172620880cada..55c7e104d5ca0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -137,7 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		   ring->funcs->reset) {
>   		dev_err(adev->dev, "Starting %s ring reset\n",
>   			s_job->sched->name);
> -		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
> +		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>   		if (!r) {
>   			atomic_inc(&ring->adev->gpu_reset_counter);
>   			dev_err(adev->dev, "Ring %s reset succeeded\n",
> @@ -187,6 +187,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		     unsigned int num_ibs, struct amdgpu_job **job,
>   		     u64 drm_client_id)
>   {
> +	struct amdgpu_fence *af;
> +	int r;
> +
>   	if (num_ibs == 0)
>   		return -EINVAL;
>   
> @@ -194,6 +197,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (!*job)
>   		return -ENOMEM;
>   
> +	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	if (!af) {
> +		r = -ENOMEM;
> +		goto err_job;
> +	}
> +	(*job)->hw_fence = af;
> +
> +	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	if (!af) {
> +		r = -ENOMEM;
> +		goto err_fence;
> +	}
> +	(*job)->hw_vm_fence = af;
> +
>   	(*job)->vm = vm;
>   
>   	amdgpu_sync_create(&(*job)->explicit_sync);
> @@ -205,6 +222,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	return drm_sched_job_init(&(*job)->base, entity, 1, owner,
>   				  drm_client_id);
> +
> +err_fence:
> +	kfree((*job)->hw_fence);
> +err_job:
> +	kfree(*job);
> +
> +	return r;
>   }
>   
>   int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
> @@ -251,11 +275,11 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>   	struct dma_fence *f;
>   	unsigned i;
>   
> -	/* Check if any fences where initialized */
> +	/* Check if any fences were initialized */
>   	if (job->base.s_fence && job->base.s_fence->finished.ops)
>   		f = &job->base.s_fence->finished;
> -	else if (job->hw_fence.base.ops)
> -		f = &job->hw_fence.base;
> +	else if (job->hw_fence && job->hw_fence->base.ops)
> +		f = &job->hw_fence->base;
>   	else
>   		f = NULL;
>   
> @@ -271,11 +295,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   
>   	amdgpu_sync_free(&job->explicit_sync);
>   
> -	/* only put the hw fence if has embedded fence */
> -	if (!job->hw_fence.base.ops)
> -		kfree(job);
> -	else
> -		dma_fence_put(&job->hw_fence.base);
> +	kfree(job);
>   }
>   
>   void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> @@ -304,10 +324,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>   	if (job->gang_submit != &job->base.s_fence->scheduled)
>   		dma_fence_put(job->gang_submit);
>   
> -	if (!job->hw_fence.base.ops)
> -		kfree(job);
> -	else
> -		dma_fence_put(&job->hw_fence.base);
> +	kfree(job);
>   }
>   
>   struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 2f302266662bc..d25f1fcf0242e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -48,7 +48,8 @@ struct amdgpu_job {
>   	struct drm_sched_job    base;
>   	struct amdgpu_vm	*vm;
>   	struct amdgpu_sync	explicit_sync;
> -	struct amdgpu_fence	hw_fence;
> +	struct amdgpu_fence	*hw_fence;
> +	struct amdgpu_fence	*hw_vm_fence;
>   	struct dma_fence	*gang_submit;
>   	uint32_t		preamble_status;
>   	uint32_t                preemption_status;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 0704fd9b85fdb..5d44f1354c8d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -147,16 +147,14 @@ struct amdgpu_fence {
>   	u64				wptr;
>   	/* fence context for resets */
>   	u64				context;
> -	uint32_t			seq;
>   };
>   
>   extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>   
> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>   void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>   void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
> -void amdgpu_fence_save_wptr(struct dma_fence *fence);
> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
>   
>   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -166,8 +164,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>   int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> -		      struct amdgpu_fence *af, unsigned int flags);
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +		      unsigned int flags);
>   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>   			      uint32_t timeout);
>   bool amdgpu_fence_process(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index bd12d8ff15a42..76bae546df11c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	bool cleaner_shader_needed = false;
>   	bool pasid_mapping_needed = false;
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_fence *af;
>   	unsigned int patch;
>   	int r;
>   
> @@ -835,12 +834,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	}
>   
>   	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
> -		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
> +		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>   		if (r)
>   			return r;
> -		/* this is part of the job's context */
> -		af = container_of(fence, struct amdgpu_fence, base);
> -		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
> +		fence = &job->hw_vm_fence->base;
>   	}
>   
>   	if (vm_flush_needed) {
--------------cjcNa3oggDXXv90DWHz0ABD4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font face="Helvetica, Arial, sans-serif">thank you Alex. The s</font><font face="Helvetica, Arial, sans-serif" style="white-space: pre-wrap;">eries is:</font></p>
    <p><font face="Helvetica, Arial, sans-serif">Tested-by: David (Ming
        Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a><br>
        Reviewed-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a></font></p>
    <p><font face="Helvetica, Arial, sans-serif">David</font><br>
    </p>
    <div class="moz-cite-prefix">On 2025-09-05 11:25, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250905152552.5558-2-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Decouple the amdgpu fence from the amdgpu_job structure.
This lets us clean up the separate fence ops for the embedded
fence and other fences.  This also allows us to allocate the
vm fence up front when we allocate the job.

v2: Additional cleanup suggested by Christian
v3: Additional cleanups suggested by Christian
v4: Additional cleanups suggested by David and
    vm fence fix
v5: cast seqno (David)

Cc: <a class="moz-txt-link-abbreviated" href="mailto:David.Wu3@amd.com">David.Wu3@amd.com</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:christian.koenig@amd.com">christian.koenig@amd.com</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 143 ++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  17 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  43 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
 8 files changed, 63 insertions(+), 167 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a70651050acff..0a62727e74f0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
 			continue;
 		}
 		job = to_amdgpu_job(s_job);
-		if (preempted &amp;&amp; (&amp;job-&gt;hw_fence.base) == fence)
+		if (preempted &amp;&amp; (&amp;job-&gt;hw_fence-&gt;base) == fence)
 			/* mark the job as preempted */
 			job-&gt;preemption_status |= AMDGPU_IB_PREEMPTED;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bdfb80377e6a8..dded88bc374c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5802,11 +5802,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
-		/* Clear job fence from fence drv to avoid force_completion
-		 * leave NULL and vm flush fence in fence drv
-		 */
-		amdgpu_fence_driver_clear_job_fences(ring);
-
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
 		amdgpu_fence_driver_force_completion(ring);
 	}
@@ -6530,7 +6525,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job-&gt;base holds a reference to parent fence
 	 */
-	if (job &amp;&amp; dma_fence_is_signaled(&amp;job-&gt;hw_fence.base)) {
+	if (job &amp;&amp; dma_fence_is_signaled(&amp;job-&gt;hw_fence-&gt;base)) {
 		job_signaled = true;
 		dev_info(adev-&gt;dev, &quot;Guilty job already signaled, skipping HW reset&quot;);
 		goto skip_hw_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 72f0f16924476..e9586aab2c474 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -45,16 +45,11 @@
  * Cast helper
  */
 static const struct dma_fence_ops amdgpu_fence_ops;
-static const struct dma_fence_ops amdgpu_job_fence_ops;
 static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
 {
 	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
 
-	if (__f-&gt;base.ops == &amp;amdgpu_fence_ops ||
-	    __f-&gt;base.ops == &amp;amdgpu_job_fence_ops)
-		return __f;
-
-	return NULL;
+	return __f;
 }
 
 /**
@@ -98,51 +93,32 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  * amdgpu_fence_emit - emit a fence on the requested ring
  *
  * @ring: ring the fence is associated with
- * @f: resulting fence object
  * @af: amdgpu fence input
  * @flags: flags to pass into the subordinate .emit_fence() call
  *
  * Emits a fence command on the requested ring (all asics).
  * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
-		      struct amdgpu_fence *af, unsigned int flags)
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		      unsigned int flags)
 {
 	struct amdgpu_device *adev = ring-&gt;adev;
 	struct dma_fence *fence;
-	struct amdgpu_fence *am_fence;
 	struct dma_fence __rcu **ptr;
 	uint32_t seq;
 	int r;
 
-	if (!af) {
-		/* create a separate hw fence */
-		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
-		if (!am_fence)
-			return -ENOMEM;
-	} else {
-		am_fence = af;
-	}
-	fence = &amp;am_fence-&gt;base;
-	am_fence-&gt;ring = ring;
+	fence = &amp;af-&gt;base;
+	af-&gt;ring = ring;
 
 	seq = ++ring-&gt;fence_drv.sync_seq;
-	am_fence-&gt;seq = seq;
-	if (af) {
-		dma_fence_init(fence, &amp;amdgpu_job_fence_ops,
-			       &amp;ring-&gt;fence_drv.lock,
-			       adev-&gt;fence_context + ring-&gt;idx, seq);
-		/* Against remove in amdgpu_job_{free, free_cb} */
-		dma_fence_get(fence);
-	} else {
-		dma_fence_init(fence, &amp;amdgpu_fence_ops,
-			       &amp;ring-&gt;fence_drv.lock,
-			       adev-&gt;fence_context + ring-&gt;idx, seq);
-	}
+	dma_fence_init(fence, &amp;amdgpu_fence_ops,
+		       &amp;ring-&gt;fence_drv.lock,
+		       adev-&gt;fence_context + ring-&gt;idx, seq);
 
 	amdgpu_ring_emit_fence(ring, ring-&gt;fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
-	amdgpu_fence_save_wptr(fence);
+	amdgpu_fence_save_wptr(af);
 	pm_runtime_get_noresume(adev_to_drm(adev)-&gt;dev);
 	ptr = &amp;ring-&gt;fence_drv.fences[seq &amp; ring-&gt;fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
@@ -167,8 +143,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 	 */
 	rcu_assign_pointer(*ptr, dma_fence_get(fence));
 
-	*f = fence;
-
 	return 0;
 }
 
@@ -669,36 +643,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of ring
- *
- * @ring: fence of the ring to be cleared
- *
- */
-void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
-{
-	int i;
-	struct dma_fence *old, **ptr;
-
-	for (i = 0; i &lt;= ring-&gt;fence_drv.num_fences_mask; i++) {
-		ptr = &amp;ring-&gt;fence_drv.fences[i];
-		old = rcu_dereference_protected(*ptr, 1);
-		if (old &amp;&amp; old-&gt;ops == &amp;amdgpu_job_fence_ops) {
-			struct amdgpu_job *job;
-
-			/* For non-scheduler bad job, i.e. failed ib test, we need to signal
-			 * it right here or we won't be able to track them in fence_drv
-			 * and they will remain unsignaled during sa_bo free.
-			 */
-			job = container_of(old, struct amdgpu_job, hw_fence.base);
-			if (!job-&gt;base.s_fence &amp;&amp; !dma_fence_is_signaled(old))
-				dma_fence_signal(old);
-			RCU_INIT_POINTER(*ptr, NULL);
-			dma_fence_put(old);
-		}
-	}
-}
-
 /**
  * amdgpu_fence_driver_set_error - set error code on fences
  * @ring: the ring which contains the fences
@@ -755,7 +699,7 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 /**
  * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
  *
- * @fence: fence of the ring to signal
+ * @af: fence of the ring to signal
  *
  */
 void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
@@ -786,15 +730,13 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		rcu_read_unlock();
 	}
 	spin_unlock_irqrestore(&amp;ring-&gt;fence_drv.lock, flags);
-	amdgpu_fence_write(ring, af-&gt;seq);
+	amdgpu_fence_write(ring, (u32)af-&gt;base.seqno);
 	amdgpu_fence_process(ring);
 }
 
-void amdgpu_fence_save_wptr(struct dma_fence *fence)
+void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
 {
-	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
-
-	am_fence-&gt;wptr = am_fence-&gt;ring-&gt;wptr;
+	af-&gt;wptr = af-&gt;ring-&gt;wptr;
 }
 
 static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
@@ -855,13 +797,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
 	return (const char *)to_amdgpu_fence(f)-&gt;ring-&gt;name;
 }
 
-static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
-{
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
-
-	return (const char *)to_amdgpu_ring(job-&gt;base.sched)-&gt;name;
-}
-
 /**
  * amdgpu_fence_enable_signaling - enable signalling on fence
  * @f: fence
@@ -878,23 +813,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
 	return true;
 }
 
-/**
- * amdgpu_job_fence_enable_signaling - enable signalling on job fence
- * @f: fence
- *
- * This is the simliar function with amdgpu_fence_enable_signaling above, it
- * only handles the job embedded fence.
- */
-static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
-{
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
-
-	if (!timer_pending(&amp;to_amdgpu_ring(job-&gt;base.sched)-&gt;fence_drv.fallback_timer))
-		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job-&gt;base.sched));
-
-	return true;
-}
-
 /**
  * amdgpu_fence_free - free up the fence memory
  *
@@ -910,21 +828,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
 	kfree(to_amdgpu_fence(f));
 }
 
-/**
- * amdgpu_job_fence_free - free up the job with embedded fence
- *
- * @rcu: RCU callback head
- *
- * Free up the job with embedded fence after the RCU grace period.
- */
-static void amdgpu_job_fence_free(struct rcu_head *rcu)
-{
-	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
-
-	/* free job if fence has a parent job */
-	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
-}
-
 /**
  * amdgpu_fence_release - callback that fence can be freed
  *
@@ -938,19 +841,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
 	call_rcu(&amp;f-&gt;rcu, amdgpu_fence_free);
 }
 
-/**
- * amdgpu_job_fence_release - callback that job embedded fence can be freed
- *
- * @f: fence
- *
- * This is the simliar function with amdgpu_fence_release above, it
- * only handles the job embedded fence.
- */
-static void amdgpu_job_fence_release(struct dma_fence *f)
-{
-	call_rcu(&amp;f-&gt;rcu, amdgpu_job_fence_free);
-}
-
 static const struct dma_fence_ops amdgpu_fence_ops = {
 	.get_driver_name = amdgpu_fence_get_driver_name,
 	.get_timeline_name = amdgpu_fence_get_timeline_name,
@@ -958,13 +848,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
 	.release = amdgpu_fence_release,
 };
 
-static const struct dma_fence_ops amdgpu_job_fence_ops = {
-	.get_driver_name = amdgpu_fence_get_driver_name,
-	.get_timeline_name = amdgpu_job_fence_get_timeline_name,
-	.enable_signaling = amdgpu_job_fence_enable_signaling,
-	.release = amdgpu_job_fence_release,
-};
-
 /*
  * Fence debugfs
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 7d9bcb72e8dd3..39229ece83f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -149,17 +149,19 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (job) {
 		vm = job-&gt;vm;
 		fence_ctx = job-&gt;base.s_fence ?
-			job-&gt;base.s_fence-&gt;scheduled.context : 0;
+			job-&gt;base.s_fence-&gt;finished.context : 0;
 		shadow_va = job-&gt;shadow_va;
 		csa_va = job-&gt;csa_va;
 		gds_va = job-&gt;gds_va;
 		init_shadow = job-&gt;init_shadow;
-		af = &amp;job-&gt;hw_fence;
+		af = job-&gt;hw_fence;
 		/* Save the context of the job for reset handling.
 		 * The driver needs this so it can skip the ring
 		 * contents for guilty contexts.
 		 */
-		af-&gt;context = job-&gt;base.s_fence ? job-&gt;base.s_fence-&gt;finished.context : 0;
+		af-&gt;context = fence_ctx;
+		/* the vm fence is also part of the job's context */
+		job-&gt;hw_vm_fence-&gt;context = fence_ctx;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -167,7 +169,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		csa_va = 0;
 		gds_va = 0;
 		init_shadow = false;
-		af = NULL;
+		af = kzalloc(sizeof(*af), GFP_ATOMIC);
+		if (!af)
+			return -ENOMEM;
 	}
 
 	if (!ring-&gt;sched.ready) {
@@ -289,7 +293,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_init_cond_exec(ring, ring-&gt;cond_exe_gpu_addr);
 	}
 
-	r = amdgpu_fence_emit(ring, f, af, fence_flags);
+	r = amdgpu_fence_emit(ring, af, fence_flags);
 	if (r) {
 		dev_err(adev-&gt;dev, &quot;failed to emit fence (%d)\n&quot;, r);
 		if (job &amp;&amp; job-&gt;vmid)
@@ -297,6 +301,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	*f = &amp;af-&gt;base;
 
 	if (ring-&gt;funcs-&gt;insert_end)
 		ring-&gt;funcs-&gt;insert_end(ring);
@@ -317,7 +322,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	 * fence so we know what rings contents to backup
 	 * after we reset the queue.
 	 */
-	amdgpu_fence_save_wptr(*f);
+	amdgpu_fence_save_wptr(af);
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 172620880cada..55c7e104d5ca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,7 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		   ring-&gt;funcs-&gt;reset) {
 		dev_err(adev-&gt;dev, &quot;Starting %s ring reset\n&quot;,
 			s_job-&gt;sched-&gt;name);
-		r = amdgpu_ring_reset(ring, job-&gt;vmid, &amp;job-&gt;hw_fence);
+		r = amdgpu_ring_reset(ring, job-&gt;vmid, job-&gt;hw_fence);
 		if (!r) {
 			atomic_inc(&amp;ring-&gt;adev-&gt;gpu_reset_counter);
 			dev_err(adev-&gt;dev, &quot;Ring %s reset succeeded\n&quot;,
@@ -187,6 +187,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     unsigned int num_ibs, struct amdgpu_job **job,
 		     u64 drm_client_id)
 {
+	struct amdgpu_fence *af;
+	int r;
+
 	if (num_ibs == 0)
 		return -EINVAL;
 
@@ -194,6 +197,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!*job)
 		return -ENOMEM;
 
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		r = -ENOMEM;
+		goto err_job;
+	}
+	(*job)-&gt;hw_fence = af;
+
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		r = -ENOMEM;
+		goto err_fence;
+	}
+	(*job)-&gt;hw_vm_fence = af;
+
 	(*job)-&gt;vm = vm;
 
 	amdgpu_sync_create(&amp;(*job)-&gt;explicit_sync);
@@ -205,6 +222,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	return drm_sched_job_init(&amp;(*job)-&gt;base, entity, 1, owner,
 				  drm_client_id);
+
+err_fence:
+	kfree((*job)-&gt;hw_fence);
+err_job:
+	kfree(*job);
+
+	return r;
 }
 
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
@@ -251,11 +275,11 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 	struct dma_fence *f;
 	unsigned i;
 
-	/* Check if any fences where initialized */
+	/* Check if any fences were initialized */
 	if (job-&gt;base.s_fence &amp;&amp; job-&gt;base.s_fence-&gt;finished.ops)
 		f = &amp;job-&gt;base.s_fence-&gt;finished;
-	else if (job-&gt;hw_fence.base.ops)
-		f = &amp;job-&gt;hw_fence.base;
+	else if (job-&gt;hw_fence &amp;&amp; job-&gt;hw_fence-&gt;base.ops)
+		f = &amp;job-&gt;hw_fence-&gt;base;
 	else
 		f = NULL;
 
@@ -271,11 +295,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	amdgpu_sync_free(&amp;job-&gt;explicit_sync);
 
-	/* only put the hw fence if has embedded fence */
-	if (!job-&gt;hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&amp;job-&gt;hw_fence.base);
+	kfree(job);
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -304,10 +324,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	if (job-&gt;gang_submit != &amp;job-&gt;base.s_fence-&gt;scheduled)
 		dma_fence_put(job-&gt;gang_submit);
 
-	if (!job-&gt;hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&amp;job-&gt;hw_fence.base);
+	kfree(job);
 }
 
 struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 2f302266662bc..d25f1fcf0242e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -48,7 +48,8 @@ struct amdgpu_job {
 	struct drm_sched_job    base;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_sync	explicit_sync;
-	struct amdgpu_fence	hw_fence;
+	struct amdgpu_fence	*hw_fence;
+	struct amdgpu_fence	*hw_vm_fence;
 	struct dma_fence	*gang_submit;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 0704fd9b85fdb..5d44f1354c8d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -147,16 +147,14 @@ struct amdgpu_fence {
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
-	uint32_t			seq;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
-void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
-void amdgpu_fence_save_wptr(struct dma_fence *fence);
+void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -166,8 +164,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
 int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
-		      struct amdgpu_fence *af, unsigned int flags);
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		      unsigned int flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
 bool amdgpu_fence_process(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bd12d8ff15a42..76bae546df11c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
-	struct amdgpu_fence *af;
 	unsigned int patch;
 	int r;
 
@@ -835,12 +834,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
-		r = amdgpu_fence_emit(ring, &amp;fence, NULL, 0);
+		r = amdgpu_fence_emit(ring, job-&gt;hw_vm_fence, 0);
 		if (r)
 			return r;
-		/* this is part of the job's context */
-		af = container_of(fence, struct amdgpu_fence, base);
-		af-&gt;context = job-&gt;base.s_fence ? job-&gt;base.s_fence-&gt;finished.context : 0;
+		fence = &amp;job-&gt;hw_vm_fence-&gt;base;
 	}
 
 	if (vm_flush_needed) {
</pre>
    </blockquote>
  </body>
</html>

--------------cjcNa3oggDXXv90DWHz0ABD4--
