Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224CCC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 14:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8921210EFB1;
	Thu, 25 Apr 2024 14:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vACFHEvA";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933F610EFB1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 14:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5HxYJfd3tC5aqzmKR6xOeKcRFsZjOEJMPlrfNzCFWzVKSWzGd3p5/65r4v56TPLXMvvifnnivzs+5O1dV/JFuTmeSboMwTT6nkFZu88qePkwG1n7otFZ9CUiMHB1Fyr9gz+d2C0NsduHMIfFEAnnWuyxQtsTnaqIe4ALkhV/BBVXXGcgVI5DHcMnvjEACKLmE2B2lKwKBqqQ+G3XOs2b9wBRxilgdYiLo9KOx+gKzjw1B+Z4KsRt+Log8J9kcg4zxxbwwpiGe1aXKGiv5DKSK82pV/EJubjMXMvFflvtBzE8TAM1DVJWB6DrC9vGGwq7hKjbe5vgO1/m7jVz9KSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+h8IuXQ0qtBLqu3aL9+z3bi9/PfE+DF+9VIypQP5Ew=;
 b=RnCG9xodlFLwTD2xUqQr8H//p5CCzpkpbO8/Dsj0AlhvB7mBMfungF6z88XYIs83YECwo7tL2z02YaoBl3K12FNf3wBtYC5XzY4ffqqHoY8Q5kFo1r8r32/ePULtENtmHk8WBpwVYeDm1+hzV90BJ0iX/8LYg1PhnelxoMpm0M68rPZwQe/FH1gc9gXO/4F+Ao0L4Bug7DytxDDWUTxF0YE3YijNIrvkMprYNSOWdFknGCK1Udi+zPS4CvOrtMEOuYC6GcnuwqgpXm4sBp2zM9vOzaFbv2GL79J7KlW+lWBENCfVUWlfvTJ4gioBLr1/UTDKJagrEiBaWgfgF6zm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+h8IuXQ0qtBLqu3aL9+z3bi9/PfE+DF+9VIypQP5Ew=;
 b=vACFHEvAalCxVzsnkDfj4ggnmeGSEAc2r/2EI4DXGJ7NAxDwQB34iLolY6rCAER0EaoyGOvK9I/JVZaUTpdkksMxYtsCY7D/+jnmqanwJkjceVTtP70eyPxOO+WDk16Lc5EI2I/6zBTFuHBinP8qxguq59lK7Meqyb5cUU6Pk74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 14:03:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 14:03:16 +0000
Message-ID: <15f7eb26-740b-489b-8c6f-e6856613cfe8@amd.com>
Date: Thu, 25 Apr 2024 16:03:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu/gfx: enable mes to map legacy queue support
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com, Likun.Gao@amd.com, Jack Xiao <Jack.Xiao@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20240425094743.134248-1-Jack.Xiao@amd.com>
 <20240425094743.134248-6-Jack.Xiao@amd.com>
 <CADnq5_OuNdjtxu4JoJGz77LKPj7b0zNw7BJcquNWah74_bAwiA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OuNdjtxu4JoJGz77LKPj7b0zNw7BJcquNWah74_bAwiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b29a73-1814-42ba-c967-08dc6530740c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2xPVFk2VFlKMTJaa1VGL0UyczVFQWhCTXFIcG1tdGhZM0U0NmhQTHJFZ0cx?=
 =?utf-8?B?eEh6OTRkUUhIelRHbHpRWm5HaXIzZG4zT3A5RlI0M1o0eDRObWNtenNmZnor?=
 =?utf-8?B?Wm9zZUc1NTBIZ3V6V0FBY01mWTAxbVlwdHhGYks2Tis3a1ovT2pWMGlqMEVu?=
 =?utf-8?B?OVp1QUtrYzh2Nk54Zlo5alJ2OHhSWm1BRkZtSUptRjJ3cTZsbWlNbEl6ZXlz?=
 =?utf-8?B?M1FhK0s4SU9Pa3lXbHNRbW5uY3p5R2g0Y3NUaHNEaW5vUHh5ZnZxQ2N4VmVE?=
 =?utf-8?B?YjdzK09CdUI3UGR1eFVjQmdMVnRLaGtsaWlZa2NjQTNwckZxaSsycG9la0NV?=
 =?utf-8?B?RWtRcTU1RmhDdkJEc2cyK3B0NHdOS3orYTFiZkhYY2hTc3hULzhDMEsvcVhG?=
 =?utf-8?B?cmdaem5TalNaSm1XTVJ6RURYc1ZvclQ4SnF5VWdnZllrOHZYWGUxTStIUll5?=
 =?utf-8?B?VllpYmlKY3ZaV1NLcjZBbVFuNTB0RUJhVU0xbzN4U0tHRk5sclVnb0ZpelJp?=
 =?utf-8?B?emp2a0R1eVowcHVUdHhTbUNXcHR1b0h4VUZVZmNhMi9UL1BKUXlkYW5rWHJ0?=
 =?utf-8?B?N1BmUUlEeFg1eHl1cE9YdFRzcjlka1RmQlhBNUVXa25yUVJ6Y3h1SFNHVjdq?=
 =?utf-8?B?S0Q4cS9Fd0ZrazVONUtCb3EwRzB6UXI0NnJGUy9iY1FLcWNBSE9MR0lLM29M?=
 =?utf-8?B?WDg2R0o0dlV5OWtTUHBwb2NXQkdNejlBd3pTdmFIeFVselk0cG1GV3JRUU1a?=
 =?utf-8?B?WU9XcVdvbjM0b3JNODV2RjNUZm5iaWZSRVdyc0Jqcm4yK1k5NEdsa2pCR3Z2?=
 =?utf-8?B?cURKU09QUGhYZ0VwS2pPNzM4UnZPQTFHWUpKNlpyUDdJc3FKTDJrMk9EbXhj?=
 =?utf-8?B?QVhrMnI3cWlVRzNyc1cyZDdMRVhTUHl0OFhQS084MVBYelZQQk1aU2xFRVlR?=
 =?utf-8?B?SU83SlVZazlXK1piR3ZCUWg1RWZtT1M0VEZhRDZiaUtkbnF2ZlBxL1VQNk5h?=
 =?utf-8?B?YXZKVXVJQnFpcDVVNFB5VWtYRFRBeUxjSnFPNkdEM1FqQXUreDdPTjdvaUlX?=
 =?utf-8?B?U2FvSHZnRVZQNmFNR0NZemlDUGFqTW9WVkF5aXFlSmNrM2t2SGRlSkZSTmFw?=
 =?utf-8?B?WTZLLzZWZGJaZXl0ZFArc2xrZEhQa2g1cWRVQ2tOUFVqdS9kYXRXd1lyMmNa?=
 =?utf-8?B?RHRvU2p6YVdoUjhPYlJ2RVhNa0trRm9seFI1cnM2SHlYREJNeGJPbk92N01p?=
 =?utf-8?B?cjBhVWVHT0FxblVzY2NHb01FQWw4bUNOU0pja0ZVSCtnbXBrTGY1dEJjcFlo?=
 =?utf-8?B?aFRMOVhVaVZuN3pkZDhSczcvTVB5akpVZDNaMHpYWVQrSU1WbytybkoyRHli?=
 =?utf-8?B?TkpLdGtBcDQzMlRMYkVpdklJOXVkU1RoQ2FZMW5LbFJZMUlPcmRjMXo1UjJJ?=
 =?utf-8?B?VnJuRWhxdHJwbGdFWC9jdFppbXFyR1N6SVJFK1RDVHh0eE5lL0d1TXRwU3Z0?=
 =?utf-8?B?dHM0U0p6MVRoalBzdFNBLzYrYjRSeVdZTlhxeUt6cUhKajMwQVZ4YVNRcXlY?=
 =?utf-8?B?YUZDQVBzWml6WEozems1U1VoTThhYlFFanROSVBlTXVVcm8vVGNVN2wxQnJP?=
 =?utf-8?B?MkkwaHRxcDBkNTVSa1Z5RGZMQ3E2cmxycUsxVGdEWkI3V2Z5cERZblhaNzdm?=
 =?utf-8?B?N3NoMlhwSDZ2anEyZkNGaGZZY1hFL2dKMDZDMDF1WkZ6cDErM09JOHZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVpsWTY2L2JmeXFkWllKa2ZjMTlJTG0vdDRGR2U5RjNrTHFGZ1VRMzRwVElk?=
 =?utf-8?B?QWlmWW01aGl5K3hZLzZlZkpuWkdTVkxlYWxMWk4wRkVMWGhxbzNrbWkwcldM?=
 =?utf-8?B?UEV0eUZVRkVKTVR0RUYzTEJnQzZwbitnNzRrdkYvbnh4TzBjeFlZVVhJYndi?=
 =?utf-8?B?NmxtRFZxT29HN0h2SDBiRUJIaW5MRkpDQVpHdEc0K0VQdjJLVGk1SE5jUGd5?=
 =?utf-8?B?Zk1oYnFrcGFTN0x3WUNRSTQycWFvRXVEd3ZFcks3QWY3d2NJelZPbUg3OXJi?=
 =?utf-8?B?akRSMUlhTkQ0S0NKd1JOcVI2eldKYTJKcVRCaCt3RHJZazhHME5VVEdYQ0tS?=
 =?utf-8?B?R0RTMXlFOHUvdC9JN0JZQndOeTJzM0ZwbUNnTUtzRWxKdFQ3TWx6dTJpeGg1?=
 =?utf-8?B?WnIzRy92ZTRWeWhWa2hQWGMxWUFReUh4RjQvMDQ4VTRZcEQ3eGNGUUdMS3Bw?=
 =?utf-8?B?Qk13VDVXaXZxcnBITjVrVTE0TG1wWTBrRk9hNkpWeVY2VUpNTDhBcDZwRGdm?=
 =?utf-8?B?M2tVSFhRZm43bjQwRVZJYVRFOEJUWWEvbG8yZW4rMml1RjVmNCtlbnNDMG1p?=
 =?utf-8?B?UjRpS0JSanlOOEY0cXN6NnBUWlgvUzJBSEdSdzlBSUZrRDdMVXZRVktMZGNq?=
 =?utf-8?B?dDBDb3hKb3NQVllZZk9sTjNqS0o1ZFAzQkJKb0VJanRFSG9oZ2YrR2tKSks1?=
 =?utf-8?B?QjQveXpGZkVIU1BEemxXcVpsTmpNOUpWdXkrVjhBT1BJOEZrRVY1NU9rdXk1?=
 =?utf-8?B?T0J5OTUzTWdQMEFPdlZiMm44WDRHaWVzckdEeXlWU0hJUkVxdnNRcnNhMHY1?=
 =?utf-8?B?SzhkZ1BBcXdXN2FUQURLREd3cVdBVTRKZkxZL2NwckJ6dmhDTHlRU0d2cllu?=
 =?utf-8?B?K3VHdGh5YU42MmFuL2hUVDRKSko5MGNVeVFPZnoyUHRLS0NZMmJvUHljL1FD?=
 =?utf-8?B?ZDFHSlRTTW9yWGFJNVdmWjJCMlE5aVlhSDJ6dXNFYkVOUjhDLzFXUmE1TTh0?=
 =?utf-8?B?S1JzNnVzdER6NXBNR21HNHB5N0o2OWZNR3ZBQzZJajk5ck1YdnFoZFduNkh3?=
 =?utf-8?B?MXI5RldtVnpmenRrblpKNmJkOVgwS2dRaFJFby9XRWZXS3habmFaVmEzbm5K?=
 =?utf-8?B?QVVwdXVkVUlmSldBaVBhbGdoTnZrYUd4Y1Z2VUtYR2tNVC9WM1Z3OWxkckZ4?=
 =?utf-8?B?SXRNS0RzdlNCY29zSnZBMnNkS21PdnpwM0FEYUt4MEtXbm4zZGRPeVFMUnBt?=
 =?utf-8?B?eU9rQ3F3eEJvL3hPTU1LWVlsTkR0U2RyakZ5MjNJNjc1WmRzQ1lUOWpTTmNq?=
 =?utf-8?B?SmR2UERFZlBvN1BhTFBVUlFXZ2RaUTd4T0h2ZVBVTlBXSm01WWg1VU5HVUV6?=
 =?utf-8?B?Mit2VFFQRnpORThYY3QxUXI5dGpad0FsVlBLN2hNNklLR2RQbnZjcTZ2aDl5?=
 =?utf-8?B?eGVGUyszaXNqMHY3bUZaWm9yRHIrQ3pPVGpEQXMvd1YyQVhXazQ1YjZLQ25R?=
 =?utf-8?B?NFErT2hLb1pBV3lYb0pQQjZQWUFWSDk3YWxMNmNXSU1oNHpXZWNFTkE2Tlh4?=
 =?utf-8?B?RFZoc281WmZYcCtpNEVSMU5rTGF1QVo2VDhrR3VJYzZrWkMybGxISGdnb1ZG?=
 =?utf-8?B?bzY0cnl2Z1hCQm4xRDBRZFduZ3RZVXExZFRVOWpLd3RheEJlSTRXbzhGODNM?=
 =?utf-8?B?SUFCbnRrMTJQV3dmTWZucUhVMVJiOUt5YWFId2ZYMEgwTkFKaTBwbWpVZHFV?=
 =?utf-8?B?MlRHV2hPQmJYVDQ3M0FvY1FrRU5hbkxVN1N2aWVteXNGWEd0bWNMUUhVd3Zl?=
 =?utf-8?B?MkhCRkhnRU10Y0h0bEpCd0lEaVY3R0hFdzNXQ1FKbFMra2pIN1N4SHdIRXIx?=
 =?utf-8?B?SmNJR2JrR2ppanZFR05SRVBHdVZhOG1kMDJSTUJnaHdOSS9HN2RnWHZJbEla?=
 =?utf-8?B?VVFGNEFjbWNpcFlwRXMzekQyU2c0RlgyVzRKTE9ObllobUh3YThrSEdkUmF3?=
 =?utf-8?B?WUdhejZ1Vk1iZXdmQnBlejFQN3VRQWpuWG9xWG9ZZWpIZzFBOCtQUnl5K280?=
 =?utf-8?B?OFFxeGcrSkVISWlzVGVpVEx2UDRNenJDczA0U25URWpSQ3ViQ0czNFJPQzlW?=
 =?utf-8?Q?hevG0wRyty4jBViuohJi2PUIK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b29a73-1814-42ba-c967-08dc6530740c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 14:03:16.2491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJztj+MBQx17hKBt2SEVRnEvO32CUdLxCehwlcglmlt7F/DQf0QUvf1vjlAlmiQd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
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

Shashank can you take a look as well.

Thanks,
Christian.

Am 25.04.24 um 15:40 schrieb Alex Deucher:
> Series looks good to me.
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> On Thu, Apr 25, 2024 at 6:07 AM Jack Xiao <Jack.Xiao@amd.com> wrote:
>> Enable mes to map legacy queue support.
>>
>> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++++----
>>   1 file changed, 34 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index d95555dc5485..172b7ba5d0a6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -622,10 +622,28 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
>>                  queue_mask |= (1ull << amdgpu_queue_mask_bit_to_set_resource_bit(adev, i));
>>          }
>>
>> -       DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
>> -                                                       kiq_ring->queue);
>>          amdgpu_device_flush_hdp(adev, NULL);
>>
>> +       if (adev->enable_mes)
>> +               queue_mask = ~0ULL;
>> +
>> +       if (adev->enable_mes) {
>> +               for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>> +                       j = i + xcc_id * adev->gfx.num_compute_rings;
>> +                       r = amdgpu_mes_map_legacy_queue(adev,
>> +                                                       &adev->gfx.compute_ring[j]);
>> +                       if (r) {
>> +                               DRM_ERROR("failed to map compute queue\n");
>> +                               return r;
>> +                       }
>> +               }
>> +
>> +               return 0;
>> +       }
>> +
>> +       DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
>> +                kiq_ring->queue);
>> +
>>          spin_lock(&kiq->ring_lock);
>>          r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
>>                                          adev->gfx.num_compute_rings +
>> @@ -636,9 +654,6 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
>>                  return r;
>>          }
>>
>> -       if (adev->enable_mes)
>> -               queue_mask = ~0ULL;
>> -
>>          kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
>>          for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>>                  j = i + xcc_id * adev->gfx.num_compute_rings;
>> @@ -665,6 +680,20 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
>>
>>          amdgpu_device_flush_hdp(adev, NULL);
>>
>> +       if (adev->enable_mes) {
>> +               for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
>> +                       j = i + xcc_id * adev->gfx.num_gfx_rings;
>> +                       r = amdgpu_mes_map_legacy_queue(adev,
>> +                                                       &adev->gfx.gfx_ring[j]);
>> +                       if (r) {
>> +                               DRM_ERROR("failed to map gfx queue\n");
>> +                               return r;
>> +                       }
>> +               }
>> +
>> +               return 0;
>> +       }
>> +
>>          spin_lock(&kiq->ring_lock);
>>          /* No need to map kcq on the slave */
>>          if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
>> --
>> 2.41.0
>>

