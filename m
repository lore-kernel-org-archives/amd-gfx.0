Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491C2CF0429
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 22:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E0E10E26C;
	Tue,  8 Oct 2024 22:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2u44RCpi";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC8410E26C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 22:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGpRdk716ltUT3/asjP74bHCDmb4ccykn0F7cic5yFh8nz845uyv/ZX+pYBqCZ4pNnpF6QlXqjmjCaXDoY4jEASfsf1yCZ28RyTzb/Wm4MBccjn5nd7cr0mi3zUwM/pNOQpxxaItuHeN64ldLieDXNhrBNcVpsS4EUknfXAc0tlD8sCC4gNB7KXH2V7tupCNe9P3eOc3BncGHIkpOnK9yMPfOCoc5aGBTInrHxUIbaIjVLsMsjKsbyGXore7YCGpKwwdeP5QkKTa+jV36ZHb+jQ+NT7n3CD941/d7FFbPyK8/8DeULdVacIg2rEaz8XvAsHnpMlO96w7N059Fw7aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkp7cQf96KeyMjzKjMIhSVODnOGpTAJ/68atIZg3Mjo=;
 b=KAto2tFHORNi1NazvT2F9Cam5na+/kw8U5oWhYWmxC3XF8/5Pvs9Yb3Nsnz6hE5QNhRe3FcfOanTy/tuSQUTRRsuBgkLHL6grmV+bGz+igoG8lV/XWJZM0qSkHaQLDC5GqNdWlDYZ0INXLFTNs5jfd87ZoN2uYPS+gJdLshdK4dVyRxdHKiWKZLY9Kqdy7nAzQFYoDeBBPaKoW4S9hq3mmRvARz669Q69Qa8m1UHrGbi5rwmHie/9RdaJ/oJVQCzzHkgJfEgT9Iw6orN37vjH0+Dd6WVydYym6b4dKj7tU8oghupJ2IV+YaxxyTdxTmoViLVv6Xwb84FEIcHQnZ7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkp7cQf96KeyMjzKjMIhSVODnOGpTAJ/68atIZg3Mjo=;
 b=2u44RCpi3CqHCpNc6IHUV1Z6rYhu0j3/3LkSF+f0B9ITQfqC0/YLVUv3O3FHun2JWci7x5/HhRQEtg/t64oVoRtVixNxjlSanh+Px9qcSv6ncYXNXrASDbY6GDmoSKEUMxXxHdwADkeVeofzyYYlyqreu256fukgQmBscSULoKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:10:50 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 22:10:49 +0000
Message-ID: <4563ca11-993a-433d-b74d-24e002b95e8a@amd.com>
Date: Tue, 8 Oct 2024 18:10:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] drm/amdgpu: power vcn 2_5 by instance
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-12-boyuan.zhang@amd.com>
 <CADnq5_M7_JEaymMEs4V-k5oi404VWtZEdC9gJAdwNHVYfOCSbw@mail.gmail.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <CADnq5_M7_JEaymMEs4V-k5oi404VWtZEdC9gJAdwNHVYfOCSbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::9) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: a472a82b-250c-4551-e6cf-08dce7e6113e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWtqU2llS2JxbXhtRjYzeG1SNWFEVVNTZFZMSEYreGJkNFRXcGxPN1FjNUl5?=
 =?utf-8?B?M0lvTmgvazlxQkQwMnBLMlpzRjZuWjZqNk1tSTRwUDRqcU1iczMreWdHRDln?=
 =?utf-8?B?RDV6dExlOTBnbHpuMDEzc1VBS09Za3lkTENvWVVteVZOVi9nbGtGa3hMZ28y?=
 =?utf-8?B?bFIwaWE2VFpxb3Y0UTJPUzlRME1oZ3lNVHZ5Z29Vb2ZZSGZLQmJlK1FiUitR?=
 =?utf-8?B?Ry9ZRXFmK1cvaS9kTkgrVm1SSVJOcUNTd2E3ckFzUFdxeVNlVWR4aWFwUXhu?=
 =?utf-8?B?ZU1DRWFQV0NTOXVJUXQwek5SUlhidUEwR29PZ1dyQnkrMS9yWmtQcEJ6cEVT?=
 =?utf-8?B?aEsrWmFCNDZ5OG9oNlZONERMb1FSUFdsRi9pYVNpTkdBSnc2WXZRVTY4OE8v?=
 =?utf-8?B?ZUdSZFRBU3gvSVUzejBLMVAvTm4wTmh6QjhPMmE5TjdlVk5Yd084ZkJHWE9V?=
 =?utf-8?B?WVozWFJlajA2UW5NUWNLOUdPWm84M25IeEJld25SeDRNRHhTWWN1ZFJtaXY5?=
 =?utf-8?B?NFpLdkJUeWZFTTlrUjQrNURyenJCaERobzlKSWNObWdJVXAwaGFTZUtidUdx?=
 =?utf-8?B?TkIvYXFhai9uUnBibHZMYVF6UkE1Kzd3SDh4YjFYQnZHeG5TV2FtTkNmS0N6?=
 =?utf-8?B?VzR4d1NvWi8ybUZrek5hNzlMNE93cnV2ZE1hNHd6TGNxWExhd0JzdmllaGxJ?=
 =?utf-8?B?R2VISFUzQVVwekRyZkx6RFp6UkpqbTNYcG5yYnJ6RE8rUDY4aUViZGhCNkRa?=
 =?utf-8?B?MmhpVVN2djM0WGRQQlZiOU1HeEp3L0lVTTl4MVhqS0szTkRzVm5tTzZKVUlW?=
 =?utf-8?B?eXMvYURZNGtTUHBEN0QxYXlFNzBqVmVDYUhJaUFhbUhCRVpKVmFHSHJHb2dQ?=
 =?utf-8?B?K0txWUdVTHNPelBodWc2aExETTcrZnBndmlETU5sZUFDbSt4MytOSXZxbFlY?=
 =?utf-8?B?YjNXYVZRdmlZUG9RenNHalBCVllrUm1QTXNVOFpjV2gxZXI3UlBBZUh1Tjlp?=
 =?utf-8?B?Wit6MlIvb2N4L3lOeG84OUNVWko1Qi9tUDZWNkJWZkNaK2hvVkVINHFoa0hl?=
 =?utf-8?B?MmNvZCt2a0FsdHBWQ2YwSDlJZElaVzl2ZUt6akhHMzV0bW15bFJYSWpNM2tS?=
 =?utf-8?B?ZHdWTTdLR1k0YkFJS01VSjU2TVJPNGhDWHhwUEpzQnY2NWxkclFhaFgyU0Ix?=
 =?utf-8?B?TWU2VVcxM3FXRXdNOS9uZkIrZUE5VjVWQ2dlbktTb2lTbEZLUnNyU05SQXJL?=
 =?utf-8?B?cHJEaXh4M0ZjcTJ1a2ZXWitaMkZmYXlNRkloVjZTOVRrc292SlorQWZJemVW?=
 =?utf-8?B?cW1rdDkzSzlKQUIxbEZKTTVXQkpHaDd3aTFWZGNpL29uNk5Kc2Y1Snc4b2Ur?=
 =?utf-8?B?WWRwdWdXRTdPaFhONzFQSi9sQmNHVzUvcklTb3Z4NlRybWZOQ2F0MVpVdFdZ?=
 =?utf-8?B?ZldkS3RTTGpkZVZ3ZkdGWlhEWGM5UHYxY0swOUVJdUw0cDgveEdQVEUrZElR?=
 =?utf-8?B?TnQrY0F1VmtKSmUwSTYxL1FBazE5TXVTVnJybmtSZUdZakVHemMrZ3laZ1B0?=
 =?utf-8?B?aUw0YkZlbWFMelFQQ2MybGFqU3IzRXg1aldQaUkwaWxZZGNiN3k5QWFsY3A5?=
 =?utf-8?B?NWhVNng3QWdBaUx1MHRCV0xiSmZmWVhwdjZrS2tKWG1wMkJicGdSSUV4aUZN?=
 =?utf-8?B?dnlhbndWampmQ292VDRtdU1VRkMwRVNGT1RwRXZkQVpkMHl3M0JBN1dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anUycGRFNzgrYnVnSEhERGQ0bTNENEk3SnJyUjlBNnZpaEFQMEE1M21DeW5t?=
 =?utf-8?B?MTdlYW9oY1VrVkwrMGNoU2JncGVEYUNvN1ZXblRWeUE4aFE0K09laTFrRlJV?=
 =?utf-8?B?b0haa1FJUVFpOEpiKzJqaEdYcGVBWWJ5TzBFdm1VVmR1c0RLYVNxSmt6Y2tj?=
 =?utf-8?B?R0FNSGN1WURxVHNWK0VQZHMxTlltdUltaElLc1A4ZHhsOUhQZXRUWUR5ZDNm?=
 =?utf-8?B?cStUUmNMTnVSUkNIa1FwUG9vQnZ1RVd6aWF2eDJrZHJxQWV1dVFOdyszMzRY?=
 =?utf-8?B?aEhCa1o1OGFqY3BrbU1ob3JLTFFvZ3A0dENsVVlrU3RTYi83RlJta3dqbVlQ?=
 =?utf-8?B?S0tyZHY2ekFkZk9JRDRDUnpPT3hjTFJzTWFhQmxxSzBIWEM1NnYwdWFQM1gr?=
 =?utf-8?B?TERVc0pOa3lTTzVXT1ZUVFhWNXlBbmlSWVdmV0g5Qk5DWFpHN24wM3VWSm1y?=
 =?utf-8?B?RC93d0RRZVRMU3BmSWg4WXdWdTdocnU3UjBWQ05vN2tXc251aDRkWExFVFMr?=
 =?utf-8?B?aXM5WGk5TU9WL1hmbERxWGlsT0RId28rSmVoUGY3YWlmVzh0T1hLb3BUVFhm?=
 =?utf-8?B?U3dzYUpyaTBkUU5vdm1xc3MzM0tmMFpKQjBHRWJlNW0xcVJEVEhlQkVCOTBG?=
 =?utf-8?B?YUhobTg5RWZLSUVqQnV1MUU4N0thZkdDTVFmV0pUQTlBQjFxUWhaSTA5djBs?=
 =?utf-8?B?LzVDMEM1a2VkR0Z3cEk5REczeVMvME1pdGIxTGY2RHlUTFFrMWQvWVZ6UEJC?=
 =?utf-8?B?ZUN4Ujg0d3FxNTJza202T2tZYXdMb2ZPdzdWTDFVUEZpZnJVemlUdWp0d0Ex?=
 =?utf-8?B?cDRMV3F3bkF4V2xKd1Q3UTFYRThRZExqcXgyc0VMVVNibE16QzJEcVEzR1dR?=
 =?utf-8?B?T2JJb3U2REhlUWY0OXBTOFc1NS9VU3NvM2NoeWdCWHp1TnB5dCtNcG54eWhm?=
 =?utf-8?B?WmI4TEkrUkN3WWhFaUdLc2pkeG8wdDZHUE9WMWNXMUgrYXJUVGNYVnk3SHZP?=
 =?utf-8?B?WmpVMWlTaTlPeUNib1ZDUkZJRWZyR1lSVWc4dytpVDdHOU56WmxpeXpic2lj?=
 =?utf-8?B?TXUvVHFuQlBBOWRsNkdJT0V0bm5KWjExODFmMG5BTmU2anQ4ZkdjamtKWmt4?=
 =?utf-8?B?UkszZ2JBOEYvRnU2VGljcHF2ODBpZExKbDZrMXlSYmw4b0NPTGlpb2trZlhl?=
 =?utf-8?B?YTVtNDdXNVd5TEFvVzFpUWEwOUEwUTVzYlFCRUdrYlE4V2VtemcrZGVpdW9k?=
 =?utf-8?B?ZVBadHdPWWUzWnpTYUxjRkJrNC93MHgyNmhCajlSSmRiQmIwdDEvZklUaGR1?=
 =?utf-8?B?bmFpNjZRYlJ0OHFnaXZEeEoySlBWdGlwTXlLOVpvbHhzUnQ5ckpweUo2aWlK?=
 =?utf-8?B?UWxvR1FkSHhlTkJPRTRqMlJQY3JuenBzWUdBTnU5Z1R2U081MW8wQXRLbnNO?=
 =?utf-8?B?ZHpHanMwTlZQelBhYnRaVnZwbjlkT2hjRlo2VVU3NjZXL1RtNCs1SWwyRGxq?=
 =?utf-8?B?WjJMN2s3TTltQWRTaTFGb2Nvc21LV2FaWjQ2TmptTkxtbHFZQ1pjVzB1ZHpO?=
 =?utf-8?B?TzNpT05PUGFGMWpVVmk0RU9tZEF1TVBCSDFjcXA0bXUyZkpmWWsyNmFIZVpl?=
 =?utf-8?B?M3J1MmpoVjg3dEpQRzhOVm9FVVlJSStqMHNZcmZ0b3JsK3kzNndaYTVLNTlH?=
 =?utf-8?B?YXJFQktoaW1QRkZjUy9QaTk1SkNoRWZxQktpcXlIWEhiWWhScmRqVUthV09x?=
 =?utf-8?B?V2dJTXdXa1lBMGoyam1vSlFWZFVKQzhrc3YxOHF1Z1RZZVVoYVAvRGRSS2NQ?=
 =?utf-8?B?ZU5aLzhQV3g0SVpUeW0wWENGa1lYVE16Y3Z5eFRob1MrYktEc3ptMFJBdnRr?=
 =?utf-8?B?UGtGdmFRaFN4Y3BsY0lmWE1GTEdaUHF0SHNHb0ZmQjdwQ0hQUEtKS1dyTUVI?=
 =?utf-8?B?cFpSQjdNWnpySzZDWTFEY0tlYUNoV1lreTBoNmdTZ0V6dGttUVRDbC9kRXR6?=
 =?utf-8?B?a3BNTWxnaXdROGY4dFo1cXZZOUJsNUJFZXdidHFwZGhOY0V2UVZLd2tKMjdw?=
 =?utf-8?B?U0JzcjFBWFhGbmorMHdmRlZTck9INDltM2FKU0RadWZNanE2aEFlMFdFemx2?=
 =?utf-8?Q?gBqWi41LMqoZvr/AdZ7KB1H1Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a472a82b-250c-4551-e6cf-08dce7e6113e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:10:49.9196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTf9S2ic77rnlukc4OfEmsEy08twfd6ggKuD/5b3Nwb6B3N3PwZYcESGxH/kfhm1KSfSLWJJ+22AYiK3lp4jXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
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


On 2024-10-04 15:52, Alex Deucher wrote:
> On Fri, Oct 4, 2024 at 2:53 PM <boyuan.zhang@amd.com> wrote:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> For vcn 2_5, add ip_block for each vcn instance during discovery stage.
>>
>> And only powering on/off one of the vcn instance using the
>> instance value stored in ip_block, instead of powering on/off all
>> vcn instances. Modify the existing functions to use the instance value
>> in ip_block, and remove the original for loop for all vcn instances.
>>
>> v2: rename "i"/"j" to "inst" for instance value.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 565 +++++++++---------
>>   2 files changed, 280 insertions(+), 289 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 9f9a1867da72..de1053cc2a2b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -2278,6 +2278,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>>
>>   static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>>   {
>> +       int i;
> new line between stack and code.

Fixed.

>
>>          if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
>>                  switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
>>                  case IP_VERSION(7, 0, 0):
>> @@ -2321,7 +2322,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>>                  case IP_VERSION(2, 0, 3):
>>                          break;
>>                  case IP_VERSION(2, 5, 0):
>> -                       amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>> +                       for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
>> +                               amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>>                          amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
>>                          break;
>>                  case IP_VERSION(2, 6, 0):
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index d00df51bc400..1f8738ae360a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -158,35 +158,34 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>>   static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>>   {
>>          struct amdgpu_ring *ring;
>> -       int i, j, r;
>> +       int i, r;
>>          uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
>>          uint32_t *ptr;
>>          struct amdgpu_device *adev = ip_block->adev;
>> +       int inst = ip_block->instance;
>>
>> -       for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>> -               if (adev->vcn.harvest_config & (1 << j))
>> -                       continue;
>> -               /* VCN DEC TRAP */
>> -               r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>> -                               VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[j].irq);
>> -               if (r)
>> -                       return r;
>> -
>> -               /* VCN ENC TRAP */
>> -               for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>> -                       r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>> -                               i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[j].irq);
>> -                       if (r)
>> -                               return r;
>> -               }
>> +       if (adev->vcn.harvest_config & (1 << inst))
>> +               goto sw_init;
>> +       /* VCN DEC TRAP */
>> +       r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>> +                       VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[inst].irq);
>> +       if (r)
>> +               return r;
>>
>> -               /* VCN POISON TRAP */
>> -               r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>> -                       VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].ras_poison_irq);
>> +       /* VCN ENC TRAP */
>> +       for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>> +               r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>> +                       i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
>>                  if (r)
>>                          return r;
>>          }
>>
>> +       /* VCN POISON TRAP */
>> +       r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>> +               VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[inst].ras_poison_irq);
>> +       if (r)
>> +               return r;
>> +sw_init:
>>          r = amdgpu_vcn_sw_init(adev);
> I think the amdgpu_vcn_* helpers will need to be updated to handle
> instances as well.  Otherwise we'll end up leaking a bunch of memory
> when these gets called for each instance.  While you are at it, we
> should move all of the per instance state from struct amdgpu_vcn to
> struct amdgpu_vcn_inst.
>
> Alex
- All amdgpu_vcn helpers are now handled the given instance.
See new patch set (patch 20/32 to 26/32)

- All per instance variable are now moved to amdgpu_vcn_inst
See new patch set (patch 10/32)

Thanks
Boyuan
>
>>          if (r)
>>                  return r;
>> @@ -197,76 +196,74 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>>          if (r)
>>                  return r;
>>
>> -       for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>> -               volatile struct amdgpu_fw_shared *fw_shared;
>> +       volatile struct amdgpu_fw_shared *fw_shared;
>>
>> -               if (adev->vcn.harvest_config & (1 << j))
>> -                       continue;
>> -               adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>> -               adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>> -               adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>> -               adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>> -               adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>> -               adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>> -
>> -               adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>> -               adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN, j, mmUVD_SCRATCH9);
>> -               adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>> -               adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA0);
>> -               adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>> -               adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA1);
>> -               adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>> -               adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_CMD);
>> -               adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>> -               adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j, mmUVD_NO_OP);
>> -
>> -               ring = &adev->vcn.inst[j].ring_dec;
>> +       if (adev->vcn.harvest_config & (1 << inst))
>> +               goto done;
>> +       adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>> +       adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>> +       adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>> +       adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>> +       adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>> +       adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>> +
>> +       adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>> +       adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN, inst, mmUVD_SCRATCH9);
>> +       adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>> +       adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA0);
>> +       adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>> +       adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA1);
>> +       adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>> +       adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_CMD);
>> +       adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>> +       adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst, mmUVD_NO_OP);
>> +
>> +       ring = &adev->vcn.inst[inst].ring_dec;
>> +       ring->use_doorbell = true;
>> +
>> +       ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>> +                       (amdgpu_sriov_vf(adev) ? 2*inst : 8*inst);
>> +
>> +       if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
>> +               ring->vm_hub = AMDGPU_MMHUB1(0);
>> +       else
>> +               ring->vm_hub = AMDGPU_MMHUB0(0);
>> +
>> +       sprintf(ring->name, "vcn_dec_%d", inst);
>> +       r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq,
>> +                                0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +       if (r)
>> +               return r;
>> +
>> +       for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>> +               enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
>> +
>> +               ring = &adev->vcn.inst[inst].ring_enc[i];
>>                  ring->use_doorbell = true;
>>
>>                  ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>> -                               (amdgpu_sriov_vf(adev) ? 2*j : 8*j);
>> +                               (amdgpu_sriov_vf(adev) ? (1 + i + 2*inst) : (2 + i + 8*inst));
>>
>> -               if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
>> +               if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>> +                       IP_VERSION(2, 5, 0))
>>                          ring->vm_hub = AMDGPU_MMHUB1(0);
>>                  else
>>                          ring->vm_hub = AMDGPU_MMHUB0(0);
>>
>> -               sprintf(ring->name, "vcn_dec_%d", j);
>> -               r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
>> -                                    0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +               sprintf(ring->name, "vcn_enc_%d.%d", inst, i);
>> +               r = amdgpu_ring_init(adev, ring, 512,
>> +                                        &adev->vcn.inst[inst].irq, 0,
>> +                                        hw_prio, NULL);
>>                  if (r)
>>                          return r;
>> -
>> -               for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>> -                       enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
>> -
>> -                       ring = &adev->vcn.inst[j].ring_enc[i];
>> -                       ring->use_doorbell = true;
>> -
>> -                       ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>> -                                       (amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));
>> -
>> -                       if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>> -                           IP_VERSION(2, 5, 0))
>> -                               ring->vm_hub = AMDGPU_MMHUB1(0);
>> -                       else
>> -                               ring->vm_hub = AMDGPU_MMHUB0(0);
>> -
>> -                       sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>> -                       r = amdgpu_ring_init(adev, ring, 512,
>> -                                            &adev->vcn.inst[j].irq, 0,
>> -                                            hw_prio, NULL);
>> -                       if (r)
>> -                               return r;
>> -               }
>> -
>> -               fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
>> -               fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>> -
>> -               if (amdgpu_vcnfw_log)
>> -                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>>          }
>>
>> +       fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
>> +       fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>> +
>> +       if (amdgpu_vcnfw_log)
>> +               amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>> +done:
>>          if (amdgpu_sriov_vf(adev)) {
>>                  r = amdgpu_virt_alloc_mm_table(adev);
>>                  if (r)
>> @@ -1005,197 +1002,192 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>>          return 0;
>>   }
>>
>> -static int vcn_v2_5_start(struct amdgpu_device *adev)
>> +static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int inst)
>>   {
>>          struct amdgpu_ring *ring;
>>          uint32_t rb_bufsz, tmp;
>> -       int i, j, k, r;
>> +       int j, k, r;
>>
>> -       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -               if (adev->pm.dpm_enabled)
>> -                       amdgpu_dpm_enable_vcn(adev, true, i);
>> -       }
>> -
>> -       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -               if (adev->vcn.harvest_config & (1 << i))
>> -                       continue;
>> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>> -                       r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
>> -                       continue;
>> -               }
>> +       if (adev->pm.dpm_enabled)
>> +               amdgpu_dpm_enable_vcn(adev, true, inst);
>>
>> -               /* disable register anti-hang mechanism */
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
>> -                       ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>> +       if (adev->vcn.harvest_config & (1 << inst))
>> +               return 0;
>>
>> -               /* set uvd status busy */
>> -               tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>> -               WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
>> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>> +               r = vcn_v2_5_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
>> +               return r;
>>          }
>>
>> +       /* disable register anti-hang mechanism */
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS), 0,
>> +               ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>> +
>> +       /* set uvd status busy */
>> +       tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>> +       WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
>> +
>>          if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>>                  return 0;
>>
>>          /*SW clock gating */
>>          vcn_v2_5_disable_clock_gating(adev);
>>
>> -       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -               if (adev->vcn.harvest_config & (1 << i))
>> -                       continue;
>> -               /* enable VCPU clock */
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>> -                       UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>> -
>> -               /* disable master interrupt */
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
>> -                       ~UVD_MASTINT_EN__VCPU_EN_MASK);
>> -
>> -               /* setup mmUVD_LMI_CTRL */
>> -               tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
>> -               tmp &= ~0xff;
>> -               WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
>> -                       UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
>> -                       UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>> -                       UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>> -                       UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>> -
>> -               /* setup mmUVD_MPC_CNTL */
>> -               tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
>> -               tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>> -               tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>> -               WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
>> -
>> -               /* setup UVD_MPC_SET_MUXA0 */
>> -               WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
>> -                       ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>> -                       (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>> -                       (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>> -                       (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>> -
>> -               /* setup UVD_MPC_SET_MUXB0 */
>> -               WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
>> -                       ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>> -                       (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>> -                       (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>> -                       (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>> -
>> -               /* setup mmUVD_MPC_SET_MUX */
>> -               WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
>> -                       ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>> -                       (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>> -                       (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>> -       }
>> +       if (adev->vcn.harvest_config & (1 << inst))
>> +               return 0;
>> +
>> +       /* enable VCPU clock */
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>> +               UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>> +
>> +       /* disable master interrupt */
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
>> +               ~UVD_MASTINT_EN__VCPU_EN_MASK);
>> +
>> +       /* setup mmUVD_LMI_CTRL */
>> +       tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
>> +       tmp &= ~0xff;
>> +       WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp | 0x8|
>> +               UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
>> +               UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>> +               UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>> +               UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>> +
>> +       /* setup mmUVD_MPC_CNTL */
>> +       tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
>> +       tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>> +       tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>> +       WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
>> +
>> +       /* setup UVD_MPC_SET_MUXA0 */
>> +       WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
>> +               ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>> +               (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>> +               (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>> +               (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>> +
>> +       /* setup UVD_MPC_SET_MUXB0 */
>> +       WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
>> +               ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>> +               (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>> +               (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>> +               (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>> +
>> +       /* setup mmUVD_MPC_SET_MUX */
>> +       WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
>> +               ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>> +               (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>> +               (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>>
>>          vcn_v2_5_mc_resume(adev);
>>
>> -       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -               volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>> -               if (adev->vcn.harvest_config & (1 << i))
>> -                       continue;
>> -               /* VCN global tiling registers */
>> -               WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>> -                       adev->gfx.config.gb_addr_config);
>> -               WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>> -                       adev->gfx.config.gb_addr_config);
>> +       volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
>> +       if (adev->vcn.harvest_config & (1 << inst))
>> +               return 0;
>> +
>> +       /* VCN global tiling registers */
>> +       WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>> +               adev->gfx.config.gb_addr_config);
>> +       WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>> +               adev->gfx.config.gb_addr_config);
>>
>> -               /* enable LMI MC and UMC channels */
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
>> -                       ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>> +       /* enable LMI MC and UMC channels */
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
>> +               ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>>
>> -               /* unblock VCPU register access */
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
>> -                       ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>> +       /* unblock VCPU register access */
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
>> +               ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>> -                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>> +               ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>
>> -               for (k = 0; k < 10; ++k) {
>> -                       uint32_t status;
>> -
>> -                       for (j = 0; j < 100; ++j) {
>> -                               status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
>> -                               if (status & 2)
>> -                                       break;
>> -                               if (amdgpu_emu_mode == 1)
>> -                                       msleep(500);
>> -                               else
>> -                                       mdelay(10);
>> -                       }
>> -                       r = 0;
>> +       for (k = 0; k < 10; ++k) {
>> +               uint32_t status;
>> +
>> +               for (j = 0; j < 100; ++j) {
>> +                       status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
>>                          if (status & 2)
>>                                  break;
>> +                       if (amdgpu_emu_mode == 1)
>> +                               msleep(500);
>> +                       else
>> +                               mdelay(10);
>> +               }
>> +               r = 0;
>> +               if (status & 2)
>> +                       break;
>>
>> -                       DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
>> -                       WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>> -                               UVD_VCPU_CNTL__BLK_RST_MASK,
>> -                               ~UVD_VCPU_CNTL__BLK_RST_MASK);
>> -                       mdelay(10);
>> -                       WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>> -                               ~UVD_VCPU_CNTL__BLK_RST_MASK);
>> +               DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
>> +               WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>> +                       UVD_VCPU_CNTL__BLK_RST_MASK,
>> +                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
>> +               mdelay(10);
>> +               WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>> +                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>
>> -                       mdelay(10);
>> -                       r = -1;
>> -               }
>> +               mdelay(10);
>> +               r = -1;
>> +       }
>>
>> -               if (r) {
>> -                       DRM_ERROR("VCN decode not responding, giving up!!!\n");
>> -                       return r;
>> -               }
>> +       if (r) {
>> +               DRM_ERROR("VCN decode not responding, giving up!!!\n");
>> +               return r;
>> +       }
>>
>> -               /* enable master interrupt */
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
>> -                       UVD_MASTINT_EN__VCPU_EN_MASK,
>> -                       ~UVD_MASTINT_EN__VCPU_EN_MASK);
>> +       /* enable master interrupt */
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
>> +               UVD_MASTINT_EN__VCPU_EN_MASK,
>> +               ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>
>> -               /* clear the busy bit of VCN_STATUS */
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
>> -                       ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>> +       /* clear the busy bit of VCN_STATUS */
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
>> +               ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>>
>> -               WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
>> +       WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
>>
>> -               ring = &adev->vcn.inst[i].ring_dec;
>> -               /* force RBC into idle state */
>> -               rb_bufsz = order_base_2(ring->ring_size);
>> -               tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
>> -               tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>> -               tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
>> -               tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
>> -               tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>> -               WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>> +       ring = &adev->vcn.inst[inst].ring_dec;
>> +       /* force RBC into idle state */
>> +       rb_bufsz = order_base_2(ring->ring_size);
>> +       tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
>> +       tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>> +       tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
>> +       tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
>> +       tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>> +       WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
>>
>> -               fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
>> -               /* program the RB_BASE for ring buffer */
>> -               WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>> -                       lower_32_bits(ring->gpu_addr));
>> -               WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>> -                       upper_32_bits(ring->gpu_addr));
>> +       fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
>> +       /* program the RB_BASE for ring buffer */
>> +       WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>> +               lower_32_bits(ring->gpu_addr));
>> +       WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>> +               upper_32_bits(ring->gpu_addr));
>>
>> -               /* Initialize the ring buffer's read and write pointers */
>> -               WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
>> +       /* Initialize the ring buffer's read and write pointers */
>> +       WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
>>
>> -               ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
>> -               WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
>> -                               lower_32_bits(ring->wptr));
>> -               fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>> +       ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
>> +       WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
>> +                       lower_32_bits(ring->wptr));
>> +       fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>>
>> -               fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
>> -               ring = &adev->vcn.inst[i].ring_enc[0];
>> -               WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>> -               WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>> -               WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
>> -               WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
>> -               WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
>> -               fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
>> -
>> -               fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
>> -               ring = &adev->vcn.inst[i].ring_enc[1];
>> -               WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>> -               WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
>> -               WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>> -               WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
>> -               WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
>> -               fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>> -       }
>> +       fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
>> +       ring = &adev->vcn.inst[inst].ring_enc[0];
>> +       WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>> +       WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>> +       WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
>> +       WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
>> +       WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
>> +       fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
>> +
>> +       fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
>> +       ring = &adev->vcn.inst[inst].ring_enc[1];
>> +       WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>> +       WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
>> +       WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>> +       WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
>> +       WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
>> +       fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>>
>>          return 0;
>>   }
>> @@ -1424,72 +1416,69 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>>          return 0;
>>   }
>>
>> -static int vcn_v2_5_stop(struct amdgpu_device *adev)
>> +static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int inst)
>>   {
>>          uint32_t tmp;
>> -       int i, r = 0;
>> +       int r = 0;
>>
>> -       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -               if (adev->vcn.harvest_config & (1 << i))
>> -                       continue;
>> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>> -                       r = vcn_v2_5_stop_dpg_mode(adev, i);
>> -                       continue;
>> -               }
>> +       if (adev->vcn.harvest_config & (1 << inst))
>> +               goto done;
>>
>> -               /* wait for vcn idle */
>> -               r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
>> -               if (r)
>> -                       return r;
>> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>> +               r = vcn_v2_5_stop_dpg_mode(adev, inst);
>> +               goto done;
>> +       }
>>
>> -               tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>> -                       UVD_LMI_STATUS__READ_CLEAN_MASK |
>> -                       UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>> -                       UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>> -               r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>> -               if (r)
>> -                       return r;
>> +       /* wait for vcn idle */
>> +       r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
>> +       if (r)
>> +               return r;
>>
>> -               /* block LMI UMC channel */
>> -               tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
>> -               tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>> -               WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
>> +       tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>> +               UVD_LMI_STATUS__READ_CLEAN_MASK |
>> +               UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>> +               UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>> +       r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
>> +       if (r)
>> +               return r;
>>
>> -               tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>> -                       UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>> -               r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>> -               if (r)
>> -                       return r;
>> +       /* block LMI UMC channel */
>> +       tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
>> +       tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>> +       WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
>>
>> -               /* block VCPU register access */
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
>> -                       UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>> -                       ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>> +       tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>> +               UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>> +       r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
>> +       if (r)
>> +               return r;
>>
>> -               /* reset VCPU */
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>> -                       UVD_VCPU_CNTL__BLK_RST_MASK,
>> -                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
>> +       /* block VCPU register access */
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
>> +               UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>> +               ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>
>> -               /* disable VCPU clock */
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>> -                       ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>> +       /* reset VCPU */
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>> +               UVD_VCPU_CNTL__BLK_RST_MASK,
>> +               ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>
>> -               /* clear status */
>> -               WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>> +       /* disable VCPU clock */
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>> +               ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>>
>> -               vcn_v2_5_enable_clock_gating(adev);
>> +       /* clear status */
>> +       WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
>>
>> -               /* enable register anti-hang mechanism */
>> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
>> -                       UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>> -                       ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>> -       }
>> +       vcn_v2_5_enable_clock_gating(adev);
>>
>> -       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> -               if (adev->pm.dpm_enabled)
>> -                       amdgpu_dpm_enable_vcn(adev, false, i);
>> -       }
>> +       /* enable register anti-hang mechanism */
>> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
>> +               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>> +               ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>> +done:
>> +       if (adev->pm.dpm_enabled)
>> +               amdgpu_dpm_enable_vcn(adev, false, inst);
>>
>>          return 0;
>>   }
>> @@ -1838,9 +1827,9 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>                  return 0;
>>
>>          if (state == AMD_PG_STATE_GATE)
>> -               ret = vcn_v2_5_stop(adev);
>> +               ret = vcn_v2_5_stop(adev, inst);
>>          else
>> -               ret = vcn_v2_5_start(adev);
>> +               ret = vcn_v2_5_start(adev, inst);
>>
>>          if (!ret)
>>                  adev->vcn.cur_state[inst] = state;
>> --
>> 2.34.1
>>
