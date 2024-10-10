Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA31CFC5F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 18:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B615A10E129;
	Thu, 10 Oct 2024 18:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rVKl0L4n";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C037810E129
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 18:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BP/FsM+L6jiDk7BDhJDUycAf8xiZujxy9a4hHfrLgFU4+RUynFv/9jKzUBSpxg9xCryafvh55jZMFgO+RzX+6dc51eYLH23hPQoRZlRtMYQfxhIUrJhVBQvYeMcYNbXY4KiL9u9MQoFP17QOEGw7eWNOg0jfE5+kQZyVETW1wd8rDgh6DhxRl7cj1tNK/KFVrn0h/4XBrB6mVpl5vSKVGKyOiMrWCwewWavRv96Ge+P1SlTemBMNHIK/c83x88expoi/oihD/pZnYyY7q+5WBsvFunhUVw2yrngGDq0m/uYcizPCIec9DEhq0DzYvZT+zny7jVzeFGBYDx0+UMZ0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HYHMlORVsG18YXCrWih+PUsM5EB+87hIo8laQgS0Y4=;
 b=E+4QQ99Z3NCvyyZufXrTjxph8xrJ/lU09i9v4e8zTDacrBKHa9ZbNRfipjcsqEHhWbzk/Mk/Gx2JGd999TQQ3/iFnUZcUbq/Ni/h1Qym7KAIJQp/lO/nBiuCWc8sTTf5Nu5tDv2BURfToKUwjhYDaORWF+fJPfyfb/pUYMjnvOPZJjpbNKAEPuiIDB20LbH4IfjamJV+Wuk4b0fOwcSblfORnmBFc5kc1ZoMZbETAw0BiodG5CWfw+XH94lbCbC07Csev77ckC2sMFkpJHb1SKAK7tOaN8x8laiXqwHMv/IcLSYiZ7W5M7WF7HSTE74NrVOUyg4RBULRVi8nDuSDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HYHMlORVsG18YXCrWih+PUsM5EB+87hIo8laQgS0Y4=;
 b=rVKl0L4n6PCKecNG9xBMfRzYiwC/nsnchws65O4LGf5+G8ub3Sjha2qRmTMaaTDHGb489WC1xwJKX6Py8pHyv0sm1M3VDsbxQIKiK5i3D5FzxPFADUe2neE59O0Em/LE8bS4NE535JIhBcFszxEuWOgEvg4rSA9ZQ64pA3d4ais=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:54:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 18:54:38 +0000
Message-ID: <bab9f20d-3203-4841-a154-1908836668f8@amd.com>
Date: Thu, 10 Oct 2024 14:54:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Not restore userptr buffer if kfd process
 has been removed
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, kent.russell@amd.com
References: <20241004155401.18978-1-xiaogang.chen@amd.com>
 <39b09fc8-16d7-462b-b4f2-3e0821434d9b@amd.com>
 <af0a1977-66a3-4891-91c7-8f807effa966@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <af0a1977-66a3-4891-91c7-8f807effa966@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbc4ec3-f40f-4e5f-eb35-08dce95cfd9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnpRZkozeTdDNjNWWjlqeU5QWWFPaVhBMmVKNXM0S1I5TjZvK0NOMlNiNlBG?=
 =?utf-8?B?b2crU1ZxbFV2enRSdjZweHpFekdDVVRZYTl4ZUhzVU1aNnVBK1ZNa1BDUy9x?=
 =?utf-8?B?YUwvaUpueHAvUW5qV2RlMDBZSnB5U2pLd1VZcVBIL21jd1gzTUtkVU5sL1l5?=
 =?utf-8?B?WG4xTEFQOXZwYklrRXNjbElRRUFXN0xNVHAzWjhPZVAxOWIrbkxidUVwY1pv?=
 =?utf-8?B?Wjk3QVQ1eWk2dGNQamp6Q3hsSXdqdWdJN01ydFZJNC8reUFtTnJIcSs0YXAv?=
 =?utf-8?B?UEZhU2Y5dnYwYnh6Qis5YTVHdEtwbXNqNFJMYmdQcGFUVjQ5QzR3aWNFV0RT?=
 =?utf-8?B?aVpVbUJDcllIQzFBMk9yN1hMaVprQTVheVRzamxxUE45ZnpFcE1KOWJ3Qjh4?=
 =?utf-8?B?cHdpNE9ac3dCLzh6clgycWY4MzNQMlh4VmE0a3kvQy9manpvWnljNk0rb1Bs?=
 =?utf-8?B?S3pmOG5vc2NkSkVUdXBtRlgyVlZzTWZvcFp1ZlhIQ2s1cUVoaGszS2RWVDdo?=
 =?utf-8?B?YkpUa0ZjUXd2NnpvUnhrRDgwNU1tazRUWHo4L0RMSm9LK3lsQzVrbHRpQ1dt?=
 =?utf-8?B?bENpeTFOaTNSSUZWelh3L013R0pPdm0xQXBiQXp0MzBvM2xKd0FlUC96RWJY?=
 =?utf-8?B?eXJEZFZGZVFEYUQ4emZqdGFUa2tZczNOWHl3SnVXSFdkRU1haVNZNHJ5Y3lx?=
 =?utf-8?B?L1E3OHNJaTJYb1hLTURqK1Z6RVVlT2hWRWlIM1pjVmZKSDVld3QydHZSTFNH?=
 =?utf-8?B?ZjE2ZXhRTnFHcGRXLzJTekZ6ZW5icUMwcGdBdUNoemc1ek81QU1kYW1SejRu?=
 =?utf-8?B?Z1hOMndaMmdTdG5XYXBnUzJSRW54N3RsSkdDamxTcG9vdWRUellSN2tvYVpY?=
 =?utf-8?B?Q0ZDNmFzR3RBTzVUcW1QMlBkT0JGY3R6UDB1V0UyTSsrRTlES2tVajJ6YzRh?=
 =?utf-8?B?YUpqdGQ3MUpCSnBDN0hZZFJTMVlsbW9SRFVmdExFUHdtbmFYNGwrVFlFR2dk?=
 =?utf-8?B?ajBIaEMyVkpGL2E3dXFMVW1yUSswVHh0WmxhNjVxcE11RDJ3QnZVbnBnSWw0?=
 =?utf-8?B?UmR5Z28vdXR6TmZXenRqd3BkNFFYcTJpM1hPcWI2eEppM2lUQ1lEeTlLeENF?=
 =?utf-8?B?bGkxWFROb2tPSURMYkJRRTdoQmswSTN3R014TlJxSTR2WC9FaEJuQ3NPKzcr?=
 =?utf-8?B?NHFRSWF5OXJEYlgwU1F4M0dPM1I5Zjl6K0J5Q2RheXR1Y3NBcGJZU3lLVEdW?=
 =?utf-8?B?R2ErN2hENTd1VUJibmJUSWcrT2ZMbDFZaWd0cUdUQVVndFdUTjFGaWhHcy82?=
 =?utf-8?B?UTRGdFcxazJNZkJtamRlaG1QdGpYb1pRQk9JY0JrRTBGWXpMUjFWTTJjUjR1?=
 =?utf-8?B?SnNlS05LSkd4WTF6WGcyNzVJc0tMbW5FR0kzWTJtd3NqTVZJYWdxek0wbXVR?=
 =?utf-8?B?OHNhd3hLQlllY3RaRjRzK0EwU2txSTQ5Q0NXMUprSTM3cVovZlpEck9nYWI0?=
 =?utf-8?B?NHk3cjNWWEpxeEx0aXJEMjdpNjNUelptaTV6Y3huOElpTWhFN2RXYTZyNllF?=
 =?utf-8?B?R29WbG9KZG9PbUw0dHByTHIyWmhmclpTcTFjbmFlYTRUVXd0V1lSNVk3UzF4?=
 =?utf-8?B?d3hyMS8ycW5xN2FZRm1CMlBhOGFFNXFXK3BSVXg1eEdPbm9HdU9MTG1wK0pB?=
 =?utf-8?B?b1B0OHNsV0tIcTZZTURqMUdUQXM1ZlpEdmJKS2VPSkZOZ0xGNzhQR3JBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VJcUo4UjMvaTNWYzhMcG9hOVh4Y0gwRm1ySlFuUWdvSnR1a01XZWI1eXFR?=
 =?utf-8?B?WXNJVGpxWTZzUlA0ZTZEdEpJZTMvTkFBM1VicW9JeGVmVlAvbnlOM2Fld2hO?=
 =?utf-8?B?bXNyVnBhY3JrdU1mdkZyMmVsak94SWVaWklOYkJ3WEY4dEp5T2l4Yjh4cEFG?=
 =?utf-8?B?eEVqdEMxTGNNSXV6QnBvSkpTaWNRWURpMkp3UDE1VDRFTk5admJzazdTYTdm?=
 =?utf-8?B?RWIyVk12OXpLRitHei84S2FUWng3VVpXMkVPaVQ3S3YzRlRLUHA0dFBGcVFM?=
 =?utf-8?B?NUJRajRwbEQySThFdGhoQzNZR3B6T2Z6ODZNU1U2S0JPa3pMM0s3UHhlY3Ji?=
 =?utf-8?B?QkVOY2lKRkltWnVJdXRHYUlWSEQ4SFlGL2lFMW9EMGtmUzlBdnhDMnFPY00r?=
 =?utf-8?B?WDlGUWJKRU5taHh2bTFKZUJEMEoyTjBFRVJlODAxK0Y2MkU2cUZnak94MlV6?=
 =?utf-8?B?V1dJdzFjUW96TGorMVQ4RFdwbU9xTnM1VnAvRGZ0MUVVNzRzMHVWMFhEbjJq?=
 =?utf-8?B?aDBabjlyTUhaTmd3anlhYTFaRFZydWo3NXNVb0t1aVdIN1N0V3R3bkxiMnhP?=
 =?utf-8?B?dUx2WlBWQUZPcDdKd2ZBaXpMY2dTYlpiMm9jeXBHRUFaa1oxRGZ1TFpnTmlX?=
 =?utf-8?B?cFlBUnlENFhJVVlBRUhUU2tKNjI1NmtFQjJyVzdFbHp0aFlYWmJ0R0dqelRI?=
 =?utf-8?B?aWZ5Y1RsK2tpdlZlcTF6RVB0TlpUdmp0blBlR3Bucy9HdTN1N1MxT0JqNzdv?=
 =?utf-8?B?bVhwVkJGVWxSOG1ONjJKWkhrd2dNWWJ6NC9qYWNCSUY5TVZNNStYNHkwTkFy?=
 =?utf-8?B?a1lzMHRhREJZLzhBVlRyTktvUCtrWmR1M0xUZHRONkFKa2RnWnBBS2ZvN0dh?=
 =?utf-8?B?blpCa1FVUGxuSGhEYi9LN24vb0FpcGo0Y1hYYlJYaDNUVzFqRWQ2Y1V1bmxD?=
 =?utf-8?B?dFYyUXlUNmVJbFR2MWhBRjlGSHltZDFkMzMwRkVzNXN4VlkvOWlITzdpWDJX?=
 =?utf-8?B?aVJlWTJHTDJmekdrSUc5eVdYRU1yMTFwWDk0cXcxUDNXbjhmZ1BCMzZHaXZT?=
 =?utf-8?B?QTdnbVk1Q0ttbHdNYUtKM1ArUFJrZGFBUHEvdzBLemZPM21MaDNlRzVqVDdC?=
 =?utf-8?B?L01xaVNQZHdjRWlnMEg5dEtrK016RGh3U1RCRkxsM0pKUjVRWVZ1VVJ3M1Ir?=
 =?utf-8?B?VFRBUE5VVEZxQy9XMU1VeU1JM0I0Z1RCR1AwM2hjN3FUaUFCNWozMG5aWXpp?=
 =?utf-8?B?d25YOWxIUFc4d0NnMEdrNkJxUHNENm9Ic3F0WkN0emRWWWRlUUlwb0JTTEJC?=
 =?utf-8?B?c0hhVmwwK3BMR29ZRi8vQ1Z3aDdrSGNObXhjSE5razZHcnVtMWlVeElsUi9I?=
 =?utf-8?B?SWM3SWVMYVQ3V2Z6VkErdzJPV2R5Q2diclE2U0JnQmtkRUhESng5eXpIZTFj?=
 =?utf-8?B?a0l0T3VRQ25WMGtUUHo5YVNnY0xCRUdEZERRSXZsNUpTTUlBYktNL2dDOWFn?=
 =?utf-8?B?OUVtNm11UVFKYkdzSDFBbURmdDhmc0Zjbk16ZVh0K21DVWpFZ2ZMRVdseVFl?=
 =?utf-8?B?WTl4cGtqZTl0MGh0ek81MTNDNDRFOXJmS2JnQTBiQjY3dXZKMnJvS3NCcUNC?=
 =?utf-8?B?SDZRenVrLzdJVGdIVk5OTnRNN01NTlpRSDU0aFByTjV0RzdDZDhWYkorUmJu?=
 =?utf-8?B?SWIxdzlSRTY1QmphR0ZFMnNaMW5BK0RyWWN1WU9FVXB5My9ra0E2VE83QVdn?=
 =?utf-8?B?N3V0WDAzc0s1MzF4bjJ4ckhWaFRBdmo3azlvWDRVSzJ5VTlqU0ZDWUFKc1di?=
 =?utf-8?B?NndDVjlSa3ZkdEJNaTB5OEZmdHFTWW9QREpKaG1TLzVOUHBvM3AyTVpaSDlL?=
 =?utf-8?B?SFVMMzl2TmtEd3BCWnkvcXlFSTM3ZENzc0gzSlBXcyszZnJyVkNKSTlRR0FR?=
 =?utf-8?B?SWxDZkcxdG1CVTQ2aEpSbVFsZWVKamFTQVlsaklXSVVmRWhGUXhPZ1VpTzJp?=
 =?utf-8?B?STlqWElhdzY2NXpzM3BGWUFneVUrTlBsazBlT2Yzek9BTEd2OFlwd3lVcm4y?=
 =?utf-8?B?TS8rcEhnUFBMZDV5SzAySnBNRFhha3dUQ3dTd2V1R3lrdVQyRjVEeUFjbDNw?=
 =?utf-8?Q?qhPa9xNqC7b6gvMIjkYfXxtwD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbc4ec3-f40f-4e5f-eb35-08dce95cfd9d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:54:38.2464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4zd06x7W5Tes/mpNzhdqXRKBygtzzhO/XOdGn7DRz/oSx77scitNfsWldpPcST6rZWz0AE96EFluJb/wU1THQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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


On 2024-10-09 18:50, Chen, Xiaogang wrote:
>
> On 10/9/2024 4:36 PM, Felix Kuehling wrote:
>>
>> On 2024-10-04 11:54, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> When kfd process has been terminated not restore userptr buffer 
>>> after mmu
>>> notifier invalidates a range.
>>
>> Is this fixing a real problem or a hypothetical problem? If there is 
>> a real problem, can you include more information here? It looks to me 
>> that amdgpu_amdkfd_restore_userptr_worker is already handling the 
>> cases where a process or mm_struct no longer exists. Maybe the only 
>> user visible change from this patch is, that you no longer print 
>> "Failed to quiesce KFD" in a corner case of an MMU notifier for a 
>> process that no longer exists?
>>
>> Or is there a problem with the lifetime of the process_info that 
>> contains the work_struct?
>>
> My thought was that restore userptr buffer is not needed anyway if the 
> correspondent kfd process has been removed. I noticed that during 
> another work. I do not see if still restoring userptr buffer would 
> cause issue when the kfd process not exist. Think avoid doing it is 
> safer, and not see there is regression.

Well, safer is usually not to change things that aren't broken. Anyway, 
this seems reasonable enough. With the braces below removed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>
> Regards
>
> Xiaogang
>
>>
>>>
>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
>>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index ce5ca304dba9..6b4be7893dfb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -2524,11 +2524,15 @@ int amdgpu_amdkfd_evict_userptr(struct 
>>> mmu_interval_notifier *mni,
>>>           /* First eviction, stop the queues */
>>>           r = kgd2kfd_quiesce_mm(mni->mm,
>>>                          KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>>> -        if (r)
>>> +
>>> +        if (r && r != -ESRCH)
>>>               pr_err("Failed to quiesce KFD\n");
>>> -        queue_delayed_work(system_freezable_wq,
>>> -            &process_info->restore_userptr_work,
>>> - msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>> +
>>> +        if (r != -ESRCH) {
>>
>> Braces are not required because there is only one statement inside 
>> the if.
>>
>> Regards,
>>   Felix
>>
>>
>>> + queue_delayed_work(system_freezable_wq,
>>> +                &process_info->restore_userptr_work,
>>> + msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>> +        }
>>>       }
>>>       mutex_unlock(&process_info->notifier_lock);
