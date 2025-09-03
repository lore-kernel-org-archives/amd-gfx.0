Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9475FCA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 13:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E27610E0C1;
	Wed,  3 Sep 2025 13:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ALm2tAsA";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA6A10E0C1
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 13:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKn7Z+HQMjkcw9oiFbFFNrbU4AIoZ9xi+Eppu6CEOD5Cb5s0DjYdztloXMjrYyRjZZgBHVz/LWGFB6PA8q8JDsIZALccOi2mci4nTZvxwjvoXGhcOz6motvgQ188XteZoTno6YQzPyNPeaHVjIEpq83iqGcJq/HIQRPEhSac2B1ftyPWvIhgRw7N2dbfD941XDqUgiKKTrkv1dO7PtDMDOTi0nc5kiyJ/pBBwXSpn+6Q9FwBLocCbQ81FYI0q7WDI3cX2qZjEaw/5YdKz9ZSZoGAaECH67BoeExMY9T8NHCHYt7hSAc8t5hAS58RXm8+F8rMZY64CTlvbM2sSSSHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmI5vtOSuSWQIA3+Xzp0BXZc6IE6DGq063GPI5xVKds=;
 b=OnKm0gXqyt4qjlrYBKtAt86/70SuGUjXXepOXz7ku14k0agqllvl+JnlfUPTIG+oV7DnjhLCGsHSriAHimSGWPEifO8GV0v84N3lQGo20gfOsokO1WDmAYfHT7bclDeH2B0UxDWPSo0I4PNUjbiYzndJDf6YyU72abWbJfldfwKpZ4bQ2btSMuBSTGYh7lN3QrEiGh09a1buo0GIZZkorQBTT/2qJGU1CfYdKmMH6H0gGWFAe5VHrswwvsYptLB1FNpJbotjBCWcXh1cEQ44oTpqE1K2dIG3VTkGTwkxQc6oq9P+ySDborpwwpz69QozbrzXG6ciNTd33UlBKe78ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmI5vtOSuSWQIA3+Xzp0BXZc6IE6DGq063GPI5xVKds=;
 b=ALm2tAsAVeEIfgvcI6PSqXITW+PfCGsCPEBROqeJLoTJ74RD2jPXdCvNNKCVs3NbsjS2ehtnkAje+lG0DNDFFvk7SieuTzKJYD5eTuVFxFeWRJEB+wXBBiQzXTKV7MxL+BZFORLjTrJk9V8zcnFK8x8gKesJ9gLomTF0aqV210I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 13:46:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 13:46:29 +0000
Message-ID: <bd5813fa-665c-4dd4-aa31-256487b92264@amd.com>
Date: Wed, 3 Sep 2025 15:46:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: revert "Rename VM invalidate to status
 lock" v2
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil.Khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250828150200.4035-1-christian.koenig@amd.com>
 <20250828150200.4035-3-christian.koenig@amd.com>
 <4149e06a-da7f-46d9-b8da-f0aacaf75758@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4149e06a-da7f-46d9-b8da-f0aacaf75758@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0038.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2a62d2-51b6-4e28-e312-08ddeaf04867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE12cC9jTWtjdksrVWJVeUpmK3hQWHdDNnNkek8vSWxxVG1hTzJSNC8vMENk?=
 =?utf-8?B?WmZydGxlTEJ2U1JFZnNlb3I0TWp1UnNDZkt2SDFFWnRJNDVGR2JwS2RDbHcx?=
 =?utf-8?B?VS9iMmtBWjBPWUtBSDNWbnk2Q1d5U2RLRFNyTmxHQ0Q3emcrL2QzQmJMaThV?=
 =?utf-8?B?TFF5MEZub1hQMXU4b3g5Z3l4bnd3ODFmdmJWaWJldTFuS3FWSlRGTFozUXll?=
 =?utf-8?B?R1RpTTh2L0p0ZTFyZ0JqSVRUSjRRbkhhZkt2dXF0azQwNWNoNUR3WlUxMm12?=
 =?utf-8?B?UEpMcnQ3K1d3N05DQUlPT1NrN1hBZnZGRzloaEpqTEVmUjZsdDdydUQvL1h5?=
 =?utf-8?B?VGxNaVRzVHo3QXdXKzRzQXgvdkJkcHVDREhpcGRhN1RiTDJyS3hIZUdOcDVi?=
 =?utf-8?B?MWNUenBISzYyNUJRQThCY0lpOHBCdzltZE51QS9CemNvL1RwdXJHN0VtaTdQ?=
 =?utf-8?B?UHVmQVYrQ0JuWlo0MEFibVM5WXppZW00U3ZSWlB3VGh2Y2xJUk9kQ0JnN0ZH?=
 =?utf-8?B?cHZQcy9CMVEwdk1OUWpiTWZHTlZ4M0JSam9NdFdMQVpUcWdteWVlbzJuS0xn?=
 =?utf-8?B?aFlyaVJ1SGZEN1lNRmJNTE1DN1hEQjNYVmFyOE5jeG1aQUhtdytDZ0VVMkVX?=
 =?utf-8?B?WWVhQS85bmdMMVlrWCtnd2FNRUdrZmlEODRhc1FnUEFmV1NiUHM1c3lnYWN5?=
 =?utf-8?B?MFhnWkxvaGJUbGRnMjEvM3p5TEpMeVZiYkhXYkpkam1BSGYza1ZhWS9hc3dM?=
 =?utf-8?B?VTRLOWt0MGRoblh6Z3R0L0oydFRRd2lDWmhBQTdLNG1SSjZZdDEvNkxxajNT?=
 =?utf-8?B?Y3owMW8vbk00R051TC8zSzVad3VNMG5CZk1KOUxNZCtyV3g1TmY1WStKa3NI?=
 =?utf-8?B?SmNMeFc5M2J0ZmZpQlFmc0ZmR05xcElxeEI4NXhXSGo1UkpLWnpOeXNyQVFm?=
 =?utf-8?B?NUQvNVJ0SVhsMnVzWUFEanp4clErQ291WWpOMGVzRkw5WU9ubjZUeXNJV1hW?=
 =?utf-8?B?Zmw4em0rWnJWWEZuckZOb3Mvb1hDL1UxNktaWlhGM2YvNzYwMzIwT3dWWUk0?=
 =?utf-8?B?cGNwa2xtb3gxZEFoUDcxeWFOd3ZWQ3h0SFhwQXdiSmZSNE1uUzNQTWlQV0NI?=
 =?utf-8?B?aHYzVXp3WDl2YkJvUnUxRk5idXZkOHBhTmp3WjgwT1ZONDdQNTdscFQ2N0ZB?=
 =?utf-8?B?RzRvbTZmY2FBOVFoWTRreXBXSm1USW92dGsrZXVRMEJUd3gzTVhLaFRveGFu?=
 =?utf-8?B?MFJ3WlRPNFZ1Mm9CdW8vdllsbHhlRDc0WGkvTlJTeHh3VzNKQTVmWkpoREFN?=
 =?utf-8?B?SmRtRzBnNXRlODdZRklQVU8ya2dFS0FmRUtSaFl2WGZWOXR5ajJWMzd5WEJh?=
 =?utf-8?B?ZjlXNU1nWkMzaVZDNi9RaWk4cGgwZG5XY1FmNEdRL2lmWUk5Y3lVWDJnM3ZU?=
 =?utf-8?B?U2dwbFNYenhZUUdoUFlLS0tXMzhSY1hMMXozRDV1NnI4VDZQKzQwcUE3NTFn?=
 =?utf-8?B?VGIyYTgvU0x0M000VzVKZExCOUdENDBvdVEwaUhpNG52UnU3Vno2ZnlFZW1R?=
 =?utf-8?B?TVBEZ3N6Q0RrSWtCMTJxUHh5YzMwQmg3ZGlDWjdEZmFWb2NBd1NGMUlZODZ5?=
 =?utf-8?B?Tjk3MlVnQzBpd3l3YktuS2hzcVBIQnVBU2sxaEEyUFdQUDYrTzNlaUVXYzVt?=
 =?utf-8?B?WisvOVJTV0dHRXRxWlQrN3FiQUtjdjFvMTlaZEhVR0JDdGVCSjZkTTV2NFc1?=
 =?utf-8?B?QU9aRjZDRmJSOE9nRitTcis4NXBGZjBFZ01hdGYzdzdUeGZld090Q2lmaE4v?=
 =?utf-8?B?Z3FmOXhJT0ZUQWc1MnBNRzkraGJvbmZYOHkwT09FM2xGazdpR2RRVFZUQ1hu?=
 =?utf-8?B?NXJiZHlwcURNRHJKQ2habmh4Z3FoR1BGNXg0WjlpMlBWZGRxWnhQOHptVDVU?=
 =?utf-8?Q?2CLmtgLfyEA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFY3bXdDTE12aU4rM3V5YkJGSk5nSy9DQWg2S1VFYkRtditXL3YvRDBhZ3BH?=
 =?utf-8?B?VlcwS1VSOGI2UVV4KzUwdURGS0tSbHJxM25aUzlaSUpCUU9nOXROWE5mcERu?=
 =?utf-8?B?ZERjc2V4YkZZVEczS045ZmJ5anhuUk9aQmtBeVlTekd2dXFYL1htZkZLYzRT?=
 =?utf-8?B?N01WMHNHQWVmaWlVQVNwTUNsWXFRQzdKWWZsR2dNTU5ndEZqTU9mcUF4UTZn?=
 =?utf-8?B?SzNPRVR0SDV1MlV6MUIyVk9nMGV1WjF6UnFyNzVKZGcrS01DWXJwVHE4Z0tK?=
 =?utf-8?B?V1lsb3dVOU9FTnAvbkwzMkNlZ3ZRNGt4T05iYThOSUdrYmhJRkpySi9pL1Zj?=
 =?utf-8?B?KzlrSUNyR1o5dndHak1UcXRmUldPbEM3Z3dHcTJEV25DaCt0Wms1blhtZVJr?=
 =?utf-8?B?RTMzSFVwaWw5S25Nc0dxdjRPczFNR3Y3M1lZMDBRckZ4eEJkbERkVkhoVkVI?=
 =?utf-8?B?M0oyT0ZKUGNZbnc2K1p1Q0l5MHVuVmFpbG96dWtiZXlKS2FMcHVnSmtDengv?=
 =?utf-8?B?ZytDNlN4RTVTc1k5cmJ1aXZULzB5M29FTmd1SFZkcGpUTVZ5MEluQ2w5ZnBS?=
 =?utf-8?B?NHh1QmdFcFNLYXBiTWdLTUNTWmdCT29lMU4rNlFvUGZsV21LOHJ4RldjSkVs?=
 =?utf-8?B?NGlFY1g2UDYrc0FQc1NNVFpkNU5qbDVNM2VWSlM0ZDF5SGRDVFYvN2lpbDdm?=
 =?utf-8?B?S2lGQStKUS9rQnpybGI5MlJtbUk5S3NiWmpSTFlTK2k1TzZjQXdXQ295NVJa?=
 =?utf-8?B?bVBWMm1hNnptM0JYb0s3VkxsdkkvMHQ1Q0ZDWWFVY2hXSHIxYXM0bkZCNXBC?=
 =?utf-8?B?ZGlTZjBsZk0rRDM5emVWRkNKYzNwdUEwL0pFRE12bCtJRXVBcTh4U3J0b0JL?=
 =?utf-8?B?MUh3aGV5a3lFazRjaFk0dmI5dmcrQkg2RlovMWE4UXFLSks0d3U1SmtNc2Zp?=
 =?utf-8?B?OUorblF3Ri80UXlaZ1ZMYUVpdm8zck56Q284K3BISlhLTFRsREg0KzZNc1hC?=
 =?utf-8?B?TjZNSFVndDdoYnhMUEpldXRtelAvNFRWQ1d2Rms5aUxEc2RmVmg5OWRudUhP?=
 =?utf-8?B?S1pvVnZtQ3RkOVF6T1ozLytHTC9yRks5ZEpiNDZqSjE0Y2svRElQUTlvT1RV?=
 =?utf-8?B?VG5jcllVMW9OU2xsZ0c3Z0laRXJFNGp5dFNEL2FzNkVYUEZqa2ZoMCtPVUZT?=
 =?utf-8?B?bDFTMVRIelJOM0pPWncrZlpEOGsyb0FYaHBrUERwbWRPRnM5ZzRQMm4vUzl0?=
 =?utf-8?B?UFdOSEoxaDZJYzEvNnlScUttVWlFODFOVlpVWENuQWZqbE4waG1TRWxPV2pW?=
 =?utf-8?B?SFRuYTRPTGlRUVZGOXpCUHIrT1VhVmxvdldLUGRtdzNWRjZQZTU4WVB6dEty?=
 =?utf-8?B?dzZxMXZ3UW4rNEpyTEt1WTZ1MWQvV2xWRk9qbFZrTENqOEZ5VGlRL0dBdGlh?=
 =?utf-8?B?Qi9lN2wwcGFHZzVBVngrVlRiek5RNnJ3SFpUQ0tIY1ptall1c1NWdWRXUHk4?=
 =?utf-8?B?NVVZYVEyVWJUWmZFSjN0VXRuWjdCTUlPa0ZuR29VNnM2eGt6bHBaTWVMVExB?=
 =?utf-8?B?cHRGMW1mS1lFTmlsN0RiTTBucnhpa0l2MVJQK3BkV2dWT3FkOTRxUFlBTk1B?=
 =?utf-8?B?U0lVTU1UeVFkREFZNFVSa0pwS0FjN0VHQzVHd2FUTkt3cVBSM2hham8yWkxC?=
 =?utf-8?B?dnR1dlpPZElaVVY2MEFCOHA3TUd2YnJpZVpsQ0dkWjkzUXovRmx5NkdLb05J?=
 =?utf-8?B?TEZTSzVlWnlpNlZtZ0JZV08vWTgvTXpDa1l2QTkyUUlhZzVuN0pZVzJSZURP?=
 =?utf-8?B?QzRxOUpHRUNVNmhLUUx4bWM5cllySmV2eTRsQVBBdWxMR0x2dnc2bkw5bDE0?=
 =?utf-8?B?ODdlRzhyU1dIM1pGS2ZkblozN0lhSXlnbDhMK2JQWHNSMmtTMUp0djM0SmdS?=
 =?utf-8?B?WkE5dGs5QVFEbWMwaDhCK3I0dVlsQUw2ZHJOVTVZbHB4aEdCQTlRdnRwUWJX?=
 =?utf-8?B?bExEQVh4TkE0SnB0ZmtaSlpXc09NYUc4Q3JqcXZES3k5R1pVWmplSDBTNFQ5?=
 =?utf-8?B?NVMrOGp2Z0JRVUtrbEx2WWxvRlI4QTc2d0tRdFJydldWajFHSWtGdDRQalZv?=
 =?utf-8?Q?3Fb0GBbCZOrs5DAhF0fLe9DAq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2a62d2-51b6-4e28-e312-08ddeaf04867
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:46:29.7663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNYudIf/YF1PksnAMJPY7VogYWLeKJxw6N2YLlxNYzzHYtqvSEJmsr15JXh0tWjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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

On 02.09.25 11:07, Khatri, Sunil wrote:
> 
> On 8/28/2025 8:32 PM, Christian König wrote:
>> This reverts commit 0479956c94b1cfa6a1ab9206eff76072944ece8b.
>>
>> It turned out that protecting the status of each bo_va only with a
>> spinlock was just hiding problems instead of solving them.
>>
>> Revert the whole approach, add a separate stats_lock and lockdep
>> assertions that the correct reservation lock is held all over the place.
>>
>> While at it also re-order fields in the VM structure and try to improve
>> the documentation a bit.
>>
>> v2: re-add missing check
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 168 +++++++++++-----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  25 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>>   4 files changed, 96 insertions(+), 109 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index abc2f96bea76..727dd2e27885 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -562,12 +562,12 @@ amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
>>       struct amdgpu_bo *bo;
>>       int ret;
>>   -    spin_lock(&vm->status_lock);
>> +    spin_lock(&vm->invalidated_lock);
>>       while (!list_empty(&vm->invalidated)) {
>>           bo_va = list_first_entry(&vm->invalidated,
>>                        struct amdgpu_bo_va,
>>                        base.vm_status);
>> -        spin_unlock(&vm->status_lock);
>> +        spin_unlock(&vm->invalidated_lock);
>>             bo = bo_va->base.bo;
>>           ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
>> @@ -584,9 +584,9 @@ amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
>>           if (ret)
>>               return ret;
>>   -        spin_lock(&vm->status_lock);
>> +        spin_lock(&vm->invalidated_lock);
>>       }
>> -    spin_unlock(&vm->status_lock);
>> +    spin_unlock(&vm->invalidated_lock);
>>         return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index a0339187eccd..a25134790476 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -127,6 +127,17 @@ struct amdgpu_vm_tlb_seq_struct {
>>       struct dma_fence_cb cb;
>>   };
>>   +/**
>> + * amdgpu_vm_assert_locked - check if VM is correctly locked
>> + * @vm: the VM which schould be tested
>> + *
>> + * Asserts that the VM root PD is locked.
>> + */
>> +static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
>> +{
>> +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>> +}
>> +
> 
> So the caller is now responsible to make sure to hold the root bo locked while performing all the operations on vm ?

Yes, that was always the case (with the exception of invalidation from fault handlers for HMM, but that is just one function).

Regards,
Christian.

> 
> Regards
> Sunil
> 
>>   /**
>>    * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
>>    *
>> @@ -143,6 +154,8 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   {
>>       int r;
>>   +    amdgpu_vm_assert_locked(vm);
>> +
>>       if (vm->pasid == pasid)
>>           return 0;
>>   @@ -181,12 +194,11 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>>       struct amdgpu_bo *bo = vm_bo->bo;
>>         vm_bo->moved = true;
>> -    spin_lock(&vm_bo->vm->status_lock);
>> +    amdgpu_vm_assert_locked(vm);
>>       if (bo->tbo.type == ttm_bo_type_kernel)
>>           list_move(&vm_bo->vm_status, &vm->evicted);
>>       else
>>           list_move_tail(&vm_bo->vm_status, &vm->evicted);
>> -    spin_unlock(&vm_bo->vm->status_lock);
>>   }
>>   /**
>>    * amdgpu_vm_bo_moved - vm_bo is moved
>> @@ -198,9 +210,8 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> -    spin_lock(&vm_bo->vm->status_lock);
>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>>       list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
>> -    spin_unlock(&vm_bo->vm->status_lock);
>>   }
>>     /**
>> @@ -213,9 +224,8 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> -    spin_lock(&vm_bo->vm->status_lock);
>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>>       list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
>> -    spin_unlock(&vm_bo->vm->status_lock);
>>       vm_bo->moved = false;
>>   }
>>   @@ -229,9 +239,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> -    spin_lock(&vm_bo->vm->status_lock);
>> +    spin_lock(&vm_bo->vm->invalidated_lock);
>>       list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
>> -    spin_unlock(&vm_bo->vm->status_lock);
>> +    spin_unlock(&vm_bo->vm->invalidated_lock);
>>   }
>>     /**
>> @@ -244,10 +254,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>>       vm_bo->moved = true;
>> -    spin_lock(&vm_bo->vm->status_lock);
>>       list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
>> -    spin_unlock(&vm_bo->vm->status_lock);
>>   }
>>     /**
>> @@ -260,13 +269,11 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> -    if (vm_bo->bo->parent) {
>> -        spin_lock(&vm_bo->vm->status_lock);
>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>> +    if (vm_bo->bo->parent)
>>           list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
>> -        spin_unlock(&vm_bo->vm->status_lock);
>> -    } else {
>> +    else
>>           amdgpu_vm_bo_idle(vm_bo);
>> -    }
>>   }
>>     /**
>> @@ -279,9 +286,8 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> -    spin_lock(&vm_bo->vm->status_lock);
>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>>       list_move(&vm_bo->vm_status, &vm_bo->vm->done);
>> -    spin_unlock(&vm_bo->vm->status_lock);
>>   }
>>     /**
>> @@ -295,10 +301,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>>   {
>>       struct amdgpu_vm_bo_base *vm_bo, *tmp;
>>   -    spin_lock(&vm->status_lock);
>> +    spin_lock(&vm->invalidated_lock);
>>       list_splice_init(&vm->done, &vm->invalidated);
>>       list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
>>           vm_bo->moved = true;
>> +    spin_unlock(&vm->invalidated_lock);
>> +
>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>>       list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>>           struct amdgpu_bo *bo = vm_bo->bo;
>>   @@ -308,14 +317,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>>           else if (bo->parent)
>>               list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
>>       }
>> -    spin_unlock(&vm->status_lock);
>>   }
>>     /**
>>    * amdgpu_vm_update_shared - helper to update shared memory stat
>>    * @base: base structure for tracking BO usage in a VM
>>    *
>> - * Takes the vm status_lock and updates the shared memory stat. If the basic
>> + * Takes the vm stats_lock and updates the shared memory stat. If the basic
>>    * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be called
>>    * as well.
>>    */
>> @@ -327,7 +335,8 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>>       uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
>>       bool shared;
>>   -    spin_lock(&vm->status_lock);
>> +    dma_resv_assert_held(bo->tbo.base.resv);
>> +    spin_lock(&vm->stats_lock);
>>       shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>       if (base->shared != shared) {
>>           base->shared = shared;
>> @@ -339,7 +348,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>>               vm->stats[bo_memtype].drm.private += size;
>>           }
>>       }
>> -    spin_unlock(&vm->status_lock);
>> +    spin_unlock(&vm->stats_lock);
>>   }
>>     /**
>> @@ -364,11 +373,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
>>    *        be bo->tbo.resource
>>    * @sign: if we should add (+1) or subtract (-1) from the stat
>>    *
>> - * Caller need to have the vm status_lock held. Useful for when multiple update
>> + * Caller need to have the vm stats_lock held. Useful for when multiple update
>>    * need to happen at the same time.
>>    */
>>   static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
>> -                struct ttm_resource *res, int sign)
>> +                      struct ttm_resource *res, int sign)
>>   {
>>       struct amdgpu_vm *vm = base->vm;
>>       struct amdgpu_bo *bo = base->bo;
>> @@ -392,7 +401,8 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
>>            */
>>           if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>>               vm->stats[res_memtype].drm.purgeable += size;
>> -        if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
>> +        if (!(bo->preferred_domains &
>> +              amdgpu_mem_type_to_domain(res_memtype)))
>>               vm->stats[bo_memtype].evicted += size;
>>       }
>>   }
>> @@ -411,9 +421,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
>>   {
>>       struct amdgpu_vm *vm = base->vm;
>>   -    spin_lock(&vm->status_lock);
>> +    spin_lock(&vm->stats_lock);
>>       amdgpu_vm_update_stats_locked(base, res, sign);
>> -    spin_unlock(&vm->status_lock);
>> +    spin_unlock(&vm->stats_lock);
>>   }
>>     /**
>> @@ -439,10 +449,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>       base->next = bo->vm_bo;
>>       bo->vm_bo = base;
>>   -    spin_lock(&vm->status_lock);
>> +    spin_lock(&vm->stats_lock);
>>       base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>       amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
>> -    spin_unlock(&vm->status_lock);
>> +    spin_unlock(&vm->stats_lock);
>>         if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>           return;
>> @@ -500,10 +510,10 @@ int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
>>       int ret;
>>         /* We can only trust prev->next while holding the lock */
>> -    spin_lock(&vm->status_lock);
>> +    spin_lock(&vm->invalidated_lock);
>>       while (!list_is_head(prev->next, &vm->done)) {
>>           bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
>> -        spin_unlock(&vm->status_lock);
>> +        spin_unlock(&vm->invalidated_lock);
>>             bo = bo_va->base.bo;
>>           if (bo) {
>> @@ -511,10 +521,10 @@ int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
>>               if (unlikely(ret))
>>                   return ret;
>>           }
>> -        spin_lock(&vm->status_lock);
>> +        spin_lock(&vm->invalidated_lock);
>>           prev = prev->next;
>>       }
>> -    spin_unlock(&vm->status_lock);
>> +    spin_unlock(&vm->invalidated_lock);
>>         return 0;
>>   }
>> @@ -610,7 +620,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                  void *param)
>>   {
>>       uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
>> -    struct amdgpu_vm_bo_base *bo_base;
>> +    struct amdgpu_vm_bo_base *bo_base, *tmp;
>>       struct amdgpu_bo *bo;
>>       int r;
>>   @@ -623,13 +633,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>               return r;
>>       }
>>   -    spin_lock(&vm->status_lock);
>> -    while (!list_empty(&vm->evicted)) {
>> -        bo_base = list_first_entry(&vm->evicted,
>> -                       struct amdgpu_vm_bo_base,
>> -                       vm_status);
>> -        spin_unlock(&vm->status_lock);
>> -
>> +    list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
>>           bo = bo_base->bo;
>>             r = validate(param, bo);
>> @@ -642,26 +646,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>               vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
>>               amdgpu_vm_bo_relocated(bo_base);
>>           }
>> -        spin_lock(&vm->status_lock);
>>       }
>> -    while (ticket && !list_empty(&vm->evicted_user)) {
>> -        bo_base = list_first_entry(&vm->evicted_user,
>> -                       struct amdgpu_vm_bo_base,
>> -                       vm_status);
>> -        spin_unlock(&vm->status_lock);
>>   -        bo = bo_base->bo;
>> -        dma_resv_assert_held(bo->tbo.base.resv);
>> -
>> -        r = validate(param, bo);
>> -        if (r)
>> -            return r;
>> +    if (ticket) {
>> +        list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
>> +                     vm_status) {
>> +            bo = bo_base->bo;
>> +            dma_resv_assert_held(bo->tbo.base.resv);
>>   -        amdgpu_vm_bo_invalidated(bo_base);
>> +            r = validate(param, bo);
>> +            if (r)
>> +                return r;
>>   -        spin_lock(&vm->status_lock);
>> +            amdgpu_vm_bo_invalidated(bo_base);
>> +        }
>>       }
>> -    spin_unlock(&vm->status_lock);
>>         amdgpu_vm_eviction_lock(vm);
>>       vm->evicting = false;
>> @@ -684,13 +683,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>>   {
>>       bool ret;
>>   +    amdgpu_vm_assert_locked(vm);
>> +
>>       amdgpu_vm_eviction_lock(vm);
>>       ret = !vm->evicting;
>>       amdgpu_vm_eviction_unlock(vm);
>>   -    spin_lock(&vm->status_lock);
>>       ret &= list_empty(&vm->evicted);
>> -    spin_unlock(&vm->status_lock);
>>         spin_lock(&vm->immediate.lock);
>>       ret &= !vm->immediate.stopped;
>> @@ -981,16 +980,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>                 struct amdgpu_vm *vm, bool immediate)
>>   {
>>       struct amdgpu_vm_update_params params;
>> -    struct amdgpu_vm_bo_base *entry;
>> +    struct amdgpu_vm_bo_base *entry, *tmp;
>>       bool flush_tlb_needed = false;
>> -    LIST_HEAD(relocated);
>>       int r, idx;
>>   -    spin_lock(&vm->status_lock);
>> -    list_splice_init(&vm->relocated, &relocated);
>> -    spin_unlock(&vm->status_lock);
>> +    amdgpu_vm_assert_locked(vm);
>>   -    if (list_empty(&relocated))
>> +    if (list_empty(&vm->relocated))
>>           return 0;
>>         if (!drm_dev_enter(adev_to_drm(adev), &idx))
>> @@ -1005,7 +1001,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>       if (r)
>>           goto error;
>>   -    list_for_each_entry(entry, &relocated, vm_status) {
>> +    list_for_each_entry(entry, &vm->relocated, vm_status) {
>>           /* vm_flush_needed after updating moved PDEs */
>>           flush_tlb_needed |= entry->moved;
>>   @@ -1021,9 +1017,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>       if (flush_tlb_needed)
>>           atomic64_inc(&vm->tlb_seq);
>>   -    while (!list_empty(&relocated)) {
>> -        entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
>> -                     vm_status);
>> +    list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
>>           amdgpu_vm_bo_idle(entry);
>>       }
>>   @@ -1249,9 +1243,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>                 struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>>   {
>> -    spin_lock(&vm->status_lock);
>> +    spin_lock(&vm->stats_lock);
>>       memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
>> -    spin_unlock(&vm->status_lock);
>> +    spin_unlock(&vm->stats_lock);
>>   }
>>     /**
>> @@ -1618,29 +1612,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>>                  struct amdgpu_vm *vm,
>>                  struct ww_acquire_ctx *ticket)
>>   {
>> -    struct amdgpu_bo_va *bo_va;
>> +    struct amdgpu_bo_va *bo_va, *tmp;
>>       struct dma_resv *resv;
>>       bool clear, unlock;
>>       int r;
>>   -    spin_lock(&vm->status_lock);
>> -    while (!list_empty(&vm->moved)) {
>> -        bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
>> -                     base.vm_status);
>> -        spin_unlock(&vm->status_lock);
>> -
>> +    list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
>>           /* Per VM BOs never need to bo cleared in the page tables */
>>           r = amdgpu_vm_bo_update(adev, bo_va, false);
>>           if (r)
>>               return r;
>> -        spin_lock(&vm->status_lock);
>>       }
>>   +    spin_lock(&vm->invalidated_lock);
>>       while (!list_empty(&vm->invalidated)) {
>>           bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
>>                        base.vm_status);
>>           resv = bo_va->base.bo->tbo.base.resv;
>> -        spin_unlock(&vm->status_lock);
>> +        spin_unlock(&vm->invalidated_lock);
>>             /* Try to reserve the BO to avoid clearing its ptes */
>>           if (!adev->debug_vm && dma_resv_trylock(resv)) {
>> @@ -1672,9 +1661,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>>                bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>>               amdgpu_vm_bo_evicted_user(&bo_va->base);
>>   -        spin_lock(&vm->status_lock);
>> +        spin_lock(&vm->invalidated_lock);
>>       }
>> -    spin_unlock(&vm->status_lock);
>> +    spin_unlock(&vm->invalidated_lock);
>>         return 0;
>>   }
>> @@ -2203,9 +2192,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>           }
>>       }
>>   -    spin_lock(&vm->status_lock);
>> +    spin_lock(&vm->invalidated_lock);
>>       list_del(&bo_va->base.vm_status);
>> -    spin_unlock(&vm->status_lock);
>> +    spin_unlock(&vm->invalidated_lock);
>>         list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>>           list_del(&mapping->list);
>> @@ -2313,10 +2302,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
>>       for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>>           struct amdgpu_vm *vm = bo_base->vm;
>>   -        spin_lock(&vm->status_lock);
>> +        spin_lock(&vm->stats_lock);
>>           amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
>>           amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
>> -        spin_unlock(&vm->status_lock);
>> +        spin_unlock(&vm->stats_lock);
>>       }
>>         amdgpu_vm_bo_invalidate(bo, evicted);
>> @@ -2582,11 +2571,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>       INIT_LIST_HEAD(&vm->relocated);
>>       INIT_LIST_HEAD(&vm->moved);
>>       INIT_LIST_HEAD(&vm->idle);
>> +    spin_lock_init(&vm->invalidated_lock);
>>       INIT_LIST_HEAD(&vm->invalidated);
>> -    spin_lock_init(&vm->status_lock);
>>       INIT_LIST_HEAD(&vm->freed);
>>       INIT_LIST_HEAD(&vm->done);
>>       INIT_KFIFO(vm->faults);
>> +    spin_lock_init(&vm->stats_lock);
>>         r = amdgpu_vm_init_entities(adev, vm);
>>       if (r)
>> @@ -3051,7 +3041,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>>       unsigned int total_done_objs = 0;
>>       unsigned int id = 0;
>>   -    spin_lock(&vm->status_lock);
>> +    amdgpu_vm_assert_locked(vm);
>> +
>>       seq_puts(m, "\tIdle BOs:\n");
>>       list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>>           if (!bo_va->base.bo)
>> @@ -3089,11 +3080,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>>       id = 0;
>>         seq_puts(m, "\tInvalidated BOs:\n");
>> +    spin_lock(&vm->invalidated_lock);
>>       list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>>           if (!bo_va->base.bo)
>>               continue;
>>           total_invalidated += amdgpu_bo_print_info(id++,    bo_va->base.bo, m);
>>       }
>> +    spin_unlock(&vm->invalidated_lock);
>>       total_invalidated_objs = id;
>>       id = 0;
>>   @@ -3103,7 +3096,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>>               continue;
>>           total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>>       }
>> -    spin_unlock(&vm->status_lock);
>>       total_done_objs = id;
>>         seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 0e3884dfdb6d..96d9b8947409 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
>>       /* protected by bo being reserved */
>>       struct amdgpu_vm_bo_base    *next;
>>   -    /* protected by vm status_lock */
>> +    /* protected by vm reservation and status_lock */
>>       struct list_head        vm_status;
>>         /* if the bo is counted as shared in mem stats
>> -     * protected by vm status_lock */
>> +     * protected by vm BO being reserved */
>>       bool                shared;
>>         /* protected by the BO being reserved */
>> @@ -344,18 +344,13 @@ struct amdgpu_vm {
>>       bool            evicting;
>>       unsigned int        saved_flags;
>>   -    /* Lock to protect vm_bo add/del/move on all lists of vm */
>> -    spinlock_t        status_lock;
>> -
>> -    /* Memory statistics for this vm, protected by status_lock */
>> +    /* Memory statistics for this vm, protected by stats_lock */
>> +    spinlock_t        stats_lock;
>>       struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>>         /* Per-VM and PT BOs who needs a validation */
>>       struct list_head    evicted;
>>   -    /* BOs for user mode queues that need a validation */
>> -    struct list_head    evicted_user;
>> -
>>       /* PT BOs which relocated and their parent need an update */
>>       struct list_head    relocated;
>>   @@ -365,15 +360,19 @@ struct amdgpu_vm {
>>       /* All BOs of this VM not currently in the state machine */
>>       struct list_head    idle;
>>   -    /* regular invalidated BOs, but not yet updated in the PT */
>> +    /* Regular BOs for KFD queues that need a validation */
>> +    struct list_head    evicted_user;
>> +
>> +    /* Regular invalidated BOs, need to be validated and updated in the PT */
>> +    spinlock_t        invalidated_lock;
>>       struct list_head    invalidated;
>>   +    /* Regular BOs which are validated and location has been updated in the PTs */
>> +    struct list_head        done;
>> +
>>       /* BO mappings freed, but not yet updated in the PT */
>>       struct list_head    freed;
>>   -    /* BOs which are invalidated, has been updated in the PTs */
>> -    struct list_head        done;
>> -
>>       /* contains the page directory */
>>       struct amdgpu_vm_bo_base     root;
>>       struct dma_fence    *last_update;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 30022123b0bf..f57c48b74274 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -541,9 +541,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>>       entry->bo->vm_bo = NULL;
>>       ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>>   -    spin_lock(&entry->vm->status_lock);
>>       list_del(&entry->vm_status);
>> -    spin_unlock(&entry->vm->status_lock);
>>       amdgpu_bo_unref(&entry->bo);
>>   }
>>   @@ -587,7 +585,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>>       struct amdgpu_vm_pt_cursor seek;
>>       struct amdgpu_vm_bo_base *entry;
>>   -    spin_lock(&params->vm->status_lock);
>>       for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
>>           if (entry && entry->bo)
>>               list_move(&entry->vm_status, &params->tlb_flush_waitlist);
>> @@ -595,7 +592,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>>         /* enter start node now */
>>       list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
>> -    spin_unlock(&params->vm->status_lock);
>>   }
>>     /**

