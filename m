Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D76CAC5B0
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 22:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8AA10E85A;
	Thu,  2 Oct 2025 22:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ir04tidj";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010027.outbound.protection.outlook.com
 [40.93.198.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8B910E858
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 22:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9RcUa3wgH9K5WxJazAeg3nViuLK5IQbbC0F7713Tc8mtQpxTVSytqDv1qMHWyV/i+ibB//Sbl1FKgNasuzWCqGiw5vZrxQ72j5yDepf/CRV8Nq2UInCsQ3GxFqoCntpsQreEXff1Qs5H3Ssf0nsrp5D3HjVvxcZSx5CFXSb9kTy2ssXoh9pBjefVIj4C1qswiylPs7R5hfeM2dT60XGXcK/D6NKvDDvo2sg2myQy8yX+LG7XyWJXF5hAX23Sbif0mpAAfIxmo5AeEiKhE0upQgwJL2DOfyw9r7y/HGC5/At6nmsAlkKiysnt+8iY84+11vSZjw77WWzx0FoBlgGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5I2o3pUdVaEu1TMIgqexNc0LQZkAk8+rAiLmMO9li8w=;
 b=SwHNRU3fddfpvtM52TwxFe9cuaJ0clTtNRbomUQxn2fC+05uNTkHe4iF0f/spznPq8CI9Q0ZgWWIM9nbEeISJ7QT89vyR83ozf7lZu59AZxGnB1MU7qBbcEKSzUBwCuKGdX+3/jS1LpR8TSkU5CeT6JugdX77uyJtNOBacHfv+1jEbeeVPruE/ajEhTWYJG4nZ1wMvdokCE/LxlIv4ZL+jOHYCdOVwhn2qz2xfEzmf2k6X32IItWlzXjf640hRAtGWFCXd4JTRrsuO8PpDnyJOUW7RAKJSljwv9InVDoZK1WtiW+s7CDpmIK41Z5kd8U3KAYl6c5bFAwJpYLnjE3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5I2o3pUdVaEu1TMIgqexNc0LQZkAk8+rAiLmMO9li8w=;
 b=Ir04tidjjg3Lt/vb3af7T66fOJG8+YA+yPSNMnbQpH+N40kSZBrgprwilMZXwVe70YLN52lzggf65PZQBAS9g7yHIQhct6ivUt9MKno35X2S+uYAsbdqi2/+n1uanBuQxLxXe7u1TwMX+/mOuo2JH3uTPsuCDyMOnCANNBBmmms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Thu, 2 Oct 2025 22:04:30 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 22:04:30 +0000
Message-ID: <75531fd4-74fa-424a-abed-3f5f03d7717d@amd.com>
Date: Thu, 2 Oct 2025 17:04:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdkfd: svm unmap use page aligned address
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, harish.kasiviswanathan@amd.com
References: <20251002174307.10583-1-Philip.Yang@amd.com>
 <20251002174307.10583-2-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251002174307.10583-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::23) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: b63d9c4f-2308-4ef1-b3de-08de01ffa912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVN0dnJZYUNSV1JKK3JteFlUUWpHYXJMb1hvRERiT204S09iZmdBbFJWT2Fv?=
 =?utf-8?B?NFo2aUNzV2d3ZU54cHhOS0x1NDlsam95TWd0UERoem1PaDV1Qm44S1NIek1i?=
 =?utf-8?B?U0IreWFOaGxZY2NjNDZCWXNwL1VucHo2V3A0OS8yUm9ESllrenZOY2tpQU50?=
 =?utf-8?B?Y1ExV1FwVzJESFF1YUlXZjRWSTNRNE90OVZxVzE5LzlNNFFoN05MVGhnc0xy?=
 =?utf-8?B?QzZpcjhZUVJqMHhvSjZDVDlTVkh0MFRLTExZWDB0RUhBZUJBRlVKc2h2RlV1?=
 =?utf-8?B?RG5MZUY1cEd4dVZ3enRGZHQ0d3p4cjZrN0hFSmc5czl2SzNwTWNKK3AwN1J3?=
 =?utf-8?B?Q0orK3N0aHdQNTVWMmIwcnNOR2dNV0dNU1hodkt4Mks2SVNmZjd4ZmE4QnRU?=
 =?utf-8?B?RmwyY2YzMitkODd5S1NhQmZoK1hqSFlyV0tvY2cxaHpjN1BmYVorSWF1SzNi?=
 =?utf-8?B?ejRKTktHanFnK3l0UTZoNWFaVUtzeFBBZHYxOG5uOXdCUndHQ0JZYzVzUFhv?=
 =?utf-8?B?MmhYeDIvMURLVTJKWjJUSmNlTHRNNlNBVUFqRS9BSmloc1czbzFlNlYrL1Zp?=
 =?utf-8?B?WjFsMnpXR09SbHV6dzNRUnQ0cWVKajRxWEpMZ3hFdEEySnFvTU0zTEpFdmFQ?=
 =?utf-8?B?b1IvWGNRVnRFbXNTMm45ZW9ZMy9tcGNuaFZ5akJ6MzY3d2wrcmJNZXd2TmtO?=
 =?utf-8?B?a0RMeUowVHhzdVlPek0yUmFLbm5WQlliZEZzN0R3Z3BnTHhxdFJzUUdHbSt6?=
 =?utf-8?B?eFZzNUtBU1pnSG5xTWdyWkNrYkI0L1FwM3UvbGdpRVh3dDZNRmN2ZTN1ZDV6?=
 =?utf-8?B?ajI1RHhGOGxDVUF1U0dBbGUxS1FmWUlzYU5oTWQwOFdMWUNpR0wxbWpMQVdT?=
 =?utf-8?B?TUdSN0F0TWk1UVRCNUU3aUdXaGNvalJFWWxKZjR4LzJ1VGdRZllpbXJRN25h?=
 =?utf-8?B?cis4NVB1bjkrUDhmVHJSeUdBUHlISzIzK2ErV0F2dzdOMFYyTG1Yb0s3clM3?=
 =?utf-8?B?a2FiUVpoWU1yQkZVREZ4QTlwbjFXSGRkajNGUDhVUWJ4eitDaGEwcytkWlRM?=
 =?utf-8?B?L0x2WndKOEZWeS9DbWppak5MeGN4Y1ZKSEZuTDVmTlYzdFFSN2hGMDhaQktS?=
 =?utf-8?B?YlU3WDFSMmROSTZlUmdyczBsOERGWG1jOWFwdWdERGlTN2laRlUzWDJieUZX?=
 =?utf-8?B?TUJ3aXBBdm90SmtONGNWZXE3ZUtPdGh6Zks1NnRuUzh5SExuSG5qOEdURElt?=
 =?utf-8?B?WWRKeXBmZmVlN2E2eHE3czZ5VldqU3BVLzI2SEYveEdkdVFsdTRraklLV2k1?=
 =?utf-8?B?eFoxZVc0YmNuQmIxVWhRM0c1MkR5REdDaEg2RjJHTnBCT3VOUEdnSlRXL1dL?=
 =?utf-8?B?Z2hldXFyaGx4STBwZDMxS1ZMUVFJaloyMkhKREJVL09nTHgwd0h2clB5ZEFr?=
 =?utf-8?B?RTdHWnFtN05rYTB1RHNsYUJORWVPOHVwTFluVytQblNkMDFQdERwR0FJelB6?=
 =?utf-8?B?NmY3aW5JdVRMN08rYndCNjNXVDNPOGxoaXlwZHhKclVrejVsMkpHRVdnY3Jx?=
 =?utf-8?B?M0E0VVh0ZmJESFh4b01VNDVXM2lHUS93Z2ZiNHpYM3QvcWdTbTVWSDFheEh4?=
 =?utf-8?B?WU9BSTVaNkFzNzNwS0pidldDMzByVjQzOVVPTERJVGEzZDVadHFnSjZXV2w4?=
 =?utf-8?B?Z1dWd3lJeEExRW5mTVdFWWc2NUNLYkg1RUpxQnBrYjJWNjNKRnlJWXlQWXNo?=
 =?utf-8?B?bEpaZEhmOGhkejZYNnpMMEJaYnU3YTh3RXFINmFDSEFDcTl3WEE3MHF2VlVQ?=
 =?utf-8?B?ZjdIZVllek93YS9tWjh6MWZxMlBtMkVBSnF1UWs2bU92cXpFQ1JrbkVyOFJH?=
 =?utf-8?B?QTZpU2gzNTdBdG5LdHhTNDlhRTFSVnRpcG5ySG4yY1JIQnZjbTBNcUpyWEg3?=
 =?utf-8?Q?tncWm+siiVK7dQBqeut95RbtkkLkTCRP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDFyQ1M5M2hJNEM4dEx2Rjc5ZU1icFQwYmgvck4yVlkzSXhBQjFGV3g5YjBs?=
 =?utf-8?B?ck1DK3JRRzR3clk2U1ZoZHAraThBYkFubCs2QTIyV2h3VHlKajNINTBNa2I4?=
 =?utf-8?B?MlN1RGtJY1psdWhyODk4V1NwMGIrbXJNelBVMm0vMVJOYTgxd2FyNFk5NW85?=
 =?utf-8?B?Zk80L3d6eWc1QXhsSEdhanJlVTlJZHJIaGZpdGJGZjNvR2ltYUZreW5xOVRj?=
 =?utf-8?B?blRydHpJSkFHb1FBdlFHanB3di9YK3VocThodlJjUWlROTE0aE9OUnVIYVFL?=
 =?utf-8?B?VS80Y1BFRGFMeXhjSjd3WWcySHFkL0NBTjRoL0UrdEhDa0pITzYvWW9DUkxi?=
 =?utf-8?B?NjNQbTQrVEdKOXRYaWg5TGpsUWtWQnRhT3FBMXZpYTRFRXNiSjVUUHJDNjdO?=
 =?utf-8?B?aDdqc0xuQWtuaVluUC9JSmN1eXJQQlQwQ3VkM0g2UjVZVlV0ajRmL2RBQUJv?=
 =?utf-8?B?VWJ0RlRvQm9nYVlxK1lFbXdhWWppWDRyNXFKVmlnbWtPSUNrTFZ5VHlSMndE?=
 =?utf-8?B?dlVmUU1MUE5odzZKTjJ5bWEyNVpMUGJJQWIzSE9SRFRDNzJwMS9KTGo2WVhr?=
 =?utf-8?B?Z1JTUWRXMnJtMnJtL0lWaW5TcEhIUW5GM0R1R0hQSU15bkp4MG9vQm9ONURr?=
 =?utf-8?B?akNWVzIvNlAxejRIUkwwMm5TVkM4THJ0UlVkU2V0NzFSMmdGY0NYZVYzMXd2?=
 =?utf-8?B?UmM1TFhSdGhBWnBZN1lSdnJWdjA4cDAxMWhlb2I2QUdUVWtDZ3RSYlIyaTBU?=
 =?utf-8?B?TWplRW9XY3BSRDBpaVc1VjhaVDJxV3p4akdaeUxUM1FLZnd3WjNVZjEyRFpm?=
 =?utf-8?B?ZVF5WGFjOWFlS0gvTzhkdlNRaUJGZkREWWpwRmRhbXl6K3Y1NkxhRlFCWWp2?=
 =?utf-8?B?TkpCSnJqbDVtZ3pmS0hJTUZhN1BzOGJUNDlteHduM3ZydXFkMmY1cGVPa2Zi?=
 =?utf-8?B?MTNTUUxaYXBpMEFTUnBLaWVJQ1VETXRZbE1hb1NQZ2tPUmc4TTVOMTVmRVNs?=
 =?utf-8?B?V2R4eS9BWDNlSjlCSnRtcmViY0ljMlAwajJjZzNENE9aQUNKcFBMekFmQi82?=
 =?utf-8?B?MlZrUTNvQXdiQW1Qckd2ZnR1aUw4NVpYaEtPNytxc3pDQm1wWEV0dDVTVlhH?=
 =?utf-8?B?dGpidXRkVGgvMjgvdFpzLzRwVWxYUHlFUnJXdlNESHg5aVBtdFh5eisvODFj?=
 =?utf-8?B?ZEMvSk1NL0ZBeUcyajFlN1h5K2lBTnE1dnRvZVlhMHFpK2Z6bVpGMURGamFs?=
 =?utf-8?B?d3dMKy9mMnE0YTlRT3oxa3hkblRCRFlIaEFSODlKSCtkemx5ZzhCYU5TQ05D?=
 =?utf-8?B?a2tSSlY3OXY5Y3VrclRtb2RCWmRqUWd5amJKbnhYUHN4Ykg2QTlIL25SZUkx?=
 =?utf-8?B?VDRHeU1OMTcyaHc1V1VDbFFQQVVpaU9oTTB2ZS9PbFB3SjMrWFpGUElhN0Rn?=
 =?utf-8?B?dkVqLy9GS0YwY3VvdHlVQitOV0RZUmR5Qi9TSHNzRThSQkd1UTRzZ2Q5VDNv?=
 =?utf-8?B?QVJzeStGR3RrUHpZZzUrWDF5bk5xSExGYTMra0svVUtPV1k0UEY1VWkyQ1Fm?=
 =?utf-8?B?cTl1cGE3V093dWd1dEw4OStENHg4dnEyUkd3dFZRZWNUb2tWQTQ0N2syb3Js?=
 =?utf-8?B?OVE2dFhpVkplVUZzc3NzRDNIdnduc2JFbTI5UDdBODVIWGRNUU5qQ3hhempR?=
 =?utf-8?B?TEZpdWl2b2dlZ3ZGYWRzL2VlMjY3NjgyY2RyR05LSFJMKzBMSmEwbnFzRm1G?=
 =?utf-8?B?ZjdkNWEzZFZIam9qZXRaZjZnREplMEtWcWlyc3U4dFlyMWJiM1VSUHRxZlFX?=
 =?utf-8?B?WS9pQWdiaXFiY2xCRkJJd25tdHdCZVlVSTlyY1l0NzZIMTlBYlduTGZmUTYy?=
 =?utf-8?B?S0l5akNVbFdSamZ4emdTVE0ycHY5cWVtKzdNQkl6SU5VeWJLSStXeFAyeTh4?=
 =?utf-8?B?aFhJYzZmcEpEMFQzUmNzSk12QkwxckRBSGFzMW5UZDM1OFloTU9tVVBJQU1p?=
 =?utf-8?B?d2xPMk54b2JsK0tzOEszdGNNTXdJWCtLZUl3cFR0TTFWTE10d1grS1hPRTRr?=
 =?utf-8?B?Ni9VMTRMajltOGtTa2Q3MkF3Z2VrMVZKUjByYWZPa1JKMXIvNGNjZTlOeGlS?=
 =?utf-8?Q?GFL8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63d9c4f-2308-4ef1-b3de-08de01ffa912
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 22:04:29.9843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8YzIErp+OB+G8afgx8s+HlVdiY1KOUDsKCk91juXJYTkStoC4Hlf6aQodm98BJi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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


On 10/2/2025 12:43 PM, Philip Yang wrote:
> svm_range_unmap_from_gpus uses page aligned start, end address, the end
> address is inclusive.
>
> Fixes: 38c55f6719f7 ("drm/amdkfd: Handle lack of READ permissions in SVM mapping")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index e8a15751c125..742c28833650 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1723,8 +1723,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   				svm_range_lock(prange);
>   				if (vma->vm_flags & VM_WRITE)
>   					pr_debug("VM_WRITE without VM_READ is not supported");
> -				s = max(start, prange->start);
> -				e = min(end, prange->last);
> +				s = max(start >> PAGE_SHIFT, prange->start);
> +				e = min((end - 1) >> PAGE_SHIFT, prange->last);

I think the problem is more than that. Here "end" is the last place for 
prange gpu mapping and the handling here is for a vma. Should use end of 
the vma range to get "e".

Regards

Xiaogang

>   				if (e >= s)
>   					r = svm_range_unmap_from_gpus(prange, s, e,
>   						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
