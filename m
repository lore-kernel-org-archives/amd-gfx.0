Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832A6C369D9
	for <amd-gfx@archiver.kernel.org>; Sat,  3 May 2025 12:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B6810E209;
	Sat,  3 May 2025 12:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qiWVXOzD";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B57C10E39F
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 May 2025 12:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i28hONKT7B5/VhMhesL0FVtlSkOLnslZHDJTGwQJhZSW3lwBlbgJOaGT0mRP89IsGwZMPHlupF/j+0umNyITL7omuUCist5ZDu9iNqrHXPlHWX3ueaEyKZh7tM0TmqHQC1aOUJbxnR12E/Z5YKafrJUFifFDoZBkWGl6QxdL68xTcvTY9fsR65wXXZuKFqGRnSsWe3bxdyHFRUWVpk6m9U2pDlT+u9pIly5iKRO7KDIYe3BXeAyFlAw1ECETyX70dXnbeRsin2LUqjnjjeTW57p2BzLJ2UB4OX+zVPZX3X9NnSf2U/RlDY/PwboBkl/v2Xd6q///E9hpGNIP6tO6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnwePc+vTWvSaZIczSbo+p8NITITWJb6m04VdoT3Tek=;
 b=oJKUsMrhASQwA8kgfSLwQzrW81ETvrrTCpNMb2U0R/DrXSluIUuGEtadJXM2hOfZQbhuRrJbI6wFPSpavNh9xUC3U99cOV+F/WcT9tBYsFeYX3iPQq3lXRdTg8mj80Xa1/hcZsWIg2CS06MDJ3ziMFCHovzLxygoec4KBLOM+6dHEVOWCHM8jADJ2AFJJk7Q9Y4mG88NwDsb9hnHrhyeuIOoHu2Q7I3YxPELcMjeQK/hBHm+WF6xsl5O4ZMcyISl1Z1TCa7sosyUmNNiKRSGbGTpjPOFSyGLndf7B261+5uGBAf0IA+9sh2DWLNp4xW5Bv/+fURAf10mK/+SYy1kUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnwePc+vTWvSaZIczSbo+p8NITITWJb6m04VdoT3Tek=;
 b=qiWVXOzDEIqcpCEs3iOPDwJQWlB4OJnsffKUlwfORgSzauytICp8eOGnUo4RT/STEdvfoZJgSPANJOaOpyXAEn2RCIlPCwsMnYDqBMrspaehMQH6HYHoxVh2rfjwDUUFoBFOotj3p9vj1tUVgMT+wyjP3Azn0cTKYfaupEOZ46w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Sat, 3 May
 2025 12:23:09 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.8699.021; Sat, 3 May 2025
 12:23:08 +0000
Message-ID: <70f66e11-7baa-4aed-ac88-f823305001e3@amd.com>
Date: Sat, 3 May 2025 17:53:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
To: John Olender <john.olender@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-2-john.olender@gmail.com>
 <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
 <2150d713-d9bf-400e-b51b-aee835431991@amd.com>
 <474bf7c1-f42a-4738-8ce0-24fced3b051c@gmail.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <474bf7c1-f42a-4738-8ce0-24fced3b051c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::17) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 780f438f-e0d6-49c7-6d84-08dd8a3d4305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUlzNFFvYlMrcEZyMW4vNEdrNWpjYnRkdUxWZmVvQURmQXE2VVRtWUVhSXB4?=
 =?utf-8?B?dU5zM2R0THRBZU4yb2x2Y051Yi9kKzV0YVIvaGhLOFJHRW80bi81K29tcm5Q?=
 =?utf-8?B?NEoxQ2RGYUx5UHRKOVVQazBsN1QycktDd2x3M0E4dkY2TjlOR0VETVVLWXVz?=
 =?utf-8?B?VlJ0UG84TDhOVEF4ekZrNVlKOTN2M00vSHVYVVFCeEpEZnV1STkyTkFDYWFl?=
 =?utf-8?B?M3Jmalpoa3hBVGFJdUw0WmpLNmNzOFBTREhBVWZNRTlEZDloMFEzeGF3cnhU?=
 =?utf-8?B?SlMxcWpGek1oM2lYQ0Q0V1FuSWtOeCs4TCtyT2VkdFpUT0pxMjY4VDFyaUxp?=
 =?utf-8?B?VUw3a1AyV3p2bG43bFVtMEtpSW5tcy92R0dhVGtrcXNUZ203a0ZTaUFPWFUy?=
 =?utf-8?B?TXcwK2hJazVoWktwTkp6ZktPTW9vVW5TVmsxNmc3QStuZ3c4OFNFMGhlVk9t?=
 =?utf-8?B?QWFHdk00SktZTk9wMmVGZWNhaldGVUo1WVlXSUhyajZKSmpEeDVqT25PUVdK?=
 =?utf-8?B?MnFEUnR6QVFXMnAzbmR4WjVTQXlkQkUvS0x0cTg0OWVScmtlN2FxV3RDY1M0?=
 =?utf-8?B?MzRreDEveElmWmd1bjhqYzg2dUgyZ1dyZjMzNnV2dStRaUZKTlV2aEJBSVdE?=
 =?utf-8?B?Q2lGT0FHby9laWVVUHhETGhLVFRMczhsWCtFY3B3b0lEQkdVcjdNb1BOVVhV?=
 =?utf-8?B?eW1mZDhBaWZBM25xVVZPY1ladi90bW11cUJoTmhZZkR0UzNJcmlNV0h3QnNZ?=
 =?utf-8?B?d09mcEFSL1FIa0l0UG9OZHNUUjhxbDZkMURFTlRBWDQvbXkzTmlxQ295b01D?=
 =?utf-8?B?NytMblZOREs3alEwTC8xMG11SnVVQzg3ODV3L3NRRWtVQUpIeHlzWnBZaTZB?=
 =?utf-8?B?Z0xnTFhrZG04MkdWMVMyR3hIZSs3L05ReU1JbEZ2VzM0amRNUW90a1N3MmJ0?=
 =?utf-8?B?c3B0RzVCa0RwNE9vWmhWbGQwaEgvYy9ZWDJ5c29ZK1REdTQ1NlB1OFdvUHlm?=
 =?utf-8?B?b3EyK000U0lWTHBYaEp4WHducFU5dmJBcVpOT0U4dmJuZ3hNd2lJYlNEcjVZ?=
 =?utf-8?B?dTk0UDNBR09Rb3NCbjJrTlpwQ3g1R0d6ZDB4amgySDhoRTR4Y1dKcUVFY08y?=
 =?utf-8?B?NUxRck9wS0tteUZkUnRHa2c3RTlmK011QW4yM09vTEZEeWs0aFFTZ3NkK05X?=
 =?utf-8?B?MmYvU25wTm84dm02NFZkbVVxYkNzTU45RFZLU2twdExHTnMvZ1VPSGJBSk42?=
 =?utf-8?B?ZXNBOHUwc3gxbkJaZ0RNT1o5SEVXU096OThoWmZZOWJXN2tGMnp1blBybW90?=
 =?utf-8?B?S3phMzRVRXZ6dSt6aVhNdWoyOFBrRVRwbCtXYmRUSSs3azFMaFdYa2ZZOW1J?=
 =?utf-8?B?Q2VES3VwVE9VaDZ2eC9xNndJcnRZVldTWWlMSzNUV1paaVVLaTVGR3ZrQkVy?=
 =?utf-8?B?azlVcDBHRzdubldNZEJQcHNDa2xtcGsrTHltS2taenpENUxMendBbkZidFNN?=
 =?utf-8?B?bXdCZ2dDLytXMDZTTk5icFc3NlV0TFM5b3A5LzlLdVdpY1NFMUIwU2YxbFVH?=
 =?utf-8?B?RjFCeHVVZXlFZVFyUU5Nc2o2T1JqTjloMGlCMkF2Ty9RVUVJdXZ6ZW15Si9o?=
 =?utf-8?B?TCtvdFFCSG8zcFpiREZTNTlCbnlNSW5EL3B0M2l2cDdjY0Y4N2ZLSnY3ZE5s?=
 =?utf-8?B?QmlJeWdXUk9PZGN3N2M0d2Q0VzZQVjZ3dXQxc3U2blVEYlJQR1N0MFYvOXd6?=
 =?utf-8?B?dWlEOTVtekt3NU1IVDRUcFJNNldCUmtmRVFhSC9DYnhrRmNJNG83WkFIU29y?=
 =?utf-8?Q?JL0qzgnTe81q3U3lV0QPDTcsKYrAG9qv3fN9w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWtwc1drRmNkZ2VkT0h2RXEvZTEyM3p0OWxXS2xUTStFQytmcmtwdGYwdWo1?=
 =?utf-8?B?SWIyQUpXdWdINS9xTEJvZ1F4ZXZsRTJTZmQ2czI0R2twZmsvTXdDa0NHeGpM?=
 =?utf-8?B?VzJkbGRWemFzSzIyTU90T01jMkV4cWlCdW1NZ1NnSkM1bmN3bkdkTHBpNEZ4?=
 =?utf-8?B?eGVPTXZpVXhNVTRNT2w0clUycnFQOWNUczhlUm1CRi9vMXZ5bzFTMGhrdmQx?=
 =?utf-8?B?ZkpJY2pOM3NSWFhwYnIzcTFoQlVNNysraTRQU1c2OXFqSWdWaDFmb2ZMd0pZ?=
 =?utf-8?B?aWtCZ0VsQmpZa2x1Mis0cjNIME1FaTZFYXVWdGZ2ZDdlV1hYMGRSb2M1VHJr?=
 =?utf-8?B?a0U3WThiY2pmbGJ6ZmJ2em9NbWdnazV4cDZUUHFNZXB1RzhBMXFsSGM1S2pk?=
 =?utf-8?B?SzBsVnlBUzdaWmVlcTVMVmVvWGRlbHNXam1lTWpQdWNHT0J1MFJYVmVXTE5x?=
 =?utf-8?B?QTliZzFKS0QrMVE4TTdNa1Bvemc2VFVPMTY2Qm5qV2h3UE5VVGVoSWVqUktF?=
 =?utf-8?B?NEd1TmN0MUs5WjNzeThiTWdqWVVRTWhHSW9ZNEJJTVBxT0ozSDJoeEwwMkxH?=
 =?utf-8?B?SmhuSmVWRGJMeGFraHF3ejdHU3kySGZNcE9nM2UzcGR3aUtIU0l6RTN3Zmk0?=
 =?utf-8?B?dFYyZGpJNHhBSVVSaWRoTTFubmh6eE5PZlpCY2JaK1o0M2FUa3F5a2J0RnRn?=
 =?utf-8?B?MWFzUFR3NVorZ0p2Yis2cVh4QnIwUTBCTFl1YmYxYnQ0ZVFnTTRxTXpmL3Ew?=
 =?utf-8?B?K21ZalVIQ1hlckVDMzM1eHpSVzNwc0RUMHNEYTQxb3U5alZUWGlnczErTWZD?=
 =?utf-8?B?aUdzRkJZd3ozZE8yRERyMEJFak9wSjNDUy9LcDhFVWhiTy84aDZ5R25wMnBj?=
 =?utf-8?B?bmF4RHpuYzgzVUwwbWVUbmxMdmhFenZQQ3NGVUFEaFpnS3FRY05QZ2hSNWJ0?=
 =?utf-8?B?NkIrWk45UUZWbStpNGZLOWJNYzdmbVVvb0w4MWQrNWFpVlYxMmtYSUZLU0dW?=
 =?utf-8?B?bUxwSEExTG1kd0JENSthOGdzNmVCMjdHWjVia0VaNkVQQmZldU83eStsQmhy?=
 =?utf-8?B?ZUtJMHJUd3oxMWhOYXdLaEMxNkUvc01yTzhLV0IzSGNEWWFKL1YwalhvWUVw?=
 =?utf-8?B?TmxHM3VLWjY2NXhOenJDOHZWbjRlL1dPaHpiaUQ3MndOdmkvaldLY0RDblpW?=
 =?utf-8?B?a0JiblRzbWgxRzN5enlnZitEZGQ1bUs3Sktyb0xtSlRtNXViLzN2Zm9CWkhl?=
 =?utf-8?B?U2dVc2owZ01zM1dtdGlFaHFnN0dMbU5WUzNmOW5UMU1tR0FZRjE1ZVhkdkd5?=
 =?utf-8?B?ZnBZdHpXdWFwVEVsUmhGbGdwa3NjUiticUUwZDRTR1J5bTVGQjlwd3h1L2ZB?=
 =?utf-8?B?aHl5a3YzcVFrMStOekhNM0NZVG0rNW4xaXBDOG1nVnVwZ1VIOTYvTjNCTTZO?=
 =?utf-8?B?Rk04RjBBNCtyOFFjRnE5dWs0WUhvRHpxWklMTUgveXI5NzhtYmpKVmZ0Wkov?=
 =?utf-8?B?aExRWmhVNSsyS0VMMG1nTFZWdld2R3ZlZ1pmMWtKSEZLd1kwRm5QRUtiSGJQ?=
 =?utf-8?B?ZGRLYUdJS0g5TXZ2QzFuZzhhTGs5cUFoY01UYmZIcURXWDJGcGZTa0E0aDRt?=
 =?utf-8?B?Y3FhQmVOT2F6Z1ZleXo1MTFqdCtoR1Z2OFVUKzlLZWRmMFF2TkVJa0hxYm1j?=
 =?utf-8?B?Kzd3bTZ1Zmc3TGs0T0pidnB4ZUdCRlc1UjZWVDRzamgwSWVsQUJ1K1oxZ2Zu?=
 =?utf-8?B?Wmw2TnhKMVMzZllsSVpta1dCM0ZJcHp0S0ZWNXVFajNBTGFSZG5SaVhMYzk2?=
 =?utf-8?B?bjZ4V2lEeldDMVR1cFVPSDN5V0ZwWExMaSszK1JGTFc2MWowV0RyM3BvVzVE?=
 =?utf-8?B?Y0doTUlnWVZtSEtRdnV0Y3FMYzhRcm9Ca1RCbmYxdHFWODQ4cmhNOUFYNFBv?=
 =?utf-8?B?aXh5S0I0WEh5d0d2TmhIMjBHNENZQlFxNVdYcU8rdVRIc1BUcWZZNENuR3pa?=
 =?utf-8?B?QmxTcERZdGRPUDRORWNIVFFVbnpwYkkzTWpuaWt0eFA0bXgwVkpqcXJJR3lj?=
 =?utf-8?B?NUFPZmpiNlNQUDlXMERpQ3FLdElDbnRhSkp6blVybld1RjJxM3N0M3J2WGNY?=
 =?utf-8?Q?MM1LkrOZa9G14ACkNgS8Ee+mu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780f438f-e0d6-49c7-6d84-08dd8a3d4305
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2025 12:23:08.4675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUBrfCyzyMDwSb1u+mbnulzRzfPdyVLw8KMOeNNhsufzEKls6ydHKLu0RsWbeDS6Dgz2Jp2tfJGN2KbA6dfJdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799
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



On 5/2/2025 9:02 PM, John Olender wrote:
> On 4/30/25 5:44 PM, Paneer Selvam, Arunpravin wrote:
>>
>> On 5/1/2025 2:50 AM, Alex Deucher wrote:
>>> + Christian
>>>
>>> On Tue, Apr 29, 2025 at 7:24 AM John Olender <john.olender@gmail.com>
>>> wrote:
>>>> The drm_mm allocator tolerated being passed end > mm->size, but the
>>>> drm_buddy allocator does not.
>>>>
>>>> Restore the pre-buddy-allocator behavior of allowing such placements.
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
>>>> Signed-off-by: John Olender <john.olender@gmail.com>
>>> This looks correct to me.
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> I was thinking that we should return an error when lpfn > man->size.
>>
>> Regards,
>> Arun.
> This patch restores the previous behavior in the spirit of "Do not crash
> the kernel".  The existing uvd placements are pretty clear in their
> intent and were accepted until the switch to drm_buddy.  I think it's
> fair to consider their style as expected.
>
> With that in mind, I'm not sure amdgpu_vram_mgr is the place this change
> really belongs.  That is, I think it's worth asking:
>
> 1) Why does drm_mm accept end > mm->size without complaint?
> 2) Why doesn't drm_buddy do the same?

I remember that during the development of DRM buddy , we had a 
discussion with Intel folks and decided to
return an error in DRM buddy when end > mm->size. This was done to 
ensure that, at the driver level,  lpfn
has the correct value.

I will modify this at drm_buddy to match with drm_mm and send the patch.

Regards,
Arun.
>
> Thanks,
> John
>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/
>>>> gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> index 2d7f82e98df9..abdc52b0895a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> @@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct
>>>> ttm_resource_manager *man,
>>>>           int r;
>>>>
>>>>           lpfn = (u64)place->lpfn << PAGE_SHIFT;
>>>> -       if (!lpfn)
>>>> +       if (!lpfn || lpfn > man->size)
>>>>                   lpfn = man->size;
>>>>
>>>>           fpfn = (u64)place->fpfn << PAGE_SHIFT;
>>>> -- 
>>>> 2.47.2
>>>>

