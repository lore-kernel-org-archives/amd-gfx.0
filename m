Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3B2CAC5B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 10:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC4F10E0BE;
	Mon,  6 Oct 2025 10:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tSJQfbp5";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B8210E0BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 10:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvkcDav16zVhK0IsKToIr9jUfR94Z9tWqTdX6olxKnmfzvdi48++eVduzWIuLJIkLQQaYeYrV+yLNryc4Vz5kIWHR+mo6OyIksenxpEeg6fzL//XDwIkOh4OlwR2/dX59nvPTRfezUWlFofOMCd8bzC01kkSnHz2/ZAIC2srcWXhvn6OWYDrAwYiSTtN3aWb6lvq/nckeaD+pPBieT623CklHcJHJth+nvSFRJR2xThrvFck9CEGOwxAHfoGjuiUqI6/RhAEmX8koap/9YS+8EX+Avq7qFpLCsVkS+Lfc1xDGwgMqwpKfHuA2FKmUK9LIRSL1QhPBtbVsOWX3wueTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ch3hQcN41qYYYRGjPLfV3LU4PFcFIGY9mF4XhIH1vw=;
 b=Eb1O7QuBoEYmGDa2IANBq0OIil9Uh3SWKG+9ig9JQ4aiEksyfGQGFhY678Otg12MlgMTx61h2mYGuparS2kHIXDBZoJJU5w7ynja+KIlJje6Ec0+IO8Zh7/3qaiY/RXrVSXHA7kQxiHuQBZjsjTIUetU4NAdneYA6mwDEvBFXsZvPLEp59SP+C3GincwUgd3mZdpEqTZbLCQ+D1jjFhs6ZXihZmf3n8XIblhFpPJiR87uoi6TESwkDYiXtc1p7YJfwxU1eAkCBqiZPf2Rdkz5hNml5fKrWuJqg+RfI3G1QUD3kkC/ln8R7aH9yiir5AOFD/NdxJO+952qrDaz5DzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ch3hQcN41qYYYRGjPLfV3LU4PFcFIGY9mF4XhIH1vw=;
 b=tSJQfbp5HKqpiZ1rzaX4HwZ+f+eCrsdPSOvUON8hi4XIsuyAquRCrcIkgcH3ZfvA08ZaXIBNYgEPUxkBnmNfvEaP2E5FG2VARrw61mmXlwOX8a2L7itWNb6KB/en2Tm0WflJHOKLfcEgwXTpM0BSUCcBmAS8ILc3SmrdXVrnEC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Mon, 6 Oct
 2025 10:34:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:34:18 +0000
Message-ID: <87c89331-fc6d-47a3-8570-33d2c280d77c@amd.com>
Date: Mon, 6 Oct 2025 12:34:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: clean up amdgpu hmm range functions
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250930082711.1278523-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250930082711.1278523-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: b0fbc51f-837c-4557-0867-08de04c3e791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnJSYmpCaVNhTEc3VDNIdDdKcUJ2b05UcFlnd1d3SlE3aG9VajA3Qkhucy8y?=
 =?utf-8?B?N1BEYVpWcVZwOXRUM1d6R2FoUGVBdmllWitUV3dkODBhUnFDYUtjY3hvWWdK?=
 =?utf-8?B?bWhvVWpsUkY2a2laZ0h2SmJrc2U3SDBaQnB4TkNmLzdxdWpKVEpUdlZoQ2gx?=
 =?utf-8?B?WkRKL1V2eEU3bkwzWEd1ZEo4VndRQzRZeXFJbTdJVUhVMEd4RENzMGd2cHRp?=
 =?utf-8?B?TWhlc2VPZmNseC91SktqaDR6TlV4a2t3RDh0dEV2SlZYamNCOThIeE80TTVl?=
 =?utf-8?B?SGE3RllPOW12dUhMWCt5VHhENHR4L2dHNDJ6TFdaa0JTeEtZWFFuQWpNcVlS?=
 =?utf-8?B?YVZHczJNYmVzMkd6R2c5bVlGQmZ3OWtmZ1FQVFFjTmVFdEo0eW5mNnBEQmMv?=
 =?utf-8?B?cDNtbEJNdUs4SXpXbER4elVYME93cDVibEZvVjNSa3FobEp6eExwejEzYmNH?=
 =?utf-8?B?SGFMOERGVnp1Z2NQelFFZExpN2VzRVNobFV4UUY0SXo4THdIRk1hVzNDQm9L?=
 =?utf-8?B?Z0dTK3ZjeGpLUnlXazBBMDRtWjdlZzIrOEZmVnFNRERyRlowbHN3a21FVmE2?=
 =?utf-8?B?RzFZSXJPYWExdDdmVU5rOU91WnRzMWFsbHkxTTFHVWpNaTlkZ3M2cFUxMXRY?=
 =?utf-8?B?eG55WktsbllzYnh6VmlQR0RiSFkwZXpPZHB5ZkdKbkorRFg5WnlyUWpoL2hl?=
 =?utf-8?B?SFI5eG40Ym41VlcrbDB0Y0M1T3k4dGY1M3FBWFNyVnlwOFF0T0VRZFNUdHV0?=
 =?utf-8?B?SHJ6RTFxekpWVnI1NkVqZVN3eDRQdTlGbE5PTUkwOEkvZUxaVm5oR3VRTmZQ?=
 =?utf-8?B?dUZUUEpRdWxNNVdVR2UyR3dLNFZBUEJUWHpBbGhYUUdmSUd3MFNRZVJOTDRZ?=
 =?utf-8?B?TElRZ2UwTVhQd3pwR0tOckZtRWQ0dDB0Sm9RaENlNGQwKzROR1N2YU8xck5M?=
 =?utf-8?B?bndaTU9rR3pmTG50TjFlaXFSZnRHRmdpRlNpV2tQaXBiSmtNVGNpNnllZnBC?=
 =?utf-8?B?VkgxMVJLdWpZVi9HeXo3TTJiWjgzS1ZvK0lQWE55d2lLVnErb1VzNXhONXUr?=
 =?utf-8?B?eXBhckhKbEh2THJlZnNFcUpYMnZvb2o0WmVuTHJuaFI5VTJncDJiK2FGcW5B?=
 =?utf-8?B?RXZXY2VMYnNnamF1RTBBTFd3RHhDRkxkN2hzbHZlTWk3OWZyYkpldWc2Vy9K?=
 =?utf-8?B?N2pCQkpsNFdEM0N2dnVMZjZJTzc3S2o1bHFWWWwwSDVtODF0TjhQYUNYcjhK?=
 =?utf-8?B?ZklFcHdMVDlLaG0xb1k1NEhLL3h5SGRSYklOc2laRFh6SGtwUGZ0TFk3cVow?=
 =?utf-8?B?R2ZFc0p2K2MzRXZoVUx5SmtMdVB6OUNyd2dRY0ZDNkJ3SXVEaDFZNmFtd0Z4?=
 =?utf-8?B?ek8zRmJkcE5pN0JYVlB3cUpwMUQ0SmlIR2dSQTRPaG5JOTNySVg5K2gxekky?=
 =?utf-8?B?S01MR0hGY3JTTG5DcHhvajY2SU1jYTQ3UFNlRnl1MjR1T2syM3ZzbG5QQldU?=
 =?utf-8?B?TVl5YVNjeGx4OUpBcUI4bCs3Z0dRbnVDS3BwZGZSVm9qVERzYmVzUFB0ZkFv?=
 =?utf-8?B?NEJJQjF4YmNyVzZJRStNUUFwdXN0Mm4zbFB6QnFXUlBpNW1FbDRSQVFBRFJp?=
 =?utf-8?B?Y3RoRWw5RExMODgxZFMwWDU0clZNNVFFbGY3YTNmdEFjT29Vam1KektxVTNI?=
 =?utf-8?B?cVppd0pmMVFUZU1XNmUyTjNZVDVwL2ZFdmsxNzY5aVJRNzhicjNuQkx0c3d5?=
 =?utf-8?B?RTNqWVNSK3Q1d1IvTVd4djQ5bnRRUzZMYVR4MkdiaVgraUhrWEtBTnJqa0lz?=
 =?utf-8?B?VUpIMXl2ZnM1bUJjV3doSHNWb0pESkFpbzZMS0ZvNXRLVldxTDBoR2tERm9X?=
 =?utf-8?B?SXVwNWMrN2dxUDdVeGxTWWxQcWZ4WGw4cXB3VVZDZU1aTmx5RW9UTGRjN0FF?=
 =?utf-8?Q?xTdyO6H8ytdnRj0U0kxFQ3Hxm5lvLvcU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjVhSlo5TUo3L3BFdjBYRjFrellNWXgvcGRINFpGdllJUDVSaGJFcC85aDVi?=
 =?utf-8?B?Z2QrRmh1V1RoSHZqOUpWbGhwblp4VzBMUVhONDZUcENOVWRVaG82dC91MndT?=
 =?utf-8?B?cHVUL2F1Y0Uyb1haVklIY1hhVW41ZHpCWE9OZXAxT0YzaE54RmhhVVd0Rk1y?=
 =?utf-8?B?MTl5eXhPVnFOK20wQWlqY2tzT1ZUNHVmUkF3MTRLMHIzZ1l3bDJqZWdueHdU?=
 =?utf-8?B?M0ZVVmp6TnI1aTBzWGIxVzErY1NFVm1IK2d6T0xVb3N1U3FxandSbmlWOFpi?=
 =?utf-8?B?YmliRGg0bE1iNkJYK1RjaVdjcGkrZmVnZ3Y2OHFRL2VRTnEzQzlvMHJxTEMw?=
 =?utf-8?B?aHRvVTVic0xZakFOY29LMGw5VnRHcHQ0YzJ2VFdFYitvNFFBNzBZWkJTM2dl?=
 =?utf-8?B?OFd1RGRVL2dPUnhkSklWQWhFUkZEcWMzRDFKR2hKMW9Jb0N6STNDMWZqM2VM?=
 =?utf-8?B?UTdZRU5DWVdvVmxpVDRaSFZFdmRDd1dXQVVTY1JFcnZOTWJQN2RNSWVEWjVo?=
 =?utf-8?B?aGpEN3NiYkpjNVhKQ0c2eVhBbG5tSEkySHl2MXRQTnRjVlVUdlIyZkNJOE9y?=
 =?utf-8?B?SCtOWGhWSFpTTFczL29OVUhnNHpOcFc5WkVTMFhQeU04OHNQZEd0eDBEbmQ5?=
 =?utf-8?B?UG1uaTFpM3dERUdtdWdvS1kwT3ZmS3VPaEdyQitjNnZQZ1J3M2N3a1lKT0Vu?=
 =?utf-8?B?Z0dYVDNMV1NsQlNEdStuaCtTeTlZTWFXcEdCSUgvT0FpWkJhZ01naytKdEpu?=
 =?utf-8?B?SldYOUV6S01GTzY3NHc2Q1BiUnhVU0RZLy9uM3VCbTVacnl2R0FaYzdkVXVE?=
 =?utf-8?B?c2RQaHE5a0YybTUzd1NTdi8xRWpFYXFycmVOU09rU2ZTN0dDam5XZ0pObkJN?=
 =?utf-8?B?Zk40aExwc3AxQllPTmhkWVlyNlBvM3VLWGs5M3ZKbVd2bkJEK3J6RFdRYndp?=
 =?utf-8?B?Zmt3SW9YVStiNXV3L3lCeDZleDc3SUFRMFBmTFE0SlJYd1BNUStzMFUyYTh1?=
 =?utf-8?B?YkFEZXJjRC9mVmVEM213dkRNSHQ2ZGtmdWxVOXZ0OGVnRktnR0RwdS9QNUZH?=
 =?utf-8?B?STVQM3l5MER0MWN5MWhwQ2Z2Rm1RSDJkV05sS0sxOTZKeiswSWtDRGhTNk91?=
 =?utf-8?B?UlJJUGNLdXZJZXZSc1hWenFxVDBkMkNZK01JSGZQNEpXSnIrMmR6STM4c3Vz?=
 =?utf-8?B?SDg5MmF5NFQ1bWE4R212eFd4bUJBMEphckhXNGtleGNYcFAzZmxPREJJY2NM?=
 =?utf-8?B?VElEdkxiVFRMZzFFL081c2RDMVJFcjgxUzVyc2kvVkJycGFNdDVWTFJZUVRQ?=
 =?utf-8?B?ZUYyQ3I0MjQ2ZWs3SElhbGtwUHpMT2c3bVlPZmhiVnh2a1RQRFYybUIzK3N4?=
 =?utf-8?B?ZXBHaXFvakd5UFdLQTF3S0lsUVkwRERNbHltaHNjWjZ5aVdBN0hOYWxaQUlm?=
 =?utf-8?B?M3lDTFhYLzNWaFdpb0xBWlpNRy9LTzQxMEFxMmQ1bnluOWpEVUM2YURPV3R4?=
 =?utf-8?B?eGVzbVdWM0J3S1drK25VNko5MmcxRGZXY0JZdXdXc2xmSENhbVhSWnNwY21W?=
 =?utf-8?B?RjB3OHFvV0U2VERIT1ZhRGJhR1lwNmUyT1hvdjdTSzJpckVLUHlRVU42R1NY?=
 =?utf-8?B?aDNGaVZnaVYxNVhNUzBnNFM0Tm82djJPNVRzUVBEQjM5RjBiYVprT3Awajdw?=
 =?utf-8?B?RGJ3TXRNdnRWYnRIS00rb0dGeXhxUUlmR2JFQmI3UStOR3lVQlRJVmNXR0hJ?=
 =?utf-8?B?dFRFV1gzRTI3RXVQYWxrS09KVlhSMDBIU1Z6ZXYwaGpqNkppdmZMRWgxaGFD?=
 =?utf-8?B?eUFDcTIxQnR0NTV5K3NKKzNxNk0vaUtHT1Z6SmdkbTJ3dVhpZUFNRGtzWHpK?=
 =?utf-8?B?NGlXR3NmdG4yOHFudm1SenVxZ2J0cnZXQVJ2NVVWVmVEcWR1dW9ZT2NMWHhG?=
 =?utf-8?B?bmRPbmRCVVZqVWtZbzZnTVE0cldPSjNMY0tHMzdCM0VKUVBuZjZJSUVjVk5j?=
 =?utf-8?B?Q2hINm1Ob1hsUUpKSTUxb3dlTnJpNExpK3V6ZUtESitobkZMTkxVV2J1TzUv?=
 =?utf-8?B?N21wSWJadUlkdWxqdmFBTzZ4WGxGa1MrTWZvSzM2Njg5S1cvem03KzJGQTYw?=
 =?utf-8?Q?H8iYwawDNVjcwwnznfyYMJk6U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fbc51f-837c-4557-0867-08de04c3e791
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:34:18.5712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUjykhMDrniHsMMbBdKFSj9XK6fIQTsb4O1+DrMYZqfCar06GGXYHpg1PobKhQN+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
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

On 30.09.25 10:27, Sunil Khatri wrote:
> Clean up the amdgpu hmm range functions for clearer
> definition of each.
> 
> a. Split amdgpu_ttm_tt_get_user_pages_done into two:
>    1. amdgpu_hmm_range_valid: To check if the user pages
>       are valid and update seq num
>    2. amdgpu_hmm_range_free: Clean up the hmm range
>       and pfn memory.
> 
> b. amdgpu_ttm_tt_get_user_pages_done and
>    amdgpu_ttm_tt_discard_user_pages are similar function so remove
>    discard and directly use amdgpu_hmm_range_free to clean up the
>    hmm range and pfn memory.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>


> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 12 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 11 ++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       | 23 +++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 32 -------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 13 --------
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  9 ++++--
>  8 files changed, 49 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 4babd37712fb..e80a00d768cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1089,7 +1089,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>  		return 0;
>  	}
>  
> -	range = kzalloc(sizeof(*range), GFP_KERNEL);
> +	range = amdgpu_hmm_range_alloc();
>  	if (unlikely(!range)) {
>  		ret = -ENOMEM;
>  		goto unregister_out;
> @@ -1097,7 +1097,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>  
>  	ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>  	if (ret) {
> -		kfree(range);
> +		amdgpu_hmm_range_free(range);
>  		if (ret == -EAGAIN)
>  			pr_debug("Failed to get user pages, try again\n");
>  		else
> @@ -1120,7 +1120,8 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>  	amdgpu_bo_unreserve(bo);
>  
>  release_out:
> -	amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
> +	amdgpu_hmm_range_valid(range);

This call here to amdgpu_hmm_range_valid() can be dropped as far as I can see.

Apart from that the patch is Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> +	amdgpu_hmm_range_free(range);
>  unregister_out:
>  	if (ret)
>  		amdgpu_hmm_unregister(bo);
> @@ -1923,7 +1924,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  	if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
>  		amdgpu_hmm_unregister(mem->bo);
>  		mutex_lock(&process_info->notifier_lock);
> -		amdgpu_ttm_tt_discard_user_pages(mem->bo->tbo.ttm, mem->range);
> +		amdgpu_hmm_range_free(mem->range);
>  		mutex_unlock(&process_info->notifier_lock);
>  	}
>  
> @@ -2550,7 +2551,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  
>  		bo = mem->bo;
>  
> -		amdgpu_ttm_tt_discard_user_pages(bo->tbo.ttm, mem->range);
> +		amdgpu_hmm_range_free(mem->range);
>  		mem->range = NULL;
>  
>  		/* BO reservations and getting user pages (hmm_range_fault)
> @@ -2574,13 +2575,13 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  			}
>  		}
>  
> -		mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
> +		mem->range = amdgpu_hmm_range_alloc();
>  		if (unlikely(!mem->range))
>  			return -ENOMEM;
>  		/* Get updated user pages */
>  		ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
>  		if (ret) {
> -			kfree(mem->range);
> +			amdgpu_hmm_range_free(mem->range);
>  			mem->range = NULL;
>  			pr_debug("Failed %d to get user pages\n", ret);
>  
> @@ -2749,8 +2750,8 @@ static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
>  			continue;
>  
>  		/* Only check mem with hmm range associated */
> -		valid = amdgpu_ttm_tt_get_user_pages_done(
> -					mem->bo->tbo.ttm, mem->range);
> +		valid = amdgpu_hmm_range_valid(mem->range);
> +		amdgpu_hmm_range_free(mem->range);
>  
>  		mem->range = NULL;
>  		if (!valid) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index b75b53f21cbb..c4b2de1a1fab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -41,6 +41,7 @@
>  #include "amdgpu_gmc.h"
>  #include "amdgpu_gem.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_hmm.h"
>  
>  static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
>  				 struct amdgpu_device *adev,
> @@ -885,7 +886,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		bool userpage_invalidated = false;
>  		struct amdgpu_bo *bo = e->bo;
>  
> -		e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
> +		e->range = amdgpu_hmm_range_alloc();
>  		if (unlikely(!e->range))
>  			return -ENOMEM;
>  
> @@ -988,9 +989,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  
>  out_free_user_pages:
>  	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> -		struct amdgpu_bo *bo = e->bo;
> -
> -		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
> +		amdgpu_hmm_range_valid(e->range);
> +		amdgpu_hmm_range_free(e->range);
>  		e->range = NULL;
>  	}
>  	mutex_unlock(&p->bo_list->bo_list_mutex);
> @@ -1321,8 +1321,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  	 */
>  	r = 0;
>  	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> -		r |= !amdgpu_ttm_tt_get_user_pages_done(e->bo->tbo.ttm,
> -							e->range);
> +		r |= !amdgpu_hmm_range_valid(e->range);
> +		amdgpu_hmm_range_free(e->range);
>  		e->range = NULL;
>  	}
>  	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 12f0597a3659..cfd8ffe2da31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -571,12 +571,12 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  		goto release_object;
>  
>  	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> -		range = kzalloc(sizeof(*range), GFP_KERNEL);
> +		range = amdgpu_hmm_range_alloc();
>  		if (unlikely(!range))
>  			return -ENOMEM;
>  		r = amdgpu_ttm_tt_get_user_pages(bo, range);
>  		if (r) {
> -			kfree(range);
> +			amdgpu_hmm_range_free(range);
>  			goto release_object;
>  		}
>  		r = amdgpu_bo_reserve(bo, true);
> @@ -599,9 +599,10 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  	args->handle = handle;
>  
>  user_pages_done:
> -	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE)
> -		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
> -
> +	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> +		amdgpu_hmm_range_valid(range);
> +		amdgpu_hmm_range_free(range);
> +	}
>  release_object:
>  	drm_gem_object_put(gobj);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 53d405a92a14..b582fd217bd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -226,14 +226,25 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  	return r;
>  }
>  
> -bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range)
> +bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range)
>  {
> -	bool r;
> +	if (!hmm_range)
> +		return false;
> +
> +	return !mmu_interval_read_retry(hmm_range->notifier,
> +					hmm_range->notifier_seq);
> +}
> +
> +struct hmm_range *amdgpu_hmm_range_alloc(void)
> +{
> +	return kzalloc(sizeof(struct hmm_range), GFP_KERNEL);
> +}
> +
> +void amdgpu_hmm_range_free(struct hmm_range *hmm_range)
> +{
> +	if (!hmm_range)
> +		return;
>  
> -	r = mmu_interval_read_retry(hmm_range->notifier,
> -				    hmm_range->notifier_seq);
>  	kvfree(hmm_range->hmm_pfns);
>  	kfree(hmm_range);
> -
> -	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> index c54e3c64251a..368dd58d13ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -35,7 +35,10 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  			       uint64_t start, uint64_t npages, bool readonly,
>  			       void *owner,
>  			       struct hmm_range *hmm_range);
> -bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
> +
> +bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range);
> +struct hmm_range *amdgpu_hmm_range_alloc(void);
> +void amdgpu_hmm_range_free(struct hmm_range *hmm_range);
>  
>  #if defined(CONFIG_HMM_MIRROR)
>  int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 046ff2346dab..96bd0185f936 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -753,38 +753,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  	return r;
>  }
>  
> -/* amdgpu_ttm_tt_discard_user_pages - Discard range and pfn array allocations
> - */
> -void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
> -				      struct hmm_range *range)
> -{
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -
> -	if (gtt && gtt->userptr && range)
> -		amdgpu_hmm_range_get_pages_done(range);
> -}
> -
> -/*
> - * amdgpu_ttm_tt_get_user_pages_done - stop HMM track the CPU page table change
> - * Check if the pages backing this ttm range have been invalidated
> - *
> - * Returns: true if pages are still valid
> - */
> -bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> -				       struct hmm_range *range)
> -{
> -	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> -
> -	if (!gtt || !gtt->userptr || !range)
> -		return false;
> -
> -	DRM_DEBUG_DRIVER("user_pages_done 0x%llx pages 0x%x\n",
> -		gtt->userptr, ttm->num_pages);
> -
> -	WARN_ONCE(!range->hmm_pfns, "No user pages to check\n");
> -
> -	return !amdgpu_hmm_range_get_pages_done(range);
> -}
>  #endif
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index a8379b925878..99c46821b961 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -192,25 +192,12 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  				 struct hmm_range *range);
> -void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
> -				      struct hmm_range *range);
> -bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> -				       struct hmm_range *range);
>  #else
>  static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  					       struct hmm_range *range)
>  {
>  	return -EPERM;
>  }
> -static inline void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
> -						    struct hmm_range *range)
> -{
> -}
> -static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> -						     struct hmm_range *range)
> -{
> -	return false;
> -}
>  #endif
>  
>  void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 9f0f14ea93e5..53e443a243ee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1737,13 +1737,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  			}
>  
>  			WRITE_ONCE(p->svms.faulting_task, current);
> -			hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
> +			hmm_range = amdgpu_hmm_range_alloc();
>  			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>  						       readonly, owner,
>  						       hmm_range);
>  			WRITE_ONCE(p->svms.faulting_task, NULL);
>  			if (r) {
> -				kfree(hmm_range);
> +				amdgpu_hmm_range_free(hmm_range);
>  				pr_debug("failed %d to get svm range pages\n", r);
>  			}
>  		} else {
> @@ -1764,10 +1764,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  		 * Overrride return value to TRY AGAIN only if prior returns
>  		 * were successful
>  		 */
> -		if (hmm_range && amdgpu_hmm_range_get_pages_done(hmm_range) && !r) {
> +		if (hmm_range && !amdgpu_hmm_range_valid(hmm_range) && !r) {
>  			pr_debug("hmm update the range, need validate again\n");
>  			r = -EAGAIN;
>  		}
> +		/* Free the hmm range */
> +		amdgpu_hmm_range_free(hmm_range);
> +
>  
>  		if (!r && !list_empty(&prange->child_list)) {
>  			pr_debug("range split by unmap in parallel, validate again\n");

