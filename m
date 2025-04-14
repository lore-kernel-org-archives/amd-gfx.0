Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27063C369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7ACE10E08E;
	Mon, 14 Apr 2025 17:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gHESJbZV";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F34410E08E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzaHBi7iM3vHONGr5G9y/CL0OJVGqzm+1sLNcvWgAz/k8kjGelw3Np1WvwJcDdSLP2ql5RZR7DjNyPG/ZqPkaTZwPeVmNg8JG7iN7XWE8QMidn+cK1ZzsYvD94aYd4lFoxEVE0dL5mcLsA7RTCnthjNQZ2l0M0jwSzSD5DTDMtGvLGtiX5UHFPI1+kqu3oSn+QvNoGw349+6n8wqwC/MKX5FKgWdm2wGeS5ow5SPmdmiek5VttnSU0mBWY41ti7VyYg1qjaLkZg3o2rVCK4DoAJ8/auodsDhd9M+5TcnsVkPnzUYENYhmlCJcDTdgAacS/stOnPB1ymPCPNEEtUzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9DQ2h0Ovo1K8zSegxc4n4Vmfu6Bb8OX8IzIktVRphw=;
 b=fhuMHVS2Q99E4wVFQMWBJBhDD9jwDvBjXQZIp6lxKX4A24/suQJWAUCV2IiIDF401UphxXY6KPQ7nI2qs0nFm+ig/AfoFdkA6GXgL87lOfCUsdHHco6klyZAwdMXlpGwy0j06u/nKWZBGV8onB2zGJDg90m1DxQUVl/FrqS4G7u2ZZvGbq465e1tc+JuKzm5N9XiiK3ghnN19BQsvBloahbqZ5JGddGhB784TEdHTvWk/tL1g3PLeHVO9xV0HZ4gTdKUkwnVmL4OTKYOmAg0n1Lzcx6htEDxDMpqzrCdklbb45O2KiNKCcge7dS6CcrhCE5TKC9uonLzQDkeKHEhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9DQ2h0Ovo1K8zSegxc4n4Vmfu6Bb8OX8IzIktVRphw=;
 b=gHESJbZV0LB6/U07YRvHMnMGcUcAY+uhMskhxd5xvOFxEAgDjQ7kbcn8xIxzH0VO2cnZin3QgStrHZrSZ/b5k9tUQkpMhSl01MD+1iHtpLT9B38+LKDq9G+WvJs9HAzpHR96Uurs/+Uz1qLZynD2DTa3oSkKr3+Ew4H0lNGCKrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 17:35:24 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 17:35:24 +0000
Message-ID: <7f72642e-7a04-487d-9b12-34645917d0d5@amd.com>
Date: Mon, 14 Apr 2025 23:05:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/sdma6: properly reference trap interrupts for
 userqs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
 <20250413160608.2198429-3-alexander.deucher@amd.com>
 <36ea9a52-9a39-484a-8100-bde07d320db2@amd.com>
 <CADnq5_N4GxmP+79H+PRSeckEy+_YRKiOf+dUaWVK56rc00Y5pQ@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_N4GxmP+79H+PRSeckEy+_YRKiOf+dUaWVK56rc00Y5pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0044.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::14) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f79af73-db2d-4995-5537-08dd7b7abcab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGhzc3l5ck9hbDY0U05MQ216bWc1T01oNm4wVTBaRG1FR0djdXhITGdKTHY4?=
 =?utf-8?B?VkRmYjVUSitzOUZKZDFKNVorRTZkOWR2VGoyNzFJYXRhQkdVdjl2R3NWU3Zq?=
 =?utf-8?B?dys0UTBBSmdOd2h0ampUTVlyTllORGxramw2LzFRZit6dTl1YVhIbTdGdkNK?=
 =?utf-8?B?bkludTF5dVpkdXcwRmJjTTJHdFZEOXJRV0F4VXZYek9pM2lOMjFRNzJoNm5k?=
 =?utf-8?B?UENoOHcxOFlaczFES0VadGtuTmN0VGtPbi9pWEZZUUVnZHJFUzFMbjR3V0ZL?=
 =?utf-8?B?T0dHcUkyK0FZem9tck9DcG1NMStaWXJyZXJlYWZBeTNqbzAvU2Mwb0tLNHo5?=
 =?utf-8?B?VE9aZHRrVGtzZlRDdUhoSmdiNi94WENPa1ZEczREbWFMRDNsdVUyd3dtYTFI?=
 =?utf-8?B?SnVxRHQ2R29TbEVHOVYrQkhPSHArSEgzUFpHWmE2L3AyVFN0MXlZV01CUk1k?=
 =?utf-8?B?bnRiUno2WEZWdTRaNU5Nak1SeWpuR0hIZUIvbGFBWUJxSE9FL0VJQkRwSmVY?=
 =?utf-8?B?R0ZPSHAyNW85UFdqR0lvYWhOMGc4TkppZzB6MTJNV1B3eVcxMTVpc3J2Ynla?=
 =?utf-8?B?SDNBY1hBVXZML3R5Z3UyaXVNYzJVMVRaaVRIVHZjaENBa2NpTXlIck1Ia3Jw?=
 =?utf-8?B?cXNFZ1dpY2YxbkExaDNRaHZHU0VtWTBvem16RFJrY1JJdTJWUUxvTWhkR1VB?=
 =?utf-8?B?TFlwemJ3OGkrcmFEdlZ2ZHpjZFV2M0c2ZUxudGpxT1VFTXVIVWhyZVFEOExu?=
 =?utf-8?B?V0VxYk52ZWExUVo1MHdmaGZEQjRnVlV3aFhoWTE1cWRTbUx1N3RIQ0hwa0Yy?=
 =?utf-8?B?MVBwalNvSWNISnUrMzk3dWJUNCtHV1J6eDJxR1B1VENPWWE1eXlBVUZicjNQ?=
 =?utf-8?B?bk8yVXg3SkNISTN2V3NRdHRESEZkV1BuVzM3LzdOR3lpdFc1Q1A2eGt5RTVZ?=
 =?utf-8?B?VzNjQkNDakQrTzNkWmN0MjRxZkNObmE4YTczdENBU1JBTldvcWw5NjRzN1M4?=
 =?utf-8?B?YndrNFBpdnRZSnhIYW9sVE4vaUh5WEhVREZSZHV0aEZUdUFDWktOQjNJR2Ex?=
 =?utf-8?B?NTFtSHkwcUFtZGdBK1ZrNEQ5MTdSZTZsRGVLKytPUlNrZDhHL0VPdXBkZlgx?=
 =?utf-8?B?dENNSkNma0dNdjNzSWlpR0ZSVU92eDQ1MC81TVMvaWtJWGhmQ0QyK2FYV1Iv?=
 =?utf-8?B?VEYrazdhcS9UZlFzaVMxS1p1c3VRVmduTlFzUzRKVE1tRlRNT2RuQW5YMFBS?=
 =?utf-8?B?eG9yVVFmZVZDQVZ5Vll3c1VZa0llMG5aN0ZXY0RESjJjMUZpNVBSanZiLzNz?=
 =?utf-8?B?WHFuOGRvQ09XT0tlTHVBeWkxVk1lVldtQTBMSzQ5SzFCZUREbTE4blNCT0Rt?=
 =?utf-8?B?S0tsMHNkNHJSSzlPWk9ncDlZUkF0N0pkYUVZUjBzZ2VpWElaK2cvZzV0cWpC?=
 =?utf-8?B?Qk5mRXZGVjZ6cWhXdVFkWkdyK2pwRnEwdTNGcXFjMlFpdmdZSzdPZXlNemJx?=
 =?utf-8?B?b3NjL0JQTTJJbElidkEyTmJhdUs5aXBuMUcwbHBuUjBLbHRwOWVHRUVrc2dj?=
 =?utf-8?B?d05CY00zMmZTZmNRb3BpWU9PS0IvMGdyQnAxZFA2aWFXTTBkeEtWNDZiVUF1?=
 =?utf-8?B?UEZ5REpISms2R0Q1UXE1RjlzZkllclQrbW04d2ZVT1ZKRkFLc1Y2ZjR5ZWI3?=
 =?utf-8?B?UVpTQzhIcmx1RERrSmtsQXJEN1dQd0ZQaHIvZ1F2Mis1aGlXSzgzcFRMaUhn?=
 =?utf-8?B?R2krK3pjelJLTitSY3hxVEgvZXVPQ0VjYUZaVnlsdk9oNlhRTXFxbUJVdVNa?=
 =?utf-8?B?eUlhRllQNGRmVnVqMVBCRmhEN2lKQTNWVi9JSWNydGw1NnVFdEpVNjlwUmdK?=
 =?utf-8?B?b2w0Mm94MFJ0K2hPVkpYSFl5KzZkd2tQSHZNbU04U1Q0K3F6N2ovZ051TWk5?=
 =?utf-8?Q?RQQoAKloftE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWF6Mk1uSFcrTm11OUxKcTJDelFDd2JnZzFMSEt1R3cyVzJIcWE4SnVUUWkv?=
 =?utf-8?B?V2diUDZuMjJDQ0NiMkkwOHc2dlROaVM3K0FwNTlDK1M4Z0o5VjViVFN4L3c4?=
 =?utf-8?B?UnhmMExqU0kzMXJGVld4S0NEbnIyU0Y2bndMdkxYNHlNaytRbHFKOVR6RGlU?=
 =?utf-8?B?T0ZrZW5LdiswUzdibXNySlB5YUZkaFY3RmQ0bkkxRllFUXV4SDFKdzdvYnZo?=
 =?utf-8?B?UCtZRGh6ZkZid1Bsa1JYeTBvb0tXWWNNbnd3VVVGUWdXb0lsS2swdnRLdEdC?=
 =?utf-8?B?ZURxQXFYejYxUkIybWtGeWxEVlJiMDRLU0h4eUVpUnczS1FFLzk4UUNkSlhE?=
 =?utf-8?B?ajl1Um04SFNFVElHc2xpN3oxMkxXOGZMNHo1TWt4VWZ3dWNCTUpzaUYrZENz?=
 =?utf-8?B?eldlZ05WcUF1eFJkTkdTbFNWQkZLRUVXRjQrbFFxWXptV2ltT2lETEZqM0Rt?=
 =?utf-8?B?MEowd1R5dHE1aFowbXdrcVFPbjdLbmF6ZWZXeCtCdE9rdWZYemFhREZYT2hJ?=
 =?utf-8?B?UmtKMWNFVHFFSk10QjBLdWxIN0pqQlQ4WkNMeFZSb1VqdnB0QUhtUUJPdEll?=
 =?utf-8?B?cnNHTlJBZVpFN3Y5NGtURU1VbGFXSm5uemVzNHdZRnRIQjV2UjUvYjdSR3Qw?=
 =?utf-8?B?MEpWUjJoMGM3Vmw4YmpFSjl0b2tIWGJySnVleUhqZlJZZXVHNFl5VDZmMm1R?=
 =?utf-8?B?dUd1UjUrRDRKRDNvMy9DM29GREVpeTBLL29vWldkaHAvQUhWTFVMY2JiWnly?=
 =?utf-8?B?Q1hLZlBDdERFOHI5dm15L25RekVkZHVHbmQ3LzB6MTU0aUtObVkwMkIxOGRr?=
 =?utf-8?B?azBqUkduaTZiN2RXR3ZkTXZsS3pVQU1kZlZqMWZsWUoxV3ZFUkhjd2RYaXh6?=
 =?utf-8?B?YzlaVE9DZ2M2alhENzZIZzBhVXBoRFpGaExpVUFnMWRVNHA4ekhmc2F0NXZ0?=
 =?utf-8?B?ODNLWXE1Ry9pZGdlSWVVYnlvUnkrTTMyWWdrVi9iSUVPQ0lXcFduOExKNXdL?=
 =?utf-8?B?em40M3JYQW8vQmR0ekxWVGNSOGRCNUtpcWVWaEczc0xVdFlrakNyQkpCUkJM?=
 =?utf-8?B?Mkxob0dXdDJWZUpYbHdObzNtVytYZnQ3UWV4MEUzZnlYL3FUY2dlRlU1dlRK?=
 =?utf-8?B?cm1KS3Q0OTJKbnA4NW9XKytwNk9GRlRwNTJYR0VrU3NPTlpsOEVydFNSQ3hL?=
 =?utf-8?B?bEEwZXRmelR3UGJSSHB3cG05RjJ2VXFHUkJkVmwyS0ZWRFJuY3VNb3hiT1pj?=
 =?utf-8?B?THVyOG9VdFBSUEpsZlNlck9ZRFdCY2ZwOHVZTURIU1RWNkp0YysxbCtNeG9z?=
 =?utf-8?B?a1pXd3ZFY2t6MGRzRzhRMWhBaHFNWjB0UVhKU3l3blhsMm4rb0Q4QVZWOUhI?=
 =?utf-8?B?M1huZUYrTURmVlpFWFNNMGtVQ1I0dzU5WTJaRys1SnZBd0I0NFg5WTRHa0N6?=
 =?utf-8?B?b2QyWVd1cjNpVGsxY01GM2hwQWVuN0I4L2RORU41S3YweXNmalk5eVY4TnND?=
 =?utf-8?B?Umpab3VhcWh1VTZGWm54dUZHMFRpRG51Tmtyd2UzQVJTMnF0R3NxY2Fxc0dM?=
 =?utf-8?B?dkN4cGYzWDR0SUpEbFRCN3F2QWxJbldjQ0pWWkI3Q2VDOGhnNmFwOVJ4dzFm?=
 =?utf-8?B?RWwwMCtiV3VnSnY3YldRaUhGMEIzRE8ycmd2eE9iOXFvNXVRVW40MEc3NlRX?=
 =?utf-8?B?NWc1eFhiakxtQXJlL2krcVpCenhjYzluUHE4bVJ5VVgvRFE0RVBTekQrYnJv?=
 =?utf-8?B?RXhGRGVtZVVsWFVZbWtHa3JXa3lpa283LzBvOTJnOEhycnhPYnltcnFUYzdu?=
 =?utf-8?B?cTg4c0dHaXZlUk5jVWwyZXlDMStwVXhyQ0twTFRDZDhXczhSVmphZ0VVWlRW?=
 =?utf-8?B?SWFNbCswcG1qckVibnRVZjdBZHVSWlJvSUFPQkF5blFMRjlFWlRKUXgvTHpY?=
 =?utf-8?B?OXNFeUtkTndtVm16WnExdnpZWlNUY3BpOFVLM005b3FZa2dPdVdxVFgyWDNs?=
 =?utf-8?B?dys1NmFjR0NjNXdYVnZmaDBlcHdQTG5VOEVRRlNlTytITFBlY2pzU0ZIZ09U?=
 =?utf-8?B?am1NdlZwcmZJYlhkcWliaTlIM2Ryd0wrdXFmSVVaUnBKL09lMGVad1dldENX?=
 =?utf-8?Q?3aSGu2lCAvECfOwqSoe23SFeT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f79af73-db2d-4995-5537-08dd7b7abcab
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:35:24.0910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdI+12/+UA5rugJ0AvrzTfHxFv4+2BAsc6LLov5RC06p8AD46GLKe7Vrjq9rIvRufR7OHrlp71BfJ0GtfWNWaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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


On 4/14/2025 9:02 PM, Alex Deucher wrote:
> On Mon, Apr 14, 2025 at 5:59 AM Khatri, Sunil <sukhatri@amd.com> wrote:
>> Same explanation as patch 1 of the series here too. Do we want to depend
>> on the disable_kq flag solely to enable/disable sdma trap.
>> IIUC, we dont want to do it in case of kernel queues at all and only
>> needed when using userqueue and that is taken care by using the flag
>> disable_kq.
> I think doing it this way makes the most sense because you are using
> the presence of user queues to determine whether or not to take the
> extra references.  We don't really care what the status of kernel
> queues are.
With the understanding from patch 1. Reviewed-by: Sunil Khatri 
<sunil.khatri@amd.com>

Regards
Sunil Khatri
> Alex
>
>> Regards
>> Sunil Khatri
>>
>> On 4/13/2025 9:36 PM, Alex Deucher wrote:
>>> We need to take a reference to the interrupts to make
>>> sure they stay enabled even if the kernel queues have
>>> disabled them.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 31 +++++++++++++++++++++++++-
>>>    1 file changed, 30 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> index 2249a1ef057bf..c3d53974e7f53 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> @@ -1377,11 +1377,39 @@ static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>>        return 0;
>>>    }
>>>
>>> +static int sdma_v6_0_set_userq_trap_interrupts(struct amdgpu_device *adev,
>>> +                                            bool enable)
>>> +{
>>> +     unsigned int irq_type;
>>> +     int i, r;
>>> +
>>> +     if (adev->userq_funcs[AMDGPU_HW_IP_DMA]) {
>>> +             for (i = 0; i < adev->sdma.num_instances; i++) {
>>> +                     irq_type = AMDGPU_SDMA_IRQ_INSTANCE0 + i;
>>> +                     if (enable)
>>> +                             r = amdgpu_irq_get(adev, &adev->sdma.trap_irq,
>>> +                                                irq_type);
>>> +                     else
>>> +                             r = amdgpu_irq_put(adev, &adev->sdma.trap_irq,
>>> +                                                irq_type);
>>> +                     if (r)
>>> +                             return r;
>>> +             }
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>    static int sdma_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
>>>    {
>>>        struct amdgpu_device *adev = ip_block->adev;
>>> +     int r;
>>>
>>> -     return sdma_v6_0_start(adev);
>>> +     r = sdma_v6_0_start(adev);
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     return sdma_v6_0_set_userq_trap_interrupts(adev, true);
>>>    }
>>>
>>>    static int sdma_v6_0_hw_fini(struct amdgpu_ip_block *ip_block)
>>> @@ -1393,6 +1421,7 @@ static int sdma_v6_0_hw_fini(struct amdgpu_ip_block *ip_block)
>>>
>>>        sdma_v6_0_ctxempty_int_enable(adev, false);
>>>        sdma_v6_0_enable(adev, false);
>>> +     sdma_v6_0_set_userq_trap_interrupts(adev, false);
>>>
>>>        return 0;
>>>    }
