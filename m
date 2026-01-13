Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31472CF45D4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 01:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC69310E2E0;
	Tue, 13 Jan 2026 01:49:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PpK1sWMU";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB4C10E2E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 01:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN09khepkTftyNN+qtYbREdalfBmnVRxfZDDCa4SufQi0chEtag0iHWkfz8pZshk+rvGdSARwZtwSzebCODxFgi4BL84vkaRdiQkWPD27skMiGXhO0ol9iZ1nJP75CKJjjSbrT2qSe0p3AateYfFf+AOHbz3/HxU0V5sjpHymnNk55+dtr2k8x3vBo+2zIVSIa49sg5oHADoT5xHZYo/Ml9B4bS/mqrLoBqd8YO53LXpGB6cGQ4uhF/Q1ObPjKhBCKLqXHt/wumcWmN8BQWTwPp1mDDfUEfLw5Ab2FDwSOWTYWNhcW7/grPghe+ooqAO7pN73WJ+kEiwqy0J4DvM7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkMIUUU3VrIcgNK/Fp1TG3jfOlywB6TGcH5cavWKEDg=;
 b=Rb3LKAX3oA67sPZeHms9Ry1kS+I3s0CO6BlCaFGTVkvkKCbx8sDc4UiDZ5de6ixfUEbKpfCH9E1E9ck1xdg88AiTKmgGolUkgxDcibnVNDp2NX9HhLqB2irl0SPHTeO6ZnVBtzDmwMwSG9bMqSy8iXuPHNd7a6LezbzLnHsjMw9/YS1LPvZsGnF1n7KF6jFXpDUcTVSOiykiTtWWVxlBVRA+MkG+if0BcEFs4umJjywVlloHPP7YV+VeamBBSdLzdIBP9rl0bAJn0NvVGd8IjjvzkDjiohgNZD8mZFeoNcIHHJKMtBRVXymbq1nr77K29EkdG4VX5rB79EXV1QakmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkMIUUU3VrIcgNK/Fp1TG3jfOlywB6TGcH5cavWKEDg=;
 b=PpK1sWMUBNjdnArce4d+GitW6PncWKefHZscmOseaMDix2WlXjur5TIMGH9z3s1tMv/gc91AEj76ki2LPg1QsnVoRggy6C7Juwlzp4QLgwW4/usfVreJCmPNX/lxDpFlS3hxRraK3WYz8FaU304Fx7qil14ZikiQyYaVvZhIv10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 01:49:39 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 01:49:39 +0000
Message-ID: <f2d12450-e4dd-487d-8d33-e482b8a32db3@amd.com>
Date: Tue, 13 Jan 2026 07:19:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix issue of missing '*' on pp_dpm_xxx nodes
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20260112101247.2654442-1-kevinyang.wang@amd.com>
 <03788e07-8f4a-43ca-b455-d852546f0988@amd.com>
Content-Language: en-US
In-Reply-To: <03788e07-8f4a-43ca-b455-d852546f0988@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::24) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3b0d41-f806-4ec6-2a30-08de52460383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTNnR3IvOHI1RDBGbU9wTGxKY3MrWENQdHV4eUNpRzRmaUI2QzRrMHMzc1d6?=
 =?utf-8?B?eEtGb2ZxeFBJQkNBQWlRUHliU3hDNEk5QVFXaVQ4NmM3RUo5OU1iaDE3TFkr?=
 =?utf-8?B?QndpMWpHaTlzL1dVVUoyT3Q1WDhJTUNqSXdteHBqWHFvQ2IyVUxRYU5kZC9v?=
 =?utf-8?B?M2IyTEsvaUZJUk9ZaDlPQm9aLzVWU2hnak0rQ3JTb2VlYzVjMC8zMzk1Zkd0?=
 =?utf-8?B?SE5qTkxVQmF5cWRGV1pSZXpmUmdBSHAycXl6Rmo5LzR5UDNiWnlvbVFmMUxN?=
 =?utf-8?B?bTFFcncrQVczd3RLcDlOWW1Kb01uNEt2d2tjYjYvdkx4UUQwcW1DTE1HQlkr?=
 =?utf-8?B?YklhM0pQTjFXR2wrTWkyc0YzYVlFam5RMnoxcko1OU1Ld0lTZ2Rqa3VPVmtG?=
 =?utf-8?B?aXB6RHV0RXNwbnhqTGY3NU1ZTkw0Y0pNbGFqMDlkaG9FMktFRnFVQXlIaGNk?=
 =?utf-8?B?VnpTRHViRlRtS2svR3VTaGYzYy9JUGNBeWoyYngyRHdYQWU1cW5DTDloYmFL?=
 =?utf-8?B?TGlaQVBzQU4vb2dEUXZNWFdFU09HK0pNeDluUEo0VkUxNUpKejlDSXo4dXlq?=
 =?utf-8?B?V2lodHpld2hDakV1RFhLRWtmQ3FKQjNiakVLdWNaOXZQTGVZQVhSbk50czZt?=
 =?utf-8?B?TGRBdk0xTnB0NWFpSUdObjhKWU9VR1BBTm5hcWpHSHBDeTQveUJHbVk3RjZy?=
 =?utf-8?B?dWU3SFowNERtMVdpTEVEckFxVUo5RFlDcWxCbVZjcUJrK2V2V1dzU1N0WmZK?=
 =?utf-8?B?TUJpWWltWWJ4RXZaaWRGaDlxWE1HcVRmblRGd3BPNmY1NHJlQktMNXJocE1a?=
 =?utf-8?B?dG1ZNjlJVkxjcTdsdEJ2dlhPUy95Rnd2cWhsOHZxTkVUaDBOT0FjMlpVQkxC?=
 =?utf-8?B?L2dGdUoyd0VERTN0YlhFakZRU251T3NhYXpjTjlTVlduYjkyQkxYTmFOVWJB?=
 =?utf-8?B?cTZWZ1FIYzFIWDFQTDZwdC84MVB0ekxLRUE2enczc21PUjk1VVJaMXZxWHJt?=
 =?utf-8?B?UWRxWTRCMk9NaVIrM3lMSHBtaGFLbStiUzJDdXRvcWlHLzNKdFl2WE9HOUhZ?=
 =?utf-8?B?VStDa0Flc1V0VWVaTVpoOCtuZDlBV2lZOFFrMUJVSEhaYzc5TmZNQk80a29T?=
 =?utf-8?B?SDlLUUw3Zm5zT2hFSU5QYVhSNHA5UnlVRUdyYmp6YTdERVVnTTNZUk9mNlgr?=
 =?utf-8?B?T1c1UWQ0Z1o1aGJvMEU0SVo1c3BqU1VjRDNsNCtOSmhXNFFma2lNWUttQ1Vh?=
 =?utf-8?B?Q3VOdjBFOENpVnNpbnFwM3AxSEZ2VWZVQ2swWXQ5REl5N2gxY2VEN2NTVndw?=
 =?utf-8?B?ZjMzemxNSnZqdWZoVGYxY0pNSkUrQzZ6aVIrNjF6d3FUemRwY0lGazZoRGdN?=
 =?utf-8?B?eGpKN0ZSMThQRk5sV1loM2YvZGMxOHl0ODYzNys5emtNcnJsSlM3cVFVQ05M?=
 =?utf-8?B?eG8zMldhanltK0NvUG8reXVYRXZsanRPOGJBblJKZEpvRWc3NktFTU5uZ2tF?=
 =?utf-8?B?dTZCK1FFUlhJRGNDWlNQZmNpVVcxVktmRnVLbjRPcUIvd0N3elBLRFNKODRB?=
 =?utf-8?B?TGViUDd1VUhXaTFGdGxOT2VTWEFIQ3huZE9pWUU3K2phWU9oRkU4dE4wN0ZY?=
 =?utf-8?B?TUpHUDdka2RqOXgvWkQ2UFJHY3hrR0FuU09NakFLZzB1MGh3RVRZaytic09I?=
 =?utf-8?B?NlhEeXErQWVGQmd5TVpoRUJxSTBXSVNtbkt3emVraXNkZ21jUEtsZmVjeWRG?=
 =?utf-8?B?UkM1UW5yS1BCUU1CUmFXV1RIb1VKcGlVMlpqbWVEMDhrVjY3c3o4c1lBREdw?=
 =?utf-8?B?WTJUa3NxamQzb1kwL1Z6VHRZNmtWQ2FkU2hVdjVaSWU0eGY0MXNaOTFtTjR2?=
 =?utf-8?B?SkpicjZZZ3E4V0huVUY0WWdwaS95VVJCSmY5RTBaaGhiNFZzOVJsWlhXNGZ2?=
 =?utf-8?Q?Zs0A9Lk/lbWXaEznXWH79s1tHGHgcrhX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkxxOGJrWFp5WE9kYVc0WmxSbkJIZXplTkVHU0x6SlhMTGM3bHMwTEtmd05a?=
 =?utf-8?B?T1I1VU1DdXZLL2Z6Nkc0ai9FM2VVY3dOWEV3dElqcXcyNG9mUVhYN3dIZmV5?=
 =?utf-8?B?alJDNXJ4ZjVpckpPUEFzN21YS1hmZlc3NjV3OFgwem5yUGJyVVlKa3J3bU02?=
 =?utf-8?B?RlJtTkxwNFFKeG5oWkVZemNmb3VOL01LUGdMcTZqU2oyV2tOTUc5ZEQvVE0z?=
 =?utf-8?B?K3c3TGF6Rjg3ZEpRb1Y3OTB6Y3Q0eWJKdVZENzZlUUg3Mk9DYUVzd2dnclNy?=
 =?utf-8?B?VFV5SmdqaWtnZEdlODRiWEhGV1ZveHU1MjNsNmZVT0hNd2J6cSs5d3l0MVgv?=
 =?utf-8?B?QlVNWkxRU2owTWRZZCtieEpTRE9ZQ25oUUFPem5QMjVYbU1wNDZqYkJzUU96?=
 =?utf-8?B?ek5YQU5YUjdybXFCSXBuNCtYT0xrdG9JV0drbXZtREcwUE41TnNCV0V6UTBU?=
 =?utf-8?B?Vk1ZTm16L2dtaVFhUmI3ZkhKeS83M0tRNzhZNHRyY3JtSCtrM3ZWaGFjalFY?=
 =?utf-8?B?T21sYm5UVW5uNkh4TENhKytTQW82am1CY0JIMUdRMFpVYlplYXNwb081WWgr?=
 =?utf-8?B?S052VEFvOEx0Z3VmT3FEM0g1M29ma3l2S2g4dWpCMW9WRGY3dTB2bU1OTjJN?=
 =?utf-8?B?MWUwRWxrMlNORFlYSHJOQ1ovTFhtYjJ5T21MbzBJdk5DMEhHVlVqcG9YYUVl?=
 =?utf-8?B?N2NXbXFldG9KUCtkTmtXYjJ3UlVRSGUwQmtoajMwanhnRFpxOGpQaEhYanBX?=
 =?utf-8?B?SUJUd3Rrb1UxQjVTUEsyWXMrZXZtOWNBZU5UcjljbWxVMzBqQXQ0TTUvQWFn?=
 =?utf-8?B?K3dLRFFKdE13cWJpcUZKc3N5bXEvN1dJeFRhNFRyQkpraW5UR29uS05jaVJG?=
 =?utf-8?B?bFpTYUdNMm5jSU9GZ0Z2bUFZRGJCUnFHY0NNdXF0Vmx1THpXYWpkN254cVdO?=
 =?utf-8?B?RDZIUlJNbUg4bmlzamZWMEw5a3hlUmpSRU9rUVpqV2N4MUtUWXBDNG5LanBS?=
 =?utf-8?B?MTFiOFRmMGhqZFVQRXJ1akwyYTdBK3QybmpKQzR5c1plYVRrdDJvYUFIQnBp?=
 =?utf-8?B?WmlXNjdNbm5XYkd1Qys4SmJDMElzQmxuMDBJbWl1N2dHQkZYSjZUQUJmWWZx?=
 =?utf-8?B?WFdXQW50eDlpdi94aVlTWld6bkxTWURReWVHeWVYK2ZqN1ZVb3NlaG54Tkhj?=
 =?utf-8?B?c3hKbG5veFpFWXgyUGxEK3Z1OUxrR0dSZmxIOFJqWWJYUVM2M3l2UHJBK1Ux?=
 =?utf-8?B?SFl1VitaSUI4enNSSXZ2bXlCc2xCekFIakk2UWZCUTZzaUdUdjhRRGorRERG?=
 =?utf-8?B?S0UyaUZPanpZSlovcnBBVDZPdllXTGljQjRFcEVNaDg2Z0grVXkvNWdMbnhC?=
 =?utf-8?B?UUxRM00rK1FUQzBta0VFUi9xTzZqUVMxaEVzT25QYllBbzBWTGFUb0pMSFVw?=
 =?utf-8?B?aWlGU0xwZ0hXSG5oRWF1Q3VXczZHZGx0ZUgyc21uZEhybmdUYm9PdmlTb2pq?=
 =?utf-8?B?TlVVTlZOMEVTM0hYb2RhZ2lnclVCWkVhc2M3RGFzWUlnR20xdHNsSHN4NElt?=
 =?utf-8?B?ZjJKb2JYdjFFRlhpWFBoL1JRUVUxWXlINjBYYWQ2Nk8rckVHcWtmamQwcUdP?=
 =?utf-8?B?U2FZVHd2SlVZaWlFSTNxRzR1SW5aUm1sdFlwamRvUVI3WFFvZ1VVaS8ydkk5?=
 =?utf-8?B?aFUvNnRwYVVMWnVzWSsvTEVDaWFMekVpUTR0VkZYcXQ1U0grKytWUjVVY1ZT?=
 =?utf-8?B?K3M2VGFWdjdrNmI0UVM4RGt4Zy9YdzQzbncvRXg0eEd2eTVDUHc4bExxSmxZ?=
 =?utf-8?B?TjJaVGZyL085QXZxRzFvSCsrSnFLOGJibm8yS1ZBa0diRzc4MzFyd3VDY09F?=
 =?utf-8?B?NFB1cWsxVlN1czBGMXA2b3cwMk9IcXJyVXMvOFFqVHdyaFYwc3o5RUNrWHBU?=
 =?utf-8?B?clFScDczUXJBUS9yTXBqeCtlK2V6R2dtQVFXWDFMSHdPUm4zaTFseElrYXYv?=
 =?utf-8?B?bTdaZ3VkcTdlS2NHU0p3STFubllxL3lLT1oyMGF6c0lYeGYwa0laRlh1YjdQ?=
 =?utf-8?B?c2YxdVFLMnZXNFlna21iZzJpMWdTSmlEYzVraDRzb2VqeUx4ZEhjVXE1Ylg2?=
 =?utf-8?B?TWN1ZzhmMUFKay92SWtaRkRXVlJSOXErNVo3QkdkVDB0QjBvV2pmNXUrQ0Ur?=
 =?utf-8?B?SkU0U0c0TWJiWlN1d25QU2VGVEQ1dlozY05EQkx1bkxack1xditMWU9rcC83?=
 =?utf-8?B?YW4zZHhyaU9lY0thalR0OGVRajIvY2JFMXkwNHlOY1duOHc5dHMwazRhclFp?=
 =?utf-8?B?T2NzdGdxRzhzYllCa3YrM0hzVDNZWTN1OFppRDJ6dUZFaGgyOTFlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3b0d41-f806-4ec6-2a30-08de52460383
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 01:49:39.6623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS/AJAHtvDAQ9dRnE1s89lvlYkYHDNuomFa3iRh77L3QutvVZIGSquzL56Q0H1ou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
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



On 12-Jan-26 4:53 PM, Lazar, Lijo wrote:
> 
> 
> On 12-Jan-26 3:42 PM, Yang Wang wrote:
>> refine the code to fix '*' missing on pp_dpm_xxx series node.
>>
>> e.g.: missing '*' on navi10 pp_dpm_sclk
>> $ cat /sys/class/drm/card0/device/pp_dpm_sclk
>> 0: 300Mhz
>> 1: 1930Mhz (the symbol of '*' is missing)
>>
>> Fixes: d259c895d622 ("drm/amd/pm: Add a helper to show dpm table")
> 
> This fix doesn't look related. Could you also add the sample values 
> under which the existing logic fails?
> 

Never mind. There is indeed a bug when current clock matches max clock.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Thanks,
> Lijo
> 
>>
>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 31 +++++++++++++-------------
>>   1 file changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/ 
>> amd/pm/swsmu/smu_cmn.c
>> index e0a508653b6a..60fc730bf81d 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> @@ -1210,11 +1210,11 @@ int smu_cmn_print_dpm_clk_levels(struct 
>> smu_context *smu,
>>                    struct smu_dpm_table *dpm_table,
>>                    uint32_t cur_clk, char *buf, int *offset)
>>   {
>> -    uint32_t min_clk, level_index, count;
>> -    uint32_t freq_values[3] = { 0 };
>> +    uint32_t min_clk, max_clk, level_index, count;
>> +    uint32_t freq_values[3];
>> +    int size, lvl, i;
>>       bool is_fine_grained;
>>       bool is_deep_sleep;
>> -    int size, lvl, i;
>>       bool freq_match;
>>       if (!dpm_table || !buf)
>> @@ -1225,6 +1225,7 @@ int smu_cmn_print_dpm_clk_levels(struct 
>> smu_context *smu,
>>       count = dpm_table->count;
>>       is_fine_grained = dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED;
>>       min_clk = SMU_DPM_TABLE_MIN(dpm_table);
>> +    max_clk = SMU_DPM_TABLE_MAX(dpm_table);
>>       /* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0 as 
>> GFXOFF */
>>       is_deep_sleep = cur_clk < min_clk / 2;
>> @@ -1245,22 +1246,22 @@ int smu_cmn_print_dpm_clk_levels(struct 
>> smu_context *smu,
>>                             freq_match ? "*" : "");
>>           }
>>       } else {
>> +        count = 2;
>>           freq_values[0] = min_clk;
>> -        freq_values[2] = SMU_DPM_TABLE_MAX(dpm_table);
>> -        freq_values[1] = cur_clk;
>> +        freq_values[1] = max_clk;
>> -        lvl = -1;
>>           if (!is_deep_sleep) {
>> -            lvl = 1;
>> -            if (smu_cmn_freqs_match(cur_clk, freq_values[0]))
>> +            if (smu_cmn_freqs_match(cur_clk, min_clk)) {
>>                   lvl = 0;
>> -            else if (smu_cmn_freqs_match(cur_clk, freq_values[2]))
>> -                lvl = 2;
>> -        }
>> -        count = 3;
>> -        if (lvl != 1) {
>> -            count = 2;
>> -            freq_values[1] = freq_values[2];
>> +            } else if (smu_cmn_freqs_match(cur_clk, max_clk)) {
>> +                lvl = 1;
>> +            } else {
>> +                /* NOTE: use index '1' to show current clock value */
>> +                lvl = 1;
>> +                count = 3;
>> +                freq_values[1] = cur_clk;
>> +                freq_values[2] = max_clk;
>> +            }
>>           }
>>           for (i = 0; i < count; i++) {
> 

