Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1483D3ABEF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 08:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923DF10E3B8;
	Mon,  8 Dec 2025 08:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oIX/yP3f";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5E810E3B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 08:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdB5ji7HHH4QWb6q3MsE9TrF6jT61AzJtEyczs9GYhu3OwiaNwnfQUQwEgEANMcDipoibFcq2O/hJdLrdStsm1FTrutftn8CgFKudGXJriFNZ8DbRDVvBCzURxB1lehnW147JD7obN9X/qFdtzK5n+2RMdeInmmcxu0G312o9xAsJlc8/krgDuEubCscVTUWXoodcQpMxuiKueRQIbNCb+BXZJlNOk5FKB5s0QLCdiSMHWV/FVJQJuOs0PRpOJxf74a1a92CHNtvWARbnLerOCi7Du2/BmH4R6KTvbfjnH07lo87VLfa0C5nAg4HOIdDMsbGYC/540bkXkKdvSKvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUrguJcsSwxBi7ZFzd/34GCUewfHABrESJpiy5cnCfo=;
 b=eboAcY8QX/zZfK6XwMDDRODe+exP6s7oZwudzAaJJvwgvsjNQQG8CAnqxyvWddleKb8UnDvb3lHqpnLO5lo+nnVMjv97PYKGz+X2wuSwSYwvCV0oUAp/OqWPrJyDmEqXByVlde9sCO7HVIn8FUuuZedfYZGzz5ZLj693g+MpJE0p9eVW73ysdcSa5Zuu/xtNKQ/j9VQ0mVbY/VjY+QJLGtmEA9N7bV0+hF2mAqw/DN/MnKSMOPxeWESFT3xhOPmkybQMNeCXp9/lG7KEHc2iZ5LSnbtekxNGtDSONs52wFUEAXWTRYZtVuoPDMQblr0RlBJO4Qz7XJocAkn0yGPbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUrguJcsSwxBi7ZFzd/34GCUewfHABrESJpiy5cnCfo=;
 b=oIX/yP3fuErOqZ8PtPEKF7RYBXIAjSj+NRmd56UVXG9noeO+P0IK70734uiDgfEn8wpSJC02FVEIiy86WuCpgDcRvZTkJvKsN0DI718xjT9p2MTsCsw1WSyju9/qt1aMneKGshm0V07ZccwBBZtUmZbYATvrayhvIlWzzqZTYOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 08:12:45 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 08:12:45 +0000
Message-ID: <c9cca8a0-1d18-4b24-8aea-56312750c804@amd.com>
Date: Mon, 8 Dec 2025 13:42:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/ras: Reduce stack usage in
 ras_umc_handle_bad_pages()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
References: <20251205121549.408575-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251205121549.408575-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0036.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 703de08b-1d10-4284-9fd2-08de363190fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTNCcjN3UGswdnRDVUgzb25qeU9rbHB4c2hjODVyNGJUVFJDbFUyQ0hDaFFS?=
 =?utf-8?B?MTNmcHIzQ29JUFZ5TUxzQ2JxUCtjdmtVTUdGdUdNZTFqREtKRGlHQmZianIz?=
 =?utf-8?B?SlBDdzM5ZGJmSWNWNERkR0ZhbkpkakNpcG52QzFObXd4ZmdrNDJzWnhyeGdw?=
 =?utf-8?B?U2hvaUNQSjBKUjhoNDErbDAvRFJjS2tjN1dXcnNZMVFESGg1ajRWdXVPN1d0?=
 =?utf-8?B?S1ExNkN2ektTcC9BMzVLSTBtUzRnU0xvZjlOTkk1M1luT3pSVTdydTZWRmJm?=
 =?utf-8?B?YTZiUmd1VDlUSjQ2UlhpWUFjb0ZKR3dBTjdnSHhYQWdBcTJDN1lCdVJ6a1dP?=
 =?utf-8?B?SHBZN2ZpTUtsaFh1ZXZTVFpjZEMxaHE4OXQ5SDRoUEZIWldBcFVldFBlSlJm?=
 =?utf-8?B?WDB5MkFBVk9yVEYwMWtPWjU4ZHpFR2dad08ySUgrQTZLR3NQeGJadFhyOWdm?=
 =?utf-8?B?L0hySnZHWThSdzV1Mmo5RXJoY05Nb3NZQTQzL1VOVUxvYkFKTERyQTg3NE0x?=
 =?utf-8?B?aEhmSkk4aG9ZNm5yT1hCbkx5dFVmRHUwa3VWc0NNYStrV3pGckNtQ3l4Z0xt?=
 =?utf-8?B?cXVHMDRZOU5vMHIzRm5QSmRBai9vQ1NsTS92cWZwdkJHaDBHQ3RUREcwMVlp?=
 =?utf-8?B?TDVoWUR2dGNmalNIbmFRaFhjdmlPTG5KRUlsbXNLRzNtdkRWZ0hvc0tpWVpa?=
 =?utf-8?B?Q3dLTDB6dGdNSUowVEJyOGpKdlhmK29BREhjUGdOamducTFLRXhLR1cxQVFa?=
 =?utf-8?B?R2l3bkhINHVPdmRDMFVjRUNUWEJIUEo5RlNRM3VtcTV5cUQ1WW8yRUZENE5Q?=
 =?utf-8?B?U3BaQU4vRUV5amNTanc0N2hSMzFGUFpIYTdKcDVCV3R6b3BQTGpmd3UxSVJl?=
 =?utf-8?B?WkNNamU5ZkZzTUNQZGdCREdRR3RNVXJDT1cwNXlIZEkwU25lL1FweHptdnAr?=
 =?utf-8?B?a3d6WmZZWDZnVFVYcnpjMUVwVUJBUDBiUndKOCtJVlFZWEhrOVRKL3N6MUUy?=
 =?utf-8?B?UjNJYW5VR29XTkZOa0Y4cmpkUEE0K3U0U3pBUnJqK09Wd0YvNVlja0JnZTh1?=
 =?utf-8?B?L1ZPU1puUm5jS0JsSElJK1JsZkVWUEVVT0FzM2hPS244WHlYTlkrUVEzb0dH?=
 =?utf-8?B?TTRCamExeC93dmIwQnpROUR1aGZpampQVlV4SFdYNU8yNHNVcFFCSXNhOHJS?=
 =?utf-8?B?djk0TXdXWkhFN3hpajRPNzRudzJJWkV4anFPNWVFNWsxeFN5N3dURjhnUkRr?=
 =?utf-8?B?dDV5OERyOVUvbVJJVVc1c2V5aEpVc0lTNnNUd2VZMnFCWWVlL2l4TW80Slp4?=
 =?utf-8?B?U1g2Y1o4R0V2Rk42dmpQMmtkT0JZeklmNXR5NlU4Vm84ZEwwUk5CUUJETFFa?=
 =?utf-8?B?KzBvN056c21PZ2RkSElka2tBRnJMcVlYeVBhVng3cm5JVHBmTGM1OWR4ZmF3?=
 =?utf-8?B?MWsybUsxSHlabXFybVg0V3dtQ3F1clRIMTg0VUtvY1MwL0RQZ21QU1hNTllZ?=
 =?utf-8?B?T1RJblpvUjdJSDVsTzhocy8veUQxa05FK3k2bjVMZy96VFliNnk3UzFvQkFo?=
 =?utf-8?B?WStWOXZkQzdyZ1hBUHBRalZIUWRiVnp0b0ZGLzZWTnF0dVBiUUFzcHhEMkZw?=
 =?utf-8?B?M21BOVdqOTdIaG9QL2Z4QWk3b0FvNno1MlFRaGd0cVFjMWkvZTcvK05haWty?=
 =?utf-8?B?ZW00WHcxRi84NTA2Q2FkUzgvUCtCR2J3aFRqZ1FpNndWT00wZzc5VXBzZEpK?=
 =?utf-8?B?c2ZTSXl3d2xnbVBMNkpKOUJLS2luNVdOUXZlbFFiTjU0bS94MHBIdWFwYXps?=
 =?utf-8?B?bnJQemlMQUx2Slg3c0FvSzRWNTRyOWQxVExFUlQvMlRtdlV3THR5ZGJUSzh0?=
 =?utf-8?B?ZExKRjFod3VTUjdmZWNsOFlEWmY0M1pJWjBYUjZZVklTUmhyMjVpakQwMnlh?=
 =?utf-8?Q?CqPCoN+BR99btlDg9eRxWQZaNTlnXbkB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3M3QnJjbkZTeWgwV3l1ZmhLYktQSFB4cGlPUlJYeFZsZS93NGNsWE5tY09X?=
 =?utf-8?B?VXN1UGZ4M1JvVnZKS1F4QWY1bUdOdVp4ZGc1RXE0Vk5vZldxRDFwWldqc240?=
 =?utf-8?B?YlBuSzI4aDNMOHJFL3AwdkF5Qno4ZHRjMEgzczlMOHhvNVZDeHFLbmdSK1ZC?=
 =?utf-8?B?SWkrYzRCbmFHY0JheHI4Q0pJU0FDRzl4am9CVW9yT1RHTnZ0a1R5Z3dRTHox?=
 =?utf-8?B?eHZOb0s5c3g2RHhLQmZpTFBtZnJtRitkV3NLbnN5ckNYMUs4eFVXUFFsTjZy?=
 =?utf-8?B?SFcxK21aajdKNGtZQTAzaEl1MXlLNm0zNGZJVEVtUmUxVnBvUmRqYWwvNEJR?=
 =?utf-8?B?TkcrcDBPODk3WW51UEE4MkdhRU5XbGJLbUpQMWdUTEN4UHc1NTNka2FKUnJD?=
 =?utf-8?B?dHFSQWR6TG9GZHdBeEh5RlhLSjJuNVRiaGhnTjVUQ3ZVa0dzZFNPQ3plTnBU?=
 =?utf-8?B?UVpvbFM4TVgyY0s3cE5iZ0tVSlNqVzBaa2xXVUNSS3RxS0ZGOFVXZHBIQlJY?=
 =?utf-8?B?eTV1cmk5WU1KUGVqcy9lNU9VMk0xaTN3ZEg5RnRxWVNmN2dlRTdqNmJlVUN4?=
 =?utf-8?B?NGlQcjNrMkV6RzdGY3VTWVhLU2pMeXlUN1VYVDdOcWREd1UxdnhTK09FalNw?=
 =?utf-8?B?bFRXYVBqckdDQVdVR1ZxZmNpQ3kvWXIzbUJNZDYySTFtaDZMZWpyaU10V2ox?=
 =?utf-8?B?Tlk1QjRnTmJSYWVqUjBxMjZ5Ni93K0JmSVA2Yk1HbllGaU9uamVKU05SWFVQ?=
 =?utf-8?B?a3Yza0k4MTZjNm1qN0plZzFZOW9LQWVkZFVxRTRvQ0thM2JWTWZJSG1QSk53?=
 =?utf-8?B?aFhkcjRiWk82azNCY21iS2FMeUdDeHpPb0kzSVRBTEFvayt5QWx1TWYvajB3?=
 =?utf-8?B?NXZBUU1QVk1RSHhEVE4vSUJLNjlhRnd2bHJkOXFuakY1R284QlBHelhUZ0JD?=
 =?utf-8?B?aS9qYVFtSVBGY2hBVGtxUjNTUi93clZuUkxwU2FuOTNSeVJkb2htT1lxbFRm?=
 =?utf-8?B?aTRVOTNDQTJaeE8rRU5zdWNOaHRhelUrNHJwZkJBWkRMeDVtMUJNOE5ISERz?=
 =?utf-8?B?L2dEcG1Gcnc1UityOFA0d1A1b0xXa3ZjTEsvSjE4UCtvaEpCcmh6MVV5OFc0?=
 =?utf-8?B?QVphNFltTTREbU1zbTJFemRKTXQzRUtPWjJRZk1aUHQ5U1pBUmNuU3RVOWF4?=
 =?utf-8?B?ZHhCYS9JeWxsSlhTVVdlWHRmeUowVStyNzl2OVNjZmVyMWRpMWxKUGtFb01E?=
 =?utf-8?B?bjJHL1puVU5XZ1ZadlBUejdyL3h3S1pVWU5COHU5VG12dEhpcmFlcWNVNkFp?=
 =?utf-8?B?T3VBdTR2V2JjdnhVOUkvQkdTYWcwalFBM005VHdtTFFmdjAxWlc1VHBxcGpZ?=
 =?utf-8?B?Mit3eXJJK2hFa0NrcGQ2bTNhQjkrOE1OMnlFbEpLWnBvTlRrRGgzSGs3emVa?=
 =?utf-8?B?WXEvMisrcXZ6OXVhQnpPMlZWQkhYOFVHeWU4YThCS0s0ZlEzZWZIb3M5L1NR?=
 =?utf-8?B?QWdEM0dBWTJybjhBR0FuTU85N04xaExZb3ZETk8vMWtFalpveFZBMEZ4cG5s?=
 =?utf-8?B?bkZUbkduTVJEVjAxVjVjMGd6MTBsTEU0a3hCR2ppQ3BDazMxSi93Z0xvdHhY?=
 =?utf-8?B?c2kxdkFpZlQzOEw0TlNiaW94akQ1WFQyYlZaOXFDd1BxWDAxOGt1VVlKS3c3?=
 =?utf-8?B?SzcyZWEvQXg1NGxHNjQrQVRHQ2xvdGQ1VmhqMVU4bHMzZUNuRWxNdUYwVHlV?=
 =?utf-8?B?R2lWSU5jelJGeWRvY2lpZ0V0N1l0OFl1K2hkeEgvUHVCbVF2Q1JzQXAzTmpo?=
 =?utf-8?B?YUE5Q0E3LzhGSGdxaTFWWWdMb0VXaUxra1AxQkx5MkEraXU0ZlZLQ1AxNHRP?=
 =?utf-8?B?S0FwYWhjcXdzZHBqTVdpdlRqNVp2SVFzSEFiUGpLaUVqM1ptcFZCUnh6NWxZ?=
 =?utf-8?B?dFIxTDlLYkFyQ3RuczRPT293RmpxOVhOekV4eThrOXg0cmRyOG5leG1hUDNj?=
 =?utf-8?B?R2IxQ0hGaEhsZEUwVWx1a29sSVJvdm1hUFFDQ1R1RnNwMzRoaTFoREJBaWJm?=
 =?utf-8?B?SDZYNm42RXl1S3pXMXRZVDRyQVhuaHNLZy9IQm93clFLbFJhelMzYkdEOXVT?=
 =?utf-8?Q?MXcPycCS5TReVeWJwq8IjyHwD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703de08b-1d10-4284-9fd2-08de363190fc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 08:12:45.0189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIMmJ9BlsGQyAkFNbRrlQUJ6E+FGsnUuGgehHVLYvuAM/VTRhVHbPB6NcUu7Ujyq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612
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



On 12/5/2025 5:45 PM, Srinivasan Shanmugam wrote:
> ras_umc_handle_bad_pages() function used a large local array:
>    struct eeprom_umc_record records[MAX_ECC_NUM_PER_RETIREMENT];
> 
> Move this array off the stack by allocating it with kcalloc()
> and freeing it before return.
> 
> This reduces the stack frame size of ras_umc_handle_bad_pages()
> and avoids the frame size warning.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_umc.c:498:5: warning: stack frame size (1208) exceeds limit (1024) in 'ras_umc_handle_bad_pages' [-Wframe-larger-than]
> 
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 31 ++++++++++++++++++-----
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index 4dae64c424a2..6061776b894d 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -497,27 +497,44 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
>   
>   int ras_umc_handle_bad_pages(struct ras_core_context *ras_core, void *data)
>   {
> -	struct eeprom_umc_record records[MAX_ECC_NUM_PER_RETIREMENT];
> +	struct eeprom_umc_record *records;
>   	int count, ret;
>   
> +	records = kcalloc(MAX_ECC_NUM_PER_RETIREMENT,
> +			  sizeof(*records), GFP_KERNEL);
> +	if (!records)
> +		return -ENOMEM;
> +
> +	count = ras_umc_get_new_records(ras_core, records,
> +					MAX_ECC_NUM_PER_RETIREMENT);
> +

This looks unintentional, same function called below.

>   	memset(records, 0, sizeof(records));

This is not required and can be skipped.

Thanks,
Lijo

> -	count = ras_umc_get_new_records(ras_core, records, ARRAY_SIZE(records));
> -	if (count <= 0)
> -		return -ENODATA;
> +	count = ras_umc_get_new_records(ras_core, records,
> +					MAX_ECC_NUM_PER_RETIREMENT);
> +	if (count <= 0) {
> +		ret = -ENODATA;
> +		goto out;
> +	}
>   
>   	ret = ras_umc_add_bad_pages(ras_core, records, count, false);
>   	if (ret) {
>   		RAS_DEV_ERR(ras_core->dev, "Failed to add ras bad page!\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>   	}
>   
>   	ret = ras_umc_save_bad_pages(ras_core);
>   	if (ret) {
>   		RAS_DEV_ERR(ras_core->dev, "Failed to save ras bad page\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>   	}
>   
> -	return 0;
> +	ret = 0;
> +
> +out:
> +	kfree(records);
> +	return ret;
>   }
>   
>   int ras_umc_sw_init(struct ras_core_context *ras_core)

