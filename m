Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027D2D70DE5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 16:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D8B10ED06;
	Thu, 28 Nov 2024 16:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="45F2D3lz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A742D10ED06
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 16:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YT45X3pi0AhLHOXdPXgxhymV1d4j9iTeDL1rrhWArRubhxjCQ+IbumVmRCB4pXv5WaYPS6F6BJxoFEmy2mOjrCRtjvpQwFfwjy/4vcdqvgIbeqUSBZvjfWd6TMZm01lhnQ8UdcYuqUlcwWdRJ71cGPWWnCLuNWupB50eJVwh3L/2h6SDT5K7DAbotb5lEpU/ckd4pS38IKyeop+yTuPkGLK0KGKQHusKrKGDR2KI0ZWa6zRiZAyRFBW8ATw+z50Jt+OuoVYnUQ1vblAZ+7dDr9AAUMEH82c4Kd0DksMIze+XnppG9gTdWEmR8R7pYVKbU8WxoHPsxBH32ZXS7ufzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZceIMrZETM5daPBVn6AEnk/AI3lMPw67jeGwHeCqTc=;
 b=X1mabCuBRKmkyVVMNsDwLOQVYthkPLTmxOhG0BB2UwsQ3PKz7CjcxwMXXSoMbuVAr7sMXvv6eczmV6nvBtEyh/iP6IszgDF6mwOmx8fUSr09qDux23D07JLuf6oubXI6/RZAOH7wo7Y6GMegkRlPsUqrVooqeCWkw8/Fohho9WPuLXESoLIzP+OqJIR+y+7N1CUtGDiymZk2pfKmC0HSSgVq09DhLrSb4FGmw8/rim6IKZQZo3k2tn4mSToNPw5GEBMz7dSZsyTspZOCblaWexqIe0ZNUkuAerI2cPJDVXZ4PBRQRfrF+cMFSQamlREt+Fp2FiX2RW9K/vy2bKuAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZceIMrZETM5daPBVn6AEnk/AI3lMPw67jeGwHeCqTc=;
 b=45F2D3lzfBzHZ7F9FFu7zolPwzbzKlkoRI5WWdN5bu16jQ9iRsw4TY42kMwIRhfekl+LG+H2q1TiccCxcz0hSvFUzLmt05dErY1C6QbzFRGdXXSa4Qr74yvuEi68TWmPx9aeJ7Hqi7/z3fkDvDTbdC117OPJAtcKMvXqSivbCUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Thu, 28 Nov
 2024 16:22:18 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.8207.014; Thu, 28 Nov 2024
 16:22:18 +0000
Message-ID: <5d8cfeb0-6249-4d6f-8e35-9c53a5a0817f@amd.com>
Date: Thu, 28 Nov 2024 11:22:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Use the correct wptr size
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, mukul.joshi@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20241118053434.3382003-1-lijo.lazar@amd.com>
 <7fb86a69-aa43-41fc-90e9-4750c84a3a89@amd.com>
 <a8cb1cfb-bdc9-4e56-8a11-bbe8f311fe6f@amd.com>
 <5116ebb9-e0d2-4525-a3ca-ca5f254b3cce@amd.com>
 <3d0e1c32-3a17-4d45-a9d7-9347db9bd1ea@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <3d0e1c32-3a17-4d45-a9d7-9347db9bd1ea@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::30) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2874ac-7a2b-4e25-0fc9-08dd0fc8d3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1JCd3NuKzUybFZJbWFlU2NSc1VISWZuTnFHK3dYaGNzK1Z4WnpWVk45RmNy?=
 =?utf-8?B?Y1BOU0trZVpuUVFzZkpxRVFzRGplNm54ZWRMSUp5YlZKbElLakw1bHlaWXkw?=
 =?utf-8?B?Tlg3eE5kQVhibWkvZFFTUTJNdnZKWktIWFhpUWg3L0wrMjBNakhwdWtYQUw5?=
 =?utf-8?B?K04xaVNXN2RISmdZeWFKWGZrZmpGUCtwQit4cTRKUUdNeDlNT1h5blhzbmlC?=
 =?utf-8?B?Z0d0RDJDaWZxenN6MDRiT2MwOXIzODgwKytmc0pRS0UxbWthN0ZQcHVlZnlG?=
 =?utf-8?B?eE5MdHpkRUQyUTBGbmhBVGRPWDFaQk5MTDU1NG8rVUJZYTJwVXFpVHZzdC82?=
 =?utf-8?B?amdqREdGQ3BFODJrMkwxSEoxUURhTndUMTk0Q21qQUo5b2lBYVFOc2FVQXNv?=
 =?utf-8?B?WE43d2Fxa21jbVFYcU1sY3pvQWswOTdZdVF4eEU1dnJwOTgxRkRxNGhUYnoy?=
 =?utf-8?B?T05DU0dFTXQycEVLamtucnVSRGlDQ0ZaR1pnZ1JvWFZuaVkzODVsRkEzbXhH?=
 =?utf-8?B?MWhOR1hlWWlmU1EwU1paVGJIRVN3SHlTSFhmRzdKNWh4UUtKRjZSRitOSHZS?=
 =?utf-8?B?VDFLSHZsSFRIczZVMFhwYzdKR2Jmd21YeUtHKzZFanZkVTlieUdoS0FDM2NZ?=
 =?utf-8?B?Umxlb0hoZGhOdWF6WUdzdHZQN3NDMEw2NkduT1JGVTZKUHlPY2ZIanVmZE1l?=
 =?utf-8?B?dHJnUW9NdnFrT3BjVW5Db1VHL0VWcU8zTzE1SGU2L3RCaVhVRzBvYzJJOGtu?=
 =?utf-8?B?THFrL2Q4VEFCVzVSYU9Zc0NIS1k1eitGZ3NsaDdvUldNTVhEdjdaKzR6Vzcy?=
 =?utf-8?B?WUUrK1BIQkNQYThkZVRYdVF3dTVzYVhFQngrQnNOUG9JUmd2L3Ztd2RiWEll?=
 =?utf-8?B?TmZZVGtrQlJhNzRqQVlka2QrQmkrT1Myd3FZa28vMmxXbmN3TDRVK0d3VkN0?=
 =?utf-8?B?QUlYVEQ5SGlJWU5ZZlM3MzdGa01NSWlqYTVyNnUxREFNSHFmd1FzU0IwQjNS?=
 =?utf-8?B?K3h5TlRFYkhvSVg5MFVTaVhCbGxhb0xDbnZGMG9lY21lVnAzZS9BVTAxUStn?=
 =?utf-8?B?LzZEQUFBRGh5bFlsNXhRazYxSkp5RndUa0JVRm03NmdnazN5UTdzb1U1ZEpz?=
 =?utf-8?B?bkE5QVdGeEcvODNNdVZUMDh6QVFZMi80QjJmdUdJNXg1cUZ2ZnRMaytDcDhK?=
 =?utf-8?B?Q1IvSERTUk9tV1Mxem8xbmkrTndjaFovNUJkVmN4YStyZVFXT0IxTll6ZHhi?=
 =?utf-8?B?MGhKM1lTSS9UNmZOeEZPSXR1ZitaaHJXNkJhTFlwbzE2NHdjak83a2dWTFRS?=
 =?utf-8?B?elRqeUp1aHFlWm1mRGQxZFJrWGNhWFJKSnBkZFVsL2tKR0JDdjEzbnFaMTVB?=
 =?utf-8?B?aTdDUnlCQ2I5bUUrVzBQdExTUzJWcFJMMVhrd0xBWWQ5RkE2YytMSXcveDBK?=
 =?utf-8?B?WXBpaTl2djFjTWJWMWJYSkxVZjRtZitrUXRkVGRmRGpzdUpiWWVwNXA3Qm5t?=
 =?utf-8?B?K2xXTUNJTC9HNDhDNjZQTWovRENGd1V0VW9QRVpvUnBWcEZabWZNYnQxa2FG?=
 =?utf-8?B?Zm9YOEl0MEM3K01GZ05PWXMwQXFxeFE2Wm51WmFRMytKa0tNeFlJQ0Qvd0w4?=
 =?utf-8?B?cVl2OGdNalZFWjhwbUx3Y3J3SHNJSlBhOHYrN0xqMU45S0lXNFp0QWQxZWhP?=
 =?utf-8?B?UzZEVGhJTS8xY2lZYU1pYzVWT3NPcmNPTURvWDJzV0pxL1JBVUhGUURaRWk0?=
 =?utf-8?B?UjU0dmE3ZjhGdXBoU0QzSERiNm5maVJPVXpNaTdRVEJLdklhK2hVUWtPbExm?=
 =?utf-8?B?ZG1jZUpiWHRQZTVoWXNLZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXRPT0ppR0VwUnM4czg1MkhaTTUrYU1aWm9kcGxiMCsrcEh3QUlXTVlCUzFo?=
 =?utf-8?B?bnR4andSSENBeVlMU3BKWkFOckk3aWpsV0FVY2M4dStvYStjV0Q5akxyZU9s?=
 =?utf-8?B?bmJ1V1dJYVpraVJKVzQwWnhJUlhkSFN6b3pwa3JIMTJsVVVMUWk3U0R6YWth?=
 =?utf-8?B?MWFvUDkrMU9BWnFoZWZNUEtJZVJPRGRqejF6NzRpZU5xOGlmWDFrWTI3ZmZL?=
 =?utf-8?B?SlBrUEZSVEgraXVDK3hPeUpLS1B1Y0F4YzVRYlNDbXFuZ3c0QlBIZytvRldu?=
 =?utf-8?B?S1VFQ3FuaENUWDVFUmNIdm83ckEzKys1UC9VZWQzOWNLcm5JRnhHbWpaem1J?=
 =?utf-8?B?alpFWFZTVllGbkw0NXVZUWNIeU9WVTJCRE82VFFjbnB1QjM3eENKK1VCSVN6?=
 =?utf-8?B?ZW1qV01GVWZaTDNReE1XZXo5YTQzNlBDdE1ibDJFMWp1RjNUK2NWZjRsa3lk?=
 =?utf-8?B?ekJzN21aS05HNWtBMnQ5aDhEZzcxZVpvOU9SdzBrWUJCbUFySDhCQk5GbDB5?=
 =?utf-8?B?L1N2RGloM0VMNzVHb2VjSnZ4UzBPOVF5bVo3U1pSRjRRTzc5Q2l1TTBSSVVU?=
 =?utf-8?B?LzI2QWpSRklpMi8zcVczeC9zK2orT241VVhwbE9MZzB3bStNUVNiZTNBMFlj?=
 =?utf-8?B?Yk0zeXAvb1h6UktzMXE4SnRXb0ZMU2h3S3R6azhLOGRWRUlRbStTZTBpV1VT?=
 =?utf-8?B?ZWpFbnU4NnE5Q3NETjlpY1hRMmZFelR2d2Z0bHlxUEhaMitheEpSUEVwNVh1?=
 =?utf-8?B?cHhCWU4waVZ6RnZyekJSWE5RUUIxc1loOGZmalBNblpLdVpuU2VYS1R0VG5S?=
 =?utf-8?B?aFdRZURiekEyZ3l1ZzZSeGgvdktXV1pBclg1MCs0dnVmNXA0bVQ5azFqOElZ?=
 =?utf-8?B?Um5pNEttVGNzNlptUGd4U1BXek4zd1BsNEhXdU1ha05MZHdpWjNTWE51MGIv?=
 =?utf-8?B?YkorSGs3Y1AxWFFhSTZEVmQ0ZFp6bmRDZFl1azgxak1wWU1pcEx1VVE3ZkJP?=
 =?utf-8?B?RGVtWE8xQ0dYVUxNNHRTeDR2Nm5yQmpsc3Zma0VoZjNYS0VENDBDZm45U2tK?=
 =?utf-8?B?REZEN1BoYmRYdnFFR2hQbVZlZEUwNytLbFZ6anBBV0o2VWQ1bFFYaU9BaFRw?=
 =?utf-8?B?TndBS3RyTkhSZnJCY0hGYkk2S25vL1o2dHRXdWdIOEQ5RFE2M2lzK052bkNu?=
 =?utf-8?B?aEIzeGFLNE9sNVZUYnJza254MWI1ZzZaY3h6aE9aZFgzKytsTTI3eHI0OVRx?=
 =?utf-8?B?aUlqOUc1YkdpbjluMDhnZGFsTEs2S1d5NmZoOXV3K3Z6L0c3dFJsc2x2ZmhB?=
 =?utf-8?B?bHZnN3YzZmxPQk00MzhEQnBwNHFzWnViQnY4RFh1NE5DdlBYbGlHa0R6OGFP?=
 =?utf-8?B?eWZaejE5WWM4Z3lvR3hVL0NXdUZlRTJCQW5yUmZqSVpjMzh3dDVtM3FkckFv?=
 =?utf-8?B?UkdESVhJQXVNbGRYN0M5SEt2U01pS21IeFhlalRqNGZ0aHl0NXNsR1BXSG1v?=
 =?utf-8?B?L1dIVXVCVURud1Rpb3o0Qkwzelcya09qNTB0bmJ3RUtmb1VlOVorK3p5Ti9F?=
 =?utf-8?B?MmN2UUN4UnZhQUpnK0JwVkJlOEFHeldJRElkVmtrZjNQSFM4SGN1U2F4YVpj?=
 =?utf-8?B?R0VyZTZ3a21hWVVoZE4vTjMwUXBSMVBzdUhaenAxbnN0ZC94REpwNm5iOTVm?=
 =?utf-8?B?bGZuNjB6NTMwOWVIR1M2UEdkOVVwQ2pFSHdiazdxUWhGRE41aUh2WWdsRFBu?=
 =?utf-8?B?MFlnT0phTnJ6b2g3TlFDRkNMZnIvNVFSUXpabEx6RWc0ZkVuQnVmUXRDMXU0?=
 =?utf-8?B?RVVKL21zNkJqbWNWMFN5Y01PMjhJMHRsWTljdy9BVFlSdW5TT24xUC9kUHF6?=
 =?utf-8?B?TXMrWW5FTW5GcnNKOGg3Vi9kVHVTQmRHSGtBaDd4QWZXRkR1R1pzU3hwaG1Q?=
 =?utf-8?B?QmRvbjFITHhRTjRTZE9GZnFybUtQSnBnRThmWUlmbnhTZmVhZDNWbVpLTE1u?=
 =?utf-8?B?b3k5WmlsZVYwU1lKTWRra0NsWC9teEc1L2R3bk5uSmxuc25XMXoxN211Zjk3?=
 =?utf-8?B?SFJzeHpQVUJ5VXhrYXdXOUZYdVhscGFBeXdYZ3V0d3prOVdjWSt6TTVKVGpW?=
 =?utf-8?Q?PdVs78uDsWtTbjNv1CL25cuiR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2874ac-7a2b-4e25-0fc9-08dd0fc8d3c7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 16:22:17.8732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eqoe1f/PQDuKKF1WkYfw/nfKvq9TS49SMLyjK2frPXgNH+LtGp0FvNrzFEhh4wcQeJSsW65jCyVEropfoN74A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
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


On 2024-11-28 10:21, Lazar, Lijo wrote:
> 
> 
> On 11/28/2024 8:12 PM, Felix Kuehling wrote:
>>
>>
>> On 2024-11-27 22:45, Lazar, Lijo wrote:
>>>
>>>
>>> On 11/28/2024 5:43 AM, Felix Kuehling wrote:
>>>>
>>>> On 2024-11-18 00:34, Lijo Lazar wrote:
>>>>> Write pointer could be 32-bit or 64-bit. Use the correct size during
>>>>> initialization.
>>>>>
>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/
>>>>> gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>>>> index 4843dcb9a5f7..d6037577c532 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>>>> @@ -125,7 +125,7 @@ static bool kq_initialize(struct kernel_queue *kq,
>>>>> struct kfd_node *dev,
>>>>>         memset(kq->pq_kernel_addr, 0, queue_size);
>>>>>       memset(kq->rptr_kernel, 0, sizeof(*kq->rptr_kernel));
>>>>> -    memset(kq->wptr_kernel, 0, sizeof(*kq->wptr_kernel));
>>>>> +    memset(kq->wptr_kernel, 0, dev->kfd->device_info.doorbell_size);
>>>>
>>>> It would be safer and cleaner to just initialize kq->wptr64_kernel,
>>>> which is always 64 bit and aliases kq->wptr_kernel.
>>>>
>>>
>>> It's done this way because of aliasing. The size requested is
>>> doorbell_size which could be 4 or 8 bytes.
>>>
>>> By safer, do you mean to have an if..else check in case the aliasing is
>>> taken out?
>>
>> Cleaner because the size of the memset would match the size of the variable. And safer because it clears the entire wptr, regardless of the doorbell size.
>>
>> That said, it doesn't really matter because the whole kq structure is allocated with kzalloc just before calling kq_initialize. So maybe we should just remove all those redundant memset(kq->field, 0, size) calls.
>>
> 
> This is not related to kzalloc of kq structure. This is actually
> initializing write pointer value to 0.
> 
> The sequence is -
> 	Allocate memory for write pointer (kfd_gtt_sa_allocate)
> 	Assign kq wptr to the allocated pointer
> 	Set wptr to 0 (Initial write pointer value).
> 
> The last step should actually be based on 4 byte or 8byte, this patch is
> for that. If gtt_sa_allocate is already getting a cleared memory, then
> this can be skipped as well.

OK, sorry, I was reading that wrong. You're right. kfd_gtt_sa_allocate does not clear memory. And clearing it with the same size as the allocation is the right thing to do. The patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

> 
> Thanks,
> Lijo
> 
>> Regards,
>>   Felix
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>
>>>>>         prop.queue_size = queue_size;
>>>>>       prop.is_interop = false;
>>>
>>
> 

