Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3A0E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 16:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 021FD10E013;
	Tue, 10 Dec 2024 16:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ULHtmtHM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75BAF10E013
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 16:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag02+I3ddCNUalsEhPUth8j0h7rtp6uxlHwVYKzbHbkxvgTucvkeZ897tBSwHTtbfv5rjHnlHvdPX9VeBaeM+5MLqWy4TQo5eFOsuiM82poVsOBJHIg6zXoQ2oXhCZFmh5+maNvX6J2X9OxoIJNi7K9IVFNWakItWAR8tmN1YxqtCOGNo3vZw5IM0vZvfhib1l5Ibrmem77S+tIS3LGLDCz3c3xPMPm55pN3K75pmI10IfqxWGDK5aVEx+9rhPypM0DJbFSoKG2duEr0HFwvU9wtk0ZfuvHG6y+kQg2xCGbAiJmjwBbftmaroARjwa6x5JGVTuBN5b4cGoIR6nAZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rc4I6FZSmOu2JgG8UyXibaU2yW95aLkJ2JopsU6C3R4=;
 b=Mj2DINzOlqv5d5xNmEiXAV0O3TWgWPZc5feIfh0vAOwtNugY8KZ3EyNxvIQgB2VRqecG336R/GIsbEWSxacm/defP9dAstLY/OiMbF7GUbBZepDic/a/viLWJPCvXLptxQMYaCNx24V472LIemydQItCb1dz3ZUN4n2K/Q+j3fZVLmXVtuI5sXvr8oVGiiGB/X3IOS4At7h2Q5zF/Gg63PfuMw7aaOMa6lWnvnteUBCwsfb96EgRLEedI2lheSrhHnwYOwHl8dSfQzxtprSmbDg9XvvF7xlZjOCv3zOOAYMp5CqBKGP5dPE9pa+VQD/1f5XfqKvwGQpwgGUaw5Ujxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc4I6FZSmOu2JgG8UyXibaU2yW95aLkJ2JopsU6C3R4=;
 b=ULHtmtHM03/ffMSEwE/Kba47UBjGeUfKKaDj0DNz7GWAs4mhRGQuzLbUNqHQlBIC8l3sWI1vYR9/TkpByAaj0LGt823GIB9mJfJ1OSaWSzg0GTpzIRO6NnTq2mCvkyGEt+jhm/PCkmbyl4pYvLZrzuCaZlnxG5NdYYbkcBX/nuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.25; Tue, 10 Dec
 2024 16:48:36 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%7]) with mapi id 15.20.8207.010; Tue, 10 Dec 2024
 16:48:35 +0000
Content-Type: multipart/alternative;
 boundary="------------GWVWu0qxzIyKlmfn6g25kdDE"
Message-ID: <e42e2520-2bf6-4e1c-b491-249879326732@amd.com>
Date: Tue, 10 Dec 2024 11:48:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu/sdma7: Add queue reset sysfs for sdmav7
To: amd-gfx@lists.freedesktop.org
References: <20241210035318.2159002-1-jesse.zhang@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20241210035318.2159002-1-jesse.zhang@amd.com>
X-ClientProxiedBy: YQ1P288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::29) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ecff67-94a0-4534-8ba1-08dd193a7d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0VyeTlwV0Q0bkZ0cUpBMG0zd05MSWNoU2NhZ3FxWm1VZEo4Wmo0YWdkWjhD?=
 =?utf-8?B?L0R3R3BvT2JjdnQ2OUZaOHdRVWw3K3gwb1BKN1N5cEVNbHIrckpBbThNNUZ4?=
 =?utf-8?B?ZkpQMTE0RVU2ZDdqSnVoeWU1Zk1lZnlUZXA0QVJzZ1Vjc0dYOHlFYW5wWWk3?=
 =?utf-8?B?anRZUUQwbG1xSi83bWdjVVcrZjd0bHhia3IrTzdxWTZzSzZaODdEbmt0UDRD?=
 =?utf-8?B?bnI3MDVKQlNqWkQvOUk1WFBZWTdON0VjRWZEUEZHOTlNb2ZoRHJHWDNsZ0tj?=
 =?utf-8?B?RENLaU9MNnpxNXNyb0RSL3BFVy94SnhaQnVWclE5RGhlRUJvVlE1aUxsUHh6?=
 =?utf-8?B?cUl1Z0RwaVE4WTQ3QnF2cFhFQStrOEhRYjhpWU11SkNVYzhScmdJSCttV2s2?=
 =?utf-8?B?WVgrb3V0QWEyWHpNdHFyZjRGaHFqZGRWRVhjVkJpelJ5eFR0aS9YSmdmQWto?=
 =?utf-8?B?MlJCWjBJQUJmM00zYlc5YlBFSVdHYmxuMzZPSmZFdXlTVGZ2RE1WMERVU01K?=
 =?utf-8?B?UFlPY3BLZGd4b3psN0lWbzVYNkJ5VGpKUVZrMnM5bHpCdE94SHB1MGNLeHZQ?=
 =?utf-8?B?a1FSWUduRFZWSEhWdzhkeEZWVW5xVTNGcnYvU2ZsVXJkL09Telc2TEgvU3Fa?=
 =?utf-8?B?N0JkdVI4WFoxWTA5bGl5WEpYV3ZmWk02cXN0bndkLzBlV1VPUkltM0ZkSFVV?=
 =?utf-8?B?RWNhTXZ6eTRuUy9XbXBEVzNoejQwSitJR2dIQTdHY3JxQkE5alZuVXhuRk5V?=
 =?utf-8?B?b05hVkVuYmxKKzVsNldmNC9RSWI0RmpHcnFWWUhXSUM5aHBDNUtXQlFIeHN1?=
 =?utf-8?B?WGJ2UVJhQjkzT29OR3BTVFRLWlRubjdZMGFRSkpUa1Y2aFlyQTNSVzVWLzhD?=
 =?utf-8?B?NWxYS2JhRmMvZmU0N0p4cVZjSDVyVS9mUlRsNWJCeW9lRlNsSzNxbFI0MXVi?=
 =?utf-8?B?NGF2WXNyMEJ3ay81T0puL0JWRUthYlRZUitUMldXanE3OTM0dUxKd1g4MU9a?=
 =?utf-8?B?OEtuYUlzTWF0a2VPUlU3akVCVXc4QnR3ZHpSUzRhdDE0L3FsbEF0SlhtSDlJ?=
 =?utf-8?B?b1hPR1lVWmhOaDVDdFM5OGNzRDNLYjluQ1ZkTXo4VzY2TTBUNGxvanFXSEJm?=
 =?utf-8?B?bFRUWDl3ZkFlL3M3b3M1WVFGL3FMbXkzWVhWZWlLS21qaVNsRVBuVVVRU3Ax?=
 =?utf-8?B?UkRNbkVrU0JZbkZPK2ZWeGx1Ny9salhINlhWWVQwcldxWjZFZzg5MnFSc3VR?=
 =?utf-8?B?Z0cxd2VsRXpYcXlZYkZUdGNBcEVBQnJOVzNIRkVpNkxQV2JkcmRvOUN5U3Ns?=
 =?utf-8?B?YzNiVzQxdjVmcWwrUldsajhTSzNmQVlqc25lcmlrV2FMTEUyYTNaZkRlRXNy?=
 =?utf-8?B?L2p3MXlvVmFwVEI1RHB2YlEzdkdPVzhqZGUyYmtaMElQeTBzM1JWTWNCNDZC?=
 =?utf-8?B?dXFmT3BQUnhUeWZESmUxWXlkS3IvcnZRd2NRMVVHK2NSZ05QaDFoZERZL25j?=
 =?utf-8?B?RFpzRVV1VG1tSmlpNVpvWXVKNFgzbHZlcHpKVXZTODhpOUZwOE9od2JuR2FZ?=
 =?utf-8?B?U2xaWHkyRW5KTEFCUXBOekNDY20xNVZiMjlKK0gxN3ZsZTFxZ2s4bFBxUDZ0?=
 =?utf-8?B?cXkrT0xHeE81Vm9HY1ZqOWxneS9jSGtLTDA0dGMwYXBjdkVnVWxnVnVRUmJt?=
 =?utf-8?B?aStKa3VNRGZtTk1Td2FWY09jdnVyZmNxQU5PUE9QeXdmbThHYm8zOXdlS05Z?=
 =?utf-8?B?Vjdib0xPYlBVaUYyeFFTUnBrZklENXpMUWp5dzgyWEpqZnFBM0tEcWxYL1c3?=
 =?utf-8?B?bVpuUDdCaHlDOFZuR2RaQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckgxa3crQk5PZWpKbVZZNkw3Z0FDZE4rbktYbmVrZnRLUmVqYnhveVVUUTdQ?=
 =?utf-8?B?VGgxeXcyTCt2cHI0cDJ5c2pDcXFqTzNVcEZQbmRrTTczQUFuRmVnRmZjU1k0?=
 =?utf-8?B?cXdzOEVPNjFOOVovSWRkRVVkaStsWHFxYXJmY25qMWNySnB4cmJXZzE4WXBi?=
 =?utf-8?B?NDE2OHlTRkZLeEo5TWhwU2d4TXpQSkc2Qnpubk9YMkZWR0NlajRXZ3BUdFBa?=
 =?utf-8?B?RmxQanpCRGxlNDRZQlJtMEtlQ09TWlZ3VVBERnJWc0dTVTFtcVRqWkpzRlVO?=
 =?utf-8?B?SjBVNHpUdE5VTk5MTUdQNnB6QnZlcUcvV0oxTW9lSXVGTCt4dHAyaFhnUTMw?=
 =?utf-8?B?WGFZY3JoQ3MySVFHZ21HRVMrMXBJYzBiclN6K1VZcnlienJpcTViWlBSWGZI?=
 =?utf-8?B?SFgwWGpZYjJoNGprUnNUdlJiamE5ODlGeElVdFZZQnZqVTAwSHU5aXhzT2xh?=
 =?utf-8?B?WjdvYS9uSkFneGZ0UzBWNEZKMGFiU01qWHhHb29WcGltcDltWUNRR0hYY1Rs?=
 =?utf-8?B?bUJ4UElPQmJCNEQ4VW5QSUVvdVdoMUkrTnRGNHVoNkhsalBpUHBia3FoTEdR?=
 =?utf-8?B?d3N0eTlmQi9BRGRIN1dVclJvVE1JRVgyVCs3Y205RmVoaW5neHV6SU9JS3Vo?=
 =?utf-8?B?UXZFRDFLY2UzR0lRMVhSWHZHVmxxeWloM2hNdkgyMklDV0tzU1Z3Ui9iNTg1?=
 =?utf-8?B?ODhhUTh0a2N5eG9aa1RZenpqWmx4cytLWVMrdWZSa1dNQ1FNRlJNMkRWanJr?=
 =?utf-8?B?Q05iOTVWaW1MUmxuWHI0ZnRXM1VQWlFNa2UrN1RCSEowbksyN1F3QzgzK0hS?=
 =?utf-8?B?Y3R3S2pldmhwMWJwM0dBdXBhR243V3hscFo5ZlBiV2tQcEtERFZCZXNTRGtw?=
 =?utf-8?B?MERtWnl2cVRLZEk0Wllyb0ZWc3dkSW5GdG9XOEV3dW9pamRYKzZvTU5qcmph?=
 =?utf-8?B?cXpEekxtNHhLN2MrOHZ3U1RiNVoxTjRjai9XMXpyaWJMeGtEUlhXY3UxYnk4?=
 =?utf-8?B?Vk4yVlFqU3hYQlZib2dKUVFuem55cGltVEtvdFBCVEk1MHZjRkIxRUlKSFB6?=
 =?utf-8?B?WDZ4bldobkZUYXNpY09mL25ueTI3UnBVSmFMR1ptU05NMDJPN2MwbXJEbVEy?=
 =?utf-8?B?ejBmTWRUbXVLcHRQYWpmNFFiamxkT01JcHNVUHhaTjJFWVFNOHVVRHZuMG9E?=
 =?utf-8?B?NzBBeWJaeEMxZWs5a041TXBzYlFBSDVtVHJwSWxIdUlDc21SbzhkQysrb3Z1?=
 =?utf-8?B?NEhPeXYxdXY4TUp3Mkw5eHVSckRKN09NTkliUDl1L29vR2QwbmtqMDErejc3?=
 =?utf-8?B?YWJHNGMxeEtZTExDK1hvcDB6bENuMTdteWkxbXpQZTU1QlV4MWU0aW9vK3V3?=
 =?utf-8?B?UFFxcjh3Q1RTMFBaUENHUW5RWUhoblpJbUQwMVpsTkJ3MytsYjkzK3orbEZZ?=
 =?utf-8?B?dHd1cm9qbnpOWnpZVE5rcEZpYVZjV21iN2pvKzI4NHBad0huQ0JoV2JLSVZu?=
 =?utf-8?B?c0tWeFF0OHcwbFYzYlJQTVRUZFBDeGoxUWZ5dm5zT3MrOXVVYWQvRE5QMzRJ?=
 =?utf-8?B?aUswSUVyRitaOVpycUFaclBEbXVibjFlQnB5ZFNrZ2Ivd3hzcGE2WGFVS2RE?=
 =?utf-8?B?SnM4NFM2ZjVSZlJXVTMvU04wRjNCSlFQU1RQU0hLTlJXYXJYYUVMM3Z5OEEw?=
 =?utf-8?B?NGxqRHV4MEpHWDdLSVp2czVUSEg5S21uZWY2S2tOQjY0QWIraHR0N3dGTC9G?=
 =?utf-8?B?S1RvTnFUM3YzOHJ4ckIyZmVab3RuQ3UzVmpqTTdkWnJMcHpxS3BNVUEwMzdT?=
 =?utf-8?B?VHg0ZTRHaHRlR0d4Wk93RGN5Ly8wYlRJTk12andmUE1oc0wyTm4zY0FXWEkw?=
 =?utf-8?B?YUdtcWYxNHlWNlRzQ3dDRFRGbUNkQVA4UmpoY1BYWWVzTmZlVVcxQ1dLckd6?=
 =?utf-8?B?NUVYYUxNckJCYmxSeHlBZWp3ZHlhVWFKSlNIejR6SDVRSjZCK0pFWGdtS2ZI?=
 =?utf-8?B?ckVrdThkNWpDWkpqUEdMZlJXaDlSbXJFM25Wb2pQd20rd3h6OHF1bnpGNHJI?=
 =?utf-8?B?Z294WWNhU05IbFVmbmEwV3R4YUcwY3RrSklFNlhvRWt2R0J0RjVjT2JsZ1hC?=
 =?utf-8?Q?0f1oZLr1TK9oBxB1m7Vrn4Va2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ecff67-94a0-4534-8ba1-08dd193a7d30
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:48:35.7442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgoqHPkmP8yTA1gly79XZc9WWQGrGrdzlXafN9bSjJseEZQZdc22CYrhPl3PcrJUDm09x8L2zLNNoD/c+eQUGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931
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

--------------GWVWu0qxzIyKlmfn6g25kdDE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-12-09 22:53, Jesse.zhang@amd.com wrote:
> sdmv7 queue reset already supports by mmio, add its sys file.
>
> Signed-off-by: Jesse Zhang<jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 627e0173b64d..8e69b84e0165 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1368,6 +1368,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> +	adev->sdma.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
> +	adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   	/* Allocate memory for SDMA IP Dump buffer */
>   	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
>   	if (ptr)
> @@ -1378,7 +1381,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
>   #endif
> -
> +	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
>   
>   	return r;

4 lines above - should it be one line only? I hope the compiler can 
optimize the code to be same as below. At lease we can remove "if (r)" 
to be sure no extra instruction is generated.

return amdgpu_sdma_sysfs_reset_mask_init(adev);

David

>   }
> @@ -1391,6 +1396,7 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->sdma.num_instances; i++)
>   		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
>   
> +	amdgpu_sdma_sysfs_reset_mask_fini(adev);
>   	amdgpu_sdma_destroy_inst_ctx(adev, true);
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
--------------GWVWu0qxzIyKlmfn6g25kdDE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-12-09 22:53,
      <a class="moz-txt-link-abbreviated" href="mailto:Jesse.zhang@amd.com">Jesse.zhang@amd.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241210035318.2159002-1-jesse.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">sdmv7 queue reset already supports by mmio, add its sys file.

Signed-off-by: Jesse Zhang <a class="moz-txt-link-rfc2396E" href="mailto:jesse.zhang@amd.com">&lt;jesse.zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 627e0173b64d..8e69b84e0165 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1368,6 +1368,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	adev-&gt;sdma.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&amp;adev-&gt;sdma.instance[0].ring);
+	adev-&gt;sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev-&gt;sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr)
@@ -1378,7 +1381,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	adev-&gt;userq_funcs[AMDGPU_HW_IP_DMA] = &amp;userq_mes_funcs;
 #endif
-
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 
 	return r;</pre>
    </blockquote>
    <p>4 lines above - should it be one line only? I hope the compiler
      can optimize the code to be same as below. At lease we can remove
      &quot;if (r)&quot; to be sure no extra instruction is generated.<br>
    </p>
    <p>return <span style="white-space: pre-wrap">amdgpu_sdma_sysfs_reset_mask_init(adev);</span></p>
    <p><span style="white-space: pre-wrap">David
</span></p>
    <blockquote type="cite" cite="mid:20241210035318.2159002-1-jesse.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">
 }
@@ -1391,6 +1396,7 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i &lt; adev-&gt;sdma.num_instances; i++)
 		amdgpu_ring_fini(&amp;adev-&gt;sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	if (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
</pre>
    </blockquote>
  </body>
</html>

--------------GWVWu0qxzIyKlmfn6g25kdDE--
