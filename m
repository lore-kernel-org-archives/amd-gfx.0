Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48144CCD1BC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 15:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C242410E918;
	Thu, 23 Oct 2025 15:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qGOH+H61";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D3310E918
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 15:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctJl4HA0Ejb6j0Sj1QZ1ZL/nX8aXzhkBkfeq3Lkl4soX7RXBFxJiaB7V5S3EKA5MU29/4CHPUjpq+/g9D75A4NKmVkZ2pdW0JUd8hU1MCYv7ZvKhgIfrHucx8vdQdQ7pn29fGfZhVnZvfWsCu9EIlaIwDXNK06F3OeVwzhOr6xRAhLo8BsJE4Ool4ApEajQ+9OKEcjdrJ7iIbIXRlq6HUObO6jf3UQ/zaCvnWBldmKbpoh03EfyqPrGIBO143POU7UAnmXuY9Y87BebCoqAzW784SL6hOacRpulRiRf0fhst00MZneYpPlbnw3kBfV/JfqFPvOM7SQLEPrmoHKg28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UryPvRtium2PMiE1t+pxWk86Uw2wcNSuZu8SBgge99Y=;
 b=iBKOl0IlRiPuD4eFSQik/VNnOhwmezkaM7HU5sbO+rVdMXdT//t6i+yUfBUYjbTISh2NHUHYkEwkCftg1akz+S91ud5fVeach8n98pTdgYYr+H1quU/Qphz9NoiiBN5AQmpkCibvCv8UI19CIflzzYijBAphTU4JprOonOhk5DiCdZGCm2CfrbEKt4+/34vaQFBOMq5QnDTex8z6l1VDv2L5wm1e1aJKM6kwiu55wwxgbERzpKrqesMWzFFZRDIQ43wvlfmkhZAEXbWY6DvxjwoE9GAfNOu1Nso84SQm054U1YvCTjDi8zNooXglCT/vU+3hRmGyYdE2kSnRnLYubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UryPvRtium2PMiE1t+pxWk86Uw2wcNSuZu8SBgge99Y=;
 b=qGOH+H61GlDDfYBmunAq2iq2cNaxKmKIxg40Lkz3oXBxDFuS7ZIcU4SMw02bl8sgbwupzYarat2jgCnaeAPQk6uhRjWDoaDAqvsguPAG7rHYEaurKHciXlPnTbtUvdAHKFNkNDzoaHvYazwLdZ6oMW7uuxgXhPqbdXnewK15Nz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:30:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:30:14 +0000
Message-ID: <a1c87ae7-9f8d-4fb7-a141-c285776d76b0@amd.com>
Date: Thu, 23 Oct 2025 11:30:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: null check for hmm_pfns ptr before freeing
 it
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251023065848.1664757-1-sunil.khatri@amd.com>
 <dc5cbf60-d73f-4590-ab7c-0ac3e919fb5c@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <dc5cbf60-d73f-4590-ab7c-0ac3e919fb5c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b265ca-a39c-4ab7-a1f4-08de12490f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHo3bmlSNW1Md0UwaVZ5SG9VSDVMQWVFUDRReGtzSHlWdDBXZklSTXJKVzVk?=
 =?utf-8?B?UEV2NFBYeExySjJoNDIwRDU2M2MxYldIaWVlc0hrR3ZaeXJnRVllUXN4MFBH?=
 =?utf-8?B?NGJGMTFiRmlVdTgvZEc1Uko4eHRoSHNPRkYySTliTXhrWk1qRkNTT1Z3cW5N?=
 =?utf-8?B?N3NyTlVoLzBLNEdZZDRZc2ZWeXEvakRPYXRKaCtaZ3JLNlpQNkFDRWRJT3BE?=
 =?utf-8?B?TlFSNFd5SmNqZHFZWjFFUUZCQ0d0SHRnS1hDYU1rQm1iRlFDYWlZTEVCMXRQ?=
 =?utf-8?B?dm9OekJOMkluZDc5Z2dGY1lTUXhiNTNwQXBWYnJRVzVFM2VKTGF5VUoxd05N?=
 =?utf-8?B?Tzl4dmpsS2Q5cWIxM2ZzMWVTS2JleU9sa2EwdVhXYU93Vk43aGhXMEU1RGlQ?=
 =?utf-8?B?RHR4SUhRZ3VkcVVudVMrWFJaVk1tTW5pamZVcDB6b0NVL1BpdWYyNlNlZ3l6?=
 =?utf-8?B?OXkyMFlnZ3d3bFB2aks5SHNIYjEvZkdaNmg4Vm45b2VQNUt2STVOZnFDaElv?=
 =?utf-8?B?aGFJc3NHWk53Q3c2STVFdVZrZlp4MzNnVHAvcGM2ZG1WcWNZU2c2SHVYNVVD?=
 =?utf-8?B?Yy9RWDZibEYzbU9xbm9rUkQ3blRrQjJTcjB0UmxZNXVtcEg4eEVtN3YxQjQz?=
 =?utf-8?B?NWZWVVZDKzNlQlBndG05VGZPT1Q1VzRwVmMxMVJyc0IycUlPV2Y2YU1GUXhr?=
 =?utf-8?B?NG1vMjZOMmtNTEVqVHI5WThYOUgyQnQrWGVROGk0VE1QNncrWUVOdUw1MUlH?=
 =?utf-8?B?K09BQzd1bTRCZFVjSUpQKzBvdVN4RmNUSlhCMnR6S3VHeFRGV1dKQmdLYzFR?=
 =?utf-8?B?b1RwQlA4SU9pcTJjbmpUSGN6cjNCQ2Q2VytXL0hIMWVnMy9QTVdKZkZiRG9R?=
 =?utf-8?B?N09xZEhzdi8wdVY3bHNMRWVqd3Z5ZVkweUtlclBRay9xVzgyL0duZzljQXM4?=
 =?utf-8?B?QVdHc1YvYmcyRWNDUDk2VEJTMFp1Mk5SSVJwQm9RNGFMWUpkWG9oeDZ6c3ha?=
 =?utf-8?B?RmdWNjI1RkhuREdNZkpGQ3ZWU3oxL1ZpZG51TU11eXBDQzd4SjdudldZTWNy?=
 =?utf-8?B?dlJRWlIwSk5rU1Q5ZFdKbmZqZXkrWEVJNVJpdkNrS1dvTlByLzVtWE80RU1F?=
 =?utf-8?B?Y3djdVpUQmJNM1RXRjNqNTV3NXZDd3VGTS85d1gyMUdvcUEvc3ZwZzNWZlp1?=
 =?utf-8?B?RUFWbnk0eFhEbnBGdlllc0N5L0dweFFTMjduSGhZMFVTREgxWU1hek5zVlQz?=
 =?utf-8?B?ZDU0LzBGWUZHN3R2emdOc25xTVM2VElPMGZlN2tUeWZrWldhY0NPYmhacDNB?=
 =?utf-8?B?ZVdob0lIOGYzZHA3TGhzVjF1Y1h6cEtnc3Q0WVpoV0RjYWxUbUh5RVp6cGM5?=
 =?utf-8?B?Qzlpam5CdjRlYTJrYkFyRllQOGJ1VWZsZGh6ZUliaGJBMndiZHBqVmYyYW5v?=
 =?utf-8?B?dkQ2NkNOeG9GOXcyak9DUzY4andpSXVJV1llSG02TXBaZG04QVd4Y0J4a2RK?=
 =?utf-8?B?V2oxNG1LalFHam9abnJHUFJyaDJURlVscUhUQ2pvdG0rWE9SUXliWGZ3SjRH?=
 =?utf-8?B?Wisra3Y0c2t3anZSWjVwdmNEMFJCNjN1S1FXaTZMeWxKTk5RYVlDYWRpaHhh?=
 =?utf-8?B?V0w4Q1hkc21YMlhYVDJWc1JkOHFqd0RQckg1czVRN3pYUGVqOVY0Wm5TWSs4?=
 =?utf-8?B?MktuN1RoR3Q3MExWU1ViS1p1T05xVzRiMEdnMFVQbmZTcjBib2d2Z0ZaNEp1?=
 =?utf-8?B?RHdhMXNqNUl1aFlFcFV0T1VjOUJzM3lmNk95RXFYenR4MUpMYXFyUjJmTHBJ?=
 =?utf-8?B?ZXZUNU5Ba3h1Q09UNGQ2OFV0MTdPRG5wN1FLS3NoVGRtd3JRUjlILzE5OFpW?=
 =?utf-8?B?YkJqdUQ4bXlySmpXa0ZHaWhYeGk2N1JyNTJMOWxRVUZKVFM2RDNQd2hqekJu?=
 =?utf-8?B?ZGEyK1pqWVhML3BwZUJ5UnluQTc3OXluV0tPZTlOdWprRTJPZ014OTNtN0Fi?=
 =?utf-8?B?ZUxqRDZJMGdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHgwNzVNenNNSmZpejIrdmdzM1lVV3kwKzhRM2xIcEJxV2g1N3E2dVNvR1Bi?=
 =?utf-8?B?ZDEvTXlhM2cvbVdEUVZDKzdiWDk4STExOGdJQk1RTW52eStDM3lHbXRUaXA3?=
 =?utf-8?B?RS9oNFd1NUNjWDNnQ3o1UjFwcjlwMlM4Qnd6WG0rd0NwLzhaZWsvdlNlNm1P?=
 =?utf-8?B?dWhnMXhTc1VqRS9rVUxacXF5a3pnWXJsNHFqWGhNMW0vZDI2T2hKNkM2S1N1?=
 =?utf-8?B?anBXMkxsNHY3NndEdWp4Vi8vKzlld2VPeXNBNVp6VGJDN0xSWHZkNnhoZGtS?=
 =?utf-8?B?MytMZEhmdERBWCtjTnVkL09aL2xiRGUwVjl6UmtYNi9XT1ROa0R2azgycEhQ?=
 =?utf-8?B?VFBJWUcwNUpubi8yMmhjWDd1Q2IzMDBsMGhIMWUrZXZWcnZodmVJb09qZzJB?=
 =?utf-8?B?WVJxUVpWck5jMXZRVUc4QURpN0M0VmRkN0pQSE1MVWdmMHgvSFRUMjMxeS9h?=
 =?utf-8?B?YSsrMmhvc3hPWmx2SVNSNmdSdEozdEp6SkVvTjFmN25vMFBEL2w1NU1TbXBB?=
 =?utf-8?B?S3BuWVpKcjc4Z3NkSjNGVm5BMWRpRXBQZUNHKzNxd2NqTVlORjRpOG9DblNY?=
 =?utf-8?B?dkI1N0g5S1RSUUVBUW5TZlR2TnpDbnp1SXhjanQ3Z2FhK0NrcCtuSWN1dmZq?=
 =?utf-8?B?TDZvTzFDekV0YzZYMWp1aTMwbDlKaU5lOGNxQmdQVVNvZjZmL2FlenlFZ0tK?=
 =?utf-8?B?N1J6N2tGc256Zm15QXJvajd0ZHJ4VmtrOWx4NkRpZi80dlpoWmhwajhrQnVR?=
 =?utf-8?B?VlFRNHA5S2E0RXV2eWIzN1YvT29OOGNmcWdIdTBoLzZBRjRTRC83elNMNkRO?=
 =?utf-8?B?OXhsdkNwYVFNQnJhRFR2ekFoWm5PbUJTUm9UL3BlcTcrSDJXdnN0SFI0ci8v?=
 =?utf-8?B?cXpadXVKNkYvMFlxNU82c3hyVzlKeHJ2VGFsdGZrajkyTHZSR0JSa1JVclcz?=
 =?utf-8?B?SGsxd2l3eU55amJMSXYxblhMeGs1RU5FTE9kSDJPdmJaS2lSQ1RJMmhucnBl?=
 =?utf-8?B?ajc4ZVV5cWVHdnQ0TFdVSWNCbE5POTgwdEMybWJCK2NuOGhCdEl5WDA3Nmk3?=
 =?utf-8?B?emhBOERSRGI2ZHdMSXZQczdGQnV1Mml0UUNjQXR2S2xxeEt6ekFRUi9ScnM5?=
 =?utf-8?B?Q2xIY29jREVIY3hscXpDNVlNK0oyQnVEM0pSR2pVVzVSeisyWWpBYkcxMzNB?=
 =?utf-8?B?ZnYvQXJFUVFHQmlZQUtMOGxCSlN5TmFkZ05tRFhxczQyWmtKdk9aMjAwZDV3?=
 =?utf-8?B?WnBvazI2LzQzRTZ2RXVKL05CcHAxYlh2UWdOLzIrSFpiUS9ZMy9DUnBvK2ZW?=
 =?utf-8?B?RWJLTDN0Uks5MkNxbGlFSDg3TEVFOFZaM2EzYnNDcTZvR05xK1h2aVFraDR2?=
 =?utf-8?B?c1Nwb2hhNk5YWE5PN0VCSDFpa0ppSFlWdHVFYVNvWWRqdTljRmw2bDhicDlz?=
 =?utf-8?B?cVVjZGxnZ2JGMnREWVFDbG8ybDBjV2Y2eUtLb0svaFY3T0owdWV2VXBicDNH?=
 =?utf-8?B?d3I0MFk4emExdmFGK3hZUzR2MENqVVIveE5BTzdDTUdxbS8zd0JmdHpYUkVZ?=
 =?utf-8?B?bHU2N0NkSlBPdlo2VE8xd3F2NFZ2ZUlzaTdBY2k5dk9yVjFOYkQ4enBDaFVi?=
 =?utf-8?B?U1RrdklpWjJWc0dURHkybUJ2elBpVU9JeU9aY25Rakx5ek5TdFNCdkF4TnBp?=
 =?utf-8?B?Q1dmTkU2eGY3MGh6bDUxVGNwbWlRZFdyS0svbGFseExUNmpnRjZSQzJtdDhk?=
 =?utf-8?B?VEdiQmYzRzR6cXk3U0lLT0ZVQm5yWFpIaVdqL09OMHUxT2VoY3R1M0V1am0v?=
 =?utf-8?B?NVRWeXJoUkFmc2xEVUs0UlZycG5Zcm1jZWFXOTdsLzdnSXd3aisrSnYySDBp?=
 =?utf-8?B?Vk9IV0FVK0xtbWNUTkFIOFBydmtmcTltUStJNzUzQ2hSUkV6aStCVGlpQnhX?=
 =?utf-8?B?SERaRkJXZ0YwU1ZiYzJ1TTI1TTZocVpYeEF5VGZ2L1RiMGxqZkhJTXBYZkR1?=
 =?utf-8?B?M3ZIdFBObllJam1keldHQ2FGRnJKY3h5RHhZSHEreTY0Ui9wZklZMEZsTWQy?=
 =?utf-8?B?NlJZOTRTMHZLbk9YN2ZmYUhiZnNUalNSTHRNM1Jtbi8wSUZTMDlaNXhsRlFX?=
 =?utf-8?Q?NH8FxlK2GR7Oel5OPVsmWiRug?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b265ca-a39c-4ab7-a1f4-08de12490f96
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:30:14.6127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDfxggGWTjDyifJ1yNIG25V5PGDQH6yzR6KhPanmEOgrTTaStdw5WZiOlO6vep+eS0v2Qla7HwBpwZlnlNv09A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
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


On 2025-10-23 03:48, Arunpravin Paneer Selvam wrote:
> Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> Regards,
> Arun.
> On 10/23/2025 12:28 PM, Sunil Khatri wrote:
>> Due to low memory or when num of pages is too big to be
>> accomodated, allocation could fail for pfn's.
>>
>> Chekc hmm_pfns for NULL before calling the kvfree for the it.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index d6f903a2d573..6ac206e2bc46 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -286,7 +286,11 @@ void amdgpu_hmm_range_free(struct 
>> amdgpu_hmm_range *range)
>>       if (!range)
>>           return;
>>   -    kvfree(range->hmm_range.hmm_pfns);
>> +    if (range->hmm_range.hmm_pfns) {
>> +        kvfree(range->hmm_range.hmm_pfns);
>> +        range->hmm_range.hmm_pfns = NULL;
>> +    }

NULL-checks before kfree and friends are unnecessary. There are actually 
static checkers that complain about such unnecessary NULL-checks. For 
example, see https://lkml.org/lkml/2024/8/11/168.

The same is also true for the standard libc free in usermode: 
https://stackoverflow.com/questions/1912325/checking-for-null-before-calling-free.

Finally, setting range->hmm_range.hmm_pfns = NULL is also unnecessary 
because you're about to free the whole range structure anyway.

Regards,
   Felix


>> +
>>       amdgpu_bo_unref(&range->bo);
>>       kfree(range);
>>   }
>
