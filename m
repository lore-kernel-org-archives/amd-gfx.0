Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E25E9A03B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 04:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359A410E2DB;
	Wed, 18 Feb 2026 04:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G8qE2fJZ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1220610E2DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 04:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBeG3hQGD6fbG30lxPUEtnKk93L0Rjpww7CKHDVTj/rrNJUashurj40yXKFNz7jZ71Aa+1tRNWOgjLbbhV9nGRSlZhF550wzF5s0OxGr1X3vdvoWt+693sgF3BDYdBRYGHNoAGljVnmo/H9bjhy1zdTophtZuQ0z5EJ7QU7V8F7WcoqjZy+r3W5R+Ysd0VIC3y/er0Hz4zUxxn6PltQ/UG14ZqF20DHyXR2COvOL3V/wrbToemS6t5peohxAVbrwwYXl2s2xT2m2FkFbGTf4+NWkPZZaPMQaW14me9KRbW+/WmYZ4yJEbqnLM43Naj9uG88QA49xM5CMfem/Ol/j8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fpl4U4NH2OrohUvdMumc7+jddWsR1FZShwD2zFfsas=;
 b=TWBrNU/sR5QNRoQfpDAUHEAu8NGBu/46m71cAl2CqUIdmx2PS+q6XPY/UCuPzAC4TKxXCV1KT7CzWouUMSyRrVnanZeZLg+x5oUPpRXC8Y8GGaGjuzqPJ9x6x1WFEN44WDPuAvnPt+gTo65viLjAAmoZOvjKspZFYEZFRvH+VHd0pzaaND8fmFfx+rDN6KXNmjZNjdojwkpQoAsjXbII7WWlGfkGxcoWj//0/ouy9WLlqkKpIMxi+GlzZCh96er5Qz705NGxaHFmxjL1uhxBTDX67ytyj9G7xE7KK67uuZyWe59cC63CxvkaWN7HnB+PlU883RffR2lUP8gX+5a8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fpl4U4NH2OrohUvdMumc7+jddWsR1FZShwD2zFfsas=;
 b=G8qE2fJZzSCcHYv2D2r/vhXbhlzrCAH/Jkd5IH4EW8eYIwMn/BaPdlh7vDmACnvdvReMQsjiPZ8FW7rFER5Qw4YXy0BnFjDsosP85eJkKL5bauVu9jkH5h4a7PhdXkAmQJr17TuN/+w2F3SdHDZsCOJ0Doa8JnF3r+zTZFCnWW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 04:51:32 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 04:51:32 +0000
Message-ID: <a05cc80e-176b-4d5f-92da-8e70825e53e8@amd.com>
Date: Tue, 17 Feb 2026 21:51:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amd/display: Use DCE 6 link encoder for DCE 6
 analog connectors
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com,
 Mauro Rossi <issor.oruam@gmail.com>
References: <20260202112508.43000-1-timur.kristof@gmail.com>
 <20260202112508.43000-2-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260202112508.43000-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::26) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: c277a058-e5ee-4a09-ae0a-08de6ea962f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVdLZnJCMTgxTlBZcWViREtxYWxDZVEzSG03L1NMaC8rMFZCL1ptdWhUSThv?=
 =?utf-8?B?TWM4OElBSTVHL2hDMFlxbXFDUFpMOSt5ekRvQTcxa0pyQzlHQU1kb3FFWDlm?=
 =?utf-8?B?UU9ZdUpvNVVKRS85UkpSS1kyUzJyWHB6bmFHU0dQUlJkRXR3dW8zeTVxb1hP?=
 =?utf-8?B?NTNhNDZCOTRESmZMVDlaMUhWTks4SjZxN1pMZDF2SHNqc0hUT1BDWEpFTkY0?=
 =?utf-8?B?SWU0QnZNVUIvazBUTmpZcnlmVzcyVjkxdFEyQ25lSWkvNU12OWM1S1o4OE92?=
 =?utf-8?B?ME5yVHpPdUpBbEtwQXFNcHAvb1Mvb2EvdzVTUlZTRUpLMmllOXliVUV4dklT?=
 =?utf-8?B?dGRtTVVobE9vMVNmYnJWQkp1VG44Qks0bzd4ZHBnd3VkNTF4NmZ1a0hJeUNi?=
 =?utf-8?B?cG1wTTdKbmFPV25FNFcvcFIwRFBiR2JwZWRjY3NFUEZHK0QwR2RWaUJZN1VX?=
 =?utf-8?B?T1dYdWpWNEllYlJvYVA2alAyb3BQOXg0ckdGTGRvZS8wcVd0TUVoODVwZlMw?=
 =?utf-8?B?L3NMbEhTcGpmWTgzbHhpaXQyc1hibkpaWm0xY240SDhCZFlCdFNUcSs0OGF6?=
 =?utf-8?B?NHFicXorWFppZVNXbS9xR092NlJ6OW1nOVFjZDkvTTcwZjBBWVh3SCs3OU9u?=
 =?utf-8?B?Z1E4RWdacHpQcmRpeTEwVW56Mkl4V05KMVdYV2xPRFZtTWVraDcyTU5tTkF0?=
 =?utf-8?B?QzJyT0FBOXRGeTA3UVpqbEU4OUpOOUp1SENNSkdkZE9LQmhjR2dPREh2dzFh?=
 =?utf-8?B?a1c5ZlQxc3FiSmFqRmc2emN5NkZxS0hZZG96OGJSZHBaM3JUNGphRmJUYlpK?=
 =?utf-8?B?SFpLL1NNN2hxSmZFMjRPZEQ3OWRWQmNJRkNlbndycTdVNEZadzdGcC94aWV1?=
 =?utf-8?B?RUNROTFROGVxeXIvNkhIdC9yUjNGcmU0NWJnSkc0dERlMm16bVVzNHFRUHZY?=
 =?utf-8?B?VWpUYXR0RHNmS25pQ0syZDM0MWJKc3hJR2ZxdkUxMCtBVkpNN0lYTzMxM3NS?=
 =?utf-8?B?cVNoN0JOSnZEQTFYMjkrc1ZrYTNLaGVYd3QrQjVFV1hFK1RrNDdWalZUL3d6?=
 =?utf-8?B?SEZ5RDh5bHB3ekR3cFpVUmIrT0haSU1SemdNQXFRcGg5RllnbGEyV2lPQ1M0?=
 =?utf-8?B?dERuSzhPc3ZJQXdxR2RrZkpETFhGT0pPRTVrbkUra3FyMTc5QkFubURqRHh6?=
 =?utf-8?B?ajlDaVRtc2ZCRDBLakw5TzFiKzNyWlNnV1RIa0U3NHVkY3dBOEtIeWlmQTVM?=
 =?utf-8?B?bDhOUHM0SXJPRGd5aUd5VFB2ZnpJSk54V3NRMVh3Rm1TT2s4WXRuOG4rWi9s?=
 =?utf-8?B?S21hWVp6dmorNWtBekMyTHZNMXZZOE00OTdtZ3BjQ2tsSE9hajAyYzZMYXlP?=
 =?utf-8?B?VDArN2J0c3BqWGVOK2hWZ1NwS1c3aTRiYWJ0TUpqdDJKUzVOTHhvVWpLT2Vj?=
 =?utf-8?B?enh3S21MejZnZ3BiNklyS2dtWVZtek1QWmc0c1h6OTBLNEsxbzViVWltS00x?=
 =?utf-8?B?dGNJdEt1eTRvSHJVWFAybDNLdXdaQkFQeThYRkVzNmFKZG12blVvT2syVjV0?=
 =?utf-8?B?K241S1h6Z0w0QWU1MXl2NkZ6cS8wa0FqRlFpZDFJOTdJM25QMkVoNmxiSThU?=
 =?utf-8?B?cDVmTDJaUjRWL3Iwc0VNQXQvaTdQS0pSbmdRamZsQ0Y2RkdVdUszWml1MTY0?=
 =?utf-8?B?VTYzaUNXOU5zOFZNenNBeWhDWDJ4S01VMEQ0R1IyRDFBZTU1N0liakw5VmNW?=
 =?utf-8?B?MERYOGtGNzFOckZSVzhYbUV1NkQyc1QyVkxHamJXekE4KzFaUkdkSnVuaHpR?=
 =?utf-8?B?V3VZMG1oY3huUXZFdEtlRi9KdTNmRWFpRjROMWx1SG16VkJxNFBBSXdYWC9z?=
 =?utf-8?B?SW9jRjI1aWdLVzBKOXVhWTZkWHRsRm9iMmtKeGtCSlJrc24vK095bjNSMUY0?=
 =?utf-8?B?blVFN2JLOXRub3Rrd21oZ0cxSjhsNlorSzZMOGdLNzhHdTJJdW83TWx3eThF?=
 =?utf-8?B?WnpSbktHYmdHcHJ1cGJmYjJMS2YzSnBlUTZncERVUzQ4VGtVNTlKSCtyWW03?=
 =?utf-8?B?WXhTVGJZcXVSTmN3ejYybnU0NUY5WnBzR1VWZmFDRzVGTnRtRTBETDllNmJm?=
 =?utf-8?Q?2mFo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTgwZG40Z0JlaEVRZmVacjkwNXVsbzBGTnFiSEdvbVJOY3duUTlsTGN1L2hD?=
 =?utf-8?B?R2pITzEvanprenAvL0RDRFlRb0FGUlBvbVpCRlJKRFpNdXF4c01JTG80NWtI?=
 =?utf-8?B?ejZnYldQU29QTm1lWUh5azN4bm9icXlYYkxsZHJWbkdPTUZpSTVhcHNYMExB?=
 =?utf-8?B?Tllsc0xqUHZRZllqN25MRTJ6TVZBMDhJWFIyQnhSVW1LN1NBMExXRUgweGJX?=
 =?utf-8?B?eVBUN1VtRldTVHJRVTRrNEE5ZTFyV3hHdUFzc3VlVkRmRGRjZjhkdFEwdHpj?=
 =?utf-8?B?OWxkUVdBeHBybmRhd3Vyc2lXc1ZsK2txeWd6TzN6WVFOOU1WWjROU3VEYk55?=
 =?utf-8?B?czRpMXpwSXJRNm5uaXNMOVN6Wi9XT1JLQzFkdmh6a0o5cXk0TG1RUTV2Q2hW?=
 =?utf-8?B?bGhIYjJFM2ZiaGhWamIzYk9XcTdITFhzcE1RNWZyRU9SWjNSSWx4R2MyUmFN?=
 =?utf-8?B?ZFlrbldvT08xUGMza1c3UUtub2VhcnFacmxLZEJSUVhEZWpOTTZoYUFQcElp?=
 =?utf-8?B?SWk2V0V0UnFCSS9GelAzSzNVRkd1bkh5SnNIN1lESC9tWG5Fb0JCWFJrZHFQ?=
 =?utf-8?B?YlY0VjRiSnczUmRDQ2tXNEpTNThjR05vaWltRkw0ZHZRZWFBVlo4UlRtS0Ra?=
 =?utf-8?B?eVpQK0E4UHhlcWhjSXhsRkI3MllSZ0FRQ01TNDhUUVIzbzBZRUZNTmQ2T3FN?=
 =?utf-8?B?M3BOV2t5VmZJQjlpemRnbUZGQWwwV0RuSXFCMkZSTm5VRmJ2QmJ4M2ZJVXpU?=
 =?utf-8?B?YzE5aUNpRnVCeCtLOERrWlpqbjZzOWl2SGtYOHBiNE1tNVdmOTZKL041YWVQ?=
 =?utf-8?B?UHdnSXR3MTdBZnRlMGFpV2U2d3plbVAwWnVvcWZZVU95QzVWZEtZejZ2NkpU?=
 =?utf-8?B?UGhyMkRvdUdSRERTeHhUellQMkJjVGU5NVZ6Q0p6UWkzYTYveThJSlVIcWpU?=
 =?utf-8?B?TEVacmQ2ZkxjTm96TTJiTTFvc0luVTc3UkhORzc1QzNwQllvNTZhUkVsWXps?=
 =?utf-8?B?bGd3N0hlNG1Ud21GcndCSDZvNy9LWDVUdU9vSEN1UUo4Rkl0RWh2K0tBYWlO?=
 =?utf-8?B?b0M0R2laSWo0YTBtY2I5UGtwNVFhZi9lTU1OL2UwaVdFRnI1NUxEellzbVpv?=
 =?utf-8?B?UFpGZ0xNZzFtaHVXZ3dKRUMzUzJKa09YVW9ZOUQvc0RzM3Q4YlRUbnN4eVFt?=
 =?utf-8?B?akg0MU1seHZmZDhma0xXMzRua0FHWi9PUDVkdUJadWFuUzFuZzczM1ZRczlt?=
 =?utf-8?B?dFUwTlB3RXZvRmhpNEFDRW10UWZrcGQ3bHZUSWxXNEFjVFBzK3cyNWZBQzJa?=
 =?utf-8?B?cURDREY4NFdURWFCWnlUMmY3TDNSeHF0OUY3MjlmQVFvQU5SVDI5OFUxMVRV?=
 =?utf-8?B?bTBBMzRLYW95TUppNy9XY21UN1pRQ2ZpWWtqbXhEMnU3N2RLWkFqQUVlWGh5?=
 =?utf-8?B?TE5ZZlN5cjZ5b0lSV2pnSzJjM2pDcDBtSC9zR2RYSDR1d1liUnBCWHhuT0FZ?=
 =?utf-8?B?OVdySmNWUWtqQWlwYm4wQUJrbGlkaVlVWVF3REM3WnlCY3NVNGJaU0ZveTlK?=
 =?utf-8?B?cGVXOS9ZQ3pFUVZEbmF6UnBaR1JMajJuWFV6azduOCtUQncrUWM3ZWpBSVdm?=
 =?utf-8?B?Ym8xL3JWVlI5bUUyczV6ak9xek42RERYTGQ1akU4NjN1dGg0c1d1TjhtbHpr?=
 =?utf-8?B?dzFlTUhobTEzSHZVNmpZUm1Cd1czNGUxQytKVmdrcjZ0dEMxNTNYSE01WTk2?=
 =?utf-8?B?b3pKR0J5aEdqZ1RZa1ZpUUFWeDJTN01ERTcxSVFVSnRxRlJSQmc0VWY5aTRl?=
 =?utf-8?B?SjJDZ0Nmampybkd5NzhlMks0VE5SRzF4bWNWM1k0VnhhV1E1MFhCK2xVRU9K?=
 =?utf-8?B?cmxPT2hLVU9BbjhqK1FJUFpNUHZ3VG1SVmZ4bDZYTVFHcVpwa3R3SG40b01X?=
 =?utf-8?B?Wk1VU0xxS015eERIM1pUVmlaTU5ZY1UyQzMvUkw1RjhTNnpiSVUyTWIwMGM1?=
 =?utf-8?B?c0ZxZVh6aW9vOTBkbE1GeUNXamZsSXp6MS9hTVorK1VCcFdXVkFwSWVzQmM1?=
 =?utf-8?B?Tml4Y1ZiaVpOQXZQQURNcVZqRE9nVVpqOU1uY1A5VHoxTlNUamE1WWJUeVBU?=
 =?utf-8?B?Y3ZWM0VIQXArQytmZDJHb3BOeHRaT0s0c2dEcGtjOWZ1NFd2Vm1mKzBNWVcx?=
 =?utf-8?B?NnRlQU9HUkFYeVE5T1BZSm9KV01GaGZqY3RGVm5HUEcrVFN6K2UxVlNWemV4?=
 =?utf-8?B?dnZaMHZEUUQvQzBmZjgwMWpmQU9DQkhHamZxamUxemdCZWg5MjFvaFNMNDNC?=
 =?utf-8?Q?yPshnsD1uYUslGjQb+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c277a058-e5ee-4a09-ae0a-08de6ea962f4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 04:51:32.3852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlP31xyErfjmsL02fs+m3EDAhNtpQK5G5IZ87uBjTKhRw7VXQPa4+UZlLqRW/1vCI3qOsw2CYy7E8EBhrcUydA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
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

This patch is also in another series and is merged into 
amd-staging-drm-next as commit "25f8c8132718 drm/amd/display: Use DCE 6 
link encoder for DCE 6 analog connectors"

On 2/2/26 04:25, Timur Kristóf wrote:
> DCE 6 should use the DCE 6 specific link encoder.
> This was a copy paste mistake.
> 
> Fixes: 0fbe321a93ce ("drm/amd/display: Implement DCE analog link encoders (v2)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Tested-by: Mauro Rossi <issor.oruam@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> index f0152933bee2..068fb1df8d88 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> @@ -734,7 +734,7 @@ static struct link_encoder *dce60_link_encoder_create(
>   		return NULL;
>   
>   	if (enc_init_data->connector.id == CONNECTOR_ID_VGA) {
> -		dce110_link_encoder_construct(enc110,
> +		dce60_link_encoder_construct(enc110,
>   			enc_init_data,
>   			&link_enc_feature,
>   			&link_enc_regs[ENGINE_ID_DACA],

