Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA9ECAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 16:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 755C010E24F;
	Wed, 24 Sep 2025 16:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0mXA9kcj";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FA410E24F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 16:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REf7Y13C2lL1yOl20VsO7cGdofUnv5U7trFAs0iSKpFWQhOXLuyRlrxPH+F/IO0AEYQawjSqN7JtJN/YGDYRMGsAzJLh0BVrs0wIhTL5EqaJ7Y3pQlgWdLyv9gvoGGviOD5jES+CqQw3l6t8keR04WkJl8XXKp56N8T2LeORT4bL2wpX+77irRRyA6/HaiX7cdkeXXvgdEjbEzW0DdrDLdUOROzVR2kpOlIDm8e+z+799JU+z8IE3297vme3KIalITaVzpqHsmjFNA3od8kxPGPRPkegoIVUkKPc51Upy392c1cKg09bDfmzqgJXcMG3ra+zWuJMDw+gojuAwQbCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsmNSMuedt7JCIwoWNo9o/6BZC0CANg0fRHk2ErWREw=;
 b=TM7w7ERtOL96WDHcMPBX77ncRW3XO9LAQkF8ICmDCZEyRdy9kmtzungKN5YN8+7rNxSZ59BSonccvCjuUuI2uoFLH0/qxaeRHVX+AbQBI2zFJGCeuvqmgQRZVJNEkWf7QUZunwYa9dHliL59IHU76NN8Vve029dJezDbtt3DyFa9suHqY00+djNyo83EU0gXe2+ZJK4yCDUZNlJo3iaB1B+S/XnKhsRwf9VDNqVMCBpBYmUrCBHqwckC1kfxRlcV2tZASr/cyoYTkQTk2Asjqrw/z/G0jLlhRREr2weeXsl7d0lozxOHPx0oEmz3wAOcYA4hFZ7U4VL4Adov3WmKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsmNSMuedt7JCIwoWNo9o/6BZC0CANg0fRHk2ErWREw=;
 b=0mXA9kcjai+we+gmlEbBlbUStHsRC/WenuvtxJhmfIDBnjq61TAl/kR0u2BfQAB62u9OKliAbUQKT3XHa2ivzA/b+dpdbWAbekuck3KGRYRQ75EXSNtIJSHSexUEcQHUbeWKbOvpdnqjdz0PJke48Twob9rx8OHDdVokoU2RzNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 16:57:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 16:57:43 +0000
Message-ID: <c5b52ba0-efe1-497e-9d35-a752a2b35267@amd.com>
Date: Wed, 24 Sep 2025 12:57:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] drm/amdgpu: use user provided hmm_range buffer in
 amdgpu_ttm_tt_get_user_pages
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250924100156.3746229-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20250924100156.3746229-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c298b6-eb83-49c1-37d3-08ddfb8b7a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2tYRGVMOXVOV2p4dUtkSitnNTJyVjB0SU1HUDJtc0dJUEhHOFpqTkJySUlm?=
 =?utf-8?B?V2FETUVRT3Y5RmJhMFAxeEY1N0V1bVVrV0xBSGlMay9GZVRka3FNNlJoSU9F?=
 =?utf-8?B?dkVYRk5RamJXQXhBektOamgvdW11M2xGRGVpYnZpM3RyTDVwbTRPMVE2OHdn?=
 =?utf-8?B?cG9rYjM2TER3dEhNZlBsWEhybkhTOGR0VUVTVHpKYUNwRWhYN1ZKWTEyTGta?=
 =?utf-8?B?SXJRUXFYMkFwcVlDRDBtREMxandWZkZxbklUL3FhNCtPN2hkY1pVM1hyeWMx?=
 =?utf-8?B?ZzhtSEd0d1REZG5XUWc3b2U1bkhXNGZ2WXp5U1RLcWR3VFU2QmMzUlpiTTlD?=
 =?utf-8?B?U2UydkZDb0F5b080dnZ1aG9Nb1dkMlZmeXBRVUs3dEFUZERxZm5rUW5vbEV3?=
 =?utf-8?B?aEhkbTlwYythL2FLT3VyWlBqTFBqWUwxVXZmRnJqRzFRTGFlMkI1Q0pjajhl?=
 =?utf-8?B?ZWxvNGsrSkVBUndnRmpkc0JWM1RNWmJpVzV5RjhNQUdFSVdZL1ZiT2x2RUto?=
 =?utf-8?B?bG5wV0JTRUU5N0paMEZhM2RTMklXRTJwK0ZjRGZkY2p5QjlxK1NabXBZRDhG?=
 =?utf-8?B?NGtCWExvcE15R0M4ZU9SRnFtK2cvK0dQRHA1UVQ4cFpYRW9ZNWpRd3NCQWlM?=
 =?utf-8?B?VnloQlRwR215NGhVRzM5T09yYUJWNlplWkxEa1l2OERyZE1IVm5kcHI3eTVR?=
 =?utf-8?B?eVE4L0NrWk0wN0ZIcnorU200MFQ3Wkx6WlRvZ0xsWnRydkVLVWVrLytMcWl4?=
 =?utf-8?B?QTk1ZWl6L1czdnRSdWN4Slo2VTF2TEcrTW1vbkZZdEx6bzlyM1hxSnUyNzBp?=
 =?utf-8?B?VkgvUkx1LzZDWWVCTGxlakpUaHd5U1lMblJGZWFwTEZJUEJCRU9KK2M2OWRw?=
 =?utf-8?B?bWlOQzBZS0sxSyt5K0Jmc1RNczRLQUw0OGVwRVZaOFdGeENSeVVUd3FZMGxl?=
 =?utf-8?B?MzhPRCtBelJnVzhyZVplUHNEVkQ5a21YUU1xYnJJTDFHUDQ0YlpyODZSSnJ1?=
 =?utf-8?B?WW1BWVl4UDFUMUtaY3hRQXJiQ2FDN2p3RE5jS0N0NldFQTF3UEV2V1drVmNP?=
 =?utf-8?B?NkhJZFpVL0Zud1REd2NxUFdaeGM0dng3dzhTZE1KTnBMdzJrV2llZzJsNC9k?=
 =?utf-8?B?NStXREdqUXk5Y251RVpOUEx0TmRPUTMydGVKWG1XelJNcmFqZGVZUTRHdFFy?=
 =?utf-8?B?OFBheEpSY0I0b1ROUnFleXFMK25RT2RhRGdIYVVjRnNOaGU3OTJva3N2SkJD?=
 =?utf-8?B?c2xjMFJMSmVST21HVFNUSzBBTDhLRC9XOTZKcEV4cEF4OTl5djNnSEN2TUMr?=
 =?utf-8?B?Z3N5RkdQNURmaWtlU2JlcWZVcGhaTjFZVDFuMkYyQlQ4TW9MbXB1N2w1b1dE?=
 =?utf-8?B?VytLVTlrKzlHaExXWERrVDNEdllDaWxyYTJNUktBaFh3K1BMUFpDQUNlcWNQ?=
 =?utf-8?B?ZVFrVEdueVVXREFpelR0VjlQdGlrb2MyL3ArN29zSGxnczJwRTRHejlONjcz?=
 =?utf-8?B?Zlp3ekxkMXpQWkpma3RGeVd3N3pZZnVNbGlkOUdKQUgvUzFJN0ZKYVJaeHVt?=
 =?utf-8?B?S3dzYmMvWjFrSUZreUozQng4TXIxNCtQdE1YS3FNdi9iY3VuWXhoTS9xcmQ0?=
 =?utf-8?B?K0JkOEpHM0trQ1U0RXlnbE5DWDhOSUNvc1hpc3ZiOFR1VXdhN0wveENPeG1P?=
 =?utf-8?B?dDhxY1Q1eTVTWm0rOXBKczV2RE9jQmVSVXBaRnZSOHo0NSs3TEJML0ZDOUJt?=
 =?utf-8?B?V0JDdzUxYmpldVFhanE2aHBKTkhBZlp5Vy9mTnFBNlRGdzc5cU9KS3ZvZWNh?=
 =?utf-8?B?SitLaWJKWHRuMWpVK1pCWjI3eDE2NXhmcU1QaUtRZm5DRS80T1lnV3Y2WUVK?=
 =?utf-8?B?ZzFqZXlqSnVVTFFndmtCVE1VRDdaSmY4YjBuQnJYN2VtaGlzSmN2TldOS0Fm?=
 =?utf-8?Q?vSSGUR823fs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndtcEhWNEhHR2tuY01ybXcyWGFsSnNZK0duRXBjdmw4R3VrZmh0N28yMHZk?=
 =?utf-8?B?TWhIRG5tUjk2ekFJMC90blQ2VzZnU0taUWw1YUFEemVidDNQRWJwRnpxeGNw?=
 =?utf-8?B?NzNuK1JLN3JWYjdEL2IwZEgrZmhRL0tXUEttalBMY3prZlZ0eUJyK25zZ2Fz?=
 =?utf-8?B?TG1XbmV4Rk9hNGViSnMrcUZ6ck51RmZXVUMvRFFlank0ZytMMTdhYWltVDFv?=
 =?utf-8?B?c3ozbjhLTmR6MkRTZ1lobE5pTmFsTEtQRzdvMWdORUZ3SVhOZ0c1UW9qdnRL?=
 =?utf-8?B?eU5Ncit3bWp6UU9jTUZjLzA2UExvd3pROFlhVmY2eThRY3JycXpsdHlTcVFI?=
 =?utf-8?B?WDErcTRSekRSaFduZEpFWVp0REZ1QTRCZ2lRM25WZVpwWXNWc045SXJjSVow?=
 =?utf-8?B?bEI0K0VzRnJ4V0Nmdlp3ZWQ5WHY1RzhRNGlFRFZ3d2grT2tHSzcxaFhhdEZx?=
 =?utf-8?B?K0ZydVdmV09QMURnWE1NZ1ZMb1djZ1ZOUjZINnBnUFRkYVArTHBWS0o3V0Jz?=
 =?utf-8?B?azMxeG85cG5aK2xjbTBoVmVUWUtUb2ZpZ0hOcTRkRm0rOUdpRnUxU2I5c0p4?=
 =?utf-8?B?bG1TNURFM2crcklkaUV2aXdOZmp3OEgwbXdaZzVjNlNBMUpRTHR5NFh0QUpX?=
 =?utf-8?B?K2JTNXEwT3crT21vYndMYU9jN2Y5RnRhaGRCZVYwWmZWTGJobkwxTG1OcW9T?=
 =?utf-8?B?dHRNM3FoY2cxWi9ESWxpaXNaMTNXTVBZNGJJYVlaSDZMM21saXJUUkxmUWx0?=
 =?utf-8?B?N0F2ek5wMlRQNi8yR21HMDN4TG5NWjdGNHJYLzRPV0pZbDloMmF4b2pBU2Ix?=
 =?utf-8?B?MXV3U2cyNUxvZ1dtSFdIbUJsSWVOa0hpcFU5ckxjZ0I3dVJsMUV6M3ZpY2U4?=
 =?utf-8?B?cis0REhOYzZYejhTTzRPWVFLRDh6RjlzaXVhMkh5WDlVVDZQLzlLb3o3Z0VU?=
 =?utf-8?B?aXZNSjB5T1drSlBYTERUNWJzeGZkV29kL1V3YkgrSmQxVjQ3SjMvbXI0b0lh?=
 =?utf-8?B?QVpOYzg1VE51WnZsNEs5UG5BdFg4L21TWFU4MjJzclZRS0Q2dFE0Y0tQSitq?=
 =?utf-8?B?TDgwYnNZdnpuenBySk1PcHJvL0ExNy9taHJBVjVuRlExRUordGxOYTVMR25Y?=
 =?utf-8?B?cGhMODV3WVNUcmlBajVNSTIwZG93KzFsY1B3cTFjYjZ5aGhIL2hJWTZHcE9O?=
 =?utf-8?B?TThLc2ZYSWVYcUtxZEFUcXlzSlFwZ3FjbFAveXQ3bGtsblQ0RHRPT0VsdFlm?=
 =?utf-8?B?NnI5SHVaWjVwNWtTek1WSVdRemVtZE9KOHhMQzlLYzZIb210YThQalBaQk45?=
 =?utf-8?B?UURHTXhjZ25DYWQ2cTlxVDk5TDM3aE1rSm1COEErSmdyYVhvZXBQVFJiTFdh?=
 =?utf-8?B?MWNnSW5GMG1aNWNPMEI4T0x3OHhaME9uSG5mVzZIUFNyWFZJUjNsTUpHQ2l4?=
 =?utf-8?B?eVlhSXR6WnNQeG5UWjNROVJ2ekNPSHBWdWwyQlhiOWhRR2dKTWttR2tWemw0?=
 =?utf-8?B?ZEJtVU1iM2dnRUUrL2lNeWJ1dm9wbGRRMk40bkl0LzljYk4zcGx4cWRlNERD?=
 =?utf-8?B?NVJlUklvTUo2WFJjRno3L3VYMWNVTkZzUGY4Snd0MDhYa3JUbkxmZWQ2bFFM?=
 =?utf-8?B?dmZwQ3M0eUdKQkZxUkxWT1psMVRZRVd2eDB3b3dad3BRUGU5ME1BeG9kTHF0?=
 =?utf-8?B?bHJZM0I1d0VwcWJWTkxHR1Z6Z1hoSmNwS1RSalNCQUI3Sjd5Q3lkMkxQUTBG?=
 =?utf-8?B?eExWMyswaEkwRDhxVlJIV25WL1RxRlVmbWRHSDNBcHVZNE1sUFFHTWZQRFdp?=
 =?utf-8?B?c1VKSFozajJBbG04TDRrdHlNYWR3V0hKTy9abWlIRTduKy9IRW9yamRVRkZl?=
 =?utf-8?B?S0ZheTBpQ0VkWnVPQXYwVERBR21ISEkxcDRpUjU5Z1VFSk5sWkxGT1ZvdEVo?=
 =?utf-8?B?TGdJZjN5SVF4WEYzbXovREZpdkdyU2pJd3Q0Y0xydjhNQ09pWEhjeFNxWG1r?=
 =?utf-8?B?QnltaFZvNzFscVE3aE9RMVEyeVhSUEJuRDFvMkxrLzVjOGxxdXBuL0JhSXB6?=
 =?utf-8?B?TW0va3p5YnF5UkJaMGd3U2VIaERSMFI5UEJXbldMOWhmL1lic0s3VzN5enZu?=
 =?utf-8?Q?WbBmBTMNnsAj1PxG4gesmdif/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c298b6-eb83-49c1-37d3-08ddfb8b7a77
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:57:43.2327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKu/0WpbSUPOHhO0RA3CnIP54gzXUhbQTXJxRiYd+aCV2ea+gAMThQSNJKpVoRlcKhNEy97oopPQVZraoyTZbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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

On 2025-09-24 06:01, Sunil Khatri wrote:
> update the amdgpu_ttm_tt_get_user_pages and all dependent function
> along with it callers to use a user allocated hmm_range buffer instead
> hmm layer allocates the buffer.
>
> This is a need to get hmm_range pointers easily accessible
> without accessing the bo and that is a requirement for the
> userqueue to lock the userptrs effectively.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

What's the reason for this change? In the current code, the hmm_range is 
allocated by amdgpu_hmm_range_get_pages and freed by 
amdgpu_hmm_range_get_pages_done. Your change is breaking that symmetry.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 10 +++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 11 +----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  8 +++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          |  4 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  7 +++++--
>   8 files changed, 38 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7c54fe6b0f5d..4babd37712fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1089,8 +1089,15 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   		return 0;
>   	}
>   
> -	ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
> +	range = kzalloc(sizeof(*range), GFP_KERNEL);
> +	if (unlikely(!range)) {
> +		ret = -ENOMEM;
> +		goto unregister_out;
> +	}
> +
> +	ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>   	if (ret) {
> +		kfree(range);
>   		if (ret == -EAGAIN)
>   			pr_debug("Failed to get user pages, try again\n");
>   		else
> @@ -2567,9 +2574,14 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   			}
>   		}
>   
> +		mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
> +		if (unlikely(!mem->range))
> +			return -ENOMEM;
>   		/* Get updated user pages */
> -		ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
> +		ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
>   		if (ret) {
> +			kfree(mem->range);
> +			mem->range = NULL;
>   			pr_debug("Failed %d to get user pages\n", ret);
>   
>   			/* Return -EFAULT bad address error as success. It will
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 744e6ff69814..31eea1c7dac3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -884,9 +884,13 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>   		bool userpage_invalidated = false;
>   		struct amdgpu_bo *bo = e->bo;
> +		e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
> +		if (unlikely(!e->range))
> +			return -ENOMEM;
> +
>   		int i;
>   
> -		r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
> +		r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>   		if (r)
>   			goto out_free_user_pages;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8524aa55e057..12f0597a3659 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -571,10 +571,14 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>   		goto release_object;
>   
>   	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> -		r = amdgpu_ttm_tt_get_user_pages(bo, &range);
> -		if (r)
> +		range = kzalloc(sizeof(*range), GFP_KERNEL);
> +		if (unlikely(!range))
> +			return -ENOMEM;
> +		r = amdgpu_ttm_tt_get_user_pages(bo, range);
> +		if (r) {
> +			kfree(range);
>   			goto release_object;
> -
> +		}
>   		r = amdgpu_bo_reserve(bo, true);
>   		if (r)
>   			goto user_pages_done;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 2c6a6b858112..53d405a92a14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -168,18 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			       uint64_t start, uint64_t npages, bool readonly,
>   			       void *owner,
> -			       struct hmm_range **phmm_range)
> +			       struct hmm_range *hmm_range)
>   {
> -	struct hmm_range *hmm_range;
>   	unsigned long end;
>   	unsigned long timeout;
>   	unsigned long *pfns;
>   	int r = 0;
>   
> -	hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
> -	if (unlikely(!hmm_range))
> -		return -ENOMEM;
> -
>   	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>   	if (unlikely(!pfns)) {
>   		r = -ENOMEM;
> @@ -221,15 +216,11 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   	hmm_range->start = start;
>   	hmm_range->hmm_pfns = pfns;
>   
> -	*phmm_range = hmm_range;
> -
>   	return 0;
>   
>   out_free_pfns:
>   	kvfree(pfns);
>   out_free_range:
> -	kfree(hmm_range);
> -
>   	if (r == -EBUSY)
>   		r = -EAGAIN;
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> index 953e1d06de20..c54e3c64251a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -34,7 +34,7 @@
>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			       uint64_t start, uint64_t npages, bool readonly,
>   			       void *owner,
> -			       struct hmm_range **phmm_range);
> +			       struct hmm_range *hmm_range);
>   bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>   
>   #if defined(CONFIG_HMM_MIRROR)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 901e0c39a594..046ff2346dab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -705,10 +705,11 @@ struct amdgpu_ttm_tt {
>    * memory and start HMM tracking CPU page table update
>    *
>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
> - * once afterwards to stop HMM tracking
> + * once afterwards to stop HMM tracking. Its the caller responsibility to ensure
> + * that range is a valid memory and it is freed too.
>    */
>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -				 struct hmm_range **range)
> +				 struct hmm_range *range)
>   {
>   	struct ttm_tt *ttm = bo->tbo.ttm;
>   	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> @@ -718,9 +719,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>   	bool readonly;
>   	int r = 0;
>   
> -	/* Make sure get_user_pages_done() can cleanup gracefully */
> -	*range = NULL;
> -
>   	mm = bo->notifier.mm;
>   	if (unlikely(!mm)) {
>   		DRM_DEBUG_DRIVER("BO is not registered?\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 6ac94469ed40..a8379b925878 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -191,14 +191,14 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>   
>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -				 struct hmm_range **range);
> +				 struct hmm_range *range);
>   void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
>   				      struct hmm_range *range);
>   bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>   				       struct hmm_range *range);
>   #else
>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -					       struct hmm_range **range)
> +					       struct hmm_range *range)
>   {
>   	return -EPERM;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 273f42e3afdd..9f0f14ea93e5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1737,12 +1737,15 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			}
>   
>   			WRITE_ONCE(p->svms.faulting_task, current);
> +			hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>   			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>   						       readonly, owner,
> -						       &hmm_range);
> +						       hmm_range);
>   			WRITE_ONCE(p->svms.faulting_task, NULL);
> -			if (r)
> +			if (r) {
> +				kfree(hmm_range);
>   				pr_debug("failed %d to get svm range pages\n", r);
> +			}
>   		} else {
>   			r = -EFAULT;
>   		}
