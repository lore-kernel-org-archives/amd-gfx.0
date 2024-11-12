Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C545D42B88
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 14:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD8110E5F4;
	Tue, 12 Nov 2024 14:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="opsb2G2R";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41FDB10E5F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 14:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qM2KSj2teG4aE3KiSvVNuxP69euf10H+fSkWSPGQ5afByNP+HhsWybfsoXvdBdTbqyT3mEabwhi249EsbwIxDii2LRkL6RqypJA9/68SknlMGcXgUh1BTj9LTt+ihjUyHf5sYMSfptQ4W2P/O9sPvFAfqRuz6t3TQZ72ET7LjlQ++seL2ck2iJ8tVEB4i5I5zYwmK7M/iErQvGPUeDCvg5JkcnfzcS+ZTR04NFdC95DSMBwxo4UfnpynzfEniINLbUIvS6USPDmEAtd7RnIEYJmS9mPHyAMxiu3Y+C8A0hfdZ4437RU1QfUjC3w7yexXvdGtDJHBvz2ptIP9R4ppfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4g1ysx8MhavTUXmN7vPbX0/3dpfOpY4BjHX4CDoRsg=;
 b=PXVvaoTuiJr6epEzgQYC1zQS/ZGUaq+E7Q90HbxM8jVJWKn09jBrxa/f1YenXmWPw9HHMhEpS0fGOO1+Ra5Fj7InfU61Xy4GLQ70kU7R/+XlOd64+VDe/CRZrlMfxPlmVISfjjI1edFY0K1H7D2GawVi2b1V/vFvjh188yys9k8L1pp0G8Kn+PSqXWjAS7NKAY0Xuysys77bkPsuANonkg1wDyKiUJP62rSoIED8ZJS4e52uRZ8wkauy5g2XIukHPS1phi3UzXiSn+DjFVCNndxsQhMCJZNk2A8OP4Or05PrWkzW1sF4sfK3X83JfSiBMolpS0uy+sqxK8/4u23Gew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4g1ysx8MhavTUXmN7vPbX0/3dpfOpY4BjHX4CDoRsg=;
 b=opsb2G2REIhDOol1y3J7QJaG6BVgNMJhN1rm5nSPG2JNY8p0jUZ64/bfDlvizsG3G6ttjGhqbomz3lmRrs9Q0GjMmGrc4ivjGvBVqrF1j5XJ1lfGG9jSjMcM4SiVr1w4/QgSIBchIf8475cE9/INO1UGL4LSGHjnRjJYwUjhcUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Tue, 12 Nov
 2024 14:37:22 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 14:37:22 +0000
Message-ID: <98a39b3b-b9ea-4f2e-bbab-d80ca0e60ba0@amd.com>
Date: Tue, 12 Nov 2024 20:07:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix and simplify workload handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Kenneth Feng <kenneth.feng@amd.com>
References: <20241109053148.13617-1-alexander.deucher@amd.com>
 <4d3e76e0-51ae-4e07-bd41-5b272cd44466@amd.com>
 <CADnq5_ONqqBF7bcQfQJzkkSEEKPPuARSZn1WZLHr3yzhdF=2fQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_ONqqBF7bcQfQJzkkSEEKPPuARSZn1WZLHr3yzhdF=2fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::7) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 98060ca0-285e-4799-fada-08dd032784bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnFsRXplNmNLMUdwb1JadWYvQmx1K2JJSmg5STZIc0MrSmF1NDQwQ2dGYWE2?=
 =?utf-8?B?aHlIcVYyaEZyM2JpYUlBV3Y3ZmpkbkRwRGJXcGVFT0RPcGNmQ0M4dDlhVE1i?=
 =?utf-8?B?UkZkSjlWV05QaW1SK3ozenJyRjA5LzJGOTBwUFJ0SEhkRCsxdjBxTU5TRU5D?=
 =?utf-8?B?K0VxMHVZZTBic0dvelJPYkxQcndkZFMvcmQvUXdsWGUvOTd6SmFCTmZvK0g5?=
 =?utf-8?B?dVVVMERGQlhQMWlKN25iTzhWM1Q5aURwZ0syWC9zQUh5UVAxS2NuVENlVk1s?=
 =?utf-8?B?TVFxYVpRNnNUdWFMdzg1MjF4ZmVxeXJpdkZ1NVRFdTMxRExPRXR6WUtrSkVk?=
 =?utf-8?B?OFdXMjBRY3llZjZNVUwyM1Z1VjZCS0tQeU5wRGk3cks0OUFNbmlMZEVVM3Qv?=
 =?utf-8?B?ZWlwQTlFaWRGMkxabnh6NUNnRWx5eDFZSmtPZXVMQ3liOFE3d1NZQ2VUaG1s?=
 =?utf-8?B?NUsvSzBzVDBEcS9KVGxDdGhyQ09COHNBbmE1WVZuTXhWMVQyZmFSNFJ2ZmFa?=
 =?utf-8?B?OEU2VnRlcC9LOGYxdVdGb0FGVEs3VWJSTU85ajRFOWdCcFZmcFIzVHZqMUFm?=
 =?utf-8?B?MWpPSlFDLzU2QU11Q1hoWXEwK2VObmkvMUlTejBrdG02NmlpcXZkaUEvMjZK?=
 =?utf-8?B?eUQwRW1ZQnF5WGFoV2FiMks5V0QvaEJMSW9WSjc2VzFoTjZiSjRlajdIMDZ3?=
 =?utf-8?B?SnFOb3VUUE40dFRubkJVdWhUbmRBdHJuMDN0SXNjMXduRWZEREhzKzZGWlQ4?=
 =?utf-8?B?TGN6L2dCUzd6bm9iUGl0UVF5ZHEyeWxvUGFhVE8zOHFjOGo0dHdydEQ3Mmg1?=
 =?utf-8?B?OUh5SnNyYmExMzh0d1FTUm5sZGp1V1RHRWtBZFp1ZzVSSkM3OWZRU3NoZUl2?=
 =?utf-8?B?TlNRY2xCaFRDM2xsOFNhSHRpOWZSY0FQa29kSVJqNUxzY2w4NUhhKzhZRFZV?=
 =?utf-8?B?cGtpOE5vTUpVOHRxWXRNdVpuSHVaQmRwelNWT0FqN3E3VlRGcFFhNXp6bWlB?=
 =?utf-8?B?VDZnYzVnRUhvOUI5UlBGc0wwTTZJaTMzcm5BODhaVUJ1SGsvWkY0djlDc0l2?=
 =?utf-8?B?R0NNSkNKcjRpVE1KbUdqL3lheFoyTkFQSFNNRVhSVGJjVkJRN3hIQlVpUEo3?=
 =?utf-8?B?Ni9lQ2JrQncwT0s5N0h2VWEra3lVODRYS042ejE3MFJucCszQ3ZIUUhxNkp1?=
 =?utf-8?B?VVowZUhQa2ZxUGhEVGpxTUlWYU91VGs4UWRDYXVXemJFaUJDOFgzcHoyaTIx?=
 =?utf-8?B?TUJHeHozN2hmMmdIRElyS3hvdWNiaGZ4UmNJNnBZRnZnL0s5eDJ1L1BaRmFx?=
 =?utf-8?B?eVpBbW5YcHNoQzFuSmN5eno1a2Z4ZmdkY21iRnRPRUFzaTlaRUwxMnZPZmJt?=
 =?utf-8?B?WXMySTNQbkJXTVBseTJXdENnMEF2bnNKSHdUdlh1aDJCcjJZdjN3ZzRqMUZL?=
 =?utf-8?B?Mm1PM0hzTVJ1YU1GajJyVWtZVEhBRnNsUU9ma2U5NEFkazM0RFNwc1JrNGh0?=
 =?utf-8?B?OGR5aXFBalMvZisrNFFDVmdNa2NNMTJJSG11WHBRUm5yRDdVRWNMYVljUUhm?=
 =?utf-8?B?UVJqRGhlcEtvUUkxenRTM3NQTU5pL2dPWitTUHJhSjhuQmRrMDFHQU5VY1F4?=
 =?utf-8?B?cmN4bGxVSHpjRnB1VTh2ZUxHRjNPdGN3dmpVaUVhcEhEQkRqQ0Vjc1ViQ3Ju?=
 =?utf-8?B?YU8xaFVscEE4bVRvWXhnMDl3blBPa1JINEZ5OG5uOXM5Y3Bna2NybUcwc2ls?=
 =?utf-8?Q?nFkmkw2DsK4rYE/CRU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVVDSnVtNUd2SEJDaGQ1bkJ0T0htQmtEVjBsK2FvK2NEeTNYbFNBZWh6cUFO?=
 =?utf-8?B?N2FxOFRMNyt3OVZLZUtDMjlGbjF3UTYzQzRsenZabE5MbVpOejN5QUM3Q2dk?=
 =?utf-8?B?MkEvQzNsMy9CdDl6bjFRSXpwU055Unl4Lzloc1pydkcrdmtlczJRVHlhVEFk?=
 =?utf-8?B?aXk3YXdvZktoUGY3RVFpam9veHYxdGxxTlQrcTJ0aUJuaEc3WHlQUkE5Tllw?=
 =?utf-8?B?a3NoUkVkNkVpVjVNZk9RTDh0cnlXRUVTU05oRGdYOVhIMjUzSk1FdG9IRlJi?=
 =?utf-8?B?NDBkQVlrVXhlRzZtR1d2a0h3TnRnNXRYRFI0R203anZZR0dJUWNUbGZ3eVpn?=
 =?utf-8?B?ZXB1cnhrS3pKZnVMMTlCMHU4QzJPZW1SNTVOOXJvRk9GRHAwTkR2QnNJQ0Mw?=
 =?utf-8?B?KzRndWNIZkJjdWpEeGFLMkhkbXVmeVhGblZiSzlIMFZDTlh4WUdUbDYzWHN4?=
 =?utf-8?B?VGJvZ1dNcWdtY2tRSTdwelBXSURnNU9jRlVPeEVRSlJUYUxjaEN4MFhkRkZz?=
 =?utf-8?B?SmYyR0tUY3htc0RteExFK2NKOVErSGZYTGNQRDg4bHFRSEoybHBnZERjRTBI?=
 =?utf-8?B?ZGg4QXZTc0s0bWhQM1o0Skpsd1lORDNqQk1RNC8vcXhCWng3SFJPZXFlZzRu?=
 =?utf-8?B?alhDdHhUU0hueTZaOVlGRURldTM4TGxaZ09YNjlmdS9uQzRESUlUSUprRUNs?=
 =?utf-8?B?MFFKeGpkVnVTSTJWaHFwU2d5VitZUHFvRG9iTWx4NnpXUXVyRUJSeTJYZ2Zj?=
 =?utf-8?B?Z2hSb29DZXBpY3FJbnhvdi9FOERMSkUwRzZ4UVdjUnNRbWNvdlR6VTVDSmZz?=
 =?utf-8?B?WEY0Tlh0cDdDUHU4cnJBUnpjR2ZKeU5QOUF0MVdhZkxNS0pVU3BKV2h2UXNl?=
 =?utf-8?B?SkZTd3FGYit5TnBFMmV0cWpkVnBxSDIyc0RXVTI3OVRiaC85TXpjUHdrM2M1?=
 =?utf-8?B?dys4bDdYbzZBRDVOcFBZV2FpNzJBbmZJZUZEclhBREozazh5U3JGckRYSCtu?=
 =?utf-8?B?dC8wTC9wQXF3OGozQUxRekg4bUR4RVQ2K0JjREVKNHRCUzlZV1huRGJXeEpu?=
 =?utf-8?B?Q3FOc3FXTHJIQ3VxelVyQTBHeHJuYWlxeDFraFZHamt1eWpYSTJWcUZjZmtC?=
 =?utf-8?B?MEtmTVpKQVBwdWRhSU9vVTc5WlJva2YvL1crekVSZG5sblh0NEIydmhDa1hH?=
 =?utf-8?B?MG9BTzFLOGdJL0Y4UW1LaTdwREFTVXc5bWhodXVJYTFUMjQrTHU1VjlOR2dn?=
 =?utf-8?B?bWJHZzRENnVBSnRSSzlSaXA0RkdiSXIvU1dST2dpL2NHWThVWGhOdEl6bnly?=
 =?utf-8?B?OXJJSVVmYk5YVHFwY1h0c0I2UWFZek1Gcit6QVJjcW9UZmpmajlDbzhpMjVh?=
 =?utf-8?B?WkwyelE0aVZ5Zk1ZbnZHRy8wd3dTVmMyWGJNSkFIODRTT0FhUGVZMndzc252?=
 =?utf-8?B?M2dlVlhvekpKeDR4WHlERnAxeTBNcTYvcmxBaE5xSXQ2RmpWYkdRQm11MXFo?=
 =?utf-8?B?UHFlZDhlVDJNM3RDK0tsem01Q2lJOTNDSFVGU2NlN05lT2pUeGlKKzJROHhP?=
 =?utf-8?B?UVR3YVZQME5Sdm5UelFkdHZjMXVpajFSZDFUZmR1RmZOTTdzM2hMMStNWEJY?=
 =?utf-8?B?dHQ0OWVpNHBlcTBNc016Z3FyMjFCenhIVit0eWk1bnNRdC91bStzZ1hTS0xa?=
 =?utf-8?B?S2svSW4rc0tlaWN6TUdUZE5ac2xvUXJNbnY1bFFNSU4zSzhna0w5c3YrQnc1?=
 =?utf-8?B?bGJkbERFRE5LWHNqS2U2d0krKzVSdU9KaGJiRnlPUXBtMHk3N2FiTmR0aUYr?=
 =?utf-8?B?Kzd6RTI1ekFoY0NML2dRWmlGVXdxbWxGbndETUtnSTFNSjlJdm9VT3pSMGJy?=
 =?utf-8?B?T2JvdUdEOE14aDRuczhoY1VpVU5FcFhXelFBY1F3MXFScWp3UC96SGV3dHFa?=
 =?utf-8?B?bXFpMjdnVmVwVW1FTFNmNGVQanQ1T01RV05PQzlHbVRiTFVVYlJFYjZnalZl?=
 =?utf-8?B?MHlRQVIxTnNSb1JJQzJVVXdLZFVmalhJVHJzemJiNlNpa3ZNT1FaaXpVeUd5?=
 =?utf-8?B?bXBzSVZxcmhzT3RUM2RGQm5kbWY4czlRbUZSNFZYT0RiR1RJRDNJOGdkbHJ2?=
 =?utf-8?Q?SrkEEHVcdqDWas8sIQQrXH2fb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98060ca0-285e-4799-fada-08dd032784bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:37:22.6191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0KdpmrqiPnb3A1kg7dULWrQlLu/cGh3xAwdz6yHAEbmLRETpiPBzA7DVvsOV3tt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
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



On 11/12/2024 7:55 PM, Alex Deucher wrote:
> On Tue, Nov 12, 2024 at 1:18 AM Lazar, Lijo <lijo.lazar@amd.com
> <mailto:lijo.lazar@amd.com>> wrote:
> 
> 
> 
>     On 11/9/2024 11:01 AM, Alex Deucher wrote:
>     > smu->workload_mask is IP specific and should not be messed with in
>     > the common code. The mask bits vary across SMU versions.
>     >
>     > Move all handling of smu->workload_mask in to the backends and
>     > simplify the code.  Store the user's preference in
>     smu->power_profile_mode
>     > which will be reflected in sysfs.  For internal driver profile
>     > switches for KFD or VCN, just update the workload mask so that the
>     > user's preference is retained.  Remove all of the extra now unused
>     > workload related elements in the smu structure.
>     >
>     > Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
>     > Signed-off-by: Alex Deucher <alexander.deucher@amd.com
>     <mailto:alexander.deucher@amd.com>>
>     > Cc: Kenneth Feng <kenneth.feng@amd.com <mailto:kenneth.feng@amd.com>>
>     > Cc: Lijo Lazar <lijo.lazar@amd.com <mailto:lijo.lazar@amd.com>>
>     > ---
>     >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 108
>     ++++++------------
>     >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  11 +-
>     >  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  20 ++--
>     >  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  20 ++--
>     >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  21 ++--
>     >  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  17 +--
>     >  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  17 +--
>     >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  33 +++---
>     >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 ++--
>     >  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  24 ++--
>     >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 --
>     >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 -
>     >  12 files changed, 132 insertions(+), 170 deletions(-)
>     >
>     > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>     b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>     > index c3a6b6f20455..162a3289855c 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>     > @@ -1268,9 +1268,6 @@ static int smu_sw_init(struct
>     amdgpu_ip_block *ip_block)
>     >       INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
>     >       atomic64_set(&smu->throttle_int_counter, 0);
>     >       smu->watermarks_bitmap = 0;
>     > -     smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>     > -     smu->default_power_profile_mode =
>     PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>     > -     smu->user_dpm_profile.user_workload_mask = 0;
>     > 
>     >       for (i = 0; i < adev->vcn.num_vcn_inst; i++)
>     >               atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
>     > @@ -1278,33 +1275,12 @@ static int smu_sw_init(struct
>     amdgpu_ip_block *ip_block)
>     >       atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>     >       atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>     > 
>     > -     smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
>     > -     smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
>     > -     smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
>     > -     smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
>     > -     smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
>     > -     smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
>     > -     smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
>     > -
>     >       if (smu->is_apu ||
>     > -         !smu_is_workload_profile_available(smu,
>     PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
>     > -             smu->driver_workload_mask =
>     > -                     1 <<
>     smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
>     > -     } else {
>     > -             smu->driver_workload_mask =
>     > -                     1 <<
>     smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
>     > -             smu->default_power_profile_mode =
>     PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>     > -     }
>     > -
>     > -     smu->workload_mask = smu->driver_workload_mask |
>     > -                                                   
>      smu->user_dpm_profile.user_workload_mask;
>     > -     smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>     > -     smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>     > -     smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
>     > -     smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
>     > -     smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
>     > -     smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
>     > -     smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
>     > +         !smu_is_workload_profile_available(smu,
>     PP_SMC_POWER_PROFILE_FULLSCREEN3D))
>     > +             smu->power_profile_mode =
>     PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>     > +     else
>     > +             smu->power_profile_mode =
>     PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>     > +
>     >       smu->display_config = &adev->pm.pm_display_cfg;
>     > 
>     >       smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
>     > @@ -2252,24 +2228,23 @@ static int smu_enable_umd_pstate(void *handle,
>     >  }
>     > 
>     >  static int smu_bump_power_profile_mode(struct smu_context *smu,
>     > -                                        long *param,
>     > -                                        uint32_t param_size)
>     > +                                    long *param,
>     > +                                    uint32_t param_size,
>     > +                                    bool enable)
>     >  {
>     >       int ret = 0;
>     > 
>     >       if (smu->ppt_funcs->set_power_profile_mode)
>     > -             ret = smu->ppt_funcs->set_power_profile_mode(smu,
>     param, param_size);
>     > +             ret = smu->ppt_funcs->set_power_profile_mode(smu,
>     param, param_size, enable);
>     > 
>     >       return ret;
>     >  }
>     > 
>     >  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>     >                                         enum amd_dpm_forced_level
>     level,
>     > -                                       bool skip_display_settings,
>     > -                                       bool init)
>     > +                                       bool skip_display_settings)
>     >  {
>     >       int ret = 0;
>     > -     int index = 0;
>     >       long workload[1];
>     >       struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>     > 
>     > @@ -2307,13 +2282,10 @@ static int
>     smu_adjust_power_state_dynamic(struct smu_context *smu,
>     >       }
>     > 
>     >       if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
>     > -             smu_dpm_ctx->dpm_level !=
>     AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
>     > -             index = fls(smu->workload_mask);
>     > -             index = index > 0 && index <= WORKLOAD_POLICY_MAX ?
>     index - 1 : 0;
>     > -             workload[0] = smu->workload_setting[index];
>     > +         smu_dpm_ctx->dpm_level !=
>     AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
>     > +             workload[0] = smu->power_profile_mode;
>     > 
>     > -             if (init || smu->power_profile_mode != workload[0])
>     > -                     smu_bump_power_profile_mode(smu, workload, 0);
>     > +             smu_bump_power_profile_mode(smu, workload, 0, true);
>     >       }
>     > 
>     >       return ret;
>     > @@ -2333,13 +2305,13 @@ static int smu_handle_task(struct
>     smu_context *smu,
>     >               ret = smu_pre_display_config_changed(smu);
>     >               if (ret)
>     >                       return ret;
>     > -             ret = smu_adjust_power_state_dynamic(smu, level,
>     false, false);
>     > +             ret = smu_adjust_power_state_dynamic(smu, level, false);
>     >               break;
>     >       case AMD_PP_TASK_COMPLETE_INIT:
>     > -             ret = smu_adjust_power_state_dynamic(smu, level,
>     true, true);
>     > +             ret = smu_adjust_power_state_dynamic(smu, level, true);
>     >               break;
>     >       case AMD_PP_TASK_READJUST_POWER_STATE:
>     > -             ret = smu_adjust_power_state_dynamic(smu, level,
>     true, false);
>     > +             ret = smu_adjust_power_state_dynamic(smu, level, true);
>     >               break;
>     >       default:
>     >               break;
>     > @@ -2361,12 +2333,11 @@ static int smu_handle_dpm_task(void *handle,
>     > 
>     >  static int smu_switch_power_profile(void *handle,
>     >                                   enum PP_SMC_POWER_PROFILE type,
>     > -                                 bool en)
>     > +                                 bool enable)
>     >  {
>     >       struct smu_context *smu = handle;
>     >       struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>     >       long workload[1];
>     > -     uint32_t index;
>     > 
>     >       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>     >               return -EOPNOTSUPP;
>     > @@ -2374,24 +2345,15 @@ static int smu_switch_power_profile(void
>     *handle,
>     >       if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
>     >               return -EINVAL;
>     > 
>     > -     if (!en) {
>     > -             smu->driver_workload_mask &= ~(1 <<
>     smu->workload_priority[type]);
>     > -             index = fls(smu->workload_mask);
>     > -             index = index > 0 && index <= WORKLOAD_POLICY_MAX ?
>     index - 1 : 0;
>     > -             workload[0] = smu->workload_setting[index];
>     > -     } else {
>     > -             smu->driver_workload_mask |= (1 <<
>     smu->workload_priority[type]);
>     > -             index = fls(smu->workload_mask);
>     > -             index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>     > -             workload[0] = smu->workload_setting[index];
>     > -     }
>     > +     /* don't disable the user's preference */
>     > +     if (!enable && type == smu->power_profile_mode)
>     > +             return 0;
>     > 
>     > -     smu->workload_mask = smu->driver_workload_mask |
>     > -                                             
>     smu->user_dpm_profile.user_workload_mask;
>     > +     workload[0] = type;
>     > 
>     >       if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
>     > -             smu_dpm_ctx->dpm_level !=
>     AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
>     > -             smu_bump_power_profile_mode(smu, workload, 0);
>     > +         smu_dpm_ctx->dpm_level !=
>     AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
>     > +             smu_bump_power_profile_mode(smu, workload, 0, enable);
>     > 
>     >       return 0;
>     >  }
>     > @@ -3090,21 +3052,25 @@ static int smu_set_power_profile_mode(void
>     *handle,
>     >                                     uint32_t param_size)
>     >  {
>     >       struct smu_context *smu = handle;
>     > -     int ret;
>     > +     long workload[1];
>     > +     int ret = 0;
>     > 
>     >       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>     >           !smu->ppt_funcs->set_power_profile_mode)
>     >               return -EOPNOTSUPP;
>     > 
>     > -     if (smu->user_dpm_profile.user_workload_mask &
>     > -        (1 << smu->workload_priority[param[param_size]]))
>     > -        return 0;
>     > -
>     > -     smu->user_dpm_profile.user_workload_mask =
>     > -             (1 << smu->workload_priority[param[param_size]]);
>     > -     smu->workload_mask = smu->user_dpm_profile.user_workload_mask |
>     > -             smu->driver_workload_mask;
>     > -     ret = smu_bump_power_profile_mode(smu, param, param_size);
>     > +     if (param[param_size] != smu->power_profile_mode) {
>     > +             /* clear the old user preference */
>     > +             workload[0] = smu->power_profile_mode;
>     > +             ret = smu_bump_power_profile_mode(smu, workload, 0,
>     false);
> 
>     What if internal driver call has set the same profile preference? Once
>     this is done, that setting is lost. There is a check to make sure that
>     user setting is not lost, but the same is not done here and cannot be
>     done with a single profile mode value.
> 
> 
> Yeah, I think we need to ref count the workload hints so we keep the
> mask up to date.
> 

Yes, that will work and will keep the logic uniform.

Frontend could just incr/decr refcount and call backend. Backend gets
mask based on profiles with non-zero refcount. If same as current
workload mask returns, otherwise sets the new one.

Thanks,
Lijo

> Alex
> 
>  
> 
> 
>     Thanks,
>     Lijo
> 
>     > +             if (ret)
>     > +                     return ret;
>     > +             /* set the new user preference */
>     > +             ret = smu_bump_power_profile_mode(smu, param,
>     param_size, true);
>     > +             if (!ret)
>     > +                     /* store the user's preference */
>     > +                     smu->power_profile_mode = param[param_size];
>     > +     }
>     > 
>     >       return ret;
>     >  }
>     > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>     b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>     > index fa93a8879113..cd2db06d752b 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>     > @@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
>     >       /* user clock state information */
>     >       uint32_t clk_mask[SMU_CLK_COUNT];
>     >       uint32_t clk_dependency;
>     > -     uint32_t user_workload_mask;
>     >  };
>     > 
>     >  #define SMU_TABLE_INIT(tables, table_id, s, a, d)    \
>     > @@ -557,12 +556,10 @@ struct smu_context {
>     >       uint32_t hard_min_uclk_req_from_dal;
>     >       bool disable_uclk_switch;
>     > 
>     > +     /* backend specific workload mask */
>     >       uint32_t workload_mask;
>     > -     uint32_t driver_workload_mask;
>     > -     uint32_t workload_priority[WORKLOAD_POLICY_MAX];
>     > -     uint32_t workload_setting[WORKLOAD_POLICY_MAX];
>     > +     /* default/user workload preference */
>     >       uint32_t power_profile_mode;
>     > -     uint32_t default_power_profile_mode;
>     >       bool pm_enabled;
>     >       bool is_apu;
>     > 
>     > @@ -734,8 +731,10 @@ struct pptable_funcs {
>     >        *                          create/set custom power profile
>     modes.
>     >        * &input: Power profile mode parameters.
>     >        * &size: Size of &input.
>     > +      * &enable: enable/disable the profile
>     >        */
>     > -     int (*set_power_profile_mode)(struct smu_context *smu, long
>     *input, uint32_t size);
>     > +     int (*set_power_profile_mode)(struct smu_context *smu, long
>     *input,
>     > +                                   uint32_t size, bool enable);
>     > 
>     >       /**
>     >        * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
>     > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>     b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>     > index 4b36c230e43a..1e44cf6fec4b 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>     > @@ -1443,7 +1443,8 @@ static int
>     arcturus_get_power_profile_mode(struct smu_context *smu,
>     > 
>     >  static int arcturus_set_power_profile_mode(struct smu_context *smu,
>     >                                          long *input,
>     > -                                        uint32_t size)
>     > +                                        uint32_t size,
>     > +                                        bool enable)
>     >  {
>     >       DpmActivityMonitorCoeffInt_t activity_monitor;
>     >       int workload_type = 0;
>     > @@ -1455,8 +1456,9 @@ static int
>     arcturus_set_power_profile_mode(struct smu_context *smu,
>     >               return -EINVAL;
>     >       }
>     > 
>     > -     if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
>     > -          (smu->smc_fw_version >= 0x360d00)) {
>     > +     if (enable &&
>     > +         (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
>     > +         (smu->smc_fw_version >= 0x360d00)) {
>     >               if (size != 10)
>     >                       return -EINVAL;
>     > 
>     > @@ -1520,18 +1522,18 @@ static int
>     arcturus_set_power_profile_mode(struct smu_context *smu,
>     >               return -EINVAL;
>     >       }
>     > 
>     > +     if (enable)
>     > +             smu->workload_mask |= (1 << workload_type);
>     > +     else
>     > +             smu->workload_mask &= ~(1 << workload_type);
>     >       ret = smu_cmn_send_smc_msg_with_param(smu,
>     >                                         SMU_MSG_SetWorkloadMask,
>     >                                         smu->workload_mask,
>     >                                         NULL);
>     > -     if (ret) {
>     > +     if (ret)
>     >               dev_err(smu->adev->dev, "Fail to set workload type
>     %d\n", workload_type);
>     > -             return ret;
>     > -     }
>     > -
>     > -     smu_cmn_assign_power_profile(smu);
>     > 
>     > -     return 0;
>     > +     return ret;
>     >  }
>     > 
>     >  static int arcturus_set_performance_level(struct smu_context *smu,
>     > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>     b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>     > index 211635dabed8..d944a9f954d0 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>     > @@ -2006,19 +2006,19 @@ static int
>     navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
>     >       return size;
>     >  }
>     > 
>     > -static int navi10_set_power_profile_mode(struct smu_context *smu,
>     long *input, uint32_t size)
>     > +static int navi10_set_power_profile_mode(struct smu_context *smu,
>     long *input,
>     > +                                      uint32_t size, bool enable)
>     >  {
>     >       DpmActivityMonitorCoeffInt_t activity_monitor;
>     >       int workload_type, ret = 0;
>     > +     uint32_t profile_mode = input[size];
>     > 
>     > -     smu->power_profile_mode = input[size];
>     > -
>     > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>     > -             dev_err(smu->adev->dev, "Invalid power profile mode
>     %d\n", smu->power_profile_mode);
>     > +     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>     > +             dev_err(smu->adev->dev, "Invalid power profile mode
>     %d\n", profile_mode);
>     >               return -EINVAL;
>     >       }
>     > 
>     > -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>     > +     if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>     >               if (size != 10)
>     >                       return -EINVAL;
>     > 
>     > @@ -2080,16 +2080,18 @@ static int
>     navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
>     >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>     >       workload_type = smu_cmn_to_asic_specific_index(smu,
>     >                                                     
>     CMN2ASIC_MAPPING_WORKLOAD,
>     > -                                                   
>     smu->power_profile_mode);
>     > +                                                    profile_mode);
>     >       if (workload_type < 0)
>     >               return -EINVAL;
>     > 
>     > +     if (enable)
>     > +             smu->workload_mask |= (1 << workload_type);
>     > +     else
>     > +             smu->workload_mask &= ~(1 << workload_type);
>     >       ret = smu_cmn_send_smc_msg_with_param(smu,
>     SMU_MSG_SetWorkloadMask,
>     >                                   smu->workload_mask, NULL);
>     >       if (ret)
>     >               dev_err(smu->adev->dev, "[%s] Failed to set work
>     load mask!", __func__);
>     > -     else
>     > -             smu_cmn_assign_power_profile(smu);
>     > 
>     >       return ret;
>     >  }
>     > diff --git
>     a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>     b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>     > index 844532a9b641..4967e087088b 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>     > @@ -1704,22 +1704,23 @@ static int
>     sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
>     >       return size;
>     >  }
>     > 
>     > -static int sienna_cichlid_set_power_profile_mode(struct
>     smu_context *smu, long *input, uint32_t size)
>     > +static int sienna_cichlid_set_power_profile_mode(struct
>     smu_context *smu,
>     > +                                              long *input,
>     uint32_t size,
>     > +                                              bool enable)
>     >  {
>     > 
>     >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>     >       DpmActivityMonitorCoeffInt_t *activity_monitor =
>     >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>     > +     uint32_t profile_mode = input[size];
>     >       int workload_type, ret = 0;
>     > 
>     > -     smu->power_profile_mode = input[size];
>     > -
>     > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>     > -             dev_err(smu->adev->dev, "Invalid power profile mode
>     %d\n", smu->power_profile_mode);
>     > +     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>     > +             dev_err(smu->adev->dev, "Invalid power profile mode
>     %d\n", profile_mode);
>     >               return -EINVAL;
>     >       }
>     > 
>     > -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>     > +     if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>     >               if (size != 10)
>     >                       return -EINVAL;
>     > 
>     > @@ -1781,16 +1782,18 @@ static int
>     sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>     >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>     >       workload_type = smu_cmn_to_asic_specific_index(smu,
>     >                                                     
>     CMN2ASIC_MAPPING_WORKLOAD,
>     > -                                                   
>     smu->power_profile_mode);
>     > +                                                    profile_mode);
>     >       if (workload_type < 0)
>     >               return -EINVAL;
>     > 
>     > +     if (enable)
>     > +             smu->workload_mask |= (1 << workload_type);
>     > +     else
>     > +             smu->workload_mask &= ~(1 << workload_type);
>     >       ret = smu_cmn_send_smc_msg_with_param(smu,
>     SMU_MSG_SetWorkloadMask,
>     >                                   smu->workload_mask, NULL);
>     >       if (ret)
>     >               dev_err(smu->adev->dev, "[%s] Failed to set work
>     load mask!", __func__);
>     > -     else
>     > -             smu_cmn_assign_power_profile(smu);
>     > 
>     >       return ret;
>     >  }
>     > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>     b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>     > index f89c487dce72..b5dba4826f81 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>     > @@ -1056,7 +1056,8 @@ static int
>     vangogh_get_power_profile_mode(struct smu_context *smu,
>     >       return size;
>     >  }
>     > 
>     > -static int vangogh_set_power_profile_mode(struct smu_context
>     *smu, long *input, uint32_t size)
>     > +static int vangogh_set_power_profile_mode(struct smu_context
>     *smu, long *input,
>     > +                                       uint32_t size, bool enable)
>     >  {
>     >       int workload_type, ret;
>     >       uint32_t profile_mode = input[size];
>     > @@ -1067,7 +1068,7 @@ static int
>     vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>     >       }
>     > 
>     >       if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>     > -                     profile_mode ==
>     PP_SMC_POWER_PROFILE_POWERSAVING)
>     > +         profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>     >               return 0;
>     > 
>     >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>     > @@ -1080,18 +1081,18 @@ static int
>     vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>     >               return -EINVAL;
>     >       }
>     > 
>     > +     if (enable)
>     > +             smu->workload_mask |= (1 << workload_type);
>     > +     else
>     > +             smu->workload_mask &= ~(1 << workload_type);
>     >       ret = smu_cmn_send_smc_msg_with_param(smu,
>     SMU_MSG_ActiveProcessNotify,
>     >                                   smu->workload_mask,
>     >                                   NULL);
>     > -     if (ret) {
>     > +     if (ret)
>     >               dev_err_once(smu->adev->dev, "Fail to set workload
>     type %d\n",
>     >                                       workload_type);
>     > -             return ret;
>     > -     }
>     > -
>     > -     smu_cmn_assign_power_profile(smu);
>     > 
>     > -     return 0;
>     > +     return ret;
>     >  }
>     > 
>     >  static int vangogh_set_soft_freq_limited_range(struct smu_context
>     *smu,
>     > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>     b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>     > index 75a9ea87f419..2d1eae79ab9d 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>     > @@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct
>     smu_context *smu,
>     >       return ret;
>     >  }
>     > 
>     > -static int renoir_set_power_profile_mode(struct smu_context *smu,
>     long *input, uint32_t size)
>     > +static int renoir_set_power_profile_mode(struct smu_context *smu,
>     long *input,
>     > +                                      uint32_t size, bool enable)
>     >  {
>     >       int workload_type, ret;
>     >       uint32_t profile_mode = input[size];
>     > @@ -875,7 +876,7 @@ static int
>     renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>     >       }
>     > 
>     >       if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>     > -                     profile_mode ==
>     PP_SMC_POWER_PROFILE_POWERSAVING)
>     > +         profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>     >               return 0;
>     > 
>     >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>     > @@ -891,17 +892,17 @@ static int
>     renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>     >               return -EINVAL;
>     >       }
>     > 
>     > +     if (enable)
>     > +             smu->workload_mask |= (1 << workload_type);
>     > +     else
>     > +             smu->workload_mask &= ~(1 << workload_type);
>     >       ret = smu_cmn_send_smc_msg_with_param(smu,
>     SMU_MSG_ActiveProcessNotify,
>     >                                   smu->workload_mask,
>     >                                   NULL);
>     > -     if (ret) {
>     > +     if (ret)
>     >               dev_err_once(smu->adev->dev, "Fail to set workload
>     type %d\n", workload_type);
>     > -             return ret;
>     > -     }
>     > 
>     > -     smu_cmn_assign_power_profile(smu);
>     > -
>     > -     return 0;
>     > +     return ret;
>     >  }
>     > 
>     >  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
>     > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>     b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>     > index 80c6b1e523aa..3cc734331891 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>     > @@ -2573,22 +2573,22 @@ static int
>     smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
>     > 
>     >  static int smu_v13_0_0_set_power_profile_mode(struct smu_context
>     *smu,
>     >                                             long *input,
>     > -                                           uint32_t size)
>     > +                                           uint32_t size,
>     > +                                           bool enable)
>     >  {
>     >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>     >       DpmActivityMonitorCoeffInt_t *activity_monitor =
>     >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>     > +     uint32_t profile_mode = input[size];
>     >       int workload_type, ret = 0;
>     >       u32 workload_mask;
>     > 
>     > -     smu->power_profile_mode = input[size];
>     > -
>     > -     if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>     > -             dev_err(smu->adev->dev, "Invalid power profile mode
>     %d\n", smu->power_profile_mode);
>     > +     if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>     > +             dev_err(smu->adev->dev, "Invalid power profile mode
>     %d\n", profile_mode);
>     >               return -EINVAL;
>     >       }
>     > 
>     > -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>     > +     if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>     >               if (size != 9)
>     >                       return -EINVAL;
>     > 
>     > @@ -2641,13 +2641,18 @@ static int
>     smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>     >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>     >       workload_type = smu_cmn_to_asic_specific_index(smu,
>     >                                                     
>     CMN2ASIC_MAPPING_WORKLOAD,
>     > -                                                   
>     smu->power_profile_mode);
>     > +                                                    profile_mode);
>     > 
>     >       if (workload_type < 0)
>     >               return -EINVAL;
>     > 
>     >       workload_mask = 1 << workload_type;
>     > 
>     > +     if (enable)
>     > +             smu->workload_mask |= workload_mask;
>     > +     else
>     > +             smu->workload_mask &= ~workload_mask;
>     > +
>     >       /* Add optimizations for SMU13.0.0/10.  Reuse the power
>     saving profile */
>     >       if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
>     IP_VERSION(13, 0, 0) &&
>     >            ((smu->adev->pm.fw_version == 0x004e6601) ||
>     > @@ -2658,25 +2663,13 @@ static int
>     smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>     >                                                             
>     CMN2ASIC_MAPPING_WORKLOAD,
>     >                                                             
>     PP_SMC_POWER_PROFILE_POWERSAVING);
>     >               if (workload_type >= 0)
>     > -                     workload_mask |= 1 << workload_type;
>     > +                     smu->workload_mask |= 1 << workload_type;
>     >       }
>     > 
>     > -     smu->workload_mask |= workload_mask;
>     >       ret = smu_cmn_send_smc_msg_with_param(smu,
>     >                                              SMU_MSG_SetWorkloadMask,
>     >                                              smu->workload_mask,
>     >                                              NULL);
>     > -     if (!ret) {
>     > -             smu_cmn_assign_power_profile(smu);
>     > -             if (smu->power_profile_mode ==
>     PP_SMC_POWER_PROFILE_POWERSAVING) {
>     > -                     workload_type =
>     smu_cmn_to_asic_specific_index(smu,
>     > -                                                           
>     CMN2ASIC_MAPPING_WORKLOAD,
>     > -                                                           
>     PP_SMC_POWER_PROFILE_FULLSCREEN3D);
>     > -                     smu->power_profile_mode = smu->workload_mask
>     & (1 << workload_type)
>     > -                                                                 
>                ? PP_SMC_POWER_PROFILE_FULLSCREEN3D
>     > -                                                                 
>                : PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>     > -             }
>     > -     }
>     > 
>     >       return ret;
>     >  }
>     > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>     b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>     > index c5d3e25cc967..1aafd23857f0 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>     > @@ -2528,22 +2528,23 @@ do {                                     
>                                                                 \
>     >       return result;
>     >  }
>     > 
>     > -static int smu_v13_0_7_set_power_profile_mode(struct smu_context
>     *smu, long *input, uint32_t size)
>     > +static int smu_v13_0_7_set_power_profile_mode(struct smu_context
>     *smu,
>     > +                                           long *input, uint32_t
>     size,
>     > +                                           bool enable)
>     >  {
>     > 
>     >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>     >       DpmActivityMonitorCoeffInt_t *activity_monitor =
>     >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>     > +     uint32_t profile_mode = input[size];
>     >       int workload_type, ret = 0;
>     > 
>     > -     smu->power_profile_mode = input[size];
>     > -
>     > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
>     > -             dev_err(smu->adev->dev, "Invalid power profile mode
>     %d\n", smu->power_profile_mode);
>     > +     if (profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
>     > +             dev_err(smu->adev->dev, "Invalid power profile mode
>     %d\n", profile_mode);
>     >               return -EINVAL;
>     >       }
>     > 
>     > -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>     > +     if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>     >               if (size != 8)
>     >                       return -EINVAL;
>     > 
>     > @@ -2590,17 +2591,19 @@ static int
>     smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>     >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>     >       workload_type = smu_cmn_to_asic_specific_index(smu,
>     >                                                     
>     CMN2ASIC_MAPPING_WORKLOAD,
>     > -                                                   
>     smu->power_profile_mode);
>     > +                                                    profile_mode);
>     >       if (workload_type < 0)
>     >               return -EINVAL;
>     > 
>     > +     if (enable)
>     > +             smu->workload_mask |= (1 << workload_type);
>     > +     else
>     > +             smu->workload_mask &= ~(1 << workload_type);
>     >       ret = smu_cmn_send_smc_msg_with_param(smu,
>     SMU_MSG_SetWorkloadMask,
>     >                                   smu->workload_mask, NULL);
>     > 
>     >       if (ret)
>     >               dev_err(smu->adev->dev, "[%s] Failed to set work
>     load mask!", __func__);
>     > -     else
>     > -             smu_cmn_assign_power_profile(smu);
>     > 
>     >       return ret;
>     >  }
>     > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>     b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>     > index 59b369eff30f..695480833603 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>     > @@ -1719,21 +1719,22 @@ static int
>     smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
>     > 
>     >  static int smu_v14_0_2_set_power_profile_mode(struct smu_context
>     *smu,
>     >                                             long *input,
>     > -                                           uint32_t size)
>     > +                                           uint32_t size,
>     > +                                           bool enable)
>     >  {
>     >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>     >       DpmActivityMonitorCoeffInt_t *activity_monitor =
>     >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>     > +     uint32_t profile_mode = input[size];
>     >       int workload_type, ret = 0;
>     >       uint32_t current_profile_mode = smu->power_profile_mode;
>     > -     smu->power_profile_mode = input[size];
>     > 
>     > -     if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>     > -             dev_err(smu->adev->dev, "Invalid power profile mode
>     %d\n", smu->power_profile_mode);
>     > +     if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>     > +             dev_err(smu->adev->dev, "Invalid power profile mode
>     %d\n", profile_mode);
>     >               return -EINVAL;
>     >       }
>     > 
>     > -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>     > +     if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>     >               if (size != 9)
>     >                       return -EINVAL;
>     > 
>     > @@ -1783,7 +1784,7 @@ static int
>     smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>     >               }
>     >       }
>     > 
>     > -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
>     > +     if (profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
>     >               smu_v14_0_deep_sleep_control(smu, false);
>     >       else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
>     >               smu_v14_0_deep_sleep_control(smu, true);
>     > @@ -1791,15 +1792,16 @@ static int
>     smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>     >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>     >       workload_type = smu_cmn_to_asic_specific_index(smu,
>     >                                                     
>     CMN2ASIC_MAPPING_WORKLOAD,
>     > -                                                   
>     smu->power_profile_mode);
>     > +                                                    profile_mode);
>     >       if (workload_type < 0)
>     >               return -EINVAL;
>     > 
>     > +     if (enable)
>     > +             smu->workload_mask |= (1 << workload_type);
>     > +     else
>     > +             smu->workload_mask &= ~(1 << workload_type);
>     >       ret = smu_cmn_send_smc_msg_with_param(smu,
>     SMU_MSG_SetWorkloadMask,
>     > -                                                                 
>                  smu->workload_mask, NULL);
>     > -
>     > -     if (!ret)
>     > -             smu_cmn_assign_power_profile(smu);
>     > +                                           smu->workload_mask, NULL);
>     > 
>     >       return ret;
>     >  }
>     > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>     b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>     > index fd2aa949538e..63c4f75fa118 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>     > @@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct
>     smu_context *smu,
>     >       return ret;
>     >  }
>     > 
>     > -void smu_cmn_assign_power_profile(struct smu_context *smu)
>     > -{
>     > -     uint32_t index;
>     > -     index = fls(smu->workload_mask);
>     > -     index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index -
>     1 : 0;
>     > -     smu->power_profile_mode = smu->workload_setting[index];
>     > -}
>     > -
>     >  bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
>     >  {
>     >       struct pci_dev *p = NULL;
>     > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>     b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>     > index 8a801e389659..1de685defe85 100644
>     > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>     > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>     > @@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void
>     *table, uint8_t frev, uint8_t crev);
>     >  int smu_cmn_set_mp1_state(struct smu_context *smu,
>     >                         enum pp_mp1_state mp1_state);
>     > 
>     > -void smu_cmn_assign_power_profile(struct smu_context *smu);
>     > -
>     >  /*
>     >   * Helper function to make sysfs_emit_at() happy. Align buf to
>     >   * the current page boundary and record the offset.
> 
