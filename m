Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0485ECCF9E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 08:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD4310E37B;
	Tue, 28 Oct 2025 08:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oqygdhnv";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E7C10E37B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 08:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiISML122TjOZoVVmitnzlVh3TUdAN9PFEOH0qBVR/EmDH5xN+1YpeTnlVIPPgJkWaNTIrg2rwwMC274gsfzx5RqYdq1LZUDf3awkis7T6DnnDFMet7nwLQX+3mTPPQtCapbTJ24O8ZXoLJb1wdbV1FzazQSDiKpXDZvEKLtyURhF2xfATzhLrhBZNZXgGjegYFRWDqhnlcecjLNdO/k9srHTL4S+GtYFFL4ci9ohoiJg2NO8/7rwXQcwBSUazh9IIc+ej1SkCiAXQ5GhfmMgwgghj0Z+DcowsbSXXZQYRqg1sEAtdFiErUR5+4DzVkremWtzAAKsLY92US/Albjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9DJpuMQfKk1g4kFDYelwyod/0CisUqPs6S8BffTG0Y=;
 b=UWsnTeFGoL9qfxywJ6c/tig5rVg7TBq13ygHM5p91rzGCudUaJASdn8noCIaOaLv27I1HCHfjPSm9GrukIrc4lOpzRsBh5rI03hae0Vi+pOMnUgS/5xCDsBliYj6QBpDshTkZO7J+1S9eD4rQzY1AEKmjgWZpzF+sD43PvPHQlrgCrZywiGm7j+m8zRPMr3+T7ZYgzXYy36o4onSETRsyMeLbH84Os1maepWgVRWNLEzSGIN0FkWFeMvK+V81dQ9648+ramlxwHC4kHMTygd0DdSS4IH8Mc0W+p5hdUCnsIc3GIhNlT0FvXRbKE/cYkDe4+RNO8rgpXhH+/9DmMGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9DJpuMQfKk1g4kFDYelwyod/0CisUqPs6S8BffTG0Y=;
 b=OqygdhnvzfZV3aVKYlCQmN60BYJdZ69iOpBvgEXeLmmlLqanjzq/VXlUx8JzAu8o44ZIPAy12WZBqtmCgUGryh/nlybKx/jFR3MTSpMohd7pF2HV1tG39QFcZNwq/qfI7mFN3vXS8T+tS3NGQqcECVB9H5XcztHkr7wIg7UR2L4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 08:53:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 08:53:21 +0000
Message-ID: <e0fa89f2-c1c0-44af-95a7-cd5539d2d4b2@amd.com>
Date: Tue, 28 Oct 2025 09:53:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: null check for hmm_pfns ptr before freeing
 it
To: "Khatri, Sunil" <sukhatri@amd.com>,
 "Kuehling, Felix" <felix.kuehling@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251023065848.1664757-1-sunil.khatri@amd.com>
 <dc5cbf60-d73f-4590-ab7c-0ac3e919fb5c@amd.com>
 <a1c87ae7-9f8d-4fb7-a141-c285776d76b0@amd.com>
 <f8ccd8cb-8ef3-4c6c-b512-a469da7f5512@amd.com>
 <9976ad6b-2276-40d1-9479-7fe06b9bcb6a@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9976ad6b-2276-40d1-9479-7fe06b9bcb6a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: e909e681-b2b5-441f-b7c8-08de15ff7222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uk83V0Y1NDZwS2lqa0VsNzZidkEzUjlpbC9wdGo2Tk14VjdJZkE1M3FwK3N4?=
 =?utf-8?B?QWJDd2ZjM1RpSHdIVGNZaE9Zc0dhNzd6R1ZiWWZ4NlB3eGxRRVZMYm1oY3Nz?=
 =?utf-8?B?ODRxODhDMURNUXBEdktyaGwvbzhNZzlUQUtYQ252Mld0MHlKVHhGK0huMXZB?=
 =?utf-8?B?UFRHV2tnRVc3TzNkOGY2SzdWM0d0YnY2S3RtR0QyZ3NuM0M2N0NPQUNRbTJG?=
 =?utf-8?B?TGVyZitxOW5vbkJJb0lXZXJGTTl3Tm9vb2hQMVlMMlRQQW9sblJDWWxDN0ps?=
 =?utf-8?B?dkZyak5zQTR0dUxrOXJGN3M2ZlVkZzE2eThQUStPVHFJUFpwYkVjRlNkSTFl?=
 =?utf-8?B?Ui8zeElGbEVtM1VMMkQ5RTRDSTFEeXFJbVZFL1VLWTU2SEVEdWlzOFBVUHBp?=
 =?utf-8?B?NmlHWGdFK2liQ3dEWkx3aklBOVZOL1ozWkJ5Q3dxY2pQNk9WVUU1U3Qrcmo3?=
 =?utf-8?B?bThmK2NhYmF1dFBYNmZZRStmcGFIYlc2Tk5YVzZwZzJ5cDU0YUo5MGxBZW5V?=
 =?utf-8?B?V3hjLzVVakJMTWowYzFUNTNnZW1jaEpxdytpSmpUWnkrNUFxYjV6RFpnYnpY?=
 =?utf-8?B?UE5iQVpDRjlocXNnY241dkxjVjBWZEU3QnVRUUJxNkJhbjIvWnE4Q2JxekFV?=
 =?utf-8?B?M1Q1ZWtNV1BHZTQ1Z3JEdDRyaEJHL1Jucm1hWGZZT2xpMzIvK2dtTkR5VjhV?=
 =?utf-8?B?NEJFdUd1aDFHUTlDaHVZRkN5UU51cExWSzk0eU5KK295QXQrazYzd3lsMUp3?=
 =?utf-8?B?d1FIYTJrZDVscDBOcTVMUjVGV3JCNklxMzg1dGU5WmFhS2ovOEhnSCtneUtq?=
 =?utf-8?B?UFdJZ296anNmQk0xdzl2T091Q2szWi8wTUZQcHZwc0dIVXFZcmNneU1IWTVZ?=
 =?utf-8?B?bWNHSjdNd0ZrN2JzcEppZDVNeG5ndVNzQ04ra3c3U2Q4NktaRFZ4YjZhanJY?=
 =?utf-8?B?YURCZ3ZyK21pNzhKTk5XSDlLVnVCMXBCMWZuUmdaQk9SZmk4ektiWGVxVWtE?=
 =?utf-8?B?TWkzcnBWUy9PRXBNb0JBbXB1dWlYYjdXM3dvV09Tcnd1bVdvd2ltM25PWEd4?=
 =?utf-8?B?ZHozQUNqb1UyMUR4dXJRaS9UalpPb1FOWndodTc3MmNVcEtiWUpqcEwwMzlk?=
 =?utf-8?B?NmVFOFF2cmlwd0RUTForWUZ4Kys3WjJzUWdLZ3g2RHZFVlZzbG4wT0t0a2Er?=
 =?utf-8?B?YzBWVUw4YVVDaWRFQU04VU5Id2xRc2dTN29yaGZ6MjJRSlZ0K1pYaDFFdXE4?=
 =?utf-8?B?czVtYUhHak9XQms0WXVNQ0J3a1UxTlFGa0pybVNUZE95YWU0dzRUNnU3Mmsr?=
 =?utf-8?B?MUdXT2lncitXeUROV0hQczlzMTJGMUlVQ2VzbkxuUDAwUGM3UGk0V3doNTZR?=
 =?utf-8?B?OUlNcFU4bWlFa1BGNnRRMzdENkFJRGRFZWFOSXBCSXhOemZRTDM2d0l4TUE5?=
 =?utf-8?B?MDJBaWZ3NDFGdUtYYktTSmdZSzEwcW8yY1Ivb2Rra3lqejAwWVpyeHNNUnll?=
 =?utf-8?B?TEdzaUh6a3NNaHIwT3VvdWt4UmRrMTM2aTBJMVZGYzAvNVp4alVaUWFSaEFG?=
 =?utf-8?B?bHk2OFFQbDdrZnR4UG9xektjSThEOGhVNEpaODM2Z3k1bG5qbkZaeTF4Y1lO?=
 =?utf-8?B?RVA0bVlXTWErcy82WFN0cEpmM2VJblpNMzBRYzJmaE5JV0dUbzNGeGgvNFVH?=
 =?utf-8?B?TTVzMW1MaHptYkJxQm9Ed1NNdkcwdFQxckE2aVE0NE1YSXlHOGxPMm5wMmhF?=
 =?utf-8?B?Y0F0MjhEM0ZvOFNyb0NSQjd0WjY5U2tTb04wUUlUOUo2Y2oxR0hjRWlqYllz?=
 =?utf-8?B?cFJuQVE2Z2s2NWZNWkt1T3VkUi9yRTRBMnJXZlpiOWg5Z2tuVy9Oc25xZi9t?=
 =?utf-8?B?WTJCOW53dWRmMDZySzY2YjdwWk9xbHlVSmoyRFpsaENQNmtxVGZVMG41UWlC?=
 =?utf-8?Q?RBeARGAF7vGPhnvs/Yh5r+Bk/kyy+QzM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTlhS01KSWVKOWwzYUFXSmNGc0s3aThqYVV0QStYbFZvY0tYQjAwMDhWQWV3?=
 =?utf-8?B?dm44M0p3SU5SUmg5c1l5RUdMSldXckh2ZXpVVGlrRmpBSHRnNk5XV1BiYU1x?=
 =?utf-8?B?SWJuZ1A4SDJzK3ZmM3FhNkhad0taeW5aN0hodTdNb3ZxWTROYW1HcDc3MjRL?=
 =?utf-8?B?MHo2THp3azByUkZZamo3aDFibmhFeFVWSGhsbE1YTTRmbzg1WXZHQkpBOWlM?=
 =?utf-8?B?NS9YRTBTaWUzejErUmFSTFVEUnpGNk5kTjkxdHFFMmFmY1MvN0tDZEY5YTMy?=
 =?utf-8?B?bzNuUG0yOWtnc1VTUkRvQkRPUzBRRFRxdkVEZWNwUnJnc3BoTDFabDhJN3Zj?=
 =?utf-8?B?RDFWZkFRTm9aU3NrWXVkeE8yN2d4RDZwQlk2aEp0OEFyald6ZWpGYlBObEw0?=
 =?utf-8?B?cjdtTjNqbUhwTHgreFdFdmFQUk1MYldHVHErRzM2Uk5FVmIxbkRXdktSNVds?=
 =?utf-8?B?U0ZiUW1wQlFrS1U2UHpsaFNmREUwaEFIQUc4ZG9LajBscCtlYTBEM0dUNUQy?=
 =?utf-8?B?bElFU250WW1qN09CWUpwK0gzR2hKcUMxWEEvNzg2aWRDUk9KY1pNSVllMGdm?=
 =?utf-8?B?eGRDc21qOWRiTXpkbmpQUkJoQ1lMVEI5U1FHdkZZd0pYYVhKZUJCSGREM05w?=
 =?utf-8?B?TWdVdGRWM3RnMkdReG1VaEtLT09ZTHhEV3M0NWFyL3c1eHI2cEFKNS9wZWUw?=
 =?utf-8?B?L1RTUE5UL1pSeGM0SU04OFE0WkNoUFQ0MHpkWGxXQnNPTE53UnZIWjUzNyt5?=
 =?utf-8?B?L3RTZWdIUXQxbzRrTU5uUElBRHBoWUVlTFVoSXo5NWdZWXBLSmIrV2RYYlNL?=
 =?utf-8?B?eFV5YlJCU3NnMDRLbjlWVnRBYW44NDZWVllkc1dHalFKdWYxUzREcWQzMFQz?=
 =?utf-8?B?MW0wQ3JjSDdNdFg0UDFCQ1hpaHVIYURBRjRTOWNzaGNNOVJ3MmZLUHJ5NVlo?=
 =?utf-8?B?aktWaEwxRXp0Z1cxck13aXNveTZxcGZDWVV2VEcxdnFrdkdhdFFJTmNyblRv?=
 =?utf-8?B?M0wzWmh2bEZsOExtSEU4RkxmemF0d1dsN1A0UDdDZGFnbkpSRExyVE5NNzht?=
 =?utf-8?B?TFJyMDBTRUw2RWZJdVE4V3J6ZHo1M1pBVXBzMTFKNHZpRjdEbkk3a2F0STdG?=
 =?utf-8?B?ZGswV0ZNQk1KNG9jYWNqQ1llK04vTTJkbG1rYllaeDluaGNzdkwzZjhPTG80?=
 =?utf-8?B?eHp4ZSs3SHF5Qm9LS3dCaFBaSmx2NENSUkp4WlZpZERIY01KV254VWJyRTBP?=
 =?utf-8?B?bTVTRjNaOWpUNEprT0lEKzVYQitRN2I2cGoyODRvUFc3U2hwcCsreS9lSW9x?=
 =?utf-8?B?TTlJRzBYUUhZRlJlYzRRUnpnOUkvbEFRdXZKNWRlVURRVmgxa3J2TVZ0eDUx?=
 =?utf-8?B?MUp5YktZYWJTRXJNL2tqaFE4MDFROXFZVHhXSTFtbG5nK3VFWlFOeDlXUU1p?=
 =?utf-8?B?dnZvMDUwSFZ6bmsxUUVHN1ZOWjBFeG9BbmJpMjgrZkNrcWtQNnpOOVZZcC9t?=
 =?utf-8?B?Y2pMaWFPQ3RjckV6aDhreW5ZZFJNUis4RFp6V2ZBaGk5dHo4bFNDZEY3MUs1?=
 =?utf-8?B?eUZSWDV2b2ZaMTBvQ3dFaHVMckxZUjJDVXJ3cmppV1NFWDgxNFlsdmRLcmhO?=
 =?utf-8?B?REpBZlpETDQxRUY1THQvZmlrc1hBd052RjI3TmdOZUo4WE9tdUkzRGtIV2VJ?=
 =?utf-8?B?MS9aNC9PcDJhNHhKcTZSN0FJTVB5V0F5VHVBWU01SEx5Z0Y5bi9MZ1lpdXMx?=
 =?utf-8?B?SlpHa3B4NFduS2NLZjJ0aTJ4WjZTZ1Y1c1RaTFRLd0ljMlVQMDFXRi9CalhS?=
 =?utf-8?B?TEhPNmxZMUJ3UGZ0TXROYWpPOWNzSTlyK0c4cWlnTHZFR3Q1dXVUSTBNaHp1?=
 =?utf-8?B?Nm9YRmlWekY0SHVHa21LN2tFL3FEdE9KdzhGck15b1ROQ1RuaVo0Z09IRHY2?=
 =?utf-8?B?ei9Qb2kwSUZ2NlpIbXhidTkxUytWY00zZzljWnhQa3FqUG5RSmZhSTAzWWhL?=
 =?utf-8?B?NHhyNnpTSjhCWk9ja3BCdTFES1d3amhHcWgvSFlHT24xSDgySHRjRmsvZWQ5?=
 =?utf-8?B?NmNUU3ZZTDBBYnBSbFRlOGYwV0ozQjduNHVUZHdMTkFUOHRYZGFydGlKZmw0?=
 =?utf-8?Q?LKJKPghX530xoDk/U9gC6/Jih?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e909e681-b2b5-441f-b7c8-08de15ff7222
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:53:21.1163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fr5ZviCrv5y0Zky3jA64d1IOfuMQqZygz3FnH2V6UTSqUXTXPaA/r5OTzsrmUIcV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
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

On 10/27/25 15:40, Khatri, Sunil wrote:
> 
> On 27-10-2025 07:58 pm, Christian König wrote:
>> On 10/23/25 17:30, Kuehling, Felix wrote:
>>> On 2025-10-23 03:48, Arunpravin Paneer Selvam wrote:
>>>> Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>>>
>>>> Regards,
>>>> Arun.
>>>> On 10/23/2025 12:28 PM, Sunil Khatri wrote:
>>>>> Due to low memory or when num of pages is too big to be
>>>>> accomodated, allocation could fail for pfn's.
>>>>>
>>>>> Chekc hmm_pfns for NULL before calling the kvfree for the it.
>>>>>
>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 6 +++++-
>>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>> index d6f903a2d573..6ac206e2bc46 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>> @@ -286,7 +286,11 @@ void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
>>>>>       if (!range)
>>>>>           return;
>>>>>   -    kvfree(range->hmm_range.hmm_pfns);
>>>>> +    if (range->hmm_range.hmm_pfns) {
>>>>> +        kvfree(range->hmm_range.hmm_pfns);
>>>>> +        range->hmm_range.hmm_pfns = NULL;
>>>>> +    }
>>> NULL-checks before kfree and friends are unnecessary. There are actually static checkers that complain about such unnecessary NULL-checks. For example, see https://lkml.org/lkml/2024/8/11/168.
>>>
>>> The same is also true for the standard libc free in usermode: https://stackoverflow.com/questions/1912325/checking-for-null-before-calling-free.
>>>
>>> Finally, setting range->hmm_range.hmm_pfns = NULL is also unnecessary because you're about to free the whole range structure anyway.
>> Agree completely with Felix.
>>
>> Sunil why do you think that this is necessary and blocking KFD for some reason?
>>
>> Regards,
>> Christian.
> 
> KFD side reported the error of NULL dereference
> 
> pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL); //fails if the size is too big.
> 
> Now when we free the memory in function amdgpu_hmm_range_free and try to do a kvfree of the range->hmm_range.hmm_pfns which is NULL and we were seeing the NULL dereference.
> So i added a check to check for the memory to be valid ptr first before calling kvfree. 
> 
> This actually fixed the issue but i do agree that *"setting range->hmm_range.hmm_pfns = NULL could be avoided and that why i did not added that check in the final patch that i merged" This is the final code after this merge.*
> 
> voidamdgpu_hmm_range_free(structamdgpu_hmm_range*range)
> {
>         if(!range)
>                 return;
>         if(range->hmm_range.hmm_pfns)
>                 kvfree(range->hmm_range.hmm_pfns);

That makes absolutely no sense kvfree() should be able to accept a NULL pointer as parameter. So clear NAK to that change.

What exactly does the backtrace look like?

Regards,
Christian.

>         amdgpu_bo_unref(&range->bo);
>         kfree(range);
> }
> 
> 
> Regards Sunil Khatri
> 
>>> Regards,
>>>   Felix
>>>
>>>
>>>>> +
>>>>>       amdgpu_bo_unref(&range->bo);
>>>>>       kfree(range);
>>>>>   }

