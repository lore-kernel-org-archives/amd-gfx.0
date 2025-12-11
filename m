Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D244ED3E78F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 06:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A91810E0D6;
	Thu, 11 Dec 2025 06:08:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5BDakgHv";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D348410E0D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 06:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgmlIrgGP+RHzOFLTWge4yoCIXYf/TLLroueooKEPUxuirZcuqZlmCipMs8zxpqHUo2P2niHSavhzS6FxHjWxTubeh1SGQCXdP00iSxNxbXO7ZIGBs7uQ/Ft9J7IE4/SNKQEDCJh6sHn+ubagAjWgrChkC4RCIlYtSyc8wbSsffHXQumeTsWpF/1bKWyMeFkkKX2WwbxzajJ1eSWaoNa0eiar210b35QAAWKNlku54sMRNyLmcGsfyy0EopNU6BRS8HUehxq4N2DwhKn2eqLzt3+0AgR6+wXPcmnhvixgnxETF642EL/iPfpVNa7pxCs/8vlw66qSyEmJfF6xYnDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbcUekpEVC69meC7wp8fbnwxIRrsypGuyDqBP/JW+9k=;
 b=OASfoQHSnzxFTSfuJNo+wtMg7svxvBW38opyUA1pxXISHOYNk4mUqSzUkCyv0ACiqJHbDpjI1s8GRR8Ns2vtlxQ4NMh+WrJT2Us9cOdYwXyQtmXNs+JT6i9ZRfMmaf3nnfJrCcC0HOKxEWggvyRObZ4wMoVs10vMnSYATa9Q7UF1CGbeKm8WhMGkGNSX965m/w5dH0fNOyegMSvO9myUXKXgEQ0fN8r6eZRHPPJ18g13JhxaBiEjN1eXdrqFvl9K9ueSoRA0cQkzomC5JzRuFCFKWm8l16ijuoo4uvA7KPpqbQClmBhzthDuh2A6455PqNmNaS5ViMsBtYNWLR5USA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbcUekpEVC69meC7wp8fbnwxIRrsypGuyDqBP/JW+9k=;
 b=5BDakgHvvQeRj63Xh8Rp3iLbhVUcepiJUpi7Yq8+z7YNmoBPGL7kdRWWFGFn+RyE0ypQj6maCmcA+guQVTUtIgNQHB2ZH+urxJWrNVHktmTr7c25NOzY8YgaNRIkRWr/4hO+xqXF1KGrYfXS6ySnicLFaJm0kZaqA70N0JULedI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 06:08:05 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:08:04 +0000
Message-ID: <89b93863-b8ef-4629-979c-5a3d1e906594@amd.com>
Date: Thu, 11 Dec 2025 11:37:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
 recovery
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20251210202347.63243-1-alexander.deucher@amd.com>
 <adf41aa5-3172-4e9e-9bfc-c8b853b7c0c0@amd.com>
 <IA0PR12MB820858B3F15710B5E2C6255B90A1A@IA0PR12MB8208.namprd12.prod.outlook.com>
 <14ea9e1c-0deb-4d2b-8bea-ef95300b753c@amd.com>
Content-Language: en-US
In-Reply-To: <14ea9e1c-0deb-4d2b-8bea-ef95300b753c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::25) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 84472fca-cae2-44d5-1759-08de387ba571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmltOGp0dnQyY1Vnckw0VG40eURPU012ZXU1MkM5ZS9JYWxDaTRWYSthQTI0?=
 =?utf-8?B?Y2UyVnF3Yk1jcThiZ1dLd0tEeDd5ZStWMDBXY0t2MTlyQ0ltM1NUWTMvUjlH?=
 =?utf-8?B?eXVNOWRRejludHdFTURRRis2djdkekpETTl4eVhKdllmRmZQUjRVTXFuRDli?=
 =?utf-8?B?c2U1dkhDWnVzUU03TzFrTXhHWWVLS0pLQ0xSam1uOXdGMzU4Ty9WU0tOVnpK?=
 =?utf-8?B?aDZZM2l4Z1hXUGxRaEVocGtLQldzenlaSHExWXBOOHluTU96KyttZCsrbmor?=
 =?utf-8?B?R0lWK3VocnBrY2o2Ky9VNTI4UHVEdlhrWmwrMlZFL05yQllqaTkwNjVGVnB1?=
 =?utf-8?B?Vmg0TmY4Y3J1bHozQ0hhS1hGL1ZoSlkyeVFld0wyb3ZBQnArQ2diQ1F1SDZv?=
 =?utf-8?B?WVVjd0pWcklNVitjaEFCK1Z6dXBDVTcvekJqeDhHZUhpMGZ1UnNKY05iODBn?=
 =?utf-8?B?ajBDekQ3R1g4akhPaXFDa0h6eFpqV0dtdFdXODFobmE4WUtDM1I3cDhkM2lS?=
 =?utf-8?B?YU1IMHFlWEMwNzNHMUs5UWtoalR0eEtFdHpsaTJudURjUHhTdXIyYVNXeFYx?=
 =?utf-8?B?YTBGVWpsaCs4azVpY1JzRlN6czV0ZTFXZGRvanFxWWE1VlIxVFMvV0tWWGtu?=
 =?utf-8?B?U1BRckVLQW10NmRBM3NMSU9iK3dkWDRiVGJtRkVpYWFTU2tmdDBhVDJwUmNE?=
 =?utf-8?B?ZUJTNlE4RE9qbkx6N0hKRHh1bkhWOThQVXkyVkttdGdBdG8wUHBDdE95M3Ni?=
 =?utf-8?B?TFZNNTYyTGc2N1JmU1NRNWc2S0VDMHd4NGovOVFPNk1NZmVXUVYxREdMOXl3?=
 =?utf-8?B?Z1QvL3VkSXBjQXNEai9GdUxHM3RsWHZZZjllZ0NDOEJma092UElKUko3Nkd4?=
 =?utf-8?B?d3dCcUo4M1doY0lKUEJ3T3Z1R1N5VVBLMnBGdTIvOU4xblV0Y2dXUGExZElH?=
 =?utf-8?B?REFLV3ZsbjRySW5GclE0S1F0eWtibWJvYUxSYy9YK3NicGZTUTJBWnhBRExn?=
 =?utf-8?B?bWxEUDVIeTl2Z1JCdnNKeC9yU3RaWVora2JSdlJUeEZPSENkRzFtN2NwSXU5?=
 =?utf-8?B?dmR6bFRWaFkyUWtaYWdQbnMrU3gzTHhLWUxoZEFtTVRTTzFJZG0vRVNzdlJx?=
 =?utf-8?B?WmZkaEx0dmxEbmNjZ21pT0tlT0I3NzdMY3ZuUXVQWkZsSHZpMVN5b09SbWZY?=
 =?utf-8?B?QkNpZWRmSzZsR0ZpcjBQU2ZPV1cwaWthRkY1eE04WVE0Vkk1b0t5T1FTdEF0?=
 =?utf-8?B?L0k5cDlKemVNR0p6cVB3aEtqcEhMMGxMazJVUmEvUHUrR3FjMFFVTVZYZnU2?=
 =?utf-8?B?VzQ0aFJuSFNFL1E3NG5uZUVKZEhlSTV1RmlOcjRWVHh6Ui84NnRrcm8yUzRO?=
 =?utf-8?B?N1Q2THJGQUxsWHQ5Y1cvOGs5WWVybnhVRGU1bm5qUnAvcjZGak5XRGs0OXo2?=
 =?utf-8?B?R1EwdnF1ZWhaT3BEdkcvSU1TbklHbzVJR2luajc1OXhsamNTNFJLTFhuK09p?=
 =?utf-8?B?M2xRV1J6YWlNNmhKM09lT3h5eC9iVmdrM0dVdjN5L2swb0tRWlk1VkJOeUR2?=
 =?utf-8?B?ZHpBT29OZjhEM2l4eGxkRDlxYTlMbFFhbXpwV0IxZnpBaDNGa05zYnp5d0xi?=
 =?utf-8?B?OGNSNzlNS2VVaTYzYlEycXRLdTBHY01OK3VEREhyZnl0RFR0QXN4ZlQxQ2dD?=
 =?utf-8?B?QlR3eUFNV3RQa0tMRTFwaTQwUmEvbG9wK01zU0VnTGhiWEpvTWJtRjZ5aHUy?=
 =?utf-8?B?eUFjZWMvNGxWZEsvY0liK2RvVTJSUXdJRDF6NGtqU3VLRTlBbE82NERvK1dq?=
 =?utf-8?B?ZHB6c2dsQ01RYTh6eFc3NHd5UExIL1dXUVc3WThGazgrd3p4OHFzZE00S2Vo?=
 =?utf-8?B?anNxSDdnQUhJc1cyTHFMNFNEb3dqVVRZNWxmM24ydHoyN3dHUHFaa2NvYUda?=
 =?utf-8?B?K21wNnUrZlJLZTZiODVwUkwrT0pScDFyMjFKcUp1U016U1pEb1RzZTR4eU9w?=
 =?utf-8?B?VzV5cmJMaTZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm9XWThnalVwcWExRlo4bU1sSGkvU2R6cm5Pd1NJZDVsbkFvOVFVVWtjTVdG?=
 =?utf-8?B?YVp0Mm8rVlQ1SlBoU0kxdGV3MjAwc3MvR29rZ2h3WGRGUy8xLzYxV0c2ekVj?=
 =?utf-8?B?NEJ6aVlBT1NOV0dQcTFvZEFxdHNJMHVuQkQ2eDRzYUJ2SFhUZEpueW5kZG5M?=
 =?utf-8?B?QTF0aFVKL0ZXU3hjUzJqMmlubys4dWtsU1JQeGRlOW9tbTNIWkJZbkNGS2xJ?=
 =?utf-8?B?QTA1RTZ5c2UvbEw0TENIY0xhTk4ydGs4ejEycURhRUo1VnEzcnk1NnBaRmN4?=
 =?utf-8?B?K1lvVng3dGhGaHF0cnJMbVI2bVhuY0gwcDNvVWZPMkpkSHo1bVpzQWljUERv?=
 =?utf-8?B?SitmaEE1bUhhNU0xMGpjcU0wL0NjOVorZWRVYVRDdzhWMktSWnV2M2gwdHVy?=
 =?utf-8?B?NlhmbitKZ3gyemFkRE1TV1ViazhsVXhxR1l1UElsSzF0Uk0rU1NtYXBHOExv?=
 =?utf-8?B?Rjl4UFUzQ0J4Q3NEdE1IN3d6SFZ5WEVBdkxTU2NwUEQ5MTlCTzA4NzNMQ1Ji?=
 =?utf-8?B?WmgvdHNtOXF0Z1hMWkVtSTErWUxsaVVTK1VtazZ2aXFUL3BpWTdiTmhLMGEr?=
 =?utf-8?B?MThrL2t6ejM0VW5GZnVxM05wVEtEUEc3SDdaNEg3RUI4SmtMOFZyZlAyV1cz?=
 =?utf-8?B?U0NrVi9RUWgrRFVtREsybmhxV1krNDBzY2RRb1J5ZW0vTWhSRnNDQXpSRlJP?=
 =?utf-8?B?UUx0VkZuWUljNEVSclhFaVovWGhUQ0hxbHUxc3Q4SW93Tk5FM2JMQzJhckRO?=
 =?utf-8?B?MjlmSVNVMFhBVmRIUGJDK2FocERLcGhKcGp1K2hoc1doU1BKbWNKbUpaaGYv?=
 =?utf-8?B?M2hFQm9jbEs2bDdHQ2JrVSsvWVNyM1VlTE8xTHZ5U3Rwa1RNVG9oend4dVpH?=
 =?utf-8?B?d2pBa2p4SWRmeHFHYkx3MjBadEQxcnJuZHlvTHQyVU5DVDVTMTh0cGxlb3ps?=
 =?utf-8?B?d0NJZzczNzR2Y0FBSlpwWXFYVVE3L2g5TytQaHB5NnZpb2h2d1B6dzBkanNo?=
 =?utf-8?B?emlGUDlJYTkzWmdrUUFQNkVuZ3lzdm1qSk1JeWhZSU45S2kvSXdNMFo5YW03?=
 =?utf-8?B?djJvK1lYb3FRbUNVa2c0OVdoTXBtSmhLQzlBKzNqbHJud1ZzQ3pHWWh4SXJU?=
 =?utf-8?B?NTMrekJYc3JUQW1aSWxIRmRlRnFoUmVsdmM2dzVFVFhodXdlUUxOdVhQNkdY?=
 =?utf-8?B?ZjBBK3JOdHZkMUpIdWpKMjkrQ21RVFBpRUpBZC8vZ1RyVVhUL2NwUm1SMVZM?=
 =?utf-8?B?SzVPUDFrTkUxc2IxMVVkOGswd0lveHE5REJEcnBZZVNoT3ROd0lwTGdhL3RN?=
 =?utf-8?B?R0JEaitGbVlxbTNYOUVtUWFmYzdSODl4RGJ2Y0VxOG56dVVkVXlBVTRHY25Z?=
 =?utf-8?B?L29oeXlHaTNDUFh0dzhBR3BqQWVzaTZDaGlIZEtXOUs1dThpdUJCN1ZCNyt6?=
 =?utf-8?B?d045dFlSQnJlQ3phWVVyY2Z1UU9oUWJKOFl3N1JVTy9Fc2VTWDJ0VS9hSndk?=
 =?utf-8?B?WVVFb0VGVTVuWjlUcVdUWHdmRzJvcDdrTW9BVTJEa29UMURoWnZnZnJXQ1hq?=
 =?utf-8?B?Q28ySFk0azIzS0l5RWpBeEg5VE5rWWd6K2JFSFVMc1B4NlJWdkZ1cEw2V3FS?=
 =?utf-8?B?ZTFFeHY5cWVUVVduRnJlaWhLY041K2NKL2hWZWxZbHBjSWVtY0dmKzVUaUdJ?=
 =?utf-8?B?ckYwUFBDek04L1AwT2RMYWNXaVZJQlNvNzFkdExETTlKaEY2QVExQ3BlUzRY?=
 =?utf-8?B?UTdSckhnNVJld2dPcmpTVFJlTHVabVBVaElrWGlmQ2NzYm51VHJ1UnNNQ2hM?=
 =?utf-8?B?REludnIybDYxTDdXYlVQOUNkZSs2SnR3MXI2cDlkdklmSmhDUUsyMGx4NWJu?=
 =?utf-8?B?VjI4T1BzZVlTeFpBbmpqUFBMZEZwSmU0SkEvNWtuOWZlNGJOYkN1d3E3RWd0?=
 =?utf-8?B?cFRYRnRIZ3djZ0tBMkhvUEdnVTNKYjRUdldxREdqN29jK1duTzZOZjJqaGJx?=
 =?utf-8?B?UVorSW52cXZVbGliS0lWVm9IS1JEMWZDVHlkQ2N5bmlISkV6b3VlSHYvWFls?=
 =?utf-8?B?T1p1bFZIQzM2SUxPcTMwVGV3NXRpK0w2UGZVazJZN3BrRDh4TGU3ZlJRN1Jz?=
 =?utf-8?Q?Rq4QNOlSWj2TQVXWpdM4vFUUe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84472fca-cae2-44d5-1759-08de387ba571
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:08:04.4344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTxLEX2UvRJeSwHNTgEM1Idkr9CH5KTqyFbltAwPVmikrb0XziRwPTkPFbgxvssD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084
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



On 12/11/2025 11:14 AM, Lazar, Lijo wrote:
> 
> 
> On 12/11/2025 10:52 AM, SHANMUGAM, SRINIVASAN wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Thursday, December 11, 2025 10:34 AM
>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>>> gfx@lists.freedesktop.org
>>> Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>> Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Matthew Brost <matthew.brost@intel.com>
>>> Subject: Re: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
>>> recovery
>>>
>>>
>>>
>>> On 12/11/2025 1:53 AM, Alex Deucher wrote:
>>>> Avoid a possible UAF in GPU recovery due to a race between the sched
>>>> timeout callback and the tdr work queue.
>>>>
>>>> The gpu recovery function calls drm_sched_stop() and later
>>>> drm_sched_start().  drm_sched_start() restarts the tdr queue which
>>>> will eventually free the job.  If the tdr queue frees the job before
>>>> time out callback completes, the job will be freed and we'll get a UAF
>>>> when accessing the pasid.  Cache it early to avoid the UAF.
>>>>
>>>> Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
>>>> Cc: SRINIVASAN.SHANMUGAM@amd.com
>>>> Cc: vitaly.prosyak@amd.com
>>>> Cc: christian.koenig@amd.com
>>>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>
>>>> v2: Check the pasid rather than job (Lijo)
>>>>       Add fixes tag (Christian)
>>>>
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 8a851d7548c00..c6b1dd95c401d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -6634,6 +6634,8 @@ int amdgpu_device_gpu_recover(struct
>>> amdgpu_device *adev,
>>>>      struct amdgpu_hive_info *hive = NULL;
>>>>      int r = 0;
>>>>      bool need_emergency_restart = false;
>>>> +   /* save the pasid here as the job may be freed before the end of 
>>>> the reset */
>>>> +   int pasid = job ? job->pasid : -EINVAL;
>>>>
>>>>      /*
>>>>       * If it reaches here because of hang/timeout and a RAS error 
>>>> is @@
>>>> -6734,8 +6736,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
>>> *adev,
>>>>      if (!r) {
>>>>              struct amdgpu_task_info *ti = NULL;
>>>>
>>>> -           if (job)
>>>> -                   ti = amdgpu_vm_get_task_info_pasid(adev, job- 
>>>> >pasid);
>>>> +           /*
>>>> +            * The job may already be freed at this point via the 
>>>> sched tdr
>>> workqueue so
>>>> +            * use the cached pasid.
>>>> +            */
>>>
>>> amdgpu_device_gpu_recover() is run in tdr workqueue.
>>>
>>> Now if this is the case, someone has to explain the logic  -
>>>
>>> Timeout is triggered here -
>>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/ 
>>> scheduler/sched_main
>>> .c#L559
>>>
>>> This calls amdgpu_job_timedout() -> amdgpu_device_gpu_recover()
>>>
>>> After that, there is this access to the job -
>>>
>>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/ 
>>> scheduler/sched_main
>>> .c#L566
>>>
>>> At least, in some condition, job is not expected to be freed. Then 
>>> I'm not sure if this
>>> is the right fix.
>>
>> What is that "someone", "some condition" you feel like? Its better to 
>> bring proper justification, and take up this as separate refactoring task
>>
> 
> Basically, if scheduler code itself is not expecting job to be not freed 
> after timedout callback, then why callback handler needs to assume the 
> same?
> 

Taking out double 'not', following is what I meant -

'if scheduler code itself is expecting job to be not freed'

Thanks,
Lijo

> Now if callback handler does something else which in turn frees the job, 
> the fix needs to be there instead of having this kind of fix.
> 
> Thanks,
> Lijo
> 
> 
>> Best,
>> Srini
> 

