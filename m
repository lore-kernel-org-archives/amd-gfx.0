Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65305C0219E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 04:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0AEC10E110;
	Tue, 11 Feb 2025 04:09:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PaCtEyiS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D389F10E110
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 04:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaV5WQJGwalMe3qEEUTQ/hKJ5xvXaHDorlKOZeBMwtahKM/+RB3OPaF59qq+mYc2qgPq9XgLkTvf+Je1m8ZcyYFIN38zx1wtFgk4P6S03HMSXriH9kaFpVePnjCTyRCvvlPiV7anotSIIcNs/vraSCtwskB2yIngsmXVpSkeSg3wIMxjyMm+ELNm5VOA2C0Qrvo16JZXX8JleX9FzmU6qEcN7ZiPuNjAxf72dtlP8SN9MOtteQRctIk2Uy1O6D1trdHXdwRsYlEZdkX/ZGPOt2oZY1NBMpIE5t+fRQpW7ulXVMpSfccJpIPcDrxRj0q+FcBVrGg+IUpNh3S7gnrLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToknU2aM7Oeaa8PAGI60HDKKRkS6dSswadBKVntsWek=;
 b=PywEzZqeF07lvo+wNkM/v9ozC6MrivJDi5NIluZV3sY0AHBMv8h6xM5NYOdJCWS1nKrw3wsMInLQujdnLHGOQ/cFzUfwREiBUbHevE8zXX/D29uj97QIeL+VNQ7XERkzLG6ryBpjv9OmI7NquZnOWHx0jW5Y2d3tljWWe5Aq/LWKrx0e3bnR78qqolx/NYtStaLX33JMiRJc7J1/H5LYj6R8+g6QkFnng2N0tvoG7LFpHRnlXWYRYwS/cPFD1vp9OBqq2iUC4lgPxHhsDtjtDsOxLwdbEkT3+cZDDyd+hXFKFTpVyjlEZsdkXCTQXDagfwQ9wol2/+IWaztG94faoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToknU2aM7Oeaa8PAGI60HDKKRkS6dSswadBKVntsWek=;
 b=PaCtEyiSmeOx+m0LgckhEKwm8K4MBa3mbn5asYYn8ZuyysUYCHaceACd0mitzgZvGADg9Ksem1PARbBlaxRdFJbVtspJNeIrL4iH8eBLW3u2RnLvDBBLWwcWRX1B72jB/YZiVv4ayaSX4o9oValLc+GGrHudEZxyHDLGcdZ6Oic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 04:09:14 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%3]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 04:09:14 +0000
Message-ID: <6f8f1c9c-d85d-4fac-973b-9d3ef6495dd0@amd.com>
Date: Tue, 11 Feb 2025 09:39:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/amdgpu: Per-instance init func for JPEG4_0_3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
 <20250210142548.2321625-2-sathishkumar.sundararaju@amd.com>
 <2fd0d40a-db7b-409b-84b5-6cd47eec12e9@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <2fd0d40a-db7b-409b-84b5-6cd47eec12e9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0202.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::10) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 587259fc-abcf-4bde-9921-08dd4a51d89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXVNWVhCRHJYcFFtZmlnQXZVV2JIZ3Ryc2l0NVAvbWFScFI5bFhSVCtvcVBG?=
 =?utf-8?B?ZjF2dlp0UWhxbXRpRGZpZldNRDEvc2RvM2Q4bVF1VXJtVXlLbFFmN2ZVbjN3?=
 =?utf-8?B?WlRMVUxpMy9PeXNuVjQzVGxndTBlYzRBZndLVVpkcml2QU1NbzNkSFZMNGdr?=
 =?utf-8?B?SG5zMHdYKzR4Q0RwZ2laNktMdExyK1R2LzJRNlAzMXFRL3dKcnJ1aEVSVGpw?=
 =?utf-8?B?VFFsQXc1K1cwTm85WDNSSUVrSmlKcU9aWHJ6ZW5ROVR6S3IrZ1g2K0JhcENk?=
 =?utf-8?B?TnZjamhrZm5zL0xsZjNTbzVvVC92c2g4NkdVZ0xNa0NDRG9ia1Z1QWtEL0g5?=
 =?utf-8?B?d2hQakhLSDJJd3pVeWJxVFh5R2kzVDJ5Y1VIbmlWQUZreEoyZW1RKytkV2pp?=
 =?utf-8?B?M243S2tRUTBUUHRiM2ZodnpONFQ2YWpTYnBad0w2UEZGams5VS9QeGMzdW9H?=
 =?utf-8?B?U3Z1MEhNaDZ6MlI1Slh4WjNzRjRBa1V5Ry8vcjcxNUl2ZS9ZaWlvTXBJaWlw?=
 =?utf-8?B?bGpQUHdXdEYwaFZoaVJCTHozUUJ6eTd5cnZEVEZrVnlZa2xMU0pLRDFzYzZI?=
 =?utf-8?B?bHRhd0lsakJpV2puOG4rOGtMWGZpRjI2QWJOU1dGYUpaNU9uUWhTUlYrZVdt?=
 =?utf-8?B?M1QyZHBKVVRJUEkyQnljbnBDTlFodHExcy9NT3lDdVdEWkUxd290K0MxTDZV?=
 =?utf-8?B?Ni9jTU9vRkJlUnhxYkJVMGkvYmhSRmNXNTlaeVJTYTZXbVowTXRBVkZLQU96?=
 =?utf-8?B?SW9RZVd5RGZoWXRPVjhXakc1WXFmUGF2TlJZMzZxK0pSMjNOcW9JcURURGlH?=
 =?utf-8?B?bk93SU85dEY2Z1pyK0Q0c0tRdTZaT0FZWFJNQnJESHJ0eHoxWkJlekMvc29H?=
 =?utf-8?B?YlFFL3ZBNG9GN3N4bWoxZmlJMTYzWkZia01udWJQL01TSHlKeWFUSnUvVVhw?=
 =?utf-8?B?aGc0VkJSMHJ1WVQwVlpZdTAwZE5lNGFHbTRFc2FPbE81WUF5S2Q5VGovRHJH?=
 =?utf-8?B?SHB2anlWR3pPQWhjQ1JpeGFpcGk2TWxBWDhtUWc3bzBpZHRVdGNRVDd0bVZN?=
 =?utf-8?B?QmdCUmllbUZYT3dDcitqZjZ5ZWRxSWQ5SDZ3dkNKYmljVnpYNExVaWtXWjQ5?=
 =?utf-8?B?UTdOZjJZTFFkQkJzY3hoWlF3MS9qeHp1RkVYc3ZrdWpFN0RHcHVPZ3ZmdVlM?=
 =?utf-8?B?K1F2YkJBYWljZGpEb2RYZzZCeEhvcUNzQmFYZ095Y1BmeWZKWXo3dkJSMW9D?=
 =?utf-8?B?SmlITTNJS1BlWVFTK2NTdjJSeUF6LzhsUjZ0MVdaSmI1Q1YvdEJ1eG9aTTdx?=
 =?utf-8?B?QUd5ZFdBWGRRdEZVV3o2L0pQeDNhdmZYQ2sxdU4rRi85cUJlakN1RmdUYlBM?=
 =?utf-8?B?ZXJoQ3FucnR2bDUvUG9iZmRRdGh5RVVneXJUWG9ESjlWQ2hwRTA4VzBPTXFo?=
 =?utf-8?B?TXhwWTlsdCtDSmo3OFBZdFJiaTIrT2RCZ0daQ0xYTXg4UnJWeWRmK2JETE4y?=
 =?utf-8?B?UVozdWpycEtuWXhkN2ZuNXFDWGNJOVh2azcxdWZnd0wvMHpoTGsvYVp6WEQz?=
 =?utf-8?B?N0k3THA1bENjZFBCT3oxVWdYUTlja1F4NDNoMnZ5ZW50bHBZdlY0cHU3eGxC?=
 =?utf-8?B?MmoxeDFOSTNmdWhnd2wxc0lXMExpcE0vNldHN0s4K0NFdFZwcEhXMHpjL1FL?=
 =?utf-8?B?UnJCcGpJNUIyN2laUkxkVFlJZEtZSExQQmw5S3FyeTc4YllTSkJnSjJJZHJM?=
 =?utf-8?B?aGxRMlRhOG9vNDd1YTZCb1BnalBicE50N1FzeUxKQ1FVd3JvQXZDcUhXNFJX?=
 =?utf-8?B?aTNKUFVyUU9QQ0tUL0lGcmkvVG9acEVWOVVjd1NOQUpoMFdBTmJ5MlhHYU03?=
 =?utf-8?Q?sc/viyiCSGsW/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHRDaWlpNlM5d2l3Wkc3d0Zza3M4YXRpcHRZS0hmeUxnTi9va2tpb3k1OExW?=
 =?utf-8?B?bmhhUTFGcFhwRnd1QlFjOElQNTNONWwvRmF6SzZuUXV1V3E5a3hxdGFYbGZu?=
 =?utf-8?B?eUhFam9rWnF1TllrMWNyUHBXdU01ZEZxUjZvaUljU3NJNHQvcmxCLzlmVXJh?=
 =?utf-8?B?bEphRkN5V20zTTlJd1FNNVc3N1A0bVVGTnNvVEt3VnM5b2dDNFZrVXk5NUp0?=
 =?utf-8?B?SkM1K0tudmUxS21zbE96VUg0QjR3cC85N0VuOW45ZHhkdVYvd0c3Wi8wRmEw?=
 =?utf-8?B?dWtNOHBra0FOaUdFWk9UckhzNU9FWW05ODNMMENrTVhzbmpGY1EyYWY2VGs4?=
 =?utf-8?B?Q00yQlVWMm14QWJRcy9uUmNHckZSYlcyYi9BZ0hsUEtlcjNZUExUQ1ZQWVdE?=
 =?utf-8?B?Z2w1dW9HSm1RMFErRTh3UFZ2UVpoS3FlNTNkVTVzemRORm10OGRzWG1CMlRr?=
 =?utf-8?B?SmtmaGxnTDU2aGZXQzZidCthdE1FYXNPa2s4VE9UTW83MnZ4TXlSSzJBb0p1?=
 =?utf-8?B?Z1MxL25WWVpJWUxoaW1QbFhTY1pJL3pUZ0g5ZGplK0Z1ZGR0QkwvemZlMXl3?=
 =?utf-8?B?dUh4cmNBdzd4dGZoajZKZFhnTHg4REtSVU1UZko2SG5ldFJUS3NsTWVKbUhq?=
 =?utf-8?B?eFdTTnJwZ3BXSlB4NUt6eXh6ZDhITGtkdlJXbXdDYnBIdGNza0FRcjUvakxM?=
 =?utf-8?B?cFExa0lBK1dkc0ptQ3oxdGh5RDRKRW54TXhrRnNCZU5mVUZXQStYdW5CNE9s?=
 =?utf-8?B?Z1p4QUd6NnJ6Y1dzd0FSYnNsZnpTRlBqaEg5WnJhcmtHZllmaURFRldHZEU5?=
 =?utf-8?B?Vi9sTHBud3NQOXYzR0Q3QkFpUzB4WjF4M0c3ZmltTXRCaFZmR2FMTWZwOVlQ?=
 =?utf-8?B?YkRWMUJ1bzNlZXZqUzlEZGZZdlNrb2ZhWGNIM0luYisvT2gvcm1oNmRSayto?=
 =?utf-8?B?NGtJMXhYUThSSnNNcmZJYlY5K25nTUZRdmVDRnZ0RFZRc1h3SE54ajhEM1c2?=
 =?utf-8?B?Tm9ZYVYzMEVFS1UvVzBUSksxM2xZcVl0dU40a1dnSGF2SThZS3FnendlbHR6?=
 =?utf-8?B?dEc3cXBNamgxTnM0cHlDOElmOTZ4ZXVLUjJ4NTIrZERxRHEwZmdTdGQ2WFVL?=
 =?utf-8?B?SkFVb3JYZENLMG4rZCtVcldWZzV5bCtFMmpyT3ptVWduN2dnSjFNMDdVQVE5?=
 =?utf-8?B?R0NtbzNmTzV2ekdQQjY1WFI5dW9zZHAvQ2lHQ2UzTlplWWQ1b1h0Ylh2Tk04?=
 =?utf-8?B?NkFuRVQ1Y0FBdUdROWdxSlRKNlVUbFJNdVRSUWNkOEdPQi9TVFdqR0h3VVpr?=
 =?utf-8?B?ZGN6VUJVTmhOd0I0RXhwUGU1T3dxampLYVNwWkF6azZaSnBTWmE4bzlTNW9t?=
 =?utf-8?B?eUlNQkJJbms1SDhkdWNsclA3VEp0c1NCSHEvektoWWo1eCtvbFZGME8vUU9Z?=
 =?utf-8?B?ZWdHUVVRbUFFdk9mdldUSU1ZNlNLUE1ZQjZOY0tiLzl6bHB5TDFac1dBVFho?=
 =?utf-8?B?OGVYNml2UE9VaW52VXNLNGNxMHVFM1NIMDRrTDBhT1pOcGJxbVpNckdKWFZu?=
 =?utf-8?B?K1h3WHBoOWt3Y0p6a256ZjYwWE9NQWZpRm9aVGV0bEt4L0hIMkJNMWo4OGl5?=
 =?utf-8?B?TXdFVEkyVWhVSUp2d2FDVDFzYTlobSszc2VUQ1hjanBoQ3NtMlBUMWtkcXBB?=
 =?utf-8?B?Vmx6V2Q5ckc4YXRUMjRrNllJRnA1b1dhNDVTb09KdVNOUnVLZXJ3RWE3V0tP?=
 =?utf-8?B?cStyakVpTHcwQTVYdFVtbGxCK2RRV3kvRHhRM1pZS0VNUkVvbW1JT21nWjN6?=
 =?utf-8?B?ZjI2ZllXcUtSQU1HWDh0eTI1bWQvazNyaVBzN3JqOVNnRDJUODhBMjc3cWRw?=
 =?utf-8?B?dENIMFRDSEo2SDNWUjl0ZzZuS3BCQXdtbjBOQkRXVTB2N2dxaUN3YWtWcmtD?=
 =?utf-8?B?L0d5aVk3c3BOczc4cUlhVG9PZHpPTEIvem1PK1o0b1AxZ3I3czZ0eWI2UEkr?=
 =?utf-8?B?L1ZJbmx6ZCtIRVpvM2xaV3dLeTcydkphbUJhK2d0cU5rN3JQMEZIL3ZDTWFY?=
 =?utf-8?B?dkdNKzJiK0pVRWorSjB0eTFLUnV1TTdUM05senVMUGZBNmNoL1g1aExSRzlm?=
 =?utf-8?Q?ZKisfYEh8LeYXrFSssvO6/hA+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587259fc-abcf-4bde-9921-08dd4a51d89d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 04:09:14.6537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLBakowtIz4eUBISsKMAZRh8EqTcp03OY6SC2yZZX3nVqfxvZRJd+zy0RHJLClVSLbjrHT8cOy+IYb5mjOa33A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
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

Hi Christian,


On 2/11/2025 12:52 AM, Christian König wrote:
> Am 10.02.25 um 15:25 schrieb Sathishkumar S:
>> Add helper functions to handle per-instance and per-core
>> initialization and deinitialization in JPEG4_0_3.
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 190 ++++++++++++-----------
>>   1 file changed, 98 insertions(+), 92 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> index 2a97302a22d3..be0b3b4c8690 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> @@ -525,6 +525,75 @@ static void 
>> jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>       WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CGC_GATE, data);
>>   }
>>   +static void jpeg_v4_0_3_start_inst(struct amdgpu_device *adev, int 
>> inst)
>> +{
>> +    int jpeg_inst = GET_INST(JPEG, inst);
>> +
>> +    WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>> +             1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>> +    SOC15_WAIT_ON_RREG
>> +        (JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>> +         UVD_PGFSM_STATUS__UVDJ_PWR_ON << 
>> UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>> +         UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>
> Please double check the coding style with checkpatch.pl this here 
> doesn't looks so well.
I did check the series with checkpatch.pl for 0 errors and 0 warnings, I 
can realign this to the usual way though, thank you.

Regards,
Sathish
>
> Regards,
> Christian.
>
>> +
>> +    /* disable anti hang mechanism */
>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, 
>> regUVD_JPEG_POWER_STATUS),
>> +         0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>> +
>> +    /* JPEG disable CGC */
>> +    jpeg_v4_0_3_disable_clock_gating(adev, inst);
>> +
>> +    /* MJPEG global tiling registers */
>> +    WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>> +             adev->gfx.config.gb_addr_config);
>> +    WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>> +             adev->gfx.config.gb_addr_config);
>> +
>> +    /* enable JMI channel */
>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
>> +         ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>> +}
>> +
>> +static void jpeg_v4_0_3_start_jrbc(struct amdgpu_ring *ring)
>> +{
>> +    struct amdgpu_device *adev = ring->adev;
>> +    int jpeg_inst = GET_INST(JPEG, ring->me);
>> +    int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
>> +
>> +    /* enable System Interrupt for JRBC */
>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN),
>> +         JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe,
>> +         ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe));
>> +
>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>> +                reg_offset, 0);
>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +                regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>> +                reg_offset,
>> +                (0x00000001L | 0x00000002L));
>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>> +                reg_offset, lower_32_bits(ring->gpu_addr));
>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>> +                reg_offset, upper_32_bits(ring->gpu_addr));
>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +                regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>> +                reg_offset, 0);
>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +                regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>> +                reg_offset, 0);
>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +                regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>> +                reg_offset, 0x00000002L);
>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +                regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>> +                reg_offset, ring->ring_size / 4);
>> +    ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst, 
>> regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>> +                     reg_offset);
>> +}
>> +
>>   /**
>>    * jpeg_v4_0_3_start - start JPEG block
>>    *
>> @@ -535,84 +604,42 @@ static void 
>> jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>   static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_ring *ring;
>> -    int i, j, jpeg_inst;
>> +    int i, j;
>>         for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>> -        jpeg_inst = GET_INST(JPEG, i);
>> -
>> -        WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>> -                 1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>> -        SOC15_WAIT_ON_RREG(
>> -            JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>> -            UVD_PGFSM_STATUS__UVDJ_PWR_ON
>> -                << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>> -            UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>> -
>> -        /* disable anti hang mechanism */
>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>> -                      regUVD_JPEG_POWER_STATUS),
>> -             0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>> -
>> -        /* JPEG disable CGC */
>> -        jpeg_v4_0_3_disable_clock_gating(adev, i);
>> -
>> -        /* MJPEG global tiling registers */
>> -        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>> -                 adev->gfx.config.gb_addr_config);
>> -        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>> -                 adev->gfx.config.gb_addr_config);
>> -
>> -        /* enable JMI channel */
>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
>> -             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>> -
>> +        jpeg_v4_0_3_start_inst(adev, i);
>>           for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>> -            int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
>> -
>>               ring = &adev->jpeg.inst[i].ring_dec[j];
>> -
>> -            /* enable System Interrupt for JRBC */
>> -            WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>> -                          regJPEG_SYS_INT_EN),
>> -                 JPEG_SYS_INT_EN__DJRBC0_MASK << j,
>> -                 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j));
>> -
>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -                        regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>> -                        reg_offset, 0);
>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -                        regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>> -                        reg_offset,
>> -                        (0x00000001L | 0x00000002L));
>> -            WREG32_SOC15_OFFSET(
>> -                JPEG, jpeg_inst,
>> -                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>> -                reg_offset, lower_32_bits(ring->gpu_addr));
>> -            WREG32_SOC15_OFFSET(
>> -                JPEG, jpeg_inst,
>> -                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>> -                reg_offset, upper_32_bits(ring->gpu_addr));
>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -                        regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>> -                        reg_offset, 0);
>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -                        regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>> -                        reg_offset, 0);
>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -                        regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>> -                        reg_offset, 0x00000002L);
>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -                        regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>> -                        reg_offset, ring->ring_size / 4);
>> -            ring->wptr = RREG32_SOC15_OFFSET(
>> -                JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>> -                reg_offset);
>> +            jpeg_v4_0_3_start_jrbc(ring);
>>           }
>>       }
>>         return 0;
>>   }
>>   +static void jpeg_v4_0_3_stop_inst(struct amdgpu_device *adev, int 
>> inst)
>> +{
>> +    int jpeg_inst = GET_INST(JPEG, inst);
>> +    /* reset JMI */
>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>> +         UVD_JMI_CNTL__SOFT_RESET_MASK,
>> +         ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>> +
>> +    jpeg_v4_0_3_enable_clock_gating(adev, inst);
>> +
>> +    /* enable anti hang mechanism */
>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, 
>> regUVD_JPEG_POWER_STATUS),
>> +         UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>> +         ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>> +
>> +    WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>> +             2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>> +    SOC15_WAIT_ON_RREG
>> +        (JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>> +         UVD_PGFSM_STATUS__UVDJ_PWR_OFF << 
>> UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>> +         UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>> +}
>> +
>>   /**
>>    * jpeg_v4_0_3_stop - stop JPEG block
>>    *
>> @@ -622,31 +649,10 @@ static int jpeg_v4_0_3_start(struct 
>> amdgpu_device *adev)
>>    */
>>   static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
>>   {
>> -    int i, jpeg_inst;
>> +    int i;
>>   -    for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>> -        jpeg_inst = GET_INST(JPEG, i);
>> -        /* reset JMI */
>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>> -             UVD_JMI_CNTL__SOFT_RESET_MASK,
>> -             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>> -
>> -        jpeg_v4_0_3_enable_clock_gating(adev, i);
>> -
>> -        /* enable anti hang mechanism */
>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>> -                      regUVD_JPEG_POWER_STATUS),
>> -             UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>> -             ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>> -
>> -        WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>> -                 2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>> -        SOC15_WAIT_ON_RREG(
>> -            JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>> -            UVD_PGFSM_STATUS__UVDJ_PWR_OFF
>> -                << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>> -            UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>> -    }
>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
>> +        jpeg_v4_0_3_stop_inst(adev, i);
>>         return 0;
>>   }
>

