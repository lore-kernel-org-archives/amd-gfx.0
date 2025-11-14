Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9212CEACD6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 21:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F82110E271;
	Fri, 14 Nov 2025 21:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EgInfAGi";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B00E10E271
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 21:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEjyqQtQMya16AfNSjkYw1N/bn23a5CMTqLdnrsC4uHolRkWmoiX6JHVrcVTF2tWQmbLruBQ2Fe6A4qlO5DCqbSRLBgt08yG3jXDZnPM4Cs1tM3a9yit4p0ZhB4Nok51TehAfH9mIYq5zrhi3xUye2wQe86S8h5M2eYUOgp+kUNTY1mgGaAKUYUPW5ixWplfPtPcNvMuHafOP77/LYwg6qgqAC5q2YbV8tEJyH+IkjmgUrTGaxYSgzjqvqAkSjG5EEj36Fn0JEfnEdl/WS7cJoq3kpfEKp1/4eV6tXEn1+ISlAQwor8wmkLANHpbQHwt0008HY/7EL2SoV3BV0l0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skNTjpiRXsEIkAlD3fmPGNXjZlHbe35ujvY26T3lVdU=;
 b=ETC18noDtbx52lVdZX9x8XFxYlE2Ig6e9JxtRnOBfbp2dZte1qHhVZEshmqy4oLsuGnwdykC8OXcdCkHseZDHO/KVscsSQjzPpjlnOJtu0xbB+ChTHDTA22cF6TjGMvKsd6Dztd3oBEq3YedXw3qveaZp3aPW9AcNZHIuDRsxCr1+OOFeAHuRut4l+ylqFu7KLnNfAZDSTdouHbcdcXPVKUwZQAP8AExHQ/Rx3NyuUFD4bG0Ku6K0nlY0sOvtOxccm4WAgP8J89RJvDNXyVsLK7KRNAd86dhJn6k3r2/n35uL2bEzIxPdUbCs7NodWDLB9YoJqGRAlr7RzDemo5fvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skNTjpiRXsEIkAlD3fmPGNXjZlHbe35ujvY26T3lVdU=;
 b=EgInfAGiD7Ypjs5avnRZi2V4WbxSeBu11sDu4mL2aouVF9bodfyG4YJOId0ECCNrTDnyUEZmS68nXVGRYNoAo4RWZbsSkZepYtvOgqtbbxk4FqbL5WX5fl0dwhdKiSE7E+v49dNVwdu1m8rAyhjhUp4S4dI5nCZOhIJe+aidv7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 21:58:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9320.018; Fri, 14 Nov 2025
 21:58:50 +0000
Message-ID: <dc1b0471-448b-44a7-b7cf-9f094dbc1545@amd.com>
Date: Fri, 14 Nov 2025 16:58:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Ignored various return code
To: Andrew Martin <andrew.martin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251113183155.1120872-1-andrew.martin@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251113183155.1120872-1-andrew.martin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: b72ad875-f044-4ad2-180c-08de23c8fe5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1FvWmVvaGhhamV1a3k4c3FySVJhUjA4L2hscUUzL3ZqR3h3T3c0WDNiUU5t?=
 =?utf-8?B?N1BGalF4T2pQcVptWXg2VUNRTGhlQVdra2tDRmVISjN2WHFTMjhjY2JDZDZT?=
 =?utf-8?B?Vy9HUElTcEtwK0xQSFhWeDVvb2NJK1JzQm1Hd2F6blQ3bHBtK1dkbTF3YXZt?=
 =?utf-8?B?OUdxU3phbktDcE83cUJJWHVZM3BjKzIybTlhT1RYMVpkbzdLN2xNM1Q3bVhv?=
 =?utf-8?B?VG83S3orcGFwOUZuVWZLNHVqbjY5ampHejlwMlJYZncyMDh4ZEdJUmFaVU9Y?=
 =?utf-8?B?Mmtzc3hYSXMzN1NQNVM0QitzQzhPOVFuaWRvejd0SmJtdFdDMWZRS3gyMzhv?=
 =?utf-8?B?UGdnTUxJd0t2Z2RQcjFQRUdIRTkzRzUzZXFhTXVCWWp0RjNXeWI1UVVUbjJv?=
 =?utf-8?B?MGk0eGZON3QyeTc3aU9CdGdRSnB1NG9HVHdMZzcvWnYyTUtZYmdvU2M1UDJw?=
 =?utf-8?B?ejJ6Qk1EVW5uRkxCdm9kRVlJOWw1Umc2TzNiMTNrOFpsbUR6eXRHRzlmWE5j?=
 =?utf-8?B?ZEJ0ZEpOSmFpWGtFdUFodkF2bTQwN3Q5blBWUGRIZmdYYWVMdWVQRW1vUStq?=
 =?utf-8?B?Qkd6RXZ6RjI5RVk4YVlMdzg3WlNCQnFJVXBkanpvVGFQbExNL0pSVFpVczdR?=
 =?utf-8?B?U3NBUkw4NDAyOEdMVG9jS0l6Nm4rSTk5dVI2YmIyMnJvRVJJZVdleGxsRyty?=
 =?utf-8?B?TUNGdzA0eWlReU0vYzZNVnVtZzhEOFFyWUVoT2hWdzJwcWlBOVZpQUtCUmNu?=
 =?utf-8?B?TzRWLzBMdnlIQkhMQ1kvV0ZpSitsMGVvQU9jbkhpRjNlbEZBcDUyb0JoKytP?=
 =?utf-8?B?SVpxczFSelZZWmhrbjRMa2o4aXpzV2NQa2NDSjkzdTNuQ250a2hXUUhJMEpt?=
 =?utf-8?B?aFRUL1JCUlZPcGhWcUorVUtwWjFQdUtmVWNhTjF6eTRBTWk3eTg2WjV6RGpr?=
 =?utf-8?B?bWY0SlB1TGxhL1lCaGZMbE4wM0c1Y0h4cnE0U0pQdXlqZlkvNVUrOFRhUGZr?=
 =?utf-8?B?RXBIUmZDVFNIY2NQWm1hYnhmZWlLSndPUjVna3A0Zk1kSXFkY1RmcVdBakJp?=
 =?utf-8?B?QW5OUW10cmxhT1dkcE9lcmRXcGhxSnh4TjZKeE1IenA2Slh6NzJySDFMRDhB?=
 =?utf-8?B?TlNVdHY4UXdxSzlpWml1ZklwbzNxbmQ3MUNqTlErYkx2bUJsTGJuVXcySUQ5?=
 =?utf-8?B?TEFqUFNsZWR2bnl6ek1iMzBHQmxPNk9MR24wdTVaWWUvdmlyOXlsVEhadjlT?=
 =?utf-8?B?ZVJRL2E1S3MrMHFOeDNNcVpiT3JiN252TGhrSm03eU84YlBwMmVRb2tGd2g4?=
 =?utf-8?B?ZmNZdWdBQy9GNzBWVTZBbDY1RC9Pb3NLZFJuM3E3Q0pUKytVa1F4QzhxaStJ?=
 =?utf-8?B?dkZrWk04R1BSUmFsVTF4TEppUEdNQmtUZkJ2a1Iza2pZd29KVklyWnNIVnVu?=
 =?utf-8?B?d3ZaUk5lN2hlVDdpY3RqRFBxUURtWnE2M2FaZlhySnZFTTNreFoyM0xiSEdP?=
 =?utf-8?B?cFQ0QWtCMjdSeEU1ZmViL05oSnkyODlSeFdTT1JpTXhMREF4dUR0b1duOFBu?=
 =?utf-8?B?RVJxZDQxU2JXdlZkMzZKZkpFVUxhd3ZnTlJWVEFSWGNkbCtqM1JqS1JZNUVH?=
 =?utf-8?B?N1N1ajZLdHVRcnBFL1kyS1VGS1VzSXlhdEN0d0I4YUVFTXE0cFFIR2Y0cVQ2?=
 =?utf-8?B?NHl1UFFYdGF4c2dqbDZZN3U2RjBESUpjOUtmbjJ2cW5UeVplY1huUHh3TWNX?=
 =?utf-8?B?U0pvWDdTUGFLYUxxdTljVnNBZVhVTWN6TGR5R1RuUWJJTVRJODdXZHBPM1p6?=
 =?utf-8?B?ZEwyOEJybmprQXJBMDB1eW5OcHZ4QW1VZVZ2UnAvVnprN0kvc21kVjBJTGNK?=
 =?utf-8?B?WG4vZWxmNWpOMEhyaThVeVZscWV6ejNrd3l4SlJvQmJJODVKekY1cDNwaXhr?=
 =?utf-8?Q?6XjSbKRnakFSWEjXE4089A0xn+fNUq2h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dllUNzFnaWc4b0VMeDV5Q1VNdi83YkZFRUgydUdIZUFJdWVnNmlWZ2R5VmVm?=
 =?utf-8?B?UDhkTGI1amlzKzNZMWxnd3k3ZnVWcVdMb2FFVXVKNnNyWW5sUGdMdmlzSjRP?=
 =?utf-8?B?OHNWVXVmaXBJUTJISmk3aXJxVkZXTzVPRXdKSFdLOWhqaEVpQUwyQTRNMzZJ?=
 =?utf-8?B?RHVLVWlJS1o5eEVFWmNycGVOYXZ1UGhwQ2twazZTbzZYK3IrakYrbnZDdE9V?=
 =?utf-8?B?TDMreXA0bjRoYkdhT1pZc3lWWDVZdjNvU1d5YVZtWGhyNjVoMnNYdVRRT3Q5?=
 =?utf-8?B?d1p4YkljbWJhYklTeE1Rd0RFMS8zcnUzWFZVMmxRTjZSRVp2dzc4RjBCbXR0?=
 =?utf-8?B?OFpScDYwclpKcWxMaDZpckw0a2M2YU42bngvZThtWkZaR2xoK3E2TlpzVmk5?=
 =?utf-8?B?SGN6REI1YjQ4U09RLzRlQlRBdG9zRzlTaStqd1U0UGRLODZTbmljRGt3dHVU?=
 =?utf-8?B?UktiOStIcDRSMUFyamY2dlJUTkxnaVZLR3BjZ29kVUFEdTNJRXUxakk2aEN5?=
 =?utf-8?B?NUs3c3Vqay92eUFzd0xYY2xpTWFBTjFFNWxTQ2g0Y3lOcXg1dU9vREZtVVZL?=
 =?utf-8?B?R1FBZ25PMnMzTEtSNWFGZjB1UUV1WW5BOGt6NlIvZE1Lc0tHY2NEbGVRSjkw?=
 =?utf-8?B?UUEzNS9hWTRtZ1ZURTcwYzlkQ3ovVVRqcVdGWEpScnptNHNyemZTSlY5L21X?=
 =?utf-8?B?MG1YOUNvam1kWU9oQzBXZXRtTi8yZ3E2cE5ZU21IRU1qR241N3FxK0Z6aGRl?=
 =?utf-8?B?UDhuVmtxTWZCQVh2TER6dld1OVRZaUZDUVBUNWVEWU5HR05NeFBZbytUR21o?=
 =?utf-8?B?WWFpclQ2Z0VTNHRhSCsxOE1SZXhHWk5JdUpHa2E2cEdWQlRmRU1CeFZLS0RU?=
 =?utf-8?B?U3lobzJGbjd5R1V6NUhGeHMvOHpWS00xRys4bXcyWkx0d05sbUR5TUJxOStm?=
 =?utf-8?B?NkV3Rk5jZG1RdkZHa2ZqUml5MEZ0RUg2c0QrandIa25DZXFRS09BNW55KzBZ?=
 =?utf-8?B?MlBIblh4TDF4dllzLzZuT3VaazMreU5DN1dPVGpZMWJDYnNwMU5idEFaM0ht?=
 =?utf-8?B?bU9iWG52WnFsN05mQTFNdnVIbEF3ZUlCWHpqMmt6NUVLTzVSa0RpOUp3b2xv?=
 =?utf-8?B?QXJtbGM1bFl3M0sydVV4bEpCMXVEdGpRUmxIVW40clRCWk9KNjBOMERFTnlt?=
 =?utf-8?B?VjFJSDNvOEs5QVFLQjN5Nllqc3BJRkJybmlRTnhIOFQ4b2xHY3FMREMvaThY?=
 =?utf-8?B?eWRWZVB1SDZobWxnNzFTUDk3bkRIQndtTnkvS3RtZHk0Z1Zna0RHbFRsM2l1?=
 =?utf-8?B?NURzSGwzL2FDNGpmN3VyTUpaQXlFZlRwbUNzWmZPcjA2bTY1cnlya0RPOS9N?=
 =?utf-8?B?Ky8wQ0Q3dWUvQ0c0VC9ZdWR6Ky9pWExIZWJMU2V0T01ZMFM2TzZFb2tzcUVy?=
 =?utf-8?B?N2ZsbmRvU2xrVXpGRFlyUFpXUVgxRklLeEZSZG5GdVJLTVFWdU4yM0JyNDIy?=
 =?utf-8?B?clRGQXhlZ2x6RGtyeG5xeWs3ajV2R0kxajAzdjlpVklmaUYveExjQXp5OVk5?=
 =?utf-8?B?ZWZVY280d0RjbVZtMkFOTHFZL212dlREd1d2V2gxei9nenBNV1A2VGhNOEpv?=
 =?utf-8?B?NUhrNUNjUkdlL0FVUkV2bUV0N2liTk9QNTl5Z2pvaXpOanJDb2pSMTVnM3Z0?=
 =?utf-8?B?L1hLVHpJY3VWQ0tmV1pxYjMrdVVJSkpUbGRGV2ZUZllsam5nMUp2V1hRQXp3?=
 =?utf-8?B?YXdsOFZnbDFwNFdyWDB3UjJLS3E0dERlN3R4K3ZDWjAvYVFKTzN4UTVpTEt2?=
 =?utf-8?B?eU9RZ0w1RDlqVzJ5N0orVUFUSEx2YmZrMzNuMjVaUDR1aGdReEd4Tkdlbm94?=
 =?utf-8?B?SUNHZXFqcVhKZmlEUEVFVkRMVzV1eWtxM3owS3hWbE5QajgwVWdESU1hVTFE?=
 =?utf-8?B?dkIxREhyckYrdlJjd0dCRDVkR05FL0VaMUwxTS85T21hVVM5QmpEaWZJZVhM?=
 =?utf-8?B?eDhEWmRsVnJtY1ZRcFJKRktEMHdkNlZHOENNcGVOdE5QRm1KWXhCWTJleDZH?=
 =?utf-8?B?czlLbHVPTlZqMHJaalhHemMzS1ZaODEwaGhzamx5ZjJGVWU1dEYybDFKZE1O?=
 =?utf-8?Q?RtpFWAQiMno0mMswSWT59nXp4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72ad875-f044-4ad2-180c-08de23c8fe5f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:58:50.2876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqN+cCnbql7WZOFyBIfPfYXQsh9WxkamAOKMVihyVCUCfJpa1MgN4uJtk5mqmx+A4Bw9eJH7Az2+cTOWdT1hKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
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


On 2025-11-13 13:31, Andrew Martin wrote:
> The return code of a non void function should not be ignored. In cases
> where we do not care, the code needs to suppress it.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 ++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  3 ++-
>   2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 644f79f3c9af..e4438fca6283 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -313,8 +313,10 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
>   void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>   {
>   	if (amdgpu_device_should_recover_gpu(adev))
> -		amdgpu_reset_domain_schedule(adev->reset_domain,
> -					     &adev->kfd.reset_work);
> +		WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
> +							&adev->kfd.reset_work),
> +							"Failed to queue work! at %s",
> +							 __func__);

The return value is not an error. It only indicates that reset work was 
already queued.


>   }
>   
>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> @@ -715,9 +717,10 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>   		if (gfx_block != NULL)
>   			gfx_block->version->funcs->set_powergating_state((void *)gfx_block, state);
>   	}
> -	amdgpu_dpm_switch_power_profile(adev,
> -					PP_SMC_POWER_PROFILE_COMPUTE,
> -					!idle);
> +	WARN_ONCE(!amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_COMPUTE, !idle),
> +		  "(%s) failed to disable video power profile mode",
> +		  __func__);

I think 0 means success here. But I agree with Philip that we can 
probably ignore errors here. I believe some chips just don't support 
power profiles and return an error here.


> +
>   }
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 22925df6a791..025609a4abcf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2780,7 +2780,8 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
>   		 * saved in MES.
>   		 */
>   		if (pdd->dev->kfd->shared_resources.enable_mes)
> -			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
> +			(void)kfd_dbg_set_mes_debug_mode(pdd,
> +							 !kfd_dbg_has_cwsr_workaround(pdd->dev));

In this case we could actually handle the error and return an error up 
to the caller.

Regards,
   Felix


>   	}
>   
>   	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
