Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7504BD1356B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 06:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EADD10E23D;
	Tue, 29 Oct 2024 06:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nGs3nado";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF11710E23D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYeXNBQolHqgqord+tU00gfwE0fAvLsshz3WOwzPPtAc43raCRl4EI1FhWERujDI9oKvekCnusK6AgA67alYLYs7z4LVQ4ZfgdM5uODoCSwJS5FKyyr4cjv683nTTf+BPn9mdWUaDZYVjVfekuS9j9pQWG1JiyR+WDhq5d9aOchrVPEaWuT5gIbjBpcU8vwlxHCrwrWxkS6AHdOx2CORXQaABelYBW07qB/2UoQAj/yAHb0n/YhEauEQh+ier0faXiD05FU2vSnlfpiZ23nAthnvjl1teq1RMaDE682VA9YpCmoXDrCIgdXdgXKaRROTcAxgr/6t7b5xbS/dq9eCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDz39BOB9zPorOSen2Md7mCymjwqUcXOhX/2WZurCII=;
 b=cEWnq7wUs9R0Bx9dIVZOzOF+Y1CP4e+iTikSB5aBrZsLzNqmYEchpFAOcnf7Ei12r9DhtpANVYjWRYchyOtFWUpheEyk4MPnsa+fdZzxgtjeEo2q0cvuFsbPPmX1CbiXBaIgHhcj2PkCeLo908+HGWn9i9+/BFRz9C4X+5iJrIktRucDEb5IlHluRXK8WCM5mojMTr1nv6kstLHO8clZ72qHQy23f+0XUTIrcS6xFNJLYvcVWOJLda9v+YBedKuPrT5HkfuDqIQGG7nAOTWkJdB11+puj3g28jBdLvzQmW7A2glbCW8DOPxuhODmes2e+GxCoSel7c07eHmSMPHvfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDz39BOB9zPorOSen2Md7mCymjwqUcXOhX/2WZurCII=;
 b=nGs3nado7XjuXqIk+Sog8qa00VdDMx9B0PDyJN5o9K3UTx+5g8U091NWcpk/wjNDMRx/6JaEy3x8pxWdodQbCxUJINeVrgU0m2uW22hz8lnguvacr7aj0I1GTB6epVPrM3Qm3ytxDwcQ6VF/SXi6//+fcC2S8SfuNWZ+AFlk2DY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 06:48:29 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 06:48:28 +0000
Content-Type: multipart/alternative;
 boundary="------------oH6O3pp0q1FcfEnCFEpvFtz2"
Message-ID: <c401ea1c-0b2f-4591-abe9-6a911c55b3a0@amd.com>
Date: Tue, 29 Oct 2024 12:18:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Group gfx sysfs functions
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20241029052700.3164571-1-lijo.lazar@amd.com>
 <93ad9f9b-9803-4ba3-b29a-06b5c53b5ccd@amd.com>
In-Reply-To: <93ad9f9b-9803-4ba3-b29a-06b5c53b5ccd@amd.com>
X-ClientProxiedBy: PN2PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::9) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: f7734871-a925-4b6c-c270-08dcf7e5b1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlR0S2V3MVZwRzcwS200ZnpDeWszOTZ4dmNSQjdkdnluNDlabUtVem5qdjB6?=
 =?utf-8?B?ZmZBcTB5NmdFSEtjdUpqaTU4RmlEZENYMmpOT3BmWDlwcE56dmI2b1hSRWFn?=
 =?utf-8?B?Q2o0Mm9sTFRENWJZaHBoejBwQk5NZHdkajNqOU5IcXhlcWJ4S0M5Vjc1Ujd0?=
 =?utf-8?B?ek85SS8wQTl1THBhaEZkWEx3a2xLZGNVQjFIQnRubUhoZGJQS2JGZFhNRkJs?=
 =?utf-8?B?ZWdELzQ5bWRWRTRBUzdLeEkrMUNuZkk2Z3dqMmp3RHlKNEVhNDM4TEYrb1JO?=
 =?utf-8?B?eGlpMWNjRzBsRDlyTmNYaUN0eWVjOCt3WURuM3VBZkk0SUs5M3VwamtoZTFa?=
 =?utf-8?B?eXgzUlFZelVFWWxEdWdpc0lwcXNkUVpiN1NaSnBqc2kreE12SWtMdW5KMXR0?=
 =?utf-8?B?Lzl3NDVlNGFGMHh1Y3JKaTVRT1J5OUZSNFZSSm9hSkpLbDRaYytLY3JxY2gy?=
 =?utf-8?B?OHNMeUtGaWJQc2NZMkFaT1FwM3RRL3Zpa3hXZElPNG1KMGoxRUw4ejJ3bHJ1?=
 =?utf-8?B?dXlRSEhuVDg5K2pUR3BQNjg0OFN1UWkxTjg1SWFZYncxZkcxVmYwcGZmSy85?=
 =?utf-8?B?UkQ4bkxqL2dTaXVhUDlRNkhMYU5TRVYyc3ZMazU2UXowRXdjS0swcWVSUzBq?=
 =?utf-8?B?R1MwdjFZbmdXN2EwbFhQelIydDMvaEtwS3RFbmdiWkszeC8rZGdDd1RYMitz?=
 =?utf-8?B?L3ZHUitxMjY5bTFVVmZpUkRoUUduYnlHQXFZdjFoMHFMSVZSU3dHRU9RK3E3?=
 =?utf-8?B?TjRacFVtOWFXSHlhTEtPSGtnOGE1WWFaQWRyaXNtRkVweXRtNDNIVFJTeXM2?=
 =?utf-8?B?U3Q2a0RPUGlIcnFnS0tqODQ2NTFzUktLZWJIMWV5OGRwRnZjMlBqck8xR21K?=
 =?utf-8?B?YVZDT3paeTJzRVlRZzJkTnYrTGNCT3RtNGZTR2dWc3hKZzVpUXMrQ3FIb0cx?=
 =?utf-8?B?WlBRVlJrTlVDY2czbHFJNjNwUlFmMXBFMmJ2aDRVYS8vdVhDNWNDRWJyZlRW?=
 =?utf-8?B?dHJPRlZhRmlBZ00vWFpNeFBqOXFlRitmR1pyNUU0Y3pESWhQbm5UV0NmWDhE?=
 =?utf-8?B?N2VVK01NRWVGREJhd09YdW0ySk9ka0dCcXNwRnl4cDJDam1CTjRwRDhick9s?=
 =?utf-8?B?UWViZ0c1WFdzYlJreFhPZldzTkdFZlhwbVUyRUx4cURUeXNrK0tkSlpUTk8r?=
 =?utf-8?B?bndRbE1TL0VKTnpIR1ZpYTJrSGRpZjZPZTI0Qm8vb0VlazFVUHQ2aDhTOUJ1?=
 =?utf-8?B?U1VmWUdYbHdrUjFpL2hOM21VUmJvL0tzVDNiQS9YdE5oNXhTZmliTnVMeDhN?=
 =?utf-8?B?SWRXRGNZUTBFbE0xYTZMaCt2b2czUWY1OW5VRmxrM3BzN3NOTVpTYUxkYXNq?=
 =?utf-8?B?NjIrMjhzaFluTVJ1SkFxTVJ4dDdxUGVodjZDdkc3VFUxZGxNUjAwKytsSzNl?=
 =?utf-8?B?RDdYeW9aTGo5ZG92Mm9FWVFYZnZvL2ZTUVlNT0lBaXhUelBtTGdCWEcwZUZq?=
 =?utf-8?B?K1FyOTZjbm1YQ2FXd0ZQMThvWE9kR0t4V05Ia2VZM2lvcWxrY1Qwelh3YnpN?=
 =?utf-8?B?MDVqS3VHa29rWEFycWZTZU5pMUc2NUhKY0g0dUt2a2hFRjJpbmYrVnFMRHBH?=
 =?utf-8?B?M3pKVmJCMVo5dTZidUJiWklJaDVMaFAwbVdORVpGNVppQVVSV2tSdzhwNWk0?=
 =?utf-8?Q?5m+Z7H9ja6ueUsIApYhS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anJwQXZURzhxUFNsSWozanFuK01iVTBFK1I3U2lZSURHSW85anhIejVNQVlY?=
 =?utf-8?B?Q1pEaDlvb0NGLzJCb0RkS3dnSDY3bldKUUZoYmlwY1cyOEphcEFyVC9oMzRm?=
 =?utf-8?B?b3l4TUlMUGRiSmlzcWlSMHpFdDU5UXNmeDJ4SmZqa2VncnA0M2NEQ0sxOUZ3?=
 =?utf-8?B?RHJscUI2S2NmK0JLOTU0dmdDNExJSkFRZXNpYWUyL3VuWUdZeHFma2VSTDN0?=
 =?utf-8?B?M21sNytqOCtEbnJYWjE0WnRLTmZTWWloTmJtR3RqNkVqdEtrUjFvM2lzTmUw?=
 =?utf-8?B?dFJqaDR4QVN6YVhmZmF6dVhWYjFvdkVMdGp3a1ExV09nVi93UzBWVmUrSkI4?=
 =?utf-8?B?LzBJYm9GR255OC9MREZnWTdjYnU5dTFXbzFqc0xnd1VUdElwY1ZBTVQrQzYx?=
 =?utf-8?B?b0NNS2I2NHNPandIL2ZmUXdkQVVQSFlZTWJGdHhnOTlYZXhPRWdLRG4yekV3?=
 =?utf-8?B?RnBhTmxCOXZNOE9TRTRQRVZnRVRDUTBuVDJUSjRTUkppcVlnVFlaZ082OUU4?=
 =?utf-8?B?TjZDbm5rWFpFR0dZOVVjLzJ5d05pek5nWEtpY0RHKzNrZFo5QkF1WVljOTVt?=
 =?utf-8?B?bmU5VGxHcmE5NEEvN05zSFVpQUNLd0FYMG8zYkNBanZ2c2M1MExlNDgxc09l?=
 =?utf-8?B?d0VnSFQwczhnUjJ6MjRZWTRwQWVIU1lpemtqanB5SnVDcGhESk9mQ3krY1Z1?=
 =?utf-8?B?N2NxeElqTHRDb0czVXZBd2w2Rlp6Z1VKR0gvY0ZGMk1LejZEazFYWXdGVjIz?=
 =?utf-8?B?ZHovN0N3a2Fzay9OMCtnaUpvbHFpOSs0Q05sWnBNc3RDTEs4Q2hHamRsV1pU?=
 =?utf-8?B?VGlqMzhBb3oydUdaWFJMSDBLSWlLTTJJSjBwbVB0UWQ5WHBVeWUxQlVad1Nn?=
 =?utf-8?B?UTRSREtrUVp6UHMwOWJ4VVVtRWhuUXUyTnhMSENBN0lwQ0krV2RPdmpib2hs?=
 =?utf-8?B?RFQrNUY4Z2VKSnZWN0sxbG43cjRpcWJNQ2FodUxOVng2cWlva2JHU3BXdCsr?=
 =?utf-8?B?alY4bG84T210RFpnUWhGbmhTMXNkWDVLdTlwMmMxN2VuQmh5QW9vN29OTEV2?=
 =?utf-8?B?V3FvUmQ5NThEMVl5MDBXc0cyUmdJeFg1TXNqdTY4bmY0Rjk0alJ2VUN2bWFG?=
 =?utf-8?B?NXdQbUdNVHJHd1BNdEJJa2dUQ1d6Y004MXZxQjl3WDVYZThsMEV3MlVDS05T?=
 =?utf-8?B?QTc2S2JobWVXR2ZDOVF3WEJHeTVVYjN1TlVIdi9sV01pNlN6cDZlSWFoSU5Q?=
 =?utf-8?B?cGxMYmFMbXdPMzVmaHFmKzNYdlBOTzdSWUVTU2Z2dEJxejh2dktEUm1pVzVt?=
 =?utf-8?B?STVidk1jMEExelhubUh5SlUyWGZqVW5tNytnNnVYbVBMaUFBWG4vV09Wd0Qw?=
 =?utf-8?B?UmNrdXROWDdRN0VGM0w4UlliTjRSUGpEMjVHVjd6Vm5JYVhtVUxsOFY2Tno1?=
 =?utf-8?B?dXZJOHBWT1pXN2ExVkVmS3VpQS9rUW9DYyt4VXRHOVZwUXI1Z3h1MEU2SFZU?=
 =?utf-8?B?eUNNYURHMUtabzVWbmp1YXlwTFZ0Nk9wR09CWWhraG14cWlYTHY4Uys4SzA1?=
 =?utf-8?B?dkNKRjFyWmdPdjRwdStQSzFYdmJZRFRHck1pNHd2TmZLTEdOVVY3N21YWkx4?=
 =?utf-8?B?VFJkTUo5aXNLUy8wNWdsZVZORk44VnlBY0M0NndKOTRqNmFKcGptNXZsSGpp?=
 =?utf-8?B?dUtkYkNrYTA4SnBYNmdQcC92S2pnWWxrdTdmMkFiRWpaRXMvQnZuTmlhNlNR?=
 =?utf-8?B?UjhyeWRpN0F5dlJPYjZkcmxodXluZmpiSTBCdUd3dHEvWUVzbWs5dlNnYkpv?=
 =?utf-8?B?RWFiQ01FeXRPOSt1dG9naU9OeG9PdWpocmJuVUJWb0xzVU5FM2hPVXlSZTJZ?=
 =?utf-8?B?UzJTcm1MWmJZTjEybFN3SmVOTEhlRGJ4ZGtNWThVY3YvVHFuQ0k4aUErYVMy?=
 =?utf-8?B?dm91KzVnRnNxTUZhMGtLTlJlM2hsZG45Y1NsWGJRbi9ia1F3Qk5zVFpoZmY5?=
 =?utf-8?B?Ym1ENzIzdy9sc2RFaEhTQmZtUnVHS3ZzUXNhNUUzS0N2eFdqNVhNRmpHU05Z?=
 =?utf-8?B?LzQ3b01Tb1BUUmVJdjhLa25ud1NyK3RpOS9MNzVxbCsrSDUwa3NsZVpsTUlt?=
 =?utf-8?Q?kXwxhhgcSucXvoj2U5zVz418q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7734871-a925-4b6c-c270-08dcf7e5b1ba
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 06:48:28.4144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4aMvusBa0uynEORJcc3dHO6nDCQNPzZwoRXoykbdkl9teBEch8o6AAwMHZ2Ejzmg7la+2NinNfV/yMuGLrV8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
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

--------------oH6O3pp0q1FcfEnCFEpvFtz2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/29/2024 12:07 PM, SRINIVASAN SHANMUGAM wrote:
>
>
> On 10/29/2024 10:57 AM, Lijo Lazar wrote:
>> Make amdgpu_gfx_sysfs_init/fini functions as common entry points for all
>> gfx related sysfs nodes.
>>
>> Signed-off-by: Lijo Lazar<lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 37 ++++++++++++++++++++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  5 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  5 ----
>>   7 files changed, 42 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index e96984c53e72..86a6fd3015c2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1602,7 +1602,7 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>>   static DEVICE_ATTR(available_compute_partition, 0444,
>>   		   amdgpu_gfx_get_available_compute_partition, NULL);
>>   
>> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>> +static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>>   {
>>   	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>   	bool xcp_switch_supported;
>> @@ -1629,7 +1629,7 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>>   	return r;
>>   }
>>   
>> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>> +static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
>>   {
>>   	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>   	bool xcp_switch_supported;
>> @@ -1646,10 +1646,13 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>>   				   &dev_attr_available_compute_partition);
>>   }
>>   
>> -int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>> +static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>>   {
>>   	int r;
>>   
>> +	if (!adev->gfx.enable_cleaner_shader)
>> +		return 0;
>> +
>
> This check seems to be incorrect here, because enforce_isolation and 
> cleaner shader are two different entities, with this check 
> enforce_isolation node won't be created for some of the ASIC's where 
> we don't load cleaner shader explictly.
>
Correction, this check "

!adev->gfx.enable_cleaner_shader"handles for ASIC's where we don't load cleaner shader explictly, but 
having it here I'm not certain cz I think we expect enforce_isolation 
node to be created independent of run_cleaner_shader, would request 
Alex/Christian, to comment onto it further. -Srini

> And moreover this grouping, its better to be done for all sysfs 
> entires in amdgpu ie., not only gfx, for other modules like even pm 
> etc., so that we can have one common sysfs amdgpu framework, improving 
> code consistency and maintainability
>
> I had initiated this https://patchwork.freedesktop.org/patch/595215/ 
> <https://patchwork.freedesktop.org/patch/595215/> , but I couldn't 
> finish it because of other work commitments.
>
>>   	r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
>>   	if (r)
>>   		return r;
>> @@ -1661,12 +1664,38 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>>   	return 0;
>>   }
>>   
>> -void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
>> +static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
>>   {
>> +	if (!adev->gfx.enable_cleaner_shader)
>> +		return;
>> +
>
> Same here
>
> -Srini
>
>>   	device_remove_file(adev->dev, &dev_attr_enforce_isolation);
>>   	device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
>>   }
>>   
>> +int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>> +{
>> +	int r;
>> +
>> +	r = amdgpu_gfx_sysfs_xcp_init(adev);
>> +	if (r) {
>> +		dev_err(adev->dev, "failed to create xcp sysfs files");
>> +		return r;
>> +	}
>> +
>> +	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> +	if (r)
>> +		dev_err(adev->dev, "failed to create isolation sysfs files");
>> +
>> +	return r;
>> +}
>> +
>> +void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>> +{
>> +	amdgpu_gfx_sysfs_xcp_fini(adev);
>> +	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> +}
>> +
>>   int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
>>   				      unsigned int cleaner_shader_size)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index f710178a21bc..b8a2f60688dc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -577,8 +577,6 @@ void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
>>   void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>>   				    unsigned int cleaner_shader_size,
>>   				    const void *cleaner_shader_ptr);
>> -int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
>> -void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
>>   void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
>>   void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
>>   void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 9da95b25e158..d1a18ca584dd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -4853,9 +4853,10 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   
>>   	gfx_v10_0_alloc_ip_dump(adev);
>>   
>> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> +	r = amdgpu_gfx_sysfs_init(adev);
>>   	if (r)
>>   		return r;
>> +
>>   	return 0;
>>   }
>>   
>> @@ -4907,7 +4908,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>   		gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
>>   
>>   	gfx_v10_0_free_microcode(adev);
>> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> +	amdgpu_gfx_sysfs_fini(adev);
>>   
>>   	kfree(adev->gfx.ip_dump_core);
>>   	kfree(adev->gfx.ip_dump_compute_queues);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 5aff8f72de9c..22811b624532 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1717,7 +1717,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   
>>   	gfx_v11_0_alloc_ip_dump(adev);
>>   
>> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> +	r = amdgpu_gfx_sysfs_init(adev);
>>   	if (r)
>>   		return r;
>>   
>> @@ -1782,7 +1782,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>   
>>   	gfx_v11_0_free_microcode(adev);
>>   
>> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> +	amdgpu_gfx_sysfs_fini(adev);
>>   
>>   	kfree(adev->gfx.ip_dump_core);
>>   	kfree(adev->gfx.ip_dump_compute_queues);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 9fec28d8a5fc..1b99f90cd193 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -1466,7 +1466,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   
>>   	gfx_v12_0_alloc_ip_dump(adev);
>>   
>> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> +	r = amdgpu_gfx_sysfs_init(adev);
>>   	if (r)
>>   		return r;
>>   
>> @@ -1529,7 +1529,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>   
>>   	gfx_v12_0_free_microcode(adev);
>>   
>> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> +	amdgpu_gfx_sysfs_fini(adev);
>>   
>>   	kfree(adev->gfx.ip_dump_core);
>>   	kfree(adev->gfx.ip_dump_compute_queues);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 66947850d7e4..987e52c47635 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -2402,7 +2402,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   
>>   	gfx_v9_0_alloc_ip_dump(adev);
>>   
>> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> +	r = amdgpu_gfx_sysfs_init(adev);
>>   	if (r)
>>   		return r;
>>   
>> @@ -2443,7 +2443,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>   	}
>>   	gfx_v9_0_free_microcode(adev);
>>   
>> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> +	amdgpu_gfx_sysfs_fini(adev);
>>   
>>   	kfree(adev->gfx.ip_dump_core);
>>   	kfree(adev->gfx.ip_dump_compute_queues);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 016290f00592..983088805c3a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -1171,10 +1171,6 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>>   
>>   	gfx_v9_4_3_alloc_ip_dump(adev);
>>   
>> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> -	if (r)
>> -		return r;
>> -
>>   	return 0;
>>   }
>>   
>> @@ -1199,7 +1195,6 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
>>   	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>>   	gfx_v9_4_3_free_microcode(adev);
>>   	amdgpu_gfx_sysfs_fini(adev);
>> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>>   
>>   	kfree(adev->gfx.ip_dump_core);
>>   	kfree(adev->gfx.ip_dump_compute_queues);
--------------oH6O3pp0q1FcfEnCFEpvFtz2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/29/2024 12:07 PM, SRINIVASAN
      SHANMUGAM wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:93ad9f9b-9803-4ba3-b29a-06b5c53b5ccd@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 10/29/2024 10:57 AM, Lijo Lazar
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20241029052700.3164571-1-lijo.lazar@amd.com">
        <pre class="moz-quote-pre" wrap="">Make amdgpu_gfx_sysfs_init/fini functions as common entry points for all
gfx related sysfs nodes.

Signed-off-by: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com" moz-do-not-send="true">&lt;lijo.lazar@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 37 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  5 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  5 ----
 7 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..86a6fd3015c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1602,7 +1602,7 @@ static DEVICE_ATTR(current_compute_partition, 0644,
 static DEVICE_ATTR(available_compute_partition, 0444,
 		   amdgpu_gfx_get_available_compute_partition, NULL);
 
-int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
+static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev-&gt;xcp_mgr;
 	bool xcp_switch_supported;
@@ -1629,7 +1629,7 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 	return r;
 }
 
-void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
+static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev-&gt;xcp_mgr;
 	bool xcp_switch_supported;
@@ -1646,10 +1646,13 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 				   &amp;dev_attr_available_compute_partition);
 }
 
-int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
+static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 {
 	int r;
 
+	if (!adev-&gt;gfx.enable_cleaner_shader)
+		return 0;
+</pre>
      </blockquote>
      <p>This check seems to be incorrect here, because
        enforce_isolation and cleaner shader are two different entities,
        with this check enforce_isolation node won't be created for some
        of the ASIC's where we don't load cleaner shader explictly.<br>
      </p>
    </blockquote>
    Correction, this check &quot;
    <pre class="moz-quote-pre" wrap="">!adev-&gt;gfx.enable_cleaner_shader&quot; <span style="white-space: normal">handles for ASIC's where we don't load cleaner shader explictly, but having it here I'm not certain cz I think we expect enforce_isolation node to be created independent of run_cleaner_shader, would request Alex/Christian, to comment onto it further.

-Srini
</span></pre>
    <blockquote type="cite" cite="mid:93ad9f9b-9803-4ba3-b29a-06b5c53b5ccd@amd.com">
      <p> </p>
      <p>And moreover this grouping, its better to be done for all sysfs
        entires in amdgpu ie., not only gfx, for other modules like even
        pm etc., so that we can have one common sysfs amdgpu framework,
        <span data-teams="true"><span class="ui-provider a b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr"> improving code consistency and maintainability</span></span></p>
      <p><span data-teams="true"><span class="ui-provider a b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">I had initiated this </span></span><span data-teams="true"><span class="ui-provider a b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr"><a aria-label="Link https://patchwork.freedesktop.org/patch/595215/" id="menurifo" href="https://patchwork.freedesktop.org/patch/595215/" rel="noreferrer noopener" target="_blank" class="fui-Link ___1q1shib f2hkw1w f3rmtva f1ewtqcl fyind8e f1k6fduh f1w7gpdv fk6fouc fjoy568 figsok6 f1s184ao f1mk8lai fnbmjn9 f1o700av f13mvf36 f1cmlufx f9n3di6 f1ids18y f1tx3yz7 f1deo86v f1eh06m1 f1iescvh fhgqx19 f1olyrje f1p93eir f1nev41a f1h8hb77 f1lqvz6u f10aw75t fsle3fq f17ae5zn moz-txt-link-freetext" title="https://patchwork.freedesktop.org/patch/595215/" moz-do-not-send="true">https://patchwork.freedesktop.org/patch/595215/</a>
          </span></span><span data-teams="true"><span class="ui-provider a b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">,</span></span> but I couldn't finish it because
        of other work commitments.<br>
      </p>
      <blockquote type="cite" cite="mid:20241029052700.3164571-1-lijo.lazar@amd.com">
        <pre class="moz-quote-pre" wrap=""> 	r = device_create_file(adev-&gt;dev, &amp;dev_attr_enforce_isolation);
 	if (r)
 		return r;
@@ -1661,12 +1664,38 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
+static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
 {
+	if (!adev-&gt;gfx.enable_cleaner_shader)
+		return;
+</pre>
      </blockquote>
      <p>Same here</p>
      <p>-Srini<br>
      </p>
      <blockquote type="cite" cite="mid:20241029052700.3164571-1-lijo.lazar@amd.com">
        <pre class="moz-quote-pre" wrap=""> 	device_remove_file(adev-&gt;dev, &amp;dev_attr_enforce_isolation);
 	device_remove_file(adev-&gt;dev, &amp;dev_attr_run_cleaner_shader);
 }
 
+int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = amdgpu_gfx_sysfs_xcp_init(adev);
+	if (r) {
+		dev_err(adev-&gt;dev, &quot;failed to create xcp sysfs files&quot;);
+		return r;
+	}
+
+	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		dev_err(adev-&gt;dev, &quot;failed to create isolation sysfs files&quot;);
+
+	return r;
+}
+
+void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
+{
+	amdgpu_gfx_sysfs_xcp_fini(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+}
+
 int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
 				      unsigned int cleaner_shader_size)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f710178a21bc..b8a2f60688dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -577,8 +577,6 @@ void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 				    unsigned int cleaner_shader_size,
 				    const void *cleaner_shader_ptr);
-int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
-void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9da95b25e158..d1a18ca584dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4853,9 +4853,10 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v10_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
+
 	return 0;
 }
 
@@ -4907,7 +4908,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
 
 	gfx_v10_0_free_microcode(adev);
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev-&gt;gfx.ip_dump_core);
 	kfree(adev-&gt;gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..22811b624532 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1717,7 +1717,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v11_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
@@ -1782,7 +1782,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v11_0_free_microcode(adev);
 
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev-&gt;gfx.ip_dump_core);
 	kfree(adev-&gt;gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9fec28d8a5fc..1b99f90cd193 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1466,7 +1466,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
@@ -1529,7 +1529,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_free_microcode(adev);
 
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev-&gt;gfx.ip_dump_core);
 	kfree(adev-&gt;gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 66947850d7e4..987e52c47635 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2402,7 +2402,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v9_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
@@ -2443,7 +2443,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	}
 	gfx_v9_0_free_microcode(adev);
 
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev-&gt;gfx.ip_dump_core);
 	kfree(adev-&gt;gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 016290f00592..983088805c3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1171,10 +1171,6 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v9_4_3_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
-	if (r)
-		return r;
-
 	return 0;
 }
 
@@ -1199,7 +1195,6 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_bo_unref(&amp;adev-&gt;gfx.rlc.clear_state_obj);
 	gfx_v9_4_3_free_microcode(adev);
 	amdgpu_gfx_sysfs_fini(adev);
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
 
 	kfree(adev-&gt;gfx.ip_dump_core);
 	kfree(adev-&gt;gfx.ip_dump_compute_queues);
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------oH6O3pp0q1FcfEnCFEpvFtz2--
