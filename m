Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA64CF34CC
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 22:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA5A10E980;
	Thu,  3 Oct 2024 22:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="36tWPSo+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A642E10E980
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 22:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6LhEYznjXO0igTZ9i0EKriMRTZzIzMAjpce9m8PJSXc6Ao5FXjaN+n8ms4hCNrKKsoM7Y2l+OAO80Mdx2QesgkuEDIoIw8Hii84AdaCpLCsVUDj5+SCaYYkuRphQFQSyNizOji+BMTd7NtW2md8aL+Nkc5hBCdR9y1l4CzidlabaNO5aa7S0YA+maJg5OpmFfLBSY2kZNyOO/S5+I/xc9CZhlQjed1OQ3UHLigmAKaqpMzNn71+ob84LaAUAFx+Nnht92Wp35JrRqaHGMsVUJKzcZ15r1ZrvmyU/noacZ7t2EJvOlGQGFb7tOBCI7/+Hq5GWcSnQ6ab/U1AHbum2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JGIN3lhmRM6fOVNEDSU08zHEk+P8LpEMGVfC3SqXI8=;
 b=HtTJx7w0yZ997KeA68lJ+W8u+V6FjfSPo5d49TX2qPR3/EvoHj1GEj9U3JWm19oXzkTKOR5xliIu19HN7TFmkz1J7Zkyvm/Mwk/1Hkp10m/nx4KSLxw7ggLofQDdjIaxPpl+bWUjTFzpsMlFXfNuphScN60US/ijqxe5skQ3uRq2tTXoVBhesVVACjAD4Raf0mE217DnCsFMe+S3vf1ej8yMMPeNv0eOdT6/RPapjwHXjc9W724v3lyrpEA3+50zQASObXhIgXdkTWBjeBwX9ma8a1zw86zzaE1ORtmk6Cw+zP5hQyjpKCTEKygzmvp4trLY2m0wgQeSYTvkqAbB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JGIN3lhmRM6fOVNEDSU08zHEk+P8LpEMGVfC3SqXI8=;
 b=36tWPSo+azlJfpG4pN8LhqiV3X9NtkRisBRL+Ak2ZKiKdrOO54dY/hXO7N4kae7pJkyI7Sg6F8DPN1PocIUqAEneDcQFwybR097TjepjgdrfmVINopj+tKJ+KfVWgaWOzlxgrH9o90xGW7HarHrDGW5kgA7d8X3rt3platmz3Yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 22:11:17 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8026.014; Thu, 3 Oct 2024
 22:11:17 +0000
Message-ID: <0e3ffe8d-da8d-4932-99f8-8241d17573f6@amd.com>
Date: Thu, 3 Oct 2024 17:11:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process
 has been removed
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241003205526.35748-1-xiaogang.chen@amd.com>
 <63ed9ee7-a4a1-4912-9ef7-743879941ced@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <63ed9ee7-a4a1-4912-9ef7-743879941ced@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 1253e9e1-62b7-43e1-4d93-08dce3f84d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MENkT0dNK2FJdHRpaG1vK3ordUN2SmI4WFhqbE5QR3lKamJIaHdtalQ0cDQ1?=
 =?utf-8?B?ZDVmSVkrS0RCdkE2Zk5xNlNWTXJzZklSUGJsbGZXSFpOaWJQNFBSdEZMQnd3?=
 =?utf-8?B?SEMrVmdnQVV6eS9henJoYUtzU0FweHYrUytINlA2NWVZRGZGQWZLY2VmNVlQ?=
 =?utf-8?B?M29ETUpnZExGYjNrbmtJMUFjU2YwZWFIMGRPaHZUTk9PYVdEc1Y1Wkt0SU1o?=
 =?utf-8?B?WFkxZnV2ZC9QQklzcnRVaklzSXdPZ0tac0FHcUFOSGlvZHNLRW9RbG5VTUZI?=
 =?utf-8?B?ZkMzcVlVa2c1UEh6ZHcwSEtCZHF4dDFFWFNRMWFnekRUZzBnV2VCeUgrVVhy?=
 =?utf-8?B?SThXRFdkUVFSb2Fqam8yVWpMUHVnbXhLTlBWTnVQNE1kOGxwNXRwbUZybE1L?=
 =?utf-8?B?MDUxR2NGS1JBdjlQcVZiNEZmQ2ZQNW43c3BIUTNjek9nbFIzamtMVmdjU2RV?=
 =?utf-8?B?cTdlSWZTYmk1cWFSSXdqd0M0Z1NpK25xWlpsL2dROG56UnREcDhwSlVQMExG?=
 =?utf-8?B?NEVqa1VyWXQzWXlYZGdzTkJoNzFqa0wwSnhCRCtWQXBKTklvT1lVRHJOT1d1?=
 =?utf-8?B?RzJFWjlEanVkb1loVGg2dWFObnJ4dWxscWxra0dkMWZNeVY2eEJEM3ZKVzZY?=
 =?utf-8?B?VlphYmYxcmUxaTBGOCtsVUhMcG56Q3dubUZlTWxpbExZbnVNVHRlb3VOeWZC?=
 =?utf-8?B?djdaUUc2QWJ3cHZvaXNMM29zSi9mOCtPOVlDanRUUnJWK1pzQlZJYkZhRlNp?=
 =?utf-8?B?Zi9LbklaNDA5QUZmdzV2eUVNdUdSdGZLN3FXb2pRUE11V29LU0V3bDlHa0l5?=
 =?utf-8?B?SS90cHM5amtVVHlTcGNpR1NRQ25tUU54QVZUY0MrUDNpd2cwcEtGMlcwOWN4?=
 =?utf-8?B?NTlQai9iRm9xeUJFMEh3UXdHVlBvTkl5TlhTNHpzYXlWTlpCQWFWUXZvZzlx?=
 =?utf-8?B?SklZSzk0cHR0SHQxOHp6dnBSWGs3Z2c0T3lrOGFZQ29DQ3B2czcxZm9ZaDZT?=
 =?utf-8?B?UFNKUUpySzZWMUU0QktBMzFqRnUzOEZpTVNEaG5WcUErWXRWbk9Lb0RxTmtu?=
 =?utf-8?B?LytZVG9iY3lOckplUmtBVkNjSnJsdFkvSXNZWEJMOU5BWEJrK08vTjVPblky?=
 =?utf-8?B?N1F2MzVBUVNjUnphcjNpbG9MaktNbmhSMUNTdDhsRnNIRFJGcUdwbHBIZ25z?=
 =?utf-8?B?VUppaVdkZHVsbmpQMFovZytmdFRZZTI0bGtkUmE0TjNjUy9xSWhUZjRaSG04?=
 =?utf-8?B?ZGZUQ0dvSmhoZTBBZGloZ1A4UHZrTDhrTGg1M21oWlZXZzhiaWd4enh0Rk1R?=
 =?utf-8?B?MHBZd2NQRmNKU0V1UVllTk5xazVkYVBiNjFuK3BoZUltU0E2aGxNYld2Q0Vl?=
 =?utf-8?B?UU1jc1FRTUt4ZHZnbGkzVXR1Y2Q1cHdpeEV6YWpmaU1XanUvTFNwS1NXOFhU?=
 =?utf-8?B?Z3pTbzFiSmFjeVl4dEJtd3ozZ3lQaloxOEtpcTlzRURZVWdRRzRkYVFyRWhx?=
 =?utf-8?B?R2xyWFM5RXBVTmZ1TWJoODkrSnhTUHFOcGtQb1dSUEdpbXhFcUFGd0UxMXFm?=
 =?utf-8?B?MUZ3TEZVaVpVa0xkNURldFI1am9zbGF6U3YzbXhpcnJhRjVxQVVrWURuSFV1?=
 =?utf-8?B?QS80ZzA2bjZieCtKNUUwZ1BoY255NVJNWm9yblZPS1dENzZsaW9VSWtiYlV4?=
 =?utf-8?B?Y3JScTNBUUdCdHVxbEVtRDNGYmpHd3V2dzUwV3grT1dGNUhvL3NFZytBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxZMERVK0FoWW1LeUYzYWV3QmQzbGhzUVhyQkZwcmt5aURiOWpqdEZQQlhM?=
 =?utf-8?B?eW9FQnQ2RndvSmVabG5LbDkyTU1zV0t5Ulh5STJuaU9la09zdHNnTndrRmZL?=
 =?utf-8?B?N2dxTTMyaTY2OWY0YjBMUVlwUlhqVUt1eWdOZlltMStKR045V3M5WVN2ZkJV?=
 =?utf-8?B?VnhTYlpzeGRLMDNPM1dlWDUraHQxcExtZVcrMWZzRDdYMVJYNEZzbXJ5ekhH?=
 =?utf-8?B?S2NwUEQ3WFpKbStlL3ZJYVBWb29uaDdkd2dPbk1odWg2Ullnd0JBK0RhVE9a?=
 =?utf-8?B?ZjFBQ2VjWTB3MnVqbXVIdXUzak12dGw5aFVJZytXQXhqeTh2dkk0cFBialE1?=
 =?utf-8?B?RDZVQnp5S3d1K1ZXSEFxTnY1UEVoQVU0NTMxSmFMZExBR1ZBTWloN3hKQi9K?=
 =?utf-8?B?WDNNUUl4a1hEV1grRlprbEYxUkRwTFhDd1lVWFhsdWVQa2V0U1lsSWZzMFE0?=
 =?utf-8?B?T2lKWllBL2VOZHlLZlpkMEVxclYrYzRVWVN0K0pqNkJZZEFiTjNBN1JvVkho?=
 =?utf-8?B?MG8yZ1Q2MFgydi9JUmFDY0RnSnhwM0NOK3JldkwrRkl6UHJaOWRsVDZLc0pu?=
 =?utf-8?B?NXNzaktXc2dXdmg4M3FRVERHNk5taW0zdWlhME1lMWpmOUkrYlArNk0xdHpx?=
 =?utf-8?B?b21TTTdmenUxQmw3NTNBVTFnNDROYXNSSkFyV0JNdGpYcmxNeGhOY1dLUmEy?=
 =?utf-8?B?Yk95NUFWbDFsbWdKR1NrQTlKZEJtT1JJcXFZTnVBdlpUWC9Gcit4UlVKeGdZ?=
 =?utf-8?B?T091RXBQaGQ3L2YrRkJGR0ZST1hJbWtUZ1JndndmRjJFMXdTcnhJYURPZXd2?=
 =?utf-8?B?ZjJFQlpuMFF6WDlwVVJ5ZktWSVp1aUhiZERiSVE1ODNoY2cvWlpXd1gxc0Uy?=
 =?utf-8?B?eE5ocU54VWFoMjB2WU9SeFN5TSs0S0Z6dW16QTFrNG9HZzU5dTBOSWdSVzNj?=
 =?utf-8?B?SDNOTmRTYkhoN2hWaHZPVTc0VlM2YTJxR0dDTUJCc1RzeGkrOU8rTmdUZkhn?=
 =?utf-8?B?cG5Qb0Ivd2R6NC96QjBoc1YzZXMwK1c0dm5wWm42Zml3SlpCazdiem41SEpM?=
 =?utf-8?B?bk9pcmRRcGhMOVlpd0FhUmRYTnZmLzJiT3IrS1NZdGZteVI1ZjB5SFBzVE8x?=
 =?utf-8?B?ZG1kcTBkVGxwa3E4TTY1UThES01NUTZ4UllnNWo4UlJLWFQ2eUhtWDhtOHhx?=
 =?utf-8?B?bm9iZVkzbTJJTTYxdVBlby8rb1ZIMDdjM25XSXhLbFR6M2NtN2lrak1NVEtS?=
 =?utf-8?B?SytobDI0dmJJZGZsS0lxVllXZnptTno5bTFieUdORWYvelkycmpaTzVBL0tT?=
 =?utf-8?B?bnpVZEN2S1Qyc0wzV2xMcXdkV1NWLzNZTEV4eXJxSmcyY0FlNGJpM1ZyTFYw?=
 =?utf-8?B?TVNXQWpsUHJLMEp6Sk81UGVqeDF5elpaaCtRM0hUai9nQUFEMnVWYkZIQURV?=
 =?utf-8?B?ZEF0a1BUamFHTVdTSUk0Q2VzWDVhdmgrdXpONHlrZUR5dWErT0FUTkVaNHZn?=
 =?utf-8?B?Z1JLYWpLY29wQ1RDKzlZOHVITWFXNHVCSGlKY2c3SklsQ3M0ZmlxWm9mSDM1?=
 =?utf-8?B?bW5UY1UxckhPMzZJMWJJNjRVclMyaWJFaDBEMWZsWERodVR4bXdWTUR3R1FR?=
 =?utf-8?B?VmR4cmpiaFdjV2h4enR5akVnbTJRMVhvN1cwQ2ZJa2h3OGwwakxhVnVpTUIv?=
 =?utf-8?B?OGMzd2Z2dzVkRGMxa1Uyalp5cmEyOCsxbW5SVmdFMzRIWXY5WDlVbFg2MDRp?=
 =?utf-8?B?VGo0QVNHRnJBeWI5M3hUck5XZ25lNmlyS0NiOEVtS2U3dHU4R1BhNTEwRjdr?=
 =?utf-8?B?WXl1aHJEWndtVkE0WTFFWEFLbG5zNXpQdE9rM2ZFZTRlU1pBZGo0Smw4a0xO?=
 =?utf-8?B?T2dtUEtQTlRKUHRDd1VlK0g0SDhuMHlldUlDTlRNOHB5bWx4bmk2YUJNT0xC?=
 =?utf-8?B?VlA2NWplUS9WK3dxOWo5Mlc0MXliOU1rRC84NnFia1VqcUxweDRYTUNERDJY?=
 =?utf-8?B?TXlWSE1sR0JDUVgxMDFvbDFhKytkUGk0N0lSYVpQZEFKTmo0cEhiUXQ1ZFdP?=
 =?utf-8?B?UDRneGF4c3ZBRkpHNTZQSnFlb2w5Qm1tdEhRcVNsbFhUcGo5cDh5dlhFZVZR?=
 =?utf-8?Q?XeWY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1253e9e1-62b7-43e1-4d93-08dce3f84d58
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 22:11:17.0116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbJJwAiDvuisTEicjbdMf+HPcxJKo4uhHYiFV4vpLSeEPIa8iT9+u8CN+egdkwZr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
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


On 10/3/2024 4:11 PM, Felix Kuehling wrote:
>
> On 2024-10-03 16:55, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> When kfd process has been terminated not restore userptr buffer after 
>> mmu notifier invalidates a range.
>>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index ce5ca304dba9..1df0926b63b3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2524,11 +2524,15 @@ int amdgpu_amdkfd_evict_userptr(struct 
>> mmu_interval_notifier *mni,
>>           /* First eviction, stop the queues */
>>           r = kgd2kfd_quiesce_mm(mni->mm,
>>                          KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>> -        if (r)
>> +
>> +        if (r && r != -ESRCH)
>>               pr_err("Failed to quiesce KFD\n");
>> -        queue_delayed_work(system_freezable_wq,
>> -            &process_info->restore_userptr_work,
>> -            msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>> +
>> +        if (!r || r != -ESRCH) {
>
> This condition is always true.
>
so sure why this condition is always true?  kgd2kfd_quiesce_mm can 
return -ESRCH when it cannot find kfd process correspondent to mni->mm, 
then above checking will be false, then will not queue restore work item 
into system_freezable_wq.

Regards

Xiaogang

> Regards,
>   Felix
>
>
>> + queue_delayed_work(system_freezable_wq,
>> +                &process_info->restore_userptr_work,
>> + msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>> +        }
>>       }
>>       mutex_unlock(&process_info->notifier_lock);
