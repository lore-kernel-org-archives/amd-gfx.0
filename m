Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CDAF588C2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20B310E57C;
	Mon, 20 Apr 2026 12:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZK1Xuqha";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CDB10E57C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wg8/2ODJA1HV9s5SyLqmc5fQEfmnuq6hc6tvrwtNxAJGBtKSYdlAzME0RdwZx6w4NdPucq9b3UwvYm56SSWDftZxDuTcvPqgC2kHy0/Eeb6Osw2a/chyUmmbFoNOzwgCvWrQagHKb5+icp/6j2jvD31VL6Lr/lHW1exGEBi6u9OnOixWEQoG/COWS/aH7aPs4FTQfd2nd9qX1zvST12Ua/Lva/EXpvxHbbRiL70NkrgijW49WGUl97ISWAj++YNTZBuZee99N6anNL3j49ikYVVccA1OydovnmSM1nYfD3alPJnuQBMTZ8ybN+zFoFGVr0KAs8PUnka3Em4Sb7TrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Yy/du/pfYWzkDVdNOQ5Jky3ZF746UXtnobtI1Zx/sg=;
 b=Xsv3FQjMk9zE/fA+83nVLcte/S7l0ck8kfXLo1mVZ67dOrG6WTt7HdBtquFweOgArYUD5SgdvCOxNPzCw5LFFLMh8aQk2R3Di95IU7W8tfz+gCGuyrykQ9mQGrayeH/4u6clwvW7sHhip9RnjguifibJ4DC/4CCPaeoZpD4QiZp6faASpdBtNZKC2w7xWnTW3eqwZPqT0k4viIQKPZykQGui27Agc7t5XHlnty323WB5yq9i/2EVmIxf9KWB7nRe9peK4RKbVdhXpVn1A6sSYLEE3N8cap2PO6xRwY9XJlgCu+Uf3W81ET20hOUb3hkuXAQ+KQ2SVPKgLuFBQZJzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Yy/du/pfYWzkDVdNOQ5Jky3ZF746UXtnobtI1Zx/sg=;
 b=ZK1XuqhakfnM0lBgOCFAXSA0OHuHFW9p9nY2mgR3Hl9F3kAwT+fOpmmlJQA4kKr+1iToZ+aGu6RWiKuiRYWQQofUiLV7H4ex2klDh4sSG62niHubsxrKWREm41eqUKyZH46THv7O1ya2fxHZUMo/HpjQ9TOOeePGHTuOGyq2Kcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by LV9PR12MB9781.namprd12.prod.outlook.com (2603:10b6:408:2f6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 12:25:55 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 12:25:55 +0000
Message-ID: <ed1e9ce3-80bf-499b-96e2-864d29270322@amd.com>
Date: Mon, 20 Apr 2026 14:25:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/amdgpu/vce1: Don't repeat GTT MGR node allocation
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260420121044.155030-1-timur.kristof@gmail.com>
 <20260420121044.155030-7-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420121044.155030-7-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0328.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::33) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|LV9PR12MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e02f99-85a2-4038-9d7f-08de9ed7f7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: HXSg4k6/9PtfuTonAhH+EbrNU85w1a+FbJdDzXshf9RmLKJGxqu18gJFo53H+e9Almh7jSiBwhKEaWuqJ7UoIBOV8mVqCXp018sLSujkeMEquGxHQZPsD73j/Y26yyXqbJmvoSLhl3s9G7PTHKzCjv+Db252d6bB2uNQT//0p+NFQ4WuXQemwRZZG+hjDlw8WUSZZwgjwG2kxeFNHW+5LVI2avKja9YQavZgxBWm+A4r5hyka0jwc0DITU5hhDCgiHSFDtoAVfx4XVY2/BFe7PEykO2U6L0IA9v6D+ZKnnOyAXH5Rss5fOlfhB9Uc7VxLzbQAOqq1NQM1b4/RKyk9jrO/NJ1gV4nh10mfzjfZCvbMl+ulTYPtT8QHfauuKZqfsNuUtQNXgA7GH9M9JzVprxr0RAgjwBp3Iq+xCfnY24zHdWLoCCwJghh00ccbbT59YM4a60t3z9BXYTXcL4WdSo7cw7c5fp0wzvpQDVx1BUeoydk5qFZWeAfMVYOaeWO6VaysRMzvtaxdm0HJfjDcFMOhaVPcsW9NlzZ/dXrTVQ3TmzbBWAx2WsOeELzzD3bcFS8sQihYLKJZ2IQ9pbpXy8bH86am9ML/txT1+odFmyGJyiwkr3LGcus3cFN1jg5Xj9TpxVuye+ejb5Dlc9iv4bnm0TSWa1CN7cQUd2Lpzf96RTq6f3A/WYBFeZkQzn+HVo2Mjk2/FzijpWJxXl/MYEP0lGmxO7sZrcQybd2Cfk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWRtK3pIamhTUjBxY1hhNndIZW12ZFZNM2JpeTdERWtFaFMvWUlIZ09hbWpK?=
 =?utf-8?B?MkU5Z2ZVV0cyaGphdm5HVGZOeUptK1VYQnNSTUdMMjJTNDc1Vzg2eUVqbXhF?=
 =?utf-8?B?SHhEMXU4Z0oxSkNsKzVLRmJLSUF6ZUJBZFBVckJ0ZHpmNHpZWS9QbklsbFd2?=
 =?utf-8?B?QnFYdEJEYlE5R2hJUzFRaEEvdFB2NjFXdE1EdEJvY0ZibFBITFZLYzczSWRI?=
 =?utf-8?B?cHBhR1dLWTRmTFJ1VDI5cVlNYml4OENHTTExZ3VqeFl5Z1dQZkgwR3BPUXdR?=
 =?utf-8?B?ejBYbmhQaDJFbXVlK3BBbnRDa1BJYm5GZHF5QU9ETUN4cGNSMVVCUlg5Nm11?=
 =?utf-8?B?N1cyYU9yZWFjbXVwQWhQcTNrSkFDbmlKaVlnZjRUV2xzRnhwNUNEeThuVXgy?=
 =?utf-8?B?L0ExdFc3UDJpMnc4OFFzMWlpRWFDL3FCV3ErbS9LSXh0ZFpibDlIa3M5OWhp?=
 =?utf-8?B?RllueEJJRnNXWXNOMWdMUm1KWUtRQzAxMDg5bzFVZ1BiS2d0UGRFcVJvL2Vr?=
 =?utf-8?B?Y21ZU3VTQzd5MVJuZVhSVTJCRTlvbGpIN1VENjFTYUsrb3JMYTBGVGJtdGhS?=
 =?utf-8?B?NmhLT0lSSzU0eVZmSnprQ0RML1p2MDNqWGZEUnozM3ZPOUtWVmhQS25ZcnNO?=
 =?utf-8?B?ZG1aUG9JZE5tVUlid3JmbC9sRit0dlFuWitGang4Ykhza0JicGVIT0J1eTZM?=
 =?utf-8?B?OEVaMkRIWHFNekoydEdDSE9TeVhEV0h0OXM0Z1NVZTAzLy9XbGNDdUdMTEhS?=
 =?utf-8?B?cXRQU1hRRFlaaUtwTzh0QjZuRGhOUXZXcUZ1dXBPcmF6VE01Y0g4M3QzUnA2?=
 =?utf-8?B?TDExZGRpYno3WUhxOUhuT3dKVytUVlFVQ1pYR0psMXNyY2NQKzBxSkJyekpk?=
 =?utf-8?B?dE1ZeFAvSWNSckpoalVaV2J0K0J5RldTckZzalpsc2tKRitzdkMwdGluR2l4?=
 =?utf-8?B?SkI2eHdQMjg1WlowdnhEbzltNDNwV3dlL09TalRzMFJtektxcVU0dHRsYVI4?=
 =?utf-8?B?SGQ5MEtHQTJwL0t3T0pSUFJUdHV5OS9FMlRzcjRXODR6dit5bDhiL3BXeUkw?=
 =?utf-8?B?ZGhnb29idm5rQ0tVY2ZBRkYxWEFuNjdXQ0NxMm9xS1ZkaEZvQTF6SWdnSFpF?=
 =?utf-8?B?N1Q5cVh3RVdaODYxcTFyV2x2azF5RmtLT3h1UE9QTUdWTHRuSjQ3a21wVUhN?=
 =?utf-8?B?dnRJcFR1OC95T2FydWNyYVhCNTkxVmNrU2pqaHpGeU5PSW5vZHZ0UFY1UkUx?=
 =?utf-8?B?Yis1REhuaXF3UXZqKytyNTlTNjlFVzBVK0JyanhTNSt6RnpmbzAxNDVsVy9B?=
 =?utf-8?B?VWFQNUluc0pHNVc0Vm1jTnBMcWM3YjZPazBVakdGRlFxcHJ1aDIzQk00cDRJ?=
 =?utf-8?B?TURDaEdwcUZBNUZoZXVCeWU3cFdqNyszZU0wRzJ5Unp0ano5S0xoT1I3djcx?=
 =?utf-8?B?Qm1URi9nY0NhN2VZa01jWkZ2ZzQyYng4c0FLOUs0RktxdUdSY3FYcllBc09Z?=
 =?utf-8?B?TTBiWERMUEpFNjdhLzJEM0xMZnFwZmc5azVmdnZIM3JEN1BvWlBBMUFJQm9h?=
 =?utf-8?B?ajM2K2hid3owRWRHMTl2elo3TlE5YWhGaDJadlRSZmpyMzB2SUlEbDNKN2pP?=
 =?utf-8?B?RmdDejJJMWtIUjNqQ2NRUHkxNS9jRWZKRDZPcEM4blpBcjAzaGlNNWF5K0h3?=
 =?utf-8?B?T055VG9nY2ZDT3R1TS9QUzlsRVppYlBBVzhtSU9ZdjB4c2daYSthQ0ozN1pl?=
 =?utf-8?B?bVF2ZkJvRS9SZ3VXZVNNdzI3UFlBWGM2aGRycStMMnRVQXErYzVGU054SDN1?=
 =?utf-8?B?eGdmRXdmSG1iMlBaZjVNU25aQzNhaHhTMkxQcVVkMmZPK3FCKzI2MFRkbyts?=
 =?utf-8?B?Q3pGSk1FK1Q0SXZtZXYzSUM2NzdjdFFRM0gyLzhMckdkWGI3L01qeUJ0VUVt?=
 =?utf-8?B?M3FoTC9Genc4ZkE2dm5zSHZZaHJlcmw0VHNJRW9wNkJiR21jR0NyTFJPLy9O?=
 =?utf-8?B?V05CK25KajgvRWlzZFkxaUJvWDlCeHJ5NFFubGJvZVc0TWhCd28xVjBMQ3Vu?=
 =?utf-8?B?elg2VHlDRlF4aDBsaFZKYnhLaXpDRlZNcnBYWGVFTFpoWlJPSVFmYXdUYmg0?=
 =?utf-8?B?REEwejlTeFNLRnQ5L3hKcE9XVkNFSWRCMmhWREpqTFM0NVhOVU1LdUltTjNi?=
 =?utf-8?B?SmVObDVVTmZ1dWYxRmVoVlBVS0lkWmNiRzY2SFJYcXQzZTBwMXBjT1hnY0tC?=
 =?utf-8?B?VldYS0swR3hLS0xEam96c3M5c2FCNVNXbDVZMjZJalJuK3B3L1lYZ3VSa1Vl?=
 =?utf-8?Q?dgCVwicYNlLxxUZgUo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e02f99-85a2-4038-9d7f-08de9ed7f7f4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:25:55.0488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MU6TKt0bHWQAsCn17+Owe2XrZ75YyN/beYnKgU/jhub7u0ZskW6OJ/DiGVwsXAmg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9781
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

On 4/20/26 14:10, Timur Kristóf wrote:
> Only allocate entries from the GTT manager when the
> VCE GTT node is not allocated yet. This prevents the
> possibility of allocating them multiple times, which
> causes issues during GPU reset and suspend/resume.
> 
> Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index b7b6096c1a1fd..100aa48204c77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -541,11 +541,13 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
>  	if (adev->gmc.vram_start < adev->gmc.gart_start)
>  		return amdgpu_bo_gpu_offset(adev->vce.vcpu_bo) <= max_vcpu_bo_addr ? 0 : -EINVAL;
>  
> -	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
> -					 &adev->vce.gart_node, num_pages, 0,
> -					 DRM_MM_INSERT_LOW);
> -	if (r)
> -		return r;
> +	if (!drm_mm_node_allocated(&adev->vce.gart_node)) {
> +		r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
> +						 &adev->vce.gart_node, num_pages, 0,
> +						 DRM_MM_INSERT_LOW);
> +		if (r)
> +			return r;
> +	}
>  
>  	vce_gart_start_offs = amdgpu_gtt_node_to_byte_offset(&adev->vce.gart_node);
>  

