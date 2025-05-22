Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDCAC54ED1
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 22:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD0410E10D;
	Thu, 22 May 2025 22:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e1n9cgaU";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFE610E10D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 22:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut47plrB4YqMhFUFC7dvALgj077mYGPdf2/btvmBcJS8ZgJP3VvGFRDziUm43BbNpd61c7avZ/QxR6ZnHmf3eobhMFl+1zMch3xxQsv4FoPHbhOgNyFuvKNwfi22nUFXoHVdcK98lznmyYyHOy5V7GLyXHhxZnpG+LD++wy0KzZriIgC8x2b7POj08ePi0UOCpk+nhI+iS3E/23nosHlMLZV5UL6PyLwN7VYlcit/1376gOzcaDrTh+HDugl7OfJ5qQKeSwOnISeDfyfHbNDExgE+MPPp1E/IrwtFSTp8F84dAWnCZK9uRp0nrOZ/OMT1lATWVC6nMbTcT1HKGlvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yft1xMb5oH4wNdNc9J6KzHsv9OdiGJyDqUFwQBlQxk=;
 b=KPZT/Sk6fY0ICIKxvP51sdceRlF7UvXQp+Q5X+spe+HdTZpwiU0/U8wBxMscAAkWAAw4DJ3QxAcNMB804lgc6prQos3YATmfDwNgmyqvcs+WTSL28duj1l+W/nr7sKdikTWUbXrWRyGnGQP9xtw9y5Pbs568GDTgjYkBKkFIxd+ujoRJmV8hgyoxRQioGY5/u/kkoEj7+6eOqyjym77S+mbiaHXQV2m6ShnHQWQYDhEagim2wVkhtqQaax8M5asjcgm7h7lXuMnQiNr+RrwaH5daUBIsDqq1qKGPDj6Z+kjTxEai5Gh5iW7y3OOMy+66Hnq+1rOXZBp0y+XFM0dbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yft1xMb5oH4wNdNc9J6KzHsv9OdiGJyDqUFwQBlQxk=;
 b=e1n9cgaUv8zTK3d5fyWvYxVgxJMB0fCAmWpW4xLg4+68nrFytRDOcvDQcu5dgXuLvS47GnJHhlCEY2bYMMlluUtvL8VPzK91rdOTlYQc+zgAGgwLrD3mf5snaXwrkYu2P2pRO70x4dRy9h9yl6A7DcCx5juXwuA5EVrl19DbsvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 22:27:13 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 22:27:13 +0000
Content-Type: multipart/alternative;
 boundary="------------ZP7JwmGO0lbTr7AqPzvCAj0j"
Message-ID: <93eec18b-b05f-403b-a6ea-c082efba44ec@amd.com>
Date: Thu, 22 May 2025 17:27:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: Should to return the evict error
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250521035654.17581-1-Emily.Deng@amd.com>
 <PH0PR12MB5417991052F0D5ABED1D99528F99A@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <PH0PR12MB5417991052F0D5ABED1D99528F99A@PH0PR12MB5417.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA0PR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:806:d1::13) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ec7e1c-8533-4d10-5751-08dd997fcc8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d29NNGQ0cU5jcjMwQ0F2bEJBRDV4QjVQZG5SVEhpMjdFMWZDK0VFQWFDSTNa?=
 =?utf-8?B?ams1S01kTlBBTHZGOHB5aEwxV2xtV2VMRnQ1MUFKOTNwRHZYWDhJK2Z4L0dF?=
 =?utf-8?B?SVZHMXhWTnUvNDJvby9pME0yZXp5Z0JuVXFSVkdFZ2lSUHUrNVNYZWZSUlVZ?=
 =?utf-8?B?MXBHOU9BT0VVRVBwdUQ1YWFCam1uNG80UmZuN2wwbjRkUGlYVzVGdUlocHp3?=
 =?utf-8?B?d3M3QnlOMGxiR01IREt6Y3hsN0R0OWtnQkhMemF2V2Y5cVQrd1BJN1ZtbXZn?=
 =?utf-8?B?K2dSS3lja0ZDODFWbjcveDJOTXpqaVQ2U0V0MmhRM1MweDVFL0J2TnBjL2xH?=
 =?utf-8?B?SkFxM0h2c01PZ0l0M1VPeFRBcW1YMVBubGM3bzQvNzh0SEU5aGM1VFBwVDQ2?=
 =?utf-8?B?WEVRUE9UeGU5M1RYeDRWazdtMXdXZFFoUTBWc25FUFFycU5DZlFNS20wL25W?=
 =?utf-8?B?cE03bGd5djRac2QrKzVPeDNHTE1hM2RuVUFQb0ZuUWVreVRWQUVTMXVRM1V3?=
 =?utf-8?B?WEZNdWNPOHJmRUpoV20zNmJBQkplRXgxaWFPRVRNOFRjV3VMdlNlVlpDUFcr?=
 =?utf-8?B?VW9QVUpwczlHak8wVHBGdnhVcWpUak9jSjFFM0VYTWJRaDU5QWsvR256dE9k?=
 =?utf-8?B?R0E1YjNEWG5NM3pZZ3ZMRi9tZStxWEZXVjJ3VGZYSXBiNUhCdXViZVM5OTV6?=
 =?utf-8?B?M2NOT2s5ZTdUWGVlWUdWZ0tIZHNlQW96eVhRWXlQTkc2WDJNMExWaUJGOHJz?=
 =?utf-8?B?YjZYQnkrRkpFZnV0c1d5WDZUY1R4b2tjTG9JckN3T1c2RzZJNGljcGdRTkhz?=
 =?utf-8?B?anJMSXhmTmNsbE5ERWRNYTJ1TnZyTGt4d1owM0p0VWFaTjZZUEx4VGhNaVVP?=
 =?utf-8?B?cFU4c1IxTTZSM09EZnlUMnJ6QUducWF3L3NMZmtGL1lWZXhaVnBtYWc5WHRD?=
 =?utf-8?B?RVROdkFnLzlTS1BzU2oveXAvRStCbEw3M1poUDNBdFFDNk9Sbk5oaGgwU1Bi?=
 =?utf-8?B?a2taTFlBb1VxSzErVVVZMnlnRG1PRVRMWHpUSnJ2Qkd4UUtZRU1ZMGdXckJP?=
 =?utf-8?B?NXl2eEdUaVp6UmlXdTZOUDBPRGxmY1JYR1JRL2RHdzJod3pxSk9yMFN5ZGsv?=
 =?utf-8?B?eWZWbmlYTDg5TkdWeUt4WW0rbGlmQWdDczVRVitLTnJnMVA1ejI4SmhBdC85?=
 =?utf-8?B?U3VrbzhMQU9mUkdSVzlMb2t1WlNqcjFxbEl1TkpicWxOZlJNOWRhUitlUUFH?=
 =?utf-8?B?ZzZuV3Nwemt5VWJlZE15VFgyUWZGQW0yTTh6MkdJalc1dy9LOEJrbFJiRjRl?=
 =?utf-8?B?N1o5Und3RVZxZURZZG1RdVZaY3hoWXV5WWhaWVZveE9YMWxnSU1Uelg3dHp1?=
 =?utf-8?B?dWpuK1BzZlp5YUtYamhQcnhhbTU3R0lwN3U2bFNKdXpDd09ER3pZWXh4RVJD?=
 =?utf-8?B?dDZVUVgxSEpjMlQ4aVc3RFBlN2l2SmpsZDFNSUE1YmVoVGZ5cVNzM0ZBcEtV?=
 =?utf-8?B?SVg5Yk4rN25DS2xzaDB2Z0xrUTQ3ZEpJQXY5ZTFCb0sySEJkWnM2TG5FTzdX?=
 =?utf-8?B?L1IzVEJOS3ZlZzM3eE5mVzhmNi92bmJUUmFWRDFwQkJoOXdYUHdONGFrcEQ5?=
 =?utf-8?B?cXVCMUJDWHUrWXdkWUNRMDlGTXNkdVQ2bTJ2eXdGcktCMUVHVDNvOVRxb2xr?=
 =?utf-8?B?WFF1QnE1Sit4NFNuVW4wMWVMYnJyam8rYlhoNGRFVWVURGk3akpsdThYZ1A4?=
 =?utf-8?B?TFhEMlAyaWMyYWpTYlk3SCtzWDhMYVR3OHhmM3E1UnRyeWsvQ3pmM2xCaDJP?=
 =?utf-8?B?Y0ZXKzI2UzFHcWlOQUMwZFBvMlZBMkNrelpjRlpRdTJPbm9aMTdVYnhGeEgx?=
 =?utf-8?B?alpaMDRtL29MQmZsdmI3OVZDSDAxcnEydjNqazlpR2FpRklUT09uNElKSnJu?=
 =?utf-8?Q?nCtXbOpfuhM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0F3TGt1cS9ramluRE13ek9Henc2L1k2RFdYNnBRc1J3elZrUUJlUFovNzlG?=
 =?utf-8?B?elVpK2xPKzh4OUl3TnBjRC9hYWlCeWRkdWhYbXpQenRLMjVwaE8yWWdmNTJY?=
 =?utf-8?B?d21BRDhrMEdOMFBsNnR0Y29vc1FkcHRaMFlyY2dxMmt6TnhEVmgvN1FyNXVL?=
 =?utf-8?B?bTRxT2M1VVhuVHdxWmlCcTR1WGhsYWgxY25jdTNRenQ0MWdqSWEvSW5WdGNL?=
 =?utf-8?B?YmlMLzREWkczeDZ4ZlBsR2tRWDJONmxZM0xTOEMrVGN4anJEdkZTazR2enA4?=
 =?utf-8?B?V1k3MEpONVkyYmo5WVVIcGoxNk16a1l2MndQd3haM1BWaW5JM1NoWkY5M3Np?=
 =?utf-8?B?clhPZEpDbXFlV1d4L0tpc3o2N1R1UWJWallSdTFrUlYvTjNFdWtMN21xNHl1?=
 =?utf-8?B?UnpMSGNFQ2JKZFJEQkloNTlrWUNIWGFib1BNT3pDWTd3QmZSclJKd2xYM3RD?=
 =?utf-8?B?V0hNVXQxaDVwRFJTZHhkcjNPdWJOZ2s1M1kzek52YlA2amVkWkl4aWdMRjlE?=
 =?utf-8?B?QkdIUGRqUDA3V0NtbG5vaTIrbFZuNXNpaERjbXI4RW5nNG43QlpaL2dmekNl?=
 =?utf-8?B?SXpHSUhZd2NMRE43ZWs4NzVqamNyZzlKOHJ6a2xtR2RsUE1CMGE0aWpqYzlv?=
 =?utf-8?B?VWpUcDBlQWR1MGxPdVd4M2V3MUJKTEFvMkEzWFBGMjMvUkYrRWl1V3IxYTBT?=
 =?utf-8?B?b2ZCcDg4WjZkMmJEUjBNT2I3eVA3Y3ZHTHJGRzAxcHoyb2x3RmZRUzlxYnBl?=
 =?utf-8?B?T29oN0twVTloV1hsZmprcTFyVmJHTWRRVC9HckNKLzhKWDBlN1B0L01rUGpX?=
 =?utf-8?B?MEpQeVl3cUhWUWp2OE9zcGdQcFBWRGVtbDFpc21zWnpMenNHSGUzZ2NtcmFZ?=
 =?utf-8?B?clZodjIvY2xlQmx6RUUwOXFxUkdlK2lYSnJTZngyeTdIbWU1T2Y1R244NGtP?=
 =?utf-8?B?SlFmcXQ1dDVYelNkL0J0WUF6NldZNTRNVldOQ2VpTFVSNHZWSHRpOWpQMnRV?=
 =?utf-8?B?Vm04eksyUmhjZWxScWN3UWRTOXZna0hkMGFjVjcyS0NhQ0tSK0tEWXlNMVlu?=
 =?utf-8?B?ZDIzU3NibUJIUy83eGR2L3QyMHpuOTZnZm5jcnhvd3htYUpuWHdWSmlIU2Ja?=
 =?utf-8?B?ckljSkdjTVlxOVNkNW51N0JvWS9vTUQ0S0RRYklEamVaRkM0RGp0ZVVIbnE2?=
 =?utf-8?B?QUVsekozbDdJdGNwcFF1eHRDazVHdm9tUXJaNUVFOWJHUmlIZjhLcmVvbkJZ?=
 =?utf-8?B?NTY3a2RmVXM3SlNZNVNVcnMwVVBoMkphOGtUMWl6R3BnMWVPNzlhdnJjM1lG?=
 =?utf-8?B?ZkpPUFR4WkE0S0E5K0dzc25uSm1IN2o1ek5sZXdRVzBmcGRNMmYybDM1YmVO?=
 =?utf-8?B?L2dvaGFnUEt5Vmw3eWZ5RVJnVTgwTjZDS3UzaURTYS9FRXJiR3VTcW9iSm91?=
 =?utf-8?B?UHVyeVhLdFY2c1NzTmQ3a0F5ekRjcW9saGRGN25DUnBuNFgxeU16Y1o0TkEw?=
 =?utf-8?B?RlR5UytvOXVEd0R1K0QwMGZHQUpCeUIvMWxiT3ZmQ3RGVlJzMjQzbitxQSt3?=
 =?utf-8?B?VmdpM2F3WXFIY0JNQzN4TmhselM4N0FCZEdPUHJNWTBqb20xMHl1MS9FaVhN?=
 =?utf-8?B?VUFFUU42MmdXN0tWMGdoQzgrUTgrajFkYUEwejdzQjNOb0hDTlI5cXF0M1Jt?=
 =?utf-8?B?a2thSzdUcitHRTVEb2tEQkdrVXRxNmV6aWY0eFgrWUxBd0lJTE15SHc2blZJ?=
 =?utf-8?B?YWdSRE9VMVZDRDNVTmt0eEUwaGlYaU5zY0ZQT2U5QWYyRTQ5UThGR0R1ZzNM?=
 =?utf-8?B?RXZLZnFkdFJoU0Foa2lpMElXN0hCQ2ZZanlwWmZuTk83bHhEUlJvNk1La1Zt?=
 =?utf-8?B?ZU9vRjJZQWhiVDgzK0dHTy9jVkpGVnMrZnJ3S0RVaVFSSExvOGdxTVZBREhj?=
 =?utf-8?B?ekF4VEk2M1RqUnVKc2NORTllUWprSkFMdnBZdDZwUDlXYmRzYnhvbExPcnh5?=
 =?utf-8?B?U0kzakRaNnJXWk93clZENkZHRHcySEJqOENVSTY0MGpqOThMbGVnVXkyQVNQ?=
 =?utf-8?B?UjU2VEl6RFFyNzUzWlpOMXkzWGdVYlFFa0JHTDk3YWZyNFo2Sk92QWh6d1hD?=
 =?utf-8?Q?vQkg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ec7e1c-8533-4d10-5751-08dd997fcc8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 22:27:13.1024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NifPNVeofd95kTv3LsyOqZjONCh2cP76RxdINMfTQdjtm2RduyENtPSdD0dmz5Oi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846
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

--------------ZP7JwmGO0lbTr7AqPzvCAj0j
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/2025 9:42 PM, Deng, Emily wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping......
>
> Emily Deng
> Best Wishes
>
>
>
>> -----Original Message-----
>> From: Emily Deng<Emily.Deng@amd.com>
>> Sent: Wednesday, May 21, 2025 11:57 AM
>> To:amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily<Emily.Deng@amd.com>
>> Subject: [PATCH v2] drm/ttm: Should to return the evict error
>>
>> For the evict fail case, the evict error should be returned.
>>
>> v2: Consider ENOENT case.
>>
>> Signed-off-by: Emily Deng<Emily.Deng@amd.com>
>> ---
>> drivers/gpu/drm/ttm/ttm_resource.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
>> index 097716bd248a..abf104ae9d35 100644
>> --- a/drivers/gpu/drm/ttm/ttm_resource.c
>> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
>> @@ -511,12 +511,12 @@ int ttm_resource_manager_evict_all(struct ttm_device
>> *bdev,
>>                .force_alloc = true
>>        };
>>        struct dma_fence *fence;
>> -      int ret;
>> +      int ret, evict_ret = 0;
>>
>>        do {
>> -              ret = ttm_bo_evict_first(bdev, man, &ctx);
>> +              evict_ret = ttm_bo_evict_first(bdev, man, &ctx);
>>                cond_resched();
>> -      } while (!ret);
>> +      } while (!evict_ret);
>>
>>        spin_lock(&man->move_lock);
>>        fence = dma_fence_get(man->move);
>> @@ -529,7 +529,7 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>>                        return ret;
>>        }
>>
>> -      return 0;
>> +      return (evict_ret == -ENOENT) ? 0 : evict_ret;
>> }

Can you explain why you care ENOENT(No such file or directory) specifically?

Regards

Xiaogang

>> EXPORT_SYMBOL(ttm_resource_manager_evict_all);
>>
>> --
>> 2.34.1
--------------ZP7JwmGO0lbTr7AqPzvCAj0j
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/21/2025 9:42 PM, Deng, Emily
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB5417991052F0D5ABED1D99528F99A@PH0PR12MB5417.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

Ping......

Emily Deng
Best Wishes



</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
Sent: Wednesday, May 21, 2025 11:57 AM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
Subject: [PATCH v2] drm/ttm: Should to return the evict error

For the evict fail case, the evict error should be returned.

v2: Consider ENOENT case.

Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
---
drivers/gpu/drm/ttm/ttm_resource.c | 8 ++++----
1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 097716bd248a..abf104ae9d35 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -511,12 +511,12 @@ int ttm_resource_manager_evict_all(struct ttm_device
*bdev,
              .force_alloc = true
      };
      struct dma_fence *fence;
-      int ret;
+      int ret, evict_ret = 0;

      do {
-              ret = ttm_bo_evict_first(bdev, man, &amp;ctx);
+              evict_ret = ttm_bo_evict_first(bdev, man, &amp;ctx);
              cond_resched();
-      } while (!ret);
+      } while (!evict_ret);

      spin_lock(&amp;man-&gt;move_lock);
      fence = dma_fence_get(man-&gt;move);
@@ -529,7 +529,7 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
                      return ret;
      }

-      return 0;
+      return (evict_ret == -ENOENT) ? 0 : evict_ret;
}</pre>
      </blockquote>
    </blockquote>
    <p>Can you explain why you care <span style="white-space: pre-wrap">ENOENT</span>(No
      such file or directory) specifically?</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:PH0PR12MB5417991052F0D5ABED1D99528F99A@PH0PR12MB5417.namprd12.prod.outlook.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
EXPORT_SYMBOL(ttm_resource_manager_evict_all);

--
2.34.1
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------ZP7JwmGO0lbTr7AqPzvCAj0j--
