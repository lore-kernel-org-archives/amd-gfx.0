Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731C4CA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 10:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1626A10E2B9;
	Tue, 19 Aug 2025 10:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b+XjrMd6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25ECD10E58C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 10:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHwkOatOUVgYJ51WwDkAQN/ClVKTmpOYrJh/wxmmotDC5WY6FFMZoxBTAnZ6h744u/ZrFD9D2LFvqne6n5vQ/8YPAlYQ3KTS143XY6sSS5ced1Jz5nlHVjPm92jKhuazb6QUpZ888efDJ5jZI3NETXuZQzfaa0f54gaklfip/bxW3gWb4fuFTJdfF7Bj4KiWDEnbSo4ckDtOhZty/moznVljcy900Qll9pfslAmijl8+lhseP0uE2IP0yq1suB/Rre1csAkXQdXAwtuaaiM0w4gGJp3x05oXwlSl/jtPeVhXHt6DEk5uMiBWgUim1RGax3JEOG64aPHbH1jWke9kiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9OXRzmY3nuG0oksHLBl8+LWAsgUwXRCqFCR93EH1Mw=;
 b=fOoPg8iO4zZV1gZqbflYHoc2M0+HuIbPeB44Pczz8F7M/nVLoDEylG8kPMYUVb+PiAor/LeDHnb7vib3DdcotyCjp5FpUrlrUTo4pq3mNdYVzmkFLLTQxHstBeAQ0XZYy+Og/cLgNia1MzCslQSVHRwMk4jfZthkYN5IygFIhrAtWYWvhrLI3qmpklfOXlKk8FSLsXBBGljB5Sx2VeOPx4kSM3IvlKTvRLIkdCXpuF/IGTPospyh5RgowjmNqBJDH7qfnX23jwq/iTj0G7INPW0SlNXKJ2eo2UPet1X0vwAnpLeV6t4xabELZI3xMnFQTgXpOmD/WqrCLRKTO2FGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9OXRzmY3nuG0oksHLBl8+LWAsgUwXRCqFCR93EH1Mw=;
 b=b+XjrMd6cy/GP2jbtUR5U+DVN/hSRUHPdKntmf7hZQ2OS/LWzpGU1mPMmKQZO+hsyZaEMuwDtcgNKNsmyh9U+lrh2U0dUFEnJlhfVuwvADuqtaXr7aa9hKZKJRpPZ3tE69H0gjlBk0I2/aP1Ebm5z83/Hqc+c8hH3SkOfoWExus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Tue, 19 Aug
 2025 10:27:20 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 10:27:20 +0000
Message-ID: <1cc5e183-dc28-3d95-b326-d9abc7cbc370@amd.com>
Date: Tue, 19 Aug 2025 15:57:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Check vcn state before profile switch
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, David.Wu3@amd.com
References: <20250819091217.2115134-1-lijo.lazar@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250819091217.2115134-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::15) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: fece907f-4a94-447e-f1b3-08dddf0afa46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUhXTlBPVmpKVFg1TnoxZXp5UnJxZnFrMDcxY2J0a3VrT0VUaFZNUnplNU4w?=
 =?utf-8?B?RGpETWlvVXRCdmt5NXZ0ejYrNEhVcXFZRnZDajJJNG9MWWhUQU85VlZiN1V4?=
 =?utf-8?B?Y1JYb0IvZjlZNHA5VytSemlaaVg3ZGk0bVlCRDBnRU5GRFpoTjdhUk1IdEhU?=
 =?utf-8?B?RjhlRUhCaDBza2RwM3JXZ2x5eHE2M01ERzJiVUFneHRnU0dQbHRSV2JTRFZ4?=
 =?utf-8?B?QmczYzJiQS9ROVFwUG9DaEV6UmpmMXFiVkhPNFdhUmtLclpCa0UyWUZMcENi?=
 =?utf-8?B?bCtUdE1PMGN4Q1ZNUnR3cjRxL0NaQ3lQbzVpYXZKdG1Ra1NqS2llV2NqSzh0?=
 =?utf-8?B?VkFBUWxVMHNKcUpxdW5ONGdJVVdueC9ZcVIvaTdqM3RxQzNjRi9FcXJhZWpC?=
 =?utf-8?B?TEtTdENod0djTEM1R0xFZ3BzS1NzcnJnK1g2bGdHejI2RVlQeW9LOGFhcTEr?=
 =?utf-8?B?alJzNDlCL0kzT3NyZkRML0NncnJhUitjam1kNzVrTDVWb01kVTBGMHdObUty?=
 =?utf-8?B?VlJ4ZGR6aElielhBTWNLU2hOZnFEL3JaREh5QWxCaVBGMktCaGJkVmZ1Sm1n?=
 =?utf-8?B?d1RxeGc3dG9Eb1NuazNVL29qaXNEaTZNeExUVUNXYisxcHBESEtxN05ReVZo?=
 =?utf-8?B?N01sVE50MURsM3RLdTJyMjlOQ2l3dHFBNUdsV1VMa0JiNFJLUUNYYVh4OEpy?=
 =?utf-8?B?SDNpUzV0alY2SWtKM1htcnEzOFNyUTBrOEpMS2xvNzBhQU5udjAxaW9WaEkx?=
 =?utf-8?B?YkxRSFlEUVRYN1VJVmJYUlloU3BQLzVhYk5LTEZ2Wmt1d2RzdUJLVWk2Wm1N?=
 =?utf-8?B?U0VWQ3NmdWE5NnkwcFJ3V0xCc1h5TnZ4REN5dERNSkhhWC9oN2g4TVVscUFh?=
 =?utf-8?B?UmVPdEpTTGF6OVU2MG1BaXlVTWVwbkRhYVlLWjZ3NzhpNnFyZ0Z4bC8va3ov?=
 =?utf-8?B?b3plRzg3NkQxcVFnT1VMMnAxUGY1Q21UUnJlYWhHZGtZMk45QXlpWHVJVW9u?=
 =?utf-8?B?djRHTzFkdDdySFBzb1c3OHFIMXZVNFhLTmZXdEZIckZqWTZRQU95bElxVDJ2?=
 =?utf-8?B?ekNDSkhjeS8zdVVsemk5cG5vUDBycnlPZzRkRU5WbkptVHEwL3BCRGkrQlNq?=
 =?utf-8?B?bnppaTZNa3dFVmVSSUtxZFJPUWFBaStDcnQvMnlFUm5YNitSRU5sTmZYcGI3?=
 =?utf-8?B?TnBDazhXR3dFSG5lSVlLK3NqZVFMNEFMTG1vNWl2aTloT2ZUNExvYXdDSFZx?=
 =?utf-8?B?YkxCNmpDbHF0SGN1KzdyYzkzY050bmxtK3hYZStrb2Uremx4NGp0SFVIY3c4?=
 =?utf-8?B?aEMrUjF2UGJiZjdTMW1qNWIwcEZueHdrem9tL1JqTlpDRDJ0eXAwZTJ4N2lR?=
 =?utf-8?B?WjF5a2phSm16V2tkTVRDM3BCRFcwZW9LZFhYU1lib0RXQzNlVSt5YkJKUlBR?=
 =?utf-8?B?V0ZneDNhZm4xUHFmVWVqRk01N205amwzWUtsTVY1QTBkUHY1RjFJSkNrOUdB?=
 =?utf-8?B?aWg1ajV5d3RXUWFsZDUxek1zN2hEMjRHVk11RHZqS1ZMOS9uNnY4cnhqVHZY?=
 =?utf-8?B?Sys5WmZBYllBbEViVzlSNEpHYTBjMkNwTGdKWlpGZUYyZk8vQzBqTVVGWUwv?=
 =?utf-8?B?bDFqS0daa1N6WEhVdjRPREFCZ1NBZUdZRUthbzZnSjF2d0wvVzEvTW1zb0Vz?=
 =?utf-8?B?U1c1TDdlNjQ3WDNPZzE3cW5hS28zTHI5QXdtYUNDZHpDZXhreC9UeG0yZHBX?=
 =?utf-8?B?cHVNektjaUtZcUErYVhzcWRJL1ZoVDRRdU45U0xpa2V1YWVMSy9QSWF3QVRh?=
 =?utf-8?B?dU5yN05LTG9EWFY2enR4NDkwWGh6bm9CS1M3WDNTMEY1dTNvNWVsRkRKa3lz?=
 =?utf-8?B?eVBPVkpiVFdxcWs2NzZMdGc5Vm5CYTIySzB0ZHhkeGxjc21uT29zZkFOMTdM?=
 =?utf-8?Q?u33IpKLUyBg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTB1L2NLeVZkQjNWbzVjQ1RCQXVQWC9lZlgrTUZNem5jeDVhUVJlNkFueE9K?=
 =?utf-8?B?a251eXhlR1dYSWNrYnJHNkVrRkp1akF4UWZJbzZiT2FqS0dOTkdaRXlRejZU?=
 =?utf-8?B?NnpSV2J0dG8wY0dnQm9EZjNhNWNYNXpmVG5iMXpBYlBrNVUvcTZrLzZyOExx?=
 =?utf-8?B?ejhGSFo3R0FzK25mM3pDY2pKNFMrbUFPOHVKMVFGZEtUSDRoTXpOSTN4Ums3?=
 =?utf-8?B?dEtYaHRzNGl0Zzk3T1c4SFBOWUgxM2tDcm94U1JKUHV4bmJIaXF3OVR2Zkdo?=
 =?utf-8?B?RlJkclpVKzZRRmFtQTFRU2xUNHhPODZ0cTBNRUxaQlFkbHZXY2JaTW9zbXh2?=
 =?utf-8?B?dWFYZHhtckN5LzRtcTNVYW0zUFhEQkxreWY4WTMzZzhYMXJtZ2hjYmEzejJY?=
 =?utf-8?B?aGxZMlJzQ1ZMbWg5bWlGdmFLWTNnb1pwRWNMR2NaVWpKZ0JEazBCZUtuM1hT?=
 =?utf-8?B?K3M2Q1EySTVWYmlXZWl1VllWRmNZMjRnNWRCWmxqRVVWQWYvdzNReEJWeUFl?=
 =?utf-8?B?QjU3Y2ZFaGVVb3BvQmxMYXV6L3dOOEhQa3FRQlA3ajFzVmRJa0wzeklDOHZP?=
 =?utf-8?B?a1MvaDFPb2pTRmJCT3VMc2NjdXhrcVpzNHhTaXJRMlNLeVpBei8rRXVHN0g1?=
 =?utf-8?B?NjVwdDlrcGpFN1QvRUgwR1VLZTdHUkZYUVVMUXFveDkwOUVPRUo1bDZXZC83?=
 =?utf-8?B?TzljbTZxNjdxdEY4ZVBUSHFqTUlHYW9OWU9xNkpxRU1hRTVOSjVnalpTQ1p4?=
 =?utf-8?B?T2NGNzgrbUFpRDJaNGtNWDUxdkxWYmJMRVBCeTlpR2xqcEtQbE1aRGd0MnF0?=
 =?utf-8?B?ZXJ6WUJwODA3Q3ZlQW5pRm9WUTVBZis2bUN6RVdiWldlb3RDM2JMT3AybmdP?=
 =?utf-8?B?aW9jWmtmQThSMXprUUp0TTRST3REU3pVK3N5THFTU05vY0FsdTlmbjdreTF3?=
 =?utf-8?B?VEI5bUdKemQ2N01kSWdxalpJVno2cmdhdkxmWFlocTVjKy8rUmxGMDBpTXZT?=
 =?utf-8?B?NTd3NVdsMkpPRTFuRFlRSDRFU01ta25qaTFXakszQ2U5U3NlVU5PWjJlbnRj?=
 =?utf-8?B?V0dnbU9JSExSb3VzMkNadHZzNnAzYjZoRW1jazh0UlFJMWtpdXAyWHZKQ1Jk?=
 =?utf-8?B?cW13K3k4b3NmR1Q2SVBGb2NSRjFLcFFVbndFM0VVS2ZEb2thc1hrMmxNOURj?=
 =?utf-8?B?emYyMzZpYUdyQVhzMVZpT2RaMzJ2S1pSbE9oK2ovWjJ0Vmo0aTRESGx0Q2xr?=
 =?utf-8?B?TmhLSlNQaEdhOGJjeDg4YXRDQUdxWmtTRDg2WUI5WnBIbFBlQkpleFptcHJo?=
 =?utf-8?B?bmNBWkxyaTNBbFZQbmRmckZSdlRHejhYU2dTYzN4bDhuSHE2bE0yM1pBWDd2?=
 =?utf-8?B?bi83eEV0VzlmdlpHL1NiRE5EQk40Rzc0b2pUa1NlWWpCRWwzVzZPME1kS2Vn?=
 =?utf-8?B?NXZOc1dNWEFuZjIyV3pvMkJYR1ZkQ0I4czVQcjBsU0lGeDFWVzBpb01tU1FB?=
 =?utf-8?B?anRYS2ZGbjZTd0ppaU1vWVIvOXVIcmx0dmU2UU4xeUQ5Y2hBdW5kRXFpMW4y?=
 =?utf-8?B?dlNWMUJpMVB0ZlV1aVZpTUl6bGRLTm5QblB4c2pYeHZZNGtlZXZPZGx6NXVD?=
 =?utf-8?B?U1hpOXpSdzdZU05pbW85KzBCYjN1NWhvWHU2cU1hcCtIUVhmUEYvS1kxSXJ0?=
 =?utf-8?B?RFJYOFFyUUhLYXFuOUd5cUxrRVk3RG82emFvTDBxQThGL1kvbGJ1ZWwvUGcr?=
 =?utf-8?B?NWhQU2ZEMldlUHp3NmFuQUh6RGVJQ1lrMXZlT2xVdEFjNllQRGNubFQ5a3Jr?=
 =?utf-8?B?T1FtRnRHSEhDU1YvRmFNeUJKWm1McS83b2gybXZ4dXpDWEVOWXR4bnk2SkQ4?=
 =?utf-8?B?Z0UxdXdHTTRsZzkyK21IaWpNU1F6VzhzOGh0OTZESjRlWXVjaUo5VjRQandX?=
 =?utf-8?B?eEN0QVZtY3ZBR0liaTBxMVF5VE55d2txWExwSWR1d1ZNbHBoRGVLL1U3Wkp3?=
 =?utf-8?B?anZRN1AyZEJrY2pOS0J4MlllOWkwcUU5WXppd2xHT253V3lPKzlIMVlVdEw2?=
 =?utf-8?B?OCs1dmdzTnlCbmdsQ2FXejJXc2RJVE1vZEswRk5nY1lJc2dVbjJ1Y0pNdUht?=
 =?utf-8?Q?koDz+0domDKh08AitXAHkHxy+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fece907f-4a94-447e-f1b3-08dddf0afa46
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 10:27:20.1300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qb+xUf75cnXXsPOgGnT1H3P4mNejiFVPDBa7BaAiauCiUTivc3SxXG3pHYZe7/cRmLVLgEjvpXZyADXqQFP3jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747
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

This patch is :-

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Regards,

Sathish

On 8/19/2025 2:42 PM, Lijo Lazar wrote:
> The patch uses power state of VCN instances for requesting video
> profile.
>
> In idle worker of a vcn instance, when there is no outstanding
> submisssion or fence, the instance is put to power gated state. When all
> instances are powered off that means video profile is no longer
> required. A request is made to turn off video profile.
>
> A job submission starts with begin_use of ring, and at that time
> vcn instance state is changed to power on. Subsequently a check is
> made for active video profile, and if not active, a request is made.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 85 ++++++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 27 +-------
>   3 files changed, 61 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c18..f3eb64edf6d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -410,6 +410,59 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev, int i)
>   	return 0;
>   }
>   
> +void amdgpu_vcn_get_profile(struct amdgpu_device *adev)
> +{
> +	int r;
> +
> +
> +	mutex_lock(&adev->vcn.workload_profile_mutex);
> +
> +	if (adev->vcn.workload_profile_active) {
> +		mutex_unlock(&adev->vcn.workload_profile_mutex);
> +		return;
> +	}
> +	r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> +					    true);
> +	if (r)
> +		dev_warn(adev->dev,
> +			 "(%d) failed to enable video power profile mode\n", r);
> +	else
> +		adev->vcn.workload_profile_active = true;
> +	mutex_unlock(&adev->vcn.workload_profile_mutex);
> +
> +	return;
> +}
> +
> +void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
> +{
> +	bool pg = true;
> +	int r, i;
> +
> +	mutex_lock(&adev->vcn.workload_profile_mutex);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE) {
> +			pg = false;
> +			break;
> +		}
> +	}
> +
> +	if (pg) {
> +		r = amdgpu_dpm_switch_power_profile(
> +			adev, PP_SMC_POWER_PROFILE_VIDEO, false);
> +		if (r)
> +			dev_warn(
> +				adev->dev,
> +				"(%d) failed to disable video power profile mode\n",
> +				r);
> +		else
> +			adev->vcn.workload_profile_active = false;
> +	}
> +
> +	mutex_unlock(&adev->vcn.workload_profile_mutex);
> +
> +	return;
> +}
> +
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   {
>   	struct amdgpu_vcn_inst *vcn_inst =
> @@ -417,7 +470,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	struct amdgpu_device *adev = vcn_inst->adev;
>   	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>   	unsigned int i = vcn_inst->inst, j;
> -	int r = 0;
>   
>   	if (adev->vcn.harvest_config & (1 << i))
>   		return;
> @@ -446,15 +498,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   		mutex_lock(&vcn_inst->vcn_pg_lock);
>   		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>   		mutex_unlock(&vcn_inst->vcn_pg_lock);
> -		mutex_lock(&adev->vcn.workload_profile_mutex);
> -		if (adev->vcn.workload_profile_active) {
> -			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> -							    false);
> -			if (r)
> -				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
> -			adev->vcn.workload_profile_active = false;
> -		}
> -		mutex_unlock(&adev->vcn.workload_profile_mutex);
> +		amdgpu_vcn_put_profile(adev);
> +
>   	} else {
>   		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>   	}
> @@ -464,30 +509,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
> -	int r = 0;
>   
>   	atomic_inc(&vcn_inst->total_submission_cnt);
>   
>   	cancel_delayed_work_sync(&vcn_inst->idle_work);
>   
> -	/* We can safely return early here because we've cancelled the
> -	 * the delayed work so there is no one else to set it to false
> -	 * and we don't care if someone else sets it to true.
> -	 */
> -	if (adev->vcn.workload_profile_active)
> -		goto pg_lock;
> -
> -	mutex_lock(&adev->vcn.workload_profile_mutex);
> -	if (!adev->vcn.workload_profile_active) {
> -		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> -						    true);
> -		if (r)
> -			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
> -		adev->vcn.workload_profile_active = true;
> -	}
> -	mutex_unlock(&adev->vcn.workload_profile_mutex);
> -
> -pg_lock:
>   	mutex_lock(&vcn_inst->vcn_pg_lock);
>   	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>   
> @@ -515,6 +541,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>   	}
>   	mutex_unlock(&vcn_inst->vcn_pg_lock);
> +	amdgpu_vcn_get_profile(adev);
>   }
>   
>   void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index b3fb1d0e43fc..6d9acd36041d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -565,4 +565,7 @@ int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
>   			     const struct amdgpu_hwip_reg_entry *reg, u32 count);
>   void amdgpu_vcn_dump_ip_state(struct amdgpu_ip_block *ip_block);
>   void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
> +void amdgpu_vcn_get_profile(struct amdgpu_device *adev);
> +void amdgpu_vcn_put_profile(struct amdgpu_device *adev);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 3a7c137a83ef..904b94bc8693 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -116,7 +116,6 @@ static void vcn_v2_5_idle_work_handler(struct work_struct *work)
>   	struct amdgpu_device *adev = vcn_inst->adev;
>   	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>   	unsigned int i, j;
> -	int r = 0;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
> @@ -149,15 +148,7 @@ static void vcn_v2_5_idle_work_handler(struct work_struct *work)
>   	if (!fences && !atomic_read(&adev->vcn.inst[0].total_submission_cnt)) {
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>   						       AMD_PG_STATE_GATE);
> -		mutex_lock(&adev->vcn.workload_profile_mutex);
> -		if (adev->vcn.workload_profile_active) {
> -			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> -							    false);
> -			if (r)
> -				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
> -			adev->vcn.workload_profile_active = false;
> -		}
> -		mutex_unlock(&adev->vcn.workload_profile_mutex);
> +		amdgpu_vcn_put_profile(adev);
>   	} else {
>   		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
>   	}
> @@ -167,7 +158,6 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	struct amdgpu_vcn_inst *v = &adev->vcn.inst[ring->me];
> -	int r = 0;
>   
>   	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
>   
> @@ -177,20 +167,6 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
>   	 * the delayed work so there is no one else to set it to false
>   	 * and we don't care if someone else sets it to true.
>   	 */
> -	if (adev->vcn.workload_profile_active)
> -		goto pg_lock;
> -
> -	mutex_lock(&adev->vcn.workload_profile_mutex);
> -	if (!adev->vcn.workload_profile_active) {
> -		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> -						    true);
> -		if (r)
> -			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
> -		adev->vcn.workload_profile_active = true;
> -	}
> -	mutex_unlock(&adev->vcn.workload_profile_mutex);
> -
> -pg_lock:
>   	mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
>   	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>   					       AMD_PG_STATE_UNGATE);
> @@ -218,6 +194,7 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
>   		v->pause_dpg_mode(v, &new_state);
>   	}
>   	mutex_unlock(&adev->vcn.inst[0].vcn_pg_lock);
> +	amdgpu_vcn_get_profile(adev);
>   }
>   
>   static void vcn_v2_5_ring_end_use(struct amdgpu_ring *ring)
