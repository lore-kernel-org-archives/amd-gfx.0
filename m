Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57630C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 10:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFFAB10E415;
	Mon,  7 Apr 2025 10:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FbR7TTiv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4DFB10E061
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 10:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6m2vrw0UYUNjDoX4HhLUbxGXiBGg7KrPCD7MoqyGNTbuO2IJZzWHQJo2JQhiZICHl6ZgIQHB0XumpJPW9cfE+GV7dHHxNxGYU2IiNOhOL53qEzrotxQ+AtqZmEl95pSi0iSswKbC3vUJDMn1GeNpx/VLsTM05jRmcyOwzQunxY74DcJo2tN0nB0YmKk2X7A89EVPORrrd/n1JInrbsOTJ/ZKqb9FNgzffUQATA2Yxwv9LPZ2ALgaOR1i2LCZYKUSiwXcUw1KzyDALLgbmwWr39o9w3v6ktuv50kf2PdEMy5FV7W92E9oJSPShfwb82y91ZD73o/sQaihVt0FPO4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orAI2Mjun+lDHch54t6IYidG0jgoq1hwFPzwrWOUYs4=;
 b=eLveKhYfwE1nKeMAz9tKh2/zsnjiv+iDKJm5ldZWIxF8DUZUO2uwMxZjYMJxzkNyZNBgC2gcq/8NjMCOp7ZTuYjjzhbFIniRQmPAtUKW4uvP3sGDGdTfPoaXWhyJSh1yJbIY2LeZXHqXoji1yJwEYMhTLTBwfji2TUoW0RRiqBDK4oxf2WaNecoF77ceiB+v8rFfEjRFsWzp42UARqVgcchuMUPfqWk0c2qHsnw+qUQAdMoGtedtklK3UgQQe2QqtcrNPbZhlla7Sc8E2opJV1LiOQ/f9F2+aRDY5y22mUSx85I9u9IbFkzfzGr43J2UWutNV4EnVlZY/T5CKe/A4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orAI2Mjun+lDHch54t6IYidG0jgoq1hwFPzwrWOUYs4=;
 b=FbR7TTivmozP3kzcXy7r5XxBfmhgH2o3akLaKh/LUENhPhW2GD/VA2OOBPTtup3pOO0nCfhVvySFumRDmF/TRMkIREy8k+sp8/NHweAbgTO2FNfNj0LXBumLD96IblyThQxRbUI8IjbvzJ7l4B/i4KCznBlxM2xL7jP28FHCJrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 10:14:34 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 10:14:34 +0000
Content-Type: multipart/alternative;
 boundary="------------5qOgsglKpEL4mBMIwT0k0vP5"
Message-ID: <04635121-c8ca-42ba-a56b-20357702c929@amd.com>
Date: Mon, 7 Apr 2025 15:44:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx9: dump full CP packet header FIFOs
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250320165634.1245798-1-alexander.deucher@amd.com>
 <CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com>
X-ClientProxiedBy: PN4P287CA0125.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 9548d660-7122-439a-8e2d-08dd75bcfe72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHNiOHM0WFlQek9sV0dPSDJodmVjZFQ5VVA1eFV3dG9zemxJK0Z5ZDlOVlZI?=
 =?utf-8?B?UktxSUNaY29VMng3NUFmeEdlTHJJNUlDN1JlekVXSC9CVGI1MjdGcEpPc3pw?=
 =?utf-8?B?aS9xdGg0VnkzaFN4WVV0Wm0vT1p2b0JHWlZuR3pGcEZXMTladkg4RjRYS1Vp?=
 =?utf-8?B?WklIN2ZDSWZ0amE4QmtMZUFNcUNGR3l2L1c1MU1wWmQyUU9yRjIvcGNnZjVm?=
 =?utf-8?B?ckVSWmExRy95cm9pS25NUVNsVmtpZTVObnc1aTE1UmpkY3RUdDhMeUxSRVNC?=
 =?utf-8?B?OWVuU1U1R21wcFZadHJoRno5ODhaV2ZVRFNyajVybVRhRGd0ZlNSR3NybXU5?=
 =?utf-8?B?TjcvbVRoajZnaDIyTnVVVEtHQkg4K0tSd3g3dDdDYjgvVkNRaXovK2FwWDk4?=
 =?utf-8?B?eElRVnJiZHgvRUxZZVNuZk45STZNRnFoVHRjL3lib0Z5MVVYakZ5MnNNblRS?=
 =?utf-8?B?OWZEZThHOHRWRzJKWmJwU3JzWjZEbTJXME92ZTZmV1Y2MTlrSytmNGdwK2hG?=
 =?utf-8?B?c25wNlUybnFFRnBlWHhjR3QxMVFZZ0UxelhQMEE3ZXVKRjZDL1M4L0pQV2Vv?=
 =?utf-8?B?NHBFNDcwN1d3NmN1NmxGSnZjRnM3M3JGbVhEZE1ITUh3dmhQWjI0Lzc5Mm45?=
 =?utf-8?B?Smx5dkQ4V3VRdDgrTGlnYS9HNE1CcVVmQk5STG0vOGZ0NDRYUlhWUFI1eWZ4?=
 =?utf-8?B?N1h0dUNXUERFSExQMi95TkJnb2VzMStrS2RIRGJzSWlNUjUrQS9xY0Z2NVh2?=
 =?utf-8?B?K2VFaElmMi9lZ1R1WmtvTWpBMmRMVVZiLzRxOWJwS2NrRDRBUjExaVRPbzFk?=
 =?utf-8?B?QVdUTTc4U0h1d1FJTkNtaW1WNjhndlB0Y3FLRlhzbFpYMUdYRmxPYUxpUWdj?=
 =?utf-8?B?TjRGRlZ6NEEvRGpkRk9wRzBXb0tKY1FWdWFBSC83azM2UFY5dHJRRmpWRHBl?=
 =?utf-8?B?a1EyUEZuVUx1bTF3YmEyZldoWFNEL0p2S09VVld0UDRuU0E3eVNOVC9YNHd3?=
 =?utf-8?B?VkU1RXJPT2FUbExxamdhTFpZaVFqMi9FRWN0SVZiZ0c2VU5jdndpd01hVlFX?=
 =?utf-8?B?bFl1SlJ4d0xaWVU2MkJSaUgvYStkbWVhemFDcnJRS1dNNWdrYWhwWWtwS3Uw?=
 =?utf-8?B?cVJhbEJxcFF4dU5UaTl6RG50VUlzSGNYKzVTYkdVTGYzVGVqMWp3QzhIWmwv?=
 =?utf-8?B?RWJlWStyOXhET0FGOFF6WEhkTUxiSHZxeGZVR1VZNDJwVWxmVmJjUnRBQWtV?=
 =?utf-8?B?dmdUejljSzBQcy80R2NnMFA3b1RlOGk0dDk5em5sRXBRSjBZKzZ4Nld0STlQ?=
 =?utf-8?B?ZDlSK0lBZlpsdCtwc3RUbEE5dmxiMEswdGV6Y3poWlVDV3pjQ0JKQ0c5QlQy?=
 =?utf-8?B?c3E2TFppc3A2em1XeXNIZ0xUaVdBUW11VWxaVzRFMWMzS21ZQ3lVQ1doc1ZH?=
 =?utf-8?B?ZEswRy9IZGQ3bjJHbU1POXBPMm90Y0E4YjdabkxJS2ttUTdRcjdBUHJwa2E1?=
 =?utf-8?B?aEJGcVlUS00yOHl1TngwekVBSHIyMWczdmgrS3JFcEIzOUV2Q2pvUmhVWjdj?=
 =?utf-8?B?UUpLaEVCL1oyU2cxbnhwT080dUFEazltOHE4U1IxUG9aREN3eW5oSUZOc3M3?=
 =?utf-8?B?OHRnbXIzRGE0ZFE4ZTVBV0hJcjg4U21xMnJOWTNBc3d4UmFIS2ZvTVpnd0RG?=
 =?utf-8?B?OXhqd0NKM1FJbkIvODZjbTQ4K21JZ1QwK1U5b1JQalI1SmdpMnpBK0R6NUt0?=
 =?utf-8?B?YnlRVFA5Rjg2b2dubmpWV2NnMWx6TzMyMkVMM3RKcGFjeFVOL1pSVHpvYStS?=
 =?utf-8?B?dE1LcDRhejd2a0g4emI1eTRodEQ3WFZNTThFRFBDdVp0bFVRQWsxbTU5RFF6?=
 =?utf-8?Q?EpJf9uX2qYWtX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODJZanRKTVpEVEo0R05KbXpqbHpVdW1NQk9Ia2t2WVY3eTlBWWpRalJ6NVg0?=
 =?utf-8?B?YndZSHRSQ2FJdWxIQVNyZEQ0S2NLL0ZwZzdRY1RZRjRxUUM2WEQxOWZoYmIy?=
 =?utf-8?B?Uzg4Mk5VakZ1WGNUV096WmZ6RGpwalI2R3phMzNZVk5leDVFWVJSZXdINitG?=
 =?utf-8?B?RXIwSkp4UDN1Q294cTEzckJIUGtRZ3ZoU3cxMzZ5NHY2NzRLY2RNQW9seTU3?=
 =?utf-8?B?ZkFieVdudVdENit1ZFBHMnkyZnpNVjc3WlFvNWZJT2ovaDBLV290Q1NGdkF1?=
 =?utf-8?B?MnM3ek8zUUVWYU1LWVJFQ0xmQWMzd25iT3J1Qzk2bTRvV0J6MXhYbjcrSXVq?=
 =?utf-8?B?ei9KK2lKM2ZrMU9lUWM0TjdDMjAwTHZhc3NUcnozSkd4ZmtlUzJiaE5xeU9i?=
 =?utf-8?B?L0J4dC80eDRoZDRwSkU3UDF0aElyZ3orc09kcHMxcEdHSUltSFhMYi9saVdP?=
 =?utf-8?B?UEVTQ1dCQStXNXlEV2U0eVN2b1ZpbTlOSkNIcVV3OThCK1RUQmdMVGxGL3hT?=
 =?utf-8?B?U3E3dENQSGRuNmNlU2lnZ3NtbG45cUxnLy9qWGhmWTB5TW5EajV1WmFFdGto?=
 =?utf-8?B?VWJDM2ErTmZRcWJwM1lGc0JMNmx0V0F6YkxZaWI0WjU0TjdBelkxQkJlUDhY?=
 =?utf-8?B?ZE1KMEpHWFNEaGVERGhEZTNJM0RDNDlCbnppUDEzeU5UN2R0dlpYWVpTb2Jr?=
 =?utf-8?B?UVpkVlgvbk0vVFNBUkxrUnkwQUZucE00WHRkYkZ1SldOZG84RDZ3RFZka2xU?=
 =?utf-8?B?d1E2RUdmd1dITjNuVkw1a20xWmIxM0h0Y24wMnIrd2NDdFNDbE4xNEpFWXE3?=
 =?utf-8?B?NUhrQkxkQTJCSzk2dHY4bk9YdFVlWEZ3aFhtN1c5cmZ2VHh5b2FqeFJ5YjVp?=
 =?utf-8?B?ZERhUitmV0YwbDlGSFp3SDZ3OU9ybWsrNld5dGNlbC9DaDJUNU80UGFlMml4?=
 =?utf-8?B?SStoS2tvUFlrS0JwUllhazI3SlBVQ3FMRUF6Rk5oOE55bDZIUXh6SUVtU3Ny?=
 =?utf-8?B?bWNMTlI4TndyS1BOYXM4WE9zb0p3Yzc5cVJvZzg0anZSZ09RbGJBcThBK0tV?=
 =?utf-8?B?R2pQMlhudDZZbEhOVm1iZmNNZ0N6UHRCdzNzWUZSSTJnOHpORWR4aGczSmlD?=
 =?utf-8?B?eEVsSk9Hd3hjcTNoTWNQTlFtOEMxaUN1OE85MXo1SU92YUJDOHdVaXVYdGZD?=
 =?utf-8?B?ZE5yWm9BK1NJMVNGNkhqYkhWU2FzWkRraXVIczdEa0xabmhobUZZOHFiQkpw?=
 =?utf-8?B?eEtnbklJdStVKzh6T01jVHVDTTlydXc0U2pZV0xseGtZL0FEQng5QzRndzVN?=
 =?utf-8?B?cmE2MmxoNzVRY0pWR0FYZytHUkl6YTVJOXVlSFNwSUlPV0pHZnhpaG1wM01Y?=
 =?utf-8?B?SWtnVGNGZU9CaDFsVVk4ZUlwVm5HdGVuOVU0NUVtRTZ5K0dYQU9kTitEdkpu?=
 =?utf-8?B?M3ZvNU1rczE1b1oyaDRkN0szZjYycnFrbGNKWTFBL2UwNUJNYTVPYkpuME5L?=
 =?utf-8?B?M1ZaSitOOUFqTmU4U1JtYkRrWEtIdGZENTJ1Z2FLQkNxRU9PQnN0TmpDM2Fo?=
 =?utf-8?B?ZklWRWdqRkttaUx2TGZiUXhKenc4bWhkbjF6MkhUSkUrM3FCTkt1bTVPaHBj?=
 =?utf-8?B?T2hHY0NVSFNCeDNEZmxlb0dXYXNiU1N1WWRXZit5YWdQS0JQa1ZpK2Zja054?=
 =?utf-8?B?WG5jRC9OUXB3RW1qNXNUU3NEa04yOXhmejlqR0V5aGJsRWJ5cURndXhwZy9Z?=
 =?utf-8?B?aml5T3REdWlsVllBbHlqODEzSzFlaDlST05ZNE5ubXJDd2p5WjdwTFh1b0hk?=
 =?utf-8?B?Z2JrdVdsblhGOGNYRVVZVWRWU2pGUWYvajVRa1krMktTRm9xNXhObFo4NlVZ?=
 =?utf-8?B?SHBoSUVzMFpUbjRLbzk1RVdaUGE4U0prZ05ZMXhESkZTK3RodXVNMngxT283?=
 =?utf-8?B?dmsyOUptYnRJNlNKVGk5eGxSUnRzYVZSakxTaEJpMmo2eldQRmJURjREZFhE?=
 =?utf-8?B?Y0JWRDJ2ZDV3VTFiQWIxdFAycncwaVIxY1MzdVBCUHR3NnRycHRlb2p2dlBi?=
 =?utf-8?B?SGt0a3JXdDFUai9jQ2NjSDlkM2ViVlNjeThGTVZrbTZyR2dYMkVQVG5Qbk1Y?=
 =?utf-8?Q?RuGCvjg6DUimaTGOPGjP5uFwk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9548d660-7122-439a-8e2d-08dd75bcfe72
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 10:14:34.1017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsirFe2XFAgm3e5XBO3l07rMyv1Dqvx/DfAK6zd7A+cDnDrRpJjwKdHLS6Y9/pD4phoXoEvDar8Ow+8k6OqGUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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

--------------5qOgsglKpEL4mBMIwT0k0vP5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/25/2025 1:18 AM, Alex Deucher wrote:
> ping on this series?
>
> Alex
>
> On Thu, Mar 20, 2025 at 12:57 PM Alex Deucher<alexander.deucher@amd.com> wrote:
>> In dev core dump, dump the full header fifo for
>> each queue. Each FIFO has 8 entries.
>>
>> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 62 +++++++++++++++++++++------
>>   1 file changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index f4dfa1418b740..64342160ff7d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -225,17 +225,36 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9[] = {
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
>> -       /* cp header registers */
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>>          /* SE status registers */
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
>> +       /* packet headers */
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
Reading this register in a loop will give value of each queue or we are 
reading same register again and again ?
for(i=0; i<reg_count; i++)
adev->gfx.ip_dump_core[i] 
=RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_9[i])); With above loop arent 
we reading same offset again for

mmCP_CE_HEADER_DUMP,mmCP_PFP_HEADER_DUMP and mmCP_ME_HEADER_DUMP 8 times. How are we making sure we are reading from different queues ?

>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP)
>>   };
>>
>>   static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
>> @@ -277,6 +296,14 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GFX_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP)
>>   };
>>
>>   enum ta_ras_gfx_subblock {
>> @@ -7340,9 +7367,14 @@ static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer
>>                          for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
>>                                  drm_printf(p, "\nmec %d, pipe %d, queue %d\n", i, j, k);
>>                                  for (reg = 0; reg < reg_count; reg++) {
>> -                                       drm_printf(p, "%-50s \t 0x%08x\n",
>> -                                                  gc_cp_reg_list_9[reg].reg_name,
>> -                                                  adev->gfx.ip_dump_compute_queues[index + reg]);
>> +                                       if (i && gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
>> +                                               drm_printf(p, "%-50s \t 0x%08x\n",
>> +                                                          "mmCP_MEC_ME2_HEADER_DUMP",
>> +                                                          adev->gfx.ip_dump_compute_queues[index + reg]);
>> +                                       else
>> +                                               drm_printf(p, "%-50s \t 0x%08x\n",
>> +                                                          gc_cp_reg_list_9[reg].reg_name,
>> +                                                          adev->gfx.ip_dump_compute_queues[index + reg]);
>>                                  }
>>                                  index += reg_count;
>>                          }
>> @@ -7379,9 +7411,13 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block *ip_block)
>>                                  soc15_grbm_select(adev, 1 + i, j, k, 0, 0);
>>
>>                                  for (reg = 0; reg < reg_count; reg++) {
>> -                                       adev->gfx.ip_dump_compute_queues[index + reg] =
>> -                                               RREG32(SOC15_REG_ENTRY_OFFSET(
>> -                                                       gc_cp_reg_list_9[reg]));
>> +                                       if (i && gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
>> +                                               adev->gfx.ip_dump_compute_queues[index + reg] =
>> +                                                       RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME2_HEADER_DUMP));
>> +                                       else
>> +                                               adev->gfx.ip_dump_compute_queues[index + reg] =
>> +                                                       RREG32(SOC15_REG_ENTRY_OFFSET(
>> +                                                                      gc_cp_reg_list_9[reg]));
When value of (i != 0), arent we reading same register i.e 
mmCP_MEC_ME1_HEADER_DUMP 8 times, how are we making sure when we read it 
again its reading for another queue ?

Regards
Sunil Khatri
>>                                  }
>>                                  index += reg_count;
>>                          }
>> --
>> 2.49.0
>>
--------------5qOgsglKpEL4mBMIwT0k0vP5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/25/2025 1:18 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">ping on this series?

Alex

On Thu, Mar 20, 2025 at 12:57 PM Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
In dev core dump, dump the full header fifo for
each queue. Each FIFO has 8 entries.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 62 +++++++++++++++++++++------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f4dfa1418b740..64342160ff7d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -225,17 +225,36 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9[] = {
        SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
        SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
        SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
-       /* cp header registers */
-       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
-       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
-       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
-       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
-       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
        /* SE status registers */
        SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
        SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
        SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
-       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
+       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
+       /* packet headers */
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),</pre>
      </blockquote>
    </blockquote>
    Reading this register in a loop will give value of each queue or we
    are reading same register again and again ? <br>
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #c586c0;">for</span><span style="color: #cccccc;"> (</span><span style="color: #dcdcaa;">i</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">=</span><span style="color: #cccccc;"> </span><span style="color: #b5cea8;">0</span><span style="color: #cccccc;">; </span><span style="color: #dcdcaa;">i</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">&lt;</span><span style="color: #cccccc;"> </span><span style="color: #dcdcaa;">reg_count</span><span style="color: #cccccc;">; </span><span style="color: #dcdcaa;">i</span><span style="color: #d4d4d4;">++</span><span style="color: #cccccc;">)</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #9cdcfe;">adev</span><span s
 tyle="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">gfx</span><span style="color: #cccccc;">.</span><span style="color: #9cdcfe;">ip_dump_core</span><span style="color: #cccccc;">[</span><span style="color: #dcdcaa;">i</span><span style="color: #cccccc;">] </span><span style="color: #d4d4d4;">=</span><span style="color: #cccccc;"> </span><span style="color: #569cd6;">RREG32</span><span style="color: #cccccc;">(</span><span style="color: #569cd6;">SOC15_REG_ENTRY_OFFSET</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">gc_reg_list_9</span><span style="color: #cccccc;">[</span><span style="color: #dcdcaa;">i</span><span style="color: #cccccc;">]));
With above loop arent we reading same offset again for </span>
<pre wrap="" class="moz-quote-pre">mmCP_CE_HEADER_DUMP,mmCP_PFP_HEADER_DUMP and mmCP_ME_HEADER_DUMP 8 times. How are we making sure we are reading from different queues ? </pre></div></div>
    <blockquote type="cite" cite="mid:CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP)
 };

 static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
@@ -277,6 +296,14 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
        SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
        SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
        SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GFX_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP)
 };

 enum ta_ras_gfx_subblock {
@@ -7340,9 +7367,14 @@ static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer
                        for (k = 0; k &lt; adev-&gt;gfx.mec.num_queue_per_pipe; k++) {
                                drm_printf(p, &quot;\nmec %d, pipe %d, queue %d\n&quot;, i, j, k);
                                for (reg = 0; reg &lt; reg_count; reg++) {
-                                       drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;,
-                                                  gc_cp_reg_list_9[reg].reg_name,
-                                                  adev-&gt;gfx.ip_dump_compute_queues[index + reg]);
+                                       if (i &amp;&amp; gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
+                                               drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;,
+                                                          &quot;mmCP_MEC_ME2_HEADER_DUMP&quot;,
+                                                          adev-&gt;gfx.ip_dump_compute_queues[index + reg]);
+                                       else
+                                               drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;,
+                                                          gc_cp_reg_list_9[reg].reg_name,
+                                                          adev-&gt;gfx.ip_dump_compute_queues[index + reg]);
                                }
                                index += reg_count;
                        }
@@ -7379,9 +7411,13 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block *ip_block)
                                soc15_grbm_select(adev, 1 + i, j, k, 0, 0);

                                for (reg = 0; reg &lt; reg_count; reg++) {
-                                       adev-&gt;gfx.ip_dump_compute_queues[index + reg] =
-                                               RREG32(SOC15_REG_ENTRY_OFFSET(
-                                                       gc_cp_reg_list_9[reg]));
+                                       if (i &amp;&amp; gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
+                                               adev-&gt;gfx.ip_dump_compute_queues[index + reg] =
+                                                       RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME2_HEADER_DUMP));
+                                       else
+                                               adev-&gt;gfx.ip_dump_compute_queues[index + reg] =
+                                                       RREG32(SOC15_REG_ENTRY_OFFSET(
+                                                                      gc_cp_reg_list_9[reg]));</pre>
      </blockquote>
    </blockquote>
    When value of (i != 0), arent we reading same register i.e <span style="white-space: pre-wrap">mmCP_MEC_ME1_HEADER_DUMP</span> 8
    times, how are we making sure when we read it again its reading for
    another queue ? <br>
    <br>
    Regards<br>
    Sunil Khatri <br>
    <blockquote type="cite" cite="mid:CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
                                }
                                index += reg_count;
                        }
--
2.49.0

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------5qOgsglKpEL4mBMIwT0k0vP5--
