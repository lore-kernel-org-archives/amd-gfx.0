Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FA4C7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 07:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C41F010E682;
	Wed, 25 Jun 2025 07:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j5iGOpYr";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B469810E685
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 07:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5isj7yWsTi37v+coQjvewNKeCHoqg6Rq09apw3FkC1//OLbl2gFu3VVDsNPaN1A+6fApJ7eabvr8/kOr3OCdUIeDt9pTUf+Z7bgWiEbAFUuX6uK0UCP1Arm8wgNOz/tGJ+6DsK4A9pZ/0Xqp5cXaW3T/w7PXI63dR77Cq1ofVLrzavWu90+c2GfhLsfdRtp6fcJ+rh4UTemCw9cWLrRSAZvRbaDs91ouoWtXA0mtWYU1sYekDWz5jkiBIC6oyaphVkG7WVMen3sbfwZesVBGvCQgLod2o/toGWPVUQ05YK1bXKWG43SHGjKHCpJkW9DIQlAPW6SPVVFK56502TF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sINgIh5OU9vx6WA2gfwTFV37uoDd7mTSHoOd1bbnGf4=;
 b=l5SJ8gEVbSHJ4dVZ2b0YwfX2rF6WuNjHEZbwBq9FQQN1Pyi3g++8TftUW4yqZCu00e2ksogIHA9EX8t/3ZP+GHZ/LYzQ/cBX1hEaxeuxwzmWsHT5nzyYHc72vGZztJl7hk+ZxUB71nxOF0uFBZbhD4ZC/yrGal6FwiMhc48FZqMnOmACIydGSBB93bVj/jxtuxgmU116XLPRjJ7BOrI4LD/XvVgGl8URd2h2j1ZXCfiZ7/wSit6tD4bwlzCeHfWhl9R4Wm8xwZZKRhpgPsN4ARdXksttXUlYhBD0iDEyvpQefcee6w8NNq50nY3VkXU/leQcdJlQP2ICusgdP3PQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sINgIh5OU9vx6WA2gfwTFV37uoDd7mTSHoOd1bbnGf4=;
 b=j5iGOpYrzJr7GcfSJQxymXf7gSaB288imZb8Jb0O6Qulmh/r/ZDSMRjR4FzNuDwiOHN6IHTf5lKyLQzpfc66vcBZFrJrQGbGjGLvP4nb8g3t1Ok+YBHz6a6+khco7UTvaK3e8KaLryf8jgivsmedNOe3Rs8OLy35ij5TDKMT1aA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 07:51:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 07:51:43 +0000
Message-ID: <faed435a-1f15-4a77-a66e-2e03062699a7@amd.com>
Date: Wed, 25 Jun 2025 09:51:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] drm/amdgpu: add user queue vm identifier
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-7-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250624084535.1178476-7-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4431fd-7308-4710-5480-08ddb3bd20bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDk0dG1BWTFpNWwyMmxlYjhyYnoyOGtOQ1RaNFFlUFZWK3A2bmFmQ2FNbTg0?=
 =?utf-8?B?TkpqdStpdGZpSTZEazZjazNtQXNVMGFLMzF1VURGTG9nVkxObmhlVU4wUTJH?=
 =?utf-8?B?OGZocWR2RDFEZjFUNEtZVWxoaXAyNGlJblcyTWVhUUZmeFdsbmZUVVZaSUVE?=
 =?utf-8?B?VXBEYUdRdFhuM3ZIdk5NUitWei9WRVJJeHhNeXg0cEhSVXJ3Q1hiWFozR1V4?=
 =?utf-8?B?dUdQSlVhbkViWk9RdUwvTTdUaXk1NllaMXpmSVVPVk5mekNleFp5UnVsancw?=
 =?utf-8?B?WWpyK0o4SG56alhmVWZKM0dmT01mMFRPNm5rUGdPMHJPNTlmQVFmOTJNUEwx?=
 =?utf-8?B?ZXhIUFJ6WEhneFMzWjlRY1JjMHM0dVpteW5WWGVhdW9KclRLYTBPSDJBOWht?=
 =?utf-8?B?TU1OUXhpUjUxcGhKOVhKZHorWW5Na2czVllhdGZYU2NKdUptYVBFSDNzaGlK?=
 =?utf-8?B?NG1wcDNmMUlTUjBiUkdRekVlRnZ5amhieEtmcC9vWlF5M0YwaHJlTjY0S0tN?=
 =?utf-8?B?a2lMU3BhaUVTMWNnT0NLemovUTdxVjZqeG9nODg0c2pCRFhvMjNtQWFNMDZP?=
 =?utf-8?B?dndhWksycDF2VkhySngwTW5sekVWelpsTUt6VllNSTlWMFlHS1dGcys4eUdJ?=
 =?utf-8?B?UTB4eUdrOStRSThNemdZWjNFQWVsSVNGbld4bkdaV1Ixbmx3NTJKdktwTCty?=
 =?utf-8?B?UGdWVFNJMEcwYmM4b0ZLbFdveXB4V1VKaG42c09Kdm1tN2phM3pJWFRqcjhD?=
 =?utf-8?B?TnZ5ZHNFN1RpMFhHUGg1Z1VUSmRBU1BtQzYrbkx3bnVCcm9LaCtnZEkwRFdI?=
 =?utf-8?B?R1ZwNU12UDAxZDVibDFhSUlodzFsL2cyeHRPWlBkdXhETHp5ellESkZCY1hE?=
 =?utf-8?B?QWN1MjlheVJieHdlVENkSWlOM2NiMmtNNWlVTzJQc3RIVlRPOGV2YTBNMjBX?=
 =?utf-8?B?aEpoT1d4VVYybjE1UWhDZk05N2JlQy9acStoL0NXMC9LOG5UZVZYVmpqVzQz?=
 =?utf-8?B?UTIvS0I5bmZzelNSaVp4N00yM1hNK0ltUVdYNzRHSm5tTm9wbjdrdE12YU83?=
 =?utf-8?B?TjNML2VBMXBNdEJBcy9vbWtZNG42Zmg0enRHV0Z3dzZuVU5HVmlwNWZXL1dM?=
 =?utf-8?B?L1dRc25yazg4MW5oajdPbGhSN0NIdGpyMjhYR1hmZHdDOWhrNTllNFhBR1Q1?=
 =?utf-8?B?UWZQZ09tNEU3THJjTjNidnF6cWpOdURsczdjaEgxYlNkbEoyc0p3TVloTzJV?=
 =?utf-8?B?b21NajkzYWlaUWx5UWpySy8zVjYyTGM4bnZ3eEZVcHlZQ2NCbUh0bUV1b3NJ?=
 =?utf-8?B?c2lacWpTcDRSeGtLY3BuenhPb2RhejQrQ0tzZG9HWHl0QzZPVGFiZW5TUll3?=
 =?utf-8?B?M2dKOWs5MTNiRmdLU2RWajF6eE01c2lTdVBXUFNtY0pWUjdnK0N2TlQrc1VF?=
 =?utf-8?B?NW9QdVRheGxMT3lIdGJZVGQ5OU5QTitjdTdiLzZPY2FrcUxrRlBjOEJScVNk?=
 =?utf-8?B?dVJUYWpUVWZZZ0UvTXl2RDNQWXJZL2ZmUTY3SHRkZVZLUVoxeVd1TlovVHVH?=
 =?utf-8?B?R1czaVBqa2FzV0RBM1JGUHViSkhiWjBFL1lIbnFEdlltUTduNVFONFZRV1FL?=
 =?utf-8?B?SzJVeWNtVXJ3NnZyakZJZlI2RTFieDJ0QjdWUVVxbXlPUzliY0FqTmkyY3or?=
 =?utf-8?B?eXNYNnlIMW1TWU9RQU91ZS9ranF6S1ErUXBQdVJFWWZnUDZRakdyb3pNQ1pa?=
 =?utf-8?B?UFd3dlA1MWQ0Mmlyc2V3T0NWQXVVMlc1U214SURVMXlaLzgyZ0lmTmhxRGNr?=
 =?utf-8?B?ajQ1SHhqZXhuRVZSZTZDbDBNNkYyaXhDYi9qbHcwVTFrQ29BbjZXME0way9n?=
 =?utf-8?B?ZUphTFhTRWJnTFRtcmo0bnFxNnI4aUJ0VEFydklNelh4MS9yODlNUzR5Z1kx?=
 =?utf-8?Q?0zupNa4V3UY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW9NMmhjTUVMVnRzTzgvbFQzcFpaNi96VzV0MExVSWtNSE5Ncmc4TFFacUo4?=
 =?utf-8?B?blJuOEhKeVhWVTkxblUzRHJZZlNMb0w3SGJiYk1Uc1oyUHZYNmNsc0JXekZW?=
 =?utf-8?B?N0NrNEo2SUFMazczcTFnKzRGSCtoMjY1cTdBRlZSRC84b3FpR0gyNWlzdnNT?=
 =?utf-8?B?SlVhQ0FDZGludW1aS0pKV29kK2s0dFo1TnJjeGNrWkw5OExLV1hZY0JCYkVB?=
 =?utf-8?B?U09SMVRXcWJScGhrb0U4VWNhbXl5dmRST3VMcnV5SHRpOVpWZ1RwZm1ZRE5Q?=
 =?utf-8?B?aXkyaTdtYnRsSm5neWU2YVJCZmJNZW01QW9NTFNRaTlPcHA0WmRGYnRyb25r?=
 =?utf-8?B?b0pCV01Xd3VsZXJLanBFQ1BiWmdpaXlMdndTV1JodDhqSGg0OHUwNFhKQXlH?=
 =?utf-8?B?OGI1ZkVZNElQOFAwTWZGTnZmQVZPM0tXdlIwZUJPQ1laK29GanhYMHZvZy96?=
 =?utf-8?B?NHVvdEVkdUc4TFB0UUF3Ull6SExMZ3VKb0xIeWtQeldHbjl2YWw2cjFtaVQz?=
 =?utf-8?B?bHl6UGlldU5kbU9EZFJWZmpxNEZqZStGODhnUk0xWDdJbks0Rk5Ndld1Zlln?=
 =?utf-8?B?RmtoaGRrNG0vcHFqTTljNVNCM3JOMENydGFDdVZtME11eWVXV05ScmhuNVNI?=
 =?utf-8?B?N3ZTYnJhR1ZUbWJhTVd3cCtrcE5xQ3JYbDhreHBNcG1UN2hwVVE4NDVSZDI2?=
 =?utf-8?B?OHdFL3NSRTNiVGJpT3R1bkU5elJDRk9pdk0xcmZtMm1KeHVNQWZKcms3K1hm?=
 =?utf-8?B?QnlMVFJseGhIcWVlbUplVXdyb0JIQWZYVzVmMnJZSGxlY0tUYmVUUmhoZUFj?=
 =?utf-8?B?VlRVNmdqelVUREEwQ0Jaa1Z1TFI5bE9tdU9mcEFqNkZsWUtUUjl5WmxUM3Bq?=
 =?utf-8?B?TFZUTDlOcDc5TnIvUXZ1SEtBOVVOVEpjZWhFaTMwMStsNjF4Yi9OZVZBTWRo?=
 =?utf-8?B?YlBvbWhjUFhwUUNXS0dDMDdyNXU1RFhiUjVILytuSVdxVFpNS1FBUVRTcVNq?=
 =?utf-8?B?N2ZnbUx4bzNUWUZWZmwrR2t1UEpwVWMyZGtxNEtkY3Mva3VDSTBsQlJXVWdl?=
 =?utf-8?B?ZzV0c2FWSVJzcEdlL0dISUowTDFaZDhkc0FBaW52RzJ6UEhISExUZWJPZEd6?=
 =?utf-8?B?TkYrWC9LRkFqcDlVRmNTVUtJKzhDK2h6RnQzb1laMisycGpVMVpMakpKNDFG?=
 =?utf-8?B?UW1VUDY5QlFwd1Y4UmVXVWlMbVdKa2JRd3dSRUw2b29ZaUhmY3M3YW14WFJx?=
 =?utf-8?B?dUdUTjJsZXFoKzJobncrbkhKVnlvTFNuV0VnMS9IdkdjSW1OeTRHTzlHeG9M?=
 =?utf-8?B?L1h1U2xqcmZ0bzUvWWhWbUU2aCtLUm56SDR3SjBmU0dGeXR0d2c0QSswQXhK?=
 =?utf-8?B?YVF1QjRXK3kxZ2ZKNGxFMDRIZmtBeW8ybU1FME1YR1Y4QWFSMCtoZm02WG1t?=
 =?utf-8?B?UzM3d1BWenpiZXVWYlVDOXNoR250cC9KdWR3S2FHYVlMelJTVlZnWkZTdTJV?=
 =?utf-8?B?cDZOcVRLWlJESTdtekZaRTZlaWVKWkNWWVBNSWFzQnNXS2tERWFMd2VGUGRD?=
 =?utf-8?B?V0ptcmtGaDR6T1YvUC94K2EyOXNWRmVUa3dzMUw0bkNieEJ5R0tRUVgzWHBX?=
 =?utf-8?B?WlVJRCtEQll1NWdJTG9iMzFYdElabUFJcjA4U0tPSmhoc1dHb1lkVTh2VVZM?=
 =?utf-8?B?K1libFdrME9tMTZpalIzemQ4dXNYSjVFS20zbVE3NktnMUNVY0llRm5leHEr?=
 =?utf-8?B?T2l1dHhXcjFrT2hyRENUdVY2N2VQVkRxRWNKODRJVEtqMzJyeTRGYXYwTS9u?=
 =?utf-8?B?bUdzeVhoUzIraWtUSzF1MXJXVGcrQnlaQXpBMVlvQjhydUtJQjZscEdQKzF3?=
 =?utf-8?B?TXBiNWwyMUhQY2FEUzN2Z3hpb1huQThDU3RRb3dxMEQ5QUhJOEJRYlZiT3I2?=
 =?utf-8?B?NmRBNGFoZkNlN0hkUUVRNHpBeU1KSFUzUzhQMDh6SGRpSHVOMlV6RWpNMTNm?=
 =?utf-8?B?WkNJd2hmM1FnakVrMlhoVnF1TzA3WW8xWVBlRGRXMkU4QXlTZzRiRUZzOFcw?=
 =?utf-8?B?V083bjdscE9CR3V5eFg1VzlaRitEMm1IYXRhbytzQUlDQnJNUU1oc1lQUTY3?=
 =?utf-8?Q?Cv0otxcnL5ad5O50/UFYWvmet?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4431fd-7308-4710-5480-08ddb3bd20bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 07:51:43.7694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hgRKr76kaag1gK3JpfzSG5iRhlUJeSMmr9JiDW6jpaAl6lSIrP3yFLbRsbvLwd9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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

On 24.06.25 10:45, Prike Liang wrote:
> Add a user queue vm identifier for each userqueue
> kms opt accessing.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 79b263c18eb1..0208c6b8a8e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -501,6 +501,8 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
> +	fpriv->vm.is_userq_context = false;
> +

I really don't like that approach. The VM should not have any special handling dependign on if user queues exists or not.

Why do you want that?

Regards,
Christian.

>  	return r;
>  }
>  
> @@ -535,6 +537,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
>  		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
>  
> +	fpriv->vm.is_userq_context = true;
> +
>  	r = amdgpu_userq_priority_permit(filp, priority);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3911c78f8282..5e075e8f0ca3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2560,7 +2560,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
>  
>  	vm->is_compute_context = false;
> -
> +	vm->is_userq_context = false;
>  	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>  				    AMDGPU_VM_USE_CPU_FOR_GFX);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f3ad687125ad..1e3c0f85c98e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -422,7 +422,7 @@ struct amdgpu_vm {
>  	struct ttm_lru_bulk_move lru_bulk_move;
>  	/* Flag to indicate if VM is used for compute */
>  	bool			is_compute_context;
> -
> +	bool			is_userq_context;
>  	/* Memory partition number, -1 means any partition */
>  	int8_t			mem_id;
>  

