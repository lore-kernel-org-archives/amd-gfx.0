Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4E7C369CB
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Apr 2025 07:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E86B10E9E4;
	Sat, 26 Apr 2025 07:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="coykAmjm";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C773410E9E4
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Apr 2025 07:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEC8SIOh58d+DgYLc6pPF7l/XNmBDHVNI2MwC6hR7mDM6mNgw/DImxZ4Pdm3UUPXl72RJn7B7Q2aomsjtmjqwtibJsunqho85aF8wIwNX2BsjY5pA8u4PB+CYM0FE7FSCkk6+QDgkruuZXg8RKqreRFxwqOkytifKGXiliqCLavpVD/4s0PvbG99OGFFm6U0Z9nFr7ws/14n+dttLCkM4wyBx7/kDTKa+lbvtVkRgYqgwJYEknZVBcKqY8OT7F1/B+Igo0X/E9Zqm9aDHSnR7Wvw3T/m5usdXpvtdn6PJGXjaIxiKwlM7nQJa3qiH0yA7+SrQQS9mivHUSITda/r6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmRd/gSwIx6i9W/BxLn/XCyrC+CKPQWezYeWbjcLh3E=;
 b=p0SfwRfKNllJnVQRMTreKf7pbhAoxwf0l+iWU+kVBXSQ9EyVtTnEHKUz3IUazI2kD2gLCcv9aAbZFqon5kR2Ngs0C9HmpX6kjbqrXTXgqoosYfOP6oljWvW2QXWpguivEwHMadsGJ0t2t5I5YCTPUoFLGlXnrE2ZswGCK9dy00y8ByJxrvgKznsdRR/4Y9x7dplqb6vMDgUN1l3X5BZFCtG3cWmm1E/C22Lhxs/by2/PmXopZ2kCNivARu3PE5+z8GxQ+YoABu7xCDfs58cl88Tbp15ycL1fVyEj+JuBXVzgzx4HIDZPoSeHJniANpj1y6ULRuk/SM16fI0sYyDtuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmRd/gSwIx6i9W/BxLn/XCyrC+CKPQWezYeWbjcLh3E=;
 b=coykAmjmL/lWBL4Hh0z7DKw4FjyxqW5/dIO+sjGLRjLzh1XG+Mz6ivMyghcNrgpUZ6ZsKlNtyM2ZGR30rMcSH6CCgVbGOf/vHhy5SNhdEMfl4Np4nuPZR+xKAGM98ir8jxl22cgq2tpiQScaB+XOQ9sYQjiJ3/+s0JbGU1fsvSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 07:31:40 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8678.025; Sat, 26 Apr 2025
 07:31:40 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/userq: take the userq_mgr lock in enforce
 isolation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250425183428.162862-1-alexander.deucher@amd.com>
 <20250425183428.162862-2-alexander.deucher@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <28d6e7c4-8525-88ee-100c-14720ca1b823@amd.com>
Date: Sat, 26 Apr 2025 13:01:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20250425183428.162862-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MA1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::22) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 278d8761-5aa8-468f-d7cf-08dd8494629a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0tKcHlaV3J5VXI0T1BsUnpwTEs0cG0vQjJPa2UrcDhuWlQ2R2xJK1lscFBQ?=
 =?utf-8?B?OGZEbzhkNzgvbkdralJ4NEVzYTNkV3p0UjBPaXMxUjd2V3Fac1NQVlAyaW9o?=
 =?utf-8?B?SlFSYVBqQkxpM1FJcWlYYlFGWFEyalRDUEVaT0F5WVBucG5mclhtYjU0STAz?=
 =?utf-8?B?VC9zS09kMmI5VWFDd3BBYXhSTHltOTQ0eGtDMlJ4NENGNEJSb253VVR1MHhY?=
 =?utf-8?B?cnNZMXJvWnlMSVZpTElyQ1dSZTlSekVsTDJXWHFkYkxkVWtON3cyYXRmSk1H?=
 =?utf-8?B?RlZwMzB1QUZMbEVqZ3JDSHBIVmhkeDh1YnJSN1FBbHI5QzlZUkVobFkxdFUz?=
 =?utf-8?B?Z0Q2MDRYc01iYlRhSkNvNFB1VDY1VEpyNzFoaVk3MFhBSzZJOWRTN0R1WFZM?=
 =?utf-8?B?N09Hd1IyT3FJR05jM3NFMzJsc2MzRFdiaTZxdlhVdHd3UTNMUlZBTmNJQkFO?=
 =?utf-8?B?MkR6c1FIMzlsVW1md0YraXBoQXFQQUd4N1lUN2dpeGNKaU9RZ1IrQWhrQnVI?=
 =?utf-8?B?UE5DeUx1alpIQWhSNHNEMSswQjJZaUorQnZqaFlGMEZWWFd4WVptdnJuMEcw?=
 =?utf-8?B?VnMwR2swNjVyOEg0MzJEdHdxSUhCSXg0b0F6VUxqcFV4SHFNM1ROcUtCZzFl?=
 =?utf-8?B?NDQ2c0NuWU5mMXZIRnRRaFYvUUNlZHVKR1JXZnhGL21mVEt2WUpUODEzK2dt?=
 =?utf-8?B?MmJwOCtycTFsUENPd2JTOUVucTlzekVWbkgyU3J2Sjk2VXBTYlBaOEUvNjho?=
 =?utf-8?B?SmxaMEtjNk1xL01IZmp6TGUwNHNhZnI0N2RIU3RKNHdBS0xOOU1EeXFlc21n?=
 =?utf-8?B?OSt4emtUblQzVVgyQjZ5NXN3dGNiU2RhRnN3amVvOGRleURPYW9hbVBDMHVS?=
 =?utf-8?B?b053TXJLN1ZxNG82UkREbW5IWGtHTlphUGVGZFpuUGlpdGJHeWdVSy9CTFha?=
 =?utf-8?B?b0JQTXd1UnNXNGgrTHVpU2RocVN1b1VpN0swYmNZWmpSTCtDMlY3R2NTY3hJ?=
 =?utf-8?B?Y3lKQzdSMjBYTVM2YkJHbTR6LzJPVlJmZS9lTm5vR3pNVk9Pbmt6RFljdGhD?=
 =?utf-8?B?UmNSRmY0cXhqaElvNkovZi9iQVVBT29KdWQ3R2JUTG4xdWV3aFc3M1E0NVRL?=
 =?utf-8?B?YlhFYzBEalRhb3R1ZmhsMXdtVDJyNy9CRG1mdVArdVc0M2JUS2ErTDFwOW1w?=
 =?utf-8?B?dzByaU4vakNEYUFvajVPKzZ6TjBSNk4rWEpVZkhHaFhHb1RmUThFYjJ5T0hK?=
 =?utf-8?B?U1NPUFpqOTE0cDhTb2FnWENmRkc2a1VoRDJHWWZWSkhtL1FTdVhWVXJQYU5M?=
 =?utf-8?B?YW9WY0FtTjdZRTZNNFBZMVFjQjIwajdPektqT1pTSE1uYWlZc2Y4WXpLMzlj?=
 =?utf-8?B?K2l5TDBpNGxuNEJOUEM5ZWRJVVZvcGtiSXdpTTc4WlE5L2lScitKODlCdzIx?=
 =?utf-8?B?S2FhTlE2cEtKZDlsc3BsWnhiVE12WWVjR1NtT0NnN1UyOFJCeEQzUzJCdVZi?=
 =?utf-8?B?NVh3QnlKY1U3NUt1NlZHVktxL3lBdmZheEJ4cXJBb3A4WG5yQVBad2c1SzBR?=
 =?utf-8?B?ME5JR0tCQjhITUpBdmZOZHdNczBVdFNwVGcwOStITytPb0RvRzhvWWZ0WEd3?=
 =?utf-8?B?cGQ2eEl4d29FQWM5OGU3RlhWb3VzL3dwTDlpa3BzZzhBUFpZZGJ5QjJsczRB?=
 =?utf-8?B?RU9Sb1locTFneVF5eUUvL2JBTGVwK1h0NEZldGtERjEyKzUxVkhFQ25FVXpD?=
 =?utf-8?B?MjBjRUJXQW0rZGxWTHNBN2JrOFBRVnVFMW5mS09aRzFnVzkySk5tWDRJejJO?=
 =?utf-8?B?Vys5bDB4cmhzdzB6cmNnM0tFdGh4U3ZuejBSMFB1bEtoY05hVG5XblhmODQy?=
 =?utf-8?B?OUNZOUZkMXdNLzVzaW9xMHMrdmxyOU02dEJ4U0hxNndiRFBwTnY1T0hraldS?=
 =?utf-8?Q?Fp6/9ZZHbhA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWdYMmdNNFNpeEpPYk03b25lTkRqQXl2bDhhNmRsMkxxRVRGd0s1T0lCNTBX?=
 =?utf-8?B?Q0RKVCs3N1EwRXYzT3M4aGRodjJtYmoxZjJXWkhJakU1cnRJdjM1RFpzL0tV?=
 =?utf-8?B?Qmx3Mnc4ZHRzaWdRRUZQdWZ2ODFSTTVrZ1N5QS9XVVN6Qk1KU3IycTVKUWtE?=
 =?utf-8?B?d0JBOXoxcUhmNHNZbXdtb1J6bzdscXVLNmlFb3NVTXk5WEZIZ004NERyY3ox?=
 =?utf-8?B?M0lEQ2VISmpRbUpzR3ZpdnBuTDZiVytJWnd0cyt4SEpmWnRKOW96ckJxeXNx?=
 =?utf-8?B?UXgvTTUzWGhETjRpVk1kbnM1bFo5UFc1VUt0MVY4S1hvcnJyaUk4RXVXaC9I?=
 =?utf-8?B?alJFVnFvMEl3RTgwckF2cTRDWm1FMGI2dzg5eDZnZDcwQkJxUVFlM01yVldX?=
 =?utf-8?B?ZkFNYjJEZ1NCRS9FT2V3S2FnNmNrQzgvV1hqRjJ3b205cXFEcEt6azhaNW9y?=
 =?utf-8?B?dUltbFVMWHQwYVgxdFhyZ3FiQ1QrN1NJQTBoUXdRMnZBNkdFdFNCUXJubWxo?=
 =?utf-8?B?UU5LWDlMU2hlR2pvRVBHYlB6UmUyU0llTmlyeHNHd0taM20ydVR1RG5YdGZx?=
 =?utf-8?B?UVYwdVZCSVZEOWdVMTJDT1ROQkRYS2RuZWpaVlNmc0gvdFlLbjJjNmJZbUZx?=
 =?utf-8?B?SFlBUXZGMTIwak4rVXVPMGwwWGFiY2V2emxRQ1pWemU3WktFMmRENVlBd2VK?=
 =?utf-8?B?WkZmTXdTZDZuNVhvUDJhRmJIYUdPUFVqTTZuMjBEL0NtcDloZHZMdXFJMXRu?=
 =?utf-8?B?V041cXAvT1MwbXlzS1dNaUROZ3poSzdpa1B0ZXZGZENLb1pjWjZTZlBoQTgx?=
 =?utf-8?B?emY5RnRDQ2FzNndyS0hpVVgvS0Y5VTlvQXRDbTZCdTcxc0wrQWRRaTkrRzZI?=
 =?utf-8?B?TWgxZGNiSS83cHNldVU1MzlvS0ZhMFRTeU1uNmVqZUNqdVhCc3VneHgrckxv?=
 =?utf-8?B?OUlkVnBQMGhPbVd2NjR4MFdwY0JBQ2U4ekVrdzBUKzNhMVQyNWFXSVFQYjlG?=
 =?utf-8?B?S2lGdVp4VjJ0d2w1dkNGWkFuWWtYS0J2Z3JjMHpCclJUbmpUTVJNRC85aXd6?=
 =?utf-8?B?UjFzR0UyWFUrSk81allaUFdPa1JSV3ZCditFSUpoYjljRHFEbzJXenVsWVZO?=
 =?utf-8?B?TFJFdXluVllaZURTRGt2NGhDSklWQW94bk9YTVVueTdoWVRHNzJOMmNCUVZK?=
 =?utf-8?B?ZnNkQlg3N2U3ckxOeTBqaDNndFZETmlmOXExYkJWK0hFcVNHeDhYNVdscjlQ?=
 =?utf-8?B?SWVHY25ITXdVTVk0ekQzTFJlc0M0YkUyNGZkOUxlWlc3ZlJ1Mzd2WEV3WnY5?=
 =?utf-8?B?REd3Y3JPbExhQmNvUWZZMDJnRTJGOGZ2c25SUVJ2SWs0SHB0a2t2NXhQZE5X?=
 =?utf-8?B?RFRGVmhPUHhHNWg0REVwc014aWtqc3AxZTlEWWFGVERWVk02b1NGeGM4VUp2?=
 =?utf-8?B?VHpkOHM4aHB0SlhTMG9pc0VQU1UrWEFXOHFCT1RNQ1BaVkNMZUozWVVnU2k3?=
 =?utf-8?B?U2lQQTFjekZOc1VkVFdIK0gxZkNEQlF1ZGpDazBudHl0aHYyL1BsOS9JVXZR?=
 =?utf-8?B?SHdKWDM0RXFnbzFYNnBjbnZTSldxSDdWVlhJOGR5SVVjTytlZ1NJMTRsRjli?=
 =?utf-8?B?U2d2STB3NU1FeHlCR0srcFl4UCtwcDhVL0VMcFluK3BEWTUrNDREeVFsQlZl?=
 =?utf-8?B?cENHZ2hrdjVvODdGOUhkRThSYWREQWp0Z2V1SlVLZitpNUlLZmJ5UnpWNWxR?=
 =?utf-8?B?d3ZxVUJ1VGpGZkx5Znl2cjZveTFQKzZJaFBaaEM2MTBSUm1nQjhUK2lnRHV5?=
 =?utf-8?B?ejVOQ0pXTW83RW1kNjlqSVc3UW9iMkRzL3V3ZVBTUU4wY2ZLejBNcFZyR3BJ?=
 =?utf-8?B?bXV5WGhFSGdzemRtc25uVmdqeS9KaG01ZjkvNnJndXVDS21kYVdvRk0vOHdB?=
 =?utf-8?B?cGVmMUdJT2xDRUN6TGNwMGF0d09JRDFkU0dzMlpWUDRBK2t2MmVpUGNIODgw?=
 =?utf-8?B?alNURi9McXJtOGlQTEdYMUhXcm1UcU80WFBWRGZud3FNNlY2cnVQRUdEUTZr?=
 =?utf-8?B?K0tQay8yOUZOVExsM3BpWklpT0hHVG4vVFlyeGYzL2NHSDJrZ0VGU05kSXdP?=
 =?utf-8?Q?4VvuTkOOqUJABTuZWEvSN8xli?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278d8761-5aa8-468f-d7cf-08dd8494629a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 07:31:40.3591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6x5bZdaibGKaJj2BmdLjd5JxvnMV/WDpheRSWDuMaq00zwBIedIDTuD6IM/c6WTvmPk3uVA3EBjhiBnPj7Syg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
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

Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>

On 4/26/2025 12:04 AM, Alex Deucher wrote:
> Add the missing locking.
>
> Fixes: 94976e7e5ede ("drm/amdgpu/userq: add helpers to start/stop scheduling")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 1fa9d2be87f39..afbe01149ed3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -865,6 +865,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>   	adev->userq_halt_for_enforce_isolation = true;
>   	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>   		cancel_delayed_work_sync(&uqm->resume_work);
> +		mutex_lock(&uqm->userq_mutex);
>   		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>   			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>   			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> @@ -874,6 +875,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>   					ret = r;
>   			}
>   		}
> +		mutex_unlock(&uqm->userq_mutex);
>   	}
>   	mutex_unlock(&adev->userq_mutex);
>   	return ret;
> @@ -897,6 +899,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>   		dev_warn(adev->dev, "userq scheduling already started!\n");
>   	adev->userq_halt_for_enforce_isolation = false;
>   	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		mutex_lock(&uqm->userq_mutex);
>   		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>   			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>   			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> @@ -906,6 +909,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>   					ret = r;
>   			}
>   		}
> +		mutex_unlock(&uqm->userq_mutex);
>   	}
>   	mutex_unlock(&adev->userq_mutex);
>   	return ret;
