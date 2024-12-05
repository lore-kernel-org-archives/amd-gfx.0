Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C146E7716F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 00:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0747510ED8A;
	Thu,  5 Dec 2024 00:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1gysAfPU";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEB410ED8A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 00:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cq69HS7n/+Y/+sAUeBfzbbGj7I70s4QwSlbOfDVu7QaRVXGSwtcKEJWdtlz9C5815gSDQhTBhUYRwSDbJBaS/48H6TRDqrAgl6YApz1ZNsXGHLUnKACp+fWjlGSWVhpR4JSo3Y6b1prb23jWN553qtlLRMB0yxffdJME5CIPE4UM1xliM9FxPsXZksBAxoXcNp8fo71cXeTtvAE2JtjluL9C3RwmK1xc/yH0e6rzloeLUopG2hCzF/TerrP4WzIA2DejlCUuMEgB0LmM7LaMGMX3wQbCxgwCbdkm4zVorqtolM4dsFgB2nAyfxS1Lb6+2HCq695rn1Inb4nToWbs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXddqsUsWGG70A2VJAGKIyO4NRVQdQuGh1oxt+JjlDY=;
 b=CyzXVGao2swQN+nRWqkGe+z2ly8NCeqge/QE2Mr39PyL7l6it3WrmWzSw1stihqj/8xRz7w9/JLANWEgGS1xSkK1KLaoaQYVgng//fliZrK2V1uk1DJU6SoNLBwRlmRK6hyTpWQBYODftVcoZkG6zOOO1VT95ok2P3NpmEf9GVHAEOhAqbLrI1hhy6hRwwk6eV04Y4ilMLWhGLWVDTHMslCIJqgQWVhpAK5c0bYk6adgCP86x9YXiKd3hDhORsiQQ7T5jXUpzHypyMld2G9Sg7TMtAMSofSwtsQ8ARS+myH3VtU0++9PopMbwLB6V2qbY47yzr6VmkIH5D0c+co3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXddqsUsWGG70A2VJAGKIyO4NRVQdQuGh1oxt+JjlDY=;
 b=1gysAfPUbW8Gsc7oVuLwq4RI/cL0+iZaVy2bopILItiG1cR+aF8Gs3pDj7RLPH0gumywqoyWeEZjNplJSSuPpUhFmoT8DFww8GpPVWPg4u3srdcoefyKTOoQRR5H+GiarnprR7BZNIaGv7abkcpAyRaDBOLRSraXhSXa0BQNGws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 00:00:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 00:00:40 +0000
Message-ID: <c510c8d3-ed30-493b-97a3-5f3d5f324a66@amd.com>
Date: Wed, 4 Dec 2024 19:00:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Dereference null return value
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "Martin, Andrew" <Andrew.Martin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Tudor, Alexandru" <Alexandru.Tudor@amd.com>
References: <20241202124505.1760749-1-Andrew.Martin@amd.com>
 <BL1PR12MB589848536293468002D55C5885362@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <BL1PR12MB589848536293468002D55C5885362@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0050.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 38051005-c708-48a5-21f5-08dd14bfdabf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0IrYzBaQ0dzNksvWTloSGlKeDNBQU1lS3NBZ3IwTWxyS0U2c0tkL1h4Mmtq?=
 =?utf-8?B?TDNUVEZYNmd3RjJEZkxkcElNaTMyb3J1QU9RYmJSOW5qZG1Lakh3OGVGcVh2?=
 =?utf-8?B?cnRtc0FrenlGNHFweUVGQWFJWlJ1MmF4U0dqb0NCci8wOUhKRC9GeTNVNFp4?=
 =?utf-8?B?VC8zaVB1YzkwUGNMNEMrOVpjZkN3eGtqNlMyYzNrU2Z1M09lSDZvdUdURVhx?=
 =?utf-8?B?bDljK25EYW9KT29VNjdLSk43VUU1WDh6THpZelhOQ1NIaHQ1RnpDS0NYR0hk?=
 =?utf-8?B?SDFqc1g2NmUxa3ZWZkt0WGl5TDFaQVU1aXIzY2o3aW5jNXJpQXlwVnRFeHQ3?=
 =?utf-8?B?TlRKMDlhcitHa3UzRHczZVBReEJtS3B0Q2YwZkk1cmo5aXp5c2FmRmxmbU1Y?=
 =?utf-8?B?UzhYbllYMWozRnlBTDg2M3lBdjBRMm5OM254SGdraWd3MVNtME9GemlCcUI4?=
 =?utf-8?B?OGpyZzVmcHJ6eWZ3YnpzcXJLbTh3MUJzSEJZTE45SjByWTVXTjhpdkVjeFVI?=
 =?utf-8?B?ZHozNkVCdnJTTlhubTY1UjFNdTRMS0hKaDdUQ0VjTVhQVmNsOUpMbUFzaHZ3?=
 =?utf-8?B?TWI4ZU1STkQwUUsyNmdPZ25BM2s1Q3BnaFBicXNlYTJPY2dhMUo3cjBPTHdy?=
 =?utf-8?B?SVJiSm16TzJITXZQU1BjNzUwZHNaWEFrRG9FVkR2NTNOaTNEOTBWMFJwMnhq?=
 =?utf-8?B?ZGI3cThmMWdWSDJBNnQyZmVYVFpPRjNMR0NwbkplaUdxczhrWGp1dm5HV0kx?=
 =?utf-8?B?d1Z4QTE2ZUp1MVFHSUdkNElBWFYwdXdGQlN0c2RXVzFkMUJMbUw3bjRieDdk?=
 =?utf-8?B?aFprM20weVRENGswdWVqdGxQaXRzamRsTU93eHpHNWVBS0tlTWU5U1JZS3Rj?=
 =?utf-8?B?V3JtY0gwcG5KeVQxNXk0OGw2aUlTcXExSUlHR0RIRGt3TUw1QndxRW5xU1J5?=
 =?utf-8?B?YW5JbmVMNE5uOGZ3VHltOFJwVCtYd29TSmthNTRyNk9uWEdaQmtqSk91dG5o?=
 =?utf-8?B?dmc2VjIvbDdZVWZ0cnNNZk45MUlLRWVQeVdwem0vSTJSUWQzdnNIYnR3MFkw?=
 =?utf-8?B?YUtVTDlmZzFFbzRqaE0vMVVmN3h2aEljc1EyOXlPNHVCNXUxT1lzR3RqbC9D?=
 =?utf-8?B?OTdqaVNGdk5Xdlk3eWZsK1VhTnIyUENmVjlTN3hIZUp6L2tQaTg2YUdzM3ZU?=
 =?utf-8?B?cnJBblNraVdBUXNHMXN4ZWllNUhsd2hQR042MS9FQ1NhQjB1bytLYVc0alpW?=
 =?utf-8?B?SE1ndG1BbEFYa2JDNk9jL3RYelJyYVIvOGl1aENjSjlyY3kwbjcycFRkbnQy?=
 =?utf-8?B?ekJiMklXMzllYUFsRTFFUWU1ZGtENnR0OUFCQ0NaYmREd0wwUGlMbEhyL29o?=
 =?utf-8?B?TnFSZFI0SUljSUIyUUt0VjU1M0IzVUFWTXRod3hGbXh1RG55bWYyeG1jSyth?=
 =?utf-8?B?TmhqOXl4NmV3ZjY0RWVNVUdVdjlUWnhoSFE5RGhZSkgyTUNkOFAxK0Njamdx?=
 =?utf-8?B?NzNKNDNkRThWTjdVdWlvdllNbGw4WTI1eVlNOW01ME9oRWxqMDlGNUJ5aytQ?=
 =?utf-8?B?YWZGdnpVQkw1bG5NRzV3TWl1VXdrM3VQWkdDVkEzQnVhNG04bXloblZYbXJY?=
 =?utf-8?B?ZTRTUWtXclpLbzM3OFRZeDErSmN5TnIyQmVYRkk1NU50cE5LWC9SVVVqNUxu?=
 =?utf-8?B?YnNXYTlQcFBHcXliQU5UYTVaeW92R1VpQXFhdHZEemliT1krN1N0ME54MFRx?=
 =?utf-8?B?WVcyVGkwZGh5MGVtN2RtbGZWSUZuQWpUUEE5ektGSnJYNDA4YmZUUnZUUEJF?=
 =?utf-8?B?QXQvK2FGOUlmS3hENEhCQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW0wT0Z6Qzd4ZUpTbUtJeGVlRStyY2J1RHY3WEFyV0RyUk54azVyS1NVRzdZ?=
 =?utf-8?B?QTJPSUpZTkhJZUV2NzFSUCtKbkpZRFFFRjY3UmVsWXNGODBkOExST2h6b0tD?=
 =?utf-8?B?cHdqTjNsY1Z1bWtnV2JUZ08yTGVXOGt5dHZoM203THk3VDhES2U5Z3UrekVF?=
 =?utf-8?B?ZmNabGg0WCtPYm1rOXh0MzFRbk5sVlEyaW5CQ294RlR6QnRvaXc0empTZnJu?=
 =?utf-8?B?VWhNRHVHOC94Yy8vUWpDL0lJSlhyY0FJdEdMb3ltN0tENk9uWnB5UHlFMTVw?=
 =?utf-8?B?YjUrOFJnUDdwazlGUDY0Yyt5R2NNY3o4bGI1cGxqWXFrUUFhUFUzUitxS0pt?=
 =?utf-8?B?WHR1OFNwbm5oZC9nSS9YMFhaNmpSOFZZazdHWFhxMnVsWGxONTBGYVBuWUQ5?=
 =?utf-8?B?RHd1ZmVHMnZkd3U0TTM3NlgyWk5JNVJMSEdyRmxpTCt1RzFvM1lxYTA0a2Fj?=
 =?utf-8?B?NVowZnFqYlF2ZGxYaVhRU3VFMTZjOE56NnlKaDVLQjhXSWFqSW9wTFhLcEJ2?=
 =?utf-8?B?SWlWOW9DcTZaZ1VSWVFBM0ZOZXFPZCsvdCtuQnoyTStYbExSNWlNMWloZWlY?=
 =?utf-8?B?MC94eXNSWjduRjZYVEVXVnUyemV2ZnZkT3ltT2FCR2RlWDN2Qm1RWnVvSGVR?=
 =?utf-8?B?QlZqaVdDTEl6TE0zODNhNnhZTVZVU3AxMTRieTNoZmo1NXJTU0orK3JqSjAz?=
 =?utf-8?B?azNrT2VJUUhscGZGL05IMlBqSHhnb1NXN1hSekFXZkJoL2h6ZjRDR1A1cUxG?=
 =?utf-8?B?dXZxZldzTkVnMTRmYjR4enBWbXM0dW44cXlEMmJsb2JUT0tIOFBmYWluY1ZX?=
 =?utf-8?B?QjM3eWdZc3pXdUxuM1cxS0tlNjNyWHNrTW9HajVCUXhCSFhSVkFiekE1a3g4?=
 =?utf-8?B?Z1UyV2hrM3huTWNWQ3RjSjRJM0pMaDdFLzh6Y3QwY3RtWDZmRkw3QXVDV0xz?=
 =?utf-8?B?K3NaSUdKcUViRmFrSlQ3R0hySkJsUmNSVEQreUg3VmpXbzVRL2pFUHRZYzAz?=
 =?utf-8?B?SjBzNUluRWlWM0dzUWFxandXL1RmakovaW5WU2hGMHd6bWtqcCt3SDFqSFVj?=
 =?utf-8?B?Ky8rOEtKKzlwbVJDVXFNdzR5ZTBRREJTRUpTR3hMaFUya1NjSzU3aFVLSjdD?=
 =?utf-8?B?YlMyekphalR1dm9CUjBacSs2NG92L1dpYndUWVhidGtZa2JoZzR6eXZEelky?=
 =?utf-8?B?UEx5dXVWUldlaDJOUjBTdEFZY0oxekRjUmFQU2oxYXN1ZmttajQ0Z0V2Tjgx?=
 =?utf-8?B?VzljTWFvK1R0Z2xjdUVia1hNL3JndDJNZ2ZiaGFqaTVYNkFKQys2NTFuQXRp?=
 =?utf-8?B?bllVSWttOHM5ajBPWGNFRW1IRGlLZVdDZThGSkthZzgzRk1TK2RtTk00SlFQ?=
 =?utf-8?B?UFhub0JDeTNrWnZoS0cyYWtxTDlNakUwMXo3aFlmOURPMXpzWHJGeHFjODF3?=
 =?utf-8?B?eUtQL1JCVmV2WUdmMjBSTSsvakkycnNEU3Y1bEdBSk5rUEYyYTlGTWtXTlBW?=
 =?utf-8?B?cmNkN0VXWjlRZXhBcG95NFQ1WnViVnhvNktOa3QrYmtNS2ZKTnQzczNSVUtJ?=
 =?utf-8?B?dC9ERmxkc3FlYVY0ZDMzZGNRdHBPTjJNVXFibU0vSFdGa0VJNFpJUEVzeE8y?=
 =?utf-8?B?bDRQbHNaWlY0a2lxOFRzaTBvbm11RFRGeUFzVTNFeStpY2FCSFBFeUVxVjg3?=
 =?utf-8?B?dFhhRVFrbTI2R3VLUC9HRCtReC9DNGhaUldpS3huYWQ3RWloUGUyY3pBcVk1?=
 =?utf-8?B?MmR1Z280SUJNZHM3VXZZOXJmZ2kwQlN1WUFTM2dWQlFjQWMvWm5JMjUvZVlM?=
 =?utf-8?B?NTEyU1pHNy8wTE9ubEYrdzlPT2laamV1Y0FnT1Qrb1Zpb2RaVGtMdFZPd1B0?=
 =?utf-8?B?Z3hBYzRodnRJTkRVbHJsWVp4N1VRMFMwUDlFc0FqVlNrWDc3cG5LNDNFMDUw?=
 =?utf-8?B?MFdmNC9XL0NhMFJzZWhsMlVvNGV6L1dDdEYzNmRscUpuMjV4VmlMclltQ0Js?=
 =?utf-8?B?NlRiQlc2VUl1cDBLQnZCc2hBOGdWRXF2WkpMc2tzQWlLN2FablhMOHFuaDln?=
 =?utf-8?B?cmIrOUg4ZmgwNmx1bEZydno5dS95VDg2TTkvZ053cjZ5SldEVWIrbWN6V0Jh?=
 =?utf-8?Q?mN46Yhy/X3tUWE+m3cwnkKDhk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38051005-c708-48a5-21f5-08dd14bfdabf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:00:39.9249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L0bmvIe5KluqhgmQiafEgpde4Dtaf9blNIgDKK7qbG8EW5UWX1EHdF6ciKvycrPPqlkJH1C7JvAtaVfUYD6og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817
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


On 2024-12-03 09:30, Russell, Kent wrote:
>
> [Public]
>
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Andrew Martin <Andrew.Martin@amd.com>
> *Sent:* Monday, December 2, 2024 7:45:55 a.m.
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com>; Tudor, Alexandru 
> <Alexandru.Tudor@amd.com>; Martin, Andrew <Andrew.Martin@amd.com>; 
> Martin, Andrew <Andrew.Martin@amd.com>
> *Subject:* [PATCH v2] drm/amdkfd: Dereference null return value
>
> In the function pqm_uninit there is a call-assignment of "pdd =
> kfd_get_process_device_data" which could be null, and this value was
> later dereferenced without checking.
>
> Fixes: fb91065851cd ("drm/amdkfd: Refactor queue wptr_bo GART mapping")
> Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c76db22a1000..89aa578f6c68 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -212,11 +212,13 @@ static void pqm_clean_queue_resource(struct 
> process_queue_manager *pqm,
>  void pqm_uninit(struct process_queue_manager *pqm)
>  {
>          struct process_queue_node *pqn, *next;
> -       struct kfd_process_device *pdd;
>
>          list_for_each_entry_safe(pqn, next, &pqm->queues, 
> process_queue_list) {
>                  if (pqn->q) {
> -                       pdd = 
> kfd_get_process_device_data(pqn->q->device, pqm->process);
> +                       struct kfd_process_device *pdd = 
> kfd_get_process_device_data(pqn->q->device,
> + pqm->process);
> +                       if (WARN_ON(!pdd))
>
> Would we want a "continue" instead of "break" if the pdd is NULL? Just 
> in case other ones in the list are still valid? Or is one NULL enough 
> to just WARN and abort?

I agree, we should use "continue" here. We are leaking memory, but let's 
not leak more than necessary. With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


Thanks,
   Felix


>
>  Kent
>
> +                               return;
>                          kfd_queue_unref_bo_vas(pdd, &pqn->q->properties);
>                          kfd_queue_release_buffers(pdd, 
> &pqn->q->properties);
>                          pqm_clean_queue_resource(pqm, pqn);
> -- 
> 2.43.0
>
>
