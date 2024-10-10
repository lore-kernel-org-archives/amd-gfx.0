Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A27CF07BF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 08:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DED510E2CE;
	Thu, 10 Oct 2024 08:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tApZmpyi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5F310E2CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 08:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRbz8c94/Ayo49bIKRUiJq3UnC04ZxM4MWBMCHyw5OC2VEF3OYPn5T5z/egYJfu61AtSc+9Vcyl6adAG7zXZVSwf4CSXwEiVk1HDwCvPGhiYZbazbqP0jhirSqDLt4op2TeVSgA9fWdNy7tIKsPvZKmFeTdJ+Wh2829DJPbXLoP9noGcRRyYTbk1ZgoHo6WtLd+OiFHOT1Og1sANXQpHskfzu0xKvLjGsDIOQ3rGZgZb+xC3FUhCzEqblmxImIzcAk8j7jBlo1vR5yo5ODwvJYO3Nc+hf76b/XJ4tlG+B/PCstbsUN9RQgqPuDfqNlNsJ02oIgYkWFBYQ4GgAoa1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFI2A9mFiYgGnh7TIzALzndngkd3axBW/8HGdcYVig8=;
 b=ZftAGAlpzc+/n8eZxtKMAw9zgov7j+NwHyEIWJs1YfspwxSZwV3R8+m77Yw3cBOy1y2xWSN3MRDRARAIhc/vQErjpLEM79wh/e5j7knTPVB4ubbJBKKom7OidAxkV/3MpPABz6hAbVXv7sTi3GxBs0I9HQsv180X6xvj36zIsfTPp98gMXbzsysfNaYpwa8dcbRmE3aHcEuF3bGcbJNn+6y3Jlk6G22sCbaaz/g4l+9Mr+iQ6beSaRlL8AguhC43tc/ZkCwxDSCiIMyUKuKlROBlI+8J6IZGWgtrK1InykoAsuMf+BCFzj3Vx/vYJNbJgrJIgrjxPkl4XE3BDt51iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFI2A9mFiYgGnh7TIzALzndngkd3axBW/8HGdcYVig8=;
 b=tApZmpyiG0mdCTf3mjg+wstl8nZAXIs+0kw2ZzpYFJoxOxlVa1ODZEGIpxMLq0xGTp2D8merPmPID5xHVqJymxj4RnFffHgn00ahCmLk1wqR0/9uo3AVaGxKEf+tI//UtrtiDMwjOGTMNMSiAiaZ/UM9O80GvEfOROEFsq0H7g0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 08:27:37 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 08:27:36 +0000
Subject: Re: [PATCH v1 06/13] drm/amdgpu: validate suspend before function call
From: "Khatri, Sunil" <sunil.khatri@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009142502.891864-1-sunil.khatri@amd.com>
 <20241009142502.891864-7-sunil.khatri@amd.com>
 <d7fa2890-7e0f-48c1-afe3-2d934ee3448e@amd.com>
 <4706cd33-4856-448c-3a6c-86450cc6fcd4@amd.com>
Message-ID: <83d7ef96-fc50-abbf-acc0-46c4a4565c48@amd.com>
Date: Thu, 10 Oct 2024 13:57:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <4706cd33-4856-448c-3a6c-86450cc6fcd4@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcea577-3e0e-4d37-73b9-08dce905654f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0NWTFJGZGRWVlFUVVpYRVJ2S0MvdG9RNUJLY1pyQlJBbXQyRnIvTzc5ZFRU?=
 =?utf-8?B?Ykp4YkhoQnlvaFFwaVlRMHdEZjIzZUpxYUJZRlZoVUtxMzlVNG93MzRXSFo1?=
 =?utf-8?B?Tnh1Z3hXWVBENTB1UXg1R1RIVjgrTWx5bGxBalk1KzAwN3R2bkZsb09FNlNN?=
 =?utf-8?B?V1RUM1RVMnl5TWRLamU4TTBEa1pVT0J2NDlOekJ3OXhIUWZDaURUOTkwTlVr?=
 =?utf-8?B?dVpLUFJLTFlnTGdhNUhxdzYzbEl6MTlOTnB4bHRQUkc4UlJpL0RKNVZNWFhS?=
 =?utf-8?B?L0E4Zi9pSTNvVkhpZXBGeEc5WnFMYUwxSFMxaHZ4YkgvS25zUjZ5UmlxaHhq?=
 =?utf-8?B?eDJoQ0Jpa01YQXBLSFRicnhWWFA1U0JDLzVZVDQ0UElWa2hVTUpjQ1BPenF0?=
 =?utf-8?B?dlBnSW1md0s3UlEzaG9wbUZCMTkwUlZUS2hXTWJuZHBtQnpLL1I0ZW03TzlZ?=
 =?utf-8?B?RktDb2lNa3JLWHpjUVhndFJiTWszL3dNWXhEV0k2d2M5L20vOHIzUnRPY3ZP?=
 =?utf-8?B?NzF1SlI5amJmQy80YXB5VTFZcFM2NVVzOUhLTkRTRVNTYnVmR1l3UE4zWThs?=
 =?utf-8?B?eXFhZ1RhelFzMGMrM1ZnSkpDMGk4T2szZHU5WWZxRzU1U3B0SWt5aWJ1OElm?=
 =?utf-8?B?alltaFZITkZidDVmN3VDNnFMZDVRSzhURWZzTWJtL2huYjh4MndReEVyMzl3?=
 =?utf-8?B?MFpHc09BbjVYOXc2b2lQSEc4aEdQSG9UWWR2dzRMZE9idnhETXJpa3V0Zzk2?=
 =?utf-8?B?ajJKSFVkUGVVTkZaNm1YVUl2a3kvZXNRNzF5dUpnR2lXajdQdzZobWYxcld1?=
 =?utf-8?B?U1hHS2FkZnc0UXhXUkhsellRN0NxRnViU3pzRk1ueDA3dWFQVVBtYVpET21o?=
 =?utf-8?B?cWM3eEZkdDZ2V1VBc3hnOEVIK3BTMTlpdE5TRjM4cXEwRU85ZU5mRkJZWlVm?=
 =?utf-8?B?bWFPZjZKc3lsTFA2MGZyVEN6QXFRREdsUC9CZmNkaGtkVkVzODA4OWJQdmta?=
 =?utf-8?B?OFpzL05WRlZPUDBXK2pHU0NSSWtlOWJoelV0cS9PNUk4dGdPNzdnbzB5SC94?=
 =?utf-8?B?NjhxYnpOUDVoNiszRStoVUh2TzJZMm4vVllOSGU3VTFneTlHbzhVc1VSSmZi?=
 =?utf-8?B?dU1Vd3hWWUlWRWE2dFhPUEFyN2ZyNGgyQTVCblJlNjZXc1RiZ2twaTVucEdu?=
 =?utf-8?B?Uisza2doV1VySUF1Wk16N0p1MzZwYmlraHpLcW1pRC90NlQxNURFbC9EWkpq?=
 =?utf-8?B?VHRzQlNkMHQwQXVBbFhyanZBZkZkdDdpeVpqWnUwaHNsN1FmczJQaFhOMDA4?=
 =?utf-8?B?bWcyeGdjQk8zdFJFWHExUFZFUFAxRWJQS1Y3R2lYcmZ6OE42TS9acERCU1J6?=
 =?utf-8?B?QXdLUm5WNFVpUlQxY0p1UUIwN0FmY0xZY1p4cmtDdEpraWdUemtRdS9laFNt?=
 =?utf-8?B?QzRyeGZlYWJOOWZYdnpGcGMwZ1krOWt6MWp2ZVNMR3V2M3JoYmlucHVaYUlO?=
 =?utf-8?B?bEs4OXlGSUllMitzR3o1R0NaMkh1RklsZkU1cHU3M3BwSHFZQVNiWFZsU2hZ?=
 =?utf-8?B?Y3RJSWxLY3pFSGtmOHF6cktjeGpFbkswOWJEZVdZemtRNlBiZW9hMkVEcWxK?=
 =?utf-8?B?T2VxL2VNWW9iVi9DYTk0MTdmN29LQXpZaTBMMkV1b0hMUkJnZjlvVjJHd1Ev?=
 =?utf-8?B?WjFCRm1kMlJXVDZYYnd5ZDFGMlMwdUEwNE5vOWExb0M5UEdEN1hhUFJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjFUVHozUEo3QUIxemdlbG16dkJPc1AvTWRDNHVTbjBRTitoM3JISFJzUnAz?=
 =?utf-8?B?UjF1aUlMZXY1Ti9tSzdHTHJ6Szk2L2hzVm1SZUNLdUI0LzJ0MEJibWF1ZTJF?=
 =?utf-8?B?bDhwS3ZTUzJtekpVVGtDWGVCYVhaYlV0L1pIazJHRmRTdnJ1K2lFRDNncnZl?=
 =?utf-8?B?bkpWclBoSEpZSHhJTjJXR01LNUVtZnhDWkUvd0ZWdDlrRWl0MVBSdFBxQzZK?=
 =?utf-8?B?K3BMR3ZyWldqVTgwVzdkdk1tQVZ4c0syY1VyVU9SeGcyYWNtQ2E5bDFVRHhm?=
 =?utf-8?B?d29sREdkMGViODVHNkxWbUxabTZUcnd6enEvRG95NlhaVmdYTThTRHV5djJt?=
 =?utf-8?B?RUtEemYxeVBpUWIrbkFOSHVwOFg5OS9PMDFBdFltZVdIUEcwdTBjZUd5aXZX?=
 =?utf-8?B?VGthd1ZLWUhMbHUxc3d3bWlldDMwSjZPamdYZ1QxdWY5QnhxdHdpZWZtS2xM?=
 =?utf-8?B?dXJiWEtza3o2aEJYOXJSeng0QkJHMytYRmF1dTFEZkdKQ1pCeG5wdkFXNnVG?=
 =?utf-8?B?am91bUFXczQ3TjJMNnNjNjNPZzl3T2RxWFVSdkN3aTN6aVJuQ09QdmRhUjVO?=
 =?utf-8?B?TUI3SUdmZ2hDRUY3eHB6RG8vMGVhUm5OUTRuY0x6eDFjdU4zMHRTTzVuazVV?=
 =?utf-8?B?bWFkRGxvRWxqd2NhVzdRUCtwQy9lUm9qVkhVYlY0cUpqZERDRHlFR3hSejV3?=
 =?utf-8?B?dzlXUDNkdnFQTjBrUVV6VWlRTjY3UXpOTDBFQ1NrRWMwbnE1eHhqVFEzVVkr?=
 =?utf-8?B?SWhYTWIxeklpMWh1OERNWE1ucnhUcTVnYlpTVE0vQi9vZHh5NmVsSnViVlhU?=
 =?utf-8?B?U3Jsb0VRQW8rdGh2ZE5iWnZwNGZIWjBnek1lcjAzcllaa3NkZ3BVS2V6enRC?=
 =?utf-8?B?a2puVyt4elU2SHplQWc0MlZSQ28rNVY5cFhyM1V4QlZIVU5KSnZqRlRFQTh5?=
 =?utf-8?B?TTFlaSsyQnZqQUpYczhyQytTeGxISUM4dmZrV1N5eVQyOExVeC83RzFaZk5v?=
 =?utf-8?B?SzNRQ0J2eG96MUxRb00zQndEckVVajJ0RE1OemF2NnNkMmt4WTlTR3oxNis1?=
 =?utf-8?B?MUFobk4vbU92cEtJRitVcDdBZGpSTlAvblpBc1FZWW9pd05zdm5SUzJyRG1u?=
 =?utf-8?B?ekkvaVJDVlJpdTNGM2hSQ3N0L1A3QzhndTBnVTNqODNoUFRlQTcyYy9FSElW?=
 =?utf-8?B?VzY1aDBUS095QnYzZmo2bXdmMHNZWDJpMXdidE5Xd3NwWkhiQVUySEJVSm1h?=
 =?utf-8?B?ZXIrcDRXbXJoV2dnZXVkaG15RzdXd0Z2MUdWeGV1Z0NaM1pxTFZvN3RJTVFi?=
 =?utf-8?B?dGlPMnFRQ0FMc0ovc0doaStkQ2NjcG9BMUVVMGFSWWpWb3hlWjcxYkJHcEQr?=
 =?utf-8?B?Q0VqZmM5WlgvZEFIT3hVUDBHQjJCRzlSakRQNlJ4bWJQTkFuTU91VStiUVZj?=
 =?utf-8?B?OVJKQTRDNUtzOXNUVVQwVEFzRC95cEhNVEF1S2liQ1kvVzB4QksxZkJ4QWpS?=
 =?utf-8?B?dDEvd1ludk1IelJoSzR1L2YyYTVka0lXQm9EZEZia3E3bnFicTNPbkFkRG5v?=
 =?utf-8?B?VkFGOHZSMXE5dENQNW5pbDhES3h4aG1ML3pUTFBUY1NrcGRodEN6VHhnWDdM?=
 =?utf-8?B?T0o4SE9iaFdZRmdDNHI3MTRmc1ZzcGhGNHRjc3BJb202RGs1Q2RoTm8zWDY4?=
 =?utf-8?B?OWxnVXRNVmdPSEJMZTJhU1g1akdWNUJ5bzhoRkJ4cGIrOTlFbHpnTE5uSzRy?=
 =?utf-8?B?VWlycVVvajhKNlJYTThpKzZnZThCU1pDNTBRanVScldCdGZpUzR4WVJZcUt5?=
 =?utf-8?B?YkpjOFZJbGZPaFN4eElxTGlYQXJSbzY4OHROaE94STdIVWhpWHl1OGlDSnhu?=
 =?utf-8?B?cG1vTjVoWk96UlY1cGUwTlRsV0s4VHkycmZweDRONlNadW9uQ3A5YStqak9s?=
 =?utf-8?B?V2pJN1Z6SlgySUp5Z25va0FxWlh0VmtSTmVvd2lTRGY3WkRIUHBXb0NEYkZ2?=
 =?utf-8?B?ZlQ2enkzNElXSFUzRTl2aWxKMkMyWFJ4M09WNVlwSHpoaTlsaGY2VlZrc2tp?=
 =?utf-8?B?aEVtOWtaUXFzdHJEejZndmgwRkJDY3dMK2lsVnBNaHhsYzAyZFNCVytmSm1j?=
 =?utf-8?Q?6+//OQUvQfqzcnsShmVbVs4Mz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcea577-3e0e-4d37-73b9-08dce905654f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 08:27:36.6142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lb0JKgIHQwqQiXvuzJBqxxBXScaQf1zyHzgFJe/IMuuu270WLg/O9hjScvxWmD3TDjLPUEldEs3CiQXcbCGNQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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


On 10/10/2024 1:37 PM, Khatri, Sunil wrote:
>
> On 10/10/2024 1:13 PM, Christian König wrote:
>> Am 09.10.24 um 16:24 schrieb Sunil Khatri:
>>> Before making a function call to suspend, validate
>>> the function pointer like we do in sw_init.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 15 ++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 26 
>>> ++++++++++++---------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 12 ++++++----
>>>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 15 ++++++------
>>>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 15 ++++++------
>>>   5 files changed, 46 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c 
>>> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>> index c1ff24335a0c..e55d680d95ce 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>> @@ -85,13 +85,14 @@ static int aldebaran_mode2_suspend_ip(struct 
>>> amdgpu_device *adev)
>>>                     AMD_IP_BLOCK_TYPE_SDMA))
>>>               continue;
>>>   -        r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -
>>> -        if (r) {
>>> -            dev_err(adev->dev,
>>> -                "suspend of IP block <%s> failed %d\n",
>>> - adev->ip_blocks[i].version->funcs->name, r);
>>> -            return r;
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            if (r) {
>>> +                dev_err(adev->dev,
>>> +                    "suspend of IP block <%s> failed %d\n",
>>> + adev->ip_blocks[i].version->funcs->name, r);
>>> +                return r;
>>> +            }
>>
>> I think we should probably create a function for that code and error 
>> message repeated a number of times. Same for the resume function.
>
> Common static inline functions only for suspend and resume sounds good ??
Each of the functions where error message is logged are in different 
files and having no commons. Also its just one like print and i think 
its ok and rather avoid calling a separate function for just one line.

Even if i decide to create a dedication function it will be in either of 
andgpu_ring.h or amdgpu_reset.h    or amdgpu_job.h only which right now 
holds information specific to the header only.

what your suggestion here ?

>
> Regards
>
> Sunil khatri
>
>>
>> Apart from that the whole set looks good to me.
>>
>> Regards,
>> Christian.
>>
>>>           }
>>>             adev->ip_blocks[i].status.hw = false;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 340141a74c12..51607ac8adb9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3471,12 +3471,14 @@ static int 
>>> amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>>               continue;
>>>             /* XXX handle errors */
>>> -        r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -        /* XXX handle errors */
>>> -        if (r) {
>>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>> - adev->ip_blocks[i].version->funcs->name, r);
>>> -            return r;
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            /* XXX handle errors */
>>> +            if (r) {
>>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>> + adev->ip_blocks[i].version->funcs->name, r);
>>> +                return r;
>>> +            }
>>>           }
>>>             adev->ip_blocks[i].status.hw = false;
>>> @@ -3553,11 +3555,13 @@ static int 
>>> amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>>               continue;
>>>             /* XXX handle errors */
>>> -        r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -        /* XXX handle errors */
>>> -        if (r) {
>>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>> - adev->ip_blocks[i].version->funcs->name, r);
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            /* XXX handle errors */
>>> +            if (r) {
>>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>> + adev->ip_blocks[i].version->funcs->name, r);
>>> +            }
>>>           }
>>>           adev->ip_blocks[i].status.hw = false;
>>>           /* handle putting the SMC in the appropriate state */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> index 3e2724590dbf..6bc75aa1c3b1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> @@ -40,11 +40,13 @@ static int 
>>> amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>>>               continue;
>>>             /* XXX handle errors */
>>> -        r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -        /* XXX handle errors */
>>> -        if (r) {
>>> -            dev_err(adev->dev, "suspend of IP block <%s> failed %d",
>>> - adev->ip_blocks[i].version->funcs->name, r);
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            /* XXX handle errors */
>>> +            if (r) {
>>> +                dev_err(adev->dev, "suspend of IP block <%s> failed 
>>> %d",
>>> + adev->ip_blocks[i].version->funcs->name, r);
>>> +            }
>>>           }
>>>           adev->ip_blocks[i].status.hw = false;
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>> index 475b7df3a908..10dece12509f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>> @@ -81,13 +81,14 @@ static int 
>>> sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
>>>                     AMD_IP_BLOCK_TYPE_SDMA))
>>>               continue;
>>>   -        r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -
>>> -        if (r) {
>>> -            dev_err(adev->dev,
>>> -                "suspend of IP block <%s> failed %d\n",
>>> - adev->ip_blocks[i].version->funcs->name, r);
>>> -            return r;
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            if (r) {
>>> +                dev_err(adev->dev,
>>> +                    "suspend of IP block <%s> failed %d\n",
>>> + adev->ip_blocks[i].version->funcs->name, r);
>>> +                return r;
>>> +            }
>>>           }
>>>           adev->ip_blocks[i].status.hw = false;
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c 
>>> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>> index 5ea9090b5040..ab049f0b4d39 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>> @@ -80,13 +80,14 @@ static int smu_v13_0_10_mode2_suspend_ip(struct 
>>> amdgpu_device *adev)
>>>                     AMD_IP_BLOCK_TYPE_MES))
>>>               continue;
>>>   -        r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> -
>>> -        if (r) {
>>> -            dev_err(adev->dev,
>>> -                "suspend of IP block <%s> failed %d\n",
>>> - adev->ip_blocks[i].version->funcs->name, r);
>>> -            return r;
>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>> +            r = 
>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>> +            if (r) {
>>> +                dev_err(adev->dev,
>>> +                    "suspend of IP block <%s> failed %d\n",
>>> + adev->ip_blocks[i].version->funcs->name, r);
>>> +                return r;
>>> +            }
>>>           }
>>>           adev->ip_blocks[i].status.hw = false;
>>>       }
>>
