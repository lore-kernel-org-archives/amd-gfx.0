Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCDACEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 15:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50FC10E3EE;
	Mon, 17 Nov 2025 15:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JzvXpdFc";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0450B10E3E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 15:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQtiw8UYA4niobp7haJIPXKK/Fga9PSoXSKvOp2/totWUJ02FjaO1A4ERHUuHTUth8CowULabWhIhPn+MDq2nqBQYQ5+XSTUTR9n2puM0O8bwrZ3kv/gxtl55ESCZMjzMGnyo0WFJU2kU9rFHPV9w4boNrh73sjca6MV6S39tpmMewV6pLKf4kUsCFQ15ooMrD5wQOWRF9Afm1MKh+aa5NMuWlYgklLx1WELz1MmEJ9pqBMJSnRlHpUn4+65lD53wgY+PvMV6eq4vFEoZi8JPPY82e2Yv14NA3in8Jv9P1ifRUxxLgPKGcks2dNztNMKsZV1Oy3eD5ENYk5MHYIcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcV6kgSTO6zuR6tmwwtCHlU4lKKU+zSrNninjw0cM0Y=;
 b=DEpULRWONkm1f2Qsop2GqkYgmH8hVMFd8YtpHsUl75etkpVzljre1FfRzl6QcncyexvrtPVZGkpc7yRy3/ndPL30ImQNCzgXImi/btEUvYZG2AQpUck3JQUX6ZeizX99tMfYyDU5xudIcVCBYD1qHqqqoRl/2GZ7HLvzVYDV3Erq/z2Mf2wOMXXO/oWLZrEJBoZTej5MWZFwvDhbipx27L/8LJ5WAC+V+oGJOkYKyuuw+fTvVlxxM9+pdpaTaXNQzkrgy6RiecGbyqgpYmlifTTvwjkLyejwyYKehhkk5wwJjONw87sozsPp4iEvzV8kJPNCmMUtP5CeOn8DYtl5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcV6kgSTO6zuR6tmwwtCHlU4lKKU+zSrNninjw0cM0Y=;
 b=JzvXpdFciJQEXdXl8phfmHQIR62E9KRA336f30VA8g5dU2f1bIVFBtzVwYADUSlzw9Y+6HT7z6hDqav/gfUpl/tcJvvuL7Oe7XgWFtwR1YHsfMUtCV8MkDhrCnX5EzCxItDf0GtzjhFgzJ1XOkwbyvF/WlOzIoPEoV/RtC2/v78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 15:50:31 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:50:31 +0000
Message-ID: <262258a0-6568-4fc6-8b16-1a22d47b039f@amd.com>
Date: Mon, 17 Nov 2025 09:50:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Use huge page size to check split svm
 range alignment
To: "Kuehling, Felix" <felix.kuehling@amd.com>, Philip Yang <yangp@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251113210955.352373-1-xiaogang.chen@amd.com>
 <c87b788f-65a6-468d-b100-2295eb284489@amd.com>
 <1421dbc3-c800-330a-2b30-3a359b9ef9af@amd.com>
 <e1b5e4f3-d2b4-4c96-820d-56144b5a7934@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <e1b5e4f3-d2b4-4c96-820d-56144b5a7934@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:806:130::16) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a1ab46-e549-45bc-b13e-08de25f109a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejZQRlZxRWlTNzVBd255enU1NFVqQ3Vva2JVcWJSUnRMMlF4YU50UVQ1VUxF?=
 =?utf-8?B?bDNTSk1kckhJWmIreGFGTFJPamRNd2RLajBzSW1aUEZyblc5SDRCZmk2WmRi?=
 =?utf-8?B?Y0I4d3pQdElabytjUUc1eFhmT2pjL2xJVmpnVmFsOWEvMWVUOFNwZmpzbWhO?=
 =?utf-8?B?VXVubkk2QXB6Q0IzdURkVDZZbjNwYVliMGZZN0xkVnFSREgxdDVEL2FjYnk2?=
 =?utf-8?B?QUZpK3JtbGh1Q1ppcnJ4YmdjRmNGQVppYW5ZcEVqcCtPU2NZMWRqR2V0T0t6?=
 =?utf-8?B?cDZqdkxtR1lVZUNwOUdtUC9mVDBVb2t3WFJVdHozQXhubHlIVmxEc2ttcklk?=
 =?utf-8?B?dnJDTTVEUnRJUlhxT2xIemlZMWZCdHBKWldpSlVtVHQvRHI4YVdyRHE3WWR2?=
 =?utf-8?B?UTRFeXk1b1NNdEYrT0tDSXRTQUJjMTlXUnQ3enZ4UG4vd1hmZlgvQ1NLUlJs?=
 =?utf-8?B?QU83UVhYYW9KZ1JiQVVIUERzSlRiZmQzTFh6d2xBNHo5ZmlLV3h5Yk1HM2Qw?=
 =?utf-8?B?K2c4SmVKUHlzLzNXL2NiME5qd25XOFUxVTJyYTZLU2JueWtPUWoyb0QxYlBp?=
 =?utf-8?B?aEhtUGdCb0RPVXJnbmdXUnc4SWM3TUJ0MDVmWGY2MkwrQmR2b1lGb0RlL2J4?=
 =?utf-8?B?ckZ4QU5VSUtrN3huVkJSejlEakQrb1RSMHZEOE1hMlZpQ3NlTVFnNTF5MlRC?=
 =?utf-8?B?OHFXb0Y5OXFER1c1S1kwSU9uVE9PVWJFQ2FXc210ZEwweW5DT1owQ3RxdkJN?=
 =?utf-8?B?TjZTS2hsMHVZOWRrRjB2akV1ampTcHhNWlJyRTY4VXpGZ2J1MDc2cExPeU4w?=
 =?utf-8?B?MzNtQUlDajJOK3dwczVNMFEvR2lxVzQ3ZmxCMmRYZU9CaE9PNWNaRW9IMzNi?=
 =?utf-8?B?QmpSOW5CbzNPRFBvYmlwTHRjMG53N0ovS2dFMzhCUGx3ZUlMeTRZK3FNL3dY?=
 =?utf-8?B?MjFWYXM1dlBKcUp1V0thUWpRUmE1Rm1pMXczQ04vRXpESXlvYzVHTzRBbk12?=
 =?utf-8?B?bjNkczlTdDZCeUdDd0FlUkVzcjRvZHNSUE4vWEVSMS9ZTlp4ZGZyUnYvaU5v?=
 =?utf-8?B?SVFIRmFybVkvNTFKajZGSFd4MlZKRnRzU3VIeUJjVy9IR1BBWXZrMGgvcmxI?=
 =?utf-8?B?YWFDVjFFamZvMmEwdmozYTcyK1NQUjJrTkgrMkFWeXJPTGJ5Rm1Xd2V3UTBV?=
 =?utf-8?B?SW8wZTdiQzFQYmhCcHVBZm5rdnpHbHdDVmZtR0w2cGNib2VEcldJb1JEVklQ?=
 =?utf-8?B?V0lJakVOK3hHV3lCdXFrQ1dVZ3NxUnlVbWVobWdqOTN6aXhFY0ROcWwxeWgz?=
 =?utf-8?B?NTQvcWo3VS80bnJ3c2hBQ1NjMXlFZlArcG1kVG9hQ3hKL21IcmFoUmdDZkU3?=
 =?utf-8?B?cWgya1RRRlIrUXd4d3NybThMNTB0b1lmSkplZGhYTTdFZnFqRmFDb0c1RVow?=
 =?utf-8?B?QmdDWWQ3dlVoNmxIeXJSVEhMMUtxRUpYTzE1R1p6UDkxa0VrcVBRVmdzbnNp?=
 =?utf-8?B?M2tlOCtoeklUOW4xWE90Q0RsdytZRXNpa1kxZWsvck5ZS0pLRGJneElGM005?=
 =?utf-8?B?Q2FmZ2xhNjg4dlR1VENvUEFGWEJIakFWb0djWEx1dmJlWEJsWnNGUXNNaDlE?=
 =?utf-8?B?ZFcvSk9IY3M1VStUcXJ5MFpnckE3Q2xJOFA2MGRHUTBrY0tKR250WXljNmdw?=
 =?utf-8?B?R3FWK1FzR1pmQXhRVU1BNHdKOHFKNHR0UHFFM21idm9lcnc4bGloQ1BzYlNZ?=
 =?utf-8?B?Yy9HVkNFcVI2SjNRWmJPVFFnQzBjS1M4blN0VDUvVEozc3lUaWd2bExmbmNx?=
 =?utf-8?B?YWJ0b1Y5L1FZS3NRUFh1SjNUcmNZdUEydzAwVVBNblVQSVNSS2pUK0FwYmha?=
 =?utf-8?B?TUZGc3M5TmQrcE9xNTg0ZFY4QjE4ZVJQdWRZQlBBVVVKaDlrSDRFQi8zMGx0?=
 =?utf-8?Q?pD6KFdVr1LqPxTkPyefffLmnVTs37Ouq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akE5Z3hYVEFtS0hoYnZEbEdVTTJOTFYwR3VSUnJyWGg0RTNFWnM0VG9kM1Rs?=
 =?utf-8?B?cDdwd0Q2aW03OFJtWDZXeGhWcGRPRk81NzdwNmF2UXVhMjhucUhuZXp5NnFJ?=
 =?utf-8?B?cW4zM3NQRForS0hURU5IbHJhb2hXOHdhME5aODJKKzU5MFRjTUs4NDc2VzF5?=
 =?utf-8?B?TkE1VWk4UkpCZmNlQXY1UDNhUG5MTE1QdEdGZ1BOTTVtL0w4cEhYVUc0MWlT?=
 =?utf-8?B?d3FiSTFOWGJYUmJuUVIvRC8xSGR3Uld3ZHdTY1E3S05XMVBrSXJnaC84MDZD?=
 =?utf-8?B?bFFWcStrUFovT3dJeitycHZhNm0zTGFQMkN2eXlYejdaa21uNlN6TVhUbzkx?=
 =?utf-8?B?TlN0dXZ5KzZQcUYyMURLdVZYWGFRNUU0YTZ2dGpleHR4SVZWbkRCckd5MjlO?=
 =?utf-8?B?c0hYcWdCbVBTK09UMFRnR1hoamZ3RlhrZ3FNQTJVNk1WR3AvV0NYNFVJMVJH?=
 =?utf-8?B?Y0lDK2wyZDdmMVAvc3psT2F6Sk1yM1RhWUkxeEo4SC9UUFpTM2NibytrN3Iv?=
 =?utf-8?B?TlY5L0I4N1hlK1NXOTc2eTllenNWY29kWkVUemxxSUxlc3V1NlRKUjYrS3hC?=
 =?utf-8?B?SElSNitMZ1VObFEwNEwrRTZ3Z1NkL1UwazJXVGJlVFJSRVM5Q29uaVFYaTZx?=
 =?utf-8?B?R2tyUkRpdTdnOHg3ditLSTl0YWFqRUFaR2FnU0g1Vnk2S3JxWXVqN3oxZFJm?=
 =?utf-8?B?cHpzeWRJMEUzU0V4RGtwYjRBdmpIVmxJUkRDMVljcWkySFhGL0RCZ09hWTN1?=
 =?utf-8?B?ZDc3VjltUGROdTRzeWczY01BSHNNdmJ6M2xlMDR5TW1NSzExOG9YZkxkRy9N?=
 =?utf-8?B?ZEh3VyttcnVxMHJXWVFES0QvZm56NTRFV0hCNzNBUXJTVHJqVTdYYTdUMVJt?=
 =?utf-8?B?OGtmZTcvYmVTVUpQUXdPTkZSWXplcld6WHBaaDcrQVVVTUtMbUNiMTZxYitq?=
 =?utf-8?B?YWhHSitVRGF6RFJZcG9Kc1VxS3ZzMHZFeko5RlZRTkpKdjZDVER6V3FBU1gz?=
 =?utf-8?B?ZmpYZFc4Rnd1dnd5Yy9wRnBsSlJSZmlZZkh1clFhZythUHVQSVBCZlNYWmxp?=
 =?utf-8?B?emlicHIyRmhGdTdJbzZSaEE5U1BSSkUyWnFKV0NiTWM1VjhGMy9aSmt6Y25m?=
 =?utf-8?B?NWpGeFBXU0tQS1luVXVEYnlKTDJOUVVIUUwxVitqdG01RlViZGt0Yi9MYU10?=
 =?utf-8?B?S0djN1VsWVRYR3NOV2xoWW5xTU9IdEl4VUJNMEo5bm9QUTFtcExjbHZxL0NL?=
 =?utf-8?B?Z2FxTkJUVGhrOXc5Z0w0N1VCMG1lT2diZFVVVGRXMlJ5R3piQURYMmlzYjhr?=
 =?utf-8?B?K0FlcU44UnU2dzdJQlhsS2pkY0wvVUZHY3h4b3VJbzZuU25hTVhyeGo2OXIv?=
 =?utf-8?B?cUp0NEFQRnVLTGl5U2U0WWlZa3MxYlArWi92OHZsREx2L3Z5TmVqaGVsS1Zr?=
 =?utf-8?B?MjIySW81aUFiL0l2K1RNRVU0WUtTZzdnWkhKTndmdlZVaC9MSkxBQ2NYa09Y?=
 =?utf-8?B?Q3BQSlRNclJ3eG9jSXdCMkh2YXdMVG1idFZBQ1FDN3dmckpvNjVQYy9KU3ph?=
 =?utf-8?B?QjB3ekxvSlVmcFJJdHJUNWd2ZWtvd3lTays3VGJnTmVjN0hzSDhEZThwaGl1?=
 =?utf-8?B?eDV3N1B3bFRUbUZCcjl1YUt1VXR6ZVRyMUFXWXNiWTUzVnpIY3ZMVTh3KzRS?=
 =?utf-8?B?QzhMK2RLbXhCOGdiUVNscjRUOFNwdTF5dHNORmRobUx1Z0NQdGdOa1hQR2Nk?=
 =?utf-8?B?NHBTdlFqaUZFKzhDbGNsMXVLdnFyYmExaURrNkpwcS9CV09SNkszQk5SSUpO?=
 =?utf-8?B?Lzdxc1N6L0p3ck5wNE9Ub2YwdkRHMWZCeVdqeDRKa0wyZnVPcVkxVnlwU0lR?=
 =?utf-8?B?ZWVlNkFIMDJZRXVwVTdGRENhNkQvcS9Pc2VhblZQdG5NZEMxWGxnSG9OTkJC?=
 =?utf-8?B?SVhYdDJsWE0rc3BGQVFpYzFSK0tHdDdIQUlqL0RxQitJRDJIdjJIM0trZmxu?=
 =?utf-8?B?d0t2ZnFXOGR0NU1PTGpsTmtsVHdNV0E3enZWR3V6SERlUGJ2ZDZSdWpCV2FI?=
 =?utf-8?B?TDBGbDErbERXcEQvdWQ4QnNEOEVkVjZWSVBkaUVKUlhQSWdHaEpkMURtWTha?=
 =?utf-8?Q?3elA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a1ab46-e549-45bc-b13e-08de25f109a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:50:31.3866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZWmRn4Nh92L/dyQJ10ldqjytgcBk/e1f/S8DurlWHsfojXo1E5xY4tG6cmqAeZO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
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


On 11/17/2025 9:06 AM, Kuehling, Felix wrote:
> On 2025-11-17 10:00, Philip Yang wrote:
>>
>> On 2025-11-14 18:26, Felix Kuehling wrote:
>>>
>>> On 2025-11-13 16:09, Xiaogang.Chen wrote:
>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>
>>>> Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that 
>>>> have split)
>>>>
>>>> When split svm ranges that have been mapped using huge page should 
>>>> use huge
>>>> page size(2MB) to check split range alignment, not 
>>>> prange->granularity that
>>>> means migration granularity.
>>>>
>>>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 16 ++++++++++++----
>>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 521c14c7a789..c60d8134db45 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -1146,11 +1146,14 @@ svm_range_split_tail(struct svm_range 
>>>> *prange, uint64_t new_last,
>>>>   {
>>>>       struct svm_range *tail = NULL;
>>>>       int r = svm_range_split(prange, prange->start, new_last, &tail);
>>>> +    bool huge_page_mapping = IS_ALIGNED(prange->start, 512);
>>>
>>> Instead of hard-coding 512 here, it would be more future-proof to 
>>> call amdgpu_vm_pt_num_entries(adev, AMDGPU_VM_PDB0). That's 
>>> currently a static function in amdgpu_vm_pt.c. Christian, would you 
>>> object to making that non-static?
>>
>> We don't have method to know if prange has huge page mapping which 
>> depends on virtual address 2MB align and physical address contiguous, 
>> it is decided inside amdgpu_vm_ptes_update. Even prange->start is not 
>> 2MB align, prange could have huge page mapping.
>
> Right, I guess the correct condition would check that the range 
> contains at least one potential huge page. I.e., the start address 
> aligned up to 2MB is larger and the end address aligned down to 2MB. 
> And the unaligned split is between those two aligned addresses.
>
If prange->start is not 2MB aligned amdgpu_vm_ptes_update will use 2MB 
fragments for the aligned middle portion of the range if possible, 
starting sub-range and ending sub-range of prange are not 2MB huge page 
mapped.

I think the checking is on start address of split range that it is not 
aligned and whole split range is inside 2MB aligned part of prange(from 
down aligned of split start address to end of split range is inside prange).

Regards

Xiaogang


>   Felix
>
>
>>
>> Regards,
>>
>> Philip
>>
>>>
>>> Also, to improve the check whether the range can really use huge 
>>> pages, you could add a check that it's size is at least 512 pages.
>>
>>>
>>>
>>>>         if (!r) {
>>>>           list_add(&tail->list, insert_list);
>>>> -        if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
>>>> -            list_add(&tail->update_list, remap_list);
>>>> +        if (huge_page_mapping) {
>>>> +            if (!IS_ALIGNED(tail->start, 512))
>>>
>>> Make that one condition: if (huge_page_mapping && !IS_ALIGNED...)
>>>
>>>
>>>> + list_add(&tail->update_list, remap_list);
>>>> +        }
>>>>       }
>>>>       return r;
>>>>   }
>>>> @@ -1162,11 +1165,16 @@ svm_range_split_head(struct svm_range 
>>>> *prange, uint64_t new_start,
>>>>       struct svm_range *head = NULL;
>>>>       int r = svm_range_split(prange, new_start, prange->last, &head);
>>>>   +    bool huge_page_mapping = IS_ALIGNED(prange->start, 512);
>>>
>>> Why the blank line before huge_page_mapping? It's part of your 
>>> variable declarations.
>>>
>>>
>>>> +
>>>>       if (!r) {
>>>>           list_add(&head->list, insert_list);
>>>> -        if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
>>>> -            list_add(&head->update_list, remap_list);
>>>> +        if (huge_page_mapping) {
>>>> +            if (!IS_ALIGNED(prange->start, 512))
>>>
>>> Same as above.
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> + list_add(&head->update_list, remap_list);
>>>> +        }
>>>>       }
>>>> +
>>>>       return r;
>>>>   }
