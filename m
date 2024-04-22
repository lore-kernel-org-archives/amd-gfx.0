Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A57C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 11:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 883AB1129CE;
	Mon, 22 Apr 2024 11:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wpAqXwSc";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B617F1129CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 11:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8vn4WvXSMssmBzztR4WkEQE3ujy+7Q0GilHctJX2NSShke7Xkj330kWz/3SzKq4/SV746TMLSGl0VL91AEpYEHeVxaD7eAp3+KxIr5uSZT8zDtv6i0Ni5JVeWWjA517nvF/ChwaGeJzRUEDIvUkFUhKDz0ac8ip2TLYRfW5zw+mvbEp4K3291Md3xg/2rIq8fxbdYTHU7anR5Cg8P366j+8QWtk36dB+xTZUqqKzYl3xaVunk94k/G/ClIQECvvmS+r4un5TUookPHPVno3wXyXFBC3wJ0+1MBUBVh036oj8U3Rw9tfqw1BN6/EIFspcjYctAltenK7ZZJvzoygvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSVbOHNcadXhHEIzBdgE/6O0U2DYprmqEHl/Yc8Ze4o=;
 b=Hr8sX1qyRMAX216tGofKqNHPxfebasvxEETZuUXb6isUxwxul8wzqYRw6tdquEDlIokjgLglAnruQo/Cls2vZvO3oBxkBIMCarGUyR2ADPMf8zxxsCNDIikALnVEwt5z4E6blaEjq8P0FrLRTYp6wjxk7ayGgb1TZh/RJvhYmarNx/6GSqiYsViGRT0MJ40drPILerIzlXjyquG5ykYoNjPX/5z9OzbVJB+x0GJxhI7zSKOpG4WbxUXMVsMG7GYMB1vFFtZWzT1kGSSNj2Yw3VyZUam4qqoBvxguKIODqLfPjPCXJlGr/ZUb51PoSrwQZ0HwoaVRljek8Vgxw78G1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSVbOHNcadXhHEIzBdgE/6O0U2DYprmqEHl/Yc8Ze4o=;
 b=wpAqXwScVoyzCAHIgVlnjSs8s0UpJ8y/PcwvD3SRfAhDDOppQUGFXxBbozRITEsT7v4W7p51Tl9YL0B/Z/m/Ozfh2Y7ViCAtgWoek7yZCjiRH5qwfpnTzPECoPPCkiBqTJmYrvZ+XHV4h8JGajFqMB+OYJ3U766EJz+4qA4uKqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 11:12:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 11:12:14 +0000
Message-ID: <198a359c-f9c2-4651-8367-36f5d4a51494@amd.com>
Date: Mon, 22 Apr 2024 16:42:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/mes: fix use-after-free issue
To: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com, Christian.Koenig@amd.com
References: <20240422093931.3823889-1-Jack.Xiao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240422093931.3823889-1-Jack.Xiao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 4372ffb4-2abd-4846-d507-08dc62bd0ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1A5eUVDd3EwQzJzL0F0ZUpDTmVJd1dyZFdEN0hQeVhpeldCUytPMW9rdVZT?=
 =?utf-8?B?L3BER2JodnhhWjgrOEc4UzA0LzJRU1pSaEdORlJFemRBSVZ4TFpJejl5RHJW?=
 =?utf-8?B?VHozeDVxTjgrbjN3dWxFYnNBRU4wS2c1Y0pNOVIvT3JVaWozVlFDTEY4anli?=
 =?utf-8?B?VVovQ3d2VVRSem92UERQQk9BWngxaXlKR1Mreno0b3JXQS9QYTNVMEdhOVli?=
 =?utf-8?B?bzMwWlE1RlZIL0VjVXhvZHYvNlVFYUJhOVc4d1dZRWlJNmlPVndDcDZuUENy?=
 =?utf-8?B?eWp0ZG9NMmtFdWhmWVpDc3E0TUtSL1lURDVIa0ZRSFRxMFdFdG94Sm9yQURV?=
 =?utf-8?B?eHEwUEhyUEIxWmdwUDI5dVMxRHAxS1pQMUtWajBJc2dRSmJ0S0tqSkxodUNq?=
 =?utf-8?B?TTJjdUVncDBMejR2RUFlVi9lclRheWFpN1U4Y2FSQnpoajZFTnIvSDV4Tnd1?=
 =?utf-8?B?L0dZa0F5QlBLMHJaakg4QkMwUXNYNUc4Y08zQklJVzU0RkpWeHpqbTNud3U4?=
 =?utf-8?B?UVJ6OWYva0RBc0VzMEMwaU9iNmdoOHFwakhFeDRoM2t2TlZFb2lmZktpL3ox?=
 =?utf-8?B?U3R6Y1dYbVRFY0ptL2wxZ240aSt6cUw1UGIwSThMYVh1Q0ZUbFR4SGVRVjVG?=
 =?utf-8?B?RUlSYkpkOWdRSyt2VWlzeU1zK2MwQncrWUhoUkFTRUdGQ1FDZFZEc2Q1empj?=
 =?utf-8?B?bmFuaTdzVE1vR3orK0ZnKzRZYUFVT2VjcXB2NUwzWWM0cDNWTm1aUi9jQlpE?=
 =?utf-8?B?dkZXWFczOGpUaGU4UWJQcGI5N08xc3cvWHk4MmZDRll1aXMxc3JwMlpMSFFK?=
 =?utf-8?B?clBCd29QcVlqcElESlRJekNLUklFL0Z3YWpMWERvdSsyekVoU2FYRGQ0T3Nn?=
 =?utf-8?B?d3g4S3V1UUJjV1FYQlAxMy9KclgrSDRZb2hLdUc1Z1VZVkxXR1VvMmlwKzdv?=
 =?utf-8?B?OGNVK083WXZ3eDc5cUdzRG1SN3RWc2QyUjh3NWx0akwvTkJ1SG50eEhMY1Bx?=
 =?utf-8?B?b1V3RUM3bXUxcE1weG1LdThpZ3NlNFpVcnFIQVlPdWhJRHZPc0prS2xjOEpi?=
 =?utf-8?B?UWtHeXNTQzMxY1Qwd3VRdnhlUFBzQVdHUnN6cVZSdkdNb3g1UnRjM0VtTXdH?=
 =?utf-8?B?Rkd2bFB6NHBoa2xWZVpoV0pEQlo0elVEbEJHYkZtbXBmVVo4UmR2ZmdvdGs0?=
 =?utf-8?B?dUY1cnFjN2NNREQrS2RyWnhHMEVjRng3blNFaHV6YXdMOHdEWGIrZ09vUGpG?=
 =?utf-8?B?ZUtLU1JJWVpJeGY4akJYRGxlaW55M3hwVG5sMlM3eFkzQlFJczlCQzg4N3RT?=
 =?utf-8?B?b0NoSWJuYks3eDZHREE4cmtUUm5vRHZJRVNXUTVLcmtDTHlmNUxCN3M0WEZt?=
 =?utf-8?B?VU00NWtZa2tqc21mVnV4aXhuVVp3VXR6VURFdkJ1RTVrT0laZnRXd3dINzFv?=
 =?utf-8?B?SHlmckQvaTFFLzZDUUt6RU5UdU5Tdm9WampnTkU0cUlUeDhXYTJSWW1CbTAz?=
 =?utf-8?B?bEdKVGc3VVJLaHdWOHpsSlNISytBU3BmNkZtbDZybkIvcmd6cDBQakVzNFRs?=
 =?utf-8?B?c3RxdHdIVVoydjY1Qk5VWHlseWFKYnhEeWdFNUZOZmRlOEVKMlJhR0RES2RL?=
 =?utf-8?B?NEVuckV5eFFoNm1Qc1BxTGk0RnN4WDZwaUdEQmtnU3YvZVlJc29MbG9zQzB0?=
 =?utf-8?B?ejNMck5CVTFLai9sVHBKZlZXRVIzU2hOQVJReVZrb1oxcmJYc2lpN0d3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUxmbisyWWptWGpHdjNKYWxMeGVtSVlPKzdRb0lhWmZjOWdTQld6TzZ0cUsz?=
 =?utf-8?B?WFplR21vNkJHdm5tQXpEQ1BrY1NBNDd1L2dMTkgxODlHYzNPR1pyRTdvdGMv?=
 =?utf-8?B?b1UvM2RJWVFsZzJvZ3poQjRVREJmR2NnOHdNT09tNHg5b3FVbmFVOVJQVnlx?=
 =?utf-8?B?dXNWZkJoMUQwUjNzbWlBNXV2WXdWRXY4OVNvTm1DTWZqL2V5VG03NnQzanBR?=
 =?utf-8?B?c0lvckVMU0oxbTVzVkVjbkJHY2VOd0pFVVRPek8yRVNJNmQzWnlraEtqRnVk?=
 =?utf-8?B?bTNUaHZQbnhRTXBnM2pjMEtOemNtYk5FS3NSZkIrVUdQeUhWMlIrQ09xQjZh?=
 =?utf-8?B?OWY0bFN0UnEraHdKcjQ5QzVKaXdXMGR6WlB6SjFHdDJRYWRzZjZDVXpEVDVX?=
 =?utf-8?B?ZDdCalBLajRORDRKM2psM1hqa1o5U3F4RkxEbHloWXVsRUxQeDNxWERCdDVV?=
 =?utf-8?B?OWZkSWV2ZkZGTXRGS2ErUjVLSkxwdDVPazdJcE9HSjRPSjlNZnhxeWpiZlhP?=
 =?utf-8?B?b2RwUVNoMUl3QnJmbm9JYU5Lc2Jld2dnMEdVU1BxRndua001Y3gyak9hQ1hV?=
 =?utf-8?B?STdBekIxcFVnd2VBM29vV3FBOFRxWCtENy9ycExmcWF4TzlTN2c0UktQdm8y?=
 =?utf-8?B?Vzc2S2EvNWRpSWdyKzBQc3M3MWEveFVSM0piR2RyTDVIS0N5amUzQXU2dVBP?=
 =?utf-8?B?eDcyTWRQdlh4RkovSlJtTVExSVF2NGtQajJ2NVhpZGs0RS9yU2VLZmQyQzFn?=
 =?utf-8?B?ZDhmM3lzbU1NbFp1VEhiMlRDR0xybXM2djRSL1RHTnJPWkEwVFd6Q3hady9E?=
 =?utf-8?B?bnRhZkhYSzFRb2ZjQmhoNXVacGNHQW5TSXNkb1ZYdWpnQzZHbDcvNWpmbFVH?=
 =?utf-8?B?RktJN0cwVDZNVml5eTdxVWJlRnhWMUtrWTlOREZFeUo3WUJWSXVubEhJcXhv?=
 =?utf-8?B?dnExNk1zY1FQcFZFeTltT3BoQnVEbVdaQVN0UEp2MFp4SnM4UXZMVlhwTTVU?=
 =?utf-8?B?cWVwQ2lLc2dVQTJlRmRXUldJbTFNRWU4RHZ6ZVNQVGg0NGJ6cDM0K1NWZkpX?=
 =?utf-8?B?RmRkNlpxeldST2FaWkJOL1c4YVVpdFdPUDR6WWQ1QzJycGZNaXJKTGFPdmtU?=
 =?utf-8?B?RDFhTkdTZjNZYmdySkNCL2lSVnlONTBSa2xqSnhlc2k3MEZFSU1rbGRyaUZZ?=
 =?utf-8?B?NjZ2ZDluaFFWRjEyS01iVkJUcjhHTU9nTER5TUc4TGNxdGJOaFV0Y085YkR6?=
 =?utf-8?B?cFErdlN1R0xQQlo5b3NrZTc0ZFY3THVSUmNXVnprYndEaFBUYWlTR2FEWEN3?=
 =?utf-8?B?V2IyVTFVQlVDMHB3Q2ZxWE5jSUJCbWM1bWJNdTVCR0phOHFIWDZlRERIVjkr?=
 =?utf-8?B?QTlBV0tLcWowWEdHQWJyaG9SWVZadUQ0ZHRXMmVMM1AvOHkxaFRLQVNCckht?=
 =?utf-8?B?UFJCRmpsdWtFbmhEZ25jdVNLQWJsaENzdDBvYVZVOEg1V2E5MzZzUUhtWEhr?=
 =?utf-8?B?bUxBclVyeXBDZUEzL1dTbXpWeFRKdzdva3NkM21nMFJZc0RDem1CU0xCaWQ3?=
 =?utf-8?B?a25oVHBpand5ZFlnU2h3S0tHcW1vRUhka3dMdGs0YitwaThoZjd6Zk1BMm53?=
 =?utf-8?B?cGZjK0o1OVE3amhxdFFMakNsMDdIRmRvc1RPTUtnL2dURFQwK25rT3BFajVq?=
 =?utf-8?B?NWZLWjc3emkvd3hIaTE3cUh5OHh3RFFpamwyKzY0SzJhY0kxMjFmaE1IUHVu?=
 =?utf-8?B?WFZvSEV1MmxnREpTVlkzR0dydFB6OWtqeldtNzN2SVhqVE95ZHNKUXJCM1gz?=
 =?utf-8?B?bm16YkIwL2dnSVdOQmoxZmNxdkdqYVFWR0w2WjhzNW1GUXpqemx1K25LVkE0?=
 =?utf-8?B?REU5UnBFcU9ldFh2MkdGeUhydC9qd0JBeG4yNVYwZnFWNDI2YU00bVNha1hD?=
 =?utf-8?B?WWthS05WYnYwYXRzbEF5aElNZHljU29yNXJubVE5WHdKWFBRUy9KNTk4QTZB?=
 =?utf-8?B?QlZpNXF0elRudHhQMWJXMG5FVEZQMEcxZUNQM090eGd4Ry9rekptM3M4YlI4?=
 =?utf-8?B?MldHVHByY1dYdHhSMnR1eUZXWWZFNEU2MXBlTThnT3JiUEJSN3FDUjB4ZWxF?=
 =?utf-8?Q?J5Cgz5xNF5HrqMl91xOMlWWWP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4372ffb4-2abd-4846-d507-08dc62bd0ffd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 11:12:14.0310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHzwC+J28FPLtpi7+bZjl12eF6LxJ+5hbom1j//8ySSObtRfcHJLvlTwS2UhGrFn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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



On 4/22/2024 3:09 PM, Jack Xiao wrote:
> Delete fence fallback timer to fix the ramdom
> use-after-free issue.
> 
> v2: move to amdgpu_mes.c
> 
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 78e4f88f5134..226751ea084b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1128,6 +1128,7 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
>  		return;
>  
>  	amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
> +	del_timer_sync(&ring->fence_drv.fallback_timer);
>  	amdgpu_ring_fini(ring);
>  	kfree(ring);
>  }
