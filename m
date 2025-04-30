Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3761BC369DC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 11:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82D910E102;
	Wed, 30 Apr 2025 11:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i5ztYp0X";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E55B10E102
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 11:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBg2V4bfEalXq9lpGSAZM99kn8j/Jr4rwiJXU/NEfwP+R5/EP1zfmvYVpEQo8j91tCOE13IY+R7oDywt+zm3EF9HJvdM7DwFVoVYiqWrodvdEo44Lg0TuNPdEzriOlFo9W9QeMFXMZguD+LhlU9ro2SwphG9m9i0BCwPnUqDOb5cj2rEwBBYXY3xmMsmGxTHgvaOC5rZhoTOnDwh8HXw6ytKQxXpoVrlnvHv0Mu2Jx7Yyc6SCmd1yB/0p27DfDhlmgdDXiDxQdzVtQyuLv9aBgkWk7XRs65XvugCWepBh1wmTmNVYaySoyQPh7JAPlG65BBdulJEKrjkH/6efpH/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgUHaHSNX/ZZzsZMUwWLlElTf+XLr6707HiVW+rZCrA=;
 b=W01O4TFZDko98KGcTy+0Y5kJ+as/ydbIVKAU8Ponamrw7tSo86L/7UU0d3stiWMw+NR+LSZp8lsFtaj2Ji8LqhwIzh6VIzOXdMVdl9QJDvJAM5U6zn6ZbOl3eHzAnAHnad48BOWAc9Ys5c0NHfE+96AY7bpFPRtdUP3ANNGd0fV5+5FGR+FnWg0cVMWUFFaLAEVxAGLWMrqduAmqSUYyIuPsZYd0KR6lZvxrbPoGxe+izEol4zpl3y6IS/bSQIio7pLK+bFBX/OJY22RyPT84iLsbJFh8DsLhAPrs3r/8eIr75Oc62kf7vzTd5x7MDNzBitUFcEpMELZm/6MTNAf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgUHaHSNX/ZZzsZMUwWLlElTf+XLr6707HiVW+rZCrA=;
 b=i5ztYp0XBaUwATK2oUZI4g9wbaSj4+GS0HsBTjN4YkavKgwyhzMfTOccSvlMigKers1CSjx3Z/ip6Lz5+zghL7EkjajdfUv6ZjYmBqULov0dfRKqPmhHaAmzcnLbYn73Qc4fF2qTcm2gx7Vkcs4E61Gm6zquxLugigUBLVSny+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 11:58:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 11:58:15 +0000
Message-ID: <5f08bb2d-e9c4-4d0d-b333-baf0355c23af@amd.com>
Date: Wed, 30 Apr 2025 13:58:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] drm/amdgpu: fix the eviction fence dereference
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430024054.4093239-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 0248cd13-b31e-4a3c-eb9e-08dd87de4a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V29KWVQyMnJ2MFhwWk0wR3lyMS9sMm9TZlNNeGViWFhpckVkQ2MzRXZYRFZu?=
 =?utf-8?B?SVlNc3RpVFFTZWVDUkt4UzRWUnVvYmFXalhLSzIvTVQ1OTZLajhsNmdMbFhG?=
 =?utf-8?B?WHEwR0pHVGErN0lKUFBZV1pyTUJaMWNlME1oZ2hFVFNGT1ltZkZDSDI1Y2N4?=
 =?utf-8?B?REx2ZDNEeDc1RWFhMHVwaDVIN09kR2JMVk1oamFWQkcwS1E0cUFLbUVjM2JC?=
 =?utf-8?B?OWZQN3JRTHlGUHo2WU1vRkVVM3ZMcSs5aVpwdTlXZElieElOTzFha3EyOGZp?=
 =?utf-8?B?YU1HN0hRM2ZIMmZrRkRUc0FxUEs1dGEzcVZ6MTlERHZTZVpLZ2M4WmhKbXZq?=
 =?utf-8?B?c3g0cktqb2lxM0dueXpCTzZBdDBzczRxK2t3cWFSWFdWQzlXUU00WXdRVGd6?=
 =?utf-8?B?WVJSZzBHRGN0MUMxTFNKMS84SWVDM2JwTWFwdWdIcUJtZ3ZhWVBRSHFxMW1z?=
 =?utf-8?B?VEJNVEd6YnU2bHJ4RGVsLzZWeGdOT1ZOeWdlUU1BUThJM0VIY0dZVUtzWENw?=
 =?utf-8?B?eWtqaHBia00rYXZnWk9penFKeGdUa21nSXpIanR3V0RPVFg2ZVY3RGxQZjNa?=
 =?utf-8?B?T1hiQ0tUQVdnRTRzWU1ybkhlRXFUY3A1YVZOWjBzcElZcVV0VDhBaTh4UEdM?=
 =?utf-8?B?UnUxMlBIRzRpM0F3N2NMZERza21GUDVaYWgzcGJ1MURyY0pBRUF1QmtVNGxP?=
 =?utf-8?B?cExVZnc2REhUc0w1ZnF0QmNRVmk3cUZyTmJmYmdUUzRDbDdZdTZvdkYrWVpz?=
 =?utf-8?B?WjBFdzdiVlVwcmdUZThaY3hjMWp6cURYL0MrWDMycE1LcTRPNWI0eDl1dTBa?=
 =?utf-8?B?ODV4QkpuZ3pXWTZIRWhmYm9CMXRkN3NlOXBrNjRpN1FIVzc4WDRqRjE1UGRa?=
 =?utf-8?B?OEJHbkJtQTVUV1ZjYlZmTGMvUWtUVS91Y1poRUdGMVdSTDJTNnpIdThkc2Jx?=
 =?utf-8?B?RkJSUjBCUTU4SWN5Ym9rSHNOUjFiMVpLbGhFY2NCcHRmTUcvTkhMTDhwejZp?=
 =?utf-8?B?WnBOK1VRVExGdkgwK0F6YW5jUUJBU3UvU1lIQkdQSitKRU1NSk0yNEwxVm5P?=
 =?utf-8?B?T1ZBN0Vldlh6K2ZIRGVQTTB5UFpyVkdRZTY5VTNTUFMzNXlZOTlwd2xFVUJn?=
 =?utf-8?B?b1BTNXJoaUlGWUlYa3dBNm92OHZHNjJiazAzZ1VlSUJhdzQ1SmZnZ0s5NWJr?=
 =?utf-8?B?dGhUYVdBci9hZFRYMVcxREhDamdYOWRUR0krc3J1VFVUTXlOZUpKRG91cXl1?=
 =?utf-8?B?ZEh6MVBUSHp2Mi9KQW9tNDMrcHVCTzkyUm82am0wdWlHWkU1aW1MUjk4dGVl?=
 =?utf-8?B?cTFFbGZXV284UXlkdGFkUEQ3bUlzMWNwNmN5MUxkWHRCODNZZTRudERqQ2Zv?=
 =?utf-8?B?VDI5Ukl2endnRHh3ZjRKSGJkQjVSamdza2dUS0FTcmppa0dvWXFsTnRJOEdK?=
 =?utf-8?B?b2k0dHFvYWhwS0FoaUI5TjhrTDhmd0txNklpZ1JoN1lUVk0vRU5DQUpwMXlC?=
 =?utf-8?B?TU9vaVphckwrWGFhZkcrSkhLMVBxeEdBZjI0T1Nsd0UvVkdLaldUOVE0YW5k?=
 =?utf-8?B?cjdhUFJic2RFNUliV0p2RnMva2FQVFJiMWRFek9XMURvdE1BcXI3bXBpTVAx?=
 =?utf-8?B?MUF6VVgzeS9yRWx6RjJlQlZsTWx5bjVJeDBWODBBcjRDcUFhSHQzS0lsWWJJ?=
 =?utf-8?B?dUhuTnhzWE5HUCs3blRVL3gzZXlxUTUyNDYrS0xYL2pNS2tybTVMdE0rc1pn?=
 =?utf-8?B?bkd3NzhLdHU1TWZoMHBwS1RtK3JJVTRuM0VGZTlzeE45bVorS0NhU1poNXFU?=
 =?utf-8?B?Q29JMTN4K2ZIai9ZNW5hRUNzUFY5YXpiSllPMUZwdy93dTJtTG9nUFlSS1JG?=
 =?utf-8?B?SkR4c0dXb3lVRUZyRUdrUysrbU02ZEpocG53Zk5ES0hpOUVhbkdGbG9lZjgz?=
 =?utf-8?Q?zJMDwHgDJfk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBwZis5NElhRXpCZHZuRmVoTm1PWDZONXJ2Q1FqWVZQbzVWVEJIeTFzaDIr?=
 =?utf-8?B?SXgrejl2L1V0ZW1wK3pYQ2p6RisxamhraHZSSy9XWGR0WGtBNWhWdHNJTU11?=
 =?utf-8?B?eWk3YzVxblIyVkZlMXAwSG1ieDBOUzR1NlhUdlU3UnQrWERFQ3FMMFk2YWRF?=
 =?utf-8?B?THlZOUlzQ2RjSVVYRGIvdXhDMUZSRHRjd2lLTTcyY3A0L2h2WGpWM3JnN0Z5?=
 =?utf-8?B?SFU0UnVKcGZuSU85ZlpnMXVRNFJjNlBEN0lSS0pGWGpqaVhJVmxmbjA2MkdJ?=
 =?utf-8?B?Q3BrWVpSM2JncGF6R2NpSWdMQjB4UnB0dUt3K3JMWnZvaG5qZjdpeTBObDN6?=
 =?utf-8?B?S3VqaXB5UEV4WTdVREZrVnRrN3M5aHYxSnN3S0ZsNkNBa2huQzU4TlVmZER3?=
 =?utf-8?B?NE9xUytBbG9sNldkUm9oMXlldDlVNEo1YlpSSDZ4OVBUSVRvc3JDSnE0Z3No?=
 =?utf-8?B?WXZQckNZSXdlNFgxNksyY21hZGxVMXVOWUFKUnB0L0RRQ0RJT3VCM2M3R1V0?=
 =?utf-8?B?YTgwakxjQ3ZaL3VIaSs2UGtZQ09lVEFHNUFEVUhzd3QvWkdycTlOZ2JqODBU?=
 =?utf-8?B?eHdsZGVvejM4elRvejY4eTZTcXJIUC9RMmk2cjUxZ04vQUR4U2VXRzNyeGZK?=
 =?utf-8?B?ZGR1UGduQmRwbld6YWJOcUdSbWRIdExQeDdMNG9PQXdLZUs0ZGpHdmxQbFlo?=
 =?utf-8?B?RWFEVlE4WGhGaGJEK3R2bC9sV1RiTGduZzlXRndySEV4RzlIR2dYMTA4Ym9S?=
 =?utf-8?B?bkdBVlZrZDRoWktaM3F0d3QrbW5EZVc5TzN0TENSSUZjdUs0Q2xXUGZoNlp6?=
 =?utf-8?B?aHRqVkZSQ013Qy82VW0vMk9oNk1QU1d1c2JlWEF3RDBKRFBvVkdoVHFnRjd3?=
 =?utf-8?B?eWdvZFRwUlNwZkpHc0ZSbkoxYld0aW5aM2N4SklFN0FYaFQ0U1VUQ2t6cnhN?=
 =?utf-8?B?aTQyZ1EwaVl6NlRNd2praUtKby94SHhiZ0tZbDc3KzcyRTFYeXBCTDJUdzlp?=
 =?utf-8?B?RHdSVm5iaUhGOWhFQzNyY0lMVGljSFdSRDBibGV1a1FPU25EbGVwM2p0Y2lC?=
 =?utf-8?B?NExIS2NtMFkwc3NyaTlwai9xRk90OVBGYlY5UEZJSTcxK2tGTGtZNW45T0th?=
 =?utf-8?B?MWZyQlQ2R0JNcENDKzVmc2tRdDRuQTh6S0tzOTFteEtNYXhSZGZhbVJVSUFJ?=
 =?utf-8?B?VHdjdzZRaGZkU1NEajdaQlR1Qm1BRzlrQ3hURUs1OHFBSlIreWV2UGlwMEVq?=
 =?utf-8?B?Q01tUnQ5Rm4yY1VsY0xxZk1CYWM0OE1reWFPSm0vMUVnQ2w2WFI1UmJ3L0p2?=
 =?utf-8?B?NUFiL3VQZVdnSTgxVXpsaC8vUFNpaXBROVEwM1FIb25sNFAzUFQ2TGFGQXUv?=
 =?utf-8?B?WlN1S0orY2tUak1MalcyRnYxRWpNTEs0QXBUN2J0d0pkRnE2S3o2NkJwU2V0?=
 =?utf-8?B?eTVyUjVwejV6QkVoS2YzTnFVMy93MDlLdm9FTFBmTlRwZGNkcUFzYWI5NDFT?=
 =?utf-8?B?S3ByanJmVVBoMEpxNDlGUGZTOTdJZjZjL2tFYVkxNkdCTmlSdEloRzk4Zlkz?=
 =?utf-8?B?TlJlZ3YvUlVxdHlBazFFRjVoalNGcjFUY3RiN0x6MG5HRm5uWnRVUk4wUVhD?=
 =?utf-8?B?aWZyS1RCM3pzMERpeGVXTUhER09RYjBwTWNHSzQvcC9qUTVmbnhMM0hNOTRq?=
 =?utf-8?B?ZkpjTTEvdFpHV3dlRFRhRTJNTUF4SXA3dG5HS2xCakh5QVR5ZmxyRDJMaEds?=
 =?utf-8?B?b3FDNlR6MHdWMzQ0NU5Lc2R3UlBRak1PQWNkRWVpbmY0enZaOXZUaCsyMmor?=
 =?utf-8?B?QlBZWGo2Tm0zNDg5SS81STJvcTZNVlhUTHdSUDVlVXh1OXBGb0ZWazJFMnhh?=
 =?utf-8?B?QVJia1BDMldlUmVYVkllS3UrRUhGSXdDY2gybCtVbm5ZZ2tiN0FPSURPTkVx?=
 =?utf-8?B?Ukl4K2lMRlFTcUU1R1FKSVNDZXdzUXFpZGZDaGR4RXhVOVNxSmc4YUVSOVht?=
 =?utf-8?B?RVN5RENKSjJyWFN5TTIvUjRab1hscGpScEVweUJkaE1tZWlBb20rYkc1Y0xI?=
 =?utf-8?B?RkpyaEgwYUVJMWt6NUpJL0MrZEdEdnRGVmJYMUxoam5zYjR6cStnT0xmTk9N?=
 =?utf-8?Q?QvmSWZUNYvbHUzW3XQtIPkF1Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0248cd13-b31e-4a3c-eb9e-08dd87de4a22
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:58:15.5488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmbkJRPW+UbwnZfequOKCktMDPkrJ3dQpIBHb/M77MIFcRHAoEKEaFb1PgoZ5FdJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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

On 4/30/25 04:40, Prike Liang wrote:
> The dma_resv_add_fence() already refers to the added fence.
> So when attaching the evciton fence to the gem bo, it needn't
> refer to it anymore.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

This is a bug fix and as such should always come as first patch in a series.

Please make sure to commit this one to amd-staging-drm-next ASAP.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 6c9b2b43a929..7a5f02ef45a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -189,7 +189,6 @@ void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  				 struct amdgpu_bo *bo)
>  {
> -	struct dma_fence *ef;
>  	struct amdgpu_eviction_fence *ev_fence;
>  	struct dma_resv *resv = bo->tbo.base.resv;
>  	int ret;
> @@ -205,10 +204,8 @@ int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  
>  	spin_lock(&evf_mgr->ev_fence_lock);
>  	ev_fence = evf_mgr->ev_fence;
> -	if (ev_fence) {
> -		ef = dma_fence_get(&ev_fence->base);
> -		dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
> -	}
> +	if (ev_fence)
> +		dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
>  	spin_unlock(&evf_mgr->ev_fence_lock);
>  
>  	return 0;

