Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2541D3B7DD
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2024 06:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA1110E0DF;
	Mon, 25 Nov 2024 06:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s7Vst8az";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D373710E0DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2024 06:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXO6v0etDebpEEE+P61PwwCayer2osZ9NJ+xDj5RDuz1FocXK8LpyHvAgKYea/l1fSeUFasRSu99xi+rAmawriNgQJZX+FrNfnQYaDfTxWjBD60sao+F5Ck/RY1crdXnQK1otgKdxTrqvKqigphQfuxFDhw5lDhh7tBHH4ilns4yStlEGakF0l8A3OfguqXaYn5xHbpNZfMdXVyLVssJIpbRUXjgco5H+MArgJZQhEpIvrGpg2ccD22CsRKbW0AjZ3ct78Dz5ZpNkfpODTawElvmuDw5LkUpaFrNzcGiARqhlFgqIQB5MxBWQt4A6AmmpulQgJW6SwTw+0fvYxuPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjsMeqXGyM9RdbAN/dNhThStaVuOM+OIp5m7QJ1/mWo=;
 b=QY8C7BFfd7RAiTKS66pXD9RN5EH4+lFUanO3JBmH+vu5HtgETCnQOZSoy2Qv6qXedlBJj6+pNiAalxbT8f2CnrLJZMF8WPyeXJGJhymbSmgMk1zwPkG+I7FiESYHNeAfj6tcvBzSDl4G7UkPUluPLIOP26yxBn3UltsurzLHLPl3ivyZ5pNjqYdfp31/vc7WpAawLdSVwG4253XHOPXPaEjSliE0Vf3lUhFkB+HPL4CM3Nr9sOYKIKJKGO4N87cAE5EH90m1YMO01kmbkiTBjIqdB2YgnK0t7yZ4HKzULx0zVvA1urcNiktgZTYxHFLbr24s2lpHdaEjWGVCM6okdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjsMeqXGyM9RdbAN/dNhThStaVuOM+OIp5m7QJ1/mWo=;
 b=s7Vst8azEZIFn4CVbsEvdd1VFtiVBbMf3ui/genJ7l7/oRQgPJ75tAXFAA96Ij0sGwCM9kIVs4HCfwNjBO5DGh1DiyrLy1WFFnT687OYOR0D42IihlIi6kHNJXFdTjO7eXDEh9IXrCR2tlBmr5wMAMYPAjU3m1NV1kWpFRxkO3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 06:40:22 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%6]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 06:40:22 +0000
Message-ID: <5dfd88a6-41eb-4731-9565-cdd5aaef2e64@amd.com>
Date: Mon, 25 Nov 2024 12:10:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add NULL ptr check for non userq fences
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241120092611.177202-1-Arunpravin.PaneerSelvam@amd.com>
 <9bd31692-9372-40a4-af9c-0c34a01535f9@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <9bd31692-9372-40a4-af9c-0c34a01535f9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::15) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: e7329787-6678-44f7-231e-08dd0d1c08ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnFMR0kxQjRTQXBZMnphMGF4RFBva0ZuVFJGZVlPNGFkSnA1OUdCSnFrT2cr?=
 =?utf-8?B?SHhOaWtqcE15SWRhMS90YmRMRUh2MkJ3YXh5L3B6VkJ3bjM2aUNrdlBJWFhF?=
 =?utf-8?B?VzZPT1htempwNmh4NWlrOGdYTHo4NXJTRjB4YmhFSVQzMlRpeTkvUDhOMm8y?=
 =?utf-8?B?cG9uaWZmUTJtejVha2VwdGVwOVFETXZtem1BWlZyVjRCK0JEUHBHU3hlNURQ?=
 =?utf-8?B?bjMwWndrS0dkNkJ1eU9pWk5QaDltalA0TFV1ZE1YdS84eDJkK3FWNjRxWHlq?=
 =?utf-8?B?bmwrdUdrUk1reXAvUVJVWkJRWVFqbjkvOGtUS1pQbnlKQ0I3M1JwOTdjSG9a?=
 =?utf-8?B?RFFtS09qaTB1VTVoVEhMNU1IMllLQ1IwYVJiL1BRVit2KzE5RmhFOEpHLzMz?=
 =?utf-8?B?Z215SUlPWDR6TUhXSUJUL204RGsxQ3JYRnd4RElTTis2Y2xQS0NtWDQ0Vmhl?=
 =?utf-8?B?YU1GdEhKSnhpWEVFWFlGVEt3dFlMZzIrcFE2UjRFeFE1My9zaFo4ZEdzZDM3?=
 =?utf-8?B?bTRyZTdTUkdnY1o0V1M4bVMvY2c4RTlaUzdXYzJPbWV6cHpQSE1vMGxPbHgr?=
 =?utf-8?B?bmV1R0N0QmQ0cEluNUdBbC9WcXFLenhxQ3c1cHB2dm04R0Y3cUNkTFcvUlVT?=
 =?utf-8?B?K0swSC82RHVvSFRHci85S0Y5anRuKzRWVVNiblZaY0JOZ1pGWmx3TVlsdWlz?=
 =?utf-8?B?V3p6TXNLdVk2dGxXMXNuU1d1NGJDMTlZeERxWmtoK0UwT2FuOXExWE52RnpC?=
 =?utf-8?B?UXhDUG5XZWZEZXVFZUh1dkk5Uy96Z3pSeENrckk2MmxQT09lc1JCZFZRWjBj?=
 =?utf-8?B?K3VaUWlLZm80eitCUkNoNmJIdWh0dWhkak1oRUtpdDZVZzhRSmQwS2UySkg2?=
 =?utf-8?B?TEowK1lBVzk5cU15NGNhS245bldsdGM1aGFoZWdld3Z4Z1l5YTYxOUxCNU5a?=
 =?utf-8?B?Rkd6SVhpeGxlYk9TcDJpOVFLUzlDbHNPNkRYOTdmS0V6TUFNcVZrVmlGWjhL?=
 =?utf-8?B?S2NKdXArdmQ2b2JoblRGb1R1YVpGQ0R5Y3ZxVXl3T2ZFbTVpZ2JlT1dlZTdY?=
 =?utf-8?B?dXlmeHdGOVRDbFRJbmRRZXZGRzRwK3B6MmpqYWJMcVcwSkt4Nm5leTFxZTJH?=
 =?utf-8?B?VDFXWlYvMlRDTkt6VjBCVHV1S3RGcXhtK2dHVlJmS0lwei9DcnVCdSs3d2ll?=
 =?utf-8?B?aGRWMUlQZlc5cXg0NitKMGtINFRhYWFaVEZNNkRTVTlFSG96L0MrRzFQajZN?=
 =?utf-8?B?MWIvVi9QdUM2R3pPVVBjd29xNDFlOGN6ZlB6bE9DaUlOT20rRnorWElWTlg3?=
 =?utf-8?B?d05JZVVaTXFzMkhrbjNyREhKNjQvblFjeWJPSTF3a3E1SVRFRTNxeGtxM2xk?=
 =?utf-8?B?Nk9MZklJOVRHQmhVNHFyNlRFM2ZXcHIyVTByUWttczlkU0VSbkpjTW9MYWxY?=
 =?utf-8?B?bWVBNGxYMFNkUlBVdm1uc1RnVEc0WlZDdld0ZkdESHZLbEEzQzBGTUZEa1Ny?=
 =?utf-8?B?SVBSQk9TOFNJWHZicmRuOHljWHU1czNCYkpNZldPTDRvVkk1U1pyNGh6K0F0?=
 =?utf-8?B?NllHdHM5Z3cycGttd01jdWkxWmJEYUk2a3psK29TWnJ4cWNSeTRLUmhJRklK?=
 =?utf-8?B?OTdNek9vNjZHMlQyU08wQjBNcjdHZGN4WFczUlN5NElLaEd1T3I1WTJXTmNQ?=
 =?utf-8?B?amhZYjhORFE5bkxBWmQyNWcwajFOdmVIbWRZdTBzdFREUm8xZXBwdnZUQ1Z4?=
 =?utf-8?B?bUI4RjBaemtLTkVnb0Q4V1dJWU9MQmpSNHRKZEdVRlMzNjIxRW9zYXR2NlRF?=
 =?utf-8?B?OTIvckg0bzdCWUlNeDF5UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzNSckZraWV0QXgvT2hoYkVwWFlhQXFvRUVYM2lBeHkzT2ZTWFlQU09BbUhC?=
 =?utf-8?B?TTUzbTRkb3FuS05NSmFqSzZ2KzRGbWI2dy9kWjgxVWdRSHVKOHQ0V3pwa3Bu?=
 =?utf-8?B?VDdHWk0wWEpoN3RrM2Y3SDFjb0swUHk5QmNpcVM0dTJkY0NHcFV2eDdJUTNt?=
 =?utf-8?B?M3pDRjREeEU4NlZZR1QrditnMDI4K1lrNlk4VnNFLzB1d1NSUTJodzB3V05o?=
 =?utf-8?B?RlhzRmNEMFhpRHZxZ05mR29MNUE5K0NDR1NYYUZ2R2NmeDlBSStRWGIrbks0?=
 =?utf-8?B?MXdUbmFQcnF3WXZ4di9oWnZDWERXbmJFRERsL2tYZ21ZclZxczkrN09veXBU?=
 =?utf-8?B?eENxRVFiKzVjY0d4OVkrOWNsZlRXOFdDQm91T0JoN0JsbDAvWkh0dU9URzE5?=
 =?utf-8?B?VmhLUFNiY3hoSWtlSGJLZ2g4WEZwd0FqUEozVE1sWktaM3FzOHVRVnhqbEcz?=
 =?utf-8?B?bEIwWDFuOXQzUzJOUjFGajRFMmh0RnBYOU92UmE2bktidm5Rb0l6T0xjaExP?=
 =?utf-8?B?OUd6Z2pMcWdkRUtEOWlzK2NzYjRWd3cvWVo3VE9OK2o1TGhQbElRbEkzVkVj?=
 =?utf-8?B?bzNpOFk2R3pGUWNuT1k1TldrRVAvUFFVWGc5R0VpZHlXVzd0dDNvUDFSVCtZ?=
 =?utf-8?B?UHBYUGNTYTcrYjUwMjNKYlFmNCtDOXZNRkdBTUN2c0NGQkd0YmFaY2o4UjZJ?=
 =?utf-8?B?QkxHeHEzTnpxU1BCbHhKUWJYT2FzZUNBa25iTGhZeGVIZ0lINk96MW14MFZY?=
 =?utf-8?B?VHBuRSs5anFDd3M5NW8rVFhxMmdQYlRYSnV3WnhTckpYeUFrdVpWMm0xWno2?=
 =?utf-8?B?ejdIU1RyNmdZYkJrT29SanIxMUpkdnBZTzBTZi9PQy9yZ3Rlei84ZzNydzM0?=
 =?utf-8?B?SUJnajl4OFNFaHdkVWg4d1JydnRFdDhONmFkbzNPSERpbVN0bmN3U1BleE5h?=
 =?utf-8?B?S0NCSjFsUE4xSkZXbmVBSkVGN0MzbmVObm5MQ0VsOFlkaEJ4NjVyeXNTK3ps?=
 =?utf-8?B?cThrNk96TnI0bUxEanpMS0tuV0lJcHNTYmpzSXF0S2NSQmhPSTdKZDFKYXlz?=
 =?utf-8?B?S3pLSzdNM0FLcDZ5c25BZUxBVk5FUWtJc1grcGxKOFAvb2IzOUg0bXhPbUNK?=
 =?utf-8?B?ekJ0N3Z0aGhyaFNNeXFpOFhvelQ1eTRZWnpUcS9kelRmWHdlL2xpRnRHUmdD?=
 =?utf-8?B?WE11STd6WUVsUDZsS2Nod2RQVFdrbmZHZFVMd0NLYmt1aGFxSFlKd3V5cWEr?=
 =?utf-8?B?dWs1SUQ4OUFaZXZNYWRFN2hUNWZMaDlUaG05ckViS1dzaDlTKytBU2pzSXFR?=
 =?utf-8?B?b1FDNUJrb2N1cjRRRXFuVFB1TFo2b01zMVpNWlFneHZybkFacjkzazhtQTBu?=
 =?utf-8?B?YWsvb2FxcHg4YnM4YUlYZk5wSjNwKzF4T2JtVDQzYmovSHI3b1hRcjhic3kw?=
 =?utf-8?B?eldoK1ZmTkl1aVJKVmZ0RVNsSEZrRnNrMGcwOEdSTVhFRys2cHBQUWcwdnkx?=
 =?utf-8?B?L0Foc0tQWFVjUjREcGpOeFFnaDEwcDRDRlB5NE83aVRqenlMaEh4VHpMeU1R?=
 =?utf-8?B?dk9mMk5UTjVKa3k5eGVBTFV6TzZlQTBZYkZ5dFB1Umh3Q1dCK0tkT1RWaDVz?=
 =?utf-8?B?UUlERjdXd0t0YTk4a3oya0VUc2hVQ2hCMmhPOHhRSStEZk5QNHV4WHhXNHRB?=
 =?utf-8?B?TUkreTdQd2lzejQ3WkhyVEZ6WFlZa0pUVjhZR2x2ejJoWFJtU2MvNWU5emRL?=
 =?utf-8?B?REFZMTQreWRmTmhKckgxZzNLdVdSY3laK2YvckRJR1Jud0tZNzNTdWJJSDZ5?=
 =?utf-8?B?RzVWRnpUQ2F6eHBMZzYzTThHazFnS2ZYclc2aWRGZ3BhR1NqT0tKdENJYUhD?=
 =?utf-8?B?dG9SaFdqb0Y0K1I0NGYxOHo4dzZ6ODQrRW8wd09pK21MWmdPaGkxL0lOTDRo?=
 =?utf-8?B?U21RbjYwQit2L2xvNjdpUFZZSE1OeTdJcTZTbnczUVl4QjdZUGpYd0hJbWgz?=
 =?utf-8?B?NGt1UzROc3VMQzRkdkV4cHlWRm1UWlRZZ3hYOERsNHVmYmhvUFVqd0dPVjJw?=
 =?utf-8?B?K3JDSVVaZjlyQ1E5OXBhZmlLTHcvWEx1czl6UGNGUEdXOVliRW9WTU1qRGpp?=
 =?utf-8?Q?ukAvlk2pwQE0fkYwYWGKjs53b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7329787-6678-44f7-231e-08dd0d1c08ea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 06:40:21.9897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWCsv080GFlUEUMJsyxyrwg57HpMJ3mWkLE5Zqu8I2Gtpmi5L9ImDi/x2Pqeo+SthpkGr16pjE+BYisrdHlKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181
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


On 11/20/2024 4:04 PM, Christian König wrote:
> Am 20.11.24 um 10:26 schrieb Arunpravin Paneer Selvam:
>> We are observing a NULL value in the non userq fences,
>> thus added a NULL pointer check just to avoid the
>> NULL pointer dereference crash.
>>
>> v2: Moved the NULL check above the non userq check.
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 6157a540c929..76f7babd7a54 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -815,6 +815,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>> *dev, void *data,
>>               struct amdgpu_userq_fence *userq_fence;
>>               u32 index;
>>   +            if (!fences[i])
>> +                continue;
>
> That should never ever happen in the first place.
>
> All fences in the array either come from some reservation object or 
> drm_syncobj. If any of those are NULL then there is a bug somewhere else.
We are observing the NULL fence for the non user queue fences, and these 
GEM BO reservation objects are coming userspace, should we request
mesa team to analyze this issue from userspace?

Thanks,
Arun.
>
> Regards,
> Christian.
>
>> +
>>               userq_fence = to_amdgpu_userq_fence(fences[i]);
>>               if (!userq_fence) {
>>                   /*

