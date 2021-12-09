Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBA3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834C810EA83;
	Thu,  9 Dec 2021 16:54:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5985C89FFD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 12:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqfz4hGzAdnZfZkG9hez87EUIs5AXsZIQTRF6S953D3jYnc6bLBi9jL/u/uKeW8ztP0QfwK4mNGe2pyK2SNFrf/l8pON2OlG+OvHRFyziIzV+SDyowu6hCOOz8o3PvYDTQqbAX0xRu3OK42BbDIpoEKp8lCVCdXM0bGg1htPylP4kcUVafPdoxJVvutqh4/tp1IWdXqAYF7DVEaxG0GtDujSP8euMoCAaeGvNCqJ9kRFqlwn8poDgQwIl4RCTlY/ezovgWPMrDF51w4dCQoNTiorfGzpMxLyBeweUPzny02ncKzAl/TOyaVkVIZX1Ce4FzBviE+iZeFh4OFzOvaCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/n10ChXIxazgm75dMjYuxkd+vR0S1QgIDkjFkcLbP4=;
 b=Ius549J6GVppxKCIcEFr7h/DgVA/KROp6KzfWsDmTSWcEfI0Zj2YS1TbJgi3fsn+UJ5bvIzMfNtpaj/sfVAf9oQD1a2g9WYa8q9aVytOV7dn8lIhvLAcHNWkAE2fZXTpn2qw9OmV1obr+FMBsUWDXSkL+tvrq+6az6JHi1lkhZevkMiiasbmbJX9PUhcZdjG2jYDQKoNbB/I/dtPsABzd13ZAeaPGAG4LhqvVLIXXwnm5xnK4LegfYNGhnldiXB695WXTg4s9kreyorXvXjhgOth1CLHu4LPOxt1gfsl25MZHtQsGdiz38FJsAExThmqjhsIxR+bppL5J2HRxfG5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/n10ChXIxazgm75dMjYuxkd+vR0S1QgIDkjFkcLbP4=;
 b=SLg5xwqFy3VwEU115YHiCwmHAqWoGi9JGTs1YMTLScBLkE+V7kR5QRGnBBzAxPb97ajTxCO+rZ5wwRUQ9BYoeD5ul+A4NxF8RUkeXOQqNb8I9KMyqyOvFFAx+645SH4LqJTkZN/EhT97JDFqcw/BanO1CR1hTraITgp5hrNw73A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 12:40:52 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 12:40:52 +0000
Message-ID: <ea563a90-49e5-0c83-a37e-925b6e9883cf@amd.com>
Date: Thu, 9 Dec 2021 18:10:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 14/17] drm/amd/pm: relocate the power related headers
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211203030540.1710564-1-evan.quan@amd.com>
 <20211203030540.1710564-14-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211203030540.1710564-14-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::33) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21d895e6-ba4f-45e5-42b3-08d9bb112296
X-MS-TrafficTypeDiagnostic: DM6PR12MB3929:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3929506E350E2F09126DFDD697709@DM6PR12MB3929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goXnpf8B4bE0xSRpIpBWtx77gG2HP/S4Up7OzY4QrffCuNeo3120ncQmWKkn6ABa2K9E0rRq8raUIZ/ESo38q9gIYCuXehLjRqccauVzGe37AXqqMNGEBrtvbG4BoAhRRe8eklfTHlaNxgXTITU7uInbTuFAIUTiIehBL4KHnLtvCqkPs7fMRZ5iBL+yoftUcHTuFst4U61r9dlHSmqT//SmmY4VcHPiuFpJ8LeMuTRrxGJZvRaMCo61KnZkBK45DSXJku60RwTziCuc8avWgkG/9qJhs5tBrSTW+SCUkn69nLX8xhSmEkuSH0Aliy/KzyeNOMhZolMQ+98t1oY29dXlPA5lTjodL4cgIKathSqYF7HZkLAZnuMXQ403s9o4ex1d86qE5VkCNk9jz2umLHdZAb4IsHjdt5I0uakH2iibtjKoGRB4mvS4Fsu2zAuTpN4Buua9jgT/vBcNJpfp6nlev1fQycdLAiz0mGf78984fo5KMQrWE7ihwMonegSSjUUKjRnnk0R11nKHyflMoAHeGqldiugaQV8iN4qE+cpPqQ2bNbchK9QX68gHGYxn12EKXMX1rxjQXRzNrCNYb4v8ZV+UJFo9dHP01BWJIWs44/Wqq90/THM5OkDahLu4BR2ggmlwq3/KaQpK4UmFRuQYPpm1T9RzOwhskMCFU+10unqSds7FBpiPzjB902J/i8yZx6At0ezQnnkX9JIhEp/sOgtGjKUJV1ODU1z5OsIg3krArOWSXMvH2X1Apu/K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(31696002)(508600001)(86362001)(4326008)(8936002)(53546011)(6506007)(2906002)(316002)(26005)(31686004)(83380400001)(186003)(6486002)(66556008)(6666004)(66476007)(66946007)(2616005)(30864003)(38100700002)(8676002)(6512007)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vjgxci9JUlZNY0xOV0NOaUU2d0tSbnRQdkJCdlJITDdWVjNCamZrQUdKSkM2?=
 =?utf-8?B?YVZUTkZ0MlY1VTNRWFJtYXVGY01UQ05kOFhsMU1rWWtoOTdlRS93bG9TeStP?=
 =?utf-8?B?NjAwRnpmZ0pwTUVYVWNRYktmdzRiVHhZWUkvVlZtbmUvN29hVVRBYVd1RndU?=
 =?utf-8?B?Yk45aUUveTR3K1o5SndQODlwRTFIR3hUQlY5SlpKbTA1cG1FMHlBdGZsZTlY?=
 =?utf-8?B?NlZQVkdwS1FBREt0c0VzcUxlK0dwLzRNRHlVSjZ2UFh6bWppelJuS0Y1czB6?=
 =?utf-8?B?U24zbHhRT1ZHM3p2VVBoK0ZjTEwwUUU0eGYybWNkN3VUdzVWUTVna1BOeTNl?=
 =?utf-8?B?S25JNGY0OGhWT05qS0JpTlNONjhlL2E4M3BSU1kxdEYrRko0K2hRd0RvZXhH?=
 =?utf-8?B?RUJ3cUgwRkZwODh3SjBybjBsZ2N3cGdoa2swMjNUcE1uNncwWDVqamNDbWMz?=
 =?utf-8?B?b3BGVElvb3QrbEdGclkzdVVVTFl1MDkxTHU0TlBqK3ZQRDEvT2wxTk1KWk0z?=
 =?utf-8?B?cm91Nmx3UVlzelZ5TXBKMDFZOWUzZG53SHA2M0o5TnBucWkxTnlkRDd3WGRU?=
 =?utf-8?B?bERacTY2N2ppQ3pSRHhySldhcFZUeDhoQWphZU1rU1poUWhtRm16MGpza2Rs?=
 =?utf-8?B?ZzVGSSs2UW5PV0FkZThlZGc3b0R3S21Xb0QrUERoWFI1ZUt1bU83eEdNNUJX?=
 =?utf-8?B?THFnS2RZeVZleFFQZHcrMGYrVEF0VkpmUks4VVpjNXJXN3Y4aHpvR2dOakdO?=
 =?utf-8?B?ODhZWE03VVFPY2lieWNlTkZzdXZwZWk1ZGdKRzVwYkVYb1pkYjZpcmVkWVhu?=
 =?utf-8?B?MCtJak5WdUx3TEcxM1VZRGdMMzR1Q3JkVjlYRGJPeTNhZGs2SFdXZFNwVUpT?=
 =?utf-8?B?N0FhTngxL1IyUVo4TElBZFhlcjBHbDlUTzZtTWJzZUgzenI5ejMzV0Z3UWo4?=
 =?utf-8?B?YXE4WURYcU5xNVdzdXg1T2JJbFFMYzlYaHBETHN2bktaU0o2bnhTa0hDQXVa?=
 =?utf-8?B?VXY3Y2tjZWdRNmZBeWxtL2J0MWR0VFVZWHFnNFVOZER1SDJwSHRLQUwzNzl4?=
 =?utf-8?B?cGttaFl0a0NIeUQ5eU4wU2hwU3MrZ05qWnBnT0kySkxTWFcwYlVRVFY2MDNn?=
 =?utf-8?B?eTRJbGJjTHZRZldUcHY3UXI5aVhIM3NvN0FCVzc1NUxVTDNhTHZrTkN2TThm?=
 =?utf-8?B?RW4wd1A2NHNxZHZ4b2RCRXZaTk1oejVyd2hvcjBoSVFvbnlXZ1loU1JSNUh0?=
 =?utf-8?B?K1MvY3VvRjdpMW1oc2IxK0V0Mk93bWNtcFBLYVQ5L0FxZUhPTXR2VlMwWURh?=
 =?utf-8?B?bXZtMTBUR0I0cTNMSjZCdWdRQklpK1Zaa2ZUZlNVZjkyUkhablpoMXdRYXhP?=
 =?utf-8?B?NDJRWEJLa0prS1ZtUTBJYkwxRkVjbTVDVTJmeVEwdmNwNk5LdE0rL25mREFr?=
 =?utf-8?B?WHpDWEpxNjlYTVhncWQ4U0c0OWZScXpqNzRUODJiOFJybXJPNGFhRUt5OEFq?=
 =?utf-8?B?YzZKanZJK0FOQzFXeXlENXppdFlvTVdNbUs3VHZFdHFFRkdodUJtT0RjcFAw?=
 =?utf-8?B?aExJT1UxcjMzTE8wdThVSE1hMWZHTFNPb3FzSmpOQlFXbWo4K0l3TEo5UEVx?=
 =?utf-8?B?KzZjTjF2VHNoSEVzNW5UMVhhNWFMZW83bkdtOHVkV2lzWVovUkxPMDQ1N2lF?=
 =?utf-8?B?QkNPQjVpYWkxUk9zdTdPTDRpdTA5U2xhMVRIaHEveEhPaG1xTExvVktKTmwv?=
 =?utf-8?B?M0FSc0lUSE9HWmhsSDBvSHlaZm12TTQ2YndMM2svTWhKbDlZazRWSFlvNW10?=
 =?utf-8?B?MEk2SXhkQ2VzM2pKSnVkMWU1QkErNzhkbVUwTHk5ZnVXRGxSaVJSZkhtSXlB?=
 =?utf-8?B?TktqZnBiZjlvQWc1M1B0blRUY3pOWWxUM01UeFF5YnFWM2VJZTVpZEx4WitZ?=
 =?utf-8?B?THdXWDduZHRNWFpJcktiMFFreExza01kMFgrWVp1aVNhOGk3T3BJMjFiQ2Jl?=
 =?utf-8?B?dERLMXFEcGJxVDdZRkJ4VTFDUmxVMzZmaXJzRVZFYm5FMG81N0Mrc2N0eFVt?=
 =?utf-8?B?LzZCdFR0WXBaRlJnT3FIWS9NNTY1bVFQNVRCNndkamw1V3NrUklnaTYrUHZp?=
 =?utf-8?Q?QbQI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d895e6-ba4f-45e5-42b3-08d9bb112296
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 12:40:52.4963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z41UKjqa4/punEP0SxLQGd3tl9VVYQlu1Z71yC+ftOQBRnPAm3Rx1WqUavxtx5YY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3929
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/3/2021 8:35 AM, Evan Quan wrote:
> Instead of centralizing all headers in the same folder. Separate them into
> different folders and place them among those source files those who really
> need them.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Id74cb4c7006327ca7ecd22daf17321e417c4aa71
> ---
>   drivers/gpu/drm/amd/pm/Makefile               | 10 +++---
>   drivers/gpu/drm/amd/pm/legacy-dpm/Makefile    | 32 +++++++++++++++++++
>   .../pm/{powerplay => legacy-dpm}/cik_dpm.h    |  0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.c |  0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.h |  0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_smc.c |  0
>   .../pm/{powerplay => legacy-dpm}/legacy_dpm.c |  0
>   .../pm/{powerplay => legacy-dpm}/legacy_dpm.h |  0
>   .../amd/pm/{powerplay => legacy-dpm}/ppsmc.h  |  0
>   .../pm/{powerplay => legacy-dpm}/r600_dpm.h   |  0
>   .../amd/pm/{powerplay => legacy-dpm}/si_dpm.c |  0
>   .../amd/pm/{powerplay => legacy-dpm}/si_dpm.h |  0
>   .../amd/pm/{powerplay => legacy-dpm}/si_smc.c |  0
>   .../{powerplay => legacy-dpm}/sislands_smc.h  |  0
>   drivers/gpu/drm/amd/pm/powerplay/Makefile     |  6 +---
>   .../pm/{ => powerplay}/inc/amd_powerplay.h    |  0
>   .../drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h |  0
>   .../amd/pm/{ => powerplay}/inc/fiji_ppsmc.h   |  0
>   .../pm/{ => powerplay}/inc/hardwaremanager.h  |  0
>   .../drm/amd/pm/{ => powerplay}/inc/hwmgr.h    |  0
>   .../{ => powerplay}/inc/polaris10_pwrvirus.h  |  0
>   .../amd/pm/{ => powerplay}/inc/power_state.h  |  0
>   .../drm/amd/pm/{ => powerplay}/inc/pp_debug.h |  0
>   .../amd/pm/{ => powerplay}/inc/pp_endian.h    |  0
>   .../amd/pm/{ => powerplay}/inc/pp_thermal.h   |  0
>   .../amd/pm/{ => powerplay}/inc/ppinterrupt.h  |  0
>   .../drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu10.h    |  0
>   .../pm/{ => powerplay}/inc/smu10_driver_if.h  |  0
>   .../pm/{ => powerplay}/inc/smu11_driver_if.h  |  0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu71.h    |  0
>   .../pm/{ => powerplay}/inc/smu71_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu72.h    |  0
>   .../pm/{ => powerplay}/inc/smu72_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu73.h    |  0
>   .../pm/{ => powerplay}/inc/smu73_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu74.h    |  0
>   .../pm/{ => powerplay}/inc/smu74_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu75.h    |  0
>   .../pm/{ => powerplay}/inc/smu75_discrete.h   |  0
>   .../amd/pm/{ => powerplay}/inc/smu7_common.h  |  0
>   .../pm/{ => powerplay}/inc/smu7_discrete.h    |  0
>   .../amd/pm/{ => powerplay}/inc/smu7_fusion.h  |  0
>   .../amd/pm/{ => powerplay}/inc/smu7_ppsmc.h   |  0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h |  0
>   .../amd/pm/{ => powerplay}/inc/smu8_fusion.h  |  0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h |  0
>   .../pm/{ => powerplay}/inc/smu9_driver_if.h   |  0
>   .../{ => powerplay}/inc/smu_ucode_xfer_cz.h   |  0
>   .../{ => powerplay}/inc/smu_ucode_xfer_vi.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smumgr.h   |  0
>   .../amd/pm/{ => powerplay}/inc/tonga_ppsmc.h  |  0
>   .../amd/pm/{ => powerplay}/inc/vega10_ppsmc.h |  0
>   .../inc/vega12/smu9_driver_if.h               |  0
>   .../amd/pm/{ => powerplay}/inc/vega12_ppsmc.h |  0
>   .../amd/pm/{ => powerplay}/inc/vega20_ppsmc.h |  0
>   .../amd/pm/{ => swsmu}/inc/aldebaran_ppsmc.h  |  0
>   .../drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h   |  0
>   .../amd/pm/{ => swsmu}/inc/arcturus_ppsmc.h   |  0
>   .../inc/smu11_driver_if_arcturus.h            |  0
>   .../inc/smu11_driver_if_cyan_skillfish.h      |  0
>   .../{ => swsmu}/inc/smu11_driver_if_navi10.h  |  0
>   .../inc/smu11_driver_if_sienna_cichlid.h      |  0
>   .../{ => swsmu}/inc/smu11_driver_if_vangogh.h |  0
>   .../amd/pm/{ => swsmu}/inc/smu12_driver_if.h  |  0
>   .../inc/smu13_driver_if_aldebaran.h           |  0
>   .../inc/smu13_driver_if_yellow_carp.h         |  0
>   .../pm/{ => swsmu}/inc/smu_11_0_cdr_table.h   |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_types.h    |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h    |  0
>   .../pm/{ => swsmu}/inc/smu_v11_0_7_ppsmc.h    |  0
>   .../pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h  |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_0_ppsmc.h  |  0
>   .../pm/{ => swsmu}/inc/smu_v11_0_pptable.h    |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_5_pmfw.h   |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_5_ppsmc.h  |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_8_pmfw.h   |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_8_ppsmc.h  |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h    |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v12_0_ppsmc.h  |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h    |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v13_0_1_pmfw.h |  0
>   .../pm/{ => swsmu}/inc/smu_v13_0_1_ppsmc.h    |  0
>   .../pm/{ => swsmu}/inc/smu_v13_0_pptable.h    |  0
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 -
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 -
>   87 files changed, 39 insertions(+), 11 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/cik_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_smc.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/legacy_dpm.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/legacy_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/r600_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_smc.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/sislands_smc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/amd_powerplay.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/fiji_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hardwaremanager.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hwmgr.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/polaris10_pwrvirus.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/power_state.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_debug.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_endian.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_thermal.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/ppinterrupt.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu11_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_common.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_fusion.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8_fusion.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_cz.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_vi.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smumgr.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/tonga_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega10_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12/smu9_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega20_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/aldebaran_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/arcturus_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_arcturus.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_cyan_skillfish.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_navi10.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_sienna_cichlid.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_vangogh.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu12_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu13_driver_if_aldebaran.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu13_driver_if_yellow_carp.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_11_0_cdr_table.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_types.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_pptable.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_5_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_5_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_8_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_8_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_1_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_1_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_pptable.h (100%)

Since this is done anyway, suggest to move firmware specific headers 
(interface/messsages etc.) to separate folder.

Thanks,
Lijo

> 
> diff --git a/drivers/gpu/drm/amd/pm/Makefile b/drivers/gpu/drm/amd/pm/Makefile
> index d35ffde387f1..84c7203b5e46 100644
> --- a/drivers/gpu/drm/amd/pm/Makefile
> +++ b/drivers/gpu/drm/amd/pm/Makefile
> @@ -21,20 +21,22 @@
>   #
>   
>   subdir-ccflags-y += \
> -		-I$(FULL_AMD_PATH)/pm/inc/  \
>   		-I$(FULL_AMD_PATH)/include/asic_reg  \
>   		-I$(FULL_AMD_PATH)/include  \
> +		-I$(FULL_AMD_PATH)/pm/inc/  \
>   		-I$(FULL_AMD_PATH)/pm/swsmu \
> +		-I$(FULL_AMD_PATH)/pm/swsmu/inc \
>   		-I$(FULL_AMD_PATH)/pm/swsmu/smu11 \
>   		-I$(FULL_AMD_PATH)/pm/swsmu/smu12 \
>   		-I$(FULL_AMD_PATH)/pm/swsmu/smu13 \
> -		-I$(FULL_AMD_PATH)/pm/powerplay \
> +		-I$(FULL_AMD_PATH)/pm/powerplay/inc \
>   		-I$(FULL_AMD_PATH)/pm/powerplay/smumgr\
> -		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr
> +		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr \
> +		-I$(FULL_AMD_PATH)/pm/legacy-dpm
>   
>   AMD_PM_PATH = ../pm
>   
> -PM_LIBS = swsmu powerplay
> +PM_LIBS = swsmu powerplay legacy-dpm
>   
>   AMD_PM = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/,$(PM_LIBS)))
>   
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
> new file mode 100644
> index 000000000000..baa4265d1daa
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
> @@ -0,0 +1,32 @@
> +#
> +# Copyright 2021 Advanced Micro Devices, Inc.
> +#
> +# Permission is hereby granted, free of charge, to any person obtaining a
> +# copy of this software and associated documentation files (the "Software"),
> +# to deal in the Software without restriction, including without limitation
> +# the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +# and/or sell copies of the Software, and to permit persons to whom the
> +# Software is furnished to do so, subject to the following conditions:
> +#
> +# The above copyright notice and this permission notice shall be included in
> +# all copies or substantial portions of the Software.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> +# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> +# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> +# OTHER DEALINGS IN THE SOFTWARE.
> +#
> +
> +AMD_LEGACYDPM_PATH = ../pm/legacy-dpm
> +
> +LEGACYDPM_MGR-y = legacy_dpm.o
> +
> +LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
> +LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
> +
> +AMD_LEGACYDPM_POWER = $(addprefix $(AMD_LEGACYDPM_PATH)/,$(LEGACYDPM_MGR-y))
> +
> +AMD_POWERPLAY_FILES += $(AMD_LEGACYDPM_POWER)
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/kv_smc.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/ppsmc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/ppsmc.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/si_smc.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/Makefile b/drivers/gpu/drm/amd/pm/powerplay/Makefile
> index 614d8b6a58ad..795a3624cbbf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/Makefile
> +++ b/drivers/gpu/drm/amd/pm/powerplay/Makefile
> @@ -28,11 +28,7 @@ AMD_POWERPLAY = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/powerplay/
>   
>   include $(AMD_POWERPLAY)
>   
> -POWER_MGR-y = amd_powerplay.o legacy_dpm.o
> -
> -POWER_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
> -
> -POWER_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
> +POWER_MGR-y = amd_powerplay.o
>   
>   AMD_PP_POWER = $(addprefix $(AMD_PP_PATH)/,$(POWER_MGR-y))
>   
> diff --git a/drivers/gpu/drm/amd/pm/inc/amd_powerplay.h b/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/amd_powerplay.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/hardwaremanager.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/hardwaremanager.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/hwmgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h b/drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/power_state.h b/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/power_state.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_debug.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/pp_debug.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_endian.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/pp_endian.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/pp_thermal.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/ppinterrupt.h b/drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/ppinterrupt.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu10.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu10.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu71.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu71.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu71_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu71_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu72.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu72.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu72_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu72_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu73.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu73.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu73_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu73_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu74.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu74.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu74_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu75.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu75.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu75_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu75_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_common.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_common.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_fusion.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_fusion.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu8.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu8.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu8_fusion.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu8_fusion.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu9.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu9.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/aldebaran_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/aldebaran_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/arcturus_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/arcturus_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_arcturus.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_arcturus.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_cyan_skillfish.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_cyan_skillfish.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_navi10.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_navi10.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_sienna_cichlid.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_sienna_cichlid.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_vangogh.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_vangogh.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu12_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu12_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_aldebaran.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_aldebaran.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_yellow_carp.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_yellow_carp.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_types.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_pmfw.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_pmfw.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_pmfw.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_pmfw.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_pmfw.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_pmfw.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index a03bbd2a7aa0..1e6d76657bbb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -33,7 +33,6 @@
>   #include "smu11_driver_if_arcturus.h"
>   #include "soc15_common.h"
>   #include "atom.h"
> -#include "power_state.h"
>   #include "arcturus_ppt.h"
>   #include "smu_v11_0_pptable.h"
>   #include "arcturus_ppsmc.h"
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 3c82f5455f88..cc502a35f9ef 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -33,7 +33,6 @@
>   #include "smu13_driver_if_aldebaran.h"
>   #include "soc15_common.h"
>   #include "atom.h"
> -#include "power_state.h"
>   #include "aldebaran_ppt.h"
>   #include "smu_v13_0_pptable.h"
>   #include "aldebaran_ppsmc.h"
> 
