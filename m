Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F86CCF9FF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 14:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D945810E99C;
	Thu, 30 Oct 2025 14:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cb8Fp36Y";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CAE10E99C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 14:33:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YI0BwsdMG1X5t84WCEcahtgB/eLOyZiagRi+J4O6TbEd3kfcHKilq2PofanroZTUrCXIqWw4aTIb/7WHdudxeTNuix0qRjh8VtZjTMGAy36z+YKrjksk2Rt9GUZtXwubbLGhiEeRXc3vvu3Mn1NlOc9p1ceZvnlHKTcEIdsqqbwihpWtfObRGZ2+eb4qyjRfaZmJ43ekrDCWReaSJIw3svBF458HKsuChOe4q9F6yQFl4fufafBQOgZ6thUdqCQjBkS/IZDlCAkdEO6hbD1Yz7Uo/92oud2LyB+onIjK1zF5msSht4uENJAQJ5AxpiTnBjkzeD4zkzG3A84vNeL0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1dQ8VI7CJKLBrcCmoLZUXyi2Ufeqyb2y951Aw4g+Yo=;
 b=Za6v1/SMKVYuISizDC0TSnGbbzIcS5smjCDrbaTRuYOAa02AK/A+6LxR6weF9tehafxLiIERC0IEaX5ZRvLgmrJ785A3mmNRPyv6dh3Yb78NAnLWJkhXO/1F95eOxDTwGf2mirMtg94OKO2/zOLdEZLXEp5fuksisuL4RdcuLijnMtozSzJEeZHNjZ9AMOatb75PBQ+LfXz2yP8pIC6C+w4xt6N1NPnJPHpAsne7SwGyi0jERMOZz74jDlVeaclaJc7uwvNgmeFJzCxtEyJgVzalRc9J3o03ctpockcfEVH7AVQOBYeXOJr6WBqGTaxWpaAN6RyIkrpjRLx3vrhI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1dQ8VI7CJKLBrcCmoLZUXyi2Ufeqyb2y951Aw4g+Yo=;
 b=cb8Fp36Y3zYVVWWChVA+xz/7IkxjEHDc0mu6bLtkqnwuJCpMeE9dz0GRjE4bKqYFHt1jQl5bmL7qwOEh32SNCwPlnFp/cI749e5ZQwvcYoNeGkTnocXPI7gTyTNOVWLPBSueVY0tnltF1Pr2QGYhBLE0S22m/m8H8YlSPrp0hnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Thu, 30 Oct 2025 14:33:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 14:33:56 +0000
Message-ID: <4fd325d1-86a4-42dc-bed0-d13d76e05226@amd.com>
Date: Thu, 30 Oct 2025 09:33:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/amd: Unwind for failed device suspend
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251023165243.317153-1-mario.limonciello@amd.com>
 <20251023165243.317153-2-mario.limonciello@amd.com>
 <CADnq5_N784+4XCPF3VCvpWZ86wKmfcbYrkvaEsU6jgNufrcOaQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_N784+4XCPF3VCvpWZ86wKmfcbYrkvaEsU6jgNufrcOaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:806:27::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: c21e3010-27ed-4945-587e-08de17c15b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm9SUERaVFU0QlVvN1ViVnhhb0hZc296VFRKUEdmUnM3WnE5Yk1hdmpBUUov?=
 =?utf-8?B?UE0yYXlhNDBITzZkdS9mNVJyZzFxYzFPYlNnMm16NENNOG91UzlHMFkwVGVO?=
 =?utf-8?B?Q3I1Nk5UbGV5a0M2T2RSMUVMeWxPRDFPYUxpeGhXc0M3NmxzQUNaVHM0Z3h4?=
 =?utf-8?B?TXZTZXVVUk1YMzBxWm5wTXViUlNBdHYzTmFjVEk1L1J0QmppTVAyOGJKdnVn?=
 =?utf-8?B?aml5MmNLMUxnWE1MaVluR2VSYUpkait2ZW9TQWJTMHREWVFJZ1VUU21LVGFZ?=
 =?utf-8?B?aXJZZ3p0eVRtYVhZU3oxdVkrbHdUM2ZQNk9FZ1NuakxvVDd2dDNKOEQ5ZC9j?=
 =?utf-8?B?aXpZVlBLUUpPYWs4SkRNbWJGZlNXbGl4ZVRaOUl1d1JFNzRVWTZnbUVxSGEr?=
 =?utf-8?B?bUx1MktMcURWUVA0S3NvZEtsN1FTdjc5bW9aQ0RqSkZJYnpmeTQ0N0QvSTRp?=
 =?utf-8?B?T0V5VkdHU2VtOVY0TWUwMEV2N1FsZm9ZWUFyeVhVVjkvUVRSM0F0NUttcVI1?=
 =?utf-8?B?UmJBcE15QVY4K014TFd5SUkxQjY3d0RQS1BMYUVYbXJtZVdMVlJVNUNmaHRL?=
 =?utf-8?B?R0l6MHk0R0U1WndCWURJNmhtai9WYVMxbTA4V2phSWNzWEM0eWwycVFiNjNT?=
 =?utf-8?B?czd3eUd5Tm83OFB1T05jNTBRV055eVdMRjV0WkkzRiszd1pTcjRuNlFnTFNu?=
 =?utf-8?B?YlRSd0paU3hrSmVYSXYybk5zNWhuRDA0bnRVb0pMZEprbEIvQURTS2FtSmta?=
 =?utf-8?B?bzRlaDAvaVIyd1lyY2FzN3A4VTBsdzhEemI2akI3THZUTWx5bU04RFJGZG91?=
 =?utf-8?B?eVJ6Lzhnd216MGYyNGoxOGNVbHoweStnSWNVREhMalVpZ2I5WlI3aUtueUIz?=
 =?utf-8?B?MTV5cVNnMW4zc2xzQndlYVBlNzlLSGVoS1lFQ1A4cncvNnF0c1cvTUFDYml5?=
 =?utf-8?B?M3B1dnZhZXlzVjNTU0dGNG1iNGxSdkxCOG93VjJkK05BUEQ1N0d5T3JEVFc0?=
 =?utf-8?B?VC9VZDh4T3gzUjAzRzY4RkY1Q1JJdzMvQk04TERCYi9hR3ltSnl1akdVNXAy?=
 =?utf-8?B?VzBpOVRid1N4cTkrOWJqSWcvTENGVmQ3bkVsSFpwUWY3bnhZY3JVbUNQQ2pC?=
 =?utf-8?B?bUVvTXJxbDQwcTBTZmxjQVpYcW5Qb3dlaTNkb2tseEF2NStrSSt5Z3p1RTFv?=
 =?utf-8?B?eWJZZFNZZHRSRG9ZREx1OTNjc21MUzRkcndWeURVQ3VIWUhSRDBENVNWQkNv?=
 =?utf-8?B?eUxmeFpRZmxBQ0lLTGlNa0lOTE1mODZNdW4vZU9sWTRqMXk4L0hWbDhUUS9n?=
 =?utf-8?B?ZXpUbzhGUVpCVS9leGJ2bXh0ekxodWNMajVENGNOMXJwbWpLU0VRcXk4dEpL?=
 =?utf-8?B?bHI4TXFieDVKNGk1QVkyRm5pUEJSSHU2SFozK3RqUERYY25Ycm1mcXNqbjBk?=
 =?utf-8?B?L0FrMWllUEIvSGZyc01jMm5RMVlwdTllczBmZldMNm4zaFp0d0FycHJvTHEy?=
 =?utf-8?B?cE85UTFiazhFRk9pZjZ4a2VBbitaUmVpdURIQzlzWEJ4WEtlakRjOGRYU0Jj?=
 =?utf-8?B?TTlCSXMyNzBvN011L0U0K3RGcytsMTFNMHdhRTh0MHEyaGRWendNaU9yZ09E?=
 =?utf-8?B?bmsrNFM1NVJ2TWZwaVJjRHFGVlEzWjdTcE5sUDZ5TVpNSjNvK0ovUWpQalNW?=
 =?utf-8?B?STZLQzMwbjc3Uk5pRjcvRUt3ckxWRkN1djF2MVl6ME9tTUNCdUtyT0srVjhr?=
 =?utf-8?B?V0FLYmkyQzU4cndYbnVDamZyRnhuZHorUzlpWHBXeW56YkdjcGkrZ3BJTzQ5?=
 =?utf-8?B?bDIwenZLWGJUVkEvMjFONXIzNHdrYmtZUzlNQXMya0xEKzRWeE4wZkNCTU9s?=
 =?utf-8?B?WU9jZXpQSzBvL0NQWVU1V3RyOXM4TDRlMHVCQUF5UWNvY3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eCtNZ2x3SmZlVVdoZmtDMmF5Ti91blpaYnoyOWNHTER1NStlSkhSTGJyeXUr?=
 =?utf-8?B?N0Q0WTdPeWd6Qy9maWRjNkZ5Zm5RaFlxeVZVZlRzV21wc0tGVHErNng3Q3Ir?=
 =?utf-8?B?aGRDUXlhQmpJaWRKbkNrNkF1VEcwMUsvUE9XNmFkMWFlemsvL0lsQk9pSEg0?=
 =?utf-8?B?TEtGTnlRdHl0b01VeHVVb3N6dlVrdFBpNiswb3VkTTArUG5hTnAwM0srR2xH?=
 =?utf-8?B?WWZsRlFlVkx4NEl0clJNV2dNV3EyMDVxS1FLdDdwa3cxNzNkT1MwT203OUtM?=
 =?utf-8?B?WVhRQThKdG5KdXo3bE53S0J3VnpPVHlkS0RqanlVUTRiQS8wWmJNdTVEWlpp?=
 =?utf-8?B?Z09UZEhrTEZGc2Y4UW5aaFJDaVBmcWxJbzNIRFlUR3dIaTh2OTlGbVYzMVhu?=
 =?utf-8?B?RjBFLzYyUHRrU0ZMb21PYWtZbUdBaTI5dmFmbkxBMThPNDhJTHU0QjFWQVdG?=
 =?utf-8?B?ZWd5cjl1MDlnbXZjUlExTzlOUkJCYkNvNXhWQlAzRTdFQytRL0ZENVhzRStZ?=
 =?utf-8?B?UVhJbTRJMjg4dDAwYWsxUkxYRW51WWR4SjBqa2UzdnBEQmNPUmRjSS9iWE1m?=
 =?utf-8?B?SXNTaTFGOUh2SFJmWlJlK1I3SU5JdGhBOER5VGs1WHlSbE1tSllLV24xNWt4?=
 =?utf-8?B?STBuOGluR3hwZGpCbHlNSCtHRHFXZTdtL3d5bjVmOHZQYlpuNWU1bnhKOUw2?=
 =?utf-8?B?NndjbkhPVVFvYjB0Q1pkTHZYVElROGh0UEF4Zmp6UHd2azdFTXozWUtsZWZi?=
 =?utf-8?B?VnloTVZTcys0b3g4RU5GM01wUlRsMWtGT3lBT0htYnhhNDVuQlpkVit2Kzkx?=
 =?utf-8?B?b200U0JsRVE4bXR0ZGpycmdCdGpkMWptZUJDa1VvSlhqTmRremVuTjVCRlVr?=
 =?utf-8?B?R1RnQUZVdVVVTXNodmlYRHJiZGdmaVVXV0MvbjUreVVZdDRPay9FaW80dnp0?=
 =?utf-8?B?STBLa1Izc2JrRGFrZGUrOEQzcE9EM0xIOFgzNkFPZ2J0M2w0bHJYSmxCUUVv?=
 =?utf-8?B?T0JnYktzOE40Qk9tUm4wcndWalJkR1hYN2t1dUxMejhjYkd5UHFsMjU0QVR5?=
 =?utf-8?B?N2Iwa3E1NmVhU1lKZVpUcXlEbnFhS2dseE1ab2tYOU14NW5tcGhreENvMEx3?=
 =?utf-8?B?aTZwTlFaOHF5RXh1Y0kyQlA4UE10ak5vbTNVQnIzbkJjZ3p0RWhKSCtodURz?=
 =?utf-8?B?K0orMU9tK3llY01LaitxcEJIZElFdloraTk1NUJSd1diMzZlQ3ZtMWpBQUhl?=
 =?utf-8?B?M3NIY3M1RTN5T0h6SDYzVjVLdGRZYkhsQ3Jkc1gzSFY3akRYcU1FZ3JSYUJ1?=
 =?utf-8?B?TTdvdWNTMGFJZ2EwM1kzV3pTQnVTbTA5MWp6WittSm5lejdyQWk4dG9mVHBU?=
 =?utf-8?B?ei9IS3FlYUFIZER2UFNrNTgrK1Q5eVVLdldpK1kwVFlJRFhoUVVYRzVlR25L?=
 =?utf-8?B?THZ3MUcwcEFWaXQvdlJIL0FPRFhicUw1Q2dUY3FZSWNFNlM5S3FKRlRpTVJE?=
 =?utf-8?B?TWFQQUhjL3RheWhpT1hyUEdwaDYzcnZKMDFVZXFDdjVtZUdjWGZ3N1l6c3BF?=
 =?utf-8?B?TUlDakMwa2V2eGU2V20xaFA1NzRYVGREWmk4dXRRb1pGSzlHVjNlREtldzRl?=
 =?utf-8?B?cmJkVm5EWGQ5djk2bXg1K0tXT0RTczMzMGVCNVJ0dDltRjN5cDc4R1BLRG9s?=
 =?utf-8?B?YXp4ZjB1SUloUzZ5amVFVk1lc21PaHUxM29WNkN5Wi80ayt3YWlROEtaME1T?=
 =?utf-8?B?NEFOMVBVdjJtVWtwbXJ4Z29ueGtxNCtVR2lFQ2M0Z2hneHdqUCtyVUZjUzcy?=
 =?utf-8?B?a3c0dkFVSUJ6Q09VYXNRWFd0ZzVMVFhVUCtjWFMzckdseFZ1bXMzck8xdi8w?=
 =?utf-8?B?QmYyZUdoY0R5RmtQVWNiZnN2RmtZRW5YN3RoMXNYQkdHL09aenMvd29oMmg1?=
 =?utf-8?B?dkJ4M0NRQ1Z4ZnlOZnh0WUphMzVwTGVwL3RERTRCcUIrUzBOV05reHpHdVFW?=
 =?utf-8?B?cFVPbFY1SEhoUzhsTCtVWGVuN3pkWVdwTmFzTzh0aG9QQWpTZzhOZkZ3eWJX?=
 =?utf-8?B?YVhPTGNCT2cvU2xUTlV0aXRkN1lYNjdwT2NlMWhML2xMbysxa0Y5dHRsdTVC?=
 =?utf-8?Q?6wn8PT9oIcCt/PK3NJEL4fZpr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21e3010-27ed-4945-587e-08de17c15b41
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:33:56.2393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoMuInqV7DMNdzzkwOmbT3GUIDXqlztaz016YZOS0pXCsIIsjL4WWLQCMCQDyo1ysb/me6eJAS5z6S3pS7Ps2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192
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



On 10/29/2025 4:19 PM, Alex Deucher wrote:
> On Thu, Oct 23, 2025 at 12:53 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> If device suspend has failed, add a recovery flow that will attempt
>> to unwind the suspend and get things back up and running.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Patch is:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

I made some minor changes to this patch from testing feedback in a v5. 
It's now patch 4/5 with a few other things I found in 2-3 and part of 
another of your patch as 1.

Could you check that one?

https://lore.kernel.org/amd-gfx/20251026042942.549389-1-superm1@kernel.org/
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++++++---
>>   1 file changed, 72 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 3ffb9bb1ec0b..645b15aa34f1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5231,7 +5231,7 @@ void amdgpu_device_complete(struct drm_device *dev)
>>   int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>   {
>>          struct amdgpu_device *adev = drm_to_adev(dev);
>> -       int r = 0;
>> +       int r, rec;
>>
>>          if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>                  return 0;
>> @@ -5247,8 +5247,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>                          return r;
>>          }
>>
>> -       if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
>> -               dev_warn(adev->dev, "smart shift update failed\n");
>> +       r = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3);
>> +       if (r)
>> +               goto unwind_sriov;
>>
>>          if (notify_clients)
>>                  drm_client_dev_suspend(adev_to_drm(adev), false);
>> @@ -5259,16 +5260,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>
>>          r = amdgpu_device_ip_suspend_phase1(adev);
>>          if (r)
>> -               return r;
>> +               goto unwind_smartshift;
>>
>>          amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
>>          r = amdgpu_userq_suspend(adev);
>>          if (r)
>> -               return r;
>> +               goto unwind_ip_phase1;
>>
>>          r = amdgpu_device_evict_resources(adev);
>>          if (r)
>> -               return r;
>> +               goto unwind_userq;
>>
>>          amdgpu_ttm_set_buffer_funcs_status(adev, false);
>>
>> @@ -5276,16 +5277,79 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>
>>          r = amdgpu_device_ip_suspend_phase2(adev);
>>          if (r)
>> -               return r;
>> +               goto unwind_evict;
>>
>>          if (amdgpu_sriov_vf(adev))
>>                  amdgpu_virt_release_full_gpu(adev, false);
>>
>>          r = amdgpu_dpm_notify_rlc_state(adev, false);
>>          if (r)
>> -               return r;
>> +               goto unwind_ip_phase2;
>>
>>          return 0;
>> +
>> +unwind_ip_phase2:
>> +       /* suspend phase 2 = resume phase 2 + resume phase 1 */
>> +       rec = amdgpu_device_ip_resume_phase2(adev);
>> +       if (rec) {
>> +               dev_warn(adev->dev, "failed to re-initialize IPs phase2: %d\n", rec);
>> +               return r;
>> +       }
>> +       rec = amdgpu_device_fw_loading(adev);
>> +       if (rec) {
>> +               dev_warn(adev->dev, "failed to reload firmwares: %d\n", rec);
>> +               return r;
>> +       }
>> +       rec = amdgpu_device_ip_resume_phase1(adev);
>> +       if (rec) {
>> +               dev_warn(adev->dev, "failed to re-initialize IPs phase1: %d\n", rec);
>> +               return r;
>> +       }
>> +
>> +unwind_evict:
>> +       if (adev->mman.buffer_funcs_ring->sched.ready)
>> +               amdgpu_ttm_set_buffer_funcs_status(adev, true);
>> +       amdgpu_fence_driver_hw_init(adev);
>> +
>> +unwind_userq:
>> +       rec = amdgpu_userq_resume(adev);
>> +       if (rec) {
>> +               dev_warn(adev->dev, "failed to re-initialize user queues: %d\n", rec);
>> +               return r;
>> +       }
>> +       rec = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
>> +       if (rec) {
>> +               dev_warn(adev->dev, "failed to re-initialize kfd: %d\n", rec);
>> +               return r;
>> +       }
>> +
>> +unwind_ip_phase1:
>> +       /* suspend phase 1 = resume phase 3 */
>> +       rec = amdgpu_device_ip_resume_phase3(adev);
>> +       if (rec) {
>> +               dev_warn(adev->dev, "failed to re-initialize IPs phase1: %d\n", rec);
>> +               return r;
>> +       }
>> +
>> +unwind_smartshift:
>> +       rec = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
>> +       if (rec) {
>> +               dev_warn(adev->dev, "failed to re-update smart shift: %d\n", rec);
>> +               return r;
>> +       }
>> +
>> +unwind_sriov:
>> +       if (amdgpu_sriov_vf(adev)) {
>> +               rec = amdgpu_virt_request_full_gpu(adev, true);
>> +               if (rec) {
>> +                       dev_warn(adev->dev, "failed to reinitialize sriov: %d\n", rec);
>> +                       return r;
>> +               }
>> +       }
>> +
>> +       adev->in_suspend = adev->in_s0ix = adev->in_s3 = false;
>> +
>> +       return r;
>>   }
>>
>>   static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
>> --
>> 2.51.1
>>

